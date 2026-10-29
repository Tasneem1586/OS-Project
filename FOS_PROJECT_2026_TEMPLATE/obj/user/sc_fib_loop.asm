
obj/user/sc_fib_loop:     file format elf32-i386


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
  800031:	e8 38 01 00 00       	call   80016e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int64 fibonacci(int n, int64 *memo);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int index=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
//	atomic_readline("Please enter Fibonacci index:", buff1);
//	index = strtol(buff1, NULL, 10);

	index = 200;
  800048:	c7 45 f4 c8 00 00 00 	movl   $0xc8,-0xc(%ebp)

	int64 *memo = malloc((index+1) * sizeof(int64));
  80004f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800052:	40                   	inc    %eax
  800053:	c1 e0 03             	shl    $0x3,%eax
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	50                   	push   %eax
  80005a:	e8 95 15 00 00       	call   8015f4 <malloc>
  80005f:	83 c4 10             	add    $0x10,%esp
  800062:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int64 res = fibonacci(index, memo) ;
  800065:	83 ec 08             	sub    $0x8,%esp
  800068:	ff 75 f0             	pushl  -0x10(%ebp)
  80006b:	ff 75 f4             	pushl  -0xc(%ebp)
  80006e:	e8 55 00 00 00       	call   8000c8 <fibonacci>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800079:	89 55 ec             	mov    %edx,-0x14(%ebp)

	if (uheapPageAllocBreak > USER_HEAP_START + DYN_ALLOC_MAX_SIZE + PAGE_SIZE)
  80007c:	a1 4c 30 80 00       	mov    0x80304c,%eax
  800081:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800086:	76 14                	jbe    80009c <_main+0x64>
		panic("page alloc is invoked!!");
  800088:	83 ec 04             	sub    $0x4,%esp
  80008b:	68 80 1f 80 00       	push   $0x801f80
  800090:	6a 16                	push   $0x16
  800092:	68 98 1f 80 00       	push   $0x801f98
  800097:	e8 32 03 00 00       	call   8003ce <_panic>

	free(memo);
  80009c:	83 ec 0c             	sub    $0xc,%esp
  80009f:	ff 75 f0             	pushl  -0x10(%ebp)
  8000a2:	e8 7b 15 00 00       	call   801622 <free>
  8000a7:	83 c4 10             	add    $0x10,%esp

	atomic_cprintf("Fibonacci #%d = %lld\n",index, res);
  8000aa:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ad:	ff 75 e8             	pushl  -0x18(%ebp)
  8000b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b3:	68 ab 1f 80 00       	push   $0x801fab
  8000b8:	e8 51 06 00 00       	call   80070e <atomic_cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
	inctst();
  8000c0:	e8 d3 19 00 00       	call   801a98 <inctst>
	return;
  8000c5:	90                   	nop
}
  8000c6:	c9                   	leave  
  8000c7:	c3                   	ret    

008000c8 <fibonacci>:


int64 fibonacci(int n, int64 *memo)
{
  8000c8:	55                   	push   %ebp
  8000c9:	89 e5                	mov    %esp,%ebp
  8000cb:	56                   	push   %esi
  8000cc:	53                   	push   %ebx
  8000cd:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i <= n; ++i)
  8000d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000d7:	eb 72                	jmp    80014b <fibonacci+0x83>
	{
		if (i <= 1)
  8000d9:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8000dd:	7f 1e                	jg     8000fd <fibonacci+0x35>
			memo[i] = 1;
  8000df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ec:	01 d0                	add    %edx,%eax
  8000ee:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  8000f4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  8000fb:	eb 4b                	jmp    800148 <fibonacci+0x80>
		else
			memo[i] = memo[i-1] + memo[i-2] ;
  8000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800100:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80010a:	8d 34 02             	lea    (%edx,%eax,1),%esi
  80010d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800110:	05 ff ff ff 1f       	add    $0x1fffffff,%eax
  800115:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80011c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011f:	01 d0                	add    %edx,%eax
  800121:	8b 08                	mov    (%eax),%ecx
  800123:	8b 58 04             	mov    0x4(%eax),%ebx
  800126:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800129:	05 fe ff ff 1f       	add    $0x1ffffffe,%eax
  80012e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	01 d0                	add    %edx,%eax
  80013a:	8b 50 04             	mov    0x4(%eax),%edx
  80013d:	8b 00                	mov    (%eax),%eax
  80013f:	01 c8                	add    %ecx,%eax
  800141:	11 da                	adc    %ebx,%edx
  800143:	89 06                	mov    %eax,(%esi)
  800145:	89 56 04             	mov    %edx,0x4(%esi)
}


int64 fibonacci(int n, int64 *memo)
{
	for (int i = 0; i <= n; ++i)
  800148:	ff 45 f4             	incl   -0xc(%ebp)
  80014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80014e:	3b 45 08             	cmp    0x8(%ebp),%eax
  800151:	7e 86                	jle    8000d9 <fibonacci+0x11>
		if (i <= 1)
			memo[i] = 1;
		else
			memo[i] = memo[i-1] + memo[i-2] ;
	}
	return memo[n];
  800153:	8b 45 08             	mov    0x8(%ebp),%eax
  800156:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80015d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800160:	01 d0                	add    %edx,%eax
  800162:	8b 50 04             	mov    0x4(%eax),%edx
  800165:	8b 00                	mov    (%eax),%eax
}
  800167:	83 c4 10             	add    $0x10,%esp
  80016a:	5b                   	pop    %ebx
  80016b:	5e                   	pop    %esi
  80016c:	5d                   	pop    %ebp
  80016d:	c3                   	ret    

0080016e <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80016e:	55                   	push   %ebp
  80016f:	89 e5                	mov    %esp,%ebp
  800171:	57                   	push   %edi
  800172:	56                   	push   %esi
  800173:	53                   	push   %ebx
  800174:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80017a:	e8 11 18 00 00       	call   801990 <sys_getenvindex>
  80017f:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800182:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800185:	89 d0                	mov    %edx,%eax
  800187:	c1 e0 03             	shl    $0x3,%eax
  80018a:	01 d0                	add    %edx,%eax
  80018c:	c1 e0 06             	shl    $0x6,%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	c1 e0 03             	shl    $0x3,%eax
  800194:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800199:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80019e:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a3:	8a 40 10             	mov    0x10(%eax),%al
  8001a6:	84 c0                	test   %al,%al
  8001a8:	74 0d                	je     8001b7 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001af:	83 c0 10             	add    $0x10,%eax
  8001b2:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001bb:	7e 0a                	jle    8001c7 <libmain+0x59>
		binaryname = argv[0];
  8001bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c0:	8b 00                	mov    (%eax),%eax
  8001c2:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 0c             	pushl  0xc(%ebp)
  8001cd:	ff 75 08             	pushl  0x8(%ebp)
  8001d0:	e8 63 fe ff ff       	call   800038 <_main>
  8001d5:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8001d8:	a1 00 30 80 00       	mov    0x803000,%eax
  8001dd:	85 c0                	test   %eax,%eax
  8001df:	0f 84 b7 01 00 00    	je     80039c <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001e5:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001eb:	bb 00 21 80 00       	mov    $0x802100,%ebx
  8001f0:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001f5:	89 c7                	mov    %eax,%edi
  8001f7:	89 de                	mov    %ebx,%esi
  8001f9:	89 d1                	mov    %edx,%ecx
  8001fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001fd:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800203:	b9 56 00 00 00       	mov    $0x56,%ecx
  800208:	b0 00                	mov    $0x0,%al
  80020a:	89 d7                	mov    %edx,%edi
  80020c:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80020e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800215:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	50                   	push   %eax
  80021c:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800222:	50                   	push   %eax
  800223:	e8 68 19 00 00       	call   801b90 <sys_utilities>
  800228:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80022b:	e8 e8 14 00 00       	call   801718 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 dc 1f 80 00       	push   $0x801fdc
  800238:	e8 5f 04 00 00       	call   80069c <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800240:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800243:	85 c0                	test   %eax,%eax
  800245:	74 58                	je     80029f <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800247:	e8 62 19 00 00       	call   801bae <sys_get_optimal_num_faults>
  80024c:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80024f:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800255:	bb 64 21 80 00       	mov    $0x802164,%ebx
  80025a:	ba 11 00 00 00       	mov    $0x11,%edx
  80025f:	89 c7                	mov    %eax,%edi
  800261:	89 de                	mov    %ebx,%esi
  800263:	89 d1                	mov    %edx,%ecx
  800265:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800267:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80026a:	b9 53 00 00 00       	mov    $0x53,%ecx
  80026f:	b0 00                	mov    $0x0,%al
  800271:	89 d7                	mov    %edx,%edi
  800273:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800275:	83 ec 08             	sub    $0x8,%esp
  800278:	ff 75 dc             	pushl  -0x24(%ebp)
  80027b:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800281:	50                   	push   %eax
  800282:	e8 09 19 00 00       	call   801b90 <sys_utilities>
  800287:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	ff 75 dc             	pushl  -0x24(%ebp)
  800290:	68 04 20 80 00       	push   $0x802004
  800295:	e8 02 04 00 00       	call   80069c <cprintf>
  80029a:	83 c4 10             	add    $0x10,%esp
  80029d:	eb 59                	jmp    8002f8 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80029f:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a4:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8002af:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002b5:	83 ec 04             	sub    $0x4,%esp
  8002b8:	52                   	push   %edx
  8002b9:	50                   	push   %eax
  8002ba:	68 28 20 80 00       	push   $0x802028
  8002bf:	e8 d8 03 00 00       	call   80069c <cprintf>
  8002c4:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8002c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cc:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8002d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d7:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e2:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002e8:	51                   	push   %ecx
  8002e9:	52                   	push   %edx
  8002ea:	50                   	push   %eax
  8002eb:	68 50 20 80 00       	push   $0x802050
  8002f0:	e8 a7 03 00 00       	call   80069c <cprintf>
  8002f5:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fd:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800303:	83 ec 08             	sub    $0x8,%esp
  800306:	50                   	push   %eax
  800307:	68 a8 20 80 00       	push   $0x8020a8
  80030c:	e8 8b 03 00 00       	call   80069c <cprintf>
  800311:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800314:	83 ec 0c             	sub    $0xc,%esp
  800317:	68 bc 20 80 00       	push   $0x8020bc
  80031c:	e8 7b 03 00 00       	call   80069c <cprintf>
  800321:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800324:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80032b:	eb 28                	jmp    800355 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80032d:	a1 20 30 80 00       	mov    0x803020,%eax
  800332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800335:	81 c2 74 04 00 00    	add    $0x474,%edx
  80033b:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	50                   	push   %eax
  800342:	ff 75 e4             	pushl  -0x1c(%ebp)
  800345:	68 d3 20 80 00       	push   $0x8020d3
  80034a:	e8 4d 03 00 00       	call   80069c <cprintf>
  80034f:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800352:	ff 45 e4             	incl   -0x1c(%ebp)
  800355:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800359:	7e d2                	jle    80032d <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80035b:	83 ec 0c             	sub    $0xc,%esp
  80035e:	68 e2 20 80 00       	push   $0x8020e2
  800363:	e8 34 03 00 00       	call   80069c <cprintf>
  800368:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80036b:	a1 20 30 80 00       	mov    0x803020,%eax
  800370:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800376:	83 ec 08             	sub    $0x8,%esp
  800379:	50                   	push   %eax
  80037a:	68 e6 20 80 00       	push   $0x8020e6
  80037f:	e8 18 03 00 00       	call   80069c <cprintf>
  800384:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800387:	83 ec 0c             	sub    $0xc,%esp
  80038a:	68 dc 1f 80 00       	push   $0x801fdc
  80038f:	e8 08 03 00 00       	call   80069c <cprintf>
  800394:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800397:	e8 96 13 00 00       	call   801732 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80039c:	e8 1f 00 00 00       	call   8003c0 <exit>
}
  8003a1:	90                   	nop
  8003a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003a5:	5b                   	pop    %ebx
  8003a6:	5e                   	pop    %esi
  8003a7:	5f                   	pop    %edi
  8003a8:	5d                   	pop    %ebp
  8003a9:	c3                   	ret    

008003aa <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003aa:	55                   	push   %ebp
  8003ab:	89 e5                	mov    %esp,%ebp
  8003ad:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003b0:	83 ec 0c             	sub    $0xc,%esp
  8003b3:	6a 00                	push   $0x0
  8003b5:	e8 a2 15 00 00       	call   80195c <sys_destroy_env>
  8003ba:	83 c4 10             	add    $0x10,%esp
}
  8003bd:	90                   	nop
  8003be:	c9                   	leave  
  8003bf:	c3                   	ret    

008003c0 <exit>:

void
exit(void)
{
  8003c0:	55                   	push   %ebp
  8003c1:	89 e5                	mov    %esp,%ebp
  8003c3:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8003c6:	e8 f7 15 00 00       	call   8019c2 <sys_exit_env>
}
  8003cb:	90                   	nop
  8003cc:	c9                   	leave  
  8003cd:	c3                   	ret    

