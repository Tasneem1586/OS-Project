
obj/user/tst_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 1c 00 00 00       	call   800052 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	panic("Not Implemented");
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	68 40 1c 80 00       	push   $0x801c40
  800046:	6a 05                	push   $0x5
  800048:	68 50 1c 80 00       	push   $0x801c50
  80004d:	e8 60 02 00 00       	call   8002b2 <_panic>

00800052 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800052:	55                   	push   %ebp
  800053:	89 e5                	mov    %esp,%ebp
  800055:	57                   	push   %edi
  800056:	56                   	push   %esi
  800057:	53                   	push   %ebx
  800058:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80005e:	e8 e9 16 00 00       	call   80174c <sys_getenvindex>
  800063:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800066:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800069:	89 d0                	mov    %edx,%eax
  80006b:	c1 e0 03             	shl    $0x3,%eax
  80006e:	01 d0                	add    %edx,%eax
  800070:	c1 e0 06             	shl    $0x6,%eax
  800073:	01 d0                	add    %edx,%eax
  800075:	c1 e0 03             	shl    $0x3,%eax
  800078:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80007d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800082:	a1 20 30 80 00       	mov    0x803020,%eax
  800087:	8a 40 10             	mov    0x10(%eax),%al
  80008a:	84 c0                	test   %al,%al
  80008c:	74 0d                	je     80009b <libmain+0x49>
		binaryname = myEnv->prog_name;
  80008e:	a1 20 30 80 00       	mov    0x803020,%eax
  800093:	83 c0 10             	add    $0x10,%eax
  800096:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80009b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80009f:	7e 0a                	jle    8000ab <libmain+0x59>
		binaryname = argv[0];
  8000a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a4:	8b 00                	mov    (%eax),%eax
  8000a6:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000ab:	83 ec 08             	sub    $0x8,%esp
  8000ae:	ff 75 0c             	pushl  0xc(%ebp)
  8000b1:	ff 75 08             	pushl  0x8(%ebp)
  8000b4:	e8 7f ff ff ff       	call   800038 <_main>
  8000b9:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000bc:	a1 00 30 80 00       	mov    0x803000,%eax
  8000c1:	85 c0                	test   %eax,%eax
  8000c3:	0f 84 b7 01 00 00    	je     800280 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000c9:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000cf:	bb ac 1d 80 00       	mov    $0x801dac,%ebx
  8000d4:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000d9:	89 c7                	mov    %eax,%edi
  8000db:	89 de                	mov    %ebx,%esi
  8000dd:	89 d1                	mov    %edx,%ecx
  8000df:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000e1:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8000e7:	b9 56 00 00 00       	mov    $0x56,%ecx
  8000ec:	b0 00                	mov    $0x0,%al
  8000ee:	89 d7                	mov    %edx,%edi
  8000f0:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8000f2:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8000f9:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8000fc:	83 ec 08             	sub    $0x8,%esp
  8000ff:	50                   	push   %eax
  800100:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800106:	50                   	push   %eax
  800107:	e8 40 18 00 00       	call   80194c <sys_utilities>
  80010c:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80010f:	e8 c0 13 00 00       	call   8014d4 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 88 1c 80 00       	push   $0x801c88
  80011c:	e8 5f 04 00 00       	call   800580 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800124:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800127:	85 c0                	test   %eax,%eax
  800129:	74 58                	je     800183 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80012b:	e8 3a 18 00 00       	call   80196a <sys_get_optimal_num_faults>
  800130:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800133:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800139:	bb 10 1e 80 00       	mov    $0x801e10,%ebx
  80013e:	ba 11 00 00 00       	mov    $0x11,%edx
  800143:	89 c7                	mov    %eax,%edi
  800145:	89 de                	mov    %ebx,%esi
  800147:	89 d1                	mov    %edx,%ecx
  800149:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80014b:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80014e:	b9 53 00 00 00       	mov    $0x53,%ecx
  800153:	b0 00                	mov    $0x0,%al
  800155:	89 d7                	mov    %edx,%edi
  800157:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800159:	83 ec 08             	sub    $0x8,%esp
  80015c:	ff 75 dc             	pushl  -0x24(%ebp)
  80015f:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800165:	50                   	push   %eax
  800166:	e8 e1 17 00 00       	call   80194c <sys_utilities>
  80016b:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 dc             	pushl  -0x24(%ebp)
  800174:	68 b0 1c 80 00       	push   $0x801cb0
  800179:	e8 02 04 00 00       	call   800580 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	eb 59                	jmp    8001dc <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800183:	a1 20 30 80 00       	mov    0x803020,%eax
  800188:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80018e:	a1 20 30 80 00       	mov    0x803020,%eax
  800193:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	52                   	push   %edx
  80019d:	50                   	push   %eax
  80019e:	68 d4 1c 80 00       	push   $0x801cd4
  8001a3:	e8 d8 03 00 00       	call   800580 <cprintf>
  8001a8:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b0:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c6:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001cc:	51                   	push   %ecx
  8001cd:	52                   	push   %edx
  8001ce:	50                   	push   %eax
  8001cf:	68 fc 1c 80 00       	push   $0x801cfc
  8001d4:	e8 a7 03 00 00       	call   800580 <cprintf>
  8001d9:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e1:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	50                   	push   %eax
  8001eb:	68 54 1d 80 00       	push   $0x801d54
  8001f0:	e8 8b 03 00 00       	call   800580 <cprintf>
  8001f5:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8001f8:	83 ec 0c             	sub    $0xc,%esp
  8001fb:	68 68 1d 80 00       	push   $0x801d68
  800200:	e8 7b 03 00 00       	call   800580 <cprintf>
  800205:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800208:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80020f:	eb 28                	jmp    800239 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800219:	81 c2 74 04 00 00    	add    $0x474,%edx
  80021f:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	50                   	push   %eax
  800226:	ff 75 e4             	pushl  -0x1c(%ebp)
  800229:	68 7f 1d 80 00       	push   $0x801d7f
  80022e:	e8 4d 03 00 00       	call   800580 <cprintf>
  800233:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800236:	ff 45 e4             	incl   -0x1c(%ebp)
  800239:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80023d:	7e d2                	jle    800211 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80023f:	83 ec 0c             	sub    $0xc,%esp
  800242:	68 8e 1d 80 00       	push   $0x801d8e
  800247:	e8 34 03 00 00       	call   800580 <cprintf>
  80024c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80024f:	a1 20 30 80 00       	mov    0x803020,%eax
  800254:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	50                   	push   %eax
  80025e:	68 92 1d 80 00       	push   $0x801d92
  800263:	e8 18 03 00 00       	call   800580 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 88 1c 80 00       	push   $0x801c88
  800273:	e8 08 03 00 00       	call   800580 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80027b:	e8 6e 12 00 00       	call   8014ee <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800280:	e8 1f 00 00 00       	call   8002a4 <exit>
}
  800285:	90                   	nop
  800286:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800289:	5b                   	pop    %ebx
  80028a:	5e                   	pop    %esi
  80028b:	5f                   	pop    %edi
  80028c:	5d                   	pop    %ebp
  80028d:	c3                   	ret    

0080028e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80028e:	55                   	push   %ebp
  80028f:	89 e5                	mov    %esp,%ebp
  800291:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800294:	83 ec 0c             	sub    $0xc,%esp
  800297:	6a 00                	push   $0x0
  800299:	e8 7a 14 00 00       	call   801718 <sys_destroy_env>
  80029e:	83 c4 10             	add    $0x10,%esp
}
  8002a1:	90                   	nop
  8002a2:	c9                   	leave  
  8002a3:	c3                   	ret    

008002a4 <exit>:

void
exit(void)
{
  8002a4:	55                   	push   %ebp
  8002a5:	89 e5                	mov    %esp,%ebp
  8002a7:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002aa:	e8 cf 14 00 00       	call   80177e <sys_exit_env>
}
  8002af:	90                   	nop
  8002b0:	c9                   	leave  
  8002b1:	c3                   	ret    

008002b2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002b2:	55                   	push   %ebp
  8002b3:	89 e5                	mov    %esp,%ebp
  8002b5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002b8:	8d 45 10             	lea    0x10(%ebp),%eax
  8002bb:	83 c0 04             	add    $0x4,%eax
  8002be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002c1:	a1 28 31 80 00       	mov    0x803128,%eax
  8002c6:	85 c0                	test   %eax,%eax
  8002c8:	74 16                	je     8002e0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002ca:	a1 28 31 80 00       	mov    0x803128,%eax
  8002cf:	83 ec 08             	sub    $0x8,%esp
  8002d2:	50                   	push   %eax
  8002d3:	68 74 1e 80 00       	push   $0x801e74
  8002d8:	e8 a3 02 00 00       	call   800580 <cprintf>
  8002dd:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8002e0:	a1 04 30 80 00       	mov    0x803004,%eax
  8002e5:	83 ec 0c             	sub    $0xc,%esp
  8002e8:	ff 75 0c             	pushl  0xc(%ebp)
  8002eb:	ff 75 08             	pushl  0x8(%ebp)
  8002ee:	50                   	push   %eax
  8002ef:	68 7c 1e 80 00       	push   $0x801e7c
  8002f4:	6a 74                	push   $0x74
  8002f6:	e8 b2 02 00 00       	call   8005ad <cprintf_colored>
  8002fb:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8002fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800301:	83 ec 08             	sub    $0x8,%esp
  800304:	ff 75 f4             	pushl  -0xc(%ebp)
  800307:	50                   	push   %eax
  800308:	e8 04 02 00 00       	call   800511 <vcprintf>
  80030d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800310:	83 ec 08             	sub    $0x8,%esp
  800313:	6a 00                	push   $0x0
  800315:	68 a4 1e 80 00       	push   $0x801ea4
  80031a:	e8 f2 01 00 00       	call   800511 <vcprintf>
  80031f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800322:	e8 7d ff ff ff       	call   8002a4 <exit>

	// should not return here
	while (1) ;
  800327:	eb fe                	jmp    800327 <_panic+0x75>

