
obj/user/sc_qs_leakage_small:     file format elf32-i386


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
  800031:	e8 a3 05 00 00       	call   8005d9 <libmain>
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
		//2012: lock the interrupt
		sys_lock_cons();
  800041:	e8 3d 1b 00 00       	call   801b83 <sys_lock_cons>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 e0 23 80 00       	push   $0x8023e0
  80004e:	e8 b4 0a 00 00       	call   800b07 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 e2 23 80 00       	push   $0x8023e2
  80005e:	e8 a4 0a 00 00       	call   800b07 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 fb 23 80 00       	push   $0x8023fb
  80006e:	e8 94 0a 00 00       	call   800b07 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 e2 23 80 00       	push   $0x8023e2
  80007e:	e8 84 0a 00 00       	call   800b07 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 e0 23 80 00       	push   $0x8023e0
  80008e:	e8 74 0a 00 00       	call   800b07 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		int NumOfElements = 20000 ;
  800096:	c7 45 f4 20 4e 00 00 	movl   $0x4e20,-0xc(%ebp)
		cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  80009d:	83 ec 08             	sub    $0x8,%esp
  8000a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8000a3:	68 14 24 80 00       	push   $0x802414
  8000a8:	e8 5a 0a 00 00       	call   800b07 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp
		cprintf("Chose the initialization method:\n") ;
  8000b0:	83 ec 0c             	sub    $0xc,%esp
  8000b3:	68 38 24 80 00       	push   $0x802438
  8000b8:	e8 4a 0a 00 00       	call   800b07 <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	68 5a 24 80 00       	push   $0x80245a
  8000c8:	e8 3a 0a 00 00       	call   800b07 <cprintf>
  8000cd:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 68 24 80 00       	push   $0x802468
  8000d8:	e8 2a 0a 00 00       	call   800b07 <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000e0:	83 ec 0c             	sub    $0xc,%esp
  8000e3:	68 77 24 80 00       	push   $0x802477
  8000e8:	e8 1a 0a 00 00       	call   800b07 <cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000f0:	83 ec 0c             	sub    $0xc,%esp
  8000f3:	68 87 24 80 00       	push   $0x802487
  8000f8:	e8 0a 0a 00 00       	call   800b07 <cprintf>
  8000fd:	83 c4 10             	add    $0x10,%esp
			Chose = 'c' ;
  800100:	c6 45 f3 63          	movb   $0x63,-0xd(%ebp)
			cputchar(Chose);
  800104:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 86 04 00 00       	call   800597 <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 79 04 00 00       	call   800597 <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800121:	80 7d f3 61          	cmpb   $0x61,-0xd(%ebp)
  800125:	74 0c                	je     800133 <_main+0xfb>
  800127:	80 7d f3 62          	cmpb   $0x62,-0xd(%ebp)
  80012b:	74 06                	je     800133 <_main+0xfb>
  80012d:	80 7d f3 63          	cmpb   $0x63,-0xd(%ebp)
  800131:	75 bd                	jne    8000f0 <_main+0xb8>

		//2012: lock the interrupt
		sys_unlock_cons();
  800133:	e8 65 1a 00 00       	call   801b9d <sys_unlock_cons>

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800138:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80013b:	c1 e0 02             	shl    $0x2,%eax
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	50                   	push   %eax
  800142:	e8 18 19 00 00       	call   801a5f <malloc>
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
  800169:	e8 e4 02 00 00       	call   800452 <InitializeAscending>
  80016e:	83 c4 10             	add    $0x10,%esp
			break ;
  800171:	eb 37                	jmp    8001aa <_main+0x172>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	ff 75 f4             	pushl  -0xc(%ebp)
  800179:	ff 75 ec             	pushl  -0x14(%ebp)
  80017c:	e8 02 03 00 00       	call   800483 <InitializeIdentical>
  800181:	83 c4 10             	add    $0x10,%esp
			break ;
  800184:	eb 24                	jmp    8001aa <_main+0x172>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 f4             	pushl  -0xc(%ebp)
  80018c:	ff 75 ec             	pushl  -0x14(%ebp)
  80018f:	e8 24 03 00 00       	call   8004b8 <InitializeSemiRandom>
  800194:	83 c4 10             	add    $0x10,%esp
			break ;
  800197:	eb 11                	jmp    8001aa <_main+0x172>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800199:	83 ec 08             	sub    $0x8,%esp
  80019c:	ff 75 f4             	pushl  -0xc(%ebp)
  80019f:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a2:	e8 11 03 00 00       	call   8004b8 <InitializeSemiRandom>
  8001a7:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001aa:	83 ec 08             	sub    $0x8,%esp
  8001ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b3:	e8 df 00 00 00       	call   800297 <QuickSort>
  8001b8:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001bb:	e8 c3 19 00 00       	call   801b83 <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001c0:	83 ec 0c             	sub    $0xc,%esp
  8001c3:	68 90 24 80 00       	push   $0x802490
  8001c8:	e8 3a 09 00 00       	call   800b07 <cprintf>
  8001cd:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  8001d0:	e8 c8 19 00 00       	call   801b9d <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d5:	83 ec 08             	sub    $0x8,%esp
  8001d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8001db:	ff 75 ec             	pushl  -0x14(%ebp)
  8001de:	e8 c5 01 00 00       	call   8003a8 <CheckSorted>
  8001e3:	83 c4 10             	add    $0x10,%esp
  8001e6:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ed:	75 14                	jne    800203 <_main+0x1cb>
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	68 c4 24 80 00       	push   $0x8024c4
  8001f7:	6a 4a                	push   $0x4a
  8001f9:	68 e6 24 80 00       	push   $0x8024e6
  8001fe:	e8 36 06 00 00       	call   800839 <_panic>
		else
		{
			sys_lock_cons();
  800203:	e8 7b 19 00 00       	call   801b83 <sys_lock_cons>
			cprintf("===============================================\n") ;
  800208:	83 ec 0c             	sub    $0xc,%esp
  80020b:	68 04 25 80 00       	push   $0x802504
  800210:	e8 f2 08 00 00       	call   800b07 <cprintf>
  800215:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 38 25 80 00       	push   $0x802538
  800220:	e8 e2 08 00 00       	call   800b07 <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 6c 25 80 00       	push   $0x80256c
  800230:	e8 d2 08 00 00       	call   800b07 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  800238:	e8 60 19 00 00       	call   801b9d <sys_unlock_cons>

		}

		//free(Elements) ;

		sys_lock_cons();
  80023d:	e8 41 19 00 00       	call   801b83 <sys_lock_cons>

		cprintf("Do you want to repeat (y/n): ") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 9e 25 80 00       	push   $0x80259e
  80024a:	e8 b8 08 00 00       	call   800b07 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
		Chose = 'n' ;
  800252:	c6 45 f3 6e          	movb   $0x6e,-0xd(%ebp)
		cputchar(Chose);
  800256:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	50                   	push   %eax
  80025e:	e8 34 03 00 00       	call   800597 <cputchar>
  800263:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	6a 0a                	push   $0xa
  80026b:	e8 27 03 00 00       	call   800597 <cputchar>
  800270:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800273:	83 ec 0c             	sub    $0xc,%esp
  800276:	6a 0a                	push   $0xa
  800278:	e8 1a 03 00 00       	call   800597 <cputchar>
  80027d:	83 c4 10             	add    $0x10,%esp
		sys_unlock_cons();
  800280:	e8 18 19 00 00       	call   801b9d <sys_unlock_cons>

	} while (Chose == 'y');
  800285:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  800289:	0f 84 b2 fd ff ff    	je     800041 <_main+0x9>

	//To indicate that it's completed successfully
	inctst();
  80028f:	e8 6f 1c 00 00       	call   801f03 <inctst>
}
  800294:	90                   	nop
  800295:	c9                   	leave  
  800296:	c3                   	ret    

00800297 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800297:	55                   	push   %ebp
  800298:	89 e5                	mov    %esp,%ebp
  80029a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80029d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a0:	48                   	dec    %eax
  8002a1:	50                   	push   %eax
  8002a2:	6a 00                	push   $0x0
  8002a4:	ff 75 0c             	pushl  0xc(%ebp)
  8002a7:	ff 75 08             	pushl  0x8(%ebp)
  8002aa:	e8 06 00 00 00       	call   8002b5 <QSort>
  8002af:	83 c4 10             	add    $0x10,%esp
}
  8002b2:	90                   	nop
  8002b3:	c9                   	leave  
  8002b4:	c3                   	ret    

008002b5 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002b5:	55                   	push   %ebp
  8002b6:	89 e5                	mov    %esp,%ebp
  8002b8:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8002be:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002c1:	0f 8d de 00 00 00    	jge    8003a5 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ca:	40                   	inc    %eax
  8002cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8002d1:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002d4:	e9 80 00 00 00       	jmp    800359 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002d9:	ff 45 f4             	incl   -0xc(%ebp)
  8002dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002df:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002e2:	7f 2b                	jg     80030f <QSort+0x5a>
  8002e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f1:	01 d0                	add    %edx,%eax
  8002f3:	8b 10                	mov    (%eax),%edx
  8002f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800302:	01 c8                	add    %ecx,%eax
  800304:	8b 00                	mov    (%eax),%eax
  800306:	39 c2                	cmp    %eax,%edx
  800308:	7d cf                	jge    8002d9 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80030a:	eb 03                	jmp    80030f <QSort+0x5a>
  80030c:	ff 4d f0             	decl   -0x10(%ebp)
  80030f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800312:	3b 45 10             	cmp    0x10(%ebp),%eax
  800315:	7e 26                	jle    80033d <QSort+0x88>
  800317:	8b 45 10             	mov    0x10(%ebp),%eax
  80031a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800321:	8b 45 08             	mov    0x8(%ebp),%eax
  800324:	01 d0                	add    %edx,%eax
  800326:	8b 10                	mov    (%eax),%edx
  800328:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800332:	8b 45 08             	mov    0x8(%ebp),%eax
  800335:	01 c8                	add    %ecx,%eax
  800337:	8b 00                	mov    (%eax),%eax
  800339:	39 c2                	cmp    %eax,%edx
  80033b:	7e cf                	jle    80030c <QSort+0x57>

		if (i <= j)
  80033d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800340:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800343:	7f 14                	jg     800359 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	ff 75 f0             	pushl  -0x10(%ebp)
  80034b:	ff 75 f4             	pushl  -0xc(%ebp)
  80034e:	ff 75 08             	pushl  0x8(%ebp)
  800351:	e8 a9 00 00 00       	call   8003ff <Swap>
  800356:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800359:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035f:	0f 8e 77 ff ff ff    	jle    8002dc <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	ff 75 f0             	pushl  -0x10(%ebp)
  80036b:	ff 75 10             	pushl  0x10(%ebp)
  80036e:	ff 75 08             	pushl  0x8(%ebp)
  800371:	e8 89 00 00 00       	call   8003ff <Swap>
  800376:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800379:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037c:	48                   	dec    %eax
  80037d:	50                   	push   %eax
  80037e:	ff 75 10             	pushl  0x10(%ebp)
  800381:	ff 75 0c             	pushl  0xc(%ebp)
  800384:	ff 75 08             	pushl  0x8(%ebp)
  800387:	e8 29 ff ff ff       	call   8002b5 <QSort>
  80038c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80038f:	ff 75 14             	pushl  0x14(%ebp)
  800392:	ff 75 f4             	pushl  -0xc(%ebp)
  800395:	ff 75 0c             	pushl  0xc(%ebp)
  800398:	ff 75 08             	pushl  0x8(%ebp)
  80039b:	e8 15 ff ff ff       	call   8002b5 <QSort>
  8003a0:	83 c4 10             	add    $0x10,%esp
  8003a3:	eb 01                	jmp    8003a6 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003a5:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003a6:	c9                   	leave  
  8003a7:	c3                   	ret    

008003a8 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003a8:	55                   	push   %ebp
  8003a9:	89 e5                	mov    %esp,%ebp
  8003ab:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003ae:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003b5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003bc:	eb 33                	jmp    8003f1 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	01 d0                	add    %edx,%eax
  8003cd:	8b 10                	mov    (%eax),%edx
  8003cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003d2:	40                   	inc    %eax
  8003d3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	01 c8                	add    %ecx,%eax
  8003df:	8b 00                	mov    (%eax),%eax
  8003e1:	39 c2                	cmp    %eax,%edx
  8003e3:	7e 09                	jle    8003ee <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ec:	eb 0c                	jmp    8003fa <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ee:	ff 45 f8             	incl   -0x8(%ebp)
  8003f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f4:	48                   	dec    %eax
  8003f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003f8:	7f c4                	jg     8003be <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003fd:	c9                   	leave  
  8003fe:	c3                   	ret    

008003ff <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003ff:	55                   	push   %ebp
  800400:	89 e5                	mov    %esp,%ebp
  800402:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800405:	8b 45 0c             	mov    0xc(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	01 d0                	add    %edx,%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	01 c2                	add    %eax,%edx
  800428:	8b 45 10             	mov    0x10(%ebp),%eax
  80042b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	01 c8                	add    %ecx,%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80043b:	8b 45 10             	mov    0x10(%ebp),%eax
  80043e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	01 c2                	add    %eax,%edx
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044d:	89 02                	mov    %eax,(%edx)
}
  80044f:	90                   	nop
  800450:	c9                   	leave  
  800451:	c3                   	ret    

00800452 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800452:	55                   	push   %ebp
  800453:	89 e5                	mov    %esp,%ebp
  800455:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800458:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80045f:	eb 17                	jmp    800478 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800461:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 c2                	add    %eax,%edx
  800470:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800473:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800475:	ff 45 fc             	incl   -0x4(%ebp)
  800478:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80047e:	7c e1                	jl     800461 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800480:	90                   	nop
  800481:	c9                   	leave  
  800482:	c3                   	ret    

00800483 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800483:	55                   	push   %ebp
  800484:	89 e5                	mov    %esp,%ebp
  800486:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800489:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800490:	eb 1b                	jmp    8004ad <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800492:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800495:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	01 c2                	add    %eax,%edx
  8004a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a4:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004a7:	48                   	dec    %eax
  8004a8:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004aa:	ff 45 fc             	incl   -0x4(%ebp)
  8004ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004b3:	7c dd                	jl     800492 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004b5:	90                   	nop
  8004b6:	c9                   	leave  
  8004b7:	c3                   	ret    

008004b8 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004b8:	55                   	push   %ebp
  8004b9:	89 e5                	mov    %esp,%ebp
  8004bb:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004c1:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004c6:	f7 e9                	imul   %ecx
  8004c8:	c1 f9 1f             	sar    $0x1f,%ecx
  8004cb:	89 d0                	mov    %edx,%eax
  8004cd:	29 c8                	sub    %ecx,%eax
  8004cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8004d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8004d6:	75 07                	jne    8004df <InitializeSemiRandom+0x27>
			Repetition = 3;
  8004d8:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e6:	eb 1e                	jmp    800506 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8004e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f5:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004fb:	99                   	cltd   
  8004fc:	f7 7d f8             	idivl  -0x8(%ebp)
  8004ff:	89 d0                	mov    %edx,%eax
  800501:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800503:	ff 45 fc             	incl   -0x4(%ebp)
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80050c:	7c da                	jl     8004e8 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80050e:	90                   	nop
  80050f:	c9                   	leave  
  800510:	c3                   	ret    