008003ce <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003ce:	55                   	push   %ebp
  8003cf:	89 e5                	mov    %esp,%ebp
  8003d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003d4:	8d 45 10             	lea    0x10(%ebp),%eax
  8003d7:	83 c0 04             	add    $0x4,%eax
  8003da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003dd:	a1 28 31 80 00       	mov    0x803128,%eax
  8003e2:	85 c0                	test   %eax,%eax
  8003e4:	74 16                	je     8003fc <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003e6:	a1 28 31 80 00       	mov    0x803128,%eax
  8003eb:	83 ec 08             	sub    $0x8,%esp
  8003ee:	50                   	push   %eax
  8003ef:	68 c8 21 80 00       	push   $0x8021c8
  8003f4:	e8 a3 02 00 00       	call   80069c <cprintf>
  8003f9:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8003fc:	a1 04 30 80 00       	mov    0x803004,%eax
  800401:	83 ec 0c             	sub    $0xc,%esp
  800404:	ff 75 0c             	pushl  0xc(%ebp)
  800407:	ff 75 08             	pushl  0x8(%ebp)
  80040a:	50                   	push   %eax
  80040b:	68 d0 21 80 00       	push   $0x8021d0
  800410:	6a 74                	push   $0x74
  800412:	e8 b2 02 00 00       	call   8006c9 <cprintf_colored>
  800417:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80041a:	8b 45 10             	mov    0x10(%ebp),%eax
  80041d:	83 ec 08             	sub    $0x8,%esp
  800420:	ff 75 f4             	pushl  -0xc(%ebp)
  800423:	50                   	push   %eax
  800424:	e8 04 02 00 00       	call   80062d <vcprintf>
  800429:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80042c:	83 ec 08             	sub    $0x8,%esp
  80042f:	6a 00                	push   $0x0
  800431:	68 f8 21 80 00       	push   $0x8021f8
  800436:	e8 f2 01 00 00       	call   80062d <vcprintf>
  80043b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80043e:	e8 7d ff ff ff       	call   8003c0 <exit>

	// should not return here
	while (1) ;
  800443:	eb fe                	jmp    800443 <_panic+0x75>

00800445 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800445:	55                   	push   %ebp
  800446:	89 e5                	mov    %esp,%ebp
  800448:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80044b:	a1 20 30 80 00       	mov    0x803020,%eax
  800450:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800456:	8b 45 0c             	mov    0xc(%ebp),%eax
  800459:	39 c2                	cmp    %eax,%edx
  80045b:	74 14                	je     800471 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80045d:	83 ec 04             	sub    $0x4,%esp
  800460:	68 fc 21 80 00       	push   $0x8021fc
  800465:	6a 26                	push   $0x26
  800467:	68 48 22 80 00       	push   $0x802248
  80046c:	e8 5d ff ff ff       	call   8003ce <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800478:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80047f:	e9 c5 00 00 00       	jmp    800549 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800484:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800487:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	01 d0                	add    %edx,%eax
  800493:	8b 00                	mov    (%eax),%eax
  800495:	85 c0                	test   %eax,%eax
  800497:	75 08                	jne    8004a1 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800499:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80049c:	e9 a5 00 00 00       	jmp    800546 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8004a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004af:	eb 69                	jmp    80051a <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b6:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004bf:	89 d0                	mov    %edx,%eax
  8004c1:	01 c0                	add    %eax,%eax
  8004c3:	01 d0                	add    %edx,%eax
  8004c5:	c1 e0 03             	shl    $0x3,%eax
  8004c8:	01 c8                	add    %ecx,%eax
  8004ca:	8a 40 04             	mov    0x4(%eax),%al
  8004cd:	84 c0                	test   %al,%al
  8004cf:	75 46                	jne    800517 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d6:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004df:	89 d0                	mov    %edx,%eax
  8004e1:	01 c0                	add    %eax,%eax
  8004e3:	01 d0                	add    %edx,%eax
  8004e5:	c1 e0 03             	shl    $0x3,%eax
  8004e8:	01 c8                	add    %ecx,%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004f7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004fc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800503:	8b 45 08             	mov    0x8(%ebp),%eax
  800506:	01 c8                	add    %ecx,%eax
  800508:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80050a:	39 c2                	cmp    %eax,%edx
  80050c:	75 09                	jne    800517 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80050e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800515:	eb 15                	jmp    80052c <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800517:	ff 45 e8             	incl   -0x18(%ebp)
  80051a:	a1 20 30 80 00       	mov    0x803020,%eax
  80051f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800525:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800528:	39 c2                	cmp    %eax,%edx
  80052a:	77 85                	ja     8004b1 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80052c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800530:	75 14                	jne    800546 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800532:	83 ec 04             	sub    $0x4,%esp
  800535:	68 54 22 80 00       	push   $0x802254
  80053a:	6a 3a                	push   $0x3a
  80053c:	68 48 22 80 00       	push   $0x802248
  800541:	e8 88 fe ff ff       	call   8003ce <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800546:	ff 45 f0             	incl   -0x10(%ebp)
  800549:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80054c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054f:	0f 8c 2f ff ff ff    	jl     800484 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800555:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800563:	eb 26                	jmp    80058b <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800565:	a1 20 30 80 00       	mov    0x803020,%eax
  80056a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800570:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800573:	89 d0                	mov    %edx,%eax
  800575:	01 c0                	add    %eax,%eax
  800577:	01 d0                	add    %edx,%eax
  800579:	c1 e0 03             	shl    $0x3,%eax
  80057c:	01 c8                	add    %ecx,%eax
  80057e:	8a 40 04             	mov    0x4(%eax),%al
  800581:	3c 01                	cmp    $0x1,%al
  800583:	75 03                	jne    800588 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800585:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800588:	ff 45 e0             	incl   -0x20(%ebp)
  80058b:	a1 20 30 80 00       	mov    0x803020,%eax
  800590:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800596:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800599:	39 c2                	cmp    %eax,%edx
  80059b:	77 c8                	ja     800565 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005a3:	74 14                	je     8005b9 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8005a5:	83 ec 04             	sub    $0x4,%esp
  8005a8:	68 a8 22 80 00       	push   $0x8022a8
  8005ad:	6a 44                	push   $0x44
  8005af:	68 48 22 80 00       	push   $0x802248
  8005b4:	e8 15 fe ff ff       	call   8003ce <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005b9:	90                   	nop
  8005ba:	c9                   	leave  
  8005bb:	c3                   	ret    

008005bc <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8005bc:	55                   	push   %ebp
  8005bd:	89 e5                	mov    %esp,%ebp
  8005bf:	53                   	push   %ebx
  8005c0:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8005c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	8d 48 01             	lea    0x1(%eax),%ecx
  8005cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ce:	89 0a                	mov    %ecx,(%edx)
  8005d0:	8b 55 08             	mov    0x8(%ebp),%edx
  8005d3:	88 d1                	mov    %dl,%cl
  8005d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e6:	75 30                	jne    800618 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8005e8:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8005ee:	a0 40 30 80 00       	mov    0x803040,%al
  8005f3:	0f b6 c0             	movzbl %al,%eax
  8005f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005f9:	8b 09                	mov    (%ecx),%ecx
  8005fb:	89 cb                	mov    %ecx,%ebx
  8005fd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800600:	83 c1 08             	add    $0x8,%ecx
  800603:	52                   	push   %edx
  800604:	50                   	push   %eax
  800605:	53                   	push   %ebx
  800606:	51                   	push   %ecx
  800607:	e8 c8 10 00 00       	call   8016d4 <sys_cputs>
  80060c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80060f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800612:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061b:	8b 40 04             	mov    0x4(%eax),%eax
  80061e:	8d 50 01             	lea    0x1(%eax),%edx
  800621:	8b 45 0c             	mov    0xc(%ebp),%eax
  800624:	89 50 04             	mov    %edx,0x4(%eax)
}
  800627:	90                   	nop
  800628:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80062b:	c9                   	leave  
  80062c:	c3                   	ret    

0080062d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80062d:	55                   	push   %ebp
  80062e:	89 e5                	mov    %esp,%ebp
  800630:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800636:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80063d:	00 00 00 
	b.cnt = 0;
  800640:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800647:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80064a:	ff 75 0c             	pushl  0xc(%ebp)
  80064d:	ff 75 08             	pushl  0x8(%ebp)
  800650:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800656:	50                   	push   %eax
  800657:	68 bc 05 80 00       	push   $0x8005bc
  80065c:	e8 5a 02 00 00       	call   8008bb <vprintfmt>
  800661:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800664:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80066a:	a0 40 30 80 00       	mov    0x803040,%al
  80066f:	0f b6 c0             	movzbl %al,%eax
  800672:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800678:	52                   	push   %edx
  800679:	50                   	push   %eax
  80067a:	51                   	push   %ecx
  80067b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800681:	83 c0 08             	add    $0x8,%eax
  800684:	50                   	push   %eax
  800685:	e8 4a 10 00 00       	call   8016d4 <sys_cputs>
  80068a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80068d:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800694:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80069a:	c9                   	leave  
  80069b:	c3                   	ret    

0080069c <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80069c:	55                   	push   %ebp
  80069d:	89 e5                	mov    %esp,%ebp
  80069f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006a2:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8006a9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b8:	50                   	push   %eax
  8006b9:	e8 6f ff ff ff       	call   80062d <vcprintf>
  8006be:	83 c4 10             	add    $0x10,%esp
  8006c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006c7:	c9                   	leave  
  8006c8:	c3                   	ret    

008006c9 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8006c9:	55                   	push   %ebp
  8006ca:	89 e5                	mov    %esp,%ebp
  8006cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006cf:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	c1 e0 08             	shl    $0x8,%eax
  8006dc:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8006e1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006e4:	83 c0 04             	add    $0x4,%eax
  8006e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ed:	83 ec 08             	sub    $0x8,%esp
  8006f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f3:	50                   	push   %eax
  8006f4:	e8 34 ff ff ff       	call   80062d <vcprintf>
  8006f9:	83 c4 10             	add    $0x10,%esp
  8006fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8006ff:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800706:	07 00 00 

	return cnt;
  800709:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80070c:	c9                   	leave  
  80070d:	c3                   	ret    

0080070e <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
  800711:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800714:	e8 ff 0f 00 00       	call   801718 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800719:	8d 45 0c             	lea    0xc(%ebp),%eax
  80071c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	83 ec 08             	sub    $0x8,%esp
  800725:	ff 75 f4             	pushl  -0xc(%ebp)
  800728:	50                   	push   %eax
  800729:	e8 ff fe ff ff       	call   80062d <vcprintf>
  80072e:	83 c4 10             	add    $0x10,%esp
  800731:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800734:	e8 f9 0f 00 00       	call   801732 <sys_unlock_cons>
	return cnt;
  800739:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	53                   	push   %ebx
  800742:	83 ec 14             	sub    $0x14,%esp
  800745:	8b 45 10             	mov    0x10(%ebp),%eax
  800748:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074b:	8b 45 14             	mov    0x14(%ebp),%eax
  80074e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800751:	8b 45 18             	mov    0x18(%ebp),%eax
  800754:	ba 00 00 00 00       	mov    $0x0,%edx
  800759:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80075c:	77 55                	ja     8007b3 <printnum+0x75>
  80075e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800761:	72 05                	jb     800768 <printnum+0x2a>
  800763:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800766:	77 4b                	ja     8007b3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800768:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80076b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80076e:	8b 45 18             	mov    0x18(%ebp),%eax
  800771:	ba 00 00 00 00       	mov    $0x0,%edx
  800776:	52                   	push   %edx
  800777:	50                   	push   %eax
  800778:	ff 75 f4             	pushl  -0xc(%ebp)
  80077b:	ff 75 f0             	pushl  -0x10(%ebp)
  80077e:	e8 8d 15 00 00       	call   801d10 <__udivdi3>
  800783:	83 c4 10             	add    $0x10,%esp
  800786:	83 ec 04             	sub    $0x4,%esp
  800789:	ff 75 20             	pushl  0x20(%ebp)
  80078c:	53                   	push   %ebx
  80078d:	ff 75 18             	pushl  0x18(%ebp)
  800790:	52                   	push   %edx
  800791:	50                   	push   %eax
  800792:	ff 75 0c             	pushl  0xc(%ebp)
  800795:	ff 75 08             	pushl  0x8(%ebp)
  800798:	e8 a1 ff ff ff       	call   80073e <printnum>
  80079d:	83 c4 20             	add    $0x20,%esp
  8007a0:	eb 1a                	jmp    8007bc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007a2:	83 ec 08             	sub    $0x8,%esp
  8007a5:	ff 75 0c             	pushl  0xc(%ebp)
  8007a8:	ff 75 20             	pushl  0x20(%ebp)
  8007ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ae:	ff d0                	call   *%eax
  8007b0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007b3:	ff 4d 1c             	decl   0x1c(%ebp)
  8007b6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007ba:	7f e6                	jg     8007a2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007bc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007bf:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ca:	53                   	push   %ebx
  8007cb:	51                   	push   %ecx
  8007cc:	52                   	push   %edx
  8007cd:	50                   	push   %eax
  8007ce:	e8 4d 16 00 00       	call   801e20 <__umoddi3>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	05 14 25 80 00       	add    $0x802514,%eax
  8007db:	8a 00                	mov    (%eax),%al
  8007dd:	0f be c0             	movsbl %al,%eax
  8007e0:	83 ec 08             	sub    $0x8,%esp
  8007e3:	ff 75 0c             	pushl  0xc(%ebp)
  8007e6:	50                   	push   %eax
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	ff d0                	call   *%eax
  8007ec:	83 c4 10             	add    $0x10,%esp
}
  8007ef:	90                   	nop
  8007f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007f3:	c9                   	leave  
  8007f4:	c3                   	ret    

