
obj/user/fos_data_on_stack:     file format elf32-i386


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
  800031:	e8 1e 00 00 00       	call   800054 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 40 1c 80 00       	push   $0x801c40
  800049:	e8 b8 03 00 00       	call   800406 <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	return;	
  800051:	90                   	nop
}
  800052:	c9                   	leave  
  800053:	c3                   	ret    

00800054 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800054:	55                   	push   %ebp
  800055:	89 e5                	mov    %esp,%ebp
  800057:	57                   	push   %edi
  800058:	56                   	push   %esi
  800059:	53                   	push   %ebx
  80005a:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800060:	e8 fb 14 00 00       	call   801560 <sys_getenvindex>
  800065:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800068:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80006b:	89 d0                	mov    %edx,%eax
  80006d:	c1 e0 03             	shl    $0x3,%eax
  800070:	01 d0                	add    %edx,%eax
  800072:	c1 e0 06             	shl    $0x6,%eax
  800075:	01 d0                	add    %edx,%eax
  800077:	c1 e0 03             	shl    $0x3,%eax
  80007a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80007f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800084:	a1 20 30 80 00       	mov    0x803020,%eax
  800089:	8a 40 10             	mov    0x10(%eax),%al
  80008c:	84 c0                	test   %al,%al
  80008e:	74 0d                	je     80009d <libmain+0x49>
		binaryname = myEnv->prog_name;
  800090:	a1 20 30 80 00       	mov    0x803020,%eax
  800095:	83 c0 10             	add    $0x10,%eax
  800098:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80009d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000a1:	7e 0a                	jle    8000ad <libmain+0x59>
		binaryname = argv[0];
  8000a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a6:	8b 00                	mov    (%eax),%eax
  8000a8:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 0c             	pushl  0xc(%ebp)
  8000b3:	ff 75 08             	pushl  0x8(%ebp)
  8000b6:	e8 7d ff ff ff       	call   800038 <_main>
  8000bb:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000be:	a1 00 30 80 00       	mov    0x803000,%eax
  8000c3:	85 c0                	test   %eax,%eax
  8000c5:	0f 84 b7 01 00 00    	je     800282 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000cb:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000d1:	bb a0 1d 80 00       	mov    $0x801da0,%ebx
  8000d6:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000db:	89 c7                	mov    %eax,%edi
  8000dd:	89 de                	mov    %ebx,%esi
  8000df:	89 d1                	mov    %edx,%ecx
  8000e1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000e3:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8000e9:	b9 56 00 00 00       	mov    $0x56,%ecx
  8000ee:	b0 00                	mov    $0x0,%al
  8000f0:	89 d7                	mov    %edx,%edi
  8000f2:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8000f4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8000fb:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8000fe:	83 ec 08             	sub    $0x8,%esp
  800101:	50                   	push   %eax
  800102:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800108:	50                   	push   %eax
  800109:	e8 52 16 00 00       	call   801760 <sys_utilities>
  80010e:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800111:	e8 d2 11 00 00       	call   8012e8 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800116:	83 ec 0c             	sub    $0xc,%esp
  800119:	68 7c 1c 80 00       	push   $0x801c7c
  80011e:	e8 71 02 00 00       	call   800394 <cprintf>
  800123:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800126:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800129:	85 c0                	test   %eax,%eax
  80012b:	74 58                	je     800185 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80012d:	e8 4c 16 00 00       	call   80177e <sys_get_optimal_num_faults>
  800132:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800135:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80013b:	bb 04 1e 80 00       	mov    $0x801e04,%ebx
  800140:	ba 11 00 00 00       	mov    $0x11,%edx
  800145:	89 c7                	mov    %eax,%edi
  800147:	89 de                	mov    %ebx,%esi
  800149:	89 d1                	mov    %edx,%ecx
  80014b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80014d:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800150:	b9 53 00 00 00       	mov    $0x53,%ecx
  800155:	b0 00                	mov    $0x0,%al
  800157:	89 d7                	mov    %edx,%edi
  800159:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80015b:	83 ec 08             	sub    $0x8,%esp
  80015e:	ff 75 dc             	pushl  -0x24(%ebp)
  800161:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800167:	50                   	push   %eax
  800168:	e8 f3 15 00 00       	call   801760 <sys_utilities>
  80016d:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 dc             	pushl  -0x24(%ebp)
  800176:	68 a4 1c 80 00       	push   $0x801ca4
  80017b:	e8 14 02 00 00       	call   800394 <cprintf>
  800180:	83 c4 10             	add    $0x10,%esp
  800183:	eb 59                	jmp    8001de <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800190:	a1 20 30 80 00       	mov    0x803020,%eax
  800195:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80019b:	83 ec 04             	sub    $0x4,%esp
  80019e:	52                   	push   %edx
  80019f:	50                   	push   %eax
  8001a0:	68 c8 1c 80 00       	push   $0x801cc8
  8001a5:	e8 ea 01 00 00       	call   800394 <cprintf>
  8001aa:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b2:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001ce:	51                   	push   %ecx
  8001cf:	52                   	push   %edx
  8001d0:	50                   	push   %eax
  8001d1:	68 f0 1c 80 00       	push   $0x801cf0
  8001d6:	e8 b9 01 00 00       	call   800394 <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001de:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e3:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8001e9:	83 ec 08             	sub    $0x8,%esp
  8001ec:	50                   	push   %eax
  8001ed:	68 48 1d 80 00       	push   $0x801d48
  8001f2:	e8 9d 01 00 00       	call   800394 <cprintf>
  8001f7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8001fa:	83 ec 0c             	sub    $0xc,%esp
  8001fd:	68 5c 1d 80 00       	push   $0x801d5c
  800202:	e8 8d 01 00 00       	call   800394 <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80020a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800211:	eb 28                	jmp    80023b <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800213:	a1 20 30 80 00       	mov    0x803020,%eax
  800218:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80021b:	81 c2 74 04 00 00    	add    $0x474,%edx
  800221:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	50                   	push   %eax
  800228:	ff 75 e4             	pushl  -0x1c(%ebp)
  80022b:	68 73 1d 80 00       	push   $0x801d73
  800230:	e8 5f 01 00 00       	call   800394 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800238:	ff 45 e4             	incl   -0x1c(%ebp)
  80023b:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80023f:	7e d2                	jle    800213 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800241:	83 ec 0c             	sub    $0xc,%esp
  800244:	68 82 1d 80 00       	push   $0x801d82
  800249:	e8 46 01 00 00       	call   800394 <cprintf>
  80024e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800251:	a1 20 30 80 00       	mov    0x803020,%eax
  800256:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80025c:	83 ec 08             	sub    $0x8,%esp
  80025f:	50                   	push   %eax
  800260:	68 86 1d 80 00       	push   $0x801d86
  800265:	e8 2a 01 00 00       	call   800394 <cprintf>
  80026a:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80026d:	83 ec 0c             	sub    $0xc,%esp
  800270:	68 7c 1c 80 00       	push   $0x801c7c
  800275:	e8 1a 01 00 00       	call   800394 <cprintf>
  80027a:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80027d:	e8 80 10 00 00       	call   801302 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800282:	e8 1f 00 00 00       	call   8002a6 <exit>
}
  800287:	90                   	nop
  800288:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80028b:	5b                   	pop    %ebx
  80028c:	5e                   	pop    %esi
  80028d:	5f                   	pop    %edi
  80028e:	5d                   	pop    %ebp
  80028f:	c3                   	ret    

00800290 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800290:	55                   	push   %ebp
  800291:	89 e5                	mov    %esp,%ebp
  800293:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800296:	83 ec 0c             	sub    $0xc,%esp
  800299:	6a 00                	push   $0x0
  80029b:	e8 8c 12 00 00       	call   80152c <sys_destroy_env>
  8002a0:	83 c4 10             	add    $0x10,%esp
}
  8002a3:	90                   	nop
  8002a4:	c9                   	leave  
  8002a5:	c3                   	ret    

008002a6 <exit>:

void
exit(void)
{
  8002a6:	55                   	push   %ebp
  8002a7:	89 e5                	mov    %esp,%ebp
  8002a9:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002ac:	e8 e1 12 00 00       	call   801592 <sys_exit_env>
}
  8002b1:	90                   	nop
  8002b2:	c9                   	leave  
  8002b3:	c3                   	ret    

008002b4 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8002b4:	55                   	push   %ebp
  8002b5:	89 e5                	mov    %esp,%ebp
  8002b7:	53                   	push   %ebx
  8002b8:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8002bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002be:	8b 00                	mov    (%eax),%eax
  8002c0:	8d 48 01             	lea    0x1(%eax),%ecx
  8002c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c6:	89 0a                	mov    %ecx,(%edx)
  8002c8:	8b 55 08             	mov    0x8(%ebp),%edx
  8002cb:	88 d1                	mov    %dl,%cl
  8002cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002d0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d7:	8b 00                	mov    (%eax),%eax
  8002d9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002de:	75 30                	jne    800310 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8002e0:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8002e6:	a0 40 30 80 00       	mov    0x803040,%al
  8002eb:	0f b6 c0             	movzbl %al,%eax
  8002ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002f1:	8b 09                	mov    (%ecx),%ecx
  8002f3:	89 cb                	mov    %ecx,%ebx
  8002f5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002f8:	83 c1 08             	add    $0x8,%ecx
  8002fb:	52                   	push   %edx
  8002fc:	50                   	push   %eax
  8002fd:	53                   	push   %ebx
  8002fe:	51                   	push   %ecx
  8002ff:	e8 a0 0f 00 00       	call   8012a4 <sys_cputs>
  800304:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800307:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800310:	8b 45 0c             	mov    0xc(%ebp),%eax
  800313:	8b 40 04             	mov    0x4(%eax),%eax
  800316:	8d 50 01             	lea    0x1(%eax),%edx
  800319:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80031f:	90                   	nop
  800320:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800323:	c9                   	leave  
  800324:	c3                   	ret    

00800325 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800325:	55                   	push   %ebp
  800326:	89 e5                	mov    %esp,%ebp
  800328:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80032e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800335:	00 00 00 
	b.cnt = 0;
  800338:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80033f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800342:	ff 75 0c             	pushl  0xc(%ebp)
  800345:	ff 75 08             	pushl  0x8(%ebp)
  800348:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80034e:	50                   	push   %eax
  80034f:	68 b4 02 80 00       	push   $0x8002b4
  800354:	e8 5a 02 00 00       	call   8005b3 <vprintfmt>
  800359:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80035c:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800362:	a0 40 30 80 00       	mov    0x803040,%al
  800367:	0f b6 c0             	movzbl %al,%eax
  80036a:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800370:	52                   	push   %edx
  800371:	50                   	push   %eax
  800372:	51                   	push   %ecx
  800373:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800379:	83 c0 08             	add    $0x8,%eax
  80037c:	50                   	push   %eax
  80037d:	e8 22 0f 00 00       	call   8012a4 <sys_cputs>
  800382:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800385:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  80038c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800392:	c9                   	leave  
  800393:	c3                   	ret    

00800394 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800394:	55                   	push   %ebp
  800395:	89 e5                	mov    %esp,%ebp
  800397:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80039a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8003a1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	83 ec 08             	sub    $0x8,%esp
  8003ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b0:	50                   	push   %eax
  8003b1:	e8 6f ff ff ff       	call   800325 <vcprintf>
  8003b6:	83 c4 10             	add    $0x10,%esp
  8003b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003bf:	c9                   	leave  
  8003c0:	c3                   	ret    

008003c1 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8003c1:	55                   	push   %ebp
  8003c2:	89 e5                	mov    %esp,%ebp
  8003c4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003c7:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	c1 e0 08             	shl    $0x8,%eax
  8003d4:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8003d9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003dc:	83 c0 04             	add    $0x4,%eax
  8003df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e5:	83 ec 08             	sub    $0x8,%esp
  8003e8:	ff 75 f4             	pushl  -0xc(%ebp)
  8003eb:	50                   	push   %eax
  8003ec:	e8 34 ff ff ff       	call   800325 <vcprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
  8003f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8003f7:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  8003fe:	07 00 00 

	return cnt;
  800401:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800404:	c9                   	leave  
  800405:	c3                   	ret    

