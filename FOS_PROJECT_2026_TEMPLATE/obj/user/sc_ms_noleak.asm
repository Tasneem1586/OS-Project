
obj/user/sc_ms_noleak:     file format elf32-i386


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
  800031:	e8 25 07 00 00       	call   80075b <libmain>
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
  800041:	e8 bf 1c 00 00       	call   801d05 <sys_lock_cons>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 25 80 00       	push   $0x802560
  80004e:	e8 36 0c 00 00       	call   800c89 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 25 80 00       	push   $0x802562
  80005e:	e8 26 0c 00 00       	call   800c89 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 78 25 80 00       	push   $0x802578
  80006e:	e8 16 0c 00 00       	call   800c89 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 25 80 00       	push   $0x802562
  80007e:	e8 06 0c 00 00       	call   800c89 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 25 80 00       	push   $0x802560
  80008e:	e8 f6 0b 00 00       	call   800c89 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		int NumOfElements = 100000 ;
  800096:	c7 45 f0 a0 86 01 00 	movl   $0x186a0,-0x10(%ebp)
		cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  80009d:	83 ec 08             	sub    $0x8,%esp
  8000a0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000a3:	68 90 25 80 00       	push   $0x802590
  8000a8:	e8 dc 0b 00 00       	call   800c89 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp

		cprintf("Chose the initialization method:\n") ;
  8000b0:	83 ec 0c             	sub    $0xc,%esp
  8000b3:	68 b4 25 80 00       	push   $0x8025b4
  8000b8:	e8 cc 0b 00 00       	call   800c89 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	68 d6 25 80 00       	push   $0x8025d6
  8000c8:	e8 bc 0b 00 00       	call   800c89 <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 e4 25 80 00       	push   $0x8025e4
  8000d8:	e8 ac 0b 00 00       	call   800c89 <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	68 f3 25 80 00       	push   $0x8025f3
  8000e8:	e8 9c 0b 00 00       	call   800c89 <cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000f0:	83 ec 0c             	sub    $0xc,%esp
  8000f3:	68 03 26 80 00       	push   $0x802603
  8000f8:	e8 8c 0b 00 00       	call   800c89 <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'c';
  800100:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  800104:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 08 06 00 00       	call   800719 <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 fb 05 00 00       	call   800719 <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800121:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800125:	74 0c                	je     800133 <_main+0xfb>
  800127:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80012b:	74 06                	je     800133 <_main+0xfb>
  80012d:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800131:	75 bd                	jne    8000f0 <_main+0xb8>

		//2012: lock the interrupt
		sys_unlock_cons();
  800133:	e8 e7 1b 00 00       	call   801d1f <sys_unlock_cons>

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800138:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80013b:	c1 e0 02             	shl    $0x2,%eax
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	50                   	push   %eax
  800142:	e8 9a 1a 00 00       	call   801be1 <malloc>
  800147:	83 c4 10             	add    $0x10,%esp
  80014a:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int  i ;
		switch (Chose)
  80014d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800151:	83 f8 62             	cmp    $0x62,%eax
  800154:	74 1d                	je     800173 <_main+0x13b>
  800156:	83 f8 63             	cmp    $0x63,%eax
  800159:	74 2b                	je     800186 <_main+0x14e>
  80015b:	83 f8 61             	cmp    $0x61,%eax
  80015e:	75 39                	jne    800199 <_main+0x161>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800160:	83 ec 08             	sub    $0x8,%esp
  800163:	ff 75 f0             	pushl  -0x10(%ebp)
  800166:	ff 75 ec             	pushl  -0x14(%ebp)
  800169:	e8 f5 01 00 00       	call   800363 <InitializeAscending>
  80016e:	83 c4 10             	add    $0x10,%esp
			break ;
  800171:	eb 37                	jmp    8001aa <_main+0x172>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	ff 75 f0             	pushl  -0x10(%ebp)
  800179:	ff 75 ec             	pushl  -0x14(%ebp)
  80017c:	e8 13 02 00 00       	call   800394 <InitializeIdentical>
  800181:	83 c4 10             	add    $0x10,%esp
			break ;
  800184:	eb 24                	jmp    8001aa <_main+0x172>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 f0             	pushl  -0x10(%ebp)
  80018c:	ff 75 ec             	pushl  -0x14(%ebp)
  80018f:	e8 35 02 00 00       	call   8003c9 <InitializeSemiRandom>
  800194:	83 c4 10             	add    $0x10,%esp
			break ;
  800197:	eb 11                	jmp    8001aa <_main+0x172>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800199:	83 ec 08             	sub    $0x8,%esp
  80019c:	ff 75 f0             	pushl  -0x10(%ebp)
  80019f:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a2:	e8 22 02 00 00       	call   8003c9 <InitializeSemiRandom>
  8001a7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001aa:	83 ec 04             	sub    $0x4,%esp
  8001ad:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b0:	6a 01                	push   $0x1
  8001b2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b5:	e8 ee 02 00 00       	call   8004a8 <MSort>
  8001ba:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001bd:	e8 43 1b 00 00       	call   801d05 <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 0c 26 80 00       	push   $0x80260c
  8001ca:	e8 ba 0a 00 00       	call   800c89 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  8001d2:	e8 48 1b 00 00       	call   801d1f <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 f0             	pushl  -0x10(%ebp)
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	e8 d4 00 00 00       	call   8002b9 <CheckSorted>
  8001e5:	83 c4 10             	add    $0x10,%esp
  8001e8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001eb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ef:	75 14                	jne    800205 <_main+0x1cd>
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	68 40 26 80 00       	push   $0x802640
  8001f9:	6a 4e                	push   $0x4e
  8001fb:	68 62 26 80 00       	push   $0x802662
  800200:	e8 b6 07 00 00       	call   8009bb <_panic>
		else
		{
			sys_lock_cons();
  800205:	e8 fb 1a 00 00       	call   801d05 <sys_lock_cons>
			cprintf("===============================================\n") ;
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	68 78 26 80 00       	push   $0x802678
  800212:	e8 72 0a 00 00       	call   800c89 <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 ac 26 80 00       	push   $0x8026ac
  800222:	e8 62 0a 00 00       	call   800c89 <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 e0 26 80 00       	push   $0x8026e0
  800232:	e8 52 0a 00 00       	call   800c89 <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  80023a:	e8 e0 1a 00 00       	call   801d1f <sys_unlock_cons>
		}

		free(Elements) ;
  80023f:	83 ec 0c             	sub    $0xc,%esp
  800242:	ff 75 ec             	pushl  -0x14(%ebp)
  800245:	e8 c5 19 00 00       	call   801c0f <free>
  80024a:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80024d:	e8 b3 1a 00 00       	call   801d05 <sys_lock_cons>
			Chose = 0 ;
  800252:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800256:	eb 3e                	jmp    800296 <_main+0x25e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800258:	83 ec 0c             	sub    $0xc,%esp
  80025b:	68 12 27 80 00       	push   $0x802712
  800260:	e8 24 0a 00 00       	call   800c89 <cprintf>
  800265:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800268:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80026c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800270:	83 ec 0c             	sub    $0xc,%esp
  800273:	50                   	push   %eax
  800274:	e8 a0 04 00 00       	call   800719 <cputchar>
  800279:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	6a 0a                	push   $0xa
  800281:	e8 93 04 00 00       	call   800719 <cputchar>
  800286:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800289:	83 ec 0c             	sub    $0xc,%esp
  80028c:	6a 0a                	push   $0xa
  80028e:	e8 86 04 00 00       	call   800719 <cputchar>
  800293:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_lock_cons();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  800296:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  80029a:	74 06                	je     8002a2 <_main+0x26a>
  80029c:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002a0:	75 b6                	jne    800258 <_main+0x220>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_unlock_cons();
  8002a2:	e8 78 1a 00 00       	call   801d1f <sys_unlock_cons>

	} while (Chose == 'y');
  8002a7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002ab:	0f 84 90 fd ff ff    	je     800041 <_main+0x9>

	//To indicate that it's completed successfully
	inctst();
  8002b1:	e8 cf 1d 00 00       	call   802085 <inctst>

}
  8002b6:	90                   	nop
  8002b7:	c9                   	leave  
  8002b8:	c3                   	ret    

008002b9 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002b9:	55                   	push   %ebp
  8002ba:	89 e5                	mov    %esp,%ebp
  8002bc:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002bf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002cd:	eb 33                	jmp    800302 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002dc:	01 d0                	add    %edx,%eax
  8002de:	8b 10                	mov    (%eax),%edx
  8002e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002e3:	40                   	inc    %eax
  8002e4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ee:	01 c8                	add    %ecx,%eax
  8002f0:	8b 00                	mov    (%eax),%eax
  8002f2:	39 c2                	cmp    %eax,%edx
  8002f4:	7e 09                	jle    8002ff <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8002f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8002fd:	eb 0c                	jmp    80030b <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002ff:	ff 45 f8             	incl   -0x8(%ebp)
  800302:	8b 45 0c             	mov    0xc(%ebp),%eax
  800305:	48                   	dec    %eax
  800306:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800309:	7f c4                	jg     8002cf <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80030b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80030e:	c9                   	leave  
  80030f:	c3                   	ret    

00800310 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800310:	55                   	push   %ebp
  800311:	89 e5                	mov    %esp,%ebp
  800313:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800316:	8b 45 0c             	mov    0xc(%ebp),%eax
  800319:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800320:	8b 45 08             	mov    0x8(%ebp),%eax
  800323:	01 d0                	add    %edx,%eax
  800325:	8b 00                	mov    (%eax),%eax
  800327:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80032a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800334:	8b 45 08             	mov    0x8(%ebp),%eax
  800337:	01 c2                	add    %eax,%edx
  800339:	8b 45 10             	mov    0x10(%ebp),%eax
  80033c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800343:	8b 45 08             	mov    0x8(%ebp),%eax
  800346:	01 c8                	add    %ecx,%eax
  800348:	8b 00                	mov    (%eax),%eax
  80034a:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80034c:	8b 45 10             	mov    0x10(%ebp),%eax
  80034f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800356:	8b 45 08             	mov    0x8(%ebp),%eax
  800359:	01 c2                	add    %eax,%edx
  80035b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80035e:	89 02                	mov    %eax,(%edx)
}
  800360:	90                   	nop
  800361:	c9                   	leave  
  800362:	c3                   	ret    

00800363 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800363:	55                   	push   %ebp
  800364:	89 e5                	mov    %esp,%ebp
  800366:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800369:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800370:	eb 17                	jmp    800389 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800372:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800375:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80037c:	8b 45 08             	mov    0x8(%ebp),%eax
  80037f:	01 c2                	add    %eax,%edx
  800381:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800384:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800386:	ff 45 fc             	incl   -0x4(%ebp)
  800389:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80038f:	7c e1                	jl     800372 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800391:	90                   	nop
  800392:	c9                   	leave  
  800393:	c3                   	ret    

00800394 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800394:	55                   	push   %ebp
  800395:	89 e5                	mov    %esp,%ebp
  800397:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003a1:	eb 1b                	jmp    8003be <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b0:	01 c2                	add    %eax,%edx
  8003b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b5:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003b8:	48                   	dec    %eax
  8003b9:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003bb:	ff 45 fc             	incl   -0x4(%ebp)
  8003be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c4:	7c dd                	jl     8003a3 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003c6:	90                   	nop
  8003c7:	c9                   	leave  
  8003c8:	c3                   	ret    

008003c9 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003c9:	55                   	push   %ebp
  8003ca:	89 e5                	mov    %esp,%ebp
  8003cc:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003cf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003d2:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003d7:	f7 e9                	imul   %ecx
  8003d9:	c1 f9 1f             	sar    $0x1f,%ecx
  8003dc:	89 d0                	mov    %edx,%eax
  8003de:	29 c8                	sub    %ecx,%eax
  8003e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8003e3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8003e7:	75 07                	jne    8003f0 <InitializeSemiRandom+0x27>
			Repetition = 3;
  8003e9:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f7:	eb 1e                	jmp    800417 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8003f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040c:	99                   	cltd   
  80040d:	f7 7d f8             	idivl  -0x8(%ebp)
  800410:	89 d0                	mov    %edx,%eax
  800412:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800414:	ff 45 fc             	incl   -0x4(%ebp)
  800417:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041d:	7c da                	jl     8003f9 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041f:	90                   	nop
  800420:	c9                   	leave  
  800421:	c3                   	ret    

00800422 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800422:	55                   	push   %ebp
  800423:	89 e5                	mov    %esp,%ebp
  800425:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800428:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800436:	eb 42                	jmp    80047a <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800438:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043b:	99                   	cltd   
  80043c:	f7 7d f0             	idivl  -0x10(%ebp)
  80043f:	89 d0                	mov    %edx,%eax
  800441:	85 c0                	test   %eax,%eax
  800443:	75 10                	jne    800455 <PrintElements+0x33>
			cprintf("\n");
  800445:	83 ec 0c             	sub    $0xc,%esp
  800448:	68 60 25 80 00       	push   $0x802560
  80044d:	e8 37 08 00 00       	call   800c89 <cprintf>
  800452:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800455:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 d0                	add    %edx,%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	83 ec 08             	sub    $0x8,%esp
  800469:	50                   	push   %eax
  80046a:	68 30 27 80 00       	push   $0x802730
  80046f:	e8 15 08 00 00       	call   800c89 <cprintf>
  800474:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800477:	ff 45 f4             	incl   -0xc(%ebp)
  80047a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047d:	48                   	dec    %eax
  80047e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800481:	7f b5                	jg     800438 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800483:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800486:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	01 d0                	add    %edx,%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	83 ec 08             	sub    $0x8,%esp
  800497:	50                   	push   %eax
  800498:	68 35 27 80 00       	push   $0x802735
  80049d:	e8 e7 07 00 00       	call   800c89 <cprintf>
  8004a2:	83 c4 10             	add    $0x10,%esp

}
  8004a5:	90                   	nop
  8004a6:	c9                   	leave  
  8004a7:	c3                   	ret    

008004a8 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
  8004ab:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b4:	7d 54                	jge    80050a <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bc:	01 d0                	add    %edx,%eax
  8004be:	89 c2                	mov    %eax,%edx
  8004c0:	c1 ea 1f             	shr    $0x1f,%edx
  8004c3:	01 d0                	add    %edx,%eax
  8004c5:	d1 f8                	sar    %eax
  8004c7:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8004d0:	ff 75 0c             	pushl  0xc(%ebp)
  8004d3:	ff 75 08             	pushl  0x8(%ebp)
  8004d6:	e8 cd ff ff ff       	call   8004a8 <MSort>
  8004db:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e1:	40                   	inc    %eax
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	ff 75 10             	pushl  0x10(%ebp)
  8004e8:	50                   	push   %eax
  8004e9:	ff 75 08             	pushl  0x8(%ebp)
  8004ec:	e8 b7 ff ff ff       	call   8004a8 <MSort>
  8004f1:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f4:	ff 75 10             	pushl  0x10(%ebp)
  8004f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004fa:	ff 75 0c             	pushl  0xc(%ebp)
  8004fd:	ff 75 08             	pushl  0x8(%ebp)
  800500:	e8 08 00 00 00       	call   80050d <Merge>
  800505:	83 c4 10             	add    $0x10,%esp
  800508:	eb 01                	jmp    80050b <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80050a:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80050b:	c9                   	leave  
  80050c:	c3                   	ret    

