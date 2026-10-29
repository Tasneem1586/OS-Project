
obj/user/ef_mergesort_leakage:     file format elf32-i386


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
  800031:	e8 4e 07 00 00       	call   800784 <libmain>
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
  80004b:	e8 de 1c 00 00       	call   801d2e <sys_lock_cons>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 a0 25 80 00       	push   $0x8025a0
  800058:	e8 55 0c 00 00       	call   800cb2 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 a2 25 80 00       	push   $0x8025a2
  800068:	e8 45 0c 00 00       	call   800cb2 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 b8 25 80 00       	push   $0x8025b8
  800078:	e8 35 0c 00 00       	call   800cb2 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 a2 25 80 00       	push   $0x8025a2
  800088:	e8 25 0c 00 00       	call   800cb2 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 a0 25 80 00       	push   $0x8025a0
  800098:	e8 15 0c 00 00       	call   800cb2 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		cprintf("Enter the number of elements: ");
  8000a0:	83 ec 0c             	sub    $0xc,%esp
  8000a3:	68 d0 25 80 00       	push   $0x8025d0
  8000a8:	e8 05 0c 00 00       	call   800cb2 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp

		int NumOfElements ;

		if (numOfRep == 1)
  8000b0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000b4:	75 09                	jne    8000bf <_main+0x87>
			NumOfElements = 32;
  8000b6:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)
  8000bd:	eb 0d                	jmp    8000cc <_main+0x94>
		else if (numOfRep == 2)
  8000bf:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000c3:	75 07                	jne    8000cc <_main+0x94>
			NumOfElements = 32;
  8000c5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)

		cprintf("%d\n", NumOfElements) ;
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d2:	68 ef 25 80 00       	push   $0x8025ef
  8000d7:	e8 d6 0b 00 00       	call   800cb2 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 1c 1b 00 00       	call   801c0a <malloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 f4 25 80 00       	push   $0x8025f4
  8000fc:	e8 b1 0b 00 00       	call   800cb2 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 16 26 80 00       	push   $0x802616
  80010c:	e8 a1 0b 00 00       	call   800cb2 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 24 26 80 00       	push   $0x802624
  80011c:	e8 91 0b 00 00       	call   800cb2 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 33 26 80 00       	push   $0x802633
  80012c:	e8 81 0b 00 00       	call   800cb2 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 43 26 80 00       	push   $0x802643
  80013c:	e8 71 0b 00 00       	call   800cb2 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  800144:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800148:	75 06                	jne    800150 <_main+0x118>
				Chose = 'a' ;
  80014a:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  80014e:	eb 0a                	jmp    80015a <_main+0x122>
			else if (numOfRep == 2)
  800150:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  800154:	75 04                	jne    80015a <_main+0x122>
				Chose = 'c' ;
  800156:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80015a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	50                   	push   %eax
  800162:	e8 db 05 00 00       	call   800742 <cputchar>
  800167:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	6a 0a                	push   $0xa
  80016f:	e8 ce 05 00 00       	call   800742 <cputchar>
  800174:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800177:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80017b:	74 0c                	je     800189 <_main+0x151>
  80017d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800181:	74 06                	je     800189 <_main+0x151>
  800183:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800187:	75 ab                	jne    800134 <_main+0xfc>

		//2012: lock the interrupt
		sys_unlock_cons();
  800189:	e8 ba 1b 00 00       	call   801d48 <sys_unlock_cons>

		int  i ;
		switch (Chose)
  80018e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800192:	83 f8 62             	cmp    $0x62,%eax
  800195:	74 1d                	je     8001b4 <_main+0x17c>
  800197:	83 f8 63             	cmp    $0x63,%eax
  80019a:	74 2b                	je     8001c7 <_main+0x18f>
  80019c:	83 f8 61             	cmp    $0x61,%eax
  80019f:	75 39                	jne    8001da <_main+0x1a2>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 f9 01 00 00       	call   8003a8 <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 17 02 00 00       	call   8003d9 <InitializeIdentical>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 39 02 00 00       	call   80040e <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 26 02 00 00       	call   80040e <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 f2 02 00 00       	call   8004ed <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001fe:	e8 2b 1b 00 00       	call   801d2e <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	68 4c 26 80 00       	push   $0x80264c
  80020b:	e8 a2 0a 00 00       	call   800cb2 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  800213:	e8 30 1b 00 00       	call   801d48 <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 e8             	pushl  -0x18(%ebp)
  800221:	e8 d8 00 00 00       	call   8002fe <CheckSorted>
  800226:	83 c4 10             	add    $0x10,%esp
  800229:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80022c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800230:	75 14                	jne    800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 80 26 80 00       	push   $0x802680
  80023a:	6a 58                	push   $0x58
  80023c:	68 a2 26 80 00       	push   $0x8026a2
  800241:	e8 9e 07 00 00       	call   8009e4 <_panic>
		else
		{
			sys_lock_cons();
  800246:	e8 e3 1a 00 00       	call   801d2e <sys_lock_cons>
			cprintf("===============================================\n") ;
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 c0 26 80 00       	push   $0x8026c0
  800253:	e8 5a 0a 00 00       	call   800cb2 <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80025b:	83 ec 0c             	sub    $0xc,%esp
  80025e:	68 f4 26 80 00       	push   $0x8026f4
  800263:	e8 4a 0a 00 00       	call   800cb2 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 28 27 80 00       	push   $0x802728
  800273:	e8 3a 0a 00 00       	call   800cb2 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  80027b:	e8 c8 1a 00 00       	call   801d48 <sys_unlock_cons>
		}

		//free(Elements) ;

		sys_lock_cons();
  800280:	e8 a9 1a 00 00       	call   801d2e <sys_lock_cons>
		Chose = 0 ;
  800285:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800289:	eb 50                	jmp    8002db <_main+0x2a3>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  80028b:	83 ec 0c             	sub    $0xc,%esp
  80028e:	68 5a 27 80 00       	push   $0x80275a
  800293:	e8 1a 0a 00 00       	call   800cb2 <cprintf>
  800298:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  80029b:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  80029f:	75 06                	jne    8002a7 <_main+0x26f>
				Chose = 'y' ;
  8002a1:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  8002a5:	eb 0a                	jmp    8002b1 <_main+0x279>
			else if (numOfRep == 2)
  8002a7:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ab:	75 04                	jne    8002b1 <_main+0x279>
				Chose = 'n' ;
  8002ad:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  8002b1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	50                   	push   %eax
  8002b9:	e8 84 04 00 00       	call   800742 <cputchar>
  8002be:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002c1:	83 ec 0c             	sub    $0xc,%esp
  8002c4:	6a 0a                	push   $0xa
  8002c6:	e8 77 04 00 00       	call   800742 <cputchar>
  8002cb:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002ce:	83 ec 0c             	sub    $0xc,%esp
  8002d1:	6a 0a                	push   $0xa
  8002d3:	e8 6a 04 00 00       	call   800742 <cputchar>
  8002d8:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_lock_cons();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  8002db:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002df:	74 06                	je     8002e7 <_main+0x2af>
  8002e1:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002e5:	75 a4                	jne    80028b <_main+0x253>
				Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_unlock_cons();
  8002e7:	e8 5c 1a 00 00       	call   801d48 <sys_unlock_cons>

	} while (Chose == 'y');
  8002ec:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002f0:	0f 84 52 fd ff ff    	je     800048 <_main+0x10>

	//To indicate that it's completed successfully
	inctst();
  8002f6:	e8 b3 1d 00 00       	call   8020ae <inctst>

}
  8002fb:	90                   	nop
  8002fc:	c9                   	leave  
  8002fd:	c3                   	ret    

008002fe <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002fe:	55                   	push   %ebp
  8002ff:	89 e5                	mov    %esp,%ebp
  800301:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800304:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800312:	eb 33                	jmp    800347 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800314:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800317:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031e:	8b 45 08             	mov    0x8(%ebp),%eax
  800321:	01 d0                	add    %edx,%eax
  800323:	8b 10                	mov    (%eax),%edx
  800325:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800328:	40                   	inc    %eax
  800329:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800330:	8b 45 08             	mov    0x8(%ebp),%eax
  800333:	01 c8                	add    %ecx,%eax
  800335:	8b 00                	mov    (%eax),%eax
  800337:	39 c2                	cmp    %eax,%edx
  800339:	7e 09                	jle    800344 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80033b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800342:	eb 0c                	jmp    800350 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800344:	ff 45 f8             	incl   -0x8(%ebp)
  800347:	8b 45 0c             	mov    0xc(%ebp),%eax
  80034a:	48                   	dec    %eax
  80034b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80034e:	7f c4                	jg     800314 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800350:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800353:	c9                   	leave  
  800354:	c3                   	ret    

00800355 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800355:	55                   	push   %ebp
  800356:	89 e5                	mov    %esp,%ebp
  800358:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80035b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800365:	8b 45 08             	mov    0x8(%ebp),%eax
  800368:	01 d0                	add    %edx,%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80036f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800372:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800379:	8b 45 08             	mov    0x8(%ebp),%eax
  80037c:	01 c2                	add    %eax,%edx
  80037e:	8b 45 10             	mov    0x10(%ebp),%eax
  800381:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	01 c8                	add    %ecx,%eax
  80038d:	8b 00                	mov    (%eax),%eax
  80038f:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800391:	8b 45 10             	mov    0x10(%ebp),%eax
  800394:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039b:	8b 45 08             	mov    0x8(%ebp),%eax
  80039e:	01 c2                	add    %eax,%edx
  8003a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a3:	89 02                	mov    %eax,(%edx)
}
  8003a5:	90                   	nop
  8003a6:	c9                   	leave  
  8003a7:	c3                   	ret    

008003a8 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003a8:	55                   	push   %ebp
  8003a9:	89 e5                	mov    %esp,%ebp
  8003ab:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003b5:	eb 17                	jmp    8003ce <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	01 c2                	add    %eax,%edx
  8003c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c9:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003cb:	ff 45 fc             	incl   -0x4(%ebp)
  8003ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003d4:	7c e1                	jl     8003b7 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003d6:	90                   	nop
  8003d7:	c9                   	leave  
  8003d8:	c3                   	ret    

008003d9 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  8003d9:	55                   	push   %ebp
  8003da:	89 e5                	mov    %esp,%ebp
  8003dc:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003e6:	eb 1b                	jmp    800403 <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	01 c2                	add    %eax,%edx
  8003f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fa:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003fd:	48                   	dec    %eax
  8003fe:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800400:	ff 45 fc             	incl   -0x4(%ebp)
  800403:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800406:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800409:	7c dd                	jl     8003e8 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80040b:	90                   	nop
  80040c:	c9                   	leave  
  80040d:	c3                   	ret    

0080040e <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80040e:	55                   	push   %ebp
  80040f:	89 e5                	mov    %esp,%ebp
  800411:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800414:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800417:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80041c:	f7 e9                	imul   %ecx
  80041e:	c1 f9 1f             	sar    $0x1f,%ecx
  800421:	89 d0                	mov    %edx,%eax
  800423:	29 c8                	sub    %ecx,%eax
  800425:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  800428:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80042c:	75 07                	jne    800435 <InitializeSemiRandom+0x27>
			Repetition = 3;
  80042e:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80043c:	eb 1e                	jmp    80045c <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80044e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800451:	99                   	cltd   
  800452:	f7 7d f8             	idivl  -0x8(%ebp)
  800455:	89 d0                	mov    %edx,%eax
  800457:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800459:	ff 45 fc             	incl   -0x4(%ebp)
  80045c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800462:	7c da                	jl     80043e <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800464:	90                   	nop
  800465:	c9                   	leave  
  800466:	c3                   	ret    

00800467 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800467:	55                   	push   %ebp
  800468:	89 e5                	mov    %esp,%ebp
  80046a:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80046d:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80047b:	eb 42                	jmp    8004bf <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80047d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800480:	99                   	cltd   
  800481:	f7 7d f0             	idivl  -0x10(%ebp)
  800484:	89 d0                	mov    %edx,%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	75 10                	jne    80049a <PrintElements+0x33>
			cprintf("\n");
  80048a:	83 ec 0c             	sub    $0xc,%esp
  80048d:	68 a0 25 80 00       	push   $0x8025a0
  800492:	e8 1b 08 00 00       	call   800cb2 <cprintf>
  800497:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80049a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80049d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	01 d0                	add    %edx,%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	83 ec 08             	sub    $0x8,%esp
  8004ae:	50                   	push   %eax
  8004af:	68 78 27 80 00       	push   $0x802778
  8004b4:	e8 f9 07 00 00       	call   800cb2 <cprintf>
  8004b9:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004bc:	ff 45 f4             	incl   -0xc(%ebp)
  8004bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c2:	48                   	dec    %eax
  8004c3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004c6:	7f b5                	jg     80047d <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8004c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d5:	01 d0                	add    %edx,%eax
  8004d7:	8b 00                	mov    (%eax),%eax
  8004d9:	83 ec 08             	sub    $0x8,%esp
  8004dc:	50                   	push   %eax
  8004dd:	68 ef 25 80 00       	push   $0x8025ef
  8004e2:	e8 cb 07 00 00       	call   800cb2 <cprintf>
  8004e7:	83 c4 10             	add    $0x10,%esp

}
  8004ea:	90                   	nop
  8004eb:	c9                   	leave  
  8004ec:	c3                   	ret    

008004ed <MSort>:


void MSort(int* A, int p, int r)
{
  8004ed:	55                   	push   %ebp
  8004ee:	89 e5                	mov    %esp,%ebp
  8004f0:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004f9:	7d 54                	jge    80054f <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	89 c2                	mov    %eax,%edx
  800505:	c1 ea 1f             	shr    $0x1f,%edx
  800508:	01 d0                	add    %edx,%eax
  80050a:	d1 f8                	sar    %eax
  80050c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  80050f:	83 ec 04             	sub    $0x4,%esp
  800512:	ff 75 f4             	pushl  -0xc(%ebp)
  800515:	ff 75 0c             	pushl  0xc(%ebp)
  800518:	ff 75 08             	pushl  0x8(%ebp)
  80051b:	e8 cd ff ff ff       	call   8004ed <MSort>
  800520:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  800523:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800526:	40                   	inc    %eax
  800527:	83 ec 04             	sub    $0x4,%esp
  80052a:	ff 75 10             	pushl  0x10(%ebp)
  80052d:	50                   	push   %eax
  80052e:	ff 75 08             	pushl  0x8(%ebp)
  800531:	e8 b7 ff ff ff       	call   8004ed <MSort>
  800536:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800539:	ff 75 10             	pushl  0x10(%ebp)
  80053c:	ff 75 f4             	pushl  -0xc(%ebp)
  80053f:	ff 75 0c             	pushl  0xc(%ebp)
  800542:	ff 75 08             	pushl  0x8(%ebp)
  800545:	e8 08 00 00 00       	call   800552 <Merge>
  80054a:	83 c4 10             	add    $0x10,%esp
  80054d:	eb 01                	jmp    800550 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80054f:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800550:	c9                   	leave  
  800551:	c3                   	ret    

00800552 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800552:	55                   	push   %ebp
  800553:	89 e5                	mov    %esp,%ebp
  800555:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800558:	8b 45 10             	mov    0x10(%ebp),%eax
  80055b:	2b 45 0c             	sub    0xc(%ebp),%eax
  80055e:	40                   	inc    %eax
  80055f:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800562:	8b 45 14             	mov    0x14(%ebp),%eax
  800565:	2b 45 10             	sub    0x10(%ebp),%eax
  800568:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  80056b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800572:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800579:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80057c:	c1 e0 02             	shl    $0x2,%eax
  80057f:	83 ec 0c             	sub    $0xc,%esp
  800582:	50                   	push   %eax
  800583:	e8 82 16 00 00       	call   801c0a <malloc>
  800588:	83 c4 10             	add    $0x10,%esp
  80058b:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80058e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800591:	c1 e0 02             	shl    $0x2,%eax
  800594:	83 ec 0c             	sub    $0xc,%esp
  800597:	50                   	push   %eax
  800598:	e8 6d 16 00 00       	call   801c0a <malloc>
  80059d:	83 c4 10             	add    $0x10,%esp
  8005a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005aa:	eb 2f                	jmp    8005db <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005b9:	01 c2                	add    %eax,%edx
  8005bb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005c1:	01 c8                	add    %ecx,%eax
  8005c3:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005c8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	01 c8                	add    %ecx,%eax
  8005d4:	8b 00                	mov    (%eax),%eax
  8005d6:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005d8:	ff 45 ec             	incl   -0x14(%ebp)
  8005db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005de:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e1:	7c c9                	jl     8005ac <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005ea:	eb 2a                	jmp    800616 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005f9:	01 c2                	add    %eax,%edx
  8005fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800601:	01 c8                	add    %ecx,%eax
  800603:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80060a:	8b 45 08             	mov    0x8(%ebp),%eax
  80060d:	01 c8                	add    %ecx,%eax
  80060f:	8b 00                	mov    (%eax),%eax
  800611:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800613:	ff 45 e8             	incl   -0x18(%ebp)
  800616:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800619:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80061c:	7c ce                	jl     8005ec <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80061e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800624:	e9 0a 01 00 00       	jmp    800733 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800629:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80062c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80062f:	0f 8d 95 00 00 00    	jge    8006ca <Merge+0x178>
  800635:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800638:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80063b:	0f 8d 89 00 00 00    	jge    8006ca <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800641:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800644:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80064b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80064e:	01 d0                	add    %edx,%eax
  800650:	8b 10                	mov    (%eax),%edx
  800652:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800655:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80065f:	01 c8                	add    %ecx,%eax
  800661:	8b 00                	mov    (%eax),%eax
  800663:	39 c2                	cmp    %eax,%edx
  800665:	7d 33                	jge    80069a <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800667:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80066a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80066f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80067c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067f:	8d 50 01             	lea    0x1(%eax),%edx
  800682:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800685:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80068c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80068f:	01 d0                	add    %edx,%eax
  800691:	8b 00                	mov    (%eax),%eax
  800693:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800695:	e9 96 00 00 00       	jmp    800730 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  80069a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069d:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ac:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b2:	8d 50 01             	lea    0x1(%eax),%edx
  8006b5:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006c2:	01 d0                	add    %edx,%eax
  8006c4:	8b 00                	mov    (%eax),%eax
  8006c6:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006c8:	eb 66                	jmp    800730 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8006ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006cd:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8006d0:	7d 30                	jge    800702 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8006d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006d5:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ea:	8d 50 01             	lea    0x1(%eax),%edx
  8006ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006fa:	01 d0                	add    %edx,%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	89 01                	mov    %eax,(%ecx)
  800700:	eb 2e                	jmp    800730 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800705:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80070a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800717:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071a:	8d 50 01             	lea    0x1(%eax),%edx
  80071d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800720:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800727:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80072a:	01 d0                	add    %edx,%eax
  80072c:	8b 00                	mov    (%eax),%eax
  80072e:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800730:	ff 45 e4             	incl   -0x1c(%ebp)
  800733:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800736:	3b 45 14             	cmp    0x14(%ebp),%eax
  800739:	0f 8e ea fe ff ff    	jle    800629 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  80073f:	90                   	nop
  800740:	c9                   	leave  
  800741:	c3                   	ret    

00800742 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800742:	55                   	push   %ebp
  800743:	89 e5                	mov    %esp,%ebp
  800745:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80074e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800752:	83 ec 0c             	sub    $0xc,%esp
  800755:	50                   	push   %eax
  800756:	e8 1b 17 00 00       	call   801e76 <sys_cputc>
  80075b:	83 c4 10             	add    $0x10,%esp
}
  80075e:	90                   	nop
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <getchar>:


int
getchar(void)
{
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
  800764:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  800767:	e8 a9 15 00 00       	call   801d15 <sys_cgetc>
  80076c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80076f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800773:	74 f2                	je     800767 <getchar+0x6>
	return c;
  800775:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800778:	c9                   	leave  
  800779:	c3                   	ret    

0080077a <iscons>:

int iscons(int fdnum)
{
  80077a:	55                   	push   %ebp
  80077b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80077d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800782:	5d                   	pop    %ebp
  800783:	c3                   	ret    

00800784 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800784:	55                   	push   %ebp
  800785:	89 e5                	mov    %esp,%ebp
  800787:	57                   	push   %edi
  800788:	56                   	push   %esi
  800789:	53                   	push   %ebx
  80078a:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800790:	e8 11 18 00 00       	call   801fa6 <sys_getenvindex>
  800795:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800798:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80079b:	89 d0                	mov    %edx,%eax
  80079d:	c1 e0 03             	shl    $0x3,%eax
  8007a0:	01 d0                	add    %edx,%eax
  8007a2:	c1 e0 06             	shl    $0x6,%eax
  8007a5:	01 d0                	add    %edx,%eax
  8007a7:	c1 e0 03             	shl    $0x3,%eax
  8007aa:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007af:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007b4:	a1 24 40 80 00       	mov    0x804024,%eax
  8007b9:	8a 40 10             	mov    0x10(%eax),%al
  8007bc:	84 c0                	test   %al,%al
  8007be:	74 0d                	je     8007cd <libmain+0x49>
		binaryname = myEnv->prog_name;
  8007c0:	a1 24 40 80 00       	mov    0x804024,%eax
  8007c5:	83 c0 10             	add    $0x10,%eax
  8007c8:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007d1:	7e 0a                	jle    8007dd <libmain+0x59>
		binaryname = argv[0];
  8007d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d6:	8b 00                	mov    (%eax),%eax
  8007d8:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  8007dd:	83 ec 08             	sub    $0x8,%esp
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	ff 75 08             	pushl  0x8(%ebp)
  8007e6:	e8 4d f8 ff ff       	call   800038 <_main>
  8007eb:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8007ee:	a1 00 40 80 00       	mov    0x804000,%eax
  8007f3:	85 c0                	test   %eax,%eax
  8007f5:	0f 84 b7 01 00 00    	je     8009b2 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007fb:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800801:	bb bc 28 80 00       	mov    $0x8028bc,%ebx
  800806:	ba 0e 00 00 00       	mov    $0xe,%edx
  80080b:	89 c7                	mov    %eax,%edi
  80080d:	89 de                	mov    %ebx,%esi
  80080f:	89 d1                	mov    %edx,%ecx
  800811:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800813:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800819:	b9 56 00 00 00       	mov    $0x56,%ecx
  80081e:	b0 00                	mov    $0x0,%al
  800820:	89 d7                	mov    %edx,%edi
  800822:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800824:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80082b:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	50                   	push   %eax
  800832:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800838:	50                   	push   %eax
  800839:	e8 68 19 00 00       	call   8021a6 <sys_utilities>
  80083e:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800841:	e8 e8 14 00 00       	call   801d2e <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800846:	83 ec 0c             	sub    $0xc,%esp
  800849:	68 98 27 80 00       	push   $0x802798
  80084e:	e8 5f 04 00 00       	call   800cb2 <cprintf>
  800853:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800856:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800859:	85 c0                	test   %eax,%eax
  80085b:	74 58                	je     8008b5 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80085d:	e8 62 19 00 00       	call   8021c4 <sys_get_optimal_num_faults>
  800862:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800865:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80086b:	bb 20 29 80 00       	mov    $0x802920,%ebx
  800870:	ba 11 00 00 00       	mov    $0x11,%edx
  800875:	89 c7                	mov    %eax,%edi
  800877:	89 de                	mov    %ebx,%esi
  800879:	89 d1                	mov    %edx,%ecx
  80087b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80087d:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800880:	b9 53 00 00 00       	mov    $0x53,%ecx
  800885:	b0 00                	mov    $0x0,%al
  800887:	89 d7                	mov    %edx,%edi
  800889:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 dc             	pushl  -0x24(%ebp)
  800891:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800897:	50                   	push   %eax
  800898:	e8 09 19 00 00       	call   8021a6 <sys_utilities>
  80089d:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8008a0:	83 ec 08             	sub    $0x8,%esp
  8008a3:	ff 75 dc             	pushl  -0x24(%ebp)
  8008a6:	68 c0 27 80 00       	push   $0x8027c0
  8008ab:	e8 02 04 00 00       	call   800cb2 <cprintf>
  8008b0:	83 c4 10             	add    $0x10,%esp
  8008b3:	eb 59                	jmp    80090e <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008b5:	a1 24 40 80 00       	mov    0x804024,%eax
  8008ba:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8008c0:	a1 24 40 80 00       	mov    0x804024,%eax
  8008c5:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8008cb:	83 ec 04             	sub    $0x4,%esp
  8008ce:	52                   	push   %edx
  8008cf:	50                   	push   %eax
  8008d0:	68 e4 27 80 00       	push   $0x8027e4
  8008d5:	e8 d8 03 00 00       	call   800cb2 <cprintf>
  8008da:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8008dd:	a1 24 40 80 00       	mov    0x804024,%eax
  8008e2:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8008e8:	a1 24 40 80 00       	mov    0x804024,%eax
  8008ed:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008f3:	a1 24 40 80 00       	mov    0x804024,%eax
  8008f8:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008fe:	51                   	push   %ecx
  8008ff:	52                   	push   %edx
  800900:	50                   	push   %eax
  800901:	68 0c 28 80 00       	push   $0x80280c
  800906:	e8 a7 03 00 00       	call   800cb2 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80090e:	a1 24 40 80 00       	mov    0x804024,%eax
  800913:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	50                   	push   %eax
  80091d:	68 64 28 80 00       	push   $0x802864
  800922:	e8 8b 03 00 00       	call   800cb2 <cprintf>
  800927:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80092a:	83 ec 0c             	sub    $0xc,%esp
  80092d:	68 78 28 80 00       	push   $0x802878
  800932:	e8 7b 03 00 00       	call   800cb2 <cprintf>
  800937:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80093a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800941:	eb 28                	jmp    80096b <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800943:	a1 24 40 80 00       	mov    0x804024,%eax
  800948:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80094b:	81 c2 74 04 00 00    	add    $0x474,%edx
  800951:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800954:	83 ec 04             	sub    $0x4,%esp
  800957:	50                   	push   %eax
  800958:	ff 75 e4             	pushl  -0x1c(%ebp)
  80095b:	68 8f 28 80 00       	push   $0x80288f
  800960:	e8 4d 03 00 00       	call   800cb2 <cprintf>
  800965:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800968:	ff 45 e4             	incl   -0x1c(%ebp)
  80096b:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80096f:	7e d2                	jle    800943 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800971:	83 ec 0c             	sub    $0xc,%esp
  800974:	68 9e 28 80 00       	push   $0x80289e
  800979:	e8 34 03 00 00       	call   800cb2 <cprintf>
  80097e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800981:	a1 24 40 80 00       	mov    0x804024,%eax
  800986:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	50                   	push   %eax
  800990:	68 a2 28 80 00       	push   $0x8028a2
  800995:	e8 18 03 00 00       	call   800cb2 <cprintf>
  80099a:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80099d:	83 ec 0c             	sub    $0xc,%esp
  8009a0:	68 98 27 80 00       	push   $0x802798
  8009a5:	e8 08 03 00 00       	call   800cb2 <cprintf>
  8009aa:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8009ad:	e8 96 13 00 00       	call   801d48 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8009b2:	e8 1f 00 00 00       	call   8009d6 <exit>
}
  8009b7:	90                   	nop
  8009b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8009bb:	5b                   	pop    %ebx
  8009bc:	5e                   	pop    %esi
  8009bd:	5f                   	pop    %edi
  8009be:	5d                   	pop    %ebp
  8009bf:	c3                   	ret    

008009c0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8009c6:	83 ec 0c             	sub    $0xc,%esp
  8009c9:	6a 00                	push   $0x0
  8009cb:	e8 a2 15 00 00       	call   801f72 <sys_destroy_env>
  8009d0:	83 c4 10             	add    $0x10,%esp
}
  8009d3:	90                   	nop
  8009d4:	c9                   	leave  
  8009d5:	c3                   	ret    

008009d6 <exit>:

void
exit(void)
{
  8009d6:	55                   	push   %ebp
  8009d7:	89 e5                	mov    %esp,%ebp
  8009d9:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8009dc:	e8 f7 15 00 00       	call   801fd8 <sys_exit_env>
}
  8009e1:	90                   	nop
  8009e2:	c9                   	leave  
  8009e3:	c3                   	ret    

008009e4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009e4:	55                   	push   %ebp
  8009e5:	89 e5                	mov    %esp,%ebp
  8009e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8009ed:	83 c0 04             	add    $0x4,%eax
  8009f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009f3:	a1 28 41 80 00       	mov    0x804128,%eax
  8009f8:	85 c0                	test   %eax,%eax
  8009fa:	74 16                	je     800a12 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009fc:	a1 28 41 80 00       	mov    0x804128,%eax
  800a01:	83 ec 08             	sub    $0x8,%esp
  800a04:	50                   	push   %eax
  800a05:	68 84 29 80 00       	push   $0x802984
  800a0a:	e8 a3 02 00 00       	call   800cb2 <cprintf>
  800a0f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800a12:	a1 04 40 80 00       	mov    0x804004,%eax
  800a17:	83 ec 0c             	sub    $0xc,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	ff 75 08             	pushl  0x8(%ebp)
  800a20:	50                   	push   %eax
  800a21:	68 8c 29 80 00       	push   $0x80298c
  800a26:	6a 74                	push   $0x74
  800a28:	e8 b2 02 00 00       	call   800cdf <cprintf_colored>
  800a2d:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800a30:	8b 45 10             	mov    0x10(%ebp),%eax
  800a33:	83 ec 08             	sub    $0x8,%esp
  800a36:	ff 75 f4             	pushl  -0xc(%ebp)
  800a39:	50                   	push   %eax
  800a3a:	e8 04 02 00 00       	call   800c43 <vcprintf>
  800a3f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	6a 00                	push   $0x0
  800a47:	68 b4 29 80 00       	push   $0x8029b4
  800a4c:	e8 f2 01 00 00       	call   800c43 <vcprintf>
  800a51:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a54:	e8 7d ff ff ff       	call   8009d6 <exit>

	// should not return here
	while (1) ;
  800a59:	eb fe                	jmp    800a59 <_panic+0x75>

