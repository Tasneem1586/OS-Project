
obj/user/sc_ms_static:     file format elf32-i386


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
  800031:	e8 db 06 00 00       	call   800711 <libmain>
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
  80004b:	e8 43 1b 00 00       	call   801b93 <sys_lock_cons>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 00 23 80 00       	push   $0x802300
  800058:	e8 e2 0b 00 00       	call   800c3f <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 02 23 80 00       	push   $0x802302
  800068:	e8 d2 0b 00 00       	call   800c3f <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 18 23 80 00       	push   $0x802318
  800078:	e8 c2 0b 00 00       	call   800c3f <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 02 23 80 00       	push   $0x802302
  800088:	e8 b2 0b 00 00       	call   800c3f <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 00 23 80 00       	push   $0x802300
  800098:	e8 a2 0b 00 00       	call   800c3f <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 50000;
  8000a0:	c7 45 ec 50 c3 00 00 	movl   $0xc350,-0x14(%ebp)
		cprintf("Enter the number of elements: %d\n", NumOfElements) ;
  8000a7:	83 ec 08             	sub    $0x8,%esp
  8000aa:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ad:	68 30 23 80 00       	push   $0x802330
  8000b2:	e8 88 0b 00 00       	call   800c3f <cprintf>
  8000b7:	83 c4 10             	add    $0x10,%esp

		cprintf("Chose the initialization method:\n") ;
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	68 54 23 80 00       	push   $0x802354
  8000c2:	e8 78 0b 00 00       	call   800c3f <cprintf>
  8000c7:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000ca:	83 ec 0c             	sub    $0xc,%esp
  8000cd:	68 76 23 80 00       	push   $0x802376
  8000d2:	e8 68 0b 00 00       	call   800c3f <cprintf>
  8000d7:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000da:	83 ec 0c             	sub    $0xc,%esp
  8000dd:	68 84 23 80 00       	push   $0x802384
  8000e2:	e8 58 0b 00 00       	call   800c3f <cprintf>
  8000e7:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000ea:	83 ec 0c             	sub    $0xc,%esp
  8000ed:	68 93 23 80 00       	push   $0x802393
  8000f2:	e8 48 0b 00 00       	call   800c3f <cprintf>
  8000f7:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	68 a3 23 80 00       	push   $0x8023a3
  800102:	e8 38 0b 00 00       	call   800c3f <cprintf>
  800107:	83 c4 10             	add    $0x10,%esp
			Chose = 'c' ;
  80010a:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80010e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	50                   	push   %eax
  800116:	e8 b4 05 00 00       	call   8006cf <cputchar>
  80011b:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	6a 0a                	push   $0xa
  800123:	e8 a7 05 00 00       	call   8006cf <cputchar>
  800128:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80012b:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80012f:	74 0c                	je     80013d <_main+0x105>
  800131:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800135:	74 06                	je     80013d <_main+0x105>
  800137:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80013b:	75 bd                	jne    8000fa <_main+0xc2>

		//2012: lock the interrupt
		sys_unlock_cons();
  80013d:	e8 6b 1a 00 00       	call   801bad <sys_unlock_cons>

		//int *Elements = malloc(sizeof(int) * NumOfElements) ;
		int *Elements = __Elements;
  800142:	c7 45 e8 40 c1 50 04 	movl   $0x450c140,-0x18(%ebp)
		int  i ;
		switch (Chose)
  800149:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80014d:	83 f8 62             	cmp    $0x62,%eax
  800150:	74 1d                	je     80016f <_main+0x137>
  800152:	83 f8 63             	cmp    $0x63,%eax
  800155:	74 2b                	je     800182 <_main+0x14a>
  800157:	83 f8 61             	cmp    $0x61,%eax
  80015a:	75 39                	jne    800195 <_main+0x15d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80015c:	83 ec 08             	sub    $0x8,%esp
  80015f:	ff 75 ec             	pushl  -0x14(%ebp)
  800162:	ff 75 e8             	pushl  -0x18(%ebp)
  800165:	e8 e7 01 00 00       	call   800351 <InitializeAscending>
  80016a:	83 c4 10             	add    $0x10,%esp
			break ;
  80016d:	eb 37                	jmp    8001a6 <_main+0x16e>
		case 'b':
			InitializeIdentical(Elements, NumOfElements);
  80016f:	83 ec 08             	sub    $0x8,%esp
  800172:	ff 75 ec             	pushl  -0x14(%ebp)
  800175:	ff 75 e8             	pushl  -0x18(%ebp)
  800178:	e8 05 02 00 00       	call   800382 <InitializeIdentical>
  80017d:	83 c4 10             	add    $0x10,%esp
			break ;
  800180:	eb 24                	jmp    8001a6 <_main+0x16e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800182:	83 ec 08             	sub    $0x8,%esp
  800185:	ff 75 ec             	pushl  -0x14(%ebp)
  800188:	ff 75 e8             	pushl  -0x18(%ebp)
  80018b:	e8 27 02 00 00       	call   8003b7 <InitializeSemiRandom>
  800190:	83 c4 10             	add    $0x10,%esp
			break ;
  800193:	eb 11                	jmp    8001a6 <_main+0x16e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800195:	83 ec 08             	sub    $0x8,%esp
  800198:	ff 75 ec             	pushl  -0x14(%ebp)
  80019b:	ff 75 e8             	pushl  -0x18(%ebp)
  80019e:	e8 14 02 00 00       	call   8003b7 <InitializeSemiRandom>
  8001a3:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ac:	6a 01                	push   $0x1
  8001ae:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b1:	e8 e0 02 00 00       	call   800496 <MSort>
  8001b6:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001b9:	e8 d5 19 00 00       	call   801b93 <sys_lock_cons>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001be:	83 ec 0c             	sub    $0xc,%esp
  8001c1:	68 ac 23 80 00       	push   $0x8023ac
  8001c6:	e8 74 0a 00 00       	call   800c3f <cprintf>
  8001cb:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_unlock_cons();
  8001ce:	e8 da 19 00 00       	call   801bad <sys_unlock_cons>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d3:	83 ec 08             	sub    $0x8,%esp
  8001d6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d9:	ff 75 e8             	pushl  -0x18(%ebp)
  8001dc:	e8 c6 00 00 00       	call   8002a7 <CheckSorted>
  8001e1:	83 c4 10             	add    $0x10,%esp
  8001e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8001eb:	75 14                	jne    800201 <_main+0x1c9>
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 e0 23 80 00       	push   $0x8023e0
  8001f5:	6a 51                	push   $0x51
  8001f7:	68 02 24 80 00       	push   $0x802402
  8001fc:	e8 70 07 00 00       	call   800971 <_panic>
		else
		{
			sys_lock_cons();
  800201:	e8 8d 19 00 00       	call   801b93 <sys_lock_cons>
			cprintf("===============================================\n") ;
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 18 24 80 00       	push   $0x802418
  80020e:	e8 2c 0a 00 00       	call   800c3f <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	68 4c 24 80 00       	push   $0x80244c
  80021e:	e8 1c 0a 00 00       	call   800c3f <cprintf>
  800223:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800226:	83 ec 0c             	sub    $0xc,%esp
  800229:	68 80 24 80 00       	push   $0x802480
  80022e:	e8 0c 0a 00 00       	call   800c3f <cprintf>
  800233:	83 c4 10             	add    $0x10,%esp
			sys_unlock_cons();
  800236:	e8 72 19 00 00       	call   801bad <sys_unlock_cons>
		}

		//free(Elements) ;

		sys_lock_cons();
  80023b:	e8 53 19 00 00       	call   801b93 <sys_lock_cons>
		Chose = 0 ;
  800240:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800244:	eb 3e                	jmp    800284 <_main+0x24c>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 b2 24 80 00       	push   $0x8024b2
  80024e:	e8 ec 09 00 00       	call   800c3f <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp
			Chose = 'n' ;
  800256:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  80025a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	50                   	push   %eax
  800262:	e8 68 04 00 00       	call   8006cf <cputchar>
  800267:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	6a 0a                	push   $0xa
  80026f:	e8 5b 04 00 00       	call   8006cf <cputchar>
  800274:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800277:	83 ec 0c             	sub    $0xc,%esp
  80027a:	6a 0a                	push   $0xa
  80027c:	e8 4e 04 00 00       	call   8006cf <cputchar>
  800281:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_lock_cons();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800284:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800288:	74 06                	je     800290 <_main+0x258>
  80028a:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80028e:	75 b6                	jne    800246 <_main+0x20e>
			Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_unlock_cons();
  800290:	e8 18 19 00 00       	call   801bad <sys_unlock_cons>

	} while (Chose == 'y');
  800295:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800299:	0f 84 a9 fd ff ff    	je     800048 <_main+0x10>

	//To indicate that it's completed successfully
	inctst();
  80029f:	e8 6f 1c 00 00       	call   801f13 <inctst>

}
  8002a4:	90                   	nop
  8002a5:	c9                   	leave  
  8002a6:	c3                   	ret    

008002a7 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002a7:	55                   	push   %ebp
  8002a8:	89 e5                	mov    %esp,%ebp
  8002aa:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002bb:	eb 33                	jmp    8002f0 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ca:	01 d0                	add    %edx,%eax
  8002cc:	8b 10                	mov    (%eax),%edx
  8002ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002d1:	40                   	inc    %eax
  8002d2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002dc:	01 c8                	add    %ecx,%eax
  8002de:	8b 00                	mov    (%eax),%eax
  8002e0:	39 c2                	cmp    %eax,%edx
  8002e2:	7e 09                	jle    8002ed <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8002e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8002eb:	eb 0c                	jmp    8002f9 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002ed:	ff 45 f8             	incl   -0x8(%ebp)
  8002f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f3:	48                   	dec    %eax
  8002f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8002f7:	7f c4                	jg     8002bd <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8002f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8002fc:	c9                   	leave  
  8002fd:	c3                   	ret    

008002fe <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8002fe:	55                   	push   %ebp
  8002ff:	89 e5                	mov    %esp,%ebp
  800301:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800304:	8b 45 0c             	mov    0xc(%ebp),%eax
  800307:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030e:	8b 45 08             	mov    0x8(%ebp),%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	8b 00                	mov    (%eax),%eax
  800315:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800318:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800322:	8b 45 08             	mov    0x8(%ebp),%eax
  800325:	01 c2                	add    %eax,%edx
  800327:	8b 45 10             	mov    0x10(%ebp),%eax
  80032a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800331:	8b 45 08             	mov    0x8(%ebp),%eax
  800334:	01 c8                	add    %ecx,%eax
  800336:	8b 00                	mov    (%eax),%eax
  800338:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80033a:	8b 45 10             	mov    0x10(%ebp),%eax
  80033d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800344:	8b 45 08             	mov    0x8(%ebp),%eax
  800347:	01 c2                	add    %eax,%edx
  800349:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80034c:	89 02                	mov    %eax,(%edx)
}
  80034e:	90                   	nop
  80034f:	c9                   	leave  
  800350:	c3                   	ret    

00800351 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800351:	55                   	push   %ebp
  800352:	89 e5                	mov    %esp,%ebp
  800354:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800357:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80035e:	eb 17                	jmp    800377 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800360:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800363:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036a:	8b 45 08             	mov    0x8(%ebp),%eax
  80036d:	01 c2                	add    %eax,%edx
  80036f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800372:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	ff 45 fc             	incl   -0x4(%ebp)
  800377:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80037a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80037d:	7c e1                	jl     800360 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80037f:	90                   	nop
  800380:	c9                   	leave  
  800381:	c3                   	ret    

00800382 <InitializeIdentical>:

void InitializeIdentical(int *Elements, int NumOfElements)
{
  800382:	55                   	push   %ebp
  800383:	89 e5                	mov    %esp,%ebp
  800385:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80038f:	eb 1b                	jmp    8003ac <InitializeIdentical+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800391:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800394:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039b:	8b 45 08             	mov    0x8(%ebp),%eax
  80039e:	01 c2                	add    %eax,%edx
  8003a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a3:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003a6:	48                   	dec    %eax
  8003a7:	89 02                	mov    %eax,(%edx)
}

