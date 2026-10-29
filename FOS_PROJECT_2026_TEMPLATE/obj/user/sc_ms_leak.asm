
obj/user/sc_ms_leak:     file format elf32-i386


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
  800031:	e8 05 07 00 00       	call   80073b <libmain>
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
		//2012: lock the interrupt
		sys_lock_cons();
  80004b:	e8 95 1c 00 00       	call   801ce5 <sys_lock_cons>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 40 25 80 00       	push   $0x802540
  800058:	e8 0c 0c 00 00       	call   800c69 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 42 25 80 00       	push   $0x802542
  800068:	e8 fc 0b 00 00       	call   800c69 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 58 25 80 00       	push   $0x802558
  800078:	e8 ec 0b 00 00       	call   800c69 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 42 25 80 00       	push   $0x802542
  800088:	e8 dc 0b 00 00       	call   800c69 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 40 25 80 00       	push   $0x802540
  800098:	e8 cc 0b 00 00       	call   800c69 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 100000;
  8000a0:	c7 45 ec a0 86 01 00 	movl   $0x186a0,-0x14(%ebp)
		cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  8000a7:	83 ec 08             	sub    $0x8,%esp
  8000aa:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ad:	68 70 25 80 00       	push   $0x802570
  8000b2:	e8 b2 0b 00 00       	call   800c69 <cprintf>
  8000b7:	83 c4 10             	add    $0x10,%esp

		cprintf("Chose the initialization method:\n") ;
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	68 94 25 80 00       	push   $0x802594
  8000c2:	e8 a2 0b 00 00       	call   800c69 <cprintf>
  8000c7:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000ca:	83 ec 0c             	sub    $0xc,%esp
  8000cd:	68 b6 25 80 00       	push   $0x8025b6
  8000d2:	e8 92 0b 00 00       	call   800c69 <cprintf>
  8000d7:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000da:	83 ec 0c             	sub    $0xc,%esp
  8000dd:	68 c4 25 80 00       	push   $0x8025c4
  8000e2:	e8 82 0b 00 00       	call   800c69 <cprintf>
  8000e7:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000ea:	83 ec 0c             	sub    $0xc,%esp
  8000ed:	68 d3 25 80 00       	push   $0x8025d3
  8000f2:	e8 72 0b 00 00       	call   800c69 <cprintf>
  8000f7:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	68 e3 25 80 00       	push   $0x8025e3
  800102:	e8 62 0b 00 00       	call   800c69 <cprintf>
  800107:	83 c4 10             	add    $0x10,%esp
			Chose = 'c' ;
  80010a:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80010e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	50                   	push   %eax
  800116:	e8 de 05 00 00       	call   8006f9 <cputchar>
  80011b:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	6a 0a                	push   $0xa
  800123:	e8 d1 05 00 00       	call   8006f9 <cputchar>
  800128:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80012b:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80012f:	74 0c                	je     80013d <_main+0x105>
  800131:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800135:	74 06                	je     80013d <_main+0x105>
  800137:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80013b:	75 bd                	jne    8000fa <_main+0xc2>

		//2012: lock the interrupt
		sys_unlock_cons();
  80013d:	e8 bd 1b 00 00       	call   801cff <sys_unlock_cons>

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800142:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800145:	c1 e0 02             	shl    $0x2,%eax
  800148:	83 ec 0c             	sub    $0xc,%esp
  80014b:	50                   	push   %eax
  80014c:	e8 70 1a 00 00       	call   801bc1 <malloc>
  800151:	83 c4 10             	add    $0x10,%esp
  800154:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int  i ;
		switch (Chose)
  800157:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80015b:	83 f8 62             	cmp    $0x62,%eax
  80015e:	74 1d                	je     80017d <_main+0x145>
  800160:	83 f8 63             	cmp    $0x63,%eax
  800163:	74 2b                	je     800190 <_main+0x158>
  800165:	83 f8 61             	cmp    $0x61,%eax
  800168:	75 39                	jne    8001a3 <_main+0x16b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80016a:	83 ec 08             	sub    $0x8,%esp
  80016d:	ff 75 ec             	pushl  -0x14(%ebp)
  800170:	ff 75 e8             	pushl  -0x18(%ebp)
  800173:	e8 e7 01 00 00       	call   80035f <InitializeAscending>
  800178:	83 c4 10             	add    $0x10,%esp
			break ;
  80017b:	eb 37                	jmp    8001b4 <_main+0x17c>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  80017d:	83 ec 08             	sub    $0x8,%esp
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	ff 75 e8             	pushl  -0x18(%ebp)
  800186:	e8 05 02 00 00       	call   800390 <InitializeIdentical>
  80018b:	83 c4 10             	add    $0x10,%esp
			break ;
  80018e:	eb 24                	jmp    8001b4 <_main+0x17c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800190:	83 ec 08             	sub    $0x8,%esp
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	ff 75 e8             	pushl  -0x18(%ebp)
  800199:	e8 27 02 00 00       	call   8003c5 <InitializeSemiRandom>
  80019e:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a1:	eb 11                	jmp    8001b4 <_main+0x17c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a3:	83 ec 08             	sub    $0x8,%esp
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ac:	e8 14 02 00 00       	call   8003c5 <InitializeSemiRandom>
  8001b1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001b4:	83 ec 04             	sub    $0x4,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	6a 01                	push   $0x1
  8001bc:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bf:	e8 e0 02 00 00       	call   8004a4 <MSort>
  8001c4:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001c7:	e8 19 1b 00 00       	call   801ce5 <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	68 ec 25 80 00       	push   $0x8025ec
  8001d4:	e8 90 0a 00 00       	call   800c69 <cprintf>
  8001d9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  8001dc:	e8 1e 1b 00 00       	call   801cff <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e1:	83 ec 08             	sub    $0x8,%esp
  8001e4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ea:	e8 c6 00 00 00       	call   8002b5 <CheckSorted>
  8001ef:	83 c4 10             	add    $0x10,%esp
  8001f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8001f9:	75 14                	jne    80020f <_main+0x1d7>
  8001fb:	83 ec 04             	sub    $0x4,%esp
  8001fe:	68 20 26 80 00       	push   $0x802620
  800203:	6a 4e                	push   $0x4e
  800205:	68 42 26 80 00       	push   $0x802642
  80020a:	e8 8c 07 00 00       	call   80099b <_panic>
		else
		{
			sys_lock_cons();
  80020f:	e8 d1 1a 00 00       	call   801ce5 <sys_lock_cons>
			cprintf("===============================================\n") ;
  800214:	83 ec 0c             	sub    $0xc,%esp
  800217:	68 54 26 80 00       	push   $0x802654
  80021c:	e8 48 0a 00 00       	call   800c69 <cprintf>
  800221:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 88 26 80 00       	push   $0x802688
  80022c:	e8 38 0a 00 00       	call   800c69 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 bc 26 80 00       	push   $0x8026bc
  80023c:	e8 28 0a 00 00       	call   800c69 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  800244:	e8 b6 1a 00 00       	call   801cff <sys_unlock_cons>
		}

		//free(Elements) ;

		sys_lock_cons();
  800249:	e8 97 1a 00 00       	call   801ce5 <sys_lock_cons>
		Chose = 0 ;
  80024e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800252:	eb 3e                	jmp    800292 <_main+0x25a>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	68 ee 26 80 00       	push   $0x8026ee
  80025c:	e8 08 0a 00 00       	call   800c69 <cprintf>
  800261:	83 c4 10             	add    $0x10,%esp
			Chose = 'n' ;
  800264:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  800268:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	50                   	push   %eax
  800270:	e8 84 04 00 00       	call   8006f9 <cputchar>
  800275:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800278:	83 ec 0c             	sub    $0xc,%esp
  80027b:	6a 0a                	push   $0xa
  80027d:	e8 77 04 00 00       	call   8006f9 <cputchar>
  800282:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	6a 0a                	push   $0xa
  80028a:	e8 6a 04 00 00       	call   8006f9 <cputchar>
  80028f:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_lock_cons();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800292:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800296:	74 06                	je     80029e <_main+0x266>
  800298:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80029c:	75 b6                	jne    800254 <_main+0x21c>
			Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_unlock_cons();
  80029e:	e8 5c 1a 00 00       	call   801cff <sys_unlock_cons>

	} while (Chose == 'y');
  8002a3:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a7:	0f 84 9b fd ff ff    	je     800048 <_main+0x10>

	//To indicate that it's completed successfully
	inctst();
  8002ad:	e8 b3 1d 00 00       	call   802065 <inctst>

}
  8002b2:	90                   	nop
  8002b3:	c9                   	leave  
  8002b4:	c3                   	ret    

008002b5 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002b5:	55                   	push   %ebp
  8002b6:	89 e5                	mov    %esp,%ebp
  8002b8:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002bb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002c9:	eb 33                	jmp    8002fe <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d8:	01 d0                	add    %edx,%eax
  8002da:	8b 10                	mov    (%eax),%edx
  8002dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002df:	40                   	inc    %eax
  8002e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ea:	01 c8                	add    %ecx,%eax
  8002ec:	8b 00                	mov    (%eax),%eax
  8002ee:	39 c2                	cmp    %eax,%edx
  8002f0:	7e 09                	jle    8002fb <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8002f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8002f9:	eb 0c                	jmp    800307 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002fb:	ff 45 f8             	incl   -0x8(%ebp)
  8002fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800301:	48                   	dec    %eax
  800302:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800305:	7f c4                	jg     8002cb <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800307:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80030a:	c9                   	leave  
  80030b:	c3                   	ret    

0080030c <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80030c:	55                   	push   %ebp
  80030d:	89 e5                	mov    %esp,%ebp
  80030f:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800312:	8b 45 0c             	mov    0xc(%ebp),%eax
  800315:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031c:	8b 45 08             	mov    0x8(%ebp),%eax
  80031f:	01 d0                	add    %edx,%eax
  800321:	8b 00                	mov    (%eax),%eax
  800323:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800326:	8b 45 0c             	mov    0xc(%ebp),%eax
  800329:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800330:	8b 45 08             	mov    0x8(%ebp),%eax
  800333:	01 c2                	add    %eax,%edx
  800335:	8b 45 10             	mov    0x10(%ebp),%eax
  800338:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c8                	add    %ecx,%eax
  800344:	8b 00                	mov    (%eax),%eax
  800346:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800348:	8b 45 10             	mov    0x10(%ebp),%eax
  80034b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800352:	8b 45 08             	mov    0x8(%ebp),%eax
  800355:	01 c2                	add    %eax,%edx
  800357:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80035a:	89 02                	mov    %eax,(%edx)
}
  80035c:	90                   	nop
  80035d:	c9                   	leave  
  80035e:	c3                   	ret    

0080035f <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80035f:	55                   	push   %ebp
  800360:	89 e5                	mov    %esp,%ebp
  800362:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80036c:	eb 17                	jmp    800385 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80036e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800371:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	01 c2                	add    %eax,%edx
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	ff 45 fc             	incl   -0x4(%ebp)
  800385:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800388:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80038b:	7c e1                	jl     80036e <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80038d:	90                   	nop
  80038e:	c9                   	leave  
  80038f:	c3                   	ret    

00800390 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800390:	55                   	push   %ebp
  800391:	89 e5                	mov    %esp,%ebp
  800393:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800396:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80039d:	eb 1b                	jmp    8003ba <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80039f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	01 c2                	add    %eax,%edx
  8003ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b1:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003b4:	48                   	dec    %eax
  8003b5:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b7:	ff 45 fc             	incl   -0x4(%ebp)
  8003ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c0:	7c dd                	jl     80039f <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003c2:	90                   	nop
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003cb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003ce:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003d3:	f7 e9                	imul   %ecx
  8003d5:	c1 f9 1f             	sar    $0x1f,%ecx
  8003d8:	89 d0                	mov    %edx,%eax
  8003da:	29 c8                	sub    %ecx,%eax
  8003dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8003df:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8003e3:	75 07                	jne    8003ec <InitializeSemiRandom+0x27>
			Repetition = 3;
  8003e5:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f3:	eb 1e                	jmp    800413 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8003f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800402:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	99                   	cltd   
  800409:	f7 7d f8             	idivl  -0x8(%ebp)
  80040c:	89 d0                	mov    %edx,%eax
  80040e:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800410:	ff 45 fc             	incl   -0x4(%ebp)
  800413:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800416:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800419:	7c da                	jl     8003f5 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041b:	90                   	nop
  80041c:	c9                   	leave  
  80041d:	c3                   	ret    

0080041e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80041e:	55                   	push   %ebp
  80041f:	89 e5                	mov    %esp,%ebp
  800421:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800424:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800432:	eb 42                	jmp    800476 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800434:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800437:	99                   	cltd   
  800438:	f7 7d f0             	idivl  -0x10(%ebp)
  80043b:	89 d0                	mov    %edx,%eax
  80043d:	85 c0                	test   %eax,%eax
  80043f:	75 10                	jne    800451 <PrintElements+0x33>
			cprintf("\n");
  800441:	83 ec 0c             	sub    $0xc,%esp
  800444:	68 40 25 80 00       	push   $0x802540
  800449:	e8 1b 08 00 00       	call   800c69 <cprintf>
  80044e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800451:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800454:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	01 d0                	add    %edx,%eax
  800460:	8b 00                	mov    (%eax),%eax
  800462:	83 ec 08             	sub    $0x8,%esp
  800465:	50                   	push   %eax
  800466:	68 0c 27 80 00       	push   $0x80270c
  80046b:	e8 f9 07 00 00       	call   800c69 <cprintf>
  800470:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800473:	ff 45 f4             	incl   -0xc(%ebp)
  800476:	8b 45 0c             	mov    0xc(%ebp),%eax
  800479:	48                   	dec    %eax
  80047a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047d:	7f b5                	jg     800434 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80047f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800482:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	01 d0                	add    %edx,%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	83 ec 08             	sub    $0x8,%esp
  800493:	50                   	push   %eax
  800494:	68 11 27 80 00       	push   $0x802711
  800499:	e8 cb 07 00 00       	call   800c69 <cprintf>
  80049e:	83 c4 10             	add    $0x10,%esp

}
  8004a1:	90                   	nop
  8004a2:	c9                   	leave  
  8004a3:	c3                   	ret    

008004a4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a4:	55                   	push   %ebp
  8004a5:	89 e5                	mov    %esp,%ebp
  8004a7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ad:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b0:	7d 54                	jge    800506 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b8:	01 d0                	add    %edx,%eax
  8004ba:	89 c2                	mov    %eax,%edx
  8004bc:	c1 ea 1f             	shr    $0x1f,%edx
  8004bf:	01 d0                	add    %edx,%eax
  8004c1:	d1 f8                	sar    %eax
  8004c3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c6:	83 ec 04             	sub    $0x4,%esp
  8004c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004cc:	ff 75 0c             	pushl  0xc(%ebp)
  8004cf:	ff 75 08             	pushl  0x8(%ebp)
  8004d2:	e8 cd ff ff ff       	call   8004a4 <MSort>
  8004d7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	40                   	inc    %eax
  8004de:	83 ec 04             	sub    $0x4,%esp
  8004e1:	ff 75 10             	pushl  0x10(%ebp)
  8004e4:	50                   	push   %eax
  8004e5:	ff 75 08             	pushl  0x8(%ebp)
  8004e8:	e8 b7 ff ff ff       	call   8004a4 <MSort>
  8004ed:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f0:	ff 75 10             	pushl  0x10(%ebp)
  8004f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f6:	ff 75 0c             	pushl  0xc(%ebp)
  8004f9:	ff 75 08             	pushl  0x8(%ebp)
  8004fc:	e8 08 00 00 00       	call   800509 <Merge>
  800501:	83 c4 10             	add    $0x10,%esp
  800504:	eb 01                	jmp    800507 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800506:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800507:	c9                   	leave  
  800508:	c3                   	ret    

