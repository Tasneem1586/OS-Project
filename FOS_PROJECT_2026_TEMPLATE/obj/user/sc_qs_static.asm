
obj/user/sc_qs_static:     file format elf32-i386


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
  800031:	e8 95 05 00 00       	call   8005cb <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
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
		int NumOfElements = 100000 ;
  800041:	c7 45 f4 a0 86 01 00 	movl   $0x186a0,-0xc(%ebp)
		//2012: lock the interrupt
		sys_lock_cons();
  800048:	e8 00 1a 00 00       	call   801a4d <sys_lock_cons>
		{
			cprintf("\n");
  80004d:	83 ec 0c             	sub    $0xc,%esp
  800050:	68 c0 21 80 00       	push   $0x8021c0
  800055:	e8 9f 0a 00 00       	call   800af9 <cprintf>
  80005a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  80005d:	83 ec 0c             	sub    $0xc,%esp
  800060:	68 c2 21 80 00       	push   $0x8021c2
  800065:	e8 8f 0a 00 00       	call   800af9 <cprintf>
  80006a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   QUICK SORT    !!!\n");
  80006d:	83 ec 0c             	sub    $0xc,%esp
  800070:	68 db 21 80 00       	push   $0x8021db
  800075:	e8 7f 0a 00 00       	call   800af9 <cprintf>
  80007a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  80007d:	83 ec 0c             	sub    $0xc,%esp
  800080:	68 c2 21 80 00       	push   $0x8021c2
  800085:	e8 6f 0a 00 00       	call   800af9 <cprintf>
  80008a:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  80008d:	83 ec 0c             	sub    $0xc,%esp
  800090:	68 c0 21 80 00       	push   $0x8021c0
  800095:	e8 5f 0a 00 00       	call   800af9 <cprintf>
  80009a:	83 c4 10             	add    $0x10,%esp

			cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  80009d:	83 ec 08             	sub    $0x8,%esp
  8000a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8000a3:	68 f4 21 80 00       	push   $0x8021f4
  8000a8:	e8 4c 0a 00 00       	call   800af9 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp
			cprintf("Chose the initialization method:\n") ;
  8000b0:	83 ec 0c             	sub    $0xc,%esp
  8000b3:	68 18 22 80 00       	push   $0x802218
  8000b8:	e8 3c 0a 00 00       	call   800af9 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	68 3a 22 80 00       	push   $0x80223a
  8000c8:	e8 2c 0a 00 00       	call   800af9 <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 48 22 80 00       	push   $0x802248
  8000d8:	e8 1c 0a 00 00       	call   800af9 <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	68 57 22 80 00       	push   $0x802257
  8000e8:	e8 0c 0a 00 00       	call   800af9 <cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000f0:	83 ec 0c             	sub    $0xc,%esp
  8000f3:	68 67 22 80 00       	push   $0x802267
  8000f8:	e8 fc 09 00 00       	call   800af9 <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
				Chose = 'c' ;
  800100:	c6 45 f3 63          	movb   $0x63,-0xd(%ebp)
				cputchar(Chose);
  800104:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 78 04 00 00       	call   800589 <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 6b 04 00 00       	call   800589 <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800121:	80 7d f3 61          	cmpb   $0x61,-0xd(%ebp)
  800125:	74 0c                	je     800133 <_main+0xfb>
  800127:	80 7d f3 62          	cmpb   $0x62,-0xd(%ebp)
  80012b:	74 06                	je     800133 <_main+0xfb>
  80012d:	80 7d f3 63          	cmpb   $0x63,-0xd(%ebp)
  800131:	75 bd                	jne    8000f0 <_main+0xb8>

		}
		sys_unlock_cons();
  800133:	e8 2f 19 00 00       	call   801a67 <sys_unlock_cons>

		//int *Elements = malloc(sizeof(int) * NumOfElements) ;
		int *Elements = __Elements;
  800138:	c7 45 ec 40 31 80 00 	movl   $0x803140,-0x14(%ebp)

		int  i ;
		switch (Chose)
  80013f:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  800143:	83 f8 62             	cmp    $0x62,%eax
  800146:	74 1d                	je     800165 <_main+0x12d>
  800148:	83 f8 63             	cmp    $0x63,%eax
  80014b:	74 2b                	je     800178 <_main+0x140>
  80014d:	83 f8 61             	cmp    $0x61,%eax
  800150:	75 39                	jne    80018b <_main+0x153>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800152:	83 ec 08             	sub    $0x8,%esp
  800155:	ff 75 f4             	pushl  -0xc(%ebp)
  800158:	ff 75 ec             	pushl  -0x14(%ebp)
  80015b:	e8 e4 02 00 00       	call   800444 <InitializeAscending>
  800160:	83 c4 10             	add    $0x10,%esp
			break ;
  800163:	eb 37                	jmp    80019c <_main+0x164>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800165:	83 ec 08             	sub    $0x8,%esp
  800168:	ff 75 f4             	pushl  -0xc(%ebp)
  80016b:	ff 75 ec             	pushl  -0x14(%ebp)
  80016e:	e8 02 03 00 00       	call   800475 <InitializeIdentical>
  800173:	83 c4 10             	add    $0x10,%esp
			break ;
  800176:	eb 24                	jmp    80019c <_main+0x164>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	ff 75 f4             	pushl  -0xc(%ebp)
  80017e:	ff 75 ec             	pushl  -0x14(%ebp)
  800181:	e8 24 03 00 00       	call   8004aa <InitializeSemiRandom>
  800186:	83 c4 10             	add    $0x10,%esp
			break ;
  800189:	eb 11                	jmp    80019c <_main+0x164>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	ff 75 f4             	pushl  -0xc(%ebp)
  800191:	ff 75 ec             	pushl  -0x14(%ebp)
  800194:	e8 11 03 00 00       	call   8004aa <InitializeSemiRandom>
  800199:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  80019c:	83 ec 08             	sub    $0x8,%esp
  80019f:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a5:	e8 df 00 00 00       	call   800289 <QuickSort>
  8001aa:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001ad:	e8 9b 18 00 00       	call   801a4d <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 70 22 80 00       	push   $0x802270
  8001ba:	e8 3a 09 00 00       	call   800af9 <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8001c2:	e8 a0 18 00 00       	call   801a67 <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8001cd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d0:	e8 c5 01 00 00       	call   80039a <CheckSorted>
  8001d5:	83 c4 10             	add    $0x10,%esp
  8001d8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001db:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001df:	75 14                	jne    8001f5 <_main+0x1bd>
  8001e1:	83 ec 04             	sub    $0x4,%esp
  8001e4:	68 a4 22 80 00       	push   $0x8022a4
  8001e9:	6a 4f                	push   $0x4f
  8001eb:	68 c6 22 80 00       	push   $0x8022c6
  8001f0:	e8 36 06 00 00       	call   80082b <_panic>
		else
		{
			sys_lock_cons();
  8001f5:	e8 53 18 00 00       	call   801a4d <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  8001fa:	83 ec 0c             	sub    $0xc,%esp
  8001fd:	68 dc 22 80 00       	push   $0x8022dc
  800202:	e8 f2 08 00 00       	call   800af9 <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	68 10 23 80 00       	push   $0x802310
  800212:	e8 e2 08 00 00       	call   800af9 <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 44 23 80 00       	push   $0x802344
  800222:	e8 d2 08 00 00       	call   800af9 <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  80022a:	e8 38 18 00 00       	call   801a67 <sys_unlock_cons>

		}

		//free(Elements) ;

		sys_lock_cons();
  80022f:	e8 19 18 00 00       	call   801a4d <sys_lock_cons>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 76 23 80 00       	push   $0x802376
  80023c:	e8 b8 08 00 00       	call   800af9 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			Chose = 'n' ;
  800244:	c6 45 f3 6e          	movb   $0x6e,-0xd(%ebp)
			cputchar(Chose);
  800248:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	50                   	push   %eax
  800250:	e8 34 03 00 00       	call   800589 <cputchar>
  800255:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800258:	83 ec 0c             	sub    $0xc,%esp
  80025b:	6a 0a                	push   $0xa
  80025d:	e8 27 03 00 00       	call   800589 <cputchar>
  800262:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800265:	83 ec 0c             	sub    $0xc,%esp
  800268:	6a 0a                	push   $0xa
  80026a:	e8 1a 03 00 00       	call   800589 <cputchar>
  80026f:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800272:	e8 f0 17 00 00       	call   801a67 <sys_unlock_cons>

	} while (Chose == 'y');
  800277:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  80027b:	0f 84 c0 fd ff ff    	je     800041 <_main+0x9>

	//To indicate that it's completed successfully
	inctst();
  800281:	e8 47 1b 00 00       	call   801dcd <inctst>
}
  800286:	90                   	nop
  800287:	c9                   	leave  
  800288:	c3                   	ret    

00800289 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800289:	55                   	push   %ebp
  80028a:	89 e5                	mov    %esp,%ebp
  80028c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80028f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800292:	48                   	dec    %eax
  800293:	50                   	push   %eax
  800294:	6a 00                	push   $0x0
  800296:	ff 75 0c             	pushl  0xc(%ebp)
  800299:	ff 75 08             	pushl  0x8(%ebp)
  80029c:	e8 06 00 00 00       	call   8002a7 <QSort>
  8002a1:	83 c4 10             	add    $0x10,%esp
}
  8002a4:	90                   	nop
  8002a5:	c9                   	leave  
  8002a6:	c3                   	ret    

008002a7 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002a7:	55                   	push   %ebp
  8002a8:	89 e5                	mov    %esp,%ebp
  8002aa:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b0:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b3:	0f 8d de 00 00 00    	jge    800397 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	40                   	inc    %eax
  8002bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8002c3:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002c6:	e9 80 00 00 00       	jmp    80034b <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002cb:	ff 45 f4             	incl   -0xc(%ebp)
  8002ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002d1:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002d4:	7f 2b                	jg     800301 <QSort+0x5a>
  8002d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e3:	01 d0                	add    %edx,%eax
  8002e5:	8b 10                	mov    (%eax),%edx
  8002e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ea:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f4:	01 c8                	add    %ecx,%eax
  8002f6:	8b 00                	mov    (%eax),%eax
  8002f8:	39 c2                	cmp    %eax,%edx
  8002fa:	7d cf                	jge    8002cb <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002fc:	eb 03                	jmp    800301 <QSort+0x5a>
  8002fe:	ff 4d f0             	decl   -0x10(%ebp)
  800301:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800304:	3b 45 10             	cmp    0x10(%ebp),%eax
  800307:	7e 26                	jle    80032f <QSort+0x88>
  800309:	8b 45 10             	mov    0x10(%ebp),%eax
  80030c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800313:	8b 45 08             	mov    0x8(%ebp),%eax
  800316:	01 d0                	add    %edx,%eax
  800318:	8b 10                	mov    (%eax),%edx
  80031a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800324:	8b 45 08             	mov    0x8(%ebp),%eax
  800327:	01 c8                	add    %ecx,%eax
  800329:	8b 00                	mov    (%eax),%eax
  80032b:	39 c2                	cmp    %eax,%edx
  80032d:	7e cf                	jle    8002fe <QSort+0x57>

		if (i <= j)
  80032f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800332:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800335:	7f 14                	jg     80034b <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800337:	83 ec 04             	sub    $0x4,%esp
  80033a:	ff 75 f0             	pushl  -0x10(%ebp)
  80033d:	ff 75 f4             	pushl  -0xc(%ebp)
  800340:	ff 75 08             	pushl  0x8(%ebp)
  800343:	e8 a9 00 00 00       	call   8003f1 <Swap>
  800348:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80034b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80034e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800351:	0f 8e 77 ff ff ff    	jle    8002ce <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800357:	83 ec 04             	sub    $0x4,%esp
  80035a:	ff 75 f0             	pushl  -0x10(%ebp)
  80035d:	ff 75 10             	pushl  0x10(%ebp)
  800360:	ff 75 08             	pushl  0x8(%ebp)
  800363:	e8 89 00 00 00       	call   8003f1 <Swap>
  800368:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80036b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036e:	48                   	dec    %eax
  80036f:	50                   	push   %eax
  800370:	ff 75 10             	pushl  0x10(%ebp)
  800373:	ff 75 0c             	pushl  0xc(%ebp)
  800376:	ff 75 08             	pushl  0x8(%ebp)
  800379:	e8 29 ff ff ff       	call   8002a7 <QSort>
  80037e:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800381:	ff 75 14             	pushl  0x14(%ebp)
  800384:	ff 75 f4             	pushl  -0xc(%ebp)
  800387:	ff 75 0c             	pushl  0xc(%ebp)
  80038a:	ff 75 08             	pushl  0x8(%ebp)
  80038d:	e8 15 ff ff ff       	call   8002a7 <QSort>
  800392:	83 c4 10             	add    $0x10,%esp
  800395:	eb 01                	jmp    800398 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800397:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  800398:	c9                   	leave  
  800399:	c3                   	ret    

0080039a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80039a:	55                   	push   %ebp
  80039b:	89 e5                	mov    %esp,%ebp
  80039d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003a0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003a7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003ae:	eb 33                	jmp    8003e3 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bd:	01 d0                	add    %edx,%eax
  8003bf:	8b 10                	mov    (%eax),%edx
  8003c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003c4:	40                   	inc    %eax
  8003c5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cf:	01 c8                	add    %ecx,%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	39 c2                	cmp    %eax,%edx
  8003d5:	7e 09                	jle    8003e0 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003de:	eb 0c                	jmp    8003ec <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	ff 45 f8             	incl   -0x8(%ebp)
  8003e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e6:	48                   	dec    %eax
  8003e7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003ea:	7f c4                	jg     8003b0 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003ef:	c9                   	leave  
  8003f0:	c3                   	ret    

008003f1 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003f1:	55                   	push   %ebp
  8003f2:	89 e5                	mov    %esp,%ebp
  8003f4:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	01 d0                	add    %edx,%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80040b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	01 c2                	add    %eax,%edx
  80041a:	8b 45 10             	mov    0x10(%ebp),%eax
  80041d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800424:	8b 45 08             	mov    0x8(%ebp),%eax
  800427:	01 c8                	add    %ecx,%eax
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80042d:	8b 45 10             	mov    0x10(%ebp),%eax
  800430:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	01 c2                	add    %eax,%edx
  80043c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043f:	89 02                	mov    %eax,(%edx)
}
  800441:	90                   	nop
  800442:	c9                   	leave  
  800443:	c3                   	ret    

