// task to help counter testing

task automatic init
    (output logic reset,
    output logic enable,
    output logic preload,
    output logic mode);

    $display("init() task running");

    reset = 1;
    enable = 0;
    preload = 0;
    mode = 0;

endtask

