	AREA	AsciiValue, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, ='2'	; Load '2','0','3','4' into R4...R1
	LDR	R3, ='0'	;
	LDR	R2, ='3'	;
	LDR	R1, ='4'	;
	
	LDR R5, = 48
	
	SUB R4, R4, R5
	SUB R3, R3, R5
	SUB R2, R2, R5
	SUB R1, R1, R5
	
	LDR R5, = 1000
	MOV R6, R4
	MUL R4, R6, R5
	LDR R5, = 100
	MOV R6, R3
	MUL R3, R6, R5
	MOV R6, R2
	LDR R5, = 10
	MUL R2, R6, R5
	
	LDR R0, =0
	
	ADD R0, R4, R3
	ADD R0, R0, R2
	ADD R0, R0, R1
	
	
	; your program goes here
	
stop	B	stop

	END	