00800444 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800444:	55                   	push   %ebp
  800445:	89 e5                	mov    %esp,%ebp
  800447:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800451:	eb 17                	jmp    80046a <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800453:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c2                	add    %eax,%edx
  800462:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800465:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800467:	ff 45 fc             	incl   -0x4(%ebp)
  80046a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800470:	7c e1                	jl     800453 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800472:	90                   	nop
  800473:	c9                   	leave  
  800474:	c3                   	ret    

00800475 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800475:	55                   	push   %ebp
  800476:	89 e5                	mov    %esp,%ebp
  800478:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800482:	eb 1b                	jmp    80049f <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800484:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800487:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	01 c2                	add    %eax,%edx
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800499:	48                   	dec    %eax
  80049a:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80049c:	ff 45 fc             	incl   -0x4(%ebp)
  80049f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a5:	7c dd                	jl     800484 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004a7:	90                   	nop
  8004a8:	c9                   	leave  
  8004a9:	c3                   	ret    

008004aa <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004aa:	55                   	push   %ebp
  8004ab:	89 e5                	mov    %esp,%ebp
  8004ad:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004b3:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004b8:	f7 e9                	imul   %ecx
  8004ba:	c1 f9 1f             	sar    $0x1f,%ecx
  8004bd:	89 d0                	mov    %edx,%eax
  8004bf:	29 c8                	sub    %ecx,%eax
  8004c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8004c4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8004c8:	75 07                	jne    8004d1 <InitializeSemiRandom+0x27>
		Repetition = 3;
  8004ca:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004d8:	eb 1e                	jmp    8004f8 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8004da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ed:	99                   	cltd   
  8004ee:	f7 7d f8             	idivl  -0x8(%ebp)
  8004f1:	89 d0                	mov    %edx,%eax
  8004f3:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
		Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  8004f5:	ff 45 fc             	incl   -0x4(%ebp)
  8004f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004fe:	7c da                	jl     8004da <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800500:	90                   	nop
  800501:	c9                   	leave  
  800502:	c3                   	ret    

00800503 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800503:	55                   	push   %ebp
  800504:	89 e5                	mov    %esp,%ebp
  800506:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800509:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800510:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800517:	eb 42                	jmp    80055b <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800519:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80051c:	99                   	cltd   
  80051d:	f7 7d f0             	idivl  -0x10(%ebp)
  800520:	89 d0                	mov    %edx,%eax
  800522:	85 c0                	test   %eax,%eax
  800524:	75 10                	jne    800536 <PrintElements+0x33>
			cprintf("\n");
  800526:	83 ec 0c             	sub    $0xc,%esp
  800529:	68 c0 21 80 00       	push   $0x8021c0
  80052e:	e8 c6 05 00 00       	call   800af9 <cprintf>
  800533:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800536:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800539:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	8b 00                	mov    (%eax),%eax
  800547:	83 ec 08             	sub    $0x8,%esp
  80054a:	50                   	push   %eax
  80054b:	68 94 23 80 00       	push   $0x802394
  800550:	e8 a4 05 00 00       	call   800af9 <cprintf>
  800555:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800558:	ff 45 f4             	incl   -0xc(%ebp)
  80055b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055e:	48                   	dec    %eax
  80055f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800562:	7f b5                	jg     800519 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800564:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800567:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056e:	8b 45 08             	mov    0x8(%ebp),%eax
  800571:	01 d0                	add    %edx,%eax
  800573:	8b 00                	mov    (%eax),%eax
  800575:	83 ec 08             	sub    $0x8,%esp
  800578:	50                   	push   %eax
  800579:	68 99 23 80 00       	push   $0x802399
  80057e:	e8 76 05 00 00       	call   800af9 <cprintf>
  800583:	83 c4 10             	add    $0x10,%esp

}
  800586:	90                   	nop
  800587:	c9                   	leave  
  800588:	c3                   	ret    

00800589 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800589:	55                   	push   %ebp
  80058a:	89 e5                	mov    %esp,%ebp
  80058c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800595:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800599:	83 ec 0c             	sub    $0xc,%esp
  80059c:	50                   	push   %eax
  80059d:	e8 f3 15 00 00       	call   801b95 <sys_cputc>
  8005a2:	83 c4 10             	add    $0x10,%esp
}
  8005a5:	90                   	nop
  8005a6:	c9                   	leave  
  8005a7:	c3                   	ret    

008005a8 <getchar>:


int
getchar(void)
{
  8005a8:	55                   	push   %ebp
  8005a9:	89 e5                	mov    %esp,%ebp
  8005ab:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8005ae:	e8 81 14 00 00       	call   801a34 <sys_cgetc>
  8005b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8005b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005ba:	74 f2                	je     8005ae <getchar+0x6>
	return c;
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005bf:	c9                   	leave  
  8005c0:	c3                   	ret    

008005c1 <iscons>:

int iscons(int fdnum)
{
  8005c1:	55                   	push   %ebp
  8005c2:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005c4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005c9:	5d                   	pop    %ebp
  8005ca:	c3                   	ret    

008005cb <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8005cb:	55                   	push   %ebp
  8005cc:	89 e5                	mov    %esp,%ebp
  8005ce:	57                   	push   %edi
  8005cf:	56                   	push   %esi
  8005d0:	53                   	push   %ebx
  8005d1:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8005d7:	e8 e9 16 00 00       	call   801cc5 <sys_getenvindex>
  8005dc:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8005df:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e2:	89 d0                	mov    %edx,%eax
  8005e4:	c1 e0 03             	shl    $0x3,%eax
  8005e7:	01 d0                	add    %edx,%eax
  8005e9:	c1 e0 06             	shl    $0x6,%eax
  8005ec:	01 d0                	add    %edx,%eax
  8005ee:	c1 e0 03             	shl    $0x3,%eax
  8005f1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005f6:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800600:	8a 40 10             	mov    0x10(%eax),%al
  800603:	84 c0                	test   %al,%al
  800605:	74 0d                	je     800614 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800607:	a1 24 30 80 00       	mov    0x803024,%eax
  80060c:	83 c0 10             	add    $0x10,%eax
  80060f:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800614:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800618:	7e 0a                	jle    800624 <libmain+0x59>
		binaryname = argv[0];
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800624:	83 ec 08             	sub    $0x8,%esp
  800627:	ff 75 0c             	pushl  0xc(%ebp)
  80062a:	ff 75 08             	pushl  0x8(%ebp)
  80062d:	e8 06 fa ff ff       	call   800038 <_main>
  800632:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800635:	a1 00 30 80 00       	mov    0x803000,%eax
  80063a:	85 c0                	test   %eax,%eax
  80063c:	0f 84 b7 01 00 00    	je     8007f9 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800642:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800648:	bb dc 24 80 00       	mov    $0x8024dc,%ebx
  80064d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800652:	89 c7                	mov    %eax,%edi
  800654:	89 de                	mov    %ebx,%esi
  800656:	89 d1                	mov    %edx,%ecx
  800658:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80065a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800660:	b9 56 00 00 00       	mov    $0x56,%ecx
  800665:	b0 00                	mov    $0x0,%al
  800667:	89 d7                	mov    %edx,%edi
  800669:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80066b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800672:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800675:	83 ec 08             	sub    $0x8,%esp
  800678:	50                   	push   %eax
  800679:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80067f:	50                   	push   %eax
  800680:	e8 40 18 00 00       	call   801ec5 <sys_utilities>
  800685:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800688:	e8 c0 13 00 00       	call   801a4d <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80068d:	83 ec 0c             	sub    $0xc,%esp
  800690:	68 b8 23 80 00       	push   $0x8023b8
  800695:	e8 5f 04 00 00       	call   800af9 <cprintf>
  80069a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80069d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006a0:	85 c0                	test   %eax,%eax
  8006a2:	74 58                	je     8006fc <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006a4:	e8 3a 18 00 00       	call   801ee3 <sys_get_optimal_num_faults>
  8006a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006ac:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006b2:	bb 40 25 80 00       	mov    $0x802540,%ebx
  8006b7:	ba 11 00 00 00       	mov    $0x11,%edx
  8006bc:	89 c7                	mov    %eax,%edi
  8006be:	89 de                	mov    %ebx,%esi
  8006c0:	89 d1                	mov    %edx,%ecx
  8006c2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006c4:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8006c7:	b9 53 00 00 00       	mov    $0x53,%ecx
  8006cc:	b0 00                	mov    $0x0,%al
  8006ce:	89 d7                	mov    %edx,%edi
  8006d0:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8006d2:	83 ec 08             	sub    $0x8,%esp
  8006d5:	ff 75 dc             	pushl  -0x24(%ebp)
  8006d8:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006de:	50                   	push   %eax
  8006df:	e8 e1 17 00 00       	call   801ec5 <sys_utilities>
  8006e4:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 dc             	pushl  -0x24(%ebp)
  8006ed:	68 e0 23 80 00       	push   $0x8023e0
  8006f2:	e8 02 04 00 00       	call   800af9 <cprintf>
  8006f7:	83 c4 10             	add    $0x10,%esp
  8006fa:	eb 59                	jmp    800755 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800701:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800707:	a1 24 30 80 00       	mov    0x803024,%eax
  80070c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800712:	83 ec 04             	sub    $0x4,%esp
  800715:	52                   	push   %edx
  800716:	50                   	push   %eax
  800717:	68 04 24 80 00       	push   $0x802404
  80071c:	e8 d8 03 00 00       	call   800af9 <cprintf>
  800721:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800724:	a1 24 30 80 00       	mov    0x803024,%eax
  800729:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80072f:	a1 24 30 80 00       	mov    0x803024,%eax
  800734:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80073a:	a1 24 30 80 00       	mov    0x803024,%eax
  80073f:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800745:	51                   	push   %ecx
  800746:	52                   	push   %edx
  800747:	50                   	push   %eax
  800748:	68 2c 24 80 00       	push   $0x80242c
  80074d:	e8 a7 03 00 00       	call   800af9 <cprintf>
  800752:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800755:	a1 24 30 80 00       	mov    0x803024,%eax
  80075a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	50                   	push   %eax
  800764:	68 84 24 80 00       	push   $0x802484
  800769:	e8 8b 03 00 00       	call   800af9 <cprintf>
  80076e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800771:	83 ec 0c             	sub    $0xc,%esp
  800774:	68 98 24 80 00       	push   $0x802498
  800779:	e8 7b 03 00 00       	call   800af9 <cprintf>
  80077e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800781:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800788:	eb 28                	jmp    8007b2 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80078a:	a1 24 30 80 00       	mov    0x803024,%eax
  80078f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800792:	81 c2 74 04 00 00    	add    $0x474,%edx
  800798:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80079b:	83 ec 04             	sub    $0x4,%esp
  80079e:	50                   	push   %eax
  80079f:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007a2:	68 af 24 80 00       	push   $0x8024af
  8007a7:	e8 4d 03 00 00       	call   800af9 <cprintf>
  8007ac:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007af:	ff 45 e4             	incl   -0x1c(%ebp)
  8007b2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007b6:	7e d2                	jle    80078a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007b8:	83 ec 0c             	sub    $0xc,%esp
  8007bb:	68 be 24 80 00       	push   $0x8024be
  8007c0:	e8 34 03 00 00       	call   800af9 <cprintf>
  8007c5:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8007c8:	a1 24 30 80 00       	mov    0x803024,%eax
  8007cd:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	50                   	push   %eax
  8007d7:	68 c2 24 80 00       	push   $0x8024c2
  8007dc:	e8 18 03 00 00       	call   800af9 <cprintf>
  8007e1:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8007e4:	83 ec 0c             	sub    $0xc,%esp
  8007e7:	68 b8 23 80 00       	push   $0x8023b8
  8007ec:	e8 08 03 00 00       	call   800af9 <cprintf>
  8007f1:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8007f4:	e8 6e 12 00 00       	call   801a67 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8007f9:	e8 1f 00 00 00       	call   80081d <exit>
}
  8007fe:	90                   	nop
  8007ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800802:	5b                   	pop    %ebx
  800803:	5e                   	pop    %esi
  800804:	5f                   	pop    %edi
  800805:	5d                   	pop    %ebp
  800806:	c3                   	ret    

00800807 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800807:	55                   	push   %ebp
  800808:	89 e5                	mov    %esp,%ebp
  80080a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80080d:	83 ec 0c             	sub    $0xc,%esp
  800810:	6a 00                	push   $0x0
  800812:	e8 7a 14 00 00       	call   801c91 <sys_destroy_env>
  800817:	83 c4 10             	add    $0x10,%esp
}
  80081a:	90                   	nop
  80081b:	c9                   	leave  
  80081c:	c3                   	ret    

0080081d <exit>:

void
exit(void)
{
  80081d:	55                   	push   %ebp
  80081e:	89 e5                	mov    %esp,%ebp
  800820:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800823:	e8 cf 14 00 00       	call   801cf7 <sys_exit_env>
}
  800828:	90                   	nop
  800829:	c9                   	leave  
  80082a:	c3                   	ret    

0080082b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
  80082e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800831:	8d 45 10             	lea    0x10(%ebp),%eax
  800834:	83 c0 04             	add    $0x4,%eax
  800837:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80083a:	a1 44 3a bd 00       	mov    0xbd3a44,%eax
  80083f:	85 c0                	test   %eax,%eax
  800841:	74 16                	je     800859 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800843:	a1 44 3a bd 00       	mov    0xbd3a44,%eax
  800848:	83 ec 08             	sub    $0x8,%esp
  80084b:	50                   	push   %eax
  80084c:	68 a4 25 80 00       	push   $0x8025a4
  800851:	e8 a3 02 00 00       	call   800af9 <cprintf>
  800856:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800859:	a1 04 30 80 00       	mov    0x803004,%eax
  80085e:	83 ec 0c             	sub    $0xc,%esp
  800861:	ff 75 0c             	pushl  0xc(%ebp)
  800864:	ff 75 08             	pushl  0x8(%ebp)
  800867:	50                   	push   %eax
  800868:	68 ac 25 80 00       	push   $0x8025ac
  80086d:	6a 74                	push   $0x74
  80086f:	e8 b2 02 00 00       	call   800b26 <cprintf_colored>
  800874:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800877:	8b 45 10             	mov    0x10(%ebp),%eax
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 f4             	pushl  -0xc(%ebp)
  800880:	50                   	push   %eax
  800881:	e8 04 02 00 00       	call   800a8a <vcprintf>
  800886:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800889:	83 ec 08             	sub    $0x8,%esp
  80088c:	6a 00                	push   $0x0
  80088e:	68 d4 25 80 00       	push   $0x8025d4
  800893:	e8 f2 01 00 00       	call   800a8a <vcprintf>
  800898:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80089b:	e8 7d ff ff ff       	call   80081d <exit>

	// should not return here
	while (1) ;
  8008a0:	eb fe                	jmp    8008a0 <_panic+0x75>