00800406 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800406:	55                   	push   %ebp
  800407:	89 e5                	mov    %esp,%ebp
  800409:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80040c:	e8 d7 0e 00 00       	call   8012e8 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800411:	8d 45 0c             	lea    0xc(%ebp),%eax
  800414:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	83 ec 08             	sub    $0x8,%esp
  80041d:	ff 75 f4             	pushl  -0xc(%ebp)
  800420:	50                   	push   %eax
  800421:	e8 ff fe ff ff       	call   800325 <vcprintf>
  800426:	83 c4 10             	add    $0x10,%esp
  800429:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80042c:	e8 d1 0e 00 00       	call   801302 <sys_unlock_cons>
	return cnt;
  800431:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800434:	c9                   	leave  
  800435:	c3                   	ret    

00800436 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800436:	55                   	push   %ebp
  800437:	89 e5                	mov    %esp,%ebp
  800439:	53                   	push   %ebx
  80043a:	83 ec 14             	sub    $0x14,%esp
  80043d:	8b 45 10             	mov    0x10(%ebp),%eax
  800440:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800443:	8b 45 14             	mov    0x14(%ebp),%eax
  800446:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800449:	8b 45 18             	mov    0x18(%ebp),%eax
  80044c:	ba 00 00 00 00       	mov    $0x0,%edx
  800451:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800454:	77 55                	ja     8004ab <printnum+0x75>
  800456:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800459:	72 05                	jb     800460 <printnum+0x2a>
  80045b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80045e:	77 4b                	ja     8004ab <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800460:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800463:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800466:	8b 45 18             	mov    0x18(%ebp),%eax
  800469:	ba 00 00 00 00       	mov    $0x0,%edx
  80046e:	52                   	push   %edx
  80046f:	50                   	push   %eax
  800470:	ff 75 f4             	pushl  -0xc(%ebp)
  800473:	ff 75 f0             	pushl  -0x10(%ebp)
  800476:	e8 61 15 00 00       	call   8019dc <__udivdi3>
  80047b:	83 c4 10             	add    $0x10,%esp
  80047e:	83 ec 04             	sub    $0x4,%esp
  800481:	ff 75 20             	pushl  0x20(%ebp)
  800484:	53                   	push   %ebx
  800485:	ff 75 18             	pushl  0x18(%ebp)
  800488:	52                   	push   %edx
  800489:	50                   	push   %eax
  80048a:	ff 75 0c             	pushl  0xc(%ebp)
  80048d:	ff 75 08             	pushl  0x8(%ebp)
  800490:	e8 a1 ff ff ff       	call   800436 <printnum>
  800495:	83 c4 20             	add    $0x20,%esp
  800498:	eb 1a                	jmp    8004b4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80049a:	83 ec 08             	sub    $0x8,%esp
  80049d:	ff 75 0c             	pushl  0xc(%ebp)
  8004a0:	ff 75 20             	pushl  0x20(%ebp)
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	ff d0                	call   *%eax
  8004a8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004ab:	ff 4d 1c             	decl   0x1c(%ebp)
  8004ae:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004b2:	7f e6                	jg     80049a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004b4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004b7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004c2:	53                   	push   %ebx
  8004c3:	51                   	push   %ecx
  8004c4:	52                   	push   %edx
  8004c5:	50                   	push   %eax
  8004c6:	e8 21 16 00 00       	call   801aec <__umoddi3>
  8004cb:	83 c4 10             	add    $0x10,%esp
  8004ce:	05 94 20 80 00       	add    $0x802094,%eax
  8004d3:	8a 00                	mov    (%eax),%al
  8004d5:	0f be c0             	movsbl %al,%eax
  8004d8:	83 ec 08             	sub    $0x8,%esp
  8004db:	ff 75 0c             	pushl  0xc(%ebp)
  8004de:	50                   	push   %eax
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	ff d0                	call   *%eax
  8004e4:	83 c4 10             	add    $0x10,%esp
}
  8004e7:	90                   	nop
  8004e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004eb:	c9                   	leave  
  8004ec:	c3                   	ret    

008004ed <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004ed:	55                   	push   %ebp
  8004ee:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004f0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004f4:	7e 1c                	jle    800512 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	8d 50 08             	lea    0x8(%eax),%edx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	89 10                	mov    %edx,(%eax)
  800503:	8b 45 08             	mov    0x8(%ebp),%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 e8 08             	sub    $0x8,%eax
  80050b:	8b 50 04             	mov    0x4(%eax),%edx
  80050e:	8b 00                	mov    (%eax),%eax
  800510:	eb 40                	jmp    800552 <getuint+0x65>
	else if (lflag)
  800512:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800516:	74 1e                	je     800536 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800518:	8b 45 08             	mov    0x8(%ebp),%eax
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	8d 50 04             	lea    0x4(%eax),%edx
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	89 10                	mov    %edx,(%eax)
  800525:	8b 45 08             	mov    0x8(%ebp),%eax
  800528:	8b 00                	mov    (%eax),%eax
  80052a:	83 e8 04             	sub    $0x4,%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	ba 00 00 00 00       	mov    $0x0,%edx
  800534:	eb 1c                	jmp    800552 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800536:	8b 45 08             	mov    0x8(%ebp),%eax
  800539:	8b 00                	mov    (%eax),%eax
  80053b:	8d 50 04             	lea    0x4(%eax),%edx
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	89 10                	mov    %edx,(%eax)
  800543:	8b 45 08             	mov    0x8(%ebp),%eax
  800546:	8b 00                	mov    (%eax),%eax
  800548:	83 e8 04             	sub    $0x4,%eax
  80054b:	8b 00                	mov    (%eax),%eax
  80054d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800552:	5d                   	pop    %ebp
  800553:	c3                   	ret    

00800554 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800554:	55                   	push   %ebp
  800555:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800557:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80055b:	7e 1c                	jle    800579 <getint+0x25>
		return va_arg(*ap, long long);
  80055d:	8b 45 08             	mov    0x8(%ebp),%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	8d 50 08             	lea    0x8(%eax),%edx
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	89 10                	mov    %edx,(%eax)
  80056a:	8b 45 08             	mov    0x8(%ebp),%eax
  80056d:	8b 00                	mov    (%eax),%eax
  80056f:	83 e8 08             	sub    $0x8,%eax
  800572:	8b 50 04             	mov    0x4(%eax),%edx
  800575:	8b 00                	mov    (%eax),%eax
  800577:	eb 38                	jmp    8005b1 <getint+0x5d>
	else if (lflag)
  800579:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80057d:	74 1a                	je     800599 <getint+0x45>
		return va_arg(*ap, long);
  80057f:	8b 45 08             	mov    0x8(%ebp),%eax
  800582:	8b 00                	mov    (%eax),%eax
  800584:	8d 50 04             	lea    0x4(%eax),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	89 10                	mov    %edx,(%eax)
  80058c:	8b 45 08             	mov    0x8(%ebp),%eax
  80058f:	8b 00                	mov    (%eax),%eax
  800591:	83 e8 04             	sub    $0x4,%eax
  800594:	8b 00                	mov    (%eax),%eax
  800596:	99                   	cltd   
  800597:	eb 18                	jmp    8005b1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	8b 00                	mov    (%eax),%eax
  80059e:	8d 50 04             	lea    0x4(%eax),%edx
  8005a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a4:	89 10                	mov    %edx,(%eax)
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	8b 00                	mov    (%eax),%eax
  8005ab:	83 e8 04             	sub    $0x4,%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	99                   	cltd   
}
  8005b1:	5d                   	pop    %ebp
  8005b2:	c3                   	ret    

