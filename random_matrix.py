#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Generate and print float matrix of specified dimensions
# (first two arguments). The elements are separated by '\t'.
#
# Example usage:
#   ./random_matrix.py 4 5

import sys
from random import uniform as uni


for _ in range(0, int(sys.argv[1])):
    sys.stdout.write(
        '\t'.join([str(uni(0, 99)) for x in range(0, int(sys.argv[2]))]) + '\n'
    )
