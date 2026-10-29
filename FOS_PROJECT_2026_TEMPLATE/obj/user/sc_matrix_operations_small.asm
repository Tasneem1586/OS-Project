
obj/user/sc_matrix_operations_small:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 e9 09 00 00       	call   800a1f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements);
int64** MatrixAddition(int **M1, int **M2, int NumOfElements);
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 01 00 00    	sub    $0x134,%esp
	char Line[255] ;
	char Chose ;
	int val =0 ;
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int NumOfElements = 3;
  800049:	c7 45 d8 03 00 00 00 	movl   $0x3,-0x28(%ebp)
	int NumOfRep = 0;
  800050:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	do
	{
		val = 0;
  800057:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		NumOfElements = 3;
  80005e:	c7 45 d8 03 00 00 00 	movl   $0x3,-0x28(%ebp)
		//2012: lock the interrupt
		sys_lock_cons();
  800065:	e8 71 1d 00 00       	call   801ddb <sys_lock_cons>
		{
			cprintf("\n");
  80006a:	83 ec 0c             	sub    $0xc,%esp
  80006d:	68 40 28 80 00       	push   $0x802840
  800072:	e8 e8 0c 00 00       	call   800d5f <cprintf>
  800077:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	68 44 28 80 00       	push   $0x802844
  800082:	e8 d8 0c 00 00       	call   800d5f <cprintf>
  800087:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   MATRIX MULTIPLICATION    !!!\n");
  80008a:	83 ec 0c             	sub    $0xc,%esp
  80008d:	68 68 28 80 00       	push   $0x802868
  800092:	e8 c8 0c 00 00       	call   800d5f <cprintf>
  800097:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  80009a:	83 ec 0c             	sub    $0xc,%esp
  80009d:	68 44 28 80 00       	push   $0x802844
  8000a2:	e8 b8 0c 00 00       	call   800d5f <cprintf>
  8000a7:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  8000aa:	83 ec 0c             	sub    $0xc,%esp
  8000ad:	68 40 28 80 00       	push   $0x802840
  8000b2:	e8 a8 0c 00 00       	call   800d5f <cprintf>
  8000b7:	83 c4 10             	add    $0x10,%esp

			//readline("Enter the number of elements: ", Line);
			//NumOfElements = strtol(Line, NULL, 10) ;
			int NumOfElements = 600 ;						//Add & Sub
  8000ba:	c7 45 e8 58 02 00 00 	movl   $0x258,-0x18(%ebp)
			if (NumOfRep % 3 == 2) 	NumOfElements = 40 ;	//Mul
  8000c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c4:	b9 03 00 00 00       	mov    $0x3,%ecx
  8000c9:	99                   	cltd   
  8000ca:	f7 f9                	idiv   %ecx
  8000cc:	89 d0                	mov    %edx,%eax
  8000ce:	83 f8 02             	cmp    $0x2,%eax
  8000d1:	75 07                	jne    8000da <_main+0xa2>
  8000d3:	c7 45 e8 28 00 00 00 	movl   $0x28,-0x18(%ebp)
			cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  8000da:	83 ec 08             	sub    $0x8,%esp
  8000dd:	ff 75 e8             	pushl  -0x18(%ebp)
  8000e0:	68 8c 28 80 00       	push   $0x80288c
  8000e5:	e8 75 0c 00 00       	call   800d5f <cprintf>
  8000ea:	83 c4 10             	add    $0x10,%esp
			//		cprintf("a) Ascending\n") ;
			//		cprintf("b) Identical\n") ;
			//		cprintf("c) Semi random\n");
			do
			{
				cprintf("Select: ") ;
  8000ed:	83 ec 0c             	sub    $0xc,%esp
  8000f0:	68 ae 28 80 00       	push   $0x8028ae
  8000f5:	e8 65 0c 00 00       	call   800d5f <cprintf>
  8000fa:	83 c4 10             	add    $0x10,%esp
				if (NumOfRep / 3 == 0) 		{ Chose = 'a'; cprintf("a) Ascending\n");}
  8000fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800100:	83 c0 02             	add    $0x2,%eax
  800103:	83 f8 04             	cmp    $0x4,%eax
  800106:	77 16                	ja     80011e <_main+0xe6>
  800108:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  80010c:	83 ec 0c             	sub    $0xc,%esp
  80010f:	68 b7 28 80 00       	push   $0x8028b7
  800114:	e8 46 0c 00 00       	call   800d5f <cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
  80011c:	eb 40                	jmp    80015e <_main+0x126>
				else if (NumOfRep/3 == 1) 	{ Chose = 'b'; cprintf("b) Identical\n");}
  80011e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800121:	83 e8 03             	sub    $0x3,%eax
  800124:	83 f8 02             	cmp    $0x2,%eax
  800127:	77 16                	ja     80013f <_main+0x107>
  800129:	c6 45 f7 62          	movb   $0x62,-0x9(%ebp)
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	68 c5 28 80 00       	push   $0x8028c5
  800135:	e8 25 0c 00 00       	call   800d5f <cprintf>
  80013a:	83 c4 10             	add    $0x10,%esp
  80013d:	eb 1f                	jmp    80015e <_main+0x126>
				else if (NumOfRep/3 == 2) 	{ Chose = 'c'; cprintf("c) Semi random\n");}
  80013f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800142:	83 e8 06             	sub    $0x6,%eax
  800145:	83 f8 02             	cmp    $0x2,%eax
  800148:	77 14                	ja     80015e <_main+0x126>
  80014a:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
  80014e:	83 ec 0c             	sub    $0xc,%esp
  800151:	68 d3 28 80 00       	push   $0x8028d3
  800156:	e8 04 0c 00 00       	call   800d5f <cprintf>
  80015b:	83 c4 10             	add    $0x10,%esp
				//			cputchar(Chose);
				//			cputchar('\n');
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80015e:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800162:	74 10                	je     800174 <_main+0x13c>
  800164:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800168:	74 0a                	je     800174 <_main+0x13c>
  80016a:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80016e:	0f 85 79 ff ff ff    	jne    8000ed <_main+0xb5>

			if (Chose == 'b')
  800174:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800178:	75 07                	jne    800181 <_main+0x149>
			{
				//			readline("Enter the value to be initialized: ", Line);
				//			val = strtol(Line, NULL, 10) ;
				val = 1;
  80017a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
			}
		}
		//2012: lock the interrupt
		sys_unlock_cons();
  800181:	e8 6f 1c 00 00       	call   801df5 <sys_unlock_cons>

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
  800186:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800189:	c1 e0 02             	shl    $0x2,%eax
  80018c:	83 ec 0c             	sub    $0xc,%esp
  80018f:	50                   	push   %eax
  800190:	e8 22 1b 00 00       	call   801cb7 <malloc>
  800195:	83 c4 10             	add    $0x10,%esp
  800198:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int **M2 = malloc(sizeof(int) * NumOfElements) ;
  80019b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80019e:	c1 e0 02             	shl    $0x2,%eax
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	50                   	push   %eax
  8001a5:	e8 0d 1b 00 00       	call   801cb7 <malloc>
  8001aa:	83 c4 10             	add    $0x10,%esp
  8001ad:	89 45 d0             	mov    %eax,-0x30(%ebp)

		for (int i = 0; i < NumOfElements; ++i)
  8001b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8001b7:	eb 4b                	jmp    800204 <_main+0x1cc>
		{
			M1[i] = malloc(sizeof(int) * NumOfElements) ;
  8001b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001c3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001c6:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8001c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001cc:	c1 e0 02             	shl    $0x2,%eax
  8001cf:	83 ec 0c             	sub    $0xc,%esp
  8001d2:	50                   	push   %eax
  8001d3:	e8 df 1a 00 00       	call   801cb7 <malloc>
  8001d8:	83 c4 10             	add    $0x10,%esp
  8001db:	89 03                	mov    %eax,(%ebx)
			M2[i] = malloc(sizeof(int) * NumOfElements) ;
  8001dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001ea:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8001ed:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001f0:	c1 e0 02             	shl    $0x2,%eax
  8001f3:	83 ec 0c             	sub    $0xc,%esp
  8001f6:	50                   	push   %eax
  8001f7:	e8 bb 1a 00 00       	call   801cb7 <malloc>
  8001fc:	83 c4 10             	add    $0x10,%esp
  8001ff:	89 03                	mov    %eax,(%ebx)
		sys_unlock_cons();

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
		int **M2 = malloc(sizeof(int) * NumOfElements) ;

		for (int i = 0; i < NumOfElements; ++i)
  800201:	ff 45 e4             	incl   -0x1c(%ebp)
  800204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800207:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80020a:	7c ad                	jl     8001b9 <_main+0x181>
			M1[i] = malloc(sizeof(int) * NumOfElements) ;
			M2[i] = malloc(sizeof(int) * NumOfElements) ;
		}

		int  i ;
		switch (Chose)
  80020c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800210:	83 f8 62             	cmp    $0x62,%eax
  800213:	74 2e                	je     800243 <_main+0x20b>
  800215:	83 f8 63             	cmp    $0x63,%eax
  800218:	74 53                	je     80026d <_main+0x235>
  80021a:	83 f8 61             	cmp    $0x61,%eax
  80021d:	75 72                	jne    800291 <_main+0x259>
		{
		case 'a':
			InitializeAscending(M1, NumOfElements);
  80021f:	83 ec 08             	sub    $0x8,%esp
  800222:	ff 75 d8             	pushl  -0x28(%ebp)
  800225:	ff 75 d4             	pushl  -0x2c(%ebp)
  800228:	e8 bf 05 00 00       	call   8007ec <InitializeAscending>
  80022d:	83 c4 10             	add    $0x10,%esp
			InitializeAscending(M2, NumOfElements);
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	ff 75 d8             	pushl  -0x28(%ebp)
  800236:	ff 75 d0             	pushl  -0x30(%ebp)
  800239:	e8 ae 05 00 00       	call   8007ec <InitializeAscending>
  80023e:	83 c4 10             	add    $0x10,%esp
			break ;
  800241:	eb 70                	jmp    8002b3 <_main+0x27b>
		case 'b':
			InitializeIdentical(M1, NumOfElements, val);
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	ff 75 f0             	pushl  -0x10(%ebp)
  800249:	ff 75 d8             	pushl  -0x28(%ebp)
  80024c:	ff 75 d4             	pushl  -0x2c(%ebp)
  80024f:	e8 e7 05 00 00       	call   80083b <InitializeIdentical>
  800254:	83 c4 10             	add    $0x10,%esp
			InitializeIdentical(M2, NumOfElements, val);
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	ff 75 f0             	pushl  -0x10(%ebp)
  80025d:	ff 75 d8             	pushl  -0x28(%ebp)
  800260:	ff 75 d0             	pushl  -0x30(%ebp)
  800263:	e8 d3 05 00 00       	call   80083b <InitializeIdentical>
  800268:	83 c4 10             	add    $0x10,%esp
			break ;
  80026b:	eb 46                	jmp    8002b3 <_main+0x27b>
		case 'c':
			InitializeSemiRandom(M1, NumOfElements);
  80026d:	83 ec 08             	sub    $0x8,%esp
  800270:	ff 75 d8             	pushl  -0x28(%ebp)
  800273:	ff 75 d4             	pushl  -0x2c(%ebp)
  800276:	e8 0f 06 00 00       	call   80088a <InitializeSemiRandom>
  80027b:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	ff 75 d8             	pushl  -0x28(%ebp)
  800284:	ff 75 d0             	pushl  -0x30(%ebp)
  800287:	e8 fe 05 00 00       	call   80088a <InitializeSemiRandom>
  80028c:	83 c4 10             	add    $0x10,%esp
			//PrintElements(M1, NumOfElements);
			break ;
  80028f:	eb 22                	jmp    8002b3 <_main+0x27b>
		default:
			InitializeSemiRandom(M1, NumOfElements);
  800291:	83 ec 08             	sub    $0x8,%esp
  800294:	ff 75 d8             	pushl  -0x28(%ebp)
  800297:	ff 75 d4             	pushl  -0x2c(%ebp)
  80029a:	e8 eb 05 00 00       	call   80088a <InitializeSemiRandom>
  80029f:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	ff 75 d8             	pushl  -0x28(%ebp)
  8002a8:	ff 75 d0             	pushl  -0x30(%ebp)
  8002ab:	e8 da 05 00 00       	call   80088a <InitializeSemiRandom>
  8002b0:	83 c4 10             	add    $0x10,%esp
		}

		sys_lock_cons();
  8002b3:	e8 23 1b 00 00       	call   801ddb <sys_lock_cons>
			//		cprintf("a) Addition       (+)\n") ;
			//		cprintf("b) Subtraction    (-)\n") ;
			//		cprintf("c) Multiplication (x)\n");
			do
			{
				cprintf("Select: ") ;
  8002b8:	83 ec 0c             	sub    $0xc,%esp
  8002bb:	68 ae 28 80 00       	push   $0x8028ae
  8002c0:	e8 9a 0a 00 00       	call   800d5f <cprintf>
  8002c5:	83 c4 10             	add    $0x10,%esp
				if (NumOfRep % 3 == 0) 		{ Chose = 'a'; cprintf("a) Add (+) \n");}
  8002c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002cb:	b9 03 00 00 00       	mov    $0x3,%ecx
  8002d0:	99                   	cltd   
  8002d1:	f7 f9                	idiv   %ecx
  8002d3:	89 d0                	mov    %edx,%eax
  8002d5:	85 c0                	test   %eax,%eax
  8002d7:	75 16                	jne    8002ef <_main+0x2b7>
  8002d9:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  8002dd:	83 ec 0c             	sub    $0xc,%esp
  8002e0:	68 e3 28 80 00       	push   $0x8028e3
  8002e5:	e8 75 0a 00 00       	call   800d5f <cprintf>
  8002ea:	83 c4 10             	add    $0x10,%esp
  8002ed:	eb 4e                	jmp    80033d <_main+0x305>
				else if (NumOfRep%3 == 1) 	{ Chose = 'b'; cprintf("b) Sub (-) \n");}
  8002ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f2:	b9 03 00 00 00       	mov    $0x3,%ecx
  8002f7:	99                   	cltd   
  8002f8:	f7 f9                	idiv   %ecx
  8002fa:	89 d0                	mov    %edx,%eax
  8002fc:	83 f8 01             	cmp    $0x1,%eax
  8002ff:	75 16                	jne    800317 <_main+0x2df>
  800301:	c6 45 f7 62          	movb   $0x62,-0x9(%ebp)
  800305:	83 ec 0c             	sub    $0xc,%esp
  800308:	68 f0 28 80 00       	push   $0x8028f0
  80030d:	e8 4d 0a 00 00       	call   800d5f <cprintf>
  800312:	83 c4 10             	add    $0x10,%esp
  800315:	eb 26                	jmp    80033d <_main+0x305>
				else if (NumOfRep%3 == 2) 	{ Chose = 'c'; cprintf("c) Mul (x) \n");}
  800317:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80031a:	b9 03 00 00 00       	mov    $0x3,%ecx
  80031f:	99                   	cltd   
  800320:	f7 f9                	idiv   %ecx
  800322:	89 d0                	mov    %edx,%eax
  800324:	83 f8 02             	cmp    $0x2,%eax
  800327:	75 14                	jne    80033d <_main+0x305>
  800329:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
  80032d:	83 ec 0c             	sub    $0xc,%esp
  800330:	68 fd 28 80 00       	push   $0x8028fd
  800335:	e8 25 0a 00 00       	call   800d5f <cprintf>
  80033a:	83 c4 10             	add    $0x10,%esp
				//			cputchar(Chose);
				//			cputchar('\n');
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80033d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800341:	74 10                	je     800353 <_main+0x31b>
  800343:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800347:	74 0a                	je     800353 <_main+0x31b>
  800349:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80034d:	0f 85 65 ff ff ff    	jne    8002b8 <_main+0x280>
		}
		sys_unlock_cons();
  800353:	e8 9d 1a 00 00       	call   801df5 <sys_unlock_cons>


		int64** Res = NULL ;
  800358:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		switch (Chose)
  80035f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800363:	83 f8 62             	cmp    $0x62,%eax
  800366:	74 23                	je     80038b <_main+0x353>
  800368:	83 f8 63             	cmp    $0x63,%eax
  80036b:	74 37                	je     8003a4 <_main+0x36c>
  80036d:	83 f8 61             	cmp    $0x61,%eax
  800370:	75 4b                	jne    8003bd <_main+0x385>
		{
		case 'a':
			Res = MatrixAddition(M1, M2, NumOfElements);
  800372:	83 ec 04             	sub    $0x4,%esp
  800375:	ff 75 d8             	pushl  -0x28(%ebp)
  800378:	ff 75 d0             	pushl  -0x30(%ebp)
  80037b:	ff 75 d4             	pushl  -0x2c(%ebp)
  80037e:	e8 af 02 00 00       	call   800632 <MatrixAddition>
  800383:	83 c4 10             	add    $0x10,%esp
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  800389:	eb 49                	jmp    8003d4 <_main+0x39c>
		case 'b':
			Res = MatrixSubtraction(M1, M2, NumOfElements);
  80038b:	83 ec 04             	sub    $0x4,%esp
  80038e:	ff 75 d8             	pushl  -0x28(%ebp)
  800391:	ff 75 d0             	pushl  -0x30(%ebp)
  800394:	ff 75 d4             	pushl  -0x2c(%ebp)
  800397:	e8 72 03 00 00       	call   80070e <MatrixSubtraction>
  80039c:	83 c4 10             	add    $0x10,%esp
  80039f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  8003a2:	eb 30                	jmp    8003d4 <_main+0x39c>
		case 'c':
			Res = MatrixMultiply(M1, M2, NumOfElements);
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	ff 75 d8             	pushl  -0x28(%ebp)
  8003aa:	ff 75 d0             	pushl  -0x30(%ebp)
  8003ad:	ff 75 d4             	pushl  -0x2c(%ebp)
  8003b0:	e8 2d 01 00 00       	call   8004e2 <MatrixMultiply>
  8003b5:	83 c4 10             	add    $0x10,%esp
  8003b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  8003bb:	eb 17                	jmp    8003d4 <_main+0x39c>
		default:
			Res = MatrixAddition(M1, M2, NumOfElements);
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	ff 75 d8             	pushl  -0x28(%ebp)
  8003c3:	ff 75 d0             	pushl  -0x30(%ebp)
  8003c6:	ff 75 d4             	pushl  -0x2c(%ebp)
  8003c9:	e8 64 02 00 00       	call   800632 <MatrixAddition>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
		}


		sys_lock_cons();
  8003d4:	e8 02 1a 00 00       	call   801ddb <sys_lock_cons>
		{
			cprintf("Operation is COMPLETED.\n");
  8003d9:	83 ec 0c             	sub    $0xc,%esp
  8003dc:	68 0a 29 80 00       	push   $0x80290a
  8003e1:	e8 79 09 00 00       	call   800d5f <cprintf>
  8003e6:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8003e9:	e8 07 1a 00 00       	call   801df5 <sys_unlock_cons>

		for (int i = 0; i < NumOfElements; ++i)
  8003ee:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8003f5:	eb 5a                	jmp    800451 <_main+0x419>
		{
			free(M1[i]);
  8003f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800404:	01 d0                	add    %edx,%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	83 ec 0c             	sub    $0xc,%esp
  80040b:	50                   	push   %eax
  80040c:	e8 d4 18 00 00       	call   801ce5 <free>
  800411:	83 c4 10             	add    $0x10,%esp
			free(M2[i]);
  800414:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800417:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800421:	01 d0                	add    %edx,%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	83 ec 0c             	sub    $0xc,%esp
  800428:	50                   	push   %eax
  800429:	e8 b7 18 00 00       	call   801ce5 <free>
  80042e:	83 c4 10             	add    $0x10,%esp
			free(Res[i]);
  800431:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800434:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80043e:	01 d0                	add    %edx,%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	83 ec 0c             	sub    $0xc,%esp
  800445:	50                   	push   %eax
  800446:	e8 9a 18 00 00       	call   801ce5 <free>
  80044b:	83 c4 10             	add    $0x10,%esp
		{
			cprintf("Operation is COMPLETED.\n");
		}
		sys_unlock_cons();

		for (int i = 0; i < NumOfElements; ++i)
  80044e:	ff 45 dc             	incl   -0x24(%ebp)
  800451:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800454:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800457:	7c 9e                	jl     8003f7 <_main+0x3bf>
		{
			free(M1[i]);
			free(M2[i]);
			free(Res[i]);
		}
		free(M1) ;
  800459:	83 ec 0c             	sub    $0xc,%esp
  80045c:	ff 75 d4             	pushl  -0x2c(%ebp)
  80045f:	e8 81 18 00 00       	call   801ce5 <free>
  800464:	83 c4 10             	add    $0x10,%esp
		free(M2) ;
  800467:	83 ec 0c             	sub    $0xc,%esp
  80046a:	ff 75 d0             	pushl  -0x30(%ebp)
  80046d:	e8 73 18 00 00       	call   801ce5 <free>
  800472:	83 c4 10             	add    $0x10,%esp
		free(Res) ;
  800475:	83 ec 0c             	sub    $0xc,%esp
  800478:	ff 75 e0             	pushl  -0x20(%ebp)
  80047b:	e8 65 18 00 00       	call   801ce5 <free>
  800480:	83 c4 10             	add    $0x10,%esp

		NumOfRep++ ;
  800483:	ff 45 ec             	incl   -0x14(%ebp)

		sys_lock_cons();
  800486:	e8 50 19 00 00       	call   801ddb <sys_lock_cons>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  80048b:	83 ec 0c             	sub    $0xc,%esp
  80048e:	68 23 29 80 00       	push   $0x802923
  800493:	e8 c7 08 00 00       	call   800d5f <cprintf>
  800498:	83 c4 10             	add    $0x10,%esp
			if (NumOfRep == 3)
  80049b:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
  80049f:	75 06                	jne    8004a7 <_main+0x46f>
				Chose = 'n' ;
  8004a1:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
  8004a5:	eb 04                	jmp    8004ab <_main+0x473>
			else
				Chose = 'y' ;
  8004a7:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
			cputchar(Chose);
  8004ab:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8004af:	83 ec 0c             	sub    $0xc,%esp
  8004b2:	50                   	push   %eax
  8004b3:	e8 25 05 00 00       	call   8009dd <cputchar>
  8004b8:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8004bb:	83 ec 0c             	sub    $0xc,%esp
  8004be:	6a 0a                	push   $0xa
  8004c0:	e8 18 05 00 00       	call   8009dd <cputchar>
  8004c5:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004c8:	e8 28 19 00 00       	call   801df5 <sys_unlock_cons>

	} while (Chose == 'y');
  8004cd:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8004d1:	0f 84 80 fb ff ff    	je     800057 <_main+0x1f>

	//To indicate that it's completed successfully
	inctst();
  8004d7:	e8 7f 1c 00 00       	call   80215b <inctst>
}
  8004dc:	90                   	nop
  8004dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004e0:	c9                   	leave  
  8004e1:	c3                   	ret    

008004e2 <MatrixMultiply>:

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
  8004e2:	55                   	push   %ebp
  8004e3:	89 e5                	mov    %esp,%ebp
  8004e5:	57                   	push   %edi
  8004e6:	56                   	push   %esi
  8004e7:	53                   	push   %ebx
  8004e8:	83 ec 2c             	sub    $0x2c,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  8004eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ee:	c1 e0 03             	shl    $0x3,%eax
  8004f1:	83 ec 0c             	sub    $0xc,%esp
  8004f4:	50                   	push   %eax
  8004f5:	e8 bd 17 00 00       	call   801cb7 <malloc>
  8004fa:	83 c4 10             	add    $0x10,%esp
  8004fd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  800500:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800507:	eb 27                	jmp    800530 <MatrixMultiply+0x4e>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800509:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80050c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800513:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800516:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800519:	8b 45 10             	mov    0x10(%ebp),%eax
  80051c:	c1 e0 03             	shl    $0x3,%eax
  80051f:	83 ec 0c             	sub    $0xc,%esp
  800522:	50                   	push   %eax
  800523:	e8 8f 17 00 00       	call   801cb7 <malloc>
  800528:	83 c4 10             	add    $0x10,%esp
  80052b:	89 03                	mov    %eax,(%ebx)

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  80052d:	ff 45 e4             	incl   -0x1c(%ebp)
  800530:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800533:	3b 45 10             	cmp    0x10(%ebp),%eax
  800536:	7c d1                	jl     800509 <MatrixMultiply+0x27>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800538:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80053f:	e9 d7 00 00 00       	jmp    80061b <MatrixMultiply+0x139>
	{
		for (int j = 0; j < NumOfElements; ++j)
  800544:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80054b:	e9 bc 00 00 00       	jmp    80060c <MatrixMultiply+0x12a>
		{
			Res[i][j] = 0 ;
  800550:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800553:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80055d:	01 d0                	add    %edx,%eax
  80055f:	8b 00                	mov    (%eax),%eax
  800561:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800564:	c1 e2 03             	shl    $0x3,%edx
  800567:	01 d0                	add    %edx,%eax
  800569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80056f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			for (int k = 0; k < NumOfElements; ++k)
  800576:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  80057d:	eb 7e                	jmp    8005fd <MatrixMultiply+0x11b>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
  80057f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800582:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800589:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80058c:	01 d0                	add    %edx,%eax
  80058e:	8b 00                	mov    (%eax),%eax
  800590:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800593:	c1 e2 03             	shl    $0x3,%edx
  800596:	8d 34 10             	lea    (%eax,%edx,1),%esi
  800599:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80059c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005a6:	01 d0                	add    %edx,%eax
  8005a8:	8b 00                	mov    (%eax),%eax
  8005aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005ad:	c1 e2 03             	shl    $0x3,%edx
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	8b 08                	mov    (%eax),%ecx
  8005b4:	8b 58 04             	mov    0x4(%eax),%ebx
  8005b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	01 d0                	add    %edx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8005cb:	c1 e2 02             	shl    $0x2,%edx
  8005ce:	01 d0                	add    %edx,%eax
  8005d0:	8b 10                	mov    (%eax),%edx
  8005d2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005d5:	8d 3c 85 00 00 00 00 	lea    0x0(,%eax,4),%edi
  8005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005df:	01 f8                	add    %edi,%eax
  8005e1:	8b 00                	mov    (%eax),%eax
  8005e3:	8b 7d dc             	mov    -0x24(%ebp),%edi
  8005e6:	c1 e7 02             	shl    $0x2,%edi
  8005e9:	01 f8                	add    %edi,%eax
  8005eb:	8b 00                	mov    (%eax),%eax
  8005ed:	0f af c2             	imul   %edx,%eax
  8005f0:	99                   	cltd   
  8005f1:	01 c8                	add    %ecx,%eax
  8005f3:	11 da                	adc    %ebx,%edx
  8005f5:	89 06                	mov    %eax,(%esi)
  8005f7:	89 56 04             	mov    %edx,0x4(%esi)
	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = 0 ;
			for (int k = 0; k < NumOfElements; ++k)
  8005fa:	ff 45 d8             	incl   -0x28(%ebp)
  8005fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800600:	3b 45 10             	cmp    0x10(%ebp),%eax
  800603:	0f 8c 76 ff ff ff    	jl     80057f <MatrixMultiply+0x9d>
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  800609:	ff 45 dc             	incl   -0x24(%ebp)
  80060c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80060f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800612:	0f 8c 38 ff ff ff    	jl     800550 <MatrixMultiply+0x6e>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800618:	ff 45 e0             	incl   -0x20(%ebp)
  80061b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800621:	0f 8c 1d ff ff ff    	jl     800544 <MatrixMultiply+0x62>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
			}
		}
	}
	return Res;
  800627:	8b 45 d4             	mov    -0x2c(%ebp),%eax
}
  80062a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80062d:	5b                   	pop    %ebx
  80062e:	5e                   	pop    %esi
  80062f:	5f                   	pop    %edi
  800630:	5d                   	pop    %ebp
  800631:	c3                   	ret    

