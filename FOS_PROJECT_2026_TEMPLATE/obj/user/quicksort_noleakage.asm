
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 dc 05 00 00       	call   800612 <libmain>
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
		//2012: lock the interrupt
		//sys_lock_cons();
		//2024: lock the console only using a sleepLock
		int NumOfElements;
		int *Elements;
		sys_lock_cons();
  800041:	e8 7e 1d 00 00       	call   801dc4 <sys_lock_cons>
		{
			cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 26 80 00       	push   $0x802620
  80004e:	e8 ed 0a 00 00       	call   800b40 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 26 80 00       	push   $0x802622
  80005e:	e8 dd 0a 00 00       	call   800b40 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 3b 26 80 00       	push   $0x80263b
  80006e:	e8 cd 0a 00 00       	call   800b40 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 26 80 00       	push   $0x802622
  80007e:	e8 bd 0a 00 00       	call   800b40 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 26 80 00       	push   $0x802620
  80008e:	e8 ad 0a 00 00       	call   800b40 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

			readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 54 26 80 00       	push   $0x802654
  8000a5:	e8 6f 11 00 00       	call   801219 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
			NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 70 17 00 00       	call   801830 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
			cprintf("Chose the initialization method:\n") ;
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	68 74 26 80 00       	push   $0x802674
  8000ce:	e8 6d 0a 00 00       	call   800b40 <cprintf>
  8000d3:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 96 26 80 00       	push   $0x802696
  8000de:	e8 5d 0a 00 00       	call   800b40 <cprintf>
  8000e3:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000e6:	83 ec 0c             	sub    $0xc,%esp
  8000e9:	68 a4 26 80 00       	push   $0x8026a4
  8000ee:	e8 4d 0a 00 00       	call   800b40 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000f6:	83 ec 0c             	sub    $0xc,%esp
  8000f9:	68 b3 26 80 00       	push   $0x8026b3
  8000fe:	e8 3d 0a 00 00       	call   800b40 <cprintf>
  800103:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  800106:	83 ec 0c             	sub    $0xc,%esp
  800109:	68 c3 26 80 00       	push   $0x8026c3
  80010e:	e8 2d 0a 00 00       	call   800b40 <cprintf>
  800113:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800116:	e8 d4 04 00 00       	call   8005ef <getchar>
  80011b:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80011e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800122:	83 ec 0c             	sub    $0xc,%esp
  800125:	50                   	push   %eax
  800126:	e8 a5 04 00 00       	call   8005d0 <cputchar>
  80012b:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80012e:	83 ec 0c             	sub    $0xc,%esp
  800131:	6a 0a                	push   $0xa
  800133:	e8 98 04 00 00       	call   8005d0 <cputchar>
  800138:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80013b:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80013f:	74 0c                	je     80014d <_main+0x115>
  800141:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800145:	74 06                	je     80014d <_main+0x115>
  800147:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80014b:	75 b9                	jne    800106 <_main+0xce>
		}
		//2012: unlock
		sys_unlock_cons();
  80014d:	e8 8c 1c 00 00       	call   801dde <sys_unlock_cons>
		//sys_unlock_cons();

		Elements = malloc(sizeof(int) * NumOfElements) ;
  800152:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800155:	c1 e0 02             	shl    $0x2,%eax
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	50                   	push   %eax
  80015c:	e8 3f 1b 00 00       	call   801ca0 <malloc>
  800161:	83 c4 10             	add    $0x10,%esp
  800164:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 03 03 00 00       	call   80048b <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 21 03 00 00       	call   8004bc <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 43 03 00 00       	call   8004f1 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 30 03 00 00       	call   8004f1 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 fe 00 00 00       	call   8002d0 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		//sys_lock_cons();
		sys_lock_cons();
  8001d5:	e8 ea 1b 00 00       	call   801dc4 <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 cc 26 80 00       	push   $0x8026cc
  8001e2:	e8 59 09 00 00       	call   800b40 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
			//		PrintElements(Elements, NumOfElements);
		}
		sys_unlock_cons();
  8001ea:	e8 ef 1b 00 00       	call   801dde <sys_unlock_cons>
		//sys_unlock_cons();

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 e4 01 00 00       	call   8003e1 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 00 27 80 00       	push   $0x802700
  800211:	6a 54                	push   $0x54
  800213:	68 22 27 80 00       	push   $0x802722
  800218:	e8 55 06 00 00       	call   800872 <_panic>
		else
		{
			//			sys_lock_cons();
			sys_lock_cons();
  80021d:	e8 a2 1b 00 00       	call   801dc4 <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 40 27 80 00       	push   $0x802740
  80022a:	e8 11 09 00 00       	call   800b40 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 74 27 80 00       	push   $0x802774
  80023a:	e8 01 09 00 00       	call   800b40 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 a8 27 80 00       	push   $0x8027a8
  80024a:	e8 f1 08 00 00       	call   800b40 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  800252:	e8 87 1b 00 00       	call   801dde <sys_unlock_cons>
			//			sys_unlock_cons();


		}

		free(Elements) ;
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	ff 75 ec             	pushl  -0x14(%ebp)
  80025d:	e8 6c 1a 00 00       	call   801cce <free>
  800262:	83 c4 10             	add    $0x10,%esp

		//		sys_lock_cons();
		sys_lock_cons();
  800265:	e8 5a 1b 00 00       	call   801dc4 <sys_lock_cons>
		{
			Chose = 0 ;
  80026a:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  80026e:	eb 42                	jmp    8002b2 <_main+0x27a>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800270:	83 ec 0c             	sub    $0xc,%esp
  800273:	68 da 27 80 00       	push   $0x8027da
  800278:	e8 c3 08 00 00       	call   800b40 <cprintf>
  80027d:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800280:	e8 6a 03 00 00       	call   8005ef <getchar>
  800285:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  800288:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	50                   	push   %eax
  800290:	e8 3b 03 00 00       	call   8005d0 <cputchar>
  800295:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	6a 0a                	push   $0xa
  80029d:	e8 2e 03 00 00       	call   8005d0 <cputchar>
  8002a2:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	6a 0a                	push   $0xa
  8002aa:	e8 21 03 00 00       	call   8005d0 <cputchar>
  8002af:	83 c4 10             	add    $0x10,%esp

		//		sys_lock_cons();
		sys_lock_cons();
		{
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b2:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b6:	74 06                	je     8002be <_main+0x286>
  8002b8:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002bc:	75 b2                	jne    800270 <_main+0x238>
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		}
		sys_unlock_cons();
  8002be:	e8 1b 1b 00 00       	call   801dde <sys_unlock_cons>
		//		sys_unlock_cons();

	} while (Chose == 'y');
  8002c3:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c7:	0f 84 74 fd ff ff    	je     800041 <_main+0x9>

}
  8002cd:	90                   	nop
  8002ce:	c9                   	leave  
  8002cf:	c3                   	ret    

008002d0 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d9:	48                   	dec    %eax
  8002da:	50                   	push   %eax
  8002db:	6a 00                	push   $0x0
  8002dd:	ff 75 0c             	pushl  0xc(%ebp)
  8002e0:	ff 75 08             	pushl  0x8(%ebp)
  8002e3:	e8 06 00 00 00       	call   8002ee <QSort>
  8002e8:	83 c4 10             	add    $0x10,%esp
}
  8002eb:	90                   	nop
  8002ec:	c9                   	leave  
  8002ed:	c3                   	ret    

008002ee <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002ee:	55                   	push   %ebp
  8002ef:	89 e5                	mov    %esp,%ebp
  8002f1:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f7:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002fa:	0f 8d de 00 00 00    	jge    8003de <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800300:	8b 45 10             	mov    0x10(%ebp),%eax
  800303:	40                   	inc    %eax
  800304:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800307:	8b 45 14             	mov    0x14(%ebp),%eax
  80030a:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  80030d:	e9 80 00 00 00       	jmp    800392 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800312:	ff 45 f4             	incl   -0xc(%ebp)
  800315:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800318:	3b 45 14             	cmp    0x14(%ebp),%eax
  80031b:	7f 2b                	jg     800348 <QSort+0x5a>
  80031d:	8b 45 10             	mov    0x10(%ebp),%eax
  800320:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800327:	8b 45 08             	mov    0x8(%ebp),%eax
  80032a:	01 d0                	add    %edx,%eax
  80032c:	8b 10                	mov    (%eax),%edx
  80032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800331:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800338:	8b 45 08             	mov    0x8(%ebp),%eax
  80033b:	01 c8                	add    %ecx,%eax
  80033d:	8b 00                	mov    (%eax),%eax
  80033f:	39 c2                	cmp    %eax,%edx
  800341:	7d cf                	jge    800312 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800343:	eb 03                	jmp    800348 <QSort+0x5a>
  800345:	ff 4d f0             	decl   -0x10(%ebp)
  800348:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80034e:	7e 26                	jle    800376 <QSort+0x88>
  800350:	8b 45 10             	mov    0x10(%ebp),%eax
  800353:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80035a:	8b 45 08             	mov    0x8(%ebp),%eax
  80035d:	01 d0                	add    %edx,%eax
  80035f:	8b 10                	mov    (%eax),%edx
  800361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800364:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	01 c8                	add    %ecx,%eax
  800370:	8b 00                	mov    (%eax),%eax
  800372:	39 c2                	cmp    %eax,%edx
  800374:	7e cf                	jle    800345 <QSort+0x57>

		if (i <= j)
  800376:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800379:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80037c:	7f 14                	jg     800392 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	ff 75 f0             	pushl  -0x10(%ebp)
  800384:	ff 75 f4             	pushl  -0xc(%ebp)
  800387:	ff 75 08             	pushl  0x8(%ebp)
  80038a:	e8 a9 00 00 00       	call   800438 <Swap>
  80038f:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800392:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800395:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800398:	0f 8e 77 ff ff ff    	jle    800315 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80039e:	83 ec 04             	sub    $0x4,%esp
  8003a1:	ff 75 f0             	pushl  -0x10(%ebp)
  8003a4:	ff 75 10             	pushl  0x10(%ebp)
  8003a7:	ff 75 08             	pushl  0x8(%ebp)
  8003aa:	e8 89 00 00 00       	call   800438 <Swap>
  8003af:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b5:	48                   	dec    %eax
  8003b6:	50                   	push   %eax
  8003b7:	ff 75 10             	pushl  0x10(%ebp)
  8003ba:	ff 75 0c             	pushl  0xc(%ebp)
  8003bd:	ff 75 08             	pushl  0x8(%ebp)
  8003c0:	e8 29 ff ff ff       	call   8002ee <QSort>
  8003c5:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003c8:	ff 75 14             	pushl  0x14(%ebp)
  8003cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ce:	ff 75 0c             	pushl  0xc(%ebp)
  8003d1:	ff 75 08             	pushl  0x8(%ebp)
  8003d4:	e8 15 ff ff ff       	call   8002ee <QSort>
  8003d9:	83 c4 10             	add    $0x10,%esp
  8003dc:	eb 01                	jmp    8003df <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003de:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003df:	c9                   	leave  
  8003e0:	c3                   	ret    

008003e1 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003e1:	55                   	push   %ebp
  8003e2:	89 e5                	mov    %esp,%ebp
  8003e4:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003e7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003f5:	eb 33                	jmp    80042a <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	01 d0                	add    %edx,%eax
  800406:	8b 10                	mov    (%eax),%edx
  800408:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80040b:	40                   	inc    %eax
  80040c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	01 c8                	add    %ecx,%eax
  800418:	8b 00                	mov    (%eax),%eax
  80041a:	39 c2                	cmp    %eax,%edx
  80041c:	7e 09                	jle    800427 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80041e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800425:	eb 0c                	jmp    800433 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800427:	ff 45 f8             	incl   -0x8(%ebp)
  80042a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042d:	48                   	dec    %eax
  80042e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800431:	7f c4                	jg     8003f7 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800433:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800436:	c9                   	leave  
  800437:	c3                   	ret    

00800438 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800438:	55                   	push   %ebp
  800439:	89 e5                	mov    %esp,%ebp
  80043b:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80043e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	01 d0                	add    %edx,%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800452:	8b 45 0c             	mov    0xc(%ebp),%eax
  800455:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	01 c2                	add    %eax,%edx
  800461:	8b 45 10             	mov    0x10(%ebp),%eax
  800464:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 c8                	add    %ecx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800474:	8b 45 10             	mov    0x10(%ebp),%eax
  800477:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	01 c2                	add    %eax,%edx
  800483:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800486:	89 02                	mov    %eax,(%edx)
}
  800488:	90                   	nop
  800489:	c9                   	leave  
  80048a:	c3                   	ret    

0080048b <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80048b:	55                   	push   %ebp
  80048c:	89 e5                	mov    %esp,%ebp
  80048e:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800491:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800498:	eb 17                	jmp    8004b1 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	01 c2                	add    %eax,%edx
  8004a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ac:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004ae:	ff 45 fc             	incl   -0x4(%ebp)
  8004b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004b7:	7c e1                	jl     80049a <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004b9:	90                   	nop
  8004ba:	c9                   	leave  
  8004bb:	c3                   	ret    

008004bc <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004bc:	55                   	push   %ebp
  8004bd:	89 e5                	mov    %esp,%ebp
  8004bf:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004c9:	eb 1b                	jmp    8004e6 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d8:	01 c2                	add    %eax,%edx
  8004da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004dd:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004e0:	48                   	dec    %eax
  8004e1:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004e3:	ff 45 fc             	incl   -0x4(%ebp)
  8004e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ec:	7c dd                	jl     8004cb <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004ee:	90                   	nop
  8004ef:	c9                   	leave  
  8004f0:	c3                   	ret    

008004f1 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004f1:	55                   	push   %ebp
  8004f2:	89 e5                	mov    %esp,%ebp
  8004f4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004fa:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004ff:	f7 e9                	imul   %ecx
  800501:	c1 f9 1f             	sar    $0x1f,%ecx
  800504:	89 d0                	mov    %edx,%eax
  800506:	29 c8                	sub    %ecx,%eax
  800508:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  80050b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80050f:	75 07                	jne    800518 <InitializeSemiRandom+0x27>
		Repetition = 3;
  800511:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800518:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80051f:	eb 1e                	jmp    80053f <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  800521:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800524:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800534:	99                   	cltd   
  800535:	f7 7d f8             	idivl  -0x8(%ebp)
  800538:	89 d0                	mov    %edx,%eax
  80053a:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
		Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  80053c:	ff 45 fc             	incl   -0x4(%ebp)
  80053f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800542:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800545:	7c da                	jl     800521 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800547:	90                   	nop
  800548:	c9                   	leave  
  800549:	c3                   	ret    

0080054a <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80054a:	55                   	push   %ebp
  80054b:	89 e5                	mov    %esp,%ebp
  80054d:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800550:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800557:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80055e:	eb 42                	jmp    8005a2 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800560:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800563:	99                   	cltd   
  800564:	f7 7d f0             	idivl  -0x10(%ebp)
  800567:	89 d0                	mov    %edx,%eax
  800569:	85 c0                	test   %eax,%eax
  80056b:	75 10                	jne    80057d <PrintElements+0x33>
			cprintf("\n");
  80056d:	83 ec 0c             	sub    $0xc,%esp
  800570:	68 20 26 80 00       	push   $0x802620
  800575:	e8 c6 05 00 00       	call   800b40 <cprintf>
  80057a:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80057d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800580:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	01 d0                	add    %edx,%eax
  80058c:	8b 00                	mov    (%eax),%eax
  80058e:	83 ec 08             	sub    $0x8,%esp
  800591:	50                   	push   %eax
  800592:	68 f8 27 80 00       	push   $0x8027f8
  800597:	e8 a4 05 00 00       	call   800b40 <cprintf>
  80059c:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80059f:	ff 45 f4             	incl   -0xc(%ebp)
  8005a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a5:	48                   	dec    %eax
  8005a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005a9:	7f b5                	jg     800560 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b8:	01 d0                	add    %edx,%eax
  8005ba:	8b 00                	mov    (%eax),%eax
  8005bc:	83 ec 08             	sub    $0x8,%esp
  8005bf:	50                   	push   %eax
  8005c0:	68 fd 27 80 00       	push   $0x8027fd
  8005c5:	e8 76 05 00 00       	call   800b40 <cprintf>
  8005ca:	83 c4 10             	add    $0x10,%esp

}
  8005cd:	90                   	nop
  8005ce:	c9                   	leave  
  8005cf:	c3                   	ret    

008005d0 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005d0:	55                   	push   %ebp
  8005d1:	89 e5                	mov    %esp,%ebp
  8005d3:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005dc:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005e0:	83 ec 0c             	sub    $0xc,%esp
  8005e3:	50                   	push   %eax
  8005e4:	e8 23 19 00 00       	call   801f0c <sys_cputc>
  8005e9:	83 c4 10             	add    $0x10,%esp
}
  8005ec:	90                   	nop
  8005ed:	c9                   	leave  
  8005ee:	c3                   	ret    

