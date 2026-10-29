
obj/user/sc_helloWorld:     file format elf32-i386


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
  800031:	e8 36 00 00 00       	call   80006c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 60 1c 80 00       	push   $0x801c60
  800046:	e8 d3 03 00 00       	call   80041e <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 55 1c 80 00       	mov    0x801c55,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 88 1c 80 00       	push   $0x801c88
  80005c:	e8 bd 03 00 00       	call   80041e <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp

	inctst();
  800064:	e8 17 16 00 00       	call   801680 <inctst>
}
  800069:	90                   	nop
  80006a:	c9                   	leave  
  80006b:	c3                   	ret    

0080006c <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80006c:	55                   	push   %ebp
  80006d:	89 e5                	mov    %esp,%ebp
  80006f:	57                   	push   %edi
  800070:	56                   	push   %esi
  800071:	53                   	push   %ebx
  800072:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800078:	e8 fb 14 00 00       	call   801578 <sys_getenvindex>
  80007d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800080:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800083:	89 d0                	mov    %edx,%eax
  800085:	c1 e0 03             	shl    $0x3,%eax
  800088:	01 d0                	add    %edx,%eax
  80008a:	c1 e0 06             	shl    $0x6,%eax
  80008d:	01 d0                	add    %edx,%eax
  80008f:	c1 e0 03             	shl    $0x3,%eax
  800092:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800097:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80009c:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a1:	8a 40 10             	mov    0x10(%eax),%al
  8000a4:	84 c0                	test   %al,%al
  8000a6:	74 0d                	je     8000b5 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	83 c0 10             	add    $0x10,%eax
  8000b0:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000b9:	7e 0a                	jle    8000c5 <libmain+0x59>
		binaryname = argv[0];
  8000bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000be:	8b 00                	mov    (%eax),%eax
  8000c0:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000c5:	83 ec 08             	sub    $0x8,%esp
  8000c8:	ff 75 0c             	pushl  0xc(%ebp)
  8000cb:	ff 75 08             	pushl  0x8(%ebp)
  8000ce:	e8 65 ff ff ff       	call   800038 <_main>
  8000d3:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000d6:	a1 00 30 80 00       	mov    0x803000,%eax
  8000db:	85 c0                	test   %eax,%eax
  8000dd:	0f 84 b7 01 00 00    	je     80029a <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000e3:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000e9:	bb d8 1d 80 00       	mov    $0x801dd8,%ebx
  8000ee:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000f3:	89 c7                	mov    %eax,%edi
  8000f5:	89 de                	mov    %ebx,%esi
  8000f7:	89 d1                	mov    %edx,%ecx
  8000f9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000fb:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800101:	b9 56 00 00 00       	mov    $0x56,%ecx
  800106:	b0 00                	mov    $0x0,%al
  800108:	89 d7                	mov    %edx,%edi
  80010a:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80010c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800113:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800116:	83 ec 08             	sub    $0x8,%esp
  800119:	50                   	push   %eax
  80011a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800120:	50                   	push   %eax
  800121:	e8 52 16 00 00       	call   801778 <sys_utilities>
  800126:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800129:	e8 d2 11 00 00       	call   801300 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80012e:	83 ec 0c             	sub    $0xc,%esp
  800131:	68 b4 1c 80 00       	push   $0x801cb4
  800136:	e8 71 02 00 00       	call   8003ac <cprintf>
  80013b:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80013e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800141:	85 c0                	test   %eax,%eax
  800143:	74 58                	je     80019d <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800145:	e8 4c 16 00 00       	call   801796 <sys_get_optimal_num_faults>
  80014a:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80014d:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800153:	bb 3c 1e 80 00       	mov    $0x801e3c,%ebx
  800158:	ba 11 00 00 00       	mov    $0x11,%edx
  80015d:	89 c7                	mov    %eax,%edi
  80015f:	89 de                	mov    %ebx,%esi
  800161:	89 d1                	mov    %edx,%ecx
  800163:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800165:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800168:	b9 53 00 00 00       	mov    $0x53,%ecx
  80016d:	b0 00                	mov    $0x0,%al
  80016f:	89 d7                	mov    %edx,%edi
  800171:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	ff 75 dc             	pushl  -0x24(%ebp)
  800179:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80017f:	50                   	push   %eax
  800180:	e8 f3 15 00 00       	call   801778 <sys_utilities>
  800185:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800188:	83 ec 08             	sub    $0x8,%esp
  80018b:	ff 75 dc             	pushl  -0x24(%ebp)
  80018e:	68 dc 1c 80 00       	push   $0x801cdc
  800193:	e8 14 02 00 00       	call   8003ac <cprintf>
  800198:	83 c4 10             	add    $0x10,%esp
  80019b:	eb 59                	jmp    8001f6 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80019d:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a2:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ad:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001b3:	83 ec 04             	sub    $0x4,%esp
  8001b6:	52                   	push   %edx
  8001b7:	50                   	push   %eax
  8001b8:	68 00 1d 80 00       	push   $0x801d00
  8001bd:	e8 ea 01 00 00       	call   8003ac <cprintf>
  8001c2:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ca:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d5:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001db:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e0:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001e6:	51                   	push   %ecx
  8001e7:	52                   	push   %edx
  8001e8:	50                   	push   %eax
  8001e9:	68 28 1d 80 00       	push   $0x801d28
  8001ee:	e8 b9 01 00 00       	call   8003ac <cprintf>
  8001f3:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fb:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800201:	83 ec 08             	sub    $0x8,%esp
  800204:	50                   	push   %eax
  800205:	68 80 1d 80 00       	push   $0x801d80
  80020a:	e8 9d 01 00 00       	call   8003ac <cprintf>
  80020f:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800212:	83 ec 0c             	sub    $0xc,%esp
  800215:	68 94 1d 80 00       	push   $0x801d94
  80021a:	e8 8d 01 00 00       	call   8003ac <cprintf>
  80021f:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800222:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800229:	eb 28                	jmp    800253 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800233:	81 c2 74 04 00 00    	add    $0x474,%edx
  800239:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	50                   	push   %eax
  800240:	ff 75 e4             	pushl  -0x1c(%ebp)
  800243:	68 ab 1d 80 00       	push   $0x801dab
  800248:	e8 5f 01 00 00       	call   8003ac <cprintf>
  80024d:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800250:	ff 45 e4             	incl   -0x1c(%ebp)
  800253:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800257:	7e d2                	jle    80022b <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	68 ba 1d 80 00       	push   $0x801dba
  800261:	e8 46 01 00 00       	call   8003ac <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800274:	83 ec 08             	sub    $0x8,%esp
  800277:	50                   	push   %eax
  800278:	68 be 1d 80 00       	push   $0x801dbe
  80027d:	e8 2a 01 00 00       	call   8003ac <cprintf>
  800282:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	68 b4 1c 80 00       	push   $0x801cb4
  80028d:	e8 1a 01 00 00       	call   8003ac <cprintf>
  800292:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800295:	e8 80 10 00 00       	call   80131a <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80029a:	e8 1f 00 00 00       	call   8002be <exit>
}
  80029f:	90                   	nop
  8002a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002a3:	5b                   	pop    %ebx
  8002a4:	5e                   	pop    %esi
  8002a5:	5f                   	pop    %edi
  8002a6:	5d                   	pop    %ebp
  8002a7:	c3                   	ret    

008002a8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002a8:	55                   	push   %ebp
  8002a9:	89 e5                	mov    %esp,%ebp
  8002ab:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002ae:	83 ec 0c             	sub    $0xc,%esp
  8002b1:	6a 00                	push   $0x0
  8002b3:	e8 8c 12 00 00       	call   801544 <sys_destroy_env>
  8002b8:	83 c4 10             	add    $0x10,%esp
}
  8002bb:	90                   	nop
  8002bc:	c9                   	leave  
  8002bd:	c3                   	ret    

008002be <exit>:

void
exit(void)
{
  8002be:	55                   	push   %ebp
  8002bf:	89 e5                	mov    %esp,%ebp
  8002c1:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002c4:	e8 e1 12 00 00       	call   8015aa <sys_exit_env>
}
  8002c9:	90                   	nop
  8002ca:	c9                   	leave  
  8002cb:	c3                   	ret    

008002cc <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8002cc:	55                   	push   %ebp
  8002cd:	89 e5                	mov    %esp,%ebp
  8002cf:	53                   	push   %ebx
  8002d0:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8002d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d6:	8b 00                	mov    (%eax),%eax
  8002d8:	8d 48 01             	lea    0x1(%eax),%ecx
  8002db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002de:	89 0a                	mov    %ecx,(%edx)
  8002e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8002e3:	88 d1                	mov    %dl,%cl
  8002e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ef:	8b 00                	mov    (%eax),%eax
  8002f1:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002f6:	75 30                	jne    800328 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8002f8:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8002fe:	a0 40 30 80 00       	mov    0x803040,%al
  800303:	0f b6 c0             	movzbl %al,%eax
  800306:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800309:	8b 09                	mov    (%ecx),%ecx
  80030b:	89 cb                	mov    %ecx,%ebx
  80030d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800310:	83 c1 08             	add    $0x8,%ecx
  800313:	52                   	push   %edx
  800314:	50                   	push   %eax
  800315:	53                   	push   %ebx
  800316:	51                   	push   %ecx
  800317:	e8 a0 0f 00 00       	call   8012bc <sys_cputs>
  80031c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80031f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800322:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	8b 40 04             	mov    0x4(%eax),%eax
  80032e:	8d 50 01             	lea    0x1(%eax),%edx
  800331:	8b 45 0c             	mov    0xc(%ebp),%eax
  800334:	89 50 04             	mov    %edx,0x4(%eax)
}
  800337:	90                   	nop
  800338:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80033b:	c9                   	leave  
  80033c:	c3                   	ret    

0080033d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80033d:	55                   	push   %ebp
  80033e:	89 e5                	mov    %esp,%ebp
  800340:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800346:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80034d:	00 00 00 
	b.cnt = 0;
  800350:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800357:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80035a:	ff 75 0c             	pushl  0xc(%ebp)
  80035d:	ff 75 08             	pushl  0x8(%ebp)
  800360:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800366:	50                   	push   %eax
  800367:	68 cc 02 80 00       	push   $0x8002cc
  80036c:	e8 5a 02 00 00       	call   8005cb <vprintfmt>
  800371:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800374:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80037a:	a0 40 30 80 00       	mov    0x803040,%al
  80037f:	0f b6 c0             	movzbl %al,%eax
  800382:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800388:	52                   	push   %edx
  800389:	50                   	push   %eax
  80038a:	51                   	push   %ecx
  80038b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800391:	83 c0 08             	add    $0x8,%eax
  800394:	50                   	push   %eax
  800395:	e8 22 0f 00 00       	call   8012bc <sys_cputs>
  80039a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80039d:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8003a4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003aa:	c9                   	leave  
  8003ab:	c3                   	ret    

008003ac <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8003ac:	55                   	push   %ebp
  8003ad:	89 e5                	mov    %esp,%ebp
  8003af:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003b2:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8003b9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	83 ec 08             	sub    $0x8,%esp
  8003c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c8:	50                   	push   %eax
  8003c9:	e8 6f ff ff ff       	call   80033d <vcprintf>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003d7:	c9                   	leave  
  8003d8:	c3                   	ret    

008003d9 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8003d9:	55                   	push   %ebp
  8003da:	89 e5                	mov    %esp,%ebp
  8003dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003df:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8003e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e9:	c1 e0 08             	shl    $0x8,%eax
  8003ec:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8003f1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003f4:	83 c0 04             	add    $0x4,%eax
  8003f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fd:	83 ec 08             	sub    $0x8,%esp
  800400:	ff 75 f4             	pushl  -0xc(%ebp)
  800403:	50                   	push   %eax
  800404:	e8 34 ff ff ff       	call   80033d <vcprintf>
  800409:	83 c4 10             	add    $0x10,%esp
  80040c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80040f:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800416:	07 00 00 

	return cnt;
  800419:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80041c:	c9                   	leave  
  80041d:	c3                   	ret    

