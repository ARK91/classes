
package alu_package;

typedef enum logic [2:0]
{
    RST = 0,
    MOV = 1,
    NOT = 2,
    ADD = 3,
    AND = 4,
    XOR = 5,
    LSH = 6,
    RSH = 7
} myopcode_t;

endpackage
