
obj/user/sc_qs_noleak:     file format elf32-i386


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
  800031:	e8 b1 05 00 00       	call   8005e7 <libmain>
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
		int NumOfElements = 200000 ;
  800041:	c7 45 f4 40 0d 03 00 	movl   $0x30d40,-0xc(%ebp)
		//2012: lock the interrupt
		sys_lock_cons();
  800048:	e8 44 1b 00 00       	call   801b91 <sys_lock_cons>
		{
			cprintf("\n");
  80004d:	83 ec 0c             	sub    $0xc,%esp
  800050:	68 00 24 80 00       	push   $0x802400
  800055:	e8 bb 0a 00 00       	call   800b15 <cprintf>
  80005a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  80005d:	83 ec 0c             	sub    $0xc,%esp
  800060:	68 02 24 80 00       	push   $0x802402
  800065:	e8 ab 0a 00 00       	call   800b15 <cprintf>
  80006a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   QUICK SORT    !!!\n");
  80006d:	83 ec 0c             	sub    $0xc,%esp
  800070:	68 1b 24 80 00       	push   $0x80241b
  800075:	e8 9b 0a 00 00       	call   800b15 <cprintf>
  80007a:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  80007d:	83 ec 0c             	sub    $0xc,%esp
  800080:	68 02 24 80 00       	push   $0x802402
  800085:	e8 8b 0a 00 00       	call   800b15 <cprintf>
  80008a:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  80008d:	83 ec 0c             	sub    $0xc,%esp
  800090:	68 00 24 80 00       	push   $0x802400
  800095:	e8 7b 0a 00 00       	call   800b15 <cprintf>
  80009a:	83 c4 10             	add    $0x10,%esp

			cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  80009d:	83 ec 08             	sub    $0x8,%esp
  8000a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8000a3:	68 34 24 80 00       	push   $0x802434
  8000a8:	e8 68 0a 00 00       	call   800b15 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp
			cprintf("Chose the initialization method:\n") ;
  8000b0:	83 ec 0c             	sub    $0xc,%esp
  8000b3:	68 58 24 80 00       	push   $0x802458
  8000b8:	e8 58 0a 00 00       	call   800b15 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	68 7a 24 80 00       	push   $0x80247a
  8000c8:	e8 48 0a 00 00       	call   800b15 <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 88 24 80 00       	push   $0x802488
  8000d8:	e8 38 0a 00 00       	call   800b15 <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	68 97 24 80 00       	push   $0x802497
  8000e8:	e8 28 0a 00 00       	call   800b15 <cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000f0:	83 ec 0c             	sub    $0xc,%esp
  8000f3:	68 a7 24 80 00       	push   $0x8024a7
  8000f8:	e8 18 0a 00 00       	call   800b15 <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
				Chose = 'c' ;
  800100:	c6 45 f3 63          	movb   $0x63,-0xd(%ebp)
				cputchar(Chose);
  800104:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 94 04 00 00       	call   8005a5 <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 87 04 00 00       	call   8005a5 <cputchar>
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
  800133:	e8 73 1a 00 00       	call   801bab <sys_unlock_cons>

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800138:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80013b:	c1 e0 02             	shl    $0x2,%eax
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	50                   	push   %eax
  800142:	e8 26 19 00 00       	call   801a6d <malloc>
  800147:	83 c4 10             	add    $0x10,%esp
  80014a:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int  i ;
		switch (Chose)
  80014d:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
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
  800163:	ff 75 f4             	pushl  -0xc(%ebp)
  800166:	ff 75 ec             	pushl  -0x14(%ebp)
  800169:	e8 f2 02 00 00       	call   800460 <InitializeAscending>
  80016e:	83 c4 10             	add    $0x10,%esp
			break ;
  800171:	eb 37                	jmp    8001aa <_main+0x172>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	ff 75 f4             	pushl  -0xc(%ebp)
  800179:	ff 75 ec             	pushl  -0x14(%ebp)
  80017c:	e8 10 03 00 00       	call   800491 <InitializeIdentical>
  800181:	83 c4 10             	add    $0x10,%esp
			break ;
  800184:	eb 24                	jmp    8001aa <_main+0x172>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 f4             	pushl  -0xc(%ebp)
  80018c:	ff 75 ec             	pushl  -0x14(%ebp)
  80018f:	e8 32 03 00 00       	call   8004c6 <InitializeSemiRandom>
  800194:	83 c4 10             	add    $0x10,%esp
			break ;
  800197:	eb 11                	jmp    8001aa <_main+0x172>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800199:	83 ec 08             	sub    $0x8,%esp
  80019c:	ff 75 f4             	pushl  -0xc(%ebp)
  80019f:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a2:	e8 1f 03 00 00       	call   8004c6 <InitializeSemiRandom>
  8001a7:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001aa:	83 ec 08             	sub    $0x8,%esp
  8001ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b3:	e8 ed 00 00 00       	call   8002a5 <QuickSort>
  8001b8:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001bb:	e8 d1 19 00 00       	call   801b91 <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001c0:	83 ec 0c             	sub    $0xc,%esp
  8001c3:	68 b0 24 80 00       	push   $0x8024b0
  8001c8:	e8 48 09 00 00       	call   800b15 <cprintf>
  8001cd:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8001d0:	e8 d6 19 00 00       	call   801bab <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d5:	83 ec 08             	sub    $0x8,%esp
  8001d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8001db:	ff 75 ec             	pushl  -0x14(%ebp)
  8001de:	e8 d3 01 00 00       	call   8003b6 <CheckSorted>
  8001e3:	83 c4 10             	add    $0x10,%esp
  8001e6:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ed:	75 14                	jne    800203 <_main+0x1cb>
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	68 e4 24 80 00       	push   $0x8024e4
  8001f7:	6a 4c                	push   $0x4c
  8001f9:	68 06 25 80 00       	push   $0x802506
  8001fe:	e8 44 06 00 00       	call   800847 <_panic>
		else
		{
			sys_lock_cons();
  800203:	e8 89 19 00 00       	call   801b91 <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  800208:	83 ec 0c             	sub    $0xc,%esp
  80020b:	68 1c 25 80 00       	push   $0x80251c
  800210:	e8 00 09 00 00       	call   800b15 <cprintf>
  800215:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 50 25 80 00       	push   $0x802550
  800220:	e8 f0 08 00 00       	call   800b15 <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 84 25 80 00       	push   $0x802584
  800230:	e8 e0 08 00 00       	call   800b15 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  800238:	e8 6e 19 00 00       	call   801bab <sys_unlock_cons>

		}

		free(Elements) ;
  80023d:	83 ec 0c             	sub    $0xc,%esp
  800240:	ff 75 ec             	pushl  -0x14(%ebp)
  800243:	e8 53 18 00 00       	call   801a9b <free>
  800248:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80024b:	e8 41 19 00 00       	call   801b91 <sys_lock_cons>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	68 b6 25 80 00       	push   $0x8025b6
  800258:	e8 b8 08 00 00       	call   800b15 <cprintf>
  80025d:	83 c4 10             	add    $0x10,%esp
			Chose = 'n' ;
  800260:	c6 45 f3 6e          	movb   $0x6e,-0xd(%ebp)
			cputchar(Chose);
  800264:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	50                   	push   %eax
  80026c:	e8 34 03 00 00       	call   8005a5 <cputchar>
  800271:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	6a 0a                	push   $0xa
  800279:	e8 27 03 00 00       	call   8005a5 <cputchar>
  80027e:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800281:	83 ec 0c             	sub    $0xc,%esp
  800284:	6a 0a                	push   $0xa
  800286:	e8 1a 03 00 00       	call   8005a5 <cputchar>
  80028b:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80028e:	e8 18 19 00 00       	call   801bab <sys_unlock_cons>

	} while (Chose == 'y');
  800293:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  800297:	0f 84 a4 fd ff ff    	je     800041 <_main+0x9>

	//To indicate that it's completed successfully
	inctst();
  80029d:	e8 6f 1c 00 00       	call   801f11 <inctst>
}
  8002a2:	90                   	nop
  8002a3:	c9                   	leave  
  8002a4:	c3                   	ret    

008002a5 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002a5:	55                   	push   %ebp
  8002a6:	89 e5                	mov    %esp,%ebp
  8002a8:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ae:	48                   	dec    %eax
  8002af:	50                   	push   %eax
  8002b0:	6a 00                	push   $0x0
  8002b2:	ff 75 0c             	pushl  0xc(%ebp)
  8002b5:	ff 75 08             	pushl  0x8(%ebp)
  8002b8:	e8 06 00 00 00       	call   8002c3 <QSort>
  8002bd:	83 c4 10             	add    $0x10,%esp
}
  8002c0:	90                   	nop
  8002c1:	c9                   	leave  
  8002c2:	c3                   	ret    

008002c3 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002c3:	55                   	push   %ebp
  8002c4:	89 e5                	mov    %esp,%ebp
  8002c6:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002cc:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002cf:	0f 8d de 00 00 00    	jge    8003b3 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d8:	40                   	inc    %eax
  8002d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8002df:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002e2:	e9 80 00 00 00       	jmp    800367 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002e7:	ff 45 f4             	incl   -0xc(%ebp)
  8002ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ed:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002f0:	7f 2b                	jg     80031d <QSort+0x5a>
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ff:	01 d0                	add    %edx,%eax
  800301:	8b 10                	mov    (%eax),%edx
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	01 c8                	add    %ecx,%eax
  800312:	8b 00                	mov    (%eax),%eax
  800314:	39 c2                	cmp    %eax,%edx
  800316:	7d cf                	jge    8002e7 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800318:	eb 03                	jmp    80031d <QSort+0x5a>
  80031a:	ff 4d f0             	decl   -0x10(%ebp)
  80031d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800320:	3b 45 10             	cmp    0x10(%ebp),%eax
  800323:	7e 26                	jle    80034b <QSort+0x88>
  800325:	8b 45 10             	mov    0x10(%ebp),%eax
  800328:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032f:	8b 45 08             	mov    0x8(%ebp),%eax
  800332:	01 d0                	add    %edx,%eax
  800334:	8b 10                	mov    (%eax),%edx
  800336:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800339:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800340:	8b 45 08             	mov    0x8(%ebp),%eax
  800343:	01 c8                	add    %ecx,%eax
  800345:	8b 00                	mov    (%eax),%eax
  800347:	39 c2                	cmp    %eax,%edx
  800349:	7e cf                	jle    80031a <QSort+0x57>

		if (i <= j)
  80034b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80034e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800351:	7f 14                	jg     800367 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	ff 75 f0             	pushl  -0x10(%ebp)
  800359:	ff 75 f4             	pushl  -0xc(%ebp)
  80035c:	ff 75 08             	pushl  0x8(%ebp)
  80035f:	e8 a9 00 00 00       	call   80040d <Swap>
  800364:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800367:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036d:	0f 8e 77 ff ff ff    	jle    8002ea <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800373:	83 ec 04             	sub    $0x4,%esp
  800376:	ff 75 f0             	pushl  -0x10(%ebp)
  800379:	ff 75 10             	pushl  0x10(%ebp)
  80037c:	ff 75 08             	pushl  0x8(%ebp)
  80037f:	e8 89 00 00 00       	call   80040d <Swap>
  800384:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800387:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038a:	48                   	dec    %eax
  80038b:	50                   	push   %eax
  80038c:	ff 75 10             	pushl  0x10(%ebp)
  80038f:	ff 75 0c             	pushl  0xc(%ebp)
  800392:	ff 75 08             	pushl  0x8(%ebp)
  800395:	e8 29 ff ff ff       	call   8002c3 <QSort>
  80039a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80039d:	ff 75 14             	pushl  0x14(%ebp)
  8003a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a3:	ff 75 0c             	pushl  0xc(%ebp)
  8003a6:	ff 75 08             	pushl  0x8(%ebp)
  8003a9:	e8 15 ff ff ff       	call   8002c3 <QSort>
  8003ae:	83 c4 10             	add    $0x10,%esp
  8003b1:	eb 01                	jmp    8003b4 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003b3:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003b4:	c9                   	leave  
  8003b5:	c3                   	ret    

008003b6 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003b6:	55                   	push   %ebp
  8003b7:	89 e5                	mov    %esp,%ebp
  8003b9:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003bc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003ca:	eb 33                	jmp    8003ff <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	01 d0                	add    %edx,%eax
  8003db:	8b 10                	mov    (%eax),%edx
  8003dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003e0:	40                   	inc    %eax
  8003e1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003eb:	01 c8                	add    %ecx,%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	39 c2                	cmp    %eax,%edx
  8003f1:	7e 09                	jle    8003fc <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003fa:	eb 0c                	jmp    800408 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003fc:	ff 45 f8             	incl   -0x8(%ebp)
  8003ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800402:	48                   	dec    %eax
  800403:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800406:	7f c4                	jg     8003cc <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800408:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80040b:	c9                   	leave  
  80040c:	c3                   	ret    

0080040d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80040d:	55                   	push   %ebp
  80040e:	89 e5                	mov    %esp,%ebp
  800410:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800413:	8b 45 0c             	mov    0xc(%ebp),%eax
  800416:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	01 d0                	add    %edx,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800431:	8b 45 08             	mov    0x8(%ebp),%eax
  800434:	01 c2                	add    %eax,%edx
  800436:	8b 45 10             	mov    0x10(%ebp),%eax
  800439:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	01 c8                	add    %ecx,%eax
  800445:	8b 00                	mov    (%eax),%eax
  800447:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800449:	8b 45 10             	mov    0x10(%ebp),%eax
  80044c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	01 c2                	add    %eax,%edx
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	89 02                	mov    %eax,(%edx)
}
  80045d:	90                   	nop
  80045e:	c9                   	leave  
  80045f:	c3                   	ret    

00800460 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800460:	55                   	push   %ebp
  800461:	89 e5                	mov    %esp,%ebp
  800463:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800466:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80046d:	eb 17                	jmp    800486 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80046f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800472:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	01 c2                	add    %eax,%edx
  80047e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800481:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	ff 45 fc             	incl   -0x4(%ebp)
  800486:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800489:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80048c:	7c e1                	jl     80046f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80048e:	90                   	nop
  80048f:	c9                   	leave  
  800490:	c3                   	ret    

00800491 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800491:	55                   	push   %ebp
  800492:	89 e5                	mov    %esp,%ebp
  800494:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800497:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80049e:	eb 1b                	jmp    8004bb <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ad:	01 c2                	add    %eax,%edx
  8004af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b2:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004b5:	48                   	dec    %eax
  8004b6:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b8:	ff 45 fc             	incl   -0x4(%ebp)
  8004bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004be:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c1:	7c dd                	jl     8004a0 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004c3:	90                   	nop
  8004c4:	c9                   	leave  
  8004c5:	c3                   	ret    

008004c6 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004c6:	55                   	push   %ebp
  8004c7:	89 e5                	mov    %esp,%ebp
  8004c9:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004cc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004cf:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004d4:	f7 e9                	imul   %ecx
  8004d6:	c1 f9 1f             	sar    $0x1f,%ecx
  8004d9:	89 d0                	mov    %edx,%eax
  8004db:	29 c8                	sub    %ecx,%eax
  8004dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8004e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8004e4:	75 07                	jne    8004ed <InitializeSemiRandom+0x27>
		Repetition = 3;
  8004e6:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004f4:	eb 1e                	jmp    800514 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8004f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800500:	8b 45 08             	mov    0x8(%ebp),%eax
  800503:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	99                   	cltd   
  80050a:	f7 7d f8             	idivl  -0x8(%ebp)
  80050d:	89 d0                	mov    %edx,%eax
  80050f:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
		Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800511:	ff 45 fc             	incl   -0x4(%ebp)
  800514:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800517:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80051a:	7c da                	jl     8004f6 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80051c:	90                   	nop
  80051d:	c9                   	leave  
  80051e:	c3                   	ret    

