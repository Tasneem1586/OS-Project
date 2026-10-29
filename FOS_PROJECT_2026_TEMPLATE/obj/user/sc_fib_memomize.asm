
obj/user/sc_fib_memomize:     file format elf32-i386


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
  800031:	e8 76 01 00 00       	call   8001ac <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int64 fibonacci(int n, int64 *memo);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int index=0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[256];
//	atomic_readline("Please enter Fibonacci index:", buff1);
//	index = strtol(buff1, NULL, 10);

	index = 200;
  800048:	c7 45 f0 c8 00 00 00 	movl   $0xc8,-0x10(%ebp)

	int64 *memo = malloc((index+1) * sizeof(int64));
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	40                   	inc    %eax
  800053:	c1 e0 03             	shl    $0x3,%eax
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	50                   	push   %eax
  80005a:	e8 d3 15 00 00       	call   801632 <malloc>
  80005f:	83 c4 10             	add    $0x10,%esp
  800062:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for (int i = 0; i <= index; ++i)
  800065:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80006c:	eb 1f                	jmp    80008d <_main+0x55>
	{
		memo[i] = 0;
  80006e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800071:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800078:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80007b:	01 d0                	add    %edx,%eax
  80007d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  800083:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
//	index = strtol(buff1, NULL, 10);

	index = 200;

	int64 *memo = malloc((index+1) * sizeof(int64));
	for (int i = 0; i <= index; ++i)
  80008a:	ff 45 f4             	incl   -0xc(%ebp)
  80008d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800090:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800093:	7e d9                	jle    80006e <_main+0x36>
	{
		memo[i] = 0;
	}
	int64 res = fibonacci(index, memo) ;
  800095:	83 ec 08             	sub    $0x8,%esp
  800098:	ff 75 ec             	pushl  -0x14(%ebp)
  80009b:	ff 75 f0             	pushl  -0x10(%ebp)
  80009e:	e8 55 00 00 00       	call   8000f8 <fibonacci>
  8000a3:	83 c4 10             	add    $0x10,%esp
  8000a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000a9:	89 55 e4             	mov    %edx,-0x1c(%ebp)

	if (uheapPageAllocBreak > USER_HEAP_START + DYN_ALLOC_MAX_SIZE + PAGE_SIZE)
  8000ac:	a1 4c 30 80 00       	mov    0x80304c,%eax
  8000b1:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000b6:	76 14                	jbe    8000cc <_main+0x94>
		panic("page alloc is invoked!!");
  8000b8:	83 ec 04             	sub    $0x4,%esp
  8000bb:	68 c0 1f 80 00       	push   $0x801fc0
  8000c0:	6a 19                	push   $0x19
  8000c2:	68 d8 1f 80 00       	push   $0x801fd8
  8000c7:	e8 40 03 00 00       	call   80040c <_panic>

	free(memo);
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d2:	e8 89 15 00 00       	call   801660 <free>
  8000d7:	83 c4 10             	add    $0x10,%esp

	atomic_cprintf("Fibonacci #%d = %lld\n",index, res);
  8000da:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000dd:	ff 75 e0             	pushl  -0x20(%ebp)
  8000e0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e3:	68 ef 1f 80 00       	push   $0x801fef
  8000e8:	e8 5f 06 00 00       	call   80074c <atomic_cprintf>
  8000ed:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
	inctst();
  8000f0:	e8 e1 19 00 00       	call   801ad6 <inctst>
	return;
  8000f5:	90                   	nop
}
  8000f6:	c9                   	leave  
  8000f7:	c3                   	ret    

008000f8 <fibonacci>:


int64 fibonacci(int n, int64 *memo)
{
  8000f8:	55                   	push   %ebp
  8000f9:	89 e5                	mov    %esp,%ebp
  8000fb:	57                   	push   %edi
  8000fc:	56                   	push   %esi
  8000fd:	53                   	push   %ebx
  8000fe:	83 ec 0c             	sub    $0xc,%esp
	if (memo[n]!=0)	return memo[n];
  800101:	8b 45 08             	mov    0x8(%ebp),%eax
  800104:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80010b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80010e:	01 d0                	add    %edx,%eax
  800110:	8b 50 04             	mov    0x4(%eax),%edx
  800113:	8b 00                	mov    (%eax),%eax
  800115:	09 d0                	or     %edx,%eax
  800117:	85 c0                	test   %eax,%eax
  800119:	74 16                	je     800131 <fibonacci+0x39>
  80011b:	8b 45 08             	mov    0x8(%ebp),%eax
  80011e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800125:	8b 45 0c             	mov    0xc(%ebp),%eax
  800128:	01 d0                	add    %edx,%eax
  80012a:	8b 50 04             	mov    0x4(%eax),%edx
  80012d:	8b 00                	mov    (%eax),%eax
  80012f:	eb 73                	jmp    8001a4 <fibonacci+0xac>
	if (n <= 1)
  800131:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800135:	7f 23                	jg     80015a <fibonacci+0x62>
		return memo[n] = 1 ;
  800137:	8b 45 08             	mov    0x8(%ebp),%eax
  80013a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800141:	8b 45 0c             	mov    0xc(%ebp),%eax
  800144:	01 d0                	add    %edx,%eax
  800146:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  80014c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  800153:	8b 50 04             	mov    0x4(%eax),%edx
  800156:	8b 00                	mov    (%eax),%eax
  800158:	eb 4a                	jmp    8001a4 <fibonacci+0xac>
	return (memo[n] = fibonacci(n-1, memo) + fibonacci(n-2, memo)) ;
  80015a:	8b 45 08             	mov    0x8(%ebp),%eax
  80015d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800164:	8b 45 0c             	mov    0xc(%ebp),%eax
  800167:	8d 3c 02             	lea    (%edx,%eax,1),%edi
  80016a:	8b 45 08             	mov    0x8(%ebp),%eax
  80016d:	48                   	dec    %eax
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 0c             	pushl  0xc(%ebp)
  800174:	50                   	push   %eax
  800175:	e8 7e ff ff ff       	call   8000f8 <fibonacci>
  80017a:	83 c4 10             	add    $0x10,%esp
  80017d:	89 c3                	mov    %eax,%ebx
  80017f:	89 d6                	mov    %edx,%esi
  800181:	8b 45 08             	mov    0x8(%ebp),%eax
  800184:	83 e8 02             	sub    $0x2,%eax
  800187:	83 ec 08             	sub    $0x8,%esp
  80018a:	ff 75 0c             	pushl  0xc(%ebp)
  80018d:	50                   	push   %eax
  80018e:	e8 65 ff ff ff       	call   8000f8 <fibonacci>
  800193:	83 c4 10             	add    $0x10,%esp
  800196:	01 d8                	add    %ebx,%eax
  800198:	11 f2                	adc    %esi,%edx
  80019a:	89 07                	mov    %eax,(%edi)
  80019c:	89 57 04             	mov    %edx,0x4(%edi)
  80019f:	8b 07                	mov    (%edi),%eax
  8001a1:	8b 57 04             	mov    0x4(%edi),%edx
}
  8001a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8001a7:	5b                   	pop    %ebx
  8001a8:	5e                   	pop    %esi
  8001a9:	5f                   	pop    %edi
  8001aa:	5d                   	pop    %ebp
  8001ab:	c3                   	ret    

008001ac <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8001ac:	55                   	push   %ebp
  8001ad:	89 e5                	mov    %esp,%ebp
  8001af:	57                   	push   %edi
  8001b0:	56                   	push   %esi
  8001b1:	53                   	push   %ebx
  8001b2:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8001b8:	e8 11 18 00 00       	call   8019ce <sys_getenvindex>
  8001bd:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8001c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8001c3:	89 d0                	mov    %edx,%eax
  8001c5:	c1 e0 03             	shl    $0x3,%eax
  8001c8:	01 d0                	add    %edx,%eax
  8001ca:	c1 e0 06             	shl    $0x6,%eax
  8001cd:	01 d0                	add    %edx,%eax
  8001cf:	c1 e0 03             	shl    $0x3,%eax
  8001d2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001d7:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e1:	8a 40 10             	mov    0x10(%eax),%al
  8001e4:	84 c0                	test   %al,%al
  8001e6:	74 0d                	je     8001f5 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ed:	83 c0 10             	add    $0x10,%eax
  8001f0:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001f9:	7e 0a                	jle    800205 <libmain+0x59>
		binaryname = argv[0];
  8001fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fe:	8b 00                	mov    (%eax),%eax
  800200:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800205:	83 ec 08             	sub    $0x8,%esp
  800208:	ff 75 0c             	pushl  0xc(%ebp)
  80020b:	ff 75 08             	pushl  0x8(%ebp)
  80020e:	e8 25 fe ff ff       	call   800038 <_main>
  800213:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800216:	a1 00 30 80 00       	mov    0x803000,%eax
  80021b:	85 c0                	test   %eax,%eax
  80021d:	0f 84 b7 01 00 00    	je     8003da <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800223:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800229:	bb 44 21 80 00       	mov    $0x802144,%ebx
  80022e:	ba 0e 00 00 00       	mov    $0xe,%edx
  800233:	89 c7                	mov    %eax,%edi
  800235:	89 de                	mov    %ebx,%esi
  800237:	89 d1                	mov    %edx,%ecx
  800239:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80023b:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800241:	b9 56 00 00 00       	mov    $0x56,%ecx
  800246:	b0 00                	mov    $0x0,%al
  800248:	89 d7                	mov    %edx,%edi
  80024a:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80024c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800253:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800256:	83 ec 08             	sub    $0x8,%esp
  800259:	50                   	push   %eax
  80025a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800260:	50                   	push   %eax
  800261:	e8 68 19 00 00       	call   801bce <sys_utilities>
  800266:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800269:	e8 e8 14 00 00       	call   801756 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 20 20 80 00       	push   $0x802020
  800276:	e8 5f 04 00 00       	call   8006da <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80027e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800281:	85 c0                	test   %eax,%eax
  800283:	74 58                	je     8002dd <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800285:	e8 62 19 00 00       	call   801bec <sys_get_optimal_num_faults>
  80028a:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80028d:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800293:	bb a8 21 80 00       	mov    $0x8021a8,%ebx
  800298:	ba 11 00 00 00       	mov    $0x11,%edx
  80029d:	89 c7                	mov    %eax,%edi
  80029f:	89 de                	mov    %ebx,%esi
  8002a1:	89 d1                	mov    %edx,%ecx
  8002a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8002a5:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8002a8:	b9 53 00 00 00       	mov    $0x53,%ecx
  8002ad:	b0 00                	mov    $0x0,%al
  8002af:	89 d7                	mov    %edx,%edi
  8002b1:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8002b3:	83 ec 08             	sub    $0x8,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8002bf:	50                   	push   %eax
  8002c0:	e8 09 19 00 00       	call   801bce <sys_utilities>
  8002c5:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8002c8:	83 ec 08             	sub    $0x8,%esp
  8002cb:	ff 75 dc             	pushl  -0x24(%ebp)
  8002ce:	68 48 20 80 00       	push   $0x802048
  8002d3:	e8 02 04 00 00       	call   8006da <cprintf>
  8002d8:	83 c4 10             	add    $0x10,%esp
  8002db:	eb 59                	jmp    800336 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e2:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ed:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002f3:	83 ec 04             	sub    $0x4,%esp
  8002f6:	52                   	push   %edx
  8002f7:	50                   	push   %eax
  8002f8:	68 6c 20 80 00       	push   $0x80206c
  8002fd:	e8 d8 03 00 00       	call   8006da <cprintf>
  800302:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800305:	a1 20 30 80 00       	mov    0x803020,%eax
  80030a:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800310:	a1 20 30 80 00       	mov    0x803020,%eax
  800315:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80031b:	a1 20 30 80 00       	mov    0x803020,%eax
  800320:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800326:	51                   	push   %ecx
  800327:	52                   	push   %edx
  800328:	50                   	push   %eax
  800329:	68 94 20 80 00       	push   $0x802094
  80032e:	e8 a7 03 00 00       	call   8006da <cprintf>
  800333:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800336:	a1 20 30 80 00       	mov    0x803020,%eax
  80033b:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800341:	83 ec 08             	sub    $0x8,%esp
  800344:	50                   	push   %eax
  800345:	68 ec 20 80 00       	push   $0x8020ec
  80034a:	e8 8b 03 00 00       	call   8006da <cprintf>
  80034f:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800352:	83 ec 0c             	sub    $0xc,%esp
  800355:	68 00 21 80 00       	push   $0x802100
  80035a:	e8 7b 03 00 00       	call   8006da <cprintf>
  80035f:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800362:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800369:	eb 28                	jmp    800393 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80036b:	a1 20 30 80 00       	mov    0x803020,%eax
  800370:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800373:	81 c2 74 04 00 00    	add    $0x474,%edx
  800379:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80037c:	83 ec 04             	sub    $0x4,%esp
  80037f:	50                   	push   %eax
  800380:	ff 75 e4             	pushl  -0x1c(%ebp)
  800383:	68 17 21 80 00       	push   $0x802117
  800388:	e8 4d 03 00 00       	call   8006da <cprintf>
  80038d:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800390:	ff 45 e4             	incl   -0x1c(%ebp)
  800393:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800397:	7e d2                	jle    80036b <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800399:	83 ec 0c             	sub    $0xc,%esp
  80039c:	68 26 21 80 00       	push   $0x802126
  8003a1:	e8 34 03 00 00       	call   8006da <cprintf>
  8003a6:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8003a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ae:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8003b4:	83 ec 08             	sub    $0x8,%esp
  8003b7:	50                   	push   %eax
  8003b8:	68 2a 21 80 00       	push   $0x80212a
  8003bd:	e8 18 03 00 00       	call   8006da <cprintf>
  8003c2:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8003c5:	83 ec 0c             	sub    $0xc,%esp
  8003c8:	68 20 20 80 00       	push   $0x802020
  8003cd:	e8 08 03 00 00       	call   8006da <cprintf>
  8003d2:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8003d5:	e8 96 13 00 00       	call   801770 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8003da:	e8 1f 00 00 00       	call   8003fe <exit>
}
  8003df:	90                   	nop
  8003e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003e3:	5b                   	pop    %ebx
  8003e4:	5e                   	pop    %esi
  8003e5:	5f                   	pop    %edi
  8003e6:	5d                   	pop    %ebp
  8003e7:	c3                   	ret    

