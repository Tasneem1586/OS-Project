
obj/user/fos_static_data_section:     file format elf32-i386


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
  800031:	e8 1b 00 00 00       	call   800051 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

/// Adding array of 20000 integer on user data section
int arr[20000];

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	atomic_cprintf("user data section contains 20,000 integer\n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 40 1c 80 00       	push   $0x801c40
  800046:	e8 b8 03 00 00       	call   800403 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	
	return;	
  80004e:	90                   	nop
}
  80004f:	c9                   	leave  
  800050:	c3                   	ret    

00800051 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800051:	55                   	push   %ebp
  800052:	89 e5                	mov    %esp,%ebp
  800054:	57                   	push   %edi
  800055:	56                   	push   %esi
  800056:	53                   	push   %ebx
  800057:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80005d:	e8 fb 14 00 00       	call   80155d <sys_getenvindex>
  800062:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800065:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800068:	89 d0                	mov    %edx,%eax
  80006a:	c1 e0 03             	shl    $0x3,%eax
  80006d:	01 d0                	add    %edx,%eax
  80006f:	c1 e0 06             	shl    $0x6,%eax
  800072:	01 d0                	add    %edx,%eax
  800074:	c1 e0 03             	shl    $0x3,%eax
  800077:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80007c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8a 40 10             	mov    0x10(%eax),%al
  800089:	84 c0                	test   %al,%al
  80008b:	74 0d                	je     80009a <libmain+0x49>
		binaryname = myEnv->prog_name;
  80008d:	a1 20 30 80 00       	mov    0x803020,%eax
  800092:	83 c0 10             	add    $0x10,%eax
  800095:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80009a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80009e:	7e 0a                	jle    8000aa <libmain+0x59>
		binaryname = argv[0];
  8000a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a3:	8b 00                	mov    (%eax),%eax
  8000a5:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000aa:	83 ec 08             	sub    $0x8,%esp
  8000ad:	ff 75 0c             	pushl  0xc(%ebp)
  8000b0:	ff 75 08             	pushl  0x8(%ebp)
  8000b3:	e8 80 ff ff ff       	call   800038 <_main>
  8000b8:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000bb:	a1 00 30 80 00       	mov    0x803000,%eax
  8000c0:	85 c0                	test   %eax,%eax
  8000c2:	0f 84 b7 01 00 00    	je     80027f <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000c8:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000ce:	bb a8 1d 80 00       	mov    $0x801da8,%ebx
  8000d3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000d8:	89 c7                	mov    %eax,%edi
  8000da:	89 de                	mov    %ebx,%esi
  8000dc:	89 d1                	mov    %edx,%ecx
  8000de:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000e0:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8000e6:	b9 56 00 00 00       	mov    $0x56,%ecx
  8000eb:	b0 00                	mov    $0x0,%al
  8000ed:	89 d7                	mov    %edx,%edi
  8000ef:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8000f1:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8000f8:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8000fb:	83 ec 08             	sub    $0x8,%esp
  8000fe:	50                   	push   %eax
  8000ff:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800105:	50                   	push   %eax
  800106:	e8 52 16 00 00       	call   80175d <sys_utilities>
  80010b:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80010e:	e8 d2 11 00 00       	call   8012e5 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 84 1c 80 00       	push   $0x801c84
  80011b:	e8 71 02 00 00       	call   800391 <cprintf>
  800120:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800123:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800126:	85 c0                	test   %eax,%eax
  800128:	74 58                	je     800182 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80012a:	e8 4c 16 00 00       	call   80177b <sys_get_optimal_num_faults>
  80012f:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800132:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800138:	bb 0c 1e 80 00       	mov    $0x801e0c,%ebx
  80013d:	ba 11 00 00 00       	mov    $0x11,%edx
  800142:	89 c7                	mov    %eax,%edi
  800144:	89 de                	mov    %ebx,%esi
  800146:	89 d1                	mov    %edx,%ecx
  800148:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80014a:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80014d:	b9 53 00 00 00       	mov    $0x53,%ecx
  800152:	b0 00                	mov    $0x0,%al
  800154:	89 d7                	mov    %edx,%edi
  800156:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800158:	83 ec 08             	sub    $0x8,%esp
  80015b:	ff 75 dc             	pushl  -0x24(%ebp)
  80015e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800164:	50                   	push   %eax
  800165:	e8 f3 15 00 00       	call   80175d <sys_utilities>
  80016a:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80016d:	83 ec 08             	sub    $0x8,%esp
  800170:	ff 75 dc             	pushl  -0x24(%ebp)
  800173:	68 ac 1c 80 00       	push   $0x801cac
  800178:	e8 14 02 00 00       	call   800391 <cprintf>
  80017d:	83 c4 10             	add    $0x10,%esp
  800180:	eb 59                	jmp    8001db <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80018d:	a1 20 30 80 00       	mov    0x803020,%eax
  800192:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	52                   	push   %edx
  80019c:	50                   	push   %eax
  80019d:	68 d0 1c 80 00       	push   $0x801cd0
  8001a2:	e8 ea 01 00 00       	call   800391 <cprintf>
  8001a7:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001af:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c5:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001cb:	51                   	push   %ecx
  8001cc:	52                   	push   %edx
  8001cd:	50                   	push   %eax
  8001ce:	68 f8 1c 80 00       	push   $0x801cf8
  8001d3:	e8 b9 01 00 00       	call   800391 <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001db:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e0:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8001e6:	83 ec 08             	sub    $0x8,%esp
  8001e9:	50                   	push   %eax
  8001ea:	68 50 1d 80 00       	push   $0x801d50
  8001ef:	e8 9d 01 00 00       	call   800391 <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8001f7:	83 ec 0c             	sub    $0xc,%esp
  8001fa:	68 64 1d 80 00       	push   $0x801d64
  8001ff:	e8 8d 01 00 00       	call   800391 <cprintf>
  800204:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800207:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80020e:	eb 28                	jmp    800238 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800210:	a1 20 30 80 00       	mov    0x803020,%eax
  800215:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800218:	81 c2 74 04 00 00    	add    $0x474,%edx
  80021e:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800221:	83 ec 04             	sub    $0x4,%esp
  800224:	50                   	push   %eax
  800225:	ff 75 e4             	pushl  -0x1c(%ebp)
  800228:	68 7b 1d 80 00       	push   $0x801d7b
  80022d:	e8 5f 01 00 00       	call   800391 <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800235:	ff 45 e4             	incl   -0x1c(%ebp)
  800238:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80023c:	7e d2                	jle    800210 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80023e:	83 ec 0c             	sub    $0xc,%esp
  800241:	68 8a 1d 80 00       	push   $0x801d8a
  800246:	e8 46 01 00 00       	call   800391 <cprintf>
  80024b:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80024e:	a1 20 30 80 00       	mov    0x803020,%eax
  800253:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800259:	83 ec 08             	sub    $0x8,%esp
  80025c:	50                   	push   %eax
  80025d:	68 8e 1d 80 00       	push   $0x801d8e
  800262:	e8 2a 01 00 00       	call   800391 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	68 84 1c 80 00       	push   $0x801c84
  800272:	e8 1a 01 00 00       	call   800391 <cprintf>
  800277:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80027a:	e8 80 10 00 00       	call   8012ff <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80027f:	e8 1f 00 00 00       	call   8002a3 <exit>
}
  800284:	90                   	nop
  800285:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800288:	5b                   	pop    %ebx
  800289:	5e                   	pop    %esi
  80028a:	5f                   	pop    %edi
  80028b:	5d                   	pop    %ebp
  80028c:	c3                   	ret    

0080028d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80028d:	55                   	push   %ebp
  80028e:	89 e5                	mov    %esp,%ebp
  800290:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800293:	83 ec 0c             	sub    $0xc,%esp
  800296:	6a 00                	push   $0x0
  800298:	e8 8c 12 00 00       	call   801529 <sys_destroy_env>
  80029d:	83 c4 10             	add    $0x10,%esp
}
  8002a0:	90                   	nop
  8002a1:	c9                   	leave  
  8002a2:	c3                   	ret    

008002a3 <exit>:

void
exit(void)
{
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002a9:	e8 e1 12 00 00       	call   80158f <sys_exit_env>
}
  8002ae:	90                   	nop
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	53                   	push   %ebx
  8002b5:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8002b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002bb:	8b 00                	mov    (%eax),%eax
  8002bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8002c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c3:	89 0a                	mov    %ecx,(%edx)
  8002c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8002c8:	88 d1                	mov    %dl,%cl
  8002ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002cd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d4:	8b 00                	mov    (%eax),%eax
  8002d6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002db:	75 30                	jne    80030d <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8002dd:	8b 15 a8 69 81 00    	mov    0x8169a8,%edx
  8002e3:	a0 c0 68 81 00       	mov    0x8168c0,%al
  8002e8:	0f b6 c0             	movzbl %al,%eax
  8002eb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002ee:	8b 09                	mov    (%ecx),%ecx
  8002f0:	89 cb                	mov    %ecx,%ebx
  8002f2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002f5:	83 c1 08             	add    $0x8,%ecx
  8002f8:	52                   	push   %edx
  8002f9:	50                   	push   %eax
  8002fa:	53                   	push   %ebx
  8002fb:	51                   	push   %ecx
  8002fc:	e8 a0 0f 00 00       	call   8012a1 <sys_cputs>
  800301:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800304:	8b 45 0c             	mov    0xc(%ebp),%eax
  800307:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	8b 40 04             	mov    0x4(%eax),%eax
  800313:	8d 50 01             	lea    0x1(%eax),%edx
  800316:	8b 45 0c             	mov    0xc(%ebp),%eax
  800319:	89 50 04             	mov    %edx,0x4(%eax)
}
  80031c:	90                   	nop
  80031d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800320:	c9                   	leave  
  800321:	c3                   	ret    

00800322 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800322:	55                   	push   %ebp
  800323:	89 e5                	mov    %esp,%ebp
  800325:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80032b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800332:	00 00 00 
	b.cnt = 0;
  800335:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80033c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80033f:	ff 75 0c             	pushl  0xc(%ebp)
  800342:	ff 75 08             	pushl  0x8(%ebp)
  800345:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80034b:	50                   	push   %eax
  80034c:	68 b1 02 80 00       	push   $0x8002b1
  800351:	e8 5a 02 00 00       	call   8005b0 <vprintfmt>
  800356:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800359:	8b 15 a8 69 81 00    	mov    0x8169a8,%edx
  80035f:	a0 c0 68 81 00       	mov    0x8168c0,%al
  800364:	0f b6 c0             	movzbl %al,%eax
  800367:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80036d:	52                   	push   %edx
  80036e:	50                   	push   %eax
  80036f:	51                   	push   %ecx
  800370:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800376:	83 c0 08             	add    $0x8,%eax
  800379:	50                   	push   %eax
  80037a:	e8 22 0f 00 00       	call   8012a1 <sys_cputs>
  80037f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800382:	c6 05 c0 68 81 00 00 	movb   $0x0,0x8168c0
	return b.cnt;
  800389:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80038f:	c9                   	leave  
  800390:	c3                   	ret    