00800511 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800511:	55                   	push   %ebp
  800512:	89 e5                	mov    %esp,%ebp
  800514:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800517:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80051e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800525:	eb 42                	jmp    800569 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800527:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80052a:	99                   	cltd   
  80052b:	f7 7d f0             	idivl  -0x10(%ebp)
  80052e:	89 d0                	mov    %edx,%eax
  800530:	85 c0                	test   %eax,%eax
  800532:	75 10                	jne    800544 <PrintElements+0x33>
			cprintf("\n");
  800534:	83 ec 0c             	sub    $0xc,%esp
  800537:	68 e0 23 80 00       	push   $0x8023e0
  80053c:	e8 c6 05 00 00       	call   800b07 <cprintf>
  800541:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800544:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800547:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054e:	8b 45 08             	mov    0x8(%ebp),%eax
  800551:	01 d0                	add    %edx,%eax
  800553:	8b 00                	mov    (%eax),%eax
  800555:	83 ec 08             	sub    $0x8,%esp
  800558:	50                   	push   %eax
  800559:	68 bc 25 80 00       	push   $0x8025bc
  80055e:	e8 a4 05 00 00       	call   800b07 <cprintf>
  800563:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800566:	ff 45 f4             	incl   -0xc(%ebp)
  800569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80056c:	48                   	dec    %eax
  80056d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800570:	7f b5                	jg     800527 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800572:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800575:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	01 d0                	add    %edx,%eax
  800581:	8b 00                	mov    (%eax),%eax
  800583:	83 ec 08             	sub    $0x8,%esp
  800586:	50                   	push   %eax
  800587:	68 c1 25 80 00       	push   $0x8025c1
  80058c:	e8 76 05 00 00       	call   800b07 <cprintf>
  800591:	83 c4 10             	add    $0x10,%esp

}
  800594:	90                   	nop
  800595:	c9                   	leave  
  800596:	c3                   	ret    

00800597 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800597:	55                   	push   %ebp
  800598:	89 e5                	mov    %esp,%ebp
  80059a:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80059d:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a0:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005a3:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005a7:	83 ec 0c             	sub    $0xc,%esp
  8005aa:	50                   	push   %eax
  8005ab:	e8 1b 17 00 00       	call   801ccb <sys_cputc>
  8005b0:	83 c4 10             	add    $0x10,%esp
}
  8005b3:	90                   	nop
  8005b4:	c9                   	leave  
  8005b5:	c3                   	ret    

008005b6 <getchar>:


int
getchar(void)
{
  8005b6:	55                   	push   %ebp
  8005b7:	89 e5                	mov    %esp,%ebp
  8005b9:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8005bc:	e8 a9 15 00 00       	call   801b6a <sys_cgetc>
  8005c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8005c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c8:	74 f2                	je     8005bc <getchar+0x6>
	return c;
  8005ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005cd:	c9                   	leave  
  8005ce:	c3                   	ret    

008005cf <iscons>:

int iscons(int fdnum)
{
  8005cf:	55                   	push   %ebp
  8005d0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005d2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005d7:	5d                   	pop    %ebp
  8005d8:	c3                   	ret    

008005d9 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8005d9:	55                   	push   %ebp
  8005da:	89 e5                	mov    %esp,%ebp
  8005dc:	57                   	push   %edi
  8005dd:	56                   	push   %esi
  8005de:	53                   	push   %ebx
  8005df:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8005e5:	e8 11 18 00 00       	call   801dfb <sys_getenvindex>
  8005ea:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8005ed:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005f0:	89 d0                	mov    %edx,%eax
  8005f2:	c1 e0 03             	shl    $0x3,%eax
  8005f5:	01 d0                	add    %edx,%eax
  8005f7:	c1 e0 06             	shl    $0x6,%eax
  8005fa:	01 d0                	add    %edx,%eax
  8005fc:	c1 e0 03             	shl    $0x3,%eax
  8005ff:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800604:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800609:	a1 24 30 80 00       	mov    0x803024,%eax
  80060e:	8a 40 10             	mov    0x10(%eax),%al
  800611:	84 c0                	test   %al,%al
  800613:	74 0d                	je     800622 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800615:	a1 24 30 80 00       	mov    0x803024,%eax
  80061a:	83 c0 10             	add    $0x10,%eax
  80061d:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800622:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800626:	7e 0a                	jle    800632 <libmain+0x59>
		binaryname = argv[0];
  800628:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062b:	8b 00                	mov    (%eax),%eax
  80062d:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800632:	83 ec 08             	sub    $0x8,%esp
  800635:	ff 75 0c             	pushl  0xc(%ebp)
  800638:	ff 75 08             	pushl  0x8(%ebp)
  80063b:	e8 f8 f9 ff ff       	call   800038 <_main>
  800640:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800643:	a1 00 30 80 00       	mov    0x803000,%eax
  800648:	85 c0                	test   %eax,%eax
  80064a:	0f 84 b7 01 00 00    	je     800807 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800650:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800656:	bb 04 27 80 00       	mov    $0x802704,%ebx
  80065b:	ba 0e 00 00 00       	mov    $0xe,%edx
  800660:	89 c7                	mov    %eax,%edi
  800662:	89 de                	mov    %ebx,%esi
  800664:	89 d1                	mov    %edx,%ecx
  800666:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800668:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80066e:	b9 56 00 00 00       	mov    $0x56,%ecx
  800673:	b0 00                	mov    $0x0,%al
  800675:	89 d7                	mov    %edx,%edi
  800677:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800679:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800680:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800683:	83 ec 08             	sub    $0x8,%esp
  800686:	50                   	push   %eax
  800687:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80068d:	50                   	push   %eax
  80068e:	e8 68 19 00 00       	call   801ffb <sys_utilities>
  800693:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800696:	e8 e8 14 00 00       	call   801b83 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	68 e0 25 80 00       	push   $0x8025e0
  8006a3:	e8 5f 04 00 00       	call   800b07 <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006ae:	85 c0                	test   %eax,%eax
  8006b0:	74 58                	je     80070a <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006b2:	e8 62 19 00 00       	call   802019 <sys_get_optimal_num_faults>
  8006b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006ba:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006c0:	bb 68 27 80 00       	mov    $0x802768,%ebx
  8006c5:	ba 11 00 00 00       	mov    $0x11,%edx
  8006ca:	89 c7                	mov    %eax,%edi
  8006cc:	89 de                	mov    %ebx,%esi
  8006ce:	89 d1                	mov    %edx,%ecx
  8006d0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006d2:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8006d5:	b9 53 00 00 00       	mov    $0x53,%ecx
  8006da:	b0 00                	mov    $0x0,%al
  8006dc:	89 d7                	mov    %edx,%edi
  8006de:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8006e0:	83 ec 08             	sub    $0x8,%esp
  8006e3:	ff 75 dc             	pushl  -0x24(%ebp)
  8006e6:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006ec:	50                   	push   %eax
  8006ed:	e8 09 19 00 00       	call   801ffb <sys_utilities>
  8006f2:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8006f5:	83 ec 08             	sub    $0x8,%esp
  8006f8:	ff 75 dc             	pushl  -0x24(%ebp)
  8006fb:	68 08 26 80 00       	push   $0x802608
  800700:	e8 02 04 00 00       	call   800b07 <cprintf>
  800705:	83 c4 10             	add    $0x10,%esp
  800708:	eb 59                	jmp    800763 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80070a:	a1 24 30 80 00       	mov    0x803024,%eax
  80070f:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800715:	a1 24 30 80 00       	mov    0x803024,%eax
  80071a:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800720:	83 ec 04             	sub    $0x4,%esp
  800723:	52                   	push   %edx
  800724:	50                   	push   %eax
  800725:	68 2c 26 80 00       	push   $0x80262c
  80072a:	e8 d8 03 00 00       	call   800b07 <cprintf>
  80072f:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800732:	a1 24 30 80 00       	mov    0x803024,%eax
  800737:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80073d:	a1 24 30 80 00       	mov    0x803024,%eax
  800742:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800748:	a1 24 30 80 00       	mov    0x803024,%eax
  80074d:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800753:	51                   	push   %ecx
  800754:	52                   	push   %edx
  800755:	50                   	push   %eax
  800756:	68 54 26 80 00       	push   $0x802654
  80075b:	e8 a7 03 00 00       	call   800b07 <cprintf>
  800760:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800763:	a1 24 30 80 00       	mov    0x803024,%eax
  800768:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80076e:	83 ec 08             	sub    $0x8,%esp
  800771:	50                   	push   %eax
  800772:	68 ac 26 80 00       	push   $0x8026ac
  800777:	e8 8b 03 00 00       	call   800b07 <cprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80077f:	83 ec 0c             	sub    $0xc,%esp
  800782:	68 c0 26 80 00       	push   $0x8026c0
  800787:	e8 7b 03 00 00       	call   800b07 <cprintf>
  80078c:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80078f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800796:	eb 28                	jmp    8007c0 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800798:	a1 24 30 80 00       	mov    0x803024,%eax
  80079d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007a0:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007a6:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007a9:	83 ec 04             	sub    $0x4,%esp
  8007ac:	50                   	push   %eax
  8007ad:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007b0:	68 d7 26 80 00       	push   $0x8026d7
  8007b5:	e8 4d 03 00 00       	call   800b07 <cprintf>
  8007ba:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007bd:	ff 45 e4             	incl   -0x1c(%ebp)
  8007c0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007c4:	7e d2                	jle    800798 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007c6:	83 ec 0c             	sub    $0xc,%esp
  8007c9:	68 e6 26 80 00       	push   $0x8026e6
  8007ce:	e8 34 03 00 00       	call   800b07 <cprintf>
  8007d3:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8007d6:	a1 24 30 80 00       	mov    0x803024,%eax
  8007db:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8007e1:	83 ec 08             	sub    $0x8,%esp
  8007e4:	50                   	push   %eax
  8007e5:	68 ea 26 80 00       	push   $0x8026ea
  8007ea:	e8 18 03 00 00       	call   800b07 <cprintf>
  8007ef:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8007f2:	83 ec 0c             	sub    $0xc,%esp
  8007f5:	68 e0 25 80 00       	push   $0x8025e0
  8007fa:	e8 08 03 00 00       	call   800b07 <cprintf>
  8007ff:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800802:	e8 96 13 00 00       	call   801b9d <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800807:	e8 1f 00 00 00       	call   80082b <exit>
}
  80080c:	90                   	nop
  80080d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800810:	5b                   	pop    %ebx
  800811:	5e                   	pop    %esi
  800812:	5f                   	pop    %edi
  800813:	5d                   	pop    %ebp
  800814:	c3                   	ret    

00800815 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800815:	55                   	push   %ebp
  800816:	89 e5                	mov    %esp,%ebp
  800818:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80081b:	83 ec 0c             	sub    $0xc,%esp
  80081e:	6a 00                	push   $0x0
  800820:	e8 a2 15 00 00       	call   801dc7 <sys_destroy_env>
  800825:	83 c4 10             	add    $0x10,%esp
}
  800828:	90                   	nop
  800829:	c9                   	leave  
  80082a:	c3                   	ret    

0080082b <exit>:

void
exit(void)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
  80082e:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800831:	e8 f7 15 00 00       	call   801e2d <sys_exit_env>
}
  800836:	90                   	nop
  800837:	c9                   	leave  
  800838:	c3                   	ret    

00800839 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800839:	55                   	push   %ebp
  80083a:	89 e5                	mov    %esp,%ebp
  80083c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80083f:	8d 45 10             	lea    0x10(%ebp),%eax
  800842:	83 c0 04             	add    $0x4,%eax
  800845:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800848:	a1 28 31 80 00       	mov    0x803128,%eax
  80084d:	85 c0                	test   %eax,%eax
  80084f:	74 16                	je     800867 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800851:	a1 28 31 80 00       	mov    0x803128,%eax
  800856:	83 ec 08             	sub    $0x8,%esp
  800859:	50                   	push   %eax
  80085a:	68 cc 27 80 00       	push   $0x8027cc
  80085f:	e8 a3 02 00 00       	call   800b07 <cprintf>
  800864:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800867:	a1 04 30 80 00       	mov    0x803004,%eax
  80086c:	83 ec 0c             	sub    $0xc,%esp
  80086f:	ff 75 0c             	pushl  0xc(%ebp)
  800872:	ff 75 08             	pushl  0x8(%ebp)
  800875:	50                   	push   %eax
  800876:	68 d4 27 80 00       	push   $0x8027d4
  80087b:	6a 74                	push   $0x74
  80087d:	e8 b2 02 00 00       	call   800b34 <cprintf_colored>
  800882:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800885:	8b 45 10             	mov    0x10(%ebp),%eax
  800888:	83 ec 08             	sub    $0x8,%esp
  80088b:	ff 75 f4             	pushl  -0xc(%ebp)
  80088e:	50                   	push   %eax
  80088f:	e8 04 02 00 00       	call   800a98 <vcprintf>
  800894:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800897:	83 ec 08             	sub    $0x8,%esp
  80089a:	6a 00                	push   $0x0
  80089c:	68 fc 27 80 00       	push   $0x8027fc
  8008a1:	e8 f2 01 00 00       	call   800a98 <vcprintf>
  8008a6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008a9:	e8 7d ff ff ff       	call   80082b <exit>

	// should not return here
	while (1) ;
  8008ae:	eb fe                	jmp    8008ae <_panic+0x75>

008008b0 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008b0:	55                   	push   %ebp
  8008b1:	89 e5                	mov    %esp,%ebp
  8008b3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008b6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008bb:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c4:	39 c2                	cmp    %eax,%edx
  8008c6:	74 14                	je     8008dc <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008c8:	83 ec 04             	sub    $0x4,%esp
  8008cb:	68 00 28 80 00       	push   $0x802800
  8008d0:	6a 26                	push   $0x26
  8008d2:	68 4c 28 80 00       	push   $0x80284c
  8008d7:	e8 5d ff ff ff       	call   800839 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008ea:	e9 c5 00 00 00       	jmp    8009b4 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8008ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	01 d0                	add    %edx,%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	85 c0                	test   %eax,%eax
  800902:	75 08                	jne    80090c <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800904:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800907:	e9 a5 00 00 00       	jmp    8009b1 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80090c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800913:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80091a:	eb 69                	jmp    800985 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80091c:	a1 24 30 80 00       	mov    0x803024,%eax
  800921:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800927:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80092a:	89 d0                	mov    %edx,%eax
  80092c:	01 c0                	add    %eax,%eax
  80092e:	01 d0                	add    %edx,%eax
  800930:	c1 e0 03             	shl    $0x3,%eax
  800933:	01 c8                	add    %ecx,%eax
  800935:	8a 40 04             	mov    0x4(%eax),%al
  800938:	84 c0                	test   %al,%al
  80093a:	75 46                	jne    800982 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80093c:	a1 24 30 80 00       	mov    0x803024,%eax
  800941:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800947:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80094a:	89 d0                	mov    %edx,%eax
  80094c:	01 c0                	add    %eax,%eax
  80094e:	01 d0                	add    %edx,%eax
  800950:	c1 e0 03             	shl    $0x3,%eax
  800953:	01 c8                	add    %ecx,%eax
  800955:	8b 00                	mov    (%eax),%eax
  800957:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80095a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80095d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800962:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800964:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800967:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	01 c8                	add    %ecx,%eax
  800973:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800975:	39 c2                	cmp    %eax,%edx
  800977:	75 09                	jne    800982 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800979:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800980:	eb 15                	jmp    800997 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800982:	ff 45 e8             	incl   -0x18(%ebp)
  800985:	a1 24 30 80 00       	mov    0x803024,%eax
  80098a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800990:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800993:	39 c2                	cmp    %eax,%edx
  800995:	77 85                	ja     80091c <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800997:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80099b:	75 14                	jne    8009b1 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80099d:	83 ec 04             	sub    $0x4,%esp
  8009a0:	68 58 28 80 00       	push   $0x802858
  8009a5:	6a 3a                	push   $0x3a
  8009a7:	68 4c 28 80 00       	push   $0x80284c
  8009ac:	e8 88 fe ff ff       	call   800839 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009b1:	ff 45 f0             	incl   -0x10(%ebp)
  8009b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009b7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009ba:	0f 8c 2f ff ff ff    	jl     8008ef <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009c7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009ce:	eb 26                	jmp    8009f6 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009d0:	a1 24 30 80 00       	mov    0x803024,%eax
  8009d5:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8009db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009de:	89 d0                	mov    %edx,%eax
  8009e0:	01 c0                	add    %eax,%eax
  8009e2:	01 d0                	add    %edx,%eax
  8009e4:	c1 e0 03             	shl    $0x3,%eax
  8009e7:	01 c8                	add    %ecx,%eax
  8009e9:	8a 40 04             	mov    0x4(%eax),%al
  8009ec:	3c 01                	cmp    $0x1,%al
  8009ee:	75 03                	jne    8009f3 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8009f0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f3:	ff 45 e0             	incl   -0x20(%ebp)
  8009f6:	a1 24 30 80 00       	mov    0x803024,%eax
  8009fb:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a01:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a04:	39 c2                	cmp    %eax,%edx
  800a06:	77 c8                	ja     8009d0 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a0b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a0e:	74 14                	je     800a24 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a10:	83 ec 04             	sub    $0x4,%esp
  800a13:	68 ac 28 80 00       	push   $0x8028ac
  800a18:	6a 44                	push   $0x44
  800a1a:	68 4c 28 80 00       	push   $0x80284c
  800a1f:	e8 15 fe ff ff       	call   800839 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a24:	90                   	nop
  800a25:	c9                   	leave  
  800a26:	c3                   	ret    

