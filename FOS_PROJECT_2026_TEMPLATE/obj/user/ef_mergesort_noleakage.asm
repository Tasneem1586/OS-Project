
obj/user/ef_mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 35 07 00 00       	call   80076b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_lock_cons();
  800041:	e8 cf 1c 00 00       	call   801d15 <sys_lock_cons>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 80 25 80 00       	push   $0x802580
  80004e:	e8 46 0c 00 00       	call   800c99 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 82 25 80 00       	push   $0x802582
  80005e:	e8 36 0c 00 00       	call   800c99 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 98 25 80 00       	push   $0x802598
  80006e:	e8 26 0c 00 00       	call   800c99 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 82 25 80 00       	push   $0x802582
  80007e:	e8 16 0c 00 00       	call   800c99 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 25 80 00       	push   $0x802580
  80008e:	e8 06 0c 00 00       	call   800c99 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		cprintf("Enter the number of elements: ");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 b0 25 80 00       	push   $0x8025b0
  80009e:	e8 f6 0b 00 00       	call   800c99 <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 2000 ;
  8000a6:	c7 45 f0 d0 07 00 00 	movl   $0x7d0,-0x10(%ebp)
		cprintf("%d\n", NumOfElements) ;
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b3:	68 cf 25 80 00       	push   $0x8025cf
  8000b8:	e8 dc 0b 00 00       	call   800c99 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c3:	c1 e0 02             	shl    $0x2,%eax
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	50                   	push   %eax
  8000ca:	e8 22 1b 00 00       	call   801bf1 <malloc>
  8000cf:	83 c4 10             	add    $0x10,%esp
  8000d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 d4 25 80 00       	push   $0x8025d4
  8000dd:	e8 b7 0b 00 00       	call   800c99 <cprintf>
  8000e2:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 f6 25 80 00       	push   $0x8025f6
  8000ed:	e8 a7 0b 00 00       	call   800c99 <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 04 26 80 00       	push   $0x802604
  8000fd:	e8 97 0b 00 00       	call   800c99 <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 13 26 80 00       	push   $0x802613
  80010d:	e8 87 0b 00 00       	call   800c99 <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 23 26 80 00       	push   $0x802623
  80011d:	e8 77 0b 00 00       	call   800c99 <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'a';
  800125:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
			cputchar(Chose);
  800129:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	50                   	push   %eax
  800131:	e8 f3 05 00 00       	call   800729 <cputchar>
  800136:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800139:	83 ec 0c             	sub    $0xc,%esp
  80013c:	6a 0a                	push   $0xa
  80013e:	e8 e6 05 00 00       	call   800729 <cputchar>
  800143:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800146:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80014a:	74 0c                	je     800158 <_main+0x120>
  80014c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800150:	74 06                	je     800158 <_main+0x120>
  800152:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800156:	75 bd                	jne    800115 <_main+0xdd>

		//2012: lock the interrupt
		sys_unlock_cons();
  800158:	e8 d2 1b 00 00       	call   801d2f <sys_unlock_cons>

		int  i ;
		switch (Chose)
  80015d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800161:	83 f8 62             	cmp    $0x62,%eax
  800164:	74 1d                	je     800183 <_main+0x14b>
  800166:	83 f8 63             	cmp    $0x63,%eax
  800169:	74 2b                	je     800196 <_main+0x15e>
  80016b:	83 f8 61             	cmp    $0x61,%eax
  80016e:	75 39                	jne    8001a9 <_main+0x171>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 f0             	pushl  -0x10(%ebp)
  800176:	ff 75 ec             	pushl  -0x14(%ebp)
  800179:	e8 f5 01 00 00       	call   800373 <InitializeAscending>
  80017e:	83 c4 10             	add    $0x10,%esp
			break ;
  800181:	eb 37                	jmp    8001ba <_main+0x182>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 f0             	pushl  -0x10(%ebp)
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	e8 13 02 00 00       	call   8003a4 <InitializeIdentical>
  800191:	83 c4 10             	add    $0x10,%esp
			break ;
  800194:	eb 24                	jmp    8001ba <_main+0x182>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	ff 75 f0             	pushl  -0x10(%ebp)
  80019c:	ff 75 ec             	pushl  -0x14(%ebp)
  80019f:	e8 35 02 00 00       	call   8003d9 <InitializeSemiRandom>
  8001a4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a7:	eb 11                	jmp    8001ba <_main+0x182>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8001af:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b2:	e8 22 02 00 00       	call   8003d9 <InitializeSemiRandom>
  8001b7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	ff 75 f0             	pushl  -0x10(%ebp)
  8001c0:	6a 01                	push   $0x1
  8001c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c5:	e8 ee 02 00 00       	call   8004b8 <MSort>
  8001ca:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001cd:	e8 43 1b 00 00       	call   801d15 <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 2c 26 80 00       	push   $0x80262c
  8001da:	e8 ba 0a 00 00       	call   800c99 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  8001e2:	e8 48 1b 00 00       	call   801d2f <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f0:	e8 d4 00 00 00       	call   8002c9 <CheckSorted>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ff:	75 14                	jne    800215 <_main+0x1dd>
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	68 60 26 80 00       	push   $0x802660
  800209:	6a 4e                	push   $0x4e
  80020b:	68 82 26 80 00       	push   $0x802682
  800210:	e8 b6 07 00 00       	call   8009cb <_panic>
		else
		{
			sys_lock_cons();
  800215:	e8 fb 1a 00 00       	call   801d15 <sys_lock_cons>
			cprintf("===============================================\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 a0 26 80 00       	push   $0x8026a0
  800222:	e8 72 0a 00 00       	call   800c99 <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 d4 26 80 00       	push   $0x8026d4
  800232:	e8 62 0a 00 00       	call   800c99 <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 08 27 80 00       	push   $0x802708
  800242:	e8 52 0a 00 00       	call   800c99 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  80024a:	e8 e0 1a 00 00       	call   801d2f <sys_unlock_cons>
		}

		free(Elements) ;
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	ff 75 ec             	pushl  -0x14(%ebp)
  800255:	e8 c5 19 00 00       	call   801c1f <free>
  80025a:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80025d:	e8 b3 1a 00 00       	call   801d15 <sys_lock_cons>
			Chose = 0 ;
  800262:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800266:	eb 3e                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	68 3a 27 80 00       	push   $0x80273a
  800270:	e8 24 0a 00 00       	call   800c99 <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800278:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 a0 04 00 00       	call   800729 <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 93 04 00 00       	call   800729 <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 86 04 00 00       	call   800729 <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_lock_cons();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b6                	jne    800268 <_main+0x230>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_unlock_cons();
  8002b2:	e8 78 1a 00 00       	call   801d2f <sys_unlock_cons>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>

	//To indicate that it's completed successfully
	inctst();
  8002c1:	e8 cf 1d 00 00       	call   802095 <inctst>

}
  8002c6:	90                   	nop
  8002c7:	c9                   	leave  
  8002c8:	c3                   	ret    

008002c9 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c9:	55                   	push   %ebp
  8002ca:	89 e5                	mov    %esp,%ebp
  8002cc:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002cf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002dd:	eb 33                	jmp    800312 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ec:	01 d0                	add    %edx,%eax
  8002ee:	8b 10                	mov    (%eax),%edx
  8002f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002f3:	40                   	inc    %eax
  8002f4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fe:	01 c8                	add    %ecx,%eax
  800300:	8b 00                	mov    (%eax),%eax
  800302:	39 c2                	cmp    %eax,%edx
  800304:	7e 09                	jle    80030f <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80030d:	eb 0c                	jmp    80031b <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030f:	ff 45 f8             	incl   -0x8(%ebp)
  800312:	8b 45 0c             	mov    0xc(%ebp),%eax
  800315:	48                   	dec    %eax
  800316:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800319:	7f c4                	jg     8002df <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80031b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80031e:	c9                   	leave  
  80031f:	c3                   	ret    

00800320 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800320:	55                   	push   %ebp
  800321:	89 e5                	mov    %esp,%ebp
  800323:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800326:	8b 45 0c             	mov    0xc(%ebp),%eax
  800329:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800330:	8b 45 08             	mov    0x8(%ebp),%eax
  800333:	01 d0                	add    %edx,%eax
  800335:	8b 00                	mov    (%eax),%eax
  800337:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80033a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80033d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800344:	8b 45 08             	mov    0x8(%ebp),%eax
  800347:	01 c2                	add    %eax,%edx
  800349:	8b 45 10             	mov    0x10(%ebp),%eax
  80034c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800353:	8b 45 08             	mov    0x8(%ebp),%eax
  800356:	01 c8                	add    %ecx,%eax
  800358:	8b 00                	mov    (%eax),%eax
  80035a:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80035c:	8b 45 10             	mov    0x10(%ebp),%eax
  80035f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	01 c2                	add    %eax,%edx
  80036b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80036e:	89 02                	mov    %eax,(%edx)
}
  800370:	90                   	nop
  800371:	c9                   	leave  
  800372:	c3                   	ret    

00800373 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800373:	55                   	push   %ebp
  800374:	89 e5                	mov    %esp,%ebp
  800376:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800379:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800380:	eb 17                	jmp    800399 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800382:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800385:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038c:	8b 45 08             	mov    0x8(%ebp),%eax
  80038f:	01 c2                	add    %eax,%edx
  800391:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800394:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800396:	ff 45 fc             	incl   -0x4(%ebp)
  800399:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039f:	7c e1                	jl     800382 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003a1:	90                   	nop
  8003a2:	c9                   	leave  
  8003a3:	c3                   	ret    

008003a4 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  8003a4:	55                   	push   %ebp
  8003a5:	89 e5                	mov    %esp,%ebp
  8003a7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003b1:	eb 1b                	jmp    8003ce <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c0:	01 c2                	add    %eax,%edx
  8003c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c5:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c8:	48                   	dec    %eax
  8003c9:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003cb:	ff 45 fc             	incl   -0x4(%ebp)
  8003ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003d4:	7c dd                	jl     8003b3 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d6:	90                   	nop
  8003d7:	c9                   	leave  
  8003d8:	c3                   	ret    

008003d9 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d9:	55                   	push   %ebp
  8003da:	89 e5                	mov    %esp,%ebp
  8003dc:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003df:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003e2:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e7:	f7 e9                	imul   %ecx
  8003e9:	c1 f9 1f             	sar    $0x1f,%ecx
  8003ec:	89 d0                	mov    %edx,%eax
  8003ee:	29 c8                	sub    %ecx,%eax
  8003f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8003f3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8003f7:	75 07                	jne    800400 <InitializeSemiRandom+0x27>
			Repetition = 3;
  8003f9:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800400:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800407:	eb 1e                	jmp    800427 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  800409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800419:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041c:	99                   	cltd   
  80041d:	f7 7d f8             	idivl  -0x8(%ebp)
  800420:	89 d0                	mov    %edx,%eax
  800422:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800424:	ff 45 fc             	incl   -0x4(%ebp)
  800427:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80042a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80042d:	7c da                	jl     800409 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042f:	90                   	nop
  800430:	c9                   	leave  
  800431:	c3                   	ret    

00800432 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800432:	55                   	push   %ebp
  800433:	89 e5                	mov    %esp,%ebp
  800435:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800438:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800446:	eb 42                	jmp    80048a <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800448:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80044b:	99                   	cltd   
  80044c:	f7 7d f0             	idivl  -0x10(%ebp)
  80044f:	89 d0                	mov    %edx,%eax
  800451:	85 c0                	test   %eax,%eax
  800453:	75 10                	jne    800465 <PrintElements+0x33>
			cprintf("\n");
  800455:	83 ec 0c             	sub    $0xc,%esp
  800458:	68 80 25 80 00       	push   $0x802580
  80045d:	e8 37 08 00 00       	call   800c99 <cprintf>
  800462:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800465:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800468:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	01 d0                	add    %edx,%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	83 ec 08             	sub    $0x8,%esp
  800479:	50                   	push   %eax
  80047a:	68 58 27 80 00       	push   $0x802758
  80047f:	e8 15 08 00 00       	call   800c99 <cprintf>
  800484:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800487:	ff 45 f4             	incl   -0xc(%ebp)
  80048a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048d:	48                   	dec    %eax
  80048e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800491:	7f b5                	jg     800448 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800493:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800496:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80049d:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a0:	01 d0                	add    %edx,%eax
  8004a2:	8b 00                	mov    (%eax),%eax
  8004a4:	83 ec 08             	sub    $0x8,%esp
  8004a7:	50                   	push   %eax
  8004a8:	68 cf 25 80 00       	push   $0x8025cf
  8004ad:	e8 e7 07 00 00       	call   800c99 <cprintf>
  8004b2:	83 c4 10             	add    $0x10,%esp

}
  8004b5:	90                   	nop
  8004b6:	c9                   	leave  
  8004b7:	c3                   	ret    

008004b8 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b8:	55                   	push   %ebp
  8004b9:	89 e5                	mov    %esp,%ebp
  8004bb:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c4:	7d 54                	jge    80051a <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cc:	01 d0                	add    %edx,%eax
  8004ce:	89 c2                	mov    %eax,%edx
  8004d0:	c1 ea 1f             	shr    $0x1f,%edx
  8004d3:	01 d0                	add    %edx,%eax
  8004d5:	d1 f8                	sar    %eax
  8004d7:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004da:	83 ec 04             	sub    $0x4,%esp
  8004dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8004e0:	ff 75 0c             	pushl  0xc(%ebp)
  8004e3:	ff 75 08             	pushl  0x8(%ebp)
  8004e6:	e8 cd ff ff ff       	call   8004b8 <MSort>
  8004eb:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004f1:	40                   	inc    %eax
  8004f2:	83 ec 04             	sub    $0x4,%esp
  8004f5:	ff 75 10             	pushl  0x10(%ebp)
  8004f8:	50                   	push   %eax
  8004f9:	ff 75 08             	pushl  0x8(%ebp)
  8004fc:	e8 b7 ff ff ff       	call   8004b8 <MSort>
  800501:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800504:	ff 75 10             	pushl  0x10(%ebp)
  800507:	ff 75 f4             	pushl  -0xc(%ebp)
  80050a:	ff 75 0c             	pushl  0xc(%ebp)
  80050d:	ff 75 08             	pushl  0x8(%ebp)
  800510:	e8 08 00 00 00       	call   80051d <Merge>
  800515:	83 c4 10             	add    $0x10,%esp
  800518:	eb 01                	jmp    80051b <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80051a:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80051b:	c9                   	leave  
  80051c:	c3                   	ret    