00800329 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80032f:	a1 20 30 80 00       	mov    0x803020,%eax
  800334:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80033a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80033d:	39 c2                	cmp    %eax,%edx
  80033f:	74 14                	je     800355 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800341:	83 ec 04             	sub    $0x4,%esp
  800344:	68 a8 1e 80 00       	push   $0x801ea8
  800349:	6a 26                	push   $0x26
  80034b:	68 f4 1e 80 00       	push   $0x801ef4
  800350:	e8 5d ff ff ff       	call   8002b2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800355:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80035c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800363:	e9 c5 00 00 00       	jmp    80042d <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800368:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	01 d0                	add    %edx,%eax
  800377:	8b 00                	mov    (%eax),%eax
  800379:	85 c0                	test   %eax,%eax
  80037b:	75 08                	jne    800385 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80037d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800380:	e9 a5 00 00 00       	jmp    80042a <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800385:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80038c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800393:	eb 69                	jmp    8003fe <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800395:	a1 20 30 80 00       	mov    0x803020,%eax
  80039a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003a0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003a3:	89 d0                	mov    %edx,%eax
  8003a5:	01 c0                	add    %eax,%eax
  8003a7:	01 d0                	add    %edx,%eax
  8003a9:	c1 e0 03             	shl    $0x3,%eax
  8003ac:	01 c8                	add    %ecx,%eax
  8003ae:	8a 40 04             	mov    0x4(%eax),%al
  8003b1:	84 c0                	test   %al,%al
  8003b3:	75 46                	jne    8003fb <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ba:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c3:	89 d0                	mov    %edx,%eax
  8003c5:	01 c0                	add    %eax,%eax
  8003c7:	01 d0                	add    %edx,%eax
  8003c9:	c1 e0 03             	shl    $0x3,%eax
  8003cc:	01 c8                	add    %ecx,%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003db:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	01 c8                	add    %ecx,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003ee:	39 c2                	cmp    %eax,%edx
  8003f0:	75 09                	jne    8003fb <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8003f2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003f9:	eb 15                	jmp    800410 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fb:	ff 45 e8             	incl   -0x18(%ebp)
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800409:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	77 85                	ja     800395 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800410:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800414:	75 14                	jne    80042a <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800416:	83 ec 04             	sub    $0x4,%esp
  800419:	68 00 1f 80 00       	push   $0x801f00
  80041e:	6a 3a                	push   $0x3a
  800420:	68 f4 1e 80 00       	push   $0x801ef4
  800425:	e8 88 fe ff ff       	call   8002b2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80042a:	ff 45 f0             	incl   -0x10(%ebp)
  80042d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800430:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800433:	0f 8c 2f ff ff ff    	jl     800368 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800439:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800440:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800447:	eb 26                	jmp    80046f <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800449:	a1 20 30 80 00       	mov    0x803020,%eax
  80044e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800454:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800457:	89 d0                	mov    %edx,%eax
  800459:	01 c0                	add    %eax,%eax
  80045b:	01 d0                	add    %edx,%eax
  80045d:	c1 e0 03             	shl    $0x3,%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8a 40 04             	mov    0x4(%eax),%al
  800465:	3c 01                	cmp    $0x1,%al
  800467:	75 03                	jne    80046c <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800469:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80046c:	ff 45 e0             	incl   -0x20(%ebp)
  80046f:	a1 20 30 80 00       	mov    0x803020,%eax
  800474:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80047a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80047d:	39 c2                	cmp    %eax,%edx
  80047f:	77 c8                	ja     800449 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800487:	74 14                	je     80049d <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800489:	83 ec 04             	sub    $0x4,%esp
  80048c:	68 54 1f 80 00       	push   $0x801f54
  800491:	6a 44                	push   $0x44
  800493:	68 f4 1e 80 00       	push   $0x801ef4
  800498:	e8 15 fe ff ff       	call   8002b2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80049d:	90                   	nop
  80049e:	c9                   	leave  
  80049f:	c3                   	ret    

008004a0 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8004a0:	55                   	push   %ebp
  8004a1:	89 e5                	mov    %esp,%ebp
  8004a3:	53                   	push   %ebx
  8004a4:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8004af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b2:	89 0a                	mov    %ecx,(%edx)
  8004b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8004b7:	88 d1                	mov    %dl,%cl
  8004b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004bc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004ca:	75 30                	jne    8004fc <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8004cc:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8004d2:	a0 40 30 80 00       	mov    0x803040,%al
  8004d7:	0f b6 c0             	movzbl %al,%eax
  8004da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004dd:	8b 09                	mov    (%ecx),%ecx
  8004df:	89 cb                	mov    %ecx,%ebx
  8004e1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004e4:	83 c1 08             	add    $0x8,%ecx
  8004e7:	52                   	push   %edx
  8004e8:	50                   	push   %eax
  8004e9:	53                   	push   %ebx
  8004ea:	51                   	push   %ecx
  8004eb:	e8 a0 0f 00 00       	call   801490 <sys_cputs>
  8004f0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ff:	8b 40 04             	mov    0x4(%eax),%eax
  800502:	8d 50 01             	lea    0x1(%eax),%edx
  800505:	8b 45 0c             	mov    0xc(%ebp),%eax
  800508:	89 50 04             	mov    %edx,0x4(%eax)
}
  80050b:	90                   	nop
  80050c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80050f:	c9                   	leave  
  800510:	c3                   	ret    

00800511 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800511:	55                   	push   %ebp
  800512:	89 e5                	mov    %esp,%ebp
  800514:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80051a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800521:	00 00 00 
	b.cnt = 0;
  800524:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80052b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80052e:	ff 75 0c             	pushl  0xc(%ebp)
  800531:	ff 75 08             	pushl  0x8(%ebp)
  800534:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80053a:	50                   	push   %eax
  80053b:	68 a0 04 80 00       	push   $0x8004a0
  800540:	e8 5a 02 00 00       	call   80079f <vprintfmt>
  800545:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800548:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80054e:	a0 40 30 80 00       	mov    0x803040,%al
  800553:	0f b6 c0             	movzbl %al,%eax
  800556:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80055c:	52                   	push   %edx
  80055d:	50                   	push   %eax
  80055e:	51                   	push   %ecx
  80055f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800565:	83 c0 08             	add    $0x8,%eax
  800568:	50                   	push   %eax
  800569:	e8 22 0f 00 00       	call   801490 <sys_cputs>
  80056e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800571:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800578:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80057e:	c9                   	leave  
  80057f:	c3                   	ret    

00800580 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800580:	55                   	push   %ebp
  800581:	89 e5                	mov    %esp,%ebp
  800583:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800586:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80058d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800590:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800593:	8b 45 08             	mov    0x8(%ebp),%eax
  800596:	83 ec 08             	sub    $0x8,%esp
  800599:	ff 75 f4             	pushl  -0xc(%ebp)
  80059c:	50                   	push   %eax
  80059d:	e8 6f ff ff ff       	call   800511 <vcprintf>
  8005a2:	83 c4 10             	add    $0x10,%esp
  8005a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ab:	c9                   	leave  
  8005ac:	c3                   	ret    

008005ad <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8005ad:	55                   	push   %ebp
  8005ae:	89 e5                	mov    %esp,%ebp
  8005b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005b3:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	c1 e0 08             	shl    $0x8,%eax
  8005c0:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8005c5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005c8:	83 c0 04             	add    $0x4,%eax
  8005cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d1:	83 ec 08             	sub    $0x8,%esp
  8005d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d7:	50                   	push   %eax
  8005d8:	e8 34 ff ff ff       	call   800511 <vcprintf>
  8005dd:	83 c4 10             	add    $0x10,%esp
  8005e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8005e3:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  8005ea:	07 00 00 

	return cnt;
  8005ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005f0:	c9                   	leave  
  8005f1:	c3                   	ret    

008005f2 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8005f2:	55                   	push   %ebp
  8005f3:	89 e5                	mov    %esp,%ebp
  8005f5:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8005f8:	e8 d7 0e 00 00       	call   8014d4 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8005fd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800600:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	83 ec 08             	sub    $0x8,%esp
  800609:	ff 75 f4             	pushl  -0xc(%ebp)
  80060c:	50                   	push   %eax
  80060d:	e8 ff fe ff ff       	call   800511 <vcprintf>
  800612:	83 c4 10             	add    $0x10,%esp
  800615:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800618:	e8 d1 0e 00 00       	call   8014ee <sys_unlock_cons>
	return cnt;
  80061d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800620:	c9                   	leave  
  800621:	c3                   	ret    

00800622 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800622:	55                   	push   %ebp
  800623:	89 e5                	mov    %esp,%ebp
  800625:	53                   	push   %ebx
  800626:	83 ec 14             	sub    $0x14,%esp
  800629:	8b 45 10             	mov    0x10(%ebp),%eax
  80062c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80062f:	8b 45 14             	mov    0x14(%ebp),%eax
  800632:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800635:	8b 45 18             	mov    0x18(%ebp),%eax
  800638:	ba 00 00 00 00       	mov    $0x0,%edx
  80063d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800640:	77 55                	ja     800697 <printnum+0x75>
  800642:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800645:	72 05                	jb     80064c <printnum+0x2a>
  800647:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80064a:	77 4b                	ja     800697 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80064c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80064f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800652:	8b 45 18             	mov    0x18(%ebp),%eax
  800655:	ba 00 00 00 00       	mov    $0x0,%edx
  80065a:	52                   	push   %edx
  80065b:	50                   	push   %eax
  80065c:	ff 75 f4             	pushl  -0xc(%ebp)
  80065f:	ff 75 f0             	pushl  -0x10(%ebp)
  800662:	e8 71 13 00 00       	call   8019d8 <__udivdi3>
  800667:	83 c4 10             	add    $0x10,%esp
  80066a:	83 ec 04             	sub    $0x4,%esp
  80066d:	ff 75 20             	pushl  0x20(%ebp)
  800670:	53                   	push   %ebx
  800671:	ff 75 18             	pushl  0x18(%ebp)
  800674:	52                   	push   %edx
  800675:	50                   	push   %eax
  800676:	ff 75 0c             	pushl  0xc(%ebp)
  800679:	ff 75 08             	pushl  0x8(%ebp)
  80067c:	e8 a1 ff ff ff       	call   800622 <printnum>
  800681:	83 c4 20             	add    $0x20,%esp
  800684:	eb 1a                	jmp    8006a0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800686:	83 ec 08             	sub    $0x8,%esp
  800689:	ff 75 0c             	pushl  0xc(%ebp)
  80068c:	ff 75 20             	pushl  0x20(%ebp)
  80068f:	8b 45 08             	mov    0x8(%ebp),%eax
  800692:	ff d0                	call   *%eax
  800694:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800697:	ff 4d 1c             	decl   0x1c(%ebp)
  80069a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80069e:	7f e6                	jg     800686 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006a0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006a3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ae:	53                   	push   %ebx
  8006af:	51                   	push   %ecx
  8006b0:	52                   	push   %edx
  8006b1:	50                   	push   %eax
  8006b2:	e8 31 14 00 00       	call   801ae8 <__umoddi3>
  8006b7:	83 c4 10             	add    $0x10,%esp
  8006ba:	05 b4 21 80 00       	add    $0x8021b4,%eax
  8006bf:	8a 00                	mov    (%eax),%al
  8006c1:	0f be c0             	movsbl %al,%eax
  8006c4:	83 ec 08             	sub    $0x8,%esp
  8006c7:	ff 75 0c             	pushl  0xc(%ebp)
  8006ca:	50                   	push   %eax
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	ff d0                	call   *%eax
  8006d0:	83 c4 10             	add    $0x10,%esp
}
  8006d3:	90                   	nop
  8006d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006d7:	c9                   	leave  
  8006d8:	c3                   	ret    

008006d9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006d9:	55                   	push   %ebp
  8006da:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006dc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006e0:	7e 1c                	jle    8006fe <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	8d 50 08             	lea    0x8(%eax),%edx
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	89 10                	mov    %edx,(%eax)
  8006ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f2:	8b 00                	mov    (%eax),%eax
  8006f4:	83 e8 08             	sub    $0x8,%eax
  8006f7:	8b 50 04             	mov    0x4(%eax),%edx
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	eb 40                	jmp    80073e <getuint+0x65>
	else if (lflag)
  8006fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800702:	74 1e                	je     800722 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	8d 50 04             	lea    0x4(%eax),%edx
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	89 10                	mov    %edx,(%eax)
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	83 e8 04             	sub    $0x4,%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	ba 00 00 00 00       	mov    $0x0,%edx
  800720:	eb 1c                	jmp    80073e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	8d 50 04             	lea    0x4(%eax),%edx
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	89 10                	mov    %edx,(%eax)
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	83 e8 04             	sub    $0x4,%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80073e:	5d                   	pop    %ebp
  80073f:	c3                   	ret    