00800391 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800391:	55                   	push   %ebp
  800392:	89 e5                	mov    %esp,%ebp
  800394:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800397:	c6 05 c0 68 81 00 01 	movb   $0x1,0x8168c0
	va_start(ap, fmt);
  80039e:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	83 ec 08             	sub    $0x8,%esp
  8003aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ad:	50                   	push   %eax
  8003ae:	e8 6f ff ff ff       	call   800322 <vcprintf>
  8003b3:	83 c4 10             	add    $0x10,%esp
  8003b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003bc:	c9                   	leave  
  8003bd:	c3                   	ret    

008003be <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8003be:	55                   	push   %ebp
  8003bf:	89 e5                	mov    %esp,%ebp
  8003c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003c4:	c6 05 c0 68 81 00 01 	movb   $0x1,0x8168c0
	curTextClr = (textClr << 8) ; //set text color by the given value
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	c1 e0 08             	shl    $0x8,%eax
  8003d1:	a3 a8 69 81 00       	mov    %eax,0x8169a8
	va_start(ap, fmt);
  8003d6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003d9:	83 c0 04             	add    $0x4,%eax
  8003dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003e8:	50                   	push   %eax
  8003e9:	e8 34 ff ff ff       	call   800322 <vcprintf>
  8003ee:	83 c4 10             	add    $0x10,%esp
  8003f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8003f4:	c7 05 a8 69 81 00 00 	movl   $0x700,0x8169a8
  8003fb:	07 00 00 

	return cnt;
  8003fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800401:	c9                   	leave  
  800402:	c3                   	ret    

00800403 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800403:	55                   	push   %ebp
  800404:	89 e5                	mov    %esp,%ebp
  800406:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800409:	e8 d7 0e 00 00       	call   8012e5 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80040e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800411:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	83 ec 08             	sub    $0x8,%esp
  80041a:	ff 75 f4             	pushl  -0xc(%ebp)
  80041d:	50                   	push   %eax
  80041e:	e8 ff fe ff ff       	call   800322 <vcprintf>
  800423:	83 c4 10             	add    $0x10,%esp
  800426:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800429:	e8 d1 0e 00 00       	call   8012ff <sys_unlock_cons>
	return cnt;
  80042e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800431:	c9                   	leave  
  800432:	c3                   	ret    

00800433 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800433:	55                   	push   %ebp
  800434:	89 e5                	mov    %esp,%ebp
  800436:	53                   	push   %ebx
  800437:	83 ec 14             	sub    $0x14,%esp
  80043a:	8b 45 10             	mov    0x10(%ebp),%eax
  80043d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800440:	8b 45 14             	mov    0x14(%ebp),%eax
  800443:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800446:	8b 45 18             	mov    0x18(%ebp),%eax
  800449:	ba 00 00 00 00       	mov    $0x0,%edx
  80044e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800451:	77 55                	ja     8004a8 <printnum+0x75>
  800453:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800456:	72 05                	jb     80045d <printnum+0x2a>
  800458:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80045b:	77 4b                	ja     8004a8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80045d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800460:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800463:	8b 45 18             	mov    0x18(%ebp),%eax
  800466:	ba 00 00 00 00       	mov    $0x0,%edx
  80046b:	52                   	push   %edx
  80046c:	50                   	push   %eax
  80046d:	ff 75 f4             	pushl  -0xc(%ebp)
  800470:	ff 75 f0             	pushl  -0x10(%ebp)
  800473:	e8 60 15 00 00       	call   8019d8 <__udivdi3>
  800478:	83 c4 10             	add    $0x10,%esp
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	ff 75 20             	pushl  0x20(%ebp)
  800481:	53                   	push   %ebx
  800482:	ff 75 18             	pushl  0x18(%ebp)
  800485:	52                   	push   %edx
  800486:	50                   	push   %eax
  800487:	ff 75 0c             	pushl  0xc(%ebp)
  80048a:	ff 75 08             	pushl  0x8(%ebp)
  80048d:	e8 a1 ff ff ff       	call   800433 <printnum>
  800492:	83 c4 20             	add    $0x20,%esp
  800495:	eb 1a                	jmp    8004b1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800497:	83 ec 08             	sub    $0x8,%esp
  80049a:	ff 75 0c             	pushl  0xc(%ebp)
  80049d:	ff 75 20             	pushl  0x20(%ebp)
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	ff d0                	call   *%eax
  8004a5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004a8:	ff 4d 1c             	decl   0x1c(%ebp)
  8004ab:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004af:	7f e6                	jg     800497 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004b1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004b4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004bf:	53                   	push   %ebx
  8004c0:	51                   	push   %ecx
  8004c1:	52                   	push   %edx
  8004c2:	50                   	push   %eax
  8004c3:	e8 20 16 00 00       	call   801ae8 <__umoddi3>
  8004c8:	83 c4 10             	add    $0x10,%esp
  8004cb:	05 94 20 80 00       	add    $0x802094,%eax
  8004d0:	8a 00                	mov    (%eax),%al
  8004d2:	0f be c0             	movsbl %al,%eax
  8004d5:	83 ec 08             	sub    $0x8,%esp
  8004d8:	ff 75 0c             	pushl  0xc(%ebp)
  8004db:	50                   	push   %eax
  8004dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004df:	ff d0                	call   *%eax
  8004e1:	83 c4 10             	add    $0x10,%esp
}
  8004e4:	90                   	nop
  8004e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004e8:	c9                   	leave  
  8004e9:	c3                   	ret    

008004ea <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004ed:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004f1:	7e 1c                	jle    80050f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f6:	8b 00                	mov    (%eax),%eax
  8004f8:	8d 50 08             	lea    0x8(%eax),%edx
  8004fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fe:	89 10                	mov    %edx,(%eax)
  800500:	8b 45 08             	mov    0x8(%ebp),%eax
  800503:	8b 00                	mov    (%eax),%eax
  800505:	83 e8 08             	sub    $0x8,%eax
  800508:	8b 50 04             	mov    0x4(%eax),%edx
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	eb 40                	jmp    80054f <getuint+0x65>
	else if (lflag)
  80050f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800513:	74 1e                	je     800533 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800515:	8b 45 08             	mov    0x8(%ebp),%eax
  800518:	8b 00                	mov    (%eax),%eax
  80051a:	8d 50 04             	lea    0x4(%eax),%edx
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	89 10                	mov    %edx,(%eax)
  800522:	8b 45 08             	mov    0x8(%ebp),%eax
  800525:	8b 00                	mov    (%eax),%eax
  800527:	83 e8 04             	sub    $0x4,%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	ba 00 00 00 00       	mov    $0x0,%edx
  800531:	eb 1c                	jmp    80054f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800533:	8b 45 08             	mov    0x8(%ebp),%eax
  800536:	8b 00                	mov    (%eax),%eax
  800538:	8d 50 04             	lea    0x4(%eax),%edx
  80053b:	8b 45 08             	mov    0x8(%ebp),%eax
  80053e:	89 10                	mov    %edx,(%eax)
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	8b 00                	mov    (%eax),%eax
  800545:	83 e8 04             	sub    $0x4,%eax
  800548:	8b 00                	mov    (%eax),%eax
  80054a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80054f:	5d                   	pop    %ebp
  800550:	c3                   	ret    

00800551 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800551:	55                   	push   %ebp
  800552:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800554:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800558:	7e 1c                	jle    800576 <getint+0x25>
		return va_arg(*ap, long long);
  80055a:	8b 45 08             	mov    0x8(%ebp),%eax
  80055d:	8b 00                	mov    (%eax),%eax
  80055f:	8d 50 08             	lea    0x8(%eax),%edx
  800562:	8b 45 08             	mov    0x8(%ebp),%eax
  800565:	89 10                	mov    %edx,(%eax)
  800567:	8b 45 08             	mov    0x8(%ebp),%eax
  80056a:	8b 00                	mov    (%eax),%eax
  80056c:	83 e8 08             	sub    $0x8,%eax
  80056f:	8b 50 04             	mov    0x4(%eax),%edx
  800572:	8b 00                	mov    (%eax),%eax
  800574:	eb 38                	jmp    8005ae <getint+0x5d>
	else if (lflag)
  800576:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80057a:	74 1a                	je     800596 <getint+0x45>
		return va_arg(*ap, long);
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	8b 00                	mov    (%eax),%eax
  800581:	8d 50 04             	lea    0x4(%eax),%edx
  800584:	8b 45 08             	mov    0x8(%ebp),%eax
  800587:	89 10                	mov    %edx,(%eax)
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	8b 00                	mov    (%eax),%eax
  80058e:	83 e8 04             	sub    $0x4,%eax
  800591:	8b 00                	mov    (%eax),%eax
  800593:	99                   	cltd   
  800594:	eb 18                	jmp    8005ae <getint+0x5d>
	else
		return va_arg(*ap, int);
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	8b 00                	mov    (%eax),%eax
  80059b:	8d 50 04             	lea    0x4(%eax),%edx
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	89 10                	mov    %edx,(%eax)
  8005a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	83 e8 04             	sub    $0x4,%eax
  8005ab:	8b 00                	mov    (%eax),%eax
  8005ad:	99                   	cltd   
}
  8005ae:	5d                   	pop    %ebp
  8005af:	c3                   	ret    

