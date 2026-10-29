
obj/user/tst_chan_all_slave:     file format elf32-i386


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
  800031:	e8 74 00 00 00       	call   8000aa <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
extern volatile bool printStats ;

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int envID = sys_getenvid();
  800041:	e8 57 15 00 00       	call   80159d <sys_getenvid>
  800046:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Sleep on the channel
	char cmd[64] = "__Sleep__";
  800049:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  80004c:	bb ba 1c 80 00       	mov    $0x801cba,%ebx
  800051:	ba 0a 00 00 00       	mov    $0xa,%edx
  800056:	89 c7                	mov    %eax,%edi
  800058:	89 de                	mov    %ebx,%esi
  80005a:	89 d1                	mov    %edx,%ecx
  80005c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80005e:	8d 55 ae             	lea    -0x52(%ebp),%edx
  800061:	b9 36 00 00 00       	mov    $0x36,%ecx
  800066:	b0 00                	mov    $0x0,%al
  800068:	89 d7                	mov    %edx,%edi
  80006a:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd, 0);
  80006c:	83 ec 08             	sub    $0x8,%esp
  80006f:	6a 00                	push   $0x0
  800071:	8d 45 a4             	lea    -0x5c(%ebp),%eax
  800074:	50                   	push   %eax
  800075:	e8 3c 17 00 00       	call   8017b6 <sys_utilities>
  80007a:	83 c4 10             	add    $0x10,%esp

	//indicates wakenup
	inctst();
  80007d:	e8 3c 16 00 00       	call   8016be <inctst>

	cprintf_colored(TEXT_light_magenta, ">>> Slave %d is Finished\n", envID);
  800082:	83 ec 04             	sub    $0x4,%esp
  800085:	ff 75 e4             	pushl  -0x1c(%ebp)
  800088:	68 a0 1c 80 00       	push   $0x801ca0
  80008d:	6a 0d                	push   $0xd
  80008f:	e8 83 03 00 00       	call   800417 <cprintf_colored>
  800094:	83 c4 10             	add    $0x10,%esp
	printStats = 0;
  800097:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  80009e:	00 00 00 

	return;
  8000a1:	90                   	nop
}
  8000a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8000a5:	5b                   	pop    %ebx
  8000a6:	5e                   	pop    %esi
  8000a7:	5f                   	pop    %edi
  8000a8:	5d                   	pop    %ebp
  8000a9:	c3                   	ret    

008000aa <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000aa:	55                   	push   %ebp
  8000ab:	89 e5                	mov    %esp,%ebp
  8000ad:	57                   	push   %edi
  8000ae:	56                   	push   %esi
  8000af:	53                   	push   %ebx
  8000b0:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000b6:	e8 fb 14 00 00       	call   8015b6 <sys_getenvindex>
  8000bb:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000be:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000c1:	89 d0                	mov    %edx,%eax
  8000c3:	c1 e0 03             	shl    $0x3,%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c1 e0 06             	shl    $0x6,%eax
  8000cb:	01 d0                	add    %edx,%eax
  8000cd:	c1 e0 03             	shl    $0x3,%eax
  8000d0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000d5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000da:	a1 20 30 80 00       	mov    0x803020,%eax
  8000df:	8a 40 10             	mov    0x10(%eax),%al
  8000e2:	84 c0                	test   %al,%al
  8000e4:	74 0d                	je     8000f3 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000eb:	83 c0 10             	add    $0x10,%eax
  8000ee:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f7:	7e 0a                	jle    800103 <libmain+0x59>
		binaryname = argv[0];
  8000f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000fc:	8b 00                	mov    (%eax),%eax
  8000fe:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	ff 75 0c             	pushl  0xc(%ebp)
  800109:	ff 75 08             	pushl  0x8(%ebp)
  80010c:	e8 27 ff ff ff       	call   800038 <_main>
  800111:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800114:	a1 00 30 80 00       	mov    0x803000,%eax
  800119:	85 c0                	test   %eax,%eax
  80011b:	0f 84 b7 01 00 00    	je     8002d8 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800121:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800127:	bb 38 1e 80 00       	mov    $0x801e38,%ebx
  80012c:	ba 0e 00 00 00       	mov    $0xe,%edx
  800131:	89 c7                	mov    %eax,%edi
  800133:	89 de                	mov    %ebx,%esi
  800135:	89 d1                	mov    %edx,%ecx
  800137:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800139:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80013f:	b9 56 00 00 00       	mov    $0x56,%ecx
  800144:	b0 00                	mov    $0x0,%al
  800146:	89 d7                	mov    %edx,%edi
  800148:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80014a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800151:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800154:	83 ec 08             	sub    $0x8,%esp
  800157:	50                   	push   %eax
  800158:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80015e:	50                   	push   %eax
  80015f:	e8 52 16 00 00       	call   8017b6 <sys_utilities>
  800164:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800167:	e8 d2 11 00 00       	call   80133e <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80016c:	83 ec 0c             	sub    $0xc,%esp
  80016f:	68 14 1d 80 00       	push   $0x801d14
  800174:	e8 71 02 00 00       	call   8003ea <cprintf>
  800179:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80017c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80017f:	85 c0                	test   %eax,%eax
  800181:	74 58                	je     8001db <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800183:	e8 4c 16 00 00       	call   8017d4 <sys_get_optimal_num_faults>
  800188:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80018b:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800191:	bb 9c 1e 80 00       	mov    $0x801e9c,%ebx
  800196:	ba 11 00 00 00       	mov    $0x11,%edx
  80019b:	89 c7                	mov    %eax,%edi
  80019d:	89 de                	mov    %ebx,%esi
  80019f:	89 d1                	mov    %edx,%ecx
  8001a1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001a3:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001a6:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001ab:	b0 00                	mov    $0x0,%al
  8001ad:	89 d7                	mov    %edx,%edi
  8001af:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 dc             	pushl  -0x24(%ebp)
  8001b7:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001bd:	50                   	push   %eax
  8001be:	e8 f3 15 00 00       	call   8017b6 <sys_utilities>
  8001c3:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cc:	68 3c 1d 80 00       	push   $0x801d3c
  8001d1:	e8 14 02 00 00       	call   8003ea <cprintf>
  8001d6:	83 c4 10             	add    $0x10,%esp
  8001d9:	eb 59                	jmp    800234 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001db:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e0:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001eb:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	52                   	push   %edx
  8001f5:	50                   	push   %eax
  8001f6:	68 60 1d 80 00       	push   $0x801d60
  8001fb:	e8 ea 01 00 00       	call   8003ea <cprintf>
  800200:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800203:	a1 20 30 80 00       	mov    0x803020,%eax
  800208:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800219:	a1 20 30 80 00       	mov    0x803020,%eax
  80021e:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800224:	51                   	push   %ecx
  800225:	52                   	push   %edx
  800226:	50                   	push   %eax
  800227:	68 88 1d 80 00       	push   $0x801d88
  80022c:	e8 b9 01 00 00       	call   8003ea <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800234:	a1 20 30 80 00       	mov    0x803020,%eax
  800239:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80023f:	83 ec 08             	sub    $0x8,%esp
  800242:	50                   	push   %eax
  800243:	68 e0 1d 80 00       	push   $0x801de0
  800248:	e8 9d 01 00 00       	call   8003ea <cprintf>
  80024d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	68 f4 1d 80 00       	push   $0x801df4
  800258:	e8 8d 01 00 00       	call   8003ea <cprintf>
  80025d:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800260:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800267:	eb 28                	jmp    800291 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800271:	81 c2 74 04 00 00    	add    $0x474,%edx
  800277:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	50                   	push   %eax
  80027e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800281:	68 0b 1e 80 00       	push   $0x801e0b
  800286:	e8 5f 01 00 00       	call   8003ea <cprintf>
  80028b:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80028e:	ff 45 e4             	incl   -0x1c(%ebp)
  800291:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800295:	7e d2                	jle    800269 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	68 1a 1e 80 00       	push   $0x801e1a
  80029f:	e8 46 01 00 00       	call   8003ea <cprintf>
  8002a4:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ac:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002b2:	83 ec 08             	sub    $0x8,%esp
  8002b5:	50                   	push   %eax
  8002b6:	68 1e 1e 80 00       	push   $0x801e1e
  8002bb:	e8 2a 01 00 00       	call   8003ea <cprintf>
  8002c0:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	68 14 1d 80 00       	push   $0x801d14
  8002cb:	e8 1a 01 00 00       	call   8003ea <cprintf>
  8002d0:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002d3:	e8 80 10 00 00       	call   801358 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002d8:	e8 1f 00 00 00       	call   8002fc <exit>
}
  8002dd:	90                   	nop
  8002de:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002e1:	5b                   	pop    %ebx
  8002e2:	5e                   	pop    %esi
  8002e3:	5f                   	pop    %edi
  8002e4:	5d                   	pop    %ebp
  8002e5:	c3                   	ret    

008002e6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002e6:	55                   	push   %ebp
  8002e7:	89 e5                	mov    %esp,%ebp
  8002e9:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002ec:	83 ec 0c             	sub    $0xc,%esp
  8002ef:	6a 00                	push   $0x0
  8002f1:	e8 8c 12 00 00       	call   801582 <sys_destroy_env>
  8002f6:	83 c4 10             	add    $0x10,%esp
}
  8002f9:	90                   	nop
  8002fa:	c9                   	leave  
  8002fb:	c3                   	ret    

008002fc <exit>:

void
exit(void)
{
  8002fc:	55                   	push   %ebp
  8002fd:	89 e5                	mov    %esp,%ebp
  8002ff:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800302:	e8 e1 12 00 00       	call   8015e8 <sys_exit_env>
}
  800307:	90                   	nop
  800308:	c9                   	leave  
  800309:	c3                   	ret    

0080030a <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80030a:	55                   	push   %ebp
  80030b:	89 e5                	mov    %esp,%ebp
  80030d:	53                   	push   %ebx
  80030e:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800311:	8b 45 0c             	mov    0xc(%ebp),%eax
  800314:	8b 00                	mov    (%eax),%eax
  800316:	8d 48 01             	lea    0x1(%eax),%ecx
  800319:	8b 55 0c             	mov    0xc(%ebp),%edx
  80031c:	89 0a                	mov    %ecx,(%edx)
  80031e:	8b 55 08             	mov    0x8(%ebp),%edx
  800321:	88 d1                	mov    %dl,%cl
  800323:	8b 55 0c             	mov    0xc(%ebp),%edx
  800326:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80032a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032d:	8b 00                	mov    (%eax),%eax
  80032f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800334:	75 30                	jne    800366 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800336:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80033c:	a0 40 30 80 00       	mov    0x803040,%al
  800341:	0f b6 c0             	movzbl %al,%eax
  800344:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800347:	8b 09                	mov    (%ecx),%ecx
  800349:	89 cb                	mov    %ecx,%ebx
  80034b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80034e:	83 c1 08             	add    $0x8,%ecx
  800351:	52                   	push   %edx
  800352:	50                   	push   %eax
  800353:	53                   	push   %ebx
  800354:	51                   	push   %ecx
  800355:	e8 a0 0f 00 00       	call   8012fa <sys_cputs>
  80035a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80035d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800360:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800366:	8b 45 0c             	mov    0xc(%ebp),%eax
  800369:	8b 40 04             	mov    0x4(%eax),%eax
  80036c:	8d 50 01             	lea    0x1(%eax),%edx
  80036f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800372:	89 50 04             	mov    %edx,0x4(%eax)
}
  800375:	90                   	nop
  800376:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800379:	c9                   	leave  
  80037a:	c3                   	ret    

