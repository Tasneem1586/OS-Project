
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 3d 01 00 00       	call   800173 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
		0xeebfd000, 	//Stack
		} ;


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
	//("STEP 0: checking Initial WS entries ...\n");
	bool found ;

#if USE_KHEAP
	{
		found = sys_check_WS_list(expectedInitialVAs, 11, 0x800000, 1);
  80003f:	6a 01                	push   $0x1
  800041:	68 00 00 80 00       	push   $0x800000
  800046:	6a 0b                	push   $0xb
  800048:	68 20 30 80 00       	push   $0x803020
  80004d:	e8 de 19 00 00       	call   801a30 <sys_check_WS_list>
  800052:	83 c4 10             	add    $0x10,%esp
  800055:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (found != 1) panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS!!\n*****IF CORRECT, CHECK THE ISSUE WITH THE STAFF*****");
  800058:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 60 1d 80 00       	push   $0x801d60
  800066:	6a 1c                	push   $0x1c
  800068:	68 e8 1d 80 00       	push   $0x801de8
  80006d:	e8 61 03 00 00       	call   8003d3 <_panic>
	}
#else
	panic("make sure to enable the kernel heap: USE_KHEAP=1");
#endif

	int freePages = sys_calculate_free_frames();
  800072:	e8 2e 16 00 00       	call   8016a5 <sys_calculate_free_frames>
  800077:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80007a:	e8 71 16 00 00       	call   8016f0 <sys_pf_calculate_allocated_pages>
  80007f:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Writing (Modified)
	__arr__[PAGE_SIZE*10-1] = 'a' ;
  800082:	c6 05 9f d0 80 00 61 	movb   $0x61,0x80d09f

	//Reading (Not Modified)
	char garbage1 = __arr__[PAGE_SIZE*11-1] ;
  800089:	a0 9f e0 80 00       	mov    0x80e09f,%al
  80008e:	88 45 e3             	mov    %al,-0x1d(%ebp)
	char garbage2 = __arr__[PAGE_SIZE*12-1] ;
  800091:	a0 9f f0 80 00       	mov    0x80f09f,%al
  800096:	88 45 e2             	mov    %al,-0x1e(%ebp)
	char garbage4,garbage5;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800099:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000a0:	eb 4a                	jmp    8000ec <_main+0xb4>
	{
		__arr__[i] = -1 ;
  8000a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000a5:	05 a0 30 80 00       	add    $0x8030a0,%eax
  8000aa:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*__ptr__ = *__ptr2__ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *__ptr__ + garbage5;
  8000ad:	a1 00 30 80 00       	mov    0x803000,%eax
  8000b2:	8a 00                	mov    (%eax),%al
  8000b4:	88 c2                	mov    %al,%dl
  8000b6:	8a 45 f7             	mov    -0x9(%ebp),%al
  8000b9:	01 d0                	add    %edx,%eax
  8000bb:	88 45 e1             	mov    %al,-0x1f(%ebp)
		garbage5 = *__ptr2__ + garbage4;
  8000be:	a1 04 30 80 00       	mov    0x803004,%eax
  8000c3:	8a 00                	mov    (%eax),%al
  8000c5:	88 c2                	mov    %al,%dl
  8000c7:	8a 45 e1             	mov    -0x1f(%ebp),%al
  8000ca:	01 d0                	add    %edx,%eax
  8000cc:	88 45 f7             	mov    %al,-0x9(%ebp)
		__ptr__++ ; __ptr2__++ ;
  8000cf:	a1 00 30 80 00       	mov    0x803000,%eax
  8000d4:	40                   	inc    %eax
  8000d5:	a3 00 30 80 00       	mov    %eax,0x803000
  8000da:	a1 04 30 80 00       	mov    0x803004,%eax
  8000df:	40                   	inc    %eax
  8000e0:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage2 = __arr__[PAGE_SIZE*12-1] ;
	char garbage4,garbage5;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000e5:	81 45 f0 00 08 00 00 	addl   $0x800,-0x10(%ebp)
  8000ec:	81 7d f0 ff 9f 00 00 	cmpl   $0x9fff,-0x10(%ebp)
  8000f3:	7e ad                	jle    8000a2 <_main+0x6a>
		__ptr__++ ; __ptr2__++ ;
	}

	//===================

	cprintf_colored(TEXT_cyan, "%~\nChecking Allocation in Mem & Page File... \n");
  8000f5:	83 ec 08             	sub    $0x8,%esp
  8000f8:	68 0c 1e 80 00       	push   $0x801e0c
  8000fd:	6a 03                	push   $0x3
  8000ff:	e8 ca 05 00 00       	call   8006ce <cprintf_colored>
  800104:	83 c4 10             	add    $0x10,%esp
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800107:	e8 e4 15 00 00       	call   8016f0 <sys_pf_calculate_allocated_pages>
  80010c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80010f:	74 14                	je     800125 <_main+0xed>
  800111:	83 ec 04             	sub    $0x4,%esp
  800114:	68 3c 1e 80 00       	push   $0x801e3c
  800119:	6a 3f                	push   $0x3f
  80011b:	68 e8 1d 80 00       	push   $0x801de8
  800120:	e8 ae 02 00 00       	call   8003d3 <_panic>

		int freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800125:	e8 7b 15 00 00       	call   8016a5 <sys_calculate_free_frames>
  80012a:	89 c3                	mov    %eax,%ebx
  80012c:	e8 8d 15 00 00       	call   8016be <sys_calculate_modified_frames>
  800131:	01 d8                	add    %ebx,%eax
  800133:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800136:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800139:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80013c:	74 1d                	je     80015b <_main+0x123>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated. Expected = %d, Actual = %d", 0, (freePages - freePagesAfter));
  80013e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800141:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800144:	83 ec 0c             	sub    $0xc,%esp
  800147:	50                   	push   %eax
  800148:	6a 00                	push   $0x0
  80014a:	68 a8 1e 80 00       	push   $0x801ea8
  80014f:	6a 43                	push   $0x43
  800151:	68 e8 1d 80 00       	push   $0x801de8
  800156:	e8 78 02 00 00       	call   8003d3 <_panic>
	}

	cprintf_colored(TEXT_light_green, "%~\nCongratulations!! test PAGE replacement [ALLOCATION] is completed successfully\n");
  80015b:	83 ec 08             	sub    $0x8,%esp
  80015e:	68 28 1f 80 00       	push   $0x801f28
  800163:	6a 0a                	push   $0xa
  800165:	e8 64 05 00 00       	call   8006ce <cprintf_colored>
  80016a:	83 c4 10             	add    $0x10,%esp
	return;
  80016d:	90                   	nop
}
  80016e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800171:	c9                   	leave  
  800172:	c3                   	ret    

00800173 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800173:	55                   	push   %ebp
  800174:	89 e5                	mov    %esp,%ebp
  800176:	57                   	push   %edi
  800177:	56                   	push   %esi
  800178:	53                   	push   %ebx
  800179:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80017f:	e8 e9 16 00 00       	call   80186d <sys_getenvindex>
  800184:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800187:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80018a:	89 d0                	mov    %edx,%eax
  80018c:	c1 e0 03             	shl    $0x3,%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	c1 e0 06             	shl    $0x6,%eax
  800194:	01 d0                	add    %edx,%eax
  800196:	c1 e0 03             	shl    $0x3,%eax
  800199:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80019e:	a3 60 30 80 00       	mov    %eax,0x803060

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001a3:	a1 60 30 80 00       	mov    0x803060,%eax
  8001a8:	8a 40 10             	mov    0x10(%eax),%al
  8001ab:	84 c0                	test   %al,%al
  8001ad:	74 0d                	je     8001bc <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001af:	a1 60 30 80 00       	mov    0x803060,%eax
  8001b4:	83 c0 10             	add    $0x10,%eax
  8001b7:	a3 50 30 80 00       	mov    %eax,0x803050

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001c0:	7e 0a                	jle    8001cc <libmain+0x59>
		binaryname = argv[0];
  8001c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c5:	8b 00                	mov    (%eax),%eax
  8001c7:	a3 50 30 80 00       	mov    %eax,0x803050

	// call user main routine
	_main(argc, argv);
  8001cc:	83 ec 08             	sub    $0x8,%esp
  8001cf:	ff 75 0c             	pushl  0xc(%ebp)
  8001d2:	ff 75 08             	pushl  0x8(%ebp)
  8001d5:	e8 5e fe ff ff       	call   800038 <_main>
  8001da:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8001dd:	a1 4c 30 80 00       	mov    0x80304c,%eax
  8001e2:	85 c0                	test   %eax,%eax
  8001e4:	0f 84 b7 01 00 00    	je     8003a1 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001ea:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001f0:	bb b8 20 80 00       	mov    $0x8020b8,%ebx
  8001f5:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001fa:	89 c7                	mov    %eax,%edi
  8001fc:	89 de                	mov    %ebx,%esi
  8001fe:	89 d1                	mov    %edx,%ecx
  800200:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800202:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800208:	b9 56 00 00 00       	mov    $0x56,%ecx
  80020d:	b0 00                	mov    $0x0,%al
  80020f:	89 d7                	mov    %edx,%edi
  800211:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800213:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80021a:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80021d:	83 ec 08             	sub    $0x8,%esp
  800220:	50                   	push   %eax
  800221:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800227:	50                   	push   %eax
  800228:	e8 40 18 00 00       	call   801a6d <sys_utilities>
  80022d:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800230:	e8 c0 13 00 00       	call   8015f5 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800235:	83 ec 0c             	sub    $0xc,%esp
  800238:	68 94 1f 80 00       	push   $0x801f94
  80023d:	e8 5f 04 00 00       	call   8006a1 <cprintf>
  800242:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800245:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800248:	85 c0                	test   %eax,%eax
  80024a:	74 58                	je     8002a4 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80024c:	e8 3a 18 00 00       	call   801a8b <sys_get_optimal_num_faults>
  800251:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800254:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80025a:	bb 1c 21 80 00       	mov    $0x80211c,%ebx
  80025f:	ba 11 00 00 00       	mov    $0x11,%edx
  800264:	89 c7                	mov    %eax,%edi
  800266:	89 de                	mov    %ebx,%esi
  800268:	89 d1                	mov    %edx,%ecx
  80026a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80026c:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80026f:	b9 53 00 00 00       	mov    $0x53,%ecx
  800274:	b0 00                	mov    $0x0,%al
  800276:	89 d7                	mov    %edx,%edi
  800278:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80027a:	83 ec 08             	sub    $0x8,%esp
  80027d:	ff 75 dc             	pushl  -0x24(%ebp)
  800280:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800286:	50                   	push   %eax
  800287:	e8 e1 17 00 00       	call   801a6d <sys_utilities>
  80028c:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80028f:	83 ec 08             	sub    $0x8,%esp
  800292:	ff 75 dc             	pushl  -0x24(%ebp)
  800295:	68 bc 1f 80 00       	push   $0x801fbc
  80029a:	e8 02 04 00 00       	call   8006a1 <cprintf>
  80029f:	83 c4 10             	add    $0x10,%esp
  8002a2:	eb 59                	jmp    8002fd <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002a4:	a1 60 30 80 00       	mov    0x803060,%eax
  8002a9:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002af:	a1 60 30 80 00       	mov    0x803060,%eax
  8002b4:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002ba:	83 ec 04             	sub    $0x4,%esp
  8002bd:	52                   	push   %edx
  8002be:	50                   	push   %eax
  8002bf:	68 e0 1f 80 00       	push   $0x801fe0
  8002c4:	e8 d8 03 00 00       	call   8006a1 <cprintf>
  8002c9:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8002cc:	a1 60 30 80 00       	mov    0x803060,%eax
  8002d1:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8002d7:	a1 60 30 80 00       	mov    0x803060,%eax
  8002dc:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002e2:	a1 60 30 80 00       	mov    0x803060,%eax
  8002e7:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002ed:	51                   	push   %ecx
  8002ee:	52                   	push   %edx
  8002ef:	50                   	push   %eax
  8002f0:	68 08 20 80 00       	push   $0x802008
  8002f5:	e8 a7 03 00 00       	call   8006a1 <cprintf>
  8002fa:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002fd:	a1 60 30 80 00       	mov    0x803060,%eax
  800302:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800308:	83 ec 08             	sub    $0x8,%esp
  80030b:	50                   	push   %eax
  80030c:	68 60 20 80 00       	push   $0x802060
  800311:	e8 8b 03 00 00       	call   8006a1 <cprintf>
  800316:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800319:	83 ec 0c             	sub    $0xc,%esp
  80031c:	68 74 20 80 00       	push   $0x802074
  800321:	e8 7b 03 00 00       	call   8006a1 <cprintf>
  800326:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800329:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800330:	eb 28                	jmp    80035a <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800332:	a1 60 30 80 00       	mov    0x803060,%eax
  800337:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80033a:	81 c2 74 04 00 00    	add    $0x474,%edx
  800340:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800343:	83 ec 04             	sub    $0x4,%esp
  800346:	50                   	push   %eax
  800347:	ff 75 e4             	pushl  -0x1c(%ebp)
  80034a:	68 8b 20 80 00       	push   $0x80208b
  80034f:	e8 4d 03 00 00       	call   8006a1 <cprintf>
  800354:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800357:	ff 45 e4             	incl   -0x1c(%ebp)
  80035a:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80035e:	7e d2                	jle    800332 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800360:	83 ec 0c             	sub    $0xc,%esp
  800363:	68 9a 20 80 00       	push   $0x80209a
  800368:	e8 34 03 00 00       	call   8006a1 <cprintf>
  80036d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800370:	a1 60 30 80 00       	mov    0x803060,%eax
  800375:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80037b:	83 ec 08             	sub    $0x8,%esp
  80037e:	50                   	push   %eax
  80037f:	68 9e 20 80 00       	push   $0x80209e
  800384:	e8 18 03 00 00       	call   8006a1 <cprintf>
  800389:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	68 94 1f 80 00       	push   $0x801f94
  800394:	e8 08 03 00 00       	call   8006a1 <cprintf>
  800399:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80039c:	e8 6e 12 00 00       	call   80160f <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8003a1:	e8 1f 00 00 00       	call   8003c5 <exit>
}
  8003a6:	90                   	nop
  8003a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003aa:	5b                   	pop    %ebx
  8003ab:	5e                   	pop    %esi
  8003ac:	5f                   	pop    %edi
  8003ad:	5d                   	pop    %ebp
  8003ae:	c3                   	ret    