0080041e <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80041e:	55                   	push   %ebp
  80041f:	89 e5                	mov    %esp,%ebp
  800421:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800424:	e8 d7 0e 00 00       	call   801300 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800429:	8d 45 0c             	lea    0xc(%ebp),%eax
  80042c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80042f:	8b 45 08             	mov    0x8(%ebp),%eax
  800432:	83 ec 08             	sub    $0x8,%esp
  800435:	ff 75 f4             	pushl  -0xc(%ebp)
  800438:	50                   	push   %eax
  800439:	e8 ff fe ff ff       	call   80033d <vcprintf>
  80043e:	83 c4 10             	add    $0x10,%esp
  800441:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800444:	e8 d1 0e 00 00       	call   80131a <sys_unlock_cons>
	return cnt;
  800449:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80044c:	c9                   	leave  
  80044d:	c3                   	ret    

0080044e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80044e:	55                   	push   %ebp
  80044f:	89 e5                	mov    %esp,%ebp
  800451:	53                   	push   %ebx
  800452:	83 ec 14             	sub    $0x14,%esp
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80045b:	8b 45 14             	mov    0x14(%ebp),%eax
  80045e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800461:	8b 45 18             	mov    0x18(%ebp),%eax
  800464:	ba 00 00 00 00       	mov    $0x0,%edx
  800469:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80046c:	77 55                	ja     8004c3 <printnum+0x75>
  80046e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800471:	72 05                	jb     800478 <printnum+0x2a>
  800473:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800476:	77 4b                	ja     8004c3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800478:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80047b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80047e:	8b 45 18             	mov    0x18(%ebp),%eax
  800481:	ba 00 00 00 00       	mov    $0x0,%edx
  800486:	52                   	push   %edx
  800487:	50                   	push   %eax
  800488:	ff 75 f4             	pushl  -0xc(%ebp)
  80048b:	ff 75 f0             	pushl  -0x10(%ebp)
  80048e:	e8 61 15 00 00       	call   8019f4 <__udivdi3>
  800493:	83 c4 10             	add    $0x10,%esp
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	ff 75 20             	pushl  0x20(%ebp)
  80049c:	53                   	push   %ebx
  80049d:	ff 75 18             	pushl  0x18(%ebp)
  8004a0:	52                   	push   %edx
  8004a1:	50                   	push   %eax
  8004a2:	ff 75 0c             	pushl  0xc(%ebp)
  8004a5:	ff 75 08             	pushl  0x8(%ebp)
  8004a8:	e8 a1 ff ff ff       	call   80044e <printnum>
  8004ad:	83 c4 20             	add    $0x20,%esp
  8004b0:	eb 1a                	jmp    8004cc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004b2:	83 ec 08             	sub    $0x8,%esp
  8004b5:	ff 75 0c             	pushl  0xc(%ebp)
  8004b8:	ff 75 20             	pushl  0x20(%ebp)
  8004bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004be:	ff d0                	call   *%eax
  8004c0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004c3:	ff 4d 1c             	decl   0x1c(%ebp)
  8004c6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004ca:	7f e6                	jg     8004b2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004cc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004cf:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004da:	53                   	push   %ebx
  8004db:	51                   	push   %ecx
  8004dc:	52                   	push   %edx
  8004dd:	50                   	push   %eax
  8004de:	e8 21 16 00 00       	call   801b04 <__umoddi3>
  8004e3:	83 c4 10             	add    $0x10,%esp
  8004e6:	05 b4 20 80 00       	add    $0x8020b4,%eax
  8004eb:	8a 00                	mov    (%eax),%al
  8004ed:	0f be c0             	movsbl %al,%eax
  8004f0:	83 ec 08             	sub    $0x8,%esp
  8004f3:	ff 75 0c             	pushl  0xc(%ebp)
  8004f6:	50                   	push   %eax
  8004f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fa:	ff d0                	call   *%eax
  8004fc:	83 c4 10             	add    $0x10,%esp
}
  8004ff:	90                   	nop
  800500:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800503:	c9                   	leave  
  800504:	c3                   	ret    

00800505 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800505:	55                   	push   %ebp
  800506:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800508:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80050c:	7e 1c                	jle    80052a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80050e:	8b 45 08             	mov    0x8(%ebp),%eax
  800511:	8b 00                	mov    (%eax),%eax
  800513:	8d 50 08             	lea    0x8(%eax),%edx
  800516:	8b 45 08             	mov    0x8(%ebp),%eax
  800519:	89 10                	mov    %edx,(%eax)
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	83 e8 08             	sub    $0x8,%eax
  800523:	8b 50 04             	mov    0x4(%eax),%edx
  800526:	8b 00                	mov    (%eax),%eax
  800528:	eb 40                	jmp    80056a <getuint+0x65>
	else if (lflag)
  80052a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80052e:	74 1e                	je     80054e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800530:	8b 45 08             	mov    0x8(%ebp),%eax
  800533:	8b 00                	mov    (%eax),%eax
  800535:	8d 50 04             	lea    0x4(%eax),%edx
  800538:	8b 45 08             	mov    0x8(%ebp),%eax
  80053b:	89 10                	mov    %edx,(%eax)
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	83 e8 04             	sub    $0x4,%eax
  800545:	8b 00                	mov    (%eax),%eax
  800547:	ba 00 00 00 00       	mov    $0x0,%edx
  80054c:	eb 1c                	jmp    80056a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80054e:	8b 45 08             	mov    0x8(%ebp),%eax
  800551:	8b 00                	mov    (%eax),%eax
  800553:	8d 50 04             	lea    0x4(%eax),%edx
  800556:	8b 45 08             	mov    0x8(%ebp),%eax
  800559:	89 10                	mov    %edx,(%eax)
  80055b:	8b 45 08             	mov    0x8(%ebp),%eax
  80055e:	8b 00                	mov    (%eax),%eax
  800560:	83 e8 04             	sub    $0x4,%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80056a:	5d                   	pop    %ebp
  80056b:	c3                   	ret    

0080056c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80056c:	55                   	push   %ebp
  80056d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80056f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800573:	7e 1c                	jle    800591 <getint+0x25>
		return va_arg(*ap, long long);
  800575:	8b 45 08             	mov    0x8(%ebp),%eax
  800578:	8b 00                	mov    (%eax),%eax
  80057a:	8d 50 08             	lea    0x8(%eax),%edx
  80057d:	8b 45 08             	mov    0x8(%ebp),%eax
  800580:	89 10                	mov    %edx,(%eax)
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	8b 00                	mov    (%eax),%eax
  800587:	83 e8 08             	sub    $0x8,%eax
  80058a:	8b 50 04             	mov    0x4(%eax),%edx
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	eb 38                	jmp    8005c9 <getint+0x5d>
	else if (lflag)
  800591:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800595:	74 1a                	je     8005b1 <getint+0x45>
		return va_arg(*ap, long);
  800597:	8b 45 08             	mov    0x8(%ebp),%eax
  80059a:	8b 00                	mov    (%eax),%eax
  80059c:	8d 50 04             	lea    0x4(%eax),%edx
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	89 10                	mov    %edx,(%eax)
  8005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	83 e8 04             	sub    $0x4,%eax
  8005ac:	8b 00                	mov    (%eax),%eax
  8005ae:	99                   	cltd   
  8005af:	eb 18                	jmp    8005c9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	8d 50 04             	lea    0x4(%eax),%edx
  8005b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bc:	89 10                	mov    %edx,(%eax)
  8005be:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	83 e8 04             	sub    $0x4,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	99                   	cltd   
}
  8005c9:	5d                   	pop    %ebp
  8005ca:	c3                   	ret    