008005ef <getchar>:


int
getchar(void)
{
  8005ef:	55                   	push   %ebp
  8005f0:	89 e5                	mov    %esp,%ebp
  8005f2:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8005f5:	e8 b1 17 00 00       	call   801dab <sys_cgetc>
  8005fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8005fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800601:	74 f2                	je     8005f5 <getchar+0x6>
	return c;
  800603:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800606:	c9                   	leave  
  800607:	c3                   	ret    

00800608 <iscons>:

int iscons(int fdnum)
{
  800608:	55                   	push   %ebp
  800609:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80060b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800610:	5d                   	pop    %ebp
  800611:	c3                   	ret    

00800612 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800612:	55                   	push   %ebp
  800613:	89 e5                	mov    %esp,%ebp
  800615:	57                   	push   %edi
  800616:	56                   	push   %esi
  800617:	53                   	push   %ebx
  800618:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80061e:	e8 19 1a 00 00       	call   80203c <sys_getenvindex>
  800623:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800626:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800629:	89 d0                	mov    %edx,%eax
  80062b:	c1 e0 03             	shl    $0x3,%eax
  80062e:	01 d0                	add    %edx,%eax
  800630:	c1 e0 06             	shl    $0x6,%eax
  800633:	01 d0                	add    %edx,%eax
  800635:	c1 e0 03             	shl    $0x3,%eax
  800638:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80063d:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800642:	a1 24 40 80 00       	mov    0x804024,%eax
  800647:	8a 40 10             	mov    0x10(%eax),%al
  80064a:	84 c0                	test   %al,%al
  80064c:	74 0d                	je     80065b <libmain+0x49>
		binaryname = myEnv->prog_name;
  80064e:	a1 24 40 80 00       	mov    0x804024,%eax
  800653:	83 c0 10             	add    $0x10,%eax
  800656:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80065b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80065f:	7e 0a                	jle    80066b <libmain+0x59>
		binaryname = argv[0];
  800661:	8b 45 0c             	mov    0xc(%ebp),%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  80066b:	83 ec 08             	sub    $0x8,%esp
  80066e:	ff 75 0c             	pushl  0xc(%ebp)
  800671:	ff 75 08             	pushl  0x8(%ebp)
  800674:	e8 bf f9 ff ff       	call   800038 <_main>
  800679:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80067c:	a1 00 40 80 00       	mov    0x804000,%eax
  800681:	85 c0                	test   %eax,%eax
  800683:	0f 84 b7 01 00 00    	je     800840 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800689:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80068f:	bb 40 29 80 00       	mov    $0x802940,%ebx
  800694:	ba 0e 00 00 00       	mov    $0xe,%edx
  800699:	89 c7                	mov    %eax,%edi
  80069b:	89 de                	mov    %ebx,%esi
  80069d:	89 d1                	mov    %edx,%ecx
  80069f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006a1:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8006a7:	b9 56 00 00 00       	mov    $0x56,%ecx
  8006ac:	b0 00                	mov    $0x0,%al
  8006ae:	89 d7                	mov    %edx,%edi
  8006b0:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8006b2:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8006b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	50                   	push   %eax
  8006c0:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8006c6:	50                   	push   %eax
  8006c7:	e8 70 1b 00 00       	call   80223c <sys_utilities>
  8006cc:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8006cf:	e8 f0 16 00 00       	call   801dc4 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8006d4:	83 ec 0c             	sub    $0xc,%esp
  8006d7:	68 1c 28 80 00       	push   $0x80281c
  8006dc:	e8 5f 04 00 00       	call   800b40 <cprintf>
  8006e1:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006e4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006e7:	85 c0                	test   %eax,%eax
  8006e9:	74 58                	je     800743 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006eb:	e8 6a 1b 00 00       	call   80225a <sys_get_optimal_num_faults>
  8006f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006f3:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006f9:	bb a4 29 80 00       	mov    $0x8029a4,%ebx
  8006fe:	ba 11 00 00 00       	mov    $0x11,%edx
  800703:	89 c7                	mov    %eax,%edi
  800705:	89 de                	mov    %ebx,%esi
  800707:	89 d1                	mov    %edx,%ecx
  800709:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80070b:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80070e:	b9 53 00 00 00       	mov    $0x53,%ecx
  800713:	b0 00                	mov    $0x0,%al
  800715:	89 d7                	mov    %edx,%edi
  800717:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 dc             	pushl  -0x24(%ebp)
  80071f:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800725:	50                   	push   %eax
  800726:	e8 11 1b 00 00       	call   80223c <sys_utilities>
  80072b:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80072e:	83 ec 08             	sub    $0x8,%esp
  800731:	ff 75 dc             	pushl  -0x24(%ebp)
  800734:	68 44 28 80 00       	push   $0x802844
  800739:	e8 02 04 00 00       	call   800b40 <cprintf>
  80073e:	83 c4 10             	add    $0x10,%esp
  800741:	eb 59                	jmp    80079c <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800743:	a1 24 40 80 00       	mov    0x804024,%eax
  800748:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80074e:	a1 24 40 80 00       	mov    0x804024,%eax
  800753:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800759:	83 ec 04             	sub    $0x4,%esp
  80075c:	52                   	push   %edx
  80075d:	50                   	push   %eax
  80075e:	68 68 28 80 00       	push   $0x802868
  800763:	e8 d8 03 00 00       	call   800b40 <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80076b:	a1 24 40 80 00       	mov    0x804024,%eax
  800770:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800776:	a1 24 40 80 00       	mov    0x804024,%eax
  80077b:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800781:	a1 24 40 80 00       	mov    0x804024,%eax
  800786:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80078c:	51                   	push   %ecx
  80078d:	52                   	push   %edx
  80078e:	50                   	push   %eax
  80078f:	68 90 28 80 00       	push   $0x802890
  800794:	e8 a7 03 00 00       	call   800b40 <cprintf>
  800799:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80079c:	a1 24 40 80 00       	mov    0x804024,%eax
  8007a1:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	50                   	push   %eax
  8007ab:	68 e8 28 80 00       	push   $0x8028e8
  8007b0:	e8 8b 03 00 00       	call   800b40 <cprintf>
  8007b5:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8007b8:	83 ec 0c             	sub    $0xc,%esp
  8007bb:	68 fc 28 80 00       	push   $0x8028fc
  8007c0:	e8 7b 03 00 00       	call   800b40 <cprintf>
  8007c5:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007c8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8007cf:	eb 28                	jmp    8007f9 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8007d1:	a1 24 40 80 00       	mov    0x804024,%eax
  8007d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007d9:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007df:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007e2:	83 ec 04             	sub    $0x4,%esp
  8007e5:	50                   	push   %eax
  8007e6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007e9:	68 13 29 80 00       	push   $0x802913
  8007ee:	e8 4d 03 00 00       	call   800b40 <cprintf>
  8007f3:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007f6:	ff 45 e4             	incl   -0x1c(%ebp)
  8007f9:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007fd:	7e d2                	jle    8007d1 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007ff:	83 ec 0c             	sub    $0xc,%esp
  800802:	68 22 29 80 00       	push   $0x802922
  800807:	e8 34 03 00 00       	call   800b40 <cprintf>
  80080c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80080f:	a1 24 40 80 00       	mov    0x804024,%eax
  800814:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80081a:	83 ec 08             	sub    $0x8,%esp
  80081d:	50                   	push   %eax
  80081e:	68 26 29 80 00       	push   $0x802926
  800823:	e8 18 03 00 00       	call   800b40 <cprintf>
  800828:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80082b:	83 ec 0c             	sub    $0xc,%esp
  80082e:	68 1c 28 80 00       	push   $0x80281c
  800833:	e8 08 03 00 00       	call   800b40 <cprintf>
  800838:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80083b:	e8 9e 15 00 00       	call   801dde <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800840:	e8 1f 00 00 00       	call   800864 <exit>
}
  800845:	90                   	nop
  800846:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800849:	5b                   	pop    %ebx
  80084a:	5e                   	pop    %esi
  80084b:	5f                   	pop    %edi
  80084c:	5d                   	pop    %ebp
  80084d:	c3                   	ret    

0080084e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80084e:	55                   	push   %ebp
  80084f:	89 e5                	mov    %esp,%ebp
  800851:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800854:	83 ec 0c             	sub    $0xc,%esp
  800857:	6a 00                	push   $0x0
  800859:	e8 aa 17 00 00       	call   802008 <sys_destroy_env>
  80085e:	83 c4 10             	add    $0x10,%esp
}
  800861:	90                   	nop
  800862:	c9                   	leave  
  800863:	c3                   	ret    

00800864 <exit>:

void
exit(void)
{
  800864:	55                   	push   %ebp
  800865:	89 e5                	mov    %esp,%ebp
  800867:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80086a:	e8 ff 17 00 00       	call   80206e <sys_exit_env>
}
  80086f:	90                   	nop
  800870:	c9                   	leave  
  800871:	c3                   	ret    

00800872 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
  800875:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800878:	8d 45 10             	lea    0x10(%ebp),%eax
  80087b:	83 c0 04             	add    $0x4,%eax
  80087e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800881:	a1 28 41 80 00       	mov    0x804128,%eax
  800886:	85 c0                	test   %eax,%eax
  800888:	74 16                	je     8008a0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80088a:	a1 28 41 80 00       	mov    0x804128,%eax
  80088f:	83 ec 08             	sub    $0x8,%esp
  800892:	50                   	push   %eax
  800893:	68 08 2a 80 00       	push   $0x802a08
  800898:	e8 a3 02 00 00       	call   800b40 <cprintf>
  80089d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8008a0:	a1 04 40 80 00       	mov    0x804004,%eax
  8008a5:	83 ec 0c             	sub    $0xc,%esp
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	ff 75 08             	pushl  0x8(%ebp)
  8008ae:	50                   	push   %eax
  8008af:	68 10 2a 80 00       	push   $0x802a10
  8008b4:	6a 74                	push   $0x74
  8008b6:	e8 b2 02 00 00       	call   800b6d <cprintf_colored>
  8008bb:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8008be:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c1:	83 ec 08             	sub    $0x8,%esp
  8008c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c7:	50                   	push   %eax
  8008c8:	e8 04 02 00 00       	call   800ad1 <vcprintf>
  8008cd:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008d0:	83 ec 08             	sub    $0x8,%esp
  8008d3:	6a 00                	push   $0x0
  8008d5:	68 38 2a 80 00       	push   $0x802a38
  8008da:	e8 f2 01 00 00       	call   800ad1 <vcprintf>
  8008df:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008e2:	e8 7d ff ff ff       	call   800864 <exit>

	// should not return here
	while (1) ;
  8008e7:	eb fe                	jmp    8008e7 <_panic+0x75>

008008e9 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008e9:	55                   	push   %ebp
  8008ea:	89 e5                	mov    %esp,%ebp
  8008ec:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008ef:	a1 24 40 80 00       	mov    0x804024,%eax
  8008f4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fd:	39 c2                	cmp    %eax,%edx
  8008ff:	74 14                	je     800915 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800901:	83 ec 04             	sub    $0x4,%esp
  800904:	68 3c 2a 80 00       	push   $0x802a3c
  800909:	6a 26                	push   $0x26
  80090b:	68 88 2a 80 00       	push   $0x802a88
  800910:	e8 5d ff ff ff       	call   800872 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800915:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80091c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800923:	e9 c5 00 00 00       	jmp    8009ed <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800928:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	01 d0                	add    %edx,%eax
  800937:	8b 00                	mov    (%eax),%eax
  800939:	85 c0                	test   %eax,%eax
  80093b:	75 08                	jne    800945 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80093d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800940:	e9 a5 00 00 00       	jmp    8009ea <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800945:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80094c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800953:	eb 69                	jmp    8009be <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800955:	a1 24 40 80 00       	mov    0x804024,%eax
  80095a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800960:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800963:	89 d0                	mov    %edx,%eax
  800965:	01 c0                	add    %eax,%eax
  800967:	01 d0                	add    %edx,%eax
  800969:	c1 e0 03             	shl    $0x3,%eax
  80096c:	01 c8                	add    %ecx,%eax
  80096e:	8a 40 04             	mov    0x4(%eax),%al
  800971:	84 c0                	test   %al,%al
  800973:	75 46                	jne    8009bb <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800975:	a1 24 40 80 00       	mov    0x804024,%eax
  80097a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800980:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800983:	89 d0                	mov    %edx,%eax
  800985:	01 c0                	add    %eax,%eax
  800987:	01 d0                	add    %edx,%eax
  800989:	c1 e0 03             	shl    $0x3,%eax
  80098c:	01 c8                	add    %ecx,%eax
  80098e:	8b 00                	mov    (%eax),%eax
  800990:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800993:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800996:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80099b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80099d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009a0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	01 c8                	add    %ecx,%eax
  8009ac:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009ae:	39 c2                	cmp    %eax,%edx
  8009b0:	75 09                	jne    8009bb <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8009b2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009b9:	eb 15                	jmp    8009d0 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009bb:	ff 45 e8             	incl   -0x18(%ebp)
  8009be:	a1 24 40 80 00       	mov    0x804024,%eax
  8009c3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009cc:	39 c2                	cmp    %eax,%edx
  8009ce:	77 85                	ja     800955 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009d4:	75 14                	jne    8009ea <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8009d6:	83 ec 04             	sub    $0x4,%esp
  8009d9:	68 94 2a 80 00       	push   $0x802a94
  8009de:	6a 3a                	push   $0x3a
  8009e0:	68 88 2a 80 00       	push   $0x802a88
  8009e5:	e8 88 fe ff ff       	call   800872 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009ea:	ff 45 f0             	incl   -0x10(%ebp)
  8009ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009f3:	0f 8c 2f ff ff ff    	jl     800928 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a00:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a07:	eb 26                	jmp    800a2f <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a09:	a1 24 40 80 00       	mov    0x804024,%eax
  800a0e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a14:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a17:	89 d0                	mov    %edx,%eax
  800a19:	01 c0                	add    %eax,%eax
  800a1b:	01 d0                	add    %edx,%eax
  800a1d:	c1 e0 03             	shl    $0x3,%eax
  800a20:	01 c8                	add    %ecx,%eax
  800a22:	8a 40 04             	mov    0x4(%eax),%al
  800a25:	3c 01                	cmp    $0x1,%al
  800a27:	75 03                	jne    800a2c <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800a29:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2c:	ff 45 e0             	incl   -0x20(%ebp)
  800a2f:	a1 24 40 80 00       	mov    0x804024,%eax
  800a34:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a3d:	39 c2                	cmp    %eax,%edx
  800a3f:	77 c8                	ja     800a09 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a44:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a47:	74 14                	je     800a5d <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a49:	83 ec 04             	sub    $0x4,%esp
  800a4c:	68 e8 2a 80 00       	push   $0x802ae8
  800a51:	6a 44                	push   $0x44
  800a53:	68 88 2a 80 00       	push   $0x802a88
  800a58:	e8 15 fe ff ff       	call   800872 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a5d:	90                   	nop
  800a5e:	c9                   	leave  
  800a5f:	c3                   	ret    

00800a60 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	53                   	push   %ebx
  800a64:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	8b 00                	mov    (%eax),%eax
  800a6c:	8d 48 01             	lea    0x1(%eax),%ecx
  800a6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a72:	89 0a                	mov    %ecx,(%edx)
  800a74:	8b 55 08             	mov    0x8(%ebp),%edx
  800a77:	88 d1                	mov    %dl,%cl
  800a79:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a83:	8b 00                	mov    (%eax),%eax
  800a85:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a8a:	75 30                	jne    800abc <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a8c:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800a92:	a0 40 40 80 00       	mov    0x804040,%al
  800a97:	0f b6 c0             	movzbl %al,%eax
  800a9a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a9d:	8b 09                	mov    (%ecx),%ecx
  800a9f:	89 cb                	mov    %ecx,%ebx
  800aa1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800aa4:	83 c1 08             	add    $0x8,%ecx
  800aa7:	52                   	push   %edx
  800aa8:	50                   	push   %eax
  800aa9:	53                   	push   %ebx
  800aaa:	51                   	push   %ecx
  800aab:	e8 d0 12 00 00       	call   801d80 <sys_cputs>
  800ab0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800abc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abf:	8b 40 04             	mov    0x4(%eax),%eax
  800ac2:	8d 50 01             	lea    0x1(%eax),%edx
  800ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac8:	89 50 04             	mov    %edx,0x4(%eax)
}
  800acb:	90                   	nop
  800acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800acf:	c9                   	leave  
  800ad0:	c3                   	ret    