008005b3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005b3:	55                   	push   %ebp
  8005b4:	89 e5                	mov    %esp,%ebp
  8005b6:	56                   	push   %esi
  8005b7:	53                   	push   %ebx
  8005b8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005bb:	eb 17                	jmp    8005d4 <vprintfmt+0x21>
			if (ch == '\0')
  8005bd:	85 db                	test   %ebx,%ebx
  8005bf:	0f 84 c1 03 00 00    	je     800986 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8005c5:	83 ec 08             	sub    $0x8,%esp
  8005c8:	ff 75 0c             	pushl  0xc(%ebp)
  8005cb:	53                   	push   %ebx
  8005cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cf:	ff d0                	call   *%eax
  8005d1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d7:	8d 50 01             	lea    0x1(%eax),%edx
  8005da:	89 55 10             	mov    %edx,0x10(%ebp)
  8005dd:	8a 00                	mov    (%eax),%al
  8005df:	0f b6 d8             	movzbl %al,%ebx
  8005e2:	83 fb 25             	cmp    $0x25,%ebx
  8005e5:	75 d6                	jne    8005bd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005e7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005eb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005f2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800600:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800607:	8b 45 10             	mov    0x10(%ebp),%eax
  80060a:	8d 50 01             	lea    0x1(%eax),%edx
  80060d:	89 55 10             	mov    %edx,0x10(%ebp)
  800610:	8a 00                	mov    (%eax),%al
  800612:	0f b6 d8             	movzbl %al,%ebx
  800615:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800618:	83 f8 5b             	cmp    $0x5b,%eax
  80061b:	0f 87 3d 03 00 00    	ja     80095e <vprintfmt+0x3ab>
  800621:	8b 04 85 b8 20 80 00 	mov    0x8020b8(,%eax,4),%eax
  800628:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80062a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80062e:	eb d7                	jmp    800607 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800630:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800634:	eb d1                	jmp    800607 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800636:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80063d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800640:	89 d0                	mov    %edx,%eax
  800642:	c1 e0 02             	shl    $0x2,%eax
  800645:	01 d0                	add    %edx,%eax
  800647:	01 c0                	add    %eax,%eax
  800649:	01 d8                	add    %ebx,%eax
  80064b:	83 e8 30             	sub    $0x30,%eax
  80064e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800651:	8b 45 10             	mov    0x10(%ebp),%eax
  800654:	8a 00                	mov    (%eax),%al
  800656:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800659:	83 fb 2f             	cmp    $0x2f,%ebx
  80065c:	7e 3e                	jle    80069c <vprintfmt+0xe9>
  80065e:	83 fb 39             	cmp    $0x39,%ebx
  800661:	7f 39                	jg     80069c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800663:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800666:	eb d5                	jmp    80063d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800668:	8b 45 14             	mov    0x14(%ebp),%eax
  80066b:	83 c0 04             	add    $0x4,%eax
  80066e:	89 45 14             	mov    %eax,0x14(%ebp)
  800671:	8b 45 14             	mov    0x14(%ebp),%eax
  800674:	83 e8 04             	sub    $0x4,%eax
  800677:	8b 00                	mov    (%eax),%eax
  800679:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80067c:	eb 1f                	jmp    80069d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80067e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800682:	79 83                	jns    800607 <vprintfmt+0x54>
				width = 0;
  800684:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80068b:	e9 77 ff ff ff       	jmp    800607 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800690:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800697:	e9 6b ff ff ff       	jmp    800607 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80069c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80069d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a1:	0f 89 60 ff ff ff    	jns    800607 <vprintfmt+0x54>
				width = precision, precision = -1;
  8006a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006ad:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006b4:	e9 4e ff ff ff       	jmp    800607 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006b9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006bc:	e9 46 ff ff ff       	jmp    800607 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c4:	83 c0 04             	add    $0x4,%eax
  8006c7:	89 45 14             	mov    %eax,0x14(%ebp)
  8006ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8006cd:	83 e8 04             	sub    $0x4,%eax
  8006d0:	8b 00                	mov    (%eax),%eax
  8006d2:	83 ec 08             	sub    $0x8,%esp
  8006d5:	ff 75 0c             	pushl  0xc(%ebp)
  8006d8:	50                   	push   %eax
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	ff d0                	call   *%eax
  8006de:	83 c4 10             	add    $0x10,%esp
			break;
  8006e1:	e9 9b 02 00 00       	jmp    800981 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e9:	83 c0 04             	add    $0x4,%eax
  8006ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8006ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f2:	83 e8 04             	sub    $0x4,%eax
  8006f5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006f7:	85 db                	test   %ebx,%ebx
  8006f9:	79 02                	jns    8006fd <vprintfmt+0x14a>
				err = -err;
  8006fb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006fd:	83 fb 64             	cmp    $0x64,%ebx
  800700:	7f 0b                	jg     80070d <vprintfmt+0x15a>
  800702:	8b 34 9d 00 1f 80 00 	mov    0x801f00(,%ebx,4),%esi
  800709:	85 f6                	test   %esi,%esi
  80070b:	75 19                	jne    800726 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80070d:	53                   	push   %ebx
  80070e:	68 a5 20 80 00       	push   $0x8020a5
  800713:	ff 75 0c             	pushl  0xc(%ebp)
  800716:	ff 75 08             	pushl  0x8(%ebp)
  800719:	e8 70 02 00 00       	call   80098e <printfmt>
  80071e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800721:	e9 5b 02 00 00       	jmp    800981 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800726:	56                   	push   %esi
  800727:	68 ae 20 80 00       	push   $0x8020ae
  80072c:	ff 75 0c             	pushl  0xc(%ebp)
  80072f:	ff 75 08             	pushl  0x8(%ebp)
  800732:	e8 57 02 00 00       	call   80098e <printfmt>
  800737:	83 c4 10             	add    $0x10,%esp
			break;
  80073a:	e9 42 02 00 00       	jmp    800981 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80073f:	8b 45 14             	mov    0x14(%ebp),%eax
  800742:	83 c0 04             	add    $0x4,%eax
  800745:	89 45 14             	mov    %eax,0x14(%ebp)
  800748:	8b 45 14             	mov    0x14(%ebp),%eax
  80074b:	83 e8 04             	sub    $0x4,%eax
  80074e:	8b 30                	mov    (%eax),%esi
  800750:	85 f6                	test   %esi,%esi
  800752:	75 05                	jne    800759 <vprintfmt+0x1a6>
				p = "(null)";
  800754:	be b1 20 80 00       	mov    $0x8020b1,%esi
			if (width > 0 && padc != '-')
  800759:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075d:	7e 6d                	jle    8007cc <vprintfmt+0x219>
  80075f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800763:	74 67                	je     8007cc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800765:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	50                   	push   %eax
  80076c:	56                   	push   %esi
  80076d:	e8 1e 03 00 00       	call   800a90 <strnlen>
  800772:	83 c4 10             	add    $0x10,%esp
  800775:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800778:	eb 16                	jmp    800790 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80077a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 0c             	pushl  0xc(%ebp)
  800784:	50                   	push   %eax
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	ff d0                	call   *%eax
  80078a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80078d:	ff 4d e4             	decl   -0x1c(%ebp)
  800790:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800794:	7f e4                	jg     80077a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800796:	eb 34                	jmp    8007cc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800798:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80079c:	74 1c                	je     8007ba <vprintfmt+0x207>
  80079e:	83 fb 1f             	cmp    $0x1f,%ebx
  8007a1:	7e 05                	jle    8007a8 <vprintfmt+0x1f5>
  8007a3:	83 fb 7e             	cmp    $0x7e,%ebx
  8007a6:	7e 12                	jle    8007ba <vprintfmt+0x207>
					putch('?', putdat);
  8007a8:	83 ec 08             	sub    $0x8,%esp
  8007ab:	ff 75 0c             	pushl  0xc(%ebp)
  8007ae:	6a 3f                	push   $0x3f
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	ff d0                	call   *%eax
  8007b5:	83 c4 10             	add    $0x10,%esp
  8007b8:	eb 0f                	jmp    8007c9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007ba:	83 ec 08             	sub    $0x8,%esp
  8007bd:	ff 75 0c             	pushl  0xc(%ebp)
  8007c0:	53                   	push   %ebx
  8007c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c4:	ff d0                	call   *%eax
  8007c6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007c9:	ff 4d e4             	decl   -0x1c(%ebp)
  8007cc:	89 f0                	mov    %esi,%eax
  8007ce:	8d 70 01             	lea    0x1(%eax),%esi
  8007d1:	8a 00                	mov    (%eax),%al
  8007d3:	0f be d8             	movsbl %al,%ebx
  8007d6:	85 db                	test   %ebx,%ebx
  8007d8:	74 24                	je     8007fe <vprintfmt+0x24b>
  8007da:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007de:	78 b8                	js     800798 <vprintfmt+0x1e5>
  8007e0:	ff 4d e0             	decl   -0x20(%ebp)
  8007e3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007e7:	79 af                	jns    800798 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007e9:	eb 13                	jmp    8007fe <vprintfmt+0x24b>
				putch(' ', putdat);
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 0c             	pushl  0xc(%ebp)
  8007f1:	6a 20                	push   $0x20
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	ff d0                	call   *%eax
  8007f8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007fb:	ff 4d e4             	decl   -0x1c(%ebp)
  8007fe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800802:	7f e7                	jg     8007eb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800804:	e9 78 01 00 00       	jmp    800981 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800809:	83 ec 08             	sub    $0x8,%esp
  80080c:	ff 75 e8             	pushl  -0x18(%ebp)
  80080f:	8d 45 14             	lea    0x14(%ebp),%eax
  800812:	50                   	push   %eax
  800813:	e8 3c fd ff ff       	call   800554 <getint>
  800818:	83 c4 10             	add    $0x10,%esp
  80081b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80081e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800821:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800824:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800827:	85 d2                	test   %edx,%edx
  800829:	79 23                	jns    80084e <vprintfmt+0x29b>
				putch('-', putdat);
  80082b:	83 ec 08             	sub    $0x8,%esp
  80082e:	ff 75 0c             	pushl  0xc(%ebp)
  800831:	6a 2d                	push   $0x2d
  800833:	8b 45 08             	mov    0x8(%ebp),%eax
  800836:	ff d0                	call   *%eax
  800838:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80083b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800841:	f7 d8                	neg    %eax
  800843:	83 d2 00             	adc    $0x0,%edx
  800846:	f7 da                	neg    %edx
  800848:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80084e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800855:	e9 bc 00 00 00       	jmp    800916 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80085a:	83 ec 08             	sub    $0x8,%esp
  80085d:	ff 75 e8             	pushl  -0x18(%ebp)
  800860:	8d 45 14             	lea    0x14(%ebp),%eax
  800863:	50                   	push   %eax
  800864:	e8 84 fc ff ff       	call   8004ed <getuint>
  800869:	83 c4 10             	add    $0x10,%esp
  80086c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800872:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800879:	e9 98 00 00 00       	jmp    800916 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	ff 75 0c             	pushl  0xc(%ebp)
  800884:	6a 58                	push   $0x58
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	ff d0                	call   *%eax
  80088b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	ff 75 0c             	pushl  0xc(%ebp)
  800894:	6a 58                	push   $0x58
  800896:	8b 45 08             	mov    0x8(%ebp),%eax
  800899:	ff d0                	call   *%eax
  80089b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80089e:	83 ec 08             	sub    $0x8,%esp
  8008a1:	ff 75 0c             	pushl  0xc(%ebp)
  8008a4:	6a 58                	push   $0x58
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	ff d0                	call   *%eax
  8008ab:	83 c4 10             	add    $0x10,%esp
			break;
  8008ae:	e9 ce 00 00 00       	jmp    800981 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8008b3:	83 ec 08             	sub    $0x8,%esp
  8008b6:	ff 75 0c             	pushl  0xc(%ebp)
  8008b9:	6a 30                	push   $0x30
  8008bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008be:	ff d0                	call   *%eax
  8008c0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008c3:	83 ec 08             	sub    $0x8,%esp
  8008c6:	ff 75 0c             	pushl  0xc(%ebp)
  8008c9:	6a 78                	push   $0x78
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	ff d0                	call   *%eax
  8008d0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d6:	83 c0 04             	add    $0x4,%eax
  8008d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8008dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8008df:	83 e8 04             	sub    $0x4,%eax
  8008e2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008ee:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008f5:	eb 1f                	jmp    800916 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 e8             	pushl  -0x18(%ebp)
  8008fd:	8d 45 14             	lea    0x14(%ebp),%eax
  800900:	50                   	push   %eax
  800901:	e8 e7 fb ff ff       	call   8004ed <getuint>
  800906:	83 c4 10             	add    $0x10,%esp
  800909:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80090f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800916:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80091a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80091d:	83 ec 04             	sub    $0x4,%esp
  800920:	52                   	push   %edx
  800921:	ff 75 e4             	pushl  -0x1c(%ebp)
  800924:	50                   	push   %eax
  800925:	ff 75 f4             	pushl  -0xc(%ebp)
  800928:	ff 75 f0             	pushl  -0x10(%ebp)
  80092b:	ff 75 0c             	pushl  0xc(%ebp)
  80092e:	ff 75 08             	pushl  0x8(%ebp)
  800931:	e8 00 fb ff ff       	call   800436 <printnum>
  800936:	83 c4 20             	add    $0x20,%esp
			break;
  800939:	eb 46                	jmp    800981 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80093b:	83 ec 08             	sub    $0x8,%esp
  80093e:	ff 75 0c             	pushl  0xc(%ebp)
  800941:	53                   	push   %ebx
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	ff d0                	call   *%eax
  800947:	83 c4 10             	add    $0x10,%esp
			break;
  80094a:	eb 35                	jmp    800981 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  80094c:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800953:	eb 2c                	jmp    800981 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800955:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  80095c:	eb 23                	jmp    800981 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80095e:	83 ec 08             	sub    $0x8,%esp
  800961:	ff 75 0c             	pushl  0xc(%ebp)
  800964:	6a 25                	push   $0x25
  800966:	8b 45 08             	mov    0x8(%ebp),%eax
  800969:	ff d0                	call   *%eax
  80096b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80096e:	ff 4d 10             	decl   0x10(%ebp)
  800971:	eb 03                	jmp    800976 <vprintfmt+0x3c3>
  800973:	ff 4d 10             	decl   0x10(%ebp)
  800976:	8b 45 10             	mov    0x10(%ebp),%eax
  800979:	48                   	dec    %eax
  80097a:	8a 00                	mov    (%eax),%al
  80097c:	3c 25                	cmp    $0x25,%al
  80097e:	75 f3                	jne    800973 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800980:	90                   	nop
		}
	}
  800981:	e9 35 fc ff ff       	jmp    8005bb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800986:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800987:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80098a:	5b                   	pop    %ebx
  80098b:	5e                   	pop    %esi
  80098c:	5d                   	pop    %ebp
  80098d:	c3                   	ret    

0080098e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80098e:	55                   	push   %ebp
  80098f:	89 e5                	mov    %esp,%ebp
  800991:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800994:	8d 45 10             	lea    0x10(%ebp),%eax
  800997:	83 c0 04             	add    $0x4,%eax
  80099a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80099d:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a3:	50                   	push   %eax
  8009a4:	ff 75 0c             	pushl  0xc(%ebp)
  8009a7:	ff 75 08             	pushl  0x8(%ebp)
  8009aa:	e8 04 fc ff ff       	call   8005b3 <vprintfmt>
  8009af:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009b2:	90                   	nop
  8009b3:	c9                   	leave  
  8009b4:	c3                   	ret    

008009b5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009b5:	55                   	push   %ebp
  8009b6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bb:	8b 40 08             	mov    0x8(%eax),%eax
  8009be:	8d 50 01             	lea    0x1(%eax),%edx
  8009c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ca:	8b 10                	mov    (%eax),%edx
  8009cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cf:	8b 40 04             	mov    0x4(%eax),%eax
  8009d2:	39 c2                	cmp    %eax,%edx
  8009d4:	73 12                	jae    8009e8 <sprintputch+0x33>
		*b->buf++ = ch;
  8009d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d9:	8b 00                	mov    (%eax),%eax
  8009db:	8d 48 01             	lea    0x1(%eax),%ecx
  8009de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e1:	89 0a                	mov    %ecx,(%edx)
  8009e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8009e6:	88 10                	mov    %dl,(%eax)
}
  8009e8:	90                   	nop
  8009e9:	5d                   	pop    %ebp
  8009ea:	c3                   	ret    

008009eb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009eb:	55                   	push   %ebp
  8009ec:	89 e5                	mov    %esp,%ebp
  8009ee:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a0c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a10:	74 06                	je     800a18 <vsnprintf+0x2d>
  800a12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a16:	7f 07                	jg     800a1f <vsnprintf+0x34>
		return -E_INVAL;
  800a18:	b8 03 00 00 00       	mov    $0x3,%eax
  800a1d:	eb 20                	jmp    800a3f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a1f:	ff 75 14             	pushl  0x14(%ebp)
  800a22:	ff 75 10             	pushl  0x10(%ebp)
  800a25:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a28:	50                   	push   %eax
  800a29:	68 b5 09 80 00       	push   $0x8009b5
  800a2e:	e8 80 fb ff ff       	call   8005b3 <vprintfmt>
  800a33:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a36:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a39:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a3f:	c9                   	leave  
  800a40:	c3                   	ret    