008007f5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007f5:	55                   	push   %ebp
  8007f6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007f8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007fc:	7e 1c                	jle    80081a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	8b 00                	mov    (%eax),%eax
  800803:	8d 50 08             	lea    0x8(%eax),%edx
  800806:	8b 45 08             	mov    0x8(%ebp),%eax
  800809:	89 10                	mov    %edx,(%eax)
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	83 e8 08             	sub    $0x8,%eax
  800813:	8b 50 04             	mov    0x4(%eax),%edx
  800816:	8b 00                	mov    (%eax),%eax
  800818:	eb 40                	jmp    80085a <getuint+0x65>
	else if (lflag)
  80081a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80081e:	74 1e                	je     80083e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	8d 50 04             	lea    0x4(%eax),%edx
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	89 10                	mov    %edx,(%eax)
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	83 e8 04             	sub    $0x4,%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	ba 00 00 00 00       	mov    $0x0,%edx
  80083c:	eb 1c                	jmp    80085a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80083e:	8b 45 08             	mov    0x8(%ebp),%eax
  800841:	8b 00                	mov    (%eax),%eax
  800843:	8d 50 04             	lea    0x4(%eax),%edx
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	89 10                	mov    %edx,(%eax)
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	8b 00                	mov    (%eax),%eax
  800850:	83 e8 04             	sub    $0x4,%eax
  800853:	8b 00                	mov    (%eax),%eax
  800855:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80085a:	5d                   	pop    %ebp
  80085b:	c3                   	ret    

0080085c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80085c:	55                   	push   %ebp
  80085d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80085f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800863:	7e 1c                	jle    800881 <getint+0x25>
		return va_arg(*ap, long long);
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	8b 00                	mov    (%eax),%eax
  80086a:	8d 50 08             	lea    0x8(%eax),%edx
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	89 10                	mov    %edx,(%eax)
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	8b 00                	mov    (%eax),%eax
  800877:	83 e8 08             	sub    $0x8,%eax
  80087a:	8b 50 04             	mov    0x4(%eax),%edx
  80087d:	8b 00                	mov    (%eax),%eax
  80087f:	eb 38                	jmp    8008b9 <getint+0x5d>
	else if (lflag)
  800881:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800885:	74 1a                	je     8008a1 <getint+0x45>
		return va_arg(*ap, long);
  800887:	8b 45 08             	mov    0x8(%ebp),%eax
  80088a:	8b 00                	mov    (%eax),%eax
  80088c:	8d 50 04             	lea    0x4(%eax),%edx
  80088f:	8b 45 08             	mov    0x8(%ebp),%eax
  800892:	89 10                	mov    %edx,(%eax)
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	83 e8 04             	sub    $0x4,%eax
  80089c:	8b 00                	mov    (%eax),%eax
  80089e:	99                   	cltd   
  80089f:	eb 18                	jmp    8008b9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	8b 00                	mov    (%eax),%eax
  8008a6:	8d 50 04             	lea    0x4(%eax),%edx
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	89 10                	mov    %edx,(%eax)
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	8b 00                	mov    (%eax),%eax
  8008b3:	83 e8 04             	sub    $0x4,%eax
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	99                   	cltd   
}
  8008b9:	5d                   	pop    %ebp
  8008ba:	c3                   	ret    

008008bb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008bb:	55                   	push   %ebp
  8008bc:	89 e5                	mov    %esp,%ebp
  8008be:	56                   	push   %esi
  8008bf:	53                   	push   %ebx
  8008c0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008c3:	eb 17                	jmp    8008dc <vprintfmt+0x21>
			if (ch == '\0')
  8008c5:	85 db                	test   %ebx,%ebx
  8008c7:	0f 84 c1 03 00 00    	je     800c8e <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8008cd:	83 ec 08             	sub    $0x8,%esp
  8008d0:	ff 75 0c             	pushl  0xc(%ebp)
  8008d3:	53                   	push   %ebx
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	ff d0                	call   *%eax
  8008d9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008df:	8d 50 01             	lea    0x1(%eax),%edx
  8008e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8008e5:	8a 00                	mov    (%eax),%al
  8008e7:	0f b6 d8             	movzbl %al,%ebx
  8008ea:	83 fb 25             	cmp    $0x25,%ebx
  8008ed:	75 d6                	jne    8008c5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008ef:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008f3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008fa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800901:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800908:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80090f:	8b 45 10             	mov    0x10(%ebp),%eax
  800912:	8d 50 01             	lea    0x1(%eax),%edx
  800915:	89 55 10             	mov    %edx,0x10(%ebp)
  800918:	8a 00                	mov    (%eax),%al
  80091a:	0f b6 d8             	movzbl %al,%ebx
  80091d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800920:	83 f8 5b             	cmp    $0x5b,%eax
  800923:	0f 87 3d 03 00 00    	ja     800c66 <vprintfmt+0x3ab>
  800929:	8b 04 85 38 25 80 00 	mov    0x802538(,%eax,4),%eax
  800930:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800932:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800936:	eb d7                	jmp    80090f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800938:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80093c:	eb d1                	jmp    80090f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80093e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800945:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800948:	89 d0                	mov    %edx,%eax
  80094a:	c1 e0 02             	shl    $0x2,%eax
  80094d:	01 d0                	add    %edx,%eax
  80094f:	01 c0                	add    %eax,%eax
  800951:	01 d8                	add    %ebx,%eax
  800953:	83 e8 30             	sub    $0x30,%eax
  800956:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800959:	8b 45 10             	mov    0x10(%ebp),%eax
  80095c:	8a 00                	mov    (%eax),%al
  80095e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800961:	83 fb 2f             	cmp    $0x2f,%ebx
  800964:	7e 3e                	jle    8009a4 <vprintfmt+0xe9>
  800966:	83 fb 39             	cmp    $0x39,%ebx
  800969:	7f 39                	jg     8009a4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80096b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80096e:	eb d5                	jmp    800945 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800970:	8b 45 14             	mov    0x14(%ebp),%eax
  800973:	83 c0 04             	add    $0x4,%eax
  800976:	89 45 14             	mov    %eax,0x14(%ebp)
  800979:	8b 45 14             	mov    0x14(%ebp),%eax
  80097c:	83 e8 04             	sub    $0x4,%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800984:	eb 1f                	jmp    8009a5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800986:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098a:	79 83                	jns    80090f <vprintfmt+0x54>
				width = 0;
  80098c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800993:	e9 77 ff ff ff       	jmp    80090f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800998:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80099f:	e9 6b ff ff ff       	jmp    80090f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009a4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009a5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a9:	0f 89 60 ff ff ff    	jns    80090f <vprintfmt+0x54>
				width = precision, precision = -1;
  8009af:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009b5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009bc:	e9 4e ff ff ff       	jmp    80090f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009c1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009c4:	e9 46 ff ff ff       	jmp    80090f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009cc:	83 c0 04             	add    $0x4,%eax
  8009cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d5:	83 e8 04             	sub    $0x4,%eax
  8009d8:	8b 00                	mov    (%eax),%eax
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	50                   	push   %eax
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
			break;
  8009e9:	e9 9b 02 00 00       	jmp    800c89 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f1:	83 c0 04             	add    $0x4,%eax
  8009f4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fa:	83 e8 04             	sub    $0x4,%eax
  8009fd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009ff:	85 db                	test   %ebx,%ebx
  800a01:	79 02                	jns    800a05 <vprintfmt+0x14a>
				err = -err;
  800a03:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a05:	83 fb 64             	cmp    $0x64,%ebx
  800a08:	7f 0b                	jg     800a15 <vprintfmt+0x15a>
  800a0a:	8b 34 9d 80 23 80 00 	mov    0x802380(,%ebx,4),%esi
  800a11:	85 f6                	test   %esi,%esi
  800a13:	75 19                	jne    800a2e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a15:	53                   	push   %ebx
  800a16:	68 25 25 80 00       	push   $0x802525
  800a1b:	ff 75 0c             	pushl  0xc(%ebp)
  800a1e:	ff 75 08             	pushl  0x8(%ebp)
  800a21:	e8 70 02 00 00       	call   800c96 <printfmt>
  800a26:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a29:	e9 5b 02 00 00       	jmp    800c89 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a2e:	56                   	push   %esi
  800a2f:	68 2e 25 80 00       	push   $0x80252e
  800a34:	ff 75 0c             	pushl  0xc(%ebp)
  800a37:	ff 75 08             	pushl  0x8(%ebp)
  800a3a:	e8 57 02 00 00       	call   800c96 <printfmt>
  800a3f:	83 c4 10             	add    $0x10,%esp
			break;
  800a42:	e9 42 02 00 00       	jmp    800c89 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a47:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4a:	83 c0 04             	add    $0x4,%eax
  800a4d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a50:	8b 45 14             	mov    0x14(%ebp),%eax
  800a53:	83 e8 04             	sub    $0x4,%eax
  800a56:	8b 30                	mov    (%eax),%esi
  800a58:	85 f6                	test   %esi,%esi
  800a5a:	75 05                	jne    800a61 <vprintfmt+0x1a6>
				p = "(null)";
  800a5c:	be 31 25 80 00       	mov    $0x802531,%esi
			if (width > 0 && padc != '-')
  800a61:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a65:	7e 6d                	jle    800ad4 <vprintfmt+0x219>
  800a67:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a6b:	74 67                	je     800ad4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	50                   	push   %eax
  800a74:	56                   	push   %esi
  800a75:	e8 1e 03 00 00       	call   800d98 <strnlen>
  800a7a:	83 c4 10             	add    $0x10,%esp
  800a7d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a80:	eb 16                	jmp    800a98 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a82:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 0c             	pushl  0xc(%ebp)
  800a8c:	50                   	push   %eax
  800a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a90:	ff d0                	call   *%eax
  800a92:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a95:	ff 4d e4             	decl   -0x1c(%ebp)
  800a98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a9c:	7f e4                	jg     800a82 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a9e:	eb 34                	jmp    800ad4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aa0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aa4:	74 1c                	je     800ac2 <vprintfmt+0x207>
  800aa6:	83 fb 1f             	cmp    $0x1f,%ebx
  800aa9:	7e 05                	jle    800ab0 <vprintfmt+0x1f5>
  800aab:	83 fb 7e             	cmp    $0x7e,%ebx
  800aae:	7e 12                	jle    800ac2 <vprintfmt+0x207>
					putch('?', putdat);
  800ab0:	83 ec 08             	sub    $0x8,%esp
  800ab3:	ff 75 0c             	pushl  0xc(%ebp)
  800ab6:	6a 3f                	push   $0x3f
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	ff d0                	call   *%eax
  800abd:	83 c4 10             	add    $0x10,%esp
  800ac0:	eb 0f                	jmp    800ad1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	53                   	push   %ebx
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	ff d0                	call   *%eax
  800ace:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad1:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad4:	89 f0                	mov    %esi,%eax
  800ad6:	8d 70 01             	lea    0x1(%eax),%esi
  800ad9:	8a 00                	mov    (%eax),%al
  800adb:	0f be d8             	movsbl %al,%ebx
  800ade:	85 db                	test   %ebx,%ebx
  800ae0:	74 24                	je     800b06 <vprintfmt+0x24b>
  800ae2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ae6:	78 b8                	js     800aa0 <vprintfmt+0x1e5>
  800ae8:	ff 4d e0             	decl   -0x20(%ebp)
  800aeb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aef:	79 af                	jns    800aa0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800af1:	eb 13                	jmp    800b06 <vprintfmt+0x24b>
				putch(' ', putdat);
  800af3:	83 ec 08             	sub    $0x8,%esp
  800af6:	ff 75 0c             	pushl  0xc(%ebp)
  800af9:	6a 20                	push   $0x20
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b03:	ff 4d e4             	decl   -0x1c(%ebp)
  800b06:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b0a:	7f e7                	jg     800af3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b0c:	e9 78 01 00 00       	jmp    800c89 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b11:	83 ec 08             	sub    $0x8,%esp
  800b14:	ff 75 e8             	pushl  -0x18(%ebp)
  800b17:	8d 45 14             	lea    0x14(%ebp),%eax
  800b1a:	50                   	push   %eax
  800b1b:	e8 3c fd ff ff       	call   80085c <getint>
  800b20:	83 c4 10             	add    $0x10,%esp
  800b23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b26:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b2f:	85 d2                	test   %edx,%edx
  800b31:	79 23                	jns    800b56 <vprintfmt+0x29b>
				putch('-', putdat);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 0c             	pushl  0xc(%ebp)
  800b39:	6a 2d                	push   $0x2d
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	ff d0                	call   *%eax
  800b40:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b49:	f7 d8                	neg    %eax
  800b4b:	83 d2 00             	adc    $0x0,%edx
  800b4e:	f7 da                	neg    %edx
  800b50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b53:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b56:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b5d:	e9 bc 00 00 00       	jmp    800c1e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b62:	83 ec 08             	sub    $0x8,%esp
  800b65:	ff 75 e8             	pushl  -0x18(%ebp)
  800b68:	8d 45 14             	lea    0x14(%ebp),%eax
  800b6b:	50                   	push   %eax
  800b6c:	e8 84 fc ff ff       	call   8007f5 <getuint>
  800b71:	83 c4 10             	add    $0x10,%esp
  800b74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b77:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b7a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b81:	e9 98 00 00 00       	jmp    800c1e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b86:	83 ec 08             	sub    $0x8,%esp
  800b89:	ff 75 0c             	pushl  0xc(%ebp)
  800b8c:	6a 58                	push   $0x58
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	ff d0                	call   *%eax
  800b93:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b96:	83 ec 08             	sub    $0x8,%esp
  800b99:	ff 75 0c             	pushl  0xc(%ebp)
  800b9c:	6a 58                	push   $0x58
  800b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba1:	ff d0                	call   *%eax
  800ba3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ba6:	83 ec 08             	sub    $0x8,%esp
  800ba9:	ff 75 0c             	pushl  0xc(%ebp)
  800bac:	6a 58                	push   $0x58
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	ff d0                	call   *%eax
  800bb3:	83 c4 10             	add    $0x10,%esp
			break;
  800bb6:	e9 ce 00 00 00       	jmp    800c89 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800bbb:	83 ec 08             	sub    $0x8,%esp
  800bbe:	ff 75 0c             	pushl  0xc(%ebp)
  800bc1:	6a 30                	push   $0x30
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	ff d0                	call   *%eax
  800bc8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bcb:	83 ec 08             	sub    $0x8,%esp
  800bce:	ff 75 0c             	pushl  0xc(%ebp)
  800bd1:	6a 78                	push   $0x78
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	ff d0                	call   *%eax
  800bd8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bdb:	8b 45 14             	mov    0x14(%ebp),%eax
  800bde:	83 c0 04             	add    $0x4,%eax
  800be1:	89 45 14             	mov    %eax,0x14(%ebp)
  800be4:	8b 45 14             	mov    0x14(%ebp),%eax
  800be7:	83 e8 04             	sub    $0x4,%eax
  800bea:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bf6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bfd:	eb 1f                	jmp    800c1e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 e8             	pushl  -0x18(%ebp)
  800c05:	8d 45 14             	lea    0x14(%ebp),%eax
  800c08:	50                   	push   %eax
  800c09:	e8 e7 fb ff ff       	call   8007f5 <getuint>
  800c0e:	83 c4 10             	add    $0x10,%esp
  800c11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c14:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c17:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c1e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c25:	83 ec 04             	sub    $0x4,%esp
  800c28:	52                   	push   %edx
  800c29:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c2c:	50                   	push   %eax
  800c2d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c30:	ff 75 f0             	pushl  -0x10(%ebp)
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	ff 75 08             	pushl  0x8(%ebp)
  800c39:	e8 00 fb ff ff       	call   80073e <printnum>
  800c3e:	83 c4 20             	add    $0x20,%esp
			break;
  800c41:	eb 46                	jmp    800c89 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c43:	83 ec 08             	sub    $0x8,%esp
  800c46:	ff 75 0c             	pushl  0xc(%ebp)
  800c49:	53                   	push   %ebx
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	ff d0                	call   *%eax
  800c4f:	83 c4 10             	add    $0x10,%esp
			break;
  800c52:	eb 35                	jmp    800c89 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c54:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800c5b:	eb 2c                	jmp    800c89 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c5d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800c64:	eb 23                	jmp    800c89 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c66:	83 ec 08             	sub    $0x8,%esp
  800c69:	ff 75 0c             	pushl  0xc(%ebp)
  800c6c:	6a 25                	push   $0x25
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	ff d0                	call   *%eax
  800c73:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c76:	ff 4d 10             	decl   0x10(%ebp)
  800c79:	eb 03                	jmp    800c7e <vprintfmt+0x3c3>
  800c7b:	ff 4d 10             	decl   0x10(%ebp)
  800c7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c81:	48                   	dec    %eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	3c 25                	cmp    $0x25,%al
  800c86:	75 f3                	jne    800c7b <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c88:	90                   	nop
		}
	}
  800c89:	e9 35 fc ff ff       	jmp    8008c3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c8e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c92:	5b                   	pop    %ebx
  800c93:	5e                   	pop    %esi
  800c94:	5d                   	pop    %ebp
  800c95:	c3                   	ret    

