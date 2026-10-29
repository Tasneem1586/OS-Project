
obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 ad 07 00 00       	call   8007e3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 38 01 00 00    	sub    $0x138,%esp

	do
	{
		//2012: lock the interrupt
		//sys_lock_cons();
		sys_lock_cons();
  800041:	e8 4f 1f 00 00       	call   801f95 <sys_lock_cons>
		{
			cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 28 80 00       	push   $0x802800
  80004e:	e8 be 0c 00 00       	call   800d11 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 28 80 00       	push   $0x802802
  80005e:	e8 ae 0c 00 00       	call   800d11 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 18 28 80 00       	push   $0x802818
  80006e:	e8 9e 0c 00 00       	call   800d11 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 28 80 00       	push   $0x802802
  80007e:	e8 8e 0c 00 00       	call   800d11 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 28 80 00       	push   $0x802800
  80008e:	e8 7e 0c 00 00       	call   800d11 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
			readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 30 28 80 00       	push   $0x802830
  8000a5:	e8 40 13 00 00       	call   8013ea <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
			cprintf("Chose the initialization method:\n") ;
  8000ad:	83 ec 0c             	sub    $0xc,%esp
  8000b0:	68 50 28 80 00       	push   $0x802850
  8000b5:	e8 57 0c 00 00       	call   800d11 <cprintf>
  8000ba:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000bd:	83 ec 0c             	sub    $0xc,%esp
  8000c0:	68 72 28 80 00       	push   $0x802872
  8000c5:	e8 47 0c 00 00       	call   800d11 <cprintf>
  8000ca:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000cd:	83 ec 0c             	sub    $0xc,%esp
  8000d0:	68 80 28 80 00       	push   $0x802880
  8000d5:	e8 37 0c 00 00       	call   800d11 <cprintf>
  8000da:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000dd:	83 ec 0c             	sub    $0xc,%esp
  8000e0:	68 8f 28 80 00       	push   $0x80288f
  8000e5:	e8 27 0c 00 00       	call   800d11 <cprintf>
  8000ea:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000ed:	83 ec 0c             	sub    $0xc,%esp
  8000f0:	68 9f 28 80 00       	push   $0x80289f
  8000f5:	e8 17 0c 00 00       	call   800d11 <cprintf>
  8000fa:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8000fd:	e8 be 06 00 00       	call   8007c0 <getchar>
  800102:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  800105:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	50                   	push   %eax
  80010d:	e8 8f 06 00 00       	call   8007a1 <cputchar>
  800112:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	6a 0a                	push   $0xa
  80011a:	e8 82 06 00 00       	call   8007a1 <cputchar>
  80011f:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800122:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800126:	74 0c                	je     800134 <_main+0xfc>
  800128:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80012c:	74 06                	je     800134 <_main+0xfc>
  80012e:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800132:	75 b9                	jne    8000ed <_main+0xb5>
		}
		sys_unlock_cons();
  800134:	e8 76 1e 00 00       	call   801faf <sys_unlock_cons>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800139:	0f 31                	rdtsc  
  80013b:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
  800141:	89 95 cc fe ff ff    	mov    %edx,-0x134(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800147:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80014d:	8b 95 cc fe ff ff    	mov    -0x134(%ebp),%edx
  800153:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  800159:	89 95 e4 fe ff ff    	mov    %edx,-0x11c(%ebp)
		//sys_unlock_cons();

		struct uint64 tic = get_virtual_time();
		NumOfElements = strtol(Line, NULL, 10) ;
  80015f:	83 ec 04             	sub    $0x4,%esp
  800162:	6a 0a                	push   $0xa
  800164:	6a 00                	push   $0x0
  800166:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80016c:	50                   	push   %eax
  80016d:	e8 8f 18 00 00       	call   801a01 <strtol>
  800172:	83 c4 10             	add    $0x10,%esp
  800175:	89 45 f0             	mov    %eax,-0x10(%ebp)
		Elements = malloc(sizeof(int) * NumOfElements) ;
  800178:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80017b:	c1 e0 02             	shl    $0x2,%eax
  80017e:	83 ec 0c             	sub    $0xc,%esp
  800181:	50                   	push   %eax
  800182:	e8 ea 1c 00 00       	call   801e71 <malloc>
  800187:	83 c4 10             	add    $0x10,%esp
  80018a:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int  i ;
		switch (Chose)
  80018d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800191:	83 f8 62             	cmp    $0x62,%eax
  800194:	74 1d                	je     8001b3 <_main+0x17b>
  800196:	83 f8 63             	cmp    $0x63,%eax
  800199:	74 2b                	je     8001c6 <_main+0x18e>
  80019b:	83 f8 61             	cmp    $0x61,%eax
  80019e:	75 39                	jne    8001d9 <_main+0x1a1>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 4a 02 00 00       	call   8003f8 <InitializeAscending>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 37                	jmp    8001ea <_main+0x1b2>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 68 02 00 00       	call   800429 <InitializeDescending>
  8001c1:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c4:	eb 24                	jmp    8001ea <_main+0x1b2>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 8a 02 00 00       	call   80045e <InitializeSemiRandom>
  8001d4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d7:	eb 11                	jmp    8001ea <_main+0x1b2>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d9:	83 ec 08             	sub    $0x8,%esp
  8001dc:	ff 75 f0             	pushl  -0x10(%ebp)
  8001df:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e2:	e8 77 02 00 00       	call   80045e <InitializeSemiRandom>
  8001e7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ea:	83 ec 04             	sub    $0x4,%esp
  8001ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f0:	6a 01                	push   $0x1
  8001f2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f5:	e8 36 03 00 00       	call   800530 <MSort>
  8001fa:	83 c4 10             	add    $0x10,%esp

		atomic_cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001fd:	83 ec 0c             	sub    $0xc,%esp
  800200:	68 a8 28 80 00       	push   $0x8028a8
  800205:	e8 79 0b 00 00       	call   800d83 <atomic_cprintf>
  80020a:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  80020d:	83 ec 08             	sub    $0x8,%esp
  800210:	ff 75 f0             	pushl  -0x10(%ebp)
  800213:	ff 75 ec             	pushl  -0x14(%ebp)
  800216:	e8 33 01 00 00       	call   80034e <CheckSorted>
  80021b:	83 c4 10             	add    $0x10,%esp
  80021e:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800221:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800225:	75 14                	jne    80023b <_main+0x203>
  800227:	83 ec 04             	sub    $0x4,%esp
  80022a:	68 dc 28 80 00       	push   $0x8028dc
  80022f:	6a 4e                	push   $0x4e
  800231:	68 fe 28 80 00       	push   $0x8028fe
  800236:	e8 08 08 00 00       	call   800a43 <_panic>
		else
		{
			//sys_lock_cons();
			sys_lock_cons();
  80023b:	e8 55 1d 00 00       	call   801f95 <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	68 1c 29 80 00       	push   $0x80291c
  800248:	e8 c4 0a 00 00       	call   800d11 <cprintf>
  80024d:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	68 50 29 80 00       	push   $0x802950
  800258:	e8 b4 0a 00 00       	call   800d11 <cprintf>
  80025d:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800260:	83 ec 0c             	sub    $0xc,%esp
  800263:	68 84 29 80 00       	push   $0x802984
  800268:	e8 a4 0a 00 00       	call   800d11 <cprintf>
  80026d:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  800270:	e8 3a 1d 00 00       	call   801faf <sys_unlock_cons>
			//sys_unlock_cons();
		}

		free(Elements) ;
  800275:	83 ec 0c             	sub    $0xc,%esp
  800278:	ff 75 ec             	pushl  -0x14(%ebp)
  80027b:	e8 1f 1c 00 00       	call   801e9f <free>
  800280:	83 c4 10             	add    $0x10,%esp
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800283:	0f 31                	rdtsc  
  800285:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  80028b:	89 95 d4 fe ff ff    	mov    %edx,-0x12c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800291:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800297:	8b 95 d4 fe ff ff    	mov    -0x12c(%ebp),%edx
  80029d:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  8002a3:	89 95 dc fe ff ff    	mov    %edx,-0x124(%ebp)

		struct uint64 toc = get_virtual_time();

		//sys_lock_cons();
		sys_lock_cons();
  8002a9:	e8 e7 1c 00 00       	call   801f95 <sys_lock_cons>
		{
			cprintf_colored(TEXT_light_green, "tic = %u - %u\n", tic.hi, tic.low);
  8002ae:	8b 95 e0 fe ff ff    	mov    -0x120(%ebp),%edx
  8002b4:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8002ba:	52                   	push   %edx
  8002bb:	50                   	push   %eax
  8002bc:	68 b6 29 80 00       	push   $0x8029b6
  8002c1:	6a 0a                	push   $0xa
  8002c3:	e8 76 0a 00 00       	call   800d3e <cprintf_colored>
  8002c8:	83 c4 10             	add    $0x10,%esp
			cprintf_colored(TEXT_light_red, "toc = %u - %u\n", toc.hi, toc.low);
  8002cb:	8b 95 d8 fe ff ff    	mov    -0x128(%ebp),%edx
  8002d1:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8002d7:	52                   	push   %edx
  8002d8:	50                   	push   %eax
  8002d9:	68 c5 29 80 00       	push   $0x8029c5
  8002de:	6a 0c                	push   $0xc
  8002e0:	e8 59 0a 00 00       	call   800d3e <cprintf_colored>
  8002e5:	83 c4 10             	add    $0x10,%esp
			Chose = 0 ;
  8002e8:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  8002ec:	eb 42                	jmp    800330 <_main+0x2f8>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  8002ee:	83 ec 0c             	sub    $0xc,%esp
  8002f1:	68 d4 29 80 00       	push   $0x8029d4
  8002f6:	e8 16 0a 00 00       	call   800d11 <cprintf>
  8002fb:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8002fe:	e8 bd 04 00 00       	call   8007c0 <getchar>
  800303:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  800306:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80030a:	83 ec 0c             	sub    $0xc,%esp
  80030d:	50                   	push   %eax
  80030e:	e8 8e 04 00 00       	call   8007a1 <cputchar>
  800313:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800316:	83 ec 0c             	sub    $0xc,%esp
  800319:	6a 0a                	push   $0xa
  80031b:	e8 81 04 00 00       	call   8007a1 <cputchar>
  800320:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	6a 0a                	push   $0xa
  800328:	e8 74 04 00 00       	call   8007a1 <cputchar>
  80032d:	83 c4 10             	add    $0x10,%esp
		sys_lock_cons();
		{
			cprintf_colored(TEXT_light_green, "tic = %u - %u\n", tic.hi, tic.low);
			cprintf_colored(TEXT_light_red, "toc = %u - %u\n", toc.hi, toc.low);
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  800330:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800334:	74 06                	je     80033c <_main+0x304>
  800336:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80033a:	75 b2                	jne    8002ee <_main+0x2b6>
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		}
		sys_unlock_cons();
  80033c:	e8 6e 1c 00 00       	call   801faf <sys_unlock_cons>
		//sys_unlock_cons();

	} while (Chose == 'y');
  800341:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800345:	0f 84 f6 fc ff ff    	je     800041 <_main+0x9>

}
  80034b:	90                   	nop
  80034c:	c9                   	leave  
  80034d:	c3                   	ret    

0080034e <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80034e:	55                   	push   %ebp
  80034f:	89 e5                	mov    %esp,%ebp
  800351:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800354:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80035b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800362:	eb 33                	jmp    800397 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800364:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 10                	mov    (%eax),%edx
  800375:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800378:	40                   	inc    %eax
  800379:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800380:	8b 45 08             	mov    0x8(%ebp),%eax
  800383:	01 c8                	add    %ecx,%eax
  800385:	8b 00                	mov    (%eax),%eax
  800387:	39 c2                	cmp    %eax,%edx
  800389:	7e 09                	jle    800394 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80038b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800392:	eb 0c                	jmp    8003a0 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800394:	ff 45 f8             	incl   -0x8(%ebp)
  800397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039a:	48                   	dec    %eax
  80039b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80039e:	7f c4                	jg     800364 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003a3:	c9                   	leave  
  8003a4:	c3                   	ret    

008003a5 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003a5:	55                   	push   %ebp
  8003a6:	89 e5                	mov    %esp,%ebp
  8003a8:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b8:	01 d0                	add    %edx,%eax
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cc:	01 c2                	add    %eax,%edx
  8003ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8003d1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	01 c8                	add    %ecx,%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8003e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	01 c2                	add    %eax,%edx
  8003f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f3:	89 02                	mov    %eax,(%edx)
}
  8003f5:	90                   	nop
  8003f6:	c9                   	leave  
  8003f7:	c3                   	ret    

008003f8 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003f8:	55                   	push   %ebp
  8003f9:	89 e5                	mov    %esp,%ebp
  8003fb:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800405:	eb 17                	jmp    80041e <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	01 c2                	add    %eax,%edx
  800416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800419:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80041b:	ff 45 fc             	incl   -0x4(%ebp)
  80041e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800421:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800424:	7c e1                	jl     800407 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800426:	90                   	nop
  800427:	c9                   	leave  
  800428:	c3                   	ret    

00800429 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800429:	55                   	push   %ebp
  80042a:	89 e5                	mov    %esp,%ebp
  80042c:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80042f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800436:	eb 1b                	jmp    800453 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800438:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	01 c2                	add    %eax,%edx
  800447:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044a:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80044d:	48                   	dec    %eax
  80044e:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800450:	ff 45 fc             	incl   -0x4(%ebp)
  800453:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800456:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800459:	7c dd                	jl     800438 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80045b:	90                   	nop
  80045c:	c9                   	leave  
  80045d:	c3                   	ret    

0080045e <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80045e:	55                   	push   %ebp
  80045f:	89 e5                	mov    %esp,%ebp
  800461:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800464:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800467:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80046c:	f7 e9                	imul   %ecx
  80046e:	c1 f9 1f             	sar    $0x1f,%ecx
  800471:	89 d0                	mov    %edx,%eax
  800473:	29 c8                	sub    %ecx,%eax
  800475:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800478:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80047f:	eb 1e                	jmp    80049f <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800481:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800491:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800494:	99                   	cltd   
  800495:	f7 7d f8             	idivl  -0x8(%ebp)
  800498:	89 d0                	mov    %edx,%eax
  80049a:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  80049c:	ff 45 fc             	incl   -0x4(%ebp)
  80049f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a5:	7c da                	jl     800481 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//cprintf("i=%d\n",i);
	}

}
  8004a7:	90                   	nop
  8004a8:	c9                   	leave  
  8004a9:	c3                   	ret    

008004aa <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004aa:	55                   	push   %ebp
  8004ab:	89 e5                	mov    %esp,%ebp
  8004ad:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004b0:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004be:	eb 42                	jmp    800502 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c3:	99                   	cltd   
  8004c4:	f7 7d f0             	idivl  -0x10(%ebp)
  8004c7:	89 d0                	mov    %edx,%eax
  8004c9:	85 c0                	test   %eax,%eax
  8004cb:	75 10                	jne    8004dd <PrintElements+0x33>
			cprintf("\n");
  8004cd:	83 ec 0c             	sub    $0xc,%esp
  8004d0:	68 00 28 80 00       	push   $0x802800
  8004d5:	e8 37 08 00 00       	call   800d11 <cprintf>
  8004da:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 d0                	add    %edx,%eax
  8004ec:	8b 00                	mov    (%eax),%eax
  8004ee:	83 ec 08             	sub    $0x8,%esp
  8004f1:	50                   	push   %eax
  8004f2:	68 f2 29 80 00       	push   $0x8029f2
  8004f7:	e8 15 08 00 00       	call   800d11 <cprintf>
  8004fc:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004ff:	ff 45 f4             	incl   -0xc(%ebp)
  800502:	8b 45 0c             	mov    0xc(%ebp),%eax
  800505:	48                   	dec    %eax
  800506:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800509:	7f b5                	jg     8004c0 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80050b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800515:	8b 45 08             	mov    0x8(%ebp),%eax
  800518:	01 d0                	add    %edx,%eax
  80051a:	8b 00                	mov    (%eax),%eax
  80051c:	83 ec 08             	sub    $0x8,%esp
  80051f:	50                   	push   %eax
  800520:	68 f7 29 80 00       	push   $0x8029f7
  800525:	e8 e7 07 00 00       	call   800d11 <cprintf>
  80052a:	83 c4 10             	add    $0x10,%esp

}
  80052d:	90                   	nop
  80052e:	c9                   	leave  
  80052f:	c3                   	ret    

00800530 <MSort>:


void MSort(int* A, int p, int r)
{
  800530:	55                   	push   %ebp
  800531:	89 e5                	mov    %esp,%ebp
  800533:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  800536:	8b 45 0c             	mov    0xc(%ebp),%eax
  800539:	3b 45 10             	cmp    0x10(%ebp),%eax
  80053c:	7d 54                	jge    800592 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  80053e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800541:	8b 45 10             	mov    0x10(%ebp),%eax
  800544:	01 d0                	add    %edx,%eax
  800546:	89 c2                	mov    %eax,%edx
  800548:	c1 ea 1f             	shr    $0x1f,%edx
  80054b:	01 d0                	add    %edx,%eax
  80054d:	d1 f8                	sar    %eax
  80054f:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800552:	83 ec 04             	sub    $0x4,%esp
  800555:	ff 75 f4             	pushl  -0xc(%ebp)
  800558:	ff 75 0c             	pushl  0xc(%ebp)
  80055b:	ff 75 08             	pushl  0x8(%ebp)
  80055e:	e8 cd ff ff ff       	call   800530 <MSort>
  800563:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  800566:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800569:	40                   	inc    %eax
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	ff 75 10             	pushl  0x10(%ebp)
  800570:	50                   	push   %eax
  800571:	ff 75 08             	pushl  0x8(%ebp)
  800574:	e8 b7 ff ff ff       	call   800530 <MSort>
  800579:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  80057c:	ff 75 10             	pushl  0x10(%ebp)
  80057f:	ff 75 f4             	pushl  -0xc(%ebp)
  800582:	ff 75 0c             	pushl  0xc(%ebp)
  800585:	ff 75 08             	pushl  0x8(%ebp)
  800588:	e8 08 00 00 00       	call   800595 <Merge>
  80058d:	83 c4 10             	add    $0x10,%esp
  800590:	eb 01                	jmp    800593 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800592:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800593:	c9                   	leave  
  800594:	c3                   	ret    

00800595 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800595:	55                   	push   %ebp
  800596:	89 e5                	mov    %esp,%ebp
  800598:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80059b:	8b 45 10             	mov    0x10(%ebp),%eax
  80059e:	2b 45 0c             	sub    0xc(%ebp),%eax
  8005a1:	40                   	inc    %eax
  8005a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  8005a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a8:	2b 45 10             	sub    0x10(%ebp),%eax
  8005ab:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  8005ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  8005b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  8005bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005bf:	c1 e0 02             	shl    $0x2,%eax
  8005c2:	83 ec 0c             	sub    $0xc,%esp
  8005c5:	50                   	push   %eax
  8005c6:	e8 a6 18 00 00       	call   801e71 <malloc>
  8005cb:	83 c4 10             	add    $0x10,%esp
  8005ce:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  8005d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d4:	c1 e0 02             	shl    $0x2,%eax
  8005d7:	83 ec 0c             	sub    $0xc,%esp
  8005da:	50                   	push   %eax
  8005db:	e8 91 18 00 00       	call   801e71 <malloc>
  8005e0:	83 c4 10             	add    $0x10,%esp
  8005e3:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005ed:	eb 2f                	jmp    80061e <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005fc:	01 c2                	add    %eax,%edx
  8005fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800601:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800604:	01 c8                	add    %ecx,%eax
  800606:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80060b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	01 c8                	add    %ecx,%eax
  800617:	8b 00                	mov    (%eax),%eax
  800619:	89 02                	mov    %eax,(%edx)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80061b:	ff 45 ec             	incl   -0x14(%ebp)
  80061e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800621:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800624:	7c c9                	jl     8005ef <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800626:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80062d:	eb 2a                	jmp    800659 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  80062f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800632:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800639:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80063c:	01 c2                	add    %eax,%edx
  80063e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800641:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800644:	01 c8                	add    %ecx,%eax
  800646:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80064d:	8b 45 08             	mov    0x8(%ebp),%eax
  800650:	01 c8                	add    %ecx,%eax
  800652:	8b 00                	mov    (%eax),%eax
  800654:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800656:	ff 45 e8             	incl   -0x18(%ebp)
  800659:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80065c:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80065f:	7c ce                	jl     80062f <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800661:	8b 45 0c             	mov    0xc(%ebp),%eax
  800664:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800667:	e9 0a 01 00 00       	jmp    800776 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  80066c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80066f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800672:	0f 8d 95 00 00 00    	jge    80070d <Merge+0x178>
  800678:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067b:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80067e:	0f 8d 89 00 00 00    	jge    80070d <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800687:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80068e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800691:	01 d0                	add    %edx,%eax
  800693:	8b 10                	mov    (%eax),%edx
  800695:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800698:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80069f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006a2:	01 c8                	add    %ecx,%eax
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	39 c2                	cmp    %eax,%edx
  8006a8:	7d 33                	jge    8006dd <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  8006aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ad:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006c2:	8d 50 01             	lea    0x1(%eax),%edx
  8006c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006cf:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006d2:	01 d0                	add    %edx,%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006d8:	e9 96 00 00 00       	jmp    800773 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8006dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006e0:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f5:	8d 50 01             	lea    0x1(%eax),%edx
  8006f8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800702:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800705:	01 d0                	add    %edx,%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80070b:	eb 66                	jmp    800773 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  80070d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800710:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800713:	7d 30                	jge    800745 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800715:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800718:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80071d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80072a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80072d:	8d 50 01             	lea    0x1(%eax),%edx
  800730:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800733:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80073a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80073d:	01 d0                	add    %edx,%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	89 01                	mov    %eax,(%ecx)
  800743:	eb 2e                	jmp    800773 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800745:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800748:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80074d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80075a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80075d:	8d 50 01             	lea    0x1(%eax),%edx
  800760:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800763:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80076d:	01 d0                	add    %edx,%eax
  80076f:	8b 00                	mov    (%eax),%eax
  800771:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800773:	ff 45 e4             	incl   -0x1c(%ebp)
  800776:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800779:	3b 45 14             	cmp    0x14(%ebp),%eax
  80077c:	0f 8e ea fe ff ff    	jle    80066c <Merge+0xd7>
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800782:	83 ec 0c             	sub    $0xc,%esp
  800785:	ff 75 d8             	pushl  -0x28(%ebp)
  800788:	e8 12 17 00 00       	call   801e9f <free>
  80078d:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800790:	83 ec 0c             	sub    $0xc,%esp
  800793:	ff 75 d4             	pushl  -0x2c(%ebp)
  800796:	e8 04 17 00 00       	call   801e9f <free>
  80079b:	83 c4 10             	add    $0x10,%esp

}
  80079e:	90                   	nop
  80079f:	c9                   	leave  
  8007a0:	c3                   	ret    

008007a1 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8007a1:	55                   	push   %ebp
  8007a2:	89 e5                	mov    %esp,%ebp
  8007a4:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007ad:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007b1:	83 ec 0c             	sub    $0xc,%esp
  8007b4:	50                   	push   %eax
  8007b5:	e8 23 19 00 00       	call   8020dd <sys_cputc>
  8007ba:	83 c4 10             	add    $0x10,%esp
}
  8007bd:	90                   	nop
  8007be:	c9                   	leave  
  8007bf:	c3                   	ret    

008007c0 <getchar>:


int
getchar(void)
{
  8007c0:	55                   	push   %ebp
  8007c1:	89 e5                	mov    %esp,%ebp
  8007c3:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8007c6:	e8 b1 17 00 00       	call   801f7c <sys_cgetc>
  8007cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8007ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007d2:	74 f2                	je     8007c6 <getchar+0x6>
	return c;
  8007d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007d7:	c9                   	leave  
  8007d8:	c3                   	ret    

008007d9 <iscons>:

int iscons(int fdnum)
{
  8007d9:	55                   	push   %ebp
  8007da:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007dc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007e1:	5d                   	pop    %ebp
  8007e2:	c3                   	ret    

008007e3 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	57                   	push   %edi
  8007e7:	56                   	push   %esi
  8007e8:	53                   	push   %ebx
  8007e9:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8007ef:	e8 19 1a 00 00       	call   80220d <sys_getenvindex>
  8007f4:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8007f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007fa:	89 d0                	mov    %edx,%eax
  8007fc:	c1 e0 03             	shl    $0x3,%eax
  8007ff:	01 d0                	add    %edx,%eax
  800801:	c1 e0 06             	shl    $0x6,%eax
  800804:	01 d0                	add    %edx,%eax
  800806:	c1 e0 03             	shl    $0x3,%eax
  800809:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80080e:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800813:	a1 24 40 80 00       	mov    0x804024,%eax
  800818:	8a 40 10             	mov    0x10(%eax),%al
  80081b:	84 c0                	test   %al,%al
  80081d:	74 0d                	je     80082c <libmain+0x49>
		binaryname = myEnv->prog_name;
  80081f:	a1 24 40 80 00       	mov    0x804024,%eax
  800824:	83 c0 10             	add    $0x10,%eax
  800827:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80082c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800830:	7e 0a                	jle    80083c <libmain+0x59>
		binaryname = argv[0];
  800832:	8b 45 0c             	mov    0xc(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  80083c:	83 ec 08             	sub    $0x8,%esp
  80083f:	ff 75 0c             	pushl  0xc(%ebp)
  800842:	ff 75 08             	pushl  0x8(%ebp)
  800845:	e8 ee f7 ff ff       	call   800038 <_main>
  80084a:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80084d:	a1 00 40 80 00       	mov    0x804000,%eax
  800852:	85 c0                	test   %eax,%eax
  800854:	0f 84 b7 01 00 00    	je     800a11 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80085a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800860:	bb 38 2b 80 00       	mov    $0x802b38,%ebx
  800865:	ba 0e 00 00 00       	mov    $0xe,%edx
  80086a:	89 c7                	mov    %eax,%edi
  80086c:	89 de                	mov    %ebx,%esi
  80086e:	89 d1                	mov    %edx,%ecx
  800870:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800872:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800878:	b9 56 00 00 00       	mov    $0x56,%ecx
  80087d:	b0 00                	mov    $0x0,%al
  80087f:	89 d7                	mov    %edx,%edi
  800881:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800883:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80088a:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80088d:	83 ec 08             	sub    $0x8,%esp
  800890:	50                   	push   %eax
  800891:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800897:	50                   	push   %eax
  800898:	e8 70 1b 00 00       	call   80240d <sys_utilities>
  80089d:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8008a0:	e8 f0 16 00 00       	call   801f95 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8008a5:	83 ec 0c             	sub    $0xc,%esp
  8008a8:	68 14 2a 80 00       	push   $0x802a14
  8008ad:	e8 5f 04 00 00       	call   800d11 <cprintf>
  8008b2:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8008b5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8008b8:	85 c0                	test   %eax,%eax
  8008ba:	74 58                	je     800914 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8008bc:	e8 6a 1b 00 00       	call   80242b <sys_get_optimal_num_faults>
  8008c1:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8008c4:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8008ca:	bb 9c 2b 80 00       	mov    $0x802b9c,%ebx
  8008cf:	ba 11 00 00 00       	mov    $0x11,%edx
  8008d4:	89 c7                	mov    %eax,%edi
  8008d6:	89 de                	mov    %ebx,%esi
  8008d8:	89 d1                	mov    %edx,%ecx
  8008da:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8008dc:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8008df:	b9 53 00 00 00       	mov    $0x53,%ecx
  8008e4:	b0 00                	mov    $0x0,%al
  8008e6:	89 d7                	mov    %edx,%edi
  8008e8:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8008ea:	83 ec 08             	sub    $0x8,%esp
  8008ed:	ff 75 dc             	pushl  -0x24(%ebp)
  8008f0:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8008f6:	50                   	push   %eax
  8008f7:	e8 11 1b 00 00       	call   80240d <sys_utilities>
  8008fc:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8008ff:	83 ec 08             	sub    $0x8,%esp
  800902:	ff 75 dc             	pushl  -0x24(%ebp)
  800905:	68 3c 2a 80 00       	push   $0x802a3c
  80090a:	e8 02 04 00 00       	call   800d11 <cprintf>
  80090f:	83 c4 10             	add    $0x10,%esp
  800912:	eb 59                	jmp    80096d <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800914:	a1 24 40 80 00       	mov    0x804024,%eax
  800919:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80091f:	a1 24 40 80 00       	mov    0x804024,%eax
  800924:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80092a:	83 ec 04             	sub    $0x4,%esp
  80092d:	52                   	push   %edx
  80092e:	50                   	push   %eax
  80092f:	68 60 2a 80 00       	push   $0x802a60
  800934:	e8 d8 03 00 00       	call   800d11 <cprintf>
  800939:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80093c:	a1 24 40 80 00       	mov    0x804024,%eax
  800941:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800947:	a1 24 40 80 00       	mov    0x804024,%eax
  80094c:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800952:	a1 24 40 80 00       	mov    0x804024,%eax
  800957:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80095d:	51                   	push   %ecx
  80095e:	52                   	push   %edx
  80095f:	50                   	push   %eax
  800960:	68 88 2a 80 00       	push   $0x802a88
  800965:	e8 a7 03 00 00       	call   800d11 <cprintf>
  80096a:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80096d:	a1 24 40 80 00       	mov    0x804024,%eax
  800972:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800978:	83 ec 08             	sub    $0x8,%esp
  80097b:	50                   	push   %eax
  80097c:	68 e0 2a 80 00       	push   $0x802ae0
  800981:	e8 8b 03 00 00       	call   800d11 <cprintf>
  800986:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800989:	83 ec 0c             	sub    $0xc,%esp
  80098c:	68 f4 2a 80 00       	push   $0x802af4
  800991:	e8 7b 03 00 00       	call   800d11 <cprintf>
  800996:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800999:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8009a0:	eb 28                	jmp    8009ca <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8009a2:	a1 24 40 80 00       	mov    0x804024,%eax
  8009a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009aa:	81 c2 74 04 00 00    	add    $0x474,%edx
  8009b0:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8009b3:	83 ec 04             	sub    $0x4,%esp
  8009b6:	50                   	push   %eax
  8009b7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009ba:	68 0b 2b 80 00       	push   $0x802b0b
  8009bf:	e8 4d 03 00 00       	call   800d11 <cprintf>
  8009c4:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8009c7:	ff 45 e4             	incl   -0x1c(%ebp)
  8009ca:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8009ce:	7e d2                	jle    8009a2 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8009d0:	83 ec 0c             	sub    $0xc,%esp
  8009d3:	68 1a 2b 80 00       	push   $0x802b1a
  8009d8:	e8 34 03 00 00       	call   800d11 <cprintf>
  8009dd:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8009e0:	a1 24 40 80 00       	mov    0x804024,%eax
  8009e5:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8009eb:	83 ec 08             	sub    $0x8,%esp
  8009ee:	50                   	push   %eax
  8009ef:	68 1e 2b 80 00       	push   $0x802b1e
  8009f4:	e8 18 03 00 00       	call   800d11 <cprintf>
  8009f9:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8009fc:	83 ec 0c             	sub    $0xc,%esp
  8009ff:	68 14 2a 80 00       	push   $0x802a14
  800a04:	e8 08 03 00 00       	call   800d11 <cprintf>
  800a09:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800a0c:	e8 9e 15 00 00       	call   801faf <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800a11:	e8 1f 00 00 00       	call   800a35 <exit>
}
  800a16:	90                   	nop
  800a17:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800a1a:	5b                   	pop    %ebx
  800a1b:	5e                   	pop    %esi
  800a1c:	5f                   	pop    %edi
  800a1d:	5d                   	pop    %ebp
  800a1e:	c3                   	ret    

00800a1f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800a1f:	55                   	push   %ebp
  800a20:	89 e5                	mov    %esp,%ebp
  800a22:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800a25:	83 ec 0c             	sub    $0xc,%esp
  800a28:	6a 00                	push   $0x0
  800a2a:	e8 aa 17 00 00       	call   8021d9 <sys_destroy_env>
  800a2f:	83 c4 10             	add    $0x10,%esp
}
  800a32:	90                   	nop
  800a33:	c9                   	leave  
  800a34:	c3                   	ret    

00800a35 <exit>:

void
exit(void)
{
  800a35:	55                   	push   %ebp
  800a36:	89 e5                	mov    %esp,%ebp
  800a38:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800a3b:	e8 ff 17 00 00       	call   80223f <sys_exit_env>
}
  800a40:	90                   	nop
  800a41:	c9                   	leave  
  800a42:	c3                   	ret    

00800a43 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a43:	55                   	push   %ebp
  800a44:	89 e5                	mov    %esp,%ebp
  800a46:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a49:	8d 45 10             	lea    0x10(%ebp),%eax
  800a4c:	83 c0 04             	add    $0x4,%eax
  800a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a52:	a1 28 41 80 00       	mov    0x804128,%eax
  800a57:	85 c0                	test   %eax,%eax
  800a59:	74 16                	je     800a71 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a5b:	a1 28 41 80 00       	mov    0x804128,%eax
  800a60:	83 ec 08             	sub    $0x8,%esp
  800a63:	50                   	push   %eax
  800a64:	68 00 2c 80 00       	push   $0x802c00
  800a69:	e8 a3 02 00 00       	call   800d11 <cprintf>
  800a6e:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800a71:	a1 04 40 80 00       	mov    0x804004,%eax
  800a76:	83 ec 0c             	sub    $0xc,%esp
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	ff 75 08             	pushl  0x8(%ebp)
  800a7f:	50                   	push   %eax
  800a80:	68 08 2c 80 00       	push   $0x802c08
  800a85:	6a 74                	push   $0x74
  800a87:	e8 b2 02 00 00       	call   800d3e <cprintf_colored>
  800a8c:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800a8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a92:	83 ec 08             	sub    $0x8,%esp
  800a95:	ff 75 f4             	pushl  -0xc(%ebp)
  800a98:	50                   	push   %eax
  800a99:	e8 04 02 00 00       	call   800ca2 <vcprintf>
  800a9e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	6a 00                	push   $0x0
  800aa6:	68 30 2c 80 00       	push   $0x802c30
  800aab:	e8 f2 01 00 00       	call   800ca2 <vcprintf>
  800ab0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800ab3:	e8 7d ff ff ff       	call   800a35 <exit>

	// should not return here
	while (1) ;
  800ab8:	eb fe                	jmp    800ab8 <_panic+0x75>

00800aba <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800aba:	55                   	push   %ebp
  800abb:	89 e5                	mov    %esp,%ebp
  800abd:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800ac0:	a1 24 40 80 00       	mov    0x804024,%eax
  800ac5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800acb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ace:	39 c2                	cmp    %eax,%edx
  800ad0:	74 14                	je     800ae6 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ad2:	83 ec 04             	sub    $0x4,%esp
  800ad5:	68 34 2c 80 00       	push   $0x802c34
  800ada:	6a 26                	push   $0x26
  800adc:	68 80 2c 80 00       	push   $0x802c80
  800ae1:	e8 5d ff ff ff       	call   800a43 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ae6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800aed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800af4:	e9 c5 00 00 00       	jmp    800bbe <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800af9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	01 d0                	add    %edx,%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	85 c0                	test   %eax,%eax
  800b0c:	75 08                	jne    800b16 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800b0e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800b11:	e9 a5 00 00 00       	jmp    800bbb <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800b16:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b1d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800b24:	eb 69                	jmp    800b8f <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800b26:	a1 24 40 80 00       	mov    0x804024,%eax
  800b2b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b31:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b34:	89 d0                	mov    %edx,%eax
  800b36:	01 c0                	add    %eax,%eax
  800b38:	01 d0                	add    %edx,%eax
  800b3a:	c1 e0 03             	shl    $0x3,%eax
  800b3d:	01 c8                	add    %ecx,%eax
  800b3f:	8a 40 04             	mov    0x4(%eax),%al
  800b42:	84 c0                	test   %al,%al
  800b44:	75 46                	jne    800b8c <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b46:	a1 24 40 80 00       	mov    0x804024,%eax
  800b4b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b51:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b54:	89 d0                	mov    %edx,%eax
  800b56:	01 c0                	add    %eax,%eax
  800b58:	01 d0                	add    %edx,%eax
  800b5a:	c1 e0 03             	shl    $0x3,%eax
  800b5d:	01 c8                	add    %ecx,%eax
  800b5f:	8b 00                	mov    (%eax),%eax
  800b61:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b64:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b67:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b6c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b71:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	01 c8                	add    %ecx,%eax
  800b7d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b7f:	39 c2                	cmp    %eax,%edx
  800b81:	75 09                	jne    800b8c <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800b83:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b8a:	eb 15                	jmp    800ba1 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b8c:	ff 45 e8             	incl   -0x18(%ebp)
  800b8f:	a1 24 40 80 00       	mov    0x804024,%eax
  800b94:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b9d:	39 c2                	cmp    %eax,%edx
  800b9f:	77 85                	ja     800b26 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800ba1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ba5:	75 14                	jne    800bbb <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800ba7:	83 ec 04             	sub    $0x4,%esp
  800baa:	68 8c 2c 80 00       	push   $0x802c8c
  800baf:	6a 3a                	push   $0x3a
  800bb1:	68 80 2c 80 00       	push   $0x802c80
  800bb6:	e8 88 fe ff ff       	call   800a43 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800bbb:	ff 45 f0             	incl   -0x10(%ebp)
  800bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800bc4:	0f 8c 2f ff ff ff    	jl     800af9 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800bca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bd1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800bd8:	eb 26                	jmp    800c00 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800bda:	a1 24 40 80 00       	mov    0x804024,%eax
  800bdf:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800be5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be8:	89 d0                	mov    %edx,%eax
  800bea:	01 c0                	add    %eax,%eax
  800bec:	01 d0                	add    %edx,%eax
  800bee:	c1 e0 03             	shl    $0x3,%eax
  800bf1:	01 c8                	add    %ecx,%eax
  800bf3:	8a 40 04             	mov    0x4(%eax),%al
  800bf6:	3c 01                	cmp    $0x1,%al
  800bf8:	75 03                	jne    800bfd <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800bfa:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bfd:	ff 45 e0             	incl   -0x20(%ebp)
  800c00:	a1 24 40 80 00       	mov    0x804024,%eax
  800c05:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800c0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c0e:	39 c2                	cmp    %eax,%edx
  800c10:	77 c8                	ja     800bda <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c15:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800c18:	74 14                	je     800c2e <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800c1a:	83 ec 04             	sub    $0x4,%esp
  800c1d:	68 e0 2c 80 00       	push   $0x802ce0
  800c22:	6a 44                	push   $0x44
  800c24:	68 80 2c 80 00       	push   $0x802c80
  800c29:	e8 15 fe ff ff       	call   800a43 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800c2e:	90                   	nop
  800c2f:	c9                   	leave  
  800c30:	c3                   	ret    

00800c31 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800c31:	55                   	push   %ebp
  800c32:	89 e5                	mov    %esp,%ebp
  800c34:	53                   	push   %ebx
  800c35:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3b:	8b 00                	mov    (%eax),%eax
  800c3d:	8d 48 01             	lea    0x1(%eax),%ecx
  800c40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c43:	89 0a                	mov    %ecx,(%edx)
  800c45:	8b 55 08             	mov    0x8(%ebp),%edx
  800c48:	88 d1                	mov    %dl,%cl
  800c4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8b 00                	mov    (%eax),%eax
  800c56:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c5b:	75 30                	jne    800c8d <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800c5d:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c63:	a0 40 40 80 00       	mov    0x804040,%al
  800c68:	0f b6 c0             	movzbl %al,%eax
  800c6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800c6e:	8b 09                	mov    (%ecx),%ecx
  800c70:	89 cb                	mov    %ecx,%ebx
  800c72:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800c75:	83 c1 08             	add    $0x8,%ecx
  800c78:	52                   	push   %edx
  800c79:	50                   	push   %eax
  800c7a:	53                   	push   %ebx
  800c7b:	51                   	push   %ecx
  800c7c:	e8 d0 12 00 00       	call   801f51 <sys_cputs>
  800c81:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c87:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c90:	8b 40 04             	mov    0x4(%eax),%eax
  800c93:	8d 50 01             	lea    0x1(%eax),%edx
  800c96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c99:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c9c:	90                   	nop
  800c9d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ca0:	c9                   	leave  
  800ca1:	c3                   	ret    

00800ca2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ca2:	55                   	push   %ebp
  800ca3:	89 e5                	mov    %esp,%ebp
  800ca5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800cab:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800cb2:	00 00 00 
	b.cnt = 0;
  800cb5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800cbc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800cbf:	ff 75 0c             	pushl  0xc(%ebp)
  800cc2:	ff 75 08             	pushl  0x8(%ebp)
  800cc5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ccb:	50                   	push   %eax
  800ccc:	68 31 0c 80 00       	push   $0x800c31
  800cd1:	e8 5a 02 00 00       	call   800f30 <vprintfmt>
  800cd6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800cd9:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800cdf:	a0 40 40 80 00       	mov    0x804040,%al
  800ce4:	0f b6 c0             	movzbl %al,%eax
  800ce7:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800ced:	52                   	push   %edx
  800cee:	50                   	push   %eax
  800cef:	51                   	push   %ecx
  800cf0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800cf6:	83 c0 08             	add    $0x8,%eax
  800cf9:	50                   	push   %eax
  800cfa:	e8 52 12 00 00       	call   801f51 <sys_cputs>
  800cff:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d02:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800d09:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800d0f:	c9                   	leave  
  800d10:	c3                   	ret    

00800d11 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d17:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800d1e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	83 ec 08             	sub    $0x8,%esp
  800d2a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2d:	50                   	push   %eax
  800d2e:	e8 6f ff ff ff       	call   800ca2 <vcprintf>
  800d33:	83 c4 10             	add    $0x10,%esp
  800d36:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800d39:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d3c:	c9                   	leave  
  800d3d:	c3                   	ret    

00800d3e <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d44:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	c1 e0 08             	shl    $0x8,%eax
  800d51:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800d56:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d59:	83 c0 04             	add    $0x4,%eax
  800d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 f4             	pushl  -0xc(%ebp)
  800d68:	50                   	push   %eax
  800d69:	e8 34 ff ff ff       	call   800ca2 <vcprintf>
  800d6e:	83 c4 10             	add    $0x10,%esp
  800d71:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800d74:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800d7b:	07 00 00 

	return cnt;
  800d7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d81:	c9                   	leave  
  800d82:	c3                   	ret    

00800d83 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
  800d86:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800d89:	e8 07 12 00 00       	call   801f95 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800d8e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d91:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	83 ec 08             	sub    $0x8,%esp
  800d9a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9d:	50                   	push   %eax
  800d9e:	e8 ff fe ff ff       	call   800ca2 <vcprintf>
  800da3:	83 c4 10             	add    $0x10,%esp
  800da6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800da9:	e8 01 12 00 00       	call   801faf <sys_unlock_cons>
	return cnt;
  800dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	53                   	push   %ebx
  800db7:	83 ec 14             	sub    $0x14,%esp
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc0:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800dc6:	8b 45 18             	mov    0x18(%ebp),%eax
  800dc9:	ba 00 00 00 00       	mov    $0x0,%edx
  800dce:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800dd1:	77 55                	ja     800e28 <printnum+0x75>
  800dd3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800dd6:	72 05                	jb     800ddd <printnum+0x2a>
  800dd8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ddb:	77 4b                	ja     800e28 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ddd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800de0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800de3:	8b 45 18             	mov    0x18(%ebp),%eax
  800de6:	ba 00 00 00 00       	mov    $0x0,%edx
  800deb:	52                   	push   %edx
  800dec:	50                   	push   %eax
  800ded:	ff 75 f4             	pushl  -0xc(%ebp)
  800df0:	ff 75 f0             	pushl  -0x10(%ebp)
  800df3:	e8 94 17 00 00       	call   80258c <__udivdi3>
  800df8:	83 c4 10             	add    $0x10,%esp
  800dfb:	83 ec 04             	sub    $0x4,%esp
  800dfe:	ff 75 20             	pushl  0x20(%ebp)
  800e01:	53                   	push   %ebx
  800e02:	ff 75 18             	pushl  0x18(%ebp)
  800e05:	52                   	push   %edx
  800e06:	50                   	push   %eax
  800e07:	ff 75 0c             	pushl  0xc(%ebp)
  800e0a:	ff 75 08             	pushl  0x8(%ebp)
  800e0d:	e8 a1 ff ff ff       	call   800db3 <printnum>
  800e12:	83 c4 20             	add    $0x20,%esp
  800e15:	eb 1a                	jmp    800e31 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e17:	83 ec 08             	sub    $0x8,%esp
  800e1a:	ff 75 0c             	pushl  0xc(%ebp)
  800e1d:	ff 75 20             	pushl  0x20(%ebp)
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	ff d0                	call   *%eax
  800e25:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e28:	ff 4d 1c             	decl   0x1c(%ebp)
  800e2b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e2f:	7f e6                	jg     800e17 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e31:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e34:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e39:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3f:	53                   	push   %ebx
  800e40:	51                   	push   %ecx
  800e41:	52                   	push   %edx
  800e42:	50                   	push   %eax
  800e43:	e8 54 18 00 00       	call   80269c <__umoddi3>
  800e48:	83 c4 10             	add    $0x10,%esp
  800e4b:	05 54 2f 80 00       	add    $0x802f54,%eax
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	0f be c0             	movsbl %al,%eax
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	50                   	push   %eax
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	ff d0                	call   *%eax
  800e61:	83 c4 10             	add    $0x10,%esp
}
  800e64:	90                   	nop
  800e65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800e68:	c9                   	leave  
  800e69:	c3                   	ret    

