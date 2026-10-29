
obj/user/fos_factorial:     file format elf32-i386


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
  800031:	e8 be 00 00 00       	call   8000f4 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int64 factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter a number:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 40 1f 80 00       	push   $0x801f40
  800057:	e8 b0 0b 00 00       	call   800c0c <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 b2 10 00 00       	call   801124 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int64 res = factorial(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 22 00 00 00       	call   8000a5 <factorial>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800089:	89 55 ec             	mov    %edx,-0x14(%ebp)

	atomic_cprintf("Factorial %d = %lld\n",i1, res);
  80008c:	ff 75 ec             	pushl  -0x14(%ebp)
  80008f:	ff 75 e8             	pushl  -0x18(%ebp)
  800092:	ff 75 f4             	pushl  -0xc(%ebp)
  800095:	68 57 1f 80 00       	push   $0x801f57
  80009a:	e8 07 04 00 00       	call   8004a6 <atomic_cprintf>
  80009f:	83 c4 10             	add    $0x10,%esp
	return;
  8000a2:	90                   	nop
}
  8000a3:	c9                   	leave  
  8000a4:	c3                   	ret    

008000a5 <factorial>:


int64 factorial(int n)
{
  8000a5:	55                   	push   %ebp
  8000a6:	89 e5                	mov    %esp,%ebp
  8000a8:	57                   	push   %edi
  8000a9:	56                   	push   %esi
  8000aa:	53                   	push   %ebx
  8000ab:	83 ec 0c             	sub    $0xc,%esp
	if (n <= 1)
  8000ae:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000b2:	7f 0c                	jg     8000c0 <factorial+0x1b>
		return 1 ;
  8000b4:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8000be:	eb 2c                	jmp    8000ec <factorial+0x47>
	return n * factorial(n-1) ;
  8000c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8000c3:	89 c3                	mov    %eax,%ebx
  8000c5:	89 c6                	mov    %eax,%esi
  8000c7:	c1 fe 1f             	sar    $0x1f,%esi
  8000ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cd:	48                   	dec    %eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 ce ff ff ff       	call   8000a5 <factorial>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	89 f7                	mov    %esi,%edi
  8000dc:	0f af f8             	imul   %eax,%edi
  8000df:	89 d1                	mov    %edx,%ecx
  8000e1:	0f af cb             	imul   %ebx,%ecx
  8000e4:	01 f9                	add    %edi,%ecx
  8000e6:	f7 e3                	mul    %ebx
  8000e8:	01 d1                	add    %edx,%ecx
  8000ea:	89 ca                	mov    %ecx,%edx
}
  8000ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8000ef:	5b                   	pop    %ebx
  8000f0:	5e                   	pop    %esi
  8000f1:	5f                   	pop    %edi
  8000f2:	5d                   	pop    %ebp
  8000f3:	c3                   	ret    

008000f4 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000f4:	55                   	push   %ebp
  8000f5:	89 e5                	mov    %esp,%ebp
  8000f7:	57                   	push   %edi
  8000f8:	56                   	push   %esi
  8000f9:	53                   	push   %ebx
  8000fa:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800100:	e8 03 17 00 00       	call   801808 <sys_getenvindex>
  800105:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800108:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80010b:	89 d0                	mov    %edx,%eax
  80010d:	c1 e0 03             	shl    $0x3,%eax
  800110:	01 d0                	add    %edx,%eax
  800112:	c1 e0 06             	shl    $0x6,%eax
  800115:	01 d0                	add    %edx,%eax
  800117:	c1 e0 03             	shl    $0x3,%eax
  80011a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80011f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800124:	a1 20 30 80 00       	mov    0x803020,%eax
  800129:	8a 40 10             	mov    0x10(%eax),%al
  80012c:	84 c0                	test   %al,%al
  80012e:	74 0d                	je     80013d <libmain+0x49>
		binaryname = myEnv->prog_name;
  800130:	a1 20 30 80 00       	mov    0x803020,%eax
  800135:	83 c0 10             	add    $0x10,%eax
  800138:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80013d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800141:	7e 0a                	jle    80014d <libmain+0x59>
		binaryname = argv[0];
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8b 00                	mov    (%eax),%eax
  800148:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80014d:	83 ec 08             	sub    $0x8,%esp
  800150:	ff 75 0c             	pushl  0xc(%ebp)
  800153:	ff 75 08             	pushl  0x8(%ebp)
  800156:	e8 dd fe ff ff       	call   800038 <_main>
  80015b:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80015e:	a1 00 30 80 00       	mov    0x803000,%eax
  800163:	85 c0                	test   %eax,%eax
  800165:	0f 84 b7 01 00 00    	je     800322 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80016b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800171:	bb a8 20 80 00       	mov    $0x8020a8,%ebx
  800176:	ba 0e 00 00 00       	mov    $0xe,%edx
  80017b:	89 c7                	mov    %eax,%edi
  80017d:	89 de                	mov    %ebx,%esi
  80017f:	89 d1                	mov    %edx,%ecx
  800181:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800183:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800189:	b9 56 00 00 00       	mov    $0x56,%ecx
  80018e:	b0 00                	mov    $0x0,%al
  800190:	89 d7                	mov    %edx,%edi
  800192:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800194:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80019b:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	50                   	push   %eax
  8001a2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001a8:	50                   	push   %eax
  8001a9:	e8 5a 18 00 00       	call   801a08 <sys_utilities>
  8001ae:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001b1:	e8 da 13 00 00       	call   801590 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001b6:	83 ec 0c             	sub    $0xc,%esp
  8001b9:	68 84 1f 80 00       	push   $0x801f84
  8001be:	e8 71 02 00 00       	call   800434 <cprintf>
  8001c3:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001c6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001c9:	85 c0                	test   %eax,%eax
  8001cb:	74 58                	je     800225 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001cd:	e8 54 18 00 00       	call   801a26 <sys_get_optimal_num_faults>
  8001d2:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001d5:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001db:	bb 0c 21 80 00       	mov    $0x80210c,%ebx
  8001e0:	ba 11 00 00 00       	mov    $0x11,%edx
  8001e5:	89 c7                	mov    %eax,%edi
  8001e7:	89 de                	mov    %ebx,%esi
  8001e9:	89 d1                	mov    %edx,%ecx
  8001eb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001ed:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001f0:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001f5:	b0 00                	mov    $0x0,%al
  8001f7:	89 d7                	mov    %edx,%edi
  8001f9:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001fb:	83 ec 08             	sub    $0x8,%esp
  8001fe:	ff 75 dc             	pushl  -0x24(%ebp)
  800201:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800207:	50                   	push   %eax
  800208:	e8 fb 17 00 00       	call   801a08 <sys_utilities>
  80020d:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	ff 75 dc             	pushl  -0x24(%ebp)
  800216:	68 ac 1f 80 00       	push   $0x801fac
  80021b:	e8 14 02 00 00       	call   800434 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
  800223:	eb 59                	jmp    80027e <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800230:	a1 20 30 80 00       	mov    0x803020,%eax
  800235:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80023b:	83 ec 04             	sub    $0x4,%esp
  80023e:	52                   	push   %edx
  80023f:	50                   	push   %eax
  800240:	68 d0 1f 80 00       	push   $0x801fd0
  800245:	e8 ea 01 00 00       	call   800434 <cprintf>
  80024a:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80024d:	a1 20 30 80 00       	mov    0x803020,%eax
  800252:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800263:	a1 20 30 80 00       	mov    0x803020,%eax
  800268:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80026e:	51                   	push   %ecx
  80026f:	52                   	push   %edx
  800270:	50                   	push   %eax
  800271:	68 f8 1f 80 00       	push   $0x801ff8
  800276:	e8 b9 01 00 00       	call   800434 <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80027e:	a1 20 30 80 00       	mov    0x803020,%eax
  800283:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800289:	83 ec 08             	sub    $0x8,%esp
  80028c:	50                   	push   %eax
  80028d:	68 50 20 80 00       	push   $0x802050
  800292:	e8 9d 01 00 00       	call   800434 <cprintf>
  800297:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	68 64 20 80 00       	push   $0x802064
  8002a2:	e8 8d 01 00 00       	call   800434 <cprintf>
  8002a7:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002b1:	eb 28                	jmp    8002db <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002bb:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002c1:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002c4:	83 ec 04             	sub    $0x4,%esp
  8002c7:	50                   	push   %eax
  8002c8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002cb:	68 7b 20 80 00       	push   $0x80207b
  8002d0:	e8 5f 01 00 00       	call   800434 <cprintf>
  8002d5:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002d8:	ff 45 e4             	incl   -0x1c(%ebp)
  8002db:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002df:	7e d2                	jle    8002b3 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002e1:	83 ec 0c             	sub    $0xc,%esp
  8002e4:	68 8a 20 80 00       	push   $0x80208a
  8002e9:	e8 46 01 00 00       	call   800434 <cprintf>
  8002ee:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f6:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002fc:	83 ec 08             	sub    $0x8,%esp
  8002ff:	50                   	push   %eax
  800300:	68 8e 20 80 00       	push   $0x80208e
  800305:	e8 2a 01 00 00       	call   800434 <cprintf>
  80030a:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80030d:	83 ec 0c             	sub    $0xc,%esp
  800310:	68 84 1f 80 00       	push   $0x801f84
  800315:	e8 1a 01 00 00       	call   800434 <cprintf>
  80031a:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80031d:	e8 88 12 00 00       	call   8015aa <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800322:	e8 1f 00 00 00       	call   800346 <exit>
}
  800327:	90                   	nop
  800328:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80032b:	5b                   	pop    %ebx
  80032c:	5e                   	pop    %esi
  80032d:	5f                   	pop    %edi
  80032e:	5d                   	pop    %ebp
  80032f:	c3                   	ret    

00800330 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800330:	55                   	push   %ebp
  800331:	89 e5                	mov    %esp,%ebp
  800333:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800336:	83 ec 0c             	sub    $0xc,%esp
  800339:	6a 00                	push   $0x0
  80033b:	e8 94 14 00 00       	call   8017d4 <sys_destroy_env>
  800340:	83 c4 10             	add    $0x10,%esp
}
  800343:	90                   	nop
  800344:	c9                   	leave  
  800345:	c3                   	ret    

00800346 <exit>:

void
exit(void)
{
  800346:	55                   	push   %ebp
  800347:	89 e5                	mov    %esp,%ebp
  800349:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80034c:	e8 e9 14 00 00       	call   80183a <sys_exit_env>
}
  800351:	90                   	nop
  800352:	c9                   	leave  
  800353:	c3                   	ret    

00800354 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800354:	55                   	push   %ebp
  800355:	89 e5                	mov    %esp,%ebp
  800357:	53                   	push   %ebx
  800358:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80035b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035e:	8b 00                	mov    (%eax),%eax
  800360:	8d 48 01             	lea    0x1(%eax),%ecx
  800363:	8b 55 0c             	mov    0xc(%ebp),%edx
  800366:	89 0a                	mov    %ecx,(%edx)
  800368:	8b 55 08             	mov    0x8(%ebp),%edx
  80036b:	88 d1                	mov    %dl,%cl
  80036d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800370:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800374:	8b 45 0c             	mov    0xc(%ebp),%eax
  800377:	8b 00                	mov    (%eax),%eax
  800379:	3d ff 00 00 00       	cmp    $0xff,%eax
  80037e:	75 30                	jne    8003b0 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800380:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800386:	a0 40 30 80 00       	mov    0x803040,%al
  80038b:	0f b6 c0             	movzbl %al,%eax
  80038e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800391:	8b 09                	mov    (%ecx),%ecx
  800393:	89 cb                	mov    %ecx,%ebx
  800395:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800398:	83 c1 08             	add    $0x8,%ecx
  80039b:	52                   	push   %edx
  80039c:	50                   	push   %eax
  80039d:	53                   	push   %ebx
  80039e:	51                   	push   %ecx
  80039f:	e8 a8 11 00 00       	call   80154c <sys_cputs>
  8003a4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b3:	8b 40 04             	mov    0x4(%eax),%eax
  8003b6:	8d 50 01             	lea    0x1(%eax),%edx
  8003b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003bc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003bf:	90                   	nop
  8003c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003ce:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003d5:	00 00 00 
	b.cnt = 0;
  8003d8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003df:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003e2:	ff 75 0c             	pushl  0xc(%ebp)
  8003e5:	ff 75 08             	pushl  0x8(%ebp)
  8003e8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003ee:	50                   	push   %eax
  8003ef:	68 54 03 80 00       	push   $0x800354
  8003f4:	e8 5a 02 00 00       	call   800653 <vprintfmt>
  8003f9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003fc:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800402:	a0 40 30 80 00       	mov    0x803040,%al
  800407:	0f b6 c0             	movzbl %al,%eax
  80040a:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800410:	52                   	push   %edx
  800411:	50                   	push   %eax
  800412:	51                   	push   %ecx
  800413:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800419:	83 c0 08             	add    $0x8,%eax
  80041c:	50                   	push   %eax
  80041d:	e8 2a 11 00 00       	call   80154c <sys_cputs>
  800422:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800425:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  80042c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800432:	c9                   	leave  
  800433:	c3                   	ret    

