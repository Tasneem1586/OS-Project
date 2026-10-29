
obj/user/sc_ms_leak_small:     file format elf32-i386


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
  800031:	e8 fb 06 00 00       	call   800731 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	char Line[255] ;
	char Chose ;
	int numOfRep = 0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{
		numOfRep++ ;
  800048:	ff 45 f0             	incl   -0x10(%ebp)
		int NumOfElements ;
		//2012: lock the interrupt
		sys_lock_cons();
  80004b:	e8 8b 1c 00 00       	call   801cdb <sys_lock_cons>
		{
			cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 40 25 80 00       	push   $0x802540
  800058:	e8 02 0c 00 00       	call   800c5f <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 42 25 80 00       	push   $0x802542
  800068:	e8 f2 0b 00 00       	call   800c5f <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 58 25 80 00       	push   $0x802558
  800078:	e8 e2 0b 00 00       	call   800c5f <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 42 25 80 00       	push   $0x802542
  800088:	e8 d2 0b 00 00       	call   800c5f <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 40 25 80 00       	push   $0x802540
  800098:	e8 c2 0b 00 00       	call   800c5f <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  8000a0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000a4:	75 09                	jne    8000af <_main+0x77>
				NumOfElements = 4000;
  8000a6:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
  8000ad:	eb 0d                	jmp    8000bc <_main+0x84>
			else if (numOfRep == 2)
  8000af:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000b3:	75 07                	jne    8000bc <_main+0x84>
				NumOfElements = 1000;
  8000b5:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
			cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  8000bc:	83 ec 08             	sub    $0x8,%esp
  8000bf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000c2:	68 70 25 80 00       	push   $0x802570
  8000c7:	e8 93 0b 00 00       	call   800c5f <cprintf>
  8000cc:	83 c4 10             	add    $0x10,%esp
			//		cprintf("a) Ascending\n") ;
			//		cprintf("b) Descending\n") ;
			//		cprintf("c) Semi random\n");
			do
			{
				cprintf("Select: ") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 92 25 80 00       	push   $0x802592
  8000d7:	e8 83 0b 00 00       	call   800c5f <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
				if (numOfRep == 1)
  8000df:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000e3:	75 16                	jne    8000fb <_main+0xc3>
				{
					Chose = 'a' ;
  8000e5:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
					cprintf("a) Ascending\n");
  8000e9:	83 ec 0c             	sub    $0xc,%esp
  8000ec:	68 9b 25 80 00       	push   $0x80259b
  8000f1:	e8 69 0b 00 00       	call   800c5f <cprintf>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	eb 1a                	jmp    800115 <_main+0xdd>
				}
				else if (numOfRep == 2)
  8000fb:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000ff:	75 14                	jne    800115 <_main+0xdd>
				{
					Chose = 'c' ;
  800101:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
					cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 a9 25 80 00       	push   $0x8025a9
  80010d:	e8 4d 0b 00 00       	call   800c5f <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
				}
				//			cputchar(Chose);
				//			cputchar('\n');
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800115:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800119:	74 0c                	je     800127 <_main+0xef>
  80011b:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80011f:	74 06                	je     800127 <_main+0xef>
  800121:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800125:	75 a8                	jne    8000cf <_main+0x97>

		}
		sys_unlock_cons();
  800127:	e8 c9 1b 00 00       	call   801cf5 <sys_unlock_cons>

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80012c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80012f:	c1 e0 02             	shl    $0x2,%eax
  800132:	83 ec 0c             	sub    $0xc,%esp
  800135:	50                   	push   %eax
  800136:	e8 7c 1a 00 00       	call   801bb7 <malloc>
  80013b:	83 c4 10             	add    $0x10,%esp
  80013e:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int  i ;
		switch (Chose)
  800141:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800145:	83 f8 62             	cmp    $0x62,%eax
  800148:	74 1d                	je     800167 <_main+0x12f>
  80014a:	83 f8 63             	cmp    $0x63,%eax
  80014d:	74 2b                	je     80017a <_main+0x142>
  80014f:	83 f8 61             	cmp    $0x61,%eax
  800152:	75 39                	jne    80018d <_main+0x155>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800154:	83 ec 08             	sub    $0x8,%esp
  800157:	ff 75 ec             	pushl  -0x14(%ebp)
  80015a:	ff 75 e8             	pushl  -0x18(%ebp)
  80015d:	e8 f3 01 00 00       	call   800355 <InitializeAscending>
  800162:	83 c4 10             	add    $0x10,%esp
			break ;
  800165:	eb 37                	jmp    80019e <_main+0x166>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800167:	83 ec 08             	sub    $0x8,%esp
  80016a:	ff 75 ec             	pushl  -0x14(%ebp)
  80016d:	ff 75 e8             	pushl  -0x18(%ebp)
  800170:	e8 11 02 00 00       	call   800386 <InitializeIdentical>
  800175:	83 c4 10             	add    $0x10,%esp
			break ;
  800178:	eb 24                	jmp    80019e <_main+0x166>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 ec             	pushl  -0x14(%ebp)
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 33 02 00 00       	call   8003bb <InitializeSemiRandom>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 11                	jmp    80019e <_main+0x166>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 ec             	pushl  -0x14(%ebp)
  800193:	ff 75 e8             	pushl  -0x18(%ebp)
  800196:	e8 20 02 00 00       	call   8003bb <InitializeSemiRandom>
  80019b:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  80019e:	83 ec 04             	sub    $0x4,%esp
  8001a1:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a4:	6a 01                	push   $0x1
  8001a6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a9:	e8 ec 02 00 00       	call   80049a <MSort>
  8001ae:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001b1:	e8 25 1b 00 00       	call   801cdb <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001b6:	83 ec 0c             	sub    $0xc,%esp
  8001b9:	68 bc 25 80 00       	push   $0x8025bc
  8001be:	e8 9c 0a 00 00       	call   800c5f <cprintf>
  8001c3:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8001c6:	e8 2a 1b 00 00       	call   801cf5 <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001cb:	83 ec 08             	sub    $0x8,%esp
  8001ce:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d1:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d4:	e8 d2 00 00 00       	call   8002ab <CheckSorted>
  8001d9:	83 c4 10             	add    $0x10,%esp
  8001dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8001e3:	75 14                	jne    8001f9 <_main+0x1c1>
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	68 f0 25 80 00       	push   $0x8025f0
  8001ed:	6a 5c                	push   $0x5c
  8001ef:	68 12 26 80 00       	push   $0x802612
  8001f4:	e8 98 07 00 00       	call   800991 <_panic>
		else
		{
			sys_lock_cons();
  8001f9:	e8 dd 1a 00 00       	call   801cdb <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  8001fe:	83 ec 0c             	sub    $0xc,%esp
  800201:	68 2c 26 80 00       	push   $0x80262c
  800206:	e8 54 0a 00 00       	call   800c5f <cprintf>
  80020b:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  80020e:	83 ec 0c             	sub    $0xc,%esp
  800211:	68 60 26 80 00       	push   $0x802660
  800216:	e8 44 0a 00 00       	call   800c5f <cprintf>
  80021b:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  80021e:	83 ec 0c             	sub    $0xc,%esp
  800221:	68 94 26 80 00       	push   $0x802694
  800226:	e8 34 0a 00 00       	call   800c5f <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  80022e:	e8 c2 1a 00 00       	call   801cf5 <sys_unlock_cons>
		}

		//free(Elements) ;

		sys_lock_cons();
  800233:	e8 a3 1a 00 00       	call   801cdb <sys_lock_cons>
		{
			Chose = 0 ;
  800238:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  80023c:	eb 4a                	jmp    800288 <_main+0x250>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  80023e:	83 ec 0c             	sub    $0xc,%esp
  800241:	68 c6 26 80 00       	push   $0x8026c6
  800246:	e8 14 0a 00 00       	call   800c5f <cprintf>
  80024b:	83 c4 10             	add    $0x10,%esp
				if (numOfRep == 1)
  80024e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800252:	75 06                	jne    80025a <_main+0x222>
					Chose = 'y' ;
  800254:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  800258:	eb 04                	jmp    80025e <_main+0x226>
				else
					Chose = 'n' ;
  80025a:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80025e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	50                   	push   %eax
  800266:	e8 84 04 00 00       	call   8006ef <cputchar>
  80026b:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	6a 0a                	push   $0xa
  800273:	e8 77 04 00 00       	call   8006ef <cputchar>
  800278:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80027b:	83 ec 0c             	sub    $0xc,%esp
  80027e:	6a 0a                	push   $0xa
  800280:	e8 6a 04 00 00       	call   8006ef <cputchar>
  800285:	83 c4 10             	add    $0x10,%esp
		//free(Elements) ;

		sys_lock_cons();
		{
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  800288:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  80028c:	74 06                	je     800294 <_main+0x25c>
  80028e:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  800292:	75 aa                	jne    80023e <_main+0x206>
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		}
		sys_unlock_cons();
  800294:	e8 5c 1a 00 00       	call   801cf5 <sys_unlock_cons>

	} while (Chose == 'y');
  800299:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  80029d:	0f 84 a5 fd ff ff    	je     800048 <_main+0x10>

	//To indicate that it's completed successfully
	inctst();
  8002a3:	e8 b3 1d 00 00       	call   80205b <inctst>

}
  8002a8:	90                   	nop
  8002a9:	c9                   	leave  
  8002aa:	c3                   	ret    

008002ab <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002ab:	55                   	push   %ebp
  8002ac:	89 e5                	mov    %esp,%ebp
  8002ae:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002b1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002bf:	eb 33                	jmp    8002f4 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ce:	01 d0                	add    %edx,%eax
  8002d0:	8b 10                	mov    (%eax),%edx
  8002d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002d5:	40                   	inc    %eax
  8002d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e0:	01 c8                	add    %ecx,%eax
  8002e2:	8b 00                	mov    (%eax),%eax
  8002e4:	39 c2                	cmp    %eax,%edx
  8002e6:	7e 09                	jle    8002f1 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8002e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8002ef:	eb 0c                	jmp    8002fd <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002f1:	ff 45 f8             	incl   -0x8(%ebp)
  8002f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f7:	48                   	dec    %eax
  8002f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8002fb:	7f c4                	jg     8002c1 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8002fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800300:	c9                   	leave  
  800301:	c3                   	ret    

00800302 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800302:	55                   	push   %ebp
  800303:	89 e5                	mov    %esp,%ebp
  800305:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800312:	8b 45 08             	mov    0x8(%ebp),%eax
  800315:	01 d0                	add    %edx,%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80031c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800326:	8b 45 08             	mov    0x8(%ebp),%eax
  800329:	01 c2                	add    %eax,%edx
  80032b:	8b 45 10             	mov    0x10(%ebp),%eax
  80032e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800335:	8b 45 08             	mov    0x8(%ebp),%eax
  800338:	01 c8                	add    %ecx,%eax
  80033a:	8b 00                	mov    (%eax),%eax
  80033c:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80033e:	8b 45 10             	mov    0x10(%ebp),%eax
  800341:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800348:	8b 45 08             	mov    0x8(%ebp),%eax
  80034b:	01 c2                	add    %eax,%edx
  80034d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800350:	89 02                	mov    %eax,(%edx)
}
  800352:	90                   	nop
  800353:	c9                   	leave  
  800354:	c3                   	ret    

00800355 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800355:	55                   	push   %ebp
  800356:	89 e5                	mov    %esp,%ebp
  800358:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80035b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800362:	eb 17                	jmp    80037b <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800364:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 c2                	add    %eax,%edx
  800373:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800376:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800378:	ff 45 fc             	incl   -0x4(%ebp)
  80037b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80037e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800381:	7c e1                	jl     800364 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800383:	90                   	nop
  800384:	c9                   	leave  
  800385:	c3                   	ret    

00800386 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800386:	55                   	push   %ebp
  800387:	89 e5                	mov    %esp,%ebp
  800389:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80038c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800393:	eb 1b                	jmp    8003b0 <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800395:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800398:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039f:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a2:	01 c2                	add    %eax,%edx
  8003a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a7:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003aa:	48                   	dec    %eax
  8003ab:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003ad:	ff 45 fc             	incl   -0x4(%ebp)
  8003b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003b6:	7c dd                	jl     800395 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003b8:	90                   	nop
  8003b9:	c9                   	leave  
  8003ba:	c3                   	ret    

008003bb <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003bb:	55                   	push   %ebp
  8003bc:	89 e5                	mov    %esp,%ebp
  8003be:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003c4:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003c9:	f7 e9                	imul   %ecx
  8003cb:	c1 f9 1f             	sar    $0x1f,%ecx
  8003ce:	89 d0                	mov    %edx,%eax
  8003d0:	29 c8                	sub    %ecx,%eax
  8003d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8003d5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8003d9:	75 07                	jne    8003e2 <InitializeSemiRandom+0x27>
		Repetition = 3;
  8003db:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003e9:	eb 1e                	jmp    800409 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8003eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fe:	99                   	cltd   
  8003ff:	f7 7d f8             	idivl  -0x8(%ebp)
  800402:	89 d0                	mov    %edx,%eax
  800404:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
		Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800406:	ff 45 fc             	incl   -0x4(%ebp)
  800409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80040f:	7c da                	jl     8003eb <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800411:	90                   	nop
  800412:	c9                   	leave  
  800413:	c3                   	ret    

00800414 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800414:	55                   	push   %ebp
  800415:	89 e5                	mov    %esp,%ebp
  800417:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80041a:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800421:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800428:	eb 42                	jmp    80046c <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80042a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80042d:	99                   	cltd   
  80042e:	f7 7d f0             	idivl  -0x10(%ebp)
  800431:	89 d0                	mov    %edx,%eax
  800433:	85 c0                	test   %eax,%eax
  800435:	75 10                	jne    800447 <PrintElements+0x33>
			cprintf("\n");
  800437:	83 ec 0c             	sub    $0xc,%esp
  80043a:	68 40 25 80 00       	push   $0x802540
  80043f:	e8 1b 08 00 00       	call   800c5f <cprintf>
  800444:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800447:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80044a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	01 d0                	add    %edx,%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	83 ec 08             	sub    $0x8,%esp
  80045b:	50                   	push   %eax
  80045c:	68 e4 26 80 00       	push   $0x8026e4
  800461:	e8 f9 07 00 00       	call   800c5f <cprintf>
  800466:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800469:	ff 45 f4             	incl   -0xc(%ebp)
  80046c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046f:	48                   	dec    %eax
  800470:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800473:	7f b5                	jg     80042a <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800475:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	01 d0                	add    %edx,%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	83 ec 08             	sub    $0x8,%esp
  800489:	50                   	push   %eax
  80048a:	68 e9 26 80 00       	push   $0x8026e9
  80048f:	e8 cb 07 00 00       	call   800c5f <cprintf>
  800494:	83 c4 10             	add    $0x10,%esp

}
  800497:	90                   	nop
  800498:	c9                   	leave  
  800499:	c3                   	ret    

0080049a <MSort>:


void MSort(int* A, int p, int r)
{
  80049a:	55                   	push   %ebp
  80049b:	89 e5                	mov    %esp,%ebp
  80049d:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004a6:	7d 54                	jge    8004fc <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ae:	01 d0                	add    %edx,%eax
  8004b0:	89 c2                	mov    %eax,%edx
  8004b2:	c1 ea 1f             	shr    $0x1f,%edx
  8004b5:	01 d0                	add    %edx,%eax
  8004b7:	d1 f8                	sar    %eax
  8004b9:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004bc:	83 ec 04             	sub    $0x4,%esp
  8004bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c2:	ff 75 0c             	pushl  0xc(%ebp)
  8004c5:	ff 75 08             	pushl  0x8(%ebp)
  8004c8:	e8 cd ff ff ff       	call   80049a <MSort>
  8004cd:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004d3:	40                   	inc    %eax
  8004d4:	83 ec 04             	sub    $0x4,%esp
  8004d7:	ff 75 10             	pushl  0x10(%ebp)
  8004da:	50                   	push   %eax
  8004db:	ff 75 08             	pushl  0x8(%ebp)
  8004de:	e8 b7 ff ff ff       	call   80049a <MSort>
  8004e3:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004e6:	ff 75 10             	pushl  0x10(%ebp)
  8004e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ec:	ff 75 0c             	pushl  0xc(%ebp)
  8004ef:	ff 75 08             	pushl  0x8(%ebp)
  8004f2:	e8 08 00 00 00       	call   8004ff <Merge>
  8004f7:	83 c4 10             	add    $0x10,%esp
  8004fa:	eb 01                	jmp    8004fd <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  8004fc:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  8004fd:	c9                   	leave  
  8004fe:	c3                   	ret    

008004ff <Merge>:

void Merge(int* A, int p, int q, int r)
{
  8004ff:	55                   	push   %ebp
  800500:	89 e5                	mov    %esp,%ebp
  800502:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800505:	8b 45 10             	mov    0x10(%ebp),%eax
  800508:	2b 45 0c             	sub    0xc(%ebp),%eax
  80050b:	40                   	inc    %eax
  80050c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80050f:	8b 45 14             	mov    0x14(%ebp),%eax
  800512:	2b 45 10             	sub    0x10(%ebp),%eax
  800515:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80051f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800526:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800529:	c1 e0 02             	shl    $0x2,%eax
  80052c:	83 ec 0c             	sub    $0xc,%esp
  80052f:	50                   	push   %eax
  800530:	e8 82 16 00 00       	call   801bb7 <malloc>
  800535:	83 c4 10             	add    $0x10,%esp
  800538:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80053b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80053e:	c1 e0 02             	shl    $0x2,%eax
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	50                   	push   %eax
  800545:	e8 6d 16 00 00       	call   801bb7 <malloc>
  80054a:	83 c4 10             	add    $0x10,%esp
  80054d:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800550:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800557:	eb 2f                	jmp    800588 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800559:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80055c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800563:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800566:	01 c2                	add    %eax,%edx
  800568:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80056b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80056e:	01 c8                	add    %ecx,%eax
  800570:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800575:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	01 c8                	add    %ecx,%eax
  800581:	8b 00                	mov    (%eax),%eax
  800583:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800585:	ff 45 ec             	incl   -0x14(%ebp)
  800588:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80058b:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80058e:	7c c9                	jl     800559 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800590:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800597:	eb 2a                	jmp    8005c3 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800599:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80059c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005a6:	01 c2                	add    %eax,%edx
  8005a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ae:	01 c8                	add    %ecx,%eax
  8005b0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8b 00                	mov    (%eax),%eax
  8005be:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005c0:	ff 45 e8             	incl   -0x18(%ebp)
  8005c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c6:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005c9:	7c ce                	jl     800599 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005d1:	e9 0a 01 00 00       	jmp    8006e0 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005dc:	0f 8d 95 00 00 00    	jge    800677 <Merge+0x178>
  8005e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e5:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e8:	0f 8d 89 00 00 00    	jge    800677 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005fb:	01 d0                	add    %edx,%eax
  8005fd:	8b 10                	mov    (%eax),%edx
  8005ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800602:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800609:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80060c:	01 c8                	add    %ecx,%eax
  80060e:	8b 00                	mov    (%eax),%eax
  800610:	39 c2                	cmp    %eax,%edx
  800612:	7d 33                	jge    800647 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800617:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80061c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800623:	8b 45 08             	mov    0x8(%ebp),%eax
  800626:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800629:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80062c:	8d 50 01             	lea    0x1(%eax),%edx
  80062f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800632:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800639:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80063c:	01 d0                	add    %edx,%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800642:	e9 96 00 00 00       	jmp    8006dd <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80064a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80064f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80065c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80065f:	8d 50 01             	lea    0x1(%eax),%edx
  800662:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800665:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80066c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	8b 00                	mov    (%eax),%eax
  800673:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800675:	eb 66                	jmp    8006dd <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800677:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80067d:	7d 30                	jge    8006af <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80067f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800682:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800687:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800694:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800697:	8d 50 01             	lea    0x1(%eax),%edx
  80069a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80069d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006a7:	01 d0                	add    %edx,%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	89 01                	mov    %eax,(%ecx)
  8006ad:	eb 2e                	jmp    8006dd <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b2:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c7:	8d 50 01             	lea    0x1(%eax),%edx
  8006ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006d7:	01 d0                	add    %edx,%eax
  8006d9:	8b 00                	mov    (%eax),%eax
  8006db:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006dd:	ff 45 e4             	incl   -0x1c(%ebp)
  8006e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006e3:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006e6:	0f 8e ea fe ff ff    	jle    8005d6 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006ec:	90                   	nop
  8006ed:	c9                   	leave  
  8006ee:	c3                   	ret    

008006ef <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006ef:	55                   	push   %ebp
  8006f0:	89 e5                	mov    %esp,%ebp
  8006f2:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8006fb:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8006ff:	83 ec 0c             	sub    $0xc,%esp
  800702:	50                   	push   %eax
  800703:	e8 1b 17 00 00       	call   801e23 <sys_cputc>
  800708:	83 c4 10             	add    $0x10,%esp
}
  80070b:	90                   	nop
  80070c:	c9                   	leave  
  80070d:	c3                   	ret    

0080070e <getchar>:


int
getchar(void)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
  800711:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  800714:	e8 a9 15 00 00       	call   801cc2 <sys_cgetc>
  800719:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80071c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800720:	74 f2                	je     800714 <getchar+0x6>
	return c;
  800722:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800725:	c9                   	leave  
  800726:	c3                   	ret    

00800727 <iscons>:

int iscons(int fdnum)
{
  800727:	55                   	push   %ebp
  800728:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80072a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80072f:	5d                   	pop    %ebp
  800730:	c3                   	ret    

00800731 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
  800734:	57                   	push   %edi
  800735:	56                   	push   %esi
  800736:	53                   	push   %ebx
  800737:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80073d:	e8 11 18 00 00       	call   801f53 <sys_getenvindex>
  800742:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800745:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800748:	89 d0                	mov    %edx,%eax
  80074a:	c1 e0 03             	shl    $0x3,%eax
  80074d:	01 d0                	add    %edx,%eax
  80074f:	c1 e0 06             	shl    $0x6,%eax
  800752:	01 d0                	add    %edx,%eax
  800754:	c1 e0 03             	shl    $0x3,%eax
  800757:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80075c:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800761:	a1 24 30 80 00       	mov    0x803024,%eax
  800766:	8a 40 10             	mov    0x10(%eax),%al
  800769:	84 c0                	test   %al,%al
  80076b:	74 0d                	je     80077a <libmain+0x49>
		binaryname = myEnv->prog_name;
  80076d:	a1 24 30 80 00       	mov    0x803024,%eax
  800772:	83 c0 10             	add    $0x10,%eax
  800775:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80077a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80077e:	7e 0a                	jle    80078a <libmain+0x59>
		binaryname = argv[0];
  800780:	8b 45 0c             	mov    0xc(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80078a:	83 ec 08             	sub    $0x8,%esp
  80078d:	ff 75 0c             	pushl  0xc(%ebp)
  800790:	ff 75 08             	pushl  0x8(%ebp)
  800793:	e8 a0 f8 ff ff       	call   800038 <_main>
  800798:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80079b:	a1 00 30 80 00       	mov    0x803000,%eax
  8007a0:	85 c0                	test   %eax,%eax
  8007a2:	0f 84 b7 01 00 00    	je     80095f <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007a8:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007ae:	bb 2c 28 80 00       	mov    $0x80282c,%ebx
  8007b3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8007b8:	89 c7                	mov    %eax,%edi
  8007ba:	89 de                	mov    %ebx,%esi
  8007bc:	89 d1                	mov    %edx,%ecx
  8007be:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007c0:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8007c6:	b9 56 00 00 00       	mov    $0x56,%ecx
  8007cb:	b0 00                	mov    $0x0,%al
  8007cd:	89 d7                	mov    %edx,%edi
  8007cf:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8007d1:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8007d8:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8007db:	83 ec 08             	sub    $0x8,%esp
  8007de:	50                   	push   %eax
  8007df:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007e5:	50                   	push   %eax
  8007e6:	e8 68 19 00 00       	call   802153 <sys_utilities>
  8007eb:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8007ee:	e8 e8 14 00 00       	call   801cdb <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8007f3:	83 ec 0c             	sub    $0xc,%esp
  8007f6:	68 08 27 80 00       	push   $0x802708
  8007fb:	e8 5f 04 00 00       	call   800c5f <cprintf>
  800800:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800803:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800806:	85 c0                	test   %eax,%eax
  800808:	74 58                	je     800862 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80080a:	e8 62 19 00 00       	call   802171 <sys_get_optimal_num_faults>
  80080f:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800812:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800818:	bb 90 28 80 00       	mov    $0x802890,%ebx
  80081d:	ba 11 00 00 00       	mov    $0x11,%edx
  800822:	89 c7                	mov    %eax,%edi
  800824:	89 de                	mov    %ebx,%esi
  800826:	89 d1                	mov    %edx,%ecx
  800828:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80082a:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80082d:	b9 53 00 00 00       	mov    $0x53,%ecx
  800832:	b0 00                	mov    $0x0,%al
  800834:	89 d7                	mov    %edx,%edi
  800836:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800838:	83 ec 08             	sub    $0x8,%esp
  80083b:	ff 75 dc             	pushl  -0x24(%ebp)
  80083e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800844:	50                   	push   %eax
  800845:	e8 09 19 00 00       	call   802153 <sys_utilities>
  80084a:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80084d:	83 ec 08             	sub    $0x8,%esp
  800850:	ff 75 dc             	pushl  -0x24(%ebp)
  800853:	68 30 27 80 00       	push   $0x802730
  800858:	e8 02 04 00 00       	call   800c5f <cprintf>
  80085d:	83 c4 10             	add    $0x10,%esp
  800860:	eb 59                	jmp    8008bb <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800862:	a1 24 30 80 00       	mov    0x803024,%eax
  800867:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80086d:	a1 24 30 80 00       	mov    0x803024,%eax
  800872:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	52                   	push   %edx
  80087c:	50                   	push   %eax
  80087d:	68 54 27 80 00       	push   $0x802754
  800882:	e8 d8 03 00 00       	call   800c5f <cprintf>
  800887:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80088a:	a1 24 30 80 00       	mov    0x803024,%eax
  80088f:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800895:	a1 24 30 80 00       	mov    0x803024,%eax
  80089a:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008a0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a5:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008ab:	51                   	push   %ecx
  8008ac:	52                   	push   %edx
  8008ad:	50                   	push   %eax
  8008ae:	68 7c 27 80 00       	push   $0x80277c
  8008b3:	e8 a7 03 00 00       	call   800c5f <cprintf>
  8008b8:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008bb:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c0:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	50                   	push   %eax
  8008ca:	68 d4 27 80 00       	push   $0x8027d4
  8008cf:	e8 8b 03 00 00       	call   800c5f <cprintf>
  8008d4:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8008d7:	83 ec 0c             	sub    $0xc,%esp
  8008da:	68 e8 27 80 00       	push   $0x8027e8
  8008df:	e8 7b 03 00 00       	call   800c5f <cprintf>
  8008e4:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8008e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8008ee:	eb 28                	jmp    800918 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8008f0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8008f8:	81 c2 74 04 00 00    	add    $0x474,%edx
  8008fe:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800901:	83 ec 04             	sub    $0x4,%esp
  800904:	50                   	push   %eax
  800905:	ff 75 e4             	pushl  -0x1c(%ebp)
  800908:	68 ff 27 80 00       	push   $0x8027ff
  80090d:	e8 4d 03 00 00       	call   800c5f <cprintf>
  800912:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800915:	ff 45 e4             	incl   -0x1c(%ebp)
  800918:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80091c:	7e d2                	jle    8008f0 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80091e:	83 ec 0c             	sub    $0xc,%esp
  800921:	68 0e 28 80 00       	push   $0x80280e
  800926:	e8 34 03 00 00       	call   800c5f <cprintf>
  80092b:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80092e:	a1 24 30 80 00       	mov    0x803024,%eax
  800933:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	50                   	push   %eax
  80093d:	68 12 28 80 00       	push   $0x802812
  800942:	e8 18 03 00 00       	call   800c5f <cprintf>
  800947:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80094a:	83 ec 0c             	sub    $0xc,%esp
  80094d:	68 08 27 80 00       	push   $0x802708
  800952:	e8 08 03 00 00       	call   800c5f <cprintf>
  800957:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80095a:	e8 96 13 00 00       	call   801cf5 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80095f:	e8 1f 00 00 00       	call   800983 <exit>
}
  800964:	90                   	nop
  800965:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800968:	5b                   	pop    %ebx
  800969:	5e                   	pop    %esi
  80096a:	5f                   	pop    %edi
  80096b:	5d                   	pop    %ebp
  80096c:	c3                   	ret    

0080096d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80096d:	55                   	push   %ebp
  80096e:	89 e5                	mov    %esp,%ebp
  800970:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800973:	83 ec 0c             	sub    $0xc,%esp
  800976:	6a 00                	push   $0x0
  800978:	e8 a2 15 00 00       	call   801f1f <sys_destroy_env>
  80097d:	83 c4 10             	add    $0x10,%esp
}
  800980:	90                   	nop
  800981:	c9                   	leave  
  800982:	c3                   	ret    

00800983 <exit>:

void
exit(void)
{
  800983:	55                   	push   %ebp
  800984:	89 e5                	mov    %esp,%ebp
  800986:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800989:	e8 f7 15 00 00       	call   801f85 <sys_exit_env>
}
  80098e:	90                   	nop
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800997:	8d 45 10             	lea    0x10(%ebp),%eax
  80099a:	83 c0 04             	add    $0x4,%eax
  80099d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009a0:	a1 28 31 80 00       	mov    0x803128,%eax
  8009a5:	85 c0                	test   %eax,%eax
  8009a7:	74 16                	je     8009bf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009a9:	a1 28 31 80 00       	mov    0x803128,%eax
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	50                   	push   %eax
  8009b2:	68 f4 28 80 00       	push   $0x8028f4
  8009b7:	e8 a3 02 00 00       	call   800c5f <cprintf>
  8009bc:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8009bf:	a1 04 30 80 00       	mov    0x803004,%eax
  8009c4:	83 ec 0c             	sub    $0xc,%esp
  8009c7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ca:	ff 75 08             	pushl  0x8(%ebp)
  8009cd:	50                   	push   %eax
  8009ce:	68 fc 28 80 00       	push   $0x8028fc
  8009d3:	6a 74                	push   $0x74
  8009d5:	e8 b2 02 00 00       	call   800c8c <cprintf_colored>
  8009da:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8009dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e0:	83 ec 08             	sub    $0x8,%esp
  8009e3:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e6:	50                   	push   %eax
  8009e7:	e8 04 02 00 00       	call   800bf0 <vcprintf>
  8009ec:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	6a 00                	push   $0x0
  8009f4:	68 24 29 80 00       	push   $0x802924
  8009f9:	e8 f2 01 00 00       	call   800bf0 <vcprintf>
  8009fe:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a01:	e8 7d ff ff ff       	call   800983 <exit>

	// should not return here
	while (1) ;
  800a06:	eb fe                	jmp    800a06 <_panic+0x75>

00800a08 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a08:	55                   	push   %ebp
  800a09:	89 e5                	mov    %esp,%ebp
  800a0b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a0e:	a1 24 30 80 00       	mov    0x803024,%eax
  800a13:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1c:	39 c2                	cmp    %eax,%edx
  800a1e:	74 14                	je     800a34 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	68 28 29 80 00       	push   $0x802928
  800a28:	6a 26                	push   $0x26
  800a2a:	68 74 29 80 00       	push   $0x802974
  800a2f:	e8 5d ff ff ff       	call   800991 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a3b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a42:	e9 c5 00 00 00       	jmp    800b0c <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	01 d0                	add    %edx,%eax
  800a56:	8b 00                	mov    (%eax),%eax
  800a58:	85 c0                	test   %eax,%eax
  800a5a:	75 08                	jne    800a64 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a5c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a5f:	e9 a5 00 00 00       	jmp    800b09 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a64:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a6b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a72:	eb 69                	jmp    800add <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a74:	a1 24 30 80 00       	mov    0x803024,%eax
  800a79:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a7f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a82:	89 d0                	mov    %edx,%eax
  800a84:	01 c0                	add    %eax,%eax
  800a86:	01 d0                	add    %edx,%eax
  800a88:	c1 e0 03             	shl    $0x3,%eax
  800a8b:	01 c8                	add    %ecx,%eax
  800a8d:	8a 40 04             	mov    0x4(%eax),%al
  800a90:	84 c0                	test   %al,%al
  800a92:	75 46                	jne    800ada <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a94:	a1 24 30 80 00       	mov    0x803024,%eax
  800a99:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a9f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aa2:	89 d0                	mov    %edx,%eax
  800aa4:	01 c0                	add    %eax,%eax
  800aa6:	01 d0                	add    %edx,%eax
  800aa8:	c1 e0 03             	shl    $0x3,%eax
  800aab:	01 c8                	add    %ecx,%eax
  800aad:	8b 00                	mov    (%eax),%eax
  800aaf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ab2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ab5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800aba:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800abf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	01 c8                	add    %ecx,%eax
  800acb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800acd:	39 c2                	cmp    %eax,%edx
  800acf:	75 09                	jne    800ada <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800ad1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ad8:	eb 15                	jmp    800aef <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ada:	ff 45 e8             	incl   -0x18(%ebp)
  800add:	a1 24 30 80 00       	mov    0x803024,%eax
  800ae2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800ae8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800aeb:	39 c2                	cmp    %eax,%edx
  800aed:	77 85                	ja     800a74 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800aef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800af3:	75 14                	jne    800b09 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800af5:	83 ec 04             	sub    $0x4,%esp
  800af8:	68 80 29 80 00       	push   $0x802980
  800afd:	6a 3a                	push   $0x3a
  800aff:	68 74 29 80 00       	push   $0x802974
  800b04:	e8 88 fe ff ff       	call   800991 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b09:	ff 45 f0             	incl   -0x10(%ebp)
  800b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b0f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b12:	0f 8c 2f ff ff ff    	jl     800a47 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b18:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b1f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b26:	eb 26                	jmp    800b4e <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b28:	a1 24 30 80 00       	mov    0x803024,%eax
  800b2d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b33:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b36:	89 d0                	mov    %edx,%eax
  800b38:	01 c0                	add    %eax,%eax
  800b3a:	01 d0                	add    %edx,%eax
  800b3c:	c1 e0 03             	shl    $0x3,%eax
  800b3f:	01 c8                	add    %ecx,%eax
  800b41:	8a 40 04             	mov    0x4(%eax),%al
  800b44:	3c 01                	cmp    $0x1,%al
  800b46:	75 03                	jne    800b4b <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b48:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b4b:	ff 45 e0             	incl   -0x20(%ebp)
  800b4e:	a1 24 30 80 00       	mov    0x803024,%eax
  800b53:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b59:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b5c:	39 c2                	cmp    %eax,%edx
  800b5e:	77 c8                	ja     800b28 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b63:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b66:	74 14                	je     800b7c <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800b68:	83 ec 04             	sub    $0x4,%esp
  800b6b:	68 d4 29 80 00       	push   $0x8029d4
  800b70:	6a 44                	push   $0x44
  800b72:	68 74 29 80 00       	push   $0x802974
  800b77:	e8 15 fe ff ff       	call   800991 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b7c:	90                   	nop
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
  800b82:	53                   	push   %ebx
  800b83:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b91:	89 0a                	mov    %ecx,(%edx)
  800b93:	8b 55 08             	mov    0x8(%ebp),%edx
  800b96:	88 d1                	mov    %dl,%cl
  800b98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ba9:	75 30                	jne    800bdb <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800bab:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800bb1:	a0 40 30 80 00       	mov    0x803040,%al
  800bb6:	0f b6 c0             	movzbl %al,%eax
  800bb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bbc:	8b 09                	mov    (%ecx),%ecx
  800bbe:	89 cb                	mov    %ecx,%ebx
  800bc0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bc3:	83 c1 08             	add    $0x8,%ecx
  800bc6:	52                   	push   %edx
  800bc7:	50                   	push   %eax
  800bc8:	53                   	push   %ebx
  800bc9:	51                   	push   %ecx
  800bca:	e8 c8 10 00 00       	call   801c97 <sys_cputs>
  800bcf:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800bdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bde:	8b 40 04             	mov    0x4(%eax),%eax
  800be1:	8d 50 01             	lea    0x1(%eax),%edx
  800be4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be7:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bea:	90                   	nop
  800beb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bee:	c9                   	leave  
  800bef:	c3                   	ret    

00800bf0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bf0:	55                   	push   %ebp
  800bf1:	89 e5                	mov    %esp,%ebp
  800bf3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bf9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c00:	00 00 00 
	b.cnt = 0;
  800c03:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c0a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c0d:	ff 75 0c             	pushl  0xc(%ebp)
  800c10:	ff 75 08             	pushl  0x8(%ebp)
  800c13:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c19:	50                   	push   %eax
  800c1a:	68 7f 0b 80 00       	push   $0x800b7f
  800c1f:	e8 5a 02 00 00       	call   800e7e <vprintfmt>
  800c24:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c27:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800c2d:	a0 40 30 80 00       	mov    0x803040,%al
  800c32:	0f b6 c0             	movzbl %al,%eax
  800c35:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c3b:	52                   	push   %edx
  800c3c:	50                   	push   %eax
  800c3d:	51                   	push   %ecx
  800c3e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c44:	83 c0 08             	add    $0x8,%eax
  800c47:	50                   	push   %eax
  800c48:	e8 4a 10 00 00       	call   801c97 <sys_cputs>
  800c4d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c50:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800c57:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c5d:	c9                   	leave  
  800c5e:	c3                   	ret    

00800c5f <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c5f:	55                   	push   %ebp
  800c60:	89 e5                	mov    %esp,%ebp
  800c62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c65:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800c6c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	83 ec 08             	sub    $0x8,%esp
  800c78:	ff 75 f4             	pushl  -0xc(%ebp)
  800c7b:	50                   	push   %eax
  800c7c:	e8 6f ff ff ff       	call   800bf0 <vcprintf>
  800c81:	83 c4 10             	add    $0x10,%esp
  800c84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c8a:	c9                   	leave  
  800c8b:	c3                   	ret    

00800c8c <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c92:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	c1 e0 08             	shl    $0x8,%eax
  800c9f:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800ca4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ca7:	83 c0 04             	add    $0x4,%eax
  800caa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb0:	83 ec 08             	sub    $0x8,%esp
  800cb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb6:	50                   	push   %eax
  800cb7:	e8 34 ff ff ff       	call   800bf0 <vcprintf>
  800cbc:	83 c4 10             	add    $0x10,%esp
  800cbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800cc2:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800cc9:	07 00 00 

	return cnt;
  800ccc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ccf:	c9                   	leave  
  800cd0:	c3                   	ret    

00800cd1 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800cd1:	55                   	push   %ebp
  800cd2:	89 e5                	mov    %esp,%ebp
  800cd4:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800cd7:	e8 ff 0f 00 00       	call   801cdb <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800cdc:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	83 ec 08             	sub    $0x8,%esp
  800ce8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ceb:	50                   	push   %eax
  800cec:	e8 ff fe ff ff       	call   800bf0 <vcprintf>
  800cf1:	83 c4 10             	add    $0x10,%esp
  800cf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800cf7:	e8 f9 0f 00 00       	call   801cf5 <sys_unlock_cons>
	return cnt;
  800cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cff:	c9                   	leave  
  800d00:	c3                   	ret    

00800d01 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d01:	55                   	push   %ebp
  800d02:	89 e5                	mov    %esp,%ebp
  800d04:	53                   	push   %ebx
  800d05:	83 ec 14             	sub    $0x14,%esp
  800d08:	8b 45 10             	mov    0x10(%ebp),%eax
  800d0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d14:	8b 45 18             	mov    0x18(%ebp),%eax
  800d17:	ba 00 00 00 00       	mov    $0x0,%edx
  800d1c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d1f:	77 55                	ja     800d76 <printnum+0x75>
  800d21:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d24:	72 05                	jb     800d2b <printnum+0x2a>
  800d26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d29:	77 4b                	ja     800d76 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d2b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d2e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d31:	8b 45 18             	mov    0x18(%ebp),%eax
  800d34:	ba 00 00 00 00       	mov    $0x0,%edx
  800d39:	52                   	push   %edx
  800d3a:	50                   	push   %eax
  800d3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3e:	ff 75 f0             	pushl  -0x10(%ebp)
  800d41:	e8 8e 15 00 00       	call   8022d4 <__udivdi3>
  800d46:	83 c4 10             	add    $0x10,%esp
  800d49:	83 ec 04             	sub    $0x4,%esp
  800d4c:	ff 75 20             	pushl  0x20(%ebp)
  800d4f:	53                   	push   %ebx
  800d50:	ff 75 18             	pushl  0x18(%ebp)
  800d53:	52                   	push   %edx
  800d54:	50                   	push   %eax
  800d55:	ff 75 0c             	pushl  0xc(%ebp)
  800d58:	ff 75 08             	pushl  0x8(%ebp)
  800d5b:	e8 a1 ff ff ff       	call   800d01 <printnum>
  800d60:	83 c4 20             	add    $0x20,%esp
  800d63:	eb 1a                	jmp    800d7f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d65:	83 ec 08             	sub    $0x8,%esp
  800d68:	ff 75 0c             	pushl  0xc(%ebp)
  800d6b:	ff 75 20             	pushl  0x20(%ebp)
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	ff d0                	call   *%eax
  800d73:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d76:	ff 4d 1c             	decl   0x1c(%ebp)
  800d79:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d7d:	7f e6                	jg     800d65 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d7f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d82:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d8d:	53                   	push   %ebx
  800d8e:	51                   	push   %ecx
  800d8f:	52                   	push   %edx
  800d90:	50                   	push   %eax
  800d91:	e8 4e 16 00 00       	call   8023e4 <__umoddi3>
  800d96:	83 c4 10             	add    $0x10,%esp
  800d99:	05 34 2c 80 00       	add    $0x802c34,%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	0f be c0             	movsbl %al,%eax
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	50                   	push   %eax
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
}
  800db2:	90                   	nop
  800db3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800db6:	c9                   	leave  
  800db7:	c3                   	ret    

