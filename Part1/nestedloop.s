.data
	i: .word 1
	j: .word 0
	x: .word 0

.global main
addr_i: .word i
addr_j: .word j
addr_x: .word x

main:
	ldr r0, addr_i
	ldr r0, [r0]			// i = 1
	ldr r1, addr_j
	ldr r1, [r1]			// j = 0
	ldr r2, addr_x
	ldr r2, [r2]			// x = 0

	cmp r0, #10
	bge exit			// i >= 10
outer:
	mov r1, r0			// j = i
	cmp r1, #10
	bge outer_end		// j >= 10
inner:
	add r3, r0, r1		// tmp = i + j
	add r2, r2, r3		// x = x + tmp
	add r1, r1, #1		// j++
	cmp r1, #10
	blt inner			// j < 10
outer_end:
	add r0, r0, #2		// i += 2
	cmp r0, #10
	blt outer			// i < 10

exit:
	mov r0, r2
	bx lr