008003af <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003af:	55                   	push   %ebp
  8003b0:	89 e5                	mov    %esp,%ebp
  8003b2:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003b5:	83 ec 0c             	sub    $0xc,%esp
  8003b8:	6a 00                	push   $0x0
  8003ba:	e8 7a 14 00 00       	call   801839 <sys_destroy_env>
  8003bf:	83 c4 10             	add    $0x10,%esp
}
  8003c2:	90                   	nop
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <exit>:

void
exit(void)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8003cb:	e8 cf 14 00 00       	call   80189f <sys_exit_env>
}
  8003d0:	90                   	nop
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003d9:	8d 45 10             	lea    0x10(%ebp),%eax
  8003dc:	83 c0 04             	add    $0x4,%eax
  8003df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003e2:	a1 88 f1 80 00       	mov    0x80f188,%eax
  8003e7:	85 c0                	test   %eax,%eax
  8003e9:	74 16                	je     800401 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003eb:	a1 88 f1 80 00       	mov    0x80f188,%eax
  8003f0:	83 ec 08             	sub    $0x8,%esp
  8003f3:	50                   	push   %eax
  8003f4:	68 80 21 80 00       	push   $0x802180
  8003f9:	e8 a3 02 00 00       	call   8006a1 <cprintf>
  8003fe:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800401:	a1 50 30 80 00       	mov    0x803050,%eax
  800406:	83 ec 0c             	sub    $0xc,%esp
  800409:	ff 75 0c             	pushl  0xc(%ebp)
  80040c:	ff 75 08             	pushl  0x8(%ebp)
  80040f:	50                   	push   %eax
  800410:	68 88 21 80 00       	push   $0x802188
  800415:	6a 74                	push   $0x74
  800417:	e8 b2 02 00 00       	call   8006ce <cprintf_colored>
  80041c:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80041f:	8b 45 10             	mov    0x10(%ebp),%eax
  800422:	83 ec 08             	sub    $0x8,%esp
  800425:	ff 75 f4             	pushl  -0xc(%ebp)
  800428:	50                   	push   %eax
  800429:	e8 04 02 00 00       	call   800632 <vcprintf>
  80042e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800431:	83 ec 08             	sub    $0x8,%esp
  800434:	6a 00                	push   $0x0
  800436:	68 b0 21 80 00       	push   $0x8021b0
  80043b:	e8 f2 01 00 00       	call   800632 <vcprintf>
  800440:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800443:	e8 7d ff ff ff       	call   8003c5 <exit>

	// should not return here
	while (1) ;
  800448:	eb fe                	jmp    800448 <_panic+0x75>

0080044a <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800450:	a1 60 30 80 00       	mov    0x803060,%eax
  800455:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80045b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045e:	39 c2                	cmp    %eax,%edx
  800460:	74 14                	je     800476 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800462:	83 ec 04             	sub    $0x4,%esp
  800465:	68 b4 21 80 00       	push   $0x8021b4
  80046a:	6a 26                	push   $0x26
  80046c:	68 00 22 80 00       	push   $0x802200
  800471:	e8 5d ff ff ff       	call   8003d3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800476:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80047d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800484:	e9 c5 00 00 00       	jmp    80054e <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800489:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800493:	8b 45 08             	mov    0x8(%ebp),%eax
  800496:	01 d0                	add    %edx,%eax
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	85 c0                	test   %eax,%eax
  80049c:	75 08                	jne    8004a6 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80049e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004a1:	e9 a5 00 00 00       	jmp    80054b <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8004a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004ad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004b4:	eb 69                	jmp    80051f <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004b6:	a1 60 30 80 00       	mov    0x803060,%eax
  8004bb:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004c1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c4:	89 d0                	mov    %edx,%eax
  8004c6:	01 c0                	add    %eax,%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	c1 e0 03             	shl    $0x3,%eax
  8004cd:	01 c8                	add    %ecx,%eax
  8004cf:	8a 40 04             	mov    0x4(%eax),%al
  8004d2:	84 c0                	test   %al,%al
  8004d4:	75 46                	jne    80051c <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004d6:	a1 60 30 80 00       	mov    0x803060,%eax
  8004db:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004e1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004e4:	89 d0                	mov    %edx,%eax
  8004e6:	01 c0                	add    %eax,%eax
  8004e8:	01 d0                	add    %edx,%eax
  8004ea:	c1 e0 03             	shl    $0x3,%eax
  8004ed:	01 c8                	add    %ecx,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004fc:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800501:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800508:	8b 45 08             	mov    0x8(%ebp),%eax
  80050b:	01 c8                	add    %ecx,%eax
  80050d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80050f:	39 c2                	cmp    %eax,%edx
  800511:	75 09                	jne    80051c <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800513:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80051a:	eb 15                	jmp    800531 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80051c:	ff 45 e8             	incl   -0x18(%ebp)
  80051f:	a1 60 30 80 00       	mov    0x803060,%eax
  800524:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80052a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80052d:	39 c2                	cmp    %eax,%edx
  80052f:	77 85                	ja     8004b6 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800531:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800535:	75 14                	jne    80054b <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800537:	83 ec 04             	sub    $0x4,%esp
  80053a:	68 0c 22 80 00       	push   $0x80220c
  80053f:	6a 3a                	push   $0x3a
  800541:	68 00 22 80 00       	push   $0x802200
  800546:	e8 88 fe ff ff       	call   8003d3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80054b:	ff 45 f0             	incl   -0x10(%ebp)
  80054e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800551:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800554:	0f 8c 2f ff ff ff    	jl     800489 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80055a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800561:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800568:	eb 26                	jmp    800590 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80056a:	a1 60 30 80 00       	mov    0x803060,%eax
  80056f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800575:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800578:	89 d0                	mov    %edx,%eax
  80057a:	01 c0                	add    %eax,%eax
  80057c:	01 d0                	add    %edx,%eax
  80057e:	c1 e0 03             	shl    $0x3,%eax
  800581:	01 c8                	add    %ecx,%eax
  800583:	8a 40 04             	mov    0x4(%eax),%al
  800586:	3c 01                	cmp    $0x1,%al
  800588:	75 03                	jne    80058d <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  80058a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80058d:	ff 45 e0             	incl   -0x20(%ebp)
  800590:	a1 60 30 80 00       	mov    0x803060,%eax
  800595:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80059b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80059e:	39 c2                	cmp    %eax,%edx
  8005a0:	77 c8                	ja     80056a <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005a8:	74 14                	je     8005be <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8005aa:	83 ec 04             	sub    $0x4,%esp
  8005ad:	68 60 22 80 00       	push   $0x802260
  8005b2:	6a 44                	push   $0x44
  8005b4:	68 00 22 80 00       	push   $0x802200
  8005b9:	e8 15 fe ff ff       	call   8003d3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005be:	90                   	nop
  8005bf:	c9                   	leave  
  8005c0:	c3                   	ret    

008005c1 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8005c1:	55                   	push   %ebp
  8005c2:	89 e5                	mov    %esp,%ebp
  8005c4:	53                   	push   %ebx
  8005c5:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8005c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005cb:	8b 00                	mov    (%eax),%eax
  8005cd:	8d 48 01             	lea    0x1(%eax),%ecx
  8005d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d3:	89 0a                	mov    %ecx,(%edx)
  8005d5:	8b 55 08             	mov    0x8(%ebp),%edx
  8005d8:	88 d1                	mov    %dl,%cl
  8005da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005dd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005eb:	75 30                	jne    80061d <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8005ed:	8b 15 8c f1 80 00    	mov    0x80f18c,%edx
  8005f3:	a0 80 30 80 00       	mov    0x803080,%al
  8005f8:	0f b6 c0             	movzbl %al,%eax
  8005fb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005fe:	8b 09                	mov    (%ecx),%ecx
  800600:	89 cb                	mov    %ecx,%ebx
  800602:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800605:	83 c1 08             	add    $0x8,%ecx
  800608:	52                   	push   %edx
  800609:	50                   	push   %eax
  80060a:	53                   	push   %ebx
  80060b:	51                   	push   %ecx
  80060c:	e8 a0 0f 00 00       	call   8015b1 <sys_cputs>
  800611:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800614:	8b 45 0c             	mov    0xc(%ebp),%eax
  800617:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80061d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800620:	8b 40 04             	mov    0x4(%eax),%eax
  800623:	8d 50 01             	lea    0x1(%eax),%edx
  800626:	8b 45 0c             	mov    0xc(%ebp),%eax
  800629:	89 50 04             	mov    %edx,0x4(%eax)
}
  80062c:	90                   	nop
  80062d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800630:	c9                   	leave  
  800631:	c3                   	ret    

00800632 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800632:	55                   	push   %ebp
  800633:	89 e5                	mov    %esp,%ebp
  800635:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80063b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800642:	00 00 00 
	b.cnt = 0;
  800645:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80064c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80064f:	ff 75 0c             	pushl  0xc(%ebp)
  800652:	ff 75 08             	pushl  0x8(%ebp)
  800655:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80065b:	50                   	push   %eax
  80065c:	68 c1 05 80 00       	push   $0x8005c1
  800661:	e8 5a 02 00 00       	call   8008c0 <vprintfmt>
  800666:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800669:	8b 15 8c f1 80 00    	mov    0x80f18c,%edx
  80066f:	a0 80 30 80 00       	mov    0x803080,%al
  800674:	0f b6 c0             	movzbl %al,%eax
  800677:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80067d:	52                   	push   %edx
  80067e:	50                   	push   %eax
  80067f:	51                   	push   %ecx
  800680:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800686:	83 c0 08             	add    $0x8,%eax
  800689:	50                   	push   %eax
  80068a:	e8 22 0f 00 00       	call   8015b1 <sys_cputs>
  80068f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800692:	c6 05 80 30 80 00 00 	movb   $0x0,0x803080
	return b.cnt;
  800699:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80069f:	c9                   	leave  
  8006a0:	c3                   	ret    

008006a1 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8006a1:	55                   	push   %ebp
  8006a2:	89 e5                	mov    %esp,%ebp
  8006a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006a7:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
	va_start(ap, fmt);
  8006ae:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b7:	83 ec 08             	sub    $0x8,%esp
  8006ba:	ff 75 f4             	pushl  -0xc(%ebp)
  8006bd:	50                   	push   %eax
  8006be:	e8 6f ff ff ff       	call   800632 <vcprintf>
  8006c3:	83 c4 10             	add    $0x10,%esp
  8006c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006cc:	c9                   	leave  
  8006cd:	c3                   	ret    

