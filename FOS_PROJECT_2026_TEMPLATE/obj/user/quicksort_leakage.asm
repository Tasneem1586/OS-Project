
obj/user/quicksort_leakage:     file format elf32-i386


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
  800031:	e8 ce 05 00 00       	call   800604 <libmain>
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
  800041:	e8 70 1d 00 00       	call   801db6 <sys_lock_cons>
		{
			cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 26 80 00       	push   $0x802620
  80004e:	e8 df 0a 00 00       	call   800b32 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 26 80 00       	push   $0x802622
  80005e:	e8 cf 0a 00 00       	call   800b32 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 3b 26 80 00       	push   $0x80263b
  80006e:	e8 bf 0a 00 00       	call   800b32 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 26 80 00       	push   $0x802622
  80007e:	e8 af 0a 00 00       	call   800b32 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 26 80 00       	push   $0x802620
  80008e:	e8 9f 0a 00 00       	call   800b32 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

			readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 54 26 80 00       	push   $0x802654
  8000a5:	e8 61 11 00 00       	call   80120b <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
			NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 62 17 00 00       	call   801822 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
			cprintf("Chose the initialization method:\n") ;
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	68 74 26 80 00       	push   $0x802674
  8000ce:	e8 5f 0a 00 00       	call   800b32 <cprintf>
  8000d3:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 96 26 80 00       	push   $0x802696
  8000de:	e8 4f 0a 00 00       	call   800b32 <cprintf>
  8000e3:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000e6:	83 ec 0c             	sub    $0xc,%esp
  8000e9:	68 a4 26 80 00       	push   $0x8026a4
  8000ee:	e8 3f 0a 00 00       	call   800b32 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000f6:	83 ec 0c             	sub    $0xc,%esp
  8000f9:	68 b3 26 80 00       	push   $0x8026b3
  8000fe:	e8 2f 0a 00 00       	call   800b32 <cprintf>
  800103:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  800106:	83 ec 0c             	sub    $0xc,%esp
  800109:	68 c3 26 80 00       	push   $0x8026c3
  80010e:	e8 1f 0a 00 00       	call   800b32 <cprintf>
  800113:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800116:	e8 c6 04 00 00       	call   8005e1 <getchar>
  80011b:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80011e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800122:	83 ec 0c             	sub    $0xc,%esp
  800125:	50                   	push   %eax
  800126:	e8 97 04 00 00       	call   8005c2 <cputchar>
  80012b:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80012e:	83 ec 0c             	sub    $0xc,%esp
  800131:	6a 0a                	push   $0xa
  800133:	e8 8a 04 00 00       	call   8005c2 <cputchar>
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
  80014d:	e8 7e 1c 00 00       	call   801dd0 <sys_unlock_cons>

		Elements = malloc(sizeof(int) * NumOfElements) ;
  800152:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800155:	c1 e0 02             	shl    $0x2,%eax
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	50                   	push   %eax
  80015c:	e8 31 1b 00 00       	call   801c92 <malloc>
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
  800183:	e8 f5 02 00 00       	call   80047d <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 13 03 00 00       	call   8004ae <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 35 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 22 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 f0 00 00 00       	call   8002c2 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001d5:	e8 dc 1b 00 00       	call   801db6 <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 cc 26 80 00       	push   $0x8026cc
  8001e2:	e8 4b 09 00 00       	call   800b32 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
			//		PrintElements(Elements, NumOfElements);
		}
		sys_unlock_cons();
  8001ea:	e8 e1 1b 00 00       	call   801dd0 <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 d6 01 00 00       	call   8003d3 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 00 27 80 00       	push   $0x802700
  800211:	6a 51                	push   $0x51
  800213:	68 22 27 80 00       	push   $0x802722
  800218:	e8 47 06 00 00       	call   800864 <_panic>
		else
		{
			sys_lock_cons();
  80021d:	e8 94 1b 00 00       	call   801db6 <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 3c 27 80 00       	push   $0x80273c
  80022a:	e8 03 09 00 00       	call   800b32 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 70 27 80 00       	push   $0x802770
  80023a:	e8 f3 08 00 00       	call   800b32 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 a4 27 80 00       	push   $0x8027a4
  80024a:	e8 e3 08 00 00       	call   800b32 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  800252:	e8 79 1b 00 00       	call   801dd0 <sys_unlock_cons>
		}

		sys_lock_cons();
  800257:	e8 5a 1b 00 00       	call   801db6 <sys_lock_cons>
		{
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 d6 27 80 00       	push   $0x8027d6
  80026a:	e8 c3 08 00 00       	call   800b32 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800272:	e8 6a 03 00 00       	call   8005e1 <getchar>
  800277:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80027e:	83 ec 0c             	sub    $0xc,%esp
  800281:	50                   	push   %eax
  800282:	e8 3b 03 00 00       	call   8005c2 <cputchar>
  800287:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	6a 0a                	push   $0xa
  80028f:	e8 2e 03 00 00       	call   8005c2 <cputchar>
  800294:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	6a 0a                	push   $0xa
  80029c:	e8 21 03 00 00       	call   8005c2 <cputchar>
  8002a1:	83 c4 10             	add    $0x10,%esp
		}

		sys_lock_cons();
		{
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a8:	74 06                	je     8002b0 <_main+0x278>
  8002aa:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002ae:	75 b2                	jne    800262 <_main+0x22a>
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		}
		sys_unlock_cons();
  8002b0:	e8 1b 1b 00 00       	call   801dd0 <sys_unlock_cons>

	} while (Chose == 'y');
  8002b5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b9:	0f 84 82 fd ff ff    	je     800041 <_main+0x9>

}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cb:	48                   	dec    %eax
  8002cc:	50                   	push   %eax
  8002cd:	6a 00                	push   $0x0
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	e8 06 00 00 00       	call   8002e0 <QSort>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ec:	0f 8d de 00 00 00    	jge    8003d0 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	40                   	inc    %eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ff:	e9 80 00 00 00       	jmp    800384 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800304:	ff 45 f4             	incl   -0xc(%ebp)
  800307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80030d:	7f 2b                	jg     80033a <QSort+0x5a>
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800323:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	39 c2                	cmp    %eax,%edx
  800333:	7d cf                	jge    800304 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800335:	eb 03                	jmp    80033a <QSort+0x5a>
  800337:	ff 4d f0             	decl   -0x10(%ebp)
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800340:	7e 26                	jle    800368 <QSort+0x88>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7e cf                	jle    800337 <QSort+0x57>

		if (i <= j)
  800368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036e:	7f 14                	jg     800384 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	ff 75 08             	pushl  0x8(%ebp)
  80037c:	e8 a9 00 00 00       	call   80042a <Swap>
  800381:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80038a:	0f 8e 77 ff ff ff    	jle    800307 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	ff 75 f0             	pushl  -0x10(%ebp)
  800396:	ff 75 10             	pushl  0x10(%ebp)
  800399:	ff 75 08             	pushl  0x8(%ebp)
  80039c:	e8 89 00 00 00       	call   80042a <Swap>
  8003a1:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	48                   	dec    %eax
  8003a8:	50                   	push   %eax
  8003a9:	ff 75 10             	pushl  0x10(%ebp)
  8003ac:	ff 75 0c             	pushl  0xc(%ebp)
  8003af:	ff 75 08             	pushl  0x8(%ebp)
  8003b2:	e8 29 ff ff ff       	call   8002e0 <QSort>
  8003b7:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ba:	ff 75 14             	pushl  0x14(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 08             	pushl  0x8(%ebp)
  8003c6:	e8 15 ff ff ff       	call   8002e0 <QSort>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	eb 01                	jmp    8003d1 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003d0:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003e7:	eb 33                	jmp    80041c <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	8b 10                	mov    (%eax),%edx
  8003fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fd:	40                   	inc    %eax
  8003fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c8                	add    %ecx,%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	7e 09                	jle    800419 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800417:	eb 0c                	jmp    800425 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800419:	ff 45 f8             	incl   -0x8(%ebp)
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	48                   	dec    %eax
  800420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800423:	7f c4                	jg     8003e9 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800425:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800444:	8b 45 0c             	mov    0xc(%ebp),%eax
  800447:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 10             	mov    0x10(%ebp),%eax
  800456:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800466:	8b 45 10             	mov    0x10(%ebp),%eax
  800469:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	01 c2                	add    %eax,%edx
  800475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800478:	89 02                	mov    %eax,(%edx)
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80048a:	eb 17                	jmp    8004a3 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80048c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	01 c2                	add    %eax,%edx
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c e1                	jl     80048c <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bb:	eb 1b                	jmp    8004d8 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	01 c2                	add    %eax,%edx
  8004cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cf:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004d2:	48                   	dec    %eax
  8004d3:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d5:	ff 45 fc             	incl   -0x4(%ebp)
  8004d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004de:	7c dd                	jl     8004bd <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004ec:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004f1:	f7 e9                	imul   %ecx
  8004f3:	c1 f9 1f             	sar    $0x1f,%ecx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	29 c8                	sub    %ecx,%eax
  8004fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8004fd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800501:	75 07                	jne    80050a <InitializeSemiRandom+0x27>
			Repetition = 3;
  800503:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  80050a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800511:	eb 1e                	jmp    800531 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  800513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800516:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800523:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800526:	99                   	cltd   
  800527:	f7 7d f8             	idivl  -0x8(%ebp)
  80052a:	89 d0                	mov    %edx,%eax
  80052c:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  80052e:	ff 45 fc             	incl   -0x4(%ebp)
  800531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800534:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800537:	7c da                	jl     800513 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800539:	90                   	nop
  80053a:	c9                   	leave  
  80053b:	c3                   	ret    

0080053c <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80053c:	55                   	push   %ebp
  80053d:	89 e5                	mov    %esp,%ebp
  80053f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800542:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800549:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800550:	eb 42                	jmp    800594 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800552:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800555:	99                   	cltd   
  800556:	f7 7d f0             	idivl  -0x10(%ebp)
  800559:	89 d0                	mov    %edx,%eax
  80055b:	85 c0                	test   %eax,%eax
  80055d:	75 10                	jne    80056f <PrintElements+0x33>
			cprintf("\n");
  80055f:	83 ec 0c             	sub    $0xc,%esp
  800562:	68 20 26 80 00       	push   $0x802620
  800567:	e8 c6 05 00 00       	call   800b32 <cprintf>
  80056c:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80056f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800572:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800579:	8b 45 08             	mov    0x8(%ebp),%eax
  80057c:	01 d0                	add    %edx,%eax
  80057e:	8b 00                	mov    (%eax),%eax
  800580:	83 ec 08             	sub    $0x8,%esp
  800583:	50                   	push   %eax
  800584:	68 f4 27 80 00       	push   $0x8027f4
  800589:	e8 a4 05 00 00       	call   800b32 <cprintf>
  80058e:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800591:	ff 45 f4             	incl   -0xc(%ebp)
  800594:	8b 45 0c             	mov    0xc(%ebp),%eax
  800597:	48                   	dec    %eax
  800598:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80059b:	7f b5                	jg     800552 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005aa:	01 d0                	add    %edx,%eax
  8005ac:	8b 00                	mov    (%eax),%eax
  8005ae:	83 ec 08             	sub    $0x8,%esp
  8005b1:	50                   	push   %eax
  8005b2:	68 f9 27 80 00       	push   $0x8027f9
  8005b7:	e8 76 05 00 00       	call   800b32 <cprintf>
  8005bc:	83 c4 10             	add    $0x10,%esp

}
  8005bf:	90                   	nop
  8005c0:	c9                   	leave  
  8005c1:	c3                   	ret    

008005c2 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005c2:	55                   	push   %ebp
  8005c3:	89 e5                	mov    %esp,%ebp
  8005c5:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cb:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005ce:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005d2:	83 ec 0c             	sub    $0xc,%esp
  8005d5:	50                   	push   %eax
  8005d6:	e8 23 19 00 00       	call   801efe <sys_cputc>
  8005db:	83 c4 10             	add    $0x10,%esp
}
  8005de:	90                   	nop
  8005df:	c9                   	leave  
  8005e0:	c3                   	ret    

008005e1 <getchar>:


