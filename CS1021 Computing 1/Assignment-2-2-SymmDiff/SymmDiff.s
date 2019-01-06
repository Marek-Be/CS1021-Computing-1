	AREA	SymmDiff, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R1, =AElems		;AElems
	LDR R2, =ASize		;ASize
	LDR R2, [R2]		;
	LDR R3, =BElems		;BElems
	LDR R4, =BSize		;BSize
	LDR R4, [R4]		;
	LDR R5, =CElems		;CElems=0
	LDR R6, =CSize		;CSize=0
	LDR R7, = 0			;CurrentNum
	LDR R8, = 0			;CheckNum
	
	MOV R11, R1			;MainSet = AElems
	MOV R10, R3			;OtherSet = BElems
	MOV R0, R2			;MainSize = ASize
	MOV R9, R4			;OtherSize =BSize
	
	
	LDR R7, [R11]		;CurrentNum = MainSet[0]
						
	B checkB			;
				
				
whileANotZero			;while (MainSize != 0)
	
	SUB R0, R0, #1		;MainSize -= 1
	
	ADD R11, #4			;n += 4
	
	LDR R7, [R11]		;CurrentNum = MainSet[n]
	MOV R9, R4			;OtherSize = BSize
	MOV R10, R3			;OtherSet = BElems
					
	CMP R0, #0			;if (MainSize == 0)
	BEQ nextSet			;	break
	
checkB					;while () {
	
	SUB R9, R9, #1		;OtherSize -= 1
	
	LDR R8, [R10]		;CheckNum = OtherSet[n]
			
	CMP R9, #0			;if (OtherSize == 0)
	BEQ isNotInB		;	NotInB()
						;	break
	CMP R8, R7			;if (CheckNum == CurrentNum)
	BEQ whileANotZero	;	break
	
	ADD R10, R10, #4	;n += 1
						
	B checkB			;}
						;}
NotInB					;Function NotInB() {

	LDR R12, [R6]		;SizeOfC = CSize
	ADD R12, R12, #1	;SizeOfC += 1
	STR R12, [R6]		;CSize = SizeOfC
	
	STR R7, [R5]		;CElems[n] = CurrentNum 
	ADD R5, R5, #4		;n += 4
	
	B whileANotZero		;}
	
nextSet					;
	
	MOV R11, R3			;MainSet = BElems
	MOV R10, R1			;OtherSet = AElems
	MOV R0, R4			;MainSize = BSize
	MOV R9, R2			;OtherSize = ASize

	LDR R7, [R11]		;//REST OF THE CODE IS COPIED OVER AND SET B IS COMPARED TO SET A
	
	B checkA

whileBNotZero
	
	SUB R0, R0, #1
	
	ADD R11, #4
	
	LDR R7, [R11]
	
	MOV R9, R2
	MOV R10, R1
	
	CMP R0, #0
	BEQ stop
	
checkA
	
	SUB R9, R9, #1
	
	LDR R8, [R10]
	
	CMP R9, #0
	BEQ NotInA
	
	CMP R8, R7
	BEQ whileBNotZero
	
	ADD R10, R10, #4
	
	B checkA
	
NotInA
	
	LDR R12, [R6]
	ADD R12, R12, #1
	STR R12, [R6]
	
	STR R7, [R5]
	ADD R5, R5, #4
	
	B whileBNotZero





stop	B	stop


	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,20,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END