00800e6a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800e6a:	55                   	push   %ebp
  800e6b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e6d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e71:	7e 1c                	jle    800e8f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	8b 00                	mov    (%eax),%eax
  800e78:	8d 50 08             	lea    0x8(%eax),%edx
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	89 10                	mov    %edx,(%eax)
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	8b 00                	mov    (%eax),%eax
  800e85:	83 e8 08             	sub    $0x8,%eax
  800e88:	8b 50 04             	mov    0x4(%eax),%edx
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	eb 40                	jmp    800ecf <getuint+0x65>
	else if (lflag)
  800e8f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e93:	74 1e                	je     800eb3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	8b 00                	mov    (%eax),%eax
  800e9a:	8d 50 04             	lea    0x4(%eax),%edx
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	89 10                	mov    %edx,(%eax)
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	8b 00                	mov    (%eax),%eax
  800ea7:	83 e8 04             	sub    $0x4,%eax
  800eaa:	8b 00                	mov    (%eax),%eax
  800eac:	ba 00 00 00 00       	mov    $0x0,%edx
  800eb1:	eb 1c                	jmp    800ecf <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	8b 00                	mov    (%eax),%eax
  800eb8:	8d 50 04             	lea    0x4(%eax),%edx
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	89 10                	mov    %edx,(%eax)
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8b 00                	mov    (%eax),%eax
  800ec5:	83 e8 04             	sub    $0x4,%eax
  800ec8:	8b 00                	mov    (%eax),%eax
  800eca:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ecf:	5d                   	pop    %ebp
  800ed0:	c3                   	ret    

00800ed1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ed4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ed8:	7e 1c                	jle    800ef6 <getint+0x25>
		return va_arg(*ap, long long);
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8b 00                	mov    (%eax),%eax
  800edf:	8d 50 08             	lea    0x8(%eax),%edx
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	89 10                	mov    %edx,(%eax)
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8b 00                	mov    (%eax),%eax
  800eec:	83 e8 08             	sub    $0x8,%eax
  800eef:	8b 50 04             	mov    0x4(%eax),%edx
  800ef2:	8b 00                	mov    (%eax),%eax
  800ef4:	eb 38                	jmp    800f2e <getint+0x5d>
	else if (lflag)
  800ef6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800efa:	74 1a                	je     800f16 <getint+0x45>
		return va_arg(*ap, long);
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	8b 00                	mov    (%eax),%eax
  800f01:	8d 50 04             	lea    0x4(%eax),%edx
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	89 10                	mov    %edx,(%eax)
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	8b 00                	mov    (%eax),%eax
  800f0e:	83 e8 04             	sub    $0x4,%eax
  800f11:	8b 00                	mov    (%eax),%eax
  800f13:	99                   	cltd   
  800f14:	eb 18                	jmp    800f2e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	8b 00                	mov    (%eax),%eax
  800f1b:	8d 50 04             	lea    0x4(%eax),%edx
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	89 10                	mov    %edx,(%eax)
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8b 00                	mov    (%eax),%eax
  800f28:	83 e8 04             	sub    $0x4,%eax
  800f2b:	8b 00                	mov    (%eax),%eax
  800f2d:	99                   	cltd   
}
  800f2e:	5d                   	pop    %ebp
  800f2f:	c3                   	ret    

