
obj/user/sc_matrix_operations:     file format elf32-i386


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
  800031:	e8 05 0a 00 00       	call   800a3b <libmain>
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
  800049:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
	int NumOfRep = 0;
  800050:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	do
	{
		val = 0;
  800057:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		//2012: lock the interrupt
		sys_lock_cons();
  80005e:	e8 82 1f 00 00       	call   801fe5 <sys_lock_cons>
		{
			cprintf("\n");
  800063:	83 ec 0c             	sub    $0xc,%esp
  800066:	68 40 28 80 00       	push   $0x802840
  80006b:	e8 f9 0e 00 00       	call   800f69 <cprintf>
  800070:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800073:	83 ec 0c             	sub    $0xc,%esp
  800076:	68 44 28 80 00       	push   $0x802844
  80007b:	e8 e9 0e 00 00       	call   800f69 <cprintf>
  800080:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   MATRIX MULTIPLICATION    !!!\n");
  800083:	83 ec 0c             	sub    $0xc,%esp
  800086:	68 68 28 80 00       	push   $0x802868
  80008b:	e8 d9 0e 00 00       	call   800f69 <cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	68 44 28 80 00       	push   $0x802844
  80009b:	e8 c9 0e 00 00       	call   800f69 <cprintf>
  8000a0:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  8000a3:	83 ec 0c             	sub    $0xc,%esp
  8000a6:	68 40 28 80 00       	push   $0x802840
  8000ab:	e8 b9 0e 00 00       	call   800f69 <cprintf>
  8000b0:	83 c4 10             	add    $0x10,%esp

			//readline("Enter the number of elements: ", Line);
			//NumOfElements = strtol(Line, NULL, 10) ;
			NumOfElements = 250 ;						//Add & Sub
  8000b3:	c7 45 ec fa 00 00 00 	movl   $0xfa,-0x14(%ebp)
			if (NumOfRep % 3 == 2) 	NumOfElements = 200 ;	//Mul
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	b9 03 00 00 00       	mov    $0x3,%ecx
  8000c2:	99                   	cltd   
  8000c3:	f7 f9                	idiv   %ecx
  8000c5:	89 d0                	mov    %edx,%eax
  8000c7:	83 f8 02             	cmp    $0x2,%eax
  8000ca:	75 07                	jne    8000d3 <_main+0x9b>
  8000cc:	c7 45 ec c8 00 00 00 	movl   $0xc8,-0x14(%ebp)
			cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  8000d3:	83 ec 08             	sub    $0x8,%esp
  8000d6:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d9:	68 8c 28 80 00       	push   $0x80288c
  8000de:	e8 86 0e 00 00       	call   800f69 <cprintf>
  8000e3:	83 c4 10             	add    $0x10,%esp
			//		cprintf("a) Ascending\n") ;
			//		cprintf("b) Identical\n") ;
			//		cprintf("c) Semi random\n");
			do
			{
				cprintf("Select: ") ;
  8000e6:	83 ec 0c             	sub    $0xc,%esp
  8000e9:	68 ae 28 80 00       	push   $0x8028ae
  8000ee:	e8 76 0e 00 00       	call   800f69 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp
				if (NumOfRep / 3 == 0) 		{ Chose = 'a'; cprintf("a) Ascending\n");}
  8000f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f9:	83 c0 02             	add    $0x2,%eax
  8000fc:	83 f8 04             	cmp    $0x4,%eax
  8000ff:	77 16                	ja     800117 <_main+0xdf>
  800101:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 b7 28 80 00       	push   $0x8028b7
  80010d:	e8 57 0e 00 00       	call   800f69 <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
  800115:	eb 40                	jmp    800157 <_main+0x11f>
				else if (NumOfRep/3 == 1) 	{ Chose = 'b'; cprintf("b) Identical\n");}
  800117:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80011a:	83 e8 03             	sub    $0x3,%eax
  80011d:	83 f8 02             	cmp    $0x2,%eax
  800120:	77 16                	ja     800138 <_main+0x100>
  800122:	c6 45 f7 62          	movb   $0x62,-0x9(%ebp)
  800126:	83 ec 0c             	sub    $0xc,%esp
  800129:	68 c5 28 80 00       	push   $0x8028c5
  80012e:	e8 36 0e 00 00       	call   800f69 <cprintf>
  800133:	83 c4 10             	add    $0x10,%esp
  800136:	eb 1f                	jmp    800157 <_main+0x11f>
				else if (NumOfRep/3 == 2) 	{ Chose = 'c'; cprintf("c) Semi random\n");}
  800138:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80013b:	83 e8 06             	sub    $0x6,%eax
  80013e:	83 f8 02             	cmp    $0x2,%eax
  800141:	77 14                	ja     800157 <_main+0x11f>
  800143:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
  800147:	83 ec 0c             	sub    $0xc,%esp
  80014a:	68 d3 28 80 00       	push   $0x8028d3
  80014f:	e8 15 0e 00 00       	call   800f69 <cprintf>
  800154:	83 c4 10             	add    $0x10,%esp
				//			cputchar(Chose);
				//			cputchar('\n');
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800157:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80015b:	74 10                	je     80016d <_main+0x135>
  80015d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800161:	74 0a                	je     80016d <_main+0x135>
  800163:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800167:	0f 85 79 ff ff ff    	jne    8000e6 <_main+0xae>

			if (Chose == 'b')
  80016d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800171:	75 07                	jne    80017a <_main+0x142>
			{
				//			readline("Enter the value to be initialized: ", Line);
				//			val = strtol(Line, NULL, 10) ;
				val = 1;
  800173:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
			}
		}
		//2012: lock the interrupt
		sys_unlock_cons();
  80017a:	e8 80 1e 00 00       	call   801fff <sys_unlock_cons>

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
  80017f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800182:	c1 e0 02             	shl    $0x2,%eax
  800185:	83 ec 0c             	sub    $0xc,%esp
  800188:	50                   	push   %eax
  800189:	e8 33 1d 00 00       	call   801ec1 <malloc>
  80018e:	83 c4 10             	add    $0x10,%esp
  800191:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int **M2 = malloc(sizeof(int) * NumOfElements) ;
  800194:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800197:	c1 e0 02             	shl    $0x2,%eax
  80019a:	83 ec 0c             	sub    $0xc,%esp
  80019d:	50                   	push   %eax
  80019e:	e8 1e 1d 00 00       	call   801ec1 <malloc>
  8001a3:	83 c4 10             	add    $0x10,%esp
  8001a6:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		for (int i = 0; i < NumOfElements; ++i)
  8001a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8001b0:	eb 4b                	jmp    8001fd <_main+0x1c5>
		{
			M1[i] = malloc(sizeof(int) * NumOfElements) ;
  8001b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001bc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001bf:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8001c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001c5:	c1 e0 02             	shl    $0x2,%eax
  8001c8:	83 ec 0c             	sub    $0xc,%esp
  8001cb:	50                   	push   %eax
  8001cc:	e8 f0 1c 00 00       	call   801ec1 <malloc>
  8001d1:	83 c4 10             	add    $0x10,%esp
  8001d4:	89 03                	mov    %eax,(%ebx)
			M2[i] = malloc(sizeof(int) * NumOfElements) ;
  8001d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001e3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8001e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001e9:	c1 e0 02             	shl    $0x2,%eax
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	50                   	push   %eax
  8001f0:	e8 cc 1c 00 00       	call   801ec1 <malloc>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 03                	mov    %eax,(%ebx)
		sys_unlock_cons();

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
		int **M2 = malloc(sizeof(int) * NumOfElements) ;

		for (int i = 0; i < NumOfElements; ++i)
  8001fa:	ff 45 e4             	incl   -0x1c(%ebp)
  8001fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800200:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800203:	7c ad                	jl     8001b2 <_main+0x17a>
		}

		//cprintf("matrices are created\n");

		int  i ;
		switch (Chose)
  800205:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800209:	83 f8 62             	cmp    $0x62,%eax
  80020c:	74 2e                	je     80023c <_main+0x204>
  80020e:	83 f8 63             	cmp    $0x63,%eax
  800211:	74 53                	je     800266 <_main+0x22e>
  800213:	83 f8 61             	cmp    $0x61,%eax
  800216:	75 72                	jne    80028a <_main+0x252>
		{
		case 'a':
			InitializeAscending(M1, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 d8             	pushl  -0x28(%ebp)
  800221:	e8 e2 05 00 00       	call   800808 <InitializeAscending>
  800226:	83 c4 10             	add    $0x10,%esp
			InitializeAscending(M2, NumOfElements);
  800229:	83 ec 08             	sub    $0x8,%esp
  80022c:	ff 75 ec             	pushl  -0x14(%ebp)
  80022f:	ff 75 d4             	pushl  -0x2c(%ebp)
  800232:	e8 d1 05 00 00       	call   800808 <InitializeAscending>
  800237:	83 c4 10             	add    $0x10,%esp
			break ;
  80023a:	eb 70                	jmp    8002ac <_main+0x274>
		case 'b':
			InitializeIdentical(M1, NumOfElements, val);
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	ff 75 f0             	pushl  -0x10(%ebp)
  800242:	ff 75 ec             	pushl  -0x14(%ebp)
  800245:	ff 75 d8             	pushl  -0x28(%ebp)
  800248:	e8 0a 06 00 00       	call   800857 <InitializeIdentical>
  80024d:	83 c4 10             	add    $0x10,%esp
			InitializeIdentical(M2, NumOfElements, val);
  800250:	83 ec 04             	sub    $0x4,%esp
  800253:	ff 75 f0             	pushl  -0x10(%ebp)
  800256:	ff 75 ec             	pushl  -0x14(%ebp)
  800259:	ff 75 d4             	pushl  -0x2c(%ebp)
  80025c:	e8 f6 05 00 00       	call   800857 <InitializeIdentical>
  800261:	83 c4 10             	add    $0x10,%esp
			break ;
  800264:	eb 46                	jmp    8002ac <_main+0x274>
		case 'c':
			InitializeSemiRandom(M1, NumOfElements);
  800266:	83 ec 08             	sub    $0x8,%esp
  800269:	ff 75 ec             	pushl  -0x14(%ebp)
  80026c:	ff 75 d8             	pushl  -0x28(%ebp)
  80026f:	e8 32 06 00 00       	call   8008a6 <InitializeSemiRandom>
  800274:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  800277:	83 ec 08             	sub    $0x8,%esp
  80027a:	ff 75 ec             	pushl  -0x14(%ebp)
  80027d:	ff 75 d4             	pushl  -0x2c(%ebp)
  800280:	e8 21 06 00 00       	call   8008a6 <InitializeSemiRandom>
  800285:	83 c4 10             	add    $0x10,%esp
			//PrintElements(M1, NumOfElements);
			break ;
  800288:	eb 22                	jmp    8002ac <_main+0x274>
		default:
			InitializeSemiRandom(M1, NumOfElements);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	ff 75 ec             	pushl  -0x14(%ebp)
  800290:	ff 75 d8             	pushl  -0x28(%ebp)
  800293:	e8 0e 06 00 00       	call   8008a6 <InitializeSemiRandom>
  800298:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  80029b:	83 ec 08             	sub    $0x8,%esp
  80029e:	ff 75 ec             	pushl  -0x14(%ebp)
  8002a1:	ff 75 d4             	pushl  -0x2c(%ebp)
  8002a4:	e8 fd 05 00 00       	call   8008a6 <InitializeSemiRandom>
  8002a9:	83 c4 10             	add    $0x10,%esp
		}

		sys_lock_cons();
  8002ac:	e8 34 1d 00 00       	call   801fe5 <sys_lock_cons>
			//		cprintf("a) Addition       (+)\n") ;
			//		cprintf("b) Subtraction    (-)\n") ;
			//		cprintf("c) Multiplication (x)\n");
			do
			{
				cprintf("Select: ") ;
  8002b1:	83 ec 0c             	sub    $0xc,%esp
  8002b4:	68 ae 28 80 00       	push   $0x8028ae
  8002b9:	e8 ab 0c 00 00       	call   800f69 <cprintf>
  8002be:	83 c4 10             	add    $0x10,%esp
				if (NumOfRep % 3 == 0) 		{ Chose = 'a'; cprintf("a) Add (+) \n");}
  8002c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002c4:	b9 03 00 00 00       	mov    $0x3,%ecx
  8002c9:	99                   	cltd   
  8002ca:	f7 f9                	idiv   %ecx
  8002cc:	89 d0                	mov    %edx,%eax
  8002ce:	85 c0                	test   %eax,%eax
  8002d0:	75 16                	jne    8002e8 <_main+0x2b0>
  8002d2:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  8002d6:	83 ec 0c             	sub    $0xc,%esp
  8002d9:	68 e3 28 80 00       	push   $0x8028e3
  8002de:	e8 86 0c 00 00       	call   800f69 <cprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp
  8002e6:	eb 4e                	jmp    800336 <_main+0x2fe>
				else if (NumOfRep%3 == 1) 	{ Chose = 'b'; cprintf("b) Sub (-) \n");}
  8002e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002eb:	b9 03 00 00 00       	mov    $0x3,%ecx
  8002f0:	99                   	cltd   
  8002f1:	f7 f9                	idiv   %ecx
  8002f3:	89 d0                	mov    %edx,%eax
  8002f5:	83 f8 01             	cmp    $0x1,%eax
  8002f8:	75 16                	jne    800310 <_main+0x2d8>
  8002fa:	c6 45 f7 62          	movb   $0x62,-0x9(%ebp)
  8002fe:	83 ec 0c             	sub    $0xc,%esp
  800301:	68 f0 28 80 00       	push   $0x8028f0
  800306:	e8 5e 0c 00 00       	call   800f69 <cprintf>
  80030b:	83 c4 10             	add    $0x10,%esp
  80030e:	eb 26                	jmp    800336 <_main+0x2fe>
				else if (NumOfRep%3 == 2) 	{ Chose = 'c'; cprintf("c) Mul (x) \n");}
  800310:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800313:	b9 03 00 00 00       	mov    $0x3,%ecx
  800318:	99                   	cltd   
  800319:	f7 f9                	idiv   %ecx
  80031b:	89 d0                	mov    %edx,%eax
  80031d:	83 f8 02             	cmp    $0x2,%eax
  800320:	75 14                	jne    800336 <_main+0x2fe>
  800322:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
  800326:	83 ec 0c             	sub    $0xc,%esp
  800329:	68 fd 28 80 00       	push   $0x8028fd
  80032e:	e8 36 0c 00 00       	call   800f69 <cprintf>
  800333:	83 c4 10             	add    $0x10,%esp
				//			cputchar(Chose);
				//			cputchar('\n');
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800336:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80033a:	74 10                	je     80034c <_main+0x314>
  80033c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800340:	74 0a                	je     80034c <_main+0x314>
  800342:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800346:	0f 85 65 ff ff ff    	jne    8002b1 <_main+0x279>
		}
		sys_unlock_cons();
  80034c:	e8 ae 1c 00 00       	call   801fff <sys_unlock_cons>


		int64** Res = NULL ;
  800351:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		switch (Chose)
  800358:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80035c:	83 f8 62             	cmp    $0x62,%eax
  80035f:	74 23                	je     800384 <_main+0x34c>
  800361:	83 f8 63             	cmp    $0x63,%eax
  800364:	74 37                	je     80039d <_main+0x365>
  800366:	83 f8 61             	cmp    $0x61,%eax
  800369:	75 4b                	jne    8003b6 <_main+0x37e>
		{
		case 'a':
			Res = MatrixAddition(M1, M2, NumOfElements);
  80036b:	83 ec 04             	sub    $0x4,%esp
  80036e:	ff 75 ec             	pushl  -0x14(%ebp)
  800371:	ff 75 d4             	pushl  -0x2c(%ebp)
  800374:	ff 75 d8             	pushl  -0x28(%ebp)
  800377:	e8 d2 02 00 00       	call   80064e <MatrixAddition>
  80037c:	83 c4 10             	add    $0x10,%esp
  80037f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  800382:	eb 49                	jmp    8003cd <_main+0x395>
		case 'b':
			Res = MatrixSubtraction(M1, M2, NumOfElements);
  800384:	83 ec 04             	sub    $0x4,%esp
  800387:	ff 75 ec             	pushl  -0x14(%ebp)
  80038a:	ff 75 d4             	pushl  -0x2c(%ebp)
  80038d:	ff 75 d8             	pushl  -0x28(%ebp)
  800390:	e8 95 03 00 00       	call   80072a <MatrixSubtraction>
  800395:	83 c4 10             	add    $0x10,%esp
  800398:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  80039b:	eb 30                	jmp    8003cd <_main+0x395>
		case 'c':
			Res = MatrixMultiply(M1, M2, NumOfElements);
  80039d:	83 ec 04             	sub    $0x4,%esp
  8003a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8003a3:	ff 75 d4             	pushl  -0x2c(%ebp)
  8003a6:	ff 75 d8             	pushl  -0x28(%ebp)
  8003a9:	e8 50 01 00 00       	call   8004fe <MatrixMultiply>
  8003ae:	83 c4 10             	add    $0x10,%esp
  8003b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  8003b4:	eb 17                	jmp    8003cd <_main+0x395>
		default:
			Res = MatrixAddition(M1, M2, NumOfElements);
  8003b6:	83 ec 04             	sub    $0x4,%esp
  8003b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8003bc:	ff 75 d4             	pushl  -0x2c(%ebp)
  8003bf:	ff 75 d8             	pushl  -0x28(%ebp)
  8003c2:	e8 87 02 00 00       	call   80064e <MatrixAddition>
  8003c7:	83 c4 10             	add    $0x10,%esp
  8003ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
			//PrintElements64(Res, NumOfElements);
		}

		if (uheapPageAllocBreak > USER_HEAP_START + DYN_ALLOC_MAX_SIZE + PAGE_SIZE)
  8003cd:	a1 4c 40 80 00       	mov    0x80404c,%eax
  8003d2:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8003d7:	76 17                	jbe    8003f0 <_main+0x3b8>
			panic("page alloc is invoked!!");
  8003d9:	83 ec 04             	sub    $0x4,%esp
  8003dc:	68 0a 29 80 00       	push   $0x80290a
  8003e1:	68 87 00 00 00       	push   $0x87
  8003e6:	68 22 29 80 00       	push   $0x802922
  8003eb:	e8 ab 08 00 00       	call   800c9b <_panic>

		sys_lock_cons();
  8003f0:	e8 f0 1b 00 00       	call   801fe5 <sys_lock_cons>
		{
			cprintf("Operation is COMPLETED.\n");
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	68 3e 29 80 00       	push   $0x80293e
  8003fd:	e8 67 0b 00 00       	call   800f69 <cprintf>
  800402:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800405:	e8 f5 1b 00 00       	call   801fff <sys_unlock_cons>

		for (int i = 0; i < NumOfElements; ++i)
  80040a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800411:	eb 5a                	jmp    80046d <_main+0x435>
		{
			free(M1[i]);
  800413:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800416:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800420:	01 d0                	add    %edx,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	83 ec 0c             	sub    $0xc,%esp
  800427:	50                   	push   %eax
  800428:	e8 c2 1a 00 00       	call   801eef <free>
  80042d:	83 c4 10             	add    $0x10,%esp
			free(M2[i]);
  800430:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	83 ec 0c             	sub    $0xc,%esp
  800444:	50                   	push   %eax
  800445:	e8 a5 1a 00 00       	call   801eef <free>
  80044a:	83 c4 10             	add    $0x10,%esp
			free(Res[i]);
  80044d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800450:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800457:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80045a:	01 d0                	add    %edx,%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	83 ec 0c             	sub    $0xc,%esp
  800461:	50                   	push   %eax
  800462:	e8 88 1a 00 00       	call   801eef <free>
  800467:	83 c4 10             	add    $0x10,%esp
		{
			cprintf("Operation is COMPLETED.\n");
		}
		sys_unlock_cons();

		for (int i = 0; i < NumOfElements; ++i)
  80046a:	ff 45 dc             	incl   -0x24(%ebp)
  80046d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800470:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800473:	7c 9e                	jl     800413 <_main+0x3db>
		{
			free(M1[i]);
			free(M2[i]);
			free(Res[i]);
		}
		free(M1) ;
  800475:	83 ec 0c             	sub    $0xc,%esp
  800478:	ff 75 d8             	pushl  -0x28(%ebp)
  80047b:	e8 6f 1a 00 00       	call   801eef <free>
  800480:	83 c4 10             	add    $0x10,%esp
		free(M2) ;
  800483:	83 ec 0c             	sub    $0xc,%esp
  800486:	ff 75 d4             	pushl  -0x2c(%ebp)
  800489:	e8 61 1a 00 00       	call   801eef <free>
  80048e:	83 c4 10             	add    $0x10,%esp
		free(Res) ;
  800491:	83 ec 0c             	sub    $0xc,%esp
  800494:	ff 75 e0             	pushl  -0x20(%ebp)
  800497:	e8 53 1a 00 00       	call   801eef <free>
  80049c:	83 c4 10             	add    $0x10,%esp

		NumOfRep++ ;
  80049f:	ff 45 e8             	incl   -0x18(%ebp)

		sys_lock_cons();
  8004a2:	e8 3e 1b 00 00       	call   801fe5 <sys_lock_cons>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8004a7:	83 ec 0c             	sub    $0xc,%esp
  8004aa:	68 57 29 80 00       	push   $0x802957
  8004af:	e8 b5 0a 00 00       	call   800f69 <cprintf>
  8004b4:	83 c4 10             	add    $0x10,%esp
			if (NumOfRep == 9)
  8004b7:	83 7d e8 09          	cmpl   $0x9,-0x18(%ebp)
  8004bb:	75 06                	jne    8004c3 <_main+0x48b>
				Chose = 'n' ;
  8004bd:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
  8004c1:	eb 04                	jmp    8004c7 <_main+0x48f>
			else
				Chose = 'y' ;
  8004c3:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
			cputchar(Chose);
  8004c7:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8004cb:	83 ec 0c             	sub    $0xc,%esp
  8004ce:	50                   	push   %eax
  8004cf:	e8 25 05 00 00       	call   8009f9 <cputchar>
  8004d4:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8004d7:	83 ec 0c             	sub    $0xc,%esp
  8004da:	6a 0a                	push   $0xa
  8004dc:	e8 18 05 00 00       	call   8009f9 <cputchar>
  8004e1:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004e4:	e8 16 1b 00 00       	call   801fff <sys_unlock_cons>

	} while (Chose == 'y');
  8004e9:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8004ed:	0f 84 64 fb ff ff    	je     800057 <_main+0x1f>

	//To indicate that it's completed successfully
	inctst();
  8004f3:	e8 6d 1e 00 00       	call   802365 <inctst>
}
  8004f8:	90                   	nop
  8004f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004fc:	c9                   	leave  
  8004fd:	c3                   	ret    

008004fe <MatrixMultiply>:

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
  8004fe:	55                   	push   %ebp
  8004ff:	89 e5                	mov    %esp,%ebp
  800501:	57                   	push   %edi
  800502:	56                   	push   %esi
  800503:	53                   	push   %ebx
  800504:	83 ec 2c             	sub    $0x2c,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800507:	8b 45 10             	mov    0x10(%ebp),%eax
  80050a:	c1 e0 03             	shl    $0x3,%eax
  80050d:	83 ec 0c             	sub    $0xc,%esp
  800510:	50                   	push   %eax
  800511:	e8 ab 19 00 00       	call   801ec1 <malloc>
  800516:	83 c4 10             	add    $0x10,%esp
  800519:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  80051c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800523:	eb 27                	jmp    80054c <MatrixMultiply+0x4e>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800525:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800528:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800532:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800535:	8b 45 10             	mov    0x10(%ebp),%eax
  800538:	c1 e0 03             	shl    $0x3,%eax
  80053b:	83 ec 0c             	sub    $0xc,%esp
  80053e:	50                   	push   %eax
  80053f:	e8 7d 19 00 00       	call   801ec1 <malloc>
  800544:	83 c4 10             	add    $0x10,%esp
  800547:	89 03                	mov    %eax,(%ebx)

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800549:	ff 45 e4             	incl   -0x1c(%ebp)
  80054c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80054f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800552:	7c d1                	jl     800525 <MatrixMultiply+0x27>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800554:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80055b:	e9 d7 00 00 00       	jmp    800637 <MatrixMultiply+0x139>
	{
		for (int j = 0; j < NumOfElements; ++j)
  800560:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800567:	e9 bc 00 00 00       	jmp    800628 <MatrixMultiply+0x12a>
		{
			Res[i][j] = 0 ;
  80056c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800576:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800579:	01 d0                	add    %edx,%eax
  80057b:	8b 00                	mov    (%eax),%eax
  80057d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800580:	c1 e2 03             	shl    $0x3,%edx
  800583:	01 d0                	add    %edx,%eax
  800585:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80058b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			for (int k = 0; k < NumOfElements; ++k)
  800592:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800599:	eb 7e                	jmp    800619 <MatrixMultiply+0x11b>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
  80059b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80059e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005a8:	01 d0                	add    %edx,%eax
  8005aa:	8b 00                	mov    (%eax),%eax
  8005ac:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005af:	c1 e2 03             	shl    $0x3,%edx
  8005b2:	8d 34 10             	lea    (%eax,%edx,1),%esi
  8005b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c2:	01 d0                	add    %edx,%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005c9:	c1 e2 03             	shl    $0x3,%edx
  8005cc:	01 d0                	add    %edx,%eax
  8005ce:	8b 08                	mov    (%eax),%ecx
  8005d0:	8b 58 04             	mov    0x4(%eax),%ebx
  8005d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e0:	01 d0                	add    %edx,%eax
  8005e2:	8b 00                	mov    (%eax),%eax
  8005e4:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8005e7:	c1 e2 02             	shl    $0x2,%edx
  8005ea:	01 d0                	add    %edx,%eax
  8005ec:	8b 10                	mov    (%eax),%edx
  8005ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005f1:	8d 3c 85 00 00 00 00 	lea    0x0(,%eax,4),%edi
  8005f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005fb:	01 f8                	add    %edi,%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	8b 7d dc             	mov    -0x24(%ebp),%edi
  800602:	c1 e7 02             	shl    $0x2,%edi
  800605:	01 f8                	add    %edi,%eax
  800607:	8b 00                	mov    (%eax),%eax
  800609:	0f af c2             	imul   %edx,%eax
  80060c:	99                   	cltd   
  80060d:	01 c8                	add    %ecx,%eax
  80060f:	11 da                	adc    %ebx,%edx
  800611:	89 06                	mov    %eax,(%esi)
  800613:	89 56 04             	mov    %edx,0x4(%esi)
	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = 0 ;
			for (int k = 0; k < NumOfElements; ++k)
  800616:	ff 45 d8             	incl   -0x28(%ebp)
  800619:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80061c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80061f:	0f 8c 76 ff ff ff    	jl     80059b <MatrixMultiply+0x9d>
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  800625:	ff 45 dc             	incl   -0x24(%ebp)
  800628:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80062b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80062e:	0f 8c 38 ff ff ff    	jl     80056c <MatrixMultiply+0x6e>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800634:	ff 45 e0             	incl   -0x20(%ebp)
  800637:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80063d:	0f 8c 1d ff ff ff    	jl     800560 <MatrixMultiply+0x62>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
			}
		}
	}
	return Res;
  800643:	8b 45 d4             	mov    -0x2c(%ebp),%eax
}
  800646:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800649:	5b                   	pop    %ebx
  80064a:	5e                   	pop    %esi
  80064b:	5f                   	pop    %edi
  80064c:	5d                   	pop    %ebp
  80064d:	c3                   	ret    

0080064e <MatrixAddition>:

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
  800651:	53                   	push   %ebx
  800652:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800655:	8b 45 10             	mov    0x10(%ebp),%eax
  800658:	c1 e0 03             	shl    $0x3,%eax
  80065b:	83 ec 0c             	sub    $0xc,%esp
  80065e:	50                   	push   %eax
  80065f:	e8 5d 18 00 00       	call   801ec1 <malloc>
  800664:	83 c4 10             	add    $0x10,%esp
  800667:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  80066a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800671:	eb 27                	jmp    80069a <MatrixAddition+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800673:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800676:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80067d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800680:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800683:	8b 45 10             	mov    0x10(%ebp),%eax
  800686:	c1 e0 03             	shl    $0x3,%eax
  800689:	83 ec 0c             	sub    $0xc,%esp
  80068c:	50                   	push   %eax
  80068d:	e8 2f 18 00 00       	call   801ec1 <malloc>
  800692:	83 c4 10             	add    $0x10,%esp
  800695:	89 03                	mov    %eax,(%ebx)

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800697:	ff 45 f4             	incl   -0xc(%ebp)
  80069a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80069d:	3b 45 10             	cmp    0x10(%ebp),%eax
  8006a0:	7c d1                	jl     800673 <MatrixAddition+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8006a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8006a9:	eb 6f                	jmp    80071a <MatrixAddition+0xcc>
	{
		for (int j = 0; j < NumOfElements; ++j)
  8006ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8006b2:	eb 5b                	jmp    80070f <MatrixAddition+0xc1>
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
  8006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c8:	c1 e2 03             	shl    $0x3,%edx
  8006cb:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  8006ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	01 d0                	add    %edx,%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006e2:	c1 e2 02             	shl    $0x2,%edx
  8006e5:	01 d0                	add    %edx,%eax
  8006e7:	8b 10                	mov    (%eax),%edx
  8006e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ec:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8006f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f6:	01 d8                	add    %ebx,%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8006fd:	c1 e3 02             	shl    $0x2,%ebx
  800700:	01 d8                	add    %ebx,%eax
  800702:	8b 00                	mov    (%eax),%eax
  800704:	01 d0                	add    %edx,%eax
  800706:	99                   	cltd   
  800707:	89 01                	mov    %eax,(%ecx)
  800709:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  80070c:	ff 45 ec             	incl   -0x14(%ebp)
  80070f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800712:	3b 45 10             	cmp    0x10(%ebp),%eax
  800715:	7c 9d                	jl     8006b4 <MatrixAddition+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800717:	ff 45 f0             	incl   -0x10(%ebp)
  80071a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800720:	7c 89                	jl     8006ab <MatrixAddition+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
		}
	}
	return Res;
  800722:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  800725:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800728:	c9                   	leave  
  800729:	c3                   	ret    