00800a41 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
  800a44:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a47:	8d 45 10             	lea    0x10(%ebp),%eax
  800a4a:	83 c0 04             	add    $0x4,%eax
  800a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a50:	8b 45 10             	mov    0x10(%ebp),%eax
  800a53:	ff 75 f4             	pushl  -0xc(%ebp)
  800a56:	50                   	push   %eax
  800a57:	ff 75 0c             	pushl  0xc(%ebp)
  800a5a:	ff 75 08             	pushl  0x8(%ebp)
  800a5d:	e8 89 ff ff ff       	call   8009eb <vsnprintf>
  800a62:	83 c4 10             	add    $0x10,%esp
  800a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a6b:	c9                   	leave  
  800a6c:	c3                   	ret    

00800a6d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a6d:	55                   	push   %ebp
  800a6e:	89 e5                	mov    %esp,%ebp
  800a70:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a7a:	eb 06                	jmp    800a82 <strlen+0x15>
		n++;
  800a7c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a7f:	ff 45 08             	incl   0x8(%ebp)
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	8a 00                	mov    (%eax),%al
  800a87:	84 c0                	test   %al,%al
  800a89:	75 f1                	jne    800a7c <strlen+0xf>
		n++;
	return n;
  800a8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a8e:	c9                   	leave  
  800a8f:	c3                   	ret    

00800a90 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a90:	55                   	push   %ebp
  800a91:	89 e5                	mov    %esp,%ebp
  800a93:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a96:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a9d:	eb 09                	jmp    800aa8 <strnlen+0x18>
		n++;
  800a9f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aa2:	ff 45 08             	incl   0x8(%ebp)
  800aa5:	ff 4d 0c             	decl   0xc(%ebp)
  800aa8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aac:	74 09                	je     800ab7 <strnlen+0x27>
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	8a 00                	mov    (%eax),%al
  800ab3:	84 c0                	test   %al,%al
  800ab5:	75 e8                	jne    800a9f <strnlen+0xf>
		n++;
	return n;
  800ab7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aba:	c9                   	leave  
  800abb:	c3                   	ret    

00800abc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800abc:	55                   	push   %ebp
  800abd:	89 e5                	mov    %esp,%ebp
  800abf:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ac8:	90                   	nop
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	8d 50 01             	lea    0x1(%eax),%edx
  800acf:	89 55 08             	mov    %edx,0x8(%ebp)
  800ad2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ad8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800adb:	8a 12                	mov    (%edx),%dl
  800add:	88 10                	mov    %dl,(%eax)
  800adf:	8a 00                	mov    (%eax),%al
  800ae1:	84 c0                	test   %al,%al
  800ae3:	75 e4                	jne    800ac9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ae5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ae8:	c9                   	leave  
  800ae9:	c3                   	ret    

00800aea <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800aea:	55                   	push   %ebp
  800aeb:	89 e5                	mov    %esp,%ebp
  800aed:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800af6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800afd:	eb 1f                	jmp    800b1e <strncpy+0x34>
		*dst++ = *src;
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	8d 50 01             	lea    0x1(%eax),%edx
  800b05:	89 55 08             	mov    %edx,0x8(%ebp)
  800b08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0b:	8a 12                	mov    (%edx),%dl
  800b0d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b12:	8a 00                	mov    (%eax),%al
  800b14:	84 c0                	test   %al,%al
  800b16:	74 03                	je     800b1b <strncpy+0x31>
			src++;
  800b18:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b1b:	ff 45 fc             	incl   -0x4(%ebp)
  800b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b21:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b24:	72 d9                	jb     800aff <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b26:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b29:	c9                   	leave  
  800b2a:	c3                   	ret    

00800b2b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b2b:	55                   	push   %ebp
  800b2c:	89 e5                	mov    %esp,%ebp
  800b2e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b3b:	74 30                	je     800b6d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b3d:	eb 16                	jmp    800b55 <strlcpy+0x2a>
			*dst++ = *src++;
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8d 50 01             	lea    0x1(%eax),%edx
  800b45:	89 55 08             	mov    %edx,0x8(%ebp)
  800b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b4e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b51:	8a 12                	mov    (%edx),%dl
  800b53:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b55:	ff 4d 10             	decl   0x10(%ebp)
  800b58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b5c:	74 09                	je     800b67 <strlcpy+0x3c>
  800b5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b61:	8a 00                	mov    (%eax),%al
  800b63:	84 c0                	test   %al,%al
  800b65:	75 d8                	jne    800b3f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b6d:	8b 55 08             	mov    0x8(%ebp),%edx
  800b70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b73:	29 c2                	sub    %eax,%edx
  800b75:	89 d0                	mov    %edx,%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b7c:	eb 06                	jmp    800b84 <strcmp+0xb>
		p++, q++;
  800b7e:	ff 45 08             	incl   0x8(%ebp)
  800b81:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	8a 00                	mov    (%eax),%al
  800b89:	84 c0                	test   %al,%al
  800b8b:	74 0e                	je     800b9b <strcmp+0x22>
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	8a 10                	mov    (%eax),%dl
  800b92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b95:	8a 00                	mov    (%eax),%al
  800b97:	38 c2                	cmp    %al,%dl
  800b99:	74 e3                	je     800b7e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	8a 00                	mov    (%eax),%al
  800ba0:	0f b6 d0             	movzbl %al,%edx
  800ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	0f b6 c0             	movzbl %al,%eax
  800bab:	29 c2                	sub    %eax,%edx
  800bad:	89 d0                	mov    %edx,%eax
}
  800baf:	5d                   	pop    %ebp
  800bb0:	c3                   	ret    

00800bb1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bb1:	55                   	push   %ebp
  800bb2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bb4:	eb 09                	jmp    800bbf <strncmp+0xe>
		n--, p++, q++;
  800bb6:	ff 4d 10             	decl   0x10(%ebp)
  800bb9:	ff 45 08             	incl   0x8(%ebp)
  800bbc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bbf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bc3:	74 17                	je     800bdc <strncmp+0x2b>
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	8a 00                	mov    (%eax),%al
  800bca:	84 c0                	test   %al,%al
  800bcc:	74 0e                	je     800bdc <strncmp+0x2b>
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	8a 10                	mov    (%eax),%dl
  800bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd6:	8a 00                	mov    (%eax),%al
  800bd8:	38 c2                	cmp    %al,%dl
  800bda:	74 da                	je     800bb6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800be0:	75 07                	jne    800be9 <strncmp+0x38>
		return 0;
  800be2:	b8 00 00 00 00       	mov    $0x0,%eax
  800be7:	eb 14                	jmp    800bfd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	0f b6 d0             	movzbl %al,%edx
  800bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	0f b6 c0             	movzbl %al,%eax
  800bf9:	29 c2                	sub    %eax,%edx
  800bfb:	89 d0                	mov    %edx,%eax
}
  800bfd:	5d                   	pop    %ebp
  800bfe:	c3                   	ret    

00800bff <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bff:	55                   	push   %ebp
  800c00:	89 e5                	mov    %esp,%ebp
  800c02:	83 ec 04             	sub    $0x4,%esp
  800c05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c08:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c0b:	eb 12                	jmp    800c1f <strchr+0x20>
		if (*s == c)
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	8a 00                	mov    (%eax),%al
  800c12:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c15:	75 05                	jne    800c1c <strchr+0x1d>
			return (char *) s;
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	eb 11                	jmp    800c2d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c1c:	ff 45 08             	incl   0x8(%ebp)
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8a 00                	mov    (%eax),%al
  800c24:	84 c0                	test   %al,%al
  800c26:	75 e5                	jne    800c0d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c28:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c2d:	c9                   	leave  
  800c2e:	c3                   	ret    

00800c2f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 04             	sub    $0x4,%esp
  800c35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c38:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c3b:	eb 0d                	jmp    800c4a <strfind+0x1b>
		if (*s == c)
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	8a 00                	mov    (%eax),%al
  800c42:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c45:	74 0e                	je     800c55 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c47:	ff 45 08             	incl   0x8(%ebp)
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8a 00                	mov    (%eax),%al
  800c4f:	84 c0                	test   %al,%al
  800c51:	75 ea                	jne    800c3d <strfind+0xe>
  800c53:	eb 01                	jmp    800c56 <strfind+0x27>
		if (*s == c)
			break;
  800c55:	90                   	nop
	return (char *) s;
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c59:	c9                   	leave  
  800c5a:	c3                   	ret    

00800c5b <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
  800c5e:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800c67:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800c6b:	76 63                	jbe    800cd0 <memset+0x75>
		uint64 data_block = c;
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	99                   	cltd   
  800c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c74:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7d:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800c81:	c1 e0 08             	shl    $0x8,%eax
  800c84:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c87:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800c8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c90:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800c94:	c1 e0 10             	shl    $0x10,%eax
  800c97:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c9a:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800c9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ca0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca3:	89 c2                	mov    %eax,%edx
  800ca5:	b8 00 00 00 00       	mov    $0x0,%eax
  800caa:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cad:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800cb0:	eb 18                	jmp    800cca <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800cb2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800cb5:	8d 41 08             	lea    0x8(%ecx),%eax
  800cb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cc1:	89 01                	mov    %eax,(%ecx)
  800cc3:	89 51 04             	mov    %edx,0x4(%ecx)
  800cc6:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800cca:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800cce:	77 e2                	ja     800cb2 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800cd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd4:	74 23                	je     800cf9 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800cd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cdc:	eb 0e                	jmp    800cec <memset+0x91>
			*p8++ = (uint8)c;
  800cde:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ce1:	8d 50 01             	lea    0x1(%eax),%edx
  800ce4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ce7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cea:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800cec:	8b 45 10             	mov    0x10(%ebp),%eax
  800cef:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf2:	89 55 10             	mov    %edx,0x10(%ebp)
  800cf5:	85 c0                	test   %eax,%eax
  800cf7:	75 e5                	jne    800cde <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfc:	c9                   	leave  
  800cfd:	c3                   	ret    

