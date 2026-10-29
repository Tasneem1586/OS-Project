
obj/user/fib_loop:     file format elf32-i386


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
  800031:	e8 41 01 00 00       	call   800177 <libmain>
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
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 e0 21 80 00       	push   $0x8021e0
  800057:	e8 33 0c 00 00       	call   800c8f <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	index = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 35 11 00 00       	call   8011a7 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int64 *memo = malloc((index+1) * sizeof(int64));
  800078:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007b:	40                   	inc    %eax
  80007c:	c1 e0 03             	shl    $0x3,%eax
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	50                   	push   %eax
  800083:	e8 8f 15 00 00       	call   801617 <malloc>
  800088:	83 c4 10             	add    $0x10,%esp
  80008b:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int64 res = fibonacci(index, memo) ;
  80008e:	83 ec 08             	sub    $0x8,%esp
  800091:	ff 75 f0             	pushl  -0x10(%ebp)
  800094:	ff 75 f4             	pushl  -0xc(%ebp)
  800097:	e8 35 00 00 00       	call   8000d1 <fibonacci>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000a2:	89 55 ec             	mov    %edx,-0x14(%ebp)

	free(memo);
  8000a5:	83 ec 0c             	sub    $0xc,%esp
  8000a8:	ff 75 f0             	pushl  -0x10(%ebp)
  8000ab:	e8 95 15 00 00       	call   801645 <free>
  8000b0:	83 c4 10             	add    $0x10,%esp

	atomic_cprintf("Fibonacci #%d = %lld\n",index, res);
  8000b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8000b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8000b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8000bc:	68 fe 21 80 00       	push   $0x8021fe
  8000c1:	e8 63 04 00 00       	call   800529 <atomic_cprintf>
  8000c6:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
		inctst();
  8000c9:	e8 ed 19 00 00       	call   801abb <inctst>
	return;
  8000ce:	90                   	nop
}
  8000cf:	c9                   	leave  
  8000d0:	c3                   	ret    

008000d1 <fibonacci>:


int64 fibonacci(int n, int64 *memo)
{
  8000d1:	55                   	push   %ebp
  8000d2:	89 e5                	mov    %esp,%ebp
  8000d4:	56                   	push   %esi
  8000d5:	53                   	push   %ebx
  8000d6:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i <= n; ++i)
  8000d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000e0:	eb 72                	jmp    800154 <fibonacci+0x83>
	{
		if (i <= 1)
  8000e2:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8000e6:	7f 1e                	jg     800106 <fibonacci+0x35>
			memo[i] = 1;
  8000e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f5:	01 d0                	add    %edx,%eax
  8000f7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  8000fd:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  800104:	eb 4b                	jmp    800151 <fibonacci+0x80>
		else
			memo[i] = memo[i-1] + memo[i-2] ;
  800106:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800109:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800110:	8b 45 0c             	mov    0xc(%ebp),%eax
  800113:	8d 34 02             	lea    (%edx,%eax,1),%esi
  800116:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800119:	05 ff ff ff 1f       	add    $0x1fffffff,%eax
  80011e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800125:	8b 45 0c             	mov    0xc(%ebp),%eax
  800128:	01 d0                	add    %edx,%eax
  80012a:	8b 08                	mov    (%eax),%ecx
  80012c:	8b 58 04             	mov    0x4(%eax),%ebx
  80012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800132:	05 fe ff ff 1f       	add    $0x1ffffffe,%eax
  800137:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80013e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800141:	01 d0                	add    %edx,%eax
  800143:	8b 50 04             	mov    0x4(%eax),%edx
  800146:	8b 00                	mov    (%eax),%eax
  800148:	01 c8                	add    %ecx,%eax
  80014a:	11 da                	adc    %ebx,%edx
  80014c:	89 06                	mov    %eax,(%esi)
  80014e:	89 56 04             	mov    %edx,0x4(%esi)
}


int64 fibonacci(int n, int64 *memo)
{
	for (int i = 0; i <= n; ++i)
  800151:	ff 45 f4             	incl   -0xc(%ebp)
  800154:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800157:	3b 45 08             	cmp    0x8(%ebp),%eax
  80015a:	7e 86                	jle    8000e2 <fibonacci+0x11>
		if (i <= 1)
			memo[i] = 1;
		else
			memo[i] = memo[i-1] + memo[i-2] ;
	}
	return memo[n];
  80015c:	8b 45 08             	mov    0x8(%ebp),%eax
  80015f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800166:	8b 45 0c             	mov    0xc(%ebp),%eax
  800169:	01 d0                	add    %edx,%eax
  80016b:	8b 50 04             	mov    0x4(%eax),%edx
  80016e:	8b 00                	mov    (%eax),%eax
}
  800170:	83 c4 10             	add    $0x10,%esp
  800173:	5b                   	pop    %ebx
  800174:	5e                   	pop    %esi
  800175:	5d                   	pop    %ebp
  800176:	c3                   	ret    

00800177 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800177:	55                   	push   %ebp
  800178:	89 e5                	mov    %esp,%ebp
  80017a:	57                   	push   %edi
  80017b:	56                   	push   %esi
  80017c:	53                   	push   %ebx
  80017d:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800183:	e8 2b 18 00 00       	call   8019b3 <sys_getenvindex>
  800188:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80018b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80018e:	89 d0                	mov    %edx,%eax
  800190:	c1 e0 03             	shl    $0x3,%eax
  800193:	01 d0                	add    %edx,%eax
  800195:	c1 e0 06             	shl    $0x6,%eax
  800198:	01 d0                	add    %edx,%eax
  80019a:	c1 e0 03             	shl    $0x3,%eax
  80019d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001a2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ac:	8a 40 10             	mov    0x10(%eax),%al
  8001af:	84 c0                	test   %al,%al
  8001b1:	74 0d                	je     8001c0 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b8:	83 c0 10             	add    $0x10,%eax
  8001bb:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001c4:	7e 0a                	jle    8001d0 <libmain+0x59>
		binaryname = argv[0];
  8001c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8001d0:	83 ec 08             	sub    $0x8,%esp
  8001d3:	ff 75 0c             	pushl  0xc(%ebp)
  8001d6:	ff 75 08             	pushl  0x8(%ebp)
  8001d9:	e8 5a fe ff ff       	call   800038 <_main>
  8001de:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8001e1:	a1 00 30 80 00       	mov    0x803000,%eax
  8001e6:	85 c0                	test   %eax,%eax
  8001e8:	0f 84 b7 01 00 00    	je     8003a5 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001ee:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001f4:	bb 50 23 80 00       	mov    $0x802350,%ebx
  8001f9:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001fe:	89 c7                	mov    %eax,%edi
  800200:	89 de                	mov    %ebx,%esi
  800202:	89 d1                	mov    %edx,%ecx
  800204:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800206:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80020c:	b9 56 00 00 00       	mov    $0x56,%ecx
  800211:	b0 00                	mov    $0x0,%al
  800213:	89 d7                	mov    %edx,%edi
  800215:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800217:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80021e:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800221:	83 ec 08             	sub    $0x8,%esp
  800224:	50                   	push   %eax
  800225:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80022b:	50                   	push   %eax
  80022c:	e8 82 19 00 00       	call   801bb3 <sys_utilities>
  800231:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800234:	e8 02 15 00 00       	call   80173b <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800239:	83 ec 0c             	sub    $0xc,%esp
  80023c:	68 2c 22 80 00       	push   $0x80222c
  800241:	e8 71 02 00 00       	call   8004b7 <cprintf>
  800246:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800249:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80024c:	85 c0                	test   %eax,%eax
  80024e:	74 58                	je     8002a8 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800250:	e8 7c 19 00 00       	call   801bd1 <sys_get_optimal_num_faults>
  800255:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800258:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80025e:	bb b4 23 80 00       	mov    $0x8023b4,%ebx
  800263:	ba 11 00 00 00       	mov    $0x11,%edx
  800268:	89 c7                	mov    %eax,%edi
  80026a:	89 de                	mov    %ebx,%esi
  80026c:	89 d1                	mov    %edx,%ecx
  80026e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800270:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800273:	b9 53 00 00 00       	mov    $0x53,%ecx
  800278:	b0 00                	mov    $0x0,%al
  80027a:	89 d7                	mov    %edx,%edi
  80027c:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	ff 75 dc             	pushl  -0x24(%ebp)
  800284:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80028a:	50                   	push   %eax
  80028b:	e8 23 19 00 00       	call   801bb3 <sys_utilities>
  800290:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800293:	83 ec 08             	sub    $0x8,%esp
  800296:	ff 75 dc             	pushl  -0x24(%ebp)
  800299:	68 54 22 80 00       	push   $0x802254
  80029e:	e8 14 02 00 00       	call   8004b7 <cprintf>
  8002a3:	83 c4 10             	add    $0x10,%esp
  8002a6:	eb 59                	jmp    800301 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ad:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b8:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002be:	83 ec 04             	sub    $0x4,%esp
  8002c1:	52                   	push   %edx
  8002c2:	50                   	push   %eax
  8002c3:	68 78 22 80 00       	push   $0x802278
  8002c8:	e8 ea 01 00 00       	call   8004b7 <cprintf>
  8002cd:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8002d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d5:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8002db:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e0:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002eb:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002f1:	51                   	push   %ecx
  8002f2:	52                   	push   %edx
  8002f3:	50                   	push   %eax
  8002f4:	68 a0 22 80 00       	push   $0x8022a0
  8002f9:	e8 b9 01 00 00       	call   8004b7 <cprintf>
  8002fe:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800301:	a1 20 30 80 00       	mov    0x803020,%eax
  800306:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80030c:	83 ec 08             	sub    $0x8,%esp
  80030f:	50                   	push   %eax
  800310:	68 f8 22 80 00       	push   $0x8022f8
  800315:	e8 9d 01 00 00       	call   8004b7 <cprintf>
  80031a:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	68 0c 23 80 00       	push   $0x80230c
  800325:	e8 8d 01 00 00       	call   8004b7 <cprintf>
  80032a:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80032d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800334:	eb 28                	jmp    80035e <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800336:	a1 20 30 80 00       	mov    0x803020,%eax
  80033b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80033e:	81 c2 74 04 00 00    	add    $0x474,%edx
  800344:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800347:	83 ec 04             	sub    $0x4,%esp
  80034a:	50                   	push   %eax
  80034b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80034e:	68 23 23 80 00       	push   $0x802323
  800353:	e8 5f 01 00 00       	call   8004b7 <cprintf>
  800358:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80035b:	ff 45 e4             	incl   -0x1c(%ebp)
  80035e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800362:	7e d2                	jle    800336 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800364:	83 ec 0c             	sub    $0xc,%esp
  800367:	68 32 23 80 00       	push   $0x802332
  80036c:	e8 46 01 00 00       	call   8004b7 <cprintf>
  800371:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800374:	a1 20 30 80 00       	mov    0x803020,%eax
  800379:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80037f:	83 ec 08             	sub    $0x8,%esp
  800382:	50                   	push   %eax
  800383:	68 36 23 80 00       	push   $0x802336
  800388:	e8 2a 01 00 00       	call   8004b7 <cprintf>
  80038d:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800390:	83 ec 0c             	sub    $0xc,%esp
  800393:	68 2c 22 80 00       	push   $0x80222c
  800398:	e8 1a 01 00 00       	call   8004b7 <cprintf>
  80039d:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8003a0:	e8 b0 13 00 00       	call   801755 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8003a5:	e8 1f 00 00 00       	call   8003c9 <exit>
}
  8003aa:	90                   	nop
  8003ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003ae:	5b                   	pop    %ebx
  8003af:	5e                   	pop    %esi
  8003b0:	5f                   	pop    %edi
  8003b1:	5d                   	pop    %ebp
  8003b2:	c3                   	ret    

008003b3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003b3:	55                   	push   %ebp
  8003b4:	89 e5                	mov    %esp,%ebp
  8003b6:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003b9:	83 ec 0c             	sub    $0xc,%esp
  8003bc:	6a 00                	push   $0x0
  8003be:	e8 bc 15 00 00       	call   80197f <sys_destroy_env>
  8003c3:	83 c4 10             	add    $0x10,%esp
}
  8003c6:	90                   	nop
  8003c7:	c9                   	leave  
  8003c8:	c3                   	ret    

008003c9 <exit>:

void
exit(void)
{
  8003c9:	55                   	push   %ebp
  8003ca:	89 e5                	mov    %esp,%ebp
  8003cc:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8003cf:	e8 11 16 00 00       	call   8019e5 <sys_exit_env>
}
  8003d4:	90                   	nop
  8003d5:	c9                   	leave  
  8003d6:	c3                   	ret    

008003d7 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8003d7:	55                   	push   %ebp
  8003d8:	89 e5                	mov    %esp,%ebp
  8003da:	53                   	push   %ebx
  8003db:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8003de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	8d 48 01             	lea    0x1(%eax),%ecx
  8003e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003e9:	89 0a                	mov    %ecx,(%edx)
  8003eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8003ee:	88 d1                	mov    %dl,%cl
  8003f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003f3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	3d ff 00 00 00       	cmp    $0xff,%eax
  800401:	75 30                	jne    800433 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800403:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800409:	a0 40 30 80 00       	mov    0x803040,%al
  80040e:	0f b6 c0             	movzbl %al,%eax
  800411:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800414:	8b 09                	mov    (%ecx),%ecx
  800416:	89 cb                	mov    %ecx,%ebx
  800418:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80041b:	83 c1 08             	add    $0x8,%ecx
  80041e:	52                   	push   %edx
  80041f:	50                   	push   %eax
  800420:	53                   	push   %ebx
  800421:	51                   	push   %ecx
  800422:	e8 d0 12 00 00       	call   8016f7 <sys_cputs>
  800427:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80042a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800433:	8b 45 0c             	mov    0xc(%ebp),%eax
  800436:	8b 40 04             	mov    0x4(%eax),%eax
  800439:	8d 50 01             	lea    0x1(%eax),%edx
  80043c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800442:	90                   	nop
  800443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800446:	c9                   	leave  
  800447:	c3                   	ret    

00800448 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800448:	55                   	push   %ebp
  800449:	89 e5                	mov    %esp,%ebp
  80044b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800451:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800458:	00 00 00 
	b.cnt = 0;
  80045b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800462:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800465:	ff 75 0c             	pushl  0xc(%ebp)
  800468:	ff 75 08             	pushl  0x8(%ebp)
  80046b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800471:	50                   	push   %eax
  800472:	68 d7 03 80 00       	push   $0x8003d7
  800477:	e8 5a 02 00 00       	call   8006d6 <vprintfmt>
  80047c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80047f:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800485:	a0 40 30 80 00       	mov    0x803040,%al
  80048a:	0f b6 c0             	movzbl %al,%eax
  80048d:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800493:	52                   	push   %edx
  800494:	50                   	push   %eax
  800495:	51                   	push   %ecx
  800496:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80049c:	83 c0 08             	add    $0x8,%eax
  80049f:	50                   	push   %eax
  8004a0:	e8 52 12 00 00       	call   8016f7 <sys_cputs>
  8004a5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004a8:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8004af:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004b5:	c9                   	leave  
  8004b6:	c3                   	ret    

