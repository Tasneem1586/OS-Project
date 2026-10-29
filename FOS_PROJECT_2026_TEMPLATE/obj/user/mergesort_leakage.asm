
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 07 07 00 00       	call   80073d <libmain>
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
	{
		//2012: lock the interrupt
//		sys_lock_cons();
		int NumOfElements;
		int *Elements;
		sys_lock_cons();
  800041:	e8 a9 1e 00 00       	call   801eef <sys_lock_cons>
		{
			cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 27 80 00       	push   $0x802760
  80004e:	e8 18 0c 00 00       	call   800c6b <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 27 80 00       	push   $0x802762
  80005e:	e8 08 0c 00 00       	call   800c6b <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 78 27 80 00       	push   $0x802778
  80006e:	e8 f8 0b 00 00       	call   800c6b <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
			cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 27 80 00       	push   $0x802762
  80007e:	e8 e8 0b 00 00       	call   800c6b <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
			cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 27 80 00       	push   $0x802760
  80008e:	e8 d8 0b 00 00       	call   800c6b <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
			readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 90 27 80 00       	push   $0x802790
  8000a5:	e8 9a 12 00 00       	call   801344 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
			NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 9b 18 00 00       	call   80195b <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
			Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 f6 1c 00 00       	call   801dcb <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
			cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 b0 27 80 00       	push   $0x8027b0
  8000e3:	e8 83 0b 00 00       	call   800c6b <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 d2 27 80 00       	push   $0x8027d2
  8000f3:	e8 73 0b 00 00       	call   800c6b <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 e0 27 80 00       	push   $0x8027e0
  800103:	e8 63 0b 00 00       	call   800c6b <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 ef 27 80 00       	push   $0x8027ef
  800113:	e8 53 0b 00 00       	call   800c6b <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 ff 27 80 00       	push   $0x8027ff
  800123:	e8 43 0b 00 00       	call   800c6b <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  80012b:	e8 ea 05 00 00       	call   80071a <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 bb 05 00 00       	call   8006fb <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 ae 05 00 00       	call   8006fb <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>
		}
		sys_unlock_cons();
  800162:	e8 a2 1d 00 00       	call   801f09 <sys_unlock_cons>
//		sys_unlock_cons();

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
  800183:	e8 e6 01 00 00       	call   80036e <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 04 02 00 00       	call   80039f <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 26 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 13 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 d2 02 00 00       	call   8004a6 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

//		sys_lock_cons();
		sys_lock_cons();
  8001d7:	e8 13 1d 00 00       	call   801eef <sys_lock_cons>
		{
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 08 28 80 00       	push   $0x802808
  8001e4:	e8 82 0a 00 00       	call   800c6b <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
			//PrintElements(Elements, NumOfElements);
		}
		sys_unlock_cons();
  8001ec:	e8 18 1d 00 00       	call   801f09 <sys_unlock_cons>
//		sys_unlock_cons();

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 c5 00 00 00       	call   8002c4 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 3c 28 80 00       	push   $0x80283c
  800213:	6a 51                	push   $0x51
  800215:	68 5e 28 80 00       	push   $0x80285e
  80021a:	e8 7e 07 00 00       	call   80099d <_panic>
		else
		{
//			sys_lock_cons();
			sys_lock_cons();
  80021f:	e8 cb 1c 00 00       	call   801eef <sys_lock_cons>
			{
				cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 78 28 80 00       	push   $0x802878
  80022c:	e8 3a 0a 00 00       	call   800c6b <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 ac 28 80 00       	push   $0x8028ac
  80023c:	e8 2a 0a 00 00       	call   800c6b <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 e0 28 80 00       	push   $0x8028e0
  80024c:	e8 1a 0a 00 00       	call   800c6b <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			}
			sys_unlock_cons();
  800254:	e8 b0 1c 00 00       	call   801f09 <sys_unlock_cons>
		}

		//free(Elements) ;

//		sys_lock_cons();
		sys_lock_cons();
  800259:	e8 91 1c 00 00       	call   801eef <sys_lock_cons>
		{
			Chose = 0 ;
  80025e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800262:	eb 42                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800264:	83 ec 0c             	sub    $0xc,%esp
  800267:	68 12 29 80 00       	push   $0x802912
  80026c:	e8 fa 09 00 00       	call   800c6b <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800274:	e8 a1 04 00 00       	call   80071a <getchar>
  800279:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 72 04 00 00       	call   8006fb <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 65 04 00 00       	call   8006fb <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 58 04 00 00       	call   8006fb <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

//		sys_lock_cons();
		sys_lock_cons();
		{
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b2                	jne    800264 <_main+0x22c>
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		}
		sys_unlock_cons();
  8002b2:	e8 52 1c 00 00       	call   801f09 <sys_unlock_cons>
//		sys_unlock_cons();

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>

}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 60 27 80 00       	push   $0x802760
  80044b:	e8 1b 08 00 00       	call   800c6b <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 30 29 80 00       	push   $0x802930
  80046d:	e8 f9 07 00 00       	call   800c6b <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 35 29 80 00       	push   $0x802935
  80049b:	e8 cb 07 00 00       	call   800c6b <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 8a 18 00 00       	call   801dcb <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 75 18 00 00       	call   801dcb <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800707:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80070b:	83 ec 0c             	sub    $0xc,%esp
  80070e:	50                   	push   %eax
  80070f:	e8 23 19 00 00       	call   802037 <sys_cputc>
  800714:	83 c4 10             	add    $0x10,%esp
}
  800717:	90                   	nop
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <getchar>:


int
getchar(void)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  800720:	e8 b1 17 00 00       	call   801ed6 <sys_cgetc>
  800725:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800728:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80072c:	74 f2                	je     800720 <getchar+0x6>
	return c;
  80072e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800731:	c9                   	leave  
  800732:	c3                   	ret    

00800733 <iscons>:

int iscons(int fdnum)
{
  800733:	55                   	push   %ebp
  800734:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800736:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80073b:	5d                   	pop    %ebp
  80073c:	c3                   	ret    

0080073d <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
  800740:	57                   	push   %edi
  800741:	56                   	push   %esi
  800742:	53                   	push   %ebx
  800743:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800749:	e8 19 1a 00 00       	call   802167 <sys_getenvindex>
  80074e:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800751:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800754:	89 d0                	mov    %edx,%eax
  800756:	c1 e0 03             	shl    $0x3,%eax
  800759:	01 d0                	add    %edx,%eax
  80075b:	c1 e0 06             	shl    $0x6,%eax
  80075e:	01 d0                	add    %edx,%eax
  800760:	c1 e0 03             	shl    $0x3,%eax
  800763:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800768:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80076d:	a1 24 40 80 00       	mov    0x804024,%eax
  800772:	8a 40 10             	mov    0x10(%eax),%al
  800775:	84 c0                	test   %al,%al
  800777:	74 0d                	je     800786 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800779:	a1 24 40 80 00       	mov    0x804024,%eax
  80077e:	83 c0 10             	add    $0x10,%eax
  800781:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800786:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80078a:	7e 0a                	jle    800796 <libmain+0x59>
		binaryname = argv[0];
  80078c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078f:	8b 00                	mov    (%eax),%eax
  800791:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	ff 75 08             	pushl  0x8(%ebp)
  80079f:	e8 94 f8 ff ff       	call   800038 <_main>
  8007a4:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8007a7:	a1 00 40 80 00       	mov    0x804000,%eax
  8007ac:	85 c0                	test   %eax,%eax
  8007ae:	0f 84 b7 01 00 00    	je     80096b <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8007b4:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007ba:	bb 78 2a 80 00       	mov    $0x802a78,%ebx
  8007bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  8007c4:	89 c7                	mov    %eax,%edi
  8007c6:	89 de                	mov    %ebx,%esi
  8007c8:	89 d1                	mov    %edx,%ecx
  8007ca:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007cc:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8007d2:	b9 56 00 00 00       	mov    $0x56,%ecx
  8007d7:	b0 00                	mov    $0x0,%al
  8007d9:	89 d7                	mov    %edx,%edi
  8007db:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8007dd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8007e4:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8007e7:	83 ec 08             	sub    $0x8,%esp
  8007ea:	50                   	push   %eax
  8007eb:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007f1:	50                   	push   %eax
  8007f2:	e8 70 1b 00 00       	call   802367 <sys_utilities>
  8007f7:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8007fa:	e8 f0 16 00 00       	call   801eef <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8007ff:	83 ec 0c             	sub    $0xc,%esp
  800802:	68 54 29 80 00       	push   $0x802954
  800807:	e8 5f 04 00 00       	call   800c6b <cprintf>
  80080c:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80080f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800812:	85 c0                	test   %eax,%eax
  800814:	74 58                	je     80086e <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800816:	e8 6a 1b 00 00       	call   802385 <sys_get_optimal_num_faults>
  80081b:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80081e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800824:	bb dc 2a 80 00       	mov    $0x802adc,%ebx
  800829:	ba 11 00 00 00       	mov    $0x11,%edx
  80082e:	89 c7                	mov    %eax,%edi
  800830:	89 de                	mov    %ebx,%esi
  800832:	89 d1                	mov    %edx,%ecx
  800834:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800836:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800839:	b9 53 00 00 00       	mov    $0x53,%ecx
  80083e:	b0 00                	mov    $0x0,%al
  800840:	89 d7                	mov    %edx,%edi
  800842:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	ff 75 dc             	pushl  -0x24(%ebp)
  80084a:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800850:	50                   	push   %eax
  800851:	e8 11 1b 00 00       	call   802367 <sys_utilities>
  800856:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800859:	83 ec 08             	sub    $0x8,%esp
  80085c:	ff 75 dc             	pushl  -0x24(%ebp)
  80085f:	68 7c 29 80 00       	push   $0x80297c
  800864:	e8 02 04 00 00       	call   800c6b <cprintf>
  800869:	83 c4 10             	add    $0x10,%esp
  80086c:	eb 59                	jmp    8008c7 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80086e:	a1 24 40 80 00       	mov    0x804024,%eax
  800873:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800879:	a1 24 40 80 00       	mov    0x804024,%eax
  80087e:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800884:	83 ec 04             	sub    $0x4,%esp
  800887:	52                   	push   %edx
  800888:	50                   	push   %eax
  800889:	68 a0 29 80 00       	push   $0x8029a0
  80088e:	e8 d8 03 00 00       	call   800c6b <cprintf>
  800893:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800896:	a1 24 40 80 00       	mov    0x804024,%eax
  80089b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8008a1:	a1 24 40 80 00       	mov    0x804024,%eax
  8008a6:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8008ac:	a1 24 40 80 00       	mov    0x804024,%eax
  8008b1:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8008b7:	51                   	push   %ecx
  8008b8:	52                   	push   %edx
  8008b9:	50                   	push   %eax
  8008ba:	68 c8 29 80 00       	push   $0x8029c8
  8008bf:	e8 a7 03 00 00       	call   800c6b <cprintf>
  8008c4:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008c7:	a1 24 40 80 00       	mov    0x804024,%eax
  8008cc:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	50                   	push   %eax
  8008d6:	68 20 2a 80 00       	push   $0x802a20
  8008db:	e8 8b 03 00 00       	call   800c6b <cprintf>
  8008e0:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8008e3:	83 ec 0c             	sub    $0xc,%esp
  8008e6:	68 34 2a 80 00       	push   $0x802a34
  8008eb:	e8 7b 03 00 00       	call   800c6b <cprintf>
  8008f0:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8008f3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8008fa:	eb 28                	jmp    800924 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8008fc:	a1 24 40 80 00       	mov    0x804024,%eax
  800901:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800904:	81 c2 74 04 00 00    	add    $0x474,%edx
  80090a:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80090d:	83 ec 04             	sub    $0x4,%esp
  800910:	50                   	push   %eax
  800911:	ff 75 e4             	pushl  -0x1c(%ebp)
  800914:	68 4b 2a 80 00       	push   $0x802a4b
  800919:	e8 4d 03 00 00       	call   800c6b <cprintf>
  80091e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800921:	ff 45 e4             	incl   -0x1c(%ebp)
  800924:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800928:	7e d2                	jle    8008fc <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80092a:	83 ec 0c             	sub    $0xc,%esp
  80092d:	68 5a 2a 80 00       	push   $0x802a5a
  800932:	e8 34 03 00 00       	call   800c6b <cprintf>
  800937:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80093a:	a1 24 40 80 00       	mov    0x804024,%eax
  80093f:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800945:	83 ec 08             	sub    $0x8,%esp
  800948:	50                   	push   %eax
  800949:	68 5e 2a 80 00       	push   $0x802a5e
  80094e:	e8 18 03 00 00       	call   800c6b <cprintf>
  800953:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800956:	83 ec 0c             	sub    $0xc,%esp
  800959:	68 54 29 80 00       	push   $0x802954
  80095e:	e8 08 03 00 00       	call   800c6b <cprintf>
  800963:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800966:	e8 9e 15 00 00       	call   801f09 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80096b:	e8 1f 00 00 00       	call   80098f <exit>
}
  800970:	90                   	nop
  800971:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800974:	5b                   	pop    %ebx
  800975:	5e                   	pop    %esi
  800976:	5f                   	pop    %edi
  800977:	5d                   	pop    %ebp
  800978:	c3                   	ret    

00800979 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800979:	55                   	push   %ebp
  80097a:	89 e5                	mov    %esp,%ebp
  80097c:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80097f:	83 ec 0c             	sub    $0xc,%esp
  800982:	6a 00                	push   $0x0
  800984:	e8 aa 17 00 00       	call   802133 <sys_destroy_env>
  800989:	83 c4 10             	add    $0x10,%esp
}
  80098c:	90                   	nop
  80098d:	c9                   	leave  
  80098e:	c3                   	ret    

0080098f <exit>:

void
exit(void)
{
  80098f:	55                   	push   %ebp
  800990:	89 e5                	mov    %esp,%ebp
  800992:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800995:	e8 ff 17 00 00       	call   802199 <sys_exit_env>
}
  80099a:	90                   	nop
  80099b:	c9                   	leave  
  80099c:	c3                   	ret    

0080099d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80099d:	55                   	push   %ebp
  80099e:	89 e5                	mov    %esp,%ebp
  8009a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009a3:	8d 45 10             	lea    0x10(%ebp),%eax
  8009a6:	83 c0 04             	add    $0x4,%eax
  8009a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009ac:	a1 28 41 80 00       	mov    0x804128,%eax
  8009b1:	85 c0                	test   %eax,%eax
  8009b3:	74 16                	je     8009cb <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009b5:	a1 28 41 80 00       	mov    0x804128,%eax
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	50                   	push   %eax
  8009be:	68 40 2b 80 00       	push   $0x802b40
  8009c3:	e8 a3 02 00 00       	call   800c6b <cprintf>
  8009c8:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8009cb:	a1 04 40 80 00       	mov    0x804004,%eax
  8009d0:	83 ec 0c             	sub    $0xc,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	ff 75 08             	pushl  0x8(%ebp)
  8009d9:	50                   	push   %eax
  8009da:	68 48 2b 80 00       	push   $0x802b48
  8009df:	6a 74                	push   $0x74
  8009e1:	e8 b2 02 00 00       	call   800c98 <cprintf_colored>
  8009e6:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8009e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ec:	83 ec 08             	sub    $0x8,%esp
  8009ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f2:	50                   	push   %eax
  8009f3:	e8 04 02 00 00       	call   800bfc <vcprintf>
  8009f8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009fb:	83 ec 08             	sub    $0x8,%esp
  8009fe:	6a 00                	push   $0x0
  800a00:	68 70 2b 80 00       	push   $0x802b70
  800a05:	e8 f2 01 00 00       	call   800bfc <vcprintf>
  800a0a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a0d:	e8 7d ff ff ff       	call   80098f <exit>

	// should not return here
	while (1) ;
  800a12:	eb fe                	jmp    800a12 <_panic+0x75>

