
obj/user/sc_fib_recursive:     file format elf32-i386


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
  800031:	e8 93 00 00 00       	call   8000c9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int64 fibonacci(int n);

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
//	i1 = strtol(buff1, NULL, 10);

	index = 30;
  800048:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)

	int64 res = fibonacci(index) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 27 00 00 00       	call   800081 <fibonacci>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800060:	89 55 ec             	mov    %edx,-0x14(%ebp)

	atomic_cprintf("Fibonacci #%d = %lld\n",index, res);
  800063:	ff 75 ec             	pushl  -0x14(%ebp)
  800066:	ff 75 e8             	pushl  -0x18(%ebp)
  800069:	ff 75 f4             	pushl  -0xc(%ebp)
  80006c:	68 c0 1c 80 00       	push   $0x801cc0
  800071:	e8 05 04 00 00       	call   80047b <atomic_cprintf>
  800076:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
	inctst();
  800079:	e8 5f 16 00 00       	call   8016dd <inctst>
	return;
  80007e:	90                   	nop
}
  80007f:	c9                   	leave  
  800080:	c3                   	ret    

00800081 <fibonacci>:


int64 fibonacci(int n)
{
  800081:	55                   	push   %ebp
  800082:	89 e5                	mov    %esp,%ebp
  800084:	56                   	push   %esi
  800085:	53                   	push   %ebx
	if (n <= 1)
  800086:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  80008a:	7f 0c                	jg     800098 <fibonacci+0x17>
		return 1 ;
  80008c:	b8 01 00 00 00       	mov    $0x1,%eax
  800091:	ba 00 00 00 00       	mov    $0x0,%edx
  800096:	eb 2a                	jmp    8000c2 <fibonacci+0x41>
	return fibonacci(n-1) + fibonacci(n-2) ;
  800098:	8b 45 08             	mov    0x8(%ebp),%eax
  80009b:	48                   	dec    %eax
  80009c:	83 ec 0c             	sub    $0xc,%esp
  80009f:	50                   	push   %eax
  8000a0:	e8 dc ff ff ff       	call   800081 <fibonacci>
  8000a5:	83 c4 10             	add    $0x10,%esp
  8000a8:	89 c3                	mov    %eax,%ebx
  8000aa:	89 d6                	mov    %edx,%esi
  8000ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8000af:	83 e8 02             	sub    $0x2,%eax
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	50                   	push   %eax
  8000b6:	e8 c6 ff ff ff       	call   800081 <fibonacci>
  8000bb:	83 c4 10             	add    $0x10,%esp
  8000be:	01 d8                	add    %ebx,%eax
  8000c0:	11 f2                	adc    %esi,%edx
}
  8000c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8000c5:	5b                   	pop    %ebx
  8000c6:	5e                   	pop    %esi
  8000c7:	5d                   	pop    %ebp
  8000c8:	c3                   	ret    

008000c9 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000c9:	55                   	push   %ebp
  8000ca:	89 e5                	mov    %esp,%ebp
  8000cc:	57                   	push   %edi
  8000cd:	56                   	push   %esi
  8000ce:	53                   	push   %ebx
  8000cf:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000d5:	e8 fb 14 00 00       	call   8015d5 <sys_getenvindex>
  8000da:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000e0:	89 d0                	mov    %edx,%eax
  8000e2:	c1 e0 03             	shl    $0x3,%eax
  8000e5:	01 d0                	add    %edx,%eax
  8000e7:	c1 e0 06             	shl    $0x6,%eax
  8000ea:	01 d0                	add    %edx,%eax
  8000ec:	c1 e0 03             	shl    $0x3,%eax
  8000ef:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fe:	8a 40 10             	mov    0x10(%eax),%al
  800101:	84 c0                	test   %al,%al
  800103:	74 0d                	je     800112 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800105:	a1 20 30 80 00       	mov    0x803020,%eax
  80010a:	83 c0 10             	add    $0x10,%eax
  80010d:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800112:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800116:	7e 0a                	jle    800122 <libmain+0x59>
		binaryname = argv[0];
  800118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011b:	8b 00                	mov    (%eax),%eax
  80011d:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800122:	83 ec 08             	sub    $0x8,%esp
  800125:	ff 75 0c             	pushl  0xc(%ebp)
  800128:	ff 75 08             	pushl  0x8(%ebp)
  80012b:	e8 08 ff ff ff       	call   800038 <_main>
  800130:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800133:	a1 00 30 80 00       	mov    0x803000,%eax
  800138:	85 c0                	test   %eax,%eax
  80013a:	0f 84 b7 01 00 00    	je     8002f7 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800140:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800146:	bb 14 1e 80 00       	mov    $0x801e14,%ebx
  80014b:	ba 0e 00 00 00       	mov    $0xe,%edx
  800150:	89 c7                	mov    %eax,%edi
  800152:	89 de                	mov    %ebx,%esi
  800154:	89 d1                	mov    %edx,%ecx
  800156:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800158:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80015e:	b9 56 00 00 00       	mov    $0x56,%ecx
  800163:	b0 00                	mov    $0x0,%al
  800165:	89 d7                	mov    %edx,%edi
  800167:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800169:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800170:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	50                   	push   %eax
  800177:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80017d:	50                   	push   %eax
  80017e:	e8 52 16 00 00       	call   8017d5 <sys_utilities>
  800183:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800186:	e8 d2 11 00 00       	call   80135d <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80018b:	83 ec 0c             	sub    $0xc,%esp
  80018e:	68 f0 1c 80 00       	push   $0x801cf0
  800193:	e8 71 02 00 00       	call   800409 <cprintf>
  800198:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80019b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80019e:	85 c0                	test   %eax,%eax
  8001a0:	74 58                	je     8001fa <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001a2:	e8 4c 16 00 00       	call   8017f3 <sys_get_optimal_num_faults>
  8001a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001aa:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001b0:	bb 78 1e 80 00       	mov    $0x801e78,%ebx
  8001b5:	ba 11 00 00 00       	mov    $0x11,%edx
  8001ba:	89 c7                	mov    %eax,%edi
  8001bc:	89 de                	mov    %ebx,%esi
  8001be:	89 d1                	mov    %edx,%ecx
  8001c0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001c2:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001c5:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001ca:	b0 00                	mov    $0x0,%al
  8001cc:	89 d7                	mov    %edx,%edi
  8001ce:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001d0:	83 ec 08             	sub    $0x8,%esp
  8001d3:	ff 75 dc             	pushl  -0x24(%ebp)
  8001d6:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001dc:	50                   	push   %eax
  8001dd:	e8 f3 15 00 00       	call   8017d5 <sys_utilities>
  8001e2:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001e5:	83 ec 08             	sub    $0x8,%esp
  8001e8:	ff 75 dc             	pushl  -0x24(%ebp)
  8001eb:	68 18 1d 80 00       	push   $0x801d18
  8001f0:	e8 14 02 00 00       	call   800409 <cprintf>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	eb 59                	jmp    800253 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ff:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800205:	a1 20 30 80 00       	mov    0x803020,%eax
  80020a:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800210:	83 ec 04             	sub    $0x4,%esp
  800213:	52                   	push   %edx
  800214:	50                   	push   %eax
  800215:	68 3c 1d 80 00       	push   $0x801d3c
  80021a:	e8 ea 01 00 00       	call   800409 <cprintf>
  80021f:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80022d:	a1 20 30 80 00       	mov    0x803020,%eax
  800232:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800238:	a1 20 30 80 00       	mov    0x803020,%eax
  80023d:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800243:	51                   	push   %ecx
  800244:	52                   	push   %edx
  800245:	50                   	push   %eax
  800246:	68 64 1d 80 00       	push   $0x801d64
  80024b:	e8 b9 01 00 00       	call   800409 <cprintf>
  800250:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800253:	a1 20 30 80 00       	mov    0x803020,%eax
  800258:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80025e:	83 ec 08             	sub    $0x8,%esp
  800261:	50                   	push   %eax
  800262:	68 bc 1d 80 00       	push   $0x801dbc
  800267:	e8 9d 01 00 00       	call   800409 <cprintf>
  80026c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80026f:	83 ec 0c             	sub    $0xc,%esp
  800272:	68 d0 1d 80 00       	push   $0x801dd0
  800277:	e8 8d 01 00 00       	call   800409 <cprintf>
  80027c:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80027f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800286:	eb 28                	jmp    8002b0 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800288:	a1 20 30 80 00       	mov    0x803020,%eax
  80028d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800290:	81 c2 74 04 00 00    	add    $0x474,%edx
  800296:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	50                   	push   %eax
  80029d:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a0:	68 e7 1d 80 00       	push   $0x801de7
  8002a5:	e8 5f 01 00 00       	call   800409 <cprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002ad:	ff 45 e4             	incl   -0x1c(%ebp)
  8002b0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002b4:	7e d2                	jle    800288 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002b6:	83 ec 0c             	sub    $0xc,%esp
  8002b9:	68 f6 1d 80 00       	push   $0x801df6
  8002be:	e8 46 01 00 00       	call   800409 <cprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cb:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002d1:	83 ec 08             	sub    $0x8,%esp
  8002d4:	50                   	push   %eax
  8002d5:	68 fa 1d 80 00       	push   $0x801dfa
  8002da:	e8 2a 01 00 00       	call   800409 <cprintf>
  8002df:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002e2:	83 ec 0c             	sub    $0xc,%esp
  8002e5:	68 f0 1c 80 00       	push   $0x801cf0
  8002ea:	e8 1a 01 00 00       	call   800409 <cprintf>
  8002ef:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002f2:	e8 80 10 00 00       	call   801377 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002f7:	e8 1f 00 00 00       	call   80031b <exit>
}
  8002fc:	90                   	nop
  8002fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800300:	5b                   	pop    %ebx
  800301:	5e                   	pop    %esi
  800302:	5f                   	pop    %edi
  800303:	5d                   	pop    %ebp
  800304:	c3                   	ret    

00800305 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800305:	55                   	push   %ebp
  800306:	89 e5                	mov    %esp,%ebp
  800308:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80030b:	83 ec 0c             	sub    $0xc,%esp
  80030e:	6a 00                	push   $0x0
  800310:	e8 8c 12 00 00       	call   8015a1 <sys_destroy_env>
  800315:	83 c4 10             	add    $0x10,%esp
}
  800318:	90                   	nop
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <exit>:

void
exit(void)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800321:	e8 e1 12 00 00       	call   801607 <sys_exit_env>
}
  800326:	90                   	nop
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	53                   	push   %ebx
  80032d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800330:	8b 45 0c             	mov    0xc(%ebp),%eax
  800333:	8b 00                	mov    (%eax),%eax
  800335:	8d 48 01             	lea    0x1(%eax),%ecx
  800338:	8b 55 0c             	mov    0xc(%ebp),%edx
  80033b:	89 0a                	mov    %ecx,(%edx)
  80033d:	8b 55 08             	mov    0x8(%ebp),%edx
  800340:	88 d1                	mov    %dl,%cl
  800342:	8b 55 0c             	mov    0xc(%ebp),%edx
  800345:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800349:	8b 45 0c             	mov    0xc(%ebp),%eax
  80034c:	8b 00                	mov    (%eax),%eax
  80034e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800353:	75 30                	jne    800385 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800355:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80035b:	a0 40 30 80 00       	mov    0x803040,%al
  800360:	0f b6 c0             	movzbl %al,%eax
  800363:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800366:	8b 09                	mov    (%ecx),%ecx
  800368:	89 cb                	mov    %ecx,%ebx
  80036a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80036d:	83 c1 08             	add    $0x8,%ecx
  800370:	52                   	push   %edx
  800371:	50                   	push   %eax
  800372:	53                   	push   %ebx
  800373:	51                   	push   %ecx
  800374:	e8 a0 0f 00 00       	call   801319 <sys_cputs>
  800379:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80037c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800385:	8b 45 0c             	mov    0xc(%ebp),%eax
  800388:	8b 40 04             	mov    0x4(%eax),%eax
  80038b:	8d 50 01             	lea    0x1(%eax),%edx
  80038e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800391:	89 50 04             	mov    %edx,0x4(%eax)
}
  800394:	90                   	nop
  800395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800398:	c9                   	leave  
  800399:	c3                   	ret    

