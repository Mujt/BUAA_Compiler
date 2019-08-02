.data
str_37:  .asciiz  "@#$$&*^^^^test end"
str_36:  .asciiz  "ch="
str_35:  .asciiz  "*********************"
str_34:  .asciiz  "test_scope begin:"
str_33:  .asciiz  "test_relation_operator begin:"
str_32:  .asciiz  "test_symbol begin:"
str_31:  .asciiz  "test_expression begin:"
str_30:  .asciiz  "test_scanf_printf begin:"
str_29:  .asciiz  "test_switch begin:"
str_28:  .asciiz  "test_while begin:"
str_27:  .asciiz  "test_if begin:"
str_26:  .asciiz  "test_recursion begin:"
str_25:  .asciiz  "fail!"
str_24:  .asciiz  "success!"
str_23:  .asciiz  "the global scope_var = "
str_22:  .asciiz  "the global scope_var = "
str_21:  .asciiz  "the local scope_var = "
str_20:  .asciiz  "fail2!"
str_19:  .asciiz  "success!"
str_18:  .asciiz  "fail1!"
str_17:  .asciiz  "fail!"
str_16:  .asciiz  "success!"
str_15:  .asciiz  " x!=y:true"
str_14:  .asciiz  " x<=y:true"
str_13:  .asciiz  " x>=y:true"
str_12:  .asciiz  " x<y:true"
str_11:  .asciiz  " x>y:true"
str_10:  .asciiz  " x==y:true"
str_9:  .asciiz  "Input is:"
str_8:  .asciiz  "fail!"
str_7:  .asciiz  "success!"
str_6:  .asciiz  "fail!"
str_5:  .asciiz  "success!"
str_4:  .asciiz  "fail1!"
str_3:  .asciiz  "success2!"
str_2:  .asciiz  "success1!"
str_1:  .asciiz  "fail!"
str_0:  .asciiz  "success!"
con1:  .word    1
con2:  .word    2
ch1:  .word    95
i:  .word    0
j:  .word    0
array:  .space    400
scope_var:  .word    0
ch:  .word    0
.text
	add  $fp,$0,$sp
	subi $sp,$sp,0 # alloc mem for var 
	j    main

Fibonacci:
	lw   $t1,0($fp) # == 
	li   $t2,1 # == 
	bne  $t1,$t2,if_0
	li   $v0,1 # return value
	jr   $ra
	if_0:
	lw   $t1,0($fp) # == 
	li   $t2,2 # == 
	bne  $t1,$t2,if_1
	li   $v0,1 # return value
	jr   $ra
	if_1:
	lw   $t2,0($fp) # cul n
	li   $t3,1
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-12($fp) # cul store *tvar_0
	lw   $t1,-12($fp) # push *tvar_0
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,12 # set new $fp
	subi $sp,$sp,20 # alloc mem for var 
	jal  Fibonacci #call func
	addi $sp,$sp,20 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,4 # delete para 
	sw   $v0,-16($fp)

	lw   $t2,0($fp) # cul n
	li   $t3,2
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-20($fp) # cul store *tvar_2
	lw   $t1,-20($fp) # push *tvar_2
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,12 # set new $fp
	subi $sp,$sp,20 # alloc mem for var 
	jal  Fibonacci #call func
	addi $sp,$sp,20 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,4 # delete para 
	sw   $v0,-24($fp)

	lw   $t2,-16($fp) # cul *tvar_1
	lw   $t3,-24($fp) # cul *tvar_3
	add  $t1,$t2,$t3 # + 
	sw   $t1,-28($fp) # cul store *tvar_4
	lw   $v0,-28($fp) # return value
	jr   $ra