0080051f <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80051f:	55                   	push   %ebp
  800520:	89 e5                	mov    %esp,%ebp
  800522:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800525:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800533:	eb 42                	jmp    800577 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800535:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800538:	99                   	cltd   
  800539:	f7 7d f0             	idivl  -0x10(%ebp)
  80053c:	89 d0                	mov    %edx,%eax
  80053e:	85 c0                	test   %eax,%eax
  800540:	75 10                	jne    800552 <PrintElements+0x33>
			cprintf("\n");
  800542:	83 ec 0c             	sub    $0xc,%esp
  800545:	68 00 24 80 00       	push   $0x802400
  80054a:	e8 c6 05 00 00       	call   800b15 <cprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800552:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800555:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055c:	8b 45 08             	mov    0x8(%ebp),%eax
  80055f:	01 d0                	add    %edx,%eax
  800561:	8b 00                	mov    (%eax),%eax
  800563:	83 ec 08             	sub    $0x8,%esp
  800566:	50                   	push   %eax
  800567:	68 d4 25 80 00       	push   $0x8025d4
  80056c:	e8 a4 05 00 00       	call   800b15 <cprintf>
  800571:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800574:	ff 45 f4             	incl   -0xc(%ebp)
  800577:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057a:	48                   	dec    %eax
  80057b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80057e:	7f b5                	jg     800535 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800580:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800583:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	01 d0                	add    %edx,%eax
  80058f:	8b 00                	mov    (%eax),%eax
  800591:	83 ec 08             	sub    $0x8,%esp
  800594:	50                   	push   %eax
  800595:	68 d9 25 80 00       	push   $0x8025d9
  80059a:	e8 76 05 00 00       	call   800b15 <cprintf>
  80059f:	83 c4 10             	add    $0x10,%esp

}
  8005a2:	90                   	nop
  8005a3:	c9                   	leave  
  8005a4:	c3                   	ret    

008005a5 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005a5:	55                   	push   %ebp
  8005a6:	89 e5                	mov    %esp,%ebp
  8005a8:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005b1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b5:	83 ec 0c             	sub    $0xc,%esp
  8005b8:	50                   	push   %eax
  8005b9:	e8 1b 17 00 00       	call   801cd9 <sys_cputc>
  8005be:	83 c4 10             	add    $0x10,%esp
}
  8005c1:	90                   	nop
  8005c2:	c9                   	leave  
  8005c3:	c3                   	ret    

008005c4 <getchar>:


int
getchar(void)
{
  8005c4:	55                   	push   %ebp
  8005c5:	89 e5                	mov    %esp,%ebp
  8005c7:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8005ca:	e8 a9 15 00 00       	call   801b78 <sys_cgetc>
  8005cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8005d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005d6:	74 f2                	je     8005ca <getchar+0x6>
	return c;
  8005d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005db:	c9                   	leave  
  8005dc:	c3                   	ret    

008005dd <iscons>:

int iscons(int fdnum)
{
  8005dd:	55                   	push   %ebp
  8005de:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005e0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005e5:	5d                   	pop    %ebp
  8005e6:	c3                   	ret    

008005e7 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8005e7:	55                   	push   %ebp
  8005e8:	89 e5                	mov    %esp,%ebp
  8005ea:	57                   	push   %edi
  8005eb:	56                   	push   %esi
  8005ec:	53                   	push   %ebx
  8005ed:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8005f3:	e8 11 18 00 00       	call   801e09 <sys_getenvindex>
  8005f8:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8005fb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005fe:	89 d0                	mov    %edx,%eax
  800600:	c1 e0 03             	shl    $0x3,%eax
  800603:	01 d0                	add    %edx,%eax
  800605:	c1 e0 06             	shl    $0x6,%eax
  800608:	01 d0                	add    %edx,%eax
  80060a:	c1 e0 03             	shl    $0x3,%eax
  80060d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800612:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800617:	a1 24 30 80 00       	mov    0x803024,%eax
  80061c:	8a 40 10             	mov    0x10(%eax),%al
  80061f:	84 c0                	test   %al,%al
  800621:	74 0d                	je     800630 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800623:	a1 24 30 80 00       	mov    0x803024,%eax
  800628:	83 c0 10             	add    $0x10,%eax
  80062b:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800630:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800634:	7e 0a                	jle    800640 <libmain+0x59>
		binaryname = argv[0];
  800636:	8b 45 0c             	mov    0xc(%ebp),%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800640:	83 ec 08             	sub    $0x8,%esp
  800643:	ff 75 0c             	pushl  0xc(%ebp)
  800646:	ff 75 08             	pushl  0x8(%ebp)
  800649:	e8 ea f9 ff ff       	call   800038 <_main>
  80064e:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800651:	a1 00 30 80 00       	mov    0x803000,%eax
  800656:	85 c0                	test   %eax,%eax
  800658:	0f 84 b7 01 00 00    	je     800815 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80065e:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800664:	bb 1c 27 80 00       	mov    $0x80271c,%ebx
  800669:	ba 0e 00 00 00       	mov    $0xe,%edx
  80066e:	89 c7                	mov    %eax,%edi
  800670:	89 de                	mov    %ebx,%esi
  800672:	89 d1                	mov    %edx,%ecx
  800674:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800676:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80067c:	b9 56 00 00 00       	mov    $0x56,%ecx
  800681:	b0 00                	mov    $0x0,%al
  800683:	89 d7                	mov    %edx,%edi
  800685:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800687:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80068e:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800691:	83 ec 08             	sub    $0x8,%esp
  800694:	50                   	push   %eax
  800695:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80069b:	50                   	push   %eax
  80069c:	e8 68 19 00 00       	call   802009 <sys_utilities>
  8006a1:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8006a4:	e8 e8 14 00 00       	call   801b91 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8006a9:	83 ec 0c             	sub    $0xc,%esp
  8006ac:	68 f8 25 80 00       	push   $0x8025f8
  8006b1:	e8 5f 04 00 00       	call   800b15 <cprintf>
  8006b6:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006bc:	85 c0                	test   %eax,%eax
  8006be:	74 58                	je     800718 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006c0:	e8 62 19 00 00       	call   802027 <sys_get_optimal_num_faults>
  8006c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006c8:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006ce:	bb 80 27 80 00       	mov    $0x802780,%ebx
  8006d3:	ba 11 00 00 00       	mov    $0x11,%edx
  8006d8:	89 c7                	mov    %eax,%edi
  8006da:	89 de                	mov    %ebx,%esi
  8006dc:	89 d1                	mov    %edx,%ecx
  8006de:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006e0:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8006e3:	b9 53 00 00 00       	mov    $0x53,%ecx
  8006e8:	b0 00                	mov    $0x0,%al
  8006ea:	89 d7                	mov    %edx,%edi
  8006ec:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8006ee:	83 ec 08             	sub    $0x8,%esp
  8006f1:	ff 75 dc             	pushl  -0x24(%ebp)
  8006f4:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006fa:	50                   	push   %eax
  8006fb:	e8 09 19 00 00       	call   802009 <sys_utilities>
  800700:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 dc             	pushl  -0x24(%ebp)
  800709:	68 20 26 80 00       	push   $0x802620
  80070e:	e8 02 04 00 00       	call   800b15 <cprintf>
  800713:	83 c4 10             	add    $0x10,%esp
  800716:	eb 59                	jmp    800771 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800718:	a1 24 30 80 00       	mov    0x803024,%eax
  80071d:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800723:	a1 24 30 80 00       	mov    0x803024,%eax
  800728:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80072e:	83 ec 04             	sub    $0x4,%esp
  800731:	52                   	push   %edx
  800732:	50                   	push   %eax
  800733:	68 44 26 80 00       	push   $0x802644
  800738:	e8 d8 03 00 00       	call   800b15 <cprintf>
  80073d:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800740:	a1 24 30 80 00       	mov    0x803024,%eax
  800745:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80074b:	a1 24 30 80 00       	mov    0x803024,%eax
  800750:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800756:	a1 24 30 80 00       	mov    0x803024,%eax
  80075b:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800761:	51                   	push   %ecx
  800762:	52                   	push   %edx
  800763:	50                   	push   %eax
  800764:	68 6c 26 80 00       	push   $0x80266c
  800769:	e8 a7 03 00 00       	call   800b15 <cprintf>
  80076e:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800771:	a1 24 30 80 00       	mov    0x803024,%eax
  800776:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	50                   	push   %eax
  800780:	68 c4 26 80 00       	push   $0x8026c4
  800785:	e8 8b 03 00 00       	call   800b15 <cprintf>
  80078a:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80078d:	83 ec 0c             	sub    $0xc,%esp
  800790:	68 d8 26 80 00       	push   $0x8026d8
  800795:	e8 7b 03 00 00       	call   800b15 <cprintf>
  80079a:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80079d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8007a4:	eb 28                	jmp    8007ce <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8007a6:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ab:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007ae:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007b4:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007b7:	83 ec 04             	sub    $0x4,%esp
  8007ba:	50                   	push   %eax
  8007bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007be:	68 ef 26 80 00       	push   $0x8026ef
  8007c3:	e8 4d 03 00 00       	call   800b15 <cprintf>
  8007c8:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007cb:	ff 45 e4             	incl   -0x1c(%ebp)
  8007ce:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007d2:	7e d2                	jle    8007a6 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007d4:	83 ec 0c             	sub    $0xc,%esp
  8007d7:	68 fe 26 80 00       	push   $0x8026fe
  8007dc:	e8 34 03 00 00       	call   800b15 <cprintf>
  8007e1:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8007e4:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e9:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	50                   	push   %eax
  8007f3:	68 02 27 80 00       	push   $0x802702
  8007f8:	e8 18 03 00 00       	call   800b15 <cprintf>
  8007fd:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800800:	83 ec 0c             	sub    $0xc,%esp
  800803:	68 f8 25 80 00       	push   $0x8025f8
  800808:	e8 08 03 00 00       	call   800b15 <cprintf>
  80080d:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800810:	e8 96 13 00 00       	call   801bab <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800815:	e8 1f 00 00 00       	call   800839 <exit>
}
  80081a:	90                   	nop
  80081b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80081e:	5b                   	pop    %ebx
  80081f:	5e                   	pop    %esi
  800820:	5f                   	pop    %edi
  800821:	5d                   	pop    %ebp
  800822:	c3                   	ret    

00800823 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800823:	55                   	push   %ebp
  800824:	89 e5                	mov    %esp,%ebp
  800826:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800829:	83 ec 0c             	sub    $0xc,%esp
  80082c:	6a 00                	push   $0x0
  80082e:	e8 a2 15 00 00       	call   801dd5 <sys_destroy_env>
  800833:	83 c4 10             	add    $0x10,%esp
}
  800836:	90                   	nop
  800837:	c9                   	leave  
  800838:	c3                   	ret    

00800839 <exit>:

void
exit(void)
{
  800839:	55                   	push   %ebp
  80083a:	89 e5                	mov    %esp,%ebp
  80083c:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80083f:	e8 f7 15 00 00       	call   801e3b <sys_exit_env>
}
  800844:	90                   	nop
  800845:	c9                   	leave  
  800846:	c3                   	ret    

00800847 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800847:	55                   	push   %ebp
  800848:	89 e5                	mov    %esp,%ebp
  80084a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80084d:	8d 45 10             	lea    0x10(%ebp),%eax
  800850:	83 c0 04             	add    $0x4,%eax
  800853:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800856:	a1 28 31 80 00       	mov    0x803128,%eax
  80085b:	85 c0                	test   %eax,%eax
  80085d:	74 16                	je     800875 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80085f:	a1 28 31 80 00       	mov    0x803128,%eax
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	50                   	push   %eax
  800868:	68 e4 27 80 00       	push   $0x8027e4
  80086d:	e8 a3 02 00 00       	call   800b15 <cprintf>
  800872:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800875:	a1 04 30 80 00       	mov    0x803004,%eax
  80087a:	83 ec 0c             	sub    $0xc,%esp
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	ff 75 08             	pushl  0x8(%ebp)
  800883:	50                   	push   %eax
  800884:	68 ec 27 80 00       	push   $0x8027ec
  800889:	6a 74                	push   $0x74
  80088b:	e8 b2 02 00 00       	call   800b42 <cprintf_colored>
  800890:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800893:	8b 45 10             	mov    0x10(%ebp),%eax
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 f4             	pushl  -0xc(%ebp)
  80089c:	50                   	push   %eax
  80089d:	e8 04 02 00 00       	call   800aa6 <vcprintf>
  8008a2:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	6a 00                	push   $0x0
  8008aa:	68 14 28 80 00       	push   $0x802814
  8008af:	e8 f2 01 00 00       	call   800aa6 <vcprintf>
  8008b4:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008b7:	e8 7d ff ff ff       	call   800839 <exit>

	// should not return here
	while (1) ;
  8008bc:	eb fe                	jmp    8008bc <_panic+0x75>

