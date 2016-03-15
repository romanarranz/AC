#!/usr/bin/python
# -*- coding: utf-8 -*-

# real   44m36.507s
# user    44m13.458s
# sys 0m2.000s

from optparse import OptionParser
parser = OptionParser()
parser.add_option("-i", dest="filename", default="2000.in",
     help="input file with two matrices", metavar="FILE")
(options, args) = parser.parse_args()

def read(filename):
    lines = open(filename, 'r').read().splitlines()
    A = []
    B = []
    matrix = A
    for line in lines:
        if line != "":
            matrix.append(map(int, line.split("\t")))
        else:
            matrix = B
    return A, B

def printMatrix(matrix):
    for line in matrix:
        print "\t".join(map(str,line))

def ikjMatrixProduct(A, B):
    n = len(A)
    C = [[0 for i in xrange(n)] for j in xrange(n)]
    for i in xrange(n):
        for k in xrange(n):
            for j in xrange(n):
                C[i][j] += A[i][k] * B[k][j]
    return C

A, B = read(options.filename)
C = ikjMatrixProduct(A, B)
printMatrix(C)