00800a27 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
  800a2a:	53                   	push   %ebx
  800a2b:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a31:	8b 00                	mov    (%eax),%eax
  800a33:	8d 48 01             	lea    0x1(%eax),%ecx
  800a36:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a39:	89 0a                	mov    %ecx,(%edx)
  800a3b:	8b 55 08             	mov    0x8(%ebp),%edx
  800a3e:	88 d1                	mov    %dl,%cl
  800a40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a43:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4a:	8b 00                	mov    (%eax),%eax
  800a4c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a51:	75 30                	jne    800a83 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a53:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800a59:	a0 40 30 80 00       	mov    0x803040,%al
  800a5e:	0f b6 c0             	movzbl %al,%eax
  800a61:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a64:	8b 09                	mov    (%ecx),%ecx
  800a66:	89 cb                	mov    %ecx,%ebx
  800a68:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a6b:	83 c1 08             	add    $0x8,%ecx
  800a6e:	52                   	push   %edx
  800a6f:	50                   	push   %eax
  800a70:	53                   	push   %ebx
  800a71:	51                   	push   %ecx
  800a72:	e8 c8 10 00 00       	call   801b3f <sys_cputs>
  800a77:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a86:	8b 40 04             	mov    0x4(%eax),%eax
  800a89:	8d 50 01             	lea    0x1(%eax),%edx
  800a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a92:	90                   	nop
  800a93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a96:	c9                   	leave  
  800a97:	c3                   	ret    

00800a98 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a98:	55                   	push   %ebp
  800a99:	89 e5                	mov    %esp,%ebp
  800a9b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800aa1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800aa8:	00 00 00 
	b.cnt = 0;
  800aab:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ab2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ab5:	ff 75 0c             	pushl  0xc(%ebp)
  800ab8:	ff 75 08             	pushl  0x8(%ebp)
  800abb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ac1:	50                   	push   %eax
  800ac2:	68 27 0a 80 00       	push   $0x800a27
  800ac7:	e8 5a 02 00 00       	call   800d26 <vprintfmt>
  800acc:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800acf:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800ad5:	a0 40 30 80 00       	mov    0x803040,%al
  800ada:	0f b6 c0             	movzbl %al,%eax
  800add:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800ae3:	52                   	push   %edx
  800ae4:	50                   	push   %eax
  800ae5:	51                   	push   %ecx
  800ae6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800aec:	83 c0 08             	add    $0x8,%eax
  800aef:	50                   	push   %eax
  800af0:	e8 4a 10 00 00       	call   801b3f <sys_cputs>
  800af5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800af8:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800aff:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b05:	c9                   	leave  
  800b06:	c3                   	ret    

00800b07 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b07:	55                   	push   %ebp
  800b08:	89 e5                	mov    %esp,%ebp
  800b0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b0d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800b14:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	83 ec 08             	sub    $0x8,%esp
  800b20:	ff 75 f4             	pushl  -0xc(%ebp)
  800b23:	50                   	push   %eax
  800b24:	e8 6f ff ff ff       	call   800a98 <vcprintf>
  800b29:	83 c4 10             	add    $0x10,%esp
  800b2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b32:	c9                   	leave  
  800b33:	c3                   	ret    

00800b34 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b34:	55                   	push   %ebp
  800b35:	89 e5                	mov    %esp,%ebp
  800b37:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b3a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	c1 e0 08             	shl    $0x8,%eax
  800b47:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800b4c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b4f:	83 c0 04             	add    $0x4,%eax
  800b52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5e:	50                   	push   %eax
  800b5f:	e8 34 ff ff ff       	call   800a98 <vcprintf>
  800b64:	83 c4 10             	add    $0x10,%esp
  800b67:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800b6a:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800b71:	07 00 00 

	return cnt;
  800b74:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800b7f:	e8 ff 0f 00 00       	call   801b83 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800b84:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b87:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	83 ec 08             	sub    $0x8,%esp
  800b90:	ff 75 f4             	pushl  -0xc(%ebp)
  800b93:	50                   	push   %eax
  800b94:	e8 ff fe ff ff       	call   800a98 <vcprintf>
  800b99:	83 c4 10             	add    $0x10,%esp
  800b9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800b9f:	e8 f9 0f 00 00       	call   801b9d <sys_unlock_cons>
	return cnt;
  800ba4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	53                   	push   %ebx
  800bad:	83 ec 14             	sub    $0x14,%esp
  800bb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800bb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bbc:	8b 45 18             	mov    0x18(%ebp),%eax
  800bbf:	ba 00 00 00 00       	mov    $0x0,%edx
  800bc4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bc7:	77 55                	ja     800c1e <printnum+0x75>
  800bc9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bcc:	72 05                	jb     800bd3 <printnum+0x2a>
  800bce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bd1:	77 4b                	ja     800c1e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bd3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bd6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bd9:	8b 45 18             	mov    0x18(%ebp),%eax
  800bdc:	ba 00 00 00 00       	mov    $0x0,%edx
  800be1:	52                   	push   %edx
  800be2:	50                   	push   %eax
  800be3:	ff 75 f4             	pushl  -0xc(%ebp)
  800be6:	ff 75 f0             	pushl  -0x10(%ebp)
  800be9:	e8 8e 15 00 00       	call   80217c <__udivdi3>
  800bee:	83 c4 10             	add    $0x10,%esp
  800bf1:	83 ec 04             	sub    $0x4,%esp
  800bf4:	ff 75 20             	pushl  0x20(%ebp)
  800bf7:	53                   	push   %ebx
  800bf8:	ff 75 18             	pushl  0x18(%ebp)
  800bfb:	52                   	push   %edx
  800bfc:	50                   	push   %eax
  800bfd:	ff 75 0c             	pushl  0xc(%ebp)
  800c00:	ff 75 08             	pushl  0x8(%ebp)
  800c03:	e8 a1 ff ff ff       	call   800ba9 <printnum>
  800c08:	83 c4 20             	add    $0x20,%esp
  800c0b:	eb 1a                	jmp    800c27 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c0d:	83 ec 08             	sub    $0x8,%esp
  800c10:	ff 75 0c             	pushl  0xc(%ebp)
  800c13:	ff 75 20             	pushl  0x20(%ebp)
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	ff d0                	call   *%eax
  800c1b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c1e:	ff 4d 1c             	decl   0x1c(%ebp)
  800c21:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c25:	7f e6                	jg     800c0d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c27:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c2a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c35:	53                   	push   %ebx
  800c36:	51                   	push   %ecx
  800c37:	52                   	push   %edx
  800c38:	50                   	push   %eax
  800c39:	e8 4e 16 00 00       	call   80228c <__umoddi3>
  800c3e:	83 c4 10             	add    $0x10,%esp
  800c41:	05 14 2b 80 00       	add    $0x802b14,%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	0f be c0             	movsbl %al,%eax
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 0c             	pushl  0xc(%ebp)
  800c51:	50                   	push   %eax
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
}
  800c5a:	90                   	nop
  800c5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c5e:	c9                   	leave  
  800c5f:	c3                   	ret    

00800c60 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c63:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c67:	7e 1c                	jle    800c85 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	8b 00                	mov    (%eax),%eax
  800c6e:	8d 50 08             	lea    0x8(%eax),%edx
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	89 10                	mov    %edx,(%eax)
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8b 00                	mov    (%eax),%eax
  800c7b:	83 e8 08             	sub    $0x8,%eax
  800c7e:	8b 50 04             	mov    0x4(%eax),%edx
  800c81:	8b 00                	mov    (%eax),%eax
  800c83:	eb 40                	jmp    800cc5 <getuint+0x65>
	else if (lflag)
  800c85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c89:	74 1e                	je     800ca9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	8b 00                	mov    (%eax),%eax
  800c90:	8d 50 04             	lea    0x4(%eax),%edx
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	89 10                	mov    %edx,(%eax)
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	8b 00                	mov    (%eax),%eax
  800c9d:	83 e8 04             	sub    $0x4,%eax
  800ca0:	8b 00                	mov    (%eax),%eax
  800ca2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ca7:	eb 1c                	jmp    800cc5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8b 00                	mov    (%eax),%eax
  800cae:	8d 50 04             	lea    0x4(%eax),%edx
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	89 10                	mov    %edx,(%eax)
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8b 00                	mov    (%eax),%eax
  800cbb:	83 e8 04             	sub    $0x4,%eax
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cc5:	5d                   	pop    %ebp
  800cc6:	c3                   	ret    

00800cc7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cc7:	55                   	push   %ebp
  800cc8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cce:	7e 1c                	jle    800cec <getint+0x25>
		return va_arg(*ap, long long);
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	8b 00                	mov    (%eax),%eax
  800cd5:	8d 50 08             	lea    0x8(%eax),%edx
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	89 10                	mov    %edx,(%eax)
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8b 00                	mov    (%eax),%eax
  800ce2:	83 e8 08             	sub    $0x8,%eax
  800ce5:	8b 50 04             	mov    0x4(%eax),%edx
  800ce8:	8b 00                	mov    (%eax),%eax
  800cea:	eb 38                	jmp    800d24 <getint+0x5d>
	else if (lflag)
  800cec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cf0:	74 1a                	je     800d0c <getint+0x45>
		return va_arg(*ap, long);
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	8d 50 04             	lea    0x4(%eax),%edx
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	89 10                	mov    %edx,(%eax)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	83 e8 04             	sub    $0x4,%eax
  800d07:	8b 00                	mov    (%eax),%eax
  800d09:	99                   	cltd   
  800d0a:	eb 18                	jmp    800d24 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8b 00                	mov    (%eax),%eax
  800d11:	8d 50 04             	lea    0x4(%eax),%edx
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	89 10                	mov    %edx,(%eax)
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8b 00                	mov    (%eax),%eax
  800d1e:	83 e8 04             	sub    $0x4,%eax
  800d21:	8b 00                	mov    (%eax),%eax
  800d23:	99                   	cltd   
}
  800d24:	5d                   	pop    %ebp
  800d25:	c3                   	ret    

