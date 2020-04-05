.include "macro_print_str.s"
.data
  str1: .space 20
  str2: .space 20
  newline: .byte  '\n'
.text
main:
  print_string("Please input a string with less than 20 charachers: ")
  la $a0,str1
  li $a1,20
  li $v0,8
  syscall  
  add $s0, $a0, $zero # $s0 store the address of the input string
  add $t0, $a0, $zero # $t0 store the base of the input string
  lb $t2, newline
loop_f: # find the terminal newline character and replace it with \0
  lb $t1, ($s0)
  addi $s0, $s0, 1
  bne $t1,$t2,loop_f 
  addi $s0, $s0, -1
  sb $zero, ($s0)
      
  la $s1, str2 # $s1 store the address of the output string
loop_w:
  addi $s0, $s0, -1
  lb $t1, ($s0)
  sb $t1, ($s1)
  addi $s1, $s1, 1
  bne $s0, $t0, loop_w
  
  print_string("The inverse of the string is: ")
  la $a0, str2
  li $v0, 4
  syscall
  
  end
