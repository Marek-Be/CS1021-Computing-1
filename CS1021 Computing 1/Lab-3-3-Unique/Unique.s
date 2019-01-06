	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
	LDR R0, = 0			;By default is 0
	LDR	R1, =VALUES		;valueLocation
	LDR R2, =COUNT
	LDR R2, [R2]		;setLength
	LDR R3, [R1]		;currentValue
	LDR R4, = 0			;Count
	MOV R5, R1			;valueLocationCount = valueLocation
	LDR R6, = 0			;compareValue
	
	B loop				;
	
nextValue				;
	ADD R1, R1, #4		;valueLocation += 4
	MOV R5, R1			;valueLocationCount = valueLocation
	SUB R2, R2, #1		;SetLength--
	LDR R4, = 0			;Count = 0
						;
	LDR R3, [R1]		;Load currentValue
	
loop					;while (setLength != 0)
	
	ADD R4, R4, #1		;Count++
	ADD R5, R5, #4		;valueLocationCount += 4
	
	LDR R6, [R5]		;Load compareValue
	
	CMP R2, #0			;if (setLength == 0)
	BEQ EndLoop			;isUnique = true
	
	CMP R3, R6			;if (currentValue == compareValue)
	BEQ SameValue		;quit()
						;
	CMP R4, R2			;if (Count == setLength)
	BEQ nextValue		;nextValue()
	
	B loop
	
EndLoop

	LDR R0, = 1

SameValue

stop	B	stop


	AREA	TestData, DATA, READWRITE

COUNT	DCD	10
VALUES	DCD	1, 2, 3, 4, 5, 6, 7, 8, 9, 1


	END