   .data
TRUE_FLAG:   .word   1
FALSE_FLAG:   .word   0
TRUE_SYM:   .byte   'T'
FALSE_SYM:   .byte   'F'
K: .word 0#????
FIB:   .space   124
alphabet:   .space   57
g_char_c:   .byte   0
Str0:   .asciiz   "**********************************************************"
Str1:   .asciiz   "begin testing switch: there should be 2 Ts "
Str2:   .asciiz   "(0==1) = 1 "
Str3:   .asciiz   "switch testing finished"
Str4:   .asciiz   "************************************************************"
Str5:   .asciiz   "should return "
Str6:   .asciiz   "********************************************************"
Str7:   .asciiz   "begin testing if: there should be 3 Ts "
Str8:   .asciiz   "int value 0 is true "
Str9:   .asciiz   "false is true "
Str10:   .asciiz   "true if in false if "
Str11:   .asciiz   "false if in true if "
Str12:   .asciiz   "false if in false if "
Str13:   .asciiz   "1"
Str14:   .asciiz   "2"
Str15:   .asciiz   "jump error "
Str16:   .asciiz   "jump error "
Str17:   .asciiz   " if testing finished"
Str18:   .asciiz   "*******************************************************"
Str19:   .asciiz   "********************************************************"
Str20:   .asciiz   "begin testing ops "
Str21:   .asciiz   "RelaOp "
Str22:   .asciiz   "less1 "
Str23:   .asciiz   "less2 "
Str24:   .asciiz   "leq "
Str25:   .asciiz   "greater1 "
Str26:   .asciiz   "greater2 "
Str27:   .asciiz   "geq "
Str28:   .asciiz   "equal "
Str29:   .asciiz   "neq "
Str30:   .asciiz   "char in condition"
Str31:   .asciiz   " ArithOp "
Str32:   .asciiz   "op testing finished"
Str33:   .asciiz   "*************************************************"
Str34:   .asciiz   "ArithOp "
Str35:   .asciiz   "***********************************************"
Str36:   .asciiz   "input number should be bigger than 0"
Str37:   .asciiz   "input number should be less than 21"
Str38:   .asciiz   "unknown error"
Str39:   .asciiz   "please input a number between 0(not included) and 20 and a character:"
Str40:   .asciiz   " "
Str41:   .asciiz   "something wrong in Fib"
Str42:   .asciiz   "something wrong in expression dealing"
Str43:   .asciiz   "the no."
Str44:   .asciiz   " Fibnonacci is "
enter:   .asciiz   "\n"
  .text
