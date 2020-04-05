.include "macro_print_str.s"
.data
.text
main:
	print_string("Please input an integer: ")
	read_integer # read the input integer and move it to $t0
	
	bge $t0,$zero,PLUS # if the integer is >= 0
	sll $t1,$t0,1 # shift left 1 bits and store in $t1
	bge $t1,$zero,OVERFLOW # if twice has changed the sign, then overflow 
	sll $t0,$t0,3 # shift left 3 bit
	bge $t0,$zero,OVERFLOW # if eighth times has changed the sign, then overflow 
	addu $t2,$t1,$t0 # addition
	bge $t2,$zero,OVERFLOW # if tenth times has changed the sign, then overflow
	j PRINT
PLUS:
	sll $t1,$t0,1 # shift left 1 bits and store in $t1
	blt $t1,$zero,OVERFLOW # if twice has changed the sign, then overflow
	sll $t0,$t0,3 # shift left 3 bit
	blt $t0,$zero,OVERFLOW  # if eighth times has changed the sign, then overflow 
	addu $t2,$t1,$t0  # addition
	blt $t2,$zero,OVERFLOW  # if tenth times has changed the sign, then overflow
	j PRINT
	
OVERFLOW:
	print_string("It has been overflow.")	
	j END
PRINT:
	print_string("The 10 times of the input is ")
	la $a0,($t2)
	li $v0,1
	syscall
	j END
END:	
	end
