// File: coconuts_tb.v
// John Hubbard, 26 Oct 2014
// hw6 assignment for Verilog 0764 class: Problem 6.8.7. Coconut and Monkey Puzzle
//

`timescale 1ns/1ns
module coconuts_tb;
    integer coconuts_tb;
    wire integer m1_tb, m2_tb, m3_tb, m4_tb, m5_tb, s_tb, monkey_tb;
    wire valid_tb;

    coconut_allocator DUT(coconuts_tb, m1_tb, m2_tb, m3_tb, m4_tb, m5_tb, s_tb,
                          monkey_tb, valid_tb);

    // This block prints whenever the inputs or outputs change:
    always @(*)
    begin
        if (valid_tb)
            $display(
                "Num coconuts to start with: %d\n", coconuts_tb
            );
    end

    // Test pattern:
    initial
    begin
        for (coconuts_tb = 0; coconuts_tb < 10000; coconuts_tb++)
        begin
            #10;
        end
    end
endmodule

/* Sample test run:

Problem 6.8.7. Coconut and Monkey Puzzle

Five sailors survive a shipwreck and swim to a tiny island where there is
nothing but a coconut tree and a monkey. The sailors gather all the coconuts
and put them in a big pile under the tree. Exhausted, they agree to go to wait
until the next morning to divide up the coconuts.

At one o’clock in the morning, the first sailor wakes. He realizes that he can’t
trust the others, and decides to take his share now. He divides the coconuts into
five equal piles, but there is one left over. He gives that coconut to the monkey,
buries his coconuts, and puts the rest of the coconuts back under the tree.

At two o’clock, the second sailor wakes up. Not realizing that the first sailor
has already taken his share, he too divides the coconuts up into five piles, leaving
one over which he gives to the monkey. He then hides his share, and piles the
remainder back under the tree.

At three, four and five o’clock in the morning, the third, fourth and fifth
sailors each wake up and carry out the same actions.

In the morning, all the sailors wake up, and try to look innocent. No one
makes a remark about the diminished pile of coconuts, and no one decides to
be honest and admit that they’ve already taken their share. Instead, they divide
the pile up into five piles, for the sixth time, and find that there is yet again one
coconut left over, which they give to the monkey.

How many coconuts were there originally?

Write a Verilog module and a test bench that displays: How many coconuts
were in the original pile?

Your test bench should output something like this:

# Num coconut to start with = X
# Num coconut after man 1 stole + 1 to monkey = Y
# Num coconut after man 2 stole + 1 to monkey = Z
# Num coconut after man 3 stole + 1 to monkey = P
# Num coconut after man 4 stole + 1 to monkey = Q
# Num coconut after man 5 stole + 1 to monkey = R
# Num coconut in the morning when 5 men gotup = S
# Man 1 got = M1
# Man 2 got = M2
# Man 3 got = M3
# Man 4 got = M4
# Man 5 got = M5
# Monkey got = 6
# Total = M should be equal to X
*/