00800c96 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
  800c99:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c9c:	8d 45 10             	lea    0x10(%ebp),%eax
  800c9f:	83 c0 04             	add    $0x4,%eax
  800ca2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ca5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca8:	ff 75 f4             	pushl  -0xc(%ebp)
  800cab:	50                   	push   %eax
  800cac:	ff 75 0c             	pushl  0xc(%ebp)
  800caf:	ff 75 08             	pushl  0x8(%ebp)
  800cb2:	e8 04 fc ff ff       	call   8008bb <vprintfmt>
  800cb7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cba:	90                   	nop
  800cbb:	c9                   	leave  
  800cbc:	c3                   	ret    

00800cbd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc3:	8b 40 08             	mov    0x8(%eax),%eax
  800cc6:	8d 50 01             	lea    0x1(%eax),%edx
  800cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd2:	8b 10                	mov    (%eax),%edx
  800cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd7:	8b 40 04             	mov    0x4(%eax),%eax
  800cda:	39 c2                	cmp    %eax,%edx
  800cdc:	73 12                	jae    800cf0 <sprintputch+0x33>
		*b->buf++ = ch;
  800cde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce1:	8b 00                	mov    (%eax),%eax
  800ce3:	8d 48 01             	lea    0x1(%eax),%ecx
  800ce6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce9:	89 0a                	mov    %ecx,(%edx)
  800ceb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cee:	88 10                	mov    %dl,(%eax)
}
  800cf0:	90                   	nop
  800cf1:	5d                   	pop    %ebp
  800cf2:	c3                   	ret    

00800cf3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cf3:	55                   	push   %ebp
  800cf4:	89 e5                	mov    %esp,%ebp
  800cf6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d02:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	01 d0                	add    %edx,%eax
  800d0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d14:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d18:	74 06                	je     800d20 <vsnprintf+0x2d>
  800d1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1e:	7f 07                	jg     800d27 <vsnprintf+0x34>
		return -E_INVAL;
  800d20:	b8 03 00 00 00       	mov    $0x3,%eax
  800d25:	eb 20                	jmp    800d47 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d27:	ff 75 14             	pushl  0x14(%ebp)
  800d2a:	ff 75 10             	pushl  0x10(%ebp)
  800d2d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d30:	50                   	push   %eax
  800d31:	68 bd 0c 80 00       	push   $0x800cbd
  800d36:	e8 80 fb ff ff       	call   8008bb <vprintfmt>
  800d3b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d41:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d44:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d47:	c9                   	leave  
  800d48:	c3                   	ret    

00800d49 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d49:	55                   	push   %ebp
  800d4a:	89 e5                	mov    %esp,%ebp
  800d4c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d4f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d52:	83 c0 04             	add    $0x4,%eax
  800d55:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d58:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d5e:	50                   	push   %eax
  800d5f:	ff 75 0c             	pushl  0xc(%ebp)
  800d62:	ff 75 08             	pushl  0x8(%ebp)
  800d65:	e8 89 ff ff ff       	call   800cf3 <vsnprintf>
  800d6a:	83 c4 10             	add    $0x10,%esp
  800d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d70:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d73:	c9                   	leave  
  800d74:	c3                   	ret    

00800d75 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d75:	55                   	push   %ebp
  800d76:	89 e5                	mov    %esp,%ebp
  800d78:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d82:	eb 06                	jmp    800d8a <strlen+0x15>
		n++;
  800d84:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d87:	ff 45 08             	incl   0x8(%ebp)
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	84 c0                	test   %al,%al
  800d91:	75 f1                	jne    800d84 <strlen+0xf>
		n++;
	return n;
  800d93:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
  800d9b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da5:	eb 09                	jmp    800db0 <strnlen+0x18>
		n++;
  800da7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	ff 4d 0c             	decl   0xc(%ebp)
  800db0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db4:	74 09                	je     800dbf <strnlen+0x27>
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	84 c0                	test   %al,%al
  800dbd:	75 e8                	jne    800da7 <strnlen+0xf>
		n++;
	return n;
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dc2:	c9                   	leave  
  800dc3:	c3                   	ret    

00800dc4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dc4:	55                   	push   %ebp
  800dc5:	89 e5                	mov    %esp,%ebp
  800dc7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dd0:	90                   	nop
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8d 50 01             	lea    0x1(%eax),%edx
  800dd7:	89 55 08             	mov    %edx,0x8(%ebp)
  800dda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ddd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800de3:	8a 12                	mov    (%edx),%dl
  800de5:	88 10                	mov    %dl,(%eax)
  800de7:	8a 00                	mov    (%eax),%al
  800de9:	84 c0                	test   %al,%al
  800deb:	75 e4                	jne    800dd1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ded:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800df0:	c9                   	leave  
  800df1:	c3                   	ret    

00800df2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800df2:	55                   	push   %ebp
  800df3:	89 e5                	mov    %esp,%ebp
  800df5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dfe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e05:	eb 1f                	jmp    800e26 <strncpy+0x34>
		*dst++ = *src;
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8d 50 01             	lea    0x1(%eax),%edx
  800e0d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e13:	8a 12                	mov    (%edx),%dl
  800e15:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	84 c0                	test   %al,%al
  800e1e:	74 03                	je     800e23 <strncpy+0x31>
			src++;
  800e20:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e23:	ff 45 fc             	incl   -0x4(%ebp)
  800e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e29:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e2c:	72 d9                	jb     800e07 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e31:	c9                   	leave  
  800e32:	c3                   	ret    

00800e33 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e43:	74 30                	je     800e75 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e45:	eb 16                	jmp    800e5d <strlcpy+0x2a>
			*dst++ = *src++;
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8d 50 01             	lea    0x1(%eax),%edx
  800e4d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e50:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e53:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e56:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e59:	8a 12                	mov    (%edx),%dl
  800e5b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e5d:	ff 4d 10             	decl   0x10(%ebp)
  800e60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e64:	74 09                	je     800e6f <strlcpy+0x3c>
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	8a 00                	mov    (%eax),%al
  800e6b:	84 c0                	test   %al,%al
  800e6d:	75 d8                	jne    800e47 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e75:	8b 55 08             	mov    0x8(%ebp),%edx
  800e78:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7b:	29 c2                	sub    %eax,%edx
  800e7d:	89 d0                	mov    %edx,%eax
}
  800e7f:	c9                   	leave  
  800e80:	c3                   	ret    

00800e81 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e81:	55                   	push   %ebp
  800e82:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e84:	eb 06                	jmp    800e8c <strcmp+0xb>
		p++, q++;
  800e86:	ff 45 08             	incl   0x8(%ebp)
  800e89:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	84 c0                	test   %al,%al
  800e93:	74 0e                	je     800ea3 <strcmp+0x22>
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	8a 10                	mov    (%eax),%dl
  800e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9d:	8a 00                	mov    (%eax),%al
  800e9f:	38 c2                	cmp    %al,%dl
  800ea1:	74 e3                	je     800e86 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	0f b6 d0             	movzbl %al,%edx
  800eab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	0f b6 c0             	movzbl %al,%eax
  800eb3:	29 c2                	sub    %eax,%edx
  800eb5:	89 d0                	mov    %edx,%eax
}
  800eb7:	5d                   	pop    %ebp
  800eb8:	c3                   	ret    

00800eb9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800eb9:	55                   	push   %ebp
  800eba:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ebc:	eb 09                	jmp    800ec7 <strncmp+0xe>
		n--, p++, q++;
  800ebe:	ff 4d 10             	decl   0x10(%ebp)
  800ec1:	ff 45 08             	incl   0x8(%ebp)
  800ec4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ec7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ecb:	74 17                	je     800ee4 <strncmp+0x2b>
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	84 c0                	test   %al,%al
  800ed4:	74 0e                	je     800ee4 <strncmp+0x2b>
  800ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed9:	8a 10                	mov    (%eax),%dl
  800edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	38 c2                	cmp    %al,%dl
  800ee2:	74 da                	je     800ebe <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ee4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee8:	75 07                	jne    800ef1 <strncmp+0x38>
		return 0;
  800eea:	b8 00 00 00 00       	mov    $0x0,%eax
  800eef:	eb 14                	jmp    800f05 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	0f b6 d0             	movzbl %al,%edx
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	0f b6 c0             	movzbl %al,%eax
  800f01:	29 c2                	sub    %eax,%edx
  800f03:	89 d0                	mov    %edx,%eax
}
  800f05:	5d                   	pop    %ebp
  800f06:	c3                   	ret    

00800f07 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f07:	55                   	push   %ebp
  800f08:	89 e5                	mov    %esp,%ebp
  800f0a:	83 ec 04             	sub    $0x4,%esp
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f13:	eb 12                	jmp    800f27 <strchr+0x20>
		if (*s == c)
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f1d:	75 05                	jne    800f24 <strchr+0x1d>
			return (char *) s;
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	eb 11                	jmp    800f35 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f24:	ff 45 08             	incl   0x8(%ebp)
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	8a 00                	mov    (%eax),%al
  800f2c:	84 c0                	test   %al,%al
  800f2e:	75 e5                	jne    800f15 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f30:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f35:	c9                   	leave  
  800f36:	c3                   	ret    

