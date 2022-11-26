from Projects.LeastSquares.least_squares_toolbox import *

''' Only used for Prototyping and making sure the least squares works
It's the preamble before script.py'''

filename = "Lab2data.txt"
data = pd.read_csv(filepath_or_buffer = filename, names = ['Time', 'Range1', 'Range2', 'Range3', 'Range4'])
poe = np.array([50, 50])
xhat = poe
control_points = np.array([[0, 0], [100, 0], [100, 100], [0, 100]])

# A = build_A_mat(data.iloc[0, 1:5].transpose(), poe, control_points)
# w = build_w_vector(data.iloc[0, 1:5].transpose(), poe, control_points)
# delta = build_delta(A, w, weight)

# row_i = 0

results = np.zeros((data.shape[0], len(xhat)))

for row_i, time_t in enumerate(data.iloc[:, 0]):
    l = data.iloc[row_i, 1:5].transpose()
    weight = np.identity(4)
    convergence_criterion = 1
    threshold = 0.0000001
    iterations = 0
    
    while convergence_criterion > threshold:
        A = build_A_mat(l, xhat, control_points)
        w = build_w_vector(l, xhat, control_points)
        delta = build_delta(A, w, weight)
        xhat = xhat + delta
        # convergence_criterion = max(abs(delta))
        convergence_criterion = np.linalg.norm(delta)
        iterations += 1
        # print(convergence_criterion)
        # print(delta)
    results[row_i] = xhat.transpose()
    print(xhat.transpose())
    
    # N = np.matmul(np.matmul(A.transpose(), weight), A)
    # Cx = np.linalg.inv(N)
    # sigmax = np.sqrt(np.diag(Cx))












