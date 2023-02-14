import argparse
import json
from utils.training import train_circor
import numpy as np

epochs_default = 10
batch_size_default = 1
learning_rate_default = 1e-4

# Parse command line arguments
parser = argparse.ArgumentParser(description="Train the segmentation model passing the model hyperparameters through the command line")

# Add mandatory arguments, the model hyperparameters or the file driven hyperparameters
model_hyperparams_selection = parser.add_mutually_exclusive_group(required=True)

# Add the hyperparamters_file argument
model_hyperparams_selection.add_argument("--hyperparameters_file", nargs=2, help='Use file driven model hyperparameters', metavar=('file_path', 'id'), type=str)

# Create a group for the model hyperparameters
model_hyperparams_selection.add_argument("--hyperparameters", nargs=3, help='Use custom model hyperparameters. Input window size, number of filters in the first layer and number of encoder/decoder blocks.', metavar=('N', 'n0', 'nenc'), type=int)

# Add the training hyperparameters as optional arguments
parser.add_argument("--training_hyperparameters", nargs=3, help='Use custom training hyperparameters', metavar=('EPOCHS', 'BATCH_SIZE', 'LEARNING_RATE'), default=[epochs_default, batch_size_default, learning_rate_default])

parser.add_argument("--model_path", help='Path to store the trained model and training details')

args = parser.parse_args()

# Catch the training hyperparameters
epochs = int(args.training_hyperparameters[0])
batch_size = int(args.training_hyperparameters[1])
learning_rate = float(args.training_hyperparameters[2])

# Catch the model hyperparameters
if args.hyperparameters_file:
    # Open the file
    with open(args.hyperparameters_file[0], 'r') as f:
        # Load the hyperparameters
        hyperparameters_dict = json.load(f)[args.hyperparameters_file[1]]
        N = int(hyperparameters_dict['N'])
        n0 = int(hyperparameters_dict['n0'])
        nenc = int(hyperparameters_dict['nenc'])
else:
    N = int(args.hyperparameters[0])
    n0 = int(args.hyperparameters[1])
    nenc = int(args.hyperparameters[2])

# Load the data
X_train = np.load('N{}-data/train.npz'.format(N))['X']
S_train = np.load('N{}-data/train.npz'.format(N))['S']
X_val = np.load('N{}-data/valid.npz'.format(N))['X']
S_val = np.load('N{}-data/valid.npz'.format(N))['S']
X_test = np.load('N{}-data/test.npz'.format(N))['X']
S_test = np.load('N{}-data/test.npz'.format(N))['S']

# Load the test dict
with open('N{}-data/test_dict.json'.format(N), 'r') as f:
    test_dict = json.load(f)

tau = N//8

if args.model_path is None:
    model_path = 'models/N{}/n0{}/nenc{}/'.format(N, n0, nenc)
else:
    model_path = args.model_path

train_circor(X_train, S_train, X_val, S_val, X_test, S_test, test_dict, model_path, N, tau, n0, nenc, epochs, batch_size, learning_rate)