00800f37 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f37:	55                   	push   %ebp
  800f38:	89 e5                	mov    %esp,%ebp
  800f3a:	83 ec 04             	sub    $0x4,%esp
  800f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f40:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f43:	eb 0d                	jmp    800f52 <strfind+0x1b>
		if (*s == c)
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f4d:	74 0e                	je     800f5d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f4f:	ff 45 08             	incl   0x8(%ebp)
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	84 c0                	test   %al,%al
  800f59:	75 ea                	jne    800f45 <strfind+0xe>
  800f5b:	eb 01                	jmp    800f5e <strfind+0x27>
		if (*s == c)
			break;
  800f5d:	90                   	nop
	return (char *) s;
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
  800f66:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f6f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f73:	76 63                	jbe    800fd8 <memset+0x75>
		uint64 data_block = c;
  800f75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f78:	99                   	cltd   
  800f79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f85:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f89:	c1 e0 08             	shl    $0x8,%eax
  800f8c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f8f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f95:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f98:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f9c:	c1 e0 10             	shl    $0x10,%eax
  800f9f:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fa2:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800fa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fab:	89 c2                	mov    %eax,%edx
  800fad:	b8 00 00 00 00       	mov    $0x0,%eax
  800fb2:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fb5:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800fb8:	eb 18                	jmp    800fd2 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800fba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fbd:	8d 41 08             	lea    0x8(%ecx),%eax
  800fc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800fc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc9:	89 01                	mov    %eax,(%ecx)
  800fcb:	89 51 04             	mov    %edx,0x4(%ecx)
  800fce:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800fd2:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fd6:	77 e2                	ja     800fba <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800fd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fdc:	74 23                	je     801001 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fe4:	eb 0e                	jmp    800ff4 <memset+0x91>
			*p8++ = (uint8)c;
  800fe6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe9:	8d 50 01             	lea    0x1(%eax),%edx
  800fec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fef:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff2:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ff4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ffa:	89 55 10             	mov    %edx,0x10(%ebp)
  800ffd:	85 c0                	test   %eax,%eax
  800fff:	75 e5                	jne    800fe6 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801004:	c9                   	leave  
  801005:	c3                   	ret    

