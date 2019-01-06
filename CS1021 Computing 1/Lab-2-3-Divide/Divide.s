	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, = 0
	LDR R0, = 0
	LDR R6, = 5
	MOV R6, R8

	LDR R2, = 25	;a
	LDR R3, = 2		;b
	
	LDR R0, = 0
	
	MOV R1, R2
	;A/B
while1
	CMP R3, #0 		;If b = 0 it will skip the code
	BEQ Zero
	CMP R1, R3 		;If the remainder is less than b, the loop will end
	BLT Skip
	LDR R4, = 1
	ADD R11, R11, R4	;quotient = quotient + 1
	SUB R1, R1, R3		;remainder = remainder - b

	B while1
Skip
Zero
	MUL R3, R11, R3
	ADD R1, R1, R3
	
stop	B	stop

	END	