008008a2 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008a2:	55                   	push   %ebp
  8008a3:	89 e5                	mov    %esp,%ebp
  8008a5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008a8:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ad:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b6:	39 c2                	cmp    %eax,%edx
  8008b8:	74 14                	je     8008ce <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008ba:	83 ec 04             	sub    $0x4,%esp
  8008bd:	68 d8 25 80 00       	push   $0x8025d8
  8008c2:	6a 26                	push   $0x26
  8008c4:	68 24 26 80 00       	push   $0x802624
  8008c9:	e8 5d ff ff ff       	call   80082b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008dc:	e9 c5 00 00 00       	jmp    8009a6 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8008e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	01 d0                	add    %edx,%eax
  8008f0:	8b 00                	mov    (%eax),%eax
  8008f2:	85 c0                	test   %eax,%eax
  8008f4:	75 08                	jne    8008fe <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8008f6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008f9:	e9 a5 00 00 00       	jmp    8009a3 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8008fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800905:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80090c:	eb 69                	jmp    800977 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80090e:	a1 24 30 80 00       	mov    0x803024,%eax
  800913:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800919:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80091c:	89 d0                	mov    %edx,%eax
  80091e:	01 c0                	add    %eax,%eax
  800920:	01 d0                	add    %edx,%eax
  800922:	c1 e0 03             	shl    $0x3,%eax
  800925:	01 c8                	add    %ecx,%eax
  800927:	8a 40 04             	mov    0x4(%eax),%al
  80092a:	84 c0                	test   %al,%al
  80092c:	75 46                	jne    800974 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80092e:	a1 24 30 80 00       	mov    0x803024,%eax
  800933:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800939:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80093c:	89 d0                	mov    %edx,%eax
  80093e:	01 c0                	add    %eax,%eax
  800940:	01 d0                	add    %edx,%eax
  800942:	c1 e0 03             	shl    $0x3,%eax
  800945:	01 c8                	add    %ecx,%eax
  800947:	8b 00                	mov    (%eax),%eax
  800949:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80094c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80094f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800954:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800956:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800959:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800960:	8b 45 08             	mov    0x8(%ebp),%eax
  800963:	01 c8                	add    %ecx,%eax
  800965:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800967:	39 c2                	cmp    %eax,%edx
  800969:	75 09                	jne    800974 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80096b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800972:	eb 15                	jmp    800989 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800974:	ff 45 e8             	incl   -0x18(%ebp)
  800977:	a1 24 30 80 00       	mov    0x803024,%eax
  80097c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800982:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800985:	39 c2                	cmp    %eax,%edx
  800987:	77 85                	ja     80090e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800989:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80098d:	75 14                	jne    8009a3 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80098f:	83 ec 04             	sub    $0x4,%esp
  800992:	68 30 26 80 00       	push   $0x802630
  800997:	6a 3a                	push   $0x3a
  800999:	68 24 26 80 00       	push   $0x802624
  80099e:	e8 88 fe ff ff       	call   80082b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009a3:	ff 45 f0             	incl   -0x10(%ebp)
  8009a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009a9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009ac:	0f 8c 2f ff ff ff    	jl     8008e1 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009b2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009c0:	eb 26                	jmp    8009e8 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009c2:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c7:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8009cd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009d0:	89 d0                	mov    %edx,%eax
  8009d2:	01 c0                	add    %eax,%eax
  8009d4:	01 d0                	add    %edx,%eax
  8009d6:	c1 e0 03             	shl    $0x3,%eax
  8009d9:	01 c8                	add    %ecx,%eax
  8009db:	8a 40 04             	mov    0x4(%eax),%al
  8009de:	3c 01                	cmp    $0x1,%al
  8009e0:	75 03                	jne    8009e5 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8009e2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009e5:	ff 45 e0             	incl   -0x20(%ebp)
  8009e8:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ed:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f6:	39 c2                	cmp    %eax,%edx
  8009f8:	77 c8                	ja     8009c2 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009fd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a00:	74 14                	je     800a16 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a02:	83 ec 04             	sub    $0x4,%esp
  800a05:	68 84 26 80 00       	push   $0x802684
  800a0a:	6a 44                	push   $0x44
  800a0c:	68 24 26 80 00       	push   $0x802624
  800a11:	e8 15 fe ff ff       	call   80082b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a16:	90                   	nop
  800a17:	c9                   	leave  
  800a18:	c3                   	ret    

00800a19 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a19:	55                   	push   %ebp
  800a1a:	89 e5                	mov    %esp,%ebp
  800a1c:	53                   	push   %ebx
  800a1d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a23:	8b 00                	mov    (%eax),%eax
  800a25:	8d 48 01             	lea    0x1(%eax),%ecx
  800a28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2b:	89 0a                	mov    %ecx,(%edx)
  800a2d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a30:	88 d1                	mov    %dl,%cl
  800a32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a35:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	8b 00                	mov    (%eax),%eax
  800a3e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a43:	75 30                	jne    800a75 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a45:	8b 15 48 3a bd 00    	mov    0xbd3a48,%edx
  800a4b:	a0 40 30 80 00       	mov    0x803040,%al
  800a50:	0f b6 c0             	movzbl %al,%eax
  800a53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a56:	8b 09                	mov    (%ecx),%ecx
  800a58:	89 cb                	mov    %ecx,%ebx
  800a5a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a5d:	83 c1 08             	add    $0x8,%ecx
  800a60:	52                   	push   %edx
  800a61:	50                   	push   %eax
  800a62:	53                   	push   %ebx
  800a63:	51                   	push   %ecx
  800a64:	e8 a0 0f 00 00       	call   801a09 <sys_cputs>
  800a69:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a78:	8b 40 04             	mov    0x4(%eax),%eax
  800a7b:	8d 50 01             	lea    0x1(%eax),%edx
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a84:	90                   	nop
  800a85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a88:	c9                   	leave  
  800a89:	c3                   	ret    

00800a8a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a8a:	55                   	push   %ebp
  800a8b:	89 e5                	mov    %esp,%ebp
  800a8d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a93:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a9a:	00 00 00 
	b.cnt = 0;
  800a9d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aa4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800aa7:	ff 75 0c             	pushl  0xc(%ebp)
  800aaa:	ff 75 08             	pushl  0x8(%ebp)
  800aad:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ab3:	50                   	push   %eax
  800ab4:	68 19 0a 80 00       	push   $0x800a19
  800ab9:	e8 5a 02 00 00       	call   800d18 <vprintfmt>
  800abe:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800ac1:	8b 15 48 3a bd 00    	mov    0xbd3a48,%edx
  800ac7:	a0 40 30 80 00       	mov    0x803040,%al
  800acc:	0f b6 c0             	movzbl %al,%eax
  800acf:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800ad5:	52                   	push   %edx
  800ad6:	50                   	push   %eax
  800ad7:	51                   	push   %ecx
  800ad8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ade:	83 c0 08             	add    $0x8,%eax
  800ae1:	50                   	push   %eax
  800ae2:	e8 22 0f 00 00       	call   801a09 <sys_cputs>
  800ae7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aea:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800af1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800af7:	c9                   	leave  
  800af8:	c3                   	ret    

00800af9 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
  800afc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800aff:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800b06:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	83 ec 08             	sub    $0x8,%esp
  800b12:	ff 75 f4             	pushl  -0xc(%ebp)
  800b15:	50                   	push   %eax
  800b16:	e8 6f ff ff ff       	call   800a8a <vcprintf>
  800b1b:	83 c4 10             	add    $0x10,%esp
  800b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b21:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b24:	c9                   	leave  
  800b25:	c3                   	ret    

00800b26 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b26:	55                   	push   %ebp
  800b27:	89 e5                	mov    %esp,%ebp
  800b29:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b2c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	c1 e0 08             	shl    $0x8,%eax
  800b39:	a3 48 3a bd 00       	mov    %eax,0xbd3a48
	va_start(ap, fmt);
  800b3e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b41:	83 c0 04             	add    $0x4,%eax
  800b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b50:	50                   	push   %eax
  800b51:	e8 34 ff ff ff       	call   800a8a <vcprintf>
  800b56:	83 c4 10             	add    $0x10,%esp
  800b59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800b5c:	c7 05 48 3a bd 00 00 	movl   $0x700,0xbd3a48
  800b63:	07 00 00 

	return cnt;
  800b66:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b69:	c9                   	leave  
  800b6a:	c3                   	ret    

00800b6b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
  800b6e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800b71:	e8 d7 0e 00 00       	call   801a4d <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800b76:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b79:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	83 ec 08             	sub    $0x8,%esp
  800b82:	ff 75 f4             	pushl  -0xc(%ebp)
  800b85:	50                   	push   %eax
  800b86:	e8 ff fe ff ff       	call   800a8a <vcprintf>
  800b8b:	83 c4 10             	add    $0x10,%esp
  800b8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800b91:	e8 d1 0e 00 00       	call   801a67 <sys_unlock_cons>
	return cnt;
  800b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b99:	c9                   	leave  
  800b9a:	c3                   	ret    

00800b9b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
  800b9e:	53                   	push   %ebx
  800b9f:	83 ec 14             	sub    $0x14,%esp
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bae:	8b 45 18             	mov    0x18(%ebp),%eax
  800bb1:	ba 00 00 00 00       	mov    $0x0,%edx
  800bb6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bb9:	77 55                	ja     800c10 <printnum+0x75>
  800bbb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bbe:	72 05                	jb     800bc5 <printnum+0x2a>
  800bc0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bc3:	77 4b                	ja     800c10 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bc5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bc8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bcb:	8b 45 18             	mov    0x18(%ebp),%eax
  800bce:	ba 00 00 00 00       	mov    $0x0,%edx
  800bd3:	52                   	push   %edx
  800bd4:	50                   	push   %eax
  800bd5:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd8:	ff 75 f0             	pushl  -0x10(%ebp)
  800bdb:	e8 74 13 00 00       	call   801f54 <__udivdi3>
  800be0:	83 c4 10             	add    $0x10,%esp
  800be3:	83 ec 04             	sub    $0x4,%esp
  800be6:	ff 75 20             	pushl  0x20(%ebp)
  800be9:	53                   	push   %ebx
  800bea:	ff 75 18             	pushl  0x18(%ebp)
  800bed:	52                   	push   %edx
  800bee:	50                   	push   %eax
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	ff 75 08             	pushl  0x8(%ebp)
  800bf5:	e8 a1 ff ff ff       	call   800b9b <printnum>
  800bfa:	83 c4 20             	add    $0x20,%esp
  800bfd:	eb 1a                	jmp    800c19 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	ff 75 20             	pushl  0x20(%ebp)
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	ff d0                	call   *%eax
  800c0d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c10:	ff 4d 1c             	decl   0x1c(%ebp)
  800c13:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c17:	7f e6                	jg     800bff <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c19:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c1c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c21:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c27:	53                   	push   %ebx
  800c28:	51                   	push   %ecx
  800c29:	52                   	push   %edx
  800c2a:	50                   	push   %eax
  800c2b:	e8 34 14 00 00       	call   802064 <__umoddi3>
  800c30:	83 c4 10             	add    $0x10,%esp
  800c33:	05 f4 28 80 00       	add    $0x8028f4,%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f be c0             	movsbl %al,%eax
  800c3d:	83 ec 08             	sub    $0x8,%esp
  800c40:	ff 75 0c             	pushl  0xc(%ebp)
  800c43:	50                   	push   %eax
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	ff d0                	call   *%eax
  800c49:	83 c4 10             	add    $0x10,%esp
}
  800c4c:	90                   	nop
  800c4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c50:	c9                   	leave  
  800c51:	c3                   	ret    

00800c52 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c55:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c59:	7e 1c                	jle    800c77 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8b 00                	mov    (%eax),%eax
  800c60:	8d 50 08             	lea    0x8(%eax),%edx
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	89 10                	mov    %edx,(%eax)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	83 e8 08             	sub    $0x8,%eax
  800c70:	8b 50 04             	mov    0x4(%eax),%edx
  800c73:	8b 00                	mov    (%eax),%eax
  800c75:	eb 40                	jmp    800cb7 <getuint+0x65>
	else if (lflag)
  800c77:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c7b:	74 1e                	je     800c9b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8b 00                	mov    (%eax),%eax
  800c82:	8d 50 04             	lea    0x4(%eax),%edx
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	89 10                	mov    %edx,(%eax)
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8b 00                	mov    (%eax),%eax
  800c8f:	83 e8 04             	sub    $0x4,%eax
  800c92:	8b 00                	mov    (%eax),%eax
  800c94:	ba 00 00 00 00       	mov    $0x0,%edx
  800c99:	eb 1c                	jmp    800cb7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	8d 50 04             	lea    0x4(%eax),%edx
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	89 10                	mov    %edx,(%eax)
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8b 00                	mov    (%eax),%eax
  800cad:	83 e8 04             	sub    $0x4,%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cb7:	5d                   	pop    %ebp
  800cb8:	c3                   	ret    

00800cb9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cbc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cc0:	7e 1c                	jle    800cde <getint+0x25>
		return va_arg(*ap, long long);
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8b 00                	mov    (%eax),%eax
  800cc7:	8d 50 08             	lea    0x8(%eax),%edx
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	89 10                	mov    %edx,(%eax)
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8b 00                	mov    (%eax),%eax
  800cd4:	83 e8 08             	sub    $0x8,%eax
  800cd7:	8b 50 04             	mov    0x4(%eax),%edx
  800cda:	8b 00                	mov    (%eax),%eax
  800cdc:	eb 38                	jmp    800d16 <getint+0x5d>
	else if (lflag)
  800cde:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce2:	74 1a                	je     800cfe <getint+0x45>
		return va_arg(*ap, long);
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8b 00                	mov    (%eax),%eax
  800ce9:	8d 50 04             	lea    0x4(%eax),%edx
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	89 10                	mov    %edx,(%eax)
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	83 e8 04             	sub    $0x4,%eax
  800cf9:	8b 00                	mov    (%eax),%eax
  800cfb:	99                   	cltd   
  800cfc:	eb 18                	jmp    800d16 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 50 04             	lea    0x4(%eax),%edx
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	89 10                	mov    %edx,(%eax)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	83 e8 04             	sub    $0x4,%eax
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	99                   	cltd   
}
  800d16:	5d                   	pop    %ebp
  800d17:	c3                   	ret    