test_recursion:
	li   $t1,8 #push 8
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,12 # set new $fp
	subi $sp,$sp,20 # alloc mem for var 
	jal  Fibonacci #call func
	addi $sp,$sp,20 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,4 # delete para 
	sw   $v0,-8($fp)

	lw   $t1,-8($fp) # == 
	li   $t2,21 # == 
	bne  $t1,$t2,if_2
	la   $a0,str_0 # print string
	li   $v0,4
	syscall
	li   $v0,0 # return value
	jr   $ra
	if_2:
	la   $a0,str_1 # print string
	li   $v0,4
	syscall
	li   $v0,0 # return value
	jr   $ra

test_if:
	li   $t1,97 # assign 
	sw   $t1,-12($fp) # assign ch
	lw   $t2,-12($fp) # cul ch
	lw   $t3,0($fp) # cul plus
	add  $t1,$t2,$t3 # + 
	sw   $t1,-16($fp) # cul store *tvar_6
	lw   $t1,-16($fp) # > 
	li   $t2,103 # > 
	sub  $t3,$t1,$t2
	blez $t3,if_3
	la   $a0,str_2 # print string
	li   $v0,4
	syscall
	if_3:
	lw   $t1,-12($fp) # != 
	li   $t2,0 # != 
	beq  $t1,$t2,if_4
	la   $a0,str_3 # print string
	li   $v0,4
	syscall
	if_4:
	li   $t1,0 # != 
	li   $t2,0 # != 
	beq  $t1,$t2,if_5
	la   $a0,str_4 # print string
	li   $v0,4
	syscall
	if_5:
	li   $v0,0 # return value
	jr   $ra

test_while:
	li   $t1,0 # assign 
	sw   $t1,-8($fp) # assign sum
	li   $t1,0 # assign 
	la   $t0,i # assign i
	sw   $t1,0($t0)
	while_6:
	la   $t0,i # < 
	lw   $t1,0($t0)
	li   $t2,100 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_7
	la   $t0,i # []= i
	lw   $t1,0($t0)
	la   $t0,i # []= i
	lw   $t2,0($t0)
	mul  $t2,$t2,4
	la   $t3,array # []= array
	add  $t3,$t3,$t2
	sw   $t1,0($t3)
	la   $t0,i # cul i
	lw   $t2,0($t0)
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-12($fp) # cul store *tvar_7
	lw   $t1,-12($fp) # assign *tvar_7
	la   $t0,i # assign i
	sw   $t1,0($t0)
	j    while_6
	while_7:
	li   $t1,0 # assign 
	la   $t0,i # assign i
	sw   $t1,0($t0)
	while_8:
	la   $t0,i # < 
	lw   $t1,0($t0)
	li   $t2,100 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_9
	lw   $t2,-8($fp) # cul sum
	la   $t0,i # cul i
	lw   $t3,0($t0)
	add  $t1,$t2,$t3 # + 
	sw   $t1,-16($fp) # cul store *tvar_8
	lw   $t1,-16($fp) # assign *tvar_8
	sw   $t1,-8($fp) # assign sum
	la   $t0,i # cul i
	lw   $t2,0($t0)
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-20($fp) # cul store *tvar_9
	lw   $t1,-20($fp) # assign *tvar_9
	la   $t0,i # assign i
	sw   $t1,0($t0)
	j    while_8
	while_9:
	lw   $t1,-8($fp) # == 
	li   $t2,4950 # == 
	bne  $t1,$t2,if_10
	la   $a0,str_5 # print string
	li   $v0,4
	syscall
	jr   $ra
	if_10:
	la   $a0,str_6 # print string
	li   $v0,4
	syscall
	jr   $ra

test_switch:
	li   $t1,97 # assign 
	sw   $t1,-8($fp) # assign flag
	lw   $t1,-8($fp) # == 
	li   $t2,97 # == 
	bne  $t1,$t2,case_12
	la   $a0,str_7 # print string
	li   $v0,4
	syscall
	j    switch_11
	case_12:
	la   $a0,str_8 # print string
	li   $v0,4
	syscall
	switch_11:

to_upper:
	lw   $t2,0($fp) # cul a
	lw   $t3,-4($fp) # cul b
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-16($fp) # cul store *tvar_10
	lw   $v0,-16($fp) # return value
	jr   $ra