0080037b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80037b:	55                   	push   %ebp
  80037c:	89 e5                	mov    %esp,%ebp
  80037e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800384:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80038b:	00 00 00 
	b.cnt = 0;
  80038e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800395:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800398:	ff 75 0c             	pushl  0xc(%ebp)
  80039b:	ff 75 08             	pushl  0x8(%ebp)
  80039e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003a4:	50                   	push   %eax
  8003a5:	68 0a 03 80 00       	push   $0x80030a
  8003aa:	e8 5a 02 00 00       	call   800609 <vprintfmt>
  8003af:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003b2:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003b8:	a0 40 30 80 00       	mov    0x803040,%al
  8003bd:	0f b6 c0             	movzbl %al,%eax
  8003c0:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003c6:	52                   	push   %edx
  8003c7:	50                   	push   %eax
  8003c8:	51                   	push   %ecx
  8003c9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003cf:	83 c0 08             	add    $0x8,%eax
  8003d2:	50                   	push   %eax
  8003d3:	e8 22 0f 00 00       	call   8012fa <sys_cputs>
  8003d8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003db:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8003e2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003e8:	c9                   	leave  
  8003e9:	c3                   	ret    

008003ea <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8003ea:	55                   	push   %ebp
  8003eb:	89 e5                	mov    %esp,%ebp
  8003ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003f0:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8003f7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	83 ec 08             	sub    $0x8,%esp
  800403:	ff 75 f4             	pushl  -0xc(%ebp)
  800406:	50                   	push   %eax
  800407:	e8 6f ff ff ff       	call   80037b <vcprintf>
  80040c:	83 c4 10             	add    $0x10,%esp
  80040f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800412:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800415:	c9                   	leave  
  800416:	c3                   	ret    

00800417 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80041d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800424:	8b 45 08             	mov    0x8(%ebp),%eax
  800427:	c1 e0 08             	shl    $0x8,%eax
  80042a:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  80042f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800432:	83 c0 04             	add    $0x4,%eax
  800435:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043b:	83 ec 08             	sub    $0x8,%esp
  80043e:	ff 75 f4             	pushl  -0xc(%ebp)
  800441:	50                   	push   %eax
  800442:	e8 34 ff ff ff       	call   80037b <vcprintf>
  800447:	83 c4 10             	add    $0x10,%esp
  80044a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80044d:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800454:	07 00 00 

	return cnt;
  800457:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80045a:	c9                   	leave  
  80045b:	c3                   	ret    

0080045c <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80045c:	55                   	push   %ebp
  80045d:	89 e5                	mov    %esp,%ebp
  80045f:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800462:	e8 d7 0e 00 00       	call   80133e <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800467:	8d 45 0c             	lea    0xc(%ebp),%eax
  80046a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80046d:	8b 45 08             	mov    0x8(%ebp),%eax
  800470:	83 ec 08             	sub    $0x8,%esp
  800473:	ff 75 f4             	pushl  -0xc(%ebp)
  800476:	50                   	push   %eax
  800477:	e8 ff fe ff ff       	call   80037b <vcprintf>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800482:	e8 d1 0e 00 00       	call   801358 <sys_unlock_cons>
	return cnt;
  800487:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80048a:	c9                   	leave  
  80048b:	c3                   	ret    

0080048c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80048c:	55                   	push   %ebp
  80048d:	89 e5                	mov    %esp,%ebp
  80048f:	53                   	push   %ebx
  800490:	83 ec 14             	sub    $0x14,%esp
  800493:	8b 45 10             	mov    0x10(%ebp),%eax
  800496:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800499:	8b 45 14             	mov    0x14(%ebp),%eax
  80049c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80049f:	8b 45 18             	mov    0x18(%ebp),%eax
  8004a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8004a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004aa:	77 55                	ja     800501 <printnum+0x75>
  8004ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004af:	72 05                	jb     8004b6 <printnum+0x2a>
  8004b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004b4:	77 4b                	ja     800501 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004b6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004b9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004bc:	8b 45 18             	mov    0x18(%ebp),%eax
  8004bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8004c4:	52                   	push   %edx
  8004c5:	50                   	push   %eax
  8004c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8004cc:	e8 5f 15 00 00       	call   801a30 <__udivdi3>
  8004d1:	83 c4 10             	add    $0x10,%esp
  8004d4:	83 ec 04             	sub    $0x4,%esp
  8004d7:	ff 75 20             	pushl  0x20(%ebp)
  8004da:	53                   	push   %ebx
  8004db:	ff 75 18             	pushl  0x18(%ebp)
  8004de:	52                   	push   %edx
  8004df:	50                   	push   %eax
  8004e0:	ff 75 0c             	pushl  0xc(%ebp)
  8004e3:	ff 75 08             	pushl  0x8(%ebp)
  8004e6:	e8 a1 ff ff ff       	call   80048c <printnum>
  8004eb:	83 c4 20             	add    $0x20,%esp
  8004ee:	eb 1a                	jmp    80050a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004f0:	83 ec 08             	sub    $0x8,%esp
  8004f3:	ff 75 0c             	pushl  0xc(%ebp)
  8004f6:	ff 75 20             	pushl  0x20(%ebp)
  8004f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fc:	ff d0                	call   *%eax
  8004fe:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800501:	ff 4d 1c             	decl   0x1c(%ebp)
  800504:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800508:	7f e6                	jg     8004f0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80050a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80050d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800512:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800515:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800518:	53                   	push   %ebx
  800519:	51                   	push   %ecx
  80051a:	52                   	push   %edx
  80051b:	50                   	push   %eax
  80051c:	e8 1f 16 00 00       	call   801b40 <__umoddi3>
  800521:	83 c4 10             	add    $0x10,%esp
  800524:	05 14 21 80 00       	add    $0x802114,%eax
  800529:	8a 00                	mov    (%eax),%al
  80052b:	0f be c0             	movsbl %al,%eax
  80052e:	83 ec 08             	sub    $0x8,%esp
  800531:	ff 75 0c             	pushl  0xc(%ebp)
  800534:	50                   	push   %eax
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	ff d0                	call   *%eax
  80053a:	83 c4 10             	add    $0x10,%esp
}
  80053d:	90                   	nop
  80053e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800541:	c9                   	leave  
  800542:	c3                   	ret    

00800543 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800543:	55                   	push   %ebp
  800544:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800546:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80054a:	7e 1c                	jle    800568 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80054c:	8b 45 08             	mov    0x8(%ebp),%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	8d 50 08             	lea    0x8(%eax),%edx
  800554:	8b 45 08             	mov    0x8(%ebp),%eax
  800557:	89 10                	mov    %edx,(%eax)
  800559:	8b 45 08             	mov    0x8(%ebp),%eax
  80055c:	8b 00                	mov    (%eax),%eax
  80055e:	83 e8 08             	sub    $0x8,%eax
  800561:	8b 50 04             	mov    0x4(%eax),%edx
  800564:	8b 00                	mov    (%eax),%eax
  800566:	eb 40                	jmp    8005a8 <getuint+0x65>
	else if (lflag)
  800568:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80056c:	74 1e                	je     80058c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80056e:	8b 45 08             	mov    0x8(%ebp),%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	8d 50 04             	lea    0x4(%eax),%edx
  800576:	8b 45 08             	mov    0x8(%ebp),%eax
  800579:	89 10                	mov    %edx,(%eax)
  80057b:	8b 45 08             	mov    0x8(%ebp),%eax
  80057e:	8b 00                	mov    (%eax),%eax
  800580:	83 e8 04             	sub    $0x4,%eax
  800583:	8b 00                	mov    (%eax),%eax
  800585:	ba 00 00 00 00       	mov    $0x0,%edx
  80058a:	eb 1c                	jmp    8005a8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80058c:	8b 45 08             	mov    0x8(%ebp),%eax
  80058f:	8b 00                	mov    (%eax),%eax
  800591:	8d 50 04             	lea    0x4(%eax),%edx
  800594:	8b 45 08             	mov    0x8(%ebp),%eax
  800597:	89 10                	mov    %edx,(%eax)
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	8b 00                	mov    (%eax),%eax
  80059e:	83 e8 04             	sub    $0x4,%eax
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005a8:	5d                   	pop    %ebp
  8005a9:	c3                   	ret    

008005aa <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005aa:	55                   	push   %ebp
  8005ab:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005ad:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005b1:	7e 1c                	jle    8005cf <getint+0x25>
		return va_arg(*ap, long long);
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	8b 00                	mov    (%eax),%eax
  8005b8:	8d 50 08             	lea    0x8(%eax),%edx
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	89 10                	mov    %edx,(%eax)
  8005c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c3:	8b 00                	mov    (%eax),%eax
  8005c5:	83 e8 08             	sub    $0x8,%eax
  8005c8:	8b 50 04             	mov    0x4(%eax),%edx
  8005cb:	8b 00                	mov    (%eax),%eax
  8005cd:	eb 38                	jmp    800607 <getint+0x5d>
	else if (lflag)
  8005cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005d3:	74 1a                	je     8005ef <getint+0x45>
		return va_arg(*ap, long);
  8005d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d8:	8b 00                	mov    (%eax),%eax
  8005da:	8d 50 04             	lea    0x4(%eax),%edx
  8005dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e0:	89 10                	mov    %edx,(%eax)
  8005e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e5:	8b 00                	mov    (%eax),%eax
  8005e7:	83 e8 04             	sub    $0x4,%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	99                   	cltd   
  8005ed:	eb 18                	jmp    800607 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	8b 00                	mov    (%eax),%eax
  8005f4:	8d 50 04             	lea    0x4(%eax),%edx
  8005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fa:	89 10                	mov    %edx,(%eax)
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	8b 00                	mov    (%eax),%eax
  800601:	83 e8 04             	sub    $0x4,%eax
  800604:	8b 00                	mov    (%eax),%eax
  800606:	99                   	cltd   
}
  800607:	5d                   	pop    %ebp
  800608:	c3                   	ret    