008005b0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005b0:	55                   	push   %ebp
  8005b1:	89 e5                	mov    %esp,%ebp
  8005b3:	56                   	push   %esi
  8005b4:	53                   	push   %ebx
  8005b5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005b8:	eb 17                	jmp    8005d1 <vprintfmt+0x21>
			if (ch == '\0')
  8005ba:	85 db                	test   %ebx,%ebx
  8005bc:	0f 84 c1 03 00 00    	je     800983 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8005c2:	83 ec 08             	sub    $0x8,%esp
  8005c5:	ff 75 0c             	pushl  0xc(%ebp)
  8005c8:	53                   	push   %ebx
  8005c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cc:	ff d0                	call   *%eax
  8005ce:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d4:	8d 50 01             	lea    0x1(%eax),%edx
  8005d7:	89 55 10             	mov    %edx,0x10(%ebp)
  8005da:	8a 00                	mov    (%eax),%al
  8005dc:	0f b6 d8             	movzbl %al,%ebx
  8005df:	83 fb 25             	cmp    $0x25,%ebx
  8005e2:	75 d6                	jne    8005ba <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005e4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005e8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005ef:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005f6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005fd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800604:	8b 45 10             	mov    0x10(%ebp),%eax
  800607:	8d 50 01             	lea    0x1(%eax),%edx
  80060a:	89 55 10             	mov    %edx,0x10(%ebp)
  80060d:	8a 00                	mov    (%eax),%al
  80060f:	0f b6 d8             	movzbl %al,%ebx
  800612:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800615:	83 f8 5b             	cmp    $0x5b,%eax
  800618:	0f 87 3d 03 00 00    	ja     80095b <vprintfmt+0x3ab>
  80061e:	8b 04 85 b8 20 80 00 	mov    0x8020b8(,%eax,4),%eax
  800625:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800627:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80062b:	eb d7                	jmp    800604 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80062d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800631:	eb d1                	jmp    800604 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800633:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80063a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80063d:	89 d0                	mov    %edx,%eax
  80063f:	c1 e0 02             	shl    $0x2,%eax
  800642:	01 d0                	add    %edx,%eax
  800644:	01 c0                	add    %eax,%eax
  800646:	01 d8                	add    %ebx,%eax
  800648:	83 e8 30             	sub    $0x30,%eax
  80064b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80064e:	8b 45 10             	mov    0x10(%ebp),%eax
  800651:	8a 00                	mov    (%eax),%al
  800653:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800656:	83 fb 2f             	cmp    $0x2f,%ebx
  800659:	7e 3e                	jle    800699 <vprintfmt+0xe9>
  80065b:	83 fb 39             	cmp    $0x39,%ebx
  80065e:	7f 39                	jg     800699 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800660:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800663:	eb d5                	jmp    80063a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800665:	8b 45 14             	mov    0x14(%ebp),%eax
  800668:	83 c0 04             	add    $0x4,%eax
  80066b:	89 45 14             	mov    %eax,0x14(%ebp)
  80066e:	8b 45 14             	mov    0x14(%ebp),%eax
  800671:	83 e8 04             	sub    $0x4,%eax
  800674:	8b 00                	mov    (%eax),%eax
  800676:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800679:	eb 1f                	jmp    80069a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80067b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067f:	79 83                	jns    800604 <vprintfmt+0x54>
				width = 0;
  800681:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800688:	e9 77 ff ff ff       	jmp    800604 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80068d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800694:	e9 6b ff ff ff       	jmp    800604 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800699:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80069a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80069e:	0f 89 60 ff ff ff    	jns    800604 <vprintfmt+0x54>
				width = precision, precision = -1;
  8006a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006aa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006b1:	e9 4e ff ff ff       	jmp    800604 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006b6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006b9:	e9 46 ff ff ff       	jmp    800604 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006be:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c1:	83 c0 04             	add    $0x4,%eax
  8006c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8006c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ca:	83 e8 04             	sub    $0x4,%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	83 ec 08             	sub    $0x8,%esp
  8006d2:	ff 75 0c             	pushl  0xc(%ebp)
  8006d5:	50                   	push   %eax
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	ff d0                	call   *%eax
  8006db:	83 c4 10             	add    $0x10,%esp
			break;
  8006de:	e9 9b 02 00 00       	jmp    80097e <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e6:	83 c0 04             	add    $0x4,%eax
  8006e9:	89 45 14             	mov    %eax,0x14(%ebp)
  8006ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ef:	83 e8 04             	sub    $0x4,%eax
  8006f2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006f4:	85 db                	test   %ebx,%ebx
  8006f6:	79 02                	jns    8006fa <vprintfmt+0x14a>
				err = -err;
  8006f8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006fa:	83 fb 64             	cmp    $0x64,%ebx
  8006fd:	7f 0b                	jg     80070a <vprintfmt+0x15a>
  8006ff:	8b 34 9d 00 1f 80 00 	mov    0x801f00(,%ebx,4),%esi
  800706:	85 f6                	test   %esi,%esi
  800708:	75 19                	jne    800723 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80070a:	53                   	push   %ebx
  80070b:	68 a5 20 80 00       	push   $0x8020a5
  800710:	ff 75 0c             	pushl  0xc(%ebp)
  800713:	ff 75 08             	pushl  0x8(%ebp)
  800716:	e8 70 02 00 00       	call   80098b <printfmt>
  80071b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80071e:	e9 5b 02 00 00       	jmp    80097e <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800723:	56                   	push   %esi
  800724:	68 ae 20 80 00       	push   $0x8020ae
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	ff 75 08             	pushl  0x8(%ebp)
  80072f:	e8 57 02 00 00       	call   80098b <printfmt>
  800734:	83 c4 10             	add    $0x10,%esp
			break;
  800737:	e9 42 02 00 00       	jmp    80097e <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80073c:	8b 45 14             	mov    0x14(%ebp),%eax
  80073f:	83 c0 04             	add    $0x4,%eax
  800742:	89 45 14             	mov    %eax,0x14(%ebp)
  800745:	8b 45 14             	mov    0x14(%ebp),%eax
  800748:	83 e8 04             	sub    $0x4,%eax
  80074b:	8b 30                	mov    (%eax),%esi
  80074d:	85 f6                	test   %esi,%esi
  80074f:	75 05                	jne    800756 <vprintfmt+0x1a6>
				p = "(null)";
  800751:	be b1 20 80 00       	mov    $0x8020b1,%esi
			if (width > 0 && padc != '-')
  800756:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075a:	7e 6d                	jle    8007c9 <vprintfmt+0x219>
  80075c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800760:	74 67                	je     8007c9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800762:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	50                   	push   %eax
  800769:	56                   	push   %esi
  80076a:	e8 1e 03 00 00       	call   800a8d <strnlen>
  80076f:	83 c4 10             	add    $0x10,%esp
  800772:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800775:	eb 16                	jmp    80078d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800777:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80077b:	83 ec 08             	sub    $0x8,%esp
  80077e:	ff 75 0c             	pushl  0xc(%ebp)
  800781:	50                   	push   %eax
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	ff d0                	call   *%eax
  800787:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80078a:	ff 4d e4             	decl   -0x1c(%ebp)
  80078d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800791:	7f e4                	jg     800777 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800793:	eb 34                	jmp    8007c9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800795:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800799:	74 1c                	je     8007b7 <vprintfmt+0x207>
  80079b:	83 fb 1f             	cmp    $0x1f,%ebx
  80079e:	7e 05                	jle    8007a5 <vprintfmt+0x1f5>
  8007a0:	83 fb 7e             	cmp    $0x7e,%ebx
  8007a3:	7e 12                	jle    8007b7 <vprintfmt+0x207>
					putch('?', putdat);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	6a 3f                	push   $0x3f
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	ff d0                	call   *%eax
  8007b2:	83 c4 10             	add    $0x10,%esp
  8007b5:	eb 0f                	jmp    8007c6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 0c             	pushl  0xc(%ebp)
  8007bd:	53                   	push   %ebx
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	ff d0                	call   *%eax
  8007c3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007c6:	ff 4d e4             	decl   -0x1c(%ebp)
  8007c9:	89 f0                	mov    %esi,%eax
  8007cb:	8d 70 01             	lea    0x1(%eax),%esi
  8007ce:	8a 00                	mov    (%eax),%al
  8007d0:	0f be d8             	movsbl %al,%ebx
  8007d3:	85 db                	test   %ebx,%ebx
  8007d5:	74 24                	je     8007fb <vprintfmt+0x24b>
  8007d7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007db:	78 b8                	js     800795 <vprintfmt+0x1e5>
  8007dd:	ff 4d e0             	decl   -0x20(%ebp)
  8007e0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007e4:	79 af                	jns    800795 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007e6:	eb 13                	jmp    8007fb <vprintfmt+0x24b>
				putch(' ', putdat);
  8007e8:	83 ec 08             	sub    $0x8,%esp
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	6a 20                	push   $0x20
  8007f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f3:	ff d0                	call   *%eax
  8007f5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007f8:	ff 4d e4             	decl   -0x1c(%ebp)
  8007fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ff:	7f e7                	jg     8007e8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800801:	e9 78 01 00 00       	jmp    80097e <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800806:	83 ec 08             	sub    $0x8,%esp
  800809:	ff 75 e8             	pushl  -0x18(%ebp)
  80080c:	8d 45 14             	lea    0x14(%ebp),%eax
  80080f:	50                   	push   %eax
  800810:	e8 3c fd ff ff       	call   800551 <getint>
  800815:	83 c4 10             	add    $0x10,%esp
  800818:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80081b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80081e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800821:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800824:	85 d2                	test   %edx,%edx
  800826:	79 23                	jns    80084b <vprintfmt+0x29b>
				putch('-', putdat);
  800828:	83 ec 08             	sub    $0x8,%esp
  80082b:	ff 75 0c             	pushl  0xc(%ebp)
  80082e:	6a 2d                	push   $0x2d
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	ff d0                	call   *%eax
  800835:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800838:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80083e:	f7 d8                	neg    %eax
  800840:	83 d2 00             	adc    $0x0,%edx
  800843:	f7 da                	neg    %edx
  800845:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800848:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80084b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800852:	e9 bc 00 00 00       	jmp    800913 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800857:	83 ec 08             	sub    $0x8,%esp
  80085a:	ff 75 e8             	pushl  -0x18(%ebp)
  80085d:	8d 45 14             	lea    0x14(%ebp),%eax
  800860:	50                   	push   %eax
  800861:	e8 84 fc ff ff       	call   8004ea <getuint>
  800866:	83 c4 10             	add    $0x10,%esp
  800869:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80086f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800876:	e9 98 00 00 00       	jmp    800913 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80087b:	83 ec 08             	sub    $0x8,%esp
  80087e:	ff 75 0c             	pushl  0xc(%ebp)
  800881:	6a 58                	push   $0x58
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	ff d0                	call   *%eax
  800888:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 0c             	pushl  0xc(%ebp)
  800891:	6a 58                	push   $0x58
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	ff d0                	call   *%eax
  800898:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	6a 58                	push   $0x58
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	ff d0                	call   *%eax
  8008a8:	83 c4 10             	add    $0x10,%esp
			break;
  8008ab:	e9 ce 00 00 00       	jmp    80097e <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8008b0:	83 ec 08             	sub    $0x8,%esp
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	6a 30                	push   $0x30
  8008b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bb:	ff d0                	call   *%eax
  8008bd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008c0:	83 ec 08             	sub    $0x8,%esp
  8008c3:	ff 75 0c             	pushl  0xc(%ebp)
  8008c6:	6a 78                	push   $0x78
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	ff d0                	call   *%eax
  8008cd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d3:	83 c0 04             	add    $0x4,%eax
  8008d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8008d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008dc:	83 e8 04             	sub    $0x4,%eax
  8008df:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008eb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008f2:	eb 1f                	jmp    800913 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008f4:	83 ec 08             	sub    $0x8,%esp
  8008f7:	ff 75 e8             	pushl  -0x18(%ebp)
  8008fa:	8d 45 14             	lea    0x14(%ebp),%eax
  8008fd:	50                   	push   %eax
  8008fe:	e8 e7 fb ff ff       	call   8004ea <getuint>
  800903:	83 c4 10             	add    $0x10,%esp
  800906:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800909:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80090c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800913:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800917:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80091a:	83 ec 04             	sub    $0x4,%esp
  80091d:	52                   	push   %edx
  80091e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800921:	50                   	push   %eax
  800922:	ff 75 f4             	pushl  -0xc(%ebp)
  800925:	ff 75 f0             	pushl  -0x10(%ebp)
  800928:	ff 75 0c             	pushl  0xc(%ebp)
  80092b:	ff 75 08             	pushl  0x8(%ebp)
  80092e:	e8 00 fb ff ff       	call   800433 <printnum>
  800933:	83 c4 20             	add    $0x20,%esp
			break;
  800936:	eb 46                	jmp    80097e <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 0c             	pushl  0xc(%ebp)
  80093e:	53                   	push   %ebx
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
			break;
  800947:	eb 35                	jmp    80097e <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800949:	c6 05 c0 68 81 00 00 	movb   $0x0,0x8168c0
			break;
  800950:	eb 2c                	jmp    80097e <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800952:	c6 05 c0 68 81 00 01 	movb   $0x1,0x8168c0
			break;
  800959:	eb 23                	jmp    80097e <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80095b:	83 ec 08             	sub    $0x8,%esp
  80095e:	ff 75 0c             	pushl  0xc(%ebp)
  800961:	6a 25                	push   $0x25
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	ff d0                	call   *%eax
  800968:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80096b:	ff 4d 10             	decl   0x10(%ebp)
  80096e:	eb 03                	jmp    800973 <vprintfmt+0x3c3>
  800970:	ff 4d 10             	decl   0x10(%ebp)
  800973:	8b 45 10             	mov    0x10(%ebp),%eax
  800976:	48                   	dec    %eax
  800977:	8a 00                	mov    (%eax),%al
  800979:	3c 25                	cmp    $0x25,%al
  80097b:	75 f3                	jne    800970 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80097d:	90                   	nop
		}
	}
  80097e:	e9 35 fc ff ff       	jmp    8005b8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800983:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800984:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800987:	5b                   	pop    %ebx
  800988:	5e                   	pop    %esi
  800989:	5d                   	pop    %ebp
  80098a:	c3                   	ret    