008006ce <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8006ce:	55                   	push   %ebp
  8006cf:	89 e5                	mov    %esp,%ebp
  8006d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006d4:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
	curTextClr = (textClr << 8) ; //set text color by the given value
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	c1 e0 08             	shl    $0x8,%eax
  8006e1:	a3 8c f1 80 00       	mov    %eax,0x80f18c
	va_start(ap, fmt);
  8006e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006e9:	83 c0 04             	add    $0x4,%eax
  8006ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f2:	83 ec 08             	sub    $0x8,%esp
  8006f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f8:	50                   	push   %eax
  8006f9:	e8 34 ff ff ff       	call   800632 <vcprintf>
  8006fe:	83 c4 10             	add    $0x10,%esp
  800701:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800704:	c7 05 8c f1 80 00 00 	movl   $0x700,0x80f18c
  80070b:	07 00 00 

	return cnt;
  80070e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800711:	c9                   	leave  
  800712:	c3                   	ret    

00800713 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800713:	55                   	push   %ebp
  800714:	89 e5                	mov    %esp,%ebp
  800716:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800719:	e8 d7 0e 00 00       	call   8015f5 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80071e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800721:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 f4             	pushl  -0xc(%ebp)
  80072d:	50                   	push   %eax
  80072e:	e8 ff fe ff ff       	call   800632 <vcprintf>
  800733:	83 c4 10             	add    $0x10,%esp
  800736:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800739:	e8 d1 0e 00 00       	call   80160f <sys_unlock_cons>
	return cnt;
  80073e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
  800746:	53                   	push   %ebx
  800747:	83 ec 14             	sub    $0x14,%esp
  80074a:	8b 45 10             	mov    0x10(%ebp),%eax
  80074d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800750:	8b 45 14             	mov    0x14(%ebp),%eax
  800753:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800756:	8b 45 18             	mov    0x18(%ebp),%eax
  800759:	ba 00 00 00 00       	mov    $0x0,%edx
  80075e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800761:	77 55                	ja     8007b8 <printnum+0x75>
  800763:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800766:	72 05                	jb     80076d <printnum+0x2a>
  800768:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80076b:	77 4b                	ja     8007b8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80076d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800770:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800773:	8b 45 18             	mov    0x18(%ebp),%eax
  800776:	ba 00 00 00 00       	mov    $0x0,%edx
  80077b:	52                   	push   %edx
  80077c:	50                   	push   %eax
  80077d:	ff 75 f4             	pushl  -0xc(%ebp)
  800780:	ff 75 f0             	pushl  -0x10(%ebp)
  800783:	e8 74 13 00 00       	call   801afc <__udivdi3>
  800788:	83 c4 10             	add    $0x10,%esp
  80078b:	83 ec 04             	sub    $0x4,%esp
  80078e:	ff 75 20             	pushl  0x20(%ebp)
  800791:	53                   	push   %ebx
  800792:	ff 75 18             	pushl  0x18(%ebp)
  800795:	52                   	push   %edx
  800796:	50                   	push   %eax
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	e8 a1 ff ff ff       	call   800743 <printnum>
  8007a2:	83 c4 20             	add    $0x20,%esp
  8007a5:	eb 1a                	jmp    8007c1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	ff 75 0c             	pushl  0xc(%ebp)
  8007ad:	ff 75 20             	pushl  0x20(%ebp)
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	ff d0                	call   *%eax
  8007b5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007b8:	ff 4d 1c             	decl   0x1c(%ebp)
  8007bb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007bf:	7f e6                	jg     8007a7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007c1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007c4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007cf:	53                   	push   %ebx
  8007d0:	51                   	push   %ecx
  8007d1:	52                   	push   %edx
  8007d2:	50                   	push   %eax
  8007d3:	e8 34 14 00 00       	call   801c0c <__umoddi3>
  8007d8:	83 c4 10             	add    $0x10,%esp
  8007db:	05 d4 24 80 00       	add    $0x8024d4,%eax
  8007e0:	8a 00                	mov    (%eax),%al
  8007e2:	0f be c0             	movsbl %al,%eax
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	50                   	push   %eax
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	ff d0                	call   *%eax
  8007f1:	83 c4 10             	add    $0x10,%esp
}
  8007f4:	90                   	nop
  8007f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007f8:	c9                   	leave  
  8007f9:	c3                   	ret    

008007fa <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007fa:	55                   	push   %ebp
  8007fb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007fd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800801:	7e 1c                	jle    80081f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	8d 50 08             	lea    0x8(%eax),%edx
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	89 10                	mov    %edx,(%eax)
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	83 e8 08             	sub    $0x8,%eax
  800818:	8b 50 04             	mov    0x4(%eax),%edx
  80081b:	8b 00                	mov    (%eax),%eax
  80081d:	eb 40                	jmp    80085f <getuint+0x65>
	else if (lflag)
  80081f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800823:	74 1e                	je     800843 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	8d 50 04             	lea    0x4(%eax),%edx
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	89 10                	mov    %edx,(%eax)
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	83 e8 04             	sub    $0x4,%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	ba 00 00 00 00       	mov    $0x0,%edx
  800841:	eb 1c                	jmp    80085f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	8b 00                	mov    (%eax),%eax
  800848:	8d 50 04             	lea    0x4(%eax),%edx
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	89 10                	mov    %edx,(%eax)
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	8b 00                	mov    (%eax),%eax
  800855:	83 e8 04             	sub    $0x4,%eax
  800858:	8b 00                	mov    (%eax),%eax
  80085a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80085f:	5d                   	pop    %ebp
  800860:	c3                   	ret    

00800861 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800861:	55                   	push   %ebp
  800862:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800864:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800868:	7e 1c                	jle    800886 <getint+0x25>
		return va_arg(*ap, long long);
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	8b 00                	mov    (%eax),%eax
  80086f:	8d 50 08             	lea    0x8(%eax),%edx
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	89 10                	mov    %edx,(%eax)
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	83 e8 08             	sub    $0x8,%eax
  80087f:	8b 50 04             	mov    0x4(%eax),%edx
  800882:	8b 00                	mov    (%eax),%eax
  800884:	eb 38                	jmp    8008be <getint+0x5d>
	else if (lflag)
  800886:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80088a:	74 1a                	je     8008a6 <getint+0x45>
		return va_arg(*ap, long);
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	8b 00                	mov    (%eax),%eax
  800891:	8d 50 04             	lea    0x4(%eax),%edx
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	89 10                	mov    %edx,(%eax)
  800899:	8b 45 08             	mov    0x8(%ebp),%eax
  80089c:	8b 00                	mov    (%eax),%eax
  80089e:	83 e8 04             	sub    $0x4,%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	99                   	cltd   
  8008a4:	eb 18                	jmp    8008be <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	8d 50 04             	lea    0x4(%eax),%edx
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	89 10                	mov    %edx,(%eax)
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	83 e8 04             	sub    $0x4,%eax
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	99                   	cltd   
}
  8008be:	5d                   	pop    %ebp
  8008bf:	c3                   	ret    