00800609 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800609:	55                   	push   %ebp
  80060a:	89 e5                	mov    %esp,%ebp
  80060c:	56                   	push   %esi
  80060d:	53                   	push   %ebx
  80060e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800611:	eb 17                	jmp    80062a <vprintfmt+0x21>
			if (ch == '\0')
  800613:	85 db                	test   %ebx,%ebx
  800615:	0f 84 c1 03 00 00    	je     8009dc <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80061b:	83 ec 08             	sub    $0x8,%esp
  80061e:	ff 75 0c             	pushl  0xc(%ebp)
  800621:	53                   	push   %ebx
  800622:	8b 45 08             	mov    0x8(%ebp),%eax
  800625:	ff d0                	call   *%eax
  800627:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80062a:	8b 45 10             	mov    0x10(%ebp),%eax
  80062d:	8d 50 01             	lea    0x1(%eax),%edx
  800630:	89 55 10             	mov    %edx,0x10(%ebp)
  800633:	8a 00                	mov    (%eax),%al
  800635:	0f b6 d8             	movzbl %al,%ebx
  800638:	83 fb 25             	cmp    $0x25,%ebx
  80063b:	75 d6                	jne    800613 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80063d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800641:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800648:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80064f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800656:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80065d:	8b 45 10             	mov    0x10(%ebp),%eax
  800660:	8d 50 01             	lea    0x1(%eax),%edx
  800663:	89 55 10             	mov    %edx,0x10(%ebp)
  800666:	8a 00                	mov    (%eax),%al
  800668:	0f b6 d8             	movzbl %al,%ebx
  80066b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80066e:	83 f8 5b             	cmp    $0x5b,%eax
  800671:	0f 87 3d 03 00 00    	ja     8009b4 <vprintfmt+0x3ab>
  800677:	8b 04 85 38 21 80 00 	mov    0x802138(,%eax,4),%eax
  80067e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800680:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800684:	eb d7                	jmp    80065d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800686:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80068a:	eb d1                	jmp    80065d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80068c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800693:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800696:	89 d0                	mov    %edx,%eax
  800698:	c1 e0 02             	shl    $0x2,%eax
  80069b:	01 d0                	add    %edx,%eax
  80069d:	01 c0                	add    %eax,%eax
  80069f:	01 d8                	add    %ebx,%eax
  8006a1:	83 e8 30             	sub    $0x30,%eax
  8006a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8006aa:	8a 00                	mov    (%eax),%al
  8006ac:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006af:	83 fb 2f             	cmp    $0x2f,%ebx
  8006b2:	7e 3e                	jle    8006f2 <vprintfmt+0xe9>
  8006b4:	83 fb 39             	cmp    $0x39,%ebx
  8006b7:	7f 39                	jg     8006f2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006b9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006bc:	eb d5                	jmp    800693 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006be:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c1:	83 c0 04             	add    $0x4,%eax
  8006c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8006c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ca:	83 e8 04             	sub    $0x4,%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006d2:	eb 1f                	jmp    8006f3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d8:	79 83                	jns    80065d <vprintfmt+0x54>
				width = 0;
  8006da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006e1:	e9 77 ff ff ff       	jmp    80065d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006e6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006ed:	e9 6b ff ff ff       	jmp    80065d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006f2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f7:	0f 89 60 ff ff ff    	jns    80065d <vprintfmt+0x54>
				width = precision, precision = -1;
  8006fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800700:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800703:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80070a:	e9 4e ff ff ff       	jmp    80065d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80070f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800712:	e9 46 ff ff ff       	jmp    80065d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800717:	8b 45 14             	mov    0x14(%ebp),%eax
  80071a:	83 c0 04             	add    $0x4,%eax
  80071d:	89 45 14             	mov    %eax,0x14(%ebp)
  800720:	8b 45 14             	mov    0x14(%ebp),%eax
  800723:	83 e8 04             	sub    $0x4,%eax
  800726:	8b 00                	mov    (%eax),%eax
  800728:	83 ec 08             	sub    $0x8,%esp
  80072b:	ff 75 0c             	pushl  0xc(%ebp)
  80072e:	50                   	push   %eax
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
			break;
  800737:	e9 9b 02 00 00       	jmp    8009d7 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80073c:	8b 45 14             	mov    0x14(%ebp),%eax
  80073f:	83 c0 04             	add    $0x4,%eax
  800742:	89 45 14             	mov    %eax,0x14(%ebp)
  800745:	8b 45 14             	mov    0x14(%ebp),%eax
  800748:	83 e8 04             	sub    $0x4,%eax
  80074b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80074d:	85 db                	test   %ebx,%ebx
  80074f:	79 02                	jns    800753 <vprintfmt+0x14a>
				err = -err;
  800751:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800753:	83 fb 64             	cmp    $0x64,%ebx
  800756:	7f 0b                	jg     800763 <vprintfmt+0x15a>
  800758:	8b 34 9d 80 1f 80 00 	mov    0x801f80(,%ebx,4),%esi
  80075f:	85 f6                	test   %esi,%esi
  800761:	75 19                	jne    80077c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800763:	53                   	push   %ebx
  800764:	68 25 21 80 00       	push   $0x802125
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	ff 75 08             	pushl  0x8(%ebp)
  80076f:	e8 70 02 00 00       	call   8009e4 <printfmt>
  800774:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800777:	e9 5b 02 00 00       	jmp    8009d7 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80077c:	56                   	push   %esi
  80077d:	68 2e 21 80 00       	push   $0x80212e
  800782:	ff 75 0c             	pushl  0xc(%ebp)
  800785:	ff 75 08             	pushl  0x8(%ebp)
  800788:	e8 57 02 00 00       	call   8009e4 <printfmt>
  80078d:	83 c4 10             	add    $0x10,%esp
			break;
  800790:	e9 42 02 00 00       	jmp    8009d7 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800795:	8b 45 14             	mov    0x14(%ebp),%eax
  800798:	83 c0 04             	add    $0x4,%eax
  80079b:	89 45 14             	mov    %eax,0x14(%ebp)
  80079e:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a1:	83 e8 04             	sub    $0x4,%eax
  8007a4:	8b 30                	mov    (%eax),%esi
  8007a6:	85 f6                	test   %esi,%esi
  8007a8:	75 05                	jne    8007af <vprintfmt+0x1a6>
				p = "(null)";
  8007aa:	be 31 21 80 00       	mov    $0x802131,%esi
			if (width > 0 && padc != '-')
  8007af:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b3:	7e 6d                	jle    800822 <vprintfmt+0x219>
  8007b5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007b9:	74 67                	je     800822 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007be:	83 ec 08             	sub    $0x8,%esp
  8007c1:	50                   	push   %eax
  8007c2:	56                   	push   %esi
  8007c3:	e8 1e 03 00 00       	call   800ae6 <strnlen>
  8007c8:	83 c4 10             	add    $0x10,%esp
  8007cb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007ce:	eb 16                	jmp    8007e6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007d0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	50                   	push   %eax
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007e3:	ff 4d e4             	decl   -0x1c(%ebp)
  8007e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ea:	7f e4                	jg     8007d0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007ec:	eb 34                	jmp    800822 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007ee:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007f2:	74 1c                	je     800810 <vprintfmt+0x207>
  8007f4:	83 fb 1f             	cmp    $0x1f,%ebx
  8007f7:	7e 05                	jle    8007fe <vprintfmt+0x1f5>
  8007f9:	83 fb 7e             	cmp    $0x7e,%ebx
  8007fc:	7e 12                	jle    800810 <vprintfmt+0x207>
					putch('?', putdat);
  8007fe:	83 ec 08             	sub    $0x8,%esp
  800801:	ff 75 0c             	pushl  0xc(%ebp)
  800804:	6a 3f                	push   $0x3f
  800806:	8b 45 08             	mov    0x8(%ebp),%eax
  800809:	ff d0                	call   *%eax
  80080b:	83 c4 10             	add    $0x10,%esp
  80080e:	eb 0f                	jmp    80081f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	ff 75 0c             	pushl  0xc(%ebp)
  800816:	53                   	push   %ebx
  800817:	8b 45 08             	mov    0x8(%ebp),%eax
  80081a:	ff d0                	call   *%eax
  80081c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80081f:	ff 4d e4             	decl   -0x1c(%ebp)
  800822:	89 f0                	mov    %esi,%eax
  800824:	8d 70 01             	lea    0x1(%eax),%esi
  800827:	8a 00                	mov    (%eax),%al
  800829:	0f be d8             	movsbl %al,%ebx
  80082c:	85 db                	test   %ebx,%ebx
  80082e:	74 24                	je     800854 <vprintfmt+0x24b>
  800830:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800834:	78 b8                	js     8007ee <vprintfmt+0x1e5>
  800836:	ff 4d e0             	decl   -0x20(%ebp)
  800839:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80083d:	79 af                	jns    8007ee <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80083f:	eb 13                	jmp    800854 <vprintfmt+0x24b>
				putch(' ', putdat);
  800841:	83 ec 08             	sub    $0x8,%esp
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	6a 20                	push   $0x20
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	ff d0                	call   *%eax
  80084e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800851:	ff 4d e4             	decl   -0x1c(%ebp)
  800854:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800858:	7f e7                	jg     800841 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80085a:	e9 78 01 00 00       	jmp    8009d7 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 e8             	pushl  -0x18(%ebp)
  800865:	8d 45 14             	lea    0x14(%ebp),%eax
  800868:	50                   	push   %eax
  800869:	e8 3c fd ff ff       	call   8005aa <getint>
  80086e:	83 c4 10             	add    $0x10,%esp
  800871:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800874:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800877:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80087d:	85 d2                	test   %edx,%edx
  80087f:	79 23                	jns    8008a4 <vprintfmt+0x29b>
				putch('-', putdat);
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	ff 75 0c             	pushl  0xc(%ebp)
  800887:	6a 2d                	push   $0x2d
  800889:	8b 45 08             	mov    0x8(%ebp),%eax
  80088c:	ff d0                	call   *%eax
  80088e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800891:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800894:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800897:	f7 d8                	neg    %eax
  800899:	83 d2 00             	adc    $0x0,%edx
  80089c:	f7 da                	neg    %edx
  80089e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008a4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008ab:	e9 bc 00 00 00       	jmp    80096c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008b0:	83 ec 08             	sub    $0x8,%esp
  8008b3:	ff 75 e8             	pushl  -0x18(%ebp)
  8008b6:	8d 45 14             	lea    0x14(%ebp),%eax
  8008b9:	50                   	push   %eax
  8008ba:	e8 84 fc ff ff       	call   800543 <getuint>
  8008bf:	83 c4 10             	add    $0x10,%esp
  8008c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008c8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008cf:	e9 98 00 00 00       	jmp    80096c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008d4:	83 ec 08             	sub    $0x8,%esp
  8008d7:	ff 75 0c             	pushl  0xc(%ebp)
  8008da:	6a 58                	push   $0x58
  8008dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008df:	ff d0                	call   *%eax
  8008e1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ea:	6a 58                	push   $0x58
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	ff d0                	call   *%eax
  8008f1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008f4:	83 ec 08             	sub    $0x8,%esp
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	6a 58                	push   $0x58
  8008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ff:	ff d0                	call   *%eax
  800901:	83 c4 10             	add    $0x10,%esp
			break;
  800904:	e9 ce 00 00 00       	jmp    8009d7 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800909:	83 ec 08             	sub    $0x8,%esp
  80090c:	ff 75 0c             	pushl  0xc(%ebp)
  80090f:	6a 30                	push   $0x30
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	ff d0                	call   *%eax
  800916:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	ff 75 0c             	pushl  0xc(%ebp)
  80091f:	6a 78                	push   $0x78
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	ff d0                	call   *%eax
  800926:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800929:	8b 45 14             	mov    0x14(%ebp),%eax
  80092c:	83 c0 04             	add    $0x4,%eax
  80092f:	89 45 14             	mov    %eax,0x14(%ebp)
  800932:	8b 45 14             	mov    0x14(%ebp),%eax
  800935:	83 e8 04             	sub    $0x4,%eax
  800938:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80093a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80093d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800944:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80094b:	eb 1f                	jmp    80096c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80094d:	83 ec 08             	sub    $0x8,%esp
  800950:	ff 75 e8             	pushl  -0x18(%ebp)
  800953:	8d 45 14             	lea    0x14(%ebp),%eax
  800956:	50                   	push   %eax
  800957:	e8 e7 fb ff ff       	call   800543 <getuint>
  80095c:	83 c4 10             	add    $0x10,%esp
  80095f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800962:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800965:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80096c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800970:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	52                   	push   %edx
  800977:	ff 75 e4             	pushl  -0x1c(%ebp)
  80097a:	50                   	push   %eax
  80097b:	ff 75 f4             	pushl  -0xc(%ebp)
  80097e:	ff 75 f0             	pushl  -0x10(%ebp)
  800981:	ff 75 0c             	pushl  0xc(%ebp)
  800984:	ff 75 08             	pushl  0x8(%ebp)
  800987:	e8 00 fb ff ff       	call   80048c <printnum>
  80098c:	83 c4 20             	add    $0x20,%esp
			break;
  80098f:	eb 46                	jmp    8009d7 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 0c             	pushl  0xc(%ebp)
  800997:	53                   	push   %ebx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	ff d0                	call   *%eax
  80099d:	83 c4 10             	add    $0x10,%esp
			break;
  8009a0:	eb 35                	jmp    8009d7 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009a2:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009a9:	eb 2c                	jmp    8009d7 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009ab:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009b2:	eb 23                	jmp    8009d7 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ba:	6a 25                	push   $0x25
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009c4:	ff 4d 10             	decl   0x10(%ebp)
  8009c7:	eb 03                	jmp    8009cc <vprintfmt+0x3c3>
  8009c9:	ff 4d 10             	decl   0x10(%ebp)
  8009cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8009cf:	48                   	dec    %eax
  8009d0:	8a 00                	mov    (%eax),%al
  8009d2:	3c 25                	cmp    $0x25,%al
  8009d4:	75 f3                	jne    8009c9 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8009d6:	90                   	nop
		}
	}
  8009d7:	e9 35 fc ff ff       	jmp    800611 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009dc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009e0:	5b                   	pop    %ebx
  8009e1:	5e                   	pop    %esi
  8009e2:	5d                   	pop    %ebp
  8009e3:	c3                   	ret    

