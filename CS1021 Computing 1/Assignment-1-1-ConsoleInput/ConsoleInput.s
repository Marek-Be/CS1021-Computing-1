	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	LDR R12,=0
	LDR R11,=0
	LDR R10,=0
	LDR R9,=0
	LDR R8,=0		
	LDR R7,=0		;max
	LDR R6,=0		;min
	LDR R5,=0
	
seperatorCheck
read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console
	
	MOV R11, R12
	LDR R10,= 10
	MUL R12, R11, R10
	ADD R12, R12, R0
	SUB R12, R12, #0x30
	;ADD R1, R0, R0
	
	
	
	
	
	
	
	
	
	
	
	
	
	; do any necessary processing of the key
	;

	B	read		; }
	B	seperatorCheck

endRead


	
	ADD R9, R9, #1	;count
	ADD R8, R8, R12	;sum
	
	CMP R9, #1
	BEQ firstNumber
	
	MOV R6, R12
	MOV R7, R12
	
	
firstNumber	

stop	B	stop

	END	