00800f30 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f30:	55                   	push   %ebp
  800f31:	89 e5                	mov    %esp,%ebp
  800f33:	56                   	push   %esi
  800f34:	53                   	push   %ebx
  800f35:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f38:	eb 17                	jmp    800f51 <vprintfmt+0x21>
			if (ch == '\0')
  800f3a:	85 db                	test   %ebx,%ebx
  800f3c:	0f 84 c1 03 00 00    	je     801303 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800f42:	83 ec 08             	sub    $0x8,%esp
  800f45:	ff 75 0c             	pushl  0xc(%ebp)
  800f48:	53                   	push   %ebx
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	ff d0                	call   *%eax
  800f4e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f51:	8b 45 10             	mov    0x10(%ebp),%eax
  800f54:	8d 50 01             	lea    0x1(%eax),%edx
  800f57:	89 55 10             	mov    %edx,0x10(%ebp)
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	0f b6 d8             	movzbl %al,%ebx
  800f5f:	83 fb 25             	cmp    $0x25,%ebx
  800f62:	75 d6                	jne    800f3a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800f64:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800f68:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800f6f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800f76:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800f7d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800f84:	8b 45 10             	mov    0x10(%ebp),%eax
  800f87:	8d 50 01             	lea    0x1(%eax),%edx
  800f8a:	89 55 10             	mov    %edx,0x10(%ebp)
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	0f b6 d8             	movzbl %al,%ebx
  800f92:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f95:	83 f8 5b             	cmp    $0x5b,%eax
  800f98:	0f 87 3d 03 00 00    	ja     8012db <vprintfmt+0x3ab>
  800f9e:	8b 04 85 78 2f 80 00 	mov    0x802f78(,%eax,4),%eax
  800fa5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800fa7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800fab:	eb d7                	jmp    800f84 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800fad:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800fb1:	eb d1                	jmp    800f84 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800fb3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800fba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800fbd:	89 d0                	mov    %edx,%eax
  800fbf:	c1 e0 02             	shl    $0x2,%eax
  800fc2:	01 d0                	add    %edx,%eax
  800fc4:	01 c0                	add    %eax,%eax
  800fc6:	01 d8                	add    %ebx,%eax
  800fc8:	83 e8 30             	sub    $0x30,%eax
  800fcb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800fce:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800fd6:	83 fb 2f             	cmp    $0x2f,%ebx
  800fd9:	7e 3e                	jle    801019 <vprintfmt+0xe9>
  800fdb:	83 fb 39             	cmp    $0x39,%ebx
  800fde:	7f 39                	jg     801019 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800fe0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800fe3:	eb d5                	jmp    800fba <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800fe5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe8:	83 c0 04             	add    $0x4,%eax
  800feb:	89 45 14             	mov    %eax,0x14(%ebp)
  800fee:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff1:	83 e8 04             	sub    $0x4,%eax
  800ff4:	8b 00                	mov    (%eax),%eax
  800ff6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ff9:	eb 1f                	jmp    80101a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ffb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fff:	79 83                	jns    800f84 <vprintfmt+0x54>
				width = 0;
  801001:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801008:	e9 77 ff ff ff       	jmp    800f84 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80100d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801014:	e9 6b ff ff ff       	jmp    800f84 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801019:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80101a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80101e:	0f 89 60 ff ff ff    	jns    800f84 <vprintfmt+0x54>
				width = precision, precision = -1;
  801024:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801027:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80102a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801031:	e9 4e ff ff ff       	jmp    800f84 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801036:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801039:	e9 46 ff ff ff       	jmp    800f84 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80103e:	8b 45 14             	mov    0x14(%ebp),%eax
  801041:	83 c0 04             	add    $0x4,%eax
  801044:	89 45 14             	mov    %eax,0x14(%ebp)
  801047:	8b 45 14             	mov    0x14(%ebp),%eax
  80104a:	83 e8 04             	sub    $0x4,%eax
  80104d:	8b 00                	mov    (%eax),%eax
  80104f:	83 ec 08             	sub    $0x8,%esp
  801052:	ff 75 0c             	pushl  0xc(%ebp)
  801055:	50                   	push   %eax
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	ff d0                	call   *%eax
  80105b:	83 c4 10             	add    $0x10,%esp
			break;
  80105e:	e9 9b 02 00 00       	jmp    8012fe <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801063:	8b 45 14             	mov    0x14(%ebp),%eax
  801066:	83 c0 04             	add    $0x4,%eax
  801069:	89 45 14             	mov    %eax,0x14(%ebp)
  80106c:	8b 45 14             	mov    0x14(%ebp),%eax
  80106f:	83 e8 04             	sub    $0x4,%eax
  801072:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801074:	85 db                	test   %ebx,%ebx
  801076:	79 02                	jns    80107a <vprintfmt+0x14a>
				err = -err;
  801078:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80107a:	83 fb 64             	cmp    $0x64,%ebx
  80107d:	7f 0b                	jg     80108a <vprintfmt+0x15a>
  80107f:	8b 34 9d c0 2d 80 00 	mov    0x802dc0(,%ebx,4),%esi
  801086:	85 f6                	test   %esi,%esi
  801088:	75 19                	jne    8010a3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80108a:	53                   	push   %ebx
  80108b:	68 65 2f 80 00       	push   $0x802f65
  801090:	ff 75 0c             	pushl  0xc(%ebp)
  801093:	ff 75 08             	pushl  0x8(%ebp)
  801096:	e8 70 02 00 00       	call   80130b <printfmt>
  80109b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80109e:	e9 5b 02 00 00       	jmp    8012fe <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8010a3:	56                   	push   %esi
  8010a4:	68 6e 2f 80 00       	push   $0x802f6e
  8010a9:	ff 75 0c             	pushl  0xc(%ebp)
  8010ac:	ff 75 08             	pushl  0x8(%ebp)
  8010af:	e8 57 02 00 00       	call   80130b <printfmt>
  8010b4:	83 c4 10             	add    $0x10,%esp
			break;
  8010b7:	e9 42 02 00 00       	jmp    8012fe <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8010bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8010bf:	83 c0 04             	add    $0x4,%eax
  8010c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8010c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8010c8:	83 e8 04             	sub    $0x4,%eax
  8010cb:	8b 30                	mov    (%eax),%esi
  8010cd:	85 f6                	test   %esi,%esi
  8010cf:	75 05                	jne    8010d6 <vprintfmt+0x1a6>
				p = "(null)";
  8010d1:	be 71 2f 80 00       	mov    $0x802f71,%esi
			if (width > 0 && padc != '-')
  8010d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010da:	7e 6d                	jle    801149 <vprintfmt+0x219>
  8010dc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8010e0:	74 67                	je     801149 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8010e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8010e5:	83 ec 08             	sub    $0x8,%esp
  8010e8:	50                   	push   %eax
  8010e9:	56                   	push   %esi
  8010ea:	e8 26 05 00 00       	call   801615 <strnlen>
  8010ef:	83 c4 10             	add    $0x10,%esp
  8010f2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8010f5:	eb 16                	jmp    80110d <vprintfmt+0x1dd>
					putch(padc, putdat);
  8010f7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8010fb:	83 ec 08             	sub    $0x8,%esp
  8010fe:	ff 75 0c             	pushl  0xc(%ebp)
  801101:	50                   	push   %eax
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	ff d0                	call   *%eax
  801107:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80110a:	ff 4d e4             	decl   -0x1c(%ebp)
  80110d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801111:	7f e4                	jg     8010f7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801113:	eb 34                	jmp    801149 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801115:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801119:	74 1c                	je     801137 <vprintfmt+0x207>
  80111b:	83 fb 1f             	cmp    $0x1f,%ebx
  80111e:	7e 05                	jle    801125 <vprintfmt+0x1f5>
  801120:	83 fb 7e             	cmp    $0x7e,%ebx
  801123:	7e 12                	jle    801137 <vprintfmt+0x207>
					putch('?', putdat);
  801125:	83 ec 08             	sub    $0x8,%esp
  801128:	ff 75 0c             	pushl  0xc(%ebp)
  80112b:	6a 3f                	push   $0x3f
  80112d:	8b 45 08             	mov    0x8(%ebp),%eax
  801130:	ff d0                	call   *%eax
  801132:	83 c4 10             	add    $0x10,%esp
  801135:	eb 0f                	jmp    801146 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801137:	83 ec 08             	sub    $0x8,%esp
  80113a:	ff 75 0c             	pushl  0xc(%ebp)
  80113d:	53                   	push   %ebx
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	ff d0                	call   *%eax
  801143:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801146:	ff 4d e4             	decl   -0x1c(%ebp)
  801149:	89 f0                	mov    %esi,%eax
  80114b:	8d 70 01             	lea    0x1(%eax),%esi
  80114e:	8a 00                	mov    (%eax),%al
  801150:	0f be d8             	movsbl %al,%ebx
  801153:	85 db                	test   %ebx,%ebx
  801155:	74 24                	je     80117b <vprintfmt+0x24b>
  801157:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80115b:	78 b8                	js     801115 <vprintfmt+0x1e5>
  80115d:	ff 4d e0             	decl   -0x20(%ebp)
  801160:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801164:	79 af                	jns    801115 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801166:	eb 13                	jmp    80117b <vprintfmt+0x24b>
				putch(' ', putdat);
  801168:	83 ec 08             	sub    $0x8,%esp
  80116b:	ff 75 0c             	pushl  0xc(%ebp)
  80116e:	6a 20                	push   $0x20
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	ff d0                	call   *%eax
  801175:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801178:	ff 4d e4             	decl   -0x1c(%ebp)
  80117b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80117f:	7f e7                	jg     801168 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801181:	e9 78 01 00 00       	jmp    8012fe <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801186:	83 ec 08             	sub    $0x8,%esp
  801189:	ff 75 e8             	pushl  -0x18(%ebp)
  80118c:	8d 45 14             	lea    0x14(%ebp),%eax
  80118f:	50                   	push   %eax
  801190:	e8 3c fd ff ff       	call   800ed1 <getint>
  801195:	83 c4 10             	add    $0x10,%esp
  801198:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80119e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011a4:	85 d2                	test   %edx,%edx
  8011a6:	79 23                	jns    8011cb <vprintfmt+0x29b>
				putch('-', putdat);
  8011a8:	83 ec 08             	sub    $0x8,%esp
  8011ab:	ff 75 0c             	pushl  0xc(%ebp)
  8011ae:	6a 2d                	push   $0x2d
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	ff d0                	call   *%eax
  8011b5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8011b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011be:	f7 d8                	neg    %eax
  8011c0:	83 d2 00             	adc    $0x0,%edx
  8011c3:	f7 da                	neg    %edx
  8011c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8011cb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8011d2:	e9 bc 00 00 00       	jmp    801293 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8011d7:	83 ec 08             	sub    $0x8,%esp
  8011da:	ff 75 e8             	pushl  -0x18(%ebp)
  8011dd:	8d 45 14             	lea    0x14(%ebp),%eax
  8011e0:	50                   	push   %eax
  8011e1:	e8 84 fc ff ff       	call   800e6a <getuint>
  8011e6:	83 c4 10             	add    $0x10,%esp
  8011e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8011ef:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8011f6:	e9 98 00 00 00       	jmp    801293 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8011fb:	83 ec 08             	sub    $0x8,%esp
  8011fe:	ff 75 0c             	pushl  0xc(%ebp)
  801201:	6a 58                	push   $0x58
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	ff d0                	call   *%eax
  801208:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80120b:	83 ec 08             	sub    $0x8,%esp
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	6a 58                	push   $0x58
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	ff d0                	call   *%eax
  801218:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80121b:	83 ec 08             	sub    $0x8,%esp
  80121e:	ff 75 0c             	pushl  0xc(%ebp)
  801221:	6a 58                	push   $0x58
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	ff d0                	call   *%eax
  801228:	83 c4 10             	add    $0x10,%esp
			break;
  80122b:	e9 ce 00 00 00       	jmp    8012fe <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801230:	83 ec 08             	sub    $0x8,%esp
  801233:	ff 75 0c             	pushl  0xc(%ebp)
  801236:	6a 30                	push   $0x30
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	ff d0                	call   *%eax
  80123d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801240:	83 ec 08             	sub    $0x8,%esp
  801243:	ff 75 0c             	pushl  0xc(%ebp)
  801246:	6a 78                	push   $0x78
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
  80124b:	ff d0                	call   *%eax
  80124d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801250:	8b 45 14             	mov    0x14(%ebp),%eax
  801253:	83 c0 04             	add    $0x4,%eax
  801256:	89 45 14             	mov    %eax,0x14(%ebp)
  801259:	8b 45 14             	mov    0x14(%ebp),%eax
  80125c:	83 e8 04             	sub    $0x4,%eax
  80125f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801261:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801264:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80126b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801272:	eb 1f                	jmp    801293 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801274:	83 ec 08             	sub    $0x8,%esp
  801277:	ff 75 e8             	pushl  -0x18(%ebp)
  80127a:	8d 45 14             	lea    0x14(%ebp),%eax
  80127d:	50                   	push   %eax
  80127e:	e8 e7 fb ff ff       	call   800e6a <getuint>
  801283:	83 c4 10             	add    $0x10,%esp
  801286:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801289:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80128c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801293:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801297:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80129a:	83 ec 04             	sub    $0x4,%esp
  80129d:	52                   	push   %edx
  80129e:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012a1:	50                   	push   %eax
  8012a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8012a5:	ff 75 f0             	pushl  -0x10(%ebp)
  8012a8:	ff 75 0c             	pushl  0xc(%ebp)
  8012ab:	ff 75 08             	pushl  0x8(%ebp)
  8012ae:	e8 00 fb ff ff       	call   800db3 <printnum>
  8012b3:	83 c4 20             	add    $0x20,%esp
			break;
  8012b6:	eb 46                	jmp    8012fe <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8012b8:	83 ec 08             	sub    $0x8,%esp
  8012bb:	ff 75 0c             	pushl  0xc(%ebp)
  8012be:	53                   	push   %ebx
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	ff d0                	call   *%eax
  8012c4:	83 c4 10             	add    $0x10,%esp
			break;
  8012c7:	eb 35                	jmp    8012fe <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8012c9:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  8012d0:	eb 2c                	jmp    8012fe <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8012d2:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  8012d9:	eb 23                	jmp    8012fe <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8012db:	83 ec 08             	sub    $0x8,%esp
  8012de:	ff 75 0c             	pushl  0xc(%ebp)
  8012e1:	6a 25                	push   $0x25
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	ff d0                	call   *%eax
  8012e8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8012eb:	ff 4d 10             	decl   0x10(%ebp)
  8012ee:	eb 03                	jmp    8012f3 <vprintfmt+0x3c3>
  8012f0:	ff 4d 10             	decl   0x10(%ebp)
  8012f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f6:	48                   	dec    %eax
  8012f7:	8a 00                	mov    (%eax),%al
  8012f9:	3c 25                	cmp    $0x25,%al
  8012fb:	75 f3                	jne    8012f0 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8012fd:	90                   	nop
		}
	}
  8012fe:	e9 35 fc ff ff       	jmp    800f38 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801303:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801304:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801307:	5b                   	pop    %ebx
  801308:	5e                   	pop    %esi
  801309:	5d                   	pop    %ebp
  80130a:	c3                   	ret    

0080130b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
  80130e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801311:	8d 45 10             	lea    0x10(%ebp),%eax
  801314:	83 c0 04             	add    $0x4,%eax
  801317:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80131a:	8b 45 10             	mov    0x10(%ebp),%eax
  80131d:	ff 75 f4             	pushl  -0xc(%ebp)
  801320:	50                   	push   %eax
  801321:	ff 75 0c             	pushl  0xc(%ebp)
  801324:	ff 75 08             	pushl  0x8(%ebp)
  801327:	e8 04 fc ff ff       	call   800f30 <vprintfmt>
  80132c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80132f:	90                   	nop
  801330:	c9                   	leave  
  801331:	c3                   	ret    

00801332 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801332:	55                   	push   %ebp
  801333:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801335:	8b 45 0c             	mov    0xc(%ebp),%eax
  801338:	8b 40 08             	mov    0x8(%eax),%eax
  80133b:	8d 50 01             	lea    0x1(%eax),%edx
  80133e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801341:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	8b 10                	mov    (%eax),%edx
  801349:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134c:	8b 40 04             	mov    0x4(%eax),%eax
  80134f:	39 c2                	cmp    %eax,%edx
  801351:	73 12                	jae    801365 <sprintputch+0x33>
		*b->buf++ = ch;
  801353:	8b 45 0c             	mov    0xc(%ebp),%eax
  801356:	8b 00                	mov    (%eax),%eax
  801358:	8d 48 01             	lea    0x1(%eax),%ecx
  80135b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135e:	89 0a                	mov    %ecx,(%edx)
  801360:	8b 55 08             	mov    0x8(%ebp),%edx
  801363:	88 10                	mov    %dl,(%eax)
}
  801365:	90                   	nop
  801366:	5d                   	pop    %ebp
  801367:	c3                   	ret    

00801368 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
  80136b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801374:	8b 45 0c             	mov    0xc(%ebp),%eax
  801377:	8d 50 ff             	lea    -0x1(%eax),%edx
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	01 d0                	add    %edx,%eax
  80137f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801382:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801389:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80138d:	74 06                	je     801395 <vsnprintf+0x2d>
  80138f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801393:	7f 07                	jg     80139c <vsnprintf+0x34>
		return -E_INVAL;
  801395:	b8 03 00 00 00       	mov    $0x3,%eax
  80139a:	eb 20                	jmp    8013bc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80139c:	ff 75 14             	pushl  0x14(%ebp)
  80139f:	ff 75 10             	pushl  0x10(%ebp)
  8013a2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8013a5:	50                   	push   %eax
  8013a6:	68 32 13 80 00       	push   $0x801332
  8013ab:	e8 80 fb ff ff       	call   800f30 <vprintfmt>
  8013b0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8013b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013b6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8013b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
  8013c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8013c4:	8d 45 10             	lea    0x10(%ebp),%eax
  8013c7:	83 c0 04             	add    $0x4,%eax
  8013ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8013cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8013d3:	50                   	push   %eax
  8013d4:	ff 75 0c             	pushl  0xc(%ebp)
  8013d7:	ff 75 08             	pushl  0x8(%ebp)
  8013da:	e8 89 ff ff ff       	call   801368 <vsnprintf>
  8013df:	83 c4 10             	add    $0x10,%esp
  8013e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8013e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
  8013ed:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  8013f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013f4:	74 13                	je     801409 <readline+0x1f>
		cprintf("%s", prompt);
  8013f6:	83 ec 08             	sub    $0x8,%esp
  8013f9:	ff 75 08             	pushl  0x8(%ebp)
  8013fc:	68 e8 30 80 00       	push   $0x8030e8
  801401:	e8 0b f9 ff ff       	call   800d11 <cprintf>
  801406:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801410:	83 ec 0c             	sub    $0xc,%esp
  801413:	6a 00                	push   $0x0
  801415:	e8 bf f3 ff ff       	call   8007d9 <iscons>
  80141a:	83 c4 10             	add    $0x10,%esp
  80141d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801420:	e8 9b f3 ff ff       	call   8007c0 <getchar>
  801425:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801428:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80142c:	79 22                	jns    801450 <readline+0x66>
			if (c != -E_EOF)
  80142e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801432:	0f 84 ad 00 00 00    	je     8014e5 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801438:	83 ec 08             	sub    $0x8,%esp
  80143b:	ff 75 ec             	pushl  -0x14(%ebp)
  80143e:	68 eb 30 80 00       	push   $0x8030eb
  801443:	e8 c9 f8 ff ff       	call   800d11 <cprintf>
  801448:	83 c4 10             	add    $0x10,%esp
			break;
  80144b:	e9 95 00 00 00       	jmp    8014e5 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801450:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801454:	7e 34                	jle    80148a <readline+0xa0>
  801456:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80145d:	7f 2b                	jg     80148a <readline+0xa0>
			if (echoing)
  80145f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801463:	74 0e                	je     801473 <readline+0x89>
				cputchar(c);
  801465:	83 ec 0c             	sub    $0xc,%esp
  801468:	ff 75 ec             	pushl  -0x14(%ebp)
  80146b:	e8 31 f3 ff ff       	call   8007a1 <cputchar>
  801470:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801473:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801476:	8d 50 01             	lea    0x1(%eax),%edx
  801479:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80147c:	89 c2                	mov    %eax,%edx
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	01 d0                	add    %edx,%eax
  801483:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801486:	88 10                	mov    %dl,(%eax)
  801488:	eb 56                	jmp    8014e0 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80148a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80148e:	75 1f                	jne    8014af <readline+0xc5>
  801490:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801494:	7e 19                	jle    8014af <readline+0xc5>
			if (echoing)
  801496:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80149a:	74 0e                	je     8014aa <readline+0xc0>
				cputchar(c);
  80149c:	83 ec 0c             	sub    $0xc,%esp
  80149f:	ff 75 ec             	pushl  -0x14(%ebp)
  8014a2:	e8 fa f2 ff ff       	call   8007a1 <cputchar>
  8014a7:	83 c4 10             	add    $0x10,%esp

			i--;
  8014aa:	ff 4d f4             	decl   -0xc(%ebp)
  8014ad:	eb 31                	jmp    8014e0 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8014af:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8014b3:	74 0a                	je     8014bf <readline+0xd5>
  8014b5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8014b9:	0f 85 61 ff ff ff    	jne    801420 <readline+0x36>
			if (echoing)
  8014bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8014c3:	74 0e                	je     8014d3 <readline+0xe9>
				cputchar(c);
  8014c5:	83 ec 0c             	sub    $0xc,%esp
  8014c8:	ff 75 ec             	pushl  -0x14(%ebp)
  8014cb:	e8 d1 f2 ff ff       	call   8007a1 <cputchar>
  8014d0:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8014d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d9:	01 d0                	add    %edx,%eax
  8014db:	c6 00 00             	movb   $0x0,(%eax)
			break;
  8014de:	eb 06                	jmp    8014e6 <readline+0xfc>
		}
	}
  8014e0:	e9 3b ff ff ff       	jmp    801420 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  8014e5:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  8014e6:	90                   	nop
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  8014ef:	e8 a1 0a 00 00       	call   801f95 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  8014f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014f8:	74 13                	je     80150d <atomic_readline+0x24>
			cprintf("%s", prompt);
  8014fa:	83 ec 08             	sub    $0x8,%esp
  8014fd:	ff 75 08             	pushl  0x8(%ebp)
  801500:	68 e8 30 80 00       	push   $0x8030e8
  801505:	e8 07 f8 ff ff       	call   800d11 <cprintf>
  80150a:	83 c4 10             	add    $0x10,%esp

		i = 0;
  80150d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  801514:	83 ec 0c             	sub    $0xc,%esp
  801517:	6a 00                	push   $0x0
  801519:	e8 bb f2 ff ff       	call   8007d9 <iscons>
  80151e:	83 c4 10             	add    $0x10,%esp
  801521:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  801524:	e8 97 f2 ff ff       	call   8007c0 <getchar>
  801529:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  80152c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801530:	79 22                	jns    801554 <atomic_readline+0x6b>
				if (c != -E_EOF)
  801532:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801536:	0f 84 ad 00 00 00    	je     8015e9 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  80153c:	83 ec 08             	sub    $0x8,%esp
  80153f:	ff 75 ec             	pushl  -0x14(%ebp)
  801542:	68 eb 30 80 00       	push   $0x8030eb
  801547:	e8 c5 f7 ff ff       	call   800d11 <cprintf>
  80154c:	83 c4 10             	add    $0x10,%esp
				break;
  80154f:	e9 95 00 00 00       	jmp    8015e9 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  801554:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801558:	7e 34                	jle    80158e <atomic_readline+0xa5>
  80155a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801561:	7f 2b                	jg     80158e <atomic_readline+0xa5>
				if (echoing)
  801563:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801567:	74 0e                	je     801577 <atomic_readline+0x8e>
					cputchar(c);
  801569:	83 ec 0c             	sub    $0xc,%esp
  80156c:	ff 75 ec             	pushl  -0x14(%ebp)
  80156f:	e8 2d f2 ff ff       	call   8007a1 <cputchar>
  801574:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  801577:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80157a:	8d 50 01             	lea    0x1(%eax),%edx
  80157d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801580:	89 c2                	mov    %eax,%edx
  801582:	8b 45 0c             	mov    0xc(%ebp),%eax
  801585:	01 d0                	add    %edx,%eax
  801587:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80158a:	88 10                	mov    %dl,(%eax)
  80158c:	eb 56                	jmp    8015e4 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  80158e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801592:	75 1f                	jne    8015b3 <atomic_readline+0xca>
  801594:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801598:	7e 19                	jle    8015b3 <atomic_readline+0xca>
				if (echoing)
  80159a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80159e:	74 0e                	je     8015ae <atomic_readline+0xc5>
					cputchar(c);
  8015a0:	83 ec 0c             	sub    $0xc,%esp
  8015a3:	ff 75 ec             	pushl  -0x14(%ebp)
  8015a6:	e8 f6 f1 ff ff       	call   8007a1 <cputchar>
  8015ab:	83 c4 10             	add    $0x10,%esp
				i--;
  8015ae:	ff 4d f4             	decl   -0xc(%ebp)
  8015b1:	eb 31                	jmp    8015e4 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  8015b3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8015b7:	74 0a                	je     8015c3 <atomic_readline+0xda>
  8015b9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8015bd:	0f 85 61 ff ff ff    	jne    801524 <atomic_readline+0x3b>
				if (echoing)
  8015c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8015c7:	74 0e                	je     8015d7 <atomic_readline+0xee>
					cputchar(c);
  8015c9:	83 ec 0c             	sub    $0xc,%esp
  8015cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8015cf:	e8 cd f1 ff ff       	call   8007a1 <cputchar>
  8015d4:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  8015d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015dd:	01 d0                	add    %edx,%eax
  8015df:	c6 00 00             	movb   $0x0,(%eax)
				break;
  8015e2:	eb 06                	jmp    8015ea <atomic_readline+0x101>
			}
		}
  8015e4:	e9 3b ff ff ff       	jmp    801524 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  8015e9:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  8015ea:	e8 c0 09 00 00       	call   801faf <sys_unlock_cons>
}
  8015ef:	90                   	nop
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8015f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015ff:	eb 06                	jmp    801607 <strlen+0x15>
		n++;
  801601:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801604:	ff 45 08             	incl   0x8(%ebp)
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	8a 00                	mov    (%eax),%al
  80160c:	84 c0                	test   %al,%al
  80160e:	75 f1                	jne    801601 <strlen+0xf>
		n++;
	return n;
  801610:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
  801618:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80161b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801622:	eb 09                	jmp    80162d <strnlen+0x18>
		n++;
  801624:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801627:	ff 45 08             	incl   0x8(%ebp)
  80162a:	ff 4d 0c             	decl   0xc(%ebp)
  80162d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801631:	74 09                	je     80163c <strnlen+0x27>
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	84 c0                	test   %al,%al
  80163a:	75 e8                	jne    801624 <strnlen+0xf>
		n++;
	return n;
  80163c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80164d:	90                   	nop
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8d 50 01             	lea    0x1(%eax),%edx
  801654:	89 55 08             	mov    %edx,0x8(%ebp)
  801657:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80165d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801660:	8a 12                	mov    (%edx),%dl
  801662:	88 10                	mov    %dl,(%eax)
  801664:	8a 00                	mov    (%eax),%al
  801666:	84 c0                	test   %al,%al
  801668:	75 e4                	jne    80164e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80167b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801682:	eb 1f                	jmp    8016a3 <strncpy+0x34>
		*dst++ = *src;
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	8d 50 01             	lea    0x1(%eax),%edx
  80168a:	89 55 08             	mov    %edx,0x8(%ebp)
  80168d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801690:	8a 12                	mov    (%edx),%dl
  801692:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801694:	8b 45 0c             	mov    0xc(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	84 c0                	test   %al,%al
  80169b:	74 03                	je     8016a0 <strncpy+0x31>
			src++;
  80169d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016a0:	ff 45 fc             	incl   -0x4(%ebp)
  8016a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016a9:	72 d9                	jb     801684 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
  8016b3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8016bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c0:	74 30                	je     8016f2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8016c2:	eb 16                	jmp    8016da <strlcpy+0x2a>
			*dst++ = *src++;
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8d 50 01             	lea    0x1(%eax),%edx
  8016ca:	89 55 08             	mov    %edx,0x8(%ebp)
  8016cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016d3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016d6:	8a 12                	mov    (%edx),%dl
  8016d8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8016da:	ff 4d 10             	decl   0x10(%ebp)
  8016dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e1:	74 09                	je     8016ec <strlcpy+0x3c>
  8016e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	84 c0                	test   %al,%al
  8016ea:	75 d8                	jne    8016c4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8016f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8016f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f8:	29 c2                	sub    %eax,%edx
  8016fa:	89 d0                	mov    %edx,%eax
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801701:	eb 06                	jmp    801709 <strcmp+0xb>
		p++, q++;
  801703:	ff 45 08             	incl   0x8(%ebp)
  801706:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	8a 00                	mov    (%eax),%al
  80170e:	84 c0                	test   %al,%al
  801710:	74 0e                	je     801720 <strcmp+0x22>
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	8a 10                	mov    (%eax),%dl
  801717:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	38 c2                	cmp    %al,%dl
  80171e:	74 e3                	je     801703 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	8a 00                	mov    (%eax),%al
  801725:	0f b6 d0             	movzbl %al,%edx
  801728:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172b:	8a 00                	mov    (%eax),%al
  80172d:	0f b6 c0             	movzbl %al,%eax
  801730:	29 c2                	sub    %eax,%edx
  801732:	89 d0                	mov    %edx,%eax
}
  801734:	5d                   	pop    %ebp
  801735:	c3                   	ret    