008008be <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008be:	55                   	push   %ebp
  8008bf:	89 e5                	mov    %esp,%ebp
  8008c1:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008c4:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c9:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d2:	39 c2                	cmp    %eax,%edx
  8008d4:	74 14                	je     8008ea <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008d6:	83 ec 04             	sub    $0x4,%esp
  8008d9:	68 18 28 80 00       	push   $0x802818
  8008de:	6a 26                	push   $0x26
  8008e0:	68 64 28 80 00       	push   $0x802864
  8008e5:	e8 5d ff ff ff       	call   800847 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008f1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008f8:	e9 c5 00 00 00       	jmp    8009c2 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8008fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800900:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	01 d0                	add    %edx,%eax
  80090c:	8b 00                	mov    (%eax),%eax
  80090e:	85 c0                	test   %eax,%eax
  800910:	75 08                	jne    80091a <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800912:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800915:	e9 a5 00 00 00       	jmp    8009bf <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80091a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800921:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800928:	eb 69                	jmp    800993 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80092a:	a1 24 30 80 00       	mov    0x803024,%eax
  80092f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800935:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800938:	89 d0                	mov    %edx,%eax
  80093a:	01 c0                	add    %eax,%eax
  80093c:	01 d0                	add    %edx,%eax
  80093e:	c1 e0 03             	shl    $0x3,%eax
  800941:	01 c8                	add    %ecx,%eax
  800943:	8a 40 04             	mov    0x4(%eax),%al
  800946:	84 c0                	test   %al,%al
  800948:	75 46                	jne    800990 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80094a:	a1 24 30 80 00       	mov    0x803024,%eax
  80094f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800955:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800958:	89 d0                	mov    %edx,%eax
  80095a:	01 c0                	add    %eax,%eax
  80095c:	01 d0                	add    %edx,%eax
  80095e:	c1 e0 03             	shl    $0x3,%eax
  800961:	01 c8                	add    %ecx,%eax
  800963:	8b 00                	mov    (%eax),%eax
  800965:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800968:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80096b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800970:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800972:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800975:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	01 c8                	add    %ecx,%eax
  800981:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800983:	39 c2                	cmp    %eax,%edx
  800985:	75 09                	jne    800990 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800987:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80098e:	eb 15                	jmp    8009a5 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800990:	ff 45 e8             	incl   -0x18(%ebp)
  800993:	a1 24 30 80 00       	mov    0x803024,%eax
  800998:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80099e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009a1:	39 c2                	cmp    %eax,%edx
  8009a3:	77 85                	ja     80092a <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009a9:	75 14                	jne    8009bf <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8009ab:	83 ec 04             	sub    $0x4,%esp
  8009ae:	68 70 28 80 00       	push   $0x802870
  8009b3:	6a 3a                	push   $0x3a
  8009b5:	68 64 28 80 00       	push   $0x802864
  8009ba:	e8 88 fe ff ff       	call   800847 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009bf:	ff 45 f0             	incl   -0x10(%ebp)
  8009c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009c8:	0f 8c 2f ff ff ff    	jl     8008fd <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009ce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009d5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009dc:	eb 26                	jmp    800a04 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009de:	a1 24 30 80 00       	mov    0x803024,%eax
  8009e3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8009e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ec:	89 d0                	mov    %edx,%eax
  8009ee:	01 c0                	add    %eax,%eax
  8009f0:	01 d0                	add    %edx,%eax
  8009f2:	c1 e0 03             	shl    $0x3,%eax
  8009f5:	01 c8                	add    %ecx,%eax
  8009f7:	8a 40 04             	mov    0x4(%eax),%al
  8009fa:	3c 01                	cmp    $0x1,%al
  8009fc:	75 03                	jne    800a01 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8009fe:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a01:	ff 45 e0             	incl   -0x20(%ebp)
  800a04:	a1 24 30 80 00       	mov    0x803024,%eax
  800a09:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a12:	39 c2                	cmp    %eax,%edx
  800a14:	77 c8                	ja     8009de <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a19:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a1c:	74 14                	je     800a32 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a1e:	83 ec 04             	sub    $0x4,%esp
  800a21:	68 c4 28 80 00       	push   $0x8028c4
  800a26:	6a 44                	push   $0x44
  800a28:	68 64 28 80 00       	push   $0x802864
  800a2d:	e8 15 fe ff ff       	call   800847 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a32:	90                   	nop
  800a33:	c9                   	leave  
  800a34:	c3                   	ret    

00800a35 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a35:	55                   	push   %ebp
  800a36:	89 e5                	mov    %esp,%ebp
  800a38:	53                   	push   %ebx
  800a39:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3f:	8b 00                	mov    (%eax),%eax
  800a41:	8d 48 01             	lea    0x1(%eax),%ecx
  800a44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a47:	89 0a                	mov    %ecx,(%edx)
  800a49:	8b 55 08             	mov    0x8(%ebp),%edx
  800a4c:	88 d1                	mov    %dl,%cl
  800a4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a51:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a58:	8b 00                	mov    (%eax),%eax
  800a5a:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a5f:	75 30                	jne    800a91 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a61:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800a67:	a0 40 30 80 00       	mov    0x803040,%al
  800a6c:	0f b6 c0             	movzbl %al,%eax
  800a6f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a72:	8b 09                	mov    (%ecx),%ecx
  800a74:	89 cb                	mov    %ecx,%ebx
  800a76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a79:	83 c1 08             	add    $0x8,%ecx
  800a7c:	52                   	push   %edx
  800a7d:	50                   	push   %eax
  800a7e:	53                   	push   %ebx
  800a7f:	51                   	push   %ecx
  800a80:	e8 c8 10 00 00       	call   801b4d <sys_cputs>
  800a85:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a94:	8b 40 04             	mov    0x4(%eax),%eax
  800a97:	8d 50 01             	lea    0x1(%eax),%edx
  800a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800aa0:	90                   	nop
  800aa1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aa4:	c9                   	leave  
  800aa5:	c3                   	ret    

00800aa6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800aa6:	55                   	push   %ebp
  800aa7:	89 e5                	mov    %esp,%ebp
  800aa9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800aaf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ab6:	00 00 00 
	b.cnt = 0;
  800ab9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ac0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ac3:	ff 75 0c             	pushl  0xc(%ebp)
  800ac6:	ff 75 08             	pushl  0x8(%ebp)
  800ac9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800acf:	50                   	push   %eax
  800ad0:	68 35 0a 80 00       	push   $0x800a35
  800ad5:	e8 5a 02 00 00       	call   800d34 <vprintfmt>
  800ada:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800add:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800ae3:	a0 40 30 80 00       	mov    0x803040,%al
  800ae8:	0f b6 c0             	movzbl %al,%eax
  800aeb:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800af1:	52                   	push   %edx
  800af2:	50                   	push   %eax
  800af3:	51                   	push   %ecx
  800af4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800afa:	83 c0 08             	add    $0x8,%eax
  800afd:	50                   	push   %eax
  800afe:	e8 4a 10 00 00       	call   801b4d <sys_cputs>
  800b03:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b06:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800b0d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b13:	c9                   	leave  
  800b14:	c3                   	ret    

00800b15 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b15:	55                   	push   %ebp
  800b16:	89 e5                	mov    %esp,%ebp
  800b18:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b1b:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800b22:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b25:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	83 ec 08             	sub    $0x8,%esp
  800b2e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b31:	50                   	push   %eax
  800b32:	e8 6f ff ff ff       	call   800aa6 <vcprintf>
  800b37:	83 c4 10             	add    $0x10,%esp
  800b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b40:	c9                   	leave  
  800b41:	c3                   	ret    

00800b42 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b42:	55                   	push   %ebp
  800b43:	89 e5                	mov    %esp,%ebp
  800b45:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b48:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	c1 e0 08             	shl    $0x8,%eax
  800b55:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800b5a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b5d:	83 c0 04             	add    $0x4,%eax
  800b60:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b66:	83 ec 08             	sub    $0x8,%esp
  800b69:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6c:	50                   	push   %eax
  800b6d:	e8 34 ff ff ff       	call   800aa6 <vcprintf>
  800b72:	83 c4 10             	add    $0x10,%esp
  800b75:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800b78:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800b7f:	07 00 00 

	return cnt;
  800b82:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b85:	c9                   	leave  
  800b86:	c3                   	ret    

00800b87 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800b87:	55                   	push   %ebp
  800b88:	89 e5                	mov    %esp,%ebp
  800b8a:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800b8d:	e8 ff 0f 00 00       	call   801b91 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800b92:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b95:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba1:	50                   	push   %eax
  800ba2:	e8 ff fe ff ff       	call   800aa6 <vcprintf>
  800ba7:	83 c4 10             	add    $0x10,%esp
  800baa:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800bad:	e8 f9 0f 00 00       	call   801bab <sys_unlock_cons>
	return cnt;
  800bb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb5:	c9                   	leave  
  800bb6:	c3                   	ret    

00800bb7 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bb7:	55                   	push   %ebp
  800bb8:	89 e5                	mov    %esp,%ebp
  800bba:	53                   	push   %ebx
  800bbb:	83 ec 14             	sub    $0x14,%esp
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bca:	8b 45 18             	mov    0x18(%ebp),%eax
  800bcd:	ba 00 00 00 00       	mov    $0x0,%edx
  800bd2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bd5:	77 55                	ja     800c2c <printnum+0x75>
  800bd7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bda:	72 05                	jb     800be1 <printnum+0x2a>
  800bdc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bdf:	77 4b                	ja     800c2c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800be1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800be4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800be7:	8b 45 18             	mov    0x18(%ebp),%eax
  800bea:	ba 00 00 00 00       	mov    $0x0,%edx
  800bef:	52                   	push   %edx
  800bf0:	50                   	push   %eax
  800bf1:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf4:	ff 75 f0             	pushl  -0x10(%ebp)
  800bf7:	e8 8c 15 00 00       	call   802188 <__udivdi3>
  800bfc:	83 c4 10             	add    $0x10,%esp
  800bff:	83 ec 04             	sub    $0x4,%esp
  800c02:	ff 75 20             	pushl  0x20(%ebp)
  800c05:	53                   	push   %ebx
  800c06:	ff 75 18             	pushl  0x18(%ebp)
  800c09:	52                   	push   %edx
  800c0a:	50                   	push   %eax
  800c0b:	ff 75 0c             	pushl  0xc(%ebp)
  800c0e:	ff 75 08             	pushl  0x8(%ebp)
  800c11:	e8 a1 ff ff ff       	call   800bb7 <printnum>
  800c16:	83 c4 20             	add    $0x20,%esp
  800c19:	eb 1a                	jmp    800c35 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	ff 75 0c             	pushl  0xc(%ebp)
  800c21:	ff 75 20             	pushl  0x20(%ebp)
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	ff d0                	call   *%eax
  800c29:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c2c:	ff 4d 1c             	decl   0x1c(%ebp)
  800c2f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c33:	7f e6                	jg     800c1b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c35:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c38:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c43:	53                   	push   %ebx
  800c44:	51                   	push   %ecx
  800c45:	52                   	push   %edx
  800c46:	50                   	push   %eax
  800c47:	e8 4c 16 00 00       	call   802298 <__umoddi3>
  800c4c:	83 c4 10             	add    $0x10,%esp
  800c4f:	05 34 2b 80 00       	add    $0x802b34,%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	0f be c0             	movsbl %al,%eax
  800c59:	83 ec 08             	sub    $0x8,%esp
  800c5c:	ff 75 0c             	pushl  0xc(%ebp)
  800c5f:	50                   	push   %eax
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	ff d0                	call   *%eax
  800c65:	83 c4 10             	add    $0x10,%esp
}
  800c68:	90                   	nop
  800c69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c71:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c75:	7e 1c                	jle    800c93 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8b 00                	mov    (%eax),%eax
  800c7c:	8d 50 08             	lea    0x8(%eax),%edx
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	89 10                	mov    %edx,(%eax)
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8b 00                	mov    (%eax),%eax
  800c89:	83 e8 08             	sub    $0x8,%eax
  800c8c:	8b 50 04             	mov    0x4(%eax),%edx
  800c8f:	8b 00                	mov    (%eax),%eax
  800c91:	eb 40                	jmp    800cd3 <getuint+0x65>
	else if (lflag)
  800c93:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c97:	74 1e                	je     800cb7 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8b 00                	mov    (%eax),%eax
  800c9e:	8d 50 04             	lea    0x4(%eax),%edx
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	89 10                	mov    %edx,(%eax)
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8b 00                	mov    (%eax),%eax
  800cab:	83 e8 04             	sub    $0x4,%eax
  800cae:	8b 00                	mov    (%eax),%eax
  800cb0:	ba 00 00 00 00       	mov    $0x0,%edx
  800cb5:	eb 1c                	jmp    800cd3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8b 00                	mov    (%eax),%eax
  800cbc:	8d 50 04             	lea    0x4(%eax),%edx
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	89 10                	mov    %edx,(%eax)
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8b 00                	mov    (%eax),%eax
  800cc9:	83 e8 04             	sub    $0x4,%eax
  800ccc:	8b 00                	mov    (%eax),%eax
  800cce:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cd3:	5d                   	pop    %ebp
  800cd4:	c3                   	ret    

00800cd5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cd8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cdc:	7e 1c                	jle    800cfa <getint+0x25>
		return va_arg(*ap, long long);
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	8b 00                	mov    (%eax),%eax
  800ce3:	8d 50 08             	lea    0x8(%eax),%edx
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	89 10                	mov    %edx,(%eax)
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8b 00                	mov    (%eax),%eax
  800cf0:	83 e8 08             	sub    $0x8,%eax
  800cf3:	8b 50 04             	mov    0x4(%eax),%edx
  800cf6:	8b 00                	mov    (%eax),%eax
  800cf8:	eb 38                	jmp    800d32 <getint+0x5d>
	else if (lflag)
  800cfa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cfe:	74 1a                	je     800d1a <getint+0x45>
		return va_arg(*ap, long);
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8b 00                	mov    (%eax),%eax
  800d05:	8d 50 04             	lea    0x4(%eax),%edx
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	89 10                	mov    %edx,(%eax)
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8b 00                	mov    (%eax),%eax
  800d12:	83 e8 04             	sub    $0x4,%eax
  800d15:	8b 00                	mov    (%eax),%eax
  800d17:	99                   	cltd   
  800d18:	eb 18                	jmp    800d32 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	8b 00                	mov    (%eax),%eax
  800d1f:	8d 50 04             	lea    0x4(%eax),%edx
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	89 10                	mov    %edx,(%eax)
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	8b 00                	mov    (%eax),%eax
  800d2c:	83 e8 04             	sub    $0x4,%eax
  800d2f:	8b 00                	mov    (%eax),%eax
  800d31:	99                   	cltd   
}
  800d32:	5d                   	pop    %ebp
  800d33:	c3                   	ret    