00800509 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800509:	55                   	push   %ebp
  80050a:	89 e5                	mov    %esp,%ebp
  80050c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80050f:	8b 45 10             	mov    0x10(%ebp),%eax
  800512:	2b 45 0c             	sub    0xc(%ebp),%eax
  800515:	40                   	inc    %eax
  800516:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800519:	8b 45 14             	mov    0x14(%ebp),%eax
  80051c:	2b 45 10             	sub    0x10(%ebp),%eax
  80051f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800522:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800529:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800530:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800533:	c1 e0 02             	shl    $0x2,%eax
  800536:	83 ec 0c             	sub    $0xc,%esp
  800539:	50                   	push   %eax
  80053a:	e8 82 16 00 00       	call   801bc1 <malloc>
  80053f:	83 c4 10             	add    $0x10,%esp
  800542:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800545:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800548:	c1 e0 02             	shl    $0x2,%eax
  80054b:	83 ec 0c             	sub    $0xc,%esp
  80054e:	50                   	push   %eax
  80054f:	e8 6d 16 00 00       	call   801bc1 <malloc>
  800554:	83 c4 10             	add    $0x10,%esp
  800557:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800561:	eb 2f                	jmp    800592 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800563:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800566:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800570:	01 c2                	add    %eax,%edx
  800572:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800575:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800578:	01 c8                	add    %ecx,%eax
  80057a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80057f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800586:	8b 45 08             	mov    0x8(%ebp),%eax
  800589:	01 c8                	add    %ecx,%eax
  80058b:	8b 00                	mov    (%eax),%eax
  80058d:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80058f:	ff 45 ec             	incl   -0x14(%ebp)
  800592:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800595:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800598:	7c c9                	jl     800563 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a1:	eb 2a                	jmp    8005cd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b0:	01 c2                	add    %eax,%edx
  8005b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b8:	01 c8                	add    %ecx,%eax
  8005ba:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	01 c8                	add    %ecx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005ca:	ff 45 e8             	incl   -0x18(%ebp)
  8005cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d3:	7c ce                	jl     8005a3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005db:	e9 0a 01 00 00       	jmp    8006ea <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e6:	0f 8d 95 00 00 00    	jge    800681 <Merge+0x178>
  8005ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ef:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f2:	0f 8d 89 00 00 00    	jge    800681 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800602:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800605:	01 d0                	add    %edx,%eax
  800607:	8b 10                	mov    (%eax),%edx
  800609:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800613:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800616:	01 c8                	add    %ecx,%eax
  800618:	8b 00                	mov    (%eax),%eax
  80061a:	39 c2                	cmp    %eax,%edx
  80061c:	7d 33                	jge    800651 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80061e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800621:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800626:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800633:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800636:	8d 50 01             	lea    0x1(%eax),%edx
  800639:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800643:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800646:	01 d0                	add    %edx,%eax
  800648:	8b 00                	mov    (%eax),%eax
  80064a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064c:	e9 96 00 00 00       	jmp    8006e7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800651:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800654:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800659:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800660:	8b 45 08             	mov    0x8(%ebp),%eax
  800663:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800666:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800669:	8d 50 01             	lea    0x1(%eax),%edx
  80066c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80066f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800676:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800679:	01 d0                	add    %edx,%eax
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80067f:	eb 66                	jmp    8006e7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800681:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800684:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800687:	7d 30                	jge    8006b9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800689:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800691:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80069e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a1:	8d 50 01             	lea    0x1(%eax),%edx
  8006a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b1:	01 d0                	add    %edx,%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	89 01                	mov    %eax,(%ecx)
  8006b7:	eb 2e                	jmp    8006e7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006bc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d1:	8d 50 01             	lea    0x1(%eax),%edx
  8006d4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e1:	01 d0                	add    %edx,%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ed:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f0:	0f 8e ea fe ff ff    	jle    8005e0 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006f6:	90                   	nop
  8006f7:	c9                   	leave  
  8006f8:	c3                   	ret    

008006f9 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006f9:	55                   	push   %ebp
  8006fa:	89 e5                	mov    %esp,%ebp
  8006fc:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800705:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800709:	83 ec 0c             	sub    $0xc,%esp
  80070c:	50                   	push   %eax
  80070d:	e8 1b 17 00 00       	call   801e2d <sys_cputc>
  800712:	83 c4 10             	add    $0x10,%esp
}
  800715:	90                   	nop
  800716:	c9                   	leave  
  800717:	c3                   	ret    

00800718 <getchar>:


int
getchar(void)
{
  800718:	55                   	push   %ebp
  800719:	89 e5                	mov    %esp,%ebp
  80071b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  80071e:	e8 a9 15 00 00       	call   801ccc <sys_cgetc>
  800723:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800726:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80072a:	74 f2                	je     80071e <getchar+0x6>
	return c;
  80072c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80072f:	c9                   	leave  
  800730:	c3                   	ret    

00800731 <iscons>:

int iscons(int fdnum)
{
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800734:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800739:	5d                   	pop    %ebp
  80073a:	c3                   	ret    

0080073b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80073b:	55                   	push   %ebp
  80073c:	89 e5                	mov    %esp,%ebp
  80073e:	57                   	push   %edi
  80073f:	56                   	push   %esi
  800740:	53                   	push   %ebx
  800741:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800747:	e8 11 18 00 00       	call   801f5d <sys_getenvindex>
  80074c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80074f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800752:	89 d0                	mov    %edx,%eax
  800754:	c1 e0 03             	shl    $0x3,%eax
  800757:	01 d0                	add    %edx,%eax
  800759:	c1 e0 06             	shl    $0x6,%eax
  80075c:	01 d0                	add    %edx,%eax
  80075e:	c1 e0 03             	shl    $0x3,%eax
  800761:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800766:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80076b:	a1 24 30 80 00       	mov    0x803024,%eax
  800770:	8a 40 10             	mov    0x10(%eax),%al
  800773:	84 c0                	test   %al,%al
  800775:	74 0d                	je     800784 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800777:	a1 24 30 80 00       	mov    0x803024,%eax
  80077c:	83 c0 10             	add    $0x10,%eax
  80077f:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800784:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800788:	7e 0a                	jle    800794 <libmain+0x59>
		binaryname = argv[0];
  80078a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800794:	83 ec 08             	sub    $0x8,%esp
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	e8 96 f8 ff ff       	call   800038 <_main>
  8007a2:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8007a5:	a1 00 30 80 00       	mov    0x803000,%eax
  8007aa:	85 c0                	test   %eax,%eax
  8007ac:	0f 84 b7 01 00 00    	je     800969 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007b2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007b8:	bb 54 28 80 00       	mov    $0x802854,%ebx
  8007bd:	ba 0e 00 00 00       	mov    $0xe,%edx
  8007c2:	89 c7                	mov    %eax,%edi
  8007c4:	89 de                	mov    %ebx,%esi
  8007c6:	89 d1                	mov    %edx,%ecx
  8007c8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007ca:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8007d0:	b9 56 00 00 00       	mov    $0x56,%ecx
  8007d5:	b0 00                	mov    $0x0,%al
  8007d7:	89 d7                	mov    %edx,%edi
  8007d9:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8007db:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8007e2:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	50                   	push   %eax
  8007e9:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007ef:	50                   	push   %eax
  8007f0:	e8 68 19 00 00       	call   80215d <sys_utilities>
  8007f5:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8007f8:	e8 e8 14 00 00       	call   801ce5 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8007fd:	83 ec 0c             	sub    $0xc,%esp
  800800:	68 30 27 80 00       	push   $0x802730
  800805:	e8 5f 04 00 00       	call   800c69 <cprintf>
  80080a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80080d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800810:	85 c0                	test   %eax,%eax
  800812:	74 58                	je     80086c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800814:	e8 62 19 00 00       	call   80217b <sys_get_optimal_num_faults>
  800819:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80081c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800822:	bb b8 28 80 00       	mov    $0x8028b8,%ebx
  800827:	ba 11 00 00 00       	mov    $0x11,%edx
  80082c:	89 c7                	mov    %eax,%edi
  80082e:	89 de                	mov    %ebx,%esi
  800830:	89 d1                	mov    %edx,%ecx
  800832:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800834:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800837:	b9 53 00 00 00       	mov    $0x53,%ecx
  80083c:	b0 00                	mov    $0x0,%al
  80083e:	89 d7                	mov    %edx,%edi
  800840:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800842:	83 ec 08             	sub    $0x8,%esp
  800845:	ff 75 dc             	pushl  -0x24(%ebp)
  800848:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80084e:	50                   	push   %eax
  80084f:	e8 09 19 00 00       	call   80215d <sys_utilities>
  800854:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800857:	83 ec 08             	sub    $0x8,%esp
  80085a:	ff 75 dc             	pushl  -0x24(%ebp)
  80085d:	68 58 27 80 00       	push   $0x802758
  800862:	e8 02 04 00 00       	call   800c69 <cprintf>
  800867:	83 c4 10             	add    $0x10,%esp
  80086a:	eb 59                	jmp    8008c5 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80086c:	a1 24 30 80 00       	mov    0x803024,%eax
  800871:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800877:	a1 24 30 80 00       	mov    0x803024,%eax
  80087c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800882:	83 ec 04             	sub    $0x4,%esp
  800885:	52                   	push   %edx
  800886:	50                   	push   %eax
  800887:	68 7c 27 80 00       	push   $0x80277c
  80088c:	e8 d8 03 00 00       	call   800c69 <cprintf>
  800891:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800894:	a1 24 30 80 00       	mov    0x803024,%eax
  800899:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80089f:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a4:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008aa:	a1 24 30 80 00       	mov    0x803024,%eax
  8008af:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008b5:	51                   	push   %ecx
  8008b6:	52                   	push   %edx
  8008b7:	50                   	push   %eax
  8008b8:	68 a4 27 80 00       	push   $0x8027a4
  8008bd:	e8 a7 03 00 00       	call   800c69 <cprintf>
  8008c2:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008c5:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ca:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8008d0:	83 ec 08             	sub    $0x8,%esp
  8008d3:	50                   	push   %eax
  8008d4:	68 fc 27 80 00       	push   $0x8027fc
  8008d9:	e8 8b 03 00 00       	call   800c69 <cprintf>
  8008de:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8008e1:	83 ec 0c             	sub    $0xc,%esp
  8008e4:	68 10 28 80 00       	push   $0x802810
  8008e9:	e8 7b 03 00 00       	call   800c69 <cprintf>
  8008ee:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8008f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8008f8:	eb 28                	jmp    800922 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8008fa:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800902:	81 c2 74 04 00 00    	add    $0x474,%edx
  800908:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80090b:	83 ec 04             	sub    $0x4,%esp
  80090e:	50                   	push   %eax
  80090f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800912:	68 27 28 80 00       	push   $0x802827
  800917:	e8 4d 03 00 00       	call   800c69 <cprintf>
  80091c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80091f:	ff 45 e4             	incl   -0x1c(%ebp)
  800922:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800926:	7e d2                	jle    8008fa <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800928:	83 ec 0c             	sub    $0xc,%esp
  80092b:	68 36 28 80 00       	push   $0x802836
  800930:	e8 34 03 00 00       	call   800c69 <cprintf>
  800935:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800938:	a1 24 30 80 00       	mov    0x803024,%eax
  80093d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800943:	83 ec 08             	sub    $0x8,%esp
  800946:	50                   	push   %eax
  800947:	68 3a 28 80 00       	push   $0x80283a
  80094c:	e8 18 03 00 00       	call   800c69 <cprintf>
  800951:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800954:	83 ec 0c             	sub    $0xc,%esp
  800957:	68 30 27 80 00       	push   $0x802730
  80095c:	e8 08 03 00 00       	call   800c69 <cprintf>
  800961:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800964:	e8 96 13 00 00       	call   801cff <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800969:	e8 1f 00 00 00       	call   80098d <exit>
}
  80096e:	90                   	nop
  80096f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800972:	5b                   	pop    %ebx
  800973:	5e                   	pop    %esi
  800974:	5f                   	pop    %edi
  800975:	5d                   	pop    %ebp
  800976:	c3                   	ret    

00800977 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800977:	55                   	push   %ebp
  800978:	89 e5                	mov    %esp,%ebp
  80097a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80097d:	83 ec 0c             	sub    $0xc,%esp
  800980:	6a 00                	push   $0x0
  800982:	e8 a2 15 00 00       	call   801f29 <sys_destroy_env>
  800987:	83 c4 10             	add    $0x10,%esp
}
  80098a:	90                   	nop
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <exit>:

void
exit(void)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800993:	e8 f7 15 00 00       	call   801f8f <sys_exit_env>
}
  800998:	90                   	nop
  800999:	c9                   	leave  
  80099a:	c3                   	ret    

0080099b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80099b:	55                   	push   %ebp
  80099c:	89 e5                	mov    %esp,%ebp
  80099e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009a1:	8d 45 10             	lea    0x10(%ebp),%eax
  8009a4:	83 c0 04             	add    $0x4,%eax
  8009a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009aa:	a1 28 31 80 00       	mov    0x803128,%eax
  8009af:	85 c0                	test   %eax,%eax
  8009b1:	74 16                	je     8009c9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009b3:	a1 28 31 80 00       	mov    0x803128,%eax
  8009b8:	83 ec 08             	sub    $0x8,%esp
  8009bb:	50                   	push   %eax
  8009bc:	68 1c 29 80 00       	push   $0x80291c
  8009c1:	e8 a3 02 00 00       	call   800c69 <cprintf>
  8009c6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8009c9:	a1 04 30 80 00       	mov    0x803004,%eax
  8009ce:	83 ec 0c             	sub    $0xc,%esp
  8009d1:	ff 75 0c             	pushl  0xc(%ebp)
  8009d4:	ff 75 08             	pushl  0x8(%ebp)
  8009d7:	50                   	push   %eax
  8009d8:	68 24 29 80 00       	push   $0x802924
  8009dd:	6a 74                	push   $0x74
  8009df:	e8 b2 02 00 00       	call   800c96 <cprintf_colored>
  8009e4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8009e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f0:	50                   	push   %eax
  8009f1:	e8 04 02 00 00       	call   800bfa <vcprintf>
  8009f6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009f9:	83 ec 08             	sub    $0x8,%esp
  8009fc:	6a 00                	push   $0x0
  8009fe:	68 4c 29 80 00       	push   $0x80294c
  800a03:	e8 f2 01 00 00       	call   800bfa <vcprintf>
  800a08:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a0b:	e8 7d ff ff ff       	call   80098d <exit>

	// should not return here
	while (1) ;
  800a10:	eb fe                	jmp    800a10 <_panic+0x75>