008003e8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003e8:	55                   	push   %ebp
  8003e9:	89 e5                	mov    %esp,%ebp
  8003eb:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003ee:	83 ec 0c             	sub    $0xc,%esp
  8003f1:	6a 00                	push   $0x0
  8003f3:	e8 a2 15 00 00       	call   80199a <sys_destroy_env>
  8003f8:	83 c4 10             	add    $0x10,%esp
}
  8003fb:	90                   	nop
  8003fc:	c9                   	leave  
  8003fd:	c3                   	ret    

008003fe <exit>:

void
exit(void)
{
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800404:	e8 f7 15 00 00       	call   801a00 <sys_exit_env>
}
  800409:	90                   	nop
  80040a:	c9                   	leave  
  80040b:	c3                   	ret    

0080040c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80040c:	55                   	push   %ebp
  80040d:	89 e5                	mov    %esp,%ebp
  80040f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800412:	8d 45 10             	lea    0x10(%ebp),%eax
  800415:	83 c0 04             	add    $0x4,%eax
  800418:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80041b:	a1 28 31 80 00       	mov    0x803128,%eax
  800420:	85 c0                	test   %eax,%eax
  800422:	74 16                	je     80043a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800424:	a1 28 31 80 00       	mov    0x803128,%eax
  800429:	83 ec 08             	sub    $0x8,%esp
  80042c:	50                   	push   %eax
  80042d:	68 0c 22 80 00       	push   $0x80220c
  800432:	e8 a3 02 00 00       	call   8006da <cprintf>
  800437:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80043a:	a1 04 30 80 00       	mov    0x803004,%eax
  80043f:	83 ec 0c             	sub    $0xc,%esp
  800442:	ff 75 0c             	pushl  0xc(%ebp)
  800445:	ff 75 08             	pushl  0x8(%ebp)
  800448:	50                   	push   %eax
  800449:	68 14 22 80 00       	push   $0x802214
  80044e:	6a 74                	push   $0x74
  800450:	e8 b2 02 00 00       	call   800707 <cprintf_colored>
  800455:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800458:	8b 45 10             	mov    0x10(%ebp),%eax
  80045b:	83 ec 08             	sub    $0x8,%esp
  80045e:	ff 75 f4             	pushl  -0xc(%ebp)
  800461:	50                   	push   %eax
  800462:	e8 04 02 00 00       	call   80066b <vcprintf>
  800467:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80046a:	83 ec 08             	sub    $0x8,%esp
  80046d:	6a 00                	push   $0x0
  80046f:	68 3c 22 80 00       	push   $0x80223c
  800474:	e8 f2 01 00 00       	call   80066b <vcprintf>
  800479:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80047c:	e8 7d ff ff ff       	call   8003fe <exit>

	// should not return here
	while (1) ;
  800481:	eb fe                	jmp    800481 <_panic+0x75>

00800483 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800483:	55                   	push   %ebp
  800484:	89 e5                	mov    %esp,%ebp
  800486:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800489:	a1 20 30 80 00       	mov    0x803020,%eax
  80048e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800494:	8b 45 0c             	mov    0xc(%ebp),%eax
  800497:	39 c2                	cmp    %eax,%edx
  800499:	74 14                	je     8004af <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80049b:	83 ec 04             	sub    $0x4,%esp
  80049e:	68 40 22 80 00       	push   $0x802240
  8004a3:	6a 26                	push   $0x26
  8004a5:	68 8c 22 80 00       	push   $0x80228c
  8004aa:	e8 5d ff ff ff       	call   80040c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004bd:	e9 c5 00 00 00       	jmp    800587 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8004c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	85 c0                	test   %eax,%eax
  8004d5:	75 08                	jne    8004df <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8004d7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004da:	e9 a5 00 00 00       	jmp    800584 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8004df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004e6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004ed:	eb 69                	jmp    800558 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f4:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004fd:	89 d0                	mov    %edx,%eax
  8004ff:	01 c0                	add    %eax,%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	c1 e0 03             	shl    $0x3,%eax
  800506:	01 c8                	add    %ecx,%eax
  800508:	8a 40 04             	mov    0x4(%eax),%al
  80050b:	84 c0                	test   %al,%al
  80050d:	75 46                	jne    800555 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80050f:	a1 20 30 80 00       	mov    0x803020,%eax
  800514:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80051a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	01 c0                	add    %eax,%eax
  800521:	01 d0                	add    %edx,%eax
  800523:	c1 e0 03             	shl    $0x3,%eax
  800526:	01 c8                	add    %ecx,%eax
  800528:	8b 00                	mov    (%eax),%eax
  80052a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80052d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800530:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800535:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800537:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800541:	8b 45 08             	mov    0x8(%ebp),%eax
  800544:	01 c8                	add    %ecx,%eax
  800546:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800548:	39 c2                	cmp    %eax,%edx
  80054a:	75 09                	jne    800555 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80054c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800553:	eb 15                	jmp    80056a <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800555:	ff 45 e8             	incl   -0x18(%ebp)
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800563:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800566:	39 c2                	cmp    %eax,%edx
  800568:	77 85                	ja     8004ef <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80056a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80056e:	75 14                	jne    800584 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800570:	83 ec 04             	sub    $0x4,%esp
  800573:	68 98 22 80 00       	push   $0x802298
  800578:	6a 3a                	push   $0x3a
  80057a:	68 8c 22 80 00       	push   $0x80228c
  80057f:	e8 88 fe ff ff       	call   80040c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800584:	ff 45 f0             	incl   -0x10(%ebp)
  800587:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80058d:	0f 8c 2f ff ff ff    	jl     8004c2 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800593:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80059a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005a1:	eb 26                	jmp    8005c9 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a8:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005ae:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b1:	89 d0                	mov    %edx,%eax
  8005b3:	01 c0                	add    %eax,%eax
  8005b5:	01 d0                	add    %edx,%eax
  8005b7:	c1 e0 03             	shl    $0x3,%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8a 40 04             	mov    0x4(%eax),%al
  8005bf:	3c 01                	cmp    $0x1,%al
  8005c1:	75 03                	jne    8005c6 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8005c3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005c6:	ff 45 e0             	incl   -0x20(%ebp)
  8005c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ce:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d7:	39 c2                	cmp    %eax,%edx
  8005d9:	77 c8                	ja     8005a3 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005de:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005e1:	74 14                	je     8005f7 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8005e3:	83 ec 04             	sub    $0x4,%esp
  8005e6:	68 ec 22 80 00       	push   $0x8022ec
  8005eb:	6a 44                	push   $0x44
  8005ed:	68 8c 22 80 00       	push   $0x80228c
  8005f2:	e8 15 fe ff ff       	call   80040c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005f7:	90                   	nop
  8005f8:	c9                   	leave  
  8005f9:	c3                   	ret    

008005fa <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	53                   	push   %ebx
  8005fe:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800601:	8b 45 0c             	mov    0xc(%ebp),%eax
  800604:	8b 00                	mov    (%eax),%eax
  800606:	8d 48 01             	lea    0x1(%eax),%ecx
  800609:	8b 55 0c             	mov    0xc(%ebp),%edx
  80060c:	89 0a                	mov    %ecx,(%edx)
  80060e:	8b 55 08             	mov    0x8(%ebp),%edx
  800611:	88 d1                	mov    %dl,%cl
  800613:	8b 55 0c             	mov    0xc(%ebp),%edx
  800616:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800624:	75 30                	jne    800656 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800626:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80062c:	a0 40 30 80 00       	mov    0x803040,%al
  800631:	0f b6 c0             	movzbl %al,%eax
  800634:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800637:	8b 09                	mov    (%ecx),%ecx
  800639:	89 cb                	mov    %ecx,%ebx
  80063b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80063e:	83 c1 08             	add    $0x8,%ecx
  800641:	52                   	push   %edx
  800642:	50                   	push   %eax
  800643:	53                   	push   %ebx
  800644:	51                   	push   %ecx
  800645:	e8 c8 10 00 00       	call   801712 <sys_cputs>
  80064a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80064d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800650:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800656:	8b 45 0c             	mov    0xc(%ebp),%eax
  800659:	8b 40 04             	mov    0x4(%eax),%eax
  80065c:	8d 50 01             	lea    0x1(%eax),%edx
  80065f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800662:	89 50 04             	mov    %edx,0x4(%eax)
}
  800665:	90                   	nop
  800666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800669:	c9                   	leave  
  80066a:	c3                   	ret    

0080066b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80066b:	55                   	push   %ebp
  80066c:	89 e5                	mov    %esp,%ebp
  80066e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800674:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80067b:	00 00 00 
	b.cnt = 0;
  80067e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800685:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800688:	ff 75 0c             	pushl  0xc(%ebp)
  80068b:	ff 75 08             	pushl  0x8(%ebp)
  80068e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800694:	50                   	push   %eax
  800695:	68 fa 05 80 00       	push   $0x8005fa
  80069a:	e8 5a 02 00 00       	call   8008f9 <vprintfmt>
  80069f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8006a2:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8006a8:	a0 40 30 80 00       	mov    0x803040,%al
  8006ad:	0f b6 c0             	movzbl %al,%eax
  8006b0:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8006b6:	52                   	push   %edx
  8006b7:	50                   	push   %eax
  8006b8:	51                   	push   %ecx
  8006b9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006bf:	83 c0 08             	add    $0x8,%eax
  8006c2:	50                   	push   %eax
  8006c3:	e8 4a 10 00 00       	call   801712 <sys_cputs>
  8006c8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006cb:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8006d2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006d8:	c9                   	leave  
  8006d9:	c3                   	ret    

008006da <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8006da:	55                   	push   %ebp
  8006db:	89 e5                	mov    %esp,%ebp
  8006dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006e0:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8006e7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	83 ec 08             	sub    $0x8,%esp
  8006f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f6:	50                   	push   %eax
  8006f7:	e8 6f ff ff ff       	call   80066b <vcprintf>
  8006fc:	83 c4 10             	add    $0x10,%esp
  8006ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800702:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800705:	c9                   	leave  
  800706:	c3                   	ret    

00800707 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800707:	55                   	push   %ebp
  800708:	89 e5                	mov    %esp,%ebp
  80070a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80070d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800714:	8b 45 08             	mov    0x8(%ebp),%eax
  800717:	c1 e0 08             	shl    $0x8,%eax
  80071a:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  80071f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800722:	83 c0 04             	add    $0x4,%eax
  800725:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800728:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	ff 75 f4             	pushl  -0xc(%ebp)
  800731:	50                   	push   %eax
  800732:	e8 34 ff ff ff       	call   80066b <vcprintf>
  800737:	83 c4 10             	add    $0x10,%esp
  80073a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80073d:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800744:	07 00 00 

	return cnt;
  800747:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80074a:	c9                   	leave  
  80074b:	c3                   	ret    

0080074c <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80074c:	55                   	push   %ebp
  80074d:	89 e5                	mov    %esp,%ebp
  80074f:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800752:	e8 ff 0f 00 00       	call   801756 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800757:	8d 45 0c             	lea    0xc(%ebp),%eax
  80075a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 f4             	pushl  -0xc(%ebp)
  800766:	50                   	push   %eax
  800767:	e8 ff fe ff ff       	call   80066b <vcprintf>
  80076c:	83 c4 10             	add    $0x10,%esp
  80076f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800772:	e8 f9 0f 00 00       	call   801770 <sys_unlock_cons>
	return cnt;
  800777:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80077a:	c9                   	leave  
  80077b:	c3                   	ret    

