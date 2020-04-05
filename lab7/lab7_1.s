.include "macro_print_str.s"
.data
const2: .word 2
const1: .word 1
.text
main:
	print_string("Input a nonnegative integer: ")
	li $v0,5
	syscall
	tlti $v0,0
	mtc1 $v0,$f16 # store the origin data into f2 # f2 = high 
	cvt.d.w $f2,$f16
	mov.d $f18,$f2
	
	print_string("The precision is defined as |output^2-input|<=precision.\n")
	print_string("precision > 0:")
	print_string("\nInput the precision(a double number): ")
	li $v0,7 # read e stored in the f0
	syscall
	
	mtc1 $zero,$f16 # f4 = 0 low
	cvt.d.w $f4,$f16
	
	lwc1 $f16,const2
	cvt.d.w $f6,$f16  # load the constant 2 into $f6
mysqrt: # use binary search to find the square root
	add.d $f8,$f4,$f2 # f8 store the f4+f2
	div.d $f8,$f8,$f6 # f8/2
	
	mul.d $f10,$f8,$f8 # f10 = f8^2
	add.d $f16,$f18,$f0 # N+e
	sub.d $f14,$f18,$f0 # N-e
	c.le.d 0,$f14,$f10
	bc1t further
	mov.d $f4,$f8
	j mysqrt
further:
	c.le.d 1,$f10,$f16
	bc1t 1,exit 
	mov.d $f2,$f8
	j mysqrt
exit:
	mov.d $f12,$f8
	li $v0,3
	syscall

	end
	
.ktext 0x80000180
	la $a0,illegal
	li $v0,4
	syscall
	end
.kdata
illegal: .asciiz "Illegeal input! The integer cannot be negative."