008004b7 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8004b7:	55                   	push   %ebp
  8004b8:	89 e5                	mov    %esp,%ebp
  8004ba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004bd:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8004c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cd:	83 ec 08             	sub    $0x8,%esp
  8004d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8004d3:	50                   	push   %eax
  8004d4:	e8 6f ff ff ff       	call   800448 <vcprintf>
  8004d9:	83 c4 10             	add    $0x10,%esp
  8004dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004df:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004e2:	c9                   	leave  
  8004e3:	c3                   	ret    

008004e4 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8004e4:	55                   	push   %ebp
  8004e5:	89 e5                	mov    %esp,%ebp
  8004e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004ea:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8004f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f4:	c1 e0 08             	shl    $0x8,%eax
  8004f7:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8004fc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004ff:	83 c0 04             	add    $0x4,%eax
  800502:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800505:	8b 45 0c             	mov    0xc(%ebp),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	ff 75 f4             	pushl  -0xc(%ebp)
  80050e:	50                   	push   %eax
  80050f:	e8 34 ff ff ff       	call   800448 <vcprintf>
  800514:	83 c4 10             	add    $0x10,%esp
  800517:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80051a:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800521:	07 00 00 

	return cnt;
  800524:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800527:	c9                   	leave  
  800528:	c3                   	ret    

00800529 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800529:	55                   	push   %ebp
  80052a:	89 e5                	mov    %esp,%ebp
  80052c:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80052f:	e8 07 12 00 00       	call   80173b <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800534:	8d 45 0c             	lea    0xc(%ebp),%eax
  800537:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80053a:	8b 45 08             	mov    0x8(%ebp),%eax
  80053d:	83 ec 08             	sub    $0x8,%esp
  800540:	ff 75 f4             	pushl  -0xc(%ebp)
  800543:	50                   	push   %eax
  800544:	e8 ff fe ff ff       	call   800448 <vcprintf>
  800549:	83 c4 10             	add    $0x10,%esp
  80054c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80054f:	e8 01 12 00 00       	call   801755 <sys_unlock_cons>
	return cnt;
  800554:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800557:	c9                   	leave  
  800558:	c3                   	ret    

00800559 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800559:	55                   	push   %ebp
  80055a:	89 e5                	mov    %esp,%ebp
  80055c:	53                   	push   %ebx
  80055d:	83 ec 14             	sub    $0x14,%esp
  800560:	8b 45 10             	mov    0x10(%ebp),%eax
  800563:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800566:	8b 45 14             	mov    0x14(%ebp),%eax
  800569:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80056c:	8b 45 18             	mov    0x18(%ebp),%eax
  80056f:	ba 00 00 00 00       	mov    $0x0,%edx
  800574:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800577:	77 55                	ja     8005ce <printnum+0x75>
  800579:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057c:	72 05                	jb     800583 <printnum+0x2a>
  80057e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800581:	77 4b                	ja     8005ce <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800583:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800586:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800589:	8b 45 18             	mov    0x18(%ebp),%eax
  80058c:	ba 00 00 00 00       	mov    $0x0,%edx
  800591:	52                   	push   %edx
  800592:	50                   	push   %eax
  800593:	ff 75 f4             	pushl  -0xc(%ebp)
  800596:	ff 75 f0             	pushl  -0x10(%ebp)
  800599:	e8 c6 19 00 00       	call   801f64 <__udivdi3>
  80059e:	83 c4 10             	add    $0x10,%esp
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	ff 75 20             	pushl  0x20(%ebp)
  8005a7:	53                   	push   %ebx
  8005a8:	ff 75 18             	pushl  0x18(%ebp)
  8005ab:	52                   	push   %edx
  8005ac:	50                   	push   %eax
  8005ad:	ff 75 0c             	pushl  0xc(%ebp)
  8005b0:	ff 75 08             	pushl  0x8(%ebp)
  8005b3:	e8 a1 ff ff ff       	call   800559 <printnum>
  8005b8:	83 c4 20             	add    $0x20,%esp
  8005bb:	eb 1a                	jmp    8005d7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005bd:	83 ec 08             	sub    $0x8,%esp
  8005c0:	ff 75 0c             	pushl  0xc(%ebp)
  8005c3:	ff 75 20             	pushl  0x20(%ebp)
  8005c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c9:	ff d0                	call   *%eax
  8005cb:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005ce:	ff 4d 1c             	decl   0x1c(%ebp)
  8005d1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005d5:	7f e6                	jg     8005bd <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005d7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005da:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e5:	53                   	push   %ebx
  8005e6:	51                   	push   %ecx
  8005e7:	52                   	push   %edx
  8005e8:	50                   	push   %eax
  8005e9:	e8 86 1a 00 00       	call   802074 <__umoddi3>
  8005ee:	83 c4 10             	add    $0x10,%esp
  8005f1:	05 34 26 80 00       	add    $0x802634,%eax
  8005f6:	8a 00                	mov    (%eax),%al
  8005f8:	0f be c0             	movsbl %al,%eax
  8005fb:	83 ec 08             	sub    $0x8,%esp
  8005fe:	ff 75 0c             	pushl  0xc(%ebp)
  800601:	50                   	push   %eax
  800602:	8b 45 08             	mov    0x8(%ebp),%eax
  800605:	ff d0                	call   *%eax
  800607:	83 c4 10             	add    $0x10,%esp
}
  80060a:	90                   	nop
  80060b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80060e:	c9                   	leave  
  80060f:	c3                   	ret    

00800610 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800610:	55                   	push   %ebp
  800611:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800613:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800617:	7e 1c                	jle    800635 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800619:	8b 45 08             	mov    0x8(%ebp),%eax
  80061c:	8b 00                	mov    (%eax),%eax
  80061e:	8d 50 08             	lea    0x8(%eax),%edx
  800621:	8b 45 08             	mov    0x8(%ebp),%eax
  800624:	89 10                	mov    %edx,(%eax)
  800626:	8b 45 08             	mov    0x8(%ebp),%eax
  800629:	8b 00                	mov    (%eax),%eax
  80062b:	83 e8 08             	sub    $0x8,%eax
  80062e:	8b 50 04             	mov    0x4(%eax),%edx
  800631:	8b 00                	mov    (%eax),%eax
  800633:	eb 40                	jmp    800675 <getuint+0x65>
	else if (lflag)
  800635:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800639:	74 1e                	je     800659 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	8d 50 04             	lea    0x4(%eax),%edx
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	89 10                	mov    %edx,(%eax)
  800648:	8b 45 08             	mov    0x8(%ebp),%eax
  80064b:	8b 00                	mov    (%eax),%eax
  80064d:	83 e8 04             	sub    $0x4,%eax
  800650:	8b 00                	mov    (%eax),%eax
  800652:	ba 00 00 00 00       	mov    $0x0,%edx
  800657:	eb 1c                	jmp    800675 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800659:	8b 45 08             	mov    0x8(%ebp),%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	8d 50 04             	lea    0x4(%eax),%edx
  800661:	8b 45 08             	mov    0x8(%ebp),%eax
  800664:	89 10                	mov    %edx,(%eax)
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	8b 00                	mov    (%eax),%eax
  80066b:	83 e8 04             	sub    $0x4,%eax
  80066e:	8b 00                	mov    (%eax),%eax
  800670:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800675:	5d                   	pop    %ebp
  800676:	c3                   	ret    

00800677 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800677:	55                   	push   %ebp
  800678:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80067a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80067e:	7e 1c                	jle    80069c <getint+0x25>
		return va_arg(*ap, long long);
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	8b 00                	mov    (%eax),%eax
  800685:	8d 50 08             	lea    0x8(%eax),%edx
  800688:	8b 45 08             	mov    0x8(%ebp),%eax
  80068b:	89 10                	mov    %edx,(%eax)
  80068d:	8b 45 08             	mov    0x8(%ebp),%eax
  800690:	8b 00                	mov    (%eax),%eax
  800692:	83 e8 08             	sub    $0x8,%eax
  800695:	8b 50 04             	mov    0x4(%eax),%edx
  800698:	8b 00                	mov    (%eax),%eax
  80069a:	eb 38                	jmp    8006d4 <getint+0x5d>
	else if (lflag)
  80069c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a0:	74 1a                	je     8006bc <getint+0x45>
		return va_arg(*ap, long);
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	8b 00                	mov    (%eax),%eax
  8006a7:	8d 50 04             	lea    0x4(%eax),%edx
  8006aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ad:	89 10                	mov    %edx,(%eax)
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	83 e8 04             	sub    $0x4,%eax
  8006b7:	8b 00                	mov    (%eax),%eax
  8006b9:	99                   	cltd   
  8006ba:	eb 18                	jmp    8006d4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	8d 50 04             	lea    0x4(%eax),%edx
  8006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c7:	89 10                	mov    %edx,(%eax)
  8006c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cc:	8b 00                	mov    (%eax),%eax
  8006ce:	83 e8 04             	sub    $0x4,%eax
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	99                   	cltd   
}
  8006d4:	5d                   	pop    %ebp
  8006d5:	c3                   	ret    