00800434 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800434:	55                   	push   %ebp
  800435:	89 e5                	mov    %esp,%ebp
  800437:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80043a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800441:	8d 45 0c             	lea    0xc(%ebp),%eax
  800444:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	83 ec 08             	sub    $0x8,%esp
  80044d:	ff 75 f4             	pushl  -0xc(%ebp)
  800450:	50                   	push   %eax
  800451:	e8 6f ff ff ff       	call   8003c5 <vcprintf>
  800456:	83 c4 10             	add    $0x10,%esp
  800459:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80045c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80045f:	c9                   	leave  
  800460:	c3                   	ret    

00800461 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800461:	55                   	push   %ebp
  800462:	89 e5                	mov    %esp,%ebp
  800464:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800467:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	c1 e0 08             	shl    $0x8,%eax
  800474:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800479:	8d 45 0c             	lea    0xc(%ebp),%eax
  80047c:	83 c0 04             	add    $0x4,%eax
  80047f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800482:	8b 45 0c             	mov    0xc(%ebp),%eax
  800485:	83 ec 08             	sub    $0x8,%esp
  800488:	ff 75 f4             	pushl  -0xc(%ebp)
  80048b:	50                   	push   %eax
  80048c:	e8 34 ff ff ff       	call   8003c5 <vcprintf>
  800491:	83 c4 10             	add    $0x10,%esp
  800494:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800497:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  80049e:	07 00 00 

	return cnt;
  8004a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8004ac:	e8 df 10 00 00       	call   801590 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8004b1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8004b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ba:	83 ec 08             	sub    $0x8,%esp
  8004bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c0:	50                   	push   %eax
  8004c1:	e8 ff fe ff ff       	call   8003c5 <vcprintf>
  8004c6:	83 c4 10             	add    $0x10,%esp
  8004c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004cc:	e8 d9 10 00 00       	call   8015aa <sys_unlock_cons>
	return cnt;
  8004d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004d4:	c9                   	leave  
  8004d5:	c3                   	ret    

008004d6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004d6:	55                   	push   %ebp
  8004d7:	89 e5                	mov    %esp,%ebp
  8004d9:	53                   	push   %ebx
  8004da:	83 ec 14             	sub    $0x14,%esp
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004e9:	8b 45 18             	mov    0x18(%ebp),%eax
  8004ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8004f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004f4:	77 55                	ja     80054b <printnum+0x75>
  8004f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004f9:	72 05                	jb     800500 <printnum+0x2a>
  8004fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004fe:	77 4b                	ja     80054b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800500:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800503:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800506:	8b 45 18             	mov    0x18(%ebp),%eax
  800509:	ba 00 00 00 00       	mov    $0x0,%edx
  80050e:	52                   	push   %edx
  80050f:	50                   	push   %eax
  800510:	ff 75 f4             	pushl  -0xc(%ebp)
  800513:	ff 75 f0             	pushl  -0x10(%ebp)
  800516:	e8 a9 17 00 00       	call   801cc4 <__udivdi3>
  80051b:	83 c4 10             	add    $0x10,%esp
  80051e:	83 ec 04             	sub    $0x4,%esp
  800521:	ff 75 20             	pushl  0x20(%ebp)
  800524:	53                   	push   %ebx
  800525:	ff 75 18             	pushl  0x18(%ebp)
  800528:	52                   	push   %edx
  800529:	50                   	push   %eax
  80052a:	ff 75 0c             	pushl  0xc(%ebp)
  80052d:	ff 75 08             	pushl  0x8(%ebp)
  800530:	e8 a1 ff ff ff       	call   8004d6 <printnum>
  800535:	83 c4 20             	add    $0x20,%esp
  800538:	eb 1a                	jmp    800554 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80053a:	83 ec 08             	sub    $0x8,%esp
  80053d:	ff 75 0c             	pushl  0xc(%ebp)
  800540:	ff 75 20             	pushl  0x20(%ebp)
  800543:	8b 45 08             	mov    0x8(%ebp),%eax
  800546:	ff d0                	call   *%eax
  800548:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80054b:	ff 4d 1c             	decl   0x1c(%ebp)
  80054e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800552:	7f e6                	jg     80053a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800554:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800557:	bb 00 00 00 00       	mov    $0x0,%ebx
  80055c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80055f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800562:	53                   	push   %ebx
  800563:	51                   	push   %ecx
  800564:	52                   	push   %edx
  800565:	50                   	push   %eax
  800566:	e8 69 18 00 00       	call   801dd4 <__umoddi3>
  80056b:	83 c4 10             	add    $0x10,%esp
  80056e:	05 94 23 80 00       	add    $0x802394,%eax
  800573:	8a 00                	mov    (%eax),%al
  800575:	0f be c0             	movsbl %al,%eax
  800578:	83 ec 08             	sub    $0x8,%esp
  80057b:	ff 75 0c             	pushl  0xc(%ebp)
  80057e:	50                   	push   %eax
  80057f:	8b 45 08             	mov    0x8(%ebp),%eax
  800582:	ff d0                	call   *%eax
  800584:	83 c4 10             	add    $0x10,%esp
}
  800587:	90                   	nop
  800588:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80058b:	c9                   	leave  
  80058c:	c3                   	ret    

0080058d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800590:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800594:	7e 1c                	jle    8005b2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	8b 00                	mov    (%eax),%eax
  80059b:	8d 50 08             	lea    0x8(%eax),%edx
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	89 10                	mov    %edx,(%eax)
  8005a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	83 e8 08             	sub    $0x8,%eax
  8005ab:	8b 50 04             	mov    0x4(%eax),%edx
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	eb 40                	jmp    8005f2 <getuint+0x65>
	else if (lflag)
  8005b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005b6:	74 1e                	je     8005d6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	8d 50 04             	lea    0x4(%eax),%edx
  8005c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c3:	89 10                	mov    %edx,(%eax)
  8005c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	83 e8 04             	sub    $0x4,%eax
  8005cd:	8b 00                	mov    (%eax),%eax
  8005cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8005d4:	eb 1c                	jmp    8005f2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	8b 00                	mov    (%eax),%eax
  8005db:	8d 50 04             	lea    0x4(%eax),%edx
  8005de:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e1:	89 10                	mov    %edx,(%eax)
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	83 e8 04             	sub    $0x4,%eax
  8005eb:	8b 00                	mov    (%eax),%eax
  8005ed:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005f2:	5d                   	pop    %ebp
  8005f3:	c3                   	ret    

008005f4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005f4:	55                   	push   %ebp
  8005f5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005f7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005fb:	7e 1c                	jle    800619 <getint+0x25>
		return va_arg(*ap, long long);
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	8d 50 08             	lea    0x8(%eax),%edx
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	89 10                	mov    %edx,(%eax)
  80060a:	8b 45 08             	mov    0x8(%ebp),%eax
  80060d:	8b 00                	mov    (%eax),%eax
  80060f:	83 e8 08             	sub    $0x8,%eax
  800612:	8b 50 04             	mov    0x4(%eax),%edx
  800615:	8b 00                	mov    (%eax),%eax
  800617:	eb 38                	jmp    800651 <getint+0x5d>
	else if (lflag)
  800619:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80061d:	74 1a                	je     800639 <getint+0x45>
		return va_arg(*ap, long);
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	8d 50 04             	lea    0x4(%eax),%edx
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	89 10                	mov    %edx,(%eax)
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	83 e8 04             	sub    $0x4,%eax
  800634:	8b 00                	mov    (%eax),%eax
  800636:	99                   	cltd   
  800637:	eb 18                	jmp    800651 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	8b 00                	mov    (%eax),%eax
  80063e:	8d 50 04             	lea    0x4(%eax),%edx
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	89 10                	mov    %edx,(%eax)
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	8b 00                	mov    (%eax),%eax
  80064b:	83 e8 04             	sub    $0x4,%eax
  80064e:	8b 00                	mov    (%eax),%eax
  800650:	99                   	cltd   
}
  800651:	5d                   	pop    %ebp
  800652:	c3                   	ret    