00801006 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801006:	55                   	push   %ebp
  801007:	89 e5                	mov    %esp,%ebp
  801009:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801018:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80101c:	76 24                	jbe    801042 <memcpy+0x3c>
		while(n >= 8){
  80101e:	eb 1c                	jmp    80103c <memcpy+0x36>
			*d64 = *s64;
  801020:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801023:	8b 50 04             	mov    0x4(%eax),%edx
  801026:	8b 00                	mov    (%eax),%eax
  801028:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80102b:	89 01                	mov    %eax,(%ecx)
  80102d:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801030:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801034:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801038:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80103c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801040:	77 de                	ja     801020 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801042:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801046:	74 31                	je     801079 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801048:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80104e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801051:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801054:	eb 16                	jmp    80106c <memcpy+0x66>
			*d8++ = *s8++;
  801056:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801059:	8d 50 01             	lea    0x1(%eax),%edx
  80105c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80105f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801062:	8d 4a 01             	lea    0x1(%edx),%ecx
  801065:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801068:	8a 12                	mov    (%edx),%dl
  80106a:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80106c:	8b 45 10             	mov    0x10(%ebp),%eax
  80106f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801072:	89 55 10             	mov    %edx,0x10(%ebp)
  801075:	85 c0                	test   %eax,%eax
  801077:	75 dd                	jne    801056 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80107c:	c9                   	leave  
  80107d:	c3                   	ret    

0080107e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80107e:	55                   	push   %ebp
  80107f:	89 e5                	mov    %esp,%ebp
  801081:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801084:	8b 45 0c             	mov    0xc(%ebp),%eax
  801087:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801090:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801093:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801096:	73 50                	jae    8010e8 <memmove+0x6a>
  801098:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109b:	8b 45 10             	mov    0x10(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010a3:	76 43                	jbe    8010e8 <memmove+0x6a>
		s += n;
  8010a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ae:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010b1:	eb 10                	jmp    8010c3 <memmove+0x45>
			*--d = *--s;
  8010b3:	ff 4d f8             	decl   -0x8(%ebp)
  8010b6:	ff 4d fc             	decl   -0x4(%ebp)
  8010b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bc:	8a 10                	mov    (%eax),%dl
  8010be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c9:	89 55 10             	mov    %edx,0x10(%ebp)
  8010cc:	85 c0                	test   %eax,%eax
  8010ce:	75 e3                	jne    8010b3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010d0:	eb 23                	jmp    8010f5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d5:	8d 50 01             	lea    0x1(%eax),%edx
  8010d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010de:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010e4:	8a 12                	mov    (%edx),%dl
  8010e6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ee:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f1:	85 c0                	test   %eax,%eax
  8010f3:	75 dd                	jne    8010d2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f8:	c9                   	leave  
  8010f9:	c3                   	ret    

008010fa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010fa:	55                   	push   %ebp
  8010fb:	89 e5                	mov    %esp,%ebp
  8010fd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801106:	8b 45 0c             	mov    0xc(%ebp),%eax
  801109:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80110c:	eb 2a                	jmp    801138 <memcmp+0x3e>
		if (*s1 != *s2)
  80110e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801111:	8a 10                	mov    (%eax),%dl
  801113:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801116:	8a 00                	mov    (%eax),%al
  801118:	38 c2                	cmp    %al,%dl
  80111a:	74 16                	je     801132 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80111c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	0f b6 d0             	movzbl %al,%edx
  801124:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801127:	8a 00                	mov    (%eax),%al
  801129:	0f b6 c0             	movzbl %al,%eax
  80112c:	29 c2                	sub    %eax,%edx
  80112e:	89 d0                	mov    %edx,%eax
  801130:	eb 18                	jmp    80114a <memcmp+0x50>
		s1++, s2++;
  801132:	ff 45 fc             	incl   -0x4(%ebp)
  801135:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801138:	8b 45 10             	mov    0x10(%ebp),%eax
  80113b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80113e:	89 55 10             	mov    %edx,0x10(%ebp)
  801141:	85 c0                	test   %eax,%eax
  801143:	75 c9                	jne    80110e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801145:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
  80114f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801152:	8b 55 08             	mov    0x8(%ebp),%edx
  801155:	8b 45 10             	mov    0x10(%ebp),%eax
  801158:	01 d0                	add    %edx,%eax
  80115a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80115d:	eb 15                	jmp    801174 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	0f b6 d0             	movzbl %al,%edx
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	0f b6 c0             	movzbl %al,%eax
  80116d:	39 c2                	cmp    %eax,%edx
  80116f:	74 0d                	je     80117e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801171:	ff 45 08             	incl   0x8(%ebp)
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80117a:	72 e3                	jb     80115f <memfind+0x13>
  80117c:	eb 01                	jmp    80117f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80117e:	90                   	nop
	return (void *) s;
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801182:	c9                   	leave  
  801183:	c3                   	ret    

00801184 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801184:	55                   	push   %ebp
  801185:	89 e5                	mov    %esp,%ebp
  801187:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80118a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801191:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801198:	eb 03                	jmp    80119d <strtol+0x19>
		s++;
  80119a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3c 20                	cmp    $0x20,%al
  8011a4:	74 f4                	je     80119a <strtol+0x16>
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	3c 09                	cmp    $0x9,%al
  8011ad:	74 eb                	je     80119a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	3c 2b                	cmp    $0x2b,%al
  8011b6:	75 05                	jne    8011bd <strtol+0x39>
		s++;
  8011b8:	ff 45 08             	incl   0x8(%ebp)
  8011bb:	eb 13                	jmp    8011d0 <strtol+0x4c>
	else if (*s == '-')
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	3c 2d                	cmp    $0x2d,%al
  8011c4:	75 0a                	jne    8011d0 <strtol+0x4c>
		s++, neg = 1;
  8011c6:	ff 45 08             	incl   0x8(%ebp)
  8011c9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d4:	74 06                	je     8011dc <strtol+0x58>
  8011d6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011da:	75 20                	jne    8011fc <strtol+0x78>
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	3c 30                	cmp    $0x30,%al
  8011e3:	75 17                	jne    8011fc <strtol+0x78>
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	40                   	inc    %eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	3c 78                	cmp    $0x78,%al
  8011ed:	75 0d                	jne    8011fc <strtol+0x78>
		s += 2, base = 16;
  8011ef:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011f3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011fa:	eb 28                	jmp    801224 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801200:	75 15                	jne    801217 <strtol+0x93>
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3c 30                	cmp    $0x30,%al
  801209:	75 0c                	jne    801217 <strtol+0x93>
		s++, base = 8;
  80120b:	ff 45 08             	incl   0x8(%ebp)
  80120e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801215:	eb 0d                	jmp    801224 <strtol+0xa0>
	else if (base == 0)
  801217:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80121b:	75 07                	jne    801224 <strtol+0xa0>
		base = 10;
  80121d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	3c 2f                	cmp    $0x2f,%al
  80122b:	7e 19                	jle    801246 <strtol+0xc2>
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	3c 39                	cmp    $0x39,%al
  801234:	7f 10                	jg     801246 <strtol+0xc2>
			dig = *s - '0';
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	0f be c0             	movsbl %al,%eax
  80123e:	83 e8 30             	sub    $0x30,%eax
  801241:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801244:	eb 42                	jmp    801288 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	3c 60                	cmp    $0x60,%al
  80124d:	7e 19                	jle    801268 <strtol+0xe4>
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	3c 7a                	cmp    $0x7a,%al
  801256:	7f 10                	jg     801268 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	0f be c0             	movsbl %al,%eax
  801260:	83 e8 57             	sub    $0x57,%eax
  801263:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801266:	eb 20                	jmp    801288 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	3c 40                	cmp    $0x40,%al
  80126f:	7e 39                	jle    8012aa <strtol+0x126>
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	8a 00                	mov    (%eax),%al
  801276:	3c 5a                	cmp    $0x5a,%al
  801278:	7f 30                	jg     8012aa <strtol+0x126>
			dig = *s - 'A' + 10;
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	0f be c0             	movsbl %al,%eax
  801282:	83 e8 37             	sub    $0x37,%eax
  801285:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801288:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80128b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80128e:	7d 19                	jge    8012a9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801290:	ff 45 08             	incl   0x8(%ebp)
  801293:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801296:	0f af 45 10          	imul   0x10(%ebp),%eax
  80129a:	89 c2                	mov    %eax,%edx
  80129c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129f:	01 d0                	add    %edx,%eax
  8012a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012a4:	e9 7b ff ff ff       	jmp    801224 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012a9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ae:	74 08                	je     8012b8 <strtol+0x134>
		*endptr = (char *) s;
  8012b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012b8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012bc:	74 07                	je     8012c5 <strtol+0x141>
  8012be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c1:	f7 d8                	neg    %eax
  8012c3:	eb 03                	jmp    8012c8 <strtol+0x144>
  8012c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012c8:	c9                   	leave  
  8012c9:	c3                   	ret    

008012ca <ltostr>:

void
ltostr(long value, char *str)
{
  8012ca:	55                   	push   %ebp
  8012cb:	89 e5                	mov    %esp,%ebp
  8012cd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012de:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e2:	79 13                	jns    8012f7 <ltostr+0x2d>
	{
		neg = 1;
  8012e4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ee:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012f1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012f4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012ff:	99                   	cltd   
  801300:	f7 f9                	idiv   %ecx
  801302:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801305:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801308:	8d 50 01             	lea    0x1(%eax),%edx
  80130b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80130e:	89 c2                	mov    %eax,%edx
  801310:	8b 45 0c             	mov    0xc(%ebp),%eax
  801313:	01 d0                	add    %edx,%eax
  801315:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801318:	83 c2 30             	add    $0x30,%edx
  80131b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80131d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801320:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801325:	f7 e9                	imul   %ecx
  801327:	c1 fa 02             	sar    $0x2,%edx
  80132a:	89 c8                	mov    %ecx,%eax
  80132c:	c1 f8 1f             	sar    $0x1f,%eax
  80132f:	29 c2                	sub    %eax,%edx
  801331:	89 d0                	mov    %edx,%eax
  801333:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801336:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80133a:	75 bb                	jne    8012f7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80133c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801343:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801346:	48                   	dec    %eax
  801347:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80134a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80134e:	74 3d                	je     80138d <ltostr+0xc3>
		start = 1 ;
  801350:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801357:	eb 34                	jmp    80138d <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801359:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135f:	01 d0                	add    %edx,%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801366:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801369:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136c:	01 c2                	add    %eax,%edx
  80136e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801371:	8b 45 0c             	mov    0xc(%ebp),%eax
  801374:	01 c8                	add    %ecx,%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80137a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80137d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801380:	01 c2                	add    %eax,%edx
  801382:	8a 45 eb             	mov    -0x15(%ebp),%al
  801385:	88 02                	mov    %al,(%edx)
		start++ ;
  801387:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80138a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80138d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801390:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801393:	7c c4                	jl     801359 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801395:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801398:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139b:	01 d0                	add    %edx,%eax
  80139d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013a0:	90                   	nop
  8013a1:	c9                   	leave  
  8013a2:	c3                   	ret    

008013a3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
  8013a6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013a9:	ff 75 08             	pushl  0x8(%ebp)
  8013ac:	e8 c4 f9 ff ff       	call   800d75 <strlen>
  8013b1:	83 c4 04             	add    $0x4,%esp
  8013b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013b7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ba:	e8 b6 f9 ff ff       	call   800d75 <strlen>
  8013bf:	83 c4 04             	add    $0x4,%esp
  8013c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d3:	eb 17                	jmp    8013ec <strcconcat+0x49>
		final[s] = str1[s] ;
  8013d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013db:	01 c2                	add    %eax,%edx
  8013dd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	01 c8                	add    %ecx,%eax
  8013e5:	8a 00                	mov    (%eax),%al
  8013e7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013e9:	ff 45 fc             	incl   -0x4(%ebp)
  8013ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013f2:	7c e1                	jl     8013d5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013fb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801402:	eb 1f                	jmp    801423 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801404:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801407:	8d 50 01             	lea    0x1(%eax),%edx
  80140a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80140d:	89 c2                	mov    %eax,%edx
  80140f:	8b 45 10             	mov    0x10(%ebp),%eax
  801412:	01 c2                	add    %eax,%edx
  801414:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141a:	01 c8                	add    %ecx,%eax
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801420:	ff 45 f8             	incl   -0x8(%ebp)
  801423:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801426:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801429:	7c d9                	jl     801404 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80142b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142e:	8b 45 10             	mov    0x10(%ebp),%eax
  801431:	01 d0                	add    %edx,%eax
  801433:	c6 00 00             	movb   $0x0,(%eax)
}
  801436:	90                   	nop
  801437:	c9                   	leave  
  801438:	c3                   	ret    

00801439 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80143c:	8b 45 14             	mov    0x14(%ebp),%eax
  80143f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801445:	8b 45 14             	mov    0x14(%ebp),%eax
  801448:	8b 00                	mov    (%eax),%eax
  80144a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801451:	8b 45 10             	mov    0x10(%ebp),%eax
  801454:	01 d0                	add    %edx,%eax
  801456:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80145c:	eb 0c                	jmp    80146a <strsplit+0x31>
			*string++ = 0;
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8d 50 01             	lea    0x1(%eax),%edx
  801464:	89 55 08             	mov    %edx,0x8(%ebp)
  801467:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	84 c0                	test   %al,%al
  801471:	74 18                	je     80148b <strsplit+0x52>
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	0f be c0             	movsbl %al,%eax
  80147b:	50                   	push   %eax
  80147c:	ff 75 0c             	pushl  0xc(%ebp)
  80147f:	e8 83 fa ff ff       	call   800f07 <strchr>
  801484:	83 c4 08             	add    $0x8,%esp
  801487:	85 c0                	test   %eax,%eax
  801489:	75 d3                	jne    80145e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	8a 00                	mov    (%eax),%al
  801490:	84 c0                	test   %al,%al
  801492:	74 5a                	je     8014ee <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801494:	8b 45 14             	mov    0x14(%ebp),%eax
  801497:	8b 00                	mov    (%eax),%eax
  801499:	83 f8 0f             	cmp    $0xf,%eax
  80149c:	75 07                	jne    8014a5 <strsplit+0x6c>
		{
			return 0;
  80149e:	b8 00 00 00 00       	mov    $0x0,%eax
  8014a3:	eb 66                	jmp    80150b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a8:	8b 00                	mov    (%eax),%eax
  8014aa:	8d 48 01             	lea    0x1(%eax),%ecx
  8014ad:	8b 55 14             	mov    0x14(%ebp),%edx
  8014b0:	89 0a                	mov    %ecx,(%edx)
  8014b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bc:	01 c2                	add    %eax,%edx
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c3:	eb 03                	jmp    8014c8 <strsplit+0x8f>
			string++;
  8014c5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	8a 00                	mov    (%eax),%al
  8014cd:	84 c0                	test   %al,%al
  8014cf:	74 8b                	je     80145c <strsplit+0x23>
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	8a 00                	mov    (%eax),%al
  8014d6:	0f be c0             	movsbl %al,%eax
  8014d9:	50                   	push   %eax
  8014da:	ff 75 0c             	pushl  0xc(%ebp)
  8014dd:	e8 25 fa ff ff       	call   800f07 <strchr>
  8014e2:	83 c4 08             	add    $0x8,%esp
  8014e5:	85 c0                	test   %eax,%eax
  8014e7:	74 dc                	je     8014c5 <strsplit+0x8c>
			string++;
	}
  8014e9:	e9 6e ff ff ff       	jmp    80145c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014ee:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f2:	8b 00                	mov    (%eax),%eax
  8014f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fe:	01 d0                	add    %edx,%eax
  801500:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801506:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801519:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801520:	eb 4a                	jmp    80156c <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801522:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801525:	8b 45 08             	mov    0x8(%ebp),%eax
  801528:	01 c2                	add    %eax,%edx
  80152a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80152d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801530:	01 c8                	add    %ecx,%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801536:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153c:	01 d0                	add    %edx,%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	3c 40                	cmp    $0x40,%al
  801542:	7e 25                	jle    801569 <str2lower+0x5c>
  801544:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801547:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154a:	01 d0                	add    %edx,%eax
  80154c:	8a 00                	mov    (%eax),%al
  80154e:	3c 5a                	cmp    $0x5a,%al
  801550:	7f 17                	jg     801569 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801552:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	01 d0                	add    %edx,%eax
  80155a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80155d:	8b 55 08             	mov    0x8(%ebp),%edx
  801560:	01 ca                	add    %ecx,%edx
  801562:	8a 12                	mov    (%edx),%dl
  801564:	83 c2 20             	add    $0x20,%edx
  801567:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801569:	ff 45 fc             	incl   -0x4(%ebp)
  80156c:	ff 75 0c             	pushl  0xc(%ebp)
  80156f:	e8 01 f8 ff ff       	call   800d75 <strlen>
  801574:	83 c4 04             	add    $0x4,%esp
  801577:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80157a:	7f a6                	jg     801522 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80157c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801587:	a1 08 30 80 00       	mov    0x803008,%eax
  80158c:	85 c0                	test   %eax,%eax
  80158e:	74 2d                	je     8015bd <uheap_init+0x3c>
	{
		buddy_init();
  801590:	e8 87 06 00 00       	call   801c1c <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801595:	e8 31 05 00 00       	call   801acb <sys_get_uheap_strategy>
  80159a:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  80159f:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8015a6:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8015a9:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8015b0:	00 00 80 
		__firstTimeFlag = 0;
  8015b3:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  8015ba:	00 00 00 
	}
}
  8015bd:	90                   	nop
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
  8015c3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  8015c6:	83 ec 04             	sub    $0x4,%esp
  8015c9:	68 a8 26 80 00       	push   $0x8026a8
  8015ce:	6a 25                	push   $0x25
  8015d0:	68 d9 26 80 00       	push   $0x8026d9
  8015d5:	e8 f4 ed ff ff       	call   8003ce <_panic>

008015da <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  8015e0:	83 ec 04             	sub    $0x4,%esp
  8015e3:	68 e8 26 80 00       	push   $0x8026e8
  8015e8:	6a 2f                	push   $0x2f
  8015ea:	68 d9 26 80 00       	push   $0x8026d9
  8015ef:	e8 da ed ff ff       	call   8003ce <_panic>

008015f4 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
  8015f7:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8015fa:	e8 82 ff ff ff       	call   801581 <uheap_init>
	if (size == 0) return NULL ;
  8015ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801603:	75 07                	jne    80160c <malloc+0x18>
  801605:	b8 00 00 00 00       	mov    $0x0,%eax
  80160a:	eb 14                	jmp    801620 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  80160c:	83 ec 04             	sub    $0x4,%esp
  80160f:	68 1c 27 80 00       	push   $0x80271c
  801614:	6a 43                	push   $0x43
  801616:	68 d9 26 80 00       	push   $0x8026d9
  80161b:	e8 ae ed ff ff       	call   8003ce <_panic>
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
  801625:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801628:	83 ec 04             	sub    $0x4,%esp
  80162b:	68 44 27 80 00       	push   $0x802744
  801630:	6a 4e                	push   $0x4e
  801632:	68 d9 26 80 00       	push   $0x8026d9
  801637:	e8 92 ed ff ff       	call   8003ce <_panic>

0080163c <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
  80163f:	83 ec 18             	sub    $0x18,%esp
  801642:	8b 45 10             	mov    0x10(%ebp),%eax
  801645:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801648:	e8 34 ff ff ff       	call   801581 <uheap_init>
	if (size == 0) return NULL ;
  80164d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801651:	75 07                	jne    80165a <smalloc+0x1e>
  801653:	b8 00 00 00 00       	mov    $0x0,%eax
  801658:	eb 14                	jmp    80166e <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  80165a:	83 ec 04             	sub    $0x4,%esp
  80165d:	68 68 27 80 00       	push   $0x802768
  801662:	6a 5f                	push   $0x5f
  801664:	68 d9 26 80 00       	push   $0x8026d9
  801669:	e8 60 ed ff ff       	call   8003ce <_panic>
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
  801673:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801676:	e8 06 ff ff ff       	call   801581 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  80167b:	83 ec 04             	sub    $0x4,%esp
  80167e:	68 90 27 80 00       	push   $0x802790
  801683:	6a 6f                	push   $0x6f
  801685:	68 d9 26 80 00       	push   $0x8026d9
  80168a:	e8 3f ed ff ff       	call   8003ce <_panic>

0080168f <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
  801692:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801695:	83 ec 04             	sub    $0x4,%esp
  801698:	68 b4 27 80 00       	push   $0x8027b4
  80169d:	6a 7e                	push   $0x7e
  80169f:	68 d9 26 80 00       	push   $0x8026d9
  8016a4:	e8 25 ed ff ff       	call   8003ce <_panic>

008016a9 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
  8016ac:	57                   	push   %edi
  8016ad:	56                   	push   %esi
  8016ae:	53                   	push   %ebx
  8016af:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016bb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016be:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016c1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016c4:	cd 30                	int    $0x30
  8016c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016cc:	83 c4 10             	add    $0x10,%esp
  8016cf:	5b                   	pop    %ebx
  8016d0:	5e                   	pop    %esi
  8016d1:	5f                   	pop    %edi
  8016d2:	5d                   	pop    %ebp
  8016d3:	c3                   	ret    

008016d4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
  8016d7:	83 ec 04             	sub    $0x4,%esp
  8016da:	8b 45 10             	mov    0x10(%ebp),%eax
  8016dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016e0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016e3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	6a 00                	push   $0x0
  8016ec:	51                   	push   %ecx
  8016ed:	52                   	push   %edx
  8016ee:	ff 75 0c             	pushl  0xc(%ebp)
  8016f1:	50                   	push   %eax
  8016f2:	6a 00                	push   $0x0
  8016f4:	e8 b0 ff ff ff       	call   8016a9 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
}
  8016fc:	90                   	nop
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_cgetc>:

int
sys_cgetc(void)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 02                	push   $0x2
  80170e:	e8 96 ff ff ff       	call   8016a9 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 03                	push   $0x3
  801727:	e8 7d ff ff ff       	call   8016a9 <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
}
  80172f:	90                   	nop
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 04                	push   $0x4
  801741:	e8 63 ff ff ff       	call   8016a9 <syscall>
  801746:	83 c4 18             	add    $0x18,%esp
}
  801749:	90                   	nop
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80174f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	52                   	push   %edx
  80175c:	50                   	push   %eax
  80175d:	6a 08                	push   $0x8
  80175f:	e8 45 ff ff ff       	call   8016a9 <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
}
  801767:	c9                   	leave  
  801768:	c3                   	ret    

00801769 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
  80176c:	56                   	push   %esi
  80176d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80176e:	8b 75 18             	mov    0x18(%ebp),%esi
  801771:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801774:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801777:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	56                   	push   %esi
  80177e:	53                   	push   %ebx
  80177f:	51                   	push   %ecx
  801780:	52                   	push   %edx
  801781:	50                   	push   %eax
  801782:	6a 09                	push   $0x9
  801784:	e8 20 ff ff ff       	call   8016a9 <syscall>
  801789:	83 c4 18             	add    $0x18,%esp
}
  80178c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80178f:	5b                   	pop    %ebx
  801790:	5e                   	pop    %esi
  801791:	5d                   	pop    %ebp
  801792:	c3                   	ret    

00801793 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	ff 75 08             	pushl  0x8(%ebp)
  8017a1:	6a 0a                	push   $0xa
  8017a3:	e8 01 ff ff ff       	call   8016a9 <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	ff 75 0c             	pushl  0xc(%ebp)
  8017b9:	ff 75 08             	pushl  0x8(%ebp)
  8017bc:	6a 0b                	push   $0xb
  8017be:	e8 e6 fe ff ff       	call   8016a9 <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 0c                	push   $0xc
  8017d7:	e8 cd fe ff ff       	call   8016a9 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 0d                	push   $0xd
  8017f0:	e8 b4 fe ff ff       	call   8016a9 <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
}
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 0e                	push   $0xe
  801809:	e8 9b fe ff ff       	call   8016a9 <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
}
  801811:	c9                   	leave  
  801812:	c3                   	ret    

00801813 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801813:	55                   	push   %ebp
  801814:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 0f                	push   $0xf
  801822:	e8 82 fe ff ff       	call   8016a9 <syscall>
  801827:	83 c4 18             	add    $0x18,%esp
}
  80182a:	c9                   	leave  
  80182b:	c3                   	ret    