0080039a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80039a:	55                   	push   %ebp
  80039b:	89 e5                	mov    %esp,%ebp
  80039d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003a3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003aa:	00 00 00 
	b.cnt = 0;
  8003ad:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003b4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003b7:	ff 75 0c             	pushl  0xc(%ebp)
  8003ba:	ff 75 08             	pushl  0x8(%ebp)
  8003bd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c3:	50                   	push   %eax
  8003c4:	68 29 03 80 00       	push   $0x800329
  8003c9:	e8 5a 02 00 00       	call   800628 <vprintfmt>
  8003ce:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003d1:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003d7:	a0 40 30 80 00       	mov    0x803040,%al
  8003dc:	0f b6 c0             	movzbl %al,%eax
  8003df:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003e5:	52                   	push   %edx
  8003e6:	50                   	push   %eax
  8003e7:	51                   	push   %ecx
  8003e8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003ee:	83 c0 08             	add    $0x8,%eax
  8003f1:	50                   	push   %eax
  8003f2:	e8 22 0f 00 00       	call   801319 <sys_cputs>
  8003f7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003fa:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800401:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800407:	c9                   	leave  
  800408:	c3                   	ret    

00800409 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
  80040c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80040f:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800416:	8d 45 0c             	lea    0xc(%ebp),%eax
  800419:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80041c:	8b 45 08             	mov    0x8(%ebp),%eax
  80041f:	83 ec 08             	sub    $0x8,%esp
  800422:	ff 75 f4             	pushl  -0xc(%ebp)
  800425:	50                   	push   %eax
  800426:	e8 6f ff ff ff       	call   80039a <vcprintf>
  80042b:	83 c4 10             	add    $0x10,%esp
  80042e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800431:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800434:	c9                   	leave  
  800435:	c3                   	ret    

00800436 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800436:	55                   	push   %ebp
  800437:	89 e5                	mov    %esp,%ebp
  800439:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80043c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800443:	8b 45 08             	mov    0x8(%ebp),%eax
  800446:	c1 e0 08             	shl    $0x8,%eax
  800449:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  80044e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800451:	83 c0 04             	add    $0x4,%eax
  800454:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800457:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045a:	83 ec 08             	sub    $0x8,%esp
  80045d:	ff 75 f4             	pushl  -0xc(%ebp)
  800460:	50                   	push   %eax
  800461:	e8 34 ff ff ff       	call   80039a <vcprintf>
  800466:	83 c4 10             	add    $0x10,%esp
  800469:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80046c:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800473:	07 00 00 

	return cnt;
  800476:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800479:	c9                   	leave  
  80047a:	c3                   	ret    

0080047b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80047b:	55                   	push   %ebp
  80047c:	89 e5                	mov    %esp,%ebp
  80047e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800481:	e8 d7 0e 00 00       	call   80135d <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800486:	8d 45 0c             	lea    0xc(%ebp),%eax
  800489:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80048c:	8b 45 08             	mov    0x8(%ebp),%eax
  80048f:	83 ec 08             	sub    $0x8,%esp
  800492:	ff 75 f4             	pushl  -0xc(%ebp)
  800495:	50                   	push   %eax
  800496:	e8 ff fe ff ff       	call   80039a <vcprintf>
  80049b:	83 c4 10             	add    $0x10,%esp
  80049e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004a1:	e8 d1 0e 00 00       	call   801377 <sys_unlock_cons>
	return cnt;
  8004a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004a9:	c9                   	leave  
  8004aa:	c3                   	ret    

008004ab <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004ab:	55                   	push   %ebp
  8004ac:	89 e5                	mov    %esp,%ebp
  8004ae:	53                   	push   %ebx
  8004af:	83 ec 14             	sub    $0x14,%esp
  8004b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8004bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004be:	8b 45 18             	mov    0x18(%ebp),%eax
  8004c1:	ba 00 00 00 00       	mov    $0x0,%edx
  8004c6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004c9:	77 55                	ja     800520 <printnum+0x75>
  8004cb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004ce:	72 05                	jb     8004d5 <printnum+0x2a>
  8004d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004d3:	77 4b                	ja     800520 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004d5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004d8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004db:	8b 45 18             	mov    0x18(%ebp),%eax
  8004de:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e3:	52                   	push   %edx
  8004e4:	50                   	push   %eax
  8004e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8004eb:	e8 60 15 00 00       	call   801a50 <__udivdi3>
  8004f0:	83 c4 10             	add    $0x10,%esp
  8004f3:	83 ec 04             	sub    $0x4,%esp
  8004f6:	ff 75 20             	pushl  0x20(%ebp)
  8004f9:	53                   	push   %ebx
  8004fa:	ff 75 18             	pushl  0x18(%ebp)
  8004fd:	52                   	push   %edx
  8004fe:	50                   	push   %eax
  8004ff:	ff 75 0c             	pushl  0xc(%ebp)
  800502:	ff 75 08             	pushl  0x8(%ebp)
  800505:	e8 a1 ff ff ff       	call   8004ab <printnum>
  80050a:	83 c4 20             	add    $0x20,%esp
  80050d:	eb 1a                	jmp    800529 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80050f:	83 ec 08             	sub    $0x8,%esp
  800512:	ff 75 0c             	pushl  0xc(%ebp)
  800515:	ff 75 20             	pushl  0x20(%ebp)
  800518:	8b 45 08             	mov    0x8(%ebp),%eax
  80051b:	ff d0                	call   *%eax
  80051d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800520:	ff 4d 1c             	decl   0x1c(%ebp)
  800523:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800527:	7f e6                	jg     80050f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800529:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80052c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800531:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800534:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800537:	53                   	push   %ebx
  800538:	51                   	push   %ecx
  800539:	52                   	push   %edx
  80053a:	50                   	push   %eax
  80053b:	e8 20 16 00 00       	call   801b60 <__umoddi3>
  800540:	83 c4 10             	add    $0x10,%esp
  800543:	05 f4 20 80 00       	add    $0x8020f4,%eax
  800548:	8a 00                	mov    (%eax),%al
  80054a:	0f be c0             	movsbl %al,%eax
  80054d:	83 ec 08             	sub    $0x8,%esp
  800550:	ff 75 0c             	pushl  0xc(%ebp)
  800553:	50                   	push   %eax
  800554:	8b 45 08             	mov    0x8(%ebp),%eax
  800557:	ff d0                	call   *%eax
  800559:	83 c4 10             	add    $0x10,%esp
}
  80055c:	90                   	nop
  80055d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800565:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800569:	7e 1c                	jle    800587 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80056b:	8b 45 08             	mov    0x8(%ebp),%eax
  80056e:	8b 00                	mov    (%eax),%eax
  800570:	8d 50 08             	lea    0x8(%eax),%edx
  800573:	8b 45 08             	mov    0x8(%ebp),%eax
  800576:	89 10                	mov    %edx,(%eax)
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	8b 00                	mov    (%eax),%eax
  80057d:	83 e8 08             	sub    $0x8,%eax
  800580:	8b 50 04             	mov    0x4(%eax),%edx
  800583:	8b 00                	mov    (%eax),%eax
  800585:	eb 40                	jmp    8005c7 <getuint+0x65>
	else if (lflag)
  800587:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80058b:	74 1e                	je     8005ab <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80058d:	8b 45 08             	mov    0x8(%ebp),%eax
  800590:	8b 00                	mov    (%eax),%eax
  800592:	8d 50 04             	lea    0x4(%eax),%edx
  800595:	8b 45 08             	mov    0x8(%ebp),%eax
  800598:	89 10                	mov    %edx,(%eax)
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	8b 00                	mov    (%eax),%eax
  80059f:	83 e8 04             	sub    $0x4,%eax
  8005a2:	8b 00                	mov    (%eax),%eax
  8005a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a9:	eb 1c                	jmp    8005c7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	8d 50 04             	lea    0x4(%eax),%edx
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	89 10                	mov    %edx,(%eax)
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	83 e8 04             	sub    $0x4,%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005c7:	5d                   	pop    %ebp
  8005c8:	c3                   	ret    

008005c9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005cc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d0:	7e 1c                	jle    8005ee <getint+0x25>
		return va_arg(*ap, long long);
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	8d 50 08             	lea    0x8(%eax),%edx
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	89 10                	mov    %edx,(%eax)
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	8b 00                	mov    (%eax),%eax
  8005e4:	83 e8 08             	sub    $0x8,%eax
  8005e7:	8b 50 04             	mov    0x4(%eax),%edx
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	eb 38                	jmp    800626 <getint+0x5d>
	else if (lflag)
  8005ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005f2:	74 1a                	je     80060e <getint+0x45>
		return va_arg(*ap, long);
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	8d 50 04             	lea    0x4(%eax),%edx
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	89 10                	mov    %edx,(%eax)
  800601:	8b 45 08             	mov    0x8(%ebp),%eax
  800604:	8b 00                	mov    (%eax),%eax
  800606:	83 e8 04             	sub    $0x4,%eax
  800609:	8b 00                	mov    (%eax),%eax
  80060b:	99                   	cltd   
  80060c:	eb 18                	jmp    800626 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	8b 00                	mov    (%eax),%eax
  800613:	8d 50 04             	lea    0x4(%eax),%edx
  800616:	8b 45 08             	mov    0x8(%ebp),%eax
  800619:	89 10                	mov    %edx,(%eax)
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	83 e8 04             	sub    $0x4,%eax
  800623:	8b 00                	mov    (%eax),%eax
  800625:	99                   	cltd   
}
  800626:	5d                   	pop    %ebp
  800627:	c3                   	ret    