void InitializeIdentical(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a9:	ff 45 fc             	incl   -0x4(%ebp)
  8003ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003af:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003b2:	7c dd                	jl     800391 <InitializeIdentical+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003b4:	90                   	nop
  8003b5:	c9                   	leave  
  8003b6:	c3                   	ret    

008003b7 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003b7:	55                   	push   %ebp
  8003b8:	89 e5                	mov    %esp,%ebp
  8003ba:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003c0:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003c5:	f7 e9                	imul   %ecx
  8003c7:	c1 f9 1f             	sar    $0x1f,%ecx
  8003ca:	89 d0                	mov    %edx,%eax
  8003cc:	29 c8                	sub    %ecx,%eax
  8003ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (Repetition == 0)
  8003d1:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8003d5:	75 07                	jne    8003de <InitializeSemiRandom+0x27>
			Repetition = 3;
  8003d7:	c7 45 f8 03 00 00 00 	movl   $0x3,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003e5:	eb 1e                	jmp    800405 <InitializeSemiRandom+0x4e>
	{
		Elements[i] = i % Repetition ;
  8003e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	99                   	cltd   
  8003fb:	f7 7d f8             	idivl  -0x8(%ebp)
  8003fe:	89 d0                	mov    %edx,%eax
  800400:	89 01                	mov    %eax,(%ecx)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	if (Repetition == 0)
			Repetition = 3;
	for (i = 0 ; i < NumOfElements ; i++)
  800402:	ff 45 fc             	incl   -0x4(%ebp)
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80040b:	7c da                	jl     8003e7 <InitializeSemiRandom+0x30>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80040d:	90                   	nop
  80040e:	c9                   	leave  
  80040f:	c3                   	ret    

00800410 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800410:	55                   	push   %ebp
  800411:	89 e5                	mov    %esp,%ebp
  800413:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800416:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80041d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800424:	eb 42                	jmp    800468 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800426:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800429:	99                   	cltd   
  80042a:	f7 7d f0             	idivl  -0x10(%ebp)
  80042d:	89 d0                	mov    %edx,%eax
  80042f:	85 c0                	test   %eax,%eax
  800431:	75 10                	jne    800443 <PrintElements+0x33>
			cprintf("\n");
  800433:	83 ec 0c             	sub    $0xc,%esp
  800436:	68 00 23 80 00       	push   $0x802300
  80043b:	e8 ff 07 00 00       	call   800c3f <cprintf>
  800440:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800443:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800446:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	01 d0                	add    %edx,%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	83 ec 08             	sub    $0x8,%esp
  800457:	50                   	push   %eax
  800458:	68 d0 24 80 00       	push   $0x8024d0
  80045d:	e8 dd 07 00 00       	call   800c3f <cprintf>
  800462:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800465:	ff 45 f4             	incl   -0xc(%ebp)
  800468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046b:	48                   	dec    %eax
  80046c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80046f:	7f b5                	jg     800426 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800471:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800474:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	01 d0                	add    %edx,%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	83 ec 08             	sub    $0x8,%esp
  800485:	50                   	push   %eax
  800486:	68 d5 24 80 00       	push   $0x8024d5
  80048b:	e8 af 07 00 00       	call   800c3f <cprintf>
  800490:	83 c4 10             	add    $0x10,%esp

}
  800493:	90                   	nop
  800494:	c9                   	leave  
  800495:	c3                   	ret    

00800496 <MSort>:


void MSort(int* A, int p, int r)
{
  800496:	55                   	push   %ebp
  800497:	89 e5                	mov    %esp,%ebp
  800499:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  80049c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049f:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004a2:	7d 54                	jge    8004f8 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004aa:	01 d0                	add    %edx,%eax
  8004ac:	89 c2                	mov    %eax,%edx
  8004ae:	c1 ea 1f             	shr    $0x1f,%edx
  8004b1:	01 d0                	add    %edx,%eax
  8004b3:	d1 f8                	sar    %eax
  8004b5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004b8:	83 ec 04             	sub    $0x4,%esp
  8004bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004be:	ff 75 0c             	pushl  0xc(%ebp)
  8004c1:	ff 75 08             	pushl  0x8(%ebp)
  8004c4:	e8 cd ff ff ff       	call   800496 <MSort>
  8004c9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004cf:	40                   	inc    %eax
  8004d0:	83 ec 04             	sub    $0x4,%esp
  8004d3:	ff 75 10             	pushl  0x10(%ebp)
  8004d6:	50                   	push   %eax
  8004d7:	ff 75 08             	pushl  0x8(%ebp)
  8004da:	e8 b7 ff ff ff       	call   800496 <MSort>
  8004df:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004e2:	ff 75 10             	pushl  0x10(%ebp)
  8004e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004e8:	ff 75 0c             	pushl  0xc(%ebp)
  8004eb:	ff 75 08             	pushl  0x8(%ebp)
  8004ee:	e8 08 00 00 00       	call   8004fb <Merge>
  8004f3:	83 c4 10             	add    $0x10,%esp
  8004f6:	eb 01                	jmp    8004f9 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  8004f8:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  8004f9:	c9                   	leave  
  8004fa:	c3                   	ret    

008004fb <Merge>:

void Merge(int* A, int p, int q, int r)
{
  8004fb:	55                   	push   %ebp
  8004fc:	89 e5                	mov    %esp,%ebp
  8004fe:	83 ec 30             	sub    $0x30,%esp
	int leftCapacity = q - p + 1;
  800501:	8b 45 10             	mov    0x10(%ebp),%eax
  800504:	2b 45 0c             	sub    0xc(%ebp),%eax
  800507:	40                   	inc    %eax
  800508:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int rightCapacity = r - q;
  80050b:	8b 45 14             	mov    0x14(%ebp),%eax
  80050e:	2b 45 10             	sub    0x10(%ebp),%eax
  800511:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	int leftIndex = 0;
  800514:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

	int rightIndex = 0;
  80051b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	//int* Left = malloc(sizeof(int) * leftCapacity);
	int* Left = __Left ;
  800522:	c7 45 e0 40 30 80 00 	movl   $0x803040,-0x20(%ebp)
	int* Right = __Right;
  800529:	c7 45 dc 40 51 21 08 	movl   $0x8215140,-0x24(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800530:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800537:	eb 2f                	jmp    800568 <Merge+0x6d>
	{
		Left[i] = A[p + i - 1];
  800539:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80053c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800543:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800546:	01 c2                	add    %eax,%edx
  800548:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80054b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80054e:	01 c8                	add    %ecx,%eax
  800550:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800555:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80055c:	8b 45 08             	mov    0x8(%ebp),%eax
  80055f:	01 c8                	add    %ecx,%eax
  800561:	8b 00                	mov    (%eax),%eax
  800563:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800565:	ff 45 f4             	incl   -0xc(%ebp)
  800568:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80056e:	7c c9                	jl     800539 <Merge+0x3e>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800570:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800577:	eb 2a                	jmp    8005a3 <Merge+0xa8>
	{
		Right[j] = A[q + j];
  800579:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80057c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800583:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800586:	01 c2                	add    %eax,%edx
  800588:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80058b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058e:	01 c8                	add    %ecx,%eax
  800590:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800597:	8b 45 08             	mov    0x8(%ebp),%eax
  80059a:	01 c8                	add    %ecx,%eax
  80059c:	8b 00                	mov    (%eax),%eax
  80059e:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005a0:	ff 45 f0             	incl   -0x10(%ebp)
  8005a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005a9:	7c ce                	jl     800579 <Merge+0x7e>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8005b1:	e9 0a 01 00 00       	jmp    8006c0 <Merge+0x1c5>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005b9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8005bc:	0f 8d 95 00 00 00    	jge    800657 <Merge+0x15c>
  8005c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005c5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005c8:	0f 8d 89 00 00 00    	jge    800657 <Merge+0x15c>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005db:	01 d0                	add    %edx,%eax
  8005dd:	8b 10                	mov    (%eax),%edx
  8005df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005e2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ec:	01 c8                	add    %ecx,%eax
  8005ee:	8b 00                	mov    (%eax),%eax
  8005f0:	39 c2                	cmp    %eax,%edx
  8005f2:	7d 33                	jge    800627 <Merge+0x12c>
			{
				A[k - 1] = Left[leftIndex++];
  8005f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005f7:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800609:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80060c:	8d 50 01             	lea    0x1(%eax),%edx
  80060f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800612:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800619:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061c:	01 d0                	add    %edx,%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800622:	e9 96 00 00 00       	jmp    8006bd <Merge+0x1c2>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800627:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80062a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80062f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80063c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80063f:	8d 50 01             	lea    0x1(%eax),%edx
  800642:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800645:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80064c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80064f:	01 d0                	add    %edx,%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800655:	eb 66                	jmp    8006bd <Merge+0x1c2>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800657:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80065a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80065d:	7d 30                	jge    80068f <Merge+0x194>
		{
			A[k - 1] = Left[leftIndex++];
  80065f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800662:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800667:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80066e:	8b 45 08             	mov    0x8(%ebp),%eax
  800671:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800674:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800677:	8d 50 01             	lea    0x1(%eax),%edx
  80067a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80067d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800684:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800687:	01 d0                	add    %edx,%eax
  800689:	8b 00                	mov    (%eax),%eax
  80068b:	89 01                	mov    %eax,(%ecx)
  80068d:	eb 2e                	jmp    8006bd <Merge+0x1c2>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  80068f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800692:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800697:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8006a7:	8d 50 01             	lea    0x1(%eax),%edx
  8006aa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8006ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006b7:	01 d0                	add    %edx,%eax
  8006b9:	8b 00                	mov    (%eax),%eax
  8006bb:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006bd:	ff 45 ec             	incl   -0x14(%ebp)
  8006c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006c3:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006c6:	0f 8e ea fe ff ff    	jle    8005b6 <Merge+0xbb>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006cc:	90                   	nop
  8006cd:	c9                   	leave  
  8006ce:	c3                   	ret    

008006cf <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006cf:	55                   	push   %ebp
  8006d0:	89 e5                	mov    %esp,%ebp
  8006d2:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8006db:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8006df:	83 ec 0c             	sub    $0xc,%esp
  8006e2:	50                   	push   %eax
  8006e3:	e8 f3 15 00 00       	call   801cdb <sys_cputc>
  8006e8:	83 c4 10             	add    $0x10,%esp
}
  8006eb:	90                   	nop
  8006ec:	c9                   	leave  
  8006ed:	c3                   	ret    

008006ee <getchar>:


int
getchar(void)
{
  8006ee:	55                   	push   %ebp
  8006ef:	89 e5                	mov    %esp,%ebp
  8006f1:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8006f4:	e8 81 14 00 00       	call   801b7a <sys_cgetc>
  8006f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8006fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800700:	74 f2                	je     8006f4 <getchar+0x6>
	return c;
  800702:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800705:	c9                   	leave  
  800706:	c3                   	ret    

00800707 <iscons>:

int iscons(int fdnum)
{
  800707:	55                   	push   %ebp
  800708:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80070a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80070f:	5d                   	pop    %ebp
  800710:	c3                   	ret    

00800711 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800711:	55                   	push   %ebp
  800712:	89 e5                	mov    %esp,%ebp
  800714:	57                   	push   %edi
  800715:	56                   	push   %esi
  800716:	53                   	push   %ebx
  800717:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80071d:	e8 e9 16 00 00       	call   801e0b <sys_getenvindex>
  800722:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800725:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800728:	89 d0                	mov    %edx,%eax
  80072a:	c1 e0 03             	shl    $0x3,%eax
  80072d:	01 d0                	add    %edx,%eax
  80072f:	c1 e0 06             	shl    $0x6,%eax
  800732:	01 d0                	add    %edx,%eax
  800734:	c1 e0 03             	shl    $0x3,%eax
  800737:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80073c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800741:	a1 20 30 80 00       	mov    0x803020,%eax
  800746:	8a 40 10             	mov    0x10(%eax),%al
  800749:	84 c0                	test   %al,%al
  80074b:	74 0d                	je     80075a <libmain+0x49>
		binaryname = myEnv->prog_name;
  80074d:	a1 20 30 80 00       	mov    0x803020,%eax
  800752:	83 c0 10             	add    $0x10,%eax
  800755:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80075a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80075e:	7e 0a                	jle    80076a <libmain+0x59>
		binaryname = argv[0];
  800760:	8b 45 0c             	mov    0xc(%ebp),%eax
  800763:	8b 00                	mov    (%eax),%eax
  800765:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80076a:	83 ec 08             	sub    $0x8,%esp
  80076d:	ff 75 0c             	pushl  0xc(%ebp)
  800770:	ff 75 08             	pushl  0x8(%ebp)
  800773:	e8 c0 f8 ff ff       	call   800038 <_main>
  800778:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80077b:	a1 00 30 80 00       	mov    0x803000,%eax
  800780:	85 c0                	test   %eax,%eax
  800782:	0f 84 b7 01 00 00    	je     80093f <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800788:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80078e:	bb 18 26 80 00       	mov    $0x802618,%ebx
  800793:	ba 0e 00 00 00       	mov    $0xe,%edx
  800798:	89 c7                	mov    %eax,%edi
  80079a:	89 de                	mov    %ebx,%esi
  80079c:	89 d1                	mov    %edx,%ecx
  80079e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007a0:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8007a6:	b9 56 00 00 00       	mov    $0x56,%ecx
  8007ab:	b0 00                	mov    $0x0,%al
  8007ad:	89 d7                	mov    %edx,%edi
  8007af:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8007b1:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8007b8:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	50                   	push   %eax
  8007bf:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8007c5:	50                   	push   %eax
  8007c6:	e8 40 18 00 00       	call   80200b <sys_utilities>
  8007cb:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8007ce:	e8 c0 13 00 00       	call   801b93 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8007d3:	83 ec 0c             	sub    $0xc,%esp
  8007d6:	68 f4 24 80 00       	push   $0x8024f4
  8007db:	e8 5f 04 00 00       	call   800c3f <cprintf>
  8007e0:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8007e3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007e6:	85 c0                	test   %eax,%eax
  8007e8:	74 58                	je     800842 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8007ea:	e8 3a 18 00 00       	call   802029 <sys_get_optimal_num_faults>
  8007ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8007f2:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8007f8:	bb 7c 26 80 00       	mov    $0x80267c,%ebx
  8007fd:	ba 11 00 00 00       	mov    $0x11,%edx
  800802:	89 c7                	mov    %eax,%edi
  800804:	89 de                	mov    %ebx,%esi
  800806:	89 d1                	mov    %edx,%ecx
  800808:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80080a:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80080d:	b9 53 00 00 00       	mov    $0x53,%ecx
  800812:	b0 00                	mov    $0x0,%al
  800814:	89 d7                	mov    %edx,%edi
  800816:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800818:	83 ec 08             	sub    $0x8,%esp
  80081b:	ff 75 dc             	pushl  -0x24(%ebp)
  80081e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800824:	50                   	push   %eax
  800825:	e8 e1 17 00 00       	call   80200b <sys_utilities>
  80082a:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80082d:	83 ec 08             	sub    $0x8,%esp
  800830:	ff 75 dc             	pushl  -0x24(%ebp)
  800833:	68 1c 25 80 00       	push   $0x80251c
  800838:	e8 02 04 00 00       	call   800c3f <cprintf>
  80083d:	83 c4 10             	add    $0x10,%esp
  800840:	eb 59                	jmp    80089b <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800842:	a1 20 30 80 00       	mov    0x803020,%eax
  800847:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80084d:	a1 20 30 80 00       	mov    0x803020,%eax
  800852:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800858:	83 ec 04             	sub    $0x4,%esp
  80085b:	52                   	push   %edx
  80085c:	50                   	push   %eax
  80085d:	68 40 25 80 00       	push   $0x802540
  800862:	e8 d8 03 00 00       	call   800c3f <cprintf>
  800867:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80086a:	a1 20 30 80 00       	mov    0x803020,%eax
  80086f:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800875:	a1 20 30 80 00       	mov    0x803020,%eax
  80087a:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800880:	a1 20 30 80 00       	mov    0x803020,%eax
  800885:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80088b:	51                   	push   %ecx
  80088c:	52                   	push   %edx
  80088d:	50                   	push   %eax
  80088e:	68 68 25 80 00       	push   $0x802568
  800893:	e8 a7 03 00 00       	call   800c3f <cprintf>
  800898:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80089b:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a0:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8008a6:	83 ec 08             	sub    $0x8,%esp
  8008a9:	50                   	push   %eax
  8008aa:	68 c0 25 80 00       	push   $0x8025c0
  8008af:	e8 8b 03 00 00       	call   800c3f <cprintf>
  8008b4:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8008b7:	83 ec 0c             	sub    $0xc,%esp
  8008ba:	68 d4 25 80 00       	push   $0x8025d4
  8008bf:	e8 7b 03 00 00       	call   800c3f <cprintf>
  8008c4:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8008c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8008ce:	eb 28                	jmp    8008f8 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8008d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8008d8:	81 c2 74 04 00 00    	add    $0x474,%edx
  8008de:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8008e1:	83 ec 04             	sub    $0x4,%esp
  8008e4:	50                   	push   %eax
  8008e5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008e8:	68 eb 25 80 00       	push   $0x8025eb
  8008ed:	e8 4d 03 00 00       	call   800c3f <cprintf>
  8008f2:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8008f5:	ff 45 e4             	incl   -0x1c(%ebp)
  8008f8:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8008fc:	7e d2                	jle    8008d0 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8008fe:	83 ec 0c             	sub    $0xc,%esp
  800901:	68 fa 25 80 00       	push   $0x8025fa
  800906:	e8 34 03 00 00       	call   800c3f <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80090e:	a1 20 30 80 00       	mov    0x803020,%eax
  800913:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	50                   	push   %eax
  80091d:	68 fe 25 80 00       	push   $0x8025fe
  800922:	e8 18 03 00 00       	call   800c3f <cprintf>
  800927:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80092a:	83 ec 0c             	sub    $0xc,%esp
  80092d:	68 f4 24 80 00       	push   $0x8024f4
  800932:	e8 08 03 00 00       	call   800c3f <cprintf>
  800937:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80093a:	e8 6e 12 00 00       	call   801bad <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80093f:	e8 1f 00 00 00       	call   800963 <exit>
}
  800944:	90                   	nop
  800945:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800948:	5b                   	pop    %ebx
  800949:	5e                   	pop    %esi
  80094a:	5f                   	pop    %edi
  80094b:	5d                   	pop    %ebp
  80094c:	c3                   	ret    

0080094d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80094d:	55                   	push   %ebp
  80094e:	89 e5                	mov    %esp,%ebp
  800950:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800953:	83 ec 0c             	sub    $0xc,%esp
  800956:	6a 00                	push   $0x0
  800958:	e8 7a 14 00 00       	call   801dd7 <sys_destroy_env>
  80095d:	83 c4 10             	add    $0x10,%esp
}
  800960:	90                   	nop
  800961:	c9                   	leave  
  800962:	c3                   	ret    

00800963 <exit>:

void
exit(void)
{
  800963:	55                   	push   %ebp
  800964:	89 e5                	mov    %esp,%ebp
  800966:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800969:	e8 cf 14 00 00       	call   801e3d <sys_exit_env>
}
  80096e:	90                   	nop
  80096f:	c9                   	leave  
  800970:	c3                   	ret    

00800971 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800971:	55                   	push   %ebp
  800972:	89 e5                	mov    %esp,%ebp
  800974:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800977:	8d 45 10             	lea    0x10(%ebp),%eax
  80097a:	83 c0 04             	add    $0x4,%eax
  80097d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800980:	a1 44 e1 f1 0b       	mov    0xbf1e144,%eax
  800985:	85 c0                	test   %eax,%eax
  800987:	74 16                	je     80099f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800989:	a1 44 e1 f1 0b       	mov    0xbf1e144,%eax
  80098e:	83 ec 08             	sub    $0x8,%esp
  800991:	50                   	push   %eax
  800992:	68 e0 26 80 00       	push   $0x8026e0
  800997:	e8 a3 02 00 00       	call   800c3f <cprintf>
  80099c:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80099f:	a1 04 30 80 00       	mov    0x803004,%eax
  8009a4:	83 ec 0c             	sub    $0xc,%esp
  8009a7:	ff 75 0c             	pushl  0xc(%ebp)
  8009aa:	ff 75 08             	pushl  0x8(%ebp)
  8009ad:	50                   	push   %eax
  8009ae:	68 e8 26 80 00       	push   $0x8026e8
  8009b3:	6a 74                	push   $0x74
  8009b5:	e8 b2 02 00 00       	call   800c6c <cprintf_colored>
  8009ba:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8009bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c0:	83 ec 08             	sub    $0x8,%esp
  8009c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c6:	50                   	push   %eax
  8009c7:	e8 04 02 00 00       	call   800bd0 <vcprintf>
  8009cc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	6a 00                	push   $0x0
  8009d4:	68 10 27 80 00       	push   $0x802710
  8009d9:	e8 f2 01 00 00       	call   800bd0 <vcprintf>
  8009de:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009e1:	e8 7d ff ff ff       	call   800963 <exit>

	// should not return here
	while (1) ;
  8009e6:	eb fe                	jmp    8009e6 <_panic+0x75>

008009e8 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009e8:	55                   	push   %ebp
  8009e9:	89 e5                	mov    %esp,%ebp
  8009eb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8009f3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fc:	39 c2                	cmp    %eax,%edx
  8009fe:	74 14                	je     800a14 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a00:	83 ec 04             	sub    $0x4,%esp
  800a03:	68 14 27 80 00       	push   $0x802714
  800a08:	6a 26                	push   $0x26
  800a0a:	68 60 27 80 00       	push   $0x802760
  800a0f:	e8 5d ff ff ff       	call   800971 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a1b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a22:	e9 c5 00 00 00       	jmp    800aec <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	01 d0                	add    %edx,%eax
  800a36:	8b 00                	mov    (%eax),%eax
  800a38:	85 c0                	test   %eax,%eax
  800a3a:	75 08                	jne    800a44 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800a3c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a3f:	e9 a5 00 00 00       	jmp    800ae9 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800a44:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a4b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a52:	eb 69                	jmp    800abd <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a54:	a1 20 30 80 00       	mov    0x803020,%eax
  800a59:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a5f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a62:	89 d0                	mov    %edx,%eax
  800a64:	01 c0                	add    %eax,%eax
  800a66:	01 d0                	add    %edx,%eax
  800a68:	c1 e0 03             	shl    $0x3,%eax
  800a6b:	01 c8                	add    %ecx,%eax
  800a6d:	8a 40 04             	mov    0x4(%eax),%al
  800a70:	84 c0                	test   %al,%al
  800a72:	75 46                	jne    800aba <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a74:	a1 20 30 80 00       	mov    0x803020,%eax
  800a79:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a7f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a82:	89 d0                	mov    %edx,%eax
  800a84:	01 c0                	add    %eax,%eax
  800a86:	01 d0                	add    %edx,%eax
  800a88:	c1 e0 03             	shl    $0x3,%eax
  800a8b:	01 c8                	add    %ecx,%eax
  800a8d:	8b 00                	mov    (%eax),%eax
  800a8f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a92:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a95:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a9a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	01 c8                	add    %ecx,%eax
  800aab:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aad:	39 c2                	cmp    %eax,%edx
  800aaf:	75 09                	jne    800aba <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800ab1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ab8:	eb 15                	jmp    800acf <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aba:	ff 45 e8             	incl   -0x18(%ebp)
  800abd:	a1 20 30 80 00       	mov    0x803020,%eax
  800ac2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800ac8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800acb:	39 c2                	cmp    %eax,%edx
  800acd:	77 85                	ja     800a54 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800acf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ad3:	75 14                	jne    800ae9 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800ad5:	83 ec 04             	sub    $0x4,%esp
  800ad8:	68 6c 27 80 00       	push   $0x80276c
  800add:	6a 3a                	push   $0x3a
  800adf:	68 60 27 80 00       	push   $0x802760
  800ae4:	e8 88 fe ff ff       	call   800971 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800ae9:	ff 45 f0             	incl   -0x10(%ebp)
  800aec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aef:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800af2:	0f 8c 2f ff ff ff    	jl     800a27 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800af8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b06:	eb 26                	jmp    800b2e <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b08:	a1 20 30 80 00       	mov    0x803020,%eax
  800b0d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800b13:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b16:	89 d0                	mov    %edx,%eax
  800b18:	01 c0                	add    %eax,%eax
  800b1a:	01 d0                	add    %edx,%eax
  800b1c:	c1 e0 03             	shl    $0x3,%eax
  800b1f:	01 c8                	add    %ecx,%eax
  800b21:	8a 40 04             	mov    0x4(%eax),%al
  800b24:	3c 01                	cmp    $0x1,%al
  800b26:	75 03                	jne    800b2b <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800b28:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b2b:	ff 45 e0             	incl   -0x20(%ebp)
  800b2e:	a1 20 30 80 00       	mov    0x803020,%eax
  800b33:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800b39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b3c:	39 c2                	cmp    %eax,%edx
  800b3e:	77 c8                	ja     800b08 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b43:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b46:	74 14                	je     800b5c <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800b48:	83 ec 04             	sub    $0x4,%esp
  800b4b:	68 c0 27 80 00       	push   $0x8027c0
  800b50:	6a 44                	push   $0x44
  800b52:	68 60 27 80 00       	push   $0x802760
  800b57:	e8 15 fe ff ff       	call   800971 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b5c:	90                   	nop
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	53                   	push   %ebx
  800b63:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b71:	89 0a                	mov    %ecx,(%edx)
  800b73:	8b 55 08             	mov    0x8(%ebp),%edx
  800b76:	88 d1                	mov    %dl,%cl
  800b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b89:	75 30                	jne    800bbb <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800b8b:	8b 15 48 e1 f1 0b    	mov    0xbf1e148,%edx
  800b91:	a0 40 c0 50 04       	mov    0x450c040,%al
  800b96:	0f b6 c0             	movzbl %al,%eax
  800b99:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800b9c:	8b 09                	mov    (%ecx),%ecx
  800b9e:	89 cb                	mov    %ecx,%ebx
  800ba0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800ba3:	83 c1 08             	add    $0x8,%ecx
  800ba6:	52                   	push   %edx
  800ba7:	50                   	push   %eax
  800ba8:	53                   	push   %ebx
  800ba9:	51                   	push   %ecx
  800baa:	e8 a0 0f 00 00       	call   801b4f <sys_cputs>
  800baf:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbe:	8b 40 04             	mov    0x4(%eax),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc7:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bca:	90                   	nop
  800bcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
  800bd3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bd9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800be0:	00 00 00 
	b.cnt = 0;
  800be3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800bea:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800bed:	ff 75 0c             	pushl  0xc(%ebp)
  800bf0:	ff 75 08             	pushl  0x8(%ebp)
  800bf3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bf9:	50                   	push   %eax
  800bfa:	68 5f 0b 80 00       	push   $0x800b5f
  800bff:	e8 5a 02 00 00       	call   800e5e <vprintfmt>
  800c04:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800c07:	8b 15 48 e1 f1 0b    	mov    0xbf1e148,%edx
  800c0d:	a0 40 c0 50 04       	mov    0x450c040,%al
  800c12:	0f b6 c0             	movzbl %al,%eax
  800c15:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800c1b:	52                   	push   %edx
  800c1c:	50                   	push   %eax
  800c1d:	51                   	push   %ecx
  800c1e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c24:	83 c0 08             	add    $0x8,%eax
  800c27:	50                   	push   %eax
  800c28:	e8 22 0f 00 00       	call   801b4f <sys_cputs>
  800c2d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c30:	c6 05 40 c0 50 04 00 	movb   $0x0,0x450c040
	return b.cnt;
  800c37:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c3d:	c9                   	leave  
  800c3e:	c3                   	ret    

00800c3f <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800c3f:	55                   	push   %ebp
  800c40:	89 e5                	mov    %esp,%ebp
  800c42:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c45:	c6 05 40 c0 50 04 01 	movb   $0x1,0x450c040
	va_start(ap, fmt);
  800c4c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	83 ec 08             	sub    $0x8,%esp
  800c58:	ff 75 f4             	pushl  -0xc(%ebp)
  800c5b:	50                   	push   %eax
  800c5c:	e8 6f ff ff ff       	call   800bd0 <vcprintf>
  800c61:	83 c4 10             	add    $0x10,%esp
  800c64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c67:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c6a:	c9                   	leave  
  800c6b:	c3                   	ret    

00800c6c <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800c6c:	55                   	push   %ebp
  800c6d:	89 e5                	mov    %esp,%ebp
  800c6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c72:	c6 05 40 c0 50 04 01 	movb   $0x1,0x450c040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	c1 e0 08             	shl    $0x8,%eax
  800c7f:	a3 48 e1 f1 0b       	mov    %eax,0xbf1e148
	va_start(ap, fmt);
  800c84:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c87:	83 c0 04             	add    $0x4,%eax
  800c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c90:	83 ec 08             	sub    $0x8,%esp
  800c93:	ff 75 f4             	pushl  -0xc(%ebp)
  800c96:	50                   	push   %eax
  800c97:	e8 34 ff ff ff       	call   800bd0 <vcprintf>
  800c9c:	83 c4 10             	add    $0x10,%esp
  800c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800ca2:	c7 05 48 e1 f1 0b 00 	movl   $0x700,0xbf1e148
  800ca9:	07 00 00 

	return cnt;
  800cac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800caf:	c9                   	leave  
  800cb0:	c3                   	ret    

00800cb1 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800cb1:	55                   	push   %ebp
  800cb2:	89 e5                	mov    %esp,%ebp
  800cb4:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800cb7:	e8 d7 0e 00 00       	call   801b93 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800cbc:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	83 ec 08             	sub    $0x8,%esp
  800cc8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ccb:	50                   	push   %eax
  800ccc:	e8 ff fe ff ff       	call   800bd0 <vcprintf>
  800cd1:	83 c4 10             	add    $0x10,%esp
  800cd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800cd7:	e8 d1 0e 00 00       	call   801bad <sys_unlock_cons>
	return cnt;
  800cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cdf:	c9                   	leave  
  800ce0:	c3                   	ret    

00800ce1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ce1:	55                   	push   %ebp
  800ce2:	89 e5                	mov    %esp,%ebp
  800ce4:	53                   	push   %ebx
  800ce5:	83 ec 14             	sub    $0x14,%esp
  800ce8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ceb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cee:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800cf4:	8b 45 18             	mov    0x18(%ebp),%eax
  800cf7:	ba 00 00 00 00       	mov    $0x0,%edx
  800cfc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cff:	77 55                	ja     800d56 <printnum+0x75>
  800d01:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d04:	72 05                	jb     800d0b <printnum+0x2a>
  800d06:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d09:	77 4b                	ja     800d56 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d0b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d0e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d11:	8b 45 18             	mov    0x18(%ebp),%eax
  800d14:	ba 00 00 00 00       	mov    $0x0,%edx
  800d19:	52                   	push   %edx
  800d1a:	50                   	push   %eax
  800d1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1e:	ff 75 f0             	pushl  -0x10(%ebp)
  800d21:	e8 72 13 00 00       	call   802098 <__udivdi3>
  800d26:	83 c4 10             	add    $0x10,%esp
  800d29:	83 ec 04             	sub    $0x4,%esp
  800d2c:	ff 75 20             	pushl  0x20(%ebp)
  800d2f:	53                   	push   %ebx
  800d30:	ff 75 18             	pushl  0x18(%ebp)
  800d33:	52                   	push   %edx
  800d34:	50                   	push   %eax
  800d35:	ff 75 0c             	pushl  0xc(%ebp)
  800d38:	ff 75 08             	pushl  0x8(%ebp)
  800d3b:	e8 a1 ff ff ff       	call   800ce1 <printnum>
  800d40:	83 c4 20             	add    $0x20,%esp
  800d43:	eb 1a                	jmp    800d5f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	ff 75 20             	pushl  0x20(%ebp)
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	ff d0                	call   *%eax
  800d53:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d56:	ff 4d 1c             	decl   0x1c(%ebp)
  800d59:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d5d:	7f e6                	jg     800d45 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d5f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d62:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d6d:	53                   	push   %ebx
  800d6e:	51                   	push   %ecx
  800d6f:	52                   	push   %edx
  800d70:	50                   	push   %eax
  800d71:	e8 32 14 00 00       	call   8021a8 <__umoddi3>
  800d76:	83 c4 10             	add    $0x10,%esp
  800d79:	05 34 2a 80 00       	add    $0x802a34,%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	0f be c0             	movsbl %al,%eax
  800d83:	83 ec 08             	sub    $0x8,%esp
  800d86:	ff 75 0c             	pushl  0xc(%ebp)
  800d89:	50                   	push   %eax
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	ff d0                	call   *%eax
  800d8f:	83 c4 10             	add    $0x10,%esp
}
  800d92:	90                   	nop
  800d93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d9b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d9f:	7e 1c                	jle    800dbd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	8b 00                	mov    (%eax),%eax
  800da6:	8d 50 08             	lea    0x8(%eax),%edx
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	89 10                	mov    %edx,(%eax)
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	8b 00                	mov    (%eax),%eax
  800db3:	83 e8 08             	sub    $0x8,%eax
  800db6:	8b 50 04             	mov    0x4(%eax),%edx
  800db9:	8b 00                	mov    (%eax),%eax
  800dbb:	eb 40                	jmp    800dfd <getuint+0x65>
	else if (lflag)
  800dbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc1:	74 1e                	je     800de1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	8b 00                	mov    (%eax),%eax
  800dc8:	8d 50 04             	lea    0x4(%eax),%edx
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	89 10                	mov    %edx,(%eax)
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	8b 00                	mov    (%eax),%eax
  800dd5:	83 e8 04             	sub    $0x4,%eax
  800dd8:	8b 00                	mov    (%eax),%eax
  800dda:	ba 00 00 00 00       	mov    $0x0,%edx
  800ddf:	eb 1c                	jmp    800dfd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	8b 00                	mov    (%eax),%eax
  800de6:	8d 50 04             	lea    0x4(%eax),%edx
  800de9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dec:	89 10                	mov    %edx,(%eax)
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8b 00                	mov    (%eax),%eax
  800df3:	83 e8 04             	sub    $0x4,%eax
  800df6:	8b 00                	mov    (%eax),%eax
  800df8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800dfd:	5d                   	pop    %ebp
  800dfe:	c3                   	ret    

00800dff <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800dff:	55                   	push   %ebp
  800e00:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e02:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e06:	7e 1c                	jle    800e24 <getint+0x25>
		return va_arg(*ap, long long);
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	8d 50 08             	lea    0x8(%eax),%edx
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	89 10                	mov    %edx,(%eax)
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	8b 00                	mov    (%eax),%eax
  800e1a:	83 e8 08             	sub    $0x8,%eax
  800e1d:	8b 50 04             	mov    0x4(%eax),%edx
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	eb 38                	jmp    800e5c <getint+0x5d>
	else if (lflag)
  800e24:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e28:	74 1a                	je     800e44 <getint+0x45>
		return va_arg(*ap, long);
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	8d 50 04             	lea    0x4(%eax),%edx
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	89 10                	mov    %edx,(%eax)
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	8b 00                	mov    (%eax),%eax
  800e3c:	83 e8 04             	sub    $0x4,%eax
  800e3f:	8b 00                	mov    (%eax),%eax
  800e41:	99                   	cltd   
  800e42:	eb 18                	jmp    800e5c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8b 00                	mov    (%eax),%eax
  800e49:	8d 50 04             	lea    0x4(%eax),%edx
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	89 10                	mov    %edx,(%eax)
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8b 00                	mov    (%eax),%eax
  800e56:	83 e8 04             	sub    $0x4,%eax
  800e59:	8b 00                	mov    (%eax),%eax
  800e5b:	99                   	cltd   
}
  800e5c:	5d                   	pop    %ebp
  800e5d:	c3                   	ret    

00800e5e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e5e:	55                   	push   %ebp
  800e5f:	89 e5                	mov    %esp,%ebp
  800e61:	56                   	push   %esi
  800e62:	53                   	push   %ebx
  800e63:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e66:	eb 17                	jmp    800e7f <vprintfmt+0x21>
			if (ch == '\0')
  800e68:	85 db                	test   %ebx,%ebx
  800e6a:	0f 84 c1 03 00 00    	je     801231 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800e70:	83 ec 08             	sub    $0x8,%esp
  800e73:	ff 75 0c             	pushl  0xc(%ebp)
  800e76:	53                   	push   %ebx
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	ff d0                	call   *%eax
  800e7c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e82:	8d 50 01             	lea    0x1(%eax),%edx
  800e85:	89 55 10             	mov    %edx,0x10(%ebp)
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	0f b6 d8             	movzbl %al,%ebx
  800e8d:	83 fb 25             	cmp    $0x25,%ebx
  800e90:	75 d6                	jne    800e68 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e92:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e96:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e9d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ea4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800eab:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb5:	8d 50 01             	lea    0x1(%eax),%edx
  800eb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	0f b6 d8             	movzbl %al,%ebx
  800ec0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ec3:	83 f8 5b             	cmp    $0x5b,%eax
  800ec6:	0f 87 3d 03 00 00    	ja     801209 <vprintfmt+0x3ab>
  800ecc:	8b 04 85 58 2a 80 00 	mov    0x802a58(,%eax,4),%eax
  800ed3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ed5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ed9:	eb d7                	jmp    800eb2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800edb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800edf:	eb d1                	jmp    800eb2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ee1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ee8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800eeb:	89 d0                	mov    %edx,%eax
  800eed:	c1 e0 02             	shl    $0x2,%eax
  800ef0:	01 d0                	add    %edx,%eax
  800ef2:	01 c0                	add    %eax,%eax
  800ef4:	01 d8                	add    %ebx,%eax
  800ef6:	83 e8 30             	sub    $0x30,%eax
  800ef9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800efc:	8b 45 10             	mov    0x10(%ebp),%eax
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f04:	83 fb 2f             	cmp    $0x2f,%ebx
  800f07:	7e 3e                	jle    800f47 <vprintfmt+0xe9>
  800f09:	83 fb 39             	cmp    $0x39,%ebx
  800f0c:	7f 39                	jg     800f47 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f0e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f11:	eb d5                	jmp    800ee8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f13:	8b 45 14             	mov    0x14(%ebp),%eax
  800f16:	83 c0 04             	add    $0x4,%eax
  800f19:	89 45 14             	mov    %eax,0x14(%ebp)
  800f1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1f:	83 e8 04             	sub    $0x4,%eax
  800f22:	8b 00                	mov    (%eax),%eax
  800f24:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f27:	eb 1f                	jmp    800f48 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f29:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f2d:	79 83                	jns    800eb2 <vprintfmt+0x54>
				width = 0;
  800f2f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f36:	e9 77 ff ff ff       	jmp    800eb2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f3b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f42:	e9 6b ff ff ff       	jmp    800eb2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f47:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f48:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4c:	0f 89 60 ff ff ff    	jns    800eb2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f52:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f58:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f5f:	e9 4e ff ff ff       	jmp    800eb2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f64:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f67:	e9 46 ff ff ff       	jmp    800eb2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6f:	83 c0 04             	add    $0x4,%eax
  800f72:	89 45 14             	mov    %eax,0x14(%ebp)
  800f75:	8b 45 14             	mov    0x14(%ebp),%eax
  800f78:	83 e8 04             	sub    $0x4,%eax
  800f7b:	8b 00                	mov    (%eax),%eax
  800f7d:	83 ec 08             	sub    $0x8,%esp
  800f80:	ff 75 0c             	pushl  0xc(%ebp)
  800f83:	50                   	push   %eax
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	ff d0                	call   *%eax
  800f89:	83 c4 10             	add    $0x10,%esp
			break;
  800f8c:	e9 9b 02 00 00       	jmp    80122c <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f91:	8b 45 14             	mov    0x14(%ebp),%eax
  800f94:	83 c0 04             	add    $0x4,%eax
  800f97:	89 45 14             	mov    %eax,0x14(%ebp)
  800f9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9d:	83 e8 04             	sub    $0x4,%eax
  800fa0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fa2:	85 db                	test   %ebx,%ebx
  800fa4:	79 02                	jns    800fa8 <vprintfmt+0x14a>
				err = -err;
  800fa6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fa8:	83 fb 64             	cmp    $0x64,%ebx
  800fab:	7f 0b                	jg     800fb8 <vprintfmt+0x15a>
  800fad:	8b 34 9d a0 28 80 00 	mov    0x8028a0(,%ebx,4),%esi
  800fb4:	85 f6                	test   %esi,%esi
  800fb6:	75 19                	jne    800fd1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fb8:	53                   	push   %ebx
  800fb9:	68 45 2a 80 00       	push   $0x802a45
  800fbe:	ff 75 0c             	pushl  0xc(%ebp)
  800fc1:	ff 75 08             	pushl  0x8(%ebp)
  800fc4:	e8 70 02 00 00       	call   801239 <printfmt>
  800fc9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fcc:	e9 5b 02 00 00       	jmp    80122c <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800fd1:	56                   	push   %esi
  800fd2:	68 4e 2a 80 00       	push   $0x802a4e
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	ff 75 08             	pushl  0x8(%ebp)
  800fdd:	e8 57 02 00 00       	call   801239 <printfmt>
  800fe2:	83 c4 10             	add    $0x10,%esp
			break;
  800fe5:	e9 42 02 00 00       	jmp    80122c <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800fea:	8b 45 14             	mov    0x14(%ebp),%eax
  800fed:	83 c0 04             	add    $0x4,%eax
  800ff0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ff3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff6:	83 e8 04             	sub    $0x4,%eax
  800ff9:	8b 30                	mov    (%eax),%esi
  800ffb:	85 f6                	test   %esi,%esi
  800ffd:	75 05                	jne    801004 <vprintfmt+0x1a6>
				p = "(null)";
  800fff:	be 51 2a 80 00       	mov    $0x802a51,%esi
			if (width > 0 && padc != '-')
  801004:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801008:	7e 6d                	jle    801077 <vprintfmt+0x219>
  80100a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80100e:	74 67                	je     801077 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801010:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801013:	83 ec 08             	sub    $0x8,%esp
  801016:	50                   	push   %eax
  801017:	56                   	push   %esi
  801018:	e8 1e 03 00 00       	call   80133b <strnlen>
  80101d:	83 c4 10             	add    $0x10,%esp
  801020:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801023:	eb 16                	jmp    80103b <vprintfmt+0x1dd>
					putch(padc, putdat);
  801025:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801029:	83 ec 08             	sub    $0x8,%esp
  80102c:	ff 75 0c             	pushl  0xc(%ebp)
  80102f:	50                   	push   %eax
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	ff d0                	call   *%eax
  801035:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801038:	ff 4d e4             	decl   -0x1c(%ebp)
  80103b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80103f:	7f e4                	jg     801025 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801041:	eb 34                	jmp    801077 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801043:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801047:	74 1c                	je     801065 <vprintfmt+0x207>
  801049:	83 fb 1f             	cmp    $0x1f,%ebx
  80104c:	7e 05                	jle    801053 <vprintfmt+0x1f5>
  80104e:	83 fb 7e             	cmp    $0x7e,%ebx
  801051:	7e 12                	jle    801065 <vprintfmt+0x207>
					putch('?', putdat);
  801053:	83 ec 08             	sub    $0x8,%esp
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	6a 3f                	push   $0x3f
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	ff d0                	call   *%eax
  801060:	83 c4 10             	add    $0x10,%esp
  801063:	eb 0f                	jmp    801074 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801065:	83 ec 08             	sub    $0x8,%esp
  801068:	ff 75 0c             	pushl  0xc(%ebp)
  80106b:	53                   	push   %ebx
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	ff d0                	call   *%eax
  801071:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801074:	ff 4d e4             	decl   -0x1c(%ebp)
  801077:	89 f0                	mov    %esi,%eax
  801079:	8d 70 01             	lea    0x1(%eax),%esi
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	0f be d8             	movsbl %al,%ebx
  801081:	85 db                	test   %ebx,%ebx
  801083:	74 24                	je     8010a9 <vprintfmt+0x24b>
  801085:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801089:	78 b8                	js     801043 <vprintfmt+0x1e5>
  80108b:	ff 4d e0             	decl   -0x20(%ebp)
  80108e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801092:	79 af                	jns    801043 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801094:	eb 13                	jmp    8010a9 <vprintfmt+0x24b>
				putch(' ', putdat);
  801096:	83 ec 08             	sub    $0x8,%esp
  801099:	ff 75 0c             	pushl  0xc(%ebp)
  80109c:	6a 20                	push   $0x20
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	ff d0                	call   *%eax
  8010a3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010a6:	ff 4d e4             	decl   -0x1c(%ebp)
  8010a9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010ad:	7f e7                	jg     801096 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010af:	e9 78 01 00 00       	jmp    80122c <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010b4:	83 ec 08             	sub    $0x8,%esp
  8010b7:	ff 75 e8             	pushl  -0x18(%ebp)
  8010ba:	8d 45 14             	lea    0x14(%ebp),%eax
  8010bd:	50                   	push   %eax
  8010be:	e8 3c fd ff ff       	call   800dff <getint>
  8010c3:	83 c4 10             	add    $0x10,%esp
  8010c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d2:	85 d2                	test   %edx,%edx
  8010d4:	79 23                	jns    8010f9 <vprintfmt+0x29b>
				putch('-', putdat);
  8010d6:	83 ec 08             	sub    $0x8,%esp
  8010d9:	ff 75 0c             	pushl  0xc(%ebp)
  8010dc:	6a 2d                	push   $0x2d
  8010de:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e1:	ff d0                	call   *%eax
  8010e3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8010e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ec:	f7 d8                	neg    %eax
  8010ee:	83 d2 00             	adc    $0x0,%edx
  8010f1:	f7 da                	neg    %edx
  8010f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010f9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801100:	e9 bc 00 00 00       	jmp    8011c1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801105:	83 ec 08             	sub    $0x8,%esp
  801108:	ff 75 e8             	pushl  -0x18(%ebp)
  80110b:	8d 45 14             	lea    0x14(%ebp),%eax
  80110e:	50                   	push   %eax
  80110f:	e8 84 fc ff ff       	call   800d98 <getuint>
  801114:	83 c4 10             	add    $0x10,%esp
  801117:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80111a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80111d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801124:	e9 98 00 00 00       	jmp    8011c1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801129:	83 ec 08             	sub    $0x8,%esp
  80112c:	ff 75 0c             	pushl  0xc(%ebp)
  80112f:	6a 58                	push   $0x58
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	ff d0                	call   *%eax
  801136:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801139:	83 ec 08             	sub    $0x8,%esp
  80113c:	ff 75 0c             	pushl  0xc(%ebp)
  80113f:	6a 58                	push   $0x58
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	ff d0                	call   *%eax
  801146:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801149:	83 ec 08             	sub    $0x8,%esp
  80114c:	ff 75 0c             	pushl  0xc(%ebp)
  80114f:	6a 58                	push   $0x58
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	ff d0                	call   *%eax
  801156:	83 c4 10             	add    $0x10,%esp
			break;
  801159:	e9 ce 00 00 00       	jmp    80122c <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80115e:	83 ec 08             	sub    $0x8,%esp
  801161:	ff 75 0c             	pushl  0xc(%ebp)
  801164:	6a 30                	push   $0x30
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	ff d0                	call   *%eax
  80116b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80116e:	83 ec 08             	sub    $0x8,%esp
  801171:	ff 75 0c             	pushl  0xc(%ebp)
  801174:	6a 78                	push   $0x78
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	ff d0                	call   *%eax
  80117b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80117e:	8b 45 14             	mov    0x14(%ebp),%eax
  801181:	83 c0 04             	add    $0x4,%eax
  801184:	89 45 14             	mov    %eax,0x14(%ebp)
  801187:	8b 45 14             	mov    0x14(%ebp),%eax
  80118a:	83 e8 04             	sub    $0x4,%eax
  80118d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80118f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801192:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801199:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011a0:	eb 1f                	jmp    8011c1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011a2:	83 ec 08             	sub    $0x8,%esp
  8011a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8011a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8011ab:	50                   	push   %eax
  8011ac:	e8 e7 fb ff ff       	call   800d98 <getuint>
  8011b1:	83 c4 10             	add    $0x10,%esp
  8011b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011ba:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011c1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011c8:	83 ec 04             	sub    $0x4,%esp
  8011cb:	52                   	push   %edx
  8011cc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011cf:	50                   	push   %eax
  8011d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d3:	ff 75 f0             	pushl  -0x10(%ebp)
  8011d6:	ff 75 0c             	pushl  0xc(%ebp)
  8011d9:	ff 75 08             	pushl  0x8(%ebp)
  8011dc:	e8 00 fb ff ff       	call   800ce1 <printnum>
  8011e1:	83 c4 20             	add    $0x20,%esp
			break;
  8011e4:	eb 46                	jmp    80122c <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8011e6:	83 ec 08             	sub    $0x8,%esp
  8011e9:	ff 75 0c             	pushl  0xc(%ebp)
  8011ec:	53                   	push   %ebx
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	ff d0                	call   *%eax
  8011f2:	83 c4 10             	add    $0x10,%esp
			break;
  8011f5:	eb 35                	jmp    80122c <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8011f7:	c6 05 40 c0 50 04 00 	movb   $0x0,0x450c040
			break;
  8011fe:	eb 2c                	jmp    80122c <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801200:	c6 05 40 c0 50 04 01 	movb   $0x1,0x450c040
			break;
  801207:	eb 23                	jmp    80122c <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801209:	83 ec 08             	sub    $0x8,%esp
  80120c:	ff 75 0c             	pushl  0xc(%ebp)
  80120f:	6a 25                	push   $0x25
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	ff d0                	call   *%eax
  801216:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801219:	ff 4d 10             	decl   0x10(%ebp)
  80121c:	eb 03                	jmp    801221 <vprintfmt+0x3c3>
  80121e:	ff 4d 10             	decl   0x10(%ebp)
  801221:	8b 45 10             	mov    0x10(%ebp),%eax
  801224:	48                   	dec    %eax
  801225:	8a 00                	mov    (%eax),%al
  801227:	3c 25                	cmp    $0x25,%al
  801229:	75 f3                	jne    80121e <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80122b:	90                   	nop
		}
	}
  80122c:	e9 35 fc ff ff       	jmp    800e66 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801231:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801232:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801235:	5b                   	pop    %ebx
  801236:	5e                   	pop    %esi
  801237:	5d                   	pop    %ebp
  801238:	c3                   	ret    

00801239 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80123f:	8d 45 10             	lea    0x10(%ebp),%eax
  801242:	83 c0 04             	add    $0x4,%eax
  801245:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801248:	8b 45 10             	mov    0x10(%ebp),%eax
  80124b:	ff 75 f4             	pushl  -0xc(%ebp)
  80124e:	50                   	push   %eax
  80124f:	ff 75 0c             	pushl  0xc(%ebp)
  801252:	ff 75 08             	pushl  0x8(%ebp)
  801255:	e8 04 fc ff ff       	call   800e5e <vprintfmt>
  80125a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80125d:	90                   	nop
  80125e:	c9                   	leave  
  80125f:	c3                   	ret    

00801260 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801260:	55                   	push   %ebp
  801261:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801263:	8b 45 0c             	mov    0xc(%ebp),%eax
  801266:	8b 40 08             	mov    0x8(%eax),%eax
  801269:	8d 50 01             	lea    0x1(%eax),%edx
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	8b 10                	mov    (%eax),%edx
  801277:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127a:	8b 40 04             	mov    0x4(%eax),%eax
  80127d:	39 c2                	cmp    %eax,%edx
  80127f:	73 12                	jae    801293 <sprintputch+0x33>
		*b->buf++ = ch;
  801281:	8b 45 0c             	mov    0xc(%ebp),%eax
  801284:	8b 00                	mov    (%eax),%eax
  801286:	8d 48 01             	lea    0x1(%eax),%ecx
  801289:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128c:	89 0a                	mov    %ecx,(%edx)
  80128e:	8b 55 08             	mov    0x8(%ebp),%edx
  801291:	88 10                	mov    %dl,(%eax)
}
  801293:	90                   	nop
  801294:	5d                   	pop    %ebp
  801295:	c3                   	ret    

00801296 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801296:	55                   	push   %ebp
  801297:	89 e5                	mov    %esp,%ebp
  801299:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80129c:	8b 45 08             	mov    0x8(%ebp),%eax
  80129f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	01 d0                	add    %edx,%eax
  8012ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012bb:	74 06                	je     8012c3 <vsnprintf+0x2d>
  8012bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012c1:	7f 07                	jg     8012ca <vsnprintf+0x34>
		return -E_INVAL;
  8012c3:	b8 03 00 00 00       	mov    $0x3,%eax
  8012c8:	eb 20                	jmp    8012ea <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012ca:	ff 75 14             	pushl  0x14(%ebp)
  8012cd:	ff 75 10             	pushl  0x10(%ebp)
  8012d0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012d3:	50                   	push   %eax
  8012d4:	68 60 12 80 00       	push   $0x801260
  8012d9:	e8 80 fb ff ff       	call   800e5e <vprintfmt>
  8012de:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012e4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012f2:	8d 45 10             	lea    0x10(%ebp),%eax
  8012f5:	83 c0 04             	add    $0x4,%eax
  8012f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8012fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fe:	ff 75 f4             	pushl  -0xc(%ebp)
  801301:	50                   	push   %eax
  801302:	ff 75 0c             	pushl  0xc(%ebp)
  801305:	ff 75 08             	pushl  0x8(%ebp)
  801308:	e8 89 ff ff ff       	call   801296 <vsnprintf>
  80130d:	83 c4 10             	add    $0x10,%esp
  801310:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801313:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801316:	c9                   	leave  
  801317:	c3                   	ret    

00801318 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801318:	55                   	push   %ebp
  801319:	89 e5                	mov    %esp,%ebp
  80131b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80131e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801325:	eb 06                	jmp    80132d <strlen+0x15>
		n++;
  801327:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80132a:	ff 45 08             	incl   0x8(%ebp)
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	84 c0                	test   %al,%al
  801334:	75 f1                	jne    801327 <strlen+0xf>
		n++;
	return n;
  801336:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801348:	eb 09                	jmp    801353 <strnlen+0x18>
		n++;
  80134a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80134d:	ff 45 08             	incl   0x8(%ebp)
  801350:	ff 4d 0c             	decl   0xc(%ebp)
  801353:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801357:	74 09                	je     801362 <strnlen+0x27>
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	8a 00                	mov    (%eax),%al
  80135e:	84 c0                	test   %al,%al
  801360:	75 e8                	jne    80134a <strnlen+0xf>
		n++;
	return n;
  801362:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801365:	c9                   	leave  
  801366:	c3                   	ret    

00801367 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
  80136a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801373:	90                   	nop
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8d 50 01             	lea    0x1(%eax),%edx
  80137a:	89 55 08             	mov    %edx,0x8(%ebp)
  80137d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801380:	8d 4a 01             	lea    0x1(%edx),%ecx
  801383:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801386:	8a 12                	mov    (%edx),%dl
  801388:	88 10                	mov    %dl,(%eax)
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	84 c0                	test   %al,%al
  80138e:	75 e4                	jne    801374 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801390:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
  801398:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013a8:	eb 1f                	jmp    8013c9 <strncpy+0x34>
		*dst++ = *src;
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	8d 50 01             	lea    0x1(%eax),%edx
  8013b0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b6:	8a 12                	mov    (%edx),%dl
  8013b8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bd:	8a 00                	mov    (%eax),%al
  8013bf:	84 c0                	test   %al,%al
  8013c1:	74 03                	je     8013c6 <strncpy+0x31>
			src++;
  8013c3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013c6:	ff 45 fc             	incl   -0x4(%ebp)
  8013c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013cf:	72 d9                	jb     8013aa <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e6:	74 30                	je     801418 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013e8:	eb 16                	jmp    801400 <strlcpy+0x2a>
			*dst++ = *src++;
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8d 50 01             	lea    0x1(%eax),%edx
  8013f0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013f9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013fc:	8a 12                	mov    (%edx),%dl
  8013fe:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801400:	ff 4d 10             	decl   0x10(%ebp)
  801403:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801407:	74 09                	je     801412 <strlcpy+0x3c>
  801409:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140c:	8a 00                	mov    (%eax),%al
  80140e:	84 c0                	test   %al,%al
  801410:	75 d8                	jne    8013ea <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801418:	8b 55 08             	mov    0x8(%ebp),%edx
  80141b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80141e:	29 c2                	sub    %eax,%edx
  801420:	89 d0                	mov    %edx,%eax
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801427:	eb 06                	jmp    80142f <strcmp+0xb>
		p++, q++;
  801429:	ff 45 08             	incl   0x8(%ebp)
  80142c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	84 c0                	test   %al,%al
  801436:	74 0e                	je     801446 <strcmp+0x22>
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	8a 10                	mov    (%eax),%dl
  80143d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	38 c2                	cmp    %al,%dl
  801444:	74 e3                	je     801429 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	0f b6 d0             	movzbl %al,%edx
  80144e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	0f b6 c0             	movzbl %al,%eax
  801456:	29 c2                	sub    %eax,%edx
  801458:	89 d0                	mov    %edx,%eax
}
  80145a:	5d                   	pop    %ebp
  80145b:	c3                   	ret    

0080145c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80145f:	eb 09                	jmp    80146a <strncmp+0xe>
		n--, p++, q++;
  801461:	ff 4d 10             	decl   0x10(%ebp)
  801464:	ff 45 08             	incl   0x8(%ebp)
  801467:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80146a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80146e:	74 17                	je     801487 <strncmp+0x2b>
  801470:	8b 45 08             	mov    0x8(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	84 c0                	test   %al,%al
  801477:	74 0e                	je     801487 <strncmp+0x2b>
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8a 10                	mov    (%eax),%dl
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	8a 00                	mov    (%eax),%al
  801483:	38 c2                	cmp    %al,%dl
  801485:	74 da                	je     801461 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801487:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148b:	75 07                	jne    801494 <strncmp+0x38>
		return 0;
  80148d:	b8 00 00 00 00       	mov    $0x0,%eax
  801492:	eb 14                	jmp    8014a8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8a 00                	mov    (%eax),%al
  801499:	0f b6 d0             	movzbl %al,%edx
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	8a 00                	mov    (%eax),%al
  8014a1:	0f b6 c0             	movzbl %al,%eax
  8014a4:	29 c2                	sub    %eax,%edx
  8014a6:	89 d0                	mov    %edx,%eax
}
  8014a8:	5d                   	pop    %ebp
  8014a9:	c3                   	ret    

008014aa <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
  8014ad:	83 ec 04             	sub    $0x4,%esp
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014b6:	eb 12                	jmp    8014ca <strchr+0x20>
		if (*s == c)
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014c0:	75 05                	jne    8014c7 <strchr+0x1d>
			return (char *) s;
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	eb 11                	jmp    8014d8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014c7:	ff 45 08             	incl   0x8(%ebp)
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 00                	mov    (%eax),%al
  8014cf:	84 c0                	test   %al,%al
  8014d1:	75 e5                	jne    8014b8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 04             	sub    $0x4,%esp
  8014e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014e6:	eb 0d                	jmp    8014f5 <strfind+0x1b>
		if (*s == c)
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	8a 00                	mov    (%eax),%al
  8014ed:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014f0:	74 0e                	je     801500 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014f2:	ff 45 08             	incl   0x8(%ebp)
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	8a 00                	mov    (%eax),%al
  8014fa:	84 c0                	test   %al,%al
  8014fc:	75 ea                	jne    8014e8 <strfind+0xe>
  8014fe:	eb 01                	jmp    801501 <strfind+0x27>
		if (*s == c)
			break;
  801500:	90                   	nop
	return (char *) s;
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
  80150f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801512:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801516:	76 63                	jbe    80157b <memset+0x75>
		uint64 data_block = c;
  801518:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151b:	99                   	cltd   
  80151c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80151f:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801522:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801525:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801528:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  80152c:	c1 e0 08             	shl    $0x8,%eax
  80152f:	09 45 f0             	or     %eax,-0x10(%ebp)
  801532:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801535:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801538:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80153b:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  80153f:	c1 e0 10             	shl    $0x10,%eax
  801542:	09 45 f0             	or     %eax,-0x10(%ebp)
  801545:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801548:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80154b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154e:	89 c2                	mov    %eax,%edx
  801550:	b8 00 00 00 00       	mov    $0x0,%eax
  801555:	09 45 f0             	or     %eax,-0x10(%ebp)
  801558:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80155b:	eb 18                	jmp    801575 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  80155d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801560:	8d 41 08             	lea    0x8(%ecx),%eax
  801563:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801566:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801569:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80156c:	89 01                	mov    %eax,(%ecx)
  80156e:	89 51 04             	mov    %edx,0x4(%ecx)
  801571:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801575:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801579:	77 e2                	ja     80155d <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80157b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157f:	74 23                	je     8015a4 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801581:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801584:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801587:	eb 0e                	jmp    801597 <memset+0x91>
			*p8++ = (uint8)c;
  801589:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158c:	8d 50 01             	lea    0x1(%eax),%edx
  80158f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801592:	8b 55 0c             	mov    0xc(%ebp),%edx
  801595:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801597:	8b 45 10             	mov    0x10(%ebp),%eax
  80159a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80159d:	89 55 10             	mov    %edx,0x10(%ebp)
  8015a0:	85 c0                	test   %eax,%eax
  8015a2:	75 e5                	jne    801589 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8015b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8015bb:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015bf:	76 24                	jbe    8015e5 <memcpy+0x3c>
		while(n >= 8){
  8015c1:	eb 1c                	jmp    8015df <memcpy+0x36>
			*d64 = *s64;
  8015c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c6:	8b 50 04             	mov    0x4(%eax),%edx
  8015c9:	8b 00                	mov    (%eax),%eax
  8015cb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015ce:	89 01                	mov    %eax,(%ecx)
  8015d0:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8015d3:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8015d7:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8015db:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8015df:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8015e3:	77 de                	ja     8015c3 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8015e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015e9:	74 31                	je     80161c <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8015eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8015f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8015f7:	eb 16                	jmp    80160f <memcpy+0x66>
			*d8++ = *s8++;
  8015f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015fc:	8d 50 01             	lea    0x1(%eax),%edx
  8015ff:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801602:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801605:	8d 4a 01             	lea    0x1(%edx),%ecx
  801608:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80160b:	8a 12                	mov    (%edx),%dl
  80160d:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80160f:	8b 45 10             	mov    0x10(%ebp),%eax
  801612:	8d 50 ff             	lea    -0x1(%eax),%edx
  801615:	89 55 10             	mov    %edx,0x10(%ebp)
  801618:	85 c0                	test   %eax,%eax
  80161a:	75 dd                	jne    8015f9 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80161c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
  801624:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801627:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801636:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801639:	73 50                	jae    80168b <memmove+0x6a>
  80163b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163e:	8b 45 10             	mov    0x10(%ebp),%eax
  801641:	01 d0                	add    %edx,%eax
  801643:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801646:	76 43                	jbe    80168b <memmove+0x6a>
		s += n;
  801648:	8b 45 10             	mov    0x10(%ebp),%eax
  80164b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80164e:	8b 45 10             	mov    0x10(%ebp),%eax
  801651:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801654:	eb 10                	jmp    801666 <memmove+0x45>
			*--d = *--s;
  801656:	ff 4d f8             	decl   -0x8(%ebp)
  801659:	ff 4d fc             	decl   -0x4(%ebp)
  80165c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80165f:	8a 10                	mov    (%eax),%dl
  801661:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801664:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801666:	8b 45 10             	mov    0x10(%ebp),%eax
  801669:	8d 50 ff             	lea    -0x1(%eax),%edx
  80166c:	89 55 10             	mov    %edx,0x10(%ebp)
  80166f:	85 c0                	test   %eax,%eax
  801671:	75 e3                	jne    801656 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801673:	eb 23                	jmp    801698 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801675:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801678:	8d 50 01             	lea    0x1(%eax),%edx
  80167b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80167e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801681:	8d 4a 01             	lea    0x1(%edx),%ecx
  801684:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801687:	8a 12                	mov    (%edx),%dl
  801689:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801691:	89 55 10             	mov    %edx,0x10(%ebp)
  801694:	85 c0                	test   %eax,%eax
  801696:	75 dd                	jne    801675 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
  8016a0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ac:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016af:	eb 2a                	jmp    8016db <memcmp+0x3e>
		if (*s1 != *s2)
  8016b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b4:	8a 10                	mov    (%eax),%dl
  8016b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	38 c2                	cmp    %al,%dl
  8016bd:	74 16                	je     8016d5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	0f b6 d0             	movzbl %al,%edx
  8016c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ca:	8a 00                	mov    (%eax),%al
  8016cc:	0f b6 c0             	movzbl %al,%eax
  8016cf:	29 c2                	sub    %eax,%edx
  8016d1:	89 d0                	mov    %edx,%eax
  8016d3:	eb 18                	jmp    8016ed <memcmp+0x50>
		s1++, s2++;
  8016d5:	ff 45 fc             	incl   -0x4(%ebp)
  8016d8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8016db:	8b 45 10             	mov    0x10(%ebp),%eax
  8016de:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8016e4:	85 c0                	test   %eax,%eax
  8016e6:	75 c9                	jne    8016b1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8016e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016ed:	c9                   	leave  
  8016ee:	c3                   	ret    

008016ef <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
  8016f2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8016f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8016f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fb:	01 d0                	add    %edx,%eax
  8016fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801700:	eb 15                	jmp    801717 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	0f b6 d0             	movzbl %al,%edx
  80170a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170d:	0f b6 c0             	movzbl %al,%eax
  801710:	39 c2                	cmp    %eax,%edx
  801712:	74 0d                	je     801721 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801714:	ff 45 08             	incl   0x8(%ebp)
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80171d:	72 e3                	jb     801702 <memfind+0x13>
  80171f:	eb 01                	jmp    801722 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801721:	90                   	nop
	return (void *) s;
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
  80172a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80172d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801734:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80173b:	eb 03                	jmp    801740 <strtol+0x19>
		s++;
  80173d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	8a 00                	mov    (%eax),%al
  801745:	3c 20                	cmp    $0x20,%al
  801747:	74 f4                	je     80173d <strtol+0x16>
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	8a 00                	mov    (%eax),%al
  80174e:	3c 09                	cmp    $0x9,%al
  801750:	74 eb                	je     80173d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	3c 2b                	cmp    $0x2b,%al
  801759:	75 05                	jne    801760 <strtol+0x39>
		s++;
  80175b:	ff 45 08             	incl   0x8(%ebp)
  80175e:	eb 13                	jmp    801773 <strtol+0x4c>
	else if (*s == '-')
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	3c 2d                	cmp    $0x2d,%al
  801767:	75 0a                	jne    801773 <strtol+0x4c>
		s++, neg = 1;
  801769:	ff 45 08             	incl   0x8(%ebp)
  80176c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801773:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801777:	74 06                	je     80177f <strtol+0x58>
  801779:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80177d:	75 20                	jne    80179f <strtol+0x78>
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	3c 30                	cmp    $0x30,%al
  801786:	75 17                	jne    80179f <strtol+0x78>
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	40                   	inc    %eax
  80178c:	8a 00                	mov    (%eax),%al
  80178e:	3c 78                	cmp    $0x78,%al
  801790:	75 0d                	jne    80179f <strtol+0x78>
		s += 2, base = 16;
  801792:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801796:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80179d:	eb 28                	jmp    8017c7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80179f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a3:	75 15                	jne    8017ba <strtol+0x93>
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	3c 30                	cmp    $0x30,%al
  8017ac:	75 0c                	jne    8017ba <strtol+0x93>
		s++, base = 8;
  8017ae:	ff 45 08             	incl   0x8(%ebp)
  8017b1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017b8:	eb 0d                	jmp    8017c7 <strtol+0xa0>
	else if (base == 0)
  8017ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017be:	75 07                	jne    8017c7 <strtol+0xa0>
		base = 10;
  8017c0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ca:	8a 00                	mov    (%eax),%al
  8017cc:	3c 2f                	cmp    $0x2f,%al
  8017ce:	7e 19                	jle    8017e9 <strtol+0xc2>
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	8a 00                	mov    (%eax),%al
  8017d5:	3c 39                	cmp    $0x39,%al
  8017d7:	7f 10                	jg     8017e9 <strtol+0xc2>
			dig = *s - '0';
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	8a 00                	mov    (%eax),%al
  8017de:	0f be c0             	movsbl %al,%eax
  8017e1:	83 e8 30             	sub    $0x30,%eax
  8017e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8017e7:	eb 42                	jmp    80182b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	8a 00                	mov    (%eax),%al
  8017ee:	3c 60                	cmp    $0x60,%al
  8017f0:	7e 19                	jle    80180b <strtol+0xe4>
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	8a 00                	mov    (%eax),%al
  8017f7:	3c 7a                	cmp    $0x7a,%al
  8017f9:	7f 10                	jg     80180b <strtol+0xe4>
			dig = *s - 'a' + 10;
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	8a 00                	mov    (%eax),%al
  801800:	0f be c0             	movsbl %al,%eax
  801803:	83 e8 57             	sub    $0x57,%eax
  801806:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801809:	eb 20                	jmp    80182b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	8a 00                	mov    (%eax),%al
  801810:	3c 40                	cmp    $0x40,%al
  801812:	7e 39                	jle    80184d <strtol+0x126>
  801814:	8b 45 08             	mov    0x8(%ebp),%eax
  801817:	8a 00                	mov    (%eax),%al
  801819:	3c 5a                	cmp    $0x5a,%al
  80181b:	7f 30                	jg     80184d <strtol+0x126>
			dig = *s - 'A' + 10;
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	8a 00                	mov    (%eax),%al
  801822:	0f be c0             	movsbl %al,%eax
  801825:	83 e8 37             	sub    $0x37,%eax
  801828:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801831:	7d 19                	jge    80184c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801833:	ff 45 08             	incl   0x8(%ebp)
  801836:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801839:	0f af 45 10          	imul   0x10(%ebp),%eax
  80183d:	89 c2                	mov    %eax,%edx
  80183f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801842:	01 d0                	add    %edx,%eax
  801844:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801847:	e9 7b ff ff ff       	jmp    8017c7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80184c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80184d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801851:	74 08                	je     80185b <strtol+0x134>
		*endptr = (char *) s;
  801853:	8b 45 0c             	mov    0xc(%ebp),%eax
  801856:	8b 55 08             	mov    0x8(%ebp),%edx
  801859:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80185b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80185f:	74 07                	je     801868 <strtol+0x141>
  801861:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801864:	f7 d8                	neg    %eax
  801866:	eb 03                	jmp    80186b <strtol+0x144>
  801868:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <ltostr>:

void
ltostr(long value, char *str)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
  801870:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801873:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80187a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801881:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801885:	79 13                	jns    80189a <ltostr+0x2d>
	{
		neg = 1;
  801887:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80188e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801891:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801894:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801897:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80189a:	8b 45 08             	mov    0x8(%ebp),%eax
  80189d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018a2:	99                   	cltd   
  8018a3:	f7 f9                	idiv   %ecx
  8018a5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ab:	8d 50 01             	lea    0x1(%eax),%edx
  8018ae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018b1:	89 c2                	mov    %eax,%edx
  8018b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b6:	01 d0                	add    %edx,%eax
  8018b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018bb:	83 c2 30             	add    $0x30,%edx
  8018be:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018c3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018c8:	f7 e9                	imul   %ecx
  8018ca:	c1 fa 02             	sar    $0x2,%edx
  8018cd:	89 c8                	mov    %ecx,%eax
  8018cf:	c1 f8 1f             	sar    $0x1f,%eax
  8018d2:	29 c2                	sub    %eax,%edx
  8018d4:	89 d0                	mov    %edx,%eax
  8018d6:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8018d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018dd:	75 bb                	jne    80189a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8018df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8018e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e9:	48                   	dec    %eax
  8018ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8018ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018f1:	74 3d                	je     801930 <ltostr+0xc3>
		start = 1 ;
  8018f3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8018fa:	eb 34                	jmp    801930 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8018fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801902:	01 d0                	add    %edx,%eax
  801904:	8a 00                	mov    (%eax),%al
  801906:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801909:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80190c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80190f:	01 c2                	add    %eax,%edx
  801911:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801914:	8b 45 0c             	mov    0xc(%ebp),%eax
  801917:	01 c8                	add    %ecx,%eax
  801919:	8a 00                	mov    (%eax),%al
  80191b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80191d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801920:	8b 45 0c             	mov    0xc(%ebp),%eax
  801923:	01 c2                	add    %eax,%edx
  801925:	8a 45 eb             	mov    -0x15(%ebp),%al
  801928:	88 02                	mov    %al,(%edx)
		start++ ;
  80192a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80192d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801930:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801933:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801936:	7c c4                	jl     8018fc <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801938:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80193b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193e:	01 d0                	add    %edx,%eax
  801940:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801943:	90                   	nop
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
  801949:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80194c:	ff 75 08             	pushl  0x8(%ebp)
  80194f:	e8 c4 f9 ff ff       	call   801318 <strlen>
  801954:	83 c4 04             	add    $0x4,%esp
  801957:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80195a:	ff 75 0c             	pushl  0xc(%ebp)
  80195d:	e8 b6 f9 ff ff       	call   801318 <strlen>
  801962:	83 c4 04             	add    $0x4,%esp
  801965:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801968:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80196f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801976:	eb 17                	jmp    80198f <strcconcat+0x49>
		final[s] = str1[s] ;
  801978:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80197b:	8b 45 10             	mov    0x10(%ebp),%eax
  80197e:	01 c2                	add    %eax,%edx
  801980:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801983:	8b 45 08             	mov    0x8(%ebp),%eax
  801986:	01 c8                	add    %ecx,%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80198c:	ff 45 fc             	incl   -0x4(%ebp)
  80198f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801992:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801995:	7c e1                	jl     801978 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801997:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80199e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019a5:	eb 1f                	jmp    8019c6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019aa:	8d 50 01             	lea    0x1(%eax),%edx
  8019ad:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019b0:	89 c2                	mov    %eax,%edx
  8019b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b5:	01 c2                	add    %eax,%edx
  8019b7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bd:	01 c8                	add    %ecx,%eax
  8019bf:	8a 00                	mov    (%eax),%al
  8019c1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8019c3:	ff 45 f8             	incl   -0x8(%ebp)
  8019c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019cc:	7c d9                	jl     8019a7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d4:	01 d0                	add    %edx,%eax
  8019d6:	c6 00 00             	movb   $0x0,(%eax)
}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8019df:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8019e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8019eb:	8b 00                	mov    (%eax),%eax
  8019ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f7:	01 d0                	add    %edx,%eax
  8019f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019ff:	eb 0c                	jmp    801a0d <strsplit+0x31>
			*string++ = 0;
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	8d 50 01             	lea    0x1(%eax),%edx
  801a07:	89 55 08             	mov    %edx,0x8(%ebp)
  801a0a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	8a 00                	mov    (%eax),%al
  801a12:	84 c0                	test   %al,%al
  801a14:	74 18                	je     801a2e <strsplit+0x52>
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	8a 00                	mov    (%eax),%al
  801a1b:	0f be c0             	movsbl %al,%eax
  801a1e:	50                   	push   %eax
  801a1f:	ff 75 0c             	pushl  0xc(%ebp)
  801a22:	e8 83 fa ff ff       	call   8014aa <strchr>
  801a27:	83 c4 08             	add    $0x8,%esp
  801a2a:	85 c0                	test   %eax,%eax
  801a2c:	75 d3                	jne    801a01 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a31:	8a 00                	mov    (%eax),%al
  801a33:	84 c0                	test   %al,%al
  801a35:	74 5a                	je     801a91 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a37:	8b 45 14             	mov    0x14(%ebp),%eax
  801a3a:	8b 00                	mov    (%eax),%eax
  801a3c:	83 f8 0f             	cmp    $0xf,%eax
  801a3f:	75 07                	jne    801a48 <strsplit+0x6c>
		{
			return 0;
  801a41:	b8 00 00 00 00       	mov    $0x0,%eax
  801a46:	eb 66                	jmp    801aae <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a48:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4b:	8b 00                	mov    (%eax),%eax
  801a4d:	8d 48 01             	lea    0x1(%eax),%ecx
  801a50:	8b 55 14             	mov    0x14(%ebp),%edx
  801a53:	89 0a                	mov    %ecx,(%edx)
  801a55:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a5c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5f:	01 c2                	add    %eax,%edx
  801a61:	8b 45 08             	mov    0x8(%ebp),%eax
  801a64:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a66:	eb 03                	jmp    801a6b <strsplit+0x8f>
			string++;
  801a68:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6e:	8a 00                	mov    (%eax),%al
  801a70:	84 c0                	test   %al,%al
  801a72:	74 8b                	je     8019ff <strsplit+0x23>
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	8a 00                	mov    (%eax),%al
  801a79:	0f be c0             	movsbl %al,%eax
  801a7c:	50                   	push   %eax
  801a7d:	ff 75 0c             	pushl  0xc(%ebp)
  801a80:	e8 25 fa ff ff       	call   8014aa <strchr>
  801a85:	83 c4 08             	add    $0x8,%esp
  801a88:	85 c0                	test   %eax,%eax
  801a8a:	74 dc                	je     801a68 <strsplit+0x8c>
			string++;
	}
  801a8c:	e9 6e ff ff ff       	jmp    8019ff <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a91:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a92:	8b 45 14             	mov    0x14(%ebp),%eax
  801a95:	8b 00                	mov    (%eax),%eax
  801a97:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a9e:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa1:	01 d0                	add    %edx,%eax
  801aa3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801aa9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801aae:	c9                   	leave  
  801aaf:	c3                   	ret    

00801ab0 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801abc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ac3:	eb 4a                	jmp    801b0f <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801ac5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  801acb:	01 c2                	add    %eax,%edx
  801acd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad3:	01 c8                	add    %ecx,%eax
  801ad5:	8a 00                	mov    (%eax),%al
  801ad7:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801ad9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801adc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801adf:	01 d0                	add    %edx,%eax
  801ae1:	8a 00                	mov    (%eax),%al
  801ae3:	3c 40                	cmp    $0x40,%al
  801ae5:	7e 25                	jle    801b0c <str2lower+0x5c>
  801ae7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aed:	01 d0                	add    %edx,%eax
  801aef:	8a 00                	mov    (%eax),%al
  801af1:	3c 5a                	cmp    $0x5a,%al
  801af3:	7f 17                	jg     801b0c <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801af5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801af8:	8b 45 08             	mov    0x8(%ebp),%eax
  801afb:	01 d0                	add    %edx,%eax
  801afd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b00:	8b 55 08             	mov    0x8(%ebp),%edx
  801b03:	01 ca                	add    %ecx,%edx
  801b05:	8a 12                	mov    (%edx),%dl
  801b07:	83 c2 20             	add    $0x20,%edx
  801b0a:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801b0c:	ff 45 fc             	incl   -0x4(%ebp)
  801b0f:	ff 75 0c             	pushl  0xc(%ebp)
  801b12:	e8 01 f8 ff ff       	call   801318 <strlen>
  801b17:	83 c4 04             	add    $0x4,%esp
  801b1a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b1d:	7f a6                	jg     801ac5 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801b1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	57                   	push   %edi
  801b28:	56                   	push   %esi
  801b29:	53                   	push   %ebx
  801b2a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b33:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b36:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b39:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b3c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b3f:	cd 30                	int    $0x30
  801b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b44:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b47:	83 c4 10             	add    $0x10,%esp
  801b4a:	5b                   	pop    %ebx
  801b4b:	5e                   	pop    %esi
  801b4c:	5f                   	pop    %edi
  801b4d:	5d                   	pop    %ebp
  801b4e:	c3                   	ret    

00801b4f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
  801b52:	83 ec 04             	sub    $0x4,%esp
  801b55:	8b 45 10             	mov    0x10(%ebp),%eax
  801b58:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801b5b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b5e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	6a 00                	push   $0x0
  801b67:	51                   	push   %ecx
  801b68:	52                   	push   %edx
  801b69:	ff 75 0c             	pushl  0xc(%ebp)
  801b6c:	50                   	push   %eax
  801b6d:	6a 00                	push   $0x0
  801b6f:	e8 b0 ff ff ff       	call   801b24 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	90                   	nop
  801b78:	c9                   	leave  
  801b79:	c3                   	ret    

00801b7a <sys_cgetc>:

int
sys_cgetc(void)
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 02                	push   $0x2
  801b89:	e8 96 ff ff ff       	call   801b24 <syscall>
  801b8e:	83 c4 18             	add    $0x18,%esp
}
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 03                	push   $0x3
  801ba2:	e8 7d ff ff ff       	call   801b24 <syscall>
  801ba7:	83 c4 18             	add    $0x18,%esp
}
  801baa:	90                   	nop
  801bab:	c9                   	leave  
  801bac:	c3                   	ret    

