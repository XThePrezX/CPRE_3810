    .data
    .text
    .globl main

main:
    lui  x2, 0x10010 #x2 = 0x10010000 (memory base?)
    addi x2, x2, 256 #x2 = 0x10010100 (stack start)
    addi x5, x0, 1
    addi x6, x0, 2
    addi x7, x0, 3
    jal  x1, func1
    jal x1, end #48

func1:
    addi x2, x2, -16
    sw x1, 12(x2) #save address
    beq x5, x5, func1_beq #will always branch: x5 = x5
    addi x5, x5, 99
    
func1_beq:
    bne x5, x6, func1_bne #here 
    addi x6, x6, 99
    
func1_bne:
    jal x1, func2
    lw x1, 12(x2) #address of the next instruction
    addi x2, x2, 16 #46
    jalr ra, 0(x1)

func2:
    addi x2, x2, -16
    sw x1, 12(x2)
    addi x8, x0, 4
    addi x9, x0, 4 #16
    blt x5, x8, func2_blt
    addi x5, x5, 99
    
func2_blt:
    bge x9, x8, func2_bge
    addi x9, x9, 99
    
func2_bge:
    jal x1, func3
    lw x1, 12(x2)
    addi x2, x2, 16
    jalr ra, 0(x1)

func3:
    addi x2, x2, -16 #20
    sw x1, 12(x2)
    bltu x5, x8, func3_bltu
    addi x5, x5, 99
    
func3_bltu:
    bgeu x9, x8, func3_bgeu
    addi x9, x9, 99
    
func3_bgeu:
    jal x1, func4
    lw x1, 12(x2)
    addi x2, x2, 16 #40
    jalr ra, 0(x1)

func4:
    addi x2, x2, -16 #25
    sw x1, 12(x2)
    auipc x10, 0 #27
    jal x1, func5
    lw x1, 12(x2)
    addi x2, x2, 16 #37
    jalr ra, 0(x1)

func5:
    addi x2, x2, -16 #29
    sw x1, 12(x2)
    addi x11, x0, 0
    lw x1, 12(x2)
    addi x2, x2, 16 #33
    jalr ra, 0(x1) 

end:
    wfi #apparently not instruction 49 but who cares it works