008008c0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008c0:	55                   	push   %ebp
  8008c1:	89 e5                	mov    %esp,%ebp
  8008c3:	56                   	push   %esi
  8008c4:	53                   	push   %ebx
  8008c5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008c8:	eb 17                	jmp    8008e1 <vprintfmt+0x21>
			if (ch == '\0')
  8008ca:	85 db                	test   %ebx,%ebx
  8008cc:	0f 84 c1 03 00 00    	je     800c93 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	ff 75 0c             	pushl  0xc(%ebp)
  8008d8:	53                   	push   %ebx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e4:	8d 50 01             	lea    0x1(%eax),%edx
  8008e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8008ea:	8a 00                	mov    (%eax),%al
  8008ec:	0f b6 d8             	movzbl %al,%ebx
  8008ef:	83 fb 25             	cmp    $0x25,%ebx
  8008f2:	75 d6                	jne    8008ca <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008f4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008f8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008ff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800906:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80090d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800914:	8b 45 10             	mov    0x10(%ebp),%eax
  800917:	8d 50 01             	lea    0x1(%eax),%edx
  80091a:	89 55 10             	mov    %edx,0x10(%ebp)
  80091d:	8a 00                	mov    (%eax),%al
  80091f:	0f b6 d8             	movzbl %al,%ebx
  800922:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800925:	83 f8 5b             	cmp    $0x5b,%eax
  800928:	0f 87 3d 03 00 00    	ja     800c6b <vprintfmt+0x3ab>
  80092e:	8b 04 85 f8 24 80 00 	mov    0x8024f8(,%eax,4),%eax
  800935:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800937:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80093b:	eb d7                	jmp    800914 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80093d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800941:	eb d1                	jmp    800914 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800943:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80094a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80094d:	89 d0                	mov    %edx,%eax
  80094f:	c1 e0 02             	shl    $0x2,%eax
  800952:	01 d0                	add    %edx,%eax
  800954:	01 c0                	add    %eax,%eax
  800956:	01 d8                	add    %ebx,%eax
  800958:	83 e8 30             	sub    $0x30,%eax
  80095b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80095e:	8b 45 10             	mov    0x10(%ebp),%eax
  800961:	8a 00                	mov    (%eax),%al
  800963:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800966:	83 fb 2f             	cmp    $0x2f,%ebx
  800969:	7e 3e                	jle    8009a9 <vprintfmt+0xe9>
  80096b:	83 fb 39             	cmp    $0x39,%ebx
  80096e:	7f 39                	jg     8009a9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800970:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800973:	eb d5                	jmp    80094a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800975:	8b 45 14             	mov    0x14(%ebp),%eax
  800978:	83 c0 04             	add    $0x4,%eax
  80097b:	89 45 14             	mov    %eax,0x14(%ebp)
  80097e:	8b 45 14             	mov    0x14(%ebp),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800989:	eb 1f                	jmp    8009aa <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80098b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098f:	79 83                	jns    800914 <vprintfmt+0x54>
				width = 0;
  800991:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800998:	e9 77 ff ff ff       	jmp    800914 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80099d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009a4:	e9 6b ff ff ff       	jmp    800914 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009a9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ae:	0f 89 60 ff ff ff    	jns    800914 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009ba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009c1:	e9 4e ff ff ff       	jmp    800914 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009c6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009c9:	e9 46 ff ff ff       	jmp    800914 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	83 c0 04             	add    $0x4,%eax
  8009d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009da:	83 e8 04             	sub    $0x4,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	50                   	push   %eax
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	ff d0                	call   *%eax
  8009eb:	83 c4 10             	add    $0x10,%esp
			break;
  8009ee:	e9 9b 02 00 00       	jmp    800c8e <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f6:	83 c0 04             	add    $0x4,%eax
  8009f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ff:	83 e8 04             	sub    $0x4,%eax
  800a02:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a04:	85 db                	test   %ebx,%ebx
  800a06:	79 02                	jns    800a0a <vprintfmt+0x14a>
				err = -err;
  800a08:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a0a:	83 fb 64             	cmp    $0x64,%ebx
  800a0d:	7f 0b                	jg     800a1a <vprintfmt+0x15a>
  800a0f:	8b 34 9d 40 23 80 00 	mov    0x802340(,%ebx,4),%esi
  800a16:	85 f6                	test   %esi,%esi
  800a18:	75 19                	jne    800a33 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a1a:	53                   	push   %ebx
  800a1b:	68 e5 24 80 00       	push   $0x8024e5
  800a20:	ff 75 0c             	pushl  0xc(%ebp)
  800a23:	ff 75 08             	pushl  0x8(%ebp)
  800a26:	e8 70 02 00 00       	call   800c9b <printfmt>
  800a2b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a2e:	e9 5b 02 00 00       	jmp    800c8e <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a33:	56                   	push   %esi
  800a34:	68 ee 24 80 00       	push   $0x8024ee
  800a39:	ff 75 0c             	pushl  0xc(%ebp)
  800a3c:	ff 75 08             	pushl  0x8(%ebp)
  800a3f:	e8 57 02 00 00       	call   800c9b <printfmt>
  800a44:	83 c4 10             	add    $0x10,%esp
			break;
  800a47:	e9 42 02 00 00       	jmp    800c8e <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4f:	83 c0 04             	add    $0x4,%eax
  800a52:	89 45 14             	mov    %eax,0x14(%ebp)
  800a55:	8b 45 14             	mov    0x14(%ebp),%eax
  800a58:	83 e8 04             	sub    $0x4,%eax
  800a5b:	8b 30                	mov    (%eax),%esi
  800a5d:	85 f6                	test   %esi,%esi
  800a5f:	75 05                	jne    800a66 <vprintfmt+0x1a6>
				p = "(null)";
  800a61:	be f1 24 80 00       	mov    $0x8024f1,%esi
			if (width > 0 && padc != '-')
  800a66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a6a:	7e 6d                	jle    800ad9 <vprintfmt+0x219>
  800a6c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a70:	74 67                	je     800ad9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a75:	83 ec 08             	sub    $0x8,%esp
  800a78:	50                   	push   %eax
  800a79:	56                   	push   %esi
  800a7a:	e8 1e 03 00 00       	call   800d9d <strnlen>
  800a7f:	83 c4 10             	add    $0x10,%esp
  800a82:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a85:	eb 16                	jmp    800a9d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a87:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	50                   	push   %eax
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a9a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa1:	7f e4                	jg     800a87 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aa3:	eb 34                	jmp    800ad9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aa5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aa9:	74 1c                	je     800ac7 <vprintfmt+0x207>
  800aab:	83 fb 1f             	cmp    $0x1f,%ebx
  800aae:	7e 05                	jle    800ab5 <vprintfmt+0x1f5>
  800ab0:	83 fb 7e             	cmp    $0x7e,%ebx
  800ab3:	7e 12                	jle    800ac7 <vprintfmt+0x207>
					putch('?', putdat);
  800ab5:	83 ec 08             	sub    $0x8,%esp
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	6a 3f                	push   $0x3f
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	ff d0                	call   *%eax
  800ac2:	83 c4 10             	add    $0x10,%esp
  800ac5:	eb 0f                	jmp    800ad6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ac7:	83 ec 08             	sub    $0x8,%esp
  800aca:	ff 75 0c             	pushl  0xc(%ebp)
  800acd:	53                   	push   %ebx
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad6:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad9:	89 f0                	mov    %esi,%eax
  800adb:	8d 70 01             	lea    0x1(%eax),%esi
  800ade:	8a 00                	mov    (%eax),%al
  800ae0:	0f be d8             	movsbl %al,%ebx
  800ae3:	85 db                	test   %ebx,%ebx
  800ae5:	74 24                	je     800b0b <vprintfmt+0x24b>
  800ae7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aeb:	78 b8                	js     800aa5 <vprintfmt+0x1e5>
  800aed:	ff 4d e0             	decl   -0x20(%ebp)
  800af0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800af4:	79 af                	jns    800aa5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800af6:	eb 13                	jmp    800b0b <vprintfmt+0x24b>
				putch(' ', putdat);
  800af8:	83 ec 08             	sub    $0x8,%esp
  800afb:	ff 75 0c             	pushl  0xc(%ebp)
  800afe:	6a 20                	push   $0x20
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	ff d0                	call   *%eax
  800b05:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b08:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b0f:	7f e7                	jg     800af8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b11:	e9 78 01 00 00       	jmp    800c8e <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b16:	83 ec 08             	sub    $0x8,%esp
  800b19:	ff 75 e8             	pushl  -0x18(%ebp)
  800b1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b1f:	50                   	push   %eax
  800b20:	e8 3c fd ff ff       	call   800861 <getint>
  800b25:	83 c4 10             	add    $0x10,%esp
  800b28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b34:	85 d2                	test   %edx,%edx
  800b36:	79 23                	jns    800b5b <vprintfmt+0x29b>
				putch('-', putdat);
  800b38:	83 ec 08             	sub    $0x8,%esp
  800b3b:	ff 75 0c             	pushl  0xc(%ebp)
  800b3e:	6a 2d                	push   $0x2d
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	ff d0                	call   *%eax
  800b45:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b4e:	f7 d8                	neg    %eax
  800b50:	83 d2 00             	adc    $0x0,%edx
  800b53:	f7 da                	neg    %edx
  800b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b62:	e9 bc 00 00 00       	jmp    800c23 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b6d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b70:	50                   	push   %eax
  800b71:	e8 84 fc ff ff       	call   8007fa <getuint>
  800b76:	83 c4 10             	add    $0x10,%esp
  800b79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b7f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b86:	e9 98 00 00 00       	jmp    800c23 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b8b:	83 ec 08             	sub    $0x8,%esp
  800b8e:	ff 75 0c             	pushl  0xc(%ebp)
  800b91:	6a 58                	push   $0x58
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	ff d0                	call   *%eax
  800b98:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ba1:	6a 58                	push   $0x58
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	ff d0                	call   *%eax
  800ba8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bab:	83 ec 08             	sub    $0x8,%esp
  800bae:	ff 75 0c             	pushl  0xc(%ebp)
  800bb1:	6a 58                	push   $0x58
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	ff d0                	call   *%eax
  800bb8:	83 c4 10             	add    $0x10,%esp
			break;
  800bbb:	e9 ce 00 00 00       	jmp    800c8e <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800bc0:	83 ec 08             	sub    $0x8,%esp
  800bc3:	ff 75 0c             	pushl  0xc(%ebp)
  800bc6:	6a 30                	push   $0x30
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	ff d0                	call   *%eax
  800bcd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bd0:	83 ec 08             	sub    $0x8,%esp
  800bd3:	ff 75 0c             	pushl  0xc(%ebp)
  800bd6:	6a 78                	push   $0x78
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	ff d0                	call   *%eax
  800bdd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800be0:	8b 45 14             	mov    0x14(%ebp),%eax
  800be3:	83 c0 04             	add    $0x4,%eax
  800be6:	89 45 14             	mov    %eax,0x14(%ebp)
  800be9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bec:	83 e8 04             	sub    $0x4,%eax
  800bef:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bfb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c02:	eb 1f                	jmp    800c23 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c0d:	50                   	push   %eax
  800c0e:	e8 e7 fb ff ff       	call   8007fa <getuint>
  800c13:	83 c4 10             	add    $0x10,%esp
  800c16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c1c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c23:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c2a:	83 ec 04             	sub    $0x4,%esp
  800c2d:	52                   	push   %edx
  800c2e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c31:	50                   	push   %eax
  800c32:	ff 75 f4             	pushl  -0xc(%ebp)
  800c35:	ff 75 f0             	pushl  -0x10(%ebp)
  800c38:	ff 75 0c             	pushl  0xc(%ebp)
  800c3b:	ff 75 08             	pushl  0x8(%ebp)
  800c3e:	e8 00 fb ff ff       	call   800743 <printnum>
  800c43:	83 c4 20             	add    $0x20,%esp
			break;
  800c46:	eb 46                	jmp    800c8e <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c48:	83 ec 08             	sub    $0x8,%esp
  800c4b:	ff 75 0c             	pushl  0xc(%ebp)
  800c4e:	53                   	push   %ebx
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	ff d0                	call   *%eax
  800c54:	83 c4 10             	add    $0x10,%esp
			break;
  800c57:	eb 35                	jmp    800c8e <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c59:	c6 05 80 30 80 00 00 	movb   $0x0,0x803080
			break;
  800c60:	eb 2c                	jmp    800c8e <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c62:	c6 05 80 30 80 00 01 	movb   $0x1,0x803080
			break;
  800c69:	eb 23                	jmp    800c8e <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 0c             	pushl  0xc(%ebp)
  800c71:	6a 25                	push   $0x25
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	ff d0                	call   *%eax
  800c78:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c7b:	ff 4d 10             	decl   0x10(%ebp)
  800c7e:	eb 03                	jmp    800c83 <vprintfmt+0x3c3>
  800c80:	ff 4d 10             	decl   0x10(%ebp)
  800c83:	8b 45 10             	mov    0x10(%ebp),%eax
  800c86:	48                   	dec    %eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	3c 25                	cmp    $0x25,%al
  800c8b:	75 f3                	jne    800c80 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c8d:	90                   	nop
		}
	}
  800c8e:	e9 35 fc ff ff       	jmp    8008c8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c93:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c94:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c97:	5b                   	pop    %ebx
  800c98:	5e                   	pop    %esi
  800c99:	5d                   	pop    %ebp
  800c9a:	c3                   	ret    

00800c9b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
  800c9e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ca1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ca4:	83 c0 04             	add    $0x4,%eax
  800ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800caa:	8b 45 10             	mov    0x10(%ebp),%eax
  800cad:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb0:	50                   	push   %eax
  800cb1:	ff 75 0c             	pushl  0xc(%ebp)
  800cb4:	ff 75 08             	pushl  0x8(%ebp)
  800cb7:	e8 04 fc ff ff       	call   8008c0 <vprintfmt>
  800cbc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cbf:	90                   	nop
  800cc0:	c9                   	leave  
  800cc1:	c3                   	ret    

00800cc2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cc2:	55                   	push   %ebp
  800cc3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	8b 40 08             	mov    0x8(%eax),%eax
  800ccb:	8d 50 01             	lea    0x1(%eax),%edx
  800cce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd7:	8b 10                	mov    (%eax),%edx
  800cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdc:	8b 40 04             	mov    0x4(%eax),%eax
  800cdf:	39 c2                	cmp    %eax,%edx
  800ce1:	73 12                	jae    800cf5 <sprintputch+0x33>
		*b->buf++ = ch;
  800ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce6:	8b 00                	mov    (%eax),%eax
  800ce8:	8d 48 01             	lea    0x1(%eax),%ecx
  800ceb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cee:	89 0a                	mov    %ecx,(%edx)
  800cf0:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf3:	88 10                	mov    %dl,(%eax)
}
  800cf5:	90                   	nop
  800cf6:	5d                   	pop    %ebp
  800cf7:	c3                   	ret    

00800cf8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cf8:	55                   	push   %ebp
  800cf9:	89 e5                	mov    %esp,%ebp
  800cfb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d07:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	01 d0                	add    %edx,%eax
  800d0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d19:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d1d:	74 06                	je     800d25 <vsnprintf+0x2d>
  800d1f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d23:	7f 07                	jg     800d2c <vsnprintf+0x34>
		return -E_INVAL;
  800d25:	b8 03 00 00 00       	mov    $0x3,%eax
  800d2a:	eb 20                	jmp    800d4c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d2c:	ff 75 14             	pushl  0x14(%ebp)
  800d2f:	ff 75 10             	pushl  0x10(%ebp)
  800d32:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d35:	50                   	push   %eax
  800d36:	68 c2 0c 80 00       	push   $0x800cc2
  800d3b:	e8 80 fb ff ff       	call   8008c0 <vprintfmt>
  800d40:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d43:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d46:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d4c:	c9                   	leave  
  800d4d:	c3                   	ret    

00800d4e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d4e:	55                   	push   %ebp
  800d4f:	89 e5                	mov    %esp,%ebp
  800d51:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d54:	8d 45 10             	lea    0x10(%ebp),%eax
  800d57:	83 c0 04             	add    $0x4,%eax
  800d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d60:	ff 75 f4             	pushl  -0xc(%ebp)
  800d63:	50                   	push   %eax
  800d64:	ff 75 0c             	pushl  0xc(%ebp)
  800d67:	ff 75 08             	pushl  0x8(%ebp)
  800d6a:	e8 89 ff ff ff       	call   800cf8 <vsnprintf>
  800d6f:	83 c4 10             	add    $0x10,%esp
  800d72:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d75:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
  800d7d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d87:	eb 06                	jmp    800d8f <strlen+0x15>
		n++;
  800d89:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d8c:	ff 45 08             	incl   0x8(%ebp)
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	84 c0                	test   %al,%al
  800d96:	75 f1                	jne    800d89 <strlen+0xf>
		n++;
	return n;
  800d98:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d9b:	c9                   	leave  
  800d9c:	c3                   	ret    

00800d9d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800da3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800daa:	eb 09                	jmp    800db5 <strnlen+0x18>
		n++;
  800dac:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800daf:	ff 45 08             	incl   0x8(%ebp)
  800db2:	ff 4d 0c             	decl   0xc(%ebp)
  800db5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db9:	74 09                	je     800dc4 <strnlen+0x27>
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8a 00                	mov    (%eax),%al
  800dc0:	84 c0                	test   %al,%al
  800dc2:	75 e8                	jne    800dac <strnlen+0xf>
		n++;
	return n;
  800dc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dc7:	c9                   	leave  
  800dc8:	c3                   	ret    

00800dc9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dc9:	55                   	push   %ebp
  800dca:	89 e5                	mov    %esp,%ebp
  800dcc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dd5:	90                   	nop
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8d 50 01             	lea    0x1(%eax),%edx
  800ddc:	89 55 08             	mov    %edx,0x8(%ebp)
  800ddf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800de2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800de8:	8a 12                	mov    (%edx),%dl
  800dea:	88 10                	mov    %dl,(%eax)
  800dec:	8a 00                	mov    (%eax),%al
  800dee:	84 c0                	test   %al,%al
  800df0:	75 e4                	jne    800dd6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800df2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800df5:	c9                   	leave  
  800df6:	c3                   	ret    

