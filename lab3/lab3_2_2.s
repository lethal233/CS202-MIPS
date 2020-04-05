.include "macro_print_str.s"
.data
.text
main:
	print_string("Input the value: ") # prompt the input 
	read_integer # read the input integer and move it to $t0
	
	move $t1,$t0 # set $t0 to $t1
	sra $t1,$t1,31 # shift right arithmetics 31 bits

	xor $t0,$t1,$t0 # xor on each bit
	sub $t0,$t0,$t1 # substraction
	
	print_string("The absolute value is: ")
	# print the absolute value
	la $a0,($t0) 
	li $v0,1
	syscall
	
	end