008006d6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006d6:	55                   	push   %ebp
  8006d7:	89 e5                	mov    %esp,%ebp
  8006d9:	56                   	push   %esi
  8006da:	53                   	push   %ebx
  8006db:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006de:	eb 17                	jmp    8006f7 <vprintfmt+0x21>
			if (ch == '\0')
  8006e0:	85 db                	test   %ebx,%ebx
  8006e2:	0f 84 c1 03 00 00    	je     800aa9 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8006e8:	83 ec 08             	sub    $0x8,%esp
  8006eb:	ff 75 0c             	pushl  0xc(%ebp)
  8006ee:	53                   	push   %ebx
  8006ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f2:	ff d0                	call   *%eax
  8006f4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fa:	8d 50 01             	lea    0x1(%eax),%edx
  8006fd:	89 55 10             	mov    %edx,0x10(%ebp)
  800700:	8a 00                	mov    (%eax),%al
  800702:	0f b6 d8             	movzbl %al,%ebx
  800705:	83 fb 25             	cmp    $0x25,%ebx
  800708:	75 d6                	jne    8006e0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80070a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80070e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800715:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80071c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800723:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80072a:	8b 45 10             	mov    0x10(%ebp),%eax
  80072d:	8d 50 01             	lea    0x1(%eax),%edx
  800730:	89 55 10             	mov    %edx,0x10(%ebp)
  800733:	8a 00                	mov    (%eax),%al
  800735:	0f b6 d8             	movzbl %al,%ebx
  800738:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80073b:	83 f8 5b             	cmp    $0x5b,%eax
  80073e:	0f 87 3d 03 00 00    	ja     800a81 <vprintfmt+0x3ab>
  800744:	8b 04 85 58 26 80 00 	mov    0x802658(,%eax,4),%eax
  80074b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80074d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800751:	eb d7                	jmp    80072a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800753:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800757:	eb d1                	jmp    80072a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800759:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800760:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800763:	89 d0                	mov    %edx,%eax
  800765:	c1 e0 02             	shl    $0x2,%eax
  800768:	01 d0                	add    %edx,%eax
  80076a:	01 c0                	add    %eax,%eax
  80076c:	01 d8                	add    %ebx,%eax
  80076e:	83 e8 30             	sub    $0x30,%eax
  800771:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800774:	8b 45 10             	mov    0x10(%ebp),%eax
  800777:	8a 00                	mov    (%eax),%al
  800779:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80077c:	83 fb 2f             	cmp    $0x2f,%ebx
  80077f:	7e 3e                	jle    8007bf <vprintfmt+0xe9>
  800781:	83 fb 39             	cmp    $0x39,%ebx
  800784:	7f 39                	jg     8007bf <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800786:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800789:	eb d5                	jmp    800760 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80078b:	8b 45 14             	mov    0x14(%ebp),%eax
  80078e:	83 c0 04             	add    $0x4,%eax
  800791:	89 45 14             	mov    %eax,0x14(%ebp)
  800794:	8b 45 14             	mov    0x14(%ebp),%eax
  800797:	83 e8 04             	sub    $0x4,%eax
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80079f:	eb 1f                	jmp    8007c0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a5:	79 83                	jns    80072a <vprintfmt+0x54>
				width = 0;
  8007a7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007ae:	e9 77 ff ff ff       	jmp    80072a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007b3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007ba:	e9 6b ff ff ff       	jmp    80072a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007bf:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c4:	0f 89 60 ff ff ff    	jns    80072a <vprintfmt+0x54>
				width = precision, precision = -1;
  8007ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007d0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007d7:	e9 4e ff ff ff       	jmp    80072a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007dc:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007df:	e9 46 ff ff ff       	jmp    80072a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e7:	83 c0 04             	add    $0x4,%eax
  8007ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f0:	83 e8 04             	sub    $0x4,%eax
  8007f3:	8b 00                	mov    (%eax),%eax
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	50                   	push   %eax
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	ff d0                	call   *%eax
  800801:	83 c4 10             	add    $0x10,%esp
			break;
  800804:	e9 9b 02 00 00       	jmp    800aa4 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800809:	8b 45 14             	mov    0x14(%ebp),%eax
  80080c:	83 c0 04             	add    $0x4,%eax
  80080f:	89 45 14             	mov    %eax,0x14(%ebp)
  800812:	8b 45 14             	mov    0x14(%ebp),%eax
  800815:	83 e8 04             	sub    $0x4,%eax
  800818:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80081a:	85 db                	test   %ebx,%ebx
  80081c:	79 02                	jns    800820 <vprintfmt+0x14a>
				err = -err;
  80081e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800820:	83 fb 64             	cmp    $0x64,%ebx
  800823:	7f 0b                	jg     800830 <vprintfmt+0x15a>
  800825:	8b 34 9d a0 24 80 00 	mov    0x8024a0(,%ebx,4),%esi
  80082c:	85 f6                	test   %esi,%esi
  80082e:	75 19                	jne    800849 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800830:	53                   	push   %ebx
  800831:	68 45 26 80 00       	push   $0x802645
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	ff 75 08             	pushl  0x8(%ebp)
  80083c:	e8 70 02 00 00       	call   800ab1 <printfmt>
  800841:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800844:	e9 5b 02 00 00       	jmp    800aa4 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800849:	56                   	push   %esi
  80084a:	68 4e 26 80 00       	push   $0x80264e
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	ff 75 08             	pushl  0x8(%ebp)
  800855:	e8 57 02 00 00       	call   800ab1 <printfmt>
  80085a:	83 c4 10             	add    $0x10,%esp
			break;
  80085d:	e9 42 02 00 00       	jmp    800aa4 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800862:	8b 45 14             	mov    0x14(%ebp),%eax
  800865:	83 c0 04             	add    $0x4,%eax
  800868:	89 45 14             	mov    %eax,0x14(%ebp)
  80086b:	8b 45 14             	mov    0x14(%ebp),%eax
  80086e:	83 e8 04             	sub    $0x4,%eax
  800871:	8b 30                	mov    (%eax),%esi
  800873:	85 f6                	test   %esi,%esi
  800875:	75 05                	jne    80087c <vprintfmt+0x1a6>
				p = "(null)";
  800877:	be 51 26 80 00       	mov    $0x802651,%esi
			if (width > 0 && padc != '-')
  80087c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800880:	7e 6d                	jle    8008ef <vprintfmt+0x219>
  800882:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800886:	74 67                	je     8008ef <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800888:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	50                   	push   %eax
  80088f:	56                   	push   %esi
  800890:	e8 26 05 00 00       	call   800dbb <strnlen>
  800895:	83 c4 10             	add    $0x10,%esp
  800898:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80089b:	eb 16                	jmp    8008b3 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80089d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008a1:	83 ec 08             	sub    $0x8,%esp
  8008a4:	ff 75 0c             	pushl  0xc(%ebp)
  8008a7:	50                   	push   %eax
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	ff d0                	call   *%eax
  8008ad:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b0:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b7:	7f e4                	jg     80089d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008b9:	eb 34                	jmp    8008ef <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008bb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008bf:	74 1c                	je     8008dd <vprintfmt+0x207>
  8008c1:	83 fb 1f             	cmp    $0x1f,%ebx
  8008c4:	7e 05                	jle    8008cb <vprintfmt+0x1f5>
  8008c6:	83 fb 7e             	cmp    $0x7e,%ebx
  8008c9:	7e 12                	jle    8008dd <vprintfmt+0x207>
					putch('?', putdat);
  8008cb:	83 ec 08             	sub    $0x8,%esp
  8008ce:	ff 75 0c             	pushl  0xc(%ebp)
  8008d1:	6a 3f                	push   $0x3f
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	ff d0                	call   *%eax
  8008d8:	83 c4 10             	add    $0x10,%esp
  8008db:	eb 0f                	jmp    8008ec <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008dd:	83 ec 08             	sub    $0x8,%esp
  8008e0:	ff 75 0c             	pushl  0xc(%ebp)
  8008e3:	53                   	push   %ebx
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	ff d0                	call   *%eax
  8008e9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ec:	ff 4d e4             	decl   -0x1c(%ebp)
  8008ef:	89 f0                	mov    %esi,%eax
  8008f1:	8d 70 01             	lea    0x1(%eax),%esi
  8008f4:	8a 00                	mov    (%eax),%al
  8008f6:	0f be d8             	movsbl %al,%ebx
  8008f9:	85 db                	test   %ebx,%ebx
  8008fb:	74 24                	je     800921 <vprintfmt+0x24b>
  8008fd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800901:	78 b8                	js     8008bb <vprintfmt+0x1e5>
  800903:	ff 4d e0             	decl   -0x20(%ebp)
  800906:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090a:	79 af                	jns    8008bb <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80090c:	eb 13                	jmp    800921 <vprintfmt+0x24b>
				putch(' ', putdat);
  80090e:	83 ec 08             	sub    $0x8,%esp
  800911:	ff 75 0c             	pushl  0xc(%ebp)
  800914:	6a 20                	push   $0x20
  800916:	8b 45 08             	mov    0x8(%ebp),%eax
  800919:	ff d0                	call   *%eax
  80091b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80091e:	ff 4d e4             	decl   -0x1c(%ebp)
  800921:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800925:	7f e7                	jg     80090e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800927:	e9 78 01 00 00       	jmp    800aa4 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80092c:	83 ec 08             	sub    $0x8,%esp
  80092f:	ff 75 e8             	pushl  -0x18(%ebp)
  800932:	8d 45 14             	lea    0x14(%ebp),%eax
  800935:	50                   	push   %eax
  800936:	e8 3c fd ff ff       	call   800677 <getint>
  80093b:	83 c4 10             	add    $0x10,%esp
  80093e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800941:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800944:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800947:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80094a:	85 d2                	test   %edx,%edx
  80094c:	79 23                	jns    800971 <vprintfmt+0x29b>
				putch('-', putdat);
  80094e:	83 ec 08             	sub    $0x8,%esp
  800951:	ff 75 0c             	pushl  0xc(%ebp)
  800954:	6a 2d                	push   $0x2d
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	ff d0                	call   *%eax
  80095b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80095e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800961:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800964:	f7 d8                	neg    %eax
  800966:	83 d2 00             	adc    $0x0,%edx
  800969:	f7 da                	neg    %edx
  80096b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800971:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800978:	e9 bc 00 00 00       	jmp    800a39 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80097d:	83 ec 08             	sub    $0x8,%esp
  800980:	ff 75 e8             	pushl  -0x18(%ebp)
  800983:	8d 45 14             	lea    0x14(%ebp),%eax
  800986:	50                   	push   %eax
  800987:	e8 84 fc ff ff       	call   800610 <getuint>
  80098c:	83 c4 10             	add    $0x10,%esp
  80098f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800992:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800995:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80099c:	e9 98 00 00 00       	jmp    800a39 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009a1:	83 ec 08             	sub    $0x8,%esp
  8009a4:	ff 75 0c             	pushl  0xc(%ebp)
  8009a7:	6a 58                	push   $0x58
  8009a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ac:	ff d0                	call   *%eax
  8009ae:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b1:	83 ec 08             	sub    $0x8,%esp
  8009b4:	ff 75 0c             	pushl  0xc(%ebp)
  8009b7:	6a 58                	push   $0x58
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	ff d0                	call   *%eax
  8009be:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c1:	83 ec 08             	sub    $0x8,%esp
  8009c4:	ff 75 0c             	pushl  0xc(%ebp)
  8009c7:	6a 58                	push   $0x58
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	ff d0                	call   *%eax
  8009ce:	83 c4 10             	add    $0x10,%esp
			break;
  8009d1:	e9 ce 00 00 00       	jmp    800aa4 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 0c             	pushl  0xc(%ebp)
  8009dc:	6a 30                	push   $0x30
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	ff d0                	call   *%eax
  8009e3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009e6:	83 ec 08             	sub    $0x8,%esp
  8009e9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ec:	6a 78                	push   $0x78
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	ff d0                	call   *%eax
  8009f3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f9:	83 c0 04             	add    $0x4,%eax
  8009fc:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800a02:	83 e8 04             	sub    $0x4,%eax
  800a05:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a11:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a18:	eb 1f                	jmp    800a39 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a1a:	83 ec 08             	sub    $0x8,%esp
  800a1d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a20:	8d 45 14             	lea    0x14(%ebp),%eax
  800a23:	50                   	push   %eax
  800a24:	e8 e7 fb ff ff       	call   800610 <getuint>
  800a29:	83 c4 10             	add    $0x10,%esp
  800a2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a32:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a39:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a40:	83 ec 04             	sub    $0x4,%esp
  800a43:	52                   	push   %edx
  800a44:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a47:	50                   	push   %eax
  800a48:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4e:	ff 75 0c             	pushl  0xc(%ebp)
  800a51:	ff 75 08             	pushl  0x8(%ebp)
  800a54:	e8 00 fb ff ff       	call   800559 <printnum>
  800a59:	83 c4 20             	add    $0x20,%esp
			break;
  800a5c:	eb 46                	jmp    800aa4 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a5e:	83 ec 08             	sub    $0x8,%esp
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	53                   	push   %ebx
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	ff d0                	call   *%eax
  800a6a:	83 c4 10             	add    $0x10,%esp
			break;
  800a6d:	eb 35                	jmp    800aa4 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800a6f:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800a76:	eb 2c                	jmp    800aa4 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800a78:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800a7f:	eb 23                	jmp    800aa4 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a81:	83 ec 08             	sub    $0x8,%esp
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	6a 25                	push   $0x25
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	ff d0                	call   *%eax
  800a8e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a91:	ff 4d 10             	decl   0x10(%ebp)
  800a94:	eb 03                	jmp    800a99 <vprintfmt+0x3c3>
  800a96:	ff 4d 10             	decl   0x10(%ebp)
  800a99:	8b 45 10             	mov    0x10(%ebp),%eax
  800a9c:	48                   	dec    %eax
  800a9d:	8a 00                	mov    (%eax),%al
  800a9f:	3c 25                	cmp    $0x25,%al
  800aa1:	75 f3                	jne    800a96 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800aa3:	90                   	nop
		}
	}
  800aa4:	e9 35 fc ff ff       	jmp    8006de <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800aa9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800aaa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aad:	5b                   	pop    %ebx
  800aae:	5e                   	pop    %esi
  800aaf:	5d                   	pop    %ebp
  800ab0:	c3                   	ret    

00800ab1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ab1:	55                   	push   %ebp
  800ab2:	89 e5                	mov    %esp,%ebp
  800ab4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ab7:	8d 45 10             	lea    0x10(%ebp),%eax
  800aba:	83 c0 04             	add    $0x4,%eax
  800abd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ac0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac6:	50                   	push   %eax
  800ac7:	ff 75 0c             	pushl  0xc(%ebp)
  800aca:	ff 75 08             	pushl  0x8(%ebp)
  800acd:	e8 04 fc ff ff       	call   8006d6 <vprintfmt>
  800ad2:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ad5:	90                   	nop
  800ad6:	c9                   	leave  
  800ad7:	c3                   	ret    

00800ad8 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ad8:	55                   	push   %ebp
  800ad9:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	8b 40 08             	mov    0x8(%eax),%eax
  800ae1:	8d 50 01             	lea    0x1(%eax),%edx
  800ae4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae7:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aed:	8b 10                	mov    (%eax),%edx
  800aef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af2:	8b 40 04             	mov    0x4(%eax),%eax
  800af5:	39 c2                	cmp    %eax,%edx
  800af7:	73 12                	jae    800b0b <sprintputch+0x33>
		*b->buf++ = ch;
  800af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afc:	8b 00                	mov    (%eax),%eax
  800afe:	8d 48 01             	lea    0x1(%eax),%ecx
  800b01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b04:	89 0a                	mov    %ecx,(%edx)
  800b06:	8b 55 08             	mov    0x8(%ebp),%edx
  800b09:	88 10                	mov    %dl,(%eax)
}
  800b0b:	90                   	nop
  800b0c:	5d                   	pop    %ebp
  800b0d:	c3                   	ret    

00800b0e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b0e:	55                   	push   %ebp
  800b0f:	89 e5                	mov    %esp,%ebp
  800b11:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	01 d0                	add    %edx,%eax
  800b25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b2f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b33:	74 06                	je     800b3b <vsnprintf+0x2d>
  800b35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b39:	7f 07                	jg     800b42 <vsnprintf+0x34>
		return -E_INVAL;
  800b3b:	b8 03 00 00 00       	mov    $0x3,%eax
  800b40:	eb 20                	jmp    800b62 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b42:	ff 75 14             	pushl  0x14(%ebp)
  800b45:	ff 75 10             	pushl  0x10(%ebp)
  800b48:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b4b:	50                   	push   %eax
  800b4c:	68 d8 0a 80 00       	push   $0x800ad8
  800b51:	e8 80 fb ff ff       	call   8006d6 <vprintfmt>
  800b56:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b59:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b5c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b62:	c9                   	leave  
  800b63:	c3                   	ret    

00800b64 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b64:	55                   	push   %ebp
  800b65:	89 e5                	mov    %esp,%ebp
  800b67:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b6a:	8d 45 10             	lea    0x10(%ebp),%eax
  800b6d:	83 c0 04             	add    $0x4,%eax
  800b70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b73:	8b 45 10             	mov    0x10(%ebp),%eax
  800b76:	ff 75 f4             	pushl  -0xc(%ebp)
  800b79:	50                   	push   %eax
  800b7a:	ff 75 0c             	pushl  0xc(%ebp)
  800b7d:	ff 75 08             	pushl  0x8(%ebp)
  800b80:	e8 89 ff ff ff       	call   800b0e <vsnprintf>
  800b85:	83 c4 10             	add    $0x10,%esp
  800b88:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b8e:	c9                   	leave  
  800b8f:	c3                   	ret    