jal main
li $v0,10
syscall
TestSwitc:
addi $sp,$sp,-8
sw $ra,4($sp)
sw $fp,0($sp)
move $fp,$sp
la $a0,Str0
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str1
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
switch0:
swi0cs1:
lw $t0,TRUE_FLAG
li $t1,1
bne $t0,$t1,swi0csdef
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
j endswitch0
swi0csdef:
endswitch0:
switch1:
swi1cs1:
lw $t0,FALSE_FLAG
li $t1,1
bne $t0,$t1,swi1cs0
la $a0,Str2
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
j endswitch1
swi1cs0:
lw $t0,FALSE_FLAG
li $t1,0
bne $t0,$t1,swi1csdef
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
j endswitch1
swi1csdef:
endswitch1:
switch2:
swi2csT:
lb $t0,TRUE_SYM
li $t1,'T'
bne $t0,$t1,swi2csdef
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str3
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str4
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,4($sp)
lw $fp,0($sp)
jr $ra
addi $sp,$sp,8
j endswitch2
swi2csdef:
la $a0,Str5
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endswitch2:
move $sp,$fp
lw $ra,4($sp)
lw $fp,0($sp)
jr $ra
addi $sp,$sp,8
TestIf:
addi $sp,$sp,-76
sw $ra,72($sp)
sw $fp,68($sp)
move $fp,$sp
la $a0,Str6
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str7
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
if0:
li $t0,0
sw $t0,64($fp)
lw $t0,64($fp)
beq $t0,$0,endif0
la $a0,Str8
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif0:
if1:
li $t0,'a'
sb $t0,60($fp)
lb $t0,60($fp)
beq $t0,$0,endif1
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif1:
if2:
li $t0,1
sw $t0,56($fp)
lw $t0,56($fp)
beq $t0,$0,endif2
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif2:
if3:
li $t0,0
sw $t0,52($fp)
li $t0,0
sw $t0,48($fp)
lw $t0,52($fp)
lw $t1,48($fp)
bne $t0,$t1,endif3
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif3:
if4:
li $t0,0
sw $t0,44($fp)
li $t0,0
sw $t0,40($fp)
lw $t0,44($fp)
lw $t1,40($fp)
beq $t0,$t1,endif4
la $a0,Str9
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif4:
if5:
li $t0,1
sw $t0,36($fp)
lw $t0,36($fp)
beq $t0,$0,endif5
if6:
li $t0,1
sw $t0,32($fp)
lw $t0,32($fp)
beq $t0,$0,endif6
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif6:
endif5:
if7:
li $t0,0
sw $t0,28($fp)
lw $t0,28($fp)
beq $t0,$0,endif7
if8:
li $t0,1
sw $t0,24($fp)
lw $t0,24($fp)
beq $t0,$0,endif8
la $a0,Str10
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif8:
endif7:
if9:
li $t0,1
sw $t0,20($fp)
lw $t0,20($fp)
beq $t0,$0,endif9
if10:
li $t0,0
sw $t0,16($fp)
lw $t0,16($fp)
beq $t0,$0,endif10
la $a0,Str11
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif10:
endif9:
if11:
li $t0,0
sw $t0,12($fp)
lw $t0,12($fp)
beq $t0,$0,endif11
if12:
li $t0,0
sw $t0,8($fp)
lw $t0,8($fp)
beq $t0,$0,endif12
la $a0,Str12
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif12:
endif11:
if13:
li $t0,1
sw $t0,4($fp)
lw $t0,4($fp)
beq $t0,$0,endif13
la $a0,Str13
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str14
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif13:
if14:
li $t0,0
sw $t0,0($fp)
lw $t0,0($fp)
beq $t0,$0,endif14
la $a0,Str15
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str16
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif14:
la $a0,Str17
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str18
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,72($sp)
lw $fp,68($sp)
jr $ra
addi $sp,$sp,76
TestOp:
addi $sp,$sp,-260
sw $ra,256($sp)
sw $fp,252($sp)
move $fp,$sp
la $a0,Str19
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str20
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
if15:
li $t0,1
sw $t0,248($fp)
li $t0,2
sw $t0,244($fp)
lw $t0,248($fp)
lw $t1,244($fp)
sub $t2,$t0,$t1
bgez $t2,endif15
if16:
li $t0,1
sw $t0,240($fp)
li $t0,2
sw $t0,236($fp)
lw $t0,240($fp)
lw $t1,236($fp)
sub $t2,$t0,$t1
bgtz $t2,endif16
if17:
li $t0,2
sw $t0,232($fp)
li $t0,2
sw $t0,228($fp)
lw $t0,232($fp)
lw $t1,228($fp)
sub $t2,$t0,$t1
bgtz $t2,endif17
if18:
li $t0,3
sw $t0,224($fp)
li $t0,2
sw $t0,220($fp)
lw $t0,224($fp)
lw $t1,220($fp)
sub $t2,$t0,$t1
blez $t2,endif18
if19:
li $t0,3
sw $t0,216($fp)
li $t0,2
sw $t0,212($fp)
lw $t0,216($fp)
lw $t1,212($fp)
sub $t2,$t0,$t1
bltz $t2,endif19
if20:
li $t0,2
sw $t0,208($fp)
li $t0,2
sw $t0,204($fp)
lw $t0,208($fp)
lw $t1,204($fp)
sub $t2,$t0,$t1
bltz $t2,endif20
if21:
li $t0,2
sw $t0,200($fp)
li $t0,2
sw $t0,196($fp)
lw $t0,200($fp)
lw $t1,196($fp)
bne $t0,$t1,endif21
if22:
li $t0,4
sw $t0,192($fp)
li $t0,2
sw $t0,188($fp)
lw $t0,192($fp)
lw $t1,188($fp)
beq $t0,$t1,endif22
la $a0,Str21
li $v0,4
syscall
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif22:
endif21:
endif20:
endif19:
endif18:
endif17:
endif16:
endif15:
if23:
li $t0,2
sw $t0,184($fp)
li $t0,1
sw $t0,180($fp)
lw $t0,184($fp)
lw $t1,180($fp)
sub $t2,$t0,$t1
bgez $t2,endif23
la $a0,Str22
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif23:
if24:
li $t0,1
sw $t0,176($fp)
li $t0,1
sw $t0,172($fp)
lw $t0,176($fp)
lw $t1,172($fp)
sub $t2,$t0,$t1
bgez $t2,endif24
la $a0,Str23
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif24:
if25:
li $t0,2
sw $t0,168($fp)
li $t0,1
sw $t0,164($fp)
lw $t0,168($fp)
lw $t1,164($fp)
sub $t2,$t0,$t1
bgtz $t2,endif25
la $a0,Str24
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif25:
if26:
li $t0,2
sw $t0,160($fp)
li $t0,3
sw $t0,156($fp)
lw $t0,160($fp)
lw $t1,156($fp)
sub $t2,$t0,$t1
blez $t2,endif26
la $a0,Str25
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif26:
if27:
li $t0,2
sw $t0,152($fp)
li $t0,2
sw $t0,148($fp)
lw $t0,152($fp)
lw $t1,148($fp)
sub $t2,$t0,$t1
blez $t2,endif27
la $a0,Str26
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif27:
if28:
li $t0,2
sw $t0,144($fp)
li $t0,3
sw $t0,140($fp)
lw $t0,144($fp)
lw $t1,140($fp)
sub $t2,$t0,$t1
bltz $t2,endif28
la $a0,Str27
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif28:
if29:
li $t0,3
sw $t0,136($fp)
li $t0,2
sw $t0,132($fp)
lw $t0,136($fp)
lw $t1,132($fp)
bne $t0,$t1,endif29
la $a0,Str28
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif29:
if30:
li $t0,2
sw $t0,128($fp)
li $t0,2
sw $t0,124($fp)
lw $t0,128($fp)
lw $t1,124($fp)
beq $t0,$t1,endif30
la $a0,Str29
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif30:
if31:
li $t0,'T'
sb $t0,120($fp)
lb $t0,TRUE_SYM
lb $t1,120($fp)
beq $t0,$t1,endif31
la $a0,Str30
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif31:
if32:
li $t0,1
sw $t0,116($fp)
li $t0,1
sw $t0,112($fp)
lw $t0,116($fp)
lw $t1,112($fp)
add $t2,$t0,$t1
sw $t2,108($fp)
li $t0,2
sw $t0,104($fp)
lw $t0,108($fp)
lw $t1,104($fp)
bne $t0,$t1,endif32
if33:
li $t0,1
sw $t0,100($fp)
li $t0,1
sw $t0,96($fp)
lw $t0,100($fp)
lw $t1,96($fp)
sub $t2,$t0,$t1
sw $t2,92($fp)
li $t0,0
sw $t0,88($fp)
lw $t0,92($fp)
lw $t1,88($fp)
bne $t0,$t1,endif33
if34:
li $t0,1
sw $t0,84($fp)
li $t0,1
sw $t0,80($fp)
lw $t0,84($fp)
lw $t1,80($fp)
mult $t0,$t1
mflo $t2
sw $t2,76($fp)
li $t0,1
sw $t0,72($fp)
lw $t0,76($fp)
lw $t1,72($fp)
bne $t0,$t1,endif34
if35:
li $t0,4
sw $t0,68($fp)
li $t0,2
sw $t0,64($fp)
lw $t0,68($fp)
lw $t1,64($fp)
div $t0,$t1
mflo $t2
sw $t2,60($fp)
li $t0,2
sw $t0,56($fp)
lw $t0,60($fp)
lw $t1,56($fp)
bne $t0,$t1,endif35
if36:
li $t0,5
sw $t0,52($fp)
li $t0,2
sw $t0,48($fp)
lw $t0,52($fp)
lw $t1,48($fp)
div $t0,$t1
mflo $t2
sw $t2,44($fp)
li $t0,2
sw $t0,40($fp)
lw $t0,44($fp)
lw $t1,40($fp)
bne $t0,$t1,endif36
if37:
li $t0,0
sw $t0,36($fp)
li $t0,1
sw $t0,32($fp)
li $t0,2
sw $t0,28($fp)
li $t0,3
sw $t0,24($fp)
lw $t0,28($fp)
lw $t1,24($fp)
mult $t0,$t1
mflo $t2
sw $t2,20($fp)
li $t0,4
sw $t0,16($fp)
lw $t0,20($fp)
lw $t1,16($fp)
div $t0,$t1
mflo $t2
sw $t2,12($fp)
lw $t0,32($fp)
lw $t1,12($fp)
add $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,36($fp)
lw $t1,8($fp)
sub $t2,$t0,$t1
sw $t2,4($fp)
li $t0,2
sw $t0,0($fp)
li $t0,0
lw $t1,0($fp)
sub $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,4($fp)
lw $t1,0($fp)
bne $t0,$t1,endif37
la $a0,Str31
li $v0,4
syscall
lb $a0,TRUE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str32
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str33
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,256($sp)
lw $fp,252($sp)
jr $ra
addi $sp,$sp,260
endif37:
endif36:
endif35:
endif34:
endif33:
endif32:
la $a0,Str34
li $v0,4
syscall
lb $a0,FALSE_SYM
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
la $a0,Str35
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,256($sp)
lw $fp,252($sp)
jr $ra
addi $sp,$sp,260
initAlph:
addi $sp,$sp,-64
sw $ra,60($sp)
sw $fp,56($sp)
move $fp,$sp
li $t0,0
sw $t0,52($fp)
li $t0,'a'
sb $t0,48($fp)
lw $t0,52($fp)
lb $t1,48($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
sw $t0,44($fp)
li $t0,'b'
sb $t0,40($fp)
lw $t0,44($fp)
lb $t1,40($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,2
sw $t0,36($fp)
li $t0,'c'
sb $t0,32($fp)
lw $t0,36($fp)
lb $t1,32($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,3
sw $t0,28($fp)
li $t0,'A'
sb $t0,24($fp)
lw $t0,28($fp)
lb $t1,24($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,4
sw $t0,20($fp)
li $t0,'B'
sb $t0,16($fp)
lw $t0,20($fp)
lb $t1,16($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,5
sw $t0,12($fp)
li $t0,'C'
sb $t0,8($fp)
lw $t0,12($fp)
lb $t1,8($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,6
sw $t0,4($fp)
li $t0,'_'
sb $t0,0($fp)
lw $t0,4($fp)
lb $t1,0($fp)
la $t2,alphabet
add $t2,$t2,$t0
sb $t1,0($t2)
move $sp,$fp
lw $ra,60($sp)
lw $fp,56($sp)
jr $ra
addi $sp,$sp,64
TestGloba:
addi $sp,$sp,-32
sw $ra,28($sp)
sw $fp,24($sp)
move $fp,$sp
lw $t0,32($fp)
sw $t0,16($fp)
lw $t0,36($fp)
sw $t0,20($fp)
if38:
lw $t0,20($fp)
lw $t1,16($fp)
sub $t2,$t0,$t1
blez $t2,endif38
move $sp,$fp
lw $ra,28($sp)
lw $fp,24($sp)
jr $ra
addi $sp,$sp,32
endif38:
lw $t0,20($fp)
la $t1,alphabet
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,12($fp)
lb $t0,12($fp)
sb $t0,g_char_c
if39:
li $t0,'_'
sb $t0,8($fp)
lb $t0,g_char_c
lb $t1,8($fp)
bne $t0,$t1,endif39
move $sp,$fp
lw $ra,28($sp)
lw $fp,24($sp)
jr $ra
addi $sp,$sp,32
endif39:
lb $a0,g_char_c
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
li $t0,1
sw $t0,4($fp)
lw $t0,20($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,16($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal TestGloba
addi $sp,$sp,8
move $sp,$fp
lw $ra,28($sp)
lw $fp,24($sp)
jr $ra
addi $sp,$sp,32
Fib:
addi $sp,$sp,-48
sw $ra,44($sp)
sw $fp,40($sp)
move $fp,$sp
lw $t0,48($fp)
sw $t0,36($fp)
if40:
li $t0,1
sw $t0,32($fp)
lw $t0,36($fp)
lw $t1,32($fp)
sub $t2,$t0,$t1
bgtz $t2,endif40
li $t0,1
sw $t0,28($fp)
lw $t0,28($fp)
move $v0,$t0
move $sp,$fp
lw $ra,44($sp)
lw $fp,40($sp)
jr $ra
addi $sp,$sp,48
endif40:
li $t0,2
sw $t0,24($fp)
lw $t0,36($fp)
lw $t1,24($fp)
sub $t2,$t0,$t1
sw $t2,20($fp)
lw $t0,20($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal Fib
move $t4,$v0
sw $t4,16($fp)
addi $sp,$sp,4
li $t0,1
sw $t0,12($fp)
lw $t0,36($fp)
lw $t1,12($fp)
sub $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,8($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal Fib
move $t4,$v0
sw $t4,4($fp)
addi $sp,$sp,4
lw $t0,16($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,44($sp)
lw $fp,40($sp)
jr $ra
addi $sp,$sp,48
RecordFib:
addi $sp,$sp,-80
sw $ra,76($sp)
sw $fp,72($sp)
move $fp,$sp
lw $t0,80($fp)
sw $t0,68($fp)
li $t0,0
sw $t0,60($fp)
li $t0,1
sw $t0,56($fp)
lw $t0,60($fp)
lw $t1,56($fp)
la $t2,FIB
sll $t0,$t0,2
add $t2,$t2,$t0
move $a0,$t0####
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall#######
sw $t1,0($t2)
li $t0,1
sw $t0,52($fp)
li $t0,1
sw $t0,48($fp)
lw $t0,52($fp)
lw $t1,48($fp)
la $t2,FIB
sll $t0,$t0,2
add $t2,$t2,$t0
move $a0,$t0####
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall#######
sw $t1,0($t2)
li $t0,2
sw $t0,44($fp)
lw $t0,44($fp)
sw $t0,64($fp)
while0:
lw $t0,64($fp)
lw $t1,68($fp)
sub $t2,$t0,$t1
bgtz $t2,endwhile0
li $t0,1
sw $t0,40($fp)
lw $t0,64($fp)
lw $t1,40($fp)
sub $t2,$t0,$t1
sw $t2,36($fp)
lw $t0,36($fp)
la $t1,FIB
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,32($fp)
li $t0,2
sw $t0,28($fp)
lw $t0,64($fp)
lw $t1,28($fp)
sub $t2,$t0,$t1
sw $t2,24($fp)
lw $t0,24($fp)
la $t1,FIB
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,20($fp)
lw $t0,32($fp)
lw $t1,20($fp)
add $t2,$t0,$t1
sw $t2,16($fp)
lw $t0,64($fp)
lw $t1,16($fp)
la $t2,FIB
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
li $t0,1
sw $t0,12($fp)
lw $t0,64($fp)
lw $t1,12($fp)
add $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,8($fp)
sw $t0,64($fp)
j while0
endwhile0:
li $t0,1
sw $t0,4($fp)
lw $t0,68($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
sw $t0,64($fp)
move $sp,$fp
lw $ra,76($sp)
lw $fp,72($sp)
jr $ra
addi $sp,$sp,80
error:
addi $sp,$sp,-12
sw $ra,8($sp)
sw $fp,4($sp)
move $fp,$sp
lw $t0,12($fp)
sw $t0,0($fp)
switch3:
swi3cs1:
lw $t0,0($fp)
li $t1,1
bne $t0,$t1,swi3cs2
la $a0,Str36
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
j endswitch3
swi3cs2:
lw $t0,0($fp)
li $t1,2
bne $t0,$t1,swi3csdef
la $a0,Str37
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
j endswitch3
swi3csdef:
la $a0,Str38
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endswitch3:
move $sp,$fp
lw $ra,8($sp)
lw $fp,4($sp)
jr $ra
addi $sp,$sp,12
main:
addi $sp,$sp,-160
sw $ra,156($sp)
sw $fp,152($sp)
move $fp,$sp
li $t0,20
sw $t0,148($fp)
jal TestOp
jal TestSwitc
jal initAlph
li $t0,0
sw $t0,132($fp)
lw $t0,132($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,6
sw $t0,128($fp)
lw $t0,128($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal TestGloba
addi $sp,$sp,8
la $a0,Str39
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0
sw $t0,144($fp)
li $v0,12
syscall
move $t0,$v0
sb $t0,136($fp)
la $a0,Str40
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
sw $t0,124($fp)
lw $t0,124($fp)
sw $t0,140($fp)
if41:
li $t0,0
sw $t0,120($fp)
lw $t0,144($fp)
lw $t1,120($fp)
sub $t2,$t0,$t1
bgtz $t2,endif41
li $t0,1
sw $t0,116($fp)
lw $t0,116($fp)
sw $t0,140($fp)
endif41:
if42:
lw $t0,144($fp)
lw $t1,148($fp)
sub $t2,$t0,$t1
blez $t2,endif42
li $t0,2
sw $t0,112($fp)
lw $t0,112($fp)
sw $t0,140($fp)
endif42:
if43:
lw $t0,140($fp)
beq $t0,$0,endif43
lw $t0,140($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal error
addi $sp,$sp,4
move $sp,$fp
lw $ra,156($sp)
lw $fp,152($sp)
jr $ra
addi $sp,$sp,160
endif43:
lw $t0,144($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal RecordFib
addi $sp,$sp,4
if44:
lw $t0,144($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal Fib
move $t4,$v0
sw $t4,108($fp)
addi $sp,$sp,4
lw $t0,144($fp)
la $t1,FIB
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,104($fp)
lw $t0,108($fp)
lw $t1,104($fp)
beq $t0,$t1,endif44
la $a0,Str41
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif44:
if45:
li $t0,-1
sw $t0,100($fp)
li $t0,0
lw $t1,100($fp)
sub $t2,$t0,$t1
sw $t2,100($fp)
li $t0,1
sw $t0,96($fp)
li $t0,-1
sw $t0,92($fp)
lw $t0,96($fp)
lw $t1,92($fp)
mult $t0,$t1
mflo $t2
sw $t2,88($fp)
lw $t0,100($fp)
lw $t1,88($fp)
add $t2,$t0,$t1
sw $t2,84($fp)
li $t0,1
sw $t0,80($fp)
lw $t0,80($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal Fib
move $t4,$v0
sw $t4,76($fp)
addi $sp,$sp,4
lw $t0,76($fp)
lw $t1,144($fp)
mult $t0,$t1
mflo $t2
sw $t2,72($fp)
lw $t0,72($fp)
lw $t1,144($fp)
div $t0,$t1
mflo $t2
sw $t2,68($fp)
lw $t0,84($fp)
lw $t1,68($fp)
sub $t2,$t0,$t1
sw $t2,64($fp)
li $t0,'z'
sb $t0,60($fp)
li $t0,'a'
sb $t0,56($fp)
lb $t0,60($fp)
lb $t1,56($fp)
sub $t2,$t0,$t1
sw $t2,52($fp)
li $t0,12
sw $t0,48($fp)
lw $t0,52($fp)
lw $t1,48($fp)
div $t0,$t1
mflo $t2
sw $t2,44($fp)
li $t0,1
sw $t0,40($fp)
lw $t0,44($fp)
lw $t1,40($fp)
sub $t2,$t0,$t1
sw $t2,36($fp)
lw $t0,36($fp)
la $t1,FIB
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,32($fp)
lw $t0,64($fp)
lw $t1,32($fp)
add $t2,$t0,$t1
sw $t2,28($fp)
li $t0,'z'
sb $t0,24($fp)
lw $t0,28($fp)
lb $t1,24($fp)
sub $t2,$t0,$t1
sw $t2,20($fp)
li $t0,'a'
sb $t0,16($fp)
lw $t0,20($fp)
lb $t1,16($fp)
add $t2,$t0,$t1
sw $t2,12($fp)
li $t0,25
sw $t0,8($fp)
lw $t0,12($fp)
lw $t1,8($fp)
add $t2,$t0,$t1
sw $t2,4($fp)
lw $t0,4($fp)
beq $t0,$0,endif45
la $a0,Str42
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif45:
la $a0,Str43
li $v0,4
syscall
lw $a0,144($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,144($fp)
la $t1,FIB
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,0($fp)
la $a0,Str44
li $v0,4
syscall
lw $a0,0($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,156($sp)
lw $fp,152($sp)
jr $ra
addi $sp,$sp,160
