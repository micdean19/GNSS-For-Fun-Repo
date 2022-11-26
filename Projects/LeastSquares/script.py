"""
LSA Exercise #1
BY Andreas B and Michael A
Date: 30th October 2022
"""
from Projects.LeastSquares.least_squares_toolbox import *


def main():
    filename = "Lab2data.txt"
    data = load_data_pandas(filename)

    # Defining Constants (To change Based on need)
    poe = np.array([50, 50])
    xhat = poe
    control_points = np.array([[0, 0], [100, 0], [100, 100], [0, 100]])

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
        
    print("running from main")
 

if __name__ == "__main__":
    main()