00800740 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800740:	55                   	push   %ebp
  800741:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800743:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800747:	7e 1c                	jle    800765 <getint+0x25>
		return va_arg(*ap, long long);
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	8d 50 08             	lea    0x8(%eax),%edx
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	89 10                	mov    %edx,(%eax)
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	8b 00                	mov    (%eax),%eax
  80075b:	83 e8 08             	sub    $0x8,%eax
  80075e:	8b 50 04             	mov    0x4(%eax),%edx
  800761:	8b 00                	mov    (%eax),%eax
  800763:	eb 38                	jmp    80079d <getint+0x5d>
	else if (lflag)
  800765:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800769:	74 1a                	je     800785 <getint+0x45>
		return va_arg(*ap, long);
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	8b 00                	mov    (%eax),%eax
  800770:	8d 50 04             	lea    0x4(%eax),%edx
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	89 10                	mov    %edx,(%eax)
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	8b 00                	mov    (%eax),%eax
  80077d:	83 e8 04             	sub    $0x4,%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	99                   	cltd   
  800783:	eb 18                	jmp    80079d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	8d 50 04             	lea    0x4(%eax),%edx
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	89 10                	mov    %edx,(%eax)
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	83 e8 04             	sub    $0x4,%eax
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	99                   	cltd   
}
  80079d:	5d                   	pop    %ebp
  80079e:	c3                   	ret    

0080079f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
  8007a2:	56                   	push   %esi
  8007a3:	53                   	push   %ebx
  8007a4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007a7:	eb 17                	jmp    8007c0 <vprintfmt+0x21>
			if (ch == '\0')
  8007a9:	85 db                	test   %ebx,%ebx
  8007ab:	0f 84 c1 03 00 00    	je     800b72 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8007b1:	83 ec 08             	sub    $0x8,%esp
  8007b4:	ff 75 0c             	pushl  0xc(%ebp)
  8007b7:	53                   	push   %ebx
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	ff d0                	call   *%eax
  8007bd:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c3:	8d 50 01             	lea    0x1(%eax),%edx
  8007c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8007c9:	8a 00                	mov    (%eax),%al
  8007cb:	0f b6 d8             	movzbl %al,%ebx
  8007ce:	83 fb 25             	cmp    $0x25,%ebx
  8007d1:	75 d6                	jne    8007a9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007d3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007d7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007de:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007e5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007ec:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f6:	8d 50 01             	lea    0x1(%eax),%edx
  8007f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8007fc:	8a 00                	mov    (%eax),%al
  8007fe:	0f b6 d8             	movzbl %al,%ebx
  800801:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800804:	83 f8 5b             	cmp    $0x5b,%eax
  800807:	0f 87 3d 03 00 00    	ja     800b4a <vprintfmt+0x3ab>
  80080d:	8b 04 85 d8 21 80 00 	mov    0x8021d8(,%eax,4),%eax
  800814:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800816:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80081a:	eb d7                	jmp    8007f3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80081c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800820:	eb d1                	jmp    8007f3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800822:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800829:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80082c:	89 d0                	mov    %edx,%eax
  80082e:	c1 e0 02             	shl    $0x2,%eax
  800831:	01 d0                	add    %edx,%eax
  800833:	01 c0                	add    %eax,%eax
  800835:	01 d8                	add    %ebx,%eax
  800837:	83 e8 30             	sub    $0x30,%eax
  80083a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80083d:	8b 45 10             	mov    0x10(%ebp),%eax
  800840:	8a 00                	mov    (%eax),%al
  800842:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800845:	83 fb 2f             	cmp    $0x2f,%ebx
  800848:	7e 3e                	jle    800888 <vprintfmt+0xe9>
  80084a:	83 fb 39             	cmp    $0x39,%ebx
  80084d:	7f 39                	jg     800888 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80084f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800852:	eb d5                	jmp    800829 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800854:	8b 45 14             	mov    0x14(%ebp),%eax
  800857:	83 c0 04             	add    $0x4,%eax
  80085a:	89 45 14             	mov    %eax,0x14(%ebp)
  80085d:	8b 45 14             	mov    0x14(%ebp),%eax
  800860:	83 e8 04             	sub    $0x4,%eax
  800863:	8b 00                	mov    (%eax),%eax
  800865:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800868:	eb 1f                	jmp    800889 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80086a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80086e:	79 83                	jns    8007f3 <vprintfmt+0x54>
				width = 0;
  800870:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800877:	e9 77 ff ff ff       	jmp    8007f3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80087c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800883:	e9 6b ff ff ff       	jmp    8007f3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800888:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800889:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088d:	0f 89 60 ff ff ff    	jns    8007f3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800893:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800896:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800899:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008a0:	e9 4e ff ff ff       	jmp    8007f3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008a5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008a8:	e9 46 ff ff ff       	jmp    8007f3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b0:	83 c0 04             	add    $0x4,%eax
  8008b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b9:	83 e8 04             	sub    $0x4,%eax
  8008bc:	8b 00                	mov    (%eax),%eax
  8008be:	83 ec 08             	sub    $0x8,%esp
  8008c1:	ff 75 0c             	pushl  0xc(%ebp)
  8008c4:	50                   	push   %eax
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	ff d0                	call   *%eax
  8008ca:	83 c4 10             	add    $0x10,%esp
			break;
  8008cd:	e9 9b 02 00 00       	jmp    800b6d <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d5:	83 c0 04             	add    $0x4,%eax
  8008d8:	89 45 14             	mov    %eax,0x14(%ebp)
  8008db:	8b 45 14             	mov    0x14(%ebp),%eax
  8008de:	83 e8 04             	sub    $0x4,%eax
  8008e1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008e3:	85 db                	test   %ebx,%ebx
  8008e5:	79 02                	jns    8008e9 <vprintfmt+0x14a>
				err = -err;
  8008e7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008e9:	83 fb 64             	cmp    $0x64,%ebx
  8008ec:	7f 0b                	jg     8008f9 <vprintfmt+0x15a>
  8008ee:	8b 34 9d 20 20 80 00 	mov    0x802020(,%ebx,4),%esi
  8008f5:	85 f6                	test   %esi,%esi
  8008f7:	75 19                	jne    800912 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008f9:	53                   	push   %ebx
  8008fa:	68 c5 21 80 00       	push   $0x8021c5
  8008ff:	ff 75 0c             	pushl  0xc(%ebp)
  800902:	ff 75 08             	pushl  0x8(%ebp)
  800905:	e8 70 02 00 00       	call   800b7a <printfmt>
  80090a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80090d:	e9 5b 02 00 00       	jmp    800b6d <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800912:	56                   	push   %esi
  800913:	68 ce 21 80 00       	push   $0x8021ce
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	ff 75 08             	pushl  0x8(%ebp)
  80091e:	e8 57 02 00 00       	call   800b7a <printfmt>
  800923:	83 c4 10             	add    $0x10,%esp
			break;
  800926:	e9 42 02 00 00       	jmp    800b6d <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80092b:	8b 45 14             	mov    0x14(%ebp),%eax
  80092e:	83 c0 04             	add    $0x4,%eax
  800931:	89 45 14             	mov    %eax,0x14(%ebp)
  800934:	8b 45 14             	mov    0x14(%ebp),%eax
  800937:	83 e8 04             	sub    $0x4,%eax
  80093a:	8b 30                	mov    (%eax),%esi
  80093c:	85 f6                	test   %esi,%esi
  80093e:	75 05                	jne    800945 <vprintfmt+0x1a6>
				p = "(null)";
  800940:	be d1 21 80 00       	mov    $0x8021d1,%esi
			if (width > 0 && padc != '-')
  800945:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800949:	7e 6d                	jle    8009b8 <vprintfmt+0x219>
  80094b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80094f:	74 67                	je     8009b8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800951:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	50                   	push   %eax
  800958:	56                   	push   %esi
  800959:	e8 1e 03 00 00       	call   800c7c <strnlen>
  80095e:	83 c4 10             	add    $0x10,%esp
  800961:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800964:	eb 16                	jmp    80097c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800966:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80096a:	83 ec 08             	sub    $0x8,%esp
  80096d:	ff 75 0c             	pushl  0xc(%ebp)
  800970:	50                   	push   %eax
  800971:	8b 45 08             	mov    0x8(%ebp),%eax
  800974:	ff d0                	call   *%eax
  800976:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800979:	ff 4d e4             	decl   -0x1c(%ebp)
  80097c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800980:	7f e4                	jg     800966 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800982:	eb 34                	jmp    8009b8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800984:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800988:	74 1c                	je     8009a6 <vprintfmt+0x207>
  80098a:	83 fb 1f             	cmp    $0x1f,%ebx
  80098d:	7e 05                	jle    800994 <vprintfmt+0x1f5>
  80098f:	83 fb 7e             	cmp    $0x7e,%ebx
  800992:	7e 12                	jle    8009a6 <vprintfmt+0x207>
					putch('?', putdat);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 0c             	pushl  0xc(%ebp)
  80099a:	6a 3f                	push   $0x3f
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	ff d0                	call   *%eax
  8009a1:	83 c4 10             	add    $0x10,%esp
  8009a4:	eb 0f                	jmp    8009b5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	53                   	push   %ebx
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	ff d0                	call   *%eax
  8009b2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009b5:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b8:	89 f0                	mov    %esi,%eax
  8009ba:	8d 70 01             	lea    0x1(%eax),%esi
  8009bd:	8a 00                	mov    (%eax),%al
  8009bf:	0f be d8             	movsbl %al,%ebx
  8009c2:	85 db                	test   %ebx,%ebx
  8009c4:	74 24                	je     8009ea <vprintfmt+0x24b>
  8009c6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009ca:	78 b8                	js     800984 <vprintfmt+0x1e5>
  8009cc:	ff 4d e0             	decl   -0x20(%ebp)
  8009cf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009d3:	79 af                	jns    800984 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009d5:	eb 13                	jmp    8009ea <vprintfmt+0x24b>
				putch(' ', putdat);
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	6a 20                	push   $0x20
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	ff d0                	call   *%eax
  8009e4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009e7:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ee:	7f e7                	jg     8009d7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009f0:	e9 78 01 00 00       	jmp    800b6d <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009f5:	83 ec 08             	sub    $0x8,%esp
  8009f8:	ff 75 e8             	pushl  -0x18(%ebp)
  8009fb:	8d 45 14             	lea    0x14(%ebp),%eax
  8009fe:	50                   	push   %eax
  8009ff:	e8 3c fd ff ff       	call   800740 <getint>
  800a04:	83 c4 10             	add    $0x10,%esp
  800a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a13:	85 d2                	test   %edx,%edx
  800a15:	79 23                	jns    800a3a <vprintfmt+0x29b>
				putch('-', putdat);
  800a17:	83 ec 08             	sub    $0x8,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	6a 2d                	push   $0x2d
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a2d:	f7 d8                	neg    %eax
  800a2f:	83 d2 00             	adc    $0x0,%edx
  800a32:	f7 da                	neg    %edx
  800a34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a37:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a3a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a41:	e9 bc 00 00 00       	jmp    800b02 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a46:	83 ec 08             	sub    $0x8,%esp
  800a49:	ff 75 e8             	pushl  -0x18(%ebp)
  800a4c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a4f:	50                   	push   %eax
  800a50:	e8 84 fc ff ff       	call   8006d9 <getuint>
  800a55:	83 c4 10             	add    $0x10,%esp
  800a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a5e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a65:	e9 98 00 00 00       	jmp    800b02 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a6a:	83 ec 08             	sub    $0x8,%esp
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	6a 58                	push   $0x58
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	ff d0                	call   *%eax
  800a77:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	6a 58                	push   $0x58
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	ff d0                	call   *%eax
  800a87:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	6a 58                	push   $0x58
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
			break;
  800a9a:	e9 ce 00 00 00       	jmp    800b6d <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 0c             	pushl  0xc(%ebp)
  800aa5:	6a 30                	push   $0x30
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	ff d0                	call   *%eax
  800aac:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800aaf:	83 ec 08             	sub    $0x8,%esp
  800ab2:	ff 75 0c             	pushl  0xc(%ebp)
  800ab5:	6a 78                	push   $0x78
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	ff d0                	call   *%eax
  800abc:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800abf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac2:	83 c0 04             	add    $0x4,%eax
  800ac5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	83 e8 04             	sub    $0x4,%eax
  800ace:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ad0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ada:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ae1:	eb 1f                	jmp    800b02 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ae9:	8d 45 14             	lea    0x14(%ebp),%eax
  800aec:	50                   	push   %eax
  800aed:	e8 e7 fb ff ff       	call   8006d9 <getuint>
  800af2:	83 c4 10             	add    $0x10,%esp
  800af5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800afb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b02:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b06:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b09:	83 ec 04             	sub    $0x4,%esp
  800b0c:	52                   	push   %edx
  800b0d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b10:	50                   	push   %eax
  800b11:	ff 75 f4             	pushl  -0xc(%ebp)
  800b14:	ff 75 f0             	pushl  -0x10(%ebp)
  800b17:	ff 75 0c             	pushl  0xc(%ebp)
  800b1a:	ff 75 08             	pushl  0x8(%ebp)
  800b1d:	e8 00 fb ff ff       	call   800622 <printnum>
  800b22:	83 c4 20             	add    $0x20,%esp
			break;
  800b25:	eb 46                	jmp    800b6d <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b27:	83 ec 08             	sub    $0x8,%esp
  800b2a:	ff 75 0c             	pushl  0xc(%ebp)
  800b2d:	53                   	push   %ebx
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	ff d0                	call   *%eax
  800b33:	83 c4 10             	add    $0x10,%esp
			break;
  800b36:	eb 35                	jmp    800b6d <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b38:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800b3f:	eb 2c                	jmp    800b6d <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800b41:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800b48:	eb 23                	jmp    800b6d <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	6a 25                	push   $0x25
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	ff d0                	call   *%eax
  800b57:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b5a:	ff 4d 10             	decl   0x10(%ebp)
  800b5d:	eb 03                	jmp    800b62 <vprintfmt+0x3c3>
  800b5f:	ff 4d 10             	decl   0x10(%ebp)
  800b62:	8b 45 10             	mov    0x10(%ebp),%eax
  800b65:	48                   	dec    %eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	3c 25                	cmp    $0x25,%al
  800b6a:	75 f3                	jne    800b5f <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800b6c:	90                   	nop
		}
	}
  800b6d:	e9 35 fc ff ff       	jmp    8007a7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b72:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b73:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b76:	5b                   	pop    %ebx
  800b77:	5e                   	pop    %esi
  800b78:	5d                   	pop    %ebp
  800b79:	c3                   	ret    