00800ad1 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
  800ad4:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ada:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ae1:	00 00 00 
	b.cnt = 0;
  800ae4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aeb:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	ff 75 08             	pushl  0x8(%ebp)
  800af4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800afa:	50                   	push   %eax
  800afb:	68 60 0a 80 00       	push   $0x800a60
  800b00:	e8 5a 02 00 00       	call   800d5f <vprintfmt>
  800b05:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800b08:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800b0e:	a0 40 40 80 00       	mov    0x804040,%al
  800b13:	0f b6 c0             	movzbl %al,%eax
  800b16:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800b1c:	52                   	push   %edx
  800b1d:	50                   	push   %eax
  800b1e:	51                   	push   %ecx
  800b1f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b25:	83 c0 08             	add    $0x8,%eax
  800b28:	50                   	push   %eax
  800b29:	e8 52 12 00 00       	call   801d80 <sys_cputs>
  800b2e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b31:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800b38:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b3e:	c9                   	leave  
  800b3f:	c3                   	ret    

00800b40 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b46:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800b4d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b50:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	83 ec 08             	sub    $0x8,%esp
  800b59:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5c:	50                   	push   %eax
  800b5d:	e8 6f ff ff ff       	call   800ad1 <vcprintf>
  800b62:	83 c4 10             	add    $0x10,%esp
  800b65:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b6b:	c9                   	leave  
  800b6c:	c3                   	ret    

00800b6d <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b6d:	55                   	push   %ebp
  800b6e:	89 e5                	mov    %esp,%ebp
  800b70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b73:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	c1 e0 08             	shl    $0x8,%eax
  800b80:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800b85:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b88:	83 c0 04             	add    $0x4,%eax
  800b8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 f4             	pushl  -0xc(%ebp)
  800b97:	50                   	push   %eax
  800b98:	e8 34 ff ff ff       	call   800ad1 <vcprintf>
  800b9d:	83 c4 10             	add    $0x10,%esp
  800ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800ba3:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800baa:	07 00 00 

	return cnt;
  800bad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb0:	c9                   	leave  
  800bb1:	c3                   	ret    

00800bb2 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800bb2:	55                   	push   %ebp
  800bb3:	89 e5                	mov    %esp,%ebp
  800bb5:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800bb8:	e8 07 12 00 00       	call   801dc4 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800bbd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	83 ec 08             	sub    $0x8,%esp
  800bc9:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcc:	50                   	push   %eax
  800bcd:	e8 ff fe ff ff       	call   800ad1 <vcprintf>
  800bd2:	83 c4 10             	add    $0x10,%esp
  800bd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800bd8:	e8 01 12 00 00       	call   801dde <sys_unlock_cons>
	return cnt;
  800bdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be0:	c9                   	leave  
  800be1:	c3                   	ret    

00800be2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
  800be5:	53                   	push   %ebx
  800be6:	83 ec 14             	sub    $0x14,%esp
  800be9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bef:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf5:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf8:	ba 00 00 00 00       	mov    $0x0,%edx
  800bfd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c00:	77 55                	ja     800c57 <printnum+0x75>
  800c02:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c05:	72 05                	jb     800c0c <printnum+0x2a>
  800c07:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0a:	77 4b                	ja     800c57 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c0c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c0f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c12:	8b 45 18             	mov    0x18(%ebp),%eax
  800c15:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1a:	52                   	push   %edx
  800c1b:	50                   	push   %eax
  800c1c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1f:	ff 75 f0             	pushl  -0x10(%ebp)
  800c22:	e8 95 17 00 00       	call   8023bc <__udivdi3>
  800c27:	83 c4 10             	add    $0x10,%esp
  800c2a:	83 ec 04             	sub    $0x4,%esp
  800c2d:	ff 75 20             	pushl  0x20(%ebp)
  800c30:	53                   	push   %ebx
  800c31:	ff 75 18             	pushl  0x18(%ebp)
  800c34:	52                   	push   %edx
  800c35:	50                   	push   %eax
  800c36:	ff 75 0c             	pushl  0xc(%ebp)
  800c39:	ff 75 08             	pushl  0x8(%ebp)
  800c3c:	e8 a1 ff ff ff       	call   800be2 <printnum>
  800c41:	83 c4 20             	add    $0x20,%esp
  800c44:	eb 1a                	jmp    800c60 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c46:	83 ec 08             	sub    $0x8,%esp
  800c49:	ff 75 0c             	pushl  0xc(%ebp)
  800c4c:	ff 75 20             	pushl  0x20(%ebp)
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	ff d0                	call   *%eax
  800c54:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c57:	ff 4d 1c             	decl   0x1c(%ebp)
  800c5a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c5e:	7f e6                	jg     800c46 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c60:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c63:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c6e:	53                   	push   %ebx
  800c6f:	51                   	push   %ecx
  800c70:	52                   	push   %edx
  800c71:	50                   	push   %eax
  800c72:	e8 55 18 00 00       	call   8024cc <__umoddi3>
  800c77:	83 c4 10             	add    $0x10,%esp
  800c7a:	05 54 2d 80 00       	add    $0x802d54,%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	0f be c0             	movsbl %al,%eax
  800c84:	83 ec 08             	sub    $0x8,%esp
  800c87:	ff 75 0c             	pushl  0xc(%ebp)
  800c8a:	50                   	push   %eax
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	ff d0                	call   *%eax
  800c90:	83 c4 10             	add    $0x10,%esp
}
  800c93:	90                   	nop
  800c94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c9c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ca0:	7e 1c                	jle    800cbe <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8b 00                	mov    (%eax),%eax
  800ca7:	8d 50 08             	lea    0x8(%eax),%edx
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	89 10                	mov    %edx,(%eax)
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8b 00                	mov    (%eax),%eax
  800cb4:	83 e8 08             	sub    $0x8,%eax
  800cb7:	8b 50 04             	mov    0x4(%eax),%edx
  800cba:	8b 00                	mov    (%eax),%eax
  800cbc:	eb 40                	jmp    800cfe <getuint+0x65>
	else if (lflag)
  800cbe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc2:	74 1e                	je     800ce2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8b 00                	mov    (%eax),%eax
  800cc9:	8d 50 04             	lea    0x4(%eax),%edx
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	89 10                	mov    %edx,(%eax)
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8b 00                	mov    (%eax),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	ba 00 00 00 00       	mov    $0x0,%edx
  800ce0:	eb 1c                	jmp    800cfe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8b 00                	mov    (%eax),%eax
  800ce7:	8d 50 04             	lea    0x4(%eax),%edx
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	89 10                	mov    %edx,(%eax)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	83 e8 04             	sub    $0x4,%eax
  800cf7:	8b 00                	mov    (%eax),%eax
  800cf9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cfe:	5d                   	pop    %ebp
  800cff:	c3                   	ret    

00800d00 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d00:	55                   	push   %ebp
  800d01:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d03:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d07:	7e 1c                	jle    800d25 <getint+0x25>
		return va_arg(*ap, long long);
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8b 00                	mov    (%eax),%eax
  800d0e:	8d 50 08             	lea    0x8(%eax),%edx
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	89 10                	mov    %edx,(%eax)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	83 e8 08             	sub    $0x8,%eax
  800d1e:	8b 50 04             	mov    0x4(%eax),%edx
  800d21:	8b 00                	mov    (%eax),%eax
  800d23:	eb 38                	jmp    800d5d <getint+0x5d>
	else if (lflag)
  800d25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d29:	74 1a                	je     800d45 <getint+0x45>
		return va_arg(*ap, long);
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8b 00                	mov    (%eax),%eax
  800d30:	8d 50 04             	lea    0x4(%eax),%edx
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	89 10                	mov    %edx,(%eax)
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8b 00                	mov    (%eax),%eax
  800d3d:	83 e8 04             	sub    $0x4,%eax
  800d40:	8b 00                	mov    (%eax),%eax
  800d42:	99                   	cltd   
  800d43:	eb 18                	jmp    800d5d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8b 00                	mov    (%eax),%eax
  800d4a:	8d 50 04             	lea    0x4(%eax),%edx
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	89 10                	mov    %edx,(%eax)
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8b 00                	mov    (%eax),%eax
  800d57:	83 e8 04             	sub    $0x4,%eax
  800d5a:	8b 00                	mov    (%eax),%eax
  800d5c:	99                   	cltd   
}
  800d5d:	5d                   	pop    %ebp
  800d5e:	c3                   	ret    

00800d5f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	56                   	push   %esi
  800d63:	53                   	push   %ebx
  800d64:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d67:	eb 17                	jmp    800d80 <vprintfmt+0x21>
			if (ch == '\0')
  800d69:	85 db                	test   %ebx,%ebx
  800d6b:	0f 84 c1 03 00 00    	je     801132 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 0c             	pushl  0xc(%ebp)
  800d77:	53                   	push   %ebx
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	ff d0                	call   *%eax
  800d7d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d80:	8b 45 10             	mov    0x10(%ebp),%eax
  800d83:	8d 50 01             	lea    0x1(%eax),%edx
  800d86:	89 55 10             	mov    %edx,0x10(%ebp)
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	0f b6 d8             	movzbl %al,%ebx
  800d8e:	83 fb 25             	cmp    $0x25,%ebx
  800d91:	75 d6                	jne    800d69 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d93:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d97:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d9e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db3:	8b 45 10             	mov    0x10(%ebp),%eax
  800db6:	8d 50 01             	lea    0x1(%eax),%edx
  800db9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	0f b6 d8             	movzbl %al,%ebx
  800dc1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc4:	83 f8 5b             	cmp    $0x5b,%eax
  800dc7:	0f 87 3d 03 00 00    	ja     80110a <vprintfmt+0x3ab>
  800dcd:	8b 04 85 78 2d 80 00 	mov    0x802d78(,%eax,4),%eax
  800dd4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dda:	eb d7                	jmp    800db3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ddc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800de0:	eb d1                	jmp    800db3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dec:	89 d0                	mov    %edx,%eax
  800dee:	c1 e0 02             	shl    $0x2,%eax
  800df1:	01 d0                	add    %edx,%eax
  800df3:	01 c0                	add    %eax,%eax
  800df5:	01 d8                	add    %ebx,%eax
  800df7:	83 e8 30             	sub    $0x30,%eax
  800dfa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e05:	83 fb 2f             	cmp    $0x2f,%ebx
  800e08:	7e 3e                	jle    800e48 <vprintfmt+0xe9>
  800e0a:	83 fb 39             	cmp    $0x39,%ebx
  800e0d:	7f 39                	jg     800e48 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e0f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e12:	eb d5                	jmp    800de9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e14:	8b 45 14             	mov    0x14(%ebp),%eax
  800e17:	83 c0 04             	add    $0x4,%eax
  800e1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e20:	83 e8 04             	sub    $0x4,%eax
  800e23:	8b 00                	mov    (%eax),%eax
  800e25:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e28:	eb 1f                	jmp    800e49 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2e:	79 83                	jns    800db3 <vprintfmt+0x54>
				width = 0;
  800e30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e37:	e9 77 ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e3c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e43:	e9 6b ff ff ff       	jmp    800db3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e48:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4d:	0f 89 60 ff ff ff    	jns    800db3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e53:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e59:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e60:	e9 4e ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e65:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e68:	e9 46 ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e70:	83 c0 04             	add    $0x4,%eax
  800e73:	89 45 14             	mov    %eax,0x14(%ebp)
  800e76:	8b 45 14             	mov    0x14(%ebp),%eax
  800e79:	83 e8 04             	sub    $0x4,%eax
  800e7c:	8b 00                	mov    (%eax),%eax
  800e7e:	83 ec 08             	sub    $0x8,%esp
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	50                   	push   %eax
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	ff d0                	call   *%eax
  800e8a:	83 c4 10             	add    $0x10,%esp
			break;
  800e8d:	e9 9b 02 00 00       	jmp    80112d <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e92:	8b 45 14             	mov    0x14(%ebp),%eax
  800e95:	83 c0 04             	add    $0x4,%eax
  800e98:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9e:	83 e8 04             	sub    $0x4,%eax
  800ea1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea3:	85 db                	test   %ebx,%ebx
  800ea5:	79 02                	jns    800ea9 <vprintfmt+0x14a>
				err = -err;
  800ea7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea9:	83 fb 64             	cmp    $0x64,%ebx
  800eac:	7f 0b                	jg     800eb9 <vprintfmt+0x15a>
  800eae:	8b 34 9d c0 2b 80 00 	mov    0x802bc0(,%ebx,4),%esi
  800eb5:	85 f6                	test   %esi,%esi
  800eb7:	75 19                	jne    800ed2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb9:	53                   	push   %ebx
  800eba:	68 65 2d 80 00       	push   $0x802d65
  800ebf:	ff 75 0c             	pushl  0xc(%ebp)
  800ec2:	ff 75 08             	pushl  0x8(%ebp)
  800ec5:	e8 70 02 00 00       	call   80113a <printfmt>
  800eca:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ecd:	e9 5b 02 00 00       	jmp    80112d <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ed2:	56                   	push   %esi
  800ed3:	68 6e 2d 80 00       	push   $0x802d6e
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	ff 75 08             	pushl  0x8(%ebp)
  800ede:	e8 57 02 00 00       	call   80113a <printfmt>
  800ee3:	83 c4 10             	add    $0x10,%esp
			break;
  800ee6:	e9 42 02 00 00       	jmp    80112d <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800eeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800eee:	83 c0 04             	add    $0x4,%eax
  800ef1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef7:	83 e8 04             	sub    $0x4,%eax
  800efa:	8b 30                	mov    (%eax),%esi
  800efc:	85 f6                	test   %esi,%esi
  800efe:	75 05                	jne    800f05 <vprintfmt+0x1a6>
				p = "(null)";
  800f00:	be 71 2d 80 00       	mov    $0x802d71,%esi
			if (width > 0 && padc != '-')
  800f05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f09:	7e 6d                	jle    800f78 <vprintfmt+0x219>
  800f0b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f0f:	74 67                	je     800f78 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f11:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f14:	83 ec 08             	sub    $0x8,%esp
  800f17:	50                   	push   %eax
  800f18:	56                   	push   %esi
  800f19:	e8 26 05 00 00       	call   801444 <strnlen>
  800f1e:	83 c4 10             	add    $0x10,%esp
  800f21:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f24:	eb 16                	jmp    800f3c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f26:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f2a:	83 ec 08             	sub    $0x8,%esp
  800f2d:	ff 75 0c             	pushl  0xc(%ebp)
  800f30:	50                   	push   %eax
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f39:	ff 4d e4             	decl   -0x1c(%ebp)
  800f3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f40:	7f e4                	jg     800f26 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f42:	eb 34                	jmp    800f78 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f44:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f48:	74 1c                	je     800f66 <vprintfmt+0x207>
  800f4a:	83 fb 1f             	cmp    $0x1f,%ebx
  800f4d:	7e 05                	jle    800f54 <vprintfmt+0x1f5>
  800f4f:	83 fb 7e             	cmp    $0x7e,%ebx
  800f52:	7e 12                	jle    800f66 <vprintfmt+0x207>
					putch('?', putdat);
  800f54:	83 ec 08             	sub    $0x8,%esp
  800f57:	ff 75 0c             	pushl  0xc(%ebp)
  800f5a:	6a 3f                	push   $0x3f
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	ff d0                	call   *%eax
  800f61:	83 c4 10             	add    $0x10,%esp
  800f64:	eb 0f                	jmp    800f75 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f66:	83 ec 08             	sub    $0x8,%esp
  800f69:	ff 75 0c             	pushl  0xc(%ebp)
  800f6c:	53                   	push   %ebx
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	ff d0                	call   *%eax
  800f72:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f75:	ff 4d e4             	decl   -0x1c(%ebp)
  800f78:	89 f0                	mov    %esi,%eax
  800f7a:	8d 70 01             	lea    0x1(%eax),%esi
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	0f be d8             	movsbl %al,%ebx
  800f82:	85 db                	test   %ebx,%ebx
  800f84:	74 24                	je     800faa <vprintfmt+0x24b>
  800f86:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f8a:	78 b8                	js     800f44 <vprintfmt+0x1e5>
  800f8c:	ff 4d e0             	decl   -0x20(%ebp)
  800f8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f93:	79 af                	jns    800f44 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f95:	eb 13                	jmp    800faa <vprintfmt+0x24b>
				putch(' ', putdat);
  800f97:	83 ec 08             	sub    $0x8,%esp
  800f9a:	ff 75 0c             	pushl  0xc(%ebp)
  800f9d:	6a 20                	push   $0x20
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	ff d0                	call   *%eax
  800fa4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa7:	ff 4d e4             	decl   -0x1c(%ebp)
  800faa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fae:	7f e7                	jg     800f97 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fb0:	e9 78 01 00 00       	jmp    80112d <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb5:	83 ec 08             	sub    $0x8,%esp
  800fb8:	ff 75 e8             	pushl  -0x18(%ebp)
  800fbb:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbe:	50                   	push   %eax
  800fbf:	e8 3c fd ff ff       	call   800d00 <getint>
  800fc4:	83 c4 10             	add    $0x10,%esp
  800fc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd3:	85 d2                	test   %edx,%edx
  800fd5:	79 23                	jns    800ffa <vprintfmt+0x29b>
				putch('-', putdat);
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	6a 2d                	push   $0x2d
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fed:	f7 d8                	neg    %eax
  800fef:	83 d2 00             	adc    $0x0,%edx
  800ff2:	f7 da                	neg    %edx
  800ff4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ffa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801001:	e9 bc 00 00 00       	jmp    8010c2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801006:	83 ec 08             	sub    $0x8,%esp
  801009:	ff 75 e8             	pushl  -0x18(%ebp)
  80100c:	8d 45 14             	lea    0x14(%ebp),%eax
  80100f:	50                   	push   %eax
  801010:	e8 84 fc ff ff       	call   800c99 <getuint>
  801015:	83 c4 10             	add    $0x10,%esp
  801018:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80101e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801025:	e9 98 00 00 00       	jmp    8010c2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80102a:	83 ec 08             	sub    $0x8,%esp
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	6a 58                	push   $0x58
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	ff d0                	call   *%eax
  801037:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103a:	83 ec 08             	sub    $0x8,%esp
  80103d:	ff 75 0c             	pushl  0xc(%ebp)
  801040:	6a 58                	push   $0x58
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	ff d0                	call   *%eax
  801047:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	ff 75 0c             	pushl  0xc(%ebp)
  801050:	6a 58                	push   $0x58
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	ff d0                	call   *%eax
  801057:	83 c4 10             	add    $0x10,%esp
			break;
  80105a:	e9 ce 00 00 00       	jmp    80112d <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80105f:	83 ec 08             	sub    $0x8,%esp
  801062:	ff 75 0c             	pushl  0xc(%ebp)
  801065:	6a 30                	push   $0x30
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	ff d0                	call   *%eax
  80106c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80106f:	83 ec 08             	sub    $0x8,%esp
  801072:	ff 75 0c             	pushl  0xc(%ebp)
  801075:	6a 78                	push   $0x78
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	ff d0                	call   *%eax
  80107c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80107f:	8b 45 14             	mov    0x14(%ebp),%eax
  801082:	83 c0 04             	add    $0x4,%eax
  801085:	89 45 14             	mov    %eax,0x14(%ebp)
  801088:	8b 45 14             	mov    0x14(%ebp),%eax
  80108b:	83 e8 04             	sub    $0x4,%eax
  80108e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801090:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801093:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80109a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010a1:	eb 1f                	jmp    8010c2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a3:	83 ec 08             	sub    $0x8,%esp
  8010a6:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a9:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ac:	50                   	push   %eax
  8010ad:	e8 e7 fb ff ff       	call   800c99 <getuint>
  8010b2:	83 c4 10             	add    $0x10,%esp
  8010b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010bb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010c2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c9:	83 ec 04             	sub    $0x4,%esp
  8010cc:	52                   	push   %edx
  8010cd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010d0:	50                   	push   %eax
  8010d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d7:	ff 75 0c             	pushl  0xc(%ebp)
  8010da:	ff 75 08             	pushl  0x8(%ebp)
  8010dd:	e8 00 fb ff ff       	call   800be2 <printnum>
  8010e2:	83 c4 20             	add    $0x20,%esp
			break;
  8010e5:	eb 46                	jmp    80112d <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e7:	83 ec 08             	sub    $0x8,%esp
  8010ea:	ff 75 0c             	pushl  0xc(%ebp)
  8010ed:	53                   	push   %ebx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	ff d0                	call   *%eax
  8010f3:	83 c4 10             	add    $0x10,%esp
			break;
  8010f6:	eb 35                	jmp    80112d <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010f8:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  8010ff:	eb 2c                	jmp    80112d <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801101:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801108:	eb 23                	jmp    80112d <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80110a:	83 ec 08             	sub    $0x8,%esp
  80110d:	ff 75 0c             	pushl  0xc(%ebp)
  801110:	6a 25                	push   $0x25
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	ff d0                	call   *%eax
  801117:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80111a:	ff 4d 10             	decl   0x10(%ebp)
  80111d:	eb 03                	jmp    801122 <vprintfmt+0x3c3>
  80111f:	ff 4d 10             	decl   0x10(%ebp)
  801122:	8b 45 10             	mov    0x10(%ebp),%eax
  801125:	48                   	dec    %eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	3c 25                	cmp    $0x25,%al
  80112a:	75 f3                	jne    80111f <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80112c:	90                   	nop
		}
	}
  80112d:	e9 35 fc ff ff       	jmp    800d67 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801132:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801133:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801136:	5b                   	pop    %ebx
  801137:	5e                   	pop    %esi
  801138:	5d                   	pop    %ebp
  801139:	c3                   	ret    