00800cfe <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800cfe:	55                   	push   %ebp
  800cff:	89 e5                	mov    %esp,%ebp
  800d01:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d10:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d14:	76 24                	jbe    800d3a <memcpy+0x3c>
		while(n >= 8){
  800d16:	eb 1c                	jmp    800d34 <memcpy+0x36>
			*d64 = *s64;
  800d18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d1b:	8b 50 04             	mov    0x4(%eax),%edx
  800d1e:	8b 00                	mov    (%eax),%eax
  800d20:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d23:	89 01                	mov    %eax,(%ecx)
  800d25:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d28:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d2c:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d30:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d34:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d38:	77 de                	ja     800d18 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3e:	74 31                	je     800d71 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d40:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d43:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d49:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800d4c:	eb 16                	jmp    800d64 <memcpy+0x66>
			*d8++ = *s8++;
  800d4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d51:	8d 50 01             	lea    0x1(%eax),%edx
  800d54:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800d57:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d5a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d5d:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800d60:	8a 12                	mov    (%edx),%dl
  800d62:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800d64:	8b 45 10             	mov    0x10(%ebp),%eax
  800d67:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6d:	85 c0                	test   %eax,%eax
  800d6f:	75 dd                	jne    800d4e <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d74:	c9                   	leave  
  800d75:	c3                   	ret    

00800d76 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d76:	55                   	push   %ebp
  800d77:	89 e5                	mov    %esp,%ebp
  800d79:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d8e:	73 50                	jae    800de0 <memmove+0x6a>
  800d90:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d93:	8b 45 10             	mov    0x10(%ebp),%eax
  800d96:	01 d0                	add    %edx,%eax
  800d98:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d9b:	76 43                	jbe    800de0 <memmove+0x6a>
		s += n;
  800d9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800da0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800da3:	8b 45 10             	mov    0x10(%ebp),%eax
  800da6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800da9:	eb 10                	jmp    800dbb <memmove+0x45>
			*--d = *--s;
  800dab:	ff 4d f8             	decl   -0x8(%ebp)
  800dae:	ff 4d fc             	decl   -0x4(%ebp)
  800db1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db4:	8a 10                	mov    (%eax),%dl
  800db6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc1:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc4:	85 c0                	test   %eax,%eax
  800dc6:	75 e3                	jne    800dab <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dc8:	eb 23                	jmp    800ded <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dcd:	8d 50 01             	lea    0x1(%eax),%edx
  800dd0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ddc:	8a 12                	mov    (%edx),%dl
  800dde:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800de0:	8b 45 10             	mov    0x10(%ebp),%eax
  800de3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de6:	89 55 10             	mov    %edx,0x10(%ebp)
  800de9:	85 c0                	test   %eax,%eax
  800deb:	75 dd                	jne    800dca <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800df0:	c9                   	leave  
  800df1:	c3                   	ret    

00800df2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800df2:	55                   	push   %ebp
  800df3:	89 e5                	mov    %esp,%ebp
  800df5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e01:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e04:	eb 2a                	jmp    800e30 <memcmp+0x3e>
		if (*s1 != *s2)
  800e06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e09:	8a 10                	mov    (%eax),%dl
  800e0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0e:	8a 00                	mov    (%eax),%al
  800e10:	38 c2                	cmp    %al,%dl
  800e12:	74 16                	je     800e2a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e17:	8a 00                	mov    (%eax),%al
  800e19:	0f b6 d0             	movzbl %al,%edx
  800e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	0f b6 c0             	movzbl %al,%eax
  800e24:	29 c2                	sub    %eax,%edx
  800e26:	89 d0                	mov    %edx,%eax
  800e28:	eb 18                	jmp    800e42 <memcmp+0x50>
		s1++, s2++;
  800e2a:	ff 45 fc             	incl   -0x4(%ebp)
  800e2d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e30:	8b 45 10             	mov    0x10(%ebp),%eax
  800e33:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e36:	89 55 10             	mov    %edx,0x10(%ebp)
  800e39:	85 c0                	test   %eax,%eax
  800e3b:	75 c9                	jne    800e06 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e42:	c9                   	leave  
  800e43:	c3                   	ret    

00800e44 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e44:	55                   	push   %ebp
  800e45:	89 e5                	mov    %esp,%ebp
  800e47:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e4a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e50:	01 d0                	add    %edx,%eax
  800e52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e55:	eb 15                	jmp    800e6c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	0f b6 d0             	movzbl %al,%edx
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	0f b6 c0             	movzbl %al,%eax
  800e65:	39 c2                	cmp    %eax,%edx
  800e67:	74 0d                	je     800e76 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e69:	ff 45 08             	incl   0x8(%ebp)
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e72:	72 e3                	jb     800e57 <memfind+0x13>
  800e74:	eb 01                	jmp    800e77 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e76:	90                   	nop
	return (void *) s;
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7a:	c9                   	leave  
  800e7b:	c3                   	ret    

00800e7c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e7c:	55                   	push   %ebp
  800e7d:	89 e5                	mov    %esp,%ebp
  800e7f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e89:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e90:	eb 03                	jmp    800e95 <strtol+0x19>
		s++;
  800e92:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	8a 00                	mov    (%eax),%al
  800e9a:	3c 20                	cmp    $0x20,%al
  800e9c:	74 f4                	je     800e92 <strtol+0x16>
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	3c 09                	cmp    $0x9,%al
  800ea5:	74 eb                	je     800e92 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	3c 2b                	cmp    $0x2b,%al
  800eae:	75 05                	jne    800eb5 <strtol+0x39>
		s++;
  800eb0:	ff 45 08             	incl   0x8(%ebp)
  800eb3:	eb 13                	jmp    800ec8 <strtol+0x4c>
	else if (*s == '-')
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	3c 2d                	cmp    $0x2d,%al
  800ebc:	75 0a                	jne    800ec8 <strtol+0x4c>
		s++, neg = 1;
  800ebe:	ff 45 08             	incl   0x8(%ebp)
  800ec1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ec8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ecc:	74 06                	je     800ed4 <strtol+0x58>
  800ece:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ed2:	75 20                	jne    800ef4 <strtol+0x78>
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	8a 00                	mov    (%eax),%al
  800ed9:	3c 30                	cmp    $0x30,%al
  800edb:	75 17                	jne    800ef4 <strtol+0x78>
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	40                   	inc    %eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3c 78                	cmp    $0x78,%al
  800ee5:	75 0d                	jne    800ef4 <strtol+0x78>
		s += 2, base = 16;
  800ee7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800eeb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ef2:	eb 28                	jmp    800f1c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ef4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef8:	75 15                	jne    800f0f <strtol+0x93>
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	8a 00                	mov    (%eax),%al
  800eff:	3c 30                	cmp    $0x30,%al
  800f01:	75 0c                	jne    800f0f <strtol+0x93>
		s++, base = 8;
  800f03:	ff 45 08             	incl   0x8(%ebp)
  800f06:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f0d:	eb 0d                	jmp    800f1c <strtol+0xa0>
	else if (base == 0)
  800f0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f13:	75 07                	jne    800f1c <strtol+0xa0>
		base = 10;
  800f15:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	3c 2f                	cmp    $0x2f,%al
  800f23:	7e 19                	jle    800f3e <strtol+0xc2>
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 39                	cmp    $0x39,%al
  800f2c:	7f 10                	jg     800f3e <strtol+0xc2>
			dig = *s - '0';
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	0f be c0             	movsbl %al,%eax
  800f36:	83 e8 30             	sub    $0x30,%eax
  800f39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f3c:	eb 42                	jmp    800f80 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	3c 60                	cmp    $0x60,%al
  800f45:	7e 19                	jle    800f60 <strtol+0xe4>
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	3c 7a                	cmp    $0x7a,%al
  800f4e:	7f 10                	jg     800f60 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	0f be c0             	movsbl %al,%eax
  800f58:	83 e8 57             	sub    $0x57,%eax
  800f5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f5e:	eb 20                	jmp    800f80 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3c 40                	cmp    $0x40,%al
  800f67:	7e 39                	jle    800fa2 <strtol+0x126>
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 00                	mov    (%eax),%al
  800f6e:	3c 5a                	cmp    $0x5a,%al
  800f70:	7f 30                	jg     800fa2 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	0f be c0             	movsbl %al,%eax
  800f7a:	83 e8 37             	sub    $0x37,%eax
  800f7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f83:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f86:	7d 19                	jge    800fa1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f88:	ff 45 08             	incl   0x8(%ebp)
  800f8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f92:	89 c2                	mov    %eax,%edx
  800f94:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f97:	01 d0                	add    %edx,%eax
  800f99:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f9c:	e9 7b ff ff ff       	jmp    800f1c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fa1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fa2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa6:	74 08                	je     800fb0 <strtol+0x134>
		*endptr = (char *) s;
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	8b 55 08             	mov    0x8(%ebp),%edx
  800fae:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fb0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fb4:	74 07                	je     800fbd <strtol+0x141>
  800fb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb9:	f7 d8                	neg    %eax
  800fbb:	eb 03                	jmp    800fc0 <strtol+0x144>
  800fbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fc0:	c9                   	leave  
  800fc1:	c3                   	ret    

00800fc2 <ltostr>:

void
ltostr(long value, char *str)
{
  800fc2:	55                   	push   %ebp
  800fc3:	89 e5                	mov    %esp,%ebp
  800fc5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fcf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fd6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fda:	79 13                	jns    800fef <ltostr+0x2d>
	{
		neg = 1;
  800fdc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fe9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fec:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ff7:	99                   	cltd   
  800ff8:	f7 f9                	idiv   %ecx
  800ffa:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	8d 50 01             	lea    0x1(%eax),%edx
  801003:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801006:	89 c2                	mov    %eax,%edx
  801008:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100b:	01 d0                	add    %edx,%eax
  80100d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801010:	83 c2 30             	add    $0x30,%edx
  801013:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801015:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801018:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80101d:	f7 e9                	imul   %ecx
  80101f:	c1 fa 02             	sar    $0x2,%edx
  801022:	89 c8                	mov    %ecx,%eax
  801024:	c1 f8 1f             	sar    $0x1f,%eax
  801027:	29 c2                	sub    %eax,%edx
  801029:	89 d0                	mov    %edx,%eax
  80102b:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80102e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801032:	75 bb                	jne    800fef <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801034:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80103b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103e:	48                   	dec    %eax
  80103f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801042:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801046:	74 3d                	je     801085 <ltostr+0xc3>
		start = 1 ;
  801048:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80104f:	eb 34                	jmp    801085 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801051:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	01 d0                	add    %edx,%eax
  801059:	8a 00                	mov    (%eax),%al
  80105b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80105e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801061:	8b 45 0c             	mov    0xc(%ebp),%eax
  801064:	01 c2                	add    %eax,%edx
  801066:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801069:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106c:	01 c8                	add    %ecx,%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801072:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801075:	8b 45 0c             	mov    0xc(%ebp),%eax
  801078:	01 c2                	add    %eax,%edx
  80107a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80107d:	88 02                	mov    %al,(%edx)
		start++ ;
  80107f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801082:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801085:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801088:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80108b:	7c c4                	jl     801051 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80108d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801090:	8b 45 0c             	mov    0xc(%ebp),%eax
  801093:	01 d0                	add    %edx,%eax
  801095:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801098:	90                   	nop
  801099:	c9                   	leave  
  80109a:	c3                   	ret    

0080109b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80109b:	55                   	push   %ebp
  80109c:	89 e5                	mov    %esp,%ebp
  80109e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010a1:	ff 75 08             	pushl  0x8(%ebp)
  8010a4:	e8 c4 f9 ff ff       	call   800a6d <strlen>
  8010a9:	83 c4 04             	add    $0x4,%esp
  8010ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010af:	ff 75 0c             	pushl  0xc(%ebp)
  8010b2:	e8 b6 f9 ff ff       	call   800a6d <strlen>
  8010b7:	83 c4 04             	add    $0x4,%esp
  8010ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010cb:	eb 17                	jmp    8010e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d3:	01 c2                	add    %eax,%edx
  8010d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	01 c8                	add    %ecx,%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010e1:	ff 45 fc             	incl   -0x4(%ebp)
  8010e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010ea:	7c e1                	jl     8010cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010fa:	eb 1f                	jmp    80111b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ff:	8d 50 01             	lea    0x1(%eax),%edx
  801102:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801105:	89 c2                	mov    %eax,%edx
  801107:	8b 45 10             	mov    0x10(%ebp),%eax
  80110a:	01 c2                	add    %eax,%edx
  80110c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80110f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801112:	01 c8                	add    %ecx,%eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801118:	ff 45 f8             	incl   -0x8(%ebp)
  80111b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801121:	7c d9                	jl     8010fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801123:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801126:	8b 45 10             	mov    0x10(%ebp),%eax
  801129:	01 d0                	add    %edx,%eax
  80112b:	c6 00 00             	movb   $0x0,(%eax)
}
  80112e:	90                   	nop
  80112f:	c9                   	leave  
  801130:	c3                   	ret    

00801131 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801131:	55                   	push   %ebp
  801132:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801134:	8b 45 14             	mov    0x14(%ebp),%eax
  801137:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80113d:	8b 45 14             	mov    0x14(%ebp),%eax
  801140:	8b 00                	mov    (%eax),%eax
  801142:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801149:	8b 45 10             	mov    0x10(%ebp),%eax
  80114c:	01 d0                	add    %edx,%eax
  80114e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801154:	eb 0c                	jmp    801162 <strsplit+0x31>
			*string++ = 0;
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8d 50 01             	lea    0x1(%eax),%edx
  80115c:	89 55 08             	mov    %edx,0x8(%ebp)
  80115f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	84 c0                	test   %al,%al
  801169:	74 18                	je     801183 <strsplit+0x52>
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	0f be c0             	movsbl %al,%eax
  801173:	50                   	push   %eax
  801174:	ff 75 0c             	pushl  0xc(%ebp)
  801177:	e8 83 fa ff ff       	call   800bff <strchr>
  80117c:	83 c4 08             	add    $0x8,%esp
  80117f:	85 c0                	test   %eax,%eax
  801181:	75 d3                	jne    801156 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	84 c0                	test   %al,%al
  80118a:	74 5a                	je     8011e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80118c:	8b 45 14             	mov    0x14(%ebp),%eax
  80118f:	8b 00                	mov    (%eax),%eax
  801191:	83 f8 0f             	cmp    $0xf,%eax
  801194:	75 07                	jne    80119d <strsplit+0x6c>
		{
			return 0;
  801196:	b8 00 00 00 00       	mov    $0x0,%eax
  80119b:	eb 66                	jmp    801203 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80119d:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a0:	8b 00                	mov    (%eax),%eax
  8011a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8011a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8011a8:	89 0a                	mov    %ecx,(%edx)
  8011aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b4:	01 c2                	add    %eax,%edx
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011bb:	eb 03                	jmp    8011c0 <strsplit+0x8f>
			string++;
  8011bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	84 c0                	test   %al,%al
  8011c7:	74 8b                	je     801154 <strsplit+0x23>
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	0f be c0             	movsbl %al,%eax
  8011d1:	50                   	push   %eax
  8011d2:	ff 75 0c             	pushl  0xc(%ebp)
  8011d5:	e8 25 fa ff ff       	call   800bff <strchr>
  8011da:	83 c4 08             	add    $0x8,%esp
  8011dd:	85 c0                	test   %eax,%eax
  8011df:	74 dc                	je     8011bd <strsplit+0x8c>
			string++;
	}
  8011e1:	e9 6e ff ff ff       	jmp    801154 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ea:	8b 00                	mov    (%eax),%eax
  8011ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f6:	01 d0                	add    %edx,%eax
  8011f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801203:	c9                   	leave  
  801204:	c3                   	ret    

00801205 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
  801208:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801211:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801218:	eb 4a                	jmp    801264 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80121a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	01 c2                	add    %eax,%edx
  801222:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	01 c8                	add    %ecx,%eax
  80122a:	8a 00                	mov    (%eax),%al
  80122c:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80122e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	01 d0                	add    %edx,%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	3c 40                	cmp    $0x40,%al
  80123a:	7e 25                	jle    801261 <str2lower+0x5c>
  80123c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801242:	01 d0                	add    %edx,%eax
  801244:	8a 00                	mov    (%eax),%al
  801246:	3c 5a                	cmp    $0x5a,%al
  801248:	7f 17                	jg     801261 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80124a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	01 d0                	add    %edx,%eax
  801252:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801255:	8b 55 08             	mov    0x8(%ebp),%edx
  801258:	01 ca                	add    %ecx,%edx
  80125a:	8a 12                	mov    (%edx),%dl
  80125c:	83 c2 20             	add    $0x20,%edx
  80125f:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801261:	ff 45 fc             	incl   -0x4(%ebp)
  801264:	ff 75 0c             	pushl  0xc(%ebp)
  801267:	e8 01 f8 ff ff       	call   800a6d <strlen>
  80126c:	83 c4 04             	add    $0x4,%esp
  80126f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801272:	7f a6                	jg     80121a <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801274:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	57                   	push   %edi
  80127d:	56                   	push   %esi
  80127e:	53                   	push   %ebx
  80127f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	8b 55 0c             	mov    0xc(%ebp),%edx
  801288:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80128b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80128e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801291:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801294:	cd 30                	int    $0x30
  801296:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801299:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80129c:	83 c4 10             	add    $0x10,%esp
  80129f:	5b                   	pop    %ebx
  8012a0:	5e                   	pop    %esi
  8012a1:	5f                   	pop    %edi
  8012a2:	5d                   	pop    %ebp
  8012a3:	c3                   	ret    

008012a4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012a4:	55                   	push   %ebp
  8012a5:	89 e5                	mov    %esp,%ebp
  8012a7:	83 ec 04             	sub    $0x4,%esp
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8012b0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012b3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	6a 00                	push   $0x0
  8012bc:	51                   	push   %ecx
  8012bd:	52                   	push   %edx
  8012be:	ff 75 0c             	pushl  0xc(%ebp)
  8012c1:	50                   	push   %eax
  8012c2:	6a 00                	push   $0x0
  8012c4:	e8 b0 ff ff ff       	call   801279 <syscall>
  8012c9:	83 c4 18             	add    $0x18,%esp
}
  8012cc:	90                   	nop
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <sys_cgetc>:

int
sys_cgetc(void)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 02                	push   $0x2
  8012de:	e8 96 ff ff ff       	call   801279 <syscall>
  8012e3:	83 c4 18             	add    $0x18,%esp
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 03                	push   $0x3
  8012f7:	e8 7d ff ff ff       	call   801279 <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	90                   	nop
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 04                	push   $0x4
  801311:	e8 63 ff ff ff       	call   801279 <syscall>
  801316:	83 c4 18             	add    $0x18,%esp
}
  801319:	90                   	nop
  80131a:	c9                   	leave  
  80131b:	c3                   	ret    

