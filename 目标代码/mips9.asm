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
huang_test:   .space   3
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
addi $sp,$sp,-28
sw $ra,24($sp)
sw $fp,20($sp)
move $fp,$sp
lw $t0,28($fp)
sw $t0,16($fp)
if0:
li $t0,1
sw $t0,12($fp)
lw $t0,16($fp)
lw $t1,12($fp)
bne $t0,$t1,endif0
li $t0,1
sw $t0,8($fp)
lw $t0,8($fp)
move $v0,$t0
move $sp,$fp
lw $ra,24($sp)
lw $fp,20($sp)
jr $ra
addi $sp,$sp,28
endif0:
if1:
li $t0,0
sw $t0,4($fp)
lw $t0,16($fp)
lw $t1,4($fp)
bne $t0,$t1,endif1
li $t0,'a'
sb $t0,0($fp)
lb $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,24($sp)
lw $fp,20($sp)
jr $ra
addi $sp,$sp,28
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
addi $sp,$sp,-80
sw $ra,76($sp)
sw $fp,72($sp)
move $fp,$sp
lw $t0,80($fp)
sw $t0,64($fp)
lw $t0,84($fp)
sw $t0,68($fp)
li $t0,0
sw $t0,48($fp)
li $t0,'Z'
sb $t0,44($fp)
lw $t0,48($fp)
lb $t1,44($fp)
addi $t2,$fp,52
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
sw $t0,40($fp)
li $t0,'0'
sb $t0,36($fp)
lw $t0,40($fp)
lb $t1,36($fp)
addi $t2,$fp,52
add $t2,$t2,$t0
sb $t1,0($t2)
lw $t0,68($fp)
lw $t1,64($fp)
mult $t0,$t1
mflo $t2
sw $t2,32($fp)
lw $t0,32($fp)
sw $t0,60($fp)
lw $t0,68($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,64($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,28($fp)
addi $sp,$sp,8
lw $t0,60($fp)
lw $t1,28($fp)
add $t2,$t0,$t1
sw $t2,24($fp)
li $t0,1
sw $t0,20($fp)
lw $t0,20($fp)
addi $t1,$fp,52
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,16($fp)
lw $t0,24($fp)
lw $t1,16($fp)
sub $t2,$t0,$t1
sw $t2,12($fp)
li $t0,0
sw $t0,8($fp)
lw $t0,8($fp)
addi $t1,$fp,52
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,4($fp)
lw $t0,12($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,76($sp)
lw $fp,72($sp)
jr $ra
addi $sp,$sp,80
trans_case:
addi $sp,$sp,-60
sw $ra,56($sp)
sw $fp,52($sp)
move $fp,$sp
lw $t0,60($fp)
sw $t0,48($fp)
if2:
li $t0,'A'
sb $t0,44($fp)
lb $t0,48($fp)
lb $t1,44($fp)
sub $t2,$t0,$t1
bltz $t2,endif2
if3:
li $t0,'Z'
sb $t0,40($fp)
lb $t0,48($fp)
lb $t1,40($fp)
sub $t2,$t0,$t1
bgtz $t2,endif3
li $t0,'a'
sb $t0,36($fp)
lw $t0,48($fp)
lw $t1,36($fp)
add $t2,$t0,$t1
sw $t2,32($fp)
li $t0,'A'
sb $t0,28($fp)
lw $t0,32($fp)
lw $t1,28($fp)
sub $t2,$t0,$t1
sw $t2,24($fp)
lw $t0,24($fp)
move $v0,$t0
move $sp,$fp
lw $ra,56($sp)
lw $fp,52($sp)
jr $ra
addi $sp,$sp,60
endif3:
endif2:
if4:
li $t0,'a'
sb $t0,20($fp)
lb $t0,48($fp)
lb $t1,20($fp)
sub $t2,$t0,$t1
bltz $t2,endif4
if5:
li $t0,'z'
sb $t0,16($fp)
lb $t0,48($fp)
lb $t1,16($fp)
sub $t2,$t0,$t1
bgtz $t2,endif5
li $t0,'a'
sb $t0,12($fp)
li $t0,'A'
sb $t0,8($fp)
lw $t0,12($fp)
lw $t1,8($fp)
sub $t2,$t0,$t1
sw $t2,4($fp)
lw $t0,48($fp)
lw $t1,4($fp)
sub $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
move $v0,$t0
move $sp,$fp
lw $ra,56($sp)
lw $fp,52($sp)
jr $ra
addi $sp,$sp,60
endif5:
endif4:
count_1:
addi $sp,$sp,-16
sw $ra,12($sp)
sw $fp,8($sp)
move $fp,$sp
li $t0,1
sw $t0,4($fp)
lw $t0,count
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
sw $t0,count
move $sp,$fp
lw $ra,12($sp)
lw $fp,8($sp)
jr $ra
addi $sp,$sp,16
FibonA:
addi $sp,$sp,-52
sw $ra,48($sp)
sw $fp,44($sp)
move $fp,$sp
lw $t0,52($fp)
sw $t0,40($fp)
if6:
li $t0,10
sw $t0,36($fp)
lw $t0,40($fp)
lw $t1,36($fp)
bne $t0,$t1,endif6
move $sp,$fp
lw $ra,48($sp)
lw $fp,44($sp)
jr $ra
addi $sp,$sp,52
endif6:
li $t0,1
sw $t0,32($fp)
lw $t0,40($fp)
lw $t1,32($fp)
sub $t2,$t0,$t1
sw $t2,28($fp)
lw $t0,28($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,24($fp)
li $t0,2
sw $t0,20($fp)
lw $t0,40($fp)
lw $t1,20($fp)
sub $t2,$t0,$t1
sw $t2,16($fp)
lw $t0,16($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,12($fp)
lw $t0,24($fp)
lw $t1,12($fp)
add $t2,$t0,$t1
sw $t2,8($fp)
lw $t0,40($fp)
lw $t1,8($fp)
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
li $t0,1
sw $t0,4($fp)
lw $t0,40($fp)
lw $t1,4($fp)
add $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal FibonA
addi $sp,$sp,4
move $sp,$fp
lw $ra,48($sp)
lw $fp,44($sp)
jr $ra
addi $sp,$sp,52
fuzhi:
addi $sp,$sp,-32
sw $ra,28($sp)
sw $fp,24($sp)
move $fp,$sp
li $t0,0
sw $t0,20($fp)
li $t0,'c'
sb $t0,16($fp)
lw $t0,20($fp)
lb $t1,16($fp)
la $t2,huang_test
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
sw $t0,12($fp)
li $t0,'d'
sb $t0,8($fp)
lw $t0,12($fp)
lb $t1,8($fp)
la $t2,huang_test
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,2
sw $t0,4($fp)
li $t0,'e'
sb $t0,0($fp)
lw $t0,4($fp)
lb $t1,0($fp)
la $t2,huang_test
add $t2,$t2,$t0
sb $t1,0($t2)
move $sp,$fp
lw $ra,28($sp)
lw $fp,24($sp)
jr $ra
addi $sp,$sp,32
main:
addi $sp,$sp,-524
sw $ra,520($sp)
sw $fp,516($sp)
move $fp,$sp
li $t0,10
sw $t0,512($fp)
li $t0,20
sw $t0,508($fp)
li $t0,'c'
sb $t0,504($fp)
li $t0,0
sw $t0,420($fp)
lw $t0,420($fp)
sw $t0,424($fp)
li $t0,'S'
sb $t0,416($fp)
lb $t0,416($fp)
sb $t0,428($fp)
li $t0,0
sw $t0,412($fp)
lw $t0,412($fp)
sw $t0,480($fp)
jal count_1
while0:
li $t0,5
sw $t0,408($fp)
lw $t0,480($fp)
lw $t1,408($fp)
sub $t2,$t0,$t1
bgez $t2,endwhile0
li $v0,5
syscall
move $t0,$v0
sw $t0,456($fp)
li $v0,12
syscall
move $t0,$v0
sb $t0,448($fp)
lw $t0,480($fp)
lw $t1,456($fp)
sll $t0,$t0,2
addi $t2,$fp,484
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,480($fp)
lb $t1,448($fp)
addi $t2,$fp,460
add $t2,$t2,$t0
sb $t1,0($t2)
li $t0,1
sw $t0,404($fp)
lw $t0,480($fp)
lw $t1,404($fp)
add $t2,$t0,$t1
sw $t2,400($fp)
lw $t0,400($fp)
sw $t0,480($fp)
j while0
endwhile0:
li $v0,12
syscall
move $t0,$v0
sb $t0,_a__A_
li $v0,5
syscall
move $t0,$v0
sw $t0,440($fp)
li $v0,5
syscall
move $t0,$v0
sw $t0,436($fp)
li $v0,5
syscall
move $t0,$v0
sw $t0,432($fp)
jal count_1
li $t0,2
sw $t0,396($fp)
lw $t0,396($fp)
sw $t0,444($fp)
li $t0,0
sw $t0,392($fp)
li $t0,0
sw $t0,388($fp)
lw $t0,392($fp)
lw $t1,388($fp)
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
li $t0,1
sw $t0,384($fp)
li $t0,1
sw $t0,380($fp)
lw $t0,384($fp)
lw $t1,380($fp)
la $t2,Fibonaq
sll $t0,$t0,2
add $t2,$t2,$t0
sw $t1,0($t2)
lw $t0,444($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal FibonA
addi $sp,$sp,4
li $t0,0
sw $t0,376($fp)
lw $t0,376($fp)
sw $t0,480($fp)
while1:
li $t0,10
sw $t0,372($fp)
lw $t0,480($fp)
lw $t1,372($fp)
sub $t2,$t0,$t1
bgez $t2,endwhile1
lw $t0,480($fp)
la $t1,Fibonaq
sll $t0,$t0,2
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,368($fp)
la $a0,Str0
li $v0,4
syscall
lw $a0,368($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,1
sw $t0,364($fp)
lw $t0,480($fp)
lw $t1,364($fp)
add $t2,$t0,$t1
sw $t2,360($fp)
lw $t0,360($fp)
sw $t0,480($fp)
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
lw $t0,440($fp)
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
lw $t0,424($fp)
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
lw $t0,440($fp)
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
lw $t0,440($fp)
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
sw $t0,356($fp)
lw $t0,356($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,2
sw $t0,352($fp)
lw $t0,352($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,3
sw $t0,348($fp)
lw $t0,348($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,4
sw $t0,344($fp)
lw $t0,344($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,5
sw $t0,340($fp)
lw $t0,340($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add_s
addi $sp,$sp,20
jal count_1
if10:
lw $t0,436($fp)
lw $t1,432($fp)
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
li $t0,1
sw $t0,336($fp)
lw $t0,436($fp)
lw $t1,336($fp)
add $t2,$t0,$t1
sw $t2,332($fp)
li $t0,2
sw $t0,328($fp)
lw $t0,328($fp)
lw $t1,432($fp)
mult $t0,$t1
mflo $t2
sw $t2,324($fp)
lw $t0,332($fp)
lw $t1,324($fp)
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
li $t0,10
sw $t0,320($fp)
lw $t0,436($fp)
lw $t1,320($fp)
bne $t0,$t1,endif12
la $a0,Str9
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif12:
if13:
lw $t0,436($fp)
lw $t1,432($fp)
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
sw $t0,316($fp)
lw $t0,316($fp)
lw $t1,432($fp)
mult $t0,$t1
mflo $t2
sw $t2,312($fp)
lw $t0,436($fp)
lw $t1,312($fp)
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
lw $t0,436($fp)
lw $t1,432($fp)
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
lw $t0,436($fp)
lw $t1,432($fp)
add $t2,$t0,$t1
sw $t2,308($fp)
lw $t0,308($fp)
beq $t0,$0,endif16
la $a0,Str13
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
endif16:
jal count_1
lw $t0,436($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
lw $t0,432($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal funct_add
move $t4,$v0
sw $t4,304($fp)
addi $sp,$sp,8
la $a0,Str14
li $v0,4
syscall
lw $a0,304($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
lb $t0,A1
lb $t1,B1
add $t2,$t0,$t1
sw $t2,300($fp)
lw $t0,300($fp)
lb $t1,C1
add $t2,$t0,$t1
sw $t2,296($fp)
lw $t0,296($fp)
lb $t1,D1
add $t2,$t0,$t1
sw $t2,292($fp)
lw $t0,292($fp)
lb $t1,E1
add $t2,$t0,$t1
sw $t2,288($fp)
lw $t0,288($fp)
lb $t1,F1
add $t2,$t0,$t1
sw $t2,284($fp)
lw $t0,284($fp)
lb $t1,G1
add $t2,$t0,$t1
sw $t2,280($fp)
lw $t0,280($fp)
lb $t1,H1
add $t2,$t0,$t1
sw $t2,276($fp)
lw $a0,276($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
jal count_1
li $t0,1
sw $t0,272($fp)
lw $t0,432($fp)
lw $t1,272($fp)
sub $t2,$t0,$t1
sw $t2,268($fp)
lw $t0,436($fp)
lw $t1,268($fp)
mult $t0,$t1
mflo $t2
sw $t2,264($fp)
lw $t0,436($fp)
lw $t1,264($fp)
add $t2,$t0,$t1
sw $t2,260($fp)
lw $t0,260($fp)
sw $t0,432($fp)
li $t0,-1
sw $t0,256($fp)
li $t0,0
lw $t1,256($fp)
sub $t2,$t0,$t1
sw $t2,256($fp)
lw $t0,256($fp)
lw $t1,436($fp)
add $t2,$t0,$t1
sw $t2,252($fp)
lw $t0,252($fp)
lw $t1,432($fp)
add $t2,$t0,$t1
sw $t2,248($fp)
lw $t0,248($fp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,244($fp)
lw $t0,244($fp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,240($fp)
la $a0,Str15
li $v0,4
syscall
lw $a0,240($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,a1
lw $t1,d1
add $t2,$t0,$t1
sw $t2,236($fp)
lw $t0,236($fp)
lw $t1,e1
add $t2,$t0,$t1
sw $t2,232($fp)
lw $a0,232($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,f1
lw $t1,g1
add $t2,$t0,$t1
sw $t2,228($fp)
lw $a0,228($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
lw $t0,436($fp)
lw $t1,432($fp)
add $t2,$t0,$t1
sw $t2,224($fp)
li $t0,0
lw $t1,224($fp)
sub $t2,$t0,$t1
sw $t2,224($fp)
lw $t0,224($fp)
lb $t1,A1
add $t2,$t0,$t1
sw $t2,220($fp)
lw $t0,220($fp)
lb $t1,B1
sub $t2,$t0,$t1
sw $t2,216($fp)
lw $t0,436($fp)
lw $t1,432($fp)
mult $t0,$t1
mflo $t2
sw $t2,212($fp)
li $t0,2
sw $t0,208($fp)
lw $t0,212($fp)
lw $t1,208($fp)
div $t0,$t1
mflo $t2
sw $t2,204($fp)
lw $t0,216($fp)
lw $t1,204($fp)
add $t2,$t0,$t1
sw $t2,200($fp)
lw $t0,480($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
sw $t0,196($fp)
lw $t0,196($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,192($fp)
addi $sp,$sp,8
li $t0,2
sw $t0,188($fp)
lw $t0,192($fp)
lw $t1,188($fp)
mult $t0,$t1
mflo $t2
sw $t2,184($fp)
lw $t0,200($fp)
lw $t1,184($fp)
sub $t2,$t0,$t1
sw $t2,180($fp)
li $t0,1
sw $t0,176($fp)
lw $t0,176($fp)
sll $t0,$t0,2
addi $t1,$fp,484
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,172($fp)
li $t0,2
sw $t0,168($fp)
lw $t0,172($fp)
lw $t1,168($fp)
mult $t0,$t1
mflo $t2
sw $t2,164($fp)
li $t0,3
sw $t0,160($fp)
lw $t0,164($fp)
lw $t1,160($fp)
div $t0,$t1
mflo $t2
sw $t2,156($fp)
li $t0,0
sw $t0,152($fp)
lw $t0,152($fp)
sll $t0,$t0,2
addi $t1,$fp,484
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,148($fp)
lw $t0,156($fp)
lw $t1,148($fp)
mult $t0,$t1
mflo $t2
sw $t2,144($fp)
lw $t0,180($fp)
lw $t1,144($fp)
add $t2,$t0,$t1
sw $t2,140($fp)
li $t0,'a'
sb $t0,136($fp)
lw $t0,140($fp)
lw $t1,136($fp)
add $t2,$t0,$t1
sw $t2,132($fp)
li $t0,10
sw $t0,128($fp)
lw $t0,132($fp)
lw $t1,128($fp)
sub $t2,$t0,$t1
sw $t2,124($fp)
la $a0,Str16
li $v0,4
syscall
lw $a0,124($fp)
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
li $t0,1
sw $t0,120($fp)
lw $a0,120($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,'a'
sb $t0,116($fp)
lb $a0,116($fp)
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
sw $t0,112($fp)
lw $t0,112($fp)
sll $t0,$t0,2
addi $t1,$fp,484
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,108($fp)
lw $t0,108($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,1
sw $t0,104($fp)
lw $t0,104($fp)
sll $t0,$t0,2
addi $t1,$fp,484
add $t1,$t1,$t0
lw $t2,0($t1)
sw $t2,100($fp)
li $t0,1
sw $t0,96($fp)
lw $t0,100($fp)
lw $t1,96($fp)
add $t2,$t0,$t1
sw $t2,92($fp)
lw $t0,92($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,88($fp)
addi $sp,$sp,8
la $a0,Str20
li $v0,4
syscall
lw $a0,88($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
sw $t0,84($fp)
lw $t0,84($fp)
addi $t1,$fp,460
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,80($fp)
lb $a0,80($fp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
li $t0,0
sw $t0,76($fp)
lw $t0,76($fp)
addi $t1,$fp,460
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,72($fp)
lb $t0,72($fp)
addi $sp,$sp,-4
sb $t0,0($sp)
jal trans_case
move $t4,$v0
sb $t4,68($fp)
addi $sp,$sp,4
li $t0,10
sw $t0,64($fp)
lw $t0,68($fp)
lw $t1,64($fp)
mult $t0,$t1
mflo $t2
sw $t2,60($fp)
li $t0,2
sw $t0,56($fp)
lw $t0,60($fp)
lw $t1,56($fp)
div $t0,$t1
mflo $t2
sw $t2,52($fp)
lw $a0,52($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,1
sw $t0,48($fp)
lw $t0,48($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
li $t0,2
sw $t0,44($fp)
lw $t0,44($fp)
addi $sp,$sp,-4
sw $t0,0($sp)
jal add
move $t4,$v0
sw $t4,40($fp)
addi $sp,$sp,8
lw $a0,40($fp)
li $v0,1
syscall
la $a0,enter
li $v0,4
syscall
li $t0,5
sw $t0,36($fp)
lw $t0,36($fp)
sw $t0,480($fp)
while2:
li $t0,2
sw $t0,32($fp)
lw $t0,32($fp)
lw $t1,480($fp)
mult $t0,$t1
mflo $t2
sw $t2,28($fp)
lw $t0,28($fp)
lw $t1,480($fp)
sub $t2,$t0,$t1
sw $t2,24($fp)
lw $t0,24($fp)
beq $t0,$0,endwhile2
li $t0,1
sw $t0,20($fp)
lw $t0,480($fp)
lw $t1,20($fp)
sub $t2,$t0,$t1
sw $t2,16($fp)
lw $t0,16($fp)
addi $t1,$fp,460
add $t1,$t1,$t0
lb $t2,0($t1)
sb $t2,12($fp)
lb $t0,12($fp)
addi $sp,$sp,-4
sb $t0,0($sp)
jal trans_case
move $t4,$v0
sb $t4,8($fp)
addi $sp,$sp,4
lb $a0,8($fp)
li $v0,11
syscall
la $a0,enter
li $v0,4
syscall
li $t0,1
sw $t0,4($fp)
lw $t0,480($fp)
lw $t1,4($fp)
sub $t2,$t0,$t1
sw $t2,0($fp)
lw $t0,0($fp)
sw $t0,480($fp)
j while2
endwhile2:
move $sp,$fp
lw $ra,520($sp)
lw $fp,516($sp)
jr $ra
addi $sp,$sp,524