0080051d <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80051d:	55                   	push   %ebp
  80051e:	89 e5                	mov    %esp,%ebp
  800520:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800523:	8b 45 10             	mov    0x10(%ebp),%eax
  800526:	2b 45 0c             	sub    0xc(%ebp),%eax
  800529:	40                   	inc    %eax
  80052a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80052d:	8b 45 14             	mov    0x14(%ebp),%eax
  800530:	2b 45 10             	sub    0x10(%ebp),%eax
  800533:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800536:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80053d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800544:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800547:	c1 e0 02             	shl    $0x2,%eax
  80054a:	83 ec 0c             	sub    $0xc,%esp
  80054d:	50                   	push   %eax
  80054e:	e8 9e 16 00 00       	call   801bf1 <malloc>
  800553:	83 c4 10             	add    $0x10,%esp
  800556:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800559:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80055c:	c1 e0 02             	shl    $0x2,%eax
  80055f:	83 ec 0c             	sub    $0xc,%esp
  800562:	50                   	push   %eax
  800563:	e8 89 16 00 00       	call   801bf1 <malloc>
  800568:	83 c4 10             	add    $0x10,%esp
  80056b:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800575:	eb 2f                	jmp    8005a6 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800581:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800584:	01 c2                	add    %eax,%edx
  800586:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800589:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80058c:	01 c8                	add    %ecx,%eax
  80058e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800593:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	01 c8                	add    %ecx,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005a3:	ff 45 ec             	incl   -0x14(%ebp)
  8005a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005ac:	7c c9                	jl     800577 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b5:	eb 2a                	jmp    8005e1 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c4:	01 c2                	add    %eax,%edx
  8005c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005cc:	01 c8                	add    %ecx,%eax
  8005ce:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d8:	01 c8                	add    %ecx,%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005de:	ff 45 e8             	incl   -0x18(%ebp)
  8005e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e4:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e7:	7c ce                	jl     8005b7 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ef:	e9 0a 01 00 00       	jmp    8006fe <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005fa:	0f 8d 95 00 00 00    	jge    800695 <Merge+0x178>
  800600:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800603:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800606:	0f 8d 89 00 00 00    	jge    800695 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80060c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800616:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800619:	01 d0                	add    %edx,%eax
  80061b:	8b 10                	mov    (%eax),%edx
  80061d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800620:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800627:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80062a:	01 c8                	add    %ecx,%eax
  80062c:	8b 00                	mov    (%eax),%eax
  80062e:	39 c2                	cmp    %eax,%edx
  800630:	7d 33                	jge    800665 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800632:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800635:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80063a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800647:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80064a:	8d 50 01             	lea    0x1(%eax),%edx
  80064d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800650:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800657:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80065a:	01 d0                	add    %edx,%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800660:	e9 96 00 00 00       	jmp    8006fb <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800665:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800668:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80066d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80067a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067d:	8d 50 01             	lea    0x1(%eax),%edx
  800680:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800683:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80068a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80068d:	01 d0                	add    %edx,%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800693:	eb 66                	jmp    8006fb <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800695:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800698:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80069b:	7d 30                	jge    8006cd <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80069d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a0:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b5:	8d 50 01             	lea    0x1(%eax),%edx
  8006b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c5:	01 d0                	add    %edx,%eax
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	89 01                	mov    %eax,(%ecx)
  8006cb:	eb 2e                	jmp    8006fb <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006d0:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e5:	8d 50 01             	lea    0x1(%eax),%edx
  8006e8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f5:	01 d0                	add    %edx,%eax
  8006f7:	8b 00                	mov    (%eax),%eax
  8006f9:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006fb:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800701:	3b 45 14             	cmp    0x14(%ebp),%eax
  800704:	0f 8e ea fe ff ff    	jle    8005f4 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  80070a:	83 ec 0c             	sub    $0xc,%esp
  80070d:	ff 75 d8             	pushl  -0x28(%ebp)
  800710:	e8 0a 15 00 00       	call   801c1f <free>
  800715:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800718:	83 ec 0c             	sub    $0xc,%esp
  80071b:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071e:	e8 fc 14 00 00       	call   801c1f <free>
  800723:	83 c4 10             	add    $0x10,%esp

}
  800726:	90                   	nop
  800727:	c9                   	leave  
  800728:	c3                   	ret    

00800729 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800729:	55                   	push   %ebp
  80072a:	89 e5                	mov    %esp,%ebp
  80072c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800735:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800739:	83 ec 0c             	sub    $0xc,%esp
  80073c:	50                   	push   %eax
  80073d:	e8 1b 17 00 00       	call   801e5d <sys_cputc>
  800742:	83 c4 10             	add    $0x10,%esp
}
  800745:	90                   	nop
  800746:	c9                   	leave  
  800747:	c3                   	ret    

00800748 <getchar>:


int
getchar(void)
{
  800748:	55                   	push   %ebp
  800749:	89 e5                	mov    %esp,%ebp
  80074b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  80074e:	e8 a9 15 00 00       	call   801cfc <sys_cgetc>
  800753:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800756:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80075a:	74 f2                	je     80074e <getchar+0x6>
	return c;
  80075c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <iscons>:

int iscons(int fdnum)
{
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800764:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800769:	5d                   	pop    %ebp
  80076a:	c3                   	ret    

0080076b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80076b:	55                   	push   %ebp
  80076c:	89 e5                	mov    %esp,%ebp
  80076e:	57                   	push   %edi
  80076f:	56                   	push   %esi
  800770:	53                   	push   %ebx
  800771:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800777:	e8 11 18 00 00       	call   801f8d <sys_getenvindex>
  80077c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80077f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800782:	89 d0                	mov    %edx,%eax
  800784:	c1 e0 03             	shl    $0x3,%eax
  800787:	01 d0                	add    %edx,%eax
  800789:	c1 e0 06             	shl    $0x6,%eax
  80078c:	01 d0                	add    %edx,%eax
  80078e:	c1 e0 03             	shl    $0x3,%eax
  800791:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800796:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80079b:	a1 24 40 80 00       	mov    0x804024,%eax
  8007a0:	8a 40 10             	mov    0x10(%eax),%al
  8007a3:	84 c0                	test   %al,%al
  8007a5:	74 0d                	je     8007b4 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8007a7:	a1 24 40 80 00       	mov    0x804024,%eax
  8007ac:	83 c0 10             	add    $0x10,%eax
  8007af:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007b4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007b8:	7e 0a                	jle    8007c4 <libmain+0x59>
		binaryname = argv[0];
  8007ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007bd:	8b 00                	mov    (%eax),%eax
  8007bf:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ca:	ff 75 08             	pushl  0x8(%ebp)
  8007cd:	e8 66 f8 ff ff       	call   800038 <_main>
  8007d2:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8007d5:	a1 00 40 80 00       	mov    0x804000,%eax
  8007da:	85 c0                	test   %eax,%eax
  8007dc:	0f 84 b7 01 00 00    	je     800999 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007e2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007e8:	bb 9c 28 80 00       	mov    $0x80289c,%ebx
  8007ed:	ba 0e 00 00 00       	mov    $0xe,%edx
  8007f2:	89 c7                	mov    %eax,%edi
  8007f4:	89 de                	mov    %ebx,%esi
  8007f6:	89 d1                	mov    %edx,%ecx
  8007f8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007fa:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800800:	b9 56 00 00 00       	mov    $0x56,%ecx
  800805:	b0 00                	mov    $0x0,%al
  800807:	89 d7                	mov    %edx,%edi
  800809:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80080b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800812:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800815:	83 ec 08             	sub    $0x8,%esp
  800818:	50                   	push   %eax
  800819:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80081f:	50                   	push   %eax
  800820:	e8 68 19 00 00       	call   80218d <sys_utilities>
  800825:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800828:	e8 e8 14 00 00       	call   801d15 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80082d:	83 ec 0c             	sub    $0xc,%esp
  800830:	68 78 27 80 00       	push   $0x802778
  800835:	e8 5f 04 00 00       	call   800c99 <cprintf>
  80083a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80083d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800840:	85 c0                	test   %eax,%eax
  800842:	74 58                	je     80089c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800844:	e8 62 19 00 00       	call   8021ab <sys_get_optimal_num_faults>
  800849:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80084c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800852:	bb 00 29 80 00       	mov    $0x802900,%ebx
  800857:	ba 11 00 00 00       	mov    $0x11,%edx
  80085c:	89 c7                	mov    %eax,%edi
  80085e:	89 de                	mov    %ebx,%esi
  800860:	89 d1                	mov    %edx,%ecx
  800862:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800864:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800867:	b9 53 00 00 00       	mov    $0x53,%ecx
  80086c:	b0 00                	mov    $0x0,%al
  80086e:	89 d7                	mov    %edx,%edi
  800870:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800872:	83 ec 08             	sub    $0x8,%esp
  800875:	ff 75 dc             	pushl  -0x24(%ebp)
  800878:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80087e:	50                   	push   %eax
  80087f:	e8 09 19 00 00       	call   80218d <sys_utilities>
  800884:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800887:	83 ec 08             	sub    $0x8,%esp
  80088a:	ff 75 dc             	pushl  -0x24(%ebp)
  80088d:	68 a0 27 80 00       	push   $0x8027a0
  800892:	e8 02 04 00 00       	call   800c99 <cprintf>
  800897:	83 c4 10             	add    $0x10,%esp
  80089a:	eb 59                	jmp    8008f5 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80089c:	a1 24 40 80 00       	mov    0x804024,%eax
  8008a1:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8008a7:	a1 24 40 80 00       	mov    0x804024,%eax
  8008ac:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8008b2:	83 ec 04             	sub    $0x4,%esp
  8008b5:	52                   	push   %edx
  8008b6:	50                   	push   %eax
  8008b7:	68 c4 27 80 00       	push   $0x8027c4
  8008bc:	e8 d8 03 00 00       	call   800c99 <cprintf>
  8008c1:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8008c4:	a1 24 40 80 00       	mov    0x804024,%eax
  8008c9:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8008cf:	a1 24 40 80 00       	mov    0x804024,%eax
  8008d4:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008da:	a1 24 40 80 00       	mov    0x804024,%eax
  8008df:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008e5:	51                   	push   %ecx
  8008e6:	52                   	push   %edx
  8008e7:	50                   	push   %eax
  8008e8:	68 ec 27 80 00       	push   $0x8027ec
  8008ed:	e8 a7 03 00 00       	call   800c99 <cprintf>
  8008f2:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008f5:	a1 24 40 80 00       	mov    0x804024,%eax
  8008fa:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800900:	83 ec 08             	sub    $0x8,%esp
  800903:	50                   	push   %eax
  800904:	68 44 28 80 00       	push   $0x802844
  800909:	e8 8b 03 00 00       	call   800c99 <cprintf>
  80090e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800911:	83 ec 0c             	sub    $0xc,%esp
  800914:	68 58 28 80 00       	push   $0x802858
  800919:	e8 7b 03 00 00       	call   800c99 <cprintf>
  80091e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800921:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800928:	eb 28                	jmp    800952 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80092a:	a1 24 40 80 00       	mov    0x804024,%eax
  80092f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800932:	81 c2 74 04 00 00    	add    $0x474,%edx
  800938:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80093b:	83 ec 04             	sub    $0x4,%esp
  80093e:	50                   	push   %eax
  80093f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800942:	68 6f 28 80 00       	push   $0x80286f
  800947:	e8 4d 03 00 00       	call   800c99 <cprintf>
  80094c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80094f:	ff 45 e4             	incl   -0x1c(%ebp)
  800952:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800956:	7e d2                	jle    80092a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800958:	83 ec 0c             	sub    $0xc,%esp
  80095b:	68 7e 28 80 00       	push   $0x80287e
  800960:	e8 34 03 00 00       	call   800c99 <cprintf>
  800965:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800968:	a1 24 40 80 00       	mov    0x804024,%eax
  80096d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800973:	83 ec 08             	sub    $0x8,%esp
  800976:	50                   	push   %eax
  800977:	68 82 28 80 00       	push   $0x802882
  80097c:	e8 18 03 00 00       	call   800c99 <cprintf>
  800981:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800984:	83 ec 0c             	sub    $0xc,%esp
  800987:	68 78 27 80 00       	push   $0x802778
  80098c:	e8 08 03 00 00       	call   800c99 <cprintf>
  800991:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800994:	e8 96 13 00 00       	call   801d2f <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800999:	e8 1f 00 00 00       	call   8009bd <exit>
}
  80099e:	90                   	nop
  80099f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8009a2:	5b                   	pop    %ebx
  8009a3:	5e                   	pop    %esi
  8009a4:	5f                   	pop    %edi
  8009a5:	5d                   	pop    %ebp
  8009a6:	c3                   	ret    

008009a7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009a7:	55                   	push   %ebp
  8009a8:	89 e5                	mov    %esp,%ebp
  8009aa:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8009ad:	83 ec 0c             	sub    $0xc,%esp
  8009b0:	6a 00                	push   $0x0
  8009b2:	e8 a2 15 00 00       	call   801f59 <sys_destroy_env>
  8009b7:	83 c4 10             	add    $0x10,%esp
}
  8009ba:	90                   	nop
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <exit>:

void
exit(void)
{
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8009c3:	e8 f7 15 00 00       	call   801fbf <sys_exit_env>
}
  8009c8:	90                   	nop
  8009c9:	c9                   	leave  
  8009ca:	c3                   	ret    

008009cb <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009cb:	55                   	push   %ebp
  8009cc:	89 e5                	mov    %esp,%ebp
  8009ce:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009d1:	8d 45 10             	lea    0x10(%ebp),%eax
  8009d4:	83 c0 04             	add    $0x4,%eax
  8009d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009da:	a1 28 41 80 00       	mov    0x804128,%eax
  8009df:	85 c0                	test   %eax,%eax
  8009e1:	74 16                	je     8009f9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009e3:	a1 28 41 80 00       	mov    0x804128,%eax
  8009e8:	83 ec 08             	sub    $0x8,%esp
  8009eb:	50                   	push   %eax
  8009ec:	68 64 29 80 00       	push   $0x802964
  8009f1:	e8 a3 02 00 00       	call   800c99 <cprintf>
  8009f6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8009f9:	a1 04 40 80 00       	mov    0x804004,%eax
  8009fe:	83 ec 0c             	sub    $0xc,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	ff 75 08             	pushl  0x8(%ebp)
  800a07:	50                   	push   %eax
  800a08:	68 6c 29 80 00       	push   $0x80296c
  800a0d:	6a 74                	push   $0x74
  800a0f:	e8 b2 02 00 00       	call   800cc6 <cprintf_colored>
  800a14:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800a17:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1a:	83 ec 08             	sub    $0x8,%esp
  800a1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a20:	50                   	push   %eax
  800a21:	e8 04 02 00 00       	call   800c2a <vcprintf>
  800a26:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a29:	83 ec 08             	sub    $0x8,%esp
  800a2c:	6a 00                	push   $0x0
  800a2e:	68 94 29 80 00       	push   $0x802994
  800a33:	e8 f2 01 00 00       	call   800c2a <vcprintf>
  800a38:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a3b:	e8 7d ff ff ff       	call   8009bd <exit>

	// should not return here
	while (1) ;
  800a40:	eb fe                	jmp    800a40 <_panic+0x75>