00800632 <MatrixAddition>:

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
  800632:	55                   	push   %ebp
  800633:	89 e5                	mov    %esp,%ebp
  800635:	53                   	push   %ebx
  800636:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800639:	8b 45 10             	mov    0x10(%ebp),%eax
  80063c:	c1 e0 03             	shl    $0x3,%eax
  80063f:	83 ec 0c             	sub    $0xc,%esp
  800642:	50                   	push   %eax
  800643:	e8 6f 16 00 00       	call   801cb7 <malloc>
  800648:	83 c4 10             	add    $0x10,%esp
  80064b:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  80064e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800655:	eb 27                	jmp    80067e <MatrixAddition+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800657:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80065a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800661:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800664:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800667:	8b 45 10             	mov    0x10(%ebp),%eax
  80066a:	c1 e0 03             	shl    $0x3,%eax
  80066d:	83 ec 0c             	sub    $0xc,%esp
  800670:	50                   	push   %eax
  800671:	e8 41 16 00 00       	call   801cb7 <malloc>
  800676:	83 c4 10             	add    $0x10,%esp
  800679:	89 03                	mov    %eax,(%ebx)

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  80067b:	ff 45 f4             	incl   -0xc(%ebp)
  80067e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800681:	3b 45 10             	cmp    0x10(%ebp),%eax
  800684:	7c d1                	jl     800657 <MatrixAddition+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800686:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80068d:	eb 6f                	jmp    8006fe <MatrixAddition+0xcc>
	{
		for (int j = 0; j < NumOfElements; ++j)
  80068f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800696:	eb 5b                	jmp    8006f3 <MatrixAddition+0xc1>
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
  800698:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006a5:	01 d0                	add    %edx,%eax
  8006a7:	8b 00                	mov    (%eax),%eax
  8006a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006ac:	c1 e2 03             	shl    $0x3,%edx
  8006af:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  8006b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	01 d0                	add    %edx,%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c6:	c1 e2 02             	shl    $0x2,%edx
  8006c9:	01 d0                	add    %edx,%eax
  8006cb:	8b 10                	mov    (%eax),%edx
  8006cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d0:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8006d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006da:	01 d8                	add    %ebx,%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8006e1:	c1 e3 02             	shl    $0x2,%ebx
  8006e4:	01 d8                	add    %ebx,%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	01 d0                	add    %edx,%eax
  8006ea:	99                   	cltd   
  8006eb:	89 01                	mov    %eax,(%ecx)
  8006ed:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  8006f0:	ff 45 ec             	incl   -0x14(%ebp)
  8006f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8006f9:	7c 9d                	jl     800698 <MatrixAddition+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8006fb:	ff 45 f0             	incl   -0x10(%ebp)
  8006fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800701:	3b 45 10             	cmp    0x10(%ebp),%eax
  800704:	7c 89                	jl     80068f <MatrixAddition+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
		}
	}
	return Res;
  800706:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  800709:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80070c:	c9                   	leave  
  80070d:	c3                   	ret    

0080070e <MatrixSubtraction>:

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
  800711:	53                   	push   %ebx
  800712:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800715:	8b 45 10             	mov    0x10(%ebp),%eax
  800718:	c1 e0 03             	shl    $0x3,%eax
  80071b:	83 ec 0c             	sub    $0xc,%esp
  80071e:	50                   	push   %eax
  80071f:	e8 93 15 00 00       	call   801cb7 <malloc>
  800724:	83 c4 10             	add    $0x10,%esp
  800727:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  80072a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800731:	eb 27                	jmp    80075a <MatrixSubtraction+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800733:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800736:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80073d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800740:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800743:	8b 45 10             	mov    0x10(%ebp),%eax
  800746:	c1 e0 03             	shl    $0x3,%eax
  800749:	83 ec 0c             	sub    $0xc,%esp
  80074c:	50                   	push   %eax
  80074d:	e8 65 15 00 00       	call   801cb7 <malloc>
  800752:	83 c4 10             	add    $0x10,%esp
  800755:	89 03                	mov    %eax,(%ebx)

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800757:	ff 45 f4             	incl   -0xc(%ebp)
  80075a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80075d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800760:	7c d1                	jl     800733 <MatrixSubtraction+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800762:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800769:	eb 71                	jmp    8007dc <MatrixSubtraction+0xce>
	{
		for (int j = 0; j < NumOfElements; ++j)
  80076b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800772:	eb 5d                	jmp    8007d1 <MatrixSubtraction+0xc3>
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
  800774:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800777:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80077e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800781:	01 d0                	add    %edx,%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800788:	c1 e2 03             	shl    $0x3,%edx
  80078b:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  80078e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800791:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	01 d0                	add    %edx,%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007a2:	c1 e2 02             	shl    $0x2,%edx
  8007a5:	01 d0                	add    %edx,%eax
  8007a7:	8b 10                	mov    (%eax),%edx
  8007a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ac:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8007b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b6:	01 d8                	add    %ebx,%eax
  8007b8:	8b 00                	mov    (%eax),%eax
  8007ba:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8007bd:	c1 e3 02             	shl    $0x2,%ebx
  8007c0:	01 d8                	add    %ebx,%eax
  8007c2:	8b 00                	mov    (%eax),%eax
  8007c4:	29 c2                	sub    %eax,%edx
  8007c6:	89 d0                	mov    %edx,%eax
  8007c8:	99                   	cltd   
  8007c9:	89 01                	mov    %eax,(%ecx)
  8007cb:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  8007ce:	ff 45 ec             	incl   -0x14(%ebp)
  8007d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007d7:	7c 9b                	jl     800774 <MatrixSubtraction+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8007d9:	ff 45 f0             	incl   -0x10(%ebp)
  8007dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007df:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007e2:	7c 87                	jl     80076b <MatrixSubtraction+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
		}
	}
	return Res;
  8007e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  8007e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007ea:	c9                   	leave  
  8007eb:	c3                   	ret    

008007ec <InitializeAscending>:

///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
  8007ec:	55                   	push   %ebp
  8007ed:	89 e5                	mov    %esp,%ebp
  8007ef:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8007f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8007f9:	eb 35                	jmp    800830 <InitializeAscending+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8007fb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800802:	eb 21                	jmp    800825 <InitializeAscending+0x39>
		{
			(Elements)[i][j] = j ;
  800804:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800807:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	01 d0                	add    %edx,%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800818:	c1 e2 02             	shl    $0x2,%edx
  80081b:	01 c2                	add    %eax,%edx
  80081d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800820:	89 02                	mov    %eax,(%edx)
void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800822:	ff 45 f8             	incl   -0x8(%ebp)
  800825:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800828:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80082b:	7c d7                	jl     800804 <InitializeAscending+0x18>
///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80082d:	ff 45 fc             	incl   -0x4(%ebp)
  800830:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800833:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800836:	7c c3                	jl     8007fb <InitializeAscending+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = j ;
		}
	}
}
  800838:	90                   	nop
  800839:	c9                   	leave  
  80083a:	c3                   	ret    

0080083b <InitializeIdentical>:

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
  80083b:	55                   	push   %ebp
  80083c:	89 e5                	mov    %esp,%ebp
  80083e:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800841:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800848:	eb 35                	jmp    80087f <InitializeIdentical+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80084a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800851:	eb 21                	jmp    800874 <InitializeIdentical+0x39>
		{
			(Elements)[i][j] = value ;
  800853:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800856:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80085d:	8b 45 08             	mov    0x8(%ebp),%eax
  800860:	01 d0                	add    %edx,%eax
  800862:	8b 00                	mov    (%eax),%eax
  800864:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800867:	c1 e2 02             	shl    $0x2,%edx
  80086a:	01 c2                	add    %eax,%edx
  80086c:	8b 45 10             	mov    0x10(%ebp),%eax
  80086f:	89 02                	mov    %eax,(%edx)
void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800871:	ff 45 f8             	incl   -0x8(%ebp)
  800874:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800877:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087a:	7c d7                	jl     800853 <InitializeIdentical+0x18>
}

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80087c:	ff 45 fc             	incl   -0x4(%ebp)
  80087f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800882:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800885:	7c c3                	jl     80084a <InitializeIdentical+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = value ;
		}
	}
}
  800887:	90                   	nop
  800888:	c9                   	leave  
  800889:	c3                   	ret    

0080088a <InitializeSemiRandom>:

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
  80088a:	55                   	push   %ebp
  80088b:	89 e5                	mov    %esp,%ebp
  80088d:	53                   	push   %ebx
  80088e:	83 ec 20             	sub    $0x20,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800891:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800898:	eb 56                	jmp    8008f0 <InitializeSemiRandom+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80089a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8008a1:	eb 42                	jmp    8008e5 <InitializeSemiRandom+0x5b>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
  8008a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8008a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b7:	c1 e2 02             	shl    $0x2,%edx
  8008ba:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  8008bd:	0f 31                	rdtsc  
  8008bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008c2:	89 55 e8             	mov    %edx,-0x18(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  8008c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008c8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ce:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8008d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008d4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8008d7:	ba 00 00 00 00       	mov    $0x0,%edx
  8008dc:	f7 f3                	div    %ebx
  8008de:	89 d0                	mov    %edx,%eax
  8008e0:	89 01                	mov    %eax,(%ecx)
void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8008e2:	ff 45 f4             	incl   -0xc(%ebp)
  8008e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008eb:	7c b6                	jl     8008a3 <InitializeSemiRandom+0x19>
}

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8008ed:	ff 45 f8             	incl   -0x8(%ebp)
  8008f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8008f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008f6:	7c a2                	jl     80089a <InitializeSemiRandom+0x10>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
			//	cprintf("i=%d\n",i);
		}
	}
}
  8008f8:	90                   	nop
  8008f9:	83 c4 20             	add    $0x20,%esp
  8008fc:	5b                   	pop    %ebx
  8008fd:	5d                   	pop    %ebp
  8008fe:	c3                   	ret    

008008ff <PrintElements>:

void PrintElements(int **Elements, int NumOfElements)
{
  8008ff:	55                   	push   %ebp
  800900:	89 e5                	mov    %esp,%ebp
  800902:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800905:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80090c:	eb 53                	jmp    800961 <PrintElements+0x62>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80090e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800915:	eb 2f                	jmp    800946 <PrintElements+0x47>
		{
			cprintf("%~%d, ",Elements[i][j]);
  800917:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80091a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	01 d0                	add    %edx,%eax
  800926:	8b 00                	mov    (%eax),%eax
  800928:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80092b:	c1 e2 02             	shl    $0x2,%edx
  80092e:	01 d0                	add    %edx,%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	50                   	push   %eax
  800936:	68 41 29 80 00       	push   $0x802941
  80093b:	e8 1f 04 00 00       	call   800d5f <cprintf>
  800940:	83 c4 10             	add    $0x10,%esp
void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800943:	ff 45 f0             	incl   -0x10(%ebp)
  800946:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800949:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80094c:	7c c9                	jl     800917 <PrintElements+0x18>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
  80094e:	83 ec 0c             	sub    $0xc,%esp
  800951:	68 48 29 80 00       	push   $0x802948
  800956:	e8 04 04 00 00       	call   800d5f <cprintf>
  80095b:	83 c4 10             	add    $0x10,%esp
}

void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80095e:	ff 45 f4             	incl   -0xc(%ebp)
  800961:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800964:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800967:	7c a5                	jl     80090e <PrintElements+0xf>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  800969:	90                   	nop
  80096a:	c9                   	leave  
  80096b:	c3                   	ret    

0080096c <PrintElements64>:

void PrintElements64(int64 **Elements, int NumOfElements)
{
  80096c:	55                   	push   %ebp
  80096d:	89 e5                	mov    %esp,%ebp
  80096f:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800972:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800979:	eb 57                	jmp    8009d2 <PrintElements64+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80097b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800982:	eb 33                	jmp    8009b7 <PrintElements64+0x4b>
		{
			cprintf("%~%lld, ",Elements[i][j]);
  800984:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800987:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	01 d0                	add    %edx,%eax
  800993:	8b 00                	mov    (%eax),%eax
  800995:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800998:	c1 e2 03             	shl    $0x3,%edx
  80099b:	01 d0                	add    %edx,%eax
  80099d:	8b 50 04             	mov    0x4(%eax),%edx
  8009a0:	8b 00                	mov    (%eax),%eax
  8009a2:	83 ec 04             	sub    $0x4,%esp
  8009a5:	52                   	push   %edx
  8009a6:	50                   	push   %eax
  8009a7:	68 4c 29 80 00       	push   $0x80294c
  8009ac:	e8 ae 03 00 00       	call   800d5f <cprintf>
  8009b1:	83 c4 10             	add    $0x10,%esp
void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8009b4:	ff 45 f0             	incl   -0x10(%ebp)
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ba:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009bd:	7c c5                	jl     800984 <PrintElements64+0x18>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
  8009bf:	83 ec 0c             	sub    $0xc,%esp
  8009c2:	68 48 29 80 00       	push   $0x802948
  8009c7:	e8 93 03 00 00       	call   800d5f <cprintf>
  8009cc:	83 c4 10             	add    $0x10,%esp
}

void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8009cf:	ff 45 f4             	incl   -0xc(%ebp)
  8009d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009d5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009d8:	7c a1                	jl     80097b <PrintElements64+0xf>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  8009da:	90                   	nop
  8009db:	c9                   	leave  
  8009dc:	c3                   	ret    

008009dd <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8009dd:	55                   	push   %ebp
  8009de:	89 e5                	mov    %esp,%ebp
  8009e0:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8009e9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8009ed:	83 ec 0c             	sub    $0xc,%esp
  8009f0:	50                   	push   %eax
  8009f1:	e8 2d 15 00 00       	call   801f23 <sys_cputc>
  8009f6:	83 c4 10             	add    $0x10,%esp
}
  8009f9:	90                   	nop
  8009fa:	c9                   	leave  
  8009fb:	c3                   	ret    

008009fc <getchar>:


int
getchar(void)
{
  8009fc:	55                   	push   %ebp
  8009fd:	89 e5                	mov    %esp,%ebp
  8009ff:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  800a02:	e8 bb 13 00 00       	call   801dc2 <sys_cgetc>
  800a07:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a0a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a0e:	74 f2                	je     800a02 <getchar+0x6>
	return c;
  800a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a13:	c9                   	leave  
  800a14:	c3                   	ret    

00800a15 <iscons>:

int iscons(int fdnum)
{
  800a15:	55                   	push   %ebp
  800a16:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800a18:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800a1d:	5d                   	pop    %ebp
  800a1e:	c3                   	ret    

00800a1f <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800a1f:	55                   	push   %ebp
  800a20:	89 e5                	mov    %esp,%ebp
  800a22:	57                   	push   %edi
  800a23:	56                   	push   %esi
  800a24:	53                   	push   %ebx
  800a25:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800a2b:	e8 23 16 00 00       	call   802053 <sys_getenvindex>
  800a30:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800a33:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a36:	89 d0                	mov    %edx,%eax
  800a38:	c1 e0 03             	shl    $0x3,%eax
  800a3b:	01 d0                	add    %edx,%eax
  800a3d:	c1 e0 06             	shl    $0x6,%eax
  800a40:	01 d0                	add    %edx,%eax
  800a42:	c1 e0 03             	shl    $0x3,%eax
  800a45:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a4a:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a4f:	a1 20 40 80 00       	mov    0x804020,%eax
  800a54:	8a 40 10             	mov    0x10(%eax),%al
  800a57:	84 c0                	test   %al,%al
  800a59:	74 0d                	je     800a68 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800a5b:	a1 20 40 80 00       	mov    0x804020,%eax
  800a60:	83 c0 10             	add    $0x10,%eax
  800a63:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a68:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a6c:	7e 0a                	jle    800a78 <libmain+0x59>
		binaryname = argv[0];
  800a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a71:	8b 00                	mov    (%eax),%eax
  800a73:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  800a78:	83 ec 08             	sub    $0x8,%esp
  800a7b:	ff 75 0c             	pushl  0xc(%ebp)
  800a7e:	ff 75 08             	pushl  0x8(%ebp)
  800a81:	e8 b2 f5 ff ff       	call   800038 <_main>
  800a86:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800a89:	a1 00 40 80 00       	mov    0x804000,%eax
  800a8e:	85 c0                	test   %eax,%eax
  800a90:	0f 84 b7 01 00 00    	je     800c4d <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800a96:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800a9c:	bb 94 2a 80 00       	mov    $0x802a94,%ebx
  800aa1:	ba 0e 00 00 00       	mov    $0xe,%edx
  800aa6:	89 c7                	mov    %eax,%edi
  800aa8:	89 de                	mov    %ebx,%esi
  800aaa:	89 d1                	mov    %edx,%ecx
  800aac:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800aae:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800ab4:	b9 56 00 00 00       	mov    $0x56,%ecx
  800ab9:	b0 00                	mov    $0x0,%al
  800abb:	89 d7                	mov    %edx,%edi
  800abd:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800abf:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800ac6:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	50                   	push   %eax
  800acd:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800ad3:	50                   	push   %eax
  800ad4:	e8 7a 17 00 00       	call   802253 <sys_utilities>
  800ad9:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800adc:	e8 fa 12 00 00       	call   801ddb <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800ae1:	83 ec 0c             	sub    $0xc,%esp
  800ae4:	68 70 29 80 00       	push   $0x802970
  800ae9:	e8 71 02 00 00       	call   800d5f <cprintf>
  800aee:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800af1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800af4:	85 c0                	test   %eax,%eax
  800af6:	74 58                	je     800b50 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800af8:	e8 74 17 00 00       	call   802271 <sys_get_optimal_num_faults>
  800afd:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800b00:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b06:	bb f8 2a 80 00       	mov    $0x802af8,%ebx
  800b0b:	ba 11 00 00 00       	mov    $0x11,%edx
  800b10:	89 c7                	mov    %eax,%edi
  800b12:	89 de                	mov    %ebx,%esi
  800b14:	89 d1                	mov    %edx,%ecx
  800b16:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800b18:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800b1b:	b9 53 00 00 00       	mov    $0x53,%ecx
  800b20:	b0 00                	mov    $0x0,%al
  800b22:	89 d7                	mov    %edx,%edi
  800b24:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800b26:	83 ec 08             	sub    $0x8,%esp
  800b29:	ff 75 dc             	pushl  -0x24(%ebp)
  800b2c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b32:	50                   	push   %eax
  800b33:	e8 1b 17 00 00       	call   802253 <sys_utilities>
  800b38:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800b3b:	83 ec 08             	sub    $0x8,%esp
  800b3e:	ff 75 dc             	pushl  -0x24(%ebp)
  800b41:	68 98 29 80 00       	push   $0x802998
  800b46:	e8 14 02 00 00       	call   800d5f <cprintf>
  800b4b:	83 c4 10             	add    $0x10,%esp
  800b4e:	eb 59                	jmp    800ba9 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b50:	a1 20 40 80 00       	mov    0x804020,%eax
  800b55:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800b5b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b60:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800b66:	83 ec 04             	sub    $0x4,%esp
  800b69:	52                   	push   %edx
  800b6a:	50                   	push   %eax
  800b6b:	68 bc 29 80 00       	push   $0x8029bc
  800b70:	e8 ea 01 00 00       	call   800d5f <cprintf>
  800b75:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800b78:	a1 20 40 80 00       	mov    0x804020,%eax
  800b7d:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800b83:	a1 20 40 80 00       	mov    0x804020,%eax
  800b88:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800b8e:	a1 20 40 80 00       	mov    0x804020,%eax
  800b93:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800b99:	51                   	push   %ecx
  800b9a:	52                   	push   %edx
  800b9b:	50                   	push   %eax
  800b9c:	68 e4 29 80 00       	push   $0x8029e4
  800ba1:	e8 b9 01 00 00       	call   800d5f <cprintf>
  800ba6:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800ba9:	a1 20 40 80 00       	mov    0x804020,%eax
  800bae:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	50                   	push   %eax
  800bb8:	68 3c 2a 80 00       	push   $0x802a3c
  800bbd:	e8 9d 01 00 00       	call   800d5f <cprintf>
  800bc2:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800bc5:	83 ec 0c             	sub    $0xc,%esp
  800bc8:	68 50 2a 80 00       	push   $0x802a50
  800bcd:	e8 8d 01 00 00       	call   800d5f <cprintf>
  800bd2:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800bd5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800bdc:	eb 28                	jmp    800c06 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800bde:	a1 20 40 80 00       	mov    0x804020,%eax
  800be3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800be6:	81 c2 74 04 00 00    	add    $0x474,%edx
  800bec:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800bef:	83 ec 04             	sub    $0x4,%esp
  800bf2:	50                   	push   %eax
  800bf3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bf6:	68 67 2a 80 00       	push   $0x802a67
  800bfb:	e8 5f 01 00 00       	call   800d5f <cprintf>
  800c00:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800c03:	ff 45 e4             	incl   -0x1c(%ebp)
  800c06:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800c0a:	7e d2                	jle    800bde <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800c0c:	83 ec 0c             	sub    $0xc,%esp
  800c0f:	68 76 2a 80 00       	push   $0x802a76
  800c14:	e8 46 01 00 00       	call   800d5f <cprintf>
  800c19:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800c1c:	a1 20 40 80 00       	mov    0x804020,%eax
  800c21:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800c27:	83 ec 08             	sub    $0x8,%esp
  800c2a:	50                   	push   %eax
  800c2b:	68 7a 2a 80 00       	push   $0x802a7a
  800c30:	e8 2a 01 00 00       	call   800d5f <cprintf>
  800c35:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800c38:	83 ec 0c             	sub    $0xc,%esp
  800c3b:	68 70 29 80 00       	push   $0x802970
  800c40:	e8 1a 01 00 00       	call   800d5f <cprintf>
  800c45:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800c48:	e8 a8 11 00 00       	call   801df5 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800c4d:	e8 1f 00 00 00       	call   800c71 <exit>
}
  800c52:	90                   	nop
  800c53:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800c56:	5b                   	pop    %ebx
  800c57:	5e                   	pop    %esi
  800c58:	5f                   	pop    %edi
  800c59:	5d                   	pop    %ebp
  800c5a:	c3                   	ret    

00800c5b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
  800c5e:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800c61:	83 ec 0c             	sub    $0xc,%esp
  800c64:	6a 00                	push   $0x0
  800c66:	e8 b4 13 00 00       	call   80201f <sys_destroy_env>
  800c6b:	83 c4 10             	add    $0x10,%esp
}
  800c6e:	90                   	nop
  800c6f:	c9                   	leave  
  800c70:	c3                   	ret    

00800c71 <exit>:

void
exit(void)
{
  800c71:	55                   	push   %ebp
  800c72:	89 e5                	mov    %esp,%ebp
  800c74:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800c77:	e8 09 14 00 00       	call   802085 <sys_exit_env>
}
  800c7c:	90                   	nop
  800c7d:	c9                   	leave  
  800c7e:	c3                   	ret    

00800c7f <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800c7f:	55                   	push   %ebp
  800c80:	89 e5                	mov    %esp,%ebp
  800c82:	53                   	push   %ebx
  800c83:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800c86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c89:	8b 00                	mov    (%eax),%eax
  800c8b:	8d 48 01             	lea    0x1(%eax),%ecx
  800c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c91:	89 0a                	mov    %ecx,(%edx)
  800c93:	8b 55 08             	mov    0x8(%ebp),%edx
  800c96:	88 d1                	mov    %dl,%cl
  800c98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ca9:	75 30                	jne    800cdb <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800cab:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800cb1:	a0 40 40 80 00       	mov    0x804040,%al
  800cb6:	0f b6 c0             	movzbl %al,%eax
  800cb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800cbc:	8b 09                	mov    (%ecx),%ecx
  800cbe:	89 cb                	mov    %ecx,%ebx
  800cc0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800cc3:	83 c1 08             	add    $0x8,%ecx
  800cc6:	52                   	push   %edx
  800cc7:	50                   	push   %eax
  800cc8:	53                   	push   %ebx
  800cc9:	51                   	push   %ecx
  800cca:	e8 c8 10 00 00       	call   801d97 <sys_cputs>
  800ccf:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800cd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cde:	8b 40 04             	mov    0x4(%eax),%eax
  800ce1:	8d 50 01             	lea    0x1(%eax),%edx
  800ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce7:	89 50 04             	mov    %edx,0x4(%eax)
}
  800cea:	90                   	nop
  800ceb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cee:	c9                   	leave  
  800cef:	c3                   	ret    

00800cf0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
  800cf3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800cf9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800d00:	00 00 00 
	b.cnt = 0;
  800d03:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800d0a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	ff 75 08             	pushl  0x8(%ebp)
  800d13:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d19:	50                   	push   %eax
  800d1a:	68 7f 0c 80 00       	push   $0x800c7f
  800d1f:	e8 5a 02 00 00       	call   800f7e <vprintfmt>
  800d24:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800d27:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800d2d:	a0 40 40 80 00       	mov    0x804040,%al
  800d32:	0f b6 c0             	movzbl %al,%eax
  800d35:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800d3b:	52                   	push   %edx
  800d3c:	50                   	push   %eax
  800d3d:	51                   	push   %ecx
  800d3e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d44:	83 c0 08             	add    $0x8,%eax
  800d47:	50                   	push   %eax
  800d48:	e8 4a 10 00 00       	call   801d97 <sys_cputs>
  800d4d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d50:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800d57:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d65:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800d6c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	83 ec 08             	sub    $0x8,%esp
  800d78:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7b:	50                   	push   %eax
  800d7c:	e8 6f ff ff ff       	call   800cf0 <vcprintf>
  800d81:	83 c4 10             	add    $0x10,%esp
  800d84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800d87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d8a:	c9                   	leave  
  800d8b:	c3                   	ret    

00800d8c <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800d8c:	55                   	push   %ebp
  800d8d:	89 e5                	mov    %esp,%ebp
  800d8f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d92:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	c1 e0 08             	shl    $0x8,%eax
  800d9f:	a3 28 41 80 00       	mov    %eax,0x804128
	va_start(ap, fmt);
  800da4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800da7:	83 c0 04             	add    $0x4,%eax
  800daa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	83 ec 08             	sub    $0x8,%esp
  800db3:	ff 75 f4             	pushl  -0xc(%ebp)
  800db6:	50                   	push   %eax
  800db7:	e8 34 ff ff ff       	call   800cf0 <vcprintf>
  800dbc:	83 c4 10             	add    $0x10,%esp
  800dbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800dc2:	c7 05 28 41 80 00 00 	movl   $0x700,0x804128
  800dc9:	07 00 00 

	return cnt;
  800dcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dcf:	c9                   	leave  
  800dd0:	c3                   	ret    

00800dd1 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800dd1:	55                   	push   %ebp
  800dd2:	89 e5                	mov    %esp,%ebp
  800dd4:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800dd7:	e8 ff 0f 00 00       	call   801ddb <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800ddc:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ddf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 f4             	pushl  -0xc(%ebp)
  800deb:	50                   	push   %eax
  800dec:	e8 ff fe ff ff       	call   800cf0 <vcprintf>
  800df1:	83 c4 10             	add    $0x10,%esp
  800df4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800df7:	e8 f9 0f 00 00       	call   801df5 <sys_unlock_cons>
	return cnt;
  800dfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dff:	c9                   	leave  
  800e00:	c3                   	ret    

00800e01 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800e01:	55                   	push   %ebp
  800e02:	89 e5                	mov    %esp,%ebp
  800e04:	53                   	push   %ebx
  800e05:	83 ec 14             	sub    $0x14,%esp
  800e08:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e11:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800e14:	8b 45 18             	mov    0x18(%ebp),%eax
  800e17:	ba 00 00 00 00       	mov    $0x0,%edx
  800e1c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e1f:	77 55                	ja     800e76 <printnum+0x75>
  800e21:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e24:	72 05                	jb     800e2b <printnum+0x2a>
  800e26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e29:	77 4b                	ja     800e76 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800e2b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800e2e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800e31:	8b 45 18             	mov    0x18(%ebp),%eax
  800e34:	ba 00 00 00 00       	mov    $0x0,%edx
  800e39:	52                   	push   %edx
  800e3a:	50                   	push   %eax
  800e3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800e3e:	ff 75 f0             	pushl  -0x10(%ebp)
  800e41:	e8 7a 17 00 00       	call   8025c0 <__udivdi3>
  800e46:	83 c4 10             	add    $0x10,%esp
  800e49:	83 ec 04             	sub    $0x4,%esp
  800e4c:	ff 75 20             	pushl  0x20(%ebp)
  800e4f:	53                   	push   %ebx
  800e50:	ff 75 18             	pushl  0x18(%ebp)
  800e53:	52                   	push   %edx
  800e54:	50                   	push   %eax
  800e55:	ff 75 0c             	pushl  0xc(%ebp)
  800e58:	ff 75 08             	pushl  0x8(%ebp)
  800e5b:	e8 a1 ff ff ff       	call   800e01 <printnum>
  800e60:	83 c4 20             	add    $0x20,%esp
  800e63:	eb 1a                	jmp    800e7f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	ff 75 20             	pushl  0x20(%ebp)
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e76:	ff 4d 1c             	decl   0x1c(%ebp)
  800e79:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e7d:	7f e6                	jg     800e65 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e7f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e82:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8d:	53                   	push   %ebx
  800e8e:	51                   	push   %ecx
  800e8f:	52                   	push   %edx
  800e90:	50                   	push   %eax
  800e91:	e8 3a 18 00 00       	call   8026d0 <__umoddi3>
  800e96:	83 c4 10             	add    $0x10,%esp
  800e99:	05 74 2d 80 00       	add    $0x802d74,%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	0f be c0             	movsbl %al,%eax
  800ea3:	83 ec 08             	sub    $0x8,%esp
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	50                   	push   %eax
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	ff d0                	call   *%eax
  800eaf:	83 c4 10             	add    $0x10,%esp
}
  800eb2:	90                   	nop
  800eb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800eb6:	c9                   	leave  
  800eb7:	c3                   	ret    