00800a5b <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a5b:	55                   	push   %ebp
  800a5c:	89 e5                	mov    %esp,%ebp
  800a5e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a61:	a1 24 40 80 00       	mov    0x804024,%eax
  800a66:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6f:	39 c2                	cmp    %eax,%edx
  800a71:	74 14                	je     800a87 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a73:	83 ec 04             	sub    $0x4,%esp
  800a76:	68 b8 29 80 00       	push   $0x8029b8
  800a7b:	6a 26                	push   $0x26
  800a7d:	68 04 2a 80 00       	push   $0x802a04
  800a82:	e8 5d ff ff ff       	call   8009e4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a95:	e9 c5 00 00 00       	jmp    800b5f <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	01 d0                	add    %edx,%eax
  800aa9:	8b 00                	mov    (%eax),%eax
  800aab:	85 c0                	test   %eax,%eax
  800aad:	75 08                	jne    800ab7 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800aaf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ab2:	e9 a5 00 00 00       	jmp    800b5c <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800ab7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800abe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800ac5:	eb 69                	jmp    800b30 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800ac7:	a1 24 40 80 00       	mov    0x804024,%eax
  800acc:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800ad2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ad5:	89 d0                	mov    %edx,%eax
  800ad7:	01 c0                	add    %eax,%eax
  800ad9:	01 d0                	add    %edx,%eax
  800adb:	c1 e0 03             	shl    $0x3,%eax
  800ade:	01 c8                	add    %ecx,%eax
  800ae0:	8a 40 04             	mov    0x4(%eax),%al
  800ae3:	84 c0                	test   %al,%al
  800ae5:	75 46                	jne    800b2d <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ae7:	a1 24 40 80 00       	mov    0x804024,%eax
  800aec:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800af2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800af5:	89 d0                	mov    %edx,%eax
  800af7:	01 c0                	add    %eax,%eax
  800af9:	01 d0                	add    %edx,%eax
  800afb:	c1 e0 03             	shl    $0x3,%eax
  800afe:	01 c8                	add    %ecx,%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b05:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b0d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b12:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	01 c8                	add    %ecx,%eax
  800b1e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b20:	39 c2                	cmp    %eax,%edx
  800b22:	75 09                	jne    800b2d <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800b24:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b2b:	eb 15                	jmp    800b42 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b2d:	ff 45 e8             	incl   -0x18(%ebp)
  800b30:	a1 24 40 80 00       	mov    0x804024,%eax
  800b35:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b3e:	39 c2                	cmp    %eax,%edx
  800b40:	77 85                	ja     800ac7 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b42:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b46:	75 14                	jne    800b5c <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800b48:	83 ec 04             	sub    $0x4,%esp
  800b4b:	68 10 2a 80 00       	push   $0x802a10
  800b50:	6a 3a                	push   $0x3a
  800b52:	68 04 2a 80 00       	push   $0x802a04
  800b57:	e8 88 fe ff ff       	call   8009e4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b5c:	ff 45 f0             	incl   -0x10(%ebp)
  800b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b62:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b65:	0f 8c 2f ff ff ff    	jl     800a9a <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b72:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b79:	eb 26                	jmp    800ba1 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b7b:	a1 24 40 80 00       	mov    0x804024,%eax
  800b80:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b86:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b89:	89 d0                	mov    %edx,%eax
  800b8b:	01 c0                	add    %eax,%eax
  800b8d:	01 d0                	add    %edx,%eax
  800b8f:	c1 e0 03             	shl    $0x3,%eax
  800b92:	01 c8                	add    %ecx,%eax
  800b94:	8a 40 04             	mov    0x4(%eax),%al
  800b97:	3c 01                	cmp    $0x1,%al
  800b99:	75 03                	jne    800b9e <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b9b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b9e:	ff 45 e0             	incl   -0x20(%ebp)
  800ba1:	a1 24 40 80 00       	mov    0x804024,%eax
  800ba6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800bac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800baf:	39 c2                	cmp    %eax,%edx
  800bb1:	77 c8                	ja     800b7b <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bb6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bb9:	74 14                	je     800bcf <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800bbb:	83 ec 04             	sub    $0x4,%esp
  800bbe:	68 64 2a 80 00       	push   $0x802a64
  800bc3:	6a 44                	push   $0x44
  800bc5:	68 04 2a 80 00       	push   $0x802a04
  800bca:	e8 15 fe ff ff       	call   8009e4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bcf:	90                   	nop
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	53                   	push   %ebx
  800bd6:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8b 00                	mov    (%eax),%eax
  800bde:	8d 48 01             	lea    0x1(%eax),%ecx
  800be1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be4:	89 0a                	mov    %ecx,(%edx)
  800be6:	8b 55 08             	mov    0x8(%ebp),%edx
  800be9:	88 d1                	mov    %dl,%cl
  800beb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bee:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bfc:	75 30                	jne    800c2e <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800bfe:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c04:	a0 40 40 80 00       	mov    0x804040,%al
  800c09:	0f b6 c0             	movzbl %al,%eax
  800c0c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800c0f:	8b 09                	mov    (%ecx),%ecx
  800c11:	89 cb                	mov    %ecx,%ebx
  800c13:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800c16:	83 c1 08             	add    $0x8,%ecx
  800c19:	52                   	push   %edx
  800c1a:	50                   	push   %eax
  800c1b:	53                   	push   %ebx
  800c1c:	51                   	push   %ecx
  800c1d:	e8 c8 10 00 00       	call   801cea <sys_cputs>
  800c22:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c28:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c31:	8b 40 04             	mov    0x4(%eax),%eax
  800c34:	8d 50 01             	lea    0x1(%eax),%edx
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c3d:	90                   	nop
  800c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c41:	c9                   	leave  
  800c42:	c3                   	ret    

00800c43 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c43:	55                   	push   %ebp
  800c44:	89 e5                	mov    %esp,%ebp
  800c46:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c4c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c53:	00 00 00 
	b.cnt = 0;
  800c56:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c5d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c60:	ff 75 0c             	pushl  0xc(%ebp)
  800c63:	ff 75 08             	pushl  0x8(%ebp)
  800c66:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c6c:	50                   	push   %eax
  800c6d:	68 d2 0b 80 00       	push   $0x800bd2
  800c72:	e8 5a 02 00 00       	call   800ed1 <vprintfmt>
  800c77:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c7a:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c80:	a0 40 40 80 00       	mov    0x804040,%al
  800c85:	0f b6 c0             	movzbl %al,%eax
  800c88:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c8e:	52                   	push   %edx
  800c8f:	50                   	push   %eax
  800c90:	51                   	push   %ecx
  800c91:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c97:	83 c0 08             	add    $0x8,%eax
  800c9a:	50                   	push   %eax
  800c9b:	e8 4a 10 00 00       	call   801cea <sys_cputs>
  800ca0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ca3:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800caa:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
  800cb5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cb8:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800cbf:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	83 ec 08             	sub    $0x8,%esp
  800ccb:	ff 75 f4             	pushl  -0xc(%ebp)
  800cce:	50                   	push   %eax
  800ccf:	e8 6f ff ff ff       	call   800c43 <vcprintf>
  800cd4:	83 c4 10             	add    $0x10,%esp
  800cd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cda:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cdd:	c9                   	leave  
  800cde:	c3                   	ret    

00800cdf <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800cdf:	55                   	push   %ebp
  800ce0:	89 e5                	mov    %esp,%ebp
  800ce2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ce5:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	c1 e0 08             	shl    $0x8,%eax
  800cf2:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800cf7:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cfa:	83 c0 04             	add    $0x4,%eax
  800cfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d03:	83 ec 08             	sub    $0x8,%esp
  800d06:	ff 75 f4             	pushl  -0xc(%ebp)
  800d09:	50                   	push   %eax
  800d0a:	e8 34 ff ff ff       	call   800c43 <vcprintf>
  800d0f:	83 c4 10             	add    $0x10,%esp
  800d12:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800d15:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800d1c:	07 00 00 

	return cnt;
  800d1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d22:	c9                   	leave  
  800d23:	c3                   	ret    

00800d24 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800d24:	55                   	push   %ebp
  800d25:	89 e5                	mov    %esp,%ebp
  800d27:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800d2a:	e8 ff 0f 00 00       	call   801d2e <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800d2f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d32:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	83 ec 08             	sub    $0x8,%esp
  800d3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3e:	50                   	push   %eax
  800d3f:	e8 ff fe ff ff       	call   800c43 <vcprintf>
  800d44:	83 c4 10             	add    $0x10,%esp
  800d47:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800d4a:	e8 f9 0f 00 00       	call   801d48 <sys_unlock_cons>
	return cnt;
  800d4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d52:	c9                   	leave  
  800d53:	c3                   	ret    

00800d54 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	53                   	push   %ebx
  800d58:	83 ec 14             	sub    $0x14,%esp
  800d5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d61:	8b 45 14             	mov    0x14(%ebp),%eax
  800d64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d67:	8b 45 18             	mov    0x18(%ebp),%eax
  800d6a:	ba 00 00 00 00       	mov    $0x0,%edx
  800d6f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d72:	77 55                	ja     800dc9 <printnum+0x75>
  800d74:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d77:	72 05                	jb     800d7e <printnum+0x2a>
  800d79:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d7c:	77 4b                	ja     800dc9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d7e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d81:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d84:	8b 45 18             	mov    0x18(%ebp),%eax
  800d87:	ba 00 00 00 00       	mov    $0x0,%edx
  800d8c:	52                   	push   %edx
  800d8d:	50                   	push   %eax
  800d8e:	ff 75 f4             	pushl  -0xc(%ebp)
  800d91:	ff 75 f0             	pushl  -0x10(%ebp)
  800d94:	e8 8b 15 00 00       	call   802324 <__udivdi3>
  800d99:	83 c4 10             	add    $0x10,%esp
  800d9c:	83 ec 04             	sub    $0x4,%esp
  800d9f:	ff 75 20             	pushl  0x20(%ebp)
  800da2:	53                   	push   %ebx
  800da3:	ff 75 18             	pushl  0x18(%ebp)
  800da6:	52                   	push   %edx
  800da7:	50                   	push   %eax
  800da8:	ff 75 0c             	pushl  0xc(%ebp)
  800dab:	ff 75 08             	pushl  0x8(%ebp)
  800dae:	e8 a1 ff ff ff       	call   800d54 <printnum>
  800db3:	83 c4 20             	add    $0x20,%esp
  800db6:	eb 1a                	jmp    800dd2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800db8:	83 ec 08             	sub    $0x8,%esp
  800dbb:	ff 75 0c             	pushl  0xc(%ebp)
  800dbe:	ff 75 20             	pushl  0x20(%ebp)
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	ff d0                	call   *%eax
  800dc6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800dc9:	ff 4d 1c             	decl   0x1c(%ebp)
  800dcc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800dd0:	7f e6                	jg     800db8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800dd2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800dd5:	bb 00 00 00 00       	mov    $0x0,%ebx
  800dda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de0:	53                   	push   %ebx
  800de1:	51                   	push   %ecx
  800de2:	52                   	push   %edx
  800de3:	50                   	push   %eax
  800de4:	e8 4b 16 00 00       	call   802434 <__umoddi3>
  800de9:	83 c4 10             	add    $0x10,%esp
  800dec:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	0f be c0             	movsbl %al,%eax
  800df6:	83 ec 08             	sub    $0x8,%esp
  800df9:	ff 75 0c             	pushl  0xc(%ebp)
  800dfc:	50                   	push   %eax
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	ff d0                	call   *%eax
  800e02:	83 c4 10             	add    $0x10,%esp
}
  800e05:	90                   	nop
  800e06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800e09:	c9                   	leave  
  800e0a:	c3                   	ret    

00800e0b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800e0b:	55                   	push   %ebp
  800e0c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e0e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e12:	7e 1c                	jle    800e30 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	8b 00                	mov    (%eax),%eax
  800e19:	8d 50 08             	lea    0x8(%eax),%edx
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	89 10                	mov    %edx,(%eax)
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	8b 00                	mov    (%eax),%eax
  800e26:	83 e8 08             	sub    $0x8,%eax
  800e29:	8b 50 04             	mov    0x4(%eax),%edx
  800e2c:	8b 00                	mov    (%eax),%eax
  800e2e:	eb 40                	jmp    800e70 <getuint+0x65>
	else if (lflag)
  800e30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e34:	74 1e                	je     800e54 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	8b 00                	mov    (%eax),%eax
  800e3b:	8d 50 04             	lea    0x4(%eax),%edx
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	89 10                	mov    %edx,(%eax)
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8b 00                	mov    (%eax),%eax
  800e48:	83 e8 04             	sub    $0x4,%eax
  800e4b:	8b 00                	mov    (%eax),%eax
  800e4d:	ba 00 00 00 00       	mov    $0x0,%edx
  800e52:	eb 1c                	jmp    800e70 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8b 00                	mov    (%eax),%eax
  800e59:	8d 50 04             	lea    0x4(%eax),%edx
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	89 10                	mov    %edx,(%eax)
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	83 e8 04             	sub    $0x4,%eax
  800e69:	8b 00                	mov    (%eax),%eax
  800e6b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e70:	5d                   	pop    %ebp
  800e71:	c3                   	ret    

00800e72 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e72:	55                   	push   %ebp
  800e73:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e75:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e79:	7e 1c                	jle    800e97 <getint+0x25>
		return va_arg(*ap, long long);
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8b 00                	mov    (%eax),%eax
  800e80:	8d 50 08             	lea    0x8(%eax),%edx
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	89 10                	mov    %edx,(%eax)
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	83 e8 08             	sub    $0x8,%eax
  800e90:	8b 50 04             	mov    0x4(%eax),%edx
  800e93:	8b 00                	mov    (%eax),%eax
  800e95:	eb 38                	jmp    800ecf <getint+0x5d>
	else if (lflag)
  800e97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e9b:	74 1a                	je     800eb7 <getint+0x45>
		return va_arg(*ap, long);
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	8b 00                	mov    (%eax),%eax
  800ea2:	8d 50 04             	lea    0x4(%eax),%edx
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	89 10                	mov    %edx,(%eax)
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	8b 00                	mov    (%eax),%eax
  800eaf:	83 e8 04             	sub    $0x4,%eax
  800eb2:	8b 00                	mov    (%eax),%eax
  800eb4:	99                   	cltd   
  800eb5:	eb 18                	jmp    800ecf <getint+0x5d>
	else
		return va_arg(*ap, int);
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	8b 00                	mov    (%eax),%eax
  800ebc:	8d 50 04             	lea    0x4(%eax),%edx
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	89 10                	mov    %edx,(%eax)
  800ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec7:	8b 00                	mov    (%eax),%eax
  800ec9:	83 e8 04             	sub    $0x4,%eax
  800ecc:	8b 00                	mov    (%eax),%eax
  800ece:	99                   	cltd   
}
  800ecf:	5d                   	pop    %ebp
  800ed0:	c3                   	ret    