00800d26 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d26:	55                   	push   %ebp
  800d27:	89 e5                	mov    %esp,%ebp
  800d29:	56                   	push   %esi
  800d2a:	53                   	push   %ebx
  800d2b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d2e:	eb 17                	jmp    800d47 <vprintfmt+0x21>
			if (ch == '\0')
  800d30:	85 db                	test   %ebx,%ebx
  800d32:	0f 84 c1 03 00 00    	je     8010f9 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d38:	83 ec 08             	sub    $0x8,%esp
  800d3b:	ff 75 0c             	pushl  0xc(%ebp)
  800d3e:	53                   	push   %ebx
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	ff d0                	call   *%eax
  800d44:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d47:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4a:	8d 50 01             	lea    0x1(%eax),%edx
  800d4d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d50:	8a 00                	mov    (%eax),%al
  800d52:	0f b6 d8             	movzbl %al,%ebx
  800d55:	83 fb 25             	cmp    $0x25,%ebx
  800d58:	75 d6                	jne    800d30 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d5a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d5e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d65:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d6c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d73:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7d:	8d 50 01             	lea    0x1(%eax),%edx
  800d80:	89 55 10             	mov    %edx,0x10(%ebp)
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	0f b6 d8             	movzbl %al,%ebx
  800d88:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d8b:	83 f8 5b             	cmp    $0x5b,%eax
  800d8e:	0f 87 3d 03 00 00    	ja     8010d1 <vprintfmt+0x3ab>
  800d94:	8b 04 85 38 2b 80 00 	mov    0x802b38(,%eax,4),%eax
  800d9b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d9d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800da1:	eb d7                	jmp    800d7a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800da3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800da7:	eb d1                	jmp    800d7a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800da9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800db0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800db3:	89 d0                	mov    %edx,%eax
  800db5:	c1 e0 02             	shl    $0x2,%eax
  800db8:	01 d0                	add    %edx,%eax
  800dba:	01 c0                	add    %eax,%eax
  800dbc:	01 d8                	add    %ebx,%eax
  800dbe:	83 e8 30             	sub    $0x30,%eax
  800dc1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dcc:	83 fb 2f             	cmp    $0x2f,%ebx
  800dcf:	7e 3e                	jle    800e0f <vprintfmt+0xe9>
  800dd1:	83 fb 39             	cmp    $0x39,%ebx
  800dd4:	7f 39                	jg     800e0f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dd6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800dd9:	eb d5                	jmp    800db0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ddb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dde:	83 c0 04             	add    $0x4,%eax
  800de1:	89 45 14             	mov    %eax,0x14(%ebp)
  800de4:	8b 45 14             	mov    0x14(%ebp),%eax
  800de7:	83 e8 04             	sub    $0x4,%eax
  800dea:	8b 00                	mov    (%eax),%eax
  800dec:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800def:	eb 1f                	jmp    800e10 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800df1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df5:	79 83                	jns    800d7a <vprintfmt+0x54>
				width = 0;
  800df7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800dfe:	e9 77 ff ff ff       	jmp    800d7a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e03:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e0a:	e9 6b ff ff ff       	jmp    800d7a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e0f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e14:	0f 89 60 ff ff ff    	jns    800d7a <vprintfmt+0x54>
				width = precision, precision = -1;
  800e1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e20:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e27:	e9 4e ff ff ff       	jmp    800d7a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e2c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e2f:	e9 46 ff ff ff       	jmp    800d7a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e34:	8b 45 14             	mov    0x14(%ebp),%eax
  800e37:	83 c0 04             	add    $0x4,%eax
  800e3a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e40:	83 e8 04             	sub    $0x4,%eax
  800e43:	8b 00                	mov    (%eax),%eax
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	50                   	push   %eax
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	ff d0                	call   *%eax
  800e51:	83 c4 10             	add    $0x10,%esp
			break;
  800e54:	e9 9b 02 00 00       	jmp    8010f4 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e59:	8b 45 14             	mov    0x14(%ebp),%eax
  800e5c:	83 c0 04             	add    $0x4,%eax
  800e5f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e62:	8b 45 14             	mov    0x14(%ebp),%eax
  800e65:	83 e8 04             	sub    $0x4,%eax
  800e68:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e6a:	85 db                	test   %ebx,%ebx
  800e6c:	79 02                	jns    800e70 <vprintfmt+0x14a>
				err = -err;
  800e6e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e70:	83 fb 64             	cmp    $0x64,%ebx
  800e73:	7f 0b                	jg     800e80 <vprintfmt+0x15a>
  800e75:	8b 34 9d 80 29 80 00 	mov    0x802980(,%ebx,4),%esi
  800e7c:	85 f6                	test   %esi,%esi
  800e7e:	75 19                	jne    800e99 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e80:	53                   	push   %ebx
  800e81:	68 25 2b 80 00       	push   $0x802b25
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	ff 75 08             	pushl  0x8(%ebp)
  800e8c:	e8 70 02 00 00       	call   801101 <printfmt>
  800e91:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e94:	e9 5b 02 00 00       	jmp    8010f4 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e99:	56                   	push   %esi
  800e9a:	68 2e 2b 80 00       	push   $0x802b2e
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	ff 75 08             	pushl  0x8(%ebp)
  800ea5:	e8 57 02 00 00       	call   801101 <printfmt>
  800eaa:	83 c4 10             	add    $0x10,%esp
			break;
  800ead:	e9 42 02 00 00       	jmp    8010f4 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800eb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb5:	83 c0 04             	add    $0x4,%eax
  800eb8:	89 45 14             	mov    %eax,0x14(%ebp)
  800ebb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebe:	83 e8 04             	sub    $0x4,%eax
  800ec1:	8b 30                	mov    (%eax),%esi
  800ec3:	85 f6                	test   %esi,%esi
  800ec5:	75 05                	jne    800ecc <vprintfmt+0x1a6>
				p = "(null)";
  800ec7:	be 31 2b 80 00       	mov    $0x802b31,%esi
			if (width > 0 && padc != '-')
  800ecc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ed0:	7e 6d                	jle    800f3f <vprintfmt+0x219>
  800ed2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ed6:	74 67                	je     800f3f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ed8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800edb:	83 ec 08             	sub    $0x8,%esp
  800ede:	50                   	push   %eax
  800edf:	56                   	push   %esi
  800ee0:	e8 1e 03 00 00       	call   801203 <strnlen>
  800ee5:	83 c4 10             	add    $0x10,%esp
  800ee8:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800eeb:	eb 16                	jmp    800f03 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800eed:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	50                   	push   %eax
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	ff d0                	call   *%eax
  800efd:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f00:	ff 4d e4             	decl   -0x1c(%ebp)
  800f03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f07:	7f e4                	jg     800eed <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f09:	eb 34                	jmp    800f3f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f0b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f0f:	74 1c                	je     800f2d <vprintfmt+0x207>
  800f11:	83 fb 1f             	cmp    $0x1f,%ebx
  800f14:	7e 05                	jle    800f1b <vprintfmt+0x1f5>
  800f16:	83 fb 7e             	cmp    $0x7e,%ebx
  800f19:	7e 12                	jle    800f2d <vprintfmt+0x207>
					putch('?', putdat);
  800f1b:	83 ec 08             	sub    $0x8,%esp
  800f1e:	ff 75 0c             	pushl  0xc(%ebp)
  800f21:	6a 3f                	push   $0x3f
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	ff d0                	call   *%eax
  800f28:	83 c4 10             	add    $0x10,%esp
  800f2b:	eb 0f                	jmp    800f3c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	53                   	push   %ebx
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f3f:	89 f0                	mov    %esi,%eax
  800f41:	8d 70 01             	lea    0x1(%eax),%esi
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	0f be d8             	movsbl %al,%ebx
  800f49:	85 db                	test   %ebx,%ebx
  800f4b:	74 24                	je     800f71 <vprintfmt+0x24b>
  800f4d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f51:	78 b8                	js     800f0b <vprintfmt+0x1e5>
  800f53:	ff 4d e0             	decl   -0x20(%ebp)
  800f56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f5a:	79 af                	jns    800f0b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f5c:	eb 13                	jmp    800f71 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f5e:	83 ec 08             	sub    $0x8,%esp
  800f61:	ff 75 0c             	pushl  0xc(%ebp)
  800f64:	6a 20                	push   $0x20
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	ff d0                	call   *%eax
  800f6b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f75:	7f e7                	jg     800f5e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f77:	e9 78 01 00 00       	jmp    8010f4 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f7c:	83 ec 08             	sub    $0x8,%esp
  800f7f:	ff 75 e8             	pushl  -0x18(%ebp)
  800f82:	8d 45 14             	lea    0x14(%ebp),%eax
  800f85:	50                   	push   %eax
  800f86:	e8 3c fd ff ff       	call   800cc7 <getint>
  800f8b:	83 c4 10             	add    $0x10,%esp
  800f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f91:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f97:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f9a:	85 d2                	test   %edx,%edx
  800f9c:	79 23                	jns    800fc1 <vprintfmt+0x29b>
				putch('-', putdat);
  800f9e:	83 ec 08             	sub    $0x8,%esp
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	6a 2d                	push   $0x2d
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	ff d0                	call   *%eax
  800fab:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fb4:	f7 d8                	neg    %eax
  800fb6:	83 d2 00             	adc    $0x0,%edx
  800fb9:	f7 da                	neg    %edx
  800fbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fbe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fc1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fc8:	e9 bc 00 00 00       	jmp    801089 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fcd:	83 ec 08             	sub    $0x8,%esp
  800fd0:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd3:	8d 45 14             	lea    0x14(%ebp),%eax
  800fd6:	50                   	push   %eax
  800fd7:	e8 84 fc ff ff       	call   800c60 <getuint>
  800fdc:	83 c4 10             	add    $0x10,%esp
  800fdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800fe5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fec:	e9 98 00 00 00       	jmp    801089 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ff1:	83 ec 08             	sub    $0x8,%esp
  800ff4:	ff 75 0c             	pushl  0xc(%ebp)
  800ff7:	6a 58                	push   $0x58
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	ff d0                	call   *%eax
  800ffe:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801001:	83 ec 08             	sub    $0x8,%esp
  801004:	ff 75 0c             	pushl  0xc(%ebp)
  801007:	6a 58                	push   $0x58
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	ff d0                	call   *%eax
  80100e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801011:	83 ec 08             	sub    $0x8,%esp
  801014:	ff 75 0c             	pushl  0xc(%ebp)
  801017:	6a 58                	push   $0x58
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	ff d0                	call   *%eax
  80101e:	83 c4 10             	add    $0x10,%esp
			break;
  801021:	e9 ce 00 00 00       	jmp    8010f4 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801026:	83 ec 08             	sub    $0x8,%esp
  801029:	ff 75 0c             	pushl  0xc(%ebp)
  80102c:	6a 30                	push   $0x30
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	ff d0                	call   *%eax
  801033:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801036:	83 ec 08             	sub    $0x8,%esp
  801039:	ff 75 0c             	pushl  0xc(%ebp)
  80103c:	6a 78                	push   $0x78
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	ff d0                	call   *%eax
  801043:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801046:	8b 45 14             	mov    0x14(%ebp),%eax
  801049:	83 c0 04             	add    $0x4,%eax
  80104c:	89 45 14             	mov    %eax,0x14(%ebp)
  80104f:	8b 45 14             	mov    0x14(%ebp),%eax
  801052:	83 e8 04             	sub    $0x4,%eax
  801055:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801057:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80105a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801061:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801068:	eb 1f                	jmp    801089 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80106a:	83 ec 08             	sub    $0x8,%esp
  80106d:	ff 75 e8             	pushl  -0x18(%ebp)
  801070:	8d 45 14             	lea    0x14(%ebp),%eax
  801073:	50                   	push   %eax
  801074:	e8 e7 fb ff ff       	call   800c60 <getuint>
  801079:	83 c4 10             	add    $0x10,%esp
  80107c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801082:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801089:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80108d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801090:	83 ec 04             	sub    $0x4,%esp
  801093:	52                   	push   %edx
  801094:	ff 75 e4             	pushl  -0x1c(%ebp)
  801097:	50                   	push   %eax
  801098:	ff 75 f4             	pushl  -0xc(%ebp)
  80109b:	ff 75 f0             	pushl  -0x10(%ebp)
  80109e:	ff 75 0c             	pushl  0xc(%ebp)
  8010a1:	ff 75 08             	pushl  0x8(%ebp)
  8010a4:	e8 00 fb ff ff       	call   800ba9 <printnum>
  8010a9:	83 c4 20             	add    $0x20,%esp
			break;
  8010ac:	eb 46                	jmp    8010f4 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010ae:	83 ec 08             	sub    $0x8,%esp
  8010b1:	ff 75 0c             	pushl  0xc(%ebp)
  8010b4:	53                   	push   %ebx
  8010b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b8:	ff d0                	call   *%eax
  8010ba:	83 c4 10             	add    $0x10,%esp
			break;
  8010bd:	eb 35                	jmp    8010f4 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010bf:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8010c6:	eb 2c                	jmp    8010f4 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8010c8:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8010cf:	eb 23                	jmp    8010f4 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010d1:	83 ec 08             	sub    $0x8,%esp
  8010d4:	ff 75 0c             	pushl  0xc(%ebp)
  8010d7:	6a 25                	push   $0x25
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	ff d0                	call   *%eax
  8010de:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010e1:	ff 4d 10             	decl   0x10(%ebp)
  8010e4:	eb 03                	jmp    8010e9 <vprintfmt+0x3c3>
  8010e6:	ff 4d 10             	decl   0x10(%ebp)
  8010e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ec:	48                   	dec    %eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	3c 25                	cmp    $0x25,%al
  8010f1:	75 f3                	jne    8010e6 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8010f3:	90                   	nop
		}
	}
  8010f4:	e9 35 fc ff ff       	jmp    800d2e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010f9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010fd:	5b                   	pop    %ebx
  8010fe:	5e                   	pop    %esi
  8010ff:	5d                   	pop    %ebp
  801100:	c3                   	ret    

00801101 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801101:	55                   	push   %ebp
  801102:	89 e5                	mov    %esp,%ebp
  801104:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801107:	8d 45 10             	lea    0x10(%ebp),%eax
  80110a:	83 c0 04             	add    $0x4,%eax
  80110d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801110:	8b 45 10             	mov    0x10(%ebp),%eax
  801113:	ff 75 f4             	pushl  -0xc(%ebp)
  801116:	50                   	push   %eax
  801117:	ff 75 0c             	pushl  0xc(%ebp)
  80111a:	ff 75 08             	pushl  0x8(%ebp)
  80111d:	e8 04 fc ff ff       	call   800d26 <vprintfmt>
  801122:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801125:	90                   	nop
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	8b 40 08             	mov    0x8(%eax),%eax
  801131:	8d 50 01             	lea    0x1(%eax),%edx
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80113a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113d:	8b 10                	mov    (%eax),%edx
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	8b 40 04             	mov    0x4(%eax),%eax
  801145:	39 c2                	cmp    %eax,%edx
  801147:	73 12                	jae    80115b <sprintputch+0x33>
		*b->buf++ = ch;
  801149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114c:	8b 00                	mov    (%eax),%eax
  80114e:	8d 48 01             	lea    0x1(%eax),%ecx
  801151:	8b 55 0c             	mov    0xc(%ebp),%edx
  801154:	89 0a                	mov    %ecx,(%edx)
  801156:	8b 55 08             	mov    0x8(%ebp),%edx
  801159:	88 10                	mov    %dl,(%eax)
}
  80115b:	90                   	nop
  80115c:	5d                   	pop    %ebp
  80115d:	c3                   	ret    

0080115e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80115e:	55                   	push   %ebp
  80115f:	89 e5                	mov    %esp,%ebp
  801161:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	01 d0                	add    %edx,%eax
  801175:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801178:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80117f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801183:	74 06                	je     80118b <vsnprintf+0x2d>
  801185:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801189:	7f 07                	jg     801192 <vsnprintf+0x34>
		return -E_INVAL;
  80118b:	b8 03 00 00 00       	mov    $0x3,%eax
  801190:	eb 20                	jmp    8011b2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801192:	ff 75 14             	pushl  0x14(%ebp)
  801195:	ff 75 10             	pushl  0x10(%ebp)
  801198:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80119b:	50                   	push   %eax
  80119c:	68 28 11 80 00       	push   $0x801128
  8011a1:	e8 80 fb ff ff       	call   800d26 <vprintfmt>
  8011a6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ac:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011ba:	8d 45 10             	lea    0x10(%ebp),%eax
  8011bd:	83 c0 04             	add    $0x4,%eax
  8011c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8011c9:	50                   	push   %eax
  8011ca:	ff 75 0c             	pushl  0xc(%ebp)
  8011cd:	ff 75 08             	pushl  0x8(%ebp)
  8011d0:	e8 89 ff ff ff       	call   80115e <vsnprintf>
  8011d5:	83 c4 10             	add    $0x10,%esp
  8011d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
  8011e3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8011e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011ed:	eb 06                	jmp    8011f5 <strlen+0x15>
		n++;
  8011ef:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8011f2:	ff 45 08             	incl   0x8(%ebp)
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	84 c0                	test   %al,%al
  8011fc:	75 f1                	jne    8011ef <strlen+0xf>
		n++;
	return n;
  8011fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
  801206:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801210:	eb 09                	jmp    80121b <strnlen+0x18>
		n++;
  801212:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801215:	ff 45 08             	incl   0x8(%ebp)
  801218:	ff 4d 0c             	decl   0xc(%ebp)
  80121b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80121f:	74 09                	je     80122a <strnlen+0x27>
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	8a 00                	mov    (%eax),%al
  801226:	84 c0                	test   %al,%al
  801228:	75 e8                	jne    801212 <strnlen+0xf>
		n++;
	return n;
  80122a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80122d:	c9                   	leave  
  80122e:	c3                   	ret    