0080077c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80077c:	55                   	push   %ebp
  80077d:	89 e5                	mov    %esp,%ebp
  80077f:	53                   	push   %ebx
  800780:	83 ec 14             	sub    $0x14,%esp
  800783:	8b 45 10             	mov    0x10(%ebp),%eax
  800786:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800789:	8b 45 14             	mov    0x14(%ebp),%eax
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80078f:	8b 45 18             	mov    0x18(%ebp),%eax
  800792:	ba 00 00 00 00       	mov    $0x0,%edx
  800797:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80079a:	77 55                	ja     8007f1 <printnum+0x75>
  80079c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80079f:	72 05                	jb     8007a6 <printnum+0x2a>
  8007a1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007a4:	77 4b                	ja     8007f1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007a6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007a9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007ac:	8b 45 18             	mov    0x18(%ebp),%eax
  8007af:	ba 00 00 00 00       	mov    $0x0,%edx
  8007b4:	52                   	push   %edx
  8007b5:	50                   	push   %eax
  8007b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b9:	ff 75 f0             	pushl  -0x10(%ebp)
  8007bc:	e8 8b 15 00 00       	call   801d4c <__udivdi3>
  8007c1:	83 c4 10             	add    $0x10,%esp
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	ff 75 20             	pushl  0x20(%ebp)
  8007ca:	53                   	push   %ebx
  8007cb:	ff 75 18             	pushl  0x18(%ebp)
  8007ce:	52                   	push   %edx
  8007cf:	50                   	push   %eax
  8007d0:	ff 75 0c             	pushl  0xc(%ebp)
  8007d3:	ff 75 08             	pushl  0x8(%ebp)
  8007d6:	e8 a1 ff ff ff       	call   80077c <printnum>
  8007db:	83 c4 20             	add    $0x20,%esp
  8007de:	eb 1a                	jmp    8007fa <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007e0:	83 ec 08             	sub    $0x8,%esp
  8007e3:	ff 75 0c             	pushl  0xc(%ebp)
  8007e6:	ff 75 20             	pushl  0x20(%ebp)
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	ff d0                	call   *%eax
  8007ee:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007f1:	ff 4d 1c             	decl   0x1c(%ebp)
  8007f4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007f8:	7f e6                	jg     8007e0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007fa:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007fd:	bb 00 00 00 00       	mov    $0x0,%ebx
  800802:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800805:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800808:	53                   	push   %ebx
  800809:	51                   	push   %ecx
  80080a:	52                   	push   %edx
  80080b:	50                   	push   %eax
  80080c:	e8 4b 16 00 00       	call   801e5c <__umoddi3>
  800811:	83 c4 10             	add    $0x10,%esp
  800814:	05 54 25 80 00       	add    $0x802554,%eax
  800819:	8a 00                	mov    (%eax),%al
  80081b:	0f be c0             	movsbl %al,%eax
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 0c             	pushl  0xc(%ebp)
  800824:	50                   	push   %eax
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	ff d0                	call   *%eax
  80082a:	83 c4 10             	add    $0x10,%esp
}
  80082d:	90                   	nop
  80082e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800831:	c9                   	leave  
  800832:	c3                   	ret    

00800833 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800833:	55                   	push   %ebp
  800834:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800836:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80083a:	7e 1c                	jle    800858 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	8b 00                	mov    (%eax),%eax
  800841:	8d 50 08             	lea    0x8(%eax),%edx
  800844:	8b 45 08             	mov    0x8(%ebp),%eax
  800847:	89 10                	mov    %edx,(%eax)
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	8b 00                	mov    (%eax),%eax
  80084e:	83 e8 08             	sub    $0x8,%eax
  800851:	8b 50 04             	mov    0x4(%eax),%edx
  800854:	8b 00                	mov    (%eax),%eax
  800856:	eb 40                	jmp    800898 <getuint+0x65>
	else if (lflag)
  800858:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80085c:	74 1e                	je     80087c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80085e:	8b 45 08             	mov    0x8(%ebp),%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	8d 50 04             	lea    0x4(%eax),%edx
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	89 10                	mov    %edx,(%eax)
  80086b:	8b 45 08             	mov    0x8(%ebp),%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	83 e8 04             	sub    $0x4,%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	ba 00 00 00 00       	mov    $0x0,%edx
  80087a:	eb 1c                	jmp    800898 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80087c:	8b 45 08             	mov    0x8(%ebp),%eax
  80087f:	8b 00                	mov    (%eax),%eax
  800881:	8d 50 04             	lea    0x4(%eax),%edx
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	89 10                	mov    %edx,(%eax)
  800889:	8b 45 08             	mov    0x8(%ebp),%eax
  80088c:	8b 00                	mov    (%eax),%eax
  80088e:	83 e8 04             	sub    $0x4,%eax
  800891:	8b 00                	mov    (%eax),%eax
  800893:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800898:	5d                   	pop    %ebp
  800899:	c3                   	ret    

0080089a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80089a:	55                   	push   %ebp
  80089b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80089d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008a1:	7e 1c                	jle    8008bf <getint+0x25>
		return va_arg(*ap, long long);
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	8b 00                	mov    (%eax),%eax
  8008a8:	8d 50 08             	lea    0x8(%eax),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	89 10                	mov    %edx,(%eax)
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	83 e8 08             	sub    $0x8,%eax
  8008b8:	8b 50 04             	mov    0x4(%eax),%edx
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	eb 38                	jmp    8008f7 <getint+0x5d>
	else if (lflag)
  8008bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c3:	74 1a                	je     8008df <getint+0x45>
		return va_arg(*ap, long);
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	8d 50 04             	lea    0x4(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	89 10                	mov    %edx,(%eax)
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	83 e8 04             	sub    $0x4,%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	99                   	cltd   
  8008dd:	eb 18                	jmp    8008f7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	8d 50 04             	lea    0x4(%eax),%edx
  8008e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ea:	89 10                	mov    %edx,(%eax)
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	83 e8 04             	sub    $0x4,%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	99                   	cltd   
}
  8008f7:	5d                   	pop    %ebp
  8008f8:	c3                   	ret    

008008f9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008f9:	55                   	push   %ebp
  8008fa:	89 e5                	mov    %esp,%ebp
  8008fc:	56                   	push   %esi
  8008fd:	53                   	push   %ebx
  8008fe:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800901:	eb 17                	jmp    80091a <vprintfmt+0x21>
			if (ch == '\0')
  800903:	85 db                	test   %ebx,%ebx
  800905:	0f 84 c1 03 00 00    	je     800ccc <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	ff 75 0c             	pushl  0xc(%ebp)
  800911:	53                   	push   %ebx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	ff d0                	call   *%eax
  800917:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80091a:	8b 45 10             	mov    0x10(%ebp),%eax
  80091d:	8d 50 01             	lea    0x1(%eax),%edx
  800920:	89 55 10             	mov    %edx,0x10(%ebp)
  800923:	8a 00                	mov    (%eax),%al
  800925:	0f b6 d8             	movzbl %al,%ebx
  800928:	83 fb 25             	cmp    $0x25,%ebx
  80092b:	75 d6                	jne    800903 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80092d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800931:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800938:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80093f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800946:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80094d:	8b 45 10             	mov    0x10(%ebp),%eax
  800950:	8d 50 01             	lea    0x1(%eax),%edx
  800953:	89 55 10             	mov    %edx,0x10(%ebp)
  800956:	8a 00                	mov    (%eax),%al
  800958:	0f b6 d8             	movzbl %al,%ebx
  80095b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80095e:	83 f8 5b             	cmp    $0x5b,%eax
  800961:	0f 87 3d 03 00 00    	ja     800ca4 <vprintfmt+0x3ab>
  800967:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  80096e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800970:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800974:	eb d7                	jmp    80094d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800976:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80097a:	eb d1                	jmp    80094d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80097c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800983:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800986:	89 d0                	mov    %edx,%eax
  800988:	c1 e0 02             	shl    $0x2,%eax
  80098b:	01 d0                	add    %edx,%eax
  80098d:	01 c0                	add    %eax,%eax
  80098f:	01 d8                	add    %ebx,%eax
  800991:	83 e8 30             	sub    $0x30,%eax
  800994:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800997:	8b 45 10             	mov    0x10(%ebp),%eax
  80099a:	8a 00                	mov    (%eax),%al
  80099c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80099f:	83 fb 2f             	cmp    $0x2f,%ebx
  8009a2:	7e 3e                	jle    8009e2 <vprintfmt+0xe9>
  8009a4:	83 fb 39             	cmp    $0x39,%ebx
  8009a7:	7f 39                	jg     8009e2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009a9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009ac:	eb d5                	jmp    800983 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b1:	83 c0 04             	add    $0x4,%eax
  8009b4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ba:	83 e8 04             	sub    $0x4,%eax
  8009bd:	8b 00                	mov    (%eax),%eax
  8009bf:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009c2:	eb 1f                	jmp    8009e3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c8:	79 83                	jns    80094d <vprintfmt+0x54>
				width = 0;
  8009ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009d1:	e9 77 ff ff ff       	jmp    80094d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009d6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009dd:	e9 6b ff ff ff       	jmp    80094d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009e2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e7:	0f 89 60 ff ff ff    	jns    80094d <vprintfmt+0x54>
				width = precision, precision = -1;
  8009ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009f3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009fa:	e9 4e ff ff ff       	jmp    80094d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009ff:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a02:	e9 46 ff ff ff       	jmp    80094d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a07:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0a:	83 c0 04             	add    $0x4,%eax
  800a0d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a10:	8b 45 14             	mov    0x14(%ebp),%eax
  800a13:	83 e8 04             	sub    $0x4,%eax
  800a16:	8b 00                	mov    (%eax),%eax
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 0c             	pushl  0xc(%ebp)
  800a1e:	50                   	push   %eax
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
			break;
  800a27:	e9 9b 02 00 00       	jmp    800cc7 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2f:	83 c0 04             	add    $0x4,%eax
  800a32:	89 45 14             	mov    %eax,0x14(%ebp)
  800a35:	8b 45 14             	mov    0x14(%ebp),%eax
  800a38:	83 e8 04             	sub    $0x4,%eax
  800a3b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a3d:	85 db                	test   %ebx,%ebx
  800a3f:	79 02                	jns    800a43 <vprintfmt+0x14a>
				err = -err;
  800a41:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a43:	83 fb 64             	cmp    $0x64,%ebx
  800a46:	7f 0b                	jg     800a53 <vprintfmt+0x15a>
  800a48:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  800a4f:	85 f6                	test   %esi,%esi
  800a51:	75 19                	jne    800a6c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a53:	53                   	push   %ebx
  800a54:	68 65 25 80 00       	push   $0x802565
  800a59:	ff 75 0c             	pushl  0xc(%ebp)
  800a5c:	ff 75 08             	pushl  0x8(%ebp)
  800a5f:	e8 70 02 00 00       	call   800cd4 <printfmt>
  800a64:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a67:	e9 5b 02 00 00       	jmp    800cc7 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a6c:	56                   	push   %esi
  800a6d:	68 6e 25 80 00       	push   $0x80256e
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	ff 75 08             	pushl  0x8(%ebp)
  800a78:	e8 57 02 00 00       	call   800cd4 <printfmt>
  800a7d:	83 c4 10             	add    $0x10,%esp
			break;
  800a80:	e9 42 02 00 00       	jmp    800cc7 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a85:	8b 45 14             	mov    0x14(%ebp),%eax
  800a88:	83 c0 04             	add    $0x4,%eax
  800a8b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a91:	83 e8 04             	sub    $0x4,%eax
  800a94:	8b 30                	mov    (%eax),%esi
  800a96:	85 f6                	test   %esi,%esi
  800a98:	75 05                	jne    800a9f <vprintfmt+0x1a6>
				p = "(null)";
  800a9a:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  800a9f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa3:	7e 6d                	jle    800b12 <vprintfmt+0x219>
  800aa5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800aa9:	74 67                	je     800b12 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aae:	83 ec 08             	sub    $0x8,%esp
  800ab1:	50                   	push   %eax
  800ab2:	56                   	push   %esi
  800ab3:	e8 1e 03 00 00       	call   800dd6 <strnlen>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800abe:	eb 16                	jmp    800ad6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ac0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ac4:	83 ec 08             	sub    $0x8,%esp
  800ac7:	ff 75 0c             	pushl  0xc(%ebp)
  800aca:	50                   	push   %eax
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	ff d0                	call   *%eax
  800ad0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ad3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ada:	7f e4                	jg     800ac0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800adc:	eb 34                	jmp    800b12 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ade:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ae2:	74 1c                	je     800b00 <vprintfmt+0x207>
  800ae4:	83 fb 1f             	cmp    $0x1f,%ebx
  800ae7:	7e 05                	jle    800aee <vprintfmt+0x1f5>
  800ae9:	83 fb 7e             	cmp    $0x7e,%ebx
  800aec:	7e 12                	jle    800b00 <vprintfmt+0x207>
					putch('?', putdat);
  800aee:	83 ec 08             	sub    $0x8,%esp
  800af1:	ff 75 0c             	pushl  0xc(%ebp)
  800af4:	6a 3f                	push   $0x3f
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	ff d0                	call   *%eax
  800afb:	83 c4 10             	add    $0x10,%esp
  800afe:	eb 0f                	jmp    800b0f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b00:	83 ec 08             	sub    $0x8,%esp
  800b03:	ff 75 0c             	pushl  0xc(%ebp)
  800b06:	53                   	push   %ebx
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	ff d0                	call   *%eax
  800b0c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b0f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b12:	89 f0                	mov    %esi,%eax
  800b14:	8d 70 01             	lea    0x1(%eax),%esi
  800b17:	8a 00                	mov    (%eax),%al
  800b19:	0f be d8             	movsbl %al,%ebx
  800b1c:	85 db                	test   %ebx,%ebx
  800b1e:	74 24                	je     800b44 <vprintfmt+0x24b>
  800b20:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b24:	78 b8                	js     800ade <vprintfmt+0x1e5>
  800b26:	ff 4d e0             	decl   -0x20(%ebp)
  800b29:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b2d:	79 af                	jns    800ade <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b2f:	eb 13                	jmp    800b44 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b31:	83 ec 08             	sub    $0x8,%esp
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	6a 20                	push   $0x20
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	ff d0                	call   *%eax
  800b3e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b41:	ff 4d e4             	decl   -0x1c(%ebp)
  800b44:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b48:	7f e7                	jg     800b31 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b4a:	e9 78 01 00 00       	jmp    800cc7 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b4f:	83 ec 08             	sub    $0x8,%esp
  800b52:	ff 75 e8             	pushl  -0x18(%ebp)
  800b55:	8d 45 14             	lea    0x14(%ebp),%eax
  800b58:	50                   	push   %eax
  800b59:	e8 3c fd ff ff       	call   80089a <getint>
  800b5e:	83 c4 10             	add    $0x10,%esp
  800b61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b64:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6d:	85 d2                	test   %edx,%edx
  800b6f:	79 23                	jns    800b94 <vprintfmt+0x29b>
				putch('-', putdat);
  800b71:	83 ec 08             	sub    $0x8,%esp
  800b74:	ff 75 0c             	pushl  0xc(%ebp)
  800b77:	6a 2d                	push   $0x2d
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	ff d0                	call   *%eax
  800b7e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b87:	f7 d8                	neg    %eax
  800b89:	83 d2 00             	adc    $0x0,%edx
  800b8c:	f7 da                	neg    %edx
  800b8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b91:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b94:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b9b:	e9 bc 00 00 00       	jmp    800c5c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ba0:	83 ec 08             	sub    $0x8,%esp
  800ba3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ba6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba9:	50                   	push   %eax
  800baa:	e8 84 fc ff ff       	call   800833 <getuint>
  800baf:	83 c4 10             	add    $0x10,%esp
  800bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bb8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bbf:	e9 98 00 00 00       	jmp    800c5c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bc4:	83 ec 08             	sub    $0x8,%esp
  800bc7:	ff 75 0c             	pushl  0xc(%ebp)
  800bca:	6a 58                	push   $0x58
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	ff d0                	call   *%eax
  800bd1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bd4:	83 ec 08             	sub    $0x8,%esp
  800bd7:	ff 75 0c             	pushl  0xc(%ebp)
  800bda:	6a 58                	push   $0x58
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	ff d0                	call   *%eax
  800be1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	6a 58                	push   $0x58
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	ff d0                	call   *%eax
  800bf1:	83 c4 10             	add    $0x10,%esp
			break;
  800bf4:	e9 ce 00 00 00       	jmp    800cc7 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800bf9:	83 ec 08             	sub    $0x8,%esp
  800bfc:	ff 75 0c             	pushl  0xc(%ebp)
  800bff:	6a 30                	push   $0x30
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	ff d0                	call   *%eax
  800c06:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c09:	83 ec 08             	sub    $0x8,%esp
  800c0c:	ff 75 0c             	pushl  0xc(%ebp)
  800c0f:	6a 78                	push   $0x78
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	ff d0                	call   *%eax
  800c16:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c19:	8b 45 14             	mov    0x14(%ebp),%eax
  800c1c:	83 c0 04             	add    $0x4,%eax
  800c1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800c22:	8b 45 14             	mov    0x14(%ebp),%eax
  800c25:	83 e8 04             	sub    $0x4,%eax
  800c28:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c34:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c3b:	eb 1f                	jmp    800c5c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c3d:	83 ec 08             	sub    $0x8,%esp
  800c40:	ff 75 e8             	pushl  -0x18(%ebp)
  800c43:	8d 45 14             	lea    0x14(%ebp),%eax
  800c46:	50                   	push   %eax
  800c47:	e8 e7 fb ff ff       	call   800833 <getuint>
  800c4c:	83 c4 10             	add    $0x10,%esp
  800c4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c52:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c55:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c5c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c60:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c63:	83 ec 04             	sub    $0x4,%esp
  800c66:	52                   	push   %edx
  800c67:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c6a:	50                   	push   %eax
  800c6b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c6e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c71:	ff 75 0c             	pushl  0xc(%ebp)
  800c74:	ff 75 08             	pushl  0x8(%ebp)
  800c77:	e8 00 fb ff ff       	call   80077c <printnum>
  800c7c:	83 c4 20             	add    $0x20,%esp
			break;
  800c7f:	eb 46                	jmp    800cc7 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	53                   	push   %ebx
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
			break;
  800c90:	eb 35                	jmp    800cc7 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c92:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800c99:	eb 2c                	jmp    800cc7 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c9b:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800ca2:	eb 23                	jmp    800cc7 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ca4:	83 ec 08             	sub    $0x8,%esp
  800ca7:	ff 75 0c             	pushl  0xc(%ebp)
  800caa:	6a 25                	push   $0x25
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	ff d0                	call   *%eax
  800cb1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cb4:	ff 4d 10             	decl   0x10(%ebp)
  800cb7:	eb 03                	jmp    800cbc <vprintfmt+0x3c3>
  800cb9:	ff 4d 10             	decl   0x10(%ebp)
  800cbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbf:	48                   	dec    %eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	3c 25                	cmp    $0x25,%al
  800cc4:	75 f3                	jne    800cb9 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800cc6:	90                   	nop
		}
	}
  800cc7:	e9 35 fc ff ff       	jmp    800901 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ccc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ccd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cd0:	5b                   	pop    %ebx
  800cd1:	5e                   	pop    %esi
  800cd2:	5d                   	pop    %ebp
  800cd3:	c3                   	ret    