00800ed1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	56                   	push   %esi
  800ed5:	53                   	push   %ebx
  800ed6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ed9:	eb 17                	jmp    800ef2 <vprintfmt+0x21>
			if (ch == '\0')
  800edb:	85 db                	test   %ebx,%ebx
  800edd:	0f 84 c1 03 00 00    	je     8012a4 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 0c             	pushl  0xc(%ebp)
  800ee9:	53                   	push   %ebx
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ef2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef5:	8d 50 01             	lea    0x1(%eax),%edx
  800ef8:	89 55 10             	mov    %edx,0x10(%ebp)
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	0f b6 d8             	movzbl %al,%ebx
  800f00:	83 fb 25             	cmp    $0x25,%ebx
  800f03:	75 d6                	jne    800edb <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800f05:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800f09:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800f10:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800f17:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800f1e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800f25:	8b 45 10             	mov    0x10(%ebp),%eax
  800f28:	8d 50 01             	lea    0x1(%eax),%edx
  800f2b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f2e:	8a 00                	mov    (%eax),%al
  800f30:	0f b6 d8             	movzbl %al,%ebx
  800f33:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f36:	83 f8 5b             	cmp    $0x5b,%eax
  800f39:	0f 87 3d 03 00 00    	ja     80127c <vprintfmt+0x3ab>
  800f3f:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800f46:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f48:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f4c:	eb d7                	jmp    800f25 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f4e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f52:	eb d1                	jmp    800f25 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f54:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f5b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f5e:	89 d0                	mov    %edx,%eax
  800f60:	c1 e0 02             	shl    $0x2,%eax
  800f63:	01 d0                	add    %edx,%eax
  800f65:	01 c0                	add    %eax,%eax
  800f67:	01 d8                	add    %ebx,%eax
  800f69:	83 e8 30             	sub    $0x30,%eax
  800f6c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f77:	83 fb 2f             	cmp    $0x2f,%ebx
  800f7a:	7e 3e                	jle    800fba <vprintfmt+0xe9>
  800f7c:	83 fb 39             	cmp    $0x39,%ebx
  800f7f:	7f 39                	jg     800fba <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f81:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f84:	eb d5                	jmp    800f5b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f86:	8b 45 14             	mov    0x14(%ebp),%eax
  800f89:	83 c0 04             	add    $0x4,%eax
  800f8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f92:	83 e8 04             	sub    $0x4,%eax
  800f95:	8b 00                	mov    (%eax),%eax
  800f97:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f9a:	eb 1f                	jmp    800fbb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f9c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa0:	79 83                	jns    800f25 <vprintfmt+0x54>
				width = 0;
  800fa2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800fa9:	e9 77 ff ff ff       	jmp    800f25 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800fae:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800fb5:	e9 6b ff ff ff       	jmp    800f25 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800fba:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800fbb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fbf:	0f 89 60 ff ff ff    	jns    800f25 <vprintfmt+0x54>
				width = precision, precision = -1;
  800fc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fc8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800fcb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800fd2:	e9 4e ff ff ff       	jmp    800f25 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800fd7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800fda:	e9 46 ff ff ff       	jmp    800f25 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fdf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe2:	83 c0 04             	add    $0x4,%eax
  800fe5:	89 45 14             	mov    %eax,0x14(%ebp)
  800fe8:	8b 45 14             	mov    0x14(%ebp),%eax
  800feb:	83 e8 04             	sub    $0x4,%eax
  800fee:	8b 00                	mov    (%eax),%eax
  800ff0:	83 ec 08             	sub    $0x8,%esp
  800ff3:	ff 75 0c             	pushl  0xc(%ebp)
  800ff6:	50                   	push   %eax
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	ff d0                	call   *%eax
  800ffc:	83 c4 10             	add    $0x10,%esp
			break;
  800fff:	e9 9b 02 00 00       	jmp    80129f <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801004:	8b 45 14             	mov    0x14(%ebp),%eax
  801007:	83 c0 04             	add    $0x4,%eax
  80100a:	89 45 14             	mov    %eax,0x14(%ebp)
  80100d:	8b 45 14             	mov    0x14(%ebp),%eax
  801010:	83 e8 04             	sub    $0x4,%eax
  801013:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801015:	85 db                	test   %ebx,%ebx
  801017:	79 02                	jns    80101b <vprintfmt+0x14a>
				err = -err;
  801019:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80101b:	83 fb 64             	cmp    $0x64,%ebx
  80101e:	7f 0b                	jg     80102b <vprintfmt+0x15a>
  801020:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  801027:	85 f6                	test   %esi,%esi
  801029:	75 19                	jne    801044 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80102b:	53                   	push   %ebx
  80102c:	68 e5 2c 80 00       	push   $0x802ce5
  801031:	ff 75 0c             	pushl  0xc(%ebp)
  801034:	ff 75 08             	pushl  0x8(%ebp)
  801037:	e8 70 02 00 00       	call   8012ac <printfmt>
  80103c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80103f:	e9 5b 02 00 00       	jmp    80129f <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801044:	56                   	push   %esi
  801045:	68 ee 2c 80 00       	push   $0x802cee
  80104a:	ff 75 0c             	pushl  0xc(%ebp)
  80104d:	ff 75 08             	pushl  0x8(%ebp)
  801050:	e8 57 02 00 00       	call   8012ac <printfmt>
  801055:	83 c4 10             	add    $0x10,%esp
			break;
  801058:	e9 42 02 00 00       	jmp    80129f <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80105d:	8b 45 14             	mov    0x14(%ebp),%eax
  801060:	83 c0 04             	add    $0x4,%eax
  801063:	89 45 14             	mov    %eax,0x14(%ebp)
  801066:	8b 45 14             	mov    0x14(%ebp),%eax
  801069:	83 e8 04             	sub    $0x4,%eax
  80106c:	8b 30                	mov    (%eax),%esi
  80106e:	85 f6                	test   %esi,%esi
  801070:	75 05                	jne    801077 <vprintfmt+0x1a6>
				p = "(null)";
  801072:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  801077:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80107b:	7e 6d                	jle    8010ea <vprintfmt+0x219>
  80107d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801081:	74 67                	je     8010ea <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801083:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801086:	83 ec 08             	sub    $0x8,%esp
  801089:	50                   	push   %eax
  80108a:	56                   	push   %esi
  80108b:	e8 1e 03 00 00       	call   8013ae <strnlen>
  801090:	83 c4 10             	add    $0x10,%esp
  801093:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801096:	eb 16                	jmp    8010ae <vprintfmt+0x1dd>
					putch(padc, putdat);
  801098:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80109c:	83 ec 08             	sub    $0x8,%esp
  80109f:	ff 75 0c             	pushl  0xc(%ebp)
  8010a2:	50                   	push   %eax
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	ff d0                	call   *%eax
  8010a8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8010ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8010ae:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010b2:	7f e4                	jg     801098 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010b4:	eb 34                	jmp    8010ea <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8010b6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8010ba:	74 1c                	je     8010d8 <vprintfmt+0x207>
  8010bc:	83 fb 1f             	cmp    $0x1f,%ebx
  8010bf:	7e 05                	jle    8010c6 <vprintfmt+0x1f5>
  8010c1:	83 fb 7e             	cmp    $0x7e,%ebx
  8010c4:	7e 12                	jle    8010d8 <vprintfmt+0x207>
					putch('?', putdat);
  8010c6:	83 ec 08             	sub    $0x8,%esp
  8010c9:	ff 75 0c             	pushl  0xc(%ebp)
  8010cc:	6a 3f                	push   $0x3f
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	ff d0                	call   *%eax
  8010d3:	83 c4 10             	add    $0x10,%esp
  8010d6:	eb 0f                	jmp    8010e7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8010d8:	83 ec 08             	sub    $0x8,%esp
  8010db:	ff 75 0c             	pushl  0xc(%ebp)
  8010de:	53                   	push   %ebx
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	ff d0                	call   *%eax
  8010e4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010e7:	ff 4d e4             	decl   -0x1c(%ebp)
  8010ea:	89 f0                	mov    %esi,%eax
  8010ec:	8d 70 01             	lea    0x1(%eax),%esi
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	0f be d8             	movsbl %al,%ebx
  8010f4:	85 db                	test   %ebx,%ebx
  8010f6:	74 24                	je     80111c <vprintfmt+0x24b>
  8010f8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010fc:	78 b8                	js     8010b6 <vprintfmt+0x1e5>
  8010fe:	ff 4d e0             	decl   -0x20(%ebp)
  801101:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801105:	79 af                	jns    8010b6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801107:	eb 13                	jmp    80111c <vprintfmt+0x24b>
				putch(' ', putdat);
  801109:	83 ec 08             	sub    $0x8,%esp
  80110c:	ff 75 0c             	pushl  0xc(%ebp)
  80110f:	6a 20                	push   $0x20
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	ff d0                	call   *%eax
  801116:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801119:	ff 4d e4             	decl   -0x1c(%ebp)
  80111c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801120:	7f e7                	jg     801109 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801122:	e9 78 01 00 00       	jmp    80129f <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801127:	83 ec 08             	sub    $0x8,%esp
  80112a:	ff 75 e8             	pushl  -0x18(%ebp)
  80112d:	8d 45 14             	lea    0x14(%ebp),%eax
  801130:	50                   	push   %eax
  801131:	e8 3c fd ff ff       	call   800e72 <getint>
  801136:	83 c4 10             	add    $0x10,%esp
  801139:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80113c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80113f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801142:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801145:	85 d2                	test   %edx,%edx
  801147:	79 23                	jns    80116c <vprintfmt+0x29b>
				putch('-', putdat);
  801149:	83 ec 08             	sub    $0x8,%esp
  80114c:	ff 75 0c             	pushl  0xc(%ebp)
  80114f:	6a 2d                	push   $0x2d
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	ff d0                	call   *%eax
  801156:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801159:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80115c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80115f:	f7 d8                	neg    %eax
  801161:	83 d2 00             	adc    $0x0,%edx
  801164:	f7 da                	neg    %edx
  801166:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801169:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80116c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801173:	e9 bc 00 00 00       	jmp    801234 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801178:	83 ec 08             	sub    $0x8,%esp
  80117b:	ff 75 e8             	pushl  -0x18(%ebp)
  80117e:	8d 45 14             	lea    0x14(%ebp),%eax
  801181:	50                   	push   %eax
  801182:	e8 84 fc ff ff       	call   800e0b <getuint>
  801187:	83 c4 10             	add    $0x10,%esp
  80118a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80118d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801190:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801197:	e9 98 00 00 00       	jmp    801234 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80119c:	83 ec 08             	sub    $0x8,%esp
  80119f:	ff 75 0c             	pushl  0xc(%ebp)
  8011a2:	6a 58                	push   $0x58
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	ff d0                	call   *%eax
  8011a9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011ac:	83 ec 08             	sub    $0x8,%esp
  8011af:	ff 75 0c             	pushl  0xc(%ebp)
  8011b2:	6a 58                	push   $0x58
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	ff d0                	call   *%eax
  8011b9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011bc:	83 ec 08             	sub    $0x8,%esp
  8011bf:	ff 75 0c             	pushl  0xc(%ebp)
  8011c2:	6a 58                	push   $0x58
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	ff d0                	call   *%eax
  8011c9:	83 c4 10             	add    $0x10,%esp
			break;
  8011cc:	e9 ce 00 00 00       	jmp    80129f <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8011d1:	83 ec 08             	sub    $0x8,%esp
  8011d4:	ff 75 0c             	pushl  0xc(%ebp)
  8011d7:	6a 30                	push   $0x30
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	ff d0                	call   *%eax
  8011de:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011e1:	83 ec 08             	sub    $0x8,%esp
  8011e4:	ff 75 0c             	pushl  0xc(%ebp)
  8011e7:	6a 78                	push   $0x78
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	ff d0                	call   *%eax
  8011ee:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f4:	83 c0 04             	add    $0x4,%eax
  8011f7:	89 45 14             	mov    %eax,0x14(%ebp)
  8011fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fd:	83 e8 04             	sub    $0x4,%eax
  801200:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801202:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801205:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80120c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801213:	eb 1f                	jmp    801234 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801215:	83 ec 08             	sub    $0x8,%esp
  801218:	ff 75 e8             	pushl  -0x18(%ebp)
  80121b:	8d 45 14             	lea    0x14(%ebp),%eax
  80121e:	50                   	push   %eax
  80121f:	e8 e7 fb ff ff       	call   800e0b <getuint>
  801224:	83 c4 10             	add    $0x10,%esp
  801227:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80122a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80122d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801234:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801238:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80123b:	83 ec 04             	sub    $0x4,%esp
  80123e:	52                   	push   %edx
  80123f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801242:	50                   	push   %eax
  801243:	ff 75 f4             	pushl  -0xc(%ebp)
  801246:	ff 75 f0             	pushl  -0x10(%ebp)
  801249:	ff 75 0c             	pushl  0xc(%ebp)
  80124c:	ff 75 08             	pushl  0x8(%ebp)
  80124f:	e8 00 fb ff ff       	call   800d54 <printnum>
  801254:	83 c4 20             	add    $0x20,%esp
			break;
  801257:	eb 46                	jmp    80129f <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801259:	83 ec 08             	sub    $0x8,%esp
  80125c:	ff 75 0c             	pushl  0xc(%ebp)
  80125f:	53                   	push   %ebx
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	ff d0                	call   *%eax
  801265:	83 c4 10             	add    $0x10,%esp
			break;
  801268:	eb 35                	jmp    80129f <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  80126a:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  801271:	eb 2c                	jmp    80129f <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801273:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  80127a:	eb 23                	jmp    80129f <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80127c:	83 ec 08             	sub    $0x8,%esp
  80127f:	ff 75 0c             	pushl  0xc(%ebp)
  801282:	6a 25                	push   $0x25
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	ff d0                	call   *%eax
  801289:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80128c:	ff 4d 10             	decl   0x10(%ebp)
  80128f:	eb 03                	jmp    801294 <vprintfmt+0x3c3>
  801291:	ff 4d 10             	decl   0x10(%ebp)
  801294:	8b 45 10             	mov    0x10(%ebp),%eax
  801297:	48                   	dec    %eax
  801298:	8a 00                	mov    (%eax),%al
  80129a:	3c 25                	cmp    $0x25,%al
  80129c:	75 f3                	jne    801291 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80129e:	90                   	nop
		}
	}
  80129f:	e9 35 fc ff ff       	jmp    800ed9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8012a4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8012a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012a8:	5b                   	pop    %ebx
  8012a9:	5e                   	pop    %esi
  8012aa:	5d                   	pop    %ebp
  8012ab:	c3                   	ret    

008012ac <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
  8012af:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8012b2:	8d 45 10             	lea    0x10(%ebp),%eax
  8012b5:	83 c0 04             	add    $0x4,%eax
  8012b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8012bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8012be:	ff 75 f4             	pushl  -0xc(%ebp)
  8012c1:	50                   	push   %eax
  8012c2:	ff 75 0c             	pushl  0xc(%ebp)
  8012c5:	ff 75 08             	pushl  0x8(%ebp)
  8012c8:	e8 04 fc ff ff       	call   800ed1 <vprintfmt>
  8012cd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8012d0:	90                   	nop
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8012d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d9:	8b 40 08             	mov    0x8(%eax),%eax
  8012dc:	8d 50 01             	lea    0x1(%eax),%edx
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8012e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e8:	8b 10                	mov    (%eax),%edx
  8012ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ed:	8b 40 04             	mov    0x4(%eax),%eax
  8012f0:	39 c2                	cmp    %eax,%edx
  8012f2:	73 12                	jae    801306 <sprintputch+0x33>
		*b->buf++ = ch;
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	8b 00                	mov    (%eax),%eax
  8012f9:	8d 48 01             	lea    0x1(%eax),%ecx
  8012fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ff:	89 0a                	mov    %ecx,(%edx)
  801301:	8b 55 08             	mov    0x8(%ebp),%edx
  801304:	88 10                	mov    %dl,(%eax)
}
  801306:	90                   	nop
  801307:	5d                   	pop    %ebp
  801308:	c3                   	ret    

00801309 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
  80130c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801315:	8b 45 0c             	mov    0xc(%ebp),%eax
  801318:	8d 50 ff             	lea    -0x1(%eax),%edx
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	01 d0                	add    %edx,%eax
  801320:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801323:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80132a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80132e:	74 06                	je     801336 <vsnprintf+0x2d>
  801330:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801334:	7f 07                	jg     80133d <vsnprintf+0x34>
		return -E_INVAL;
  801336:	b8 03 00 00 00       	mov    $0x3,%eax
  80133b:	eb 20                	jmp    80135d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80133d:	ff 75 14             	pushl  0x14(%ebp)
  801340:	ff 75 10             	pushl  0x10(%ebp)
  801343:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801346:	50                   	push   %eax
  801347:	68 d3 12 80 00       	push   $0x8012d3
  80134c:	e8 80 fb ff ff       	call   800ed1 <vprintfmt>
  801351:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801354:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801357:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80135a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
  801362:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801365:	8d 45 10             	lea    0x10(%ebp),%eax
  801368:	83 c0 04             	add    $0x4,%eax
  80136b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80136e:	8b 45 10             	mov    0x10(%ebp),%eax
  801371:	ff 75 f4             	pushl  -0xc(%ebp)
  801374:	50                   	push   %eax
  801375:	ff 75 0c             	pushl  0xc(%ebp)
  801378:	ff 75 08             	pushl  0x8(%ebp)
  80137b:	e8 89 ff ff ff       	call   801309 <vsnprintf>
  801380:	83 c4 10             	add    $0x10,%esp
  801383:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801386:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801389:	c9                   	leave  
  80138a:	c3                   	ret    

0080138b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
  80138e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801391:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801398:	eb 06                	jmp    8013a0 <strlen+0x15>
		n++;
  80139a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80139d:	ff 45 08             	incl   0x8(%ebp)
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	84 c0                	test   %al,%al
  8013a7:	75 f1                	jne    80139a <strlen+0xf>
		n++;
	return n;
  8013a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
  8013b1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013bb:	eb 09                	jmp    8013c6 <strnlen+0x18>
		n++;
  8013bd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013c0:	ff 45 08             	incl   0x8(%ebp)
  8013c3:	ff 4d 0c             	decl   0xc(%ebp)
  8013c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013ca:	74 09                	je     8013d5 <strnlen+0x27>
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	8a 00                	mov    (%eax),%al
  8013d1:	84 c0                	test   %al,%al
  8013d3:	75 e8                	jne    8013bd <strnlen+0xf>
		n++;
	return n;
  8013d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
  8013dd:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013e6:	90                   	nop
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	8d 50 01             	lea    0x1(%eax),%edx
  8013ed:	89 55 08             	mov    %edx,0x8(%ebp)
  8013f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013f6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013f9:	8a 12                	mov    (%edx),%dl
  8013fb:	88 10                	mov    %dl,(%eax)
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	84 c0                	test   %al,%al
  801401:	75 e4                	jne    8013e7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801403:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801406:	c9                   	leave  
  801407:	c3                   	ret    