00800a14 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a14:	55                   	push   %ebp
  800a15:	89 e5                	mov    %esp,%ebp
  800a17:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a1a:	a1 24 40 80 00       	mov    0x804024,%eax
  800a1f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a28:	39 c2                	cmp    %eax,%edx
  800a2a:	74 14                	je     800a40 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a2c:	83 ec 04             	sub    $0x4,%esp
  800a2f:	68 74 2b 80 00       	push   $0x802b74
  800a34:	6a 26                	push   $0x26
  800a36:	68 c0 2b 80 00       	push   $0x802bc0
  800a3b:	e8 5d ff ff ff       	call   80099d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a47:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a4e:	e9 c5 00 00 00       	jmp    800b18 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a56:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a60:	01 d0                	add    %edx,%eax
  800a62:	8b 00                	mov    (%eax),%eax
  800a64:	85 c0                	test   %eax,%eax
  800a66:	75 08                	jne    800a70 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a68:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a6b:	e9 a5 00 00 00       	jmp    800b15 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a70:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a77:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a7e:	eb 69                	jmp    800ae9 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a80:	a1 24 40 80 00       	mov    0x804024,%eax
  800a85:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a8b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a8e:	89 d0                	mov    %edx,%eax
  800a90:	01 c0                	add    %eax,%eax
  800a92:	01 d0                	add    %edx,%eax
  800a94:	c1 e0 03             	shl    $0x3,%eax
  800a97:	01 c8                	add    %ecx,%eax
  800a99:	8a 40 04             	mov    0x4(%eax),%al
  800a9c:	84 c0                	test   %al,%al
  800a9e:	75 46                	jne    800ae6 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aa0:	a1 24 40 80 00       	mov    0x804024,%eax
  800aa5:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800aab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aae:	89 d0                	mov    %edx,%eax
  800ab0:	01 c0                	add    %eax,%eax
  800ab2:	01 d0                	add    %edx,%eax
  800ab4:	c1 e0 03             	shl    $0x3,%eax
  800ab7:	01 c8                	add    %ecx,%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800abe:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ac1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ac6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800acb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	01 c8                	add    %ecx,%eax
  800ad7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ad9:	39 c2                	cmp    %eax,%edx
  800adb:	75 09                	jne    800ae6 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800add:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ae4:	eb 15                	jmp    800afb <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ae6:	ff 45 e8             	incl   -0x18(%ebp)
  800ae9:	a1 24 40 80 00       	mov    0x804024,%eax
  800aee:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800af4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800af7:	39 c2                	cmp    %eax,%edx
  800af9:	77 85                	ja     800a80 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800afb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800aff:	75 14                	jne    800b15 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800b01:	83 ec 04             	sub    $0x4,%esp
  800b04:	68 cc 2b 80 00       	push   $0x802bcc
  800b09:	6a 3a                	push   $0x3a
  800b0b:	68 c0 2b 80 00       	push   $0x802bc0
  800b10:	e8 88 fe ff ff       	call   80099d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b15:	ff 45 f0             	incl   -0x10(%ebp)
  800b18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b1b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b1e:	0f 8c 2f ff ff ff    	jl     800a53 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b24:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b2b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b32:	eb 26                	jmp    800b5a <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b34:	a1 24 40 80 00       	mov    0x804024,%eax
  800b39:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b42:	89 d0                	mov    %edx,%eax
  800b44:	01 c0                	add    %eax,%eax
  800b46:	01 d0                	add    %edx,%eax
  800b48:	c1 e0 03             	shl    $0x3,%eax
  800b4b:	01 c8                	add    %ecx,%eax
  800b4d:	8a 40 04             	mov    0x4(%eax),%al
  800b50:	3c 01                	cmp    $0x1,%al
  800b52:	75 03                	jne    800b57 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b54:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b57:	ff 45 e0             	incl   -0x20(%ebp)
  800b5a:	a1 24 40 80 00       	mov    0x804024,%eax
  800b5f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b65:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b68:	39 c2                	cmp    %eax,%edx
  800b6a:	77 c8                	ja     800b34 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b6f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b72:	74 14                	je     800b88 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800b74:	83 ec 04             	sub    $0x4,%esp
  800b77:	68 20 2c 80 00       	push   $0x802c20
  800b7c:	6a 44                	push   $0x44
  800b7e:	68 c0 2b 80 00       	push   $0x802bc0
  800b83:	e8 15 fe ff ff       	call   80099d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b88:	90                   	nop
  800b89:	c9                   	leave  
  800b8a:	c3                   	ret    

00800b8b <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800b8b:	55                   	push   %ebp
  800b8c:	89 e5                	mov    %esp,%ebp
  800b8e:	53                   	push   %ebx
  800b8f:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800b92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	8d 48 01             	lea    0x1(%eax),%ecx
  800b9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9d:	89 0a                	mov    %ecx,(%edx)
  800b9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba2:	88 d1                	mov    %dl,%cl
  800ba4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bae:	8b 00                	mov    (%eax),%eax
  800bb0:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bb5:	75 30                	jne    800be7 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800bb7:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800bbd:	a0 40 40 80 00       	mov    0x804040,%al
  800bc2:	0f b6 c0             	movzbl %al,%eax
  800bc5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bc8:	8b 09                	mov    (%ecx),%ecx
  800bca:	89 cb                	mov    %ecx,%ebx
  800bcc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800bcf:	83 c1 08             	add    $0x8,%ecx
  800bd2:	52                   	push   %edx
  800bd3:	50                   	push   %eax
  800bd4:	53                   	push   %ebx
  800bd5:	51                   	push   %ecx
  800bd6:	e8 d0 12 00 00       	call   801eab <sys_cputs>
  800bdb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	8b 40 04             	mov    0x4(%eax),%eax
  800bed:	8d 50 01             	lea    0x1(%eax),%edx
  800bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf3:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bf6:	90                   	nop
  800bf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bfa:	c9                   	leave  
  800bfb:	c3                   	ret    

00800bfc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bfc:	55                   	push   %ebp
  800bfd:	89 e5                	mov    %esp,%ebp
  800bff:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c05:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c0c:	00 00 00 
	b.cnt = 0;
  800c0f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c16:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c19:	ff 75 0c             	pushl  0xc(%ebp)
  800c1c:	ff 75 08             	pushl  0x8(%ebp)
  800c1f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c25:	50                   	push   %eax
  800c26:	68 8b 0b 80 00       	push   $0x800b8b
  800c2b:	e8 5a 02 00 00       	call   800e8a <vprintfmt>
  800c30:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c33:	8b 15 2c 41 80 00    	mov    0x80412c,%edx
  800c39:	a0 40 40 80 00       	mov    0x804040,%al
  800c3e:	0f b6 c0             	movzbl %al,%eax
  800c41:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c47:	52                   	push   %edx
  800c48:	50                   	push   %eax
  800c49:	51                   	push   %ecx
  800c4a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c50:	83 c0 08             	add    $0x8,%eax
  800c53:	50                   	push   %eax
  800c54:	e8 52 12 00 00       	call   801eab <sys_cputs>
  800c59:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c5c:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800c63:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c69:	c9                   	leave  
  800c6a:	c3                   	ret    

00800c6b <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c6b:	55                   	push   %ebp
  800c6c:	89 e5                	mov    %esp,%ebp
  800c6e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c71:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800c78:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 f4             	pushl  -0xc(%ebp)
  800c87:	50                   	push   %eax
  800c88:	e8 6f ff ff ff       	call   800bfc <vcprintf>
  800c8d:	83 c4 10             	add    $0x10,%esp
  800c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c93:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c96:	c9                   	leave  
  800c97:	c3                   	ret    

00800c98 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800c98:	55                   	push   %ebp
  800c99:	89 e5                	mov    %esp,%ebp
  800c9b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c9e:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	c1 e0 08             	shl    $0x8,%eax
  800cab:	a3 2c 41 80 00       	mov    %eax,0x80412c
	va_start(ap, fmt);
  800cb0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cb3:	83 c0 04             	add    $0x4,%eax
  800cb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbc:	83 ec 08             	sub    $0x8,%esp
  800cbf:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc2:	50                   	push   %eax
  800cc3:	e8 34 ff ff ff       	call   800bfc <vcprintf>
  800cc8:	83 c4 10             	add    $0x10,%esp
  800ccb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800cce:	c7 05 2c 41 80 00 00 	movl   $0x700,0x80412c
  800cd5:	07 00 00 

	return cnt;
  800cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cdb:	c9                   	leave  
  800cdc:	c3                   	ret    

00800cdd <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800cdd:	55                   	push   %ebp
  800cde:	89 e5                	mov    %esp,%ebp
  800ce0:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800ce3:	e8 07 12 00 00       	call   801eef <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800ce8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ceb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	83 ec 08             	sub    $0x8,%esp
  800cf4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf7:	50                   	push   %eax
  800cf8:	e8 ff fe ff ff       	call   800bfc <vcprintf>
  800cfd:	83 c4 10             	add    $0x10,%esp
  800d00:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800d03:	e8 01 12 00 00       	call   801f09 <sys_unlock_cons>
	return cnt;
  800d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0b:	c9                   	leave  
  800d0c:	c3                   	ret    

00800d0d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d0d:	55                   	push   %ebp
  800d0e:	89 e5                	mov    %esp,%ebp
  800d10:	53                   	push   %ebx
  800d11:	83 ec 14             	sub    $0x14,%esp
  800d14:	8b 45 10             	mov    0x10(%ebp),%eax
  800d17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d20:	8b 45 18             	mov    0x18(%ebp),%eax
  800d23:	ba 00 00 00 00       	mov    $0x0,%edx
  800d28:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d2b:	77 55                	ja     800d82 <printnum+0x75>
  800d2d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d30:	72 05                	jb     800d37 <printnum+0x2a>
  800d32:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d35:	77 4b                	ja     800d82 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d37:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d3a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d3d:	8b 45 18             	mov    0x18(%ebp),%eax
  800d40:	ba 00 00 00 00       	mov    $0x0,%edx
  800d45:	52                   	push   %edx
  800d46:	50                   	push   %eax
  800d47:	ff 75 f4             	pushl  -0xc(%ebp)
  800d4a:	ff 75 f0             	pushl  -0x10(%ebp)
  800d4d:	e8 96 17 00 00       	call   8024e8 <__udivdi3>
  800d52:	83 c4 10             	add    $0x10,%esp
  800d55:	83 ec 04             	sub    $0x4,%esp
  800d58:	ff 75 20             	pushl  0x20(%ebp)
  800d5b:	53                   	push   %ebx
  800d5c:	ff 75 18             	pushl  0x18(%ebp)
  800d5f:	52                   	push   %edx
  800d60:	50                   	push   %eax
  800d61:	ff 75 0c             	pushl  0xc(%ebp)
  800d64:	ff 75 08             	pushl  0x8(%ebp)
  800d67:	e8 a1 ff ff ff       	call   800d0d <printnum>
  800d6c:	83 c4 20             	add    $0x20,%esp
  800d6f:	eb 1a                	jmp    800d8b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 0c             	pushl  0xc(%ebp)
  800d77:	ff 75 20             	pushl  0x20(%ebp)
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	ff d0                	call   *%eax
  800d7f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d82:	ff 4d 1c             	decl   0x1c(%ebp)
  800d85:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d89:	7f e6                	jg     800d71 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d8b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d8e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d99:	53                   	push   %ebx
  800d9a:	51                   	push   %ecx
  800d9b:	52                   	push   %edx
  800d9c:	50                   	push   %eax
  800d9d:	e8 56 18 00 00       	call   8025f8 <__umoddi3>
  800da2:	83 c4 10             	add    $0x10,%esp
  800da5:	05 94 2e 80 00       	add    $0x802e94,%eax
  800daa:	8a 00                	mov    (%eax),%al
  800dac:	0f be c0             	movsbl %al,%eax
  800daf:	83 ec 08             	sub    $0x8,%esp
  800db2:	ff 75 0c             	pushl  0xc(%ebp)
  800db5:	50                   	push   %eax
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	ff d0                	call   *%eax
  800dbb:	83 c4 10             	add    $0x10,%esp
}
  800dbe:	90                   	nop
  800dbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dc2:	c9                   	leave  
  800dc3:	c3                   	ret    

00800dc4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dc4:	55                   	push   %ebp
  800dc5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dc7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dcb:	7e 1c                	jle    800de9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8b 00                	mov    (%eax),%eax
  800dd2:	8d 50 08             	lea    0x8(%eax),%edx
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	89 10                	mov    %edx,(%eax)
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8b 00                	mov    (%eax),%eax
  800ddf:	83 e8 08             	sub    $0x8,%eax
  800de2:	8b 50 04             	mov    0x4(%eax),%edx
  800de5:	8b 00                	mov    (%eax),%eax
  800de7:	eb 40                	jmp    800e29 <getuint+0x65>
	else if (lflag)
  800de9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ded:	74 1e                	je     800e0d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	8b 00                	mov    (%eax),%eax
  800df4:	8d 50 04             	lea    0x4(%eax),%edx
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	89 10                	mov    %edx,(%eax)
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8b 00                	mov    (%eax),%eax
  800e01:	83 e8 04             	sub    $0x4,%eax
  800e04:	8b 00                	mov    (%eax),%eax
  800e06:	ba 00 00 00 00       	mov    $0x0,%edx
  800e0b:	eb 1c                	jmp    800e29 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  800e29:	5d                   	pop    %ebp
  800e2a:	c3                   	ret    

00800e2b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e2e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e32:	7e 1c                	jle    800e50 <getint+0x25>
		return va_arg(*ap, long long);
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	8b 00                	mov    (%eax),%eax
  800e39:	8d 50 08             	lea    0x8(%eax),%edx
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	89 10                	mov    %edx,(%eax)
  800e41:	8b 45 08             	mov    0x8(%ebp),%eax
  800e44:	8b 00                	mov    (%eax),%eax
  800e46:	83 e8 08             	sub    $0x8,%eax
  800e49:	8b 50 04             	mov    0x4(%eax),%edx
  800e4c:	8b 00                	mov    (%eax),%eax
  800e4e:	eb 38                	jmp    800e88 <getint+0x5d>
	else if (lflag)
  800e50:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e54:	74 1a                	je     800e70 <getint+0x45>
		return va_arg(*ap, long);
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	8b 00                	mov    (%eax),%eax
  800e5b:	8d 50 04             	lea    0x4(%eax),%edx
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	89 10                	mov    %edx,(%eax)
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	8b 00                	mov    (%eax),%eax
  800e68:	83 e8 04             	sub    $0x4,%eax
  800e6b:	8b 00                	mov    (%eax),%eax
  800e6d:	99                   	cltd   
  800e6e:	eb 18                	jmp    800e88 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	8b 00                	mov    (%eax),%eax
  800e75:	8d 50 04             	lea    0x4(%eax),%edx
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	89 10                	mov    %edx,(%eax)
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	8b 00                	mov    (%eax),%eax
  800e82:	83 e8 04             	sub    $0x4,%eax
  800e85:	8b 00                	mov    (%eax),%eax
  800e87:	99                   	cltd   
}
  800e88:	5d                   	pop    %ebp
  800e89:	c3                   	ret    