0080131c <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80131c:	55                   	push   %ebp
  80131d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80131f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	52                   	push   %edx
  80132c:	50                   	push   %eax
  80132d:	6a 08                	push   $0x8
  80132f:	e8 45 ff ff ff       	call   801279 <syscall>
  801334:	83 c4 18             	add    $0x18,%esp
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
  80133c:	56                   	push   %esi
  80133d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80133e:	8b 75 18             	mov    0x18(%ebp),%esi
  801341:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801344:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801347:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	56                   	push   %esi
  80134e:	53                   	push   %ebx
  80134f:	51                   	push   %ecx
  801350:	52                   	push   %edx
  801351:	50                   	push   %eax
  801352:	6a 09                	push   $0x9
  801354:	e8 20 ff ff ff       	call   801279 <syscall>
  801359:	83 c4 18             	add    $0x18,%esp
}
  80135c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80135f:	5b                   	pop    %ebx
  801360:	5e                   	pop    %esi
  801361:	5d                   	pop    %ebp
  801362:	c3                   	ret    

00801363 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	ff 75 08             	pushl  0x8(%ebp)
  801371:	6a 0a                	push   $0xa
  801373:	e8 01 ff ff ff       	call   801279 <syscall>
  801378:	83 c4 18             	add    $0x18,%esp
}
  80137b:	c9                   	leave  
  80137c:	c3                   	ret    

0080137d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	ff 75 0c             	pushl  0xc(%ebp)
  801389:	ff 75 08             	pushl  0x8(%ebp)
  80138c:	6a 0b                	push   $0xb
  80138e:	e8 e6 fe ff ff       	call   801279 <syscall>
  801393:	83 c4 18             	add    $0x18,%esp
}
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 0c                	push   $0xc
  8013a7:	e8 cd fe ff ff       	call   801279 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 0d                	push   $0xd
  8013c0:	e8 b4 fe ff ff       	call   801279 <syscall>
  8013c5:	83 c4 18             	add    $0x18,%esp
}
  8013c8:	c9                   	leave  
  8013c9:	c3                   	ret    

008013ca <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 0e                	push   $0xe
  8013d9:	e8 9b fe ff ff       	call   801279 <syscall>
  8013de:	83 c4 18             	add    $0x18,%esp
}
  8013e1:	c9                   	leave  
  8013e2:	c3                   	ret    

008013e3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 0f                	push   $0xf
  8013f2:	e8 82 fe ff ff       	call   801279 <syscall>
  8013f7:	83 c4 18             	add    $0x18,%esp
}
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	ff 75 08             	pushl  0x8(%ebp)
  80140a:	6a 10                	push   $0x10
  80140c:	e8 68 fe ff ff       	call   801279 <syscall>
  801411:	83 c4 18             	add    $0x18,%esp
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 11                	push   $0x11
  801425:	e8 4f fe ff ff       	call   801279 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	90                   	nop
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_cputc>:

void
sys_cputc(const char c)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 04             	sub    $0x4,%esp
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80143c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	50                   	push   %eax
  801449:	6a 01                	push   $0x1
  80144b:	e8 29 fe ff ff       	call   801279 <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
}
  801453:	90                   	nop
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 14                	push   $0x14
  801465:	e8 0f fe ff ff       	call   801279 <syscall>
  80146a:	83 c4 18             	add    $0x18,%esp
}
  80146d:	90                   	nop
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	83 ec 04             	sub    $0x4,%esp
  801476:	8b 45 10             	mov    0x10(%ebp),%eax
  801479:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80147c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80147f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	6a 00                	push   $0x0
  801488:	51                   	push   %ecx
  801489:	52                   	push   %edx
  80148a:	ff 75 0c             	pushl  0xc(%ebp)
  80148d:	50                   	push   %eax
  80148e:	6a 15                	push   $0x15
  801490:	e8 e4 fd ff ff       	call   801279 <syscall>
  801495:	83 c4 18             	add    $0x18,%esp
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80149d:	8b 55 10             	mov    0x10(%ebp),%edx
  8014a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	52                   	push   %edx
  8014a8:	50                   	push   %eax
  8014a9:	ff 75 08             	pushl  0x8(%ebp)
  8014ac:	6a 16                	push   $0x16
  8014ae:	e8 c6 fd ff ff       	call   801279 <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
}
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	52                   	push   %edx
  8014c8:	50                   	push   %eax
  8014c9:	6a 17                	push   $0x17
  8014cb:	e8 a9 fd ff ff       	call   801279 <syscall>
  8014d0:	83 c4 18             	add    $0x18,%esp
}
  8014d3:	c9                   	leave  
  8014d4:	c3                   	ret    

008014d5 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	52                   	push   %edx
  8014e5:	50                   	push   %eax
  8014e6:	6a 18                	push   $0x18
  8014e8:	e8 8c fd ff ff       	call   801279 <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	6a 00                	push   $0x0
  8014fa:	ff 75 14             	pushl  0x14(%ebp)
  8014fd:	ff 75 10             	pushl  0x10(%ebp)
  801500:	ff 75 0c             	pushl  0xc(%ebp)
  801503:	50                   	push   %eax
  801504:	6a 19                	push   $0x19
  801506:	e8 6e fd ff ff       	call   801279 <syscall>
  80150b:	83 c4 18             	add    $0x18,%esp
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	50                   	push   %eax
  80151f:	6a 1a                	push   $0x1a
  801521:	e8 53 fd ff ff       	call   801279 <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	90                   	nop
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	50                   	push   %eax
  80153b:	6a 1b                	push   $0x1b
  80153d:	e8 37 fd ff ff       	call   801279 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 05                	push   $0x5
  801556:	e8 1e fd ff ff       	call   801279 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 06                	push   $0x6
  80156f:	e8 05 fd ff ff       	call   801279 <syscall>
  801574:	83 c4 18             	add    $0x18,%esp
}
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 07                	push   $0x7
  801588:	e8 ec fc ff ff       	call   801279 <syscall>
  80158d:	83 c4 18             	add    $0x18,%esp
}
  801590:	c9                   	leave  
  801591:	c3                   	ret    

00801592 <sys_exit_env>:


void sys_exit_env(void)
{
  801592:	55                   	push   %ebp
  801593:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 1c                	push   $0x1c
  8015a1:	e8 d3 fc ff ff       	call   801279 <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
}
  8015a9:	90                   	nop
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	ff 75 10             	pushl  0x10(%ebp)
  8015b6:	ff 75 0c             	pushl  0xc(%ebp)
  8015b9:	ff 75 08             	pushl  0x8(%ebp)
  8015bc:	6a 13                	push   $0x13
  8015be:	e8 b6 fc ff ff       	call   801279 <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c6:	90                   	nop
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 1e                	push   $0x1e
  8015d8:	e8 9c fc ff ff       	call   801279 <syscall>
  8015dd:	83 c4 18             	add    $0x18,%esp
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
  8015e5:	83 ec 04             	sub    $0x4,%esp
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015ee:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	50                   	push   %eax
  8015fb:	6a 1f                	push   $0x1f
  8015fd:	e8 77 fc ff ff       	call   801279 <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
	return ;
  801605:	90                   	nop
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <rsttst>:
void rsttst()
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 21                	push   $0x21
  801617:	e8 5d fc ff ff       	call   801279 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
	return ;
  80161f:	90                   	nop
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
  801625:	83 ec 04             	sub    $0x4,%esp
  801628:	8b 45 14             	mov    0x14(%ebp),%eax
  80162b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80162e:	8b 55 18             	mov    0x18(%ebp),%edx
  801631:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801635:	52                   	push   %edx
  801636:	50                   	push   %eax
  801637:	ff 75 10             	pushl  0x10(%ebp)
  80163a:	ff 75 0c             	pushl  0xc(%ebp)
  80163d:	ff 75 08             	pushl  0x8(%ebp)
  801640:	6a 20                	push   $0x20
  801642:	e8 32 fc ff ff       	call   801279 <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
	return ;
  80164a:	90                   	nop
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <chktst>:
void chktst(uint32 n)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	ff 75 08             	pushl  0x8(%ebp)
  80165b:	6a 22                	push   $0x22
  80165d:	e8 17 fc ff ff       	call   801279 <syscall>
  801662:	83 c4 18             	add    $0x18,%esp
	return ;
  801665:	90                   	nop
}
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <inctst>:

void inctst()
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 23                	push   $0x23
  801677:	e8 fd fb ff ff       	call   801279 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
	return ;
  80167f:	90                   	nop
}
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <gettst>:
uint32 gettst()
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 24                	push   $0x24
  801691:	e8 e3 fb ff ff       	call   801279 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 25                	push   $0x25
  8016aa:	e8 ca fb ff ff       	call   801279 <syscall>
  8016af:	83 c4 18             	add    $0x18,%esp
  8016b2:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8016b7:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	ff 75 08             	pushl  0x8(%ebp)
  8016d4:	6a 26                	push   $0x26
  8016d6:	e8 9e fb ff ff       	call   801279 <syscall>
  8016db:	83 c4 18             	add    $0x18,%esp
	return ;
  8016de:	90                   	nop
}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
  8016e4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016e5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	6a 00                	push   $0x0
  8016f3:	53                   	push   %ebx
  8016f4:	51                   	push   %ecx
  8016f5:	52                   	push   %edx
  8016f6:	50                   	push   %eax
  8016f7:	6a 27                	push   $0x27
  8016f9:	e8 7b fb ff ff       	call   801279 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801709:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	52                   	push   %edx
  801716:	50                   	push   %eax
  801717:	6a 28                	push   $0x28
  801719:	e8 5b fb ff ff       	call   801279 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801726:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801729:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	6a 00                	push   $0x0
  801731:	51                   	push   %ecx
  801732:	ff 75 10             	pushl  0x10(%ebp)
  801735:	52                   	push   %edx
  801736:	50                   	push   %eax
  801737:	6a 29                	push   $0x29
  801739:	e8 3b fb ff ff       	call   801279 <syscall>
  80173e:	83 c4 18             	add    $0x18,%esp
}
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	ff 75 10             	pushl  0x10(%ebp)
  80174d:	ff 75 0c             	pushl  0xc(%ebp)
  801750:	ff 75 08             	pushl  0x8(%ebp)
  801753:	6a 12                	push   $0x12
  801755:	e8 1f fb ff ff       	call   801279 <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
	return ;
  80175d:	90                   	nop
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801763:	8b 55 0c             	mov    0xc(%ebp),%edx
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 2a                	push   $0x2a
  801773:	e8 01 fb ff ff       	call   801279 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
	return;
  80177b:	90                   	nop
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 2b                	push   $0x2b
  80178d:	e8 e7 fa ff ff       	call   801279 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
  80179a:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80179d:	83 ec 04             	sub    $0x4,%esp
  8017a0:	68 28 22 80 00       	push   $0x802228
  8017a5:	68 0a 01 00 00       	push   $0x10a
  8017aa:	68 38 22 80 00       	push   $0x802238
  8017af:	e8 38 00 00 00       	call   8017ec <_panic>

008017b4 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	ff 75 0c             	pushl  0xc(%ebp)
  8017c0:	ff 75 08             	pushl  0x8(%ebp)
  8017c3:	6a 33                	push   $0x33
  8017c5:	e8 af fa ff ff       	call   801279 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
	return;
  8017cd:	90                   	nop
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	ff 75 0c             	pushl  0xc(%ebp)
  8017dc:	ff 75 08             	pushl  0x8(%ebp)
  8017df:	6a 34                	push   $0x34
  8017e1:	e8 93 fa ff ff       	call   801279 <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e9:	90                   	nop
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
  8017ef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8017f2:	8d 45 10             	lea    0x10(%ebp),%eax
  8017f5:	83 c0 04             	add    $0x4,%eax
  8017f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8017fb:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801800:	85 c0                	test   %eax,%eax
  801802:	74 16                	je     80181a <_panic+0x2e>
		cprintf("%s: ", argv0);
  801804:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801809:	83 ec 08             	sub    $0x8,%esp
  80180c:	50                   	push   %eax
  80180d:	68 48 22 80 00       	push   $0x802248
  801812:	e8 7d eb ff ff       	call   800394 <cprintf>
  801817:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80181a:	a1 04 30 80 00       	mov    0x803004,%eax
  80181f:	83 ec 0c             	sub    $0xc,%esp
  801822:	ff 75 0c             	pushl  0xc(%ebp)
  801825:	ff 75 08             	pushl  0x8(%ebp)
  801828:	50                   	push   %eax
  801829:	68 50 22 80 00       	push   $0x802250
  80182e:	6a 74                	push   $0x74
  801830:	e8 8c eb ff ff       	call   8003c1 <cprintf_colored>
  801835:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801838:	8b 45 10             	mov    0x10(%ebp),%eax
  80183b:	83 ec 08             	sub    $0x8,%esp
  80183e:	ff 75 f4             	pushl  -0xc(%ebp)
  801841:	50                   	push   %eax
  801842:	e8 de ea ff ff       	call   800325 <vcprintf>
  801847:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80184a:	83 ec 08             	sub    $0x8,%esp
  80184d:	6a 00                	push   $0x0
  80184f:	68 78 22 80 00       	push   $0x802278
  801854:	e8 cc ea ff ff       	call   800325 <vcprintf>
  801859:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80185c:	e8 45 ea ff ff       	call   8002a6 <exit>

	// should not return here
	while (1) ;
  801861:	eb fe                	jmp    801861 <_panic+0x75>

00801863 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
  801866:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801869:	a1 20 30 80 00       	mov    0x803020,%eax
  80186e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801874:	8b 45 0c             	mov    0xc(%ebp),%eax
  801877:	39 c2                	cmp    %eax,%edx
  801879:	74 14                	je     80188f <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80187b:	83 ec 04             	sub    $0x4,%esp
  80187e:	68 7c 22 80 00       	push   $0x80227c
  801883:	6a 26                	push   $0x26
  801885:	68 c8 22 80 00       	push   $0x8022c8
  80188a:	e8 5d ff ff ff       	call   8017ec <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80188f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801896:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80189d:	e9 c5 00 00 00       	jmp    801967 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8018a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	01 d0                	add    %edx,%eax
  8018b1:	8b 00                	mov    (%eax),%eax
  8018b3:	85 c0                	test   %eax,%eax
  8018b5:	75 08                	jne    8018bf <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8018b7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018ba:	e9 a5 00 00 00       	jmp    801964 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8018bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018c6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018cd:	eb 69                	jmp    801938 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8018d4:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018da:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018dd:	89 d0                	mov    %edx,%eax
  8018df:	01 c0                	add    %eax,%eax
  8018e1:	01 d0                	add    %edx,%eax
  8018e3:	c1 e0 03             	shl    $0x3,%eax
  8018e6:	01 c8                	add    %ecx,%eax
  8018e8:	8a 40 04             	mov    0x4(%eax),%al
  8018eb:	84 c0                	test   %al,%al
  8018ed:	75 46                	jne    801935 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8018f4:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018fd:	89 d0                	mov    %edx,%eax
  8018ff:	01 c0                	add    %eax,%eax
  801901:	01 d0                	add    %edx,%eax
  801903:	c1 e0 03             	shl    $0x3,%eax
  801906:	01 c8                	add    %ecx,%eax
  801908:	8b 00                	mov    (%eax),%eax
  80190a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80190d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801910:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801915:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801917:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	01 c8                	add    %ecx,%eax
  801926:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801928:	39 c2                	cmp    %eax,%edx
  80192a:	75 09                	jne    801935 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80192c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801933:	eb 15                	jmp    80194a <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801935:	ff 45 e8             	incl   -0x18(%ebp)
  801938:	a1 20 30 80 00       	mov    0x803020,%eax
  80193d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801943:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801946:	39 c2                	cmp    %eax,%edx
  801948:	77 85                	ja     8018cf <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80194a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80194e:	75 14                	jne    801964 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801950:	83 ec 04             	sub    $0x4,%esp
  801953:	68 d4 22 80 00       	push   $0x8022d4
  801958:	6a 3a                	push   $0x3a
  80195a:	68 c8 22 80 00       	push   $0x8022c8
  80195f:	e8 88 fe ff ff       	call   8017ec <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801964:	ff 45 f0             	incl   -0x10(%ebp)
  801967:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80196a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80196d:	0f 8c 2f ff ff ff    	jl     8018a2 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801973:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80197a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801981:	eb 26                	jmp    8019a9 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801983:	a1 20 30 80 00       	mov    0x803020,%eax
  801988:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80198e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801991:	89 d0                	mov    %edx,%eax
  801993:	01 c0                	add    %eax,%eax
  801995:	01 d0                	add    %edx,%eax
  801997:	c1 e0 03             	shl    $0x3,%eax
  80199a:	01 c8                	add    %ecx,%eax
  80199c:	8a 40 04             	mov    0x4(%eax),%al
  80199f:	3c 01                	cmp    $0x1,%al
  8019a1:	75 03                	jne    8019a6 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019a3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019a6:	ff 45 e0             	incl   -0x20(%ebp)
  8019a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8019ae:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019b7:	39 c2                	cmp    %eax,%edx
  8019b9:	77 c8                	ja     801983 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019be:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019c1:	74 14                	je     8019d7 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8019c3:	83 ec 04             	sub    $0x4,%esp
  8019c6:	68 28 23 80 00       	push   $0x802328
  8019cb:	6a 44                	push   $0x44
  8019cd:	68 c8 22 80 00       	push   $0x8022c8
  8019d2:	e8 15 fe ff ff       	call   8017ec <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019d7:	90                   	nop
  8019d8:	c9                   	leave  
  8019d9:	c3                   	ret    
  8019da:	66 90                	xchg   %ax,%ax

