	.data 
	msg_str: 		.asciiz "Enter some Number: "
	.text
	.globl main
	main:
	la		$a0, msg_str
	li		$v0, 4
	syscall
	li		$v0, 5
	syscall
	move		$a0,$v0			# compute 4!
	li		$a1, 0
	li		$a2, 1 
	jal		fac
	move	        $a0,$v0			# get result
	li		$v0,1			# print integer
	syscall
	li		$v0,10
	syscall
fac:
	slti		$t0,$a0,1
	bne		$t0,$zero,one
	
	addi            $sp,$sp,-4		# push space for activation frame
	sw		$ra,0($sp)		# save return address
	addi		$a0,$a0,-1
	move		$t0, $a2;
	add		$a2, $a1, $a2;
	move		$a1, $t0
	jal		fac			# recursive call 
	lw		$ra,0($sp)		# restore $ra
	addi            $sp,$sp,4		# pop activation frame	
	j		ret			# exit procedure via epilogue
one:
	move		$v0,$a0          		# return value
ret:
	jr		$ra			# return