test_scanf_printf:
	li   $v0,12 # reada
	syscall
	sw   $v0,-8($fp) # read a
	li   $v0,12 # readb
	syscall
	sw   $v0,-12($fp) # read b
	li   $v0,12 # readc
	syscall
	sw   $v0,-16($fp) # read c
	la   $a0,str_9 # print string
	li   $v0,4
	syscall
	lw   $a0,-8($fp) # print a
	li   $v0,11
	syscall
	lw   $a0,-12($fp) # print b
	li   $v0,11
	syscall
	lw   $a0,-16($fp) # print c
	li   $v0,11
	syscall
	lw   $t1,-8($fp) # push a
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	li   $t1,32 #push 32
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  to_upper #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 
	sw   $v0,-20($fp)

	lw   $a0,-20($fp) # print *tvar_11
	li   $v0,1
	syscall
	lw   $t1,-12($fp) # push b
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	li   $t1,32 #push 32
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  to_upper #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 
	sw   $v0,-24($fp)

	lw   $a0,-24($fp) # print *tvar_12
	li   $v0,1
	syscall
	lw   $t1,-16($fp) # push c
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	li   $t1,32 #push 32
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  to_upper #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 
	sw   $v0,-28($fp)

	lw   $a0,-28($fp) # print *tvar_13
	li   $v0,1
	syscall
	jr   $ra

test_relation_operator:
	lw   $t1,0($fp) # == 
	lw   $t2,-4($fp) # == 
	bne  $t1,$t2,if_13
	la   $a0,str_10 # print string
	li   $v0,4
	syscall
	if_13:
	lw   $t1,0($fp) # > 
	lw   $t2,-4($fp) # > 
	sub  $t3,$t1,$t2
	blez $t3,if_14
	la   $a0,str_11 # print string
	li   $v0,4
	syscall
	if_14:
	lw   $t1,0($fp) # < 
	lw   $t2,-4($fp) # < 
	sub  $t3,$t1,$t2
	bgez $t3,if_15
	la   $a0,str_12 # print string
	li   $v0,4
	syscall
	if_15:
	lw   $t1,0($fp) # >= 
	lw   $t2,-4($fp) # >= 
	sub  $t3,$t1,$t2
	bltz $t3,if_16
	la   $a0,str_13 # print string
	li   $v0,4
	syscall
	if_16:
	lw   $t1,0($fp) # <= 
	lw   $t2,-4($fp) # <= 
	sub  $t3,$t1,$t2
	bgtz $t3,if_17
	la   $a0,str_14 # print string
	li   $v0,4
	syscall
	if_17:
	lw   $t1,0($fp) # != 
	lw   $t2,-4($fp) # != 
	beq  $t1,$t2,if_18
	la   $a0,str_15 # print string
	li   $v0,4
	syscall
	if_18:
	jr   $ra