00801736 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801739:	eb 09                	jmp    801744 <strncmp+0xe>
		n--, p++, q++;
  80173b:	ff 4d 10             	decl   0x10(%ebp)
  80173e:	ff 45 08             	incl   0x8(%ebp)
  801741:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801744:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801748:	74 17                	je     801761 <strncmp+0x2b>
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	8a 00                	mov    (%eax),%al
  80174f:	84 c0                	test   %al,%al
  801751:	74 0e                	je     801761 <strncmp+0x2b>
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	8a 10                	mov    (%eax),%dl
  801758:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	38 c2                	cmp    %al,%dl
  80175f:	74 da                	je     80173b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801761:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801765:	75 07                	jne    80176e <strncmp+0x38>
		return 0;
  801767:	b8 00 00 00 00       	mov    $0x0,%eax
  80176c:	eb 14                	jmp    801782 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80176e:	8b 45 08             	mov    0x8(%ebp),%eax
  801771:	8a 00                	mov    (%eax),%al
  801773:	0f b6 d0             	movzbl %al,%edx
  801776:	8b 45 0c             	mov    0xc(%ebp),%eax
  801779:	8a 00                	mov    (%eax),%al
  80177b:	0f b6 c0             	movzbl %al,%eax
  80177e:	29 c2                	sub    %eax,%edx
  801780:	89 d0                	mov    %edx,%eax
}
  801782:	5d                   	pop    %ebp
  801783:	c3                   	ret    