00800db8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800db8:	55                   	push   %ebp
  800db9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dbb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dbf:	7e 1c                	jle    800ddd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8b 00                	mov    (%eax),%eax
  800dc6:	8d 50 08             	lea    0x8(%eax),%edx
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	89 10                	mov    %edx,(%eax)
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	83 e8 08             	sub    $0x8,%eax
  800dd6:	8b 50 04             	mov    0x4(%eax),%edx
  800dd9:	8b 00                	mov    (%eax),%eax
  800ddb:	eb 40                	jmp    800e1d <getuint+0x65>
	else if (lflag)
  800ddd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800de1:	74 1e                	je     800e01 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8b 00                	mov    (%eax),%eax
  800de8:	8d 50 04             	lea    0x4(%eax),%edx
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	89 10                	mov    %edx,(%eax)
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	8b 00                	mov    (%eax),%eax
  800df5:	83 e8 04             	sub    $0x4,%eax
  800df8:	8b 00                	mov    (%eax),%eax
  800dfa:	ba 00 00 00 00       	mov    $0x0,%edx
  800dff:	eb 1c                	jmp    800e1d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8b 00                	mov    (%eax),%eax
  800e06:	8d 50 04             	lea    0x4(%eax),%edx
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	89 10                	mov    %edx,(%eax)
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8b 00                	mov    (%eax),%eax
  800e13:	83 e8 04             	sub    $0x4,%eax
  800e16:	8b 00                	mov    (%eax),%eax
  800e18:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e1d:	5d                   	pop    %ebp
  800e1e:	c3                   	ret    

00800e1f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e1f:	55                   	push   %ebp
  800e20:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e22:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e26:	7e 1c                	jle    800e44 <getint+0x25>
		return va_arg(*ap, long long);
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8b 00                	mov    (%eax),%eax
  800e2d:	8d 50 08             	lea    0x8(%eax),%edx
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	89 10                	mov    %edx,(%eax)
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8b 00                	mov    (%eax),%eax
  800e3a:	83 e8 08             	sub    $0x8,%eax
  800e3d:	8b 50 04             	mov    0x4(%eax),%edx
  800e40:	8b 00                	mov    (%eax),%eax
  800e42:	eb 38                	jmp    800e7c <getint+0x5d>
	else if (lflag)
  800e44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e48:	74 1a                	je     800e64 <getint+0x45>
		return va_arg(*ap, long);
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	8b 00                	mov    (%eax),%eax
  800e4f:	8d 50 04             	lea    0x4(%eax),%edx
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	89 10                	mov    %edx,(%eax)
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	8b 00                	mov    (%eax),%eax
  800e5c:	83 e8 04             	sub    $0x4,%eax
  800e5f:	8b 00                	mov    (%eax),%eax
  800e61:	99                   	cltd   
  800e62:	eb 18                	jmp    800e7c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8b 00                	mov    (%eax),%eax
  800e69:	8d 50 04             	lea    0x4(%eax),%edx
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	89 10                	mov    %edx,(%eax)
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	8b 00                	mov    (%eax),%eax
  800e76:	83 e8 04             	sub    $0x4,%eax
  800e79:	8b 00                	mov    (%eax),%eax
  800e7b:	99                   	cltd   
}
  800e7c:	5d                   	pop    %ebp
  800e7d:	c3                   	ret    

