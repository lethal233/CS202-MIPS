.include "../macro_print_str.s"
.data
.text
.globl main
main:
	print_string("please input the number: ")
	
	li $v0,5
	syscall
	move $s0,$v0 # size 
	
	sll $a0,$s0,2
	li $v0,9
	syscall 
	move $s1,$v0 # s1 is base address
	move $s2,$v0
	
	print_string("Please input the array\n")
	add $t0,$zero,$zero
	
loop_read:
	li $v0,5
	syscall
	sw $v0,($s2)
	
	addi $s2,$s2,4 #n+1 address 
	addi $t0,$t0,1 
	bne $t0,$s0,loop_read
	
	move $a0,$s1 # base address 
	move $a1,$s0 # size
	jal sort
	print_string("After sorting the array we get: ")
	move $a1,$s0
	jal print_array
	end 
	
sort:
	addi $sp,$sp,-20
	sw $ra,16($sp)
	sw $s3,12($sp)
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)
	
	move $s2,$a0 # copy parameter $a0 into $s2
	move $s3,$a1 # copy parameter $a1 into $s3
	
	move $s0,$zero #i=0
loop_i:
	slt $t0,$s0,$s3 #t0=0 if i<n
	beq $t0,$zero,end_loop_i
	addi $s1,$s0,-1 #j = i-1
loop_j:
	slti $t0,$s0,-1 # t0 = 1 if j<0
	bne $t0,$zero,end_loop_j
	sll $t1,$s1,2  # t1 = j * 4
	add $t2,$s2,$t1 # t2 = v +(j * 4)
	lw $t3,0($t2) # t3 = v[j]
	lw $t4,4($t2) # t4 = v[j+1]
	slt $t0,$t4,$t3 # t0 = 0 if t4 < t3
	beq $t0,$zero,end_loop_j
	move $a0,$s2
	move $a1,$s1 # 2nd parameter is j
	jal swap
	
	addi $s1,$s1,-1 # j - 1
	j loop_j
end_loop_j:
	addi $s0,$s0,1
	j loop_i
end_loop_i:	
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra
swap:
	sll $t1,$a1,2  # t1 = k * 4
	add $t1,$a0,$t1 # t1 = v + (k * 4)
	
	lw $t0,0($t1)# t0(temp) = v[k]
	lw $t2,4($t1)# t2 = v[k+1]
	
	sw $t2,0($t1)# v[k] = t2
	sw $t0,4($t1)# v[k+1] = temp
	
	jr $ra
	

		

	
	
