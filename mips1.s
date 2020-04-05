.include "../macro_print_str.asm"
.data
min_value: .word 0
.text
.globl main
main:
	print_string("please input the number:")
	li $v0,5 #read a integer
	syscall
	move $s0,$v0 #s0 is the number of integer
	move $a1,$v0
	sll $a0,$s0,2 #new a heap with 4*$s0
	li $v0,9
	syscall
	move $s1,$v0 #$s1 is the start of the heap
	move $s2,$v0 #$s2 is the point
	print_string("please input the array\n")
	add $t0,$0,$0
loop_read:
	li $v0,5 #read the array
	syscall
	sw $v0,($s2)
	addi $s2,$s2,4
	addi $t0,$t0,1
	bne $t0,$s0,loop_read
	
	lw $t0,($s1) #initialize the min_value
	sw $t0,min_value
	li $t0,1
	addi $s2,$s1,4
	
	move $a0,$s1
	print_array
	
	
	end 