test_expression:
	li   $t1,10 # assign 
	sw   $t1,-8($fp) # assign x
	li   $t1,1 # assign 
	sw   $t1,-12($fp) # assign y
	li   $t2,0
	li   $t3,2
	mul  $t1,$t2,$t3 # * 
	sw   $t1,-24($fp) # cul store *tvar_14
	li   $t1,2 # []= 
	lw   $t2,-24($fp) # []= *tvar_14
	mul  $t2,$t2,4
	addi $t3,$fp,-20 # []= A
	sub  $t3,$t3,$t2
	sw   $t1,0($t3)
	li   $t2,1
	lw   $t3,-8($fp) # cul x
	mul  $t1,$t2,$t3 # * 
	sw   $t1,-28($fp) # cul store *tvar_15
	li   $t2,0 # geta 
	mul  $t2,$t2,4
	addi $t3,$fp,-20 # geta A
	sub  $t3,$t3,$t2
	lw   $t1,0($t3)
	sw   $t1,-32($fp) # geta *tvar_16
	lw   $t2,-28($fp) # cul *tvar_15
	lw   $t3,-32($fp) # cul *tvar_16
	mul  $t1,$t2,$t3 # * 
	sw   $t1,-36($fp) # cul store *tvar_17
	li   $t2,0
	lw   $t3,-12($fp) # cul y
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-40($fp) # cul store *tvar_18
	lw   $t2,-36($fp) # cul *tvar_17
	lw   $t3,-40($fp) # cul *tvar_18
	mul  $t1,$t2,$t3 # * 
	sw   $t1,-44($fp) # cul store *tvar_19
	lw   $t2,-44($fp) # cul *tvar_19
	lw   $t3,-12($fp) # cul y
	mul  $t1,$t2,$t3 # * 
	sw   $t1,-48($fp) # cul store *tvar_20
	lw   $t2,-48($fp) # cul *tvar_20
	li   $t3,2
	div  $t1,$t2,$t3 # / 
	sw   $t1,-52($fp) # cul store *tvar_21
	li   $t2,0
	lw   $t3,-52($fp) # cul *tvar_21
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-56($fp) # cul store *tvar_22
	lw   $t2,-56($fp) # cul *tvar_22
	li   $t3,42
	add  $t1,$t2,$t3 # + 
	sw   $t1,-60($fp) # cul store *tvar_23
	li   $t1,97 #push 97
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	li   $t2,0
	li   $t3,-32
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-64($fp) # cul store *tvar_24
	lw   $t1,-64($fp) # push *tvar_24
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  to_upper #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 
	sw   $v0,-68($fp)

	lw   $t2,-60($fp) # cul *tvar_23
	lw   $t3,-68($fp) # cul *tvar_25
	add  $t1,$t2,$t3 # + 
	sw   $t1,-72($fp) # cul store *tvar_26
	lw   $t2,-72($fp) # cul *tvar_26
	li   $t3,65
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-76($fp) # cul store *tvar_27
	lw   $t2,-8($fp) # cul x
	lw   $t3,-76($fp) # cul *tvar_27
	add  $t1,$t2,$t3 # + 
	sw   $t1,-80($fp) # cul store *tvar_28
	lw   $t1,-80($fp) # assign *tvar_28
	sw   $t1,-16($fp) # assign z
	lw   $t1,-16($fp) # == 
	li   $t2,62 # == 
	bne  $t1,$t2,if_19
	la   $a0,str_16 # print string
	li   $v0,4
	syscall
	jr   $ra
	if_19:
	la   $a0,str_17 # print string
	li   $v0,4
	syscall
	jr   $ra

