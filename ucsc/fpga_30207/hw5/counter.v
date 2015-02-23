//Copyright: Jagadeesh Vasudevamurthy
2 //File seg7.v display_at_n_second.v
3
4 module mod_counter(clk, arst, q, done) ;
5 parameter N = 7 ;
6 parameter MAX = 127 ;
7 input clk,arst;
8 output [N-1:0] q ;
9 output done ;
10
11 reg [N-1:0] q ;
12 reg done ;
13
14 always @(posedge clk or posedge arst)
15 begin
16 if (arst == 1'b1)
17 begin
18 q <= 0 ;
19 done <= 0 ;
20 end
21 else if (q == MAX)
22 begin
23 q <= 0 ;
24 done <= 1 ;
25 end
26 else
27 begin
28 q <= q + 1 ;
29 done <= 0 ;
30 end
31 end
32 endmodule
33
34 module display_at_n_second(clk, arst, seg, an, text, done) ;
35 parameter NUM_SEC = 1 ;
36 parameter C = 35; //27 for 1 sec
37 parameter N = 7 ;
38 parameter W = 4 ;
39 parameter CRYSTAL = 100 ; // 100 MHZ
40 parameter [C-1:0] STOPAT = (CRYSTAL * 1_000_000 * NUM_SEC)- 1 ;
41
42 input clk, arst ;
43 input [15:0] text ;
44 output [0:N-1] seg ;