0080113a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801140:	8d 45 10             	lea    0x10(%ebp),%eax
  801143:	83 c0 04             	add    $0x4,%eax
  801146:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801149:	8b 45 10             	mov    0x10(%ebp),%eax
  80114c:	ff 75 f4             	pushl  -0xc(%ebp)
  80114f:	50                   	push   %eax
  801150:	ff 75 0c             	pushl  0xc(%ebp)
  801153:	ff 75 08             	pushl  0x8(%ebp)
  801156:	e8 04 fc ff ff       	call   800d5f <vprintfmt>
  80115b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80115e:	90                   	nop
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	8b 40 08             	mov    0x8(%eax),%eax
  80116a:	8d 50 01             	lea    0x1(%eax),%edx
  80116d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801170:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801173:	8b 45 0c             	mov    0xc(%ebp),%eax
  801176:	8b 10                	mov    (%eax),%edx
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	8b 40 04             	mov    0x4(%eax),%eax
  80117e:	39 c2                	cmp    %eax,%edx
  801180:	73 12                	jae    801194 <sprintputch+0x33>
		*b->buf++ = ch;
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	8b 00                	mov    (%eax),%eax
  801187:	8d 48 01             	lea    0x1(%eax),%ecx
  80118a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118d:	89 0a                	mov    %ecx,(%edx)
  80118f:	8b 55 08             	mov    0x8(%ebp),%edx
  801192:	88 10                	mov    %dl,(%eax)
}
  801194:	90                   	nop
  801195:	5d                   	pop    %ebp
  801196:	c3                   	ret    

00801197 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801197:	55                   	push   %ebp
  801198:	89 e5                	mov    %esp,%ebp
  80119a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ac:	01 d0                	add    %edx,%eax
  8011ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011bc:	74 06                	je     8011c4 <vsnprintf+0x2d>
  8011be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011c2:	7f 07                	jg     8011cb <vsnprintf+0x34>
		return -E_INVAL;
  8011c4:	b8 03 00 00 00       	mov    $0x3,%eax
  8011c9:	eb 20                	jmp    8011eb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011cb:	ff 75 14             	pushl  0x14(%ebp)
  8011ce:	ff 75 10             	pushl  0x10(%ebp)
  8011d1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011d4:	50                   	push   %eax
  8011d5:	68 61 11 80 00       	push   $0x801161
  8011da:	e8 80 fb ff ff       	call   800d5f <vprintfmt>
  8011df:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
  8011f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8011f6:	83 c0 04             	add    $0x4,%eax
  8011f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ff:	ff 75 f4             	pushl  -0xc(%ebp)
  801202:	50                   	push   %eax
  801203:	ff 75 0c             	pushl  0xc(%ebp)
  801206:	ff 75 08             	pushl  0x8(%ebp)
  801209:	e8 89 ff ff ff       	call   801197 <vsnprintf>
  80120e:	83 c4 10             	add    $0x10,%esp
  801211:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801214:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801217:	c9                   	leave  
  801218:	c3                   	ret    

00801219 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
  80121c:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  80121f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801223:	74 13                	je     801238 <readline+0x1f>
		cprintf("%s", prompt);
  801225:	83 ec 08             	sub    $0x8,%esp
  801228:	ff 75 08             	pushl  0x8(%ebp)
  80122b:	68 e8 2e 80 00       	push   $0x802ee8
  801230:	e8 0b f9 ff ff       	call   800b40 <cprintf>
  801235:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80123f:	83 ec 0c             	sub    $0xc,%esp
  801242:	6a 00                	push   $0x0
  801244:	e8 bf f3 ff ff       	call   800608 <iscons>
  801249:	83 c4 10             	add    $0x10,%esp
  80124c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80124f:	e8 9b f3 ff ff       	call   8005ef <getchar>
  801254:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801257:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80125b:	79 22                	jns    80127f <readline+0x66>
			if (c != -E_EOF)
  80125d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801261:	0f 84 ad 00 00 00    	je     801314 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801267:	83 ec 08             	sub    $0x8,%esp
  80126a:	ff 75 ec             	pushl  -0x14(%ebp)
  80126d:	68 eb 2e 80 00       	push   $0x802eeb
  801272:	e8 c9 f8 ff ff       	call   800b40 <cprintf>
  801277:	83 c4 10             	add    $0x10,%esp
			break;
  80127a:	e9 95 00 00 00       	jmp    801314 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80127f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801283:	7e 34                	jle    8012b9 <readline+0xa0>
  801285:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80128c:	7f 2b                	jg     8012b9 <readline+0xa0>
			if (echoing)
  80128e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801292:	74 0e                	je     8012a2 <readline+0x89>
				cputchar(c);
  801294:	83 ec 0c             	sub    $0xc,%esp
  801297:	ff 75 ec             	pushl  -0x14(%ebp)
  80129a:	e8 31 f3 ff ff       	call   8005d0 <cputchar>
  80129f:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012a5:	8d 50 01             	lea    0x1(%eax),%edx
  8012a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012ab:	89 c2                	mov    %eax,%edx
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b5:	88 10                	mov    %dl,(%eax)
  8012b7:	eb 56                	jmp    80130f <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012b9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012bd:	75 1f                	jne    8012de <readline+0xc5>
  8012bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012c3:	7e 19                	jle    8012de <readline+0xc5>
			if (echoing)
  8012c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c9:	74 0e                	je     8012d9 <readline+0xc0>
				cputchar(c);
  8012cb:	83 ec 0c             	sub    $0xc,%esp
  8012ce:	ff 75 ec             	pushl  -0x14(%ebp)
  8012d1:	e8 fa f2 ff ff       	call   8005d0 <cputchar>
  8012d6:	83 c4 10             	add    $0x10,%esp

			i--;
  8012d9:	ff 4d f4             	decl   -0xc(%ebp)
  8012dc:	eb 31                	jmp    80130f <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012de:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012e2:	74 0a                	je     8012ee <readline+0xd5>
  8012e4:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012e8:	0f 85 61 ff ff ff    	jne    80124f <readline+0x36>
			if (echoing)
  8012ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012f2:	74 0e                	je     801302 <readline+0xe9>
				cputchar(c);
  8012f4:	83 ec 0c             	sub    $0xc,%esp
  8012f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8012fa:	e8 d1 f2 ff ff       	call   8005d0 <cputchar>
  8012ff:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801302:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801305:	8b 45 0c             	mov    0xc(%ebp),%eax
  801308:	01 d0                	add    %edx,%eax
  80130a:	c6 00 00             	movb   $0x0,(%eax)
			break;
  80130d:	eb 06                	jmp    801315 <readline+0xfc>
		}
	}
  80130f:	e9 3b ff ff ff       	jmp    80124f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  801314:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  801315:	90                   	nop
  801316:	c9                   	leave  
  801317:	c3                   	ret    

00801318 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801318:	55                   	push   %ebp
  801319:	89 e5                	mov    %esp,%ebp
  80131b:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  80131e:	e8 a1 0a 00 00       	call   801dc4 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  801323:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801327:	74 13                	je     80133c <atomic_readline+0x24>
			cprintf("%s", prompt);
  801329:	83 ec 08             	sub    $0x8,%esp
  80132c:	ff 75 08             	pushl  0x8(%ebp)
  80132f:	68 e8 2e 80 00       	push   $0x802ee8
  801334:	e8 07 f8 ff ff       	call   800b40 <cprintf>
  801339:	83 c4 10             	add    $0x10,%esp

		i = 0;
  80133c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  801343:	83 ec 0c             	sub    $0xc,%esp
  801346:	6a 00                	push   $0x0
  801348:	e8 bb f2 ff ff       	call   800608 <iscons>
  80134d:	83 c4 10             	add    $0x10,%esp
  801350:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  801353:	e8 97 f2 ff ff       	call   8005ef <getchar>
  801358:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  80135b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80135f:	79 22                	jns    801383 <atomic_readline+0x6b>
				if (c != -E_EOF)
  801361:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801365:	0f 84 ad 00 00 00    	je     801418 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  80136b:	83 ec 08             	sub    $0x8,%esp
  80136e:	ff 75 ec             	pushl  -0x14(%ebp)
  801371:	68 eb 2e 80 00       	push   $0x802eeb
  801376:	e8 c5 f7 ff ff       	call   800b40 <cprintf>
  80137b:	83 c4 10             	add    $0x10,%esp
				break;
  80137e:	e9 95 00 00 00       	jmp    801418 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  801383:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801387:	7e 34                	jle    8013bd <atomic_readline+0xa5>
  801389:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801390:	7f 2b                	jg     8013bd <atomic_readline+0xa5>
				if (echoing)
  801392:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801396:	74 0e                	je     8013a6 <atomic_readline+0x8e>
					cputchar(c);
  801398:	83 ec 0c             	sub    $0xc,%esp
  80139b:	ff 75 ec             	pushl  -0x14(%ebp)
  80139e:	e8 2d f2 ff ff       	call   8005d0 <cputchar>
  8013a3:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  8013a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a9:	8d 50 01             	lea    0x1(%eax),%edx
  8013ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013af:	89 c2                	mov    %eax,%edx
  8013b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b4:	01 d0                	add    %edx,%eax
  8013b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013b9:	88 10                	mov    %dl,(%eax)
  8013bb:	eb 56                	jmp    801413 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  8013bd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013c1:	75 1f                	jne    8013e2 <atomic_readline+0xca>
  8013c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013c7:	7e 19                	jle    8013e2 <atomic_readline+0xca>
				if (echoing)
  8013c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013cd:	74 0e                	je     8013dd <atomic_readline+0xc5>
					cputchar(c);
  8013cf:	83 ec 0c             	sub    $0xc,%esp
  8013d2:	ff 75 ec             	pushl  -0x14(%ebp)
  8013d5:	e8 f6 f1 ff ff       	call   8005d0 <cputchar>
  8013da:	83 c4 10             	add    $0x10,%esp
				i--;
  8013dd:	ff 4d f4             	decl   -0xc(%ebp)
  8013e0:	eb 31                	jmp    801413 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  8013e2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013e6:	74 0a                	je     8013f2 <atomic_readline+0xda>
  8013e8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013ec:	0f 85 61 ff ff ff    	jne    801353 <atomic_readline+0x3b>
				if (echoing)
  8013f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013f6:	74 0e                	je     801406 <atomic_readline+0xee>
					cputchar(c);
  8013f8:	83 ec 0c             	sub    $0xc,%esp
  8013fb:	ff 75 ec             	pushl  -0x14(%ebp)
  8013fe:	e8 cd f1 ff ff       	call   8005d0 <cputchar>
  801403:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  801406:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801409:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140c:	01 d0                	add    %edx,%eax
  80140e:	c6 00 00             	movb   $0x0,(%eax)
				break;
  801411:	eb 06                	jmp    801419 <atomic_readline+0x101>
			}
		}
  801413:	e9 3b ff ff ff       	jmp    801353 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  801418:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  801419:	e8 c0 09 00 00       	call   801dde <sys_unlock_cons>
}
  80141e:	90                   	nop
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
  801424:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801427:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80142e:	eb 06                	jmp    801436 <strlen+0x15>
		n++;
  801430:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801433:	ff 45 08             	incl   0x8(%ebp)
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	8a 00                	mov    (%eax),%al
  80143b:	84 c0                	test   %al,%al
  80143d:	75 f1                	jne    801430 <strlen+0xf>
		n++;
	return n;
  80143f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
  801447:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80144a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801451:	eb 09                	jmp    80145c <strnlen+0x18>
		n++;
  801453:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801456:	ff 45 08             	incl   0x8(%ebp)
  801459:	ff 4d 0c             	decl   0xc(%ebp)
  80145c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801460:	74 09                	je     80146b <strnlen+0x27>
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	84 c0                	test   %al,%al
  801469:	75 e8                	jne    801453 <strnlen+0xf>
		n++;
	return n;
  80146b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80147c:	90                   	nop
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8d 50 01             	lea    0x1(%eax),%edx
  801483:	89 55 08             	mov    %edx,0x8(%ebp)
  801486:	8b 55 0c             	mov    0xc(%ebp),%edx
  801489:	8d 4a 01             	lea    0x1(%edx),%ecx
  80148c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80148f:	8a 12                	mov    (%edx),%dl
  801491:	88 10                	mov    %dl,(%eax)
  801493:	8a 00                	mov    (%eax),%al
  801495:	84 c0                	test   %al,%al
  801497:	75 e4                	jne    80147d <strcpy+0xd>
		/* do nothing */;
	return ret;
  801499:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
  8014a1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014b1:	eb 1f                	jmp    8014d2 <strncpy+0x34>
		*dst++ = *src;
  8014b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b6:	8d 50 01             	lea    0x1(%eax),%edx
  8014b9:	89 55 08             	mov    %edx,0x8(%ebp)
  8014bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bf:	8a 12                	mov    (%edx),%dl
  8014c1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c6:	8a 00                	mov    (%eax),%al
  8014c8:	84 c0                	test   %al,%al
  8014ca:	74 03                	je     8014cf <strncpy+0x31>
			src++;
  8014cc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014cf:	ff 45 fc             	incl   -0x4(%ebp)
  8014d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014d8:	72 d9                	jb     8014b3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ef:	74 30                	je     801521 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014f1:	eb 16                	jmp    801509 <strlcpy+0x2a>
			*dst++ = *src++;
  8014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f6:	8d 50 01             	lea    0x1(%eax),%edx
  8014f9:	89 55 08             	mov    %edx,0x8(%ebp)
  8014fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801502:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801505:	8a 12                	mov    (%edx),%dl
  801507:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801509:	ff 4d 10             	decl   0x10(%ebp)
  80150c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801510:	74 09                	je     80151b <strlcpy+0x3c>
  801512:	8b 45 0c             	mov    0xc(%ebp),%eax
  801515:	8a 00                	mov    (%eax),%al
  801517:	84 c0                	test   %al,%al
  801519:	75 d8                	jne    8014f3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
  80151e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801521:	8b 55 08             	mov    0x8(%ebp),%edx
  801524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801527:	29 c2                	sub    %eax,%edx
  801529:	89 d0                	mov    %edx,%eax
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801530:	eb 06                	jmp    801538 <strcmp+0xb>
		p++, q++;
  801532:	ff 45 08             	incl   0x8(%ebp)
  801535:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	84 c0                	test   %al,%al
  80153f:	74 0e                	je     80154f <strcmp+0x22>
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	8a 10                	mov    (%eax),%dl
  801546:	8b 45 0c             	mov    0xc(%ebp),%eax
  801549:	8a 00                	mov    (%eax),%al
  80154b:	38 c2                	cmp    %al,%dl
  80154d:	74 e3                	je     801532 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	0f b6 d0             	movzbl %al,%edx
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	8a 00                	mov    (%eax),%al
  80155c:	0f b6 c0             	movzbl %al,%eax
  80155f:	29 c2                	sub    %eax,%edx
  801561:	89 d0                	mov    %edx,%eax
}
  801563:	5d                   	pop    %ebp
  801564:	c3                   	ret    