int
getchar(void)
{
  8005e1:	55                   	push   %ebp
  8005e2:	89 e5                	mov    %esp,%ebp
  8005e4:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8005e7:	e8 b1 17 00 00       	call   801d9d <sys_cgetc>
  8005ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8005ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005f3:	74 f2                	je     8005e7 <getchar+0x6>
	return c;
  8005f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005f8:	c9                   	leave  
  8005f9:	c3                   	ret    

008005fa <iscons>:

int iscons(int fdnum)
{
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005fd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800602:	5d                   	pop    %ebp
  800603:	c3                   	ret    

00800604 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800604:	55                   	push   %ebp
  800605:	89 e5                	mov    %esp,%ebp
  800607:	57                   	push   %edi
  800608:	56                   	push   %esi
  800609:	53                   	push   %ebx
  80060a:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800610:	e8 19 1a 00 00       	call   80202e <sys_getenvindex>
  800615:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800618:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80061b:	89 d0                	mov    %edx,%eax
  80061d:	c1 e0 03             	shl    $0x3,%eax
  800620:	01 d0                	add    %edx,%eax
  800622:	c1 e0 06             	shl    $0x6,%eax
  800625:	01 d0                	add    %edx,%eax
  800627:	c1 e0 03             	shl    $0x3,%eax
  80062a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80062f:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800634:	a1 24 40 80 00       	mov    0x804024,%eax
  800639:	8a 40 10             	mov    0x10(%eax),%al
  80063c:	84 c0                	test   %al,%al
  80063e:	74 0d                	je     80064d <libmain+0x49>
		binaryname = myEnv->prog_name;
  800640:	a1 24 40 80 00       	mov    0x804024,%eax
  800645:	83 c0 10             	add    $0x10,%eax
  800648:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80064d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800651:	7e 0a                	jle    80065d <libmain+0x59>
		binaryname = argv[0];
  800653:	8b 45 0c             	mov    0xc(%ebp),%eax
  800656:	8b 00                	mov    (%eax),%eax
  800658:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  80065d:	83 ec 08             	sub    $0x8,%esp
  800660:	ff 75 0c             	pushl  0xc(%ebp)
  800663:	ff 75 08             	pushl  0x8(%ebp)
  800666:	e8 cd f9 ff ff       	call   800038 <_main>
  80066b:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80066e:	a1 00 40 80 00       	mov    0x804000,%eax
  800673:	85 c0                	test   %eax,%eax
  800675:	0f 84 b7 01 00 00    	je     800832 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80067b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800681:	bb 3c 29 80 00       	mov    $0x80293c,%ebx
  800686:	ba 0e 00 00 00       	mov    $0xe,%edx
  80068b:	89 c7                	mov    %eax,%edi
  80068d:	89 de                	mov    %ebx,%esi
  80068f:	89 d1                	mov    %edx,%ecx
  800691:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800693:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800699:	b9 56 00 00 00       	mov    $0x56,%ecx
  80069e:	b0 00                	mov    $0x0,%al
  8006a0:	89 d7                	mov    %edx,%edi
  8006a2:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8006a4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8006ab:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8006ae:	83 ec 08             	sub    $0x8,%esp
  8006b1:	50                   	push   %eax
  8006b2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8006b8:	50                   	push   %eax
  8006b9:	e8 70 1b 00 00       	call   80222e <sys_utilities>
  8006be:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8006c1:	e8 f0 16 00 00       	call   801db6 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	68 18 28 80 00       	push   $0x802818
  8006ce:	e8 5f 04 00 00       	call   800b32 <cprintf>
  8006d3:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006d6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006d9:	85 c0                	test   %eax,%eax
  8006db:	74 58                	je     800735 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006dd:	e8 6a 1b 00 00       	call   80224c <sys_get_optimal_num_faults>
  8006e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006e5:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006eb:	bb a0 29 80 00       	mov    $0x8029a0,%ebx
  8006f0:	ba 11 00 00 00       	mov    $0x11,%edx
  8006f5:	89 c7                	mov    %eax,%edi
  8006f7:	89 de                	mov    %ebx,%esi
  8006f9:	89 d1                	mov    %edx,%ecx
  8006fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006fd:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800700:	b9 53 00 00 00       	mov    $0x53,%ecx
  800705:	b0 00                	mov    $0x0,%al
  800707:	89 d7                	mov    %edx,%edi
  800709:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80070b:	83 ec 08             	sub    $0x8,%esp
  80070e:	ff 75 dc             	pushl  -0x24(%ebp)
  800711:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800717:	50                   	push   %eax
  800718:	e8 11 1b 00 00       	call   80222e <sys_utilities>
  80071d:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800720:	83 ec 08             	sub    $0x8,%esp
  800723:	ff 75 dc             	pushl  -0x24(%ebp)
  800726:	68 40 28 80 00       	push   $0x802840
  80072b:	e8 02 04 00 00       	call   800b32 <cprintf>
  800730:	83 c4 10             	add    $0x10,%esp
  800733:	eb 59                	jmp    80078e <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800735:	a1 24 40 80 00       	mov    0x804024,%eax
  80073a:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800740:	a1 24 40 80 00       	mov    0x804024,%eax
  800745:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80074b:	83 ec 04             	sub    $0x4,%esp
  80074e:	52                   	push   %edx
  80074f:	50                   	push   %eax
  800750:	68 64 28 80 00       	push   $0x802864
  800755:	e8 d8 03 00 00       	call   800b32 <cprintf>
  80075a:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80075d:	a1 24 40 80 00       	mov    0x804024,%eax
  800762:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800768:	a1 24 40 80 00       	mov    0x804024,%eax
  80076d:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800773:	a1 24 40 80 00       	mov    0x804024,%eax
  800778:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80077e:	51                   	push   %ecx
  80077f:	52                   	push   %edx
  800780:	50                   	push   %eax
  800781:	68 8c 28 80 00       	push   $0x80288c
  800786:	e8 a7 03 00 00       	call   800b32 <cprintf>
  80078b:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80078e:	a1 24 40 80 00       	mov    0x804024,%eax
  800793:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	50                   	push   %eax
  80079d:	68 e4 28 80 00       	push   $0x8028e4
  8007a2:	e8 8b 03 00 00       	call   800b32 <cprintf>
  8007a7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8007aa:	83 ec 0c             	sub    $0xc,%esp
  8007ad:	68 f8 28 80 00       	push   $0x8028f8
  8007b2:	e8 7b 03 00 00       	call   800b32 <cprintf>
  8007b7:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8007c1:	eb 28                	jmp    8007eb <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8007c3:	a1 24 40 80 00       	mov    0x804024,%eax
  8007c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007cb:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007d1:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007d4:	83 ec 04             	sub    $0x4,%esp
  8007d7:	50                   	push   %eax
  8007d8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007db:	68 0f 29 80 00       	push   $0x80290f
  8007e0:	e8 4d 03 00 00       	call   800b32 <cprintf>
  8007e5:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007e8:	ff 45 e4             	incl   -0x1c(%ebp)
  8007eb:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007ef:	7e d2                	jle    8007c3 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8007f1:	83 ec 0c             	sub    $0xc,%esp
  8007f4:	68 1e 29 80 00       	push   $0x80291e
  8007f9:	e8 34 03 00 00       	call   800b32 <cprintf>
  8007fe:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800801:	a1 24 40 80 00       	mov    0x804024,%eax
  800806:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80080c:	83 ec 08             	sub    $0x8,%esp
  80080f:	50                   	push   %eax
  800810:	68 22 29 80 00       	push   $0x802922
  800815:	e8 18 03 00 00       	call   800b32 <cprintf>
  80081a:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80081d:	83 ec 0c             	sub    $0xc,%esp
  800820:	68 18 28 80 00       	push   $0x802818
  800825:	e8 08 03 00 00       	call   800b32 <cprintf>
  80082a:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80082d:	e8 9e 15 00 00       	call   801dd0 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800832:	e8 1f 00 00 00       	call   800856 <exit>
}
  800837:	90                   	nop
  800838:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80083b:	5b                   	pop    %ebx
  80083c:	5e                   	pop    %esi
  80083d:	5f                   	pop    %edi
  80083e:	5d                   	pop    %ebp
  80083f:	c3                   	ret    

00800840 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800840:	55                   	push   %ebp
  800841:	89 e5                	mov    %esp,%ebp
  800843:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800846:	83 ec 0c             	sub    $0xc,%esp
  800849:	6a 00                	push   $0x0
  80084b:	e8 aa 17 00 00       	call   801ffa <sys_destroy_env>
  800850:	83 c4 10             	add    $0x10,%esp
}
  800853:	90                   	nop
  800854:	c9                   	leave  
  800855:	c3                   	ret    

00800856 <exit>:

void
exit(void)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
  800859:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80085c:	e8 ff 17 00 00       	call   802060 <sys_exit_env>
}
  800861:	90                   	nop
  800862:	c9                   	leave  
  800863:	c3                   	ret    

00800864 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800864:	55                   	push   %ebp
  800865:	89 e5                	mov    %esp,%ebp
  800867:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80086a:	8d 45 10             	lea    0x10(%ebp),%eax
  80086d:	83 c0 04             	add    $0x4,%eax
  800870:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800873:	a1 28 41 80 00       	mov    0x804128,%eax
  800878:	85 c0                	test   %eax,%eax
  80087a:	74 16                	je     800892 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80087c:	a1 28 41 80 00       	mov    0x804128,%eax
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	50                   	push   %eax
  800885:	68 04 2a 80 00       	push   $0x802a04
  80088a:	e8 a3 02 00 00       	call   800b32 <cprintf>
  80088f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800892:	a1 04 40 80 00       	mov    0x804004,%eax
  800897:	83 ec 0c             	sub    $0xc,%esp
  80089a:	ff 75 0c             	pushl  0xc(%ebp)
  80089d:	ff 75 08             	pushl  0x8(%ebp)
  8008a0:	50                   	push   %eax
  8008a1:	68 0c 2a 80 00       	push   $0x802a0c
  8008a6:	6a 74                	push   $0x74
  8008a8:	e8 b2 02 00 00       	call   800b5f <cprintf_colored>
  8008ad:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8008b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b3:	83 ec 08             	sub    $0x8,%esp
  8008b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b9:	50                   	push   %eax
  8008ba:	e8 04 02 00 00       	call   800ac3 <vcprintf>
  8008bf:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008c2:	83 ec 08             	sub    $0x8,%esp
  8008c5:	6a 00                	push   $0x0
  8008c7:	68 34 2a 80 00       	push   $0x802a34
  8008cc:	e8 f2 01 00 00       	call   800ac3 <vcprintf>
  8008d1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008d4:	e8 7d ff ff ff       	call   800856 <exit>

	// should not return here
	while (1) ;
  8008d9:	eb fe                	jmp    8008d9 <_panic+0x75>

008008db <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
  8008de:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008e1:	a1 24 40 80 00       	mov    0x804024,%eax
  8008e6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ef:	39 c2                	cmp    %eax,%edx
  8008f1:	74 14                	je     800907 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008f3:	83 ec 04             	sub    $0x4,%esp
  8008f6:	68 38 2a 80 00       	push   $0x802a38
  8008fb:	6a 26                	push   $0x26
  8008fd:	68 84 2a 80 00       	push   $0x802a84
  800902:	e8 5d ff ff ff       	call   800864 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800907:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80090e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800915:	e9 c5 00 00 00       	jmp    8009df <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80091a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800924:	8b 45 08             	mov    0x8(%ebp),%eax
  800927:	01 d0                	add    %edx,%eax
  800929:	8b 00                	mov    (%eax),%eax
  80092b:	85 c0                	test   %eax,%eax
  80092d:	75 08                	jne    800937 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80092f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800932:	e9 a5 00 00 00       	jmp    8009dc <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800937:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80093e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800945:	eb 69                	jmp    8009b0 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800947:	a1 24 40 80 00       	mov    0x804024,%eax
  80094c:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800952:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800955:	89 d0                	mov    %edx,%eax
  800957:	01 c0                	add    %eax,%eax
  800959:	01 d0                	add    %edx,%eax
  80095b:	c1 e0 03             	shl    $0x3,%eax
  80095e:	01 c8                	add    %ecx,%eax
  800960:	8a 40 04             	mov    0x4(%eax),%al
  800963:	84 c0                	test   %al,%al
  800965:	75 46                	jne    8009ad <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800967:	a1 24 40 80 00       	mov    0x804024,%eax
  80096c:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800972:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800975:	89 d0                	mov    %edx,%eax
  800977:	01 c0                	add    %eax,%eax
  800979:	01 d0                	add    %edx,%eax
  80097b:	c1 e0 03             	shl    $0x3,%eax
  80097e:	01 c8                	add    %ecx,%eax
  800980:	8b 00                	mov    (%eax),%eax
  800982:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800985:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800988:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80098d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80098f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800992:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	01 c8                	add    %ecx,%eax
  80099e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009a0:	39 c2                	cmp    %eax,%edx
  8009a2:	75 09                	jne    8009ad <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8009a4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009ab:	eb 15                	jmp    8009c2 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ad:	ff 45 e8             	incl   -0x18(%ebp)
  8009b0:	a1 24 40 80 00       	mov    0x804024,%eax
  8009b5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009be:	39 c2                	cmp    %eax,%edx
  8009c0:	77 85                	ja     800947 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009c6:	75 14                	jne    8009dc <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8009c8:	83 ec 04             	sub    $0x4,%esp
  8009cb:	68 90 2a 80 00       	push   $0x802a90
  8009d0:	6a 3a                	push   $0x3a
  8009d2:	68 84 2a 80 00       	push   $0x802a84
  8009d7:	e8 88 fe ff ff       	call   800864 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009dc:	ff 45 f0             	incl   -0x10(%ebp)
  8009df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009e5:	0f 8c 2f ff ff ff    	jl     80091a <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009eb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009f9:	eb 26                	jmp    800a21 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009fb:	a1 24 40 80 00       	mov    0x804024,%eax
  800a00:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a06:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a09:	89 d0                	mov    %edx,%eax
  800a0b:	01 c0                	add    %eax,%eax
  800a0d:	01 d0                	add    %edx,%eax
  800a0f:	c1 e0 03             	shl    $0x3,%eax
  800a12:	01 c8                	add    %ecx,%eax
  800a14:	8a 40 04             	mov    0x4(%eax),%al
  800a17:	3c 01                	cmp    $0x1,%al
  800a19:	75 03                	jne    800a1e <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800a1b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a1e:	ff 45 e0             	incl   -0x20(%ebp)
  800a21:	a1 24 40 80 00       	mov    0x804024,%eax
  800a26:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a2f:	39 c2                	cmp    %eax,%edx
  800a31:	77 c8                	ja     8009fb <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a36:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a39:	74 14                	je     800a4f <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a3b:	83 ec 04             	sub    $0x4,%esp
  800a3e:	68 e4 2a 80 00       	push   $0x802ae4
  800a43:	6a 44                	push   $0x44
  800a45:	68 84 2a 80 00       	push   $0x802a84
  800a4a:	e8 15 fe ff ff       	call   800864 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a4f:	90                   	nop
  800a50:	c9                   	leave  
  800a51:	c3                   	ret    

00800a52 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a52:	55                   	push   %ebp
  800a53:	89 e5                	mov    %esp,%ebp
  800a55:	53                   	push   %ebx
  800a56:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5c:	8b 00                	mov    (%eax),%eax
  800a5e:	8d 48 01             	lea    0x1(%eax),%ecx
  800a61:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a64:	89 0a                	mov    %ecx,(%edx)
  800a66:	8b 55 08             	mov    0x8(%ebp),%edx
  800a69:	88 d1                	mov    %dl,%cl
  800a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a75:	8b 00                	mov    (%eax),%eax
  800a77:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a7c:	75 30                	jne    800aae <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a7e:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800a84:	a0 40 40 80 00       	mov    0x804040,%al
  800a89:	0f b6 c0             	movzbl %al,%eax
  800a8c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a8f:	8b 09                	mov    (%ecx),%ecx
  800a91:	89 cb                	mov    %ecx,%ebx
  800a93:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800a96:	83 c1 08             	add    $0x8,%ecx
  800a99:	52                   	push   %edx
  800a9a:	50                   	push   %eax
  800a9b:	53                   	push   %ebx
  800a9c:	51                   	push   %ecx
  800a9d:	e8 d0 12 00 00       	call   801d72 <sys_cputs>
  800aa2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800aae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab1:	8b 40 04             	mov    0x4(%eax),%eax
  800ab4:	8d 50 01             	lea    0x1(%eax),%edx
  800ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aba:	89 50 04             	mov    %edx,0x4(%eax)
}
  800abd:	90                   	nop
  800abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac1:	c9                   	leave  
  800ac2:	c3                   	ret    

00800ac3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ac3:	55                   	push   %ebp
  800ac4:	89 e5                	mov    %esp,%ebp
  800ac6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800acc:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ad3:	00 00 00 
	b.cnt = 0;
  800ad6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800add:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ae0:	ff 75 0c             	pushl  0xc(%ebp)
  800ae3:	ff 75 08             	pushl  0x8(%ebp)
  800ae6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800aec:	50                   	push   %eax
  800aed:	68 52 0a 80 00       	push   $0x800a52
  800af2:	e8 5a 02 00 00       	call   800d51 <vprintfmt>
  800af7:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800afa:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800b00:	a0 40 40 80 00       	mov    0x804040,%al
  800b05:	0f b6 c0             	movzbl %al,%eax
  800b08:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800b0e:	52                   	push   %edx
  800b0f:	50                   	push   %eax
  800b10:	51                   	push   %ecx
  800b11:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b17:	83 c0 08             	add    $0x8,%eax
  800b1a:	50                   	push   %eax
  800b1b:	e8 52 12 00 00       	call   801d72 <sys_cputs>
  800b20:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b23:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800b2a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b30:	c9                   	leave  
  800b31:	c3                   	ret    

00800b32 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b32:	55                   	push   %ebp
  800b33:	89 e5                	mov    %esp,%ebp
  800b35:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b38:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800b3f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b42:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	83 ec 08             	sub    $0x8,%esp
  800b4b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4e:	50                   	push   %eax
  800b4f:	e8 6f ff ff ff       	call   800ac3 <vcprintf>
  800b54:	83 c4 10             	add    $0x10,%esp
  800b57:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b65:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	c1 e0 08             	shl    $0x8,%eax
  800b72:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800b77:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b7a:	83 c0 04             	add    $0x4,%eax
  800b7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 f4             	pushl  -0xc(%ebp)
  800b89:	50                   	push   %eax
  800b8a:	e8 34 ff ff ff       	call   800ac3 <vcprintf>
  800b8f:	83 c4 10             	add    $0x10,%esp
  800b92:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800b95:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800b9c:	07 00 00 

	return cnt;
  800b9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800baa:	e8 07 12 00 00       	call   801db6 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800baf:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbe:	50                   	push   %eax
  800bbf:	e8 ff fe ff ff       	call   800ac3 <vcprintf>
  800bc4:	83 c4 10             	add    $0x10,%esp
  800bc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800bca:	e8 01 12 00 00       	call   801dd0 <sys_unlock_cons>
	return cnt;
  800bcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	53                   	push   %ebx
  800bd8:	83 ec 14             	sub    $0x14,%esp
  800bdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be1:	8b 45 14             	mov    0x14(%ebp),%eax
  800be4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800be7:	8b 45 18             	mov    0x18(%ebp),%eax
  800bea:	ba 00 00 00 00       	mov    $0x0,%edx
  800bef:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf2:	77 55                	ja     800c49 <printnum+0x75>
  800bf4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf7:	72 05                	jb     800bfe <printnum+0x2a>
  800bf9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bfc:	77 4b                	ja     800c49 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bfe:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c04:	8b 45 18             	mov    0x18(%ebp),%eax
  800c07:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0c:	52                   	push   %edx
  800c0d:	50                   	push   %eax
  800c0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c11:	ff 75 f0             	pushl  -0x10(%ebp)
  800c14:	e8 93 17 00 00       	call   8023ac <__udivdi3>
  800c19:	83 c4 10             	add    $0x10,%esp
  800c1c:	83 ec 04             	sub    $0x4,%esp
  800c1f:	ff 75 20             	pushl  0x20(%ebp)
  800c22:	53                   	push   %ebx
  800c23:	ff 75 18             	pushl  0x18(%ebp)
  800c26:	52                   	push   %edx
  800c27:	50                   	push   %eax
  800c28:	ff 75 0c             	pushl  0xc(%ebp)
  800c2b:	ff 75 08             	pushl  0x8(%ebp)
  800c2e:	e8 a1 ff ff ff       	call   800bd4 <printnum>
  800c33:	83 c4 20             	add    $0x20,%esp
  800c36:	eb 1a                	jmp    800c52 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c38:	83 ec 08             	sub    $0x8,%esp
  800c3b:	ff 75 0c             	pushl  0xc(%ebp)
  800c3e:	ff 75 20             	pushl  0x20(%ebp)
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	ff d0                	call   *%eax
  800c46:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c49:	ff 4d 1c             	decl   0x1c(%ebp)
  800c4c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c50:	7f e6                	jg     800c38 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c52:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c55:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c60:	53                   	push   %ebx
  800c61:	51                   	push   %ecx
  800c62:	52                   	push   %edx
  800c63:	50                   	push   %eax
  800c64:	e8 53 18 00 00       	call   8024bc <__umoddi3>
  800c69:	83 c4 10             	add    $0x10,%esp
  800c6c:	05 54 2d 80 00       	add    $0x802d54,%eax
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	0f be c0             	movsbl %al,%eax
  800c76:	83 ec 08             	sub    $0x8,%esp
  800c79:	ff 75 0c             	pushl  0xc(%ebp)
  800c7c:	50                   	push   %eax
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	ff d0                	call   *%eax
  800c82:	83 c4 10             	add    $0x10,%esp
}
  800c85:	90                   	nop
  800c86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c89:	c9                   	leave  
  800c8a:	c3                   	ret    