0080072a <MatrixSubtraction>:

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
  80072a:	55                   	push   %ebp
  80072b:	89 e5                	mov    %esp,%ebp
  80072d:	53                   	push   %ebx
  80072e:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800731:	8b 45 10             	mov    0x10(%ebp),%eax
  800734:	c1 e0 03             	shl    $0x3,%eax
  800737:	83 ec 0c             	sub    $0xc,%esp
  80073a:	50                   	push   %eax
  80073b:	e8 81 17 00 00       	call   801ec1 <malloc>
  800740:	83 c4 10             	add    $0x10,%esp
  800743:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  800746:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80074d:	eb 27                	jmp    800776 <MatrixSubtraction+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  80074f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800752:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800759:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80075c:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  80075f:	8b 45 10             	mov    0x10(%ebp),%eax
  800762:	c1 e0 03             	shl    $0x3,%eax
  800765:	83 ec 0c             	sub    $0xc,%esp
  800768:	50                   	push   %eax
  800769:	e8 53 17 00 00       	call   801ec1 <malloc>
  80076e:	83 c4 10             	add    $0x10,%esp
  800771:	89 03                	mov    %eax,(%ebx)

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800773:	ff 45 f4             	incl   -0xc(%ebp)
  800776:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800779:	3b 45 10             	cmp    0x10(%ebp),%eax
  80077c:	7c d1                	jl     80074f <MatrixSubtraction+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  80077e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800785:	eb 71                	jmp    8007f8 <MatrixSubtraction+0xce>
	{
		for (int j = 0; j < NumOfElements; ++j)
  800787:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80078e:	eb 5d                	jmp    8007ed <MatrixSubtraction+0xc3>
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
  800790:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800793:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80079d:	01 d0                	add    %edx,%eax
  80079f:	8b 00                	mov    (%eax),%eax
  8007a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007a4:	c1 e2 03             	shl    $0x3,%edx
  8007a7:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  8007aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	01 d0                	add    %edx,%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007be:	c1 e2 02             	shl    $0x2,%edx
  8007c1:	01 d0                	add    %edx,%eax
  8007c3:	8b 10                	mov    (%eax),%edx
  8007c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c8:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8007cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d2:	01 d8                	add    %ebx,%eax
  8007d4:	8b 00                	mov    (%eax),%eax
  8007d6:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8007d9:	c1 e3 02             	shl    $0x2,%ebx
  8007dc:	01 d8                	add    %ebx,%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	29 c2                	sub    %eax,%edx
  8007e2:	89 d0                	mov    %edx,%eax
  8007e4:	99                   	cltd   
  8007e5:	89 01                	mov    %eax,(%ecx)
  8007e7:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  8007ea:	ff 45 ec             	incl   -0x14(%ebp)
  8007ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007f3:	7c 9b                	jl     800790 <MatrixSubtraction+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8007f5:	ff 45 f0             	incl   -0x10(%ebp)
  8007f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007fb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007fe:	7c 87                	jl     800787 <MatrixSubtraction+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
		}
	}
	return Res;
  800800:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  800803:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800806:	c9                   	leave  
  800807:	c3                   	ret    

00800808 <InitializeAscending>:

///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
  800808:	55                   	push   %ebp
  800809:	89 e5                	mov    %esp,%ebp
  80080b:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80080e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800815:	eb 35                	jmp    80084c <InitializeAscending+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800817:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80081e:	eb 21                	jmp    800841 <InitializeAscending+0x39>
		{
			(Elements)[i][j] = j ;
  800820:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800823:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	01 d0                	add    %edx,%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800834:	c1 e2 02             	shl    $0x2,%edx
  800837:	01 c2                	add    %eax,%edx
  800839:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80083c:	89 02                	mov    %eax,(%edx)
void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80083e:	ff 45 f8             	incl   -0x8(%ebp)
  800841:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800844:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800847:	7c d7                	jl     800820 <InitializeAscending+0x18>
///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800849:	ff 45 fc             	incl   -0x4(%ebp)
  80084c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80084f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800852:	7c c3                	jl     800817 <InitializeAscending+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = j ;
		}
	}
}
  800854:	90                   	nop
  800855:	c9                   	leave  
  800856:	c3                   	ret    

00800857 <InitializeIdentical>:

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
  800857:	55                   	push   %ebp
  800858:	89 e5                	mov    %esp,%ebp
  80085a:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80085d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800864:	eb 35                	jmp    80089b <InitializeIdentical+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800866:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80086d:	eb 21                	jmp    800890 <InitializeIdentical+0x39>
		{
			(Elements)[i][j] = value ;
  80086f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800872:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800879:	8b 45 08             	mov    0x8(%ebp),%eax
  80087c:	01 d0                	add    %edx,%eax
  80087e:	8b 00                	mov    (%eax),%eax
  800880:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800883:	c1 e2 02             	shl    $0x2,%edx
  800886:	01 c2                	add    %eax,%edx
  800888:	8b 45 10             	mov    0x10(%ebp),%eax
  80088b:	89 02                	mov    %eax,(%edx)
void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80088d:	ff 45 f8             	incl   -0x8(%ebp)
  800890:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800893:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800896:	7c d7                	jl     80086f <InitializeIdentical+0x18>
}

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800898:	ff 45 fc             	incl   -0x4(%ebp)
  80089b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80089e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008a1:	7c c3                	jl     800866 <InitializeIdentical+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = value ;
		}
	}
}
  8008a3:	90                   	nop
  8008a4:	c9                   	leave  
  8008a5:	c3                   	ret    

008008a6 <InitializeSemiRandom>:

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
  8008a6:	55                   	push   %ebp
  8008a7:	89 e5                	mov    %esp,%ebp
  8008a9:	53                   	push   %ebx
  8008aa:	83 ec 20             	sub    $0x20,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8008ad:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8008b4:	eb 56                	jmp    80090c <InitializeSemiRandom+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8008b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8008bd:	eb 42                	jmp    800901 <InitializeSemiRandom+0x5b>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
  8008bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8008c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	01 d0                	add    %edx,%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d3:	c1 e2 02             	shl    $0x2,%edx
  8008d6:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  8008d9:	0f 31                	rdtsc  
  8008db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008de:	89 55 e8             	mov    %edx,-0x18(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  8008e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ea:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8008ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008f0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8008f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8008f8:	f7 f3                	div    %ebx
  8008fa:	89 d0                	mov    %edx,%eax
  8008fc:	89 01                	mov    %eax,(%ecx)
void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8008fe:	ff 45 f4             	incl   -0xc(%ebp)
  800901:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800904:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800907:	7c b6                	jl     8008bf <InitializeSemiRandom+0x19>
}

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800909:	ff 45 f8             	incl   -0x8(%ebp)
  80090c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80090f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800912:	7c a2                	jl     8008b6 <InitializeSemiRandom+0x10>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
			//	cprintf("i=%d\n",i);
		}
	}
}
  800914:	90                   	nop
  800915:	83 c4 20             	add    $0x20,%esp
  800918:	5b                   	pop    %ebx
  800919:	5d                   	pop    %ebp
  80091a:	c3                   	ret    

0080091b <PrintElements>:

void PrintElements(int **Elements, int NumOfElements)
{
  80091b:	55                   	push   %ebp
  80091c:	89 e5                	mov    %esp,%ebp
  80091e:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800921:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800928:	eb 53                	jmp    80097d <PrintElements+0x62>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80092a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800931:	eb 2f                	jmp    800962 <PrintElements+0x47>
		{
			cprintf("%~%d, ",Elements[i][j]);
  800933:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800936:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80093d:	8b 45 08             	mov    0x8(%ebp),%eax
  800940:	01 d0                	add    %edx,%eax
  800942:	8b 00                	mov    (%eax),%eax
  800944:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800947:	c1 e2 02             	shl    $0x2,%edx
  80094a:	01 d0                	add    %edx,%eax
  80094c:	8b 00                	mov    (%eax),%eax
  80094e:	83 ec 08             	sub    $0x8,%esp
  800951:	50                   	push   %eax
  800952:	68 75 29 80 00       	push   $0x802975
  800957:	e8 0d 06 00 00       	call   800f69 <cprintf>
  80095c:	83 c4 10             	add    $0x10,%esp
void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80095f:	ff 45 f0             	incl   -0x10(%ebp)
  800962:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800965:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800968:	7c c9                	jl     800933 <PrintElements+0x18>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
  80096a:	83 ec 0c             	sub    $0xc,%esp
  80096d:	68 7c 29 80 00       	push   $0x80297c
  800972:	e8 f2 05 00 00       	call   800f69 <cprintf>
  800977:	83 c4 10             	add    $0x10,%esp
}

void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80097a:	ff 45 f4             	incl   -0xc(%ebp)
  80097d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800980:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800983:	7c a5                	jl     80092a <PrintElements+0xf>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  800985:	90                   	nop
  800986:	c9                   	leave  
  800987:	c3                   	ret    

00800988 <PrintElements64>:

void PrintElements64(int64 **Elements, int NumOfElements)
{
  800988:	55                   	push   %ebp
  800989:	89 e5                	mov    %esp,%ebp
  80098b:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80098e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800995:	eb 57                	jmp    8009ee <PrintElements64+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800997:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80099e:	eb 33                	jmp    8009d3 <PrintElements64+0x4b>
		{
			cprintf("%~%lld, ",Elements[i][j]);
  8009a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	01 d0                	add    %edx,%eax
  8009af:	8b 00                	mov    (%eax),%eax
  8009b1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8009b4:	c1 e2 03             	shl    $0x3,%edx
  8009b7:	01 d0                	add    %edx,%eax
  8009b9:	8b 50 04             	mov    0x4(%eax),%edx
  8009bc:	8b 00                	mov    (%eax),%eax
  8009be:	83 ec 04             	sub    $0x4,%esp
  8009c1:	52                   	push   %edx
  8009c2:	50                   	push   %eax
  8009c3:	68 80 29 80 00       	push   $0x802980
  8009c8:	e8 9c 05 00 00       	call   800f69 <cprintf>
  8009cd:	83 c4 10             	add    $0x10,%esp
void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8009d0:	ff 45 f0             	incl   -0x10(%ebp)
  8009d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009d9:	7c c5                	jl     8009a0 <PrintElements64+0x18>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
  8009db:	83 ec 0c             	sub    $0xc,%esp
  8009de:	68 7c 29 80 00       	push   $0x80297c
  8009e3:	e8 81 05 00 00       	call   800f69 <cprintf>
  8009e8:	83 c4 10             	add    $0x10,%esp
}

void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8009eb:	ff 45 f4             	incl   -0xc(%ebp)
  8009ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009f1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009f4:	7c a1                	jl     800997 <PrintElements64+0xf>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  8009f6:	90                   	nop
  8009f7:	c9                   	leave  
  8009f8:	c3                   	ret    

008009f9 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8009f9:	55                   	push   %ebp
  8009fa:	89 e5                	mov    %esp,%ebp
  8009fc:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800a05:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800a09:	83 ec 0c             	sub    $0xc,%esp
  800a0c:	50                   	push   %eax
  800a0d:	e8 1b 17 00 00       	call   80212d <sys_cputc>
  800a12:	83 c4 10             	add    $0x10,%esp
}
  800a15:	90                   	nop
  800a16:	c9                   	leave  
  800a17:	c3                   	ret    

00800a18 <getchar>:


int
getchar(void)
{
  800a18:	55                   	push   %ebp
  800a19:	89 e5                	mov    %esp,%ebp
  800a1b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  800a1e:	e8 a9 15 00 00       	call   801fcc <sys_cgetc>
  800a23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a2a:	74 f2                	je     800a1e <getchar+0x6>
	return c;
  800a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <iscons>:

int iscons(int fdnum)
{
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800a34:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800a39:	5d                   	pop    %ebp
  800a3a:	c3                   	ret    

00800a3b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800a3b:	55                   	push   %ebp
  800a3c:	89 e5                	mov    %esp,%ebp
  800a3e:	57                   	push   %edi
  800a3f:	56                   	push   %esi
  800a40:	53                   	push   %ebx
  800a41:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800a47:	e8 11 18 00 00       	call   80225d <sys_getenvindex>
  800a4c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800a4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a52:	89 d0                	mov    %edx,%eax
  800a54:	c1 e0 03             	shl    $0x3,%eax
  800a57:	01 d0                	add    %edx,%eax
  800a59:	c1 e0 06             	shl    $0x6,%eax
  800a5c:	01 d0                	add    %edx,%eax
  800a5e:	c1 e0 03             	shl    $0x3,%eax
  800a61:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a66:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a6b:	a1 20 40 80 00       	mov    0x804020,%eax
  800a70:	8a 40 10             	mov    0x10(%eax),%al
  800a73:	84 c0                	test   %al,%al
  800a75:	74 0d                	je     800a84 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800a77:	a1 20 40 80 00       	mov    0x804020,%eax
  800a7c:	83 c0 10             	add    $0x10,%eax
  800a7f:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a84:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a88:	7e 0a                	jle    800a94 <libmain+0x59>
		binaryname = argv[0];
  800a8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8d:	8b 00                	mov    (%eax),%eax
  800a8f:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	ff 75 08             	pushl  0x8(%ebp)
  800a9d:	e8 96 f5 ff ff       	call   800038 <_main>
  800aa2:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800aa5:	a1 00 40 80 00       	mov    0x804000,%eax
  800aaa:	85 c0                	test   %eax,%eax
  800aac:	0f 84 b7 01 00 00    	je     800c69 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800ab2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800ab8:	bb c8 2a 80 00       	mov    $0x802ac8,%ebx
  800abd:	ba 0e 00 00 00       	mov    $0xe,%edx
  800ac2:	89 c7                	mov    %eax,%edi
  800ac4:	89 de                	mov    %ebx,%esi
  800ac6:	89 d1                	mov    %edx,%ecx
  800ac8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800aca:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800ad0:	b9 56 00 00 00       	mov    $0x56,%ecx
  800ad5:	b0 00                	mov    $0x0,%al
  800ad7:	89 d7                	mov    %edx,%edi
  800ad9:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800adb:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800ae2:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800ae5:	83 ec 08             	sub    $0x8,%esp
  800ae8:	50                   	push   %eax
  800ae9:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800aef:	50                   	push   %eax
  800af0:	e8 68 19 00 00       	call   80245d <sys_utilities>
  800af5:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800af8:	e8 e8 14 00 00       	call   801fe5 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800afd:	83 ec 0c             	sub    $0xc,%esp
  800b00:	68 a4 29 80 00       	push   $0x8029a4
  800b05:	e8 5f 04 00 00       	call   800f69 <cprintf>
  800b0a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800b0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800b10:	85 c0                	test   %eax,%eax
  800b12:	74 58                	je     800b6c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800b14:	e8 62 19 00 00       	call   80247b <sys_get_optimal_num_faults>
  800b19:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800b1c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b22:	bb 2c 2b 80 00       	mov    $0x802b2c,%ebx
  800b27:	ba 11 00 00 00       	mov    $0x11,%edx
  800b2c:	89 c7                	mov    %eax,%edi
  800b2e:	89 de                	mov    %ebx,%esi
  800b30:	89 d1                	mov    %edx,%ecx
  800b32:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800b34:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800b37:	b9 53 00 00 00       	mov    $0x53,%ecx
  800b3c:	b0 00                	mov    $0x0,%al
  800b3e:	89 d7                	mov    %edx,%edi
  800b40:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800b42:	83 ec 08             	sub    $0x8,%esp
  800b45:	ff 75 dc             	pushl  -0x24(%ebp)
  800b48:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b4e:	50                   	push   %eax
  800b4f:	e8 09 19 00 00       	call   80245d <sys_utilities>
  800b54:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800b57:	83 ec 08             	sub    $0x8,%esp
  800b5a:	ff 75 dc             	pushl  -0x24(%ebp)
  800b5d:	68 cc 29 80 00       	push   $0x8029cc
  800b62:	e8 02 04 00 00       	call   800f69 <cprintf>
  800b67:	83 c4 10             	add    $0x10,%esp
  800b6a:	eb 59                	jmp    800bc5 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b6c:	a1 20 40 80 00       	mov    0x804020,%eax
  800b71:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800b77:	a1 20 40 80 00       	mov    0x804020,%eax
  800b7c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800b82:	83 ec 04             	sub    $0x4,%esp
  800b85:	52                   	push   %edx
  800b86:	50                   	push   %eax
  800b87:	68 f0 29 80 00       	push   $0x8029f0
  800b8c:	e8 d8 03 00 00       	call   800f69 <cprintf>
  800b91:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800b94:	a1 20 40 80 00       	mov    0x804020,%eax
  800b99:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800b9f:	a1 20 40 80 00       	mov    0x804020,%eax
  800ba4:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800baa:	a1 20 40 80 00       	mov    0x804020,%eax
  800baf:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800bb5:	51                   	push   %ecx
  800bb6:	52                   	push   %edx
  800bb7:	50                   	push   %eax
  800bb8:	68 18 2a 80 00       	push   $0x802a18
  800bbd:	e8 a7 03 00 00       	call   800f69 <cprintf>
  800bc2:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800bc5:	a1 20 40 80 00       	mov    0x804020,%eax
  800bca:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800bd0:	83 ec 08             	sub    $0x8,%esp
  800bd3:	50                   	push   %eax
  800bd4:	68 70 2a 80 00       	push   $0x802a70
  800bd9:	e8 8b 03 00 00       	call   800f69 <cprintf>
  800bde:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800be1:	83 ec 0c             	sub    $0xc,%esp
  800be4:	68 84 2a 80 00       	push   $0x802a84
  800be9:	e8 7b 03 00 00       	call   800f69 <cprintf>
  800bee:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800bf1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800bf8:	eb 28                	jmp    800c22 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800bfa:	a1 20 40 80 00       	mov    0x804020,%eax
  800bff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c02:	81 c2 74 04 00 00    	add    $0x474,%edx
  800c08:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800c0b:	83 ec 04             	sub    $0x4,%esp
  800c0e:	50                   	push   %eax
  800c0f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c12:	68 9b 2a 80 00       	push   $0x802a9b
  800c17:	e8 4d 03 00 00       	call   800f69 <cprintf>
  800c1c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800c1f:	ff 45 e4             	incl   -0x1c(%ebp)
  800c22:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800c26:	7e d2                	jle    800bfa <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800c28:	83 ec 0c             	sub    $0xc,%esp
  800c2b:	68 aa 2a 80 00       	push   $0x802aaa
  800c30:	e8 34 03 00 00       	call   800f69 <cprintf>
  800c35:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800c38:	a1 20 40 80 00       	mov    0x804020,%eax
  800c3d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800c43:	83 ec 08             	sub    $0x8,%esp
  800c46:	50                   	push   %eax
  800c47:	68 ae 2a 80 00       	push   $0x802aae
  800c4c:	e8 18 03 00 00       	call   800f69 <cprintf>
  800c51:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800c54:	83 ec 0c             	sub    $0xc,%esp
  800c57:	68 a4 29 80 00       	push   $0x8029a4
  800c5c:	e8 08 03 00 00       	call   800f69 <cprintf>
  800c61:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800c64:	e8 96 13 00 00       	call   801fff <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800c69:	e8 1f 00 00 00       	call   800c8d <exit>
}
  800c6e:	90                   	nop
  800c6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800c72:	5b                   	pop    %ebx
  800c73:	5e                   	pop    %esi
  800c74:	5f                   	pop    %edi
  800c75:	5d                   	pop    %ebp
  800c76:	c3                   	ret    

00800c77 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c77:	55                   	push   %ebp
  800c78:	89 e5                	mov    %esp,%ebp
  800c7a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800c7d:	83 ec 0c             	sub    $0xc,%esp
  800c80:	6a 00                	push   $0x0
  800c82:	e8 a2 15 00 00       	call   802229 <sys_destroy_env>
  800c87:	83 c4 10             	add    $0x10,%esp
}
  800c8a:	90                   	nop
  800c8b:	c9                   	leave  
  800c8c:	c3                   	ret    

00800c8d <exit>:

void
exit(void)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
  800c90:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800c93:	e8 f7 15 00 00       	call   80228f <sys_exit_env>
}
  800c98:	90                   	nop
  800c99:	c9                   	leave  
  800c9a:	c3                   	ret    

00800c9b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
  800c9e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800ca1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ca4:	83 c0 04             	add    $0x4,%eax
  800ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800caa:	a1 28 41 80 00       	mov    0x804128,%eax
  800caf:	85 c0                	test   %eax,%eax
  800cb1:	74 16                	je     800cc9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800cb3:	a1 28 41 80 00       	mov    0x804128,%eax
  800cb8:	83 ec 08             	sub    $0x8,%esp
  800cbb:	50                   	push   %eax
  800cbc:	68 90 2b 80 00       	push   $0x802b90
  800cc1:	e8 a3 02 00 00       	call   800f69 <cprintf>
  800cc6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800cc9:	a1 04 40 80 00       	mov    0x804004,%eax
  800cce:	83 ec 0c             	sub    $0xc,%esp
  800cd1:	ff 75 0c             	pushl  0xc(%ebp)
  800cd4:	ff 75 08             	pushl  0x8(%ebp)
  800cd7:	50                   	push   %eax
  800cd8:	68 98 2b 80 00       	push   $0x802b98
  800cdd:	6a 74                	push   $0x74
  800cdf:	e8 b2 02 00 00       	call   800f96 <cprintf_colored>
  800ce4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800ce7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cea:	83 ec 08             	sub    $0x8,%esp
  800ced:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf0:	50                   	push   %eax
  800cf1:	e8 04 02 00 00       	call   800efa <vcprintf>
  800cf6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800cf9:	83 ec 08             	sub    $0x8,%esp
  800cfc:	6a 00                	push   $0x0
  800cfe:	68 c0 2b 80 00       	push   $0x802bc0
  800d03:	e8 f2 01 00 00       	call   800efa <vcprintf>
  800d08:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d0b:	e8 7d ff ff ff       	call   800c8d <exit>

	// should not return here
	while (1) ;
  800d10:	eb fe                	jmp    800d10 <_panic+0x75>

00800d12 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d12:	55                   	push   %ebp
  800d13:	89 e5                	mov    %esp,%ebp
  800d15:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d18:	a1 20 40 80 00       	mov    0x804020,%eax
  800d1d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800d23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d26:	39 c2                	cmp    %eax,%edx
  800d28:	74 14                	je     800d3e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d2a:	83 ec 04             	sub    $0x4,%esp
  800d2d:	68 c4 2b 80 00       	push   $0x802bc4
  800d32:	6a 26                	push   $0x26
  800d34:	68 10 2c 80 00       	push   $0x802c10
  800d39:	e8 5d ff ff ff       	call   800c9b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d45:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d4c:	e9 c5 00 00 00       	jmp    800e16 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800d51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	01 d0                	add    %edx,%eax
  800d60:	8b 00                	mov    (%eax),%eax
  800d62:	85 c0                	test   %eax,%eax
  800d64:	75 08                	jne    800d6e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800d66:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d69:	e9 a5 00 00 00       	jmp    800e13 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800d6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d75:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d7c:	eb 69                	jmp    800de7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d7e:	a1 20 40 80 00       	mov    0x804020,%eax
  800d83:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800d89:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d8c:	89 d0                	mov    %edx,%eax
  800d8e:	01 c0                	add    %eax,%eax
  800d90:	01 d0                	add    %edx,%eax
  800d92:	c1 e0 03             	shl    $0x3,%eax
  800d95:	01 c8                	add    %ecx,%eax
  800d97:	8a 40 04             	mov    0x4(%eax),%al
  800d9a:	84 c0                	test   %al,%al
  800d9c:	75 46                	jne    800de4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d9e:	a1 20 40 80 00       	mov    0x804020,%eax
  800da3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800da9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dac:	89 d0                	mov    %edx,%eax
  800dae:	01 c0                	add    %eax,%eax
  800db0:	01 d0                	add    %edx,%eax
  800db2:	c1 e0 03             	shl    $0x3,%eax
  800db5:	01 c8                	add    %ecx,%eax
  800db7:	8b 00                	mov    (%eax),%eax
  800db9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800dbc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800dbf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dc4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	01 c8                	add    %ecx,%eax
  800dd5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800dd7:	39 c2                	cmp    %eax,%edx
  800dd9:	75 09                	jne    800de4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800ddb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800de2:	eb 15                	jmp    800df9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800de4:	ff 45 e8             	incl   -0x18(%ebp)
  800de7:	a1 20 40 80 00       	mov    0x804020,%eax
  800dec:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800df2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800df5:	39 c2                	cmp    %eax,%edx
  800df7:	77 85                	ja     800d7e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800df9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800dfd:	75 14                	jne    800e13 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800dff:	83 ec 04             	sub    $0x4,%esp
  800e02:	68 1c 2c 80 00       	push   $0x802c1c
  800e07:	6a 3a                	push   $0x3a
  800e09:	68 10 2c 80 00       	push   $0x802c10
  800e0e:	e8 88 fe ff ff       	call   800c9b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e13:	ff 45 f0             	incl   -0x10(%ebp)
  800e16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e19:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e1c:	0f 8c 2f ff ff ff    	jl     800d51 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e29:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e30:	eb 26                	jmp    800e58 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e32:	a1 20 40 80 00       	mov    0x804020,%eax
  800e37:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800e3d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e40:	89 d0                	mov    %edx,%eax
  800e42:	01 c0                	add    %eax,%eax
  800e44:	01 d0                	add    %edx,%eax
  800e46:	c1 e0 03             	shl    $0x3,%eax
  800e49:	01 c8                	add    %ecx,%eax
  800e4b:	8a 40 04             	mov    0x4(%eax),%al
  800e4e:	3c 01                	cmp    $0x1,%al
  800e50:	75 03                	jne    800e55 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800e52:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e55:	ff 45 e0             	incl   -0x20(%ebp)
  800e58:	a1 20 40 80 00       	mov    0x804020,%eax
  800e5d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800e63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e66:	39 c2                	cmp    %eax,%edx
  800e68:	77 c8                	ja     800e32 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e6d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e70:	74 14                	je     800e86 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	68 70 2c 80 00       	push   $0x802c70
  800e7a:	6a 44                	push   $0x44
  800e7c:	68 10 2c 80 00       	push   $0x802c10
  800e81:	e8 15 fe ff ff       	call   800c9b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e86:	90                   	nop
  800e87:	c9                   	leave  
  800e88:	c3                   	ret    

00800e89 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800e89:	55                   	push   %ebp
  800e8a:	89 e5                	mov    %esp,%ebp
  800e8c:	53                   	push   %ebx
  800e8d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e93:	8b 00                	mov    (%eax),%eax
  800e95:	8d 48 01             	lea    0x1(%eax),%ecx
  800e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9b:	89 0a                	mov    %ecx,(%edx)
  800e9d:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea0:	88 d1                	mov    %dl,%cl
  800ea2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	8b 00                	mov    (%eax),%eax
  800eae:	3d ff 00 00 00       	cmp    $0xff,%eax
  800eb3:	75 30                	jne    800ee5 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800eb5:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800ebb:	a0 40 40 80 00       	mov    0x804040,%al
  800ec0:	0f b6 c0             	movzbl %al,%eax
  800ec3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800ec6:	8b 09                	mov    (%ecx),%ecx
  800ec8:	89 cb                	mov    %ecx,%ebx
  800eca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800ecd:	83 c1 08             	add    $0x8,%ecx
  800ed0:	52                   	push   %edx
  800ed1:	50                   	push   %eax
  800ed2:	53                   	push   %ebx
  800ed3:	51                   	push   %ecx
  800ed4:	e8 c8 10 00 00       	call   801fa1 <sys_cputs>
  800ed9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800edc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee8:	8b 40 04             	mov    0x4(%eax),%eax
  800eeb:	8d 50 01             	lea    0x1(%eax),%edx
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ef4:	90                   	nop
  800ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ef8:	c9                   	leave  
  800ef9:	c3                   	ret    