00800a12 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a12:	55                   	push   %ebp
  800a13:	89 e5                	mov    %esp,%ebp
  800a15:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a26:	39 c2                	cmp    %eax,%edx
  800a28:	74 14                	je     800a3e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a2a:	83 ec 04             	sub    $0x4,%esp
  800a2d:	68 50 29 80 00       	push   $0x802950
  800a32:	6a 26                	push   $0x26
  800a34:	68 9c 29 80 00       	push   $0x80299c
  800a39:	e8 5d ff ff ff       	call   80099b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a45:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a4c:	e9 c5 00 00 00       	jmp    800b16 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	01 d0                	add    %edx,%eax
  800a60:	8b 00                	mov    (%eax),%eax
  800a62:	85 c0                	test   %eax,%eax
  800a64:	75 08                	jne    800a6e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a66:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a69:	e9 a5 00 00 00       	jmp    800b13 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a75:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a7c:	eb 69                	jmp    800ae7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a7e:	a1 24 30 80 00       	mov    0x803024,%eax
  800a83:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a89:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a8c:	89 d0                	mov    %edx,%eax
  800a8e:	01 c0                	add    %eax,%eax
  800a90:	01 d0                	add    %edx,%eax
  800a92:	c1 e0 03             	shl    $0x3,%eax
  800a95:	01 c8                	add    %ecx,%eax
  800a97:	8a 40 04             	mov    0x4(%eax),%al
  800a9a:	84 c0                	test   %al,%al
  800a9c:	75 46                	jne    800ae4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a9e:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800aa9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aac:	89 d0                	mov    %edx,%eax
  800aae:	01 c0                	add    %eax,%eax
  800ab0:	01 d0                	add    %edx,%eax
  800ab2:	c1 e0 03             	shl    $0x3,%eax
  800ab5:	01 c8                	add    %ecx,%eax
  800ab7:	8b 00                	mov    (%eax),%eax
  800ab9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800abc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800abf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ac4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	01 c8                	add    %ecx,%eax
  800ad5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ad7:	39 c2                	cmp    %eax,%edx
  800ad9:	75 09                	jne    800ae4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800adb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ae2:	eb 15                	jmp    800af9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ae4:	ff 45 e8             	incl   -0x18(%ebp)
  800ae7:	a1 24 30 80 00       	mov    0x803024,%eax
  800aec:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800af2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800af5:	39 c2                	cmp    %eax,%edx
  800af7:	77 85                	ja     800a7e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800af9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800afd:	75 14                	jne    800b13 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800aff:	83 ec 04             	sub    $0x4,%esp
  800b02:	68 a8 29 80 00       	push   $0x8029a8
  800b07:	6a 3a                	push   $0x3a
  800b09:	68 9c 29 80 00       	push   $0x80299c
  800b0e:	e8 88 fe ff ff       	call   80099b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b13:	ff 45 f0             	incl   -0x10(%ebp)
  800b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b19:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b1c:	0f 8c 2f ff ff ff    	jl     800a51 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b29:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b30:	eb 26                	jmp    800b58 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b32:	a1 24 30 80 00       	mov    0x803024,%eax
  800b37:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b3d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b40:	89 d0                	mov    %edx,%eax
  800b42:	01 c0                	add    %eax,%eax
  800b44:	01 d0                	add    %edx,%eax
  800b46:	c1 e0 03             	shl    $0x3,%eax
  800b49:	01 c8                	add    %ecx,%eax
  800b4b:	8a 40 04             	mov    0x4(%eax),%al
  800b4e:	3c 01                	cmp    $0x1,%al
  800b50:	75 03                	jne    800b55 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b52:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b55:	ff 45 e0             	incl   -0x20(%ebp)
  800b58:	a1 24 30 80 00       	mov    0x803024,%eax
  800b5d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b66:	39 c2                	cmp    %eax,%edx
  800b68:	77 c8                	ja     800b32 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b6d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b70:	74 14                	je     800b86 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800b72:	83 ec 04             	sub    $0x4,%esp
  800b75:	68 fc 29 80 00       	push   $0x8029fc
  800b7a:	6a 44                	push   $0x44
  800b7c:	68 9c 29 80 00       	push   $0x80299c
  800b81:	e8 15 fe ff ff       	call   80099b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b86:	90                   	nop
  800b87:	c9                   	leave  
  800b88:	c3                   	ret    

00800b89 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800b89:	55                   	push   %ebp
  800b8a:	89 e5                	mov    %esp,%ebp
  800b8c:	53                   	push   %ebx
  800b8d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800b90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b93:	8b 00                	mov    (%eax),%eax
  800b95:	8d 48 01             	lea    0x1(%eax),%ecx
  800b98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9b:	89 0a                	mov    %ecx,(%edx)
  800b9d:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba0:	88 d1                	mov    %dl,%cl
  800ba2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bb3:	75 30                	jne    800be5 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800bb5:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800bbb:	a0 40 30 80 00       	mov    0x803040,%al
  800bc0:	0f b6 c0             	movzbl %al,%eax
  800bc3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bc6:	8b 09                	mov    (%ecx),%ecx
  800bc8:	89 cb                	mov    %ecx,%ebx
  800bca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bcd:	83 c1 08             	add    $0x8,%ecx
  800bd0:	52                   	push   %edx
  800bd1:	50                   	push   %eax
  800bd2:	53                   	push   %ebx
  800bd3:	51                   	push   %ecx
  800bd4:	e8 c8 10 00 00       	call   801ca1 <sys_cputs>
  800bd9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800be5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be8:	8b 40 04             	mov    0x4(%eax),%eax
  800beb:	8d 50 01             	lea    0x1(%eax),%edx
  800bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf1:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bf4:	90                   	nop
  800bf5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
  800bfd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c03:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c0a:	00 00 00 
	b.cnt = 0;
  800c0d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c14:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c17:	ff 75 0c             	pushl  0xc(%ebp)
  800c1a:	ff 75 08             	pushl  0x8(%ebp)
  800c1d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c23:	50                   	push   %eax
  800c24:	68 89 0b 80 00       	push   $0x800b89
  800c29:	e8 5a 02 00 00       	call   800e88 <vprintfmt>
  800c2e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c31:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800c37:	a0 40 30 80 00       	mov    0x803040,%al
  800c3c:	0f b6 c0             	movzbl %al,%eax
  800c3f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c45:	52                   	push   %edx
  800c46:	50                   	push   %eax
  800c47:	51                   	push   %ecx
  800c48:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c4e:	83 c0 08             	add    $0x8,%eax
  800c51:	50                   	push   %eax
  800c52:	e8 4a 10 00 00       	call   801ca1 <sys_cputs>
  800c57:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c5a:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800c61:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c67:	c9                   	leave  
  800c68:	c3                   	ret    

00800c69 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c69:	55                   	push   %ebp
  800c6a:	89 e5                	mov    %esp,%ebp
  800c6c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c6f:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800c76:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	83 ec 08             	sub    $0x8,%esp
  800c82:	ff 75 f4             	pushl  -0xc(%ebp)
  800c85:	50                   	push   %eax
  800c86:	e8 6f ff ff ff       	call   800bfa <vcprintf>
  800c8b:	83 c4 10             	add    $0x10,%esp
  800c8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c91:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
  800c99:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c9c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	c1 e0 08             	shl    $0x8,%eax
  800ca9:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800cae:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cb1:	83 c0 04             	add    $0x4,%eax
  800cb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc0:	50                   	push   %eax
  800cc1:	e8 34 ff ff ff       	call   800bfa <vcprintf>
  800cc6:	83 c4 10             	add    $0x10,%esp
  800cc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800ccc:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800cd3:	07 00 00 

	return cnt;
  800cd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cd9:	c9                   	leave  
  800cda:	c3                   	ret    

00800cdb <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800cdb:	55                   	push   %ebp
  800cdc:	89 e5                	mov    %esp,%ebp
  800cde:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800ce1:	e8 ff 0f 00 00       	call   801ce5 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800ce6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ce9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	83 ec 08             	sub    $0x8,%esp
  800cf2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf5:	50                   	push   %eax
  800cf6:	e8 ff fe ff ff       	call   800bfa <vcprintf>
  800cfb:	83 c4 10             	add    $0x10,%esp
  800cfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800d01:	e8 f9 0f 00 00       	call   801cff <sys_unlock_cons>
	return cnt;
  800d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d09:	c9                   	leave  
  800d0a:	c3                   	ret    

00800d0b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
  800d0e:	53                   	push   %ebx
  800d0f:	83 ec 14             	sub    $0x14,%esp
  800d12:	8b 45 10             	mov    0x10(%ebp),%eax
  800d15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d18:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d1e:	8b 45 18             	mov    0x18(%ebp),%eax
  800d21:	ba 00 00 00 00       	mov    $0x0,%edx
  800d26:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d29:	77 55                	ja     800d80 <printnum+0x75>
  800d2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d2e:	72 05                	jb     800d35 <printnum+0x2a>
  800d30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d33:	77 4b                	ja     800d80 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d35:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d38:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d3b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d3e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d43:	52                   	push   %edx
  800d44:	50                   	push   %eax
  800d45:	ff 75 f4             	pushl  -0xc(%ebp)
  800d48:	ff 75 f0             	pushl  -0x10(%ebp)
  800d4b:	e8 8c 15 00 00       	call   8022dc <__udivdi3>
  800d50:	83 c4 10             	add    $0x10,%esp
  800d53:	83 ec 04             	sub    $0x4,%esp
  800d56:	ff 75 20             	pushl  0x20(%ebp)
  800d59:	53                   	push   %ebx
  800d5a:	ff 75 18             	pushl  0x18(%ebp)
  800d5d:	52                   	push   %edx
  800d5e:	50                   	push   %eax
  800d5f:	ff 75 0c             	pushl  0xc(%ebp)
  800d62:	ff 75 08             	pushl  0x8(%ebp)
  800d65:	e8 a1 ff ff ff       	call   800d0b <printnum>
  800d6a:	83 c4 20             	add    $0x20,%esp
  800d6d:	eb 1a                	jmp    800d89 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d6f:	83 ec 08             	sub    $0x8,%esp
  800d72:	ff 75 0c             	pushl  0xc(%ebp)
  800d75:	ff 75 20             	pushl  0x20(%ebp)
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	ff d0                	call   *%eax
  800d7d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d80:	ff 4d 1c             	decl   0x1c(%ebp)
  800d83:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d87:	7f e6                	jg     800d6f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d89:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d8c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d97:	53                   	push   %ebx
  800d98:	51                   	push   %ecx
  800d99:	52                   	push   %edx
  800d9a:	50                   	push   %eax
  800d9b:	e8 4c 16 00 00       	call   8023ec <__umoddi3>
  800da0:	83 c4 10             	add    $0x10,%esp
  800da3:	05 74 2c 80 00       	add    $0x802c74,%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f be c0             	movsbl %al,%eax
  800dad:	83 ec 08             	sub    $0x8,%esp
  800db0:	ff 75 0c             	pushl  0xc(%ebp)
  800db3:	50                   	push   %eax
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	ff d0                	call   *%eax
  800db9:	83 c4 10             	add    $0x10,%esp
}
  800dbc:	90                   	nop
  800dbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dc0:	c9                   	leave  
  800dc1:	c3                   	ret    

00800dc2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dc2:	55                   	push   %ebp
  800dc3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dc5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dc9:	7e 1c                	jle    800de7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8b 00                	mov    (%eax),%eax
  800dd0:	8d 50 08             	lea    0x8(%eax),%edx
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	89 10                	mov    %edx,(%eax)
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8b 00                	mov    (%eax),%eax
  800ddd:	83 e8 08             	sub    $0x8,%eax
  800de0:	8b 50 04             	mov    0x4(%eax),%edx
  800de3:	8b 00                	mov    (%eax),%eax
  800de5:	eb 40                	jmp    800e27 <getuint+0x65>
	else if (lflag)
  800de7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800deb:	74 1e                	je     800e0b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	8b 00                	mov    (%eax),%eax
  800df2:	8d 50 04             	lea    0x4(%eax),%edx
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	89 10                	mov    %edx,(%eax)
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8b 00                	mov    (%eax),%eax
  800dff:	83 e8 04             	sub    $0x4,%eax
  800e02:	8b 00                	mov    (%eax),%eax
  800e04:	ba 00 00 00 00       	mov    $0x0,%edx
  800e09:	eb 1c                	jmp    800e27 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	8b 00                	mov    (%eax),%eax
  800e10:	8d 50 04             	lea    0x4(%eax),%edx
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	89 10                	mov    %edx,(%eax)
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8b 00                	mov    (%eax),%eax
  800e1d:	83 e8 04             	sub    $0x4,%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e27:	5d                   	pop    %ebp
  800e28:	c3                   	ret    

00800e29 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e29:	55                   	push   %ebp
  800e2a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e2c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e30:	7e 1c                	jle    800e4e <getint+0x25>
		return va_arg(*ap, long long);
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	8d 50 08             	lea    0x8(%eax),%edx
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	89 10                	mov    %edx,(%eax)
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	83 e8 08             	sub    $0x8,%eax
  800e47:	8b 50 04             	mov    0x4(%eax),%edx
  800e4a:	8b 00                	mov    (%eax),%eax
  800e4c:	eb 38                	jmp    800e86 <getint+0x5d>
	else if (lflag)
  800e4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e52:	74 1a                	je     800e6e <getint+0x45>
		return va_arg(*ap, long);
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8b 00                	mov    (%eax),%eax
  800e59:	8d 50 04             	lea    0x4(%eax),%edx
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	89 10                	mov    %edx,(%eax)
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	83 e8 04             	sub    $0x4,%eax
  800e69:	8b 00                	mov    (%eax),%eax
  800e6b:	99                   	cltd   
  800e6c:	eb 18                	jmp    800e86 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8b 00                	mov    (%eax),%eax
  800e73:	8d 50 04             	lea    0x4(%eax),%edx
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	89 10                	mov    %edx,(%eax)
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8b 00                	mov    (%eax),%eax
  800e80:	83 e8 04             	sub    $0x4,%eax
  800e83:	8b 00                	mov    (%eax),%eax
  800e85:	99                   	cltd   
}
  800e86:	5d                   	pop    %ebp
  800e87:	c3                   	ret    