00801bad <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 04                	push   $0x4
  801bbc:	e8 63 ff ff ff       	call   801b24 <syscall>
  801bc1:	83 c4 18             	add    $0x18,%esp
}
  801bc4:	90                   	nop
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bca:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	52                   	push   %edx
  801bd7:	50                   	push   %eax
  801bd8:	6a 08                	push   $0x8
  801bda:	e8 45 ff ff ff       	call   801b24 <syscall>
  801bdf:	83 c4 18             	add    $0x18,%esp
}
  801be2:	c9                   	leave  
  801be3:	c3                   	ret    

00801be4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
  801be7:	56                   	push   %esi
  801be8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801be9:	8b 75 18             	mov    0x18(%ebp),%esi
  801bec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf8:	56                   	push   %esi
  801bf9:	53                   	push   %ebx
  801bfa:	51                   	push   %ecx
  801bfb:	52                   	push   %edx
  801bfc:	50                   	push   %eax
  801bfd:	6a 09                	push   $0x9
  801bff:	e8 20 ff ff ff       	call   801b24 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
}
  801c07:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c0a:	5b                   	pop    %ebx
  801c0b:	5e                   	pop    %esi
  801c0c:	5d                   	pop    %ebp
  801c0d:	c3                   	ret    

00801c0e <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	ff 75 08             	pushl  0x8(%ebp)
  801c1c:	6a 0a                	push   $0xa
  801c1e:	e8 01 ff ff ff       	call   801b24 <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	ff 75 0c             	pushl  0xc(%ebp)
  801c34:	ff 75 08             	pushl  0x8(%ebp)
  801c37:	6a 0b                	push   $0xb
  801c39:	e8 e6 fe ff ff       	call   801b24 <syscall>
  801c3e:	83 c4 18             	add    $0x18,%esp
}
  801c41:	c9                   	leave  
  801c42:	c3                   	ret    

