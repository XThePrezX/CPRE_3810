    .data
    .text
    .globl main
    
    
main: #NOTE: branch is taken each time
    addi x5, x0, 5
    addi x6, x0, 3

    add x7, x5, x6
    sub x28, x5, x6
    and x29, x5, x6
    andi x30, x5, 3
    or x31, x5, x6
    ori x8, x5, 1
    xor x9, x5, x6
    xori x10, x5, 7
    slt x11, x5, x6
    slti x12, x5, 10
    sltiu x31, x5, 10
    sll x7, x7, x6

    srl x28, x7, x6
    sra x29, x7, x6
    slli x5, x5, 1
    srli x6, x6, 1
    srai x28, x28, 1
    lui x30, 0x00100
    addi x5, x0, 0
    lui x1, 0x10000	# Add 0x10000000 to x1
    addi x2, x0, 1	# Add 1 to x2

    sw x2, 0(x1)	# Store 1 with offset of 0 at x1 (0x10000000)
    lw x3, 0(x1)	# Load value at x1 (x2 = 1) into x3

    sw x3, 8(x1)	# Store x3 (1) with offset of 8 at x1 (0x10000008)
    addi x5, x0, 1
    addi x5, x0, 1

    beq x5, x5, branch_eq

   addi x5, x0, 5


branch_eq:
    addi x6, x0, 2

    bne x5, x6, branch_ne

    addi x7, x0, 2

branch_ne:
    addi x5, x0, 3

    blt x6, x5, branch_lt

    addi x7, x0, 3

branch_lt:
    addi x6, x0, 3

    bge x5, x6, branch_ge

    addi x7, x0, 4

branch_ge:
    addi x6, x0, 1

    bltu x6, x5, branch_ltu

    addi x7, x0, 5

branch_ltu:
    addi x6, x0, 3
    addi x5, x0, 5

    bgeu x5, x6, branch_geu

    addi x7, x0, 6

branch_geu:

    auipc x31, 0

    jal  x1, func
    
    addi x7, x0, 7
    addi x8, x0, 8
    addi x9, x1, 8

    jal  x1, func2


func:

    addi x9, x0, 1
    addi x7, x0, 7
    addi x8, x10, 8
    

    jalr x0, 0(x1)


func2:

    addi x9, x9, 1
    wfi
