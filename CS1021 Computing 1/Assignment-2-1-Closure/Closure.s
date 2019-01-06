	AREA	Closure, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
	LDR R0, = 0			;isClosure = 0
	LDR	R1, =AElems		;AElems
	LDR R2, =ASize		;
	LDR R2, [R2]		;ASize
	LDR R3, [R1]		;currentValue = AElems[n]
	LDR R4, = 0			;Count
	MOV R5, R1			;valueLocationCount = valueLocation
	LDR R6, = 0			;compareValue
	MOV R7, R1			;AElemsCopy = AElems
	LDR R8, = 0			;compareSize = 0
	LDR R9, = 0			;tempValue = 0
	
	B SearchFor
	
NextValue				;Function NextValue() {
	
	CMP R2, #0			;if (ASize <= 0)
	BLE stop			;	stop()

	ADD R1, R1, #4		;AElems += 4
	LDR R3, [R1]		;currentValue = AElems[n]

	MOV R7, R1			;AElemsCopy = AElems
	
	LDR R8, = 0			;compareSize = 0
	
	CMP R3, #0			;if (currentValue == 0)
	BEQ NextValue		;	NextValue()
						;else
						;	SearchForClosure()
						;}
SearchFor				;Function SearchForClosure() {
	
	LDR R6, [R7]		;compareValue = AElemsCopy[n]
	LDR R9, = 0			;tempValue = 0
	SUB R6, R9, R6		;compareValue = (0 - compareValue)
	
	CMP R3, R6			;if (currentValue == compareValue)
	BEQ isClosure		;	isClosure()
	
	CMP R8, R2			;if (currentValue == compareValue)
	BEQ noClosure		;	noClosure()

	ADD R7, R7, #4		;n += 4
	ADD R8, R8, #1		;compareSize += 1
	
	B SearchFor			;
						;}
isClosure				;Function isClosure() {

	LDR R9, = 0			;tempValue = 0
	STR R9, [R7]		;AElemsCopy[n] = tempValue
	
	SUB R2, R2, #2		;ASize -= 2
	
	B NextValue			;NextValue()
						;}
noClosure				;Function noClosure() {
	
	LDR R0, = 2			;isClosure = 0
						;}

stop	B	stop


	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	+4,-6,-4,+3,-8,+6,+8,-3	; Elements of A

	END