00800df7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800df7:	55                   	push   %ebp
  800df8:	89 e5                	mov    %esp,%ebp
  800dfa:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e0a:	eb 1f                	jmp    800e2b <strncpy+0x34>
		*dst++ = *src;
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	8d 50 01             	lea    0x1(%eax),%edx
  800e12:	89 55 08             	mov    %edx,0x8(%ebp)
  800e15:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e18:	8a 12                	mov    (%edx),%dl
  800e1a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	84 c0                	test   %al,%al
  800e23:	74 03                	je     800e28 <strncpy+0x31>
			src++;
  800e25:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e28:	ff 45 fc             	incl   -0x4(%ebp)
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e31:	72 d9                	jb     800e0c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e33:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e36:	c9                   	leave  
  800e37:	c3                   	ret    

00800e38 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e38:	55                   	push   %ebp
  800e39:	89 e5                	mov    %esp,%ebp
  800e3b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e48:	74 30                	je     800e7a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e4a:	eb 16                	jmp    800e62 <strlcpy+0x2a>
			*dst++ = *src++;
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	8d 50 01             	lea    0x1(%eax),%edx
  800e52:	89 55 08             	mov    %edx,0x8(%ebp)
  800e55:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e58:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e5b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e5e:	8a 12                	mov    (%edx),%dl
  800e60:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e62:	ff 4d 10             	decl   0x10(%ebp)
  800e65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e69:	74 09                	je     800e74 <strlcpy+0x3c>
  800e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	84 c0                	test   %al,%al
  800e72:	75 d8                	jne    800e4c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e7a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e80:	29 c2                	sub    %eax,%edx
  800e82:	89 d0                	mov    %edx,%eax
}
  800e84:	c9                   	leave  
  800e85:	c3                   	ret    

00800e86 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e86:	55                   	push   %ebp
  800e87:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e89:	eb 06                	jmp    800e91 <strcmp+0xb>
		p++, q++;
  800e8b:	ff 45 08             	incl   0x8(%ebp)
  800e8e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	84 c0                	test   %al,%al
  800e98:	74 0e                	je     800ea8 <strcmp+0x22>
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8a 10                	mov    (%eax),%dl
  800e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	38 c2                	cmp    %al,%dl
  800ea6:	74 e3                	je     800e8b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	0f b6 d0             	movzbl %al,%edx
  800eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	0f b6 c0             	movzbl %al,%eax
  800eb8:	29 c2                	sub    %eax,%edx
  800eba:	89 d0                	mov    %edx,%eax
}
  800ebc:	5d                   	pop    %ebp
  800ebd:	c3                   	ret    

00800ebe <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ebe:	55                   	push   %ebp
  800ebf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ec1:	eb 09                	jmp    800ecc <strncmp+0xe>
		n--, p++, q++;
  800ec3:	ff 4d 10             	decl   0x10(%ebp)
  800ec6:	ff 45 08             	incl   0x8(%ebp)
  800ec9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ecc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed0:	74 17                	je     800ee9 <strncmp+0x2b>
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	84 c0                	test   %al,%al
  800ed9:	74 0e                	je     800ee9 <strncmp+0x2b>
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	8a 10                	mov    (%eax),%dl
  800ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	38 c2                	cmp    %al,%dl
  800ee7:	74 da                	je     800ec3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ee9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eed:	75 07                	jne    800ef6 <strncmp+0x38>
		return 0;
  800eef:	b8 00 00 00 00       	mov    $0x0,%eax
  800ef4:	eb 14                	jmp    800f0a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	0f b6 d0             	movzbl %al,%edx
  800efe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	0f b6 c0             	movzbl %al,%eax
  800f06:	29 c2                	sub    %eax,%edx
  800f08:	89 d0                	mov    %edx,%eax
}
  800f0a:	5d                   	pop    %ebp
  800f0b:	c3                   	ret    

00800f0c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f0c:	55                   	push   %ebp
  800f0d:	89 e5                	mov    %esp,%ebp
  800f0f:	83 ec 04             	sub    $0x4,%esp
  800f12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f15:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f18:	eb 12                	jmp    800f2c <strchr+0x20>
		if (*s == c)
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f22:	75 05                	jne    800f29 <strchr+0x1d>
			return (char *) s;
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	eb 11                	jmp    800f3a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f29:	ff 45 08             	incl   0x8(%ebp)
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	84 c0                	test   %al,%al
  800f33:	75 e5                	jne    800f1a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f3a:	c9                   	leave  
  800f3b:	c3                   	ret    

00800f3c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
  800f3f:	83 ec 04             	sub    $0x4,%esp
  800f42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f45:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f48:	eb 0d                	jmp    800f57 <strfind+0x1b>
		if (*s == c)
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f52:	74 0e                	je     800f62 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f54:	ff 45 08             	incl   0x8(%ebp)
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	84 c0                	test   %al,%al
  800f5e:	75 ea                	jne    800f4a <strfind+0xe>
  800f60:	eb 01                	jmp    800f63 <strfind+0x27>
		if (*s == c)
			break;
  800f62:	90                   	nop
	return (char *) s;
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f66:	c9                   	leave  
  800f67:	c3                   	ret    