00800c8b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c8b:	55                   	push   %ebp
  800c8c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c8e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c92:	7e 1c                	jle    800cb0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8b 00                	mov    (%eax),%eax
  800c99:	8d 50 08             	lea    0x8(%eax),%edx
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	89 10                	mov    %edx,(%eax)
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8b 00                	mov    (%eax),%eax
  800ca6:	83 e8 08             	sub    $0x8,%eax
  800ca9:	8b 50 04             	mov    0x4(%eax),%edx
  800cac:	8b 00                	mov    (%eax),%eax
  800cae:	eb 40                	jmp    800cf0 <getuint+0x65>
	else if (lflag)
  800cb0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb4:	74 1e                	je     800cd4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8b 00                	mov    (%eax),%eax
  800cbb:	8d 50 04             	lea    0x4(%eax),%edx
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	89 10                	mov    %edx,(%eax)
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8b 00                	mov    (%eax),%eax
  800cc8:	83 e8 04             	sub    $0x4,%eax
  800ccb:	8b 00                	mov    (%eax),%eax
  800ccd:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd2:	eb 1c                	jmp    800cf0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	8d 50 04             	lea    0x4(%eax),%edx
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	89 10                	mov    %edx,(%eax)
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8b 00                	mov    (%eax),%eax
  800ce6:	83 e8 04             	sub    $0x4,%eax
  800ce9:	8b 00                	mov    (%eax),%eax
  800ceb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cf0:	5d                   	pop    %ebp
  800cf1:	c3                   	ret    

00800cf2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cf2:	55                   	push   %ebp
  800cf3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cf5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cf9:	7e 1c                	jle    800d17 <getint+0x25>
		return va_arg(*ap, long long);
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	8d 50 08             	lea    0x8(%eax),%edx
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	89 10                	mov    %edx,(%eax)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	83 e8 08             	sub    $0x8,%eax
  800d10:	8b 50 04             	mov    0x4(%eax),%edx
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	eb 38                	jmp    800d4f <getint+0x5d>
	else if (lflag)
  800d17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1b:	74 1a                	je     800d37 <getint+0x45>
		return va_arg(*ap, long);
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8b 00                	mov    (%eax),%eax
  800d22:	8d 50 04             	lea    0x4(%eax),%edx
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	89 10                	mov    %edx,(%eax)
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8b 00                	mov    (%eax),%eax
  800d2f:	83 e8 04             	sub    $0x4,%eax
  800d32:	8b 00                	mov    (%eax),%eax
  800d34:	99                   	cltd   
  800d35:	eb 18                	jmp    800d4f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	8b 00                	mov    (%eax),%eax
  800d3c:	8d 50 04             	lea    0x4(%eax),%edx
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	89 10                	mov    %edx,(%eax)
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8b 00                	mov    (%eax),%eax
  800d49:	83 e8 04             	sub    $0x4,%eax
  800d4c:	8b 00                	mov    (%eax),%eax
  800d4e:	99                   	cltd   
}
  800d4f:	5d                   	pop    %ebp
  800d50:	c3                   	ret    

00800d51 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d51:	55                   	push   %ebp
  800d52:	89 e5                	mov    %esp,%ebp
  800d54:	56                   	push   %esi
  800d55:	53                   	push   %ebx
  800d56:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d59:	eb 17                	jmp    800d72 <vprintfmt+0x21>
			if (ch == '\0')
  800d5b:	85 db                	test   %ebx,%ebx
  800d5d:	0f 84 c1 03 00 00    	je     801124 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d63:	83 ec 08             	sub    $0x8,%esp
  800d66:	ff 75 0c             	pushl  0xc(%ebp)
  800d69:	53                   	push   %ebx
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	ff d0                	call   *%eax
  800d6f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	8d 50 01             	lea    0x1(%eax),%edx
  800d78:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7b:	8a 00                	mov    (%eax),%al
  800d7d:	0f b6 d8             	movzbl %al,%ebx
  800d80:	83 fb 25             	cmp    $0x25,%ebx
  800d83:	75 d6                	jne    800d5b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d85:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d89:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d90:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d97:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d9e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800da5:	8b 45 10             	mov    0x10(%ebp),%eax
  800da8:	8d 50 01             	lea    0x1(%eax),%edx
  800dab:	89 55 10             	mov    %edx,0x10(%ebp)
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	0f b6 d8             	movzbl %al,%ebx
  800db3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800db6:	83 f8 5b             	cmp    $0x5b,%eax
  800db9:	0f 87 3d 03 00 00    	ja     8010fc <vprintfmt+0x3ab>
  800dbf:	8b 04 85 78 2d 80 00 	mov    0x802d78(,%eax,4),%eax
  800dc6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dc8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dcc:	eb d7                	jmp    800da5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dce:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dd2:	eb d1                	jmp    800da5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dd4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ddb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dde:	89 d0                	mov    %edx,%eax
  800de0:	c1 e0 02             	shl    $0x2,%eax
  800de3:	01 d0                	add    %edx,%eax
  800de5:	01 c0                	add    %eax,%eax
  800de7:	01 d8                	add    %ebx,%eax
  800de9:	83 e8 30             	sub    $0x30,%eax
  800dec:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800def:	8b 45 10             	mov    0x10(%ebp),%eax
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800df7:	83 fb 2f             	cmp    $0x2f,%ebx
  800dfa:	7e 3e                	jle    800e3a <vprintfmt+0xe9>
  800dfc:	83 fb 39             	cmp    $0x39,%ebx
  800dff:	7f 39                	jg     800e3a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e01:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e04:	eb d5                	jmp    800ddb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e06:	8b 45 14             	mov    0x14(%ebp),%eax
  800e09:	83 c0 04             	add    $0x4,%eax
  800e0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e12:	83 e8 04             	sub    $0x4,%eax
  800e15:	8b 00                	mov    (%eax),%eax
  800e17:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e1a:	eb 1f                	jmp    800e3b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e20:	79 83                	jns    800da5 <vprintfmt+0x54>
				width = 0;
  800e22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e29:	e9 77 ff ff ff       	jmp    800da5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e2e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e35:	e9 6b ff ff ff       	jmp    800da5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e3a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e3f:	0f 89 60 ff ff ff    	jns    800da5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e45:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e4b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e52:	e9 4e ff ff ff       	jmp    800da5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e57:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e5a:	e9 46 ff ff ff       	jmp    800da5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e62:	83 c0 04             	add    $0x4,%eax
  800e65:	89 45 14             	mov    %eax,0x14(%ebp)
  800e68:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6b:	83 e8 04             	sub    $0x4,%eax
  800e6e:	8b 00                	mov    (%eax),%eax
  800e70:	83 ec 08             	sub    $0x8,%esp
  800e73:	ff 75 0c             	pushl  0xc(%ebp)
  800e76:	50                   	push   %eax
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	ff d0                	call   *%eax
  800e7c:	83 c4 10             	add    $0x10,%esp
			break;
  800e7f:	e9 9b 02 00 00       	jmp    80111f <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e84:	8b 45 14             	mov    0x14(%ebp),%eax
  800e87:	83 c0 04             	add    $0x4,%eax
  800e8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e90:	83 e8 04             	sub    $0x4,%eax
  800e93:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e95:	85 db                	test   %ebx,%ebx
  800e97:	79 02                	jns    800e9b <vprintfmt+0x14a>
				err = -err;
  800e99:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e9b:	83 fb 64             	cmp    $0x64,%ebx
  800e9e:	7f 0b                	jg     800eab <vprintfmt+0x15a>
  800ea0:	8b 34 9d c0 2b 80 00 	mov    0x802bc0(,%ebx,4),%esi
  800ea7:	85 f6                	test   %esi,%esi
  800ea9:	75 19                	jne    800ec4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eab:	53                   	push   %ebx
  800eac:	68 65 2d 80 00       	push   $0x802d65
  800eb1:	ff 75 0c             	pushl  0xc(%ebp)
  800eb4:	ff 75 08             	pushl  0x8(%ebp)
  800eb7:	e8 70 02 00 00       	call   80112c <printfmt>
  800ebc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ebf:	e9 5b 02 00 00       	jmp    80111f <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ec4:	56                   	push   %esi
  800ec5:	68 6e 2d 80 00       	push   $0x802d6e
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	ff 75 08             	pushl  0x8(%ebp)
  800ed0:	e8 57 02 00 00       	call   80112c <printfmt>
  800ed5:	83 c4 10             	add    $0x10,%esp
			break;
  800ed8:	e9 42 02 00 00       	jmp    80111f <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800edd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee0:	83 c0 04             	add    $0x4,%eax
  800ee3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee9:	83 e8 04             	sub    $0x4,%eax
  800eec:	8b 30                	mov    (%eax),%esi
  800eee:	85 f6                	test   %esi,%esi
  800ef0:	75 05                	jne    800ef7 <vprintfmt+0x1a6>
				p = "(null)";
  800ef2:	be 71 2d 80 00       	mov    $0x802d71,%esi
			if (width > 0 && padc != '-')
  800ef7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800efb:	7e 6d                	jle    800f6a <vprintfmt+0x219>
  800efd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f01:	74 67                	je     800f6a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f06:	83 ec 08             	sub    $0x8,%esp
  800f09:	50                   	push   %eax
  800f0a:	56                   	push   %esi
  800f0b:	e8 26 05 00 00       	call   801436 <strnlen>
  800f10:	83 c4 10             	add    $0x10,%esp
  800f13:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f16:	eb 16                	jmp    800f2e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f18:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f1c:	83 ec 08             	sub    $0x8,%esp
  800f1f:	ff 75 0c             	pushl  0xc(%ebp)
  800f22:	50                   	push   %eax
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	ff d0                	call   *%eax
  800f28:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2b:	ff 4d e4             	decl   -0x1c(%ebp)
  800f2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f32:	7f e4                	jg     800f18 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f34:	eb 34                	jmp    800f6a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f36:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f3a:	74 1c                	je     800f58 <vprintfmt+0x207>
  800f3c:	83 fb 1f             	cmp    $0x1f,%ebx
  800f3f:	7e 05                	jle    800f46 <vprintfmt+0x1f5>
  800f41:	83 fb 7e             	cmp    $0x7e,%ebx
  800f44:	7e 12                	jle    800f58 <vprintfmt+0x207>
					putch('?', putdat);
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	6a 3f                	push   $0x3f
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	ff d0                	call   *%eax
  800f53:	83 c4 10             	add    $0x10,%esp
  800f56:	eb 0f                	jmp    800f67 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f58:	83 ec 08             	sub    $0x8,%esp
  800f5b:	ff 75 0c             	pushl  0xc(%ebp)
  800f5e:	53                   	push   %ebx
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	ff d0                	call   *%eax
  800f64:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f67:	ff 4d e4             	decl   -0x1c(%ebp)
  800f6a:	89 f0                	mov    %esi,%eax
  800f6c:	8d 70 01             	lea    0x1(%eax),%esi
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	0f be d8             	movsbl %al,%ebx
  800f74:	85 db                	test   %ebx,%ebx
  800f76:	74 24                	je     800f9c <vprintfmt+0x24b>
  800f78:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f7c:	78 b8                	js     800f36 <vprintfmt+0x1e5>
  800f7e:	ff 4d e0             	decl   -0x20(%ebp)
  800f81:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f85:	79 af                	jns    800f36 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f87:	eb 13                	jmp    800f9c <vprintfmt+0x24b>
				putch(' ', putdat);
  800f89:	83 ec 08             	sub    $0x8,%esp
  800f8c:	ff 75 0c             	pushl  0xc(%ebp)
  800f8f:	6a 20                	push   $0x20
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	ff d0                	call   *%eax
  800f96:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f99:	ff 4d e4             	decl   -0x1c(%ebp)
  800f9c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa0:	7f e7                	jg     800f89 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fa2:	e9 78 01 00 00       	jmp    80111f <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fa7:	83 ec 08             	sub    $0x8,%esp
  800faa:	ff 75 e8             	pushl  -0x18(%ebp)
  800fad:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb0:	50                   	push   %eax
  800fb1:	e8 3c fd ff ff       	call   800cf2 <getint>
  800fb6:	83 c4 10             	add    $0x10,%esp
  800fb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fbc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc5:	85 d2                	test   %edx,%edx
  800fc7:	79 23                	jns    800fec <vprintfmt+0x29b>
				putch('-', putdat);
  800fc9:	83 ec 08             	sub    $0x8,%esp
  800fcc:	ff 75 0c             	pushl  0xc(%ebp)
  800fcf:	6a 2d                	push   $0x2d
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	ff d0                	call   *%eax
  800fd6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fdf:	f7 d8                	neg    %eax
  800fe1:	83 d2 00             	adc    $0x0,%edx
  800fe4:	f7 da                	neg    %edx
  800fe6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ff3:	e9 bc 00 00 00       	jmp    8010b4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ff8:	83 ec 08             	sub    $0x8,%esp
  800ffb:	ff 75 e8             	pushl  -0x18(%ebp)
  800ffe:	8d 45 14             	lea    0x14(%ebp),%eax
  801001:	50                   	push   %eax
  801002:	e8 84 fc ff ff       	call   800c8b <getuint>
  801007:	83 c4 10             	add    $0x10,%esp
  80100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801010:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801017:	e9 98 00 00 00       	jmp    8010b4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80101c:	83 ec 08             	sub    $0x8,%esp
  80101f:	ff 75 0c             	pushl  0xc(%ebp)
  801022:	6a 58                	push   $0x58
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	ff d0                	call   *%eax
  801029:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80102c:	83 ec 08             	sub    $0x8,%esp
  80102f:	ff 75 0c             	pushl  0xc(%ebp)
  801032:	6a 58                	push   $0x58
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	ff d0                	call   *%eax
  801039:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103c:	83 ec 08             	sub    $0x8,%esp
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	6a 58                	push   $0x58
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	ff d0                	call   *%eax
  801049:	83 c4 10             	add    $0x10,%esp
			break;
  80104c:	e9 ce 00 00 00       	jmp    80111f <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801051:	83 ec 08             	sub    $0x8,%esp
  801054:	ff 75 0c             	pushl  0xc(%ebp)
  801057:	6a 30                	push   $0x30
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	ff d0                	call   *%eax
  80105e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801061:	83 ec 08             	sub    $0x8,%esp
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	6a 78                	push   $0x78
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	ff d0                	call   *%eax
  80106e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801071:	8b 45 14             	mov    0x14(%ebp),%eax
  801074:	83 c0 04             	add    $0x4,%eax
  801077:	89 45 14             	mov    %eax,0x14(%ebp)
  80107a:	8b 45 14             	mov    0x14(%ebp),%eax
  80107d:	83 e8 04             	sub    $0x4,%eax
  801080:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801082:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801085:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80108c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801093:	eb 1f                	jmp    8010b4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801095:	83 ec 08             	sub    $0x8,%esp
  801098:	ff 75 e8             	pushl  -0x18(%ebp)
  80109b:	8d 45 14             	lea    0x14(%ebp),%eax
  80109e:	50                   	push   %eax
  80109f:	e8 e7 fb ff ff       	call   800c8b <getuint>
  8010a4:	83 c4 10             	add    $0x10,%esp
  8010a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010ad:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010b4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010bb:	83 ec 04             	sub    $0x4,%esp
  8010be:	52                   	push   %edx
  8010bf:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010c2:	50                   	push   %eax
  8010c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c6:	ff 75 f0             	pushl  -0x10(%ebp)
  8010c9:	ff 75 0c             	pushl  0xc(%ebp)
  8010cc:	ff 75 08             	pushl  0x8(%ebp)
  8010cf:	e8 00 fb ff ff       	call   800bd4 <printnum>
  8010d4:	83 c4 20             	add    $0x20,%esp
			break;
  8010d7:	eb 46                	jmp    80111f <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010d9:	83 ec 08             	sub    $0x8,%esp
  8010dc:	ff 75 0c             	pushl  0xc(%ebp)
  8010df:	53                   	push   %ebx
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	ff d0                	call   *%eax
  8010e5:	83 c4 10             	add    $0x10,%esp
			break;
  8010e8:	eb 35                	jmp    80111f <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010ea:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  8010f1:	eb 2c                	jmp    80111f <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8010f3:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  8010fa:	eb 23                	jmp    80111f <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010fc:	83 ec 08             	sub    $0x8,%esp
  8010ff:	ff 75 0c             	pushl  0xc(%ebp)
  801102:	6a 25                	push   $0x25
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	ff d0                	call   *%eax
  801109:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80110c:	ff 4d 10             	decl   0x10(%ebp)
  80110f:	eb 03                	jmp    801114 <vprintfmt+0x3c3>
  801111:	ff 4d 10             	decl   0x10(%ebp)
  801114:	8b 45 10             	mov    0x10(%ebp),%eax
  801117:	48                   	dec    %eax
  801118:	8a 00                	mov    (%eax),%al
  80111a:	3c 25                	cmp    $0x25,%al
  80111c:	75 f3                	jne    801111 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80111e:	90                   	nop
		}
	}
  80111f:	e9 35 fc ff ff       	jmp    800d59 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801124:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801125:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801128:	5b                   	pop    %ebx
  801129:	5e                   	pop    %esi
  80112a:	5d                   	pop    %ebp
  80112b:	c3                   	ret    