00800653 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800653:	55                   	push   %ebp
  800654:	89 e5                	mov    %esp,%ebp
  800656:	56                   	push   %esi
  800657:	53                   	push   %ebx
  800658:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80065b:	eb 17                	jmp    800674 <vprintfmt+0x21>
			if (ch == '\0')
  80065d:	85 db                	test   %ebx,%ebx
  80065f:	0f 84 c1 03 00 00    	je     800a26 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	ff 75 0c             	pushl  0xc(%ebp)
  80066b:	53                   	push   %ebx
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	ff d0                	call   *%eax
  800671:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800674:	8b 45 10             	mov    0x10(%ebp),%eax
  800677:	8d 50 01             	lea    0x1(%eax),%edx
  80067a:	89 55 10             	mov    %edx,0x10(%ebp)
  80067d:	8a 00                	mov    (%eax),%al
  80067f:	0f b6 d8             	movzbl %al,%ebx
  800682:	83 fb 25             	cmp    $0x25,%ebx
  800685:	75 d6                	jne    80065d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800687:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80068b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800692:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800699:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006a0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8006aa:	8d 50 01             	lea    0x1(%eax),%edx
  8006ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8006b0:	8a 00                	mov    (%eax),%al
  8006b2:	0f b6 d8             	movzbl %al,%ebx
  8006b5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006b8:	83 f8 5b             	cmp    $0x5b,%eax
  8006bb:	0f 87 3d 03 00 00    	ja     8009fe <vprintfmt+0x3ab>
  8006c1:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  8006c8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006ca:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006ce:	eb d7                	jmp    8006a7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006d0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006d4:	eb d1                	jmp    8006a7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006d6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006e0:	89 d0                	mov    %edx,%eax
  8006e2:	c1 e0 02             	shl    $0x2,%eax
  8006e5:	01 d0                	add    %edx,%eax
  8006e7:	01 c0                	add    %eax,%eax
  8006e9:	01 d8                	add    %ebx,%eax
  8006eb:	83 e8 30             	sub    $0x30,%eax
  8006ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f4:	8a 00                	mov    (%eax),%al
  8006f6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006f9:	83 fb 2f             	cmp    $0x2f,%ebx
  8006fc:	7e 3e                	jle    80073c <vprintfmt+0xe9>
  8006fe:	83 fb 39             	cmp    $0x39,%ebx
  800701:	7f 39                	jg     80073c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800703:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800706:	eb d5                	jmp    8006dd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800708:	8b 45 14             	mov    0x14(%ebp),%eax
  80070b:	83 c0 04             	add    $0x4,%eax
  80070e:	89 45 14             	mov    %eax,0x14(%ebp)
  800711:	8b 45 14             	mov    0x14(%ebp),%eax
  800714:	83 e8 04             	sub    $0x4,%eax
  800717:	8b 00                	mov    (%eax),%eax
  800719:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80071c:	eb 1f                	jmp    80073d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80071e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800722:	79 83                	jns    8006a7 <vprintfmt+0x54>
				width = 0;
  800724:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80072b:	e9 77 ff ff ff       	jmp    8006a7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800730:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800737:	e9 6b ff ff ff       	jmp    8006a7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80073c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80073d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800741:	0f 89 60 ff ff ff    	jns    8006a7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800747:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80074a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80074d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800754:	e9 4e ff ff ff       	jmp    8006a7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800759:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80075c:	e9 46 ff ff ff       	jmp    8006a7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800761:	8b 45 14             	mov    0x14(%ebp),%eax
  800764:	83 c0 04             	add    $0x4,%eax
  800767:	89 45 14             	mov    %eax,0x14(%ebp)
  80076a:	8b 45 14             	mov    0x14(%ebp),%eax
  80076d:	83 e8 04             	sub    $0x4,%eax
  800770:	8b 00                	mov    (%eax),%eax
  800772:	83 ec 08             	sub    $0x8,%esp
  800775:	ff 75 0c             	pushl  0xc(%ebp)
  800778:	50                   	push   %eax
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	ff d0                	call   *%eax
  80077e:	83 c4 10             	add    $0x10,%esp
			break;
  800781:	e9 9b 02 00 00       	jmp    800a21 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800786:	8b 45 14             	mov    0x14(%ebp),%eax
  800789:	83 c0 04             	add    $0x4,%eax
  80078c:	89 45 14             	mov    %eax,0x14(%ebp)
  80078f:	8b 45 14             	mov    0x14(%ebp),%eax
  800792:	83 e8 04             	sub    $0x4,%eax
  800795:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800797:	85 db                	test   %ebx,%ebx
  800799:	79 02                	jns    80079d <vprintfmt+0x14a>
				err = -err;
  80079b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80079d:	83 fb 64             	cmp    $0x64,%ebx
  8007a0:	7f 0b                	jg     8007ad <vprintfmt+0x15a>
  8007a2:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  8007a9:	85 f6                	test   %esi,%esi
  8007ab:	75 19                	jne    8007c6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007ad:	53                   	push   %ebx
  8007ae:	68 a5 23 80 00       	push   $0x8023a5
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	ff 75 08             	pushl  0x8(%ebp)
  8007b9:	e8 70 02 00 00       	call   800a2e <printfmt>
  8007be:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007c1:	e9 5b 02 00 00       	jmp    800a21 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007c6:	56                   	push   %esi
  8007c7:	68 ae 23 80 00       	push   $0x8023ae
  8007cc:	ff 75 0c             	pushl  0xc(%ebp)
  8007cf:	ff 75 08             	pushl  0x8(%ebp)
  8007d2:	e8 57 02 00 00       	call   800a2e <printfmt>
  8007d7:	83 c4 10             	add    $0x10,%esp
			break;
  8007da:	e9 42 02 00 00       	jmp    800a21 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007df:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e2:	83 c0 04             	add    $0x4,%eax
  8007e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007eb:	83 e8 04             	sub    $0x4,%eax
  8007ee:	8b 30                	mov    (%eax),%esi
  8007f0:	85 f6                	test   %esi,%esi
  8007f2:	75 05                	jne    8007f9 <vprintfmt+0x1a6>
				p = "(null)";
  8007f4:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  8007f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007fd:	7e 6d                	jle    80086c <vprintfmt+0x219>
  8007ff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800803:	74 67                	je     80086c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800805:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800808:	83 ec 08             	sub    $0x8,%esp
  80080b:	50                   	push   %eax
  80080c:	56                   	push   %esi
  80080d:	e8 26 05 00 00       	call   800d38 <strnlen>
  800812:	83 c4 10             	add    $0x10,%esp
  800815:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800818:	eb 16                	jmp    800830 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80081a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 0c             	pushl  0xc(%ebp)
  800824:	50                   	push   %eax
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	ff d0                	call   *%eax
  80082a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80082d:	ff 4d e4             	decl   -0x1c(%ebp)
  800830:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800834:	7f e4                	jg     80081a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800836:	eb 34                	jmp    80086c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800838:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80083c:	74 1c                	je     80085a <vprintfmt+0x207>
  80083e:	83 fb 1f             	cmp    $0x1f,%ebx
  800841:	7e 05                	jle    800848 <vprintfmt+0x1f5>
  800843:	83 fb 7e             	cmp    $0x7e,%ebx
  800846:	7e 12                	jle    80085a <vprintfmt+0x207>
					putch('?', putdat);
  800848:	83 ec 08             	sub    $0x8,%esp
  80084b:	ff 75 0c             	pushl  0xc(%ebp)
  80084e:	6a 3f                	push   $0x3f
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	ff d0                	call   *%eax
  800855:	83 c4 10             	add    $0x10,%esp
  800858:	eb 0f                	jmp    800869 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80085a:	83 ec 08             	sub    $0x8,%esp
  80085d:	ff 75 0c             	pushl  0xc(%ebp)
  800860:	53                   	push   %ebx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	ff d0                	call   *%eax
  800866:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800869:	ff 4d e4             	decl   -0x1c(%ebp)
  80086c:	89 f0                	mov    %esi,%eax
  80086e:	8d 70 01             	lea    0x1(%eax),%esi
  800871:	8a 00                	mov    (%eax),%al
  800873:	0f be d8             	movsbl %al,%ebx
  800876:	85 db                	test   %ebx,%ebx
  800878:	74 24                	je     80089e <vprintfmt+0x24b>
  80087a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80087e:	78 b8                	js     800838 <vprintfmt+0x1e5>
  800880:	ff 4d e0             	decl   -0x20(%ebp)
  800883:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800887:	79 af                	jns    800838 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800889:	eb 13                	jmp    80089e <vprintfmt+0x24b>
				putch(' ', putdat);
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 0c             	pushl  0xc(%ebp)
  800891:	6a 20                	push   $0x20
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	ff d0                	call   *%eax
  800898:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80089b:	ff 4d e4             	decl   -0x1c(%ebp)
  80089e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008a2:	7f e7                	jg     80088b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008a4:	e9 78 01 00 00       	jmp    800a21 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008a9:	83 ec 08             	sub    $0x8,%esp
  8008ac:	ff 75 e8             	pushl  -0x18(%ebp)
  8008af:	8d 45 14             	lea    0x14(%ebp),%eax
  8008b2:	50                   	push   %eax
  8008b3:	e8 3c fd ff ff       	call   8005f4 <getint>
  8008b8:	83 c4 10             	add    $0x10,%esp
  8008bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008be:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c7:	85 d2                	test   %edx,%edx
  8008c9:	79 23                	jns    8008ee <vprintfmt+0x29b>
				putch('-', putdat);
  8008cb:	83 ec 08             	sub    $0x8,%esp
  8008ce:	ff 75 0c             	pushl  0xc(%ebp)
  8008d1:	6a 2d                	push   $0x2d
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	ff d0                	call   *%eax
  8008d8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008e1:	f7 d8                	neg    %eax
  8008e3:	83 d2 00             	adc    $0x0,%edx
  8008e6:	f7 da                	neg    %edx
  8008e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008f5:	e9 bc 00 00 00       	jmp    8009b6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 e8             	pushl  -0x18(%ebp)
  800900:	8d 45 14             	lea    0x14(%ebp),%eax
  800903:	50                   	push   %eax
  800904:	e8 84 fc ff ff       	call   80058d <getuint>
  800909:	83 c4 10             	add    $0x10,%esp
  80090c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800912:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800919:	e9 98 00 00 00       	jmp    8009b6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 0c             	pushl  0xc(%ebp)
  800924:	6a 58                	push   $0x58
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	ff d0                	call   *%eax
  80092b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80092e:	83 ec 08             	sub    $0x8,%esp
  800931:	ff 75 0c             	pushl  0xc(%ebp)
  800934:	6a 58                	push   $0x58
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	ff d0                	call   *%eax
  80093b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	6a 58                	push   $0x58
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	ff d0                	call   *%eax
  80094b:	83 c4 10             	add    $0x10,%esp
			break;
  80094e:	e9 ce 00 00 00       	jmp    800a21 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	6a 30                	push   $0x30
  80095b:	8b 45 08             	mov    0x8(%ebp),%eax
  80095e:	ff d0                	call   *%eax
  800960:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	ff 75 0c             	pushl  0xc(%ebp)
  800969:	6a 78                	push   $0x78
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	ff d0                	call   *%eax
  800970:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800973:	8b 45 14             	mov    0x14(%ebp),%eax
  800976:	83 c0 04             	add    $0x4,%eax
  800979:	89 45 14             	mov    %eax,0x14(%ebp)
  80097c:	8b 45 14             	mov    0x14(%ebp),%eax
  80097f:	83 e8 04             	sub    $0x4,%eax
  800982:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800984:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800987:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80098e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800995:	eb 1f                	jmp    8009b6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800997:	83 ec 08             	sub    $0x8,%esp
  80099a:	ff 75 e8             	pushl  -0x18(%ebp)
  80099d:	8d 45 14             	lea    0x14(%ebp),%eax
  8009a0:	50                   	push   %eax
  8009a1:	e8 e7 fb ff ff       	call   80058d <getuint>
  8009a6:	83 c4 10             	add    $0x10,%esp
  8009a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009af:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009b6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009bd:	83 ec 04             	sub    $0x4,%esp
  8009c0:	52                   	push   %edx
  8009c1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009c4:	50                   	push   %eax
  8009c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c8:	ff 75 f0             	pushl  -0x10(%ebp)
  8009cb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ce:	ff 75 08             	pushl  0x8(%ebp)
  8009d1:	e8 00 fb ff ff       	call   8004d6 <printnum>
  8009d6:	83 c4 20             	add    $0x20,%esp
			break;
  8009d9:	eb 46                	jmp    800a21 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009db:	83 ec 08             	sub    $0x8,%esp
  8009de:	ff 75 0c             	pushl  0xc(%ebp)
  8009e1:	53                   	push   %ebx
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	ff d0                	call   *%eax
  8009e7:	83 c4 10             	add    $0x10,%esp
			break;
  8009ea:	eb 35                	jmp    800a21 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009ec:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009f3:	eb 2c                	jmp    800a21 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009f5:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009fc:	eb 23                	jmp    800a21 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	6a 25                	push   $0x25
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a0e:	ff 4d 10             	decl   0x10(%ebp)
  800a11:	eb 03                	jmp    800a16 <vprintfmt+0x3c3>
  800a13:	ff 4d 10             	decl   0x10(%ebp)
  800a16:	8b 45 10             	mov    0x10(%ebp),%eax
  800a19:	48                   	dec    %eax
  800a1a:	8a 00                	mov    (%eax),%al
  800a1c:	3c 25                	cmp    $0x25,%al
  800a1e:	75 f3                	jne    800a13 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a20:	90                   	nop
		}
	}
  800a21:	e9 35 fc ff ff       	jmp    80065b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a26:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a27:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a2a:	5b                   	pop    %ebx
  800a2b:	5e                   	pop    %esi
  800a2c:	5d                   	pop    %ebp
  800a2d:	c3                   	ret    

00800a2e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
  800a31:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a34:	8d 45 10             	lea    0x10(%ebp),%eax
  800a37:	83 c0 04             	add    $0x4,%eax
  800a3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a40:	ff 75 f4             	pushl  -0xc(%ebp)
  800a43:	50                   	push   %eax
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	ff 75 08             	pushl  0x8(%ebp)
  800a4a:	e8 04 fc ff ff       	call   800653 <vprintfmt>
  800a4f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a52:	90                   	nop
  800a53:	c9                   	leave  
  800a54:	c3                   	ret    

00800a55 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a55:	55                   	push   %ebp
  800a56:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5b:	8b 40 08             	mov    0x8(%eax),%eax
  800a5e:	8d 50 01             	lea    0x1(%eax),%edx
  800a61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a64:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	8b 10                	mov    (%eax),%edx
  800a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6f:	8b 40 04             	mov    0x4(%eax),%eax
  800a72:	39 c2                	cmp    %eax,%edx
  800a74:	73 12                	jae    800a88 <sprintputch+0x33>
		*b->buf++ = ch;
  800a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a79:	8b 00                	mov    (%eax),%eax
  800a7b:	8d 48 01             	lea    0x1(%eax),%ecx
  800a7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a81:	89 0a                	mov    %ecx,(%edx)
  800a83:	8b 55 08             	mov    0x8(%ebp),%edx
  800a86:	88 10                	mov    %dl,(%eax)
}
  800a88:	90                   	nop
  800a89:	5d                   	pop    %ebp
  800a8a:	c3                   	ret    

00800a8b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a8b:	55                   	push   %ebp
  800a8c:	89 e5                	mov    %esp,%ebp
  800a8e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	01 d0                	add    %edx,%eax
  800aa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800aac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ab0:	74 06                	je     800ab8 <vsnprintf+0x2d>
  800ab2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab6:	7f 07                	jg     800abf <vsnprintf+0x34>
		return -E_INVAL;
  800ab8:	b8 03 00 00 00       	mov    $0x3,%eax
  800abd:	eb 20                	jmp    800adf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800abf:	ff 75 14             	pushl  0x14(%ebp)
  800ac2:	ff 75 10             	pushl  0x10(%ebp)
  800ac5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ac8:	50                   	push   %eax
  800ac9:	68 55 0a 80 00       	push   $0x800a55
  800ace:	e8 80 fb ff ff       	call   800653 <vprintfmt>
  800ad3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ad6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800adc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800adf:	c9                   	leave  
  800ae0:	c3                   	ret    

00800ae1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
  800ae4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ae7:	8d 45 10             	lea    0x10(%ebp),%eax
  800aea:	83 c0 04             	add    $0x4,%eax
  800aed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800af0:	8b 45 10             	mov    0x10(%ebp),%eax
  800af3:	ff 75 f4             	pushl  -0xc(%ebp)
  800af6:	50                   	push   %eax
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	ff 75 08             	pushl  0x8(%ebp)
  800afd:	e8 89 ff ff ff       	call   800a8b <vsnprintf>
  800b02:	83 c4 10             	add    $0x10,%esp
  800b05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b0b:	c9                   	leave  
  800b0c:	c3                   	ret    