00800efa <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800efa:	55                   	push   %ebp
  800efb:	89 e5                	mov    %esp,%ebp
  800efd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f03:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f0a:	00 00 00 
	b.cnt = 0;
  800f0d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f14:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f17:	ff 75 0c             	pushl  0xc(%ebp)
  800f1a:	ff 75 08             	pushl  0x8(%ebp)
  800f1d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f23:	50                   	push   %eax
  800f24:	68 89 0e 80 00       	push   $0x800e89
  800f29:	e8 5a 02 00 00       	call   801188 <vprintfmt>
  800f2e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800f31:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800f37:	a0 40 40 80 00       	mov    0x804040,%al
  800f3c:	0f b6 c0             	movzbl %al,%eax
  800f3f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800f45:	52                   	push   %edx
  800f46:	50                   	push   %eax
  800f47:	51                   	push   %ecx
  800f48:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f4e:	83 c0 08             	add    $0x8,%eax
  800f51:	50                   	push   %eax
  800f52:	e8 4a 10 00 00       	call   801fa1 <sys_cputs>
  800f57:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f5a:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800f61:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f67:	c9                   	leave  
  800f68:	c3                   	ret    

00800f69 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800f69:	55                   	push   %ebp
  800f6a:	89 e5                	mov    %esp,%ebp
  800f6c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f6f:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800f76:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 f4             	pushl  -0xc(%ebp)
  800f85:	50                   	push   %eax
  800f86:	e8 6f ff ff ff       	call   800efa <vcprintf>
  800f8b:	83 c4 10             	add    $0x10,%esp
  800f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f94:	c9                   	leave  
  800f95:	c3                   	ret    

00800f96 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800f96:	55                   	push   %ebp
  800f97:	89 e5                	mov    %esp,%ebp
  800f99:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f9c:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	c1 e0 08             	shl    $0x8,%eax
  800fa9:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800fae:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fb1:	83 c0 04             	add    $0x4,%eax
  800fb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800fc0:	50                   	push   %eax
  800fc1:	e8 34 ff ff ff       	call   800efa <vcprintf>
  800fc6:	83 c4 10             	add    $0x10,%esp
  800fc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800fcc:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800fd3:	07 00 00 

	return cnt;
  800fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fd9:	c9                   	leave  
  800fda:	c3                   	ret    

00800fdb <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800fdb:	55                   	push   %ebp
  800fdc:	89 e5                	mov    %esp,%ebp
  800fde:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800fe1:	e8 ff 0f 00 00       	call   801fe5 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800fe6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fe9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	83 ec 08             	sub    $0x8,%esp
  800ff2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff5:	50                   	push   %eax
  800ff6:	e8 ff fe ff ff       	call   800efa <vcprintf>
  800ffb:	83 c4 10             	add    $0x10,%esp
  800ffe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  801001:	e8 f9 0f 00 00       	call   801fff <sys_unlock_cons>
	return cnt;
  801006:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	53                   	push   %ebx
  80100f:	83 ec 14             	sub    $0x14,%esp
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801018:	8b 45 14             	mov    0x14(%ebp),%eax
  80101b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80101e:	8b 45 18             	mov    0x18(%ebp),%eax
  801021:	ba 00 00 00 00       	mov    $0x0,%edx
  801026:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801029:	77 55                	ja     801080 <printnum+0x75>
  80102b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80102e:	72 05                	jb     801035 <printnum+0x2a>
  801030:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801033:	77 4b                	ja     801080 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801035:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801038:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80103b:	8b 45 18             	mov    0x18(%ebp),%eax
  80103e:	ba 00 00 00 00       	mov    $0x0,%edx
  801043:	52                   	push   %edx
  801044:	50                   	push   %eax
  801045:	ff 75 f4             	pushl  -0xc(%ebp)
  801048:	ff 75 f0             	pushl  -0x10(%ebp)
  80104b:	e8 8c 15 00 00       	call   8025dc <__udivdi3>
  801050:	83 c4 10             	add    $0x10,%esp
  801053:	83 ec 04             	sub    $0x4,%esp
  801056:	ff 75 20             	pushl  0x20(%ebp)
  801059:	53                   	push   %ebx
  80105a:	ff 75 18             	pushl  0x18(%ebp)
  80105d:	52                   	push   %edx
  80105e:	50                   	push   %eax
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	ff 75 08             	pushl  0x8(%ebp)
  801065:	e8 a1 ff ff ff       	call   80100b <printnum>
  80106a:	83 c4 20             	add    $0x20,%esp
  80106d:	eb 1a                	jmp    801089 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80106f:	83 ec 08             	sub    $0x8,%esp
  801072:	ff 75 0c             	pushl  0xc(%ebp)
  801075:	ff 75 20             	pushl  0x20(%ebp)
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	ff d0                	call   *%eax
  80107d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801080:	ff 4d 1c             	decl   0x1c(%ebp)
  801083:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801087:	7f e6                	jg     80106f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801089:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80108c:	bb 00 00 00 00       	mov    $0x0,%ebx
  801091:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801094:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801097:	53                   	push   %ebx
  801098:	51                   	push   %ecx
  801099:	52                   	push   %edx
  80109a:	50                   	push   %eax
  80109b:	e8 4c 16 00 00       	call   8026ec <__umoddi3>
  8010a0:	83 c4 10             	add    $0x10,%esp
  8010a3:	05 d4 2e 80 00       	add    $0x802ed4,%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	0f be c0             	movsbl %al,%eax
  8010ad:	83 ec 08             	sub    $0x8,%esp
  8010b0:	ff 75 0c             	pushl  0xc(%ebp)
  8010b3:	50                   	push   %eax
  8010b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b7:	ff d0                	call   *%eax
  8010b9:	83 c4 10             	add    $0x10,%esp
}
  8010bc:	90                   	nop
  8010bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010c0:	c9                   	leave  
  8010c1:	c3                   	ret    

008010c2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010c2:	55                   	push   %ebp
  8010c3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010c5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010c9:	7e 1c                	jle    8010e7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	8b 00                	mov    (%eax),%eax
  8010d0:	8d 50 08             	lea    0x8(%eax),%edx
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	89 10                	mov    %edx,(%eax)
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8b 00                	mov    (%eax),%eax
  8010dd:	83 e8 08             	sub    $0x8,%eax
  8010e0:	8b 50 04             	mov    0x4(%eax),%edx
  8010e3:	8b 00                	mov    (%eax),%eax
  8010e5:	eb 40                	jmp    801127 <getuint+0x65>
	else if (lflag)
  8010e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010eb:	74 1e                	je     80110b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8b 00                	mov    (%eax),%eax
  8010f2:	8d 50 04             	lea    0x4(%eax),%edx
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	89 10                	mov    %edx,(%eax)
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	8b 00                	mov    (%eax),%eax
  8010ff:	83 e8 04             	sub    $0x4,%eax
  801102:	8b 00                	mov    (%eax),%eax
  801104:	ba 00 00 00 00       	mov    $0x0,%edx
  801109:	eb 1c                	jmp    801127 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8b 00                	mov    (%eax),%eax
  801110:	8d 50 04             	lea    0x4(%eax),%edx
  801113:	8b 45 08             	mov    0x8(%ebp),%eax
  801116:	89 10                	mov    %edx,(%eax)
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	8b 00                	mov    (%eax),%eax
  80111d:	83 e8 04             	sub    $0x4,%eax
  801120:	8b 00                	mov    (%eax),%eax
  801122:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801127:	5d                   	pop    %ebp
  801128:	c3                   	ret    

00801129 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801129:	55                   	push   %ebp
  80112a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80112c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801130:	7e 1c                	jle    80114e <getint+0x25>
		return va_arg(*ap, long long);
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8b 00                	mov    (%eax),%eax
  801137:	8d 50 08             	lea    0x8(%eax),%edx
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
  80113d:	89 10                	mov    %edx,(%eax)
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8b 00                	mov    (%eax),%eax
  801144:	83 e8 08             	sub    $0x8,%eax
  801147:	8b 50 04             	mov    0x4(%eax),%edx
  80114a:	8b 00                	mov    (%eax),%eax
  80114c:	eb 38                	jmp    801186 <getint+0x5d>
	else if (lflag)
  80114e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801152:	74 1a                	je     80116e <getint+0x45>
		return va_arg(*ap, long);
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8b 00                	mov    (%eax),%eax
  801159:	8d 50 04             	lea    0x4(%eax),%edx
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	89 10                	mov    %edx,(%eax)
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8b 00                	mov    (%eax),%eax
  801166:	83 e8 04             	sub    $0x4,%eax
  801169:	8b 00                	mov    (%eax),%eax
  80116b:	99                   	cltd   
  80116c:	eb 18                	jmp    801186 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80116e:	8b 45 08             	mov    0x8(%ebp),%eax
  801171:	8b 00                	mov    (%eax),%eax
  801173:	8d 50 04             	lea    0x4(%eax),%edx
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	89 10                	mov    %edx,(%eax)
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	8b 00                	mov    (%eax),%eax
  801180:	83 e8 04             	sub    $0x4,%eax
  801183:	8b 00                	mov    (%eax),%eax
  801185:	99                   	cltd   
}
  801186:	5d                   	pop    %ebp
  801187:	c3                   	ret    

00801188 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	56                   	push   %esi
  80118c:	53                   	push   %ebx
  80118d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801190:	eb 17                	jmp    8011a9 <vprintfmt+0x21>
			if (ch == '\0')
  801192:	85 db                	test   %ebx,%ebx
  801194:	0f 84 c1 03 00 00    	je     80155b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80119a:	83 ec 08             	sub    $0x8,%esp
  80119d:	ff 75 0c             	pushl  0xc(%ebp)
  8011a0:	53                   	push   %ebx
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	ff d0                	call   *%eax
  8011a6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ac:	8d 50 01             	lea    0x1(%eax),%edx
  8011af:	89 55 10             	mov    %edx,0x10(%ebp)
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	0f b6 d8             	movzbl %al,%ebx
  8011b7:	83 fb 25             	cmp    $0x25,%ebx
  8011ba:	75 d6                	jne    801192 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011bc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011c0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011c7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8011d5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8011dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011df:	8d 50 01             	lea    0x1(%eax),%edx
  8011e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	0f b6 d8             	movzbl %al,%ebx
  8011ea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8011ed:	83 f8 5b             	cmp    $0x5b,%eax
  8011f0:	0f 87 3d 03 00 00    	ja     801533 <vprintfmt+0x3ab>
  8011f6:	8b 04 85 f8 2e 80 00 	mov    0x802ef8(,%eax,4),%eax
  8011fd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8011ff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801203:	eb d7                	jmp    8011dc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801205:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801209:	eb d1                	jmp    8011dc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80120b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801212:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801215:	89 d0                	mov    %edx,%eax
  801217:	c1 e0 02             	shl    $0x2,%eax
  80121a:	01 d0                	add    %edx,%eax
  80121c:	01 c0                	add    %eax,%eax
  80121e:	01 d8                	add    %ebx,%eax
  801220:	83 e8 30             	sub    $0x30,%eax
  801223:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801226:	8b 45 10             	mov    0x10(%ebp),%eax
  801229:	8a 00                	mov    (%eax),%al
  80122b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80122e:	83 fb 2f             	cmp    $0x2f,%ebx
  801231:	7e 3e                	jle    801271 <vprintfmt+0xe9>
  801233:	83 fb 39             	cmp    $0x39,%ebx
  801236:	7f 39                	jg     801271 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801238:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80123b:	eb d5                	jmp    801212 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80123d:	8b 45 14             	mov    0x14(%ebp),%eax
  801240:	83 c0 04             	add    $0x4,%eax
  801243:	89 45 14             	mov    %eax,0x14(%ebp)
  801246:	8b 45 14             	mov    0x14(%ebp),%eax
  801249:	83 e8 04             	sub    $0x4,%eax
  80124c:	8b 00                	mov    (%eax),%eax
  80124e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801251:	eb 1f                	jmp    801272 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801253:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801257:	79 83                	jns    8011dc <vprintfmt+0x54>
				width = 0;
  801259:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801260:	e9 77 ff ff ff       	jmp    8011dc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801265:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80126c:	e9 6b ff ff ff       	jmp    8011dc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801271:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801272:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801276:	0f 89 60 ff ff ff    	jns    8011dc <vprintfmt+0x54>
				width = precision, precision = -1;
  80127c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80127f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801282:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801289:	e9 4e ff ff ff       	jmp    8011dc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80128e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801291:	e9 46 ff ff ff       	jmp    8011dc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801296:	8b 45 14             	mov    0x14(%ebp),%eax
  801299:	83 c0 04             	add    $0x4,%eax
  80129c:	89 45 14             	mov    %eax,0x14(%ebp)
  80129f:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a2:	83 e8 04             	sub    $0x4,%eax
  8012a5:	8b 00                	mov    (%eax),%eax
  8012a7:	83 ec 08             	sub    $0x8,%esp
  8012aa:	ff 75 0c             	pushl  0xc(%ebp)
  8012ad:	50                   	push   %eax
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	ff d0                	call   *%eax
  8012b3:	83 c4 10             	add    $0x10,%esp
			break;
  8012b6:	e9 9b 02 00 00       	jmp    801556 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012be:	83 c0 04             	add    $0x4,%eax
  8012c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8012c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c7:	83 e8 04             	sub    $0x4,%eax
  8012ca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012cc:	85 db                	test   %ebx,%ebx
  8012ce:	79 02                	jns    8012d2 <vprintfmt+0x14a>
				err = -err;
  8012d0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8012d2:	83 fb 64             	cmp    $0x64,%ebx
  8012d5:	7f 0b                	jg     8012e2 <vprintfmt+0x15a>
  8012d7:	8b 34 9d 40 2d 80 00 	mov    0x802d40(,%ebx,4),%esi
  8012de:	85 f6                	test   %esi,%esi
  8012e0:	75 19                	jne    8012fb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8012e2:	53                   	push   %ebx
  8012e3:	68 e5 2e 80 00       	push   $0x802ee5
  8012e8:	ff 75 0c             	pushl  0xc(%ebp)
  8012eb:	ff 75 08             	pushl  0x8(%ebp)
  8012ee:	e8 70 02 00 00       	call   801563 <printfmt>
  8012f3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8012f6:	e9 5b 02 00 00       	jmp    801556 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8012fb:	56                   	push   %esi
  8012fc:	68 ee 2e 80 00       	push   $0x802eee
  801301:	ff 75 0c             	pushl  0xc(%ebp)
  801304:	ff 75 08             	pushl  0x8(%ebp)
  801307:	e8 57 02 00 00       	call   801563 <printfmt>
  80130c:	83 c4 10             	add    $0x10,%esp
			break;
  80130f:	e9 42 02 00 00       	jmp    801556 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801314:	8b 45 14             	mov    0x14(%ebp),%eax
  801317:	83 c0 04             	add    $0x4,%eax
  80131a:	89 45 14             	mov    %eax,0x14(%ebp)
  80131d:	8b 45 14             	mov    0x14(%ebp),%eax
  801320:	83 e8 04             	sub    $0x4,%eax
  801323:	8b 30                	mov    (%eax),%esi
  801325:	85 f6                	test   %esi,%esi
  801327:	75 05                	jne    80132e <vprintfmt+0x1a6>
				p = "(null)";
  801329:	be f1 2e 80 00       	mov    $0x802ef1,%esi
			if (width > 0 && padc != '-')
  80132e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801332:	7e 6d                	jle    8013a1 <vprintfmt+0x219>
  801334:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801338:	74 67                	je     8013a1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80133a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80133d:	83 ec 08             	sub    $0x8,%esp
  801340:	50                   	push   %eax
  801341:	56                   	push   %esi
  801342:	e8 1e 03 00 00       	call   801665 <strnlen>
  801347:	83 c4 10             	add    $0x10,%esp
  80134a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80134d:	eb 16                	jmp    801365 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80134f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801353:	83 ec 08             	sub    $0x8,%esp
  801356:	ff 75 0c             	pushl  0xc(%ebp)
  801359:	50                   	push   %eax
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	ff d0                	call   *%eax
  80135f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801362:	ff 4d e4             	decl   -0x1c(%ebp)
  801365:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801369:	7f e4                	jg     80134f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80136b:	eb 34                	jmp    8013a1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80136d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801371:	74 1c                	je     80138f <vprintfmt+0x207>
  801373:	83 fb 1f             	cmp    $0x1f,%ebx
  801376:	7e 05                	jle    80137d <vprintfmt+0x1f5>
  801378:	83 fb 7e             	cmp    $0x7e,%ebx
  80137b:	7e 12                	jle    80138f <vprintfmt+0x207>
					putch('?', putdat);
  80137d:	83 ec 08             	sub    $0x8,%esp
  801380:	ff 75 0c             	pushl  0xc(%ebp)
  801383:	6a 3f                	push   $0x3f
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	ff d0                	call   *%eax
  80138a:	83 c4 10             	add    $0x10,%esp
  80138d:	eb 0f                	jmp    80139e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80138f:	83 ec 08             	sub    $0x8,%esp
  801392:	ff 75 0c             	pushl  0xc(%ebp)
  801395:	53                   	push   %ebx
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	ff d0                	call   *%eax
  80139b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80139e:	ff 4d e4             	decl   -0x1c(%ebp)
  8013a1:	89 f0                	mov    %esi,%eax
  8013a3:	8d 70 01             	lea    0x1(%eax),%esi
  8013a6:	8a 00                	mov    (%eax),%al
  8013a8:	0f be d8             	movsbl %al,%ebx
  8013ab:	85 db                	test   %ebx,%ebx
  8013ad:	74 24                	je     8013d3 <vprintfmt+0x24b>
  8013af:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013b3:	78 b8                	js     80136d <vprintfmt+0x1e5>
  8013b5:	ff 4d e0             	decl   -0x20(%ebp)
  8013b8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013bc:	79 af                	jns    80136d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013be:	eb 13                	jmp    8013d3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8013c0:	83 ec 08             	sub    $0x8,%esp
  8013c3:	ff 75 0c             	pushl  0xc(%ebp)
  8013c6:	6a 20                	push   $0x20
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	ff d0                	call   *%eax
  8013cd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013d0:	ff 4d e4             	decl   -0x1c(%ebp)
  8013d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013d7:	7f e7                	jg     8013c0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8013d9:	e9 78 01 00 00       	jmp    801556 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8013de:	83 ec 08             	sub    $0x8,%esp
  8013e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8013e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8013e7:	50                   	push   %eax
  8013e8:	e8 3c fd ff ff       	call   801129 <getint>
  8013ed:	83 c4 10             	add    $0x10,%esp
  8013f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8013f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fc:	85 d2                	test   %edx,%edx
  8013fe:	79 23                	jns    801423 <vprintfmt+0x29b>
				putch('-', putdat);
  801400:	83 ec 08             	sub    $0x8,%esp
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	6a 2d                	push   $0x2d
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	ff d0                	call   *%eax
  80140d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801410:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801416:	f7 d8                	neg    %eax
  801418:	83 d2 00             	adc    $0x0,%edx
  80141b:	f7 da                	neg    %edx
  80141d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801420:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801423:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80142a:	e9 bc 00 00 00       	jmp    8014eb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80142f:	83 ec 08             	sub    $0x8,%esp
  801432:	ff 75 e8             	pushl  -0x18(%ebp)
  801435:	8d 45 14             	lea    0x14(%ebp),%eax
  801438:	50                   	push   %eax
  801439:	e8 84 fc ff ff       	call   8010c2 <getuint>
  80143e:	83 c4 10             	add    $0x10,%esp
  801441:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801444:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801447:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80144e:	e9 98 00 00 00       	jmp    8014eb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801453:	83 ec 08             	sub    $0x8,%esp
  801456:	ff 75 0c             	pushl  0xc(%ebp)
  801459:	6a 58                	push   $0x58
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	ff d0                	call   *%eax
  801460:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801463:	83 ec 08             	sub    $0x8,%esp
  801466:	ff 75 0c             	pushl  0xc(%ebp)
  801469:	6a 58                	push   $0x58
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	ff d0                	call   *%eax
  801470:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801473:	83 ec 08             	sub    $0x8,%esp
  801476:	ff 75 0c             	pushl  0xc(%ebp)
  801479:	6a 58                	push   $0x58
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	ff d0                	call   *%eax
  801480:	83 c4 10             	add    $0x10,%esp
			break;
  801483:	e9 ce 00 00 00       	jmp    801556 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801488:	83 ec 08             	sub    $0x8,%esp
  80148b:	ff 75 0c             	pushl  0xc(%ebp)
  80148e:	6a 30                	push   $0x30
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	ff d0                	call   *%eax
  801495:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801498:	83 ec 08             	sub    $0x8,%esp
  80149b:	ff 75 0c             	pushl  0xc(%ebp)
  80149e:	6a 78                	push   $0x78
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	ff d0                	call   *%eax
  8014a5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8014a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ab:	83 c0 04             	add    $0x4,%eax
  8014ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8014b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b4:	83 e8 04             	sub    $0x4,%eax
  8014b7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014c3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014ca:	eb 1f                	jmp    8014eb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014cc:	83 ec 08             	sub    $0x8,%esp
  8014cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8014d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8014d5:	50                   	push   %eax
  8014d6:	e8 e7 fb ff ff       	call   8010c2 <getuint>
  8014db:	83 c4 10             	add    $0x10,%esp
  8014de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8014e4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8014eb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8014ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014f2:	83 ec 04             	sub    $0x4,%esp
  8014f5:	52                   	push   %edx
  8014f6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014f9:	50                   	push   %eax
  8014fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8014fd:	ff 75 f0             	pushl  -0x10(%ebp)
  801500:	ff 75 0c             	pushl  0xc(%ebp)
  801503:	ff 75 08             	pushl  0x8(%ebp)
  801506:	e8 00 fb ff ff       	call   80100b <printnum>
  80150b:	83 c4 20             	add    $0x20,%esp
			break;
  80150e:	eb 46                	jmp    801556 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801510:	83 ec 08             	sub    $0x8,%esp
  801513:	ff 75 0c             	pushl  0xc(%ebp)
  801516:	53                   	push   %ebx
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	ff d0                	call   *%eax
  80151c:	83 c4 10             	add    $0x10,%esp
			break;
  80151f:	eb 35                	jmp    801556 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801521:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  801528:	eb 2c                	jmp    801556 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80152a:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801531:	eb 23                	jmp    801556 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801533:	83 ec 08             	sub    $0x8,%esp
  801536:	ff 75 0c             	pushl  0xc(%ebp)
  801539:	6a 25                	push   $0x25
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	ff d0                	call   *%eax
  801540:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801543:	ff 4d 10             	decl   0x10(%ebp)
  801546:	eb 03                	jmp    80154b <vprintfmt+0x3c3>
  801548:	ff 4d 10             	decl   0x10(%ebp)
  80154b:	8b 45 10             	mov    0x10(%ebp),%eax
  80154e:	48                   	dec    %eax
  80154f:	8a 00                	mov    (%eax),%al
  801551:	3c 25                	cmp    $0x25,%al
  801553:	75 f3                	jne    801548 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801555:	90                   	nop
		}
	}
  801556:	e9 35 fc ff ff       	jmp    801190 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80155b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80155c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80155f:	5b                   	pop    %ebx
  801560:	5e                   	pop    %esi
  801561:	5d                   	pop    %ebp
  801562:	c3                   	ret    