00800d34 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	56                   	push   %esi
  800d38:	53                   	push   %ebx
  800d39:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d3c:	eb 17                	jmp    800d55 <vprintfmt+0x21>
			if (ch == '\0')
  800d3e:	85 db                	test   %ebx,%ebx
  800d40:	0f 84 c1 03 00 00    	je     801107 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d46:	83 ec 08             	sub    $0x8,%esp
  800d49:	ff 75 0c             	pushl  0xc(%ebp)
  800d4c:	53                   	push   %ebx
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	ff d0                	call   *%eax
  800d52:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d55:	8b 45 10             	mov    0x10(%ebp),%eax
  800d58:	8d 50 01             	lea    0x1(%eax),%edx
  800d5b:	89 55 10             	mov    %edx,0x10(%ebp)
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	0f b6 d8             	movzbl %al,%ebx
  800d63:	83 fb 25             	cmp    $0x25,%ebx
  800d66:	75 d6                	jne    800d3e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d68:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d6c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d73:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d7a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d81:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d88:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8b:	8d 50 01             	lea    0x1(%eax),%edx
  800d8e:	89 55 10             	mov    %edx,0x10(%ebp)
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	0f b6 d8             	movzbl %al,%ebx
  800d96:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d99:	83 f8 5b             	cmp    $0x5b,%eax
  800d9c:	0f 87 3d 03 00 00    	ja     8010df <vprintfmt+0x3ab>
  800da2:	8b 04 85 58 2b 80 00 	mov    0x802b58(,%eax,4),%eax
  800da9:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dab:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800daf:	eb d7                	jmp    800d88 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800db1:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800db5:	eb d1                	jmp    800d88 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800db7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dbe:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dc1:	89 d0                	mov    %edx,%eax
  800dc3:	c1 e0 02             	shl    $0x2,%eax
  800dc6:	01 d0                	add    %edx,%eax
  800dc8:	01 c0                	add    %eax,%eax
  800dca:	01 d8                	add    %ebx,%eax
  800dcc:	83 e8 30             	sub    $0x30,%eax
  800dcf:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dda:	83 fb 2f             	cmp    $0x2f,%ebx
  800ddd:	7e 3e                	jle    800e1d <vprintfmt+0xe9>
  800ddf:	83 fb 39             	cmp    $0x39,%ebx
  800de2:	7f 39                	jg     800e1d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800de7:	eb d5                	jmp    800dbe <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800de9:	8b 45 14             	mov    0x14(%ebp),%eax
  800dec:	83 c0 04             	add    $0x4,%eax
  800def:	89 45 14             	mov    %eax,0x14(%ebp)
  800df2:	8b 45 14             	mov    0x14(%ebp),%eax
  800df5:	83 e8 04             	sub    $0x4,%eax
  800df8:	8b 00                	mov    (%eax),%eax
  800dfa:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800dfd:	eb 1f                	jmp    800e1e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800dff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e03:	79 83                	jns    800d88 <vprintfmt+0x54>
				width = 0;
  800e05:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e0c:	e9 77 ff ff ff       	jmp    800d88 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e11:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e18:	e9 6b ff ff ff       	jmp    800d88 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e1d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e22:	0f 89 60 ff ff ff    	jns    800d88 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e28:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e2b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e2e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e35:	e9 4e ff ff ff       	jmp    800d88 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e3a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e3d:	e9 46 ff ff ff       	jmp    800d88 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e42:	8b 45 14             	mov    0x14(%ebp),%eax
  800e45:	83 c0 04             	add    $0x4,%eax
  800e48:	89 45 14             	mov    %eax,0x14(%ebp)
  800e4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4e:	83 e8 04             	sub    $0x4,%eax
  800e51:	8b 00                	mov    (%eax),%eax
  800e53:	83 ec 08             	sub    $0x8,%esp
  800e56:	ff 75 0c             	pushl  0xc(%ebp)
  800e59:	50                   	push   %eax
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	ff d0                	call   *%eax
  800e5f:	83 c4 10             	add    $0x10,%esp
			break;
  800e62:	e9 9b 02 00 00       	jmp    801102 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e67:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6a:	83 c0 04             	add    $0x4,%eax
  800e6d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e70:	8b 45 14             	mov    0x14(%ebp),%eax
  800e73:	83 e8 04             	sub    $0x4,%eax
  800e76:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e78:	85 db                	test   %ebx,%ebx
  800e7a:	79 02                	jns    800e7e <vprintfmt+0x14a>
				err = -err;
  800e7c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e7e:	83 fb 64             	cmp    $0x64,%ebx
  800e81:	7f 0b                	jg     800e8e <vprintfmt+0x15a>
  800e83:	8b 34 9d a0 29 80 00 	mov    0x8029a0(,%ebx,4),%esi
  800e8a:	85 f6                	test   %esi,%esi
  800e8c:	75 19                	jne    800ea7 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e8e:	53                   	push   %ebx
  800e8f:	68 45 2b 80 00       	push   $0x802b45
  800e94:	ff 75 0c             	pushl  0xc(%ebp)
  800e97:	ff 75 08             	pushl  0x8(%ebp)
  800e9a:	e8 70 02 00 00       	call   80110f <printfmt>
  800e9f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ea2:	e9 5b 02 00 00       	jmp    801102 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ea7:	56                   	push   %esi
  800ea8:	68 4e 2b 80 00       	push   $0x802b4e
  800ead:	ff 75 0c             	pushl  0xc(%ebp)
  800eb0:	ff 75 08             	pushl  0x8(%ebp)
  800eb3:	e8 57 02 00 00       	call   80110f <printfmt>
  800eb8:	83 c4 10             	add    $0x10,%esp
			break;
  800ebb:	e9 42 02 00 00       	jmp    801102 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ec0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec3:	83 c0 04             	add    $0x4,%eax
  800ec6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ecc:	83 e8 04             	sub    $0x4,%eax
  800ecf:	8b 30                	mov    (%eax),%esi
  800ed1:	85 f6                	test   %esi,%esi
  800ed3:	75 05                	jne    800eda <vprintfmt+0x1a6>
				p = "(null)";
  800ed5:	be 51 2b 80 00       	mov    $0x802b51,%esi
			if (width > 0 && padc != '-')
  800eda:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ede:	7e 6d                	jle    800f4d <vprintfmt+0x219>
  800ee0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ee4:	74 67                	je     800f4d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ee6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ee9:	83 ec 08             	sub    $0x8,%esp
  800eec:	50                   	push   %eax
  800eed:	56                   	push   %esi
  800eee:	e8 1e 03 00 00       	call   801211 <strnlen>
  800ef3:	83 c4 10             	add    $0x10,%esp
  800ef6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ef9:	eb 16                	jmp    800f11 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800efb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	50                   	push   %eax
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	ff d0                	call   *%eax
  800f0b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f0e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f11:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f15:	7f e4                	jg     800efb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f17:	eb 34                	jmp    800f4d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f19:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f1d:	74 1c                	je     800f3b <vprintfmt+0x207>
  800f1f:	83 fb 1f             	cmp    $0x1f,%ebx
  800f22:	7e 05                	jle    800f29 <vprintfmt+0x1f5>
  800f24:	83 fb 7e             	cmp    $0x7e,%ebx
  800f27:	7e 12                	jle    800f3b <vprintfmt+0x207>
					putch('?', putdat);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 0c             	pushl  0xc(%ebp)
  800f2f:	6a 3f                	push   $0x3f
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
  800f39:	eb 0f                	jmp    800f4a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f3b:	83 ec 08             	sub    $0x8,%esp
  800f3e:	ff 75 0c             	pushl  0xc(%ebp)
  800f41:	53                   	push   %ebx
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	ff d0                	call   *%eax
  800f47:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f4a:	ff 4d e4             	decl   -0x1c(%ebp)
  800f4d:	89 f0                	mov    %esi,%eax
  800f4f:	8d 70 01             	lea    0x1(%eax),%esi
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	0f be d8             	movsbl %al,%ebx
  800f57:	85 db                	test   %ebx,%ebx
  800f59:	74 24                	je     800f7f <vprintfmt+0x24b>
  800f5b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f5f:	78 b8                	js     800f19 <vprintfmt+0x1e5>
  800f61:	ff 4d e0             	decl   -0x20(%ebp)
  800f64:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f68:	79 af                	jns    800f19 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f6a:	eb 13                	jmp    800f7f <vprintfmt+0x24b>
				putch(' ', putdat);
  800f6c:	83 ec 08             	sub    $0x8,%esp
  800f6f:	ff 75 0c             	pushl  0xc(%ebp)
  800f72:	6a 20                	push   $0x20
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	ff d0                	call   *%eax
  800f79:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f83:	7f e7                	jg     800f6c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f85:	e9 78 01 00 00       	jmp    801102 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f8a:	83 ec 08             	sub    $0x8,%esp
  800f8d:	ff 75 e8             	pushl  -0x18(%ebp)
  800f90:	8d 45 14             	lea    0x14(%ebp),%eax
  800f93:	50                   	push   %eax
  800f94:	e8 3c fd ff ff       	call   800cd5 <getint>
  800f99:	83 c4 10             	add    $0x10,%esp
  800f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa8:	85 d2                	test   %edx,%edx
  800faa:	79 23                	jns    800fcf <vprintfmt+0x29b>
				putch('-', putdat);
  800fac:	83 ec 08             	sub    $0x8,%esp
  800faf:	ff 75 0c             	pushl  0xc(%ebp)
  800fb2:	6a 2d                	push   $0x2d
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	ff d0                	call   *%eax
  800fb9:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc2:	f7 d8                	neg    %eax
  800fc4:	83 d2 00             	adc    $0x0,%edx
  800fc7:	f7 da                	neg    %edx
  800fc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fcf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fd6:	e9 bc 00 00 00       	jmp    801097 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fdb:	83 ec 08             	sub    $0x8,%esp
  800fde:	ff 75 e8             	pushl  -0x18(%ebp)
  800fe1:	8d 45 14             	lea    0x14(%ebp),%eax
  800fe4:	50                   	push   %eax
  800fe5:	e8 84 fc ff ff       	call   800c6e <getuint>
  800fea:	83 c4 10             	add    $0x10,%esp
  800fed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ff3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ffa:	e9 98 00 00 00       	jmp    801097 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800fff:	83 ec 08             	sub    $0x8,%esp
  801002:	ff 75 0c             	pushl  0xc(%ebp)
  801005:	6a 58                	push   $0x58
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	ff d0                	call   *%eax
  80100c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80100f:	83 ec 08             	sub    $0x8,%esp
  801012:	ff 75 0c             	pushl  0xc(%ebp)
  801015:	6a 58                	push   $0x58
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	ff d0                	call   *%eax
  80101c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80101f:	83 ec 08             	sub    $0x8,%esp
  801022:	ff 75 0c             	pushl  0xc(%ebp)
  801025:	6a 58                	push   $0x58
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	ff d0                	call   *%eax
  80102c:	83 c4 10             	add    $0x10,%esp
			break;
  80102f:	e9 ce 00 00 00       	jmp    801102 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801034:	83 ec 08             	sub    $0x8,%esp
  801037:	ff 75 0c             	pushl  0xc(%ebp)
  80103a:	6a 30                	push   $0x30
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	ff d0                	call   *%eax
  801041:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801044:	83 ec 08             	sub    $0x8,%esp
  801047:	ff 75 0c             	pushl  0xc(%ebp)
  80104a:	6a 78                	push   $0x78
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	ff d0                	call   *%eax
  801051:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801054:	8b 45 14             	mov    0x14(%ebp),%eax
  801057:	83 c0 04             	add    $0x4,%eax
  80105a:	89 45 14             	mov    %eax,0x14(%ebp)
  80105d:	8b 45 14             	mov    0x14(%ebp),%eax
  801060:	83 e8 04             	sub    $0x4,%eax
  801063:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801065:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801068:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80106f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801076:	eb 1f                	jmp    801097 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801078:	83 ec 08             	sub    $0x8,%esp
  80107b:	ff 75 e8             	pushl  -0x18(%ebp)
  80107e:	8d 45 14             	lea    0x14(%ebp),%eax
  801081:	50                   	push   %eax
  801082:	e8 e7 fb ff ff       	call   800c6e <getuint>
  801087:	83 c4 10             	add    $0x10,%esp
  80108a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80108d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801090:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801097:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80109b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80109e:	83 ec 04             	sub    $0x4,%esp
  8010a1:	52                   	push   %edx
  8010a2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010a5:	50                   	push   %eax
  8010a6:	ff 75 f4             	pushl  -0xc(%ebp)
  8010a9:	ff 75 f0             	pushl  -0x10(%ebp)
  8010ac:	ff 75 0c             	pushl  0xc(%ebp)
  8010af:	ff 75 08             	pushl  0x8(%ebp)
  8010b2:	e8 00 fb ff ff       	call   800bb7 <printnum>
  8010b7:	83 c4 20             	add    $0x20,%esp
			break;
  8010ba:	eb 46                	jmp    801102 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010bc:	83 ec 08             	sub    $0x8,%esp
  8010bf:	ff 75 0c             	pushl  0xc(%ebp)
  8010c2:	53                   	push   %ebx
  8010c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c6:	ff d0                	call   *%eax
  8010c8:	83 c4 10             	add    $0x10,%esp
			break;
  8010cb:	eb 35                	jmp    801102 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010cd:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8010d4:	eb 2c                	jmp    801102 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8010d6:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8010dd:	eb 23                	jmp    801102 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010df:	83 ec 08             	sub    $0x8,%esp
  8010e2:	ff 75 0c             	pushl  0xc(%ebp)
  8010e5:	6a 25                	push   $0x25
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	ff d0                	call   *%eax
  8010ec:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010ef:	ff 4d 10             	decl   0x10(%ebp)
  8010f2:	eb 03                	jmp    8010f7 <vprintfmt+0x3c3>
  8010f4:	ff 4d 10             	decl   0x10(%ebp)
  8010f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fa:	48                   	dec    %eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	3c 25                	cmp    $0x25,%al
  8010ff:	75 f3                	jne    8010f4 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801101:	90                   	nop
		}
	}
  801102:	e9 35 fc ff ff       	jmp    800d3c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801107:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801108:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80110b:	5b                   	pop    %ebx
  80110c:	5e                   	pop    %esi
  80110d:	5d                   	pop    %ebp
  80110e:	c3                   	ret    

0080110f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
  801112:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801115:	8d 45 10             	lea    0x10(%ebp),%eax
  801118:	83 c0 04             	add    $0x4,%eax
  80111b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80111e:	8b 45 10             	mov    0x10(%ebp),%eax
  801121:	ff 75 f4             	pushl  -0xc(%ebp)
  801124:	50                   	push   %eax
  801125:	ff 75 0c             	pushl  0xc(%ebp)
  801128:	ff 75 08             	pushl  0x8(%ebp)
  80112b:	e8 04 fc ff ff       	call   800d34 <vprintfmt>
  801130:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801133:	90                   	nop
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	8b 40 08             	mov    0x8(%eax),%eax
  80113f:	8d 50 01             	lea    0x1(%eax),%edx
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	8b 10                	mov    (%eax),%edx
  80114d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801150:	8b 40 04             	mov    0x4(%eax),%eax
  801153:	39 c2                	cmp    %eax,%edx
  801155:	73 12                	jae    801169 <sprintputch+0x33>
		*b->buf++ = ch;
  801157:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115a:	8b 00                	mov    (%eax),%eax
  80115c:	8d 48 01             	lea    0x1(%eax),%ecx
  80115f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801162:	89 0a                	mov    %ecx,(%edx)
  801164:	8b 55 08             	mov    0x8(%ebp),%edx
  801167:	88 10                	mov    %dl,(%eax)
}
  801169:	90                   	nop
  80116a:	5d                   	pop    %ebp
  80116b:	c3                   	ret    

0080116c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80116c:	55                   	push   %ebp
  80116d:	89 e5                	mov    %esp,%ebp
  80116f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	01 d0                	add    %edx,%eax
  801183:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801186:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80118d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801191:	74 06                	je     801199 <vsnprintf+0x2d>
  801193:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801197:	7f 07                	jg     8011a0 <vsnprintf+0x34>
		return -E_INVAL;
  801199:	b8 03 00 00 00       	mov    $0x3,%eax
  80119e:	eb 20                	jmp    8011c0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011a0:	ff 75 14             	pushl  0x14(%ebp)
  8011a3:	ff 75 10             	pushl  0x10(%ebp)
  8011a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011a9:	50                   	push   %eax
  8011aa:	68 36 11 80 00       	push   $0x801136
  8011af:	e8 80 fb ff ff       	call   800d34 <vprintfmt>
  8011b4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ba:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011c8:	8d 45 10             	lea    0x10(%ebp),%eax
  8011cb:	83 c0 04             	add    $0x4,%eax
  8011ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d7:	50                   	push   %eax
  8011d8:	ff 75 0c             	pushl  0xc(%ebp)
  8011db:	ff 75 08             	pushl  0x8(%ebp)
  8011de:	e8 89 ff ff ff       	call   80116c <vsnprintf>
  8011e3:	83 c4 10             	add    $0x10,%esp
  8011e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
  8011f1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8011f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011fb:	eb 06                	jmp    801203 <strlen+0x15>
		n++;
  8011fd:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801200:	ff 45 08             	incl   0x8(%ebp)
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	8a 00                	mov    (%eax),%al
  801208:	84 c0                	test   %al,%al
  80120a:	75 f1                	jne    8011fd <strlen+0xf>
		n++;
	return n;
  80120c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
  801214:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801217:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121e:	eb 09                	jmp    801229 <strnlen+0x18>
		n++;
  801220:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801223:	ff 45 08             	incl   0x8(%ebp)
  801226:	ff 4d 0c             	decl   0xc(%ebp)
  801229:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80122d:	74 09                	je     801238 <strnlen+0x27>
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	8a 00                	mov    (%eax),%al
  801234:	84 c0                	test   %al,%al
  801236:	75 e8                	jne    801220 <strnlen+0xf>
		n++;
	return n;
  801238:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80123b:	c9                   	leave  
  80123c:	c3                   	ret    

