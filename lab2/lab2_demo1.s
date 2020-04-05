.data
str: .asciiz "A"

.text
main:
	la $a0,str
	li $v0,4
	syscall 
	lb $t0,($a0)
	addi $t0,$t0,32
	sb $t0,str
	syscall
	li $v0,10
	syscall