00800e88 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e88:	55                   	push   %ebp
  800e89:	89 e5                	mov    %esp,%ebp
  800e8b:	56                   	push   %esi
  800e8c:	53                   	push   %ebx
  800e8d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e90:	eb 17                	jmp    800ea9 <vprintfmt+0x21>
			if (ch == '\0')
  800e92:	85 db                	test   %ebx,%ebx
  800e94:	0f 84 c1 03 00 00    	je     80125b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	53                   	push   %ebx
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	ff d0                	call   *%eax
  800ea6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ea9:	8b 45 10             	mov    0x10(%ebp),%eax
  800eac:	8d 50 01             	lea    0x1(%eax),%edx
  800eaf:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f b6 d8             	movzbl %al,%ebx
  800eb7:	83 fb 25             	cmp    $0x25,%ebx
  800eba:	75 d6                	jne    800e92 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ebc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ec0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ec7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ece:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ed5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	8d 50 01             	lea    0x1(%eax),%edx
  800ee2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	0f b6 d8             	movzbl %al,%ebx
  800eea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800eed:	83 f8 5b             	cmp    $0x5b,%eax
  800ef0:	0f 87 3d 03 00 00    	ja     801233 <vprintfmt+0x3ab>
  800ef6:	8b 04 85 98 2c 80 00 	mov    0x802c98(,%eax,4),%eax
  800efd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800eff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f03:	eb d7                	jmp    800edc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f05:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f09:	eb d1                	jmp    800edc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f0b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f12:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f15:	89 d0                	mov    %edx,%eax
  800f17:	c1 e0 02             	shl    $0x2,%eax
  800f1a:	01 d0                	add    %edx,%eax
  800f1c:	01 c0                	add    %eax,%eax
  800f1e:	01 d8                	add    %ebx,%eax
  800f20:	83 e8 30             	sub    $0x30,%eax
  800f23:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f26:	8b 45 10             	mov    0x10(%ebp),%eax
  800f29:	8a 00                	mov    (%eax),%al
  800f2b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f2e:	83 fb 2f             	cmp    $0x2f,%ebx
  800f31:	7e 3e                	jle    800f71 <vprintfmt+0xe9>
  800f33:	83 fb 39             	cmp    $0x39,%ebx
  800f36:	7f 39                	jg     800f71 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f38:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f3b:	eb d5                	jmp    800f12 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f40:	83 c0 04             	add    $0x4,%eax
  800f43:	89 45 14             	mov    %eax,0x14(%ebp)
  800f46:	8b 45 14             	mov    0x14(%ebp),%eax
  800f49:	83 e8 04             	sub    $0x4,%eax
  800f4c:	8b 00                	mov    (%eax),%eax
  800f4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f51:	eb 1f                	jmp    800f72 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f57:	79 83                	jns    800edc <vprintfmt+0x54>
				width = 0;
  800f59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f60:	e9 77 ff ff ff       	jmp    800edc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f65:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f6c:	e9 6b ff ff ff       	jmp    800edc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f71:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f76:	0f 89 60 ff ff ff    	jns    800edc <vprintfmt+0x54>
				width = precision, precision = -1;
  800f7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f82:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f89:	e9 4e ff ff ff       	jmp    800edc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f8e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f91:	e9 46 ff ff ff       	jmp    800edc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f96:	8b 45 14             	mov    0x14(%ebp),%eax
  800f99:	83 c0 04             	add    $0x4,%eax
  800f9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa2:	83 e8 04             	sub    $0x4,%eax
  800fa5:	8b 00                	mov    (%eax),%eax
  800fa7:	83 ec 08             	sub    $0x8,%esp
  800faa:	ff 75 0c             	pushl  0xc(%ebp)
  800fad:	50                   	push   %eax
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	ff d0                	call   *%eax
  800fb3:	83 c4 10             	add    $0x10,%esp
			break;
  800fb6:	e9 9b 02 00 00       	jmp    801256 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbe:	83 c0 04             	add    $0x4,%eax
  800fc1:	89 45 14             	mov    %eax,0x14(%ebp)
  800fc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc7:	83 e8 04             	sub    $0x4,%eax
  800fca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fcc:	85 db                	test   %ebx,%ebx
  800fce:	79 02                	jns    800fd2 <vprintfmt+0x14a>
				err = -err;
  800fd0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fd2:	83 fb 64             	cmp    $0x64,%ebx
  800fd5:	7f 0b                	jg     800fe2 <vprintfmt+0x15a>
  800fd7:	8b 34 9d e0 2a 80 00 	mov    0x802ae0(,%ebx,4),%esi
  800fde:	85 f6                	test   %esi,%esi
  800fe0:	75 19                	jne    800ffb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fe2:	53                   	push   %ebx
  800fe3:	68 85 2c 80 00       	push   $0x802c85
  800fe8:	ff 75 0c             	pushl  0xc(%ebp)
  800feb:	ff 75 08             	pushl  0x8(%ebp)
  800fee:	e8 70 02 00 00       	call   801263 <printfmt>
  800ff3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ff6:	e9 5b 02 00 00       	jmp    801256 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ffb:	56                   	push   %esi
  800ffc:	68 8e 2c 80 00       	push   $0x802c8e
  801001:	ff 75 0c             	pushl  0xc(%ebp)
  801004:	ff 75 08             	pushl  0x8(%ebp)
  801007:	e8 57 02 00 00       	call   801263 <printfmt>
  80100c:	83 c4 10             	add    $0x10,%esp
			break;
  80100f:	e9 42 02 00 00       	jmp    801256 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801014:	8b 45 14             	mov    0x14(%ebp),%eax
  801017:	83 c0 04             	add    $0x4,%eax
  80101a:	89 45 14             	mov    %eax,0x14(%ebp)
  80101d:	8b 45 14             	mov    0x14(%ebp),%eax
  801020:	83 e8 04             	sub    $0x4,%eax
  801023:	8b 30                	mov    (%eax),%esi
  801025:	85 f6                	test   %esi,%esi
  801027:	75 05                	jne    80102e <vprintfmt+0x1a6>
				p = "(null)";
  801029:	be 91 2c 80 00       	mov    $0x802c91,%esi
			if (width > 0 && padc != '-')
  80102e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801032:	7e 6d                	jle    8010a1 <vprintfmt+0x219>
  801034:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801038:	74 67                	je     8010a1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80103a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80103d:	83 ec 08             	sub    $0x8,%esp
  801040:	50                   	push   %eax
  801041:	56                   	push   %esi
  801042:	e8 1e 03 00 00       	call   801365 <strnlen>
  801047:	83 c4 10             	add    $0x10,%esp
  80104a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80104d:	eb 16                	jmp    801065 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80104f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801053:	83 ec 08             	sub    $0x8,%esp
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	50                   	push   %eax
  80105a:	8b 45 08             	mov    0x8(%ebp),%eax
  80105d:	ff d0                	call   *%eax
  80105f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801062:	ff 4d e4             	decl   -0x1c(%ebp)
  801065:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801069:	7f e4                	jg     80104f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80106b:	eb 34                	jmp    8010a1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80106d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801071:	74 1c                	je     80108f <vprintfmt+0x207>
  801073:	83 fb 1f             	cmp    $0x1f,%ebx
  801076:	7e 05                	jle    80107d <vprintfmt+0x1f5>
  801078:	83 fb 7e             	cmp    $0x7e,%ebx
  80107b:	7e 12                	jle    80108f <vprintfmt+0x207>
					putch('?', putdat);
  80107d:	83 ec 08             	sub    $0x8,%esp
  801080:	ff 75 0c             	pushl  0xc(%ebp)
  801083:	6a 3f                	push   $0x3f
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	ff d0                	call   *%eax
  80108a:	83 c4 10             	add    $0x10,%esp
  80108d:	eb 0f                	jmp    80109e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80108f:	83 ec 08             	sub    $0x8,%esp
  801092:	ff 75 0c             	pushl  0xc(%ebp)
  801095:	53                   	push   %ebx
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	ff d0                	call   *%eax
  80109b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80109e:	ff 4d e4             	decl   -0x1c(%ebp)
  8010a1:	89 f0                	mov    %esi,%eax
  8010a3:	8d 70 01             	lea    0x1(%eax),%esi
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	0f be d8             	movsbl %al,%ebx
  8010ab:	85 db                	test   %ebx,%ebx
  8010ad:	74 24                	je     8010d3 <vprintfmt+0x24b>
  8010af:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010b3:	78 b8                	js     80106d <vprintfmt+0x1e5>
  8010b5:	ff 4d e0             	decl   -0x20(%ebp)
  8010b8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010bc:	79 af                	jns    80106d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010be:	eb 13                	jmp    8010d3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010c0:	83 ec 08             	sub    $0x8,%esp
  8010c3:	ff 75 0c             	pushl  0xc(%ebp)
  8010c6:	6a 20                	push   $0x20
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	ff d0                	call   *%eax
  8010cd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010d0:	ff 4d e4             	decl   -0x1c(%ebp)
  8010d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010d7:	7f e7                	jg     8010c0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010d9:	e9 78 01 00 00       	jmp    801256 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010de:	83 ec 08             	sub    $0x8,%esp
  8010e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8010e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8010e7:	50                   	push   %eax
  8010e8:	e8 3c fd ff ff       	call   800e29 <getint>
  8010ed:	83 c4 10             	add    $0x10,%esp
  8010f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fc:	85 d2                	test   %edx,%edx
  8010fe:	79 23                	jns    801123 <vprintfmt+0x29b>
				putch('-', putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	6a 2d                	push   $0x2d
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	ff d0                	call   *%eax
  80110d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801110:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801113:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801116:	f7 d8                	neg    %eax
  801118:	83 d2 00             	adc    $0x0,%edx
  80111b:	f7 da                	neg    %edx
  80111d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801120:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801123:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80112a:	e9 bc 00 00 00       	jmp    8011eb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80112f:	83 ec 08             	sub    $0x8,%esp
  801132:	ff 75 e8             	pushl  -0x18(%ebp)
  801135:	8d 45 14             	lea    0x14(%ebp),%eax
  801138:	50                   	push   %eax
  801139:	e8 84 fc ff ff       	call   800dc2 <getuint>
  80113e:	83 c4 10             	add    $0x10,%esp
  801141:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801144:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801147:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80114e:	e9 98 00 00 00       	jmp    8011eb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801153:	83 ec 08             	sub    $0x8,%esp
  801156:	ff 75 0c             	pushl  0xc(%ebp)
  801159:	6a 58                	push   $0x58
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	ff d0                	call   *%eax
  801160:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801163:	83 ec 08             	sub    $0x8,%esp
  801166:	ff 75 0c             	pushl  0xc(%ebp)
  801169:	6a 58                	push   $0x58
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	ff d0                	call   *%eax
  801170:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801173:	83 ec 08             	sub    $0x8,%esp
  801176:	ff 75 0c             	pushl  0xc(%ebp)
  801179:	6a 58                	push   $0x58
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	ff d0                	call   *%eax
  801180:	83 c4 10             	add    $0x10,%esp
			break;
  801183:	e9 ce 00 00 00       	jmp    801256 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801188:	83 ec 08             	sub    $0x8,%esp
  80118b:	ff 75 0c             	pushl  0xc(%ebp)
  80118e:	6a 30                	push   $0x30
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	ff d0                	call   *%eax
  801195:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801198:	83 ec 08             	sub    $0x8,%esp
  80119b:	ff 75 0c             	pushl  0xc(%ebp)
  80119e:	6a 78                	push   $0x78
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	ff d0                	call   *%eax
  8011a5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ab:	83 c0 04             	add    $0x4,%eax
  8011ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8011b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b4:	83 e8 04             	sub    $0x4,%eax
  8011b7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011c3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011ca:	eb 1f                	jmp    8011eb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011cc:	83 ec 08             	sub    $0x8,%esp
  8011cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8011d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8011d5:	50                   	push   %eax
  8011d6:	e8 e7 fb ff ff       	call   800dc2 <getuint>
  8011db:	83 c4 10             	add    $0x10,%esp
  8011de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011e4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011eb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011f2:	83 ec 04             	sub    $0x4,%esp
  8011f5:	52                   	push   %edx
  8011f6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011f9:	50                   	push   %eax
  8011fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8011fd:	ff 75 f0             	pushl  -0x10(%ebp)
  801200:	ff 75 0c             	pushl  0xc(%ebp)
  801203:	ff 75 08             	pushl  0x8(%ebp)
  801206:	e8 00 fb ff ff       	call   800d0b <printnum>
  80120b:	83 c4 20             	add    $0x20,%esp
			break;
  80120e:	eb 46                	jmp    801256 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801210:	83 ec 08             	sub    $0x8,%esp
  801213:	ff 75 0c             	pushl  0xc(%ebp)
  801216:	53                   	push   %ebx
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	ff d0                	call   *%eax
  80121c:	83 c4 10             	add    $0x10,%esp
			break;
  80121f:	eb 35                	jmp    801256 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801221:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  801228:	eb 2c                	jmp    801256 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80122a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  801231:	eb 23                	jmp    801256 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801233:	83 ec 08             	sub    $0x8,%esp
  801236:	ff 75 0c             	pushl  0xc(%ebp)
  801239:	6a 25                	push   $0x25
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	ff d0                	call   *%eax
  801240:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801243:	ff 4d 10             	decl   0x10(%ebp)
  801246:	eb 03                	jmp    80124b <vprintfmt+0x3c3>
  801248:	ff 4d 10             	decl   0x10(%ebp)
  80124b:	8b 45 10             	mov    0x10(%ebp),%eax
  80124e:	48                   	dec    %eax
  80124f:	8a 00                	mov    (%eax),%al
  801251:	3c 25                	cmp    $0x25,%al
  801253:	75 f3                	jne    801248 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801255:	90                   	nop
		}
	}
  801256:	e9 35 fc ff ff       	jmp    800e90 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80125b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80125c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80125f:	5b                   	pop    %ebx
  801260:	5e                   	pop    %esi
  801261:	5d                   	pop    %ebp
  801262:	c3                   	ret    

00801263 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
  801266:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801269:	8d 45 10             	lea    0x10(%ebp),%eax
  80126c:	83 c0 04             	add    $0x4,%eax
  80126f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801272:	8b 45 10             	mov    0x10(%ebp),%eax
  801275:	ff 75 f4             	pushl  -0xc(%ebp)
  801278:	50                   	push   %eax
  801279:	ff 75 0c             	pushl  0xc(%ebp)
  80127c:	ff 75 08             	pushl  0x8(%ebp)
  80127f:	e8 04 fc ff ff       	call   800e88 <vprintfmt>
  801284:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801287:	90                   	nop
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80128d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801290:	8b 40 08             	mov    0x8(%eax),%eax
  801293:	8d 50 01             	lea    0x1(%eax),%edx
  801296:	8b 45 0c             	mov    0xc(%ebp),%eax
  801299:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80129c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129f:	8b 10                	mov    (%eax),%edx
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	8b 40 04             	mov    0x4(%eax),%eax
  8012a7:	39 c2                	cmp    %eax,%edx
  8012a9:	73 12                	jae    8012bd <sprintputch+0x33>
		*b->buf++ = ch;
  8012ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ae:	8b 00                	mov    (%eax),%eax
  8012b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b6:	89 0a                	mov    %ecx,(%edx)
  8012b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8012bb:	88 10                	mov    %dl,(%eax)
}
  8012bd:	90                   	nop
  8012be:	5d                   	pop    %ebp
  8012bf:	c3                   	ret    

008012c0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
  8012c3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	01 d0                	add    %edx,%eax
  8012d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e5:	74 06                	je     8012ed <vsnprintf+0x2d>
  8012e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012eb:	7f 07                	jg     8012f4 <vsnprintf+0x34>
		return -E_INVAL;
  8012ed:	b8 03 00 00 00       	mov    $0x3,%eax
  8012f2:	eb 20                	jmp    801314 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012f4:	ff 75 14             	pushl  0x14(%ebp)
  8012f7:	ff 75 10             	pushl  0x10(%ebp)
  8012fa:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012fd:	50                   	push   %eax
  8012fe:	68 8a 12 80 00       	push   $0x80128a
  801303:	e8 80 fb ff ff       	call   800e88 <vprintfmt>
  801308:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80130b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80130e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801311:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
  801319:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80131c:	8d 45 10             	lea    0x10(%ebp),%eax
  80131f:	83 c0 04             	add    $0x4,%eax
  801322:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801325:	8b 45 10             	mov    0x10(%ebp),%eax
  801328:	ff 75 f4             	pushl  -0xc(%ebp)
  80132b:	50                   	push   %eax
  80132c:	ff 75 0c             	pushl  0xc(%ebp)
  80132f:	ff 75 08             	pushl  0x8(%ebp)
  801332:	e8 89 ff ff ff       	call   8012c0 <vsnprintf>
  801337:	83 c4 10             	add    $0x10,%esp
  80133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80133d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801340:	c9                   	leave  
  801341:	c3                   	ret    