0080123d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80123d:	55                   	push   %ebp
  80123e:	89 e5                	mov    %esp,%ebp
  801240:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801249:	90                   	nop
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8d 50 01             	lea    0x1(%eax),%edx
  801250:	89 55 08             	mov    %edx,0x8(%ebp)
  801253:	8b 55 0c             	mov    0xc(%ebp),%edx
  801256:	8d 4a 01             	lea    0x1(%edx),%ecx
  801259:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80125c:	8a 12                	mov    (%edx),%dl
  80125e:	88 10                	mov    %dl,(%eax)
  801260:	8a 00                	mov    (%eax),%al
  801262:	84 c0                	test   %al,%al
  801264:	75 e4                	jne    80124a <strcpy+0xd>
		/* do nothing */;
	return ret;
  801266:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801269:	c9                   	leave  
  80126a:	c3                   	ret    

0080126b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
  80126e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127e:	eb 1f                	jmp    80129f <strncpy+0x34>
		*dst++ = *src;
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	8d 50 01             	lea    0x1(%eax),%edx
  801286:	89 55 08             	mov    %edx,0x8(%ebp)
  801289:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128c:	8a 12                	mov    (%edx),%dl
  80128e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801290:	8b 45 0c             	mov    0xc(%ebp),%eax
  801293:	8a 00                	mov    (%eax),%al
  801295:	84 c0                	test   %al,%al
  801297:	74 03                	je     80129c <strncpy+0x31>
			src++;
  801299:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80129c:	ff 45 fc             	incl   -0x4(%ebp)
  80129f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012a5:	72 d9                	jb     801280 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
  8012af:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012bc:	74 30                	je     8012ee <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012be:	eb 16                	jmp    8012d6 <strlcpy+0x2a>
			*dst++ = *src++;
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	8d 50 01             	lea    0x1(%eax),%edx
  8012c6:	89 55 08             	mov    %edx,0x8(%ebp)
  8012c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012cf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012d2:	8a 12                	mov    (%edx),%dl
  8012d4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012d6:	ff 4d 10             	decl   0x10(%ebp)
  8012d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012dd:	74 09                	je     8012e8 <strlcpy+0x3c>
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	84 c0                	test   %al,%al
  8012e6:	75 d8                	jne    8012c0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f4:	29 c2                	sub    %eax,%edx
  8012f6:	89 d0                	mov    %edx,%eax
}
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8012fd:	eb 06                	jmp    801305 <strcmp+0xb>
		p++, q++;
  8012ff:	ff 45 08             	incl   0x8(%ebp)
  801302:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	8a 00                	mov    (%eax),%al
  80130a:	84 c0                	test   %al,%al
  80130c:	74 0e                	je     80131c <strcmp+0x22>
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 10                	mov    (%eax),%dl
  801313:	8b 45 0c             	mov    0xc(%ebp),%eax
  801316:	8a 00                	mov    (%eax),%al
  801318:	38 c2                	cmp    %al,%dl
  80131a:	74 e3                	je     8012ff <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	8a 00                	mov    (%eax),%al
  801321:	0f b6 d0             	movzbl %al,%edx
  801324:	8b 45 0c             	mov    0xc(%ebp),%eax
  801327:	8a 00                	mov    (%eax),%al
  801329:	0f b6 c0             	movzbl %al,%eax
  80132c:	29 c2                	sub    %eax,%edx
  80132e:	89 d0                	mov    %edx,%eax
}
  801330:	5d                   	pop    %ebp
  801331:	c3                   	ret    

