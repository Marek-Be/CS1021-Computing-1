	AREA	StatEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	LDR R12,=0				;
	LDR R11,=0				;
	LDR R10,=0				;
	LDR R9,=0				;
	LDR R8,=0				;	Sum
	LDR R7,=0				;	Min
	LDR R6,=0				;	Max
	LDR R5,=0				;	Mean
	LDR R4,=0				;	Count
	
ReadNum						;	While (Key != Enter) {
	BL	getkey				;	Key = (getkey)
	CMP	R0, #0x0D			;	if (Key == Enter) {
	BEQ	newNumber			;		EndRead = true
	BL	sendchar			;	}
							;	
	CMP	R0, #" "			;	if (Key == " ")
	BEQ newNumber			;		NewNumber()
							;	
	CMP R0, #"."			;	if (Key == ".")
	BEQ ReadDec				;		DeciminalNumber()

	MOV R11, R12			;	Number	=	LastNumber	
	LDR R10,= 10			;	(Loading 10 to multiply)
	MUL R12, R11, R10		;	LastNumber	*=	10
	ADD R12, R12, R0		;	LastNumber +=	Key
	SUB R12, R12, #0x30		;	LastNumber -=	48 (To change number from ascii to an int)		
	
	B	ReadNum				;	}
	
ReadDec						;	DecimalNumber()

	BL	getkey				;	Key = (getkey)
	CMP	R0, #0x0D			;	if (Key == Enter){	
	BEQ	newNumber			;		NewNumber()
	BL	sendchar			;
	
	CMP	R0, #" "			;	if (Key == " "){
	BEQ newNumber			;		NewNumber()

	ADD R9, R9, R0			;	LastDec += Key
	SUB R9, R9, #0x30		;	LastDec -= 48 (To change number from ascii to an int)
		
	BL	getkey				;	}
	
	CMP	R0, #0x0D			;	(Repeat of last part, I needed to actually copy the code twice so an error I had wouldnt happen)
	BEQ	MulTen				
	
	BL	sendchar
	
	CMP	R0, #" "			;	(Only thing that changed, multiplies last decimal part by ten to make sure there is a zero at the end)
	BEQ MulTen											
	
	MOV R11, R9											
	LDR R10,= 10											
	MUL R9, R11, R10									
	ADD R9, R9, R0										
	SUB R9, R9, #0x30
	
	B newNumber

MulTen

	LDR R10, = 10			;	(Loading 10 to multiply)
	MUL R9, R10, R9			;	LastDec *= 10

