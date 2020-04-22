#!/usr/bin/env python2

import re
import os
import sys

try:
    petscdir = os.environ['PETSC_DIR']
    petscarch = os.environ['PETSC_ARCH']
except Exception as e:
    print("Set the PETSC_DIR and PETSC_ARCH environment variables first!")
    sys.exit(1)

file = "%s/%s/lib/petsc/conf/petscvariables" % (petscdir, petscarch)

remove = ['C:msys64mingw64lib', ' -LC:\\msys64\\mingw64\\lib']


try:
    f = open(file, "r")
    lines = f.readlines()
    f.close()
except Exception as e:
    print("Reading the PETSc variables file '%s' failed!" % file)
    sys.exit(1)


def remove_all(text, items):
    for i in items:
        text = text.replace(i, '')
    return text

newlines = [remove_all(l,remove) for l in lines]


try:
    f = open(file, "w")
    f.writelines(newlines)
    f.close()
except Exception as e:
    print("Writing the PETSc variables file '%s' failed!" % file)
    sys.exit(1)


print("Success!")