00801784 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
  801787:	83 ec 04             	sub    $0x4,%esp
  80178a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801790:	eb 12                	jmp    8017a4 <strchr+0x20>
		if (*s == c)
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
  801795:	8a 00                	mov    (%eax),%al
  801797:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80179a:	75 05                	jne    8017a1 <strchr+0x1d>
			return (char *) s;
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	eb 11                	jmp    8017b2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017a1:	ff 45 08             	incl   0x8(%ebp)
  8017a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a7:	8a 00                	mov    (%eax),%al
  8017a9:	84 c0                	test   %al,%al
  8017ab:	75 e5                	jne    801792 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 04             	sub    $0x4,%esp
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017c0:	eb 0d                	jmp    8017cf <strfind+0x1b>
		if (*s == c)
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017ca:	74 0e                	je     8017da <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8017cc:	ff 45 08             	incl   0x8(%ebp)
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	8a 00                	mov    (%eax),%al
  8017d4:	84 c0                	test   %al,%al
  8017d6:	75 ea                	jne    8017c2 <strfind+0xe>
  8017d8:	eb 01                	jmp    8017db <strfind+0x27>
		if (*s == c)
			break;
  8017da:	90                   	nop
	return (char *) s;
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
  8017e3:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8017e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8017ec:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8017f0:	76 63                	jbe    801855 <memset+0x75>
		uint64 data_block = c;
  8017f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f5:	99                   	cltd   
  8017f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8017f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8017fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801802:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801806:	c1 e0 08             	shl    $0x8,%eax
  801809:	09 45 f0             	or     %eax,-0x10(%ebp)
  80180c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80180f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801812:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801815:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801819:	c1 e0 10             	shl    $0x10,%eax
  80181c:	09 45 f0             	or     %eax,-0x10(%ebp)
  80181f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801822:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801825:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801828:	89 c2                	mov    %eax,%edx
  80182a:	b8 00 00 00 00       	mov    $0x0,%eax
  80182f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801832:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801835:	eb 18                	jmp    80184f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801837:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80183a:	8d 41 08             	lea    0x8(%ecx),%eax
  80183d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801840:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801843:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801846:	89 01                	mov    %eax,(%ecx)
  801848:	89 51 04             	mov    %edx,0x4(%ecx)
  80184b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80184f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801853:	77 e2                	ja     801837 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801855:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801859:	74 23                	je     80187e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80185b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80185e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801861:	eb 0e                	jmp    801871 <memset+0x91>
			*p8++ = (uint8)c;
  801863:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801866:	8d 50 01             	lea    0x1(%eax),%edx
  801869:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80186c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801871:	8b 45 10             	mov    0x10(%ebp),%eax
  801874:	8d 50 ff             	lea    -0x1(%eax),%edx
  801877:	89 55 10             	mov    %edx,0x10(%ebp)
  80187a:	85 c0                	test   %eax,%eax
  80187c:	75 e5                	jne    801863 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80187e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
  801886:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801889:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801895:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801899:	76 24                	jbe    8018bf <memcpy+0x3c>
		while(n >= 8){
  80189b:	eb 1c                	jmp    8018b9 <memcpy+0x36>
			*d64 = *s64;
  80189d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a0:	8b 50 04             	mov    0x4(%eax),%edx
  8018a3:	8b 00                	mov    (%eax),%eax
  8018a5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018a8:	89 01                	mov    %eax,(%ecx)
  8018aa:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8018ad:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8018b1:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8018b5:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8018b9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8018bd:	77 de                	ja     80189d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8018bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018c3:	74 31                	je     8018f6 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8018c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8018cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8018d1:	eb 16                	jmp    8018e9 <memcpy+0x66>
			*d8++ = *s8++;
  8018d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d6:	8d 50 01             	lea    0x1(%eax),%edx
  8018d9:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8018dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018df:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018e2:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8018e5:	8a 12                	mov    (%edx),%dl
  8018e7:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8018e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8018f2:	85 c0                	test   %eax,%eax
  8018f4:	75 dd                	jne    8018d3 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018f9:	c9                   	leave  
  8018fa:	c3                   	ret    

008018fb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
  8018fe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801901:	8b 45 0c             	mov    0xc(%ebp),%eax
  801904:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80190d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801910:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801913:	73 50                	jae    801965 <memmove+0x6a>
  801915:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801918:	8b 45 10             	mov    0x10(%ebp),%eax
  80191b:	01 d0                	add    %edx,%eax
  80191d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801920:	76 43                	jbe    801965 <memmove+0x6a>
		s += n;
  801922:	8b 45 10             	mov    0x10(%ebp),%eax
  801925:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801928:	8b 45 10             	mov    0x10(%ebp),%eax
  80192b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80192e:	eb 10                	jmp    801940 <memmove+0x45>
			*--d = *--s;
  801930:	ff 4d f8             	decl   -0x8(%ebp)
  801933:	ff 4d fc             	decl   -0x4(%ebp)
  801936:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801939:	8a 10                	mov    (%eax),%dl
  80193b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80193e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801940:	8b 45 10             	mov    0x10(%ebp),%eax
  801943:	8d 50 ff             	lea    -0x1(%eax),%edx
  801946:	89 55 10             	mov    %edx,0x10(%ebp)
  801949:	85 c0                	test   %eax,%eax
  80194b:	75 e3                	jne    801930 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80194d:	eb 23                	jmp    801972 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80194f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801952:	8d 50 01             	lea    0x1(%eax),%edx
  801955:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801958:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80195b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80195e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801961:	8a 12                	mov    (%edx),%dl
  801963:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801965:	8b 45 10             	mov    0x10(%ebp),%eax
  801968:	8d 50 ff             	lea    -0x1(%eax),%edx
  80196b:	89 55 10             	mov    %edx,0x10(%ebp)
  80196e:	85 c0                	test   %eax,%eax
  801970:	75 dd                	jne    80194f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801975:	c9                   	leave  
  801976:	c3                   	ret    

00801977 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801977:	55                   	push   %ebp
  801978:	89 e5                	mov    %esp,%ebp
  80197a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801983:	8b 45 0c             	mov    0xc(%ebp),%eax
  801986:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801989:	eb 2a                	jmp    8019b5 <memcmp+0x3e>
		if (*s1 != *s2)
  80198b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80198e:	8a 10                	mov    (%eax),%dl
  801990:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801993:	8a 00                	mov    (%eax),%al
  801995:	38 c2                	cmp    %al,%dl
  801997:	74 16                	je     8019af <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801999:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	0f b6 d0             	movzbl %al,%edx
  8019a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a4:	8a 00                	mov    (%eax),%al
  8019a6:	0f b6 c0             	movzbl %al,%eax
  8019a9:	29 c2                	sub    %eax,%edx
  8019ab:	89 d0                	mov    %edx,%eax
  8019ad:	eb 18                	jmp    8019c7 <memcmp+0x50>
		s1++, s2++;
  8019af:	ff 45 fc             	incl   -0x4(%ebp)
  8019b2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8019b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8019bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8019be:	85 c0                	test   %eax,%eax
  8019c0:	75 c9                	jne    80198b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8019c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019c7:	c9                   	leave  
  8019c8:	c3                   	ret    

008019c9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8019c9:	55                   	push   %ebp
  8019ca:	89 e5                	mov    %esp,%ebp
  8019cc:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8019cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8019d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d5:	01 d0                	add    %edx,%eax
  8019d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8019da:	eb 15                	jmp    8019f1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	8a 00                	mov    (%eax),%al
  8019e1:	0f b6 d0             	movzbl %al,%edx
  8019e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e7:	0f b6 c0             	movzbl %al,%eax
  8019ea:	39 c2                	cmp    %eax,%edx
  8019ec:	74 0d                	je     8019fb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8019ee:	ff 45 08             	incl   0x8(%ebp)
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019f7:	72 e3                	jb     8019dc <memfind+0x13>
  8019f9:	eb 01                	jmp    8019fc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8019fb:	90                   	nop
	return (void *) s;
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
  801a04:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801a07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801a0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a15:	eb 03                	jmp    801a1a <strtol+0x19>
		s++;
  801a17:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	8a 00                	mov    (%eax),%al
  801a1f:	3c 20                	cmp    $0x20,%al
  801a21:	74 f4                	je     801a17 <strtol+0x16>
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	8a 00                	mov    (%eax),%al
  801a28:	3c 09                	cmp    $0x9,%al
  801a2a:	74 eb                	je     801a17 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2f:	8a 00                	mov    (%eax),%al
  801a31:	3c 2b                	cmp    $0x2b,%al
  801a33:	75 05                	jne    801a3a <strtol+0x39>
		s++;
  801a35:	ff 45 08             	incl   0x8(%ebp)
  801a38:	eb 13                	jmp    801a4d <strtol+0x4c>
	else if (*s == '-')
  801a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3d:	8a 00                	mov    (%eax),%al
  801a3f:	3c 2d                	cmp    $0x2d,%al
  801a41:	75 0a                	jne    801a4d <strtol+0x4c>
		s++, neg = 1;
  801a43:	ff 45 08             	incl   0x8(%ebp)
  801a46:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801a4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a51:	74 06                	je     801a59 <strtol+0x58>
  801a53:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801a57:	75 20                	jne    801a79 <strtol+0x78>
  801a59:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5c:	8a 00                	mov    (%eax),%al
  801a5e:	3c 30                	cmp    $0x30,%al
  801a60:	75 17                	jne    801a79 <strtol+0x78>
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	40                   	inc    %eax
  801a66:	8a 00                	mov    (%eax),%al
  801a68:	3c 78                	cmp    $0x78,%al
  801a6a:	75 0d                	jne    801a79 <strtol+0x78>
		s += 2, base = 16;
  801a6c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801a70:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801a77:	eb 28                	jmp    801aa1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801a79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a7d:	75 15                	jne    801a94 <strtol+0x93>
  801a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a82:	8a 00                	mov    (%eax),%al
  801a84:	3c 30                	cmp    $0x30,%al
  801a86:	75 0c                	jne    801a94 <strtol+0x93>
		s++, base = 8;
  801a88:	ff 45 08             	incl   0x8(%ebp)
  801a8b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a92:	eb 0d                	jmp    801aa1 <strtol+0xa0>
	else if (base == 0)
  801a94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a98:	75 07                	jne    801aa1 <strtol+0xa0>
		base = 10;
  801a9a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa4:	8a 00                	mov    (%eax),%al
  801aa6:	3c 2f                	cmp    $0x2f,%al
  801aa8:	7e 19                	jle    801ac3 <strtol+0xc2>
  801aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801aad:	8a 00                	mov    (%eax),%al
  801aaf:	3c 39                	cmp    $0x39,%al
  801ab1:	7f 10                	jg     801ac3 <strtol+0xc2>
			dig = *s - '0';
  801ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab6:	8a 00                	mov    (%eax),%al
  801ab8:	0f be c0             	movsbl %al,%eax
  801abb:	83 e8 30             	sub    $0x30,%eax
  801abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ac1:	eb 42                	jmp    801b05 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac6:	8a 00                	mov    (%eax),%al
  801ac8:	3c 60                	cmp    $0x60,%al
  801aca:	7e 19                	jle    801ae5 <strtol+0xe4>
  801acc:	8b 45 08             	mov    0x8(%ebp),%eax
  801acf:	8a 00                	mov    (%eax),%al
  801ad1:	3c 7a                	cmp    $0x7a,%al
  801ad3:	7f 10                	jg     801ae5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad8:	8a 00                	mov    (%eax),%al
  801ada:	0f be c0             	movsbl %al,%eax
  801add:	83 e8 57             	sub    $0x57,%eax
  801ae0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ae3:	eb 20                	jmp    801b05 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae8:	8a 00                	mov    (%eax),%al
  801aea:	3c 40                	cmp    $0x40,%al
  801aec:	7e 39                	jle    801b27 <strtol+0x126>
  801aee:	8b 45 08             	mov    0x8(%ebp),%eax
  801af1:	8a 00                	mov    (%eax),%al
  801af3:	3c 5a                	cmp    $0x5a,%al
  801af5:	7f 30                	jg     801b27 <strtol+0x126>
			dig = *s - 'A' + 10;
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	8a 00                	mov    (%eax),%al
  801afc:	0f be c0             	movsbl %al,%eax
  801aff:	83 e8 37             	sub    $0x37,%eax
  801b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b08:	3b 45 10             	cmp    0x10(%ebp),%eax
  801b0b:	7d 19                	jge    801b26 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801b0d:	ff 45 08             	incl   0x8(%ebp)
  801b10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b13:	0f af 45 10          	imul   0x10(%ebp),%eax
  801b17:	89 c2                	mov    %eax,%edx
  801b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b1c:	01 d0                	add    %edx,%eax
  801b1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801b21:	e9 7b ff ff ff       	jmp    801aa1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801b26:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801b27:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b2b:	74 08                	je     801b35 <strtol+0x134>
		*endptr = (char *) s;
  801b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b30:	8b 55 08             	mov    0x8(%ebp),%edx
  801b33:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801b35:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b39:	74 07                	je     801b42 <strtol+0x141>
  801b3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b3e:	f7 d8                	neg    %eax
  801b40:	eb 03                	jmp    801b45 <strtol+0x144>
  801b42:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b45:	c9                   	leave  
  801b46:	c3                   	ret    

00801b47 <ltostr>:

void
ltostr(long value, char *str)
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
  801b4a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801b4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801b54:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801b5b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b5f:	79 13                	jns    801b74 <ltostr+0x2d>
	{
		neg = 1;
  801b61:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801b68:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b6b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801b6e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801b71:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801b74:	8b 45 08             	mov    0x8(%ebp),%eax
  801b77:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801b7c:	99                   	cltd   
  801b7d:	f7 f9                	idiv   %ecx
  801b7f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b82:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b85:	8d 50 01             	lea    0x1(%eax),%edx
  801b88:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b8b:	89 c2                	mov    %eax,%edx
  801b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b90:	01 d0                	add    %edx,%eax
  801b92:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b95:	83 c2 30             	add    $0x30,%edx
  801b98:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b9a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b9d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ba2:	f7 e9                	imul   %ecx
  801ba4:	c1 fa 02             	sar    $0x2,%edx
  801ba7:	89 c8                	mov    %ecx,%eax
  801ba9:	c1 f8 1f             	sar    $0x1f,%eax
  801bac:	29 c2                	sub    %eax,%edx
  801bae:	89 d0                	mov    %edx,%eax
  801bb0:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801bb3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801bb7:	75 bb                	jne    801b74 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801bb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801bc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bc3:	48                   	dec    %eax
  801bc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801bc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801bcb:	74 3d                	je     801c0a <ltostr+0xc3>
		start = 1 ;
  801bcd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801bd4:	eb 34                	jmp    801c0a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801bd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bdc:	01 d0                	add    %edx,%eax
  801bde:	8a 00                	mov    (%eax),%al
  801be0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801be3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801be6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be9:	01 c2                	add    %eax,%edx
  801beb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bf1:	01 c8                	add    %ecx,%eax
  801bf3:	8a 00                	mov    (%eax),%al
  801bf5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801bf7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bfd:	01 c2                	add    %eax,%edx
  801bff:	8a 45 eb             	mov    -0x15(%ebp),%al
  801c02:	88 02                	mov    %al,(%edx)
		start++ ;
  801c04:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801c07:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c0d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c10:	7c c4                	jl     801bd6 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801c12:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c18:	01 d0                	add    %edx,%eax
  801c1a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801c1d:	90                   	nop
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
  801c23:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801c26:	ff 75 08             	pushl  0x8(%ebp)
  801c29:	e8 c4 f9 ff ff       	call   8015f2 <strlen>
  801c2e:	83 c4 04             	add    $0x4,%esp
  801c31:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801c34:	ff 75 0c             	pushl  0xc(%ebp)
  801c37:	e8 b6 f9 ff ff       	call   8015f2 <strlen>
  801c3c:	83 c4 04             	add    $0x4,%esp
  801c3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c50:	eb 17                	jmp    801c69 <strcconcat+0x49>
		final[s] = str1[s] ;
  801c52:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c55:	8b 45 10             	mov    0x10(%ebp),%eax
  801c58:	01 c2                	add    %eax,%edx
  801c5a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c60:	01 c8                	add    %ecx,%eax
  801c62:	8a 00                	mov    (%eax),%al
  801c64:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c66:	ff 45 fc             	incl   -0x4(%ebp)
  801c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c6c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c6f:	7c e1                	jl     801c52 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c71:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c78:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c7f:	eb 1f                	jmp    801ca0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c84:	8d 50 01             	lea    0x1(%eax),%edx
  801c87:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c8a:	89 c2                	mov    %eax,%edx
  801c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c8f:	01 c2                	add    %eax,%edx
  801c91:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c94:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c97:	01 c8                	add    %ecx,%eax
  801c99:	8a 00                	mov    (%eax),%al
  801c9b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c9d:	ff 45 f8             	incl   -0x8(%ebp)
  801ca0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ca3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ca6:	7c d9                	jl     801c81 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ca8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cab:	8b 45 10             	mov    0x10(%ebp),%eax
  801cae:	01 d0                	add    %edx,%eax
  801cb0:	c6 00 00             	movb   $0x0,(%eax)
}
  801cb3:	90                   	nop
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801cb9:	8b 45 14             	mov    0x14(%ebp),%eax
  801cbc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801cc2:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc5:	8b 00                	mov    (%eax),%eax
  801cc7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cce:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd1:	01 d0                	add    %edx,%eax
  801cd3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801cd9:	eb 0c                	jmp    801ce7 <strsplit+0x31>
			*string++ = 0;
  801cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cde:	8d 50 01             	lea    0x1(%eax),%edx
  801ce1:	89 55 08             	mov    %edx,0x8(%ebp)
  801ce4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cea:	8a 00                	mov    (%eax),%al
  801cec:	84 c0                	test   %al,%al
  801cee:	74 18                	je     801d08 <strsplit+0x52>
  801cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf3:	8a 00                	mov    (%eax),%al
  801cf5:	0f be c0             	movsbl %al,%eax
  801cf8:	50                   	push   %eax
  801cf9:	ff 75 0c             	pushl  0xc(%ebp)
  801cfc:	e8 83 fa ff ff       	call   801784 <strchr>
  801d01:	83 c4 08             	add    $0x8,%esp
  801d04:	85 c0                	test   %eax,%eax
  801d06:	75 d3                	jne    801cdb <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801d08:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0b:	8a 00                	mov    (%eax),%al
  801d0d:	84 c0                	test   %al,%al
  801d0f:	74 5a                	je     801d6b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801d11:	8b 45 14             	mov    0x14(%ebp),%eax
  801d14:	8b 00                	mov    (%eax),%eax
  801d16:	83 f8 0f             	cmp    $0xf,%eax
  801d19:	75 07                	jne    801d22 <strsplit+0x6c>
		{
			return 0;
  801d1b:	b8 00 00 00 00       	mov    $0x0,%eax
  801d20:	eb 66                	jmp    801d88 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801d22:	8b 45 14             	mov    0x14(%ebp),%eax
  801d25:	8b 00                	mov    (%eax),%eax
  801d27:	8d 48 01             	lea    0x1(%eax),%ecx
  801d2a:	8b 55 14             	mov    0x14(%ebp),%edx
  801d2d:	89 0a                	mov    %ecx,(%edx)
  801d2f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d36:	8b 45 10             	mov    0x10(%ebp),%eax
  801d39:	01 c2                	add    %eax,%edx
  801d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d40:	eb 03                	jmp    801d45 <strsplit+0x8f>
			string++;
  801d42:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d45:	8b 45 08             	mov    0x8(%ebp),%eax
  801d48:	8a 00                	mov    (%eax),%al
  801d4a:	84 c0                	test   %al,%al
  801d4c:	74 8b                	je     801cd9 <strsplit+0x23>
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	8a 00                	mov    (%eax),%al
  801d53:	0f be c0             	movsbl %al,%eax
  801d56:	50                   	push   %eax
  801d57:	ff 75 0c             	pushl  0xc(%ebp)
  801d5a:	e8 25 fa ff ff       	call   801784 <strchr>
  801d5f:	83 c4 08             	add    $0x8,%esp
  801d62:	85 c0                	test   %eax,%eax
  801d64:	74 dc                	je     801d42 <strsplit+0x8c>
			string++;
	}
  801d66:	e9 6e ff ff ff       	jmp    801cd9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d6b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d6c:	8b 45 14             	mov    0x14(%ebp),%eax
  801d6f:	8b 00                	mov    (%eax),%eax
  801d71:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d78:	8b 45 10             	mov    0x10(%ebp),%eax
  801d7b:	01 d0                	add    %edx,%eax
  801d7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d83:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
  801d8d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801d90:	8b 45 08             	mov    0x8(%ebp),%eax
  801d93:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801d96:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d9d:	eb 4a                	jmp    801de9 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801d9f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801da2:	8b 45 08             	mov    0x8(%ebp),%eax
  801da5:	01 c2                	add    %eax,%edx
  801da7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dad:	01 c8                	add    %ecx,%eax
  801daf:	8a 00                	mov    (%eax),%al
  801db1:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801db3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801db9:	01 d0                	add    %edx,%eax
  801dbb:	8a 00                	mov    (%eax),%al
  801dbd:	3c 40                	cmp    $0x40,%al
  801dbf:	7e 25                	jle    801de6 <str2lower+0x5c>
  801dc1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dc7:	01 d0                	add    %edx,%eax
  801dc9:	8a 00                	mov    (%eax),%al
  801dcb:	3c 5a                	cmp    $0x5a,%al
  801dcd:	7f 17                	jg     801de6 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801dcf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd5:	01 d0                	add    %edx,%eax
  801dd7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801dda:	8b 55 08             	mov    0x8(%ebp),%edx
  801ddd:	01 ca                	add    %ecx,%edx
  801ddf:	8a 12                	mov    (%edx),%dl
  801de1:	83 c2 20             	add    $0x20,%edx
  801de4:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801de6:	ff 45 fc             	incl   -0x4(%ebp)
  801de9:	ff 75 0c             	pushl  0xc(%ebp)
  801dec:	e8 01 f8 ff ff       	call   8015f2 <strlen>
  801df1:	83 c4 04             	add    $0x4,%esp
  801df4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801df7:	7f a6                	jg     801d9f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801df9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801dfc:	c9                   	leave  
  801dfd:	c3                   	ret    

00801dfe <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801dfe:	55                   	push   %ebp
  801dff:	89 e5                	mov    %esp,%ebp
  801e01:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801e04:	a1 08 40 80 00       	mov    0x804008,%eax
  801e09:	85 c0                	test   %eax,%eax
  801e0b:	74 2d                	je     801e3a <uheap_init+0x3c>
	{
		buddy_init();
  801e0d:	e8 87 06 00 00       	call   802499 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801e12:	e8 31 05 00 00       	call   802348 <sys_get_uheap_strategy>
  801e17:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801e1c:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801e23:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801e26:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801e2d:	00 00 80 
		__firstTimeFlag = 0;
  801e30:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801e37:	00 00 00 
	}
}
  801e3a:	90                   	nop
  801e3b:	c9                   	leave  
  801e3c:	c3                   	ret    

00801e3d <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801e3d:	55                   	push   %ebp
  801e3e:	89 e5                	mov    %esp,%ebp
  801e40:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801e43:	83 ec 04             	sub    $0x4,%esp
  801e46:	68 fc 30 80 00       	push   $0x8030fc
  801e4b:	6a 25                	push   $0x25
  801e4d:	68 2d 31 80 00       	push   $0x80312d
  801e52:	e8 ec eb ff ff       	call   800a43 <_panic>

00801e57 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
  801e5a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801e5d:	83 ec 04             	sub    $0x4,%esp
  801e60:	68 3c 31 80 00       	push   $0x80313c
  801e65:	6a 2f                	push   $0x2f
  801e67:	68 2d 31 80 00       	push   $0x80312d
  801e6c:	e8 d2 eb ff ff       	call   800a43 <_panic>

00801e71 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801e71:	55                   	push   %ebp
  801e72:	89 e5                	mov    %esp,%ebp
  801e74:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801e77:	e8 82 ff ff ff       	call   801dfe <uheap_init>
	if (size == 0) return NULL ;
  801e7c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e80:	75 07                	jne    801e89 <malloc+0x18>
  801e82:	b8 00 00 00 00       	mov    $0x0,%eax
  801e87:	eb 14                	jmp    801e9d <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801e89:	83 ec 04             	sub    $0x4,%esp
  801e8c:	68 70 31 80 00       	push   $0x803170
  801e91:	6a 43                	push   $0x43
  801e93:	68 2d 31 80 00       	push   $0x80312d
  801e98:	e8 a6 eb ff ff       	call   800a43 <_panic>
}
  801e9d:	c9                   	leave  
  801e9e:	c3                   	ret    

00801e9f <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801e9f:	55                   	push   %ebp
  801ea0:	89 e5                	mov    %esp,%ebp
  801ea2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801ea5:	83 ec 04             	sub    $0x4,%esp
  801ea8:	68 98 31 80 00       	push   $0x803198
  801ead:	6a 4e                	push   $0x4e
  801eaf:	68 2d 31 80 00       	push   $0x80312d
  801eb4:	e8 8a eb ff ff       	call   800a43 <_panic>

00801eb9 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
  801ebc:	83 ec 18             	sub    $0x18,%esp
  801ebf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec2:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ec5:	e8 34 ff ff ff       	call   801dfe <uheap_init>
	if (size == 0) return NULL ;
  801eca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ece:	75 07                	jne    801ed7 <smalloc+0x1e>
  801ed0:	b8 00 00 00 00       	mov    $0x0,%eax
  801ed5:	eb 14                	jmp    801eeb <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801ed7:	83 ec 04             	sub    $0x4,%esp
  801eda:	68 bc 31 80 00       	push   $0x8031bc
  801edf:	6a 5f                	push   $0x5f
  801ee1:	68 2d 31 80 00       	push   $0x80312d
  801ee6:	e8 58 eb ff ff       	call   800a43 <_panic>
}
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
  801ef0:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ef3:	e8 06 ff ff ff       	call   801dfe <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801ef8:	83 ec 04             	sub    $0x4,%esp
  801efb:	68 e4 31 80 00       	push   $0x8031e4
  801f00:	6a 6f                	push   $0x6f
  801f02:	68 2d 31 80 00       	push   $0x80312d
  801f07:	e8 37 eb ff ff       	call   800a43 <_panic>

00801f0c <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801f0c:	55                   	push   %ebp
  801f0d:	89 e5                	mov    %esp,%ebp
  801f0f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801f12:	83 ec 04             	sub    $0x4,%esp
  801f15:	68 08 32 80 00       	push   $0x803208
  801f1a:	6a 7e                	push   $0x7e
  801f1c:	68 2d 31 80 00       	push   $0x80312d
  801f21:	e8 1d eb ff ff       	call   800a43 <_panic>

00801f26 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f26:	55                   	push   %ebp
  801f27:	89 e5                	mov    %esp,%ebp
  801f29:	57                   	push   %edi
  801f2a:	56                   	push   %esi
  801f2b:	53                   	push   %ebx
  801f2c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f32:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f35:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f38:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f3b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f3e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f41:	cd 30                	int    $0x30
  801f43:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f46:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f49:	83 c4 10             	add    $0x10,%esp
  801f4c:	5b                   	pop    %ebx
  801f4d:	5e                   	pop    %esi
  801f4e:	5f                   	pop    %edi
  801f4f:	5d                   	pop    %ebp
  801f50:	c3                   	ret    

00801f51 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
  801f54:	83 ec 04             	sub    $0x4,%esp
  801f57:	8b 45 10             	mov    0x10(%ebp),%eax
  801f5a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801f5d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f60:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f64:	8b 45 08             	mov    0x8(%ebp),%eax
  801f67:	6a 00                	push   $0x0
  801f69:	51                   	push   %ecx
  801f6a:	52                   	push   %edx
  801f6b:	ff 75 0c             	pushl  0xc(%ebp)
  801f6e:	50                   	push   %eax
  801f6f:	6a 00                	push   $0x0
  801f71:	e8 b0 ff ff ff       	call   801f26 <syscall>
  801f76:	83 c4 18             	add    $0x18,%esp
}
  801f79:	90                   	nop
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_cgetc>:

int
sys_cgetc(void)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 02                	push   $0x2
  801f8b:	e8 96 ff ff ff       	call   801f26 <syscall>
  801f90:	83 c4 18             	add    $0x18,%esp
}
  801f93:	c9                   	leave  
  801f94:	c3                   	ret    