newNumber

	LDR R10, = 100			;	(Louding 100 to multiply)
	MUL R12, R10, R12		;	(Mutliplying the first part of the number by 100)
	ADD R12, R12, R9		;	LastNumber += LastDec
	ADD R4, R4, #1			;	Count += 1
	ADD R8, R8, R12			;	Sum += LastNumber

	CMP R6, #0				;	if (Count != 0)	
	BNE NotFirstNumber		;		NotFirstNumber()
	
	MOV R6, R12				;	else { Min = LastNumber						
	MOV R7, R12				;	Max = LastNumber 
	
	B EndMinMax				;	(Skip to end of minmax)			
	
NotFirstNumber										
															
	CMP R12, R6				;	if (LastNumber > Max)						
	BLS Smaller				;
	
	MOV R6, R12				;	Max = LastNumber								
	
Smaller						;

	CMP R12, R7				;	else if (LastNumber < Min)
	BHS EndMinMax			
	
	MOV R7, R12				;	Min = LastNumber						

EndMinMax													

	LDR R9, = 0;			;	Resting values
	LDR R11, = 0											
	LDR R12, = 0											

	CMP	R0, #0x0D										
	BEQ	endRead												
	
	B ReadNum										
	
endRead						

	MOV R10, R8												
									
	CMP R4, #0 					;	if (Count == 0)
	BEQ SkipDivideMean			;	(Do nothing)
	
Divide							;	else{

	CMP R10, R4 				;	while(Sum >= Count)			
	BLT SkipDivideMean			;	{
	
	ADD R5, R5, #1				;	Mean += 1					
	SUB R10, R10, R4			;	Sum -= Count				
	
	B Divide					;	}
	
SkipDivideMean					;	

	LDR R0, = 10
	BL sendchar
	LDR R0, = "M"
	BL sendchar
	LDR R0, = "i"
	BL sendchar
	LDR R0, = "n"
	BL sendchar
	LDR R0, = ":"
	BL sendchar

	MOV R12, R7				;	ToPrint = Min
	LDR R11, = 10			;	PowerOf = 10
	LDR R10, = 0			;	
	LDR R9, = 1				;	10LessPowerOf = 1
	LDR R8, = -1			;	Power = -1
	LDR R4, = 0				;
	
BeginMin					;

	CMP R12, R11			;	while (ToPrint > PowerOf)
	BLO DivideMin			;	{
	
	LDR R4, = 10			;	(Loading 10 to multiply)
	MUL R11, R4, R11		;	PowerOf *= 10
	MUL R9, R4, R9			;	10LessPowerOf *= 10
	ADD R8, #1				;	Power += 1
	MOV R10, R12			;	TempDivide = ToPrint
	
	B BeginMin				;	}
	
PowerMin					;	while (Power != -1) {

	CMP R11, #0				;	
	BEQ DivideMin			;	if (PowerOf != 0){
	
	LDR R4, = 10			;	(Loading 10 to multiply)
	MUL R9, R4, R9			;	10LessPowerOf *= 10
	SUB R11, #1				;	PowerOf -= 1
	MOV R10, R12			;	TempDivide = ToPrint
	
	B PowerMin				;
	
DivideMin					;	

	CMP R9, #0 				;	if (10LessPowerOf != 0)	
	BEQ EndDivideMin		;	{
	
	LDR R4, = 0				;
	
DividingMin					;	

	CMP R10, R9 			;	while (TempDivide >= 10LessPowerOf)
	BLT EndDivideMin		;
	
	ADD R4, R4, #1			;	MostSignificant += 1
	SUB R10, R10, R9		;	TempDivide -= 10LessPowerOf
	
	B DividingMin			;	}
	
EndDivideMin				;	}

	CMP R8, #0				;	if (Power == 0)
	BNE SkipDotMin			;	{
	
	LDR R0, = "."			;	Print (".")
	BL sendchar				;	
	
SkipDotMin					;	}

	MOV R0, R4				;	
	ADD R0, R0, #48			;
	BL sendchar				;	Print (MostSignificant)
	MUL R4, R9, R4			;	MostSignificant *= 10LessPowerOf
	SUB R12, R12, R4		;	ToPrint -= MostSignificant
	MOV R11, R8				;	
	LDR R4, = 0 			;	MostSignificant = 0
	LDR R9, = 1				;	10LessPowerOf = 1
	
	CMP R8, #-1				;	
	BEQ EndPrintMin			;	
	
	SUB R8, R8, #1			;	Power -= 1
	
	B PowerMin				;	}
	
EndPrintMin

	LDR R0, = 10
	BL sendchar
	LDR R0, = "M"
	BL sendchar
	LDR R0, = "a"
	BL sendchar
	LDR R0, = "x"
	BL sendchar
	LDR R0, = ":"
	BL sendchar

	MOV R12, R6
	LDR R11, = 10
	LDR R10, = 0
	LDR R9, = 1
	LDR R8, = -1;
	LDR R4, = 0
	
BeginMax			;SAME CODE AS DISPLAYING THE MIN!

	CMP R12, R11
	BLO DivideMax
	
	LDR R4, = 10
	MUL R11, R4, R11
	MUL R9, R4, R9
	ADD R8, #1
	MOV R10, R12
	
	B BeginMax
	
PowerMax

	CMP R11, #0
	BEQ DivideMax
	
	LDR R4, = 10
	MUL R9, R4, R9
	SUB R11, #1
	MOV R10, R12
	
	B PowerMax
	
DivideMax

	CMP R9, #0 		
	BEQ EndDivideMax
	
	LDR R4, = 0
	
DividingMax

	CMP R10, R9 		
	BLT EndDivideMax
	
	ADD R4, R4, #1	
	SUB R10, R10, R9	
	
	B DividingMax
	
EndDivideMax

	CMP R8, #0
	BNE SkipDotMax
	
	LDR R0, = "."
	BL sendchar
	
SkipDotMax

	MOV R0, R4
	ADD R0, R0, #48
	BL sendchar
	MUL R4, R9, R4
	SUB R12, R12, R4
	MOV R11, R8
	LDR R4, = 0 
	LDR R9, = 1
	
	CMP R8, #-1
	BEQ EndPrintMax
	
	SUB R8, R8, #1
	
	B PowerMax
	
EndPrintMax

	LDR R0, = 10
	BL sendchar
	LDR R0, = "R"
	BL sendchar
	LDR R0, = "a"
	BL sendchar
	LDR R0, = "n"
	BL sendchar
	LDR R0, = "g"
	BL sendchar
	LDR R0, = "e"
	BL sendchar
	LDR R0, = ":"
	BL sendchar
	
	LDR R12, = 0					;	PrintValue = 0
	ADD R12, R7, R12				;	PrintValue += Max
	SUB R12, R6, R12				;	PrintValue -= Min
	LDR R11, = 10
	LDR R10, = 0
	LDR R9, = 1
	LDR R8, = -1;
	LDR R4, = 0
	
BeginRange				;SAME CODE AS DISPLAYING THE MIN!

	CMP R12, R11
	BLO DivideRange
	
	LDR R4, = 10
	MUL R11, R4, R11
	MUL R9, R4, R9
	ADD R8, #1
	MOV R10, R12
	
	B BeginRange
	
PowerRange

	CMP R11, #0
	BEQ DivideRange
	
	LDR R4, = 10
	MUL R9, R4, R9
	SUB R11, #1
	MOV R10, R12
	
	B PowerRange
	
DivideRange

	CMP R9, #0 		
	BEQ EndDivideRange
	
	LDR R4, = 0
	
DividingRange

	CMP R10, R9 		
	BLT EndDivideRange
	
	ADD R4, R4, #1	
	SUB R10, R10, R9	
	
	B DividingRange
	
EndDivideRange

	CMP R8, #0
	BNE SkipDotRange
	
	LDR R0, = "."
	BL sendchar
	
SkipDotRange

	MOV R0, R4
	ADD R0, R0, #48
	BL sendchar
	MUL R4, R9, R4
	SUB R12, R12, R4
	MOV R11, R8
	LDR R4, = 0 
	LDR R9, = 1
	
	CMP R8, #-1
	BEQ EndPrintRange
	
	SUB R8, R8, #1
	
	B PowerRange
	
EndPrintRange

	LDR R0, = 10
	BL sendchar
	LDR R0, = "M"
	BL sendchar
	LDR R0, = "e"
	BL sendchar
	LDR R0, = "a"
	BL sendchar
	LDR R0, = "n"
	BL sendchar
	LDR R0, = ":"
	BL sendchar
	
	MOV R12, R5
	LDR R11, = 10
	LDR R10, = 0
	LDR R9, = 1
	LDR R8, = -1;
	LDR R4, = 0
	
BeginMean					;SAME CODE AS DISPLAYING THE MIN!

	CMP R12, R11
	BLO DivideMean
	
	LDR R4, = 10
	MUL R11, R4, R11
	MUL R9, R4, R9
	ADD R8, #1
	MOV R10, R12
	
	B BeginMean
	
PowerMean

	CMP R11, #0
	BEQ DivideMean
	
	LDR R4, = 10
	MUL R9, R4, R9
	SUB R11, #1
	MOV R10, R12
	
	B PowerMean
	
DivideMean

	CMP R9, #0 		
	BEQ EndDivideMean
	LDR R4, = 0
	
DividingMean

	CMP R10, R9 		
	BLT EndDivideMean
	
	ADD R4, R4, #1	
	SUB R10, R10, R9	
	
	B DividingMean
	
EndDivideMean

	CMP R8, #0
	BNE SkipDotMean
	
	LDR R0, = "."
	BL sendchar
	
SkipDotMean

	MOV R0, R4
	ADD R0, R0, #48
	BL sendchar
	MUL R4, R9, R4
	SUB R12, R12, R4
	MOV R11, R8
	LDR R4, = 0
	LDR R9, = 1
	
	CMP R8, #-1
	BEQ EndPrintMean
	
	SUB R8, R8, #1
	
	B PowerMean
	
EndPrintMean

stop	B	stop

	END