0080112c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80112c:	55                   	push   %ebp
  80112d:	89 e5                	mov    %esp,%ebp
  80112f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801132:	8d 45 10             	lea    0x10(%ebp),%eax
  801135:	83 c0 04             	add    $0x4,%eax
  801138:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80113b:	8b 45 10             	mov    0x10(%ebp),%eax
  80113e:	ff 75 f4             	pushl  -0xc(%ebp)
  801141:	50                   	push   %eax
  801142:	ff 75 0c             	pushl  0xc(%ebp)
  801145:	ff 75 08             	pushl  0x8(%ebp)
  801148:	e8 04 fc ff ff       	call   800d51 <vprintfmt>
  80114d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801150:	90                   	nop
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	8b 40 08             	mov    0x8(%eax),%eax
  80115c:	8d 50 01             	lea    0x1(%eax),%edx
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	8b 10                	mov    (%eax),%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	8b 40 04             	mov    0x4(%eax),%eax
  801170:	39 c2                	cmp    %eax,%edx
  801172:	73 12                	jae    801186 <sprintputch+0x33>
		*b->buf++ = ch;
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	8b 00                	mov    (%eax),%eax
  801179:	8d 48 01             	lea    0x1(%eax),%ecx
  80117c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117f:	89 0a                	mov    %ecx,(%edx)
  801181:	8b 55 08             	mov    0x8(%ebp),%edx
  801184:	88 10                	mov    %dl,(%eax)
}
  801186:	90                   	nop
  801187:	5d                   	pop    %ebp
  801188:	c3                   	ret    

00801189 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801189:	55                   	push   %ebp
  80118a:	89 e5                	mov    %esp,%ebp
  80118c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	8d 50 ff             	lea    -0x1(%eax),%edx
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	01 d0                	add    %edx,%eax
  8011a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ae:	74 06                	je     8011b6 <vsnprintf+0x2d>
  8011b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011b4:	7f 07                	jg     8011bd <vsnprintf+0x34>
		return -E_INVAL;
  8011b6:	b8 03 00 00 00       	mov    $0x3,%eax
  8011bb:	eb 20                	jmp    8011dd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011bd:	ff 75 14             	pushl  0x14(%ebp)
  8011c0:	ff 75 10             	pushl  0x10(%ebp)
  8011c3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011c6:	50                   	push   %eax
  8011c7:	68 53 11 80 00       	push   $0x801153
  8011cc:	e8 80 fb ff ff       	call   800d51 <vprintfmt>
  8011d1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011da:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011dd:	c9                   	leave  
  8011de:	c3                   	ret    

008011df <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011df:	55                   	push   %ebp
  8011e0:	89 e5                	mov    %esp,%ebp
  8011e2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011e5:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e8:	83 c0 04             	add    $0x4,%eax
  8011eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f1:	ff 75 f4             	pushl  -0xc(%ebp)
  8011f4:	50                   	push   %eax
  8011f5:	ff 75 0c             	pushl  0xc(%ebp)
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	e8 89 ff ff ff       	call   801189 <vsnprintf>
  801200:	83 c4 10             	add    $0x10,%esp
  801203:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801206:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801209:	c9                   	leave  
  80120a:	c3                   	ret    

0080120b <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80120b:	55                   	push   %ebp
  80120c:	89 e5                	mov    %esp,%ebp
  80120e:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  801211:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801215:	74 13                	je     80122a <readline+0x1f>
		cprintf("%s", prompt);
  801217:	83 ec 08             	sub    $0x8,%esp
  80121a:	ff 75 08             	pushl  0x8(%ebp)
  80121d:	68 e8 2e 80 00       	push   $0x802ee8
  801222:	e8 0b f9 ff ff       	call   800b32 <cprintf>
  801227:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80122a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801231:	83 ec 0c             	sub    $0xc,%esp
  801234:	6a 00                	push   $0x0
  801236:	e8 bf f3 ff ff       	call   8005fa <iscons>
  80123b:	83 c4 10             	add    $0x10,%esp
  80123e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801241:	e8 9b f3 ff ff       	call   8005e1 <getchar>
  801246:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801249:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80124d:	79 22                	jns    801271 <readline+0x66>
			if (c != -E_EOF)
  80124f:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801253:	0f 84 ad 00 00 00    	je     801306 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801259:	83 ec 08             	sub    $0x8,%esp
  80125c:	ff 75 ec             	pushl  -0x14(%ebp)
  80125f:	68 eb 2e 80 00       	push   $0x802eeb
  801264:	e8 c9 f8 ff ff       	call   800b32 <cprintf>
  801269:	83 c4 10             	add    $0x10,%esp
			break;
  80126c:	e9 95 00 00 00       	jmp    801306 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801271:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801275:	7e 34                	jle    8012ab <readline+0xa0>
  801277:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80127e:	7f 2b                	jg     8012ab <readline+0xa0>
			if (echoing)
  801280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801284:	74 0e                	je     801294 <readline+0x89>
				cputchar(c);
  801286:	83 ec 0c             	sub    $0xc,%esp
  801289:	ff 75 ec             	pushl  -0x14(%ebp)
  80128c:	e8 31 f3 ff ff       	call   8005c2 <cputchar>
  801291:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80129d:	89 c2                	mov    %eax,%edx
  80129f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a2:	01 d0                	add    %edx,%eax
  8012a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a7:	88 10                	mov    %dl,(%eax)
  8012a9:	eb 56                	jmp    801301 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012ab:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012af:	75 1f                	jne    8012d0 <readline+0xc5>
  8012b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012b5:	7e 19                	jle    8012d0 <readline+0xc5>
			if (echoing)
  8012b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012bb:	74 0e                	je     8012cb <readline+0xc0>
				cputchar(c);
  8012bd:	83 ec 0c             	sub    $0xc,%esp
  8012c0:	ff 75 ec             	pushl  -0x14(%ebp)
  8012c3:	e8 fa f2 ff ff       	call   8005c2 <cputchar>
  8012c8:	83 c4 10             	add    $0x10,%esp

			i--;
  8012cb:	ff 4d f4             	decl   -0xc(%ebp)
  8012ce:	eb 31                	jmp    801301 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012d0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012d4:	74 0a                	je     8012e0 <readline+0xd5>
  8012d6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012da:	0f 85 61 ff ff ff    	jne    801241 <readline+0x36>
			if (echoing)
  8012e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e4:	74 0e                	je     8012f4 <readline+0xe9>
				cputchar(c);
  8012e6:	83 ec 0c             	sub    $0xc,%esp
  8012e9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ec:	e8 d1 f2 ff ff       	call   8005c2 <cputchar>
  8012f1:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fa:	01 d0                	add    %edx,%eax
  8012fc:	c6 00 00             	movb   $0x0,(%eax)
			break;
  8012ff:	eb 06                	jmp    801307 <readline+0xfc>
		}
	}
  801301:	e9 3b ff ff ff       	jmp    801241 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  801306:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  801307:	90                   	nop
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
  80130d:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  801310:	e8 a1 0a 00 00       	call   801db6 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  801315:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801319:	74 13                	je     80132e <atomic_readline+0x24>
			cprintf("%s", prompt);
  80131b:	83 ec 08             	sub    $0x8,%esp
  80131e:	ff 75 08             	pushl  0x8(%ebp)
  801321:	68 e8 2e 80 00       	push   $0x802ee8
  801326:	e8 07 f8 ff ff       	call   800b32 <cprintf>
  80132b:	83 c4 10             	add    $0x10,%esp

		i = 0;
  80132e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  801335:	83 ec 0c             	sub    $0xc,%esp
  801338:	6a 00                	push   $0x0
  80133a:	e8 bb f2 ff ff       	call   8005fa <iscons>
  80133f:	83 c4 10             	add    $0x10,%esp
  801342:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  801345:	e8 97 f2 ff ff       	call   8005e1 <getchar>
  80134a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  80134d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801351:	79 22                	jns    801375 <atomic_readline+0x6b>
				if (c != -E_EOF)
  801353:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801357:	0f 84 ad 00 00 00    	je     80140a <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  80135d:	83 ec 08             	sub    $0x8,%esp
  801360:	ff 75 ec             	pushl  -0x14(%ebp)
  801363:	68 eb 2e 80 00       	push   $0x802eeb
  801368:	e8 c5 f7 ff ff       	call   800b32 <cprintf>
  80136d:	83 c4 10             	add    $0x10,%esp
				break;
  801370:	e9 95 00 00 00       	jmp    80140a <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  801375:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801379:	7e 34                	jle    8013af <atomic_readline+0xa5>
  80137b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801382:	7f 2b                	jg     8013af <atomic_readline+0xa5>
				if (echoing)
  801384:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801388:	74 0e                	je     801398 <atomic_readline+0x8e>
					cputchar(c);
  80138a:	83 ec 0c             	sub    $0xc,%esp
  80138d:	ff 75 ec             	pushl  -0x14(%ebp)
  801390:	e8 2d f2 ff ff       	call   8005c2 <cputchar>
  801395:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  801398:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80139b:	8d 50 01             	lea    0x1(%eax),%edx
  80139e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013a1:	89 c2                	mov    %eax,%edx
  8013a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a6:	01 d0                	add    %edx,%eax
  8013a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013ab:	88 10                	mov    %dl,(%eax)
  8013ad:	eb 56                	jmp    801405 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  8013af:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013b3:	75 1f                	jne    8013d4 <atomic_readline+0xca>
  8013b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b9:	7e 19                	jle    8013d4 <atomic_readline+0xca>
				if (echoing)
  8013bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013bf:	74 0e                	je     8013cf <atomic_readline+0xc5>
					cputchar(c);
  8013c1:	83 ec 0c             	sub    $0xc,%esp
  8013c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c7:	e8 f6 f1 ff ff       	call   8005c2 <cputchar>
  8013cc:	83 c4 10             	add    $0x10,%esp
				i--;
  8013cf:	ff 4d f4             	decl   -0xc(%ebp)
  8013d2:	eb 31                	jmp    801405 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  8013d4:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d8:	74 0a                	je     8013e4 <atomic_readline+0xda>
  8013da:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013de:	0f 85 61 ff ff ff    	jne    801345 <atomic_readline+0x3b>
				if (echoing)
  8013e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e8:	74 0e                	je     8013f8 <atomic_readline+0xee>
					cputchar(c);
  8013ea:	83 ec 0c             	sub    $0xc,%esp
  8013ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8013f0:	e8 cd f1 ff ff       	call   8005c2 <cputchar>
  8013f5:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  8013f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fe:	01 d0                	add    %edx,%eax
  801400:	c6 00 00             	movb   $0x0,(%eax)
				break;
  801403:	eb 06                	jmp    80140b <atomic_readline+0x101>
			}
		}
  801405:	e9 3b ff ff ff       	jmp    801345 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  80140a:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  80140b:	e8 c0 09 00 00       	call   801dd0 <sys_unlock_cons>
}
  801410:	90                   	nop
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
  801416:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801419:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801420:	eb 06                	jmp    801428 <strlen+0x15>
		n++;
  801422:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801425:	ff 45 08             	incl   0x8(%ebp)
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	84 c0                	test   %al,%al
  80142f:	75 f1                	jne    801422 <strlen+0xf>
		n++;
	return n;
  801431:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
  801439:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80143c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801443:	eb 09                	jmp    80144e <strnlen+0x18>
		n++;
  801445:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801448:	ff 45 08             	incl   0x8(%ebp)
  80144b:	ff 4d 0c             	decl   0xc(%ebp)
  80144e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801452:	74 09                	je     80145d <strnlen+0x27>
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	84 c0                	test   %al,%al
  80145b:	75 e8                	jne    801445 <strnlen+0xf>
		n++;
	return n;
  80145d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801460:	c9                   	leave  
  801461:	c3                   	ret    

00801462 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
  801465:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80146e:	90                   	nop
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8d 50 01             	lea    0x1(%eax),%edx
  801475:	89 55 08             	mov    %edx,0x8(%ebp)
  801478:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80147e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801481:	8a 12                	mov    (%edx),%dl
  801483:	88 10                	mov    %dl,(%eax)
  801485:	8a 00                	mov    (%eax),%al
  801487:	84 c0                	test   %al,%al
  801489:	75 e4                	jne    80146f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80148b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80148e:	c9                   	leave  
  80148f:	c3                   	ret    

00801490 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
  801493:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80149c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a3:	eb 1f                	jmp    8014c4 <strncpy+0x34>
		*dst++ = *src;
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	8d 50 01             	lea    0x1(%eax),%edx
  8014ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8014ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b1:	8a 12                	mov    (%edx),%dl
  8014b3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b8:	8a 00                	mov    (%eax),%al
  8014ba:	84 c0                	test   %al,%al
  8014bc:	74 03                	je     8014c1 <strncpy+0x31>
			src++;
  8014be:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014c1:	ff 45 fc             	incl   -0x4(%ebp)
  8014c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ca:	72 d9                	jb     8014a5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e1:	74 30                	je     801513 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014e3:	eb 16                	jmp    8014fb <strlcpy+0x2a>
			*dst++ = *src++;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	8d 50 01             	lea    0x1(%eax),%edx
  8014eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8014ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014f7:	8a 12                	mov    (%edx),%dl
  8014f9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014fb:	ff 4d 10             	decl   0x10(%ebp)
  8014fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801502:	74 09                	je     80150d <strlcpy+0x3c>
  801504:	8b 45 0c             	mov    0xc(%ebp),%eax
  801507:	8a 00                	mov    (%eax),%al
  801509:	84 c0                	test   %al,%al
  80150b:	75 d8                	jne    8014e5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801513:	8b 55 08             	mov    0x8(%ebp),%edx
  801516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801519:	29 c2                	sub    %eax,%edx
  80151b:	89 d0                	mov    %edx,%eax
}
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801522:	eb 06                	jmp    80152a <strcmp+0xb>
		p++, q++;
  801524:	ff 45 08             	incl   0x8(%ebp)
  801527:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8a 00                	mov    (%eax),%al
  80152f:	84 c0                	test   %al,%al
  801531:	74 0e                	je     801541 <strcmp+0x22>
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	8a 10                	mov    (%eax),%dl
  801538:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	38 c2                	cmp    %al,%dl
  80153f:	74 e3                	je     801524 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	8a 00                	mov    (%eax),%al
  801546:	0f b6 d0             	movzbl %al,%edx
  801549:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154c:	8a 00                	mov    (%eax),%al
  80154e:	0f b6 c0             	movzbl %al,%eax
  801551:	29 c2                	sub    %eax,%edx
  801553:	89 d0                	mov    %edx,%eax
}
  801555:	5d                   	pop    %ebp
  801556:	c3                   	ret    