00801342 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
  801345:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801348:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80134f:	eb 06                	jmp    801357 <strlen+0x15>
		n++;
  801351:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801354:	ff 45 08             	incl   0x8(%ebp)
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	84 c0                	test   %al,%al
  80135e:	75 f1                	jne    801351 <strlen+0xf>
		n++;
	return n;
  801360:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
  801368:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80136b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801372:	eb 09                	jmp    80137d <strnlen+0x18>
		n++;
  801374:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801377:	ff 45 08             	incl   0x8(%ebp)
  80137a:	ff 4d 0c             	decl   0xc(%ebp)
  80137d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801381:	74 09                	je     80138c <strnlen+0x27>
  801383:	8b 45 08             	mov    0x8(%ebp),%eax
  801386:	8a 00                	mov    (%eax),%al
  801388:	84 c0                	test   %al,%al
  80138a:	75 e8                	jne    801374 <strnlen+0xf>
		n++;
	return n;
  80138c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
  801394:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80139d:	90                   	nop
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8d 50 01             	lea    0x1(%eax),%edx
  8013a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013b0:	8a 12                	mov    (%edx),%dl
  8013b2:	88 10                	mov    %dl,(%eax)
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	84 c0                	test   %al,%al
  8013b8:	75 e4                	jne    80139e <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
  8013c2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d2:	eb 1f                	jmp    8013f3 <strncpy+0x34>
		*dst++ = *src;
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8d 50 01             	lea    0x1(%eax),%edx
  8013da:	89 55 08             	mov    %edx,0x8(%ebp)
  8013dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e0:	8a 12                	mov    (%edx),%dl
  8013e2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	84 c0                	test   %al,%al
  8013eb:	74 03                	je     8013f0 <strncpy+0x31>
			src++;
  8013ed:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013f0:	ff 45 fc             	incl   -0x4(%ebp)
  8013f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f9:	72 d9                	jb     8013d4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013fe:	c9                   	leave  
  8013ff:	c3                   	ret    

00801400 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801400:	55                   	push   %ebp
  801401:	89 e5                	mov    %esp,%ebp
  801403:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80140c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801410:	74 30                	je     801442 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801412:	eb 16                	jmp    80142a <strlcpy+0x2a>
			*dst++ = *src++;
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	8d 50 01             	lea    0x1(%eax),%edx
  80141a:	89 55 08             	mov    %edx,0x8(%ebp)
  80141d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801420:	8d 4a 01             	lea    0x1(%edx),%ecx
  801423:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801426:	8a 12                	mov    (%edx),%dl
  801428:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80142a:	ff 4d 10             	decl   0x10(%ebp)
  80142d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801431:	74 09                	je     80143c <strlcpy+0x3c>
  801433:	8b 45 0c             	mov    0xc(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	84 c0                	test   %al,%al
  80143a:	75 d8                	jne    801414 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801442:	8b 55 08             	mov    0x8(%ebp),%edx
  801445:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801448:	29 c2                	sub    %eax,%edx
  80144a:	89 d0                	mov    %edx,%eax
}
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801451:	eb 06                	jmp    801459 <strcmp+0xb>
		p++, q++;
  801453:	ff 45 08             	incl   0x8(%ebp)
  801456:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	84 c0                	test   %al,%al
  801460:	74 0e                	je     801470 <strcmp+0x22>
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 10                	mov    (%eax),%dl
  801467:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	38 c2                	cmp    %al,%dl
  80146e:	74 e3                	je     801453 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801470:	8b 45 08             	mov    0x8(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	0f b6 d0             	movzbl %al,%edx
  801478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	0f b6 c0             	movzbl %al,%eax
  801480:	29 c2                	sub    %eax,%edx
  801482:	89 d0                	mov    %edx,%eax
}
  801484:	5d                   	pop    %ebp
  801485:	c3                   	ret    

00801486 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801489:	eb 09                	jmp    801494 <strncmp+0xe>
		n--, p++, q++;
  80148b:	ff 4d 10             	decl   0x10(%ebp)
  80148e:	ff 45 08             	incl   0x8(%ebp)
  801491:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801494:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801498:	74 17                	je     8014b1 <strncmp+0x2b>
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	8a 00                	mov    (%eax),%al
  80149f:	84 c0                	test   %al,%al
  8014a1:	74 0e                	je     8014b1 <strncmp+0x2b>
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	8a 10                	mov    (%eax),%dl
  8014a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	38 c2                	cmp    %al,%dl
  8014af:	74 da                	je     80148b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b5:	75 07                	jne    8014be <strncmp+0x38>
		return 0;
  8014b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8014bc:	eb 14                	jmp    8014d2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	8a 00                	mov    (%eax),%al
  8014c3:	0f b6 d0             	movzbl %al,%edx
  8014c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c9:	8a 00                	mov    (%eax),%al
  8014cb:	0f b6 c0             	movzbl %al,%eax
  8014ce:	29 c2                	sub    %eax,%edx
  8014d0:	89 d0                	mov    %edx,%eax
}
  8014d2:	5d                   	pop    %ebp
  8014d3:	c3                   	ret    

008014d4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
  8014d7:	83 ec 04             	sub    $0x4,%esp
  8014da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014e0:	eb 12                	jmp    8014f4 <strchr+0x20>
		if (*s == c)
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014ea:	75 05                	jne    8014f1 <strchr+0x1d>
			return (char *) s;
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	eb 11                	jmp    801502 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014f1:	ff 45 08             	incl   0x8(%ebp)
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	84 c0                	test   %al,%al
  8014fb:	75 e5                	jne    8014e2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	83 ec 04             	sub    $0x4,%esp
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801510:	eb 0d                	jmp    80151f <strfind+0x1b>
		if (*s == c)
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	8a 00                	mov    (%eax),%al
  801517:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80151a:	74 0e                	je     80152a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80151c:	ff 45 08             	incl   0x8(%ebp)
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	8a 00                	mov    (%eax),%al
  801524:	84 c0                	test   %al,%al
  801526:	75 ea                	jne    801512 <strfind+0xe>
  801528:	eb 01                	jmp    80152b <strfind+0x27>
		if (*s == c)
			break;
  80152a:	90                   	nop
	return (char *) s;
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80153c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801540:	76 63                	jbe    8015a5 <memset+0x75>
		uint64 data_block = c;
  801542:	8b 45 0c             	mov    0xc(%ebp),%eax
  801545:	99                   	cltd   
  801546:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801549:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80154c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80154f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801552:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801556:	c1 e0 08             	shl    $0x8,%eax
  801559:	09 45 f0             	or     %eax,-0x10(%ebp)
  80155c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80155f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801562:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801565:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801569:	c1 e0 10             	shl    $0x10,%eax
  80156c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80156f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801572:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801575:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801578:	89 c2                	mov    %eax,%edx
  80157a:	b8 00 00 00 00       	mov    $0x0,%eax
  80157f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801582:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801585:	eb 18                	jmp    80159f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801587:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80158a:	8d 41 08             	lea    0x8(%ecx),%eax
  80158d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801590:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801593:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801596:	89 01                	mov    %eax,(%ecx)
  801598:	89 51 04             	mov    %edx,0x4(%ecx)
  80159b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80159f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015a3:	77 e2                	ja     801587 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8015a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015a9:	74 23                	je     8015ce <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8015ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015b1:	eb 0e                	jmp    8015c1 <memset+0x91>
			*p8++ = (uint8)c;
  8015b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b6:	8d 50 01             	lea    0x1(%eax),%edx
  8015b9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bf:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8015c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ca:	85 c0                	test   %eax,%eax
  8015cc:	75 e5                	jne    8015b3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
  8015d6:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8015d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8015e5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015e9:	76 24                	jbe    80160f <memcpy+0x3c>
		while(n >= 8){
  8015eb:	eb 1c                	jmp    801609 <memcpy+0x36>
			*d64 = *s64;
  8015ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f0:	8b 50 04             	mov    0x4(%eax),%edx
  8015f3:	8b 00                	mov    (%eax),%eax
  8015f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015f8:	89 01                	mov    %eax,(%ecx)
  8015fa:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8015fd:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801601:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801605:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801609:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80160d:	77 de                	ja     8015ed <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80160f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801613:	74 31                	je     801646 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801615:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801618:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80161b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801621:	eb 16                	jmp    801639 <memcpy+0x66>
			*d8++ = *s8++;
  801623:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801626:	8d 50 01             	lea    0x1(%eax),%edx
  801629:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80162c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80162f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801632:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801635:	8a 12                	mov    (%edx),%dl
  801637:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801639:	8b 45 10             	mov    0x10(%ebp),%eax
  80163c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80163f:	89 55 10             	mov    %edx,0x10(%ebp)
  801642:	85 c0                	test   %eax,%eax
  801644:	75 dd                	jne    801623 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
  80164e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801651:	8b 45 0c             	mov    0xc(%ebp),%eax
  801654:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80165d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801660:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801663:	73 50                	jae    8016b5 <memmove+0x6a>
  801665:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801668:	8b 45 10             	mov    0x10(%ebp),%eax
  80166b:	01 d0                	add    %edx,%eax
  80166d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801670:	76 43                	jbe    8016b5 <memmove+0x6a>
		s += n;
  801672:	8b 45 10             	mov    0x10(%ebp),%eax
  801675:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801678:	8b 45 10             	mov    0x10(%ebp),%eax
  80167b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80167e:	eb 10                	jmp    801690 <memmove+0x45>
			*--d = *--s;
  801680:	ff 4d f8             	decl   -0x8(%ebp)
  801683:	ff 4d fc             	decl   -0x4(%ebp)
  801686:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801689:	8a 10                	mov    (%eax),%dl
  80168b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80168e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801690:	8b 45 10             	mov    0x10(%ebp),%eax
  801693:	8d 50 ff             	lea    -0x1(%eax),%edx
  801696:	89 55 10             	mov    %edx,0x10(%ebp)
  801699:	85 c0                	test   %eax,%eax
  80169b:	75 e3                	jne    801680 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80169d:	eb 23                	jmp    8016c2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80169f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a2:	8d 50 01             	lea    0x1(%eax),%edx
  8016a5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016b1:	8a 12                	mov    (%edx),%dl
  8016b3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8016be:	85 c0                	test   %eax,%eax
  8016c0:	75 dd                	jne    80169f <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016d9:	eb 2a                	jmp    801705 <memcmp+0x3e>
		if (*s1 != *s2)
  8016db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016de:	8a 10                	mov    (%eax),%dl
  8016e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e3:	8a 00                	mov    (%eax),%al
  8016e5:	38 c2                	cmp    %al,%dl
  8016e7:	74 16                	je     8016ff <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	0f b6 d0             	movzbl %al,%edx
  8016f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	0f b6 c0             	movzbl %al,%eax
  8016f9:	29 c2                	sub    %eax,%edx
  8016fb:	89 d0                	mov    %edx,%eax
  8016fd:	eb 18                	jmp    801717 <memcmp+0x50>
		s1++, s2++;
  8016ff:	ff 45 fc             	incl   -0x4(%ebp)
  801702:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801705:	8b 45 10             	mov    0x10(%ebp),%eax
  801708:	8d 50 ff             	lea    -0x1(%eax),%edx
  80170b:	89 55 10             	mov    %edx,0x10(%ebp)
  80170e:	85 c0                	test   %eax,%eax
  801710:	75 c9                	jne    8016db <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801712:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801717:	c9                   	leave  
  801718:	c3                   	ret    

00801719 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801719:	55                   	push   %ebp
  80171a:	89 e5                	mov    %esp,%ebp
  80171c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80171f:	8b 55 08             	mov    0x8(%ebp),%edx
  801722:	8b 45 10             	mov    0x10(%ebp),%eax
  801725:	01 d0                	add    %edx,%eax
  801727:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80172a:	eb 15                	jmp    801741 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	0f b6 d0             	movzbl %al,%edx
  801734:	8b 45 0c             	mov    0xc(%ebp),%eax
  801737:	0f b6 c0             	movzbl %al,%eax
  80173a:	39 c2                	cmp    %eax,%edx
  80173c:	74 0d                	je     80174b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80173e:	ff 45 08             	incl   0x8(%ebp)
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801747:	72 e3                	jb     80172c <memfind+0x13>
  801749:	eb 01                	jmp    80174c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80174b:	90                   	nop
	return (void *) s;
  80174c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
  801754:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801757:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80175e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801765:	eb 03                	jmp    80176a <strtol+0x19>
		s++;
  801767:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80176a:	8b 45 08             	mov    0x8(%ebp),%eax
  80176d:	8a 00                	mov    (%eax),%al
  80176f:	3c 20                	cmp    $0x20,%al
  801771:	74 f4                	je     801767 <strtol+0x16>
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	8a 00                	mov    (%eax),%al
  801778:	3c 09                	cmp    $0x9,%al
  80177a:	74 eb                	je     801767 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	8a 00                	mov    (%eax),%al
  801781:	3c 2b                	cmp    $0x2b,%al
  801783:	75 05                	jne    80178a <strtol+0x39>
		s++;
  801785:	ff 45 08             	incl   0x8(%ebp)
  801788:	eb 13                	jmp    80179d <strtol+0x4c>
	else if (*s == '-')
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	8a 00                	mov    (%eax),%al
  80178f:	3c 2d                	cmp    $0x2d,%al
  801791:	75 0a                	jne    80179d <strtol+0x4c>
		s++, neg = 1;
  801793:	ff 45 08             	incl   0x8(%ebp)
  801796:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80179d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a1:	74 06                	je     8017a9 <strtol+0x58>
  8017a3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017a7:	75 20                	jne    8017c9 <strtol+0x78>
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	3c 30                	cmp    $0x30,%al
  8017b0:	75 17                	jne    8017c9 <strtol+0x78>
  8017b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b5:	40                   	inc    %eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	3c 78                	cmp    $0x78,%al
  8017ba:	75 0d                	jne    8017c9 <strtol+0x78>
		s += 2, base = 16;
  8017bc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017c0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017c7:	eb 28                	jmp    8017f1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017cd:	75 15                	jne    8017e4 <strtol+0x93>
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	8a 00                	mov    (%eax),%al
  8017d4:	3c 30                	cmp    $0x30,%al
  8017d6:	75 0c                	jne    8017e4 <strtol+0x93>
		s++, base = 8;
  8017d8:	ff 45 08             	incl   0x8(%ebp)
  8017db:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017e2:	eb 0d                	jmp    8017f1 <strtol+0xa0>
	else if (base == 0)
  8017e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e8:	75 07                	jne    8017f1 <strtol+0xa0>
		base = 10;
  8017ea:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f4:	8a 00                	mov    (%eax),%al
  8017f6:	3c 2f                	cmp    $0x2f,%al
  8017f8:	7e 19                	jle    801813 <strtol+0xc2>
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	8a 00                	mov    (%eax),%al
  8017ff:	3c 39                	cmp    $0x39,%al
  801801:	7f 10                	jg     801813 <strtol+0xc2>
			dig = *s - '0';
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	0f be c0             	movsbl %al,%eax
  80180b:	83 e8 30             	sub    $0x30,%eax
  80180e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801811:	eb 42                	jmp    801855 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	3c 60                	cmp    $0x60,%al
  80181a:	7e 19                	jle    801835 <strtol+0xe4>
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	8a 00                	mov    (%eax),%al
  801821:	3c 7a                	cmp    $0x7a,%al
  801823:	7f 10                	jg     801835 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	8a 00                	mov    (%eax),%al
  80182a:	0f be c0             	movsbl %al,%eax
  80182d:	83 e8 57             	sub    $0x57,%eax
  801830:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801833:	eb 20                	jmp    801855 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 40                	cmp    $0x40,%al
  80183c:	7e 39                	jle    801877 <strtol+0x126>
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	3c 5a                	cmp    $0x5a,%al
  801845:	7f 30                	jg     801877 <strtol+0x126>
			dig = *s - 'A' + 10;
  801847:	8b 45 08             	mov    0x8(%ebp),%eax
  80184a:	8a 00                	mov    (%eax),%al
  80184c:	0f be c0             	movsbl %al,%eax
  80184f:	83 e8 37             	sub    $0x37,%eax
  801852:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801855:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801858:	3b 45 10             	cmp    0x10(%ebp),%eax
  80185b:	7d 19                	jge    801876 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80185d:	ff 45 08             	incl   0x8(%ebp)
  801860:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801863:	0f af 45 10          	imul   0x10(%ebp),%eax
  801867:	89 c2                	mov    %eax,%edx
  801869:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80186c:	01 d0                	add    %edx,%eax
  80186e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801871:	e9 7b ff ff ff       	jmp    8017f1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801876:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801877:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80187b:	74 08                	je     801885 <strtol+0x134>
		*endptr = (char *) s;
  80187d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801880:	8b 55 08             	mov    0x8(%ebp),%edx
  801883:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801885:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801889:	74 07                	je     801892 <strtol+0x141>
  80188b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188e:	f7 d8                	neg    %eax
  801890:	eb 03                	jmp    801895 <strtol+0x144>
  801892:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <ltostr>:

void
ltostr(long value, char *str)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80189d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018af:	79 13                	jns    8018c4 <ltostr+0x2d>
	{
		neg = 1;
  8018b1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018bb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018be:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018c1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018cc:	99                   	cltd   
  8018cd:	f7 f9                	idiv   %ecx
  8018cf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d5:	8d 50 01             	lea    0x1(%eax),%edx
  8018d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018db:	89 c2                	mov    %eax,%edx
  8018dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e0:	01 d0                	add    %edx,%eax
  8018e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018e5:	83 c2 30             	add    $0x30,%edx
  8018e8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018ed:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018f2:	f7 e9                	imul   %ecx
  8018f4:	c1 fa 02             	sar    $0x2,%edx
  8018f7:	89 c8                	mov    %ecx,%eax
  8018f9:	c1 f8 1f             	sar    $0x1f,%eax
  8018fc:	29 c2                	sub    %eax,%edx
  8018fe:	89 d0                	mov    %edx,%eax
  801900:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801903:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801907:	75 bb                	jne    8018c4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801909:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801910:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801913:	48                   	dec    %eax
  801914:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801917:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80191b:	74 3d                	je     80195a <ltostr+0xc3>
		start = 1 ;
  80191d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801924:	eb 34                	jmp    80195a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801926:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801929:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192c:	01 d0                	add    %edx,%eax
  80192e:	8a 00                	mov    (%eax),%al
  801930:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801933:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801936:	8b 45 0c             	mov    0xc(%ebp),%eax
  801939:	01 c2                	add    %eax,%edx
  80193b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80193e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801941:	01 c8                	add    %ecx,%eax
  801943:	8a 00                	mov    (%eax),%al
  801945:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801947:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80194a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194d:	01 c2                	add    %eax,%edx
  80194f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801952:	88 02                	mov    %al,(%edx)
		start++ ;
  801954:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801957:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80195d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801960:	7c c4                	jl     801926 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801962:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801965:	8b 45 0c             	mov    0xc(%ebp),%eax
  801968:	01 d0                	add    %edx,%eax
  80196a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80196d:	90                   	nop
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801976:	ff 75 08             	pushl  0x8(%ebp)
  801979:	e8 c4 f9 ff ff       	call   801342 <strlen>
  80197e:	83 c4 04             	add    $0x4,%esp
  801981:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801984:	ff 75 0c             	pushl  0xc(%ebp)
  801987:	e8 b6 f9 ff ff       	call   801342 <strlen>
  80198c:	83 c4 04             	add    $0x4,%esp
  80198f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801992:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801999:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019a0:	eb 17                	jmp    8019b9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a8:	01 c2                	add    %eax,%edx
  8019aa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	01 c8                	add    %ecx,%eax
  8019b2:	8a 00                	mov    (%eax),%al
  8019b4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019b6:	ff 45 fc             	incl   -0x4(%ebp)
  8019b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019bf:	7c e1                	jl     8019a2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019c8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019cf:	eb 1f                	jmp    8019f0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019d4:	8d 50 01             	lea    0x1(%eax),%edx
  8019d7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019da:	89 c2                	mov    %eax,%edx
  8019dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019df:	01 c2                	add    %eax,%edx
  8019e1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e7:	01 c8                	add    %ecx,%eax
  8019e9:	8a 00                	mov    (%eax),%al
  8019eb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8019ed:	ff 45 f8             	incl   -0x8(%ebp)
  8019f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019f6:	7c d9                	jl     8019d1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019fe:	01 d0                	add    %edx,%eax
  801a00:	c6 00 00             	movb   $0x0,(%eax)
}
  801a03:	90                   	nop
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a09:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a12:	8b 45 14             	mov    0x14(%ebp),%eax
  801a15:	8b 00                	mov    (%eax),%eax
  801a17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a1e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a21:	01 d0                	add    %edx,%eax
  801a23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a29:	eb 0c                	jmp    801a37 <strsplit+0x31>
			*string++ = 0;
  801a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2e:	8d 50 01             	lea    0x1(%eax),%edx
  801a31:	89 55 08             	mov    %edx,0x8(%ebp)
  801a34:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	8a 00                	mov    (%eax),%al
  801a3c:	84 c0                	test   %al,%al
  801a3e:	74 18                	je     801a58 <strsplit+0x52>
  801a40:	8b 45 08             	mov    0x8(%ebp),%eax
  801a43:	8a 00                	mov    (%eax),%al
  801a45:	0f be c0             	movsbl %al,%eax
  801a48:	50                   	push   %eax
  801a49:	ff 75 0c             	pushl  0xc(%ebp)
  801a4c:	e8 83 fa ff ff       	call   8014d4 <strchr>
  801a51:	83 c4 08             	add    $0x8,%esp
  801a54:	85 c0                	test   %eax,%eax
  801a56:	75 d3                	jne    801a2b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a58:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5b:	8a 00                	mov    (%eax),%al
  801a5d:	84 c0                	test   %al,%al
  801a5f:	74 5a                	je     801abb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a61:	8b 45 14             	mov    0x14(%ebp),%eax
  801a64:	8b 00                	mov    (%eax),%eax
  801a66:	83 f8 0f             	cmp    $0xf,%eax
  801a69:	75 07                	jne    801a72 <strsplit+0x6c>
		{
			return 0;
  801a6b:	b8 00 00 00 00       	mov    $0x0,%eax
  801a70:	eb 66                	jmp    801ad8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a72:	8b 45 14             	mov    0x14(%ebp),%eax
  801a75:	8b 00                	mov    (%eax),%eax
  801a77:	8d 48 01             	lea    0x1(%eax),%ecx
  801a7a:	8b 55 14             	mov    0x14(%ebp),%edx
  801a7d:	89 0a                	mov    %ecx,(%edx)
  801a7f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a86:	8b 45 10             	mov    0x10(%ebp),%eax
  801a89:	01 c2                	add    %eax,%edx
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a90:	eb 03                	jmp    801a95 <strsplit+0x8f>
			string++;
  801a92:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a95:	8b 45 08             	mov    0x8(%ebp),%eax
  801a98:	8a 00                	mov    (%eax),%al
  801a9a:	84 c0                	test   %al,%al
  801a9c:	74 8b                	je     801a29 <strsplit+0x23>
  801a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa1:	8a 00                	mov    (%eax),%al
  801aa3:	0f be c0             	movsbl %al,%eax
  801aa6:	50                   	push   %eax
  801aa7:	ff 75 0c             	pushl  0xc(%ebp)
  801aaa:	e8 25 fa ff ff       	call   8014d4 <strchr>
  801aaf:	83 c4 08             	add    $0x8,%esp
  801ab2:	85 c0                	test   %eax,%eax
  801ab4:	74 dc                	je     801a92 <strsplit+0x8c>
			string++;
	}
  801ab6:	e9 6e ff ff ff       	jmp    801a29 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801abb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801abc:	8b 45 14             	mov    0x14(%ebp),%eax
  801abf:	8b 00                	mov    (%eax),%eax
  801ac1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ac8:	8b 45 10             	mov    0x10(%ebp),%eax
  801acb:	01 d0                	add    %edx,%eax
  801acd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ad3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ad8:	c9                   	leave  
  801ad9:	c3                   	ret    

00801ada <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
  801add:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801ae6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801aed:	eb 4a                	jmp    801b39 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801aef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801af2:	8b 45 08             	mov    0x8(%ebp),%eax
  801af5:	01 c2                	add    %eax,%edx
  801af7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afd:	01 c8                	add    %ecx,%eax
  801aff:	8a 00                	mov    (%eax),%al
  801b01:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801b03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b09:	01 d0                	add    %edx,%eax
  801b0b:	8a 00                	mov    (%eax),%al
  801b0d:	3c 40                	cmp    $0x40,%al
  801b0f:	7e 25                	jle    801b36 <str2lower+0x5c>
  801b11:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b17:	01 d0                	add    %edx,%eax
  801b19:	8a 00                	mov    (%eax),%al
  801b1b:	3c 5a                	cmp    $0x5a,%al
  801b1d:	7f 17                	jg     801b36 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801b1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b22:	8b 45 08             	mov    0x8(%ebp),%eax
  801b25:	01 d0                	add    %edx,%eax
  801b27:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b2a:	8b 55 08             	mov    0x8(%ebp),%edx
  801b2d:	01 ca                	add    %ecx,%edx
  801b2f:	8a 12                	mov    (%edx),%dl
  801b31:	83 c2 20             	add    $0x20,%edx
  801b34:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b36:	ff 45 fc             	incl   -0x4(%ebp)
  801b39:	ff 75 0c             	pushl  0xc(%ebp)
  801b3c:	e8 01 f8 ff ff       	call   801342 <strlen>
  801b41:	83 c4 04             	add    $0x4,%esp
  801b44:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b47:	7f a6                	jg     801aef <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b49:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b4c:	c9                   	leave  
  801b4d:	c3                   	ret    

00801b4e <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
  801b51:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801b54:	a1 08 30 80 00       	mov    0x803008,%eax
  801b59:	85 c0                	test   %eax,%eax
  801b5b:	74 2d                	je     801b8a <uheap_init+0x3c>
	{
		buddy_init();
  801b5d:	e8 87 06 00 00       	call   8021e9 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801b62:	e8 31 05 00 00       	call   802098 <sys_get_uheap_strategy>
  801b67:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  801b6c:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801b73:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801b76:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  801b7d:	00 00 80 
		__firstTimeFlag = 0;
  801b80:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801b87:	00 00 00 
	}
}
  801b8a:	90                   	nop
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
  801b90:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801b93:	83 ec 04             	sub    $0x4,%esp
  801b96:	68 08 2e 80 00       	push   $0x802e08
  801b9b:	6a 25                	push   $0x25
  801b9d:	68 39 2e 80 00       	push   $0x802e39
  801ba2:	e8 f4 ed ff ff       	call   80099b <_panic>

