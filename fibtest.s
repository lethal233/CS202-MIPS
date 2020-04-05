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
	sw $a0,8($sp)
	sw $ra,4($sp)
	sw $s0,0($sp)
	
	slti $t0,$a0,2
	beq $t0,$zero,else
	add $v0,$a0,$zero
	j exit

else:
	addi $a0,$a0,-1
	jal fib
	add $v0,$v0,$s0
	addi $a0,$a0,-1
	jal fib
	add $v0,$v0,$s0
	
exit:
	lw $a0,8($sp)
	lw $ra,4($sp)
	lw $s0,0($sp)
	addi $sp,$sp,12
	jr $ra