00800eb8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800eb8:	55                   	push   %ebp
  800eb9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ebb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ebf:	7e 1c                	jle    800edd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8b 00                	mov    (%eax),%eax
  800ec6:	8d 50 08             	lea    0x8(%eax),%edx
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	89 10                	mov    %edx,(%eax)
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8b 00                	mov    (%eax),%eax
  800ed3:	83 e8 08             	sub    $0x8,%eax
  800ed6:	8b 50 04             	mov    0x4(%eax),%edx
  800ed9:	8b 00                	mov    (%eax),%eax
  800edb:	eb 40                	jmp    800f1d <getuint+0x65>
	else if (lflag)
  800edd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ee1:	74 1e                	je     800f01 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	8b 00                	mov    (%eax),%eax
  800ee8:	8d 50 04             	lea    0x4(%eax),%edx
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	89 10                	mov    %edx,(%eax)
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8b 00                	mov    (%eax),%eax
  800ef5:	83 e8 04             	sub    $0x4,%eax
  800ef8:	8b 00                	mov    (%eax),%eax
  800efa:	ba 00 00 00 00       	mov    $0x0,%edx
  800eff:	eb 1c                	jmp    800f1d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8b 00                	mov    (%eax),%eax
  800f06:	8d 50 04             	lea    0x4(%eax),%edx
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	89 10                	mov    %edx,(%eax)
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8b 00                	mov    (%eax),%eax
  800f13:	83 e8 04             	sub    $0x4,%eax
  800f16:	8b 00                	mov    (%eax),%eax
  800f18:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800f1d:	5d                   	pop    %ebp
  800f1e:	c3                   	ret    

00800f1f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800f1f:	55                   	push   %ebp
  800f20:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800f22:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800f26:	7e 1c                	jle    800f44 <getint+0x25>
		return va_arg(*ap, long long);
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8b 00                	mov    (%eax),%eax
  800f2d:	8d 50 08             	lea    0x8(%eax),%edx
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	89 10                	mov    %edx,(%eax)
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8b 00                	mov    (%eax),%eax
  800f3a:	83 e8 08             	sub    $0x8,%eax
  800f3d:	8b 50 04             	mov    0x4(%eax),%edx
  800f40:	8b 00                	mov    (%eax),%eax
  800f42:	eb 38                	jmp    800f7c <getint+0x5d>
	else if (lflag)
  800f44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f48:	74 1a                	je     800f64 <getint+0x45>
		return va_arg(*ap, long);
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8b 00                	mov    (%eax),%eax
  800f4f:	8d 50 04             	lea    0x4(%eax),%edx
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	89 10                	mov    %edx,(%eax)
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8b 00                	mov    (%eax),%eax
  800f5c:	83 e8 04             	sub    $0x4,%eax
  800f5f:	8b 00                	mov    (%eax),%eax
  800f61:	99                   	cltd   
  800f62:	eb 18                	jmp    800f7c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8b 00                	mov    (%eax),%eax
  800f69:	8d 50 04             	lea    0x4(%eax),%edx
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	89 10                	mov    %edx,(%eax)
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8b 00                	mov    (%eax),%eax
  800f76:	83 e8 04             	sub    $0x4,%eax
  800f79:	8b 00                	mov    (%eax),%eax
  800f7b:	99                   	cltd   
}
  800f7c:	5d                   	pop    %ebp
  800f7d:	c3                   	ret    

00800f7e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	56                   	push   %esi
  800f82:	53                   	push   %ebx
  800f83:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f86:	eb 17                	jmp    800f9f <vprintfmt+0x21>
			if (ch == '\0')
  800f88:	85 db                	test   %ebx,%ebx
  800f8a:	0f 84 c1 03 00 00    	je     801351 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800f90:	83 ec 08             	sub    $0x8,%esp
  800f93:	ff 75 0c             	pushl  0xc(%ebp)
  800f96:	53                   	push   %ebx
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	ff d0                	call   *%eax
  800f9c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	8d 50 01             	lea    0x1(%eax),%edx
  800fa5:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f b6 d8             	movzbl %al,%ebx
  800fad:	83 fb 25             	cmp    $0x25,%ebx
  800fb0:	75 d6                	jne    800f88 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800fb2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800fb6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800fbd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800fc4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800fcb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd5:	8d 50 01             	lea    0x1(%eax),%edx
  800fd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	0f b6 d8             	movzbl %al,%ebx
  800fe0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800fe3:	83 f8 5b             	cmp    $0x5b,%eax
  800fe6:	0f 87 3d 03 00 00    	ja     801329 <vprintfmt+0x3ab>
  800fec:	8b 04 85 98 2d 80 00 	mov    0x802d98(,%eax,4),%eax
  800ff3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ff5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ff9:	eb d7                	jmp    800fd2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ffb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800fff:	eb d1                	jmp    800fd2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801001:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801008:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80100b:	89 d0                	mov    %edx,%eax
  80100d:	c1 e0 02             	shl    $0x2,%eax
  801010:	01 d0                	add    %edx,%eax
  801012:	01 c0                	add    %eax,%eax
  801014:	01 d8                	add    %ebx,%eax
  801016:	83 e8 30             	sub    $0x30,%eax
  801019:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80101c:	8b 45 10             	mov    0x10(%ebp),%eax
  80101f:	8a 00                	mov    (%eax),%al
  801021:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801024:	83 fb 2f             	cmp    $0x2f,%ebx
  801027:	7e 3e                	jle    801067 <vprintfmt+0xe9>
  801029:	83 fb 39             	cmp    $0x39,%ebx
  80102c:	7f 39                	jg     801067 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80102e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801031:	eb d5                	jmp    801008 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801033:	8b 45 14             	mov    0x14(%ebp),%eax
  801036:	83 c0 04             	add    $0x4,%eax
  801039:	89 45 14             	mov    %eax,0x14(%ebp)
  80103c:	8b 45 14             	mov    0x14(%ebp),%eax
  80103f:	83 e8 04             	sub    $0x4,%eax
  801042:	8b 00                	mov    (%eax),%eax
  801044:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801047:	eb 1f                	jmp    801068 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801049:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80104d:	79 83                	jns    800fd2 <vprintfmt+0x54>
				width = 0;
  80104f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801056:	e9 77 ff ff ff       	jmp    800fd2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80105b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801062:	e9 6b ff ff ff       	jmp    800fd2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801067:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801068:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80106c:	0f 89 60 ff ff ff    	jns    800fd2 <vprintfmt+0x54>
				width = precision, precision = -1;
  801072:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801075:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801078:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80107f:	e9 4e ff ff ff       	jmp    800fd2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801084:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801087:	e9 46 ff ff ff       	jmp    800fd2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80108c:	8b 45 14             	mov    0x14(%ebp),%eax
  80108f:	83 c0 04             	add    $0x4,%eax
  801092:	89 45 14             	mov    %eax,0x14(%ebp)
  801095:	8b 45 14             	mov    0x14(%ebp),%eax
  801098:	83 e8 04             	sub    $0x4,%eax
  80109b:	8b 00                	mov    (%eax),%eax
  80109d:	83 ec 08             	sub    $0x8,%esp
  8010a0:	ff 75 0c             	pushl  0xc(%ebp)
  8010a3:	50                   	push   %eax
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	ff d0                	call   *%eax
  8010a9:	83 c4 10             	add    $0x10,%esp
			break;
  8010ac:	e9 9b 02 00 00       	jmp    80134c <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8010b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b4:	83 c0 04             	add    $0x4,%eax
  8010b7:	89 45 14             	mov    %eax,0x14(%ebp)
  8010ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8010bd:	83 e8 04             	sub    $0x4,%eax
  8010c0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8010c2:	85 db                	test   %ebx,%ebx
  8010c4:	79 02                	jns    8010c8 <vprintfmt+0x14a>
				err = -err;
  8010c6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8010c8:	83 fb 64             	cmp    $0x64,%ebx
  8010cb:	7f 0b                	jg     8010d8 <vprintfmt+0x15a>
  8010cd:	8b 34 9d e0 2b 80 00 	mov    0x802be0(,%ebx,4),%esi
  8010d4:	85 f6                	test   %esi,%esi
  8010d6:	75 19                	jne    8010f1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8010d8:	53                   	push   %ebx
  8010d9:	68 85 2d 80 00       	push   $0x802d85
  8010de:	ff 75 0c             	pushl  0xc(%ebp)
  8010e1:	ff 75 08             	pushl  0x8(%ebp)
  8010e4:	e8 70 02 00 00       	call   801359 <printfmt>
  8010e9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8010ec:	e9 5b 02 00 00       	jmp    80134c <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8010f1:	56                   	push   %esi
  8010f2:	68 8e 2d 80 00       	push   $0x802d8e
  8010f7:	ff 75 0c             	pushl  0xc(%ebp)
  8010fa:	ff 75 08             	pushl  0x8(%ebp)
  8010fd:	e8 57 02 00 00       	call   801359 <printfmt>
  801102:	83 c4 10             	add    $0x10,%esp
			break;
  801105:	e9 42 02 00 00       	jmp    80134c <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80110a:	8b 45 14             	mov    0x14(%ebp),%eax
  80110d:	83 c0 04             	add    $0x4,%eax
  801110:	89 45 14             	mov    %eax,0x14(%ebp)
  801113:	8b 45 14             	mov    0x14(%ebp),%eax
  801116:	83 e8 04             	sub    $0x4,%eax
  801119:	8b 30                	mov    (%eax),%esi
  80111b:	85 f6                	test   %esi,%esi
  80111d:	75 05                	jne    801124 <vprintfmt+0x1a6>
				p = "(null)";
  80111f:	be 91 2d 80 00       	mov    $0x802d91,%esi
			if (width > 0 && padc != '-')
  801124:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801128:	7e 6d                	jle    801197 <vprintfmt+0x219>
  80112a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80112e:	74 67                	je     801197 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801130:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801133:	83 ec 08             	sub    $0x8,%esp
  801136:	50                   	push   %eax
  801137:	56                   	push   %esi
  801138:	e8 1e 03 00 00       	call   80145b <strnlen>
  80113d:	83 c4 10             	add    $0x10,%esp
  801140:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801143:	eb 16                	jmp    80115b <vprintfmt+0x1dd>
					putch(padc, putdat);
  801145:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801149:	83 ec 08             	sub    $0x8,%esp
  80114c:	ff 75 0c             	pushl  0xc(%ebp)
  80114f:	50                   	push   %eax
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	ff d0                	call   *%eax
  801155:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801158:	ff 4d e4             	decl   -0x1c(%ebp)
  80115b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80115f:	7f e4                	jg     801145 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801161:	eb 34                	jmp    801197 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801163:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801167:	74 1c                	je     801185 <vprintfmt+0x207>
  801169:	83 fb 1f             	cmp    $0x1f,%ebx
  80116c:	7e 05                	jle    801173 <vprintfmt+0x1f5>
  80116e:	83 fb 7e             	cmp    $0x7e,%ebx
  801171:	7e 12                	jle    801185 <vprintfmt+0x207>
					putch('?', putdat);
  801173:	83 ec 08             	sub    $0x8,%esp
  801176:	ff 75 0c             	pushl  0xc(%ebp)
  801179:	6a 3f                	push   $0x3f
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	ff d0                	call   *%eax
  801180:	83 c4 10             	add    $0x10,%esp
  801183:	eb 0f                	jmp    801194 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801185:	83 ec 08             	sub    $0x8,%esp
  801188:	ff 75 0c             	pushl  0xc(%ebp)
  80118b:	53                   	push   %ebx
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	ff d0                	call   *%eax
  801191:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801194:	ff 4d e4             	decl   -0x1c(%ebp)
  801197:	89 f0                	mov    %esi,%eax
  801199:	8d 70 01             	lea    0x1(%eax),%esi
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	0f be d8             	movsbl %al,%ebx
  8011a1:	85 db                	test   %ebx,%ebx
  8011a3:	74 24                	je     8011c9 <vprintfmt+0x24b>
  8011a5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011a9:	78 b8                	js     801163 <vprintfmt+0x1e5>
  8011ab:	ff 4d e0             	decl   -0x20(%ebp)
  8011ae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011b2:	79 af                	jns    801163 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011b4:	eb 13                	jmp    8011c9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8011b6:	83 ec 08             	sub    $0x8,%esp
  8011b9:	ff 75 0c             	pushl  0xc(%ebp)
  8011bc:	6a 20                	push   $0x20
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	ff d0                	call   *%eax
  8011c3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011c6:	ff 4d e4             	decl   -0x1c(%ebp)
  8011c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011cd:	7f e7                	jg     8011b6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8011cf:	e9 78 01 00 00       	jmp    80134c <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8011d4:	83 ec 08             	sub    $0x8,%esp
  8011d7:	ff 75 e8             	pushl  -0x18(%ebp)
  8011da:	8d 45 14             	lea    0x14(%ebp),%eax
  8011dd:	50                   	push   %eax
  8011de:	e8 3c fd ff ff       	call   800f1f <getint>
  8011e3:	83 c4 10             	add    $0x10,%esp
  8011e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8011ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011f2:	85 d2                	test   %edx,%edx
  8011f4:	79 23                	jns    801219 <vprintfmt+0x29b>
				putch('-', putdat);
  8011f6:	83 ec 08             	sub    $0x8,%esp
  8011f9:	ff 75 0c             	pushl  0xc(%ebp)
  8011fc:	6a 2d                	push   $0x2d
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	ff d0                	call   *%eax
  801203:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801206:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801209:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80120c:	f7 d8                	neg    %eax
  80120e:	83 d2 00             	adc    $0x0,%edx
  801211:	f7 da                	neg    %edx
  801213:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801216:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801219:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801220:	e9 bc 00 00 00       	jmp    8012e1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801225:	83 ec 08             	sub    $0x8,%esp
  801228:	ff 75 e8             	pushl  -0x18(%ebp)
  80122b:	8d 45 14             	lea    0x14(%ebp),%eax
  80122e:	50                   	push   %eax
  80122f:	e8 84 fc ff ff       	call   800eb8 <getuint>
  801234:	83 c4 10             	add    $0x10,%esp
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80123a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80123d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801244:	e9 98 00 00 00       	jmp    8012e1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801249:	83 ec 08             	sub    $0x8,%esp
  80124c:	ff 75 0c             	pushl  0xc(%ebp)
  80124f:	6a 58                	push   $0x58
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
  801254:	ff d0                	call   *%eax
  801256:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801259:	83 ec 08             	sub    $0x8,%esp
  80125c:	ff 75 0c             	pushl  0xc(%ebp)
  80125f:	6a 58                	push   $0x58
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	ff d0                	call   *%eax
  801266:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801269:	83 ec 08             	sub    $0x8,%esp
  80126c:	ff 75 0c             	pushl  0xc(%ebp)
  80126f:	6a 58                	push   $0x58
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	ff d0                	call   *%eax
  801276:	83 c4 10             	add    $0x10,%esp
			break;
  801279:	e9 ce 00 00 00       	jmp    80134c <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80127e:	83 ec 08             	sub    $0x8,%esp
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	6a 30                	push   $0x30
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	ff d0                	call   *%eax
  80128b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80128e:	83 ec 08             	sub    $0x8,%esp
  801291:	ff 75 0c             	pushl  0xc(%ebp)
  801294:	6a 78                	push   $0x78
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	ff d0                	call   *%eax
  80129b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80129e:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a1:	83 c0 04             	add    $0x4,%eax
  8012a4:	89 45 14             	mov    %eax,0x14(%ebp)
  8012a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012aa:	83 e8 04             	sub    $0x4,%eax
  8012ad:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8012af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8012b9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8012c0:	eb 1f                	jmp    8012e1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8012c2:	83 ec 08             	sub    $0x8,%esp
  8012c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8012c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8012cb:	50                   	push   %eax
  8012cc:	e8 e7 fb ff ff       	call   800eb8 <getuint>
  8012d1:	83 c4 10             	add    $0x10,%esp
  8012d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8012da:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8012e1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8012e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012e8:	83 ec 04             	sub    $0x4,%esp
  8012eb:	52                   	push   %edx
  8012ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012ef:	50                   	push   %eax
  8012f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8012f3:	ff 75 f0             	pushl  -0x10(%ebp)
  8012f6:	ff 75 0c             	pushl  0xc(%ebp)
  8012f9:	ff 75 08             	pushl  0x8(%ebp)
  8012fc:	e8 00 fb ff ff       	call   800e01 <printnum>
  801301:	83 c4 20             	add    $0x20,%esp
			break;
  801304:	eb 46                	jmp    80134c <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801306:	83 ec 08             	sub    $0x8,%esp
  801309:	ff 75 0c             	pushl  0xc(%ebp)
  80130c:	53                   	push   %ebx
  80130d:	8b 45 08             	mov    0x8(%ebp),%eax
  801310:	ff d0                	call   *%eax
  801312:	83 c4 10             	add    $0x10,%esp
			break;
  801315:	eb 35                	jmp    80134c <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801317:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  80131e:	eb 2c                	jmp    80134c <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801320:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801327:	eb 23                	jmp    80134c <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801329:	83 ec 08             	sub    $0x8,%esp
  80132c:	ff 75 0c             	pushl  0xc(%ebp)
  80132f:	6a 25                	push   $0x25
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	ff d0                	call   *%eax
  801336:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801339:	ff 4d 10             	decl   0x10(%ebp)
  80133c:	eb 03                	jmp    801341 <vprintfmt+0x3c3>
  80133e:	ff 4d 10             	decl   0x10(%ebp)
  801341:	8b 45 10             	mov    0x10(%ebp),%eax
  801344:	48                   	dec    %eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	3c 25                	cmp    $0x25,%al
  801349:	75 f3                	jne    80133e <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80134b:	90                   	nop
		}
	}
  80134c:	e9 35 fc ff ff       	jmp    800f86 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801351:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801352:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801355:	5b                   	pop    %ebx
  801356:	5e                   	pop    %esi
  801357:	5d                   	pop    %ebp
  801358:	c3                   	ret    

