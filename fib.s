.include "macro_print_str.s"
.data
.text
main:
	li $a0,2
	li $s0,0
	jal fib
	li $v0,10
	syscall
	
fib:
	addi $sp,$sp,-12
	sw $ra,8($sp)
	sw $s0,4($sp)
	sw $a0,0($sp)
	bgt $a0,$zero,test2
	add $v0,$zero,$zero
	j return
	
test2: addi $t0,$zero,1
	bne $t0,$a0,gen
	add $v0,$zero,$t0
	j return
	
gen:
	subi $a0,$a0,1
	jal fib
	add $s0,$v0,$zero
	sub $a0,$a0,1
	jal fib
	add $v0,$v0,$s0
return:
	lw $a0,0($sp)
	lw $s0,4($sp)
	lw $ra,8($sp)
	addi $sp,$sp,12
	jr $ra