00800d18 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	56                   	push   %esi
  800d1c:	53                   	push   %ebx
  800d1d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d20:	eb 17                	jmp    800d39 <vprintfmt+0x21>
			if (ch == '\0')
  800d22:	85 db                	test   %ebx,%ebx
  800d24:	0f 84 c1 03 00 00    	je     8010eb <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d2a:	83 ec 08             	sub    $0x8,%esp
  800d2d:	ff 75 0c             	pushl  0xc(%ebp)
  800d30:	53                   	push   %ebx
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	ff d0                	call   *%eax
  800d36:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d39:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3c:	8d 50 01             	lea    0x1(%eax),%edx
  800d3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	0f b6 d8             	movzbl %al,%ebx
  800d47:	83 fb 25             	cmp    $0x25,%ebx
  800d4a:	75 d6                	jne    800d22 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d4c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d50:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d57:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d5e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d65:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6f:	8d 50 01             	lea    0x1(%eax),%edx
  800d72:	89 55 10             	mov    %edx,0x10(%ebp)
  800d75:	8a 00                	mov    (%eax),%al
  800d77:	0f b6 d8             	movzbl %al,%ebx
  800d7a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d7d:	83 f8 5b             	cmp    $0x5b,%eax
  800d80:	0f 87 3d 03 00 00    	ja     8010c3 <vprintfmt+0x3ab>
  800d86:	8b 04 85 18 29 80 00 	mov    0x802918(,%eax,4),%eax
  800d8d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d8f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d93:	eb d7                	jmp    800d6c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d95:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d99:	eb d1                	jmp    800d6c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d9b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800da2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800da5:	89 d0                	mov    %edx,%eax
  800da7:	c1 e0 02             	shl    $0x2,%eax
  800daa:	01 d0                	add    %edx,%eax
  800dac:	01 c0                	add    %eax,%eax
  800dae:	01 d8                	add    %ebx,%eax
  800db0:	83 e8 30             	sub    $0x30,%eax
  800db3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800db6:	8b 45 10             	mov    0x10(%ebp),%eax
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dbe:	83 fb 2f             	cmp    $0x2f,%ebx
  800dc1:	7e 3e                	jle    800e01 <vprintfmt+0xe9>
  800dc3:	83 fb 39             	cmp    $0x39,%ebx
  800dc6:	7f 39                	jg     800e01 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dc8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800dcb:	eb d5                	jmp    800da2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800dcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd0:	83 c0 04             	add    $0x4,%eax
  800dd3:	89 45 14             	mov    %eax,0x14(%ebp)
  800dd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd9:	83 e8 04             	sub    $0x4,%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800de1:	eb 1f                	jmp    800e02 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800de3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de7:	79 83                	jns    800d6c <vprintfmt+0x54>
				width = 0;
  800de9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800df0:	e9 77 ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800df5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800dfc:	e9 6b ff ff ff       	jmp    800d6c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e01:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e06:	0f 89 60 ff ff ff    	jns    800d6c <vprintfmt+0x54>
				width = precision, precision = -1;
  800e0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e12:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e19:	e9 4e ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e1e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e21:	e9 46 ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e26:	8b 45 14             	mov    0x14(%ebp),%eax
  800e29:	83 c0 04             	add    $0x4,%eax
  800e2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e32:	83 e8 04             	sub    $0x4,%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	ff 75 0c             	pushl  0xc(%ebp)
  800e3d:	50                   	push   %eax
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	ff d0                	call   *%eax
  800e43:	83 c4 10             	add    $0x10,%esp
			break;
  800e46:	e9 9b 02 00 00       	jmp    8010e6 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4e:	83 c0 04             	add    $0x4,%eax
  800e51:	89 45 14             	mov    %eax,0x14(%ebp)
  800e54:	8b 45 14             	mov    0x14(%ebp),%eax
  800e57:	83 e8 04             	sub    $0x4,%eax
  800e5a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e5c:	85 db                	test   %ebx,%ebx
  800e5e:	79 02                	jns    800e62 <vprintfmt+0x14a>
				err = -err;
  800e60:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e62:	83 fb 64             	cmp    $0x64,%ebx
  800e65:	7f 0b                	jg     800e72 <vprintfmt+0x15a>
  800e67:	8b 34 9d 60 27 80 00 	mov    0x802760(,%ebx,4),%esi
  800e6e:	85 f6                	test   %esi,%esi
  800e70:	75 19                	jne    800e8b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e72:	53                   	push   %ebx
  800e73:	68 05 29 80 00       	push   $0x802905
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	ff 75 08             	pushl  0x8(%ebp)
  800e7e:	e8 70 02 00 00       	call   8010f3 <printfmt>
  800e83:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e86:	e9 5b 02 00 00       	jmp    8010e6 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e8b:	56                   	push   %esi
  800e8c:	68 0e 29 80 00       	push   $0x80290e
  800e91:	ff 75 0c             	pushl  0xc(%ebp)
  800e94:	ff 75 08             	pushl  0x8(%ebp)
  800e97:	e8 57 02 00 00       	call   8010f3 <printfmt>
  800e9c:	83 c4 10             	add    $0x10,%esp
			break;
  800e9f:	e9 42 02 00 00       	jmp    8010e6 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ea4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea7:	83 c0 04             	add    $0x4,%eax
  800eaa:	89 45 14             	mov    %eax,0x14(%ebp)
  800ead:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb0:	83 e8 04             	sub    $0x4,%eax
  800eb3:	8b 30                	mov    (%eax),%esi
  800eb5:	85 f6                	test   %esi,%esi
  800eb7:	75 05                	jne    800ebe <vprintfmt+0x1a6>
				p = "(null)";
  800eb9:	be 11 29 80 00       	mov    $0x802911,%esi
			if (width > 0 && padc != '-')
  800ebe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec2:	7e 6d                	jle    800f31 <vprintfmt+0x219>
  800ec4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ec8:	74 67                	je     800f31 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800eca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	50                   	push   %eax
  800ed1:	56                   	push   %esi
  800ed2:	e8 1e 03 00 00       	call   8011f5 <strnlen>
  800ed7:	83 c4 10             	add    $0x10,%esp
  800eda:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800edd:	eb 16                	jmp    800ef5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800edf:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 0c             	pushl  0xc(%ebp)
  800ee9:	50                   	push   %eax
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ef2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ef5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ef9:	7f e4                	jg     800edf <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800efb:	eb 34                	jmp    800f31 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800efd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f01:	74 1c                	je     800f1f <vprintfmt+0x207>
  800f03:	83 fb 1f             	cmp    $0x1f,%ebx
  800f06:	7e 05                	jle    800f0d <vprintfmt+0x1f5>
  800f08:	83 fb 7e             	cmp    $0x7e,%ebx
  800f0b:	7e 12                	jle    800f1f <vprintfmt+0x207>
					putch('?', putdat);
  800f0d:	83 ec 08             	sub    $0x8,%esp
  800f10:	ff 75 0c             	pushl  0xc(%ebp)
  800f13:	6a 3f                	push   $0x3f
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	ff d0                	call   *%eax
  800f1a:	83 c4 10             	add    $0x10,%esp
  800f1d:	eb 0f                	jmp    800f2e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	53                   	push   %ebx
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f2e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f31:	89 f0                	mov    %esi,%eax
  800f33:	8d 70 01             	lea    0x1(%eax),%esi
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f be d8             	movsbl %al,%ebx
  800f3b:	85 db                	test   %ebx,%ebx
  800f3d:	74 24                	je     800f63 <vprintfmt+0x24b>
  800f3f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f43:	78 b8                	js     800efd <vprintfmt+0x1e5>
  800f45:	ff 4d e0             	decl   -0x20(%ebp)
  800f48:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f4c:	79 af                	jns    800efd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f4e:	eb 13                	jmp    800f63 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f50:	83 ec 08             	sub    $0x8,%esp
  800f53:	ff 75 0c             	pushl  0xc(%ebp)
  800f56:	6a 20                	push   $0x20
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	ff d0                	call   *%eax
  800f5d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f60:	ff 4d e4             	decl   -0x1c(%ebp)
  800f63:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f67:	7f e7                	jg     800f50 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f69:	e9 78 01 00 00       	jmp    8010e6 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f6e:	83 ec 08             	sub    $0x8,%esp
  800f71:	ff 75 e8             	pushl  -0x18(%ebp)
  800f74:	8d 45 14             	lea    0x14(%ebp),%eax
  800f77:	50                   	push   %eax
  800f78:	e8 3c fd ff ff       	call   800cb9 <getint>
  800f7d:	83 c4 10             	add    $0x10,%esp
  800f80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f83:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8c:	85 d2                	test   %edx,%edx
  800f8e:	79 23                	jns    800fb3 <vprintfmt+0x29b>
				putch('-', putdat);
  800f90:	83 ec 08             	sub    $0x8,%esp
  800f93:	ff 75 0c             	pushl  0xc(%ebp)
  800f96:	6a 2d                	push   $0x2d
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	ff d0                	call   *%eax
  800f9d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa6:	f7 d8                	neg    %eax
  800fa8:	83 d2 00             	adc    $0x0,%edx
  800fab:	f7 da                	neg    %edx
  800fad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fb3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fba:	e9 bc 00 00 00       	jmp    80107b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	ff 75 e8             	pushl  -0x18(%ebp)
  800fc5:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc8:	50                   	push   %eax
  800fc9:	e8 84 fc ff ff       	call   800c52 <getuint>
  800fce:	83 c4 10             	add    $0x10,%esp
  800fd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800fd7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fde:	e9 98 00 00 00       	jmp    80107b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800fe3:	83 ec 08             	sub    $0x8,%esp
  800fe6:	ff 75 0c             	pushl  0xc(%ebp)
  800fe9:	6a 58                	push   $0x58
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	ff d0                	call   *%eax
  800ff0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ff3:	83 ec 08             	sub    $0x8,%esp
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	6a 58                	push   $0x58
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	ff d0                	call   *%eax
  801000:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 0c             	pushl  0xc(%ebp)
  801009:	6a 58                	push   $0x58
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	ff d0                	call   *%eax
  801010:	83 c4 10             	add    $0x10,%esp
			break;
  801013:	e9 ce 00 00 00       	jmp    8010e6 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801018:	83 ec 08             	sub    $0x8,%esp
  80101b:	ff 75 0c             	pushl  0xc(%ebp)
  80101e:	6a 30                	push   $0x30
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	ff d0                	call   *%eax
  801025:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801028:	83 ec 08             	sub    $0x8,%esp
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	6a 78                	push   $0x78
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	ff d0                	call   *%eax
  801035:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801038:	8b 45 14             	mov    0x14(%ebp),%eax
  80103b:	83 c0 04             	add    $0x4,%eax
  80103e:	89 45 14             	mov    %eax,0x14(%ebp)
  801041:	8b 45 14             	mov    0x14(%ebp),%eax
  801044:	83 e8 04             	sub    $0x4,%eax
  801047:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801049:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80104c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801053:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80105a:	eb 1f                	jmp    80107b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 e8             	pushl  -0x18(%ebp)
  801062:	8d 45 14             	lea    0x14(%ebp),%eax
  801065:	50                   	push   %eax
  801066:	e8 e7 fb ff ff       	call   800c52 <getuint>
  80106b:	83 c4 10             	add    $0x10,%esp
  80106e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801071:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801074:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80107b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80107f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801082:	83 ec 04             	sub    $0x4,%esp
  801085:	52                   	push   %edx
  801086:	ff 75 e4             	pushl  -0x1c(%ebp)
  801089:	50                   	push   %eax
  80108a:	ff 75 f4             	pushl  -0xc(%ebp)
  80108d:	ff 75 f0             	pushl  -0x10(%ebp)
  801090:	ff 75 0c             	pushl  0xc(%ebp)
  801093:	ff 75 08             	pushl  0x8(%ebp)
  801096:	e8 00 fb ff ff       	call   800b9b <printnum>
  80109b:	83 c4 20             	add    $0x20,%esp
			break;
  80109e:	eb 46                	jmp    8010e6 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 0c             	pushl  0xc(%ebp)
  8010a6:	53                   	push   %ebx
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	ff d0                	call   *%eax
  8010ac:	83 c4 10             	add    $0x10,%esp
			break;
  8010af:	eb 35                	jmp    8010e6 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010b1:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8010b8:	eb 2c                	jmp    8010e6 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8010ba:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8010c1:	eb 23                	jmp    8010e6 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010c3:	83 ec 08             	sub    $0x8,%esp
  8010c6:	ff 75 0c             	pushl  0xc(%ebp)
  8010c9:	6a 25                	push   $0x25
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	ff d0                	call   *%eax
  8010d0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010d3:	ff 4d 10             	decl   0x10(%ebp)
  8010d6:	eb 03                	jmp    8010db <vprintfmt+0x3c3>
  8010d8:	ff 4d 10             	decl   0x10(%ebp)
  8010db:	8b 45 10             	mov    0x10(%ebp),%eax
  8010de:	48                   	dec    %eax
  8010df:	8a 00                	mov    (%eax),%al
  8010e1:	3c 25                	cmp    $0x25,%al
  8010e3:	75 f3                	jne    8010d8 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8010e5:	90                   	nop
		}
	}
  8010e6:	e9 35 fc ff ff       	jmp    800d20 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010eb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010ef:	5b                   	pop    %ebx
  8010f0:	5e                   	pop    %esi
  8010f1:	5d                   	pop    %ebp
  8010f2:	c3                   	ret    

008010f3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
  8010f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8010f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8010fc:	83 c0 04             	add    $0x4,%eax
  8010ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801102:	8b 45 10             	mov    0x10(%ebp),%eax
  801105:	ff 75 f4             	pushl  -0xc(%ebp)
  801108:	50                   	push   %eax
  801109:	ff 75 0c             	pushl  0xc(%ebp)
  80110c:	ff 75 08             	pushl  0x8(%ebp)
  80110f:	e8 04 fc ff ff       	call   800d18 <vprintfmt>
  801114:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801117:	90                   	nop
  801118:	c9                   	leave  
  801119:	c3                   	ret    