00800a42 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a42:	55                   	push   %ebp
  800a43:	89 e5                	mov    %esp,%ebp
  800a45:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a48:	a1 24 40 80 00       	mov    0x804024,%eax
  800a4d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a56:	39 c2                	cmp    %eax,%edx
  800a58:	74 14                	je     800a6e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a5a:	83 ec 04             	sub    $0x4,%esp
  800a5d:	68 98 29 80 00       	push   $0x802998
  800a62:	6a 26                	push   $0x26
  800a64:	68 e4 29 80 00       	push   $0x8029e4
  800a69:	e8 5d ff ff ff       	call   8009cb <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a75:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a7c:	e9 c5 00 00 00       	jmp    800b46 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	01 d0                	add    %edx,%eax
  800a90:	8b 00                	mov    (%eax),%eax
  800a92:	85 c0                	test   %eax,%eax
  800a94:	75 08                	jne    800a9e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a96:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a99:	e9 a5 00 00 00       	jmp    800b43 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a9e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aa5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800aac:	eb 69                	jmp    800b17 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800aae:	a1 24 40 80 00       	mov    0x804024,%eax
  800ab3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800ab9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800abc:	89 d0                	mov    %edx,%eax
  800abe:	01 c0                	add    %eax,%eax
  800ac0:	01 d0                	add    %edx,%eax
  800ac2:	c1 e0 03             	shl    $0x3,%eax
  800ac5:	01 c8                	add    %ecx,%eax
  800ac7:	8a 40 04             	mov    0x4(%eax),%al
  800aca:	84 c0                	test   %al,%al
  800acc:	75 46                	jne    800b14 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ace:	a1 24 40 80 00       	mov    0x804024,%eax
  800ad3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800ad9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800adc:	89 d0                	mov    %edx,%eax
  800ade:	01 c0                	add    %eax,%eax
  800ae0:	01 d0                	add    %edx,%eax
  800ae2:	c1 e0 03             	shl    $0x3,%eax
  800ae5:	01 c8                	add    %ecx,%eax
  800ae7:	8b 00                	mov    (%eax),%eax
  800ae9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800aec:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800aef:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800af4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800af6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	01 c8                	add    %ecx,%eax
  800b05:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b07:	39 c2                	cmp    %eax,%edx
  800b09:	75 09                	jne    800b14 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800b0b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b12:	eb 15                	jmp    800b29 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b14:	ff 45 e8             	incl   -0x18(%ebp)
  800b17:	a1 24 40 80 00       	mov    0x804024,%eax
  800b1c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b22:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b25:	39 c2                	cmp    %eax,%edx
  800b27:	77 85                	ja     800aae <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b2d:	75 14                	jne    800b43 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800b2f:	83 ec 04             	sub    $0x4,%esp
  800b32:	68 f0 29 80 00       	push   $0x8029f0
  800b37:	6a 3a                	push   $0x3a
  800b39:	68 e4 29 80 00       	push   $0x8029e4
  800b3e:	e8 88 fe ff ff       	call   8009cb <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b43:	ff 45 f0             	incl   -0x10(%ebp)
  800b46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b49:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b4c:	0f 8c 2f ff ff ff    	jl     800a81 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b52:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b59:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b60:	eb 26                	jmp    800b88 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b62:	a1 24 40 80 00       	mov    0x804024,%eax
  800b67:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b6d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b70:	89 d0                	mov    %edx,%eax
  800b72:	01 c0                	add    %eax,%eax
  800b74:	01 d0                	add    %edx,%eax
  800b76:	c1 e0 03             	shl    $0x3,%eax
  800b79:	01 c8                	add    %ecx,%eax
  800b7b:	8a 40 04             	mov    0x4(%eax),%al
  800b7e:	3c 01                	cmp    $0x1,%al
  800b80:	75 03                	jne    800b85 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b82:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b85:	ff 45 e0             	incl   -0x20(%ebp)
  800b88:	a1 24 40 80 00       	mov    0x804024,%eax
  800b8d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b93:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b96:	39 c2                	cmp    %eax,%edx
  800b98:	77 c8                	ja     800b62 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b9d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ba0:	74 14                	je     800bb6 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800ba2:	83 ec 04             	sub    $0x4,%esp
  800ba5:	68 44 2a 80 00       	push   $0x802a44
  800baa:	6a 44                	push   $0x44
  800bac:	68 e4 29 80 00       	push   $0x8029e4
  800bb1:	e8 15 fe ff ff       	call   8009cb <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bb6:	90                   	nop
  800bb7:	c9                   	leave  
  800bb8:	c3                   	ret    

00800bb9 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800bb9:	55                   	push   %ebp
  800bba:	89 e5                	mov    %esp,%ebp
  800bbc:	53                   	push   %ebx
  800bbd:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc3:	8b 00                	mov    (%eax),%eax
  800bc5:	8d 48 01             	lea    0x1(%eax),%ecx
  800bc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcb:	89 0a                	mov    %ecx,(%edx)
  800bcd:	8b 55 08             	mov    0x8(%ebp),%edx
  800bd0:	88 d1                	mov    %dl,%cl
  800bd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8b 00                	mov    (%eax),%eax
  800bde:	3d ff 00 00 00       	cmp    $0xff,%eax
  800be3:	75 30                	jne    800c15 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800be5:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800beb:	a0 40 40 80 00       	mov    0x804040,%al
  800bf0:	0f b6 c0             	movzbl %al,%eax
  800bf3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bf6:	8b 09                	mov    (%ecx),%ecx
  800bf8:	89 cb                	mov    %ecx,%ebx
  800bfa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bfd:	83 c1 08             	add    $0x8,%ecx
  800c00:	52                   	push   %edx
  800c01:	50                   	push   %eax
  800c02:	53                   	push   %ebx
  800c03:	51                   	push   %ecx
  800c04:	e8 c8 10 00 00       	call   801cd1 <sys_cputs>
  800c09:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	8b 40 04             	mov    0x4(%eax),%eax
  800c1b:	8d 50 01             	lea    0x1(%eax),%edx
  800c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c21:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c24:	90                   	nop
  800c25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c28:	c9                   	leave  
  800c29:	c3                   	ret    

00800c2a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
  800c2d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c33:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c3a:	00 00 00 
	b.cnt = 0;
  800c3d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c44:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c47:	ff 75 0c             	pushl  0xc(%ebp)
  800c4a:	ff 75 08             	pushl  0x8(%ebp)
  800c4d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c53:	50                   	push   %eax
  800c54:	68 b9 0b 80 00       	push   $0x800bb9
  800c59:	e8 5a 02 00 00       	call   800eb8 <vprintfmt>
  800c5e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c61:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c67:	a0 40 40 80 00       	mov    0x804040,%al
  800c6c:	0f b6 c0             	movzbl %al,%eax
  800c6f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c75:	52                   	push   %edx
  800c76:	50                   	push   %eax
  800c77:	51                   	push   %ecx
  800c78:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c7e:	83 c0 08             	add    $0x8,%eax
  800c81:	50                   	push   %eax
  800c82:	e8 4a 10 00 00       	call   801cd1 <sys_cputs>
  800c87:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c8a:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800c91:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
  800c9c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c9f:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800ca6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ca9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	83 ec 08             	sub    $0x8,%esp
  800cb2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb5:	50                   	push   %eax
  800cb6:	e8 6f ff ff ff       	call   800c2a <vcprintf>
  800cbb:	83 c4 10             	add    $0x10,%esp
  800cbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cc4:	c9                   	leave  
  800cc5:	c3                   	ret    

00800cc6 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800cc6:	55                   	push   %ebp
  800cc7:	89 e5                	mov    %esp,%ebp
  800cc9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ccc:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	c1 e0 08             	shl    $0x8,%eax
  800cd9:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800cde:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ce1:	83 c0 04             	add    $0x4,%eax
  800ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	83 ec 08             	sub    $0x8,%esp
  800ced:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf0:	50                   	push   %eax
  800cf1:	e8 34 ff ff ff       	call   800c2a <vcprintf>
  800cf6:	83 c4 10             	add    $0x10,%esp
  800cf9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800cfc:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800d03:	07 00 00 

	return cnt;
  800d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d09:	c9                   	leave  
  800d0a:	c3                   	ret    

00800d0b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
  800d0e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800d11:	e8 ff 0f 00 00       	call   801d15 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800d16:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d19:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	83 ec 08             	sub    $0x8,%esp
  800d22:	ff 75 f4             	pushl  -0xc(%ebp)
  800d25:	50                   	push   %eax
  800d26:	e8 ff fe ff ff       	call   800c2a <vcprintf>
  800d2b:	83 c4 10             	add    $0x10,%esp
  800d2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800d31:	e8 f9 0f 00 00       	call   801d2f <sys_unlock_cons>
	return cnt;
  800d36:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d39:	c9                   	leave  
  800d3a:	c3                   	ret    

00800d3b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d3b:	55                   	push   %ebp
  800d3c:	89 e5                	mov    %esp,%ebp
  800d3e:	53                   	push   %ebx
  800d3f:	83 ec 14             	sub    $0x14,%esp
  800d42:	8b 45 10             	mov    0x10(%ebp),%eax
  800d45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d48:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d4e:	8b 45 18             	mov    0x18(%ebp),%eax
  800d51:	ba 00 00 00 00       	mov    $0x0,%edx
  800d56:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d59:	77 55                	ja     800db0 <printnum+0x75>
  800d5b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d5e:	72 05                	jb     800d65 <printnum+0x2a>
  800d60:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d63:	77 4b                	ja     800db0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d65:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d68:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d6b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d6e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d73:	52                   	push   %edx
  800d74:	50                   	push   %eax
  800d75:	ff 75 f4             	pushl  -0xc(%ebp)
  800d78:	ff 75 f0             	pushl  -0x10(%ebp)
  800d7b:	e8 8c 15 00 00       	call   80230c <__udivdi3>
  800d80:	83 c4 10             	add    $0x10,%esp
  800d83:	83 ec 04             	sub    $0x4,%esp
  800d86:	ff 75 20             	pushl  0x20(%ebp)
  800d89:	53                   	push   %ebx
  800d8a:	ff 75 18             	pushl  0x18(%ebp)
  800d8d:	52                   	push   %edx
  800d8e:	50                   	push   %eax
  800d8f:	ff 75 0c             	pushl  0xc(%ebp)
  800d92:	ff 75 08             	pushl  0x8(%ebp)
  800d95:	e8 a1 ff ff ff       	call   800d3b <printnum>
  800d9a:	83 c4 20             	add    $0x20,%esp
  800d9d:	eb 1a                	jmp    800db9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d9f:	83 ec 08             	sub    $0x8,%esp
  800da2:	ff 75 0c             	pushl  0xc(%ebp)
  800da5:	ff 75 20             	pushl  0x20(%ebp)
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	ff d0                	call   *%eax
  800dad:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800db0:	ff 4d 1c             	decl   0x1c(%ebp)
  800db3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800db7:	7f e6                	jg     800d9f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800db9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800dbc:	bb 00 00 00 00       	mov    $0x0,%ebx
  800dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc7:	53                   	push   %ebx
  800dc8:	51                   	push   %ecx
  800dc9:	52                   	push   %edx
  800dca:	50                   	push   %eax
  800dcb:	e8 4c 16 00 00       	call   80241c <__umoddi3>
  800dd0:	83 c4 10             	add    $0x10,%esp
  800dd3:	05 b4 2c 80 00       	add    $0x802cb4,%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f be c0             	movsbl %al,%eax
  800ddd:	83 ec 08             	sub    $0x8,%esp
  800de0:	ff 75 0c             	pushl  0xc(%ebp)
  800de3:	50                   	push   %eax
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
  800de7:	ff d0                	call   *%eax
  800de9:	83 c4 10             	add    $0x10,%esp
}
  800dec:	90                   	nop
  800ded:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800df0:	c9                   	leave  
  800df1:	c3                   	ret    

00800df2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800df2:	55                   	push   %ebp
  800df3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800df5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800df9:	7e 1c                	jle    800e17 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	8b 00                	mov    (%eax),%eax
  800e00:	8d 50 08             	lea    0x8(%eax),%edx
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	89 10                	mov    %edx,(%eax)
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	83 e8 08             	sub    $0x8,%eax
  800e10:	8b 50 04             	mov    0x4(%eax),%edx
  800e13:	8b 00                	mov    (%eax),%eax
  800e15:	eb 40                	jmp    800e57 <getuint+0x65>
	else if (lflag)
  800e17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e1b:	74 1e                	je     800e3b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	8d 50 04             	lea    0x4(%eax),%edx
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	89 10                	mov    %edx,(%eax)
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	83 e8 04             	sub    $0x4,%eax
  800e32:	8b 00                	mov    (%eax),%eax
  800e34:	ba 00 00 00 00       	mov    $0x0,%edx
  800e39:	eb 1c                	jmp    800e57 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	8b 00                	mov    (%eax),%eax
  800e40:	8d 50 04             	lea    0x4(%eax),%edx
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	89 10                	mov    %edx,(%eax)
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8b 00                	mov    (%eax),%eax
  800e4d:	83 e8 04             	sub    $0x4,%eax
  800e50:	8b 00                	mov    (%eax),%eax
  800e52:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e57:	5d                   	pop    %ebp
  800e58:	c3                   	ret    

00800e59 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e5c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e60:	7e 1c                	jle    800e7e <getint+0x25>
		return va_arg(*ap, long long);
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	8b 00                	mov    (%eax),%eax
  800e67:	8d 50 08             	lea    0x8(%eax),%edx
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	89 10                	mov    %edx,(%eax)
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8b 00                	mov    (%eax),%eax
  800e74:	83 e8 08             	sub    $0x8,%eax
  800e77:	8b 50 04             	mov    0x4(%eax),%edx
  800e7a:	8b 00                	mov    (%eax),%eax
  800e7c:	eb 38                	jmp    800eb6 <getint+0x5d>
	else if (lflag)
  800e7e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e82:	74 1a                	je     800e9e <getint+0x45>
		return va_arg(*ap, long);
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	8b 00                	mov    (%eax),%eax
  800e89:	8d 50 04             	lea    0x4(%eax),%edx
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	89 10                	mov    %edx,(%eax)
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8b 00                	mov    (%eax),%eax
  800e96:	83 e8 04             	sub    $0x4,%eax
  800e99:	8b 00                	mov    (%eax),%eax
  800e9b:	99                   	cltd   
  800e9c:	eb 18                	jmp    800eb6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	8b 00                	mov    (%eax),%eax
  800ea3:	8d 50 04             	lea    0x4(%eax),%edx
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	89 10                	mov    %edx,(%eax)
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	8b 00                	mov    (%eax),%eax
  800eb0:	83 e8 04             	sub    $0x4,%eax
  800eb3:	8b 00                	mov    (%eax),%eax
  800eb5:	99                   	cltd   
}
  800eb6:	5d                   	pop    %ebp
  800eb7:	c3                   	ret    