00800f68 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f68:	55                   	push   %ebp
  800f69:	89 e5                	mov    %esp,%ebp
  800f6b:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f74:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f78:	76 63                	jbe    800fdd <memset+0x75>
		uint64 data_block = c;
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	99                   	cltd   
  800f7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f81:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8a:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f8e:	c1 e0 08             	shl    $0x8,%eax
  800f91:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f94:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f9d:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800fa1:	c1 e0 10             	shl    $0x10,%eax
  800fa4:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fa7:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800faa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fb0:	89 c2                	mov    %eax,%edx
  800fb2:	b8 00 00 00 00       	mov    $0x0,%eax
  800fb7:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fba:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800fbd:	eb 18                	jmp    800fd7 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800fbf:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fc2:	8d 41 08             	lea    0x8(%ecx),%eax
  800fc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fce:	89 01                	mov    %eax,(%ecx)
  800fd0:	89 51 04             	mov    %edx,0x4(%ecx)
  800fd3:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800fd7:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fdb:	77 e2                	ja     800fbf <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800fdd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe1:	74 23                	je     801006 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800fe3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fe9:	eb 0e                	jmp    800ff9 <memset+0x91>
			*p8++ = (uint8)c;
  800feb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fee:	8d 50 01             	lea    0x1(%eax),%edx
  800ff1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ff4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff7:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ff9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fff:	89 55 10             	mov    %edx,0x10(%ebp)
  801002:	85 c0                	test   %eax,%eax
  801004:	75 e5                	jne    800feb <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801011:	8b 45 0c             	mov    0xc(%ebp),%eax
  801014:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  80101d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801021:	76 24                	jbe    801047 <memcpy+0x3c>
		while(n >= 8){
  801023:	eb 1c                	jmp    801041 <memcpy+0x36>
			*d64 = *s64;
  801025:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801028:	8b 50 04             	mov    0x4(%eax),%edx
  80102b:	8b 00                	mov    (%eax),%eax
  80102d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801030:	89 01                	mov    %eax,(%ecx)
  801032:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801035:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801039:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80103d:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801041:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801045:	77 de                	ja     801025 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801047:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80104b:	74 31                	je     80107e <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80104d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801050:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801053:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801056:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801059:	eb 16                	jmp    801071 <memcpy+0x66>
			*d8++ = *s8++;
  80105b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80105e:	8d 50 01             	lea    0x1(%eax),%edx
  801061:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801064:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801067:	8d 4a 01             	lea    0x1(%edx),%ecx
  80106a:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80106d:	8a 12                	mov    (%edx),%dl
  80106f:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801071:	8b 45 10             	mov    0x10(%ebp),%eax
  801074:	8d 50 ff             	lea    -0x1(%eax),%edx
  801077:	89 55 10             	mov    %edx,0x10(%ebp)
  80107a:	85 c0                	test   %eax,%eax
  80107c:	75 dd                	jne    80105b <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801081:	c9                   	leave  
  801082:	c3                   	ret    

00801083 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801083:	55                   	push   %ebp
  801084:	89 e5                	mov    %esp,%ebp
  801086:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801095:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801098:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80109b:	73 50                	jae    8010ed <memmove+0x6a>
  80109d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a3:	01 d0                	add    %edx,%eax
  8010a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010a8:	76 43                	jbe    8010ed <memmove+0x6a>
		s += n;
  8010aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ad:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010b6:	eb 10                	jmp    8010c8 <memmove+0x45>
			*--d = *--s;
  8010b8:	ff 4d f8             	decl   -0x8(%ebp)
  8010bb:	ff 4d fc             	decl   -0x4(%ebp)
  8010be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c1:	8a 10                	mov    (%eax),%dl
  8010c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d1:	85 c0                	test   %eax,%eax
  8010d3:	75 e3                	jne    8010b8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010d5:	eb 23                	jmp    8010fa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010da:	8d 50 01             	lea    0x1(%eax),%edx
  8010dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010e9:	8a 12                	mov    (%edx),%dl
  8010eb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f6:	85 c0                	test   %eax,%eax
  8010f8:	75 dd                	jne    8010d7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010fd:	c9                   	leave  
  8010fe:	c3                   	ret    

008010ff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010ff:	55                   	push   %ebp
  801100:	89 e5                	mov    %esp,%ebp
  801102:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801111:	eb 2a                	jmp    80113d <memcmp+0x3e>
		if (*s1 != *s2)
  801113:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801116:	8a 10                	mov    (%eax),%dl
  801118:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111b:	8a 00                	mov    (%eax),%al
  80111d:	38 c2                	cmp    %al,%dl
  80111f:	74 16                	je     801137 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801121:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	0f b6 d0             	movzbl %al,%edx
  801129:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	0f b6 c0             	movzbl %al,%eax
  801131:	29 c2                	sub    %eax,%edx
  801133:	89 d0                	mov    %edx,%eax
  801135:	eb 18                	jmp    80114f <memcmp+0x50>
		s1++, s2++;
  801137:	ff 45 fc             	incl   -0x4(%ebp)
  80113a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80113d:	8b 45 10             	mov    0x10(%ebp),%eax
  801140:	8d 50 ff             	lea    -0x1(%eax),%edx
  801143:	89 55 10             	mov    %edx,0x10(%ebp)
  801146:	85 c0                	test   %eax,%eax
  801148:	75 c9                	jne    801113 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80114a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80114f:	c9                   	leave  
  801150:	c3                   	ret    

00801151 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801151:	55                   	push   %ebp
  801152:	89 e5                	mov    %esp,%ebp
  801154:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801157:	8b 55 08             	mov    0x8(%ebp),%edx
  80115a:	8b 45 10             	mov    0x10(%ebp),%eax
  80115d:	01 d0                	add    %edx,%eax
  80115f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801162:	eb 15                	jmp    801179 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	0f b6 d0             	movzbl %al,%edx
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	0f b6 c0             	movzbl %al,%eax
  801172:	39 c2                	cmp    %eax,%edx
  801174:	74 0d                	je     801183 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801176:	ff 45 08             	incl   0x8(%ebp)
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80117f:	72 e3                	jb     801164 <memfind+0x13>
  801181:	eb 01                	jmp    801184 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801183:	90                   	nop
	return (void *) s;
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801187:	c9                   	leave  
  801188:	c3                   	ret    

00801189 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801189:	55                   	push   %ebp
  80118a:	89 e5                	mov    %esp,%ebp
  80118c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80118f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801196:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80119d:	eb 03                	jmp    8011a2 <strtol+0x19>
		s++;
  80119f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 20                	cmp    $0x20,%al
  8011a9:	74 f4                	je     80119f <strtol+0x16>
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	3c 09                	cmp    $0x9,%al
  8011b2:	74 eb                	je     80119f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	3c 2b                	cmp    $0x2b,%al
  8011bb:	75 05                	jne    8011c2 <strtol+0x39>
		s++;
  8011bd:	ff 45 08             	incl   0x8(%ebp)
  8011c0:	eb 13                	jmp    8011d5 <strtol+0x4c>
	else if (*s == '-')
  8011c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	3c 2d                	cmp    $0x2d,%al
  8011c9:	75 0a                	jne    8011d5 <strtol+0x4c>
		s++, neg = 1;
  8011cb:	ff 45 08             	incl   0x8(%ebp)
  8011ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d9:	74 06                	je     8011e1 <strtol+0x58>
  8011db:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011df:	75 20                	jne    801201 <strtol+0x78>
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	3c 30                	cmp    $0x30,%al
  8011e8:	75 17                	jne    801201 <strtol+0x78>
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	40                   	inc    %eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3c 78                	cmp    $0x78,%al
  8011f2:	75 0d                	jne    801201 <strtol+0x78>
		s += 2, base = 16;
  8011f4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011f8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011ff:	eb 28                	jmp    801229 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801201:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801205:	75 15                	jne    80121c <strtol+0x93>
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	3c 30                	cmp    $0x30,%al
  80120e:	75 0c                	jne    80121c <strtol+0x93>
		s++, base = 8;
  801210:	ff 45 08             	incl   0x8(%ebp)
  801213:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80121a:	eb 0d                	jmp    801229 <strtol+0xa0>
	else if (base == 0)
  80121c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801220:	75 07                	jne    801229 <strtol+0xa0>
		base = 10;
  801222:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	3c 2f                	cmp    $0x2f,%al
  801230:	7e 19                	jle    80124b <strtol+0xc2>
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	3c 39                	cmp    $0x39,%al
  801239:	7f 10                	jg     80124b <strtol+0xc2>
			dig = *s - '0';
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	8a 00                	mov    (%eax),%al
  801240:	0f be c0             	movsbl %al,%eax
  801243:	83 e8 30             	sub    $0x30,%eax
  801246:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801249:	eb 42                	jmp    80128d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 60                	cmp    $0x60,%al
  801252:	7e 19                	jle    80126d <strtol+0xe4>
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	3c 7a                	cmp    $0x7a,%al
  80125b:	7f 10                	jg     80126d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	0f be c0             	movsbl %al,%eax
  801265:	83 e8 57             	sub    $0x57,%eax
  801268:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80126b:	eb 20                	jmp    80128d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	3c 40                	cmp    $0x40,%al
  801274:	7e 39                	jle    8012af <strtol+0x126>
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	3c 5a                	cmp    $0x5a,%al
  80127d:	7f 30                	jg     8012af <strtol+0x126>
			dig = *s - 'A' + 10;
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	8a 00                	mov    (%eax),%al
  801284:	0f be c0             	movsbl %al,%eax
  801287:	83 e8 37             	sub    $0x37,%eax
  80128a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80128d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801290:	3b 45 10             	cmp    0x10(%ebp),%eax
  801293:	7d 19                	jge    8012ae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801295:	ff 45 08             	incl   0x8(%ebp)
  801298:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80129f:	89 c2                	mov    %eax,%edx
  8012a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012a4:	01 d0                	add    %edx,%eax
  8012a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012a9:	e9 7b ff ff ff       	jmp    801229 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012ae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012b3:	74 08                	je     8012bd <strtol+0x134>
		*endptr = (char *) s;
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8012bb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012c1:	74 07                	je     8012ca <strtol+0x141>
  8012c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c6:	f7 d8                	neg    %eax
  8012c8:	eb 03                	jmp    8012cd <strtol+0x144>
  8012ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <ltostr>:

void
ltostr(long value, char *str)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
  8012d2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e7:	79 13                	jns    8012fc <ltostr+0x2d>
	{
		neg = 1;
  8012e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012f6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012f9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801304:	99                   	cltd   
  801305:	f7 f9                	idiv   %ecx
  801307:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80130a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80130d:	8d 50 01             	lea    0x1(%eax),%edx
  801310:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801313:	89 c2                	mov    %eax,%edx
  801315:	8b 45 0c             	mov    0xc(%ebp),%eax
  801318:	01 d0                	add    %edx,%eax
  80131a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80131d:	83 c2 30             	add    $0x30,%edx
  801320:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801322:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801325:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80132a:	f7 e9                	imul   %ecx
  80132c:	c1 fa 02             	sar    $0x2,%edx
  80132f:	89 c8                	mov    %ecx,%eax
  801331:	c1 f8 1f             	sar    $0x1f,%eax
  801334:	29 c2                	sub    %eax,%edx
  801336:	89 d0                	mov    %edx,%eax
  801338:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80133b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80133f:	75 bb                	jne    8012fc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801341:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801348:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134b:	48                   	dec    %eax
  80134c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80134f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801353:	74 3d                	je     801392 <ltostr+0xc3>
		start = 1 ;
  801355:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80135c:	eb 34                	jmp    801392 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80135e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801361:	8b 45 0c             	mov    0xc(%ebp),%eax
  801364:	01 d0                	add    %edx,%eax
  801366:	8a 00                	mov    (%eax),%al
  801368:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80136b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80136e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801371:	01 c2                	add    %eax,%edx
  801373:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801376:	8b 45 0c             	mov    0xc(%ebp),%eax
  801379:	01 c8                	add    %ecx,%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80137f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801382:	8b 45 0c             	mov    0xc(%ebp),%eax
  801385:	01 c2                	add    %eax,%edx
  801387:	8a 45 eb             	mov    -0x15(%ebp),%al
  80138a:	88 02                	mov    %al,(%edx)
		start++ ;
  80138c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80138f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801392:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801395:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801398:	7c c4                	jl     80135e <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80139a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80139d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a0:	01 d0                	add    %edx,%eax
  8013a2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013a5:	90                   	nop
  8013a6:	c9                   	leave  
  8013a7:	c3                   	ret    

008013a8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013a8:	55                   	push   %ebp
  8013a9:	89 e5                	mov    %esp,%ebp
  8013ab:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013ae:	ff 75 08             	pushl  0x8(%ebp)
  8013b1:	e8 c4 f9 ff ff       	call   800d7a <strlen>
  8013b6:	83 c4 04             	add    $0x4,%esp
  8013b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013bc:	ff 75 0c             	pushl  0xc(%ebp)
  8013bf:	e8 b6 f9 ff ff       	call   800d7a <strlen>
  8013c4:	83 c4 04             	add    $0x4,%esp
  8013c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d8:	eb 17                	jmp    8013f1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e0:	01 c2                	add    %eax,%edx
  8013e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	01 c8                	add    %ecx,%eax
  8013ea:	8a 00                	mov    (%eax),%al
  8013ec:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013ee:	ff 45 fc             	incl   -0x4(%ebp)
  8013f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013f7:	7c e1                	jl     8013da <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801400:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801407:	eb 1f                	jmp    801428 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140c:	8d 50 01             	lea    0x1(%eax),%edx
  80140f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801412:	89 c2                	mov    %eax,%edx
  801414:	8b 45 10             	mov    0x10(%ebp),%eax
  801417:	01 c2                	add    %eax,%edx
  801419:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80141c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141f:	01 c8                	add    %ecx,%eax
  801421:	8a 00                	mov    (%eax),%al
  801423:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801425:	ff 45 f8             	incl   -0x8(%ebp)
  801428:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80142b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80142e:	7c d9                	jl     801409 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801430:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801433:	8b 45 10             	mov    0x10(%ebp),%eax
  801436:	01 d0                	add    %edx,%eax
  801438:	c6 00 00             	movb   $0x0,(%eax)
}
  80143b:	90                   	nop
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801441:	8b 45 14             	mov    0x14(%ebp),%eax
  801444:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80144a:	8b 45 14             	mov    0x14(%ebp),%eax
  80144d:	8b 00                	mov    (%eax),%eax
  80144f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801456:	8b 45 10             	mov    0x10(%ebp),%eax
  801459:	01 d0                	add    %edx,%eax
  80145b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801461:	eb 0c                	jmp    80146f <strsplit+0x31>
			*string++ = 0;
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	8d 50 01             	lea    0x1(%eax),%edx
  801469:	89 55 08             	mov    %edx,0x8(%ebp)
  80146c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	84 c0                	test   %al,%al
  801476:	74 18                	je     801490 <strsplit+0x52>
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	0f be c0             	movsbl %al,%eax
  801480:	50                   	push   %eax
  801481:	ff 75 0c             	pushl  0xc(%ebp)
  801484:	e8 83 fa ff ff       	call   800f0c <strchr>
  801489:	83 c4 08             	add    $0x8,%esp
  80148c:	85 c0                	test   %eax,%eax
  80148e:	75 d3                	jne    801463 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	84 c0                	test   %al,%al
  801497:	74 5a                	je     8014f3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801499:	8b 45 14             	mov    0x14(%ebp),%eax
  80149c:	8b 00                	mov    (%eax),%eax
  80149e:	83 f8 0f             	cmp    $0xf,%eax
  8014a1:	75 07                	jne    8014aa <strsplit+0x6c>
		{
			return 0;
  8014a3:	b8 00 00 00 00       	mov    $0x0,%eax
  8014a8:	eb 66                	jmp    801510 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ad:	8b 00                	mov    (%eax),%eax
  8014af:	8d 48 01             	lea    0x1(%eax),%ecx
  8014b2:	8b 55 14             	mov    0x14(%ebp),%edx
  8014b5:	89 0a                	mov    %ecx,(%edx)
  8014b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014be:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c1:	01 c2                	add    %eax,%edx
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c8:	eb 03                	jmp    8014cd <strsplit+0x8f>
			string++;
  8014ca:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	84 c0                	test   %al,%al
  8014d4:	74 8b                	je     801461 <strsplit+0x23>
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	0f be c0             	movsbl %al,%eax
  8014de:	50                   	push   %eax
  8014df:	ff 75 0c             	pushl  0xc(%ebp)
  8014e2:	e8 25 fa ff ff       	call   800f0c <strchr>
  8014e7:	83 c4 08             	add    $0x8,%esp
  8014ea:	85 c0                	test   %eax,%eax
  8014ec:	74 dc                	je     8014ca <strsplit+0x8c>
			string++;
	}
  8014ee:	e9 6e ff ff ff       	jmp    801461 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014f3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f7:	8b 00                	mov    (%eax),%eax
  8014f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801500:	8b 45 10             	mov    0x10(%ebp),%eax
  801503:	01 d0                	add    %edx,%eax
  801505:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80150b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801510:	c9                   	leave  
  801511:	c3                   	ret    

00801512 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801512:	55                   	push   %ebp
  801513:	89 e5                	mov    %esp,%ebp
  801515:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80151e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801525:	eb 4a                	jmp    801571 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801527:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	01 c2                	add    %eax,%edx
  80152f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801532:	8b 45 0c             	mov    0xc(%ebp),%eax
  801535:	01 c8                	add    %ecx,%eax
  801537:	8a 00                	mov    (%eax),%al
  801539:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80153b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80153e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801541:	01 d0                	add    %edx,%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	3c 40                	cmp    $0x40,%al
  801547:	7e 25                	jle    80156e <str2lower+0x5c>
  801549:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154f:	01 d0                	add    %edx,%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	3c 5a                	cmp    $0x5a,%al
  801555:	7f 17                	jg     80156e <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801557:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
  80155d:	01 d0                	add    %edx,%eax
  80155f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801562:	8b 55 08             	mov    0x8(%ebp),%edx
  801565:	01 ca                	add    %ecx,%edx
  801567:	8a 12                	mov    (%edx),%dl
  801569:	83 c2 20             	add    $0x20,%edx
  80156c:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80156e:	ff 45 fc             	incl   -0x4(%ebp)
  801571:	ff 75 0c             	pushl  0xc(%ebp)
  801574:	e8 01 f8 ff ff       	call   800d7a <strlen>
  801579:	83 c4 04             	add    $0x4,%esp
  80157c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80157f:	7f a6                	jg     801527 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	57                   	push   %edi
  80158a:	56                   	push   %esi
  80158b:	53                   	push   %ebx
  80158c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	8b 55 0c             	mov    0xc(%ebp),%edx
  801595:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801598:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80159b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80159e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015a1:	cd 30                	int    $0x30
  8015a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015a9:	83 c4 10             	add    $0x10,%esp
  8015ac:	5b                   	pop    %ebx
  8015ad:	5e                   	pop    %esi
  8015ae:	5f                   	pop    %edi
  8015af:	5d                   	pop    %ebp
  8015b0:	c3                   	ret    

008015b1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
  8015b4:	83 ec 04             	sub    $0x4,%esp
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8015bd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	6a 00                	push   $0x0
  8015c9:	51                   	push   %ecx
  8015ca:	52                   	push   %edx
  8015cb:	ff 75 0c             	pushl  0xc(%ebp)
  8015ce:	50                   	push   %eax
  8015cf:	6a 00                	push   $0x0
  8015d1:	e8 b0 ff ff ff       	call   801586 <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	90                   	nop
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <sys_cgetc>:

int
sys_cgetc(void)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 02                	push   $0x2
  8015eb:	e8 96 ff ff ff       	call   801586 <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 03                	push   $0x3
  801604:	e8 7d ff ff ff       	call   801586 <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	90                   	nop
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 04                	push   $0x4
  80161e:	e8 63 ff ff ff       	call   801586 <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	90                   	nop
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80162c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	52                   	push   %edx
  801639:	50                   	push   %eax
  80163a:	6a 08                	push   $0x8
  80163c:	e8 45 ff ff ff       	call   801586 <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
  801649:	56                   	push   %esi
  80164a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80164b:	8b 75 18             	mov    0x18(%ebp),%esi
  80164e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801651:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801654:	8b 55 0c             	mov    0xc(%ebp),%edx
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	56                   	push   %esi
  80165b:	53                   	push   %ebx
  80165c:	51                   	push   %ecx
  80165d:	52                   	push   %edx
  80165e:	50                   	push   %eax
  80165f:	6a 09                	push   $0x9
  801661:	e8 20 ff ff ff       	call   801586 <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80166c:	5b                   	pop    %ebx
  80166d:	5e                   	pop    %esi
  80166e:	5d                   	pop    %ebp
  80166f:	c3                   	ret    

00801670 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	ff 75 08             	pushl  0x8(%ebp)
  80167e:	6a 0a                	push   $0xa
  801680:	e8 01 ff ff ff       	call   801586 <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
}
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	ff 75 0c             	pushl  0xc(%ebp)
  801696:	ff 75 08             	pushl  0x8(%ebp)
  801699:	6a 0b                	push   $0xb
  80169b:	e8 e6 fe ff ff       	call   801586 <syscall>
  8016a0:	83 c4 18             	add    $0x18,%esp
}
  8016a3:	c9                   	leave  
  8016a4:	c3                   	ret    