0080050d <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050d:	55                   	push   %ebp
  80050e:	89 e5                	mov    %esp,%ebp
  800510:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800513:	8b 45 10             	mov    0x10(%ebp),%eax
  800516:	2b 45 0c             	sub    0xc(%ebp),%eax
  800519:	40                   	inc    %eax
  80051a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051d:	8b 45 14             	mov    0x14(%ebp),%eax
  800520:	2b 45 10             	sub    0x10(%ebp),%eax
  800523:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800526:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800534:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800537:	c1 e0 02             	shl    $0x2,%eax
  80053a:	83 ec 0c             	sub    $0xc,%esp
  80053d:	50                   	push   %eax
  80053e:	e8 9e 16 00 00       	call   801be1 <malloc>
  800543:	83 c4 10             	add    $0x10,%esp
  800546:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800549:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054c:	c1 e0 02             	shl    $0x2,%eax
  80054f:	83 ec 0c             	sub    $0xc,%esp
  800552:	50                   	push   %eax
  800553:	e8 89 16 00 00       	call   801be1 <malloc>
  800558:	83 c4 10             	add    $0x10,%esp
  80055b:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800565:	eb 2f                	jmp    800596 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800567:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80056a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800571:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800574:	01 c2                	add    %eax,%edx
  800576:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800579:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057c:	01 c8                	add    %ecx,%eax
  80057e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800583:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	01 c8                	add    %ecx,%eax
  80058f:	8b 00                	mov    (%eax),%eax
  800591:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800593:	ff 45 ec             	incl   -0x14(%ebp)
  800596:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800599:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059c:	7c c9                	jl     800567 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a5:	eb 2a                	jmp    8005d1 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b4:	01 c2                	add    %eax,%edx
  8005b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005bc:	01 c8                	add    %ecx,%eax
  8005be:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005ce:	ff 45 e8             	incl   -0x18(%ebp)
  8005d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d4:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d7:	7c ce                	jl     8005a7 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005df:	e9 0a 01 00 00       	jmp    8006ee <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005ea:	0f 8d 95 00 00 00    	jge    800685 <Merge+0x178>
  8005f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f3:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f6:	0f 8d 89 00 00 00    	jge    800685 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800606:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800609:	01 d0                	add    %edx,%eax
  80060b:	8b 10                	mov    (%eax),%edx
  80060d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800610:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800617:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80061a:	01 c8                	add    %ecx,%eax
  80061c:	8b 00                	mov    (%eax),%eax
  80061e:	39 c2                	cmp    %eax,%edx
  800620:	7d 33                	jge    800655 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800622:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800625:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80062a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800637:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80063a:	8d 50 01             	lea    0x1(%eax),%edx
  80063d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800640:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800647:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80064a:	01 d0                	add    %edx,%eax
  80064c:	8b 00                	mov    (%eax),%eax
  80064e:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800650:	e9 96 00 00 00       	jmp    8006eb <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800655:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800658:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80066a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066d:	8d 50 01             	lea    0x1(%eax),%edx
  800670:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800673:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80067a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067d:	01 d0                	add    %edx,%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800683:	eb 66                	jmp    8006eb <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800685:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800688:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80068b:	7d 30                	jge    8006bd <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800690:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800695:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069c:	8b 45 08             	mov    0x8(%ebp),%eax
  80069f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a5:	8d 50 01             	lea    0x1(%eax),%edx
  8006a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b5:	01 d0                	add    %edx,%eax
  8006b7:	8b 00                	mov    (%eax),%eax
  8006b9:	89 01                	mov    %eax,(%ecx)
  8006bb:	eb 2e                	jmp    8006eb <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c0:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d5:	8d 50 01             	lea    0x1(%eax),%edx
  8006d8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e5:	01 d0                	add    %edx,%eax
  8006e7:	8b 00                	mov    (%eax),%eax
  8006e9:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006eb:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006f1:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f4:	0f 8e ea fe ff ff    	jle    8005e4 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  8006fa:	83 ec 0c             	sub    $0xc,%esp
  8006fd:	ff 75 d8             	pushl  -0x28(%ebp)
  800700:	e8 0a 15 00 00       	call   801c0f <free>
  800705:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800708:	83 ec 0c             	sub    $0xc,%esp
  80070b:	ff 75 d4             	pushl  -0x2c(%ebp)
  80070e:	e8 fc 14 00 00       	call   801c0f <free>
  800713:	83 c4 10             	add    $0x10,%esp

}
  800716:	90                   	nop
  800717:	c9                   	leave  
  800718:	c3                   	ret    

00800719 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800719:	55                   	push   %ebp
  80071a:	89 e5                	mov    %esp,%ebp
  80071c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800725:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800729:	83 ec 0c             	sub    $0xc,%esp
  80072c:	50                   	push   %eax
  80072d:	e8 1b 17 00 00       	call   801e4d <sys_cputc>
  800732:	83 c4 10             	add    $0x10,%esp
}
  800735:	90                   	nop
  800736:	c9                   	leave  
  800737:	c3                   	ret    

00800738 <getchar>:


int
getchar(void)
{
  800738:	55                   	push   %ebp
  800739:	89 e5                	mov    %esp,%ebp
  80073b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  80073e:	e8 a9 15 00 00       	call   801cec <sys_cgetc>
  800743:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800746:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80074a:	74 f2                	je     80073e <getchar+0x6>
	return c;
  80074c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <iscons>:

int iscons(int fdnum)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800754:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800759:	5d                   	pop    %ebp
  80075a:	c3                   	ret    

0080075b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80075b:	55                   	push   %ebp
  80075c:	89 e5                	mov    %esp,%ebp
  80075e:	57                   	push   %edi
  80075f:	56                   	push   %esi
  800760:	53                   	push   %ebx
  800761:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800767:	e8 11 18 00 00       	call   801f7d <sys_getenvindex>
  80076c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80076f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800772:	89 d0                	mov    %edx,%eax
  800774:	c1 e0 03             	shl    $0x3,%eax
  800777:	01 d0                	add    %edx,%eax
  800779:	c1 e0 06             	shl    $0x6,%eax
  80077c:	01 d0                	add    %edx,%eax
  80077e:	c1 e0 03             	shl    $0x3,%eax
  800781:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800786:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80078b:	a1 24 40 80 00       	mov    0x804024,%eax
  800790:	8a 40 10             	mov    0x10(%eax),%al
  800793:	84 c0                	test   %al,%al
  800795:	74 0d                	je     8007a4 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800797:	a1 24 40 80 00       	mov    0x804024,%eax
  80079c:	83 c0 10             	add    $0x10,%eax
  80079f:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007a8:	7e 0a                	jle    8007b4 <libmain+0x59>
		binaryname = argv[0];
  8007aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007ad:	8b 00                	mov    (%eax),%eax
  8007af:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ba:	ff 75 08             	pushl  0x8(%ebp)
  8007bd:	e8 76 f8 ff ff       	call   800038 <_main>
  8007c2:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8007c5:	a1 00 40 80 00       	mov    0x804000,%eax
  8007ca:	85 c0                	test   %eax,%eax
  8007cc:	0f 84 b7 01 00 00    	je     800989 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007d2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007d8:	bb 78 28 80 00       	mov    $0x802878,%ebx
  8007dd:	ba 0e 00 00 00       	mov    $0xe,%edx
  8007e2:	89 c7                	mov    %eax,%edi
  8007e4:	89 de                	mov    %ebx,%esi
  8007e6:	89 d1                	mov    %edx,%ecx
  8007e8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007ea:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8007f0:	b9 56 00 00 00       	mov    $0x56,%ecx
  8007f5:	b0 00                	mov    $0x0,%al
  8007f7:	89 d7                	mov    %edx,%edi
  8007f9:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8007fb:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800802:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	50                   	push   %eax
  800809:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80080f:	50                   	push   %eax
  800810:	e8 68 19 00 00       	call   80217d <sys_utilities>
  800815:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800818:	e8 e8 14 00 00       	call   801d05 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80081d:	83 ec 0c             	sub    $0xc,%esp
  800820:	68 54 27 80 00       	push   $0x802754
  800825:	e8 5f 04 00 00       	call   800c89 <cprintf>
  80082a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80082d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800830:	85 c0                	test   %eax,%eax
  800832:	74 58                	je     80088c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800834:	e8 62 19 00 00       	call   80219b <sys_get_optimal_num_faults>
  800839:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80083c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800842:	bb dc 28 80 00       	mov    $0x8028dc,%ebx
  800847:	ba 11 00 00 00       	mov    $0x11,%edx
  80084c:	89 c7                	mov    %eax,%edi
  80084e:	89 de                	mov    %ebx,%esi
  800850:	89 d1                	mov    %edx,%ecx
  800852:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800854:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800857:	b9 53 00 00 00       	mov    $0x53,%ecx
  80085c:	b0 00                	mov    $0x0,%al
  80085e:	89 d7                	mov    %edx,%edi
  800860:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	ff 75 dc             	pushl  -0x24(%ebp)
  800868:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80086e:	50                   	push   %eax
  80086f:	e8 09 19 00 00       	call   80217d <sys_utilities>
  800874:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800877:	83 ec 08             	sub    $0x8,%esp
  80087a:	ff 75 dc             	pushl  -0x24(%ebp)
  80087d:	68 7c 27 80 00       	push   $0x80277c
  800882:	e8 02 04 00 00       	call   800c89 <cprintf>
  800887:	83 c4 10             	add    $0x10,%esp
  80088a:	eb 59                	jmp    8008e5 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80088c:	a1 24 40 80 00       	mov    0x804024,%eax
  800891:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800897:	a1 24 40 80 00       	mov    0x804024,%eax
  80089c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8008a2:	83 ec 04             	sub    $0x4,%esp
  8008a5:	52                   	push   %edx
  8008a6:	50                   	push   %eax
  8008a7:	68 a0 27 80 00       	push   $0x8027a0
  8008ac:	e8 d8 03 00 00       	call   800c89 <cprintf>
  8008b1:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8008b4:	a1 24 40 80 00       	mov    0x804024,%eax
  8008b9:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8008bf:	a1 24 40 80 00       	mov    0x804024,%eax
  8008c4:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008ca:	a1 24 40 80 00       	mov    0x804024,%eax
  8008cf:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008d5:	51                   	push   %ecx
  8008d6:	52                   	push   %edx
  8008d7:	50                   	push   %eax
  8008d8:	68 c8 27 80 00       	push   $0x8027c8
  8008dd:	e8 a7 03 00 00       	call   800c89 <cprintf>
  8008e2:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008e5:	a1 24 40 80 00       	mov    0x804024,%eax
  8008ea:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8008f0:	83 ec 08             	sub    $0x8,%esp
  8008f3:	50                   	push   %eax
  8008f4:	68 20 28 80 00       	push   $0x802820
  8008f9:	e8 8b 03 00 00       	call   800c89 <cprintf>
  8008fe:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800901:	83 ec 0c             	sub    $0xc,%esp
  800904:	68 34 28 80 00       	push   $0x802834
  800909:	e8 7b 03 00 00       	call   800c89 <cprintf>
  80090e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800911:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800918:	eb 28                	jmp    800942 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80091a:	a1 24 40 80 00       	mov    0x804024,%eax
  80091f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800922:	81 c2 74 04 00 00    	add    $0x474,%edx
  800928:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80092b:	83 ec 04             	sub    $0x4,%esp
  80092e:	50                   	push   %eax
  80092f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800932:	68 4b 28 80 00       	push   $0x80284b
  800937:	e8 4d 03 00 00       	call   800c89 <cprintf>
  80093c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80093f:	ff 45 e4             	incl   -0x1c(%ebp)
  800942:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800946:	7e d2                	jle    80091a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800948:	83 ec 0c             	sub    $0xc,%esp
  80094b:	68 5a 28 80 00       	push   $0x80285a
  800950:	e8 34 03 00 00       	call   800c89 <cprintf>
  800955:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800958:	a1 24 40 80 00       	mov    0x804024,%eax
  80095d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	50                   	push   %eax
  800967:	68 5e 28 80 00       	push   $0x80285e
  80096c:	e8 18 03 00 00       	call   800c89 <cprintf>
  800971:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800974:	83 ec 0c             	sub    $0xc,%esp
  800977:	68 54 27 80 00       	push   $0x802754
  80097c:	e8 08 03 00 00       	call   800c89 <cprintf>
  800981:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800984:	e8 96 13 00 00       	call   801d1f <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800989:	e8 1f 00 00 00       	call   8009ad <exit>
}
  80098e:	90                   	nop
  80098f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800992:	5b                   	pop    %ebx
  800993:	5e                   	pop    %esi
  800994:	5f                   	pop    %edi
  800995:	5d                   	pop    %ebp
  800996:	c3                   	ret    

00800997 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800997:	55                   	push   %ebp
  800998:	89 e5                	mov    %esp,%ebp
  80099a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80099d:	83 ec 0c             	sub    $0xc,%esp
  8009a0:	6a 00                	push   $0x0
  8009a2:	e8 a2 15 00 00       	call   801f49 <sys_destroy_env>
  8009a7:	83 c4 10             	add    $0x10,%esp
}
  8009aa:	90                   	nop
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <exit>:

void
exit(void)
{
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8009b3:	e8 f7 15 00 00       	call   801faf <sys_exit_env>
}
  8009b8:	90                   	nop
  8009b9:	c9                   	leave  
  8009ba:	c3                   	ret    

008009bb <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009bb:	55                   	push   %ebp
  8009bc:	89 e5                	mov    %esp,%ebp
  8009be:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009c1:	8d 45 10             	lea    0x10(%ebp),%eax
  8009c4:	83 c0 04             	add    $0x4,%eax
  8009c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009ca:	a1 28 41 80 00       	mov    0x804128,%eax
  8009cf:	85 c0                	test   %eax,%eax
  8009d1:	74 16                	je     8009e9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009d3:	a1 28 41 80 00       	mov    0x804128,%eax
  8009d8:	83 ec 08             	sub    $0x8,%esp
  8009db:	50                   	push   %eax
  8009dc:	68 40 29 80 00       	push   $0x802940
  8009e1:	e8 a3 02 00 00       	call   800c89 <cprintf>
  8009e6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8009e9:	a1 04 40 80 00       	mov    0x804004,%eax
  8009ee:	83 ec 0c             	sub    $0xc,%esp
  8009f1:	ff 75 0c             	pushl  0xc(%ebp)
  8009f4:	ff 75 08             	pushl  0x8(%ebp)
  8009f7:	50                   	push   %eax
  8009f8:	68 48 29 80 00       	push   $0x802948
  8009fd:	6a 74                	push   $0x74
  8009ff:	e8 b2 02 00 00       	call   800cb6 <cprintf_colored>
  800a04:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800a07:	8b 45 10             	mov    0x10(%ebp),%eax
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a10:	50                   	push   %eax
  800a11:	e8 04 02 00 00       	call   800c1a <vcprintf>
  800a16:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a19:	83 ec 08             	sub    $0x8,%esp
  800a1c:	6a 00                	push   $0x0
  800a1e:	68 70 29 80 00       	push   $0x802970
  800a23:	e8 f2 01 00 00       	call   800c1a <vcprintf>
  800a28:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a2b:	e8 7d ff ff ff       	call   8009ad <exit>

	// should not return here
	while (1) ;
  800a30:	eb fe                	jmp    800a30 <_panic+0x75>

