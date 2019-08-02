.data
.text
jal main
li $v0,10
syscall
main:
addi $sp,$sp,-20
sw $ra,16($sp)
sw $fp,12($sp)
move $fp,$sp
addi $sp,$sp,-4
li $t0,1
sw $t0,0($sp)
addi $sp,$sp,-4
li $t1,2
sw $t1,0($sp)
jal add
addi $sp,$sp,8
move $a0,$v0
li $v0,1
syscall
move $sp,$fp
lw $ra,16($sp)
lw $fp,12($sp)
jr $ra
addi $sp,$sp,20
add:
addi $sp,$sp,-20
sw $ra,16($sp)
sw $fp,12($sp)
move $fp,$sp
lw $t0,24($fp)
lw $t1,20($fp)
sw $t0,4($fp)
sw $t1,8($fp)
lw $t0,4($fp)
lw $t1,8($fp)
add $t0,$t1,$t0
move $v0,$t0
move $sp,$fp
lw $ra,16($sp)
lw $fp,12($sp)
jr $ra
addi $sp,$sp,20
