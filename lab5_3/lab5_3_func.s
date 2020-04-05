.data
bl: .byte ' '
.text
.globl print_array
print_array:
	addi $sp,$sp,-12
	sw $s0,8($sp)
	sw $a0,4($sp) # a0 is the base address of the array
	sw $a1,0($sp) # a1 is the size of the array

	move $s1,$a0
	move $t7,$zero
loop_print:
	lw $a0,($s1)
	li $v0,1
	syscall 
	
	lb $a0,bl
	li $v0,11
	syscall
	
	addi $s1,$s1,4
	addi $t7,$t7,1
	bne $t7,$a1,loop_print
	
	
	lw $a1,0($sp)
	lw $a0,4($sp)
	lw $s0,8($sp)
	addi $sp,$sp,12
	jr $ra
	
	
