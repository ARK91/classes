// 4 bit adder program generator
// For UCSC Class 30207: Digital Design with FPGA
// John F. Hubbard, 18 Jan 2015
//

#define BIT_LENGTH_A     4
#define BIT_LENGTH_B     4
#define BIT_LENGTH_SUM   5

#include <stdio.h>

void print_binary(int x, int bit_length)
{
    int index;

    for (index = bit_length - 1; index >=0; index--)
    {
        if (x & (1 << index))
            printf("1");
        else
            printf("0");
    }
}

int main(int argc, char * argv[])
{
    int a;
    int b;
    int sum;

    printf(" a    b   | sum\n");
    printf("---------------------------\n");

    for (a = 0; a < 16; a++)
    {
        for (b = 0; b < 16; b++)
        {
            sum = a + b;
            print_binary(a, BIT_LENGTH_A);
            printf(" ");
            print_binary(b, BIT_LENGTH_B);
            printf(" | ");
            print_binary(sum, BIT_LENGTH_SUM);
            printf(" (%d)", sum);
            printf("\n");
        }
    }

    return 0;
}
