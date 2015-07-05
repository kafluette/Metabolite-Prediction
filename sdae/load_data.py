import pandas
import os
from operator import mul
from functools import partial


def _data(f):
    # return '../${f}' basically
    return os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', f))


def load_data():
    # load positive data and resize to add label
    pos_train = pandas.read_csv(_data('Tyrosine/positive_train.csv'), header=True)
    neg_train = pandas.read_csv(_data('Tyrosine/negative_train.csv'), header=True)

    # count rows and dims
    n_pos, d = pos_train.shape
    n_neg = neg_train.shape[0]
    n = n_pos + n_neg

    # merge positive/negative data
    all_data = pos_train.append(neg_train)

    # partition train, test, validate sets
    train_frac, test_frac, valid_frac = 0.7, 0.2, 0.1
    train_offset, test_offset, valid_offset = map(int, map(partial(mul, n), (train_frac, test_frac, valid_frac)))
    train_set, test_set, valid_set = all_data[0:train_offset, :], \
                                     all_data[train_offset+1:train_offset+1+test_offset, :], \
                                     all_data[train_offset+1+test_offset+1:train_offset+1+test_offset+1+valid_offset, :]

    # add labels, carefully ...

    return train_set, valid_set, test_set


def test_load_data():
    data = load_data()
    print "brk"


if __name__ == '__main__':
    test_load_data()