008005cb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005cb:	55                   	push   %ebp
  8005cc:	89 e5                	mov    %esp,%ebp
  8005ce:	56                   	push   %esi
  8005cf:	53                   	push   %ebx
  8005d0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005d3:	eb 17                	jmp    8005ec <vprintfmt+0x21>
			if (ch == '\0')
  8005d5:	85 db                	test   %ebx,%ebx
  8005d7:	0f 84 c1 03 00 00    	je     80099e <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8005dd:	83 ec 08             	sub    $0x8,%esp
  8005e0:	ff 75 0c             	pushl  0xc(%ebp)
  8005e3:	53                   	push   %ebx
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	ff d0                	call   *%eax
  8005e9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ef:	8d 50 01             	lea    0x1(%eax),%edx
  8005f2:	89 55 10             	mov    %edx,0x10(%ebp)
  8005f5:	8a 00                	mov    (%eax),%al
  8005f7:	0f b6 d8             	movzbl %al,%ebx
  8005fa:	83 fb 25             	cmp    $0x25,%ebx
  8005fd:	75 d6                	jne    8005d5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005ff:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800603:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80060a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800611:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800618:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80061f:	8b 45 10             	mov    0x10(%ebp),%eax
  800622:	8d 50 01             	lea    0x1(%eax),%edx
  800625:	89 55 10             	mov    %edx,0x10(%ebp)
  800628:	8a 00                	mov    (%eax),%al
  80062a:	0f b6 d8             	movzbl %al,%ebx
  80062d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800630:	83 f8 5b             	cmp    $0x5b,%eax
  800633:	0f 87 3d 03 00 00    	ja     800976 <vprintfmt+0x3ab>
  800639:	8b 04 85 d8 20 80 00 	mov    0x8020d8(,%eax,4),%eax
  800640:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800642:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800646:	eb d7                	jmp    80061f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800648:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80064c:	eb d1                	jmp    80061f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80064e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800655:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800658:	89 d0                	mov    %edx,%eax
  80065a:	c1 e0 02             	shl    $0x2,%eax
  80065d:	01 d0                	add    %edx,%eax
  80065f:	01 c0                	add    %eax,%eax
  800661:	01 d8                	add    %ebx,%eax
  800663:	83 e8 30             	sub    $0x30,%eax
  800666:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800669:	8b 45 10             	mov    0x10(%ebp),%eax
  80066c:	8a 00                	mov    (%eax),%al
  80066e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800671:	83 fb 2f             	cmp    $0x2f,%ebx
  800674:	7e 3e                	jle    8006b4 <vprintfmt+0xe9>
  800676:	83 fb 39             	cmp    $0x39,%ebx
  800679:	7f 39                	jg     8006b4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80067b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80067e:	eb d5                	jmp    800655 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800680:	8b 45 14             	mov    0x14(%ebp),%eax
  800683:	83 c0 04             	add    $0x4,%eax
  800686:	89 45 14             	mov    %eax,0x14(%ebp)
  800689:	8b 45 14             	mov    0x14(%ebp),%eax
  80068c:	83 e8 04             	sub    $0x4,%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800694:	eb 1f                	jmp    8006b5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800696:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80069a:	79 83                	jns    80061f <vprintfmt+0x54>
				width = 0;
  80069c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006a3:	e9 77 ff ff ff       	jmp    80061f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006a8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006af:	e9 6b ff ff ff       	jmp    80061f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006b4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006b5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b9:	0f 89 60 ff ff ff    	jns    80061f <vprintfmt+0x54>
				width = precision, precision = -1;
  8006bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006c5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006cc:	e9 4e ff ff ff       	jmp    80061f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006d1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006d4:	e9 46 ff ff ff       	jmp    80061f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006dc:	83 c0 04             	add    $0x4,%eax
  8006df:	89 45 14             	mov    %eax,0x14(%ebp)
  8006e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e5:	83 e8 04             	sub    $0x4,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	83 ec 08             	sub    $0x8,%esp
  8006ed:	ff 75 0c             	pushl  0xc(%ebp)
  8006f0:	50                   	push   %eax
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
			break;
  8006f9:	e9 9b 02 00 00       	jmp    800999 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800701:	83 c0 04             	add    $0x4,%eax
  800704:	89 45 14             	mov    %eax,0x14(%ebp)
  800707:	8b 45 14             	mov    0x14(%ebp),%eax
  80070a:	83 e8 04             	sub    $0x4,%eax
  80070d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80070f:	85 db                	test   %ebx,%ebx
  800711:	79 02                	jns    800715 <vprintfmt+0x14a>
				err = -err;
  800713:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800715:	83 fb 64             	cmp    $0x64,%ebx
  800718:	7f 0b                	jg     800725 <vprintfmt+0x15a>
  80071a:	8b 34 9d 20 1f 80 00 	mov    0x801f20(,%ebx,4),%esi
  800721:	85 f6                	test   %esi,%esi
  800723:	75 19                	jne    80073e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800725:	53                   	push   %ebx
  800726:	68 c5 20 80 00       	push   $0x8020c5
  80072b:	ff 75 0c             	pushl  0xc(%ebp)
  80072e:	ff 75 08             	pushl  0x8(%ebp)
  800731:	e8 70 02 00 00       	call   8009a6 <printfmt>
  800736:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800739:	e9 5b 02 00 00       	jmp    800999 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80073e:	56                   	push   %esi
  80073f:	68 ce 20 80 00       	push   $0x8020ce
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	ff 75 08             	pushl  0x8(%ebp)
  80074a:	e8 57 02 00 00       	call   8009a6 <printfmt>
  80074f:	83 c4 10             	add    $0x10,%esp
			break;
  800752:	e9 42 02 00 00       	jmp    800999 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800757:	8b 45 14             	mov    0x14(%ebp),%eax
  80075a:	83 c0 04             	add    $0x4,%eax
  80075d:	89 45 14             	mov    %eax,0x14(%ebp)
  800760:	8b 45 14             	mov    0x14(%ebp),%eax
  800763:	83 e8 04             	sub    $0x4,%eax
  800766:	8b 30                	mov    (%eax),%esi
  800768:	85 f6                	test   %esi,%esi
  80076a:	75 05                	jne    800771 <vprintfmt+0x1a6>
				p = "(null)";
  80076c:	be d1 20 80 00       	mov    $0x8020d1,%esi
			if (width > 0 && padc != '-')
  800771:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800775:	7e 6d                	jle    8007e4 <vprintfmt+0x219>
  800777:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80077b:	74 67                	je     8007e4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80077d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	50                   	push   %eax
  800784:	56                   	push   %esi
  800785:	e8 1e 03 00 00       	call   800aa8 <strnlen>
  80078a:	83 c4 10             	add    $0x10,%esp
  80078d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800790:	eb 16                	jmp    8007a8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800792:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	50                   	push   %eax
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007a5:	ff 4d e4             	decl   -0x1c(%ebp)
  8007a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ac:	7f e4                	jg     800792 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007ae:	eb 34                	jmp    8007e4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007b0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007b4:	74 1c                	je     8007d2 <vprintfmt+0x207>
  8007b6:	83 fb 1f             	cmp    $0x1f,%ebx
  8007b9:	7e 05                	jle    8007c0 <vprintfmt+0x1f5>
  8007bb:	83 fb 7e             	cmp    $0x7e,%ebx
  8007be:	7e 12                	jle    8007d2 <vprintfmt+0x207>
					putch('?', putdat);
  8007c0:	83 ec 08             	sub    $0x8,%esp
  8007c3:	ff 75 0c             	pushl  0xc(%ebp)
  8007c6:	6a 3f                	push   $0x3f
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
  8007d0:	eb 0f                	jmp    8007e1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007d2:	83 ec 08             	sub    $0x8,%esp
  8007d5:	ff 75 0c             	pushl  0xc(%ebp)
  8007d8:	53                   	push   %ebx
  8007d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dc:	ff d0                	call   *%eax
  8007de:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007e1:	ff 4d e4             	decl   -0x1c(%ebp)
  8007e4:	89 f0                	mov    %esi,%eax
  8007e6:	8d 70 01             	lea    0x1(%eax),%esi
  8007e9:	8a 00                	mov    (%eax),%al
  8007eb:	0f be d8             	movsbl %al,%ebx
  8007ee:	85 db                	test   %ebx,%ebx
  8007f0:	74 24                	je     800816 <vprintfmt+0x24b>
  8007f2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007f6:	78 b8                	js     8007b0 <vprintfmt+0x1e5>
  8007f8:	ff 4d e0             	decl   -0x20(%ebp)
  8007fb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007ff:	79 af                	jns    8007b0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800801:	eb 13                	jmp    800816 <vprintfmt+0x24b>
				putch(' ', putdat);
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	6a 20                	push   $0x20
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	ff d0                	call   *%eax
  800810:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800813:	ff 4d e4             	decl   -0x1c(%ebp)
  800816:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80081a:	7f e7                	jg     800803 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80081c:	e9 78 01 00 00       	jmp    800999 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 e8             	pushl  -0x18(%ebp)
  800827:	8d 45 14             	lea    0x14(%ebp),%eax
  80082a:	50                   	push   %eax
  80082b:	e8 3c fd ff ff       	call   80056c <getint>
  800830:	83 c4 10             	add    $0x10,%esp
  800833:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800836:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800839:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80083f:	85 d2                	test   %edx,%edx
  800841:	79 23                	jns    800866 <vprintfmt+0x29b>
				putch('-', putdat);
  800843:	83 ec 08             	sub    $0x8,%esp
  800846:	ff 75 0c             	pushl  0xc(%ebp)
  800849:	6a 2d                	push   $0x2d
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	ff d0                	call   *%eax
  800850:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800853:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800856:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800859:	f7 d8                	neg    %eax
  80085b:	83 d2 00             	adc    $0x0,%edx
  80085e:	f7 da                	neg    %edx
  800860:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800863:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800866:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80086d:	e9 bc 00 00 00       	jmp    80092e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800872:	83 ec 08             	sub    $0x8,%esp
  800875:	ff 75 e8             	pushl  -0x18(%ebp)
  800878:	8d 45 14             	lea    0x14(%ebp),%eax
  80087b:	50                   	push   %eax
  80087c:	e8 84 fc ff ff       	call   800505 <getuint>
  800881:	83 c4 10             	add    $0x10,%esp
  800884:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800887:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80088a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800891:	e9 98 00 00 00       	jmp    80092e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	6a 58                	push   $0x58
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	ff d0                	call   *%eax
  8008a3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008a6:	83 ec 08             	sub    $0x8,%esp
  8008a9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ac:	6a 58                	push   $0x58
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	ff d0                	call   *%eax
  8008b3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008b6:	83 ec 08             	sub    $0x8,%esp
  8008b9:	ff 75 0c             	pushl  0xc(%ebp)
  8008bc:	6a 58                	push   $0x58
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	ff d0                	call   *%eax
  8008c3:	83 c4 10             	add    $0x10,%esp
			break;
  8008c6:	e9 ce 00 00 00       	jmp    800999 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8008cb:	83 ec 08             	sub    $0x8,%esp
  8008ce:	ff 75 0c             	pushl  0xc(%ebp)
  8008d1:	6a 30                	push   $0x30
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	ff d0                	call   *%eax
  8008d8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008db:	83 ec 08             	sub    $0x8,%esp
  8008de:	ff 75 0c             	pushl  0xc(%ebp)
  8008e1:	6a 78                	push   $0x78
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	ff d0                	call   *%eax
  8008e8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ee:	83 c0 04             	add    $0x4,%eax
  8008f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f7:	83 e8 04             	sub    $0x4,%eax
  8008fa:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800906:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80090d:	eb 1f                	jmp    80092e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80090f:	83 ec 08             	sub    $0x8,%esp
  800912:	ff 75 e8             	pushl  -0x18(%ebp)
  800915:	8d 45 14             	lea    0x14(%ebp),%eax
  800918:	50                   	push   %eax
  800919:	e8 e7 fb ff ff       	call   800505 <getuint>
  80091e:	83 c4 10             	add    $0x10,%esp
  800921:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800924:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800927:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80092e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800932:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800935:	83 ec 04             	sub    $0x4,%esp
  800938:	52                   	push   %edx
  800939:	ff 75 e4             	pushl  -0x1c(%ebp)
  80093c:	50                   	push   %eax
  80093d:	ff 75 f4             	pushl  -0xc(%ebp)
  800940:	ff 75 f0             	pushl  -0x10(%ebp)
  800943:	ff 75 0c             	pushl  0xc(%ebp)
  800946:	ff 75 08             	pushl  0x8(%ebp)
  800949:	e8 00 fb ff ff       	call   80044e <printnum>
  80094e:	83 c4 20             	add    $0x20,%esp
			break;
  800951:	eb 46                	jmp    800999 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	53                   	push   %ebx
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	ff d0                	call   *%eax
  80095f:	83 c4 10             	add    $0x10,%esp
			break;
  800962:	eb 35                	jmp    800999 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800964:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  80096b:	eb 2c                	jmp    800999 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80096d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800974:	eb 23                	jmp    800999 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800976:	83 ec 08             	sub    $0x8,%esp
  800979:	ff 75 0c             	pushl  0xc(%ebp)
  80097c:	6a 25                	push   $0x25
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	ff d0                	call   *%eax
  800983:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800986:	ff 4d 10             	decl   0x10(%ebp)
  800989:	eb 03                	jmp    80098e <vprintfmt+0x3c3>
  80098b:	ff 4d 10             	decl   0x10(%ebp)
  80098e:	8b 45 10             	mov    0x10(%ebp),%eax
  800991:	48                   	dec    %eax
  800992:	8a 00                	mov    (%eax),%al
  800994:	3c 25                	cmp    $0x25,%al
  800996:	75 f3                	jne    80098b <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800998:	90                   	nop
		}
	}
  800999:	e9 35 fc ff ff       	jmp    8005d3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80099e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80099f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009a2:	5b                   	pop    %ebx
  8009a3:	5e                   	pop    %esi
  8009a4:	5d                   	pop    %ebp
  8009a5:	c3                   	ret    

008009a6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009a6:	55                   	push   %ebp
  8009a7:	89 e5                	mov    %esp,%ebp
  8009a9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009ac:	8d 45 10             	lea    0x10(%ebp),%eax
  8009af:	83 c0 04             	add    $0x4,%eax
  8009b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009bb:	50                   	push   %eax
  8009bc:	ff 75 0c             	pushl  0xc(%ebp)
  8009bf:	ff 75 08             	pushl  0x8(%ebp)
  8009c2:	e8 04 fc ff ff       	call   8005cb <vprintfmt>
  8009c7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009ca:	90                   	nop
  8009cb:	c9                   	leave  
  8009cc:	c3                   	ret    

008009cd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009cd:	55                   	push   %ebp
  8009ce:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d3:	8b 40 08             	mov    0x8(%eax),%eax
  8009d6:	8d 50 01             	lea    0x1(%eax),%edx
  8009d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e2:	8b 10                	mov    (%eax),%edx
  8009e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e7:	8b 40 04             	mov    0x4(%eax),%eax
  8009ea:	39 c2                	cmp    %eax,%edx
  8009ec:	73 12                	jae    800a00 <sprintputch+0x33>
		*b->buf++ = ch;
  8009ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f1:	8b 00                	mov    (%eax),%eax
  8009f3:	8d 48 01             	lea    0x1(%eax),%ecx
  8009f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f9:	89 0a                	mov    %ecx,(%edx)
  8009fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8009fe:	88 10                	mov    %dl,(%eax)
}
  800a00:	90                   	nop
  800a01:	5d                   	pop    %ebp
  800a02:	c3                   	ret    

00800a03 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
  800a06:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a09:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a12:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	01 d0                	add    %edx,%eax
  800a1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a24:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a28:	74 06                	je     800a30 <vsnprintf+0x2d>
  800a2a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a2e:	7f 07                	jg     800a37 <vsnprintf+0x34>
		return -E_INVAL;
  800a30:	b8 03 00 00 00       	mov    $0x3,%eax
  800a35:	eb 20                	jmp    800a57 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a37:	ff 75 14             	pushl  0x14(%ebp)
  800a3a:	ff 75 10             	pushl  0x10(%ebp)
  800a3d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a40:	50                   	push   %eax
  800a41:	68 cd 09 80 00       	push   $0x8009cd
  800a46:	e8 80 fb ff ff       	call   8005cb <vprintfmt>
  800a4b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a51:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a57:	c9                   	leave  
  800a58:	c3                   	ret    

