	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1,=ASize
	LDR R3,=BSize
	
	LDR r1, [R1];Subset length
	LDR r2, = 0 ;Current subset value
	LDR r3, [R3];Set Length
	LDR r4, = 0;Current set value
	
	SUB R1, R1, #1
	SUB R3, R3, #1
	
	LDR R7,=AElems
	LDR R8,=BElems

	LDR R9, = 0
	LDR R10, = 0
	LDR R11, = 4

	LDR R5, = 0

subset
	MUL R9, R11, R5
	ADD R9, R9, R8
	LDR R2, [R9]

	LDR R6, = 0

	CMP R5, R1
	BEQ End1
set
	MUL R10, R11, R6
	ADD R10, R10, R8
	LDR R4, [R10]

	CMP R6, R3
	BEQ notEqual
	CMP R2, R4
	BEQ equal
	
	ADD R6, R6, #1
	
	B set
equal
	
	
	ADD R5, R5, #1
	
	B subset
End1
	LDR R0, = 1

	B quit

notEqual
	LDR R0,=0

quit

stop	B	stop

	AREA	TestData, DATA, READWRITE

ASize DCD 3
AElems DCD 7, 20, 9, 420
	
BSize DCD 8
BElems DCD	9, 13, 7, 11, 20, 25, 10, 12

	END