00800628 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800628:	55                   	push   %ebp
  800629:	89 e5                	mov    %esp,%ebp
  80062b:	56                   	push   %esi
  80062c:	53                   	push   %ebx
  80062d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800630:	eb 17                	jmp    800649 <vprintfmt+0x21>
			if (ch == '\0')
  800632:	85 db                	test   %ebx,%ebx
  800634:	0f 84 c1 03 00 00    	je     8009fb <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 0c             	pushl  0xc(%ebp)
  800640:	53                   	push   %ebx
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	ff d0                	call   *%eax
  800646:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800649:	8b 45 10             	mov    0x10(%ebp),%eax
  80064c:	8d 50 01             	lea    0x1(%eax),%edx
  80064f:	89 55 10             	mov    %edx,0x10(%ebp)
  800652:	8a 00                	mov    (%eax),%al
  800654:	0f b6 d8             	movzbl %al,%ebx
  800657:	83 fb 25             	cmp    $0x25,%ebx
  80065a:	75 d6                	jne    800632 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80065c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800660:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800667:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80066e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800675:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80067c:	8b 45 10             	mov    0x10(%ebp),%eax
  80067f:	8d 50 01             	lea    0x1(%eax),%edx
  800682:	89 55 10             	mov    %edx,0x10(%ebp)
  800685:	8a 00                	mov    (%eax),%al
  800687:	0f b6 d8             	movzbl %al,%ebx
  80068a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80068d:	83 f8 5b             	cmp    $0x5b,%eax
  800690:	0f 87 3d 03 00 00    	ja     8009d3 <vprintfmt+0x3ab>
  800696:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  80069d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80069f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006a3:	eb d7                	jmp    80067c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006a5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006a9:	eb d1                	jmp    80067c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006b5:	89 d0                	mov    %edx,%eax
  8006b7:	c1 e0 02             	shl    $0x2,%eax
  8006ba:	01 d0                	add    %edx,%eax
  8006bc:	01 c0                	add    %eax,%eax
  8006be:	01 d8                	add    %ebx,%eax
  8006c0:	83 e8 30             	sub    $0x30,%eax
  8006c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8006c9:	8a 00                	mov    (%eax),%al
  8006cb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006ce:	83 fb 2f             	cmp    $0x2f,%ebx
  8006d1:	7e 3e                	jle    800711 <vprintfmt+0xe9>
  8006d3:	83 fb 39             	cmp    $0x39,%ebx
  8006d6:	7f 39                	jg     800711 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006d8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006db:	eb d5                	jmp    8006b2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e0:	83 c0 04             	add    $0x4,%eax
  8006e3:	89 45 14             	mov    %eax,0x14(%ebp)
  8006e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e9:	83 e8 04             	sub    $0x4,%eax
  8006ec:	8b 00                	mov    (%eax),%eax
  8006ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006f1:	eb 1f                	jmp    800712 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f7:	79 83                	jns    80067c <vprintfmt+0x54>
				width = 0;
  8006f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800700:	e9 77 ff ff ff       	jmp    80067c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800705:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80070c:	e9 6b ff ff ff       	jmp    80067c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800711:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800712:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800716:	0f 89 60 ff ff ff    	jns    80067c <vprintfmt+0x54>
				width = precision, precision = -1;
  80071c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80071f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800722:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800729:	e9 4e ff ff ff       	jmp    80067c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80072e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800731:	e9 46 ff ff ff       	jmp    80067c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800736:	8b 45 14             	mov    0x14(%ebp),%eax
  800739:	83 c0 04             	add    $0x4,%eax
  80073c:	89 45 14             	mov    %eax,0x14(%ebp)
  80073f:	8b 45 14             	mov    0x14(%ebp),%eax
  800742:	83 e8 04             	sub    $0x4,%eax
  800745:	8b 00                	mov    (%eax),%eax
  800747:	83 ec 08             	sub    $0x8,%esp
  80074a:	ff 75 0c             	pushl  0xc(%ebp)
  80074d:	50                   	push   %eax
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	ff d0                	call   *%eax
  800753:	83 c4 10             	add    $0x10,%esp
			break;
  800756:	e9 9b 02 00 00       	jmp    8009f6 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80075b:	8b 45 14             	mov    0x14(%ebp),%eax
  80075e:	83 c0 04             	add    $0x4,%eax
  800761:	89 45 14             	mov    %eax,0x14(%ebp)
  800764:	8b 45 14             	mov    0x14(%ebp),%eax
  800767:	83 e8 04             	sub    $0x4,%eax
  80076a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80076c:	85 db                	test   %ebx,%ebx
  80076e:	79 02                	jns    800772 <vprintfmt+0x14a>
				err = -err;
  800770:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800772:	83 fb 64             	cmp    $0x64,%ebx
  800775:	7f 0b                	jg     800782 <vprintfmt+0x15a>
  800777:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  80077e:	85 f6                	test   %esi,%esi
  800780:	75 19                	jne    80079b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800782:	53                   	push   %ebx
  800783:	68 05 21 80 00       	push   $0x802105
  800788:	ff 75 0c             	pushl  0xc(%ebp)
  80078b:	ff 75 08             	pushl  0x8(%ebp)
  80078e:	e8 70 02 00 00       	call   800a03 <printfmt>
  800793:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800796:	e9 5b 02 00 00       	jmp    8009f6 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80079b:	56                   	push   %esi
  80079c:	68 0e 21 80 00       	push   $0x80210e
  8007a1:	ff 75 0c             	pushl  0xc(%ebp)
  8007a4:	ff 75 08             	pushl  0x8(%ebp)
  8007a7:	e8 57 02 00 00       	call   800a03 <printfmt>
  8007ac:	83 c4 10             	add    $0x10,%esp
			break;
  8007af:	e9 42 02 00 00       	jmp    8009f6 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b7:	83 c0 04             	add    $0x4,%eax
  8007ba:	89 45 14             	mov    %eax,0x14(%ebp)
  8007bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c0:	83 e8 04             	sub    $0x4,%eax
  8007c3:	8b 30                	mov    (%eax),%esi
  8007c5:	85 f6                	test   %esi,%esi
  8007c7:	75 05                	jne    8007ce <vprintfmt+0x1a6>
				p = "(null)";
  8007c9:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  8007ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d2:	7e 6d                	jle    800841 <vprintfmt+0x219>
  8007d4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007d8:	74 67                	je     800841 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007dd:	83 ec 08             	sub    $0x8,%esp
  8007e0:	50                   	push   %eax
  8007e1:	56                   	push   %esi
  8007e2:	e8 1e 03 00 00       	call   800b05 <strnlen>
  8007e7:	83 c4 10             	add    $0x10,%esp
  8007ea:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007ed:	eb 16                	jmp    800805 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007ef:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007f3:	83 ec 08             	sub    $0x8,%esp
  8007f6:	ff 75 0c             	pushl  0xc(%ebp)
  8007f9:	50                   	push   %eax
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	ff d0                	call   *%eax
  8007ff:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800802:	ff 4d e4             	decl   -0x1c(%ebp)
  800805:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800809:	7f e4                	jg     8007ef <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80080b:	eb 34                	jmp    800841 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80080d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800811:	74 1c                	je     80082f <vprintfmt+0x207>
  800813:	83 fb 1f             	cmp    $0x1f,%ebx
  800816:	7e 05                	jle    80081d <vprintfmt+0x1f5>
  800818:	83 fb 7e             	cmp    $0x7e,%ebx
  80081b:	7e 12                	jle    80082f <vprintfmt+0x207>
					putch('?', putdat);
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	ff 75 0c             	pushl  0xc(%ebp)
  800823:	6a 3f                	push   $0x3f
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	ff d0                	call   *%eax
  80082a:	83 c4 10             	add    $0x10,%esp
  80082d:	eb 0f                	jmp    80083e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80082f:	83 ec 08             	sub    $0x8,%esp
  800832:	ff 75 0c             	pushl  0xc(%ebp)
  800835:	53                   	push   %ebx
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	ff d0                	call   *%eax
  80083b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80083e:	ff 4d e4             	decl   -0x1c(%ebp)
  800841:	89 f0                	mov    %esi,%eax
  800843:	8d 70 01             	lea    0x1(%eax),%esi
  800846:	8a 00                	mov    (%eax),%al
  800848:	0f be d8             	movsbl %al,%ebx
  80084b:	85 db                	test   %ebx,%ebx
  80084d:	74 24                	je     800873 <vprintfmt+0x24b>
  80084f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800853:	78 b8                	js     80080d <vprintfmt+0x1e5>
  800855:	ff 4d e0             	decl   -0x20(%ebp)
  800858:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80085c:	79 af                	jns    80080d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80085e:	eb 13                	jmp    800873 <vprintfmt+0x24b>
				putch(' ', putdat);
  800860:	83 ec 08             	sub    $0x8,%esp
  800863:	ff 75 0c             	pushl  0xc(%ebp)
  800866:	6a 20                	push   $0x20
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	ff d0                	call   *%eax
  80086d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800870:	ff 4d e4             	decl   -0x1c(%ebp)
  800873:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800877:	7f e7                	jg     800860 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800879:	e9 78 01 00 00       	jmp    8009f6 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	ff 75 e8             	pushl  -0x18(%ebp)
  800884:	8d 45 14             	lea    0x14(%ebp),%eax
  800887:	50                   	push   %eax
  800888:	e8 3c fd ff ff       	call   8005c9 <getint>
  80088d:	83 c4 10             	add    $0x10,%esp
  800890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800893:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800896:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800899:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80089c:	85 d2                	test   %edx,%edx
  80089e:	79 23                	jns    8008c3 <vprintfmt+0x29b>
				putch('-', putdat);
  8008a0:	83 ec 08             	sub    $0x8,%esp
  8008a3:	ff 75 0c             	pushl  0xc(%ebp)
  8008a6:	6a 2d                	push   $0x2d
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	ff d0                	call   *%eax
  8008ad:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b6:	f7 d8                	neg    %eax
  8008b8:	83 d2 00             	adc    $0x0,%edx
  8008bb:	f7 da                	neg    %edx
  8008bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008c3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008ca:	e9 bc 00 00 00       	jmp    80098b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8008d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8008d8:	50                   	push   %eax
  8008d9:	e8 84 fc ff ff       	call   800562 <getuint>
  8008de:	83 c4 10             	add    $0x10,%esp
  8008e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008e7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008ee:	e9 98 00 00 00       	jmp    80098b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008f3:	83 ec 08             	sub    $0x8,%esp
  8008f6:	ff 75 0c             	pushl  0xc(%ebp)
  8008f9:	6a 58                	push   $0x58
  8008fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fe:	ff d0                	call   *%eax
  800900:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800903:	83 ec 08             	sub    $0x8,%esp
  800906:	ff 75 0c             	pushl  0xc(%ebp)
  800909:	6a 58                	push   $0x58
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	ff d0                	call   *%eax
  800910:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800913:	83 ec 08             	sub    $0x8,%esp
  800916:	ff 75 0c             	pushl  0xc(%ebp)
  800919:	6a 58                	push   $0x58
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	ff d0                	call   *%eax
  800920:	83 c4 10             	add    $0x10,%esp
			break;
  800923:	e9 ce 00 00 00       	jmp    8009f6 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800928:	83 ec 08             	sub    $0x8,%esp
  80092b:	ff 75 0c             	pushl  0xc(%ebp)
  80092e:	6a 30                	push   $0x30
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	ff d0                	call   *%eax
  800935:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 0c             	pushl  0xc(%ebp)
  80093e:	6a 78                	push   $0x78
  800940:	8b 45 08             	mov    0x8(%ebp),%eax
  800943:	ff d0                	call   *%eax
  800945:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800948:	8b 45 14             	mov    0x14(%ebp),%eax
  80094b:	83 c0 04             	add    $0x4,%eax
  80094e:	89 45 14             	mov    %eax,0x14(%ebp)
  800951:	8b 45 14             	mov    0x14(%ebp),%eax
  800954:	83 e8 04             	sub    $0x4,%eax
  800957:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800959:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800963:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80096a:	eb 1f                	jmp    80098b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80096c:	83 ec 08             	sub    $0x8,%esp
  80096f:	ff 75 e8             	pushl  -0x18(%ebp)
  800972:	8d 45 14             	lea    0x14(%ebp),%eax
  800975:	50                   	push   %eax
  800976:	e8 e7 fb ff ff       	call   800562 <getuint>
  80097b:	83 c4 10             	add    $0x10,%esp
  80097e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800981:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800984:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80098b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80098f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800992:	83 ec 04             	sub    $0x4,%esp
  800995:	52                   	push   %edx
  800996:	ff 75 e4             	pushl  -0x1c(%ebp)
  800999:	50                   	push   %eax
  80099a:	ff 75 f4             	pushl  -0xc(%ebp)
  80099d:	ff 75 f0             	pushl  -0x10(%ebp)
  8009a0:	ff 75 0c             	pushl  0xc(%ebp)
  8009a3:	ff 75 08             	pushl  0x8(%ebp)
  8009a6:	e8 00 fb ff ff       	call   8004ab <printnum>
  8009ab:	83 c4 20             	add    $0x20,%esp
			break;
  8009ae:	eb 46                	jmp    8009f6 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009b0:	83 ec 08             	sub    $0x8,%esp
  8009b3:	ff 75 0c             	pushl  0xc(%ebp)
  8009b6:	53                   	push   %ebx
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	ff d0                	call   *%eax
  8009bc:	83 c4 10             	add    $0x10,%esp
			break;
  8009bf:	eb 35                	jmp    8009f6 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009c1:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009c8:	eb 2c                	jmp    8009f6 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009ca:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009d1:	eb 23                	jmp    8009f6 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009d3:	83 ec 08             	sub    $0x8,%esp
  8009d6:	ff 75 0c             	pushl  0xc(%ebp)
  8009d9:	6a 25                	push   $0x25
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	ff d0                	call   *%eax
  8009e0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009e3:	ff 4d 10             	decl   0x10(%ebp)
  8009e6:	eb 03                	jmp    8009eb <vprintfmt+0x3c3>
  8009e8:	ff 4d 10             	decl   0x10(%ebp)
  8009eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ee:	48                   	dec    %eax
  8009ef:	8a 00                	mov    (%eax),%al
  8009f1:	3c 25                	cmp    $0x25,%al
  8009f3:	75 f3                	jne    8009e8 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8009f5:	90                   	nop
		}
	}
  8009f6:	e9 35 fc ff ff       	jmp    800630 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009fb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009ff:	5b                   	pop    %ebx
  800a00:	5e                   	pop    %esi
  800a01:	5d                   	pop    %ebp
  800a02:	c3                   	ret    

00800a03 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
  800a06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a09:	8d 45 10             	lea    0x10(%ebp),%eax
  800a0c:	83 c0 04             	add    $0x4,%eax
  800a0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a12:	8b 45 10             	mov    0x10(%ebp),%eax
  800a15:	ff 75 f4             	pushl  -0xc(%ebp)
  800a18:	50                   	push   %eax
  800a19:	ff 75 0c             	pushl  0xc(%ebp)
  800a1c:	ff 75 08             	pushl  0x8(%ebp)
  800a1f:	e8 04 fc ff ff       	call   800628 <vprintfmt>
  800a24:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a27:	90                   	nop
  800a28:	c9                   	leave  
  800a29:	c3                   	ret    