00800e8a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e8a:	55                   	push   %ebp
  800e8b:	89 e5                	mov    %esp,%ebp
  800e8d:	56                   	push   %esi
  800e8e:	53                   	push   %ebx
  800e8f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e92:	eb 17                	jmp    800eab <vprintfmt+0x21>
			if (ch == '\0')
  800e94:	85 db                	test   %ebx,%ebx
  800e96:	0f 84 c1 03 00 00    	je     80125d <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	53                   	push   %ebx
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	ff d0                	call   *%eax
  800ea8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eab:	8b 45 10             	mov    0x10(%ebp),%eax
  800eae:	8d 50 01             	lea    0x1(%eax),%edx
  800eb1:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb4:	8a 00                	mov    (%eax),%al
  800eb6:	0f b6 d8             	movzbl %al,%ebx
  800eb9:	83 fb 25             	cmp    $0x25,%ebx
  800ebc:	75 d6                	jne    800e94 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ebe:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ec2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ec9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ed0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ed7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ede:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee1:	8d 50 01             	lea    0x1(%eax),%edx
  800ee4:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	0f b6 d8             	movzbl %al,%ebx
  800eec:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800eef:	83 f8 5b             	cmp    $0x5b,%eax
  800ef2:	0f 87 3d 03 00 00    	ja     801235 <vprintfmt+0x3ab>
  800ef8:	8b 04 85 b8 2e 80 00 	mov    0x802eb8(,%eax,4),%eax
  800eff:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f01:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f05:	eb d7                	jmp    800ede <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f07:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f0b:	eb d1                	jmp    800ede <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f0d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f14:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f17:	89 d0                	mov    %edx,%eax
  800f19:	c1 e0 02             	shl    $0x2,%eax
  800f1c:	01 d0                	add    %edx,%eax
  800f1e:	01 c0                	add    %eax,%eax
  800f20:	01 d8                	add    %ebx,%eax
  800f22:	83 e8 30             	sub    $0x30,%eax
  800f25:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f28:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f30:	83 fb 2f             	cmp    $0x2f,%ebx
  800f33:	7e 3e                	jle    800f73 <vprintfmt+0xe9>
  800f35:	83 fb 39             	cmp    $0x39,%ebx
  800f38:	7f 39                	jg     800f73 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f3a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f3d:	eb d5                	jmp    800f14 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f42:	83 c0 04             	add    $0x4,%eax
  800f45:	89 45 14             	mov    %eax,0x14(%ebp)
  800f48:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4b:	83 e8 04             	sub    $0x4,%eax
  800f4e:	8b 00                	mov    (%eax),%eax
  800f50:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f53:	eb 1f                	jmp    800f74 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f59:	79 83                	jns    800ede <vprintfmt+0x54>
				width = 0;
  800f5b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f62:	e9 77 ff ff ff       	jmp    800ede <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f67:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f6e:	e9 6b ff ff ff       	jmp    800ede <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f73:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f78:	0f 89 60 ff ff ff    	jns    800ede <vprintfmt+0x54>
				width = precision, precision = -1;
  800f7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f84:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f8b:	e9 4e ff ff ff       	jmp    800ede <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f90:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f93:	e9 46 ff ff ff       	jmp    800ede <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f98:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9b:	83 c0 04             	add    $0x4,%eax
  800f9e:	89 45 14             	mov    %eax,0x14(%ebp)
  800fa1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa4:	83 e8 04             	sub    $0x4,%eax
  800fa7:	8b 00                	mov    (%eax),%eax
  800fa9:	83 ec 08             	sub    $0x8,%esp
  800fac:	ff 75 0c             	pushl  0xc(%ebp)
  800faf:	50                   	push   %eax
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	ff d0                	call   *%eax
  800fb5:	83 c4 10             	add    $0x10,%esp
			break;
  800fb8:	e9 9b 02 00 00       	jmp    801258 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc0:	83 c0 04             	add    $0x4,%eax
  800fc3:	89 45 14             	mov    %eax,0x14(%ebp)
  800fc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc9:	83 e8 04             	sub    $0x4,%eax
  800fcc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fce:	85 db                	test   %ebx,%ebx
  800fd0:	79 02                	jns    800fd4 <vprintfmt+0x14a>
				err = -err;
  800fd2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fd4:	83 fb 64             	cmp    $0x64,%ebx
  800fd7:	7f 0b                	jg     800fe4 <vprintfmt+0x15a>
  800fd9:	8b 34 9d 00 2d 80 00 	mov    0x802d00(,%ebx,4),%esi
  800fe0:	85 f6                	test   %esi,%esi
  800fe2:	75 19                	jne    800ffd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fe4:	53                   	push   %ebx
  800fe5:	68 a5 2e 80 00       	push   $0x802ea5
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	ff 75 08             	pushl  0x8(%ebp)
  800ff0:	e8 70 02 00 00       	call   801265 <printfmt>
  800ff5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ff8:	e9 5b 02 00 00       	jmp    801258 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ffd:	56                   	push   %esi
  800ffe:	68 ae 2e 80 00       	push   $0x802eae
  801003:	ff 75 0c             	pushl  0xc(%ebp)
  801006:	ff 75 08             	pushl  0x8(%ebp)
  801009:	e8 57 02 00 00       	call   801265 <printfmt>
  80100e:	83 c4 10             	add    $0x10,%esp
			break;
  801011:	e9 42 02 00 00       	jmp    801258 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801016:	8b 45 14             	mov    0x14(%ebp),%eax
  801019:	83 c0 04             	add    $0x4,%eax
  80101c:	89 45 14             	mov    %eax,0x14(%ebp)
  80101f:	8b 45 14             	mov    0x14(%ebp),%eax
  801022:	83 e8 04             	sub    $0x4,%eax
  801025:	8b 30                	mov    (%eax),%esi
  801027:	85 f6                	test   %esi,%esi
  801029:	75 05                	jne    801030 <vprintfmt+0x1a6>
				p = "(null)";
  80102b:	be b1 2e 80 00       	mov    $0x802eb1,%esi
			if (width > 0 && padc != '-')
  801030:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801034:	7e 6d                	jle    8010a3 <vprintfmt+0x219>
  801036:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80103a:	74 67                	je     8010a3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80103c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80103f:	83 ec 08             	sub    $0x8,%esp
  801042:	50                   	push   %eax
  801043:	56                   	push   %esi
  801044:	e8 26 05 00 00       	call   80156f <strnlen>
  801049:	83 c4 10             	add    $0x10,%esp
  80104c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80104f:	eb 16                	jmp    801067 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801051:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801055:	83 ec 08             	sub    $0x8,%esp
  801058:	ff 75 0c             	pushl  0xc(%ebp)
  80105b:	50                   	push   %eax
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	ff d0                	call   *%eax
  801061:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801064:	ff 4d e4             	decl   -0x1c(%ebp)
  801067:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80106b:	7f e4                	jg     801051 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80106d:	eb 34                	jmp    8010a3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80106f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801073:	74 1c                	je     801091 <vprintfmt+0x207>
  801075:	83 fb 1f             	cmp    $0x1f,%ebx
  801078:	7e 05                	jle    80107f <vprintfmt+0x1f5>
  80107a:	83 fb 7e             	cmp    $0x7e,%ebx
  80107d:	7e 12                	jle    801091 <vprintfmt+0x207>
					putch('?', putdat);
  80107f:	83 ec 08             	sub    $0x8,%esp
  801082:	ff 75 0c             	pushl  0xc(%ebp)
  801085:	6a 3f                	push   $0x3f
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	ff d0                	call   *%eax
  80108c:	83 c4 10             	add    $0x10,%esp
  80108f:	eb 0f                	jmp    8010a0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801091:	83 ec 08             	sub    $0x8,%esp
  801094:	ff 75 0c             	pushl  0xc(%ebp)
  801097:	53                   	push   %ebx
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	ff d0                	call   *%eax
  80109d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010a0:	ff 4d e4             	decl   -0x1c(%ebp)
  8010a3:	89 f0                	mov    %esi,%eax
  8010a5:	8d 70 01             	lea    0x1(%eax),%esi
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	0f be d8             	movsbl %al,%ebx
  8010ad:	85 db                	test   %ebx,%ebx
  8010af:	74 24                	je     8010d5 <vprintfmt+0x24b>
  8010b1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010b5:	78 b8                	js     80106f <vprintfmt+0x1e5>
  8010b7:	ff 4d e0             	decl   -0x20(%ebp)
  8010ba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010be:	79 af                	jns    80106f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010c0:	eb 13                	jmp    8010d5 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010c2:	83 ec 08             	sub    $0x8,%esp
  8010c5:	ff 75 0c             	pushl  0xc(%ebp)
  8010c8:	6a 20                	push   $0x20
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	ff d0                	call   *%eax
  8010cf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010d2:	ff 4d e4             	decl   -0x1c(%ebp)
  8010d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010d9:	7f e7                	jg     8010c2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010db:	e9 78 01 00 00       	jmp    801258 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010e0:	83 ec 08             	sub    $0x8,%esp
  8010e3:	ff 75 e8             	pushl  -0x18(%ebp)
  8010e6:	8d 45 14             	lea    0x14(%ebp),%eax
  8010e9:	50                   	push   %eax
  8010ea:	e8 3c fd ff ff       	call   800e2b <getint>
  8010ef:	83 c4 10             	add    $0x10,%esp
  8010f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fe:	85 d2                	test   %edx,%edx
  801100:	79 23                	jns    801125 <vprintfmt+0x29b>
				putch('-', putdat);
  801102:	83 ec 08             	sub    $0x8,%esp
  801105:	ff 75 0c             	pushl  0xc(%ebp)
  801108:	6a 2d                	push   $0x2d
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	ff d0                	call   *%eax
  80110f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801112:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801115:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801118:	f7 d8                	neg    %eax
  80111a:	83 d2 00             	adc    $0x0,%edx
  80111d:	f7 da                	neg    %edx
  80111f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801122:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801125:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80112c:	e9 bc 00 00 00       	jmp    8011ed <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801131:	83 ec 08             	sub    $0x8,%esp
  801134:	ff 75 e8             	pushl  -0x18(%ebp)
  801137:	8d 45 14             	lea    0x14(%ebp),%eax
  80113a:	50                   	push   %eax
  80113b:	e8 84 fc ff ff       	call   800dc4 <getuint>
  801140:	83 c4 10             	add    $0x10,%esp
  801143:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801146:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801149:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801150:	e9 98 00 00 00       	jmp    8011ed <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801155:	83 ec 08             	sub    $0x8,%esp
  801158:	ff 75 0c             	pushl  0xc(%ebp)
  80115b:	6a 58                	push   $0x58
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	ff d0                	call   *%eax
  801162:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801165:	83 ec 08             	sub    $0x8,%esp
  801168:	ff 75 0c             	pushl  0xc(%ebp)
  80116b:	6a 58                	push   $0x58
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	ff d0                	call   *%eax
  801172:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801175:	83 ec 08             	sub    $0x8,%esp
  801178:	ff 75 0c             	pushl  0xc(%ebp)
  80117b:	6a 58                	push   $0x58
  80117d:	8b 45 08             	mov    0x8(%ebp),%eax
  801180:	ff d0                	call   *%eax
  801182:	83 c4 10             	add    $0x10,%esp
			break;
  801185:	e9 ce 00 00 00       	jmp    801258 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80118a:	83 ec 08             	sub    $0x8,%esp
  80118d:	ff 75 0c             	pushl  0xc(%ebp)
  801190:	6a 30                	push   $0x30
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	ff d0                	call   *%eax
  801197:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80119a:	83 ec 08             	sub    $0x8,%esp
  80119d:	ff 75 0c             	pushl  0xc(%ebp)
  8011a0:	6a 78                	push   $0x78
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	ff d0                	call   *%eax
  8011a7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ad:	83 c0 04             	add    $0x4,%eax
  8011b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8011b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b6:	83 e8 04             	sub    $0x4,%eax
  8011b9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011c5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011cc:	eb 1f                	jmp    8011ed <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011ce:	83 ec 08             	sub    $0x8,%esp
  8011d1:	ff 75 e8             	pushl  -0x18(%ebp)
  8011d4:	8d 45 14             	lea    0x14(%ebp),%eax
  8011d7:	50                   	push   %eax
  8011d8:	e8 e7 fb ff ff       	call   800dc4 <getuint>
  8011dd:	83 c4 10             	add    $0x10,%esp
  8011e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011e6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011ed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011f4:	83 ec 04             	sub    $0x4,%esp
  8011f7:	52                   	push   %edx
  8011f8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011fb:	50                   	push   %eax
  8011fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ff:	ff 75 f0             	pushl  -0x10(%ebp)
  801202:	ff 75 0c             	pushl  0xc(%ebp)
  801205:	ff 75 08             	pushl  0x8(%ebp)
  801208:	e8 00 fb ff ff       	call   800d0d <printnum>
  80120d:	83 c4 20             	add    $0x20,%esp
			break;
  801210:	eb 46                	jmp    801258 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801212:	83 ec 08             	sub    $0x8,%esp
  801215:	ff 75 0c             	pushl  0xc(%ebp)
  801218:	53                   	push   %ebx
  801219:	8b 45 08             	mov    0x8(%ebp),%eax
  80121c:	ff d0                	call   *%eax
  80121e:	83 c4 10             	add    $0x10,%esp
			break;
  801221:	eb 35                	jmp    801258 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801223:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  80122a:	eb 2c                	jmp    801258 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80122c:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801233:	eb 23                	jmp    801258 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801235:	83 ec 08             	sub    $0x8,%esp
  801238:	ff 75 0c             	pushl  0xc(%ebp)
  80123b:	6a 25                	push   $0x25
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	ff d0                	call   *%eax
  801242:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801245:	ff 4d 10             	decl   0x10(%ebp)
  801248:	eb 03                	jmp    80124d <vprintfmt+0x3c3>
  80124a:	ff 4d 10             	decl   0x10(%ebp)
  80124d:	8b 45 10             	mov    0x10(%ebp),%eax
  801250:	48                   	dec    %eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	3c 25                	cmp    $0x25,%al
  801255:	75 f3                	jne    80124a <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801257:	90                   	nop
		}
	}
  801258:	e9 35 fc ff ff       	jmp    800e92 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80125d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80125e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801261:	5b                   	pop    %ebx
  801262:	5e                   	pop    %esi
  801263:	5d                   	pop    %ebp
  801264:	c3                   	ret    

00801265 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
  801268:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80126b:	8d 45 10             	lea    0x10(%ebp),%eax
  80126e:	83 c0 04             	add    $0x4,%eax
  801271:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	ff 75 f4             	pushl  -0xc(%ebp)
  80127a:	50                   	push   %eax
  80127b:	ff 75 0c             	pushl  0xc(%ebp)
  80127e:	ff 75 08             	pushl  0x8(%ebp)
  801281:	e8 04 fc ff ff       	call   800e8a <vprintfmt>
  801286:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801289:	90                   	nop
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	8b 40 08             	mov    0x8(%eax),%eax
  801295:	8d 50 01             	lea    0x1(%eax),%edx
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	8b 10                	mov    (%eax),%edx
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	8b 40 04             	mov    0x4(%eax),%eax
  8012a9:	39 c2                	cmp    %eax,%edx
  8012ab:	73 12                	jae    8012bf <sprintputch+0x33>
		*b->buf++ = ch;
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	8b 00                	mov    (%eax),%eax
  8012b2:	8d 48 01             	lea    0x1(%eax),%ecx
  8012b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b8:	89 0a                	mov    %ecx,(%edx)
  8012ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8012bd:	88 10                	mov    %dl,(%eax)
}
  8012bf:	90                   	nop
  8012c0:	5d                   	pop    %ebp
  8012c1:	c3                   	ret    

