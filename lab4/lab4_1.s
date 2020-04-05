.include "macro_print_str.s"
.data
.text
main:
	addi $t0,$zero,6
	addi $t1,$zero,1001
	addi $s0,$zero,31
	
	
counterloop:
	beq $t0,$t1,endcounterloop
	addi $t2,$zero,1 #i
	
iloop:
	beq $t2,$s0,endiloop
	addi $t3,$zero,1 #j
	
jloop:
	beq $t3,$s0,endjloop
	addi $t4,$zero,1 #k

kloop:
	beq $t4,$s0,endkloop
	mult $t2,$t2
	mflo $t5
	
	mult $t3,$t3
	mflo $t6
	addu $t5,$t5,$t6
	
	mult $t4,$t4
	mflo $t6
	addu $t5,$t5,$t6
	
	mult $t2,$t3
	mflo $t6
	addu $t5,$t5,$t6
	
	mult $t2,$t4
	mflo $t6
	addu $t5,$t5,$t6
	
	mult $t3,$t4
	mflo $t6
	addu $t5,$t5,$t6
	
	bne $t5,$t0,continue
print_result:
	la $a0,0($t0)	
	li $v0,1
	syscall
	print_string(" ")
	j endiloop
continue:	
	addi $t4,$t4,1
	j kloop
endkloop:
	addi $t3,$t3,1
	j jloop
endjloop:
	addi $t2,$t2,1
	j iloop
endiloop:
	addi $t0,$t0,1
	j counterloop
endcounterloop:
	end
		
		
		
