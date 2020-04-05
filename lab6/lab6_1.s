.include "macro_print_str.s"
.data
addflag: .byte '+'
subflag: .byte '-'
mulflag: .byte '*'
divflag: .byte '/'

.text
main:
	print_string("First input the two operands, and next operator(+,-,*,/) to do the calculation.\n")
	lb $s1,addflag # load +
	lb $s2,subflag # load -
	lb $s3,mulflag # load *
	lb $s4,divflag # load /
	
	print_string("Input the first operand: ")
	li $v0,5
	syscall
	tlti $v0,0
	move $s5,$v0 # s5 store the first number
	
	print_string("Input the second operand: ")
	li $v0,5
	syscall
	tlti $v0,0
	move $s6,$v0 # s6 store the second number
	
	print_string("Input the operator: ")
	li $v0,12
	syscall
	move $a2,$v0 # a2 store the operator
	move $a0,$s5 # a0 store the first number
	move $a1,$s6 # a1 store the second number
	jal calculator # call the function calculator
	end 
	
calculator:# the function calculator
	addi $sp,$sp,-16
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	sw $ra,12($sp)
	
	move $s0,$a2 # move the operand to s0
	move $s5,$a0 # move the first operand to s5
	move $s6,$a1 # move the second operand to s6
	
	beq $s0,$s1,addition # go to addition part 
	beq $s0,$s2,subtraction # go to subtraction part
	beq $s0,$s3,multiplication # go to multiplication part
	tne $s0,$s4 # if s0!='/', then go to exception handler
	j division
addition:
	add $s7,$s5,$s6 # s7 store the result of the sum
	j print_result
subtraction:
	sub $s7,$s5,$s6
	j print_result
multiplication:
	mult $s5,$s6
	mfhi $t1
	tnei $t1,0 # if hi != 0, then overflow,$t1 as a flag
	
	mflo $a0
	print_string("\nThe result is ")
	li $v0,36 # to print the result as unsigned number, because we can print the number 0x7FFFFFFF*2, within one word
	syscall
	
	# the end of the function
	lw $ra,12($sp)
	lw $a2,8($sp)
	lw $a1,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,16
	jr $ra
	
division:		
	div $s7,$s5,$s6
	j print_result
	
print_result: # print the result
	print_string("\nThe result is ")
	move $a0,$s7
	li $v0,1
	syscall 
	lw $ra,12($sp)
	lw $a2,8($sp)
	lw $a1,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,16
	jr $ra # go back to main
	
.ktext 0x80000180
	la $a0,prompt # print "\nruntime exception at "
	li $v0,4
	syscall
	
	mfc0 $a0,$14 # error location
	li $v0,34 # print as 0x
	syscall
	
	mfc0 $s7,$13 # move the cause to $s7
	beq $s7,0x00000030,over # if $s7 = 0x00000030, it means overflow
	beq $s7,0x00000024,zerror # if $s7 = 0x00000024, it means divide by zero
	beq $s7,0x00000020,ill # if $s7 = 0x00000020, it means illegal input on the operand
	bne $t1,$zero,over # to see whether it is overflow or illegal input on the operator
	j ill
over:# overflow
	la $a0,	overflow
	j print_error
ill:# illegal input 
	la $a0,illegal
	j print_error
zerror:# divide by zero
	la $a0,zero
	j print_error
print_error:#print the error message and quit the program
	li $v0,4
	syscall
	end
.kdata
illegal: .asciiz " illegeal input."
overflow: .asciiz " arithmetic overflow."
zero: .asciiz " divide by zero."
prompt: .ascii "\nRuntime exception at "