008009e4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009e4:	55                   	push   %ebp
  8009e5:	89 e5                	mov    %esp,%ebp
  8009e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8009ed:	83 c0 04             	add    $0x4,%eax
  8009f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f9:	50                   	push   %eax
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	ff 75 08             	pushl  0x8(%ebp)
  800a00:	e8 04 fc ff ff       	call   800609 <vprintfmt>
  800a05:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a08:	90                   	nop
  800a09:	c9                   	leave  
  800a0a:	c3                   	ret    

00800a0b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a0b:	55                   	push   %ebp
  800a0c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a11:	8b 40 08             	mov    0x8(%eax),%eax
  800a14:	8d 50 01             	lea    0x1(%eax),%edx
  800a17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a20:	8b 10                	mov    (%eax),%edx
  800a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a25:	8b 40 04             	mov    0x4(%eax),%eax
  800a28:	39 c2                	cmp    %eax,%edx
  800a2a:	73 12                	jae    800a3e <sprintputch+0x33>
		*b->buf++ = ch;
  800a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2f:	8b 00                	mov    (%eax),%eax
  800a31:	8d 48 01             	lea    0x1(%eax),%ecx
  800a34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a37:	89 0a                	mov    %ecx,(%edx)
  800a39:	8b 55 08             	mov    0x8(%ebp),%edx
  800a3c:	88 10                	mov    %dl,(%eax)
}
  800a3e:	90                   	nop
  800a3f:	5d                   	pop    %ebp
  800a40:	c3                   	ret    

00800a41 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
  800a44:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a53:	8b 45 08             	mov    0x8(%ebp),%eax
  800a56:	01 d0                	add    %edx,%eax
  800a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a62:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a66:	74 06                	je     800a6e <vsnprintf+0x2d>
  800a68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a6c:	7f 07                	jg     800a75 <vsnprintf+0x34>
		return -E_INVAL;
  800a6e:	b8 03 00 00 00       	mov    $0x3,%eax
  800a73:	eb 20                	jmp    800a95 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a75:	ff 75 14             	pushl  0x14(%ebp)
  800a78:	ff 75 10             	pushl  0x10(%ebp)
  800a7b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a7e:	50                   	push   %eax
  800a7f:	68 0b 0a 80 00       	push   $0x800a0b
  800a84:	e8 80 fb ff ff       	call   800609 <vprintfmt>
  800a89:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a8f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a95:	c9                   	leave  
  800a96:	c3                   	ret    

00800a97 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a97:	55                   	push   %ebp
  800a98:	89 e5                	mov    %esp,%ebp
  800a9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a9d:	8d 45 10             	lea    0x10(%ebp),%eax
  800aa0:	83 c0 04             	add    $0x4,%eax
  800aa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800aa6:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa9:	ff 75 f4             	pushl  -0xc(%ebp)
  800aac:	50                   	push   %eax
  800aad:	ff 75 0c             	pushl  0xc(%ebp)
  800ab0:	ff 75 08             	pushl  0x8(%ebp)
  800ab3:	e8 89 ff ff ff       	call   800a41 <vsnprintf>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800abe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac1:	c9                   	leave  
  800ac2:	c3                   	ret    

00800ac3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ac3:	55                   	push   %ebp
  800ac4:	89 e5                	mov    %esp,%ebp
  800ac6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ac9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ad0:	eb 06                	jmp    800ad8 <strlen+0x15>
		n++;
  800ad2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ad5:	ff 45 08             	incl   0x8(%ebp)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	84 c0                	test   %al,%al
  800adf:	75 f1                	jne    800ad2 <strlen+0xf>
		n++;
	return n;
  800ae1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ae4:	c9                   	leave  
  800ae5:	c3                   	ret    

00800ae6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ae6:	55                   	push   %ebp
  800ae7:	89 e5                	mov    %esp,%ebp
  800ae9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af3:	eb 09                	jmp    800afe <strnlen+0x18>
		n++;
  800af5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800af8:	ff 45 08             	incl   0x8(%ebp)
  800afb:	ff 4d 0c             	decl   0xc(%ebp)
  800afe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b02:	74 09                	je     800b0d <strnlen+0x27>
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	8a 00                	mov    (%eax),%al
  800b09:	84 c0                	test   %al,%al
  800b0b:	75 e8                	jne    800af5 <strnlen+0xf>
		n++;
	return n;
  800b0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b10:	c9                   	leave  
  800b11:	c3                   	ret    

00800b12 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
  800b15:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b1e:	90                   	nop
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8d 50 01             	lea    0x1(%eax),%edx
  800b25:	89 55 08             	mov    %edx,0x8(%ebp)
  800b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b2e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b31:	8a 12                	mov    (%edx),%dl
  800b33:	88 10                	mov    %dl,(%eax)
  800b35:	8a 00                	mov    (%eax),%al
  800b37:	84 c0                	test   %al,%al
  800b39:	75 e4                	jne    800b1f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b3e:	c9                   	leave  
  800b3f:	c3                   	ret    

00800b40 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b53:	eb 1f                	jmp    800b74 <strncpy+0x34>
		*dst++ = *src;
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8d 50 01             	lea    0x1(%eax),%edx
  800b5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b61:	8a 12                	mov    (%edx),%dl
  800b63:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b68:	8a 00                	mov    (%eax),%al
  800b6a:	84 c0                	test   %al,%al
  800b6c:	74 03                	je     800b71 <strncpy+0x31>
			src++;
  800b6e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b71:	ff 45 fc             	incl   -0x4(%ebp)
  800b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b77:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b7a:	72 d9                	jb     800b55 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b7f:	c9                   	leave  
  800b80:	c3                   	ret    

00800b81 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
  800b84:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b91:	74 30                	je     800bc3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b93:	eb 16                	jmp    800bab <strlcpy+0x2a>
			*dst++ = *src++;
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8d 50 01             	lea    0x1(%eax),%edx
  800b9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ba7:	8a 12                	mov    (%edx),%dl
  800ba9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bab:	ff 4d 10             	decl   0x10(%ebp)
  800bae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb2:	74 09                	je     800bbd <strlcpy+0x3c>
  800bb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb7:	8a 00                	mov    (%eax),%al
  800bb9:	84 c0                	test   %al,%al
  800bbb:	75 d8                	jne    800b95 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bc3:	8b 55 08             	mov    0x8(%ebp),%edx
  800bc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc9:	29 c2                	sub    %eax,%edx
  800bcb:	89 d0                	mov    %edx,%eax
}
  800bcd:	c9                   	leave  
  800bce:	c3                   	ret    

00800bcf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bcf:	55                   	push   %ebp
  800bd0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bd2:	eb 06                	jmp    800bda <strcmp+0xb>
		p++, q++;
  800bd4:	ff 45 08             	incl   0x8(%ebp)
  800bd7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	8a 00                	mov    (%eax),%al
  800bdf:	84 c0                	test   %al,%al
  800be1:	74 0e                	je     800bf1 <strcmp+0x22>
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	8a 10                	mov    (%eax),%dl
  800be8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800beb:	8a 00                	mov    (%eax),%al
  800bed:	38 c2                	cmp    %al,%dl
  800bef:	74 e3                	je     800bd4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	0f b6 d0             	movzbl %al,%edx
  800bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	0f b6 c0             	movzbl %al,%eax
  800c01:	29 c2                	sub    %eax,%edx
  800c03:	89 d0                	mov    %edx,%eax
}
  800c05:	5d                   	pop    %ebp
  800c06:	c3                   	ret    

00800c07 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c07:	55                   	push   %ebp
  800c08:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c0a:	eb 09                	jmp    800c15 <strncmp+0xe>
		n--, p++, q++;
  800c0c:	ff 4d 10             	decl   0x10(%ebp)
  800c0f:	ff 45 08             	incl   0x8(%ebp)
  800c12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c19:	74 17                	je     800c32 <strncmp+0x2b>
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	84 c0                	test   %al,%al
  800c22:	74 0e                	je     800c32 <strncmp+0x2b>
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8a 10                	mov    (%eax),%dl
  800c29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2c:	8a 00                	mov    (%eax),%al
  800c2e:	38 c2                	cmp    %al,%dl
  800c30:	74 da                	je     800c0c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c36:	75 07                	jne    800c3f <strncmp+0x38>
		return 0;
  800c38:	b8 00 00 00 00       	mov    $0x0,%eax
  800c3d:	eb 14                	jmp    800c53 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	0f b6 d0             	movzbl %al,%edx
  800c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4a:	8a 00                	mov    (%eax),%al
  800c4c:	0f b6 c0             	movzbl %al,%eax
  800c4f:	29 c2                	sub    %eax,%edx
  800c51:	89 d0                	mov    %edx,%eax
}
  800c53:	5d                   	pop    %ebp
  800c54:	c3                   	ret    

00800c55 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c55:	55                   	push   %ebp
  800c56:	89 e5                	mov    %esp,%ebp
  800c58:	83 ec 04             	sub    $0x4,%esp
  800c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c61:	eb 12                	jmp    800c75 <strchr+0x20>
		if (*s == c)
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c6b:	75 05                	jne    800c72 <strchr+0x1d>
			return (char *) s;
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	eb 11                	jmp    800c83 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c72:	ff 45 08             	incl   0x8(%ebp)
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	8a 00                	mov    (%eax),%al
  800c7a:	84 c0                	test   %al,%al
  800c7c:	75 e5                	jne    800c63 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c83:	c9                   	leave  
  800c84:	c3                   	ret    

00800c85 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c85:	55                   	push   %ebp
  800c86:	89 e5                	mov    %esp,%ebp
  800c88:	83 ec 04             	sub    $0x4,%esp
  800c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c91:	eb 0d                	jmp    800ca0 <strfind+0x1b>
		if (*s == c)
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c9b:	74 0e                	je     800cab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	75 ea                	jne    800c93 <strfind+0xe>
  800ca9:	eb 01                	jmp    800cac <strfind+0x27>
		if (*s == c)
			break;
  800cab:	90                   	nop
	return (char *) s;
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800caf:	c9                   	leave  
  800cb0:	c3                   	ret    

00800cb1 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800cb1:	55                   	push   %ebp
  800cb2:	89 e5                	mov    %esp,%ebp
  800cb4:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800cbd:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800cc1:	76 63                	jbe    800d26 <memset+0x75>
		uint64 data_block = c;
  800cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc6:	99                   	cltd   
  800cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cca:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ccd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cd3:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800cd7:	c1 e0 08             	shl    $0x8,%eax
  800cda:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cdd:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ce0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ce3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ce6:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800cea:	c1 e0 10             	shl    $0x10,%eax
  800ced:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cf0:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800cf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf9:	89 c2                	mov    %eax,%edx
  800cfb:	b8 00 00 00 00       	mov    $0x0,%eax
  800d00:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d03:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d06:	eb 18                	jmp    800d20 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d08:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d0b:	8d 41 08             	lea    0x8(%ecx),%eax
  800d0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d17:	89 01                	mov    %eax,(%ecx)
  800d19:	89 51 04             	mov    %edx,0x4(%ecx)
  800d1c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d20:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d24:	77 e2                	ja     800d08 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2a:	74 23                	je     800d4f <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d32:	eb 0e                	jmp    800d42 <memset+0x91>
			*p8++ = (uint8)c;
  800d34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d37:	8d 50 01             	lea    0x1(%eax),%edx
  800d3a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d40:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d42:	8b 45 10             	mov    0x10(%ebp),%eax
  800d45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d48:	89 55 10             	mov    %edx,0x10(%ebp)
  800d4b:	85 c0                	test   %eax,%eax
  800d4d:	75 e5                	jne    800d34 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d52:	c9                   	leave  
  800d53:	c3                   	ret    

