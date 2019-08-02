.text
li $v0,5
syscall
move $s1,$v0
li $v0,12
syscall

move $s2,$v0
li $v0,5
syscall
move $s3,$v0
li $v0,5
syscall
move $s4,$v0
move $a0,$s1
li $v0,1
syscall
move $a0,$s2
li $v0,11
syscall
li $v0,10
syscall