0080182c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80182c:	55                   	push   %ebp
  80182d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	ff 75 08             	pushl  0x8(%ebp)
  80183a:	6a 10                	push   $0x10
  80183c:	e8 68 fe ff ff       	call   8016a9 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 11                	push   $0x11
  801855:	e8 4f fe ff ff       	call   8016a9 <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	90                   	nop
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <sys_cputc>:

void
sys_cputc(const char c)
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
  801863:	83 ec 04             	sub    $0x4,%esp
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
  801869:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80186c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	50                   	push   %eax
  801879:	6a 01                	push   $0x1
  80187b:	e8 29 fe ff ff       	call   8016a9 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	90                   	nop
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 14                	push   $0x14
  801895:	e8 0f fe ff ff       	call   8016a9 <syscall>
  80189a:	83 c4 18             	add    $0x18,%esp
}
  80189d:	90                   	nop
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
  8018a3:	83 ec 04             	sub    $0x4,%esp
  8018a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018ac:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018af:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	6a 00                	push   $0x0
  8018b8:	51                   	push   %ecx
  8018b9:	52                   	push   %edx
  8018ba:	ff 75 0c             	pushl  0xc(%ebp)
  8018bd:	50                   	push   %eax
  8018be:	6a 15                	push   $0x15
  8018c0:	e8 e4 fd ff ff       	call   8016a9 <syscall>
  8018c5:	83 c4 18             	add    $0x18,%esp
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018cd:	8b 55 10             	mov    0x10(%ebp),%edx
  8018d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	52                   	push   %edx
  8018d8:	50                   	push   %eax
  8018d9:	ff 75 08             	pushl  0x8(%ebp)
  8018dc:	6a 16                	push   $0x16
  8018de:	e8 c6 fd ff ff       	call   8016a9 <syscall>
  8018e3:	83 c4 18             	add    $0x18,%esp
}
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	52                   	push   %edx
  8018f8:	50                   	push   %eax
  8018f9:	6a 17                	push   $0x17
  8018fb:	e8 a9 fd ff ff       	call   8016a9 <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801908:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190b:	8b 45 08             	mov    0x8(%ebp),%eax
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	52                   	push   %edx
  801915:	50                   	push   %eax
  801916:	6a 18                	push   $0x18
  801918:	e8 8c fd ff ff       	call   8016a9 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	6a 00                	push   $0x0
  80192a:	ff 75 14             	pushl  0x14(%ebp)
  80192d:	ff 75 10             	pushl  0x10(%ebp)
  801930:	ff 75 0c             	pushl  0xc(%ebp)
  801933:	50                   	push   %eax
  801934:	6a 19                	push   $0x19
  801936:	e8 6e fd ff ff       	call   8016a9 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
}
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801943:	8b 45 08             	mov    0x8(%ebp),%eax
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	50                   	push   %eax
  80194f:	6a 1a                	push   $0x1a
  801951:	e8 53 fd ff ff       	call   8016a9 <syscall>
  801956:	83 c4 18             	add    $0x18,%esp
}
  801959:	90                   	nop
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	50                   	push   %eax
  80196b:	6a 1b                	push   $0x1b
  80196d:	e8 37 fd ff ff       	call   8016a9 <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	c9                   	leave  
  801976:	c3                   	ret    

00801977 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801977:	55                   	push   %ebp
  801978:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 05                	push   $0x5
  801986:	e8 1e fd ff ff       	call   8016a9 <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
}
  80198e:	c9                   	leave  
  80198f:	c3                   	ret    

00801990 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801990:	55                   	push   %ebp
  801991:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 06                	push   $0x6
  80199f:	e8 05 fd ff ff       	call   8016a9 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
}
  8019a7:	c9                   	leave  
  8019a8:	c3                   	ret    

008019a9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019a9:	55                   	push   %ebp
  8019aa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 07                	push   $0x7
  8019b8:	e8 ec fc ff ff       	call   8016a9 <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
}
  8019c0:	c9                   	leave  
  8019c1:	c3                   	ret    

008019c2 <sys_exit_env>:


void sys_exit_env(void)
{
  8019c2:	55                   	push   %ebp
  8019c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 1c                	push   $0x1c
  8019d1:	e8 d3 fc ff ff       	call   8016a9 <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	ff 75 10             	pushl  0x10(%ebp)
  8019e6:	ff 75 0c             	pushl  0xc(%ebp)
  8019e9:	ff 75 08             	pushl  0x8(%ebp)
  8019ec:	6a 13                	push   $0x13
  8019ee:	e8 b6 fc ff ff       	call   8016a9 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f6:	90                   	nop
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 1e                	push   $0x1e
  801a08:	e8 9c fc ff ff       	call   8016a9 <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
}
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
  801a15:	83 ec 04             	sub    $0x4,%esp
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a1e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	50                   	push   %eax
  801a2b:	6a 1f                	push   $0x1f
  801a2d:	e8 77 fc ff ff       	call   8016a9 <syscall>
  801a32:	83 c4 18             	add    $0x18,%esp
	return ;
  801a35:	90                   	nop
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <rsttst>:
void rsttst()
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 21                	push   $0x21
  801a47:	e8 5d fc ff ff       	call   8016a9 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4f:	90                   	nop
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 04             	sub    $0x4,%esp
  801a58:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a5e:	8b 55 18             	mov    0x18(%ebp),%edx
  801a61:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a65:	52                   	push   %edx
  801a66:	50                   	push   %eax
  801a67:	ff 75 10             	pushl  0x10(%ebp)
  801a6a:	ff 75 0c             	pushl  0xc(%ebp)
  801a6d:	ff 75 08             	pushl  0x8(%ebp)
  801a70:	6a 20                	push   $0x20
  801a72:	e8 32 fc ff ff       	call   8016a9 <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7a:	90                   	nop
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <chktst>:
void chktst(uint32 n)
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	ff 75 08             	pushl  0x8(%ebp)
  801a8b:	6a 22                	push   $0x22
  801a8d:	e8 17 fc ff ff       	call   8016a9 <syscall>
  801a92:	83 c4 18             	add    $0x18,%esp
	return ;
  801a95:	90                   	nop
}
  801a96:	c9                   	leave  
  801a97:	c3                   	ret    

00801a98 <inctst>:

void inctst()
{
  801a98:	55                   	push   %ebp
  801a99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 23                	push   $0x23
  801aa7:	e8 fd fb ff ff       	call   8016a9 <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
	return ;
  801aaf:	90                   	nop
}
  801ab0:	c9                   	leave  
  801ab1:	c3                   	ret    

00801ab2 <gettst>:
uint32 gettst()
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 24                	push   $0x24
  801ac1:	e8 e3 fb ff ff       	call   8016a9 <syscall>
  801ac6:	83 c4 18             	add    $0x18,%esp
}
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 25                	push   $0x25
  801ada:	e8 ca fb ff ff       	call   8016a9 <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
  801ae2:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801ae7:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801af1:	8b 45 08             	mov    0x8(%ebp),%eax
  801af4:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	ff 75 08             	pushl  0x8(%ebp)
  801b04:	6a 26                	push   $0x26
  801b06:	e8 9e fb ff ff       	call   8016a9 <syscall>
  801b0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b0e:	90                   	nop
}
  801b0f:	c9                   	leave  
  801b10:	c3                   	ret    

00801b11 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b11:	55                   	push   %ebp
  801b12:	89 e5                	mov    %esp,%ebp
  801b14:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b15:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b21:	6a 00                	push   $0x0
  801b23:	53                   	push   %ebx
  801b24:	51                   	push   %ecx
  801b25:	52                   	push   %edx
  801b26:	50                   	push   %eax
  801b27:	6a 27                	push   $0x27
  801b29:	e8 7b fb ff ff       	call   8016a9 <syscall>
  801b2e:	83 c4 18             	add    $0x18,%esp
}
  801b31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b34:	c9                   	leave  
  801b35:	c3                   	ret    

00801b36 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b36:	55                   	push   %ebp
  801b37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	52                   	push   %edx
  801b46:	50                   	push   %eax
  801b47:	6a 28                	push   $0x28
  801b49:	e8 5b fb ff ff       	call   8016a9 <syscall>
  801b4e:	83 c4 18             	add    $0x18,%esp
}
  801b51:	c9                   	leave  
  801b52:	c3                   	ret    

00801b53 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b56:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b59:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5f:	6a 00                	push   $0x0
  801b61:	51                   	push   %ecx
  801b62:	ff 75 10             	pushl  0x10(%ebp)
  801b65:	52                   	push   %edx
  801b66:	50                   	push   %eax
  801b67:	6a 29                	push   $0x29
  801b69:	e8 3b fb ff ff       	call   8016a9 <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
}
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	ff 75 10             	pushl  0x10(%ebp)
  801b7d:	ff 75 0c             	pushl  0xc(%ebp)
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	6a 12                	push   $0x12
  801b85:	e8 1f fb ff ff       	call   8016a9 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8d:	90                   	nop
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	52                   	push   %edx
  801ba0:	50                   	push   %eax
  801ba1:	6a 2a                	push   $0x2a
  801ba3:	e8 01 fb ff ff       	call   8016a9 <syscall>
  801ba8:	83 c4 18             	add    $0x18,%esp
	return;
  801bab:	90                   	nop
}
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 2b                	push   $0x2b
  801bbd:	e8 e7 fa ff ff       	call   8016a9 <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
  801bca:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bcd:	83 ec 04             	sub    $0x4,%esp
  801bd0:	68 d8 27 80 00       	push   $0x8027d8
  801bd5:	68 0a 01 00 00       	push   $0x10a
  801bda:	68 e8 27 80 00       	push   $0x8027e8
  801bdf:	e8 ea e7 ff ff       	call   8003ce <_panic>

00801be4 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	ff 75 0c             	pushl  0xc(%ebp)
  801bf0:	ff 75 08             	pushl  0x8(%ebp)
  801bf3:	6a 33                	push   $0x33
  801bf5:	e8 af fa ff ff       	call   8016a9 <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
	return;
  801bfd:	90                   	nop
}
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	ff 75 0c             	pushl  0xc(%ebp)
  801c0c:	ff 75 08             	pushl  0x8(%ebp)
  801c0f:	6a 34                	push   $0x34
  801c11:	e8 93 fa ff ff       	call   8016a9 <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
	return ;
  801c19:	90                   	nop
}
  801c1a:	c9                   	leave  
  801c1b:	c3                   	ret    

00801c1c <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801c1c:	55                   	push   %ebp
  801c1d:	89 e5                	mov    %esp,%ebp
  801c1f:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c22:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801c29:	eb 36                	jmp    801c61 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801c2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c2e:	c1 e0 04             	shl    $0x4,%eax
  801c31:	05 60 30 80 00       	add    $0x803060,%eax
  801c36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c3f:	c1 e0 04             	shl    $0x4,%eax
  801c42:	05 64 30 80 00       	add    $0x803064,%eax
  801c47:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c50:	c1 e0 04             	shl    $0x4,%eax
  801c53:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c5e:	ff 45 fc             	incl   -0x4(%ebp)
  801c61:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801c65:	7e c4                	jle    801c2b <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801c67:	90                   	nop
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
  801c6d:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c70:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801c77:	eb 24                	jmp    801c9d <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801c79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c7c:	c1 e0 04             	shl    $0x4,%eax
  801c7f:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c84:	8b 00                	mov    (%eax),%eax
  801c86:	83 ec 04             	sub    $0x4,%esp
  801c89:	50                   	push   %eax
  801c8a:	ff 75 f4             	pushl  -0xc(%ebp)
  801c8d:	68 f8 27 80 00       	push   $0x8027f8
  801c92:	e8 05 ea ff ff       	call   80069c <cprintf>
  801c97:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c9a:	ff 45 f4             	incl   -0xc(%ebp)
  801c9d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801ca1:	7e d6                	jle    801c79 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801ca3:	90                   	nop
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801cac:	83 ec 04             	sub    $0x4,%esp
  801caf:	68 08 28 80 00       	push   $0x802808
  801cb4:	6a 33                	push   $0x33
  801cb6:	68 29 28 80 00       	push   $0x802829
  801cbb:	e8 0e e7 ff ff       	call   8003ce <_panic>

00801cc0 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
  801cc3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801cc6:	83 ec 04             	sub    $0x4,%esp
  801cc9:	68 41 28 80 00       	push   $0x802841
  801cce:	6a 3e                	push   $0x3e
  801cd0:	68 29 28 80 00       	push   $0x802829
  801cd5:	e8 f4 e6 ff ff       	call   8003ce <_panic>

00801cda <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
  801cdd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801ce0:	83 ec 04             	sub    $0x4,%esp
  801ce3:	68 5f 28 80 00       	push   $0x80285f
  801ce8:	6a 49                	push   $0x49
  801cea:	68 29 28 80 00       	push   $0x802829
  801cef:	e8 da e6 ff ff       	call   8003ce <_panic>

00801cf4 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
  801cf7:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801cfa:	83 ec 04             	sub    $0x4,%esp
  801cfd:	68 7c 28 80 00       	push   $0x80287c
  801d02:	6a 58                	push   $0x58
  801d04:	68 29 28 80 00       	push   $0x802829
  801d09:	e8 c0 e6 ff ff       	call   8003ce <_panic>
  801d0e:	66 90                	xchg   %ax,%ax