008012c2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
  8012c5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	01 d0                	add    %edx,%eax
  8012d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e7:	74 06                	je     8012ef <vsnprintf+0x2d>
  8012e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ed:	7f 07                	jg     8012f6 <vsnprintf+0x34>
		return -E_INVAL;
  8012ef:	b8 03 00 00 00       	mov    $0x3,%eax
  8012f4:	eb 20                	jmp    801316 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012f6:	ff 75 14             	pushl  0x14(%ebp)
  8012f9:	ff 75 10             	pushl  0x10(%ebp)
  8012fc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012ff:	50                   	push   %eax
  801300:	68 8c 12 80 00       	push   $0x80128c
  801305:	e8 80 fb ff ff       	call   800e8a <vprintfmt>
  80130a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80130d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801310:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801313:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801316:	c9                   	leave  
  801317:	c3                   	ret    

00801318 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801318:	55                   	push   %ebp
  801319:	89 e5                	mov    %esp,%ebp
  80131b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80131e:	8d 45 10             	lea    0x10(%ebp),%eax
  801321:	83 c0 04             	add    $0x4,%eax
  801324:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801327:	8b 45 10             	mov    0x10(%ebp),%eax
  80132a:	ff 75 f4             	pushl  -0xc(%ebp)
  80132d:	50                   	push   %eax
  80132e:	ff 75 0c             	pushl  0xc(%ebp)
  801331:	ff 75 08             	pushl  0x8(%ebp)
  801334:	e8 89 ff ff ff       	call   8012c2 <vsnprintf>
  801339:	83 c4 10             	add    $0x10,%esp
  80133c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80133f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
  801347:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  80134a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80134e:	74 13                	je     801363 <readline+0x1f>
		cprintf("%s", prompt);
  801350:	83 ec 08             	sub    $0x8,%esp
  801353:	ff 75 08             	pushl  0x8(%ebp)
  801356:	68 28 30 80 00       	push   $0x803028
  80135b:	e8 0b f9 ff ff       	call   800c6b <cprintf>
  801360:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801363:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80136a:	83 ec 0c             	sub    $0xc,%esp
  80136d:	6a 00                	push   $0x0
  80136f:	e8 bf f3 ff ff       	call   800733 <iscons>
  801374:	83 c4 10             	add    $0x10,%esp
  801377:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80137a:	e8 9b f3 ff ff       	call   80071a <getchar>
  80137f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801382:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801386:	79 22                	jns    8013aa <readline+0x66>
			if (c != -E_EOF)
  801388:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80138c:	0f 84 ad 00 00 00    	je     80143f <readline+0xfb>
				cprintf("read error: %e\n", c);
  801392:	83 ec 08             	sub    $0x8,%esp
  801395:	ff 75 ec             	pushl  -0x14(%ebp)
  801398:	68 2b 30 80 00       	push   $0x80302b
  80139d:	e8 c9 f8 ff ff       	call   800c6b <cprintf>
  8013a2:	83 c4 10             	add    $0x10,%esp
			break;
  8013a5:	e9 95 00 00 00       	jmp    80143f <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8013aa:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8013ae:	7e 34                	jle    8013e4 <readline+0xa0>
  8013b0:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8013b7:	7f 2b                	jg     8013e4 <readline+0xa0>
			if (echoing)
  8013b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013bd:	74 0e                	je     8013cd <readline+0x89>
				cputchar(c);
  8013bf:	83 ec 0c             	sub    $0xc,%esp
  8013c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c5:	e8 31 f3 ff ff       	call   8006fb <cputchar>
  8013ca:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8013cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d0:	8d 50 01             	lea    0x1(%eax),%edx
  8013d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013d6:	89 c2                	mov    %eax,%edx
  8013d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013db:	01 d0                	add    %edx,%eax
  8013dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013e0:	88 10                	mov    %dl,(%eax)
  8013e2:	eb 56                	jmp    80143a <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8013e4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013e8:	75 1f                	jne    801409 <readline+0xc5>
  8013ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013ee:	7e 19                	jle    801409 <readline+0xc5>
			if (echoing)
  8013f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013f4:	74 0e                	je     801404 <readline+0xc0>
				cputchar(c);
  8013f6:	83 ec 0c             	sub    $0xc,%esp
  8013f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8013fc:	e8 fa f2 ff ff       	call   8006fb <cputchar>
  801401:	83 c4 10             	add    $0x10,%esp

			i--;
  801404:	ff 4d f4             	decl   -0xc(%ebp)
  801407:	eb 31                	jmp    80143a <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801409:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80140d:	74 0a                	je     801419 <readline+0xd5>
  80140f:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801413:	0f 85 61 ff ff ff    	jne    80137a <readline+0x36>
			if (echoing)
  801419:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80141d:	74 0e                	je     80142d <readline+0xe9>
				cputchar(c);
  80141f:	83 ec 0c             	sub    $0xc,%esp
  801422:	ff 75 ec             	pushl  -0x14(%ebp)
  801425:	e8 d1 f2 ff ff       	call   8006fb <cputchar>
  80142a:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80142d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801430:	8b 45 0c             	mov    0xc(%ebp),%eax
  801433:	01 d0                	add    %edx,%eax
  801435:	c6 00 00             	movb   $0x0,(%eax)
			break;
  801438:	eb 06                	jmp    801440 <readline+0xfc>
		}
	}
  80143a:	e9 3b ff ff ff       	jmp    80137a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  80143f:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  801440:	90                   	nop
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  801449:	e8 a1 0a 00 00       	call   801eef <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  80144e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801452:	74 13                	je     801467 <atomic_readline+0x24>
			cprintf("%s", prompt);
  801454:	83 ec 08             	sub    $0x8,%esp
  801457:	ff 75 08             	pushl  0x8(%ebp)
  80145a:	68 28 30 80 00       	push   $0x803028
  80145f:	e8 07 f8 ff ff       	call   800c6b <cprintf>
  801464:	83 c4 10             	add    $0x10,%esp

		i = 0;
  801467:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  80146e:	83 ec 0c             	sub    $0xc,%esp
  801471:	6a 00                	push   $0x0
  801473:	e8 bb f2 ff ff       	call   800733 <iscons>
  801478:	83 c4 10             	add    $0x10,%esp
  80147b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  80147e:	e8 97 f2 ff ff       	call   80071a <getchar>
  801483:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  801486:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80148a:	79 22                	jns    8014ae <atomic_readline+0x6b>
				if (c != -E_EOF)
  80148c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801490:	0f 84 ad 00 00 00    	je     801543 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  801496:	83 ec 08             	sub    $0x8,%esp
  801499:	ff 75 ec             	pushl  -0x14(%ebp)
  80149c:	68 2b 30 80 00       	push   $0x80302b
  8014a1:	e8 c5 f7 ff ff       	call   800c6b <cprintf>
  8014a6:	83 c4 10             	add    $0x10,%esp
				break;
  8014a9:	e9 95 00 00 00       	jmp    801543 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  8014ae:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8014b2:	7e 34                	jle    8014e8 <atomic_readline+0xa5>
  8014b4:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8014bb:	7f 2b                	jg     8014e8 <atomic_readline+0xa5>
				if (echoing)
  8014bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8014c1:	74 0e                	je     8014d1 <atomic_readline+0x8e>
					cputchar(c);
  8014c3:	83 ec 0c             	sub    $0xc,%esp
  8014c6:	ff 75 ec             	pushl  -0x14(%ebp)
  8014c9:	e8 2d f2 ff ff       	call   8006fb <cputchar>
  8014ce:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  8014d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014d4:	8d 50 01             	lea    0x1(%eax),%edx
  8014d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8014da:	89 c2                	mov    %eax,%edx
  8014dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014df:	01 d0                	add    %edx,%eax
  8014e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014e4:	88 10                	mov    %dl,(%eax)
  8014e6:	eb 56                	jmp    80153e <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  8014e8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8014ec:	75 1f                	jne    80150d <atomic_readline+0xca>
  8014ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8014f2:	7e 19                	jle    80150d <atomic_readline+0xca>
				if (echoing)
  8014f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8014f8:	74 0e                	je     801508 <atomic_readline+0xc5>
					cputchar(c);
  8014fa:	83 ec 0c             	sub    $0xc,%esp
  8014fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801500:	e8 f6 f1 ff ff       	call   8006fb <cputchar>
  801505:	83 c4 10             	add    $0x10,%esp
				i--;
  801508:	ff 4d f4             	decl   -0xc(%ebp)
  80150b:	eb 31                	jmp    80153e <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  80150d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801511:	74 0a                	je     80151d <atomic_readline+0xda>
  801513:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801517:	0f 85 61 ff ff ff    	jne    80147e <atomic_readline+0x3b>
				if (echoing)
  80151d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801521:	74 0e                	je     801531 <atomic_readline+0xee>
					cputchar(c);
  801523:	83 ec 0c             	sub    $0xc,%esp
  801526:	ff 75 ec             	pushl  -0x14(%ebp)
  801529:	e8 cd f1 ff ff       	call   8006fb <cputchar>
  80152e:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  801531:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801534:	8b 45 0c             	mov    0xc(%ebp),%eax
  801537:	01 d0                	add    %edx,%eax
  801539:	c6 00 00             	movb   $0x0,(%eax)
				break;
  80153c:	eb 06                	jmp    801544 <atomic_readline+0x101>
			}
		}
  80153e:	e9 3b ff ff ff       	jmp    80147e <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  801543:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  801544:	e8 c0 09 00 00       	call   801f09 <sys_unlock_cons>
}
  801549:	90                   	nop
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
  80154f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801559:	eb 06                	jmp    801561 <strlen+0x15>
		n++;
  80155b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80155e:	ff 45 08             	incl   0x8(%ebp)
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	8a 00                	mov    (%eax),%al
  801566:	84 c0                	test   %al,%al
  801568:	75 f1                	jne    80155b <strlen+0xf>
		n++;
	return n;
  80156a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
  801572:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801575:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80157c:	eb 09                	jmp    801587 <strnlen+0x18>
		n++;
  80157e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801581:	ff 45 08             	incl   0x8(%ebp)
  801584:	ff 4d 0c             	decl   0xc(%ebp)
  801587:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80158b:	74 09                	je     801596 <strnlen+0x27>
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	84 c0                	test   %al,%al
  801594:	75 e8                	jne    80157e <strnlen+0xf>
		n++;
	return n;
  801596:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
  80159e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8015a7:	90                   	nop
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	8d 50 01             	lea    0x1(%eax),%edx
  8015ae:	89 55 08             	mov    %edx,0x8(%ebp)
  8015b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015b7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015ba:	8a 12                	mov    (%edx),%dl
  8015bc:	88 10                	mov    %dl,(%eax)
  8015be:	8a 00                	mov    (%eax),%al
  8015c0:	84 c0                	test   %al,%al
  8015c2:	75 e4                	jne    8015a8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
  8015cc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015dc:	eb 1f                	jmp    8015fd <strncpy+0x34>
		*dst++ = *src;
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8d 50 01             	lea    0x1(%eax),%edx
  8015e4:	89 55 08             	mov    %edx,0x8(%ebp)
  8015e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ea:	8a 12                	mov    (%edx),%dl
  8015ec:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f1:	8a 00                	mov    (%eax),%al
  8015f3:	84 c0                	test   %al,%al
  8015f5:	74 03                	je     8015fa <strncpy+0x31>
			src++;
  8015f7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8015fa:	ff 45 fc             	incl   -0x4(%ebp)
  8015fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801600:	3b 45 10             	cmp    0x10(%ebp),%eax
  801603:	72 d9                	jb     8015de <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801605:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
  80160d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801616:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80161a:	74 30                	je     80164c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80161c:	eb 16                	jmp    801634 <strlcpy+0x2a>
			*dst++ = *src++;
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	8d 50 01             	lea    0x1(%eax),%edx
  801624:	89 55 08             	mov    %edx,0x8(%ebp)
  801627:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80162d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801630:	8a 12                	mov    (%edx),%dl
  801632:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801634:	ff 4d 10             	decl   0x10(%ebp)
  801637:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163b:	74 09                	je     801646 <strlcpy+0x3c>
  80163d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	84 c0                	test   %al,%al
  801644:	75 d8                	jne    80161e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80164c:	8b 55 08             	mov    0x8(%ebp),%edx
  80164f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801652:	29 c2                	sub    %eax,%edx
  801654:	89 d0                	mov    %edx,%eax
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80165b:	eb 06                	jmp    801663 <strcmp+0xb>
		p++, q++;
  80165d:	ff 45 08             	incl   0x8(%ebp)
  801660:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	84 c0                	test   %al,%al
  80166a:	74 0e                	je     80167a <strcmp+0x22>
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 10                	mov    (%eax),%dl
  801671:	8b 45 0c             	mov    0xc(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	38 c2                	cmp    %al,%dl
  801678:	74 e3                	je     80165d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	8a 00                	mov    (%eax),%al
  80167f:	0f b6 d0             	movzbl %al,%edx
  801682:	8b 45 0c             	mov    0xc(%ebp),%eax
  801685:	8a 00                	mov    (%eax),%al
  801687:	0f b6 c0             	movzbl %al,%eax
  80168a:	29 c2                	sub    %eax,%edx
  80168c:	89 d0                	mov    %edx,%eax
}
  80168e:	5d                   	pop    %ebp
  80168f:	c3                   	ret    

00801690 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801693:	eb 09                	jmp    80169e <strncmp+0xe>
		n--, p++, q++;
  801695:	ff 4d 10             	decl   0x10(%ebp)
  801698:	ff 45 08             	incl   0x8(%ebp)
  80169b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80169e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a2:	74 17                	je     8016bb <strncmp+0x2b>
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	84 c0                	test   %al,%al
  8016ab:	74 0e                	je     8016bb <strncmp+0x2b>
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 10                	mov    (%eax),%dl
  8016b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	38 c2                	cmp    %al,%dl
  8016b9:	74 da                	je     801695 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8016bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016bf:	75 07                	jne    8016c8 <strncmp+0x38>
		return 0;
  8016c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8016c6:	eb 14                	jmp    8016dc <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	8a 00                	mov    (%eax),%al
  8016cd:	0f b6 d0             	movzbl %al,%edx
  8016d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	0f b6 c0             	movzbl %al,%eax
  8016d8:	29 c2                	sub    %eax,%edx
  8016da:	89 d0                	mov    %edx,%eax
}
  8016dc:	5d                   	pop    %ebp
  8016dd:	c3                   	ret    