00800eb8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800eb8:	55                   	push   %ebp
  800eb9:	89 e5                	mov    %esp,%ebp
  800ebb:	56                   	push   %esi
  800ebc:	53                   	push   %ebx
  800ebd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ec0:	eb 17                	jmp    800ed9 <vprintfmt+0x21>
			if (ch == '\0')
  800ec2:	85 db                	test   %ebx,%ebx
  800ec4:	0f 84 c1 03 00 00    	je     80128b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800eca:	83 ec 08             	sub    $0x8,%esp
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	53                   	push   %ebx
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	ff d0                	call   *%eax
  800ed6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ed9:	8b 45 10             	mov    0x10(%ebp),%eax
  800edc:	8d 50 01             	lea    0x1(%eax),%edx
  800edf:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	0f b6 d8             	movzbl %al,%ebx
  800ee7:	83 fb 25             	cmp    $0x25,%ebx
  800eea:	75 d6                	jne    800ec2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800eec:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ef0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ef7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800efe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800f05:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800f0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0f:	8d 50 01             	lea    0x1(%eax),%edx
  800f12:	89 55 10             	mov    %edx,0x10(%ebp)
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	0f b6 d8             	movzbl %al,%ebx
  800f1a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f1d:	83 f8 5b             	cmp    $0x5b,%eax
  800f20:	0f 87 3d 03 00 00    	ja     801263 <vprintfmt+0x3ab>
  800f26:	8b 04 85 d8 2c 80 00 	mov    0x802cd8(,%eax,4),%eax
  800f2d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f2f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f33:	eb d7                	jmp    800f0c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f35:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f39:	eb d1                	jmp    800f0c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f3b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f42:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f45:	89 d0                	mov    %edx,%eax
  800f47:	c1 e0 02             	shl    $0x2,%eax
  800f4a:	01 d0                	add    %edx,%eax
  800f4c:	01 c0                	add    %eax,%eax
  800f4e:	01 d8                	add    %ebx,%eax
  800f50:	83 e8 30             	sub    $0x30,%eax
  800f53:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f56:	8b 45 10             	mov    0x10(%ebp),%eax
  800f59:	8a 00                	mov    (%eax),%al
  800f5b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f5e:	83 fb 2f             	cmp    $0x2f,%ebx
  800f61:	7e 3e                	jle    800fa1 <vprintfmt+0xe9>
  800f63:	83 fb 39             	cmp    $0x39,%ebx
  800f66:	7f 39                	jg     800fa1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f68:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f6b:	eb d5                	jmp    800f42 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f70:	83 c0 04             	add    $0x4,%eax
  800f73:	89 45 14             	mov    %eax,0x14(%ebp)
  800f76:	8b 45 14             	mov    0x14(%ebp),%eax
  800f79:	83 e8 04             	sub    $0x4,%eax
  800f7c:	8b 00                	mov    (%eax),%eax
  800f7e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f81:	eb 1f                	jmp    800fa2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f87:	79 83                	jns    800f0c <vprintfmt+0x54>
				width = 0;
  800f89:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f90:	e9 77 ff ff ff       	jmp    800f0c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f95:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f9c:	e9 6b ff ff ff       	jmp    800f0c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800fa1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800fa2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa6:	0f 89 60 ff ff ff    	jns    800f0c <vprintfmt+0x54>
				width = precision, precision = -1;
  800fac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800faf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800fb2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800fb9:	e9 4e ff ff ff       	jmp    800f0c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800fbe:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800fc1:	e9 46 ff ff ff       	jmp    800f0c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc9:	83 c0 04             	add    $0x4,%eax
  800fcc:	89 45 14             	mov    %eax,0x14(%ebp)
  800fcf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd2:	83 e8 04             	sub    $0x4,%eax
  800fd5:	8b 00                	mov    (%eax),%eax
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	50                   	push   %eax
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	ff d0                	call   *%eax
  800fe3:	83 c4 10             	add    $0x10,%esp
			break;
  800fe6:	e9 9b 02 00 00       	jmp    801286 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800feb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fee:	83 c0 04             	add    $0x4,%eax
  800ff1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ff4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff7:	83 e8 04             	sub    $0x4,%eax
  800ffa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ffc:	85 db                	test   %ebx,%ebx
  800ffe:	79 02                	jns    801002 <vprintfmt+0x14a>
				err = -err;
  801000:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801002:	83 fb 64             	cmp    $0x64,%ebx
  801005:	7f 0b                	jg     801012 <vprintfmt+0x15a>
  801007:	8b 34 9d 20 2b 80 00 	mov    0x802b20(,%ebx,4),%esi
  80100e:	85 f6                	test   %esi,%esi
  801010:	75 19                	jne    80102b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801012:	53                   	push   %ebx
  801013:	68 c5 2c 80 00       	push   $0x802cc5
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	ff 75 08             	pushl  0x8(%ebp)
  80101e:	e8 70 02 00 00       	call   801293 <printfmt>
  801023:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801026:	e9 5b 02 00 00       	jmp    801286 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80102b:	56                   	push   %esi
  80102c:	68 ce 2c 80 00       	push   $0x802cce
  801031:	ff 75 0c             	pushl  0xc(%ebp)
  801034:	ff 75 08             	pushl  0x8(%ebp)
  801037:	e8 57 02 00 00       	call   801293 <printfmt>
  80103c:	83 c4 10             	add    $0x10,%esp
			break;
  80103f:	e9 42 02 00 00       	jmp    801286 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801044:	8b 45 14             	mov    0x14(%ebp),%eax
  801047:	83 c0 04             	add    $0x4,%eax
  80104a:	89 45 14             	mov    %eax,0x14(%ebp)
  80104d:	8b 45 14             	mov    0x14(%ebp),%eax
  801050:	83 e8 04             	sub    $0x4,%eax
  801053:	8b 30                	mov    (%eax),%esi
  801055:	85 f6                	test   %esi,%esi
  801057:	75 05                	jne    80105e <vprintfmt+0x1a6>
				p = "(null)";
  801059:	be d1 2c 80 00       	mov    $0x802cd1,%esi
			if (width > 0 && padc != '-')
  80105e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801062:	7e 6d                	jle    8010d1 <vprintfmt+0x219>
  801064:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801068:	74 67                	je     8010d1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80106a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	50                   	push   %eax
  801071:	56                   	push   %esi
  801072:	e8 1e 03 00 00       	call   801395 <strnlen>
  801077:	83 c4 10             	add    $0x10,%esp
  80107a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80107d:	eb 16                	jmp    801095 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80107f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801083:	83 ec 08             	sub    $0x8,%esp
  801086:	ff 75 0c             	pushl  0xc(%ebp)
  801089:	50                   	push   %eax
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	ff d0                	call   *%eax
  80108f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801092:	ff 4d e4             	decl   -0x1c(%ebp)
  801095:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801099:	7f e4                	jg     80107f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80109b:	eb 34                	jmp    8010d1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80109d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8010a1:	74 1c                	je     8010bf <vprintfmt+0x207>
  8010a3:	83 fb 1f             	cmp    $0x1f,%ebx
  8010a6:	7e 05                	jle    8010ad <vprintfmt+0x1f5>
  8010a8:	83 fb 7e             	cmp    $0x7e,%ebx
  8010ab:	7e 12                	jle    8010bf <vprintfmt+0x207>
					putch('?', putdat);
  8010ad:	83 ec 08             	sub    $0x8,%esp
  8010b0:	ff 75 0c             	pushl  0xc(%ebp)
  8010b3:	6a 3f                	push   $0x3f
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	ff d0                	call   *%eax
  8010ba:	83 c4 10             	add    $0x10,%esp
  8010bd:	eb 0f                	jmp    8010ce <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8010bf:	83 ec 08             	sub    $0x8,%esp
  8010c2:	ff 75 0c             	pushl  0xc(%ebp)
  8010c5:	53                   	push   %ebx
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	ff d0                	call   *%eax
  8010cb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ce:	ff 4d e4             	decl   -0x1c(%ebp)
  8010d1:	89 f0                	mov    %esi,%eax
  8010d3:	8d 70 01             	lea    0x1(%eax),%esi
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	0f be d8             	movsbl %al,%ebx
  8010db:	85 db                	test   %ebx,%ebx
  8010dd:	74 24                	je     801103 <vprintfmt+0x24b>
  8010df:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010e3:	78 b8                	js     80109d <vprintfmt+0x1e5>
  8010e5:	ff 4d e0             	decl   -0x20(%ebp)
  8010e8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010ec:	79 af                	jns    80109d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010ee:	eb 13                	jmp    801103 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010f0:	83 ec 08             	sub    $0x8,%esp
  8010f3:	ff 75 0c             	pushl  0xc(%ebp)
  8010f6:	6a 20                	push   $0x20
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	ff d0                	call   *%eax
  8010fd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801100:	ff 4d e4             	decl   -0x1c(%ebp)
  801103:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801107:	7f e7                	jg     8010f0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801109:	e9 78 01 00 00       	jmp    801286 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80110e:	83 ec 08             	sub    $0x8,%esp
  801111:	ff 75 e8             	pushl  -0x18(%ebp)
  801114:	8d 45 14             	lea    0x14(%ebp),%eax
  801117:	50                   	push   %eax
  801118:	e8 3c fd ff ff       	call   800e59 <getint>
  80111d:	83 c4 10             	add    $0x10,%esp
  801120:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801123:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801126:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801129:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80112c:	85 d2                	test   %edx,%edx
  80112e:	79 23                	jns    801153 <vprintfmt+0x29b>
				putch('-', putdat);
  801130:	83 ec 08             	sub    $0x8,%esp
  801133:	ff 75 0c             	pushl  0xc(%ebp)
  801136:	6a 2d                	push   $0x2d
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	ff d0                	call   *%eax
  80113d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801140:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801143:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801146:	f7 d8                	neg    %eax
  801148:	83 d2 00             	adc    $0x0,%edx
  80114b:	f7 da                	neg    %edx
  80114d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801150:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801153:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80115a:	e9 bc 00 00 00       	jmp    80121b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80115f:	83 ec 08             	sub    $0x8,%esp
  801162:	ff 75 e8             	pushl  -0x18(%ebp)
  801165:	8d 45 14             	lea    0x14(%ebp),%eax
  801168:	50                   	push   %eax
  801169:	e8 84 fc ff ff       	call   800df2 <getuint>
  80116e:	83 c4 10             	add    $0x10,%esp
  801171:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801174:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801177:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80117e:	e9 98 00 00 00       	jmp    80121b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801183:	83 ec 08             	sub    $0x8,%esp
  801186:	ff 75 0c             	pushl  0xc(%ebp)
  801189:	6a 58                	push   $0x58
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	ff d0                	call   *%eax
  801190:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801193:	83 ec 08             	sub    $0x8,%esp
  801196:	ff 75 0c             	pushl  0xc(%ebp)
  801199:	6a 58                	push   $0x58
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	ff d0                	call   *%eax
  8011a0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011a3:	83 ec 08             	sub    $0x8,%esp
  8011a6:	ff 75 0c             	pushl  0xc(%ebp)
  8011a9:	6a 58                	push   $0x58
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	ff d0                	call   *%eax
  8011b0:	83 c4 10             	add    $0x10,%esp
			break;
  8011b3:	e9 ce 00 00 00       	jmp    801286 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8011b8:	83 ec 08             	sub    $0x8,%esp
  8011bb:	ff 75 0c             	pushl  0xc(%ebp)
  8011be:	6a 30                	push   $0x30
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	ff d0                	call   *%eax
  8011c5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011c8:	83 ec 08             	sub    $0x8,%esp
  8011cb:	ff 75 0c             	pushl  0xc(%ebp)
  8011ce:	6a 78                	push   $0x78
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	ff d0                	call   *%eax
  8011d5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011db:	83 c0 04             	add    $0x4,%eax
  8011de:	89 45 14             	mov    %eax,0x14(%ebp)
  8011e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e4:	83 e8 04             	sub    $0x4,%eax
  8011e7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011f3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011fa:	eb 1f                	jmp    80121b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011fc:	83 ec 08             	sub    $0x8,%esp
  8011ff:	ff 75 e8             	pushl  -0x18(%ebp)
  801202:	8d 45 14             	lea    0x14(%ebp),%eax
  801205:	50                   	push   %eax
  801206:	e8 e7 fb ff ff       	call   800df2 <getuint>
  80120b:	83 c4 10             	add    $0x10,%esp
  80120e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801211:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801214:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80121b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80121f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801222:	83 ec 04             	sub    $0x4,%esp
  801225:	52                   	push   %edx
  801226:	ff 75 e4             	pushl  -0x1c(%ebp)
  801229:	50                   	push   %eax
  80122a:	ff 75 f4             	pushl  -0xc(%ebp)
  80122d:	ff 75 f0             	pushl  -0x10(%ebp)
  801230:	ff 75 0c             	pushl  0xc(%ebp)
  801233:	ff 75 08             	pushl  0x8(%ebp)
  801236:	e8 00 fb ff ff       	call   800d3b <printnum>
  80123b:	83 c4 20             	add    $0x20,%esp
			break;
  80123e:	eb 46                	jmp    801286 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801240:	83 ec 08             	sub    $0x8,%esp
  801243:	ff 75 0c             	pushl  0xc(%ebp)
  801246:	53                   	push   %ebx
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	ff d0                	call   *%eax
  80124c:	83 c4 10             	add    $0x10,%esp
			break;
  80124f:	eb 35                	jmp    801286 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801251:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  801258:	eb 2c                	jmp    801286 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80125a:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801261:	eb 23                	jmp    801286 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801263:	83 ec 08             	sub    $0x8,%esp
  801266:	ff 75 0c             	pushl  0xc(%ebp)
  801269:	6a 25                	push   $0x25
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	ff d0                	call   *%eax
  801270:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801273:	ff 4d 10             	decl   0x10(%ebp)
  801276:	eb 03                	jmp    80127b <vprintfmt+0x3c3>
  801278:	ff 4d 10             	decl   0x10(%ebp)
  80127b:	8b 45 10             	mov    0x10(%ebp),%eax
  80127e:	48                   	dec    %eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	3c 25                	cmp    $0x25,%al
  801283:	75 f3                	jne    801278 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801285:	90                   	nop
		}
	}
  801286:	e9 35 fc ff ff       	jmp    800ec0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80128b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80128c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80128f:	5b                   	pop    %ebx
  801290:	5e                   	pop    %esi
  801291:	5d                   	pop    %ebp
  801292:	c3                   	ret    

00801293 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
  801296:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801299:	8d 45 10             	lea    0x10(%ebp),%eax
  80129c:	83 c0 04             	add    $0x4,%eax
  80129f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8012a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8012a8:	50                   	push   %eax
  8012a9:	ff 75 0c             	pushl  0xc(%ebp)
  8012ac:	ff 75 08             	pushl  0x8(%ebp)
  8012af:	e8 04 fc ff ff       	call   800eb8 <vprintfmt>
  8012b4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8012b7:	90                   	nop
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8012bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c0:	8b 40 08             	mov    0x8(%eax),%eax
  8012c3:	8d 50 01             	lea    0x1(%eax),%edx
  8012c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8012cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cf:	8b 10                	mov    (%eax),%edx
  8012d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d4:	8b 40 04             	mov    0x4(%eax),%eax
  8012d7:	39 c2                	cmp    %eax,%edx
  8012d9:	73 12                	jae    8012ed <sprintputch+0x33>
		*b->buf++ = ch;
  8012db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012de:	8b 00                	mov    (%eax),%eax
  8012e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e6:	89 0a                	mov    %ecx,(%edx)
  8012e8:	8b 55 08             	mov    0x8(%ebp),%edx
  8012eb:	88 10                	mov    %dl,(%eax)
}
  8012ed:	90                   	nop
  8012ee:	5d                   	pop    %ebp
  8012ef:	c3                   	ret    

008012f0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012f0:	55                   	push   %ebp
  8012f1:	89 e5                	mov    %esp,%ebp
  8012f3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	01 d0                	add    %edx,%eax
  801307:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80130a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801311:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801315:	74 06                	je     80131d <vsnprintf+0x2d>
  801317:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80131b:	7f 07                	jg     801324 <vsnprintf+0x34>
		return -E_INVAL;
  80131d:	b8 03 00 00 00       	mov    $0x3,%eax
  801322:	eb 20                	jmp    801344 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801324:	ff 75 14             	pushl  0x14(%ebp)
  801327:	ff 75 10             	pushl  0x10(%ebp)
  80132a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80132d:	50                   	push   %eax
  80132e:	68 ba 12 80 00       	push   $0x8012ba
  801333:	e8 80 fb ff ff       	call   800eb8 <vprintfmt>
  801338:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80133b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80133e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801341:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
  801349:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80134c:	8d 45 10             	lea    0x10(%ebp),%eax
  80134f:	83 c0 04             	add    $0x4,%eax
  801352:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801355:	8b 45 10             	mov    0x10(%ebp),%eax
  801358:	ff 75 f4             	pushl  -0xc(%ebp)
  80135b:	50                   	push   %eax
  80135c:	ff 75 0c             	pushl  0xc(%ebp)
  80135f:	ff 75 08             	pushl  0x8(%ebp)
  801362:	e8 89 ff ff ff       	call   8012f0 <vsnprintf>
  801367:	83 c4 10             	add    $0x10,%esp
  80136a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80136d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801378:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80137f:	eb 06                	jmp    801387 <strlen+0x15>
		n++;
  801381:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801384:	ff 45 08             	incl   0x8(%ebp)
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	84 c0                	test   %al,%al
  80138e:	75 f1                	jne    801381 <strlen+0xf>
		n++;
	return n;
  801390:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
  801398:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80139b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013a2:	eb 09                	jmp    8013ad <strnlen+0x18>
		n++;
  8013a4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013a7:	ff 45 08             	incl   0x8(%ebp)
  8013aa:	ff 4d 0c             	decl   0xc(%ebp)
  8013ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013b1:	74 09                	je     8013bc <strnlen+0x27>
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	8a 00                	mov    (%eax),%al
  8013b8:	84 c0                	test   %al,%al
  8013ba:	75 e8                	jne    8013a4 <strnlen+0xf>
		n++;
	return n;
  8013bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013bf:	c9                   	leave  
  8013c0:	c3                   	ret    

