.data
line: .byte  '\n'
.text
.globl main
main:
	li $a0,1 # i
	li $s0,9 # bound
	#li $s6,0
loop_i:
	li $a1,1
loop_j:
	jal print_table
	addi $a1,$a1,1
	ble $a1,$a0,loop_j
	addi $a0,$a0,1
	#addi $s7,$s7,1
	move $t2,$a0
	lb $a0,line
	li $v0,11
	syscall 
	move $a0,$t2
	ble $a1,$s0,loop_i
	
	li $v0,10
	syscall