0080122f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80122f:	55                   	push   %ebp
  801230:	89 e5                	mov    %esp,%ebp
  801232:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80123b:	90                   	nop
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8d 50 01             	lea    0x1(%eax),%edx
  801242:	89 55 08             	mov    %edx,0x8(%ebp)
  801245:	8b 55 0c             	mov    0xc(%ebp),%edx
  801248:	8d 4a 01             	lea    0x1(%edx),%ecx
  80124b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80124e:	8a 12                	mov    (%edx),%dl
  801250:	88 10                	mov    %dl,(%eax)
  801252:	8a 00                	mov    (%eax),%al
  801254:	84 c0                	test   %al,%al
  801256:	75 e4                	jne    80123c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801258:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801269:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801270:	eb 1f                	jmp    801291 <strncpy+0x34>
		*dst++ = *src;
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8d 50 01             	lea    0x1(%eax),%edx
  801278:	89 55 08             	mov    %edx,0x8(%ebp)
  80127b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127e:	8a 12                	mov    (%edx),%dl
  801280:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801282:	8b 45 0c             	mov    0xc(%ebp),%eax
  801285:	8a 00                	mov    (%eax),%al
  801287:	84 c0                	test   %al,%al
  801289:	74 03                	je     80128e <strncpy+0x31>
			src++;
  80128b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80128e:	ff 45 fc             	incl   -0x4(%ebp)
  801291:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801294:	3b 45 10             	cmp    0x10(%ebp),%eax
  801297:	72 d9                	jb     801272 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801299:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
  8012a1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ae:	74 30                	je     8012e0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012b0:	eb 16                	jmp    8012c8 <strlcpy+0x2a>
			*dst++ = *src++;
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8d 50 01             	lea    0x1(%eax),%edx
  8012b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012be:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012c1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012c4:	8a 12                	mov    (%edx),%dl
  8012c6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012c8:	ff 4d 10             	decl   0x10(%ebp)
  8012cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012cf:	74 09                	je     8012da <strlcpy+0x3c>
  8012d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d4:	8a 00                	mov    (%eax),%al
  8012d6:	84 c0                	test   %al,%al
  8012d8:	75 d8                	jne    8012b2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8012e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e6:	29 c2                	sub    %eax,%edx
  8012e8:	89 d0                	mov    %edx,%eax
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8012ef:	eb 06                	jmp    8012f7 <strcmp+0xb>
		p++, q++;
  8012f1:	ff 45 08             	incl   0x8(%ebp)
  8012f4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	84 c0                	test   %al,%al
  8012fe:	74 0e                	je     80130e <strcmp+0x22>
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	8a 10                	mov    (%eax),%dl
  801305:	8b 45 0c             	mov    0xc(%ebp),%eax
  801308:	8a 00                	mov    (%eax),%al
  80130a:	38 c2                	cmp    %al,%dl
  80130c:	74 e3                	je     8012f1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	0f b6 d0             	movzbl %al,%edx
  801316:	8b 45 0c             	mov    0xc(%ebp),%eax
  801319:	8a 00                	mov    (%eax),%al
  80131b:	0f b6 c0             	movzbl %al,%eax
  80131e:	29 c2                	sub    %eax,%edx
  801320:	89 d0                	mov    %edx,%eax
}
  801322:	5d                   	pop    %ebp
  801323:	c3                   	ret    

00801324 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801327:	eb 09                	jmp    801332 <strncmp+0xe>
		n--, p++, q++;
  801329:	ff 4d 10             	decl   0x10(%ebp)
  80132c:	ff 45 08             	incl   0x8(%ebp)
  80132f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801332:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801336:	74 17                	je     80134f <strncmp+0x2b>
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	84 c0                	test   %al,%al
  80133f:	74 0e                	je     80134f <strncmp+0x2b>
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 10                	mov    (%eax),%dl
  801346:	8b 45 0c             	mov    0xc(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	38 c2                	cmp    %al,%dl
  80134d:	74 da                	je     801329 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80134f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801353:	75 07                	jne    80135c <strncmp+0x38>
		return 0;
  801355:	b8 00 00 00 00       	mov    $0x0,%eax
  80135a:	eb 14                	jmp    801370 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	8a 00                	mov    (%eax),%al
  801361:	0f b6 d0             	movzbl %al,%edx
  801364:	8b 45 0c             	mov    0xc(%ebp),%eax
  801367:	8a 00                	mov    (%eax),%al
  801369:	0f b6 c0             	movzbl %al,%eax
  80136c:	29 c2                	sub    %eax,%edx
  80136e:	89 d0                	mov    %edx,%eax
}
  801370:	5d                   	pop    %ebp
  801371:	c3                   	ret    

00801372 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80137e:	eb 12                	jmp    801392 <strchr+0x20>
		if (*s == c)
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	8a 00                	mov    (%eax),%al
  801385:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801388:	75 05                	jne    80138f <strchr+0x1d>
			return (char *) s;
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	eb 11                	jmp    8013a0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80138f:	ff 45 08             	incl   0x8(%ebp)
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	84 c0                	test   %al,%al
  801399:	75 e5                	jne    801380 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80139b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
  8013a5:	83 ec 04             	sub    $0x4,%esp
  8013a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ae:	eb 0d                	jmp    8013bd <strfind+0x1b>
		if (*s == c)
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013b8:	74 0e                	je     8013c8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013ba:	ff 45 08             	incl   0x8(%ebp)
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	84 c0                	test   %al,%al
  8013c4:	75 ea                	jne    8013b0 <strfind+0xe>
  8013c6:	eb 01                	jmp    8013c9 <strfind+0x27>
		if (*s == c)
			break;
  8013c8:	90                   	nop
	return (char *) s;
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013cc:	c9                   	leave  
  8013cd:	c3                   	ret    

008013ce <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8013ce:	55                   	push   %ebp
  8013cf:	89 e5                	mov    %esp,%ebp
  8013d1:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8013da:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8013de:	76 63                	jbe    801443 <memset+0x75>
		uint64 data_block = c;
  8013e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e3:	99                   	cltd   
  8013e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8013ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f0:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8013f4:	c1 e0 08             	shl    $0x8,%eax
  8013f7:	09 45 f0             	or     %eax,-0x10(%ebp)
  8013fa:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8013fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801400:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801403:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801407:	c1 e0 10             	shl    $0x10,%eax
  80140a:	09 45 f0             	or     %eax,-0x10(%ebp)
  80140d:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801410:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801416:	89 c2                	mov    %eax,%edx
  801418:	b8 00 00 00 00       	mov    $0x0,%eax
  80141d:	09 45 f0             	or     %eax,-0x10(%ebp)
  801420:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801423:	eb 18                	jmp    80143d <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801425:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801428:	8d 41 08             	lea    0x8(%ecx),%eax
  80142b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80142e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801431:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801434:	89 01                	mov    %eax,(%ecx)
  801436:	89 51 04             	mov    %edx,0x4(%ecx)
  801439:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80143d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801441:	77 e2                	ja     801425 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801443:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801447:	74 23                	je     80146c <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801449:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  80144f:	eb 0e                	jmp    80145f <memset+0x91>
			*p8++ = (uint8)c;
  801451:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801454:	8d 50 01             	lea    0x1(%eax),%edx
  801457:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145d:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80145f:	8b 45 10             	mov    0x10(%ebp),%eax
  801462:	8d 50 ff             	lea    -0x1(%eax),%edx
  801465:	89 55 10             	mov    %edx,0x10(%ebp)
  801468:	85 c0                	test   %eax,%eax
  80146a:	75 e5                	jne    801451 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146f:	c9                   	leave  
  801470:	c3                   	ret    

00801471 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
  801474:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801483:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801487:	76 24                	jbe    8014ad <memcpy+0x3c>
		while(n >= 8){
  801489:	eb 1c                	jmp    8014a7 <memcpy+0x36>
			*d64 = *s64;
  80148b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80148e:	8b 50 04             	mov    0x4(%eax),%edx
  801491:	8b 00                	mov    (%eax),%eax
  801493:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801496:	89 01                	mov    %eax,(%ecx)
  801498:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80149b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80149f:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8014a3:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8014a7:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014ab:	77 de                	ja     80148b <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8014ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b1:	74 31                	je     8014e4 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8014b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8014b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8014bf:	eb 16                	jmp    8014d7 <memcpy+0x66>
			*d8++ = *s8++;
  8014c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014c4:	8d 50 01             	lea    0x1(%eax),%edx
  8014c7:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8014ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d0:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8014d3:	8a 12                	mov    (%edx),%dl
  8014d5:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e0:	85 c0                	test   %eax,%eax
  8014e2:	75 dd                	jne    8014c1 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8014e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801501:	73 50                	jae    801553 <memmove+0x6a>
  801503:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801506:	8b 45 10             	mov    0x10(%ebp),%eax
  801509:	01 d0                	add    %edx,%eax
  80150b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80150e:	76 43                	jbe    801553 <memmove+0x6a>
		s += n;
  801510:	8b 45 10             	mov    0x10(%ebp),%eax
  801513:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801516:	8b 45 10             	mov    0x10(%ebp),%eax
  801519:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80151c:	eb 10                	jmp    80152e <memmove+0x45>
			*--d = *--s;
  80151e:	ff 4d f8             	decl   -0x8(%ebp)
  801521:	ff 4d fc             	decl   -0x4(%ebp)
  801524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801527:	8a 10                	mov    (%eax),%dl
  801529:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80152e:	8b 45 10             	mov    0x10(%ebp),%eax
  801531:	8d 50 ff             	lea    -0x1(%eax),%edx
  801534:	89 55 10             	mov    %edx,0x10(%ebp)
  801537:	85 c0                	test   %eax,%eax
  801539:	75 e3                	jne    80151e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80153b:	eb 23                	jmp    801560 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80153d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801540:	8d 50 01             	lea    0x1(%eax),%edx
  801543:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801546:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801549:	8d 4a 01             	lea    0x1(%edx),%ecx
  80154c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80154f:	8a 12                	mov    (%edx),%dl
  801551:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801553:	8b 45 10             	mov    0x10(%ebp),%eax
  801556:	8d 50 ff             	lea    -0x1(%eax),%edx
  801559:	89 55 10             	mov    %edx,0x10(%ebp)
  80155c:	85 c0                	test   %eax,%eax
  80155e:	75 dd                	jne    80153d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801560:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
  801568:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801571:	8b 45 0c             	mov    0xc(%ebp),%eax
  801574:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801577:	eb 2a                	jmp    8015a3 <memcmp+0x3e>
		if (*s1 != *s2)
  801579:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157c:	8a 10                	mov    (%eax),%dl
  80157e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	38 c2                	cmp    %al,%dl
  801585:	74 16                	je     80159d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801587:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	0f b6 d0             	movzbl %al,%edx
  80158f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	0f b6 c0             	movzbl %al,%eax
  801597:	29 c2                	sub    %eax,%edx
  801599:	89 d0                	mov    %edx,%eax
  80159b:	eb 18                	jmp    8015b5 <memcmp+0x50>
		s1++, s2++;
  80159d:	ff 45 fc             	incl   -0x4(%ebp)
  8015a0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015a9:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ac:	85 c0                	test   %eax,%eax
  8015ae:	75 c9                	jne    801579 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015bd:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c3:	01 d0                	add    %edx,%eax
  8015c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015c8:	eb 15                	jmp    8015df <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	0f b6 d0             	movzbl %al,%edx
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	0f b6 c0             	movzbl %al,%eax
  8015d8:	39 c2                	cmp    %eax,%edx
  8015da:	74 0d                	je     8015e9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015dc:	ff 45 08             	incl   0x8(%ebp)
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015e5:	72 e3                	jb     8015ca <memfind+0x13>
  8015e7:	eb 01                	jmp    8015ea <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015e9:	90                   	nop
	return (void *) s;
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
  8015f2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015fc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801603:	eb 03                	jmp    801608 <strtol+0x19>
		s++;
  801605:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	8a 00                	mov    (%eax),%al
  80160d:	3c 20                	cmp    $0x20,%al
  80160f:	74 f4                	je     801605 <strtol+0x16>
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	3c 09                	cmp    $0x9,%al
  801618:	74 eb                	je     801605 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	8a 00                	mov    (%eax),%al
  80161f:	3c 2b                	cmp    $0x2b,%al
  801621:	75 05                	jne    801628 <strtol+0x39>
		s++;
  801623:	ff 45 08             	incl   0x8(%ebp)
  801626:	eb 13                	jmp    80163b <strtol+0x4c>
	else if (*s == '-')
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	3c 2d                	cmp    $0x2d,%al
  80162f:	75 0a                	jne    80163b <strtol+0x4c>
		s++, neg = 1;
  801631:	ff 45 08             	incl   0x8(%ebp)
  801634:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80163b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163f:	74 06                	je     801647 <strtol+0x58>
  801641:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801645:	75 20                	jne    801667 <strtol+0x78>
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	8a 00                	mov    (%eax),%al
  80164c:	3c 30                	cmp    $0x30,%al
  80164e:	75 17                	jne    801667 <strtol+0x78>
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	40                   	inc    %eax
  801654:	8a 00                	mov    (%eax),%al
  801656:	3c 78                	cmp    $0x78,%al
  801658:	75 0d                	jne    801667 <strtol+0x78>
		s += 2, base = 16;
  80165a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80165e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801665:	eb 28                	jmp    80168f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801667:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80166b:	75 15                	jne    801682 <strtol+0x93>
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 30                	cmp    $0x30,%al
  801674:	75 0c                	jne    801682 <strtol+0x93>
		s++, base = 8;
  801676:	ff 45 08             	incl   0x8(%ebp)
  801679:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801680:	eb 0d                	jmp    80168f <strtol+0xa0>
	else if (base == 0)
  801682:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801686:	75 07                	jne    80168f <strtol+0xa0>
		base = 10;
  801688:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	3c 2f                	cmp    $0x2f,%al
  801696:	7e 19                	jle    8016b1 <strtol+0xc2>
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	3c 39                	cmp    $0x39,%al
  80169f:	7f 10                	jg     8016b1 <strtol+0xc2>
			dig = *s - '0';
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	8a 00                	mov    (%eax),%al
  8016a6:	0f be c0             	movsbl %al,%eax
  8016a9:	83 e8 30             	sub    $0x30,%eax
  8016ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016af:	eb 42                	jmp    8016f3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	3c 60                	cmp    $0x60,%al
  8016b8:	7e 19                	jle    8016d3 <strtol+0xe4>
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	3c 7a                	cmp    $0x7a,%al
  8016c1:	7f 10                	jg     8016d3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 00                	mov    (%eax),%al
  8016c8:	0f be c0             	movsbl %al,%eax
  8016cb:	83 e8 57             	sub    $0x57,%eax
  8016ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016d1:	eb 20                	jmp    8016f3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8a 00                	mov    (%eax),%al
  8016d8:	3c 40                	cmp    $0x40,%al
  8016da:	7e 39                	jle    801715 <strtol+0x126>
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	8a 00                	mov    (%eax),%al
  8016e1:	3c 5a                	cmp    $0x5a,%al
  8016e3:	7f 30                	jg     801715 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e8:	8a 00                	mov    (%eax),%al
  8016ea:	0f be c0             	movsbl %al,%eax
  8016ed:	83 e8 37             	sub    $0x37,%eax
  8016f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016f9:	7d 19                	jge    801714 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016fb:	ff 45 08             	incl   0x8(%ebp)
  8016fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801701:	0f af 45 10          	imul   0x10(%ebp),%eax
  801705:	89 c2                	mov    %eax,%edx
  801707:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80170a:	01 d0                	add    %edx,%eax
  80170c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80170f:	e9 7b ff ff ff       	jmp    80168f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801714:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801715:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801719:	74 08                	je     801723 <strtol+0x134>
		*endptr = (char *) s;
  80171b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171e:	8b 55 08             	mov    0x8(%ebp),%edx
  801721:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801723:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801727:	74 07                	je     801730 <strtol+0x141>
  801729:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172c:	f7 d8                	neg    %eax
  80172e:	eb 03                	jmp    801733 <strtol+0x144>
  801730:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <ltostr>:

void
ltostr(long value, char *str)
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80173b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801742:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801749:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80174d:	79 13                	jns    801762 <ltostr+0x2d>
	{
		neg = 1;
  80174f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801756:	8b 45 0c             	mov    0xc(%ebp),%eax
  801759:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80175c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80175f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80176a:	99                   	cltd   
  80176b:	f7 f9                	idiv   %ecx
  80176d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801770:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801773:	8d 50 01             	lea    0x1(%eax),%edx
  801776:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801779:	89 c2                	mov    %eax,%edx
  80177b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177e:	01 d0                	add    %edx,%eax
  801780:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801783:	83 c2 30             	add    $0x30,%edx
  801786:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801788:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80178b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801790:	f7 e9                	imul   %ecx
  801792:	c1 fa 02             	sar    $0x2,%edx
  801795:	89 c8                	mov    %ecx,%eax
  801797:	c1 f8 1f             	sar    $0x1f,%eax
  80179a:	29 c2                	sub    %eax,%edx
  80179c:	89 d0                	mov    %edx,%eax
  80179e:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8017a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017a5:	75 bb                	jne    801762 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b1:	48                   	dec    %eax
  8017b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017b9:	74 3d                	je     8017f8 <ltostr+0xc3>
		start = 1 ;
  8017bb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017c2:	eb 34                	jmp    8017f8 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8017c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	01 d0                	add    %edx,%eax
  8017cc:	8a 00                	mov    (%eax),%al
  8017ce:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d7:	01 c2                	add    %eax,%edx
  8017d9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017df:	01 c8                	add    %ecx,%eax
  8017e1:	8a 00                	mov    (%eax),%al
  8017e3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017eb:	01 c2                	add    %eax,%edx
  8017ed:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017f0:	88 02                	mov    %al,(%edx)
		start++ ;
  8017f2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017f5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017fe:	7c c4                	jl     8017c4 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801800:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	01 d0                	add    %edx,%eax
  801808:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80180b:	90                   	nop
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801814:	ff 75 08             	pushl  0x8(%ebp)
  801817:	e8 c4 f9 ff ff       	call   8011e0 <strlen>
  80181c:	83 c4 04             	add    $0x4,%esp
  80181f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801822:	ff 75 0c             	pushl  0xc(%ebp)
  801825:	e8 b6 f9 ff ff       	call   8011e0 <strlen>
  80182a:	83 c4 04             	add    $0x4,%esp
  80182d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801830:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801837:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80183e:	eb 17                	jmp    801857 <strcconcat+0x49>
		final[s] = str1[s] ;
  801840:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801843:	8b 45 10             	mov    0x10(%ebp),%eax
  801846:	01 c2                	add    %eax,%edx
  801848:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	01 c8                	add    %ecx,%eax
  801850:	8a 00                	mov    (%eax),%al
  801852:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801854:	ff 45 fc             	incl   -0x4(%ebp)
  801857:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80185a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80185d:	7c e1                	jl     801840 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80185f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801866:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80186d:	eb 1f                	jmp    80188e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80186f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801872:	8d 50 01             	lea    0x1(%eax),%edx
  801875:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801878:	89 c2                	mov    %eax,%edx
  80187a:	8b 45 10             	mov    0x10(%ebp),%eax
  80187d:	01 c2                	add    %eax,%edx
  80187f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801882:	8b 45 0c             	mov    0xc(%ebp),%eax
  801885:	01 c8                	add    %ecx,%eax
  801887:	8a 00                	mov    (%eax),%al
  801889:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80188b:	ff 45 f8             	incl   -0x8(%ebp)
  80188e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801891:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801894:	7c d9                	jl     80186f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801896:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801899:	8b 45 10             	mov    0x10(%ebp),%eax
  80189c:	01 d0                	add    %edx,%eax
  80189e:	c6 00 00             	movb   $0x0,(%eax)
}
  8018a1:	90                   	nop
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b3:	8b 00                	mov    (%eax),%eax
  8018b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bf:	01 d0                	add    %edx,%eax
  8018c1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c7:	eb 0c                	jmp    8018d5 <strsplit+0x31>
			*string++ = 0;
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	8d 50 01             	lea    0x1(%eax),%edx
  8018cf:	89 55 08             	mov    %edx,0x8(%ebp)
  8018d2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	8a 00                	mov    (%eax),%al
  8018da:	84 c0                	test   %al,%al
  8018dc:	74 18                	je     8018f6 <strsplit+0x52>
  8018de:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e1:	8a 00                	mov    (%eax),%al
  8018e3:	0f be c0             	movsbl %al,%eax
  8018e6:	50                   	push   %eax
  8018e7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ea:	e8 83 fa ff ff       	call   801372 <strchr>
  8018ef:	83 c4 08             	add    $0x8,%esp
  8018f2:	85 c0                	test   %eax,%eax
  8018f4:	75 d3                	jne    8018c9 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	8a 00                	mov    (%eax),%al
  8018fb:	84 c0                	test   %al,%al
  8018fd:	74 5a                	je     801959 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801902:	8b 00                	mov    (%eax),%eax
  801904:	83 f8 0f             	cmp    $0xf,%eax
  801907:	75 07                	jne    801910 <strsplit+0x6c>
		{
			return 0;
  801909:	b8 00 00 00 00       	mov    $0x0,%eax
  80190e:	eb 66                	jmp    801976 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801910:	8b 45 14             	mov    0x14(%ebp),%eax
  801913:	8b 00                	mov    (%eax),%eax
  801915:	8d 48 01             	lea    0x1(%eax),%ecx
  801918:	8b 55 14             	mov    0x14(%ebp),%edx
  80191b:	89 0a                	mov    %ecx,(%edx)
  80191d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801924:	8b 45 10             	mov    0x10(%ebp),%eax
  801927:	01 c2                	add    %eax,%edx
  801929:	8b 45 08             	mov    0x8(%ebp),%eax
  80192c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80192e:	eb 03                	jmp    801933 <strsplit+0x8f>
			string++;
  801930:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8a 00                	mov    (%eax),%al
  801938:	84 c0                	test   %al,%al
  80193a:	74 8b                	je     8018c7 <strsplit+0x23>
  80193c:	8b 45 08             	mov    0x8(%ebp),%eax
  80193f:	8a 00                	mov    (%eax),%al
  801941:	0f be c0             	movsbl %al,%eax
  801944:	50                   	push   %eax
  801945:	ff 75 0c             	pushl  0xc(%ebp)
  801948:	e8 25 fa ff ff       	call   801372 <strchr>
  80194d:	83 c4 08             	add    $0x8,%esp
  801950:	85 c0                	test   %eax,%eax
  801952:	74 dc                	je     801930 <strsplit+0x8c>
			string++;
	}
  801954:	e9 6e ff ff ff       	jmp    8018c7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801959:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80195a:	8b 45 14             	mov    0x14(%ebp),%eax
  80195d:	8b 00                	mov    (%eax),%eax
  80195f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801966:	8b 45 10             	mov    0x10(%ebp),%eax
  801969:	01 d0                	add    %edx,%eax
  80196b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801971:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
  80197b:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801984:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80198b:	eb 4a                	jmp    8019d7 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80198d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801990:	8b 45 08             	mov    0x8(%ebp),%eax
  801993:	01 c2                	add    %eax,%edx
  801995:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801998:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199b:	01 c8                	add    %ecx,%eax
  80199d:	8a 00                	mov    (%eax),%al
  80199f:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8019a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a7:	01 d0                	add    %edx,%eax
  8019a9:	8a 00                	mov    (%eax),%al
  8019ab:	3c 40                	cmp    $0x40,%al
  8019ad:	7e 25                	jle    8019d4 <str2lower+0x5c>
  8019af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	8a 00                	mov    (%eax),%al
  8019b9:	3c 5a                	cmp    $0x5a,%al
  8019bb:	7f 17                	jg     8019d4 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8019bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	01 d0                	add    %edx,%eax
  8019c5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019c8:	8b 55 08             	mov    0x8(%ebp),%edx
  8019cb:	01 ca                	add    %ecx,%edx
  8019cd:	8a 12                	mov    (%edx),%dl
  8019cf:	83 c2 20             	add    $0x20,%edx
  8019d2:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8019d4:	ff 45 fc             	incl   -0x4(%ebp)
  8019d7:	ff 75 0c             	pushl  0xc(%ebp)
  8019da:	e8 01 f8 ff ff       	call   8011e0 <strlen>
  8019df:	83 c4 04             	add    $0x4,%esp
  8019e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019e5:	7f a6                	jg     80198d <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8019e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8019f2:	a1 08 30 80 00       	mov    0x803008,%eax
  8019f7:	85 c0                	test   %eax,%eax
  8019f9:	74 2d                	je     801a28 <uheap_init+0x3c>
	{
		buddy_init();
  8019fb:	e8 87 06 00 00       	call   802087 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801a00:	e8 31 05 00 00       	call   801f36 <sys_get_uheap_strategy>
  801a05:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  801a0a:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801a11:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801a14:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  801a1b:	00 00 80 
		__firstTimeFlag = 0;
  801a1e:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801a25:	00 00 00 
	}
}
  801a28:	90                   	nop
  801a29:	c9                   	leave  
  801a2a:	c3                   	ret    