00800d54 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d66:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d6a:	76 24                	jbe    800d90 <memcpy+0x3c>
		while(n >= 8){
  800d6c:	eb 1c                	jmp    800d8a <memcpy+0x36>
			*d64 = *s64;
  800d6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d71:	8b 50 04             	mov    0x4(%eax),%edx
  800d74:	8b 00                	mov    (%eax),%eax
  800d76:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d79:	89 01                	mov    %eax,(%ecx)
  800d7b:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d7e:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d82:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d86:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d8a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d8e:	77 de                	ja     800d6e <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d94:	74 31                	je     800dc7 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d99:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800da2:	eb 16                	jmp    800dba <memcpy+0x66>
			*d8++ = *s8++;
  800da4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da7:	8d 50 01             	lea    0x1(%eax),%edx
  800daa:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800dad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800db6:	8a 12                	mov    (%edx),%dl
  800db8:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc3:	85 c0                	test   %eax,%eax
  800dc5:	75 dd                	jne    800da4 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de4:	73 50                	jae    800e36 <memmove+0x6a>
  800de6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dec:	01 d0                	add    %edx,%eax
  800dee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df1:	76 43                	jbe    800e36 <memmove+0x6a>
		s += n;
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800df9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dff:	eb 10                	jmp    800e11 <memmove+0x45>
			*--d = *--s;
  800e01:	ff 4d f8             	decl   -0x8(%ebp)
  800e04:	ff 4d fc             	decl   -0x4(%ebp)
  800e07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0a:	8a 10                	mov    (%eax),%dl
  800e0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e11:	8b 45 10             	mov    0x10(%ebp),%eax
  800e14:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e17:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1a:	85 c0                	test   %eax,%eax
  800e1c:	75 e3                	jne    800e01 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e1e:	eb 23                	jmp    800e43 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e23:	8d 50 01             	lea    0x1(%eax),%edx
  800e26:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e29:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e2f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e32:	8a 12                	mov    (%edx),%dl
  800e34:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e36:	8b 45 10             	mov    0x10(%ebp),%eax
  800e39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3f:	85 c0                	test   %eax,%eax
  800e41:	75 dd                	jne    800e20 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e46:	c9                   	leave  
  800e47:	c3                   	ret    

00800e48 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e48:	55                   	push   %ebp
  800e49:	89 e5                	mov    %esp,%ebp
  800e4b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e57:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e5a:	eb 2a                	jmp    800e86 <memcmp+0x3e>
		if (*s1 != *s2)
  800e5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5f:	8a 10                	mov    (%eax),%dl
  800e61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e64:	8a 00                	mov    (%eax),%al
  800e66:	38 c2                	cmp    %al,%dl
  800e68:	74 16                	je     800e80 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	0f b6 d0             	movzbl %al,%edx
  800e72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e75:	8a 00                	mov    (%eax),%al
  800e77:	0f b6 c0             	movzbl %al,%eax
  800e7a:	29 c2                	sub    %eax,%edx
  800e7c:	89 d0                	mov    %edx,%eax
  800e7e:	eb 18                	jmp    800e98 <memcmp+0x50>
		s1++, s2++;
  800e80:	ff 45 fc             	incl   -0x4(%ebp)
  800e83:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e86:	8b 45 10             	mov    0x10(%ebp),%eax
  800e89:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e8f:	85 c0                	test   %eax,%eax
  800e91:	75 c9                	jne    800e5c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e98:	c9                   	leave  
  800e99:	c3                   	ret    

00800e9a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e9a:	55                   	push   %ebp
  800e9b:	89 e5                	mov    %esp,%ebp
  800e9d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ea0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea6:	01 d0                	add    %edx,%eax
  800ea8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eab:	eb 15                	jmp    800ec2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	0f b6 d0             	movzbl %al,%edx
  800eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb8:	0f b6 c0             	movzbl %al,%eax
  800ebb:	39 c2                	cmp    %eax,%edx
  800ebd:	74 0d                	je     800ecc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ebf:	ff 45 08             	incl   0x8(%ebp)
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ec8:	72 e3                	jb     800ead <memfind+0x13>
  800eca:	eb 01                	jmp    800ecd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ecc:	90                   	nop
	return (void *) s;
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed0:	c9                   	leave  
  800ed1:	c3                   	ret    

00800ed2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ed2:	55                   	push   %ebp
  800ed3:	89 e5                	mov    %esp,%ebp
  800ed5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800edf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ee6:	eb 03                	jmp    800eeb <strtol+0x19>
		s++;
  800ee8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	3c 20                	cmp    $0x20,%al
  800ef2:	74 f4                	je     800ee8 <strtol+0x16>
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	8a 00                	mov    (%eax),%al
  800ef9:	3c 09                	cmp    $0x9,%al
  800efb:	74 eb                	je     800ee8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	3c 2b                	cmp    $0x2b,%al
  800f04:	75 05                	jne    800f0b <strtol+0x39>
		s++;
  800f06:	ff 45 08             	incl   0x8(%ebp)
  800f09:	eb 13                	jmp    800f1e <strtol+0x4c>
	else if (*s == '-')
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	3c 2d                	cmp    $0x2d,%al
  800f12:	75 0a                	jne    800f1e <strtol+0x4c>
		s++, neg = 1;
  800f14:	ff 45 08             	incl   0x8(%ebp)
  800f17:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f22:	74 06                	je     800f2a <strtol+0x58>
  800f24:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f28:	75 20                	jne    800f4a <strtol+0x78>
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	3c 30                	cmp    $0x30,%al
  800f31:	75 17                	jne    800f4a <strtol+0x78>
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	40                   	inc    %eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	3c 78                	cmp    $0x78,%al
  800f3b:	75 0d                	jne    800f4a <strtol+0x78>
		s += 2, base = 16;
  800f3d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f41:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f48:	eb 28                	jmp    800f72 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4e:	75 15                	jne    800f65 <strtol+0x93>
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	3c 30                	cmp    $0x30,%al
  800f57:	75 0c                	jne    800f65 <strtol+0x93>
		s++, base = 8;
  800f59:	ff 45 08             	incl   0x8(%ebp)
  800f5c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f63:	eb 0d                	jmp    800f72 <strtol+0xa0>
	else if (base == 0)
  800f65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f69:	75 07                	jne    800f72 <strtol+0xa0>
		base = 10;
  800f6b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	3c 2f                	cmp    $0x2f,%al
  800f79:	7e 19                	jle    800f94 <strtol+0xc2>
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	3c 39                	cmp    $0x39,%al
  800f82:	7f 10                	jg     800f94 <strtol+0xc2>
			dig = *s - '0';
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	0f be c0             	movsbl %al,%eax
  800f8c:	83 e8 30             	sub    $0x30,%eax
  800f8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f92:	eb 42                	jmp    800fd6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	3c 60                	cmp    $0x60,%al
  800f9b:	7e 19                	jle    800fb6 <strtol+0xe4>
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	3c 7a                	cmp    $0x7a,%al
  800fa4:	7f 10                	jg     800fb6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	0f be c0             	movsbl %al,%eax
  800fae:	83 e8 57             	sub    $0x57,%eax
  800fb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb4:	eb 20                	jmp    800fd6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	3c 40                	cmp    $0x40,%al
  800fbd:	7e 39                	jle    800ff8 <strtol+0x126>
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	8a 00                	mov    (%eax),%al
  800fc4:	3c 5a                	cmp    $0x5a,%al
  800fc6:	7f 30                	jg     800ff8 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	0f be c0             	movsbl %al,%eax
  800fd0:	83 e8 37             	sub    $0x37,%eax
  800fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fdc:	7d 19                	jge    800ff7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fde:	ff 45 08             	incl   0x8(%ebp)
  800fe1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fe8:	89 c2                	mov    %eax,%edx
  800fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fed:	01 d0                	add    %edx,%eax
  800fef:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ff2:	e9 7b ff ff ff       	jmp    800f72 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800ff7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ff8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffc:	74 08                	je     801006 <strtol+0x134>
		*endptr = (char *) s;
  800ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801001:	8b 55 08             	mov    0x8(%ebp),%edx
  801004:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801006:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80100a:	74 07                	je     801013 <strtol+0x141>
  80100c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100f:	f7 d8                	neg    %eax
  801011:	eb 03                	jmp    801016 <strtol+0x144>
  801013:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <ltostr>:

void
ltostr(long value, char *str)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80101e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801025:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80102c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801030:	79 13                	jns    801045 <ltostr+0x2d>
	{
		neg = 1;
  801032:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801039:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80103f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801042:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
  801048:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80104d:	99                   	cltd   
  80104e:	f7 f9                	idiv   %ecx
  801050:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801053:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801056:	8d 50 01             	lea    0x1(%eax),%edx
  801059:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80105c:	89 c2                	mov    %eax,%edx
  80105e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801061:	01 d0                	add    %edx,%eax
  801063:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801066:	83 c2 30             	add    $0x30,%edx
  801069:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80106b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801073:	f7 e9                	imul   %ecx
  801075:	c1 fa 02             	sar    $0x2,%edx
  801078:	89 c8                	mov    %ecx,%eax
  80107a:	c1 f8 1f             	sar    $0x1f,%eax
  80107d:	29 c2                	sub    %eax,%edx
  80107f:	89 d0                	mov    %edx,%eax
  801081:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801084:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801088:	75 bb                	jne    801045 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80108a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801091:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801094:	48                   	dec    %eax
  801095:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801098:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80109c:	74 3d                	je     8010db <ltostr+0xc3>
		start = 1 ;
  80109e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a5:	eb 34                	jmp    8010db <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8010a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ba:	01 c2                	add    %eax,%edx
  8010bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	01 c8                	add    %ecx,%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 c2                	add    %eax,%edx
  8010d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e1:	7c c4                	jl     8010a7 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	01 d0                	add    %edx,%eax
  8010eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010ee:	90                   	nop
  8010ef:	c9                   	leave  
  8010f0:	c3                   	ret    

008010f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010f1:	55                   	push   %ebp
  8010f2:	89 e5                	mov    %esp,%ebp
  8010f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f7:	ff 75 08             	pushl  0x8(%ebp)
  8010fa:	e8 c4 f9 ff ff       	call   800ac3 <strlen>
  8010ff:	83 c4 04             	add    $0x4,%esp
  801102:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801105:	ff 75 0c             	pushl  0xc(%ebp)
  801108:	e8 b6 f9 ff ff       	call   800ac3 <strlen>
  80110d:	83 c4 04             	add    $0x4,%esp
  801110:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80111a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801121:	eb 17                	jmp    80113a <strcconcat+0x49>
		final[s] = str1[s] ;
  801123:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801126:	8b 45 10             	mov    0x10(%ebp),%eax
  801129:	01 c2                	add    %eax,%edx
  80112b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	01 c8                	add    %ecx,%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801137:	ff 45 fc             	incl   -0x4(%ebp)
  80113a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801140:	7c e1                	jl     801123 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801142:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801149:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801150:	eb 1f                	jmp    801171 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801152:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801155:	8d 50 01             	lea    0x1(%eax),%edx
  801158:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80115b:	89 c2                	mov    %eax,%edx
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	01 c2                	add    %eax,%edx
  801162:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	01 c8                	add    %ecx,%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80116e:	ff 45 f8             	incl   -0x8(%ebp)
  801171:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801174:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801177:	7c d9                	jl     801152 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801179:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117c:	8b 45 10             	mov    0x10(%ebp),%eax
  80117f:	01 d0                	add    %edx,%eax
  801181:	c6 00 00             	movb   $0x0,(%eax)
}
  801184:	90                   	nop
  801185:	c9                   	leave  
  801186:	c3                   	ret    

00801187 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80118a:	8b 45 14             	mov    0x14(%ebp),%eax
  80118d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801193:	8b 45 14             	mov    0x14(%ebp),%eax
  801196:	8b 00                	mov    (%eax),%eax
  801198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	01 d0                	add    %edx,%eax
  8011a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011aa:	eb 0c                	jmp    8011b8 <strsplit+0x31>
			*string++ = 0;
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8d 50 01             	lea    0x1(%eax),%edx
  8011b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	84 c0                	test   %al,%al
  8011bf:	74 18                	je     8011d9 <strsplit+0x52>
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	0f be c0             	movsbl %al,%eax
  8011c9:	50                   	push   %eax
  8011ca:	ff 75 0c             	pushl  0xc(%ebp)
  8011cd:	e8 83 fa ff ff       	call   800c55 <strchr>
  8011d2:	83 c4 08             	add    $0x8,%esp
  8011d5:	85 c0                	test   %eax,%eax
  8011d7:	75 d3                	jne    8011ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	84 c0                	test   %al,%al
  8011e0:	74 5a                	je     80123c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e5:	8b 00                	mov    (%eax),%eax
  8011e7:	83 f8 0f             	cmp    $0xf,%eax
  8011ea:	75 07                	jne    8011f3 <strsplit+0x6c>
		{
			return 0;
  8011ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f1:	eb 66                	jmp    801259 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f6:	8b 00                	mov    (%eax),%eax
  8011f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8011fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8011fe:	89 0a                	mov    %ecx,(%edx)
  801200:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	01 c2                	add    %eax,%edx
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801211:	eb 03                	jmp    801216 <strsplit+0x8f>
			string++;
  801213:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	84 c0                	test   %al,%al
  80121d:	74 8b                	je     8011aa <strsplit+0x23>
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	0f be c0             	movsbl %al,%eax
  801227:	50                   	push   %eax
  801228:	ff 75 0c             	pushl  0xc(%ebp)
  80122b:	e8 25 fa ff ff       	call   800c55 <strchr>
  801230:	83 c4 08             	add    $0x8,%esp
  801233:	85 c0                	test   %eax,%eax
  801235:	74 dc                	je     801213 <strsplit+0x8c>
			string++;
	}
  801237:	e9 6e ff ff ff       	jmp    8011aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80123c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80123d:	8b 45 14             	mov    0x14(%ebp),%eax
  801240:	8b 00                	mov    (%eax),%eax
  801242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801249:	8b 45 10             	mov    0x10(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801254:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
  80125e:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801267:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80126e:	eb 4a                	jmp    8012ba <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801270:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	01 c2                	add    %eax,%edx
  801278:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80127b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127e:	01 c8                	add    %ecx,%eax
  801280:	8a 00                	mov    (%eax),%al
  801282:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801284:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801287:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128a:	01 d0                	add    %edx,%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	3c 40                	cmp    $0x40,%al
  801290:	7e 25                	jle    8012b7 <str2lower+0x5c>
  801292:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	01 d0                	add    %edx,%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	3c 5a                	cmp    $0x5a,%al
  80129e:	7f 17                	jg     8012b7 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8012ae:	01 ca                	add    %ecx,%edx
  8012b0:	8a 12                	mov    (%edx),%dl
  8012b2:	83 c2 20             	add    $0x20,%edx
  8012b5:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012b7:	ff 45 fc             	incl   -0x4(%ebp)
  8012ba:	ff 75 0c             	pushl  0xc(%ebp)
  8012bd:	e8 01 f8 ff ff       	call   800ac3 <strlen>
  8012c2:	83 c4 04             	add    $0x4,%esp
  8012c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012c8:	7f a6                	jg     801270 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8012ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
  8012d2:	57                   	push   %edi
  8012d3:	56                   	push   %esi
  8012d4:	53                   	push   %ebx
  8012d5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012e4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012e7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012ea:	cd 30                	int    $0x30
  8012ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012f2:	83 c4 10             	add    $0x10,%esp
  8012f5:	5b                   	pop    %ebx
  8012f6:	5e                   	pop    %esi
  8012f7:	5f                   	pop    %edi
  8012f8:	5d                   	pop    %ebp
  8012f9:	c3                   	ret    

008012fa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
  8012fd:	83 ec 04             	sub    $0x4,%esp
  801300:	8b 45 10             	mov    0x10(%ebp),%eax
  801303:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801306:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801309:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80130d:	8b 45 08             	mov    0x8(%ebp),%eax
  801310:	6a 00                	push   $0x0
  801312:	51                   	push   %ecx
  801313:	52                   	push   %edx
  801314:	ff 75 0c             	pushl  0xc(%ebp)
  801317:	50                   	push   %eax
  801318:	6a 00                	push   $0x0
  80131a:	e8 b0 ff ff ff       	call   8012cf <syscall>
  80131f:	83 c4 18             	add    $0x18,%esp
}
  801322:	90                   	nop
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <sys_cgetc>:

int
sys_cgetc(void)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 02                	push   $0x2
  801334:	e8 96 ff ff ff       	call   8012cf <syscall>
  801339:	83 c4 18             	add    $0x18,%esp
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <sys_lock_cons>:

void sys_lock_cons(void)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 03                	push   $0x3
  80134d:	e8 7d ff ff ff       	call   8012cf <syscall>
  801352:	83 c4 18             	add    $0x18,%esp
}
  801355:	90                   	nop
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 04                	push   $0x4
  801367:	e8 63 ff ff ff       	call   8012cf <syscall>
  80136c:	83 c4 18             	add    $0x18,%esp
}
  80136f:	90                   	nop
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801375:	8b 55 0c             	mov    0xc(%ebp),%edx
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	52                   	push   %edx
  801382:	50                   	push   %eax
  801383:	6a 08                	push   $0x8
  801385:	e8 45 ff ff ff       	call   8012cf <syscall>
  80138a:	83 c4 18             	add    $0x18,%esp
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
  801392:	56                   	push   %esi
  801393:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801394:	8b 75 18             	mov    0x18(%ebp),%esi
  801397:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80139a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80139d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	56                   	push   %esi
  8013a4:	53                   	push   %ebx
  8013a5:	51                   	push   %ecx
  8013a6:	52                   	push   %edx
  8013a7:	50                   	push   %eax
  8013a8:	6a 09                	push   $0x9
  8013aa:	e8 20 ff ff ff       	call   8012cf <syscall>
  8013af:	83 c4 18             	add    $0x18,%esp
}
  8013b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013b5:	5b                   	pop    %ebx
  8013b6:	5e                   	pop    %esi
  8013b7:	5d                   	pop    %ebp
  8013b8:	c3                   	ret    

