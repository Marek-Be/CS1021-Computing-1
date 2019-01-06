	AREA	GCD, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, = 9
	LDR R2, = 30

while1
	CMP R1, R2
	BEQ skip
	CMP R1, R2		
	BLE lessThan
	SUB R1, R1, R2
	B endOfWhile1
lessThan
	SUB R2, R2, R1
endOfWhile1
	B while1
skip

	MOV R0, R1

stop	B	stop

	END	