   .data
a1:   .word   0
b1:   .word   1
c1:   .word   10
A1:   .byte   'a'
B1:   .byte   'A'
C1:   .byte   '+'
D1:   .byte   '-'
E1:   .byte   '*'
F1:   .byte   '/'
G1:   .byte   '_'
H1:   .byte   '1'
d1:   .word   -0
e1:   .word   0
f1:   .word   5
g1:   .word   -10
Fibonaq:   .space   40
count:   .word   0
_a__A_:   .byte   0
Str0:   .asciiz   "FIBONAQ:"
Str1:   .asciiz   "_a__A_ is the first:"
Str2:   .asciiz   "sk is 0"
Str3:   .asciiz   "sk is not 0"
Str4:   .asciiz   "_a__A_ is the second:"
Str5:   .asciiz   "_a__A_ is the third:"
Str6:   .asciiz   "default:_a__A_ is not in swich words:"
Str7:   .asciiz   "a >= b"
Str8:   .asciiz   "a+1 <= 2b"
Str9:   .asciiz   "a is 10;"
Str10:   .asciiz   "a != b"
Str11:   .asciiz   "a < 2*b"
Str12:   .asciiz   "a > b"
Str13:   .asciiz   "a+b is not 0"
Str14:   .asciiz   "funct_add:"
Str15:   .asciiz   "a+b+A1-B1:"
Str16:   .asciiz   "-(a+b)+A1-B1+a*b/2-add(k,1)*2+a_array[1]*2/3+'a'-10:"
Str17:   .asciiz   "  !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUV  WXYZ[\]^`abcdefghijklmnopqrstuvwxyz{|}~ "
Str18:   .asciiz   "Helloworld!"
Str19:   .asciiz   "count_1:"
Str20:   .asciiz   "print1:"
enter:   .asciiz   "\n"
  .text