00800e7e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
  800e81:	56                   	push   %esi
  800e82:	53                   	push   %ebx
  800e83:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e86:	eb 17                	jmp    800e9f <vprintfmt+0x21>
			if (ch == '\0')
  800e88:	85 db                	test   %ebx,%ebx
  800e8a:	0f 84 c1 03 00 00    	je     801251 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800e90:	83 ec 08             	sub    $0x8,%esp
  800e93:	ff 75 0c             	pushl  0xc(%ebp)
  800e96:	53                   	push   %ebx
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	ff d0                	call   *%eax
  800e9c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea2:	8d 50 01             	lea    0x1(%eax),%edx
  800ea5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea8:	8a 00                	mov    (%eax),%al
  800eaa:	0f b6 d8             	movzbl %al,%ebx
  800ead:	83 fb 25             	cmp    $0x25,%ebx
  800eb0:	75 d6                	jne    800e88 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800eb2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800eb6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ebd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ec4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ecb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ed2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed5:	8d 50 01             	lea    0x1(%eax),%edx
  800ed8:	89 55 10             	mov    %edx,0x10(%ebp)
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	0f b6 d8             	movzbl %al,%ebx
  800ee0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ee3:	83 f8 5b             	cmp    $0x5b,%eax
  800ee6:	0f 87 3d 03 00 00    	ja     801229 <vprintfmt+0x3ab>
  800eec:	8b 04 85 58 2c 80 00 	mov    0x802c58(,%eax,4),%eax
  800ef3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ef5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ef9:	eb d7                	jmp    800ed2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800efb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800eff:	eb d1                	jmp    800ed2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f01:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f08:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f0b:	89 d0                	mov    %edx,%eax
  800f0d:	c1 e0 02             	shl    $0x2,%eax
  800f10:	01 d0                	add    %edx,%eax
  800f12:	01 c0                	add    %eax,%eax
  800f14:	01 d8                	add    %ebx,%eax
  800f16:	83 e8 30             	sub    $0x30,%eax
  800f19:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f24:	83 fb 2f             	cmp    $0x2f,%ebx
  800f27:	7e 3e                	jle    800f67 <vprintfmt+0xe9>
  800f29:	83 fb 39             	cmp    $0x39,%ebx
  800f2c:	7f 39                	jg     800f67 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f2e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f31:	eb d5                	jmp    800f08 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f33:	8b 45 14             	mov    0x14(%ebp),%eax
  800f36:	83 c0 04             	add    $0x4,%eax
  800f39:	89 45 14             	mov    %eax,0x14(%ebp)
  800f3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3f:	83 e8 04             	sub    $0x4,%eax
  800f42:	8b 00                	mov    (%eax),%eax
  800f44:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f47:	eb 1f                	jmp    800f68 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4d:	79 83                	jns    800ed2 <vprintfmt+0x54>
				width = 0;
  800f4f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f56:	e9 77 ff ff ff       	jmp    800ed2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f5b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f62:	e9 6b ff ff ff       	jmp    800ed2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f67:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f68:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f6c:	0f 89 60 ff ff ff    	jns    800ed2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f78:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f7f:	e9 4e ff ff ff       	jmp    800ed2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f84:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f87:	e9 46 ff ff ff       	jmp    800ed2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8f:	83 c0 04             	add    $0x4,%eax
  800f92:	89 45 14             	mov    %eax,0x14(%ebp)
  800f95:	8b 45 14             	mov    0x14(%ebp),%eax
  800f98:	83 e8 04             	sub    $0x4,%eax
  800f9b:	8b 00                	mov    (%eax),%eax
  800f9d:	83 ec 08             	sub    $0x8,%esp
  800fa0:	ff 75 0c             	pushl  0xc(%ebp)
  800fa3:	50                   	push   %eax
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	ff d0                	call   *%eax
  800fa9:	83 c4 10             	add    $0x10,%esp
			break;
  800fac:	e9 9b 02 00 00       	jmp    80124c <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb4:	83 c0 04             	add    $0x4,%eax
  800fb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800fba:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbd:	83 e8 04             	sub    $0x4,%eax
  800fc0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fc2:	85 db                	test   %ebx,%ebx
  800fc4:	79 02                	jns    800fc8 <vprintfmt+0x14a>
				err = -err;
  800fc6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fc8:	83 fb 64             	cmp    $0x64,%ebx
  800fcb:	7f 0b                	jg     800fd8 <vprintfmt+0x15a>
  800fcd:	8b 34 9d a0 2a 80 00 	mov    0x802aa0(,%ebx,4),%esi
  800fd4:	85 f6                	test   %esi,%esi
  800fd6:	75 19                	jne    800ff1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fd8:	53                   	push   %ebx
  800fd9:	68 45 2c 80 00       	push   $0x802c45
  800fde:	ff 75 0c             	pushl  0xc(%ebp)
  800fe1:	ff 75 08             	pushl  0x8(%ebp)
  800fe4:	e8 70 02 00 00       	call   801259 <printfmt>
  800fe9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fec:	e9 5b 02 00 00       	jmp    80124c <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ff1:	56                   	push   %esi
  800ff2:	68 4e 2c 80 00       	push   $0x802c4e
  800ff7:	ff 75 0c             	pushl  0xc(%ebp)
  800ffa:	ff 75 08             	pushl  0x8(%ebp)
  800ffd:	e8 57 02 00 00       	call   801259 <printfmt>
  801002:	83 c4 10             	add    $0x10,%esp
			break;
  801005:	e9 42 02 00 00       	jmp    80124c <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80100a:	8b 45 14             	mov    0x14(%ebp),%eax
  80100d:	83 c0 04             	add    $0x4,%eax
  801010:	89 45 14             	mov    %eax,0x14(%ebp)
  801013:	8b 45 14             	mov    0x14(%ebp),%eax
  801016:	83 e8 04             	sub    $0x4,%eax
  801019:	8b 30                	mov    (%eax),%esi
  80101b:	85 f6                	test   %esi,%esi
  80101d:	75 05                	jne    801024 <vprintfmt+0x1a6>
				p = "(null)";
  80101f:	be 51 2c 80 00       	mov    $0x802c51,%esi
			if (width > 0 && padc != '-')
  801024:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801028:	7e 6d                	jle    801097 <vprintfmt+0x219>
  80102a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80102e:	74 67                	je     801097 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801030:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801033:	83 ec 08             	sub    $0x8,%esp
  801036:	50                   	push   %eax
  801037:	56                   	push   %esi
  801038:	e8 1e 03 00 00       	call   80135b <strnlen>
  80103d:	83 c4 10             	add    $0x10,%esp
  801040:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801043:	eb 16                	jmp    80105b <vprintfmt+0x1dd>
					putch(padc, putdat);
  801045:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	50                   	push   %eax
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	ff d0                	call   *%eax
  801055:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801058:	ff 4d e4             	decl   -0x1c(%ebp)
  80105b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80105f:	7f e4                	jg     801045 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801061:	eb 34                	jmp    801097 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801063:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801067:	74 1c                	je     801085 <vprintfmt+0x207>
  801069:	83 fb 1f             	cmp    $0x1f,%ebx
  80106c:	7e 05                	jle    801073 <vprintfmt+0x1f5>
  80106e:	83 fb 7e             	cmp    $0x7e,%ebx
  801071:	7e 12                	jle    801085 <vprintfmt+0x207>
					putch('?', putdat);
  801073:	83 ec 08             	sub    $0x8,%esp
  801076:	ff 75 0c             	pushl  0xc(%ebp)
  801079:	6a 3f                	push   $0x3f
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	ff d0                	call   *%eax
  801080:	83 c4 10             	add    $0x10,%esp
  801083:	eb 0f                	jmp    801094 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801085:	83 ec 08             	sub    $0x8,%esp
  801088:	ff 75 0c             	pushl  0xc(%ebp)
  80108b:	53                   	push   %ebx
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	ff d0                	call   *%eax
  801091:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801094:	ff 4d e4             	decl   -0x1c(%ebp)
  801097:	89 f0                	mov    %esi,%eax
  801099:	8d 70 01             	lea    0x1(%eax),%esi
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	0f be d8             	movsbl %al,%ebx
  8010a1:	85 db                	test   %ebx,%ebx
  8010a3:	74 24                	je     8010c9 <vprintfmt+0x24b>
  8010a5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010a9:	78 b8                	js     801063 <vprintfmt+0x1e5>
  8010ab:	ff 4d e0             	decl   -0x20(%ebp)
  8010ae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010b2:	79 af                	jns    801063 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010b4:	eb 13                	jmp    8010c9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010b6:	83 ec 08             	sub    $0x8,%esp
  8010b9:	ff 75 0c             	pushl  0xc(%ebp)
  8010bc:	6a 20                	push   $0x20
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	ff d0                	call   *%eax
  8010c3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010c6:	ff 4d e4             	decl   -0x1c(%ebp)
  8010c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010cd:	7f e7                	jg     8010b6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010cf:	e9 78 01 00 00       	jmp    80124c <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010d4:	83 ec 08             	sub    $0x8,%esp
  8010d7:	ff 75 e8             	pushl  -0x18(%ebp)
  8010da:	8d 45 14             	lea    0x14(%ebp),%eax
  8010dd:	50                   	push   %eax
  8010de:	e8 3c fd ff ff       	call   800e1f <getint>
  8010e3:	83 c4 10             	add    $0x10,%esp
  8010e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f2:	85 d2                	test   %edx,%edx
  8010f4:	79 23                	jns    801119 <vprintfmt+0x29b>
				putch('-', putdat);
  8010f6:	83 ec 08             	sub    $0x8,%esp
  8010f9:	ff 75 0c             	pushl  0xc(%ebp)
  8010fc:	6a 2d                	push   $0x2d
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	ff d0                	call   *%eax
  801103:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801106:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801109:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80110c:	f7 d8                	neg    %eax
  80110e:	83 d2 00             	adc    $0x0,%edx
  801111:	f7 da                	neg    %edx
  801113:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801116:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801119:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801120:	e9 bc 00 00 00       	jmp    8011e1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801125:	83 ec 08             	sub    $0x8,%esp
  801128:	ff 75 e8             	pushl  -0x18(%ebp)
  80112b:	8d 45 14             	lea    0x14(%ebp),%eax
  80112e:	50                   	push   %eax
  80112f:	e8 84 fc ff ff       	call   800db8 <getuint>
  801134:	83 c4 10             	add    $0x10,%esp
  801137:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80113a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80113d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801144:	e9 98 00 00 00       	jmp    8011e1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801149:	83 ec 08             	sub    $0x8,%esp
  80114c:	ff 75 0c             	pushl  0xc(%ebp)
  80114f:	6a 58                	push   $0x58
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	ff d0                	call   *%eax
  801156:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801159:	83 ec 08             	sub    $0x8,%esp
  80115c:	ff 75 0c             	pushl  0xc(%ebp)
  80115f:	6a 58                	push   $0x58
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	ff d0                	call   *%eax
  801166:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801169:	83 ec 08             	sub    $0x8,%esp
  80116c:	ff 75 0c             	pushl  0xc(%ebp)
  80116f:	6a 58                	push   $0x58
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	ff d0                	call   *%eax
  801176:	83 c4 10             	add    $0x10,%esp
			break;
  801179:	e9 ce 00 00 00       	jmp    80124c <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80117e:	83 ec 08             	sub    $0x8,%esp
  801181:	ff 75 0c             	pushl  0xc(%ebp)
  801184:	6a 30                	push   $0x30
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	ff d0                	call   *%eax
  80118b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80118e:	83 ec 08             	sub    $0x8,%esp
  801191:	ff 75 0c             	pushl  0xc(%ebp)
  801194:	6a 78                	push   $0x78
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	ff d0                	call   *%eax
  80119b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80119e:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a1:	83 c0 04             	add    $0x4,%eax
  8011a4:	89 45 14             	mov    %eax,0x14(%ebp)
  8011a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011aa:	83 e8 04             	sub    $0x4,%eax
  8011ad:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011b9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011c0:	eb 1f                	jmp    8011e1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011c2:	83 ec 08             	sub    $0x8,%esp
  8011c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8011c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8011cb:	50                   	push   %eax
  8011cc:	e8 e7 fb ff ff       	call   800db8 <getuint>
  8011d1:	83 c4 10             	add    $0x10,%esp
  8011d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011da:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011e1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e8:	83 ec 04             	sub    $0x4,%esp
  8011eb:	52                   	push   %edx
  8011ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011ef:	50                   	push   %eax
  8011f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8011f3:	ff 75 f0             	pushl  -0x10(%ebp)
  8011f6:	ff 75 0c             	pushl  0xc(%ebp)
  8011f9:	ff 75 08             	pushl  0x8(%ebp)
  8011fc:	e8 00 fb ff ff       	call   800d01 <printnum>
  801201:	83 c4 20             	add    $0x20,%esp
			break;
  801204:	eb 46                	jmp    80124c <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801206:	83 ec 08             	sub    $0x8,%esp
  801209:	ff 75 0c             	pushl  0xc(%ebp)
  80120c:	53                   	push   %ebx
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	ff d0                	call   *%eax
  801212:	83 c4 10             	add    $0x10,%esp
			break;
  801215:	eb 35                	jmp    80124c <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801217:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  80121e:	eb 2c                	jmp    80124c <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801220:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  801227:	eb 23                	jmp    80124c <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801229:	83 ec 08             	sub    $0x8,%esp
  80122c:	ff 75 0c             	pushl  0xc(%ebp)
  80122f:	6a 25                	push   $0x25
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	ff d0                	call   *%eax
  801236:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801239:	ff 4d 10             	decl   0x10(%ebp)
  80123c:	eb 03                	jmp    801241 <vprintfmt+0x3c3>
  80123e:	ff 4d 10             	decl   0x10(%ebp)
  801241:	8b 45 10             	mov    0x10(%ebp),%eax
  801244:	48                   	dec    %eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	3c 25                	cmp    $0x25,%al
  801249:	75 f3                	jne    80123e <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80124b:	90                   	nop
		}
	}
  80124c:	e9 35 fc ff ff       	jmp    800e86 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801251:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801252:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801255:	5b                   	pop    %ebx
  801256:	5e                   	pop    %esi
  801257:	5d                   	pop    %ebp
  801258:	c3                   	ret    

00801259 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80125f:	8d 45 10             	lea    0x10(%ebp),%eax
  801262:	83 c0 04             	add    $0x4,%eax
  801265:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801268:	8b 45 10             	mov    0x10(%ebp),%eax
  80126b:	ff 75 f4             	pushl  -0xc(%ebp)
  80126e:	50                   	push   %eax
  80126f:	ff 75 0c             	pushl  0xc(%ebp)
  801272:	ff 75 08             	pushl  0x8(%ebp)
  801275:	e8 04 fc ff ff       	call   800e7e <vprintfmt>
  80127a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80127d:	90                   	nop
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801283:	8b 45 0c             	mov    0xc(%ebp),%eax
  801286:	8b 40 08             	mov    0x8(%eax),%eax
  801289:	8d 50 01             	lea    0x1(%eax),%edx
  80128c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801292:	8b 45 0c             	mov    0xc(%ebp),%eax
  801295:	8b 10                	mov    (%eax),%edx
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	8b 40 04             	mov    0x4(%eax),%eax
  80129d:	39 c2                	cmp    %eax,%edx
  80129f:	73 12                	jae    8012b3 <sprintputch+0x33>
		*b->buf++ = ch;
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	8b 00                	mov    (%eax),%eax
  8012a6:	8d 48 01             	lea    0x1(%eax),%ecx
  8012a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ac:	89 0a                	mov    %ecx,(%edx)
  8012ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b1:	88 10                	mov    %dl,(%eax)
}
  8012b3:	90                   	nop
  8012b4:	5d                   	pop    %ebp
  8012b5:	c3                   	ret    

008012b6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	01 d0                	add    %edx,%eax
  8012cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012db:	74 06                	je     8012e3 <vsnprintf+0x2d>
  8012dd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e1:	7f 07                	jg     8012ea <vsnprintf+0x34>
		return -E_INVAL;
  8012e3:	b8 03 00 00 00       	mov    $0x3,%eax
  8012e8:	eb 20                	jmp    80130a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012ea:	ff 75 14             	pushl  0x14(%ebp)
  8012ed:	ff 75 10             	pushl  0x10(%ebp)
  8012f0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012f3:	50                   	push   %eax
  8012f4:	68 80 12 80 00       	push   $0x801280
  8012f9:	e8 80 fb ff ff       	call   800e7e <vprintfmt>
  8012fe:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801301:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801304:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801307:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
  80130f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801312:	8d 45 10             	lea    0x10(%ebp),%eax
  801315:	83 c0 04             	add    $0x4,%eax
  801318:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80131b:	8b 45 10             	mov    0x10(%ebp),%eax
  80131e:	ff 75 f4             	pushl  -0xc(%ebp)
  801321:	50                   	push   %eax
  801322:	ff 75 0c             	pushl  0xc(%ebp)
  801325:	ff 75 08             	pushl  0x8(%ebp)
  801328:	e8 89 ff ff ff       	call   8012b6 <vsnprintf>
  80132d:	83 c4 10             	add    $0x10,%esp
  801330:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801333:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
  80133b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80133e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801345:	eb 06                	jmp    80134d <strlen+0x15>
		n++;
  801347:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134a:	ff 45 08             	incl   0x8(%ebp)
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	84 c0                	test   %al,%al
  801354:	75 f1                	jne    801347 <strlen+0xf>
		n++;
	return n;
  801356:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801359:	c9                   	leave  
  80135a:	c3                   	ret    