00800a32 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a32:	55                   	push   %ebp
  800a33:	89 e5                	mov    %esp,%ebp
  800a35:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a38:	a1 24 40 80 00       	mov    0x804024,%eax
  800a3d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a46:	39 c2                	cmp    %eax,%edx
  800a48:	74 14                	je     800a5e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a4a:	83 ec 04             	sub    $0x4,%esp
  800a4d:	68 74 29 80 00       	push   $0x802974
  800a52:	6a 26                	push   $0x26
  800a54:	68 c0 29 80 00       	push   $0x8029c0
  800a59:	e8 5d ff ff ff       	call   8009bb <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a65:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a6c:	e9 c5 00 00 00       	jmp    800b36 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a74:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	01 d0                	add    %edx,%eax
  800a80:	8b 00                	mov    (%eax),%eax
  800a82:	85 c0                	test   %eax,%eax
  800a84:	75 08                	jne    800a8e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a86:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a89:	e9 a5 00 00 00       	jmp    800b33 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a95:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a9c:	eb 69                	jmp    800b07 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a9e:	a1 24 40 80 00       	mov    0x804024,%eax
  800aa3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800aa9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aac:	89 d0                	mov    %edx,%eax
  800aae:	01 c0                	add    %eax,%eax
  800ab0:	01 d0                	add    %edx,%eax
  800ab2:	c1 e0 03             	shl    $0x3,%eax
  800ab5:	01 c8                	add    %ecx,%eax
  800ab7:	8a 40 04             	mov    0x4(%eax),%al
  800aba:	84 c0                	test   %al,%al
  800abc:	75 46                	jne    800b04 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800abe:	a1 24 40 80 00       	mov    0x804024,%eax
  800ac3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800ac9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800acc:	89 d0                	mov    %edx,%eax
  800ace:	01 c0                	add    %eax,%eax
  800ad0:	01 d0                	add    %edx,%eax
  800ad2:	c1 e0 03             	shl    $0x3,%eax
  800ad5:	01 c8                	add    %ecx,%eax
  800ad7:	8b 00                	mov    (%eax),%eax
  800ad9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800adc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800adf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ae4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	01 c8                	add    %ecx,%eax
  800af5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800af7:	39 c2                	cmp    %eax,%edx
  800af9:	75 09                	jne    800b04 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800afb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b02:	eb 15                	jmp    800b19 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b04:	ff 45 e8             	incl   -0x18(%ebp)
  800b07:	a1 24 40 80 00       	mov    0x804024,%eax
  800b0c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b12:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b15:	39 c2                	cmp    %eax,%edx
  800b17:	77 85                	ja     800a9e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b19:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b1d:	75 14                	jne    800b33 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800b1f:	83 ec 04             	sub    $0x4,%esp
  800b22:	68 cc 29 80 00       	push   $0x8029cc
  800b27:	6a 3a                	push   $0x3a
  800b29:	68 c0 29 80 00       	push   $0x8029c0
  800b2e:	e8 88 fe ff ff       	call   8009bb <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b33:	ff 45 f0             	incl   -0x10(%ebp)
  800b36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b39:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b3c:	0f 8c 2f ff ff ff    	jl     800a71 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b42:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b49:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b50:	eb 26                	jmp    800b78 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b52:	a1 24 40 80 00       	mov    0x804024,%eax
  800b57:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b5d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b60:	89 d0                	mov    %edx,%eax
  800b62:	01 c0                	add    %eax,%eax
  800b64:	01 d0                	add    %edx,%eax
  800b66:	c1 e0 03             	shl    $0x3,%eax
  800b69:	01 c8                	add    %ecx,%eax
  800b6b:	8a 40 04             	mov    0x4(%eax),%al
  800b6e:	3c 01                	cmp    $0x1,%al
  800b70:	75 03                	jne    800b75 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b72:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b75:	ff 45 e0             	incl   -0x20(%ebp)
  800b78:	a1 24 40 80 00       	mov    0x804024,%eax
  800b7d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b83:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b86:	39 c2                	cmp    %eax,%edx
  800b88:	77 c8                	ja     800b52 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b8d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b90:	74 14                	je     800ba6 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800b92:	83 ec 04             	sub    $0x4,%esp
  800b95:	68 20 2a 80 00       	push   $0x802a20
  800b9a:	6a 44                	push   $0x44
  800b9c:	68 c0 29 80 00       	push   $0x8029c0
  800ba1:	e8 15 fe ff ff       	call   8009bb <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ba6:	90                   	nop
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	53                   	push   %ebx
  800bad:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800bb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb3:	8b 00                	mov    (%eax),%eax
  800bb5:	8d 48 01             	lea    0x1(%eax),%ecx
  800bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbb:	89 0a                	mov    %ecx,(%edx)
  800bbd:	8b 55 08             	mov    0x8(%ebp),%edx
  800bc0:	88 d1                	mov    %dl,%cl
  800bc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcc:	8b 00                	mov    (%eax),%eax
  800bce:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bd3:	75 30                	jne    800c05 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800bd5:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800bdb:	a0 40 40 80 00       	mov    0x804040,%al
  800be0:	0f b6 c0             	movzbl %al,%eax
  800be3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800be6:	8b 09                	mov    (%ecx),%ecx
  800be8:	89 cb                	mov    %ecx,%ebx
  800bea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bed:	83 c1 08             	add    $0x8,%ecx
  800bf0:	52                   	push   %edx
  800bf1:	50                   	push   %eax
  800bf2:	53                   	push   %ebx
  800bf3:	51                   	push   %ecx
  800bf4:	e8 c8 10 00 00       	call   801cc1 <sys_cputs>
  800bf9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c08:	8b 40 04             	mov    0x4(%eax),%eax
  800c0b:	8d 50 01             	lea    0x1(%eax),%edx
  800c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c11:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c14:	90                   	nop
  800c15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c18:	c9                   	leave  
  800c19:	c3                   	ret    

00800c1a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c1a:	55                   	push   %ebp
  800c1b:	89 e5                	mov    %esp,%ebp
  800c1d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c23:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c2a:	00 00 00 
	b.cnt = 0;
  800c2d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c34:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c37:	ff 75 0c             	pushl  0xc(%ebp)
  800c3a:	ff 75 08             	pushl  0x8(%ebp)
  800c3d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c43:	50                   	push   %eax
  800c44:	68 a9 0b 80 00       	push   $0x800ba9
  800c49:	e8 5a 02 00 00       	call   800ea8 <vprintfmt>
  800c4e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c51:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c57:	a0 40 40 80 00       	mov    0x804040,%al
  800c5c:	0f b6 c0             	movzbl %al,%eax
  800c5f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c65:	52                   	push   %edx
  800c66:	50                   	push   %eax
  800c67:	51                   	push   %ecx
  800c68:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c6e:	83 c0 08             	add    $0x8,%eax
  800c71:	50                   	push   %eax
  800c72:	e8 4a 10 00 00       	call   801cc1 <sys_cputs>
  800c77:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c7a:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800c81:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c87:	c9                   	leave  
  800c88:	c3                   	ret    

00800c89 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c89:	55                   	push   %ebp
  800c8a:	89 e5                	mov    %esp,%ebp
  800c8c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c8f:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800c96:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	83 ec 08             	sub    $0x8,%esp
  800ca2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca5:	50                   	push   %eax
  800ca6:	e8 6f ff ff ff       	call   800c1a <vcprintf>
  800cab:	83 c4 10             	add    $0x10,%esp
  800cae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cb4:	c9                   	leave  
  800cb5:	c3                   	ret    

00800cb6 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800cb6:	55                   	push   %ebp
  800cb7:	89 e5                	mov    %esp,%ebp
  800cb9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cbc:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	c1 e0 08             	shl    $0x8,%eax
  800cc9:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800cce:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cd1:	83 c0 04             	add    $0x4,%eax
  800cd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce0:	50                   	push   %eax
  800ce1:	e8 34 ff ff ff       	call   800c1a <vcprintf>
  800ce6:	83 c4 10             	add    $0x10,%esp
  800ce9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800cec:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800cf3:	07 00 00 

	return cnt;
  800cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800d01:	e8 ff 0f 00 00       	call   801d05 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800d06:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d09:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	83 ec 08             	sub    $0x8,%esp
  800d12:	ff 75 f4             	pushl  -0xc(%ebp)
  800d15:	50                   	push   %eax
  800d16:	e8 ff fe ff ff       	call   800c1a <vcprintf>
  800d1b:	83 c4 10             	add    $0x10,%esp
  800d1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800d21:	e8 f9 0f 00 00       	call   801d1f <sys_unlock_cons>
	return cnt;
  800d26:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d29:	c9                   	leave  
  800d2a:	c3                   	ret    

00800d2b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d2b:	55                   	push   %ebp
  800d2c:	89 e5                	mov    %esp,%ebp
  800d2e:	53                   	push   %ebx
  800d2f:	83 ec 14             	sub    $0x14,%esp
  800d32:	8b 45 10             	mov    0x10(%ebp),%eax
  800d35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d38:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d3e:	8b 45 18             	mov    0x18(%ebp),%eax
  800d41:	ba 00 00 00 00       	mov    $0x0,%edx
  800d46:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d49:	77 55                	ja     800da0 <printnum+0x75>
  800d4b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d4e:	72 05                	jb     800d55 <printnum+0x2a>
  800d50:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d53:	77 4b                	ja     800da0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d55:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d58:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d5b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d5e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d63:	52                   	push   %edx
  800d64:	50                   	push   %eax
  800d65:	ff 75 f4             	pushl  -0xc(%ebp)
  800d68:	ff 75 f0             	pushl  -0x10(%ebp)
  800d6b:	e8 8c 15 00 00       	call   8022fc <__udivdi3>
  800d70:	83 c4 10             	add    $0x10,%esp
  800d73:	83 ec 04             	sub    $0x4,%esp
  800d76:	ff 75 20             	pushl  0x20(%ebp)
  800d79:	53                   	push   %ebx
  800d7a:	ff 75 18             	pushl  0x18(%ebp)
  800d7d:	52                   	push   %edx
  800d7e:	50                   	push   %eax
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	ff 75 08             	pushl  0x8(%ebp)
  800d85:	e8 a1 ff ff ff       	call   800d2b <printnum>
  800d8a:	83 c4 20             	add    $0x20,%esp
  800d8d:	eb 1a                	jmp    800da9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d8f:	83 ec 08             	sub    $0x8,%esp
  800d92:	ff 75 0c             	pushl  0xc(%ebp)
  800d95:	ff 75 20             	pushl  0x20(%ebp)
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800da0:	ff 4d 1c             	decl   0x1c(%ebp)
  800da3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800da7:	7f e6                	jg     800d8f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800da9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800dac:	bb 00 00 00 00       	mov    $0x0,%ebx
  800db1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db7:	53                   	push   %ebx
  800db8:	51                   	push   %ecx
  800db9:	52                   	push   %edx
  800dba:	50                   	push   %eax
  800dbb:	e8 4c 16 00 00       	call   80240c <__umoddi3>
  800dc0:	83 c4 10             	add    $0x10,%esp
  800dc3:	05 94 2c 80 00       	add    $0x802c94,%eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	0f be c0             	movsbl %al,%eax
  800dcd:	83 ec 08             	sub    $0x8,%esp
  800dd0:	ff 75 0c             	pushl  0xc(%ebp)
  800dd3:	50                   	push   %eax
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	ff d0                	call   *%eax
  800dd9:	83 c4 10             	add    $0x10,%esp
}
  800ddc:	90                   	nop
  800ddd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800de0:	c9                   	leave  
  800de1:	c3                   	ret    

00800de2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800de2:	55                   	push   %ebp
  800de3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800de5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800de9:	7e 1c                	jle    800e07 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	8b 00                	mov    (%eax),%eax
  800df0:	8d 50 08             	lea    0x8(%eax),%edx
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	89 10                	mov    %edx,(%eax)
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8b 00                	mov    (%eax),%eax
  800dfd:	83 e8 08             	sub    $0x8,%eax
  800e00:	8b 50 04             	mov    0x4(%eax),%edx
  800e03:	8b 00                	mov    (%eax),%eax
  800e05:	eb 40                	jmp    800e47 <getuint+0x65>
	else if (lflag)
  800e07:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e0b:	74 1e                	je     800e2b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e10:	8b 00                	mov    (%eax),%eax
  800e12:	8d 50 04             	lea    0x4(%eax),%edx
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 10                	mov    %edx,(%eax)
  800e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1d:	8b 00                	mov    (%eax),%eax
  800e1f:	83 e8 04             	sub    $0x4,%eax
  800e22:	8b 00                	mov    (%eax),%eax
  800e24:	ba 00 00 00 00       	mov    $0x0,%edx
  800e29:	eb 1c                	jmp    800e47 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	8b 00                	mov    (%eax),%eax
  800e30:	8d 50 04             	lea    0x4(%eax),%edx
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
  800e36:	89 10                	mov    %edx,(%eax)
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	8b 00                	mov    (%eax),%eax
  800e3d:	83 e8 04             	sub    $0x4,%eax
  800e40:	8b 00                	mov    (%eax),%eax
  800e42:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e47:	5d                   	pop    %ebp
  800e48:	c3                   	ret    

00800e49 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e49:	55                   	push   %ebp
  800e4a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e4c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e50:	7e 1c                	jle    800e6e <getint+0x25>
		return va_arg(*ap, long long);
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8b 00                	mov    (%eax),%eax
  800e57:	8d 50 08             	lea    0x8(%eax),%edx
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	89 10                	mov    %edx,(%eax)
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	8b 00                	mov    (%eax),%eax
  800e64:	83 e8 08             	sub    $0x8,%eax
  800e67:	8b 50 04             	mov    0x4(%eax),%edx
  800e6a:	8b 00                	mov    (%eax),%eax
  800e6c:	eb 38                	jmp    800ea6 <getint+0x5d>
	else if (lflag)
  800e6e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e72:	74 1a                	je     800e8e <getint+0x45>
		return va_arg(*ap, long);
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8b 00                	mov    (%eax),%eax
  800e79:	8d 50 04             	lea    0x4(%eax),%edx
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	89 10                	mov    %edx,(%eax)
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8b 00                	mov    (%eax),%eax
  800e86:	83 e8 04             	sub    $0x4,%eax
  800e89:	8b 00                	mov    (%eax),%eax
  800e8b:	99                   	cltd   
  800e8c:	eb 18                	jmp    800ea6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	8b 00                	mov    (%eax),%eax
  800e93:	8d 50 04             	lea    0x4(%eax),%edx
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	89 10                	mov    %edx,(%eax)
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8b 00                	mov    (%eax),%eax
  800ea0:	83 e8 04             	sub    $0x4,%eax
  800ea3:	8b 00                	mov    (%eax),%eax
  800ea5:	99                   	cltd   
}
  800ea6:	5d                   	pop    %ebp
  800ea7:	c3                   	ret    