00801a2b <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801a2b:	55                   	push   %ebp
  801a2c:	89 e5                	mov    %esp,%ebp
  801a2e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801a31:	83 ec 04             	sub    $0x4,%esp
  801a34:	68 a8 2c 80 00       	push   $0x802ca8
  801a39:	6a 25                	push   $0x25
  801a3b:	68 d9 2c 80 00       	push   $0x802cd9
  801a40:	e8 f4 ed ff ff       	call   800839 <_panic>

00801a45 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
  801a48:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801a4b:	83 ec 04             	sub    $0x4,%esp
  801a4e:	68 e8 2c 80 00       	push   $0x802ce8
  801a53:	6a 2f                	push   $0x2f
  801a55:	68 d9 2c 80 00       	push   $0x802cd9
  801a5a:	e8 da ed ff ff       	call   800839 <_panic>

00801a5f <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801a5f:	55                   	push   %ebp
  801a60:	89 e5                	mov    %esp,%ebp
  801a62:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801a65:	e8 82 ff ff ff       	call   8019ec <uheap_init>
	if (size == 0) return NULL ;
  801a6a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a6e:	75 07                	jne    801a77 <malloc+0x18>
  801a70:	b8 00 00 00 00       	mov    $0x0,%eax
  801a75:	eb 14                	jmp    801a8b <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801a77:	83 ec 04             	sub    $0x4,%esp
  801a7a:	68 1c 2d 80 00       	push   $0x802d1c
  801a7f:	6a 43                	push   $0x43
  801a81:	68 d9 2c 80 00       	push   $0x802cd9
  801a86:	e8 ae ed ff ff       	call   800839 <_panic>
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
  801a90:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801a93:	83 ec 04             	sub    $0x4,%esp
  801a96:	68 44 2d 80 00       	push   $0x802d44
  801a9b:	6a 4e                	push   $0x4e
  801a9d:	68 d9 2c 80 00       	push   $0x802cd9
  801aa2:	e8 92 ed ff ff       	call   800839 <_panic>

00801aa7 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
  801aaa:	83 ec 18             	sub    $0x18,%esp
  801aad:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab0:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ab3:	e8 34 ff ff ff       	call   8019ec <uheap_init>
	if (size == 0) return NULL ;
  801ab8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801abc:	75 07                	jne    801ac5 <smalloc+0x1e>
  801abe:	b8 00 00 00 00       	mov    $0x0,%eax
  801ac3:	eb 14                	jmp    801ad9 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801ac5:	83 ec 04             	sub    $0x4,%esp
  801ac8:	68 68 2d 80 00       	push   $0x802d68
  801acd:	6a 5f                	push   $0x5f
  801acf:	68 d9 2c 80 00       	push   $0x802cd9
  801ad4:	e8 60 ed ff ff       	call   800839 <_panic>
}
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
  801ade:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ae1:	e8 06 ff ff ff       	call   8019ec <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801ae6:	83 ec 04             	sub    $0x4,%esp
  801ae9:	68 90 2d 80 00       	push   $0x802d90
  801aee:	6a 6f                	push   $0x6f
  801af0:	68 d9 2c 80 00       	push   $0x802cd9
  801af5:	e8 3f ed ff ff       	call   800839 <_panic>

00801afa <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
  801afd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801b00:	83 ec 04             	sub    $0x4,%esp
  801b03:	68 b4 2d 80 00       	push   $0x802db4
  801b08:	6a 7e                	push   $0x7e
  801b0a:	68 d9 2c 80 00       	push   $0x802cd9
  801b0f:	e8 25 ed ff ff       	call   800839 <_panic>

00801b14 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
  801b17:	57                   	push   %edi
  801b18:	56                   	push   %esi
  801b19:	53                   	push   %ebx
  801b1a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b23:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b26:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b29:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b2c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b2f:	cd 30                	int    $0x30
  801b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b34:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b37:	83 c4 10             	add    $0x10,%esp
  801b3a:	5b                   	pop    %ebx
  801b3b:	5e                   	pop    %esi
  801b3c:	5f                   	pop    %edi
  801b3d:	5d                   	pop    %ebp
  801b3e:	c3                   	ret    

00801b3f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
  801b42:	83 ec 04             	sub    $0x4,%esp
  801b45:	8b 45 10             	mov    0x10(%ebp),%eax
  801b48:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801b4b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b4e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b52:	8b 45 08             	mov    0x8(%ebp),%eax
  801b55:	6a 00                	push   $0x0
  801b57:	51                   	push   %ecx
  801b58:	52                   	push   %edx
  801b59:	ff 75 0c             	pushl  0xc(%ebp)
  801b5c:	50                   	push   %eax
  801b5d:	6a 00                	push   $0x0
  801b5f:	e8 b0 ff ff ff       	call   801b14 <syscall>
  801b64:	83 c4 18             	add    $0x18,%esp
}
  801b67:	90                   	nop
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_cgetc>:

int
sys_cgetc(void)
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 02                	push   $0x2
  801b79:	e8 96 ff ff ff       	call   801b14 <syscall>
  801b7e:	83 c4 18             	add    $0x18,%esp
}
  801b81:	c9                   	leave  
  801b82:	c3                   	ret    

00801b83 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801b83:	55                   	push   %ebp
  801b84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 03                	push   $0x3
  801b92:	e8 7d ff ff ff       	call   801b14 <syscall>
  801b97:	83 c4 18             	add    $0x18,%esp
}
  801b9a:	90                   	nop
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 04                	push   $0x4
  801bac:	e8 63 ff ff ff       	call   801b14 <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
}
  801bb4:	90                   	nop
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	52                   	push   %edx
  801bc7:	50                   	push   %eax
  801bc8:	6a 08                	push   $0x8
  801bca:	e8 45 ff ff ff       	call   801b14 <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	56                   	push   %esi
  801bd8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bd9:	8b 75 18             	mov    0x18(%ebp),%esi
  801bdc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	56                   	push   %esi
  801be9:	53                   	push   %ebx
  801bea:	51                   	push   %ecx
  801beb:	52                   	push   %edx
  801bec:	50                   	push   %eax
  801bed:	6a 09                	push   $0x9
  801bef:	e8 20 ff ff ff       	call   801b14 <syscall>
  801bf4:	83 c4 18             	add    $0x18,%esp
}
  801bf7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bfa:	5b                   	pop    %ebx
  801bfb:	5e                   	pop    %esi
  801bfc:	5d                   	pop    %ebp
  801bfd:	c3                   	ret    

00801bfe <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	ff 75 08             	pushl  0x8(%ebp)
  801c0c:	6a 0a                	push   $0xa
  801c0e:	e8 01 ff ff ff       	call   801b14 <syscall>
  801c13:	83 c4 18             	add    $0x18,%esp
}
  801c16:	c9                   	leave  
  801c17:	c3                   	ret    

