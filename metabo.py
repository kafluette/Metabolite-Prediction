#!/usr/bin/env python3
from functools import partial
import numpy

m = 100  # we have 100 samples
p = 1000  # of 1000 dimensions each
X = numpy.random.normal((m,p))  # chosen randomly from N(0,1)

nbins = 75  # create this many bins
gamma = p / nbins  # which means each bin has a width of gamma=p/nbins

B = [0,1]  # the "binary" set {0,1}, representing "choice"

def Learner(multiplets, spectrum):
    """
    The learner for a given metabolite (represented by the multiplets vector)
    takes the p-vector spectrum and returns whether or not the metabolite is
    present in the spectrum."""
    bins = Bin(gamma, spectrum)  # generate p/gamma bins of width gamma
    present = []
    for i, multiplet in iter(multiplets):
        ps = map(partial(P, multiplet), bins)
        present[i] = C1(ps)
    return C2(present)

def P(multiplet, bin, error=0.005):
    """
    Determines whether or not the multiplet parameterized by the multiplet vector
    is present in the bin."""
    multiplet_graph = GenerateMultiplet(multiplet)
    is_present = Risk(multiplet_graph, bin) <= error
    return is_present

def Risk(g1, g2):
    """
    Returns the normalized error between the two graphs.
    At the moment, this implementation returns the sum of square error."""
    err = g1 - g2  # TODO: numpy elementwise subtraction
    sqerr = err ** 2 # TODO: numpy elementwise square
    sumsqerr = sqerr.magnitude()  # TODO: numpy vector magnitude
    return sumsqerr

def GenerateMultiplet(params):
    """
    Returns the multiplet represented by the parameters vector."""
    return []  # TODO: numpy vector

def C1(ps):
    """
    Combines the decision vector from the q possible multiplets into a single
    decision representing whether the metabolite is present."""
    frac = 0.8  # the fraction of multiplets that must be present to indicate metabolite is present
    return sum(ps) / (frac*len(ps))

def C2(ps):
    """
    Combines the decision vector from the p/gamma bins into a single decision
    representing whether the metabolite is present."""
    frac = 0.8  # the fraction of bins that must have the multiplet "present" to indicate the metabolite is present
    return sum(ps) / frac*len(ps)