00800a59 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a59:	55                   	push   %ebp
  800a5a:	89 e5                	mov    %esp,%ebp
  800a5c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a5f:	8d 45 10             	lea    0x10(%ebp),%eax
  800a62:	83 c0 04             	add    $0x4,%eax
  800a65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a68:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6e:	50                   	push   %eax
  800a6f:	ff 75 0c             	pushl  0xc(%ebp)
  800a72:	ff 75 08             	pushl  0x8(%ebp)
  800a75:	e8 89 ff ff ff       	call   800a03 <vsnprintf>
  800a7a:	83 c4 10             	add    $0x10,%esp
  800a7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a83:	c9                   	leave  
  800a84:	c3                   	ret    

00800a85 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a85:	55                   	push   %ebp
  800a86:	89 e5                	mov    %esp,%ebp
  800a88:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a92:	eb 06                	jmp    800a9a <strlen+0x15>
		n++;
  800a94:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a97:	ff 45 08             	incl   0x8(%ebp)
  800a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9d:	8a 00                	mov    (%eax),%al
  800a9f:	84 c0                	test   %al,%al
  800aa1:	75 f1                	jne    800a94 <strlen+0xf>
		n++;
	return n;
  800aa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aa6:	c9                   	leave  
  800aa7:	c3                   	ret    

00800aa8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800aa8:	55                   	push   %ebp
  800aa9:	89 e5                	mov    %esp,%ebp
  800aab:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ab5:	eb 09                	jmp    800ac0 <strnlen+0x18>
		n++;
  800ab7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aba:	ff 45 08             	incl   0x8(%ebp)
  800abd:	ff 4d 0c             	decl   0xc(%ebp)
  800ac0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac4:	74 09                	je     800acf <strnlen+0x27>
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	8a 00                	mov    (%eax),%al
  800acb:	84 c0                	test   %al,%al
  800acd:	75 e8                	jne    800ab7 <strnlen+0xf>
		n++;
	return n;
  800acf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ad2:	c9                   	leave  
  800ad3:	c3                   	ret    

00800ad4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
  800ad7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ae0:	90                   	nop
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8d 50 01             	lea    0x1(%eax),%edx
  800ae7:	89 55 08             	mov    %edx,0x8(%ebp)
  800aea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aed:	8d 4a 01             	lea    0x1(%edx),%ecx
  800af0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800af3:	8a 12                	mov    (%edx),%dl
  800af5:	88 10                	mov    %dl,(%eax)
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	84 c0                	test   %al,%al
  800afb:	75 e4                	jne    800ae1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b00:	c9                   	leave  
  800b01:	c3                   	ret    

00800b02 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b02:	55                   	push   %ebp
  800b03:	89 e5                	mov    %esp,%ebp
  800b05:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b15:	eb 1f                	jmp    800b36 <strncpy+0x34>
		*dst++ = *src;
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8d 50 01             	lea    0x1(%eax),%edx
  800b1d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b23:	8a 12                	mov    (%edx),%dl
  800b25:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2a:	8a 00                	mov    (%eax),%al
  800b2c:	84 c0                	test   %al,%al
  800b2e:	74 03                	je     800b33 <strncpy+0x31>
			src++;
  800b30:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b33:	ff 45 fc             	incl   -0x4(%ebp)
  800b36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b39:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b3c:	72 d9                	jb     800b17 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b41:	c9                   	leave  
  800b42:	c3                   	ret    

00800b43 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
  800b46:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b53:	74 30                	je     800b85 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b55:	eb 16                	jmp    800b6d <strlcpy+0x2a>
			*dst++ = *src++;
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8d 50 01             	lea    0x1(%eax),%edx
  800b5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b63:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b66:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b69:	8a 12                	mov    (%edx),%dl
  800b6b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b6d:	ff 4d 10             	decl   0x10(%ebp)
  800b70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b74:	74 09                	je     800b7f <strlcpy+0x3c>
  800b76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b79:	8a 00                	mov    (%eax),%al
  800b7b:	84 c0                	test   %al,%al
  800b7d:	75 d8                	jne    800b57 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b85:	8b 55 08             	mov    0x8(%ebp),%edx
  800b88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b8b:	29 c2                	sub    %eax,%edx
  800b8d:	89 d0                	mov    %edx,%eax
}
  800b8f:	c9                   	leave  
  800b90:	c3                   	ret    

00800b91 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b91:	55                   	push   %ebp
  800b92:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b94:	eb 06                	jmp    800b9c <strcmp+0xb>
		p++, q++;
  800b96:	ff 45 08             	incl   0x8(%ebp)
  800b99:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	8a 00                	mov    (%eax),%al
  800ba1:	84 c0                	test   %al,%al
  800ba3:	74 0e                	je     800bb3 <strcmp+0x22>
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	8a 10                	mov    (%eax),%dl
  800baa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bad:	8a 00                	mov    (%eax),%al
  800baf:	38 c2                	cmp    %al,%dl
  800bb1:	74 e3                	je     800b96 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	8a 00                	mov    (%eax),%al
  800bb8:	0f b6 d0             	movzbl %al,%edx
  800bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbe:	8a 00                	mov    (%eax),%al
  800bc0:	0f b6 c0             	movzbl %al,%eax
  800bc3:	29 c2                	sub    %eax,%edx
  800bc5:	89 d0                	mov    %edx,%eax
}
  800bc7:	5d                   	pop    %ebp
  800bc8:	c3                   	ret    

00800bc9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bcc:	eb 09                	jmp    800bd7 <strncmp+0xe>
		n--, p++, q++;
  800bce:	ff 4d 10             	decl   0x10(%ebp)
  800bd1:	ff 45 08             	incl   0x8(%ebp)
  800bd4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bd7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bdb:	74 17                	je     800bf4 <strncmp+0x2b>
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8a 00                	mov    (%eax),%al
  800be2:	84 c0                	test   %al,%al
  800be4:	74 0e                	je     800bf4 <strncmp+0x2b>
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	8a 10                	mov    (%eax),%dl
  800beb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bee:	8a 00                	mov    (%eax),%al
  800bf0:	38 c2                	cmp    %al,%dl
  800bf2:	74 da                	je     800bce <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bf4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bf8:	75 07                	jne    800c01 <strncmp+0x38>
		return 0;
  800bfa:	b8 00 00 00 00       	mov    $0x0,%eax
  800bff:	eb 14                	jmp    800c15 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	8a 00                	mov    (%eax),%al
  800c06:	0f b6 d0             	movzbl %al,%edx
  800c09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	0f b6 c0             	movzbl %al,%eax
  800c11:	29 c2                	sub    %eax,%edx
  800c13:	89 d0                	mov    %edx,%eax
}
  800c15:	5d                   	pop    %ebp
  800c16:	c3                   	ret    

00800c17 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c17:	55                   	push   %ebp
  800c18:	89 e5                	mov    %esp,%ebp
  800c1a:	83 ec 04             	sub    $0x4,%esp
  800c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c20:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c23:	eb 12                	jmp    800c37 <strchr+0x20>
		if (*s == c)
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c2d:	75 05                	jne    800c34 <strchr+0x1d>
			return (char *) s;
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	eb 11                	jmp    800c45 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c34:	ff 45 08             	incl   0x8(%ebp)
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	84 c0                	test   %al,%al
  800c3e:	75 e5                	jne    800c25 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c45:	c9                   	leave  
  800c46:	c3                   	ret    

00800c47 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c47:	55                   	push   %ebp
  800c48:	89 e5                	mov    %esp,%ebp
  800c4a:	83 ec 04             	sub    $0x4,%esp
  800c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c50:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c53:	eb 0d                	jmp    800c62 <strfind+0x1b>
		if (*s == c)
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	8a 00                	mov    (%eax),%al
  800c5a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c5d:	74 0e                	je     800c6d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c5f:	ff 45 08             	incl   0x8(%ebp)
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
  800c65:	8a 00                	mov    (%eax),%al
  800c67:	84 c0                	test   %al,%al
  800c69:	75 ea                	jne    800c55 <strfind+0xe>
  800c6b:	eb 01                	jmp    800c6e <strfind+0x27>
		if (*s == c)
			break;
  800c6d:	90                   	nop
	return (char *) s;
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
  800c76:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800c7f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800c83:	76 63                	jbe    800ce8 <memset+0x75>
		uint64 data_block = c;
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	99                   	cltd   
  800c89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c92:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c95:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800c99:	c1 e0 08             	shl    $0x8,%eax
  800c9c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c9f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ca5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca8:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800cac:	c1 e0 10             	shl    $0x10,%eax
  800caf:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cb2:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800cb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cbb:	89 c2                	mov    %eax,%edx
  800cbd:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc2:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cc5:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800cc8:	eb 18                	jmp    800ce2 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800cca:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ccd:	8d 41 08             	lea    0x8(%ecx),%eax
  800cd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800cd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cd9:	89 01                	mov    %eax,(%ecx)
  800cdb:	89 51 04             	mov    %edx,0x4(%ecx)
  800cde:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800ce2:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ce6:	77 e2                	ja     800cca <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800ce8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cec:	74 23                	je     800d11 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800cee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cf4:	eb 0e                	jmp    800d04 <memset+0x91>
			*p8++ = (uint8)c;
  800cf6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cf9:	8d 50 01             	lea    0x1(%eax),%edx
  800cfc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d02:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d04:	8b 45 10             	mov    0x10(%ebp),%eax
  800d07:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d0a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d0d:	85 c0                	test   %eax,%eax
  800d0f:	75 e5                	jne    800cf6 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d14:	c9                   	leave  
  800d15:	c3                   	ret    