00801c43 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 0c                	push   $0xc
  801c52:	e8 cd fe ff ff       	call   801b24 <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
}
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 0d                	push   $0xd
  801c6b:	e8 b4 fe ff ff       	call   801b24 <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 0e                	push   $0xe
  801c84:	e8 9b fe ff ff       	call   801b24 <syscall>
  801c89:	83 c4 18             	add    $0x18,%esp
}
  801c8c:	c9                   	leave  
  801c8d:	c3                   	ret    

00801c8e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 0f                	push   $0xf
  801c9d:	e8 82 fe ff ff       	call   801b24 <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
}
  801ca5:	c9                   	leave  
  801ca6:	c3                   	ret    

00801ca7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	ff 75 08             	pushl  0x8(%ebp)
  801cb5:	6a 10                	push   $0x10
  801cb7:	e8 68 fe ff ff       	call   801b24 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 11                	push   $0x11
  801cd0:	e8 4f fe ff ff       	call   801b24 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	90                   	nop
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_cputc>:

void
sys_cputc(const char c)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
  801cde:	83 ec 04             	sub    $0x4,%esp
  801ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ce7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	50                   	push   %eax
  801cf4:	6a 01                	push   $0x1
  801cf6:	e8 29 fe ff ff       	call   801b24 <syscall>
  801cfb:	83 c4 18             	add    $0x18,%esp
}
  801cfe:	90                   	nop
  801cff:	c9                   	leave  
  801d00:	c3                   	ret    

