.include "macro_print_str.s"
.data
.text
main:
    addi $s0,$zero,9 # parameter
    addi $s1,$zero,1 # flag
    addi $s2,$zero,1 # j
    addi $s3,$zero,9
    j multiplication
    end

multiplication:
    bgt $s0,1,recursive
    print_string("1 * 1 = 1\n")
    j $ra
    
recursive:
    addi $sp,$sp,-8
    sw $ra,4($sp)
    sw $s0,0($sp)

    addi $s0,$s0,-1
    jal multiplication

    sw 
    addi $sp,$sp,8
    jr $ra
L1:
    addi $s0,$s0,-1
    jal recursive

calculate:
    multu $s2,$s0
    mflo $t1

    la $a0,($s2)
    li $v0,1
    syscall

    print_string(" * ")

    la $a0,($s0)
    li $v0,1
    syscall

    print_string(" = ")

    la $a0,($t1)
    li $v0,1
    syscall
    
    print_string(" ")

    addi $s2,$s2,1
    ble $s2,$s0,calculate
    addi $s2,$zero,1
    print_string("\n")



