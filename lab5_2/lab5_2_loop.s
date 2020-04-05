.include "../macro_print_str.s"
.text
main:
	print_string("This program uses loop.")
	print_string("Input a positive integer: ")
	li $v0,5
	syscall
	
	li $s1,0
	li $s0,10 # load the base constant 10
	move $t0,$v0 # store the input to $t0
	#bne $s1,1,loop
loop:
	div $t0,$s0
	mflo $t1 #quotient
	mfhi $t2 #remainder
	
	mult $s1,$s0 # multiply by 10
	mflo $s1
	
	add $s1,$s1,$t2 # get the result
	
	move $t0,$t1
	bne $t0,$zero,loop # if quotient is 0, then quit the loop
	
	print_string("The inverse is: ")
	
	la $a0,($s1)
	li $v0,1
	syscall
	
	end
	