00801d01 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d01:	55                   	push   %ebp
  801d02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 14                	push   $0x14
  801d10:	e8 0f fe ff ff       	call   801b24 <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
}
  801d18:	90                   	nop
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
  801d1e:	83 ec 04             	sub    $0x4,%esp
  801d21:	8b 45 10             	mov    0x10(%ebp),%eax
  801d24:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801d27:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d2a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d31:	6a 00                	push   $0x0
  801d33:	51                   	push   %ecx
  801d34:	52                   	push   %edx
  801d35:	ff 75 0c             	pushl  0xc(%ebp)
  801d38:	50                   	push   %eax
  801d39:	6a 15                	push   $0x15
  801d3b:	e8 e4 fd ff ff       	call   801b24 <syscall>
  801d40:	83 c4 18             	add    $0x18,%esp
}
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801d48:	8b 55 10             	mov    0x10(%ebp),%edx
  801d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	52                   	push   %edx
  801d53:	50                   	push   %eax
  801d54:	ff 75 08             	pushl  0x8(%ebp)
  801d57:	6a 16                	push   $0x16
  801d59:	e8 c6 fd ff ff       	call   801b24 <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d69:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	52                   	push   %edx
  801d73:	50                   	push   %eax
  801d74:	6a 17                	push   $0x17
  801d76:	e8 a9 fd ff ff       	call   801b24 <syscall>
  801d7b:	83 c4 18             	add    $0x18,%esp
}
  801d7e:	c9                   	leave  
  801d7f:	c3                   	ret    