00801565 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801568:	eb 09                	jmp    801573 <strncmp+0xe>
		n--, p++, q++;
  80156a:	ff 4d 10             	decl   0x10(%ebp)
  80156d:	ff 45 08             	incl   0x8(%ebp)
  801570:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801573:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801577:	74 17                	je     801590 <strncmp+0x2b>
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	8a 00                	mov    (%eax),%al
  80157e:	84 c0                	test   %al,%al
  801580:	74 0e                	je     801590 <strncmp+0x2b>
  801582:	8b 45 08             	mov    0x8(%ebp),%eax
  801585:	8a 10                	mov    (%eax),%dl
  801587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	38 c2                	cmp    %al,%dl
  80158e:	74 da                	je     80156a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801590:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801594:	75 07                	jne    80159d <strncmp+0x38>
		return 0;
  801596:	b8 00 00 00 00       	mov    $0x0,%eax
  80159b:	eb 14                	jmp    8015b1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	8a 00                	mov    (%eax),%al
  8015a2:	0f b6 d0             	movzbl %al,%edx
  8015a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a8:	8a 00                	mov    (%eax),%al
  8015aa:	0f b6 c0             	movzbl %al,%eax
  8015ad:	29 c2                	sub    %eax,%edx
  8015af:	89 d0                	mov    %edx,%eax
}
  8015b1:	5d                   	pop    %ebp
  8015b2:	c3                   	ret    

008015b3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
  8015b6:	83 ec 04             	sub    $0x4,%esp
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015bf:	eb 12                	jmp    8015d3 <strchr+0x20>
		if (*s == c)
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	8a 00                	mov    (%eax),%al
  8015c6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015c9:	75 05                	jne    8015d0 <strchr+0x1d>
			return (char *) s;
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	eb 11                	jmp    8015e1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015d0:	ff 45 08             	incl   0x8(%ebp)
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	84 c0                	test   %al,%al
  8015da:	75 e5                	jne    8015c1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 04             	sub    $0x4,%esp
  8015e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015ef:	eb 0d                	jmp    8015fe <strfind+0x1b>
		if (*s == c)
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	8a 00                	mov    (%eax),%al
  8015f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015f9:	74 0e                	je     801609 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015fb:	ff 45 08             	incl   0x8(%ebp)
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	8a 00                	mov    (%eax),%al
  801603:	84 c0                	test   %al,%al
  801605:	75 ea                	jne    8015f1 <strfind+0xe>
  801607:	eb 01                	jmp    80160a <strfind+0x27>
		if (*s == c)
			break;
  801609:	90                   	nop
	return (char *) s;
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
  801612:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80161b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80161f:	76 63                	jbe    801684 <memset+0x75>
		uint64 data_block = c;
  801621:	8b 45 0c             	mov    0xc(%ebp),%eax
  801624:	99                   	cltd   
  801625:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801628:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80162b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80162e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801631:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801635:	c1 e0 08             	shl    $0x8,%eax
  801638:	09 45 f0             	or     %eax,-0x10(%ebp)
  80163b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80163e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801641:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801644:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801648:	c1 e0 10             	shl    $0x10,%eax
  80164b:	09 45 f0             	or     %eax,-0x10(%ebp)
  80164e:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801651:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801654:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801657:	89 c2                	mov    %eax,%edx
  801659:	b8 00 00 00 00       	mov    $0x0,%eax
  80165e:	09 45 f0             	or     %eax,-0x10(%ebp)
  801661:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801664:	eb 18                	jmp    80167e <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801666:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801669:	8d 41 08             	lea    0x8(%ecx),%eax
  80166c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80166f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801672:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801675:	89 01                	mov    %eax,(%ecx)
  801677:	89 51 04             	mov    %edx,0x4(%ecx)
  80167a:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80167e:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801682:	77 e2                	ja     801666 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801684:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801688:	74 23                	je     8016ad <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80168a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80168d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801690:	eb 0e                	jmp    8016a0 <memset+0x91>
			*p8++ = (uint8)c;
  801692:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801695:	8d 50 01             	lea    0x1(%eax),%edx
  801698:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80169b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169e:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8016a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8016a9:	85 c0                	test   %eax,%eax
  8016ab:	75 e5                	jne    801692 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016b0:	c9                   	leave  
  8016b1:	c3                   	ret    

