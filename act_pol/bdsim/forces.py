r"""
Forces involved in BD simulations
---------------------------------

All Rouse polymer simulations involve spring forces between adjacent monomers (
`f_elas_linear_rouse`). Here, we also implement a spherical confinement and additional Hookean
springs that can couple distinct monomers. Combinations of confinement and spring
forces are also implemented in the same for loop to make code more efficient.
"""

from numba import njit
import numpy as np

@njit
def f_conf_ellipse(x0, Aex, rx, ry, rz):
    """Compute soft (cubic) force due to elliptical confinement."""
    N, _ = x0.shape
    f = np.zeros(x0.shape)
    for j in range(N):
        conf = x0[j, 0]**2/rx**2 + x0[j, 1]**2/ry**2 + x0[j, 2]**2/rz**2
        if conf > 1:
            conf_u = np.array([
                -x0[j, 0]/rx**2, -x0[j, 1]/ry**2, -x0[j, 2]/rz**2
            ])
            conf_u = conf_u/np.linalg.norm(conf_u)
            # Steph's confinement from
            # https://journals.aps.org/pre/abstract/10.1103/PhysRevE.82.011913
            f[j] += Aex*conf_u*np.power(np.sqrt(conf) - 1, 3)
    return f

@njit
def f_elas_linear_rouse(x0, k_over_xi):
    """Compute spring forces on single, linear rouse polymer."""
    N, _ = x0.shape
    f = np.zeros(x0.shape)
    for j in range(1, N):
        for n in range(3):
            f[j, n] += -k_over_xi*(x0[j, n] - x0[j-1, n])
            f[j-1, n] += -k_over_xi*(x0[j-1, n] - x0[j, n])
    return f

@njit
def f_elas_loops(x0, k_over_xi, relk, K, lamb=0):
    """Compute spring forces on single, linear rouse polymer with additional
    springs located at points in K matrix."""
    N, _ = x0.shape
    f = np.zeros(x0.shape)
    for j in range(1, N):
        f[j, :] += -lamb * x0[j, :]
        for n in range(3):
            f[j, n] += -k_over_xi*(x0[j, n] - x0[j-1, n])
            f[j-1, n] += -k_over_xi*(x0[j-1, n] - x0[j, n])
    # add additional springs at specific locations
    for k in range(len(K)):
        s1 = K[k][0]
        s2 = K[k][1]
        for n in range(3):
            f[s1, n] += -relk * k_over_xi*(x0[s1, n] - x0[s2, n])
            f[s2, n] += -relk * k_over_xi*(x0[s2, n] - x0[s1, n])
    return f

@njit
def f_conf_spring(x0, k_over_xi, Aex, rx, ry, rz):
    """ Compute forces due to springs and confinement
        all in the same for loop."""
    N, _ = x0.shape
    f = np.zeros(x0.shape)
    for i in range(N):
        # SPRING FORCES
        if i >= 1:
            for n in range(3):
                f[i, n] += -k_over_xi * (x0[i, n] - x0[i - 1, n])
                f[i - 1, n] += -k_over_xi * (x0[i - 1, n] - x0[i, n])
        # CONFINEMENT
        conf = x0[i, 0] ** 2 / rx ** 2 + x0[i, 1] ** 2 / ry ** 2 + x0[i, 2] ** 2 / rz ** 2
        if conf > 1:
            conf_u = np.array([
                -x0[i, 0] / rx ** 2, -x0[i, 1] / ry ** 2, -x0[i, 2] / rz ** 2
            ])
            conf_u = conf_u / np.linalg.norm(conf_u)
            f[i] += Aex * conf_u * np.power(np.sqrt(conf) - 1, 3)
    return f

@njit
def f_elas_flow(x0, k, xi, R, l, B, s1, s2, lamb, reciprocal=False):
    """Compute spring forces on single, linear rouse polymer with a condensate-mediated
    force acting on the enhancer (s1) pointing towards the promoter (s2)."""
    N, _ = x0.shape
    f = np.zeros(x0.shape)
    for j in range(1, N):
        f[j, :] += -lamb * x0[j, :]
        for n in range(3):
            f[j, n] += -k/xi[j]*(x0[j, n] - x0[j-1, n])
            f[j-1, n] += -k/xi[j]*(x0[j-1, n] - x0[j, n])
    # Enhancer-promoter (s1-s2) condensate force
    delta = x0[s1,:] - x0[s2,:]  # Displacement vector pointing from s2 to s1
    d = np.linalg.norm(delta)  # Magnitude of displacement
    # Velocity in the axis of flow
    v = -B*np.divide((np.exp(-(R+d)/l)*(l+R)*(l+d)-np.exp(-np.abs(R-d)/l)*(l**2-R*d+l*np.abs(R-d))),d**2)
    v_vector = np.divide(v * delta, d)  # Dimensionful velocity vector in cartesian coordinates
    v_vector = np.nan_to_num(v_vector)  # Probably nan because d == 0
    f[s1, :] += v_vector  # Force only acts on s1 (enhancer)
    if reciprocal:
        f[s2, :] -= v_vector
    # Here, force_vector / xi[s1] = xi[s1] * velocity_vector / xi[s1] = velocity_vector
    return f