00801563 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
  801566:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801569:	8d 45 10             	lea    0x10(%ebp),%eax
  80156c:	83 c0 04             	add    $0x4,%eax
  80156f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801572:	8b 45 10             	mov    0x10(%ebp),%eax
  801575:	ff 75 f4             	pushl  -0xc(%ebp)
  801578:	50                   	push   %eax
  801579:	ff 75 0c             	pushl  0xc(%ebp)
  80157c:	ff 75 08             	pushl  0x8(%ebp)
  80157f:	e8 04 fc ff ff       	call   801188 <vprintfmt>
  801584:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801587:	90                   	nop
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80158d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801590:	8b 40 08             	mov    0x8(%eax),%eax
  801593:	8d 50 01             	lea    0x1(%eax),%edx
  801596:	8b 45 0c             	mov    0xc(%ebp),%eax
  801599:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	8b 10                	mov    (%eax),%edx
  8015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a4:	8b 40 04             	mov    0x4(%eax),%eax
  8015a7:	39 c2                	cmp    %eax,%edx
  8015a9:	73 12                	jae    8015bd <sprintputch+0x33>
		*b->buf++ = ch;
  8015ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ae:	8b 00                	mov    (%eax),%eax
  8015b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8015b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b6:	89 0a                	mov    %ecx,(%edx)
  8015b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8015bb:	88 10                	mov    %dl,(%eax)
}
  8015bd:	90                   	nop
  8015be:	5d                   	pop    %ebp
  8015bf:	c3                   	ret    

008015c0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
  8015c3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	01 d0                	add    %edx,%eax
  8015d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8015e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015e5:	74 06                	je     8015ed <vsnprintf+0x2d>
  8015e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015eb:	7f 07                	jg     8015f4 <vsnprintf+0x34>
		return -E_INVAL;
  8015ed:	b8 03 00 00 00       	mov    $0x3,%eax
  8015f2:	eb 20                	jmp    801614 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8015f4:	ff 75 14             	pushl  0x14(%ebp)
  8015f7:	ff 75 10             	pushl  0x10(%ebp)
  8015fa:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8015fd:	50                   	push   %eax
  8015fe:	68 8a 15 80 00       	push   $0x80158a
  801603:	e8 80 fb ff ff       	call   801188 <vprintfmt>
  801608:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80160b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80160e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801611:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801614:	c9                   	leave  
  801615:	c3                   	ret    

00801616 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801616:	55                   	push   %ebp
  801617:	89 e5                	mov    %esp,%ebp
  801619:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80161c:	8d 45 10             	lea    0x10(%ebp),%eax
  80161f:	83 c0 04             	add    $0x4,%eax
  801622:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801625:	8b 45 10             	mov    0x10(%ebp),%eax
  801628:	ff 75 f4             	pushl  -0xc(%ebp)
  80162b:	50                   	push   %eax
  80162c:	ff 75 0c             	pushl  0xc(%ebp)
  80162f:	ff 75 08             	pushl  0x8(%ebp)
  801632:	e8 89 ff ff ff       	call   8015c0 <vsnprintf>
  801637:	83 c4 10             	add    $0x10,%esp
  80163a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80163d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801648:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80164f:	eb 06                	jmp    801657 <strlen+0x15>
		n++;
  801651:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801654:	ff 45 08             	incl   0x8(%ebp)
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	84 c0                	test   %al,%al
  80165e:	75 f1                	jne    801651 <strlen+0xf>
		n++;
	return n;
  801660:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80166b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801672:	eb 09                	jmp    80167d <strnlen+0x18>
		n++;
  801674:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801677:	ff 45 08             	incl   0x8(%ebp)
  80167a:	ff 4d 0c             	decl   0xc(%ebp)
  80167d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801681:	74 09                	je     80168c <strnlen+0x27>
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	8a 00                	mov    (%eax),%al
  801688:	84 c0                	test   %al,%al
  80168a:	75 e8                	jne    801674 <strnlen+0xf>
		n++;
	return n;
  80168c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
  801694:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80169d:	90                   	nop
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8d 50 01             	lea    0x1(%eax),%edx
  8016a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016b0:	8a 12                	mov    (%edx),%dl
  8016b2:	88 10                	mov    %dl,(%eax)
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	84 c0                	test   %al,%al
  8016b8:	75 e4                	jne    80169e <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
  8016c2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016d2:	eb 1f                	jmp    8016f3 <strncpy+0x34>
		*dst++ = *src;
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8d 50 01             	lea    0x1(%eax),%edx
  8016da:	89 55 08             	mov    %edx,0x8(%ebp)
  8016dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e0:	8a 12                	mov    (%edx),%dl
  8016e2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e7:	8a 00                	mov    (%eax),%al
  8016e9:	84 c0                	test   %al,%al
  8016eb:	74 03                	je     8016f0 <strncpy+0x31>
			src++;
  8016ed:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016f0:	ff 45 fc             	incl   -0x4(%ebp)
  8016f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016f9:	72 d9                	jb     8016d4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016fe:	c9                   	leave  
  8016ff:	c3                   	ret    

00801700 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
  801703:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80170c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801710:	74 30                	je     801742 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801712:	eb 16                	jmp    80172a <strlcpy+0x2a>
			*dst++ = *src++;
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	8d 50 01             	lea    0x1(%eax),%edx
  80171a:	89 55 08             	mov    %edx,0x8(%ebp)
  80171d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801720:	8d 4a 01             	lea    0x1(%edx),%ecx
  801723:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801726:	8a 12                	mov    (%edx),%dl
  801728:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80172a:	ff 4d 10             	decl   0x10(%ebp)
  80172d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801731:	74 09                	je     80173c <strlcpy+0x3c>
  801733:	8b 45 0c             	mov    0xc(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	84 c0                	test   %al,%al
  80173a:	75 d8                	jne    801714 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801742:	8b 55 08             	mov    0x8(%ebp),%edx
  801745:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801748:	29 c2                	sub    %eax,%edx
  80174a:	89 d0                	mov    %edx,%eax
}
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801751:	eb 06                	jmp    801759 <strcmp+0xb>
		p++, q++;
  801753:	ff 45 08             	incl   0x8(%ebp)
  801756:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	8a 00                	mov    (%eax),%al
  80175e:	84 c0                	test   %al,%al
  801760:	74 0e                	je     801770 <strcmp+0x22>
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	8a 10                	mov    (%eax),%dl
  801767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176a:	8a 00                	mov    (%eax),%al
  80176c:	38 c2                	cmp    %al,%dl
  80176e:	74 e3                	je     801753 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	8a 00                	mov    (%eax),%al
  801775:	0f b6 d0             	movzbl %al,%edx
  801778:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177b:	8a 00                	mov    (%eax),%al
  80177d:	0f b6 c0             	movzbl %al,%eax
  801780:	29 c2                	sub    %eax,%edx
  801782:	89 d0                	mov    %edx,%eax
}
  801784:	5d                   	pop    %ebp
  801785:	c3                   	ret    

00801786 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801789:	eb 09                	jmp    801794 <strncmp+0xe>
		n--, p++, q++;
  80178b:	ff 4d 10             	decl   0x10(%ebp)
  80178e:	ff 45 08             	incl   0x8(%ebp)
  801791:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801794:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801798:	74 17                	je     8017b1 <strncmp+0x2b>
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	8a 00                	mov    (%eax),%al
  80179f:	84 c0                	test   %al,%al
  8017a1:	74 0e                	je     8017b1 <strncmp+0x2b>
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 10                	mov    (%eax),%dl
  8017a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ab:	8a 00                	mov    (%eax),%al
  8017ad:	38 c2                	cmp    %al,%dl
  8017af:	74 da                	je     80178b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8017b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b5:	75 07                	jne    8017be <strncmp+0x38>
		return 0;
  8017b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8017bc:	eb 14                	jmp    8017d2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	8a 00                	mov    (%eax),%al
  8017c3:	0f b6 d0             	movzbl %al,%edx
  8017c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c9:	8a 00                	mov    (%eax),%al
  8017cb:	0f b6 c0             	movzbl %al,%eax
  8017ce:	29 c2                	sub    %eax,%edx
  8017d0:	89 d0                	mov    %edx,%eax
}
  8017d2:	5d                   	pop    %ebp
  8017d3:	c3                   	ret    