00800b7a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b7a:	55                   	push   %ebp
  800b7b:	89 e5                	mov    %esp,%ebp
  800b7d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b80:	8d 45 10             	lea    0x10(%ebp),%eax
  800b83:	83 c0 04             	add    $0x4,%eax
  800b86:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b89:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b8f:	50                   	push   %eax
  800b90:	ff 75 0c             	pushl  0xc(%ebp)
  800b93:	ff 75 08             	pushl  0x8(%ebp)
  800b96:	e8 04 fc ff ff       	call   80079f <vprintfmt>
  800b9b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b9e:	90                   	nop
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ba4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba7:	8b 40 08             	mov    0x8(%eax),%eax
  800baa:	8d 50 01             	lea    0x1(%eax),%edx
  800bad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb6:	8b 10                	mov    (%eax),%edx
  800bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbb:	8b 40 04             	mov    0x4(%eax),%eax
  800bbe:	39 c2                	cmp    %eax,%edx
  800bc0:	73 12                	jae    800bd4 <sprintputch+0x33>
		*b->buf++ = ch;
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	8b 00                	mov    (%eax),%eax
  800bc7:	8d 48 01             	lea    0x1(%eax),%ecx
  800bca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcd:	89 0a                	mov    %ecx,(%edx)
  800bcf:	8b 55 08             	mov    0x8(%ebp),%edx
  800bd2:	88 10                	mov    %dl,(%eax)
}
  800bd4:	90                   	nop
  800bd5:	5d                   	pop    %ebp
  800bd6:	c3                   	ret    

00800bd7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bd7:	55                   	push   %ebp
  800bd8:	89 e5                	mov    %esp,%ebp
  800bda:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800be3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	01 d0                	add    %edx,%eax
  800bee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bf8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bfc:	74 06                	je     800c04 <vsnprintf+0x2d>
  800bfe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c02:	7f 07                	jg     800c0b <vsnprintf+0x34>
		return -E_INVAL;
  800c04:	b8 03 00 00 00       	mov    $0x3,%eax
  800c09:	eb 20                	jmp    800c2b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c0b:	ff 75 14             	pushl  0x14(%ebp)
  800c0e:	ff 75 10             	pushl  0x10(%ebp)
  800c11:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c14:	50                   	push   %eax
  800c15:	68 a1 0b 80 00       	push   $0x800ba1
  800c1a:	e8 80 fb ff ff       	call   80079f <vprintfmt>
  800c1f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c25:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c2b:	c9                   	leave  
  800c2c:	c3                   	ret    

00800c2d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c2d:	55                   	push   %ebp
  800c2e:	89 e5                	mov    %esp,%ebp
  800c30:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c33:	8d 45 10             	lea    0x10(%ebp),%eax
  800c36:	83 c0 04             	add    $0x4,%eax
  800c39:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c42:	50                   	push   %eax
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	ff 75 08             	pushl  0x8(%ebp)
  800c49:	e8 89 ff ff ff       	call   800bd7 <vsnprintf>
  800c4e:	83 c4 10             	add    $0x10,%esp
  800c51:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c57:	c9                   	leave  
  800c58:	c3                   	ret    

00800c59 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c59:	55                   	push   %ebp
  800c5a:	89 e5                	mov    %esp,%ebp
  800c5c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c66:	eb 06                	jmp    800c6e <strlen+0x15>
		n++;
  800c68:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c6b:	ff 45 08             	incl   0x8(%ebp)
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	84 c0                	test   %al,%al
  800c75:	75 f1                	jne    800c68 <strlen+0xf>
		n++;
	return n;
  800c77:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c7a:	c9                   	leave  
  800c7b:	c3                   	ret    

00800c7c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c7c:	55                   	push   %ebp
  800c7d:	89 e5                	mov    %esp,%ebp
  800c7f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c89:	eb 09                	jmp    800c94 <strnlen+0x18>
		n++;
  800c8b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c8e:	ff 45 08             	incl   0x8(%ebp)
  800c91:	ff 4d 0c             	decl   0xc(%ebp)
  800c94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c98:	74 09                	je     800ca3 <strnlen+0x27>
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	84 c0                	test   %al,%al
  800ca1:	75 e8                	jne    800c8b <strnlen+0xf>
		n++;
	return n;
  800ca3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
  800cab:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cb4:	90                   	nop
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8d 50 01             	lea    0x1(%eax),%edx
  800cbb:	89 55 08             	mov    %edx,0x8(%ebp)
  800cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cc7:	8a 12                	mov    (%edx),%dl
  800cc9:	88 10                	mov    %dl,(%eax)
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	84 c0                	test   %al,%al
  800ccf:	75 e4                	jne    800cb5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd4:	c9                   	leave  
  800cd5:	c3                   	ret    

00800cd6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cd6:	55                   	push   %ebp
  800cd7:	89 e5                	mov    %esp,%ebp
  800cd9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ce2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce9:	eb 1f                	jmp    800d0a <strncpy+0x34>
		*dst++ = *src;
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8d 50 01             	lea    0x1(%eax),%edx
  800cf1:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf7:	8a 12                	mov    (%edx),%dl
  800cf9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	84 c0                	test   %al,%al
  800d02:	74 03                	je     800d07 <strncpy+0x31>
			src++;
  800d04:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d07:	ff 45 fc             	incl   -0x4(%ebp)
  800d0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d0d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d10:	72 d9                	jb     800ceb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d12:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d15:	c9                   	leave  
  800d16:	c3                   	ret    

00800d17 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d17:	55                   	push   %ebp
  800d18:	89 e5                	mov    %esp,%ebp
  800d1a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d23:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d27:	74 30                	je     800d59 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d29:	eb 16                	jmp    800d41 <strlcpy+0x2a>
			*dst++ = *src++;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8d 50 01             	lea    0x1(%eax),%edx
  800d31:	89 55 08             	mov    %edx,0x8(%ebp)
  800d34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d37:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d3a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d3d:	8a 12                	mov    (%edx),%dl
  800d3f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d41:	ff 4d 10             	decl   0x10(%ebp)
  800d44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d48:	74 09                	je     800d53 <strlcpy+0x3c>
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	84 c0                	test   %al,%al
  800d51:	75 d8                	jne    800d2b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d59:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5f:	29 c2                	sub    %eax,%edx
  800d61:	89 d0                	mov    %edx,%eax
}
  800d63:	c9                   	leave  
  800d64:	c3                   	ret    

00800d65 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d65:	55                   	push   %ebp
  800d66:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d68:	eb 06                	jmp    800d70 <strcmp+0xb>
		p++, q++;
  800d6a:	ff 45 08             	incl   0x8(%ebp)
  800d6d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	84 c0                	test   %al,%al
  800d77:	74 0e                	je     800d87 <strcmp+0x22>
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	8a 10                	mov    (%eax),%dl
  800d7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	38 c2                	cmp    %al,%dl
  800d85:	74 e3                	je     800d6a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	0f b6 d0             	movzbl %al,%edx
  800d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	0f b6 c0             	movzbl %al,%eax
  800d97:	29 c2                	sub    %eax,%edx
  800d99:	89 d0                	mov    %edx,%eax
}
  800d9b:	5d                   	pop    %ebp
  800d9c:	c3                   	ret    

00800d9d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800da0:	eb 09                	jmp    800dab <strncmp+0xe>
		n--, p++, q++;
  800da2:	ff 4d 10             	decl   0x10(%ebp)
  800da5:	ff 45 08             	incl   0x8(%ebp)
  800da8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800daf:	74 17                	je     800dc8 <strncmp+0x2b>
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	84 c0                	test   %al,%al
  800db8:	74 0e                	je     800dc8 <strncmp+0x2b>
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	8a 10                	mov    (%eax),%dl
  800dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	38 c2                	cmp    %al,%dl
  800dc6:	74 da                	je     800da2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dcc:	75 07                	jne    800dd5 <strncmp+0x38>
		return 0;
  800dce:	b8 00 00 00 00       	mov    $0x0,%eax
  800dd3:	eb 14                	jmp    800de9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f b6 d0             	movzbl %al,%edx
  800ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	0f b6 c0             	movzbl %al,%eax
  800de5:	29 c2                	sub    %eax,%edx
  800de7:	89 d0                	mov    %edx,%eax
}
  800de9:	5d                   	pop    %ebp
  800dea:	c3                   	ret    