test_symbol:
	li   $t1,42 # assign 
	sw   $t1,-8($fp) # assign _a1
	li   $t1,47 # assign 
	sw   $t1,-12($fp) # assign _a2
	li   $t1,43 # assign 
	sw   $t1,-16($fp) # assign _a3
	li   $t1,45 # assign 
	sw   $t1,-20($fp) # assign _a4
	li   $t1,95 # assign 
	sw   $t1,-24($fp) # assign _a5
	li   $t1,1 # assign 
	sw   $t1,-28($fp) # assign aa
	li   $t1,0 # assign 
	sw   $t1,-32($fp) # assign Aa
	lw   $t1,-28($fp) # == 
	li   $t2,0 # == 
	bne  $t1,$t2,if_20
	la   $a0,str_18 # print string
	li   $v0,4
	syscall
	if_20:
	li   $t1,0 # assign 
	sw   $t1,-156($fp) # assign i
	lw   $t2,-8($fp) # cul _a1
	lw   $t3,-12($fp) # cul _a2
	add  $t1,$t2,$t3 # + 
	sw   $t1,-164($fp) # cul store *tvar_29
	lw   $t2,-164($fp) # cul *tvar_29
	lw   $t3,-16($fp) # cul _a3
	add  $t1,$t2,$t3 # + 
	sw   $t1,-168($fp) # cul store *tvar_30
	lw   $t2,-168($fp) # cul *tvar_30
	lw   $t3,-20($fp) # cul _a4
	add  $t1,$t2,$t3 # + 
	sw   $t1,-172($fp) # cul store *tvar_31
	lw   $t2,-172($fp) # cul *tvar_31
	lw   $t3,-24($fp) # cul _a5
	add  $t1,$t2,$t3 # + 
	sw   $t1,-176($fp) # cul store *tvar_32
	lw   $t1,-176($fp) # assign *tvar_32
	sw   $t1,-160($fp) # assign sum
	while_21:
	lw   $t1,-156($fp) # < 
	li   $t2,10 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_22
	lw   $t1,-156($fp) # []= i
	lw   $t2,-156($fp) # []= i
	mul  $t2,$t2,4
	addi $t3,$fp,-36 # []= array
	sub  $t3,$t3,$t2
	sw   $t1,0($t3)
	lw   $t2,-156($fp) # cul i
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-180($fp) # cul store *tvar_33
	lw   $t1,-180($fp) # assign *tvar_33
	sw   $t1,-156($fp) # assign i
	j    while_21
	while_22:
	while_23:
	lw   $t1,-156($fp) # < 
	li   $t2,20 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_24
	li   $t2,97
	lw   $t3,-156($fp) # cul i
	add  $t1,$t2,$t3 # + 
	sw   $t1,-184($fp) # cul store *tvar_34
	lw   $t2,-184($fp) # cul *tvar_34
	li   $t3,10
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-188($fp) # cul store *tvar_35
	lw   $t1,-188($fp) # []= *tvar_35
	lw   $t2,-156($fp) # []= i
	mul  $t2,$t2,4
	addi $t3,$fp,-36 # []= array
	sub  $t3,$t3,$t2
	sw   $t1,0($t3)
	lw   $t2,-156($fp) # cul i
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-192($fp) # cul store *tvar_36
	lw   $t1,-192($fp) # assign *tvar_36
	sw   $t1,-156($fp) # assign i
	j    while_23
	while_24:
	while_25:
	lw   $t1,-156($fp) # < 
	li   $t2,30 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_26
	li   $t2,65
	lw   $t3,-156($fp) # cul i
	add  $t1,$t2,$t3 # + 
	sw   $t1,-196($fp) # cul store *tvar_37
	lw   $t2,-196($fp) # cul *tvar_37
	li   $t3,20
	sub  $t1,$t2,$t3 # - 
	sw   $t1,-200($fp) # cul store *tvar_38
	lw   $t1,-200($fp) # []= *tvar_38
	lw   $t2,-156($fp) # []= i
	mul  $t2,$t2,4
	addi $t3,$fp,-36 # []= array
	sub  $t3,$t3,$t2
	sw   $t1,0($t3)
	lw   $t2,-156($fp) # cul i
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-204($fp) # cul store *tvar_39
	lw   $t1,-204($fp) # assign *tvar_39
	sw   $t1,-156($fp) # assign i
	j    while_25
	while_26:
	li   $t1,0 # assign 
	sw   $t1,-156($fp) # assign i
	while_27:
	lw   $t1,-156($fp) # < 
	li   $t2,30 # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_28
	lw   $t2,-156($fp) # geta i
	mul  $t2,$t2,4
	addi $t3,$fp,-36 # geta array
	sub  $t3,$t3,$t2
	lw   $t1,0($t3)
	sw   $t1,-208($fp) # geta *tvar_40
	lw   $t2,-160($fp) # cul sum
	lw   $t3,-208($fp) # cul *tvar_40
	add  $t1,$t2,$t3 # + 
	sw   $t1,-212($fp) # cul store *tvar_41
	lw   $t1,-212($fp) # assign *tvar_41
	sw   $t1,-160($fp) # assign sum
	lw   $t2,-156($fp) # cul i
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-216($fp) # cul store *tvar_42
	lw   $t1,-216($fp) # assign *tvar_42
	sw   $t1,-156($fp) # assign i
	j    while_27
	while_28:
	lw   $t1,-160($fp) # == 
	li   $t2,2027 # == 
	bne  $t1,$t2,if_29
	la   $a0,str_19 # print string
	li   $v0,4
	syscall
	jr   $ra
	if_29:
	la   $a0,str_20 # print string
	li   $v0,4
	syscall
	jr   $ra

