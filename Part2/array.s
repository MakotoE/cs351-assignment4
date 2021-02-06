.data
	a: .skip 10
	b: .skip 10
	i: .word 1
	sum: .word 0

.global main
addr_a: .word a
addr_b: .word b

main:
	ldr r0, addr_a		// int* a
	ldr r1, addr_b		// int* b
	ldr r2, i			// int i = 1
	ldr r3, sum			// int sum = 0

	cmp r2, #10
	bge exit			// i >= 10

loop:
	// a[i] = i
	add r4, r0, r2		// tmp0 = a + i
	str r2, [r4]		// *tmp0 = i

	// b[i] = i << 2
	lsl r4, r2, #2		// tmp0 = i << 2
	add r5, r1, r2		// tmp1 = b + i
	str r4, [r5]		// *tmp1 = tmp0
	
	// if (b[i] % 8 == 0)
	add r4, r1, r2		// tmp0 = b + i
	ldr r4, [r4]		// tmp0 = *tmp0
	and r4, r4, #7		// tmp0 = tmp0 % 8
	cmp r4, #0
	bne loop_end		// tmp0 != 0

	// b[i] = a[i/2]
	lsr r4, r2, #1		// tmp0 = i / 2
	add r4, r0, r4		// tmp0 = a + tmp0
	ldr r4, [r4]		// tmp0 = *tmp0
	add r5, r1, r2		// tmp1 = b + i
	str r4, [r5]		// *tmp1 = tmp0

loop_end:
	// sum += a[i] + b[i]
	add r4, r0, r2		// tmp0 = a + i
	ldr r4, [r4]		// tmp0 = *tmp0
	add r5, r1, r2		// tmp1 = b + i
	ldr r5, [r5]		// tmp1 = *tmp1
	add r4, r4, r5		// tmp0 = tmp0 + tmp1
	add r3, r3, r4		// sum = sum + tmp0

	add r2, r2, #1		// i++

	cmp r2, #10
	blt loop			// i < 10

exit:
	// return sum
	mov r0, r3
	bx lr
