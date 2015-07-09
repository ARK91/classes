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
import re
import subprocess
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

def extract_scores(log):
    info = { "fail_count":0, "pass_count":0, "no_report_count":0, "score":0.0 }
    output = ""
    for line in log.splitlines():
        if line.strip().startswith("TEST_RESULT: PASS"):
            info["pass_count"] += 1
        elif line.strip().startswith("TEST_RESULT: FAIL"):
            info["fail_count"] += 1
        else:
            info["no_report_count"] += 1
    return info, output

def print_final_scores(info):
    score = 0.0
    total = (info["pass_count"] + info["fail_count"] + info["no_report_count"])
    if total == 0:
        return result
    score = (float(info["pass_count"]) / float(total)) * 100.0
    print("Test result summary:")
    print("Passes   : " + str(info["pass_count"]))
    print("Failures : " + str(info["fail_count"]))
    print("Score:     %.2f percent passed" % score)

def run_all_tests():
    print("Running ALL testcases\n")

def run_one_test(testname):
    print("Running testcase: %s" % testname)

    old_path = os.getcwd()
    os.chdir("../scenarios/%s" % testname)
    process = subprocess.Popen("./runsim", stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE, shell=True)

    stdout, stderr = process.communicate()
    if not (type(stdout) is str):
        # Required for earlier versions of Python:
        if (type(stdout) is bytes):
            stdout = stdout.decode("utf-8")
            stderr = stderr.decode("utf-8")


    info, stdout = extract_scores(stdout)
    for line in stdout.splitlines():
        print (line)
    for line in stderr.splitlines():
        print (line)

    print_final_scores(info)
    os.chdir(old_path)

def run_commands():
    if opt.run_all_tests != None:
        run_all_tests()
    elif opt.testcase_name != None:
        run_one_test(opt.testcase_name)
    else:
        print("Please run this program with -h or --help for usage information\n")
        exit(1)


if opt.verbose:
    debug_print_args()

run_commands()