00801d80 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801d80:	55                   	push   %ebp
  801d81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801d83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d86:	8b 45 08             	mov    0x8(%ebp),%eax
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	52                   	push   %edx
  801d90:	50                   	push   %eax
  801d91:	6a 18                	push   $0x18
  801d93:	e8 8c fd ff ff       	call   801b24 <syscall>
  801d98:	83 c4 18             	add    $0x18,%esp
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801da0:	8b 45 08             	mov    0x8(%ebp),%eax
  801da3:	6a 00                	push   $0x0
  801da5:	ff 75 14             	pushl  0x14(%ebp)
  801da8:	ff 75 10             	pushl  0x10(%ebp)
  801dab:	ff 75 0c             	pushl  0xc(%ebp)
  801dae:	50                   	push   %eax
  801daf:	6a 19                	push   $0x19
  801db1:	e8 6e fd ff ff       	call   801b24 <syscall>
  801db6:	83 c4 18             	add    $0x18,%esp
}
  801db9:	c9                   	leave  
  801dba:	c3                   	ret    

00801dbb <sys_run_env>:

void sys_run_env(int32 envId)
{
  801dbb:	55                   	push   %ebp
  801dbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	50                   	push   %eax
  801dca:	6a 1a                	push   $0x1a
  801dcc:	e8 53 fd ff ff       	call   801b24 <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
}
  801dd4:	90                   	nop
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801dda:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	50                   	push   %eax
  801de6:	6a 1b                	push   $0x1b
  801de8:	e8 37 fd ff ff       	call   801b24 <syscall>
  801ded:	83 c4 18             	add    $0x18,%esp
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 05                	push   $0x5
  801e01:	e8 1e fd ff ff       	call   801b24 <syscall>
  801e06:	83 c4 18             	add    $0x18,%esp
}
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    

