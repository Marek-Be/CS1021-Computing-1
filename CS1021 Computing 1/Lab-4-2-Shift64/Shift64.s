	AREA	Shift64, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =0x13131313
	LDR	R1, =0x13131313
	LDR	R2, =-100
	LDR R3, =0x80000000
	LDR R4, =0x00000001
	
						; if (Shift < 0)
	CMP R2, #0			; 	  leftShift(Shift)
	BLT startNegative	; else
						;	  rightShift(Shift)
						
startPositive			;rightShift(int Shift)
						;
	ADD R2, R2, #1		;Shift += 1

shiftWhile				;

	CMP R2, #0			;while (Shift != 0)
	BEQ stop			;{

	SUB R2, R2, #1		;Shift -= 1
	
	MOVS R0, R0, LSR #1	;Shift R0 right 1
	MOVS R1, R1, LSR #1	;Shift R1 right 1
	
	BCS isOne			;if (Carry == 1)
						;
	B shiftWhile		;{

isOne					;

	ORR R0, R0, R3		;Change first digit of R3 to 1
						;}
	B shiftWhile		;}
	
	
startNegative			;leftShift(int Shift)
	
	SUB R2, R2, #1		;Shift -= 1

shiftWhileNeg			;while (Shift != 0)

	CMP R2, #0			;
	BEQ stop			;

	ADD R2, R2, #1		;Shift += 1
	
	MOVS R1, R1, LSL #1	;Shift R1 left 1
	MOVS R0, R0, LSL #1	;Shift R1 left 1
	
	BCS isOneNeg		;if (Carry == 1)
	
	B shiftWhileNeg		;{

isOneNeg				;

	ORR R1, R1, R4		;Change last digit of R4 to 1
						;}
	B shiftWhileNeg		;}
	
stop	B	stop


	END
		