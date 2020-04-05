.data
#Prompt users to input
prompt1: .asciiz"Please input the H1:"
prompt2: .asciiz"Please input the M1:"
prompt3: .asciiz"Please input the S:"
prompt4: .asciiz"Please input the R:"

#Define parts of the sentence
sentence1:.asciiz"Takes "
sentence2:.asciiz" hours and "
sentence3:.asciiz" minutes\n"

.text
main:
	#load constant into registers
	li $t4,60
	li $t7,2
	
	#Print prompt1
	li $v0,4
	la $a0,prompt1
	syscall
	
	#Read the value of H1, and store it in $t0
	li $v0,5
	syscall
	move $t0,$v0
	
	#Print prompt2
	li $v0,4
	la $a0,prompt2
	syscall
	
	#Read the value of M1, and store it in $t1
	li $v0,5
	syscall
	move $t1,$v0
	
	#Print prompt3
	li $v0,4
	la $a0,prompt3
	syscall
	
	#Read the value of S, and store it in $t2
	li $v0,5
	syscall
	move $t2,$v0
	
	#Print prompt4
	li $v0,4
	la $a0,prompt4
	syscall
	
	#Read the value of R, and store it in $t3
	li $v0,5
	syscall
	move $t3,$v0
	
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
	