008017d4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
  8017d7:	83 ec 04             	sub    $0x4,%esp
  8017da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017e0:	eb 12                	jmp    8017f4 <strchr+0x20>
		if (*s == c)
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	8a 00                	mov    (%eax),%al
  8017e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017ea:	75 05                	jne    8017f1 <strchr+0x1d>
			return (char *) s;
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	eb 11                	jmp    801802 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017f1:	ff 45 08             	incl   0x8(%ebp)
  8017f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f7:	8a 00                	mov    (%eax),%al
  8017f9:	84 c0                	test   %al,%al
  8017fb:	75 e5                	jne    8017e2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
  801807:	83 ec 04             	sub    $0x4,%esp
  80180a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801810:	eb 0d                	jmp    80181f <strfind+0x1b>
		if (*s == c)
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	8a 00                	mov    (%eax),%al
  801817:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80181a:	74 0e                	je     80182a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80181c:	ff 45 08             	incl   0x8(%ebp)
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	84 c0                	test   %al,%al
  801826:	75 ea                	jne    801812 <strfind+0xe>
  801828:	eb 01                	jmp    80182b <strfind+0x27>
		if (*s == c)
			break;
  80182a:	90                   	nop
	return (char *) s;
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80183c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801840:	76 63                	jbe    8018a5 <memset+0x75>
		uint64 data_block = c;
  801842:	8b 45 0c             	mov    0xc(%ebp),%eax
  801845:	99                   	cltd   
  801846:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801849:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80184c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80184f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801852:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801856:	c1 e0 08             	shl    $0x8,%eax
  801859:	09 45 f0             	or     %eax,-0x10(%ebp)
  80185c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80185f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801862:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801865:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801869:	c1 e0 10             	shl    $0x10,%eax
  80186c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80186f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801872:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801875:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801878:	89 c2                	mov    %eax,%edx
  80187a:	b8 00 00 00 00       	mov    $0x0,%eax
  80187f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801882:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801885:	eb 18                	jmp    80189f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801887:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80188a:	8d 41 08             	lea    0x8(%ecx),%eax
  80188d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801890:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801893:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801896:	89 01                	mov    %eax,(%ecx)
  801898:	89 51 04             	mov    %edx,0x4(%ecx)
  80189b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80189f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8018a3:	77 e2                	ja     801887 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8018a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018a9:	74 23                	je     8018ce <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8018ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018b1:	eb 0e                	jmp    8018c1 <memset+0x91>
			*p8++ = (uint8)c;
  8018b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018b6:	8d 50 01             	lea    0x1(%eax),%edx
  8018b9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bf:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8018c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8018ca:	85 c0                	test   %eax,%eax
  8018cc:	75 e5                	jne    8018b3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
  8018d6:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8018d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8018df:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8018e5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8018e9:	76 24                	jbe    80190f <memcpy+0x3c>
		while(n >= 8){
  8018eb:	eb 1c                	jmp    801909 <memcpy+0x36>
			*d64 = *s64;
  8018ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f0:	8b 50 04             	mov    0x4(%eax),%edx
  8018f3:	8b 00                	mov    (%eax),%eax
  8018f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018f8:	89 01                	mov    %eax,(%ecx)
  8018fa:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8018fd:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801901:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801905:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801909:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80190d:	77 de                	ja     8018ed <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80190f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801913:	74 31                	je     801946 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801915:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801918:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80191b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80191e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801921:	eb 16                	jmp    801939 <memcpy+0x66>
			*d8++ = *s8++;
  801923:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801926:	8d 50 01             	lea    0x1(%eax),%edx
  801929:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80192c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80192f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801932:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801935:	8a 12                	mov    (%edx),%dl
  801937:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801939:	8b 45 10             	mov    0x10(%ebp),%eax
  80193c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80193f:	89 55 10             	mov    %edx,0x10(%ebp)
  801942:	85 c0                	test   %eax,%eax
  801944:	75 dd                	jne    801923 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
  80194e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801951:	8b 45 0c             	mov    0xc(%ebp),%eax
  801954:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80195d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801960:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801963:	73 50                	jae    8019b5 <memmove+0x6a>
  801965:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801968:	8b 45 10             	mov    0x10(%ebp),%eax
  80196b:	01 d0                	add    %edx,%eax
  80196d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801970:	76 43                	jbe    8019b5 <memmove+0x6a>
		s += n;
  801972:	8b 45 10             	mov    0x10(%ebp),%eax
  801975:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801978:	8b 45 10             	mov    0x10(%ebp),%eax
  80197b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80197e:	eb 10                	jmp    801990 <memmove+0x45>
			*--d = *--s;
  801980:	ff 4d f8             	decl   -0x8(%ebp)
  801983:	ff 4d fc             	decl   -0x4(%ebp)
  801986:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801989:	8a 10                	mov    (%eax),%dl
  80198b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80198e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801990:	8b 45 10             	mov    0x10(%ebp),%eax
  801993:	8d 50 ff             	lea    -0x1(%eax),%edx
  801996:	89 55 10             	mov    %edx,0x10(%ebp)
  801999:	85 c0                	test   %eax,%eax
  80199b:	75 e3                	jne    801980 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80199d:	eb 23                	jmp    8019c2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80199f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a2:	8d 50 01             	lea    0x1(%eax),%edx
  8019a5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8019ae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8019b1:	8a 12                	mov    (%edx),%dl
  8019b3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8019b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8019bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8019be:	85 c0                	test   %eax,%eax
  8019c0:	75 dd                	jne    80199f <memmove+0x54>
			*d++ = *s++;

	return dst;
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
  8019ca:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8019d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8019d9:	eb 2a                	jmp    801a05 <memcmp+0x3e>
		if (*s1 != *s2)
  8019db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019de:	8a 10                	mov    (%eax),%dl
  8019e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019e3:	8a 00                	mov    (%eax),%al
  8019e5:	38 c2                	cmp    %al,%dl
  8019e7:	74 16                	je     8019ff <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8019e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ec:	8a 00                	mov    (%eax),%al
  8019ee:	0f b6 d0             	movzbl %al,%edx
  8019f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f4:	8a 00                	mov    (%eax),%al
  8019f6:	0f b6 c0             	movzbl %al,%eax
  8019f9:	29 c2                	sub    %eax,%edx
  8019fb:	89 d0                	mov    %edx,%eax
  8019fd:	eb 18                	jmp    801a17 <memcmp+0x50>
		s1++, s2++;
  8019ff:	ff 45 fc             	incl   -0x4(%ebp)
  801a02:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801a05:	8b 45 10             	mov    0x10(%ebp),%eax
  801a08:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a0b:	89 55 10             	mov    %edx,0x10(%ebp)
  801a0e:	85 c0                	test   %eax,%eax
  801a10:	75 c9                	jne    8019db <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801a12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
  801a1c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801a1f:	8b 55 08             	mov    0x8(%ebp),%edx
  801a22:	8b 45 10             	mov    0x10(%ebp),%eax
  801a25:	01 d0                	add    %edx,%eax
  801a27:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801a2a:	eb 15                	jmp    801a41 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2f:	8a 00                	mov    (%eax),%al
  801a31:	0f b6 d0             	movzbl %al,%edx
  801a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a37:	0f b6 c0             	movzbl %al,%eax
  801a3a:	39 c2                	cmp    %eax,%edx
  801a3c:	74 0d                	je     801a4b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801a3e:	ff 45 08             	incl   0x8(%ebp)
  801a41:	8b 45 08             	mov    0x8(%ebp),%eax
  801a44:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801a47:	72 e3                	jb     801a2c <memfind+0x13>
  801a49:	eb 01                	jmp    801a4c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801a4b:	90                   	nop
	return (void *) s;
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
  801a54:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801a57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801a5e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a65:	eb 03                	jmp    801a6a <strtol+0x19>
		s++;
  801a67:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	8a 00                	mov    (%eax),%al
  801a6f:	3c 20                	cmp    $0x20,%al
  801a71:	74 f4                	je     801a67 <strtol+0x16>
  801a73:	8b 45 08             	mov    0x8(%ebp),%eax
  801a76:	8a 00                	mov    (%eax),%al
  801a78:	3c 09                	cmp    $0x9,%al
  801a7a:	74 eb                	je     801a67 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7f:	8a 00                	mov    (%eax),%al
  801a81:	3c 2b                	cmp    $0x2b,%al
  801a83:	75 05                	jne    801a8a <strtol+0x39>
		s++;
  801a85:	ff 45 08             	incl   0x8(%ebp)
  801a88:	eb 13                	jmp    801a9d <strtol+0x4c>
	else if (*s == '-')
  801a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8d:	8a 00                	mov    (%eax),%al
  801a8f:	3c 2d                	cmp    $0x2d,%al
  801a91:	75 0a                	jne    801a9d <strtol+0x4c>
		s++, neg = 1;
  801a93:	ff 45 08             	incl   0x8(%ebp)
  801a96:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801a9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801aa1:	74 06                	je     801aa9 <strtol+0x58>
  801aa3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801aa7:	75 20                	jne    801ac9 <strtol+0x78>
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	8a 00                	mov    (%eax),%al
  801aae:	3c 30                	cmp    $0x30,%al
  801ab0:	75 17                	jne    801ac9 <strtol+0x78>
  801ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab5:	40                   	inc    %eax
  801ab6:	8a 00                	mov    (%eax),%al
  801ab8:	3c 78                	cmp    $0x78,%al
  801aba:	75 0d                	jne    801ac9 <strtol+0x78>
		s += 2, base = 16;
  801abc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801ac0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801ac7:	eb 28                	jmp    801af1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801ac9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801acd:	75 15                	jne    801ae4 <strtol+0x93>
  801acf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad2:	8a 00                	mov    (%eax),%al
  801ad4:	3c 30                	cmp    $0x30,%al
  801ad6:	75 0c                	jne    801ae4 <strtol+0x93>
		s++, base = 8;
  801ad8:	ff 45 08             	incl   0x8(%ebp)
  801adb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801ae2:	eb 0d                	jmp    801af1 <strtol+0xa0>
	else if (base == 0)
  801ae4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ae8:	75 07                	jne    801af1 <strtol+0xa0>
		base = 10;
  801aea:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801af1:	8b 45 08             	mov    0x8(%ebp),%eax
  801af4:	8a 00                	mov    (%eax),%al
  801af6:	3c 2f                	cmp    $0x2f,%al
  801af8:	7e 19                	jle    801b13 <strtol+0xc2>
  801afa:	8b 45 08             	mov    0x8(%ebp),%eax
  801afd:	8a 00                	mov    (%eax),%al
  801aff:	3c 39                	cmp    $0x39,%al
  801b01:	7f 10                	jg     801b13 <strtol+0xc2>
			dig = *s - '0';
  801b03:	8b 45 08             	mov    0x8(%ebp),%eax
  801b06:	8a 00                	mov    (%eax),%al
  801b08:	0f be c0             	movsbl %al,%eax
  801b0b:	83 e8 30             	sub    $0x30,%eax
  801b0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b11:	eb 42                	jmp    801b55 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	8a 00                	mov    (%eax),%al
  801b18:	3c 60                	cmp    $0x60,%al
  801b1a:	7e 19                	jle    801b35 <strtol+0xe4>
  801b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1f:	8a 00                	mov    (%eax),%al
  801b21:	3c 7a                	cmp    $0x7a,%al
  801b23:	7f 10                	jg     801b35 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	8a 00                	mov    (%eax),%al
  801b2a:	0f be c0             	movsbl %al,%eax
  801b2d:	83 e8 57             	sub    $0x57,%eax
  801b30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b33:	eb 20                	jmp    801b55 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801b35:	8b 45 08             	mov    0x8(%ebp),%eax
  801b38:	8a 00                	mov    (%eax),%al
  801b3a:	3c 40                	cmp    $0x40,%al
  801b3c:	7e 39                	jle    801b77 <strtol+0x126>
  801b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b41:	8a 00                	mov    (%eax),%al
  801b43:	3c 5a                	cmp    $0x5a,%al
  801b45:	7f 30                	jg     801b77 <strtol+0x126>
			dig = *s - 'A' + 10;
  801b47:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4a:	8a 00                	mov    (%eax),%al
  801b4c:	0f be c0             	movsbl %al,%eax
  801b4f:	83 e8 37             	sub    $0x37,%eax
  801b52:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b58:	3b 45 10             	cmp    0x10(%ebp),%eax
  801b5b:	7d 19                	jge    801b76 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801b5d:	ff 45 08             	incl   0x8(%ebp)
  801b60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b63:	0f af 45 10          	imul   0x10(%ebp),%eax
  801b67:	89 c2                	mov    %eax,%edx
  801b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6c:	01 d0                	add    %edx,%eax
  801b6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801b71:	e9 7b ff ff ff       	jmp    801af1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801b76:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801b77:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b7b:	74 08                	je     801b85 <strtol+0x134>
		*endptr = (char *) s;
  801b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b80:	8b 55 08             	mov    0x8(%ebp),%edx
  801b83:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801b85:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b89:	74 07                	je     801b92 <strtol+0x141>
  801b8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b8e:	f7 d8                	neg    %eax
  801b90:	eb 03                	jmp    801b95 <strtol+0x144>
  801b92:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <ltostr>:

void
ltostr(long value, char *str)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
  801b9a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801b9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801ba4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801bab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801baf:	79 13                	jns    801bc4 <ltostr+0x2d>
	{
		neg = 1;
  801bb1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bbb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801bbe:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801bc1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801bcc:	99                   	cltd   
  801bcd:	f7 f9                	idiv   %ecx
  801bcf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801bd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bd5:	8d 50 01             	lea    0x1(%eax),%edx
  801bd8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801bdb:	89 c2                	mov    %eax,%edx
  801bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be0:	01 d0                	add    %edx,%eax
  801be2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801be5:	83 c2 30             	add    $0x30,%edx
  801be8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801bea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801bed:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801bf2:	f7 e9                	imul   %ecx
  801bf4:	c1 fa 02             	sar    $0x2,%edx
  801bf7:	89 c8                	mov    %ecx,%eax
  801bf9:	c1 f8 1f             	sar    $0x1f,%eax
  801bfc:	29 c2                	sub    %eax,%edx
  801bfe:	89 d0                	mov    %edx,%eax
  801c00:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801c03:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c07:	75 bb                	jne    801bc4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801c09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801c10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c13:	48                   	dec    %eax
  801c14:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801c17:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801c1b:	74 3d                	je     801c5a <ltostr+0xc3>
		start = 1 ;
  801c1d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801c24:	eb 34                	jmp    801c5a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801c26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c29:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c2c:	01 d0                	add    %edx,%eax
  801c2e:	8a 00                	mov    (%eax),%al
  801c30:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801c33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c39:	01 c2                	add    %eax,%edx
  801c3b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801c3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c41:	01 c8                	add    %ecx,%eax
  801c43:	8a 00                	mov    (%eax),%al
  801c45:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801c47:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c4d:	01 c2                	add    %eax,%edx
  801c4f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801c52:	88 02                	mov    %al,(%edx)
		start++ ;
  801c54:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801c57:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c5d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c60:	7c c4                	jl     801c26 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801c62:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801c65:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c68:	01 d0                	add    %edx,%eax
  801c6a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801c6d:	90                   	nop
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
  801c73:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801c76:	ff 75 08             	pushl  0x8(%ebp)
  801c79:	e8 c4 f9 ff ff       	call   801642 <strlen>
  801c7e:	83 c4 04             	add    $0x4,%esp
  801c81:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801c84:	ff 75 0c             	pushl  0xc(%ebp)
  801c87:	e8 b6 f9 ff ff       	call   801642 <strlen>
  801c8c:	83 c4 04             	add    $0x4,%esp
  801c8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ca0:	eb 17                	jmp    801cb9 <strcconcat+0x49>
		final[s] = str1[s] ;
  801ca2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ca5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca8:	01 c2                	add    %eax,%edx
  801caa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801cad:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb0:	01 c8                	add    %ecx,%eax
  801cb2:	8a 00                	mov    (%eax),%al
  801cb4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801cb6:	ff 45 fc             	incl   -0x4(%ebp)
  801cb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801cbf:	7c e1                	jl     801ca2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801cc1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801cc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ccf:	eb 1f                	jmp    801cf0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cd4:	8d 50 01             	lea    0x1(%eax),%edx
  801cd7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801cda:	89 c2                	mov    %eax,%edx
  801cdc:	8b 45 10             	mov    0x10(%ebp),%eax
  801cdf:	01 c2                	add    %eax,%edx
  801ce1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ce7:	01 c8                	add    %ecx,%eax
  801ce9:	8a 00                	mov    (%eax),%al
  801ceb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ced:	ff 45 f8             	incl   -0x8(%ebp)
  801cf0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cf3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801cf6:	7c d9                	jl     801cd1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801cf8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cfb:	8b 45 10             	mov    0x10(%ebp),%eax
  801cfe:	01 d0                	add    %edx,%eax
  801d00:	c6 00 00             	movb   $0x0,(%eax)
}
  801d03:	90                   	nop
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801d09:	8b 45 14             	mov    0x14(%ebp),%eax
  801d0c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801d12:	8b 45 14             	mov    0x14(%ebp),%eax
  801d15:	8b 00                	mov    (%eax),%eax
  801d17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d1e:	8b 45 10             	mov    0x10(%ebp),%eax
  801d21:	01 d0                	add    %edx,%eax
  801d23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801d29:	eb 0c                	jmp    801d37 <strsplit+0x31>
			*string++ = 0;
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	8d 50 01             	lea    0x1(%eax),%edx
  801d31:	89 55 08             	mov    %edx,0x8(%ebp)
  801d34:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801d37:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3a:	8a 00                	mov    (%eax),%al
  801d3c:	84 c0                	test   %al,%al
  801d3e:	74 18                	je     801d58 <strsplit+0x52>
  801d40:	8b 45 08             	mov    0x8(%ebp),%eax
  801d43:	8a 00                	mov    (%eax),%al
  801d45:	0f be c0             	movsbl %al,%eax
  801d48:	50                   	push   %eax
  801d49:	ff 75 0c             	pushl  0xc(%ebp)
  801d4c:	e8 83 fa ff ff       	call   8017d4 <strchr>
  801d51:	83 c4 08             	add    $0x8,%esp
  801d54:	85 c0                	test   %eax,%eax
  801d56:	75 d3                	jne    801d2b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	8a 00                	mov    (%eax),%al
  801d5d:	84 c0                	test   %al,%al
  801d5f:	74 5a                	je     801dbb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801d61:	8b 45 14             	mov    0x14(%ebp),%eax
  801d64:	8b 00                	mov    (%eax),%eax
  801d66:	83 f8 0f             	cmp    $0xf,%eax
  801d69:	75 07                	jne    801d72 <strsplit+0x6c>
		{
			return 0;
  801d6b:	b8 00 00 00 00       	mov    $0x0,%eax
  801d70:	eb 66                	jmp    801dd8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801d72:	8b 45 14             	mov    0x14(%ebp),%eax
  801d75:	8b 00                	mov    (%eax),%eax
  801d77:	8d 48 01             	lea    0x1(%eax),%ecx
  801d7a:	8b 55 14             	mov    0x14(%ebp),%edx
  801d7d:	89 0a                	mov    %ecx,(%edx)
  801d7f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d86:	8b 45 10             	mov    0x10(%ebp),%eax
  801d89:	01 c2                	add    %eax,%edx
  801d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d90:	eb 03                	jmp    801d95 <strsplit+0x8f>
			string++;
  801d92:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d95:	8b 45 08             	mov    0x8(%ebp),%eax
  801d98:	8a 00                	mov    (%eax),%al
  801d9a:	84 c0                	test   %al,%al
  801d9c:	74 8b                	je     801d29 <strsplit+0x23>
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	8a 00                	mov    (%eax),%al
  801da3:	0f be c0             	movsbl %al,%eax
  801da6:	50                   	push   %eax
  801da7:	ff 75 0c             	pushl  0xc(%ebp)
  801daa:	e8 25 fa ff ff       	call   8017d4 <strchr>
  801daf:	83 c4 08             	add    $0x8,%esp
  801db2:	85 c0                	test   %eax,%eax
  801db4:	74 dc                	je     801d92 <strsplit+0x8c>
			string++;
	}
  801db6:	e9 6e ff ff ff       	jmp    801d29 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801dbb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801dbc:	8b 45 14             	mov    0x14(%ebp),%eax
  801dbf:	8b 00                	mov    (%eax),%eax
  801dc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dc8:	8b 45 10             	mov    0x10(%ebp),%eax
  801dcb:	01 d0                	add    %edx,%eax
  801dcd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801dd3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801dd8:	c9                   	leave  
  801dd9:	c3                   	ret    

00801dda <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
  801ddd:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801de0:	8b 45 08             	mov    0x8(%ebp),%eax
  801de3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801de6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ded:	eb 4a                	jmp    801e39 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801def:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801df2:	8b 45 08             	mov    0x8(%ebp),%eax
  801df5:	01 c2                	add    %eax,%edx
  801df7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801dfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dfd:	01 c8                	add    %ecx,%eax
  801dff:	8a 00                	mov    (%eax),%al
  801e01:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e09:	01 d0                	add    %edx,%eax
  801e0b:	8a 00                	mov    (%eax),%al
  801e0d:	3c 40                	cmp    $0x40,%al
  801e0f:	7e 25                	jle    801e36 <str2lower+0x5c>
  801e11:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e17:	01 d0                	add    %edx,%eax
  801e19:	8a 00                	mov    (%eax),%al
  801e1b:	3c 5a                	cmp    $0x5a,%al
  801e1d:	7f 17                	jg     801e36 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801e1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e22:	8b 45 08             	mov    0x8(%ebp),%eax
  801e25:	01 d0                	add    %edx,%eax
  801e27:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e2a:	8b 55 08             	mov    0x8(%ebp),%edx
  801e2d:	01 ca                	add    %ecx,%edx
  801e2f:	8a 12                	mov    (%edx),%dl
  801e31:	83 c2 20             	add    $0x20,%edx
  801e34:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801e36:	ff 45 fc             	incl   -0x4(%ebp)
  801e39:	ff 75 0c             	pushl  0xc(%ebp)
  801e3c:	e8 01 f8 ff ff       	call   801642 <strlen>
  801e41:	83 c4 04             	add    $0x4,%esp
  801e44:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801e47:	7f a6                	jg     801def <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801e4c:	c9                   	leave  
  801e4d:	c3                   	ret    

00801e4e <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
  801e51:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801e54:	a1 08 40 80 00       	mov    0x804008,%eax
  801e59:	85 c0                	test   %eax,%eax
  801e5b:	74 2d                	je     801e8a <uheap_init+0x3c>
	{
		buddy_init();
  801e5d:	e8 87 06 00 00       	call   8024e9 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801e62:	e8 31 05 00 00       	call   802398 <sys_get_uheap_strategy>
  801e67:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801e6c:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801e73:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801e76:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801e7d:	00 00 80 
		__firstTimeFlag = 0;
  801e80:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801e87:	00 00 00 
	}
}
  801e8a:	90                   	nop
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
  801e90:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801e93:	83 ec 04             	sub    $0x4,%esp
  801e96:	68 68 30 80 00       	push   $0x803068
  801e9b:	6a 25                	push   $0x25
  801e9d:	68 99 30 80 00       	push   $0x803099
  801ea2:	e8 f4 ed ff ff       	call   800c9b <_panic>

00801ea7 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801ea7:	55                   	push   %ebp
  801ea8:	89 e5                	mov    %esp,%ebp
  801eaa:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801ead:	83 ec 04             	sub    $0x4,%esp
  801eb0:	68 a8 30 80 00       	push   $0x8030a8
  801eb5:	6a 2f                	push   $0x2f
  801eb7:	68 99 30 80 00       	push   $0x803099
  801ebc:	e8 da ed ff ff       	call   800c9b <_panic>

00801ec1 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
  801ec4:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ec7:	e8 82 ff ff ff       	call   801e4e <uheap_init>
	if (size == 0) return NULL ;
  801ecc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ed0:	75 07                	jne    801ed9 <malloc+0x18>
  801ed2:	b8 00 00 00 00       	mov    $0x0,%eax
  801ed7:	eb 14                	jmp    801eed <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801ed9:	83 ec 04             	sub    $0x4,%esp
  801edc:	68 dc 30 80 00       	push   $0x8030dc
  801ee1:	6a 43                	push   $0x43
  801ee3:	68 99 30 80 00       	push   $0x803099
  801ee8:	e8 ae ed ff ff       	call   800c9b <_panic>
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
  801ef2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801ef5:	83 ec 04             	sub    $0x4,%esp
  801ef8:	68 04 31 80 00       	push   $0x803104
  801efd:	6a 4e                	push   $0x4e
  801eff:	68 99 30 80 00       	push   $0x803099
  801f04:	e8 92 ed ff ff       	call   800c9b <_panic>

00801f09 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
  801f0c:	83 ec 18             	sub    $0x18,%esp
  801f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f12:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801f15:	e8 34 ff ff ff       	call   801e4e <uheap_init>
	if (size == 0) return NULL ;
  801f1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801f1e:	75 07                	jne    801f27 <smalloc+0x1e>
  801f20:	b8 00 00 00 00       	mov    $0x0,%eax
  801f25:	eb 14                	jmp    801f3b <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801f27:	83 ec 04             	sub    $0x4,%esp
  801f2a:	68 28 31 80 00       	push   $0x803128
  801f2f:	6a 5f                	push   $0x5f
  801f31:	68 99 30 80 00       	push   $0x803099
  801f36:	e8 60 ed ff ff       	call   800c9b <_panic>
}
  801f3b:	c9                   	leave  
  801f3c:	c3                   	ret    

00801f3d <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f3d:	55                   	push   %ebp
  801f3e:	89 e5                	mov    %esp,%ebp
  801f40:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801f43:	e8 06 ff ff ff       	call   801e4e <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801f48:	83 ec 04             	sub    $0x4,%esp
  801f4b:	68 50 31 80 00       	push   $0x803150
  801f50:	6a 6f                	push   $0x6f
  801f52:	68 99 30 80 00       	push   $0x803099
  801f57:	e8 3f ed ff ff       	call   800c9b <_panic>

