.include "macro_print_str.s"
.data
	testdata: .word 0x1ac23344
.text
main:
	lw $s1,testdata 
	
	print_string("The original data is:  ")
	# print the original data
	la $a0,($s1)
	li $v0,35
	syscall
	
	print_string("\n")
	
	andi $t1,$s1,0x55555555 # and opration 
	sll $t1,$t1,1 # shift left
	
	andi $t2,$s1,0xaaaaaaaa # and operation 
	srl $t2,$t2,1 # shift right 
	
	addu $t3,$t1,$t2 # addition
	
	print_string("The exchanged data is: ")
	# print the exchanged data
	move $a0,$t3
	li $v0,35
	syscall
	
	end
	