00801408 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801408:	55                   	push   %ebp
  801409:	89 e5                	mov    %esp,%ebp
  80140b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801414:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80141b:	eb 1f                	jmp    80143c <strncpy+0x34>
		*dst++ = *src;
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8d 50 01             	lea    0x1(%eax),%edx
  801423:	89 55 08             	mov    %edx,0x8(%ebp)
  801426:	8b 55 0c             	mov    0xc(%ebp),%edx
  801429:	8a 12                	mov    (%edx),%dl
  80142b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80142d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	84 c0                	test   %al,%al
  801434:	74 03                	je     801439 <strncpy+0x31>
			src++;
  801436:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801439:	ff 45 fc             	incl   -0x4(%ebp)
  80143c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801442:	72 d9                	jb     80141d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801444:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
  80144c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801455:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801459:	74 30                	je     80148b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80145b:	eb 16                	jmp    801473 <strlcpy+0x2a>
			*dst++ = *src++;
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8d 50 01             	lea    0x1(%eax),%edx
  801463:	89 55 08             	mov    %edx,0x8(%ebp)
  801466:	8b 55 0c             	mov    0xc(%ebp),%edx
  801469:	8d 4a 01             	lea    0x1(%edx),%ecx
  80146c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80146f:	8a 12                	mov    (%edx),%dl
  801471:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801473:	ff 4d 10             	decl   0x10(%ebp)
  801476:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80147a:	74 09                	je     801485 <strlcpy+0x3c>
  80147c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147f:	8a 00                	mov    (%eax),%al
  801481:	84 c0                	test   %al,%al
  801483:	75 d8                	jne    80145d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80148b:	8b 55 08             	mov    0x8(%ebp),%edx
  80148e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801491:	29 c2                	sub    %eax,%edx
  801493:	89 d0                	mov    %edx,%eax
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80149a:	eb 06                	jmp    8014a2 <strcmp+0xb>
		p++, q++;
  80149c:	ff 45 08             	incl   0x8(%ebp)
  80149f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	84 c0                	test   %al,%al
  8014a9:	74 0e                	je     8014b9 <strcmp+0x22>
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 10                	mov    (%eax),%dl
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	38 c2                	cmp    %al,%dl
  8014b7:	74 e3                	je     80149c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	0f b6 d0             	movzbl %al,%edx
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	0f b6 c0             	movzbl %al,%eax
  8014c9:	29 c2                	sub    %eax,%edx
  8014cb:	89 d0                	mov    %edx,%eax
}
  8014cd:	5d                   	pop    %ebp
  8014ce:	c3                   	ret    

008014cf <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8014d2:	eb 09                	jmp    8014dd <strncmp+0xe>
		n--, p++, q++;
  8014d4:	ff 4d 10             	decl   0x10(%ebp)
  8014d7:	ff 45 08             	incl   0x8(%ebp)
  8014da:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e1:	74 17                	je     8014fa <strncmp+0x2b>
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	8a 00                	mov    (%eax),%al
  8014e8:	84 c0                	test   %al,%al
  8014ea:	74 0e                	je     8014fa <strncmp+0x2b>
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	8a 10                	mov    (%eax),%dl
  8014f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f4:	8a 00                	mov    (%eax),%al
  8014f6:	38 c2                	cmp    %al,%dl
  8014f8:	74 da                	je     8014d4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014fe:	75 07                	jne    801507 <strncmp+0x38>
		return 0;
  801500:	b8 00 00 00 00       	mov    $0x0,%eax
  801505:	eb 14                	jmp    80151b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	8a 00                	mov    (%eax),%al
  80150c:	0f b6 d0             	movzbl %al,%edx
  80150f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	0f b6 c0             	movzbl %al,%eax
  801517:	29 c2                	sub    %eax,%edx
  801519:	89 d0                	mov    %edx,%eax
}
  80151b:	5d                   	pop    %ebp
  80151c:	c3                   	ret    

0080151d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
  801520:	83 ec 04             	sub    $0x4,%esp
  801523:	8b 45 0c             	mov    0xc(%ebp),%eax
  801526:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801529:	eb 12                	jmp    80153d <strchr+0x20>
		if (*s == c)
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	8a 00                	mov    (%eax),%al
  801530:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801533:	75 05                	jne    80153a <strchr+0x1d>
			return (char *) s;
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	eb 11                	jmp    80154b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80153a:	ff 45 08             	incl   0x8(%ebp)
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	8a 00                	mov    (%eax),%al
  801542:	84 c0                	test   %al,%al
  801544:	75 e5                	jne    80152b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801546:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
  801550:	83 ec 04             	sub    $0x4,%esp
  801553:	8b 45 0c             	mov    0xc(%ebp),%eax
  801556:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801559:	eb 0d                	jmp    801568 <strfind+0x1b>
		if (*s == c)
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801563:	74 0e                	je     801573 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801565:	ff 45 08             	incl   0x8(%ebp)
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	84 c0                	test   %al,%al
  80156f:	75 ea                	jne    80155b <strfind+0xe>
  801571:	eb 01                	jmp    801574 <strfind+0x27>
		if (*s == c)
			break;
  801573:	90                   	nop
	return (char *) s;
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801585:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801589:	76 63                	jbe    8015ee <memset+0x75>
		uint64 data_block = c;
  80158b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158e:	99                   	cltd   
  80158f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801592:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801595:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801598:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80159b:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  80159f:	c1 e0 08             	shl    $0x8,%eax
  8015a2:	09 45 f0             	or     %eax,-0x10(%ebp)
  8015a5:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8015a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ae:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8015b2:	c1 e0 10             	shl    $0x10,%eax
  8015b5:	09 45 f0             	or     %eax,-0x10(%ebp)
  8015b8:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8015bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015c1:	89 c2                	mov    %eax,%edx
  8015c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8015c8:	09 45 f0             	or     %eax,-0x10(%ebp)
  8015cb:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8015ce:	eb 18                	jmp    8015e8 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8015d0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d3:	8d 41 08             	lea    0x8(%ecx),%eax
  8015d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8015d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015df:	89 01                	mov    %eax,(%ecx)
  8015e1:	89 51 04             	mov    %edx,0x4(%ecx)
  8015e4:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8015e8:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015ec:	77 e2                	ja     8015d0 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8015ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f2:	74 23                	je     801617 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8015f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015fa:	eb 0e                	jmp    80160a <memset+0x91>
			*p8++ = (uint8)c;
  8015fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ff:	8d 50 01             	lea    0x1(%eax),%edx
  801602:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801605:	8b 55 0c             	mov    0xc(%ebp),%edx
  801608:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80160a:	8b 45 10             	mov    0x10(%ebp),%eax
  80160d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801610:	89 55 10             	mov    %edx,0x10(%ebp)
  801613:	85 c0                	test   %eax,%eax
  801615:	75 e5                	jne    8015fc <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
  80161f:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801622:	8b 45 0c             	mov    0xc(%ebp),%eax
  801625:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  80162e:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801632:	76 24                	jbe    801658 <memcpy+0x3c>
		while(n >= 8){
  801634:	eb 1c                	jmp    801652 <memcpy+0x36>
			*d64 = *s64;
  801636:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801639:	8b 50 04             	mov    0x4(%eax),%edx
  80163c:	8b 00                	mov    (%eax),%eax
  80163e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801641:	89 01                	mov    %eax,(%ecx)
  801643:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801646:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80164a:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80164e:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801652:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801656:	77 de                	ja     801636 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801658:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80165c:	74 31                	je     80168f <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80165e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801661:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801664:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801667:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80166a:	eb 16                	jmp    801682 <memcpy+0x66>
			*d8++ = *s8++;
  80166c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80166f:	8d 50 01             	lea    0x1(%eax),%edx
  801672:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801675:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801678:	8d 4a 01             	lea    0x1(%edx),%ecx
  80167b:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80167e:	8a 12                	mov    (%edx),%dl
  801680:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801682:	8b 45 10             	mov    0x10(%ebp),%eax
  801685:	8d 50 ff             	lea    -0x1(%eax),%edx
  801688:	89 55 10             	mov    %edx,0x10(%ebp)
  80168b:	85 c0                	test   %eax,%eax
  80168d:	75 dd                	jne    80166c <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
  801697:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80169a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80169d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8016a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016ac:	73 50                	jae    8016fe <memmove+0x6a>
  8016ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b4:	01 d0                	add    %edx,%eax
  8016b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016b9:	76 43                	jbe    8016fe <memmove+0x6a>
		s += n;
  8016bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016be:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016c7:	eb 10                	jmp    8016d9 <memmove+0x45>
			*--d = *--s;
  8016c9:	ff 4d f8             	decl   -0x8(%ebp)
  8016cc:	ff 4d fc             	decl   -0x4(%ebp)
  8016cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d2:	8a 10                	mov    (%eax),%dl
  8016d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016dc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016df:	89 55 10             	mov    %edx,0x10(%ebp)
  8016e2:	85 c0                	test   %eax,%eax
  8016e4:	75 e3                	jne    8016c9 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016e6:	eb 23                	jmp    80170b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016eb:	8d 50 01             	lea    0x1(%eax),%edx
  8016ee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016f4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016f7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016fa:	8a 12                	mov    (%edx),%dl
  8016fc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801701:	8d 50 ff             	lea    -0x1(%eax),%edx
  801704:	89 55 10             	mov    %edx,0x10(%ebp)
  801707:	85 c0                	test   %eax,%eax
  801709:	75 dd                	jne    8016e8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
  801713:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801716:	8b 45 08             	mov    0x8(%ebp),%eax
  801719:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80171c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801722:	eb 2a                	jmp    80174e <memcmp+0x3e>
		if (*s1 != *s2)
  801724:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801727:	8a 10                	mov    (%eax),%dl
  801729:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172c:	8a 00                	mov    (%eax),%al
  80172e:	38 c2                	cmp    %al,%dl
  801730:	74 16                	je     801748 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801732:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801735:	8a 00                	mov    (%eax),%al
  801737:	0f b6 d0             	movzbl %al,%edx
  80173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173d:	8a 00                	mov    (%eax),%al
  80173f:	0f b6 c0             	movzbl %al,%eax
  801742:	29 c2                	sub    %eax,%edx
  801744:	89 d0                	mov    %edx,%eax
  801746:	eb 18                	jmp    801760 <memcmp+0x50>
		s1++, s2++;
  801748:	ff 45 fc             	incl   -0x4(%ebp)
  80174b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80174e:	8b 45 10             	mov    0x10(%ebp),%eax
  801751:	8d 50 ff             	lea    -0x1(%eax),%edx
  801754:	89 55 10             	mov    %edx,0x10(%ebp)
  801757:	85 c0                	test   %eax,%eax
  801759:	75 c9                	jne    801724 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80175b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
  801765:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801768:	8b 55 08             	mov    0x8(%ebp),%edx
  80176b:	8b 45 10             	mov    0x10(%ebp),%eax
  80176e:	01 d0                	add    %edx,%eax
  801770:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801773:	eb 15                	jmp    80178a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	8a 00                	mov    (%eax),%al
  80177a:	0f b6 d0             	movzbl %al,%edx
  80177d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801780:	0f b6 c0             	movzbl %al,%eax
  801783:	39 c2                	cmp    %eax,%edx
  801785:	74 0d                	je     801794 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801787:	ff 45 08             	incl   0x8(%ebp)
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801790:	72 e3                	jb     801775 <memfind+0x13>
  801792:	eb 01                	jmp    801795 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801794:	90                   	nop
	return (void *) s;
  801795:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
  80179d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8017a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8017a7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017ae:	eb 03                	jmp    8017b3 <strtol+0x19>
		s++;
  8017b0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	3c 20                	cmp    $0x20,%al
  8017ba:	74 f4                	je     8017b0 <strtol+0x16>
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	3c 09                	cmp    $0x9,%al
  8017c3:	74 eb                	je     8017b0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 2b                	cmp    $0x2b,%al
  8017cc:	75 05                	jne    8017d3 <strtol+0x39>
		s++;
  8017ce:	ff 45 08             	incl   0x8(%ebp)
  8017d1:	eb 13                	jmp    8017e6 <strtol+0x4c>
	else if (*s == '-')
  8017d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d6:	8a 00                	mov    (%eax),%al
  8017d8:	3c 2d                	cmp    $0x2d,%al
  8017da:	75 0a                	jne    8017e6 <strtol+0x4c>
		s++, neg = 1;
  8017dc:	ff 45 08             	incl   0x8(%ebp)
  8017df:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ea:	74 06                	je     8017f2 <strtol+0x58>
  8017ec:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017f0:	75 20                	jne    801812 <strtol+0x78>
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	8a 00                	mov    (%eax),%al
  8017f7:	3c 30                	cmp    $0x30,%al
  8017f9:	75 17                	jne    801812 <strtol+0x78>
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	40                   	inc    %eax
  8017ff:	8a 00                	mov    (%eax),%al
  801801:	3c 78                	cmp    $0x78,%al
  801803:	75 0d                	jne    801812 <strtol+0x78>
		s += 2, base = 16;
  801805:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801809:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801810:	eb 28                	jmp    80183a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801812:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801816:	75 15                	jne    80182d <strtol+0x93>
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	8a 00                	mov    (%eax),%al
  80181d:	3c 30                	cmp    $0x30,%al
  80181f:	75 0c                	jne    80182d <strtol+0x93>
		s++, base = 8;
  801821:	ff 45 08             	incl   0x8(%ebp)
  801824:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80182b:	eb 0d                	jmp    80183a <strtol+0xa0>
	else if (base == 0)
  80182d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801831:	75 07                	jne    80183a <strtol+0xa0>
		base = 10;
  801833:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	8a 00                	mov    (%eax),%al
  80183f:	3c 2f                	cmp    $0x2f,%al
  801841:	7e 19                	jle    80185c <strtol+0xc2>
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	8a 00                	mov    (%eax),%al
  801848:	3c 39                	cmp    $0x39,%al
  80184a:	7f 10                	jg     80185c <strtol+0xc2>
			dig = *s - '0';
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	0f be c0             	movsbl %al,%eax
  801854:	83 e8 30             	sub    $0x30,%eax
  801857:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80185a:	eb 42                	jmp    80189e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80185c:	8b 45 08             	mov    0x8(%ebp),%eax
  80185f:	8a 00                	mov    (%eax),%al
  801861:	3c 60                	cmp    $0x60,%al
  801863:	7e 19                	jle    80187e <strtol+0xe4>
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
  801868:	8a 00                	mov    (%eax),%al
  80186a:	3c 7a                	cmp    $0x7a,%al
  80186c:	7f 10                	jg     80187e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	8a 00                	mov    (%eax),%al
  801873:	0f be c0             	movsbl %al,%eax
  801876:	83 e8 57             	sub    $0x57,%eax
  801879:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80187c:	eb 20                	jmp    80189e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80187e:	8b 45 08             	mov    0x8(%ebp),%eax
  801881:	8a 00                	mov    (%eax),%al
  801883:	3c 40                	cmp    $0x40,%al
  801885:	7e 39                	jle    8018c0 <strtol+0x126>
  801887:	8b 45 08             	mov    0x8(%ebp),%eax
  80188a:	8a 00                	mov    (%eax),%al
  80188c:	3c 5a                	cmp    $0x5a,%al
  80188e:	7f 30                	jg     8018c0 <strtol+0x126>
			dig = *s - 'A' + 10;
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	8a 00                	mov    (%eax),%al
  801895:	0f be c0             	movsbl %al,%eax
  801898:	83 e8 37             	sub    $0x37,%eax
  80189b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018a1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018a4:	7d 19                	jge    8018bf <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8018a6:	ff 45 08             	incl   0x8(%ebp)
  8018a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ac:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018b0:	89 c2                	mov    %eax,%edx
  8018b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018b5:	01 d0                	add    %edx,%eax
  8018b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018ba:	e9 7b ff ff ff       	jmp    80183a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018bf:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018c4:	74 08                	je     8018ce <strtol+0x134>
		*endptr = (char *) s;
  8018c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8018cc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018ce:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018d2:	74 07                	je     8018db <strtol+0x141>
  8018d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d7:	f7 d8                	neg    %eax
  8018d9:	eb 03                	jmp    8018de <strtol+0x144>
  8018db:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <ltostr>:

void
ltostr(long value, char *str)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
  8018e3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018f8:	79 13                	jns    80190d <ltostr+0x2d>
	{
		neg = 1;
  8018fa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801901:	8b 45 0c             	mov    0xc(%ebp),%eax
  801904:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801907:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80190a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801915:	99                   	cltd   
  801916:	f7 f9                	idiv   %ecx
  801918:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80191b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80191e:	8d 50 01             	lea    0x1(%eax),%edx
  801921:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801924:	89 c2                	mov    %eax,%edx
  801926:	8b 45 0c             	mov    0xc(%ebp),%eax
  801929:	01 d0                	add    %edx,%eax
  80192b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80192e:	83 c2 30             	add    $0x30,%edx
  801931:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801933:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801936:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80193b:	f7 e9                	imul   %ecx
  80193d:	c1 fa 02             	sar    $0x2,%edx
  801940:	89 c8                	mov    %ecx,%eax
  801942:	c1 f8 1f             	sar    $0x1f,%eax
  801945:	29 c2                	sub    %eax,%edx
  801947:	89 d0                	mov    %edx,%eax
  801949:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80194c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801950:	75 bb                	jne    80190d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801952:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801959:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195c:	48                   	dec    %eax
  80195d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801960:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801964:	74 3d                	je     8019a3 <ltostr+0xc3>
		start = 1 ;
  801966:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80196d:	eb 34                	jmp    8019a3 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80196f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801972:	8b 45 0c             	mov    0xc(%ebp),%eax
  801975:	01 d0                	add    %edx,%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80197c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80197f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801982:	01 c2                	add    %eax,%edx
  801984:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801987:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198a:	01 c8                	add    %ecx,%eax
  80198c:	8a 00                	mov    (%eax),%al
  80198e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801990:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801993:	8b 45 0c             	mov    0xc(%ebp),%eax
  801996:	01 c2                	add    %eax,%edx
  801998:	8a 45 eb             	mov    -0x15(%ebp),%al
  80199b:	88 02                	mov    %al,(%edx)
		start++ ;
  80199d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019a0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019a9:	7c c4                	jl     80196f <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b1:	01 d0                	add    %edx,%eax
  8019b3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019b6:	90                   	nop
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
  8019bc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019bf:	ff 75 08             	pushl  0x8(%ebp)
  8019c2:	e8 c4 f9 ff ff       	call   80138b <strlen>
  8019c7:	83 c4 04             	add    $0x4,%esp
  8019ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019cd:	ff 75 0c             	pushl  0xc(%ebp)
  8019d0:	e8 b6 f9 ff ff       	call   80138b <strlen>
  8019d5:	83 c4 04             	add    $0x4,%esp
  8019d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019e9:	eb 17                	jmp    801a02 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f1:	01 c2                	add    %eax,%edx
  8019f3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	01 c8                	add    %ecx,%eax
  8019fb:	8a 00                	mov    (%eax),%al
  8019fd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019ff:	ff 45 fc             	incl   -0x4(%ebp)
  801a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a05:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a08:	7c e1                	jl     8019eb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a0a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a11:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a18:	eb 1f                	jmp    801a39 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1d:	8d 50 01             	lea    0x1(%eax),%edx
  801a20:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a23:	89 c2                	mov    %eax,%edx
  801a25:	8b 45 10             	mov    0x10(%ebp),%eax
  801a28:	01 c2                	add    %eax,%edx
  801a2a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a30:	01 c8                	add    %ecx,%eax
  801a32:	8a 00                	mov    (%eax),%al
  801a34:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a36:	ff 45 f8             	incl   -0x8(%ebp)
  801a39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a3f:	7c d9                	jl     801a1a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a44:	8b 45 10             	mov    0x10(%ebp),%eax
  801a47:	01 d0                	add    %edx,%eax
  801a49:	c6 00 00             	movb   $0x0,(%eax)
}
  801a4c:	90                   	nop
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a52:	8b 45 14             	mov    0x14(%ebp),%eax
  801a55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a5b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5e:	8b 00                	mov    (%eax),%eax
  801a60:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a67:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6a:	01 d0                	add    %edx,%eax
  801a6c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a72:	eb 0c                	jmp    801a80 <strsplit+0x31>
			*string++ = 0;
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	8d 50 01             	lea    0x1(%eax),%edx
  801a7a:	89 55 08             	mov    %edx,0x8(%ebp)
  801a7d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a80:	8b 45 08             	mov    0x8(%ebp),%eax
  801a83:	8a 00                	mov    (%eax),%al
  801a85:	84 c0                	test   %al,%al
  801a87:	74 18                	je     801aa1 <strsplit+0x52>
  801a89:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8c:	8a 00                	mov    (%eax),%al
  801a8e:	0f be c0             	movsbl %al,%eax
  801a91:	50                   	push   %eax
  801a92:	ff 75 0c             	pushl  0xc(%ebp)
  801a95:	e8 83 fa ff ff       	call   80151d <strchr>
  801a9a:	83 c4 08             	add    $0x8,%esp
  801a9d:	85 c0                	test   %eax,%eax
  801a9f:	75 d3                	jne    801a74 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa4:	8a 00                	mov    (%eax),%al
  801aa6:	84 c0                	test   %al,%al
  801aa8:	74 5a                	je     801b04 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  801aad:	8b 00                	mov    (%eax),%eax
  801aaf:	83 f8 0f             	cmp    $0xf,%eax
  801ab2:	75 07                	jne    801abb <strsplit+0x6c>
		{
			return 0;
  801ab4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ab9:	eb 66                	jmp    801b21 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801abb:	8b 45 14             	mov    0x14(%ebp),%eax
  801abe:	8b 00                	mov    (%eax),%eax
  801ac0:	8d 48 01             	lea    0x1(%eax),%ecx
  801ac3:	8b 55 14             	mov    0x14(%ebp),%edx
  801ac6:	89 0a                	mov    %ecx,(%edx)
  801ac8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801acf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad2:	01 c2                	add    %eax,%edx
  801ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ad9:	eb 03                	jmp    801ade <strsplit+0x8f>
			string++;
  801adb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ade:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae1:	8a 00                	mov    (%eax),%al
  801ae3:	84 c0                	test   %al,%al
  801ae5:	74 8b                	je     801a72 <strsplit+0x23>
  801ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aea:	8a 00                	mov    (%eax),%al
  801aec:	0f be c0             	movsbl %al,%eax
  801aef:	50                   	push   %eax
  801af0:	ff 75 0c             	pushl  0xc(%ebp)
  801af3:	e8 25 fa ff ff       	call   80151d <strchr>
  801af8:	83 c4 08             	add    $0x8,%esp
  801afb:	85 c0                	test   %eax,%eax
  801afd:	74 dc                	je     801adb <strsplit+0x8c>
			string++;
	}
  801aff:	e9 6e ff ff ff       	jmp    801a72 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b04:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b05:	8b 45 14             	mov    0x14(%ebp),%eax
  801b08:	8b 00                	mov    (%eax),%eax
  801b0a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b11:	8b 45 10             	mov    0x10(%ebp),%eax
  801b14:	01 d0                	add    %edx,%eax
  801b16:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b1c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b21:	c9                   	leave  
  801b22:	c3                   	ret    

00801b23 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
  801b26:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801b29:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801b2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b36:	eb 4a                	jmp    801b82 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801b38:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3e:	01 c2                	add    %eax,%edx
  801b40:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b43:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b46:	01 c8                	add    %ecx,%eax
  801b48:	8a 00                	mov    (%eax),%al
  801b4a:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801b4c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b52:	01 d0                	add    %edx,%eax
  801b54:	8a 00                	mov    (%eax),%al
  801b56:	3c 40                	cmp    $0x40,%al
  801b58:	7e 25                	jle    801b7f <str2lower+0x5c>
  801b5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b60:	01 d0                	add    %edx,%eax
  801b62:	8a 00                	mov    (%eax),%al
  801b64:	3c 5a                	cmp    $0x5a,%al
  801b66:	7f 17                	jg     801b7f <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801b68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6e:	01 d0                	add    %edx,%eax
  801b70:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b73:	8b 55 08             	mov    0x8(%ebp),%edx
  801b76:	01 ca                	add    %ecx,%edx
  801b78:	8a 12                	mov    (%edx),%dl
  801b7a:	83 c2 20             	add    $0x20,%edx
  801b7d:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b7f:	ff 45 fc             	incl   -0x4(%ebp)
  801b82:	ff 75 0c             	pushl  0xc(%ebp)
  801b85:	e8 01 f8 ff ff       	call   80138b <strlen>
  801b8a:	83 c4 04             	add    $0x4,%esp
  801b8d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b90:	7f a6                	jg     801b38 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b92:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
  801b9a:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801b9d:	a1 08 40 80 00       	mov    0x804008,%eax
  801ba2:	85 c0                	test   %eax,%eax
  801ba4:	74 2d                	je     801bd3 <uheap_init+0x3c>
	{
		buddy_init();
  801ba6:	e8 87 06 00 00       	call   802232 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801bab:	e8 31 05 00 00       	call   8020e1 <sys_get_uheap_strategy>
  801bb0:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801bb5:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801bbc:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801bbf:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801bc6:	00 00 80 
		__firstTimeFlag = 0;
  801bc9:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801bd0:	00 00 00 
	}
}
  801bd3:	90                   	nop
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
  801bd9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801bdc:	83 ec 04             	sub    $0x4,%esp
  801bdf:	68 68 2e 80 00       	push   $0x802e68
  801be4:	6a 25                	push   $0x25
  801be6:	68 99 2e 80 00       	push   $0x802e99
  801beb:	e8 f4 ed ff ff       	call   8009e4 <_panic>