00800b90 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
  800b93:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  800b96:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b9a:	74 13                	je     800baf <readline+0x1f>
		cprintf("%s", prompt);
  800b9c:	83 ec 08             	sub    $0x8,%esp
  800b9f:	ff 75 08             	pushl  0x8(%ebp)
  800ba2:	68 c8 27 80 00       	push   $0x8027c8
  800ba7:	e8 0b f9 ff ff       	call   8004b7 <cprintf>
  800bac:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800baf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800bb6:	83 ec 0c             	sub    $0xc,%esp
  800bb9:	6a 00                	push   $0x0
  800bbb:	e8 a9 11 00 00       	call   801d69 <iscons>
  800bc0:	83 c4 10             	add    $0x10,%esp
  800bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800bc6:	e8 85 11 00 00       	call   801d50 <getchar>
  800bcb:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800bce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800bd2:	79 22                	jns    800bf6 <readline+0x66>
			if (c != -E_EOF)
  800bd4:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800bd8:	0f 84 ad 00 00 00    	je     800c8b <readline+0xfb>
				cprintf("read error: %e\n", c);
  800bde:	83 ec 08             	sub    $0x8,%esp
  800be1:	ff 75 ec             	pushl  -0x14(%ebp)
  800be4:	68 cb 27 80 00       	push   $0x8027cb
  800be9:	e8 c9 f8 ff ff       	call   8004b7 <cprintf>
  800bee:	83 c4 10             	add    $0x10,%esp
			break;
  800bf1:	e9 95 00 00 00       	jmp    800c8b <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800bf6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800bfa:	7e 34                	jle    800c30 <readline+0xa0>
  800bfc:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c03:	7f 2b                	jg     800c30 <readline+0xa0>
			if (echoing)
  800c05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c09:	74 0e                	je     800c19 <readline+0x89>
				cputchar(c);
  800c0b:	83 ec 0c             	sub    $0xc,%esp
  800c0e:	ff 75 ec             	pushl  -0x14(%ebp)
  800c11:	e8 1b 11 00 00       	call   801d31 <cputchar>
  800c16:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c1c:	8d 50 01             	lea    0x1(%eax),%edx
  800c1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800c22:	89 c2                	mov    %eax,%edx
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	01 d0                	add    %edx,%eax
  800c29:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800c2c:	88 10                	mov    %dl,(%eax)
  800c2e:	eb 56                	jmp    800c86 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800c30:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800c34:	75 1f                	jne    800c55 <readline+0xc5>
  800c36:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800c3a:	7e 19                	jle    800c55 <readline+0xc5>
			if (echoing)
  800c3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c40:	74 0e                	je     800c50 <readline+0xc0>
				cputchar(c);
  800c42:	83 ec 0c             	sub    $0xc,%esp
  800c45:	ff 75 ec             	pushl  -0x14(%ebp)
  800c48:	e8 e4 10 00 00       	call   801d31 <cputchar>
  800c4d:	83 c4 10             	add    $0x10,%esp

			i--;
  800c50:	ff 4d f4             	decl   -0xc(%ebp)
  800c53:	eb 31                	jmp    800c86 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800c55:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800c59:	74 0a                	je     800c65 <readline+0xd5>
  800c5b:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800c5f:	0f 85 61 ff ff ff    	jne    800bc6 <readline+0x36>
			if (echoing)
  800c65:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c69:	74 0e                	je     800c79 <readline+0xe9>
				cputchar(c);
  800c6b:	83 ec 0c             	sub    $0xc,%esp
  800c6e:	ff 75 ec             	pushl  -0x14(%ebp)
  800c71:	e8 bb 10 00 00       	call   801d31 <cputchar>
  800c76:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800c79:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	01 d0                	add    %edx,%eax
  800c81:	c6 00 00             	movb   $0x0,(%eax)
			break;
  800c84:	eb 06                	jmp    800c8c <readline+0xfc>
		}
	}
  800c86:	e9 3b ff ff ff       	jmp    800bc6 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  800c8b:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  800c8c:	90                   	nop
  800c8d:	c9                   	leave  
  800c8e:	c3                   	ret    

00800c8f <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
  800c92:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  800c95:	e8 a1 0a 00 00       	call   80173b <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  800c9a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c9e:	74 13                	je     800cb3 <atomic_readline+0x24>
			cprintf("%s", prompt);
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 08             	pushl  0x8(%ebp)
  800ca6:	68 c8 27 80 00       	push   $0x8027c8
  800cab:	e8 07 f8 ff ff       	call   8004b7 <cprintf>
  800cb0:	83 c4 10             	add    $0x10,%esp

		i = 0;
  800cb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  800cba:	83 ec 0c             	sub    $0xc,%esp
  800cbd:	6a 00                	push   $0x0
  800cbf:	e8 a5 10 00 00       	call   801d69 <iscons>
  800cc4:	83 c4 10             	add    $0x10,%esp
  800cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  800cca:	e8 81 10 00 00       	call   801d50 <getchar>
  800ccf:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  800cd2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800cd6:	79 22                	jns    800cfa <atomic_readline+0x6b>
				if (c != -E_EOF)
  800cd8:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800cdc:	0f 84 ad 00 00 00    	je     800d8f <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  800ce2:	83 ec 08             	sub    $0x8,%esp
  800ce5:	ff 75 ec             	pushl  -0x14(%ebp)
  800ce8:	68 cb 27 80 00       	push   $0x8027cb
  800ced:	e8 c5 f7 ff ff       	call   8004b7 <cprintf>
  800cf2:	83 c4 10             	add    $0x10,%esp
				break;
  800cf5:	e9 95 00 00 00       	jmp    800d8f <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  800cfa:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800cfe:	7e 34                	jle    800d34 <atomic_readline+0xa5>
  800d00:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800d07:	7f 2b                	jg     800d34 <atomic_readline+0xa5>
				if (echoing)
  800d09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d0d:	74 0e                	je     800d1d <atomic_readline+0x8e>
					cputchar(c);
  800d0f:	83 ec 0c             	sub    $0xc,%esp
  800d12:	ff 75 ec             	pushl  -0x14(%ebp)
  800d15:	e8 17 10 00 00       	call   801d31 <cputchar>
  800d1a:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  800d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d20:	8d 50 01             	lea    0x1(%eax),%edx
  800d23:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800d26:	89 c2                	mov    %eax,%edx
  800d28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2b:	01 d0                	add    %edx,%eax
  800d2d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d30:	88 10                	mov    %dl,(%eax)
  800d32:	eb 56                	jmp    800d8a <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  800d34:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800d38:	75 1f                	jne    800d59 <atomic_readline+0xca>
  800d3a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800d3e:	7e 19                	jle    800d59 <atomic_readline+0xca>
				if (echoing)
  800d40:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d44:	74 0e                	je     800d54 <atomic_readline+0xc5>
					cputchar(c);
  800d46:	83 ec 0c             	sub    $0xc,%esp
  800d49:	ff 75 ec             	pushl  -0x14(%ebp)
  800d4c:	e8 e0 0f 00 00       	call   801d31 <cputchar>
  800d51:	83 c4 10             	add    $0x10,%esp
				i--;
  800d54:	ff 4d f4             	decl   -0xc(%ebp)
  800d57:	eb 31                	jmp    800d8a <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  800d59:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800d5d:	74 0a                	je     800d69 <atomic_readline+0xda>
  800d5f:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800d63:	0f 85 61 ff ff ff    	jne    800cca <atomic_readline+0x3b>
				if (echoing)
  800d69:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d6d:	74 0e                	je     800d7d <atomic_readline+0xee>
					cputchar(c);
  800d6f:	83 ec 0c             	sub    $0xc,%esp
  800d72:	ff 75 ec             	pushl  -0x14(%ebp)
  800d75:	e8 b7 0f 00 00       	call   801d31 <cputchar>
  800d7a:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  800d7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d83:	01 d0                	add    %edx,%eax
  800d85:	c6 00 00             	movb   $0x0,(%eax)
				break;
  800d88:	eb 06                	jmp    800d90 <atomic_readline+0x101>
			}
		}
  800d8a:	e9 3b ff ff ff       	jmp    800cca <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  800d8f:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  800d90:	e8 c0 09 00 00       	call   801755 <sys_unlock_cons>
}
  800d95:	90                   	nop
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
  800d9b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da5:	eb 06                	jmp    800dad <strlen+0x15>
		n++;
  800da7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	8b 45 08             	mov    0x8(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	84 c0                	test   %al,%al
  800db4:	75 f1                	jne    800da7 <strlen+0xf>
		n++;
	return n;
  800db6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db9:	c9                   	leave  
  800dba:	c3                   	ret    

00800dbb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dbb:	55                   	push   %ebp
  800dbc:	89 e5                	mov    %esp,%ebp
  800dbe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc8:	eb 09                	jmp    800dd3 <strnlen+0x18>
		n++;
  800dca:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dcd:	ff 45 08             	incl   0x8(%ebp)
  800dd0:	ff 4d 0c             	decl   0xc(%ebp)
  800dd3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd7:	74 09                	je     800de2 <strnlen+0x27>
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8a 00                	mov    (%eax),%al
  800dde:	84 c0                	test   %al,%al
  800de0:	75 e8                	jne    800dca <strnlen+0xf>
		n++;
	return n;
  800de2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de5:	c9                   	leave  
  800de6:	c3                   	ret    

00800de7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
  800dea:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800df3:	90                   	nop
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8d 50 01             	lea    0x1(%eax),%edx
  800dfa:	89 55 08             	mov    %edx,0x8(%ebp)
  800dfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e00:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e03:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e06:	8a 12                	mov    (%edx),%dl
  800e08:	88 10                	mov    %dl,(%eax)
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	84 c0                	test   %al,%al
  800e0e:	75 e4                	jne    800df4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e13:	c9                   	leave  
  800e14:	c3                   	ret    

00800e15 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e15:	55                   	push   %ebp
  800e16:	89 e5                	mov    %esp,%ebp
  800e18:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e28:	eb 1f                	jmp    800e49 <strncpy+0x34>
		*dst++ = *src;
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	8d 50 01             	lea    0x1(%eax),%edx
  800e30:	89 55 08             	mov    %edx,0x8(%ebp)
  800e33:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e36:	8a 12                	mov    (%edx),%dl
  800e38:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	84 c0                	test   %al,%al
  800e41:	74 03                	je     800e46 <strncpy+0x31>
			src++;
  800e43:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e46:	ff 45 fc             	incl   -0x4(%ebp)
  800e49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e4f:	72 d9                	jb     800e2a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e54:	c9                   	leave  
  800e55:	c3                   	ret    

00800e56 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e56:	55                   	push   %ebp
  800e57:	89 e5                	mov    %esp,%ebp
  800e59:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e66:	74 30                	je     800e98 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e68:	eb 16                	jmp    800e80 <strlcpy+0x2a>
			*dst++ = *src++;
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	8d 50 01             	lea    0x1(%eax),%edx
  800e70:	89 55 08             	mov    %edx,0x8(%ebp)
  800e73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e79:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e7c:	8a 12                	mov    (%edx),%dl
  800e7e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e80:	ff 4d 10             	decl   0x10(%ebp)
  800e83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e87:	74 09                	je     800e92 <strlcpy+0x3c>
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	84 c0                	test   %al,%al
  800e90:	75 d8                	jne    800e6a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e98:	8b 55 08             	mov    0x8(%ebp),%edx
  800e9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9e:	29 c2                	sub    %eax,%edx
  800ea0:	89 d0                	mov    %edx,%eax
}
  800ea2:	c9                   	leave  
  800ea3:	c3                   	ret    

00800ea4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ea4:	55                   	push   %ebp
  800ea5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ea7:	eb 06                	jmp    800eaf <strcmp+0xb>
		p++, q++;
  800ea9:	ff 45 08             	incl   0x8(%ebp)
  800eac:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	84 c0                	test   %al,%al
  800eb6:	74 0e                	je     800ec6 <strcmp+0x22>
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8a 10                	mov    (%eax),%dl
  800ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	38 c2                	cmp    %al,%dl
  800ec4:	74 e3                	je     800ea9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	8a 00                	mov    (%eax),%al
  800ecb:	0f b6 d0             	movzbl %al,%edx
  800ece:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	0f b6 c0             	movzbl %al,%eax
  800ed6:	29 c2                	sub    %eax,%edx
  800ed8:	89 d0                	mov    %edx,%eax
}
  800eda:	5d                   	pop    %ebp
  800edb:	c3                   	ret    

00800edc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800edc:	55                   	push   %ebp
  800edd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800edf:	eb 09                	jmp    800eea <strncmp+0xe>
		n--, p++, q++;
  800ee1:	ff 4d 10             	decl   0x10(%ebp)
  800ee4:	ff 45 08             	incl   0x8(%ebp)
  800ee7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800eea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eee:	74 17                	je     800f07 <strncmp+0x2b>
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	84 c0                	test   %al,%al
  800ef7:	74 0e                	je     800f07 <strncmp+0x2b>
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	8a 10                	mov    (%eax),%dl
  800efe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	38 c2                	cmp    %al,%dl
  800f05:	74 da                	je     800ee1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0b:	75 07                	jne    800f14 <strncmp+0x38>
		return 0;
  800f0d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f12:	eb 14                	jmp    800f28 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	0f b6 d0             	movzbl %al,%edx
  800f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	0f b6 c0             	movzbl %al,%eax
  800f24:	29 c2                	sub    %eax,%edx
  800f26:	89 d0                	mov    %edx,%eax
}
  800f28:	5d                   	pop    %ebp
  800f29:	c3                   	ret    

00800f2a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f2a:	55                   	push   %ebp
  800f2b:	89 e5                	mov    %esp,%ebp
  800f2d:	83 ec 04             	sub    $0x4,%esp
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f36:	eb 12                	jmp    800f4a <strchr+0x20>
		if (*s == c)
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f40:	75 05                	jne    800f47 <strchr+0x1d>
			return (char *) s;
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	eb 11                	jmp    800f58 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f47:	ff 45 08             	incl   0x8(%ebp)
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	84 c0                	test   %al,%al
  800f51:	75 e5                	jne    800f38 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f58:	c9                   	leave  
  800f59:	c3                   	ret    

00800f5a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f5a:	55                   	push   %ebp
  800f5b:	89 e5                	mov    %esp,%ebp
  800f5d:	83 ec 04             	sub    $0x4,%esp
  800f60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f63:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f66:	eb 0d                	jmp    800f75 <strfind+0x1b>
		if (*s == c)
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f70:	74 0e                	je     800f80 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f72:	ff 45 08             	incl   0x8(%ebp)
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	84 c0                	test   %al,%al
  800f7c:	75 ea                	jne    800f68 <strfind+0xe>
  800f7e:	eb 01                	jmp    800f81 <strfind+0x27>
		if (*s == c)
			break;
  800f80:	90                   	nop
	return (char *) s;
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f84:	c9                   	leave  
  800f85:	c3                   	ret    