008016de <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 04             	sub    $0x4,%esp
  8016e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016ea:	eb 12                	jmp    8016fe <strchr+0x20>
		if (*s == c)
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8016f4:	75 05                	jne    8016fb <strchr+0x1d>
			return (char *) s;
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	eb 11                	jmp    80170c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8016fb:	ff 45 08             	incl   0x8(%ebp)
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	84 c0                	test   %al,%al
  801705:	75 e5                	jne    8016ec <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801707:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
  801711:	83 ec 04             	sub    $0x4,%esp
  801714:	8b 45 0c             	mov    0xc(%ebp),%eax
  801717:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80171a:	eb 0d                	jmp    801729 <strfind+0x1b>
		if (*s == c)
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	8a 00                	mov    (%eax),%al
  801721:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801724:	74 0e                	je     801734 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801726:	ff 45 08             	incl   0x8(%ebp)
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	8a 00                	mov    (%eax),%al
  80172e:	84 c0                	test   %al,%al
  801730:	75 ea                	jne    80171c <strfind+0xe>
  801732:	eb 01                	jmp    801735 <strfind+0x27>
		if (*s == c)
			break;
  801734:	90                   	nop
	return (char *) s;
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
  80173d:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801746:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80174a:	76 63                	jbe    8017af <memset+0x75>
		uint64 data_block = c;
  80174c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174f:	99                   	cltd   
  801750:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801753:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801759:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80175c:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801760:	c1 e0 08             	shl    $0x8,%eax
  801763:	09 45 f0             	or     %eax,-0x10(%ebp)
  801766:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801769:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80176c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80176f:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801773:	c1 e0 10             	shl    $0x10,%eax
  801776:	09 45 f0             	or     %eax,-0x10(%ebp)
  801779:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  80177c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80177f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801782:	89 c2                	mov    %eax,%edx
  801784:	b8 00 00 00 00       	mov    $0x0,%eax
  801789:	09 45 f0             	or     %eax,-0x10(%ebp)
  80178c:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80178f:	eb 18                	jmp    8017a9 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801791:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801794:	8d 41 08             	lea    0x8(%ecx),%eax
  801797:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80179a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80179d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a0:	89 01                	mov    %eax,(%ecx)
  8017a2:	89 51 04             	mov    %edx,0x4(%ecx)
  8017a5:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8017a9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8017ad:	77 e2                	ja     801791 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8017af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b3:	74 23                	je     8017d8 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8017b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017bb:	eb 0e                	jmp    8017cb <memset+0x91>
			*p8++ = (uint8)c;
  8017bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c0:	8d 50 01             	lea    0x1(%eax),%edx
  8017c3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c9:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8017cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8017d4:	85 c0                	test   %eax,%eax
  8017d6:	75 e5                	jne    8017bd <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
  8017e0:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8017e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8017ef:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8017f3:	76 24                	jbe    801819 <memcpy+0x3c>
		while(n >= 8){
  8017f5:	eb 1c                	jmp    801813 <memcpy+0x36>
			*d64 = *s64;
  8017f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017fa:	8b 50 04             	mov    0x4(%eax),%edx
  8017fd:	8b 00                	mov    (%eax),%eax
  8017ff:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801802:	89 01                	mov    %eax,(%ecx)
  801804:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801807:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80180b:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80180f:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801813:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801817:	77 de                	ja     8017f7 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801819:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80181d:	74 31                	je     801850 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80181f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801822:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801825:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801828:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80182b:	eb 16                	jmp    801843 <memcpy+0x66>
			*d8++ = *s8++;
  80182d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801830:	8d 50 01             	lea    0x1(%eax),%edx
  801833:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801836:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801839:	8d 4a 01             	lea    0x1(%edx),%ecx
  80183c:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80183f:	8a 12                	mov    (%edx),%dl
  801841:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801843:	8b 45 10             	mov    0x10(%ebp),%eax
  801846:	8d 50 ff             	lea    -0x1(%eax),%edx
  801849:	89 55 10             	mov    %edx,0x10(%ebp)
  80184c:	85 c0                	test   %eax,%eax
  80184e:	75 dd                	jne    80182d <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801850:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
  801858:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80185b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801861:	8b 45 08             	mov    0x8(%ebp),%eax
  801864:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801867:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80186a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80186d:	73 50                	jae    8018bf <memmove+0x6a>
  80186f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801872:	8b 45 10             	mov    0x10(%ebp),%eax
  801875:	01 d0                	add    %edx,%eax
  801877:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80187a:	76 43                	jbe    8018bf <memmove+0x6a>
		s += n;
  80187c:	8b 45 10             	mov    0x10(%ebp),%eax
  80187f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801882:	8b 45 10             	mov    0x10(%ebp),%eax
  801885:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801888:	eb 10                	jmp    80189a <memmove+0x45>
			*--d = *--s;
  80188a:	ff 4d f8             	decl   -0x8(%ebp)
  80188d:	ff 4d fc             	decl   -0x4(%ebp)
  801890:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801893:	8a 10                	mov    (%eax),%dl
  801895:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801898:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80189a:	8b 45 10             	mov    0x10(%ebp),%eax
  80189d:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8018a3:	85 c0                	test   %eax,%eax
  8018a5:	75 e3                	jne    80188a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8018a7:	eb 23                	jmp    8018cc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8018a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ac:	8d 50 01             	lea    0x1(%eax),%edx
  8018af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018b8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8018bb:	8a 12                	mov    (%edx),%dl
  8018bd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8018bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8018c8:	85 c0                	test   %eax,%eax
  8018ca:	75 dd                	jne    8018a9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
  8018d4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8018dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8018e3:	eb 2a                	jmp    80190f <memcmp+0x3e>
		if (*s1 != *s2)
  8018e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e8:	8a 10                	mov    (%eax),%dl
  8018ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ed:	8a 00                	mov    (%eax),%al
  8018ef:	38 c2                	cmp    %al,%dl
  8018f1:	74 16                	je     801909 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8018f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f6:	8a 00                	mov    (%eax),%al
  8018f8:	0f b6 d0             	movzbl %al,%edx
  8018fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fe:	8a 00                	mov    (%eax),%al
  801900:	0f b6 c0             	movzbl %al,%eax
  801903:	29 c2                	sub    %eax,%edx
  801905:	89 d0                	mov    %edx,%eax
  801907:	eb 18                	jmp    801921 <memcmp+0x50>
		s1++, s2++;
  801909:	ff 45 fc             	incl   -0x4(%ebp)
  80190c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80190f:	8b 45 10             	mov    0x10(%ebp),%eax
  801912:	8d 50 ff             	lea    -0x1(%eax),%edx
  801915:	89 55 10             	mov    %edx,0x10(%ebp)
  801918:	85 c0                	test   %eax,%eax
  80191a:	75 c9                	jne    8018e5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80191c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801929:	8b 55 08             	mov    0x8(%ebp),%edx
  80192c:	8b 45 10             	mov    0x10(%ebp),%eax
  80192f:	01 d0                	add    %edx,%eax
  801931:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801934:	eb 15                	jmp    80194b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801936:	8b 45 08             	mov    0x8(%ebp),%eax
  801939:	8a 00                	mov    (%eax),%al
  80193b:	0f b6 d0             	movzbl %al,%edx
  80193e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801941:	0f b6 c0             	movzbl %al,%eax
  801944:	39 c2                	cmp    %eax,%edx
  801946:	74 0d                	je     801955 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801948:	ff 45 08             	incl   0x8(%ebp)
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801951:	72 e3                	jb     801936 <memfind+0x13>
  801953:	eb 01                	jmp    801956 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801955:	90                   	nop
	return (void *) s;
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
  80195e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801961:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801968:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80196f:	eb 03                	jmp    801974 <strtol+0x19>
		s++;
  801971:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	3c 20                	cmp    $0x20,%al
  80197b:	74 f4                	je     801971 <strtol+0x16>
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	8a 00                	mov    (%eax),%al
  801982:	3c 09                	cmp    $0x9,%al
  801984:	74 eb                	je     801971 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
  801989:	8a 00                	mov    (%eax),%al
  80198b:	3c 2b                	cmp    $0x2b,%al
  80198d:	75 05                	jne    801994 <strtol+0x39>
		s++;
  80198f:	ff 45 08             	incl   0x8(%ebp)
  801992:	eb 13                	jmp    8019a7 <strtol+0x4c>
	else if (*s == '-')
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	8a 00                	mov    (%eax),%al
  801999:	3c 2d                	cmp    $0x2d,%al
  80199b:	75 0a                	jne    8019a7 <strtol+0x4c>
		s++, neg = 1;
  80199d:	ff 45 08             	incl   0x8(%ebp)
  8019a0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8019a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019ab:	74 06                	je     8019b3 <strtol+0x58>
  8019ad:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8019b1:	75 20                	jne    8019d3 <strtol+0x78>
  8019b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b6:	8a 00                	mov    (%eax),%al
  8019b8:	3c 30                	cmp    $0x30,%al
  8019ba:	75 17                	jne    8019d3 <strtol+0x78>
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	40                   	inc    %eax
  8019c0:	8a 00                	mov    (%eax),%al
  8019c2:	3c 78                	cmp    $0x78,%al
  8019c4:	75 0d                	jne    8019d3 <strtol+0x78>
		s += 2, base = 16;
  8019c6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8019ca:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8019d1:	eb 28                	jmp    8019fb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8019d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019d7:	75 15                	jne    8019ee <strtol+0x93>
  8019d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dc:	8a 00                	mov    (%eax),%al
  8019de:	3c 30                	cmp    $0x30,%al
  8019e0:	75 0c                	jne    8019ee <strtol+0x93>
		s++, base = 8;
  8019e2:	ff 45 08             	incl   0x8(%ebp)
  8019e5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8019ec:	eb 0d                	jmp    8019fb <strtol+0xa0>
	else if (base == 0)
  8019ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019f2:	75 07                	jne    8019fb <strtol+0xa0>
		base = 10;
  8019f4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8019fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fe:	8a 00                	mov    (%eax),%al
  801a00:	3c 2f                	cmp    $0x2f,%al
  801a02:	7e 19                	jle    801a1d <strtol+0xc2>
  801a04:	8b 45 08             	mov    0x8(%ebp),%eax
  801a07:	8a 00                	mov    (%eax),%al
  801a09:	3c 39                	cmp    $0x39,%al
  801a0b:	7f 10                	jg     801a1d <strtol+0xc2>
			dig = *s - '0';
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	8a 00                	mov    (%eax),%al
  801a12:	0f be c0             	movsbl %al,%eax
  801a15:	83 e8 30             	sub    $0x30,%eax
  801a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a1b:	eb 42                	jmp    801a5f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	8a 00                	mov    (%eax),%al
  801a22:	3c 60                	cmp    $0x60,%al
  801a24:	7e 19                	jle    801a3f <strtol+0xe4>
  801a26:	8b 45 08             	mov    0x8(%ebp),%eax
  801a29:	8a 00                	mov    (%eax),%al
  801a2b:	3c 7a                	cmp    $0x7a,%al
  801a2d:	7f 10                	jg     801a3f <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a32:	8a 00                	mov    (%eax),%al
  801a34:	0f be c0             	movsbl %al,%eax
  801a37:	83 e8 57             	sub    $0x57,%eax
  801a3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a3d:	eb 20                	jmp    801a5f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a42:	8a 00                	mov    (%eax),%al
  801a44:	3c 40                	cmp    $0x40,%al
  801a46:	7e 39                	jle    801a81 <strtol+0x126>
  801a48:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4b:	8a 00                	mov    (%eax),%al
  801a4d:	3c 5a                	cmp    $0x5a,%al
  801a4f:	7f 30                	jg     801a81 <strtol+0x126>
			dig = *s - 'A' + 10;
  801a51:	8b 45 08             	mov    0x8(%ebp),%eax
  801a54:	8a 00                	mov    (%eax),%al
  801a56:	0f be c0             	movsbl %al,%eax
  801a59:	83 e8 37             	sub    $0x37,%eax
  801a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a62:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a65:	7d 19                	jge    801a80 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a67:	ff 45 08             	incl   0x8(%ebp)
  801a6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a6d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a71:	89 c2                	mov    %eax,%edx
  801a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a76:	01 d0                	add    %edx,%eax
  801a78:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a7b:	e9 7b ff ff ff       	jmp    8019fb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a80:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a85:	74 08                	je     801a8f <strtol+0x134>
		*endptr = (char *) s;
  801a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a8a:	8b 55 08             	mov    0x8(%ebp),%edx
  801a8d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a93:	74 07                	je     801a9c <strtol+0x141>
  801a95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a98:	f7 d8                	neg    %eax
  801a9a:	eb 03                	jmp    801a9f <strtol+0x144>
  801a9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a9f:	c9                   	leave  
  801aa0:	c3                   	ret    

00801aa1 <ltostr>:

void
ltostr(long value, char *str)
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
  801aa4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801aa7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801aae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801ab5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ab9:	79 13                	jns    801ace <ltostr+0x2d>
	{
		neg = 1;
  801abb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801ac8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801acb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801ace:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801ad6:	99                   	cltd   
  801ad7:	f7 f9                	idiv   %ecx
  801ad9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801adc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801adf:	8d 50 01             	lea    0x1(%eax),%edx
  801ae2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801ae5:	89 c2                	mov    %eax,%edx
  801ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aea:	01 d0                	add    %edx,%eax
  801aec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801aef:	83 c2 30             	add    $0x30,%edx
  801af2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801af4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801af7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801afc:	f7 e9                	imul   %ecx
  801afe:	c1 fa 02             	sar    $0x2,%edx
  801b01:	89 c8                	mov    %ecx,%eax
  801b03:	c1 f8 1f             	sar    $0x1f,%eax
  801b06:	29 c2                	sub    %eax,%edx
  801b08:	89 d0                	mov    %edx,%eax
  801b0a:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801b0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b11:	75 bb                	jne    801ace <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b1d:	48                   	dec    %eax
  801b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b21:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b25:	74 3d                	je     801b64 <ltostr+0xc3>
		start = 1 ;
  801b27:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b2e:	eb 34                	jmp    801b64 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801b30:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b33:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b36:	01 d0                	add    %edx,%eax
  801b38:	8a 00                	mov    (%eax),%al
  801b3a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b40:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b43:	01 c2                	add    %eax,%edx
  801b45:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b48:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b4b:	01 c8                	add    %ecx,%eax
  801b4d:	8a 00                	mov    (%eax),%al
  801b4f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b51:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b54:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b57:	01 c2                	add    %eax,%edx
  801b59:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b5c:	88 02                	mov    %al,(%edx)
		start++ ;
  801b5e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b61:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b67:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b6a:	7c c4                	jl     801b30 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b6c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b72:	01 d0                	add    %edx,%eax
  801b74:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b77:	90                   	nop
  801b78:	c9                   	leave  
  801b79:	c3                   	ret    

00801b7a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
  801b7d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	e8 c4 f9 ff ff       	call   80154c <strlen>
  801b88:	83 c4 04             	add    $0x4,%esp
  801b8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b8e:	ff 75 0c             	pushl  0xc(%ebp)
  801b91:	e8 b6 f9 ff ff       	call   80154c <strlen>
  801b96:	83 c4 04             	add    $0x4,%esp
  801b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801ba3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801baa:	eb 17                	jmp    801bc3 <strcconcat+0x49>
		final[s] = str1[s] ;
  801bac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801baf:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb2:	01 c2                	add    %eax,%edx
  801bb4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bba:	01 c8                	add    %ecx,%eax
  801bbc:	8a 00                	mov    (%eax),%al
  801bbe:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801bc0:	ff 45 fc             	incl   -0x4(%ebp)
  801bc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bc6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bc9:	7c e1                	jl     801bac <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801bcb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801bd2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801bd9:	eb 1f                	jmp    801bfa <strcconcat+0x80>
		final[s++] = str2[i] ;
  801bdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bde:	8d 50 01             	lea    0x1(%eax),%edx
  801be1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801be4:	89 c2                	mov    %eax,%edx
  801be6:	8b 45 10             	mov    0x10(%ebp),%eax
  801be9:	01 c2                	add    %eax,%edx
  801beb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bf1:	01 c8                	add    %ecx,%eax
  801bf3:	8a 00                	mov    (%eax),%al
  801bf5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801bf7:	ff 45 f8             	incl   -0x8(%ebp)
  801bfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bfd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c00:	7c d9                	jl     801bdb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c02:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c05:	8b 45 10             	mov    0x10(%ebp),%eax
  801c08:	01 d0                	add    %edx,%eax
  801c0a:	c6 00 00             	movb   $0x0,(%eax)
}
  801c0d:	90                   	nop
  801c0e:	c9                   	leave  
  801c0f:	c3                   	ret    

00801c10 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c13:	8b 45 14             	mov    0x14(%ebp),%eax
  801c16:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c1c:	8b 45 14             	mov    0x14(%ebp),%eax
  801c1f:	8b 00                	mov    (%eax),%eax
  801c21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c28:	8b 45 10             	mov    0x10(%ebp),%eax
  801c2b:	01 d0                	add    %edx,%eax
  801c2d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c33:	eb 0c                	jmp    801c41 <strsplit+0x31>
			*string++ = 0;
  801c35:	8b 45 08             	mov    0x8(%ebp),%eax
  801c38:	8d 50 01             	lea    0x1(%eax),%edx
  801c3b:	89 55 08             	mov    %edx,0x8(%ebp)
  801c3e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c41:	8b 45 08             	mov    0x8(%ebp),%eax
  801c44:	8a 00                	mov    (%eax),%al
  801c46:	84 c0                	test   %al,%al
  801c48:	74 18                	je     801c62 <strsplit+0x52>
  801c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4d:	8a 00                	mov    (%eax),%al
  801c4f:	0f be c0             	movsbl %al,%eax
  801c52:	50                   	push   %eax
  801c53:	ff 75 0c             	pushl  0xc(%ebp)
  801c56:	e8 83 fa ff ff       	call   8016de <strchr>
  801c5b:	83 c4 08             	add    $0x8,%esp
  801c5e:	85 c0                	test   %eax,%eax
  801c60:	75 d3                	jne    801c35 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	8a 00                	mov    (%eax),%al
  801c67:	84 c0                	test   %al,%al
  801c69:	74 5a                	je     801cc5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801c6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801c6e:	8b 00                	mov    (%eax),%eax
  801c70:	83 f8 0f             	cmp    $0xf,%eax
  801c73:	75 07                	jne    801c7c <strsplit+0x6c>
		{
			return 0;
  801c75:	b8 00 00 00 00       	mov    $0x0,%eax
  801c7a:	eb 66                	jmp    801ce2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c7c:	8b 45 14             	mov    0x14(%ebp),%eax
  801c7f:	8b 00                	mov    (%eax),%eax
  801c81:	8d 48 01             	lea    0x1(%eax),%ecx
  801c84:	8b 55 14             	mov    0x14(%ebp),%edx
  801c87:	89 0a                	mov    %ecx,(%edx)
  801c89:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c90:	8b 45 10             	mov    0x10(%ebp),%eax
  801c93:	01 c2                	add    %eax,%edx
  801c95:	8b 45 08             	mov    0x8(%ebp),%eax
  801c98:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c9a:	eb 03                	jmp    801c9f <strsplit+0x8f>
			string++;
  801c9c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	8a 00                	mov    (%eax),%al
  801ca4:	84 c0                	test   %al,%al
  801ca6:	74 8b                	je     801c33 <strsplit+0x23>
  801ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cab:	8a 00                	mov    (%eax),%al
  801cad:	0f be c0             	movsbl %al,%eax
  801cb0:	50                   	push   %eax
  801cb1:	ff 75 0c             	pushl  0xc(%ebp)
  801cb4:	e8 25 fa ff ff       	call   8016de <strchr>
  801cb9:	83 c4 08             	add    $0x8,%esp
  801cbc:	85 c0                	test   %eax,%eax
  801cbe:	74 dc                	je     801c9c <strsplit+0x8c>
			string++;
	}
  801cc0:	e9 6e ff ff ff       	jmp    801c33 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801cc5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801cc6:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc9:	8b 00                	mov    (%eax),%eax
  801ccb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cd2:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd5:	01 d0                	add    %edx,%eax
  801cd7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801cdd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ce2:	c9                   	leave  
  801ce3:	c3                   	ret    

00801ce4 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801ce4:	55                   	push   %ebp
  801ce5:	89 e5                	mov    %esp,%ebp
  801ce7:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801cea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ced:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801cf0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801cf7:	eb 4a                	jmp    801d43 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801cf9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cff:	01 c2                	add    %eax,%edx
  801d01:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801d04:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d07:	01 c8                	add    %ecx,%eax
  801d09:	8a 00                	mov    (%eax),%al
  801d0b:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801d0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d13:	01 d0                	add    %edx,%eax
  801d15:	8a 00                	mov    (%eax),%al
  801d17:	3c 40                	cmp    $0x40,%al
  801d19:	7e 25                	jle    801d40 <str2lower+0x5c>
  801d1b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d21:	01 d0                	add    %edx,%eax
  801d23:	8a 00                	mov    (%eax),%al
  801d25:	3c 5a                	cmp    $0x5a,%al
  801d27:	7f 17                	jg     801d40 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801d29:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2f:	01 d0                	add    %edx,%eax
  801d31:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801d34:	8b 55 08             	mov    0x8(%ebp),%edx
  801d37:	01 ca                	add    %ecx,%edx
  801d39:	8a 12                	mov    (%edx),%dl
  801d3b:	83 c2 20             	add    $0x20,%edx
  801d3e:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801d40:	ff 45 fc             	incl   -0x4(%ebp)
  801d43:	ff 75 0c             	pushl  0xc(%ebp)
  801d46:	e8 01 f8 ff ff       	call   80154c <strlen>
  801d4b:	83 c4 04             	add    $0x4,%esp
  801d4e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801d51:	7f a6                	jg     801cf9 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801d53:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
  801d5b:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801d5e:	a1 08 40 80 00       	mov    0x804008,%eax
  801d63:	85 c0                	test   %eax,%eax
  801d65:	74 2d                	je     801d94 <uheap_init+0x3c>
	{
		buddy_init();
  801d67:	e8 87 06 00 00       	call   8023f3 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801d6c:	e8 31 05 00 00       	call   8022a2 <sys_get_uheap_strategy>
  801d71:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801d76:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801d7d:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801d80:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801d87:	00 00 80 
		__firstTimeFlag = 0;
  801d8a:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801d91:	00 00 00 
	}
}
  801d94:	90                   	nop
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
  801d9a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801d9d:	83 ec 04             	sub    $0x4,%esp
  801da0:	68 3c 30 80 00       	push   $0x80303c
  801da5:	6a 25                	push   $0x25
  801da7:	68 6d 30 80 00       	push   $0x80306d
  801dac:	e8 ec eb ff ff       	call   80099d <_panic>