00800ea8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ea8:	55                   	push   %ebp
  800ea9:	89 e5                	mov    %esp,%ebp
  800eab:	56                   	push   %esi
  800eac:	53                   	push   %ebx
  800ead:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eb0:	eb 17                	jmp    800ec9 <vprintfmt+0x21>
			if (ch == '\0')
  800eb2:	85 db                	test   %ebx,%ebx
  800eb4:	0f 84 c1 03 00 00    	je     80127b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800eba:	83 ec 08             	sub    $0x8,%esp
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	53                   	push   %ebx
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecc:	8d 50 01             	lea    0x1(%eax),%edx
  800ecf:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed2:	8a 00                	mov    (%eax),%al
  800ed4:	0f b6 d8             	movzbl %al,%ebx
  800ed7:	83 fb 25             	cmp    $0x25,%ebx
  800eda:	75 d6                	jne    800eb2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800edc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ee0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ee7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800eee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ef5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800efc:	8b 45 10             	mov    0x10(%ebp),%eax
  800eff:	8d 50 01             	lea    0x1(%eax),%edx
  800f02:	89 55 10             	mov    %edx,0x10(%ebp)
  800f05:	8a 00                	mov    (%eax),%al
  800f07:	0f b6 d8             	movzbl %al,%ebx
  800f0a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f0d:	83 f8 5b             	cmp    $0x5b,%eax
  800f10:	0f 87 3d 03 00 00    	ja     801253 <vprintfmt+0x3ab>
  800f16:	8b 04 85 b8 2c 80 00 	mov    0x802cb8(,%eax,4),%eax
  800f1d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f1f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f23:	eb d7                	jmp    800efc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f25:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f29:	eb d1                	jmp    800efc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f2b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f35:	89 d0                	mov    %edx,%eax
  800f37:	c1 e0 02             	shl    $0x2,%eax
  800f3a:	01 d0                	add    %edx,%eax
  800f3c:	01 c0                	add    %eax,%eax
  800f3e:	01 d8                	add    %ebx,%eax
  800f40:	83 e8 30             	sub    $0x30,%eax
  800f43:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f46:	8b 45 10             	mov    0x10(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f4e:	83 fb 2f             	cmp    $0x2f,%ebx
  800f51:	7e 3e                	jle    800f91 <vprintfmt+0xe9>
  800f53:	83 fb 39             	cmp    $0x39,%ebx
  800f56:	7f 39                	jg     800f91 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f58:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f5b:	eb d5                	jmp    800f32 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f60:	83 c0 04             	add    $0x4,%eax
  800f63:	89 45 14             	mov    %eax,0x14(%ebp)
  800f66:	8b 45 14             	mov    0x14(%ebp),%eax
  800f69:	83 e8 04             	sub    $0x4,%eax
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f71:	eb 1f                	jmp    800f92 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f73:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f77:	79 83                	jns    800efc <vprintfmt+0x54>
				width = 0;
  800f79:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f80:	e9 77 ff ff ff       	jmp    800efc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f85:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f8c:	e9 6b ff ff ff       	jmp    800efc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f91:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f96:	0f 89 60 ff ff ff    	jns    800efc <vprintfmt+0x54>
				width = precision, precision = -1;
  800f9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f9f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800fa2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800fa9:	e9 4e ff ff ff       	jmp    800efc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800fae:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800fb1:	e9 46 ff ff ff       	jmp    800efc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb9:	83 c0 04             	add    $0x4,%eax
  800fbc:	89 45 14             	mov    %eax,0x14(%ebp)
  800fbf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc2:	83 e8 04             	sub    $0x4,%eax
  800fc5:	8b 00                	mov    (%eax),%eax
  800fc7:	83 ec 08             	sub    $0x8,%esp
  800fca:	ff 75 0c             	pushl  0xc(%ebp)
  800fcd:	50                   	push   %eax
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	ff d0                	call   *%eax
  800fd3:	83 c4 10             	add    $0x10,%esp
			break;
  800fd6:	e9 9b 02 00 00       	jmp    801276 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fdb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fde:	83 c0 04             	add    $0x4,%eax
  800fe1:	89 45 14             	mov    %eax,0x14(%ebp)
  800fe4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe7:	83 e8 04             	sub    $0x4,%eax
  800fea:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fec:	85 db                	test   %ebx,%ebx
  800fee:	79 02                	jns    800ff2 <vprintfmt+0x14a>
				err = -err;
  800ff0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ff2:	83 fb 64             	cmp    $0x64,%ebx
  800ff5:	7f 0b                	jg     801002 <vprintfmt+0x15a>
  800ff7:	8b 34 9d 00 2b 80 00 	mov    0x802b00(,%ebx,4),%esi
  800ffe:	85 f6                	test   %esi,%esi
  801000:	75 19                	jne    80101b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801002:	53                   	push   %ebx
  801003:	68 a5 2c 80 00       	push   $0x802ca5
  801008:	ff 75 0c             	pushl  0xc(%ebp)
  80100b:	ff 75 08             	pushl  0x8(%ebp)
  80100e:	e8 70 02 00 00       	call   801283 <printfmt>
  801013:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801016:	e9 5b 02 00 00       	jmp    801276 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80101b:	56                   	push   %esi
  80101c:	68 ae 2c 80 00       	push   $0x802cae
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	ff 75 08             	pushl  0x8(%ebp)
  801027:	e8 57 02 00 00       	call   801283 <printfmt>
  80102c:	83 c4 10             	add    $0x10,%esp
			break;
  80102f:	e9 42 02 00 00       	jmp    801276 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801034:	8b 45 14             	mov    0x14(%ebp),%eax
  801037:	83 c0 04             	add    $0x4,%eax
  80103a:	89 45 14             	mov    %eax,0x14(%ebp)
  80103d:	8b 45 14             	mov    0x14(%ebp),%eax
  801040:	83 e8 04             	sub    $0x4,%eax
  801043:	8b 30                	mov    (%eax),%esi
  801045:	85 f6                	test   %esi,%esi
  801047:	75 05                	jne    80104e <vprintfmt+0x1a6>
				p = "(null)";
  801049:	be b1 2c 80 00       	mov    $0x802cb1,%esi
			if (width > 0 && padc != '-')
  80104e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801052:	7e 6d                	jle    8010c1 <vprintfmt+0x219>
  801054:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801058:	74 67                	je     8010c1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80105a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80105d:	83 ec 08             	sub    $0x8,%esp
  801060:	50                   	push   %eax
  801061:	56                   	push   %esi
  801062:	e8 1e 03 00 00       	call   801385 <strnlen>
  801067:	83 c4 10             	add    $0x10,%esp
  80106a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80106d:	eb 16                	jmp    801085 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80106f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801073:	83 ec 08             	sub    $0x8,%esp
  801076:	ff 75 0c             	pushl  0xc(%ebp)
  801079:	50                   	push   %eax
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	ff d0                	call   *%eax
  80107f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801082:	ff 4d e4             	decl   -0x1c(%ebp)
  801085:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801089:	7f e4                	jg     80106f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80108b:	eb 34                	jmp    8010c1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80108d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801091:	74 1c                	je     8010af <vprintfmt+0x207>
  801093:	83 fb 1f             	cmp    $0x1f,%ebx
  801096:	7e 05                	jle    80109d <vprintfmt+0x1f5>
  801098:	83 fb 7e             	cmp    $0x7e,%ebx
  80109b:	7e 12                	jle    8010af <vprintfmt+0x207>
					putch('?', putdat);
  80109d:	83 ec 08             	sub    $0x8,%esp
  8010a0:	ff 75 0c             	pushl  0xc(%ebp)
  8010a3:	6a 3f                	push   $0x3f
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	ff d0                	call   *%eax
  8010aa:	83 c4 10             	add    $0x10,%esp
  8010ad:	eb 0f                	jmp    8010be <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8010af:	83 ec 08             	sub    $0x8,%esp
  8010b2:	ff 75 0c             	pushl  0xc(%ebp)
  8010b5:	53                   	push   %ebx
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	ff d0                	call   *%eax
  8010bb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010be:	ff 4d e4             	decl   -0x1c(%ebp)
  8010c1:	89 f0                	mov    %esi,%eax
  8010c3:	8d 70 01             	lea    0x1(%eax),%esi
  8010c6:	8a 00                	mov    (%eax),%al
  8010c8:	0f be d8             	movsbl %al,%ebx
  8010cb:	85 db                	test   %ebx,%ebx
  8010cd:	74 24                	je     8010f3 <vprintfmt+0x24b>
  8010cf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010d3:	78 b8                	js     80108d <vprintfmt+0x1e5>
  8010d5:	ff 4d e0             	decl   -0x20(%ebp)
  8010d8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010dc:	79 af                	jns    80108d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010de:	eb 13                	jmp    8010f3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010e0:	83 ec 08             	sub    $0x8,%esp
  8010e3:	ff 75 0c             	pushl  0xc(%ebp)
  8010e6:	6a 20                	push   $0x20
  8010e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010eb:	ff d0                	call   *%eax
  8010ed:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010f0:	ff 4d e4             	decl   -0x1c(%ebp)
  8010f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010f7:	7f e7                	jg     8010e0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010f9:	e9 78 01 00 00       	jmp    801276 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010fe:	83 ec 08             	sub    $0x8,%esp
  801101:	ff 75 e8             	pushl  -0x18(%ebp)
  801104:	8d 45 14             	lea    0x14(%ebp),%eax
  801107:	50                   	push   %eax
  801108:	e8 3c fd ff ff       	call   800e49 <getint>
  80110d:	83 c4 10             	add    $0x10,%esp
  801110:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801113:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801116:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801119:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111c:	85 d2                	test   %edx,%edx
  80111e:	79 23                	jns    801143 <vprintfmt+0x29b>
				putch('-', putdat);
  801120:	83 ec 08             	sub    $0x8,%esp
  801123:	ff 75 0c             	pushl  0xc(%ebp)
  801126:	6a 2d                	push   $0x2d
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	ff d0                	call   *%eax
  80112d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801130:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801133:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801136:	f7 d8                	neg    %eax
  801138:	83 d2 00             	adc    $0x0,%edx
  80113b:	f7 da                	neg    %edx
  80113d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801140:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801143:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80114a:	e9 bc 00 00 00       	jmp    80120b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80114f:	83 ec 08             	sub    $0x8,%esp
  801152:	ff 75 e8             	pushl  -0x18(%ebp)
  801155:	8d 45 14             	lea    0x14(%ebp),%eax
  801158:	50                   	push   %eax
  801159:	e8 84 fc ff ff       	call   800de2 <getuint>
  80115e:	83 c4 10             	add    $0x10,%esp
  801161:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801164:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801167:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80116e:	e9 98 00 00 00       	jmp    80120b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801173:	83 ec 08             	sub    $0x8,%esp
  801176:	ff 75 0c             	pushl  0xc(%ebp)
  801179:	6a 58                	push   $0x58
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	ff d0                	call   *%eax
  801180:	83 c4 10             	add    $0x10,%esp
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
			break;
  8011a3:	e9 ce 00 00 00       	jmp    801276 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8011a8:	83 ec 08             	sub    $0x8,%esp
  8011ab:	ff 75 0c             	pushl  0xc(%ebp)
  8011ae:	6a 30                	push   $0x30
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	ff d0                	call   *%eax
  8011b5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011b8:	83 ec 08             	sub    $0x8,%esp
  8011bb:	ff 75 0c             	pushl  0xc(%ebp)
  8011be:	6a 78                	push   $0x78
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	ff d0                	call   *%eax
  8011c5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cb:	83 c0 04             	add    $0x4,%eax
  8011ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8011d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d4:	83 e8 04             	sub    $0x4,%eax
  8011d7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011e3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011ea:	eb 1f                	jmp    80120b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011ec:	83 ec 08             	sub    $0x8,%esp
  8011ef:	ff 75 e8             	pushl  -0x18(%ebp)
  8011f2:	8d 45 14             	lea    0x14(%ebp),%eax
  8011f5:	50                   	push   %eax
  8011f6:	e8 e7 fb ff ff       	call   800de2 <getuint>
  8011fb:	83 c4 10             	add    $0x10,%esp
  8011fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801201:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801204:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80120b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80120f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801212:	83 ec 04             	sub    $0x4,%esp
  801215:	52                   	push   %edx
  801216:	ff 75 e4             	pushl  -0x1c(%ebp)
  801219:	50                   	push   %eax
  80121a:	ff 75 f4             	pushl  -0xc(%ebp)
  80121d:	ff 75 f0             	pushl  -0x10(%ebp)
  801220:	ff 75 0c             	pushl  0xc(%ebp)
  801223:	ff 75 08             	pushl  0x8(%ebp)
  801226:	e8 00 fb ff ff       	call   800d2b <printnum>
  80122b:	83 c4 20             	add    $0x20,%esp
			break;
  80122e:	eb 46                	jmp    801276 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801230:	83 ec 08             	sub    $0x8,%esp
  801233:	ff 75 0c             	pushl  0xc(%ebp)
  801236:	53                   	push   %ebx
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	ff d0                	call   *%eax
  80123c:	83 c4 10             	add    $0x10,%esp
			break;
  80123f:	eb 35                	jmp    801276 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801241:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  801248:	eb 2c                	jmp    801276 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80124a:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801251:	eb 23                	jmp    801276 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801253:	83 ec 08             	sub    $0x8,%esp
  801256:	ff 75 0c             	pushl  0xc(%ebp)
  801259:	6a 25                	push   $0x25
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	ff d0                	call   *%eax
  801260:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801263:	ff 4d 10             	decl   0x10(%ebp)
  801266:	eb 03                	jmp    80126b <vprintfmt+0x3c3>
  801268:	ff 4d 10             	decl   0x10(%ebp)
  80126b:	8b 45 10             	mov    0x10(%ebp),%eax
  80126e:	48                   	dec    %eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	3c 25                	cmp    $0x25,%al
  801273:	75 f3                	jne    801268 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801275:	90                   	nop
		}
	}
  801276:	e9 35 fc ff ff       	jmp    800eb0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80127b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80127c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80127f:	5b                   	pop    %ebx
  801280:	5e                   	pop    %esi
  801281:	5d                   	pop    %ebp
  801282:	c3                   	ret    

00801283 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
  801286:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801289:	8d 45 10             	lea    0x10(%ebp),%eax
  80128c:	83 c0 04             	add    $0x4,%eax
  80128f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801292:	8b 45 10             	mov    0x10(%ebp),%eax
  801295:	ff 75 f4             	pushl  -0xc(%ebp)
  801298:	50                   	push   %eax
  801299:	ff 75 0c             	pushl  0xc(%ebp)
  80129c:	ff 75 08             	pushl  0x8(%ebp)
  80129f:	e8 04 fc ff ff       	call   800ea8 <vprintfmt>
  8012a4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8012a7:	90                   	nop
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	8b 40 08             	mov    0x8(%eax),%eax
  8012b3:	8d 50 01             	lea    0x1(%eax),%edx
  8012b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8012bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bf:	8b 10                	mov    (%eax),%edx
  8012c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c4:	8b 40 04             	mov    0x4(%eax),%eax
  8012c7:	39 c2                	cmp    %eax,%edx
  8012c9:	73 12                	jae    8012dd <sprintputch+0x33>
		*b->buf++ = ch;
  8012cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ce:	8b 00                	mov    (%eax),%eax
  8012d0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d6:	89 0a                	mov    %ecx,(%edx)
  8012d8:	8b 55 08             	mov    0x8(%ebp),%edx
  8012db:	88 10                	mov    %dl,(%eax)
}
  8012dd:	90                   	nop
  8012de:	5d                   	pop    %ebp
  8012df:	c3                   	ret    

008012e0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ef:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	01 d0                	add    %edx,%eax
  8012f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801301:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801305:	74 06                	je     80130d <vsnprintf+0x2d>
  801307:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80130b:	7f 07                	jg     801314 <vsnprintf+0x34>
		return -E_INVAL;
  80130d:	b8 03 00 00 00       	mov    $0x3,%eax
  801312:	eb 20                	jmp    801334 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801314:	ff 75 14             	pushl  0x14(%ebp)
  801317:	ff 75 10             	pushl  0x10(%ebp)
  80131a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80131d:	50                   	push   %eax
  80131e:	68 aa 12 80 00       	push   $0x8012aa
  801323:	e8 80 fb ff ff       	call   800ea8 <vprintfmt>
  801328:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80132b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80132e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801331:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80133c:	8d 45 10             	lea    0x10(%ebp),%eax
  80133f:	83 c0 04             	add    $0x4,%eax
  801342:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801345:	8b 45 10             	mov    0x10(%ebp),%eax
  801348:	ff 75 f4             	pushl  -0xc(%ebp)
  80134b:	50                   	push   %eax
  80134c:	ff 75 0c             	pushl  0xc(%ebp)
  80134f:	ff 75 08             	pushl  0x8(%ebp)
  801352:	e8 89 ff ff ff       	call   8012e0 <vsnprintf>
  801357:	83 c4 10             	add    $0x10,%esp
  80135a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80135d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
  801365:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801368:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136f:	eb 06                	jmp    801377 <strlen+0x15>
		n++;
  801371:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801374:	ff 45 08             	incl   0x8(%ebp)
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 00                	mov    (%eax),%al
  80137c:	84 c0                	test   %al,%al
  80137e:	75 f1                	jne    801371 <strlen+0xf>
		n++;
	return n;
  801380:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
  801388:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80138b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801392:	eb 09                	jmp    80139d <strnlen+0x18>
		n++;
  801394:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801397:	ff 45 08             	incl   0x8(%ebp)
  80139a:	ff 4d 0c             	decl   0xc(%ebp)
  80139d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013a1:	74 09                	je     8013ac <strnlen+0x27>
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	8a 00                	mov    (%eax),%al
  8013a8:	84 c0                	test   %al,%al
  8013aa:	75 e8                	jne    801394 <strnlen+0xf>
		n++;
	return n;
  8013ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
  8013b4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013bd:	90                   	nop
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8d 50 01             	lea    0x1(%eax),%edx
  8013c4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ca:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013cd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013d0:	8a 12                	mov    (%edx),%dl
  8013d2:	88 10                	mov    %dl,(%eax)
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	84 c0                	test   %al,%al
  8013d8:	75 e4                	jne    8013be <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013dd:	c9                   	leave  
  8013de:	c3                   	ret    

