#include <stdio.h>

int main(void)
{
    int day, row;
    int baseDay = 1;

    for (row = 0; row < 7; ++row)
    {
        for (day = baseDay; day < 38; day++)
        {
            if (day >=1 && day <= 31)
            {
                printf("%02x", day);
            }
            else
            {
                printf("00");
            }
        }

        baseDay--;
        printf("\n");
    }
    return 0;
}
