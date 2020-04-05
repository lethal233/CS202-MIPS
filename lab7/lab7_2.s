.include "macro_print_str.s"
.data
size: .word 5
A: .float 0.0,0.0,0.0,0.0,0.0
B: .float 0.0,0.0,0.0,0.0,0.0
C: .float 0.0,0.0,0.0,0.0,0.0
.text
main:
	lw $s0,size # size in s0
	la $s1,A # A in s1
	move $s2,$s1 # base address
	la $s3,B # B in s3
	move $s4,$s3 # base address
	la $s5,C # C in s5
	move $s6,$s5 # base address
	mtc1 $zero,$f16
	cvt.s.w $f16,$f14 # f14= 0
	add $t0,$zero,$zero # i in t0
	print_string("input the number: ")
loopA:
	li $v0,6
	syscall
	swc1 $f0,0($s1) 
	addi $s1,$s1,4
	addi $t0,$t0,1
	bne $t0,$s0,loopA
	add $t0,$zero,$zero # i in t0
# loopB:
	# li $v0,6
	# syscall
	# swc1 $f0,0($s3)
	# addi $s3,$s3,4
	# addi $t0,$t0,1
	# bne $t0,$s0,loopB
# loopC:
	# li $v0,6
	# syscall
	# swc1 $f0,0($s5)
	# addi $s5,$s5,4
	# addi $t0,$t0,1
	# bne $t0,$s0,loopC
	# addi $t0,$zero,$zero # i in t0
	add.s $f1,$f14,$f14 # f1 is sum
	move $s1,$s2
calculateA:
	lwc1 $f2,0($s1)
	add.s $f1,$f1,$f2
	addi $s1,$s1,4
	addi $t0,$t0,1
	bne $t0,$s0,calculateA
	
	mov.s $f12,$f1
	li $v0,2
	syscall
	end 