00801f95 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801f95:	55                   	push   %ebp
  801f96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 03                	push   $0x3
  801fa4:	e8 7d ff ff ff       	call   801f26 <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
}
  801fac:	90                   	nop
  801fad:	c9                   	leave  
  801fae:	c3                   	ret    

00801faf <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801faf:	55                   	push   %ebp
  801fb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 04                	push   $0x4
  801fbe:	e8 63 ff ff ff       	call   801f26 <syscall>
  801fc3:	83 c4 18             	add    $0x18,%esp
}
  801fc6:	90                   	nop
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801fcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	52                   	push   %edx
  801fd9:	50                   	push   %eax
  801fda:	6a 08                	push   $0x8
  801fdc:	e8 45 ff ff ff       	call   801f26 <syscall>
  801fe1:	83 c4 18             	add    $0x18,%esp
}
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
  801fe9:	56                   	push   %esi
  801fea:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801feb:	8b 75 18             	mov    0x18(%ebp),%esi
  801fee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ff1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ff4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffa:	56                   	push   %esi
  801ffb:	53                   	push   %ebx
  801ffc:	51                   	push   %ecx
  801ffd:	52                   	push   %edx
  801ffe:	50                   	push   %eax
  801fff:	6a 09                	push   $0x9
  802001:	e8 20 ff ff ff       	call   801f26 <syscall>
  802006:	83 c4 18             	add    $0x18,%esp
}
  802009:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80200c:	5b                   	pop    %ebx
  80200d:	5e                   	pop    %esi
  80200e:	5d                   	pop    %ebp
  80200f:	c3                   	ret    

00802010 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  802010:	55                   	push   %ebp
  802011:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	ff 75 08             	pushl  0x8(%ebp)
  80201e:	6a 0a                	push   $0xa
  802020:	e8 01 ff ff ff       	call   801f26 <syscall>
  802025:	83 c4 18             	add    $0x18,%esp
}
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	ff 75 0c             	pushl  0xc(%ebp)
  802036:	ff 75 08             	pushl  0x8(%ebp)
  802039:	6a 0b                	push   $0xb
  80203b:	e8 e6 fe ff ff       	call   801f26 <syscall>
  802040:	83 c4 18             	add    $0x18,%esp
}
  802043:	c9                   	leave  
  802044:	c3                   	ret    

00802045 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802045:	55                   	push   %ebp
  802046:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 0c                	push   $0xc
  802054:	e8 cd fe ff ff       	call   801f26 <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
}
  80205c:	c9                   	leave  
  80205d:	c3                   	ret    

0080205e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80205e:	55                   	push   %ebp
  80205f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 0d                	push   $0xd
  80206d:	e8 b4 fe ff ff       	call   801f26 <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	c9                   	leave  
  802076:	c3                   	ret    

00802077 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802077:	55                   	push   %ebp
  802078:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 0e                	push   $0xe
  802086:	e8 9b fe ff ff       	call   801f26 <syscall>
  80208b:	83 c4 18             	add    $0x18,%esp
}
  80208e:	c9                   	leave  
  80208f:	c3                   	ret    

00802090 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802090:	55                   	push   %ebp
  802091:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 0f                	push   $0xf
  80209f:	e8 82 fe ff ff       	call   801f26 <syscall>
  8020a4:	83 c4 18             	add    $0x18,%esp
}
  8020a7:	c9                   	leave  
  8020a8:	c3                   	ret    

008020a9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020a9:	55                   	push   %ebp
  8020aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	ff 75 08             	pushl  0x8(%ebp)
  8020b7:	6a 10                	push   $0x10
  8020b9:	e8 68 fe ff ff       	call   801f26 <syscall>
  8020be:	83 c4 18             	add    $0x18,%esp
}
  8020c1:	c9                   	leave  
  8020c2:	c3                   	ret    

008020c3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8020c3:	55                   	push   %ebp
  8020c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 11                	push   $0x11
  8020d2:	e8 4f fe ff ff       	call   801f26 <syscall>
  8020d7:	83 c4 18             	add    $0x18,%esp
}
  8020da:	90                   	nop
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <sys_cputc>:

void
sys_cputc(const char c)
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
  8020e0:	83 ec 04             	sub    $0x4,%esp
  8020e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020e9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	50                   	push   %eax
  8020f6:	6a 01                	push   $0x1
  8020f8:	e8 29 fe ff ff       	call   801f26 <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
}
  802100:	90                   	nop
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 14                	push   $0x14
  802112:	e8 0f fe ff ff       	call   801f26 <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
}
  80211a:	90                   	nop
  80211b:	c9                   	leave  
  80211c:	c3                   	ret    

0080211d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80211d:	55                   	push   %ebp
  80211e:	89 e5                	mov    %esp,%ebp
  802120:	83 ec 04             	sub    $0x4,%esp
  802123:	8b 45 10             	mov    0x10(%ebp),%eax
  802126:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  802129:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80212c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802130:	8b 45 08             	mov    0x8(%ebp),%eax
  802133:	6a 00                	push   $0x0
  802135:	51                   	push   %ecx
  802136:	52                   	push   %edx
  802137:	ff 75 0c             	pushl  0xc(%ebp)
  80213a:	50                   	push   %eax
  80213b:	6a 15                	push   $0x15
  80213d:	e8 e4 fd ff ff       	call   801f26 <syscall>
  802142:	83 c4 18             	add    $0x18,%esp
}
  802145:	c9                   	leave  
  802146:	c3                   	ret    

00802147 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  802147:	55                   	push   %ebp
  802148:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80214a:	8b 55 10             	mov    0x10(%ebp),%edx
  80214d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	52                   	push   %edx
  802155:	50                   	push   %eax
  802156:	ff 75 08             	pushl  0x8(%ebp)
  802159:	6a 16                	push   $0x16
  80215b:	e8 c6 fd ff ff       	call   801f26 <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
}
  802163:	c9                   	leave  
  802164:	c3                   	ret    

00802165 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  802165:	55                   	push   %ebp
  802166:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  802168:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216b:	8b 45 08             	mov    0x8(%ebp),%eax
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	52                   	push   %edx
  802175:	50                   	push   %eax
  802176:	6a 17                	push   $0x17
  802178:	e8 a9 fd ff ff       	call   801f26 <syscall>
  80217d:	83 c4 18             	add    $0x18,%esp
}
  802180:	c9                   	leave  
  802181:	c3                   	ret    

00802182 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  802182:	55                   	push   %ebp
  802183:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  802185:	8b 55 0c             	mov    0xc(%ebp),%edx
  802188:	8b 45 08             	mov    0x8(%ebp),%eax
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	52                   	push   %edx
  802192:	50                   	push   %eax
  802193:	6a 18                	push   $0x18
  802195:	e8 8c fd ff ff       	call   801f26 <syscall>
  80219a:	83 c4 18             	add    $0x18,%esp
}
  80219d:	c9                   	leave  
  80219e:	c3                   	ret    

0080219f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80219f:	55                   	push   %ebp
  8021a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a5:	6a 00                	push   $0x0
  8021a7:	ff 75 14             	pushl  0x14(%ebp)
  8021aa:	ff 75 10             	pushl  0x10(%ebp)
  8021ad:	ff 75 0c             	pushl  0xc(%ebp)
  8021b0:	50                   	push   %eax
  8021b1:	6a 19                	push   $0x19
  8021b3:	e8 6e fd ff ff       	call   801f26 <syscall>
  8021b8:	83 c4 18             	add    $0x18,%esp
}
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <sys_run_env>:

void sys_run_env(int32 envId)
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	50                   	push   %eax
  8021cc:	6a 1a                	push   $0x1a
  8021ce:	e8 53 fd ff ff       	call   801f26 <syscall>
  8021d3:	83 c4 18             	add    $0x18,%esp
}
  8021d6:	90                   	nop
  8021d7:	c9                   	leave  
  8021d8:	c3                   	ret    

008021d9 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8021d9:	55                   	push   %ebp
  8021da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8021dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	50                   	push   %eax
  8021e8:	6a 1b                	push   $0x1b
  8021ea:	e8 37 fd ff ff       	call   801f26 <syscall>
  8021ef:	83 c4 18             	add    $0x18,%esp
}
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 05                	push   $0x5
  802203:	e8 1e fd ff ff       	call   801f26 <syscall>
  802208:	83 c4 18             	add    $0x18,%esp
}
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 06                	push   $0x6
  80221c:	e8 05 fd ff ff       	call   801f26 <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
}
  802224:	c9                   	leave  
  802225:	c3                   	ret    

00802226 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802226:	55                   	push   %ebp
  802227:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 07                	push   $0x7
  802235:	e8 ec fc ff ff       	call   801f26 <syscall>
  80223a:	83 c4 18             	add    $0x18,%esp
}
  80223d:	c9                   	leave  
  80223e:	c3                   	ret    

0080223f <sys_exit_env>:


void sys_exit_env(void)
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 1c                	push   $0x1c
  80224e:	e8 d3 fc ff ff       	call   801f26 <syscall>
  802253:	83 c4 18             	add    $0x18,%esp
}
  802256:	90                   	nop
  802257:	c9                   	leave  
  802258:	c3                   	ret    

00802259 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802259:	55                   	push   %ebp
  80225a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	ff 75 10             	pushl  0x10(%ebp)
  802263:	ff 75 0c             	pushl  0xc(%ebp)
  802266:	ff 75 08             	pushl  0x8(%ebp)
  802269:	6a 13                	push   $0x13
  80226b:	e8 b6 fc ff ff       	call   801f26 <syscall>
  802270:	83 c4 18             	add    $0x18,%esp
	return ;
  802273:	90                   	nop
}
  802274:	c9                   	leave  
  802275:	c3                   	ret    

00802276 <sys_rcr2>:
uint32 sys_rcr2()
{
  802276:	55                   	push   %ebp
  802277:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 1e                	push   $0x1e
  802285:	e8 9c fc ff ff       	call   801f26 <syscall>
  80228a:	83 c4 18             	add    $0x18,%esp
}
  80228d:	c9                   	leave  
  80228e:	c3                   	ret    

0080228f <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80228f:	55                   	push   %ebp
  802290:	89 e5                	mov    %esp,%ebp
  802292:	83 ec 04             	sub    $0x4,%esp
  802295:	8b 45 08             	mov    0x8(%ebp),%eax
  802298:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80229b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 00                	push   $0x0
  8022a3:	6a 00                	push   $0x0
  8022a5:	6a 00                	push   $0x0
  8022a7:	50                   	push   %eax
  8022a8:	6a 1f                	push   $0x1f
  8022aa:	e8 77 fc ff ff       	call   801f26 <syscall>
  8022af:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b2:	90                   	nop
}
  8022b3:	c9                   	leave  
  8022b4:	c3                   	ret    

008022b5 <rsttst>:
void rsttst()
{
  8022b5:	55                   	push   %ebp
  8022b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 21                	push   $0x21
  8022c4:	e8 5d fc ff ff       	call   801f26 <syscall>
  8022c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022cc:	90                   	nop
}
  8022cd:	c9                   	leave  
  8022ce:	c3                   	ret    

008022cf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8022cf:	55                   	push   %ebp
  8022d0:	89 e5                	mov    %esp,%ebp
  8022d2:	83 ec 04             	sub    $0x4,%esp
  8022d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8022d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022db:	8b 55 18             	mov    0x18(%ebp),%edx
  8022de:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022e2:	52                   	push   %edx
  8022e3:	50                   	push   %eax
  8022e4:	ff 75 10             	pushl  0x10(%ebp)
  8022e7:	ff 75 0c             	pushl  0xc(%ebp)
  8022ea:	ff 75 08             	pushl  0x8(%ebp)
  8022ed:	6a 20                	push   $0x20
  8022ef:	e8 32 fc ff ff       	call   801f26 <syscall>
  8022f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f7:	90                   	nop
}
  8022f8:	c9                   	leave  
  8022f9:	c3                   	ret    

008022fa <chktst>:
void chktst(uint32 n)
{
  8022fa:	55                   	push   %ebp
  8022fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	ff 75 08             	pushl  0x8(%ebp)
  802308:	6a 22                	push   $0x22
  80230a:	e8 17 fc ff ff       	call   801f26 <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
	return ;
  802312:	90                   	nop
}
  802313:	c9                   	leave  
  802314:	c3                   	ret    

00802315 <inctst>:

void inctst()
{
  802315:	55                   	push   %ebp
  802316:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	6a 23                	push   $0x23
  802324:	e8 fd fb ff ff       	call   801f26 <syscall>
  802329:	83 c4 18             	add    $0x18,%esp
	return ;
  80232c:	90                   	nop
}
  80232d:	c9                   	leave  
  80232e:	c3                   	ret    

0080232f <gettst>:
uint32 gettst()
{
  80232f:	55                   	push   %ebp
  802330:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 24                	push   $0x24
  80233e:	e8 e3 fb ff ff       	call   801f26 <syscall>
  802343:	83 c4 18             	add    $0x18,%esp
}
  802346:	c9                   	leave  
  802347:	c3                   	ret    

00802348 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802348:	55                   	push   %ebp
  802349:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 25                	push   $0x25
  802357:	e8 ca fb ff ff       	call   801f26 <syscall>
  80235c:	83 c4 18             	add    $0x18,%esp
  80235f:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  802364:	a1 48 40 80 00       	mov    0x804048,%eax
}
  802369:	c9                   	leave  
  80236a:	c3                   	ret    

0080236b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80236b:	55                   	push   %ebp
  80236c:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80236e:	8b 45 08             	mov    0x8(%ebp),%eax
  802371:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	ff 75 08             	pushl  0x8(%ebp)
  802381:	6a 26                	push   $0x26
  802383:	e8 9e fb ff ff       	call   801f26 <syscall>
  802388:	83 c4 18             	add    $0x18,%esp
	return ;
  80238b:	90                   	nop
}
  80238c:	c9                   	leave  
  80238d:	c3                   	ret    

0080238e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80238e:	55                   	push   %ebp
  80238f:	89 e5                	mov    %esp,%ebp
  802391:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802392:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802395:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80239b:	8b 45 08             	mov    0x8(%ebp),%eax
  80239e:	6a 00                	push   $0x0
  8023a0:	53                   	push   %ebx
  8023a1:	51                   	push   %ecx
  8023a2:	52                   	push   %edx
  8023a3:	50                   	push   %eax
  8023a4:	6a 27                	push   $0x27
  8023a6:	e8 7b fb ff ff       	call   801f26 <syscall>
  8023ab:	83 c4 18             	add    $0x18,%esp
}
  8023ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023b1:	c9                   	leave  
  8023b2:	c3                   	ret    

008023b3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023b3:	55                   	push   %ebp
  8023b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	52                   	push   %edx
  8023c3:	50                   	push   %eax
  8023c4:	6a 28                	push   $0x28
  8023c6:	e8 5b fb ff ff       	call   801f26 <syscall>
  8023cb:	83 c4 18             	add    $0x18,%esp
}
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8023d0:	55                   	push   %ebp
  8023d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8023d3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8023d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023dc:	6a 00                	push   $0x0
  8023de:	51                   	push   %ecx
  8023df:	ff 75 10             	pushl  0x10(%ebp)
  8023e2:	52                   	push   %edx
  8023e3:	50                   	push   %eax
  8023e4:	6a 29                	push   $0x29
  8023e6:	e8 3b fb ff ff       	call   801f26 <syscall>
  8023eb:	83 c4 18             	add    $0x18,%esp
}
  8023ee:	c9                   	leave  
  8023ef:	c3                   	ret    

008023f0 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8023f0:	55                   	push   %ebp
  8023f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8023f3:	6a 00                	push   $0x0
  8023f5:	6a 00                	push   $0x0
  8023f7:	ff 75 10             	pushl  0x10(%ebp)
  8023fa:	ff 75 0c             	pushl  0xc(%ebp)
  8023fd:	ff 75 08             	pushl  0x8(%ebp)
  802400:	6a 12                	push   $0x12
  802402:	e8 1f fb ff ff       	call   801f26 <syscall>
  802407:	83 c4 18             	add    $0x18,%esp
	return ;
  80240a:	90                   	nop
}
  80240b:	c9                   	leave  
  80240c:	c3                   	ret    

0080240d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80240d:	55                   	push   %ebp
  80240e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802410:	8b 55 0c             	mov    0xc(%ebp),%edx
  802413:	8b 45 08             	mov    0x8(%ebp),%eax
  802416:	6a 00                	push   $0x0
  802418:	6a 00                	push   $0x0
  80241a:	6a 00                	push   $0x0
  80241c:	52                   	push   %edx
  80241d:	50                   	push   %eax
  80241e:	6a 2a                	push   $0x2a
  802420:	e8 01 fb ff ff       	call   801f26 <syscall>
  802425:	83 c4 18             	add    $0x18,%esp
	return;
  802428:	90                   	nop
}
  802429:	c9                   	leave  
  80242a:	c3                   	ret    

0080242b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80242b:	55                   	push   %ebp
  80242c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80242e:	6a 00                	push   $0x0
  802430:	6a 00                	push   $0x0
  802432:	6a 00                	push   $0x0
  802434:	6a 00                	push   $0x0
  802436:	6a 00                	push   $0x0
  802438:	6a 2b                	push   $0x2b
  80243a:	e8 e7 fa ff ff       	call   801f26 <syscall>
  80243f:	83 c4 18             	add    $0x18,%esp
}
  802442:	c9                   	leave  
  802443:	c3                   	ret    

00802444 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802444:	55                   	push   %ebp
  802445:	89 e5                	mov    %esp,%ebp
  802447:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80244a:	83 ec 04             	sub    $0x4,%esp
  80244d:	68 2c 32 80 00       	push   $0x80322c
  802452:	68 0a 01 00 00       	push   $0x10a
  802457:	68 3c 32 80 00       	push   $0x80323c
  80245c:	e8 e2 e5 ff ff       	call   800a43 <_panic>

00802461 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  802461:	55                   	push   %ebp
  802462:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802464:	6a 00                	push   $0x0
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	ff 75 0c             	pushl  0xc(%ebp)
  80246d:	ff 75 08             	pushl  0x8(%ebp)
  802470:	6a 33                	push   $0x33
  802472:	e8 af fa ff ff       	call   801f26 <syscall>
  802477:	83 c4 18             	add    $0x18,%esp
	return;
  80247a:	90                   	nop
}
  80247b:	c9                   	leave  
  80247c:	c3                   	ret    

