.text

.global	addNode

addNode:
	sub	sp, sp, #32
	str	lr, [sp, #24]

	str	w0, [sp]

	adrp	x8, head
	ldr	x9, [x8, :lo12:head]
	cmp	x9, xzr
	bne	.sec1
//.sec:
	mov	w0, #16
	bl	malloc
	str	x0, [sp, #8]
	adrp	x8, head
	str	x0, [x8, :lo12:head]

	ldr	x8, [sp, #8]
	ldr	w9, [sp]
	str	w9, [x8]
	mov	x9, xzr
	str	x9, [x8, #8]

	adrp	x8, last
	ldr	x9, [sp, #8]
	str	x9, [x8, :lo12:last]

	b	.end1
.sec1:
	mov	w0, #16
	bl	malloc
	str	x0, [sp, #8]

	ldr	x8, [sp, #8]
	ldr	w9, [sp]
	str	w9, [x8]
	mov	x9, xzr
	str	x9, [x8, #8]

	adrp	x8, last
	ldr	x9, [x8, :lo12:last]
	ldr	x10, [sp, #8]
	str	x10, [x9, #8]

	ldr	x8, [sp, #8]
	adrp	x9, last
	str	x8, [x9, :lo12:last]

.end1:
	ldr	lr, [sp, #24]
	add	sp, sp, #32
	ret

.global	freeList

freeList:
	sub	sp, sp, #32
	str	lr, [sp, #24]

	adrp	x8, head
	ldr	x9, [x8, :lo12:head]
	str	x9, [sp]

.logic1:
	ldr	x8, [sp]
	cmp	x8, xzr
	beq	.end2
.loop1:
	ldr	x8, [sp]
	str	x8, [sp, #8]

	ldr	x9, [x8, #8]
	str	x9, [sp]

	ldr	x0, [sp, #8]
	bl	free
	b	.logic1
.end2:
	ldr	lr, [sp, #24]
	add	sp, sp, #32
	ret

.global	printList

printList:
	sub	sp, sp, #32
	str	lr, [sp, #24]

	//adrp	x8, head
	//ldr	x9, [x8, :lo12:head]
	ldr	x9, head
	str	x9, [sp]

.logic2:
	ldr	x8, [sp]
	cmp	x8, xzr
	beq	.end3

.loop2:

	adrp	x8, .str1
	add	x0, x8, :lo12:.str1
	ldr	x8, [sp]
	ldr	w1, [x8]
	bl	printf

	ldr	x8, [sp]
	ldr	x9, [x8, #8]
	str	x9, [sp]
	b	.logic2
.end3:
	ldr	lr, [sp, #24]
	add	sp, sp, #32
	ret

.global	main

main:
	sub	sp, sp, #32
	str	lr, [sp, #24]

	mov	w0, #100
	bl	addNode
	mov	w0, #200
	bl	addNode
	mov	w0, #300
	bl	addNode
	mov	w0, #400
	bl	addNode
	mov	w0, #500
	bl	addNode
	mov	w0, #755
	bl	addNode

	//ldr	x9, head

	//adrp	x8, printList
	//add	x8, x8, :lo12:printList
	//blr	x8

	bl	printList

	bl	freeList

	ldr	lr, [sp, #24]
	add	sp, sp, #32
	ret



.str1:
	.asciz	"num: %i\n"

.bss

.global	head
head:
	.xword	0

.global	last
last:
	.xword	0

hello:
	.long	0