0080098b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80098b:	55                   	push   %ebp
  80098c:	89 e5                	mov    %esp,%ebp
  80098e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800991:	8d 45 10             	lea    0x10(%ebp),%eax
  800994:	83 c0 04             	add    $0x4,%eax
  800997:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80099a:	8b 45 10             	mov    0x10(%ebp),%eax
  80099d:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a0:	50                   	push   %eax
  8009a1:	ff 75 0c             	pushl  0xc(%ebp)
  8009a4:	ff 75 08             	pushl  0x8(%ebp)
  8009a7:	e8 04 fc ff ff       	call   8005b0 <vprintfmt>
  8009ac:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009af:	90                   	nop
  8009b0:	c9                   	leave  
  8009b1:	c3                   	ret    

008009b2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009b2:	55                   	push   %ebp
  8009b3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b8:	8b 40 08             	mov    0x8(%eax),%eax
  8009bb:	8d 50 01             	lea    0x1(%eax),%edx
  8009be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c7:	8b 10                	mov    (%eax),%edx
  8009c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cc:	8b 40 04             	mov    0x4(%eax),%eax
  8009cf:	39 c2                	cmp    %eax,%edx
  8009d1:	73 12                	jae    8009e5 <sprintputch+0x33>
		*b->buf++ = ch;
  8009d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d6:	8b 00                	mov    (%eax),%eax
  8009d8:	8d 48 01             	lea    0x1(%eax),%ecx
  8009db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009de:	89 0a                	mov    %ecx,(%edx)
  8009e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8009e3:	88 10                	mov    %dl,(%eax)
}
  8009e5:	90                   	nop
  8009e6:	5d                   	pop    %ebp
  8009e7:	c3                   	ret    

008009e8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009e8:	55                   	push   %ebp
  8009e9:	89 e5                	mov    %esp,%ebp
  8009eb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	01 d0                	add    %edx,%eax
  8009ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a09:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a0d:	74 06                	je     800a15 <vsnprintf+0x2d>
  800a0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a13:	7f 07                	jg     800a1c <vsnprintf+0x34>
		return -E_INVAL;
  800a15:	b8 03 00 00 00       	mov    $0x3,%eax
  800a1a:	eb 20                	jmp    800a3c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a1c:	ff 75 14             	pushl  0x14(%ebp)
  800a1f:	ff 75 10             	pushl  0x10(%ebp)
  800a22:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a25:	50                   	push   %eax
  800a26:	68 b2 09 80 00       	push   $0x8009b2
  800a2b:	e8 80 fb ff ff       	call   8005b0 <vprintfmt>
  800a30:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a36:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a3c:	c9                   	leave  
  800a3d:	c3                   	ret    

00800a3e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
  800a41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a44:	8d 45 10             	lea    0x10(%ebp),%eax
  800a47:	83 c0 04             	add    $0x4,%eax
  800a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a50:	ff 75 f4             	pushl  -0xc(%ebp)
  800a53:	50                   	push   %eax
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 08             	pushl  0x8(%ebp)
  800a5a:	e8 89 ff ff ff       	call   8009e8 <vsnprintf>
  800a5f:	83 c4 10             	add    $0x10,%esp
  800a62:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a68:	c9                   	leave  
  800a69:	c3                   	ret    

00800a6a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a6a:	55                   	push   %ebp
  800a6b:	89 e5                	mov    %esp,%ebp
  800a6d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a77:	eb 06                	jmp    800a7f <strlen+0x15>
		n++;
  800a79:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a7c:	ff 45 08             	incl   0x8(%ebp)
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	8a 00                	mov    (%eax),%al
  800a84:	84 c0                	test   %al,%al
  800a86:	75 f1                	jne    800a79 <strlen+0xf>
		n++;
	return n;
  800a88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a8b:	c9                   	leave  
  800a8c:	c3                   	ret    

00800a8d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a9a:	eb 09                	jmp    800aa5 <strnlen+0x18>
		n++;
  800a9c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a9f:	ff 45 08             	incl   0x8(%ebp)
  800aa2:	ff 4d 0c             	decl   0xc(%ebp)
  800aa5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa9:	74 09                	je     800ab4 <strnlen+0x27>
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	8a 00                	mov    (%eax),%al
  800ab0:	84 c0                	test   %al,%al
  800ab2:	75 e8                	jne    800a9c <strnlen+0xf>
		n++;
	return n;
  800ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ab7:	c9                   	leave  
  800ab8:	c3                   	ret    

00800ab9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ab9:	55                   	push   %ebp
  800aba:	89 e5                	mov    %esp,%ebp
  800abc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ac5:	90                   	nop
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	8d 50 01             	lea    0x1(%eax),%edx
  800acc:	89 55 08             	mov    %edx,0x8(%ebp)
  800acf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ad5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ad8:	8a 12                	mov    (%edx),%dl
  800ada:	88 10                	mov    %dl,(%eax)
  800adc:	8a 00                	mov    (%eax),%al
  800ade:	84 c0                	test   %al,%al
  800ae0:	75 e4                	jne    800ac6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ae2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ae5:	c9                   	leave  
  800ae6:	c3                   	ret    

00800ae7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ae7:	55                   	push   %ebp
  800ae8:	89 e5                	mov    %esp,%ebp
  800aea:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800af3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800afa:	eb 1f                	jmp    800b1b <strncpy+0x34>
		*dst++ = *src;
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8d 50 01             	lea    0x1(%eax),%edx
  800b02:	89 55 08             	mov    %edx,0x8(%ebp)
  800b05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b08:	8a 12                	mov    (%edx),%dl
  800b0a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0f:	8a 00                	mov    (%eax),%al
  800b11:	84 c0                	test   %al,%al
  800b13:	74 03                	je     800b18 <strncpy+0x31>
			src++;
  800b15:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b18:	ff 45 fc             	incl   -0x4(%ebp)
  800b1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b1e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b21:	72 d9                	jb     800afc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b23:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b26:	c9                   	leave  
  800b27:	c3                   	ret    

00800b28 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b28:	55                   	push   %ebp
  800b29:	89 e5                	mov    %esp,%ebp
  800b2b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b38:	74 30                	je     800b6a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b3a:	eb 16                	jmp    800b52 <strlcpy+0x2a>
			*dst++ = *src++;
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	8d 50 01             	lea    0x1(%eax),%edx
  800b42:	89 55 08             	mov    %edx,0x8(%ebp)
  800b45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b48:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b4b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b4e:	8a 12                	mov    (%edx),%dl
  800b50:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b52:	ff 4d 10             	decl   0x10(%ebp)
  800b55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b59:	74 09                	je     800b64 <strlcpy+0x3c>
  800b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	84 c0                	test   %al,%al
  800b62:	75 d8                	jne    800b3c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b6a:	8b 55 08             	mov    0x8(%ebp),%edx
  800b6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b70:	29 c2                	sub    %eax,%edx
  800b72:	89 d0                	mov    %edx,%eax
}
  800b74:	c9                   	leave  
  800b75:	c3                   	ret    