00801ba7 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801ba7:	55                   	push   %ebp
  801ba8:	89 e5                	mov    %esp,%ebp
  801baa:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801bad:	83 ec 04             	sub    $0x4,%esp
  801bb0:	68 48 2e 80 00       	push   $0x802e48
  801bb5:	6a 2f                	push   $0x2f
  801bb7:	68 39 2e 80 00       	push   $0x802e39
  801bbc:	e8 da ed ff ff       	call   80099b <_panic>

00801bc1 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
  801bc4:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801bc7:	e8 82 ff ff ff       	call   801b4e <uheap_init>
	if (size == 0) return NULL ;
  801bcc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801bd0:	75 07                	jne    801bd9 <malloc+0x18>
  801bd2:	b8 00 00 00 00       	mov    $0x0,%eax
  801bd7:	eb 14                	jmp    801bed <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801bd9:	83 ec 04             	sub    $0x4,%esp
  801bdc:	68 7c 2e 80 00       	push   $0x802e7c
  801be1:	6a 43                	push   $0x43
  801be3:	68 39 2e 80 00       	push   $0x802e39
  801be8:	e8 ae ed ff ff       	call   80099b <_panic>
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
  801bf2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801bf5:	83 ec 04             	sub    $0x4,%esp
  801bf8:	68 a4 2e 80 00       	push   $0x802ea4
  801bfd:	6a 4e                	push   $0x4e
  801bff:	68 39 2e 80 00       	push   $0x802e39
  801c04:	e8 92 ed ff ff       	call   80099b <_panic>

00801c09 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
  801c0c:	83 ec 18             	sub    $0x18,%esp
  801c0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c12:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c15:	e8 34 ff ff ff       	call   801b4e <uheap_init>
	if (size == 0) return NULL ;
  801c1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c1e:	75 07                	jne    801c27 <smalloc+0x1e>
  801c20:	b8 00 00 00 00       	mov    $0x0,%eax
  801c25:	eb 14                	jmp    801c3b <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801c27:	83 ec 04             	sub    $0x4,%esp
  801c2a:	68 c8 2e 80 00       	push   $0x802ec8
  801c2f:	6a 5f                	push   $0x5f
  801c31:	68 39 2e 80 00       	push   $0x802e39
  801c36:	e8 60 ed ff ff       	call   80099b <_panic>
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
  801c40:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c43:	e8 06 ff ff ff       	call   801b4e <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801c48:	83 ec 04             	sub    $0x4,%esp
  801c4b:	68 f0 2e 80 00       	push   $0x802ef0
  801c50:	6a 6f                	push   $0x6f
  801c52:	68 39 2e 80 00       	push   $0x802e39
  801c57:	e8 3f ed ff ff       	call   80099b <_panic>

00801c5c <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
  801c5f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801c62:	83 ec 04             	sub    $0x4,%esp
  801c65:	68 14 2f 80 00       	push   $0x802f14
  801c6a:	6a 7e                	push   $0x7e
  801c6c:	68 39 2e 80 00       	push   $0x802e39
  801c71:	e8 25 ed ff ff       	call   80099b <_panic>

00801c76 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
  801c79:	57                   	push   %edi
  801c7a:	56                   	push   %esi
  801c7b:	53                   	push   %ebx
  801c7c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c85:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c88:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c8b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c8e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c91:	cd 30                	int    $0x30
  801c93:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c99:	83 c4 10             	add    $0x10,%esp
  801c9c:	5b                   	pop    %ebx
  801c9d:	5e                   	pop    %esi
  801c9e:	5f                   	pop    %edi
  801c9f:	5d                   	pop    %ebp
  801ca0:	c3                   	ret    

00801ca1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
  801ca4:	83 ec 04             	sub    $0x4,%esp
  801ca7:	8b 45 10             	mov    0x10(%ebp),%eax
  801caa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801cad:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cb0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb7:	6a 00                	push   $0x0
  801cb9:	51                   	push   %ecx
  801cba:	52                   	push   %edx
  801cbb:	ff 75 0c             	pushl  0xc(%ebp)
  801cbe:	50                   	push   %eax
  801cbf:	6a 00                	push   $0x0
  801cc1:	e8 b0 ff ff ff       	call   801c76 <syscall>
  801cc6:	83 c4 18             	add    $0x18,%esp
}
  801cc9:	90                   	nop
  801cca:	c9                   	leave  
  801ccb:	c3                   	ret    

00801ccc <sys_cgetc>:

int
sys_cgetc(void)
{
  801ccc:	55                   	push   %ebp
  801ccd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 02                	push   $0x2
  801cdb:	e8 96 ff ff ff       	call   801c76 <syscall>
  801ce0:	83 c4 18             	add    $0x18,%esp
}
  801ce3:	c9                   	leave  
  801ce4:	c3                   	ret    

00801ce5 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 03                	push   $0x3
  801cf4:	e8 7d ff ff ff       	call   801c76 <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
}
  801cfc:	90                   	nop
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 04                	push   $0x4
  801d0e:	e8 63 ff ff ff       	call   801c76 <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	90                   	nop
  801d17:	c9                   	leave  
  801d18:	c3                   	ret    