0080111a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80111a:	55                   	push   %ebp
  80111b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80111d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801120:	8b 40 08             	mov    0x8(%eax),%eax
  801123:	8d 50 01             	lea    0x1(%eax),%edx
  801126:	8b 45 0c             	mov    0xc(%ebp),%eax
  801129:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	8b 10                	mov    (%eax),%edx
  801131:	8b 45 0c             	mov    0xc(%ebp),%eax
  801134:	8b 40 04             	mov    0x4(%eax),%eax
  801137:	39 c2                	cmp    %eax,%edx
  801139:	73 12                	jae    80114d <sprintputch+0x33>
		*b->buf++ = ch;
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	8b 00                	mov    (%eax),%eax
  801140:	8d 48 01             	lea    0x1(%eax),%ecx
  801143:	8b 55 0c             	mov    0xc(%ebp),%edx
  801146:	89 0a                	mov    %ecx,(%edx)
  801148:	8b 55 08             	mov    0x8(%ebp),%edx
  80114b:	88 10                	mov    %dl,(%eax)
}
  80114d:	90                   	nop
  80114e:	5d                   	pop    %ebp
  80114f:	c3                   	ret    

00801150 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
  801153:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80115c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	01 d0                	add    %edx,%eax
  801167:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80116a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801171:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801175:	74 06                	je     80117d <vsnprintf+0x2d>
  801177:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80117b:	7f 07                	jg     801184 <vsnprintf+0x34>
		return -E_INVAL;
  80117d:	b8 03 00 00 00       	mov    $0x3,%eax
  801182:	eb 20                	jmp    8011a4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801184:	ff 75 14             	pushl  0x14(%ebp)
  801187:	ff 75 10             	pushl  0x10(%ebp)
  80118a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80118d:	50                   	push   %eax
  80118e:	68 1a 11 80 00       	push   $0x80111a
  801193:	e8 80 fb ff ff       	call   800d18 <vprintfmt>
  801198:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80119b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80119e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011a4:	c9                   	leave  
  8011a5:	c3                   	ret    

008011a6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
  8011a9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011ac:	8d 45 10             	lea    0x10(%ebp),%eax
  8011af:	83 c0 04             	add    $0x4,%eax
  8011b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8011bb:	50                   	push   %eax
  8011bc:	ff 75 0c             	pushl  0xc(%ebp)
  8011bf:	ff 75 08             	pushl  0x8(%ebp)
  8011c2:	e8 89 ff ff ff       	call   801150 <vsnprintf>
  8011c7:	83 c4 10             	add    $0x10,%esp
  8011ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011d0:	c9                   	leave  
  8011d1:	c3                   	ret    

008011d2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011d2:	55                   	push   %ebp
  8011d3:	89 e5                	mov    %esp,%ebp
  8011d5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8011d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011df:	eb 06                	jmp    8011e7 <strlen+0x15>
		n++;
  8011e1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8011e4:	ff 45 08             	incl   0x8(%ebp)
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	84 c0                	test   %al,%al
  8011ee:	75 f1                	jne    8011e1 <strlen+0xf>
		n++;
	return n;
  8011f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
  8011f8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801202:	eb 09                	jmp    80120d <strnlen+0x18>
		n++;
  801204:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801207:	ff 45 08             	incl   0x8(%ebp)
  80120a:	ff 4d 0c             	decl   0xc(%ebp)
  80120d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801211:	74 09                	je     80121c <strnlen+0x27>
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	84 c0                	test   %al,%al
  80121a:	75 e8                	jne    801204 <strnlen+0xf>
		n++;
	return n;
  80121c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
  801224:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80122d:	90                   	nop
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8d 50 01             	lea    0x1(%eax),%edx
  801234:	89 55 08             	mov    %edx,0x8(%ebp)
  801237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801240:	8a 12                	mov    (%edx),%dl
  801242:	88 10                	mov    %dl,(%eax)
  801244:	8a 00                	mov    (%eax),%al
  801246:	84 c0                	test   %al,%al
  801248:	75 e4                	jne    80122e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80124d:	c9                   	leave  
  80124e:	c3                   	ret    

0080124f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80124f:	55                   	push   %ebp
  801250:	89 e5                	mov    %esp,%ebp
  801252:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80125b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801262:	eb 1f                	jmp    801283 <strncpy+0x34>
		*dst++ = *src;
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8d 50 01             	lea    0x1(%eax),%edx
  80126a:	89 55 08             	mov    %edx,0x8(%ebp)
  80126d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801270:	8a 12                	mov    (%edx),%dl
  801272:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	84 c0                	test   %al,%al
  80127b:	74 03                	je     801280 <strncpy+0x31>
			src++;
  80127d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801280:	ff 45 fc             	incl   -0x4(%ebp)
  801283:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801286:	3b 45 10             	cmp    0x10(%ebp),%eax
  801289:	72 d9                	jb     801264 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80128b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80129c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012a0:	74 30                	je     8012d2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012a2:	eb 16                	jmp    8012ba <strlcpy+0x2a>
			*dst++ = *src++;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8d 50 01             	lea    0x1(%eax),%edx
  8012aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012b6:	8a 12                	mov    (%edx),%dl
  8012b8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012ba:	ff 4d 10             	decl   0x10(%ebp)
  8012bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012c1:	74 09                	je     8012cc <strlcpy+0x3c>
  8012c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	84 c0                	test   %al,%al
  8012ca:	75 d8                	jne    8012a4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8012d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d8:	29 c2                	sub    %eax,%edx
  8012da:	89 d0                	mov    %edx,%eax
}
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8012e1:	eb 06                	jmp    8012e9 <strcmp+0xb>
		p++, q++;
  8012e3:	ff 45 08             	incl   0x8(%ebp)
  8012e6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	84 c0                	test   %al,%al
  8012f0:	74 0e                	je     801300 <strcmp+0x22>
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	8a 10                	mov    (%eax),%dl
  8012f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	38 c2                	cmp    %al,%dl
  8012fe:	74 e3                	je     8012e3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	8a 00                	mov    (%eax),%al
  801305:	0f b6 d0             	movzbl %al,%edx
  801308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	0f b6 c0             	movzbl %al,%eax
  801310:	29 c2                	sub    %eax,%edx
  801312:	89 d0                	mov    %edx,%eax
}
  801314:	5d                   	pop    %ebp
  801315:	c3                   	ret    

00801316 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801319:	eb 09                	jmp    801324 <strncmp+0xe>
		n--, p++, q++;
  80131b:	ff 4d 10             	decl   0x10(%ebp)
  80131e:	ff 45 08             	incl   0x8(%ebp)
  801321:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801324:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801328:	74 17                	je     801341 <strncmp+0x2b>
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	84 c0                	test   %al,%al
  801331:	74 0e                	je     801341 <strncmp+0x2b>
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	8a 10                	mov    (%eax),%dl
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	38 c2                	cmp    %al,%dl
  80133f:	74 da                	je     80131b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801341:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801345:	75 07                	jne    80134e <strncmp+0x38>
		return 0;
  801347:	b8 00 00 00 00       	mov    $0x0,%eax
  80134c:	eb 14                	jmp    801362 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	0f b6 d0             	movzbl %al,%edx
  801356:	8b 45 0c             	mov    0xc(%ebp),%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	0f b6 c0             	movzbl %al,%eax
  80135e:	29 c2                	sub    %eax,%edx
  801360:	89 d0                	mov    %edx,%eax
}
  801362:	5d                   	pop    %ebp
  801363:	c3                   	ret    