008016a5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 0c                	push   $0xc
  8016b4:	e8 cd fe ff ff       	call   801586 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
}
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 0d                	push   $0xd
  8016cd:	e8 b4 fe ff ff       	call   801586 <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 0e                	push   $0xe
  8016e6:	e8 9b fe ff ff       	call   801586 <syscall>
  8016eb:	83 c4 18             	add    $0x18,%esp
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 0f                	push   $0xf
  8016ff:	e8 82 fe ff ff       	call   801586 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
}
  801707:	c9                   	leave  
  801708:	c3                   	ret    

00801709 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	ff 75 08             	pushl  0x8(%ebp)
  801717:	6a 10                	push   $0x10
  801719:	e8 68 fe ff ff       	call   801586 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 11                	push   $0x11
  801732:	e8 4f fe ff ff       	call   801586 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_cputc>:

void
sys_cputc(const char c)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 04             	sub    $0x4,%esp
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
  801746:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801749:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	50                   	push   %eax
  801756:	6a 01                	push   $0x1
  801758:	e8 29 fe ff ff       	call   801586 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
}
  801760:	90                   	nop
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 14                	push   $0x14
  801772:	e8 0f fe ff ff       	call   801586 <syscall>
  801777:	83 c4 18             	add    $0x18,%esp
}
  80177a:	90                   	nop
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
  801780:	83 ec 04             	sub    $0x4,%esp
  801783:	8b 45 10             	mov    0x10(%ebp),%eax
  801786:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801789:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80178c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801790:	8b 45 08             	mov    0x8(%ebp),%eax
  801793:	6a 00                	push   $0x0
  801795:	51                   	push   %ecx
  801796:	52                   	push   %edx
  801797:	ff 75 0c             	pushl  0xc(%ebp)
  80179a:	50                   	push   %eax
  80179b:	6a 15                	push   $0x15
  80179d:	e8 e4 fd ff ff       	call   801586 <syscall>
  8017a2:	83 c4 18             	add    $0x18,%esp
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8017aa:	8b 55 10             	mov    0x10(%ebp),%edx
  8017ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	52                   	push   %edx
  8017b5:	50                   	push   %eax
  8017b6:	ff 75 08             	pushl  0x8(%ebp)
  8017b9:	6a 16                	push   $0x16
  8017bb:	e8 c6 fd ff ff       	call   801586 <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8017c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	52                   	push   %edx
  8017d5:	50                   	push   %eax
  8017d6:	6a 17                	push   $0x17
  8017d8:	e8 a9 fd ff ff       	call   801586 <syscall>
  8017dd:	83 c4 18             	add    $0x18,%esp
}
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8017e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	52                   	push   %edx
  8017f2:	50                   	push   %eax
  8017f3:	6a 18                	push   $0x18
  8017f5:	e8 8c fd ff ff       	call   801586 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801802:	8b 45 08             	mov    0x8(%ebp),%eax
  801805:	6a 00                	push   $0x0
  801807:	ff 75 14             	pushl  0x14(%ebp)
  80180a:	ff 75 10             	pushl  0x10(%ebp)
  80180d:	ff 75 0c             	pushl  0xc(%ebp)
  801810:	50                   	push   %eax
  801811:	6a 19                	push   $0x19
  801813:	e8 6e fd ff ff       	call   801586 <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
}
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <sys_run_env>:

void sys_run_env(int32 envId)
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801820:	8b 45 08             	mov    0x8(%ebp),%eax
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	50                   	push   %eax
  80182c:	6a 1a                	push   $0x1a
  80182e:	e8 53 fd ff ff       	call   801586 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	90                   	nop
  801837:	c9                   	leave  
  801838:	c3                   	ret    

00801839 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	50                   	push   %eax
  801848:	6a 1b                	push   $0x1b
  80184a:	e8 37 fd ff ff       	call   801586 <syscall>
  80184f:	83 c4 18             	add    $0x18,%esp
}
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 05                	push   $0x5
  801863:	e8 1e fd ff ff       	call   801586 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 06                	push   $0x6
  80187c:	e8 05 fd ff ff       	call   801586 <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 07                	push   $0x7
  801895:	e8 ec fc ff ff       	call   801586 <syscall>
  80189a:	83 c4 18             	add    $0x18,%esp
}
  80189d:	c9                   	leave  
  80189e:	c3                   	ret    

0080189f <sys_exit_env>:


void sys_exit_env(void)
{
  80189f:	55                   	push   %ebp
  8018a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 1c                	push   $0x1c
  8018ae:	e8 d3 fc ff ff       	call   801586 <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	90                   	nop
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	ff 75 10             	pushl  0x10(%ebp)
  8018c3:	ff 75 0c             	pushl  0xc(%ebp)
  8018c6:	ff 75 08             	pushl  0x8(%ebp)
  8018c9:	6a 13                	push   $0x13
  8018cb:	e8 b6 fc ff ff       	call   801586 <syscall>
  8018d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d3:	90                   	nop
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 1e                	push   $0x1e
  8018e5:	e8 9c fc ff ff       	call   801586 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
  8018f2:	83 ec 04             	sub    $0x4,%esp
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018fb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	50                   	push   %eax
  801908:	6a 1f                	push   $0x1f
  80190a:	e8 77 fc ff ff       	call   801586 <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
	return ;
  801912:	90                   	nop
}
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <rsttst>:
void rsttst()
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 21                	push   $0x21
  801924:	e8 5d fc ff ff       	call   801586 <syscall>
  801929:	83 c4 18             	add    $0x18,%esp
	return ;
  80192c:	90                   	nop
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
  801932:	83 ec 04             	sub    $0x4,%esp
  801935:	8b 45 14             	mov    0x14(%ebp),%eax
  801938:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80193b:	8b 55 18             	mov    0x18(%ebp),%edx
  80193e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801942:	52                   	push   %edx
  801943:	50                   	push   %eax
  801944:	ff 75 10             	pushl  0x10(%ebp)
  801947:	ff 75 0c             	pushl  0xc(%ebp)
  80194a:	ff 75 08             	pushl  0x8(%ebp)
  80194d:	6a 20                	push   $0x20
  80194f:	e8 32 fc ff ff       	call   801586 <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
	return ;
  801957:	90                   	nop
}
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <chktst>:
void chktst(uint32 n)
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	ff 75 08             	pushl  0x8(%ebp)
  801968:	6a 22                	push   $0x22
  80196a:	e8 17 fc ff ff       	call   801586 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
	return ;
  801972:	90                   	nop
}
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <inctst>:

void inctst()
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 23                	push   $0x23
  801984:	e8 fd fb ff ff       	call   801586 <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
	return ;
  80198c:	90                   	nop
}
  80198d:	c9                   	leave  
  80198e:	c3                   	ret    

0080198f <gettst>:
uint32 gettst()
{
  80198f:	55                   	push   %ebp
  801990:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 24                	push   $0x24
  80199e:	e8 e3 fb ff ff       	call   801586 <syscall>
  8019a3:	83 c4 18             	add    $0x18,%esp
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 25                	push   $0x25
  8019b7:	e8 ca fb ff ff       	call   801586 <syscall>
  8019bc:	83 c4 18             	add    $0x18,%esp
  8019bf:	a3 a4 f0 80 00       	mov    %eax,0x80f0a4
	return uheapPlaceStrategy ;
  8019c4:	a1 a4 f0 80 00       	mov    0x80f0a4,%eax
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	a3 a4 f0 80 00       	mov    %eax,0x80f0a4
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	ff 75 08             	pushl  0x8(%ebp)
  8019e1:	6a 26                	push   $0x26
  8019e3:	e8 9e fb ff ff       	call   801586 <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019eb:	90                   	nop
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
  8019f1:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8019f2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fe:	6a 00                	push   $0x0
  801a00:	53                   	push   %ebx
  801a01:	51                   	push   %ecx
  801a02:	52                   	push   %edx
  801a03:	50                   	push   %eax
  801a04:	6a 27                	push   $0x27
  801a06:	e8 7b fb ff ff       	call   801586 <syscall>
  801a0b:	83 c4 18             	add    $0x18,%esp
}
  801a0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	52                   	push   %edx
  801a23:	50                   	push   %eax
  801a24:	6a 28                	push   $0x28
  801a26:	e8 5b fb ff ff       	call   801586 <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
}
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801a33:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a36:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a39:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3c:	6a 00                	push   $0x0
  801a3e:	51                   	push   %ecx
  801a3f:	ff 75 10             	pushl  0x10(%ebp)
  801a42:	52                   	push   %edx
  801a43:	50                   	push   %eax
  801a44:	6a 29                	push   $0x29
  801a46:	e8 3b fb ff ff       	call   801586 <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
}
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	ff 75 10             	pushl  0x10(%ebp)
  801a5a:	ff 75 0c             	pushl  0xc(%ebp)
  801a5d:	ff 75 08             	pushl  0x8(%ebp)
  801a60:	6a 12                	push   $0x12
  801a62:	e8 1f fb ff ff       	call   801586 <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6a:	90                   	nop
}
  801a6b:	c9                   	leave  
  801a6c:	c3                   	ret    

00801a6d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801a70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a73:	8b 45 08             	mov    0x8(%ebp),%eax
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	52                   	push   %edx
  801a7d:	50                   	push   %eax
  801a7e:	6a 2a                	push   $0x2a
  801a80:	e8 01 fb ff ff       	call   801586 <syscall>
  801a85:	83 c4 18             	add    $0x18,%esp
	return;
  801a88:	90                   	nop
}
  801a89:	c9                   	leave  
  801a8a:	c3                   	ret    

00801a8b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a8b:	55                   	push   %ebp
  801a8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 2b                	push   $0x2b
  801a9a:	e8 e7 fa ff ff       	call   801586 <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
  801aa7:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801aaa:	83 ec 04             	sub    $0x4,%esp
  801aad:	68 68 26 80 00       	push   $0x802668
  801ab2:	68 0a 01 00 00       	push   $0x10a
  801ab7:	68 78 26 80 00       	push   $0x802678
  801abc:	e8 12 e9 ff ff       	call   8003d3 <_panic>

00801ac1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	ff 75 0c             	pushl  0xc(%ebp)
  801acd:	ff 75 08             	pushl  0x8(%ebp)
  801ad0:	6a 33                	push   $0x33
  801ad2:	e8 af fa ff ff       	call   801586 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
	return;
  801ada:	90                   	nop
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	ff 75 0c             	pushl  0xc(%ebp)
  801ae9:	ff 75 08             	pushl  0x8(%ebp)
  801aec:	6a 34                	push   $0x34
  801aee:	e8 93 fa ff ff       	call   801586 <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
	return ;
  801af6:	90                   	nop
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    
  801af9:	66 90                	xchg   %ax,%ax
  801afb:	90                   	nop