0080135b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
  80135e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801361:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801368:	eb 09                	jmp    801373 <strnlen+0x18>
		n++;
  80136a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80136d:	ff 45 08             	incl   0x8(%ebp)
  801370:	ff 4d 0c             	decl   0xc(%ebp)
  801373:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801377:	74 09                	je     801382 <strnlen+0x27>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	84 c0                	test   %al,%al
  801380:	75 e8                	jne    80136a <strnlen+0xf>
		n++;
	return n;
  801382:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801385:	c9                   	leave  
  801386:	c3                   	ret    

00801387 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801387:	55                   	push   %ebp
  801388:	89 e5                	mov    %esp,%ebp
  80138a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801393:	90                   	nop
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8d 50 01             	lea    0x1(%eax),%edx
  80139a:	89 55 08             	mov    %edx,0x8(%ebp)
  80139d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a6:	8a 12                	mov    (%edx),%dl
  8013a8:	88 10                	mov    %dl,(%eax)
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	84 c0                	test   %al,%al
  8013ae:	75 e4                	jne    801394 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c8:	eb 1f                	jmp    8013e9 <strncpy+0x34>
		*dst++ = *src;
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8d 50 01             	lea    0x1(%eax),%edx
  8013d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d6:	8a 12                	mov    (%edx),%dl
  8013d8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	84 c0                	test   %al,%al
  8013e1:	74 03                	je     8013e6 <strncpy+0x31>
			src++;
  8013e3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e6:	ff 45 fc             	incl   -0x4(%ebp)
  8013e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ef:	72 d9                	jb     8013ca <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
  8013f9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801402:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801406:	74 30                	je     801438 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801408:	eb 16                	jmp    801420 <strlcpy+0x2a>
			*dst++ = *src++;
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8d 50 01             	lea    0x1(%eax),%edx
  801410:	89 55 08             	mov    %edx,0x8(%ebp)
  801413:	8b 55 0c             	mov    0xc(%ebp),%edx
  801416:	8d 4a 01             	lea    0x1(%edx),%ecx
  801419:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80141c:	8a 12                	mov    (%edx),%dl
  80141e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801420:	ff 4d 10             	decl   0x10(%ebp)
  801423:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801427:	74 09                	je     801432 <strlcpy+0x3c>
  801429:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	84 c0                	test   %al,%al
  801430:	75 d8                	jne    80140a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801438:	8b 55 08             	mov    0x8(%ebp),%edx
  80143b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143e:	29 c2                	sub    %eax,%edx
  801440:	89 d0                	mov    %edx,%eax
}
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801447:	eb 06                	jmp    80144f <strcmp+0xb>
		p++, q++;
  801449:	ff 45 08             	incl   0x8(%ebp)
  80144c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	84 c0                	test   %al,%al
  801456:	74 0e                	je     801466 <strcmp+0x22>
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	8a 10                	mov    (%eax),%dl
  80145d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	38 c2                	cmp    %al,%dl
  801464:	74 e3                	je     801449 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	0f b6 d0             	movzbl %al,%edx
  80146e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801471:	8a 00                	mov    (%eax),%al
  801473:	0f b6 c0             	movzbl %al,%eax
  801476:	29 c2                	sub    %eax,%edx
  801478:	89 d0                	mov    %edx,%eax
}
  80147a:	5d                   	pop    %ebp
  80147b:	c3                   	ret    

0080147c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80147c:	55                   	push   %ebp
  80147d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80147f:	eb 09                	jmp    80148a <strncmp+0xe>
		n--, p++, q++;
  801481:	ff 4d 10             	decl   0x10(%ebp)
  801484:	ff 45 08             	incl   0x8(%ebp)
  801487:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148e:	74 17                	je     8014a7 <strncmp+0x2b>
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	84 c0                	test   %al,%al
  801497:	74 0e                	je     8014a7 <strncmp+0x2b>
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 10                	mov    (%eax),%dl
  80149e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a1:	8a 00                	mov    (%eax),%al
  8014a3:	38 c2                	cmp    %al,%dl
  8014a5:	74 da                	je     801481 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ab:	75 07                	jne    8014b4 <strncmp+0x38>
		return 0;
  8014ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b2:	eb 14                	jmp    8014c8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	8a 00                	mov    (%eax),%al
  8014b9:	0f b6 d0             	movzbl %al,%edx
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	8a 00                	mov    (%eax),%al
  8014c1:	0f b6 c0             	movzbl %al,%eax
  8014c4:	29 c2                	sub    %eax,%edx
  8014c6:	89 d0                	mov    %edx,%eax
}
  8014c8:	5d                   	pop    %ebp
  8014c9:	c3                   	ret    

008014ca <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014ca:	55                   	push   %ebp
  8014cb:	89 e5                	mov    %esp,%ebp
  8014cd:	83 ec 04             	sub    $0x4,%esp
  8014d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d6:	eb 12                	jmp    8014ea <strchr+0x20>
		if (*s == c)
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	8a 00                	mov    (%eax),%al
  8014dd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e0:	75 05                	jne    8014e7 <strchr+0x1d>
			return (char *) s;
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	eb 11                	jmp    8014f8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014e7:	ff 45 08             	incl   0x8(%ebp)
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	8a 00                	mov    (%eax),%al
  8014ef:	84 c0                	test   %al,%al
  8014f1:	75 e5                	jne    8014d8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
  8014fd:	83 ec 04             	sub    $0x4,%esp
  801500:	8b 45 0c             	mov    0xc(%ebp),%eax
  801503:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801506:	eb 0d                	jmp    801515 <strfind+0x1b>
		if (*s == c)
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
  80150b:	8a 00                	mov    (%eax),%al
  80150d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801510:	74 0e                	je     801520 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801512:	ff 45 08             	incl   0x8(%ebp)
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	8a 00                	mov    (%eax),%al
  80151a:	84 c0                	test   %al,%al
  80151c:	75 ea                	jne    801508 <strfind+0xe>
  80151e:	eb 01                	jmp    801521 <strfind+0x27>
		if (*s == c)
			break;
  801520:	90                   	nop
	return (char *) s;
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
  801529:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801532:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801536:	76 63                	jbe    80159b <memset+0x75>
		uint64 data_block = c;
  801538:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153b:	99                   	cltd   
  80153c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80153f:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801542:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801545:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801548:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  80154c:	c1 e0 08             	shl    $0x8,%eax
  80154f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801552:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801555:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801558:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155b:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  80155f:	c1 e0 10             	shl    $0x10,%eax
  801562:	09 45 f0             	or     %eax,-0x10(%ebp)
  801565:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801568:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80156b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80156e:	89 c2                	mov    %eax,%edx
  801570:	b8 00 00 00 00       	mov    $0x0,%eax
  801575:	09 45 f0             	or     %eax,-0x10(%ebp)
  801578:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80157b:	eb 18                	jmp    801595 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  80157d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801580:	8d 41 08             	lea    0x8(%ecx),%eax
  801583:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801589:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158c:	89 01                	mov    %eax,(%ecx)
  80158e:	89 51 04             	mov    %edx,0x4(%ecx)
  801591:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801595:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801599:	77 e2                	ja     80157d <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80159b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159f:	74 23                	je     8015c4 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8015a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015a7:	eb 0e                	jmp    8015b7 <memset+0x91>
			*p8++ = (uint8)c;
  8015a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ac:	8d 50 01             	lea    0x1(%eax),%edx
  8015af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b5:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c0:	85 c0                	test   %eax,%eax
  8015c2:	75 e5                	jne    8015a9 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
  8015cc:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8015cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8015db:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015df:	76 24                	jbe    801605 <memcpy+0x3c>
		while(n >= 8){
  8015e1:	eb 1c                	jmp    8015ff <memcpy+0x36>
			*d64 = *s64;
  8015e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e6:	8b 50 04             	mov    0x4(%eax),%edx
  8015e9:	8b 00                	mov    (%eax),%eax
  8015eb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015ee:	89 01                	mov    %eax,(%ecx)
  8015f0:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8015f3:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8015f7:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8015fb:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8015ff:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801603:	77 de                	ja     8015e3 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801605:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801609:	74 31                	je     80163c <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801611:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801614:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801617:	eb 16                	jmp    80162f <memcpy+0x66>
			*d8++ = *s8++;
  801619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80161c:	8d 50 01             	lea    0x1(%eax),%edx
  80161f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801622:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801625:	8d 4a 01             	lea    0x1(%edx),%ecx
  801628:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80162b:	8a 12                	mov    (%edx),%dl
  80162d:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80162f:	8b 45 10             	mov    0x10(%ebp),%eax
  801632:	8d 50 ff             	lea    -0x1(%eax),%edx
  801635:	89 55 10             	mov    %edx,0x10(%ebp)
  801638:	85 c0                	test   %eax,%eax
  80163a:	75 dd                	jne    801619 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801647:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801653:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801656:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801659:	73 50                	jae    8016ab <memmove+0x6a>
  80165b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801666:	76 43                	jbe    8016ab <memmove+0x6a>
		s += n;
  801668:	8b 45 10             	mov    0x10(%ebp),%eax
  80166b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801674:	eb 10                	jmp    801686 <memmove+0x45>
			*--d = *--s;
  801676:	ff 4d f8             	decl   -0x8(%ebp)
  801679:	ff 4d fc             	decl   -0x4(%ebp)
  80167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167f:	8a 10                	mov    (%eax),%dl
  801681:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801684:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801686:	8b 45 10             	mov    0x10(%ebp),%eax
  801689:	8d 50 ff             	lea    -0x1(%eax),%edx
  80168c:	89 55 10             	mov    %edx,0x10(%ebp)
  80168f:	85 c0                	test   %eax,%eax
  801691:	75 e3                	jne    801676 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801693:	eb 23                	jmp    8016b8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801695:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801698:	8d 50 01             	lea    0x1(%eax),%edx
  80169b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80169e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016a4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016a7:	8a 12                	mov    (%edx),%dl
  8016a9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b4:	85 c0                	test   %eax,%eax
  8016b6:	75 dd                	jne    801695 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016bb:	c9                   	leave  
  8016bc:	c3                   	ret    

008016bd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016bd:	55                   	push   %ebp
  8016be:	89 e5                	mov    %esp,%ebp
  8016c0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016cf:	eb 2a                	jmp    8016fb <memcmp+0x3e>
		if (*s1 != *s2)
  8016d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d4:	8a 10                	mov    (%eax),%dl
  8016d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	38 c2                	cmp    %al,%dl
  8016dd:	74 16                	je     8016f5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e2:	8a 00                	mov    (%eax),%al
  8016e4:	0f b6 d0             	movzbl %al,%edx
  8016e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ea:	8a 00                	mov    (%eax),%al
  8016ec:	0f b6 c0             	movzbl %al,%eax
  8016ef:	29 c2                	sub    %eax,%edx
  8016f1:	89 d0                	mov    %edx,%eax
  8016f3:	eb 18                	jmp    80170d <memcmp+0x50>
		s1++, s2++;
  8016f5:	ff 45 fc             	incl   -0x4(%ebp)
  8016f8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8016fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801701:	89 55 10             	mov    %edx,0x10(%ebp)
  801704:	85 c0                	test   %eax,%eax
  801706:	75 c9                	jne    8016d1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801708:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801715:	8b 55 08             	mov    0x8(%ebp),%edx
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801720:	eb 15                	jmp    801737 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	8a 00                	mov    (%eax),%al
  801727:	0f b6 d0             	movzbl %al,%edx
  80172a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172d:	0f b6 c0             	movzbl %al,%eax
  801730:	39 c2                	cmp    %eax,%edx
  801732:	74 0d                	je     801741 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801734:	ff 45 08             	incl   0x8(%ebp)
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80173d:	72 e3                	jb     801722 <memfind+0x13>
  80173f:	eb 01                	jmp    801742 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801741:	90                   	nop
	return (void *) s;
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
  80174a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80174d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801754:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80175b:	eb 03                	jmp    801760 <strtol+0x19>
		s++;
  80175d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	3c 20                	cmp    $0x20,%al
  801767:	74 f4                	je     80175d <strtol+0x16>
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8a 00                	mov    (%eax),%al
  80176e:	3c 09                	cmp    $0x9,%al
  801770:	74 eb                	je     80175d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	8a 00                	mov    (%eax),%al
  801777:	3c 2b                	cmp    $0x2b,%al
  801779:	75 05                	jne    801780 <strtol+0x39>
		s++;
  80177b:	ff 45 08             	incl   0x8(%ebp)
  80177e:	eb 13                	jmp    801793 <strtol+0x4c>
	else if (*s == '-')
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	8a 00                	mov    (%eax),%al
  801785:	3c 2d                	cmp    $0x2d,%al
  801787:	75 0a                	jne    801793 <strtol+0x4c>
		s++, neg = 1;
  801789:	ff 45 08             	incl   0x8(%ebp)
  80178c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801793:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801797:	74 06                	je     80179f <strtol+0x58>
  801799:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80179d:	75 20                	jne    8017bf <strtol+0x78>
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	8a 00                	mov    (%eax),%al
  8017a4:	3c 30                	cmp    $0x30,%al
  8017a6:	75 17                	jne    8017bf <strtol+0x78>
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	40                   	inc    %eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	3c 78                	cmp    $0x78,%al
  8017b0:	75 0d                	jne    8017bf <strtol+0x78>
		s += 2, base = 16;
  8017b2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017b6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017bd:	eb 28                	jmp    8017e7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c3:	75 15                	jne    8017da <strtol+0x93>
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 30                	cmp    $0x30,%al
  8017cc:	75 0c                	jne    8017da <strtol+0x93>
		s++, base = 8;
  8017ce:	ff 45 08             	incl   0x8(%ebp)
  8017d1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017d8:	eb 0d                	jmp    8017e7 <strtol+0xa0>
	else if (base == 0)
  8017da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017de:	75 07                	jne    8017e7 <strtol+0xa0>
		base = 10;
  8017e0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ea:	8a 00                	mov    (%eax),%al
  8017ec:	3c 2f                	cmp    $0x2f,%al
  8017ee:	7e 19                	jle    801809 <strtol+0xc2>
  8017f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f3:	8a 00                	mov    (%eax),%al
  8017f5:	3c 39                	cmp    $0x39,%al
  8017f7:	7f 10                	jg     801809 <strtol+0xc2>
			dig = *s - '0';
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	8a 00                	mov    (%eax),%al
  8017fe:	0f be c0             	movsbl %al,%eax
  801801:	83 e8 30             	sub    $0x30,%eax
  801804:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801807:	eb 42                	jmp    80184b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	8a 00                	mov    (%eax),%al
  80180e:	3c 60                	cmp    $0x60,%al
  801810:	7e 19                	jle    80182b <strtol+0xe4>
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	8a 00                	mov    (%eax),%al
  801817:	3c 7a                	cmp    $0x7a,%al
  801819:	7f 10                	jg     80182b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80181b:	8b 45 08             	mov    0x8(%ebp),%eax
  80181e:	8a 00                	mov    (%eax),%al
  801820:	0f be c0             	movsbl %al,%eax
  801823:	83 e8 57             	sub    $0x57,%eax
  801826:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801829:	eb 20                	jmp    80184b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	8a 00                	mov    (%eax),%al
  801830:	3c 40                	cmp    $0x40,%al
  801832:	7e 39                	jle    80186d <strtol+0x126>
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	3c 5a                	cmp    $0x5a,%al
  80183b:	7f 30                	jg     80186d <strtol+0x126>
			dig = *s - 'A' + 10;
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	8a 00                	mov    (%eax),%al
  801842:	0f be c0             	movsbl %al,%eax
  801845:	83 e8 37             	sub    $0x37,%eax
  801848:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80184b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80184e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801851:	7d 19                	jge    80186c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801853:	ff 45 08             	incl   0x8(%ebp)
  801856:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801859:	0f af 45 10          	imul   0x10(%ebp),%eax
  80185d:	89 c2                	mov    %eax,%edx
  80185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801862:	01 d0                	add    %edx,%eax
  801864:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801867:	e9 7b ff ff ff       	jmp    8017e7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80186c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80186d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801871:	74 08                	je     80187b <strtol+0x134>
		*endptr = (char *) s;
  801873:	8b 45 0c             	mov    0xc(%ebp),%eax
  801876:	8b 55 08             	mov    0x8(%ebp),%edx
  801879:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80187b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80187f:	74 07                	je     801888 <strtol+0x141>
  801881:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801884:	f7 d8                	neg    %eax
  801886:	eb 03                	jmp    80188b <strtol+0x144>
  801888:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <ltostr>:

void
ltostr(long value, char *str)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801893:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80189a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018a5:	79 13                	jns    8018ba <ltostr+0x2d>
	{
		neg = 1;
  8018a7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018b4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018b7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018c2:	99                   	cltd   
  8018c3:	f7 f9                	idiv   %ecx
  8018c5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018cb:	8d 50 01             	lea    0x1(%eax),%edx
  8018ce:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018d1:	89 c2                	mov    %eax,%edx
  8018d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d6:	01 d0                	add    %edx,%eax
  8018d8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018db:	83 c2 30             	add    $0x30,%edx
  8018de:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018e3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018e8:	f7 e9                	imul   %ecx
  8018ea:	c1 fa 02             	sar    $0x2,%edx
  8018ed:	89 c8                	mov    %ecx,%eax
  8018ef:	c1 f8 1f             	sar    $0x1f,%eax
  8018f2:	29 c2                	sub    %eax,%edx
  8018f4:	89 d0                	mov    %edx,%eax
  8018f6:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8018f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018fd:	75 bb                	jne    8018ba <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8018ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801906:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801909:	48                   	dec    %eax
  80190a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80190d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801911:	74 3d                	je     801950 <ltostr+0xc3>
		start = 1 ;
  801913:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80191a:	eb 34                	jmp    801950 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80191c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80191f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801922:	01 d0                	add    %edx,%eax
  801924:	8a 00                	mov    (%eax),%al
  801926:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801929:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80192c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192f:	01 c2                	add    %eax,%edx
  801931:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801934:	8b 45 0c             	mov    0xc(%ebp),%eax
  801937:	01 c8                	add    %ecx,%eax
  801939:	8a 00                	mov    (%eax),%al
  80193b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80193d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801940:	8b 45 0c             	mov    0xc(%ebp),%eax
  801943:	01 c2                	add    %eax,%edx
  801945:	8a 45 eb             	mov    -0x15(%ebp),%al
  801948:	88 02                	mov    %al,(%edx)
		start++ ;
  80194a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80194d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801950:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801953:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801956:	7c c4                	jl     80191c <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801958:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80195b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195e:	01 d0                	add    %edx,%eax
  801960:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801963:	90                   	nop
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
  801969:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80196c:	ff 75 08             	pushl  0x8(%ebp)
  80196f:	e8 c4 f9 ff ff       	call   801338 <strlen>
  801974:	83 c4 04             	add    $0x4,%esp
  801977:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80197a:	ff 75 0c             	pushl  0xc(%ebp)
  80197d:	e8 b6 f9 ff ff       	call   801338 <strlen>
  801982:	83 c4 04             	add    $0x4,%esp
  801985:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801988:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80198f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801996:	eb 17                	jmp    8019af <strcconcat+0x49>
		final[s] = str1[s] ;
  801998:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80199b:	8b 45 10             	mov    0x10(%ebp),%eax
  80199e:	01 c2                	add    %eax,%edx
  8019a0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	01 c8                	add    %ecx,%eax
  8019a8:	8a 00                	mov    (%eax),%al
  8019aa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019ac:	ff 45 fc             	incl   -0x4(%ebp)
  8019af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019b5:	7c e1                	jl     801998 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019c5:	eb 1f                	jmp    8019e6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ca:	8d 50 01             	lea    0x1(%eax),%edx
  8019cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019d0:	89 c2                	mov    %eax,%edx
  8019d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d5:	01 c2                	add    %eax,%edx
  8019d7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019dd:	01 c8                	add    %ecx,%eax
  8019df:	8a 00                	mov    (%eax),%al
  8019e1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8019e3:	ff 45 f8             	incl   -0x8(%ebp)
  8019e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019e9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019ec:	7c d9                	jl     8019c7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f4:	01 d0                	add    %edx,%eax
  8019f6:	c6 00 00             	movb   $0x0,(%eax)
}
  8019f9:	90                   	nop
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8019ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801a02:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a08:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0b:	8b 00                	mov    (%eax),%eax
  801a0d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a14:	8b 45 10             	mov    0x10(%ebp),%eax
  801a17:	01 d0                	add    %edx,%eax
  801a19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a1f:	eb 0c                	jmp    801a2d <strsplit+0x31>
			*string++ = 0;
  801a21:	8b 45 08             	mov    0x8(%ebp),%eax
  801a24:	8d 50 01             	lea    0x1(%eax),%edx
  801a27:	89 55 08             	mov    %edx,0x8(%ebp)
  801a2a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	8a 00                	mov    (%eax),%al
  801a32:	84 c0                	test   %al,%al
  801a34:	74 18                	je     801a4e <strsplit+0x52>
  801a36:	8b 45 08             	mov    0x8(%ebp),%eax
  801a39:	8a 00                	mov    (%eax),%al
  801a3b:	0f be c0             	movsbl %al,%eax
  801a3e:	50                   	push   %eax
  801a3f:	ff 75 0c             	pushl  0xc(%ebp)
  801a42:	e8 83 fa ff ff       	call   8014ca <strchr>
  801a47:	83 c4 08             	add    $0x8,%esp
  801a4a:	85 c0                	test   %eax,%eax
  801a4c:	75 d3                	jne    801a21 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a51:	8a 00                	mov    (%eax),%al
  801a53:	84 c0                	test   %al,%al
  801a55:	74 5a                	je     801ab1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a57:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5a:	8b 00                	mov    (%eax),%eax
  801a5c:	83 f8 0f             	cmp    $0xf,%eax
  801a5f:	75 07                	jne    801a68 <strsplit+0x6c>
		{
			return 0;
  801a61:	b8 00 00 00 00       	mov    $0x0,%eax
  801a66:	eb 66                	jmp    801ace <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a68:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6b:	8b 00                	mov    (%eax),%eax
  801a6d:	8d 48 01             	lea    0x1(%eax),%ecx
  801a70:	8b 55 14             	mov    0x14(%ebp),%edx
  801a73:	89 0a                	mov    %ecx,(%edx)
  801a75:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a7c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7f:	01 c2                	add    %eax,%edx
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a86:	eb 03                	jmp    801a8b <strsplit+0x8f>
			string++;
  801a88:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	8a 00                	mov    (%eax),%al
  801a90:	84 c0                	test   %al,%al
  801a92:	74 8b                	je     801a1f <strsplit+0x23>
  801a94:	8b 45 08             	mov    0x8(%ebp),%eax
  801a97:	8a 00                	mov    (%eax),%al
  801a99:	0f be c0             	movsbl %al,%eax
  801a9c:	50                   	push   %eax
  801a9d:	ff 75 0c             	pushl  0xc(%ebp)
  801aa0:	e8 25 fa ff ff       	call   8014ca <strchr>
  801aa5:	83 c4 08             	add    $0x8,%esp
  801aa8:	85 c0                	test   %eax,%eax
  801aaa:	74 dc                	je     801a88 <strsplit+0x8c>
			string++;
	}
  801aac:	e9 6e ff ff ff       	jmp    801a1f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ab1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ab2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab5:	8b 00                	mov    (%eax),%eax
  801ab7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801abe:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac1:	01 d0                	add    %edx,%eax
  801ac3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ac9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
  801ad3:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801adc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ae3:	eb 4a                	jmp    801b2f <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801ae5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aeb:	01 c2                	add    %eax,%edx
  801aed:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801af0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af3:	01 c8                	add    %ecx,%eax
  801af5:	8a 00                	mov    (%eax),%al
  801af7:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801af9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aff:	01 d0                	add    %edx,%eax
  801b01:	8a 00                	mov    (%eax),%al
  801b03:	3c 40                	cmp    $0x40,%al
  801b05:	7e 25                	jle    801b2c <str2lower+0x5c>
  801b07:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b0d:	01 d0                	add    %edx,%eax
  801b0f:	8a 00                	mov    (%eax),%al
  801b11:	3c 5a                	cmp    $0x5a,%al
  801b13:	7f 17                	jg     801b2c <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801b15:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	01 d0                	add    %edx,%eax
  801b1d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b20:	8b 55 08             	mov    0x8(%ebp),%edx
  801b23:	01 ca                	add    %ecx,%edx
  801b25:	8a 12                	mov    (%edx),%dl
  801b27:	83 c2 20             	add    $0x20,%edx
  801b2a:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b2c:	ff 45 fc             	incl   -0x4(%ebp)
  801b2f:	ff 75 0c             	pushl  0xc(%ebp)
  801b32:	e8 01 f8 ff ff       	call   801338 <strlen>
  801b37:	83 c4 04             	add    $0x4,%esp
  801b3a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b3d:	7f a6                	jg     801ae5 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b42:	c9                   	leave  
  801b43:	c3                   	ret    

00801b44 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801b44:	55                   	push   %ebp
  801b45:	89 e5                	mov    %esp,%ebp
  801b47:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801b4a:	a1 08 30 80 00       	mov    0x803008,%eax
  801b4f:	85 c0                	test   %eax,%eax
  801b51:	74 2d                	je     801b80 <uheap_init+0x3c>
	{
		buddy_init();
  801b53:	e8 87 06 00 00       	call   8021df <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801b58:	e8 31 05 00 00       	call   80208e <sys_get_uheap_strategy>
  801b5d:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  801b62:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801b69:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801b6c:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  801b73:	00 00 80 
		__firstTimeFlag = 0;
  801b76:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801b7d:	00 00 00 
	}
}
  801b80:	90                   	nop
  801b81:	c9                   	leave  
  801b82:	c3                   	ret    

