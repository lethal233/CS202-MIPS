.include "macro_print_str.s"
.data
	testdata: .word 0x1ac23456
.text 
main:
	la $t1,testdata      # load the address of the first data of testdata
	
	lbu  $a1,0($t1)      	# load the byte 
	sll $a1,$a1,8	     	# shift left 8 bits
	
	lbu $a2,1($t1)		# load the byte
	addu $a1,$a1,$a2	# add the second byte
	sll $a1,$a1,8		# shift left 8 bits
	
	lbu $a2,2($t1)		# load the byte
	addu $a1,$a1,$a2	# add the third byte
	sll $a1,$a1,8		# shift left 8 bits
	
	lbu $a2,3($t1)		# load the byte
	addu $a1,$a1,$a2	# add the fourth byte
	
	print_string("The big-endian of 0x1ac23456 is: ")
	# print the big-endian
	move $a0,$a1
	li $v0,34
	syscall
	
	print_string("\n")
	print_string("The small-endian of 0x1ac23456 is: ")
	
	lbu  $a1,3($t1)	# load the byte
	sll $a1,$a1,8		# shift left 8 bits
	
	lbu $a2,2($t1)		# load the byte
	addu $a1,$a1,$a2	# add the byte
	sll $a1,$a1,8		# shift left 8 bits
	
	lbu $a2,1($t1)		# load the byte
	addu $a1,$a1,$a2	# add the byte
	sll $a1,$a1,8		# shift left 8 bit
	
	lbu $a2,0($t1)		# load the byte
	addu $a1,$a1,$a2	# add the byte
	
	# print the small-endian
	move $a0,$a1		# set $a1 to $a0
	li $v0,34
	syscall
	
	end