008013c1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013c1:	55                   	push   %ebp
  8013c2:	89 e5                	mov    %esp,%ebp
  8013c4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013cd:	90                   	nop
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8d 50 01             	lea    0x1(%eax),%edx
  8013d4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013dd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013e0:	8a 12                	mov    (%edx),%dl
  8013e2:	88 10                	mov    %dl,(%eax)
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	84 c0                	test   %al,%al
  8013e8:	75 e4                	jne    8013ce <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
  8013f2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801402:	eb 1f                	jmp    801423 <strncpy+0x34>
		*dst++ = *src;
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	8d 50 01             	lea    0x1(%eax),%edx
  80140a:	89 55 08             	mov    %edx,0x8(%ebp)
  80140d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801410:	8a 12                	mov    (%edx),%dl
  801412:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801414:	8b 45 0c             	mov    0xc(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	84 c0                	test   %al,%al
  80141b:	74 03                	je     801420 <strncpy+0x31>
			src++;
  80141d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801420:	ff 45 fc             	incl   -0x4(%ebp)
  801423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801426:	3b 45 10             	cmp    0x10(%ebp),%eax
  801429:	72 d9                	jb     801404 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80142b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80143c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801440:	74 30                	je     801472 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801442:	eb 16                	jmp    80145a <strlcpy+0x2a>
			*dst++ = *src++;
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8d 50 01             	lea    0x1(%eax),%edx
  80144a:	89 55 08             	mov    %edx,0x8(%ebp)
  80144d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801450:	8d 4a 01             	lea    0x1(%edx),%ecx
  801453:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801456:	8a 12                	mov    (%edx),%dl
  801458:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80145a:	ff 4d 10             	decl   0x10(%ebp)
  80145d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801461:	74 09                	je     80146c <strlcpy+0x3c>
  801463:	8b 45 0c             	mov    0xc(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	84 c0                	test   %al,%al
  80146a:	75 d8                	jne    801444 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801472:	8b 55 08             	mov    0x8(%ebp),%edx
  801475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801478:	29 c2                	sub    %eax,%edx
  80147a:	89 d0                	mov    %edx,%eax
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801481:	eb 06                	jmp    801489 <strcmp+0xb>
		p++, q++;
  801483:	ff 45 08             	incl   0x8(%ebp)
  801486:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	84 c0                	test   %al,%al
  801490:	74 0e                	je     8014a0 <strcmp+0x22>
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	8a 10                	mov    (%eax),%dl
  801497:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149a:	8a 00                	mov    (%eax),%al
  80149c:	38 c2                	cmp    %al,%dl
  80149e:	74 e3                	je     801483 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	8a 00                	mov    (%eax),%al
  8014a5:	0f b6 d0             	movzbl %al,%edx
  8014a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	0f b6 c0             	movzbl %al,%eax
  8014b0:	29 c2                	sub    %eax,%edx
  8014b2:	89 d0                	mov    %edx,%eax
}
  8014b4:	5d                   	pop    %ebp
  8014b5:	c3                   	ret    

008014b6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8014b9:	eb 09                	jmp    8014c4 <strncmp+0xe>
		n--, p++, q++;
  8014bb:	ff 4d 10             	decl   0x10(%ebp)
  8014be:	ff 45 08             	incl   0x8(%ebp)
  8014c1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014c8:	74 17                	je     8014e1 <strncmp+0x2b>
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 00                	mov    (%eax),%al
  8014cf:	84 c0                	test   %al,%al
  8014d1:	74 0e                	je     8014e1 <strncmp+0x2b>
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	8a 10                	mov    (%eax),%dl
  8014d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014db:	8a 00                	mov    (%eax),%al
  8014dd:	38 c2                	cmp    %al,%dl
  8014df:	74 da                	je     8014bb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e5:	75 07                	jne    8014ee <strncmp+0x38>
		return 0;
  8014e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8014ec:	eb 14                	jmp    801502 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	8a 00                	mov    (%eax),%al
  8014f3:	0f b6 d0             	movzbl %al,%edx
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	8a 00                	mov    (%eax),%al
  8014fb:	0f b6 c0             	movzbl %al,%eax
  8014fe:	29 c2                	sub    %eax,%edx
  801500:	89 d0                	mov    %edx,%eax
}
  801502:	5d                   	pop    %ebp
  801503:	c3                   	ret    

00801504 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	83 ec 04             	sub    $0x4,%esp
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801510:	eb 12                	jmp    801524 <strchr+0x20>
		if (*s == c)
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	8a 00                	mov    (%eax),%al
  801517:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80151a:	75 05                	jne    801521 <strchr+0x1d>
			return (char *) s;
  80151c:	8b 45 08             	mov    0x8(%ebp),%eax
  80151f:	eb 11                	jmp    801532 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801521:	ff 45 08             	incl   0x8(%ebp)
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	8a 00                	mov    (%eax),%al
  801529:	84 c0                	test   %al,%al
  80152b:	75 e5                	jne    801512 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80152d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
  801537:	83 ec 04             	sub    $0x4,%esp
  80153a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801540:	eb 0d                	jmp    80154f <strfind+0x1b>
		if (*s == c)
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80154a:	74 0e                	je     80155a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80154c:	ff 45 08             	incl   0x8(%ebp)
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	84 c0                	test   %al,%al
  801556:	75 ea                	jne    801542 <strfind+0xe>
  801558:	eb 01                	jmp    80155b <strfind+0x27>
		if (*s == c)
			break;
  80155a:	90                   	nop
	return (char *) s;
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
  801563:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80156c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801570:	76 63                	jbe    8015d5 <memset+0x75>
		uint64 data_block = c;
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	99                   	cltd   
  801576:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801579:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80157c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80157f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801582:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801586:	c1 e0 08             	shl    $0x8,%eax
  801589:	09 45 f0             	or     %eax,-0x10(%ebp)
  80158c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80158f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801592:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801595:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801599:	c1 e0 10             	shl    $0x10,%eax
  80159c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80159f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8015a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a8:	89 c2                	mov    %eax,%edx
  8015aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8015af:	09 45 f0             	or     %eax,-0x10(%ebp)
  8015b2:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8015b5:	eb 18                	jmp    8015cf <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8015b7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015ba:	8d 41 08             	lea    0x8(%ecx),%eax
  8015bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8015c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015c6:	89 01                	mov    %eax,(%ecx)
  8015c8:	89 51 04             	mov    %edx,0x4(%ecx)
  8015cb:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8015cf:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015d3:	77 e2                	ja     8015b7 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8015d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d9:	74 23                	je     8015fe <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8015db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015de:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015e1:	eb 0e                	jmp    8015f1 <memset+0x91>
			*p8++ = (uint8)c;
  8015e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e6:	8d 50 01             	lea    0x1(%eax),%edx
  8015e9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ef:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8015f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015f7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015fa:	85 c0                	test   %eax,%eax
  8015fc:	75 e5                	jne    8015e3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
  801606:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801609:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801615:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801619:	76 24                	jbe    80163f <memcpy+0x3c>
		while(n >= 8){
  80161b:	eb 1c                	jmp    801639 <memcpy+0x36>
			*d64 = *s64;
  80161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801620:	8b 50 04             	mov    0x4(%eax),%edx
  801623:	8b 00                	mov    (%eax),%eax
  801625:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801628:	89 01                	mov    %eax,(%ecx)
  80162a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80162d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801631:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801635:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801639:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80163d:	77 de                	ja     80161d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80163f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801643:	74 31                	je     801676 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801645:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801648:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80164b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80164e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801651:	eb 16                	jmp    801669 <memcpy+0x66>
			*d8++ = *s8++;
  801653:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801656:	8d 50 01             	lea    0x1(%eax),%edx
  801659:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80165c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80165f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801662:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801665:	8a 12                	mov    (%edx),%dl
  801667:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801669:	8b 45 10             	mov    0x10(%ebp),%eax
  80166c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80166f:	89 55 10             	mov    %edx,0x10(%ebp)
  801672:	85 c0                	test   %eax,%eax
  801674:	75 dd                	jne    801653 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801679:	c9                   	leave  
  80167a:	c3                   	ret    

0080167b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
  80167e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801681:	8b 45 0c             	mov    0xc(%ebp),%eax
  801684:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801690:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801693:	73 50                	jae    8016e5 <memmove+0x6a>
  801695:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801698:	8b 45 10             	mov    0x10(%ebp),%eax
  80169b:	01 d0                	add    %edx,%eax
  80169d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016a0:	76 43                	jbe    8016e5 <memmove+0x6a>
		s += n;
  8016a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ab:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016ae:	eb 10                	jmp    8016c0 <memmove+0x45>
			*--d = *--s;
  8016b0:	ff 4d f8             	decl   -0x8(%ebp)
  8016b3:	ff 4d fc             	decl   -0x4(%ebp)
  8016b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b9:	8a 10                	mov    (%eax),%dl
  8016bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016be:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c9:	85 c0                	test   %eax,%eax
  8016cb:	75 e3                	jne    8016b0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016cd:	eb 23                	jmp    8016f2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d2:	8d 50 01             	lea    0x1(%eax),%edx
  8016d5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016db:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016de:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016e1:	8a 12                	mov    (%edx),%dl
  8016e3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016eb:	89 55 10             	mov    %edx,0x10(%ebp)
  8016ee:	85 c0                	test   %eax,%eax
  8016f0:	75 dd                	jne    8016cf <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
  8016fa:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801700:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801703:	8b 45 0c             	mov    0xc(%ebp),%eax
  801706:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801709:	eb 2a                	jmp    801735 <memcmp+0x3e>
		if (*s1 != *s2)
  80170b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170e:	8a 10                	mov    (%eax),%dl
  801710:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801713:	8a 00                	mov    (%eax),%al
  801715:	38 c2                	cmp    %al,%dl
  801717:	74 16                	je     80172f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801719:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80171c:	8a 00                	mov    (%eax),%al
  80171e:	0f b6 d0             	movzbl %al,%edx
  801721:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	0f b6 c0             	movzbl %al,%eax
  801729:	29 c2                	sub    %eax,%edx
  80172b:	89 d0                	mov    %edx,%eax
  80172d:	eb 18                	jmp    801747 <memcmp+0x50>
		s1++, s2++;
  80172f:	ff 45 fc             	incl   -0x4(%ebp)
  801732:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801735:	8b 45 10             	mov    0x10(%ebp),%eax
  801738:	8d 50 ff             	lea    -0x1(%eax),%edx
  80173b:	89 55 10             	mov    %edx,0x10(%ebp)
  80173e:	85 c0                	test   %eax,%eax
  801740:	75 c9                	jne    80170b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801742:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
  80174c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80174f:	8b 55 08             	mov    0x8(%ebp),%edx
  801752:	8b 45 10             	mov    0x10(%ebp),%eax
  801755:	01 d0                	add    %edx,%eax
  801757:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80175a:	eb 15                	jmp    801771 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80175c:	8b 45 08             	mov    0x8(%ebp),%eax
  80175f:	8a 00                	mov    (%eax),%al
  801761:	0f b6 d0             	movzbl %al,%edx
  801764:	8b 45 0c             	mov    0xc(%ebp),%eax
  801767:	0f b6 c0             	movzbl %al,%eax
  80176a:	39 c2                	cmp    %eax,%edx
  80176c:	74 0d                	je     80177b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80176e:	ff 45 08             	incl   0x8(%ebp)
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801777:	72 e3                	jb     80175c <memfind+0x13>
  801779:	eb 01                	jmp    80177c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80177b:	90                   	nop
	return (void *) s;
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
  801784:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801787:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80178e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801795:	eb 03                	jmp    80179a <strtol+0x19>
		s++;
  801797:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	8a 00                	mov    (%eax),%al
  80179f:	3c 20                	cmp    $0x20,%al
  8017a1:	74 f4                	je     801797 <strtol+0x16>
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 09                	cmp    $0x9,%al
  8017aa:	74 eb                	je     801797 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	8a 00                	mov    (%eax),%al
  8017b1:	3c 2b                	cmp    $0x2b,%al
  8017b3:	75 05                	jne    8017ba <strtol+0x39>
		s++;
  8017b5:	ff 45 08             	incl   0x8(%ebp)
  8017b8:	eb 13                	jmp    8017cd <strtol+0x4c>
	else if (*s == '-')
  8017ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bd:	8a 00                	mov    (%eax),%al
  8017bf:	3c 2d                	cmp    $0x2d,%al
  8017c1:	75 0a                	jne    8017cd <strtol+0x4c>
		s++, neg = 1;
  8017c3:	ff 45 08             	incl   0x8(%ebp)
  8017c6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017d1:	74 06                	je     8017d9 <strtol+0x58>
  8017d3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017d7:	75 20                	jne    8017f9 <strtol+0x78>
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	8a 00                	mov    (%eax),%al
  8017de:	3c 30                	cmp    $0x30,%al
  8017e0:	75 17                	jne    8017f9 <strtol+0x78>
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	40                   	inc    %eax
  8017e6:	8a 00                	mov    (%eax),%al
  8017e8:	3c 78                	cmp    $0x78,%al
  8017ea:	75 0d                	jne    8017f9 <strtol+0x78>
		s += 2, base = 16;
  8017ec:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017f0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017f7:	eb 28                	jmp    801821 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017fd:	75 15                	jne    801814 <strtol+0x93>
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	8a 00                	mov    (%eax),%al
  801804:	3c 30                	cmp    $0x30,%al
  801806:	75 0c                	jne    801814 <strtol+0x93>
		s++, base = 8;
  801808:	ff 45 08             	incl   0x8(%ebp)
  80180b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801812:	eb 0d                	jmp    801821 <strtol+0xa0>
	else if (base == 0)
  801814:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801818:	75 07                	jne    801821 <strtol+0xa0>
		base = 10;
  80181a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	8a 00                	mov    (%eax),%al
  801826:	3c 2f                	cmp    $0x2f,%al
  801828:	7e 19                	jle    801843 <strtol+0xc2>
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	8a 00                	mov    (%eax),%al
  80182f:	3c 39                	cmp    $0x39,%al
  801831:	7f 10                	jg     801843 <strtol+0xc2>
			dig = *s - '0';
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	8a 00                	mov    (%eax),%al
  801838:	0f be c0             	movsbl %al,%eax
  80183b:	83 e8 30             	sub    $0x30,%eax
  80183e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801841:	eb 42                	jmp    801885 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	8a 00                	mov    (%eax),%al
  801848:	3c 60                	cmp    $0x60,%al
  80184a:	7e 19                	jle    801865 <strtol+0xe4>
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	3c 7a                	cmp    $0x7a,%al
  801853:	7f 10                	jg     801865 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	8a 00                	mov    (%eax),%al
  80185a:	0f be c0             	movsbl %al,%eax
  80185d:	83 e8 57             	sub    $0x57,%eax
  801860:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801863:	eb 20                	jmp    801885 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
  801868:	8a 00                	mov    (%eax),%al
  80186a:	3c 40                	cmp    $0x40,%al
  80186c:	7e 39                	jle    8018a7 <strtol+0x126>
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	8a 00                	mov    (%eax),%al
  801873:	3c 5a                	cmp    $0x5a,%al
  801875:	7f 30                	jg     8018a7 <strtol+0x126>
			dig = *s - 'A' + 10;
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
  80187a:	8a 00                	mov    (%eax),%al
  80187c:	0f be c0             	movsbl %al,%eax
  80187f:	83 e8 37             	sub    $0x37,%eax
  801882:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801885:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801888:	3b 45 10             	cmp    0x10(%ebp),%eax
  80188b:	7d 19                	jge    8018a6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80188d:	ff 45 08             	incl   0x8(%ebp)
  801890:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801893:	0f af 45 10          	imul   0x10(%ebp),%eax
  801897:	89 c2                	mov    %eax,%edx
  801899:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80189c:	01 d0                	add    %edx,%eax
  80189e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018a1:	e9 7b ff ff ff       	jmp    801821 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018a6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018ab:	74 08                	je     8018b5 <strtol+0x134>
		*endptr = (char *) s;
  8018ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b0:	8b 55 08             	mov    0x8(%ebp),%edx
  8018b3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018b9:	74 07                	je     8018c2 <strtol+0x141>
  8018bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018be:	f7 d8                	neg    %eax
  8018c0:	eb 03                	jmp    8018c5 <strtol+0x144>
  8018c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <ltostr>:

void
ltostr(long value, char *str)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
  8018ca:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018df:	79 13                	jns    8018f4 <ltostr+0x2d>
	{
		neg = 1;
  8018e1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018eb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018ee:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018f1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018fc:	99                   	cltd   
  8018fd:	f7 f9                	idiv   %ecx
  8018ff:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801902:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801905:	8d 50 01             	lea    0x1(%eax),%edx
  801908:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80190b:	89 c2                	mov    %eax,%edx
  80190d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801910:	01 d0                	add    %edx,%eax
  801912:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801915:	83 c2 30             	add    $0x30,%edx
  801918:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80191a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801922:	f7 e9                	imul   %ecx
  801924:	c1 fa 02             	sar    $0x2,%edx
  801927:	89 c8                	mov    %ecx,%eax
  801929:	c1 f8 1f             	sar    $0x1f,%eax
  80192c:	29 c2                	sub    %eax,%edx
  80192e:	89 d0                	mov    %edx,%eax
  801930:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801933:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801937:	75 bb                	jne    8018f4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801939:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801940:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801943:	48                   	dec    %eax
  801944:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801947:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80194b:	74 3d                	je     80198a <ltostr+0xc3>
		start = 1 ;
  80194d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801954:	eb 34                	jmp    80198a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801956:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801959:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195c:	01 d0                	add    %edx,%eax
  80195e:	8a 00                	mov    (%eax),%al
  801960:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801963:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801966:	8b 45 0c             	mov    0xc(%ebp),%eax
  801969:	01 c2                	add    %eax,%edx
  80196b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80196e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801971:	01 c8                	add    %ecx,%eax
  801973:	8a 00                	mov    (%eax),%al
  801975:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801977:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80197a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197d:	01 c2                	add    %eax,%edx
  80197f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801982:	88 02                	mov    %al,(%edx)
		start++ ;
  801984:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801987:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80198a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801990:	7c c4                	jl     801956 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801992:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801995:	8b 45 0c             	mov    0xc(%ebp),%eax
  801998:	01 d0                	add    %edx,%eax
  80199a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80199d:	90                   	nop
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
  8019a3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019a6:	ff 75 08             	pushl  0x8(%ebp)
  8019a9:	e8 c4 f9 ff ff       	call   801372 <strlen>
  8019ae:	83 c4 04             	add    $0x4,%esp
  8019b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019b4:	ff 75 0c             	pushl  0xc(%ebp)
  8019b7:	e8 b6 f9 ff ff       	call   801372 <strlen>
  8019bc:	83 c4 04             	add    $0x4,%esp
  8019bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019d0:	eb 17                	jmp    8019e9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d8:	01 c2                	add    %eax,%edx
  8019da:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	01 c8                	add    %ecx,%eax
  8019e2:	8a 00                	mov    (%eax),%al
  8019e4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019e6:	ff 45 fc             	incl   -0x4(%ebp)
  8019e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019ef:	7c e1                	jl     8019d2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019ff:	eb 1f                	jmp    801a20 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a04:	8d 50 01             	lea    0x1(%eax),%edx
  801a07:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a0a:	89 c2                	mov    %eax,%edx
  801a0c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0f:	01 c2                	add    %eax,%edx
  801a11:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a17:	01 c8                	add    %ecx,%eax
  801a19:	8a 00                	mov    (%eax),%al
  801a1b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a1d:	ff 45 f8             	incl   -0x8(%ebp)
  801a20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a26:	7c d9                	jl     801a01 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a2b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2e:	01 d0                	add    %edx,%eax
  801a30:	c6 00 00             	movb   $0x0,(%eax)
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a39:	8b 45 14             	mov    0x14(%ebp),%eax
  801a3c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a42:	8b 45 14             	mov    0x14(%ebp),%eax
  801a45:	8b 00                	mov    (%eax),%eax
  801a47:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a4e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a51:	01 d0                	add    %edx,%eax
  801a53:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a59:	eb 0c                	jmp    801a67 <strsplit+0x31>
			*string++ = 0;
  801a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5e:	8d 50 01             	lea    0x1(%eax),%edx
  801a61:	89 55 08             	mov    %edx,0x8(%ebp)
  801a64:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a67:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6a:	8a 00                	mov    (%eax),%al
  801a6c:	84 c0                	test   %al,%al
  801a6e:	74 18                	je     801a88 <strsplit+0x52>
  801a70:	8b 45 08             	mov    0x8(%ebp),%eax
  801a73:	8a 00                	mov    (%eax),%al
  801a75:	0f be c0             	movsbl %al,%eax
  801a78:	50                   	push   %eax
  801a79:	ff 75 0c             	pushl  0xc(%ebp)
  801a7c:	e8 83 fa ff ff       	call   801504 <strchr>
  801a81:	83 c4 08             	add    $0x8,%esp
  801a84:	85 c0                	test   %eax,%eax
  801a86:	75 d3                	jne    801a5b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a88:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8b:	8a 00                	mov    (%eax),%al
  801a8d:	84 c0                	test   %al,%al
  801a8f:	74 5a                	je     801aeb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a91:	8b 45 14             	mov    0x14(%ebp),%eax
  801a94:	8b 00                	mov    (%eax),%eax
  801a96:	83 f8 0f             	cmp    $0xf,%eax
  801a99:	75 07                	jne    801aa2 <strsplit+0x6c>
		{
			return 0;
  801a9b:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa0:	eb 66                	jmp    801b08 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aa2:	8b 45 14             	mov    0x14(%ebp),%eax
  801aa5:	8b 00                	mov    (%eax),%eax
  801aa7:	8d 48 01             	lea    0x1(%eax),%ecx
  801aaa:	8b 55 14             	mov    0x14(%ebp),%edx
  801aad:	89 0a                	mov    %ecx,(%edx)
  801aaf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ab6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab9:	01 c2                	add    %eax,%edx
  801abb:	8b 45 08             	mov    0x8(%ebp),%eax
  801abe:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac0:	eb 03                	jmp    801ac5 <strsplit+0x8f>
			string++;
  801ac2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	8a 00                	mov    (%eax),%al
  801aca:	84 c0                	test   %al,%al
  801acc:	74 8b                	je     801a59 <strsplit+0x23>
  801ace:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad1:	8a 00                	mov    (%eax),%al
  801ad3:	0f be c0             	movsbl %al,%eax
  801ad6:	50                   	push   %eax
  801ad7:	ff 75 0c             	pushl  0xc(%ebp)
  801ada:	e8 25 fa ff ff       	call   801504 <strchr>
  801adf:	83 c4 08             	add    $0x8,%esp
  801ae2:	85 c0                	test   %eax,%eax
  801ae4:	74 dc                	je     801ac2 <strsplit+0x8c>
			string++;
	}
  801ae6:	e9 6e ff ff ff       	jmp    801a59 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801aeb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801aec:	8b 45 14             	mov    0x14(%ebp),%eax
  801aef:	8b 00                	mov    (%eax),%eax
  801af1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801af8:	8b 45 10             	mov    0x10(%ebp),%eax
  801afb:	01 d0                	add    %edx,%eax
  801afd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b03:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
  801b0d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801b16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b1d:	eb 4a                	jmp    801b69 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801b1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b22:	8b 45 08             	mov    0x8(%ebp),%eax
  801b25:	01 c2                	add    %eax,%edx
  801b27:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b2d:	01 c8                	add    %ecx,%eax
  801b2f:	8a 00                	mov    (%eax),%al
  801b31:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801b33:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b39:	01 d0                	add    %edx,%eax
  801b3b:	8a 00                	mov    (%eax),%al
  801b3d:	3c 40                	cmp    $0x40,%al
  801b3f:	7e 25                	jle    801b66 <str2lower+0x5c>
  801b41:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b44:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b47:	01 d0                	add    %edx,%eax
  801b49:	8a 00                	mov    (%eax),%al
  801b4b:	3c 5a                	cmp    $0x5a,%al
  801b4d:	7f 17                	jg     801b66 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801b4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b52:	8b 45 08             	mov    0x8(%ebp),%eax
  801b55:	01 d0                	add    %edx,%eax
  801b57:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b5a:	8b 55 08             	mov    0x8(%ebp),%edx
  801b5d:	01 ca                	add    %ecx,%edx
  801b5f:	8a 12                	mov    (%edx),%dl
  801b61:	83 c2 20             	add    $0x20,%edx
  801b64:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b66:	ff 45 fc             	incl   -0x4(%ebp)
  801b69:	ff 75 0c             	pushl  0xc(%ebp)
  801b6c:	e8 01 f8 ff ff       	call   801372 <strlen>
  801b71:	83 c4 04             	add    $0x4,%esp
  801b74:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b77:	7f a6                	jg     801b1f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b79:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
  801b81:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801b84:	a1 08 40 80 00       	mov    0x804008,%eax
  801b89:	85 c0                	test   %eax,%eax
  801b8b:	74 2d                	je     801bba <uheap_init+0x3c>
	{
		buddy_init();
  801b8d:	e8 87 06 00 00       	call   802219 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801b92:	e8 31 05 00 00       	call   8020c8 <sys_get_uheap_strategy>
  801b97:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801b9c:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801ba3:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801ba6:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801bad:	00 00 80 
		__firstTimeFlag = 0;
  801bb0:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801bb7:	00 00 00 
	}
}
  801bba:	90                   	nop
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
  801bc0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801bc3:	83 ec 04             	sub    $0x4,%esp
  801bc6:	68 48 2e 80 00       	push   $0x802e48
  801bcb:	6a 25                	push   $0x25
  801bcd:	68 79 2e 80 00       	push   $0x802e79
  801bd2:	e8 f4 ed ff ff       	call   8009cb <_panic>

00801bd7 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
  801bda:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801bdd:	83 ec 04             	sub    $0x4,%esp
  801be0:	68 88 2e 80 00       	push   $0x802e88
  801be5:	6a 2f                	push   $0x2f
  801be7:	68 79 2e 80 00       	push   $0x802e79
  801bec:	e8 da ed ff ff       	call   8009cb <_panic>

00801bf1 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
  801bf4:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801bf7:	e8 82 ff ff ff       	call   801b7e <uheap_init>
	if (size == 0) return NULL ;
  801bfc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c00:	75 07                	jne    801c09 <malloc+0x18>
  801c02:	b8 00 00 00 00       	mov    $0x0,%eax
  801c07:	eb 14                	jmp    801c1d <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801c09:	83 ec 04             	sub    $0x4,%esp
  801c0c:	68 bc 2e 80 00       	push   $0x802ebc
  801c11:	6a 43                	push   $0x43
  801c13:	68 79 2e 80 00       	push   $0x802e79
  801c18:	e8 ae ed ff ff       	call   8009cb <_panic>
}
  801c1d:	c9                   	leave  
  801c1e:	c3                   	ret    