00801b83 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801b83:	55                   	push   %ebp
  801b84:	89 e5                	mov    %esp,%ebp
  801b86:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801b89:	83 ec 04             	sub    $0x4,%esp
  801b8c:	68 c8 2d 80 00       	push   $0x802dc8
  801b91:	6a 25                	push   $0x25
  801b93:	68 f9 2d 80 00       	push   $0x802df9
  801b98:	e8 f4 ed ff ff       	call   800991 <_panic>

00801b9d <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
  801ba0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801ba3:	83 ec 04             	sub    $0x4,%esp
  801ba6:	68 08 2e 80 00       	push   $0x802e08
  801bab:	6a 2f                	push   $0x2f
  801bad:	68 f9 2d 80 00       	push   $0x802df9
  801bb2:	e8 da ed ff ff       	call   800991 <_panic>

00801bb7 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801bbd:	e8 82 ff ff ff       	call   801b44 <uheap_init>
	if (size == 0) return NULL ;
  801bc2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801bc6:	75 07                	jne    801bcf <malloc+0x18>
  801bc8:	b8 00 00 00 00       	mov    $0x0,%eax
  801bcd:	eb 14                	jmp    801be3 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801bcf:	83 ec 04             	sub    $0x4,%esp
  801bd2:	68 3c 2e 80 00       	push   $0x802e3c
  801bd7:	6a 43                	push   $0x43
  801bd9:	68 f9 2d 80 00       	push   $0x802df9
  801bde:	e8 ae ed ff ff       	call   800991 <_panic>
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
  801be8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801beb:	83 ec 04             	sub    $0x4,%esp
  801bee:	68 64 2e 80 00       	push   $0x802e64
  801bf3:	6a 4e                	push   $0x4e
  801bf5:	68 f9 2d 80 00       	push   $0x802df9
  801bfa:	e8 92 ed ff ff       	call   800991 <_panic>

00801bff <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
  801c02:	83 ec 18             	sub    $0x18,%esp
  801c05:	8b 45 10             	mov    0x10(%ebp),%eax
  801c08:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c0b:	e8 34 ff ff ff       	call   801b44 <uheap_init>
	if (size == 0) return NULL ;
  801c10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c14:	75 07                	jne    801c1d <smalloc+0x1e>
  801c16:	b8 00 00 00 00       	mov    $0x0,%eax
  801c1b:	eb 14                	jmp    801c31 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801c1d:	83 ec 04             	sub    $0x4,%esp
  801c20:	68 88 2e 80 00       	push   $0x802e88
  801c25:	6a 5f                	push   $0x5f
  801c27:	68 f9 2d 80 00       	push   $0x802df9
  801c2c:	e8 60 ed ff ff       	call   800991 <_panic>
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
  801c36:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c39:	e8 06 ff ff ff       	call   801b44 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801c3e:	83 ec 04             	sub    $0x4,%esp
  801c41:	68 b0 2e 80 00       	push   $0x802eb0
  801c46:	6a 6f                	push   $0x6f
  801c48:	68 f9 2d 80 00       	push   $0x802df9
  801c4d:	e8 3f ed ff ff       	call   800991 <_panic>

00801c52 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
  801c55:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801c58:	83 ec 04             	sub    $0x4,%esp
  801c5b:	68 d4 2e 80 00       	push   $0x802ed4
  801c60:	6a 7e                	push   $0x7e
  801c62:	68 f9 2d 80 00       	push   $0x802df9
  801c67:	e8 25 ed ff ff       	call   800991 <_panic>

00801c6c <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
  801c6f:	57                   	push   %edi
  801c70:	56                   	push   %esi
  801c71:	53                   	push   %ebx
  801c72:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c75:	8b 45 08             	mov    0x8(%ebp),%eax
  801c78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c7e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c81:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c84:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c87:	cd 30                	int    $0x30
  801c89:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c8f:	83 c4 10             	add    $0x10,%esp
  801c92:	5b                   	pop    %ebx
  801c93:	5e                   	pop    %esi
  801c94:	5f                   	pop    %edi
  801c95:	5d                   	pop    %ebp
  801c96:	c3                   	ret    

00801c97 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
  801c9a:	83 ec 04             	sub    $0x4,%esp
  801c9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801ca3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ca6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801caa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cad:	6a 00                	push   $0x0
  801caf:	51                   	push   %ecx
  801cb0:	52                   	push   %edx
  801cb1:	ff 75 0c             	pushl  0xc(%ebp)
  801cb4:	50                   	push   %eax
  801cb5:	6a 00                	push   $0x0
  801cb7:	e8 b0 ff ff ff       	call   801c6c <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	90                   	nop
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 02                	push   $0x2
  801cd1:	e8 96 ff ff ff       	call   801c6c <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_lock_cons>:

void sys_lock_cons(void)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 03                	push   $0x3
  801cea:	e8 7d ff ff ff       	call   801c6c <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
}
  801cf2:	90                   	nop
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 04                	push   $0x4
  801d04:	e8 63 ff ff ff       	call   801c6c <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
}
  801d0c:	90                   	nop
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d15:	8b 45 08             	mov    0x8(%ebp),%eax
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	52                   	push   %edx
  801d1f:	50                   	push   %eax
  801d20:	6a 08                	push   $0x8
  801d22:	e8 45 ff ff ff       	call   801c6c <syscall>
  801d27:	83 c4 18             	add    $0x18,%esp
}
  801d2a:	c9                   	leave  
  801d2b:	c3                   	ret    

00801d2c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d2c:	55                   	push   %ebp
  801d2d:	89 e5                	mov    %esp,%ebp
  801d2f:	56                   	push   %esi
  801d30:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d31:	8b 75 18             	mov    0x18(%ebp),%esi
  801d34:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d40:	56                   	push   %esi
  801d41:	53                   	push   %ebx
  801d42:	51                   	push   %ecx
  801d43:	52                   	push   %edx
  801d44:	50                   	push   %eax
  801d45:	6a 09                	push   $0x9
  801d47:	e8 20 ff ff ff       	call   801c6c <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
}
  801d4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d52:	5b                   	pop    %ebx
  801d53:	5e                   	pop    %esi
  801d54:	5d                   	pop    %ebp
  801d55:	c3                   	ret    

