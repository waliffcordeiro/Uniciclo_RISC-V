.data
	data0:	.word 0x0000ff00
	data1: 	.word 0x0000020a
.text
	addi s0, x0, 5	# s0 = 5
	lw t0, data0	#t0 = data0
	lw t1, data1	#t1 = data1
	add s1, t0, t1
		
	li a7, 1
	add a0, s0, x0
	ecall
	
	li a7, 1
	add a0, s1, x0
	ecall