00800d16 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d28:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d2c:	76 24                	jbe    800d52 <memcpy+0x3c>
		while(n >= 8){
  800d2e:	eb 1c                	jmp    800d4c <memcpy+0x36>
			*d64 = *s64;
  800d30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d33:	8b 50 04             	mov    0x4(%eax),%edx
  800d36:	8b 00                	mov    (%eax),%eax
  800d38:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d3b:	89 01                	mov    %eax,(%ecx)
  800d3d:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d40:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d44:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d48:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d4c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d50:	77 de                	ja     800d30 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d56:	74 31                	je     800d89 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d61:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800d64:	eb 16                	jmp    800d7c <memcpy+0x66>
			*d8++ = *s8++;
  800d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d69:	8d 50 01             	lea    0x1(%eax),%edx
  800d6c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800d6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d72:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d75:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800d78:	8a 12                	mov    (%edx),%dl
  800d7a:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800d7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d82:	89 55 10             	mov    %edx,0x10(%ebp)
  800d85:	85 c0                	test   %eax,%eax
  800d87:	75 dd                	jne    800d66 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8c:	c9                   	leave  
  800d8d:	c3                   	ret    

00800d8e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d8e:	55                   	push   %ebp
  800d8f:	89 e5                	mov    %esp,%ebp
  800d91:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800da0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da6:	73 50                	jae    800df8 <memmove+0x6a>
  800da8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dab:	8b 45 10             	mov    0x10(%ebp),%eax
  800dae:	01 d0                	add    %edx,%eax
  800db0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db3:	76 43                	jbe    800df8 <memmove+0x6a>
		s += n;
  800db5:	8b 45 10             	mov    0x10(%ebp),%eax
  800db8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbe:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dc1:	eb 10                	jmp    800dd3 <memmove+0x45>
			*--d = *--s;
  800dc3:	ff 4d f8             	decl   -0x8(%ebp)
  800dc6:	ff 4d fc             	decl   -0x4(%ebp)
  800dc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcc:	8a 10                	mov    (%eax),%dl
  800dce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ddc:	85 c0                	test   %eax,%eax
  800dde:	75 e3                	jne    800dc3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800de0:	eb 23                	jmp    800e05 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800de2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de5:	8d 50 01             	lea    0x1(%eax),%edx
  800de8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800deb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dee:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df4:	8a 12                	mov    (%edx),%dl
  800df6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800df8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfe:	89 55 10             	mov    %edx,0x10(%ebp)
  800e01:	85 c0                	test   %eax,%eax
  800e03:	75 dd                	jne    800de2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e08:	c9                   	leave  
  800e09:	c3                   	ret    

00800e0a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e0a:	55                   	push   %ebp
  800e0b:	89 e5                	mov    %esp,%ebp
  800e0d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e19:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e1c:	eb 2a                	jmp    800e48 <memcmp+0x3e>
		if (*s1 != *s2)
  800e1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e21:	8a 10                	mov    (%eax),%dl
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	38 c2                	cmp    %al,%dl
  800e2a:	74 16                	je     800e42 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	0f b6 d0             	movzbl %al,%edx
  800e34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e37:	8a 00                	mov    (%eax),%al
  800e39:	0f b6 c0             	movzbl %al,%eax
  800e3c:	29 c2                	sub    %eax,%edx
  800e3e:	89 d0                	mov    %edx,%eax
  800e40:	eb 18                	jmp    800e5a <memcmp+0x50>
		s1++, s2++;
  800e42:	ff 45 fc             	incl   -0x4(%ebp)
  800e45:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e48:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4e:	89 55 10             	mov    %edx,0x10(%ebp)
  800e51:	85 c0                	test   %eax,%eax
  800e53:	75 c9                	jne    800e1e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e55:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e5a:	c9                   	leave  
  800e5b:	c3                   	ret    

00800e5c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e5c:	55                   	push   %ebp
  800e5d:	89 e5                	mov    %esp,%ebp
  800e5f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e62:	8b 55 08             	mov    0x8(%ebp),%edx
  800e65:	8b 45 10             	mov    0x10(%ebp),%eax
  800e68:	01 d0                	add    %edx,%eax
  800e6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e6d:	eb 15                	jmp    800e84 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8a 00                	mov    (%eax),%al
  800e74:	0f b6 d0             	movzbl %al,%edx
  800e77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7a:	0f b6 c0             	movzbl %al,%eax
  800e7d:	39 c2                	cmp    %eax,%edx
  800e7f:	74 0d                	je     800e8e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e81:	ff 45 08             	incl   0x8(%ebp)
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e8a:	72 e3                	jb     800e6f <memfind+0x13>
  800e8c:	eb 01                	jmp    800e8f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e8e:	90                   	nop
	return (void *) s;
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e92:	c9                   	leave  
  800e93:	c3                   	ret    

00800e94 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e94:	55                   	push   %ebp
  800e95:	89 e5                	mov    %esp,%ebp
  800e97:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ea1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea8:	eb 03                	jmp    800ead <strtol+0x19>
		s++;
  800eaa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	3c 20                	cmp    $0x20,%al
  800eb4:	74 f4                	je     800eaa <strtol+0x16>
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	3c 09                	cmp    $0x9,%al
  800ebd:	74 eb                	je     800eaa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	3c 2b                	cmp    $0x2b,%al
  800ec6:	75 05                	jne    800ecd <strtol+0x39>
		s++;
  800ec8:	ff 45 08             	incl   0x8(%ebp)
  800ecb:	eb 13                	jmp    800ee0 <strtol+0x4c>
	else if (*s == '-')
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	3c 2d                	cmp    $0x2d,%al
  800ed4:	75 0a                	jne    800ee0 <strtol+0x4c>
		s++, neg = 1;
  800ed6:	ff 45 08             	incl   0x8(%ebp)
  800ed9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ee0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee4:	74 06                	je     800eec <strtol+0x58>
  800ee6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800eea:	75 20                	jne    800f0c <strtol+0x78>
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	3c 30                	cmp    $0x30,%al
  800ef3:	75 17                	jne    800f0c <strtol+0x78>
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	40                   	inc    %eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	3c 78                	cmp    $0x78,%al
  800efd:	75 0d                	jne    800f0c <strtol+0x78>
		s += 2, base = 16;
  800eff:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f03:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f0a:	eb 28                	jmp    800f34 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f0c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f10:	75 15                	jne    800f27 <strtol+0x93>
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	3c 30                	cmp    $0x30,%al
  800f19:	75 0c                	jne    800f27 <strtol+0x93>
		s++, base = 8;
  800f1b:	ff 45 08             	incl   0x8(%ebp)
  800f1e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f25:	eb 0d                	jmp    800f34 <strtol+0xa0>
	else if (base == 0)
  800f27:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2b:	75 07                	jne    800f34 <strtol+0xa0>
		base = 10;
  800f2d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	3c 2f                	cmp    $0x2f,%al
  800f3b:	7e 19                	jle    800f56 <strtol+0xc2>
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	3c 39                	cmp    $0x39,%al
  800f44:	7f 10                	jg     800f56 <strtol+0xc2>
			dig = *s - '0';
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	0f be c0             	movsbl %al,%eax
  800f4e:	83 e8 30             	sub    $0x30,%eax
  800f51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f54:	eb 42                	jmp    800f98 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	8a 00                	mov    (%eax),%al
  800f5b:	3c 60                	cmp    $0x60,%al
  800f5d:	7e 19                	jle    800f78 <strtol+0xe4>
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	3c 7a                	cmp    $0x7a,%al
  800f66:	7f 10                	jg     800f78 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	0f be c0             	movsbl %al,%eax
  800f70:	83 e8 57             	sub    $0x57,%eax
  800f73:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f76:	eb 20                	jmp    800f98 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	3c 40                	cmp    $0x40,%al
  800f7f:	7e 39                	jle    800fba <strtol+0x126>
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3c 5a                	cmp    $0x5a,%al
  800f88:	7f 30                	jg     800fba <strtol+0x126>
			dig = *s - 'A' + 10;
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	0f be c0             	movsbl %al,%eax
  800f92:	83 e8 37             	sub    $0x37,%eax
  800f95:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f9b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f9e:	7d 19                	jge    800fb9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fa0:	ff 45 08             	incl   0x8(%ebp)
  800fa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa6:	0f af 45 10          	imul   0x10(%ebp),%eax
  800faa:	89 c2                	mov    %eax,%edx
  800fac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800faf:	01 d0                	add    %edx,%eax
  800fb1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fb4:	e9 7b ff ff ff       	jmp    800f34 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fb9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fbe:	74 08                	je     800fc8 <strtol+0x134>
		*endptr = (char *) s;
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fc8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fcc:	74 07                	je     800fd5 <strtol+0x141>
  800fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd1:	f7 d8                	neg    %eax
  800fd3:	eb 03                	jmp    800fd8 <strtol+0x144>
  800fd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <ltostr>:

void
ltostr(long value, char *str)
{
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fe0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fe7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff2:	79 13                	jns    801007 <ltostr+0x2d>
	{
		neg = 1;
  800ff4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffe:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801001:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801004:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80100f:	99                   	cltd   
  801010:	f7 f9                	idiv   %ecx
  801012:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801015:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801018:	8d 50 01             	lea    0x1(%eax),%edx
  80101b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80101e:	89 c2                	mov    %eax,%edx
  801020:	8b 45 0c             	mov    0xc(%ebp),%eax
  801023:	01 d0                	add    %edx,%eax
  801025:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801028:	83 c2 30             	add    $0x30,%edx
  80102b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80102d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801030:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801035:	f7 e9                	imul   %ecx
  801037:	c1 fa 02             	sar    $0x2,%edx
  80103a:	89 c8                	mov    %ecx,%eax
  80103c:	c1 f8 1f             	sar    $0x1f,%eax
  80103f:	29 c2                	sub    %eax,%edx
  801041:	89 d0                	mov    %edx,%eax
  801043:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801046:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104a:	75 bb                	jne    801007 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80104c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801053:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801056:	48                   	dec    %eax
  801057:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80105a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80105e:	74 3d                	je     80109d <ltostr+0xc3>
		start = 1 ;
  801060:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801067:	eb 34                	jmp    80109d <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801069:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80106c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106f:	01 d0                	add    %edx,%eax
  801071:	8a 00                	mov    (%eax),%al
  801073:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801076:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801079:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107c:	01 c2                	add    %eax,%edx
  80107e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	01 c8                	add    %ecx,%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80108a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	01 c2                	add    %eax,%edx
  801092:	8a 45 eb             	mov    -0x15(%ebp),%al
  801095:	88 02                	mov    %al,(%edx)
		start++ ;
  801097:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80109a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80109d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010a3:	7c c4                	jl     801069 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010a5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ab:	01 d0                	add    %edx,%eax
  8010ad:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010b0:	90                   	nop
  8010b1:	c9                   	leave  
  8010b2:	c3                   	ret    

008010b3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010b9:	ff 75 08             	pushl  0x8(%ebp)
  8010bc:	e8 c4 f9 ff ff       	call   800a85 <strlen>
  8010c1:	83 c4 04             	add    $0x4,%esp
  8010c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010c7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ca:	e8 b6 f9 ff ff       	call   800a85 <strlen>
  8010cf:	83 c4 04             	add    $0x4,%esp
  8010d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010e3:	eb 17                	jmp    8010fc <strcconcat+0x49>
		final[s] = str1[s] ;
  8010e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010eb:	01 c2                	add    %eax,%edx
  8010ed:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f3:	01 c8                	add    %ecx,%eax
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010f9:	ff 45 fc             	incl   -0x4(%ebp)
  8010fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801102:	7c e1                	jl     8010e5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801104:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80110b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801112:	eb 1f                	jmp    801133 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801114:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801117:	8d 50 01             	lea    0x1(%eax),%edx
  80111a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80111d:	89 c2                	mov    %eax,%edx
  80111f:	8b 45 10             	mov    0x10(%ebp),%eax
  801122:	01 c2                	add    %eax,%edx
  801124:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112a:	01 c8                	add    %ecx,%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801130:	ff 45 f8             	incl   -0x8(%ebp)
  801133:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801136:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801139:	7c d9                	jl     801114 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80113b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80113e:	8b 45 10             	mov    0x10(%ebp),%eax
  801141:	01 d0                	add    %edx,%eax
  801143:	c6 00 00             	movb   $0x0,(%eax)
}
  801146:	90                   	nop
  801147:	c9                   	leave  
  801148:	c3                   	ret    

00801149 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801149:	55                   	push   %ebp
  80114a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80114c:	8b 45 14             	mov    0x14(%ebp),%eax
  80114f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801155:	8b 45 14             	mov    0x14(%ebp),%eax
  801158:	8b 00                	mov    (%eax),%eax
  80115a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801161:	8b 45 10             	mov    0x10(%ebp),%eax
  801164:	01 d0                	add    %edx,%eax
  801166:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80116c:	eb 0c                	jmp    80117a <strsplit+0x31>
			*string++ = 0;
  80116e:	8b 45 08             	mov    0x8(%ebp),%eax
  801171:	8d 50 01             	lea    0x1(%eax),%edx
  801174:	89 55 08             	mov    %edx,0x8(%ebp)
  801177:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	84 c0                	test   %al,%al
  801181:	74 18                	je     80119b <strsplit+0x52>
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	0f be c0             	movsbl %al,%eax
  80118b:	50                   	push   %eax
  80118c:	ff 75 0c             	pushl  0xc(%ebp)
  80118f:	e8 83 fa ff ff       	call   800c17 <strchr>
  801194:	83 c4 08             	add    $0x8,%esp
  801197:	85 c0                	test   %eax,%eax
  801199:	75 d3                	jne    80116e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	84 c0                	test   %al,%al
  8011a2:	74 5a                	je     8011fe <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a7:	8b 00                	mov    (%eax),%eax
  8011a9:	83 f8 0f             	cmp    $0xf,%eax
  8011ac:	75 07                	jne    8011b5 <strsplit+0x6c>
		{
			return 0;
  8011ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b3:	eb 66                	jmp    80121b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b8:	8b 00                	mov    (%eax),%eax
  8011ba:	8d 48 01             	lea    0x1(%eax),%ecx
  8011bd:	8b 55 14             	mov    0x14(%ebp),%edx
  8011c0:	89 0a                	mov    %ecx,(%edx)
  8011c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011cc:	01 c2                	add    %eax,%edx
  8011ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011d3:	eb 03                	jmp    8011d8 <strsplit+0x8f>
			string++;
  8011d5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	84 c0                	test   %al,%al
  8011df:	74 8b                	je     80116c <strsplit+0x23>
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	0f be c0             	movsbl %al,%eax
  8011e9:	50                   	push   %eax
  8011ea:	ff 75 0c             	pushl  0xc(%ebp)
  8011ed:	e8 25 fa ff ff       	call   800c17 <strchr>
  8011f2:	83 c4 08             	add    $0x8,%esp
  8011f5:	85 c0                	test   %eax,%eax
  8011f7:	74 dc                	je     8011d5 <strsplit+0x8c>
			string++;
	}
  8011f9:	e9 6e ff ff ff       	jmp    80116c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011fe:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801202:	8b 00                	mov    (%eax),%eax
  801204:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80120b:	8b 45 10             	mov    0x10(%ebp),%eax
  80120e:	01 d0                	add    %edx,%eax
  801210:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801216:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
  801220:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801229:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801230:	eb 4a                	jmp    80127c <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801232:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	01 c2                	add    %eax,%edx
  80123a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80123d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801240:	01 c8                	add    %ecx,%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801246:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 40                	cmp    $0x40,%al
  801252:	7e 25                	jle    801279 <str2lower+0x5c>
  801254:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801257:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125a:	01 d0                	add    %edx,%eax
  80125c:	8a 00                	mov    (%eax),%al
  80125e:	3c 5a                	cmp    $0x5a,%al
  801260:	7f 17                	jg     801279 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801262:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	01 d0                	add    %edx,%eax
  80126a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80126d:	8b 55 08             	mov    0x8(%ebp),%edx
  801270:	01 ca                	add    %ecx,%edx
  801272:	8a 12                	mov    (%edx),%dl
  801274:	83 c2 20             	add    $0x20,%edx
  801277:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801279:	ff 45 fc             	incl   -0x4(%ebp)
  80127c:	ff 75 0c             	pushl  0xc(%ebp)
  80127f:	e8 01 f8 ff ff       	call   800a85 <strlen>
  801284:	83 c4 04             	add    $0x4,%esp
  801287:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80128a:	7f a6                	jg     801232 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80128c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	57                   	push   %edi
  801295:	56                   	push   %esi
  801296:	53                   	push   %ebx
  801297:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012a6:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012ac:	cd 30                	int    $0x30
  8012ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b4:	83 c4 10             	add    $0x10,%esp
  8012b7:	5b                   	pop    %ebx
  8012b8:	5e                   	pop    %esi
  8012b9:	5f                   	pop    %edi
  8012ba:	5d                   	pop    %ebp
  8012bb:	c3                   	ret    

008012bc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
  8012bf:	83 ec 04             	sub    $0x4,%esp
  8012c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8012c8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012cb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	6a 00                	push   $0x0
  8012d4:	51                   	push   %ecx
  8012d5:	52                   	push   %edx
  8012d6:	ff 75 0c             	pushl  0xc(%ebp)
  8012d9:	50                   	push   %eax
  8012da:	6a 00                	push   $0x0
  8012dc:	e8 b0 ff ff ff       	call   801291 <syscall>
  8012e1:	83 c4 18             	add    $0x18,%esp
}
  8012e4:	90                   	nop
  8012e5:	c9                   	leave  
  8012e6:	c3                   	ret    

008012e7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e7:	55                   	push   %ebp
  8012e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 02                	push   $0x2
  8012f6:	e8 96 ff ff ff       	call   801291 <syscall>
  8012fb:	83 c4 18             	add    $0x18,%esp
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 03                	push   $0x3
  80130f:	e8 7d ff ff ff       	call   801291 <syscall>
  801314:	83 c4 18             	add    $0x18,%esp
}
  801317:	90                   	nop
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 04                	push   $0x4
  801329:	e8 63 ff ff ff       	call   801291 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	90                   	nop
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801337:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	52                   	push   %edx
  801344:	50                   	push   %eax
  801345:	6a 08                	push   $0x8
  801347:	e8 45 ff ff ff       	call   801291 <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	56                   	push   %esi
  801355:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801356:	8b 75 18             	mov    0x18(%ebp),%esi
  801359:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80135c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80135f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	56                   	push   %esi
  801366:	53                   	push   %ebx
  801367:	51                   	push   %ecx
  801368:	52                   	push   %edx
  801369:	50                   	push   %eax
  80136a:	6a 09                	push   $0x9
  80136c:	e8 20 ff ff ff       	call   801291 <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801377:	5b                   	pop    %ebx
  801378:	5e                   	pop    %esi
  801379:	5d                   	pop    %ebp
  80137a:	c3                   	ret    

