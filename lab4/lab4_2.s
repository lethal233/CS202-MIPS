.include "macro_print_str.s"
.data 
originstr: .space 15
flag: .byte '\n'
.text 
main:
	print_string("Input the string(the maximum length is 15): ")
	la $a0,originstr
	li $a1,15
	li $v0,8
	syscall
	
	la $s0,0($a0)
  	la $t0,0($a0)
	lb $t2,flag
loop:	
	lb $t1,0($s0)
	addi $s0,$s0,1
	bne $t1,$t2,loop
	
	addi $s0,$s0,-1
	sb $zero,0($s0)
	
	print_string("The inverse is: ")
loop2:
	addi $s0,$s0,-1
	lb $a0,0($s0)
	li $v0,11
	syscall
	bne $s0,$t0,loop2
  
  	end