00801f5c <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801f5c:	55                   	push   %ebp
  801f5d:	89 e5                	mov    %esp,%ebp
  801f5f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801f62:	83 ec 04             	sub    $0x4,%esp
  801f65:	68 74 31 80 00       	push   $0x803174
  801f6a:	6a 7e                	push   $0x7e
  801f6c:	68 99 30 80 00       	push   $0x803099
  801f71:	e8 25 ed ff ff       	call   800c9b <_panic>

00801f76 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
  801f79:	57                   	push   %edi
  801f7a:	56                   	push   %esi
  801f7b:	53                   	push   %ebx
  801f7c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f85:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f88:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f8b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f8e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f91:	cd 30                	int    $0x30
  801f93:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f99:	83 c4 10             	add    $0x10,%esp
  801f9c:	5b                   	pop    %ebx
  801f9d:	5e                   	pop    %esi
  801f9e:	5f                   	pop    %edi
  801f9f:	5d                   	pop    %ebp
  801fa0:	c3                   	ret    

00801fa1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
  801fa4:	83 ec 04             	sub    $0x4,%esp
  801fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  801faa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801fad:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fb0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb7:	6a 00                	push   $0x0
  801fb9:	51                   	push   %ecx
  801fba:	52                   	push   %edx
  801fbb:	ff 75 0c             	pushl  0xc(%ebp)
  801fbe:	50                   	push   %eax
  801fbf:	6a 00                	push   $0x0
  801fc1:	e8 b0 ff ff ff       	call   801f76 <syscall>
  801fc6:	83 c4 18             	add    $0x18,%esp
}
  801fc9:	90                   	nop
  801fca:	c9                   	leave  
  801fcb:	c3                   	ret    

00801fcc <sys_cgetc>:

int
sys_cgetc(void)
{
  801fcc:	55                   	push   %ebp
  801fcd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 02                	push   $0x2
  801fdb:	e8 96 ff ff ff       	call   801f76 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	c9                   	leave  
  801fe4:	c3                   	ret    

00801fe5 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 03                	push   $0x3
  801ff4:	e8 7d ff ff ff       	call   801f76 <syscall>
  801ff9:	83 c4 18             	add    $0x18,%esp
}
  801ffc:	90                   	nop
  801ffd:	c9                   	leave  
  801ffe:	c3                   	ret    

00801fff <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801fff:	55                   	push   %ebp
  802000:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 04                	push   $0x4
  80200e:	e8 63 ff ff ff       	call   801f76 <syscall>
  802013:	83 c4 18             	add    $0x18,%esp
}
  802016:	90                   	nop
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80201c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	52                   	push   %edx
  802029:	50                   	push   %eax
  80202a:	6a 08                	push   $0x8
  80202c:	e8 45 ff ff ff       	call   801f76 <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
  802039:	56                   	push   %esi
  80203a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80203b:	8b 75 18             	mov    0x18(%ebp),%esi
  80203e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802041:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802044:	8b 55 0c             	mov    0xc(%ebp),%edx
  802047:	8b 45 08             	mov    0x8(%ebp),%eax
  80204a:	56                   	push   %esi
  80204b:	53                   	push   %ebx
  80204c:	51                   	push   %ecx
  80204d:	52                   	push   %edx
  80204e:	50                   	push   %eax
  80204f:	6a 09                	push   $0x9
  802051:	e8 20 ff ff ff       	call   801f76 <syscall>
  802056:	83 c4 18             	add    $0x18,%esp
}
  802059:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80205c:	5b                   	pop    %ebx
  80205d:	5e                   	pop    %esi
  80205e:	5d                   	pop    %ebp
  80205f:	c3                   	ret    

00802060 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	ff 75 08             	pushl  0x8(%ebp)
  80206e:	6a 0a                	push   $0xa
  802070:	e8 01 ff ff ff       	call   801f76 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
}
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	ff 75 0c             	pushl  0xc(%ebp)
  802086:	ff 75 08             	pushl  0x8(%ebp)
  802089:	6a 0b                	push   $0xb
  80208b:	e8 e6 fe ff ff       	call   801f76 <syscall>
  802090:	83 c4 18             	add    $0x18,%esp
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 0c                	push   $0xc
  8020a4:	e8 cd fe ff ff       	call   801f76 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 0d                	push   $0xd
  8020bd:	e8 b4 fe ff ff       	call   801f76 <syscall>
  8020c2:	83 c4 18             	add    $0x18,%esp
}
  8020c5:	c9                   	leave  
  8020c6:	c3                   	ret    

008020c7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020c7:	55                   	push   %ebp
  8020c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 0e                	push   $0xe
  8020d6:	e8 9b fe ff ff       	call   801f76 <syscall>
  8020db:	83 c4 18             	add    $0x18,%esp
}
  8020de:	c9                   	leave  
  8020df:	c3                   	ret    

008020e0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8020e0:	55                   	push   %ebp
  8020e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 0f                	push   $0xf
  8020ef:	e8 82 fe ff ff       	call   801f76 <syscall>
  8020f4:	83 c4 18             	add    $0x18,%esp
}
  8020f7:	c9                   	leave  
  8020f8:	c3                   	ret    

008020f9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020f9:	55                   	push   %ebp
  8020fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	ff 75 08             	pushl  0x8(%ebp)
  802107:	6a 10                	push   $0x10
  802109:	e8 68 fe ff ff       	call   801f76 <syscall>
  80210e:	83 c4 18             	add    $0x18,%esp
}
  802111:	c9                   	leave  
  802112:	c3                   	ret    

00802113 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802113:	55                   	push   %ebp
  802114:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 11                	push   $0x11
  802122:	e8 4f fe ff ff       	call   801f76 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
}
  80212a:	90                   	nop
  80212b:	c9                   	leave  
  80212c:	c3                   	ret    

0080212d <sys_cputc>:

void
sys_cputc(const char c)
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
  802130:	83 ec 04             	sub    $0x4,%esp
  802133:	8b 45 08             	mov    0x8(%ebp),%eax
  802136:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802139:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	50                   	push   %eax
  802146:	6a 01                	push   $0x1
  802148:	e8 29 fe ff ff       	call   801f76 <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
}
  802150:	90                   	nop
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 14                	push   $0x14
  802162:	e8 0f fe ff ff       	call   801f76 <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
}
  80216a:	90                   	nop
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
  802170:	83 ec 04             	sub    $0x4,%esp
  802173:	8b 45 10             	mov    0x10(%ebp),%eax
  802176:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  802179:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80217c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802180:	8b 45 08             	mov    0x8(%ebp),%eax
  802183:	6a 00                	push   $0x0
  802185:	51                   	push   %ecx
  802186:	52                   	push   %edx
  802187:	ff 75 0c             	pushl  0xc(%ebp)
  80218a:	50                   	push   %eax
  80218b:	6a 15                	push   $0x15
  80218d:	e8 e4 fd ff ff       	call   801f76 <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80219a:	8b 55 10             	mov    0x10(%ebp),%edx
  80219d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	52                   	push   %edx
  8021a5:	50                   	push   %eax
  8021a6:	ff 75 08             	pushl  0x8(%ebp)
  8021a9:	6a 16                	push   $0x16
  8021ab:	e8 c6 fd ff ff       	call   801f76 <syscall>
  8021b0:	83 c4 18             	add    $0x18,%esp
}
  8021b3:	c9                   	leave  
  8021b4:	c3                   	ret    

008021b5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8021b5:	55                   	push   %ebp
  8021b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8021b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	52                   	push   %edx
  8021c5:	50                   	push   %eax
  8021c6:	6a 17                	push   $0x17
  8021c8:	e8 a9 fd ff ff       	call   801f76 <syscall>
  8021cd:	83 c4 18             	add    $0x18,%esp
}
  8021d0:	c9                   	leave  
  8021d1:	c3                   	ret    

008021d2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8021d2:	55                   	push   %ebp
  8021d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8021d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	52                   	push   %edx
  8021e2:	50                   	push   %eax
  8021e3:	6a 18                	push   $0x18
  8021e5:	e8 8c fd ff ff       	call   801f76 <syscall>
  8021ea:	83 c4 18             	add    $0x18,%esp
}
  8021ed:	c9                   	leave  
  8021ee:	c3                   	ret    

008021ef <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8021ef:	55                   	push   %ebp
  8021f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f5:	6a 00                	push   $0x0
  8021f7:	ff 75 14             	pushl  0x14(%ebp)
  8021fa:	ff 75 10             	pushl  0x10(%ebp)
  8021fd:	ff 75 0c             	pushl  0xc(%ebp)
  802200:	50                   	push   %eax
  802201:	6a 19                	push   $0x19
  802203:	e8 6e fd ff ff       	call   801f76 <syscall>
  802208:	83 c4 18             	add    $0x18,%esp
}
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <sys_run_env>:

void sys_run_env(int32 envId)
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802210:	8b 45 08             	mov    0x8(%ebp),%eax
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	50                   	push   %eax
  80221c:	6a 1a                	push   $0x1a
  80221e:	e8 53 fd ff ff       	call   801f76 <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
}
  802226:	90                   	nop
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80222c:	8b 45 08             	mov    0x8(%ebp),%eax
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	6a 00                	push   $0x0
  802237:	50                   	push   %eax
  802238:	6a 1b                	push   $0x1b
  80223a:	e8 37 fd ff ff       	call   801f76 <syscall>
  80223f:	83 c4 18             	add    $0x18,%esp
}
  802242:	c9                   	leave  
  802243:	c3                   	ret    

00802244 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802244:	55                   	push   %ebp
  802245:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	6a 00                	push   $0x0
  802251:	6a 05                	push   $0x5
  802253:	e8 1e fd ff ff       	call   801f76 <syscall>
  802258:	83 c4 18             	add    $0x18,%esp
}
  80225b:	c9                   	leave  
  80225c:	c3                   	ret    

0080225d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80225d:	55                   	push   %ebp
  80225e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 06                	push   $0x6
  80226c:	e8 05 fd ff ff       	call   801f76 <syscall>
  802271:	83 c4 18             	add    $0x18,%esp
}
  802274:	c9                   	leave  
  802275:	c3                   	ret    

00802276 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802276:	55                   	push   %ebp
  802277:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 07                	push   $0x7
  802285:	e8 ec fc ff ff       	call   801f76 <syscall>
  80228a:	83 c4 18             	add    $0x18,%esp
}
  80228d:	c9                   	leave  
  80228e:	c3                   	ret    

0080228f <sys_exit_env>:


void sys_exit_env(void)
{
  80228f:	55                   	push   %ebp
  802290:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 1c                	push   $0x1c
  80229e:	e8 d3 fc ff ff       	call   801f76 <syscall>
  8022a3:	83 c4 18             	add    $0x18,%esp
}
  8022a6:	90                   	nop
  8022a7:	c9                   	leave  
  8022a8:	c3                   	ret    

008022a9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022a9:	55                   	push   %ebp
  8022aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	ff 75 10             	pushl  0x10(%ebp)
  8022b3:	ff 75 0c             	pushl  0xc(%ebp)
  8022b6:	ff 75 08             	pushl  0x8(%ebp)
  8022b9:	6a 13                	push   $0x13
  8022bb:	e8 b6 fc ff ff       	call   801f76 <syscall>
  8022c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c3:	90                   	nop
}
  8022c4:	c9                   	leave  
  8022c5:	c3                   	ret    

008022c6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 1e                	push   $0x1e
  8022d5:	e8 9c fc ff ff       	call   801f76 <syscall>
  8022da:	83 c4 18             	add    $0x18,%esp
}
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
  8022e2:	83 ec 04             	sub    $0x4,%esp
  8022e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022eb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	6a 00                	push   $0x0
  8022f7:	50                   	push   %eax
  8022f8:	6a 1f                	push   $0x1f
  8022fa:	e8 77 fc ff ff       	call   801f76 <syscall>
  8022ff:	83 c4 18             	add    $0x18,%esp
	return ;
  802302:	90                   	nop
}
  802303:	c9                   	leave  
  802304:	c3                   	ret    

00802305 <rsttst>:
void rsttst()
{
  802305:	55                   	push   %ebp
  802306:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802308:	6a 00                	push   $0x0
  80230a:	6a 00                	push   $0x0
  80230c:	6a 00                	push   $0x0
  80230e:	6a 00                	push   $0x0
  802310:	6a 00                	push   $0x0
  802312:	6a 21                	push   $0x21
  802314:	e8 5d fc ff ff       	call   801f76 <syscall>
  802319:	83 c4 18             	add    $0x18,%esp
	return ;
  80231c:	90                   	nop
}
  80231d:	c9                   	leave  
  80231e:	c3                   	ret    

0080231f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80231f:	55                   	push   %ebp
  802320:	89 e5                	mov    %esp,%ebp
  802322:	83 ec 04             	sub    $0x4,%esp
  802325:	8b 45 14             	mov    0x14(%ebp),%eax
  802328:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80232b:	8b 55 18             	mov    0x18(%ebp),%edx
  80232e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802332:	52                   	push   %edx
  802333:	50                   	push   %eax
  802334:	ff 75 10             	pushl  0x10(%ebp)
  802337:	ff 75 0c             	pushl  0xc(%ebp)
  80233a:	ff 75 08             	pushl  0x8(%ebp)
  80233d:	6a 20                	push   $0x20
  80233f:	e8 32 fc ff ff       	call   801f76 <syscall>
  802344:	83 c4 18             	add    $0x18,%esp
	return ;
  802347:	90                   	nop
}
  802348:	c9                   	leave  
  802349:	c3                   	ret    

0080234a <chktst>:
void chktst(uint32 n)
{
  80234a:	55                   	push   %ebp
  80234b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	ff 75 08             	pushl  0x8(%ebp)
  802358:	6a 22                	push   $0x22
  80235a:	e8 17 fc ff ff       	call   801f76 <syscall>
  80235f:	83 c4 18             	add    $0x18,%esp
	return ;
  802362:	90                   	nop
}
  802363:	c9                   	leave  
  802364:	c3                   	ret    

00802365 <inctst>:

void inctst()
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802368:	6a 00                	push   $0x0
  80236a:	6a 00                	push   $0x0
  80236c:	6a 00                	push   $0x0
  80236e:	6a 00                	push   $0x0
  802370:	6a 00                	push   $0x0
  802372:	6a 23                	push   $0x23
  802374:	e8 fd fb ff ff       	call   801f76 <syscall>
  802379:	83 c4 18             	add    $0x18,%esp
	return ;
  80237c:	90                   	nop
}
  80237d:	c9                   	leave  
  80237e:	c3                   	ret    

0080237f <gettst>:
uint32 gettst()
{
  80237f:	55                   	push   %ebp
  802380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	6a 00                	push   $0x0
  802388:	6a 00                	push   $0x0
  80238a:	6a 00                	push   $0x0
  80238c:	6a 24                	push   $0x24
  80238e:	e8 e3 fb ff ff       	call   801f76 <syscall>
  802393:	83 c4 18             	add    $0x18,%esp
}
  802396:	c9                   	leave  
  802397:	c3                   	ret    

00802398 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802398:	55                   	push   %ebp
  802399:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80239b:	6a 00                	push   $0x0
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 25                	push   $0x25
  8023a7:	e8 ca fb ff ff       	call   801f76 <syscall>
  8023ac:	83 c4 18             	add    $0x18,%esp
  8023af:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8023b4:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8023b9:	c9                   	leave  
  8023ba:	c3                   	ret    

008023bb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023bb:	55                   	push   %ebp
  8023bc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8023be:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c1:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023c6:	6a 00                	push   $0x0
  8023c8:	6a 00                	push   $0x0
  8023ca:	6a 00                	push   $0x0
  8023cc:	6a 00                	push   $0x0
  8023ce:	ff 75 08             	pushl  0x8(%ebp)
  8023d1:	6a 26                	push   $0x26
  8023d3:	e8 9e fb ff ff       	call   801f76 <syscall>
  8023d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8023db:	90                   	nop
}
  8023dc:	c9                   	leave  
  8023dd:	c3                   	ret    

008023de <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023de:	55                   	push   %ebp
  8023df:	89 e5                	mov    %esp,%ebp
  8023e1:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ee:	6a 00                	push   $0x0
  8023f0:	53                   	push   %ebx
  8023f1:	51                   	push   %ecx
  8023f2:	52                   	push   %edx
  8023f3:	50                   	push   %eax
  8023f4:	6a 27                	push   $0x27
  8023f6:	e8 7b fb ff ff       	call   801f76 <syscall>
  8023fb:	83 c4 18             	add    $0x18,%esp
}
  8023fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802401:	c9                   	leave  
  802402:	c3                   	ret    

00802403 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802403:	55                   	push   %ebp
  802404:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802406:	8b 55 0c             	mov    0xc(%ebp),%edx
  802409:	8b 45 08             	mov    0x8(%ebp),%eax
  80240c:	6a 00                	push   $0x0
  80240e:	6a 00                	push   $0x0
  802410:	6a 00                	push   $0x0
  802412:	52                   	push   %edx
  802413:	50                   	push   %eax
  802414:	6a 28                	push   $0x28
  802416:	e8 5b fb ff ff       	call   801f76 <syscall>
  80241b:	83 c4 18             	add    $0x18,%esp
}
  80241e:	c9                   	leave  
  80241f:	c3                   	ret    

00802420 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802420:	55                   	push   %ebp
  802421:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802423:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802426:	8b 55 0c             	mov    0xc(%ebp),%edx
  802429:	8b 45 08             	mov    0x8(%ebp),%eax
  80242c:	6a 00                	push   $0x0
  80242e:	51                   	push   %ecx
  80242f:	ff 75 10             	pushl  0x10(%ebp)
  802432:	52                   	push   %edx
  802433:	50                   	push   %eax
  802434:	6a 29                	push   $0x29
  802436:	e8 3b fb ff ff       	call   801f76 <syscall>
  80243b:	83 c4 18             	add    $0x18,%esp
}
  80243e:	c9                   	leave  
  80243f:	c3                   	ret    

00802440 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802440:	55                   	push   %ebp
  802441:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802443:	6a 00                	push   $0x0
  802445:	6a 00                	push   $0x0
  802447:	ff 75 10             	pushl  0x10(%ebp)
  80244a:	ff 75 0c             	pushl  0xc(%ebp)
  80244d:	ff 75 08             	pushl  0x8(%ebp)
  802450:	6a 12                	push   $0x12
  802452:	e8 1f fb ff ff       	call   801f76 <syscall>
  802457:	83 c4 18             	add    $0x18,%esp
	return ;
  80245a:	90                   	nop
}
  80245b:	c9                   	leave  
  80245c:	c3                   	ret    

0080245d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80245d:	55                   	push   %ebp
  80245e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802460:	8b 55 0c             	mov    0xc(%ebp),%edx
  802463:	8b 45 08             	mov    0x8(%ebp),%eax
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	6a 00                	push   $0x0
  80246c:	52                   	push   %edx
  80246d:	50                   	push   %eax
  80246e:	6a 2a                	push   $0x2a
  802470:	e8 01 fb ff ff       	call   801f76 <syscall>
  802475:	83 c4 18             	add    $0x18,%esp
	return;
  802478:	90                   	nop
}
  802479:	c9                   	leave  
  80247a:	c3                   	ret    

0080247b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80247b:	55                   	push   %ebp
  80247c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80247e:	6a 00                	push   $0x0
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 00                	push   $0x0
  802486:	6a 00                	push   $0x0
  802488:	6a 2b                	push   $0x2b
  80248a:	e8 e7 fa ff ff       	call   801f76 <syscall>
  80248f:	83 c4 18             	add    $0x18,%esp
}
  802492:	c9                   	leave  
  802493:	c3                   	ret    