00801afc <__udivdi3>:
  801afc:	55                   	push   %ebp
  801afd:	57                   	push   %edi
  801afe:	56                   	push   %esi
  801aff:	53                   	push   %ebx
  801b00:	83 ec 1c             	sub    $0x1c,%esp
  801b03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b13:	89 ca                	mov    %ecx,%edx
  801b15:	89 f8                	mov    %edi,%eax
  801b17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b1b:	85 f6                	test   %esi,%esi
  801b1d:	75 2d                	jne    801b4c <__udivdi3+0x50>
  801b1f:	39 cf                	cmp    %ecx,%edi
  801b21:	77 65                	ja     801b88 <__udivdi3+0x8c>
  801b23:	89 fd                	mov    %edi,%ebp
  801b25:	85 ff                	test   %edi,%edi
  801b27:	75 0b                	jne    801b34 <__udivdi3+0x38>
  801b29:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2e:	31 d2                	xor    %edx,%edx
  801b30:	f7 f7                	div    %edi
  801b32:	89 c5                	mov    %eax,%ebp
  801b34:	31 d2                	xor    %edx,%edx
  801b36:	89 c8                	mov    %ecx,%eax
  801b38:	f7 f5                	div    %ebp
  801b3a:	89 c1                	mov    %eax,%ecx
  801b3c:	89 d8                	mov    %ebx,%eax
  801b3e:	f7 f5                	div    %ebp
  801b40:	89 cf                	mov    %ecx,%edi
  801b42:	89 fa                	mov    %edi,%edx
  801b44:	83 c4 1c             	add    $0x1c,%esp
  801b47:	5b                   	pop    %ebx
  801b48:	5e                   	pop    %esi
  801b49:	5f                   	pop    %edi
  801b4a:	5d                   	pop    %ebp
  801b4b:	c3                   	ret    
  801b4c:	39 ce                	cmp    %ecx,%esi
  801b4e:	77 28                	ja     801b78 <__udivdi3+0x7c>
  801b50:	0f bd fe             	bsr    %esi,%edi
  801b53:	83 f7 1f             	xor    $0x1f,%edi
  801b56:	75 40                	jne    801b98 <__udivdi3+0x9c>
  801b58:	39 ce                	cmp    %ecx,%esi
  801b5a:	72 0a                	jb     801b66 <__udivdi3+0x6a>
  801b5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b60:	0f 87 9e 00 00 00    	ja     801c04 <__udivdi3+0x108>
  801b66:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6b:	89 fa                	mov    %edi,%edx
  801b6d:	83 c4 1c             	add    $0x1c,%esp
  801b70:	5b                   	pop    %ebx
  801b71:	5e                   	pop    %esi
  801b72:	5f                   	pop    %edi
  801b73:	5d                   	pop    %ebp
  801b74:	c3                   	ret    
  801b75:	8d 76 00             	lea    0x0(%esi),%esi
  801b78:	31 ff                	xor    %edi,%edi
  801b7a:	31 c0                	xor    %eax,%eax
  801b7c:	89 fa                	mov    %edi,%edx
  801b7e:	83 c4 1c             	add    $0x1c,%esp
  801b81:	5b                   	pop    %ebx
  801b82:	5e                   	pop    %esi
  801b83:	5f                   	pop    %edi
  801b84:	5d                   	pop    %ebp
  801b85:	c3                   	ret    
  801b86:	66 90                	xchg   %ax,%ax
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	f7 f7                	div    %edi
  801b8c:	31 ff                	xor    %edi,%edi
  801b8e:	89 fa                	mov    %edi,%edx
  801b90:	83 c4 1c             	add    $0x1c,%esp
  801b93:	5b                   	pop    %ebx
  801b94:	5e                   	pop    %esi
  801b95:	5f                   	pop    %edi
  801b96:	5d                   	pop    %ebp
  801b97:	c3                   	ret    
  801b98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b9d:	89 eb                	mov    %ebp,%ebx
  801b9f:	29 fb                	sub    %edi,%ebx
  801ba1:	89 f9                	mov    %edi,%ecx
  801ba3:	d3 e6                	shl    %cl,%esi
  801ba5:	89 c5                	mov    %eax,%ebp
  801ba7:	88 d9                	mov    %bl,%cl
  801ba9:	d3 ed                	shr    %cl,%ebp
  801bab:	89 e9                	mov    %ebp,%ecx
  801bad:	09 f1                	or     %esi,%ecx
  801baf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bb3:	89 f9                	mov    %edi,%ecx
  801bb5:	d3 e0                	shl    %cl,%eax
  801bb7:	89 c5                	mov    %eax,%ebp
  801bb9:	89 d6                	mov    %edx,%esi
  801bbb:	88 d9                	mov    %bl,%cl
  801bbd:	d3 ee                	shr    %cl,%esi
  801bbf:	89 f9                	mov    %edi,%ecx
  801bc1:	d3 e2                	shl    %cl,%edx
  801bc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc7:	88 d9                	mov    %bl,%cl
  801bc9:	d3 e8                	shr    %cl,%eax
  801bcb:	09 c2                	or     %eax,%edx
  801bcd:	89 d0                	mov    %edx,%eax
  801bcf:	89 f2                	mov    %esi,%edx
  801bd1:	f7 74 24 0c          	divl   0xc(%esp)
  801bd5:	89 d6                	mov    %edx,%esi
  801bd7:	89 c3                	mov    %eax,%ebx
  801bd9:	f7 e5                	mul    %ebp
  801bdb:	39 d6                	cmp    %edx,%esi
  801bdd:	72 19                	jb     801bf8 <__udivdi3+0xfc>
  801bdf:	74 0b                	je     801bec <__udivdi3+0xf0>
  801be1:	89 d8                	mov    %ebx,%eax
  801be3:	31 ff                	xor    %edi,%edi
  801be5:	e9 58 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bf0:	89 f9                	mov    %edi,%ecx
  801bf2:	d3 e2                	shl    %cl,%edx
  801bf4:	39 c2                	cmp    %eax,%edx
  801bf6:	73 e9                	jae    801be1 <__udivdi3+0xe5>
  801bf8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bfb:	31 ff                	xor    %edi,%edi
  801bfd:	e9 40 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c02:	66 90                	xchg   %ax,%ax
  801c04:	31 c0                	xor    %eax,%eax
  801c06:	e9 37 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c0b:	90                   	nop

00801c0c <__umoddi3>:
  801c0c:	55                   	push   %ebp
  801c0d:	57                   	push   %edi
  801c0e:	56                   	push   %esi
  801c0f:	53                   	push   %ebx
  801c10:	83 ec 1c             	sub    $0x1c,%esp
  801c13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c2b:	89 f3                	mov    %esi,%ebx
  801c2d:	89 fa                	mov    %edi,%edx
  801c2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c33:	89 34 24             	mov    %esi,(%esp)
  801c36:	85 c0                	test   %eax,%eax
  801c38:	75 1a                	jne    801c54 <__umoddi3+0x48>
  801c3a:	39 f7                	cmp    %esi,%edi
  801c3c:	0f 86 a2 00 00 00    	jbe    801ce4 <__umoddi3+0xd8>
  801c42:	89 c8                	mov    %ecx,%eax
  801c44:	89 f2                	mov    %esi,%edx
  801c46:	f7 f7                	div    %edi
  801c48:	89 d0                	mov    %edx,%eax
  801c4a:	31 d2                	xor    %edx,%edx
  801c4c:	83 c4 1c             	add    $0x1c,%esp
  801c4f:	5b                   	pop    %ebx
  801c50:	5e                   	pop    %esi
  801c51:	5f                   	pop    %edi
  801c52:	5d                   	pop    %ebp
  801c53:	c3                   	ret    
  801c54:	39 f0                	cmp    %esi,%eax
  801c56:	0f 87 ac 00 00 00    	ja     801d08 <__umoddi3+0xfc>
  801c5c:	0f bd e8             	bsr    %eax,%ebp
  801c5f:	83 f5 1f             	xor    $0x1f,%ebp
  801c62:	0f 84 ac 00 00 00    	je     801d14 <__umoddi3+0x108>
  801c68:	bf 20 00 00 00       	mov    $0x20,%edi
  801c6d:	29 ef                	sub    %ebp,%edi
  801c6f:	89 fe                	mov    %edi,%esi
  801c71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c75:	89 e9                	mov    %ebp,%ecx
  801c77:	d3 e0                	shl    %cl,%eax
  801c79:	89 d7                	mov    %edx,%edi
  801c7b:	89 f1                	mov    %esi,%ecx
  801c7d:	d3 ef                	shr    %cl,%edi
  801c7f:	09 c7                	or     %eax,%edi
  801c81:	89 e9                	mov    %ebp,%ecx
  801c83:	d3 e2                	shl    %cl,%edx
  801c85:	89 14 24             	mov    %edx,(%esp)
  801c88:	89 d8                	mov    %ebx,%eax
  801c8a:	d3 e0                	shl    %cl,%eax
  801c8c:	89 c2                	mov    %eax,%edx
  801c8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c92:	d3 e0                	shl    %cl,%eax
  801c94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c9c:	89 f1                	mov    %esi,%ecx
  801c9e:	d3 e8                	shr    %cl,%eax
  801ca0:	09 d0                	or     %edx,%eax
  801ca2:	d3 eb                	shr    %cl,%ebx
  801ca4:	89 da                	mov    %ebx,%edx
  801ca6:	f7 f7                	div    %edi
  801ca8:	89 d3                	mov    %edx,%ebx
  801caa:	f7 24 24             	mull   (%esp)
  801cad:	89 c6                	mov    %eax,%esi
  801caf:	89 d1                	mov    %edx,%ecx
  801cb1:	39 d3                	cmp    %edx,%ebx
  801cb3:	0f 82 87 00 00 00    	jb     801d40 <__umoddi3+0x134>
  801cb9:	0f 84 91 00 00 00    	je     801d50 <__umoddi3+0x144>
  801cbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cc3:	29 f2                	sub    %esi,%edx
  801cc5:	19 cb                	sbb    %ecx,%ebx
  801cc7:	89 d8                	mov    %ebx,%eax
  801cc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ccd:	d3 e0                	shl    %cl,%eax
  801ccf:	89 e9                	mov    %ebp,%ecx
  801cd1:	d3 ea                	shr    %cl,%edx
  801cd3:	09 d0                	or     %edx,%eax
  801cd5:	89 e9                	mov    %ebp,%ecx
  801cd7:	d3 eb                	shr    %cl,%ebx
  801cd9:	89 da                	mov    %ebx,%edx
  801cdb:	83 c4 1c             	add    $0x1c,%esp
  801cde:	5b                   	pop    %ebx
  801cdf:	5e                   	pop    %esi
  801ce0:	5f                   	pop    %edi
  801ce1:	5d                   	pop    %ebp
  801ce2:	c3                   	ret    
  801ce3:	90                   	nop
  801ce4:	89 fd                	mov    %edi,%ebp
  801ce6:	85 ff                	test   %edi,%edi
  801ce8:	75 0b                	jne    801cf5 <__umoddi3+0xe9>
  801cea:	b8 01 00 00 00       	mov    $0x1,%eax
  801cef:	31 d2                	xor    %edx,%edx
  801cf1:	f7 f7                	div    %edi
  801cf3:	89 c5                	mov    %eax,%ebp
  801cf5:	89 f0                	mov    %esi,%eax
  801cf7:	31 d2                	xor    %edx,%edx
  801cf9:	f7 f5                	div    %ebp
  801cfb:	89 c8                	mov    %ecx,%eax
  801cfd:	f7 f5                	div    %ebp
  801cff:	89 d0                	mov    %edx,%eax
  801d01:	e9 44 ff ff ff       	jmp    801c4a <__umoddi3+0x3e>
  801d06:	66 90                	xchg   %ax,%ax
  801d08:	89 c8                	mov    %ecx,%eax
  801d0a:	89 f2                	mov    %esi,%edx
  801d0c:	83 c4 1c             	add    $0x1c,%esp
  801d0f:	5b                   	pop    %ebx
  801d10:	5e                   	pop    %esi
  801d11:	5f                   	pop    %edi
  801d12:	5d                   	pop    %ebp
  801d13:	c3                   	ret    
  801d14:	3b 04 24             	cmp    (%esp),%eax
  801d17:	72 06                	jb     801d1f <__umoddi3+0x113>
  801d19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d1d:	77 0f                	ja     801d2e <__umoddi3+0x122>
  801d1f:	89 f2                	mov    %esi,%edx
  801d21:	29 f9                	sub    %edi,%ecx
  801d23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d27:	89 14 24             	mov    %edx,(%esp)
  801d2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d32:	8b 14 24             	mov    (%esp),%edx
  801d35:	83 c4 1c             	add    $0x1c,%esp
  801d38:	5b                   	pop    %ebx
  801d39:	5e                   	pop    %esi
  801d3a:	5f                   	pop    %edi
  801d3b:	5d                   	pop    %ebp
  801d3c:	c3                   	ret    
  801d3d:	8d 76 00             	lea    0x0(%esi),%esi
  801d40:	2b 04 24             	sub    (%esp),%eax
  801d43:	19 fa                	sbb    %edi,%edx
  801d45:	89 d1                	mov    %edx,%ecx
  801d47:	89 c6                	mov    %eax,%esi
  801d49:	e9 71 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
  801d4e:	66 90                	xchg   %ax,%ax
  801d50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d54:	72 ea                	jb     801d40 <__umoddi3+0x134>
  801d56:	89 d9                	mov    %ebx,%ecx
  801d58:	e9 62 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
