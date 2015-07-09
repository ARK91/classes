#!/usr/bin/env python
#
# regression-test.py
#
# This is for: UCSC 18966: SystemVerilog OOP Testbench
#
# John Hubbard, 08 July 2015
#
# This runs regression tests and produces a summary report. You can run one test
# at a time, by name (passing in the directory name, under scenarios/ or
# testcases/ . Or you can run all tests.
# ------------------------------------------------------------------------------

import os
from optparse import OptionParser

# --------------- Command-line options -----------------------------------------
p = OptionParser()
p.add_option('-t', '--testcase', type='string', dest='testcase_name',
          help='Run a test, by directory name. Example: counter_count2max_bug')

p.add_option('-a', '--all', action='store_true', dest='run_all_tests',
             help='Runs all tests')

p.add_option('-v', '--verbose', action='store_true', dest='verbose')

opt, args = p.parse_args()

def debug_print_args():
    print(opt)

home = os.environ["HOME"]

def run_commands():
    if opt.run_all_tests != None:
        print("Running ALL testcases\n")
    elif opt.testcase_name != None:
        print("Running testcase: %s" % opt.testcase_name)
    else:
        print("Please run this program with -h or --help for usage information\n")
        exit(1)


if opt.verbose:
    debug_print_args()

run_commands()

