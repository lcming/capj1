.data
Q1:		        .word 1, 1, 1, 0 # Q1[0][0], Q1[0][1], Q1[1][0], Q1[1][1]
msg_str: 		.asciiz "Q3 =\n"
.text
.globl main
main:
#==============================
# sample program demonstrating
# how to determine Q3 with mmul
#==============================
	la	$a0, Q1			# Q1 be the first input matrix
	la	$a1, Q1			# Q1 be the second input matrix
	jal	mmul			# $v0 = Q2 = Q1xQ1
	move	$a0, $v0	    	# $v0, i.e, Q2, be the first input matrix
	la	$a1, Q1			# Q1 be the second input matrix again
	jal 	mmul			# $v0 = Q3 = Q2xQ1
	move	$t0, $v0		# copy $v0, i.e, Q3 to another register
	la	$a0, msg_str        	# load the address of the message "Q3=\n"
	li	$v0, 4              	# print string
	syscall                     
	lw	$a0, 0($t0)		# load Q3[0][0] from memory to argument register
	li	$v0, 1		    	# prepare to print integer	
	syscall				
	li	$a0, 32			# prepare to print ascii code 32: white space
	li	$v0, 11			# print char: white space
	syscall
	lw	$a0, 4($t0)		# load Q3[0][1] from memory to argument register
	li	$v0, 1		    	# print integer: Q3[0][1]	
	syscall	
	li	$a0, 10			# prepare to print ascii code 10: change line
	li	$v0, 11			# print char: change line
	syscall
	lw	$a0, 8($t0)		# load Q3[1][0] from memory to argument register
	li	$v0, 1		    	# print integer Q3[1][0]	
	syscall				
	li	$a0, 32			# prepare to print ascii code 32: white space
	li	$v0, 11			# print char: white space
	syscall
	lw	$a0, 12($t0)		# load Q3[1][1] from memory to argument register
	li	$v0, 1		    	# print integer: Q3[1][1]	
	syscall				
	li	$v0, 10
	syscall
mmul:
#===================================
# mmul implemented for you.
# you can use this as follows:
# la    $a0, A
# la    $a1, B
# jr    mmul
# The return register $v0 will hold 
# address of the result matrix C=AxB.
# You can access C by:
# 0($v0):C[0][0], 4($v0):C[0][1]
# 8($v0):C[1][0],12($v0):C[1][1]
#===================================
	move	$t0, $a0	    # int* m1
	move	$t1, $a1	    # int* m2
	li	$a0, 16             # request for 16 byte location to hold result matrix
	li	$v0, 9              # malloc system call
	syscall
	
	lw	$t2, 0($t0)	        #m1[0]
	lw	$t3, 4($t0)	        #m1[1]
	lw	$t4, 0($t1)	        #m2[0]
	lw	$t5, 8($t1)	        #m2[2]
	mul	$t7, $t2, $t4       #m1[0]*m2[0]
	mul	$t8, $t3, $t5       #m1[1]*m2[2]
	add	$t7, $t7, $t8       #r[0] 
	sw	$t7, 0($v0)
	
	lw	$t4, 4($t1)	       #m2[1]
	lw	$t5, 12($t1)	    #m2[3]
	mul	$t7, $t2, $t4
	mul	$t8, $t3, $t5
	add	$t7, $t7, $t8       #r[1]
	sw	$t7, 4($v0)
	
	#r[3]
	lw	$t2, 8($t0)	        #m1[2]
	lw	$t3, 12($t0)	    #m1[3]
	mul	$t7, $t2, $t4
	mul	$t8, $t3, $t5
	add	$t7, $t7, $t8       #r[3]
	sw	$t7, 12($v0)	

	#r[2]
	lw	$t4, 0($t1)	        #m2[0]
	lw	$t5, 8($t1)	        #m2[2]
	mul	$t7, $t2, $t4
	mul	$t8, $t3, $t5
	add	$t7, $t7, $t8       #r[2]
	sw	$t7, 8($v0)		
	
	jr	$ra