00800a2a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a2a:	55                   	push   %ebp
  800a2b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	8b 40 08             	mov    0x8(%eax),%eax
  800a33:	8d 50 01             	lea    0x1(%eax),%edx
  800a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a39:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3f:	8b 10                	mov    (%eax),%edx
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	8b 40 04             	mov    0x4(%eax),%eax
  800a47:	39 c2                	cmp    %eax,%edx
  800a49:	73 12                	jae    800a5d <sprintputch+0x33>
		*b->buf++ = ch;
  800a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4e:	8b 00                	mov    (%eax),%eax
  800a50:	8d 48 01             	lea    0x1(%eax),%ecx
  800a53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a56:	89 0a                	mov    %ecx,(%edx)
  800a58:	8b 55 08             	mov    0x8(%ebp),%edx
  800a5b:	88 10                	mov    %dl,(%eax)
}
  800a5d:	90                   	nop
  800a5e:	5d                   	pop    %ebp
  800a5f:	c3                   	ret    

00800a60 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	01 d0                	add    %edx,%eax
  800a77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a81:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a85:	74 06                	je     800a8d <vsnprintf+0x2d>
  800a87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a8b:	7f 07                	jg     800a94 <vsnprintf+0x34>
		return -E_INVAL;
  800a8d:	b8 03 00 00 00       	mov    $0x3,%eax
  800a92:	eb 20                	jmp    800ab4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a94:	ff 75 14             	pushl  0x14(%ebp)
  800a97:	ff 75 10             	pushl  0x10(%ebp)
  800a9a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a9d:	50                   	push   %eax
  800a9e:	68 2a 0a 80 00       	push   $0x800a2a
  800aa3:	e8 80 fb ff ff       	call   800628 <vprintfmt>
  800aa8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ab4:	c9                   	leave  
  800ab5:	c3                   	ret    

00800ab6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ab6:	55                   	push   %ebp
  800ab7:	89 e5                	mov    %esp,%ebp
  800ab9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800abc:	8d 45 10             	lea    0x10(%ebp),%eax
  800abf:	83 c0 04             	add    $0x4,%eax
  800ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ac5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac8:	ff 75 f4             	pushl  -0xc(%ebp)
  800acb:	50                   	push   %eax
  800acc:	ff 75 0c             	pushl  0xc(%ebp)
  800acf:	ff 75 08             	pushl  0x8(%ebp)
  800ad2:	e8 89 ff ff ff       	call   800a60 <vsnprintf>
  800ad7:	83 c4 10             	add    $0x10,%esp
  800ada:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800add:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae0:	c9                   	leave  
  800ae1:	c3                   	ret    

00800ae2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ae2:	55                   	push   %ebp
  800ae3:	89 e5                	mov    %esp,%ebp
  800ae5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ae8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800aef:	eb 06                	jmp    800af7 <strlen+0x15>
		n++;
  800af1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800af4:	ff 45 08             	incl   0x8(%ebp)
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	8a 00                	mov    (%eax),%al
  800afc:	84 c0                	test   %al,%al
  800afe:	75 f1                	jne    800af1 <strlen+0xf>
		n++;
	return n;
  800b00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b03:	c9                   	leave  
  800b04:	c3                   	ret    

00800b05 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b05:	55                   	push   %ebp
  800b06:	89 e5                	mov    %esp,%ebp
  800b08:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b12:	eb 09                	jmp    800b1d <strnlen+0x18>
		n++;
  800b14:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b17:	ff 45 08             	incl   0x8(%ebp)
  800b1a:	ff 4d 0c             	decl   0xc(%ebp)
  800b1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b21:	74 09                	je     800b2c <strnlen+0x27>
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8a 00                	mov    (%eax),%al
  800b28:	84 c0                	test   %al,%al
  800b2a:	75 e8                	jne    800b14 <strnlen+0xf>
		n++;
	return n;
  800b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b2f:	c9                   	leave  
  800b30:	c3                   	ret    

00800b31 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b31:	55                   	push   %ebp
  800b32:	89 e5                	mov    %esp,%ebp
  800b34:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b3d:	90                   	nop
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8d 50 01             	lea    0x1(%eax),%edx
  800b44:	89 55 08             	mov    %edx,0x8(%ebp)
  800b47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b4d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b50:	8a 12                	mov    (%edx),%dl
  800b52:	88 10                	mov    %dl,(%eax)
  800b54:	8a 00                	mov    (%eax),%al
  800b56:	84 c0                	test   %al,%al
  800b58:	75 e4                	jne    800b3e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b72:	eb 1f                	jmp    800b93 <strncpy+0x34>
		*dst++ = *src;
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	8d 50 01             	lea    0x1(%eax),%edx
  800b7a:	89 55 08             	mov    %edx,0x8(%ebp)
  800b7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b80:	8a 12                	mov    (%edx),%dl
  800b82:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b87:	8a 00                	mov    (%eax),%al
  800b89:	84 c0                	test   %al,%al
  800b8b:	74 03                	je     800b90 <strncpy+0x31>
			src++;
  800b8d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b90:	ff 45 fc             	incl   -0x4(%ebp)
  800b93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b96:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b99:	72 d9                	jb     800b74 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b9e:	c9                   	leave  
  800b9f:	c3                   	ret    

00800ba0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ba0:	55                   	push   %ebp
  800ba1:	89 e5                	mov    %esp,%ebp
  800ba3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb0:	74 30                	je     800be2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bb2:	eb 16                	jmp    800bca <strlcpy+0x2a>
			*dst++ = *src++;
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	8d 50 01             	lea    0x1(%eax),%edx
  800bba:	89 55 08             	mov    %edx,0x8(%ebp)
  800bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc6:	8a 12                	mov    (%edx),%dl
  800bc8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bca:	ff 4d 10             	decl   0x10(%ebp)
  800bcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd1:	74 09                	je     800bdc <strlcpy+0x3c>
  800bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd6:	8a 00                	mov    (%eax),%al
  800bd8:	84 c0                	test   %al,%al
  800bda:	75 d8                	jne    800bb4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800be2:	8b 55 08             	mov    0x8(%ebp),%edx
  800be5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be8:	29 c2                	sub    %eax,%edx
  800bea:	89 d0                	mov    %edx,%eax
}
  800bec:	c9                   	leave  
  800bed:	c3                   	ret    

00800bee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bf1:	eb 06                	jmp    800bf9 <strcmp+0xb>
		p++, q++;
  800bf3:	ff 45 08             	incl   0x8(%ebp)
  800bf6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	8a 00                	mov    (%eax),%al
  800bfe:	84 c0                	test   %al,%al
  800c00:	74 0e                	je     800c10 <strcmp+0x22>
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	8a 10                	mov    (%eax),%dl
  800c07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	38 c2                	cmp    %al,%dl
  800c0e:	74 e3                	je     800bf3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	0f b6 d0             	movzbl %al,%edx
  800c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	0f b6 c0             	movzbl %al,%eax
  800c20:	29 c2                	sub    %eax,%edx
  800c22:	89 d0                	mov    %edx,%eax
}
  800c24:	5d                   	pop    %ebp
  800c25:	c3                   	ret    

00800c26 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c29:	eb 09                	jmp    800c34 <strncmp+0xe>
		n--, p++, q++;
  800c2b:	ff 4d 10             	decl   0x10(%ebp)
  800c2e:	ff 45 08             	incl   0x8(%ebp)
  800c31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c38:	74 17                	je     800c51 <strncmp+0x2b>
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	8a 00                	mov    (%eax),%al
  800c3f:	84 c0                	test   %al,%al
  800c41:	74 0e                	je     800c51 <strncmp+0x2b>
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8a 10                	mov    (%eax),%dl
  800c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	38 c2                	cmp    %al,%dl
  800c4f:	74 da                	je     800c2b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c55:	75 07                	jne    800c5e <strncmp+0x38>
		return 0;
  800c57:	b8 00 00 00 00       	mov    $0x0,%eax
  800c5c:	eb 14                	jmp    800c72 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	8a 00                	mov    (%eax),%al
  800c63:	0f b6 d0             	movzbl %al,%edx
  800c66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c69:	8a 00                	mov    (%eax),%al
  800c6b:	0f b6 c0             	movzbl %al,%eax
  800c6e:	29 c2                	sub    %eax,%edx
  800c70:	89 d0                	mov    %edx,%eax
}
  800c72:	5d                   	pop    %ebp
  800c73:	c3                   	ret    

00800c74 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c74:	55                   	push   %ebp
  800c75:	89 e5                	mov    %esp,%ebp
  800c77:	83 ec 04             	sub    $0x4,%esp
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c80:	eb 12                	jmp    800c94 <strchr+0x20>
		if (*s == c)
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	8a 00                	mov    (%eax),%al
  800c87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c8a:	75 05                	jne    800c91 <strchr+0x1d>
			return (char *) s;
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	eb 11                	jmp    800ca2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c91:	ff 45 08             	incl   0x8(%ebp)
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	84 c0                	test   %al,%al
  800c9b:	75 e5                	jne    800c82 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ca2:	c9                   	leave  
  800ca3:	c3                   	ret    

00800ca4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ca4:	55                   	push   %ebp
  800ca5:	89 e5                	mov    %esp,%ebp
  800ca7:	83 ec 04             	sub    $0x4,%esp
  800caa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cb0:	eb 0d                	jmp    800cbf <strfind+0x1b>
		if (*s == c)
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cba:	74 0e                	je     800cca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cbc:	ff 45 08             	incl   0x8(%ebp)
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	84 c0                	test   %al,%al
  800cc6:	75 ea                	jne    800cb2 <strfind+0xe>
  800cc8:	eb 01                	jmp    800ccb <strfind+0x27>
		if (*s == c)
			break;
  800cca:	90                   	nop
	return (char *) s;
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cce:	c9                   	leave  
  800ccf:	c3                   	ret    

00800cd0 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800cd0:	55                   	push   %ebp
  800cd1:	89 e5                	mov    %esp,%ebp
  800cd3:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800cdc:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ce0:	76 63                	jbe    800d45 <memset+0x75>
		uint64 data_block = c;
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	99                   	cltd   
  800ce6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ce9:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf2:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800cf6:	c1 e0 08             	shl    $0x8,%eax
  800cf9:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cfc:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d05:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d09:	c1 e0 10             	shl    $0x10,%eax
  800d0c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d0f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d18:	89 c2                	mov    %eax,%edx
  800d1a:	b8 00 00 00 00       	mov    $0x0,%eax
  800d1f:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d22:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d25:	eb 18                	jmp    800d3f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d27:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d2a:	8d 41 08             	lea    0x8(%ecx),%eax
  800d2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d36:	89 01                	mov    %eax,(%ecx)
  800d38:	89 51 04             	mov    %edx,0x4(%ecx)
  800d3b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d3f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d43:	77 e2                	ja     800d27 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d49:	74 23                	je     800d6e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d51:	eb 0e                	jmp    800d61 <memset+0x91>
			*p8++ = (uint8)c;
  800d53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d56:	8d 50 01             	lea    0x1(%eax),%edx
  800d59:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d61:	8b 45 10             	mov    0x10(%ebp),%eax
  800d64:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d67:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6a:	85 c0                	test   %eax,%eax
  800d6c:	75 e5                	jne    800d53 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d71:	c9                   	leave  
  800d72:	c3                   	ret    