008016b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
  8016b5:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8016b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8016c4:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8016c8:	76 24                	jbe    8016ee <memcpy+0x3c>
		while(n >= 8){
  8016ca:	eb 1c                	jmp    8016e8 <memcpy+0x36>
			*d64 = *s64;
  8016cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016cf:	8b 50 04             	mov    0x4(%eax),%edx
  8016d2:	8b 00                	mov    (%eax),%eax
  8016d4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016d7:	89 01                	mov    %eax,(%ecx)
  8016d9:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8016dc:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8016e0:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8016e4:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8016e8:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8016ec:	77 de                	ja     8016cc <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8016ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016f2:	74 31                	je     801725 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8016f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8016fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801700:	eb 16                	jmp    801718 <memcpy+0x66>
			*d8++ = *s8++;
  801702:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801705:	8d 50 01             	lea    0x1(%eax),%edx
  801708:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80170b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80170e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801711:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801714:	8a 12                	mov    (%edx),%dl
  801716:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80171e:	89 55 10             	mov    %edx,0x10(%ebp)
  801721:	85 c0                	test   %eax,%eax
  801723:	75 dd                	jne    801702 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801728:	c9                   	leave  
  801729:	c3                   	ret    

0080172a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80172a:	55                   	push   %ebp
  80172b:	89 e5                	mov    %esp,%ebp
  80172d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801730:	8b 45 0c             	mov    0xc(%ebp),%eax
  801733:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80173c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80173f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801742:	73 50                	jae    801794 <memmove+0x6a>
  801744:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801747:	8b 45 10             	mov    0x10(%ebp),%eax
  80174a:	01 d0                	add    %edx,%eax
  80174c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80174f:	76 43                	jbe    801794 <memmove+0x6a>
		s += n;
  801751:	8b 45 10             	mov    0x10(%ebp),%eax
  801754:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801757:	8b 45 10             	mov    0x10(%ebp),%eax
  80175a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80175d:	eb 10                	jmp    80176f <memmove+0x45>
			*--d = *--s;
  80175f:	ff 4d f8             	decl   -0x8(%ebp)
  801762:	ff 4d fc             	decl   -0x4(%ebp)
  801765:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801768:	8a 10                	mov    (%eax),%dl
  80176a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80176d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80176f:	8b 45 10             	mov    0x10(%ebp),%eax
  801772:	8d 50 ff             	lea    -0x1(%eax),%edx
  801775:	89 55 10             	mov    %edx,0x10(%ebp)
  801778:	85 c0                	test   %eax,%eax
  80177a:	75 e3                	jne    80175f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80177c:	eb 23                	jmp    8017a1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801781:	8d 50 01             	lea    0x1(%eax),%edx
  801784:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801787:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80178a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80178d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801790:	8a 12                	mov    (%edx),%dl
  801792:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801794:	8b 45 10             	mov    0x10(%ebp),%eax
  801797:	8d 50 ff             	lea    -0x1(%eax),%edx
  80179a:	89 55 10             	mov    %edx,0x10(%ebp)
  80179d:	85 c0                	test   %eax,%eax
  80179f:	75 dd                	jne    80177e <memmove+0x54>
			*d++ = *s++;

	return dst;
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8017b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8017b8:	eb 2a                	jmp    8017e4 <memcmp+0x3e>
		if (*s1 != *s2)
  8017ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017bd:	8a 10                	mov    (%eax),%dl
  8017bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	38 c2                	cmp    %al,%dl
  8017c6:	74 16                	je     8017de <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017cb:	8a 00                	mov    (%eax),%al
  8017cd:	0f b6 d0             	movzbl %al,%edx
  8017d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d3:	8a 00                	mov    (%eax),%al
  8017d5:	0f b6 c0             	movzbl %al,%eax
  8017d8:	29 c2                	sub    %eax,%edx
  8017da:	89 d0                	mov    %edx,%eax
  8017dc:	eb 18                	jmp    8017f6 <memcmp+0x50>
		s1++, s2++;
  8017de:	ff 45 fc             	incl   -0x4(%ebp)
  8017e1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8017ed:	85 c0                	test   %eax,%eax
  8017ef:	75 c9                	jne    8017ba <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
  8017fb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017fe:	8b 55 08             	mov    0x8(%ebp),%edx
  801801:	8b 45 10             	mov    0x10(%ebp),%eax
  801804:	01 d0                	add    %edx,%eax
  801806:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801809:	eb 15                	jmp    801820 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	8a 00                	mov    (%eax),%al
  801810:	0f b6 d0             	movzbl %al,%edx
  801813:	8b 45 0c             	mov    0xc(%ebp),%eax
  801816:	0f b6 c0             	movzbl %al,%eax
  801819:	39 c2                	cmp    %eax,%edx
  80181b:	74 0d                	je     80182a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80181d:	ff 45 08             	incl   0x8(%ebp)
  801820:	8b 45 08             	mov    0x8(%ebp),%eax
  801823:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801826:	72 e3                	jb     80180b <memfind+0x13>
  801828:	eb 01                	jmp    80182b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80182a:	90                   	nop
	return (void *) s;
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801836:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80183d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801844:	eb 03                	jmp    801849 <strtol+0x19>
		s++;
  801846:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	8a 00                	mov    (%eax),%al
  80184e:	3c 20                	cmp    $0x20,%al
  801850:	74 f4                	je     801846 <strtol+0x16>
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	8a 00                	mov    (%eax),%al
  801857:	3c 09                	cmp    $0x9,%al
  801859:	74 eb                	je     801846 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80185b:	8b 45 08             	mov    0x8(%ebp),%eax
  80185e:	8a 00                	mov    (%eax),%al
  801860:	3c 2b                	cmp    $0x2b,%al
  801862:	75 05                	jne    801869 <strtol+0x39>
		s++;
  801864:	ff 45 08             	incl   0x8(%ebp)
  801867:	eb 13                	jmp    80187c <strtol+0x4c>
	else if (*s == '-')
  801869:	8b 45 08             	mov    0x8(%ebp),%eax
  80186c:	8a 00                	mov    (%eax),%al
  80186e:	3c 2d                	cmp    $0x2d,%al
  801870:	75 0a                	jne    80187c <strtol+0x4c>
		s++, neg = 1;
  801872:	ff 45 08             	incl   0x8(%ebp)
  801875:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80187c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801880:	74 06                	je     801888 <strtol+0x58>
  801882:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801886:	75 20                	jne    8018a8 <strtol+0x78>
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	8a 00                	mov    (%eax),%al
  80188d:	3c 30                	cmp    $0x30,%al
  80188f:	75 17                	jne    8018a8 <strtol+0x78>
  801891:	8b 45 08             	mov    0x8(%ebp),%eax
  801894:	40                   	inc    %eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	3c 78                	cmp    $0x78,%al
  801899:	75 0d                	jne    8018a8 <strtol+0x78>
		s += 2, base = 16;
  80189b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80189f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8018a6:	eb 28                	jmp    8018d0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8018a8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018ac:	75 15                	jne    8018c3 <strtol+0x93>
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	8a 00                	mov    (%eax),%al
  8018b3:	3c 30                	cmp    $0x30,%al
  8018b5:	75 0c                	jne    8018c3 <strtol+0x93>
		s++, base = 8;
  8018b7:	ff 45 08             	incl   0x8(%ebp)
  8018ba:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8018c1:	eb 0d                	jmp    8018d0 <strtol+0xa0>
	else if (base == 0)
  8018c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018c7:	75 07                	jne    8018d0 <strtol+0xa0>
		base = 10;
  8018c9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	3c 2f                	cmp    $0x2f,%al
  8018d7:	7e 19                	jle    8018f2 <strtol+0xc2>
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	8a 00                	mov    (%eax),%al
  8018de:	3c 39                	cmp    $0x39,%al
  8018e0:	7f 10                	jg     8018f2 <strtol+0xc2>
			dig = *s - '0';
  8018e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	0f be c0             	movsbl %al,%eax
  8018ea:	83 e8 30             	sub    $0x30,%eax
  8018ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018f0:	eb 42                	jmp    801934 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f5:	8a 00                	mov    (%eax),%al
  8018f7:	3c 60                	cmp    $0x60,%al
  8018f9:	7e 19                	jle    801914 <strtol+0xe4>
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	8a 00                	mov    (%eax),%al
  801900:	3c 7a                	cmp    $0x7a,%al
  801902:	7f 10                	jg     801914 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8a 00                	mov    (%eax),%al
  801909:	0f be c0             	movsbl %al,%eax
  80190c:	83 e8 57             	sub    $0x57,%eax
  80190f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801912:	eb 20                	jmp    801934 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	8a 00                	mov    (%eax),%al
  801919:	3c 40                	cmp    $0x40,%al
  80191b:	7e 39                	jle    801956 <strtol+0x126>
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	8a 00                	mov    (%eax),%al
  801922:	3c 5a                	cmp    $0x5a,%al
  801924:	7f 30                	jg     801956 <strtol+0x126>
			dig = *s - 'A' + 10;
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	8a 00                	mov    (%eax),%al
  80192b:	0f be c0             	movsbl %al,%eax
  80192e:	83 e8 37             	sub    $0x37,%eax
  801931:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801934:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801937:	3b 45 10             	cmp    0x10(%ebp),%eax
  80193a:	7d 19                	jge    801955 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80193c:	ff 45 08             	incl   0x8(%ebp)
  80193f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801942:	0f af 45 10          	imul   0x10(%ebp),%eax
  801946:	89 c2                	mov    %eax,%edx
  801948:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80194b:	01 d0                	add    %edx,%eax
  80194d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801950:	e9 7b ff ff ff       	jmp    8018d0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801955:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801956:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80195a:	74 08                	je     801964 <strtol+0x134>
		*endptr = (char *) s;
  80195c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195f:	8b 55 08             	mov    0x8(%ebp),%edx
  801962:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801964:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801968:	74 07                	je     801971 <strtol+0x141>
  80196a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80196d:	f7 d8                	neg    %eax
  80196f:	eb 03                	jmp    801974 <strtol+0x144>
  801971:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <ltostr>:

void
ltostr(long value, char *str)
{
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80197c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801983:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80198a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80198e:	79 13                	jns    8019a3 <ltostr+0x2d>
	{
		neg = 1;
  801990:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80199d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8019a0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8019ab:	99                   	cltd   
  8019ac:	f7 f9                	idiv   %ecx
  8019ae:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8019b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019b4:	8d 50 01             	lea    0x1(%eax),%edx
  8019b7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019ba:	89 c2                	mov    %eax,%edx
  8019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bf:	01 d0                	add    %edx,%eax
  8019c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019c4:	83 c2 30             	add    $0x30,%edx
  8019c7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019cc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019d1:	f7 e9                	imul   %ecx
  8019d3:	c1 fa 02             	sar    $0x2,%edx
  8019d6:	89 c8                	mov    %ecx,%eax
  8019d8:	c1 f8 1f             	sar    $0x1f,%eax
  8019db:	29 c2                	sub    %eax,%edx
  8019dd:	89 d0                	mov    %edx,%eax
  8019df:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8019e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019e6:	75 bb                	jne    8019a3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f2:	48                   	dec    %eax
  8019f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019fa:	74 3d                	je     801a39 <ltostr+0xc3>
		start = 1 ;
  8019fc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a03:	eb 34                	jmp    801a39 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801a05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0b:	01 d0                	add    %edx,%eax
  801a0d:	8a 00                	mov    (%eax),%al
  801a0f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a12:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a15:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a18:	01 c2                	add    %eax,%edx
  801a1a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a20:	01 c8                	add    %ecx,%eax
  801a22:	8a 00                	mov    (%eax),%al
  801a24:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a26:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2c:	01 c2                	add    %eax,%edx
  801a2e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a31:	88 02                	mov    %al,(%edx)
		start++ ;
  801a33:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a36:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a3f:	7c c4                	jl     801a05 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a41:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a44:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a47:	01 d0                	add    %edx,%eax
  801a49:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a4c:	90                   	nop
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
  801a52:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a55:	ff 75 08             	pushl  0x8(%ebp)
  801a58:	e8 c4 f9 ff ff       	call   801421 <strlen>
  801a5d:	83 c4 04             	add    $0x4,%esp
  801a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a63:	ff 75 0c             	pushl  0xc(%ebp)
  801a66:	e8 b6 f9 ff ff       	call   801421 <strlen>
  801a6b:	83 c4 04             	add    $0x4,%esp
  801a6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a7f:	eb 17                	jmp    801a98 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a81:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a84:	8b 45 10             	mov    0x10(%ebp),%eax
  801a87:	01 c2                	add    %eax,%edx
  801a89:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	01 c8                	add    %ecx,%eax
  801a91:	8a 00                	mov    (%eax),%al
  801a93:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a95:	ff 45 fc             	incl   -0x4(%ebp)
  801a98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a9b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a9e:	7c e1                	jl     801a81 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801aa0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801aa7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801aae:	eb 1f                	jmp    801acf <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ab0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ab3:	8d 50 01             	lea    0x1(%eax),%edx
  801ab6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ab9:	89 c2                	mov    %eax,%edx
  801abb:	8b 45 10             	mov    0x10(%ebp),%eax
  801abe:	01 c2                	add    %eax,%edx
  801ac0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac6:	01 c8                	add    %ecx,%eax
  801ac8:	8a 00                	mov    (%eax),%al
  801aca:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801acc:	ff 45 f8             	incl   -0x8(%ebp)
  801acf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ad2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ad5:	7c d9                	jl     801ab0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ad7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ada:	8b 45 10             	mov    0x10(%ebp),%eax
  801add:	01 d0                	add    %edx,%eax
  801adf:	c6 00 00             	movb   $0x0,(%eax)
}
  801ae2:	90                   	nop
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ae8:	8b 45 14             	mov    0x14(%ebp),%eax
  801aeb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801af1:	8b 45 14             	mov    0x14(%ebp),%eax
  801af4:	8b 00                	mov    (%eax),%eax
  801af6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801afd:	8b 45 10             	mov    0x10(%ebp),%eax
  801b00:	01 d0                	add    %edx,%eax
  801b02:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b08:	eb 0c                	jmp    801b16 <strsplit+0x31>
			*string++ = 0;
  801b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0d:	8d 50 01             	lea    0x1(%eax),%edx
  801b10:	89 55 08             	mov    %edx,0x8(%ebp)
  801b13:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b16:	8b 45 08             	mov    0x8(%ebp),%eax
  801b19:	8a 00                	mov    (%eax),%al
  801b1b:	84 c0                	test   %al,%al
  801b1d:	74 18                	je     801b37 <strsplit+0x52>
  801b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b22:	8a 00                	mov    (%eax),%al
  801b24:	0f be c0             	movsbl %al,%eax
  801b27:	50                   	push   %eax
  801b28:	ff 75 0c             	pushl  0xc(%ebp)
  801b2b:	e8 83 fa ff ff       	call   8015b3 <strchr>
  801b30:	83 c4 08             	add    $0x8,%esp
  801b33:	85 c0                	test   %eax,%eax
  801b35:	75 d3                	jne    801b0a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	8a 00                	mov    (%eax),%al
  801b3c:	84 c0                	test   %al,%al
  801b3e:	74 5a                	je     801b9a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b40:	8b 45 14             	mov    0x14(%ebp),%eax
  801b43:	8b 00                	mov    (%eax),%eax
  801b45:	83 f8 0f             	cmp    $0xf,%eax
  801b48:	75 07                	jne    801b51 <strsplit+0x6c>
		{
			return 0;
  801b4a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b4f:	eb 66                	jmp    801bb7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b51:	8b 45 14             	mov    0x14(%ebp),%eax
  801b54:	8b 00                	mov    (%eax),%eax
  801b56:	8d 48 01             	lea    0x1(%eax),%ecx
  801b59:	8b 55 14             	mov    0x14(%ebp),%edx
  801b5c:	89 0a                	mov    %ecx,(%edx)
  801b5e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b65:	8b 45 10             	mov    0x10(%ebp),%eax
  801b68:	01 c2                	add    %eax,%edx
  801b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b6f:	eb 03                	jmp    801b74 <strsplit+0x8f>
			string++;
  801b71:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b74:	8b 45 08             	mov    0x8(%ebp),%eax
  801b77:	8a 00                	mov    (%eax),%al
  801b79:	84 c0                	test   %al,%al
  801b7b:	74 8b                	je     801b08 <strsplit+0x23>
  801b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b80:	8a 00                	mov    (%eax),%al
  801b82:	0f be c0             	movsbl %al,%eax
  801b85:	50                   	push   %eax
  801b86:	ff 75 0c             	pushl  0xc(%ebp)
  801b89:	e8 25 fa ff ff       	call   8015b3 <strchr>
  801b8e:	83 c4 08             	add    $0x8,%esp
  801b91:	85 c0                	test   %eax,%eax
  801b93:	74 dc                	je     801b71 <strsplit+0x8c>
			string++;
	}
  801b95:	e9 6e ff ff ff       	jmp    801b08 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b9a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b9b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9e:	8b 00                	mov    (%eax),%eax
  801ba0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ba7:	8b 45 10             	mov    0x10(%ebp),%eax
  801baa:	01 d0                	add    %edx,%eax
  801bac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801bb2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801bb7:	c9                   	leave  
  801bb8:	c3                   	ret    

00801bb9 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801bb9:	55                   	push   %ebp
  801bba:	89 e5                	mov    %esp,%ebp
  801bbc:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801bc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bcc:	eb 4a                	jmp    801c18 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801bce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd4:	01 c2                	add    %eax,%edx
  801bd6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bdc:	01 c8                	add    %ecx,%eax
  801bde:	8a 00                	mov    (%eax),%al
  801be0:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801be2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be8:	01 d0                	add    %edx,%eax
  801bea:	8a 00                	mov    (%eax),%al
  801bec:	3c 40                	cmp    $0x40,%al
  801bee:	7e 25                	jle    801c15 <str2lower+0x5c>
  801bf0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bf6:	01 d0                	add    %edx,%eax
  801bf8:	8a 00                	mov    (%eax),%al
  801bfa:	3c 5a                	cmp    $0x5a,%al
  801bfc:	7f 17                	jg     801c15 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801bfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c01:	8b 45 08             	mov    0x8(%ebp),%eax
  801c04:	01 d0                	add    %edx,%eax
  801c06:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c09:	8b 55 08             	mov    0x8(%ebp),%edx
  801c0c:	01 ca                	add    %ecx,%edx
  801c0e:	8a 12                	mov    (%edx),%dl
  801c10:	83 c2 20             	add    $0x20,%edx
  801c13:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801c15:	ff 45 fc             	incl   -0x4(%ebp)
  801c18:	ff 75 0c             	pushl  0xc(%ebp)
  801c1b:	e8 01 f8 ff ff       	call   801421 <strlen>
  801c20:	83 c4 04             	add    $0x4,%esp
  801c23:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801c26:	7f a6                	jg     801bce <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801c28:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
  801c30:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801c33:	a1 08 40 80 00       	mov    0x804008,%eax
  801c38:	85 c0                	test   %eax,%eax
  801c3a:	74 2d                	je     801c69 <uheap_init+0x3c>
	{
		buddy_init();
  801c3c:	e8 87 06 00 00       	call   8022c8 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801c41:	e8 31 05 00 00       	call   802177 <sys_get_uheap_strategy>
  801c46:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801c4b:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801c52:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801c55:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801c5c:	00 00 80 
		__firstTimeFlag = 0;
  801c5f:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801c66:	00 00 00 
	}
}
  801c69:	90                   	nop
  801c6a:	c9                   	leave  
  801c6b:	c3                   	ret    

00801c6c <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
  801c6f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801c72:	83 ec 04             	sub    $0x4,%esp
  801c75:	68 fc 2e 80 00       	push   $0x802efc
  801c7a:	6a 25                	push   $0x25
  801c7c:	68 2d 2f 80 00       	push   $0x802f2d
  801c81:	e8 ec eb ff ff       	call   800872 <_panic>

00801c86 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
  801c89:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801c8c:	83 ec 04             	sub    $0x4,%esp
  801c8f:	68 3c 2f 80 00       	push   $0x802f3c
  801c94:	6a 2f                	push   $0x2f
  801c96:	68 2d 2f 80 00       	push   $0x802f2d
  801c9b:	e8 d2 eb ff ff       	call   800872 <_panic>

00801ca0 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801ca0:	55                   	push   %ebp
  801ca1:	89 e5                	mov    %esp,%ebp
  801ca3:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ca6:	e8 82 ff ff ff       	call   801c2d <uheap_init>
	if (size == 0) return NULL ;
  801cab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801caf:	75 07                	jne    801cb8 <malloc+0x18>
  801cb1:	b8 00 00 00 00       	mov    $0x0,%eax
  801cb6:	eb 14                	jmp    801ccc <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801cb8:	83 ec 04             	sub    $0x4,%esp
  801cbb:	68 70 2f 80 00       	push   $0x802f70
  801cc0:	6a 43                	push   $0x43
  801cc2:	68 2d 2f 80 00       	push   $0x802f2d
  801cc7:	e8 a6 eb ff ff       	call   800872 <_panic>
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
  801cd1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801cd4:	83 ec 04             	sub    $0x4,%esp
  801cd7:	68 98 2f 80 00       	push   $0x802f98
  801cdc:	6a 4e                	push   $0x4e
  801cde:	68 2d 2f 80 00       	push   $0x802f2d
  801ce3:	e8 8a eb ff ff       	call   800872 <_panic>

00801ce8 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
  801ceb:	83 ec 18             	sub    $0x18,%esp
  801cee:	8b 45 10             	mov    0x10(%ebp),%eax
  801cf1:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801cf4:	e8 34 ff ff ff       	call   801c2d <uheap_init>
	if (size == 0) return NULL ;
  801cf9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cfd:	75 07                	jne    801d06 <smalloc+0x1e>
  801cff:	b8 00 00 00 00       	mov    $0x0,%eax
  801d04:	eb 14                	jmp    801d1a <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801d06:	83 ec 04             	sub    $0x4,%esp
  801d09:	68 bc 2f 80 00       	push   $0x802fbc
  801d0e:	6a 5f                	push   $0x5f
  801d10:	68 2d 2f 80 00       	push   $0x802f2d
  801d15:	e8 58 eb ff ff       	call   800872 <_panic>
}
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
  801d1f:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801d22:	e8 06 ff ff ff       	call   801c2d <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801d27:	83 ec 04             	sub    $0x4,%esp
  801d2a:	68 e4 2f 80 00       	push   $0x802fe4
  801d2f:	6a 6f                	push   $0x6f
  801d31:	68 2d 2f 80 00       	push   $0x802f2d
  801d36:	e8 37 eb ff ff       	call   800872 <_panic>

00801d3b <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
  801d3e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801d41:	83 ec 04             	sub    $0x4,%esp
  801d44:	68 08 30 80 00       	push   $0x803008
  801d49:	6a 7e                	push   $0x7e
  801d4b:	68 2d 2f 80 00       	push   $0x802f2d
  801d50:	e8 1d eb ff ff       	call   800872 <_panic>

00801d55 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
  801d58:	57                   	push   %edi
  801d59:	56                   	push   %esi
  801d5a:	53                   	push   %ebx
  801d5b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d64:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d67:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d6a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d6d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d70:	cd 30                	int    $0x30
  801d72:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d75:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d78:	83 c4 10             	add    $0x10,%esp
  801d7b:	5b                   	pop    %ebx
  801d7c:	5e                   	pop    %esi
  801d7d:	5f                   	pop    %edi
  801d7e:	5d                   	pop    %ebp
  801d7f:	c3                   	ret    

00801d80 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801d80:	55                   	push   %ebp
  801d81:	89 e5                	mov    %esp,%ebp
  801d83:	83 ec 04             	sub    $0x4,%esp
  801d86:	8b 45 10             	mov    0x10(%ebp),%eax
  801d89:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801d8c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d8f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d93:	8b 45 08             	mov    0x8(%ebp),%eax
  801d96:	6a 00                	push   $0x0
  801d98:	51                   	push   %ecx
  801d99:	52                   	push   %edx
  801d9a:	ff 75 0c             	pushl  0xc(%ebp)
  801d9d:	50                   	push   %eax
  801d9e:	6a 00                	push   $0x0
  801da0:	e8 b0 ff ff ff       	call   801d55 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	90                   	nop
  801da9:	c9                   	leave  
  801daa:	c3                   	ret    

00801dab <sys_cgetc>:

int
sys_cgetc(void)
{
  801dab:	55                   	push   %ebp
  801dac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 02                	push   $0x2
  801dba:	e8 96 ff ff ff       	call   801d55 <syscall>
  801dbf:	83 c4 18             	add    $0x18,%esp
}
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 03                	push   $0x3
  801dd3:	e8 7d ff ff ff       	call   801d55 <syscall>
  801dd8:	83 c4 18             	add    $0x18,%esp
}
  801ddb:	90                   	nop
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 04                	push   $0x4
  801ded:	e8 63 ff ff ff       	call   801d55 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	90                   	nop
  801df6:	c9                   	leave  
  801df7:	c3                   	ret    

00801df8 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801df8:	55                   	push   %ebp
  801df9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801dfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	52                   	push   %edx
  801e08:	50                   	push   %eax
  801e09:	6a 08                	push   $0x8
  801e0b:	e8 45 ff ff ff       	call   801d55 <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
  801e18:	56                   	push   %esi
  801e19:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e1a:	8b 75 18             	mov    0x18(%ebp),%esi
  801e1d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e20:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e26:	8b 45 08             	mov    0x8(%ebp),%eax
  801e29:	56                   	push   %esi
  801e2a:	53                   	push   %ebx
  801e2b:	51                   	push   %ecx
  801e2c:	52                   	push   %edx
  801e2d:	50                   	push   %eax
  801e2e:	6a 09                	push   $0x9
  801e30:	e8 20 ff ff ff       	call   801d55 <syscall>
  801e35:	83 c4 18             	add    $0x18,%esp
}
  801e38:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e3b:	5b                   	pop    %ebx
  801e3c:	5e                   	pop    %esi
  801e3d:	5d                   	pop    %ebp
  801e3e:	c3                   	ret    