008013b9 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	ff 75 08             	pushl  0x8(%ebp)
  8013c7:	6a 0a                	push   $0xa
  8013c9:	e8 01 ff ff ff       	call   8012cf <syscall>
  8013ce:	83 c4 18             	add    $0x18,%esp
}
  8013d1:	c9                   	leave  
  8013d2:	c3                   	ret    

008013d3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	ff 75 0c             	pushl  0xc(%ebp)
  8013df:	ff 75 08             	pushl  0x8(%ebp)
  8013e2:	6a 0b                	push   $0xb
  8013e4:	e8 e6 fe ff ff       	call   8012cf <syscall>
  8013e9:	83 c4 18             	add    $0x18,%esp
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 0c                	push   $0xc
  8013fd:	e8 cd fe ff ff       	call   8012cf <syscall>
  801402:	83 c4 18             	add    $0x18,%esp
}
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 0d                	push   $0xd
  801416:	e8 b4 fe ff ff       	call   8012cf <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
}
  80141e:	c9                   	leave  
  80141f:	c3                   	ret    

00801420 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 0e                	push   $0xe
  80142f:	e8 9b fe ff ff       	call   8012cf <syscall>
  801434:	83 c4 18             	add    $0x18,%esp
}
  801437:	c9                   	leave  
  801438:	c3                   	ret    

00801439 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 0f                	push   $0xf
  801448:	e8 82 fe ff ff       	call   8012cf <syscall>
  80144d:	83 c4 18             	add    $0x18,%esp
}
  801450:	c9                   	leave  
  801451:	c3                   	ret    

00801452 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801452:	55                   	push   %ebp
  801453:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	ff 75 08             	pushl  0x8(%ebp)
  801460:	6a 10                	push   $0x10
  801462:	e8 68 fe ff ff       	call   8012cf <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 11                	push   $0x11
  80147b:	e8 4f fe ff ff       	call   8012cf <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	90                   	nop
  801484:	c9                   	leave  
  801485:	c3                   	ret    

00801486 <sys_cputc>:

void
sys_cputc(const char c)
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
  801489:	83 ec 04             	sub    $0x4,%esp
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801492:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	50                   	push   %eax
  80149f:	6a 01                	push   $0x1
  8014a1:	e8 29 fe ff ff       	call   8012cf <syscall>
  8014a6:	83 c4 18             	add    $0x18,%esp
}
  8014a9:	90                   	nop
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 14                	push   $0x14
  8014bb:	e8 0f fe ff ff       	call   8012cf <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
}
  8014c3:	90                   	nop
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
  8014c9:	83 ec 04             	sub    $0x4,%esp
  8014cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8014d2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014d5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dc:	6a 00                	push   $0x0
  8014de:	51                   	push   %ecx
  8014df:	52                   	push   %edx
  8014e0:	ff 75 0c             	pushl  0xc(%ebp)
  8014e3:	50                   	push   %eax
  8014e4:	6a 15                	push   $0x15
  8014e6:	e8 e4 fd ff ff       	call   8012cf <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8014f3:	8b 55 10             	mov    0x10(%ebp),%edx
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	52                   	push   %edx
  8014fe:	50                   	push   %eax
  8014ff:	ff 75 08             	pushl  0x8(%ebp)
  801502:	6a 16                	push   $0x16
  801504:	e8 c6 fd ff ff       	call   8012cf <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801511:	8b 55 0c             	mov    0xc(%ebp),%edx
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	52                   	push   %edx
  80151e:	50                   	push   %eax
  80151f:	6a 17                	push   $0x17
  801521:	e8 a9 fd ff ff       	call   8012cf <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80152e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	52                   	push   %edx
  80153b:	50                   	push   %eax
  80153c:	6a 18                	push   $0x18
  80153e:	e8 8c fd ff ff       	call   8012cf <syscall>
  801543:	83 c4 18             	add    $0x18,%esp
}
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	6a 00                	push   $0x0
  801550:	ff 75 14             	pushl  0x14(%ebp)
  801553:	ff 75 10             	pushl  0x10(%ebp)
  801556:	ff 75 0c             	pushl  0xc(%ebp)
  801559:	50                   	push   %eax
  80155a:	6a 19                	push   $0x19
  80155c:	e8 6e fd ff ff       	call   8012cf <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801569:	8b 45 08             	mov    0x8(%ebp),%eax
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	50                   	push   %eax
  801575:	6a 1a                	push   $0x1a
  801577:	e8 53 fd ff ff       	call   8012cf <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	90                   	nop
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	50                   	push   %eax
  801591:	6a 1b                	push   $0x1b
  801593:	e8 37 fd ff ff       	call   8012cf <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 05                	push   $0x5
  8015ac:	e8 1e fd ff ff       	call   8012cf <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 06                	push   $0x6
  8015c5:	e8 05 fd ff ff       	call   8012cf <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 07                	push   $0x7
  8015de:	e8 ec fc ff ff       	call   8012cf <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_exit_env>:


void sys_exit_env(void)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 1c                	push   $0x1c
  8015f7:	e8 d3 fc ff ff       	call   8012cf <syscall>
  8015fc:	83 c4 18             	add    $0x18,%esp
}
  8015ff:	90                   	nop
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	ff 75 10             	pushl  0x10(%ebp)
  80160c:	ff 75 0c             	pushl  0xc(%ebp)
  80160f:	ff 75 08             	pushl  0x8(%ebp)
  801612:	6a 13                	push   $0x13
  801614:	e8 b6 fc ff ff       	call   8012cf <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
	return ;
  80161c:	90                   	nop
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_rcr2>:
uint32 sys_rcr2()
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 1e                	push   $0x1e
  80162e:	e8 9c fc ff ff       	call   8012cf <syscall>
  801633:	83 c4 18             	add    $0x18,%esp
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 04             	sub    $0x4,%esp
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801644:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	50                   	push   %eax
  801651:	6a 1f                	push   $0x1f
  801653:	e8 77 fc ff ff       	call   8012cf <syscall>
  801658:	83 c4 18             	add    $0x18,%esp
	return ;
  80165b:	90                   	nop
}
  80165c:	c9                   	leave  
  80165d:	c3                   	ret    