00801d56 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	ff 75 08             	pushl  0x8(%ebp)
  801d64:	6a 0a                	push   $0xa
  801d66:	e8 01 ff ff ff       	call   801c6c <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
}
  801d6e:	c9                   	leave  
  801d6f:	c3                   	ret    

00801d70 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	ff 75 0c             	pushl  0xc(%ebp)
  801d7c:	ff 75 08             	pushl  0x8(%ebp)
  801d7f:	6a 0b                	push   $0xb
  801d81:	e8 e6 fe ff ff       	call   801c6c <syscall>
  801d86:	83 c4 18             	add    $0x18,%esp
}
  801d89:	c9                   	leave  
  801d8a:	c3                   	ret    

00801d8b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 0c                	push   $0xc
  801d9a:	e8 cd fe ff ff       	call   801c6c <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 0d                	push   $0xd
  801db3:	e8 b4 fe ff ff       	call   801c6c <syscall>
  801db8:	83 c4 18             	add    $0x18,%esp
}
  801dbb:	c9                   	leave  
  801dbc:	c3                   	ret    

00801dbd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dbd:	55                   	push   %ebp
  801dbe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 0e                	push   $0xe
  801dcc:	e8 9b fe ff ff       	call   801c6c <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
}
  801dd4:	c9                   	leave  
  801dd5:	c3                   	ret    

00801dd6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801dd6:	55                   	push   %ebp
  801dd7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 0f                	push   $0xf
  801de5:	e8 82 fe ff ff       	call   801c6c <syscall>
  801dea:	83 c4 18             	add    $0x18,%esp
}
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	ff 75 08             	pushl  0x8(%ebp)
  801dfd:	6a 10                	push   $0x10
  801dff:	e8 68 fe ff ff       	call   801c6c <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
}
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 11                	push   $0x11
  801e18:	e8 4f fe ff ff       	call   801c6c <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	90                   	nop
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_cputc>:

void
sys_cputc(const char c)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
  801e26:	83 ec 04             	sub    $0x4,%esp
  801e29:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e2f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	50                   	push   %eax
  801e3c:	6a 01                	push   $0x1
  801e3e:	e8 29 fe ff ff       	call   801c6c <syscall>
  801e43:	83 c4 18             	add    $0x18,%esp
}
  801e46:	90                   	nop
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 14                	push   $0x14
  801e58:	e8 0f fe ff ff       	call   801c6c <syscall>
  801e5d:	83 c4 18             	add    $0x18,%esp
}
  801e60:	90                   	nop
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
  801e66:	83 ec 04             	sub    $0x4,%esp
  801e69:	8b 45 10             	mov    0x10(%ebp),%eax
  801e6c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801e6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e72:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	6a 00                	push   $0x0
  801e7b:	51                   	push   %ecx
  801e7c:	52                   	push   %edx
  801e7d:	ff 75 0c             	pushl  0xc(%ebp)
  801e80:	50                   	push   %eax
  801e81:	6a 15                	push   $0x15
  801e83:	e8 e4 fd ff ff       	call   801c6c <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801e90:	8b 55 10             	mov    0x10(%ebp),%edx
  801e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	52                   	push   %edx
  801e9b:	50                   	push   %eax
  801e9c:	ff 75 08             	pushl  0x8(%ebp)
  801e9f:	6a 16                	push   $0x16
  801ea1:	e8 c6 fd ff ff       	call   801c6c <syscall>
  801ea6:	83 c4 18             	add    $0x18,%esp
}
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801eae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	52                   	push   %edx
  801ebb:	50                   	push   %eax
  801ebc:	6a 17                	push   $0x17
  801ebe:	e8 a9 fd ff ff       	call   801c6c <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801ecb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ece:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	52                   	push   %edx
  801ed8:	50                   	push   %eax
  801ed9:	6a 18                	push   $0x18
  801edb:	e8 8c fd ff ff       	call   801c6c <syscall>
  801ee0:	83 c4 18             	add    $0x18,%esp
}
  801ee3:	c9                   	leave  
  801ee4:	c3                   	ret    

00801ee5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eeb:	6a 00                	push   $0x0
  801eed:	ff 75 14             	pushl  0x14(%ebp)
  801ef0:	ff 75 10             	pushl  0x10(%ebp)
  801ef3:	ff 75 0c             	pushl  0xc(%ebp)
  801ef6:	50                   	push   %eax
  801ef7:	6a 19                	push   $0x19
  801ef9:	e8 6e fd ff ff       	call   801c6c <syscall>
  801efe:	83 c4 18             	add    $0x18,%esp
}
  801f01:	c9                   	leave  
  801f02:	c3                   	ret    

00801f03 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801f03:	55                   	push   %ebp
  801f04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f06:	8b 45 08             	mov    0x8(%ebp),%eax
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	50                   	push   %eax
  801f12:	6a 1a                	push   $0x1a
  801f14:	e8 53 fd ff ff       	call   801c6c <syscall>
  801f19:	83 c4 18             	add    $0x18,%esp
}
  801f1c:	90                   	nop
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801f22:	8b 45 08             	mov    0x8(%ebp),%eax
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	50                   	push   %eax
  801f2e:	6a 1b                	push   $0x1b
  801f30:	e8 37 fd ff ff       	call   801c6c <syscall>
  801f35:	83 c4 18             	add    $0x18,%esp
}
  801f38:	c9                   	leave  
  801f39:	c3                   	ret    

00801f3a <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f3a:	55                   	push   %ebp
  801f3b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 05                	push   $0x5
  801f49:	e8 1e fd ff ff       	call   801c6c <syscall>
  801f4e:	83 c4 18             	add    $0x18,%esp
}
  801f51:	c9                   	leave  
  801f52:	c3                   	ret    

00801f53 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f53:	55                   	push   %ebp
  801f54:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 06                	push   $0x6
  801f62:	e8 05 fd ff ff       	call   801c6c <syscall>
  801f67:	83 c4 18             	add    $0x18,%esp
}
  801f6a:	c9                   	leave  
  801f6b:	c3                   	ret    

00801f6c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f6c:	55                   	push   %ebp
  801f6d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 07                	push   $0x7
  801f7b:	e8 ec fc ff ff       	call   801c6c <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_exit_env>:


void sys_exit_env(void)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 1c                	push   $0x1c
  801f94:	e8 d3 fc ff ff       	call   801c6c <syscall>
  801f99:	83 c4 18             	add    $0x18,%esp
}
  801f9c:	90                   	nop
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	ff 75 10             	pushl  0x10(%ebp)
  801fa9:	ff 75 0c             	pushl  0xc(%ebp)
  801fac:	ff 75 08             	pushl  0x8(%ebp)
  801faf:	6a 13                	push   $0x13
  801fb1:	e8 b6 fc ff ff       	call   801c6c <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb9:	90                   	nop
}
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <sys_rcr2>:
uint32 sys_rcr2()
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 1e                	push   $0x1e
  801fcb:	e8 9c fc ff ff       	call   801c6c <syscall>
  801fd0:	83 c4 18             	add    $0x18,%esp
}
  801fd3:	c9                   	leave  
  801fd4:	c3                   	ret    

00801fd5 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801fd5:	55                   	push   %ebp
  801fd6:	89 e5                	mov    %esp,%ebp
  801fd8:	83 ec 04             	sub    $0x4,%esp
  801fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fde:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fe1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	50                   	push   %eax
  801fee:	6a 1f                	push   $0x1f
  801ff0:	e8 77 fc ff ff       	call   801c6c <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff8:	90                   	nop
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <rsttst>:
void rsttst()
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 21                	push   $0x21
  80200a:	e8 5d fc ff ff       	call   801c6c <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
	return ;
  802012:	90                   	nop
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 04             	sub    $0x4,%esp
  80201b:	8b 45 14             	mov    0x14(%ebp),%eax
  80201e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802021:	8b 55 18             	mov    0x18(%ebp),%edx
  802024:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802028:	52                   	push   %edx
  802029:	50                   	push   %eax
  80202a:	ff 75 10             	pushl  0x10(%ebp)
  80202d:	ff 75 0c             	pushl  0xc(%ebp)
  802030:	ff 75 08             	pushl  0x8(%ebp)
  802033:	6a 20                	push   $0x20
  802035:	e8 32 fc ff ff       	call   801c6c <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
	return ;
  80203d:	90                   	nop
}
  80203e:	c9                   	leave  
  80203f:	c3                   	ret    

00802040 <chktst>:
void chktst(uint32 n)
{
  802040:	55                   	push   %ebp
  802041:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	ff 75 08             	pushl  0x8(%ebp)
  80204e:	6a 22                	push   $0x22
  802050:	e8 17 fc ff ff       	call   801c6c <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
	return ;
  802058:	90                   	nop
}
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <inctst>:

void inctst()
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 23                	push   $0x23
  80206a:	e8 fd fb ff ff       	call   801c6c <syscall>
  80206f:	83 c4 18             	add    $0x18,%esp
	return ;
  802072:	90                   	nop
}
  802073:	c9                   	leave  
  802074:	c3                   	ret    

00802075 <gettst>:
uint32 gettst()
{
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 24                	push   $0x24
  802084:	e8 e3 fb ff ff       	call   801c6c <syscall>
  802089:	83 c4 18             	add    $0x18,%esp
}
  80208c:	c9                   	leave  
  80208d:	c3                   	ret    

0080208e <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80208e:	55                   	push   %ebp
  80208f:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 25                	push   $0x25
  80209d:	e8 ca fb ff ff       	call   801c6c <syscall>
  8020a2:	83 c4 18             	add    $0x18,%esp
  8020a5:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8020aa:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	ff 75 08             	pushl  0x8(%ebp)
  8020c7:	6a 26                	push   $0x26
  8020c9:	e8 9e fb ff ff       	call   801c6c <syscall>
  8020ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d1:	90                   	nop
}
  8020d2:	c9                   	leave  
  8020d3:	c3                   	ret    

008020d4 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020d4:	55                   	push   %ebp
  8020d5:	89 e5                	mov    %esp,%ebp
  8020d7:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020d8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e4:	6a 00                	push   $0x0
  8020e6:	53                   	push   %ebx
  8020e7:	51                   	push   %ecx
  8020e8:	52                   	push   %edx
  8020e9:	50                   	push   %eax
  8020ea:	6a 27                	push   $0x27
  8020ec:	e8 7b fb ff ff       	call   801c6c <syscall>
  8020f1:	83 c4 18             	add    $0x18,%esp
}
  8020f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8020f7:	c9                   	leave  
  8020f8:	c3                   	ret    

008020f9 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8020f9:	55                   	push   %ebp
  8020fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8020fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	52                   	push   %edx
  802109:	50                   	push   %eax
  80210a:	6a 28                	push   $0x28
  80210c:	e8 5b fb ff ff       	call   801c6c <syscall>
  802111:	83 c4 18             	add    $0x18,%esp
}
  802114:	c9                   	leave  
  802115:	c3                   	ret    

00802116 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802116:	55                   	push   %ebp
  802117:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802119:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80211c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211f:	8b 45 08             	mov    0x8(%ebp),%eax
  802122:	6a 00                	push   $0x0
  802124:	51                   	push   %ecx
  802125:	ff 75 10             	pushl  0x10(%ebp)
  802128:	52                   	push   %edx
  802129:	50                   	push   %eax
  80212a:	6a 29                	push   $0x29
  80212c:	e8 3b fb ff ff       	call   801c6c <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	ff 75 10             	pushl  0x10(%ebp)
  802140:	ff 75 0c             	pushl  0xc(%ebp)
  802143:	ff 75 08             	pushl  0x8(%ebp)
  802146:	6a 12                	push   $0x12
  802148:	e8 1f fb ff ff       	call   801c6c <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
	return ;
  802150:	90                   	nop
}
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802156:	8b 55 0c             	mov    0xc(%ebp),%edx
  802159:	8b 45 08             	mov    0x8(%ebp),%eax
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	52                   	push   %edx
  802163:	50                   	push   %eax
  802164:	6a 2a                	push   $0x2a
  802166:	e8 01 fb ff ff       	call   801c6c <syscall>
  80216b:	83 c4 18             	add    $0x18,%esp
	return;
  80216e:	90                   	nop
}
  80216f:	c9                   	leave  
  802170:	c3                   	ret    

00802171 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802171:	55                   	push   %ebp
  802172:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 2b                	push   $0x2b
  802180:	e8 e7 fa ff ff       	call   801c6c <syscall>
  802185:	83 c4 18             	add    $0x18,%esp
}
  802188:	c9                   	leave  
  802189:	c3                   	ret    

0080218a <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80218a:	55                   	push   %ebp
  80218b:	89 e5                	mov    %esp,%ebp
  80218d:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802190:	83 ec 04             	sub    $0x4,%esp
  802193:	68 f8 2e 80 00       	push   $0x802ef8
  802198:	68 0a 01 00 00       	push   $0x10a
  80219d:	68 08 2f 80 00       	push   $0x802f08
  8021a2:	e8 ea e7 ff ff       	call   800991 <_panic>

008021a7 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8021a7:	55                   	push   %ebp
  8021a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	ff 75 0c             	pushl  0xc(%ebp)
  8021b3:	ff 75 08             	pushl  0x8(%ebp)
  8021b6:	6a 33                	push   $0x33
  8021b8:	e8 af fa ff ff       	call   801c6c <syscall>
  8021bd:	83 c4 18             	add    $0x18,%esp
	return;
  8021c0:	90                   	nop
}
  8021c1:	c9                   	leave  
  8021c2:	c3                   	ret    

008021c3 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8021c3:	55                   	push   %ebp
  8021c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	ff 75 0c             	pushl  0xc(%ebp)
  8021cf:	ff 75 08             	pushl  0x8(%ebp)
  8021d2:	6a 34                	push   $0x34
  8021d4:	e8 93 fa ff ff       	call   801c6c <syscall>
  8021d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021dc:	90                   	nop
}
  8021dd:	c9                   	leave  
  8021de:	c3                   	ret    

008021df <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8021df:	55                   	push   %ebp
  8021e0:	89 e5                	mov    %esp,%ebp
  8021e2:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8021e5:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8021ec:	eb 36                	jmp    802224 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8021ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021f1:	c1 e0 04             	shl    $0x4,%eax
  8021f4:	05 60 30 80 00       	add    $0x803060,%eax
  8021f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8021ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802202:	c1 e0 04             	shl    $0x4,%eax
  802205:	05 64 30 80 00       	add    $0x803064,%eax
  80220a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802210:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802213:	c1 e0 04             	shl    $0x4,%eax
  802216:	05 6c 30 80 00       	add    $0x80306c,%eax
  80221b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802221:	ff 45 fc             	incl   -0x4(%ebp)
  802224:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802228:	7e c4                	jle    8021ee <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  80222a:	90                   	nop
  80222b:	c9                   	leave  
  80222c:	c3                   	ret    

0080222d <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  80222d:	55                   	push   %ebp
  80222e:	89 e5                	mov    %esp,%ebp
  802230:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802233:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  80223a:	eb 24                	jmp    802260 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  80223c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80223f:	c1 e0 04             	shl    $0x4,%eax
  802242:	05 6c 30 80 00       	add    $0x80306c,%eax
  802247:	8b 00                	mov    (%eax),%eax
  802249:	83 ec 04             	sub    $0x4,%esp
  80224c:	50                   	push   %eax
  80224d:	ff 75 f4             	pushl  -0xc(%ebp)
  802250:	68 18 2f 80 00       	push   $0x802f18
  802255:	e8 05 ea ff ff       	call   800c5f <cprintf>
  80225a:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80225d:	ff 45 f4             	incl   -0xc(%ebp)
  802260:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  802264:	7e d6                	jle    80223c <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802266:	90                   	nop
  802267:	c9                   	leave  
  802268:	c3                   	ret    