00801c1f <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801c1f:	55                   	push   %ebp
  801c20:	89 e5                	mov    %esp,%ebp
  801c22:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801c25:	83 ec 04             	sub    $0x4,%esp
  801c28:	68 e4 2e 80 00       	push   $0x802ee4
  801c2d:	6a 4e                	push   $0x4e
  801c2f:	68 79 2e 80 00       	push   $0x802e79
  801c34:	e8 92 ed ff ff       	call   8009cb <_panic>

00801c39 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
  801c3c:	83 ec 18             	sub    $0x18,%esp
  801c3f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c42:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c45:	e8 34 ff ff ff       	call   801b7e <uheap_init>
	if (size == 0) return NULL ;
  801c4a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c4e:	75 07                	jne    801c57 <smalloc+0x1e>
  801c50:	b8 00 00 00 00       	mov    $0x0,%eax
  801c55:	eb 14                	jmp    801c6b <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801c57:	83 ec 04             	sub    $0x4,%esp
  801c5a:	68 08 2f 80 00       	push   $0x802f08
  801c5f:	6a 5f                	push   $0x5f
  801c61:	68 79 2e 80 00       	push   $0x802e79
  801c66:	e8 60 ed ff ff       	call   8009cb <_panic>
}
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
  801c70:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c73:	e8 06 ff ff ff       	call   801b7e <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801c78:	83 ec 04             	sub    $0x4,%esp
  801c7b:	68 30 2f 80 00       	push   $0x802f30
  801c80:	6a 6f                	push   $0x6f
  801c82:	68 79 2e 80 00       	push   $0x802e79
  801c87:	e8 3f ed ff ff       	call   8009cb <_panic>

00801c8c <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
  801c8f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801c92:	83 ec 04             	sub    $0x4,%esp
  801c95:	68 54 2f 80 00       	push   $0x802f54
  801c9a:	6a 7e                	push   $0x7e
  801c9c:	68 79 2e 80 00       	push   $0x802e79
  801ca1:	e8 25 ed ff ff       	call   8009cb <_panic>

00801ca6 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	57                   	push   %edi
  801caa:	56                   	push   %esi
  801cab:	53                   	push   %ebx
  801cac:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801caf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cb8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cbb:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cbe:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cc1:	cd 30                	int    $0x30
  801cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cc9:	83 c4 10             	add    $0x10,%esp
  801ccc:	5b                   	pop    %ebx
  801ccd:	5e                   	pop    %esi
  801cce:	5f                   	pop    %edi
  801ccf:	5d                   	pop    %ebp
  801cd0:	c3                   	ret    

00801cd1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801cd1:	55                   	push   %ebp
  801cd2:	89 e5                	mov    %esp,%ebp
  801cd4:	83 ec 04             	sub    $0x4,%esp
  801cd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801cda:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801cdd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ce0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce7:	6a 00                	push   $0x0
  801ce9:	51                   	push   %ecx
  801cea:	52                   	push   %edx
  801ceb:	ff 75 0c             	pushl  0xc(%ebp)
  801cee:	50                   	push   %eax
  801cef:	6a 00                	push   $0x0
  801cf1:	e8 b0 ff ff ff       	call   801ca6 <syscall>
  801cf6:	83 c4 18             	add    $0x18,%esp
}
  801cf9:	90                   	nop
  801cfa:	c9                   	leave  
  801cfb:	c3                   	ret    

00801cfc <sys_cgetc>:

int
sys_cgetc(void)
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 02                	push   $0x2
  801d0b:	e8 96 ff ff ff       	call   801ca6 <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
}
  801d13:	c9                   	leave  
  801d14:	c3                   	ret    

00801d15 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801d15:	55                   	push   %ebp
  801d16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 03                	push   $0x3
  801d24:	e8 7d ff ff ff       	call   801ca6 <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
}
  801d2c:	90                   	nop
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    

00801d2f <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 04                	push   $0x4
  801d3e:	e8 63 ff ff ff       	call   801ca6 <syscall>
  801d43:	83 c4 18             	add    $0x18,%esp
}
  801d46:	90                   	nop
  801d47:	c9                   	leave  
  801d48:	c3                   	ret    

00801d49 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801d49:	55                   	push   %ebp
  801d4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	52                   	push   %edx
  801d59:	50                   	push   %eax
  801d5a:	6a 08                	push   $0x8
  801d5c:	e8 45 ff ff ff       	call   801ca6 <syscall>
  801d61:	83 c4 18             	add    $0x18,%esp
}
  801d64:	c9                   	leave  
  801d65:	c3                   	ret    

00801d66 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
  801d69:	56                   	push   %esi
  801d6a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d6b:	8b 75 18             	mov    0x18(%ebp),%esi
  801d6e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d71:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d74:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d77:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7a:	56                   	push   %esi
  801d7b:	53                   	push   %ebx
  801d7c:	51                   	push   %ecx
  801d7d:	52                   	push   %edx
  801d7e:	50                   	push   %eax
  801d7f:	6a 09                	push   $0x9
  801d81:	e8 20 ff ff ff       	call   801ca6 <syscall>
  801d86:	83 c4 18             	add    $0x18,%esp
}
  801d89:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d8c:	5b                   	pop    %ebx
  801d8d:	5e                   	pop    %esi
  801d8e:	5d                   	pop    %ebp
  801d8f:	c3                   	ret    