0080165e <rsttst>:
void rsttst()
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 21                	push   $0x21
  80166d:	e8 5d fc ff ff       	call   8012cf <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
	return ;
  801675:	90                   	nop
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 04             	sub    $0x4,%esp
  80167e:	8b 45 14             	mov    0x14(%ebp),%eax
  801681:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801684:	8b 55 18             	mov    0x18(%ebp),%edx
  801687:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80168b:	52                   	push   %edx
  80168c:	50                   	push   %eax
  80168d:	ff 75 10             	pushl  0x10(%ebp)
  801690:	ff 75 0c             	pushl  0xc(%ebp)
  801693:	ff 75 08             	pushl  0x8(%ebp)
  801696:	6a 20                	push   $0x20
  801698:	e8 32 fc ff ff       	call   8012cf <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a0:	90                   	nop
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <chktst>:
void chktst(uint32 n)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	ff 75 08             	pushl  0x8(%ebp)
  8016b1:	6a 22                	push   $0x22
  8016b3:	e8 17 fc ff ff       	call   8012cf <syscall>
  8016b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016bb:	90                   	nop
}
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <inctst>:

void inctst()
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 23                	push   $0x23
  8016cd:	e8 fd fb ff ff       	call   8012cf <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d5:	90                   	nop
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <gettst>:
uint32 gettst()
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 24                	push   $0x24
  8016e7:	e8 e3 fb ff ff       	call   8012cf <syscall>
  8016ec:	83 c4 18             	add    $0x18,%esp
}
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 25                	push   $0x25
  801700:	e8 ca fb ff ff       	call   8012cf <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
  801708:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  80170d:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	ff 75 08             	pushl  0x8(%ebp)
  80172a:	6a 26                	push   $0x26
  80172c:	e8 9e fb ff ff       	call   8012cf <syscall>
  801731:	83 c4 18             	add    $0x18,%esp
	return ;
  801734:	90                   	nop
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
  80173a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80173b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80173e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801741:	8b 55 0c             	mov    0xc(%ebp),%edx
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	6a 00                	push   $0x0
  801749:	53                   	push   %ebx
  80174a:	51                   	push   %ecx
  80174b:	52                   	push   %edx
  80174c:	50                   	push   %eax
  80174d:	6a 27                	push   $0x27
  80174f:	e8 7b fb ff ff       	call   8012cf <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80175f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	52                   	push   %edx
  80176c:	50                   	push   %eax
  80176d:	6a 28                	push   $0x28
  80176f:	e8 5b fb ff ff       	call   8012cf <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80177c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80177f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	6a 00                	push   $0x0
  801787:	51                   	push   %ecx
  801788:	ff 75 10             	pushl  0x10(%ebp)
  80178b:	52                   	push   %edx
  80178c:	50                   	push   %eax
  80178d:	6a 29                	push   $0x29
  80178f:	e8 3b fb ff ff       	call   8012cf <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	ff 75 10             	pushl  0x10(%ebp)
  8017a3:	ff 75 0c             	pushl  0xc(%ebp)
  8017a6:	ff 75 08             	pushl  0x8(%ebp)
  8017a9:	6a 12                	push   $0x12
  8017ab:	e8 1f fb ff ff       	call   8012cf <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b3:	90                   	nop
}
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	52                   	push   %edx
  8017c6:	50                   	push   %eax
  8017c7:	6a 2a                	push   $0x2a
  8017c9:	e8 01 fb ff ff       	call   8012cf <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
	return;
  8017d1:	90                   	nop
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 2b                	push   $0x2b
  8017e3:	e8 e7 fa ff ff       	call   8012cf <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
}
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
  8017f0:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8017f3:	83 ec 04             	sub    $0x4,%esp
  8017f6:	68 a8 22 80 00       	push   $0x8022a8
  8017fb:	68 0a 01 00 00       	push   $0x10a
  801800:	68 b8 22 80 00       	push   $0x8022b8
  801805:	e8 38 00 00 00       	call   801842 <_panic>

0080180a <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	ff 75 0c             	pushl  0xc(%ebp)
  801816:	ff 75 08             	pushl  0x8(%ebp)
  801819:	6a 33                	push   $0x33
  80181b:	e8 af fa ff ff       	call   8012cf <syscall>
  801820:	83 c4 18             	add    $0x18,%esp
	return;
  801823:	90                   	nop
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	ff 75 0c             	pushl  0xc(%ebp)
  801832:	ff 75 08             	pushl  0x8(%ebp)
  801835:	6a 34                	push   $0x34
  801837:	e8 93 fa ff ff       	call   8012cf <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
	return ;
  80183f:	90                   	nop
}
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
  801845:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801848:	8d 45 10             	lea    0x10(%ebp),%eax
  80184b:	83 c0 04             	add    $0x4,%eax
  80184e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801851:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801856:	85 c0                	test   %eax,%eax
  801858:	74 16                	je     801870 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80185a:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80185f:	83 ec 08             	sub    $0x8,%esp
  801862:	50                   	push   %eax
  801863:	68 c8 22 80 00       	push   $0x8022c8
  801868:	e8 7d eb ff ff       	call   8003ea <cprintf>
  80186d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801870:	a1 04 30 80 00       	mov    0x803004,%eax
  801875:	83 ec 0c             	sub    $0xc,%esp
  801878:	ff 75 0c             	pushl  0xc(%ebp)
  80187b:	ff 75 08             	pushl  0x8(%ebp)
  80187e:	50                   	push   %eax
  80187f:	68 d0 22 80 00       	push   $0x8022d0
  801884:	6a 74                	push   $0x74
  801886:	e8 8c eb ff ff       	call   800417 <cprintf_colored>
  80188b:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80188e:	8b 45 10             	mov    0x10(%ebp),%eax
  801891:	83 ec 08             	sub    $0x8,%esp
  801894:	ff 75 f4             	pushl  -0xc(%ebp)
  801897:	50                   	push   %eax
  801898:	e8 de ea ff ff       	call   80037b <vcprintf>
  80189d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018a0:	83 ec 08             	sub    $0x8,%esp
  8018a3:	6a 00                	push   $0x0
  8018a5:	68 f8 22 80 00       	push   $0x8022f8
  8018aa:	e8 cc ea ff ff       	call   80037b <vcprintf>
  8018af:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018b2:	e8 45 ea ff ff       	call   8002fc <exit>

	// should not return here
	while (1) ;
  8018b7:	eb fe                	jmp    8018b7 <_panic+0x75>

008018b9 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
  8018bc:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8018c4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8018ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cd:	39 c2                	cmp    %eax,%edx
  8018cf:	74 14                	je     8018e5 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018d1:	83 ec 04             	sub    $0x4,%esp
  8018d4:	68 fc 22 80 00       	push   $0x8022fc
  8018d9:	6a 26                	push   $0x26
  8018db:	68 48 23 80 00       	push   $0x802348
  8018e0:	e8 5d ff ff ff       	call   801842 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018f3:	e9 c5 00 00 00       	jmp    8019bd <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8018f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801902:	8b 45 08             	mov    0x8(%ebp),%eax
  801905:	01 d0                	add    %edx,%eax
  801907:	8b 00                	mov    (%eax),%eax
  801909:	85 c0                	test   %eax,%eax
  80190b:	75 08                	jne    801915 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80190d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801910:	e9 a5 00 00 00       	jmp    8019ba <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801915:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80191c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801923:	eb 69                	jmp    80198e <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801925:	a1 20 30 80 00       	mov    0x803020,%eax
  80192a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801930:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801933:	89 d0                	mov    %edx,%eax
  801935:	01 c0                	add    %eax,%eax
  801937:	01 d0                	add    %edx,%eax
  801939:	c1 e0 03             	shl    $0x3,%eax
  80193c:	01 c8                	add    %ecx,%eax
  80193e:	8a 40 04             	mov    0x4(%eax),%al
  801941:	84 c0                	test   %al,%al
  801943:	75 46                	jne    80198b <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801945:	a1 20 30 80 00       	mov    0x803020,%eax
  80194a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801950:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801953:	89 d0                	mov    %edx,%eax
  801955:	01 c0                	add    %eax,%eax
  801957:	01 d0                	add    %edx,%eax
  801959:	c1 e0 03             	shl    $0x3,%eax
  80195c:	01 c8                	add    %ecx,%eax
  80195e:	8b 00                	mov    (%eax),%eax
  801960:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801963:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801966:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80196b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80196d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801970:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	01 c8                	add    %ecx,%eax
  80197c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80197e:	39 c2                	cmp    %eax,%edx
  801980:	75 09                	jne    80198b <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801982:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801989:	eb 15                	jmp    8019a0 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80198b:	ff 45 e8             	incl   -0x18(%ebp)
  80198e:	a1 20 30 80 00       	mov    0x803020,%eax
  801993:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801999:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80199c:	39 c2                	cmp    %eax,%edx
  80199e:	77 85                	ja     801925 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019a4:	75 14                	jne    8019ba <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8019a6:	83 ec 04             	sub    $0x4,%esp
  8019a9:	68 54 23 80 00       	push   $0x802354
  8019ae:	6a 3a                	push   $0x3a
  8019b0:	68 48 23 80 00       	push   $0x802348
  8019b5:	e8 88 fe ff ff       	call   801842 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019ba:	ff 45 f0             	incl   -0x10(%ebp)
  8019bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019c0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019c3:	0f 8c 2f ff ff ff    	jl     8018f8 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019d7:	eb 26                	jmp    8019ff <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8019de:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8019e4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019e7:	89 d0                	mov    %edx,%eax
  8019e9:	01 c0                	add    %eax,%eax
  8019eb:	01 d0                	add    %edx,%eax
  8019ed:	c1 e0 03             	shl    $0x3,%eax
  8019f0:	01 c8                	add    %ecx,%eax
  8019f2:	8a 40 04             	mov    0x4(%eax),%al
  8019f5:	3c 01                	cmp    $0x1,%al
  8019f7:	75 03                	jne    8019fc <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019f9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019fc:	ff 45 e0             	incl   -0x20(%ebp)
  8019ff:	a1 20 30 80 00       	mov    0x803020,%eax
  801a04:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a0d:	39 c2                	cmp    %eax,%edx
  801a0f:	77 c8                	ja     8019d9 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a14:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a17:	74 14                	je     801a2d <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a19:	83 ec 04             	sub    $0x4,%esp
  801a1c:	68 a8 23 80 00       	push   $0x8023a8
  801a21:	6a 44                	push   $0x44
  801a23:	68 48 23 80 00       	push   $0x802348
  801a28:	e8 15 fe ff ff       	call   801842 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a2d:	90                   	nop
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <__udivdi3>:
  801a30:	55                   	push   %ebp
  801a31:	57                   	push   %edi
  801a32:	56                   	push   %esi
  801a33:	53                   	push   %ebx
  801a34:	83 ec 1c             	sub    $0x1c,%esp
  801a37:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a43:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a47:	89 ca                	mov    %ecx,%edx
  801a49:	89 f8                	mov    %edi,%eax
  801a4b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a4f:	85 f6                	test   %esi,%esi
  801a51:	75 2d                	jne    801a80 <__udivdi3+0x50>
  801a53:	39 cf                	cmp    %ecx,%edi
  801a55:	77 65                	ja     801abc <__udivdi3+0x8c>
  801a57:	89 fd                	mov    %edi,%ebp
  801a59:	85 ff                	test   %edi,%edi
  801a5b:	75 0b                	jne    801a68 <__udivdi3+0x38>
  801a5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a62:	31 d2                	xor    %edx,%edx
  801a64:	f7 f7                	div    %edi
  801a66:	89 c5                	mov    %eax,%ebp
  801a68:	31 d2                	xor    %edx,%edx
  801a6a:	89 c8                	mov    %ecx,%eax
  801a6c:	f7 f5                	div    %ebp
  801a6e:	89 c1                	mov    %eax,%ecx
  801a70:	89 d8                	mov    %ebx,%eax
  801a72:	f7 f5                	div    %ebp
  801a74:	89 cf                	mov    %ecx,%edi
  801a76:	89 fa                	mov    %edi,%edx
  801a78:	83 c4 1c             	add    $0x1c,%esp
  801a7b:	5b                   	pop    %ebx
  801a7c:	5e                   	pop    %esi
  801a7d:	5f                   	pop    %edi
  801a7e:	5d                   	pop    %ebp
  801a7f:	c3                   	ret    
  801a80:	39 ce                	cmp    %ecx,%esi
  801a82:	77 28                	ja     801aac <__udivdi3+0x7c>
  801a84:	0f bd fe             	bsr    %esi,%edi
  801a87:	83 f7 1f             	xor    $0x1f,%edi
  801a8a:	75 40                	jne    801acc <__udivdi3+0x9c>
  801a8c:	39 ce                	cmp    %ecx,%esi
  801a8e:	72 0a                	jb     801a9a <__udivdi3+0x6a>
  801a90:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a94:	0f 87 9e 00 00 00    	ja     801b38 <__udivdi3+0x108>
  801a9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9f:	89 fa                	mov    %edi,%edx
  801aa1:	83 c4 1c             	add    $0x1c,%esp
  801aa4:	5b                   	pop    %ebx
  801aa5:	5e                   	pop    %esi
  801aa6:	5f                   	pop    %edi
  801aa7:	5d                   	pop    %ebp
  801aa8:	c3                   	ret    
  801aa9:	8d 76 00             	lea    0x0(%esi),%esi
  801aac:	31 ff                	xor    %edi,%edi
  801aae:	31 c0                	xor    %eax,%eax
  801ab0:	89 fa                	mov    %edi,%edx
  801ab2:	83 c4 1c             	add    $0x1c,%esp
  801ab5:	5b                   	pop    %ebx
  801ab6:	5e                   	pop    %esi
  801ab7:	5f                   	pop    %edi
  801ab8:	5d                   	pop    %ebp
  801ab9:	c3                   	ret    
  801aba:	66 90                	xchg   %ax,%ax
  801abc:	89 d8                	mov    %ebx,%eax
  801abe:	f7 f7                	div    %edi
  801ac0:	31 ff                	xor    %edi,%edi
  801ac2:	89 fa                	mov    %edi,%edx
  801ac4:	83 c4 1c             	add    $0x1c,%esp
  801ac7:	5b                   	pop    %ebx
  801ac8:	5e                   	pop    %esi
  801ac9:	5f                   	pop    %edi
  801aca:	5d                   	pop    %ebp
  801acb:	c3                   	ret    
  801acc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad1:	89 eb                	mov    %ebp,%ebx
  801ad3:	29 fb                	sub    %edi,%ebx
  801ad5:	89 f9                	mov    %edi,%ecx
  801ad7:	d3 e6                	shl    %cl,%esi
  801ad9:	89 c5                	mov    %eax,%ebp
  801adb:	88 d9                	mov    %bl,%cl
  801add:	d3 ed                	shr    %cl,%ebp
  801adf:	89 e9                	mov    %ebp,%ecx
  801ae1:	09 f1                	or     %esi,%ecx
  801ae3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ae7:	89 f9                	mov    %edi,%ecx
  801ae9:	d3 e0                	shl    %cl,%eax
  801aeb:	89 c5                	mov    %eax,%ebp
  801aed:	89 d6                	mov    %edx,%esi
  801aef:	88 d9                	mov    %bl,%cl
  801af1:	d3 ee                	shr    %cl,%esi
  801af3:	89 f9                	mov    %edi,%ecx
  801af5:	d3 e2                	shl    %cl,%edx
  801af7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801afb:	88 d9                	mov    %bl,%cl
  801afd:	d3 e8                	shr    %cl,%eax
  801aff:	09 c2                	or     %eax,%edx
  801b01:	89 d0                	mov    %edx,%eax
  801b03:	89 f2                	mov    %esi,%edx
  801b05:	f7 74 24 0c          	divl   0xc(%esp)
  801b09:	89 d6                	mov    %edx,%esi
  801b0b:	89 c3                	mov    %eax,%ebx
  801b0d:	f7 e5                	mul    %ebp
  801b0f:	39 d6                	cmp    %edx,%esi
  801b11:	72 19                	jb     801b2c <__udivdi3+0xfc>
  801b13:	74 0b                	je     801b20 <__udivdi3+0xf0>
  801b15:	89 d8                	mov    %ebx,%eax
  801b17:	31 ff                	xor    %edi,%edi
  801b19:	e9 58 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b1e:	66 90                	xchg   %ax,%ax
  801b20:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b24:	89 f9                	mov    %edi,%ecx
  801b26:	d3 e2                	shl    %cl,%edx
  801b28:	39 c2                	cmp    %eax,%edx
  801b2a:	73 e9                	jae    801b15 <__udivdi3+0xe5>
  801b2c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b2f:	31 ff                	xor    %edi,%edi
  801b31:	e9 40 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b36:	66 90                	xchg   %ax,%ax
  801b38:	31 c0                	xor    %eax,%eax
  801b3a:	e9 37 ff ff ff       	jmp    801a76 <__udivdi3+0x46>
  801b3f:	90                   	nop