0080137b <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	ff 75 08             	pushl  0x8(%ebp)
  801389:	6a 0a                	push   $0xa
  80138b:	e8 01 ff ff ff       	call   801291 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	ff 75 0c             	pushl  0xc(%ebp)
  8013a1:	ff 75 08             	pushl  0x8(%ebp)
  8013a4:	6a 0b                	push   $0xb
  8013a6:	e8 e6 fe ff ff       	call   801291 <syscall>
  8013ab:	83 c4 18             	add    $0x18,%esp
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 0c                	push   $0xc
  8013bf:	e8 cd fe ff ff       	call   801291 <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 0d                	push   $0xd
  8013d8:	e8 b4 fe ff ff       	call   801291 <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 0e                	push   $0xe
  8013f1:	e8 9b fe ff ff       	call   801291 <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 0f                	push   $0xf
  80140a:	e8 82 fe ff ff       	call   801291 <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
}
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	ff 75 08             	pushl  0x8(%ebp)
  801422:	6a 10                	push   $0x10
  801424:	e8 68 fe ff ff       	call   801291 <syscall>
  801429:	83 c4 18             	add    $0x18,%esp
}
  80142c:	c9                   	leave  
  80142d:	c3                   	ret    

0080142e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 11                	push   $0x11
  80143d:	e8 4f fe ff ff       	call   801291 <syscall>
  801442:	83 c4 18             	add    $0x18,%esp
}
  801445:	90                   	nop
  801446:	c9                   	leave  
  801447:	c3                   	ret    

00801448 <sys_cputc>:

void
sys_cputc(const char c)
{
  801448:	55                   	push   %ebp
  801449:	89 e5                	mov    %esp,%ebp
  80144b:	83 ec 04             	sub    $0x4,%esp
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801454:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	50                   	push   %eax
  801461:	6a 01                	push   $0x1
  801463:	e8 29 fe ff ff       	call   801291 <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	90                   	nop
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 14                	push   $0x14
  80147d:	e8 0f fe ff ff       	call   801291 <syscall>
  801482:	83 c4 18             	add    $0x18,%esp
}
  801485:	90                   	nop
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
  80148b:	83 ec 04             	sub    $0x4,%esp
  80148e:	8b 45 10             	mov    0x10(%ebp),%eax
  801491:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801494:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801497:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80149b:	8b 45 08             	mov    0x8(%ebp),%eax
  80149e:	6a 00                	push   $0x0
  8014a0:	51                   	push   %ecx
  8014a1:	52                   	push   %edx
  8014a2:	ff 75 0c             	pushl  0xc(%ebp)
  8014a5:	50                   	push   %eax
  8014a6:	6a 15                	push   $0x15
  8014a8:	e8 e4 fd ff ff       	call   801291 <syscall>
  8014ad:	83 c4 18             	add    $0x18,%esp
}
  8014b0:	c9                   	leave  
  8014b1:	c3                   	ret    

008014b2 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8014b5:	8b 55 10             	mov    0x10(%ebp),%edx
  8014b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	52                   	push   %edx
  8014c0:	50                   	push   %eax
  8014c1:	ff 75 08             	pushl  0x8(%ebp)
  8014c4:	6a 16                	push   $0x16
  8014c6:	e8 c6 fd ff ff       	call   801291 <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	52                   	push   %edx
  8014e0:	50                   	push   %eax
  8014e1:	6a 17                	push   $0x17
  8014e3:	e8 a9 fd ff ff       	call   801291 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	52                   	push   %edx
  8014fd:	50                   	push   %eax
  8014fe:	6a 18                	push   $0x18
  801500:	e8 8c fd ff ff       	call   801291 <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	6a 00                	push   $0x0
  801512:	ff 75 14             	pushl  0x14(%ebp)
  801515:	ff 75 10             	pushl  0x10(%ebp)
  801518:	ff 75 0c             	pushl  0xc(%ebp)
  80151b:	50                   	push   %eax
  80151c:	6a 19                	push   $0x19
  80151e:	e8 6e fd ff ff       	call   801291 <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
}
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	50                   	push   %eax
  801537:	6a 1a                	push   $0x1a
  801539:	e8 53 fd ff ff       	call   801291 <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	90                   	nop
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801547:	8b 45 08             	mov    0x8(%ebp),%eax
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	50                   	push   %eax
  801553:	6a 1b                	push   $0x1b
  801555:	e8 37 fd ff ff       	call   801291 <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 05                	push   $0x5
  80156e:	e8 1e fd ff ff       	call   801291 <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 06                	push   $0x6
  801587:	e8 05 fd ff ff       	call   801291 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 07                	push   $0x7
  8015a0:	e8 ec fc ff ff       	call   801291 <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_exit_env>:


void sys_exit_env(void)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 1c                	push   $0x1c
  8015b9:	e8 d3 fc ff ff       	call   801291 <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	90                   	nop
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	ff 75 10             	pushl  0x10(%ebp)
  8015ce:	ff 75 0c             	pushl  0xc(%ebp)
  8015d1:	ff 75 08             	pushl  0x8(%ebp)
  8015d4:	6a 13                	push   $0x13
  8015d6:	e8 b6 fc ff ff       	call   801291 <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
	return ;
  8015de:	90                   	nop
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 1e                	push   $0x1e
  8015f0:	e8 9c fc ff ff       	call   801291 <syscall>
  8015f5:	83 c4 18             	add    $0x18,%esp
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
  8015fd:	83 ec 04             	sub    $0x4,%esp
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801606:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	50                   	push   %eax
  801613:	6a 1f                	push   $0x1f
  801615:	e8 77 fc ff ff       	call   801291 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
	return ;
  80161d:	90                   	nop
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <rsttst>:
void rsttst()
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 21                	push   $0x21
  80162f:	e8 5d fc ff ff       	call   801291 <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
	return ;
  801637:	90                   	nop
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
  80163d:	83 ec 04             	sub    $0x4,%esp
  801640:	8b 45 14             	mov    0x14(%ebp),%eax
  801643:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801646:	8b 55 18             	mov    0x18(%ebp),%edx
  801649:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80164d:	52                   	push   %edx
  80164e:	50                   	push   %eax
  80164f:	ff 75 10             	pushl  0x10(%ebp)
  801652:	ff 75 0c             	pushl  0xc(%ebp)
  801655:	ff 75 08             	pushl  0x8(%ebp)
  801658:	6a 20                	push   $0x20
  80165a:	e8 32 fc ff ff       	call   801291 <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
	return ;
  801662:	90                   	nop
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <chktst>:
void chktst(uint32 n)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	ff 75 08             	pushl  0x8(%ebp)
  801673:	6a 22                	push   $0x22
  801675:	e8 17 fc ff ff       	call   801291 <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
	return ;
  80167d:	90                   	nop
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <inctst>:

void inctst()
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 23                	push   $0x23
  80168f:	e8 fd fb ff ff       	call   801291 <syscall>
  801694:	83 c4 18             	add    $0x18,%esp
	return ;
  801697:	90                   	nop
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <gettst>:
uint32 gettst()
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 24                	push   $0x24
  8016a9:	e8 e3 fb ff ff       	call   801291 <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 25                	push   $0x25
  8016c2:	e8 ca fb ff ff       	call   801291 <syscall>
  8016c7:	83 c4 18             	add    $0x18,%esp
  8016ca:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8016cf:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8016d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dc:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	ff 75 08             	pushl  0x8(%ebp)
  8016ec:	6a 26                	push   $0x26
  8016ee:	e8 9e fb ff ff       	call   801291 <syscall>
  8016f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f6:	90                   	nop
}
  8016f7:	c9                   	leave  
  8016f8:	c3                   	ret    

008016f9 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016f9:	55                   	push   %ebp
  8016fa:	89 e5                	mov    %esp,%ebp
  8016fc:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016fd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801700:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801703:	8b 55 0c             	mov    0xc(%ebp),%edx
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	6a 00                	push   $0x0
  80170b:	53                   	push   %ebx
  80170c:	51                   	push   %ecx
  80170d:	52                   	push   %edx
  80170e:	50                   	push   %eax
  80170f:	6a 27                	push   $0x27
  801711:	e8 7b fb ff ff       	call   801291 <syscall>
  801716:	83 c4 18             	add    $0x18,%esp
}
  801719:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801721:	8b 55 0c             	mov    0xc(%ebp),%edx
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	52                   	push   %edx
  80172e:	50                   	push   %eax
  80172f:	6a 28                	push   $0x28
  801731:	e8 5b fb ff ff       	call   801291 <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80173e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801741:	8b 55 0c             	mov    0xc(%ebp),%edx
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	6a 00                	push   $0x0
  801749:	51                   	push   %ecx
  80174a:	ff 75 10             	pushl  0x10(%ebp)
  80174d:	52                   	push   %edx
  80174e:	50                   	push   %eax
  80174f:	6a 29                	push   $0x29
  801751:	e8 3b fb ff ff       	call   801291 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	ff 75 10             	pushl  0x10(%ebp)
  801765:	ff 75 0c             	pushl  0xc(%ebp)
  801768:	ff 75 08             	pushl  0x8(%ebp)
  80176b:	6a 12                	push   $0x12
  80176d:	e8 1f fb ff ff       	call   801291 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
	return ;
  801775:	90                   	nop
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80177b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	52                   	push   %edx
  801788:	50                   	push   %eax
  801789:	6a 2a                	push   $0x2a
  80178b:	e8 01 fb ff ff       	call   801291 <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
	return;
  801793:	90                   	nop
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 2b                	push   $0x2b
  8017a5:	e8 e7 fa ff ff       	call   801291 <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
  8017b2:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8017b5:	83 ec 04             	sub    $0x4,%esp
  8017b8:	68 48 22 80 00       	push   $0x802248
  8017bd:	68 0a 01 00 00       	push   $0x10a
  8017c2:	68 58 22 80 00       	push   $0x802258
  8017c7:	e8 38 00 00 00       	call   801804 <_panic>

008017cc <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	ff 75 0c             	pushl  0xc(%ebp)
  8017d8:	ff 75 08             	pushl  0x8(%ebp)
  8017db:	6a 33                	push   $0x33
  8017dd:	e8 af fa ff ff       	call   801291 <syscall>
  8017e2:	83 c4 18             	add    $0x18,%esp
	return;
  8017e5:	90                   	nop
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	ff 75 0c             	pushl  0xc(%ebp)
  8017f4:	ff 75 08             	pushl  0x8(%ebp)
  8017f7:	6a 34                	push   $0x34
  8017f9:	e8 93 fa ff ff       	call   801291 <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801801:	90                   	nop
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
  801807:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80180a:	8d 45 10             	lea    0x10(%ebp),%eax
  80180d:	83 c0 04             	add    $0x4,%eax
  801810:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801813:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801818:	85 c0                	test   %eax,%eax
  80181a:	74 16                	je     801832 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80181c:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801821:	83 ec 08             	sub    $0x8,%esp
  801824:	50                   	push   %eax
  801825:	68 68 22 80 00       	push   $0x802268
  80182a:	e8 7d eb ff ff       	call   8003ac <cprintf>
  80182f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801832:	a1 04 30 80 00       	mov    0x803004,%eax
  801837:	83 ec 0c             	sub    $0xc,%esp
  80183a:	ff 75 0c             	pushl  0xc(%ebp)
  80183d:	ff 75 08             	pushl  0x8(%ebp)
  801840:	50                   	push   %eax
  801841:	68 70 22 80 00       	push   $0x802270
  801846:	6a 74                	push   $0x74
  801848:	e8 8c eb ff ff       	call   8003d9 <cprintf_colored>
  80184d:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801850:	8b 45 10             	mov    0x10(%ebp),%eax
  801853:	83 ec 08             	sub    $0x8,%esp
  801856:	ff 75 f4             	pushl  -0xc(%ebp)
  801859:	50                   	push   %eax
  80185a:	e8 de ea ff ff       	call   80033d <vcprintf>
  80185f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801862:	83 ec 08             	sub    $0x8,%esp
  801865:	6a 00                	push   $0x0
  801867:	68 98 22 80 00       	push   $0x802298
  80186c:	e8 cc ea ff ff       	call   80033d <vcprintf>
  801871:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801874:	e8 45 ea ff ff       	call   8002be <exit>

	// should not return here
	while (1) ;
  801879:	eb fe                	jmp    801879 <_panic+0x75>

0080187b <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
  80187e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801881:	a1 20 30 80 00       	mov    0x803020,%eax
  801886:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80188c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188f:	39 c2                	cmp    %eax,%edx
  801891:	74 14                	je     8018a7 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801893:	83 ec 04             	sub    $0x4,%esp
  801896:	68 9c 22 80 00       	push   $0x80229c
  80189b:	6a 26                	push   $0x26
  80189d:	68 e8 22 80 00       	push   $0x8022e8
  8018a2:	e8 5d ff ff ff       	call   801804 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018b5:	e9 c5 00 00 00       	jmp    80197f <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8018ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c7:	01 d0                	add    %edx,%eax
  8018c9:	8b 00                	mov    (%eax),%eax
  8018cb:	85 c0                	test   %eax,%eax
  8018cd:	75 08                	jne    8018d7 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8018cf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018d2:	e9 a5 00 00 00       	jmp    80197c <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8018d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018de:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018e5:	eb 69                	jmp    801950 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8018ec:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018f5:	89 d0                	mov    %edx,%eax
  8018f7:	01 c0                	add    %eax,%eax
  8018f9:	01 d0                	add    %edx,%eax
  8018fb:	c1 e0 03             	shl    $0x3,%eax
  8018fe:	01 c8                	add    %ecx,%eax
  801900:	8a 40 04             	mov    0x4(%eax),%al
  801903:	84 c0                	test   %al,%al
  801905:	75 46                	jne    80194d <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801907:	a1 20 30 80 00       	mov    0x803020,%eax
  80190c:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801912:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801915:	89 d0                	mov    %edx,%eax
  801917:	01 c0                	add    %eax,%eax
  801919:	01 d0                	add    %edx,%eax
  80191b:	c1 e0 03             	shl    $0x3,%eax
  80191e:	01 c8                	add    %ecx,%eax
  801920:	8b 00                	mov    (%eax),%eax
  801922:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801925:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801928:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80192d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80192f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801932:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	01 c8                	add    %ecx,%eax
  80193e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801940:	39 c2                	cmp    %eax,%edx
  801942:	75 09                	jne    80194d <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801944:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80194b:	eb 15                	jmp    801962 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80194d:	ff 45 e8             	incl   -0x18(%ebp)
  801950:	a1 20 30 80 00       	mov    0x803020,%eax
  801955:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80195b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80195e:	39 c2                	cmp    %eax,%edx
  801960:	77 85                	ja     8018e7 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801962:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801966:	75 14                	jne    80197c <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801968:	83 ec 04             	sub    $0x4,%esp
  80196b:	68 f4 22 80 00       	push   $0x8022f4
  801970:	6a 3a                	push   $0x3a
  801972:	68 e8 22 80 00       	push   $0x8022e8
  801977:	e8 88 fe ff ff       	call   801804 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80197c:	ff 45 f0             	incl   -0x10(%ebp)
  80197f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801982:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801985:	0f 8c 2f ff ff ff    	jl     8018ba <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80198b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801992:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801999:	eb 26                	jmp    8019c1 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80199b:	a1 20 30 80 00       	mov    0x803020,%eax
  8019a0:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8019a6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019a9:	89 d0                	mov    %edx,%eax
  8019ab:	01 c0                	add    %eax,%eax
  8019ad:	01 d0                	add    %edx,%eax
  8019af:	c1 e0 03             	shl    $0x3,%eax
  8019b2:	01 c8                	add    %ecx,%eax
  8019b4:	8a 40 04             	mov    0x4(%eax),%al
  8019b7:	3c 01                	cmp    $0x1,%al
  8019b9:	75 03                	jne    8019be <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019bb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019be:	ff 45 e0             	incl   -0x20(%ebp)
  8019c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8019c6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019cf:	39 c2                	cmp    %eax,%edx
  8019d1:	77 c8                	ja     80199b <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019d9:	74 14                	je     8019ef <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8019db:	83 ec 04             	sub    $0x4,%esp
  8019de:	68 48 23 80 00       	push   $0x802348
  8019e3:	6a 44                	push   $0x44
  8019e5:	68 e8 22 80 00       	push   $0x8022e8
  8019ea:	e8 15 fe ff ff       	call   801804 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019ef:	90                   	nop
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    
  8019f2:	66 90                	xchg   %ax,%ax