00801c18 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c18:	55                   	push   %ebp
  801c19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	ff 75 0c             	pushl  0xc(%ebp)
  801c24:	ff 75 08             	pushl  0x8(%ebp)
  801c27:	6a 0b                	push   $0xb
  801c29:	e8 e6 fe ff ff       	call   801b14 <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 0c                	push   $0xc
  801c42:	e8 cd fe ff ff       	call   801b14 <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
}
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 0d                	push   $0xd
  801c5b:	e8 b4 fe ff ff       	call   801b14 <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
}
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 0e                	push   $0xe
  801c74:	e8 9b fe ff ff       	call   801b14 <syscall>
  801c79:	83 c4 18             	add    $0x18,%esp
}
  801c7c:	c9                   	leave  
  801c7d:	c3                   	ret    

00801c7e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 0f                	push   $0xf
  801c8d:	e8 82 fe ff ff       	call   801b14 <syscall>
  801c92:	83 c4 18             	add    $0x18,%esp
}
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	ff 75 08             	pushl  0x8(%ebp)
  801ca5:	6a 10                	push   $0x10
  801ca7:	e8 68 fe ff ff       	call   801b14 <syscall>
  801cac:	83 c4 18             	add    $0x18,%esp
}
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 11                	push   $0x11
  801cc0:	e8 4f fe ff ff       	call   801b14 <syscall>
  801cc5:	83 c4 18             	add    $0x18,%esp
}
  801cc8:	90                   	nop
  801cc9:	c9                   	leave  
  801cca:	c3                   	ret    

00801ccb <sys_cputc>:

void
sys_cputc(const char c)
{
  801ccb:	55                   	push   %ebp
  801ccc:	89 e5                	mov    %esp,%ebp
  801cce:	83 ec 04             	sub    $0x4,%esp
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cd7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	50                   	push   %eax
  801ce4:	6a 01                	push   $0x1
  801ce6:	e8 29 fe ff ff       	call   801b14 <syscall>
  801ceb:	83 c4 18             	add    $0x18,%esp
}
  801cee:	90                   	nop
  801cef:	c9                   	leave  
  801cf0:	c3                   	ret    

00801cf1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 14                	push   $0x14
  801d00:	e8 0f fe ff ff       	call   801b14 <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
}
  801d08:	90                   	nop
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 04             	sub    $0x4,%esp
  801d11:	8b 45 10             	mov    0x10(%ebp),%eax
  801d14:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801d17:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d1a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d21:	6a 00                	push   $0x0
  801d23:	51                   	push   %ecx
  801d24:	52                   	push   %edx
  801d25:	ff 75 0c             	pushl  0xc(%ebp)
  801d28:	50                   	push   %eax
  801d29:	6a 15                	push   $0x15
  801d2b:	e8 e4 fd ff ff       	call   801b14 <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	c9                   	leave  
  801d34:	c3                   	ret    

00801d35 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801d38:	8b 55 10             	mov    0x10(%ebp),%edx
  801d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	52                   	push   %edx
  801d43:	50                   	push   %eax
  801d44:	ff 75 08             	pushl  0x8(%ebp)
  801d47:	6a 16                	push   $0x16
  801d49:	e8 c6 fd ff ff       	call   801b14 <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
}
  801d51:	c9                   	leave  
  801d52:	c3                   	ret    

00801d53 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801d53:	55                   	push   %ebp
  801d54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d59:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	52                   	push   %edx
  801d63:	50                   	push   %eax
  801d64:	6a 17                	push   $0x17
  801d66:	e8 a9 fd ff ff       	call   801b14 <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
}
  801d6e:	c9                   	leave  
  801d6f:	c3                   	ret    

00801d70 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	52                   	push   %edx
  801d80:	50                   	push   %eax
  801d81:	6a 18                	push   $0x18
  801d83:	e8 8c fd ff ff       	call   801b14 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801d90:	8b 45 08             	mov    0x8(%ebp),%eax
  801d93:	6a 00                	push   $0x0
  801d95:	ff 75 14             	pushl  0x14(%ebp)
  801d98:	ff 75 10             	pushl  0x10(%ebp)
  801d9b:	ff 75 0c             	pushl  0xc(%ebp)
  801d9e:	50                   	push   %eax
  801d9f:	6a 19                	push   $0x19
  801da1:	e8 6e fd ff ff       	call   801b14 <syscall>
  801da6:	83 c4 18             	add    $0x18,%esp
}
  801da9:	c9                   	leave  
  801daa:	c3                   	ret    

00801dab <sys_run_env>:

void sys_run_env(int32 envId)
{
  801dab:	55                   	push   %ebp
  801dac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dae:	8b 45 08             	mov    0x8(%ebp),%eax
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	50                   	push   %eax
  801dba:	6a 1a                	push   $0x1a
  801dbc:	e8 53 fd ff ff       	call   801b14 <syscall>
  801dc1:	83 c4 18             	add    $0x18,%esp
}
  801dc4:	90                   	nop
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801dca:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	50                   	push   %eax
  801dd6:	6a 1b                	push   $0x1b
  801dd8:	e8 37 fd ff ff       	call   801b14 <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 05                	push   $0x5
  801df1:	e8 1e fd ff ff       	call   801b14 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 06                	push   $0x6
  801e0a:	e8 05 fd ff ff       	call   801b14 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	c9                   	leave  
  801e13:	c3                   	ret    

00801e14 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e14:	55                   	push   %ebp
  801e15:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 07                	push   $0x7
  801e23:	e8 ec fc ff ff       	call   801b14 <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_exit_env>:


void sys_exit_env(void)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 1c                	push   $0x1c
  801e3c:	e8 d3 fc ff ff       	call   801b14 <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	90                   	nop
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	ff 75 10             	pushl  0x10(%ebp)
  801e51:	ff 75 0c             	pushl  0xc(%ebp)
  801e54:	ff 75 08             	pushl  0x8(%ebp)
  801e57:	6a 13                	push   $0x13
  801e59:	e8 b6 fc ff ff       	call   801b14 <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
	return ;
  801e61:	90                   	nop
}
  801e62:	c9                   	leave  
  801e63:	c3                   	ret    

00801e64 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e64:	55                   	push   %ebp
  801e65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 1e                	push   $0x1e
  801e73:	e8 9c fc ff ff       	call   801b14 <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
}
  801e7b:	c9                   	leave  
  801e7c:	c3                   	ret    

00801e7d <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801e7d:	55                   	push   %ebp
  801e7e:	89 e5                	mov    %esp,%ebp
  801e80:	83 ec 04             	sub    $0x4,%esp
  801e83:	8b 45 08             	mov    0x8(%ebp),%eax
  801e86:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e89:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	50                   	push   %eax
  801e96:	6a 1f                	push   $0x1f
  801e98:	e8 77 fc ff ff       	call   801b14 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea0:	90                   	nop
}
  801ea1:	c9                   	leave  
  801ea2:	c3                   	ret    

00801ea3 <rsttst>:
void rsttst()
{
  801ea3:	55                   	push   %ebp
  801ea4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 21                	push   $0x21
  801eb2:	e8 5d fc ff ff       	call   801b14 <syscall>
  801eb7:	83 c4 18             	add    $0x18,%esp
	return ;
  801eba:	90                   	nop
}
  801ebb:	c9                   	leave  
  801ebc:	c3                   	ret    

00801ebd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ebd:	55                   	push   %ebp
  801ebe:	89 e5                	mov    %esp,%ebp
  801ec0:	83 ec 04             	sub    $0x4,%esp
  801ec3:	8b 45 14             	mov    0x14(%ebp),%eax
  801ec6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ec9:	8b 55 18             	mov    0x18(%ebp),%edx
  801ecc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ed0:	52                   	push   %edx
  801ed1:	50                   	push   %eax
  801ed2:	ff 75 10             	pushl  0x10(%ebp)
  801ed5:	ff 75 0c             	pushl  0xc(%ebp)
  801ed8:	ff 75 08             	pushl  0x8(%ebp)
  801edb:	6a 20                	push   $0x20
  801edd:	e8 32 fc ff ff       	call   801b14 <syscall>
  801ee2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ee5:	90                   	nop
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <chktst>:
void chktst(uint32 n)
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	ff 75 08             	pushl  0x8(%ebp)
  801ef6:	6a 22                	push   $0x22
  801ef8:	e8 17 fc ff ff       	call   801b14 <syscall>
  801efd:	83 c4 18             	add    $0x18,%esp
	return ;
  801f00:	90                   	nop
}
  801f01:	c9                   	leave  
  801f02:	c3                   	ret    

00801f03 <inctst>:

void inctst()
{
  801f03:	55                   	push   %ebp
  801f04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 23                	push   $0x23
  801f12:	e8 fd fb ff ff       	call   801b14 <syscall>
  801f17:	83 c4 18             	add    $0x18,%esp
	return ;
  801f1a:	90                   	nop
}
  801f1b:	c9                   	leave  
  801f1c:	c3                   	ret    

00801f1d <gettst>:
uint32 gettst()
{
  801f1d:	55                   	push   %ebp
  801f1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 24                	push   $0x24
  801f2c:	e8 e3 fb ff ff       	call   801b14 <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 25                	push   $0x25
  801f45:	e8 ca fb ff ff       	call   801b14 <syscall>
  801f4a:	83 c4 18             	add    $0x18,%esp
  801f4d:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801f52:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5f:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	ff 75 08             	pushl  0x8(%ebp)
  801f6f:	6a 26                	push   $0x26
  801f71:	e8 9e fb ff ff       	call   801b14 <syscall>
  801f76:	83 c4 18             	add    $0x18,%esp
	return ;
  801f79:	90                   	nop
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
  801f7f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f80:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f83:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f86:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f89:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8c:	6a 00                	push   $0x0
  801f8e:	53                   	push   %ebx
  801f8f:	51                   	push   %ecx
  801f90:	52                   	push   %edx
  801f91:	50                   	push   %eax
  801f92:	6a 27                	push   $0x27
  801f94:	e8 7b fb ff ff       	call   801b14 <syscall>
  801f99:	83 c4 18             	add    $0x18,%esp
}
  801f9c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801fa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	52                   	push   %edx
  801fb1:	50                   	push   %eax
  801fb2:	6a 28                	push   $0x28
  801fb4:	e8 5b fb ff ff       	call   801b14 <syscall>
  801fb9:	83 c4 18             	add    $0x18,%esp
}
  801fbc:	c9                   	leave  
  801fbd:	c3                   	ret    

00801fbe <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801fbe:	55                   	push   %ebp
  801fbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801fc1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fca:	6a 00                	push   $0x0
  801fcc:	51                   	push   %ecx
  801fcd:	ff 75 10             	pushl  0x10(%ebp)
  801fd0:	52                   	push   %edx
  801fd1:	50                   	push   %eax
  801fd2:	6a 29                	push   $0x29
  801fd4:	e8 3b fb ff ff       	call   801b14 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	ff 75 10             	pushl  0x10(%ebp)
  801fe8:	ff 75 0c             	pushl  0xc(%ebp)
  801feb:	ff 75 08             	pushl  0x8(%ebp)
  801fee:	6a 12                	push   $0x12
  801ff0:	e8 1f fb ff ff       	call   801b14 <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff8:	90                   	nop
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801ffe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802001:	8b 45 08             	mov    0x8(%ebp),%eax
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	52                   	push   %edx
  80200b:	50                   	push   %eax
  80200c:	6a 2a                	push   $0x2a
  80200e:	e8 01 fb ff ff       	call   801b14 <syscall>
  802013:	83 c4 18             	add    $0x18,%esp
	return;
  802016:	90                   	nop
}
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 2b                	push   $0x2b
  802028:	e8 e7 fa ff ff       	call   801b14 <syscall>
  80202d:	83 c4 18             	add    $0x18,%esp
}
  802030:	c9                   	leave  
  802031:	c3                   	ret    

00802032 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802032:	55                   	push   %ebp
  802033:	89 e5                	mov    %esp,%ebp
  802035:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802038:	83 ec 04             	sub    $0x4,%esp
  80203b:	68 d8 2d 80 00       	push   $0x802dd8
  802040:	68 0a 01 00 00       	push   $0x10a
  802045:	68 e8 2d 80 00       	push   $0x802de8
  80204a:	e8 ea e7 ff ff       	call   800839 <_panic>

0080204f <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80204f:	55                   	push   %ebp
  802050:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	ff 75 0c             	pushl  0xc(%ebp)
  80205b:	ff 75 08             	pushl  0x8(%ebp)
  80205e:	6a 33                	push   $0x33
  802060:	e8 af fa ff ff       	call   801b14 <syscall>
  802065:	83 c4 18             	add    $0x18,%esp
	return;
  802068:	90                   	nop
}
  802069:	c9                   	leave  
  80206a:	c3                   	ret    

0080206b <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80206b:	55                   	push   %ebp
  80206c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	ff 75 0c             	pushl  0xc(%ebp)
  802077:	ff 75 08             	pushl  0x8(%ebp)
  80207a:	6a 34                	push   $0x34
  80207c:	e8 93 fa ff ff       	call   801b14 <syscall>
  802081:	83 c4 18             	add    $0x18,%esp
	return ;
  802084:	90                   	nop
}
  802085:	c9                   	leave  
  802086:	c3                   	ret    

00802087 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802087:	55                   	push   %ebp
  802088:	89 e5                	mov    %esp,%ebp
  80208a:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80208d:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  802094:	eb 36                	jmp    8020cc <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  802096:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802099:	c1 e0 04             	shl    $0x4,%eax
  80209c:	05 60 30 80 00       	add    $0x803060,%eax
  8020a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8020a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020aa:	c1 e0 04             	shl    $0x4,%eax
  8020ad:	05 64 30 80 00       	add    $0x803064,%eax
  8020b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8020b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020bb:	c1 e0 04             	shl    $0x4,%eax
  8020be:	05 6c 30 80 00       	add    $0x80306c,%eax
  8020c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8020c9:	ff 45 fc             	incl   -0x4(%ebp)
  8020cc:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  8020d0:	7e c4                	jle    802096 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  8020d2:	90                   	nop
  8020d3:	c9                   	leave  
  8020d4:	c3                   	ret    

008020d5 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  8020d5:	55                   	push   %ebp
  8020d6:	89 e5                	mov    %esp,%ebp
  8020d8:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  8020db:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  8020e2:	eb 24                	jmp    802108 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  8020e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8020e7:	c1 e0 04             	shl    $0x4,%eax
  8020ea:	05 6c 30 80 00       	add    $0x80306c,%eax
  8020ef:	8b 00                	mov    (%eax),%eax
  8020f1:	83 ec 04             	sub    $0x4,%esp
  8020f4:	50                   	push   %eax
  8020f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8020f8:	68 f8 2d 80 00       	push   $0x802df8
  8020fd:	e8 05 ea ff ff       	call   800b07 <cprintf>
  802102:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802105:	ff 45 f4             	incl   -0xc(%ebp)
  802108:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80210c:	7e d6                	jle    8020e4 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  80210e:	90                   	nop
  80210f:	c9                   	leave  
  802110:	c3                   	ret    

00802111 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802111:	55                   	push   %ebp
  802112:	89 e5                	mov    %esp,%ebp
  802114:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802117:	83 ec 04             	sub    $0x4,%esp
  80211a:	68 08 2e 80 00       	push   $0x802e08
  80211f:	6a 33                	push   $0x33
  802121:	68 29 2e 80 00       	push   $0x802e29
  802126:	e8 0e e7 ff ff       	call   800839 <_panic>