00801bf0 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
  801bf3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801bf6:	83 ec 04             	sub    $0x4,%esp
  801bf9:	68 a8 2e 80 00       	push   $0x802ea8
  801bfe:	6a 2f                	push   $0x2f
  801c00:	68 99 2e 80 00       	push   $0x802e99
  801c05:	e8 da ed ff ff       	call   8009e4 <_panic>

00801c0a <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c10:	e8 82 ff ff ff       	call   801b97 <uheap_init>
	if (size == 0) return NULL ;
  801c15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c19:	75 07                	jne    801c22 <malloc+0x18>
  801c1b:	b8 00 00 00 00       	mov    $0x0,%eax
  801c20:	eb 14                	jmp    801c36 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801c22:	83 ec 04             	sub    $0x4,%esp
  801c25:	68 dc 2e 80 00       	push   $0x802edc
  801c2a:	6a 43                	push   $0x43
  801c2c:	68 99 2e 80 00       	push   $0x802e99
  801c31:	e8 ae ed ff ff       	call   8009e4 <_panic>
}
  801c36:	c9                   	leave  
  801c37:	c3                   	ret    

00801c38 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801c38:	55                   	push   %ebp
  801c39:	89 e5                	mov    %esp,%ebp
  801c3b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801c3e:	83 ec 04             	sub    $0x4,%esp
  801c41:	68 04 2f 80 00       	push   $0x802f04
  801c46:	6a 4e                	push   $0x4e
  801c48:	68 99 2e 80 00       	push   $0x802e99
  801c4d:	e8 92 ed ff ff       	call   8009e4 <_panic>

00801c52 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
  801c55:	83 ec 18             	sub    $0x18,%esp
  801c58:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5b:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c5e:	e8 34 ff ff ff       	call   801b97 <uheap_init>
	if (size == 0) return NULL ;
  801c63:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c67:	75 07                	jne    801c70 <smalloc+0x1e>
  801c69:	b8 00 00 00 00       	mov    $0x0,%eax
  801c6e:	eb 14                	jmp    801c84 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801c70:	83 ec 04             	sub    $0x4,%esp
  801c73:	68 28 2f 80 00       	push   $0x802f28
  801c78:	6a 5f                	push   $0x5f
  801c7a:	68 99 2e 80 00       	push   $0x802e99
  801c7f:	e8 60 ed ff ff       	call   8009e4 <_panic>
}
  801c84:	c9                   	leave  
  801c85:	c3                   	ret    

00801c86 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
  801c89:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c8c:	e8 06 ff ff ff       	call   801b97 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801c91:	83 ec 04             	sub    $0x4,%esp
  801c94:	68 50 2f 80 00       	push   $0x802f50
  801c99:	6a 6f                	push   $0x6f
  801c9b:	68 99 2e 80 00       	push   $0x802e99
  801ca0:	e8 3f ed ff ff       	call   8009e4 <_panic>

00801ca5 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
  801ca8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801cab:	83 ec 04             	sub    $0x4,%esp
  801cae:	68 74 2f 80 00       	push   $0x802f74
  801cb3:	6a 7e                	push   $0x7e
  801cb5:	68 99 2e 80 00       	push   $0x802e99
  801cba:	e8 25 ed ff ff       	call   8009e4 <_panic>

00801cbf <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
  801cc2:	57                   	push   %edi
  801cc3:	56                   	push   %esi
  801cc4:	53                   	push   %ebx
  801cc5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cce:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cd1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cd4:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cd7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cda:	cd 30                	int    $0x30
  801cdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ce2:	83 c4 10             	add    $0x10,%esp
  801ce5:	5b                   	pop    %ebx
  801ce6:	5e                   	pop    %esi
  801ce7:	5f                   	pop    %edi
  801ce8:	5d                   	pop    %ebp
  801ce9:	c3                   	ret    

00801cea <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
  801ced:	83 ec 04             	sub    $0x4,%esp
  801cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  801cf3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801cf6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cf9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801d00:	6a 00                	push   $0x0
  801d02:	51                   	push   %ecx
  801d03:	52                   	push   %edx
  801d04:	ff 75 0c             	pushl  0xc(%ebp)
  801d07:	50                   	push   %eax
  801d08:	6a 00                	push   $0x0
  801d0a:	e8 b0 ff ff ff       	call   801cbf <syscall>
  801d0f:	83 c4 18             	add    $0x18,%esp
}
  801d12:	90                   	nop
  801d13:	c9                   	leave  
  801d14:	c3                   	ret    

00801d15 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d15:	55                   	push   %ebp
  801d16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 02                	push   $0x2
  801d24:	e8 96 ff ff ff       	call   801cbf <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_lock_cons>:

void sys_lock_cons(void)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 03                	push   $0x3
  801d3d:	e8 7d ff ff ff       	call   801cbf <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
}
  801d45:	90                   	nop
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 04                	push   $0x4
  801d57:	e8 63 ff ff ff       	call   801cbf <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
}
  801d5f:	90                   	nop
  801d60:	c9                   	leave  
  801d61:	c3                   	ret    

00801d62 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801d62:	55                   	push   %ebp
  801d63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d68:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	52                   	push   %edx
  801d72:	50                   	push   %eax
  801d73:	6a 08                	push   $0x8
  801d75:	e8 45 ff ff ff       	call   801cbf <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
}
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
  801d82:	56                   	push   %esi
  801d83:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d84:	8b 75 18             	mov    0x18(%ebp),%esi
  801d87:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d8a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d90:	8b 45 08             	mov    0x8(%ebp),%eax
  801d93:	56                   	push   %esi
  801d94:	53                   	push   %ebx
  801d95:	51                   	push   %ecx
  801d96:	52                   	push   %edx
  801d97:	50                   	push   %eax
  801d98:	6a 09                	push   $0x9
  801d9a:	e8 20 ff ff ff       	call   801cbf <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801da5:	5b                   	pop    %ebx
  801da6:	5e                   	pop    %esi
  801da7:	5d                   	pop    %ebp
  801da8:	c3                   	ret    

00801da9 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	ff 75 08             	pushl  0x8(%ebp)
  801db7:	6a 0a                	push   $0xa
  801db9:	e8 01 ff ff ff       	call   801cbf <syscall>
  801dbe:	83 c4 18             	add    $0x18,%esp
}
  801dc1:	c9                   	leave  
  801dc2:	c3                   	ret    