00801db1 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
  801db4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801db7:	83 ec 04             	sub    $0x4,%esp
  801dba:	68 7c 30 80 00       	push   $0x80307c
  801dbf:	6a 2f                	push   $0x2f
  801dc1:	68 6d 30 80 00       	push   $0x80306d
  801dc6:	e8 d2 eb ff ff       	call   80099d <_panic>

00801dcb <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
  801dce:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801dd1:	e8 82 ff ff ff       	call   801d58 <uheap_init>
	if (size == 0) return NULL ;
  801dd6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801dda:	75 07                	jne    801de3 <malloc+0x18>
  801ddc:	b8 00 00 00 00       	mov    $0x0,%eax
  801de1:	eb 14                	jmp    801df7 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801de3:	83 ec 04             	sub    $0x4,%esp
  801de6:	68 b0 30 80 00       	push   $0x8030b0
  801deb:	6a 43                	push   $0x43
  801ded:	68 6d 30 80 00       	push   $0x80306d
  801df2:	e8 a6 eb ff ff       	call   80099d <_panic>
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
  801dfc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801dff:	83 ec 04             	sub    $0x4,%esp
  801e02:	68 d8 30 80 00       	push   $0x8030d8
  801e07:	6a 4e                	push   $0x4e
  801e09:	68 6d 30 80 00       	push   $0x80306d
  801e0e:	e8 8a eb ff ff       	call   80099d <_panic>

00801e13 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
  801e16:	83 ec 18             	sub    $0x18,%esp
  801e19:	8b 45 10             	mov    0x10(%ebp),%eax
  801e1c:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801e1f:	e8 34 ff ff ff       	call   801d58 <uheap_init>
	if (size == 0) return NULL ;
  801e24:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e28:	75 07                	jne    801e31 <smalloc+0x1e>
  801e2a:	b8 00 00 00 00       	mov    $0x0,%eax
  801e2f:	eb 14                	jmp    801e45 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801e31:	83 ec 04             	sub    $0x4,%esp
  801e34:	68 fc 30 80 00       	push   $0x8030fc
  801e39:	6a 5f                	push   $0x5f
  801e3b:	68 6d 30 80 00       	push   $0x80306d
  801e40:	e8 58 eb ff ff       	call   80099d <_panic>
}
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
  801e4a:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801e4d:	e8 06 ff ff ff       	call   801d58 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801e52:	83 ec 04             	sub    $0x4,%esp
  801e55:	68 24 31 80 00       	push   $0x803124
  801e5a:	6a 6f                	push   $0x6f
  801e5c:	68 6d 30 80 00       	push   $0x80306d
  801e61:	e8 37 eb ff ff       	call   80099d <_panic>

00801e66 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
  801e69:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801e6c:	83 ec 04             	sub    $0x4,%esp
  801e6f:	68 48 31 80 00       	push   $0x803148
  801e74:	6a 7e                	push   $0x7e
  801e76:	68 6d 30 80 00       	push   $0x80306d
  801e7b:	e8 1d eb ff ff       	call   80099d <_panic>

00801e80 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
  801e83:	57                   	push   %edi
  801e84:	56                   	push   %esi
  801e85:	53                   	push   %ebx
  801e86:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e89:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e92:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e95:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e98:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e9b:	cd 30                	int    $0x30
  801e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ea0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ea3:	83 c4 10             	add    $0x10,%esp
  801ea6:	5b                   	pop    %ebx
  801ea7:	5e                   	pop    %esi
  801ea8:	5f                   	pop    %edi
  801ea9:	5d                   	pop    %ebp
  801eaa:	c3                   	ret    

00801eab <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 04             	sub    $0x4,%esp
  801eb1:	8b 45 10             	mov    0x10(%ebp),%eax
  801eb4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801eb7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801eba:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec1:	6a 00                	push   $0x0
  801ec3:	51                   	push   %ecx
  801ec4:	52                   	push   %edx
  801ec5:	ff 75 0c             	pushl  0xc(%ebp)
  801ec8:	50                   	push   %eax
  801ec9:	6a 00                	push   $0x0
  801ecb:	e8 b0 ff ff ff       	call   801e80 <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
}
  801ed3:	90                   	nop
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 02                	push   $0x2
  801ee5:	e8 96 ff ff ff       	call   801e80 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_lock_cons>:

void sys_lock_cons(void)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 03                	push   $0x3
  801efe:	e8 7d ff ff ff       	call   801e80 <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
}
  801f06:	90                   	nop
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 04                	push   $0x4
  801f18:	e8 63 ff ff ff       	call   801e80 <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	90                   	nop
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f29:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	52                   	push   %edx
  801f33:	50                   	push   %eax
  801f34:	6a 08                	push   $0x8
  801f36:	e8 45 ff ff ff       	call   801e80 <syscall>
  801f3b:	83 c4 18             	add    $0x18,%esp
}
  801f3e:	c9                   	leave  
  801f3f:	c3                   	ret    

00801f40 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f40:	55                   	push   %ebp
  801f41:	89 e5                	mov    %esp,%ebp
  801f43:	56                   	push   %esi
  801f44:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f45:	8b 75 18             	mov    0x18(%ebp),%esi
  801f48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f51:	8b 45 08             	mov    0x8(%ebp),%eax
  801f54:	56                   	push   %esi
  801f55:	53                   	push   %ebx
  801f56:	51                   	push   %ecx
  801f57:	52                   	push   %edx
  801f58:	50                   	push   %eax
  801f59:	6a 09                	push   $0x9
  801f5b:	e8 20 ff ff ff       	call   801e80 <syscall>
  801f60:	83 c4 18             	add    $0x18,%esp
}
  801f63:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f66:	5b                   	pop    %ebx
  801f67:	5e                   	pop    %esi
  801f68:	5d                   	pop    %ebp
  801f69:	c3                   	ret    

00801f6a <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801f6a:	55                   	push   %ebp
  801f6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	ff 75 08             	pushl  0x8(%ebp)
  801f78:	6a 0a                	push   $0xa
  801f7a:	e8 01 ff ff ff       	call   801e80 <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	c9                   	leave  
  801f83:	c3                   	ret    

00801f84 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f84:	55                   	push   %ebp
  801f85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	ff 75 0c             	pushl  0xc(%ebp)
  801f90:	ff 75 08             	pushl  0x8(%ebp)
  801f93:	6a 0b                	push   $0xb
  801f95:	e8 e6 fe ff ff       	call   801e80 <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 0c                	push   $0xc
  801fae:	e8 cd fe ff ff       	call   801e80 <syscall>
  801fb3:	83 c4 18             	add    $0x18,%esp
}
  801fb6:	c9                   	leave  
  801fb7:	c3                   	ret    

00801fb8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 0d                	push   $0xd
  801fc7:	e8 b4 fe ff ff       	call   801e80 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 0e                	push   $0xe
  801fe0:	e8 9b fe ff ff       	call   801e80 <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
}
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 0f                	push   $0xf
  801ff9:	e8 82 fe ff ff       	call   801e80 <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	ff 75 08             	pushl  0x8(%ebp)
  802011:	6a 10                	push   $0x10
  802013:	e8 68 fe ff ff       	call   801e80 <syscall>
  802018:	83 c4 18             	add    $0x18,%esp
}
  80201b:	c9                   	leave  
  80201c:	c3                   	ret    

0080201d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80201d:	55                   	push   %ebp
  80201e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 11                	push   $0x11
  80202c:	e8 4f fe ff ff       	call   801e80 <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	90                   	nop
  802035:	c9                   	leave  
  802036:	c3                   	ret    

00802037 <sys_cputc>:

void
sys_cputc(const char c)
{
  802037:	55                   	push   %ebp
  802038:	89 e5                	mov    %esp,%ebp
  80203a:	83 ec 04             	sub    $0x4,%esp
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802043:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	50                   	push   %eax
  802050:	6a 01                	push   $0x1
  802052:	e8 29 fe ff ff       	call   801e80 <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	90                   	nop
  80205b:	c9                   	leave  
  80205c:	c3                   	ret    

0080205d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80205d:	55                   	push   %ebp
  80205e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 14                	push   $0x14
  80206c:	e8 0f fe ff ff       	call   801e80 <syscall>
  802071:	83 c4 18             	add    $0x18,%esp
}
  802074:	90                   	nop
  802075:	c9                   	leave  
  802076:	c3                   	ret    

00802077 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  802077:	55                   	push   %ebp
  802078:	89 e5                	mov    %esp,%ebp
  80207a:	83 ec 04             	sub    $0x4,%esp
  80207d:	8b 45 10             	mov    0x10(%ebp),%eax
  802080:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  802083:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802086:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80208a:	8b 45 08             	mov    0x8(%ebp),%eax
  80208d:	6a 00                	push   $0x0
  80208f:	51                   	push   %ecx
  802090:	52                   	push   %edx
  802091:	ff 75 0c             	pushl  0xc(%ebp)
  802094:	50                   	push   %eax
  802095:	6a 15                	push   $0x15
  802097:	e8 e4 fd ff ff       	call   801e80 <syscall>
  80209c:	83 c4 18             	add    $0x18,%esp
}
  80209f:	c9                   	leave  
  8020a0:	c3                   	ret    

008020a1 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8020a4:	8b 55 10             	mov    0x10(%ebp),%edx
  8020a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	52                   	push   %edx
  8020af:	50                   	push   %eax
  8020b0:	ff 75 08             	pushl  0x8(%ebp)
  8020b3:	6a 16                	push   $0x16
  8020b5:	e8 c6 fd ff ff       	call   801e80 <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
}
  8020bd:	c9                   	leave  
  8020be:	c3                   	ret    

