	AREA	ShiftAndAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, = 0
	LDR	R1, =9					;1001
	LDR	R2, =16					;1010
	
	MOVS R2, R2, LSR #1			;Shift number by one to the right
	
shiftWhile						;while (num2 != 0)
								;{
	BCS isOne					;if (carry != 1)
								;{
	MOVS R1, R1, LSL #1			;Shift num1 left one
	MOVS R2, R2, LSR #1			;Shift num2 right one
	
	B shiftWhile				;}

isOne							;else if (carry == 1)
								;{
	ADD R0, R0, R1				;answer += num1
	
	MOVS R1, R1, LSL #1			;Shift num1 left one
	MOVS R2, R2, LSR #1			;Shift num2 right one
	
	CMP R2, #0					;
	BEQ stop					; //While num != 0 part
	
	B shiftWhile				;}
	
	
	; your program goes here

	
stop	B	stop


	END	
	