00801dc3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801dc3:	55                   	push   %ebp
  801dc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	ff 75 0c             	pushl  0xc(%ebp)
  801dcf:	ff 75 08             	pushl  0x8(%ebp)
  801dd2:	6a 0b                	push   $0xb
  801dd4:	e8 e6 fe ff ff       	call   801cbf <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
}
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 0c                	push   $0xc
  801ded:	e8 cd fe ff ff       	call   801cbf <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 0d                	push   $0xd
  801e06:	e8 b4 fe ff ff       	call   801cbf <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 0e                	push   $0xe
  801e1f:	e8 9b fe ff ff       	call   801cbf <syscall>
  801e24:	83 c4 18             	add    $0x18,%esp
}
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 0f                	push   $0xf
  801e38:	e8 82 fe ff ff       	call   801cbf <syscall>
  801e3d:	83 c4 18             	add    $0x18,%esp
}
  801e40:	c9                   	leave  
  801e41:	c3                   	ret    

00801e42 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e42:	55                   	push   %ebp
  801e43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	ff 75 08             	pushl  0x8(%ebp)
  801e50:	6a 10                	push   $0x10
  801e52:	e8 68 fe ff ff       	call   801cbf <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	c9                   	leave  
  801e5b:	c3                   	ret    

00801e5c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e5c:	55                   	push   %ebp
  801e5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 11                	push   $0x11
  801e6b:	e8 4f fe ff ff       	call   801cbf <syscall>
  801e70:	83 c4 18             	add    $0x18,%esp
}
  801e73:	90                   	nop
  801e74:	c9                   	leave  
  801e75:	c3                   	ret    

00801e76 <sys_cputc>:

void
sys_cputc(const char c)
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
  801e79:	83 ec 04             	sub    $0x4,%esp
  801e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e82:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	50                   	push   %eax
  801e8f:	6a 01                	push   $0x1
  801e91:	e8 29 fe ff ff       	call   801cbf <syscall>
  801e96:	83 c4 18             	add    $0x18,%esp
}
  801e99:	90                   	nop
  801e9a:	c9                   	leave  
  801e9b:	c3                   	ret    

00801e9c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e9c:	55                   	push   %ebp
  801e9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 14                	push   $0x14
  801eab:	e8 0f fe ff ff       	call   801cbf <syscall>
  801eb0:	83 c4 18             	add    $0x18,%esp
}
  801eb3:	90                   	nop
  801eb4:	c9                   	leave  
  801eb5:	c3                   	ret    

00801eb6 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801eb6:	55                   	push   %ebp
  801eb7:	89 e5                	mov    %esp,%ebp
  801eb9:	83 ec 04             	sub    $0x4,%esp
  801ebc:	8b 45 10             	mov    0x10(%ebp),%eax
  801ebf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801ec2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ec5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecc:	6a 00                	push   $0x0
  801ece:	51                   	push   %ecx
  801ecf:	52                   	push   %edx
  801ed0:	ff 75 0c             	pushl  0xc(%ebp)
  801ed3:	50                   	push   %eax
  801ed4:	6a 15                	push   $0x15
  801ed6:	e8 e4 fd ff ff       	call   801cbf <syscall>
  801edb:	83 c4 18             	add    $0x18,%esp
}
  801ede:	c9                   	leave  
  801edf:	c3                   	ret    

00801ee0 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801ee0:	55                   	push   %ebp
  801ee1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801ee3:	8b 55 10             	mov    0x10(%ebp),%edx
  801ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	52                   	push   %edx
  801eee:	50                   	push   %eax
  801eef:	ff 75 08             	pushl  0x8(%ebp)
  801ef2:	6a 16                	push   $0x16
  801ef4:	e8 c6 fd ff ff       	call   801cbf <syscall>
  801ef9:	83 c4 18             	add    $0x18,%esp
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801f01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f04:	8b 45 08             	mov    0x8(%ebp),%eax
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	52                   	push   %edx
  801f0e:	50                   	push   %eax
  801f0f:	6a 17                	push   $0x17
  801f11:	e8 a9 fd ff ff       	call   801cbf <syscall>
  801f16:	83 c4 18             	add    $0x18,%esp
}
  801f19:	c9                   	leave  
  801f1a:	c3                   	ret    

00801f1b <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801f1b:	55                   	push   %ebp
  801f1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801f1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f21:	8b 45 08             	mov    0x8(%ebp),%eax
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	52                   	push   %edx
  801f2b:	50                   	push   %eax
  801f2c:	6a 18                	push   $0x18
  801f2e:	e8 8c fd ff ff       	call   801cbf <syscall>
  801f33:	83 c4 18             	add    $0x18,%esp
}
  801f36:	c9                   	leave  
  801f37:	c3                   	ret    

00801f38 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f38:	55                   	push   %ebp
  801f39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3e:	6a 00                	push   $0x0
  801f40:	ff 75 14             	pushl  0x14(%ebp)
  801f43:	ff 75 10             	pushl  0x10(%ebp)
  801f46:	ff 75 0c             	pushl  0xc(%ebp)
  801f49:	50                   	push   %eax
  801f4a:	6a 19                	push   $0x19
  801f4c:	e8 6e fd ff ff       	call   801cbf <syscall>
  801f51:	83 c4 18             	add    $0x18,%esp
}
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f59:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	50                   	push   %eax
  801f65:	6a 1a                	push   $0x1a
  801f67:	e8 53 fd ff ff       	call   801cbf <syscall>
  801f6c:	83 c4 18             	add    $0x18,%esp
}
  801f6f:	90                   	nop
  801f70:	c9                   	leave  
  801f71:	c3                   	ret    

00801f72 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801f72:	55                   	push   %ebp
  801f73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801f75:	8b 45 08             	mov    0x8(%ebp),%eax
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	50                   	push   %eax
  801f81:	6a 1b                	push   $0x1b
  801f83:	e8 37 fd ff ff       	call   801cbf <syscall>
  801f88:	83 c4 18             	add    $0x18,%esp
}
  801f8b:	c9                   	leave  
  801f8c:	c3                   	ret    

00801f8d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f8d:	55                   	push   %ebp
  801f8e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 05                	push   $0x5
  801f9c:	e8 1e fd ff ff       	call   801cbf <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
}
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 06                	push   $0x6
  801fb5:	e8 05 fd ff ff       	call   801cbf <syscall>
  801fba:	83 c4 18             	add    $0x18,%esp
}
  801fbd:	c9                   	leave  
  801fbe:	c3                   	ret    

00801fbf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 07                	push   $0x7
  801fce:	e8 ec fc ff ff       	call   801cbf <syscall>
  801fd3:	83 c4 18             	add    $0x18,%esp
}
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <sys_exit_env>:


void sys_exit_env(void)
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 1c                	push   $0x1c
  801fe7:	e8 d3 fc ff ff       	call   801cbf <syscall>
  801fec:	83 c4 18             	add    $0x18,%esp
}
  801fef:	90                   	nop
  801ff0:	c9                   	leave  
  801ff1:	c3                   	ret    

00801ff2 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ff2:	55                   	push   %ebp
  801ff3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	ff 75 10             	pushl  0x10(%ebp)
  801ffc:	ff 75 0c             	pushl  0xc(%ebp)
  801fff:	ff 75 08             	pushl  0x8(%ebp)
  802002:	6a 13                	push   $0x13
  802004:	e8 b6 fc ff ff       	call   801cbf <syscall>
  802009:	83 c4 18             	add    $0x18,%esp
	return ;
  80200c:	90                   	nop
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_rcr2>:
uint32 sys_rcr2()
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 1e                	push   $0x1e
  80201e:	e8 9c fc ff ff       	call   801cbf <syscall>
  802023:	83 c4 18             	add    $0x18,%esp
}
  802026:	c9                   	leave  
  802027:	c3                   	ret    

00802028 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  802028:	55                   	push   %ebp
  802029:	89 e5                	mov    %esp,%ebp
  80202b:	83 ec 04             	sub    $0x4,%esp
  80202e:	8b 45 08             	mov    0x8(%ebp),%eax
  802031:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802034:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	50                   	push   %eax
  802041:	6a 1f                	push   $0x1f
  802043:	e8 77 fc ff ff       	call   801cbf <syscall>
  802048:	83 c4 18             	add    $0x18,%esp
	return ;
  80204b:	90                   	nop
}
  80204c:	c9                   	leave  
  80204d:	c3                   	ret    

0080204e <rsttst>:
void rsttst()
{
  80204e:	55                   	push   %ebp
  80204f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 21                	push   $0x21
  80205d:	e8 5d fc ff ff       	call   801cbf <syscall>
  802062:	83 c4 18             	add    $0x18,%esp
	return ;
  802065:	90                   	nop
}
  802066:	c9                   	leave  
  802067:	c3                   	ret    

00802068 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802068:	55                   	push   %ebp
  802069:	89 e5                	mov    %esp,%ebp
  80206b:	83 ec 04             	sub    $0x4,%esp
  80206e:	8b 45 14             	mov    0x14(%ebp),%eax
  802071:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802074:	8b 55 18             	mov    0x18(%ebp),%edx
  802077:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80207b:	52                   	push   %edx
  80207c:	50                   	push   %eax
  80207d:	ff 75 10             	pushl  0x10(%ebp)
  802080:	ff 75 0c             	pushl  0xc(%ebp)
  802083:	ff 75 08             	pushl  0x8(%ebp)
  802086:	6a 20                	push   $0x20
  802088:	e8 32 fc ff ff       	call   801cbf <syscall>
  80208d:	83 c4 18             	add    $0x18,%esp
	return ;
  802090:	90                   	nop
}
  802091:	c9                   	leave  
  802092:	c3                   	ret    

00802093 <chktst>:
void chktst(uint32 n)
{
  802093:	55                   	push   %ebp
  802094:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802096:	6a 00                	push   $0x0
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	ff 75 08             	pushl  0x8(%ebp)
  8020a1:	6a 22                	push   $0x22
  8020a3:	e8 17 fc ff ff       	call   801cbf <syscall>
  8020a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ab:	90                   	nop
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <inctst>:

void inctst()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 23                	push   $0x23
  8020bd:	e8 fd fb ff ff       	call   801cbf <syscall>
  8020c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020c5:	90                   	nop
}
  8020c6:	c9                   	leave  
  8020c7:	c3                   	ret    

008020c8 <gettst>:
uint32 gettst()
{
  8020c8:	55                   	push   %ebp
  8020c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 24                	push   $0x24
  8020d7:	e8 e3 fb ff ff       	call   801cbf <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
}
  8020df:	c9                   	leave  
  8020e0:	c3                   	ret    

008020e1 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8020e1:	55                   	push   %ebp
  8020e2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 25                	push   $0x25
  8020f0:	e8 ca fb ff ff       	call   801cbf <syscall>
  8020f5:	83 c4 18             	add    $0x18,%esp
  8020f8:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8020fd:	a1 48 40 80 00       	mov    0x804048,%eax
}
  802102:	c9                   	leave  
  802103:	c3                   	ret    

00802104 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802104:	55                   	push   %ebp
  802105:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  802107:	8b 45 08             	mov    0x8(%ebp),%eax
  80210a:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	ff 75 08             	pushl  0x8(%ebp)
  80211a:	6a 26                	push   $0x26
  80211c:	e8 9e fb ff ff       	call   801cbf <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
	return ;
  802124:	90                   	nop
}
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
  80212a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80212b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80212e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802131:	8b 55 0c             	mov    0xc(%ebp),%edx
  802134:	8b 45 08             	mov    0x8(%ebp),%eax
  802137:	6a 00                	push   $0x0
  802139:	53                   	push   %ebx
  80213a:	51                   	push   %ecx
  80213b:	52                   	push   %edx
  80213c:	50                   	push   %eax
  80213d:	6a 27                	push   $0x27
  80213f:	e8 7b fb ff ff       	call   801cbf <syscall>
  802144:	83 c4 18             	add    $0x18,%esp
}
  802147:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80214f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802152:	8b 45 08             	mov    0x8(%ebp),%eax
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	52                   	push   %edx
  80215c:	50                   	push   %eax
  80215d:	6a 28                	push   $0x28
  80215f:	e8 5b fb ff ff       	call   801cbf <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	c9                   	leave  
  802168:	c3                   	ret    

00802169 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802169:	55                   	push   %ebp
  80216a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80216c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80216f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802172:	8b 45 08             	mov    0x8(%ebp),%eax
  802175:	6a 00                	push   $0x0
  802177:	51                   	push   %ecx
  802178:	ff 75 10             	pushl  0x10(%ebp)
  80217b:	52                   	push   %edx
  80217c:	50                   	push   %eax
  80217d:	6a 29                	push   $0x29
  80217f:	e8 3b fb ff ff       	call   801cbf <syscall>
  802184:	83 c4 18             	add    $0x18,%esp
}
  802187:	c9                   	leave  
  802188:	c3                   	ret    

00802189 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802189:	55                   	push   %ebp
  80218a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	ff 75 10             	pushl  0x10(%ebp)
  802193:	ff 75 0c             	pushl  0xc(%ebp)
  802196:	ff 75 08             	pushl  0x8(%ebp)
  802199:	6a 12                	push   $0x12
  80219b:	e8 1f fb ff ff       	call   801cbf <syscall>
  8021a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a3:	90                   	nop
}
  8021a4:	c9                   	leave  
  8021a5:	c3                   	ret    

008021a6 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8021a6:	55                   	push   %ebp
  8021a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8021a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	52                   	push   %edx
  8021b6:	50                   	push   %eax
  8021b7:	6a 2a                	push   $0x2a
  8021b9:	e8 01 fb ff ff       	call   801cbf <syscall>
  8021be:	83 c4 18             	add    $0x18,%esp
	return;
  8021c1:	90                   	nop
}
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 2b                	push   $0x2b
  8021d3:	e8 e7 fa ff ff       	call   801cbf <syscall>
  8021d8:	83 c4 18             	add    $0x18,%esp
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
  8021e0:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8021e3:	83 ec 04             	sub    $0x4,%esp
  8021e6:	68 98 2f 80 00       	push   $0x802f98
  8021eb:	68 0a 01 00 00       	push   $0x10a
  8021f0:	68 a8 2f 80 00       	push   $0x802fa8
  8021f5:	e8 ea e7 ff ff       	call   8009e4 <_panic>

008021fa <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8021fa:	55                   	push   %ebp
  8021fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	ff 75 0c             	pushl  0xc(%ebp)
  802206:	ff 75 08             	pushl  0x8(%ebp)
  802209:	6a 33                	push   $0x33
  80220b:	e8 af fa ff ff       	call   801cbf <syscall>
  802210:	83 c4 18             	add    $0x18,%esp
	return;
  802213:	90                   	nop
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	ff 75 0c             	pushl  0xc(%ebp)
  802222:	ff 75 08             	pushl  0x8(%ebp)
  802225:	6a 34                	push   $0x34
  802227:	e8 93 fa ff ff       	call   801cbf <syscall>
  80222c:	83 c4 18             	add    $0x18,%esp
	return ;
  80222f:	90                   	nop
}
  802230:	c9                   	leave  
  802231:	c3                   	ret    

00802232 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802232:	55                   	push   %ebp
  802233:	89 e5                	mov    %esp,%ebp
  802235:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802238:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  80223f:	eb 36                	jmp    802277 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  802241:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802244:	c1 e0 04             	shl    $0x4,%eax
  802247:	05 60 40 80 00       	add    $0x804060,%eax
  80224c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802252:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802255:	c1 e0 04             	shl    $0x4,%eax
  802258:	05 64 40 80 00       	add    $0x804064,%eax
  80225d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802263:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802266:	c1 e0 04             	shl    $0x4,%eax
  802269:	05 6c 40 80 00       	add    $0x80406c,%eax
  80226e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802274:	ff 45 fc             	incl   -0x4(%ebp)
  802277:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  80227b:	7e c4                	jle    802241 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  80227d:	90                   	nop
  80227e:	c9                   	leave  
  80227f:	c3                   	ret    

00802280 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802280:	55                   	push   %ebp
  802281:	89 e5                	mov    %esp,%ebp
  802283:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802286:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  80228d:	eb 24                	jmp    8022b3 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  80228f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802292:	c1 e0 04             	shl    $0x4,%eax
  802295:	05 6c 40 80 00       	add    $0x80406c,%eax
  80229a:	8b 00                	mov    (%eax),%eax
  80229c:	83 ec 04             	sub    $0x4,%esp
  80229f:	50                   	push   %eax
  8022a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8022a3:	68 b8 2f 80 00       	push   $0x802fb8
  8022a8:	e8 05 ea ff ff       	call   800cb2 <cprintf>
  8022ad:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  8022b0:	ff 45 f4             	incl   -0xc(%ebp)
  8022b3:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  8022b7:	7e d6                	jle    80228f <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  8022b9:	90                   	nop
  8022ba:	c9                   	leave  
  8022bb:	c3                   	ret    