0080212b <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80212b:	55                   	push   %ebp
  80212c:	89 e5                	mov    %esp,%ebp
  80212e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802131:	83 ec 04             	sub    $0x4,%esp
  802134:	68 41 2e 80 00       	push   $0x802e41
  802139:	6a 3e                	push   $0x3e
  80213b:	68 29 2e 80 00       	push   $0x802e29
  802140:	e8 f4 e6 ff ff       	call   800839 <_panic>

00802145 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802145:	55                   	push   %ebp
  802146:	89 e5                	mov    %esp,%ebp
  802148:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  80214b:	83 ec 04             	sub    $0x4,%esp
  80214e:	68 5f 2e 80 00       	push   $0x802e5f
  802153:	6a 49                	push   $0x49
  802155:	68 29 2e 80 00       	push   $0x802e29
  80215a:	e8 da e6 ff ff       	call   800839 <_panic>

0080215f <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  80215f:	55                   	push   %ebp
  802160:	89 e5                	mov    %esp,%ebp
  802162:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802165:	83 ec 04             	sub    $0x4,%esp
  802168:	68 7c 2e 80 00       	push   $0x802e7c
  80216d:	6a 58                	push   $0x58
  80216f:	68 29 2e 80 00       	push   $0x802e29
  802174:	e8 c0 e6 ff ff       	call   800839 <_panic>
  802179:	66 90                	xchg   %ax,%ax
  80217b:	90                   	nop

0080217c <__udivdi3>:
  80217c:	55                   	push   %ebp
  80217d:	57                   	push   %edi
  80217e:	56                   	push   %esi
  80217f:	53                   	push   %ebx
  802180:	83 ec 1c             	sub    $0x1c,%esp
  802183:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802187:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80218b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80218f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802193:	89 ca                	mov    %ecx,%edx
  802195:	89 f8                	mov    %edi,%eax
  802197:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80219b:	85 f6                	test   %esi,%esi
  80219d:	75 2d                	jne    8021cc <__udivdi3+0x50>
  80219f:	39 cf                	cmp    %ecx,%edi
  8021a1:	77 65                	ja     802208 <__udivdi3+0x8c>
  8021a3:	89 fd                	mov    %edi,%ebp
  8021a5:	85 ff                	test   %edi,%edi
  8021a7:	75 0b                	jne    8021b4 <__udivdi3+0x38>
  8021a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ae:	31 d2                	xor    %edx,%edx
  8021b0:	f7 f7                	div    %edi
  8021b2:	89 c5                	mov    %eax,%ebp
  8021b4:	31 d2                	xor    %edx,%edx
  8021b6:	89 c8                	mov    %ecx,%eax
  8021b8:	f7 f5                	div    %ebp
  8021ba:	89 c1                	mov    %eax,%ecx
  8021bc:	89 d8                	mov    %ebx,%eax
  8021be:	f7 f5                	div    %ebp
  8021c0:	89 cf                	mov    %ecx,%edi
  8021c2:	89 fa                	mov    %edi,%edx
  8021c4:	83 c4 1c             	add    $0x1c,%esp
  8021c7:	5b                   	pop    %ebx
  8021c8:	5e                   	pop    %esi
  8021c9:	5f                   	pop    %edi
  8021ca:	5d                   	pop    %ebp
  8021cb:	c3                   	ret    
  8021cc:	39 ce                	cmp    %ecx,%esi
  8021ce:	77 28                	ja     8021f8 <__udivdi3+0x7c>
  8021d0:	0f bd fe             	bsr    %esi,%edi
  8021d3:	83 f7 1f             	xor    $0x1f,%edi
  8021d6:	75 40                	jne    802218 <__udivdi3+0x9c>
  8021d8:	39 ce                	cmp    %ecx,%esi
  8021da:	72 0a                	jb     8021e6 <__udivdi3+0x6a>
  8021dc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021e0:	0f 87 9e 00 00 00    	ja     802284 <__udivdi3+0x108>
  8021e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021eb:	89 fa                	mov    %edi,%edx
  8021ed:	83 c4 1c             	add    $0x1c,%esp
  8021f0:	5b                   	pop    %ebx
  8021f1:	5e                   	pop    %esi
  8021f2:	5f                   	pop    %edi
  8021f3:	5d                   	pop    %ebp
  8021f4:	c3                   	ret    
  8021f5:	8d 76 00             	lea    0x0(%esi),%esi
  8021f8:	31 ff                	xor    %edi,%edi
  8021fa:	31 c0                	xor    %eax,%eax
  8021fc:	89 fa                	mov    %edi,%edx
  8021fe:	83 c4 1c             	add    $0x1c,%esp
  802201:	5b                   	pop    %ebx
  802202:	5e                   	pop    %esi
  802203:	5f                   	pop    %edi
  802204:	5d                   	pop    %ebp
  802205:	c3                   	ret    
  802206:	66 90                	xchg   %ax,%ax
  802208:	89 d8                	mov    %ebx,%eax
  80220a:	f7 f7                	div    %edi
  80220c:	31 ff                	xor    %edi,%edi
  80220e:	89 fa                	mov    %edi,%edx
  802210:	83 c4 1c             	add    $0x1c,%esp
  802213:	5b                   	pop    %ebx
  802214:	5e                   	pop    %esi
  802215:	5f                   	pop    %edi
  802216:	5d                   	pop    %ebp
  802217:	c3                   	ret    
  802218:	bd 20 00 00 00       	mov    $0x20,%ebp
  80221d:	89 eb                	mov    %ebp,%ebx
  80221f:	29 fb                	sub    %edi,%ebx
  802221:	89 f9                	mov    %edi,%ecx
  802223:	d3 e6                	shl    %cl,%esi
  802225:	89 c5                	mov    %eax,%ebp
  802227:	88 d9                	mov    %bl,%cl
  802229:	d3 ed                	shr    %cl,%ebp
  80222b:	89 e9                	mov    %ebp,%ecx
  80222d:	09 f1                	or     %esi,%ecx
  80222f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802233:	89 f9                	mov    %edi,%ecx
  802235:	d3 e0                	shl    %cl,%eax
  802237:	89 c5                	mov    %eax,%ebp
  802239:	89 d6                	mov    %edx,%esi
  80223b:	88 d9                	mov    %bl,%cl
  80223d:	d3 ee                	shr    %cl,%esi
  80223f:	89 f9                	mov    %edi,%ecx
  802241:	d3 e2                	shl    %cl,%edx
  802243:	8b 44 24 08          	mov    0x8(%esp),%eax
  802247:	88 d9                	mov    %bl,%cl
  802249:	d3 e8                	shr    %cl,%eax
  80224b:	09 c2                	or     %eax,%edx
  80224d:	89 d0                	mov    %edx,%eax
  80224f:	89 f2                	mov    %esi,%edx
  802251:	f7 74 24 0c          	divl   0xc(%esp)
  802255:	89 d6                	mov    %edx,%esi
  802257:	89 c3                	mov    %eax,%ebx
  802259:	f7 e5                	mul    %ebp
  80225b:	39 d6                	cmp    %edx,%esi
  80225d:	72 19                	jb     802278 <__udivdi3+0xfc>
  80225f:	74 0b                	je     80226c <__udivdi3+0xf0>
  802261:	89 d8                	mov    %ebx,%eax
  802263:	31 ff                	xor    %edi,%edi
  802265:	e9 58 ff ff ff       	jmp    8021c2 <__udivdi3+0x46>
  80226a:	66 90                	xchg   %ax,%ax
  80226c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802270:	89 f9                	mov    %edi,%ecx
  802272:	d3 e2                	shl    %cl,%edx
  802274:	39 c2                	cmp    %eax,%edx
  802276:	73 e9                	jae    802261 <__udivdi3+0xe5>
  802278:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80227b:	31 ff                	xor    %edi,%edi
  80227d:	e9 40 ff ff ff       	jmp    8021c2 <__udivdi3+0x46>
  802282:	66 90                	xchg   %ax,%ax
  802284:	31 c0                	xor    %eax,%eax
  802286:	e9 37 ff ff ff       	jmp    8021c2 <__udivdi3+0x46>
  80228b:	90                   	nop

0080228c <__umoddi3>:
  80228c:	55                   	push   %ebp
  80228d:	57                   	push   %edi
  80228e:	56                   	push   %esi
  80228f:	53                   	push   %ebx
  802290:	83 ec 1c             	sub    $0x1c,%esp
  802293:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802297:	8b 74 24 34          	mov    0x34(%esp),%esi
  80229b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80229f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022a7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022ab:	89 f3                	mov    %esi,%ebx
  8022ad:	89 fa                	mov    %edi,%edx
  8022af:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022b3:	89 34 24             	mov    %esi,(%esp)
  8022b6:	85 c0                	test   %eax,%eax
  8022b8:	75 1a                	jne    8022d4 <__umoddi3+0x48>
  8022ba:	39 f7                	cmp    %esi,%edi
  8022bc:	0f 86 a2 00 00 00    	jbe    802364 <__umoddi3+0xd8>
  8022c2:	89 c8                	mov    %ecx,%eax
  8022c4:	89 f2                	mov    %esi,%edx
  8022c6:	f7 f7                	div    %edi
  8022c8:	89 d0                	mov    %edx,%eax
  8022ca:	31 d2                	xor    %edx,%edx
  8022cc:	83 c4 1c             	add    $0x1c,%esp
  8022cf:	5b                   	pop    %ebx
  8022d0:	5e                   	pop    %esi
  8022d1:	5f                   	pop    %edi
  8022d2:	5d                   	pop    %ebp
  8022d3:	c3                   	ret    
  8022d4:	39 f0                	cmp    %esi,%eax
  8022d6:	0f 87 ac 00 00 00    	ja     802388 <__umoddi3+0xfc>
  8022dc:	0f bd e8             	bsr    %eax,%ebp
  8022df:	83 f5 1f             	xor    $0x1f,%ebp
  8022e2:	0f 84 ac 00 00 00    	je     802394 <__umoddi3+0x108>
  8022e8:	bf 20 00 00 00       	mov    $0x20,%edi
  8022ed:	29 ef                	sub    %ebp,%edi
  8022ef:	89 fe                	mov    %edi,%esi
  8022f1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022f5:	89 e9                	mov    %ebp,%ecx
  8022f7:	d3 e0                	shl    %cl,%eax
  8022f9:	89 d7                	mov    %edx,%edi
  8022fb:	89 f1                	mov    %esi,%ecx
  8022fd:	d3 ef                	shr    %cl,%edi
  8022ff:	09 c7                	or     %eax,%edi
  802301:	89 e9                	mov    %ebp,%ecx
  802303:	d3 e2                	shl    %cl,%edx
  802305:	89 14 24             	mov    %edx,(%esp)
  802308:	89 d8                	mov    %ebx,%eax
  80230a:	d3 e0                	shl    %cl,%eax
  80230c:	89 c2                	mov    %eax,%edx
  80230e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802312:	d3 e0                	shl    %cl,%eax
  802314:	89 44 24 04          	mov    %eax,0x4(%esp)
  802318:	8b 44 24 08          	mov    0x8(%esp),%eax
  80231c:	89 f1                	mov    %esi,%ecx
  80231e:	d3 e8                	shr    %cl,%eax
  802320:	09 d0                	or     %edx,%eax
  802322:	d3 eb                	shr    %cl,%ebx
  802324:	89 da                	mov    %ebx,%edx
  802326:	f7 f7                	div    %edi
  802328:	89 d3                	mov    %edx,%ebx
  80232a:	f7 24 24             	mull   (%esp)
  80232d:	89 c6                	mov    %eax,%esi
  80232f:	89 d1                	mov    %edx,%ecx
  802331:	39 d3                	cmp    %edx,%ebx
  802333:	0f 82 87 00 00 00    	jb     8023c0 <__umoddi3+0x134>
  802339:	0f 84 91 00 00 00    	je     8023d0 <__umoddi3+0x144>
  80233f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802343:	29 f2                	sub    %esi,%edx
  802345:	19 cb                	sbb    %ecx,%ebx
  802347:	89 d8                	mov    %ebx,%eax
  802349:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80234d:	d3 e0                	shl    %cl,%eax
  80234f:	89 e9                	mov    %ebp,%ecx
  802351:	d3 ea                	shr    %cl,%edx
  802353:	09 d0                	or     %edx,%eax
  802355:	89 e9                	mov    %ebp,%ecx
  802357:	d3 eb                	shr    %cl,%ebx
  802359:	89 da                	mov    %ebx,%edx
  80235b:	83 c4 1c             	add    $0x1c,%esp
  80235e:	5b                   	pop    %ebx
  80235f:	5e                   	pop    %esi
  802360:	5f                   	pop    %edi
  802361:	5d                   	pop    %ebp
  802362:	c3                   	ret    
  802363:	90                   	nop
  802364:	89 fd                	mov    %edi,%ebp
  802366:	85 ff                	test   %edi,%edi
  802368:	75 0b                	jne    802375 <__umoddi3+0xe9>
  80236a:	b8 01 00 00 00       	mov    $0x1,%eax
  80236f:	31 d2                	xor    %edx,%edx
  802371:	f7 f7                	div    %edi
  802373:	89 c5                	mov    %eax,%ebp
  802375:	89 f0                	mov    %esi,%eax
  802377:	31 d2                	xor    %edx,%edx
  802379:	f7 f5                	div    %ebp
  80237b:	89 c8                	mov    %ecx,%eax
  80237d:	f7 f5                	div    %ebp
  80237f:	89 d0                	mov    %edx,%eax
  802381:	e9 44 ff ff ff       	jmp    8022ca <__umoddi3+0x3e>
  802386:	66 90                	xchg   %ax,%ax
  802388:	89 c8                	mov    %ecx,%eax
  80238a:	89 f2                	mov    %esi,%edx
  80238c:	83 c4 1c             	add    $0x1c,%esp
  80238f:	5b                   	pop    %ebx
  802390:	5e                   	pop    %esi
  802391:	5f                   	pop    %edi
  802392:	5d                   	pop    %ebp
  802393:	c3                   	ret    
  802394:	3b 04 24             	cmp    (%esp),%eax
  802397:	72 06                	jb     80239f <__umoddi3+0x113>
  802399:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80239d:	77 0f                	ja     8023ae <__umoddi3+0x122>
  80239f:	89 f2                	mov    %esi,%edx
  8023a1:	29 f9                	sub    %edi,%ecx
  8023a3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023a7:	89 14 24             	mov    %edx,(%esp)
  8023aa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ae:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023b2:	8b 14 24             	mov    (%esp),%edx
  8023b5:	83 c4 1c             	add    $0x1c,%esp
  8023b8:	5b                   	pop    %ebx
  8023b9:	5e                   	pop    %esi
  8023ba:	5f                   	pop    %edi
  8023bb:	5d                   	pop    %ebp
  8023bc:	c3                   	ret    
  8023bd:	8d 76 00             	lea    0x0(%esi),%esi
  8023c0:	2b 04 24             	sub    (%esp),%eax
  8023c3:	19 fa                	sbb    %edi,%edx
  8023c5:	89 d1                	mov    %edx,%ecx
  8023c7:	89 c6                	mov    %eax,%esi
  8023c9:	e9 71 ff ff ff       	jmp    80233f <__umoddi3+0xb3>
  8023ce:	66 90                	xchg   %ax,%ax
  8023d0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023d4:	72 ea                	jb     8023c0 <__umoddi3+0x134>
  8023d6:	89 d9                	mov    %ebx,%ecx
  8023d8:	e9 62 ff ff ff       	jmp    80233f <__umoddi3+0xb3>