00801e3f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801e3f:	55                   	push   %ebp
  801e40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	ff 75 08             	pushl  0x8(%ebp)
  801e4d:	6a 0a                	push   $0xa
  801e4f:	e8 01 ff ff ff       	call   801d55 <syscall>
  801e54:	83 c4 18             	add    $0x18,%esp
}
  801e57:	c9                   	leave  
  801e58:	c3                   	ret    

00801e59 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e59:	55                   	push   %ebp
  801e5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	ff 75 0c             	pushl  0xc(%ebp)
  801e65:	ff 75 08             	pushl  0x8(%ebp)
  801e68:	6a 0b                	push   $0xb
  801e6a:	e8 e6 fe ff ff       	call   801d55 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
}
  801e72:	c9                   	leave  
  801e73:	c3                   	ret    

00801e74 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e74:	55                   	push   %ebp
  801e75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 0c                	push   $0xc
  801e83:	e8 cd fe ff ff       	call   801d55 <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 0d                	push   $0xd
  801e9c:	e8 b4 fe ff ff       	call   801d55 <syscall>
  801ea1:	83 c4 18             	add    $0x18,%esp
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 0e                	push   $0xe
  801eb5:	e8 9b fe ff ff       	call   801d55 <syscall>
  801eba:	83 c4 18             	add    $0x18,%esp
}
  801ebd:	c9                   	leave  
  801ebe:	c3                   	ret    

00801ebf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ebf:	55                   	push   %ebp
  801ec0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 0f                	push   $0xf
  801ece:	e8 82 fe ff ff       	call   801d55 <syscall>
  801ed3:	83 c4 18             	add    $0x18,%esp
}
  801ed6:	c9                   	leave  
  801ed7:	c3                   	ret    

00801ed8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ed8:	55                   	push   %ebp
  801ed9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	ff 75 08             	pushl  0x8(%ebp)
  801ee6:	6a 10                	push   $0x10
  801ee8:	e8 68 fe ff ff       	call   801d55 <syscall>
  801eed:	83 c4 18             	add    $0x18,%esp
}
  801ef0:	c9                   	leave  
  801ef1:	c3                   	ret    

00801ef2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 11                	push   $0x11
  801f01:	e8 4f fe ff ff       	call   801d55 <syscall>
  801f06:	83 c4 18             	add    $0x18,%esp
}
  801f09:	90                   	nop
  801f0a:	c9                   	leave  
  801f0b:	c3                   	ret    

00801f0c <sys_cputc>:

void
sys_cputc(const char c)
{
  801f0c:	55                   	push   %ebp
  801f0d:	89 e5                	mov    %esp,%ebp
  801f0f:	83 ec 04             	sub    $0x4,%esp
  801f12:	8b 45 08             	mov    0x8(%ebp),%eax
  801f15:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f18:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	50                   	push   %eax
  801f25:	6a 01                	push   $0x1
  801f27:	e8 29 fe ff ff       	call   801d55 <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	90                   	nop
  801f30:	c9                   	leave  
  801f31:	c3                   	ret    

00801f32 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f32:	55                   	push   %ebp
  801f33:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 14                	push   $0x14
  801f41:	e8 0f fe ff ff       	call   801d55 <syscall>
  801f46:	83 c4 18             	add    $0x18,%esp
}
  801f49:	90                   	nop
  801f4a:	c9                   	leave  
  801f4b:	c3                   	ret    

00801f4c <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801f4c:	55                   	push   %ebp
  801f4d:	89 e5                	mov    %esp,%ebp
  801f4f:	83 ec 04             	sub    $0x4,%esp
  801f52:	8b 45 10             	mov    0x10(%ebp),%eax
  801f55:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801f58:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f5b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f62:	6a 00                	push   $0x0
  801f64:	51                   	push   %ecx
  801f65:	52                   	push   %edx
  801f66:	ff 75 0c             	pushl  0xc(%ebp)
  801f69:	50                   	push   %eax
  801f6a:	6a 15                	push   $0x15
  801f6c:	e8 e4 fd ff ff       	call   801d55 <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
}
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801f79:	8b 55 10             	mov    0x10(%ebp),%edx
  801f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	52                   	push   %edx
  801f84:	50                   	push   %eax
  801f85:	ff 75 08             	pushl  0x8(%ebp)
  801f88:	6a 16                	push   $0x16
  801f8a:	e8 c6 fd ff ff       	call   801d55 <syscall>
  801f8f:	83 c4 18             	add    $0x18,%esp
}
  801f92:	c9                   	leave  
  801f93:	c3                   	ret    

00801f94 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801f94:	55                   	push   %ebp
  801f95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801f97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	52                   	push   %edx
  801fa4:	50                   	push   %eax
  801fa5:	6a 17                	push   $0x17
  801fa7:	e8 a9 fd ff ff       	call   801d55 <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
}
  801faf:	c9                   	leave  
  801fb0:	c3                   	ret    

00801fb1 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801fb1:	55                   	push   %ebp
  801fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	52                   	push   %edx
  801fc1:	50                   	push   %eax
  801fc2:	6a 18                	push   $0x18
  801fc4:	e8 8c fd ff ff       	call   801d55 <syscall>
  801fc9:	83 c4 18             	add    $0x18,%esp
}
  801fcc:	c9                   	leave  
  801fcd:	c3                   	ret    

00801fce <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fce:	55                   	push   %ebp
  801fcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd4:	6a 00                	push   $0x0
  801fd6:	ff 75 14             	pushl  0x14(%ebp)
  801fd9:	ff 75 10             	pushl  0x10(%ebp)
  801fdc:	ff 75 0c             	pushl  0xc(%ebp)
  801fdf:	50                   	push   %eax
  801fe0:	6a 19                	push   $0x19
  801fe2:	e8 6e fd ff ff       	call   801d55 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_run_env>:

void sys_run_env(int32 envId)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fef:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	50                   	push   %eax
  801ffb:	6a 1a                	push   $0x1a
  801ffd:	e8 53 fd ff ff       	call   801d55 <syscall>
  802002:	83 c4 18             	add    $0x18,%esp
}
  802005:	90                   	nop
  802006:	c9                   	leave  
  802007:	c3                   	ret    

00802008 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  802008:	55                   	push   %ebp
  802009:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80200b:	8b 45 08             	mov    0x8(%ebp),%eax
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	50                   	push   %eax
  802017:	6a 1b                	push   $0x1b
  802019:	e8 37 fd ff ff       	call   801d55 <syscall>
  80201e:	83 c4 18             	add    $0x18,%esp
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 05                	push   $0x5
  802032:	e8 1e fd ff ff       	call   801d55 <syscall>
  802037:	83 c4 18             	add    $0x18,%esp
}
  80203a:	c9                   	leave  
  80203b:	c3                   	ret    

0080203c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80203c:	55                   	push   %ebp
  80203d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 06                	push   $0x6
  80204b:	e8 05 fd ff ff       	call   801d55 <syscall>
  802050:	83 c4 18             	add    $0x18,%esp
}
  802053:	c9                   	leave  
  802054:	c3                   	ret    

00802055 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802055:	55                   	push   %ebp
  802056:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 07                	push   $0x7
  802064:	e8 ec fc ff ff       	call   801d55 <syscall>
  802069:	83 c4 18             	add    $0x18,%esp
}
  80206c:	c9                   	leave  
  80206d:	c3                   	ret    

0080206e <sys_exit_env>:


void sys_exit_env(void)
{
  80206e:	55                   	push   %ebp
  80206f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 1c                	push   $0x1c
  80207d:	e8 d3 fc ff ff       	call   801d55 <syscall>
  802082:	83 c4 18             	add    $0x18,%esp
}
  802085:	90                   	nop
  802086:	c9                   	leave  
  802087:	c3                   	ret    

00802088 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802088:	55                   	push   %ebp
  802089:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	ff 75 10             	pushl  0x10(%ebp)
  802092:	ff 75 0c             	pushl  0xc(%ebp)
  802095:	ff 75 08             	pushl  0x8(%ebp)
  802098:	6a 13                	push   $0x13
  80209a:	e8 b6 fc ff ff       	call   801d55 <syscall>
  80209f:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a2:	90                   	nop
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 1e                	push   $0x1e
  8020b4:	e8 9c fc ff ff       	call   801d55 <syscall>
  8020b9:	83 c4 18             	add    $0x18,%esp
}
  8020bc:	c9                   	leave  
  8020bd:	c3                   	ret    

008020be <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8020be:	55                   	push   %ebp
  8020bf:	89 e5                	mov    %esp,%ebp
  8020c1:	83 ec 04             	sub    $0x4,%esp
  8020c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020ca:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	50                   	push   %eax
  8020d7:	6a 1f                	push   $0x1f
  8020d9:	e8 77 fc ff ff       	call   801d55 <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e1:	90                   	nop
}
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <rsttst>:
void rsttst()
{
  8020e4:	55                   	push   %ebp
  8020e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 21                	push   $0x21
  8020f3:	e8 5d fc ff ff       	call   801d55 <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020fb:	90                   	nop
}
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
  802101:	83 ec 04             	sub    $0x4,%esp
  802104:	8b 45 14             	mov    0x14(%ebp),%eax
  802107:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80210a:	8b 55 18             	mov    0x18(%ebp),%edx
  80210d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802111:	52                   	push   %edx
  802112:	50                   	push   %eax
  802113:	ff 75 10             	pushl  0x10(%ebp)
  802116:	ff 75 0c             	pushl  0xc(%ebp)
  802119:	ff 75 08             	pushl  0x8(%ebp)
  80211c:	6a 20                	push   $0x20
  80211e:	e8 32 fc ff ff       	call   801d55 <syscall>
  802123:	83 c4 18             	add    $0x18,%esp
	return ;
  802126:	90                   	nop
}
  802127:	c9                   	leave  
  802128:	c3                   	ret    

00802129 <chktst>:
void chktst(uint32 n)
{
  802129:	55                   	push   %ebp
  80212a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	ff 75 08             	pushl  0x8(%ebp)
  802137:	6a 22                	push   $0x22
  802139:	e8 17 fc ff ff       	call   801d55 <syscall>
  80213e:	83 c4 18             	add    $0x18,%esp
	return ;
  802141:	90                   	nop
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <inctst>:

void inctst()
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 23                	push   $0x23
  802153:	e8 fd fb ff ff       	call   801d55 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
	return ;
  80215b:	90                   	nop
}
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <gettst>:
uint32 gettst()
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 24                	push   $0x24
  80216d:	e8 e3 fb ff ff       	call   801d55 <syscall>
  802172:	83 c4 18             	add    $0x18,%esp
}
  802175:	c9                   	leave  
  802176:	c3                   	ret    

00802177 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802177:	55                   	push   %ebp
  802178:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 25                	push   $0x25
  802186:	e8 ca fb ff ff       	call   801d55 <syscall>
  80218b:	83 c4 18             	add    $0x18,%esp
  80218e:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  802193:	a1 48 40 80 00       	mov    0x804048,%eax
}
  802198:	c9                   	leave  
  802199:	c3                   	ret    

0080219a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80219a:	55                   	push   %ebp
  80219b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80219d:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a0:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	ff 75 08             	pushl  0x8(%ebp)
  8021b0:	6a 26                	push   $0x26
  8021b2:	e8 9e fb ff ff       	call   801d55 <syscall>
  8021b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ba:	90                   	nop
}
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
  8021c0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021c1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8021cd:	6a 00                	push   $0x0
  8021cf:	53                   	push   %ebx
  8021d0:	51                   	push   %ecx
  8021d1:	52                   	push   %edx
  8021d2:	50                   	push   %eax
  8021d3:	6a 27                	push   $0x27
  8021d5:	e8 7b fb ff ff       	call   801d55 <syscall>
  8021da:	83 c4 18             	add    $0x18,%esp
}
  8021dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021e0:	c9                   	leave  
  8021e1:	c3                   	ret    

008021e2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021e2:	55                   	push   %ebp
  8021e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	52                   	push   %edx
  8021f2:	50                   	push   %eax
  8021f3:	6a 28                	push   $0x28
  8021f5:	e8 5b fb ff ff       	call   801d55 <syscall>
  8021fa:	83 c4 18             	add    $0x18,%esp
}
  8021fd:	c9                   	leave  
  8021fe:	c3                   	ret    

008021ff <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8021ff:	55                   	push   %ebp
  802200:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  802202:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802205:	8b 55 0c             	mov    0xc(%ebp),%edx
  802208:	8b 45 08             	mov    0x8(%ebp),%eax
  80220b:	6a 00                	push   $0x0
  80220d:	51                   	push   %ecx
  80220e:	ff 75 10             	pushl  0x10(%ebp)
  802211:	52                   	push   %edx
  802212:	50                   	push   %eax
  802213:	6a 29                	push   $0x29
  802215:	e8 3b fb ff ff       	call   801d55 <syscall>
  80221a:	83 c4 18             	add    $0x18,%esp
}
  80221d:	c9                   	leave  
  80221e:	c3                   	ret    

0080221f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80221f:	55                   	push   %ebp
  802220:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	ff 75 10             	pushl  0x10(%ebp)
  802229:	ff 75 0c             	pushl  0xc(%ebp)
  80222c:	ff 75 08             	pushl  0x8(%ebp)
  80222f:	6a 12                	push   $0x12
  802231:	e8 1f fb ff ff       	call   801d55 <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
	return ;
  802239:	90                   	nop
}
  80223a:	c9                   	leave  
  80223b:	c3                   	ret    

0080223c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80223c:	55                   	push   %ebp
  80223d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80223f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802242:	8b 45 08             	mov    0x8(%ebp),%eax
  802245:	6a 00                	push   $0x0
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	52                   	push   %edx
  80224c:	50                   	push   %eax
  80224d:	6a 2a                	push   $0x2a
  80224f:	e8 01 fb ff ff       	call   801d55 <syscall>
  802254:	83 c4 18             	add    $0x18,%esp
	return;
  802257:	90                   	nop
}
  802258:	c9                   	leave  
  802259:	c3                   	ret    

0080225a <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80225a:	55                   	push   %ebp
  80225b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 2b                	push   $0x2b
  802269:	e8 e7 fa ff ff       	call   801d55 <syscall>
  80226e:	83 c4 18             	add    $0x18,%esp
}
  802271:	c9                   	leave  
  802272:	c3                   	ret    

00802273 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802273:	55                   	push   %ebp
  802274:	89 e5                	mov    %esp,%ebp
  802276:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802279:	83 ec 04             	sub    $0x4,%esp
  80227c:	68 2c 30 80 00       	push   $0x80302c
  802281:	68 0a 01 00 00       	push   $0x10a
  802286:	68 3c 30 80 00       	push   $0x80303c
  80228b:	e8 e2 e5 ff ff       	call   800872 <_panic>

00802290 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  802290:	55                   	push   %ebp
  802291:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	ff 75 0c             	pushl  0xc(%ebp)
  80229c:	ff 75 08             	pushl  0x8(%ebp)
  80229f:	6a 33                	push   $0x33
  8022a1:	e8 af fa ff ff       	call   801d55 <syscall>
  8022a6:	83 c4 18             	add    $0x18,%esp
	return;
  8022a9:	90                   	nop
}
  8022aa:	c9                   	leave  
  8022ab:	c3                   	ret    

008022ac <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8022ac:	55                   	push   %ebp
  8022ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	ff 75 0c             	pushl  0xc(%ebp)
  8022b8:	ff 75 08             	pushl  0x8(%ebp)
  8022bb:	6a 34                	push   $0x34
  8022bd:	e8 93 fa ff ff       	call   801d55 <syscall>
  8022c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c5:	90                   	nop
}
  8022c6:	c9                   	leave  
  8022c7:	c3                   	ret    

008022c8 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8022c8:	55                   	push   %ebp
  8022c9:	89 e5                	mov    %esp,%ebp
  8022cb:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8022ce:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8022d5:	eb 36                	jmp    80230d <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8022d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022da:	c1 e0 04             	shl    $0x4,%eax
  8022dd:	05 60 40 80 00       	add    $0x804060,%eax
  8022e2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8022e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022eb:	c1 e0 04             	shl    $0x4,%eax
  8022ee:	05 64 40 80 00       	add    $0x804064,%eax
  8022f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8022f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022fc:	c1 e0 04             	shl    $0x4,%eax
  8022ff:	05 6c 40 80 00       	add    $0x80406c,%eax
  802304:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80230a:	ff 45 fc             	incl   -0x4(%ebp)
  80230d:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802311:	7e c4                	jle    8022d7 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802313:	90                   	nop
  802314:	c9                   	leave  
  802315:	c3                   	ret    