00801b40 <__umoddi3>:
  801b40:	55                   	push   %ebp
  801b41:	57                   	push   %edi
  801b42:	56                   	push   %esi
  801b43:	53                   	push   %ebx
  801b44:	83 ec 1c             	sub    $0x1c,%esp
  801b47:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b53:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b57:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b5f:	89 f3                	mov    %esi,%ebx
  801b61:	89 fa                	mov    %edi,%edx
  801b63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b67:	89 34 24             	mov    %esi,(%esp)
  801b6a:	85 c0                	test   %eax,%eax
  801b6c:	75 1a                	jne    801b88 <__umoddi3+0x48>
  801b6e:	39 f7                	cmp    %esi,%edi
  801b70:	0f 86 a2 00 00 00    	jbe    801c18 <__umoddi3+0xd8>
  801b76:	89 c8                	mov    %ecx,%eax
  801b78:	89 f2                	mov    %esi,%edx
  801b7a:	f7 f7                	div    %edi
  801b7c:	89 d0                	mov    %edx,%eax
  801b7e:	31 d2                	xor    %edx,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	39 f0                	cmp    %esi,%eax
  801b8a:	0f 87 ac 00 00 00    	ja     801c3c <__umoddi3+0xfc>
  801b90:	0f bd e8             	bsr    %eax,%ebp
  801b93:	83 f5 1f             	xor    $0x1f,%ebp
  801b96:	0f 84 ac 00 00 00    	je     801c48 <__umoddi3+0x108>
  801b9c:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba1:	29 ef                	sub    %ebp,%edi
  801ba3:	89 fe                	mov    %edi,%esi
  801ba5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ba9:	89 e9                	mov    %ebp,%ecx
  801bab:	d3 e0                	shl    %cl,%eax
  801bad:	89 d7                	mov    %edx,%edi
  801baf:	89 f1                	mov    %esi,%ecx
  801bb1:	d3 ef                	shr    %cl,%edi
  801bb3:	09 c7                	or     %eax,%edi
  801bb5:	89 e9                	mov    %ebp,%ecx
  801bb7:	d3 e2                	shl    %cl,%edx
  801bb9:	89 14 24             	mov    %edx,(%esp)
  801bbc:	89 d8                	mov    %ebx,%eax
  801bbe:	d3 e0                	shl    %cl,%eax
  801bc0:	89 c2                	mov    %eax,%edx
  801bc2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc6:	d3 e0                	shl    %cl,%eax
  801bc8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bcc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd0:	89 f1                	mov    %esi,%ecx
  801bd2:	d3 e8                	shr    %cl,%eax
  801bd4:	09 d0                	or     %edx,%eax
  801bd6:	d3 eb                	shr    %cl,%ebx
  801bd8:	89 da                	mov    %ebx,%edx
  801bda:	f7 f7                	div    %edi
  801bdc:	89 d3                	mov    %edx,%ebx
  801bde:	f7 24 24             	mull   (%esp)
  801be1:	89 c6                	mov    %eax,%esi
  801be3:	89 d1                	mov    %edx,%ecx
  801be5:	39 d3                	cmp    %edx,%ebx
  801be7:	0f 82 87 00 00 00    	jb     801c74 <__umoddi3+0x134>
  801bed:	0f 84 91 00 00 00    	je     801c84 <__umoddi3+0x144>
  801bf3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bf7:	29 f2                	sub    %esi,%edx
  801bf9:	19 cb                	sbb    %ecx,%ebx
  801bfb:	89 d8                	mov    %ebx,%eax
  801bfd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c01:	d3 e0                	shl    %cl,%eax
  801c03:	89 e9                	mov    %ebp,%ecx
  801c05:	d3 ea                	shr    %cl,%edx
  801c07:	09 d0                	or     %edx,%eax
  801c09:	89 e9                	mov    %ebp,%ecx
  801c0b:	d3 eb                	shr    %cl,%ebx
  801c0d:	89 da                	mov    %ebx,%edx
  801c0f:	83 c4 1c             	add    $0x1c,%esp
  801c12:	5b                   	pop    %ebx
  801c13:	5e                   	pop    %esi
  801c14:	5f                   	pop    %edi
  801c15:	5d                   	pop    %ebp
  801c16:	c3                   	ret    
  801c17:	90                   	nop
  801c18:	89 fd                	mov    %edi,%ebp
  801c1a:	85 ff                	test   %edi,%edi
  801c1c:	75 0b                	jne    801c29 <__umoddi3+0xe9>
  801c1e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c23:	31 d2                	xor    %edx,%edx
  801c25:	f7 f7                	div    %edi
  801c27:	89 c5                	mov    %eax,%ebp
  801c29:	89 f0                	mov    %esi,%eax
  801c2b:	31 d2                	xor    %edx,%edx
  801c2d:	f7 f5                	div    %ebp
  801c2f:	89 c8                	mov    %ecx,%eax
  801c31:	f7 f5                	div    %ebp
  801c33:	89 d0                	mov    %edx,%eax
  801c35:	e9 44 ff ff ff       	jmp    801b7e <__umoddi3+0x3e>
  801c3a:	66 90                	xchg   %ax,%ax
  801c3c:	89 c8                	mov    %ecx,%eax
  801c3e:	89 f2                	mov    %esi,%edx
  801c40:	83 c4 1c             	add    $0x1c,%esp
  801c43:	5b                   	pop    %ebx
  801c44:	5e                   	pop    %esi
  801c45:	5f                   	pop    %edi
  801c46:	5d                   	pop    %ebp
  801c47:	c3                   	ret    
  801c48:	3b 04 24             	cmp    (%esp),%eax
  801c4b:	72 06                	jb     801c53 <__umoddi3+0x113>
  801c4d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c51:	77 0f                	ja     801c62 <__umoddi3+0x122>
  801c53:	89 f2                	mov    %esi,%edx
  801c55:	29 f9                	sub    %edi,%ecx
  801c57:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5b:	89 14 24             	mov    %edx,(%esp)
  801c5e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c62:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c66:	8b 14 24             	mov    (%esp),%edx
  801c69:	83 c4 1c             	add    $0x1c,%esp
  801c6c:	5b                   	pop    %ebx
  801c6d:	5e                   	pop    %esi
  801c6e:	5f                   	pop    %edi
  801c6f:	5d                   	pop    %ebp
  801c70:	c3                   	ret    
  801c71:	8d 76 00             	lea    0x0(%esi),%esi
  801c74:	2b 04 24             	sub    (%esp),%eax
  801c77:	19 fa                	sbb    %edi,%edx
  801c79:	89 d1                	mov    %edx,%ecx
  801c7b:	89 c6                	mov    %eax,%esi
  801c7d:	e9 71 ff ff ff       	jmp    801bf3 <__umoddi3+0xb3>
  801c82:	66 90                	xchg   %ax,%ax
  801c84:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c88:	72 ea                	jb     801c74 <__umoddi3+0x134>
  801c8a:	89 d9                	mov    %ebx,%ecx
  801c8c:	e9 62 ff ff ff       	jmp    801bf3 <__umoddi3+0xb3>