00802269 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802269:	55                   	push   %ebp
  80226a:	89 e5                	mov    %esp,%ebp
  80226c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  80226f:	83 ec 04             	sub    $0x4,%esp
  802272:	68 28 2f 80 00       	push   $0x802f28
  802277:	6a 33                	push   $0x33
  802279:	68 49 2f 80 00       	push   $0x802f49
  80227e:	e8 0e e7 ff ff       	call   800991 <_panic>

00802283 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  802283:	55                   	push   %ebp
  802284:	89 e5                	mov    %esp,%ebp
  802286:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802289:	83 ec 04             	sub    $0x4,%esp
  80228c:	68 61 2f 80 00       	push   $0x802f61
  802291:	6a 3e                	push   $0x3e
  802293:	68 49 2f 80 00       	push   $0x802f49
  802298:	e8 f4 e6 ff ff       	call   800991 <_panic>

0080229d <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  80229d:	55                   	push   %ebp
  80229e:	89 e5                	mov    %esp,%ebp
  8022a0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8022a3:	83 ec 04             	sub    $0x4,%esp
  8022a6:	68 7f 2f 80 00       	push   $0x802f7f
  8022ab:	6a 49                	push   $0x49
  8022ad:	68 49 2f 80 00       	push   $0x802f49
  8022b2:	e8 da e6 ff ff       	call   800991 <_panic>

008022b7 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8022b7:	55                   	push   %ebp
  8022b8:	89 e5                	mov    %esp,%ebp
  8022ba:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8022bd:	83 ec 04             	sub    $0x4,%esp
  8022c0:	68 9c 2f 80 00       	push   $0x802f9c
  8022c5:	6a 58                	push   $0x58
  8022c7:	68 49 2f 80 00       	push   $0x802f49
  8022cc:	e8 c0 e6 ff ff       	call   800991 <_panic>
  8022d1:	66 90                	xchg   %ax,%ax
  8022d3:	90                   	nop

008022d4 <__udivdi3>:
  8022d4:	55                   	push   %ebp
  8022d5:	57                   	push   %edi
  8022d6:	56                   	push   %esi
  8022d7:	53                   	push   %ebx
  8022d8:	83 ec 1c             	sub    $0x1c,%esp
  8022db:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022df:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022eb:	89 ca                	mov    %ecx,%edx
  8022ed:	89 f8                	mov    %edi,%eax
  8022ef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022f3:	85 f6                	test   %esi,%esi
  8022f5:	75 2d                	jne    802324 <__udivdi3+0x50>
  8022f7:	39 cf                	cmp    %ecx,%edi
  8022f9:	77 65                	ja     802360 <__udivdi3+0x8c>
  8022fb:	89 fd                	mov    %edi,%ebp
  8022fd:	85 ff                	test   %edi,%edi
  8022ff:	75 0b                	jne    80230c <__udivdi3+0x38>
  802301:	b8 01 00 00 00       	mov    $0x1,%eax
  802306:	31 d2                	xor    %edx,%edx
  802308:	f7 f7                	div    %edi
  80230a:	89 c5                	mov    %eax,%ebp
  80230c:	31 d2                	xor    %edx,%edx
  80230e:	89 c8                	mov    %ecx,%eax
  802310:	f7 f5                	div    %ebp
  802312:	89 c1                	mov    %eax,%ecx
  802314:	89 d8                	mov    %ebx,%eax
  802316:	f7 f5                	div    %ebp
  802318:	89 cf                	mov    %ecx,%edi
  80231a:	89 fa                	mov    %edi,%edx
  80231c:	83 c4 1c             	add    $0x1c,%esp
  80231f:	5b                   	pop    %ebx
  802320:	5e                   	pop    %esi
  802321:	5f                   	pop    %edi
  802322:	5d                   	pop    %ebp
  802323:	c3                   	ret    
  802324:	39 ce                	cmp    %ecx,%esi
  802326:	77 28                	ja     802350 <__udivdi3+0x7c>
  802328:	0f bd fe             	bsr    %esi,%edi
  80232b:	83 f7 1f             	xor    $0x1f,%edi
  80232e:	75 40                	jne    802370 <__udivdi3+0x9c>
  802330:	39 ce                	cmp    %ecx,%esi
  802332:	72 0a                	jb     80233e <__udivdi3+0x6a>
  802334:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802338:	0f 87 9e 00 00 00    	ja     8023dc <__udivdi3+0x108>
  80233e:	b8 01 00 00 00       	mov    $0x1,%eax
  802343:	89 fa                	mov    %edi,%edx
  802345:	83 c4 1c             	add    $0x1c,%esp
  802348:	5b                   	pop    %ebx
  802349:	5e                   	pop    %esi
  80234a:	5f                   	pop    %edi
  80234b:	5d                   	pop    %ebp
  80234c:	c3                   	ret    
  80234d:	8d 76 00             	lea    0x0(%esi),%esi
  802350:	31 ff                	xor    %edi,%edi
  802352:	31 c0                	xor    %eax,%eax
  802354:	89 fa                	mov    %edi,%edx
  802356:	83 c4 1c             	add    $0x1c,%esp
  802359:	5b                   	pop    %ebx
  80235a:	5e                   	pop    %esi
  80235b:	5f                   	pop    %edi
  80235c:	5d                   	pop    %ebp
  80235d:	c3                   	ret    
  80235e:	66 90                	xchg   %ax,%ax
  802360:	89 d8                	mov    %ebx,%eax
  802362:	f7 f7                	div    %edi
  802364:	31 ff                	xor    %edi,%edi
  802366:	89 fa                	mov    %edi,%edx
  802368:	83 c4 1c             	add    $0x1c,%esp
  80236b:	5b                   	pop    %ebx
  80236c:	5e                   	pop    %esi
  80236d:	5f                   	pop    %edi
  80236e:	5d                   	pop    %ebp
  80236f:	c3                   	ret    
  802370:	bd 20 00 00 00       	mov    $0x20,%ebp
  802375:	89 eb                	mov    %ebp,%ebx
  802377:	29 fb                	sub    %edi,%ebx
  802379:	89 f9                	mov    %edi,%ecx
  80237b:	d3 e6                	shl    %cl,%esi
  80237d:	89 c5                	mov    %eax,%ebp
  80237f:	88 d9                	mov    %bl,%cl
  802381:	d3 ed                	shr    %cl,%ebp
  802383:	89 e9                	mov    %ebp,%ecx
  802385:	09 f1                	or     %esi,%ecx
  802387:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80238b:	89 f9                	mov    %edi,%ecx
  80238d:	d3 e0                	shl    %cl,%eax
  80238f:	89 c5                	mov    %eax,%ebp
  802391:	89 d6                	mov    %edx,%esi
  802393:	88 d9                	mov    %bl,%cl
  802395:	d3 ee                	shr    %cl,%esi
  802397:	89 f9                	mov    %edi,%ecx
  802399:	d3 e2                	shl    %cl,%edx
  80239b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80239f:	88 d9                	mov    %bl,%cl
  8023a1:	d3 e8                	shr    %cl,%eax
  8023a3:	09 c2                	or     %eax,%edx
  8023a5:	89 d0                	mov    %edx,%eax
  8023a7:	89 f2                	mov    %esi,%edx
  8023a9:	f7 74 24 0c          	divl   0xc(%esp)
  8023ad:	89 d6                	mov    %edx,%esi
  8023af:	89 c3                	mov    %eax,%ebx
  8023b1:	f7 e5                	mul    %ebp
  8023b3:	39 d6                	cmp    %edx,%esi
  8023b5:	72 19                	jb     8023d0 <__udivdi3+0xfc>
  8023b7:	74 0b                	je     8023c4 <__udivdi3+0xf0>
  8023b9:	89 d8                	mov    %ebx,%eax
  8023bb:	31 ff                	xor    %edi,%edi
  8023bd:	e9 58 ff ff ff       	jmp    80231a <__udivdi3+0x46>
  8023c2:	66 90                	xchg   %ax,%ax
  8023c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023c8:	89 f9                	mov    %edi,%ecx
  8023ca:	d3 e2                	shl    %cl,%edx
  8023cc:	39 c2                	cmp    %eax,%edx
  8023ce:	73 e9                	jae    8023b9 <__udivdi3+0xe5>
  8023d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023d3:	31 ff                	xor    %edi,%edi
  8023d5:	e9 40 ff ff ff       	jmp    80231a <__udivdi3+0x46>
  8023da:	66 90                	xchg   %ax,%ax
  8023dc:	31 c0                	xor    %eax,%eax
  8023de:	e9 37 ff ff ff       	jmp    80231a <__udivdi3+0x46>
  8023e3:	90                   	nop

008023e4 <__umoddi3>:
  8023e4:	55                   	push   %ebp
  8023e5:	57                   	push   %edi
  8023e6:	56                   	push   %esi
  8023e7:	53                   	push   %ebx
  8023e8:	83 ec 1c             	sub    $0x1c,%esp
  8023eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802403:	89 f3                	mov    %esi,%ebx
  802405:	89 fa                	mov    %edi,%edx
  802407:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80240b:	89 34 24             	mov    %esi,(%esp)
  80240e:	85 c0                	test   %eax,%eax
  802410:	75 1a                	jne    80242c <__umoddi3+0x48>
  802412:	39 f7                	cmp    %esi,%edi
  802414:	0f 86 a2 00 00 00    	jbe    8024bc <__umoddi3+0xd8>
  80241a:	89 c8                	mov    %ecx,%eax
  80241c:	89 f2                	mov    %esi,%edx
  80241e:	f7 f7                	div    %edi
  802420:	89 d0                	mov    %edx,%eax
  802422:	31 d2                	xor    %edx,%edx
  802424:	83 c4 1c             	add    $0x1c,%esp
  802427:	5b                   	pop    %ebx
  802428:	5e                   	pop    %esi
  802429:	5f                   	pop    %edi
  80242a:	5d                   	pop    %ebp
  80242b:	c3                   	ret    
  80242c:	39 f0                	cmp    %esi,%eax
  80242e:	0f 87 ac 00 00 00    	ja     8024e0 <__umoddi3+0xfc>
  802434:	0f bd e8             	bsr    %eax,%ebp
  802437:	83 f5 1f             	xor    $0x1f,%ebp
  80243a:	0f 84 ac 00 00 00    	je     8024ec <__umoddi3+0x108>
  802440:	bf 20 00 00 00       	mov    $0x20,%edi
  802445:	29 ef                	sub    %ebp,%edi
  802447:	89 fe                	mov    %edi,%esi
  802449:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80244d:	89 e9                	mov    %ebp,%ecx
  80244f:	d3 e0                	shl    %cl,%eax
  802451:	89 d7                	mov    %edx,%edi
  802453:	89 f1                	mov    %esi,%ecx
  802455:	d3 ef                	shr    %cl,%edi
  802457:	09 c7                	or     %eax,%edi
  802459:	89 e9                	mov    %ebp,%ecx
  80245b:	d3 e2                	shl    %cl,%edx
  80245d:	89 14 24             	mov    %edx,(%esp)
  802460:	89 d8                	mov    %ebx,%eax
  802462:	d3 e0                	shl    %cl,%eax
  802464:	89 c2                	mov    %eax,%edx
  802466:	8b 44 24 08          	mov    0x8(%esp),%eax
  80246a:	d3 e0                	shl    %cl,%eax
  80246c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802470:	8b 44 24 08          	mov    0x8(%esp),%eax
  802474:	89 f1                	mov    %esi,%ecx
  802476:	d3 e8                	shr    %cl,%eax
  802478:	09 d0                	or     %edx,%eax
  80247a:	d3 eb                	shr    %cl,%ebx
  80247c:	89 da                	mov    %ebx,%edx
  80247e:	f7 f7                	div    %edi
  802480:	89 d3                	mov    %edx,%ebx
  802482:	f7 24 24             	mull   (%esp)
  802485:	89 c6                	mov    %eax,%esi
  802487:	89 d1                	mov    %edx,%ecx
  802489:	39 d3                	cmp    %edx,%ebx
  80248b:	0f 82 87 00 00 00    	jb     802518 <__umoddi3+0x134>
  802491:	0f 84 91 00 00 00    	je     802528 <__umoddi3+0x144>
  802497:	8b 54 24 04          	mov    0x4(%esp),%edx
  80249b:	29 f2                	sub    %esi,%edx
  80249d:	19 cb                	sbb    %ecx,%ebx
  80249f:	89 d8                	mov    %ebx,%eax
  8024a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024a5:	d3 e0                	shl    %cl,%eax
  8024a7:	89 e9                	mov    %ebp,%ecx
  8024a9:	d3 ea                	shr    %cl,%edx
  8024ab:	09 d0                	or     %edx,%eax
  8024ad:	89 e9                	mov    %ebp,%ecx
  8024af:	d3 eb                	shr    %cl,%ebx
  8024b1:	89 da                	mov    %ebx,%edx
  8024b3:	83 c4 1c             	add    $0x1c,%esp
  8024b6:	5b                   	pop    %ebx
  8024b7:	5e                   	pop    %esi
  8024b8:	5f                   	pop    %edi
  8024b9:	5d                   	pop    %ebp
  8024ba:	c3                   	ret    
  8024bb:	90                   	nop
  8024bc:	89 fd                	mov    %edi,%ebp
  8024be:	85 ff                	test   %edi,%edi
  8024c0:	75 0b                	jne    8024cd <__umoddi3+0xe9>
  8024c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024c7:	31 d2                	xor    %edx,%edx
  8024c9:	f7 f7                	div    %edi
  8024cb:	89 c5                	mov    %eax,%ebp
  8024cd:	89 f0                	mov    %esi,%eax
  8024cf:	31 d2                	xor    %edx,%edx
  8024d1:	f7 f5                	div    %ebp
  8024d3:	89 c8                	mov    %ecx,%eax
  8024d5:	f7 f5                	div    %ebp
  8024d7:	89 d0                	mov    %edx,%eax
  8024d9:	e9 44 ff ff ff       	jmp    802422 <__umoddi3+0x3e>
  8024de:	66 90                	xchg   %ax,%ax
  8024e0:	89 c8                	mov    %ecx,%eax
  8024e2:	89 f2                	mov    %esi,%edx
  8024e4:	83 c4 1c             	add    $0x1c,%esp
  8024e7:	5b                   	pop    %ebx
  8024e8:	5e                   	pop    %esi
  8024e9:	5f                   	pop    %edi
  8024ea:	5d                   	pop    %ebp
  8024eb:	c3                   	ret    
  8024ec:	3b 04 24             	cmp    (%esp),%eax
  8024ef:	72 06                	jb     8024f7 <__umoddi3+0x113>
  8024f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024f5:	77 0f                	ja     802506 <__umoddi3+0x122>
  8024f7:	89 f2                	mov    %esi,%edx
  8024f9:	29 f9                	sub    %edi,%ecx
  8024fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024ff:	89 14 24             	mov    %edx,(%esp)
  802502:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802506:	8b 44 24 04          	mov    0x4(%esp),%eax
  80250a:	8b 14 24             	mov    (%esp),%edx
  80250d:	83 c4 1c             	add    $0x1c,%esp
  802510:	5b                   	pop    %ebx
  802511:	5e                   	pop    %esi
  802512:	5f                   	pop    %edi
  802513:	5d                   	pop    %ebp
  802514:	c3                   	ret    
  802515:	8d 76 00             	lea    0x0(%esi),%esi
  802518:	2b 04 24             	sub    (%esp),%eax
  80251b:	19 fa                	sbb    %edi,%edx
  80251d:	89 d1                	mov    %edx,%ecx
  80251f:	89 c6                	mov    %eax,%esi
  802521:	e9 71 ff ff ff       	jmp    802497 <__umoddi3+0xb3>
  802526:	66 90                	xchg   %ax,%ax
  802528:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80252c:	72 ea                	jb     802518 <__umoddi3+0x134>
  80252e:	89 d9                	mov    %ebx,%ecx
  802530:	e9 62 ff ff ff       	jmp    802497 <__umoddi3+0xb3>