00800deb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 04             	sub    $0x4,%esp
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df7:	eb 12                	jmp    800e0b <strchr+0x20>
		if (*s == c)
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e01:	75 05                	jne    800e08 <strchr+0x1d>
			return (char *) s;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	eb 11                	jmp    800e19 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e08:	ff 45 08             	incl   0x8(%ebp)
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	8a 00                	mov    (%eax),%al
  800e10:	84 c0                	test   %al,%al
  800e12:	75 e5                	jne    800df9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e19:	c9                   	leave  
  800e1a:	c3                   	ret    

00800e1b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e1b:	55                   	push   %ebp
  800e1c:	89 e5                	mov    %esp,%ebp
  800e1e:	83 ec 04             	sub    $0x4,%esp
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e27:	eb 0d                	jmp    800e36 <strfind+0x1b>
		if (*s == c)
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e31:	74 0e                	je     800e41 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e33:	ff 45 08             	incl   0x8(%ebp)
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	8a 00                	mov    (%eax),%al
  800e3b:	84 c0                	test   %al,%al
  800e3d:	75 ea                	jne    800e29 <strfind+0xe>
  800e3f:	eb 01                	jmp    800e42 <strfind+0x27>
		if (*s == c)
			break;
  800e41:	90                   	nop
	return (char *) s;
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
  800e4a:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800e53:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800e57:	76 63                	jbe    800ebc <memset+0x75>
		uint64 data_block = c;
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	99                   	cltd   
  800e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e60:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800e63:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e66:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e69:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800e6d:	c1 e0 08             	shl    $0x8,%eax
  800e70:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e73:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800e76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7c:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800e80:	c1 e0 10             	shl    $0x10,%eax
  800e83:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e86:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800e89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8f:	89 c2                	mov    %eax,%edx
  800e91:	b8 00 00 00 00       	mov    $0x0,%eax
  800e96:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e99:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800e9c:	eb 18                	jmp    800eb6 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800e9e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ea1:	8d 41 08             	lea    0x8(%ecx),%eax
  800ea4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800ea7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eaa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ead:	89 01                	mov    %eax,(%ecx)
  800eaf:	89 51 04             	mov    %edx,0x4(%ecx)
  800eb2:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800eb6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800eba:	77 e2                	ja     800e9e <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800ebc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec0:	74 23                	je     800ee5 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800ec2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ec8:	eb 0e                	jmp    800ed8 <memset+0x91>
			*p8++ = (uint8)c;
  800eca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ecd:	8d 50 01             	lea    0x1(%eax),%edx
  800ed0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ed3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed6:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ed8:	8b 45 10             	mov    0x10(%ebp),%eax
  800edb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ede:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee1:	85 c0                	test   %eax,%eax
  800ee3:	75 e5                	jne    800eca <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
  800eed:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800efc:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f00:	76 24                	jbe    800f26 <memcpy+0x3c>
		while(n >= 8){
  800f02:	eb 1c                	jmp    800f20 <memcpy+0x36>
			*d64 = *s64;
  800f04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f07:	8b 50 04             	mov    0x4(%eax),%edx
  800f0a:	8b 00                	mov    (%eax),%eax
  800f0c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f0f:	89 01                	mov    %eax,(%ecx)
  800f11:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f14:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f18:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f1c:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f20:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f24:	77 de                	ja     800f04 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2a:	74 31                	je     800f5d <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f35:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f38:	eb 16                	jmp    800f50 <memcpy+0x66>
			*d8++ = *s8++;
  800f3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f3d:	8d 50 01             	lea    0x1(%eax),%edx
  800f40:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800f43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f46:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f49:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800f4c:	8a 12                	mov    (%edx),%dl
  800f4e:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800f50:	8b 45 10             	mov    0x10(%ebp),%eax
  800f53:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f56:	89 55 10             	mov    %edx,0x10(%ebp)
  800f59:	85 c0                	test   %eax,%eax
  800f5b:	75 dd                	jne    800f3a <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f60:	c9                   	leave  
  800f61:	c3                   	ret    

00800f62 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f62:	55                   	push   %ebp
  800f63:	89 e5                	mov    %esp,%ebp
  800f65:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f7a:	73 50                	jae    800fcc <memmove+0x6a>
  800f7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f82:	01 d0                	add    %edx,%eax
  800f84:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f87:	76 43                	jbe    800fcc <memmove+0x6a>
		s += n;
  800f89:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f95:	eb 10                	jmp    800fa7 <memmove+0x45>
			*--d = *--s;
  800f97:	ff 4d f8             	decl   -0x8(%ebp)
  800f9a:	ff 4d fc             	decl   -0x4(%ebp)
  800f9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa0:	8a 10                	mov    (%eax),%dl
  800fa2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800faa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fad:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb0:	85 c0                	test   %eax,%eax
  800fb2:	75 e3                	jne    800f97 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fb4:	eb 23                	jmp    800fd9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb9:	8d 50 01             	lea    0x1(%eax),%edx
  800fbc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc8:	8a 12                	mov    (%edx),%dl
  800fca:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd5:	85 c0                	test   %eax,%eax
  800fd7:	75 dd                	jne    800fb6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
  800fe1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fed:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ff0:	eb 2a                	jmp    80101c <memcmp+0x3e>
		if (*s1 != *s2)
  800ff2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff5:	8a 10                	mov    (%eax),%dl
  800ff7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	38 c2                	cmp    %al,%dl
  800ffe:	74 16                	je     801016 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801000:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	0f b6 d0             	movzbl %al,%edx
  801008:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100b:	8a 00                	mov    (%eax),%al
  80100d:	0f b6 c0             	movzbl %al,%eax
  801010:	29 c2                	sub    %eax,%edx
  801012:	89 d0                	mov    %edx,%eax
  801014:	eb 18                	jmp    80102e <memcmp+0x50>
		s1++, s2++;
  801016:	ff 45 fc             	incl   -0x4(%ebp)
  801019:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80101c:	8b 45 10             	mov    0x10(%ebp),%eax
  80101f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801022:	89 55 10             	mov    %edx,0x10(%ebp)
  801025:	85 c0                	test   %eax,%eax
  801027:	75 c9                	jne    800ff2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801029:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80102e:	c9                   	leave  
  80102f:	c3                   	ret    

00801030 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
  801033:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801036:	8b 55 08             	mov    0x8(%ebp),%edx
  801039:	8b 45 10             	mov    0x10(%ebp),%eax
  80103c:	01 d0                	add    %edx,%eax
  80103e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801041:	eb 15                	jmp    801058 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8a 00                	mov    (%eax),%al
  801048:	0f b6 d0             	movzbl %al,%edx
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	0f b6 c0             	movzbl %al,%eax
  801051:	39 c2                	cmp    %eax,%edx
  801053:	74 0d                	je     801062 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801055:	ff 45 08             	incl   0x8(%ebp)
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80105e:	72 e3                	jb     801043 <memfind+0x13>
  801060:	eb 01                	jmp    801063 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801062:	90                   	nop
	return (void *) s;
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801066:	c9                   	leave  
  801067:	c3                   	ret    

00801068 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
  80106b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80106e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801075:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80107c:	eb 03                	jmp    801081 <strtol+0x19>
		s++;
  80107e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801081:	8b 45 08             	mov    0x8(%ebp),%eax
  801084:	8a 00                	mov    (%eax),%al
  801086:	3c 20                	cmp    $0x20,%al
  801088:	74 f4                	je     80107e <strtol+0x16>
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	3c 09                	cmp    $0x9,%al
  801091:	74 eb                	je     80107e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	8a 00                	mov    (%eax),%al
  801098:	3c 2b                	cmp    $0x2b,%al
  80109a:	75 05                	jne    8010a1 <strtol+0x39>
		s++;
  80109c:	ff 45 08             	incl   0x8(%ebp)
  80109f:	eb 13                	jmp    8010b4 <strtol+0x4c>
	else if (*s == '-')
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	8a 00                	mov    (%eax),%al
  8010a6:	3c 2d                	cmp    $0x2d,%al
  8010a8:	75 0a                	jne    8010b4 <strtol+0x4c>
		s++, neg = 1;
  8010aa:	ff 45 08             	incl   0x8(%ebp)
  8010ad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b8:	74 06                	je     8010c0 <strtol+0x58>
  8010ba:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010be:	75 20                	jne    8010e0 <strtol+0x78>
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	3c 30                	cmp    $0x30,%al
  8010c7:	75 17                	jne    8010e0 <strtol+0x78>
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	40                   	inc    %eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	3c 78                	cmp    $0x78,%al
  8010d1:	75 0d                	jne    8010e0 <strtol+0x78>
		s += 2, base = 16;
  8010d3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010d7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010de:	eb 28                	jmp    801108 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e4:	75 15                	jne    8010fb <strtol+0x93>
  8010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e9:	8a 00                	mov    (%eax),%al
  8010eb:	3c 30                	cmp    $0x30,%al
  8010ed:	75 0c                	jne    8010fb <strtol+0x93>
		s++, base = 8;
  8010ef:	ff 45 08             	incl   0x8(%ebp)
  8010f2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010f9:	eb 0d                	jmp    801108 <strtol+0xa0>
	else if (base == 0)
  8010fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ff:	75 07                	jne    801108 <strtol+0xa0>
		base = 10;
  801101:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	3c 2f                	cmp    $0x2f,%al
  80110f:	7e 19                	jle    80112a <strtol+0xc2>
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	3c 39                	cmp    $0x39,%al
  801118:	7f 10                	jg     80112a <strtol+0xc2>
			dig = *s - '0';
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	0f be c0             	movsbl %al,%eax
  801122:	83 e8 30             	sub    $0x30,%eax
  801125:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801128:	eb 42                	jmp    80116c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 60                	cmp    $0x60,%al
  801131:	7e 19                	jle    80114c <strtol+0xe4>
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3c 7a                	cmp    $0x7a,%al
  80113a:	7f 10                	jg     80114c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	0f be c0             	movsbl %al,%eax
  801144:	83 e8 57             	sub    $0x57,%eax
  801147:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80114a:	eb 20                	jmp    80116c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	3c 40                	cmp    $0x40,%al
  801153:	7e 39                	jle    80118e <strtol+0x126>
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	3c 5a                	cmp    $0x5a,%al
  80115c:	7f 30                	jg     80118e <strtol+0x126>
			dig = *s - 'A' + 10;
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	0f be c0             	movsbl %al,%eax
  801166:	83 e8 37             	sub    $0x37,%eax
  801169:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80116c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801172:	7d 19                	jge    80118d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801174:	ff 45 08             	incl   0x8(%ebp)
  801177:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80117e:	89 c2                	mov    %eax,%edx
  801180:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801183:	01 d0                	add    %edx,%eax
  801185:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801188:	e9 7b ff ff ff       	jmp    801108 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80118d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80118e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801192:	74 08                	je     80119c <strtol+0x134>
		*endptr = (char *) s;
  801194:	8b 45 0c             	mov    0xc(%ebp),%eax
  801197:	8b 55 08             	mov    0x8(%ebp),%edx
  80119a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80119c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a0:	74 07                	je     8011a9 <strtol+0x141>
  8011a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a5:	f7 d8                	neg    %eax
  8011a7:	eb 03                	jmp    8011ac <strtol+0x144>
  8011a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011ac:	c9                   	leave  
  8011ad:	c3                   	ret    

008011ae <ltostr>:

void
ltostr(long value, char *str)
{
  8011ae:	55                   	push   %ebp
  8011af:	89 e5                	mov    %esp,%ebp
  8011b1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c6:	79 13                	jns    8011db <ltostr+0x2d>
	{
		neg = 1;
  8011c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011d5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011d8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011e3:	99                   	cltd   
  8011e4:	f7 f9                	idiv   %ecx
  8011e6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011f2:	89 c2                	mov    %eax,%edx
  8011f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f7:	01 d0                	add    %edx,%eax
  8011f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011fc:	83 c2 30             	add    $0x30,%edx
  8011ff:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801201:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801204:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801209:	f7 e9                	imul   %ecx
  80120b:	c1 fa 02             	sar    $0x2,%edx
  80120e:	89 c8                	mov    %ecx,%eax
  801210:	c1 f8 1f             	sar    $0x1f,%eax
  801213:	29 c2                	sub    %eax,%edx
  801215:	89 d0                	mov    %edx,%eax
  801217:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80121a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121e:	75 bb                	jne    8011db <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801220:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801227:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122a:	48                   	dec    %eax
  80122b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80122e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801232:	74 3d                	je     801271 <ltostr+0xc3>
		start = 1 ;
  801234:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80123b:	eb 34                	jmp    801271 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80123d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801240:	8b 45 0c             	mov    0xc(%ebp),%eax
  801243:	01 d0                	add    %edx,%eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80124a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	01 c2                	add    %eax,%edx
  801252:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801255:	8b 45 0c             	mov    0xc(%ebp),%eax
  801258:	01 c8                	add    %ecx,%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80125e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801261:	8b 45 0c             	mov    0xc(%ebp),%eax
  801264:	01 c2                	add    %eax,%edx
  801266:	8a 45 eb             	mov    -0x15(%ebp),%al
  801269:	88 02                	mov    %al,(%edx)
		start++ ;
  80126b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80126e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801271:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801274:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801277:	7c c4                	jl     80123d <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801279:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80127c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127f:	01 d0                	add    %edx,%eax
  801281:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801284:	90                   	nop
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
  80128a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80128d:	ff 75 08             	pushl  0x8(%ebp)
  801290:	e8 c4 f9 ff ff       	call   800c59 <strlen>
  801295:	83 c4 04             	add    $0x4,%esp
  801298:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80129b:	ff 75 0c             	pushl  0xc(%ebp)
  80129e:	e8 b6 f9 ff ff       	call   800c59 <strlen>
  8012a3:	83 c4 04             	add    $0x4,%esp
  8012a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b7:	eb 17                	jmp    8012d0 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bf:	01 c2                	add    %eax,%edx
  8012c1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c7:	01 c8                	add    %ecx,%eax
  8012c9:	8a 00                	mov    (%eax),%al
  8012cb:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012cd:	ff 45 fc             	incl   -0x4(%ebp)
  8012d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012d6:	7c e1                	jl     8012b9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012e6:	eb 1f                	jmp    801307 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012eb:	8d 50 01             	lea    0x1(%eax),%edx
  8012ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012f1:	89 c2                	mov    %eax,%edx
  8012f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f6:	01 c2                	add    %eax,%edx
  8012f8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fe:	01 c8                	add    %ecx,%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801304:	ff 45 f8             	incl   -0x8(%ebp)
  801307:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80130a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80130d:	7c d9                	jl     8012e8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80130f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801312:	8b 45 10             	mov    0x10(%ebp),%eax
  801315:	01 d0                	add    %edx,%eax
  801317:	c6 00 00             	movb   $0x0,(%eax)
}
  80131a:	90                   	nop
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801320:	8b 45 14             	mov    0x14(%ebp),%eax
  801323:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801329:	8b 45 14             	mov    0x14(%ebp),%eax
  80132c:	8b 00                	mov    (%eax),%eax
  80132e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801335:	8b 45 10             	mov    0x10(%ebp),%eax
  801338:	01 d0                	add    %edx,%eax
  80133a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801340:	eb 0c                	jmp    80134e <strsplit+0x31>
			*string++ = 0;
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 08             	mov    %edx,0x8(%ebp)
  80134b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	84 c0                	test   %al,%al
  801355:	74 18                	je     80136f <strsplit+0x52>
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	0f be c0             	movsbl %al,%eax
  80135f:	50                   	push   %eax
  801360:	ff 75 0c             	pushl  0xc(%ebp)
  801363:	e8 83 fa ff ff       	call   800deb <strchr>
  801368:	83 c4 08             	add    $0x8,%esp
  80136b:	85 c0                	test   %eax,%eax
  80136d:	75 d3                	jne    801342 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	84 c0                	test   %al,%al
  801376:	74 5a                	je     8013d2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801378:	8b 45 14             	mov    0x14(%ebp),%eax
  80137b:	8b 00                	mov    (%eax),%eax
  80137d:	83 f8 0f             	cmp    $0xf,%eax
  801380:	75 07                	jne    801389 <strsplit+0x6c>
		{
			return 0;
  801382:	b8 00 00 00 00       	mov    $0x0,%eax
  801387:	eb 66                	jmp    8013ef <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801389:	8b 45 14             	mov    0x14(%ebp),%eax
  80138c:	8b 00                	mov    (%eax),%eax
  80138e:	8d 48 01             	lea    0x1(%eax),%ecx
  801391:	8b 55 14             	mov    0x14(%ebp),%edx
  801394:	89 0a                	mov    %ecx,(%edx)
  801396:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80139d:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a0:	01 c2                	add    %eax,%edx
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a7:	eb 03                	jmp    8013ac <strsplit+0x8f>
			string++;
  8013a9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8013af:	8a 00                	mov    (%eax),%al
  8013b1:	84 c0                	test   %al,%al
  8013b3:	74 8b                	je     801340 <strsplit+0x23>
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	0f be c0             	movsbl %al,%eax
  8013bd:	50                   	push   %eax
  8013be:	ff 75 0c             	pushl  0xc(%ebp)
  8013c1:	e8 25 fa ff ff       	call   800deb <strchr>
  8013c6:	83 c4 08             	add    $0x8,%esp
  8013c9:	85 c0                	test   %eax,%eax
  8013cb:	74 dc                	je     8013a9 <strsplit+0x8c>
			string++;
	}
  8013cd:	e9 6e ff ff ff       	jmp    801340 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013d2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	8b 00                	mov    (%eax),%eax
  8013d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013df:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e2:	01 d0                	add    %edx,%eax
  8013e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013ea:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8013fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801404:	eb 4a                	jmp    801450 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801406:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	01 c2                	add    %eax,%edx
  80140e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801411:	8b 45 0c             	mov    0xc(%ebp),%eax
  801414:	01 c8                	add    %ecx,%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80141a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80141d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801420:	01 d0                	add    %edx,%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	3c 40                	cmp    $0x40,%al
  801426:	7e 25                	jle    80144d <str2lower+0x5c>
  801428:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142e:	01 d0                	add    %edx,%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	3c 5a                	cmp    $0x5a,%al
  801434:	7f 17                	jg     80144d <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801436:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	01 d0                	add    %edx,%eax
  80143e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801441:	8b 55 08             	mov    0x8(%ebp),%edx
  801444:	01 ca                	add    %ecx,%edx
  801446:	8a 12                	mov    (%edx),%dl
  801448:	83 c2 20             	add    $0x20,%edx
  80144b:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80144d:	ff 45 fc             	incl   -0x4(%ebp)
  801450:	ff 75 0c             	pushl  0xc(%ebp)
  801453:	e8 01 f8 ff ff       	call   800c59 <strlen>
  801458:	83 c4 04             	add    $0x4,%esp
  80145b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80145e:	7f a6                	jg     801406 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801460:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	57                   	push   %edi
  801469:	56                   	push   %esi
  80146a:	53                   	push   %ebx
  80146b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	8b 55 0c             	mov    0xc(%ebp),%edx
  801474:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801477:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80147a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80147d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801480:	cd 30                	int    $0x30
  801482:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801485:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801488:	83 c4 10             	add    $0x10,%esp
  80148b:	5b                   	pop    %ebx
  80148c:	5e                   	pop    %esi
  80148d:	5f                   	pop    %edi
  80148e:	5d                   	pop    %ebp
  80148f:	c3                   	ret    

00801490 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
  801493:	83 ec 04             	sub    $0x4,%esp
  801496:	8b 45 10             	mov    0x10(%ebp),%eax
  801499:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80149c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80149f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	6a 00                	push   $0x0
  8014a8:	51                   	push   %ecx
  8014a9:	52                   	push   %edx
  8014aa:	ff 75 0c             	pushl  0xc(%ebp)
  8014ad:	50                   	push   %eax
  8014ae:	6a 00                	push   $0x0
  8014b0:	e8 b0 ff ff ff       	call   801465 <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	90                   	nop
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <sys_cgetc>:

int
sys_cgetc(void)
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 02                	push   $0x2
  8014ca:	e8 96 ff ff ff       	call   801465 <syscall>
  8014cf:	83 c4 18             	add    $0x18,%esp
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 03                	push   $0x3
  8014e3:	e8 7d ff ff ff       	call   801465 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	90                   	nop
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 04                	push   $0x4
  8014fd:	e8 63 ff ff ff       	call   801465 <syscall>
  801502:	83 c4 18             	add    $0x18,%esp
}
  801505:	90                   	nop
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80150b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	52                   	push   %edx
  801518:	50                   	push   %eax
  801519:	6a 08                	push   $0x8
  80151b:	e8 45 ff ff ff       	call   801465 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
  801528:	56                   	push   %esi
  801529:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80152a:	8b 75 18             	mov    0x18(%ebp),%esi
  80152d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801530:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801533:	8b 55 0c             	mov    0xc(%ebp),%edx
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	56                   	push   %esi
  80153a:	53                   	push   %ebx
  80153b:	51                   	push   %ecx
  80153c:	52                   	push   %edx
  80153d:	50                   	push   %eax
  80153e:	6a 09                	push   $0x9
  801540:	e8 20 ff ff ff       	call   801465 <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80154b:	5b                   	pop    %ebx
  80154c:	5e                   	pop    %esi
  80154d:	5d                   	pop    %ebp
  80154e:	c3                   	ret    

0080154f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	ff 75 08             	pushl  0x8(%ebp)
  80155d:	6a 0a                	push   $0xa
  80155f:	e8 01 ff ff ff       	call   801465 <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	ff 75 0c             	pushl  0xc(%ebp)
  801575:	ff 75 08             	pushl  0x8(%ebp)
  801578:	6a 0b                	push   $0xb
  80157a:	e8 e6 fe ff ff       	call   801465 <syscall>
  80157f:	83 c4 18             	add    $0x18,%esp
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 0c                	push   $0xc
  801593:	e8 cd fe ff ff       	call   801465 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 0d                	push   $0xd
  8015ac:	e8 b4 fe ff ff       	call   801465 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 0e                	push   $0xe
  8015c5:	e8 9b fe ff ff       	call   801465 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 0f                	push   $0xf
  8015de:	e8 82 fe ff ff       	call   801465 <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	ff 75 08             	pushl  0x8(%ebp)
  8015f6:	6a 10                	push   $0x10
  8015f8:	e8 68 fe ff ff       	call   801465 <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 11                	push   $0x11
  801611:	e8 4f fe ff ff       	call   801465 <syscall>
  801616:	83 c4 18             	add    $0x18,%esp
}
  801619:	90                   	nop
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <sys_cputc>:

void
sys_cputc(const char c)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
  80161f:	83 ec 04             	sub    $0x4,%esp
  801622:	8b 45 08             	mov    0x8(%ebp),%eax
  801625:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801628:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	50                   	push   %eax
  801635:	6a 01                	push   $0x1
  801637:	e8 29 fe ff ff       	call   801465 <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	90                   	nop
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 14                	push   $0x14
  801651:	e8 0f fe ff ff       	call   801465 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	90                   	nop
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 04             	sub    $0x4,%esp
  801662:	8b 45 10             	mov    0x10(%ebp),%eax
  801665:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801668:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80166b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80166f:	8b 45 08             	mov    0x8(%ebp),%eax
  801672:	6a 00                	push   $0x0
  801674:	51                   	push   %ecx
  801675:	52                   	push   %edx
  801676:	ff 75 0c             	pushl  0xc(%ebp)
  801679:	50                   	push   %eax
  80167a:	6a 15                	push   $0x15
  80167c:	e8 e4 fd ff ff       	call   801465 <syscall>
  801681:	83 c4 18             	add    $0x18,%esp
}
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801689:	8b 55 10             	mov    0x10(%ebp),%edx
  80168c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	52                   	push   %edx
  801694:	50                   	push   %eax
  801695:	ff 75 08             	pushl  0x8(%ebp)
  801698:	6a 16                	push   $0x16
  80169a:	e8 c6 fd ff ff       	call   801465 <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	52                   	push   %edx
  8016b4:	50                   	push   %eax
  8016b5:	6a 17                	push   $0x17
  8016b7:	e8 a9 fd ff ff       	call   801465 <syscall>
  8016bc:	83 c4 18             	add    $0x18,%esp
}
  8016bf:	c9                   	leave  
  8016c0:	c3                   	ret    