00800cd4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cd4:	55                   	push   %ebp
  800cd5:	89 e5                	mov    %esp,%ebp
  800cd7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cda:	8d 45 10             	lea    0x10(%ebp),%eax
  800cdd:	83 c0 04             	add    $0x4,%eax
  800ce0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ce3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce6:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce9:	50                   	push   %eax
  800cea:	ff 75 0c             	pushl  0xc(%ebp)
  800ced:	ff 75 08             	pushl  0x8(%ebp)
  800cf0:	e8 04 fc ff ff       	call   8008f9 <vprintfmt>
  800cf5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cf8:	90                   	nop
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	8b 40 08             	mov    0x8(%eax),%eax
  800d04:	8d 50 01             	lea    0x1(%eax),%edx
  800d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d10:	8b 10                	mov    (%eax),%edx
  800d12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d15:	8b 40 04             	mov    0x4(%eax),%eax
  800d18:	39 c2                	cmp    %eax,%edx
  800d1a:	73 12                	jae    800d2e <sprintputch+0x33>
		*b->buf++ = ch;
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	8b 00                	mov    (%eax),%eax
  800d21:	8d 48 01             	lea    0x1(%eax),%ecx
  800d24:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d27:	89 0a                	mov    %ecx,(%edx)
  800d29:	8b 55 08             	mov    0x8(%ebp),%edx
  800d2c:	88 10                	mov    %dl,(%eax)
}
  800d2e:	90                   	nop
  800d2f:	5d                   	pop    %ebp
  800d30:	c3                   	ret    

00800d31 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d40:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	01 d0                	add    %edx,%eax
  800d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d52:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d56:	74 06                	je     800d5e <vsnprintf+0x2d>
  800d58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d5c:	7f 07                	jg     800d65 <vsnprintf+0x34>
		return -E_INVAL;
  800d5e:	b8 03 00 00 00       	mov    $0x3,%eax
  800d63:	eb 20                	jmp    800d85 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d65:	ff 75 14             	pushl  0x14(%ebp)
  800d68:	ff 75 10             	pushl  0x10(%ebp)
  800d6b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d6e:	50                   	push   %eax
  800d6f:	68 fb 0c 80 00       	push   $0x800cfb
  800d74:	e8 80 fb ff ff       	call   8008f9 <vprintfmt>
  800d79:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d7f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d85:	c9                   	leave  
  800d86:	c3                   	ret    

00800d87 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
  800d8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d8d:	8d 45 10             	lea    0x10(%ebp),%eax
  800d90:	83 c0 04             	add    $0x4,%eax
  800d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9c:	50                   	push   %eax
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	ff 75 08             	pushl  0x8(%ebp)
  800da3:	e8 89 ff ff ff       	call   800d31 <vsnprintf>
  800da8:	83 c4 10             	add    $0x10,%esp
  800dab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800db9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc0:	eb 06                	jmp    800dc8 <strlen+0x15>
		n++;
  800dc2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dc5:	ff 45 08             	incl   0x8(%ebp)
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	84 c0                	test   %al,%al
  800dcf:	75 f1                	jne    800dc2 <strlen+0xf>
		n++;
	return n;
  800dd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ddc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800de3:	eb 09                	jmp    800dee <strnlen+0x18>
		n++;
  800de5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800de8:	ff 45 08             	incl   0x8(%ebp)
  800deb:	ff 4d 0c             	decl   0xc(%ebp)
  800dee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df2:	74 09                	je     800dfd <strnlen+0x27>
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	84 c0                	test   %al,%al
  800dfb:	75 e8                	jne    800de5 <strnlen+0xf>
		n++;
	return n;
  800dfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e0e:	90                   	nop
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	8d 50 01             	lea    0x1(%eax),%edx
  800e15:	89 55 08             	mov    %edx,0x8(%ebp)
  800e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e21:	8a 12                	mov    (%edx),%dl
  800e23:	88 10                	mov    %dl,(%eax)
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	84 c0                	test   %al,%al
  800e29:	75 e4                	jne    800e0f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e43:	eb 1f                	jmp    800e64 <strncpy+0x34>
		*dst++ = *src;
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	8d 50 01             	lea    0x1(%eax),%edx
  800e4b:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e51:	8a 12                	mov    (%edx),%dl
  800e53:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	84 c0                	test   %al,%al
  800e5c:	74 03                	je     800e61 <strncpy+0x31>
			src++;
  800e5e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e61:	ff 45 fc             	incl   -0x4(%ebp)
  800e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e67:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e6a:	72 d9                	jb     800e45 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e6f:	c9                   	leave  
  800e70:	c3                   	ret    

00800e71 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e71:	55                   	push   %ebp
  800e72:	89 e5                	mov    %esp,%ebp
  800e74:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	74 30                	je     800eb3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e83:	eb 16                	jmp    800e9b <strlcpy+0x2a>
			*dst++ = *src++;
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	8d 50 01             	lea    0x1(%eax),%edx
  800e8b:	89 55 08             	mov    %edx,0x8(%ebp)
  800e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e97:	8a 12                	mov    (%edx),%dl
  800e99:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e9b:	ff 4d 10             	decl   0x10(%ebp)
  800e9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea2:	74 09                	je     800ead <strlcpy+0x3c>
  800ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	84 c0                	test   %al,%al
  800eab:	75 d8                	jne    800e85 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800eb3:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb9:	29 c2                	sub    %eax,%edx
  800ebb:	89 d0                	mov    %edx,%eax
}
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ec2:	eb 06                	jmp    800eca <strcmp+0xb>
		p++, q++;
  800ec4:	ff 45 08             	incl   0x8(%ebp)
  800ec7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	84 c0                	test   %al,%al
  800ed1:	74 0e                	je     800ee1 <strcmp+0x22>
  800ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed6:	8a 10                	mov    (%eax),%dl
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	38 c2                	cmp    %al,%dl
  800edf:	74 e3                	je     800ec4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	0f b6 d0             	movzbl %al,%edx
  800ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	0f b6 c0             	movzbl %al,%eax
  800ef1:	29 c2                	sub    %eax,%edx
  800ef3:	89 d0                	mov    %edx,%eax
}
  800ef5:	5d                   	pop    %ebp
  800ef6:	c3                   	ret    

00800ef7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ef7:	55                   	push   %ebp
  800ef8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800efa:	eb 09                	jmp    800f05 <strncmp+0xe>
		n--, p++, q++;
  800efc:	ff 4d 10             	decl   0x10(%ebp)
  800eff:	ff 45 08             	incl   0x8(%ebp)
  800f02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f09:	74 17                	je     800f22 <strncmp+0x2b>
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	84 c0                	test   %al,%al
  800f12:	74 0e                	je     800f22 <strncmp+0x2b>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 10                	mov    (%eax),%dl
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	38 c2                	cmp    %al,%dl
  800f20:	74 da                	je     800efc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f26:	75 07                	jne    800f2f <strncmp+0x38>
		return 0;
  800f28:	b8 00 00 00 00       	mov    $0x0,%eax
  800f2d:	eb 14                	jmp    800f43 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	0f b6 d0             	movzbl %al,%edx
  800f37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	0f b6 c0             	movzbl %al,%eax
  800f3f:	29 c2                	sub    %eax,%edx
  800f41:	89 d0                	mov    %edx,%eax
}
  800f43:	5d                   	pop    %ebp
  800f44:	c3                   	ret    