jal main
li $v0,10
syscall
add:
addi $sp,$sp,-24
sw $ra,20($sp)
sw $fp,16($sp)
move $fp,$sp
lw $t0,24($fp)
sw $t0,8($fp)
lw $t0,28($fp)
sw $t0,12($fp)
li $t0,0
sw $t0,4($fp)
lw $t0,12($fp)
lw $t1,8($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,20($sp)
lw $fp,16($sp)
jr $ra
addi $sp,$sp,24
add_s:
addi $sp,$sp,-52
sw $ra,48($sp)
sw $fp,44($sp)
move $fp,$sp
lw $t0,52($fp)
sw $t0,24($fp)
lw $t0,56($fp)
sw $t0,28($fp)
lw $t0,60($fp)
sw $t0,32($fp)
lw $t0,64($fp)
sw $t0,36($fp)
lw $t0,68($fp)
sw $t0,40($fp)
li $t0,9
sw $t0,20($fp)
lw $t0,40($fp)
lw $t1,36($fp)
add $t2,$t0,$t1
sw $t2,16($fp)
lw $t0,16($fp)
lw $t1,32($fp)
add $t2,$t0,$t1
sw $t2,12($fp)
lw $t0,12($fp)
lw $t1,28($fp)
add $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,8($fp)
lw $t1,24($fp)
add $t2,$t0,$t1
sw $t2,4($fp)
lw $t0,4($fp)
lw $t1,20($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $a0,0($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,48($sp)
lw $fp,44($sp)
jr $ra
addi $sp,$sp,52
ret1:
addi $sp,$sp,-12
sw $ra,8($sp)
sw $fp,4($sp)
move $fp,$sp
lw $t0,12($fp)
sw $t0,0($fp)
if0:
lw $t0,0($fp)
li $t1,1
bne $t0,$t1,endif0
li $t0,1
move $v0,$t0
move $sp,$fp
lw $ra,8($sp)
lw $fp,4($sp)
jr $ra
addi $sp,$sp,12
endif0:
if1:
lw $t0,0($fp)
li $t1,0
bne $t0,$t1,endif1
li $t0,'a'
move $v0,$t0
move $sp,$fp
lw $ra,8($sp)
lw $fp,4($sp)
jr $ra
addi $sp,$sp,12
endif1:
fun_void:
addi $sp,$sp,-20
sw $ra,16($sp)
sw $fp,12($sp)
move $fp,$sp
li $t0,10
sw $t0,8($fp)
move $sp,$fp
lw $ra,16($sp)
lw $fp,12($sp)
jr $ra
addi $sp,$sp,20
funct_add:
addi $sp,$sp,-56
sw $ra,52($sp)
sw $fp,48($sp)
move $fp,$sp
lw $t0,56($fp)
sw $t0,40($fp)
lw $t0,60($fp)
sw $t0,44($fp)
li $t0,0
li $t1,'Z'
addi $t2,$fp,28
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
li $t1,'0'
addi $t2,$fp,28
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,44($fp)
lw $t1,40($fp)
mult $t0,$t1
mflo $t2
sw $t2,24($fp)
lw $t0,24($fp)
sw $t0,36($fp)
lw $t0,44($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,40($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,20($fp)
addi $sp,$sp,8
lw $t0,36($fp)
lw $t1,20($fp)
add $t2,$t0,$t1
sw $t2,16($fp)
li $t0,1
addi $t1,$fp,28
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,12($fp)
lw $t0,16($fp)
lw $t1,12($fp)
sub $t2,$t0,$t1
sw $t2,8($fp)
li $t0,0
addi $t1,$fp,28
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,4($fp)
lw $t0,8($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,52($sp)
lw $fp,48($sp)
jr $ra
addi $sp,$sp,56
trans_case:
addi $sp,$sp,-28
sw $ra,24($sp)
sw $fp,20($sp)
move $fp,$sp
lw $t0,28($fp)
sw $t0,16($fp)
if2:
lb $t0,16($fp)
li $t1,'A'
sub $t2,$t0,$t1
bltz $t2,endif2
if3:
lb $t0,16($fp)
li $t1,'Z'
sub $t2,$t0,$t1
bgtz $t2,endif3
lw $t0,16($fp)
li $t1,'a'
add $t2,$t0,$t1
sw $t2,12($fp)
lw $t0,12($fp)
li $t1,'A'
sub $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,8($fp)
move $v0,$t0
move $sp,$fp
lw $ra,24($sp)
lw $fp,20($sp)
jr $ra
addi $sp,$sp,28
endif3:
endif2:
if4:
lb $t0,16($fp)
li $t1,'a'
sub $t2,$t0,$t1
bltz $t2,endif4
if5:
lb $t0,16($fp)
li $t1,'z'
sub $t2,$t0,$t1
bgtz $t2,endif5
li $t0,'a'
li $t1,'A'
sub $t2,$t0,$t1
sw $t2,4($fp)
lw $t0,16($fp)
lw $t1,4($fp)
sub $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,24($sp)
lw $fp,20($sp)
jr $ra
addi $sp,$sp,28
endif5:
endif4:
count_1:
addi $sp,$sp,-12
sw $ra,8($sp)
sw $fp,4($sp)
move $fp,$sp
lw $t0,count
li $t1,1
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
sw $t0,count
move $sp,$fp
lw $ra,8($sp)
lw $fp,4($sp)
jr $ra
addi $sp,$sp,12
FibonA:
addi $sp,$sp,-36
sw $ra,32($sp)
sw $fp,28($sp)
move $fp,$sp
lw $t0,36($fp)
sw $t0,24($fp)
if6:
lw $t0,24($fp)
li $t1,10
bne $t0,$t1,endif6
move $sp,$fp
lw $ra,32($sp)
lw $fp,28($sp)
jr $ra
addi $sp,$sp,36
endif6:
lw $t0,24($fp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,20($fp)
lw $t0,20($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,16($fp)
lw $t0,24($fp)
li $t1,2
sub $t2,$t0,$t1
sw $t2,12($fp)
lw $t0,12($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,8($fp)
lw $t0,16($fp)
lw $t1,8($fp)
add $t2,$t0,$t1
sw $t2,4($fp)
lw $t0,24($fp)
lw $t1,4($fp)
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,24($fp)
li $t1,1
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal FibonA
addi $sp,$sp,4
move $sp,$fp
lw $ra,32($sp)
lw $fp,28($sp)
jr $ra
addi $sp,$sp,36
main:
addi $sp,$sp,-336
sw $ra,332($sp)
sw $fp,328($sp)
move $fp,$sp
li $t0,10
sw $t0,324($fp)
li $t0,20
sw $t0,320($fp)
li $t0,'c'
sb $t0,316($fp)
li $t0,0
sw $t0,236($fp)
li $t0,'S'
sb $t0,240($fp)
li $t0,0
sw $t0,292($fp)
jal count_1
while0:
lw $t0,292($fp)
li $t1,5
sub $t2,$t0,$t1
bgez $t2,endwhile0
li $v0,5
syscall
move $t0,$v0
sw $t0,268($fp)
li $v0,12
syscall
move $t0,$v0
sb $t0,260($fp)
lw $t0,292($fp)
lw $t1,268($fp)
sll $t0,$t0,2
addi $t2,$fp,296
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,292($fp)
lb $t1,260($fp)
addi $t2,$fp,272
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,292($fp)
li $t1,1
add $t2,$t0,$t1
sw $t2,232($fp)
lw $t0,232($fp)
sw $t0,292($fp)
j while0
endwhile0:
li $v0,12
syscall
move $t0,$v0
sb $t0,_a__A_
li $v0,5
syscall
move $t0,$v0
sw $t0,252($fp)
li $v0,5
syscall
move $t0,$v0
sw $t0,248($fp)
li $v0,5
syscall
move $t0,$v0
sw $t0,244($fp)
jal count_1
li $t0,2
sw $t0,256($fp)
li $t0,0
li $t1,0
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
li $t0,1
li $t1,1
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,256($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal FibonA
addi $sp,$sp,4
li $t0,0
sw $t0,292($fp)
while1:
lw $t0,292($fp)
li $t1,10
sub $t2,$t0,$t1
bgez $t2,endwhile1
lw $t0,292($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,228($fp)
la $a0,Str0
li $v0,4
syscall
lw $a0,228($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,292($fp)
li $t1,1
add $t2,$t0,$t1
sw $t2,224($fp)
lw $t0,224($fp)
sw $t0,292($fp)
j while1
endwhile1:
jal count_1
jal fun_void
jal count_1
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
switch0:
swi0csa:
lb $t0,_a__A_
li $t1,'a'
bne $t0,$t1,swi0csb
if7:
lw $t0,252($fp)
beq $t0,$0,endif7
la $a0,Str1
li $v0,4
syscall
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif7:
switch1:
swi1cs0:
lw $t0,236($fp)
li $t1,0
bne $t0,$t1,swi1csdef
la $a0,Str2
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
j endswitch1
swi1csdef:
la $a0,Str3
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endswitch1:
j endswitch0
swi0csb:
lb $t0,_a__A_
li $t1,'b'
bne $t0,$t1,swi0csc
if8:
lw $t0,252($fp)
beq $t0,$0,endif8
la $a0,Str4
li $v0,4
syscall
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif8:
j endswitch0
swi0csc:
lb $t0,_a__A_
li $t1,'c'
bne $t0,$t1,swi0csdef
if9:
lw $t0,252($fp)
beq $t0,$0,endif9
la $a0,Str5
li $v0,4
syscall
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endif9:
j endswitch0
swi0csdef:
la $a0,Str6
li $v0,4
syscall
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
endswitch0:
jal count_1
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,2
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,3
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,4
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,5
addi $sp,$sp,-4
sw $t0,0($sp)
jal add_s
addi $sp,$sp,20
jal count_1
if10:
lw $t0,248($fp)
lw $t1,244($fp)
sub $t2,$t0,$t1
bltz $t2,endif10
la $a0,Str7
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif10:
if11:
lw $t0,248($fp)
li $t1,1
add $t2,$t0,$t1
sw $t2,220($fp)
li $t0,2
lw $t1,244($fp)
mult $t0,$t1
mflo $t2
sw $t2,216($fp)
lw $t0,220($fp)
lw $t1,216($fp)
sub $t2,$t0,$t1
bgtz $t2,endif11
la $a0,Str8
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif11:
if12:
lw $t0,248($fp)
li $t1,10
bne $t0,$t1,endif12
la $a0,Str9
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif12:
if13:
lw $t0,248($fp)
lw $t1,244($fp)
beq $t0,$t1,endif13
la $a0,Str10
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif13:
if14:
li $t0,2
lw $t1,244($fp)
mult $t0,$t1
mflo $t2
sw $t2,212($fp)
lw $t0,248($fp)
lw $t1,212($fp)
sub $t2,$t0,$t1
bgez $t2,endif14
la $a0,Str11
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif14:
if15:
lw $t0,248($fp)
lw $t1,244($fp)
sub $t2,$t0,$t1
blez $t2,endif15
la $a0,Str12
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif15:
if16:
lw $t0,248($fp)
lw $t1,244($fp)
add $t2,$t0,$t1
sw $t2,208($fp)
lw $t0,208($fp)
beq $t0,$0,endif16
la $a0,Str13
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif16:
jal count_1
lw $t0,248($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,244($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal funct_add
move $t4,$v0
sw $t4,204($fp)
addi $sp,$sp,8
la $a0,Str14
li $v0,4
syscall
lw $a0,204($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
lb $t0,A1
lb $t1,B1
add $t2,$t0,$t1
sw $t2,200($fp)
lw $t0,200($fp)
lb $t1,C1
add $t2,$t0,$t1
sw $t2,196($fp)
lw $t0,196($fp)
lb $t1,D1
add $t2,$t0,$t1
sw $t2,192($fp)
lw $t0,192($fp)
lb $t1,E1
add $t2,$t0,$t1
sw $t2,188($fp)
lw $t0,188($fp)
lb $t1,F1
add $t2,$t0,$t1
sw $t2,184($fp)
lw $t0,184($fp)
lb $t1,G1
add $t2,$t0,$t1
sw $t2,180($fp)
lw $t0,180($fp)
lb $t1,H1
add $t2,$t0,$t1
sw $t2,176($fp)
lw $a0,176($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
lw $t0,244($fp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,172($fp)
lw $t0,248($fp)
lw $t1,172($fp)
mult $t0,$t1
mflo $t2
sw $t2,168($fp)
lw $t0,248($fp)
lw $t1,168($fp)
add $t2,$t0,$t1
sw $t2,164($fp)
lw $t0,164($fp)
sw $t0,244($fp)
lw $t0,248($fp)
lw $t1,244($fp)
add $t2,$t0,$t1
sw $t2,160($fp)
lw $t0,160($fp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,156($fp)
lw $t0,156($fp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,152($fp)
la $a0,Str15
li $v0,4
syscall
lw $a0,152($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,a1
lw $t1,d1
add $t2,$t0,$t1
sw $t2,148($fp)
lw $t0,148($fp)
lw $t1,e1
add $t2,$t0,$t1
sw $t2,144($fp)
lw $a0,144($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,f1
lw $t1,g1
add $t2,$t0,$t1
sw $t2,140($fp)
lw $a0,140($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,248($fp)
lw $t1,244($fp)
add $t2,$t0,$t1
sw $t2,136($fp)
li $t0,0
lw $t1,136($fp)
sub $t2,$t0,$t1
sw $t2,136($fp)
lw $t0,136($fp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,132($fp)
lw $t0,132($fp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,128($fp)
lw $t0,248($fp)
lw $t1,244($fp)
mult $t0,$t1
mflo $t2
sw $t2,124($fp)
lw $t0,124($fp)
li $t1,2
div $t0,$t1
mflo $t2
sw $t2,120($fp)
lw $t0,128($fp)
lw $t1,120($fp)
add $t2,$t0,$t1
sw $t2,116($fp)
lw $t0,292($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,112($fp)
addi $sp,$sp,8
lw $t0,112($fp)
li $t1,2
mult $t0,$t1
mflo $t2
sw $t2,108($fp)
lw $t0,116($fp)
lw $t1,108($fp)
sub $t2,$t0,$t1
sw $t2,104($fp)
li $t0,1
sll $t0,$t0,2
addi $t1,$fp,296
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,100($fp)
lw $t0,100($fp)
li $t1,2
mult $t0,$t1
mflo $t2
sw $t2,96($fp)
lw $t0,96($fp)
li $t1,3
div $t0,$t1
mflo $t2
sw $t2,92($fp)
li $t0,0
sll $t0,$t0,2
addi $t1,$fp,296
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,88($fp)
lw $t0,92($fp)
lw $t1,88($fp)
mult $t0,$t1
mflo $t2
sw $t2,84($fp)
lw $t0,104($fp)
lw $t1,84($fp)
add $t2,$t0,$t1
sw $t2,80($fp)
lw $t0,80($fp)
li $t1,'a'
add $t2,$t0,$t1
sw $t2,76($fp)
lw $t0,76($fp)
li $t1,10
sub $t2,$t0,$t1
sw $t2,72($fp)
la $a0,Str16
li $v0,4
syscall
lw $a0,72($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
la $a0,Str17
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
li $a0,1
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $a0,'a'
li $v0,11
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
la $a0,Str19
li $v0,4
syscall
lw $a0,count
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
sll $t0,$t0,2
addi $t1,$fp,296
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,68($fp)
lw $t0,68($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
sll $t0,$t0,2
addi $t1,$fp,296
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,64($fp)
lw $t0,64($fp)
li $t1,1
add $t2,$t0,$t1
sw $t2,60($fp)
lw $t0,60($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,56($fp)
addi $sp,$sp,8
la $a0,Str20
li $v0,4
syscall
lw $a0,56($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
addi $t1,$fp,272
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,52($fp)
lb $a0,52($fp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
addi $t1,$fp,272
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,48($fp)
lb $t0,48($fp)
addi $sp,$sp,-4
sb $t0,0($sp)
jal trans_case
move $t4,$v0
sb $t4,44($fp)
addi $sp,$sp,4
lw $t0,44($fp)
li $t1,10
mult $t0,$t1
mflo $t2
sw $t2,40($fp)
lw $t0,40($fp)
li $t1,2
div $t0,$t1
mflo $t2
sw $t2,36($fp)
lw $a0,36($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,2
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,32($fp)
addi $sp,$sp,8
lw $a0,32($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,5
sw $t0,292($fp)
while2:
li $t0,2
lw $t1,292($fp)
mult $t0,$t1
mflo $t2
sw $t2,28($fp)
lw $t0,28($fp)
lw $t1,292($fp)
sub $t2,$t0,$t1
sw $t2,24($fp)
lw $t0,24($fp)
beq $t0,$0,endwhile2
lw $t0,292($fp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,20($fp)
lw $t0,20($fp)
addi $t1,$fp,272
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,16($fp)
lb $t0,16($fp)
addi $sp,$sp,-4
sb $t0,0($sp)
jal trans_case
move $t4,$v0
sb $t4,12($fp)
addi $sp,$sp,4
lb $a0,12($fp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,292($fp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,8($fp)
sw $t0,292($fp)
j while2
endwhile2:
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,4($fp)
addi $sp,$sp,8
lw $t0,4($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,0($fp)
addi $sp,$sp,8
lw $a0,0($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $sp,$fp
lw $ra,332($sp)
lw $fp,328($sp)
jr $ra
addi $sp,$sp,336