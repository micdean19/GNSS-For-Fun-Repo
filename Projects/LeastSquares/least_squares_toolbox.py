import numpy as np
import pandas as pd


def calc_dist(x1,x2):
    if len(x1) == len(x2):
        return np.linalg.norm(x1-x2)
    else:
        return 0


def build_A_mat(l_vector, poe, control_points):
    '''
    Assumption: Number of rows in observation should match the number of rows in control points)
    This is because there's 4 observation and 4 anchor points( 1 observation per anchor point)
    
    :param l_vector: Observation
    :param poe: X Initial estimate or best estimate (if epoch != 1)
    :param control_points: Anchor Coordinates
    :return:
    '''
    x_rows = len(l_vector)
    n_cols = len(poe)
    A_mat = np.zeros([x_rows,n_cols])
    
    for i,obs in enumerate(l_vector):
        Arow_i = [(poe[0]-control_points[i][0])/calc_dist(poe,control_points[i]),
                  (poe[1]-control_points[i][1])/calc_dist(poe,control_points[i])]
        
        A_mat[i] = Arow_i
    
    return A_mat
    

def build_w_vector(l_vector, poe, control_points):
    w = np.zeros([len(l_vector)])
    for i, obs_i in enumerate(l_vector):
        w_i = calc_dist(poe, control_points[i])- obs_i
        w[i] = w_i
    return w
    

def build_delta(A_mat, w_vector, weight_matrix):
    N = np.matmul(np.matmul(A_mat.transpose(), weight_matrix), A_mat)
    u = np.matmul(np.matmul(A_mat.transpose(), weight_matrix), w_vector)
    return -1* np.matmul(np.linalg.inv(N),u)


def load_data_manually(filename):
    import csv
    
    # Creates an object/pointer to filetext in memory
    file = open(filename)
    
    # Creating the Object of csv.
    csvreader = csv.reader(file)
    
    time_list = []
    meas1_list = []
    meas2_list = []
    meas3_list = []
    meas4_list = []
    
    for row in csvreader:
        time_list.append(float(row[0]))
        meas1_list.append(float((row[1])))
        meas2_list.append(float(row[2]))
        meas3_list.append(float(row[3]))
        meas4_list.append(float(row[4]))
    
    data = {'Time': time_list,
            'range1': meas1_list,
            'range2': meas1_list,
            'range3': meas1_list,
            'range4': meas1_list, }
    
    return data


def load_data_pandas(filename):
    import pandas as pd
    data = pd.read_csv(filepath_or_buffer = filename, names = ['Time', 'Range1', 'Range2', 'Range3', 'Range4'])
    return data