00802494 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802494:	55                   	push   %ebp
  802495:	89 e5                	mov    %esp,%ebp
  802497:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80249a:	83 ec 04             	sub    $0x4,%esp
  80249d:	68 98 31 80 00       	push   $0x803198
  8024a2:	68 0a 01 00 00       	push   $0x10a
  8024a7:	68 a8 31 80 00       	push   $0x8031a8
  8024ac:	e8 ea e7 ff ff       	call   800c9b <_panic>

008024b1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8024b1:	55                   	push   %ebp
  8024b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8024b4:	6a 00                	push   $0x0
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	ff 75 0c             	pushl  0xc(%ebp)
  8024bd:	ff 75 08             	pushl  0x8(%ebp)
  8024c0:	6a 33                	push   $0x33
  8024c2:	e8 af fa ff ff       	call   801f76 <syscall>
  8024c7:	83 c4 18             	add    $0x18,%esp
	return;
  8024ca:	90                   	nop
}
  8024cb:	c9                   	leave  
  8024cc:	c3                   	ret    

008024cd <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8024cd:	55                   	push   %ebp
  8024ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8024d0:	6a 00                	push   $0x0
  8024d2:	6a 00                	push   $0x0
  8024d4:	6a 00                	push   $0x0
  8024d6:	ff 75 0c             	pushl  0xc(%ebp)
  8024d9:	ff 75 08             	pushl  0x8(%ebp)
  8024dc:	6a 34                	push   $0x34
  8024de:	e8 93 fa ff ff       	call   801f76 <syscall>
  8024e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8024e6:	90                   	nop
}
  8024e7:	c9                   	leave  
  8024e8:	c3                   	ret    

008024e9 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8024e9:	55                   	push   %ebp
  8024ea:	89 e5                	mov    %esp,%ebp
  8024ec:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8024ef:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8024f6:	eb 36                	jmp    80252e <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8024f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024fb:	c1 e0 04             	shl    $0x4,%eax
  8024fe:	05 60 40 80 00       	add    $0x804060,%eax
  802503:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802509:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80250c:	c1 e0 04             	shl    $0x4,%eax
  80250f:	05 64 40 80 00       	add    $0x804064,%eax
  802514:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80251a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80251d:	c1 e0 04             	shl    $0x4,%eax
  802520:	05 6c 40 80 00       	add    $0x80406c,%eax
  802525:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80252b:	ff 45 fc             	incl   -0x4(%ebp)
  80252e:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802532:	7e c4                	jle    8024f8 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802534:	90                   	nop
  802535:	c9                   	leave  
  802536:	c3                   	ret    

00802537 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802537:	55                   	push   %ebp
  802538:	89 e5                	mov    %esp,%ebp
  80253a:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80253d:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802544:	eb 24                	jmp    80256a <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802546:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802549:	c1 e0 04             	shl    $0x4,%eax
  80254c:	05 6c 40 80 00       	add    $0x80406c,%eax
  802551:	8b 00                	mov    (%eax),%eax
  802553:	83 ec 04             	sub    $0x4,%esp
  802556:	50                   	push   %eax
  802557:	ff 75 f4             	pushl  -0xc(%ebp)
  80255a:	68 b8 31 80 00       	push   $0x8031b8
  80255f:	e8 05 ea ff ff       	call   800f69 <cprintf>
  802564:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802567:	ff 45 f4             	incl   -0xc(%ebp)
  80256a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80256e:	7e d6                	jle    802546 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802570:	90                   	nop
  802571:	c9                   	leave  
  802572:	c3                   	ret    

00802573 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802573:	55                   	push   %ebp
  802574:	89 e5                	mov    %esp,%ebp
  802576:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802579:	83 ec 04             	sub    $0x4,%esp
  80257c:	68 c8 31 80 00       	push   $0x8031c8
  802581:	6a 33                	push   $0x33
  802583:	68 e9 31 80 00       	push   $0x8031e9
  802588:	e8 0e e7 ff ff       	call   800c9b <_panic>

0080258d <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80258d:	55                   	push   %ebp
  80258e:	89 e5                	mov    %esp,%ebp
  802590:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802593:	83 ec 04             	sub    $0x4,%esp
  802596:	68 01 32 80 00       	push   $0x803201
  80259b:	6a 3e                	push   $0x3e
  80259d:	68 e9 31 80 00       	push   $0x8031e9
  8025a2:	e8 f4 e6 ff ff       	call   800c9b <_panic>

008025a7 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8025a7:	55                   	push   %ebp
  8025a8:	89 e5                	mov    %esp,%ebp
  8025aa:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8025ad:	83 ec 04             	sub    $0x4,%esp
  8025b0:	68 1f 32 80 00       	push   $0x80321f
  8025b5:	6a 49                	push   $0x49
  8025b7:	68 e9 31 80 00       	push   $0x8031e9
  8025bc:	e8 da e6 ff ff       	call   800c9b <_panic>

008025c1 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8025c1:	55                   	push   %ebp
  8025c2:	89 e5                	mov    %esp,%ebp
  8025c4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8025c7:	83 ec 04             	sub    $0x4,%esp
  8025ca:	68 3c 32 80 00       	push   $0x80323c
  8025cf:	6a 58                	push   $0x58
  8025d1:	68 e9 31 80 00       	push   $0x8031e9
  8025d6:	e8 c0 e6 ff ff       	call   800c9b <_panic>
  8025db:	90                   	nop

008025dc <__udivdi3>:
  8025dc:	55                   	push   %ebp
  8025dd:	57                   	push   %edi
  8025de:	56                   	push   %esi
  8025df:	53                   	push   %ebx
  8025e0:	83 ec 1c             	sub    $0x1c,%esp
  8025e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025f3:	89 ca                	mov    %ecx,%edx
  8025f5:	89 f8                	mov    %edi,%eax
  8025f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025fb:	85 f6                	test   %esi,%esi
  8025fd:	75 2d                	jne    80262c <__udivdi3+0x50>
  8025ff:	39 cf                	cmp    %ecx,%edi
  802601:	77 65                	ja     802668 <__udivdi3+0x8c>
  802603:	89 fd                	mov    %edi,%ebp
  802605:	85 ff                	test   %edi,%edi
  802607:	75 0b                	jne    802614 <__udivdi3+0x38>
  802609:	b8 01 00 00 00       	mov    $0x1,%eax
  80260e:	31 d2                	xor    %edx,%edx
  802610:	f7 f7                	div    %edi
  802612:	89 c5                	mov    %eax,%ebp
  802614:	31 d2                	xor    %edx,%edx
  802616:	89 c8                	mov    %ecx,%eax
  802618:	f7 f5                	div    %ebp
  80261a:	89 c1                	mov    %eax,%ecx
  80261c:	89 d8                	mov    %ebx,%eax
  80261e:	f7 f5                	div    %ebp
  802620:	89 cf                	mov    %ecx,%edi
  802622:	89 fa                	mov    %edi,%edx
  802624:	83 c4 1c             	add    $0x1c,%esp
  802627:	5b                   	pop    %ebx
  802628:	5e                   	pop    %esi
  802629:	5f                   	pop    %edi
  80262a:	5d                   	pop    %ebp
  80262b:	c3                   	ret    
  80262c:	39 ce                	cmp    %ecx,%esi
  80262e:	77 28                	ja     802658 <__udivdi3+0x7c>
  802630:	0f bd fe             	bsr    %esi,%edi
  802633:	83 f7 1f             	xor    $0x1f,%edi
  802636:	75 40                	jne    802678 <__udivdi3+0x9c>
  802638:	39 ce                	cmp    %ecx,%esi
  80263a:	72 0a                	jb     802646 <__udivdi3+0x6a>
  80263c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802640:	0f 87 9e 00 00 00    	ja     8026e4 <__udivdi3+0x108>
  802646:	b8 01 00 00 00       	mov    $0x1,%eax
  80264b:	89 fa                	mov    %edi,%edx
  80264d:	83 c4 1c             	add    $0x1c,%esp
  802650:	5b                   	pop    %ebx
  802651:	5e                   	pop    %esi
  802652:	5f                   	pop    %edi
  802653:	5d                   	pop    %ebp
  802654:	c3                   	ret    
  802655:	8d 76 00             	lea    0x0(%esi),%esi
  802658:	31 ff                	xor    %edi,%edi
  80265a:	31 c0                	xor    %eax,%eax
  80265c:	89 fa                	mov    %edi,%edx
  80265e:	83 c4 1c             	add    $0x1c,%esp
  802661:	5b                   	pop    %ebx
  802662:	5e                   	pop    %esi
  802663:	5f                   	pop    %edi
  802664:	5d                   	pop    %ebp
  802665:	c3                   	ret    
  802666:	66 90                	xchg   %ax,%ax
  802668:	89 d8                	mov    %ebx,%eax
  80266a:	f7 f7                	div    %edi
  80266c:	31 ff                	xor    %edi,%edi
  80266e:	89 fa                	mov    %edi,%edx
  802670:	83 c4 1c             	add    $0x1c,%esp
  802673:	5b                   	pop    %ebx
  802674:	5e                   	pop    %esi
  802675:	5f                   	pop    %edi
  802676:	5d                   	pop    %ebp
  802677:	c3                   	ret    
  802678:	bd 20 00 00 00       	mov    $0x20,%ebp
  80267d:	89 eb                	mov    %ebp,%ebx
  80267f:	29 fb                	sub    %edi,%ebx
  802681:	89 f9                	mov    %edi,%ecx
  802683:	d3 e6                	shl    %cl,%esi
  802685:	89 c5                	mov    %eax,%ebp
  802687:	88 d9                	mov    %bl,%cl
  802689:	d3 ed                	shr    %cl,%ebp
  80268b:	89 e9                	mov    %ebp,%ecx
  80268d:	09 f1                	or     %esi,%ecx
  80268f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802693:	89 f9                	mov    %edi,%ecx
  802695:	d3 e0                	shl    %cl,%eax
  802697:	89 c5                	mov    %eax,%ebp
  802699:	89 d6                	mov    %edx,%esi
  80269b:	88 d9                	mov    %bl,%cl
  80269d:	d3 ee                	shr    %cl,%esi
  80269f:	89 f9                	mov    %edi,%ecx
  8026a1:	d3 e2                	shl    %cl,%edx
  8026a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026a7:	88 d9                	mov    %bl,%cl
  8026a9:	d3 e8                	shr    %cl,%eax
  8026ab:	09 c2                	or     %eax,%edx
  8026ad:	89 d0                	mov    %edx,%eax
  8026af:	89 f2                	mov    %esi,%edx
  8026b1:	f7 74 24 0c          	divl   0xc(%esp)
  8026b5:	89 d6                	mov    %edx,%esi
  8026b7:	89 c3                	mov    %eax,%ebx
  8026b9:	f7 e5                	mul    %ebp
  8026bb:	39 d6                	cmp    %edx,%esi
  8026bd:	72 19                	jb     8026d8 <__udivdi3+0xfc>
  8026bf:	74 0b                	je     8026cc <__udivdi3+0xf0>
  8026c1:	89 d8                	mov    %ebx,%eax
  8026c3:	31 ff                	xor    %edi,%edi
  8026c5:	e9 58 ff ff ff       	jmp    802622 <__udivdi3+0x46>
  8026ca:	66 90                	xchg   %ax,%ax
  8026cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026d0:	89 f9                	mov    %edi,%ecx
  8026d2:	d3 e2                	shl    %cl,%edx
  8026d4:	39 c2                	cmp    %eax,%edx
  8026d6:	73 e9                	jae    8026c1 <__udivdi3+0xe5>
  8026d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026db:	31 ff                	xor    %edi,%edi
  8026dd:	e9 40 ff ff ff       	jmp    802622 <__udivdi3+0x46>
  8026e2:	66 90                	xchg   %ax,%ax
  8026e4:	31 c0                	xor    %eax,%eax
  8026e6:	e9 37 ff ff ff       	jmp    802622 <__udivdi3+0x46>
  8026eb:	90                   	nop

008026ec <__umoddi3>:
  8026ec:	55                   	push   %ebp
  8026ed:	57                   	push   %edi
  8026ee:	56                   	push   %esi
  8026ef:	53                   	push   %ebx
  8026f0:	83 ec 1c             	sub    $0x1c,%esp
  8026f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802703:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802707:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80270b:	89 f3                	mov    %esi,%ebx
  80270d:	89 fa                	mov    %edi,%edx
  80270f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802713:	89 34 24             	mov    %esi,(%esp)
  802716:	85 c0                	test   %eax,%eax
  802718:	75 1a                	jne    802734 <__umoddi3+0x48>
  80271a:	39 f7                	cmp    %esi,%edi
  80271c:	0f 86 a2 00 00 00    	jbe    8027c4 <__umoddi3+0xd8>
  802722:	89 c8                	mov    %ecx,%eax
  802724:	89 f2                	mov    %esi,%edx
  802726:	f7 f7                	div    %edi
  802728:	89 d0                	mov    %edx,%eax
  80272a:	31 d2                	xor    %edx,%edx
  80272c:	83 c4 1c             	add    $0x1c,%esp
  80272f:	5b                   	pop    %ebx
  802730:	5e                   	pop    %esi
  802731:	5f                   	pop    %edi
  802732:	5d                   	pop    %ebp
  802733:	c3                   	ret    
  802734:	39 f0                	cmp    %esi,%eax
  802736:	0f 87 ac 00 00 00    	ja     8027e8 <__umoddi3+0xfc>
  80273c:	0f bd e8             	bsr    %eax,%ebp
  80273f:	83 f5 1f             	xor    $0x1f,%ebp
  802742:	0f 84 ac 00 00 00    	je     8027f4 <__umoddi3+0x108>
  802748:	bf 20 00 00 00       	mov    $0x20,%edi
  80274d:	29 ef                	sub    %ebp,%edi
  80274f:	89 fe                	mov    %edi,%esi
  802751:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802755:	89 e9                	mov    %ebp,%ecx
  802757:	d3 e0                	shl    %cl,%eax
  802759:	89 d7                	mov    %edx,%edi
  80275b:	89 f1                	mov    %esi,%ecx
  80275d:	d3 ef                	shr    %cl,%edi
  80275f:	09 c7                	or     %eax,%edi
  802761:	89 e9                	mov    %ebp,%ecx
  802763:	d3 e2                	shl    %cl,%edx
  802765:	89 14 24             	mov    %edx,(%esp)
  802768:	89 d8                	mov    %ebx,%eax
  80276a:	d3 e0                	shl    %cl,%eax
  80276c:	89 c2                	mov    %eax,%edx
  80276e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802772:	d3 e0                	shl    %cl,%eax
  802774:	89 44 24 04          	mov    %eax,0x4(%esp)
  802778:	8b 44 24 08          	mov    0x8(%esp),%eax
  80277c:	89 f1                	mov    %esi,%ecx
  80277e:	d3 e8                	shr    %cl,%eax
  802780:	09 d0                	or     %edx,%eax
  802782:	d3 eb                	shr    %cl,%ebx
  802784:	89 da                	mov    %ebx,%edx
  802786:	f7 f7                	div    %edi
  802788:	89 d3                	mov    %edx,%ebx
  80278a:	f7 24 24             	mull   (%esp)
  80278d:	89 c6                	mov    %eax,%esi
  80278f:	89 d1                	mov    %edx,%ecx
  802791:	39 d3                	cmp    %edx,%ebx
  802793:	0f 82 87 00 00 00    	jb     802820 <__umoddi3+0x134>
  802799:	0f 84 91 00 00 00    	je     802830 <__umoddi3+0x144>
  80279f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8027a3:	29 f2                	sub    %esi,%edx
  8027a5:	19 cb                	sbb    %ecx,%ebx
  8027a7:	89 d8                	mov    %ebx,%eax
  8027a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8027ad:	d3 e0                	shl    %cl,%eax
  8027af:	89 e9                	mov    %ebp,%ecx
  8027b1:	d3 ea                	shr    %cl,%edx
  8027b3:	09 d0                	or     %edx,%eax
  8027b5:	89 e9                	mov    %ebp,%ecx
  8027b7:	d3 eb                	shr    %cl,%ebx
  8027b9:	89 da                	mov    %ebx,%edx
  8027bb:	83 c4 1c             	add    $0x1c,%esp
  8027be:	5b                   	pop    %ebx
  8027bf:	5e                   	pop    %esi
  8027c0:	5f                   	pop    %edi
  8027c1:	5d                   	pop    %ebp
  8027c2:	c3                   	ret    
  8027c3:	90                   	nop
  8027c4:	89 fd                	mov    %edi,%ebp
  8027c6:	85 ff                	test   %edi,%edi
  8027c8:	75 0b                	jne    8027d5 <__umoddi3+0xe9>
  8027ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8027cf:	31 d2                	xor    %edx,%edx
  8027d1:	f7 f7                	div    %edi
  8027d3:	89 c5                	mov    %eax,%ebp
  8027d5:	89 f0                	mov    %esi,%eax
  8027d7:	31 d2                	xor    %edx,%edx
  8027d9:	f7 f5                	div    %ebp
  8027db:	89 c8                	mov    %ecx,%eax
  8027dd:	f7 f5                	div    %ebp
  8027df:	89 d0                	mov    %edx,%eax
  8027e1:	e9 44 ff ff ff       	jmp    80272a <__umoddi3+0x3e>
  8027e6:	66 90                	xchg   %ax,%ax
  8027e8:	89 c8                	mov    %ecx,%eax
  8027ea:	89 f2                	mov    %esi,%edx
  8027ec:	83 c4 1c             	add    $0x1c,%esp
  8027ef:	5b                   	pop    %ebx
  8027f0:	5e                   	pop    %esi
  8027f1:	5f                   	pop    %edi
  8027f2:	5d                   	pop    %ebp
  8027f3:	c3                   	ret    
  8027f4:	3b 04 24             	cmp    (%esp),%eax
  8027f7:	72 06                	jb     8027ff <__umoddi3+0x113>
  8027f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027fd:	77 0f                	ja     80280e <__umoddi3+0x122>
  8027ff:	89 f2                	mov    %esi,%edx
  802801:	29 f9                	sub    %edi,%ecx
  802803:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802807:	89 14 24             	mov    %edx,(%esp)
  80280a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80280e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802812:	8b 14 24             	mov    (%esp),%edx
  802815:	83 c4 1c             	add    $0x1c,%esp
  802818:	5b                   	pop    %ebx
  802819:	5e                   	pop    %esi
  80281a:	5f                   	pop    %edi
  80281b:	5d                   	pop    %ebp
  80281c:	c3                   	ret    
  80281d:	8d 76 00             	lea    0x0(%esi),%esi
  802820:	2b 04 24             	sub    (%esp),%eax
  802823:	19 fa                	sbb    %edi,%edx
  802825:	89 d1                	mov    %edx,%ecx
  802827:	89 c6                	mov    %eax,%esi
  802829:	e9 71 ff ff ff       	jmp    80279f <__umoddi3+0xb3>
  80282e:	66 90                	xchg   %ax,%ax
  802830:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802834:	72 ea                	jb     802820 <__umoddi3+0x134>
  802836:	89 d9                	mov    %ebx,%ecx
  802838:	e9 62 ff ff ff       	jmp    80279f <__umoddi3+0xb3>