00800b0d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800b0d:	55                   	push   %ebp
  800b0e:	89 e5                	mov    %esp,%ebp
  800b10:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  800b13:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b17:	74 13                	je     800b2c <readline+0x1f>
		cprintf("%s", prompt);
  800b19:	83 ec 08             	sub    $0x8,%esp
  800b1c:	ff 75 08             	pushl  0x8(%ebp)
  800b1f:	68 28 25 80 00       	push   $0x802528
  800b24:	e8 0b f9 ff ff       	call   800434 <cprintf>
  800b29:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800b2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800b33:	83 ec 0c             	sub    $0xc,%esp
  800b36:	6a 00                	push   $0x0
  800b38:	e8 8f 0f 00 00       	call   801acc <iscons>
  800b3d:	83 c4 10             	add    $0x10,%esp
  800b40:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800b43:	e8 6b 0f 00 00       	call   801ab3 <getchar>
  800b48:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800b4b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b4f:	79 22                	jns    800b73 <readline+0x66>
			if (c != -E_EOF)
  800b51:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800b55:	0f 84 ad 00 00 00    	je     800c08 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800b5b:	83 ec 08             	sub    $0x8,%esp
  800b5e:	ff 75 ec             	pushl  -0x14(%ebp)
  800b61:	68 2b 25 80 00       	push   $0x80252b
  800b66:	e8 c9 f8 ff ff       	call   800434 <cprintf>
  800b6b:	83 c4 10             	add    $0x10,%esp
			break;
  800b6e:	e9 95 00 00 00       	jmp    800c08 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800b73:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800b77:	7e 34                	jle    800bad <readline+0xa0>
  800b79:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800b80:	7f 2b                	jg     800bad <readline+0xa0>
			if (echoing)
  800b82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b86:	74 0e                	je     800b96 <readline+0x89>
				cputchar(c);
  800b88:	83 ec 0c             	sub    $0xc,%esp
  800b8b:	ff 75 ec             	pushl  -0x14(%ebp)
  800b8e:	e8 01 0f 00 00       	call   801a94 <cputchar>
  800b93:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b99:	8d 50 01             	lea    0x1(%eax),%edx
  800b9c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b9f:	89 c2                	mov    %eax,%edx
  800ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba4:	01 d0                	add    %edx,%eax
  800ba6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ba9:	88 10                	mov    %dl,(%eax)
  800bab:	eb 56                	jmp    800c03 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800bad:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800bb1:	75 1f                	jne    800bd2 <readline+0xc5>
  800bb3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800bb7:	7e 19                	jle    800bd2 <readline+0xc5>
			if (echoing)
  800bb9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bbd:	74 0e                	je     800bcd <readline+0xc0>
				cputchar(c);
  800bbf:	83 ec 0c             	sub    $0xc,%esp
  800bc2:	ff 75 ec             	pushl  -0x14(%ebp)
  800bc5:	e8 ca 0e 00 00       	call   801a94 <cputchar>
  800bca:	83 c4 10             	add    $0x10,%esp

			i--;
  800bcd:	ff 4d f4             	decl   -0xc(%ebp)
  800bd0:	eb 31                	jmp    800c03 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800bd2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800bd6:	74 0a                	je     800be2 <readline+0xd5>
  800bd8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800bdc:	0f 85 61 ff ff ff    	jne    800b43 <readline+0x36>
			if (echoing)
  800be2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800be6:	74 0e                	je     800bf6 <readline+0xe9>
				cputchar(c);
  800be8:	83 ec 0c             	sub    $0xc,%esp
  800beb:	ff 75 ec             	pushl  -0x14(%ebp)
  800bee:	e8 a1 0e 00 00       	call   801a94 <cputchar>
  800bf3:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800bf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfc:	01 d0                	add    %edx,%eax
  800bfe:	c6 00 00             	movb   $0x0,(%eax)
			break;
  800c01:	eb 06                	jmp    800c09 <readline+0xfc>
		}
	}
  800c03:	e9 3b ff ff ff       	jmp    800b43 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  800c08:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  800c09:	90                   	nop
  800c0a:	c9                   	leave  
  800c0b:	c3                   	ret    

00800c0c <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800c0c:	55                   	push   %ebp
  800c0d:	89 e5                	mov    %esp,%ebp
  800c0f:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  800c12:	e8 79 09 00 00       	call   801590 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  800c17:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c1b:	74 13                	je     800c30 <atomic_readline+0x24>
			cprintf("%s", prompt);
  800c1d:	83 ec 08             	sub    $0x8,%esp
  800c20:	ff 75 08             	pushl  0x8(%ebp)
  800c23:	68 28 25 80 00       	push   $0x802528
  800c28:	e8 07 f8 ff ff       	call   800434 <cprintf>
  800c2d:	83 c4 10             	add    $0x10,%esp

		i = 0;
  800c30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  800c37:	83 ec 0c             	sub    $0xc,%esp
  800c3a:	6a 00                	push   $0x0
  800c3c:	e8 8b 0e 00 00       	call   801acc <iscons>
  800c41:	83 c4 10             	add    $0x10,%esp
  800c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  800c47:	e8 67 0e 00 00       	call   801ab3 <getchar>
  800c4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  800c4f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c53:	79 22                	jns    800c77 <atomic_readline+0x6b>
				if (c != -E_EOF)
  800c55:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c59:	0f 84 ad 00 00 00    	je     800d0c <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 ec             	pushl  -0x14(%ebp)
  800c65:	68 2b 25 80 00       	push   $0x80252b
  800c6a:	e8 c5 f7 ff ff       	call   800434 <cprintf>
  800c6f:	83 c4 10             	add    $0x10,%esp
				break;
  800c72:	e9 95 00 00 00       	jmp    800d0c <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  800c77:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c7b:	7e 34                	jle    800cb1 <atomic_readline+0xa5>
  800c7d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c84:	7f 2b                	jg     800cb1 <atomic_readline+0xa5>
				if (echoing)
  800c86:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c8a:	74 0e                	je     800c9a <atomic_readline+0x8e>
					cputchar(c);
  800c8c:	83 ec 0c             	sub    $0xc,%esp
  800c8f:	ff 75 ec             	pushl  -0x14(%ebp)
  800c92:	e8 fd 0d 00 00       	call   801a94 <cputchar>
  800c97:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  800c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ca0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ca3:	89 c2                	mov    %eax,%edx
  800ca5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca8:	01 d0                	add    %edx,%eax
  800caa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800cad:	88 10                	mov    %dl,(%eax)
  800caf:	eb 56                	jmp    800d07 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  800cb1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800cb5:	75 1f                	jne    800cd6 <atomic_readline+0xca>
  800cb7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800cbb:	7e 19                	jle    800cd6 <atomic_readline+0xca>
				if (echoing)
  800cbd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cc1:	74 0e                	je     800cd1 <atomic_readline+0xc5>
					cputchar(c);
  800cc3:	83 ec 0c             	sub    $0xc,%esp
  800cc6:	ff 75 ec             	pushl  -0x14(%ebp)
  800cc9:	e8 c6 0d 00 00       	call   801a94 <cputchar>
  800cce:	83 c4 10             	add    $0x10,%esp
				i--;
  800cd1:	ff 4d f4             	decl   -0xc(%ebp)
  800cd4:	eb 31                	jmp    800d07 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  800cd6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800cda:	74 0a                	je     800ce6 <atomic_readline+0xda>
  800cdc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800ce0:	0f 85 61 ff ff ff    	jne    800c47 <atomic_readline+0x3b>
				if (echoing)
  800ce6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cea:	74 0e                	je     800cfa <atomic_readline+0xee>
					cputchar(c);
  800cec:	83 ec 0c             	sub    $0xc,%esp
  800cef:	ff 75 ec             	pushl  -0x14(%ebp)
  800cf2:	e8 9d 0d 00 00       	call   801a94 <cputchar>
  800cf7:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  800cfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d00:	01 d0                	add    %edx,%eax
  800d02:	c6 00 00             	movb   $0x0,(%eax)
				break;
  800d05:	eb 06                	jmp    800d0d <atomic_readline+0x101>
			}
		}
  800d07:	e9 3b ff ff ff       	jmp    800c47 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  800d0c:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  800d0d:	e8 98 08 00 00       	call   8015aa <sys_unlock_cons>
}
  800d12:	90                   	nop
  800d13:	c9                   	leave  
  800d14:	c3                   	ret    

00800d15 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d15:	55                   	push   %ebp
  800d16:	89 e5                	mov    %esp,%ebp
  800d18:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d22:	eb 06                	jmp    800d2a <strlen+0x15>
		n++;
  800d24:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d27:	ff 45 08             	incl   0x8(%ebp)
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	84 c0                	test   %al,%al
  800d31:	75 f1                	jne    800d24 <strlen+0xf>
		n++;
	return n;
  800d33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d36:	c9                   	leave  
  800d37:	c3                   	ret    

00800d38 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d38:	55                   	push   %ebp
  800d39:	89 e5                	mov    %esp,%ebp
  800d3b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d45:	eb 09                	jmp    800d50 <strnlen+0x18>
		n++;
  800d47:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d4a:	ff 45 08             	incl   0x8(%ebp)
  800d4d:	ff 4d 0c             	decl   0xc(%ebp)
  800d50:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d54:	74 09                	je     800d5f <strnlen+0x27>
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	8a 00                	mov    (%eax),%al
  800d5b:	84 c0                	test   %al,%al
  800d5d:	75 e8                	jne    800d47 <strnlen+0xf>
		n++;
	return n;
  800d5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d62:	c9                   	leave  
  800d63:	c3                   	ret    

00800d64 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d64:	55                   	push   %ebp
  800d65:	89 e5                	mov    %esp,%ebp
  800d67:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d70:	90                   	nop
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8d 50 01             	lea    0x1(%eax),%edx
  800d77:	89 55 08             	mov    %edx,0x8(%ebp)
  800d7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d80:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d83:	8a 12                	mov    (%edx),%dl
  800d85:	88 10                	mov    %dl,(%eax)
  800d87:	8a 00                	mov    (%eax),%al
  800d89:	84 c0                	test   %al,%al
  800d8b:	75 e4                	jne    800d71 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d90:	c9                   	leave  
  800d91:	c3                   	ret    

00800d92 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d92:	55                   	push   %ebp
  800d93:	89 e5                	mov    %esp,%ebp
  800d95:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da5:	eb 1f                	jmp    800dc6 <strncpy+0x34>
		*dst++ = *src;
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	8d 50 01             	lea    0x1(%eax),%edx
  800dad:	89 55 08             	mov    %edx,0x8(%ebp)
  800db0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800db3:	8a 12                	mov    (%edx),%dl
  800db5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dba:	8a 00                	mov    (%eax),%al
  800dbc:	84 c0                	test   %al,%al
  800dbe:	74 03                	je     800dc3 <strncpy+0x31>
			src++;
  800dc0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dc3:	ff 45 fc             	incl   -0x4(%ebp)
  800dc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dcc:	72 d9                	jb     800da7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dce:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dd1:	c9                   	leave  
  800dd2:	c3                   	ret    

00800dd3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dd3:	55                   	push   %ebp
  800dd4:	89 e5                	mov    %esp,%ebp
  800dd6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ddf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de3:	74 30                	je     800e15 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800de5:	eb 16                	jmp    800dfd <strlcpy+0x2a>
			*dst++ = *src++;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8d 50 01             	lea    0x1(%eax),%edx
  800ded:	89 55 08             	mov    %edx,0x8(%ebp)
  800df0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df9:	8a 12                	mov    (%edx),%dl
  800dfb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dfd:	ff 4d 10             	decl   0x10(%ebp)
  800e00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e04:	74 09                	je     800e0f <strlcpy+0x3c>
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	8a 00                	mov    (%eax),%al
  800e0b:	84 c0                	test   %al,%al
  800e0d:	75 d8                	jne    800de7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e15:	8b 55 08             	mov    0x8(%ebp),%edx
  800e18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1b:	29 c2                	sub    %eax,%edx
  800e1d:	89 d0                	mov    %edx,%eax
}
  800e1f:	c9                   	leave  
  800e20:	c3                   	ret    

00800e21 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e21:	55                   	push   %ebp
  800e22:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e24:	eb 06                	jmp    800e2c <strcmp+0xb>
		p++, q++;
  800e26:	ff 45 08             	incl   0x8(%ebp)
  800e29:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	84 c0                	test   %al,%al
  800e33:	74 0e                	je     800e43 <strcmp+0x22>
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8a 10                	mov    (%eax),%dl
  800e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	38 c2                	cmp    %al,%dl
  800e41:	74 e3                	je     800e26 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8a 00                	mov    (%eax),%al
  800e48:	0f b6 d0             	movzbl %al,%edx
  800e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	0f b6 c0             	movzbl %al,%eax
  800e53:	29 c2                	sub    %eax,%edx
  800e55:	89 d0                	mov    %edx,%eax
}
  800e57:	5d                   	pop    %ebp
  800e58:	c3                   	ret    

00800e59 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e5c:	eb 09                	jmp    800e67 <strncmp+0xe>
		n--, p++, q++;
  800e5e:	ff 4d 10             	decl   0x10(%ebp)
  800e61:	ff 45 08             	incl   0x8(%ebp)
  800e64:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6b:	74 17                	je     800e84 <strncmp+0x2b>
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	8a 00                	mov    (%eax),%al
  800e72:	84 c0                	test   %al,%al
  800e74:	74 0e                	je     800e84 <strncmp+0x2b>
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	8a 10                	mov    (%eax),%dl
  800e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7e:	8a 00                	mov    (%eax),%al
  800e80:	38 c2                	cmp    %al,%dl
  800e82:	74 da                	je     800e5e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e88:	75 07                	jne    800e91 <strncmp+0x38>
		return 0;
  800e8a:	b8 00 00 00 00       	mov    $0x0,%eax
  800e8f:	eb 14                	jmp    800ea5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	0f b6 d0             	movzbl %al,%edx
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	8a 00                	mov    (%eax),%al
  800e9e:	0f b6 c0             	movzbl %al,%eax
  800ea1:	29 c2                	sub    %eax,%edx
  800ea3:	89 d0                	mov    %edx,%eax
}
  800ea5:	5d                   	pop    %ebp
  800ea6:	c3                   	ret    