00800d73 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d73:	55                   	push   %ebp
  800d74:	89 e5                	mov    %esp,%ebp
  800d76:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d85:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d89:	76 24                	jbe    800daf <memcpy+0x3c>
		while(n >= 8){
  800d8b:	eb 1c                	jmp    800da9 <memcpy+0x36>
			*d64 = *s64;
  800d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d90:	8b 50 04             	mov    0x4(%eax),%edx
  800d93:	8b 00                	mov    (%eax),%eax
  800d95:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d98:	89 01                	mov    %eax,(%ecx)
  800d9a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d9d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800da1:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800da5:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800da9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800dad:	77 de                	ja     800d8d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800daf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db3:	74 31                	je     800de6 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800db5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800dbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800dc1:	eb 16                	jmp    800dd9 <memcpy+0x66>
			*d8++ = *s8++;
  800dc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc6:	8d 50 01             	lea    0x1(%eax),%edx
  800dc9:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800dcc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dcf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd2:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800dd5:	8a 12                	mov    (%edx),%dl
  800dd7:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddf:	89 55 10             	mov    %edx,0x10(%ebp)
  800de2:	85 c0                	test   %eax,%eax
  800de4:	75 dd                	jne    800dc3 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e00:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e03:	73 50                	jae    800e55 <memmove+0x6a>
  800e05:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e08:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0b:	01 d0                	add    %edx,%eax
  800e0d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e10:	76 43                	jbe    800e55 <memmove+0x6a>
		s += n;
  800e12:	8b 45 10             	mov    0x10(%ebp),%eax
  800e15:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e18:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e1e:	eb 10                	jmp    800e30 <memmove+0x45>
			*--d = *--s;
  800e20:	ff 4d f8             	decl   -0x8(%ebp)
  800e23:	ff 4d fc             	decl   -0x4(%ebp)
  800e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e29:	8a 10                	mov    (%eax),%dl
  800e2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e30:	8b 45 10             	mov    0x10(%ebp),%eax
  800e33:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e36:	89 55 10             	mov    %edx,0x10(%ebp)
  800e39:	85 c0                	test   %eax,%eax
  800e3b:	75 e3                	jne    800e20 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e3d:	eb 23                	jmp    800e62 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e42:	8d 50 01             	lea    0x1(%eax),%edx
  800e45:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e48:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e4b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e51:	8a 12                	mov    (%edx),%dl
  800e53:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e55:	8b 45 10             	mov    0x10(%ebp),%eax
  800e58:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5e:	85 c0                	test   %eax,%eax
  800e60:	75 dd                	jne    800e3f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e65:	c9                   	leave  
  800e66:	c3                   	ret    

00800e67 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e67:	55                   	push   %ebp
  800e68:	89 e5                	mov    %esp,%ebp
  800e6a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e76:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e79:	eb 2a                	jmp    800ea5 <memcmp+0x3e>
		if (*s1 != *s2)
  800e7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7e:	8a 10                	mov    (%eax),%dl
  800e80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e83:	8a 00                	mov    (%eax),%al
  800e85:	38 c2                	cmp    %al,%dl
  800e87:	74 16                	je     800e9f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	0f b6 d0             	movzbl %al,%edx
  800e91:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	0f b6 c0             	movzbl %al,%eax
  800e99:	29 c2                	sub    %eax,%edx
  800e9b:	89 d0                	mov    %edx,%eax
  800e9d:	eb 18                	jmp    800eb7 <memcmp+0x50>
		s1++, s2++;
  800e9f:	ff 45 fc             	incl   -0x4(%ebp)
  800ea2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ea5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eab:	89 55 10             	mov    %edx,0x10(%ebp)
  800eae:	85 c0                	test   %eax,%eax
  800eb0:	75 c9                	jne    800e7b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb7:	c9                   	leave  
  800eb8:	c3                   	ret    

00800eb9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eb9:	55                   	push   %ebp
  800eba:	89 e5                	mov    %esp,%ebp
  800ebc:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ebf:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	01 d0                	add    %edx,%eax
  800ec7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eca:	eb 15                	jmp    800ee1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	8a 00                	mov    (%eax),%al
  800ed1:	0f b6 d0             	movzbl %al,%edx
  800ed4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed7:	0f b6 c0             	movzbl %al,%eax
  800eda:	39 c2                	cmp    %eax,%edx
  800edc:	74 0d                	je     800eeb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ede:	ff 45 08             	incl   0x8(%ebp)
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ee7:	72 e3                	jb     800ecc <memfind+0x13>
  800ee9:	eb 01                	jmp    800eec <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eeb:	90                   	nop
	return (void *) s;
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eef:	c9                   	leave  
  800ef0:	c3                   	ret    

00800ef1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ef1:	55                   	push   %ebp
  800ef2:	89 e5                	mov    %esp,%ebp
  800ef4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ef7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800efe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f05:	eb 03                	jmp    800f0a <strtol+0x19>
		s++;
  800f07:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 20                	cmp    $0x20,%al
  800f11:	74 f4                	je     800f07 <strtol+0x16>
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	8a 00                	mov    (%eax),%al
  800f18:	3c 09                	cmp    $0x9,%al
  800f1a:	74 eb                	je     800f07 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	3c 2b                	cmp    $0x2b,%al
  800f23:	75 05                	jne    800f2a <strtol+0x39>
		s++;
  800f25:	ff 45 08             	incl   0x8(%ebp)
  800f28:	eb 13                	jmp    800f3d <strtol+0x4c>
	else if (*s == '-')
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	3c 2d                	cmp    $0x2d,%al
  800f31:	75 0a                	jne    800f3d <strtol+0x4c>
		s++, neg = 1;
  800f33:	ff 45 08             	incl   0x8(%ebp)
  800f36:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f3d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f41:	74 06                	je     800f49 <strtol+0x58>
  800f43:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f47:	75 20                	jne    800f69 <strtol+0x78>
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	3c 30                	cmp    $0x30,%al
  800f50:	75 17                	jne    800f69 <strtol+0x78>
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	40                   	inc    %eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3c 78                	cmp    $0x78,%al
  800f5a:	75 0d                	jne    800f69 <strtol+0x78>
		s += 2, base = 16;
  800f5c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f60:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f67:	eb 28                	jmp    800f91 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6d:	75 15                	jne    800f84 <strtol+0x93>
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	3c 30                	cmp    $0x30,%al
  800f76:	75 0c                	jne    800f84 <strtol+0x93>
		s++, base = 8;
  800f78:	ff 45 08             	incl   0x8(%ebp)
  800f7b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f82:	eb 0d                	jmp    800f91 <strtol+0xa0>
	else if (base == 0)
  800f84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f88:	75 07                	jne    800f91 <strtol+0xa0>
		base = 10;
  800f8a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	8a 00                	mov    (%eax),%al
  800f96:	3c 2f                	cmp    $0x2f,%al
  800f98:	7e 19                	jle    800fb3 <strtol+0xc2>
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	3c 39                	cmp    $0x39,%al
  800fa1:	7f 10                	jg     800fb3 <strtol+0xc2>
			dig = *s - '0';
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	0f be c0             	movsbl %al,%eax
  800fab:	83 e8 30             	sub    $0x30,%eax
  800fae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb1:	eb 42                	jmp    800ff5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	3c 60                	cmp    $0x60,%al
  800fba:	7e 19                	jle    800fd5 <strtol+0xe4>
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	8a 00                	mov    (%eax),%al
  800fc1:	3c 7a                	cmp    $0x7a,%al
  800fc3:	7f 10                	jg     800fd5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc8:	8a 00                	mov    (%eax),%al
  800fca:	0f be c0             	movsbl %al,%eax
  800fcd:	83 e8 57             	sub    $0x57,%eax
  800fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd3:	eb 20                	jmp    800ff5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	3c 40                	cmp    $0x40,%al
  800fdc:	7e 39                	jle    801017 <strtol+0x126>
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	8a 00                	mov    (%eax),%al
  800fe3:	3c 5a                	cmp    $0x5a,%al
  800fe5:	7f 30                	jg     801017 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fea:	8a 00                	mov    (%eax),%al
  800fec:	0f be c0             	movsbl %al,%eax
  800fef:	83 e8 37             	sub    $0x37,%eax
  800ff2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ffb:	7d 19                	jge    801016 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ffd:	ff 45 08             	incl   0x8(%ebp)
  801000:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801003:	0f af 45 10          	imul   0x10(%ebp),%eax
  801007:	89 c2                	mov    %eax,%edx
  801009:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80100c:	01 d0                	add    %edx,%eax
  80100e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801011:	e9 7b ff ff ff       	jmp    800f91 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801016:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801017:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80101b:	74 08                	je     801025 <strtol+0x134>
		*endptr = (char *) s;
  80101d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801020:	8b 55 08             	mov    0x8(%ebp),%edx
  801023:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801025:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801029:	74 07                	je     801032 <strtol+0x141>
  80102b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102e:	f7 d8                	neg    %eax
  801030:	eb 03                	jmp    801035 <strtol+0x144>
  801032:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <ltostr>:

void
ltostr(long value, char *str)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
  80103a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80103d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801044:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80104b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104f:	79 13                	jns    801064 <ltostr+0x2d>
	{
		neg = 1;
  801051:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801058:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80105e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801061:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80106c:	99                   	cltd   
  80106d:	f7 f9                	idiv   %ecx
  80106f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801072:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801075:	8d 50 01             	lea    0x1(%eax),%edx
  801078:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80107b:	89 c2                	mov    %eax,%edx
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	01 d0                	add    %edx,%eax
  801082:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801085:	83 c2 30             	add    $0x30,%edx
  801088:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80108a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80108d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801092:	f7 e9                	imul   %ecx
  801094:	c1 fa 02             	sar    $0x2,%edx
  801097:	89 c8                	mov    %ecx,%eax
  801099:	c1 f8 1f             	sar    $0x1f,%eax
  80109c:	29 c2                	sub    %eax,%edx
  80109e:	89 d0                	mov    %edx,%eax
  8010a0:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8010a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010a7:	75 bb                	jne    801064 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b3:	48                   	dec    %eax
  8010b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010bb:	74 3d                	je     8010fa <ltostr+0xc3>
		start = 1 ;
  8010bd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c4:	eb 34                	jmp    8010fa <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8010c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cc:	01 d0                	add    %edx,%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	01 c2                	add    %eax,%edx
  8010db:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e1:	01 c8                	add    %ecx,%eax
  8010e3:	8a 00                	mov    (%eax),%al
  8010e5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010e7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	01 c2                	add    %eax,%edx
  8010ef:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f2:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010f7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801100:	7c c4                	jl     8010c6 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801102:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801105:	8b 45 0c             	mov    0xc(%ebp),%eax
  801108:	01 d0                	add    %edx,%eax
  80110a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80110d:	90                   	nop
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
  801113:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801116:	ff 75 08             	pushl  0x8(%ebp)
  801119:	e8 c4 f9 ff ff       	call   800ae2 <strlen>
  80111e:	83 c4 04             	add    $0x4,%esp
  801121:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801124:	ff 75 0c             	pushl  0xc(%ebp)
  801127:	e8 b6 f9 ff ff       	call   800ae2 <strlen>
  80112c:	83 c4 04             	add    $0x4,%esp
  80112f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801132:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801139:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801140:	eb 17                	jmp    801159 <strcconcat+0x49>
		final[s] = str1[s] ;
  801142:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801145:	8b 45 10             	mov    0x10(%ebp),%eax
  801148:	01 c2                	add    %eax,%edx
  80114a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	01 c8                	add    %ecx,%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801156:	ff 45 fc             	incl   -0x4(%ebp)
  801159:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80115f:	7c e1                	jl     801142 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801161:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801168:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80116f:	eb 1f                	jmp    801190 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801171:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801174:	8d 50 01             	lea    0x1(%eax),%edx
  801177:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80117a:	89 c2                	mov    %eax,%edx
  80117c:	8b 45 10             	mov    0x10(%ebp),%eax
  80117f:	01 c2                	add    %eax,%edx
  801181:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	01 c8                	add    %ecx,%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80118d:	ff 45 f8             	incl   -0x8(%ebp)
  801190:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801193:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801196:	7c d9                	jl     801171 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801198:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119b:	8b 45 10             	mov    0x10(%ebp),%eax
  80119e:	01 d0                	add    %edx,%eax
  8011a0:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a3:	90                   	nop
  8011a4:	c9                   	leave  
  8011a5:	c3                   	ret    

008011a6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b5:	8b 00                	mov    (%eax),%eax
  8011b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011be:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c1:	01 d0                	add    %edx,%eax
  8011c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011c9:	eb 0c                	jmp    8011d7 <strsplit+0x31>
			*string++ = 0;
  8011cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ce:	8d 50 01             	lea    0x1(%eax),%edx
  8011d1:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	8a 00                	mov    (%eax),%al
  8011dc:	84 c0                	test   %al,%al
  8011de:	74 18                	je     8011f8 <strsplit+0x52>
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	0f be c0             	movsbl %al,%eax
  8011e8:	50                   	push   %eax
  8011e9:	ff 75 0c             	pushl  0xc(%ebp)
  8011ec:	e8 83 fa ff ff       	call   800c74 <strchr>
  8011f1:	83 c4 08             	add    $0x8,%esp
  8011f4:	85 c0                	test   %eax,%eax
  8011f6:	75 d3                	jne    8011cb <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	84 c0                	test   %al,%al
  8011ff:	74 5a                	je     80125b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801201:	8b 45 14             	mov    0x14(%ebp),%eax
  801204:	8b 00                	mov    (%eax),%eax
  801206:	83 f8 0f             	cmp    $0xf,%eax
  801209:	75 07                	jne    801212 <strsplit+0x6c>
		{
			return 0;
  80120b:	b8 00 00 00 00       	mov    $0x0,%eax
  801210:	eb 66                	jmp    801278 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801212:	8b 45 14             	mov    0x14(%ebp),%eax
  801215:	8b 00                	mov    (%eax),%eax
  801217:	8d 48 01             	lea    0x1(%eax),%ecx
  80121a:	8b 55 14             	mov    0x14(%ebp),%edx
  80121d:	89 0a                	mov    %ecx,(%edx)
  80121f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801226:	8b 45 10             	mov    0x10(%ebp),%eax
  801229:	01 c2                	add    %eax,%edx
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801230:	eb 03                	jmp    801235 <strsplit+0x8f>
			string++;
  801232:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	84 c0                	test   %al,%al
  80123c:	74 8b                	je     8011c9 <strsplit+0x23>
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	0f be c0             	movsbl %al,%eax
  801246:	50                   	push   %eax
  801247:	ff 75 0c             	pushl  0xc(%ebp)
  80124a:	e8 25 fa ff ff       	call   800c74 <strchr>
  80124f:	83 c4 08             	add    $0x8,%esp
  801252:	85 c0                	test   %eax,%eax
  801254:	74 dc                	je     801232 <strsplit+0x8c>
			string++;
	}
  801256:	e9 6e ff ff ff       	jmp    8011c9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80125b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80125c:	8b 45 14             	mov    0x14(%ebp),%eax
  80125f:	8b 00                	mov    (%eax),%eax
  801261:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801268:	8b 45 10             	mov    0x10(%ebp),%eax
  80126b:	01 d0                	add    %edx,%eax
  80126d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801273:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801278:	c9                   	leave  
  801279:	c3                   	ret    

0080127a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80127a:	55                   	push   %ebp
  80127b:	89 e5                	mov    %esp,%ebp
  80127d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801286:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80128d:	eb 4a                	jmp    8012d9 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80128f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	01 c2                	add    %eax,%edx
  801297:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80129a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129d:	01 c8                	add    %ecx,%eax
  80129f:	8a 00                	mov    (%eax),%al
  8012a1:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8012a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	01 d0                	add    %edx,%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	3c 40                	cmp    $0x40,%al
  8012af:	7e 25                	jle    8012d6 <str2lower+0x5c>
  8012b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b7:	01 d0                	add    %edx,%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	3c 5a                	cmp    $0x5a,%al
  8012bd:	7f 17                	jg     8012d6 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	01 d0                	add    %edx,%eax
  8012c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8012cd:	01 ca                	add    %ecx,%edx
  8012cf:	8a 12                	mov    (%edx),%dl
  8012d1:	83 c2 20             	add    $0x20,%edx
  8012d4:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012d6:	ff 45 fc             	incl   -0x4(%ebp)
  8012d9:	ff 75 0c             	pushl  0xc(%ebp)
  8012dc:	e8 01 f8 ff ff       	call   800ae2 <strlen>
  8012e1:	83 c4 04             	add    $0x4,%esp
  8012e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012e7:	7f a6                	jg     80128f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ec:	c9                   	leave  
  8012ed:	c3                   	ret    

008012ee <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012ee:	55                   	push   %ebp
  8012ef:	89 e5                	mov    %esp,%ebp
  8012f1:	57                   	push   %edi
  8012f2:	56                   	push   %esi
  8012f3:	53                   	push   %ebx
  8012f4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801300:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801303:	8b 7d 18             	mov    0x18(%ebp),%edi
  801306:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801309:	cd 30                	int    $0x30
  80130b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80130e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801311:	83 c4 10             	add    $0x10,%esp
  801314:	5b                   	pop    %ebx
  801315:	5e                   	pop    %esi
  801316:	5f                   	pop    %edi
  801317:	5d                   	pop    %ebp
  801318:	c3                   	ret    

00801319 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
  80131c:	83 ec 04             	sub    $0x4,%esp
  80131f:	8b 45 10             	mov    0x10(%ebp),%eax
  801322:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801325:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801328:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	6a 00                	push   $0x0
  801331:	51                   	push   %ecx
  801332:	52                   	push   %edx
  801333:	ff 75 0c             	pushl  0xc(%ebp)
  801336:	50                   	push   %eax
  801337:	6a 00                	push   $0x0
  801339:	e8 b0 ff ff ff       	call   8012ee <syscall>
  80133e:	83 c4 18             	add    $0x18,%esp
}
  801341:	90                   	nop
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <sys_cgetc>:

int
sys_cgetc(void)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 02                	push   $0x2
  801353:	e8 96 ff ff ff       	call   8012ee <syscall>
  801358:	83 c4 18             	add    $0x18,%esp
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <sys_lock_cons>:

void sys_lock_cons(void)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 03                	push   $0x3
  80136c:	e8 7d ff ff ff       	call   8012ee <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	90                   	nop
  801375:	c9                   	leave  
  801376:	c3                   	ret    

00801377 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801377:	55                   	push   %ebp
  801378:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 04                	push   $0x4
  801386:	e8 63 ff ff ff       	call   8012ee <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	90                   	nop
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801394:	8b 55 0c             	mov    0xc(%ebp),%edx
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	52                   	push   %edx
  8013a1:	50                   	push   %eax
  8013a2:	6a 08                	push   $0x8
  8013a4:	e8 45 ff ff ff       	call   8012ee <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
  8013b1:	56                   	push   %esi
  8013b2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013b3:	8b 75 18             	mov    0x18(%ebp),%esi
  8013b6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	56                   	push   %esi
  8013c3:	53                   	push   %ebx
  8013c4:	51                   	push   %ecx
  8013c5:	52                   	push   %edx
  8013c6:	50                   	push   %eax
  8013c7:	6a 09                	push   $0x9
  8013c9:	e8 20 ff ff ff       	call   8012ee <syscall>
  8013ce:	83 c4 18             	add    $0x18,%esp
}
  8013d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013d4:	5b                   	pop    %ebx
  8013d5:	5e                   	pop    %esi
  8013d6:	5d                   	pop    %ebp
  8013d7:	c3                   	ret    