00800f86 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f86:	55                   	push   %ebp
  800f87:	89 e5                	mov    %esp,%ebp
  800f89:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f92:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f96:	76 63                	jbe    800ffb <memset+0x75>
		uint64 data_block = c;
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	99                   	cltd   
  800f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9f:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800fa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa8:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800fac:	c1 e0 08             	shl    $0x8,%eax
  800faf:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fb2:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800fb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fbb:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800fbf:	c1 e0 10             	shl    $0x10,%eax
  800fc2:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fc5:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fce:	89 c2                	mov    %eax,%edx
  800fd0:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd5:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fd8:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800fdb:	eb 18                	jmp    800ff5 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800fdd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fe0:	8d 41 08             	lea    0x8(%ecx),%eax
  800fe3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800fe6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fec:	89 01                	mov    %eax,(%ecx)
  800fee:	89 51 04             	mov    %edx,0x4(%ecx)
  800ff1:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800ff5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ff9:	77 e2                	ja     800fdd <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800ffb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fff:	74 23                	je     801024 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801001:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801004:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801007:	eb 0e                	jmp    801017 <memset+0x91>
			*p8++ = (uint8)c;
  801009:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100c:	8d 50 01             	lea    0x1(%eax),%edx
  80100f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801012:	8b 55 0c             	mov    0xc(%ebp),%edx
  801015:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801017:	8b 45 10             	mov    0x10(%ebp),%eax
  80101a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80101d:	89 55 10             	mov    %edx,0x10(%ebp)
  801020:	85 c0                	test   %eax,%eax
  801022:	75 e5                	jne    801009 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80102f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801032:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  80103b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80103f:	76 24                	jbe    801065 <memcpy+0x3c>
		while(n >= 8){
  801041:	eb 1c                	jmp    80105f <memcpy+0x36>
			*d64 = *s64;
  801043:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801046:	8b 50 04             	mov    0x4(%eax),%edx
  801049:	8b 00                	mov    (%eax),%eax
  80104b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80104e:	89 01                	mov    %eax,(%ecx)
  801050:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801053:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801057:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80105b:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80105f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801063:	77 de                	ja     801043 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801065:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801069:	74 31                	je     80109c <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80106b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801074:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801077:	eb 16                	jmp    80108f <memcpy+0x66>
			*d8++ = *s8++;
  801079:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80107c:	8d 50 01             	lea    0x1(%eax),%edx
  80107f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801082:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801085:	8d 4a 01             	lea    0x1(%edx),%ecx
  801088:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80108b:	8a 12                	mov    (%edx),%dl
  80108d:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80108f:	8b 45 10             	mov    0x10(%ebp),%eax
  801092:	8d 50 ff             	lea    -0x1(%eax),%edx
  801095:	89 55 10             	mov    %edx,0x10(%ebp)
  801098:	85 c0                	test   %eax,%eax
  80109a:	75 dd                	jne    801079 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80109f:	c9                   	leave  
  8010a0:	c3                   	ret    

008010a1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010a1:	55                   	push   %ebp
  8010a2:	89 e5                	mov    %esp,%ebp
  8010a4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010b9:	73 50                	jae    80110b <memmove+0x6a>
  8010bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010be:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c1:	01 d0                	add    %edx,%eax
  8010c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010c6:	76 43                	jbe    80110b <memmove+0x6a>
		s += n;
  8010c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010d4:	eb 10                	jmp    8010e6 <memmove+0x45>
			*--d = *--s;
  8010d6:	ff 4d f8             	decl   -0x8(%ebp)
  8010d9:	ff 4d fc             	decl   -0x4(%ebp)
  8010dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010df:	8a 10                	mov    (%eax),%dl
  8010e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ec:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ef:	85 c0                	test   %eax,%eax
  8010f1:	75 e3                	jne    8010d6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010f3:	eb 23                	jmp    801118 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f8:	8d 50 01             	lea    0x1(%eax),%edx
  8010fb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801101:	8d 4a 01             	lea    0x1(%edx),%ecx
  801104:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801107:	8a 12                	mov    (%edx),%dl
  801109:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80110b:	8b 45 10             	mov    0x10(%ebp),%eax
  80110e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801111:	89 55 10             	mov    %edx,0x10(%ebp)
  801114:	85 c0                	test   %eax,%eax
  801116:	75 dd                	jne    8010f5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80112f:	eb 2a                	jmp    80115b <memcmp+0x3e>
		if (*s1 != *s2)
  801131:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801134:	8a 10                	mov    (%eax),%dl
  801136:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	38 c2                	cmp    %al,%dl
  80113d:	74 16                	je     801155 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80113f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	0f b6 d0             	movzbl %al,%edx
  801147:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114a:	8a 00                	mov    (%eax),%al
  80114c:	0f b6 c0             	movzbl %al,%eax
  80114f:	29 c2                	sub    %eax,%edx
  801151:	89 d0                	mov    %edx,%eax
  801153:	eb 18                	jmp    80116d <memcmp+0x50>
		s1++, s2++;
  801155:	ff 45 fc             	incl   -0x4(%ebp)
  801158:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80115b:	8b 45 10             	mov    0x10(%ebp),%eax
  80115e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801161:	89 55 10             	mov    %edx,0x10(%ebp)
  801164:	85 c0                	test   %eax,%eax
  801166:	75 c9                	jne    801131 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801168:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80116d:	c9                   	leave  
  80116e:	c3                   	ret    

0080116f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80116f:	55                   	push   %ebp
  801170:	89 e5                	mov    %esp,%ebp
  801172:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801175:	8b 55 08             	mov    0x8(%ebp),%edx
  801178:	8b 45 10             	mov    0x10(%ebp),%eax
  80117b:	01 d0                	add    %edx,%eax
  80117d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801180:	eb 15                	jmp    801197 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	0f b6 d0             	movzbl %al,%edx
  80118a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118d:	0f b6 c0             	movzbl %al,%eax
  801190:	39 c2                	cmp    %eax,%edx
  801192:	74 0d                	je     8011a1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801194:	ff 45 08             	incl   0x8(%ebp)
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80119d:	72 e3                	jb     801182 <memfind+0x13>
  80119f:	eb 01                	jmp    8011a2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011a1:	90                   	nop
	return (void *) s;
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011a5:	c9                   	leave  
  8011a6:	c3                   	ret    

008011a7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011a7:	55                   	push   %ebp
  8011a8:	89 e5                	mov    %esp,%ebp
  8011aa:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011bb:	eb 03                	jmp    8011c0 <strtol+0x19>
		s++;
  8011bd:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 20                	cmp    $0x20,%al
  8011c7:	74 f4                	je     8011bd <strtol+0x16>
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3c 09                	cmp    $0x9,%al
  8011d0:	74 eb                	je     8011bd <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	3c 2b                	cmp    $0x2b,%al
  8011d9:	75 05                	jne    8011e0 <strtol+0x39>
		s++;
  8011db:	ff 45 08             	incl   0x8(%ebp)
  8011de:	eb 13                	jmp    8011f3 <strtol+0x4c>
	else if (*s == '-')
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	3c 2d                	cmp    $0x2d,%al
  8011e7:	75 0a                	jne    8011f3 <strtol+0x4c>
		s++, neg = 1;
  8011e9:	ff 45 08             	incl   0x8(%ebp)
  8011ec:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f7:	74 06                	je     8011ff <strtol+0x58>
  8011f9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011fd:	75 20                	jne    80121f <strtol+0x78>
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	8a 00                	mov    (%eax),%al
  801204:	3c 30                	cmp    $0x30,%al
  801206:	75 17                	jne    80121f <strtol+0x78>
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	40                   	inc    %eax
  80120c:	8a 00                	mov    (%eax),%al
  80120e:	3c 78                	cmp    $0x78,%al
  801210:	75 0d                	jne    80121f <strtol+0x78>
		s += 2, base = 16;
  801212:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801216:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80121d:	eb 28                	jmp    801247 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80121f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801223:	75 15                	jne    80123a <strtol+0x93>
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3c 30                	cmp    $0x30,%al
  80122c:	75 0c                	jne    80123a <strtol+0x93>
		s++, base = 8;
  80122e:	ff 45 08             	incl   0x8(%ebp)
  801231:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801238:	eb 0d                	jmp    801247 <strtol+0xa0>
	else if (base == 0)
  80123a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80123e:	75 07                	jne    801247 <strtol+0xa0>
		base = 10;
  801240:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 2f                	cmp    $0x2f,%al
  80124e:	7e 19                	jle    801269 <strtol+0xc2>
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	3c 39                	cmp    $0x39,%al
  801257:	7f 10                	jg     801269 <strtol+0xc2>
			dig = *s - '0';
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	8a 00                	mov    (%eax),%al
  80125e:	0f be c0             	movsbl %al,%eax
  801261:	83 e8 30             	sub    $0x30,%eax
  801264:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801267:	eb 42                	jmp    8012ab <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	3c 60                	cmp    $0x60,%al
  801270:	7e 19                	jle    80128b <strtol+0xe4>
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	3c 7a                	cmp    $0x7a,%al
  801279:	7f 10                	jg     80128b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	0f be c0             	movsbl %al,%eax
  801283:	83 e8 57             	sub    $0x57,%eax
  801286:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801289:	eb 20                	jmp    8012ab <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	3c 40                	cmp    $0x40,%al
  801292:	7e 39                	jle    8012cd <strtol+0x126>
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	3c 5a                	cmp    $0x5a,%al
  80129b:	7f 30                	jg     8012cd <strtol+0x126>
			dig = *s - 'A' + 10;
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	0f be c0             	movsbl %al,%eax
  8012a5:	83 e8 37             	sub    $0x37,%eax
  8012a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ae:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012b1:	7d 19                	jge    8012cc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012b3:	ff 45 08             	incl   0x8(%ebp)
  8012b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012bd:	89 c2                	mov    %eax,%edx
  8012bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c2:	01 d0                	add    %edx,%eax
  8012c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012c7:	e9 7b ff ff ff       	jmp    801247 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012cc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012d1:	74 08                	je     8012db <strtol+0x134>
		*endptr = (char *) s;
  8012d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d6:	8b 55 08             	mov    0x8(%ebp),%edx
  8012d9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012db:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012df:	74 07                	je     8012e8 <strtol+0x141>
  8012e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e4:	f7 d8                	neg    %eax
  8012e6:	eb 03                	jmp    8012eb <strtol+0x144>
  8012e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012eb:	c9                   	leave  
  8012ec:	c3                   	ret    

008012ed <ltostr>:

void
ltostr(long value, char *str)
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
  8012f0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012fa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801301:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801305:	79 13                	jns    80131a <ltostr+0x2d>
	{
		neg = 1;
  801307:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80130e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801311:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801314:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801317:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801322:	99                   	cltd   
  801323:	f7 f9                	idiv   %ecx
  801325:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801328:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132b:	8d 50 01             	lea    0x1(%eax),%edx
  80132e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801331:	89 c2                	mov    %eax,%edx
  801333:	8b 45 0c             	mov    0xc(%ebp),%eax
  801336:	01 d0                	add    %edx,%eax
  801338:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80133b:	83 c2 30             	add    $0x30,%edx
  80133e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801340:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801343:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801348:	f7 e9                	imul   %ecx
  80134a:	c1 fa 02             	sar    $0x2,%edx
  80134d:	89 c8                	mov    %ecx,%eax
  80134f:	c1 f8 1f             	sar    $0x1f,%eax
  801352:	29 c2                	sub    %eax,%edx
  801354:	89 d0                	mov    %edx,%eax
  801356:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801359:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80135d:	75 bb                	jne    80131a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80135f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801366:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801369:	48                   	dec    %eax
  80136a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80136d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801371:	74 3d                	je     8013b0 <ltostr+0xc3>
		start = 1 ;
  801373:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80137a:	eb 34                	jmp    8013b0 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80137c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80137f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801382:	01 d0                	add    %edx,%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801389:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80138c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138f:	01 c2                	add    %eax,%edx
  801391:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	01 c8                	add    %ecx,%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80139d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a3:	01 c2                	add    %eax,%edx
  8013a5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013a8:	88 02                	mov    %al,(%edx)
		start++ ;
  8013aa:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013ad:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013b6:	7c c4                	jl     80137c <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013b8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013be:	01 d0                	add    %edx,%eax
  8013c0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013c3:	90                   	nop
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
  8013c9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013cc:	ff 75 08             	pushl  0x8(%ebp)
  8013cf:	e8 c4 f9 ff ff       	call   800d98 <strlen>
  8013d4:	83 c4 04             	add    $0x4,%esp
  8013d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013da:	ff 75 0c             	pushl  0xc(%ebp)
  8013dd:	e8 b6 f9 ff ff       	call   800d98 <strlen>
  8013e2:	83 c4 04             	add    $0x4,%esp
  8013e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013f6:	eb 17                	jmp    80140f <strcconcat+0x49>
		final[s] = str1[s] ;
  8013f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fe:	01 c2                	add    %eax,%edx
  801400:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	01 c8                	add    %ecx,%eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80140c:	ff 45 fc             	incl   -0x4(%ebp)
  80140f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801412:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801415:	7c e1                	jl     8013f8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801417:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80141e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801425:	eb 1f                	jmp    801446 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801427:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80142a:	8d 50 01             	lea    0x1(%eax),%edx
  80142d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801430:	89 c2                	mov    %eax,%edx
  801432:	8b 45 10             	mov    0x10(%ebp),%eax
  801435:	01 c2                	add    %eax,%edx
  801437:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	01 c8                	add    %ecx,%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801443:	ff 45 f8             	incl   -0x8(%ebp)
  801446:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801449:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80144c:	7c d9                	jl     801427 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80144e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801451:	8b 45 10             	mov    0x10(%ebp),%eax
  801454:	01 d0                	add    %edx,%eax
  801456:	c6 00 00             	movb   $0x0,(%eax)
}
  801459:	90                   	nop
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80145f:	8b 45 14             	mov    0x14(%ebp),%eax
  801462:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801468:	8b 45 14             	mov    0x14(%ebp),%eax
  80146b:	8b 00                	mov    (%eax),%eax
  80146d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801474:	8b 45 10             	mov    0x10(%ebp),%eax
  801477:	01 d0                	add    %edx,%eax
  801479:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80147f:	eb 0c                	jmp    80148d <strsplit+0x31>
			*string++ = 0;
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	8d 50 01             	lea    0x1(%eax),%edx
  801487:	89 55 08             	mov    %edx,0x8(%ebp)
  80148a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	84 c0                	test   %al,%al
  801494:	74 18                	je     8014ae <strsplit+0x52>
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	0f be c0             	movsbl %al,%eax
  80149e:	50                   	push   %eax
  80149f:	ff 75 0c             	pushl  0xc(%ebp)
  8014a2:	e8 83 fa ff ff       	call   800f2a <strchr>
  8014a7:	83 c4 08             	add    $0x8,%esp
  8014aa:	85 c0                	test   %eax,%eax
  8014ac:	75 d3                	jne    801481 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	8a 00                	mov    (%eax),%al
  8014b3:	84 c0                	test   %al,%al
  8014b5:	74 5a                	je     801511 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ba:	8b 00                	mov    (%eax),%eax
  8014bc:	83 f8 0f             	cmp    $0xf,%eax
  8014bf:	75 07                	jne    8014c8 <strsplit+0x6c>
		{
			return 0;
  8014c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8014c6:	eb 66                	jmp    80152e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014cb:	8b 00                	mov    (%eax),%eax
  8014cd:	8d 48 01             	lea    0x1(%eax),%ecx
  8014d0:	8b 55 14             	mov    0x14(%ebp),%edx
  8014d3:	89 0a                	mov    %ecx,(%edx)
  8014d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014df:	01 c2                	add    %eax,%edx
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014e6:	eb 03                	jmp    8014eb <strsplit+0x8f>
			string++;
  8014e8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	84 c0                	test   %al,%al
  8014f2:	74 8b                	je     80147f <strsplit+0x23>
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	0f be c0             	movsbl %al,%eax
  8014fc:	50                   	push   %eax
  8014fd:	ff 75 0c             	pushl  0xc(%ebp)
  801500:	e8 25 fa ff ff       	call   800f2a <strchr>
  801505:	83 c4 08             	add    $0x8,%esp
  801508:	85 c0                	test   %eax,%eax
  80150a:	74 dc                	je     8014e8 <strsplit+0x8c>
			string++;
	}
  80150c:	e9 6e ff ff ff       	jmp    80147f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801511:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801512:	8b 45 14             	mov    0x14(%ebp),%eax
  801515:	8b 00                	mov    (%eax),%eax
  801517:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80151e:	8b 45 10             	mov    0x10(%ebp),%eax
  801521:	01 d0                	add    %edx,%eax
  801523:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801529:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80153c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801543:	eb 4a                	jmp    80158f <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801545:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	01 c2                	add    %eax,%edx
  80154d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801550:	8b 45 0c             	mov    0xc(%ebp),%eax
  801553:	01 c8                	add    %ecx,%eax
  801555:	8a 00                	mov    (%eax),%al
  801557:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801559:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155f:	01 d0                	add    %edx,%eax
  801561:	8a 00                	mov    (%eax),%al
  801563:	3c 40                	cmp    $0x40,%al
  801565:	7e 25                	jle    80158c <str2lower+0x5c>
  801567:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156d:	01 d0                	add    %edx,%eax
  80156f:	8a 00                	mov    (%eax),%al
  801571:	3c 5a                	cmp    $0x5a,%al
  801573:	7f 17                	jg     80158c <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801575:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	01 d0                	add    %edx,%eax
  80157d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801580:	8b 55 08             	mov    0x8(%ebp),%edx
  801583:	01 ca                	add    %ecx,%edx
  801585:	8a 12                	mov    (%edx),%dl
  801587:	83 c2 20             	add    $0x20,%edx
  80158a:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80158c:	ff 45 fc             	incl   -0x4(%ebp)
  80158f:	ff 75 0c             	pushl  0xc(%ebp)
  801592:	e8 01 f8 ff ff       	call   800d98 <strlen>
  801597:	83 c4 04             	add    $0x4,%esp
  80159a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80159d:	7f a6                	jg     801545 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80159f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
  8015a7:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8015aa:	a1 08 30 80 00       	mov    0x803008,%eax
  8015af:	85 c0                	test   %eax,%eax
  8015b1:	74 2d                	je     8015e0 <uheap_init+0x3c>
	{
		buddy_init();
  8015b3:	e8 87 06 00 00       	call   801c3f <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8015b8:	e8 31 05 00 00       	call   801aee <sys_get_uheap_strategy>
  8015bd:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  8015c2:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8015c9:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8015cc:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8015d3:	00 00 80 
		__firstTimeFlag = 0;
  8015d6:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  8015dd:	00 00 00 
	}
}
  8015e0:	90                   	nop
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  8015e9:	83 ec 04             	sub    $0x4,%esp
  8015ec:	68 dc 27 80 00       	push   $0x8027dc
  8015f1:	6a 25                	push   $0x25
  8015f3:	68 0d 28 80 00       	push   $0x80280d
  8015f8:	e8 76 07 00 00       	call   801d73 <_panic>