00801d90 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801d90:	55                   	push   %ebp
  801d91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	ff 75 08             	pushl  0x8(%ebp)
  801d9e:	6a 0a                	push   $0xa
  801da0:	e8 01 ff ff ff       	call   801ca6 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	ff 75 0c             	pushl  0xc(%ebp)
  801db6:	ff 75 08             	pushl  0x8(%ebp)
  801db9:	6a 0b                	push   $0xb
  801dbb:	e8 e6 fe ff ff       	call   801ca6 <syscall>
  801dc0:	83 c4 18             	add    $0x18,%esp
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 0c                	push   $0xc
  801dd4:	e8 cd fe ff ff       	call   801ca6 <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
}
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 0d                	push   $0xd
  801ded:	e8 b4 fe ff ff       	call   801ca6 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 0e                	push   $0xe
  801e06:	e8 9b fe ff ff       	call   801ca6 <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 0f                	push   $0xf
  801e1f:	e8 82 fe ff ff       	call   801ca6 <syscall>
  801e24:	83 c4 18             	add    $0x18,%esp
}
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	ff 75 08             	pushl  0x8(%ebp)
  801e37:	6a 10                	push   $0x10
  801e39:	e8 68 fe ff ff       	call   801ca6 <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	c9                   	leave  
  801e42:	c3                   	ret    

00801e43 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 11                	push   $0x11
  801e52:	e8 4f fe ff ff       	call   801ca6 <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	90                   	nop
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    

00801e5d <sys_cputc>:

void
sys_cputc(const char c)
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
  801e60:	83 ec 04             	sub    $0x4,%esp
  801e63:	8b 45 08             	mov    0x8(%ebp),%eax
  801e66:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e69:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	50                   	push   %eax
  801e76:	6a 01                	push   $0x1
  801e78:	e8 29 fe ff ff       	call   801ca6 <syscall>
  801e7d:	83 c4 18             	add    $0x18,%esp
}
  801e80:	90                   	nop
  801e81:	c9                   	leave  
  801e82:	c3                   	ret    

00801e83 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e83:	55                   	push   %ebp
  801e84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 14                	push   $0x14
  801e92:	e8 0f fe ff ff       	call   801ca6 <syscall>
  801e97:	83 c4 18             	add    $0x18,%esp
}
  801e9a:	90                   	nop
  801e9b:	c9                   	leave  
  801e9c:	c3                   	ret    

00801e9d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801e9d:	55                   	push   %ebp
  801e9e:	89 e5                	mov    %esp,%ebp
  801ea0:	83 ec 04             	sub    $0x4,%esp
  801ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801ea9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801eac:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb3:	6a 00                	push   $0x0
  801eb5:	51                   	push   %ecx
  801eb6:	52                   	push   %edx
  801eb7:	ff 75 0c             	pushl  0xc(%ebp)
  801eba:	50                   	push   %eax
  801ebb:	6a 15                	push   $0x15
  801ebd:	e8 e4 fd ff ff       	call   801ca6 <syscall>
  801ec2:	83 c4 18             	add    $0x18,%esp
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801eca:	8b 55 10             	mov    0x10(%ebp),%edx
  801ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	52                   	push   %edx
  801ed5:	50                   	push   %eax
  801ed6:	ff 75 08             	pushl  0x8(%ebp)
  801ed9:	6a 16                	push   $0x16
  801edb:	e8 c6 fd ff ff       	call   801ca6 <syscall>
  801ee0:	83 c4 18             	add    $0x18,%esp
}
  801ee3:	c9                   	leave  
  801ee4:	c3                   	ret    

00801ee5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801ee8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	52                   	push   %edx
  801ef5:	50                   	push   %eax
  801ef6:	6a 17                	push   $0x17
  801ef8:	e8 a9 fd ff ff       	call   801ca6 <syscall>
  801efd:	83 c4 18             	add    $0x18,%esp
}
  801f00:	c9                   	leave  
  801f01:	c3                   	ret    

00801f02 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801f02:	55                   	push   %ebp
  801f03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801f05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f08:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	52                   	push   %edx
  801f12:	50                   	push   %eax
  801f13:	6a 18                	push   $0x18
  801f15:	e8 8c fd ff ff       	call   801ca6 <syscall>
  801f1a:	83 c4 18             	add    $0x18,%esp
}
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f22:	8b 45 08             	mov    0x8(%ebp),%eax
  801f25:	6a 00                	push   $0x0
  801f27:	ff 75 14             	pushl  0x14(%ebp)
  801f2a:	ff 75 10             	pushl  0x10(%ebp)
  801f2d:	ff 75 0c             	pushl  0xc(%ebp)
  801f30:	50                   	push   %eax
  801f31:	6a 19                	push   $0x19
  801f33:	e8 6e fd ff ff       	call   801ca6 <syscall>
  801f38:	83 c4 18             	add    $0x18,%esp
}
  801f3b:	c9                   	leave  
  801f3c:	c3                   	ret    

00801f3d <sys_run_env>:

void sys_run_env(int32 envId)
{
  801f3d:	55                   	push   %ebp
  801f3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f40:	8b 45 08             	mov    0x8(%ebp),%eax
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	50                   	push   %eax
  801f4c:	6a 1a                	push   $0x1a
  801f4e:	e8 53 fd ff ff       	call   801ca6 <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	90                   	nop
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	50                   	push   %eax
  801f68:	6a 1b                	push   $0x1b
  801f6a:	e8 37 fd ff ff       	call   801ca6 <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
}
  801f72:	c9                   	leave  
  801f73:	c3                   	ret    

00801f74 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f74:	55                   	push   %ebp
  801f75:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 05                	push   $0x5
  801f83:	e8 1e fd ff ff       	call   801ca6 <syscall>
  801f88:	83 c4 18             	add    $0x18,%esp
}
  801f8b:	c9                   	leave  
  801f8c:	c3                   	ret    

00801f8d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f8d:	55                   	push   %ebp
  801f8e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 06                	push   $0x6
  801f9c:	e8 05 fd ff ff       	call   801ca6 <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
}
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 07                	push   $0x7
  801fb5:	e8 ec fc ff ff       	call   801ca6 <syscall>
  801fba:	83 c4 18             	add    $0x18,%esp
}
  801fbd:	c9                   	leave  
  801fbe:	c3                   	ret    

00801fbf <sys_exit_env>:


void sys_exit_env(void)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 1c                	push   $0x1c
  801fce:	e8 d3 fc ff ff       	call   801ca6 <syscall>
  801fd3:	83 c4 18             	add    $0x18,%esp
}
  801fd6:	90                   	nop
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	ff 75 10             	pushl  0x10(%ebp)
  801fe3:	ff 75 0c             	pushl  0xc(%ebp)
  801fe6:	ff 75 08             	pushl  0x8(%ebp)
  801fe9:	6a 13                	push   $0x13
  801feb:	e8 b6 fc ff ff       	call   801ca6 <syscall>
  801ff0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff3:	90                   	nop
}
  801ff4:	c9                   	leave  
  801ff5:	c3                   	ret    

00801ff6 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ff6:	55                   	push   %ebp
  801ff7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 1e                	push   $0x1e
  802005:	e8 9c fc ff ff       	call   801ca6 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
  802012:	83 ec 04             	sub    $0x4,%esp
  802015:	8b 45 08             	mov    0x8(%ebp),%eax
  802018:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80201b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	50                   	push   %eax
  802028:	6a 1f                	push   $0x1f
  80202a:	e8 77 fc ff ff       	call   801ca6 <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
	return ;
  802032:	90                   	nop
}
  802033:	c9                   	leave  
  802034:	c3                   	ret    

00802035 <rsttst>:
void rsttst()
{
  802035:	55                   	push   %ebp
  802036:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 21                	push   $0x21
  802044:	e8 5d fc ff ff       	call   801ca6 <syscall>
  802049:	83 c4 18             	add    $0x18,%esp
	return ;
  80204c:	90                   	nop
}
  80204d:	c9                   	leave  
  80204e:	c3                   	ret    

0080204f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80204f:	55                   	push   %ebp
  802050:	89 e5                	mov    %esp,%ebp
  802052:	83 ec 04             	sub    $0x4,%esp
  802055:	8b 45 14             	mov    0x14(%ebp),%eax
  802058:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80205b:	8b 55 18             	mov    0x18(%ebp),%edx
  80205e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802062:	52                   	push   %edx
  802063:	50                   	push   %eax
  802064:	ff 75 10             	pushl  0x10(%ebp)
  802067:	ff 75 0c             	pushl  0xc(%ebp)
  80206a:	ff 75 08             	pushl  0x8(%ebp)
  80206d:	6a 20                	push   $0x20
  80206f:	e8 32 fc ff ff       	call   801ca6 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
	return ;
  802077:	90                   	nop
}
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <chktst>:
void chktst(uint32 n)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	ff 75 08             	pushl  0x8(%ebp)
  802088:	6a 22                	push   $0x22
  80208a:	e8 17 fc ff ff       	call   801ca6 <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
	return ;
  802092:	90                   	nop
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <inctst>:

void inctst()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 23                	push   $0x23
  8020a4:	e8 fd fb ff ff       	call   801ca6 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ac:	90                   	nop
}
  8020ad:	c9                   	leave  
  8020ae:	c3                   	ret    

008020af <gettst>:
uint32 gettst()
{
  8020af:	55                   	push   %ebp
  8020b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 24                	push   $0x24
  8020be:	e8 e3 fb ff ff       	call   801ca6 <syscall>
  8020c3:	83 c4 18             	add    $0x18,%esp
}
  8020c6:	c9                   	leave  
  8020c7:	c3                   	ret    

008020c8 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8020c8:	55                   	push   %ebp
  8020c9:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 25                	push   $0x25
  8020d7:	e8 ca fb ff ff       	call   801ca6 <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
  8020df:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8020e4:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8020e9:	c9                   	leave  
  8020ea:	c3                   	ret    

008020eb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020eb:	55                   	push   %ebp
  8020ec:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f1:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	ff 75 08             	pushl  0x8(%ebp)
  802101:	6a 26                	push   $0x26
  802103:	e8 9e fb ff ff       	call   801ca6 <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
	return ;
  80210b:	90                   	nop
}
  80210c:	c9                   	leave  
  80210d:	c3                   	ret    

0080210e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80210e:	55                   	push   %ebp
  80210f:	89 e5                	mov    %esp,%ebp
  802111:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802112:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802115:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802118:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211b:	8b 45 08             	mov    0x8(%ebp),%eax
  80211e:	6a 00                	push   $0x0
  802120:	53                   	push   %ebx
  802121:	51                   	push   %ecx
  802122:	52                   	push   %edx
  802123:	50                   	push   %eax
  802124:	6a 27                	push   $0x27
  802126:	e8 7b fb ff ff       	call   801ca6 <syscall>
  80212b:	83 c4 18             	add    $0x18,%esp
}
  80212e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802136:	8b 55 0c             	mov    0xc(%ebp),%edx
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	52                   	push   %edx
  802143:	50                   	push   %eax
  802144:	6a 28                	push   $0x28
  802146:	e8 5b fb ff ff       	call   801ca6 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802153:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802156:	8b 55 0c             	mov    0xc(%ebp),%edx
  802159:	8b 45 08             	mov    0x8(%ebp),%eax
  80215c:	6a 00                	push   $0x0
  80215e:	51                   	push   %ecx
  80215f:	ff 75 10             	pushl  0x10(%ebp)
  802162:	52                   	push   %edx
  802163:	50                   	push   %eax
  802164:	6a 29                	push   $0x29
  802166:	e8 3b fb ff ff       	call   801ca6 <syscall>
  80216b:	83 c4 18             	add    $0x18,%esp
}
  80216e:	c9                   	leave  
  80216f:	c3                   	ret    

00802170 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802170:	55                   	push   %ebp
  802171:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	ff 75 10             	pushl  0x10(%ebp)
  80217a:	ff 75 0c             	pushl  0xc(%ebp)
  80217d:	ff 75 08             	pushl  0x8(%ebp)
  802180:	6a 12                	push   $0x12
  802182:	e8 1f fb ff ff       	call   801ca6 <syscall>
  802187:	83 c4 18             	add    $0x18,%esp
	return ;
  80218a:	90                   	nop
}
  80218b:	c9                   	leave  
  80218c:	c3                   	ret    

0080218d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80218d:	55                   	push   %ebp
  80218e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802190:	8b 55 0c             	mov    0xc(%ebp),%edx
  802193:	8b 45 08             	mov    0x8(%ebp),%eax
  802196:	6a 00                	push   $0x0
  802198:	6a 00                	push   $0x0
  80219a:	6a 00                	push   $0x0
  80219c:	52                   	push   %edx
  80219d:	50                   	push   %eax
  80219e:	6a 2a                	push   $0x2a
  8021a0:	e8 01 fb ff ff       	call   801ca6 <syscall>
  8021a5:	83 c4 18             	add    $0x18,%esp
	return;
  8021a8:	90                   	nop
}
  8021a9:	c9                   	leave  
  8021aa:	c3                   	ret    

008021ab <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8021ab:	55                   	push   %ebp
  8021ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 2b                	push   $0x2b
  8021ba:	e8 e7 fa ff ff       	call   801ca6 <syscall>
  8021bf:	83 c4 18             	add    $0x18,%esp
}
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
  8021c7:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8021ca:	83 ec 04             	sub    $0x4,%esp
  8021cd:	68 78 2f 80 00       	push   $0x802f78
  8021d2:	68 0a 01 00 00       	push   $0x10a
  8021d7:	68 88 2f 80 00       	push   $0x802f88
  8021dc:	e8 ea e7 ff ff       	call   8009cb <_panic>

008021e1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8021e1:	55                   	push   %ebp
  8021e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	ff 75 0c             	pushl  0xc(%ebp)
  8021ed:	ff 75 08             	pushl  0x8(%ebp)
  8021f0:	6a 33                	push   $0x33
  8021f2:	e8 af fa ff ff       	call   801ca6 <syscall>
  8021f7:	83 c4 18             	add    $0x18,%esp
	return;
  8021fa:	90                   	nop
}
  8021fb:	c9                   	leave  
  8021fc:	c3                   	ret    

008021fd <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8021fd:	55                   	push   %ebp
  8021fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	ff 75 0c             	pushl  0xc(%ebp)
  802209:	ff 75 08             	pushl  0x8(%ebp)
  80220c:	6a 34                	push   $0x34
  80220e:	e8 93 fa ff ff       	call   801ca6 <syscall>
  802213:	83 c4 18             	add    $0x18,%esp
	return ;
  802216:	90                   	nop
}
  802217:	c9                   	leave  
  802218:	c3                   	ret    

00802219 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802219:	55                   	push   %ebp
  80221a:	89 e5                	mov    %esp,%ebp
  80221c:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80221f:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  802226:	eb 36                	jmp    80225e <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  802228:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80222b:	c1 e0 04             	shl    $0x4,%eax
  80222e:	05 60 40 80 00       	add    $0x804060,%eax
  802233:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802239:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80223c:	c1 e0 04             	shl    $0x4,%eax
  80223f:	05 64 40 80 00       	add    $0x804064,%eax
  802244:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80224a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80224d:	c1 e0 04             	shl    $0x4,%eax
  802250:	05 6c 40 80 00       	add    $0x80406c,%eax
  802255:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80225b:	ff 45 fc             	incl   -0x4(%ebp)
  80225e:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802262:	7e c4                	jle    802228 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802264:	90                   	nop
  802265:	c9                   	leave  
  802266:	c3                   	ret    