00800f45 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f51:	eb 12                	jmp    800f65 <strchr+0x20>
		if (*s == c)
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f5b:	75 05                	jne    800f62 <strchr+0x1d>
			return (char *) s;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	eb 11                	jmp    800f73 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f62:	ff 45 08             	incl   0x8(%ebp)
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	84 c0                	test   %al,%al
  800f6c:	75 e5                	jne    800f53 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f73:	c9                   	leave  
  800f74:	c3                   	ret    

00800f75 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f75:	55                   	push   %ebp
  800f76:	89 e5                	mov    %esp,%ebp
  800f78:	83 ec 04             	sub    $0x4,%esp
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f81:	eb 0d                	jmp    800f90 <strfind+0x1b>
		if (*s == c)
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f8b:	74 0e                	je     800f9b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f8d:	ff 45 08             	incl   0x8(%ebp)
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	84 c0                	test   %al,%al
  800f97:	75 ea                	jne    800f83 <strfind+0xe>
  800f99:	eb 01                	jmp    800f9c <strfind+0x27>
		if (*s == c)
			break;
  800f9b:	90                   	nop
	return (char *) s;
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800fad:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fb1:	76 63                	jbe    801016 <memset+0x75>
		uint64 data_block = c;
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	99                   	cltd   
  800fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fba:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800fbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc3:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800fc7:	c1 e0 08             	shl    $0x8,%eax
  800fca:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fcd:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800fd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd6:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800fda:	c1 e0 10             	shl    $0x10,%eax
  800fdd:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fe0:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800fe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe9:	89 c2                	mov    %eax,%edx
  800feb:	b8 00 00 00 00       	mov    $0x0,%eax
  800ff0:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ff3:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800ff6:	eb 18                	jmp    801010 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800ff8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ffb:	8d 41 08             	lea    0x8(%ecx),%eax
  800ffe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801001:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801004:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801007:	89 01                	mov    %eax,(%ecx)
  801009:	89 51 04             	mov    %edx,0x4(%ecx)
  80100c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801010:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801014:	77 e2                	ja     800ff8 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801016:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101a:	74 23                	je     80103f <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80101c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801022:	eb 0e                	jmp    801032 <memset+0x91>
			*p8++ = (uint8)c;
  801024:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801027:	8d 50 01             	lea    0x1(%eax),%edx
  80102a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80102d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801030:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	8d 50 ff             	lea    -0x1(%eax),%edx
  801038:	89 55 10             	mov    %edx,0x10(%ebp)
  80103b:	85 c0                	test   %eax,%eax
  80103d:	75 e5                	jne    801024 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801056:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80105a:	76 24                	jbe    801080 <memcpy+0x3c>
		while(n >= 8){
  80105c:	eb 1c                	jmp    80107a <memcpy+0x36>
			*d64 = *s64;
  80105e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801061:	8b 50 04             	mov    0x4(%eax),%edx
  801064:	8b 00                	mov    (%eax),%eax
  801066:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801069:	89 01                	mov    %eax,(%ecx)
  80106b:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80106e:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801072:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801076:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80107a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80107e:	77 de                	ja     80105e <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801080:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801084:	74 31                	je     8010b7 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801086:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801089:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80108c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801092:	eb 16                	jmp    8010aa <memcpy+0x66>
			*d8++ = *s8++;
  801094:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801097:	8d 50 01             	lea    0x1(%eax),%edx
  80109a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80109d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8010a6:	8a 12                	mov    (%edx),%dl
  8010a8:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8010aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b3:	85 c0                	test   %eax,%eax
  8010b5:	75 dd                	jne    801094 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010ba:	c9                   	leave  
  8010bb:	c3                   	ret    

008010bc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010bc:	55                   	push   %ebp
  8010bd:	89 e5                	mov    %esp,%ebp
  8010bf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010d4:	73 50                	jae    801126 <memmove+0x6a>
  8010d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010e1:	76 43                	jbe    801126 <memmove+0x6a>
		s += n;
  8010e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ec:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010ef:	eb 10                	jmp    801101 <memmove+0x45>
			*--d = *--s;
  8010f1:	ff 4d f8             	decl   -0x8(%ebp)
  8010f4:	ff 4d fc             	decl   -0x4(%ebp)
  8010f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fa:	8a 10                	mov    (%eax),%dl
  8010fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ff:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801101:	8b 45 10             	mov    0x10(%ebp),%eax
  801104:	8d 50 ff             	lea    -0x1(%eax),%edx
  801107:	89 55 10             	mov    %edx,0x10(%ebp)
  80110a:	85 c0                	test   %eax,%eax
  80110c:	75 e3                	jne    8010f1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80110e:	eb 23                	jmp    801133 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801110:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801113:	8d 50 01             	lea    0x1(%eax),%edx
  801116:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801119:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80111c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80111f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801122:	8a 12                	mov    (%edx),%dl
  801124:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801126:	8b 45 10             	mov    0x10(%ebp),%eax
  801129:	8d 50 ff             	lea    -0x1(%eax),%edx
  80112c:	89 55 10             	mov    %edx,0x10(%ebp)
  80112f:	85 c0                	test   %eax,%eax
  801131:	75 dd                	jne    801110 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801136:	c9                   	leave  
  801137:	c3                   	ret    

00801138 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801138:	55                   	push   %ebp
  801139:	89 e5                	mov    %esp,%ebp
  80113b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801144:	8b 45 0c             	mov    0xc(%ebp),%eax
  801147:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80114a:	eb 2a                	jmp    801176 <memcmp+0x3e>
		if (*s1 != *s2)
  80114c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114f:	8a 10                	mov    (%eax),%dl
  801151:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	38 c2                	cmp    %al,%dl
  801158:	74 16                	je     801170 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80115a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	0f b6 d0             	movzbl %al,%edx
  801162:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	0f b6 c0             	movzbl %al,%eax
  80116a:	29 c2                	sub    %eax,%edx
  80116c:	89 d0                	mov    %edx,%eax
  80116e:	eb 18                	jmp    801188 <memcmp+0x50>
		s1++, s2++;
  801170:	ff 45 fc             	incl   -0x4(%ebp)
  801173:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801176:	8b 45 10             	mov    0x10(%ebp),%eax
  801179:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117c:	89 55 10             	mov    %edx,0x10(%ebp)
  80117f:	85 c0                	test   %eax,%eax
  801181:	75 c9                	jne    80114c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801183:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
  80118d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801190:	8b 55 08             	mov    0x8(%ebp),%edx
  801193:	8b 45 10             	mov    0x10(%ebp),%eax
  801196:	01 d0                	add    %edx,%eax
  801198:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80119b:	eb 15                	jmp    8011b2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	0f b6 d0             	movzbl %al,%edx
  8011a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a8:	0f b6 c0             	movzbl %al,%eax
  8011ab:	39 c2                	cmp    %eax,%edx
  8011ad:	74 0d                	je     8011bc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011af:	ff 45 08             	incl   0x8(%ebp)
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011b8:	72 e3                	jb     80119d <memfind+0x13>
  8011ba:	eb 01                	jmp    8011bd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011bc:	90                   	nop
	return (void *) s;
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011d6:	eb 03                	jmp    8011db <strtol+0x19>
		s++;
  8011d8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	3c 20                	cmp    $0x20,%al
  8011e2:	74 f4                	je     8011d8 <strtol+0x16>
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	8a 00                	mov    (%eax),%al
  8011e9:	3c 09                	cmp    $0x9,%al
  8011eb:	74 eb                	je     8011d8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	3c 2b                	cmp    $0x2b,%al
  8011f4:	75 05                	jne    8011fb <strtol+0x39>
		s++;
  8011f6:	ff 45 08             	incl   0x8(%ebp)
  8011f9:	eb 13                	jmp    80120e <strtol+0x4c>
	else if (*s == '-')
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fe:	8a 00                	mov    (%eax),%al
  801200:	3c 2d                	cmp    $0x2d,%al
  801202:	75 0a                	jne    80120e <strtol+0x4c>
		s++, neg = 1;
  801204:	ff 45 08             	incl   0x8(%ebp)
  801207:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80120e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801212:	74 06                	je     80121a <strtol+0x58>
  801214:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801218:	75 20                	jne    80123a <strtol+0x78>
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	3c 30                	cmp    $0x30,%al
  801221:	75 17                	jne    80123a <strtol+0x78>
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	40                   	inc    %eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	3c 78                	cmp    $0x78,%al
  80122b:	75 0d                	jne    80123a <strtol+0x78>
		s += 2, base = 16;
  80122d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801231:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801238:	eb 28                	jmp    801262 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80123a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80123e:	75 15                	jne    801255 <strtol+0x93>
  801240:	8b 45 08             	mov    0x8(%ebp),%eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	3c 30                	cmp    $0x30,%al
  801247:	75 0c                	jne    801255 <strtol+0x93>
		s++, base = 8;
  801249:	ff 45 08             	incl   0x8(%ebp)
  80124c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801253:	eb 0d                	jmp    801262 <strtol+0xa0>
	else if (base == 0)
  801255:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801259:	75 07                	jne    801262 <strtol+0xa0>
		base = 10;
  80125b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	3c 2f                	cmp    $0x2f,%al
  801269:	7e 19                	jle    801284 <strtol+0xc2>
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	3c 39                	cmp    $0x39,%al
  801272:	7f 10                	jg     801284 <strtol+0xc2>
			dig = *s - '0';
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	0f be c0             	movsbl %al,%eax
  80127c:	83 e8 30             	sub    $0x30,%eax
  80127f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801282:	eb 42                	jmp    8012c6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	8a 00                	mov    (%eax),%al
  801289:	3c 60                	cmp    $0x60,%al
  80128b:	7e 19                	jle    8012a6 <strtol+0xe4>
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	8a 00                	mov    (%eax),%al
  801292:	3c 7a                	cmp    $0x7a,%al
  801294:	7f 10                	jg     8012a6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	8a 00                	mov    (%eax),%al
  80129b:	0f be c0             	movsbl %al,%eax
  80129e:	83 e8 57             	sub    $0x57,%eax
  8012a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012a4:	eb 20                	jmp    8012c6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	8a 00                	mov    (%eax),%al
  8012ab:	3c 40                	cmp    $0x40,%al
  8012ad:	7e 39                	jle    8012e8 <strtol+0x126>
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	8a 00                	mov    (%eax),%al
  8012b4:	3c 5a                	cmp    $0x5a,%al
  8012b6:	7f 30                	jg     8012e8 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	8a 00                	mov    (%eax),%al
  8012bd:	0f be c0             	movsbl %al,%eax
  8012c0:	83 e8 37             	sub    $0x37,%eax
  8012c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012cc:	7d 19                	jge    8012e7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012ce:	ff 45 08             	incl   0x8(%ebp)
  8012d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012d8:	89 c2                	mov    %eax,%edx
  8012da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012dd:	01 d0                	add    %edx,%eax
  8012df:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012e2:	e9 7b ff ff ff       	jmp    801262 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012e7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ec:	74 08                	je     8012f6 <strtol+0x134>
		*endptr = (char *) s;
  8012ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f1:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012fa:	74 07                	je     801303 <strtol+0x141>
  8012fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ff:	f7 d8                	neg    %eax
  801301:	eb 03                	jmp    801306 <strtol+0x144>
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <ltostr>:

void
ltostr(long value, char *str)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80130e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801315:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80131c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801320:	79 13                	jns    801335 <ltostr+0x2d>
	{
		neg = 1;
  801322:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80132f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801332:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80133d:	99                   	cltd   
  80133e:	f7 f9                	idiv   %ecx
  801340:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801343:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801346:	8d 50 01             	lea    0x1(%eax),%edx
  801349:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80134c:	89 c2                	mov    %eax,%edx
  80134e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801351:	01 d0                	add    %edx,%eax
  801353:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801356:	83 c2 30             	add    $0x30,%edx
  801359:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80135b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80135e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801363:	f7 e9                	imul   %ecx
  801365:	c1 fa 02             	sar    $0x2,%edx
  801368:	89 c8                	mov    %ecx,%eax
  80136a:	c1 f8 1f             	sar    $0x1f,%eax
  80136d:	29 c2                	sub    %eax,%edx
  80136f:	89 d0                	mov    %edx,%eax
  801371:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801374:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801378:	75 bb                	jne    801335 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80137a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801381:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801384:	48                   	dec    %eax
  801385:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801388:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80138c:	74 3d                	je     8013cb <ltostr+0xc3>
		start = 1 ;
  80138e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801395:	eb 34                	jmp    8013cb <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801397:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80139a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139d:	01 d0                	add    %edx,%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	01 c2                	add    %eax,%edx
  8013ac:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b2:	01 c8                	add    %ecx,%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013be:	01 c2                	add    %eax,%edx
  8013c0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013c3:	88 02                	mov    %al,(%edx)
		start++ ;
  8013c5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013c8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013d1:	7c c4                	jl     801397 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013d3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d9:	01 d0                	add    %edx,%eax
  8013db:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013de:	90                   	nop
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
  8013e4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013e7:	ff 75 08             	pushl  0x8(%ebp)
  8013ea:	e8 c4 f9 ff ff       	call   800db3 <strlen>
  8013ef:	83 c4 04             	add    $0x4,%esp
  8013f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013f5:	ff 75 0c             	pushl  0xc(%ebp)
  8013f8:	e8 b6 f9 ff ff       	call   800db3 <strlen>
  8013fd:	83 c4 04             	add    $0x4,%esp
  801400:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801403:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80140a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801411:	eb 17                	jmp    80142a <strcconcat+0x49>
		final[s] = str1[s] ;
  801413:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801416:	8b 45 10             	mov    0x10(%ebp),%eax
  801419:	01 c2                	add    %eax,%edx
  80141b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	01 c8                	add    %ecx,%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801427:	ff 45 fc             	incl   -0x4(%ebp)
  80142a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80142d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801430:	7c e1                	jl     801413 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801432:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801439:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801440:	eb 1f                	jmp    801461 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801442:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801445:	8d 50 01             	lea    0x1(%eax),%edx
  801448:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80144b:	89 c2                	mov    %eax,%edx
  80144d:	8b 45 10             	mov    0x10(%ebp),%eax
  801450:	01 c2                	add    %eax,%edx
  801452:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801455:	8b 45 0c             	mov    0xc(%ebp),%eax
  801458:	01 c8                	add    %ecx,%eax
  80145a:	8a 00                	mov    (%eax),%al
  80145c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80145e:	ff 45 f8             	incl   -0x8(%ebp)
  801461:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801464:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801467:	7c d9                	jl     801442 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801469:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80146c:	8b 45 10             	mov    0x10(%ebp),%eax
  80146f:	01 d0                	add    %edx,%eax
  801471:	c6 00 00             	movb   $0x0,(%eax)
}
  801474:	90                   	nop
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80147a:	8b 45 14             	mov    0x14(%ebp),%eax
  80147d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801483:	8b 45 14             	mov    0x14(%ebp),%eax
  801486:	8b 00                	mov    (%eax),%eax
  801488:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80148f:	8b 45 10             	mov    0x10(%ebp),%eax
  801492:	01 d0                	add    %edx,%eax
  801494:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80149a:	eb 0c                	jmp    8014a8 <strsplit+0x31>
			*string++ = 0;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8d 50 01             	lea    0x1(%eax),%edx
  8014a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014a5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	84 c0                	test   %al,%al
  8014af:	74 18                	je     8014c9 <strsplit+0x52>
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	8a 00                	mov    (%eax),%al
  8014b6:	0f be c0             	movsbl %al,%eax
  8014b9:	50                   	push   %eax
  8014ba:	ff 75 0c             	pushl  0xc(%ebp)
  8014bd:	e8 83 fa ff ff       	call   800f45 <strchr>
  8014c2:	83 c4 08             	add    $0x8,%esp
  8014c5:	85 c0                	test   %eax,%eax
  8014c7:	75 d3                	jne    80149c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	8a 00                	mov    (%eax),%al
  8014ce:	84 c0                	test   %al,%al
  8014d0:	74 5a                	je     80152c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d5:	8b 00                	mov    (%eax),%eax
  8014d7:	83 f8 0f             	cmp    $0xf,%eax
  8014da:	75 07                	jne    8014e3 <strsplit+0x6c>
		{
			return 0;
  8014dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8014e1:	eb 66                	jmp    801549 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e6:	8b 00                	mov    (%eax),%eax
  8014e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8014eb:	8b 55 14             	mov    0x14(%ebp),%edx
  8014ee:	89 0a                	mov    %ecx,(%edx)
  8014f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fa:	01 c2                	add    %eax,%edx
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801501:	eb 03                	jmp    801506 <strsplit+0x8f>
			string++;
  801503:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	8a 00                	mov    (%eax),%al
  80150b:	84 c0                	test   %al,%al
  80150d:	74 8b                	je     80149a <strsplit+0x23>
  80150f:	8b 45 08             	mov    0x8(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	0f be c0             	movsbl %al,%eax
  801517:	50                   	push   %eax
  801518:	ff 75 0c             	pushl  0xc(%ebp)
  80151b:	e8 25 fa ff ff       	call   800f45 <strchr>
  801520:	83 c4 08             	add    $0x8,%esp
  801523:	85 c0                	test   %eax,%eax
  801525:	74 dc                	je     801503 <strsplit+0x8c>
			string++;
	}
  801527:	e9 6e ff ff ff       	jmp    80149a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80152c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80152d:	8b 45 14             	mov    0x14(%ebp),%eax
  801530:	8b 00                	mov    (%eax),%eax
  801532:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801539:	8b 45 10             	mov    0x10(%ebp),%eax
  80153c:	01 d0                	add    %edx,%eax
  80153e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801544:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
  80154e:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801557:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80155e:	eb 4a                	jmp    8015aa <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801560:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	01 c2                	add    %eax,%edx
  801568:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80156b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156e:	01 c8                	add    %ecx,%eax
  801570:	8a 00                	mov    (%eax),%al
  801572:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801574:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801577:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157a:	01 d0                	add    %edx,%eax
  80157c:	8a 00                	mov    (%eax),%al
  80157e:	3c 40                	cmp    $0x40,%al
  801580:	7e 25                	jle    8015a7 <str2lower+0x5c>
  801582:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801585:	8b 45 0c             	mov    0xc(%ebp),%eax
  801588:	01 d0                	add    %edx,%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	3c 5a                	cmp    $0x5a,%al
  80158e:	7f 17                	jg     8015a7 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801590:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	01 d0                	add    %edx,%eax
  801598:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80159b:	8b 55 08             	mov    0x8(%ebp),%edx
  80159e:	01 ca                	add    %ecx,%edx
  8015a0:	8a 12                	mov    (%edx),%dl
  8015a2:	83 c2 20             	add    $0x20,%edx
  8015a5:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8015a7:	ff 45 fc             	incl   -0x4(%ebp)
  8015aa:	ff 75 0c             	pushl  0xc(%ebp)
  8015ad:	e8 01 f8 ff ff       	call   800db3 <strlen>
  8015b2:	83 c4 04             	add    $0x4,%esp
  8015b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015b8:	7f a6                	jg     801560 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8015ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
  8015c2:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8015c5:	a1 08 30 80 00       	mov    0x803008,%eax
  8015ca:	85 c0                	test   %eax,%eax
  8015cc:	74 2d                	je     8015fb <uheap_init+0x3c>
	{
		buddy_init();
  8015ce:	e8 87 06 00 00       	call   801c5a <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8015d3:	e8 31 05 00 00       	call   801b09 <sys_get_uheap_strategy>
  8015d8:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  8015dd:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8015e4:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8015e7:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8015ee:	00 00 80 
		__firstTimeFlag = 0;
  8015f1:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  8015f8:	00 00 00 
	}
}
  8015fb:	90                   	nop
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
  801601:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801604:	83 ec 04             	sub    $0x4,%esp
  801607:	68 e8 26 80 00       	push   $0x8026e8
  80160c:	6a 25                	push   $0x25
  80160e:	68 19 27 80 00       	push   $0x802719
  801613:	e8 f4 ed ff ff       	call   80040c <_panic>

00801618 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
  80161b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  80161e:	83 ec 04             	sub    $0x4,%esp
  801621:	68 28 27 80 00       	push   $0x802728
  801626:	6a 2f                	push   $0x2f
  801628:	68 19 27 80 00       	push   $0x802719
  80162d:	e8 da ed ff ff       	call   80040c <_panic>

00801632 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
  801635:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801638:	e8 82 ff ff ff       	call   8015bf <uheap_init>
	if (size == 0) return NULL ;
  80163d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801641:	75 07                	jne    80164a <malloc+0x18>
  801643:	b8 00 00 00 00       	mov    $0x0,%eax
  801648:	eb 14                	jmp    80165e <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  80164a:	83 ec 04             	sub    $0x4,%esp
  80164d:	68 5c 27 80 00       	push   $0x80275c
  801652:	6a 43                	push   $0x43
  801654:	68 19 27 80 00       	push   $0x802719
  801659:	e8 ae ed ff ff       	call   80040c <_panic>
}
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
  801663:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801666:	83 ec 04             	sub    $0x4,%esp
  801669:	68 84 27 80 00       	push   $0x802784
  80166e:	6a 4e                	push   $0x4e
  801670:	68 19 27 80 00       	push   $0x802719
  801675:	e8 92 ed ff ff       	call   80040c <_panic>