00801557 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80155a:	eb 09                	jmp    801565 <strncmp+0xe>
		n--, p++, q++;
  80155c:	ff 4d 10             	decl   0x10(%ebp)
  80155f:	ff 45 08             	incl   0x8(%ebp)
  801562:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801565:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801569:	74 17                	je     801582 <strncmp+0x2b>
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	84 c0                	test   %al,%al
  801572:	74 0e                	je     801582 <strncmp+0x2b>
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	8a 10                	mov    (%eax),%dl
  801579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157c:	8a 00                	mov    (%eax),%al
  80157e:	38 c2                	cmp    %al,%dl
  801580:	74 da                	je     80155c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801582:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801586:	75 07                	jne    80158f <strncmp+0x38>
		return 0;
  801588:	b8 00 00 00 00       	mov    $0x0,%eax
  80158d:	eb 14                	jmp    8015a3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	0f b6 d0             	movzbl %al,%edx
  801597:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	0f b6 c0             	movzbl %al,%eax
  80159f:	29 c2                	sub    %eax,%edx
  8015a1:	89 d0                	mov    %edx,%eax
}
  8015a3:	5d                   	pop    %ebp
  8015a4:	c3                   	ret    

008015a5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
  8015a8:	83 ec 04             	sub    $0x4,%esp
  8015ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015b1:	eb 12                	jmp    8015c5 <strchr+0x20>
		if (*s == c)
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	8a 00                	mov    (%eax),%al
  8015b8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015bb:	75 05                	jne    8015c2 <strchr+0x1d>
			return (char *) s;
  8015bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c0:	eb 11                	jmp    8015d3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015c2:	ff 45 08             	incl   0x8(%ebp)
  8015c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c8:	8a 00                	mov    (%eax),%al
  8015ca:	84 c0                	test   %al,%al
  8015cc:	75 e5                	jne    8015b3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
  8015d8:	83 ec 04             	sub    $0x4,%esp
  8015db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015de:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015e1:	eb 0d                	jmp    8015f0 <strfind+0x1b>
		if (*s == c)
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015eb:	74 0e                	je     8015fb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015ed:	ff 45 08             	incl   0x8(%ebp)
  8015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f3:	8a 00                	mov    (%eax),%al
  8015f5:	84 c0                	test   %al,%al
  8015f7:	75 ea                	jne    8015e3 <strfind+0xe>
  8015f9:	eb 01                	jmp    8015fc <strfind+0x27>
		if (*s == c)
			break;
  8015fb:	90                   	nop
	return (char *) s;
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
  801604:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80160d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801611:	76 63                	jbe    801676 <memset+0x75>
		uint64 data_block = c;
  801613:	8b 45 0c             	mov    0xc(%ebp),%eax
  801616:	99                   	cltd   
  801617:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80161a:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80161d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801620:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801623:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801627:	c1 e0 08             	shl    $0x8,%eax
  80162a:	09 45 f0             	or     %eax,-0x10(%ebp)
  80162d:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801630:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801633:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801636:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  80163a:	c1 e0 10             	shl    $0x10,%eax
  80163d:	09 45 f0             	or     %eax,-0x10(%ebp)
  801640:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801643:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801646:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801649:	89 c2                	mov    %eax,%edx
  80164b:	b8 00 00 00 00       	mov    $0x0,%eax
  801650:	09 45 f0             	or     %eax,-0x10(%ebp)
  801653:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801656:	eb 18                	jmp    801670 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801658:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80165b:	8d 41 08             	lea    0x8(%ecx),%eax
  80165e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801661:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801664:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801667:	89 01                	mov    %eax,(%ecx)
  801669:	89 51 04             	mov    %edx,0x4(%ecx)
  80166c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801670:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801674:	77 e2                	ja     801658 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801676:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80167a:	74 23                	je     80169f <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801682:	eb 0e                	jmp    801692 <memset+0x91>
			*p8++ = (uint8)c;
  801684:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801687:	8d 50 01             	lea    0x1(%eax),%edx
  80168a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80168d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801690:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801692:	8b 45 10             	mov    0x10(%ebp),%eax
  801695:	8d 50 ff             	lea    -0x1(%eax),%edx
  801698:	89 55 10             	mov    %edx,0x10(%ebp)
  80169b:	85 c0                	test   %eax,%eax
  80169d:	75 e5                	jne    801684 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
  8016a7:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8016aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8016b6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8016ba:	76 24                	jbe    8016e0 <memcpy+0x3c>
		while(n >= 8){
  8016bc:	eb 1c                	jmp    8016da <memcpy+0x36>
			*d64 = *s64;
  8016be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c1:	8b 50 04             	mov    0x4(%eax),%edx
  8016c4:	8b 00                	mov    (%eax),%eax
  8016c6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016c9:	89 01                	mov    %eax,(%ecx)
  8016cb:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8016ce:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8016d2:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8016d6:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8016da:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8016de:	77 de                	ja     8016be <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8016e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e4:	74 31                	je     801717 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8016e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8016ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8016f2:	eb 16                	jmp    80170a <memcpy+0x66>
			*d8++ = *s8++;
  8016f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f7:	8d 50 01             	lea    0x1(%eax),%edx
  8016fa:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8016fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801700:	8d 4a 01             	lea    0x1(%edx),%ecx
  801703:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801706:	8a 12                	mov    (%edx),%dl
  801708:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80170a:	8b 45 10             	mov    0x10(%ebp),%eax
  80170d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801710:	89 55 10             	mov    %edx,0x10(%ebp)
  801713:	85 c0                	test   %eax,%eax
  801715:	75 dd                	jne    8016f4 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
  80171f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801722:	8b 45 0c             	mov    0xc(%ebp),%eax
  801725:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801728:	8b 45 08             	mov    0x8(%ebp),%eax
  80172b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80172e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801731:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801734:	73 50                	jae    801786 <memmove+0x6a>
  801736:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801739:	8b 45 10             	mov    0x10(%ebp),%eax
  80173c:	01 d0                	add    %edx,%eax
  80173e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801741:	76 43                	jbe    801786 <memmove+0x6a>
		s += n;
  801743:	8b 45 10             	mov    0x10(%ebp),%eax
  801746:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801749:	8b 45 10             	mov    0x10(%ebp),%eax
  80174c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80174f:	eb 10                	jmp    801761 <memmove+0x45>
			*--d = *--s;
  801751:	ff 4d f8             	decl   -0x8(%ebp)
  801754:	ff 4d fc             	decl   -0x4(%ebp)
  801757:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80175a:	8a 10                	mov    (%eax),%dl
  80175c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801761:	8b 45 10             	mov    0x10(%ebp),%eax
  801764:	8d 50 ff             	lea    -0x1(%eax),%edx
  801767:	89 55 10             	mov    %edx,0x10(%ebp)
  80176a:	85 c0                	test   %eax,%eax
  80176c:	75 e3                	jne    801751 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80176e:	eb 23                	jmp    801793 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801770:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801773:	8d 50 01             	lea    0x1(%eax),%edx
  801776:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801779:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80177c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80177f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801782:	8a 12                	mov    (%edx),%dl
  801784:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801786:	8b 45 10             	mov    0x10(%ebp),%eax
  801789:	8d 50 ff             	lea    -0x1(%eax),%edx
  80178c:	89 55 10             	mov    %edx,0x10(%ebp)
  80178f:	85 c0                	test   %eax,%eax
  801791:	75 dd                	jne    801770 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
  80179b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80179e:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8017a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8017aa:	eb 2a                	jmp    8017d6 <memcmp+0x3e>
		if (*s1 != *s2)
  8017ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017af:	8a 10                	mov    (%eax),%dl
  8017b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b4:	8a 00                	mov    (%eax),%al
  8017b6:	38 c2                	cmp    %al,%dl
  8017b8:	74 16                	je     8017d0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017bd:	8a 00                	mov    (%eax),%al
  8017bf:	0f b6 d0             	movzbl %al,%edx
  8017c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	0f b6 c0             	movzbl %al,%eax
  8017ca:	29 c2                	sub    %eax,%edx
  8017cc:	89 d0                	mov    %edx,%eax
  8017ce:	eb 18                	jmp    8017e8 <memcmp+0x50>
		s1++, s2++;
  8017d0:	ff 45 fc             	incl   -0x4(%ebp)
  8017d3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8017df:	85 c0                	test   %eax,%eax
  8017e1:	75 c9                	jne    8017ac <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
  8017ed:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	01 d0                	add    %edx,%eax
  8017f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017fb:	eb 15                	jmp    801812 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	8a 00                	mov    (%eax),%al
  801802:	0f b6 d0             	movzbl %al,%edx
  801805:	8b 45 0c             	mov    0xc(%ebp),%eax
  801808:	0f b6 c0             	movzbl %al,%eax
  80180b:	39 c2                	cmp    %eax,%edx
  80180d:	74 0d                	je     80181c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80180f:	ff 45 08             	incl   0x8(%ebp)
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801818:	72 e3                	jb     8017fd <memfind+0x13>
  80181a:	eb 01                	jmp    80181d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80181c:	90                   	nop
	return (void *) s;
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801820:	c9                   	leave  
  801821:	c3                   	ret    

00801822 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801828:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80182f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801836:	eb 03                	jmp    80183b <strtol+0x19>
		s++;
  801838:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
  80183e:	8a 00                	mov    (%eax),%al
  801840:	3c 20                	cmp    $0x20,%al
  801842:	74 f4                	je     801838 <strtol+0x16>
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	8a 00                	mov    (%eax),%al
  801849:	3c 09                	cmp    $0x9,%al
  80184b:	74 eb                	je     801838 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80184d:	8b 45 08             	mov    0x8(%ebp),%eax
  801850:	8a 00                	mov    (%eax),%al
  801852:	3c 2b                	cmp    $0x2b,%al
  801854:	75 05                	jne    80185b <strtol+0x39>
		s++;
  801856:	ff 45 08             	incl   0x8(%ebp)
  801859:	eb 13                	jmp    80186e <strtol+0x4c>
	else if (*s == '-')
  80185b:	8b 45 08             	mov    0x8(%ebp),%eax
  80185e:	8a 00                	mov    (%eax),%al
  801860:	3c 2d                	cmp    $0x2d,%al
  801862:	75 0a                	jne    80186e <strtol+0x4c>
		s++, neg = 1;
  801864:	ff 45 08             	incl   0x8(%ebp)
  801867:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80186e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801872:	74 06                	je     80187a <strtol+0x58>
  801874:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801878:	75 20                	jne    80189a <strtol+0x78>
  80187a:	8b 45 08             	mov    0x8(%ebp),%eax
  80187d:	8a 00                	mov    (%eax),%al
  80187f:	3c 30                	cmp    $0x30,%al
  801881:	75 17                	jne    80189a <strtol+0x78>
  801883:	8b 45 08             	mov    0x8(%ebp),%eax
  801886:	40                   	inc    %eax
  801887:	8a 00                	mov    (%eax),%al
  801889:	3c 78                	cmp    $0x78,%al
  80188b:	75 0d                	jne    80189a <strtol+0x78>
		s += 2, base = 16;
  80188d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801891:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801898:	eb 28                	jmp    8018c2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80189a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80189e:	75 15                	jne    8018b5 <strtol+0x93>
  8018a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a3:	8a 00                	mov    (%eax),%al
  8018a5:	3c 30                	cmp    $0x30,%al
  8018a7:	75 0c                	jne    8018b5 <strtol+0x93>
		s++, base = 8;
  8018a9:	ff 45 08             	incl   0x8(%ebp)
  8018ac:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8018b3:	eb 0d                	jmp    8018c2 <strtol+0xa0>
	else if (base == 0)
  8018b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018b9:	75 07                	jne    8018c2 <strtol+0xa0>
		base = 10;
  8018bb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c5:	8a 00                	mov    (%eax),%al
  8018c7:	3c 2f                	cmp    $0x2f,%al
  8018c9:	7e 19                	jle    8018e4 <strtol+0xc2>
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	8a 00                	mov    (%eax),%al
  8018d0:	3c 39                	cmp    $0x39,%al
  8018d2:	7f 10                	jg     8018e4 <strtol+0xc2>
			dig = *s - '0';
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	8a 00                	mov    (%eax),%al
  8018d9:	0f be c0             	movsbl %al,%eax
  8018dc:	83 e8 30             	sub    $0x30,%eax
  8018df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018e2:	eb 42                	jmp    801926 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e7:	8a 00                	mov    (%eax),%al
  8018e9:	3c 60                	cmp    $0x60,%al
  8018eb:	7e 19                	jle    801906 <strtol+0xe4>
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	8a 00                	mov    (%eax),%al
  8018f2:	3c 7a                	cmp    $0x7a,%al
  8018f4:	7f 10                	jg     801906 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	8a 00                	mov    (%eax),%al
  8018fb:	0f be c0             	movsbl %al,%eax
  8018fe:	83 e8 57             	sub    $0x57,%eax
  801901:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801904:	eb 20                	jmp    801926 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	8a 00                	mov    (%eax),%al
  80190b:	3c 40                	cmp    $0x40,%al
  80190d:	7e 39                	jle    801948 <strtol+0x126>
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	8a 00                	mov    (%eax),%al
  801914:	3c 5a                	cmp    $0x5a,%al
  801916:	7f 30                	jg     801948 <strtol+0x126>
			dig = *s - 'A' + 10;
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	0f be c0             	movsbl %al,%eax
  801920:	83 e8 37             	sub    $0x37,%eax
  801923:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801926:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801929:	3b 45 10             	cmp    0x10(%ebp),%eax
  80192c:	7d 19                	jge    801947 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80192e:	ff 45 08             	incl   0x8(%ebp)
  801931:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801934:	0f af 45 10          	imul   0x10(%ebp),%eax
  801938:	89 c2                	mov    %eax,%edx
  80193a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80193d:	01 d0                	add    %edx,%eax
  80193f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801942:	e9 7b ff ff ff       	jmp    8018c2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801947:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801948:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80194c:	74 08                	je     801956 <strtol+0x134>
		*endptr = (char *) s;
  80194e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801951:	8b 55 08             	mov    0x8(%ebp),%edx
  801954:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801956:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80195a:	74 07                	je     801963 <strtol+0x141>
  80195c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195f:	f7 d8                	neg    %eax
  801961:	eb 03                	jmp    801966 <strtol+0x144>
  801963:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <ltostr>:

void
ltostr(long value, char *str)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
  80196b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80196e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801975:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80197c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801980:	79 13                	jns    801995 <ltostr+0x2d>
	{
		neg = 1;
  801982:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801989:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80198f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801992:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801995:	8b 45 08             	mov    0x8(%ebp),%eax
  801998:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80199d:	99                   	cltd   
  80199e:	f7 f9                	idiv   %ecx
  8019a0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8019a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a6:	8d 50 01             	lea    0x1(%eax),%edx
  8019a9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019ac:	89 c2                	mov    %eax,%edx
  8019ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b1:	01 d0                	add    %edx,%eax
  8019b3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019b6:	83 c2 30             	add    $0x30,%edx
  8019b9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019be:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019c3:	f7 e9                	imul   %ecx
  8019c5:	c1 fa 02             	sar    $0x2,%edx
  8019c8:	89 c8                	mov    %ecx,%eax
  8019ca:	c1 f8 1f             	sar    $0x1f,%eax
  8019cd:	29 c2                	sub    %eax,%edx
  8019cf:	89 d0                	mov    %edx,%eax
  8019d1:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8019d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019d8:	75 bb                	jne    801995 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019e4:	48                   	dec    %eax
  8019e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019ec:	74 3d                	je     801a2b <ltostr+0xc3>
		start = 1 ;
  8019ee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8019f5:	eb 34                	jmp    801a2b <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8019f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fd:	01 d0                	add    %edx,%eax
  8019ff:	8a 00                	mov    (%eax),%al
  801a01:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a04:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a07:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0a:	01 c2                	add    %eax,%edx
  801a0c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a12:	01 c8                	add    %ecx,%eax
  801a14:	8a 00                	mov    (%eax),%al
  801a16:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a18:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1e:	01 c2                	add    %eax,%edx
  801a20:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a23:	88 02                	mov    %al,(%edx)
		start++ ;
  801a25:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a28:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a2e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a31:	7c c4                	jl     8019f7 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a33:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a39:	01 d0                	add    %edx,%eax
  801a3b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a3e:	90                   	nop
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
  801a44:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a47:	ff 75 08             	pushl  0x8(%ebp)
  801a4a:	e8 c4 f9 ff ff       	call   801413 <strlen>
  801a4f:	83 c4 04             	add    $0x4,%esp
  801a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a55:	ff 75 0c             	pushl  0xc(%ebp)
  801a58:	e8 b6 f9 ff ff       	call   801413 <strlen>
  801a5d:	83 c4 04             	add    $0x4,%esp
  801a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a71:	eb 17                	jmp    801a8a <strcconcat+0x49>
		final[s] = str1[s] ;
  801a73:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a76:	8b 45 10             	mov    0x10(%ebp),%eax
  801a79:	01 c2                	add    %eax,%edx
  801a7b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	01 c8                	add    %ecx,%eax
  801a83:	8a 00                	mov    (%eax),%al
  801a85:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a87:	ff 45 fc             	incl   -0x4(%ebp)
  801a8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a8d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a90:	7c e1                	jl     801a73 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a99:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801aa0:	eb 1f                	jmp    801ac1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801aa2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa5:	8d 50 01             	lea    0x1(%eax),%edx
  801aa8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801aab:	89 c2                	mov    %eax,%edx
  801aad:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab0:	01 c2                	add    %eax,%edx
  801ab2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab8:	01 c8                	add    %ecx,%eax
  801aba:	8a 00                	mov    (%eax),%al
  801abc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801abe:	ff 45 f8             	incl   -0x8(%ebp)
  801ac1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ac4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ac7:	7c d9                	jl     801aa2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ac9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801acc:	8b 45 10             	mov    0x10(%ebp),%eax
  801acf:	01 d0                	add    %edx,%eax
  801ad1:	c6 00 00             	movb   $0x0,(%eax)
}
  801ad4:	90                   	nop
  801ad5:	c9                   	leave  
  801ad6:	c3                   	ret    

00801ad7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ada:	8b 45 14             	mov    0x14(%ebp),%eax
  801add:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ae3:	8b 45 14             	mov    0x14(%ebp),%eax
  801ae6:	8b 00                	mov    (%eax),%eax
  801ae8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aef:	8b 45 10             	mov    0x10(%ebp),%eax
  801af2:	01 d0                	add    %edx,%eax
  801af4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801afa:	eb 0c                	jmp    801b08 <strsplit+0x31>
			*string++ = 0;
  801afc:	8b 45 08             	mov    0x8(%ebp),%eax
  801aff:	8d 50 01             	lea    0x1(%eax),%edx
  801b02:	89 55 08             	mov    %edx,0x8(%ebp)
  801b05:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b08:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0b:	8a 00                	mov    (%eax),%al
  801b0d:	84 c0                	test   %al,%al
  801b0f:	74 18                	je     801b29 <strsplit+0x52>
  801b11:	8b 45 08             	mov    0x8(%ebp),%eax
  801b14:	8a 00                	mov    (%eax),%al
  801b16:	0f be c0             	movsbl %al,%eax
  801b19:	50                   	push   %eax
  801b1a:	ff 75 0c             	pushl  0xc(%ebp)
  801b1d:	e8 83 fa ff ff       	call   8015a5 <strchr>
  801b22:	83 c4 08             	add    $0x8,%esp
  801b25:	85 c0                	test   %eax,%eax
  801b27:	75 d3                	jne    801afc <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b29:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2c:	8a 00                	mov    (%eax),%al
  801b2e:	84 c0                	test   %al,%al
  801b30:	74 5a                	je     801b8c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b32:	8b 45 14             	mov    0x14(%ebp),%eax
  801b35:	8b 00                	mov    (%eax),%eax
  801b37:	83 f8 0f             	cmp    $0xf,%eax
  801b3a:	75 07                	jne    801b43 <strsplit+0x6c>
		{
			return 0;
  801b3c:	b8 00 00 00 00       	mov    $0x0,%eax
  801b41:	eb 66                	jmp    801ba9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b43:	8b 45 14             	mov    0x14(%ebp),%eax
  801b46:	8b 00                	mov    (%eax),%eax
  801b48:	8d 48 01             	lea    0x1(%eax),%ecx
  801b4b:	8b 55 14             	mov    0x14(%ebp),%edx
  801b4e:	89 0a                	mov    %ecx,(%edx)
  801b50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b57:	8b 45 10             	mov    0x10(%ebp),%eax
  801b5a:	01 c2                	add    %eax,%edx
  801b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b61:	eb 03                	jmp    801b66 <strsplit+0x8f>
			string++;
  801b63:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b66:	8b 45 08             	mov    0x8(%ebp),%eax
  801b69:	8a 00                	mov    (%eax),%al
  801b6b:	84 c0                	test   %al,%al
  801b6d:	74 8b                	je     801afa <strsplit+0x23>
  801b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b72:	8a 00                	mov    (%eax),%al
  801b74:	0f be c0             	movsbl %al,%eax
  801b77:	50                   	push   %eax
  801b78:	ff 75 0c             	pushl  0xc(%ebp)
  801b7b:	e8 25 fa ff ff       	call   8015a5 <strchr>
  801b80:	83 c4 08             	add    $0x8,%esp
  801b83:	85 c0                	test   %eax,%eax
  801b85:	74 dc                	je     801b63 <strsplit+0x8c>
			string++;
	}
  801b87:	e9 6e ff ff ff       	jmp    801afa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b8c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b8d:	8b 45 14             	mov    0x14(%ebp),%eax
  801b90:	8b 00                	mov    (%eax),%eax
  801b92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b99:	8b 45 10             	mov    0x10(%ebp),%eax
  801b9c:	01 d0                	add    %edx,%eax
  801b9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ba4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
  801bae:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801bb7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bbe:	eb 4a                	jmp    801c0a <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801bc0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	01 c2                	add    %eax,%edx
  801bc8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bce:	01 c8                	add    %ecx,%eax
  801bd0:	8a 00                	mov    (%eax),%al
  801bd2:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801bd4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bda:	01 d0                	add    %edx,%eax
  801bdc:	8a 00                	mov    (%eax),%al
  801bde:	3c 40                	cmp    $0x40,%al
  801be0:	7e 25                	jle    801c07 <str2lower+0x5c>
  801be2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be8:	01 d0                	add    %edx,%eax
  801bea:	8a 00                	mov    (%eax),%al
  801bec:	3c 5a                	cmp    $0x5a,%al
  801bee:	7f 17                	jg     801c07 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801bf0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	01 d0                	add    %edx,%eax
  801bf8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bfb:	8b 55 08             	mov    0x8(%ebp),%edx
  801bfe:	01 ca                	add    %ecx,%edx
  801c00:	8a 12                	mov    (%edx),%dl
  801c02:	83 c2 20             	add    $0x20,%edx
  801c05:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801c07:	ff 45 fc             	incl   -0x4(%ebp)
  801c0a:	ff 75 0c             	pushl  0xc(%ebp)
  801c0d:	e8 01 f8 ff ff       	call   801413 <strlen>
  801c12:	83 c4 04             	add    $0x4,%esp
  801c15:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801c18:	7f a6                	jg     801bc0 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801c1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c1d:	c9                   	leave  
  801c1e:	c3                   	ret    

00801c1f <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801c1f:	55                   	push   %ebp
  801c20:	89 e5                	mov    %esp,%ebp
  801c22:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801c25:	a1 08 40 80 00       	mov    0x804008,%eax
  801c2a:	85 c0                	test   %eax,%eax
  801c2c:	74 2d                	je     801c5b <uheap_init+0x3c>
	{
		buddy_init();
  801c2e:	e8 87 06 00 00       	call   8022ba <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801c33:	e8 31 05 00 00       	call   802169 <sys_get_uheap_strategy>
  801c38:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801c3d:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801c44:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801c47:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801c4e:	00 00 80 
		__firstTimeFlag = 0;
  801c51:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801c58:	00 00 00 
	}
}
  801c5b:	90                   	nop
  801c5c:	c9                   	leave  
  801c5d:	c3                   	ret    