008016c1 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	52                   	push   %edx
  8016d1:	50                   	push   %eax
  8016d2:	6a 18                	push   $0x18
  8016d4:	e8 8c fd ff ff       	call   801465 <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	6a 00                	push   $0x0
  8016e6:	ff 75 14             	pushl  0x14(%ebp)
  8016e9:	ff 75 10             	pushl  0x10(%ebp)
  8016ec:	ff 75 0c             	pushl  0xc(%ebp)
  8016ef:	50                   	push   %eax
  8016f0:	6a 19                	push   $0x19
  8016f2:	e8 6e fd ff ff       	call   801465 <syscall>
  8016f7:	83 c4 18             	add    $0x18,%esp
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_run_env>:

void sys_run_env(int32 envId)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	50                   	push   %eax
  80170b:	6a 1a                	push   $0x1a
  80170d:	e8 53 fd ff ff       	call   801465 <syscall>
  801712:	83 c4 18             	add    $0x18,%esp
}
  801715:	90                   	nop
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	50                   	push   %eax
  801727:	6a 1b                	push   $0x1b
  801729:	e8 37 fd ff ff       	call   801465 <syscall>
  80172e:	83 c4 18             	add    $0x18,%esp
}
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 05                	push   $0x5
  801742:	e8 1e fd ff ff       	call   801465 <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
}
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 06                	push   $0x6
  80175b:	e8 05 fd ff ff       	call   801465 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 07                	push   $0x7
  801774:	e8 ec fc ff ff       	call   801465 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_exit_env>:


void sys_exit_env(void)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 1c                	push   $0x1c
  80178d:	e8 d3 fc ff ff       	call   801465 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	90                   	nop
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	ff 75 10             	pushl  0x10(%ebp)
  8017a2:	ff 75 0c             	pushl  0xc(%ebp)
  8017a5:	ff 75 08             	pushl  0x8(%ebp)
  8017a8:	6a 13                	push   $0x13
  8017aa:	e8 b6 fc ff ff       	call   801465 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b2:	90                   	nop
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 1e                	push   $0x1e
  8017c4:	e8 9c fc ff ff       	call   801465 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
  8017d1:	83 ec 04             	sub    $0x4,%esp
  8017d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017da:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	50                   	push   %eax
  8017e7:	6a 1f                	push   $0x1f
  8017e9:	e8 77 fc ff ff       	call   801465 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f1:	90                   	nop
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <rsttst>:
void rsttst()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 21                	push   $0x21
  801803:	e8 5d fc ff ff       	call   801465 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
	return ;
  80180b:	90                   	nop
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	8b 45 14             	mov    0x14(%ebp),%eax
  801817:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80181a:	8b 55 18             	mov    0x18(%ebp),%edx
  80181d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801821:	52                   	push   %edx
  801822:	50                   	push   %eax
  801823:	ff 75 10             	pushl  0x10(%ebp)
  801826:	ff 75 0c             	pushl  0xc(%ebp)
  801829:	ff 75 08             	pushl  0x8(%ebp)
  80182c:	6a 20                	push   $0x20
  80182e:	e8 32 fc ff ff       	call   801465 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
	return ;
  801836:	90                   	nop
}
  801837:	c9                   	leave  
  801838:	c3                   	ret    

00801839 <chktst>:
void chktst(uint32 n)
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	ff 75 08             	pushl  0x8(%ebp)
  801847:	6a 22                	push   $0x22
  801849:	e8 17 fc ff ff       	call   801465 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
	return ;
  801851:	90                   	nop
}
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <inctst>:

void inctst()
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 23                	push   $0x23
  801863:	e8 fd fb ff ff       	call   801465 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
	return ;
  80186b:	90                   	nop
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <gettst>:
uint32 gettst()
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 24                	push   $0x24
  80187d:	e8 e3 fb ff ff       	call   801465 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 25                	push   $0x25
  801896:	e8 ca fb ff ff       	call   801465 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
  80189e:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018a3:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8018ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b0:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	ff 75 08             	pushl  0x8(%ebp)
  8018c0:	6a 26                	push   $0x26
  8018c2:	e8 9e fb ff ff       	call   801465 <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ca:	90                   	nop
}
  8018cb:	c9                   	leave  
  8018cc:	c3                   	ret    

008018cd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018cd:	55                   	push   %ebp
  8018ce:	89 e5                	mov    %esp,%ebp
  8018d0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018d1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	6a 00                	push   $0x0
  8018df:	53                   	push   %ebx
  8018e0:	51                   	push   %ecx
  8018e1:	52                   	push   %edx
  8018e2:	50                   	push   %eax
  8018e3:	6a 27                	push   $0x27
  8018e5:	e8 7b fb ff ff       	call   801465 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	52                   	push   %edx
  801902:	50                   	push   %eax
  801903:	6a 28                	push   $0x28
  801905:	e8 5b fb ff ff       	call   801465 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801912:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801915:	8b 55 0c             	mov    0xc(%ebp),%edx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	6a 00                	push   $0x0
  80191d:	51                   	push   %ecx
  80191e:	ff 75 10             	pushl  0x10(%ebp)
  801921:	52                   	push   %edx
  801922:	50                   	push   %eax
  801923:	6a 29                	push   $0x29
  801925:	e8 3b fb ff ff       	call   801465 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	ff 75 10             	pushl  0x10(%ebp)
  801939:	ff 75 0c             	pushl  0xc(%ebp)
  80193c:	ff 75 08             	pushl  0x8(%ebp)
  80193f:	6a 12                	push   $0x12
  801941:	e8 1f fb ff ff       	call   801465 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
	return ;
  801949:	90                   	nop
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80194f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	52                   	push   %edx
  80195c:	50                   	push   %eax
  80195d:	6a 2a                	push   $0x2a
  80195f:	e8 01 fb ff ff       	call   801465 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
	return;
  801967:	90                   	nop
}
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 2b                	push   $0x2b
  801979:	e8 e7 fa ff ff       	call   801465 <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
  801986:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801989:	83 ec 04             	sub    $0x4,%esp
  80198c:	68 48 23 80 00       	push   $0x802348
  801991:	68 0a 01 00 00       	push   $0x10a
  801996:	68 58 23 80 00       	push   $0x802358
  80199b:	e8 12 e9 ff ff       	call   8002b2 <_panic>