00801359 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
  80135c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80135f:	8d 45 10             	lea    0x10(%ebp),%eax
  801362:	83 c0 04             	add    $0x4,%eax
  801365:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801368:	8b 45 10             	mov    0x10(%ebp),%eax
  80136b:	ff 75 f4             	pushl  -0xc(%ebp)
  80136e:	50                   	push   %eax
  80136f:	ff 75 0c             	pushl  0xc(%ebp)
  801372:	ff 75 08             	pushl  0x8(%ebp)
  801375:	e8 04 fc ff ff       	call   800f7e <vprintfmt>
  80137a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80137d:	90                   	nop
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801383:	8b 45 0c             	mov    0xc(%ebp),%eax
  801386:	8b 40 08             	mov    0x8(%eax),%eax
  801389:	8d 50 01             	lea    0x1(%eax),%edx
  80138c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801392:	8b 45 0c             	mov    0xc(%ebp),%eax
  801395:	8b 10                	mov    (%eax),%edx
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	8b 40 04             	mov    0x4(%eax),%eax
  80139d:	39 c2                	cmp    %eax,%edx
  80139f:	73 12                	jae    8013b3 <sprintputch+0x33>
		*b->buf++ = ch;
  8013a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a4:	8b 00                	mov    (%eax),%eax
  8013a6:	8d 48 01             	lea    0x1(%eax),%ecx
  8013a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ac:	89 0a                	mov    %ecx,(%edx)
  8013ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b1:	88 10                	mov    %dl,(%eax)
}
  8013b3:	90                   	nop
  8013b4:	5d                   	pop    %ebp
  8013b5:	c3                   	ret    

008013b6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
  8013b9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	01 d0                	add    %edx,%eax
  8013cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8013d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013db:	74 06                	je     8013e3 <vsnprintf+0x2d>
  8013dd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013e1:	7f 07                	jg     8013ea <vsnprintf+0x34>
		return -E_INVAL;
  8013e3:	b8 03 00 00 00       	mov    $0x3,%eax
  8013e8:	eb 20                	jmp    80140a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8013ea:	ff 75 14             	pushl  0x14(%ebp)
  8013ed:	ff 75 10             	pushl  0x10(%ebp)
  8013f0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8013f3:	50                   	push   %eax
  8013f4:	68 80 13 80 00       	push   $0x801380
  8013f9:	e8 80 fb ff ff       	call   800f7e <vprintfmt>
  8013fe:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801401:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801404:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801407:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
  80140f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801412:	8d 45 10             	lea    0x10(%ebp),%eax
  801415:	83 c0 04             	add    $0x4,%eax
  801418:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80141b:	8b 45 10             	mov    0x10(%ebp),%eax
  80141e:	ff 75 f4             	pushl  -0xc(%ebp)
  801421:	50                   	push   %eax
  801422:	ff 75 0c             	pushl  0xc(%ebp)
  801425:	ff 75 08             	pushl  0x8(%ebp)
  801428:	e8 89 ff ff ff       	call   8013b6 <vsnprintf>
  80142d:	83 c4 10             	add    $0x10,%esp
  801430:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801433:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
  80143b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80143e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801445:	eb 06                	jmp    80144d <strlen+0x15>
		n++;
  801447:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80144a:	ff 45 08             	incl   0x8(%ebp)
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	84 c0                	test   %al,%al
  801454:	75 f1                	jne    801447 <strlen+0xf>
		n++;
	return n;
  801456:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801459:	c9                   	leave  
  80145a:	c3                   	ret    

0080145b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
  80145e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801461:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801468:	eb 09                	jmp    801473 <strnlen+0x18>
		n++;
  80146a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80146d:	ff 45 08             	incl   0x8(%ebp)
  801470:	ff 4d 0c             	decl   0xc(%ebp)
  801473:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801477:	74 09                	je     801482 <strnlen+0x27>
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	75 e8                	jne    80146a <strnlen+0xf>
		n++;
	return n;
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801493:	90                   	nop
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8d 50 01             	lea    0x1(%eax),%edx
  80149a:	89 55 08             	mov    %edx,0x8(%ebp)
  80149d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014a6:	8a 12                	mov    (%edx),%dl
  8014a8:	88 10                	mov    %dl,(%eax)
  8014aa:	8a 00                	mov    (%eax),%al
  8014ac:	84 c0                	test   %al,%al
  8014ae:	75 e4                	jne    801494 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014c8:	eb 1f                	jmp    8014e9 <strncpy+0x34>
		*dst++ = *src;
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8d 50 01             	lea    0x1(%eax),%edx
  8014d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8014d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d6:	8a 12                	mov    (%edx),%dl
  8014d8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dd:	8a 00                	mov    (%eax),%al
  8014df:	84 c0                	test   %al,%al
  8014e1:	74 03                	je     8014e6 <strncpy+0x31>
			src++;
  8014e3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014e6:	ff 45 fc             	incl   -0x4(%ebp)
  8014e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ef:	72 d9                	jb     8014ca <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
  8014f9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801502:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801506:	74 30                	je     801538 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801508:	eb 16                	jmp    801520 <strlcpy+0x2a>
			*dst++ = *src++;
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	8d 50 01             	lea    0x1(%eax),%edx
  801510:	89 55 08             	mov    %edx,0x8(%ebp)
  801513:	8b 55 0c             	mov    0xc(%ebp),%edx
  801516:	8d 4a 01             	lea    0x1(%edx),%ecx
  801519:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80151c:	8a 12                	mov    (%edx),%dl
  80151e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801520:	ff 4d 10             	decl   0x10(%ebp)
  801523:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801527:	74 09                	je     801532 <strlcpy+0x3c>
  801529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152c:	8a 00                	mov    (%eax),%al
  80152e:	84 c0                	test   %al,%al
  801530:	75 d8                	jne    80150a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801538:	8b 55 08             	mov    0x8(%ebp),%edx
  80153b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153e:	29 c2                	sub    %eax,%edx
  801540:	89 d0                	mov    %edx,%eax
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801547:	eb 06                	jmp    80154f <strcmp+0xb>
		p++, q++;
  801549:	ff 45 08             	incl   0x8(%ebp)
  80154c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	84 c0                	test   %al,%al
  801556:	74 0e                	je     801566 <strcmp+0x22>
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	8a 10                	mov    (%eax),%dl
  80155d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801560:	8a 00                	mov    (%eax),%al
  801562:	38 c2                	cmp    %al,%dl
  801564:	74 e3                	je     801549 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	8a 00                	mov    (%eax),%al
  80156b:	0f b6 d0             	movzbl %al,%edx
  80156e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801571:	8a 00                	mov    (%eax),%al
  801573:	0f b6 c0             	movzbl %al,%eax
  801576:	29 c2                	sub    %eax,%edx
  801578:	89 d0                	mov    %edx,%eax
}
  80157a:	5d                   	pop    %ebp
  80157b:	c3                   	ret    

0080157c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80157c:	55                   	push   %ebp
  80157d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80157f:	eb 09                	jmp    80158a <strncmp+0xe>
		n--, p++, q++;
  801581:	ff 4d 10             	decl   0x10(%ebp)
  801584:	ff 45 08             	incl   0x8(%ebp)
  801587:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80158a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80158e:	74 17                	je     8015a7 <strncmp+0x2b>
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
  801593:	8a 00                	mov    (%eax),%al
  801595:	84 c0                	test   %al,%al
  801597:	74 0e                	je     8015a7 <strncmp+0x2b>
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 10                	mov    (%eax),%dl
  80159e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	38 c2                	cmp    %al,%dl
  8015a5:	74 da                	je     801581 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8015a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ab:	75 07                	jne    8015b4 <strncmp+0x38>
		return 0;
  8015ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8015b2:	eb 14                	jmp    8015c8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	8a 00                	mov    (%eax),%al
  8015b9:	0f b6 d0             	movzbl %al,%edx
  8015bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	0f b6 c0             	movzbl %al,%eax
  8015c4:	29 c2                	sub    %eax,%edx
  8015c6:	89 d0                	mov    %edx,%eax
}
  8015c8:	5d                   	pop    %ebp
  8015c9:	c3                   	ret    