008013d8 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	ff 75 08             	pushl  0x8(%ebp)
  8013e6:	6a 0a                	push   $0xa
  8013e8:	e8 01 ff ff ff       	call   8012ee <syscall>
  8013ed:	83 c4 18             	add    $0x18,%esp
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	ff 75 0c             	pushl  0xc(%ebp)
  8013fe:	ff 75 08             	pushl  0x8(%ebp)
  801401:	6a 0b                	push   $0xb
  801403:	e8 e6 fe ff ff       	call   8012ee <syscall>
  801408:	83 c4 18             	add    $0x18,%esp
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 0c                	push   $0xc
  80141c:	e8 cd fe ff ff       	call   8012ee <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 0d                	push   $0xd
  801435:	e8 b4 fe ff ff       	call   8012ee <syscall>
  80143a:	83 c4 18             	add    $0x18,%esp
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 0e                	push   $0xe
  80144e:	e8 9b fe ff ff       	call   8012ee <syscall>
  801453:	83 c4 18             	add    $0x18,%esp
}
  801456:	c9                   	leave  
  801457:	c3                   	ret    

00801458 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801458:	55                   	push   %ebp
  801459:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 0f                	push   $0xf
  801467:	e8 82 fe ff ff       	call   8012ee <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
}
  80146f:	c9                   	leave  
  801470:	c3                   	ret    

00801471 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	ff 75 08             	pushl  0x8(%ebp)
  80147f:	6a 10                	push   $0x10
  801481:	e8 68 fe ff ff       	call   8012ee <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 11                	push   $0x11
  80149a:	e8 4f fe ff ff       	call   8012ee <syscall>
  80149f:	83 c4 18             	add    $0x18,%esp
}
  8014a2:	90                   	nop
  8014a3:	c9                   	leave  
  8014a4:	c3                   	ret    

008014a5 <sys_cputc>:

void
sys_cputc(const char c)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 04             	sub    $0x4,%esp
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014b1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	50                   	push   %eax
  8014be:	6a 01                	push   $0x1
  8014c0:	e8 29 fe ff ff       	call   8012ee <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
}
  8014c8:	90                   	nop
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 14                	push   $0x14
  8014da:	e8 0f fe ff ff       	call   8012ee <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
}
  8014e2:	90                   	nop
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
  8014e8:	83 ec 04             	sub    $0x4,%esp
  8014eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8014f1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	6a 00                	push   $0x0
  8014fd:	51                   	push   %ecx
  8014fe:	52                   	push   %edx
  8014ff:	ff 75 0c             	pushl  0xc(%ebp)
  801502:	50                   	push   %eax
  801503:	6a 15                	push   $0x15
  801505:	e8 e4 fd ff ff       	call   8012ee <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801512:	8b 55 10             	mov    0x10(%ebp),%edx
  801515:	8b 45 0c             	mov    0xc(%ebp),%eax
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	52                   	push   %edx
  80151d:	50                   	push   %eax
  80151e:	ff 75 08             	pushl  0x8(%ebp)
  801521:	6a 16                	push   $0x16
  801523:	e8 c6 fd ff ff       	call   8012ee <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	52                   	push   %edx
  80153d:	50                   	push   %eax
  80153e:	6a 17                	push   $0x17
  801540:	e8 a9 fd ff ff       	call   8012ee <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80154d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801550:	8b 45 08             	mov    0x8(%ebp),%eax
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	52                   	push   %edx
  80155a:	50                   	push   %eax
  80155b:	6a 18                	push   $0x18
  80155d:	e8 8c fd ff ff       	call   8012ee <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	6a 00                	push   $0x0
  80156f:	ff 75 14             	pushl  0x14(%ebp)
  801572:	ff 75 10             	pushl  0x10(%ebp)
  801575:	ff 75 0c             	pushl  0xc(%ebp)
  801578:	50                   	push   %eax
  801579:	6a 19                	push   $0x19
  80157b:	e8 6e fd ff ff       	call   8012ee <syscall>
  801580:	83 c4 18             	add    $0x18,%esp
}
  801583:	c9                   	leave  
  801584:	c3                   	ret    

00801585 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801585:	55                   	push   %ebp
  801586:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	50                   	push   %eax
  801594:	6a 1a                	push   $0x1a
  801596:	e8 53 fd ff ff       	call   8012ee <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
}
  80159e:	90                   	nop
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	50                   	push   %eax
  8015b0:	6a 1b                	push   $0x1b
  8015b2:	e8 37 fd ff ff       	call   8012ee <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 05                	push   $0x5
  8015cb:	e8 1e fd ff ff       	call   8012ee <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 06                	push   $0x6
  8015e4:	e8 05 fd ff ff       	call   8012ee <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 07                	push   $0x7
  8015fd:	e8 ec fc ff ff       	call   8012ee <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <sys_exit_env>:


void sys_exit_env(void)
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 1c                	push   $0x1c
  801616:	e8 d3 fc ff ff       	call   8012ee <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	90                   	nop
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	ff 75 10             	pushl  0x10(%ebp)
  80162b:	ff 75 0c             	pushl  0xc(%ebp)
  80162e:	ff 75 08             	pushl  0x8(%ebp)
  801631:	6a 13                	push   $0x13
  801633:	e8 b6 fc ff ff       	call   8012ee <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
	return ;
  80163b:	90                   	nop
}
  80163c:	c9                   	leave  
  80163d:	c3                   	ret    