00800ea7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea7:	55                   	push   %ebp
  800ea8:	89 e5                	mov    %esp,%ebp
  800eaa:	83 ec 04             	sub    $0x4,%esp
  800ead:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eb3:	eb 12                	jmp    800ec7 <strchr+0x20>
		if (*s == c)
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ebd:	75 05                	jne    800ec4 <strchr+0x1d>
			return (char *) s;
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	eb 11                	jmp    800ed5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ec4:	ff 45 08             	incl   0x8(%ebp)
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	8a 00                	mov    (%eax),%al
  800ecc:	84 c0                	test   %al,%al
  800ece:	75 e5                	jne    800eb5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ed0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed5:	c9                   	leave  
  800ed6:	c3                   	ret    

00800ed7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed7:	55                   	push   %ebp
  800ed8:	89 e5                	mov    %esp,%ebp
  800eda:	83 ec 04             	sub    $0x4,%esp
  800edd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ee3:	eb 0d                	jmp    800ef2 <strfind+0x1b>
		if (*s == c)
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eed:	74 0e                	je     800efd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800eef:	ff 45 08             	incl   0x8(%ebp)
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	84 c0                	test   %al,%al
  800ef9:	75 ea                	jne    800ee5 <strfind+0xe>
  800efb:	eb 01                	jmp    800efe <strfind+0x27>
		if (*s == c)
			break;
  800efd:	90                   	nop
	return (char *) s;
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f01:	c9                   	leave  
  800f02:	c3                   	ret    

00800f03 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f03:	55                   	push   %ebp
  800f04:	89 e5                	mov    %esp,%ebp
  800f06:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f0f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f13:	76 63                	jbe    800f78 <memset+0x75>
		uint64 data_block = c;
  800f15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f18:	99                   	cltd   
  800f19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1c:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f25:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f29:	c1 e0 08             	shl    $0x8,%eax
  800f2c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f2f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f38:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f3c:	c1 e0 10             	shl    $0x10,%eax
  800f3f:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f42:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f45:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f4b:	89 c2                	mov    %eax,%edx
  800f4d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f52:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f55:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f58:	eb 18                	jmp    800f72 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f5a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f5d:	8d 41 08             	lea    0x8(%ecx),%eax
  800f60:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f63:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f66:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f69:	89 01                	mov    %eax,(%ecx)
  800f6b:	89 51 04             	mov    %edx,0x4(%ecx)
  800f6e:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f72:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f76:	77 e2                	ja     800f5a <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7c:	74 23                	je     800fa1 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f81:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f84:	eb 0e                	jmp    800f94 <memset+0x91>
			*p8++ = (uint8)c;
  800f86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f89:	8d 50 01             	lea    0x1(%eax),%edx
  800f8c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f92:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f94:	8b 45 10             	mov    0x10(%ebp),%eax
  800f97:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f9a:	89 55 10             	mov    %edx,0x10(%ebp)
  800f9d:	85 c0                	test   %eax,%eax
  800f9f:	75 e5                	jne    800f86 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fa4:	c9                   	leave  
  800fa5:	c3                   	ret    

00800fa6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fa6:	55                   	push   %ebp
  800fa7:	89 e5                	mov    %esp,%ebp
  800fa9:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800fb8:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fbc:	76 24                	jbe    800fe2 <memcpy+0x3c>
		while(n >= 8){
  800fbe:	eb 1c                	jmp    800fdc <memcpy+0x36>
			*d64 = *s64;
  800fc0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc3:	8b 50 04             	mov    0x4(%eax),%edx
  800fc6:	8b 00                	mov    (%eax),%eax
  800fc8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fcb:	89 01                	mov    %eax,(%ecx)
  800fcd:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800fd0:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800fd4:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800fd8:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800fdc:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fe0:	77 de                	ja     800fc0 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800fe2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe6:	74 31                	je     801019 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800fe8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800fee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800ff4:	eb 16                	jmp    80100c <memcpy+0x66>
			*d8++ = *s8++;
  800ff6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff9:	8d 50 01             	lea    0x1(%eax),%edx
  800ffc:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801002:	8d 4a 01             	lea    0x1(%edx),%ecx
  801005:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801008:	8a 12                	mov    (%edx),%dl
  80100a:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801012:	89 55 10             	mov    %edx,0x10(%ebp)
  801015:	85 c0                	test   %eax,%eax
  801017:	75 dd                	jne    800ff6 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80101c:	c9                   	leave  
  80101d:	c3                   	ret    

0080101e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
  801021:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801030:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801033:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801036:	73 50                	jae    801088 <memmove+0x6a>
  801038:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103b:	8b 45 10             	mov    0x10(%ebp),%eax
  80103e:	01 d0                	add    %edx,%eax
  801040:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801043:	76 43                	jbe    801088 <memmove+0x6a>
		s += n;
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80104b:	8b 45 10             	mov    0x10(%ebp),%eax
  80104e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801051:	eb 10                	jmp    801063 <memmove+0x45>
			*--d = *--s;
  801053:	ff 4d f8             	decl   -0x8(%ebp)
  801056:	ff 4d fc             	decl   -0x4(%ebp)
  801059:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80105c:	8a 10                	mov    (%eax),%dl
  80105e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801061:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	8d 50 ff             	lea    -0x1(%eax),%edx
  801069:	89 55 10             	mov    %edx,0x10(%ebp)
  80106c:	85 c0                	test   %eax,%eax
  80106e:	75 e3                	jne    801053 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801070:	eb 23                	jmp    801095 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801072:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801075:	8d 50 01             	lea    0x1(%eax),%edx
  801078:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80107b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801081:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801084:	8a 12                	mov    (%edx),%dl
  801086:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801088:	8b 45 10             	mov    0x10(%ebp),%eax
  80108b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108e:	89 55 10             	mov    %edx,0x10(%ebp)
  801091:	85 c0                	test   %eax,%eax
  801093:	75 dd                	jne    801072 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
  80109d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010ac:	eb 2a                	jmp    8010d8 <memcmp+0x3e>
		if (*s1 != *s2)
  8010ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b1:	8a 10                	mov    (%eax),%dl
  8010b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	38 c2                	cmp    %al,%dl
  8010ba:	74 16                	je     8010d2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	0f b6 d0             	movzbl %al,%edx
  8010c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	0f b6 c0             	movzbl %al,%eax
  8010cc:	29 c2                	sub    %eax,%edx
  8010ce:	89 d0                	mov    %edx,%eax
  8010d0:	eb 18                	jmp    8010ea <memcmp+0x50>
		s1++, s2++;
  8010d2:	ff 45 fc             	incl   -0x4(%ebp)
  8010d5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010db:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010de:	89 55 10             	mov    %edx,0x10(%ebp)
  8010e1:	85 c0                	test   %eax,%eax
  8010e3:	75 c9                	jne    8010ae <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
  8010ef:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f8:	01 d0                	add    %edx,%eax
  8010fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010fd:	eb 15                	jmp    801114 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	0f b6 d0             	movzbl %al,%edx
  801107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110a:	0f b6 c0             	movzbl %al,%eax
  80110d:	39 c2                	cmp    %eax,%edx
  80110f:	74 0d                	je     80111e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801111:	ff 45 08             	incl   0x8(%ebp)
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80111a:	72 e3                	jb     8010ff <memfind+0x13>
  80111c:	eb 01                	jmp    80111f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80111e:	90                   	nop
	return (void *) s;
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801122:	c9                   	leave  
  801123:	c3                   	ret    

00801124 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801124:	55                   	push   %ebp
  801125:	89 e5                	mov    %esp,%ebp
  801127:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80112a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801131:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801138:	eb 03                	jmp    80113d <strtol+0x19>
		s++;
  80113a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	8a 00                	mov    (%eax),%al
  801142:	3c 20                	cmp    $0x20,%al
  801144:	74 f4                	je     80113a <strtol+0x16>
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	3c 09                	cmp    $0x9,%al
  80114d:	74 eb                	je     80113a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	3c 2b                	cmp    $0x2b,%al
  801156:	75 05                	jne    80115d <strtol+0x39>
		s++;
  801158:	ff 45 08             	incl   0x8(%ebp)
  80115b:	eb 13                	jmp    801170 <strtol+0x4c>
	else if (*s == '-')
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	8a 00                	mov    (%eax),%al
  801162:	3c 2d                	cmp    $0x2d,%al
  801164:	75 0a                	jne    801170 <strtol+0x4c>
		s++, neg = 1;
  801166:	ff 45 08             	incl   0x8(%ebp)
  801169:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801170:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801174:	74 06                	je     80117c <strtol+0x58>
  801176:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80117a:	75 20                	jne    80119c <strtol+0x78>
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	3c 30                	cmp    $0x30,%al
  801183:	75 17                	jne    80119c <strtol+0x78>
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	40                   	inc    %eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	3c 78                	cmp    $0x78,%al
  80118d:	75 0d                	jne    80119c <strtol+0x78>
		s += 2, base = 16;
  80118f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801193:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80119a:	eb 28                	jmp    8011c4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80119c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a0:	75 15                	jne    8011b7 <strtol+0x93>
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 30                	cmp    $0x30,%al
  8011a9:	75 0c                	jne    8011b7 <strtol+0x93>
		s++, base = 8;
  8011ab:	ff 45 08             	incl   0x8(%ebp)
  8011ae:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011b5:	eb 0d                	jmp    8011c4 <strtol+0xa0>
	else if (base == 0)
  8011b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011bb:	75 07                	jne    8011c4 <strtol+0xa0>
		base = 10;
  8011bd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	3c 2f                	cmp    $0x2f,%al
  8011cb:	7e 19                	jle    8011e6 <strtol+0xc2>
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3c 39                	cmp    $0x39,%al
  8011d4:	7f 10                	jg     8011e6 <strtol+0xc2>
			dig = *s - '0';
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	0f be c0             	movsbl %al,%eax
  8011de:	83 e8 30             	sub    $0x30,%eax
  8011e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011e4:	eb 42                	jmp    801228 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	3c 60                	cmp    $0x60,%al
  8011ed:	7e 19                	jle    801208 <strtol+0xe4>
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	3c 7a                	cmp    $0x7a,%al
  8011f6:	7f 10                	jg     801208 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	0f be c0             	movsbl %al,%eax
  801200:	83 e8 57             	sub    $0x57,%eax
  801203:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801206:	eb 20                	jmp    801228 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	3c 40                	cmp    $0x40,%al
  80120f:	7e 39                	jle    80124a <strtol+0x126>
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	3c 5a                	cmp    $0x5a,%al
  801218:	7f 30                	jg     80124a <strtol+0x126>
			dig = *s - 'A' + 10;
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	83 e8 37             	sub    $0x37,%eax
  801225:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801228:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80122b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80122e:	7d 19                	jge    801249 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801230:	ff 45 08             	incl   0x8(%ebp)
  801233:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801236:	0f af 45 10          	imul   0x10(%ebp),%eax
  80123a:	89 c2                	mov    %eax,%edx
  80123c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123f:	01 d0                	add    %edx,%eax
  801241:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801244:	e9 7b ff ff ff       	jmp    8011c4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801249:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80124a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80124e:	74 08                	je     801258 <strtol+0x134>
		*endptr = (char *) s;
  801250:	8b 45 0c             	mov    0xc(%ebp),%eax
  801253:	8b 55 08             	mov    0x8(%ebp),%edx
  801256:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801258:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80125c:	74 07                	je     801265 <strtol+0x141>
  80125e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801261:	f7 d8                	neg    %eax
  801263:	eb 03                	jmp    801268 <strtol+0x144>
  801265:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801268:	c9                   	leave  
  801269:	c3                   	ret    

0080126a <ltostr>:

void
ltostr(long value, char *str)
{
  80126a:	55                   	push   %ebp
  80126b:	89 e5                	mov    %esp,%ebp
  80126d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801277:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80127e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801282:	79 13                	jns    801297 <ltostr+0x2d>
	{
		neg = 1;
  801284:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80128b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801291:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801294:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80129f:	99                   	cltd   
  8012a0:	f7 f9                	idiv   %ecx
  8012a2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a8:	8d 50 01             	lea    0x1(%eax),%edx
  8012ab:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ae:	89 c2                	mov    %eax,%edx
  8012b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b3:	01 d0                	add    %edx,%eax
  8012b5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b8:	83 c2 30             	add    $0x30,%edx
  8012bb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012c0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012c5:	f7 e9                	imul   %ecx
  8012c7:	c1 fa 02             	sar    $0x2,%edx
  8012ca:	89 c8                	mov    %ecx,%eax
  8012cc:	c1 f8 1f             	sar    $0x1f,%eax
  8012cf:	29 c2                	sub    %eax,%edx
  8012d1:	89 d0                	mov    %edx,%eax
  8012d3:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012da:	75 bb                	jne    801297 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e6:	48                   	dec    %eax
  8012e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012ee:	74 3d                	je     80132d <ltostr+0xc3>
		start = 1 ;
  8012f0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012f7:	eb 34                	jmp    80132d <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ff:	01 d0                	add    %edx,%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801306:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130c:	01 c2                	add    %eax,%edx
  80130e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	01 c8                	add    %ecx,%eax
  801316:	8a 00                	mov    (%eax),%al
  801318:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80131a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80131d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801320:	01 c2                	add    %eax,%edx
  801322:	8a 45 eb             	mov    -0x15(%ebp),%al
  801325:	88 02                	mov    %al,(%edx)
		start++ ;
  801327:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80132a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80132d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801330:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801333:	7c c4                	jl     8012f9 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801335:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	01 d0                	add    %edx,%eax
  80133d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801340:	90                   	nop
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
  801346:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801349:	ff 75 08             	pushl  0x8(%ebp)
  80134c:	e8 c4 f9 ff ff       	call   800d15 <strlen>
  801351:	83 c4 04             	add    $0x4,%esp
  801354:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801357:	ff 75 0c             	pushl  0xc(%ebp)
  80135a:	e8 b6 f9 ff ff       	call   800d15 <strlen>
  80135f:	83 c4 04             	add    $0x4,%esp
  801362:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80136c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801373:	eb 17                	jmp    80138c <strcconcat+0x49>
		final[s] = str1[s] ;
  801375:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801378:	8b 45 10             	mov    0x10(%ebp),%eax
  80137b:	01 c2                	add    %eax,%edx
  80137d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	01 c8                	add    %ecx,%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801389:	ff 45 fc             	incl   -0x4(%ebp)
  80138c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80138f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801392:	7c e1                	jl     801375 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801394:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80139b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013a2:	eb 1f                	jmp    8013c3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a7:	8d 50 01             	lea    0x1(%eax),%edx
  8013aa:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013ad:	89 c2                	mov    %eax,%edx
  8013af:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b2:	01 c2                	add    %eax,%edx
  8013b4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ba:	01 c8                	add    %ecx,%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013c0:	ff 45 f8             	incl   -0x8(%ebp)
  8013c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013c9:	7c d9                	jl     8013a4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d1:	01 d0                	add    %edx,%eax
  8013d3:	c6 00 00             	movb   $0x0,(%eax)
}
  8013d6:	90                   	nop
  8013d7:	c9                   	leave  
  8013d8:	c3                   	ret    

008013d9 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013d9:	55                   	push   %ebp
  8013da:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e8:	8b 00                	mov    (%eax),%eax
  8013ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f4:	01 d0                	add    %edx,%eax
  8013f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013fc:	eb 0c                	jmp    80140a <strsplit+0x31>
			*string++ = 0;
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	8d 50 01             	lea    0x1(%eax),%edx
  801404:	89 55 08             	mov    %edx,0x8(%ebp)
  801407:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	84 c0                	test   %al,%al
  801411:	74 18                	je     80142b <strsplit+0x52>
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	0f be c0             	movsbl %al,%eax
  80141b:	50                   	push   %eax
  80141c:	ff 75 0c             	pushl  0xc(%ebp)
  80141f:	e8 83 fa ff ff       	call   800ea7 <strchr>
  801424:	83 c4 08             	add    $0x8,%esp
  801427:	85 c0                	test   %eax,%eax
  801429:	75 d3                	jne    8013fe <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	84 c0                	test   %al,%al
  801432:	74 5a                	je     80148e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801434:	8b 45 14             	mov    0x14(%ebp),%eax
  801437:	8b 00                	mov    (%eax),%eax
  801439:	83 f8 0f             	cmp    $0xf,%eax
  80143c:	75 07                	jne    801445 <strsplit+0x6c>
		{
			return 0;
  80143e:	b8 00 00 00 00       	mov    $0x0,%eax
  801443:	eb 66                	jmp    8014ab <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801445:	8b 45 14             	mov    0x14(%ebp),%eax
  801448:	8b 00                	mov    (%eax),%eax
  80144a:	8d 48 01             	lea    0x1(%eax),%ecx
  80144d:	8b 55 14             	mov    0x14(%ebp),%edx
  801450:	89 0a                	mov    %ecx,(%edx)
  801452:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801459:	8b 45 10             	mov    0x10(%ebp),%eax
  80145c:	01 c2                	add    %eax,%edx
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801463:	eb 03                	jmp    801468 <strsplit+0x8f>
			string++;
  801465:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	84 c0                	test   %al,%al
  80146f:	74 8b                	je     8013fc <strsplit+0x23>
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f be c0             	movsbl %al,%eax
  801479:	50                   	push   %eax
  80147a:	ff 75 0c             	pushl  0xc(%ebp)
  80147d:	e8 25 fa ff ff       	call   800ea7 <strchr>
  801482:	83 c4 08             	add    $0x8,%esp
  801485:	85 c0                	test   %eax,%eax
  801487:	74 dc                	je     801465 <strsplit+0x8c>
			string++;
	}
  801489:	e9 6e ff ff ff       	jmp    8013fc <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80148e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80148f:	8b 45 14             	mov    0x14(%ebp),%eax
  801492:	8b 00                	mov    (%eax),%eax
  801494:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80149b:	8b 45 10             	mov    0x10(%ebp),%eax
  80149e:	01 d0                	add    %edx,%eax
  8014a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014a6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
  8014b0:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8014b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8014b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014c0:	eb 4a                	jmp    80150c <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	01 c2                	add    %eax,%edx
  8014ca:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d0:	01 c8                	add    %ecx,%eax
  8014d2:	8a 00                	mov    (%eax),%al
  8014d4:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dc:	01 d0                	add    %edx,%eax
  8014de:	8a 00                	mov    (%eax),%al
  8014e0:	3c 40                	cmp    $0x40,%al
  8014e2:	7e 25                	jle    801509 <str2lower+0x5c>
  8014e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ea:	01 d0                	add    %edx,%eax
  8014ec:	8a 00                	mov    (%eax),%al
  8014ee:	3c 5a                	cmp    $0x5a,%al
  8014f0:	7f 17                	jg     801509 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8014f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	01 d0                	add    %edx,%eax
  8014fa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801500:	01 ca                	add    %ecx,%edx
  801502:	8a 12                	mov    (%edx),%dl
  801504:	83 c2 20             	add    $0x20,%edx
  801507:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801509:	ff 45 fc             	incl   -0x4(%ebp)
  80150c:	ff 75 0c             	pushl  0xc(%ebp)
  80150f:	e8 01 f8 ff ff       	call   800d15 <strlen>
  801514:	83 c4 04             	add    $0x4,%esp
  801517:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80151a:	7f a6                	jg     8014c2 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80151c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80151f:	c9                   	leave  
  801520:	c3                   	ret    

00801521 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
  801524:	57                   	push   %edi
  801525:	56                   	push   %esi
  801526:	53                   	push   %ebx
  801527:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801530:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801533:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801536:	8b 7d 18             	mov    0x18(%ebp),%edi
  801539:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80153c:	cd 30                	int    $0x30
  80153e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801541:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801544:	83 c4 10             	add    $0x10,%esp
  801547:	5b                   	pop    %ebx
  801548:	5e                   	pop    %esi
  801549:	5f                   	pop    %edi
  80154a:	5d                   	pop    %ebp
  80154b:	c3                   	ret    

0080154c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
  80154f:	83 ec 04             	sub    $0x4,%esp
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801558:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80155b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	6a 00                	push   $0x0
  801564:	51                   	push   %ecx
  801565:	52                   	push   %edx
  801566:	ff 75 0c             	pushl  0xc(%ebp)
  801569:	50                   	push   %eax
  80156a:	6a 00                	push   $0x0
  80156c:	e8 b0 ff ff ff       	call   801521 <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
}
  801574:	90                   	nop
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <sys_cgetc>:

int
sys_cgetc(void)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 02                	push   $0x2
  801586:	e8 96 ff ff ff       	call   801521 <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 03                	push   $0x3
  80159f:	e8 7d ff ff ff       	call   801521 <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
}
  8015a7:	90                   	nop
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 04                	push   $0x4
  8015b9:	e8 63 ff ff ff       	call   801521 <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	90                   	nop
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	52                   	push   %edx
  8015d4:	50                   	push   %eax
  8015d5:	6a 08                	push   $0x8
  8015d7:	e8 45 ff ff ff       	call   801521 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
  8015e4:	56                   	push   %esi
  8015e5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015e6:	8b 75 18             	mov    0x18(%ebp),%esi
  8015e9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	56                   	push   %esi
  8015f6:	53                   	push   %ebx
  8015f7:	51                   	push   %ecx
  8015f8:	52                   	push   %edx
  8015f9:	50                   	push   %eax
  8015fa:	6a 09                	push   $0x9
  8015fc:	e8 20 ff ff ff       	call   801521 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801607:	5b                   	pop    %ebx
  801608:	5e                   	pop    %esi
  801609:	5d                   	pop    %ebp
  80160a:	c3                   	ret    

