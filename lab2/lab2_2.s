.data
oriStr: .asciiz"abc"		#define the original string
finalStr: .asciiz ""		#define the output string
.text
main:

	la $s0,oriStr		#load the oriStr into register
	la $s1,finalStr		#load the finalStr into register
	
	lb $t1,0($s0)		#Take out the first letter
	sb $t1,0($s1)		#Store it in the finalStr
	sub $t1,$t1,32		#Captitalize it 
	sb $t1,1($s1)		#Store it in the finalStr
	
	
	lb $t1,1($s0)		#Take out the second letter
	sb $t1,2($s1)		#Store it in the finalStr
	sub $t1,$t1,32		#Captitalize it 
	sb $t1,3($s1)		#Store it in the finalStr
	
	
	lb $t1,2($s0)		#Take out the third letter
	sb $t1,4($s1)		#Store it in the finalStr
	sub $t1,$t1,32		#Captitalize it 
	sb $t1,5($s1)		#Store it in the finalStr
	
	#Print the finalStr
	li $v0,4	
	la $a0,($s1)		
	syscall
	
	#Exit the program
	li $v0,10
	syscall
	
	
	