0080163e <sys_rcr2>:
uint32 sys_rcr2()
{
  80163e:	55                   	push   %ebp
  80163f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 1e                	push   $0x1e
  80164d:	e8 9c fc ff ff       	call   8012ee <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
  80165a:	83 ec 04             	sub    $0x4,%esp
  80165d:	8b 45 08             	mov    0x8(%ebp),%eax
  801660:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801663:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	50                   	push   %eax
  801670:	6a 1f                	push   $0x1f
  801672:	e8 77 fc ff ff       	call   8012ee <syscall>
  801677:	83 c4 18             	add    $0x18,%esp
	return ;
  80167a:	90                   	nop
}
  80167b:	c9                   	leave  
  80167c:	c3                   	ret    

0080167d <rsttst>:
void rsttst()
{
  80167d:	55                   	push   %ebp
  80167e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 21                	push   $0x21
  80168c:	e8 5d fc ff ff       	call   8012ee <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
	return ;
  801694:	90                   	nop
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
  80169a:	83 ec 04             	sub    $0x4,%esp
  80169d:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016a3:	8b 55 18             	mov    0x18(%ebp),%edx
  8016a6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016aa:	52                   	push   %edx
  8016ab:	50                   	push   %eax
  8016ac:	ff 75 10             	pushl  0x10(%ebp)
  8016af:	ff 75 0c             	pushl  0xc(%ebp)
  8016b2:	ff 75 08             	pushl  0x8(%ebp)
  8016b5:	6a 20                	push   $0x20
  8016b7:	e8 32 fc ff ff       	call   8012ee <syscall>
  8016bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016bf:	90                   	nop
}
  8016c0:	c9                   	leave  
  8016c1:	c3                   	ret    

008016c2 <chktst>:
void chktst(uint32 n)
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	ff 75 08             	pushl  0x8(%ebp)
  8016d0:	6a 22                	push   $0x22
  8016d2:	e8 17 fc ff ff       	call   8012ee <syscall>
  8016d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8016da:	90                   	nop
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <inctst>:

void inctst()
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 23                	push   $0x23
  8016ec:	e8 fd fb ff ff       	call   8012ee <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f4:	90                   	nop
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <gettst>:
uint32 gettst()
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 24                	push   $0x24
  801706:	e8 e3 fb ff ff       	call   8012ee <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 25                	push   $0x25
  80171f:	e8 ca fb ff ff       	call   8012ee <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
  801727:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  80172c:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	ff 75 08             	pushl  0x8(%ebp)
  801749:	6a 26                	push   $0x26
  80174b:	e8 9e fb ff ff       	call   8012ee <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
	return ;
  801753:	90                   	nop
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
  801759:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80175a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80175d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801760:	8b 55 0c             	mov    0xc(%ebp),%edx
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	6a 00                	push   $0x0
  801768:	53                   	push   %ebx
  801769:	51                   	push   %ecx
  80176a:	52                   	push   %edx
  80176b:	50                   	push   %eax
  80176c:	6a 27                	push   $0x27
  80176e:	e8 7b fb ff ff       	call   8012ee <syscall>
  801773:	83 c4 18             	add    $0x18,%esp
}
  801776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80177e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	52                   	push   %edx
  80178b:	50                   	push   %eax
  80178c:	6a 28                	push   $0x28
  80178e:	e8 5b fb ff ff       	call   8012ee <syscall>
  801793:	83 c4 18             	add    $0x18,%esp
}
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80179b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80179e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a4:	6a 00                	push   $0x0
  8017a6:	51                   	push   %ecx
  8017a7:	ff 75 10             	pushl  0x10(%ebp)
  8017aa:	52                   	push   %edx
  8017ab:	50                   	push   %eax
  8017ac:	6a 29                	push   $0x29
  8017ae:	e8 3b fb ff ff       	call   8012ee <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	ff 75 10             	pushl  0x10(%ebp)
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	6a 12                	push   $0x12
  8017ca:	e8 1f fb ff ff       	call   8012ee <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d2:	90                   	nop
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	52                   	push   %edx
  8017e5:	50                   	push   %eax
  8017e6:	6a 2a                	push   $0x2a
  8017e8:	e8 01 fb ff ff       	call   8012ee <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
	return;
  8017f0:	90                   	nop
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 2b                	push   $0x2b
  801802:	e8 e7 fa ff ff       	call   8012ee <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801812:	83 ec 04             	sub    $0x4,%esp
  801815:	68 88 22 80 00       	push   $0x802288
  80181a:	68 0a 01 00 00       	push   $0x10a
  80181f:	68 98 22 80 00       	push   $0x802298
  801824:	e8 38 00 00 00       	call   801861 <_panic>

00801829 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	ff 75 0c             	pushl  0xc(%ebp)
  801835:	ff 75 08             	pushl  0x8(%ebp)
  801838:	6a 33                	push   $0x33
  80183a:	e8 af fa ff ff       	call   8012ee <syscall>
  80183f:	83 c4 18             	add    $0x18,%esp
	return;
  801842:	90                   	nop
}
  801843:	c9                   	leave  
  801844:	c3                   	ret    

00801845 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801845:	55                   	push   %ebp
  801846:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	ff 75 0c             	pushl  0xc(%ebp)
  801851:	ff 75 08             	pushl  0x8(%ebp)
  801854:	6a 34                	push   $0x34
  801856:	e8 93 fa ff ff       	call   8012ee <syscall>
  80185b:	83 c4 18             	add    $0x18,%esp
	return ;
  80185e:	90                   	nop
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
  801864:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801867:	8d 45 10             	lea    0x10(%ebp),%eax
  80186a:	83 c0 04             	add    $0x4,%eax
  80186d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801870:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801875:	85 c0                	test   %eax,%eax
  801877:	74 16                	je     80188f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801879:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80187e:	83 ec 08             	sub    $0x8,%esp
  801881:	50                   	push   %eax
  801882:	68 a8 22 80 00       	push   $0x8022a8
  801887:	e8 7d eb ff ff       	call   800409 <cprintf>
  80188c:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80188f:	a1 04 30 80 00       	mov    0x803004,%eax
  801894:	83 ec 0c             	sub    $0xc,%esp
  801897:	ff 75 0c             	pushl  0xc(%ebp)
  80189a:	ff 75 08             	pushl  0x8(%ebp)
  80189d:	50                   	push   %eax
  80189e:	68 b0 22 80 00       	push   $0x8022b0
  8018a3:	6a 74                	push   $0x74
  8018a5:	e8 8c eb ff ff       	call   800436 <cprintf_colored>
  8018aa:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8018ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b0:	83 ec 08             	sub    $0x8,%esp
  8018b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8018b6:	50                   	push   %eax
  8018b7:	e8 de ea ff ff       	call   80039a <vcprintf>
  8018bc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018bf:	83 ec 08             	sub    $0x8,%esp
  8018c2:	6a 00                	push   $0x0
  8018c4:	68 d8 22 80 00       	push   $0x8022d8
  8018c9:	e8 cc ea ff ff       	call   80039a <vcprintf>
  8018ce:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018d1:	e8 45 ea ff ff       	call   80031b <exit>

	// should not return here
	while (1) ;
  8018d6:	eb fe                	jmp    8018d6 <_panic+0x75>

008018d8 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
  8018db:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018de:	a1 20 30 80 00       	mov    0x803020,%eax
  8018e3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8018e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ec:	39 c2                	cmp    %eax,%edx
  8018ee:	74 14                	je     801904 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018f0:	83 ec 04             	sub    $0x4,%esp
  8018f3:	68 dc 22 80 00       	push   $0x8022dc
  8018f8:	6a 26                	push   $0x26
  8018fa:	68 28 23 80 00       	push   $0x802328
  8018ff:	e8 5d ff ff ff       	call   801861 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801904:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80190b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801912:	e9 c5 00 00 00       	jmp    8019dc <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801917:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	01 d0                	add    %edx,%eax
  801926:	8b 00                	mov    (%eax),%eax
  801928:	85 c0                	test   %eax,%eax
  80192a:	75 08                	jne    801934 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80192c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80192f:	e9 a5 00 00 00       	jmp    8019d9 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801934:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80193b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801942:	eb 69                	jmp    8019ad <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801944:	a1 20 30 80 00       	mov    0x803020,%eax
  801949:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80194f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801952:	89 d0                	mov    %edx,%eax
  801954:	01 c0                	add    %eax,%eax
  801956:	01 d0                	add    %edx,%eax
  801958:	c1 e0 03             	shl    $0x3,%eax
  80195b:	01 c8                	add    %ecx,%eax
  80195d:	8a 40 04             	mov    0x4(%eax),%al
  801960:	84 c0                	test   %al,%al
  801962:	75 46                	jne    8019aa <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801964:	a1 20 30 80 00       	mov    0x803020,%eax
  801969:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80196f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801972:	89 d0                	mov    %edx,%eax
  801974:	01 c0                	add    %eax,%eax
  801976:	01 d0                	add    %edx,%eax
  801978:	c1 e0 03             	shl    $0x3,%eax
  80197b:	01 c8                	add    %ecx,%eax
  80197d:	8b 00                	mov    (%eax),%eax
  80197f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801982:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801985:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80198a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80198c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80198f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	01 c8                	add    %ecx,%eax
  80199b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80199d:	39 c2                	cmp    %eax,%edx
  80199f:	75 09                	jne    8019aa <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8019a1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019a8:	eb 15                	jmp    8019bf <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019aa:	ff 45 e8             	incl   -0x18(%ebp)
  8019ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8019b2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019bb:	39 c2                	cmp    %eax,%edx
  8019bd:	77 85                	ja     801944 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019c3:	75 14                	jne    8019d9 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8019c5:	83 ec 04             	sub    $0x4,%esp
  8019c8:	68 34 23 80 00       	push   $0x802334
  8019cd:	6a 3a                	push   $0x3a
  8019cf:	68 28 23 80 00       	push   $0x802328
  8019d4:	e8 88 fe ff ff       	call   801861 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019d9:	ff 45 f0             	incl   -0x10(%ebp)
  8019dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019df:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019e2:	0f 8c 2f ff ff ff    	jl     801917 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019f6:	eb 26                	jmp    801a1e <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8019fd:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801a03:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a06:	89 d0                	mov    %edx,%eax
  801a08:	01 c0                	add    %eax,%eax
  801a0a:	01 d0                	add    %edx,%eax
  801a0c:	c1 e0 03             	shl    $0x3,%eax
  801a0f:	01 c8                	add    %ecx,%eax
  801a11:	8a 40 04             	mov    0x4(%eax),%al
  801a14:	3c 01                	cmp    $0x1,%al
  801a16:	75 03                	jne    801a1b <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801a18:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a1b:	ff 45 e0             	incl   -0x20(%ebp)
  801a1e:	a1 20 30 80 00       	mov    0x803020,%eax
  801a23:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a29:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a2c:	39 c2                	cmp    %eax,%edx
  801a2e:	77 c8                	ja     8019f8 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a33:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a36:	74 14                	je     801a4c <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a38:	83 ec 04             	sub    $0x4,%esp
  801a3b:	68 88 23 80 00       	push   $0x802388
  801a40:	6a 44                	push   $0x44
  801a42:	68 28 23 80 00       	push   $0x802328
  801a47:	e8 15 fe ff ff       	call   801861 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a4c:	90                   	nop
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    
  801a4f:	90                   	nop