008015ca <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015ca:	55                   	push   %ebp
  8015cb:	89 e5                	mov    %esp,%ebp
  8015cd:	83 ec 04             	sub    $0x4,%esp
  8015d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d6:	eb 12                	jmp    8015ea <strchr+0x20>
		if (*s == c)
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e0:	75 05                	jne    8015e7 <strchr+0x1d>
			return (char *) s;
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	eb 11                	jmp    8015f8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015e7:	ff 45 08             	incl   0x8(%ebp)
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	84 c0                	test   %al,%al
  8015f1:	75 e5                	jne    8015d8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
  8015fd:	83 ec 04             	sub    $0x4,%esp
  801600:	8b 45 0c             	mov    0xc(%ebp),%eax
  801603:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801606:	eb 0d                	jmp    801615 <strfind+0x1b>
		if (*s == c)
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	8a 00                	mov    (%eax),%al
  80160d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801610:	74 0e                	je     801620 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801612:	ff 45 08             	incl   0x8(%ebp)
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	8a 00                	mov    (%eax),%al
  80161a:	84 c0                	test   %al,%al
  80161c:	75 ea                	jne    801608 <strfind+0xe>
  80161e:	eb 01                	jmp    801621 <strfind+0x27>
		if (*s == c)
			break;
  801620:	90                   	nop
	return (char *) s;
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
  801629:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801632:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801636:	76 63                	jbe    80169b <memset+0x75>
		uint64 data_block = c;
  801638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163b:	99                   	cltd   
  80163c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80163f:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801642:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801645:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801648:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  80164c:	c1 e0 08             	shl    $0x8,%eax
  80164f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801652:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801655:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801658:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80165b:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  80165f:	c1 e0 10             	shl    $0x10,%eax
  801662:	09 45 f0             	or     %eax,-0x10(%ebp)
  801665:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80166b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80166e:	89 c2                	mov    %eax,%edx
  801670:	b8 00 00 00 00       	mov    $0x0,%eax
  801675:	09 45 f0             	or     %eax,-0x10(%ebp)
  801678:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80167b:	eb 18                	jmp    801695 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  80167d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801680:	8d 41 08             	lea    0x8(%ecx),%eax
  801683:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801686:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801689:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168c:	89 01                	mov    %eax,(%ecx)
  80168e:	89 51 04             	mov    %edx,0x4(%ecx)
  801691:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801695:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801699:	77 e2                	ja     80167d <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80169b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169f:	74 23                	je     8016c4 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8016a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016a7:	eb 0e                	jmp    8016b7 <memset+0x91>
			*p8++ = (uint8)c;
  8016a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ac:	8d 50 01             	lea    0x1(%eax),%edx
  8016af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b5:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8016b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c0:	85 c0                	test   %eax,%eax
  8016c2:	75 e5                	jne    8016a9 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8016cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8016db:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8016df:	76 24                	jbe    801705 <memcpy+0x3c>
		while(n >= 8){
  8016e1:	eb 1c                	jmp    8016ff <memcpy+0x36>
			*d64 = *s64;
  8016e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e6:	8b 50 04             	mov    0x4(%eax),%edx
  8016e9:	8b 00                	mov    (%eax),%eax
  8016eb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016ee:	89 01                	mov    %eax,(%ecx)
  8016f0:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8016f3:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8016f7:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8016fb:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8016ff:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801703:	77 de                	ja     8016e3 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801705:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801709:	74 31                	je     80173c <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80170b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801711:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801714:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801717:	eb 16                	jmp    80172f <memcpy+0x66>
			*d8++ = *s8++;
  801719:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80171c:	8d 50 01             	lea    0x1(%eax),%edx
  80171f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801722:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801725:	8d 4a 01             	lea    0x1(%edx),%ecx
  801728:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80172b:	8a 12                	mov    (%edx),%dl
  80172d:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80172f:	8b 45 10             	mov    0x10(%ebp),%eax
  801732:	8d 50 ff             	lea    -0x1(%eax),%edx
  801735:	89 55 10             	mov    %edx,0x10(%ebp)
  801738:	85 c0                	test   %eax,%eax
  80173a:	75 dd                	jne    801719 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
  801744:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801747:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80174d:	8b 45 08             	mov    0x8(%ebp),%eax
  801750:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801753:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801756:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801759:	73 50                	jae    8017ab <memmove+0x6a>
  80175b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80175e:	8b 45 10             	mov    0x10(%ebp),%eax
  801761:	01 d0                	add    %edx,%eax
  801763:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801766:	76 43                	jbe    8017ab <memmove+0x6a>
		s += n;
  801768:	8b 45 10             	mov    0x10(%ebp),%eax
  80176b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80176e:	8b 45 10             	mov    0x10(%ebp),%eax
  801771:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801774:	eb 10                	jmp    801786 <memmove+0x45>
			*--d = *--s;
  801776:	ff 4d f8             	decl   -0x8(%ebp)
  801779:	ff 4d fc             	decl   -0x4(%ebp)
  80177c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80177f:	8a 10                	mov    (%eax),%dl
  801781:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801784:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801786:	8b 45 10             	mov    0x10(%ebp),%eax
  801789:	8d 50 ff             	lea    -0x1(%eax),%edx
  80178c:	89 55 10             	mov    %edx,0x10(%ebp)
  80178f:	85 c0                	test   %eax,%eax
  801791:	75 e3                	jne    801776 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801793:	eb 23                	jmp    8017b8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801795:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801798:	8d 50 01             	lea    0x1(%eax),%edx
  80179b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80179e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017a4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017a7:	8a 12                	mov    (%edx),%dl
  8017a9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8017ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8017b4:	85 c0                	test   %eax,%eax
  8017b6:	75 dd                	jne    801795 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8017b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
  8017c0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8017c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8017c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8017cf:	eb 2a                	jmp    8017fb <memcmp+0x3e>
		if (*s1 != *s2)
  8017d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017d4:	8a 10                	mov    (%eax),%dl
  8017d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d9:	8a 00                	mov    (%eax),%al
  8017db:	38 c2                	cmp    %al,%dl
  8017dd:	74 16                	je     8017f5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017e2:	8a 00                	mov    (%eax),%al
  8017e4:	0f b6 d0             	movzbl %al,%edx
  8017e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ea:	8a 00                	mov    (%eax),%al
  8017ec:	0f b6 c0             	movzbl %al,%eax
  8017ef:	29 c2                	sub    %eax,%edx
  8017f1:	89 d0                	mov    %edx,%eax
  8017f3:	eb 18                	jmp    80180d <memcmp+0x50>
		s1++, s2++;
  8017f5:	ff 45 fc             	incl   -0x4(%ebp)
  8017f8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801801:	89 55 10             	mov    %edx,0x10(%ebp)
  801804:	85 c0                	test   %eax,%eax
  801806:	75 c9                	jne    8017d1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801808:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
  801812:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801815:	8b 55 08             	mov    0x8(%ebp),%edx
  801818:	8b 45 10             	mov    0x10(%ebp),%eax
  80181b:	01 d0                	add    %edx,%eax
  80181d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801820:	eb 15                	jmp    801837 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801822:	8b 45 08             	mov    0x8(%ebp),%eax
  801825:	8a 00                	mov    (%eax),%al
  801827:	0f b6 d0             	movzbl %al,%edx
  80182a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182d:	0f b6 c0             	movzbl %al,%eax
  801830:	39 c2                	cmp    %eax,%edx
  801832:	74 0d                	je     801841 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801834:	ff 45 08             	incl   0x8(%ebp)
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80183d:	72 e3                	jb     801822 <memfind+0x13>
  80183f:	eb 01                	jmp    801842 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801841:	90                   	nop
	return (void *) s;
  801842:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
  80184a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80184d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801854:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80185b:	eb 03                	jmp    801860 <strtol+0x19>
		s++;
  80185d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	8a 00                	mov    (%eax),%al
  801865:	3c 20                	cmp    $0x20,%al
  801867:	74 f4                	je     80185d <strtol+0x16>
  801869:	8b 45 08             	mov    0x8(%ebp),%eax
  80186c:	8a 00                	mov    (%eax),%al
  80186e:	3c 09                	cmp    $0x9,%al
  801870:	74 eb                	je     80185d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	8a 00                	mov    (%eax),%al
  801877:	3c 2b                	cmp    $0x2b,%al
  801879:	75 05                	jne    801880 <strtol+0x39>
		s++;
  80187b:	ff 45 08             	incl   0x8(%ebp)
  80187e:	eb 13                	jmp    801893 <strtol+0x4c>
	else if (*s == '-')
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	8a 00                	mov    (%eax),%al
  801885:	3c 2d                	cmp    $0x2d,%al
  801887:	75 0a                	jne    801893 <strtol+0x4c>
		s++, neg = 1;
  801889:	ff 45 08             	incl   0x8(%ebp)
  80188c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801893:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801897:	74 06                	je     80189f <strtol+0x58>
  801899:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80189d:	75 20                	jne    8018bf <strtol+0x78>
  80189f:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a2:	8a 00                	mov    (%eax),%al
  8018a4:	3c 30                	cmp    $0x30,%al
  8018a6:	75 17                	jne    8018bf <strtol+0x78>
  8018a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ab:	40                   	inc    %eax
  8018ac:	8a 00                	mov    (%eax),%al
  8018ae:	3c 78                	cmp    $0x78,%al
  8018b0:	75 0d                	jne    8018bf <strtol+0x78>
		s += 2, base = 16;
  8018b2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8018b6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8018bd:	eb 28                	jmp    8018e7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8018bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018c3:	75 15                	jne    8018da <strtol+0x93>
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	3c 30                	cmp    $0x30,%al
  8018cc:	75 0c                	jne    8018da <strtol+0x93>
		s++, base = 8;
  8018ce:	ff 45 08             	incl   0x8(%ebp)
  8018d1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8018d8:	eb 0d                	jmp    8018e7 <strtol+0xa0>
	else if (base == 0)
  8018da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018de:	75 07                	jne    8018e7 <strtol+0xa0>
		base = 10;
  8018e0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	8a 00                	mov    (%eax),%al
  8018ec:	3c 2f                	cmp    $0x2f,%al
  8018ee:	7e 19                	jle    801909 <strtol+0xc2>
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	8a 00                	mov    (%eax),%al
  8018f5:	3c 39                	cmp    $0x39,%al
  8018f7:	7f 10                	jg     801909 <strtol+0xc2>
			dig = *s - '0';
  8018f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fc:	8a 00                	mov    (%eax),%al
  8018fe:	0f be c0             	movsbl %al,%eax
  801901:	83 e8 30             	sub    $0x30,%eax
  801904:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801907:	eb 42                	jmp    80194b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	8a 00                	mov    (%eax),%al
  80190e:	3c 60                	cmp    $0x60,%al
  801910:	7e 19                	jle    80192b <strtol+0xe4>
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	8a 00                	mov    (%eax),%al
  801917:	3c 7a                	cmp    $0x7a,%al
  801919:	7f 10                	jg     80192b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	8a 00                	mov    (%eax),%al
  801920:	0f be c0             	movsbl %al,%eax
  801923:	83 e8 57             	sub    $0x57,%eax
  801926:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801929:	eb 20                	jmp    80194b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	8a 00                	mov    (%eax),%al
  801930:	3c 40                	cmp    $0x40,%al
  801932:	7e 39                	jle    80196d <strtol+0x126>
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	8a 00                	mov    (%eax),%al
  801939:	3c 5a                	cmp    $0x5a,%al
  80193b:	7f 30                	jg     80196d <strtol+0x126>
			dig = *s - 'A' + 10;
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	8a 00                	mov    (%eax),%al
  801942:	0f be c0             	movsbl %al,%eax
  801945:	83 e8 37             	sub    $0x37,%eax
  801948:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80194b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80194e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801951:	7d 19                	jge    80196c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801953:	ff 45 08             	incl   0x8(%ebp)
  801956:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801959:	0f af 45 10          	imul   0x10(%ebp),%eax
  80195d:	89 c2                	mov    %eax,%edx
  80195f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801962:	01 d0                	add    %edx,%eax
  801964:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801967:	e9 7b ff ff ff       	jmp    8018e7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80196c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80196d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801971:	74 08                	je     80197b <strtol+0x134>
		*endptr = (char *) s;
  801973:	8b 45 0c             	mov    0xc(%ebp),%eax
  801976:	8b 55 08             	mov    0x8(%ebp),%edx
  801979:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80197b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80197f:	74 07                	je     801988 <strtol+0x141>
  801981:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801984:	f7 d8                	neg    %eax
  801986:	eb 03                	jmp    80198b <strtol+0x144>
  801988:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <ltostr>:

void
ltostr(long value, char *str)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
  801990:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801993:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80199a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8019a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019a5:	79 13                	jns    8019ba <ltostr+0x2d>
	{
		neg = 1;
  8019a7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8019ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8019b4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8019b7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8019c2:	99                   	cltd   
  8019c3:	f7 f9                	idiv   %ecx
  8019c5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8019c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019cb:	8d 50 01             	lea    0x1(%eax),%edx
  8019ce:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019d1:	89 c2                	mov    %eax,%edx
  8019d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d6:	01 d0                	add    %edx,%eax
  8019d8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019db:	83 c2 30             	add    $0x30,%edx
  8019de:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019e3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019e8:	f7 e9                	imul   %ecx
  8019ea:	c1 fa 02             	sar    $0x2,%edx
  8019ed:	89 c8                	mov    %ecx,%eax
  8019ef:	c1 f8 1f             	sar    $0x1f,%eax
  8019f2:	29 c2                	sub    %eax,%edx
  8019f4:	89 d0                	mov    %edx,%eax
  8019f6:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8019f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019fd:	75 bb                	jne    8019ba <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a06:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a09:	48                   	dec    %eax
  801a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a0d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a11:	74 3d                	je     801a50 <ltostr+0xc3>
		start = 1 ;
  801a13:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a1a:	eb 34                	jmp    801a50 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a22:	01 d0                	add    %edx,%eax
  801a24:	8a 00                	mov    (%eax),%al
  801a26:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a29:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2f:	01 c2                	add    %eax,%edx
  801a31:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a37:	01 c8                	add    %ecx,%eax
  801a39:	8a 00                	mov    (%eax),%al
  801a3b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a3d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a43:	01 c2                	add    %eax,%edx
  801a45:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a48:	88 02                	mov    %al,(%edx)
		start++ ;
  801a4a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a4d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a53:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a56:	7c c4                	jl     801a1c <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a58:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5e:	01 d0                	add    %edx,%eax
  801a60:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a63:	90                   	nop
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
  801a69:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a6c:	ff 75 08             	pushl  0x8(%ebp)
  801a6f:	e8 c4 f9 ff ff       	call   801438 <strlen>
  801a74:	83 c4 04             	add    $0x4,%esp
  801a77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a7a:	ff 75 0c             	pushl  0xc(%ebp)
  801a7d:	e8 b6 f9 ff ff       	call   801438 <strlen>
  801a82:	83 c4 04             	add    $0x4,%esp
  801a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a96:	eb 17                	jmp    801aaf <strcconcat+0x49>
		final[s] = str1[s] ;
  801a98:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a9b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a9e:	01 c2                	add    %eax,%edx
  801aa0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa6:	01 c8                	add    %ecx,%eax
  801aa8:	8a 00                	mov    (%eax),%al
  801aaa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801aac:	ff 45 fc             	incl   -0x4(%ebp)
  801aaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ab2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ab5:	7c e1                	jl     801a98 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801ab7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801abe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ac5:	eb 1f                	jmp    801ae6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ac7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aca:	8d 50 01             	lea    0x1(%eax),%edx
  801acd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ad0:	89 c2                	mov    %eax,%edx
  801ad2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad5:	01 c2                	add    %eax,%edx
  801ad7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ada:	8b 45 0c             	mov    0xc(%ebp),%eax
  801add:	01 c8                	add    %ecx,%eax
  801adf:	8a 00                	mov    (%eax),%al
  801ae1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ae3:	ff 45 f8             	incl   -0x8(%ebp)
  801ae6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801aec:	7c d9                	jl     801ac7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801aee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801af1:	8b 45 10             	mov    0x10(%ebp),%eax
  801af4:	01 d0                	add    %edx,%eax
  801af6:	c6 00 00             	movb   $0x0,(%eax)
}
  801af9:	90                   	nop
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801aff:	8b 45 14             	mov    0x14(%ebp),%eax
  801b02:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b08:	8b 45 14             	mov    0x14(%ebp),%eax
  801b0b:	8b 00                	mov    (%eax),%eax
  801b0d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b14:	8b 45 10             	mov    0x10(%ebp),%eax
  801b17:	01 d0                	add    %edx,%eax
  801b19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b1f:	eb 0c                	jmp    801b2d <strsplit+0x31>
			*string++ = 0;
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	8d 50 01             	lea    0x1(%eax),%edx
  801b27:	89 55 08             	mov    %edx,0x8(%ebp)
  801b2a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b30:	8a 00                	mov    (%eax),%al
  801b32:	84 c0                	test   %al,%al
  801b34:	74 18                	je     801b4e <strsplit+0x52>
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	8a 00                	mov    (%eax),%al
  801b3b:	0f be c0             	movsbl %al,%eax
  801b3e:	50                   	push   %eax
  801b3f:	ff 75 0c             	pushl  0xc(%ebp)
  801b42:	e8 83 fa ff ff       	call   8015ca <strchr>
  801b47:	83 c4 08             	add    $0x8,%esp
  801b4a:	85 c0                	test   %eax,%eax
  801b4c:	75 d3                	jne    801b21 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b51:	8a 00                	mov    (%eax),%al
  801b53:	84 c0                	test   %al,%al
  801b55:	74 5a                	je     801bb1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b57:	8b 45 14             	mov    0x14(%ebp),%eax
  801b5a:	8b 00                	mov    (%eax),%eax
  801b5c:	83 f8 0f             	cmp    $0xf,%eax
  801b5f:	75 07                	jne    801b68 <strsplit+0x6c>
		{
			return 0;
  801b61:	b8 00 00 00 00       	mov    $0x0,%eax
  801b66:	eb 66                	jmp    801bce <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b68:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6b:	8b 00                	mov    (%eax),%eax
  801b6d:	8d 48 01             	lea    0x1(%eax),%ecx
  801b70:	8b 55 14             	mov    0x14(%ebp),%edx
  801b73:	89 0a                	mov    %ecx,(%edx)
  801b75:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b7c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7f:	01 c2                	add    %eax,%edx
  801b81:	8b 45 08             	mov    0x8(%ebp),%eax
  801b84:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b86:	eb 03                	jmp    801b8b <strsplit+0x8f>
			string++;
  801b88:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8e:	8a 00                	mov    (%eax),%al
  801b90:	84 c0                	test   %al,%al
  801b92:	74 8b                	je     801b1f <strsplit+0x23>
  801b94:	8b 45 08             	mov    0x8(%ebp),%eax
  801b97:	8a 00                	mov    (%eax),%al
  801b99:	0f be c0             	movsbl %al,%eax
  801b9c:	50                   	push   %eax
  801b9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ba0:	e8 25 fa ff ff       	call   8015ca <strchr>
  801ba5:	83 c4 08             	add    $0x8,%esp
  801ba8:	85 c0                	test   %eax,%eax
  801baa:	74 dc                	je     801b88 <strsplit+0x8c>
			string++;
	}
  801bac:	e9 6e ff ff ff       	jmp    801b1f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801bb1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801bb2:	8b 45 14             	mov    0x14(%ebp),%eax
  801bb5:	8b 00                	mov    (%eax),%eax
  801bb7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  801bc1:	01 d0                	add    %edx,%eax
  801bc3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801bc9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801bdc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801be3:	eb 4a                	jmp    801c2f <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801be5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be8:	8b 45 08             	mov    0x8(%ebp),%eax
  801beb:	01 c2                	add    %eax,%edx
  801bed:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bf3:	01 c8                	add    %ecx,%eax
  801bf5:	8a 00                	mov    (%eax),%al
  801bf7:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801bf9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bff:	01 d0                	add    %edx,%eax
  801c01:	8a 00                	mov    (%eax),%al
  801c03:	3c 40                	cmp    $0x40,%al
  801c05:	7e 25                	jle    801c2c <str2lower+0x5c>
  801c07:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c0d:	01 d0                	add    %edx,%eax
  801c0f:	8a 00                	mov    (%eax),%al
  801c11:	3c 5a                	cmp    $0x5a,%al
  801c13:	7f 17                	jg     801c2c <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801c15:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c18:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1b:	01 d0                	add    %edx,%eax
  801c1d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c20:	8b 55 08             	mov    0x8(%ebp),%edx
  801c23:	01 ca                	add    %ecx,%edx
  801c25:	8a 12                	mov    (%edx),%dl
  801c27:	83 c2 20             	add    $0x20,%edx
  801c2a:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801c2c:	ff 45 fc             	incl   -0x4(%ebp)
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	e8 01 f8 ff ff       	call   801438 <strlen>
  801c37:	83 c4 04             	add    $0x4,%esp
  801c3a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801c3d:	7f a6                	jg     801be5 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801c3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
  801c47:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801c4a:	a1 08 40 80 00       	mov    0x804008,%eax
  801c4f:	85 c0                	test   %eax,%eax
  801c51:	74 2d                	je     801c80 <uheap_init+0x3c>
	{
		buddy_init();
  801c53:	e8 87 06 00 00       	call   8022df <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801c58:	e8 31 05 00 00       	call   80218e <sys_get_uheap_strategy>
  801c5d:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801c62:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801c69:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801c6c:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801c73:	00 00 80 
		__firstTimeFlag = 0;
  801c76:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801c7d:	00 00 00 
	}
}
  801c80:	90                   	nop
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
  801c86:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801c89:	83 ec 04             	sub    $0x4,%esp
  801c8c:	68 08 2f 80 00       	push   $0x802f08
  801c91:	6a 25                	push   $0x25
  801c93:	68 39 2f 80 00       	push   $0x802f39
  801c98:	e8 34 07 00 00       	call   8023d1 <_panic>

00801c9d <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
  801ca0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801ca3:	83 ec 04             	sub    $0x4,%esp
  801ca6:	68 48 2f 80 00       	push   $0x802f48
  801cab:	6a 2f                	push   $0x2f
  801cad:	68 39 2f 80 00       	push   $0x802f39
  801cb2:	e8 1a 07 00 00       	call   8023d1 <_panic>

00801cb7 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
  801cba:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801cbd:	e8 82 ff ff ff       	call   801c44 <uheap_init>
	if (size == 0) return NULL ;
  801cc2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cc6:	75 07                	jne    801ccf <malloc+0x18>
  801cc8:	b8 00 00 00 00       	mov    $0x0,%eax
  801ccd:	eb 14                	jmp    801ce3 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801ccf:	83 ec 04             	sub    $0x4,%esp
  801cd2:	68 7c 2f 80 00       	push   $0x802f7c
  801cd7:	6a 43                	push   $0x43
  801cd9:	68 39 2f 80 00       	push   $0x802f39
  801cde:	e8 ee 06 00 00       	call   8023d1 <_panic>
}
  801ce3:	c9                   	leave  
  801ce4:	c3                   	ret    

00801ce5 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
  801ce8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801ceb:	83 ec 04             	sub    $0x4,%esp
  801cee:	68 a4 2f 80 00       	push   $0x802fa4
  801cf3:	6a 4e                	push   $0x4e
  801cf5:	68 39 2f 80 00       	push   $0x802f39
  801cfa:	e8 d2 06 00 00       	call   8023d1 <_panic>

00801cff <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
  801d02:	83 ec 18             	sub    $0x18,%esp
  801d05:	8b 45 10             	mov    0x10(%ebp),%eax
  801d08:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801d0b:	e8 34 ff ff ff       	call   801c44 <uheap_init>
	if (size == 0) return NULL ;
  801d10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d14:	75 07                	jne    801d1d <smalloc+0x1e>
  801d16:	b8 00 00 00 00       	mov    $0x0,%eax
  801d1b:	eb 14                	jmp    801d31 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801d1d:	83 ec 04             	sub    $0x4,%esp
  801d20:	68 c8 2f 80 00       	push   $0x802fc8
  801d25:	6a 5f                	push   $0x5f
  801d27:	68 39 2f 80 00       	push   $0x802f39
  801d2c:	e8 a0 06 00 00       	call   8023d1 <_panic>
}
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
  801d36:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801d39:	e8 06 ff ff ff       	call   801c44 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801d3e:	83 ec 04             	sub    $0x4,%esp
  801d41:	68 f0 2f 80 00       	push   $0x802ff0
  801d46:	6a 6f                	push   $0x6f
  801d48:	68 39 2f 80 00       	push   $0x802f39
  801d4d:	e8 7f 06 00 00       	call   8023d1 <_panic>

00801d52 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
  801d55:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801d58:	83 ec 04             	sub    $0x4,%esp
  801d5b:	68 14 30 80 00       	push   $0x803014
  801d60:	6a 7e                	push   $0x7e
  801d62:	68 39 2f 80 00       	push   $0x802f39
  801d67:	e8 65 06 00 00       	call   8023d1 <_panic>

00801d6c <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
  801d6f:	57                   	push   %edi
  801d70:	56                   	push   %esi
  801d71:	53                   	push   %ebx
  801d72:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d75:	8b 45 08             	mov    0x8(%ebp),%eax
  801d78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d81:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d84:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d87:	cd 30                	int    $0x30
  801d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d8f:	83 c4 10             	add    $0x10,%esp
  801d92:	5b                   	pop    %ebx
  801d93:	5e                   	pop    %esi
  801d94:	5f                   	pop    %edi
  801d95:	5d                   	pop    %ebp
  801d96:	c3                   	ret    

00801d97 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
  801d9a:	83 ec 04             	sub    $0x4,%esp
  801d9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801da0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801da3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801da6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	6a 00                	push   $0x0
  801daf:	51                   	push   %ecx
  801db0:	52                   	push   %edx
  801db1:	ff 75 0c             	pushl  0xc(%ebp)
  801db4:	50                   	push   %eax
  801db5:	6a 00                	push   $0x0
  801db7:	e8 b0 ff ff ff       	call   801d6c <syscall>
  801dbc:	83 c4 18             	add    $0x18,%esp
}
  801dbf:	90                   	nop
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 02                	push   $0x2
  801dd1:	e8 96 ff ff ff       	call   801d6c <syscall>
  801dd6:	83 c4 18             	add    $0x18,%esp
}
  801dd9:	c9                   	leave  
  801dda:	c3                   	ret    

00801ddb <sys_lock_cons>:

void sys_lock_cons(void)
{
  801ddb:	55                   	push   %ebp
  801ddc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 03                	push   $0x3
  801dea:	e8 7d ff ff ff       	call   801d6c <syscall>
  801def:	83 c4 18             	add    $0x18,%esp
}
  801df2:	90                   	nop
  801df3:	c9                   	leave  
  801df4:	c3                   	ret    

00801df5 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801df5:	55                   	push   %ebp
  801df6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 04                	push   $0x4
  801e04:	e8 63 ff ff ff       	call   801d6c <syscall>
  801e09:	83 c4 18             	add    $0x18,%esp
}
  801e0c:	90                   	nop
  801e0d:	c9                   	leave  
  801e0e:	c3                   	ret    

00801e0f <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	52                   	push   %edx
  801e1f:	50                   	push   %eax
  801e20:	6a 08                	push   $0x8
  801e22:	e8 45 ff ff ff       	call   801d6c <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	c9                   	leave  
  801e2b:	c3                   	ret    

00801e2c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	56                   	push   %esi
  801e30:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e31:	8b 75 18             	mov    0x18(%ebp),%esi
  801e34:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e40:	56                   	push   %esi
  801e41:	53                   	push   %ebx
  801e42:	51                   	push   %ecx
  801e43:	52                   	push   %edx
  801e44:	50                   	push   %eax
  801e45:	6a 09                	push   $0x9
  801e47:	e8 20 ff ff ff       	call   801d6c <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
}
  801e4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e52:	5b                   	pop    %ebx
  801e53:	5e                   	pop    %esi
  801e54:	5d                   	pop    %ebp
  801e55:	c3                   	ret    

00801e56 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801e56:	55                   	push   %ebp
  801e57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	ff 75 08             	pushl  0x8(%ebp)
  801e64:	6a 0a                	push   $0xa
  801e66:	e8 01 ff ff ff       	call   801d6c <syscall>
  801e6b:	83 c4 18             	add    $0x18,%esp
}
  801e6e:	c9                   	leave  
  801e6f:	c3                   	ret    

00801e70 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	ff 75 0c             	pushl  0xc(%ebp)
  801e7c:	ff 75 08             	pushl  0x8(%ebp)
  801e7f:	6a 0b                	push   $0xb
  801e81:	e8 e6 fe ff ff       	call   801d6c <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 0c                	push   $0xc
  801e9a:	e8 cd fe ff ff       	call   801d6c <syscall>
  801e9f:	83 c4 18             	add    $0x18,%esp
}
  801ea2:	c9                   	leave  
  801ea3:	c3                   	ret    

00801ea4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ea4:	55                   	push   %ebp
  801ea5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 0d                	push   $0xd
  801eb3:	e8 b4 fe ff ff       	call   801d6c <syscall>
  801eb8:	83 c4 18             	add    $0x18,%esp
}
  801ebb:	c9                   	leave  
  801ebc:	c3                   	ret    