00801c5e <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801c5e:	55                   	push   %ebp
  801c5f:	89 e5                	mov    %esp,%ebp
  801c61:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801c64:	83 ec 04             	sub    $0x4,%esp
  801c67:	68 fc 2e 80 00       	push   $0x802efc
  801c6c:	6a 25                	push   $0x25
  801c6e:	68 2d 2f 80 00       	push   $0x802f2d
  801c73:	e8 ec eb ff ff       	call   800864 <_panic>

00801c78 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801c78:	55                   	push   %ebp
  801c79:	89 e5                	mov    %esp,%ebp
  801c7b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801c7e:	83 ec 04             	sub    $0x4,%esp
  801c81:	68 3c 2f 80 00       	push   $0x802f3c
  801c86:	6a 2f                	push   $0x2f
  801c88:	68 2d 2f 80 00       	push   $0x802f2d
  801c8d:	e8 d2 eb ff ff       	call   800864 <_panic>

00801c92 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801c92:	55                   	push   %ebp
  801c93:	89 e5                	mov    %esp,%ebp
  801c95:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801c98:	e8 82 ff ff ff       	call   801c1f <uheap_init>
	if (size == 0) return NULL ;
  801c9d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ca1:	75 07                	jne    801caa <malloc+0x18>
  801ca3:	b8 00 00 00 00       	mov    $0x0,%eax
  801ca8:	eb 14                	jmp    801cbe <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801caa:	83 ec 04             	sub    $0x4,%esp
  801cad:	68 70 2f 80 00       	push   $0x802f70
  801cb2:	6a 43                	push   $0x43
  801cb4:	68 2d 2f 80 00       	push   $0x802f2d
  801cb9:	e8 a6 eb ff ff       	call   800864 <_panic>
}
  801cbe:	c9                   	leave  
  801cbf:	c3                   	ret    

00801cc0 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
  801cc3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801cc6:	83 ec 04             	sub    $0x4,%esp
  801cc9:	68 98 2f 80 00       	push   $0x802f98
  801cce:	6a 4e                	push   $0x4e
  801cd0:	68 2d 2f 80 00       	push   $0x802f2d
  801cd5:	e8 8a eb ff ff       	call   800864 <_panic>

00801cda <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
  801cdd:	83 ec 18             	sub    $0x18,%esp
  801ce0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce3:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ce6:	e8 34 ff ff ff       	call   801c1f <uheap_init>
	if (size == 0) return NULL ;
  801ceb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cef:	75 07                	jne    801cf8 <smalloc+0x1e>
  801cf1:	b8 00 00 00 00       	mov    $0x0,%eax
  801cf6:	eb 14                	jmp    801d0c <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801cf8:	83 ec 04             	sub    $0x4,%esp
  801cfb:	68 bc 2f 80 00       	push   $0x802fbc
  801d00:	6a 5f                	push   $0x5f
  801d02:	68 2d 2f 80 00       	push   $0x802f2d
  801d07:	e8 58 eb ff ff       	call   800864 <_panic>
}
  801d0c:	c9                   	leave  
  801d0d:	c3                   	ret    

00801d0e <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d0e:	55                   	push   %ebp
  801d0f:	89 e5                	mov    %esp,%ebp
  801d11:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801d14:	e8 06 ff ff ff       	call   801c1f <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801d19:	83 ec 04             	sub    $0x4,%esp
  801d1c:	68 e4 2f 80 00       	push   $0x802fe4
  801d21:	6a 6f                	push   $0x6f
  801d23:	68 2d 2f 80 00       	push   $0x802f2d
  801d28:	e8 37 eb ff ff       	call   800864 <_panic>

00801d2d <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801d2d:	55                   	push   %ebp
  801d2e:	89 e5                	mov    %esp,%ebp
  801d30:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801d33:	83 ec 04             	sub    $0x4,%esp
  801d36:	68 08 30 80 00       	push   $0x803008
  801d3b:	6a 7e                	push   $0x7e
  801d3d:	68 2d 2f 80 00       	push   $0x802f2d
  801d42:	e8 1d eb ff ff       	call   800864 <_panic>

00801d47 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d47:	55                   	push   %ebp
  801d48:	89 e5                	mov    %esp,%ebp
  801d4a:	57                   	push   %edi
  801d4b:	56                   	push   %esi
  801d4c:	53                   	push   %ebx
  801d4d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d50:	8b 45 08             	mov    0x8(%ebp),%eax
  801d53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d56:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d59:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d5c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d5f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d62:	cd 30                	int    $0x30
  801d64:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d6a:	83 c4 10             	add    $0x10,%esp
  801d6d:	5b                   	pop    %ebx
  801d6e:	5e                   	pop    %esi
  801d6f:	5f                   	pop    %edi
  801d70:	5d                   	pop    %ebp
  801d71:	c3                   	ret    

00801d72 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
  801d75:	83 ec 04             	sub    $0x4,%esp
  801d78:	8b 45 10             	mov    0x10(%ebp),%eax
  801d7b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801d7e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d81:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d85:	8b 45 08             	mov    0x8(%ebp),%eax
  801d88:	6a 00                	push   $0x0
  801d8a:	51                   	push   %ecx
  801d8b:	52                   	push   %edx
  801d8c:	ff 75 0c             	pushl  0xc(%ebp)
  801d8f:	50                   	push   %eax
  801d90:	6a 00                	push   $0x0
  801d92:	e8 b0 ff ff ff       	call   801d47 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
}
  801d9a:	90                   	nop
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_cgetc>:

int
sys_cgetc(void)
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 02                	push   $0x2
  801dac:	e8 96 ff ff ff       	call   801d47 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 03                	push   $0x3
  801dc5:	e8 7d ff ff ff       	call   801d47 <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
}
  801dcd:	90                   	nop
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 04                	push   $0x4
  801ddf:	e8 63 ff ff ff       	call   801d47 <syscall>
  801de4:	83 c4 18             	add    $0x18,%esp
}
  801de7:	90                   	nop
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ded:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df0:	8b 45 08             	mov    0x8(%ebp),%eax
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	52                   	push   %edx
  801dfa:	50                   	push   %eax
  801dfb:	6a 08                	push   $0x8
  801dfd:	e8 45 ff ff ff       	call   801d47 <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
}
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
  801e0a:	56                   	push   %esi
  801e0b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e0c:	8b 75 18             	mov    0x18(%ebp),%esi
  801e0f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e12:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	56                   	push   %esi
  801e1c:	53                   	push   %ebx
  801e1d:	51                   	push   %ecx
  801e1e:	52                   	push   %edx
  801e1f:	50                   	push   %eax
  801e20:	6a 09                	push   $0x9
  801e22:	e8 20 ff ff ff       	call   801d47 <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e2d:	5b                   	pop    %ebx
  801e2e:	5e                   	pop    %esi
  801e2f:	5d                   	pop    %ebp
  801e30:	c3                   	ret    

00801e31 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	ff 75 08             	pushl  0x8(%ebp)
  801e3f:	6a 0a                	push   $0xa
  801e41:	e8 01 ff ff ff       	call   801d47 <syscall>
  801e46:	83 c4 18             	add    $0x18,%esp
}
  801e49:	c9                   	leave  
  801e4a:	c3                   	ret    

00801e4b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e4b:	55                   	push   %ebp
  801e4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	ff 75 0c             	pushl  0xc(%ebp)
  801e57:	ff 75 08             	pushl  0x8(%ebp)
  801e5a:	6a 0b                	push   $0xb
  801e5c:	e8 e6 fe ff ff       	call   801d47 <syscall>
  801e61:	83 c4 18             	add    $0x18,%esp
}
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 0c                	push   $0xc
  801e75:	e8 cd fe ff ff       	call   801d47 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	c9                   	leave  
  801e7e:	c3                   	ret    