008013df <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
  8013e2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013f2:	eb 1f                	jmp    801413 <strncpy+0x34>
		*dst++ = *src;
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8d 50 01             	lea    0x1(%eax),%edx
  8013fa:	89 55 08             	mov    %edx,0x8(%ebp)
  8013fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801400:	8a 12                	mov    (%edx),%dl
  801402:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801404:	8b 45 0c             	mov    0xc(%ebp),%eax
  801407:	8a 00                	mov    (%eax),%al
  801409:	84 c0                	test   %al,%al
  80140b:	74 03                	je     801410 <strncpy+0x31>
			src++;
  80140d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801410:	ff 45 fc             	incl   -0x4(%ebp)
  801413:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801416:	3b 45 10             	cmp    0x10(%ebp),%eax
  801419:	72 d9                	jb     8013f4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80141b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80141e:	c9                   	leave  
  80141f:	c3                   	ret    

00801420 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
  801423:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80142c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801430:	74 30                	je     801462 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801432:	eb 16                	jmp    80144a <strlcpy+0x2a>
			*dst++ = *src++;
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8d 50 01             	lea    0x1(%eax),%edx
  80143a:	89 55 08             	mov    %edx,0x8(%ebp)
  80143d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801440:	8d 4a 01             	lea    0x1(%edx),%ecx
  801443:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801446:	8a 12                	mov    (%edx),%dl
  801448:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80144a:	ff 4d 10             	decl   0x10(%ebp)
  80144d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801451:	74 09                	je     80145c <strlcpy+0x3c>
  801453:	8b 45 0c             	mov    0xc(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	84 c0                	test   %al,%al
  80145a:	75 d8                	jne    801434 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801462:	8b 55 08             	mov    0x8(%ebp),%edx
  801465:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801468:	29 c2                	sub    %eax,%edx
  80146a:	89 d0                	mov    %edx,%eax
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801471:	eb 06                	jmp    801479 <strcmp+0xb>
		p++, q++;
  801473:	ff 45 08             	incl   0x8(%ebp)
  801476:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	74 0e                	je     801490 <strcmp+0x22>
  801482:	8b 45 08             	mov    0x8(%ebp),%eax
  801485:	8a 10                	mov    (%eax),%dl
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	8a 00                	mov    (%eax),%al
  80148c:	38 c2                	cmp    %al,%dl
  80148e:	74 e3                	je     801473 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	0f b6 d0             	movzbl %al,%edx
  801498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	0f b6 c0             	movzbl %al,%eax
  8014a0:	29 c2                	sub    %eax,%edx
  8014a2:	89 d0                	mov    %edx,%eax
}
  8014a4:	5d                   	pop    %ebp
  8014a5:	c3                   	ret    

008014a6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8014a9:	eb 09                	jmp    8014b4 <strncmp+0xe>
		n--, p++, q++;
  8014ab:	ff 4d 10             	decl   0x10(%ebp)
  8014ae:	ff 45 08             	incl   0x8(%ebp)
  8014b1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b8:	74 17                	je     8014d1 <strncmp+0x2b>
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	84 c0                	test   %al,%al
  8014c1:	74 0e                	je     8014d1 <strncmp+0x2b>
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	8a 10                	mov    (%eax),%dl
  8014c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cb:	8a 00                	mov    (%eax),%al
  8014cd:	38 c2                	cmp    %al,%dl
  8014cf:	74 da                	je     8014ab <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d5:	75 07                	jne    8014de <strncmp+0x38>
		return 0;
  8014d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8014dc:	eb 14                	jmp    8014f2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e1:	8a 00                	mov    (%eax),%al
  8014e3:	0f b6 d0             	movzbl %al,%edx
  8014e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e9:	8a 00                	mov    (%eax),%al
  8014eb:	0f b6 c0             	movzbl %al,%eax
  8014ee:	29 c2                	sub    %eax,%edx
  8014f0:	89 d0                	mov    %edx,%eax
}
  8014f2:	5d                   	pop    %ebp
  8014f3:	c3                   	ret    

008014f4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
  8014f7:	83 ec 04             	sub    $0x4,%esp
  8014fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801500:	eb 12                	jmp    801514 <strchr+0x20>
		if (*s == c)
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	8a 00                	mov    (%eax),%al
  801507:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80150a:	75 05                	jne    801511 <strchr+0x1d>
			return (char *) s;
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
  80150f:	eb 11                	jmp    801522 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801511:	ff 45 08             	incl   0x8(%ebp)
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	8a 00                	mov    (%eax),%al
  801519:	84 c0                	test   %al,%al
  80151b:	75 e5                	jne    801502 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80151d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	83 ec 04             	sub    $0x4,%esp
  80152a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801530:	eb 0d                	jmp    80153f <strfind+0x1b>
		if (*s == c)
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80153a:	74 0e                	je     80154a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80153c:	ff 45 08             	incl   0x8(%ebp)
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	84 c0                	test   %al,%al
  801546:	75 ea                	jne    801532 <strfind+0xe>
  801548:	eb 01                	jmp    80154b <strfind+0x27>
		if (*s == c)
			break;
  80154a:	90                   	nop
	return (char *) s;
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
  801553:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
  801559:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80155c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801560:	76 63                	jbe    8015c5 <memset+0x75>
		uint64 data_block = c;
  801562:	8b 45 0c             	mov    0xc(%ebp),%eax
  801565:	99                   	cltd   
  801566:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801569:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80156c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80156f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801572:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801576:	c1 e0 08             	shl    $0x8,%eax
  801579:	09 45 f0             	or     %eax,-0x10(%ebp)
  80157c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80157f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801582:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801585:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801589:	c1 e0 10             	shl    $0x10,%eax
  80158c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80158f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801592:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801595:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801598:	89 c2                	mov    %eax,%edx
  80159a:	b8 00 00 00 00       	mov    $0x0,%eax
  80159f:	09 45 f0             	or     %eax,-0x10(%ebp)
  8015a2:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8015a5:	eb 18                	jmp    8015bf <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8015a7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015aa:	8d 41 08             	lea    0x8(%ecx),%eax
  8015ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8015b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015b6:	89 01                	mov    %eax,(%ecx)
  8015b8:	89 51 04             	mov    %edx,0x4(%ecx)
  8015bb:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8015bf:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015c3:	77 e2                	ja     8015a7 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8015c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015c9:	74 23                	je     8015ee <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8015cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015d1:	eb 0e                	jmp    8015e1 <memset+0x91>
			*p8++ = (uint8)c;
  8015d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d6:	8d 50 01             	lea    0x1(%eax),%edx
  8015d9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015df:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8015e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ea:	85 c0                	test   %eax,%eax
  8015ec:	75 e5                	jne    8015d3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8015f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801605:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801609:	76 24                	jbe    80162f <memcpy+0x3c>
		while(n >= 8){
  80160b:	eb 1c                	jmp    801629 <memcpy+0x36>
			*d64 = *s64;
  80160d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801610:	8b 50 04             	mov    0x4(%eax),%edx
  801613:	8b 00                	mov    (%eax),%eax
  801615:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801618:	89 01                	mov    %eax,(%ecx)
  80161a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80161d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801621:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801625:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801629:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80162d:	77 de                	ja     80160d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80162f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801633:	74 31                	je     801666 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801635:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801638:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80163b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801641:	eb 16                	jmp    801659 <memcpy+0x66>
			*d8++ = *s8++;
  801643:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801646:	8d 50 01             	lea    0x1(%eax),%edx
  801649:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80164c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80164f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801652:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801655:	8a 12                	mov    (%edx),%dl
  801657:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801659:	8b 45 10             	mov    0x10(%ebp),%eax
  80165c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80165f:	89 55 10             	mov    %edx,0x10(%ebp)
  801662:	85 c0                	test   %eax,%eax
  801664:	75 dd                	jne    801643 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801666:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
  80166e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801671:	8b 45 0c             	mov    0xc(%ebp),%eax
  801674:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801683:	73 50                	jae    8016d5 <memmove+0x6a>
  801685:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801688:	8b 45 10             	mov    0x10(%ebp),%eax
  80168b:	01 d0                	add    %edx,%eax
  80168d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801690:	76 43                	jbe    8016d5 <memmove+0x6a>
		s += n;
  801692:	8b 45 10             	mov    0x10(%ebp),%eax
  801695:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801698:	8b 45 10             	mov    0x10(%ebp),%eax
  80169b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80169e:	eb 10                	jmp    8016b0 <memmove+0x45>
			*--d = *--s;
  8016a0:	ff 4d f8             	decl   -0x8(%ebp)
  8016a3:	ff 4d fc             	decl   -0x4(%ebp)
  8016a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a9:	8a 10                	mov    (%eax),%dl
  8016ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ae:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b9:	85 c0                	test   %eax,%eax
  8016bb:	75 e3                	jne    8016a0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016bd:	eb 23                	jmp    8016e2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c2:	8d 50 01             	lea    0x1(%eax),%edx
  8016c5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016cb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016d1:	8a 12                	mov    (%edx),%dl
  8016d3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016db:	89 55 10             	mov    %edx,0x10(%ebp)
  8016de:	85 c0                	test   %eax,%eax
  8016e0:	75 dd                	jne    8016bf <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f9:	eb 2a                	jmp    801725 <memcmp+0x3e>
		if (*s1 != *s2)
  8016fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fe:	8a 10                	mov    (%eax),%dl
  801700:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	38 c2                	cmp    %al,%dl
  801707:	74 16                	je     80171f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801709:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170c:	8a 00                	mov    (%eax),%al
  80170e:	0f b6 d0             	movzbl %al,%edx
  801711:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	0f b6 c0             	movzbl %al,%eax
  801719:	29 c2                	sub    %eax,%edx
  80171b:	89 d0                	mov    %edx,%eax
  80171d:	eb 18                	jmp    801737 <memcmp+0x50>
		s1++, s2++;
  80171f:	ff 45 fc             	incl   -0x4(%ebp)
  801722:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801725:	8b 45 10             	mov    0x10(%ebp),%eax
  801728:	8d 50 ff             	lea    -0x1(%eax),%edx
  80172b:	89 55 10             	mov    %edx,0x10(%ebp)
  80172e:	85 c0                	test   %eax,%eax
  801730:	75 c9                	jne    8016fb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801732:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
  80173c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80173f:	8b 55 08             	mov    0x8(%ebp),%edx
  801742:	8b 45 10             	mov    0x10(%ebp),%eax
  801745:	01 d0                	add    %edx,%eax
  801747:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80174a:	eb 15                	jmp    801761 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80174c:	8b 45 08             	mov    0x8(%ebp),%eax
  80174f:	8a 00                	mov    (%eax),%al
  801751:	0f b6 d0             	movzbl %al,%edx
  801754:	8b 45 0c             	mov    0xc(%ebp),%eax
  801757:	0f b6 c0             	movzbl %al,%eax
  80175a:	39 c2                	cmp    %eax,%edx
  80175c:	74 0d                	je     80176b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80175e:	ff 45 08             	incl   0x8(%ebp)
  801761:	8b 45 08             	mov    0x8(%ebp),%eax
  801764:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801767:	72 e3                	jb     80174c <memfind+0x13>
  801769:	eb 01                	jmp    80176c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80176b:	90                   	nop
	return (void *) s;
  80176c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801777:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80177e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801785:	eb 03                	jmp    80178a <strtol+0x19>
		s++;
  801787:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	8a 00                	mov    (%eax),%al
  80178f:	3c 20                	cmp    $0x20,%al
  801791:	74 f4                	je     801787 <strtol+0x16>
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	8a 00                	mov    (%eax),%al
  801798:	3c 09                	cmp    $0x9,%al
  80179a:	74 eb                	je     801787 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	8a 00                	mov    (%eax),%al
  8017a1:	3c 2b                	cmp    $0x2b,%al
  8017a3:	75 05                	jne    8017aa <strtol+0x39>
		s++;
  8017a5:	ff 45 08             	incl   0x8(%ebp)
  8017a8:	eb 13                	jmp    8017bd <strtol+0x4c>
	else if (*s == '-')
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	8a 00                	mov    (%eax),%al
  8017af:	3c 2d                	cmp    $0x2d,%al
  8017b1:	75 0a                	jne    8017bd <strtol+0x4c>
		s++, neg = 1;
  8017b3:	ff 45 08             	incl   0x8(%ebp)
  8017b6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c1:	74 06                	je     8017c9 <strtol+0x58>
  8017c3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c7:	75 20                	jne    8017e9 <strtol+0x78>
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	8a 00                	mov    (%eax),%al
  8017ce:	3c 30                	cmp    $0x30,%al
  8017d0:	75 17                	jne    8017e9 <strtol+0x78>
  8017d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d5:	40                   	inc    %eax
  8017d6:	8a 00                	mov    (%eax),%al
  8017d8:	3c 78                	cmp    $0x78,%al
  8017da:	75 0d                	jne    8017e9 <strtol+0x78>
		s += 2, base = 16;
  8017dc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017e0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e7:	eb 28                	jmp    801811 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ed:	75 15                	jne    801804 <strtol+0x93>
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f2:	8a 00                	mov    (%eax),%al
  8017f4:	3c 30                	cmp    $0x30,%al
  8017f6:	75 0c                	jne    801804 <strtol+0x93>
		s++, base = 8;
  8017f8:	ff 45 08             	incl   0x8(%ebp)
  8017fb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801802:	eb 0d                	jmp    801811 <strtol+0xa0>
	else if (base == 0)
  801804:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801808:	75 07                	jne    801811 <strtol+0xa0>
		base = 10;
  80180a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801811:	8b 45 08             	mov    0x8(%ebp),%eax
  801814:	8a 00                	mov    (%eax),%al
  801816:	3c 2f                	cmp    $0x2f,%al
  801818:	7e 19                	jle    801833 <strtol+0xc2>
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	3c 39                	cmp    $0x39,%al
  801821:	7f 10                	jg     801833 <strtol+0xc2>
			dig = *s - '0';
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	8a 00                	mov    (%eax),%al
  801828:	0f be c0             	movsbl %al,%eax
  80182b:	83 e8 30             	sub    $0x30,%eax
  80182e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801831:	eb 42                	jmp    801875 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	8a 00                	mov    (%eax),%al
  801838:	3c 60                	cmp    $0x60,%al
  80183a:	7e 19                	jle    801855 <strtol+0xe4>
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	8a 00                	mov    (%eax),%al
  801841:	3c 7a                	cmp    $0x7a,%al
  801843:	7f 10                	jg     801855 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	8a 00                	mov    (%eax),%al
  80184a:	0f be c0             	movsbl %al,%eax
  80184d:	83 e8 57             	sub    $0x57,%eax
  801850:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801853:	eb 20                	jmp    801875 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	8a 00                	mov    (%eax),%al
  80185a:	3c 40                	cmp    $0x40,%al
  80185c:	7e 39                	jle    801897 <strtol+0x126>
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	8a 00                	mov    (%eax),%al
  801863:	3c 5a                	cmp    $0x5a,%al
  801865:	7f 30                	jg     801897 <strtol+0x126>
			dig = *s - 'A' + 10;
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
  80186a:	8a 00                	mov    (%eax),%al
  80186c:	0f be c0             	movsbl %al,%eax
  80186f:	83 e8 37             	sub    $0x37,%eax
  801872:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801875:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801878:	3b 45 10             	cmp    0x10(%ebp),%eax
  80187b:	7d 19                	jge    801896 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80187d:	ff 45 08             	incl   0x8(%ebp)
  801880:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801883:	0f af 45 10          	imul   0x10(%ebp),%eax
  801887:	89 c2                	mov    %eax,%edx
  801889:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80188c:	01 d0                	add    %edx,%eax
  80188e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801891:	e9 7b ff ff ff       	jmp    801811 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801896:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801897:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80189b:	74 08                	je     8018a5 <strtol+0x134>
		*endptr = (char *) s;
  80189d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8018a3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a9:	74 07                	je     8018b2 <strtol+0x141>
  8018ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ae:	f7 d8                	neg    %eax
  8018b0:	eb 03                	jmp    8018b5 <strtol+0x144>
  8018b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018b5:	c9                   	leave  
  8018b6:	c3                   	ret    

008018b7 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b7:	55                   	push   %ebp
  8018b8:	89 e5                	mov    %esp,%ebp
  8018ba:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018c4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018cb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018cf:	79 13                	jns    8018e4 <ltostr+0x2d>
	{
		neg = 1;
  8018d1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018db:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018de:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018e1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018ec:	99                   	cltd   
  8018ed:	f7 f9                	idiv   %ecx
  8018ef:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f5:	8d 50 01             	lea    0x1(%eax),%edx
  8018f8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018fb:	89 c2                	mov    %eax,%edx
  8018fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801900:	01 d0                	add    %edx,%eax
  801902:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801905:	83 c2 30             	add    $0x30,%edx
  801908:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80190a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80190d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801912:	f7 e9                	imul   %ecx
  801914:	c1 fa 02             	sar    $0x2,%edx
  801917:	89 c8                	mov    %ecx,%eax
  801919:	c1 f8 1f             	sar    $0x1f,%eax
  80191c:	29 c2                	sub    %eax,%edx
  80191e:	89 d0                	mov    %edx,%eax
  801920:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801923:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801927:	75 bb                	jne    8018e4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801929:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801930:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801933:	48                   	dec    %eax
  801934:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801937:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80193b:	74 3d                	je     80197a <ltostr+0xc3>
		start = 1 ;
  80193d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801944:	eb 34                	jmp    80197a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801946:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801949:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194c:	01 d0                	add    %edx,%eax
  80194e:	8a 00                	mov    (%eax),%al
  801950:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801953:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801956:	8b 45 0c             	mov    0xc(%ebp),%eax
  801959:	01 c2                	add    %eax,%edx
  80195b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80195e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801961:	01 c8                	add    %ecx,%eax
  801963:	8a 00                	mov    (%eax),%al
  801965:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801967:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80196a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196d:	01 c2                	add    %eax,%edx
  80196f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801972:	88 02                	mov    %al,(%edx)
		start++ ;
  801974:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801977:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80197d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801980:	7c c4                	jl     801946 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801982:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801985:	8b 45 0c             	mov    0xc(%ebp),%eax
  801988:	01 d0                	add    %edx,%eax
  80198a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80198d:	90                   	nop
  80198e:	c9                   	leave  
  80198f:	c3                   	ret    

00801990 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801990:	55                   	push   %ebp
  801991:	89 e5                	mov    %esp,%ebp
  801993:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801996:	ff 75 08             	pushl  0x8(%ebp)
  801999:	e8 c4 f9 ff ff       	call   801362 <strlen>
  80199e:	83 c4 04             	add    $0x4,%esp
  8019a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019a4:	ff 75 0c             	pushl  0xc(%ebp)
  8019a7:	e8 b6 f9 ff ff       	call   801362 <strlen>
  8019ac:	83 c4 04             	add    $0x4,%esp
  8019af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019c0:	eb 17                	jmp    8019d9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019c8:	01 c2                	add    %eax,%edx
  8019ca:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	01 c8                	add    %ecx,%eax
  8019d2:	8a 00                	mov    (%eax),%al
  8019d4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019d6:	ff 45 fc             	incl   -0x4(%ebp)
  8019d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019df:	7c e1                	jl     8019c2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019ef:	eb 1f                	jmp    801a10 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f4:	8d 50 01             	lea    0x1(%eax),%edx
  8019f7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019fa:	89 c2                	mov    %eax,%edx
  8019fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ff:	01 c2                	add    %eax,%edx
  801a01:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a04:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a07:	01 c8                	add    %ecx,%eax
  801a09:	8a 00                	mov    (%eax),%al
  801a0b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a0d:	ff 45 f8             	incl   -0x8(%ebp)
  801a10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a13:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a16:	7c d9                	jl     8019f1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a18:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1e:	01 d0                	add    %edx,%eax
  801a20:	c6 00 00             	movb   $0x0,(%eax)
}
  801a23:	90                   	nop
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a29:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a32:	8b 45 14             	mov    0x14(%ebp),%eax
  801a35:	8b 00                	mov    (%eax),%eax
  801a37:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a41:	01 d0                	add    %edx,%eax
  801a43:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a49:	eb 0c                	jmp    801a57 <strsplit+0x31>
			*string++ = 0;
  801a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4e:	8d 50 01             	lea    0x1(%eax),%edx
  801a51:	89 55 08             	mov    %edx,0x8(%ebp)
  801a54:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a57:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5a:	8a 00                	mov    (%eax),%al
  801a5c:	84 c0                	test   %al,%al
  801a5e:	74 18                	je     801a78 <strsplit+0x52>
  801a60:	8b 45 08             	mov    0x8(%ebp),%eax
  801a63:	8a 00                	mov    (%eax),%al
  801a65:	0f be c0             	movsbl %al,%eax
  801a68:	50                   	push   %eax
  801a69:	ff 75 0c             	pushl  0xc(%ebp)
  801a6c:	e8 83 fa ff ff       	call   8014f4 <strchr>
  801a71:	83 c4 08             	add    $0x8,%esp
  801a74:	85 c0                	test   %eax,%eax
  801a76:	75 d3                	jne    801a4b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	84 c0                	test   %al,%al
  801a7f:	74 5a                	je     801adb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a81:	8b 45 14             	mov    0x14(%ebp),%eax
  801a84:	8b 00                	mov    (%eax),%eax
  801a86:	83 f8 0f             	cmp    $0xf,%eax
  801a89:	75 07                	jne    801a92 <strsplit+0x6c>
		{
			return 0;
  801a8b:	b8 00 00 00 00       	mov    $0x0,%eax
  801a90:	eb 66                	jmp    801af8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a92:	8b 45 14             	mov    0x14(%ebp),%eax
  801a95:	8b 00                	mov    (%eax),%eax
  801a97:	8d 48 01             	lea    0x1(%eax),%ecx
  801a9a:	8b 55 14             	mov    0x14(%ebp),%edx
  801a9d:	89 0a                	mov    %ecx,(%edx)
  801a9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aa6:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa9:	01 c2                	add    %eax,%edx
  801aab:	8b 45 08             	mov    0x8(%ebp),%eax
  801aae:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ab0:	eb 03                	jmp    801ab5 <strsplit+0x8f>
			string++;
  801ab2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab8:	8a 00                	mov    (%eax),%al
  801aba:	84 c0                	test   %al,%al
  801abc:	74 8b                	je     801a49 <strsplit+0x23>
  801abe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac1:	8a 00                	mov    (%eax),%al
  801ac3:	0f be c0             	movsbl %al,%eax
  801ac6:	50                   	push   %eax
  801ac7:	ff 75 0c             	pushl  0xc(%ebp)
  801aca:	e8 25 fa ff ff       	call   8014f4 <strchr>
  801acf:	83 c4 08             	add    $0x8,%esp
  801ad2:	85 c0                	test   %eax,%eax
  801ad4:	74 dc                	je     801ab2 <strsplit+0x8c>
			string++;
	}
  801ad6:	e9 6e ff ff ff       	jmp    801a49 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801adb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801adc:	8b 45 14             	mov    0x14(%ebp),%eax
  801adf:	8b 00                	mov    (%eax),%eax
  801ae1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae8:	8b 45 10             	mov    0x10(%ebp),%eax
  801aeb:	01 d0                	add    %edx,%eax
  801aed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801af3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
  801afd:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801b00:	8b 45 08             	mov    0x8(%ebp),%eax
  801b03:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801b06:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b0d:	eb 4a                	jmp    801b59 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801b0f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b12:	8b 45 08             	mov    0x8(%ebp),%eax
  801b15:	01 c2                	add    %eax,%edx
  801b17:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b1d:	01 c8                	add    %ecx,%eax
  801b1f:	8a 00                	mov    (%eax),%al
  801b21:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801b23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b29:	01 d0                	add    %edx,%eax
  801b2b:	8a 00                	mov    (%eax),%al
  801b2d:	3c 40                	cmp    $0x40,%al
  801b2f:	7e 25                	jle    801b56 <str2lower+0x5c>
  801b31:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b37:	01 d0                	add    %edx,%eax
  801b39:	8a 00                	mov    (%eax),%al
  801b3b:	3c 5a                	cmp    $0x5a,%al
  801b3d:	7f 17                	jg     801b56 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801b3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	01 d0                	add    %edx,%eax
  801b47:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b4a:	8b 55 08             	mov    0x8(%ebp),%edx
  801b4d:	01 ca                	add    %ecx,%edx
  801b4f:	8a 12                	mov    (%edx),%dl
  801b51:	83 c2 20             	add    $0x20,%edx
  801b54:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b56:	ff 45 fc             	incl   -0x4(%ebp)
  801b59:	ff 75 0c             	pushl  0xc(%ebp)
  801b5c:	e8 01 f8 ff ff       	call   801362 <strlen>
  801b61:	83 c4 04             	add    $0x4,%esp
  801b64:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b67:	7f a6                	jg     801b0f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b69:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b6c:	c9                   	leave  
  801b6d:	c3                   	ret    

00801b6e <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
  801b71:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801b74:	a1 08 40 80 00       	mov    0x804008,%eax
  801b79:	85 c0                	test   %eax,%eax
  801b7b:	74 2d                	je     801baa <uheap_init+0x3c>
	{
		buddy_init();
  801b7d:	e8 87 06 00 00       	call   802209 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801b82:	e8 31 05 00 00       	call   8020b8 <sys_get_uheap_strategy>
  801b87:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801b8c:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801b93:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801b96:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801b9d:	00 00 80 
		__firstTimeFlag = 0;
  801ba0:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801ba7:	00 00 00 
	}
}
  801baa:	90                   	nop
  801bab:	c9                   	leave  
  801bac:	c3                   	ret    