008020bf <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8020bf:	55                   	push   %ebp
  8020c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8020c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	52                   	push   %edx
  8020cf:	50                   	push   %eax
  8020d0:	6a 17                	push   $0x17
  8020d2:	e8 a9 fd ff ff       	call   801e80 <syscall>
  8020d7:	83 c4 18             	add    $0x18,%esp
}
  8020da:	c9                   	leave  
  8020db:	c3                   	ret    

008020dc <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8020dc:	55                   	push   %ebp
  8020dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8020df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	52                   	push   %edx
  8020ec:	50                   	push   %eax
  8020ed:	6a 18                	push   $0x18
  8020ef:	e8 8c fd ff ff       	call   801e80 <syscall>
  8020f4:	83 c4 18             	add    $0x18,%esp
}
  8020f7:	c9                   	leave  
  8020f8:	c3                   	ret    

008020f9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8020f9:	55                   	push   %ebp
  8020fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8020fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ff:	6a 00                	push   $0x0
  802101:	ff 75 14             	pushl  0x14(%ebp)
  802104:	ff 75 10             	pushl  0x10(%ebp)
  802107:	ff 75 0c             	pushl  0xc(%ebp)
  80210a:	50                   	push   %eax
  80210b:	6a 19                	push   $0x19
  80210d:	e8 6e fd ff ff       	call   801e80 <syscall>
  802112:	83 c4 18             	add    $0x18,%esp
}
  802115:	c9                   	leave  
  802116:	c3                   	ret    

00802117 <sys_run_env>:

void sys_run_env(int32 envId)
{
  802117:	55                   	push   %ebp
  802118:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80211a:	8b 45 08             	mov    0x8(%ebp),%eax
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	50                   	push   %eax
  802126:	6a 1a                	push   $0x1a
  802128:	e8 53 fd ff ff       	call   801e80 <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
}
  802130:	90                   	nop
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  802136:	8b 45 08             	mov    0x8(%ebp),%eax
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	50                   	push   %eax
  802142:	6a 1b                	push   $0x1b
  802144:	e8 37 fd ff ff       	call   801e80 <syscall>
  802149:	83 c4 18             	add    $0x18,%esp
}
  80214c:	c9                   	leave  
  80214d:	c3                   	ret    

0080214e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80214e:	55                   	push   %ebp
  80214f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 05                	push   $0x5
  80215d:	e8 1e fd ff ff       	call   801e80 <syscall>
  802162:	83 c4 18             	add    $0x18,%esp
}
  802165:	c9                   	leave  
  802166:	c3                   	ret    

00802167 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802167:	55                   	push   %ebp
  802168:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 06                	push   $0x6
  802176:	e8 05 fd ff ff       	call   801e80 <syscall>
  80217b:	83 c4 18             	add    $0x18,%esp
}
  80217e:	c9                   	leave  
  80217f:	c3                   	ret    

00802180 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802180:	55                   	push   %ebp
  802181:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 07                	push   $0x7
  80218f:	e8 ec fc ff ff       	call   801e80 <syscall>
  802194:	83 c4 18             	add    $0x18,%esp
}
  802197:	c9                   	leave  
  802198:	c3                   	ret    

00802199 <sys_exit_env>:


void sys_exit_env(void)
{
  802199:	55                   	push   %ebp
  80219a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 1c                	push   $0x1c
  8021a8:	e8 d3 fc ff ff       	call   801e80 <syscall>
  8021ad:	83 c4 18             	add    $0x18,%esp
}
  8021b0:	90                   	nop
  8021b1:	c9                   	leave  
  8021b2:	c3                   	ret    

008021b3 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021b3:	55                   	push   %ebp
  8021b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	ff 75 10             	pushl  0x10(%ebp)
  8021bd:	ff 75 0c             	pushl  0xc(%ebp)
  8021c0:	ff 75 08             	pushl  0x8(%ebp)
  8021c3:	6a 13                	push   $0x13
  8021c5:	e8 b6 fc ff ff       	call   801e80 <syscall>
  8021ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8021cd:	90                   	nop
}
  8021ce:	c9                   	leave  
  8021cf:	c3                   	ret    

008021d0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021d0:	55                   	push   %ebp
  8021d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 1e                	push   $0x1e
  8021df:	e8 9c fc ff ff       	call   801e80 <syscall>
  8021e4:	83 c4 18             	add    $0x18,%esp
}
  8021e7:	c9                   	leave  
  8021e8:	c3                   	ret    

008021e9 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8021e9:	55                   	push   %ebp
  8021ea:	89 e5                	mov    %esp,%ebp
  8021ec:	83 ec 04             	sub    $0x4,%esp
  8021ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021f5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	50                   	push   %eax
  802202:	6a 1f                	push   $0x1f
  802204:	e8 77 fc ff ff       	call   801e80 <syscall>
  802209:	83 c4 18             	add    $0x18,%esp
	return ;
  80220c:	90                   	nop
}
  80220d:	c9                   	leave  
  80220e:	c3                   	ret    

0080220f <rsttst>:
void rsttst()
{
  80220f:	55                   	push   %ebp
  802210:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 00                	push   $0x0
  80221c:	6a 21                	push   $0x21
  80221e:	e8 5d fc ff ff       	call   801e80 <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
	return ;
  802226:	90                   	nop
}
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
  80222c:	83 ec 04             	sub    $0x4,%esp
  80222f:	8b 45 14             	mov    0x14(%ebp),%eax
  802232:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802235:	8b 55 18             	mov    0x18(%ebp),%edx
  802238:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80223c:	52                   	push   %edx
  80223d:	50                   	push   %eax
  80223e:	ff 75 10             	pushl  0x10(%ebp)
  802241:	ff 75 0c             	pushl  0xc(%ebp)
  802244:	ff 75 08             	pushl  0x8(%ebp)
  802247:	6a 20                	push   $0x20
  802249:	e8 32 fc ff ff       	call   801e80 <syscall>
  80224e:	83 c4 18             	add    $0x18,%esp
	return ;
  802251:	90                   	nop
}
  802252:	c9                   	leave  
  802253:	c3                   	ret    

00802254 <chktst>:
void chktst(uint32 n)
{
  802254:	55                   	push   %ebp
  802255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802257:	6a 00                	push   $0x0
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	ff 75 08             	pushl  0x8(%ebp)
  802262:	6a 22                	push   $0x22
  802264:	e8 17 fc ff ff       	call   801e80 <syscall>
  802269:	83 c4 18             	add    $0x18,%esp
	return ;
  80226c:	90                   	nop
}
  80226d:	c9                   	leave  
  80226e:	c3                   	ret    

0080226f <inctst>:

void inctst()
{
  80226f:	55                   	push   %ebp
  802270:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 23                	push   $0x23
  80227e:	e8 fd fb ff ff       	call   801e80 <syscall>
  802283:	83 c4 18             	add    $0x18,%esp
	return ;
  802286:	90                   	nop
}
  802287:	c9                   	leave  
  802288:	c3                   	ret    

00802289 <gettst>:
uint32 gettst()
{
  802289:	55                   	push   %ebp
  80228a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80228c:	6a 00                	push   $0x0
  80228e:	6a 00                	push   $0x0
  802290:	6a 00                	push   $0x0
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 24                	push   $0x24
  802298:	e8 e3 fb ff ff       	call   801e80 <syscall>
  80229d:	83 c4 18             	add    $0x18,%esp
}
  8022a0:	c9                   	leave  
  8022a1:	c3                   	ret    

008022a2 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8022a2:	55                   	push   %ebp
  8022a3:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022a5:	6a 00                	push   $0x0
  8022a7:	6a 00                	push   $0x0
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 25                	push   $0x25
  8022b1:	e8 ca fb ff ff       	call   801e80 <syscall>
  8022b6:	83 c4 18             	add    $0x18,%esp
  8022b9:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8022be:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8022c3:	c9                   	leave  
  8022c4:	c3                   	ret    

008022c5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022c5:	55                   	push   %ebp
  8022c6:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8022c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cb:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 00                	push   $0x0
  8022d8:	ff 75 08             	pushl  0x8(%ebp)
  8022db:	6a 26                	push   $0x26
  8022dd:	e8 9e fb ff ff       	call   801e80 <syscall>
  8022e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8022e5:	90                   	nop
}
  8022e6:	c9                   	leave  
  8022e7:	c3                   	ret    

008022e8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8022e8:	55                   	push   %ebp
  8022e9:	89 e5                	mov    %esp,%ebp
  8022eb:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8022ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f8:	6a 00                	push   $0x0
  8022fa:	53                   	push   %ebx
  8022fb:	51                   	push   %ecx
  8022fc:	52                   	push   %edx
  8022fd:	50                   	push   %eax
  8022fe:	6a 27                	push   $0x27
  802300:	e8 7b fb ff ff       	call   801e80 <syscall>
  802305:	83 c4 18             	add    $0x18,%esp
}
  802308:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80230b:	c9                   	leave  
  80230c:	c3                   	ret    

0080230d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80230d:	55                   	push   %ebp
  80230e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802310:	8b 55 0c             	mov    0xc(%ebp),%edx
  802313:	8b 45 08             	mov    0x8(%ebp),%eax
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	52                   	push   %edx
  80231d:	50                   	push   %eax
  80231e:	6a 28                	push   $0x28
  802320:	e8 5b fb ff ff       	call   801e80 <syscall>
  802325:	83 c4 18             	add    $0x18,%esp
}
  802328:	c9                   	leave  
  802329:	c3                   	ret    

0080232a <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80232a:	55                   	push   %ebp
  80232b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80232d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802330:	8b 55 0c             	mov    0xc(%ebp),%edx
  802333:	8b 45 08             	mov    0x8(%ebp),%eax
  802336:	6a 00                	push   $0x0
  802338:	51                   	push   %ecx
  802339:	ff 75 10             	pushl  0x10(%ebp)
  80233c:	52                   	push   %edx
  80233d:	50                   	push   %eax
  80233e:	6a 29                	push   $0x29
  802340:	e8 3b fb ff ff       	call   801e80 <syscall>
  802345:	83 c4 18             	add    $0x18,%esp
}
  802348:	c9                   	leave  
  802349:	c3                   	ret    

0080234a <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80234a:	55                   	push   %ebp
  80234b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	ff 75 10             	pushl  0x10(%ebp)
  802354:	ff 75 0c             	pushl  0xc(%ebp)
  802357:	ff 75 08             	pushl  0x8(%ebp)
  80235a:	6a 12                	push   $0x12
  80235c:	e8 1f fb ff ff       	call   801e80 <syscall>
  802361:	83 c4 18             	add    $0x18,%esp
	return ;
  802364:	90                   	nop
}
  802365:	c9                   	leave  
  802366:	c3                   	ret    

00802367 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  802367:	55                   	push   %ebp
  802368:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80236a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80236d:	8b 45 08             	mov    0x8(%ebp),%eax
  802370:	6a 00                	push   $0x0
  802372:	6a 00                	push   $0x0
  802374:	6a 00                	push   $0x0
  802376:	52                   	push   %edx
  802377:	50                   	push   %eax
  802378:	6a 2a                	push   $0x2a
  80237a:	e8 01 fb ff ff       	call   801e80 <syscall>
  80237f:	83 c4 18             	add    $0x18,%esp
	return;
  802382:	90                   	nop
}
  802383:	c9                   	leave  
  802384:	c3                   	ret    

00802385 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802385:	55                   	push   %ebp
  802386:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  802388:	6a 00                	push   $0x0
  80238a:	6a 00                	push   $0x0
  80238c:	6a 00                	push   $0x0
  80238e:	6a 00                	push   $0x0
  802390:	6a 00                	push   $0x0
  802392:	6a 2b                	push   $0x2b
  802394:	e8 e7 fa ff ff       	call   801e80 <syscall>
  802399:	83 c4 18             	add    $0x18,%esp
}
  80239c:	c9                   	leave  
  80239d:	c3                   	ret    

0080239e <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80239e:	55                   	push   %ebp
  80239f:	89 e5                	mov    %esp,%ebp
  8023a1:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8023a4:	83 ec 04             	sub    $0x4,%esp
  8023a7:	68 6c 31 80 00       	push   $0x80316c
  8023ac:	68 0a 01 00 00       	push   $0x10a
  8023b1:	68 7c 31 80 00       	push   $0x80317c
  8023b6:	e8 e2 e5 ff ff       	call   80099d <_panic>

008023bb <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8023bb:	55                   	push   %ebp
  8023bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	ff 75 0c             	pushl  0xc(%ebp)
  8023c7:	ff 75 08             	pushl  0x8(%ebp)
  8023ca:	6a 33                	push   $0x33
  8023cc:	e8 af fa ff ff       	call   801e80 <syscall>
  8023d1:	83 c4 18             	add    $0x18,%esp
	return;
  8023d4:	90                   	nop
}
  8023d5:	c9                   	leave  
  8023d6:	c3                   	ret    

008023d7 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8023d7:	55                   	push   %ebp
  8023d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8023da:	6a 00                	push   $0x0
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	ff 75 0c             	pushl  0xc(%ebp)
  8023e3:	ff 75 08             	pushl  0x8(%ebp)
  8023e6:	6a 34                	push   $0x34
  8023e8:	e8 93 fa ff ff       	call   801e80 <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8023f0:	90                   	nop
}
  8023f1:	c9                   	leave  
  8023f2:	c3                   	ret    

008023f3 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8023f3:	55                   	push   %ebp
  8023f4:	89 e5                	mov    %esp,%ebp
  8023f6:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8023f9:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  802400:	eb 36                	jmp    802438 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  802402:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802405:	c1 e0 04             	shl    $0x4,%eax
  802408:	05 60 40 80 00       	add    $0x804060,%eax
  80240d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802413:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802416:	c1 e0 04             	shl    $0x4,%eax
  802419:	05 64 40 80 00       	add    $0x804064,%eax
  80241e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802424:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802427:	c1 e0 04             	shl    $0x4,%eax
  80242a:	05 6c 40 80 00       	add    $0x80406c,%eax
  80242f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802435:	ff 45 fc             	incl   -0x4(%ebp)
  802438:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  80243c:	7e c4                	jle    802402 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  80243e:	90                   	nop
  80243f:	c9                   	leave  
  802440:	c3                   	ret    

00802441 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802441:	55                   	push   %ebp
  802442:	89 e5                	mov    %esp,%ebp
  802444:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802447:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  80244e:	eb 24                	jmp    802474 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  802450:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802453:	c1 e0 04             	shl    $0x4,%eax
  802456:	05 6c 40 80 00       	add    $0x80406c,%eax
  80245b:	8b 00                	mov    (%eax),%eax
  80245d:	83 ec 04             	sub    $0x4,%esp
  802460:	50                   	push   %eax
  802461:	ff 75 f4             	pushl  -0xc(%ebp)
  802464:	68 8c 31 80 00       	push   $0x80318c
  802469:	e8 fd e7 ff ff       	call   800c6b <cprintf>
  80246e:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802471:	ff 45 f4             	incl   -0xc(%ebp)
  802474:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  802478:	7e d6                	jle    802450 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  80247a:	90                   	nop
  80247b:	c9                   	leave  
  80247c:	c3                   	ret    

0080247d <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  80247d:	55                   	push   %ebp
  80247e:	89 e5                	mov    %esp,%ebp
  802480:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  802483:	83 ec 04             	sub    $0x4,%esp
  802486:	68 9c 31 80 00       	push   $0x80319c
  80248b:	6a 33                	push   $0x33
  80248d:	68 bd 31 80 00       	push   $0x8031bd
  802492:	e8 06 e5 ff ff       	call   80099d <_panic>