00801e7f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e7f:	55                   	push   %ebp
  801e80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 0d                	push   $0xd
  801e8e:	e8 b4 fe ff ff       	call   801d47 <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
}
  801e96:	c9                   	leave  
  801e97:	c3                   	ret    

00801e98 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e98:	55                   	push   %ebp
  801e99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 0e                	push   $0xe
  801ea7:	e8 9b fe ff ff       	call   801d47 <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 0f                	push   $0xf
  801ec0:	e8 82 fe ff ff       	call   801d47 <syscall>
  801ec5:	83 c4 18             	add    $0x18,%esp
}
  801ec8:	c9                   	leave  
  801ec9:	c3                   	ret    

00801eca <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801eca:	55                   	push   %ebp
  801ecb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	ff 75 08             	pushl  0x8(%ebp)
  801ed8:	6a 10                	push   $0x10
  801eda:	e8 68 fe ff ff       	call   801d47 <syscall>
  801edf:	83 c4 18             	add    $0x18,%esp
}
  801ee2:	c9                   	leave  
  801ee3:	c3                   	ret    

00801ee4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ee4:	55                   	push   %ebp
  801ee5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 11                	push   $0x11
  801ef3:	e8 4f fe ff ff       	call   801d47 <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	90                   	nop
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_cputc>:

void
sys_cputc(const char c)
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
  801f01:	83 ec 04             	sub    $0x4,%esp
  801f04:	8b 45 08             	mov    0x8(%ebp),%eax
  801f07:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f0a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	50                   	push   %eax
  801f17:	6a 01                	push   $0x1
  801f19:	e8 29 fe ff ff       	call   801d47 <syscall>
  801f1e:	83 c4 18             	add    $0x18,%esp
}
  801f21:	90                   	nop
  801f22:	c9                   	leave  
  801f23:	c3                   	ret    

00801f24 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f24:	55                   	push   %ebp
  801f25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 14                	push   $0x14
  801f33:	e8 0f fe ff ff       	call   801d47 <syscall>
  801f38:	83 c4 18             	add    $0x18,%esp
}
  801f3b:	90                   	nop
  801f3c:	c9                   	leave  
  801f3d:	c3                   	ret    

00801f3e <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801f3e:	55                   	push   %ebp
  801f3f:	89 e5                	mov    %esp,%ebp
  801f41:	83 ec 04             	sub    $0x4,%esp
  801f44:	8b 45 10             	mov    0x10(%ebp),%eax
  801f47:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801f4a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f4d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f51:	8b 45 08             	mov    0x8(%ebp),%eax
  801f54:	6a 00                	push   $0x0
  801f56:	51                   	push   %ecx
  801f57:	52                   	push   %edx
  801f58:	ff 75 0c             	pushl  0xc(%ebp)
  801f5b:	50                   	push   %eax
  801f5c:	6a 15                	push   $0x15
  801f5e:	e8 e4 fd ff ff       	call   801d47 <syscall>
  801f63:	83 c4 18             	add    $0x18,%esp
}
  801f66:	c9                   	leave  
  801f67:	c3                   	ret    

00801f68 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801f68:	55                   	push   %ebp
  801f69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801f6b:	8b 55 10             	mov    0x10(%ebp),%edx
  801f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	52                   	push   %edx
  801f76:	50                   	push   %eax
  801f77:	ff 75 08             	pushl  0x8(%ebp)
  801f7a:	6a 16                	push   $0x16
  801f7c:	e8 c6 fd ff ff       	call   801d47 <syscall>
  801f81:	83 c4 18             	add    $0x18,%esp
}
  801f84:	c9                   	leave  
  801f85:	c3                   	ret    

00801f86 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801f86:	55                   	push   %ebp
  801f87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801f89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	52                   	push   %edx
  801f96:	50                   	push   %eax
  801f97:	6a 17                	push   $0x17
  801f99:	e8 a9 fd ff ff       	call   801d47 <syscall>
  801f9e:	83 c4 18             	add    $0x18,%esp
}
  801fa1:	c9                   	leave  
  801fa2:	c3                   	ret    

00801fa3 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801fa3:	55                   	push   %ebp
  801fa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801fa6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	52                   	push   %edx
  801fb3:	50                   	push   %eax
  801fb4:	6a 18                	push   $0x18
  801fb6:	e8 8c fd ff ff       	call   801d47 <syscall>
  801fbb:	83 c4 18             	add    $0x18,%esp
}
  801fbe:	c9                   	leave  
  801fbf:	c3                   	ret    

00801fc0 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fc0:	55                   	push   %ebp
  801fc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc6:	6a 00                	push   $0x0
  801fc8:	ff 75 14             	pushl  0x14(%ebp)
  801fcb:	ff 75 10             	pushl  0x10(%ebp)
  801fce:	ff 75 0c             	pushl  0xc(%ebp)
  801fd1:	50                   	push   %eax
  801fd2:	6a 19                	push   $0x19
  801fd4:	e8 6e fd ff ff       	call   801d47 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <sys_run_env>:

void sys_run_env(int32 envId)
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	50                   	push   %eax
  801fed:	6a 1a                	push   $0x1a
  801fef:	e8 53 fd ff ff       	call   801d47 <syscall>
  801ff4:	83 c4 18             	add    $0x18,%esp
}
  801ff7:	90                   	nop
  801ff8:	c9                   	leave  
  801ff9:	c3                   	ret    

00801ffa <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	50                   	push   %eax
  802009:	6a 1b                	push   $0x1b
  80200b:	e8 37 fd ff ff       	call   801d47 <syscall>
  802010:	83 c4 18             	add    $0x18,%esp
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 05                	push   $0x5
  802024:	e8 1e fd ff ff       	call   801d47 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
}
  80202c:	c9                   	leave  
  80202d:	c3                   	ret    

0080202e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 06                	push   $0x6
  80203d:	e8 05 fd ff ff       	call   801d47 <syscall>
  802042:	83 c4 18             	add    $0x18,%esp
}
  802045:	c9                   	leave  
  802046:	c3                   	ret    

00802047 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 07                	push   $0x7
  802056:	e8 ec fc ff ff       	call   801d47 <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
}
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <sys_exit_env>:


void sys_exit_env(void)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 1c                	push   $0x1c
  80206f:	e8 d3 fc ff ff       	call   801d47 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
}
  802077:	90                   	nop
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	ff 75 10             	pushl  0x10(%ebp)
  802084:	ff 75 0c             	pushl  0xc(%ebp)
  802087:	ff 75 08             	pushl  0x8(%ebp)
  80208a:	6a 13                	push   $0x13
  80208c:	e8 b6 fc ff ff       	call   801d47 <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
	return ;
  802094:	90                   	nop
}
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <sys_rcr2>:
uint32 sys_rcr2()
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 1e                	push   $0x1e
  8020a6:	e8 9c fc ff ff       	call   801d47 <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	c9                   	leave  
  8020af:	c3                   	ret    

008020b0 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
  8020b3:	83 ec 04             	sub    $0x4,%esp
  8020b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020bc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	50                   	push   %eax
  8020c9:	6a 1f                	push   $0x1f
  8020cb:	e8 77 fc ff ff       	call   801d47 <syscall>
  8020d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d3:	90                   	nop
}
  8020d4:	c9                   	leave  
  8020d5:	c3                   	ret    

008020d6 <rsttst>:
void rsttst()
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 21                	push   $0x21
  8020e5:	e8 5d fc ff ff       	call   801d47 <syscall>
  8020ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ed:	90                   	nop
}
  8020ee:	c9                   	leave  
  8020ef:	c3                   	ret    

008020f0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020f0:	55                   	push   %ebp
  8020f1:	89 e5                	mov    %esp,%ebp
  8020f3:	83 ec 04             	sub    $0x4,%esp
  8020f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8020f9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020fc:	8b 55 18             	mov    0x18(%ebp),%edx
  8020ff:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802103:	52                   	push   %edx
  802104:	50                   	push   %eax
  802105:	ff 75 10             	pushl  0x10(%ebp)
  802108:	ff 75 0c             	pushl  0xc(%ebp)
  80210b:	ff 75 08             	pushl  0x8(%ebp)
  80210e:	6a 20                	push   $0x20
  802110:	e8 32 fc ff ff       	call   801d47 <syscall>
  802115:	83 c4 18             	add    $0x18,%esp
	return ;
  802118:	90                   	nop
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <chktst>:
void chktst(uint32 n)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	ff 75 08             	pushl  0x8(%ebp)
  802129:	6a 22                	push   $0x22
  80212b:	e8 17 fc ff ff       	call   801d47 <syscall>
  802130:	83 c4 18             	add    $0x18,%esp
	return ;
  802133:	90                   	nop
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <inctst>:

void inctst()
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 23                	push   $0x23
  802145:	e8 fd fb ff ff       	call   801d47 <syscall>
  80214a:	83 c4 18             	add    $0x18,%esp
	return ;
  80214d:	90                   	nop
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <gettst>:
uint32 gettst()
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 24                	push   $0x24
  80215f:	e8 e3 fb ff ff       	call   801d47 <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	c9                   	leave  
  802168:	c3                   	ret    

00802169 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802169:	55                   	push   %ebp
  80216a:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 25                	push   $0x25
  802178:	e8 ca fb ff ff       	call   801d47 <syscall>
  80217d:	83 c4 18             	add    $0x18,%esp
  802180:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  802185:	a1 48 40 80 00       	mov    0x804048,%eax
}
  80218a:	c9                   	leave  
  80218b:	c3                   	ret    

0080218c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80218c:	55                   	push   %ebp
  80218d:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80218f:	8b 45 08             	mov    0x8(%ebp),%eax
  802192:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	ff 75 08             	pushl  0x8(%ebp)
  8021a2:	6a 26                	push   $0x26
  8021a4:	e8 9e fb ff ff       	call   801d47 <syscall>
  8021a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ac:	90                   	nop
}
  8021ad:	c9                   	leave  
  8021ae:	c3                   	ret    

008021af <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021af:	55                   	push   %ebp
  8021b0:	89 e5                	mov    %esp,%ebp
  8021b2:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021b3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bf:	6a 00                	push   $0x0
  8021c1:	53                   	push   %ebx
  8021c2:	51                   	push   %ecx
  8021c3:	52                   	push   %edx
  8021c4:	50                   	push   %eax
  8021c5:	6a 27                	push   $0x27
  8021c7:	e8 7b fb ff ff       	call   801d47 <syscall>
  8021cc:	83 c4 18             	add    $0x18,%esp
}
  8021cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021da:	8b 45 08             	mov    0x8(%ebp),%eax
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	52                   	push   %edx
  8021e4:	50                   	push   %eax
  8021e5:	6a 28                	push   $0x28
  8021e7:	e8 5b fb ff ff       	call   801d47 <syscall>
  8021ec:	83 c4 18             	add    $0x18,%esp
}
  8021ef:	c9                   	leave  
  8021f0:	c3                   	ret    

008021f1 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8021f1:	55                   	push   %ebp
  8021f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8021f4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8021f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fd:	6a 00                	push   $0x0
  8021ff:	51                   	push   %ecx
  802200:	ff 75 10             	pushl  0x10(%ebp)
  802203:	52                   	push   %edx
  802204:	50                   	push   %eax
  802205:	6a 29                	push   $0x29
  802207:	e8 3b fb ff ff       	call   801d47 <syscall>
  80220c:	83 c4 18             	add    $0x18,%esp
}
  80220f:	c9                   	leave  
  802210:	c3                   	ret    

00802211 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802211:	55                   	push   %ebp
  802212:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	ff 75 10             	pushl  0x10(%ebp)
  80221b:	ff 75 0c             	pushl  0xc(%ebp)
  80221e:	ff 75 08             	pushl  0x8(%ebp)
  802221:	6a 12                	push   $0x12
  802223:	e8 1f fb ff ff       	call   801d47 <syscall>
  802228:	83 c4 18             	add    $0x18,%esp
	return ;
  80222b:	90                   	nop
}
  80222c:	c9                   	leave  
  80222d:	c3                   	ret    

0080222e <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80222e:	55                   	push   %ebp
  80222f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802231:	8b 55 0c             	mov    0xc(%ebp),%edx
  802234:	8b 45 08             	mov    0x8(%ebp),%eax
  802237:	6a 00                	push   $0x0
  802239:	6a 00                	push   $0x0
  80223b:	6a 00                	push   $0x0
  80223d:	52                   	push   %edx
  80223e:	50                   	push   %eax
  80223f:	6a 2a                	push   $0x2a
  802241:	e8 01 fb ff ff       	call   801d47 <syscall>
  802246:	83 c4 18             	add    $0x18,%esp
	return;
  802249:	90                   	nop
}
  80224a:	c9                   	leave  
  80224b:	c3                   	ret    

0080224c <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80224c:	55                   	push   %ebp
  80224d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80224f:	6a 00                	push   $0x0
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	6a 00                	push   $0x0
  802259:	6a 2b                	push   $0x2b
  80225b:	e8 e7 fa ff ff       	call   801d47 <syscall>
  802260:	83 c4 18             	add    $0x18,%esp
}
  802263:	c9                   	leave  
  802264:	c3                   	ret    

00802265 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802265:	55                   	push   %ebp
  802266:	89 e5                	mov    %esp,%ebp
  802268:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80226b:	83 ec 04             	sub    $0x4,%esp
  80226e:	68 2c 30 80 00       	push   $0x80302c
  802273:	68 0a 01 00 00       	push   $0x10a
  802278:	68 3c 30 80 00       	push   $0x80303c
  80227d:	e8 e2 e5 ff ff       	call   800864 <_panic>

00802282 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  802282:	55                   	push   %ebp
  802283:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802285:	6a 00                	push   $0x0
  802287:	6a 00                	push   $0x0
  802289:	6a 00                	push   $0x0
  80228b:	ff 75 0c             	pushl  0xc(%ebp)
  80228e:	ff 75 08             	pushl  0x8(%ebp)
  802291:	6a 33                	push   $0x33
  802293:	e8 af fa ff ff       	call   801d47 <syscall>
  802298:	83 c4 18             	add    $0x18,%esp
	return;
  80229b:	90                   	nop
}
  80229c:	c9                   	leave  
  80229d:	c3                   	ret    

0080229e <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80229e:	55                   	push   %ebp
  80229f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8022a1:	6a 00                	push   $0x0
  8022a3:	6a 00                	push   $0x0
  8022a5:	6a 00                	push   $0x0
  8022a7:	ff 75 0c             	pushl  0xc(%ebp)
  8022aa:	ff 75 08             	pushl  0x8(%ebp)
  8022ad:	6a 34                	push   $0x34
  8022af:	e8 93 fa ff ff       	call   801d47 <syscall>
  8022b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b7:	90                   	nop
}
  8022b8:	c9                   	leave  
  8022b9:	c3                   	ret    

008022ba <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8022ba:	55                   	push   %ebp
  8022bb:	89 e5                	mov    %esp,%ebp
  8022bd:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8022c0:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8022c7:	eb 36                	jmp    8022ff <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8022c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022cc:	c1 e0 04             	shl    $0x4,%eax
  8022cf:	05 60 40 80 00       	add    $0x804060,%eax
  8022d4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8022da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022dd:	c1 e0 04             	shl    $0x4,%eax
  8022e0:	05 64 40 80 00       	add    $0x804064,%eax
  8022e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8022eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022ee:	c1 e0 04             	shl    $0x4,%eax
  8022f1:	05 6c 40 80 00       	add    $0x80406c,%eax
  8022f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8022fc:	ff 45 fc             	incl   -0x4(%ebp)
  8022ff:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  802303:	7e c4                	jle    8022c9 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  802305:	90                   	nop
  802306:	c9                   	leave  
  802307:	c3                   	ret    

00802308 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802308:	55                   	push   %ebp
  802309:	89 e5                	mov    %esp,%ebp
  80230b:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  80230e:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  802315:	eb 24                	jmp    80233b <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802317:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80231a:	c1 e0 04             	shl    $0x4,%eax
  80231d:	05 6c 40 80 00       	add    $0x80406c,%eax
  802322:	8b 00                	mov    (%eax),%eax
  802324:	83 ec 04             	sub    $0x4,%esp
  802327:	50                   	push   %eax
  802328:	ff 75 f4             	pushl  -0xc(%ebp)
  80232b:	68 4c 30 80 00       	push   $0x80304c
  802330:	e8 fd e7 ff ff       	call   800b32 <cprintf>
  802335:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802338:	ff 45 f4             	incl   -0xc(%ebp)
  80233b:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80233f:	7e d6                	jle    802317 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802341:	90                   	nop
  802342:	c9                   	leave  
  802343:	c3                   	ret    