008015fd <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
  801600:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801603:	83 ec 04             	sub    $0x4,%esp
  801606:	68 1c 28 80 00       	push   $0x80281c
  80160b:	6a 2f                	push   $0x2f
  80160d:	68 0d 28 80 00       	push   $0x80280d
  801612:	e8 5c 07 00 00       	call   801d73 <_panic>

00801617 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
  80161a:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80161d:	e8 82 ff ff ff       	call   8015a4 <uheap_init>
	if (size == 0) return NULL ;
  801622:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801626:	75 07                	jne    80162f <malloc+0x18>
  801628:	b8 00 00 00 00       	mov    $0x0,%eax
  80162d:	eb 14                	jmp    801643 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  80162f:	83 ec 04             	sub    $0x4,%esp
  801632:	68 50 28 80 00       	push   $0x802850
  801637:	6a 43                	push   $0x43
  801639:	68 0d 28 80 00       	push   $0x80280d
  80163e:	e8 30 07 00 00       	call   801d73 <_panic>
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
  801648:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  80164b:	83 ec 04             	sub    $0x4,%esp
  80164e:	68 78 28 80 00       	push   $0x802878
  801653:	6a 4e                	push   $0x4e
  801655:	68 0d 28 80 00       	push   $0x80280d
  80165a:	e8 14 07 00 00       	call   801d73 <_panic>

0080165f <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
  801662:	83 ec 18             	sub    $0x18,%esp
  801665:	8b 45 10             	mov    0x10(%ebp),%eax
  801668:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80166b:	e8 34 ff ff ff       	call   8015a4 <uheap_init>
	if (size == 0) return NULL ;
  801670:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801674:	75 07                	jne    80167d <smalloc+0x1e>
  801676:	b8 00 00 00 00       	mov    $0x0,%eax
  80167b:	eb 14                	jmp    801691 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  80167d:	83 ec 04             	sub    $0x4,%esp
  801680:	68 9c 28 80 00       	push   $0x80289c
  801685:	6a 5f                	push   $0x5f
  801687:	68 0d 28 80 00       	push   $0x80280d
  80168c:	e8 e2 06 00 00       	call   801d73 <_panic>
}
  801691:	c9                   	leave  
  801692:	c3                   	ret    

00801693 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
  801696:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801699:	e8 06 ff ff ff       	call   8015a4 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  80169e:	83 ec 04             	sub    $0x4,%esp
  8016a1:	68 c4 28 80 00       	push   $0x8028c4
  8016a6:	6a 6f                	push   $0x6f
  8016a8:	68 0d 28 80 00       	push   $0x80280d
  8016ad:	e8 c1 06 00 00       	call   801d73 <_panic>

008016b2 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
  8016b5:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8016b8:	83 ec 04             	sub    $0x4,%esp
  8016bb:	68 e8 28 80 00       	push   $0x8028e8
  8016c0:	6a 7e                	push   $0x7e
  8016c2:	68 0d 28 80 00       	push   $0x80280d
  8016c7:	e8 a7 06 00 00       	call   801d73 <_panic>

008016cc <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	57                   	push   %edi
  8016d0:	56                   	push   %esi
  8016d1:	53                   	push   %ebx
  8016d2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016de:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016e4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016e7:	cd 30                	int    $0x30
  8016e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ef:	83 c4 10             	add    $0x10,%esp
  8016f2:	5b                   	pop    %ebx
  8016f3:	5e                   	pop    %esi
  8016f4:	5f                   	pop    %edi
  8016f5:	5d                   	pop    %ebp
  8016f6:	c3                   	ret    

008016f7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
  8016fa:	83 ec 04             	sub    $0x4,%esp
  8016fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801700:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801703:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801706:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	6a 00                	push   $0x0
  80170f:	51                   	push   %ecx
  801710:	52                   	push   %edx
  801711:	ff 75 0c             	pushl  0xc(%ebp)
  801714:	50                   	push   %eax
  801715:	6a 00                	push   $0x0
  801717:	e8 b0 ff ff ff       	call   8016cc <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	90                   	nop
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_cgetc>:

int
sys_cgetc(void)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 02                	push   $0x2
  801731:	e8 96 ff ff ff       	call   8016cc <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_lock_cons>:

void sys_lock_cons(void)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 03                	push   $0x3
  80174a:	e8 7d ff ff ff       	call   8016cc <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
}
  801752:	90                   	nop
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 04                	push   $0x4
  801764:	e8 63 ff ff ff       	call   8016cc <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	90                   	nop
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801772:	8b 55 0c             	mov    0xc(%ebp),%edx
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	52                   	push   %edx
  80177f:	50                   	push   %eax
  801780:	6a 08                	push   $0x8
  801782:	e8 45 ff ff ff       	call   8016cc <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	56                   	push   %esi
  801790:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801791:	8b 75 18             	mov    0x18(%ebp),%esi
  801794:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801797:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80179a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	56                   	push   %esi
  8017a1:	53                   	push   %ebx
  8017a2:	51                   	push   %ecx
  8017a3:	52                   	push   %edx
  8017a4:	50                   	push   %eax
  8017a5:	6a 09                	push   $0x9
  8017a7:	e8 20 ff ff ff       	call   8016cc <syscall>
  8017ac:	83 c4 18             	add    $0x18,%esp
}
  8017af:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017b2:	5b                   	pop    %ebx
  8017b3:	5e                   	pop    %esi
  8017b4:	5d                   	pop    %ebp
  8017b5:	c3                   	ret    

008017b6 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	ff 75 08             	pushl  0x8(%ebp)
  8017c4:	6a 0a                	push   $0xa
  8017c6:	e8 01 ff ff ff       	call   8016cc <syscall>
  8017cb:	83 c4 18             	add    $0x18,%esp
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	ff 75 0c             	pushl  0xc(%ebp)
  8017dc:	ff 75 08             	pushl  0x8(%ebp)
  8017df:	6a 0b                	push   $0xb
  8017e1:	e8 e6 fe ff ff       	call   8016cc <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 0c                	push   $0xc
  8017fa:	e8 cd fe ff ff       	call   8016cc <syscall>
  8017ff:	83 c4 18             	add    $0x18,%esp
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 0d                	push   $0xd
  801813:	e8 b4 fe ff ff       	call   8016cc <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
}
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 0e                	push   $0xe
  80182c:	e8 9b fe ff ff       	call   8016cc <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 0f                	push   $0xf
  801845:	e8 82 fe ff ff       	call   8016cc <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	ff 75 08             	pushl  0x8(%ebp)
  80185d:	6a 10                	push   $0x10
  80185f:	e8 68 fe ff ff       	call   8016cc <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 11                	push   $0x11
  801878:	e8 4f fe ff ff       	call   8016cc <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
}
  801880:	90                   	nop
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <sys_cputc>:

void
sys_cputc(const char c)
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
  801886:	83 ec 04             	sub    $0x4,%esp
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80188f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	50                   	push   %eax
  80189c:	6a 01                	push   $0x1
  80189e:	e8 29 fe ff ff       	call   8016cc <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
}
  8018a6:	90                   	nop
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 14                	push   $0x14
  8018b8:	e8 0f fe ff ff       	call   8016cc <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	90                   	nop
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
  8018c6:	83 ec 04             	sub    $0x4,%esp
  8018c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018cf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018d2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	6a 00                	push   $0x0
  8018db:	51                   	push   %ecx
  8018dc:	52                   	push   %edx
  8018dd:	ff 75 0c             	pushl  0xc(%ebp)
  8018e0:	50                   	push   %eax
  8018e1:	6a 15                	push   $0x15
  8018e3:	e8 e4 fd ff ff       	call   8016cc <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018f0:	8b 55 10             	mov    0x10(%ebp),%edx
  8018f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	52                   	push   %edx
  8018fb:	50                   	push   %eax
  8018fc:	ff 75 08             	pushl  0x8(%ebp)
  8018ff:	6a 16                	push   $0x16
  801901:	e8 c6 fd ff ff       	call   8016cc <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80190e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	52                   	push   %edx
  80191b:	50                   	push   %eax
  80191c:	6a 17                	push   $0x17
  80191e:	e8 a9 fd ff ff       	call   8016cc <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80192b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	52                   	push   %edx
  801938:	50                   	push   %eax
  801939:	6a 18                	push   $0x18
  80193b:	e8 8c fd ff ff       	call   8016cc <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	6a 00                	push   $0x0
  80194d:	ff 75 14             	pushl  0x14(%ebp)
  801950:	ff 75 10             	pushl  0x10(%ebp)
  801953:	ff 75 0c             	pushl  0xc(%ebp)
  801956:	50                   	push   %eax
  801957:	6a 19                	push   $0x19
  801959:	e8 6e fd ff ff       	call   8016cc <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
}
  801961:	c9                   	leave  
  801962:	c3                   	ret    

00801963 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	50                   	push   %eax
  801972:	6a 1a                	push   $0x1a
  801974:	e8 53 fd ff ff       	call   8016cc <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	50                   	push   %eax
  80198e:	6a 1b                	push   $0x1b
  801990:	e8 37 fd ff ff       	call   8016cc <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 05                	push   $0x5
  8019a9:	e8 1e fd ff ff       	call   8016cc <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 06                	push   $0x6
  8019c2:	e8 05 fd ff ff       	call   8016cc <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
}
  8019ca:	c9                   	leave  
  8019cb:	c3                   	ret    

008019cc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019cc:	55                   	push   %ebp
  8019cd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 07                	push   $0x7
  8019db:	e8 ec fc ff ff       	call   8016cc <syscall>
  8019e0:	83 c4 18             	add    $0x18,%esp
}
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <sys_exit_env>:


void sys_exit_env(void)
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 1c                	push   $0x1c
  8019f4:	e8 d3 fc ff ff       	call   8016cc <syscall>
  8019f9:	83 c4 18             	add    $0x18,%esp
}
  8019fc:	90                   	nop
  8019fd:	c9                   	leave  
  8019fe:	c3                   	ret    

008019ff <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	ff 75 10             	pushl  0x10(%ebp)
  801a09:	ff 75 0c             	pushl  0xc(%ebp)
  801a0c:	ff 75 08             	pushl  0x8(%ebp)
  801a0f:	6a 13                	push   $0x13
  801a11:	e8 b6 fc ff ff       	call   8016cc <syscall>
  801a16:	83 c4 18             	add    $0x18,%esp
	return ;
  801a19:	90                   	nop
}
  801a1a:	c9                   	leave  
  801a1b:	c3                   	ret    

00801a1c <sys_rcr2>:
uint32 sys_rcr2()
{
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 1e                	push   $0x1e
  801a2b:	e8 9c fc ff ff       	call   8016cc <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
  801a38:	83 ec 04             	sub    $0x4,%esp
  801a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a41:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	50                   	push   %eax
  801a4e:	6a 1f                	push   $0x1f
  801a50:	e8 77 fc ff ff       	call   8016cc <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
	return ;
  801a58:	90                   	nop
}
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <rsttst>:
void rsttst()
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 21                	push   $0x21
  801a6a:	e8 5d fc ff ff       	call   8016cc <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a72:	90                   	nop
}
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
  801a78:	83 ec 04             	sub    $0x4,%esp
  801a7b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a81:	8b 55 18             	mov    0x18(%ebp),%edx
  801a84:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a88:	52                   	push   %edx
  801a89:	50                   	push   %eax
  801a8a:	ff 75 10             	pushl  0x10(%ebp)
  801a8d:	ff 75 0c             	pushl  0xc(%ebp)
  801a90:	ff 75 08             	pushl  0x8(%ebp)
  801a93:	6a 20                	push   $0x20
  801a95:	e8 32 fc ff ff       	call   8016cc <syscall>
  801a9a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a9d:	90                   	nop
}
  801a9e:	c9                   	leave  
  801a9f:	c3                   	ret    

