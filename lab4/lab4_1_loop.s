.include "macro_print_str.s"
.data
.text
main:
    addi $s0,$zero,9 # constant 9
    addi $t0,$zero,1 # i
    addi $t1,$zero,1 # j

loopi:
    addi $t1,$zero,1
    ble $t0,$s0,calculate
    j exit
loopii:
    addi $t1,$t1,1
    ble $t1,$t0,calculate
    print_string("\n")
    addi $t0,$t0,1
    j loopi
calculate:
    multu $t0,$t1
    mflo $t2
    
    la $a0,($t1)
    li $v0,1
    syscall

    print_string(" * ")

    la $a0,($t0)
    li $v0,1
    syscall

    print_string(" = ")

    la $a0,($t2)
    li $v0,1
    syscall
    
    print_string(" ")
    j loopii
exit:
    end    