00800b76 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b76:	55                   	push   %ebp
  800b77:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b79:	eb 06                	jmp    800b81 <strcmp+0xb>
		p++, q++;
  800b7b:	ff 45 08             	incl   0x8(%ebp)
  800b7e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	8a 00                	mov    (%eax),%al
  800b86:	84 c0                	test   %al,%al
  800b88:	74 0e                	je     800b98 <strcmp+0x22>
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8a 10                	mov    (%eax),%dl
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	8a 00                	mov    (%eax),%al
  800b94:	38 c2                	cmp    %al,%dl
  800b96:	74 e3                	je     800b7b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	0f b6 d0             	movzbl %al,%edx
  800ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba3:	8a 00                	mov    (%eax),%al
  800ba5:	0f b6 c0             	movzbl %al,%eax
  800ba8:	29 c2                	sub    %eax,%edx
  800baa:	89 d0                	mov    %edx,%eax
}
  800bac:	5d                   	pop    %ebp
  800bad:	c3                   	ret    

00800bae <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bb1:	eb 09                	jmp    800bbc <strncmp+0xe>
		n--, p++, q++;
  800bb3:	ff 4d 10             	decl   0x10(%ebp)
  800bb6:	ff 45 08             	incl   0x8(%ebp)
  800bb9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bbc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bc0:	74 17                	je     800bd9 <strncmp+0x2b>
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	84 c0                	test   %al,%al
  800bc9:	74 0e                	je     800bd9 <strncmp+0x2b>
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8a 10                	mov    (%eax),%dl
  800bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd3:	8a 00                	mov    (%eax),%al
  800bd5:	38 c2                	cmp    %al,%dl
  800bd7:	74 da                	je     800bb3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bdd:	75 07                	jne    800be6 <strncmp+0x38>
		return 0;
  800bdf:	b8 00 00 00 00       	mov    $0x0,%eax
  800be4:	eb 14                	jmp    800bfa <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	8a 00                	mov    (%eax),%al
  800beb:	0f b6 d0             	movzbl %al,%edx
  800bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	0f b6 c0             	movzbl %al,%eax
  800bf6:	29 c2                	sub    %eax,%edx
  800bf8:	89 d0                	mov    %edx,%eax
}
  800bfa:	5d                   	pop    %ebp
  800bfb:	c3                   	ret    

00800bfc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bfc:	55                   	push   %ebp
  800bfd:	89 e5                	mov    %esp,%ebp
  800bff:	83 ec 04             	sub    $0x4,%esp
  800c02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c05:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c08:	eb 12                	jmp    800c1c <strchr+0x20>
		if (*s == c)
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	8a 00                	mov    (%eax),%al
  800c0f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c12:	75 05                	jne    800c19 <strchr+0x1d>
			return (char *) s;
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	eb 11                	jmp    800c2a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c19:	ff 45 08             	incl   0x8(%ebp)
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	84 c0                	test   %al,%al
  800c23:	75 e5                	jne    800c0a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 04             	sub    $0x4,%esp
  800c32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c35:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c38:	eb 0d                	jmp    800c47 <strfind+0x1b>
		if (*s == c)
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	8a 00                	mov    (%eax),%al
  800c3f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c42:	74 0e                	je     800c52 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c44:	ff 45 08             	incl   0x8(%ebp)
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	8a 00                	mov    (%eax),%al
  800c4c:	84 c0                	test   %al,%al
  800c4e:	75 ea                	jne    800c3a <strfind+0xe>
  800c50:	eb 01                	jmp    800c53 <strfind+0x27>
		if (*s == c)
			break;
  800c52:	90                   	nop
	return (char *) s;
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c56:	c9                   	leave  
  800c57:	c3                   	ret    