00801364 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801364:	55                   	push   %ebp
  801365:	89 e5                	mov    %esp,%ebp
  801367:	83 ec 04             	sub    $0x4,%esp
  80136a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801370:	eb 12                	jmp    801384 <strchr+0x20>
		if (*s == c)
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80137a:	75 05                	jne    801381 <strchr+0x1d>
			return (char *) s;
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	eb 11                	jmp    801392 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801381:	ff 45 08             	incl   0x8(%ebp)
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	84 c0                	test   %al,%al
  80138b:	75 e5                	jne    801372 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80138d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
  801397:	83 ec 04             	sub    $0x4,%esp
  80139a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013a0:	eb 0d                	jmp    8013af <strfind+0x1b>
		if (*s == c)
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013aa:	74 0e                	je     8013ba <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013ac:	ff 45 08             	incl   0x8(%ebp)
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	8a 00                	mov    (%eax),%al
  8013b4:	84 c0                	test   %al,%al
  8013b6:	75 ea                	jne    8013a2 <strfind+0xe>
  8013b8:	eb 01                	jmp    8013bb <strfind+0x27>
		if (*s == c)
			break;
  8013ba:	90                   	nop
	return (char *) s;
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
  8013c3:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8013cc:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8013d0:	76 63                	jbe    801435 <memset+0x75>
		uint64 data_block = c;
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	99                   	cltd   
  8013d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8013dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013e2:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8013e6:	c1 e0 08             	shl    $0x8,%eax
  8013e9:	09 45 f0             	or     %eax,-0x10(%ebp)
  8013ec:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8013ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f5:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8013f9:	c1 e0 10             	shl    $0x10,%eax
  8013fc:	09 45 f0             	or     %eax,-0x10(%ebp)
  8013ff:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801405:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801408:	89 c2                	mov    %eax,%edx
  80140a:	b8 00 00 00 00       	mov    $0x0,%eax
  80140f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801412:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801415:	eb 18                	jmp    80142f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801417:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80141a:	8d 41 08             	lea    0x8(%ecx),%eax
  80141d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801420:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801423:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801426:	89 01                	mov    %eax,(%ecx)
  801428:	89 51 04             	mov    %edx,0x4(%ecx)
  80142b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80142f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801433:	77 e2                	ja     801417 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801435:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801439:	74 23                	je     80145e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80143b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801441:	eb 0e                	jmp    801451 <memset+0x91>
			*p8++ = (uint8)c;
  801443:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801446:	8d 50 01             	lea    0x1(%eax),%edx
  801449:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80144c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801451:	8b 45 10             	mov    0x10(%ebp),%eax
  801454:	8d 50 ff             	lea    -0x1(%eax),%edx
  801457:	89 55 10             	mov    %edx,0x10(%ebp)
  80145a:	85 c0                	test   %eax,%eax
  80145c:	75 e5                	jne    801443 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
  801466:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801475:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801479:	76 24                	jbe    80149f <memcpy+0x3c>
		while(n >= 8){
  80147b:	eb 1c                	jmp    801499 <memcpy+0x36>
			*d64 = *s64;
  80147d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801480:	8b 50 04             	mov    0x4(%eax),%edx
  801483:	8b 00                	mov    (%eax),%eax
  801485:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801488:	89 01                	mov    %eax,(%ecx)
  80148a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80148d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801491:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801495:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801499:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80149d:	77 de                	ja     80147d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80149f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014a3:	74 31                	je     8014d6 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8014a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8014ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8014b1:	eb 16                	jmp    8014c9 <memcpy+0x66>
			*d8++ = *s8++;
  8014b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014b6:	8d 50 01             	lea    0x1(%eax),%edx
  8014b9:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8014bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014bf:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014c2:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8014c5:	8a 12                	mov    (%edx),%dl
  8014c7:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8014c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8014d2:	85 c0                	test   %eax,%eax
  8014d4:	75 dd                	jne    8014b3 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
  8014de:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014f3:	73 50                	jae    801545 <memmove+0x6a>
  8014f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fb:	01 d0                	add    %edx,%eax
  8014fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801500:	76 43                	jbe    801545 <memmove+0x6a>
		s += n;
  801502:	8b 45 10             	mov    0x10(%ebp),%eax
  801505:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801508:	8b 45 10             	mov    0x10(%ebp),%eax
  80150b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80150e:	eb 10                	jmp    801520 <memmove+0x45>
			*--d = *--s;
  801510:	ff 4d f8             	decl   -0x8(%ebp)
  801513:	ff 4d fc             	decl   -0x4(%ebp)
  801516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801519:	8a 10                	mov    (%eax),%dl
  80151b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801520:	8b 45 10             	mov    0x10(%ebp),%eax
  801523:	8d 50 ff             	lea    -0x1(%eax),%edx
  801526:	89 55 10             	mov    %edx,0x10(%ebp)
  801529:	85 c0                	test   %eax,%eax
  80152b:	75 e3                	jne    801510 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80152d:	eb 23                	jmp    801552 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80152f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801532:	8d 50 01             	lea    0x1(%eax),%edx
  801535:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801538:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80153b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80153e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801541:	8a 12                	mov    (%edx),%dl
  801543:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801545:	8b 45 10             	mov    0x10(%ebp),%eax
  801548:	8d 50 ff             	lea    -0x1(%eax),%edx
  80154b:	89 55 10             	mov    %edx,0x10(%ebp)
  80154e:	85 c0                	test   %eax,%eax
  801550:	75 dd                	jne    80152f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
  80155a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801563:	8b 45 0c             	mov    0xc(%ebp),%eax
  801566:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801569:	eb 2a                	jmp    801595 <memcmp+0x3e>
		if (*s1 != *s2)
  80156b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80156e:	8a 10                	mov    (%eax),%dl
  801570:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	38 c2                	cmp    %al,%dl
  801577:	74 16                	je     80158f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801579:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157c:	8a 00                	mov    (%eax),%al
  80157e:	0f b6 d0             	movzbl %al,%edx
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801584:	8a 00                	mov    (%eax),%al
  801586:	0f b6 c0             	movzbl %al,%eax
  801589:	29 c2                	sub    %eax,%edx
  80158b:	89 d0                	mov    %edx,%eax
  80158d:	eb 18                	jmp    8015a7 <memcmp+0x50>
		s1++, s2++;
  80158f:	ff 45 fc             	incl   -0x4(%ebp)
  801592:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801595:	8b 45 10             	mov    0x10(%ebp),%eax
  801598:	8d 50 ff             	lea    -0x1(%eax),%edx
  80159b:	89 55 10             	mov    %edx,0x10(%ebp)
  80159e:	85 c0                	test   %eax,%eax
  8015a0:	75 c9                	jne    80156b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015af:	8b 55 08             	mov    0x8(%ebp),%edx
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015ba:	eb 15                	jmp    8015d1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	0f b6 d0             	movzbl %al,%edx
  8015c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c7:	0f b6 c0             	movzbl %al,%eax
  8015ca:	39 c2                	cmp    %eax,%edx
  8015cc:	74 0d                	je     8015db <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015ce:	ff 45 08             	incl   0x8(%ebp)
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015d7:	72 e3                	jb     8015bc <memfind+0x13>
  8015d9:	eb 01                	jmp    8015dc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015db:	90                   	nop
	return (void *) s;
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
  8015e4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015f5:	eb 03                	jmp    8015fa <strtol+0x19>
		s++;
  8015f7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	3c 20                	cmp    $0x20,%al
  801601:	74 f4                	je     8015f7 <strtol+0x16>
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	8a 00                	mov    (%eax),%al
  801608:	3c 09                	cmp    $0x9,%al
  80160a:	74 eb                	je     8015f7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	8a 00                	mov    (%eax),%al
  801611:	3c 2b                	cmp    $0x2b,%al
  801613:	75 05                	jne    80161a <strtol+0x39>
		s++;
  801615:	ff 45 08             	incl   0x8(%ebp)
  801618:	eb 13                	jmp    80162d <strtol+0x4c>
	else if (*s == '-')
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	8a 00                	mov    (%eax),%al
  80161f:	3c 2d                	cmp    $0x2d,%al
  801621:	75 0a                	jne    80162d <strtol+0x4c>
		s++, neg = 1;
  801623:	ff 45 08             	incl   0x8(%ebp)
  801626:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80162d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801631:	74 06                	je     801639 <strtol+0x58>
  801633:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801637:	75 20                	jne    801659 <strtol+0x78>
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	3c 30                	cmp    $0x30,%al
  801640:	75 17                	jne    801659 <strtol+0x78>
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	40                   	inc    %eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	3c 78                	cmp    $0x78,%al
  80164a:	75 0d                	jne    801659 <strtol+0x78>
		s += 2, base = 16;
  80164c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801650:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801657:	eb 28                	jmp    801681 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801659:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80165d:	75 15                	jne    801674 <strtol+0x93>
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 30                	cmp    $0x30,%al
  801666:	75 0c                	jne    801674 <strtol+0x93>
		s++, base = 8;
  801668:	ff 45 08             	incl   0x8(%ebp)
  80166b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801672:	eb 0d                	jmp    801681 <strtol+0xa0>
	else if (base == 0)
  801674:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801678:	75 07                	jne    801681 <strtol+0xa0>
		base = 10;
  80167a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
  801684:	8a 00                	mov    (%eax),%al
  801686:	3c 2f                	cmp    $0x2f,%al
  801688:	7e 19                	jle    8016a3 <strtol+0xc2>
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	8a 00                	mov    (%eax),%al
  80168f:	3c 39                	cmp    $0x39,%al
  801691:	7f 10                	jg     8016a3 <strtol+0xc2>
			dig = *s - '0';
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	0f be c0             	movsbl %al,%eax
  80169b:	83 e8 30             	sub    $0x30,%eax
  80169e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016a1:	eb 42                	jmp    8016e5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	8a 00                	mov    (%eax),%al
  8016a8:	3c 60                	cmp    $0x60,%al
  8016aa:	7e 19                	jle    8016c5 <strtol+0xe4>
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	3c 7a                	cmp    $0x7a,%al
  8016b3:	7f 10                	jg     8016c5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	0f be c0             	movsbl %al,%eax
  8016bd:	83 e8 57             	sub    $0x57,%eax
  8016c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016c3:	eb 20                	jmp    8016e5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	8a 00                	mov    (%eax),%al
  8016ca:	3c 40                	cmp    $0x40,%al
  8016cc:	7e 39                	jle    801707 <strtol+0x126>
  8016ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d1:	8a 00                	mov    (%eax),%al
  8016d3:	3c 5a                	cmp    $0x5a,%al
  8016d5:	7f 30                	jg     801707 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8a 00                	mov    (%eax),%al
  8016dc:	0f be c0             	movsbl %al,%eax
  8016df:	83 e8 37             	sub    $0x37,%eax
  8016e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016eb:	7d 19                	jge    801706 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016ed:	ff 45 08             	incl   0x8(%ebp)
  8016f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016f7:	89 c2                	mov    %eax,%edx
  8016f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016fc:	01 d0                	add    %edx,%eax
  8016fe:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801701:	e9 7b ff ff ff       	jmp    801681 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801706:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801707:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80170b:	74 08                	je     801715 <strtol+0x134>
		*endptr = (char *) s;
  80170d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801710:	8b 55 08             	mov    0x8(%ebp),%edx
  801713:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801715:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801719:	74 07                	je     801722 <strtol+0x141>
  80171b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171e:	f7 d8                	neg    %eax
  801720:	eb 03                	jmp    801725 <strtol+0x144>
  801722:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <ltostr>:

void
ltostr(long value, char *str)
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
  80172a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80172d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801734:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80173b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80173f:	79 13                	jns    801754 <ltostr+0x2d>
	{
		neg = 1;
  801741:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801748:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80174e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801751:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80175c:	99                   	cltd   
  80175d:	f7 f9                	idiv   %ecx
  80175f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801765:	8d 50 01             	lea    0x1(%eax),%edx
  801768:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80176b:	89 c2                	mov    %eax,%edx
  80176d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801770:	01 d0                	add    %edx,%eax
  801772:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801775:	83 c2 30             	add    $0x30,%edx
  801778:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80177a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80177d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801782:	f7 e9                	imul   %ecx
  801784:	c1 fa 02             	sar    $0x2,%edx
  801787:	89 c8                	mov    %ecx,%eax
  801789:	c1 f8 1f             	sar    $0x1f,%eax
  80178c:	29 c2                	sub    %eax,%edx
  80178e:	89 d0                	mov    %edx,%eax
  801790:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801793:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801797:	75 bb                	jne    801754 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801799:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a3:	48                   	dec    %eax
  8017a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017ab:	74 3d                	je     8017ea <ltostr+0xc3>
		start = 1 ;
  8017ad:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017b4:	eb 34                	jmp    8017ea <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8017b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bc:	01 d0                	add    %edx,%eax
  8017be:	8a 00                	mov    (%eax),%al
  8017c0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c9:	01 c2                	add    %eax,%edx
  8017cb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d1:	01 c8                	add    %ecx,%eax
  8017d3:	8a 00                	mov    (%eax),%al
  8017d5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017dd:	01 c2                	add    %eax,%edx
  8017df:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017e2:	88 02                	mov    %al,(%edx)
		start++ ;
  8017e4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017e7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017f0:	7c c4                	jl     8017b6 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f8:	01 d0                	add    %edx,%eax
  8017fa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017fd:	90                   	nop
  8017fe:	c9                   	leave  
  8017ff:	c3                   	ret    

00801800 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801800:	55                   	push   %ebp
  801801:	89 e5                	mov    %esp,%ebp
  801803:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801806:	ff 75 08             	pushl  0x8(%ebp)
  801809:	e8 c4 f9 ff ff       	call   8011d2 <strlen>
  80180e:	83 c4 04             	add    $0x4,%esp
  801811:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801814:	ff 75 0c             	pushl  0xc(%ebp)
  801817:	e8 b6 f9 ff ff       	call   8011d2 <strlen>
  80181c:	83 c4 04             	add    $0x4,%esp
  80181f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801822:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801829:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801830:	eb 17                	jmp    801849 <strcconcat+0x49>
		final[s] = str1[s] ;
  801832:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801835:	8b 45 10             	mov    0x10(%ebp),%eax
  801838:	01 c2                	add    %eax,%edx
  80183a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	01 c8                	add    %ecx,%eax
  801842:	8a 00                	mov    (%eax),%al
  801844:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801846:	ff 45 fc             	incl   -0x4(%ebp)
  801849:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80184c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80184f:	7c e1                	jl     801832 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801851:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801858:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80185f:	eb 1f                	jmp    801880 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801861:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801864:	8d 50 01             	lea    0x1(%eax),%edx
  801867:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80186a:	89 c2                	mov    %eax,%edx
  80186c:	8b 45 10             	mov    0x10(%ebp),%eax
  80186f:	01 c2                	add    %eax,%edx
  801871:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801874:	8b 45 0c             	mov    0xc(%ebp),%eax
  801877:	01 c8                	add    %ecx,%eax
  801879:	8a 00                	mov    (%eax),%al
  80187b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80187d:	ff 45 f8             	incl   -0x8(%ebp)
  801880:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801883:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801886:	7c d9                	jl     801861 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801888:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80188b:	8b 45 10             	mov    0x10(%ebp),%eax
  80188e:	01 d0                	add    %edx,%eax
  801890:	c6 00 00             	movb   $0x0,(%eax)
}
  801893:	90                   	nop
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801899:	8b 45 14             	mov    0x14(%ebp),%eax
  80189c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a5:	8b 00                	mov    (%eax),%eax
  8018a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b1:	01 d0                	add    %edx,%eax
  8018b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b9:	eb 0c                	jmp    8018c7 <strsplit+0x31>
			*string++ = 0;
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	8d 50 01             	lea    0x1(%eax),%edx
  8018c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8018c4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	8a 00                	mov    (%eax),%al
  8018cc:	84 c0                	test   %al,%al
  8018ce:	74 18                	je     8018e8 <strsplit+0x52>
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	0f be c0             	movsbl %al,%eax
  8018d8:	50                   	push   %eax
  8018d9:	ff 75 0c             	pushl  0xc(%ebp)
  8018dc:	e8 83 fa ff ff       	call   801364 <strchr>
  8018e1:	83 c4 08             	add    $0x8,%esp
  8018e4:	85 c0                	test   %eax,%eax
  8018e6:	75 d3                	jne    8018bb <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	8a 00                	mov    (%eax),%al
  8018ed:	84 c0                	test   %al,%al
  8018ef:	74 5a                	je     80194b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f4:	8b 00                	mov    (%eax),%eax
  8018f6:	83 f8 0f             	cmp    $0xf,%eax
  8018f9:	75 07                	jne    801902 <strsplit+0x6c>
		{
			return 0;
  8018fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801900:	eb 66                	jmp    801968 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801902:	8b 45 14             	mov    0x14(%ebp),%eax
  801905:	8b 00                	mov    (%eax),%eax
  801907:	8d 48 01             	lea    0x1(%eax),%ecx
  80190a:	8b 55 14             	mov    0x14(%ebp),%edx
  80190d:	89 0a                	mov    %ecx,(%edx)
  80190f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801916:	8b 45 10             	mov    0x10(%ebp),%eax
  801919:	01 c2                	add    %eax,%edx
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801920:	eb 03                	jmp    801925 <strsplit+0x8f>
			string++;
  801922:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	8a 00                	mov    (%eax),%al
  80192a:	84 c0                	test   %al,%al
  80192c:	74 8b                	je     8018b9 <strsplit+0x23>
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	8a 00                	mov    (%eax),%al
  801933:	0f be c0             	movsbl %al,%eax
  801936:	50                   	push   %eax
  801937:	ff 75 0c             	pushl  0xc(%ebp)
  80193a:	e8 25 fa ff ff       	call   801364 <strchr>
  80193f:	83 c4 08             	add    $0x8,%esp
  801942:	85 c0                	test   %eax,%eax
  801944:	74 dc                	je     801922 <strsplit+0x8c>
			string++;
	}
  801946:	e9 6e ff ff ff       	jmp    8018b9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80194b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80194c:	8b 45 14             	mov    0x14(%ebp),%eax
  80194f:	8b 00                	mov    (%eax),%eax
  801951:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801958:	8b 45 10             	mov    0x10(%ebp),%eax
  80195b:	01 d0                	add    %edx,%eax
  80195d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801963:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
  80196d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801976:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80197d:	eb 4a                	jmp    8019c9 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80197f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	01 c2                	add    %eax,%edx
  801987:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80198a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198d:	01 c8                	add    %ecx,%eax
  80198f:	8a 00                	mov    (%eax),%al
  801991:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801993:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801996:	8b 45 0c             	mov    0xc(%ebp),%eax
  801999:	01 d0                	add    %edx,%eax
  80199b:	8a 00                	mov    (%eax),%al
  80199d:	3c 40                	cmp    $0x40,%al
  80199f:	7e 25                	jle    8019c6 <str2lower+0x5c>
  8019a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a7:	01 d0                	add    %edx,%eax
  8019a9:	8a 00                	mov    (%eax),%al
  8019ab:	3c 5a                	cmp    $0x5a,%al
  8019ad:	7f 17                	jg     8019c6 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8019af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8019bd:	01 ca                	add    %ecx,%edx
  8019bf:	8a 12                	mov    (%edx),%dl
  8019c1:	83 c2 20             	add    $0x20,%edx
  8019c4:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8019c6:	ff 45 fc             	incl   -0x4(%ebp)
  8019c9:	ff 75 0c             	pushl  0xc(%ebp)
  8019cc:	e8 01 f8 ff ff       	call   8011d2 <strlen>
  8019d1:	83 c4 04             	add    $0x4,%esp
  8019d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019d7:	7f a6                	jg     80197f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8019d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
  8019e1:	57                   	push   %edi
  8019e2:	56                   	push   %esi
  8019e3:	53                   	push   %ebx
  8019e4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019f0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019f3:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019f6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019f9:	cd 30                	int    $0x30
  8019fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a01:	83 c4 10             	add    $0x10,%esp
  801a04:	5b                   	pop    %ebx
  801a05:	5e                   	pop    %esi
  801a06:	5f                   	pop    %edi
  801a07:	5d                   	pop    %ebp
  801a08:	c3                   	ret    

00801a09 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
  801a0c:	83 ec 04             	sub    $0x4,%esp
  801a0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801a15:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a18:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1f:	6a 00                	push   $0x0
  801a21:	51                   	push   %ecx
  801a22:	52                   	push   %edx
  801a23:	ff 75 0c             	pushl  0xc(%ebp)
  801a26:	50                   	push   %eax
  801a27:	6a 00                	push   $0x0
  801a29:	e8 b0 ff ff ff       	call   8019de <syscall>
  801a2e:	83 c4 18             	add    $0x18,%esp
}
  801a31:	90                   	nop
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 02                	push   $0x2
  801a43:	e8 96 ff ff ff       	call   8019de <syscall>
  801a48:	83 c4 18             	add    $0x18,%esp
}
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <sys_lock_cons>:

void sys_lock_cons(void)
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 03                	push   $0x3
  801a5c:	e8 7d ff ff ff       	call   8019de <syscall>
  801a61:	83 c4 18             	add    $0x18,%esp
}
  801a64:	90                   	nop
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 04                	push   $0x4
  801a76:	e8 63 ff ff ff       	call   8019de <syscall>
  801a7b:	83 c4 18             	add    $0x18,%esp
}
  801a7e:	90                   	nop
  801a7f:	c9                   	leave  
  801a80:	c3                   	ret    

00801a81 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a84:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a87:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	52                   	push   %edx
  801a91:	50                   	push   %eax
  801a92:	6a 08                	push   $0x8
  801a94:	e8 45 ff ff ff       	call   8019de <syscall>
  801a99:	83 c4 18             	add    $0x18,%esp
}
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
  801aa1:	56                   	push   %esi
  801aa2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801aa3:	8b 75 18             	mov    0x18(%ebp),%esi
  801aa6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aa9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab2:	56                   	push   %esi
  801ab3:	53                   	push   %ebx
  801ab4:	51                   	push   %ecx
  801ab5:	52                   	push   %edx
  801ab6:	50                   	push   %eax
  801ab7:	6a 09                	push   $0x9
  801ab9:	e8 20 ff ff ff       	call   8019de <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ac4:	5b                   	pop    %ebx
  801ac5:	5e                   	pop    %esi
  801ac6:	5d                   	pop    %ebp
  801ac7:	c3                   	ret    

00801ac8 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	ff 75 08             	pushl  0x8(%ebp)
  801ad6:	6a 0a                	push   $0xa
  801ad8:	e8 01 ff ff ff       	call   8019de <syscall>
  801add:	83 c4 18             	add    $0x18,%esp
}
  801ae0:	c9                   	leave  
  801ae1:	c3                   	ret    

00801ae2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ae2:	55                   	push   %ebp
  801ae3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	ff 75 0c             	pushl  0xc(%ebp)
  801aee:	ff 75 08             	pushl  0x8(%ebp)
  801af1:	6a 0b                	push   $0xb
  801af3:	e8 e6 fe ff ff       	call   8019de <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	c9                   	leave  
  801afc:	c3                   	ret    

00801afd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 0c                	push   $0xc
  801b0c:	e8 cd fe ff ff       	call   8019de <syscall>
  801b11:	83 c4 18             	add    $0x18,%esp
}
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 0d                	push   $0xd
  801b25:	e8 b4 fe ff ff       	call   8019de <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	c9                   	leave  
  801b2e:	c3                   	ret    

00801b2f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 0e                	push   $0xe
  801b3e:	e8 9b fe ff ff       	call   8019de <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 0f                	push   $0xf
  801b57:	e8 82 fe ff ff       	call   8019de <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	6a 00                	push   $0x0
  801b6c:	ff 75 08             	pushl  0x8(%ebp)
  801b6f:	6a 10                	push   $0x10
  801b71:	e8 68 fe ff ff       	call   8019de <syscall>
  801b76:	83 c4 18             	add    $0x18,%esp
}
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 11                	push   $0x11
  801b8a:	e8 4f fe ff ff       	call   8019de <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	90                   	nop
  801b93:	c9                   	leave  
  801b94:	c3                   	ret    

00801b95 <sys_cputc>:

void
sys_cputc(const char c)
{
  801b95:	55                   	push   %ebp
  801b96:	89 e5                	mov    %esp,%ebp
  801b98:	83 ec 04             	sub    $0x4,%esp
  801b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ba1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	50                   	push   %eax
  801bae:	6a 01                	push   $0x1
  801bb0:	e8 29 fe ff ff       	call   8019de <syscall>
  801bb5:	83 c4 18             	add    $0x18,%esp
}
  801bb8:	90                   	nop
  801bb9:	c9                   	leave  
  801bba:	c3                   	ret    

00801bbb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 14                	push   $0x14
  801bca:	e8 0f fe ff ff       	call   8019de <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
}
  801bd2:	90                   	nop
  801bd3:	c9                   	leave  
  801bd4:	c3                   	ret    

00801bd5 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	83 ec 04             	sub    $0x4,%esp
  801bdb:	8b 45 10             	mov    0x10(%ebp),%eax
  801bde:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801be1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801be4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801be8:	8b 45 08             	mov    0x8(%ebp),%eax
  801beb:	6a 00                	push   $0x0
  801bed:	51                   	push   %ecx
  801bee:	52                   	push   %edx
  801bef:	ff 75 0c             	pushl  0xc(%ebp)
  801bf2:	50                   	push   %eax
  801bf3:	6a 15                	push   $0x15
  801bf5:	e8 e4 fd ff ff       	call   8019de <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
}
  801bfd:	c9                   	leave  
  801bfe:	c3                   	ret    

00801bff <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801c02:	8b 55 10             	mov    0x10(%ebp),%edx
  801c05:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	52                   	push   %edx
  801c0d:	50                   	push   %eax
  801c0e:	ff 75 08             	pushl  0x8(%ebp)
  801c11:	6a 16                	push   $0x16
  801c13:	e8 c6 fd ff ff       	call   8019de <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
}
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c23:	8b 45 08             	mov    0x8(%ebp),%eax
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	52                   	push   %edx
  801c2d:	50                   	push   %eax
  801c2e:	6a 17                	push   $0x17
  801c30:	e8 a9 fd ff ff       	call   8019de <syscall>
  801c35:	83 c4 18             	add    $0x18,%esp
}
  801c38:	c9                   	leave  
  801c39:	c3                   	ret    

00801c3a <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801c3a:	55                   	push   %ebp
  801c3b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	52                   	push   %edx
  801c4a:	50                   	push   %eax
  801c4b:	6a 18                	push   $0x18
  801c4d:	e8 8c fd ff ff       	call   8019de <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
}
  801c55:	c9                   	leave  
  801c56:	c3                   	ret    

00801c57 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c57:	55                   	push   %ebp
  801c58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5d:	6a 00                	push   $0x0
  801c5f:	ff 75 14             	pushl  0x14(%ebp)
  801c62:	ff 75 10             	pushl  0x10(%ebp)
  801c65:	ff 75 0c             	pushl  0xc(%ebp)
  801c68:	50                   	push   %eax
  801c69:	6a 19                	push   $0x19
  801c6b:	e8 6e fd ff ff       	call   8019de <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c78:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	50                   	push   %eax
  801c84:	6a 1a                	push   $0x1a
  801c86:	e8 53 fd ff ff       	call   8019de <syscall>
  801c8b:	83 c4 18             	add    $0x18,%esp
}
  801c8e:	90                   	nop
  801c8f:	c9                   	leave  
  801c90:	c3                   	ret    

00801c91 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801c91:	55                   	push   %ebp
  801c92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801c94:	8b 45 08             	mov    0x8(%ebp),%eax
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	50                   	push   %eax
  801ca0:	6a 1b                	push   $0x1b
  801ca2:	e8 37 fd ff ff       	call   8019de <syscall>
  801ca7:	83 c4 18             	add    $0x18,%esp
}
  801caa:	c9                   	leave  
  801cab:	c3                   	ret    

00801cac <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cac:	55                   	push   %ebp
  801cad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 05                	push   $0x5
  801cbb:	e8 1e fd ff ff       	call   8019de <syscall>
  801cc0:	83 c4 18             	add    $0x18,%esp
}
  801cc3:	c9                   	leave  
  801cc4:	c3                   	ret    

00801cc5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 06                	push   $0x6
  801cd4:	e8 05 fd ff ff       	call   8019de <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
}
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 07                	push   $0x7
  801ced:	e8 ec fc ff ff       	call   8019de <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
}
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_exit_env>:


void sys_exit_env(void)
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 1c                	push   $0x1c
  801d06:	e8 d3 fc ff ff       	call   8019de <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	90                   	nop
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	ff 75 10             	pushl  0x10(%ebp)
  801d1b:	ff 75 0c             	pushl  0xc(%ebp)
  801d1e:	ff 75 08             	pushl  0x8(%ebp)
  801d21:	6a 13                	push   $0x13
  801d23:	e8 b6 fc ff ff       	call   8019de <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
	return ;
  801d2b:	90                   	nop
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_rcr2>:
uint32 sys_rcr2()
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 1e                	push   $0x1e
  801d3d:	e8 9c fc ff ff       	call   8019de <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
}
  801d45:	c9                   	leave  
  801d46:	c3                   	ret    

00801d47 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801d47:	55                   	push   %ebp
  801d48:	89 e5                	mov    %esp,%ebp
  801d4a:	83 ec 04             	sub    $0x4,%esp
  801d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d50:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d53:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	50                   	push   %eax
  801d60:	6a 1f                	push   $0x1f
  801d62:	e8 77 fc ff ff       	call   8019de <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6a:	90                   	nop
}
  801d6b:	c9                   	leave  
  801d6c:	c3                   	ret    

00801d6d <rsttst>:
void rsttst()
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 21                	push   $0x21
  801d7c:	e8 5d fc ff ff       	call   8019de <syscall>
  801d81:	83 c4 18             	add    $0x18,%esp
	return ;
  801d84:	90                   	nop
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
  801d8a:	83 ec 04             	sub    $0x4,%esp
  801d8d:	8b 45 14             	mov    0x14(%ebp),%eax
  801d90:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d93:	8b 55 18             	mov    0x18(%ebp),%edx
  801d96:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d9a:	52                   	push   %edx
  801d9b:	50                   	push   %eax
  801d9c:	ff 75 10             	pushl  0x10(%ebp)
  801d9f:	ff 75 0c             	pushl  0xc(%ebp)
  801da2:	ff 75 08             	pushl  0x8(%ebp)
  801da5:	6a 20                	push   $0x20
  801da7:	e8 32 fc ff ff       	call   8019de <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
	return ;
  801daf:	90                   	nop
}
  801db0:	c9                   	leave  
  801db1:	c3                   	ret    

00801db2 <chktst>:
void chktst(uint32 n)
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	ff 75 08             	pushl  0x8(%ebp)
  801dc0:	6a 22                	push   $0x22
  801dc2:	e8 17 fc ff ff       	call   8019de <syscall>
  801dc7:	83 c4 18             	add    $0x18,%esp
	return ;
  801dca:	90                   	nop
}
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <inctst>:

void inctst()
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 23                	push   $0x23
  801ddc:	e8 fd fb ff ff       	call   8019de <syscall>
  801de1:	83 c4 18             	add    $0x18,%esp
	return ;
  801de4:	90                   	nop
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <gettst>:
uint32 gettst()
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 24                	push   $0x24
  801df6:	e8 e3 fb ff ff       	call   8019de <syscall>
  801dfb:	83 c4 18             	add    $0x18,%esp
}
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 25                	push   $0x25
  801e0f:	e8 ca fb ff ff       	call   8019de <syscall>
  801e14:	83 c4 18             	add    $0x18,%esp
  801e17:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801e1c:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801e26:	8b 45 08             	mov    0x8(%ebp),%eax
  801e29:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	ff 75 08             	pushl  0x8(%ebp)
  801e39:	6a 26                	push   $0x26
  801e3b:	e8 9e fb ff ff       	call   8019de <syscall>
  801e40:	83 c4 18             	add    $0x18,%esp
	return ;
  801e43:	90                   	nop
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
  801e49:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e4a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e4d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e53:	8b 45 08             	mov    0x8(%ebp),%eax
  801e56:	6a 00                	push   $0x0
  801e58:	53                   	push   %ebx
  801e59:	51                   	push   %ecx
  801e5a:	52                   	push   %edx
  801e5b:	50                   	push   %eax
  801e5c:	6a 27                	push   $0x27
  801e5e:	e8 7b fb ff ff       	call   8019de <syscall>
  801e63:	83 c4 18             	add    $0x18,%esp
}
  801e66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e71:	8b 45 08             	mov    0x8(%ebp),%eax
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	52                   	push   %edx
  801e7b:	50                   	push   %eax
  801e7c:	6a 28                	push   $0x28
  801e7e:	e8 5b fb ff ff       	call   8019de <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
}
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801e8b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	6a 00                	push   $0x0
  801e96:	51                   	push   %ecx
  801e97:	ff 75 10             	pushl  0x10(%ebp)
  801e9a:	52                   	push   %edx
  801e9b:	50                   	push   %eax
  801e9c:	6a 29                	push   $0x29
  801e9e:	e8 3b fb ff ff       	call   8019de <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	ff 75 10             	pushl  0x10(%ebp)
  801eb2:	ff 75 0c             	pushl  0xc(%ebp)
  801eb5:	ff 75 08             	pushl  0x8(%ebp)
  801eb8:	6a 12                	push   $0x12
  801eba:	e8 1f fb ff ff       	call   8019de <syscall>
  801ebf:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec2:	90                   	nop
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801ec8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	52                   	push   %edx
  801ed5:	50                   	push   %eax
  801ed6:	6a 2a                	push   $0x2a
  801ed8:	e8 01 fb ff ff       	call   8019de <syscall>
  801edd:	83 c4 18             	add    $0x18,%esp
	return;
  801ee0:	90                   	nop
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 2b                	push   $0x2b
  801ef2:	e8 e7 fa ff ff       	call   8019de <syscall>
  801ef7:	83 c4 18             	add    $0x18,%esp
}
  801efa:	c9                   	leave  
  801efb:	c3                   	ret    

00801efc <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801efc:	55                   	push   %ebp
  801efd:	89 e5                	mov    %esp,%ebp
  801eff:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801f02:	83 ec 04             	sub    $0x4,%esp
  801f05:	68 88 2a 80 00       	push   $0x802a88
  801f0a:	68 0a 01 00 00       	push   $0x10a
  801f0f:	68 98 2a 80 00       	push   $0x802a98
  801f14:	e8 12 e9 ff ff       	call   80082b <_panic>

00801f19 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801f19:	55                   	push   %ebp
  801f1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	ff 75 0c             	pushl  0xc(%ebp)
  801f25:	ff 75 08             	pushl  0x8(%ebp)
  801f28:	6a 33                	push   $0x33
  801f2a:	e8 af fa ff ff       	call   8019de <syscall>
  801f2f:	83 c4 18             	add    $0x18,%esp
	return;
  801f32:	90                   	nop
}
  801f33:	c9                   	leave  
  801f34:	c3                   	ret    