0080247d <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80247d:	55                   	push   %ebp
  80247e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 00                	push   $0x0
  802486:	ff 75 0c             	pushl  0xc(%ebp)
  802489:	ff 75 08             	pushl  0x8(%ebp)
  80248c:	6a 34                	push   $0x34
  80248e:	e8 93 fa ff ff       	call   801f26 <syscall>
  802493:	83 c4 18             	add    $0x18,%esp
	return ;
  802496:	90                   	nop
}
  802497:	c9                   	leave  
  802498:	c3                   	ret    

00802499 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  802499:	55                   	push   %ebp
  80249a:	89 e5                	mov    %esp,%ebp
  80249c:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  80249f:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8024a6:	eb 36                	jmp    8024de <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8024a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024ab:	c1 e0 04             	shl    $0x4,%eax
  8024ae:	05 60 40 80 00       	add    $0x804060,%eax
  8024b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8024b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024bc:	c1 e0 04             	shl    $0x4,%eax
  8024bf:	05 64 40 80 00       	add    $0x804064,%eax
  8024c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8024ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024cd:	c1 e0 04             	shl    $0x4,%eax
  8024d0:	05 6c 40 80 00       	add    $0x80406c,%eax
  8024d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8024db:	ff 45 fc             	incl   -0x4(%ebp)
  8024de:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  8024e2:	7e c4                	jle    8024a8 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  8024e4:	90                   	nop
  8024e5:	c9                   	leave  
  8024e6:	c3                   	ret    

008024e7 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  8024e7:	55                   	push   %ebp
  8024e8:	89 e5                	mov    %esp,%ebp
  8024ea:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  8024ed:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  8024f4:	eb 24                	jmp    80251a <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  8024f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024f9:	c1 e0 04             	shl    $0x4,%eax
  8024fc:	05 6c 40 80 00       	add    $0x80406c,%eax
  802501:	8b 00                	mov    (%eax),%eax
  802503:	83 ec 04             	sub    $0x4,%esp
  802506:	50                   	push   %eax
  802507:	ff 75 f4             	pushl  -0xc(%ebp)
  80250a:	68 4c 32 80 00       	push   $0x80324c
  80250f:	e8 fd e7 ff ff       	call   800d11 <cprintf>
  802514:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802517:	ff 45 f4             	incl   -0xc(%ebp)
  80251a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  80251e:	7e d6                	jle    8024f6 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802520:	90                   	nop
  802521:	c9                   	leave  
  802522:	c3                   	ret    

00802523 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  802523:	55                   	push   %ebp
  802524:	89 e5                	mov    %esp,%ebp
  802526:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802529:	83 ec 04             	sub    $0x4,%esp
  80252c:	68 5c 32 80 00       	push   $0x80325c
  802531:	6a 33                	push   $0x33
  802533:	68 7d 32 80 00       	push   $0x80327d
  802538:	e8 06 e5 ff ff       	call   800a43 <_panic>

0080253d <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80253d:	55                   	push   %ebp
  80253e:	89 e5                	mov    %esp,%ebp
  802540:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  802543:	83 ec 04             	sub    $0x4,%esp
  802546:	68 95 32 80 00       	push   $0x803295
  80254b:	6a 3e                	push   $0x3e
  80254d:	68 7d 32 80 00       	push   $0x80327d
  802552:	e8 ec e4 ff ff       	call   800a43 <_panic>

00802557 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802557:	55                   	push   %ebp
  802558:	89 e5                	mov    %esp,%ebp
  80255a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  80255d:	83 ec 04             	sub    $0x4,%esp
  802560:	68 b3 32 80 00       	push   $0x8032b3
  802565:	6a 49                	push   $0x49
  802567:	68 7d 32 80 00       	push   $0x80327d
  80256c:	e8 d2 e4 ff ff       	call   800a43 <_panic>

00802571 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  802571:	55                   	push   %ebp
  802572:	89 e5                	mov    %esp,%ebp
  802574:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802577:	83 ec 04             	sub    $0x4,%esp
  80257a:	68 d0 32 80 00       	push   $0x8032d0
  80257f:	6a 58                	push   $0x58
  802581:	68 7d 32 80 00       	push   $0x80327d
  802586:	e8 b8 e4 ff ff       	call   800a43 <_panic>
  80258b:	90                   	nop

0080258c <__udivdi3>:
  80258c:	55                   	push   %ebp
  80258d:	57                   	push   %edi
  80258e:	56                   	push   %esi
  80258f:	53                   	push   %ebx
  802590:	83 ec 1c             	sub    $0x1c,%esp
  802593:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802597:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80259b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80259f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025a3:	89 ca                	mov    %ecx,%edx
  8025a5:	89 f8                	mov    %edi,%eax
  8025a7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025ab:	85 f6                	test   %esi,%esi
  8025ad:	75 2d                	jne    8025dc <__udivdi3+0x50>
  8025af:	39 cf                	cmp    %ecx,%edi
  8025b1:	77 65                	ja     802618 <__udivdi3+0x8c>
  8025b3:	89 fd                	mov    %edi,%ebp
  8025b5:	85 ff                	test   %edi,%edi
  8025b7:	75 0b                	jne    8025c4 <__udivdi3+0x38>
  8025b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8025be:	31 d2                	xor    %edx,%edx
  8025c0:	f7 f7                	div    %edi
  8025c2:	89 c5                	mov    %eax,%ebp
  8025c4:	31 d2                	xor    %edx,%edx
  8025c6:	89 c8                	mov    %ecx,%eax
  8025c8:	f7 f5                	div    %ebp
  8025ca:	89 c1                	mov    %eax,%ecx
  8025cc:	89 d8                	mov    %ebx,%eax
  8025ce:	f7 f5                	div    %ebp
  8025d0:	89 cf                	mov    %ecx,%edi
  8025d2:	89 fa                	mov    %edi,%edx
  8025d4:	83 c4 1c             	add    $0x1c,%esp
  8025d7:	5b                   	pop    %ebx
  8025d8:	5e                   	pop    %esi
  8025d9:	5f                   	pop    %edi
  8025da:	5d                   	pop    %ebp
  8025db:	c3                   	ret    
  8025dc:	39 ce                	cmp    %ecx,%esi
  8025de:	77 28                	ja     802608 <__udivdi3+0x7c>
  8025e0:	0f bd fe             	bsr    %esi,%edi
  8025e3:	83 f7 1f             	xor    $0x1f,%edi
  8025e6:	75 40                	jne    802628 <__udivdi3+0x9c>
  8025e8:	39 ce                	cmp    %ecx,%esi
  8025ea:	72 0a                	jb     8025f6 <__udivdi3+0x6a>
  8025ec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8025f0:	0f 87 9e 00 00 00    	ja     802694 <__udivdi3+0x108>
  8025f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8025fb:	89 fa                	mov    %edi,%edx
  8025fd:	83 c4 1c             	add    $0x1c,%esp
  802600:	5b                   	pop    %ebx
  802601:	5e                   	pop    %esi
  802602:	5f                   	pop    %edi
  802603:	5d                   	pop    %ebp
  802604:	c3                   	ret    
  802605:	8d 76 00             	lea    0x0(%esi),%esi
  802608:	31 ff                	xor    %edi,%edi
  80260a:	31 c0                	xor    %eax,%eax
  80260c:	89 fa                	mov    %edi,%edx
  80260e:	83 c4 1c             	add    $0x1c,%esp
  802611:	5b                   	pop    %ebx
  802612:	5e                   	pop    %esi
  802613:	5f                   	pop    %edi
  802614:	5d                   	pop    %ebp
  802615:	c3                   	ret    
  802616:	66 90                	xchg   %ax,%ax
  802618:	89 d8                	mov    %ebx,%eax
  80261a:	f7 f7                	div    %edi
  80261c:	31 ff                	xor    %edi,%edi
  80261e:	89 fa                	mov    %edi,%edx
  802620:	83 c4 1c             	add    $0x1c,%esp
  802623:	5b                   	pop    %ebx
  802624:	5e                   	pop    %esi
  802625:	5f                   	pop    %edi
  802626:	5d                   	pop    %ebp
  802627:	c3                   	ret    
  802628:	bd 20 00 00 00       	mov    $0x20,%ebp
  80262d:	89 eb                	mov    %ebp,%ebx
  80262f:	29 fb                	sub    %edi,%ebx
  802631:	89 f9                	mov    %edi,%ecx
  802633:	d3 e6                	shl    %cl,%esi
  802635:	89 c5                	mov    %eax,%ebp
  802637:	88 d9                	mov    %bl,%cl
  802639:	d3 ed                	shr    %cl,%ebp
  80263b:	89 e9                	mov    %ebp,%ecx
  80263d:	09 f1                	or     %esi,%ecx
  80263f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802643:	89 f9                	mov    %edi,%ecx
  802645:	d3 e0                	shl    %cl,%eax
  802647:	89 c5                	mov    %eax,%ebp
  802649:	89 d6                	mov    %edx,%esi
  80264b:	88 d9                	mov    %bl,%cl
  80264d:	d3 ee                	shr    %cl,%esi
  80264f:	89 f9                	mov    %edi,%ecx
  802651:	d3 e2                	shl    %cl,%edx
  802653:	8b 44 24 08          	mov    0x8(%esp),%eax
  802657:	88 d9                	mov    %bl,%cl
  802659:	d3 e8                	shr    %cl,%eax
  80265b:	09 c2                	or     %eax,%edx
  80265d:	89 d0                	mov    %edx,%eax
  80265f:	89 f2                	mov    %esi,%edx
  802661:	f7 74 24 0c          	divl   0xc(%esp)
  802665:	89 d6                	mov    %edx,%esi
  802667:	89 c3                	mov    %eax,%ebx
  802669:	f7 e5                	mul    %ebp
  80266b:	39 d6                	cmp    %edx,%esi
  80266d:	72 19                	jb     802688 <__udivdi3+0xfc>
  80266f:	74 0b                	je     80267c <__udivdi3+0xf0>
  802671:	89 d8                	mov    %ebx,%eax
  802673:	31 ff                	xor    %edi,%edi
  802675:	e9 58 ff ff ff       	jmp    8025d2 <__udivdi3+0x46>
  80267a:	66 90                	xchg   %ax,%ax
  80267c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802680:	89 f9                	mov    %edi,%ecx
  802682:	d3 e2                	shl    %cl,%edx
  802684:	39 c2                	cmp    %eax,%edx
  802686:	73 e9                	jae    802671 <__udivdi3+0xe5>
  802688:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80268b:	31 ff                	xor    %edi,%edi
  80268d:	e9 40 ff ff ff       	jmp    8025d2 <__udivdi3+0x46>
  802692:	66 90                	xchg   %ax,%ax
  802694:	31 c0                	xor    %eax,%eax
  802696:	e9 37 ff ff ff       	jmp    8025d2 <__udivdi3+0x46>
  80269b:	90                   	nop

0080269c <__umoddi3>:
  80269c:	55                   	push   %ebp
  80269d:	57                   	push   %edi
  80269e:	56                   	push   %esi
  80269f:	53                   	push   %ebx
  8026a0:	83 ec 1c             	sub    $0x1c,%esp
  8026a3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026a7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026af:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026b7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026bb:	89 f3                	mov    %esi,%ebx
  8026bd:	89 fa                	mov    %edi,%edx
  8026bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026c3:	89 34 24             	mov    %esi,(%esp)
  8026c6:	85 c0                	test   %eax,%eax
  8026c8:	75 1a                	jne    8026e4 <__umoddi3+0x48>
  8026ca:	39 f7                	cmp    %esi,%edi
  8026cc:	0f 86 a2 00 00 00    	jbe    802774 <__umoddi3+0xd8>
  8026d2:	89 c8                	mov    %ecx,%eax
  8026d4:	89 f2                	mov    %esi,%edx
  8026d6:	f7 f7                	div    %edi
  8026d8:	89 d0                	mov    %edx,%eax
  8026da:	31 d2                	xor    %edx,%edx
  8026dc:	83 c4 1c             	add    $0x1c,%esp
  8026df:	5b                   	pop    %ebx
  8026e0:	5e                   	pop    %esi
  8026e1:	5f                   	pop    %edi
  8026e2:	5d                   	pop    %ebp
  8026e3:	c3                   	ret    
  8026e4:	39 f0                	cmp    %esi,%eax
  8026e6:	0f 87 ac 00 00 00    	ja     802798 <__umoddi3+0xfc>
  8026ec:	0f bd e8             	bsr    %eax,%ebp
  8026ef:	83 f5 1f             	xor    $0x1f,%ebp
  8026f2:	0f 84 ac 00 00 00    	je     8027a4 <__umoddi3+0x108>
  8026f8:	bf 20 00 00 00       	mov    $0x20,%edi
  8026fd:	29 ef                	sub    %ebp,%edi
  8026ff:	89 fe                	mov    %edi,%esi
  802701:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802705:	89 e9                	mov    %ebp,%ecx
  802707:	d3 e0                	shl    %cl,%eax
  802709:	89 d7                	mov    %edx,%edi
  80270b:	89 f1                	mov    %esi,%ecx
  80270d:	d3 ef                	shr    %cl,%edi
  80270f:	09 c7                	or     %eax,%edi
  802711:	89 e9                	mov    %ebp,%ecx
  802713:	d3 e2                	shl    %cl,%edx
  802715:	89 14 24             	mov    %edx,(%esp)
  802718:	89 d8                	mov    %ebx,%eax
  80271a:	d3 e0                	shl    %cl,%eax
  80271c:	89 c2                	mov    %eax,%edx
  80271e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802722:	d3 e0                	shl    %cl,%eax
  802724:	89 44 24 04          	mov    %eax,0x4(%esp)
  802728:	8b 44 24 08          	mov    0x8(%esp),%eax
  80272c:	89 f1                	mov    %esi,%ecx
  80272e:	d3 e8                	shr    %cl,%eax
  802730:	09 d0                	or     %edx,%eax
  802732:	d3 eb                	shr    %cl,%ebx
  802734:	89 da                	mov    %ebx,%edx
  802736:	f7 f7                	div    %edi
  802738:	89 d3                	mov    %edx,%ebx
  80273a:	f7 24 24             	mull   (%esp)
  80273d:	89 c6                	mov    %eax,%esi
  80273f:	89 d1                	mov    %edx,%ecx
  802741:	39 d3                	cmp    %edx,%ebx
  802743:	0f 82 87 00 00 00    	jb     8027d0 <__umoddi3+0x134>
  802749:	0f 84 91 00 00 00    	je     8027e0 <__umoddi3+0x144>
  80274f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802753:	29 f2                	sub    %esi,%edx
  802755:	19 cb                	sbb    %ecx,%ebx
  802757:	89 d8                	mov    %ebx,%eax
  802759:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80275d:	d3 e0                	shl    %cl,%eax
  80275f:	89 e9                	mov    %ebp,%ecx
  802761:	d3 ea                	shr    %cl,%edx
  802763:	09 d0                	or     %edx,%eax
  802765:	89 e9                	mov    %ebp,%ecx
  802767:	d3 eb                	shr    %cl,%ebx
  802769:	89 da                	mov    %ebx,%edx
  80276b:	83 c4 1c             	add    $0x1c,%esp
  80276e:	5b                   	pop    %ebx
  80276f:	5e                   	pop    %esi
  802770:	5f                   	pop    %edi
  802771:	5d                   	pop    %ebp
  802772:	c3                   	ret    
  802773:	90                   	nop
  802774:	89 fd                	mov    %edi,%ebp
  802776:	85 ff                	test   %edi,%edi
  802778:	75 0b                	jne    802785 <__umoddi3+0xe9>
  80277a:	b8 01 00 00 00       	mov    $0x1,%eax
  80277f:	31 d2                	xor    %edx,%edx
  802781:	f7 f7                	div    %edi
  802783:	89 c5                	mov    %eax,%ebp
  802785:	89 f0                	mov    %esi,%eax
  802787:	31 d2                	xor    %edx,%edx
  802789:	f7 f5                	div    %ebp
  80278b:	89 c8                	mov    %ecx,%eax
  80278d:	f7 f5                	div    %ebp
  80278f:	89 d0                	mov    %edx,%eax
  802791:	e9 44 ff ff ff       	jmp    8026da <__umoddi3+0x3e>
  802796:	66 90                	xchg   %ax,%ax
  802798:	89 c8                	mov    %ecx,%eax
  80279a:	89 f2                	mov    %esi,%edx
  80279c:	83 c4 1c             	add    $0x1c,%esp
  80279f:	5b                   	pop    %ebx
  8027a0:	5e                   	pop    %esi
  8027a1:	5f                   	pop    %edi
  8027a2:	5d                   	pop    %ebp
  8027a3:	c3                   	ret    
  8027a4:	3b 04 24             	cmp    (%esp),%eax
  8027a7:	72 06                	jb     8027af <__umoddi3+0x113>
  8027a9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027ad:	77 0f                	ja     8027be <__umoddi3+0x122>
  8027af:	89 f2                	mov    %esi,%edx
  8027b1:	29 f9                	sub    %edi,%ecx
  8027b3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027b7:	89 14 24             	mov    %edx,(%esp)
  8027ba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027be:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027c2:	8b 14 24             	mov    (%esp),%edx
  8027c5:	83 c4 1c             	add    $0x1c,%esp
  8027c8:	5b                   	pop    %ebx
  8027c9:	5e                   	pop    %esi
  8027ca:	5f                   	pop    %edi
  8027cb:	5d                   	pop    %ebp
  8027cc:	c3                   	ret    
  8027cd:	8d 76 00             	lea    0x0(%esi),%esi
  8027d0:	2b 04 24             	sub    (%esp),%eax
  8027d3:	19 fa                	sbb    %edi,%edx
  8027d5:	89 d1                	mov    %edx,%ecx
  8027d7:	89 c6                	mov    %eax,%esi
  8027d9:	e9 71 ff ff ff       	jmp    80274f <__umoddi3+0xb3>
  8027de:	66 90                	xchg   %ax,%ax
  8027e0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8027e4:	72 ea                	jb     8027d0 <__umoddi3+0x134>
  8027e6:	89 d9                	mov    %ebx,%ecx
  8027e8:	e9 62 ff ff ff       	jmp    80274f <__umoddi3+0xb3>