008022bc <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  8022bc:	55                   	push   %ebp
  8022bd:	89 e5                	mov    %esp,%ebp
  8022bf:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  8022c2:	83 ec 04             	sub    $0x4,%esp
  8022c5:	68 c8 2f 80 00       	push   $0x802fc8
  8022ca:	6a 33                	push   $0x33
  8022cc:	68 e9 2f 80 00       	push   $0x802fe9
  8022d1:	e8 0e e7 ff ff       	call   8009e4 <_panic>

008022d6 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  8022d6:	55                   	push   %ebp
  8022d7:	89 e5                	mov    %esp,%ebp
  8022d9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  8022dc:	83 ec 04             	sub    $0x4,%esp
  8022df:	68 01 30 80 00       	push   $0x803001
  8022e4:	6a 3e                	push   $0x3e
  8022e6:	68 e9 2f 80 00       	push   $0x802fe9
  8022eb:	e8 f4 e6 ff ff       	call   8009e4 <_panic>

008022f0 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8022f0:	55                   	push   %ebp
  8022f1:	89 e5                	mov    %esp,%ebp
  8022f3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8022f6:	83 ec 04             	sub    $0x4,%esp
  8022f9:	68 1f 30 80 00       	push   $0x80301f
  8022fe:	6a 49                	push   $0x49
  802300:	68 e9 2f 80 00       	push   $0x802fe9
  802305:	e8 da e6 ff ff       	call   8009e4 <_panic>

0080230a <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  80230a:	55                   	push   %ebp
  80230b:	89 e5                	mov    %esp,%ebp
  80230d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802310:	83 ec 04             	sub    $0x4,%esp
  802313:	68 3c 30 80 00       	push   $0x80303c
  802318:	6a 58                	push   $0x58
  80231a:	68 e9 2f 80 00       	push   $0x802fe9
  80231f:	e8 c0 e6 ff ff       	call   8009e4 <_panic>

00802324 <__udivdi3>:
  802324:	55                   	push   %ebp
  802325:	57                   	push   %edi
  802326:	56                   	push   %esi
  802327:	53                   	push   %ebx
  802328:	83 ec 1c             	sub    $0x1c,%esp
  80232b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80232f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802333:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802337:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80233b:	89 ca                	mov    %ecx,%edx
  80233d:	89 f8                	mov    %edi,%eax
  80233f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802343:	85 f6                	test   %esi,%esi
  802345:	75 2d                	jne    802374 <__udivdi3+0x50>
  802347:	39 cf                	cmp    %ecx,%edi
  802349:	77 65                	ja     8023b0 <__udivdi3+0x8c>
  80234b:	89 fd                	mov    %edi,%ebp
  80234d:	85 ff                	test   %edi,%edi
  80234f:	75 0b                	jne    80235c <__udivdi3+0x38>
  802351:	b8 01 00 00 00       	mov    $0x1,%eax
  802356:	31 d2                	xor    %edx,%edx
  802358:	f7 f7                	div    %edi
  80235a:	89 c5                	mov    %eax,%ebp
  80235c:	31 d2                	xor    %edx,%edx
  80235e:	89 c8                	mov    %ecx,%eax
  802360:	f7 f5                	div    %ebp
  802362:	89 c1                	mov    %eax,%ecx
  802364:	89 d8                	mov    %ebx,%eax
  802366:	f7 f5                	div    %ebp
  802368:	89 cf                	mov    %ecx,%edi
  80236a:	89 fa                	mov    %edi,%edx
  80236c:	83 c4 1c             	add    $0x1c,%esp
  80236f:	5b                   	pop    %ebx
  802370:	5e                   	pop    %esi
  802371:	5f                   	pop    %edi
  802372:	5d                   	pop    %ebp
  802373:	c3                   	ret    
  802374:	39 ce                	cmp    %ecx,%esi
  802376:	77 28                	ja     8023a0 <__udivdi3+0x7c>
  802378:	0f bd fe             	bsr    %esi,%edi
  80237b:	83 f7 1f             	xor    $0x1f,%edi
  80237e:	75 40                	jne    8023c0 <__udivdi3+0x9c>
  802380:	39 ce                	cmp    %ecx,%esi
  802382:	72 0a                	jb     80238e <__udivdi3+0x6a>
  802384:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802388:	0f 87 9e 00 00 00    	ja     80242c <__udivdi3+0x108>
  80238e:	b8 01 00 00 00       	mov    $0x1,%eax
  802393:	89 fa                	mov    %edi,%edx
  802395:	83 c4 1c             	add    $0x1c,%esp
  802398:	5b                   	pop    %ebx
  802399:	5e                   	pop    %esi
  80239a:	5f                   	pop    %edi
  80239b:	5d                   	pop    %ebp
  80239c:	c3                   	ret    
  80239d:	8d 76 00             	lea    0x0(%esi),%esi
  8023a0:	31 ff                	xor    %edi,%edi
  8023a2:	31 c0                	xor    %eax,%eax
  8023a4:	89 fa                	mov    %edi,%edx
  8023a6:	83 c4 1c             	add    $0x1c,%esp
  8023a9:	5b                   	pop    %ebx
  8023aa:	5e                   	pop    %esi
  8023ab:	5f                   	pop    %edi
  8023ac:	5d                   	pop    %ebp
  8023ad:	c3                   	ret    
  8023ae:	66 90                	xchg   %ax,%ax
  8023b0:	89 d8                	mov    %ebx,%eax
  8023b2:	f7 f7                	div    %edi
  8023b4:	31 ff                	xor    %edi,%edi
  8023b6:	89 fa                	mov    %edi,%edx
  8023b8:	83 c4 1c             	add    $0x1c,%esp
  8023bb:	5b                   	pop    %ebx
  8023bc:	5e                   	pop    %esi
  8023bd:	5f                   	pop    %edi
  8023be:	5d                   	pop    %ebp
  8023bf:	c3                   	ret    
  8023c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023c5:	89 eb                	mov    %ebp,%ebx
  8023c7:	29 fb                	sub    %edi,%ebx
  8023c9:	89 f9                	mov    %edi,%ecx
  8023cb:	d3 e6                	shl    %cl,%esi
  8023cd:	89 c5                	mov    %eax,%ebp
  8023cf:	88 d9                	mov    %bl,%cl
  8023d1:	d3 ed                	shr    %cl,%ebp
  8023d3:	89 e9                	mov    %ebp,%ecx
  8023d5:	09 f1                	or     %esi,%ecx
  8023d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023db:	89 f9                	mov    %edi,%ecx
  8023dd:	d3 e0                	shl    %cl,%eax
  8023df:	89 c5                	mov    %eax,%ebp
  8023e1:	89 d6                	mov    %edx,%esi
  8023e3:	88 d9                	mov    %bl,%cl
  8023e5:	d3 ee                	shr    %cl,%esi
  8023e7:	89 f9                	mov    %edi,%ecx
  8023e9:	d3 e2                	shl    %cl,%edx
  8023eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ef:	88 d9                	mov    %bl,%cl
  8023f1:	d3 e8                	shr    %cl,%eax
  8023f3:	09 c2                	or     %eax,%edx
  8023f5:	89 d0                	mov    %edx,%eax
  8023f7:	89 f2                	mov    %esi,%edx
  8023f9:	f7 74 24 0c          	divl   0xc(%esp)
  8023fd:	89 d6                	mov    %edx,%esi
  8023ff:	89 c3                	mov    %eax,%ebx
  802401:	f7 e5                	mul    %ebp
  802403:	39 d6                	cmp    %edx,%esi
  802405:	72 19                	jb     802420 <__udivdi3+0xfc>
  802407:	74 0b                	je     802414 <__udivdi3+0xf0>
  802409:	89 d8                	mov    %ebx,%eax
  80240b:	31 ff                	xor    %edi,%edi
  80240d:	e9 58 ff ff ff       	jmp    80236a <__udivdi3+0x46>
  802412:	66 90                	xchg   %ax,%ax
  802414:	8b 54 24 08          	mov    0x8(%esp),%edx
  802418:	89 f9                	mov    %edi,%ecx
  80241a:	d3 e2                	shl    %cl,%edx
  80241c:	39 c2                	cmp    %eax,%edx
  80241e:	73 e9                	jae    802409 <__udivdi3+0xe5>
  802420:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802423:	31 ff                	xor    %edi,%edi
  802425:	e9 40 ff ff ff       	jmp    80236a <__udivdi3+0x46>
  80242a:	66 90                	xchg   %ax,%ax
  80242c:	31 c0                	xor    %eax,%eax
  80242e:	e9 37 ff ff ff       	jmp    80236a <__udivdi3+0x46>
  802433:	90                   	nop

00802434 <__umoddi3>:
  802434:	55                   	push   %ebp
  802435:	57                   	push   %edi
  802436:	56                   	push   %esi
  802437:	53                   	push   %ebx
  802438:	83 ec 1c             	sub    $0x1c,%esp
  80243b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80243f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802443:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802447:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80244b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80244f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802453:	89 f3                	mov    %esi,%ebx
  802455:	89 fa                	mov    %edi,%edx
  802457:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80245b:	89 34 24             	mov    %esi,(%esp)
  80245e:	85 c0                	test   %eax,%eax
  802460:	75 1a                	jne    80247c <__umoddi3+0x48>
  802462:	39 f7                	cmp    %esi,%edi
  802464:	0f 86 a2 00 00 00    	jbe    80250c <__umoddi3+0xd8>
  80246a:	89 c8                	mov    %ecx,%eax
  80246c:	89 f2                	mov    %esi,%edx
  80246e:	f7 f7                	div    %edi
  802470:	89 d0                	mov    %edx,%eax
  802472:	31 d2                	xor    %edx,%edx
  802474:	83 c4 1c             	add    $0x1c,%esp
  802477:	5b                   	pop    %ebx
  802478:	5e                   	pop    %esi
  802479:	5f                   	pop    %edi
  80247a:	5d                   	pop    %ebp
  80247b:	c3                   	ret    
  80247c:	39 f0                	cmp    %esi,%eax
  80247e:	0f 87 ac 00 00 00    	ja     802530 <__umoddi3+0xfc>
  802484:	0f bd e8             	bsr    %eax,%ebp
  802487:	83 f5 1f             	xor    $0x1f,%ebp
  80248a:	0f 84 ac 00 00 00    	je     80253c <__umoddi3+0x108>
  802490:	bf 20 00 00 00       	mov    $0x20,%edi
  802495:	29 ef                	sub    %ebp,%edi
  802497:	89 fe                	mov    %edi,%esi
  802499:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80249d:	89 e9                	mov    %ebp,%ecx
  80249f:	d3 e0                	shl    %cl,%eax
  8024a1:	89 d7                	mov    %edx,%edi
  8024a3:	89 f1                	mov    %esi,%ecx
  8024a5:	d3 ef                	shr    %cl,%edi
  8024a7:	09 c7                	or     %eax,%edi
  8024a9:	89 e9                	mov    %ebp,%ecx
  8024ab:	d3 e2                	shl    %cl,%edx
  8024ad:	89 14 24             	mov    %edx,(%esp)
  8024b0:	89 d8                	mov    %ebx,%eax
  8024b2:	d3 e0                	shl    %cl,%eax
  8024b4:	89 c2                	mov    %eax,%edx
  8024b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ba:	d3 e0                	shl    %cl,%eax
  8024bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024c4:	89 f1                	mov    %esi,%ecx
  8024c6:	d3 e8                	shr    %cl,%eax
  8024c8:	09 d0                	or     %edx,%eax
  8024ca:	d3 eb                	shr    %cl,%ebx
  8024cc:	89 da                	mov    %ebx,%edx
  8024ce:	f7 f7                	div    %edi
  8024d0:	89 d3                	mov    %edx,%ebx
  8024d2:	f7 24 24             	mull   (%esp)
  8024d5:	89 c6                	mov    %eax,%esi
  8024d7:	89 d1                	mov    %edx,%ecx
  8024d9:	39 d3                	cmp    %edx,%ebx
  8024db:	0f 82 87 00 00 00    	jb     802568 <__umoddi3+0x134>
  8024e1:	0f 84 91 00 00 00    	je     802578 <__umoddi3+0x144>
  8024e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024eb:	29 f2                	sub    %esi,%edx
  8024ed:	19 cb                	sbb    %ecx,%ebx
  8024ef:	89 d8                	mov    %ebx,%eax
  8024f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024f5:	d3 e0                	shl    %cl,%eax
  8024f7:	89 e9                	mov    %ebp,%ecx
  8024f9:	d3 ea                	shr    %cl,%edx
  8024fb:	09 d0                	or     %edx,%eax
  8024fd:	89 e9                	mov    %ebp,%ecx
  8024ff:	d3 eb                	shr    %cl,%ebx
  802501:	89 da                	mov    %ebx,%edx
  802503:	83 c4 1c             	add    $0x1c,%esp
  802506:	5b                   	pop    %ebx
  802507:	5e                   	pop    %esi
  802508:	5f                   	pop    %edi
  802509:	5d                   	pop    %ebp
  80250a:	c3                   	ret    
  80250b:	90                   	nop
  80250c:	89 fd                	mov    %edi,%ebp
  80250e:	85 ff                	test   %edi,%edi
  802510:	75 0b                	jne    80251d <__umoddi3+0xe9>
  802512:	b8 01 00 00 00       	mov    $0x1,%eax
  802517:	31 d2                	xor    %edx,%edx
  802519:	f7 f7                	div    %edi
  80251b:	89 c5                	mov    %eax,%ebp
  80251d:	89 f0                	mov    %esi,%eax
  80251f:	31 d2                	xor    %edx,%edx
  802521:	f7 f5                	div    %ebp
  802523:	89 c8                	mov    %ecx,%eax
  802525:	f7 f5                	div    %ebp
  802527:	89 d0                	mov    %edx,%eax
  802529:	e9 44 ff ff ff       	jmp    802472 <__umoddi3+0x3e>
  80252e:	66 90                	xchg   %ax,%ax
  802530:	89 c8                	mov    %ecx,%eax
  802532:	89 f2                	mov    %esi,%edx
  802534:	83 c4 1c             	add    $0x1c,%esp
  802537:	5b                   	pop    %ebx
  802538:	5e                   	pop    %esi
  802539:	5f                   	pop    %edi
  80253a:	5d                   	pop    %ebp
  80253b:	c3                   	ret    
  80253c:	3b 04 24             	cmp    (%esp),%eax
  80253f:	72 06                	jb     802547 <__umoddi3+0x113>
  802541:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802545:	77 0f                	ja     802556 <__umoddi3+0x122>
  802547:	89 f2                	mov    %esi,%edx
  802549:	29 f9                	sub    %edi,%ecx
  80254b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80254f:	89 14 24             	mov    %edx,(%esp)
  802552:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802556:	8b 44 24 04          	mov    0x4(%esp),%eax
  80255a:	8b 14 24             	mov    (%esp),%edx
  80255d:	83 c4 1c             	add    $0x1c,%esp
  802560:	5b                   	pop    %ebx
  802561:	5e                   	pop    %esi
  802562:	5f                   	pop    %edi
  802563:	5d                   	pop    %ebp
  802564:	c3                   	ret    
  802565:	8d 76 00             	lea    0x0(%esi),%esi
  802568:	2b 04 24             	sub    (%esp),%eax
  80256b:	19 fa                	sbb    %edi,%edx
  80256d:	89 d1                	mov    %edx,%ecx
  80256f:	89 c6                	mov    %eax,%esi
  802571:	e9 71 ff ff ff       	jmp    8024e7 <__umoddi3+0xb3>
  802576:	66 90                	xchg   %ax,%ax
  802578:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80257c:	72 ea                	jb     802568 <__umoddi3+0x134>
  80257e:	89 d9                	mov    %ebx,%ecx
  802580:	e9 62 ff ff ff       	jmp    8024e7 <__umoddi3+0xb3>