0080160b <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	ff 75 08             	pushl  0x8(%ebp)
  801619:	6a 0a                	push   $0xa
  80161b:	e8 01 ff ff ff       	call   801521 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	ff 75 0c             	pushl  0xc(%ebp)
  801631:	ff 75 08             	pushl  0x8(%ebp)
  801634:	6a 0b                	push   $0xb
  801636:	e8 e6 fe ff ff       	call   801521 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 0c                	push   $0xc
  80164f:	e8 cd fe ff ff       	call   801521 <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
}
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 0d                	push   $0xd
  801668:	e8 b4 fe ff ff       	call   801521 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 0e                	push   $0xe
  801681:	e8 9b fe ff ff       	call   801521 <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
}
  801689:	c9                   	leave  
  80168a:	c3                   	ret    

0080168b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 0f                	push   $0xf
  80169a:	e8 82 fe ff ff       	call   801521 <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	ff 75 08             	pushl  0x8(%ebp)
  8016b2:	6a 10                	push   $0x10
  8016b4:	e8 68 fe ff ff       	call   801521 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
}
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 11                	push   $0x11
  8016cd:	e8 4f fe ff ff       	call   801521 <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
}
  8016d5:	90                   	nop
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_cputc>:

void
sys_cputc(const char c)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016e4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	50                   	push   %eax
  8016f1:	6a 01                	push   $0x1
  8016f3:	e8 29 fe ff ff       	call   801521 <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
}
  8016fb:	90                   	nop
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 14                	push   $0x14
  80170d:	e8 0f fe ff ff       	call   801521 <syscall>
  801712:	83 c4 18             	add    $0x18,%esp
}
  801715:	90                   	nop
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 04             	sub    $0x4,%esp
  80171e:	8b 45 10             	mov    0x10(%ebp),%eax
  801721:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801724:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801727:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	6a 00                	push   $0x0
  801730:	51                   	push   %ecx
  801731:	52                   	push   %edx
  801732:	ff 75 0c             	pushl  0xc(%ebp)
  801735:	50                   	push   %eax
  801736:	6a 15                	push   $0x15
  801738:	e8 e4 fd ff ff       	call   801521 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801745:	8b 55 10             	mov    0x10(%ebp),%edx
  801748:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	52                   	push   %edx
  801750:	50                   	push   %eax
  801751:	ff 75 08             	pushl  0x8(%ebp)
  801754:	6a 16                	push   $0x16
  801756:	e8 c6 fd ff ff       	call   801521 <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801763:	8b 55 0c             	mov    0xc(%ebp),%edx
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 17                	push   $0x17
  801773:	e8 a9 fd ff ff       	call   801521 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801780:	8b 55 0c             	mov    0xc(%ebp),%edx
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	52                   	push   %edx
  80178d:	50                   	push   %eax
  80178e:	6a 18                	push   $0x18
  801790:	e8 8c fd ff ff       	call   801521 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	6a 00                	push   $0x0
  8017a2:	ff 75 14             	pushl  0x14(%ebp)
  8017a5:	ff 75 10             	pushl  0x10(%ebp)
  8017a8:	ff 75 0c             	pushl  0xc(%ebp)
  8017ab:	50                   	push   %eax
  8017ac:	6a 19                	push   $0x19
  8017ae:	e8 6e fd ff ff       	call   801521 <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	50                   	push   %eax
  8017c7:	6a 1a                	push   $0x1a
  8017c9:	e8 53 fd ff ff       	call   801521 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	90                   	nop
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8017d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	50                   	push   %eax
  8017e3:	6a 1b                	push   $0x1b
  8017e5:	e8 37 fd ff ff       	call   801521 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 05                	push   $0x5
  8017fe:	e8 1e fd ff ff       	call   801521 <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 06                	push   $0x6
  801817:	e8 05 fd ff ff       	call   801521 <syscall>
  80181c:	83 c4 18             	add    $0x18,%esp
}
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 07                	push   $0x7
  801830:	e8 ec fc ff ff       	call   801521 <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <sys_exit_env>:


