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
d1:   .word   0
e1:   .word   0
f1:   .word   5
g1:   .word   10
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
add:
addi $sp,$sp,-20
sw $ra,16($sp)
lw $t0,0($fp)
sw $t0,8($sp)
lw $t0,4($fp)
sw $t0,12($sp)
li $t0,0
sw $t0,4($sp)
lw $t0,12($sp)
lw $t1,8($sp)
add $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
move $v0,$t0
lw $ra,16($sp)
addi $sp,$sp,20
jr $ra
ret1:
addi $sp,$sp,-8
sw $ra,4($sp)
lw $t0,0($fp)
sw $t0,0($sp)
if0:
lw $t0,0($sp)
li $t1,1
bne $t0,$t1,endif0
li $t0,1
move $v0,$t0
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra
endif0:
if1:
lw $t0,0($sp)
li $t1,0
bne $t0,$t1,endif1
li $t0,'a'
move $v0,$t0
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra
endif1:
fun_void:
addi $sp,$sp,-16
sw $ra,12($sp)
li $t0,10
sw $t0,8($sp)
lw $ra,12($sp)
addi $sp,$sp,16
jr $ra
funct_add:
addi $sp,$sp,-52
sw $ra,48($sp)
lw $t0,0($fp)
sw $t0,40($sp)
lw $t0,4($fp)
sw $t0,44($sp)
li $t0,0
li $t1,'Z'
addi $t2,$sp,28
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
li $t1,'0'
addi $t2,$sp,28
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,44($sp)
lw $t1,40($sp)
mult $t0,$t1
mflo $t2
sw $t2,24($sp)
lw $t0,24($sp)
sw $t0,36($sp)
lw $t0,44($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,40($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal add
move $t4,$v0
sw $t4,20($sp)
addi $sp,$sp,8
move $fp,$sp
lw $t0,36($sp)
lw $t1,20($sp)
add $t2,$t0,$t1
sw $t2,16($sp)
li $t0,1
addi $t1,$sp,28
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,12($sp)
lw $t0,16($sp)
lw $t1,12($sp)
sub $t2,$t0,$t1
sw $t2,8($sp)
li $t0,0
addi $t1,$sp,28
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,4($sp)
lw $t0,8($sp)
lw $t1,4($sp)
add $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
move $v0,$t0
lw $ra,48($sp)
addi $sp,$sp,52
jr $ra
trans_case:
addi $sp,$sp,-24
sw $ra,20($sp)
lw $t0,0($fp)
sw $t0,16($sp)
if2:
lw $t0,16($sp)
li $t1,'A'
sub $t2,$t0,$t1
bltz $t2,endif2
if3:
lw $t0,16($sp)
li $t1,'Z'
sub $t2,$t0,$t1
bgtz $t2,endif3
lw $t0,16($sp)
li $t1,'a'
add $t2,$t0,$t1
sw $t2,12($sp)
lw $t0,12($sp)
li $t1,'A'
sub $t2,$t0,$t1
sw $t2,8($sp)
lw $t0,8($sp)
move $v0,$t0
lw $ra,20($sp)
addi $sp,$sp,24
jr $ra
endif3:
endif2:
if4:
lw $t0,16($sp)
li $t1,'a'
sub $t2,$t0,$t1
bltz $t2,endif4
if5:
lw $t0,16($sp)
li $t1,'z'
sub $t2,$t0,$t1
bgtz $t2,endif5
li $t0,'a'
li $t1,'A'
sub $t2,$t0,$t1
sw $t2,4($sp)
lw $t0,16($sp)
lw $t1,4($sp)
sub $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
move $v0,$t0
lw $ra,20($sp)
addi $sp,$sp,24
jr $ra
endif5:
endif4:
count_1:
addi $sp,$sp,-8
sw $ra,4($sp)
lw $t0,count
li $t1,1
add $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
sw $t0,count
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra
FibonA:
addi $sp,$sp,-32
sw $ra,28($sp)
lw $t0,0($fp)
sw $t0,24($sp)
if6:
lw $t0,24($sp)
li $t1,10
bne $t0,$t1,endif6
lw $ra,28($sp)
addi $sp,$sp,32
jr $ra
endif6:
lw $t0,24($sp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,20($sp)
lw $t0,20($sp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,16($sp)
lw $t0,24($sp)
li $t1,2
sub $t2,$t0,$t1
sw $t2,12($sp)
lw $t0,12($sp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,8($sp)
lw $t0,16($sp)
lw $t1,8($sp)
add $t2,$t0,$t1
sw $t2,4($sp)
lw $t0,24($sp)
lw $t1,4($sp)
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,24($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal FibonA
addi $sp,$sp,4
move $fp,$sp
lw $ra,28($sp)
addi $sp,$sp,32
jr $ra
main:
addi $sp,$sp,-340
sw $ra,336($sp)
li $t0,10
sw $t0,332($sp)
li $t0,20
sw $t0,328($sp)
li $t0,'c'
sb $t0,324($sp)
li $t0,0
sw $t0,244($sp)
li $t0,'S'
sb $t0,248($sp)
li $t0,0
sw $t0,300($sp)
move $fp,$sp
jal count_1
move $fp,$sp
while0:
lw $t0,300($sp)
li $t1,5
sub $t2,$t0,$t1
bgez $t2,endwhile0
li $v0,5
syscall
move $t0,$v0
sw $t0,276($sp)
li $v0,12
syscall
move $t0,$v0
sb $t0,268($sp)
lw $t0,300($sp)
lw $t1,276($sp)
sll $t0,$t0,2
addi $t2,$sp,304
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,300($sp)
lb $t1,268($sp)
addi $t2,$sp,280
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,300($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,240($sp)
lw $t0,240($sp)
sw $t0,300($sp)
j while0
endwhile0:
li $v0,12
syscall
move $t0,$v0
sb $t0,_a__A_
li $v0,5
syscall
move $t0,$v0
sw $t0,260($sp)
li $v0,5
syscall
move $t0,$v0
sw $t0,256($sp)
li $v0,5
syscall
move $t0,$v0
sw $t0,252($sp)
move $fp,$sp
jal count_1
move $fp,$sp
li $t0,2
sw $t0,264($sp)
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
lw $t0,264($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal FibonA
addi $sp,$sp,4
move $fp,$sp
li $t0,0
sw $t0,300($sp)
while1:
lw $t0,300($sp)
li $t1,10
sub $t2,$t0,$t1
bgez $t2,endwhile1
lw $t0,300($sp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,236($sp)
la $a0,Str0
li $v0,4
syscall
lw $a0,236($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,300($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,232($sp)
lw $t0,232($sp)
sw $t0,300($sp)
j while1
endwhile1:
move $fp,$sp
jal count_1
move $fp,$sp
move $fp,$sp
jal fun_void
move $fp,$sp
move $fp,$sp
jal count_1
move $fp,$sp
lb $a0,_a__A_
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
switch0:
swi0csa:
lw $t0,_a__A_
li $t1,'a'
bne $t0,$t1,swi0csb
if7:
lw $t0,260($sp)
bne $t0,$0,endif7
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
lw $t0,244($sp)
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
lw $t0,_a__A_
li $t1,'b'
bne $t0,$t1,swi0csc
if8:
lw $t0,260($sp)
bne $t0,$0,endif8
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
lw $t0,_a__A_
li $t1,'c'
bne $t0,$t1,swi0csdef
if9:
lw $t0,260($sp)
bne $t0,$0,endif9
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
move $fp,$sp
jal count_1
move $fp,$sp
if10:
lw $t0,256($sp)
lw $t1,252($sp)
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
lw $t0,256($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,228($sp)
li $t0,2
lw $t1,252($sp)
mult $t0,$t1
mflo $t2
sw $t2,224($sp)
lw $t0,228($sp)
lw $t1,224($sp)
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
lw $t0,256($sp)
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
lw $t0,256($sp)
lw $t1,252($sp)
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
lw $t1,252($sp)
mult $t0,$t1
mflo $t2
sw $t2,220($sp)
lw $t0,256($sp)
lw $t1,220($sp)
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
lw $t0,256($sp)
lw $t1,252($sp)
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
lw $t0,256($sp)
lw $t1,252($sp)
add $t2,$t0,$t1
sw $t2,216($sp)
lw $t0,216($sp)
bne $t0,$0,endif16
la $a0,Str13
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif16:
move $fp,$sp
jal count_1
move $fp,$sp
lw $t0,256($sp)
li $t1,100
add $t2,$t0,$t1
sw $t2,212($sp)
lw $t0,212($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,252($sp)
li $t1,2
mult $t0,$t1
mflo $t2
sw $t2,208($sp)
lw $t0,208($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal add
move $t4,$v0
sw $t4,204($sp)
addi $sp,$sp,8
move $fp,$sp
lw $a0,204($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $fp,$sp
jal count_1
move $fp,$sp
lw $t0,256($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,252($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal funct_add
move $t4,$v0
sw $t4,200($sp)
addi $sp,$sp,8
move $fp,$sp
la $a0,Str14
li $v0,4
syscall
lw $a0,200($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $fp,$sp
jal count_1
move $fp,$sp
lb $t0,A1
lb $t1,B1
add $t2,$t0,$t1
sw $t2,196($sp)
lw $t0,196($sp)
lb $t1,C1
add $t2,$t0,$t1
sw $t2,192($sp)
lw $t0,192($sp)
lb $t1,D1
add $t2,$t0,$t1
sw $t2,188($sp)
lw $t0,188($sp)
lb $t1,E1
add $t2,$t0,$t1
sw $t2,184($sp)
lw $t0,184($sp)
lb $t1,F1
add $t2,$t0,$t1
sw $t2,180($sp)
lw $t0,180($sp)
lb $t1,G1
add $t2,$t0,$t1
sw $t2,176($sp)
lw $t0,176($sp)
lb $t1,H1
add $t2,$t0,$t1
sw $t2,172($sp)
lw $a0,172($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $fp,$sp
jal count_1
move $fp,$sp
lw $t0,252($sp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,168($sp)
lw $t0,256($sp)
lw $t1,168($sp)
mult $t0,$t1
mflo $t2
sw $t2,164($sp)
lw $t0,256($sp)
lw $t1,164($sp)
add $t2,$t0,$t1
sw $t2,160($sp)
lw $t0,160($sp)
sw $t0,252($sp)
lw $t0,256($sp)
lw $t1,252($sp)
add $t2,$t0,$t1
sw $t2,156($sp)
lw $t0,156($sp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,152($sp)
lw $t0,152($sp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,148($sp)
la $a0,Str15
li $v0,4
syscall
lw $a0,148($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,a1
lw $t1,d1
add $t2,$t0,$t1
sw $t2,144($sp)
lw $t0,144($sp)
lw $t1,e1
add $t2,$t0,$t1
sw $t2,140($sp)
lw $a0,140($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,f1
lw $t1,g1
add $t2,$t0,$t1
sw $t2,136($sp)
lw $a0,136($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,256($sp)
lw $t1,252($sp)
add $t2,$t0,$t1
sw $t2,132($sp)
li $t0,0
lw $t1,132($sp)
sub $t2,$t0,$t1
sw $t2,132($sp)
lw $t0,132($sp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,128($sp)
lw $t0,128($sp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,124($sp)
lw $t0,256($sp)
lw $t1,252($sp)
mult $t0,$t1
mflo $t2
sw $t2,120($sp)
lw $t0,120($sp)
li $t1,2
div $t0,$t1
mflo $t2
sw $t2,116($sp)
lw $t0,124($sp)
lw $t1,116($sp)
add $t2,$t0,$t1
sw $t2,112($sp)
lw $t0,300($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal add
move $t4,$v0
sw $t4,108($sp)
addi $sp,$sp,8
move $fp,$sp
lw $t0,108($sp)
li $t1,2
mult $t0,$t1
mflo $t2
sw $t2,104($sp)
lw $t0,112($sp)
lw $t1,104($sp)
sub $t2,$t0,$t1
sw $t2,100($sp)
li $t0,1
sll $t0,$t0,2
addi $t1,$sp,304
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,96($sp)
lw $t0,96($sp)
li $t1,2
mult $t0,$t1
mflo $t2
sw $t2,92($sp)
lw $t0,92($sp)
li $t1,3
div $t0,$t1
mflo $t2
sw $t2,88($sp)
li $t0,0
sll $t0,$t0,2
addi $t1,$sp,304
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,84($sp)
lw $t0,88($sp)
lw $t1,84($sp)
mult $t0,$t1
mflo $t2
sw $t2,80($sp)
lw $t0,100($sp)
lw $t1,80($sp)
add $t2,$t0,$t1
sw $t2,76($sp)
lw $t0,76($sp)
li $t1,'a'
add $t2,$t0,$t1
sw $t2,72($sp)
lw $t0,72($sp)
li $t1,10
sub $t2,$t0,$t1
sw $t2,68($sp)
la $a0,Str16
li $v0,4
syscall
lw $a0,68($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
move $fp,$sp
jal count_1
move $fp,$sp
la $a0,Str17
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
move $fp,$sp
jal count_1
move $fp,$sp
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
addi $t1,$sp,304
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,64($sp)
lw $t0,64($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
sll $t0,$t0,2
addi $t1,$sp,304
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,60($sp)
lw $t0,60($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,56($sp)
lw $t0,56($sp)
addi $sp,$sp,-4
sw $t0,0($sp)
move $fp,$sp
jal add
move $t4,$v0
sw $t4,52($sp)
addi $sp,$sp,8
move $fp,$sp
la $a0,Str20
li $v0,4
syscall
lw $a0,52($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
addi $t1,$sp,280
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,48($sp)
lb $a0,48($sp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
addi $t1,$sp,280
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,44($sp)
lb $t0,44($sp)
addi $sp,$sp,-4
sb $t0,0($sp)
move $fp,$sp
jal trans_case
move $t4,$v0
sb $t4,40($sp)
addi $sp,$sp,4
move $fp,$sp
lw $t0,40($sp)
li $t1,10
mult $t0,$t1
mflo $t2
sw $t2,36($sp)
lw $t0,36($sp)
li $t1,2
div $t0,$t1
mflo $t2
sw $t2,32($sp)
lw $a0,32($sp)
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
move $fp,$sp
jal add
move $t4,$v0
sw $t4,28($sp)
addi $sp,$sp,8
move $fp,$sp
lw $a0,28($sp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,5
sw $t0,300($sp)
while2:
li $t0,2
lw $t1,300($sp)
mult $t0,$t1
mflo $t2
sw $t2,24($sp)
lw $t0,24($sp)
lw $t1,300($sp)
sub $t2,$t0,$t1
sw $t2,20($sp)
lw $t0,20($sp)
li $t1,0
sub $t2,$t0,$t1
blez $t2,endwhile2
lw $t0,300($sp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,16($sp)
lw $t0,16($sp)
addi $t1,$sp,280
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,12($sp)
lb $t0,12($sp)
addi $sp,$sp,-4
sb $t0,0($sp)
move $fp,$sp
jal trans_case
move $t4,$v0
sb $t4,8($sp)
addi $sp,$sp,4
move $fp,$sp
lb $a0,8($sp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,300($sp)
li $t1,1
sub $t2,$t0,$t1
sw $t2,4($sp)
lw $t0,4($sp)
sw $t0,300($sp)
while3:
lw $t0,244($sp)
li $t1,0
bne $t0,$t1,endwhile3
lw $t0,244($sp)
li $t1,1
add $t2,$t0,$t1
sw $t2,0($sp)
lw $t0,0($sp)
sw $t0,244($sp)
j while3
endwhile3:
j while2
endwhile2:
lw $ra,336($sp)
addi $sp,$sp,340
jr $ra