008019dc <__udivdi3>:
  8019dc:	55                   	push   %ebp
  8019dd:	57                   	push   %edi
  8019de:	56                   	push   %esi
  8019df:	53                   	push   %ebx
  8019e0:	83 ec 1c             	sub    $0x1c,%esp
  8019e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019f3:	89 ca                	mov    %ecx,%edx
  8019f5:	89 f8                	mov    %edi,%eax
  8019f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019fb:	85 f6                	test   %esi,%esi
  8019fd:	75 2d                	jne    801a2c <__udivdi3+0x50>
  8019ff:	39 cf                	cmp    %ecx,%edi
  801a01:	77 65                	ja     801a68 <__udivdi3+0x8c>
  801a03:	89 fd                	mov    %edi,%ebp
  801a05:	85 ff                	test   %edi,%edi
  801a07:	75 0b                	jne    801a14 <__udivdi3+0x38>
  801a09:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0e:	31 d2                	xor    %edx,%edx
  801a10:	f7 f7                	div    %edi
  801a12:	89 c5                	mov    %eax,%ebp
  801a14:	31 d2                	xor    %edx,%edx
  801a16:	89 c8                	mov    %ecx,%eax
  801a18:	f7 f5                	div    %ebp
  801a1a:	89 c1                	mov    %eax,%ecx
  801a1c:	89 d8                	mov    %ebx,%eax
  801a1e:	f7 f5                	div    %ebp
  801a20:	89 cf                	mov    %ecx,%edi
  801a22:	89 fa                	mov    %edi,%edx
  801a24:	83 c4 1c             	add    $0x1c,%esp
  801a27:	5b                   	pop    %ebx
  801a28:	5e                   	pop    %esi
  801a29:	5f                   	pop    %edi
  801a2a:	5d                   	pop    %ebp
  801a2b:	c3                   	ret    
  801a2c:	39 ce                	cmp    %ecx,%esi
  801a2e:	77 28                	ja     801a58 <__udivdi3+0x7c>
  801a30:	0f bd fe             	bsr    %esi,%edi
  801a33:	83 f7 1f             	xor    $0x1f,%edi
  801a36:	75 40                	jne    801a78 <__udivdi3+0x9c>
  801a38:	39 ce                	cmp    %ecx,%esi
  801a3a:	72 0a                	jb     801a46 <__udivdi3+0x6a>
  801a3c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a40:	0f 87 9e 00 00 00    	ja     801ae4 <__udivdi3+0x108>
  801a46:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4b:	89 fa                	mov    %edi,%edx
  801a4d:	83 c4 1c             	add    $0x1c,%esp
  801a50:	5b                   	pop    %ebx
  801a51:	5e                   	pop    %esi
  801a52:	5f                   	pop    %edi
  801a53:	5d                   	pop    %ebp
  801a54:	c3                   	ret    
  801a55:	8d 76 00             	lea    0x0(%esi),%esi
  801a58:	31 ff                	xor    %edi,%edi
  801a5a:	31 c0                	xor    %eax,%eax
  801a5c:	89 fa                	mov    %edi,%edx
  801a5e:	83 c4 1c             	add    $0x1c,%esp
  801a61:	5b                   	pop    %ebx
  801a62:	5e                   	pop    %esi
  801a63:	5f                   	pop    %edi
  801a64:	5d                   	pop    %ebp
  801a65:	c3                   	ret    
  801a66:	66 90                	xchg   %ax,%ax
  801a68:	89 d8                	mov    %ebx,%eax
  801a6a:	f7 f7                	div    %edi
  801a6c:	31 ff                	xor    %edi,%edi
  801a6e:	89 fa                	mov    %edi,%edx
  801a70:	83 c4 1c             	add    $0x1c,%esp
  801a73:	5b                   	pop    %ebx
  801a74:	5e                   	pop    %esi
  801a75:	5f                   	pop    %edi
  801a76:	5d                   	pop    %ebp
  801a77:	c3                   	ret    
  801a78:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a7d:	89 eb                	mov    %ebp,%ebx
  801a7f:	29 fb                	sub    %edi,%ebx
  801a81:	89 f9                	mov    %edi,%ecx
  801a83:	d3 e6                	shl    %cl,%esi
  801a85:	89 c5                	mov    %eax,%ebp
  801a87:	88 d9                	mov    %bl,%cl
  801a89:	d3 ed                	shr    %cl,%ebp
  801a8b:	89 e9                	mov    %ebp,%ecx
  801a8d:	09 f1                	or     %esi,%ecx
  801a8f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a93:	89 f9                	mov    %edi,%ecx
  801a95:	d3 e0                	shl    %cl,%eax
  801a97:	89 c5                	mov    %eax,%ebp
  801a99:	89 d6                	mov    %edx,%esi
  801a9b:	88 d9                	mov    %bl,%cl
  801a9d:	d3 ee                	shr    %cl,%esi
  801a9f:	89 f9                	mov    %edi,%ecx
  801aa1:	d3 e2                	shl    %cl,%edx
  801aa3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa7:	88 d9                	mov    %bl,%cl
  801aa9:	d3 e8                	shr    %cl,%eax
  801aab:	09 c2                	or     %eax,%edx
  801aad:	89 d0                	mov    %edx,%eax
  801aaf:	89 f2                	mov    %esi,%edx
  801ab1:	f7 74 24 0c          	divl   0xc(%esp)
  801ab5:	89 d6                	mov    %edx,%esi
  801ab7:	89 c3                	mov    %eax,%ebx
  801ab9:	f7 e5                	mul    %ebp
  801abb:	39 d6                	cmp    %edx,%esi
  801abd:	72 19                	jb     801ad8 <__udivdi3+0xfc>
  801abf:	74 0b                	je     801acc <__udivdi3+0xf0>
  801ac1:	89 d8                	mov    %ebx,%eax
  801ac3:	31 ff                	xor    %edi,%edi
  801ac5:	e9 58 ff ff ff       	jmp    801a22 <__udivdi3+0x46>
  801aca:	66 90                	xchg   %ax,%ax
  801acc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ad0:	89 f9                	mov    %edi,%ecx
  801ad2:	d3 e2                	shl    %cl,%edx
  801ad4:	39 c2                	cmp    %eax,%edx
  801ad6:	73 e9                	jae    801ac1 <__udivdi3+0xe5>
  801ad8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801adb:	31 ff                	xor    %edi,%edi
  801add:	e9 40 ff ff ff       	jmp    801a22 <__udivdi3+0x46>
  801ae2:	66 90                	xchg   %ax,%ax
  801ae4:	31 c0                	xor    %eax,%eax
  801ae6:	e9 37 ff ff ff       	jmp    801a22 <__udivdi3+0x46>
  801aeb:	90                   	nop

00801aec <__umoddi3>:
  801aec:	55                   	push   %ebp
  801aed:	57                   	push   %edi
  801aee:	56                   	push   %esi
  801aef:	53                   	push   %ebx
  801af0:	83 ec 1c             	sub    $0x1c,%esp
  801af3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801af7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801afb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b03:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b07:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b0b:	89 f3                	mov    %esi,%ebx
  801b0d:	89 fa                	mov    %edi,%edx
  801b0f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b13:	89 34 24             	mov    %esi,(%esp)
  801b16:	85 c0                	test   %eax,%eax
  801b18:	75 1a                	jne    801b34 <__umoddi3+0x48>
  801b1a:	39 f7                	cmp    %esi,%edi
  801b1c:	0f 86 a2 00 00 00    	jbe    801bc4 <__umoddi3+0xd8>
  801b22:	89 c8                	mov    %ecx,%eax
  801b24:	89 f2                	mov    %esi,%edx
  801b26:	f7 f7                	div    %edi
  801b28:	89 d0                	mov    %edx,%eax
  801b2a:	31 d2                	xor    %edx,%edx
  801b2c:	83 c4 1c             	add    $0x1c,%esp
  801b2f:	5b                   	pop    %ebx
  801b30:	5e                   	pop    %esi
  801b31:	5f                   	pop    %edi
  801b32:	5d                   	pop    %ebp
  801b33:	c3                   	ret    
  801b34:	39 f0                	cmp    %esi,%eax
  801b36:	0f 87 ac 00 00 00    	ja     801be8 <__umoddi3+0xfc>
  801b3c:	0f bd e8             	bsr    %eax,%ebp
  801b3f:	83 f5 1f             	xor    $0x1f,%ebp
  801b42:	0f 84 ac 00 00 00    	je     801bf4 <__umoddi3+0x108>
  801b48:	bf 20 00 00 00       	mov    $0x20,%edi
  801b4d:	29 ef                	sub    %ebp,%edi
  801b4f:	89 fe                	mov    %edi,%esi
  801b51:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b55:	89 e9                	mov    %ebp,%ecx
  801b57:	d3 e0                	shl    %cl,%eax
  801b59:	89 d7                	mov    %edx,%edi
  801b5b:	89 f1                	mov    %esi,%ecx
  801b5d:	d3 ef                	shr    %cl,%edi
  801b5f:	09 c7                	or     %eax,%edi
  801b61:	89 e9                	mov    %ebp,%ecx
  801b63:	d3 e2                	shl    %cl,%edx
  801b65:	89 14 24             	mov    %edx,(%esp)
  801b68:	89 d8                	mov    %ebx,%eax
  801b6a:	d3 e0                	shl    %cl,%eax
  801b6c:	89 c2                	mov    %eax,%edx
  801b6e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b72:	d3 e0                	shl    %cl,%eax
  801b74:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b78:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b7c:	89 f1                	mov    %esi,%ecx
  801b7e:	d3 e8                	shr    %cl,%eax
  801b80:	09 d0                	or     %edx,%eax
  801b82:	d3 eb                	shr    %cl,%ebx
  801b84:	89 da                	mov    %ebx,%edx
  801b86:	f7 f7                	div    %edi
  801b88:	89 d3                	mov    %edx,%ebx
  801b8a:	f7 24 24             	mull   (%esp)
  801b8d:	89 c6                	mov    %eax,%esi
  801b8f:	89 d1                	mov    %edx,%ecx
  801b91:	39 d3                	cmp    %edx,%ebx
  801b93:	0f 82 87 00 00 00    	jb     801c20 <__umoddi3+0x134>
  801b99:	0f 84 91 00 00 00    	je     801c30 <__umoddi3+0x144>
  801b9f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ba3:	29 f2                	sub    %esi,%edx
  801ba5:	19 cb                	sbb    %ecx,%ebx
  801ba7:	89 d8                	mov    %ebx,%eax
  801ba9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bad:	d3 e0                	shl    %cl,%eax
  801baf:	89 e9                	mov    %ebp,%ecx
  801bb1:	d3 ea                	shr    %cl,%edx
  801bb3:	09 d0                	or     %edx,%eax
  801bb5:	89 e9                	mov    %ebp,%ecx
  801bb7:	d3 eb                	shr    %cl,%ebx
  801bb9:	89 da                	mov    %ebx,%edx
  801bbb:	83 c4 1c             	add    $0x1c,%esp
  801bbe:	5b                   	pop    %ebx
  801bbf:	5e                   	pop    %esi
  801bc0:	5f                   	pop    %edi
  801bc1:	5d                   	pop    %ebp
  801bc2:	c3                   	ret    
  801bc3:	90                   	nop
  801bc4:	89 fd                	mov    %edi,%ebp
  801bc6:	85 ff                	test   %edi,%edi
  801bc8:	75 0b                	jne    801bd5 <__umoddi3+0xe9>
  801bca:	b8 01 00 00 00       	mov    $0x1,%eax
  801bcf:	31 d2                	xor    %edx,%edx
  801bd1:	f7 f7                	div    %edi
  801bd3:	89 c5                	mov    %eax,%ebp
  801bd5:	89 f0                	mov    %esi,%eax
  801bd7:	31 d2                	xor    %edx,%edx
  801bd9:	f7 f5                	div    %ebp
  801bdb:	89 c8                	mov    %ecx,%eax
  801bdd:	f7 f5                	div    %ebp
  801bdf:	89 d0                	mov    %edx,%eax
  801be1:	e9 44 ff ff ff       	jmp    801b2a <__umoddi3+0x3e>
  801be6:	66 90                	xchg   %ax,%ax
  801be8:	89 c8                	mov    %ecx,%eax
  801bea:	89 f2                	mov    %esi,%edx
  801bec:	83 c4 1c             	add    $0x1c,%esp
  801bef:	5b                   	pop    %ebx
  801bf0:	5e                   	pop    %esi
  801bf1:	5f                   	pop    %edi
  801bf2:	5d                   	pop    %ebp
  801bf3:	c3                   	ret    
  801bf4:	3b 04 24             	cmp    (%esp),%eax
  801bf7:	72 06                	jb     801bff <__umoddi3+0x113>
  801bf9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bfd:	77 0f                	ja     801c0e <__umoddi3+0x122>
  801bff:	89 f2                	mov    %esi,%edx
  801c01:	29 f9                	sub    %edi,%ecx
  801c03:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c07:	89 14 24             	mov    %edx,(%esp)
  801c0a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c0e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c12:	8b 14 24             	mov    (%esp),%edx
  801c15:	83 c4 1c             	add    $0x1c,%esp
  801c18:	5b                   	pop    %ebx
  801c19:	5e                   	pop    %esi
  801c1a:	5f                   	pop    %edi
  801c1b:	5d                   	pop    %ebp
  801c1c:	c3                   	ret    
  801c1d:	8d 76 00             	lea    0x0(%esi),%esi
  801c20:	2b 04 24             	sub    (%esp),%eax
  801c23:	19 fa                	sbb    %edi,%edx
  801c25:	89 d1                	mov    %edx,%ecx
  801c27:	89 c6                	mov    %eax,%esi
  801c29:	e9 71 ff ff ff       	jmp    801b9f <__umoddi3+0xb3>
  801c2e:	66 90                	xchg   %ax,%ax
  801c30:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c34:	72 ea                	jb     801c20 <__umoddi3+0x134>
  801c36:	89 d9                	mov    %ebx,%ecx
  801c38:	e9 62 ff ff ff       	jmp    801b9f <__umoddi3+0xb3>