void sys_exit_env(void)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 1c                	push   $0x1c
  801849:	e8 d3 fc ff ff       	call   801521 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	90                   	nop
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	ff 75 10             	pushl  0x10(%ebp)
  80185e:	ff 75 0c             	pushl  0xc(%ebp)
  801861:	ff 75 08             	pushl  0x8(%ebp)
  801864:	6a 13                	push   $0x13
  801866:	e8 b6 fc ff ff       	call   801521 <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
	return ;
  80186e:	90                   	nop
}
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <sys_rcr2>:
uint32 sys_rcr2()
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 1e                	push   $0x1e
  801880:	e8 9c fc ff ff       	call   801521 <syscall>
  801885:	83 c4 18             	add    $0x18,%esp
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
  80188d:	83 ec 04             	sub    $0x4,%esp
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801896:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	50                   	push   %eax
  8018a3:	6a 1f                	push   $0x1f
  8018a5:	e8 77 fc ff ff       	call   801521 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ad:	90                   	nop
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <rsttst>:
void rsttst()
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 21                	push   $0x21
  8018bf:	e8 5d fc ff ff       	call   801521 <syscall>
  8018c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c7:	90                   	nop
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
  8018cd:	83 ec 04             	sub    $0x4,%esp
  8018d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018d6:	8b 55 18             	mov    0x18(%ebp),%edx
  8018d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018dd:	52                   	push   %edx
  8018de:	50                   	push   %eax
  8018df:	ff 75 10             	pushl  0x10(%ebp)
  8018e2:	ff 75 0c             	pushl  0xc(%ebp)
  8018e5:	ff 75 08             	pushl  0x8(%ebp)
  8018e8:	6a 20                	push   $0x20
  8018ea:	e8 32 fc ff ff       	call   801521 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f2:	90                   	nop
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <chktst>:
void chktst(uint32 n)
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	ff 75 08             	pushl  0x8(%ebp)
  801903:	6a 22                	push   $0x22
  801905:	e8 17 fc ff ff       	call   801521 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
	return ;
  80190d:	90                   	nop
}
  80190e:	c9                   	leave  
  80190f:	c3                   	ret    

00801910 <inctst>:

void inctst()
{
  801910:	55                   	push   %ebp
  801911:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 23                	push   $0x23
  80191f:	e8 fd fb ff ff       	call   801521 <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
	return ;
  801927:	90                   	nop
}
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <gettst>:
uint32 gettst()
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 24                	push   $0x24
  801939:	e8 e3 fb ff ff       	call   801521 <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 25                	push   $0x25
  801952:	e8 ca fb ff ff       	call   801521 <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
  80195a:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  80195f:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801969:	8b 45 08             	mov    0x8(%ebp),%eax
  80196c:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	ff 75 08             	pushl  0x8(%ebp)
  80197c:	6a 26                	push   $0x26
  80197e:	e8 9e fb ff ff       	call   801521 <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
	return ;
  801986:	90                   	nop
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80198d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801990:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801993:	8b 55 0c             	mov    0xc(%ebp),%edx
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	6a 00                	push   $0x0
  80199b:	53                   	push   %ebx
  80199c:	51                   	push   %ecx
  80199d:	52                   	push   %edx
  80199e:	50                   	push   %eax
  80199f:	6a 27                	push   $0x27
  8019a1:	e8 7b fb ff ff       	call   801521 <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	52                   	push   %edx
  8019be:	50                   	push   %eax
  8019bf:	6a 28                	push   $0x28
  8019c1:	e8 5b fb ff ff       	call   801521 <syscall>
  8019c6:	83 c4 18             	add    $0x18,%esp
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8019ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	51                   	push   %ecx
  8019da:	ff 75 10             	pushl  0x10(%ebp)
  8019dd:	52                   	push   %edx
  8019de:	50                   	push   %eax
  8019df:	6a 29                	push   $0x29
  8019e1:	e8 3b fb ff ff       	call   801521 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	ff 75 10             	pushl  0x10(%ebp)
  8019f5:	ff 75 0c             	pushl  0xc(%ebp)
  8019f8:	ff 75 08             	pushl  0x8(%ebp)
  8019fb:	6a 12                	push   $0x12
  8019fd:	e8 1f fb ff ff       	call   801521 <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
	return ;
  801a05:	90                   	nop
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801a0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	52                   	push   %edx
  801a18:	50                   	push   %eax
  801a19:	6a 2a                	push   $0x2a
  801a1b:	e8 01 fb ff ff       	call   801521 <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
	return;
  801a23:	90                   	nop
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 2b                	push   $0x2b
  801a35:	e8 e7 fa ff ff       	call   801521 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
  801a42:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801a45:	83 ec 04             	sub    $0x4,%esp
  801a48:	68 3b 25 80 00       	push   $0x80253b
  801a4d:	68 0a 01 00 00       	push   $0x10a
  801a52:	68 4b 25 80 00       	push   $0x80254b
  801a57:	e8 7a 00 00 00       	call   801ad6 <_panic>

00801a5c <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	ff 75 0c             	pushl  0xc(%ebp)
  801a68:	ff 75 08             	pushl  0x8(%ebp)
  801a6b:	6a 33                	push   $0x33
  801a6d:	e8 af fa ff ff       	call   801521 <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
	return;
  801a75:	90                   	nop
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a78:	55                   	push   %ebp
  801a79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	ff 75 08             	pushl  0x8(%ebp)
  801a87:	6a 34                	push   $0x34
  801a89:	e8 93 fa ff ff       	call   801521 <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a91:	90                   	nop
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
  801a97:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801aa0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801aa4:	83 ec 0c             	sub    $0xc,%esp
  801aa7:	50                   	push   %eax
  801aa8:	e8 2b fc ff ff       	call   8016d8 <sys_cputc>
  801aad:	83 c4 10             	add    $0x10,%esp
}
  801ab0:	90                   	nop
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <getchar>:


int
getchar(void)
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
  801ab6:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  801ab9:	e8 b9 fa ff ff       	call   801577 <sys_cgetc>
  801abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ac1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801ac5:	74 f2                	je     801ab9 <getchar+0x6>
	return c;
  801ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801aca:	c9                   	leave  
  801acb:	c3                   	ret    

00801acc <iscons>:

int iscons(int fdnum)
{
  801acc:	55                   	push   %ebp
  801acd:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801acf:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ad4:	5d                   	pop    %ebp
  801ad5:	c3                   	ret    

00801ad6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
  801ad9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801adc:	8d 45 10             	lea    0x10(%ebp),%eax
  801adf:	83 c0 04             	add    $0x4,%eax
  801ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801ae5:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801aea:	85 c0                	test   %eax,%eax
  801aec:	74 16                	je     801b04 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801aee:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801af3:	83 ec 08             	sub    $0x8,%esp
  801af6:	50                   	push   %eax
  801af7:	68 5c 25 80 00       	push   $0x80255c
  801afc:	e8 33 e9 ff ff       	call   800434 <cprintf>
  801b01:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801b04:	a1 04 30 80 00       	mov    0x803004,%eax
  801b09:	83 ec 0c             	sub    $0xc,%esp
  801b0c:	ff 75 0c             	pushl  0xc(%ebp)
  801b0f:	ff 75 08             	pushl  0x8(%ebp)
  801b12:	50                   	push   %eax
  801b13:	68 64 25 80 00       	push   $0x802564
  801b18:	6a 74                	push   $0x74
  801b1a:	e8 42 e9 ff ff       	call   800461 <cprintf_colored>
  801b1f:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801b22:	8b 45 10             	mov    0x10(%ebp),%eax
  801b25:	83 ec 08             	sub    $0x8,%esp
  801b28:	ff 75 f4             	pushl  -0xc(%ebp)
  801b2b:	50                   	push   %eax
  801b2c:	e8 94 e8 ff ff       	call   8003c5 <vcprintf>
  801b31:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b34:	83 ec 08             	sub    $0x8,%esp
  801b37:	6a 00                	push   $0x0
  801b39:	68 8c 25 80 00       	push   $0x80258c
  801b3e:	e8 82 e8 ff ff       	call   8003c5 <vcprintf>
  801b43:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b46:	e8 fb e7 ff ff       	call   800346 <exit>

	// should not return here
	while (1) ;
  801b4b:	eb fe                	jmp    801b4b <_panic+0x75>

00801b4d <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
  801b50:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b53:	a1 20 30 80 00       	mov    0x803020,%eax
  801b58:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801b5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b61:	39 c2                	cmp    %eax,%edx
  801b63:	74 14                	je     801b79 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b65:	83 ec 04             	sub    $0x4,%esp
  801b68:	68 90 25 80 00       	push   $0x802590
  801b6d:	6a 26                	push   $0x26
  801b6f:	68 dc 25 80 00       	push   $0x8025dc
  801b74:	e8 5d ff ff ff       	call   801ad6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b80:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b87:	e9 c5 00 00 00       	jmp    801c51 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801b8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b8f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	01 d0                	add    %edx,%eax
  801b9b:	8b 00                	mov    (%eax),%eax
  801b9d:	85 c0                	test   %eax,%eax
  801b9f:	75 08                	jne    801ba9 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801ba1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801ba4:	e9 a5 00 00 00       	jmp    801c4e <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801ba9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bb0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801bb7:	eb 69                	jmp    801c22 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801bb9:	a1 20 30 80 00       	mov    0x803020,%eax
  801bbe:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bc4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bc7:	89 d0                	mov    %edx,%eax
  801bc9:	01 c0                	add    %eax,%eax
  801bcb:	01 d0                	add    %edx,%eax
  801bcd:	c1 e0 03             	shl    $0x3,%eax
  801bd0:	01 c8                	add    %ecx,%eax
  801bd2:	8a 40 04             	mov    0x4(%eax),%al
  801bd5:	84 c0                	test   %al,%al
  801bd7:	75 46                	jne    801c1f <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801bd9:	a1 20 30 80 00       	mov    0x803020,%eax
  801bde:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801be4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801be7:	89 d0                	mov    %edx,%eax
  801be9:	01 c0                	add    %eax,%eax
  801beb:	01 d0                	add    %edx,%eax
  801bed:	c1 e0 03             	shl    $0x3,%eax
  801bf0:	01 c8                	add    %ecx,%eax
  801bf2:	8b 00                	mov    (%eax),%eax
  801bf4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bf7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bfa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801bff:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c04:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	01 c8                	add    %ecx,%eax
  801c10:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c12:	39 c2                	cmp    %eax,%edx
  801c14:	75 09                	jne    801c1f <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801c16:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c1d:	eb 15                	jmp    801c34 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c1f:	ff 45 e8             	incl   -0x18(%ebp)
  801c22:	a1 20 30 80 00       	mov    0x803020,%eax
  801c27:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c30:	39 c2                	cmp    %eax,%edx
  801c32:	77 85                	ja     801bb9 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c34:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c38:	75 14                	jne    801c4e <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801c3a:	83 ec 04             	sub    $0x4,%esp
  801c3d:	68 e8 25 80 00       	push   $0x8025e8
  801c42:	6a 3a                	push   $0x3a
  801c44:	68 dc 25 80 00       	push   $0x8025dc
  801c49:	e8 88 fe ff ff       	call   801ad6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c4e:	ff 45 f0             	incl   -0x10(%ebp)
  801c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c54:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c57:	0f 8c 2f ff ff ff    	jl     801b8c <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c64:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c6b:	eb 26                	jmp    801c93 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c6d:	a1 20 30 80 00       	mov    0x803020,%eax
  801c72:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c78:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c7b:	89 d0                	mov    %edx,%eax
  801c7d:	01 c0                	add    %eax,%eax
  801c7f:	01 d0                	add    %edx,%eax
  801c81:	c1 e0 03             	shl    $0x3,%eax
  801c84:	01 c8                	add    %ecx,%eax
  801c86:	8a 40 04             	mov    0x4(%eax),%al
  801c89:	3c 01                	cmp    $0x1,%al
  801c8b:	75 03                	jne    801c90 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801c8d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c90:	ff 45 e0             	incl   -0x20(%ebp)
  801c93:	a1 20 30 80 00       	mov    0x803020,%eax
  801c98:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ca1:	39 c2                	cmp    %eax,%edx
  801ca3:	77 c8                	ja     801c6d <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ca8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cab:	74 14                	je     801cc1 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801cad:	83 ec 04             	sub    $0x4,%esp
  801cb0:	68 3c 26 80 00       	push   $0x80263c
  801cb5:	6a 44                	push   $0x44
  801cb7:	68 dc 25 80 00       	push   $0x8025dc
  801cbc:	e8 15 fe ff ff       	call   801ad6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801cc1:	90                   	nop
  801cc2:	c9                   	leave  
  801cc3:	c3                   	ret    

00801cc4 <__udivdi3>:
  801cc4:	55                   	push   %ebp
  801cc5:	57                   	push   %edi
  801cc6:	56                   	push   %esi
  801cc7:	53                   	push   %ebx
  801cc8:	83 ec 1c             	sub    $0x1c,%esp
  801ccb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ccf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cd3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cd7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cdb:	89 ca                	mov    %ecx,%edx
  801cdd:	89 f8                	mov    %edi,%eax
  801cdf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ce3:	85 f6                	test   %esi,%esi
  801ce5:	75 2d                	jne    801d14 <__udivdi3+0x50>
  801ce7:	39 cf                	cmp    %ecx,%edi
  801ce9:	77 65                	ja     801d50 <__udivdi3+0x8c>
  801ceb:	89 fd                	mov    %edi,%ebp
  801ced:	85 ff                	test   %edi,%edi
  801cef:	75 0b                	jne    801cfc <__udivdi3+0x38>
  801cf1:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf6:	31 d2                	xor    %edx,%edx
  801cf8:	f7 f7                	div    %edi
  801cfa:	89 c5                	mov    %eax,%ebp
  801cfc:	31 d2                	xor    %edx,%edx
  801cfe:	89 c8                	mov    %ecx,%eax
  801d00:	f7 f5                	div    %ebp
  801d02:	89 c1                	mov    %eax,%ecx
  801d04:	89 d8                	mov    %ebx,%eax
  801d06:	f7 f5                	div    %ebp
  801d08:	89 cf                	mov    %ecx,%edi
  801d0a:	89 fa                	mov    %edi,%edx
  801d0c:	83 c4 1c             	add    $0x1c,%esp
  801d0f:	5b                   	pop    %ebx
  801d10:	5e                   	pop    %esi
  801d11:	5f                   	pop    %edi
  801d12:	5d                   	pop    %ebp
  801d13:	c3                   	ret    
  801d14:	39 ce                	cmp    %ecx,%esi
  801d16:	77 28                	ja     801d40 <__udivdi3+0x7c>
  801d18:	0f bd fe             	bsr    %esi,%edi
  801d1b:	83 f7 1f             	xor    $0x1f,%edi
  801d1e:	75 40                	jne    801d60 <__udivdi3+0x9c>
  801d20:	39 ce                	cmp    %ecx,%esi
  801d22:	72 0a                	jb     801d2e <__udivdi3+0x6a>
  801d24:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d28:	0f 87 9e 00 00 00    	ja     801dcc <__udivdi3+0x108>
  801d2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d33:	89 fa                	mov    %edi,%edx
  801d35:	83 c4 1c             	add    $0x1c,%esp
  801d38:	5b                   	pop    %ebx
  801d39:	5e                   	pop    %esi
  801d3a:	5f                   	pop    %edi
  801d3b:	5d                   	pop    %ebp
  801d3c:	c3                   	ret    
  801d3d:	8d 76 00             	lea    0x0(%esi),%esi
  801d40:	31 ff                	xor    %edi,%edi
  801d42:	31 c0                	xor    %eax,%eax
  801d44:	89 fa                	mov    %edi,%edx
  801d46:	83 c4 1c             	add    $0x1c,%esp
  801d49:	5b                   	pop    %ebx
  801d4a:	5e                   	pop    %esi
  801d4b:	5f                   	pop    %edi
  801d4c:	5d                   	pop    %ebp
  801d4d:	c3                   	ret    
  801d4e:	66 90                	xchg   %ax,%ax
  801d50:	89 d8                	mov    %ebx,%eax
  801d52:	f7 f7                	div    %edi
  801d54:	31 ff                	xor    %edi,%edi
  801d56:	89 fa                	mov    %edi,%edx
  801d58:	83 c4 1c             	add    $0x1c,%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5f                   	pop    %edi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    
  801d60:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d65:	89 eb                	mov    %ebp,%ebx
  801d67:	29 fb                	sub    %edi,%ebx
  801d69:	89 f9                	mov    %edi,%ecx
  801d6b:	d3 e6                	shl    %cl,%esi
  801d6d:	89 c5                	mov    %eax,%ebp
  801d6f:	88 d9                	mov    %bl,%cl
  801d71:	d3 ed                	shr    %cl,%ebp
  801d73:	89 e9                	mov    %ebp,%ecx
  801d75:	09 f1                	or     %esi,%ecx
  801d77:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d7b:	89 f9                	mov    %edi,%ecx
  801d7d:	d3 e0                	shl    %cl,%eax
  801d7f:	89 c5                	mov    %eax,%ebp
  801d81:	89 d6                	mov    %edx,%esi
  801d83:	88 d9                	mov    %bl,%cl
  801d85:	d3 ee                	shr    %cl,%esi
  801d87:	89 f9                	mov    %edi,%ecx
  801d89:	d3 e2                	shl    %cl,%edx
  801d8b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d8f:	88 d9                	mov    %bl,%cl
  801d91:	d3 e8                	shr    %cl,%eax
  801d93:	09 c2                	or     %eax,%edx
  801d95:	89 d0                	mov    %edx,%eax
  801d97:	89 f2                	mov    %esi,%edx
  801d99:	f7 74 24 0c          	divl   0xc(%esp)
  801d9d:	89 d6                	mov    %edx,%esi
  801d9f:	89 c3                	mov    %eax,%ebx
  801da1:	f7 e5                	mul    %ebp
  801da3:	39 d6                	cmp    %edx,%esi
  801da5:	72 19                	jb     801dc0 <__udivdi3+0xfc>
  801da7:	74 0b                	je     801db4 <__udivdi3+0xf0>
  801da9:	89 d8                	mov    %ebx,%eax
  801dab:	31 ff                	xor    %edi,%edi
  801dad:	e9 58 ff ff ff       	jmp    801d0a <__udivdi3+0x46>
  801db2:	66 90                	xchg   %ax,%ax
  801db4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801db8:	89 f9                	mov    %edi,%ecx
  801dba:	d3 e2                	shl    %cl,%edx
  801dbc:	39 c2                	cmp    %eax,%edx
  801dbe:	73 e9                	jae    801da9 <__udivdi3+0xe5>
  801dc0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dc3:	31 ff                	xor    %edi,%edi
  801dc5:	e9 40 ff ff ff       	jmp    801d0a <__udivdi3+0x46>
  801dca:	66 90                	xchg   %ax,%ax
  801dcc:	31 c0                	xor    %eax,%eax
  801dce:	e9 37 ff ff ff       	jmp    801d0a <__udivdi3+0x46>
  801dd3:	90                   	nop

00801dd4 <__umoddi3>:
  801dd4:	55                   	push   %ebp
  801dd5:	57                   	push   %edi
  801dd6:	56                   	push   %esi
  801dd7:	53                   	push   %ebx
  801dd8:	83 ec 1c             	sub    $0x1c,%esp
  801ddb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ddf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801de3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801de7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801deb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801def:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801df3:	89 f3                	mov    %esi,%ebx
  801df5:	89 fa                	mov    %edi,%edx
  801df7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dfb:	89 34 24             	mov    %esi,(%esp)
  801dfe:	85 c0                	test   %eax,%eax
  801e00:	75 1a                	jne    801e1c <__umoddi3+0x48>
  801e02:	39 f7                	cmp    %esi,%edi
  801e04:	0f 86 a2 00 00 00    	jbe    801eac <__umoddi3+0xd8>
  801e0a:	89 c8                	mov    %ecx,%eax
  801e0c:	89 f2                	mov    %esi,%edx
  801e0e:	f7 f7                	div    %edi
  801e10:	89 d0                	mov    %edx,%eax
  801e12:	31 d2                	xor    %edx,%edx
  801e14:	83 c4 1c             	add    $0x1c,%esp
  801e17:	5b                   	pop    %ebx
  801e18:	5e                   	pop    %esi
  801e19:	5f                   	pop    %edi
  801e1a:	5d                   	pop    %ebp
  801e1b:	c3                   	ret    
  801e1c:	39 f0                	cmp    %esi,%eax
  801e1e:	0f 87 ac 00 00 00    	ja     801ed0 <__umoddi3+0xfc>
  801e24:	0f bd e8             	bsr    %eax,%ebp
  801e27:	83 f5 1f             	xor    $0x1f,%ebp
  801e2a:	0f 84 ac 00 00 00    	je     801edc <__umoddi3+0x108>
  801e30:	bf 20 00 00 00       	mov    $0x20,%edi
  801e35:	29 ef                	sub    %ebp,%edi
  801e37:	89 fe                	mov    %edi,%esi
  801e39:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e3d:	89 e9                	mov    %ebp,%ecx
  801e3f:	d3 e0                	shl    %cl,%eax
  801e41:	89 d7                	mov    %edx,%edi
  801e43:	89 f1                	mov    %esi,%ecx
  801e45:	d3 ef                	shr    %cl,%edi
  801e47:	09 c7                	or     %eax,%edi
  801e49:	89 e9                	mov    %ebp,%ecx
  801e4b:	d3 e2                	shl    %cl,%edx
  801e4d:	89 14 24             	mov    %edx,(%esp)
  801e50:	89 d8                	mov    %ebx,%eax
  801e52:	d3 e0                	shl    %cl,%eax
  801e54:	89 c2                	mov    %eax,%edx
  801e56:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e5a:	d3 e0                	shl    %cl,%eax
  801e5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e60:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e64:	89 f1                	mov    %esi,%ecx
  801e66:	d3 e8                	shr    %cl,%eax
  801e68:	09 d0                	or     %edx,%eax
  801e6a:	d3 eb                	shr    %cl,%ebx
  801e6c:	89 da                	mov    %ebx,%edx
  801e6e:	f7 f7                	div    %edi
  801e70:	89 d3                	mov    %edx,%ebx
  801e72:	f7 24 24             	mull   (%esp)
  801e75:	89 c6                	mov    %eax,%esi
  801e77:	89 d1                	mov    %edx,%ecx
  801e79:	39 d3                	cmp    %edx,%ebx
  801e7b:	0f 82 87 00 00 00    	jb     801f08 <__umoddi3+0x134>
  801e81:	0f 84 91 00 00 00    	je     801f18 <__umoddi3+0x144>
  801e87:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e8b:	29 f2                	sub    %esi,%edx
  801e8d:	19 cb                	sbb    %ecx,%ebx
  801e8f:	89 d8                	mov    %ebx,%eax
  801e91:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e95:	d3 e0                	shl    %cl,%eax
  801e97:	89 e9                	mov    %ebp,%ecx
  801e99:	d3 ea                	shr    %cl,%edx
  801e9b:	09 d0                	or     %edx,%eax
  801e9d:	89 e9                	mov    %ebp,%ecx
  801e9f:	d3 eb                	shr    %cl,%ebx
  801ea1:	89 da                	mov    %ebx,%edx
  801ea3:	83 c4 1c             	add    $0x1c,%esp
  801ea6:	5b                   	pop    %ebx
  801ea7:	5e                   	pop    %esi
  801ea8:	5f                   	pop    %edi
  801ea9:	5d                   	pop    %ebp
  801eaa:	c3                   	ret    
  801eab:	90                   	nop
  801eac:	89 fd                	mov    %edi,%ebp
  801eae:	85 ff                	test   %edi,%edi
  801eb0:	75 0b                	jne    801ebd <__umoddi3+0xe9>
  801eb2:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb7:	31 d2                	xor    %edx,%edx
  801eb9:	f7 f7                	div    %edi
  801ebb:	89 c5                	mov    %eax,%ebp
  801ebd:	89 f0                	mov    %esi,%eax
  801ebf:	31 d2                	xor    %edx,%edx
  801ec1:	f7 f5                	div    %ebp
  801ec3:	89 c8                	mov    %ecx,%eax
  801ec5:	f7 f5                	div    %ebp
  801ec7:	89 d0                	mov    %edx,%eax
  801ec9:	e9 44 ff ff ff       	jmp    801e12 <__umoddi3+0x3e>
  801ece:	66 90                	xchg   %ax,%ax
  801ed0:	89 c8                	mov    %ecx,%eax
  801ed2:	89 f2                	mov    %esi,%edx
  801ed4:	83 c4 1c             	add    $0x1c,%esp
  801ed7:	5b                   	pop    %ebx
  801ed8:	5e                   	pop    %esi
  801ed9:	5f                   	pop    %edi
  801eda:	5d                   	pop    %ebp
  801edb:	c3                   	ret    
  801edc:	3b 04 24             	cmp    (%esp),%eax
  801edf:	72 06                	jb     801ee7 <__umoddi3+0x113>
  801ee1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ee5:	77 0f                	ja     801ef6 <__umoddi3+0x122>
  801ee7:	89 f2                	mov    %esi,%edx
  801ee9:	29 f9                	sub    %edi,%ecx
  801eeb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eef:	89 14 24             	mov    %edx,(%esp)
  801ef2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ef6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801efa:	8b 14 24             	mov    (%esp),%edx
  801efd:	83 c4 1c             	add    $0x1c,%esp
  801f00:	5b                   	pop    %ebx
  801f01:	5e                   	pop    %esi
  801f02:	5f                   	pop    %edi
  801f03:	5d                   	pop    %ebp
  801f04:	c3                   	ret    
  801f05:	8d 76 00             	lea    0x0(%esi),%esi
  801f08:	2b 04 24             	sub    (%esp),%eax
  801f0b:	19 fa                	sbb    %edi,%edx
  801f0d:	89 d1                	mov    %edx,%ecx
  801f0f:	89 c6                	mov    %eax,%esi
  801f11:	e9 71 ff ff ff       	jmp    801e87 <__umoddi3+0xb3>
  801f16:	66 90                	xchg   %ax,%ax
  801f18:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f1c:	72 ea                	jb     801f08 <__umoddi3+0x134>
  801f1e:	89 d9                	mov    %ebx,%ecx
  801f20:	e9 62 ff ff ff       	jmp    801e87 <__umoddi3+0xb3>