local_scope:
	li   $t1,10 # assign 
	sw   $t1,-8($fp) # assign scope_var
	la   $a0,str_21 # print string
	li   $v0,4
	syscall
	lw   $a0,-8($fp) # print scope_var
	li   $v0,1
	syscall

test_scope:
	li   $t1,20 # assign 
	la   $t0,scope_var # assign scope_var
	sw   $t1,0($t0)
	la   $t0,scope_var # assign scope_var
	lw   $t1,0($t0)
	sw   $t1,-8($fp) # assign tem
	la   $a0,str_22 # print string
	li   $v0,4
	syscall
	la   $t0,scope_var # print scope_var
	lw   $a0,0($t0)
	li   $v0,1
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  local_scope #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	la   $a0,str_23 # print string
	li   $v0,4
	syscall
	la   $t0,scope_var # print scope_var
	lw   $a0,0($t0)
	li   $v0,1
	syscall
	lw   $t1,-8($fp) # == 
	la   $t0,scope_var # == 
	lw   $t2,0($t0)
	bne  $t1,$t2,if_30
	la   $a0,str_24 # print string
	li   $v0,4
	syscall
	jr   $ra
	if_30:
	la   $a0,str_25 # print string
	li   $v0,4
	syscall
	jr   $ra

test:
	li   $t1,0 # assign 
	sw   $t1,-12($fp) # assign j
	li   $t1,9 # assign 
	sw   $t1,-16($fp) # assign k
	while_31:
	lw   $t1,-12($fp) # < 
	lw   $t2,-16($fp) # < 
	sub  $t3,$t1,$t2
	bgez $t3,while_32
	li   $v0,5 # readi
	syscall
	sw   $v0,-8($fp) # read i
	lw   $t1,-8($fp) # == 
	li   $t2,0 # == 
	bne  $t1,$t2,case_34
	la   $a0,str_26 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  test_recursion #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_34:
	lw   $t1,-8($fp) # == 
	li   $t2,1 # == 
	bne  $t1,$t2,case_35
	la   $a0,str_27 # print string
	li   $v0,4
	syscall
	li   $t1,20 #push 20
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,12 # set new $fp
	subi $sp,$sp,8 # alloc mem for var 
	jal  test_if #call func
	addi $sp,$sp,8 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,4 # delete para 

	j    switch_33
	case_35:
	lw   $t1,-8($fp) # == 
	li   $t2,2 # == 
	bne  $t1,$t2,case_36
	la   $a0,str_28 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,16 # alloc mem for var 
	jal  test_while #call func
	addi $sp,$sp,16 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_36:
	lw   $t1,-8($fp) # == 
	li   $t2,3 # == 
	bne  $t1,$t2,case_37
	la   $a0,str_29 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  test_switch #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_37:
	lw   $t1,-8($fp) # == 
	li   $t2,4 # == 
	bne  $t1,$t2,case_38
	la   $a0,str_30 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,24 # alloc mem for var 
	jal  test_scanf_printf #call func
	addi $sp,$sp,24 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_38:
	lw   $t1,-8($fp) # == 
	li   $t2,5 # == 
	bne  $t1,$t2,case_39
	la   $a0,str_31 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,76 # alloc mem for var 
	jal  test_expression #call func
	addi $sp,$sp,76 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_39:
	lw   $t1,-8($fp) # == 
	li   $t2,6 # == 
	bne  $t1,$t2,case_40
	la   $a0,str_32 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,212 # alloc mem for var 
	jal  test_symbol #call func
	addi $sp,$sp,212 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_40:
	lw   $t1,-8($fp) # == 
	li   $t2,7 # == 
	bne  $t1,$t2,case_41
	la   $a0,str_33 # print string
	li   $v0,4
	syscall
	la   $t0,con1 # cul con1
	lw   $t2,0($t0)
	li   $t3,2
	add  $t1,$t2,$t3 # + 
	sw   $t1,-20($fp) # cul store *tvar_43
	lw   $t1,-20($fp) # push *tvar_43
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	la   $t0,con2 # cul con2
	lw   $t2,0($t0)
	li   $t3,4
	add  $t1,$t2,$t3 # + 
	sw   $t1,-24($fp) # cul store *tvar_44
	lw   $t1,-24($fp) # push *tvar_44
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,0 # alloc mem for var 
	jal  test_relation_operator #call func
	addi $sp,$sp,0 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 

	la   $t0,con1 # cul con1
	lw   $t2,0($t0)
	li   $t3,6
	add  $t1,$t2,$t3 # + 
	sw   $t1,-28($fp) # cul store *tvar_45
	lw   $t1,-28($fp) # push *tvar_45
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	la   $t0,con2 # cul con2
	lw   $t2,0($t0)
	li   $t3,3
	add  $t1,$t2,$t3 # + 
	sw   $t1,-32($fp) # cul store *tvar_46
	lw   $t1,-32($fp) # push *tvar_46
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,0 # alloc mem for var 
	jal  test_relation_operator #call func
	addi $sp,$sp,0 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 

	la   $t0,con1 # cul con1
	lw   $t2,0($t0)
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-36($fp) # cul store *tvar_47
	lw   $t1,-36($fp) # push *tvar_47
	sw   $t1,0($sp)
	addi $sp,$sp,-4
	la   $t0,con2 #push con2
	lw   $t1,0($t0)
	sw   $t1,0($sp)
	addi $sp,$sp,-4

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,16 # set new $fp
	subi $sp,$sp,0 # alloc mem for var 
	jal  test_relation_operator #call func
	addi $sp,$sp,0 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,8 # delete para 

	j    switch_33
	case_41:
	lw   $t1,-8($fp) # == 
	li   $t2,8 # == 
	bne  $t1,$t2,case_42
	la   $a0,str_34 # print string
	li   $v0,4
	syscall

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,4 # alloc mem for var 
	jal  test_scope #call func
	addi $sp,$sp,4 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

	j    switch_33
	case_42:
	switch_33:
	la   $a0,str_35 # print string
	li   $v0,4
	syscall
	lw   $t2,-12($fp) # cul j
	li   $t3,1
	add  $t1,$t2,$t3 # + 
	sw   $t1,-40($fp) # cul store *tvar_48
	lw   $t1,-40($fp) # assign *tvar_48
	sw   $t1,-12($fp) # assign j
	j    while_31
	while_32:
	la   $t0,ch1 # assign ch1
	lw   $t1,0($t0)
	la   $t0,ch # assign ch
	sw   $t1,0($t0)
	la   $a0,str_36 # print string
	li   $v0,4
	syscall
	la   $t0,ch # print ch
	lw   $a0,0($t0)
	li   $v0,11
	syscall
	la   $a0,str_37 # print string
	li   $v0,4
	syscall
	jr   $ra

main:

	sw   $fp,0($sp) # store old $fp
	subi $sp,$sp,4
	sw   $ra,0($sp) #store $ra
	subi $sp,$sp,4
	addi $fp,$sp,8 # set new $fp
	subi $sp,$sp,36 # alloc mem for var 
	jal  test #call func
	addi $sp,$sp,36 # delete var mem 
	addi $sp,$sp,4
	lw   $ra,0($sp) # get old $ra
	addi $sp,$sp,4
	lw   $fp,0($sp) # get old $fp
	addi $sp,$sp,0 # delete para 

