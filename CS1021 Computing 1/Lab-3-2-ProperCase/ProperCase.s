	AREA	ProperCase, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =testStr	;currentLetterLocation
	MOV R3, R1			;Copy of the location of the string
	
	LDRB R2, [R1]		;Loads the first letter
	CMP R2, #'a'		;
	BLO SkipFirst		;if (currentLetter.isLowerCase())
	CMP R2, #'z'		;
	BHI SkipFirst		;
						;{
	SUB R2, R2, #32		;currentLetter.toUpperCase()
	STRB R2, [R1]		;Loads into memory
						;}
SkipFirst

toLower					;While (currentLetter != 0) {
	ADD R1, R1, #1		;currentLetterLocation++
	LDRB R2, [R1]		;Loads letter
	
	CMP R2, #0			;if (currentLetter == 0)
	BEQ stop			;quit()
	
	CMP R2, #" "		;if (currentLetter == " ")
	BEQ IsUpper			;IsUpper(currentLetter)
	
	CMP R2, #'A'		;
	BLO SkipFirst		;else if (currentLetter.isUpperCase())
	CMP R2, #'Z'		;{
	BHI SkipFirst		;
						;
	ADD R2, R2, #32		;currentLetter.toLowerCase()
	STRB R2, [R1]		;Loads into memory
						;}
	B toLower			;}

IsUpper					;Function IsUpper(Letter)
						;{
	ADD R1, R1, #1		;currentLetterLocation++
	LDRB R2, [R1]		;Loads letter
						;
	CMP R2, #'a'		;if (currentLetter.isLower())
	BLO toLower			;{
	CMP R2, #'z'		;
	BHI toLower			;
						;
	SUB R2, R2, #32		;currentLetter.toUpperCase
	STRB R2, [R1]		;Loads into memory
						;}
	B toLower
	; your program goes here

stop	B	stop



	AREA	TestData, DATA, READWRITE

testStr	DCB	"hello WORLD",0

	END