0080167a <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80167a:	55                   	push   %ebp
  80167b:	89 e5                	mov    %esp,%ebp
  80167d:	83 ec 18             	sub    $0x18,%esp
  801680:	8b 45 10             	mov    0x10(%ebp),%eax
  801683:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801686:	e8 34 ff ff ff       	call   8015bf <uheap_init>
	if (size == 0) return NULL ;
  80168b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80168f:	75 07                	jne    801698 <smalloc+0x1e>
  801691:	b8 00 00 00 00       	mov    $0x0,%eax
  801696:	eb 14                	jmp    8016ac <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801698:	83 ec 04             	sub    $0x4,%esp
  80169b:	68 a8 27 80 00       	push   $0x8027a8
  8016a0:	6a 5f                	push   $0x5f
  8016a2:	68 19 27 80 00       	push   $0x802719
  8016a7:	e8 60 ed ff ff       	call   80040c <_panic>
}
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
  8016b1:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8016b4:	e8 06 ff ff ff       	call   8015bf <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  8016b9:	83 ec 04             	sub    $0x4,%esp
  8016bc:	68 d0 27 80 00       	push   $0x8027d0
  8016c1:	6a 6f                	push   $0x6f
  8016c3:	68 19 27 80 00       	push   $0x802719
  8016c8:	e8 3f ed ff ff       	call   80040c <_panic>

008016cd <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8016cd:	55                   	push   %ebp
  8016ce:	89 e5                	mov    %esp,%ebp
  8016d0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8016d3:	83 ec 04             	sub    $0x4,%esp
  8016d6:	68 f4 27 80 00       	push   $0x8027f4
  8016db:	6a 7e                	push   $0x7e
  8016dd:	68 19 27 80 00       	push   $0x802719
  8016e2:	e8 25 ed ff ff       	call   80040c <_panic>

008016e7 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	57                   	push   %edi
  8016eb:	56                   	push   %esi
  8016ec:	53                   	push   %ebx
  8016ed:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016fc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016ff:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801702:	cd 30                	int    $0x30
  801704:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801707:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80170a:	83 c4 10             	add    $0x10,%esp
  80170d:	5b                   	pop    %ebx
  80170e:	5e                   	pop    %esi
  80170f:	5f                   	pop    %edi
  801710:	5d                   	pop    %ebp
  801711:	c3                   	ret    

00801712 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801712:	55                   	push   %ebp
  801713:	89 e5                	mov    %esp,%ebp
  801715:	83 ec 04             	sub    $0x4,%esp
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80171e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801721:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	51                   	push   %ecx
  80172b:	52                   	push   %edx
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 00                	push   $0x0
  801732:	e8 b0 ff ff ff       	call   8016e7 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_cgetc>:

int
sys_cgetc(void)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 02                	push   $0x2
  80174c:	e8 96 ff ff ff       	call   8016e7 <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 03                	push   $0x3
  801765:	e8 7d ff ff ff       	call   8016e7 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	90                   	nop
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 04                	push   $0x4
  80177f:	e8 63 ff ff ff       	call   8016e7 <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	90                   	nop
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80178d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801790:	8b 45 08             	mov    0x8(%ebp),%eax
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	52                   	push   %edx
  80179a:	50                   	push   %eax
  80179b:	6a 08                	push   $0x8
  80179d:	e8 45 ff ff ff       	call   8016e7 <syscall>
  8017a2:	83 c4 18             	add    $0x18,%esp
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
  8017aa:	56                   	push   %esi
  8017ab:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017ac:	8b 75 18             	mov    0x18(%ebp),%esi
  8017af:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bb:	56                   	push   %esi
  8017bc:	53                   	push   %ebx
  8017bd:	51                   	push   %ecx
  8017be:	52                   	push   %edx
  8017bf:	50                   	push   %eax
  8017c0:	6a 09                	push   $0x9
  8017c2:	e8 20 ff ff ff       	call   8016e7 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017cd:	5b                   	pop    %ebx
  8017ce:	5e                   	pop    %esi
  8017cf:	5d                   	pop    %ebp
  8017d0:	c3                   	ret    