00801aa0 <chktst>:
void chktst(uint32 n)
{
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	ff 75 08             	pushl  0x8(%ebp)
  801aae:	6a 22                	push   $0x22
  801ab0:	e8 17 fc ff ff       	call   8016cc <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab8:	90                   	nop
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <inctst>:

void inctst()
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 23                	push   $0x23
  801aca:	e8 fd fb ff ff       	call   8016cc <syscall>
  801acf:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad2:	90                   	nop
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <gettst>:
uint32 gettst()
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 24                	push   $0x24
  801ae4:	e8 e3 fb ff ff       	call   8016cc <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 25                	push   $0x25
  801afd:	e8 ca fb ff ff       	call   8016cc <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
  801b05:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801b0a:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801b0f:	c9                   	leave  
  801b10:	c3                   	ret    

00801b11 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b11:	55                   	push   %ebp
  801b12:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801b14:	8b 45 08             	mov    0x8(%ebp),%eax
  801b17:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	ff 75 08             	pushl  0x8(%ebp)
  801b27:	6a 26                	push   $0x26
  801b29:	e8 9e fb ff ff       	call   8016cc <syscall>
  801b2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b31:	90                   	nop
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
  801b37:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b38:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b41:	8b 45 08             	mov    0x8(%ebp),%eax
  801b44:	6a 00                	push   $0x0
  801b46:	53                   	push   %ebx
  801b47:	51                   	push   %ecx
  801b48:	52                   	push   %edx
  801b49:	50                   	push   %eax
  801b4a:	6a 27                	push   $0x27
  801b4c:	e8 7b fb ff ff       	call   8016cc <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
}
  801b54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	52                   	push   %edx
  801b69:	50                   	push   %eax
  801b6a:	6a 28                	push   $0x28
  801b6c:	e8 5b fb ff ff       	call   8016cc <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
}
  801b74:	c9                   	leave  
  801b75:	c3                   	ret    

00801b76 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b76:	55                   	push   %ebp
  801b77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b79:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	6a 00                	push   $0x0
  801b84:	51                   	push   %ecx
  801b85:	ff 75 10             	pushl  0x10(%ebp)
  801b88:	52                   	push   %edx
  801b89:	50                   	push   %eax
  801b8a:	6a 29                	push   $0x29
  801b8c:	e8 3b fb ff ff       	call   8016cc <syscall>
  801b91:	83 c4 18             	add    $0x18,%esp
}
  801b94:	c9                   	leave  
  801b95:	c3                   	ret    

00801b96 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b96:	55                   	push   %ebp
  801b97:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	ff 75 10             	pushl  0x10(%ebp)
  801ba0:	ff 75 0c             	pushl  0xc(%ebp)
  801ba3:	ff 75 08             	pushl  0x8(%ebp)
  801ba6:	6a 12                	push   $0x12
  801ba8:	e8 1f fb ff ff       	call   8016cc <syscall>
  801bad:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb0:	90                   	nop
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	52                   	push   %edx
  801bc3:	50                   	push   %eax
  801bc4:	6a 2a                	push   $0x2a
  801bc6:	e8 01 fb ff ff       	call   8016cc <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
	return;
  801bce:	90                   	nop
}
  801bcf:	c9                   	leave  
  801bd0:	c3                   	ret    

00801bd1 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bd1:	55                   	push   %ebp
  801bd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 2b                	push   $0x2b
  801be0:	e8 e7 fa ff ff       	call   8016cc <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
}
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
  801bed:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bf0:	83 ec 04             	sub    $0x4,%esp
  801bf3:	68 0c 29 80 00       	push   $0x80290c
  801bf8:	68 0a 01 00 00       	push   $0x10a
  801bfd:	68 1c 29 80 00       	push   $0x80291c
  801c02:	e8 6c 01 00 00       	call   801d73 <_panic>

00801c07 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	ff 75 0c             	pushl  0xc(%ebp)
  801c13:	ff 75 08             	pushl  0x8(%ebp)
  801c16:	6a 33                	push   $0x33
  801c18:	e8 af fa ff ff       	call   8016cc <syscall>
  801c1d:	83 c4 18             	add    $0x18,%esp
	return;
  801c20:	90                   	nop
}
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	ff 75 0c             	pushl  0xc(%ebp)
  801c2f:	ff 75 08             	pushl  0x8(%ebp)
  801c32:	6a 34                	push   $0x34
  801c34:	e8 93 fa ff ff       	call   8016cc <syscall>
  801c39:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3c:	90                   	nop
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
  801c42:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c45:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801c4c:	eb 36                	jmp    801c84 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801c4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c51:	c1 e0 04             	shl    $0x4,%eax
  801c54:	05 60 30 80 00       	add    $0x803060,%eax
  801c59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c62:	c1 e0 04             	shl    $0x4,%eax
  801c65:	05 64 30 80 00       	add    $0x803064,%eax
  801c6a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c73:	c1 e0 04             	shl    $0x4,%eax
  801c76:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c7b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c81:	ff 45 fc             	incl   -0x4(%ebp)
  801c84:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801c88:	7e c4                	jle    801c4e <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801c8a:	90                   	nop
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
  801c90:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c93:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801c9a:	eb 24                	jmp    801cc0 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c9f:	c1 e0 04             	shl    $0x4,%eax
  801ca2:	05 6c 30 80 00       	add    $0x80306c,%eax
  801ca7:	8b 00                	mov    (%eax),%eax
  801ca9:	83 ec 04             	sub    $0x4,%esp
  801cac:	50                   	push   %eax
  801cad:	ff 75 f4             	pushl  -0xc(%ebp)
  801cb0:	68 2c 29 80 00       	push   $0x80292c
  801cb5:	e8 fd e7 ff ff       	call   8004b7 <cprintf>
  801cba:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801cbd:	ff 45 f4             	incl   -0xc(%ebp)
  801cc0:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801cc4:	7e d6                	jle    801c9c <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801cc6:	90                   	nop
  801cc7:	c9                   	leave  
  801cc8:	c3                   	ret    

00801cc9 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801cc9:	55                   	push   %ebp
  801cca:	89 e5                	mov    %esp,%ebp
  801ccc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801ccf:	83 ec 04             	sub    $0x4,%esp
  801cd2:	68 3c 29 80 00       	push   $0x80293c
  801cd7:	6a 33                	push   $0x33
  801cd9:	68 5d 29 80 00       	push   $0x80295d
  801cde:	e8 90 00 00 00       	call   801d73 <_panic>

00801ce3 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
  801ce6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801ce9:	83 ec 04             	sub    $0x4,%esp
  801cec:	68 75 29 80 00       	push   $0x802975
  801cf1:	6a 3e                	push   $0x3e
  801cf3:	68 5d 29 80 00       	push   $0x80295d
  801cf8:	e8 76 00 00 00       	call   801d73 <_panic>

00801cfd <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
  801d00:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801d03:	83 ec 04             	sub    $0x4,%esp
  801d06:	68 93 29 80 00       	push   $0x802993
  801d0b:	6a 49                	push   $0x49
  801d0d:	68 5d 29 80 00       	push   $0x80295d
  801d12:	e8 5c 00 00 00       	call   801d73 <_panic>

00801d17 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
  801d1a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801d1d:	83 ec 04             	sub    $0x4,%esp
  801d20:	68 b0 29 80 00       	push   $0x8029b0
  801d25:	6a 58                	push   $0x58
  801d27:	68 5d 29 80 00       	push   $0x80295d
  801d2c:	e8 42 00 00 00       	call   801d73 <_panic>

00801d31 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801d31:	55                   	push   %ebp
  801d32:	89 e5                	mov    %esp,%ebp
  801d34:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801d37:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3a:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801d3d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801d41:	83 ec 0c             	sub    $0xc,%esp
  801d44:	50                   	push   %eax
  801d45:	e8 39 fb ff ff       	call   801883 <sys_cputc>
  801d4a:	83 c4 10             	add    $0x10,%esp
}
  801d4d:	90                   	nop
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <getchar>:


int
getchar(void)
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
  801d53:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  801d56:	e8 c7 f9 ff ff       	call   801722 <sys_cgetc>
  801d5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801d5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801d62:	74 f2                	je     801d56 <getchar+0x6>
	return c;
  801d64:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <iscons>:

int iscons(int fdnum)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801d6c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d71:	5d                   	pop    %ebp
  801d72:	c3                   	ret    

00801d73 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801d73:	55                   	push   %ebp
  801d74:	89 e5                	mov    %esp,%ebp
  801d76:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801d79:	8d 45 10             	lea    0x10(%ebp),%eax
  801d7c:	83 c0 04             	add    $0x4,%eax
  801d7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d82:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801d87:	85 c0                	test   %eax,%eax
  801d89:	74 16                	je     801da1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801d8b:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801d90:	83 ec 08             	sub    $0x8,%esp
  801d93:	50                   	push   %eax
  801d94:	68 d4 29 80 00       	push   $0x8029d4
  801d99:	e8 19 e7 ff ff       	call   8004b7 <cprintf>
  801d9e:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801da1:	a1 04 30 80 00       	mov    0x803004,%eax
  801da6:	83 ec 0c             	sub    $0xc,%esp
  801da9:	ff 75 0c             	pushl  0xc(%ebp)
  801dac:	ff 75 08             	pushl  0x8(%ebp)
  801daf:	50                   	push   %eax
  801db0:	68 dc 29 80 00       	push   $0x8029dc
  801db5:	6a 74                	push   $0x74
  801db7:	e8 28 e7 ff ff       	call   8004e4 <cprintf_colored>
  801dbc:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801dbf:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc2:	83 ec 08             	sub    $0x8,%esp
  801dc5:	ff 75 f4             	pushl  -0xc(%ebp)
  801dc8:	50                   	push   %eax
  801dc9:	e8 7a e6 ff ff       	call   800448 <vcprintf>
  801dce:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801dd1:	83 ec 08             	sub    $0x8,%esp
  801dd4:	6a 00                	push   $0x0
  801dd6:	68 04 2a 80 00       	push   $0x802a04
  801ddb:	e8 68 e6 ff ff       	call   800448 <vcprintf>
  801de0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801de3:	e8 e1 e5 ff ff       	call   8003c9 <exit>

	// should not return here
	while (1) ;
  801de8:	eb fe                	jmp    801de8 <_panic+0x75>

00801dea <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
  801ded:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801df0:	a1 20 30 80 00       	mov    0x803020,%eax
  801df5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dfe:	39 c2                	cmp    %eax,%edx
  801e00:	74 14                	je     801e16 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801e02:	83 ec 04             	sub    $0x4,%esp
  801e05:	68 08 2a 80 00       	push   $0x802a08
  801e0a:	6a 26                	push   $0x26
  801e0c:	68 54 2a 80 00       	push   $0x802a54
  801e11:	e8 5d ff ff ff       	call   801d73 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801e16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801e1d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e24:	e9 c5 00 00 00       	jmp    801eee <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801e29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e33:	8b 45 08             	mov    0x8(%ebp),%eax
  801e36:	01 d0                	add    %edx,%eax
  801e38:	8b 00                	mov    (%eax),%eax
  801e3a:	85 c0                	test   %eax,%eax
  801e3c:	75 08                	jne    801e46 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801e3e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801e41:	e9 a5 00 00 00       	jmp    801eeb <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801e46:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e4d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e54:	eb 69                	jmp    801ebf <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e56:	a1 20 30 80 00       	mov    0x803020,%eax
  801e5b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801e61:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e64:	89 d0                	mov    %edx,%eax
  801e66:	01 c0                	add    %eax,%eax
  801e68:	01 d0                	add    %edx,%eax
  801e6a:	c1 e0 03             	shl    $0x3,%eax
  801e6d:	01 c8                	add    %ecx,%eax
  801e6f:	8a 40 04             	mov    0x4(%eax),%al
  801e72:	84 c0                	test   %al,%al
  801e74:	75 46                	jne    801ebc <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e76:	a1 20 30 80 00       	mov    0x803020,%eax
  801e7b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801e81:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e84:	89 d0                	mov    %edx,%eax
  801e86:	01 c0                	add    %eax,%eax
  801e88:	01 d0                	add    %edx,%eax
  801e8a:	c1 e0 03             	shl    $0x3,%eax
  801e8d:	01 c8                	add    %ecx,%eax
  801e8f:	8b 00                	mov    (%eax),%eax
  801e91:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e94:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e97:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e9c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801e9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ea1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eab:	01 c8                	add    %ecx,%eax
  801ead:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801eaf:	39 c2                	cmp    %eax,%edx
  801eb1:	75 09                	jne    801ebc <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801eb3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801eba:	eb 15                	jmp    801ed1 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ebc:	ff 45 e8             	incl   -0x18(%ebp)
  801ebf:	a1 20 30 80 00       	mov    0x803020,%eax
  801ec4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801eca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ecd:	39 c2                	cmp    %eax,%edx
  801ecf:	77 85                	ja     801e56 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801ed1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ed5:	75 14                	jne    801eeb <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801ed7:	83 ec 04             	sub    $0x4,%esp
  801eda:	68 60 2a 80 00       	push   $0x802a60
  801edf:	6a 3a                	push   $0x3a
  801ee1:	68 54 2a 80 00       	push   $0x802a54
  801ee6:	e8 88 fe ff ff       	call   801d73 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801eeb:	ff 45 f0             	incl   -0x10(%ebp)
  801eee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ef1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ef4:	0f 8c 2f ff ff ff    	jl     801e29 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801efa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f01:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801f08:	eb 26                	jmp    801f30 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801f0a:	a1 20 30 80 00       	mov    0x803020,%eax
  801f0f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801f15:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f18:	89 d0                	mov    %edx,%eax
  801f1a:	01 c0                	add    %eax,%eax
  801f1c:	01 d0                	add    %edx,%eax
  801f1e:	c1 e0 03             	shl    $0x3,%eax
  801f21:	01 c8                	add    %ecx,%eax
  801f23:	8a 40 04             	mov    0x4(%eax),%al
  801f26:	3c 01                	cmp    $0x1,%al
  801f28:	75 03                	jne    801f2d <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801f2a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f2d:	ff 45 e0             	incl   -0x20(%ebp)
  801f30:	a1 20 30 80 00       	mov    0x803020,%eax
  801f35:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801f3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f3e:	39 c2                	cmp    %eax,%edx
  801f40:	77 c8                	ja     801f0a <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801f42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f45:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801f48:	74 14                	je     801f5e <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801f4a:	83 ec 04             	sub    $0x4,%esp
  801f4d:	68 b4 2a 80 00       	push   $0x802ab4
  801f52:	6a 44                	push   $0x44
  801f54:	68 54 2a 80 00       	push   $0x802a54
  801f59:	e8 15 fe ff ff       	call   801d73 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f5e:	90                   	nop
  801f5f:	c9                   	leave  
  801f60:	c3                   	ret    
  801f61:	66 90                	xchg   %ax,%ax
  801f63:	90                   	nop