00801e0b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 06                	push   $0x6
  801e1a:	e8 05 fd ff ff       	call   801b24 <syscall>
  801e1f:	83 c4 18             	add    $0x18,%esp
}
  801e22:	c9                   	leave  
  801e23:	c3                   	ret    

00801e24 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e24:	55                   	push   %ebp
  801e25:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 07                	push   $0x7
  801e33:	e8 ec fc ff ff       	call   801b24 <syscall>
  801e38:	83 c4 18             	add    $0x18,%esp
}
  801e3b:	c9                   	leave  
  801e3c:	c3                   	ret    

00801e3d <sys_exit_env>:


void sys_exit_env(void)
{
  801e3d:	55                   	push   %ebp
  801e3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 1c                	push   $0x1c
  801e4c:	e8 d3 fc ff ff       	call   801b24 <syscall>
  801e51:	83 c4 18             	add    $0x18,%esp
}
  801e54:	90                   	nop
  801e55:	c9                   	leave  
  801e56:	c3                   	ret    

00801e57 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	ff 75 10             	pushl  0x10(%ebp)
  801e61:	ff 75 0c             	pushl  0xc(%ebp)
  801e64:	ff 75 08             	pushl  0x8(%ebp)
  801e67:	6a 13                	push   $0x13
  801e69:	e8 b6 fc ff ff       	call   801b24 <syscall>
  801e6e:	83 c4 18             	add    $0x18,%esp
	return ;
  801e71:	90                   	nop
}
  801e72:	c9                   	leave  
  801e73:	c3                   	ret    

00801e74 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e74:	55                   	push   %ebp
  801e75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 1e                	push   $0x1e
  801e83:	e8 9c fc ff ff       	call   801b24 <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
  801e90:	83 ec 04             	sub    $0x4,%esp
  801e93:	8b 45 08             	mov    0x8(%ebp),%eax
  801e96:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e99:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	50                   	push   %eax
  801ea6:	6a 1f                	push   $0x1f
  801ea8:	e8 77 fc ff ff       	call   801b24 <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb0:	90                   	nop
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <rsttst>:
void rsttst()
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 21                	push   $0x21
  801ec2:	e8 5d fc ff ff       	call   801b24 <syscall>
  801ec7:	83 c4 18             	add    $0x18,%esp
	return ;
  801eca:	90                   	nop
}
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
  801ed0:	83 ec 04             	sub    $0x4,%esp
  801ed3:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ed9:	8b 55 18             	mov    0x18(%ebp),%edx
  801edc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ee0:	52                   	push   %edx
  801ee1:	50                   	push   %eax
  801ee2:	ff 75 10             	pushl  0x10(%ebp)
  801ee5:	ff 75 0c             	pushl  0xc(%ebp)
  801ee8:	ff 75 08             	pushl  0x8(%ebp)
  801eeb:	6a 20                	push   $0x20
  801eed:	e8 32 fc ff ff       	call   801b24 <syscall>
  801ef2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef5:	90                   	nop
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <chktst>:
void chktst(uint32 n)
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	ff 75 08             	pushl  0x8(%ebp)
  801f06:	6a 22                	push   $0x22
  801f08:	e8 17 fc ff ff       	call   801b24 <syscall>
  801f0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f10:	90                   	nop
}
  801f11:	c9                   	leave  
  801f12:	c3                   	ret    

00801f13 <inctst>:

void inctst()
{
  801f13:	55                   	push   %ebp
  801f14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 23                	push   $0x23
  801f22:	e8 fd fb ff ff       	call   801b24 <syscall>
  801f27:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2a:	90                   	nop
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <gettst>:
uint32 gettst()
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 24                	push   $0x24
  801f3c:	e8 e3 fb ff ff       	call   801b24 <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 25                	push   $0x25
  801f55:	e8 ca fb ff ff       	call   801b24 <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
  801f5d:	a3 48 c0 50 04       	mov    %eax,0x450c048
	return uheapPlaceStrategy ;
  801f62:	a1 48 c0 50 04       	mov    0x450c048,%eax
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6f:	a3 48 c0 50 04       	mov    %eax,0x450c048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	ff 75 08             	pushl  0x8(%ebp)
  801f7f:	6a 26                	push   $0x26
  801f81:	e8 9e fb ff ff       	call   801b24 <syscall>
  801f86:	83 c4 18             	add    $0x18,%esp
	return ;
  801f89:	90                   	nop
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f90:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f93:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f99:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9c:	6a 00                	push   $0x0
  801f9e:	53                   	push   %ebx
  801f9f:	51                   	push   %ecx
  801fa0:	52                   	push   %edx
  801fa1:	50                   	push   %eax
  801fa2:	6a 27                	push   $0x27
  801fa4:	e8 7b fb ff ff       	call   801b24 <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
}
  801fac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801faf:	c9                   	leave  
  801fb0:	c3                   	ret    

00801fb1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801fb1:	55                   	push   %ebp
  801fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	52                   	push   %edx
  801fc1:	50                   	push   %eax
  801fc2:	6a 28                	push   $0x28
  801fc4:	e8 5b fb ff ff       	call   801b24 <syscall>
  801fc9:	83 c4 18             	add    $0x18,%esp
}
  801fcc:	c9                   	leave  
  801fcd:	c3                   	ret    

00801fce <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801fce:	55                   	push   %ebp
  801fcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801fd1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fda:	6a 00                	push   $0x0
  801fdc:	51                   	push   %ecx
  801fdd:	ff 75 10             	pushl  0x10(%ebp)
  801fe0:	52                   	push   %edx
  801fe1:	50                   	push   %eax
  801fe2:	6a 29                	push   $0x29
  801fe4:	e8 3b fb ff ff       	call   801b24 <syscall>
  801fe9:	83 c4 18             	add    $0x18,%esp
}
  801fec:	c9                   	leave  
  801fed:	c3                   	ret    

00801fee <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801fee:	55                   	push   %ebp
  801fef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	ff 75 10             	pushl  0x10(%ebp)
  801ff8:	ff 75 0c             	pushl  0xc(%ebp)
  801ffb:	ff 75 08             	pushl  0x8(%ebp)
  801ffe:	6a 12                	push   $0x12
  802000:	e8 1f fb ff ff       	call   801b24 <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
	return ;
  802008:	90                   	nop
}
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80200e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802011:	8b 45 08             	mov    0x8(%ebp),%eax
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	52                   	push   %edx
  80201b:	50                   	push   %eax
  80201c:	6a 2a                	push   $0x2a
  80201e:	e8 01 fb ff ff       	call   801b24 <syscall>
  802023:	83 c4 18             	add    $0x18,%esp
	return;
  802026:	90                   	nop
}
  802027:	c9                   	leave  
  802028:	c3                   	ret    

00802029 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802029:	55                   	push   %ebp
  80202a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 2b                	push   $0x2b
  802038:	e8 e7 fa ff ff       	call   801b24 <syscall>
  80203d:	83 c4 18             	add    $0x18,%esp
}
  802040:	c9                   	leave  
  802041:	c3                   	ret    

