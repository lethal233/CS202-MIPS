.include "../macro_print_str.s"
.data
.text
main:
	print_string("This program uses recursion.")
	print_string("Input a positive integer: ")
	li $v0,5
	syscall
	li $s0,10
	li $s1,0
	move $a0,$v0
	jal recursion
	print_string("The inverse is: ")
	la $a0,($s1)
	li $v0,1
	syscall
	end
	
recursion:
	addi $sp,$sp,-8
	sw $ra,4($sp)
	sw $a0,0($sp)
	
	beq $a0,$zero,return
	div $a0,$s0
	mflo $t1 #quotient
	mfhi $t2 #remainder
	
	mult $s1,$s0 # multiply by 10
	mflo $s1
	
	add $s1,$s1,$t2 # get the result
	
	move $a0,$t1
	jal recursion
	
return:
	lw $a0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
