.data
m: .byte '*'
eq: .byte '='
bl: .byte ' '
.text
.globl print_table
print_table:
	addi $sp,$sp,-8
	sw $a0,4($sp)
	sw $a1,0($sp)
	
	multu $a0,$a1
    	mflo $t0 # calculate the result
    	#addi $s6,$s6,1
	li $v0, 1
	syscall
	
	lb $a0,m
	li $v0,11
	syscall
	
	move $a0,$a1
	li $v0,1
	syscall
	
	lb $a0,eq
	li $v0,11
	syscall
	
	la $a0,($t0)
	li $v0,1
	syscall
	
	lb $a0,bl
	li $v0,11
	syscall
	
	lw $a1,0($sp)
	lw $a0,4($sp)
	addi $sp,$sp,8
	jr $ra