00801bad <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
  801bb0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801bb3:	83 ec 04             	sub    $0x4,%esp
  801bb6:	68 28 2e 80 00       	push   $0x802e28
  801bbb:	6a 25                	push   $0x25
  801bbd:	68 59 2e 80 00       	push   $0x802e59
  801bc2:	e8 f4 ed ff ff       	call   8009bb <_panic>

00801bc7 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
  801bca:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801bcd:	83 ec 04             	sub    $0x4,%esp
  801bd0:	68 68 2e 80 00       	push   $0x802e68
  801bd5:	6a 2f                	push   $0x2f
  801bd7:	68 59 2e 80 00       	push   $0x802e59
  801bdc:	e8 da ed ff ff       	call   8009bb <_panic>

00801be1 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801be1:	55                   	push   %ebp
  801be2:	89 e5                	mov    %esp,%ebp
  801be4:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801be7:	e8 82 ff ff ff       	call   801b6e <uheap_init>
	if (size == 0) return NULL ;
  801bec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801bf0:	75 07                	jne    801bf9 <malloc+0x18>
  801bf2:	b8 00 00 00 00       	mov    $0x0,%eax
  801bf7:	eb 14                	jmp    801c0d <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801bf9:	83 ec 04             	sub    $0x4,%esp
  801bfc:	68 9c 2e 80 00       	push   $0x802e9c
  801c01:	6a 43                	push   $0x43
  801c03:	68 59 2e 80 00       	push   $0x802e59
  801c08:	e8 ae ed ff ff       	call   8009bb <_panic>
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
  801c12:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801c15:	83 ec 04             	sub    $0x4,%esp
  801c18:	68 c4 2e 80 00       	push   $0x802ec4
  801c1d:	6a 4e                	push   $0x4e
  801c1f:	68 59 2e 80 00       	push   $0x802e59
  801c24:	e8 92 ed ff ff       	call   8009bb <_panic>

00801c29 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
  801c2c:	83 ec 18             	sub    $0x18,%esp
  801c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c32:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c35:	e8 34 ff ff ff       	call   801b6e <uheap_init>
	if (size == 0) return NULL ;
  801c3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c3e:	75 07                	jne    801c47 <smalloc+0x1e>
  801c40:	b8 00 00 00 00       	mov    $0x0,%eax
  801c45:	eb 14                	jmp    801c5b <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801c47:	83 ec 04             	sub    $0x4,%esp
  801c4a:	68 e8 2e 80 00       	push   $0x802ee8
  801c4f:	6a 5f                	push   $0x5f
  801c51:	68 59 2e 80 00       	push   $0x802e59
  801c56:	e8 60 ed ff ff       	call   8009bb <_panic>
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
  801c60:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c63:	e8 06 ff ff ff       	call   801b6e <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801c68:	83 ec 04             	sub    $0x4,%esp
  801c6b:	68 10 2f 80 00       	push   $0x802f10
  801c70:	6a 6f                	push   $0x6f
  801c72:	68 59 2e 80 00       	push   $0x802e59
  801c77:	e8 3f ed ff ff       	call   8009bb <_panic>

00801c7c <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801c7c:	55                   	push   %ebp
  801c7d:	89 e5                	mov    %esp,%ebp
  801c7f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801c82:	83 ec 04             	sub    $0x4,%esp
  801c85:	68 34 2f 80 00       	push   $0x802f34
  801c8a:	6a 7e                	push   $0x7e
  801c8c:	68 59 2e 80 00       	push   $0x802e59
  801c91:	e8 25 ed ff ff       	call   8009bb <_panic>

00801c96 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
  801c99:	57                   	push   %edi
  801c9a:	56                   	push   %esi
  801c9b:	53                   	push   %ebx
  801c9c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ca8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cab:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cae:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cb1:	cd 30                	int    $0x30
  801cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cb9:	83 c4 10             	add    $0x10,%esp
  801cbc:	5b                   	pop    %ebx
  801cbd:	5e                   	pop    %esi
  801cbe:	5f                   	pop    %edi
  801cbf:	5d                   	pop    %ebp
  801cc0:	c3                   	ret    

00801cc1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	8b 45 10             	mov    0x10(%ebp),%eax
  801cca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801ccd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cd0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd7:	6a 00                	push   $0x0
  801cd9:	51                   	push   %ecx
  801cda:	52                   	push   %edx
  801cdb:	ff 75 0c             	pushl  0xc(%ebp)
  801cde:	50                   	push   %eax
  801cdf:	6a 00                	push   $0x0
  801ce1:	e8 b0 ff ff ff       	call   801c96 <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
}
  801ce9:	90                   	nop
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <sys_cgetc>:

int
sys_cgetc(void)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 02                	push   $0x2
  801cfb:	e8 96 ff ff ff       	call   801c96 <syscall>
  801d00:	83 c4 18             	add    $0x18,%esp
}
  801d03:	c9                   	leave  
  801d04:	c3                   	ret    

00801d05 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801d05:	55                   	push   %ebp
  801d06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 03                	push   $0x3
  801d14:	e8 7d ff ff ff       	call   801c96 <syscall>
  801d19:	83 c4 18             	add    $0x18,%esp
}
  801d1c:	90                   	nop
  801d1d:	c9                   	leave  
  801d1e:	c3                   	ret    

00801d1f <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 04                	push   $0x4
  801d2e:	e8 63 ff ff ff       	call   801c96 <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
}
  801d36:	90                   	nop
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	52                   	push   %edx
  801d49:	50                   	push   %eax
  801d4a:	6a 08                	push   $0x8
  801d4c:	e8 45 ff ff ff       	call   801c96 <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
}
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
  801d59:	56                   	push   %esi
  801d5a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d5b:	8b 75 18             	mov    0x18(%ebp),%esi
  801d5e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d61:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d64:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d67:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6a:	56                   	push   %esi
  801d6b:	53                   	push   %ebx
  801d6c:	51                   	push   %ecx
  801d6d:	52                   	push   %edx
  801d6e:	50                   	push   %eax
  801d6f:	6a 09                	push   $0x9
  801d71:	e8 20 ff ff ff       	call   801c96 <syscall>
  801d76:	83 c4 18             	add    $0x18,%esp
}
  801d79:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d7c:	5b                   	pop    %ebx
  801d7d:	5e                   	pop    %esi
  801d7e:	5d                   	pop    %ebp
  801d7f:	c3                   	ret    

