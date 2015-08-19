#!/bin/bash
#
# John Hubbard
# SystemVerilog OOP Testbench Final Project (UCSC 18966)
# 18 Aug 2015
#
# This runs all of the testcases, and then looks through the
# logs to see if there are any passes or failures. It reports
# the results to stdout.

echo "Running all testcases..."

./run-all-tests.sh

echo "Looking for passes and failures..."
passes=`find .. -name vlog.log | xargs grep PASS | wc -l`
failures=`find .. -name vlog.log | xargs grep FAIL | wc -l`

echo "PASSES:   $passes"
echo "FAILURES: $failures"

if [ $failures != "0" ];then
    echo "Failed tests reports (please see testcase vlog.log files for details:"
    find .. -name vlog.log | xargs grep FAIL
else
    echo "SUCCESS: no failures, all tests PASSED, congratulations!"
fi