00801a50 <__udivdi3>:
  801a50:	55                   	push   %ebp
  801a51:	57                   	push   %edi
  801a52:	56                   	push   %esi
  801a53:	53                   	push   %ebx
  801a54:	83 ec 1c             	sub    $0x1c,%esp
  801a57:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a63:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a67:	89 ca                	mov    %ecx,%edx
  801a69:	89 f8                	mov    %edi,%eax
  801a6b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a6f:	85 f6                	test   %esi,%esi
  801a71:	75 2d                	jne    801aa0 <__udivdi3+0x50>
  801a73:	39 cf                	cmp    %ecx,%edi
  801a75:	77 65                	ja     801adc <__udivdi3+0x8c>
  801a77:	89 fd                	mov    %edi,%ebp
  801a79:	85 ff                	test   %edi,%edi
  801a7b:	75 0b                	jne    801a88 <__udivdi3+0x38>
  801a7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a82:	31 d2                	xor    %edx,%edx
  801a84:	f7 f7                	div    %edi
  801a86:	89 c5                	mov    %eax,%ebp
  801a88:	31 d2                	xor    %edx,%edx
  801a8a:	89 c8                	mov    %ecx,%eax
  801a8c:	f7 f5                	div    %ebp
  801a8e:	89 c1                	mov    %eax,%ecx
  801a90:	89 d8                	mov    %ebx,%eax
  801a92:	f7 f5                	div    %ebp
  801a94:	89 cf                	mov    %ecx,%edi
  801a96:	89 fa                	mov    %edi,%edx
  801a98:	83 c4 1c             	add    $0x1c,%esp
  801a9b:	5b                   	pop    %ebx
  801a9c:	5e                   	pop    %esi
  801a9d:	5f                   	pop    %edi
  801a9e:	5d                   	pop    %ebp
  801a9f:	c3                   	ret    
  801aa0:	39 ce                	cmp    %ecx,%esi
  801aa2:	77 28                	ja     801acc <__udivdi3+0x7c>
  801aa4:	0f bd fe             	bsr    %esi,%edi
  801aa7:	83 f7 1f             	xor    $0x1f,%edi
  801aaa:	75 40                	jne    801aec <__udivdi3+0x9c>
  801aac:	39 ce                	cmp    %ecx,%esi
  801aae:	72 0a                	jb     801aba <__udivdi3+0x6a>
  801ab0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab4:	0f 87 9e 00 00 00    	ja     801b58 <__udivdi3+0x108>
  801aba:	b8 01 00 00 00       	mov    $0x1,%eax
  801abf:	89 fa                	mov    %edi,%edx
  801ac1:	83 c4 1c             	add    $0x1c,%esp
  801ac4:	5b                   	pop    %ebx
  801ac5:	5e                   	pop    %esi
  801ac6:	5f                   	pop    %edi
  801ac7:	5d                   	pop    %ebp
  801ac8:	c3                   	ret    
  801ac9:	8d 76 00             	lea    0x0(%esi),%esi
  801acc:	31 ff                	xor    %edi,%edi
  801ace:	31 c0                	xor    %eax,%eax
  801ad0:	89 fa                	mov    %edi,%edx
  801ad2:	83 c4 1c             	add    $0x1c,%esp
  801ad5:	5b                   	pop    %ebx
  801ad6:	5e                   	pop    %esi
  801ad7:	5f                   	pop    %edi
  801ad8:	5d                   	pop    %ebp
  801ad9:	c3                   	ret    
  801ada:	66 90                	xchg   %ax,%ax
  801adc:	89 d8                	mov    %ebx,%eax
  801ade:	f7 f7                	div    %edi
  801ae0:	31 ff                	xor    %edi,%edi
  801ae2:	89 fa                	mov    %edi,%edx
  801ae4:	83 c4 1c             	add    $0x1c,%esp
  801ae7:	5b                   	pop    %ebx
  801ae8:	5e                   	pop    %esi
  801ae9:	5f                   	pop    %edi
  801aea:	5d                   	pop    %ebp
  801aeb:	c3                   	ret    
  801aec:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af1:	89 eb                	mov    %ebp,%ebx
  801af3:	29 fb                	sub    %edi,%ebx
  801af5:	89 f9                	mov    %edi,%ecx
  801af7:	d3 e6                	shl    %cl,%esi
  801af9:	89 c5                	mov    %eax,%ebp
  801afb:	88 d9                	mov    %bl,%cl
  801afd:	d3 ed                	shr    %cl,%ebp
  801aff:	89 e9                	mov    %ebp,%ecx
  801b01:	09 f1                	or     %esi,%ecx
  801b03:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b07:	89 f9                	mov    %edi,%ecx
  801b09:	d3 e0                	shl    %cl,%eax
  801b0b:	89 c5                	mov    %eax,%ebp
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	88 d9                	mov    %bl,%cl
  801b11:	d3 ee                	shr    %cl,%esi
  801b13:	89 f9                	mov    %edi,%ecx
  801b15:	d3 e2                	shl    %cl,%edx
  801b17:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1b:	88 d9                	mov    %bl,%cl
  801b1d:	d3 e8                	shr    %cl,%eax
  801b1f:	09 c2                	or     %eax,%edx
  801b21:	89 d0                	mov    %edx,%eax
  801b23:	89 f2                	mov    %esi,%edx
  801b25:	f7 74 24 0c          	divl   0xc(%esp)
  801b29:	89 d6                	mov    %edx,%esi
  801b2b:	89 c3                	mov    %eax,%ebx
  801b2d:	f7 e5                	mul    %ebp
  801b2f:	39 d6                	cmp    %edx,%esi
  801b31:	72 19                	jb     801b4c <__udivdi3+0xfc>
  801b33:	74 0b                	je     801b40 <__udivdi3+0xf0>
  801b35:	89 d8                	mov    %ebx,%eax
  801b37:	31 ff                	xor    %edi,%edi
  801b39:	e9 58 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b3e:	66 90                	xchg   %ax,%ax
  801b40:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b44:	89 f9                	mov    %edi,%ecx
  801b46:	d3 e2                	shl    %cl,%edx
  801b48:	39 c2                	cmp    %eax,%edx
  801b4a:	73 e9                	jae    801b35 <__udivdi3+0xe5>
  801b4c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b4f:	31 ff                	xor    %edi,%edi
  801b51:	e9 40 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b56:	66 90                	xchg   %ax,%ax
  801b58:	31 c0                	xor    %eax,%eax
  801b5a:	e9 37 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b5f:	90                   	nop

00801b60 <__umoddi3>:
  801b60:	55                   	push   %ebp
  801b61:	57                   	push   %edi
  801b62:	56                   	push   %esi
  801b63:	53                   	push   %ebx
  801b64:	83 ec 1c             	sub    $0x1c,%esp
  801b67:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b73:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b77:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b7f:	89 f3                	mov    %esi,%ebx
  801b81:	89 fa                	mov    %edi,%edx
  801b83:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b87:	89 34 24             	mov    %esi,(%esp)
  801b8a:	85 c0                	test   %eax,%eax
  801b8c:	75 1a                	jne    801ba8 <__umoddi3+0x48>
  801b8e:	39 f7                	cmp    %esi,%edi
  801b90:	0f 86 a2 00 00 00    	jbe    801c38 <__umoddi3+0xd8>
  801b96:	89 c8                	mov    %ecx,%eax
  801b98:	89 f2                	mov    %esi,%edx
  801b9a:	f7 f7                	div    %edi
  801b9c:	89 d0                	mov    %edx,%eax
  801b9e:	31 d2                	xor    %edx,%edx
  801ba0:	83 c4 1c             	add    $0x1c,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    
  801ba8:	39 f0                	cmp    %esi,%eax
  801baa:	0f 87 ac 00 00 00    	ja     801c5c <__umoddi3+0xfc>
  801bb0:	0f bd e8             	bsr    %eax,%ebp
  801bb3:	83 f5 1f             	xor    $0x1f,%ebp
  801bb6:	0f 84 ac 00 00 00    	je     801c68 <__umoddi3+0x108>
  801bbc:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc1:	29 ef                	sub    %ebp,%edi
  801bc3:	89 fe                	mov    %edi,%esi
  801bc5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bc9:	89 e9                	mov    %ebp,%ecx
  801bcb:	d3 e0                	shl    %cl,%eax
  801bcd:	89 d7                	mov    %edx,%edi
  801bcf:	89 f1                	mov    %esi,%ecx
  801bd1:	d3 ef                	shr    %cl,%edi
  801bd3:	09 c7                	or     %eax,%edi
  801bd5:	89 e9                	mov    %ebp,%ecx
  801bd7:	d3 e2                	shl    %cl,%edx
  801bd9:	89 14 24             	mov    %edx,(%esp)
  801bdc:	89 d8                	mov    %ebx,%eax
  801bde:	d3 e0                	shl    %cl,%eax
  801be0:	89 c2                	mov    %eax,%edx
  801be2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801be6:	d3 e0                	shl    %cl,%eax
  801be8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bec:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf0:	89 f1                	mov    %esi,%ecx
  801bf2:	d3 e8                	shr    %cl,%eax
  801bf4:	09 d0                	or     %edx,%eax
  801bf6:	d3 eb                	shr    %cl,%ebx
  801bf8:	89 da                	mov    %ebx,%edx
  801bfa:	f7 f7                	div    %edi
  801bfc:	89 d3                	mov    %edx,%ebx
  801bfe:	f7 24 24             	mull   (%esp)
  801c01:	89 c6                	mov    %eax,%esi
  801c03:	89 d1                	mov    %edx,%ecx
  801c05:	39 d3                	cmp    %edx,%ebx
  801c07:	0f 82 87 00 00 00    	jb     801c94 <__umoddi3+0x134>
  801c0d:	0f 84 91 00 00 00    	je     801ca4 <__umoddi3+0x144>
  801c13:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c17:	29 f2                	sub    %esi,%edx
  801c19:	19 cb                	sbb    %ecx,%ebx
  801c1b:	89 d8                	mov    %ebx,%eax
  801c1d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c21:	d3 e0                	shl    %cl,%eax
  801c23:	89 e9                	mov    %ebp,%ecx
  801c25:	d3 ea                	shr    %cl,%edx
  801c27:	09 d0                	or     %edx,%eax
  801c29:	89 e9                	mov    %ebp,%ecx
  801c2b:	d3 eb                	shr    %cl,%ebx
  801c2d:	89 da                	mov    %ebx,%edx
  801c2f:	83 c4 1c             	add    $0x1c,%esp
  801c32:	5b                   	pop    %ebx
  801c33:	5e                   	pop    %esi
  801c34:	5f                   	pop    %edi
  801c35:	5d                   	pop    %ebp
  801c36:	c3                   	ret    
  801c37:	90                   	nop
  801c38:	89 fd                	mov    %edi,%ebp
  801c3a:	85 ff                	test   %edi,%edi
  801c3c:	75 0b                	jne    801c49 <__umoddi3+0xe9>
  801c3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c43:	31 d2                	xor    %edx,%edx
  801c45:	f7 f7                	div    %edi
  801c47:	89 c5                	mov    %eax,%ebp
  801c49:	89 f0                	mov    %esi,%eax
  801c4b:	31 d2                	xor    %edx,%edx
  801c4d:	f7 f5                	div    %ebp
  801c4f:	89 c8                	mov    %ecx,%eax
  801c51:	f7 f5                	div    %ebp
  801c53:	89 d0                	mov    %edx,%eax
  801c55:	e9 44 ff ff ff       	jmp    801b9e <__umoddi3+0x3e>
  801c5a:	66 90                	xchg   %ax,%ax
  801c5c:	89 c8                	mov    %ecx,%eax
  801c5e:	89 f2                	mov    %esi,%edx
  801c60:	83 c4 1c             	add    $0x1c,%esp
  801c63:	5b                   	pop    %ebx
  801c64:	5e                   	pop    %esi
  801c65:	5f                   	pop    %edi
  801c66:	5d                   	pop    %ebp
  801c67:	c3                   	ret    
  801c68:	3b 04 24             	cmp    (%esp),%eax
  801c6b:	72 06                	jb     801c73 <__umoddi3+0x113>
  801c6d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c71:	77 0f                	ja     801c82 <__umoddi3+0x122>
  801c73:	89 f2                	mov    %esi,%edx
  801c75:	29 f9                	sub    %edi,%ecx
  801c77:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7b:	89 14 24             	mov    %edx,(%esp)
  801c7e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c82:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c86:	8b 14 24             	mov    (%esp),%edx
  801c89:	83 c4 1c             	add    $0x1c,%esp
  801c8c:	5b                   	pop    %ebx
  801c8d:	5e                   	pop    %esi
  801c8e:	5f                   	pop    %edi
  801c8f:	5d                   	pop    %ebp
  801c90:	c3                   	ret    
  801c91:	8d 76 00             	lea    0x0(%esi),%esi
  801c94:	2b 04 24             	sub    (%esp),%eax
  801c97:	19 fa                	sbb    %edi,%edx
  801c99:	89 d1                	mov    %edx,%ecx
  801c9b:	89 c6                	mov    %eax,%esi
  801c9d:	e9 71 ff ff ff       	jmp    801c13 <__umoddi3+0xb3>
  801ca2:	66 90                	xchg   %ax,%ax
  801ca4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ca8:	72 ea                	jb     801c94 <__umoddi3+0x134>
  801caa:	89 d9                	mov    %ebx,%ecx
  801cac:	e9 62 ff ff ff       	jmp    801c13 <__umoddi3+0xb3>