00801d19 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	52                   	push   %edx
  801d29:	50                   	push   %eax
  801d2a:	6a 08                	push   $0x8
  801d2c:	e8 45 ff ff ff       	call   801c76 <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
}
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
  801d39:	56                   	push   %esi
  801d3a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d3b:	8b 75 18             	mov    0x18(%ebp),%esi
  801d3e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d41:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d47:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4a:	56                   	push   %esi
  801d4b:	53                   	push   %ebx
  801d4c:	51                   	push   %ecx
  801d4d:	52                   	push   %edx
  801d4e:	50                   	push   %eax
  801d4f:	6a 09                	push   $0x9
  801d51:	e8 20 ff ff ff       	call   801c76 <syscall>
  801d56:	83 c4 18             	add    $0x18,%esp
}
  801d59:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d5c:	5b                   	pop    %ebx
  801d5d:	5e                   	pop    %esi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    

00801d60 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	ff 75 08             	pushl  0x8(%ebp)
  801d6e:	6a 0a                	push   $0xa
  801d70:	e8 01 ff ff ff       	call   801c76 <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
}
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	ff 75 0c             	pushl  0xc(%ebp)
  801d86:	ff 75 08             	pushl  0x8(%ebp)
  801d89:	6a 0b                	push   $0xb
  801d8b:	e8 e6 fe ff ff       	call   801c76 <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 0c                	push   $0xc
  801da4:	e8 cd fe ff ff       	call   801c76 <syscall>
  801da9:	83 c4 18             	add    $0x18,%esp
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 0d                	push   $0xd
  801dbd:	e8 b4 fe ff ff       	call   801c76 <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 0e                	push   $0xe
  801dd6:	e8 9b fe ff ff       	call   801c76 <syscall>
  801ddb:	83 c4 18             	add    $0x18,%esp
}
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 0f                	push   $0xf
  801def:	e8 82 fe ff ff       	call   801c76 <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	ff 75 08             	pushl  0x8(%ebp)
  801e07:	6a 10                	push   $0x10
  801e09:	e8 68 fe ff ff       	call   801c76 <syscall>
  801e0e:	83 c4 18             	add    $0x18,%esp
}
  801e11:	c9                   	leave  
  801e12:	c3                   	ret    

00801e13 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 11                	push   $0x11
  801e22:	e8 4f fe ff ff       	call   801c76 <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	90                   	nop
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_cputc>:

void
sys_cputc(const char c)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
  801e30:	83 ec 04             	sub    $0x4,%esp
  801e33:	8b 45 08             	mov    0x8(%ebp),%eax
  801e36:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e39:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	50                   	push   %eax
  801e46:	6a 01                	push   $0x1
  801e48:	e8 29 fe ff ff       	call   801c76 <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
}
  801e50:	90                   	nop
  801e51:	c9                   	leave  
  801e52:	c3                   	ret    

00801e53 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e53:	55                   	push   %ebp
  801e54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 14                	push   $0x14
  801e62:	e8 0f fe ff ff       	call   801c76 <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
}
  801e6a:	90                   	nop
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
  801e70:	83 ec 04             	sub    $0x4,%esp
  801e73:	8b 45 10             	mov    0x10(%ebp),%eax
  801e76:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801e79:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e7c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	6a 00                	push   $0x0
  801e85:	51                   	push   %ecx
  801e86:	52                   	push   %edx
  801e87:	ff 75 0c             	pushl  0xc(%ebp)
  801e8a:	50                   	push   %eax
  801e8b:	6a 15                	push   $0x15
  801e8d:	e8 e4 fd ff ff       	call   801c76 <syscall>
  801e92:	83 c4 18             	add    $0x18,%esp
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801e9a:	8b 55 10             	mov    0x10(%ebp),%edx
  801e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	52                   	push   %edx
  801ea5:	50                   	push   %eax
  801ea6:	ff 75 08             	pushl  0x8(%ebp)
  801ea9:	6a 16                	push   $0x16
  801eab:	e8 c6 fd ff ff       	call   801c76 <syscall>
  801eb0:	83 c4 18             	add    $0x18,%esp
}
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	6a 17                	push   $0x17
  801ec8:	e8 a9 fd ff ff       	call   801c76 <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801ed5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	52                   	push   %edx
  801ee2:	50                   	push   %eax
  801ee3:	6a 18                	push   $0x18
  801ee5:	e8 8c fd ff ff       	call   801c76 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef5:	6a 00                	push   $0x0
  801ef7:	ff 75 14             	pushl  0x14(%ebp)
  801efa:	ff 75 10             	pushl  0x10(%ebp)
  801efd:	ff 75 0c             	pushl  0xc(%ebp)
  801f00:	50                   	push   %eax
  801f01:	6a 19                	push   $0x19
  801f03:	e8 6e fd ff ff       	call   801c76 <syscall>
  801f08:	83 c4 18             	add    $0x18,%esp
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <sys_run_env>:

void sys_run_env(int32 envId)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f10:	8b 45 08             	mov    0x8(%ebp),%eax
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	50                   	push   %eax
  801f1c:	6a 1a                	push   $0x1a
  801f1e:	e8 53 fd ff ff       	call   801c76 <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
}
  801f26:	90                   	nop
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	50                   	push   %eax
  801f38:	6a 1b                	push   $0x1b
  801f3a:	e8 37 fd ff ff       	call   801c76 <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 05                	push   $0x5
  801f53:	e8 1e fd ff ff       	call   801c76 <syscall>
  801f58:	83 c4 18             	add    $0x18,%esp
}
  801f5b:	c9                   	leave  
  801f5c:	c3                   	ret    

00801f5d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f5d:	55                   	push   %ebp
  801f5e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 06                	push   $0x6
  801f6c:	e8 05 fd ff ff       	call   801c76 <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
}
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 07                	push   $0x7
  801f85:	e8 ec fc ff ff       	call   801c76 <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
}
  801f8d:	c9                   	leave  
  801f8e:	c3                   	ret    

00801f8f <sys_exit_env>:


void sys_exit_env(void)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 1c                	push   $0x1c
  801f9e:	e8 d3 fc ff ff       	call   801c76 <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
}
  801fa6:	90                   	nop
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	ff 75 10             	pushl  0x10(%ebp)
  801fb3:	ff 75 0c             	pushl  0xc(%ebp)
  801fb6:	ff 75 08             	pushl  0x8(%ebp)
  801fb9:	6a 13                	push   $0x13
  801fbb:	e8 b6 fc ff ff       	call   801c76 <syscall>
  801fc0:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc3:	90                   	nop
}
  801fc4:	c9                   	leave  
  801fc5:	c3                   	ret    

00801fc6 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 1e                	push   $0x1e
  801fd5:	e8 9c fc ff ff       	call   801c76 <syscall>
  801fda:	83 c4 18             	add    $0x18,%esp
}
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
  801fe2:	83 ec 04             	sub    $0x4,%esp
  801fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801feb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	50                   	push   %eax
  801ff8:	6a 1f                	push   $0x1f
  801ffa:	e8 77 fc ff ff       	call   801c76 <syscall>
  801fff:	83 c4 18             	add    $0x18,%esp
	return ;
  802002:	90                   	nop
}
  802003:	c9                   	leave  
  802004:	c3                   	ret    

00802005 <rsttst>:
void rsttst()
{
  802005:	55                   	push   %ebp
  802006:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 21                	push   $0x21
  802014:	e8 5d fc ff ff       	call   801c76 <syscall>
  802019:	83 c4 18             	add    $0x18,%esp
	return ;
  80201c:	90                   	nop
}
  80201d:	c9                   	leave  
  80201e:	c3                   	ret    

0080201f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80201f:	55                   	push   %ebp
  802020:	89 e5                	mov    %esp,%ebp
  802022:	83 ec 04             	sub    $0x4,%esp
  802025:	8b 45 14             	mov    0x14(%ebp),%eax
  802028:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80202b:	8b 55 18             	mov    0x18(%ebp),%edx
  80202e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802032:	52                   	push   %edx
  802033:	50                   	push   %eax
  802034:	ff 75 10             	pushl  0x10(%ebp)
  802037:	ff 75 0c             	pushl  0xc(%ebp)
  80203a:	ff 75 08             	pushl  0x8(%ebp)
  80203d:	6a 20                	push   $0x20
  80203f:	e8 32 fc ff ff       	call   801c76 <syscall>
  802044:	83 c4 18             	add    $0x18,%esp
	return ;
  802047:	90                   	nop
}
  802048:	c9                   	leave  
  802049:	c3                   	ret    

0080204a <chktst>:
void chktst(uint32 n)
{
  80204a:	55                   	push   %ebp
  80204b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	ff 75 08             	pushl  0x8(%ebp)
  802058:	6a 22                	push   $0x22
  80205a:	e8 17 fc ff ff       	call   801c76 <syscall>
  80205f:	83 c4 18             	add    $0x18,%esp
	return ;
  802062:	90                   	nop
}
  802063:	c9                   	leave  
  802064:	c3                   	ret    

00802065 <inctst>:

void inctst()
{
  802065:	55                   	push   %ebp
  802066:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 23                	push   $0x23
  802074:	e8 fd fb ff ff       	call   801c76 <syscall>
  802079:	83 c4 18             	add    $0x18,%esp
	return ;
  80207c:	90                   	nop
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <gettst>:
uint32 gettst()
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 24                	push   $0x24
  80208e:	e8 e3 fb ff ff       	call   801c76 <syscall>
  802093:	83 c4 18             	add    $0x18,%esp
}
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 25                	push   $0x25
  8020a7:	e8 ca fb ff ff       	call   801c76 <syscall>
  8020ac:	83 c4 18             	add    $0x18,%esp
  8020af:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8020b4:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8020b9:	c9                   	leave  
  8020ba:	c3                   	ret    

008020bb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8020be:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c1:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	ff 75 08             	pushl  0x8(%ebp)
  8020d1:	6a 26                	push   $0x26
  8020d3:	e8 9e fb ff ff       	call   801c76 <syscall>
  8020d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020db:	90                   	nop
}
  8020dc:	c9                   	leave  
  8020dd:	c3                   	ret    

008020de <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020de:	55                   	push   %ebp
  8020df:	89 e5                	mov    %esp,%ebp
  8020e1:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ee:	6a 00                	push   $0x0
  8020f0:	53                   	push   %ebx
  8020f1:	51                   	push   %ecx
  8020f2:	52                   	push   %edx
  8020f3:	50                   	push   %eax
  8020f4:	6a 27                	push   $0x27
  8020f6:	e8 7b fb ff ff       	call   801c76 <syscall>
  8020fb:	83 c4 18             	add    $0x18,%esp
}
  8020fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802106:	8b 55 0c             	mov    0xc(%ebp),%edx
  802109:	8b 45 08             	mov    0x8(%ebp),%eax
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	52                   	push   %edx
  802113:	50                   	push   %eax
  802114:	6a 28                	push   $0x28
  802116:	e8 5b fb ff ff       	call   801c76 <syscall>
  80211b:	83 c4 18             	add    $0x18,%esp
}
  80211e:	c9                   	leave  
  80211f:	c3                   	ret    

00802120 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802120:	55                   	push   %ebp
  802121:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802123:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802126:	8b 55 0c             	mov    0xc(%ebp),%edx
  802129:	8b 45 08             	mov    0x8(%ebp),%eax
  80212c:	6a 00                	push   $0x0
  80212e:	51                   	push   %ecx
  80212f:	ff 75 10             	pushl  0x10(%ebp)
  802132:	52                   	push   %edx
  802133:	50                   	push   %eax
  802134:	6a 29                	push   $0x29
  802136:	e8 3b fb ff ff       	call   801c76 <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
}
  80213e:	c9                   	leave  
  80213f:	c3                   	ret    

00802140 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802140:	55                   	push   %ebp
  802141:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	ff 75 10             	pushl  0x10(%ebp)
  80214a:	ff 75 0c             	pushl  0xc(%ebp)
  80214d:	ff 75 08             	pushl  0x8(%ebp)
  802150:	6a 12                	push   $0x12
  802152:	e8 1f fb ff ff       	call   801c76 <syscall>
  802157:	83 c4 18             	add    $0x18,%esp
	return ;
  80215a:	90                   	nop
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802160:	8b 55 0c             	mov    0xc(%ebp),%edx
  802163:	8b 45 08             	mov    0x8(%ebp),%eax
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	52                   	push   %edx
  80216d:	50                   	push   %eax
  80216e:	6a 2a                	push   $0x2a
  802170:	e8 01 fb ff ff       	call   801c76 <syscall>
  802175:	83 c4 18             	add    $0x18,%esp
	return;
  802178:	90                   	nop
}
  802179:	c9                   	leave  
  80217a:	c3                   	ret    

0080217b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80217b:	55                   	push   %ebp
  80217c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 2b                	push   $0x2b
  80218a:	e8 e7 fa ff ff       	call   801c76 <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
  802197:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80219a:	83 ec 04             	sub    $0x4,%esp
  80219d:	68 38 2f 80 00       	push   $0x802f38
  8021a2:	68 0a 01 00 00       	push   $0x10a
  8021a7:	68 48 2f 80 00       	push   $0x802f48
  8021ac:	e8 ea e7 ff ff       	call   80099b <_panic>

008021b1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	ff 75 0c             	pushl  0xc(%ebp)
  8021bd:	ff 75 08             	pushl  0x8(%ebp)
  8021c0:	6a 33                	push   $0x33
  8021c2:	e8 af fa ff ff       	call   801c76 <syscall>
  8021c7:	83 c4 18             	add    $0x18,%esp
	return;
  8021ca:	90                   	nop
}
  8021cb:	c9                   	leave  
  8021cc:	c3                   	ret    

008021cd <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8021cd:	55                   	push   %ebp
  8021ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	ff 75 0c             	pushl  0xc(%ebp)
  8021d9:	ff 75 08             	pushl  0x8(%ebp)
  8021dc:	6a 34                	push   $0x34
  8021de:	e8 93 fa ff ff       	call   801c76 <syscall>
  8021e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e6:	90                   	nop
}
  8021e7:	c9                   	leave  
  8021e8:	c3                   	ret    

008021e9 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8021e9:	55                   	push   %ebp
  8021ea:	89 e5                	mov    %esp,%ebp
  8021ec:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8021ef:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8021f6:	eb 36                	jmp    80222e <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8021f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021fb:	c1 e0 04             	shl    $0x4,%eax
  8021fe:	05 60 30 80 00       	add    $0x803060,%eax
  802203:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802209:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80220c:	c1 e0 04             	shl    $0x4,%eax
  80220f:	05 64 30 80 00       	add    $0x803064,%eax
  802214:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80221a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80221d:	c1 e0 04             	shl    $0x4,%eax
  802220:	05 6c 30 80 00       	add    $0x80306c,%eax
  802225:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80222b:	ff 45 fc             	incl   -0x4(%ebp)
  80222e:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802232:	7e c4                	jle    8021f8 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802234:	90                   	nop
  802235:	c9                   	leave  
  802236:	c3                   	ret    

00802237 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802237:	55                   	push   %ebp
  802238:	89 e5                	mov    %esp,%ebp
  80223a:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80223d:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802244:	eb 24                	jmp    80226a <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802246:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802249:	c1 e0 04             	shl    $0x4,%eax
  80224c:	05 6c 30 80 00       	add    $0x80306c,%eax
  802251:	8b 00                	mov    (%eax),%eax
  802253:	83 ec 04             	sub    $0x4,%esp
  802256:	50                   	push   %eax
  802257:	ff 75 f4             	pushl  -0xc(%ebp)
  80225a:	68 58 2f 80 00       	push   $0x802f58
  80225f:	e8 05 ea ff ff       	call   800c69 <cprintf>
  802264:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802267:	ff 45 f4             	incl   -0xc(%ebp)
  80226a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80226e:	7e d6                	jle    802246 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802270:	90                   	nop
  802271:	c9                   	leave  
  802272:	c3                   	ret    