00801332 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801332:	55                   	push   %ebp
  801333:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801335:	eb 09                	jmp    801340 <strncmp+0xe>
		n--, p++, q++;
  801337:	ff 4d 10             	decl   0x10(%ebp)
  80133a:	ff 45 08             	incl   0x8(%ebp)
  80133d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801340:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801344:	74 17                	je     80135d <strncmp+0x2b>
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	84 c0                	test   %al,%al
  80134d:	74 0e                	je     80135d <strncmp+0x2b>
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 10                	mov    (%eax),%dl
  801354:	8b 45 0c             	mov    0xc(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	38 c2                	cmp    %al,%dl
  80135b:	74 da                	je     801337 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80135d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801361:	75 07                	jne    80136a <strncmp+0x38>
		return 0;
  801363:	b8 00 00 00 00       	mov    $0x0,%eax
  801368:	eb 14                	jmp    80137e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	0f b6 d0             	movzbl %al,%edx
  801372:	8b 45 0c             	mov    0xc(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	0f b6 c0             	movzbl %al,%eax
  80137a:	29 c2                	sub    %eax,%edx
  80137c:	89 d0                	mov    %edx,%eax
}
  80137e:	5d                   	pop    %ebp
  80137f:	c3                   	ret    

00801380 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
  801383:	83 ec 04             	sub    $0x4,%esp
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80138c:	eb 12                	jmp    8013a0 <strchr+0x20>
		if (*s == c)
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801396:	75 05                	jne    80139d <strchr+0x1d>
			return (char *) s;
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	eb 11                	jmp    8013ae <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80139d:	ff 45 08             	incl   0x8(%ebp)
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	84 c0                	test   %al,%al
  8013a7:	75 e5                	jne    80138e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
  8013b3:	83 ec 04             	sub    $0x4,%esp
  8013b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013bc:	eb 0d                	jmp    8013cb <strfind+0x1b>
		if (*s == c)
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c6:	74 0e                	je     8013d6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013c8:	ff 45 08             	incl   0x8(%ebp)
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	8a 00                	mov    (%eax),%al
  8013d0:	84 c0                	test   %al,%al
  8013d2:	75 ea                	jne    8013be <strfind+0xe>
  8013d4:	eb 01                	jmp    8013d7 <strfind+0x27>
		if (*s == c)
			break;
  8013d6:	90                   	nop
	return (char *) s;
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
  8013df:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8013e8:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8013ec:	76 63                	jbe    801451 <memset+0x75>
		uint64 data_block = c;
  8013ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f1:	99                   	cltd   
  8013f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8013f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fe:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801402:	c1 e0 08             	shl    $0x8,%eax
  801405:	09 45 f0             	or     %eax,-0x10(%ebp)
  801408:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80140b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80140e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801411:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801415:	c1 e0 10             	shl    $0x10,%eax
  801418:	09 45 f0             	or     %eax,-0x10(%ebp)
  80141b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  80141e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801421:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801424:	89 c2                	mov    %eax,%edx
  801426:	b8 00 00 00 00       	mov    $0x0,%eax
  80142b:	09 45 f0             	or     %eax,-0x10(%ebp)
  80142e:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801431:	eb 18                	jmp    80144b <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801433:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801436:	8d 41 08             	lea    0x8(%ecx),%eax
  801439:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80143c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80143f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801442:	89 01                	mov    %eax,(%ecx)
  801444:	89 51 04             	mov    %edx,0x4(%ecx)
  801447:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80144b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80144f:	77 e2                	ja     801433 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801451:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801455:	74 23                	je     80147a <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801457:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  80145d:	eb 0e                	jmp    80146d <memset+0x91>
			*p8++ = (uint8)c;
  80145f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801462:	8d 50 01             	lea    0x1(%eax),%edx
  801465:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146b:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80146d:	8b 45 10             	mov    0x10(%ebp),%eax
  801470:	8d 50 ff             	lea    -0x1(%eax),%edx
  801473:	89 55 10             	mov    %edx,0x10(%ebp)
  801476:	85 c0                	test   %eax,%eax
  801478:	75 e5                	jne    80145f <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80147d:	c9                   	leave  
  80147e:	c3                   	ret    

0080147f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
  801482:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801485:	8b 45 0c             	mov    0xc(%ebp),%eax
  801488:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801491:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801495:	76 24                	jbe    8014bb <memcpy+0x3c>
		while(n >= 8){
  801497:	eb 1c                	jmp    8014b5 <memcpy+0x36>
			*d64 = *s64;
  801499:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80149c:	8b 50 04             	mov    0x4(%eax),%edx
  80149f:	8b 00                	mov    (%eax),%eax
  8014a1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014a4:	89 01                	mov    %eax,(%ecx)
  8014a6:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8014a9:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8014ad:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8014b1:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8014b5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014b9:	77 de                	ja     801499 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8014bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014bf:	74 31                	je     8014f2 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8014c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8014c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8014cd:	eb 16                	jmp    8014e5 <memcpy+0x66>
			*d8++ = *s8++;
  8014cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014d2:	8d 50 01             	lea    0x1(%eax),%edx
  8014d5:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8014d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014db:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014de:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8014e1:	8a 12                	mov    (%edx),%dl
  8014e3:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8014e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014eb:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ee:	85 c0                	test   %eax,%eax
  8014f0:	75 dd                	jne    8014cf <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801500:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801509:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80150f:	73 50                	jae    801561 <memmove+0x6a>
  801511:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801514:	8b 45 10             	mov    0x10(%ebp),%eax
  801517:	01 d0                	add    %edx,%eax
  801519:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151c:	76 43                	jbe    801561 <memmove+0x6a>
		s += n;
  80151e:	8b 45 10             	mov    0x10(%ebp),%eax
  801521:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801524:	8b 45 10             	mov    0x10(%ebp),%eax
  801527:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80152a:	eb 10                	jmp    80153c <memmove+0x45>
			*--d = *--s;
  80152c:	ff 4d f8             	decl   -0x8(%ebp)
  80152f:	ff 4d fc             	decl   -0x4(%ebp)
  801532:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801535:	8a 10                	mov    (%eax),%dl
  801537:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80153c:	8b 45 10             	mov    0x10(%ebp),%eax
  80153f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801542:	89 55 10             	mov    %edx,0x10(%ebp)
  801545:	85 c0                	test   %eax,%eax
  801547:	75 e3                	jne    80152c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801549:	eb 23                	jmp    80156e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80154b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154e:	8d 50 01             	lea    0x1(%eax),%edx
  801551:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801554:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801557:	8d 4a 01             	lea    0x1(%edx),%ecx
  80155a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80155d:	8a 12                	mov    (%edx),%dl
  80155f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801561:	8b 45 10             	mov    0x10(%ebp),%eax
  801564:	8d 50 ff             	lea    -0x1(%eax),%edx
  801567:	89 55 10             	mov    %edx,0x10(%ebp)
  80156a:	85 c0                	test   %eax,%eax
  80156c:	75 dd                	jne    80154b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
  801576:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80157f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801582:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801585:	eb 2a                	jmp    8015b1 <memcmp+0x3e>
		if (*s1 != *s2)
  801587:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158a:	8a 10                	mov    (%eax),%dl
  80158c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	38 c2                	cmp    %al,%dl
  801593:	74 16                	je     8015ab <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801595:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801598:	8a 00                	mov    (%eax),%al
  80159a:	0f b6 d0             	movzbl %al,%edx
  80159d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a0:	8a 00                	mov    (%eax),%al
  8015a2:	0f b6 c0             	movzbl %al,%eax
  8015a5:	29 c2                	sub    %eax,%edx
  8015a7:	89 d0                	mov    %edx,%eax
  8015a9:	eb 18                	jmp    8015c3 <memcmp+0x50>
		s1++, s2++;
  8015ab:	ff 45 fc             	incl   -0x4(%ebp)
  8015ae:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ba:	85 c0                	test   %eax,%eax
  8015bc:	75 c9                	jne    801587 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d1:	01 d0                	add    %edx,%eax
  8015d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015d6:	eb 15                	jmp    8015ed <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	0f b6 d0             	movzbl %al,%edx
  8015e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e3:	0f b6 c0             	movzbl %al,%eax
  8015e6:	39 c2                	cmp    %eax,%edx
  8015e8:	74 0d                	je     8015f7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015ea:	ff 45 08             	incl   0x8(%ebp)
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015f3:	72 e3                	jb     8015d8 <memfind+0x13>
  8015f5:	eb 01                	jmp    8015f8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015f7:	90                   	nop
	return (void *) s;
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
  801600:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801603:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80160a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801611:	eb 03                	jmp    801616 <strtol+0x19>
		s++;
  801613:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	3c 20                	cmp    $0x20,%al
  80161d:	74 f4                	je     801613 <strtol+0x16>
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	8a 00                	mov    (%eax),%al
  801624:	3c 09                	cmp    $0x9,%al
  801626:	74 eb                	je     801613 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	3c 2b                	cmp    $0x2b,%al
  80162f:	75 05                	jne    801636 <strtol+0x39>
		s++;
  801631:	ff 45 08             	incl   0x8(%ebp)
  801634:	eb 13                	jmp    801649 <strtol+0x4c>
	else if (*s == '-')
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	3c 2d                	cmp    $0x2d,%al
  80163d:	75 0a                	jne    801649 <strtol+0x4c>
		s++, neg = 1;
  80163f:	ff 45 08             	incl   0x8(%ebp)
  801642:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801649:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80164d:	74 06                	je     801655 <strtol+0x58>
  80164f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801653:	75 20                	jne    801675 <strtol+0x78>
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	8a 00                	mov    (%eax),%al
  80165a:	3c 30                	cmp    $0x30,%al
  80165c:	75 17                	jne    801675 <strtol+0x78>
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	40                   	inc    %eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 78                	cmp    $0x78,%al
  801666:	75 0d                	jne    801675 <strtol+0x78>
		s += 2, base = 16;
  801668:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80166c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801673:	eb 28                	jmp    80169d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801675:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801679:	75 15                	jne    801690 <strtol+0x93>
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	3c 30                	cmp    $0x30,%al
  801682:	75 0c                	jne    801690 <strtol+0x93>
		s++, base = 8;
  801684:	ff 45 08             	incl   0x8(%ebp)
  801687:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80168e:	eb 0d                	jmp    80169d <strtol+0xa0>
	else if (base == 0)
  801690:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801694:	75 07                	jne    80169d <strtol+0xa0>
		base = 10;
  801696:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	3c 2f                	cmp    $0x2f,%al
  8016a4:	7e 19                	jle    8016bf <strtol+0xc2>
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	8a 00                	mov    (%eax),%al
  8016ab:	3c 39                	cmp    $0x39,%al
  8016ad:	7f 10                	jg     8016bf <strtol+0xc2>
			dig = *s - '0';
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	8a 00                	mov    (%eax),%al
  8016b4:	0f be c0             	movsbl %al,%eax
  8016b7:	83 e8 30             	sub    $0x30,%eax
  8016ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016bd:	eb 42                	jmp    801701 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	3c 60                	cmp    $0x60,%al
  8016c6:	7e 19                	jle    8016e1 <strtol+0xe4>
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	8a 00                	mov    (%eax),%al
  8016cd:	3c 7a                	cmp    $0x7a,%al
  8016cf:	7f 10                	jg     8016e1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	0f be c0             	movsbl %al,%eax
  8016d9:	83 e8 57             	sub    $0x57,%eax
  8016dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016df:	eb 20                	jmp    801701 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	8a 00                	mov    (%eax),%al
  8016e6:	3c 40                	cmp    $0x40,%al
  8016e8:	7e 39                	jle    801723 <strtol+0x126>
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	8a 00                	mov    (%eax),%al
  8016ef:	3c 5a                	cmp    $0x5a,%al
  8016f1:	7f 30                	jg     801723 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8a 00                	mov    (%eax),%al
  8016f8:	0f be c0             	movsbl %al,%eax
  8016fb:	83 e8 37             	sub    $0x37,%eax
  8016fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801701:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801704:	3b 45 10             	cmp    0x10(%ebp),%eax
  801707:	7d 19                	jge    801722 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801709:	ff 45 08             	incl   0x8(%ebp)
  80170c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801713:	89 c2                	mov    %eax,%edx
  801715:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801718:	01 d0                	add    %edx,%eax
  80171a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80171d:	e9 7b ff ff ff       	jmp    80169d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801722:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801723:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801727:	74 08                	je     801731 <strtol+0x134>
		*endptr = (char *) s;
  801729:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172c:	8b 55 08             	mov    0x8(%ebp),%edx
  80172f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801731:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801735:	74 07                	je     80173e <strtol+0x141>
  801737:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173a:	f7 d8                	neg    %eax
  80173c:	eb 03                	jmp    801741 <strtol+0x144>
  80173e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <ltostr>:

void
ltostr(long value, char *str)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
  801746:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801749:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801750:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801757:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80175b:	79 13                	jns    801770 <ltostr+0x2d>
	{
		neg = 1;
  80175d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801764:	8b 45 0c             	mov    0xc(%ebp),%eax
  801767:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80176a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80176d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801778:	99                   	cltd   
  801779:	f7 f9                	idiv   %ecx
  80177b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801781:	8d 50 01             	lea    0x1(%eax),%edx
  801784:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801787:	89 c2                	mov    %eax,%edx
  801789:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178c:	01 d0                	add    %edx,%eax
  80178e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801791:	83 c2 30             	add    $0x30,%edx
  801794:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801796:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801799:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80179e:	f7 e9                	imul   %ecx
  8017a0:	c1 fa 02             	sar    $0x2,%edx
  8017a3:	89 c8                	mov    %ecx,%eax
  8017a5:	c1 f8 1f             	sar    $0x1f,%eax
  8017a8:	29 c2                	sub    %eax,%edx
  8017aa:	89 d0                	mov    %edx,%eax
  8017ac:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8017af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017b3:	75 bb                	jne    801770 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017bf:	48                   	dec    %eax
  8017c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017c7:	74 3d                	je     801806 <ltostr+0xc3>
		start = 1 ;
  8017c9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017d0:	eb 34                	jmp    801806 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8017d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d8:	01 d0                	add    %edx,%eax
  8017da:	8a 00                	mov    (%eax),%al
  8017dc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e5:	01 c2                	add    %eax,%edx
  8017e7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ed:	01 c8                	add    %ecx,%eax
  8017ef:	8a 00                	mov    (%eax),%al
  8017f1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017f3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f9:	01 c2                	add    %eax,%edx
  8017fb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017fe:	88 02                	mov    %al,(%edx)
		start++ ;
  801800:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801803:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801806:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801809:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80180c:	7c c4                	jl     8017d2 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80180e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801811:	8b 45 0c             	mov    0xc(%ebp),%eax
  801814:	01 d0                	add    %edx,%eax
  801816:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801819:	90                   	nop
  80181a:	c9                   	leave  
  80181b:	c3                   	ret    

0080181c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80181c:	55                   	push   %ebp
  80181d:	89 e5                	mov    %esp,%ebp
  80181f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801822:	ff 75 08             	pushl  0x8(%ebp)
  801825:	e8 c4 f9 ff ff       	call   8011ee <strlen>
  80182a:	83 c4 04             	add    $0x4,%esp
  80182d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801830:	ff 75 0c             	pushl  0xc(%ebp)
  801833:	e8 b6 f9 ff ff       	call   8011ee <strlen>
  801838:	83 c4 04             	add    $0x4,%esp
  80183b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80183e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801845:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80184c:	eb 17                	jmp    801865 <strcconcat+0x49>
		final[s] = str1[s] ;
  80184e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801851:	8b 45 10             	mov    0x10(%ebp),%eax
  801854:	01 c2                	add    %eax,%edx
  801856:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	01 c8                	add    %ecx,%eax
  80185e:	8a 00                	mov    (%eax),%al
  801860:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801862:	ff 45 fc             	incl   -0x4(%ebp)
  801865:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801868:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80186b:	7c e1                	jl     80184e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80186d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801874:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80187b:	eb 1f                	jmp    80189c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80187d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801880:	8d 50 01             	lea    0x1(%eax),%edx
  801883:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801886:	89 c2                	mov    %eax,%edx
  801888:	8b 45 10             	mov    0x10(%ebp),%eax
  80188b:	01 c2                	add    %eax,%edx
  80188d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801890:	8b 45 0c             	mov    0xc(%ebp),%eax
  801893:	01 c8                	add    %ecx,%eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801899:	ff 45 f8             	incl   -0x8(%ebp)
  80189c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018a2:	7c d9                	jl     80187d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018aa:	01 d0                	add    %edx,%eax
  8018ac:	c6 00 00             	movb   $0x0,(%eax)
}
  8018af:	90                   	nop
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018be:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c1:	8b 00                	mov    (%eax),%eax
  8018c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cd:	01 d0                	add    %edx,%eax
  8018cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018d5:	eb 0c                	jmp    8018e3 <strsplit+0x31>
			*string++ = 0;
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	8d 50 01             	lea    0x1(%eax),%edx
  8018dd:	89 55 08             	mov    %edx,0x8(%ebp)
  8018e0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	8a 00                	mov    (%eax),%al
  8018e8:	84 c0                	test   %al,%al
  8018ea:	74 18                	je     801904 <strsplit+0x52>
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	8a 00                	mov    (%eax),%al
  8018f1:	0f be c0             	movsbl %al,%eax
  8018f4:	50                   	push   %eax
  8018f5:	ff 75 0c             	pushl  0xc(%ebp)
  8018f8:	e8 83 fa ff ff       	call   801380 <strchr>
  8018fd:	83 c4 08             	add    $0x8,%esp
  801900:	85 c0                	test   %eax,%eax
  801902:	75 d3                	jne    8018d7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8a 00                	mov    (%eax),%al
  801909:	84 c0                	test   %al,%al
  80190b:	74 5a                	je     801967 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80190d:	8b 45 14             	mov    0x14(%ebp),%eax
  801910:	8b 00                	mov    (%eax),%eax
  801912:	83 f8 0f             	cmp    $0xf,%eax
  801915:	75 07                	jne    80191e <strsplit+0x6c>
		{
			return 0;
  801917:	b8 00 00 00 00       	mov    $0x0,%eax
  80191c:	eb 66                	jmp    801984 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80191e:	8b 45 14             	mov    0x14(%ebp),%eax
  801921:	8b 00                	mov    (%eax),%eax
  801923:	8d 48 01             	lea    0x1(%eax),%ecx
  801926:	8b 55 14             	mov    0x14(%ebp),%edx
  801929:	89 0a                	mov    %ecx,(%edx)
  80192b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801932:	8b 45 10             	mov    0x10(%ebp),%eax
  801935:	01 c2                	add    %eax,%edx
  801937:	8b 45 08             	mov    0x8(%ebp),%eax
  80193a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80193c:	eb 03                	jmp    801941 <strsplit+0x8f>
			string++;
  80193e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801941:	8b 45 08             	mov    0x8(%ebp),%eax
  801944:	8a 00                	mov    (%eax),%al
  801946:	84 c0                	test   %al,%al
  801948:	74 8b                	je     8018d5 <strsplit+0x23>
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	8a 00                	mov    (%eax),%al
  80194f:	0f be c0             	movsbl %al,%eax
  801952:	50                   	push   %eax
  801953:	ff 75 0c             	pushl  0xc(%ebp)
  801956:	e8 25 fa ff ff       	call   801380 <strchr>
  80195b:	83 c4 08             	add    $0x8,%esp
  80195e:	85 c0                	test   %eax,%eax
  801960:	74 dc                	je     80193e <strsplit+0x8c>
			string++;
	}
  801962:	e9 6e ff ff ff       	jmp    8018d5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801967:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801968:	8b 45 14             	mov    0x14(%ebp),%eax
  80196b:	8b 00                	mov    (%eax),%eax
  80196d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801974:	8b 45 10             	mov    0x10(%ebp),%eax
  801977:	01 d0                	add    %edx,%eax
  801979:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80197f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
  801989:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80198c:	8b 45 08             	mov    0x8(%ebp),%eax
  80198f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801992:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801999:	eb 4a                	jmp    8019e5 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80199b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	01 c2                	add    %eax,%edx
  8019a3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a9:	01 c8                	add    %ecx,%eax
  8019ab:	8a 00                	mov    (%eax),%al
  8019ad:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8019af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	8a 00                	mov    (%eax),%al
  8019b9:	3c 40                	cmp    $0x40,%al
  8019bb:	7e 25                	jle    8019e2 <str2lower+0x5c>
  8019bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c3:	01 d0                	add    %edx,%eax
  8019c5:	8a 00                	mov    (%eax),%al
  8019c7:	3c 5a                	cmp    $0x5a,%al
  8019c9:	7f 17                	jg     8019e2 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8019cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	01 d0                	add    %edx,%eax
  8019d3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019d6:	8b 55 08             	mov    0x8(%ebp),%edx
  8019d9:	01 ca                	add    %ecx,%edx
  8019db:	8a 12                	mov    (%edx),%dl
  8019dd:	83 c2 20             	add    $0x20,%edx
  8019e0:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8019e2:	ff 45 fc             	incl   -0x4(%ebp)
  8019e5:	ff 75 0c             	pushl  0xc(%ebp)
  8019e8:	e8 01 f8 ff ff       	call   8011ee <strlen>
  8019ed:	83 c4 04             	add    $0x4,%esp
  8019f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019f3:	7f a6                	jg     80199b <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8019f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019f8:	c9                   	leave  
  8019f9:	c3                   	ret    

008019fa <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
  8019fd:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801a00:	a1 08 30 80 00       	mov    0x803008,%eax
  801a05:	85 c0                	test   %eax,%eax
  801a07:	74 2d                	je     801a36 <uheap_init+0x3c>
	{
		buddy_init();
  801a09:	e8 87 06 00 00       	call   802095 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801a0e:	e8 31 05 00 00       	call   801f44 <sys_get_uheap_strategy>
  801a13:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  801a18:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801a1f:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801a22:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  801a29:	00 00 80 
		__firstTimeFlag = 0;
  801a2c:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801a33:	00 00 00 
	}
}
  801a36:	90                   	nop
  801a37:	c9                   	leave  
  801a38:	c3                   	ret    

00801a39 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801a39:	55                   	push   %ebp
  801a3a:	89 e5                	mov    %esp,%ebp
  801a3c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801a3f:	83 ec 04             	sub    $0x4,%esp
  801a42:	68 c8 2c 80 00       	push   $0x802cc8
  801a47:	6a 25                	push   $0x25
  801a49:	68 f9 2c 80 00       	push   $0x802cf9
  801a4e:	e8 f4 ed ff ff       	call   800847 <_panic>

00801a53 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
  801a56:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801a59:	83 ec 04             	sub    $0x4,%esp
  801a5c:	68 08 2d 80 00       	push   $0x802d08
  801a61:	6a 2f                	push   $0x2f
  801a63:	68 f9 2c 80 00       	push   $0x802cf9
  801a68:	e8 da ed ff ff       	call   800847 <_panic>

00801a6d <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
  801a70:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801a73:	e8 82 ff ff ff       	call   8019fa <uheap_init>
	if (size == 0) return NULL ;
  801a78:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a7c:	75 07                	jne    801a85 <malloc+0x18>
  801a7e:	b8 00 00 00 00       	mov    $0x0,%eax
  801a83:	eb 14                	jmp    801a99 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801a85:	83 ec 04             	sub    $0x4,%esp
  801a88:	68 3c 2d 80 00       	push   $0x802d3c
  801a8d:	6a 43                	push   $0x43
  801a8f:	68 f9 2c 80 00       	push   $0x802cf9
  801a94:	e8 ae ed ff ff       	call   800847 <_panic>
}
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
  801a9e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801aa1:	83 ec 04             	sub    $0x4,%esp
  801aa4:	68 64 2d 80 00       	push   $0x802d64
  801aa9:	6a 4e                	push   $0x4e
  801aab:	68 f9 2c 80 00       	push   $0x802cf9
  801ab0:	e8 92 ed ff ff       	call   800847 <_panic>

00801ab5 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
  801ab8:	83 ec 18             	sub    $0x18,%esp
  801abb:	8b 45 10             	mov    0x10(%ebp),%eax
  801abe:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ac1:	e8 34 ff ff ff       	call   8019fa <uheap_init>
	if (size == 0) return NULL ;
  801ac6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801aca:	75 07                	jne    801ad3 <smalloc+0x1e>
  801acc:	b8 00 00 00 00       	mov    $0x0,%eax
  801ad1:	eb 14                	jmp    801ae7 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801ad3:	83 ec 04             	sub    $0x4,%esp
  801ad6:	68 88 2d 80 00       	push   $0x802d88
  801adb:	6a 5f                	push   $0x5f
  801add:	68 f9 2c 80 00       	push   $0x802cf9
  801ae2:	e8 60 ed ff ff       	call   800847 <_panic>
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
  801aec:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801aef:	e8 06 ff ff ff       	call   8019fa <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801af4:	83 ec 04             	sub    $0x4,%esp
  801af7:	68 b0 2d 80 00       	push   $0x802db0
  801afc:	6a 6f                	push   $0x6f
  801afe:	68 f9 2c 80 00       	push   $0x802cf9
  801b03:	e8 3f ed ff ff       	call   800847 <_panic>

00801b08 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
  801b0b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801b0e:	83 ec 04             	sub    $0x4,%esp
  801b11:	68 d4 2d 80 00       	push   $0x802dd4
  801b16:	6a 7e                	push   $0x7e
  801b18:	68 f9 2c 80 00       	push   $0x802cf9
  801b1d:	e8 25 ed ff ff       	call   800847 <_panic>

00801b22 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
  801b25:	57                   	push   %edi
  801b26:	56                   	push   %esi
  801b27:	53                   	push   %ebx
  801b28:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b31:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b34:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b37:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b3a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b3d:	cd 30                	int    $0x30
  801b3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b42:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b45:	83 c4 10             	add    $0x10,%esp
  801b48:	5b                   	pop    %ebx
  801b49:	5e                   	pop    %esi
  801b4a:	5f                   	pop    %edi
  801b4b:	5d                   	pop    %ebp
  801b4c:	c3                   	ret    

00801b4d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
  801b50:	83 ec 04             	sub    $0x4,%esp
  801b53:	8b 45 10             	mov    0x10(%ebp),%eax
  801b56:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801b59:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b5c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b60:	8b 45 08             	mov    0x8(%ebp),%eax
  801b63:	6a 00                	push   $0x0
  801b65:	51                   	push   %ecx
  801b66:	52                   	push   %edx
  801b67:	ff 75 0c             	pushl  0xc(%ebp)
  801b6a:	50                   	push   %eax
  801b6b:	6a 00                	push   $0x0
  801b6d:	e8 b0 ff ff ff       	call   801b22 <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
}
  801b75:	90                   	nop
  801b76:	c9                   	leave  
  801b77:	c3                   	ret    

00801b78 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b78:	55                   	push   %ebp
  801b79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 02                	push   $0x2
  801b87:	e8 96 ff ff ff       	call   801b22 <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
}
  801b8f:	c9                   	leave  
  801b90:	c3                   	ret    