008017d1 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	ff 75 08             	pushl  0x8(%ebp)
  8017df:	6a 0a                	push   $0xa
  8017e1:	e8 01 ff ff ff       	call   8016e7 <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	ff 75 0c             	pushl  0xc(%ebp)
  8017f7:	ff 75 08             	pushl  0x8(%ebp)
  8017fa:	6a 0b                	push   $0xb
  8017fc:	e8 e6 fe ff ff       	call   8016e7 <syscall>
  801801:	83 c4 18             	add    $0x18,%esp
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 0c                	push   $0xc
  801815:	e8 cd fe ff ff       	call   8016e7 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 0d                	push   $0xd
  80182e:	e8 b4 fe ff ff       	call   8016e7 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 0e                	push   $0xe
  801847:	e8 9b fe ff ff       	call   8016e7 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 0f                	push   $0xf
  801860:	e8 82 fe ff ff       	call   8016e7 <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	ff 75 08             	pushl  0x8(%ebp)
  801878:	6a 10                	push   $0x10
  80187a:	e8 68 fe ff ff       	call   8016e7 <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 11                	push   $0x11
  801893:	e8 4f fe ff ff       	call   8016e7 <syscall>
  801898:	83 c4 18             	add    $0x18,%esp
}
  80189b:	90                   	nop
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_cputc>:

void
sys_cputc(const char c)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
  8018a1:	83 ec 04             	sub    $0x4,%esp
  8018a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018aa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	50                   	push   %eax
  8018b7:	6a 01                	push   $0x1
  8018b9:	e8 29 fe ff ff       	call   8016e7 <syscall>
  8018be:	83 c4 18             	add    $0x18,%esp
}
  8018c1:	90                   	nop
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 14                	push   $0x14
  8018d3:	e8 0f fe ff ff       	call   8016e7 <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	90                   	nop
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
  8018e1:	83 ec 04             	sub    $0x4,%esp
  8018e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018ea:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018ed:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	6a 00                	push   $0x0
  8018f6:	51                   	push   %ecx
  8018f7:	52                   	push   %edx
  8018f8:	ff 75 0c             	pushl  0xc(%ebp)
  8018fb:	50                   	push   %eax
  8018fc:	6a 15                	push   $0x15
  8018fe:	e8 e4 fd ff ff       	call   8016e7 <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80190b:	8b 55 10             	mov    0x10(%ebp),%edx
  80190e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	52                   	push   %edx
  801916:	50                   	push   %eax
  801917:	ff 75 08             	pushl  0x8(%ebp)
  80191a:	6a 16                	push   $0x16
  80191c:	e8 c6 fd ff ff       	call   8016e7 <syscall>
  801921:	83 c4 18             	add    $0x18,%esp
}
  801924:	c9                   	leave  
  801925:	c3                   	ret    

00801926 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801926:	55                   	push   %ebp
  801927:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801929:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192c:	8b 45 08             	mov    0x8(%ebp),%eax
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	52                   	push   %edx
  801936:	50                   	push   %eax
  801937:	6a 17                	push   $0x17
  801939:	e8 a9 fd ff ff       	call   8016e7 <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801946:	8b 55 0c             	mov    0xc(%ebp),%edx
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	52                   	push   %edx
  801953:	50                   	push   %eax
  801954:	6a 18                	push   $0x18
  801956:	e8 8c fd ff ff       	call   8016e7 <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
}
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	6a 00                	push   $0x0
  801968:	ff 75 14             	pushl  0x14(%ebp)
  80196b:	ff 75 10             	pushl  0x10(%ebp)
  80196e:	ff 75 0c             	pushl  0xc(%ebp)
  801971:	50                   	push   %eax
  801972:	6a 19                	push   $0x19
  801974:	e8 6e fd ff ff       	call   8016e7 <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <sys_run_env>:

void sys_run_env(int32 envId)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	50                   	push   %eax
  80198d:	6a 1a                	push   $0x1a
  80198f:	e8 53 fd ff ff       	call   8016e7 <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	90                   	nop
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80199d:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	50                   	push   %eax
  8019a9:	6a 1b                	push   $0x1b
  8019ab:	e8 37 fd ff ff       	call   8016e7 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 05                	push   $0x5
  8019c4:	e8 1e fd ff ff       	call   8016e7 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 06                	push   $0x6
  8019dd:	e8 05 fd ff ff       	call   8016e7 <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
}
  8019e5:	c9                   	leave  
  8019e6:	c3                   	ret    

008019e7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 07                	push   $0x7
  8019f6:	e8 ec fc ff ff       	call   8016e7 <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
}
  8019fe:	c9                   	leave  
  8019ff:	c3                   	ret    

00801a00 <sys_exit_env>:


void sys_exit_env(void)
{
  801a00:	55                   	push   %ebp
  801a01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 1c                	push   $0x1c
  801a0f:	e8 d3 fc ff ff       	call   8016e7 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	90                   	nop
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	ff 75 10             	pushl  0x10(%ebp)
  801a24:	ff 75 0c             	pushl  0xc(%ebp)
  801a27:	ff 75 08             	pushl  0x8(%ebp)
  801a2a:	6a 13                	push   $0x13
  801a2c:	e8 b6 fc ff ff       	call   8016e7 <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
	return ;
  801a34:	90                   	nop
}
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 1e                	push   $0x1e
  801a46:	e8 9c fc ff ff       	call   8016e7 <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
}
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
  801a53:	83 ec 04             	sub    $0x4,%esp
  801a56:	8b 45 08             	mov    0x8(%ebp),%eax
  801a59:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a5c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	50                   	push   %eax
  801a69:	6a 1f                	push   $0x1f
  801a6b:	e8 77 fc ff ff       	call   8016e7 <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
	return ;
  801a73:	90                   	nop
}
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <rsttst>:
void rsttst()
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 21                	push   $0x21
  801a85:	e8 5d fc ff ff       	call   8016e7 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8d:	90                   	nop
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
  801a93:	83 ec 04             	sub    $0x4,%esp
  801a96:	8b 45 14             	mov    0x14(%ebp),%eax
  801a99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a9c:	8b 55 18             	mov    0x18(%ebp),%edx
  801a9f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801aa3:	52                   	push   %edx
  801aa4:	50                   	push   %eax
  801aa5:	ff 75 10             	pushl  0x10(%ebp)
  801aa8:	ff 75 0c             	pushl  0xc(%ebp)
  801aab:	ff 75 08             	pushl  0x8(%ebp)
  801aae:	6a 20                	push   $0x20
  801ab0:	e8 32 fc ff ff       	call   8016e7 <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab8:	90                   	nop
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <chktst>:
void chktst(uint32 n)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	ff 75 08             	pushl  0x8(%ebp)
  801ac9:	6a 22                	push   $0x22
  801acb:	e8 17 fc ff ff       	call   8016e7 <syscall>
  801ad0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad3:	90                   	nop
}
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <inctst>:

void inctst()
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 23                	push   $0x23
  801ae5:	e8 fd fb ff ff       	call   8016e7 <syscall>
  801aea:	83 c4 18             	add    $0x18,%esp
	return ;
  801aed:	90                   	nop
}
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <gettst>:
uint32 gettst()
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 24                	push   $0x24
  801aff:	e8 e3 fb ff ff       	call   8016e7 <syscall>
  801b04:	83 c4 18             	add    $0x18,%esp
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 25                	push   $0x25
  801b18:	e8 ca fb ff ff       	call   8016e7 <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
  801b20:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801b25:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b32:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	ff 75 08             	pushl  0x8(%ebp)
  801b42:	6a 26                	push   $0x26
  801b44:	e8 9e fb ff ff       	call   8016e7 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4c:	90                   	nop
}
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
  801b52:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b53:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b56:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b59:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5f:	6a 00                	push   $0x0
  801b61:	53                   	push   %ebx
  801b62:	51                   	push   %ecx
  801b63:	52                   	push   %edx
  801b64:	50                   	push   %eax
  801b65:	6a 27                	push   $0x27
  801b67:	e8 7b fb ff ff       	call   8016e7 <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
}
  801b6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	52                   	push   %edx
  801b84:	50                   	push   %eax
  801b85:	6a 28                	push   $0x28
  801b87:	e8 5b fb ff ff       	call   8016e7 <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
}
  801b8f:	c9                   	leave  
  801b90:	c3                   	ret    

00801b91 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b94:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	6a 00                	push   $0x0
  801b9f:	51                   	push   %ecx
  801ba0:	ff 75 10             	pushl  0x10(%ebp)
  801ba3:	52                   	push   %edx
  801ba4:	50                   	push   %eax
  801ba5:	6a 29                	push   $0x29
  801ba7:	e8 3b fb ff ff       	call   8016e7 <syscall>
  801bac:	83 c4 18             	add    $0x18,%esp
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	ff 75 10             	pushl  0x10(%ebp)
  801bbb:	ff 75 0c             	pushl  0xc(%ebp)
  801bbe:	ff 75 08             	pushl  0x8(%ebp)
  801bc1:	6a 12                	push   $0x12
  801bc3:	e8 1f fb ff ff       	call   8016e7 <syscall>
  801bc8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bcb:	90                   	nop
}
  801bcc:	c9                   	leave  
  801bcd:	c3                   	ret    

00801bce <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801bce:	55                   	push   %ebp
  801bcf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801bd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	52                   	push   %edx
  801bde:	50                   	push   %eax
  801bdf:	6a 2a                	push   $0x2a
  801be1:	e8 01 fb ff ff       	call   8016e7 <syscall>
  801be6:	83 c4 18             	add    $0x18,%esp
	return;
  801be9:	90                   	nop
}
  801bea:	c9                   	leave  
  801beb:	c3                   	ret    

00801bec <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 2b                	push   $0x2b
  801bfb:	e8 e7 fa ff ff       	call   8016e7 <syscall>
  801c00:	83 c4 18             	add    $0x18,%esp
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801c0b:	83 ec 04             	sub    $0x4,%esp
  801c0e:	68 18 28 80 00       	push   $0x802818
  801c13:	68 0a 01 00 00       	push   $0x10a
  801c18:	68 28 28 80 00       	push   $0x802828
  801c1d:	e8 ea e7 ff ff       	call   80040c <_panic>

00801c22 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801c22:	55                   	push   %ebp
  801c23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	ff 75 0c             	pushl  0xc(%ebp)
  801c2e:	ff 75 08             	pushl  0x8(%ebp)
  801c31:	6a 33                	push   $0x33
  801c33:	e8 af fa ff ff       	call   8016e7 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
	return;
  801c3b:	90                   	nop
}
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	ff 75 0c             	pushl  0xc(%ebp)
  801c4a:	ff 75 08             	pushl  0x8(%ebp)
  801c4d:	6a 34                	push   $0x34
  801c4f:	e8 93 fa ff ff       	call   8016e7 <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
	return ;
  801c57:	90                   	nop
}
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
  801c5d:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c60:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801c67:	eb 36                	jmp    801c9f <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c6c:	c1 e0 04             	shl    $0x4,%eax
  801c6f:	05 60 30 80 00       	add    $0x803060,%eax
  801c74:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c7d:	c1 e0 04             	shl    $0x4,%eax
  801c80:	05 64 30 80 00       	add    $0x803064,%eax
  801c85:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c8e:	c1 e0 04             	shl    $0x4,%eax
  801c91:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c96:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c9c:	ff 45 fc             	incl   -0x4(%ebp)
  801c9f:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801ca3:	7e c4                	jle    801c69 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801ca5:	90                   	nop
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
  801cab:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801cae:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801cb5:	eb 24                	jmp    801cdb <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cba:	c1 e0 04             	shl    $0x4,%eax
  801cbd:	05 6c 30 80 00       	add    $0x80306c,%eax
  801cc2:	8b 00                	mov    (%eax),%eax
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	50                   	push   %eax
  801cc8:	ff 75 f4             	pushl  -0xc(%ebp)
  801ccb:	68 38 28 80 00       	push   $0x802838
  801cd0:	e8 05 ea ff ff       	call   8006da <cprintf>
  801cd5:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801cd8:	ff 45 f4             	incl   -0xc(%ebp)
  801cdb:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801cdf:	7e d6                	jle    801cb7 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801ce1:	90                   	nop
  801ce2:	c9                   	leave  
  801ce3:	c3                   	ret    

00801ce4 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801ce4:	55                   	push   %ebp
  801ce5:	89 e5                	mov    %esp,%ebp
  801ce7:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801cea:	83 ec 04             	sub    $0x4,%esp
  801ced:	68 48 28 80 00       	push   $0x802848
  801cf2:	6a 33                	push   $0x33
  801cf4:	68 69 28 80 00       	push   $0x802869
  801cf9:	e8 0e e7 ff ff       	call   80040c <_panic>

00801cfe <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801cfe:	55                   	push   %ebp
  801cff:	89 e5                	mov    %esp,%ebp
  801d01:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801d04:	83 ec 04             	sub    $0x4,%esp
  801d07:	68 81 28 80 00       	push   $0x802881
  801d0c:	6a 3e                	push   $0x3e
  801d0e:	68 69 28 80 00       	push   $0x802869
  801d13:	e8 f4 e6 ff ff       	call   80040c <_panic>

00801d18 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
  801d1b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801d1e:	83 ec 04             	sub    $0x4,%esp
  801d21:	68 9f 28 80 00       	push   $0x80289f
  801d26:	6a 49                	push   $0x49
  801d28:	68 69 28 80 00       	push   $0x802869
  801d2d:	e8 da e6 ff ff       	call   80040c <_panic>

00801d32 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
  801d35:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801d38:	83 ec 04             	sub    $0x4,%esp
  801d3b:	68 bc 28 80 00       	push   $0x8028bc
  801d40:	6a 58                	push   $0x58
  801d42:	68 69 28 80 00       	push   $0x802869
  801d47:	e8 c0 e6 ff ff       	call   80040c <_panic>