00802042 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  802042:	55                   	push   %ebp
  802043:	89 e5                	mov    %esp,%ebp
  802045:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802048:	83 ec 04             	sub    $0x4,%esp
  80204b:	68 c8 2b 80 00       	push   $0x802bc8
  802050:	68 0a 01 00 00       	push   $0x10a
  802055:	68 d8 2b 80 00       	push   $0x802bd8
  80205a:	e8 12 e9 ff ff       	call   800971 <_panic>

0080205f <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80205f:	55                   	push   %ebp
  802060:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	ff 75 0c             	pushl  0xc(%ebp)
  80206b:	ff 75 08             	pushl  0x8(%ebp)
  80206e:	6a 33                	push   $0x33
  802070:	e8 af fa ff ff       	call   801b24 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
	return;
  802078:	90                   	nop
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	ff 75 0c             	pushl  0xc(%ebp)
  802087:	ff 75 08             	pushl  0x8(%ebp)
  80208a:	6a 34                	push   $0x34
  80208c:	e8 93 fa ff ff       	call   801b24 <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
	return ;
  802094:	90                   	nop
}
  802095:	c9                   	leave  
  802096:	c3                   	ret    
  802097:	90                   	nop

00802098 <__udivdi3>:
  802098:	55                   	push   %ebp
  802099:	57                   	push   %edi
  80209a:	56                   	push   %esi
  80209b:	53                   	push   %ebx
  80209c:	83 ec 1c             	sub    $0x1c,%esp
  80209f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020af:	89 ca                	mov    %ecx,%edx
  8020b1:	89 f8                	mov    %edi,%eax
  8020b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020b7:	85 f6                	test   %esi,%esi
  8020b9:	75 2d                	jne    8020e8 <__udivdi3+0x50>
  8020bb:	39 cf                	cmp    %ecx,%edi
  8020bd:	77 65                	ja     802124 <__udivdi3+0x8c>
  8020bf:	89 fd                	mov    %edi,%ebp
  8020c1:	85 ff                	test   %edi,%edi
  8020c3:	75 0b                	jne    8020d0 <__udivdi3+0x38>
  8020c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ca:	31 d2                	xor    %edx,%edx
  8020cc:	f7 f7                	div    %edi
  8020ce:	89 c5                	mov    %eax,%ebp
  8020d0:	31 d2                	xor    %edx,%edx
  8020d2:	89 c8                	mov    %ecx,%eax
  8020d4:	f7 f5                	div    %ebp
  8020d6:	89 c1                	mov    %eax,%ecx
  8020d8:	89 d8                	mov    %ebx,%eax
  8020da:	f7 f5                	div    %ebp
  8020dc:	89 cf                	mov    %ecx,%edi
  8020de:	89 fa                	mov    %edi,%edx
  8020e0:	83 c4 1c             	add    $0x1c,%esp
  8020e3:	5b                   	pop    %ebx
  8020e4:	5e                   	pop    %esi
  8020e5:	5f                   	pop    %edi
  8020e6:	5d                   	pop    %ebp
  8020e7:	c3                   	ret    
  8020e8:	39 ce                	cmp    %ecx,%esi
  8020ea:	77 28                	ja     802114 <__udivdi3+0x7c>
  8020ec:	0f bd fe             	bsr    %esi,%edi
  8020ef:	83 f7 1f             	xor    $0x1f,%edi
  8020f2:	75 40                	jne    802134 <__udivdi3+0x9c>
  8020f4:	39 ce                	cmp    %ecx,%esi
  8020f6:	72 0a                	jb     802102 <__udivdi3+0x6a>
  8020f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020fc:	0f 87 9e 00 00 00    	ja     8021a0 <__udivdi3+0x108>
  802102:	b8 01 00 00 00       	mov    $0x1,%eax
  802107:	89 fa                	mov    %edi,%edx
  802109:	83 c4 1c             	add    $0x1c,%esp
  80210c:	5b                   	pop    %ebx
  80210d:	5e                   	pop    %esi
  80210e:	5f                   	pop    %edi
  80210f:	5d                   	pop    %ebp
  802110:	c3                   	ret    
  802111:	8d 76 00             	lea    0x0(%esi),%esi
  802114:	31 ff                	xor    %edi,%edi
  802116:	31 c0                	xor    %eax,%eax
  802118:	89 fa                	mov    %edi,%edx
  80211a:	83 c4 1c             	add    $0x1c,%esp
  80211d:	5b                   	pop    %ebx
  80211e:	5e                   	pop    %esi
  80211f:	5f                   	pop    %edi
  802120:	5d                   	pop    %ebp
  802121:	c3                   	ret    
  802122:	66 90                	xchg   %ax,%ax
  802124:	89 d8                	mov    %ebx,%eax
  802126:	f7 f7                	div    %edi
  802128:	31 ff                	xor    %edi,%edi
  80212a:	89 fa                	mov    %edi,%edx
  80212c:	83 c4 1c             	add    $0x1c,%esp
  80212f:	5b                   	pop    %ebx
  802130:	5e                   	pop    %esi
  802131:	5f                   	pop    %edi
  802132:	5d                   	pop    %ebp
  802133:	c3                   	ret    
  802134:	bd 20 00 00 00       	mov    $0x20,%ebp
  802139:	89 eb                	mov    %ebp,%ebx
  80213b:	29 fb                	sub    %edi,%ebx
  80213d:	89 f9                	mov    %edi,%ecx
  80213f:	d3 e6                	shl    %cl,%esi
  802141:	89 c5                	mov    %eax,%ebp
  802143:	88 d9                	mov    %bl,%cl
  802145:	d3 ed                	shr    %cl,%ebp
  802147:	89 e9                	mov    %ebp,%ecx
  802149:	09 f1                	or     %esi,%ecx
  80214b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80214f:	89 f9                	mov    %edi,%ecx
  802151:	d3 e0                	shl    %cl,%eax
  802153:	89 c5                	mov    %eax,%ebp
  802155:	89 d6                	mov    %edx,%esi
  802157:	88 d9                	mov    %bl,%cl
  802159:	d3 ee                	shr    %cl,%esi
  80215b:	89 f9                	mov    %edi,%ecx
  80215d:	d3 e2                	shl    %cl,%edx
  80215f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802163:	88 d9                	mov    %bl,%cl
  802165:	d3 e8                	shr    %cl,%eax
  802167:	09 c2                	or     %eax,%edx
  802169:	89 d0                	mov    %edx,%eax
  80216b:	89 f2                	mov    %esi,%edx
  80216d:	f7 74 24 0c          	divl   0xc(%esp)
  802171:	89 d6                	mov    %edx,%esi
  802173:	89 c3                	mov    %eax,%ebx
  802175:	f7 e5                	mul    %ebp
  802177:	39 d6                	cmp    %edx,%esi
  802179:	72 19                	jb     802194 <__udivdi3+0xfc>
  80217b:	74 0b                	je     802188 <__udivdi3+0xf0>
  80217d:	89 d8                	mov    %ebx,%eax
  80217f:	31 ff                	xor    %edi,%edi
  802181:	e9 58 ff ff ff       	jmp    8020de <__udivdi3+0x46>
  802186:	66 90                	xchg   %ax,%ax
  802188:	8b 54 24 08          	mov    0x8(%esp),%edx
  80218c:	89 f9                	mov    %edi,%ecx
  80218e:	d3 e2                	shl    %cl,%edx
  802190:	39 c2                	cmp    %eax,%edx
  802192:	73 e9                	jae    80217d <__udivdi3+0xe5>
  802194:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802197:	31 ff                	xor    %edi,%edi
  802199:	e9 40 ff ff ff       	jmp    8020de <__udivdi3+0x46>
  80219e:	66 90                	xchg   %ax,%ax
  8021a0:	31 c0                	xor    %eax,%eax
  8021a2:	e9 37 ff ff ff       	jmp    8020de <__udivdi3+0x46>
  8021a7:	90                   	nop

008021a8 <__umoddi3>:
  8021a8:	55                   	push   %ebp
  8021a9:	57                   	push   %edi
  8021aa:	56                   	push   %esi
  8021ab:	53                   	push   %ebx
  8021ac:	83 ec 1c             	sub    $0x1c,%esp
  8021af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021c7:	89 f3                	mov    %esi,%ebx
  8021c9:	89 fa                	mov    %edi,%edx
  8021cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021cf:	89 34 24             	mov    %esi,(%esp)
  8021d2:	85 c0                	test   %eax,%eax
  8021d4:	75 1a                	jne    8021f0 <__umoddi3+0x48>
  8021d6:	39 f7                	cmp    %esi,%edi
  8021d8:	0f 86 a2 00 00 00    	jbe    802280 <__umoddi3+0xd8>
  8021de:	89 c8                	mov    %ecx,%eax
  8021e0:	89 f2                	mov    %esi,%edx
  8021e2:	f7 f7                	div    %edi
  8021e4:	89 d0                	mov    %edx,%eax
  8021e6:	31 d2                	xor    %edx,%edx
  8021e8:	83 c4 1c             	add    $0x1c,%esp
  8021eb:	5b                   	pop    %ebx
  8021ec:	5e                   	pop    %esi
  8021ed:	5f                   	pop    %edi
  8021ee:	5d                   	pop    %ebp
  8021ef:	c3                   	ret    
  8021f0:	39 f0                	cmp    %esi,%eax
  8021f2:	0f 87 ac 00 00 00    	ja     8022a4 <__umoddi3+0xfc>
  8021f8:	0f bd e8             	bsr    %eax,%ebp
  8021fb:	83 f5 1f             	xor    $0x1f,%ebp
  8021fe:	0f 84 ac 00 00 00    	je     8022b0 <__umoddi3+0x108>
  802204:	bf 20 00 00 00       	mov    $0x20,%edi
  802209:	29 ef                	sub    %ebp,%edi
  80220b:	89 fe                	mov    %edi,%esi
  80220d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802211:	89 e9                	mov    %ebp,%ecx
  802213:	d3 e0                	shl    %cl,%eax
  802215:	89 d7                	mov    %edx,%edi
  802217:	89 f1                	mov    %esi,%ecx
  802219:	d3 ef                	shr    %cl,%edi
  80221b:	09 c7                	or     %eax,%edi
  80221d:	89 e9                	mov    %ebp,%ecx
  80221f:	d3 e2                	shl    %cl,%edx
  802221:	89 14 24             	mov    %edx,(%esp)
  802224:	89 d8                	mov    %ebx,%eax
  802226:	d3 e0                	shl    %cl,%eax
  802228:	89 c2                	mov    %eax,%edx
  80222a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80222e:	d3 e0                	shl    %cl,%eax
  802230:	89 44 24 04          	mov    %eax,0x4(%esp)
  802234:	8b 44 24 08          	mov    0x8(%esp),%eax
  802238:	89 f1                	mov    %esi,%ecx
  80223a:	d3 e8                	shr    %cl,%eax
  80223c:	09 d0                	or     %edx,%eax
  80223e:	d3 eb                	shr    %cl,%ebx
  802240:	89 da                	mov    %ebx,%edx
  802242:	f7 f7                	div    %edi
  802244:	89 d3                	mov    %edx,%ebx
  802246:	f7 24 24             	mull   (%esp)
  802249:	89 c6                	mov    %eax,%esi
  80224b:	89 d1                	mov    %edx,%ecx
  80224d:	39 d3                	cmp    %edx,%ebx
  80224f:	0f 82 87 00 00 00    	jb     8022dc <__umoddi3+0x134>
  802255:	0f 84 91 00 00 00    	je     8022ec <__umoddi3+0x144>
  80225b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80225f:	29 f2                	sub    %esi,%edx
  802261:	19 cb                	sbb    %ecx,%ebx
  802263:	89 d8                	mov    %ebx,%eax
  802265:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802269:	d3 e0                	shl    %cl,%eax
  80226b:	89 e9                	mov    %ebp,%ecx
  80226d:	d3 ea                	shr    %cl,%edx
  80226f:	09 d0                	or     %edx,%eax
  802271:	89 e9                	mov    %ebp,%ecx
  802273:	d3 eb                	shr    %cl,%ebx
  802275:	89 da                	mov    %ebx,%edx
  802277:	83 c4 1c             	add    $0x1c,%esp
  80227a:	5b                   	pop    %ebx
  80227b:	5e                   	pop    %esi
  80227c:	5f                   	pop    %edi
  80227d:	5d                   	pop    %ebp
  80227e:	c3                   	ret    
  80227f:	90                   	nop
  802280:	89 fd                	mov    %edi,%ebp
  802282:	85 ff                	test   %edi,%edi
  802284:	75 0b                	jne    802291 <__umoddi3+0xe9>
  802286:	b8 01 00 00 00       	mov    $0x1,%eax
  80228b:	31 d2                	xor    %edx,%edx
  80228d:	f7 f7                	div    %edi
  80228f:	89 c5                	mov    %eax,%ebp
  802291:	89 f0                	mov    %esi,%eax
  802293:	31 d2                	xor    %edx,%edx
  802295:	f7 f5                	div    %ebp
  802297:	89 c8                	mov    %ecx,%eax
  802299:	f7 f5                	div    %ebp
  80229b:	89 d0                	mov    %edx,%eax
  80229d:	e9 44 ff ff ff       	jmp    8021e6 <__umoddi3+0x3e>
  8022a2:	66 90                	xchg   %ax,%ax
  8022a4:	89 c8                	mov    %ecx,%eax
  8022a6:	89 f2                	mov    %esi,%edx
  8022a8:	83 c4 1c             	add    $0x1c,%esp
  8022ab:	5b                   	pop    %ebx
  8022ac:	5e                   	pop    %esi
  8022ad:	5f                   	pop    %edi
  8022ae:	5d                   	pop    %ebp
  8022af:	c3                   	ret    
  8022b0:	3b 04 24             	cmp    (%esp),%eax
  8022b3:	72 06                	jb     8022bb <__umoddi3+0x113>
  8022b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022b9:	77 0f                	ja     8022ca <__umoddi3+0x122>
  8022bb:	89 f2                	mov    %esi,%edx
  8022bd:	29 f9                	sub    %edi,%ecx
  8022bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022c3:	89 14 24             	mov    %edx,(%esp)
  8022c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022ce:	8b 14 24             	mov    (%esp),%edx
  8022d1:	83 c4 1c             	add    $0x1c,%esp
  8022d4:	5b                   	pop    %ebx
  8022d5:	5e                   	pop    %esi
  8022d6:	5f                   	pop    %edi
  8022d7:	5d                   	pop    %ebp
  8022d8:	c3                   	ret    
  8022d9:	8d 76 00             	lea    0x0(%esi),%esi
  8022dc:	2b 04 24             	sub    (%esp),%eax
  8022df:	19 fa                	sbb    %edi,%edx
  8022e1:	89 d1                	mov    %edx,%ecx
  8022e3:	89 c6                	mov    %eax,%esi
  8022e5:	e9 71 ff ff ff       	jmp    80225b <__umoddi3+0xb3>
  8022ea:	66 90                	xchg   %ax,%ax
  8022ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022f0:	72 ea                	jb     8022dc <__umoddi3+0x134>
  8022f2:	89 d9                	mov    %ebx,%ecx
  8022f4:	e9 62 ff ff ff       	jmp    80225b <__umoddi3+0xb3>