00801b91 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 03                	push   $0x3
  801ba0:	e8 7d ff ff ff       	call   801b22 <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
}
  801ba8:	90                   	nop
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 04                	push   $0x4
  801bba:	e8 63 ff ff ff       	call   801b22 <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
}
  801bc2:	90                   	nop
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	52                   	push   %edx
  801bd5:	50                   	push   %eax
  801bd6:	6a 08                	push   $0x8
  801bd8:	e8 45 ff ff ff       	call   801b22 <syscall>
  801bdd:	83 c4 18             	add    $0x18,%esp
}
  801be0:	c9                   	leave  
  801be1:	c3                   	ret    

00801be2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
  801be5:	56                   	push   %esi
  801be6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801be7:	8b 75 18             	mov    0x18(%ebp),%esi
  801bea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	56                   	push   %esi
  801bf7:	53                   	push   %ebx
  801bf8:	51                   	push   %ecx
  801bf9:	52                   	push   %edx
  801bfa:	50                   	push   %eax
  801bfb:	6a 09                	push   $0x9
  801bfd:	e8 20 ff ff ff       	call   801b22 <syscall>
  801c02:	83 c4 18             	add    $0x18,%esp
}
  801c05:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c08:	5b                   	pop    %ebx
  801c09:	5e                   	pop    %esi
  801c0a:	5d                   	pop    %ebp
  801c0b:	c3                   	ret    

00801c0c <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	ff 75 08             	pushl  0x8(%ebp)
  801c1a:	6a 0a                	push   $0xa
  801c1c:	e8 01 ff ff ff       	call   801b22 <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	ff 75 08             	pushl  0x8(%ebp)
  801c35:	6a 0b                	push   $0xb
  801c37:	e8 e6 fe ff ff       	call   801b22 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 0c                	push   $0xc
  801c50:	e8 cd fe ff ff       	call   801b22 <syscall>
  801c55:	83 c4 18             	add    $0x18,%esp
}
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 0d                	push   $0xd
  801c69:	e8 b4 fe ff ff       	call   801b22 <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 0e                	push   $0xe
  801c82:	e8 9b fe ff ff       	call   801b22 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
}
  801c8a:	c9                   	leave  
  801c8b:	c3                   	ret    

00801c8c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 0f                	push   $0xf
  801c9b:	e8 82 fe ff ff       	call   801b22 <syscall>
  801ca0:	83 c4 18             	add    $0x18,%esp
}
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	ff 75 08             	pushl  0x8(%ebp)
  801cb3:	6a 10                	push   $0x10
  801cb5:	e8 68 fe ff ff       	call   801b22 <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
}
  801cbd:	c9                   	leave  
  801cbe:	c3                   	ret    

00801cbf <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 11                	push   $0x11
  801cce:	e8 4f fe ff ff       	call   801b22 <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	90                   	nop
  801cd7:	c9                   	leave  
  801cd8:	c3                   	ret    

00801cd9 <sys_cputc>:

void
sys_cputc(const char c)
{
  801cd9:	55                   	push   %ebp
  801cda:	89 e5                	mov    %esp,%ebp
  801cdc:	83 ec 04             	sub    $0x4,%esp
  801cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ce5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	50                   	push   %eax
  801cf2:	6a 01                	push   $0x1
  801cf4:	e8 29 fe ff ff       	call   801b22 <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
}
  801cfc:	90                   	nop
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 14                	push   $0x14
  801d0e:	e8 0f fe ff ff       	call   801b22 <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	90                   	nop
  801d17:	c9                   	leave  
  801d18:	c3                   	ret    

00801d19 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
  801d1c:	83 ec 04             	sub    $0x4,%esp
  801d1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d22:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801d25:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d28:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2f:	6a 00                	push   $0x0
  801d31:	51                   	push   %ecx
  801d32:	52                   	push   %edx
  801d33:	ff 75 0c             	pushl  0xc(%ebp)
  801d36:	50                   	push   %eax
  801d37:	6a 15                	push   $0x15
  801d39:	e8 e4 fd ff ff       	call   801b22 <syscall>
  801d3e:	83 c4 18             	add    $0x18,%esp
}
  801d41:	c9                   	leave  
  801d42:	c3                   	ret    

00801d43 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801d43:	55                   	push   %ebp
  801d44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801d46:	8b 55 10             	mov    0x10(%ebp),%edx
  801d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	52                   	push   %edx
  801d51:	50                   	push   %eax
  801d52:	ff 75 08             	pushl  0x8(%ebp)
  801d55:	6a 16                	push   $0x16
  801d57:	e8 c6 fd ff ff       	call   801b22 <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d64:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d67:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	52                   	push   %edx
  801d71:	50                   	push   %eax
  801d72:	6a 17                	push   $0x17
  801d74:	e8 a9 fd ff ff       	call   801b22 <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d84:	8b 45 08             	mov    0x8(%ebp),%eax
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	52                   	push   %edx
  801d8e:	50                   	push   %eax
  801d8f:	6a 18                	push   $0x18
  801d91:	e8 8c fd ff ff       	call   801b22 <syscall>
  801d96:	83 c4 18             	add    $0x18,%esp
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	ff 75 14             	pushl  0x14(%ebp)
  801da6:	ff 75 10             	pushl  0x10(%ebp)
  801da9:	ff 75 0c             	pushl  0xc(%ebp)
  801dac:	50                   	push   %eax
  801dad:	6a 19                	push   $0x19
  801daf:	e8 6e fd ff ff       	call   801b22 <syscall>
  801db4:	83 c4 18             	add    $0x18,%esp
}
  801db7:	c9                   	leave  
  801db8:	c3                   	ret    

00801db9 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801db9:	55                   	push   %ebp
  801dba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	50                   	push   %eax
  801dc8:	6a 1a                	push   $0x1a
  801dca:	e8 53 fd ff ff       	call   801b22 <syscall>
  801dcf:	83 c4 18             	add    $0x18,%esp
}
  801dd2:	90                   	nop
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	50                   	push   %eax
  801de4:	6a 1b                	push   $0x1b
  801de6:	e8 37 fd ff ff       	call   801b22 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 05                	push   $0x5
  801dff:	e8 1e fd ff ff       	call   801b22 <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
}
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 06                	push   $0x6
  801e18:	e8 05 fd ff ff       	call   801b22 <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    

00801e22 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e22:	55                   	push   %ebp
  801e23:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 07                	push   $0x7
  801e31:	e8 ec fc ff ff       	call   801b22 <syscall>
  801e36:	83 c4 18             	add    $0x18,%esp
}
  801e39:	c9                   	leave  
  801e3a:	c3                   	ret    

00801e3b <sys_exit_env>:


void sys_exit_env(void)
{
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 1c                	push   $0x1c
  801e4a:	e8 d3 fc ff ff       	call   801b22 <syscall>
  801e4f:	83 c4 18             	add    $0x18,%esp
}
  801e52:	90                   	nop
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	ff 75 10             	pushl  0x10(%ebp)
  801e5f:	ff 75 0c             	pushl  0xc(%ebp)
  801e62:	ff 75 08             	pushl  0x8(%ebp)
  801e65:	6a 13                	push   $0x13
  801e67:	e8 b6 fc ff ff       	call   801b22 <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e6f:	90                   	nop
}
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 1e                	push   $0x1e
  801e81:	e8 9c fc ff ff       	call   801b22 <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
  801e8e:	83 ec 04             	sub    $0x4,%esp
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e97:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	50                   	push   %eax
  801ea4:	6a 1f                	push   $0x1f
  801ea6:	e8 77 fc ff ff       	call   801b22 <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
	return ;
  801eae:	90                   	nop
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <rsttst>:
void rsttst()
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 21                	push   $0x21
  801ec0:	e8 5d fc ff ff       	call   801b22 <syscall>
  801ec5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec8:	90                   	nop
}
  801ec9:	c9                   	leave  
  801eca:	c3                   	ret    

00801ecb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ecb:	55                   	push   %ebp
  801ecc:	89 e5                	mov    %esp,%ebp
  801ece:	83 ec 04             	sub    $0x4,%esp
  801ed1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ed7:	8b 55 18             	mov    0x18(%ebp),%edx
  801eda:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	ff 75 10             	pushl  0x10(%ebp)
  801ee3:	ff 75 0c             	pushl  0xc(%ebp)
  801ee6:	ff 75 08             	pushl  0x8(%ebp)
  801ee9:	6a 20                	push   $0x20
  801eeb:	e8 32 fc ff ff       	call   801b22 <syscall>
  801ef0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef3:	90                   	nop
}
  801ef4:	c9                   	leave  
  801ef5:	c3                   	ret    

00801ef6 <chktst>:
void chktst(uint32 n)
{
  801ef6:	55                   	push   %ebp
  801ef7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	ff 75 08             	pushl  0x8(%ebp)
  801f04:	6a 22                	push   $0x22
  801f06:	e8 17 fc ff ff       	call   801b22 <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0e:	90                   	nop
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <inctst>:

void inctst()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 23                	push   $0x23
  801f20:	e8 fd fb ff ff       	call   801b22 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
	return ;
  801f28:	90                   	nop
}
  801f29:	c9                   	leave  
  801f2a:	c3                   	ret    

00801f2b <gettst>:
uint32 gettst()
{
  801f2b:	55                   	push   %ebp
  801f2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 24                	push   $0x24
  801f3a:	e8 e3 fb ff ff       	call   801b22 <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 25                	push   $0x25
  801f53:	e8 ca fb ff ff       	call   801b22 <syscall>
  801f58:	83 c4 18             	add    $0x18,%esp
  801f5b:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801f60:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6d:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	ff 75 08             	pushl  0x8(%ebp)
  801f7d:	6a 26                	push   $0x26
  801f7f:	e8 9e fb ff ff       	call   801b22 <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
	return ;
  801f87:	90                   	nop
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f8e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f91:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f94:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f97:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9a:	6a 00                	push   $0x0
  801f9c:	53                   	push   %ebx
  801f9d:	51                   	push   %ecx
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 27                	push   $0x27
  801fa2:	e8 7b fb ff ff       	call   801b22 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801fad:	c9                   	leave  
  801fae:	c3                   	ret    

00801faf <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801faf:	55                   	push   %ebp
  801fb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801fb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	52                   	push   %edx
  801fbf:	50                   	push   %eax
  801fc0:	6a 28                	push   $0x28
  801fc2:	e8 5b fb ff ff       	call   801b22 <syscall>
  801fc7:	83 c4 18             	add    $0x18,%esp
}
  801fca:	c9                   	leave  
  801fcb:	c3                   	ret    

00801fcc <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801fcc:	55                   	push   %ebp
  801fcd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801fcf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd8:	6a 00                	push   $0x0
  801fda:	51                   	push   %ecx
  801fdb:	ff 75 10             	pushl  0x10(%ebp)
  801fde:	52                   	push   %edx
  801fdf:	50                   	push   %eax
  801fe0:	6a 29                	push   $0x29
  801fe2:	e8 3b fb ff ff       	call   801b22 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	ff 75 10             	pushl  0x10(%ebp)
  801ff6:	ff 75 0c             	pushl  0xc(%ebp)
  801ff9:	ff 75 08             	pushl  0x8(%ebp)
  801ffc:	6a 12                	push   $0x12
  801ffe:	e8 1f fb ff ff       	call   801b22 <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
	return ;
  802006:	90                   	nop
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80200c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200f:	8b 45 08             	mov    0x8(%ebp),%eax
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	52                   	push   %edx
  802019:	50                   	push   %eax
  80201a:	6a 2a                	push   $0x2a
  80201c:	e8 01 fb ff ff       	call   801b22 <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
	return;
  802024:	90                   	nop
}
  802025:	c9                   	leave  
  802026:	c3                   	ret    

00802027 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802027:	55                   	push   %ebp
  802028:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 2b                	push   $0x2b
  802036:	e8 e7 fa ff ff       	call   801b22 <syscall>
  80203b:	83 c4 18             	add    $0x18,%esp
}
  80203e:	c9                   	leave  
  80203f:	c3                   	ret    

00802040 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802040:	55                   	push   %ebp
  802041:	89 e5                	mov    %esp,%ebp
  802043:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802046:	83 ec 04             	sub    $0x4,%esp
  802049:	68 f8 2d 80 00       	push   $0x802df8
  80204e:	68 0a 01 00 00       	push   $0x10a
  802053:	68 08 2e 80 00       	push   $0x802e08
  802058:	e8 ea e7 ff ff       	call   800847 <_panic>

0080205d <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80205d:	55                   	push   %ebp
  80205e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	ff 75 0c             	pushl  0xc(%ebp)
  802069:	ff 75 08             	pushl  0x8(%ebp)
  80206c:	6a 33                	push   $0x33
  80206e:	e8 af fa ff ff       	call   801b22 <syscall>
  802073:	83 c4 18             	add    $0x18,%esp
	return;
  802076:	90                   	nop
}
  802077:	c9                   	leave  
  802078:	c3                   	ret    

00802079 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  802079:	55                   	push   %ebp
  80207a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	ff 75 0c             	pushl  0xc(%ebp)
  802085:	ff 75 08             	pushl  0x8(%ebp)
  802088:	6a 34                	push   $0x34
  80208a:	e8 93 fa ff ff       	call   801b22 <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
	return ;
  802092:	90                   	nop
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
  802098:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80209b:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8020a2:	eb 36                	jmp    8020da <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8020a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020a7:	c1 e0 04             	shl    $0x4,%eax
  8020aa:	05 60 30 80 00       	add    $0x803060,%eax
  8020af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8020b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020b8:	c1 e0 04             	shl    $0x4,%eax
  8020bb:	05 64 30 80 00       	add    $0x803064,%eax
  8020c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8020c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020c9:	c1 e0 04             	shl    $0x4,%eax
  8020cc:	05 6c 30 80 00       	add    $0x80306c,%eax
  8020d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8020d7:	ff 45 fc             	incl   -0x4(%ebp)
  8020da:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  8020de:	7e c4                	jle    8020a4 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  8020e0:	90                   	nop
  8020e1:	c9                   	leave  
  8020e2:	c3                   	ret    

008020e3 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  8020e3:	55                   	push   %ebp
  8020e4:	89 e5                	mov    %esp,%ebp
  8020e6:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  8020e9:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  8020f0:	eb 24                	jmp    802116 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  8020f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8020f5:	c1 e0 04             	shl    $0x4,%eax
  8020f8:	05 6c 30 80 00       	add    $0x80306c,%eax
  8020fd:	8b 00                	mov    (%eax),%eax
  8020ff:	83 ec 04             	sub    $0x4,%esp
  802102:	50                   	push   %eax
  802103:	ff 75 f4             	pushl  -0xc(%ebp)
  802106:	68 18 2e 80 00       	push   $0x802e18
  80210b:	e8 05 ea ff ff       	call   800b15 <cprintf>
  802110:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802113:	ff 45 f4             	incl   -0xc(%ebp)
  802116:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80211a:	7e d6                	jle    8020f2 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  80211c:	90                   	nop
  80211d:	c9                   	leave  
  80211e:	c3                   	ret    

0080211f <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  80211f:	55                   	push   %ebp
  802120:	89 e5                	mov    %esp,%ebp
  802122:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802125:	83 ec 04             	sub    $0x4,%esp
  802128:	68 28 2e 80 00       	push   $0x802e28
  80212d:	6a 33                	push   $0x33
  80212f:	68 49 2e 80 00       	push   $0x802e49
  802134:	e8 0e e7 ff ff       	call   800847 <_panic>