00801f35 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	ff 75 0c             	pushl  0xc(%ebp)
  801f41:	ff 75 08             	pushl  0x8(%ebp)
  801f44:	6a 34                	push   $0x34
  801f46:	e8 93 fa ff ff       	call   8019de <syscall>
  801f4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4e:	90                   	nop
}
  801f4f:	c9                   	leave  
  801f50:	c3                   	ret    
  801f51:	66 90                	xchg   %ax,%ax
  801f53:	90                   	nop

00801f54 <__udivdi3>:
  801f54:	55                   	push   %ebp
  801f55:	57                   	push   %edi
  801f56:	56                   	push   %esi
  801f57:	53                   	push   %ebx
  801f58:	83 ec 1c             	sub    $0x1c,%esp
  801f5b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f5f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f67:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f6b:	89 ca                	mov    %ecx,%edx
  801f6d:	89 f8                	mov    %edi,%eax
  801f6f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f73:	85 f6                	test   %esi,%esi
  801f75:	75 2d                	jne    801fa4 <__udivdi3+0x50>
  801f77:	39 cf                	cmp    %ecx,%edi
  801f79:	77 65                	ja     801fe0 <__udivdi3+0x8c>
  801f7b:	89 fd                	mov    %edi,%ebp
  801f7d:	85 ff                	test   %edi,%edi
  801f7f:	75 0b                	jne    801f8c <__udivdi3+0x38>
  801f81:	b8 01 00 00 00       	mov    $0x1,%eax
  801f86:	31 d2                	xor    %edx,%edx
  801f88:	f7 f7                	div    %edi
  801f8a:	89 c5                	mov    %eax,%ebp
  801f8c:	31 d2                	xor    %edx,%edx
  801f8e:	89 c8                	mov    %ecx,%eax
  801f90:	f7 f5                	div    %ebp
  801f92:	89 c1                	mov    %eax,%ecx
  801f94:	89 d8                	mov    %ebx,%eax
  801f96:	f7 f5                	div    %ebp
  801f98:	89 cf                	mov    %ecx,%edi
  801f9a:	89 fa                	mov    %edi,%edx
  801f9c:	83 c4 1c             	add    $0x1c,%esp
  801f9f:	5b                   	pop    %ebx
  801fa0:	5e                   	pop    %esi
  801fa1:	5f                   	pop    %edi
  801fa2:	5d                   	pop    %ebp
  801fa3:	c3                   	ret    
  801fa4:	39 ce                	cmp    %ecx,%esi
  801fa6:	77 28                	ja     801fd0 <__udivdi3+0x7c>
  801fa8:	0f bd fe             	bsr    %esi,%edi
  801fab:	83 f7 1f             	xor    $0x1f,%edi
  801fae:	75 40                	jne    801ff0 <__udivdi3+0x9c>
  801fb0:	39 ce                	cmp    %ecx,%esi
  801fb2:	72 0a                	jb     801fbe <__udivdi3+0x6a>
  801fb4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fb8:	0f 87 9e 00 00 00    	ja     80205c <__udivdi3+0x108>
  801fbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc3:	89 fa                	mov    %edi,%edx
  801fc5:	83 c4 1c             	add    $0x1c,%esp
  801fc8:	5b                   	pop    %ebx
  801fc9:	5e                   	pop    %esi
  801fca:	5f                   	pop    %edi
  801fcb:	5d                   	pop    %ebp
  801fcc:	c3                   	ret    
  801fcd:	8d 76 00             	lea    0x0(%esi),%esi
  801fd0:	31 ff                	xor    %edi,%edi
  801fd2:	31 c0                	xor    %eax,%eax
  801fd4:	89 fa                	mov    %edi,%edx
  801fd6:	83 c4 1c             	add    $0x1c,%esp
  801fd9:	5b                   	pop    %ebx
  801fda:	5e                   	pop    %esi
  801fdb:	5f                   	pop    %edi
  801fdc:	5d                   	pop    %ebp
  801fdd:	c3                   	ret    
  801fde:	66 90                	xchg   %ax,%ax
  801fe0:	89 d8                	mov    %ebx,%eax
  801fe2:	f7 f7                	div    %edi
  801fe4:	31 ff                	xor    %edi,%edi
  801fe6:	89 fa                	mov    %edi,%edx
  801fe8:	83 c4 1c             	add    $0x1c,%esp
  801feb:	5b                   	pop    %ebx
  801fec:	5e                   	pop    %esi
  801fed:	5f                   	pop    %edi
  801fee:	5d                   	pop    %ebp
  801fef:	c3                   	ret    
  801ff0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ff5:	89 eb                	mov    %ebp,%ebx
  801ff7:	29 fb                	sub    %edi,%ebx
  801ff9:	89 f9                	mov    %edi,%ecx
  801ffb:	d3 e6                	shl    %cl,%esi
  801ffd:	89 c5                	mov    %eax,%ebp
  801fff:	88 d9                	mov    %bl,%cl
  802001:	d3 ed                	shr    %cl,%ebp
  802003:	89 e9                	mov    %ebp,%ecx
  802005:	09 f1                	or     %esi,%ecx
  802007:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80200b:	89 f9                	mov    %edi,%ecx
  80200d:	d3 e0                	shl    %cl,%eax
  80200f:	89 c5                	mov    %eax,%ebp
  802011:	89 d6                	mov    %edx,%esi
  802013:	88 d9                	mov    %bl,%cl
  802015:	d3 ee                	shr    %cl,%esi
  802017:	89 f9                	mov    %edi,%ecx
  802019:	d3 e2                	shl    %cl,%edx
  80201b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80201f:	88 d9                	mov    %bl,%cl
  802021:	d3 e8                	shr    %cl,%eax
  802023:	09 c2                	or     %eax,%edx
  802025:	89 d0                	mov    %edx,%eax
  802027:	89 f2                	mov    %esi,%edx
  802029:	f7 74 24 0c          	divl   0xc(%esp)
  80202d:	89 d6                	mov    %edx,%esi
  80202f:	89 c3                	mov    %eax,%ebx
  802031:	f7 e5                	mul    %ebp
  802033:	39 d6                	cmp    %edx,%esi
  802035:	72 19                	jb     802050 <__udivdi3+0xfc>
  802037:	74 0b                	je     802044 <__udivdi3+0xf0>
  802039:	89 d8                	mov    %ebx,%eax
  80203b:	31 ff                	xor    %edi,%edi
  80203d:	e9 58 ff ff ff       	jmp    801f9a <__udivdi3+0x46>
  802042:	66 90                	xchg   %ax,%ax
  802044:	8b 54 24 08          	mov    0x8(%esp),%edx
  802048:	89 f9                	mov    %edi,%ecx
  80204a:	d3 e2                	shl    %cl,%edx
  80204c:	39 c2                	cmp    %eax,%edx
  80204e:	73 e9                	jae    802039 <__udivdi3+0xe5>
  802050:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802053:	31 ff                	xor    %edi,%edi
  802055:	e9 40 ff ff ff       	jmp    801f9a <__udivdi3+0x46>
  80205a:	66 90                	xchg   %ax,%ax
  80205c:	31 c0                	xor    %eax,%eax
  80205e:	e9 37 ff ff ff       	jmp    801f9a <__udivdi3+0x46>
  802063:	90                   	nop

00802064 <__umoddi3>:
  802064:	55                   	push   %ebp
  802065:	57                   	push   %edi
  802066:	56                   	push   %esi
  802067:	53                   	push   %ebx
  802068:	83 ec 1c             	sub    $0x1c,%esp
  80206b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80206f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802073:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802077:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80207b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80207f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802083:	89 f3                	mov    %esi,%ebx
  802085:	89 fa                	mov    %edi,%edx
  802087:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80208b:	89 34 24             	mov    %esi,(%esp)
  80208e:	85 c0                	test   %eax,%eax
  802090:	75 1a                	jne    8020ac <__umoddi3+0x48>
  802092:	39 f7                	cmp    %esi,%edi
  802094:	0f 86 a2 00 00 00    	jbe    80213c <__umoddi3+0xd8>
  80209a:	89 c8                	mov    %ecx,%eax
  80209c:	89 f2                	mov    %esi,%edx
  80209e:	f7 f7                	div    %edi
  8020a0:	89 d0                	mov    %edx,%eax
  8020a2:	31 d2                	xor    %edx,%edx
  8020a4:	83 c4 1c             	add    $0x1c,%esp
  8020a7:	5b                   	pop    %ebx
  8020a8:	5e                   	pop    %esi
  8020a9:	5f                   	pop    %edi
  8020aa:	5d                   	pop    %ebp
  8020ab:	c3                   	ret    
  8020ac:	39 f0                	cmp    %esi,%eax
  8020ae:	0f 87 ac 00 00 00    	ja     802160 <__umoddi3+0xfc>
  8020b4:	0f bd e8             	bsr    %eax,%ebp
  8020b7:	83 f5 1f             	xor    $0x1f,%ebp
  8020ba:	0f 84 ac 00 00 00    	je     80216c <__umoddi3+0x108>
  8020c0:	bf 20 00 00 00       	mov    $0x20,%edi
  8020c5:	29 ef                	sub    %ebp,%edi
  8020c7:	89 fe                	mov    %edi,%esi
  8020c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020cd:	89 e9                	mov    %ebp,%ecx
  8020cf:	d3 e0                	shl    %cl,%eax
  8020d1:	89 d7                	mov    %edx,%edi
  8020d3:	89 f1                	mov    %esi,%ecx
  8020d5:	d3 ef                	shr    %cl,%edi
  8020d7:	09 c7                	or     %eax,%edi
  8020d9:	89 e9                	mov    %ebp,%ecx
  8020db:	d3 e2                	shl    %cl,%edx
  8020dd:	89 14 24             	mov    %edx,(%esp)
  8020e0:	89 d8                	mov    %ebx,%eax
  8020e2:	d3 e0                	shl    %cl,%eax
  8020e4:	89 c2                	mov    %eax,%edx
  8020e6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020ea:	d3 e0                	shl    %cl,%eax
  8020ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020f0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020f4:	89 f1                	mov    %esi,%ecx
  8020f6:	d3 e8                	shr    %cl,%eax
  8020f8:	09 d0                	or     %edx,%eax
  8020fa:	d3 eb                	shr    %cl,%ebx
  8020fc:	89 da                	mov    %ebx,%edx
  8020fe:	f7 f7                	div    %edi
  802100:	89 d3                	mov    %edx,%ebx
  802102:	f7 24 24             	mull   (%esp)
  802105:	89 c6                	mov    %eax,%esi
  802107:	89 d1                	mov    %edx,%ecx
  802109:	39 d3                	cmp    %edx,%ebx
  80210b:	0f 82 87 00 00 00    	jb     802198 <__umoddi3+0x134>
  802111:	0f 84 91 00 00 00    	je     8021a8 <__umoddi3+0x144>
  802117:	8b 54 24 04          	mov    0x4(%esp),%edx
  80211b:	29 f2                	sub    %esi,%edx
  80211d:	19 cb                	sbb    %ecx,%ebx
  80211f:	89 d8                	mov    %ebx,%eax
  802121:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802125:	d3 e0                	shl    %cl,%eax
  802127:	89 e9                	mov    %ebp,%ecx
  802129:	d3 ea                	shr    %cl,%edx
  80212b:	09 d0                	or     %edx,%eax
  80212d:	89 e9                	mov    %ebp,%ecx
  80212f:	d3 eb                	shr    %cl,%ebx
  802131:	89 da                	mov    %ebx,%edx
  802133:	83 c4 1c             	add    $0x1c,%esp
  802136:	5b                   	pop    %ebx
  802137:	5e                   	pop    %esi
  802138:	5f                   	pop    %edi
  802139:	5d                   	pop    %ebp
  80213a:	c3                   	ret    
  80213b:	90                   	nop
  80213c:	89 fd                	mov    %edi,%ebp
  80213e:	85 ff                	test   %edi,%edi
  802140:	75 0b                	jne    80214d <__umoddi3+0xe9>
  802142:	b8 01 00 00 00       	mov    $0x1,%eax
  802147:	31 d2                	xor    %edx,%edx
  802149:	f7 f7                	div    %edi
  80214b:	89 c5                	mov    %eax,%ebp
  80214d:	89 f0                	mov    %esi,%eax
  80214f:	31 d2                	xor    %edx,%edx
  802151:	f7 f5                	div    %ebp
  802153:	89 c8                	mov    %ecx,%eax
  802155:	f7 f5                	div    %ebp
  802157:	89 d0                	mov    %edx,%eax
  802159:	e9 44 ff ff ff       	jmp    8020a2 <__umoddi3+0x3e>
  80215e:	66 90                	xchg   %ax,%ax
  802160:	89 c8                	mov    %ecx,%eax
  802162:	89 f2                	mov    %esi,%edx
  802164:	83 c4 1c             	add    $0x1c,%esp
  802167:	5b                   	pop    %ebx
  802168:	5e                   	pop    %esi
  802169:	5f                   	pop    %edi
  80216a:	5d                   	pop    %ebp
  80216b:	c3                   	ret    
  80216c:	3b 04 24             	cmp    (%esp),%eax
  80216f:	72 06                	jb     802177 <__umoddi3+0x113>
  802171:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802175:	77 0f                	ja     802186 <__umoddi3+0x122>
  802177:	89 f2                	mov    %esi,%edx
  802179:	29 f9                	sub    %edi,%ecx
  80217b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80217f:	89 14 24             	mov    %edx,(%esp)
  802182:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802186:	8b 44 24 04          	mov    0x4(%esp),%eax
  80218a:	8b 14 24             	mov    (%esp),%edx
  80218d:	83 c4 1c             	add    $0x1c,%esp
  802190:	5b                   	pop    %ebx
  802191:	5e                   	pop    %esi
  802192:	5f                   	pop    %edi
  802193:	5d                   	pop    %ebp
  802194:	c3                   	ret    
  802195:	8d 76 00             	lea    0x0(%esi),%esi
  802198:	2b 04 24             	sub    (%esp),%eax
  80219b:	19 fa                	sbb    %edi,%edx
  80219d:	89 d1                	mov    %edx,%ecx
  80219f:	89 c6                	mov    %eax,%esi
  8021a1:	e9 71 ff ff ff       	jmp    802117 <__umoddi3+0xb3>
  8021a6:	66 90                	xchg   %ax,%ax
  8021a8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021ac:	72 ea                	jb     802198 <__umoddi3+0x134>
  8021ae:	89 d9                	mov    %ebx,%ecx
  8021b0:	e9 62 ff ff ff       	jmp    802117 <__umoddi3+0xb3>