00800c58 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800c58:	55                   	push   %ebp
  800c59:	89 e5                	mov    %esp,%ebp
  800c5b:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800c64:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800c68:	76 63                	jbe    800ccd <memset+0x75>
		uint64 data_block = c;
  800c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6d:	99                   	cltd   
  800c6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c71:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c77:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7a:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800c7e:	c1 e0 08             	shl    $0x8,%eax
  800c81:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c84:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c8d:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800c91:	c1 e0 10             	shl    $0x10,%eax
  800c94:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c97:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800c9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca0:	89 c2                	mov    %eax,%edx
  800ca2:	b8 00 00 00 00       	mov    $0x0,%eax
  800ca7:	09 45 f0             	or     %eax,-0x10(%ebp)
  800caa:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800cad:	eb 18                	jmp    800cc7 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800caf:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800cb2:	8d 41 08             	lea    0x8(%ecx),%eax
  800cb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800cb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cbe:	89 01                	mov    %eax,(%ecx)
  800cc0:	89 51 04             	mov    %edx,0x4(%ecx)
  800cc3:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800cc7:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ccb:	77 e2                	ja     800caf <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800ccd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd1:	74 23                	je     800cf6 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800cd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cd9:	eb 0e                	jmp    800ce9 <memset+0x91>
			*p8++ = (uint8)c;
  800cdb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cde:	8d 50 01             	lea    0x1(%eax),%edx
  800ce1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ce4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce7:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ce9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cec:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cef:	89 55 10             	mov    %edx,0x10(%ebp)
  800cf2:	85 c0                	test   %eax,%eax
  800cf4:	75 e5                	jne    800cdb <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d0d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d11:	76 24                	jbe    800d37 <memcpy+0x3c>
		while(n >= 8){
  800d13:	eb 1c                	jmp    800d31 <memcpy+0x36>
			*d64 = *s64;
  800d15:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d18:	8b 50 04             	mov    0x4(%eax),%edx
  800d1b:	8b 00                	mov    (%eax),%eax
  800d1d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d20:	89 01                	mov    %eax,(%ecx)
  800d22:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d25:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d29:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d2d:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d31:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d35:	77 de                	ja     800d15 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3b:	74 31                	je     800d6e <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d40:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d46:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800d49:	eb 16                	jmp    800d61 <memcpy+0x66>
			*d8++ = *s8++;
  800d4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d4e:	8d 50 01             	lea    0x1(%eax),%edx
  800d51:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800d54:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d57:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d5a:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800d5d:	8a 12                	mov    (%edx),%dl
  800d5f:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800d61:	8b 45 10             	mov    0x10(%ebp),%eax
  800d64:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d67:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6a:	85 c0                	test   %eax,%eax
  800d6c:	75 dd                	jne    800d4b <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d71:	c9                   	leave  
  800d72:	c3                   	ret    

00800d73 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d73:	55                   	push   %ebp
  800d74:	89 e5                	mov    %esp,%ebp
  800d76:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d88:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d8b:	73 50                	jae    800ddd <memmove+0x6a>
  800d8d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d90:	8b 45 10             	mov    0x10(%ebp),%eax
  800d93:	01 d0                	add    %edx,%eax
  800d95:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d98:	76 43                	jbe    800ddd <memmove+0x6a>
		s += n;
  800d9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800da0:	8b 45 10             	mov    0x10(%ebp),%eax
  800da3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800da6:	eb 10                	jmp    800db8 <memmove+0x45>
			*--d = *--s;
  800da8:	ff 4d f8             	decl   -0x8(%ebp)
  800dab:	ff 4d fc             	decl   -0x4(%ebp)
  800dae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db1:	8a 10                	mov    (%eax),%dl
  800db3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800db8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dbe:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc1:	85 c0                	test   %eax,%eax
  800dc3:	75 e3                	jne    800da8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dc5:	eb 23                	jmp    800dea <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dca:	8d 50 01             	lea    0x1(%eax),%edx
  800dcd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dd9:	8a 12                	mov    (%edx),%dl
  800ddb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ddd:	8b 45 10             	mov    0x10(%ebp),%eax
  800de0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de3:	89 55 10             	mov    %edx,0x10(%ebp)
  800de6:	85 c0                	test   %eax,%eax
  800de8:	75 dd                	jne    800dc7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ded:	c9                   	leave  
  800dee:	c3                   	ret    

00800def <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800def:	55                   	push   %ebp
  800df0:	89 e5                	mov    %esp,%ebp
  800df2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfe:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e01:	eb 2a                	jmp    800e2d <memcmp+0x3e>
		if (*s1 != *s2)
  800e03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e06:	8a 10                	mov    (%eax),%dl
  800e08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0b:	8a 00                	mov    (%eax),%al
  800e0d:	38 c2                	cmp    %al,%dl
  800e0f:	74 16                	je     800e27 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	8a 00                	mov    (%eax),%al
  800e16:	0f b6 d0             	movzbl %al,%edx
  800e19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f b6 c0             	movzbl %al,%eax
  800e21:	29 c2                	sub    %eax,%edx
  800e23:	89 d0                	mov    %edx,%eax
  800e25:	eb 18                	jmp    800e3f <memcmp+0x50>
		s1++, s2++;
  800e27:	ff 45 fc             	incl   -0x4(%ebp)
  800e2a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e30:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e33:	89 55 10             	mov    %edx,0x10(%ebp)
  800e36:	85 c0                	test   %eax,%eax
  800e38:	75 c9                	jne    800e03 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e3f:	c9                   	leave  
  800e40:	c3                   	ret    

00800e41 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e41:	55                   	push   %ebp
  800e42:	89 e5                	mov    %esp,%ebp
  800e44:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e47:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4d:	01 d0                	add    %edx,%eax
  800e4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e52:	eb 15                	jmp    800e69 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	0f b6 d0             	movzbl %al,%edx
  800e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5f:	0f b6 c0             	movzbl %al,%eax
  800e62:	39 c2                	cmp    %eax,%edx
  800e64:	74 0d                	je     800e73 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e66:	ff 45 08             	incl   0x8(%ebp)
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e6f:	72 e3                	jb     800e54 <memfind+0x13>
  800e71:	eb 01                	jmp    800e74 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e73:	90                   	nop
	return (void *) s;
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e77:	c9                   	leave  
  800e78:	c3                   	ret    

00800e79 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e79:	55                   	push   %ebp
  800e7a:	89 e5                	mov    %esp,%ebp
  800e7c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e86:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e8d:	eb 03                	jmp    800e92 <strtol+0x19>
		s++;
  800e8f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	3c 20                	cmp    $0x20,%al
  800e99:	74 f4                	je     800e8f <strtol+0x16>
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	3c 09                	cmp    $0x9,%al
  800ea2:	74 eb                	je     800e8f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	3c 2b                	cmp    $0x2b,%al
  800eab:	75 05                	jne    800eb2 <strtol+0x39>
		s++;
  800ead:	ff 45 08             	incl   0x8(%ebp)
  800eb0:	eb 13                	jmp    800ec5 <strtol+0x4c>
	else if (*s == '-')
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	3c 2d                	cmp    $0x2d,%al
  800eb9:	75 0a                	jne    800ec5 <strtol+0x4c>
		s++, neg = 1;
  800ebb:	ff 45 08             	incl   0x8(%ebp)
  800ebe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ec5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec9:	74 06                	je     800ed1 <strtol+0x58>
  800ecb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ecf:	75 20                	jne    800ef1 <strtol+0x78>
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	3c 30                	cmp    $0x30,%al
  800ed8:	75 17                	jne    800ef1 <strtol+0x78>
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	40                   	inc    %eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	3c 78                	cmp    $0x78,%al
  800ee2:	75 0d                	jne    800ef1 <strtol+0x78>
		s += 2, base = 16;
  800ee4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ee8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800eef:	eb 28                	jmp    800f19 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ef1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef5:	75 15                	jne    800f0c <strtol+0x93>
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	3c 30                	cmp    $0x30,%al
  800efe:	75 0c                	jne    800f0c <strtol+0x93>
		s++, base = 8;
  800f00:	ff 45 08             	incl   0x8(%ebp)
  800f03:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f0a:	eb 0d                	jmp    800f19 <strtol+0xa0>
	else if (base == 0)
  800f0c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f10:	75 07                	jne    800f19 <strtol+0xa0>
		base = 10;
  800f12:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	3c 2f                	cmp    $0x2f,%al
  800f20:	7e 19                	jle    800f3b <strtol+0xc2>
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	3c 39                	cmp    $0x39,%al
  800f29:	7f 10                	jg     800f3b <strtol+0xc2>
			dig = *s - '0';
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	8a 00                	mov    (%eax),%al
  800f30:	0f be c0             	movsbl %al,%eax
  800f33:	83 e8 30             	sub    $0x30,%eax
  800f36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f39:	eb 42                	jmp    800f7d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	3c 60                	cmp    $0x60,%al
  800f42:	7e 19                	jle    800f5d <strtol+0xe4>
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	3c 7a                	cmp    $0x7a,%al
  800f4b:	7f 10                	jg     800f5d <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	0f be c0             	movsbl %al,%eax
  800f55:	83 e8 57             	sub    $0x57,%eax
  800f58:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f5b:	eb 20                	jmp    800f7d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	3c 40                	cmp    $0x40,%al
  800f64:	7e 39                	jle    800f9f <strtol+0x126>
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	3c 5a                	cmp    $0x5a,%al
  800f6d:	7f 30                	jg     800f9f <strtol+0x126>
			dig = *s - 'A' + 10;
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	0f be c0             	movsbl %al,%eax
  800f77:	83 e8 37             	sub    $0x37,%eax
  800f7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f80:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f83:	7d 19                	jge    800f9e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f85:	ff 45 08             	incl   0x8(%ebp)
  800f88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8b:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f8f:	89 c2                	mov    %eax,%edx
  800f91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f94:	01 d0                	add    %edx,%eax
  800f96:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f99:	e9 7b ff ff ff       	jmp    800f19 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f9e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f9f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa3:	74 08                	je     800fad <strtol+0x134>
		*endptr = (char *) s;
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8b 55 08             	mov    0x8(%ebp),%edx
  800fab:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fad:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fb1:	74 07                	je     800fba <strtol+0x141>
  800fb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb6:	f7 d8                	neg    %eax
  800fb8:	eb 03                	jmp    800fbd <strtol+0x144>
  800fba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fbd:	c9                   	leave  
  800fbe:	c3                   	ret    

00800fbf <ltostr>:

void
ltostr(long value, char *str)
{
  800fbf:	55                   	push   %ebp
  800fc0:	89 e5                	mov    %esp,%ebp
  800fc2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fcc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fd3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fd7:	79 13                	jns    800fec <ltostr+0x2d>
	{
		neg = 1;
  800fd9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fe6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fe9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ff4:	99                   	cltd   
  800ff5:	f7 f9                	idiv   %ecx
  800ff7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ffa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffd:	8d 50 01             	lea    0x1(%eax),%edx
  801000:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801003:	89 c2                	mov    %eax,%edx
  801005:	8b 45 0c             	mov    0xc(%ebp),%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80100d:	83 c2 30             	add    $0x30,%edx
  801010:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801012:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801015:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80101a:	f7 e9                	imul   %ecx
  80101c:	c1 fa 02             	sar    $0x2,%edx
  80101f:	89 c8                	mov    %ecx,%eax
  801021:	c1 f8 1f             	sar    $0x1f,%eax
  801024:	29 c2                	sub    %eax,%edx
  801026:	89 d0                	mov    %edx,%eax
  801028:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80102b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80102f:	75 bb                	jne    800fec <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801031:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801038:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103b:	48                   	dec    %eax
  80103c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80103f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801043:	74 3d                	je     801082 <ltostr+0xc3>
		start = 1 ;
  801045:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80104c:	eb 34                	jmp    801082 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80104e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	01 d0                	add    %edx,%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80105b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80105e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801061:	01 c2                	add    %eax,%edx
  801063:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801066:	8b 45 0c             	mov    0xc(%ebp),%eax
  801069:	01 c8                	add    %ecx,%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80106f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801072:	8b 45 0c             	mov    0xc(%ebp),%eax
  801075:	01 c2                	add    %eax,%edx
  801077:	8a 45 eb             	mov    -0x15(%ebp),%al
  80107a:	88 02                	mov    %al,(%edx)
		start++ ;
  80107c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80107f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801082:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801085:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801088:	7c c4                	jl     80104e <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80108a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	01 d0                	add    %edx,%eax
  801092:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801095:	90                   	nop
  801096:	c9                   	leave  
  801097:	c3                   	ret    

00801098 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
  80109b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80109e:	ff 75 08             	pushl  0x8(%ebp)
  8010a1:	e8 c4 f9 ff ff       	call   800a6a <strlen>
  8010a6:	83 c4 04             	add    $0x4,%esp
  8010a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010ac:	ff 75 0c             	pushl  0xc(%ebp)
  8010af:	e8 b6 f9 ff ff       	call   800a6a <strlen>
  8010b4:	83 c4 04             	add    $0x4,%esp
  8010b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c8:	eb 17                	jmp    8010e1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d0:	01 c2                	add    %eax,%edx
  8010d2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	01 c8                	add    %ecx,%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010de:	ff 45 fc             	incl   -0x4(%ebp)
  8010e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010e7:	7c e1                	jl     8010ca <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010f7:	eb 1f                	jmp    801118 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fc:	8d 50 01             	lea    0x1(%eax),%edx
  8010ff:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801102:	89 c2                	mov    %eax,%edx
  801104:	8b 45 10             	mov    0x10(%ebp),%eax
  801107:	01 c2                	add    %eax,%edx
  801109:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80110c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110f:	01 c8                	add    %ecx,%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801115:	ff 45 f8             	incl   -0x8(%ebp)
  801118:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80111e:	7c d9                	jl     8010f9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801120:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801123:	8b 45 10             	mov    0x10(%ebp),%eax
  801126:	01 d0                	add    %edx,%eax
  801128:	c6 00 00             	movb   $0x0,(%eax)
}
  80112b:	90                   	nop
  80112c:	c9                   	leave  
  80112d:	c3                   	ret    

0080112e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80112e:	55                   	push   %ebp
  80112f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801131:	8b 45 14             	mov    0x14(%ebp),%eax
  801134:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80113a:	8b 45 14             	mov    0x14(%ebp),%eax
  80113d:	8b 00                	mov    (%eax),%eax
  80113f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801146:	8b 45 10             	mov    0x10(%ebp),%eax
  801149:	01 d0                	add    %edx,%eax
  80114b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801151:	eb 0c                	jmp    80115f <strsplit+0x31>
			*string++ = 0;
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8d 50 01             	lea    0x1(%eax),%edx
  801159:	89 55 08             	mov    %edx,0x8(%ebp)
  80115c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	84 c0                	test   %al,%al
  801166:	74 18                	je     801180 <strsplit+0x52>
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	0f be c0             	movsbl %al,%eax
  801170:	50                   	push   %eax
  801171:	ff 75 0c             	pushl  0xc(%ebp)
  801174:	e8 83 fa ff ff       	call   800bfc <strchr>
  801179:	83 c4 08             	add    $0x8,%esp
  80117c:	85 c0                	test   %eax,%eax
  80117e:	75 d3                	jne    801153 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	8a 00                	mov    (%eax),%al
  801185:	84 c0                	test   %al,%al
  801187:	74 5a                	je     8011e3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801189:	8b 45 14             	mov    0x14(%ebp),%eax
  80118c:	8b 00                	mov    (%eax),%eax
  80118e:	83 f8 0f             	cmp    $0xf,%eax
  801191:	75 07                	jne    80119a <strsplit+0x6c>
		{
			return 0;
  801193:	b8 00 00 00 00       	mov    $0x0,%eax
  801198:	eb 66                	jmp    801200 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80119a:	8b 45 14             	mov    0x14(%ebp),%eax
  80119d:	8b 00                	mov    (%eax),%eax
  80119f:	8d 48 01             	lea    0x1(%eax),%ecx
  8011a2:	8b 55 14             	mov    0x14(%ebp),%edx
  8011a5:	89 0a                	mov    %ecx,(%edx)
  8011a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b1:	01 c2                	add    %eax,%edx
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011b8:	eb 03                	jmp    8011bd <strsplit+0x8f>
			string++;
  8011ba:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	84 c0                	test   %al,%al
  8011c4:	74 8b                	je     801151 <strsplit+0x23>
  8011c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	0f be c0             	movsbl %al,%eax
  8011ce:	50                   	push   %eax
  8011cf:	ff 75 0c             	pushl  0xc(%ebp)
  8011d2:	e8 25 fa ff ff       	call   800bfc <strchr>
  8011d7:	83 c4 08             	add    $0x8,%esp
  8011da:	85 c0                	test   %eax,%eax
  8011dc:	74 dc                	je     8011ba <strsplit+0x8c>
			string++;
	}
  8011de:	e9 6e ff ff ff       	jmp    801151 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011e3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e7:	8b 00                	mov    (%eax),%eax
  8011e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f3:	01 d0                	add    %edx,%eax
  8011f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801200:	c9                   	leave  
  801201:	c3                   	ret    

00801202 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801202:	55                   	push   %ebp
  801203:	89 e5                	mov    %esp,%ebp
  801205:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80120e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801215:	eb 4a                	jmp    801261 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801217:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	01 c2                	add    %eax,%edx
  80121f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801222:	8b 45 0c             	mov    0xc(%ebp),%eax
  801225:	01 c8                	add    %ecx,%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80122b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80122e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801231:	01 d0                	add    %edx,%eax
  801233:	8a 00                	mov    (%eax),%al
  801235:	3c 40                	cmp    $0x40,%al
  801237:	7e 25                	jle    80125e <str2lower+0x5c>
  801239:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	01 d0                	add    %edx,%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	3c 5a                	cmp    $0x5a,%al
  801245:	7f 17                	jg     80125e <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801247:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	01 d0                	add    %edx,%eax
  80124f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801252:	8b 55 08             	mov    0x8(%ebp),%edx
  801255:	01 ca                	add    %ecx,%edx
  801257:	8a 12                	mov    (%edx),%dl
  801259:	83 c2 20             	add    $0x20,%edx
  80125c:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80125e:	ff 45 fc             	incl   -0x4(%ebp)
  801261:	ff 75 0c             	pushl  0xc(%ebp)
  801264:	e8 01 f8 ff ff       	call   800a6a <strlen>
  801269:	83 c4 04             	add    $0x4,%esp
  80126c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80126f:	7f a6                	jg     801217 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801271:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801274:	c9                   	leave  
  801275:	c3                   	ret    

00801276 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
  801279:	57                   	push   %edi
  80127a:	56                   	push   %esi
  80127b:	53                   	push   %ebx
  80127c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	8b 55 0c             	mov    0xc(%ebp),%edx
  801285:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801288:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80128b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80128e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801291:	cd 30                	int    $0x30
  801293:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801296:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801299:	83 c4 10             	add    $0x10,%esp
  80129c:	5b                   	pop    %ebx
  80129d:	5e                   	pop    %esi
  80129e:	5f                   	pop    %edi
  80129f:	5d                   	pop    %ebp
  8012a0:	c3                   	ret    

008012a1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012a1:	55                   	push   %ebp
  8012a2:	89 e5                	mov    %esp,%ebp
  8012a4:	83 ec 04             	sub    $0x4,%esp
  8012a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012aa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8012ad:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012b0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	6a 00                	push   $0x0
  8012b9:	51                   	push   %ecx
  8012ba:	52                   	push   %edx
  8012bb:	ff 75 0c             	pushl  0xc(%ebp)
  8012be:	50                   	push   %eax
  8012bf:	6a 00                	push   $0x0
  8012c1:	e8 b0 ff ff ff       	call   801276 <syscall>
  8012c6:	83 c4 18             	add    $0x18,%esp
}
  8012c9:	90                   	nop
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <sys_cgetc>:

int
sys_cgetc(void)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 02                	push   $0x2
  8012db:	e8 96 ff ff ff       	call   801276 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 03                	push   $0x3
  8012f4:	e8 7d ff ff ff       	call   801276 <syscall>
  8012f9:	83 c4 18             	add    $0x18,%esp
}
  8012fc:	90                   	nop
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 04                	push   $0x4
  80130e:	e8 63 ff ff ff       	call   801276 <syscall>
  801313:	83 c4 18             	add    $0x18,%esp
}
  801316:	90                   	nop
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80131c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	52                   	push   %edx
  801329:	50                   	push   %eax
  80132a:	6a 08                	push   $0x8
  80132c:	e8 45 ff ff ff       	call   801276 <syscall>
  801331:	83 c4 18             	add    $0x18,%esp
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	56                   	push   %esi
  80133a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80133b:	8b 75 18             	mov    0x18(%ebp),%esi
  80133e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801341:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801344:	8b 55 0c             	mov    0xc(%ebp),%edx
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	56                   	push   %esi
  80134b:	53                   	push   %ebx
  80134c:	51                   	push   %ecx
  80134d:	52                   	push   %edx
  80134e:	50                   	push   %eax
  80134f:	6a 09                	push   $0x9
  801351:	e8 20 ff ff ff       	call   801276 <syscall>
  801356:	83 c4 18             	add    $0x18,%esp
}
  801359:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80135c:	5b                   	pop    %ebx
  80135d:	5e                   	pop    %esi
  80135e:	5d                   	pop    %ebp
  80135f:	c3                   	ret    