00802139 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  802139:	55                   	push   %ebp
  80213a:	89 e5                	mov    %esp,%ebp
  80213c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  80213f:	83 ec 04             	sub    $0x4,%esp
  802142:	68 61 2e 80 00       	push   $0x802e61
  802147:	6a 3e                	push   $0x3e
  802149:	68 49 2e 80 00       	push   $0x802e49
  80214e:	e8 f4 e6 ff ff       	call   800847 <_panic>

00802153 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
  802156:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  802159:	83 ec 04             	sub    $0x4,%esp
  80215c:	68 7f 2e 80 00       	push   $0x802e7f
  802161:	6a 49                	push   $0x49
  802163:	68 49 2e 80 00       	push   $0x802e49
  802168:	e8 da e6 ff ff       	call   800847 <_panic>

0080216d <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
  802170:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802173:	83 ec 04             	sub    $0x4,%esp
  802176:	68 9c 2e 80 00       	push   $0x802e9c
  80217b:	6a 58                	push   $0x58
  80217d:	68 49 2e 80 00       	push   $0x802e49
  802182:	e8 c0 e6 ff ff       	call   800847 <_panic>
  802187:	90                   	nop

00802188 <__udivdi3>:
  802188:	55                   	push   %ebp
  802189:	57                   	push   %edi
  80218a:	56                   	push   %esi
  80218b:	53                   	push   %ebx
  80218c:	83 ec 1c             	sub    $0x1c,%esp
  80218f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802193:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802197:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80219b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80219f:	89 ca                	mov    %ecx,%edx
  8021a1:	89 f8                	mov    %edi,%eax
  8021a3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021a7:	85 f6                	test   %esi,%esi
  8021a9:	75 2d                	jne    8021d8 <__udivdi3+0x50>
  8021ab:	39 cf                	cmp    %ecx,%edi
  8021ad:	77 65                	ja     802214 <__udivdi3+0x8c>
  8021af:	89 fd                	mov    %edi,%ebp
  8021b1:	85 ff                	test   %edi,%edi
  8021b3:	75 0b                	jne    8021c0 <__udivdi3+0x38>
  8021b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ba:	31 d2                	xor    %edx,%edx
  8021bc:	f7 f7                	div    %edi
  8021be:	89 c5                	mov    %eax,%ebp
  8021c0:	31 d2                	xor    %edx,%edx
  8021c2:	89 c8                	mov    %ecx,%eax
  8021c4:	f7 f5                	div    %ebp
  8021c6:	89 c1                	mov    %eax,%ecx
  8021c8:	89 d8                	mov    %ebx,%eax
  8021ca:	f7 f5                	div    %ebp
  8021cc:	89 cf                	mov    %ecx,%edi
  8021ce:	89 fa                	mov    %edi,%edx
  8021d0:	83 c4 1c             	add    $0x1c,%esp
  8021d3:	5b                   	pop    %ebx
  8021d4:	5e                   	pop    %esi
  8021d5:	5f                   	pop    %edi
  8021d6:	5d                   	pop    %ebp
  8021d7:	c3                   	ret    
  8021d8:	39 ce                	cmp    %ecx,%esi
  8021da:	77 28                	ja     802204 <__udivdi3+0x7c>
  8021dc:	0f bd fe             	bsr    %esi,%edi
  8021df:	83 f7 1f             	xor    $0x1f,%edi
  8021e2:	75 40                	jne    802224 <__udivdi3+0x9c>
  8021e4:	39 ce                	cmp    %ecx,%esi
  8021e6:	72 0a                	jb     8021f2 <__udivdi3+0x6a>
  8021e8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021ec:	0f 87 9e 00 00 00    	ja     802290 <__udivdi3+0x108>
  8021f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f7:	89 fa                	mov    %edi,%edx
  8021f9:	83 c4 1c             	add    $0x1c,%esp
  8021fc:	5b                   	pop    %ebx
  8021fd:	5e                   	pop    %esi
  8021fe:	5f                   	pop    %edi
  8021ff:	5d                   	pop    %ebp
  802200:	c3                   	ret    
  802201:	8d 76 00             	lea    0x0(%esi),%esi
  802204:	31 ff                	xor    %edi,%edi
  802206:	31 c0                	xor    %eax,%eax
  802208:	89 fa                	mov    %edi,%edx
  80220a:	83 c4 1c             	add    $0x1c,%esp
  80220d:	5b                   	pop    %ebx
  80220e:	5e                   	pop    %esi
  80220f:	5f                   	pop    %edi
  802210:	5d                   	pop    %ebp
  802211:	c3                   	ret    
  802212:	66 90                	xchg   %ax,%ax
  802214:	89 d8                	mov    %ebx,%eax
  802216:	f7 f7                	div    %edi
  802218:	31 ff                	xor    %edi,%edi
  80221a:	89 fa                	mov    %edi,%edx
  80221c:	83 c4 1c             	add    $0x1c,%esp
  80221f:	5b                   	pop    %ebx
  802220:	5e                   	pop    %esi
  802221:	5f                   	pop    %edi
  802222:	5d                   	pop    %ebp
  802223:	c3                   	ret    
  802224:	bd 20 00 00 00       	mov    $0x20,%ebp
  802229:	89 eb                	mov    %ebp,%ebx
  80222b:	29 fb                	sub    %edi,%ebx
  80222d:	89 f9                	mov    %edi,%ecx
  80222f:	d3 e6                	shl    %cl,%esi
  802231:	89 c5                	mov    %eax,%ebp
  802233:	88 d9                	mov    %bl,%cl
  802235:	d3 ed                	shr    %cl,%ebp
  802237:	89 e9                	mov    %ebp,%ecx
  802239:	09 f1                	or     %esi,%ecx
  80223b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80223f:	89 f9                	mov    %edi,%ecx
  802241:	d3 e0                	shl    %cl,%eax
  802243:	89 c5                	mov    %eax,%ebp
  802245:	89 d6                	mov    %edx,%esi
  802247:	88 d9                	mov    %bl,%cl
  802249:	d3 ee                	shr    %cl,%esi
  80224b:	89 f9                	mov    %edi,%ecx
  80224d:	d3 e2                	shl    %cl,%edx
  80224f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802253:	88 d9                	mov    %bl,%cl
  802255:	d3 e8                	shr    %cl,%eax
  802257:	09 c2                	or     %eax,%edx
  802259:	89 d0                	mov    %edx,%eax
  80225b:	89 f2                	mov    %esi,%edx
  80225d:	f7 74 24 0c          	divl   0xc(%esp)
  802261:	89 d6                	mov    %edx,%esi
  802263:	89 c3                	mov    %eax,%ebx
  802265:	f7 e5                	mul    %ebp
  802267:	39 d6                	cmp    %edx,%esi
  802269:	72 19                	jb     802284 <__udivdi3+0xfc>
  80226b:	74 0b                	je     802278 <__udivdi3+0xf0>
  80226d:	89 d8                	mov    %ebx,%eax
  80226f:	31 ff                	xor    %edi,%edi
  802271:	e9 58 ff ff ff       	jmp    8021ce <__udivdi3+0x46>
  802276:	66 90                	xchg   %ax,%ax
  802278:	8b 54 24 08          	mov    0x8(%esp),%edx
  80227c:	89 f9                	mov    %edi,%ecx
  80227e:	d3 e2                	shl    %cl,%edx
  802280:	39 c2                	cmp    %eax,%edx
  802282:	73 e9                	jae    80226d <__udivdi3+0xe5>
  802284:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802287:	31 ff                	xor    %edi,%edi
  802289:	e9 40 ff ff ff       	jmp    8021ce <__udivdi3+0x46>
  80228e:	66 90                	xchg   %ax,%ax
  802290:	31 c0                	xor    %eax,%eax
  802292:	e9 37 ff ff ff       	jmp    8021ce <__udivdi3+0x46>
  802297:	90                   	nop

00802298 <__umoddi3>:
  802298:	55                   	push   %ebp
  802299:	57                   	push   %edi
  80229a:	56                   	push   %esi
  80229b:	53                   	push   %ebx
  80229c:	83 ec 1c             	sub    $0x1c,%esp
  80229f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022a3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022ab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022af:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022b3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022b7:	89 f3                	mov    %esi,%ebx
  8022b9:	89 fa                	mov    %edi,%edx
  8022bb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022bf:	89 34 24             	mov    %esi,(%esp)
  8022c2:	85 c0                	test   %eax,%eax
  8022c4:	75 1a                	jne    8022e0 <__umoddi3+0x48>
  8022c6:	39 f7                	cmp    %esi,%edi
  8022c8:	0f 86 a2 00 00 00    	jbe    802370 <__umoddi3+0xd8>
  8022ce:	89 c8                	mov    %ecx,%eax
  8022d0:	89 f2                	mov    %esi,%edx
  8022d2:	f7 f7                	div    %edi
  8022d4:	89 d0                	mov    %edx,%eax
  8022d6:	31 d2                	xor    %edx,%edx
  8022d8:	83 c4 1c             	add    $0x1c,%esp
  8022db:	5b                   	pop    %ebx
  8022dc:	5e                   	pop    %esi
  8022dd:	5f                   	pop    %edi
  8022de:	5d                   	pop    %ebp
  8022df:	c3                   	ret    
  8022e0:	39 f0                	cmp    %esi,%eax
  8022e2:	0f 87 ac 00 00 00    	ja     802394 <__umoddi3+0xfc>
  8022e8:	0f bd e8             	bsr    %eax,%ebp
  8022eb:	83 f5 1f             	xor    $0x1f,%ebp
  8022ee:	0f 84 ac 00 00 00    	je     8023a0 <__umoddi3+0x108>
  8022f4:	bf 20 00 00 00       	mov    $0x20,%edi
  8022f9:	29 ef                	sub    %ebp,%edi
  8022fb:	89 fe                	mov    %edi,%esi
  8022fd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802301:	89 e9                	mov    %ebp,%ecx
  802303:	d3 e0                	shl    %cl,%eax
  802305:	89 d7                	mov    %edx,%edi
  802307:	89 f1                	mov    %esi,%ecx
  802309:	d3 ef                	shr    %cl,%edi
  80230b:	09 c7                	or     %eax,%edi
  80230d:	89 e9                	mov    %ebp,%ecx
  80230f:	d3 e2                	shl    %cl,%edx
  802311:	89 14 24             	mov    %edx,(%esp)
  802314:	89 d8                	mov    %ebx,%eax
  802316:	d3 e0                	shl    %cl,%eax
  802318:	89 c2                	mov    %eax,%edx
  80231a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80231e:	d3 e0                	shl    %cl,%eax
  802320:	89 44 24 04          	mov    %eax,0x4(%esp)
  802324:	8b 44 24 08          	mov    0x8(%esp),%eax
  802328:	89 f1                	mov    %esi,%ecx
  80232a:	d3 e8                	shr    %cl,%eax
  80232c:	09 d0                	or     %edx,%eax
  80232e:	d3 eb                	shr    %cl,%ebx
  802330:	89 da                	mov    %ebx,%edx
  802332:	f7 f7                	div    %edi
  802334:	89 d3                	mov    %edx,%ebx
  802336:	f7 24 24             	mull   (%esp)
  802339:	89 c6                	mov    %eax,%esi
  80233b:	89 d1                	mov    %edx,%ecx
  80233d:	39 d3                	cmp    %edx,%ebx
  80233f:	0f 82 87 00 00 00    	jb     8023cc <__umoddi3+0x134>
  802345:	0f 84 91 00 00 00    	je     8023dc <__umoddi3+0x144>
  80234b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80234f:	29 f2                	sub    %esi,%edx
  802351:	19 cb                	sbb    %ecx,%ebx
  802353:	89 d8                	mov    %ebx,%eax
  802355:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802359:	d3 e0                	shl    %cl,%eax
  80235b:	89 e9                	mov    %ebp,%ecx
  80235d:	d3 ea                	shr    %cl,%edx
  80235f:	09 d0                	or     %edx,%eax
  802361:	89 e9                	mov    %ebp,%ecx
  802363:	d3 eb                	shr    %cl,%ebx
  802365:	89 da                	mov    %ebx,%edx
  802367:	83 c4 1c             	add    $0x1c,%esp
  80236a:	5b                   	pop    %ebx
  80236b:	5e                   	pop    %esi
  80236c:	5f                   	pop    %edi
  80236d:	5d                   	pop    %ebp
  80236e:	c3                   	ret    
  80236f:	90                   	nop
  802370:	89 fd                	mov    %edi,%ebp
  802372:	85 ff                	test   %edi,%edi
  802374:	75 0b                	jne    802381 <__umoddi3+0xe9>
  802376:	b8 01 00 00 00       	mov    $0x1,%eax
  80237b:	31 d2                	xor    %edx,%edx
  80237d:	f7 f7                	div    %edi
  80237f:	89 c5                	mov    %eax,%ebp
  802381:	89 f0                	mov    %esi,%eax
  802383:	31 d2                	xor    %edx,%edx
  802385:	f7 f5                	div    %ebp
  802387:	89 c8                	mov    %ecx,%eax
  802389:	f7 f5                	div    %ebp
  80238b:	89 d0                	mov    %edx,%eax
  80238d:	e9 44 ff ff ff       	jmp    8022d6 <__umoddi3+0x3e>
  802392:	66 90                	xchg   %ax,%ax
  802394:	89 c8                	mov    %ecx,%eax
  802396:	89 f2                	mov    %esi,%edx
  802398:	83 c4 1c             	add    $0x1c,%esp
  80239b:	5b                   	pop    %ebx
  80239c:	5e                   	pop    %esi
  80239d:	5f                   	pop    %edi
  80239e:	5d                   	pop    %ebp
  80239f:	c3                   	ret    
  8023a0:	3b 04 24             	cmp    (%esp),%eax
  8023a3:	72 06                	jb     8023ab <__umoddi3+0x113>
  8023a5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023a9:	77 0f                	ja     8023ba <__umoddi3+0x122>
  8023ab:	89 f2                	mov    %esi,%edx
  8023ad:	29 f9                	sub    %edi,%ecx
  8023af:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023b3:	89 14 24             	mov    %edx,(%esp)
  8023b6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ba:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023be:	8b 14 24             	mov    (%esp),%edx
  8023c1:	83 c4 1c             	add    $0x1c,%esp
  8023c4:	5b                   	pop    %ebx
  8023c5:	5e                   	pop    %esi
  8023c6:	5f                   	pop    %edi
  8023c7:	5d                   	pop    %ebp
  8023c8:	c3                   	ret    
  8023c9:	8d 76 00             	lea    0x0(%esi),%esi
  8023cc:	2b 04 24             	sub    (%esp),%eax
  8023cf:	19 fa                	sbb    %edi,%edx
  8023d1:	89 d1                	mov    %edx,%ecx
  8023d3:	89 c6                	mov    %eax,%esi
  8023d5:	e9 71 ff ff ff       	jmp    80234b <__umoddi3+0xb3>
  8023da:	66 90                	xchg   %ax,%ax
  8023dc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023e0:	72 ea                	jb     8023cc <__umoddi3+0x134>
  8023e2:	89 d9                	mov    %ebx,%ecx
  8023e4:	e9 62 ff ff ff       	jmp    80234b <__umoddi3+0xb3>