00801d80 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801d80:	55                   	push   %ebp
  801d81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	ff 75 08             	pushl  0x8(%ebp)
  801d8e:	6a 0a                	push   $0xa
  801d90:	e8 01 ff ff ff       	call   801c96 <syscall>
  801d95:	83 c4 18             	add    $0x18,%esp
}
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	ff 75 0c             	pushl  0xc(%ebp)
  801da6:	ff 75 08             	pushl  0x8(%ebp)
  801da9:	6a 0b                	push   $0xb
  801dab:	e8 e6 fe ff ff       	call   801c96 <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 0c                	push   $0xc
  801dc4:	e8 cd fe ff ff       	call   801c96 <syscall>
  801dc9:	83 c4 18             	add    $0x18,%esp
}
  801dcc:	c9                   	leave  
  801dcd:	c3                   	ret    

00801dce <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 0d                	push   $0xd
  801ddd:	e8 b4 fe ff ff       	call   801c96 <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 0e                	push   $0xe
  801df6:	e8 9b fe ff ff       	call   801c96 <syscall>
  801dfb:	83 c4 18             	add    $0x18,%esp
}
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 0f                	push   $0xf
  801e0f:	e8 82 fe ff ff       	call   801c96 <syscall>
  801e14:	83 c4 18             	add    $0x18,%esp
}
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	ff 75 08             	pushl  0x8(%ebp)
  801e27:	6a 10                	push   $0x10
  801e29:	e8 68 fe ff ff       	call   801c96 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 11                	push   $0x11
  801e42:	e8 4f fe ff ff       	call   801c96 <syscall>
  801e47:	83 c4 18             	add    $0x18,%esp
}
  801e4a:	90                   	nop
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_cputc>:

void
sys_cputc(const char c)
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
  801e50:	83 ec 04             	sub    $0x4,%esp
  801e53:	8b 45 08             	mov    0x8(%ebp),%eax
  801e56:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e59:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	50                   	push   %eax
  801e66:	6a 01                	push   $0x1
  801e68:	e8 29 fe ff ff       	call   801c96 <syscall>
  801e6d:	83 c4 18             	add    $0x18,%esp
}
  801e70:	90                   	nop
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 14                	push   $0x14
  801e82:	e8 0f fe ff ff       	call   801c96 <syscall>
  801e87:	83 c4 18             	add    $0x18,%esp
}
  801e8a:	90                   	nop
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
  801e90:	83 ec 04             	sub    $0x4,%esp
  801e93:	8b 45 10             	mov    0x10(%ebp),%eax
  801e96:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801e99:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e9c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea3:	6a 00                	push   $0x0
  801ea5:	51                   	push   %ecx
  801ea6:	52                   	push   %edx
  801ea7:	ff 75 0c             	pushl  0xc(%ebp)
  801eaa:	50                   	push   %eax
  801eab:	6a 15                	push   $0x15
  801ead:	e8 e4 fd ff ff       	call   801c96 <syscall>
  801eb2:	83 c4 18             	add    $0x18,%esp
}
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801eba:	8b 55 10             	mov    0x10(%ebp),%edx
  801ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	ff 75 08             	pushl  0x8(%ebp)
  801ec9:	6a 16                	push   $0x16
  801ecb:	e8 c6 fd ff ff       	call   801c96 <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
}
  801ed3:	c9                   	leave  
  801ed4:	c3                   	ret    

00801ed5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801ed5:	55                   	push   %ebp
  801ed6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	52                   	push   %edx
  801ee5:	50                   	push   %eax
  801ee6:	6a 17                	push   $0x17
  801ee8:	e8 a9 fd ff ff       	call   801c96 <syscall>
  801eed:	83 c4 18             	add    $0x18,%esp
}
  801ef0:	c9                   	leave  
  801ef1:	c3                   	ret    

00801ef2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801ef5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	52                   	push   %edx
  801f02:	50                   	push   %eax
  801f03:	6a 18                	push   $0x18
  801f05:	e8 8c fd ff ff       	call   801c96 <syscall>
  801f0a:	83 c4 18             	add    $0x18,%esp
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f12:	8b 45 08             	mov    0x8(%ebp),%eax
  801f15:	6a 00                	push   $0x0
  801f17:	ff 75 14             	pushl  0x14(%ebp)
  801f1a:	ff 75 10             	pushl  0x10(%ebp)
  801f1d:	ff 75 0c             	pushl  0xc(%ebp)
  801f20:	50                   	push   %eax
  801f21:	6a 19                	push   $0x19
  801f23:	e8 6e fd ff ff       	call   801c96 <syscall>
  801f28:	83 c4 18             	add    $0x18,%esp
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_run_env>:

void sys_run_env(int32 envId)
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f30:	8b 45 08             	mov    0x8(%ebp),%eax
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	50                   	push   %eax
  801f3c:	6a 1a                	push   $0x1a
  801f3e:	e8 53 fd ff ff       	call   801c96 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	90                   	nop
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	50                   	push   %eax
  801f58:	6a 1b                	push   $0x1b
  801f5a:	e8 37 fd ff ff       	call   801c96 <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
}
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 05                	push   $0x5
  801f73:	e8 1e fd ff ff       	call   801c96 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	c9                   	leave  
  801f7c:	c3                   	ret    

00801f7d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f7d:	55                   	push   %ebp
  801f7e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 06                	push   $0x6
  801f8c:	e8 05 fd ff ff       	call   801c96 <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
}
  801f94:	c9                   	leave  
  801f95:	c3                   	ret    

00801f96 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f96:	55                   	push   %ebp
  801f97:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 07                	push   $0x7
  801fa5:	e8 ec fc ff ff       	call   801c96 <syscall>
  801faa:	83 c4 18             	add    $0x18,%esp
}
  801fad:	c9                   	leave  
  801fae:	c3                   	ret    

00801faf <sys_exit_env>:


void sys_exit_env(void)
{
  801faf:	55                   	push   %ebp
  801fb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 1c                	push   $0x1c
  801fbe:	e8 d3 fc ff ff       	call   801c96 <syscall>
  801fc3:	83 c4 18             	add    $0x18,%esp
}
  801fc6:	90                   	nop
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	ff 75 10             	pushl  0x10(%ebp)
  801fd3:	ff 75 0c             	pushl  0xc(%ebp)
  801fd6:	ff 75 08             	pushl  0x8(%ebp)
  801fd9:	6a 13                	push   $0x13
  801fdb:	e8 b6 fc ff ff       	call   801c96 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe3:	90                   	nop
}
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 1e                	push   $0x1e
  801ff5:	e8 9c fc ff ff       	call   801c96 <syscall>
  801ffa:	83 c4 18             	add    $0x18,%esp
}
  801ffd:	c9                   	leave  
  801ffe:	c3                   	ret    

00801fff <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801fff:	55                   	push   %ebp
  802000:	89 e5                	mov    %esp,%ebp
  802002:	83 ec 04             	sub    $0x4,%esp
  802005:	8b 45 08             	mov    0x8(%ebp),%eax
  802008:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80200b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	50                   	push   %eax
  802018:	6a 1f                	push   $0x1f
  80201a:	e8 77 fc ff ff       	call   801c96 <syscall>
  80201f:	83 c4 18             	add    $0x18,%esp
	return ;
  802022:	90                   	nop
}
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <rsttst>:
void rsttst()
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 21                	push   $0x21
  802034:	e8 5d fc ff ff       	call   801c96 <syscall>
  802039:	83 c4 18             	add    $0x18,%esp
	return ;
  80203c:	90                   	nop
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
  802042:	83 ec 04             	sub    $0x4,%esp
  802045:	8b 45 14             	mov    0x14(%ebp),%eax
  802048:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80204b:	8b 55 18             	mov    0x18(%ebp),%edx
  80204e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802052:	52                   	push   %edx
  802053:	50                   	push   %eax
  802054:	ff 75 10             	pushl  0x10(%ebp)
  802057:	ff 75 0c             	pushl  0xc(%ebp)
  80205a:	ff 75 08             	pushl  0x8(%ebp)
  80205d:	6a 20                	push   $0x20
  80205f:	e8 32 fc ff ff       	call   801c96 <syscall>
  802064:	83 c4 18             	add    $0x18,%esp
	return ;
  802067:	90                   	nop
}
  802068:	c9                   	leave  
  802069:	c3                   	ret    

0080206a <chktst>:
void chktst(uint32 n)
{
  80206a:	55                   	push   %ebp
  80206b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	ff 75 08             	pushl  0x8(%ebp)
  802078:	6a 22                	push   $0x22
  80207a:	e8 17 fc ff ff       	call   801c96 <syscall>
  80207f:	83 c4 18             	add    $0x18,%esp
	return ;
  802082:	90                   	nop
}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <inctst>:

void inctst()
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 23                	push   $0x23
  802094:	e8 fd fb ff ff       	call   801c96 <syscall>
  802099:	83 c4 18             	add    $0x18,%esp
	return ;
  80209c:	90                   	nop
}
  80209d:	c9                   	leave  
  80209e:	c3                   	ret    

0080209f <gettst>:
uint32 gettst()
{
  80209f:	55                   	push   %ebp
  8020a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 24                	push   $0x24
  8020ae:	e8 e3 fb ff ff       	call   801c96 <syscall>
  8020b3:	83 c4 18             	add    $0x18,%esp
}
  8020b6:	c9                   	leave  
  8020b7:	c3                   	ret    

008020b8 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8020b8:	55                   	push   %ebp
  8020b9:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 25                	push   $0x25
  8020c7:	e8 ca fb ff ff       	call   801c96 <syscall>
  8020cc:	83 c4 18             	add    $0x18,%esp
  8020cf:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8020d4:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8020de:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e1:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	ff 75 08             	pushl  0x8(%ebp)
  8020f1:	6a 26                	push   $0x26
  8020f3:	e8 9e fb ff ff       	call   801c96 <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020fb:	90                   	nop
}
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
  802101:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802102:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802105:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802108:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210b:	8b 45 08             	mov    0x8(%ebp),%eax
  80210e:	6a 00                	push   $0x0
  802110:	53                   	push   %ebx
  802111:	51                   	push   %ecx
  802112:	52                   	push   %edx
  802113:	50                   	push   %eax
  802114:	6a 27                	push   $0x27
  802116:	e8 7b fb ff ff       	call   801c96 <syscall>
  80211b:	83 c4 18             	add    $0x18,%esp
}
  80211e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802121:	c9                   	leave  
  802122:	c3                   	ret    

00802123 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802123:	55                   	push   %ebp
  802124:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802126:	8b 55 0c             	mov    0xc(%ebp),%edx
  802129:	8b 45 08             	mov    0x8(%ebp),%eax
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	52                   	push   %edx
  802133:	50                   	push   %eax
  802134:	6a 28                	push   $0x28
  802136:	e8 5b fb ff ff       	call   801c96 <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
}
  80213e:	c9                   	leave  
  80213f:	c3                   	ret    

00802140 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802140:	55                   	push   %ebp
  802141:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802143:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802146:	8b 55 0c             	mov    0xc(%ebp),%edx
  802149:	8b 45 08             	mov    0x8(%ebp),%eax
  80214c:	6a 00                	push   $0x0
  80214e:	51                   	push   %ecx
  80214f:	ff 75 10             	pushl  0x10(%ebp)
  802152:	52                   	push   %edx
  802153:	50                   	push   %eax
  802154:	6a 29                	push   $0x29
  802156:	e8 3b fb ff ff       	call   801c96 <syscall>
  80215b:	83 c4 18             	add    $0x18,%esp
}
  80215e:	c9                   	leave  
  80215f:	c3                   	ret    

00802160 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802160:	55                   	push   %ebp
  802161:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	ff 75 10             	pushl  0x10(%ebp)
  80216a:	ff 75 0c             	pushl  0xc(%ebp)
  80216d:	ff 75 08             	pushl  0x8(%ebp)
  802170:	6a 12                	push   $0x12
  802172:	e8 1f fb ff ff       	call   801c96 <syscall>
  802177:	83 c4 18             	add    $0x18,%esp
	return ;
  80217a:	90                   	nop
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802180:	8b 55 0c             	mov    0xc(%ebp),%edx
  802183:	8b 45 08             	mov    0x8(%ebp),%eax
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	52                   	push   %edx
  80218d:	50                   	push   %eax
  80218e:	6a 2a                	push   $0x2a
  802190:	e8 01 fb ff ff       	call   801c96 <syscall>
  802195:	83 c4 18             	add    $0x18,%esp
	return;
  802198:	90                   	nop
}
  802199:	c9                   	leave  
  80219a:	c3                   	ret    

0080219b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80219b:	55                   	push   %ebp
  80219c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 2b                	push   $0x2b
  8021aa:	e8 e7 fa ff ff       	call   801c96 <syscall>
  8021af:	83 c4 18             	add    $0x18,%esp
}
  8021b2:	c9                   	leave  
  8021b3:	c3                   	ret    

008021b4 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8021b4:	55                   	push   %ebp
  8021b5:	89 e5                	mov    %esp,%ebp
  8021b7:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8021ba:	83 ec 04             	sub    $0x4,%esp
  8021bd:	68 58 2f 80 00       	push   $0x802f58
  8021c2:	68 0a 01 00 00       	push   $0x10a
  8021c7:	68 68 2f 80 00       	push   $0x802f68
  8021cc:	e8 ea e7 ff ff       	call   8009bb <_panic>

008021d1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8021d1:	55                   	push   %ebp
  8021d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	ff 75 0c             	pushl  0xc(%ebp)
  8021dd:	ff 75 08             	pushl  0x8(%ebp)
  8021e0:	6a 33                	push   $0x33
  8021e2:	e8 af fa ff ff       	call   801c96 <syscall>
  8021e7:	83 c4 18             	add    $0x18,%esp
	return;
  8021ea:	90                   	nop
}
  8021eb:	c9                   	leave  
  8021ec:	c3                   	ret    

008021ed <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8021ed:	55                   	push   %ebp
  8021ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	ff 75 0c             	pushl  0xc(%ebp)
  8021f9:	ff 75 08             	pushl  0x8(%ebp)
  8021fc:	6a 34                	push   $0x34
  8021fe:	e8 93 fa ff ff       	call   801c96 <syscall>
  802203:	83 c4 18             	add    $0x18,%esp
	return ;
  802206:	90                   	nop
}
  802207:	c9                   	leave  
  802208:	c3                   	ret    

00802209 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802209:	55                   	push   %ebp
  80220a:	89 e5                	mov    %esp,%ebp
  80220c:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80220f:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  802216:	eb 36                	jmp    80224e <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  802218:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80221b:	c1 e0 04             	shl    $0x4,%eax
  80221e:	05 60 40 80 00       	add    $0x804060,%eax
  802223:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802229:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80222c:	c1 e0 04             	shl    $0x4,%eax
  80222f:	05 64 40 80 00       	add    $0x804064,%eax
  802234:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80223a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80223d:	c1 e0 04             	shl    $0x4,%eax
  802240:	05 6c 40 80 00       	add    $0x80406c,%eax
  802245:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80224b:	ff 45 fc             	incl   -0x4(%ebp)
  80224e:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802252:	7e c4                	jle    802218 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802254:	90                   	nop
  802255:	c9                   	leave  
  802256:	c3                   	ret    

00802257 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802257:	55                   	push   %ebp
  802258:	89 e5                	mov    %esp,%ebp
  80225a:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80225d:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802264:	eb 24                	jmp    80228a <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802266:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802269:	c1 e0 04             	shl    $0x4,%eax
  80226c:	05 6c 40 80 00       	add    $0x80406c,%eax
  802271:	8b 00                	mov    (%eax),%eax
  802273:	83 ec 04             	sub    $0x4,%esp
  802276:	50                   	push   %eax
  802277:	ff 75 f4             	pushl  -0xc(%ebp)
  80227a:	68 78 2f 80 00       	push   $0x802f78
  80227f:	e8 05 ea ff ff       	call   800c89 <cprintf>
  802284:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802287:	ff 45 f4             	incl   -0xc(%ebp)
  80228a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80228e:	7e d6                	jle    802266 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802290:	90                   	nop
  802291:	c9                   	leave  
  802292:	c3                   	ret    

