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
Fibonaq:  .space   40
count:   .word   0
_a__A_:   .byte
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
  li $a0,1
  li $a1,2
  jal funct_add
  move $a0,$v0
  li $v0,1
  syscall
  li $v0,10
  syscall
add:
addi $sp,$sp,-20
sw $ra,16($sp)
sw $a0,12($sp)
sw $a1,8($sp)
li $t0,0
sw $t0,4($sp)
lw $t0,12($sp)
lw $t1,8($sp)
add $t1,$t0,$t1
sw $t1,0($sp)
lw $t0,0($sp)
move $v0,$t0
lw $ra,16($sp)
addi $sp,$sp,20
jr $ra
funct_add:
addi $sp,$sp,-40
sw $ra,36($sp)
sw $a0,32($sp)
sw $a1,28($sp)
li $t0,0
li $t1,'Z'
addi $t2,$sp,22
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
li $t1,'0'
addi $t2,$sp,22
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,32($sp)
lw $t1,28($sp)
mult $t0,$t1
mflo $t1
sw $t1,18($sp)
lw $t0,18($sp)
sw $t0,24($sp)
sw $t0,32($sp)
move $a0,$t0
sw $t0,28($sp)
move $a1,$t0
jal add
move $t4,$v0
sw $t4,14($sp)
lw $t0,24($sp)
lw $t1,14($sp)
add $t1,$t0,$t1
sw $t1,10($sp)
li $t0,1
addi $t1,$sp,22
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,9($sp)
lw $t0,10($sp)
lw $t1,9($sp)
sub $t1,$t0,$t1
sw $t1,5($sp)
li $t0,0
addi $t1,$sp,22
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,4($sp)
lw $t0,5($sp)
lw $t1,4($sp)
add $t1,$t0,$t1
sw $t1,0($sp)
lw $t0,0($sp)
move $v0,$t0
lw $ra,36($sp)
addi $sp,$sp,40
jr $ra