008019f4 <__udivdi3>:
  8019f4:	55                   	push   %ebp
  8019f5:	57                   	push   %edi
  8019f6:	56                   	push   %esi
  8019f7:	53                   	push   %ebx
  8019f8:	83 ec 1c             	sub    $0x1c,%esp
  8019fb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019ff:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a03:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a07:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a0b:	89 ca                	mov    %ecx,%edx
  801a0d:	89 f8                	mov    %edi,%eax
  801a0f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a13:	85 f6                	test   %esi,%esi
  801a15:	75 2d                	jne    801a44 <__udivdi3+0x50>
  801a17:	39 cf                	cmp    %ecx,%edi
  801a19:	77 65                	ja     801a80 <__udivdi3+0x8c>
  801a1b:	89 fd                	mov    %edi,%ebp
  801a1d:	85 ff                	test   %edi,%edi
  801a1f:	75 0b                	jne    801a2c <__udivdi3+0x38>
  801a21:	b8 01 00 00 00       	mov    $0x1,%eax
  801a26:	31 d2                	xor    %edx,%edx
  801a28:	f7 f7                	div    %edi
  801a2a:	89 c5                	mov    %eax,%ebp
  801a2c:	31 d2                	xor    %edx,%edx
  801a2e:	89 c8                	mov    %ecx,%eax
  801a30:	f7 f5                	div    %ebp
  801a32:	89 c1                	mov    %eax,%ecx
  801a34:	89 d8                	mov    %ebx,%eax
  801a36:	f7 f5                	div    %ebp
  801a38:	89 cf                	mov    %ecx,%edi
  801a3a:	89 fa                	mov    %edi,%edx
  801a3c:	83 c4 1c             	add    $0x1c,%esp
  801a3f:	5b                   	pop    %ebx
  801a40:	5e                   	pop    %esi
  801a41:	5f                   	pop    %edi
  801a42:	5d                   	pop    %ebp
  801a43:	c3                   	ret    
  801a44:	39 ce                	cmp    %ecx,%esi
  801a46:	77 28                	ja     801a70 <__udivdi3+0x7c>
  801a48:	0f bd fe             	bsr    %esi,%edi
  801a4b:	83 f7 1f             	xor    $0x1f,%edi
  801a4e:	75 40                	jne    801a90 <__udivdi3+0x9c>
  801a50:	39 ce                	cmp    %ecx,%esi
  801a52:	72 0a                	jb     801a5e <__udivdi3+0x6a>
  801a54:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a58:	0f 87 9e 00 00 00    	ja     801afc <__udivdi3+0x108>
  801a5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a63:	89 fa                	mov    %edi,%edx
  801a65:	83 c4 1c             	add    $0x1c,%esp
  801a68:	5b                   	pop    %ebx
  801a69:	5e                   	pop    %esi
  801a6a:	5f                   	pop    %edi
  801a6b:	5d                   	pop    %ebp
  801a6c:	c3                   	ret    
  801a6d:	8d 76 00             	lea    0x0(%esi),%esi
  801a70:	31 ff                	xor    %edi,%edi
  801a72:	31 c0                	xor    %eax,%eax
  801a74:	89 fa                	mov    %edi,%edx
  801a76:	83 c4 1c             	add    $0x1c,%esp
  801a79:	5b                   	pop    %ebx
  801a7a:	5e                   	pop    %esi
  801a7b:	5f                   	pop    %edi
  801a7c:	5d                   	pop    %ebp
  801a7d:	c3                   	ret    
  801a7e:	66 90                	xchg   %ax,%ax
  801a80:	89 d8                	mov    %ebx,%eax
  801a82:	f7 f7                	div    %edi
  801a84:	31 ff                	xor    %edi,%edi
  801a86:	89 fa                	mov    %edi,%edx
  801a88:	83 c4 1c             	add    $0x1c,%esp
  801a8b:	5b                   	pop    %ebx
  801a8c:	5e                   	pop    %esi
  801a8d:	5f                   	pop    %edi
  801a8e:	5d                   	pop    %ebp
  801a8f:	c3                   	ret    
  801a90:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a95:	89 eb                	mov    %ebp,%ebx
  801a97:	29 fb                	sub    %edi,%ebx
  801a99:	89 f9                	mov    %edi,%ecx
  801a9b:	d3 e6                	shl    %cl,%esi
  801a9d:	89 c5                	mov    %eax,%ebp
  801a9f:	88 d9                	mov    %bl,%cl
  801aa1:	d3 ed                	shr    %cl,%ebp
  801aa3:	89 e9                	mov    %ebp,%ecx
  801aa5:	09 f1                	or     %esi,%ecx
  801aa7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aab:	89 f9                	mov    %edi,%ecx
  801aad:	d3 e0                	shl    %cl,%eax
  801aaf:	89 c5                	mov    %eax,%ebp
  801ab1:	89 d6                	mov    %edx,%esi
  801ab3:	88 d9                	mov    %bl,%cl
  801ab5:	d3 ee                	shr    %cl,%esi
  801ab7:	89 f9                	mov    %edi,%ecx
  801ab9:	d3 e2                	shl    %cl,%edx
  801abb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801abf:	88 d9                	mov    %bl,%cl
  801ac1:	d3 e8                	shr    %cl,%eax
  801ac3:	09 c2                	or     %eax,%edx
  801ac5:	89 d0                	mov    %edx,%eax
  801ac7:	89 f2                	mov    %esi,%edx
  801ac9:	f7 74 24 0c          	divl   0xc(%esp)
  801acd:	89 d6                	mov    %edx,%esi
  801acf:	89 c3                	mov    %eax,%ebx
  801ad1:	f7 e5                	mul    %ebp
  801ad3:	39 d6                	cmp    %edx,%esi
  801ad5:	72 19                	jb     801af0 <__udivdi3+0xfc>
  801ad7:	74 0b                	je     801ae4 <__udivdi3+0xf0>
  801ad9:	89 d8                	mov    %ebx,%eax
  801adb:	31 ff                	xor    %edi,%edi
  801add:	e9 58 ff ff ff       	jmp    801a3a <__udivdi3+0x46>
  801ae2:	66 90                	xchg   %ax,%ax
  801ae4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ae8:	89 f9                	mov    %edi,%ecx
  801aea:	d3 e2                	shl    %cl,%edx
  801aec:	39 c2                	cmp    %eax,%edx
  801aee:	73 e9                	jae    801ad9 <__udivdi3+0xe5>
  801af0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801af3:	31 ff                	xor    %edi,%edi
  801af5:	e9 40 ff ff ff       	jmp    801a3a <__udivdi3+0x46>
  801afa:	66 90                	xchg   %ax,%ax
  801afc:	31 c0                	xor    %eax,%eax
  801afe:	e9 37 ff ff ff       	jmp    801a3a <__udivdi3+0x46>
  801b03:	90                   	nop

00801b04 <__umoddi3>:
  801b04:	55                   	push   %ebp
  801b05:	57                   	push   %edi
  801b06:	56                   	push   %esi
  801b07:	53                   	push   %ebx
  801b08:	83 ec 1c             	sub    $0x1c,%esp
  801b0b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b0f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b17:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b1b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b1f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b23:	89 f3                	mov    %esi,%ebx
  801b25:	89 fa                	mov    %edi,%edx
  801b27:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b2b:	89 34 24             	mov    %esi,(%esp)
  801b2e:	85 c0                	test   %eax,%eax
  801b30:	75 1a                	jne    801b4c <__umoddi3+0x48>
  801b32:	39 f7                	cmp    %esi,%edi
  801b34:	0f 86 a2 00 00 00    	jbe    801bdc <__umoddi3+0xd8>
  801b3a:	89 c8                	mov    %ecx,%eax
  801b3c:	89 f2                	mov    %esi,%edx
  801b3e:	f7 f7                	div    %edi
  801b40:	89 d0                	mov    %edx,%eax
  801b42:	31 d2                	xor    %edx,%edx
  801b44:	83 c4 1c             	add    $0x1c,%esp
  801b47:	5b                   	pop    %ebx
  801b48:	5e                   	pop    %esi
  801b49:	5f                   	pop    %edi
  801b4a:	5d                   	pop    %ebp
  801b4b:	c3                   	ret    
  801b4c:	39 f0                	cmp    %esi,%eax
  801b4e:	0f 87 ac 00 00 00    	ja     801c00 <__umoddi3+0xfc>
  801b54:	0f bd e8             	bsr    %eax,%ebp
  801b57:	83 f5 1f             	xor    $0x1f,%ebp
  801b5a:	0f 84 ac 00 00 00    	je     801c0c <__umoddi3+0x108>
  801b60:	bf 20 00 00 00       	mov    $0x20,%edi
  801b65:	29 ef                	sub    %ebp,%edi
  801b67:	89 fe                	mov    %edi,%esi
  801b69:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b6d:	89 e9                	mov    %ebp,%ecx
  801b6f:	d3 e0                	shl    %cl,%eax
  801b71:	89 d7                	mov    %edx,%edi
  801b73:	89 f1                	mov    %esi,%ecx
  801b75:	d3 ef                	shr    %cl,%edi
  801b77:	09 c7                	or     %eax,%edi
  801b79:	89 e9                	mov    %ebp,%ecx
  801b7b:	d3 e2                	shl    %cl,%edx
  801b7d:	89 14 24             	mov    %edx,(%esp)
  801b80:	89 d8                	mov    %ebx,%eax
  801b82:	d3 e0                	shl    %cl,%eax
  801b84:	89 c2                	mov    %eax,%edx
  801b86:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b8a:	d3 e0                	shl    %cl,%eax
  801b8c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b90:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b94:	89 f1                	mov    %esi,%ecx
  801b96:	d3 e8                	shr    %cl,%eax
  801b98:	09 d0                	or     %edx,%eax
  801b9a:	d3 eb                	shr    %cl,%ebx
  801b9c:	89 da                	mov    %ebx,%edx
  801b9e:	f7 f7                	div    %edi
  801ba0:	89 d3                	mov    %edx,%ebx
  801ba2:	f7 24 24             	mull   (%esp)
  801ba5:	89 c6                	mov    %eax,%esi
  801ba7:	89 d1                	mov    %edx,%ecx
  801ba9:	39 d3                	cmp    %edx,%ebx
  801bab:	0f 82 87 00 00 00    	jb     801c38 <__umoddi3+0x134>
  801bb1:	0f 84 91 00 00 00    	je     801c48 <__umoddi3+0x144>
  801bb7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bbb:	29 f2                	sub    %esi,%edx
  801bbd:	19 cb                	sbb    %ecx,%ebx
  801bbf:	89 d8                	mov    %ebx,%eax
  801bc1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bc5:	d3 e0                	shl    %cl,%eax
  801bc7:	89 e9                	mov    %ebp,%ecx
  801bc9:	d3 ea                	shr    %cl,%edx
  801bcb:	09 d0                	or     %edx,%eax
  801bcd:	89 e9                	mov    %ebp,%ecx
  801bcf:	d3 eb                	shr    %cl,%ebx
  801bd1:	89 da                	mov    %ebx,%edx
  801bd3:	83 c4 1c             	add    $0x1c,%esp
  801bd6:	5b                   	pop    %ebx
  801bd7:	5e                   	pop    %esi
  801bd8:	5f                   	pop    %edi
  801bd9:	5d                   	pop    %ebp
  801bda:	c3                   	ret    
  801bdb:	90                   	nop
  801bdc:	89 fd                	mov    %edi,%ebp
  801bde:	85 ff                	test   %edi,%edi
  801be0:	75 0b                	jne    801bed <__umoddi3+0xe9>
  801be2:	b8 01 00 00 00       	mov    $0x1,%eax
  801be7:	31 d2                	xor    %edx,%edx
  801be9:	f7 f7                	div    %edi
  801beb:	89 c5                	mov    %eax,%ebp
  801bed:	89 f0                	mov    %esi,%eax
  801bef:	31 d2                	xor    %edx,%edx
  801bf1:	f7 f5                	div    %ebp
  801bf3:	89 c8                	mov    %ecx,%eax
  801bf5:	f7 f5                	div    %ebp
  801bf7:	89 d0                	mov    %edx,%eax
  801bf9:	e9 44 ff ff ff       	jmp    801b42 <__umoddi3+0x3e>
  801bfe:	66 90                	xchg   %ax,%ax
  801c00:	89 c8                	mov    %ecx,%eax
  801c02:	89 f2                	mov    %esi,%edx
  801c04:	83 c4 1c             	add    $0x1c,%esp
  801c07:	5b                   	pop    %ebx
  801c08:	5e                   	pop    %esi
  801c09:	5f                   	pop    %edi
  801c0a:	5d                   	pop    %ebp
  801c0b:	c3                   	ret    
  801c0c:	3b 04 24             	cmp    (%esp),%eax
  801c0f:	72 06                	jb     801c17 <__umoddi3+0x113>
  801c11:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c15:	77 0f                	ja     801c26 <__umoddi3+0x122>
  801c17:	89 f2                	mov    %esi,%edx
  801c19:	29 f9                	sub    %edi,%ecx
  801c1b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c1f:	89 14 24             	mov    %edx,(%esp)
  801c22:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c26:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c2a:	8b 14 24             	mov    (%esp),%edx
  801c2d:	83 c4 1c             	add    $0x1c,%esp
  801c30:	5b                   	pop    %ebx
  801c31:	5e                   	pop    %esi
  801c32:	5f                   	pop    %edi
  801c33:	5d                   	pop    %ebp
  801c34:	c3                   	ret    
  801c35:	8d 76 00             	lea    0x0(%esi),%esi
  801c38:	2b 04 24             	sub    (%esp),%eax
  801c3b:	19 fa                	sbb    %edi,%edx
  801c3d:	89 d1                	mov    %edx,%ecx
  801c3f:	89 c6                	mov    %eax,%esi
  801c41:	e9 71 ff ff ff       	jmp    801bb7 <__umoddi3+0xb3>
  801c46:	66 90                	xchg   %ax,%ax
  801c48:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c4c:	72 ea                	jb     801c38 <__umoddi3+0x134>
  801c4e:	89 d9                	mov    %ebx,%ecx
  801c50:	e9 62 ff ff ff       	jmp    801bb7 <__umoddi3+0xb3>