00801ebd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ebd:	55                   	push   %ebp
  801ebe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 0e                	push   $0xe
  801ecc:	e8 9b fe ff ff       	call   801d6c <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 0f                	push   $0xf
  801ee5:	e8 82 fe ff ff       	call   801d6c <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	ff 75 08             	pushl  0x8(%ebp)
  801efd:	6a 10                	push   $0x10
  801eff:	e8 68 fe ff ff       	call   801d6c <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 11                	push   $0x11
  801f18:	e8 4f fe ff ff       	call   801d6c <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	90                   	nop
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <sys_cputc>:

void
sys_cputc(const char c)
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
  801f26:	83 ec 04             	sub    $0x4,%esp
  801f29:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f2f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	50                   	push   %eax
  801f3c:	6a 01                	push   $0x1
  801f3e:	e8 29 fe ff ff       	call   801d6c <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	90                   	nop
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 14                	push   $0x14
  801f58:	e8 0f fe ff ff       	call   801d6c <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
}
  801f60:	90                   	nop
  801f61:	c9                   	leave  
  801f62:	c3                   	ret    

00801f63 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801f63:	55                   	push   %ebp
  801f64:	89 e5                	mov    %esp,%ebp
  801f66:	83 ec 04             	sub    $0x4,%esp
  801f69:	8b 45 10             	mov    0x10(%ebp),%eax
  801f6c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801f6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f72:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f76:	8b 45 08             	mov    0x8(%ebp),%eax
  801f79:	6a 00                	push   $0x0
  801f7b:	51                   	push   %ecx
  801f7c:	52                   	push   %edx
  801f7d:	ff 75 0c             	pushl  0xc(%ebp)
  801f80:	50                   	push   %eax
  801f81:	6a 15                	push   $0x15
  801f83:	e8 e4 fd ff ff       	call   801d6c <syscall>
  801f88:	83 c4 18             	add    $0x18,%esp
}
  801f8b:	c9                   	leave  
  801f8c:	c3                   	ret    

00801f8d <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801f8d:	55                   	push   %ebp
  801f8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801f90:	8b 55 10             	mov    0x10(%ebp),%edx
  801f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	52                   	push   %edx
  801f9b:	50                   	push   %eax
  801f9c:	ff 75 08             	pushl  0x8(%ebp)
  801f9f:	6a 16                	push   $0x16
  801fa1:	e8 c6 fd ff ff       	call   801d6c <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801fae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	52                   	push   %edx
  801fbb:	50                   	push   %eax
  801fbc:	6a 17                	push   $0x17
  801fbe:	e8 a9 fd ff ff       	call   801d6c <syscall>
  801fc3:	83 c4 18             	add    $0x18,%esp
}
  801fc6:	c9                   	leave  
  801fc7:	c3                   	ret    

00801fc8 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801fcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fce:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	52                   	push   %edx
  801fd8:	50                   	push   %eax
  801fd9:	6a 18                	push   $0x18
  801fdb:	e8 8c fd ff ff       	call   801d6c <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	c9                   	leave  
  801fe4:	c3                   	ret    

00801fe5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  801feb:	6a 00                	push   $0x0
  801fed:	ff 75 14             	pushl  0x14(%ebp)
  801ff0:	ff 75 10             	pushl  0x10(%ebp)
  801ff3:	ff 75 0c             	pushl  0xc(%ebp)
  801ff6:	50                   	push   %eax
  801ff7:	6a 19                	push   $0x19
  801ff9:	e8 6e fd ff ff       	call   801d6c <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <sys_run_env>:

void sys_run_env(int32 envId)
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802006:	8b 45 08             	mov    0x8(%ebp),%eax
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	50                   	push   %eax
  802012:	6a 1a                	push   $0x1a
  802014:	e8 53 fd ff ff       	call   801d6c <syscall>
  802019:	83 c4 18             	add    $0x18,%esp
}
  80201c:	90                   	nop
  80201d:	c9                   	leave  
  80201e:	c3                   	ret    

0080201f <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80201f:	55                   	push   %ebp
  802020:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  802022:	8b 45 08             	mov    0x8(%ebp),%eax
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	50                   	push   %eax
  80202e:	6a 1b                	push   $0x1b
  802030:	e8 37 fd ff ff       	call   801d6c <syscall>
  802035:	83 c4 18             	add    $0x18,%esp
}
  802038:	c9                   	leave  
  802039:	c3                   	ret    

0080203a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80203a:	55                   	push   %ebp
  80203b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 05                	push   $0x5
  802049:	e8 1e fd ff ff       	call   801d6c <syscall>
  80204e:	83 c4 18             	add    $0x18,%esp
}
  802051:	c9                   	leave  
  802052:	c3                   	ret    

00802053 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802053:	55                   	push   %ebp
  802054:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 06                	push   $0x6
  802062:	e8 05 fd ff ff       	call   801d6c <syscall>
  802067:	83 c4 18             	add    $0x18,%esp
}
  80206a:	c9                   	leave  
  80206b:	c3                   	ret    

0080206c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80206c:	55                   	push   %ebp
  80206d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 07                	push   $0x7
  80207b:	e8 ec fc ff ff       	call   801d6c <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <sys_exit_env>:


void sys_exit_env(void)
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 1c                	push   $0x1c
  802094:	e8 d3 fc ff ff       	call   801d6c <syscall>
  802099:	83 c4 18             	add    $0x18,%esp
}
  80209c:	90                   	nop
  80209d:	c9                   	leave  
  80209e:	c3                   	ret    

0080209f <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80209f:	55                   	push   %ebp
  8020a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	ff 75 10             	pushl  0x10(%ebp)
  8020a9:	ff 75 0c             	pushl  0xc(%ebp)
  8020ac:	ff 75 08             	pushl  0x8(%ebp)
  8020af:	6a 13                	push   $0x13
  8020b1:	e8 b6 fc ff ff       	call   801d6c <syscall>
  8020b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b9:	90                   	nop
}
  8020ba:	c9                   	leave  
  8020bb:	c3                   	ret    

008020bc <sys_rcr2>:
uint32 sys_rcr2()
{
  8020bc:	55                   	push   %ebp
  8020bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 1e                	push   $0x1e
  8020cb:	e8 9c fc ff ff       	call   801d6c <syscall>
  8020d0:	83 c4 18             	add    $0x18,%esp
}
  8020d3:	c9                   	leave  
  8020d4:	c3                   	ret    

008020d5 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8020d5:	55                   	push   %ebp
  8020d6:	89 e5                	mov    %esp,%ebp
  8020d8:	83 ec 04             	sub    $0x4,%esp
  8020db:	8b 45 08             	mov    0x8(%ebp),%eax
  8020de:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020e1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	50                   	push   %eax
  8020ee:	6a 1f                	push   $0x1f
  8020f0:	e8 77 fc ff ff       	call   801d6c <syscall>
  8020f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f8:	90                   	nop
}
  8020f9:	c9                   	leave  
  8020fa:	c3                   	ret    

008020fb <rsttst>:
void rsttst()
{
  8020fb:	55                   	push   %ebp
  8020fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 21                	push   $0x21
  80210a:	e8 5d fc ff ff       	call   801d6c <syscall>
  80210f:	83 c4 18             	add    $0x18,%esp
	return ;
  802112:	90                   	nop
}
  802113:	c9                   	leave  
  802114:	c3                   	ret    

00802115 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802115:	55                   	push   %ebp
  802116:	89 e5                	mov    %esp,%ebp
  802118:	83 ec 04             	sub    $0x4,%esp
  80211b:	8b 45 14             	mov    0x14(%ebp),%eax
  80211e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802121:	8b 55 18             	mov    0x18(%ebp),%edx
  802124:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802128:	52                   	push   %edx
  802129:	50                   	push   %eax
  80212a:	ff 75 10             	pushl  0x10(%ebp)
  80212d:	ff 75 0c             	pushl  0xc(%ebp)
  802130:	ff 75 08             	pushl  0x8(%ebp)
  802133:	6a 20                	push   $0x20
  802135:	e8 32 fc ff ff       	call   801d6c <syscall>
  80213a:	83 c4 18             	add    $0x18,%esp
	return ;
  80213d:	90                   	nop
}
  80213e:	c9                   	leave  
  80213f:	c3                   	ret    

00802140 <chktst>:
void chktst(uint32 n)
{
  802140:	55                   	push   %ebp
  802141:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	ff 75 08             	pushl  0x8(%ebp)
  80214e:	6a 22                	push   $0x22
  802150:	e8 17 fc ff ff       	call   801d6c <syscall>
  802155:	83 c4 18             	add    $0x18,%esp
	return ;
  802158:	90                   	nop
}
  802159:	c9                   	leave  
  80215a:	c3                   	ret    

0080215b <inctst>:

void inctst()
{
  80215b:	55                   	push   %ebp
  80215c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 23                	push   $0x23
  80216a:	e8 fd fb ff ff       	call   801d6c <syscall>
  80216f:	83 c4 18             	add    $0x18,%esp
	return ;
  802172:	90                   	nop
}
  802173:	c9                   	leave  
  802174:	c3                   	ret    

00802175 <gettst>:
uint32 gettst()
{
  802175:	55                   	push   %ebp
  802176:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 24                	push   $0x24
  802184:	e8 e3 fb ff ff       	call   801d6c <syscall>
  802189:	83 c4 18             	add    $0x18,%esp
}
  80218c:	c9                   	leave  
  80218d:	c3                   	ret    

0080218e <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80218e:	55                   	push   %ebp
  80218f:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 25                	push   $0x25
  80219d:	e8 ca fb ff ff       	call   801d6c <syscall>
  8021a2:	83 c4 18             	add    $0x18,%esp
  8021a5:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8021aa:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8021b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b7:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	ff 75 08             	pushl  0x8(%ebp)
  8021c7:	6a 26                	push   $0x26
  8021c9:	e8 9e fb ff ff       	call   801d6c <syscall>
  8021ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8021d1:	90                   	nop
}
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
  8021d7:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021d8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e4:	6a 00                	push   $0x0
  8021e6:	53                   	push   %ebx
  8021e7:	51                   	push   %ecx
  8021e8:	52                   	push   %edx
  8021e9:	50                   	push   %eax
  8021ea:	6a 27                	push   $0x27
  8021ec:	e8 7b fb ff ff       	call   801d6c <syscall>
  8021f1:	83 c4 18             	add    $0x18,%esp
}
  8021f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	52                   	push   %edx
  802209:	50                   	push   %eax
  80220a:	6a 28                	push   $0x28
  80220c:	e8 5b fb ff ff       	call   801d6c <syscall>
  802211:	83 c4 18             	add    $0x18,%esp
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802219:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80221c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80221f:	8b 45 08             	mov    0x8(%ebp),%eax
  802222:	6a 00                	push   $0x0
  802224:	51                   	push   %ecx
  802225:	ff 75 10             	pushl  0x10(%ebp)
  802228:	52                   	push   %edx
  802229:	50                   	push   %eax
  80222a:	6a 29                	push   $0x29
  80222c:	e8 3b fb ff ff       	call   801d6c <syscall>
  802231:	83 c4 18             	add    $0x18,%esp
}
  802234:	c9                   	leave  
  802235:	c3                   	ret    

00802236 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802236:	55                   	push   %ebp
  802237:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802239:	6a 00                	push   $0x0
  80223b:	6a 00                	push   $0x0
  80223d:	ff 75 10             	pushl  0x10(%ebp)
  802240:	ff 75 0c             	pushl  0xc(%ebp)
  802243:	ff 75 08             	pushl  0x8(%ebp)
  802246:	6a 12                	push   $0x12
  802248:	e8 1f fb ff ff       	call   801d6c <syscall>
  80224d:	83 c4 18             	add    $0x18,%esp
	return ;
  802250:	90                   	nop
}
  802251:	c9                   	leave  
  802252:	c3                   	ret    

00802253 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  802253:	55                   	push   %ebp
  802254:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802256:	8b 55 0c             	mov    0xc(%ebp),%edx
  802259:	8b 45 08             	mov    0x8(%ebp),%eax
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	52                   	push   %edx
  802263:	50                   	push   %eax
  802264:	6a 2a                	push   $0x2a
  802266:	e8 01 fb ff ff       	call   801d6c <syscall>
  80226b:	83 c4 18             	add    $0x18,%esp
	return;
  80226e:	90                   	nop
}
  80226f:	c9                   	leave  
  802270:	c3                   	ret    

00802271 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802271:	55                   	push   %ebp
  802272:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 2b                	push   $0x2b
  802280:	e8 e7 fa ff ff       	call   801d6c <syscall>
  802285:	83 c4 18             	add    $0x18,%esp
}
  802288:	c9                   	leave  
  802289:	c3                   	ret    

0080228a <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80228a:	55                   	push   %ebp
  80228b:	89 e5                	mov    %esp,%ebp
  80228d:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802290:	83 ec 04             	sub    $0x4,%esp
  802293:	68 38 30 80 00       	push   $0x803038
  802298:	68 0a 01 00 00       	push   $0x10a
  80229d:	68 48 30 80 00       	push   $0x803048
  8022a2:	e8 2a 01 00 00       	call   8023d1 <_panic>

008022a7 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8022a7:	55                   	push   %ebp
  8022a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	ff 75 0c             	pushl  0xc(%ebp)
  8022b3:	ff 75 08             	pushl  0x8(%ebp)
  8022b6:	6a 33                	push   $0x33
  8022b8:	e8 af fa ff ff       	call   801d6c <syscall>
  8022bd:	83 c4 18             	add    $0x18,%esp
	return;
  8022c0:	90                   	nop
}
  8022c1:	c9                   	leave  
  8022c2:	c3                   	ret    

008022c3 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8022c3:	55                   	push   %ebp
  8022c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	ff 75 0c             	pushl  0xc(%ebp)
  8022cf:	ff 75 08             	pushl  0x8(%ebp)
  8022d2:	6a 34                	push   $0x34
  8022d4:	e8 93 fa ff ff       	call   801d6c <syscall>
  8022d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022dc:	90                   	nop
}
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
  8022e2:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8022e5:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8022ec:	eb 36                	jmp    802324 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8022ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022f1:	c1 e0 04             	shl    $0x4,%eax
  8022f4:	05 60 40 80 00       	add    $0x804060,%eax
  8022f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8022ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802302:	c1 e0 04             	shl    $0x4,%eax
  802305:	05 64 40 80 00       	add    $0x804064,%eax
  80230a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802310:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802313:	c1 e0 04             	shl    $0x4,%eax
  802316:	05 6c 40 80 00       	add    $0x80406c,%eax
  80231b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802321:	ff 45 fc             	incl   -0x4(%ebp)
  802324:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802328:	7e c4                	jle    8022ee <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  80232a:	90                   	nop
  80232b:	c9                   	leave  
  80232c:	c3                   	ret    

0080232d <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  80232d:	55                   	push   %ebp
  80232e:	89 e5                	mov    %esp,%ebp
  802330:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802333:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  80233a:	eb 24                	jmp    802360 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  80233c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80233f:	c1 e0 04             	shl    $0x4,%eax
  802342:	05 6c 40 80 00       	add    $0x80406c,%eax
  802347:	8b 00                	mov    (%eax),%eax
  802349:	83 ec 04             	sub    $0x4,%esp
  80234c:	50                   	push   %eax
  80234d:	ff 75 f4             	pushl  -0xc(%ebp)
  802350:	68 58 30 80 00       	push   $0x803058
  802355:	e8 05 ea ff ff       	call   800d5f <cprintf>
  80235a:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80235d:	ff 45 f4             	incl   -0xc(%ebp)
  802360:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  802364:	7e d6                	jle    80233c <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802366:	90                   	nop
  802367:	c9                   	leave  
  802368:	c3                   	ret    

00802369 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802369:	55                   	push   %ebp
  80236a:	89 e5                	mov    %esp,%ebp
  80236c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  80236f:	83 ec 04             	sub    $0x4,%esp
  802372:	68 68 30 80 00       	push   $0x803068
  802377:	6a 33                	push   $0x33
  802379:	68 89 30 80 00       	push   $0x803089
  80237e:	e8 4e 00 00 00       	call   8023d1 <_panic>

00802383 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  802383:	55                   	push   %ebp
  802384:	89 e5                	mov    %esp,%ebp
  802386:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802389:	83 ec 04             	sub    $0x4,%esp
  80238c:	68 a1 30 80 00       	push   $0x8030a1
  802391:	6a 3e                	push   $0x3e
  802393:	68 89 30 80 00       	push   $0x803089
  802398:	e8 34 00 00 00       	call   8023d1 <_panic>

0080239d <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  80239d:	55                   	push   %ebp
  80239e:	89 e5                	mov    %esp,%ebp
  8023a0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8023a3:	83 ec 04             	sub    $0x4,%esp
  8023a6:	68 bf 30 80 00       	push   $0x8030bf
  8023ab:	6a 49                	push   $0x49
  8023ad:	68 89 30 80 00       	push   $0x803089
  8023b2:	e8 1a 00 00 00       	call   8023d1 <_panic>

008023b7 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8023b7:	55                   	push   %ebp
  8023b8:	89 e5                	mov    %esp,%ebp
  8023ba:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8023bd:	83 ec 04             	sub    $0x4,%esp
  8023c0:	68 dc 30 80 00       	push   $0x8030dc
  8023c5:	6a 58                	push   $0x58
  8023c7:	68 89 30 80 00       	push   $0x803089
  8023cc:	e8 00 00 00 00       	call   8023d1 <_panic>

008023d1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8023d1:	55                   	push   %ebp
  8023d2:	89 e5                	mov    %esp,%ebp
  8023d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8023d7:	8d 45 10             	lea    0x10(%ebp),%eax
  8023da:	83 c0 04             	add    $0x4,%eax
  8023dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8023e0:	a1 2c 41 80 00       	mov    0x80412c,%eax
  8023e5:	85 c0                	test   %eax,%eax
  8023e7:	74 16                	je     8023ff <_panic+0x2e>
		cprintf("%s: ", argv0);
  8023e9:	a1 2c 41 80 00       	mov    0x80412c,%eax
  8023ee:	83 ec 08             	sub    $0x8,%esp
  8023f1:	50                   	push   %eax
  8023f2:	68 00 31 80 00       	push   $0x803100
  8023f7:	e8 63 e9 ff ff       	call   800d5f <cprintf>
  8023fc:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8023ff:	a1 04 40 80 00       	mov    0x804004,%eax
  802404:	83 ec 0c             	sub    $0xc,%esp
  802407:	ff 75 0c             	pushl  0xc(%ebp)
  80240a:	ff 75 08             	pushl  0x8(%ebp)
  80240d:	50                   	push   %eax
  80240e:	68 08 31 80 00       	push   $0x803108
  802413:	6a 74                	push   $0x74
  802415:	e8 72 e9 ff ff       	call   800d8c <cprintf_colored>
  80241a:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80241d:	8b 45 10             	mov    0x10(%ebp),%eax
  802420:	83 ec 08             	sub    $0x8,%esp
  802423:	ff 75 f4             	pushl  -0xc(%ebp)
  802426:	50                   	push   %eax
  802427:	e8 c4 e8 ff ff       	call   800cf0 <vcprintf>
  80242c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80242f:	83 ec 08             	sub    $0x8,%esp
  802432:	6a 00                	push   $0x0
  802434:	68 30 31 80 00       	push   $0x803130
  802439:	e8 b2 e8 ff ff       	call   800cf0 <vcprintf>
  80243e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  802441:	e8 2b e8 ff ff       	call   800c71 <exit>

	// should not return here
	while (1) ;
  802446:	eb fe                	jmp    802446 <_panic+0x75>