00802267 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802267:	55                   	push   %ebp
  802268:	89 e5                	mov    %esp,%ebp
  80226a:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80226d:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802274:	eb 24                	jmp    80229a <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802276:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802279:	c1 e0 04             	shl    $0x4,%eax
  80227c:	05 6c 40 80 00       	add    $0x80406c,%eax
  802281:	8b 00                	mov    (%eax),%eax
  802283:	83 ec 04             	sub    $0x4,%esp
  802286:	50                   	push   %eax
  802287:	ff 75 f4             	pushl  -0xc(%ebp)
  80228a:	68 98 2f 80 00       	push   $0x802f98
  80228f:	e8 05 ea ff ff       	call   800c99 <cprintf>
  802294:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802297:	ff 45 f4             	incl   -0xc(%ebp)
  80229a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80229e:	7e d6                	jle    802276 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  8022a0:	90                   	nop
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
  8022a6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  8022a9:	83 ec 04             	sub    $0x4,%esp
  8022ac:	68 a8 2f 80 00       	push   $0x802fa8
  8022b1:	6a 33                	push   $0x33
  8022b3:	68 c9 2f 80 00       	push   $0x802fc9
  8022b8:	e8 0e e7 ff ff       	call   8009cb <_panic>

008022bd <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  8022bd:	55                   	push   %ebp
  8022be:	89 e5                	mov    %esp,%ebp
  8022c0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  8022c3:	83 ec 04             	sub    $0x4,%esp
  8022c6:	68 e1 2f 80 00       	push   $0x802fe1
  8022cb:	6a 3e                	push   $0x3e
  8022cd:	68 c9 2f 80 00       	push   $0x802fc9
  8022d2:	e8 f4 e6 ff ff       	call   8009cb <_panic>

008022d7 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8022d7:	55                   	push   %ebp
  8022d8:	89 e5                	mov    %esp,%ebp
  8022da:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8022dd:	83 ec 04             	sub    $0x4,%esp
  8022e0:	68 ff 2f 80 00       	push   $0x802fff
  8022e5:	6a 49                	push   $0x49
  8022e7:	68 c9 2f 80 00       	push   $0x802fc9
  8022ec:	e8 da e6 ff ff       	call   8009cb <_panic>

008022f1 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8022f1:	55                   	push   %ebp
  8022f2:	89 e5                	mov    %esp,%ebp
  8022f4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8022f7:	83 ec 04             	sub    $0x4,%esp
  8022fa:	68 1c 30 80 00       	push   $0x80301c
  8022ff:	6a 58                	push   $0x58
  802301:	68 c9 2f 80 00       	push   $0x802fc9
  802306:	e8 c0 e6 ff ff       	call   8009cb <_panic>
  80230b:	90                   	nop

0080230c <__udivdi3>:
  80230c:	55                   	push   %ebp
  80230d:	57                   	push   %edi
  80230e:	56                   	push   %esi
  80230f:	53                   	push   %ebx
  802310:	83 ec 1c             	sub    $0x1c,%esp
  802313:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802317:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80231b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80231f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802323:	89 ca                	mov    %ecx,%edx
  802325:	89 f8                	mov    %edi,%eax
  802327:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80232b:	85 f6                	test   %esi,%esi
  80232d:	75 2d                	jne    80235c <__udivdi3+0x50>
  80232f:	39 cf                	cmp    %ecx,%edi
  802331:	77 65                	ja     802398 <__udivdi3+0x8c>
  802333:	89 fd                	mov    %edi,%ebp
  802335:	85 ff                	test   %edi,%edi
  802337:	75 0b                	jne    802344 <__udivdi3+0x38>
  802339:	b8 01 00 00 00       	mov    $0x1,%eax
  80233e:	31 d2                	xor    %edx,%edx
  802340:	f7 f7                	div    %edi
  802342:	89 c5                	mov    %eax,%ebp
  802344:	31 d2                	xor    %edx,%edx
  802346:	89 c8                	mov    %ecx,%eax
  802348:	f7 f5                	div    %ebp
  80234a:	89 c1                	mov    %eax,%ecx
  80234c:	89 d8                	mov    %ebx,%eax
  80234e:	f7 f5                	div    %ebp
  802350:	89 cf                	mov    %ecx,%edi
  802352:	89 fa                	mov    %edi,%edx
  802354:	83 c4 1c             	add    $0x1c,%esp
  802357:	5b                   	pop    %ebx
  802358:	5e                   	pop    %esi
  802359:	5f                   	pop    %edi
  80235a:	5d                   	pop    %ebp
  80235b:	c3                   	ret    
  80235c:	39 ce                	cmp    %ecx,%esi
  80235e:	77 28                	ja     802388 <__udivdi3+0x7c>
  802360:	0f bd fe             	bsr    %esi,%edi
  802363:	83 f7 1f             	xor    $0x1f,%edi
  802366:	75 40                	jne    8023a8 <__udivdi3+0x9c>
  802368:	39 ce                	cmp    %ecx,%esi
  80236a:	72 0a                	jb     802376 <__udivdi3+0x6a>
  80236c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802370:	0f 87 9e 00 00 00    	ja     802414 <__udivdi3+0x108>
  802376:	b8 01 00 00 00       	mov    $0x1,%eax
  80237b:	89 fa                	mov    %edi,%edx
  80237d:	83 c4 1c             	add    $0x1c,%esp
  802380:	5b                   	pop    %ebx
  802381:	5e                   	pop    %esi
  802382:	5f                   	pop    %edi
  802383:	5d                   	pop    %ebp
  802384:	c3                   	ret    
  802385:	8d 76 00             	lea    0x0(%esi),%esi
  802388:	31 ff                	xor    %edi,%edi
  80238a:	31 c0                	xor    %eax,%eax
  80238c:	89 fa                	mov    %edi,%edx
  80238e:	83 c4 1c             	add    $0x1c,%esp
  802391:	5b                   	pop    %ebx
  802392:	5e                   	pop    %esi
  802393:	5f                   	pop    %edi
  802394:	5d                   	pop    %ebp
  802395:	c3                   	ret    
  802396:	66 90                	xchg   %ax,%ax
  802398:	89 d8                	mov    %ebx,%eax
  80239a:	f7 f7                	div    %edi
  80239c:	31 ff                	xor    %edi,%edi
  80239e:	89 fa                	mov    %edi,%edx
  8023a0:	83 c4 1c             	add    $0x1c,%esp
  8023a3:	5b                   	pop    %ebx
  8023a4:	5e                   	pop    %esi
  8023a5:	5f                   	pop    %edi
  8023a6:	5d                   	pop    %ebp
  8023a7:	c3                   	ret    
  8023a8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023ad:	89 eb                	mov    %ebp,%ebx
  8023af:	29 fb                	sub    %edi,%ebx
  8023b1:	89 f9                	mov    %edi,%ecx
  8023b3:	d3 e6                	shl    %cl,%esi
  8023b5:	89 c5                	mov    %eax,%ebp
  8023b7:	88 d9                	mov    %bl,%cl
  8023b9:	d3 ed                	shr    %cl,%ebp
  8023bb:	89 e9                	mov    %ebp,%ecx
  8023bd:	09 f1                	or     %esi,%ecx
  8023bf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023c3:	89 f9                	mov    %edi,%ecx
  8023c5:	d3 e0                	shl    %cl,%eax
  8023c7:	89 c5                	mov    %eax,%ebp
  8023c9:	89 d6                	mov    %edx,%esi
  8023cb:	88 d9                	mov    %bl,%cl
  8023cd:	d3 ee                	shr    %cl,%esi
  8023cf:	89 f9                	mov    %edi,%ecx
  8023d1:	d3 e2                	shl    %cl,%edx
  8023d3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023d7:	88 d9                	mov    %bl,%cl
  8023d9:	d3 e8                	shr    %cl,%eax
  8023db:	09 c2                	or     %eax,%edx
  8023dd:	89 d0                	mov    %edx,%eax
  8023df:	89 f2                	mov    %esi,%edx
  8023e1:	f7 74 24 0c          	divl   0xc(%esp)
  8023e5:	89 d6                	mov    %edx,%esi
  8023e7:	89 c3                	mov    %eax,%ebx
  8023e9:	f7 e5                	mul    %ebp
  8023eb:	39 d6                	cmp    %edx,%esi
  8023ed:	72 19                	jb     802408 <__udivdi3+0xfc>
  8023ef:	74 0b                	je     8023fc <__udivdi3+0xf0>
  8023f1:	89 d8                	mov    %ebx,%eax
  8023f3:	31 ff                	xor    %edi,%edi
  8023f5:	e9 58 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  8023fa:	66 90                	xchg   %ax,%ax
  8023fc:	8b 54 24 08          	mov    0x8(%esp),%edx
  802400:	89 f9                	mov    %edi,%ecx
  802402:	d3 e2                	shl    %cl,%edx
  802404:	39 c2                	cmp    %eax,%edx
  802406:	73 e9                	jae    8023f1 <__udivdi3+0xe5>
  802408:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80240b:	31 ff                	xor    %edi,%edi
  80240d:	e9 40 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  802412:	66 90                	xchg   %ax,%ax
  802414:	31 c0                	xor    %eax,%eax
  802416:	e9 37 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  80241b:	90                   	nop

0080241c <__umoddi3>:
  80241c:	55                   	push   %ebp
  80241d:	57                   	push   %edi
  80241e:	56                   	push   %esi
  80241f:	53                   	push   %ebx
  802420:	83 ec 1c             	sub    $0x1c,%esp
  802423:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802427:	8b 74 24 34          	mov    0x34(%esp),%esi
  80242b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80242f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802433:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802437:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80243b:	89 f3                	mov    %esi,%ebx
  80243d:	89 fa                	mov    %edi,%edx
  80243f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802443:	89 34 24             	mov    %esi,(%esp)
  802446:	85 c0                	test   %eax,%eax
  802448:	75 1a                	jne    802464 <__umoddi3+0x48>
  80244a:	39 f7                	cmp    %esi,%edi
  80244c:	0f 86 a2 00 00 00    	jbe    8024f4 <__umoddi3+0xd8>
  802452:	89 c8                	mov    %ecx,%eax
  802454:	89 f2                	mov    %esi,%edx
  802456:	f7 f7                	div    %edi
  802458:	89 d0                	mov    %edx,%eax
  80245a:	31 d2                	xor    %edx,%edx
  80245c:	83 c4 1c             	add    $0x1c,%esp
  80245f:	5b                   	pop    %ebx
  802460:	5e                   	pop    %esi
  802461:	5f                   	pop    %edi
  802462:	5d                   	pop    %ebp
  802463:	c3                   	ret    
  802464:	39 f0                	cmp    %esi,%eax
  802466:	0f 87 ac 00 00 00    	ja     802518 <__umoddi3+0xfc>
  80246c:	0f bd e8             	bsr    %eax,%ebp
  80246f:	83 f5 1f             	xor    $0x1f,%ebp
  802472:	0f 84 ac 00 00 00    	je     802524 <__umoddi3+0x108>
  802478:	bf 20 00 00 00       	mov    $0x20,%edi
  80247d:	29 ef                	sub    %ebp,%edi
  80247f:	89 fe                	mov    %edi,%esi
  802481:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802485:	89 e9                	mov    %ebp,%ecx
  802487:	d3 e0                	shl    %cl,%eax
  802489:	89 d7                	mov    %edx,%edi
  80248b:	89 f1                	mov    %esi,%ecx
  80248d:	d3 ef                	shr    %cl,%edi
  80248f:	09 c7                	or     %eax,%edi
  802491:	89 e9                	mov    %ebp,%ecx
  802493:	d3 e2                	shl    %cl,%edx
  802495:	89 14 24             	mov    %edx,(%esp)
  802498:	89 d8                	mov    %ebx,%eax
  80249a:	d3 e0                	shl    %cl,%eax
  80249c:	89 c2                	mov    %eax,%edx
  80249e:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024a2:	d3 e0                	shl    %cl,%eax
  8024a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024a8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ac:	89 f1                	mov    %esi,%ecx
  8024ae:	d3 e8                	shr    %cl,%eax
  8024b0:	09 d0                	or     %edx,%eax
  8024b2:	d3 eb                	shr    %cl,%ebx
  8024b4:	89 da                	mov    %ebx,%edx
  8024b6:	f7 f7                	div    %edi
  8024b8:	89 d3                	mov    %edx,%ebx
  8024ba:	f7 24 24             	mull   (%esp)
  8024bd:	89 c6                	mov    %eax,%esi
  8024bf:	89 d1                	mov    %edx,%ecx
  8024c1:	39 d3                	cmp    %edx,%ebx
  8024c3:	0f 82 87 00 00 00    	jb     802550 <__umoddi3+0x134>
  8024c9:	0f 84 91 00 00 00    	je     802560 <__umoddi3+0x144>
  8024cf:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024d3:	29 f2                	sub    %esi,%edx
  8024d5:	19 cb                	sbb    %ecx,%ebx
  8024d7:	89 d8                	mov    %ebx,%eax
  8024d9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024dd:	d3 e0                	shl    %cl,%eax
  8024df:	89 e9                	mov    %ebp,%ecx
  8024e1:	d3 ea                	shr    %cl,%edx
  8024e3:	09 d0                	or     %edx,%eax
  8024e5:	89 e9                	mov    %ebp,%ecx
  8024e7:	d3 eb                	shr    %cl,%ebx
  8024e9:	89 da                	mov    %ebx,%edx
  8024eb:	83 c4 1c             	add    $0x1c,%esp
  8024ee:	5b                   	pop    %ebx
  8024ef:	5e                   	pop    %esi
  8024f0:	5f                   	pop    %edi
  8024f1:	5d                   	pop    %ebp
  8024f2:	c3                   	ret    
  8024f3:	90                   	nop
  8024f4:	89 fd                	mov    %edi,%ebp
  8024f6:	85 ff                	test   %edi,%edi
  8024f8:	75 0b                	jne    802505 <__umoddi3+0xe9>
  8024fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ff:	31 d2                	xor    %edx,%edx
  802501:	f7 f7                	div    %edi
  802503:	89 c5                	mov    %eax,%ebp
  802505:	89 f0                	mov    %esi,%eax
  802507:	31 d2                	xor    %edx,%edx
  802509:	f7 f5                	div    %ebp
  80250b:	89 c8                	mov    %ecx,%eax
  80250d:	f7 f5                	div    %ebp
  80250f:	89 d0                	mov    %edx,%eax
  802511:	e9 44 ff ff ff       	jmp    80245a <__umoddi3+0x3e>
  802516:	66 90                	xchg   %ax,%ax
  802518:	89 c8                	mov    %ecx,%eax
  80251a:	89 f2                	mov    %esi,%edx
  80251c:	83 c4 1c             	add    $0x1c,%esp
  80251f:	5b                   	pop    %ebx
  802520:	5e                   	pop    %esi
  802521:	5f                   	pop    %edi
  802522:	5d                   	pop    %ebp
  802523:	c3                   	ret    
  802524:	3b 04 24             	cmp    (%esp),%eax
  802527:	72 06                	jb     80252f <__umoddi3+0x113>
  802529:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80252d:	77 0f                	ja     80253e <__umoddi3+0x122>
  80252f:	89 f2                	mov    %esi,%edx
  802531:	29 f9                	sub    %edi,%ecx
  802533:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802537:	89 14 24             	mov    %edx,(%esp)
  80253a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80253e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802542:	8b 14 24             	mov    (%esp),%edx
  802545:	83 c4 1c             	add    $0x1c,%esp
  802548:	5b                   	pop    %ebx
  802549:	5e                   	pop    %esi
  80254a:	5f                   	pop    %edi
  80254b:	5d                   	pop    %ebp
  80254c:	c3                   	ret    
  80254d:	8d 76 00             	lea    0x0(%esi),%esi
  802550:	2b 04 24             	sub    (%esp),%eax
  802553:	19 fa                	sbb    %edi,%edx
  802555:	89 d1                	mov    %edx,%ecx
  802557:	89 c6                	mov    %eax,%esi
  802559:	e9 71 ff ff ff       	jmp    8024cf <__umoddi3+0xb3>
  80255e:	66 90                	xchg   %ax,%ax
  802560:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802564:	72 ea                	jb     802550 <__umoddi3+0x134>
  802566:	89 d9                	mov    %ebx,%ecx
  802568:	e9 62 ff ff ff       	jmp    8024cf <__umoddi3+0xb3>
