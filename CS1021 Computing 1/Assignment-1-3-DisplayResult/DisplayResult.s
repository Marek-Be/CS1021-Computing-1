	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	IMPORT 	div
	EXPORT	start
	PRESERVE8

start
	
	LDR R12, = 1034
	LDR R11, = 10
	LDR R10, = 0
	LDR R9, = 1
	LDR R8, = -1;
	LDR R4, = 0
	
begin
	CMP R12, R11
	BLO while1
	LDR R4, = 10
	MUL R11, R4, R11
	MUL R9, R4, R9
	ADD R8, #1
	MOV R10, R12
	B begin
Next1
	CMP R11, #0
	BEQ while1
	LDR R4, = 10
	MUL R9, R4, R9
	SUB R11, #1
	MOV R10, R12
	B Next1
while1
	CMP R9, #0 		;If b = 0 it will skip the code
	BEQ skip
	LDR R4, = 0
BACK
	CMP R10, R9 		;If the remainder is less than b, the loop will end
	BLT skip
	ADD R4, R4, #1	;quotient = quotient + 1
	SUB R10, R10, R9	;remainder = remainder - b
	B BACK
skip
	CMP R8, #0
	BNE skipDot
	LDR R0, = "."
	BL sendchar
skipDot
	MOV R0, R4
	ADD R0, R0, #48
	BL sendchar
	MUL R4, R9, R4
	SUB R12, R12, R4
	MOV R11, R8
	LDR R4, = 0 
	LDR R9, = 1
	CMP R8, #-1
	BEQ stop
	SUB R8, R8, #1
	B Next1
	
stop	B	stop

	END	