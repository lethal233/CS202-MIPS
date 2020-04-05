.data
H1:	.word 1		#define H1
M1:	.word 43	#define M1
S:	.word 30	#define S
R:	.word 59	#define R

#define the parts of the sentences
sentence1:.asciiz"Takes "	
sentence2:.asciiz" hours and "
sentence3:.asciiz" minutes\n"

.text
main:
	#load the data into registers
	lw $t0,H1
	lw $t1,M1
	lw $t2,S
	lw $t3,R
	li $t4,60
	li $t7,2
	
	#To calculate the required time
	mult $t2,$t4
	mflo $t2
	div $t2,$t3
	mfhi $t5	 #Move the remainder to $t5
	mflo $t6	 #Move the quotient to $t6 (The minutes)
	
	#To judge whether it needs rouding-off
	multu $t5,$t7
	mflo $t5
	
	ble $t3, $t5, plus	#if R<=2*remainder, then the minutes must be added 1
	bgt $t3, $t5, remain	#else, no need to operate
	
plus:
	addi $t6,$t6,1
	j remain		#Jump to the label 'remain'
	
remain:	
	add $t1,$t1,$t6	#To sum M1 and the minutes calculated in the process
	#To convert the minutes to xx hours and xx minutes
	divu $t1,$t4		
	mfhi $t5		#Move the remainder to $t5
	mflo $t6 		#Move the quotient to $t6
	
	add $t0,$t0,$t6	#To calculate the total hours
	move $t1,$t5		#Assign the remainder to the M1
	
	#Print "Takes "
	li $v0,4
	la $a0,sentence1
	syscall
	
	#Print hours needed
	li $v0,1
	la $a0,($t0)
	syscall
	
	#Print " hours and "
	li $v0,4
	la $a0,sentence2
	syscall
	
	#Print minutes needed
	li $v0,1
	la $a0,($t1)
	syscall
	
	#Print " minutes\n"
	li $v0,4
	la $a0,sentence3
	syscall
	
	#Exit the program
	li $v0,10
	syscall
	