00801d4c <__udivdi3>:
  801d4c:	55                   	push   %ebp
  801d4d:	57                   	push   %edi
  801d4e:	56                   	push   %esi
  801d4f:	53                   	push   %ebx
  801d50:	83 ec 1c             	sub    $0x1c,%esp
  801d53:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d57:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d63:	89 ca                	mov    %ecx,%edx
  801d65:	89 f8                	mov    %edi,%eax
  801d67:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d6b:	85 f6                	test   %esi,%esi
  801d6d:	75 2d                	jne    801d9c <__udivdi3+0x50>
  801d6f:	39 cf                	cmp    %ecx,%edi
  801d71:	77 65                	ja     801dd8 <__udivdi3+0x8c>
  801d73:	89 fd                	mov    %edi,%ebp
  801d75:	85 ff                	test   %edi,%edi
  801d77:	75 0b                	jne    801d84 <__udivdi3+0x38>
  801d79:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7e:	31 d2                	xor    %edx,%edx
  801d80:	f7 f7                	div    %edi
  801d82:	89 c5                	mov    %eax,%ebp
  801d84:	31 d2                	xor    %edx,%edx
  801d86:	89 c8                	mov    %ecx,%eax
  801d88:	f7 f5                	div    %ebp
  801d8a:	89 c1                	mov    %eax,%ecx
  801d8c:	89 d8                	mov    %ebx,%eax
  801d8e:	f7 f5                	div    %ebp
  801d90:	89 cf                	mov    %ecx,%edi
  801d92:	89 fa                	mov    %edi,%edx
  801d94:	83 c4 1c             	add    $0x1c,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    
  801d9c:	39 ce                	cmp    %ecx,%esi
  801d9e:	77 28                	ja     801dc8 <__udivdi3+0x7c>
  801da0:	0f bd fe             	bsr    %esi,%edi
  801da3:	83 f7 1f             	xor    $0x1f,%edi
  801da6:	75 40                	jne    801de8 <__udivdi3+0x9c>
  801da8:	39 ce                	cmp    %ecx,%esi
  801daa:	72 0a                	jb     801db6 <__udivdi3+0x6a>
  801dac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801db0:	0f 87 9e 00 00 00    	ja     801e54 <__udivdi3+0x108>
  801db6:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbb:	89 fa                	mov    %edi,%edx
  801dbd:	83 c4 1c             	add    $0x1c,%esp
  801dc0:	5b                   	pop    %ebx
  801dc1:	5e                   	pop    %esi
  801dc2:	5f                   	pop    %edi
  801dc3:	5d                   	pop    %ebp
  801dc4:	c3                   	ret    
  801dc5:	8d 76 00             	lea    0x0(%esi),%esi
  801dc8:	31 ff                	xor    %edi,%edi
  801dca:	31 c0                	xor    %eax,%eax
  801dcc:	89 fa                	mov    %edi,%edx
  801dce:	83 c4 1c             	add    $0x1c,%esp
  801dd1:	5b                   	pop    %ebx
  801dd2:	5e                   	pop    %esi
  801dd3:	5f                   	pop    %edi
  801dd4:	5d                   	pop    %ebp
  801dd5:	c3                   	ret    
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	89 d8                	mov    %ebx,%eax
  801dda:	f7 f7                	div    %edi
  801ddc:	31 ff                	xor    %edi,%edi
  801dde:	89 fa                	mov    %edi,%edx
  801de0:	83 c4 1c             	add    $0x1c,%esp
  801de3:	5b                   	pop    %ebx
  801de4:	5e                   	pop    %esi
  801de5:	5f                   	pop    %edi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    
  801de8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ded:	89 eb                	mov    %ebp,%ebx
  801def:	29 fb                	sub    %edi,%ebx
  801df1:	89 f9                	mov    %edi,%ecx
  801df3:	d3 e6                	shl    %cl,%esi
  801df5:	89 c5                	mov    %eax,%ebp
  801df7:	88 d9                	mov    %bl,%cl
  801df9:	d3 ed                	shr    %cl,%ebp
  801dfb:	89 e9                	mov    %ebp,%ecx
  801dfd:	09 f1                	or     %esi,%ecx
  801dff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e03:	89 f9                	mov    %edi,%ecx
  801e05:	d3 e0                	shl    %cl,%eax
  801e07:	89 c5                	mov    %eax,%ebp
  801e09:	89 d6                	mov    %edx,%esi
  801e0b:	88 d9                	mov    %bl,%cl
  801e0d:	d3 ee                	shr    %cl,%esi
  801e0f:	89 f9                	mov    %edi,%ecx
  801e11:	d3 e2                	shl    %cl,%edx
  801e13:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e17:	88 d9                	mov    %bl,%cl
  801e19:	d3 e8                	shr    %cl,%eax
  801e1b:	09 c2                	or     %eax,%edx
  801e1d:	89 d0                	mov    %edx,%eax
  801e1f:	89 f2                	mov    %esi,%edx
  801e21:	f7 74 24 0c          	divl   0xc(%esp)
  801e25:	89 d6                	mov    %edx,%esi
  801e27:	89 c3                	mov    %eax,%ebx
  801e29:	f7 e5                	mul    %ebp
  801e2b:	39 d6                	cmp    %edx,%esi
  801e2d:	72 19                	jb     801e48 <__udivdi3+0xfc>
  801e2f:	74 0b                	je     801e3c <__udivdi3+0xf0>
  801e31:	89 d8                	mov    %ebx,%eax
  801e33:	31 ff                	xor    %edi,%edi
  801e35:	e9 58 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e3a:	66 90                	xchg   %ax,%ax
  801e3c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e40:	89 f9                	mov    %edi,%ecx
  801e42:	d3 e2                	shl    %cl,%edx
  801e44:	39 c2                	cmp    %eax,%edx
  801e46:	73 e9                	jae    801e31 <__udivdi3+0xe5>
  801e48:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e4b:	31 ff                	xor    %edi,%edi
  801e4d:	e9 40 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e52:	66 90                	xchg   %ax,%ax
  801e54:	31 c0                	xor    %eax,%eax
  801e56:	e9 37 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e5b:	90                   	nop

00801e5c <__umoddi3>:
  801e5c:	55                   	push   %ebp
  801e5d:	57                   	push   %edi
  801e5e:	56                   	push   %esi
  801e5f:	53                   	push   %ebx
  801e60:	83 ec 1c             	sub    $0x1c,%esp
  801e63:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e67:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e6f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e73:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e77:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e7b:	89 f3                	mov    %esi,%ebx
  801e7d:	89 fa                	mov    %edi,%edx
  801e7f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e83:	89 34 24             	mov    %esi,(%esp)
  801e86:	85 c0                	test   %eax,%eax
  801e88:	75 1a                	jne    801ea4 <__umoddi3+0x48>
  801e8a:	39 f7                	cmp    %esi,%edi
  801e8c:	0f 86 a2 00 00 00    	jbe    801f34 <__umoddi3+0xd8>
  801e92:	89 c8                	mov    %ecx,%eax
  801e94:	89 f2                	mov    %esi,%edx
  801e96:	f7 f7                	div    %edi
  801e98:	89 d0                	mov    %edx,%eax
  801e9a:	31 d2                	xor    %edx,%edx
  801e9c:	83 c4 1c             	add    $0x1c,%esp
  801e9f:	5b                   	pop    %ebx
  801ea0:	5e                   	pop    %esi
  801ea1:	5f                   	pop    %edi
  801ea2:	5d                   	pop    %ebp
  801ea3:	c3                   	ret    
  801ea4:	39 f0                	cmp    %esi,%eax
  801ea6:	0f 87 ac 00 00 00    	ja     801f58 <__umoddi3+0xfc>
  801eac:	0f bd e8             	bsr    %eax,%ebp
  801eaf:	83 f5 1f             	xor    $0x1f,%ebp
  801eb2:	0f 84 ac 00 00 00    	je     801f64 <__umoddi3+0x108>
  801eb8:	bf 20 00 00 00       	mov    $0x20,%edi
  801ebd:	29 ef                	sub    %ebp,%edi
  801ebf:	89 fe                	mov    %edi,%esi
  801ec1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ec5:	89 e9                	mov    %ebp,%ecx
  801ec7:	d3 e0                	shl    %cl,%eax
  801ec9:	89 d7                	mov    %edx,%edi
  801ecb:	89 f1                	mov    %esi,%ecx
  801ecd:	d3 ef                	shr    %cl,%edi
  801ecf:	09 c7                	or     %eax,%edi
  801ed1:	89 e9                	mov    %ebp,%ecx
  801ed3:	d3 e2                	shl    %cl,%edx
  801ed5:	89 14 24             	mov    %edx,(%esp)
  801ed8:	89 d8                	mov    %ebx,%eax
  801eda:	d3 e0                	shl    %cl,%eax
  801edc:	89 c2                	mov    %eax,%edx
  801ede:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee2:	d3 e0                	shl    %cl,%eax
  801ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ee8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eec:	89 f1                	mov    %esi,%ecx
  801eee:	d3 e8                	shr    %cl,%eax
  801ef0:	09 d0                	or     %edx,%eax
  801ef2:	d3 eb                	shr    %cl,%ebx
  801ef4:	89 da                	mov    %ebx,%edx
  801ef6:	f7 f7                	div    %edi
  801ef8:	89 d3                	mov    %edx,%ebx
  801efa:	f7 24 24             	mull   (%esp)
  801efd:	89 c6                	mov    %eax,%esi
  801eff:	89 d1                	mov    %edx,%ecx
  801f01:	39 d3                	cmp    %edx,%ebx
  801f03:	0f 82 87 00 00 00    	jb     801f90 <__umoddi3+0x134>
  801f09:	0f 84 91 00 00 00    	je     801fa0 <__umoddi3+0x144>
  801f0f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f13:	29 f2                	sub    %esi,%edx
  801f15:	19 cb                	sbb    %ecx,%ebx
  801f17:	89 d8                	mov    %ebx,%eax
  801f19:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f1d:	d3 e0                	shl    %cl,%eax
  801f1f:	89 e9                	mov    %ebp,%ecx
  801f21:	d3 ea                	shr    %cl,%edx
  801f23:	09 d0                	or     %edx,%eax
  801f25:	89 e9                	mov    %ebp,%ecx
  801f27:	d3 eb                	shr    %cl,%ebx
  801f29:	89 da                	mov    %ebx,%edx
  801f2b:	83 c4 1c             	add    $0x1c,%esp
  801f2e:	5b                   	pop    %ebx
  801f2f:	5e                   	pop    %esi
  801f30:	5f                   	pop    %edi
  801f31:	5d                   	pop    %ebp
  801f32:	c3                   	ret    
  801f33:	90                   	nop
  801f34:	89 fd                	mov    %edi,%ebp
  801f36:	85 ff                	test   %edi,%edi
  801f38:	75 0b                	jne    801f45 <__umoddi3+0xe9>
  801f3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3f:	31 d2                	xor    %edx,%edx
  801f41:	f7 f7                	div    %edi
  801f43:	89 c5                	mov    %eax,%ebp
  801f45:	89 f0                	mov    %esi,%eax
  801f47:	31 d2                	xor    %edx,%edx
  801f49:	f7 f5                	div    %ebp
  801f4b:	89 c8                	mov    %ecx,%eax
  801f4d:	f7 f5                	div    %ebp
  801f4f:	89 d0                	mov    %edx,%eax
  801f51:	e9 44 ff ff ff       	jmp    801e9a <__umoddi3+0x3e>
  801f56:	66 90                	xchg   %ax,%ax
  801f58:	89 c8                	mov    %ecx,%eax
  801f5a:	89 f2                	mov    %esi,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	3b 04 24             	cmp    (%esp),%eax
  801f67:	72 06                	jb     801f6f <__umoddi3+0x113>
  801f69:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f6d:	77 0f                	ja     801f7e <__umoddi3+0x122>
  801f6f:	89 f2                	mov    %esi,%edx
  801f71:	29 f9                	sub    %edi,%ecx
  801f73:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f77:	89 14 24             	mov    %edx,(%esp)
  801f7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f82:	8b 14 24             	mov    (%esp),%edx
  801f85:	83 c4 1c             	add    $0x1c,%esp
  801f88:	5b                   	pop    %ebx
  801f89:	5e                   	pop    %esi
  801f8a:	5f                   	pop    %edi
  801f8b:	5d                   	pop    %ebp
  801f8c:	c3                   	ret    
  801f8d:	8d 76 00             	lea    0x0(%esi),%esi
  801f90:	2b 04 24             	sub    (%esp),%eax
  801f93:	19 fa                	sbb    %edi,%edx
  801f95:	89 d1                	mov    %edx,%ecx
  801f97:	89 c6                	mov    %eax,%esi
  801f99:	e9 71 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
  801f9e:	66 90                	xchg   %ax,%ax
  801fa0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fa4:	72 ea                	jb     801f90 <__umoddi3+0x134>
  801fa6:	89 d9                	mov    %ebx,%ecx
  801fa8:	e9 62 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