008019a0 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	ff 75 0c             	pushl  0xc(%ebp)
  8019ac:	ff 75 08             	pushl  0x8(%ebp)
  8019af:	6a 33                	push   $0x33
  8019b1:	e8 af fa ff ff       	call   801465 <syscall>
  8019b6:	83 c4 18             	add    $0x18,%esp
	return;
  8019b9:	90                   	nop
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	ff 75 0c             	pushl  0xc(%ebp)
  8019c8:	ff 75 08             	pushl  0x8(%ebp)
  8019cb:	6a 34                	push   $0x34
  8019cd:	e8 93 fa ff ff       	call   801465 <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d5:	90                   	nop
}
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <__udivdi3>:
  8019d8:	55                   	push   %ebp
  8019d9:	57                   	push   %edi
  8019da:	56                   	push   %esi
  8019db:	53                   	push   %ebx
  8019dc:	83 ec 1c             	sub    $0x1c,%esp
  8019df:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019e3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019ef:	89 ca                	mov    %ecx,%edx
  8019f1:	89 f8                	mov    %edi,%eax
  8019f3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019f7:	85 f6                	test   %esi,%esi
  8019f9:	75 2d                	jne    801a28 <__udivdi3+0x50>
  8019fb:	39 cf                	cmp    %ecx,%edi
  8019fd:	77 65                	ja     801a64 <__udivdi3+0x8c>
  8019ff:	89 fd                	mov    %edi,%ebp
  801a01:	85 ff                	test   %edi,%edi
  801a03:	75 0b                	jne    801a10 <__udivdi3+0x38>
  801a05:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0a:	31 d2                	xor    %edx,%edx
  801a0c:	f7 f7                	div    %edi
  801a0e:	89 c5                	mov    %eax,%ebp
  801a10:	31 d2                	xor    %edx,%edx
  801a12:	89 c8                	mov    %ecx,%eax
  801a14:	f7 f5                	div    %ebp
  801a16:	89 c1                	mov    %eax,%ecx
  801a18:	89 d8                	mov    %ebx,%eax
  801a1a:	f7 f5                	div    %ebp
  801a1c:	89 cf                	mov    %ecx,%edi
  801a1e:	89 fa                	mov    %edi,%edx
  801a20:	83 c4 1c             	add    $0x1c,%esp
  801a23:	5b                   	pop    %ebx
  801a24:	5e                   	pop    %esi
  801a25:	5f                   	pop    %edi
  801a26:	5d                   	pop    %ebp
  801a27:	c3                   	ret    
  801a28:	39 ce                	cmp    %ecx,%esi
  801a2a:	77 28                	ja     801a54 <__udivdi3+0x7c>
  801a2c:	0f bd fe             	bsr    %esi,%edi
  801a2f:	83 f7 1f             	xor    $0x1f,%edi
  801a32:	75 40                	jne    801a74 <__udivdi3+0x9c>
  801a34:	39 ce                	cmp    %ecx,%esi
  801a36:	72 0a                	jb     801a42 <__udivdi3+0x6a>
  801a38:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a3c:	0f 87 9e 00 00 00    	ja     801ae0 <__udivdi3+0x108>
  801a42:	b8 01 00 00 00       	mov    $0x1,%eax
  801a47:	89 fa                	mov    %edi,%edx
  801a49:	83 c4 1c             	add    $0x1c,%esp
  801a4c:	5b                   	pop    %ebx
  801a4d:	5e                   	pop    %esi
  801a4e:	5f                   	pop    %edi
  801a4f:	5d                   	pop    %ebp
  801a50:	c3                   	ret    
  801a51:	8d 76 00             	lea    0x0(%esi),%esi
  801a54:	31 ff                	xor    %edi,%edi
  801a56:	31 c0                	xor    %eax,%eax
  801a58:	89 fa                	mov    %edi,%edx
  801a5a:	83 c4 1c             	add    $0x1c,%esp
  801a5d:	5b                   	pop    %ebx
  801a5e:	5e                   	pop    %esi
  801a5f:	5f                   	pop    %edi
  801a60:	5d                   	pop    %ebp
  801a61:	c3                   	ret    
  801a62:	66 90                	xchg   %ax,%ax
  801a64:	89 d8                	mov    %ebx,%eax
  801a66:	f7 f7                	div    %edi
  801a68:	31 ff                	xor    %edi,%edi
  801a6a:	89 fa                	mov    %edi,%edx
  801a6c:	83 c4 1c             	add    $0x1c,%esp
  801a6f:	5b                   	pop    %ebx
  801a70:	5e                   	pop    %esi
  801a71:	5f                   	pop    %edi
  801a72:	5d                   	pop    %ebp
  801a73:	c3                   	ret    
  801a74:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a79:	89 eb                	mov    %ebp,%ebx
  801a7b:	29 fb                	sub    %edi,%ebx
  801a7d:	89 f9                	mov    %edi,%ecx
  801a7f:	d3 e6                	shl    %cl,%esi
  801a81:	89 c5                	mov    %eax,%ebp
  801a83:	88 d9                	mov    %bl,%cl
  801a85:	d3 ed                	shr    %cl,%ebp
  801a87:	89 e9                	mov    %ebp,%ecx
  801a89:	09 f1                	or     %esi,%ecx
  801a8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a8f:	89 f9                	mov    %edi,%ecx
  801a91:	d3 e0                	shl    %cl,%eax
  801a93:	89 c5                	mov    %eax,%ebp
  801a95:	89 d6                	mov    %edx,%esi
  801a97:	88 d9                	mov    %bl,%cl
  801a99:	d3 ee                	shr    %cl,%esi
  801a9b:	89 f9                	mov    %edi,%ecx
  801a9d:	d3 e2                	shl    %cl,%edx
  801a9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa3:	88 d9                	mov    %bl,%cl
  801aa5:	d3 e8                	shr    %cl,%eax
  801aa7:	09 c2                	or     %eax,%edx
  801aa9:	89 d0                	mov    %edx,%eax
  801aab:	89 f2                	mov    %esi,%edx
  801aad:	f7 74 24 0c          	divl   0xc(%esp)
  801ab1:	89 d6                	mov    %edx,%esi
  801ab3:	89 c3                	mov    %eax,%ebx
  801ab5:	f7 e5                	mul    %ebp
  801ab7:	39 d6                	cmp    %edx,%esi
  801ab9:	72 19                	jb     801ad4 <__udivdi3+0xfc>
  801abb:	74 0b                	je     801ac8 <__udivdi3+0xf0>
  801abd:	89 d8                	mov    %ebx,%eax
  801abf:	31 ff                	xor    %edi,%edi
  801ac1:	e9 58 ff ff ff       	jmp    801a1e <__udivdi3+0x46>
  801ac6:	66 90                	xchg   %ax,%ax
  801ac8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801acc:	89 f9                	mov    %edi,%ecx
  801ace:	d3 e2                	shl    %cl,%edx
  801ad0:	39 c2                	cmp    %eax,%edx
  801ad2:	73 e9                	jae    801abd <__udivdi3+0xe5>
  801ad4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ad7:	31 ff                	xor    %edi,%edi
  801ad9:	e9 40 ff ff ff       	jmp    801a1e <__udivdi3+0x46>
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	31 c0                	xor    %eax,%eax
  801ae2:	e9 37 ff ff ff       	jmp    801a1e <__udivdi3+0x46>
  801ae7:	90                   	nop

00801ae8 <__umoddi3>:
  801ae8:	55                   	push   %ebp
  801ae9:	57                   	push   %edi
  801aea:	56                   	push   %esi
  801aeb:	53                   	push   %ebx
  801aec:	83 ec 1c             	sub    $0x1c,%esp
  801aef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801af3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801af7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801afb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b03:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b07:	89 f3                	mov    %esi,%ebx
  801b09:	89 fa                	mov    %edi,%edx
  801b0b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b0f:	89 34 24             	mov    %esi,(%esp)
  801b12:	85 c0                	test   %eax,%eax
  801b14:	75 1a                	jne    801b30 <__umoddi3+0x48>
  801b16:	39 f7                	cmp    %esi,%edi
  801b18:	0f 86 a2 00 00 00    	jbe    801bc0 <__umoddi3+0xd8>
  801b1e:	89 c8                	mov    %ecx,%eax
  801b20:	89 f2                	mov    %esi,%edx
  801b22:	f7 f7                	div    %edi
  801b24:	89 d0                	mov    %edx,%eax
  801b26:	31 d2                	xor    %edx,%edx
  801b28:	83 c4 1c             	add    $0x1c,%esp
  801b2b:	5b                   	pop    %ebx
  801b2c:	5e                   	pop    %esi
  801b2d:	5f                   	pop    %edi
  801b2e:	5d                   	pop    %ebp
  801b2f:	c3                   	ret    
  801b30:	39 f0                	cmp    %esi,%eax
  801b32:	0f 87 ac 00 00 00    	ja     801be4 <__umoddi3+0xfc>
  801b38:	0f bd e8             	bsr    %eax,%ebp
  801b3b:	83 f5 1f             	xor    $0x1f,%ebp
  801b3e:	0f 84 ac 00 00 00    	je     801bf0 <__umoddi3+0x108>
  801b44:	bf 20 00 00 00       	mov    $0x20,%edi
  801b49:	29 ef                	sub    %ebp,%edi
  801b4b:	89 fe                	mov    %edi,%esi
  801b4d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b51:	89 e9                	mov    %ebp,%ecx
  801b53:	d3 e0                	shl    %cl,%eax
  801b55:	89 d7                	mov    %edx,%edi
  801b57:	89 f1                	mov    %esi,%ecx
  801b59:	d3 ef                	shr    %cl,%edi
  801b5b:	09 c7                	or     %eax,%edi
  801b5d:	89 e9                	mov    %ebp,%ecx
  801b5f:	d3 e2                	shl    %cl,%edx
  801b61:	89 14 24             	mov    %edx,(%esp)
  801b64:	89 d8                	mov    %ebx,%eax
  801b66:	d3 e0                	shl    %cl,%eax
  801b68:	89 c2                	mov    %eax,%edx
  801b6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b6e:	d3 e0                	shl    %cl,%eax
  801b70:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b74:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b78:	89 f1                	mov    %esi,%ecx
  801b7a:	d3 e8                	shr    %cl,%eax
  801b7c:	09 d0                	or     %edx,%eax
  801b7e:	d3 eb                	shr    %cl,%ebx
  801b80:	89 da                	mov    %ebx,%edx
  801b82:	f7 f7                	div    %edi
  801b84:	89 d3                	mov    %edx,%ebx
  801b86:	f7 24 24             	mull   (%esp)
  801b89:	89 c6                	mov    %eax,%esi
  801b8b:	89 d1                	mov    %edx,%ecx
  801b8d:	39 d3                	cmp    %edx,%ebx
  801b8f:	0f 82 87 00 00 00    	jb     801c1c <__umoddi3+0x134>
  801b95:	0f 84 91 00 00 00    	je     801c2c <__umoddi3+0x144>
  801b9b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b9f:	29 f2                	sub    %esi,%edx
  801ba1:	19 cb                	sbb    %ecx,%ebx
  801ba3:	89 d8                	mov    %ebx,%eax
  801ba5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ba9:	d3 e0                	shl    %cl,%eax
  801bab:	89 e9                	mov    %ebp,%ecx
  801bad:	d3 ea                	shr    %cl,%edx
  801baf:	09 d0                	or     %edx,%eax
  801bb1:	89 e9                	mov    %ebp,%ecx
  801bb3:	d3 eb                	shr    %cl,%ebx
  801bb5:	89 da                	mov    %ebx,%edx
  801bb7:	83 c4 1c             	add    $0x1c,%esp
  801bba:	5b                   	pop    %ebx
  801bbb:	5e                   	pop    %esi
  801bbc:	5f                   	pop    %edi
  801bbd:	5d                   	pop    %ebp
  801bbe:	c3                   	ret    
  801bbf:	90                   	nop
  801bc0:	89 fd                	mov    %edi,%ebp
  801bc2:	85 ff                	test   %edi,%edi
  801bc4:	75 0b                	jne    801bd1 <__umoddi3+0xe9>
  801bc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801bcb:	31 d2                	xor    %edx,%edx
  801bcd:	f7 f7                	div    %edi
  801bcf:	89 c5                	mov    %eax,%ebp
  801bd1:	89 f0                	mov    %esi,%eax
  801bd3:	31 d2                	xor    %edx,%edx
  801bd5:	f7 f5                	div    %ebp
  801bd7:	89 c8                	mov    %ecx,%eax
  801bd9:	f7 f5                	div    %ebp
  801bdb:	89 d0                	mov    %edx,%eax
  801bdd:	e9 44 ff ff ff       	jmp    801b26 <__umoddi3+0x3e>
  801be2:	66 90                	xchg   %ax,%ax
  801be4:	89 c8                	mov    %ecx,%eax
  801be6:	89 f2                	mov    %esi,%edx
  801be8:	83 c4 1c             	add    $0x1c,%esp
  801beb:	5b                   	pop    %ebx
  801bec:	5e                   	pop    %esi
  801bed:	5f                   	pop    %edi
  801bee:	5d                   	pop    %ebp
  801bef:	c3                   	ret    
  801bf0:	3b 04 24             	cmp    (%esp),%eax
  801bf3:	72 06                	jb     801bfb <__umoddi3+0x113>
  801bf5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bf9:	77 0f                	ja     801c0a <__umoddi3+0x122>
  801bfb:	89 f2                	mov    %esi,%edx
  801bfd:	29 f9                	sub    %edi,%ecx
  801bff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c03:	89 14 24             	mov    %edx,(%esp)
  801c06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c0e:	8b 14 24             	mov    (%esp),%edx
  801c11:	83 c4 1c             	add    $0x1c,%esp
  801c14:	5b                   	pop    %ebx
  801c15:	5e                   	pop    %esi
  801c16:	5f                   	pop    %edi
  801c17:	5d                   	pop    %ebp
  801c18:	c3                   	ret    
  801c19:	8d 76 00             	lea    0x0(%esi),%esi
  801c1c:	2b 04 24             	sub    (%esp),%eax
  801c1f:	19 fa                	sbb    %edi,%edx
  801c21:	89 d1                	mov    %edx,%ecx
  801c23:	89 c6                	mov    %eax,%esi
  801c25:	e9 71 ff ff ff       	jmp    801b9b <__umoddi3+0xb3>
  801c2a:	66 90                	xchg   %ax,%ax
  801c2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c30:	72 ea                	jb     801c1c <__umoddi3+0x134>
  801c32:	89 d9                	mov    %ebx,%ecx
  801c34:	e9 62 ff ff ff       	jmp    801b9b <__umoddi3+0xb3>