00801d10 <__udivdi3>:
  801d10:	55                   	push   %ebp
  801d11:	57                   	push   %edi
  801d12:	56                   	push   %esi
  801d13:	53                   	push   %ebx
  801d14:	83 ec 1c             	sub    $0x1c,%esp
  801d17:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d1b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d23:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d27:	89 ca                	mov    %ecx,%edx
  801d29:	89 f8                	mov    %edi,%eax
  801d2b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2f:	85 f6                	test   %esi,%esi
  801d31:	75 2d                	jne    801d60 <__udivdi3+0x50>
  801d33:	39 cf                	cmp    %ecx,%edi
  801d35:	77 65                	ja     801d9c <__udivdi3+0x8c>
  801d37:	89 fd                	mov    %edi,%ebp
  801d39:	85 ff                	test   %edi,%edi
  801d3b:	75 0b                	jne    801d48 <__udivdi3+0x38>
  801d3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d42:	31 d2                	xor    %edx,%edx
  801d44:	f7 f7                	div    %edi
  801d46:	89 c5                	mov    %eax,%ebp
  801d48:	31 d2                	xor    %edx,%edx
  801d4a:	89 c8                	mov    %ecx,%eax
  801d4c:	f7 f5                	div    %ebp
  801d4e:	89 c1                	mov    %eax,%ecx
  801d50:	89 d8                	mov    %ebx,%eax
  801d52:	f7 f5                	div    %ebp
  801d54:	89 cf                	mov    %ecx,%edi
  801d56:	89 fa                	mov    %edi,%edx
  801d58:	83 c4 1c             	add    $0x1c,%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5f                   	pop    %edi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    
  801d60:	39 ce                	cmp    %ecx,%esi
  801d62:	77 28                	ja     801d8c <__udivdi3+0x7c>
  801d64:	0f bd fe             	bsr    %esi,%edi
  801d67:	83 f7 1f             	xor    $0x1f,%edi
  801d6a:	75 40                	jne    801dac <__udivdi3+0x9c>
  801d6c:	39 ce                	cmp    %ecx,%esi
  801d6e:	72 0a                	jb     801d7a <__udivdi3+0x6a>
  801d70:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d74:	0f 87 9e 00 00 00    	ja     801e18 <__udivdi3+0x108>
  801d7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7f:	89 fa                	mov    %edi,%edx
  801d81:	83 c4 1c             	add    $0x1c,%esp
  801d84:	5b                   	pop    %ebx
  801d85:	5e                   	pop    %esi
  801d86:	5f                   	pop    %edi
  801d87:	5d                   	pop    %ebp
  801d88:	c3                   	ret    
  801d89:	8d 76 00             	lea    0x0(%esi),%esi
  801d8c:	31 ff                	xor    %edi,%edi
  801d8e:	31 c0                	xor    %eax,%eax
  801d90:	89 fa                	mov    %edi,%edx
  801d92:	83 c4 1c             	add    $0x1c,%esp
  801d95:	5b                   	pop    %ebx
  801d96:	5e                   	pop    %esi
  801d97:	5f                   	pop    %edi
  801d98:	5d                   	pop    %ebp
  801d99:	c3                   	ret    
  801d9a:	66 90                	xchg   %ax,%ax
  801d9c:	89 d8                	mov    %ebx,%eax
  801d9e:	f7 f7                	div    %edi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	89 fa                	mov    %edi,%edx
  801da4:	83 c4 1c             	add    $0x1c,%esp
  801da7:	5b                   	pop    %ebx
  801da8:	5e                   	pop    %esi
  801da9:	5f                   	pop    %edi
  801daa:	5d                   	pop    %ebp
  801dab:	c3                   	ret    
  801dac:	bd 20 00 00 00       	mov    $0x20,%ebp
  801db1:	89 eb                	mov    %ebp,%ebx
  801db3:	29 fb                	sub    %edi,%ebx
  801db5:	89 f9                	mov    %edi,%ecx
  801db7:	d3 e6                	shl    %cl,%esi
  801db9:	89 c5                	mov    %eax,%ebp
  801dbb:	88 d9                	mov    %bl,%cl
  801dbd:	d3 ed                	shr    %cl,%ebp
  801dbf:	89 e9                	mov    %ebp,%ecx
  801dc1:	09 f1                	or     %esi,%ecx
  801dc3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc7:	89 f9                	mov    %edi,%ecx
  801dc9:	d3 e0                	shl    %cl,%eax
  801dcb:	89 c5                	mov    %eax,%ebp
  801dcd:	89 d6                	mov    %edx,%esi
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ee                	shr    %cl,%esi
  801dd3:	89 f9                	mov    %edi,%ecx
  801dd5:	d3 e2                	shl    %cl,%edx
  801dd7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ddb:	88 d9                	mov    %bl,%cl
  801ddd:	d3 e8                	shr    %cl,%eax
  801ddf:	09 c2                	or     %eax,%edx
  801de1:	89 d0                	mov    %edx,%eax
  801de3:	89 f2                	mov    %esi,%edx
  801de5:	f7 74 24 0c          	divl   0xc(%esp)
  801de9:	89 d6                	mov    %edx,%esi
  801deb:	89 c3                	mov    %eax,%ebx
  801ded:	f7 e5                	mul    %ebp
  801def:	39 d6                	cmp    %edx,%esi
  801df1:	72 19                	jb     801e0c <__udivdi3+0xfc>
  801df3:	74 0b                	je     801e00 <__udivdi3+0xf0>
  801df5:	89 d8                	mov    %ebx,%eax
  801df7:	31 ff                	xor    %edi,%edi
  801df9:	e9 58 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801dfe:	66 90                	xchg   %ax,%ax
  801e00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e04:	89 f9                	mov    %edi,%ecx
  801e06:	d3 e2                	shl    %cl,%edx
  801e08:	39 c2                	cmp    %eax,%edx
  801e0a:	73 e9                	jae    801df5 <__udivdi3+0xe5>
  801e0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0f:	31 ff                	xor    %edi,%edi
  801e11:	e9 40 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e16:	66 90                	xchg   %ax,%ax
  801e18:	31 c0                	xor    %eax,%eax
  801e1a:	e9 37 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e1f:	90                   	nop

00801e20 <__umoddi3>:
  801e20:	55                   	push   %ebp
  801e21:	57                   	push   %edi
  801e22:	56                   	push   %esi
  801e23:	53                   	push   %ebx
  801e24:	83 ec 1c             	sub    $0x1c,%esp
  801e27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3f:	89 f3                	mov    %esi,%ebx
  801e41:	89 fa                	mov    %edi,%edx
  801e43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e47:	89 34 24             	mov    %esi,(%esp)
  801e4a:	85 c0                	test   %eax,%eax
  801e4c:	75 1a                	jne    801e68 <__umoddi3+0x48>
  801e4e:	39 f7                	cmp    %esi,%edi
  801e50:	0f 86 a2 00 00 00    	jbe    801ef8 <__umoddi3+0xd8>
  801e56:	89 c8                	mov    %ecx,%eax
  801e58:	89 f2                	mov    %esi,%edx
  801e5a:	f7 f7                	div    %edi
  801e5c:	89 d0                	mov    %edx,%eax
  801e5e:	31 d2                	xor    %edx,%edx
  801e60:	83 c4 1c             	add    $0x1c,%esp
  801e63:	5b                   	pop    %ebx
  801e64:	5e                   	pop    %esi
  801e65:	5f                   	pop    %edi
  801e66:	5d                   	pop    %ebp
  801e67:	c3                   	ret    
  801e68:	39 f0                	cmp    %esi,%eax
  801e6a:	0f 87 ac 00 00 00    	ja     801f1c <__umoddi3+0xfc>
  801e70:	0f bd e8             	bsr    %eax,%ebp
  801e73:	83 f5 1f             	xor    $0x1f,%ebp
  801e76:	0f 84 ac 00 00 00    	je     801f28 <__umoddi3+0x108>
  801e7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e81:	29 ef                	sub    %ebp,%edi
  801e83:	89 fe                	mov    %edi,%esi
  801e85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e89:	89 e9                	mov    %ebp,%ecx
  801e8b:	d3 e0                	shl    %cl,%eax
  801e8d:	89 d7                	mov    %edx,%edi
  801e8f:	89 f1                	mov    %esi,%ecx
  801e91:	d3 ef                	shr    %cl,%edi
  801e93:	09 c7                	or     %eax,%edi
  801e95:	89 e9                	mov    %ebp,%ecx
  801e97:	d3 e2                	shl    %cl,%edx
  801e99:	89 14 24             	mov    %edx,(%esp)
  801e9c:	89 d8                	mov    %ebx,%eax
  801e9e:	d3 e0                	shl    %cl,%eax
  801ea0:	89 c2                	mov    %eax,%edx
  801ea2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea6:	d3 e0                	shl    %cl,%eax
  801ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801eac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb0:	89 f1                	mov    %esi,%ecx
  801eb2:	d3 e8                	shr    %cl,%eax
  801eb4:	09 d0                	or     %edx,%eax
  801eb6:	d3 eb                	shr    %cl,%ebx
  801eb8:	89 da                	mov    %ebx,%edx
  801eba:	f7 f7                	div    %edi
  801ebc:	89 d3                	mov    %edx,%ebx
  801ebe:	f7 24 24             	mull   (%esp)
  801ec1:	89 c6                	mov    %eax,%esi
  801ec3:	89 d1                	mov    %edx,%ecx
  801ec5:	39 d3                	cmp    %edx,%ebx
  801ec7:	0f 82 87 00 00 00    	jb     801f54 <__umoddi3+0x134>
  801ecd:	0f 84 91 00 00 00    	je     801f64 <__umoddi3+0x144>
  801ed3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed7:	29 f2                	sub    %esi,%edx
  801ed9:	19 cb                	sbb    %ecx,%ebx
  801edb:	89 d8                	mov    %ebx,%eax
  801edd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ee1:	d3 e0                	shl    %cl,%eax
  801ee3:	89 e9                	mov    %ebp,%ecx
  801ee5:	d3 ea                	shr    %cl,%edx
  801ee7:	09 d0                	or     %edx,%eax
  801ee9:	89 e9                	mov    %ebp,%ecx
  801eeb:	d3 eb                	shr    %cl,%ebx
  801eed:	89 da                	mov    %ebx,%edx
  801eef:	83 c4 1c             	add    $0x1c,%esp
  801ef2:	5b                   	pop    %ebx
  801ef3:	5e                   	pop    %esi
  801ef4:	5f                   	pop    %edi
  801ef5:	5d                   	pop    %ebp
  801ef6:	c3                   	ret    
  801ef7:	90                   	nop
  801ef8:	89 fd                	mov    %edi,%ebp
  801efa:	85 ff                	test   %edi,%edi
  801efc:	75 0b                	jne    801f09 <__umoddi3+0xe9>
  801efe:	b8 01 00 00 00       	mov    $0x1,%eax
  801f03:	31 d2                	xor    %edx,%edx
  801f05:	f7 f7                	div    %edi
  801f07:	89 c5                	mov    %eax,%ebp
  801f09:	89 f0                	mov    %esi,%eax
  801f0b:	31 d2                	xor    %edx,%edx
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 c8                	mov    %ecx,%eax
  801f11:	f7 f5                	div    %ebp
  801f13:	89 d0                	mov    %edx,%eax
  801f15:	e9 44 ff ff ff       	jmp    801e5e <__umoddi3+0x3e>
  801f1a:	66 90                	xchg   %ax,%ax
  801f1c:	89 c8                	mov    %ecx,%eax
  801f1e:	89 f2                	mov    %esi,%edx
  801f20:	83 c4 1c             	add    $0x1c,%esp
  801f23:	5b                   	pop    %ebx
  801f24:	5e                   	pop    %esi
  801f25:	5f                   	pop    %edi
  801f26:	5d                   	pop    %ebp
  801f27:	c3                   	ret    
  801f28:	3b 04 24             	cmp    (%esp),%eax
  801f2b:	72 06                	jb     801f33 <__umoddi3+0x113>
  801f2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f31:	77 0f                	ja     801f42 <__umoddi3+0x122>
  801f33:	89 f2                	mov    %esi,%edx
  801f35:	29 f9                	sub    %edi,%ecx
  801f37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f3b:	89 14 24             	mov    %edx,(%esp)
  801f3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f46:	8b 14 24             	mov    (%esp),%edx
  801f49:	83 c4 1c             	add    $0x1c,%esp
  801f4c:	5b                   	pop    %ebx
  801f4d:	5e                   	pop    %esi
  801f4e:	5f                   	pop    %edi
  801f4f:	5d                   	pop    %ebp
  801f50:	c3                   	ret    
  801f51:	8d 76 00             	lea    0x0(%esi),%esi
  801f54:	2b 04 24             	sub    (%esp),%eax
  801f57:	19 fa                	sbb    %edi,%edx
  801f59:	89 d1                	mov    %edx,%ecx
  801f5b:	89 c6                	mov    %eax,%esi
  801f5d:	e9 71 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>
  801f62:	66 90                	xchg   %ax,%ax
  801f64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f68:	72 ea                	jb     801f54 <__umoddi3+0x134>
  801f6a:	89 d9                	mov    %ebx,%ecx
  801f6c:	e9 62 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>