00802497 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  802497:	55                   	push   %ebp
  802498:	89 e5                	mov    %esp,%ebp
  80249a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  80249d:	83 ec 04             	sub    $0x4,%esp
  8024a0:	68 d5 31 80 00       	push   $0x8031d5
  8024a5:	6a 3e                	push   $0x3e
  8024a7:	68 bd 31 80 00       	push   $0x8031bd
  8024ac:	e8 ec e4 ff ff       	call   80099d <_panic>

008024b1 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8024b1:	55                   	push   %ebp
  8024b2:	89 e5                	mov    %esp,%ebp
  8024b4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  8024b7:	83 ec 04             	sub    $0x4,%esp
  8024ba:	68 f3 31 80 00       	push   $0x8031f3
  8024bf:	6a 49                	push   $0x49
  8024c1:	68 bd 31 80 00       	push   $0x8031bd
  8024c6:	e8 d2 e4 ff ff       	call   80099d <_panic>

008024cb <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  8024cb:	55                   	push   %ebp
  8024cc:	89 e5                	mov    %esp,%ebp
  8024ce:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  8024d1:	83 ec 04             	sub    $0x4,%esp
  8024d4:	68 10 32 80 00       	push   $0x803210
  8024d9:	6a 58                	push   $0x58
  8024db:	68 bd 31 80 00       	push   $0x8031bd
  8024e0:	e8 b8 e4 ff ff       	call   80099d <_panic>
  8024e5:	66 90                	xchg   %ax,%ax
  8024e7:	90                   	nop

008024e8 <__udivdi3>:
  8024e8:	55                   	push   %ebp
  8024e9:	57                   	push   %edi
  8024ea:	56                   	push   %esi
  8024eb:	53                   	push   %ebx
  8024ec:	83 ec 1c             	sub    $0x1c,%esp
  8024ef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024f3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024fb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024ff:	89 ca                	mov    %ecx,%edx
  802501:	89 f8                	mov    %edi,%eax
  802503:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802507:	85 f6                	test   %esi,%esi
  802509:	75 2d                	jne    802538 <__udivdi3+0x50>
  80250b:	39 cf                	cmp    %ecx,%edi
  80250d:	77 65                	ja     802574 <__udivdi3+0x8c>
  80250f:	89 fd                	mov    %edi,%ebp
  802511:	85 ff                	test   %edi,%edi
  802513:	75 0b                	jne    802520 <__udivdi3+0x38>
  802515:	b8 01 00 00 00       	mov    $0x1,%eax
  80251a:	31 d2                	xor    %edx,%edx
  80251c:	f7 f7                	div    %edi
  80251e:	89 c5                	mov    %eax,%ebp
  802520:	31 d2                	xor    %edx,%edx
  802522:	89 c8                	mov    %ecx,%eax
  802524:	f7 f5                	div    %ebp
  802526:	89 c1                	mov    %eax,%ecx
  802528:	89 d8                	mov    %ebx,%eax
  80252a:	f7 f5                	div    %ebp
  80252c:	89 cf                	mov    %ecx,%edi
  80252e:	89 fa                	mov    %edi,%edx
  802530:	83 c4 1c             	add    $0x1c,%esp
  802533:	5b                   	pop    %ebx
  802534:	5e                   	pop    %esi
  802535:	5f                   	pop    %edi
  802536:	5d                   	pop    %ebp
  802537:	c3                   	ret    
  802538:	39 ce                	cmp    %ecx,%esi
  80253a:	77 28                	ja     802564 <__udivdi3+0x7c>
  80253c:	0f bd fe             	bsr    %esi,%edi
  80253f:	83 f7 1f             	xor    $0x1f,%edi
  802542:	75 40                	jne    802584 <__udivdi3+0x9c>
  802544:	39 ce                	cmp    %ecx,%esi
  802546:	72 0a                	jb     802552 <__udivdi3+0x6a>
  802548:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80254c:	0f 87 9e 00 00 00    	ja     8025f0 <__udivdi3+0x108>
  802552:	b8 01 00 00 00       	mov    $0x1,%eax
  802557:	89 fa                	mov    %edi,%edx
  802559:	83 c4 1c             	add    $0x1c,%esp
  80255c:	5b                   	pop    %ebx
  80255d:	5e                   	pop    %esi
  80255e:	5f                   	pop    %edi
  80255f:	5d                   	pop    %ebp
  802560:	c3                   	ret    
  802561:	8d 76 00             	lea    0x0(%esi),%esi
  802564:	31 ff                	xor    %edi,%edi
  802566:	31 c0                	xor    %eax,%eax
  802568:	89 fa                	mov    %edi,%edx
  80256a:	83 c4 1c             	add    $0x1c,%esp
  80256d:	5b                   	pop    %ebx
  80256e:	5e                   	pop    %esi
  80256f:	5f                   	pop    %edi
  802570:	5d                   	pop    %ebp
  802571:	c3                   	ret    
  802572:	66 90                	xchg   %ax,%ax
  802574:	89 d8                	mov    %ebx,%eax
  802576:	f7 f7                	div    %edi
  802578:	31 ff                	xor    %edi,%edi
  80257a:	89 fa                	mov    %edi,%edx
  80257c:	83 c4 1c             	add    $0x1c,%esp
  80257f:	5b                   	pop    %ebx
  802580:	5e                   	pop    %esi
  802581:	5f                   	pop    %edi
  802582:	5d                   	pop    %ebp
  802583:	c3                   	ret    
  802584:	bd 20 00 00 00       	mov    $0x20,%ebp
  802589:	89 eb                	mov    %ebp,%ebx
  80258b:	29 fb                	sub    %edi,%ebx
  80258d:	89 f9                	mov    %edi,%ecx
  80258f:	d3 e6                	shl    %cl,%esi
  802591:	89 c5                	mov    %eax,%ebp
  802593:	88 d9                	mov    %bl,%cl
  802595:	d3 ed                	shr    %cl,%ebp
  802597:	89 e9                	mov    %ebp,%ecx
  802599:	09 f1                	or     %esi,%ecx
  80259b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80259f:	89 f9                	mov    %edi,%ecx
  8025a1:	d3 e0                	shl    %cl,%eax
  8025a3:	89 c5                	mov    %eax,%ebp
  8025a5:	89 d6                	mov    %edx,%esi
  8025a7:	88 d9                	mov    %bl,%cl
  8025a9:	d3 ee                	shr    %cl,%esi
  8025ab:	89 f9                	mov    %edi,%ecx
  8025ad:	d3 e2                	shl    %cl,%edx
  8025af:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025b3:	88 d9                	mov    %bl,%cl
  8025b5:	d3 e8                	shr    %cl,%eax
  8025b7:	09 c2                	or     %eax,%edx
  8025b9:	89 d0                	mov    %edx,%eax
  8025bb:	89 f2                	mov    %esi,%edx
  8025bd:	f7 74 24 0c          	divl   0xc(%esp)
  8025c1:	89 d6                	mov    %edx,%esi
  8025c3:	89 c3                	mov    %eax,%ebx
  8025c5:	f7 e5                	mul    %ebp
  8025c7:	39 d6                	cmp    %edx,%esi
  8025c9:	72 19                	jb     8025e4 <__udivdi3+0xfc>
  8025cb:	74 0b                	je     8025d8 <__udivdi3+0xf0>
  8025cd:	89 d8                	mov    %ebx,%eax
  8025cf:	31 ff                	xor    %edi,%edi
  8025d1:	e9 58 ff ff ff       	jmp    80252e <__udivdi3+0x46>
  8025d6:	66 90                	xchg   %ax,%ax
  8025d8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025dc:	89 f9                	mov    %edi,%ecx
  8025de:	d3 e2                	shl    %cl,%edx
  8025e0:	39 c2                	cmp    %eax,%edx
  8025e2:	73 e9                	jae    8025cd <__udivdi3+0xe5>
  8025e4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025e7:	31 ff                	xor    %edi,%edi
  8025e9:	e9 40 ff ff ff       	jmp    80252e <__udivdi3+0x46>
  8025ee:	66 90                	xchg   %ax,%ax
  8025f0:	31 c0                	xor    %eax,%eax
  8025f2:	e9 37 ff ff ff       	jmp    80252e <__udivdi3+0x46>
  8025f7:	90                   	nop

008025f8 <__umoddi3>:
  8025f8:	55                   	push   %ebp
  8025f9:	57                   	push   %edi
  8025fa:	56                   	push   %esi
  8025fb:	53                   	push   %ebx
  8025fc:	83 ec 1c             	sub    $0x1c,%esp
  8025ff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802603:	8b 74 24 34          	mov    0x34(%esp),%esi
  802607:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80260b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80260f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802613:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802617:	89 f3                	mov    %esi,%ebx
  802619:	89 fa                	mov    %edi,%edx
  80261b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80261f:	89 34 24             	mov    %esi,(%esp)
  802622:	85 c0                	test   %eax,%eax
  802624:	75 1a                	jne    802640 <__umoddi3+0x48>
  802626:	39 f7                	cmp    %esi,%edi
  802628:	0f 86 a2 00 00 00    	jbe    8026d0 <__umoddi3+0xd8>
  80262e:	89 c8                	mov    %ecx,%eax
  802630:	89 f2                	mov    %esi,%edx
  802632:	f7 f7                	div    %edi
  802634:	89 d0                	mov    %edx,%eax
  802636:	31 d2                	xor    %edx,%edx
  802638:	83 c4 1c             	add    $0x1c,%esp
  80263b:	5b                   	pop    %ebx
  80263c:	5e                   	pop    %esi
  80263d:	5f                   	pop    %edi
  80263e:	5d                   	pop    %ebp
  80263f:	c3                   	ret    
  802640:	39 f0                	cmp    %esi,%eax
  802642:	0f 87 ac 00 00 00    	ja     8026f4 <__umoddi3+0xfc>
  802648:	0f bd e8             	bsr    %eax,%ebp
  80264b:	83 f5 1f             	xor    $0x1f,%ebp
  80264e:	0f 84 ac 00 00 00    	je     802700 <__umoddi3+0x108>
  802654:	bf 20 00 00 00       	mov    $0x20,%edi
  802659:	29 ef                	sub    %ebp,%edi
  80265b:	89 fe                	mov    %edi,%esi
  80265d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802661:	89 e9                	mov    %ebp,%ecx
  802663:	d3 e0                	shl    %cl,%eax
  802665:	89 d7                	mov    %edx,%edi
  802667:	89 f1                	mov    %esi,%ecx
  802669:	d3 ef                	shr    %cl,%edi
  80266b:	09 c7                	or     %eax,%edi
  80266d:	89 e9                	mov    %ebp,%ecx
  80266f:	d3 e2                	shl    %cl,%edx
  802671:	89 14 24             	mov    %edx,(%esp)
  802674:	89 d8                	mov    %ebx,%eax
  802676:	d3 e0                	shl    %cl,%eax
  802678:	89 c2                	mov    %eax,%edx
  80267a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80267e:	d3 e0                	shl    %cl,%eax
  802680:	89 44 24 04          	mov    %eax,0x4(%esp)
  802684:	8b 44 24 08          	mov    0x8(%esp),%eax
  802688:	89 f1                	mov    %esi,%ecx
  80268a:	d3 e8                	shr    %cl,%eax
  80268c:	09 d0                	or     %edx,%eax
  80268e:	d3 eb                	shr    %cl,%ebx
  802690:	89 da                	mov    %ebx,%edx
  802692:	f7 f7                	div    %edi
  802694:	89 d3                	mov    %edx,%ebx
  802696:	f7 24 24             	mull   (%esp)
  802699:	89 c6                	mov    %eax,%esi
  80269b:	89 d1                	mov    %edx,%ecx
  80269d:	39 d3                	cmp    %edx,%ebx
  80269f:	0f 82 87 00 00 00    	jb     80272c <__umoddi3+0x134>
  8026a5:	0f 84 91 00 00 00    	je     80273c <__umoddi3+0x144>
  8026ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  8026af:	29 f2                	sub    %esi,%edx
  8026b1:	19 cb                	sbb    %ecx,%ebx
  8026b3:	89 d8                	mov    %ebx,%eax
  8026b5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026b9:	d3 e0                	shl    %cl,%eax
  8026bb:	89 e9                	mov    %ebp,%ecx
  8026bd:	d3 ea                	shr    %cl,%edx
  8026bf:	09 d0                	or     %edx,%eax
  8026c1:	89 e9                	mov    %ebp,%ecx
  8026c3:	d3 eb                	shr    %cl,%ebx
  8026c5:	89 da                	mov    %ebx,%edx
  8026c7:	83 c4 1c             	add    $0x1c,%esp
  8026ca:	5b                   	pop    %ebx
  8026cb:	5e                   	pop    %esi
  8026cc:	5f                   	pop    %edi
  8026cd:	5d                   	pop    %ebp
  8026ce:	c3                   	ret    
  8026cf:	90                   	nop
  8026d0:	89 fd                	mov    %edi,%ebp
  8026d2:	85 ff                	test   %edi,%edi
  8026d4:	75 0b                	jne    8026e1 <__umoddi3+0xe9>
  8026d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026db:	31 d2                	xor    %edx,%edx
  8026dd:	f7 f7                	div    %edi
  8026df:	89 c5                	mov    %eax,%ebp
  8026e1:	89 f0                	mov    %esi,%eax
  8026e3:	31 d2                	xor    %edx,%edx
  8026e5:	f7 f5                	div    %ebp
  8026e7:	89 c8                	mov    %ecx,%eax
  8026e9:	f7 f5                	div    %ebp
  8026eb:	89 d0                	mov    %edx,%eax
  8026ed:	e9 44 ff ff ff       	jmp    802636 <__umoddi3+0x3e>
  8026f2:	66 90                	xchg   %ax,%ax
  8026f4:	89 c8                	mov    %ecx,%eax
  8026f6:	89 f2                	mov    %esi,%edx
  8026f8:	83 c4 1c             	add    $0x1c,%esp
  8026fb:	5b                   	pop    %ebx
  8026fc:	5e                   	pop    %esi
  8026fd:	5f                   	pop    %edi
  8026fe:	5d                   	pop    %ebp
  8026ff:	c3                   	ret    
  802700:	3b 04 24             	cmp    (%esp),%eax
  802703:	72 06                	jb     80270b <__umoddi3+0x113>
  802705:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802709:	77 0f                	ja     80271a <__umoddi3+0x122>
  80270b:	89 f2                	mov    %esi,%edx
  80270d:	29 f9                	sub    %edi,%ecx
  80270f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802713:	89 14 24             	mov    %edx,(%esp)
  802716:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80271a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80271e:	8b 14 24             	mov    (%esp),%edx
  802721:	83 c4 1c             	add    $0x1c,%esp
  802724:	5b                   	pop    %ebx
  802725:	5e                   	pop    %esi
  802726:	5f                   	pop    %edi
  802727:	5d                   	pop    %ebp
  802728:	c3                   	ret    
  802729:	8d 76 00             	lea    0x0(%esi),%esi
  80272c:	2b 04 24             	sub    (%esp),%eax
  80272f:	19 fa                	sbb    %edi,%edx
  802731:	89 d1                	mov    %edx,%ecx
  802733:	89 c6                	mov    %eax,%esi
  802735:	e9 71 ff ff ff       	jmp    8026ab <__umoddi3+0xb3>
  80273a:	66 90                	xchg   %ax,%ax
  80273c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802740:	72 ea                	jb     80272c <__umoddi3+0x134>
  802742:	89 d9                	mov    %ebx,%ecx
  802744:	e9 62 ff ff ff       	jmp    8026ab <__umoddi3+0xb3>