00802448 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  802448:	55                   	push   %ebp
  802449:	89 e5                	mov    %esp,%ebp
  80244b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80244e:	a1 20 40 80 00       	mov    0x804020,%eax
  802453:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80245c:	39 c2                	cmp    %eax,%edx
  80245e:	74 14                	je     802474 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  802460:	83 ec 04             	sub    $0x4,%esp
  802463:	68 34 31 80 00       	push   $0x803134
  802468:	6a 26                	push   $0x26
  80246a:	68 80 31 80 00       	push   $0x803180
  80246f:	e8 5d ff ff ff       	call   8023d1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80247b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802482:	e9 c5 00 00 00       	jmp    80254c <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  802487:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80248a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802491:	8b 45 08             	mov    0x8(%ebp),%eax
  802494:	01 d0                	add    %edx,%eax
  802496:	8b 00                	mov    (%eax),%eax
  802498:	85 c0                	test   %eax,%eax
  80249a:	75 08                	jne    8024a4 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80249c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80249f:	e9 a5 00 00 00       	jmp    802549 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8024a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8024ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8024b2:	eb 69                	jmp    80251d <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8024b4:	a1 20 40 80 00       	mov    0x804020,%eax
  8024b9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8024bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8024c2:	89 d0                	mov    %edx,%eax
  8024c4:	01 c0                	add    %eax,%eax
  8024c6:	01 d0                	add    %edx,%eax
  8024c8:	c1 e0 03             	shl    $0x3,%eax
  8024cb:	01 c8                	add    %ecx,%eax
  8024cd:	8a 40 04             	mov    0x4(%eax),%al
  8024d0:	84 c0                	test   %al,%al
  8024d2:	75 46                	jne    80251a <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8024d4:	a1 20 40 80 00       	mov    0x804020,%eax
  8024d9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8024df:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8024e2:	89 d0                	mov    %edx,%eax
  8024e4:	01 c0                	add    %eax,%eax
  8024e6:	01 d0                	add    %edx,%eax
  8024e8:	c1 e0 03             	shl    $0x3,%eax
  8024eb:	01 c8                	add    %ecx,%eax
  8024ed:	8b 00                	mov    (%eax),%eax
  8024ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8024f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8024f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8024fa:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8024fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  802506:	8b 45 08             	mov    0x8(%ebp),%eax
  802509:	01 c8                	add    %ecx,%eax
  80250b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80250d:	39 c2                	cmp    %eax,%edx
  80250f:	75 09                	jne    80251a <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  802511:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  802518:	eb 15                	jmp    80252f <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80251a:	ff 45 e8             	incl   -0x18(%ebp)
  80251d:	a1 20 40 80 00       	mov    0x804020,%eax
  802522:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802528:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80252b:	39 c2                	cmp    %eax,%edx
  80252d:	77 85                	ja     8024b4 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80252f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  802533:	75 14                	jne    802549 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  802535:	83 ec 04             	sub    $0x4,%esp
  802538:	68 8c 31 80 00       	push   $0x80318c
  80253d:	6a 3a                	push   $0x3a
  80253f:	68 80 31 80 00       	push   $0x803180
  802544:	e8 88 fe ff ff       	call   8023d1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802549:	ff 45 f0             	incl   -0x10(%ebp)
  80254c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80254f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  802552:	0f 8c 2f ff ff ff    	jl     802487 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802558:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80255f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802566:	eb 26                	jmp    80258e <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802568:	a1 20 40 80 00       	mov    0x804020,%eax
  80256d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802573:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802576:	89 d0                	mov    %edx,%eax
  802578:	01 c0                	add    %eax,%eax
  80257a:	01 d0                	add    %edx,%eax
  80257c:	c1 e0 03             	shl    $0x3,%eax
  80257f:	01 c8                	add    %ecx,%eax
  802581:	8a 40 04             	mov    0x4(%eax),%al
  802584:	3c 01                	cmp    $0x1,%al
  802586:	75 03                	jne    80258b <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  802588:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80258b:	ff 45 e0             	incl   -0x20(%ebp)
  80258e:	a1 20 40 80 00       	mov    0x804020,%eax
  802593:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802599:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80259c:	39 c2                	cmp    %eax,%edx
  80259e:	77 c8                	ja     802568 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8025a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025a3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8025a6:	74 14                	je     8025bc <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8025a8:	83 ec 04             	sub    $0x4,%esp
  8025ab:	68 e0 31 80 00       	push   $0x8031e0
  8025b0:	6a 44                	push   $0x44
  8025b2:	68 80 31 80 00       	push   $0x803180
  8025b7:	e8 15 fe ff ff       	call   8023d1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8025bc:	90                   	nop
  8025bd:	c9                   	leave  
  8025be:	c3                   	ret    
  8025bf:	90                   	nop

008025c0 <__udivdi3>:
  8025c0:	55                   	push   %ebp
  8025c1:	57                   	push   %edi
  8025c2:	56                   	push   %esi
  8025c3:	53                   	push   %ebx
  8025c4:	83 ec 1c             	sub    $0x1c,%esp
  8025c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025d7:	89 ca                	mov    %ecx,%edx
  8025d9:	89 f8                	mov    %edi,%eax
  8025db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025df:	85 f6                	test   %esi,%esi
  8025e1:	75 2d                	jne    802610 <__udivdi3+0x50>
  8025e3:	39 cf                	cmp    %ecx,%edi
  8025e5:	77 65                	ja     80264c <__udivdi3+0x8c>
  8025e7:	89 fd                	mov    %edi,%ebp
  8025e9:	85 ff                	test   %edi,%edi
  8025eb:	75 0b                	jne    8025f8 <__udivdi3+0x38>
  8025ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8025f2:	31 d2                	xor    %edx,%edx
  8025f4:	f7 f7                	div    %edi
  8025f6:	89 c5                	mov    %eax,%ebp
  8025f8:	31 d2                	xor    %edx,%edx
  8025fa:	89 c8                	mov    %ecx,%eax
  8025fc:	f7 f5                	div    %ebp
  8025fe:	89 c1                	mov    %eax,%ecx
  802600:	89 d8                	mov    %ebx,%eax
  802602:	f7 f5                	div    %ebp
  802604:	89 cf                	mov    %ecx,%edi
  802606:	89 fa                	mov    %edi,%edx
  802608:	83 c4 1c             	add    $0x1c,%esp
  80260b:	5b                   	pop    %ebx
  80260c:	5e                   	pop    %esi
  80260d:	5f                   	pop    %edi
  80260e:	5d                   	pop    %ebp
  80260f:	c3                   	ret    
  802610:	39 ce                	cmp    %ecx,%esi
  802612:	77 28                	ja     80263c <__udivdi3+0x7c>
  802614:	0f bd fe             	bsr    %esi,%edi
  802617:	83 f7 1f             	xor    $0x1f,%edi
  80261a:	75 40                	jne    80265c <__udivdi3+0x9c>
  80261c:	39 ce                	cmp    %ecx,%esi
  80261e:	72 0a                	jb     80262a <__udivdi3+0x6a>
  802620:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802624:	0f 87 9e 00 00 00    	ja     8026c8 <__udivdi3+0x108>
  80262a:	b8 01 00 00 00       	mov    $0x1,%eax
  80262f:	89 fa                	mov    %edi,%edx
  802631:	83 c4 1c             	add    $0x1c,%esp
  802634:	5b                   	pop    %ebx
  802635:	5e                   	pop    %esi
  802636:	5f                   	pop    %edi
  802637:	5d                   	pop    %ebp
  802638:	c3                   	ret    
  802639:	8d 76 00             	lea    0x0(%esi),%esi
  80263c:	31 ff                	xor    %edi,%edi
  80263e:	31 c0                	xor    %eax,%eax
  802640:	89 fa                	mov    %edi,%edx
  802642:	83 c4 1c             	add    $0x1c,%esp
  802645:	5b                   	pop    %ebx
  802646:	5e                   	pop    %esi
  802647:	5f                   	pop    %edi
  802648:	5d                   	pop    %ebp
  802649:	c3                   	ret    
  80264a:	66 90                	xchg   %ax,%ax
  80264c:	89 d8                	mov    %ebx,%eax
  80264e:	f7 f7                	div    %edi
  802650:	31 ff                	xor    %edi,%edi
  802652:	89 fa                	mov    %edi,%edx
  802654:	83 c4 1c             	add    $0x1c,%esp
  802657:	5b                   	pop    %ebx
  802658:	5e                   	pop    %esi
  802659:	5f                   	pop    %edi
  80265a:	5d                   	pop    %ebp
  80265b:	c3                   	ret    
  80265c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802661:	89 eb                	mov    %ebp,%ebx
  802663:	29 fb                	sub    %edi,%ebx
  802665:	89 f9                	mov    %edi,%ecx
  802667:	d3 e6                	shl    %cl,%esi
  802669:	89 c5                	mov    %eax,%ebp
  80266b:	88 d9                	mov    %bl,%cl
  80266d:	d3 ed                	shr    %cl,%ebp
  80266f:	89 e9                	mov    %ebp,%ecx
  802671:	09 f1                	or     %esi,%ecx
  802673:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802677:	89 f9                	mov    %edi,%ecx
  802679:	d3 e0                	shl    %cl,%eax
  80267b:	89 c5                	mov    %eax,%ebp
  80267d:	89 d6                	mov    %edx,%esi
  80267f:	88 d9                	mov    %bl,%cl
  802681:	d3 ee                	shr    %cl,%esi
  802683:	89 f9                	mov    %edi,%ecx
  802685:	d3 e2                	shl    %cl,%edx
  802687:	8b 44 24 08          	mov    0x8(%esp),%eax
  80268b:	88 d9                	mov    %bl,%cl
  80268d:	d3 e8                	shr    %cl,%eax
  80268f:	09 c2                	or     %eax,%edx
  802691:	89 d0                	mov    %edx,%eax
  802693:	89 f2                	mov    %esi,%edx
  802695:	f7 74 24 0c          	divl   0xc(%esp)
  802699:	89 d6                	mov    %edx,%esi
  80269b:	89 c3                	mov    %eax,%ebx
  80269d:	f7 e5                	mul    %ebp
  80269f:	39 d6                	cmp    %edx,%esi
  8026a1:	72 19                	jb     8026bc <__udivdi3+0xfc>
  8026a3:	74 0b                	je     8026b0 <__udivdi3+0xf0>
  8026a5:	89 d8                	mov    %ebx,%eax
  8026a7:	31 ff                	xor    %edi,%edi
  8026a9:	e9 58 ff ff ff       	jmp    802606 <__udivdi3+0x46>
  8026ae:	66 90                	xchg   %ax,%ax
  8026b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026b4:	89 f9                	mov    %edi,%ecx
  8026b6:	d3 e2                	shl    %cl,%edx
  8026b8:	39 c2                	cmp    %eax,%edx
  8026ba:	73 e9                	jae    8026a5 <__udivdi3+0xe5>
  8026bc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026bf:	31 ff                	xor    %edi,%edi
  8026c1:	e9 40 ff ff ff       	jmp    802606 <__udivdi3+0x46>
  8026c6:	66 90                	xchg   %ax,%ax
  8026c8:	31 c0                	xor    %eax,%eax
  8026ca:	e9 37 ff ff ff       	jmp    802606 <__udivdi3+0x46>
  8026cf:	90                   	nop

008026d0 <__umoddi3>:
  8026d0:	55                   	push   %ebp
  8026d1:	57                   	push   %edi
  8026d2:	56                   	push   %esi
  8026d3:	53                   	push   %ebx
  8026d4:	83 ec 1c             	sub    $0x1c,%esp
  8026d7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026db:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026e3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026ef:	89 f3                	mov    %esi,%ebx
  8026f1:	89 fa                	mov    %edi,%edx
  8026f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026f7:	89 34 24             	mov    %esi,(%esp)
  8026fa:	85 c0                	test   %eax,%eax
  8026fc:	75 1a                	jne    802718 <__umoddi3+0x48>
  8026fe:	39 f7                	cmp    %esi,%edi
  802700:	0f 86 a2 00 00 00    	jbe    8027a8 <__umoddi3+0xd8>
  802706:	89 c8                	mov    %ecx,%eax
  802708:	89 f2                	mov    %esi,%edx
  80270a:	f7 f7                	div    %edi
  80270c:	89 d0                	mov    %edx,%eax
  80270e:	31 d2                	xor    %edx,%edx
  802710:	83 c4 1c             	add    $0x1c,%esp
  802713:	5b                   	pop    %ebx
  802714:	5e                   	pop    %esi
  802715:	5f                   	pop    %edi
  802716:	5d                   	pop    %ebp
  802717:	c3                   	ret    
  802718:	39 f0                	cmp    %esi,%eax
  80271a:	0f 87 ac 00 00 00    	ja     8027cc <__umoddi3+0xfc>
  802720:	0f bd e8             	bsr    %eax,%ebp
  802723:	83 f5 1f             	xor    $0x1f,%ebp
  802726:	0f 84 ac 00 00 00    	je     8027d8 <__umoddi3+0x108>
  80272c:	bf 20 00 00 00       	mov    $0x20,%edi
  802731:	29 ef                	sub    %ebp,%edi
  802733:	89 fe                	mov    %edi,%esi
  802735:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802739:	89 e9                	mov    %ebp,%ecx
  80273b:	d3 e0                	shl    %cl,%eax
  80273d:	89 d7                	mov    %edx,%edi
  80273f:	89 f1                	mov    %esi,%ecx
  802741:	d3 ef                	shr    %cl,%edi
  802743:	09 c7                	or     %eax,%edi
  802745:	89 e9                	mov    %ebp,%ecx
  802747:	d3 e2                	shl    %cl,%edx
  802749:	89 14 24             	mov    %edx,(%esp)
  80274c:	89 d8                	mov    %ebx,%eax
  80274e:	d3 e0                	shl    %cl,%eax
  802750:	89 c2                	mov    %eax,%edx
  802752:	8b 44 24 08          	mov    0x8(%esp),%eax
  802756:	d3 e0                	shl    %cl,%eax
  802758:	89 44 24 04          	mov    %eax,0x4(%esp)
  80275c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802760:	89 f1                	mov    %esi,%ecx
  802762:	d3 e8                	shr    %cl,%eax
  802764:	09 d0                	or     %edx,%eax
  802766:	d3 eb                	shr    %cl,%ebx
  802768:	89 da                	mov    %ebx,%edx
  80276a:	f7 f7                	div    %edi
  80276c:	89 d3                	mov    %edx,%ebx
  80276e:	f7 24 24             	mull   (%esp)
  802771:	89 c6                	mov    %eax,%esi
  802773:	89 d1                	mov    %edx,%ecx
  802775:	39 d3                	cmp    %edx,%ebx
  802777:	0f 82 87 00 00 00    	jb     802804 <__umoddi3+0x134>
  80277d:	0f 84 91 00 00 00    	je     802814 <__umoddi3+0x144>
  802783:	8b 54 24 04          	mov    0x4(%esp),%edx
  802787:	29 f2                	sub    %esi,%edx
  802789:	19 cb                	sbb    %ecx,%ebx
  80278b:	89 d8                	mov    %ebx,%eax
  80278d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802791:	d3 e0                	shl    %cl,%eax
  802793:	89 e9                	mov    %ebp,%ecx
  802795:	d3 ea                	shr    %cl,%edx
  802797:	09 d0                	or     %edx,%eax
  802799:	89 e9                	mov    %ebp,%ecx
  80279b:	d3 eb                	shr    %cl,%ebx
  80279d:	89 da                	mov    %ebx,%edx
  80279f:	83 c4 1c             	add    $0x1c,%esp
  8027a2:	5b                   	pop    %ebx
  8027a3:	5e                   	pop    %esi
  8027a4:	5f                   	pop    %edi
  8027a5:	5d                   	pop    %ebp
  8027a6:	c3                   	ret    
  8027a7:	90                   	nop
  8027a8:	89 fd                	mov    %edi,%ebp
  8027aa:	85 ff                	test   %edi,%edi
  8027ac:	75 0b                	jne    8027b9 <__umoddi3+0xe9>
  8027ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8027b3:	31 d2                	xor    %edx,%edx
  8027b5:	f7 f7                	div    %edi
  8027b7:	89 c5                	mov    %eax,%ebp
  8027b9:	89 f0                	mov    %esi,%eax
  8027bb:	31 d2                	xor    %edx,%edx
  8027bd:	f7 f5                	div    %ebp
  8027bf:	89 c8                	mov    %ecx,%eax
  8027c1:	f7 f5                	div    %ebp
  8027c3:	89 d0                	mov    %edx,%eax
  8027c5:	e9 44 ff ff ff       	jmp    80270e <__umoddi3+0x3e>
  8027ca:	66 90                	xchg   %ax,%ax
  8027cc:	89 c8                	mov    %ecx,%eax
  8027ce:	89 f2                	mov    %esi,%edx
  8027d0:	83 c4 1c             	add    $0x1c,%esp
  8027d3:	5b                   	pop    %ebx
  8027d4:	5e                   	pop    %esi
  8027d5:	5f                   	pop    %edi
  8027d6:	5d                   	pop    %ebp
  8027d7:	c3                   	ret    
  8027d8:	3b 04 24             	cmp    (%esp),%eax
  8027db:	72 06                	jb     8027e3 <__umoddi3+0x113>
  8027dd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027e1:	77 0f                	ja     8027f2 <__umoddi3+0x122>
  8027e3:	89 f2                	mov    %esi,%edx
  8027e5:	29 f9                	sub    %edi,%ecx
  8027e7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027eb:	89 14 24             	mov    %edx,(%esp)
  8027ee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027f2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027f6:	8b 14 24             	mov    (%esp),%edx
  8027f9:	83 c4 1c             	add    $0x1c,%esp
  8027fc:	5b                   	pop    %ebx
  8027fd:	5e                   	pop    %esi
  8027fe:	5f                   	pop    %edi
  8027ff:	5d                   	pop    %ebp
  802800:	c3                   	ret    
  802801:	8d 76 00             	lea    0x0(%esi),%esi
  802804:	2b 04 24             	sub    (%esp),%eax
  802807:	19 fa                	sbb    %edi,%edx
  802809:	89 d1                	mov    %edx,%ecx
  80280b:	89 c6                	mov    %eax,%esi
  80280d:	e9 71 ff ff ff       	jmp    802783 <__umoddi3+0xb3>
  802812:	66 90                	xchg   %ax,%ax
  802814:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802818:	72 ea                	jb     802804 <__umoddi3+0x134>
  80281a:	89 d9                	mov    %ebx,%ecx
  80281c:	e9 62 ff ff ff       	jmp    802783 <__umoddi3+0xb3>