00802293 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802293:	55                   	push   %ebp
  802294:	89 e5                	mov    %esp,%ebp
  802296:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802299:	83 ec 04             	sub    $0x4,%esp
  80229c:	68 88 2f 80 00       	push   $0x802f88
  8022a1:	6a 33                	push   $0x33
  8022a3:	68 a9 2f 80 00       	push   $0x802fa9
  8022a8:	e8 0e e7 ff ff       	call   8009bb <_panic>

008022ad <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  8022ad:	55                   	push   %ebp
  8022ae:	89 e5                	mov    %esp,%ebp
  8022b0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  8022b3:	83 ec 04             	sub    $0x4,%esp
  8022b6:	68 c1 2f 80 00       	push   $0x802fc1
  8022bb:	6a 3e                	push   $0x3e
  8022bd:	68 a9 2f 80 00       	push   $0x802fa9
  8022c2:	e8 f4 e6 ff ff       	call   8009bb <_panic>

008022c7 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8022c7:	55                   	push   %ebp
  8022c8:	89 e5                	mov    %esp,%ebp
  8022ca:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8022cd:	83 ec 04             	sub    $0x4,%esp
  8022d0:	68 df 2f 80 00       	push   $0x802fdf
  8022d5:	6a 49                	push   $0x49
  8022d7:	68 a9 2f 80 00       	push   $0x802fa9
  8022dc:	e8 da e6 ff ff       	call   8009bb <_panic>

008022e1 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8022e1:	55                   	push   %ebp
  8022e2:	89 e5                	mov    %esp,%ebp
  8022e4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8022e7:	83 ec 04             	sub    $0x4,%esp
  8022ea:	68 fc 2f 80 00       	push   $0x802ffc
  8022ef:	6a 58                	push   $0x58
  8022f1:	68 a9 2f 80 00       	push   $0x802fa9
  8022f6:	e8 c0 e6 ff ff       	call   8009bb <_panic>
  8022fb:	90                   	nop

008022fc <__udivdi3>:
  8022fc:	55                   	push   %ebp
  8022fd:	57                   	push   %edi
  8022fe:	56                   	push   %esi
  8022ff:	53                   	push   %ebx
  802300:	83 ec 1c             	sub    $0x1c,%esp
  802303:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802307:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80230b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80230f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802313:	89 ca                	mov    %ecx,%edx
  802315:	89 f8                	mov    %edi,%eax
  802317:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80231b:	85 f6                	test   %esi,%esi
  80231d:	75 2d                	jne    80234c <__udivdi3+0x50>
  80231f:	39 cf                	cmp    %ecx,%edi
  802321:	77 65                	ja     802388 <__udivdi3+0x8c>
  802323:	89 fd                	mov    %edi,%ebp
  802325:	85 ff                	test   %edi,%edi
  802327:	75 0b                	jne    802334 <__udivdi3+0x38>
  802329:	b8 01 00 00 00       	mov    $0x1,%eax
  80232e:	31 d2                	xor    %edx,%edx
  802330:	f7 f7                	div    %edi
  802332:	89 c5                	mov    %eax,%ebp
  802334:	31 d2                	xor    %edx,%edx
  802336:	89 c8                	mov    %ecx,%eax
  802338:	f7 f5                	div    %ebp
  80233a:	89 c1                	mov    %eax,%ecx
  80233c:	89 d8                	mov    %ebx,%eax
  80233e:	f7 f5                	div    %ebp
  802340:	89 cf                	mov    %ecx,%edi
  802342:	89 fa                	mov    %edi,%edx
  802344:	83 c4 1c             	add    $0x1c,%esp
  802347:	5b                   	pop    %ebx
  802348:	5e                   	pop    %esi
  802349:	5f                   	pop    %edi
  80234a:	5d                   	pop    %ebp
  80234b:	c3                   	ret    
  80234c:	39 ce                	cmp    %ecx,%esi
  80234e:	77 28                	ja     802378 <__udivdi3+0x7c>
  802350:	0f bd fe             	bsr    %esi,%edi
  802353:	83 f7 1f             	xor    $0x1f,%edi
  802356:	75 40                	jne    802398 <__udivdi3+0x9c>
  802358:	39 ce                	cmp    %ecx,%esi
  80235a:	72 0a                	jb     802366 <__udivdi3+0x6a>
  80235c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802360:	0f 87 9e 00 00 00    	ja     802404 <__udivdi3+0x108>
  802366:	b8 01 00 00 00       	mov    $0x1,%eax
  80236b:	89 fa                	mov    %edi,%edx
  80236d:	83 c4 1c             	add    $0x1c,%esp
  802370:	5b                   	pop    %ebx
  802371:	5e                   	pop    %esi
  802372:	5f                   	pop    %edi
  802373:	5d                   	pop    %ebp
  802374:	c3                   	ret    
  802375:	8d 76 00             	lea    0x0(%esi),%esi
  802378:	31 ff                	xor    %edi,%edi
  80237a:	31 c0                	xor    %eax,%eax
  80237c:	89 fa                	mov    %edi,%edx
  80237e:	83 c4 1c             	add    $0x1c,%esp
  802381:	5b                   	pop    %ebx
  802382:	5e                   	pop    %esi
  802383:	5f                   	pop    %edi
  802384:	5d                   	pop    %ebp
  802385:	c3                   	ret    
  802386:	66 90                	xchg   %ax,%ax
  802388:	89 d8                	mov    %ebx,%eax
  80238a:	f7 f7                	div    %edi
  80238c:	31 ff                	xor    %edi,%edi
  80238e:	89 fa                	mov    %edi,%edx
  802390:	83 c4 1c             	add    $0x1c,%esp
  802393:	5b                   	pop    %ebx
  802394:	5e                   	pop    %esi
  802395:	5f                   	pop    %edi
  802396:	5d                   	pop    %ebp
  802397:	c3                   	ret    
  802398:	bd 20 00 00 00       	mov    $0x20,%ebp
  80239d:	89 eb                	mov    %ebp,%ebx
  80239f:	29 fb                	sub    %edi,%ebx
  8023a1:	89 f9                	mov    %edi,%ecx
  8023a3:	d3 e6                	shl    %cl,%esi
  8023a5:	89 c5                	mov    %eax,%ebp
  8023a7:	88 d9                	mov    %bl,%cl
  8023a9:	d3 ed                	shr    %cl,%ebp
  8023ab:	89 e9                	mov    %ebp,%ecx
  8023ad:	09 f1                	or     %esi,%ecx
  8023af:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023b3:	89 f9                	mov    %edi,%ecx
  8023b5:	d3 e0                	shl    %cl,%eax
  8023b7:	89 c5                	mov    %eax,%ebp
  8023b9:	89 d6                	mov    %edx,%esi
  8023bb:	88 d9                	mov    %bl,%cl
  8023bd:	d3 ee                	shr    %cl,%esi
  8023bf:	89 f9                	mov    %edi,%ecx
  8023c1:	d3 e2                	shl    %cl,%edx
  8023c3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023c7:	88 d9                	mov    %bl,%cl
  8023c9:	d3 e8                	shr    %cl,%eax
  8023cb:	09 c2                	or     %eax,%edx
  8023cd:	89 d0                	mov    %edx,%eax
  8023cf:	89 f2                	mov    %esi,%edx
  8023d1:	f7 74 24 0c          	divl   0xc(%esp)
  8023d5:	89 d6                	mov    %edx,%esi
  8023d7:	89 c3                	mov    %eax,%ebx
  8023d9:	f7 e5                	mul    %ebp
  8023db:	39 d6                	cmp    %edx,%esi
  8023dd:	72 19                	jb     8023f8 <__udivdi3+0xfc>
  8023df:	74 0b                	je     8023ec <__udivdi3+0xf0>
  8023e1:	89 d8                	mov    %ebx,%eax
  8023e3:	31 ff                	xor    %edi,%edi
  8023e5:	e9 58 ff ff ff       	jmp    802342 <__udivdi3+0x46>
  8023ea:	66 90                	xchg   %ax,%ax
  8023ec:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023f0:	89 f9                	mov    %edi,%ecx
  8023f2:	d3 e2                	shl    %cl,%edx
  8023f4:	39 c2                	cmp    %eax,%edx
  8023f6:	73 e9                	jae    8023e1 <__udivdi3+0xe5>
  8023f8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023fb:	31 ff                	xor    %edi,%edi
  8023fd:	e9 40 ff ff ff       	jmp    802342 <__udivdi3+0x46>
  802402:	66 90                	xchg   %ax,%ax
  802404:	31 c0                	xor    %eax,%eax
  802406:	e9 37 ff ff ff       	jmp    802342 <__udivdi3+0x46>
  80240b:	90                   	nop

0080240c <__umoddi3>:
  80240c:	55                   	push   %ebp
  80240d:	57                   	push   %edi
  80240e:	56                   	push   %esi
  80240f:	53                   	push   %ebx
  802410:	83 ec 1c             	sub    $0x1c,%esp
  802413:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802417:	8b 74 24 34          	mov    0x34(%esp),%esi
  80241b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80241f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802423:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802427:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80242b:	89 f3                	mov    %esi,%ebx
  80242d:	89 fa                	mov    %edi,%edx
  80242f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802433:	89 34 24             	mov    %esi,(%esp)
  802436:	85 c0                	test   %eax,%eax
  802438:	75 1a                	jne    802454 <__umoddi3+0x48>
  80243a:	39 f7                	cmp    %esi,%edi
  80243c:	0f 86 a2 00 00 00    	jbe    8024e4 <__umoddi3+0xd8>
  802442:	89 c8                	mov    %ecx,%eax
  802444:	89 f2                	mov    %esi,%edx
  802446:	f7 f7                	div    %edi
  802448:	89 d0                	mov    %edx,%eax
  80244a:	31 d2                	xor    %edx,%edx
  80244c:	83 c4 1c             	add    $0x1c,%esp
  80244f:	5b                   	pop    %ebx
  802450:	5e                   	pop    %esi
  802451:	5f                   	pop    %edi
  802452:	5d                   	pop    %ebp
  802453:	c3                   	ret    
  802454:	39 f0                	cmp    %esi,%eax
  802456:	0f 87 ac 00 00 00    	ja     802508 <__umoddi3+0xfc>
  80245c:	0f bd e8             	bsr    %eax,%ebp
  80245f:	83 f5 1f             	xor    $0x1f,%ebp
  802462:	0f 84 ac 00 00 00    	je     802514 <__umoddi3+0x108>
  802468:	bf 20 00 00 00       	mov    $0x20,%edi
  80246d:	29 ef                	sub    %ebp,%edi
  80246f:	89 fe                	mov    %edi,%esi
  802471:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802475:	89 e9                	mov    %ebp,%ecx
  802477:	d3 e0                	shl    %cl,%eax
  802479:	89 d7                	mov    %edx,%edi
  80247b:	89 f1                	mov    %esi,%ecx
  80247d:	d3 ef                	shr    %cl,%edi
  80247f:	09 c7                	or     %eax,%edi
  802481:	89 e9                	mov    %ebp,%ecx
  802483:	d3 e2                	shl    %cl,%edx
  802485:	89 14 24             	mov    %edx,(%esp)
  802488:	89 d8                	mov    %ebx,%eax
  80248a:	d3 e0                	shl    %cl,%eax
  80248c:	89 c2                	mov    %eax,%edx
  80248e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802492:	d3 e0                	shl    %cl,%eax
  802494:	89 44 24 04          	mov    %eax,0x4(%esp)
  802498:	8b 44 24 08          	mov    0x8(%esp),%eax
  80249c:	89 f1                	mov    %esi,%ecx
  80249e:	d3 e8                	shr    %cl,%eax
  8024a0:	09 d0                	or     %edx,%eax
  8024a2:	d3 eb                	shr    %cl,%ebx
  8024a4:	89 da                	mov    %ebx,%edx
  8024a6:	f7 f7                	div    %edi
  8024a8:	89 d3                	mov    %edx,%ebx
  8024aa:	f7 24 24             	mull   (%esp)
  8024ad:	89 c6                	mov    %eax,%esi
  8024af:	89 d1                	mov    %edx,%ecx
  8024b1:	39 d3                	cmp    %edx,%ebx
  8024b3:	0f 82 87 00 00 00    	jb     802540 <__umoddi3+0x134>
  8024b9:	0f 84 91 00 00 00    	je     802550 <__umoddi3+0x144>
  8024bf:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024c3:	29 f2                	sub    %esi,%edx
  8024c5:	19 cb                	sbb    %ecx,%ebx
  8024c7:	89 d8                	mov    %ebx,%eax
  8024c9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024cd:	d3 e0                	shl    %cl,%eax
  8024cf:	89 e9                	mov    %ebp,%ecx
  8024d1:	d3 ea                	shr    %cl,%edx
  8024d3:	09 d0                	or     %edx,%eax
  8024d5:	89 e9                	mov    %ebp,%ecx
  8024d7:	d3 eb                	shr    %cl,%ebx
  8024d9:	89 da                	mov    %ebx,%edx
  8024db:	83 c4 1c             	add    $0x1c,%esp
  8024de:	5b                   	pop    %ebx
  8024df:	5e                   	pop    %esi
  8024e0:	5f                   	pop    %edi
  8024e1:	5d                   	pop    %ebp
  8024e2:	c3                   	ret    
  8024e3:	90                   	nop
  8024e4:	89 fd                	mov    %edi,%ebp
  8024e6:	85 ff                	test   %edi,%edi
  8024e8:	75 0b                	jne    8024f5 <__umoddi3+0xe9>
  8024ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ef:	31 d2                	xor    %edx,%edx
  8024f1:	f7 f7                	div    %edi
  8024f3:	89 c5                	mov    %eax,%ebp
  8024f5:	89 f0                	mov    %esi,%eax
  8024f7:	31 d2                	xor    %edx,%edx
  8024f9:	f7 f5                	div    %ebp
  8024fb:	89 c8                	mov    %ecx,%eax
  8024fd:	f7 f5                	div    %ebp
  8024ff:	89 d0                	mov    %edx,%eax
  802501:	e9 44 ff ff ff       	jmp    80244a <__umoddi3+0x3e>
  802506:	66 90                	xchg   %ax,%ax
  802508:	89 c8                	mov    %ecx,%eax
  80250a:	89 f2                	mov    %esi,%edx
  80250c:	83 c4 1c             	add    $0x1c,%esp
  80250f:	5b                   	pop    %ebx
  802510:	5e                   	pop    %esi
  802511:	5f                   	pop    %edi
  802512:	5d                   	pop    %ebp
  802513:	c3                   	ret    
  802514:	3b 04 24             	cmp    (%esp),%eax
  802517:	72 06                	jb     80251f <__umoddi3+0x113>
  802519:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80251d:	77 0f                	ja     80252e <__umoddi3+0x122>
  80251f:	89 f2                	mov    %esi,%edx
  802521:	29 f9                	sub    %edi,%ecx
  802523:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802527:	89 14 24             	mov    %edx,(%esp)
  80252a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80252e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802532:	8b 14 24             	mov    (%esp),%edx
  802535:	83 c4 1c             	add    $0x1c,%esp
  802538:	5b                   	pop    %ebx
  802539:	5e                   	pop    %esi
  80253a:	5f                   	pop    %edi
  80253b:	5d                   	pop    %ebp
  80253c:	c3                   	ret    
  80253d:	8d 76 00             	lea    0x0(%esi),%esi
  802540:	2b 04 24             	sub    (%esp),%eax
  802543:	19 fa                	sbb    %edi,%edx
  802545:	89 d1                	mov    %edx,%ecx
  802547:	89 c6                	mov    %eax,%esi
  802549:	e9 71 ff ff ff       	jmp    8024bf <__umoddi3+0xb3>
  80254e:	66 90                	xchg   %ax,%ax
  802550:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802554:	72 ea                	jb     802540 <__umoddi3+0x134>
  802556:	89 d9                	mov    %ebx,%ecx
  802558:	e9 62 ff ff ff       	jmp    8024bf <__umoddi3+0xb3>