00802344 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802344:	55                   	push   %ebp
  802345:	89 e5                	mov    %esp,%ebp
  802347:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  80234a:	83 ec 04             	sub    $0x4,%esp
  80234d:	68 5c 30 80 00       	push   $0x80305c
  802352:	6a 33                	push   $0x33
  802354:	68 7d 30 80 00       	push   $0x80307d
  802359:	e8 06 e5 ff ff       	call   800864 <_panic>

0080235e <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80235e:	55                   	push   %ebp
  80235f:	89 e5                	mov    %esp,%ebp
  802361:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802364:	83 ec 04             	sub    $0x4,%esp
  802367:	68 95 30 80 00       	push   $0x803095
  80236c:	6a 3e                	push   $0x3e
  80236e:	68 7d 30 80 00       	push   $0x80307d
  802373:	e8 ec e4 ff ff       	call   800864 <_panic>

00802378 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802378:	55                   	push   %ebp
  802379:	89 e5                	mov    %esp,%ebp
  80237b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  80237e:	83 ec 04             	sub    $0x4,%esp
  802381:	68 b3 30 80 00       	push   $0x8030b3
  802386:	6a 49                	push   $0x49
  802388:	68 7d 30 80 00       	push   $0x80307d
  80238d:	e8 d2 e4 ff ff       	call   800864 <_panic>

00802392 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  802392:	55                   	push   %ebp
  802393:	89 e5                	mov    %esp,%ebp
  802395:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802398:	83 ec 04             	sub    $0x4,%esp
  80239b:	68 d0 30 80 00       	push   $0x8030d0
  8023a0:	6a 58                	push   $0x58
  8023a2:	68 7d 30 80 00       	push   $0x80307d
  8023a7:	e8 b8 e4 ff ff       	call   800864 <_panic>

008023ac <__udivdi3>:
  8023ac:	55                   	push   %ebp
  8023ad:	57                   	push   %edi
  8023ae:	56                   	push   %esi
  8023af:	53                   	push   %ebx
  8023b0:	83 ec 1c             	sub    $0x1c,%esp
  8023b3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023b7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023bf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023c3:	89 ca                	mov    %ecx,%edx
  8023c5:	89 f8                	mov    %edi,%eax
  8023c7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023cb:	85 f6                	test   %esi,%esi
  8023cd:	75 2d                	jne    8023fc <__udivdi3+0x50>
  8023cf:	39 cf                	cmp    %ecx,%edi
  8023d1:	77 65                	ja     802438 <__udivdi3+0x8c>
  8023d3:	89 fd                	mov    %edi,%ebp
  8023d5:	85 ff                	test   %edi,%edi
  8023d7:	75 0b                	jne    8023e4 <__udivdi3+0x38>
  8023d9:	b8 01 00 00 00       	mov    $0x1,%eax
  8023de:	31 d2                	xor    %edx,%edx
  8023e0:	f7 f7                	div    %edi
  8023e2:	89 c5                	mov    %eax,%ebp
  8023e4:	31 d2                	xor    %edx,%edx
  8023e6:	89 c8                	mov    %ecx,%eax
  8023e8:	f7 f5                	div    %ebp
  8023ea:	89 c1                	mov    %eax,%ecx
  8023ec:	89 d8                	mov    %ebx,%eax
  8023ee:	f7 f5                	div    %ebp
  8023f0:	89 cf                	mov    %ecx,%edi
  8023f2:	89 fa                	mov    %edi,%edx
  8023f4:	83 c4 1c             	add    $0x1c,%esp
  8023f7:	5b                   	pop    %ebx
  8023f8:	5e                   	pop    %esi
  8023f9:	5f                   	pop    %edi
  8023fa:	5d                   	pop    %ebp
  8023fb:	c3                   	ret    
  8023fc:	39 ce                	cmp    %ecx,%esi
  8023fe:	77 28                	ja     802428 <__udivdi3+0x7c>
  802400:	0f bd fe             	bsr    %esi,%edi
  802403:	83 f7 1f             	xor    $0x1f,%edi
  802406:	75 40                	jne    802448 <__udivdi3+0x9c>
  802408:	39 ce                	cmp    %ecx,%esi
  80240a:	72 0a                	jb     802416 <__udivdi3+0x6a>
  80240c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802410:	0f 87 9e 00 00 00    	ja     8024b4 <__udivdi3+0x108>
  802416:	b8 01 00 00 00       	mov    $0x1,%eax
  80241b:	89 fa                	mov    %edi,%edx
  80241d:	83 c4 1c             	add    $0x1c,%esp
  802420:	5b                   	pop    %ebx
  802421:	5e                   	pop    %esi
  802422:	5f                   	pop    %edi
  802423:	5d                   	pop    %ebp
  802424:	c3                   	ret    
  802425:	8d 76 00             	lea    0x0(%esi),%esi
  802428:	31 ff                	xor    %edi,%edi
  80242a:	31 c0                	xor    %eax,%eax
  80242c:	89 fa                	mov    %edi,%edx
  80242e:	83 c4 1c             	add    $0x1c,%esp
  802431:	5b                   	pop    %ebx
  802432:	5e                   	pop    %esi
  802433:	5f                   	pop    %edi
  802434:	5d                   	pop    %ebp
  802435:	c3                   	ret    
  802436:	66 90                	xchg   %ax,%ax
  802438:	89 d8                	mov    %ebx,%eax
  80243a:	f7 f7                	div    %edi
  80243c:	31 ff                	xor    %edi,%edi
  80243e:	89 fa                	mov    %edi,%edx
  802440:	83 c4 1c             	add    $0x1c,%esp
  802443:	5b                   	pop    %ebx
  802444:	5e                   	pop    %esi
  802445:	5f                   	pop    %edi
  802446:	5d                   	pop    %ebp
  802447:	c3                   	ret    
  802448:	bd 20 00 00 00       	mov    $0x20,%ebp
  80244d:	89 eb                	mov    %ebp,%ebx
  80244f:	29 fb                	sub    %edi,%ebx
  802451:	89 f9                	mov    %edi,%ecx
  802453:	d3 e6                	shl    %cl,%esi
  802455:	89 c5                	mov    %eax,%ebp
  802457:	88 d9                	mov    %bl,%cl
  802459:	d3 ed                	shr    %cl,%ebp
  80245b:	89 e9                	mov    %ebp,%ecx
  80245d:	09 f1                	or     %esi,%ecx
  80245f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802463:	89 f9                	mov    %edi,%ecx
  802465:	d3 e0                	shl    %cl,%eax
  802467:	89 c5                	mov    %eax,%ebp
  802469:	89 d6                	mov    %edx,%esi
  80246b:	88 d9                	mov    %bl,%cl
  80246d:	d3 ee                	shr    %cl,%esi
  80246f:	89 f9                	mov    %edi,%ecx
  802471:	d3 e2                	shl    %cl,%edx
  802473:	8b 44 24 08          	mov    0x8(%esp),%eax
  802477:	88 d9                	mov    %bl,%cl
  802479:	d3 e8                	shr    %cl,%eax
  80247b:	09 c2                	or     %eax,%edx
  80247d:	89 d0                	mov    %edx,%eax
  80247f:	89 f2                	mov    %esi,%edx
  802481:	f7 74 24 0c          	divl   0xc(%esp)
  802485:	89 d6                	mov    %edx,%esi
  802487:	89 c3                	mov    %eax,%ebx
  802489:	f7 e5                	mul    %ebp
  80248b:	39 d6                	cmp    %edx,%esi
  80248d:	72 19                	jb     8024a8 <__udivdi3+0xfc>
  80248f:	74 0b                	je     80249c <__udivdi3+0xf0>
  802491:	89 d8                	mov    %ebx,%eax
  802493:	31 ff                	xor    %edi,%edi
  802495:	e9 58 ff ff ff       	jmp    8023f2 <__udivdi3+0x46>
  80249a:	66 90                	xchg   %ax,%ax
  80249c:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024a0:	89 f9                	mov    %edi,%ecx
  8024a2:	d3 e2                	shl    %cl,%edx
  8024a4:	39 c2                	cmp    %eax,%edx
  8024a6:	73 e9                	jae    802491 <__udivdi3+0xe5>
  8024a8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024ab:	31 ff                	xor    %edi,%edi
  8024ad:	e9 40 ff ff ff       	jmp    8023f2 <__udivdi3+0x46>
  8024b2:	66 90                	xchg   %ax,%ax
  8024b4:	31 c0                	xor    %eax,%eax
  8024b6:	e9 37 ff ff ff       	jmp    8023f2 <__udivdi3+0x46>
  8024bb:	90                   	nop

008024bc <__umoddi3>:
  8024bc:	55                   	push   %ebp
  8024bd:	57                   	push   %edi
  8024be:	56                   	push   %esi
  8024bf:	53                   	push   %ebx
  8024c0:	83 ec 1c             	sub    $0x1c,%esp
  8024c3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024c7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024cf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024d7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024db:	89 f3                	mov    %esi,%ebx
  8024dd:	89 fa                	mov    %edi,%edx
  8024df:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024e3:	89 34 24             	mov    %esi,(%esp)
  8024e6:	85 c0                	test   %eax,%eax
  8024e8:	75 1a                	jne    802504 <__umoddi3+0x48>
  8024ea:	39 f7                	cmp    %esi,%edi
  8024ec:	0f 86 a2 00 00 00    	jbe    802594 <__umoddi3+0xd8>
  8024f2:	89 c8                	mov    %ecx,%eax
  8024f4:	89 f2                	mov    %esi,%edx
  8024f6:	f7 f7                	div    %edi
  8024f8:	89 d0                	mov    %edx,%eax
  8024fa:	31 d2                	xor    %edx,%edx
  8024fc:	83 c4 1c             	add    $0x1c,%esp
  8024ff:	5b                   	pop    %ebx
  802500:	5e                   	pop    %esi
  802501:	5f                   	pop    %edi
  802502:	5d                   	pop    %ebp
  802503:	c3                   	ret    
  802504:	39 f0                	cmp    %esi,%eax
  802506:	0f 87 ac 00 00 00    	ja     8025b8 <__umoddi3+0xfc>
  80250c:	0f bd e8             	bsr    %eax,%ebp
  80250f:	83 f5 1f             	xor    $0x1f,%ebp
  802512:	0f 84 ac 00 00 00    	je     8025c4 <__umoddi3+0x108>
  802518:	bf 20 00 00 00       	mov    $0x20,%edi
  80251d:	29 ef                	sub    %ebp,%edi
  80251f:	89 fe                	mov    %edi,%esi
  802521:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802525:	89 e9                	mov    %ebp,%ecx
  802527:	d3 e0                	shl    %cl,%eax
  802529:	89 d7                	mov    %edx,%edi
  80252b:	89 f1                	mov    %esi,%ecx
  80252d:	d3 ef                	shr    %cl,%edi
  80252f:	09 c7                	or     %eax,%edi
  802531:	89 e9                	mov    %ebp,%ecx
  802533:	d3 e2                	shl    %cl,%edx
  802535:	89 14 24             	mov    %edx,(%esp)
  802538:	89 d8                	mov    %ebx,%eax
  80253a:	d3 e0                	shl    %cl,%eax
  80253c:	89 c2                	mov    %eax,%edx
  80253e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802542:	d3 e0                	shl    %cl,%eax
  802544:	89 44 24 04          	mov    %eax,0x4(%esp)
  802548:	8b 44 24 08          	mov    0x8(%esp),%eax
  80254c:	89 f1                	mov    %esi,%ecx
  80254e:	d3 e8                	shr    %cl,%eax
  802550:	09 d0                	or     %edx,%eax
  802552:	d3 eb                	shr    %cl,%ebx
  802554:	89 da                	mov    %ebx,%edx
  802556:	f7 f7                	div    %edi
  802558:	89 d3                	mov    %edx,%ebx
  80255a:	f7 24 24             	mull   (%esp)
  80255d:	89 c6                	mov    %eax,%esi
  80255f:	89 d1                	mov    %edx,%ecx
  802561:	39 d3                	cmp    %edx,%ebx
  802563:	0f 82 87 00 00 00    	jb     8025f0 <__umoddi3+0x134>
  802569:	0f 84 91 00 00 00    	je     802600 <__umoddi3+0x144>
  80256f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802573:	29 f2                	sub    %esi,%edx
  802575:	19 cb                	sbb    %ecx,%ebx
  802577:	89 d8                	mov    %ebx,%eax
  802579:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80257d:	d3 e0                	shl    %cl,%eax
  80257f:	89 e9                	mov    %ebp,%ecx
  802581:	d3 ea                	shr    %cl,%edx
  802583:	09 d0                	or     %edx,%eax
  802585:	89 e9                	mov    %ebp,%ecx
  802587:	d3 eb                	shr    %cl,%ebx
  802589:	89 da                	mov    %ebx,%edx
  80258b:	83 c4 1c             	add    $0x1c,%esp
  80258e:	5b                   	pop    %ebx
  80258f:	5e                   	pop    %esi
  802590:	5f                   	pop    %edi
  802591:	5d                   	pop    %ebp
  802592:	c3                   	ret    
  802593:	90                   	nop
  802594:	89 fd                	mov    %edi,%ebp
  802596:	85 ff                	test   %edi,%edi
  802598:	75 0b                	jne    8025a5 <__umoddi3+0xe9>
  80259a:	b8 01 00 00 00       	mov    $0x1,%eax
  80259f:	31 d2                	xor    %edx,%edx
  8025a1:	f7 f7                	div    %edi
  8025a3:	89 c5                	mov    %eax,%ebp
  8025a5:	89 f0                	mov    %esi,%eax
  8025a7:	31 d2                	xor    %edx,%edx
  8025a9:	f7 f5                	div    %ebp
  8025ab:	89 c8                	mov    %ecx,%eax
  8025ad:	f7 f5                	div    %ebp
  8025af:	89 d0                	mov    %edx,%eax
  8025b1:	e9 44 ff ff ff       	jmp    8024fa <__umoddi3+0x3e>
  8025b6:	66 90                	xchg   %ax,%ax
  8025b8:	89 c8                	mov    %ecx,%eax
  8025ba:	89 f2                	mov    %esi,%edx
  8025bc:	83 c4 1c             	add    $0x1c,%esp
  8025bf:	5b                   	pop    %ebx
  8025c0:	5e                   	pop    %esi
  8025c1:	5f                   	pop    %edi
  8025c2:	5d                   	pop    %ebp
  8025c3:	c3                   	ret    
  8025c4:	3b 04 24             	cmp    (%esp),%eax
  8025c7:	72 06                	jb     8025cf <__umoddi3+0x113>
  8025c9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025cd:	77 0f                	ja     8025de <__umoddi3+0x122>
  8025cf:	89 f2                	mov    %esi,%edx
  8025d1:	29 f9                	sub    %edi,%ecx
  8025d3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025d7:	89 14 24             	mov    %edx,(%esp)
  8025da:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025de:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025e2:	8b 14 24             	mov    (%esp),%edx
  8025e5:	83 c4 1c             	add    $0x1c,%esp
  8025e8:	5b                   	pop    %ebx
  8025e9:	5e                   	pop    %esi
  8025ea:	5f                   	pop    %edi
  8025eb:	5d                   	pop    %ebp
  8025ec:	c3                   	ret    
  8025ed:	8d 76 00             	lea    0x0(%esi),%esi
  8025f0:	2b 04 24             	sub    (%esp),%eax
  8025f3:	19 fa                	sbb    %edi,%edx
  8025f5:	89 d1                	mov    %edx,%ecx
  8025f7:	89 c6                	mov    %eax,%esi
  8025f9:	e9 71 ff ff ff       	jmp    80256f <__umoddi3+0xb3>
  8025fe:	66 90                	xchg   %ax,%ax
  802600:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802604:	72 ea                	jb     8025f0 <__umoddi3+0x134>
  802606:	89 d9                	mov    %ebx,%ecx
  802608:	e9 62 ff ff ff       	jmp    80256f <__umoddi3+0xb3>