00802273 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802273:	55                   	push   %ebp
  802274:	89 e5                	mov    %esp,%ebp
  802276:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802279:	83 ec 04             	sub    $0x4,%esp
  80227c:	68 68 2f 80 00       	push   $0x802f68
  802281:	6a 33                	push   $0x33
  802283:	68 89 2f 80 00       	push   $0x802f89
  802288:	e8 0e e7 ff ff       	call   80099b <_panic>

0080228d <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
  802290:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802293:	83 ec 04             	sub    $0x4,%esp
  802296:	68 a1 2f 80 00       	push   $0x802fa1
  80229b:	6a 3e                	push   $0x3e
  80229d:	68 89 2f 80 00       	push   $0x802f89
  8022a2:	e8 f4 e6 ff ff       	call   80099b <_panic>

008022a7 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8022a7:	55                   	push   %ebp
  8022a8:	89 e5                	mov    %esp,%ebp
  8022aa:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8022ad:	83 ec 04             	sub    $0x4,%esp
  8022b0:	68 bf 2f 80 00       	push   $0x802fbf
  8022b5:	6a 49                	push   $0x49
  8022b7:	68 89 2f 80 00       	push   $0x802f89
  8022bc:	e8 da e6 ff ff       	call   80099b <_panic>

008022c1 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8022c1:	55                   	push   %ebp
  8022c2:	89 e5                	mov    %esp,%ebp
  8022c4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8022c7:	83 ec 04             	sub    $0x4,%esp
  8022ca:	68 dc 2f 80 00       	push   $0x802fdc
  8022cf:	6a 58                	push   $0x58
  8022d1:	68 89 2f 80 00       	push   $0x802f89
  8022d6:	e8 c0 e6 ff ff       	call   80099b <_panic>
  8022db:	90                   	nop

008022dc <__udivdi3>:
  8022dc:	55                   	push   %ebp
  8022dd:	57                   	push   %edi
  8022de:	56                   	push   %esi
  8022df:	53                   	push   %ebx
  8022e0:	83 ec 1c             	sub    $0x1c,%esp
  8022e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022f3:	89 ca                	mov    %ecx,%edx
  8022f5:	89 f8                	mov    %edi,%eax
  8022f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022fb:	85 f6                	test   %esi,%esi
  8022fd:	75 2d                	jne    80232c <__udivdi3+0x50>
  8022ff:	39 cf                	cmp    %ecx,%edi
  802301:	77 65                	ja     802368 <__udivdi3+0x8c>
  802303:	89 fd                	mov    %edi,%ebp
  802305:	85 ff                	test   %edi,%edi
  802307:	75 0b                	jne    802314 <__udivdi3+0x38>
  802309:	b8 01 00 00 00       	mov    $0x1,%eax
  80230e:	31 d2                	xor    %edx,%edx
  802310:	f7 f7                	div    %edi
  802312:	89 c5                	mov    %eax,%ebp
  802314:	31 d2                	xor    %edx,%edx
  802316:	89 c8                	mov    %ecx,%eax
  802318:	f7 f5                	div    %ebp
  80231a:	89 c1                	mov    %eax,%ecx
  80231c:	89 d8                	mov    %ebx,%eax
  80231e:	f7 f5                	div    %ebp
  802320:	89 cf                	mov    %ecx,%edi
  802322:	89 fa                	mov    %edi,%edx
  802324:	83 c4 1c             	add    $0x1c,%esp
  802327:	5b                   	pop    %ebx
  802328:	5e                   	pop    %esi
  802329:	5f                   	pop    %edi
  80232a:	5d                   	pop    %ebp
  80232b:	c3                   	ret    
  80232c:	39 ce                	cmp    %ecx,%esi
  80232e:	77 28                	ja     802358 <__udivdi3+0x7c>
  802330:	0f bd fe             	bsr    %esi,%edi
  802333:	83 f7 1f             	xor    $0x1f,%edi
  802336:	75 40                	jne    802378 <__udivdi3+0x9c>
  802338:	39 ce                	cmp    %ecx,%esi
  80233a:	72 0a                	jb     802346 <__udivdi3+0x6a>
  80233c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802340:	0f 87 9e 00 00 00    	ja     8023e4 <__udivdi3+0x108>
  802346:	b8 01 00 00 00       	mov    $0x1,%eax
  80234b:	89 fa                	mov    %edi,%edx
  80234d:	83 c4 1c             	add    $0x1c,%esp
  802350:	5b                   	pop    %ebx
  802351:	5e                   	pop    %esi
  802352:	5f                   	pop    %edi
  802353:	5d                   	pop    %ebp
  802354:	c3                   	ret    
  802355:	8d 76 00             	lea    0x0(%esi),%esi
  802358:	31 ff                	xor    %edi,%edi
  80235a:	31 c0                	xor    %eax,%eax
  80235c:	89 fa                	mov    %edi,%edx
  80235e:	83 c4 1c             	add    $0x1c,%esp
  802361:	5b                   	pop    %ebx
  802362:	5e                   	pop    %esi
  802363:	5f                   	pop    %edi
  802364:	5d                   	pop    %ebp
  802365:	c3                   	ret    
  802366:	66 90                	xchg   %ax,%ax
  802368:	89 d8                	mov    %ebx,%eax
  80236a:	f7 f7                	div    %edi
  80236c:	31 ff                	xor    %edi,%edi
  80236e:	89 fa                	mov    %edi,%edx
  802370:	83 c4 1c             	add    $0x1c,%esp
  802373:	5b                   	pop    %ebx
  802374:	5e                   	pop    %esi
  802375:	5f                   	pop    %edi
  802376:	5d                   	pop    %ebp
  802377:	c3                   	ret    
  802378:	bd 20 00 00 00       	mov    $0x20,%ebp
  80237d:	89 eb                	mov    %ebp,%ebx
  80237f:	29 fb                	sub    %edi,%ebx
  802381:	89 f9                	mov    %edi,%ecx
  802383:	d3 e6                	shl    %cl,%esi
  802385:	89 c5                	mov    %eax,%ebp
  802387:	88 d9                	mov    %bl,%cl
  802389:	d3 ed                	shr    %cl,%ebp
  80238b:	89 e9                	mov    %ebp,%ecx
  80238d:	09 f1                	or     %esi,%ecx
  80238f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802393:	89 f9                	mov    %edi,%ecx
  802395:	d3 e0                	shl    %cl,%eax
  802397:	89 c5                	mov    %eax,%ebp
  802399:	89 d6                	mov    %edx,%esi
  80239b:	88 d9                	mov    %bl,%cl
  80239d:	d3 ee                	shr    %cl,%esi
  80239f:	89 f9                	mov    %edi,%ecx
  8023a1:	d3 e2                	shl    %cl,%edx
  8023a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023a7:	88 d9                	mov    %bl,%cl
  8023a9:	d3 e8                	shr    %cl,%eax
  8023ab:	09 c2                	or     %eax,%edx
  8023ad:	89 d0                	mov    %edx,%eax
  8023af:	89 f2                	mov    %esi,%edx
  8023b1:	f7 74 24 0c          	divl   0xc(%esp)
  8023b5:	89 d6                	mov    %edx,%esi
  8023b7:	89 c3                	mov    %eax,%ebx
  8023b9:	f7 e5                	mul    %ebp
  8023bb:	39 d6                	cmp    %edx,%esi
  8023bd:	72 19                	jb     8023d8 <__udivdi3+0xfc>
  8023bf:	74 0b                	je     8023cc <__udivdi3+0xf0>
  8023c1:	89 d8                	mov    %ebx,%eax
  8023c3:	31 ff                	xor    %edi,%edi
  8023c5:	e9 58 ff ff ff       	jmp    802322 <__udivdi3+0x46>
  8023ca:	66 90                	xchg   %ax,%ax
  8023cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023d0:	89 f9                	mov    %edi,%ecx
  8023d2:	d3 e2                	shl    %cl,%edx
  8023d4:	39 c2                	cmp    %eax,%edx
  8023d6:	73 e9                	jae    8023c1 <__udivdi3+0xe5>
  8023d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023db:	31 ff                	xor    %edi,%edi
  8023dd:	e9 40 ff ff ff       	jmp    802322 <__udivdi3+0x46>
  8023e2:	66 90                	xchg   %ax,%ax
  8023e4:	31 c0                	xor    %eax,%eax
  8023e6:	e9 37 ff ff ff       	jmp    802322 <__udivdi3+0x46>
  8023eb:	90                   	nop

008023ec <__umoddi3>:
  8023ec:	55                   	push   %ebp
  8023ed:	57                   	push   %edi
  8023ee:	56                   	push   %esi
  8023ef:	53                   	push   %ebx
  8023f0:	83 ec 1c             	sub    $0x1c,%esp
  8023f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802403:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802407:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80240b:	89 f3                	mov    %esi,%ebx
  80240d:	89 fa                	mov    %edi,%edx
  80240f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802413:	89 34 24             	mov    %esi,(%esp)
  802416:	85 c0                	test   %eax,%eax
  802418:	75 1a                	jne    802434 <__umoddi3+0x48>
  80241a:	39 f7                	cmp    %esi,%edi
  80241c:	0f 86 a2 00 00 00    	jbe    8024c4 <__umoddi3+0xd8>
  802422:	89 c8                	mov    %ecx,%eax
  802424:	89 f2                	mov    %esi,%edx
  802426:	f7 f7                	div    %edi
  802428:	89 d0                	mov    %edx,%eax
  80242a:	31 d2                	xor    %edx,%edx
  80242c:	83 c4 1c             	add    $0x1c,%esp
  80242f:	5b                   	pop    %ebx
  802430:	5e                   	pop    %esi
  802431:	5f                   	pop    %edi
  802432:	5d                   	pop    %ebp
  802433:	c3                   	ret    
  802434:	39 f0                	cmp    %esi,%eax
  802436:	0f 87 ac 00 00 00    	ja     8024e8 <__umoddi3+0xfc>
  80243c:	0f bd e8             	bsr    %eax,%ebp
  80243f:	83 f5 1f             	xor    $0x1f,%ebp
  802442:	0f 84 ac 00 00 00    	je     8024f4 <__umoddi3+0x108>
  802448:	bf 20 00 00 00       	mov    $0x20,%edi
  80244d:	29 ef                	sub    %ebp,%edi
  80244f:	89 fe                	mov    %edi,%esi
  802451:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802455:	89 e9                	mov    %ebp,%ecx
  802457:	d3 e0                	shl    %cl,%eax
  802459:	89 d7                	mov    %edx,%edi
  80245b:	89 f1                	mov    %esi,%ecx
  80245d:	d3 ef                	shr    %cl,%edi
  80245f:	09 c7                	or     %eax,%edi
  802461:	89 e9                	mov    %ebp,%ecx
  802463:	d3 e2                	shl    %cl,%edx
  802465:	89 14 24             	mov    %edx,(%esp)
  802468:	89 d8                	mov    %ebx,%eax
  80246a:	d3 e0                	shl    %cl,%eax
  80246c:	89 c2                	mov    %eax,%edx
  80246e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802472:	d3 e0                	shl    %cl,%eax
  802474:	89 44 24 04          	mov    %eax,0x4(%esp)
  802478:	8b 44 24 08          	mov    0x8(%esp),%eax
  80247c:	89 f1                	mov    %esi,%ecx
  80247e:	d3 e8                	shr    %cl,%eax
  802480:	09 d0                	or     %edx,%eax
  802482:	d3 eb                	shr    %cl,%ebx
  802484:	89 da                	mov    %ebx,%edx
  802486:	f7 f7                	div    %edi
  802488:	89 d3                	mov    %edx,%ebx
  80248a:	f7 24 24             	mull   (%esp)
  80248d:	89 c6                	mov    %eax,%esi
  80248f:	89 d1                	mov    %edx,%ecx
  802491:	39 d3                	cmp    %edx,%ebx
  802493:	0f 82 87 00 00 00    	jb     802520 <__umoddi3+0x134>
  802499:	0f 84 91 00 00 00    	je     802530 <__umoddi3+0x144>
  80249f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024a3:	29 f2                	sub    %esi,%edx
  8024a5:	19 cb                	sbb    %ecx,%ebx
  8024a7:	89 d8                	mov    %ebx,%eax
  8024a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024ad:	d3 e0                	shl    %cl,%eax
  8024af:	89 e9                	mov    %ebp,%ecx
  8024b1:	d3 ea                	shr    %cl,%edx
  8024b3:	09 d0                	or     %edx,%eax
  8024b5:	89 e9                	mov    %ebp,%ecx
  8024b7:	d3 eb                	shr    %cl,%ebx
  8024b9:	89 da                	mov    %ebx,%edx
  8024bb:	83 c4 1c             	add    $0x1c,%esp
  8024be:	5b                   	pop    %ebx
  8024bf:	5e                   	pop    %esi
  8024c0:	5f                   	pop    %edi
  8024c1:	5d                   	pop    %ebp
  8024c2:	c3                   	ret    
  8024c3:	90                   	nop
  8024c4:	89 fd                	mov    %edi,%ebp
  8024c6:	85 ff                	test   %edi,%edi
  8024c8:	75 0b                	jne    8024d5 <__umoddi3+0xe9>
  8024ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8024cf:	31 d2                	xor    %edx,%edx
  8024d1:	f7 f7                	div    %edi
  8024d3:	89 c5                	mov    %eax,%ebp
  8024d5:	89 f0                	mov    %esi,%eax
  8024d7:	31 d2                	xor    %edx,%edx
  8024d9:	f7 f5                	div    %ebp
  8024db:	89 c8                	mov    %ecx,%eax
  8024dd:	f7 f5                	div    %ebp
  8024df:	89 d0                	mov    %edx,%eax
  8024e1:	e9 44 ff ff ff       	jmp    80242a <__umoddi3+0x3e>
  8024e6:	66 90                	xchg   %ax,%ax
  8024e8:	89 c8                	mov    %ecx,%eax
  8024ea:	89 f2                	mov    %esi,%edx
  8024ec:	83 c4 1c             	add    $0x1c,%esp
  8024ef:	5b                   	pop    %ebx
  8024f0:	5e                   	pop    %esi
  8024f1:	5f                   	pop    %edi
  8024f2:	5d                   	pop    %ebp
  8024f3:	c3                   	ret    
  8024f4:	3b 04 24             	cmp    (%esp),%eax
  8024f7:	72 06                	jb     8024ff <__umoddi3+0x113>
  8024f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024fd:	77 0f                	ja     80250e <__umoddi3+0x122>
  8024ff:	89 f2                	mov    %esi,%edx
  802501:	29 f9                	sub    %edi,%ecx
  802503:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802507:	89 14 24             	mov    %edx,(%esp)
  80250a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80250e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802512:	8b 14 24             	mov    (%esp),%edx
  802515:	83 c4 1c             	add    $0x1c,%esp
  802518:	5b                   	pop    %ebx
  802519:	5e                   	pop    %esi
  80251a:	5f                   	pop    %edi
  80251b:	5d                   	pop    %ebp
  80251c:	c3                   	ret    
  80251d:	8d 76 00             	lea    0x0(%esi),%esi
  802520:	2b 04 24             	sub    (%esp),%eax
  802523:	19 fa                	sbb    %edi,%edx
  802525:	89 d1                	mov    %edx,%ecx
  802527:	89 c6                	mov    %eax,%esi
  802529:	e9 71 ff ff ff       	jmp    80249f <__umoddi3+0xb3>
  80252e:	66 90                	xchg   %ax,%ax
  802530:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802534:	72 ea                	jb     802520 <__umoddi3+0x134>
  802536:	89 d9                	mov    %ebx,%ecx
  802538:	e9 62 ff ff ff       	jmp    80249f <__umoddi3+0xb3>