00801f64 <__udivdi3>:
  801f64:	55                   	push   %ebp
  801f65:	57                   	push   %edi
  801f66:	56                   	push   %esi
  801f67:	53                   	push   %ebx
  801f68:	83 ec 1c             	sub    $0x1c,%esp
  801f6b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f6f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f7b:	89 ca                	mov    %ecx,%edx
  801f7d:	89 f8                	mov    %edi,%eax
  801f7f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f83:	85 f6                	test   %esi,%esi
  801f85:	75 2d                	jne    801fb4 <__udivdi3+0x50>
  801f87:	39 cf                	cmp    %ecx,%edi
  801f89:	77 65                	ja     801ff0 <__udivdi3+0x8c>
  801f8b:	89 fd                	mov    %edi,%ebp
  801f8d:	85 ff                	test   %edi,%edi
  801f8f:	75 0b                	jne    801f9c <__udivdi3+0x38>
  801f91:	b8 01 00 00 00       	mov    $0x1,%eax
  801f96:	31 d2                	xor    %edx,%edx
  801f98:	f7 f7                	div    %edi
  801f9a:	89 c5                	mov    %eax,%ebp
  801f9c:	31 d2                	xor    %edx,%edx
  801f9e:	89 c8                	mov    %ecx,%eax
  801fa0:	f7 f5                	div    %ebp
  801fa2:	89 c1                	mov    %eax,%ecx
  801fa4:	89 d8                	mov    %ebx,%eax
  801fa6:	f7 f5                	div    %ebp
  801fa8:	89 cf                	mov    %ecx,%edi
  801faa:	89 fa                	mov    %edi,%edx
  801fac:	83 c4 1c             	add    $0x1c,%esp
  801faf:	5b                   	pop    %ebx
  801fb0:	5e                   	pop    %esi
  801fb1:	5f                   	pop    %edi
  801fb2:	5d                   	pop    %ebp
  801fb3:	c3                   	ret    
  801fb4:	39 ce                	cmp    %ecx,%esi
  801fb6:	77 28                	ja     801fe0 <__udivdi3+0x7c>
  801fb8:	0f bd fe             	bsr    %esi,%edi
  801fbb:	83 f7 1f             	xor    $0x1f,%edi
  801fbe:	75 40                	jne    802000 <__udivdi3+0x9c>
  801fc0:	39 ce                	cmp    %ecx,%esi
  801fc2:	72 0a                	jb     801fce <__udivdi3+0x6a>
  801fc4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fc8:	0f 87 9e 00 00 00    	ja     80206c <__udivdi3+0x108>
  801fce:	b8 01 00 00 00       	mov    $0x1,%eax
  801fd3:	89 fa                	mov    %edi,%edx
  801fd5:	83 c4 1c             	add    $0x1c,%esp
  801fd8:	5b                   	pop    %ebx
  801fd9:	5e                   	pop    %esi
  801fda:	5f                   	pop    %edi
  801fdb:	5d                   	pop    %ebp
  801fdc:	c3                   	ret    
  801fdd:	8d 76 00             	lea    0x0(%esi),%esi
  801fe0:	31 ff                	xor    %edi,%edi
  801fe2:	31 c0                	xor    %eax,%eax
  801fe4:	89 fa                	mov    %edi,%edx
  801fe6:	83 c4 1c             	add    $0x1c,%esp
  801fe9:	5b                   	pop    %ebx
  801fea:	5e                   	pop    %esi
  801feb:	5f                   	pop    %edi
  801fec:	5d                   	pop    %ebp
  801fed:	c3                   	ret    
  801fee:	66 90                	xchg   %ax,%ax
  801ff0:	89 d8                	mov    %ebx,%eax
  801ff2:	f7 f7                	div    %edi
  801ff4:	31 ff                	xor    %edi,%edi
  801ff6:	89 fa                	mov    %edi,%edx
  801ff8:	83 c4 1c             	add    $0x1c,%esp
  801ffb:	5b                   	pop    %ebx
  801ffc:	5e                   	pop    %esi
  801ffd:	5f                   	pop    %edi
  801ffe:	5d                   	pop    %ebp
  801fff:	c3                   	ret    
  802000:	bd 20 00 00 00       	mov    $0x20,%ebp
  802005:	89 eb                	mov    %ebp,%ebx
  802007:	29 fb                	sub    %edi,%ebx
  802009:	89 f9                	mov    %edi,%ecx
  80200b:	d3 e6                	shl    %cl,%esi
  80200d:	89 c5                	mov    %eax,%ebp
  80200f:	88 d9                	mov    %bl,%cl
  802011:	d3 ed                	shr    %cl,%ebp
  802013:	89 e9                	mov    %ebp,%ecx
  802015:	09 f1                	or     %esi,%ecx
  802017:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80201b:	89 f9                	mov    %edi,%ecx
  80201d:	d3 e0                	shl    %cl,%eax
  80201f:	89 c5                	mov    %eax,%ebp
  802021:	89 d6                	mov    %edx,%esi
  802023:	88 d9                	mov    %bl,%cl
  802025:	d3 ee                	shr    %cl,%esi
  802027:	89 f9                	mov    %edi,%ecx
  802029:	d3 e2                	shl    %cl,%edx
  80202b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80202f:	88 d9                	mov    %bl,%cl
  802031:	d3 e8                	shr    %cl,%eax
  802033:	09 c2                	or     %eax,%edx
  802035:	89 d0                	mov    %edx,%eax
  802037:	89 f2                	mov    %esi,%edx
  802039:	f7 74 24 0c          	divl   0xc(%esp)
  80203d:	89 d6                	mov    %edx,%esi
  80203f:	89 c3                	mov    %eax,%ebx
  802041:	f7 e5                	mul    %ebp
  802043:	39 d6                	cmp    %edx,%esi
  802045:	72 19                	jb     802060 <__udivdi3+0xfc>
  802047:	74 0b                	je     802054 <__udivdi3+0xf0>
  802049:	89 d8                	mov    %ebx,%eax
  80204b:	31 ff                	xor    %edi,%edi
  80204d:	e9 58 ff ff ff       	jmp    801faa <__udivdi3+0x46>
  802052:	66 90                	xchg   %ax,%ax
  802054:	8b 54 24 08          	mov    0x8(%esp),%edx
  802058:	89 f9                	mov    %edi,%ecx
  80205a:	d3 e2                	shl    %cl,%edx
  80205c:	39 c2                	cmp    %eax,%edx
  80205e:	73 e9                	jae    802049 <__udivdi3+0xe5>
  802060:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802063:	31 ff                	xor    %edi,%edi
  802065:	e9 40 ff ff ff       	jmp    801faa <__udivdi3+0x46>
  80206a:	66 90                	xchg   %ax,%ax
  80206c:	31 c0                	xor    %eax,%eax
  80206e:	e9 37 ff ff ff       	jmp    801faa <__udivdi3+0x46>
  802073:	90                   	nop

00802074 <__umoddi3>:
  802074:	55                   	push   %ebp
  802075:	57                   	push   %edi
  802076:	56                   	push   %esi
  802077:	53                   	push   %ebx
  802078:	83 ec 1c             	sub    $0x1c,%esp
  80207b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80207f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802083:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802087:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80208b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80208f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802093:	89 f3                	mov    %esi,%ebx
  802095:	89 fa                	mov    %edi,%edx
  802097:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80209b:	89 34 24             	mov    %esi,(%esp)
  80209e:	85 c0                	test   %eax,%eax
  8020a0:	75 1a                	jne    8020bc <__umoddi3+0x48>
  8020a2:	39 f7                	cmp    %esi,%edi
  8020a4:	0f 86 a2 00 00 00    	jbe    80214c <__umoddi3+0xd8>
  8020aa:	89 c8                	mov    %ecx,%eax
  8020ac:	89 f2                	mov    %esi,%edx
  8020ae:	f7 f7                	div    %edi
  8020b0:	89 d0                	mov    %edx,%eax
  8020b2:	31 d2                	xor    %edx,%edx
  8020b4:	83 c4 1c             	add    $0x1c,%esp
  8020b7:	5b                   	pop    %ebx
  8020b8:	5e                   	pop    %esi
  8020b9:	5f                   	pop    %edi
  8020ba:	5d                   	pop    %ebp
  8020bb:	c3                   	ret    
  8020bc:	39 f0                	cmp    %esi,%eax
  8020be:	0f 87 ac 00 00 00    	ja     802170 <__umoddi3+0xfc>
  8020c4:	0f bd e8             	bsr    %eax,%ebp
  8020c7:	83 f5 1f             	xor    $0x1f,%ebp
  8020ca:	0f 84 ac 00 00 00    	je     80217c <__umoddi3+0x108>
  8020d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8020d5:	29 ef                	sub    %ebp,%edi
  8020d7:	89 fe                	mov    %edi,%esi
  8020d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020dd:	89 e9                	mov    %ebp,%ecx
  8020df:	d3 e0                	shl    %cl,%eax
  8020e1:	89 d7                	mov    %edx,%edi
  8020e3:	89 f1                	mov    %esi,%ecx
  8020e5:	d3 ef                	shr    %cl,%edi
  8020e7:	09 c7                	or     %eax,%edi
  8020e9:	89 e9                	mov    %ebp,%ecx
  8020eb:	d3 e2                	shl    %cl,%edx
  8020ed:	89 14 24             	mov    %edx,(%esp)
  8020f0:	89 d8                	mov    %ebx,%eax
  8020f2:	d3 e0                	shl    %cl,%eax
  8020f4:	89 c2                	mov    %eax,%edx
  8020f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020fa:	d3 e0                	shl    %cl,%eax
  8020fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802100:	8b 44 24 08          	mov    0x8(%esp),%eax
  802104:	89 f1                	mov    %esi,%ecx
  802106:	d3 e8                	shr    %cl,%eax
  802108:	09 d0                	or     %edx,%eax
  80210a:	d3 eb                	shr    %cl,%ebx
  80210c:	89 da                	mov    %ebx,%edx
  80210e:	f7 f7                	div    %edi
  802110:	89 d3                	mov    %edx,%ebx
  802112:	f7 24 24             	mull   (%esp)
  802115:	89 c6                	mov    %eax,%esi
  802117:	89 d1                	mov    %edx,%ecx
  802119:	39 d3                	cmp    %edx,%ebx
  80211b:	0f 82 87 00 00 00    	jb     8021a8 <__umoddi3+0x134>
  802121:	0f 84 91 00 00 00    	je     8021b8 <__umoddi3+0x144>
  802127:	8b 54 24 04          	mov    0x4(%esp),%edx
  80212b:	29 f2                	sub    %esi,%edx
  80212d:	19 cb                	sbb    %ecx,%ebx
  80212f:	89 d8                	mov    %ebx,%eax
  802131:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802135:	d3 e0                	shl    %cl,%eax
  802137:	89 e9                	mov    %ebp,%ecx
  802139:	d3 ea                	shr    %cl,%edx
  80213b:	09 d0                	or     %edx,%eax
  80213d:	89 e9                	mov    %ebp,%ecx
  80213f:	d3 eb                	shr    %cl,%ebx
  802141:	89 da                	mov    %ebx,%edx
  802143:	83 c4 1c             	add    $0x1c,%esp
  802146:	5b                   	pop    %ebx
  802147:	5e                   	pop    %esi
  802148:	5f                   	pop    %edi
  802149:	5d                   	pop    %ebp
  80214a:	c3                   	ret    
  80214b:	90                   	nop
  80214c:	89 fd                	mov    %edi,%ebp
  80214e:	85 ff                	test   %edi,%edi
  802150:	75 0b                	jne    80215d <__umoddi3+0xe9>
  802152:	b8 01 00 00 00       	mov    $0x1,%eax
  802157:	31 d2                	xor    %edx,%edx
  802159:	f7 f7                	div    %edi
  80215b:	89 c5                	mov    %eax,%ebp
  80215d:	89 f0                	mov    %esi,%eax
  80215f:	31 d2                	xor    %edx,%edx
  802161:	f7 f5                	div    %ebp
  802163:	89 c8                	mov    %ecx,%eax
  802165:	f7 f5                	div    %ebp
  802167:	89 d0                	mov    %edx,%eax
  802169:	e9 44 ff ff ff       	jmp    8020b2 <__umoddi3+0x3e>
  80216e:	66 90                	xchg   %ax,%ax
  802170:	89 c8                	mov    %ecx,%eax
  802172:	89 f2                	mov    %esi,%edx
  802174:	83 c4 1c             	add    $0x1c,%esp
  802177:	5b                   	pop    %ebx
  802178:	5e                   	pop    %esi
  802179:	5f                   	pop    %edi
  80217a:	5d                   	pop    %ebp
  80217b:	c3                   	ret    
  80217c:	3b 04 24             	cmp    (%esp),%eax
  80217f:	72 06                	jb     802187 <__umoddi3+0x113>
  802181:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802185:	77 0f                	ja     802196 <__umoddi3+0x122>
  802187:	89 f2                	mov    %esi,%edx
  802189:	29 f9                	sub    %edi,%ecx
  80218b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80218f:	89 14 24             	mov    %edx,(%esp)
  802192:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802196:	8b 44 24 04          	mov    0x4(%esp),%eax
  80219a:	8b 14 24             	mov    (%esp),%edx
  80219d:	83 c4 1c             	add    $0x1c,%esp
  8021a0:	5b                   	pop    %ebx
  8021a1:	5e                   	pop    %esi
  8021a2:	5f                   	pop    %edi
  8021a3:	5d                   	pop    %ebp
  8021a4:	c3                   	ret    
  8021a5:	8d 76 00             	lea    0x0(%esi),%esi
  8021a8:	2b 04 24             	sub    (%esp),%eax
  8021ab:	19 fa                	sbb    %edi,%edx
  8021ad:	89 d1                	mov    %edx,%ecx
  8021af:	89 c6                	mov    %eax,%esi
  8021b1:	e9 71 ff ff ff       	jmp    802127 <__umoddi3+0xb3>
  8021b6:	66 90                	xchg   %ax,%ax
  8021b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021bc:	72 ea                	jb     8021a8 <__umoddi3+0x134>
  8021be:	89 d9                	mov    %ebx,%ecx
  8021c0:	e9 62 ff ff ff       	jmp    802127 <__umoddi3+0xb3>