00802316 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802316:	55                   	push   %ebp
  802317:	89 e5                	mov    %esp,%ebp
  802319:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80231c:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802323:	eb 24                	jmp    802349 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802325:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802328:	c1 e0 04             	shl    $0x4,%eax
  80232b:	05 6c 40 80 00       	add    $0x80406c,%eax
  802330:	8b 00                	mov    (%eax),%eax
  802332:	83 ec 04             	sub    $0x4,%esp
  802335:	50                   	push   %eax
  802336:	ff 75 f4             	pushl  -0xc(%ebp)
  802339:	68 4c 30 80 00       	push   $0x80304c
  80233e:	e8 fd e7 ff ff       	call   800b40 <cprintf>
  802343:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802346:	ff 45 f4             	incl   -0xc(%ebp)
  802349:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80234d:	7e d6                	jle    802325 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  80234f:	90                   	nop
  802350:	c9                   	leave  
  802351:	c3                   	ret    

00802352 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802352:	55                   	push   %ebp
  802353:	89 e5                	mov    %esp,%ebp
  802355:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802358:	83 ec 04             	sub    $0x4,%esp
  80235b:	68 5c 30 80 00       	push   $0x80305c
  802360:	6a 33                	push   $0x33
  802362:	68 7d 30 80 00       	push   $0x80307d
  802367:	e8 06 e5 ff ff       	call   800872 <_panic>

0080236c <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80236c:	55                   	push   %ebp
  80236d:	89 e5                	mov    %esp,%ebp
  80236f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802372:	83 ec 04             	sub    $0x4,%esp
  802375:	68 95 30 80 00       	push   $0x803095
  80237a:	6a 3e                	push   $0x3e
  80237c:	68 7d 30 80 00       	push   $0x80307d
  802381:	e8 ec e4 ff ff       	call   800872 <_panic>

00802386 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802386:	55                   	push   %ebp
  802387:	89 e5                	mov    %esp,%ebp
  802389:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  80238c:	83 ec 04             	sub    $0x4,%esp
  80238f:	68 b3 30 80 00       	push   $0x8030b3
  802394:	6a 49                	push   $0x49
  802396:	68 7d 30 80 00       	push   $0x80307d
  80239b:	e8 d2 e4 ff ff       	call   800872 <_panic>

008023a0 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8023a0:	55                   	push   %ebp
  8023a1:	89 e5                	mov    %esp,%ebp
  8023a3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8023a6:	83 ec 04             	sub    $0x4,%esp
  8023a9:	68 d0 30 80 00       	push   $0x8030d0
  8023ae:	6a 58                	push   $0x58
  8023b0:	68 7d 30 80 00       	push   $0x80307d
  8023b5:	e8 b8 e4 ff ff       	call   800872 <_panic>
  8023ba:	66 90                	xchg   %ax,%ax

008023bc <__udivdi3>:
  8023bc:	55                   	push   %ebp
  8023bd:	57                   	push   %edi
  8023be:	56                   	push   %esi
  8023bf:	53                   	push   %ebx
  8023c0:	83 ec 1c             	sub    $0x1c,%esp
  8023c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023d3:	89 ca                	mov    %ecx,%edx
  8023d5:	89 f8                	mov    %edi,%eax
  8023d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023db:	85 f6                	test   %esi,%esi
  8023dd:	75 2d                	jne    80240c <__udivdi3+0x50>
  8023df:	39 cf                	cmp    %ecx,%edi
  8023e1:	77 65                	ja     802448 <__udivdi3+0x8c>
  8023e3:	89 fd                	mov    %edi,%ebp
  8023e5:	85 ff                	test   %edi,%edi
  8023e7:	75 0b                	jne    8023f4 <__udivdi3+0x38>
  8023e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ee:	31 d2                	xor    %edx,%edx
  8023f0:	f7 f7                	div    %edi
  8023f2:	89 c5                	mov    %eax,%ebp
  8023f4:	31 d2                	xor    %edx,%edx
  8023f6:	89 c8                	mov    %ecx,%eax
  8023f8:	f7 f5                	div    %ebp
  8023fa:	89 c1                	mov    %eax,%ecx
  8023fc:	89 d8                	mov    %ebx,%eax
  8023fe:	f7 f5                	div    %ebp
  802400:	89 cf                	mov    %ecx,%edi
  802402:	89 fa                	mov    %edi,%edx
  802404:	83 c4 1c             	add    $0x1c,%esp
  802407:	5b                   	pop    %ebx
  802408:	5e                   	pop    %esi
  802409:	5f                   	pop    %edi
  80240a:	5d                   	pop    %ebp
  80240b:	c3                   	ret    
  80240c:	39 ce                	cmp    %ecx,%esi
  80240e:	77 28                	ja     802438 <__udivdi3+0x7c>
  802410:	0f bd fe             	bsr    %esi,%edi
  802413:	83 f7 1f             	xor    $0x1f,%edi
  802416:	75 40                	jne    802458 <__udivdi3+0x9c>
  802418:	39 ce                	cmp    %ecx,%esi
  80241a:	72 0a                	jb     802426 <__udivdi3+0x6a>
  80241c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802420:	0f 87 9e 00 00 00    	ja     8024c4 <__udivdi3+0x108>
  802426:	b8 01 00 00 00       	mov    $0x1,%eax
  80242b:	89 fa                	mov    %edi,%edx
  80242d:	83 c4 1c             	add    $0x1c,%esp
  802430:	5b                   	pop    %ebx
  802431:	5e                   	pop    %esi
  802432:	5f                   	pop    %edi
  802433:	5d                   	pop    %ebp
  802434:	c3                   	ret    
  802435:	8d 76 00             	lea    0x0(%esi),%esi
  802438:	31 ff                	xor    %edi,%edi
  80243a:	31 c0                	xor    %eax,%eax
  80243c:	89 fa                	mov    %edi,%edx
  80243e:	83 c4 1c             	add    $0x1c,%esp
  802441:	5b                   	pop    %ebx
  802442:	5e                   	pop    %esi
  802443:	5f                   	pop    %edi
  802444:	5d                   	pop    %ebp
  802445:	c3                   	ret    
  802446:	66 90                	xchg   %ax,%ax
  802448:	89 d8                	mov    %ebx,%eax
  80244a:	f7 f7                	div    %edi
  80244c:	31 ff                	xor    %edi,%edi
  80244e:	89 fa                	mov    %edi,%edx
  802450:	83 c4 1c             	add    $0x1c,%esp
  802453:	5b                   	pop    %ebx
  802454:	5e                   	pop    %esi
  802455:	5f                   	pop    %edi
  802456:	5d                   	pop    %ebp
  802457:	c3                   	ret    
  802458:	bd 20 00 00 00       	mov    $0x20,%ebp
  80245d:	89 eb                	mov    %ebp,%ebx
  80245f:	29 fb                	sub    %edi,%ebx
  802461:	89 f9                	mov    %edi,%ecx
  802463:	d3 e6                	shl    %cl,%esi
  802465:	89 c5                	mov    %eax,%ebp
  802467:	88 d9                	mov    %bl,%cl
  802469:	d3 ed                	shr    %cl,%ebp
  80246b:	89 e9                	mov    %ebp,%ecx
  80246d:	09 f1                	or     %esi,%ecx
  80246f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802473:	89 f9                	mov    %edi,%ecx
  802475:	d3 e0                	shl    %cl,%eax
  802477:	89 c5                	mov    %eax,%ebp
  802479:	89 d6                	mov    %edx,%esi
  80247b:	88 d9                	mov    %bl,%cl
  80247d:	d3 ee                	shr    %cl,%esi
  80247f:	89 f9                	mov    %edi,%ecx
  802481:	d3 e2                	shl    %cl,%edx
  802483:	8b 44 24 08          	mov    0x8(%esp),%eax
  802487:	88 d9                	mov    %bl,%cl
  802489:	d3 e8                	shr    %cl,%eax
  80248b:	09 c2                	or     %eax,%edx
  80248d:	89 d0                	mov    %edx,%eax
  80248f:	89 f2                	mov    %esi,%edx
  802491:	f7 74 24 0c          	divl   0xc(%esp)
  802495:	89 d6                	mov    %edx,%esi
  802497:	89 c3                	mov    %eax,%ebx
  802499:	f7 e5                	mul    %ebp
  80249b:	39 d6                	cmp    %edx,%esi
  80249d:	72 19                	jb     8024b8 <__udivdi3+0xfc>
  80249f:	74 0b                	je     8024ac <__udivdi3+0xf0>
  8024a1:	89 d8                	mov    %ebx,%eax
  8024a3:	31 ff                	xor    %edi,%edi
  8024a5:	e9 58 ff ff ff       	jmp    802402 <__udivdi3+0x46>
  8024aa:	66 90                	xchg   %ax,%ax
  8024ac:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024b0:	89 f9                	mov    %edi,%ecx
  8024b2:	d3 e2                	shl    %cl,%edx
  8024b4:	39 c2                	cmp    %eax,%edx
  8024b6:	73 e9                	jae    8024a1 <__udivdi3+0xe5>
  8024b8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024bb:	31 ff                	xor    %edi,%edi
  8024bd:	e9 40 ff ff ff       	jmp    802402 <__udivdi3+0x46>
  8024c2:	66 90                	xchg   %ax,%ax
  8024c4:	31 c0                	xor    %eax,%eax
  8024c6:	e9 37 ff ff ff       	jmp    802402 <__udivdi3+0x46>
  8024cb:	90                   	nop

008024cc <__umoddi3>:
  8024cc:	55                   	push   %ebp
  8024cd:	57                   	push   %edi
  8024ce:	56                   	push   %esi
  8024cf:	53                   	push   %ebx
  8024d0:	83 ec 1c             	sub    $0x1c,%esp
  8024d3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024d7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024df:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024eb:	89 f3                	mov    %esi,%ebx
  8024ed:	89 fa                	mov    %edi,%edx
  8024ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024f3:	89 34 24             	mov    %esi,(%esp)
  8024f6:	85 c0                	test   %eax,%eax
  8024f8:	75 1a                	jne    802514 <__umoddi3+0x48>
  8024fa:	39 f7                	cmp    %esi,%edi
  8024fc:	0f 86 a2 00 00 00    	jbe    8025a4 <__umoddi3+0xd8>
  802502:	89 c8                	mov    %ecx,%eax
  802504:	89 f2                	mov    %esi,%edx
  802506:	f7 f7                	div    %edi
  802508:	89 d0                	mov    %edx,%eax
  80250a:	31 d2                	xor    %edx,%edx
  80250c:	83 c4 1c             	add    $0x1c,%esp
  80250f:	5b                   	pop    %ebx
  802510:	5e                   	pop    %esi
  802511:	5f                   	pop    %edi
  802512:	5d                   	pop    %ebp
  802513:	c3                   	ret    
  802514:	39 f0                	cmp    %esi,%eax
  802516:	0f 87 ac 00 00 00    	ja     8025c8 <__umoddi3+0xfc>
  80251c:	0f bd e8             	bsr    %eax,%ebp
  80251f:	83 f5 1f             	xor    $0x1f,%ebp
  802522:	0f 84 ac 00 00 00    	je     8025d4 <__umoddi3+0x108>
  802528:	bf 20 00 00 00       	mov    $0x20,%edi
  80252d:	29 ef                	sub    %ebp,%edi
  80252f:	89 fe                	mov    %edi,%esi
  802531:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802535:	89 e9                	mov    %ebp,%ecx
  802537:	d3 e0                	shl    %cl,%eax
  802539:	89 d7                	mov    %edx,%edi
  80253b:	89 f1                	mov    %esi,%ecx
  80253d:	d3 ef                	shr    %cl,%edi
  80253f:	09 c7                	or     %eax,%edi
  802541:	89 e9                	mov    %ebp,%ecx
  802543:	d3 e2                	shl    %cl,%edx
  802545:	89 14 24             	mov    %edx,(%esp)
  802548:	89 d8                	mov    %ebx,%eax
  80254a:	d3 e0                	shl    %cl,%eax
  80254c:	89 c2                	mov    %eax,%edx
  80254e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802552:	d3 e0                	shl    %cl,%eax
  802554:	89 44 24 04          	mov    %eax,0x4(%esp)
  802558:	8b 44 24 08          	mov    0x8(%esp),%eax
  80255c:	89 f1                	mov    %esi,%ecx
  80255e:	d3 e8                	shr    %cl,%eax
  802560:	09 d0                	or     %edx,%eax
  802562:	d3 eb                	shr    %cl,%ebx
  802564:	89 da                	mov    %ebx,%edx
  802566:	f7 f7                	div    %edi
  802568:	89 d3                	mov    %edx,%ebx
  80256a:	f7 24 24             	mull   (%esp)
  80256d:	89 c6                	mov    %eax,%esi
  80256f:	89 d1                	mov    %edx,%ecx
  802571:	39 d3                	cmp    %edx,%ebx
  802573:	0f 82 87 00 00 00    	jb     802600 <__umoddi3+0x134>
  802579:	0f 84 91 00 00 00    	je     802610 <__umoddi3+0x144>
  80257f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802583:	29 f2                	sub    %esi,%edx
  802585:	19 cb                	sbb    %ecx,%ebx
  802587:	89 d8                	mov    %ebx,%eax
  802589:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80258d:	d3 e0                	shl    %cl,%eax
  80258f:	89 e9                	mov    %ebp,%ecx
  802591:	d3 ea                	shr    %cl,%edx
  802593:	09 d0                	or     %edx,%eax
  802595:	89 e9                	mov    %ebp,%ecx
  802597:	d3 eb                	shr    %cl,%ebx
  802599:	89 da                	mov    %ebx,%edx
  80259b:	83 c4 1c             	add    $0x1c,%esp
  80259e:	5b                   	pop    %ebx
  80259f:	5e                   	pop    %esi
  8025a0:	5f                   	pop    %edi
  8025a1:	5d                   	pop    %ebp
  8025a2:	c3                   	ret    
  8025a3:	90                   	nop
  8025a4:	89 fd                	mov    %edi,%ebp
  8025a6:	85 ff                	test   %edi,%edi
  8025a8:	75 0b                	jne    8025b5 <__umoddi3+0xe9>
  8025aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8025af:	31 d2                	xor    %edx,%edx
  8025b1:	f7 f7                	div    %edi
  8025b3:	89 c5                	mov    %eax,%ebp
  8025b5:	89 f0                	mov    %esi,%eax
  8025b7:	31 d2                	xor    %edx,%edx
  8025b9:	f7 f5                	div    %ebp
  8025bb:	89 c8                	mov    %ecx,%eax
  8025bd:	f7 f5                	div    %ebp
  8025bf:	89 d0                	mov    %edx,%eax
  8025c1:	e9 44 ff ff ff       	jmp    80250a <__umoddi3+0x3e>
  8025c6:	66 90                	xchg   %ax,%ax
  8025c8:	89 c8                	mov    %ecx,%eax
  8025ca:	89 f2                	mov    %esi,%edx
  8025cc:	83 c4 1c             	add    $0x1c,%esp
  8025cf:	5b                   	pop    %ebx
  8025d0:	5e                   	pop    %esi
  8025d1:	5f                   	pop    %edi
  8025d2:	5d                   	pop    %ebp
  8025d3:	c3                   	ret    
  8025d4:	3b 04 24             	cmp    (%esp),%eax
  8025d7:	72 06                	jb     8025df <__umoddi3+0x113>
  8025d9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025dd:	77 0f                	ja     8025ee <__umoddi3+0x122>
  8025df:	89 f2                	mov    %esi,%edx
  8025e1:	29 f9                	sub    %edi,%ecx
  8025e3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025e7:	89 14 24             	mov    %edx,(%esp)
  8025ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ee:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025f2:	8b 14 24             	mov    (%esp),%edx
  8025f5:	83 c4 1c             	add    $0x1c,%esp
  8025f8:	5b                   	pop    %ebx
  8025f9:	5e                   	pop    %esi
  8025fa:	5f                   	pop    %edi
  8025fb:	5d                   	pop    %ebp
  8025fc:	c3                   	ret    
  8025fd:	8d 76 00             	lea    0x0(%esi),%esi
  802600:	2b 04 24             	sub    (%esp),%eax
  802603:	19 fa                	sbb    %edi,%edx
  802605:	89 d1                	mov    %edx,%ecx
  802607:	89 c6                	mov    %eax,%esi
  802609:	e9 71 ff ff ff       	jmp    80257f <__umoddi3+0xb3>
  80260e:	66 90                	xchg   %ax,%ax
  802610:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802614:	72 ea                	jb     802600 <__umoddi3+0x134>
  802616:	89 d9                	mov    %ebx,%ecx
  802618:	e9 62 ff ff ff       	jmp    80257f <__umoddi3+0xb3>
