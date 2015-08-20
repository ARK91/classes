README.txt
By John Hubbard, 17 Aug 2015
UCSC 18966: SystemVerilog OOP Testbench: Class Project

In order to run tests, please follow these steps:

A. Running all tests:

    cd scripts
    ./run-all-tests.sh

    -- Note that the log files are vlog.log, and there
       will one such file in each testcase subdirectory,
       after running the above script.

B. Running just one test:

    cd testcases/loopback # for example
    ./runsim

C. Regression test, to automatically report whether
   or not all of the tests are passing:

   cd scripts
   ./regression-test.sh

D. In the doc subdirectory, you will find:

   -- A detailed description of the test plan, in
      Microsoft Word format.

   -- A sample test run of regression-test.sh, which
      shows the output of each testcase, plus the
      summary at the end, with an overall PASS/FAIL
      report.
