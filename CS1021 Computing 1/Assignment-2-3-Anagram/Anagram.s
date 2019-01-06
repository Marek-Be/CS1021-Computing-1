	AREA	Anagram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R0, =1			;isAnagram=1
	LDR	R1, =stringA	;stringA
	LDR	R2, =stringB	;stringB
	MOV R3, R2			;tempStringB
	LDRB R4, [R1]		;aLetter = stringA[0]
	LDR R5, =0			;bLetter = 0
	LDR R6, =0			;tempValue = 0
	LDR R7, =0			;aLength = 0
	LDR R8, =0			;bLength = 0
	MOV R9, R1			;aLen = aLetter	
	MOV R10,R2			;bLen = bLetter
	
getLengthA				;while (currentLetterA != 0)
						;{
	LDRB R4, [R9]		;currentLetterA = aLen[n]
						;
	CMP R4, #0			;
	BEQ getLengthB		;
						;
	ADD R9, R9, #1		;n += 1
	ADD R7, R7, #1		;aLength += 1
	
	B getLengthA		;}
	
getLengthB				;while (currentLetterB != 0)
						;{
	LDRB R5, [R10]		;currentLetterB = bLen[n]
	
	CMP R5, #0			;
	BEQ compareLengths	;
	
	ADD R10, R10, #1	;n += 1
	ADD R8, R8, #1		;bLength += 1
	
	B getLengthB		;}

	
	
compareLengths			;

	CMP R7, R8			;if (bLength != aLength)
	BNE noAnagram		;	noAnagram()
						;else
	LDRB R4, [R1]		;aLetter = stringA[0]
	
	B SearchFor			;SearchFor()
	
NextValue				;Function NextLetter() {

	LDR R6,= "-"		;tempValue = "-"
	STRB R6, [R3]		;tempStringB[n] = tempValue
	
	ADD R1, R1, #1		;stringA += 1
	
	LDRB R4, [R1]		;aLetter = stringA[current]
	
	CMP R4, #0			;if (aLetter == 0)
	BEQ stop			;	break
	
	MOV R3, R2			;tempStringB = stringB
						;}
SearchFor				;Function SearchFor() {
						;while (aLetter != 0) {
	LDRB R5, [R3]		;bLetter = tempStringB[n]
						;
	CMP R5, #0			;if (bLetter == 0)
	BEQ noAnagram		;	noAnagram()
	
	CMP R5, R4			;if (aLetter == bLetter)
	BEQ NextValue		;	NextLetter()
	
	ADD R3, R3, #1		;n+=1
	
	B SearchFor			;}
						;}
noAnagram				;Function noAnagram() {
	LDR R0, = 0			;isAnagram = 0
						;}
stop	B	stop

	AREA	TestData, DATA, READWRITE

stringA	DCB	"bests",0
stringB	DCB	"beets",0

	END