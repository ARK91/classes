// 4 bit adder program generator
// For UCSC Class 30207: Digital Design with FPGA
// John F. Hubbard, 18 Jan 2015
//

#define BIT_LENGTH_A     4
#define BIT_LENGTH_B     4
#define BIT_LENGTH_SUM   5

#include <stdio.h>

void print_binary(int x, int bitLength)
{
    int index;

    for (index = bitLength - 1; index >=0; index--)
    {
        if (x & (1 << index))
            printf("1");
        else
            printf("0");
    }
}

void print_algebraic(const char * digitName, int x, int bitLength, int bit)
{
    int index;

    for (index = bitLength - 1; index >=0; index--)
    {
        if (index == bitLength - 1)
            printf("(");

        if (x & (1 << index))
            printf("%s[%d]", digitName, index);
        else
            printf("!%s[%d]", digitName, index);

        if (index == 0)
            printf(")");
        else
            printf("&");
    }
}

print_term(int a, int b, int sum, int bit)
{
    // if bit[n] of sum is set, print
    if (sum & (1 << bit))
    {
        print_algebraic("a", a, BIT_LENGTH_A, bit);
        printf(" & ");
        print_algebraic("b", b, BIT_LENGTH_B, bit);
        printf(" + ");
    }
}

int main(int argc, char * argv[])
{
    int a;
    int b;
    int sum;
    int bit;

    printf("// 4-bit counter truth table: structural verilog");
    printf("\n\n");

    for (bit = 0; bit <= 5; bit++)
    {
        printf("assign sum[%d] = ", bit);

        for (a = 0; a < 16; a++)
        {
            for (b = 0; b < 16; b++)
            {
                sum = a + b;
                print_term(a, b, sum, bit);
            }
            printf("\n");
        }

        printf("0;\n\n");
    }
    return 0;
}