00801360 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	ff 75 08             	pushl  0x8(%ebp)
  80136e:	6a 0a                	push   $0xa
  801370:	e8 01 ff ff ff       	call   801276 <syscall>
  801375:	83 c4 18             	add    $0x18,%esp
}
  801378:	c9                   	leave  
  801379:	c3                   	ret    

0080137a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80137a:	55                   	push   %ebp
  80137b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	ff 75 0c             	pushl  0xc(%ebp)
  801386:	ff 75 08             	pushl  0x8(%ebp)
  801389:	6a 0b                	push   $0xb
  80138b:	e8 e6 fe ff ff       	call   801276 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 0c                	push   $0xc
  8013a4:	e8 cd fe ff ff       	call   801276 <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 0d                	push   $0xd
  8013bd:	e8 b4 fe ff ff       	call   801276 <syscall>
  8013c2:	83 c4 18             	add    $0x18,%esp
}
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 0e                	push   $0xe
  8013d6:	e8 9b fe ff ff       	call   801276 <syscall>
  8013db:	83 c4 18             	add    $0x18,%esp
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 0f                	push   $0xf
  8013ef:	e8 82 fe ff ff       	call   801276 <syscall>
  8013f4:	83 c4 18             	add    $0x18,%esp
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	ff 75 08             	pushl  0x8(%ebp)
  801407:	6a 10                	push   $0x10
  801409:	e8 68 fe ff ff       	call   801276 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 11                	push   $0x11
  801422:	e8 4f fe ff ff       	call   801276 <syscall>
  801427:	83 c4 18             	add    $0x18,%esp
}
  80142a:	90                   	nop
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <sys_cputc>:

void
sys_cputc(const char c)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 04             	sub    $0x4,%esp
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801439:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	50                   	push   %eax
  801446:	6a 01                	push   $0x1
  801448:	e8 29 fe ff ff       	call   801276 <syscall>
  80144d:	83 c4 18             	add    $0x18,%esp
}
  801450:	90                   	nop
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 14                	push   $0x14
  801462:	e8 0f fe ff ff       	call   801276 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	90                   	nop
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 04             	sub    $0x4,%esp
  801473:	8b 45 10             	mov    0x10(%ebp),%eax
  801476:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801479:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80147c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	6a 00                	push   $0x0
  801485:	51                   	push   %ecx
  801486:	52                   	push   %edx
  801487:	ff 75 0c             	pushl  0xc(%ebp)
  80148a:	50                   	push   %eax
  80148b:	6a 15                	push   $0x15
  80148d:	e8 e4 fd ff ff       	call   801276 <syscall>
  801492:	83 c4 18             	add    $0x18,%esp
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80149a:	8b 55 10             	mov    0x10(%ebp),%edx
  80149d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	52                   	push   %edx
  8014a5:	50                   	push   %eax
  8014a6:	ff 75 08             	pushl  0x8(%ebp)
  8014a9:	6a 16                	push   $0x16
  8014ab:	e8 c6 fd ff ff       	call   801276 <syscall>
  8014b0:	83 c4 18             	add    $0x18,%esp
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	52                   	push   %edx
  8014c5:	50                   	push   %eax
  8014c6:	6a 17                	push   $0x17
  8014c8:	e8 a9 fd ff ff       	call   801276 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	52                   	push   %edx
  8014e2:	50                   	push   %eax
  8014e3:	6a 18                	push   $0x18
  8014e5:	e8 8c fd ff ff       	call   801276 <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	6a 00                	push   $0x0
  8014f7:	ff 75 14             	pushl  0x14(%ebp)
  8014fa:	ff 75 10             	pushl  0x10(%ebp)
  8014fd:	ff 75 0c             	pushl  0xc(%ebp)
  801500:	50                   	push   %eax
  801501:	6a 19                	push   $0x19
  801503:	e8 6e fd ff ff       	call   801276 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <sys_run_env>:

void sys_run_env(int32 envId)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	50                   	push   %eax
  80151c:	6a 1a                	push   $0x1a
  80151e:	e8 53 fd ff ff       	call   801276 <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
}
  801526:	90                   	nop
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	50                   	push   %eax
  801538:	6a 1b                	push   $0x1b
  80153a:	e8 37 fd ff ff       	call   801276 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 05                	push   $0x5
  801553:	e8 1e fd ff ff       	call   801276 <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 06                	push   $0x6
  80156c:	e8 05 fd ff ff       	call   801276 <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 07                	push   $0x7
  801585:	e8 ec fc ff ff       	call   801276 <syscall>
  80158a:	83 c4 18             	add    $0x18,%esp
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_exit_env>:


void sys_exit_env(void)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 1c                	push   $0x1c
  80159e:	e8 d3 fc ff ff       	call   801276 <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	90                   	nop
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	ff 75 10             	pushl  0x10(%ebp)
  8015b3:	ff 75 0c             	pushl  0xc(%ebp)
  8015b6:	ff 75 08             	pushl  0x8(%ebp)
  8015b9:	6a 13                	push   $0x13
  8015bb:	e8 b6 fc ff ff       	call   801276 <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c3:	90                   	nop
}
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 1e                	push   $0x1e
  8015d5:	e8 9c fc ff ff       	call   801276 <syscall>
  8015da:	83 c4 18             	add    $0x18,%esp
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
  8015e2:	83 ec 04             	sub    $0x4,%esp
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015eb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	50                   	push   %eax
  8015f8:	6a 1f                	push   $0x1f
  8015fa:	e8 77 fc ff ff       	call   801276 <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801602:	90                   	nop
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <rsttst>:
void rsttst()
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 21                	push   $0x21
  801614:	e8 5d fc ff ff       	call   801276 <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
	return ;
  80161c:	90                   	nop
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
  801622:	83 ec 04             	sub    $0x4,%esp
  801625:	8b 45 14             	mov    0x14(%ebp),%eax
  801628:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80162b:	8b 55 18             	mov    0x18(%ebp),%edx
  80162e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801632:	52                   	push   %edx
  801633:	50                   	push   %eax
  801634:	ff 75 10             	pushl  0x10(%ebp)
  801637:	ff 75 0c             	pushl  0xc(%ebp)
  80163a:	ff 75 08             	pushl  0x8(%ebp)
  80163d:	6a 20                	push   $0x20
  80163f:	e8 32 fc ff ff       	call   801276 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
	return ;
  801647:	90                   	nop
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <chktst>:
void chktst(uint32 n)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	ff 75 08             	pushl  0x8(%ebp)
  801658:	6a 22                	push   $0x22
  80165a:	e8 17 fc ff ff       	call   801276 <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
	return ;
  801662:	90                   	nop
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <inctst>:

void inctst()
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 23                	push   $0x23
  801674:	e8 fd fb ff ff       	call   801276 <syscall>
  801679:	83 c4 18             	add    $0x18,%esp
	return ;
  80167c:	90                   	nop
}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <gettst>:
uint32 gettst()
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 24                	push   $0x24
  80168e:	e8 e3 fb ff ff       	call   801276 <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
}
  801696:	c9                   	leave  
  801697:	c3                   	ret    

00801698 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801698:	55                   	push   %ebp
  801699:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 25                	push   $0x25
  8016a7:	e8 ca fb ff ff       	call   801276 <syscall>
  8016ac:	83 c4 18             	add    $0x18,%esp
  8016af:	a3 c8 68 81 00       	mov    %eax,0x8168c8
	return uheapPlaceStrategy ;
  8016b4:	a1 c8 68 81 00       	mov    0x8168c8,%eax
}
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	a3 c8 68 81 00       	mov    %eax,0x8168c8
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	ff 75 08             	pushl  0x8(%ebp)
  8016d1:	6a 26                	push   $0x26
  8016d3:	e8 9e fb ff ff       	call   801276 <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016db:	90                   	nop
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	6a 00                	push   $0x0
  8016f0:	53                   	push   %ebx
  8016f1:	51                   	push   %ecx
  8016f2:	52                   	push   %edx
  8016f3:	50                   	push   %eax
  8016f4:	6a 27                	push   $0x27
  8016f6:	e8 7b fb ff ff       	call   801276 <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
}
  8016fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801706:	8b 55 0c             	mov    0xc(%ebp),%edx
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	52                   	push   %edx
  801713:	50                   	push   %eax
  801714:	6a 28                	push   $0x28
  801716:	e8 5b fb ff ff       	call   801276 <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
}
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801723:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801726:	8b 55 0c             	mov    0xc(%ebp),%edx
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	6a 00                	push   $0x0
  80172e:	51                   	push   %ecx
  80172f:	ff 75 10             	pushl  0x10(%ebp)
  801732:	52                   	push   %edx
  801733:	50                   	push   %eax
  801734:	6a 29                	push   $0x29
  801736:	e8 3b fb ff ff       	call   801276 <syscall>
  80173b:	83 c4 18             	add    $0x18,%esp
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	ff 75 10             	pushl  0x10(%ebp)
  80174a:	ff 75 0c             	pushl  0xc(%ebp)
  80174d:	ff 75 08             	pushl  0x8(%ebp)
  801750:	6a 12                	push   $0x12
  801752:	e8 1f fb ff ff       	call   801276 <syscall>
  801757:	83 c4 18             	add    $0x18,%esp
	return ;
  80175a:	90                   	nop
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801760:	8b 55 0c             	mov    0xc(%ebp),%edx
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	52                   	push   %edx
  80176d:	50                   	push   %eax
  80176e:	6a 2a                	push   $0x2a
  801770:	e8 01 fb ff ff       	call   801276 <syscall>
  801775:	83 c4 18             	add    $0x18,%esp
	return;
  801778:	90                   	nop
}
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 2b                	push   $0x2b
  80178a:	e8 e7 fa ff ff       	call   801276 <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
  801797:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80179a:	83 ec 04             	sub    $0x4,%esp
  80179d:	68 28 22 80 00       	push   $0x802228
  8017a2:	68 0a 01 00 00       	push   $0x10a
  8017a7:	68 38 22 80 00       	push   $0x802238
  8017ac:	e8 38 00 00 00       	call   8017e9 <_panic>

008017b1 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	ff 75 0c             	pushl  0xc(%ebp)
  8017bd:	ff 75 08             	pushl  0x8(%ebp)
  8017c0:	6a 33                	push   $0x33
  8017c2:	e8 af fa ff ff       	call   801276 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
	return;
  8017ca:	90                   	nop
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	ff 75 0c             	pushl  0xc(%ebp)
  8017d9:	ff 75 08             	pushl  0x8(%ebp)
  8017dc:	6a 34                	push   $0x34
  8017de:	e8 93 fa ff ff       	call   801276 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e6:	90                   	nop
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
  8017ec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8017ef:	8d 45 10             	lea    0x10(%ebp),%eax
  8017f2:	83 c0 04             	add    $0x4,%eax
  8017f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8017f8:	a1 ac 69 81 00       	mov    0x8169ac,%eax
  8017fd:	85 c0                	test   %eax,%eax
  8017ff:	74 16                	je     801817 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801801:	a1 ac 69 81 00       	mov    0x8169ac,%eax
  801806:	83 ec 08             	sub    $0x8,%esp
  801809:	50                   	push   %eax
  80180a:	68 48 22 80 00       	push   $0x802248
  80180f:	e8 7d eb ff ff       	call   800391 <cprintf>
  801814:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801817:	a1 04 30 80 00       	mov    0x803004,%eax
  80181c:	83 ec 0c             	sub    $0xc,%esp
  80181f:	ff 75 0c             	pushl  0xc(%ebp)
  801822:	ff 75 08             	pushl  0x8(%ebp)
  801825:	50                   	push   %eax
  801826:	68 50 22 80 00       	push   $0x802250
  80182b:	6a 74                	push   $0x74
  80182d:	e8 8c eb ff ff       	call   8003be <cprintf_colored>
  801832:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801835:	8b 45 10             	mov    0x10(%ebp),%eax
  801838:	83 ec 08             	sub    $0x8,%esp
  80183b:	ff 75 f4             	pushl  -0xc(%ebp)
  80183e:	50                   	push   %eax
  80183f:	e8 de ea ff ff       	call   800322 <vcprintf>
  801844:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801847:	83 ec 08             	sub    $0x8,%esp
  80184a:	6a 00                	push   $0x0
  80184c:	68 78 22 80 00       	push   $0x802278
  801851:	e8 cc ea ff ff       	call   800322 <vcprintf>
  801856:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801859:	e8 45 ea ff ff       	call   8002a3 <exit>

	// should not return here
	while (1) ;
  80185e:	eb fe                	jmp    80185e <_panic+0x75>

00801860 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
  801863:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801866:	a1 20 30 80 00       	mov    0x803020,%eax
  80186b:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801871:	8b 45 0c             	mov    0xc(%ebp),%eax
  801874:	39 c2                	cmp    %eax,%edx
  801876:	74 14                	je     80188c <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801878:	83 ec 04             	sub    $0x4,%esp
  80187b:	68 7c 22 80 00       	push   $0x80227c
  801880:	6a 26                	push   $0x26
  801882:	68 c8 22 80 00       	push   $0x8022c8
  801887:	e8 5d ff ff ff       	call   8017e9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80188c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801893:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80189a:	e9 c5 00 00 00       	jmp    801964 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80189f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	01 d0                	add    %edx,%eax
  8018ae:	8b 00                	mov    (%eax),%eax
  8018b0:	85 c0                	test   %eax,%eax
  8018b2:	75 08                	jne    8018bc <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8018b4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018b7:	e9 a5 00 00 00       	jmp    801961 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8018bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018ca:	eb 69                	jmp    801935 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8018d1:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018d7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018da:	89 d0                	mov    %edx,%eax
  8018dc:	01 c0                	add    %eax,%eax
  8018de:	01 d0                	add    %edx,%eax
  8018e0:	c1 e0 03             	shl    $0x3,%eax
  8018e3:	01 c8                	add    %ecx,%eax
  8018e5:	8a 40 04             	mov    0x4(%eax),%al
  8018e8:	84 c0                	test   %al,%al
  8018ea:	75 46                	jne    801932 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8018f1:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018f7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018fa:	89 d0                	mov    %edx,%eax
  8018fc:	01 c0                	add    %eax,%eax
  8018fe:	01 d0                	add    %edx,%eax
  801900:	c1 e0 03             	shl    $0x3,%eax
  801903:	01 c8                	add    %ecx,%eax
  801905:	8b 00                	mov    (%eax),%eax
  801907:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80190a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80190d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801912:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801914:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801917:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	01 c8                	add    %ecx,%eax
  801923:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801925:	39 c2                	cmp    %eax,%edx
  801927:	75 09                	jne    801932 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801929:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801930:	eb 15                	jmp    801947 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801932:	ff 45 e8             	incl   -0x18(%ebp)
  801935:	a1 20 30 80 00       	mov    0x803020,%eax
  80193a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801940:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801943:	39 c2                	cmp    %eax,%edx
  801945:	77 85                	ja     8018cc <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801947:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80194b:	75 14                	jne    801961 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80194d:	83 ec 04             	sub    $0x4,%esp
  801950:	68 d4 22 80 00       	push   $0x8022d4
  801955:	6a 3a                	push   $0x3a
  801957:	68 c8 22 80 00       	push   $0x8022c8
  80195c:	e8 88 fe ff ff       	call   8017e9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801961:	ff 45 f0             	incl   -0x10(%ebp)
  801964:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801967:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80196a:	0f 8c 2f ff ff ff    	jl     80189f <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801970:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801977:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80197e:	eb 26                	jmp    8019a6 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801980:	a1 20 30 80 00       	mov    0x803020,%eax
  801985:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80198b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80198e:	89 d0                	mov    %edx,%eax
  801990:	01 c0                	add    %eax,%eax
  801992:	01 d0                	add    %edx,%eax
  801994:	c1 e0 03             	shl    $0x3,%eax
  801997:	01 c8                	add    %ecx,%eax
  801999:	8a 40 04             	mov    0x4(%eax),%al
  80199c:	3c 01                	cmp    $0x1,%al
  80199e:	75 03                	jne    8019a3 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019a0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019a3:	ff 45 e0             	incl   -0x20(%ebp)
  8019a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8019ab:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019b4:	39 c2                	cmp    %eax,%edx
  8019b6:	77 c8                	ja     801980 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019bb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019be:	74 14                	je     8019d4 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8019c0:	83 ec 04             	sub    $0x4,%esp
  8019c3:	68 28 23 80 00       	push   $0x802328
  8019c8:	6a 44                	push   $0x44
  8019ca:	68 c8 22 80 00       	push   $0x8022c8
  8019cf:	e8 15 fe ff ff       	call   8017e9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019d4:	90                   	nop
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    
  8019d7:	90                   	nop

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
