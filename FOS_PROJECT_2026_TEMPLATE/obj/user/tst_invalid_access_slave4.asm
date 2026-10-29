
obj/user/tst_invalid_access_slave4:     file format elf32-i386


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
  800031:	e8 5c 00 00 00       	call   800092 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//[4] Not in Page File, Not Stack & Not Heap
	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

		unsigned char *x = (unsigned char *)(0x00200000-PAGE_SIZE);
  80004e:	c7 45 e8 00 f0 1f 00 	movl   $0x1ff000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)
		uint32 size = 4*kilo;

		unsigned char *x = (unsigned char *)(0x00200000-PAGE_SIZE);

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}
	}

	inctst();
  800079:	e8 16 18 00 00       	call   801894 <inctst>
	panic("tst invalid access failed: Attempt to access page that's not exist in page file, neither stack or heap.\nThe env must be killed and shouldn't return here.");
  80007e:	83 ec 04             	sub    $0x4,%esp
  800081:	68 80 1c 80 00       	push   $0x801c80
  800086:	6a 18                	push   $0x18
  800088:	68 1c 1d 80 00       	push   $0x801d1c
  80008d:	e8 60 02 00 00       	call   8002f2 <_panic>

00800092 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800092:	55                   	push   %ebp
  800093:	89 e5                	mov    %esp,%ebp
  800095:	57                   	push   %edi
  800096:	56                   	push   %esi
  800097:	53                   	push   %ebx
  800098:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  80009e:	e8 e9 16 00 00       	call   80178c <sys_getenvindex>
  8000a3:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000a6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000a9:	89 d0                	mov    %edx,%eax
  8000ab:	c1 e0 03             	shl    $0x3,%eax
  8000ae:	01 d0                	add    %edx,%eax
  8000b0:	c1 e0 06             	shl    $0x6,%eax
  8000b3:	01 d0                	add    %edx,%eax
  8000b5:	c1 e0 03             	shl    $0x3,%eax
  8000b8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000bd:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c7:	8a 40 10             	mov    0x10(%eax),%al
  8000ca:	84 c0                	test   %al,%al
  8000cc:	74 0d                	je     8000db <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d3:	83 c0 10             	add    $0x10,%eax
  8000d6:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000df:	7e 0a                	jle    8000eb <libmain+0x59>
		binaryname = argv[0];
  8000e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000e4:	8b 00                	mov    (%eax),%eax
  8000e6:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000eb:	83 ec 08             	sub    $0x8,%esp
  8000ee:	ff 75 0c             	pushl  0xc(%ebp)
  8000f1:	ff 75 08             	pushl  0x8(%ebp)
  8000f4:	e8 3f ff ff ff       	call   800038 <_main>
  8000f9:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000fc:	a1 00 30 80 00       	mov    0x803000,%eax
  800101:	85 c0                	test   %eax,%eax
  800103:	0f 84 b7 01 00 00    	je     8002c0 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800109:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80010f:	bb 7c 1e 80 00       	mov    $0x801e7c,%ebx
  800114:	ba 0e 00 00 00       	mov    $0xe,%edx
  800119:	89 c7                	mov    %eax,%edi
  80011b:	89 de                	mov    %ebx,%esi
  80011d:	89 d1                	mov    %edx,%ecx
  80011f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800121:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800127:	b9 56 00 00 00       	mov    $0x56,%ecx
  80012c:	b0 00                	mov    $0x0,%al
  80012e:	89 d7                	mov    %edx,%edi
  800130:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800132:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800139:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80013c:	83 ec 08             	sub    $0x8,%esp
  80013f:	50                   	push   %eax
  800140:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800146:	50                   	push   %eax
  800147:	e8 40 18 00 00       	call   80198c <sys_utilities>
  80014c:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80014f:	e8 c0 13 00 00       	call   801514 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800154:	83 ec 0c             	sub    $0xc,%esp
  800157:	68 58 1d 80 00       	push   $0x801d58
  80015c:	e8 5f 04 00 00       	call   8005c0 <cprintf>
  800161:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800164:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800167:	85 c0                	test   %eax,%eax
  800169:	74 58                	je     8001c3 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80016b:	e8 3a 18 00 00       	call   8019aa <sys_get_optimal_num_faults>
  800170:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800173:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800179:	bb e0 1e 80 00       	mov    $0x801ee0,%ebx
  80017e:	ba 11 00 00 00       	mov    $0x11,%edx
  800183:	89 c7                	mov    %eax,%edi
  800185:	89 de                	mov    %ebx,%esi
  800187:	89 d1                	mov    %edx,%ecx
  800189:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80018b:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80018e:	b9 53 00 00 00       	mov    $0x53,%ecx
  800193:	b0 00                	mov    $0x0,%al
  800195:	89 d7                	mov    %edx,%edi
  800197:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800199:	83 ec 08             	sub    $0x8,%esp
  80019c:	ff 75 dc             	pushl  -0x24(%ebp)
  80019f:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001a5:	50                   	push   %eax
  8001a6:	e8 e1 17 00 00       	call   80198c <sys_utilities>
  8001ab:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001ae:	83 ec 08             	sub    $0x8,%esp
  8001b1:	ff 75 dc             	pushl  -0x24(%ebp)
  8001b4:	68 80 1d 80 00       	push   $0x801d80
  8001b9:	e8 02 04 00 00       	call   8005c0 <cprintf>
  8001be:	83 c4 10             	add    $0x10,%esp
  8001c1:	eb 59                	jmp    80021c <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d3:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001d9:	83 ec 04             	sub    $0x4,%esp
  8001dc:	52                   	push   %edx
  8001dd:	50                   	push   %eax
  8001de:	68 a4 1d 80 00       	push   $0x801da4
  8001e3:	e8 d8 03 00 00       	call   8005c0 <cprintf>
  8001e8:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fb:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80020c:	51                   	push   %ecx
  80020d:	52                   	push   %edx
  80020e:	50                   	push   %eax
  80020f:	68 cc 1d 80 00       	push   $0x801dcc
  800214:	e8 a7 03 00 00       	call   8005c0 <cprintf>
  800219:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80021c:	a1 20 30 80 00       	mov    0x803020,%eax
  800221:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	50                   	push   %eax
  80022b:	68 24 1e 80 00       	push   $0x801e24
  800230:	e8 8b 03 00 00       	call   8005c0 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800238:	83 ec 0c             	sub    $0xc,%esp
  80023b:	68 38 1e 80 00       	push   $0x801e38
  800240:	e8 7b 03 00 00       	call   8005c0 <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800248:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80024f:	eb 28                	jmp    800279 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800251:	a1 20 30 80 00       	mov    0x803020,%eax
  800256:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800259:	81 c2 74 04 00 00    	add    $0x474,%edx
  80025f:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	50                   	push   %eax
  800266:	ff 75 e4             	pushl  -0x1c(%ebp)
  800269:	68 4f 1e 80 00       	push   $0x801e4f
  80026e:	e8 4d 03 00 00       	call   8005c0 <cprintf>
  800273:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800276:	ff 45 e4             	incl   -0x1c(%ebp)
  800279:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80027d:	7e d2                	jle    800251 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80027f:	83 ec 0c             	sub    $0xc,%esp
  800282:	68 5e 1e 80 00       	push   $0x801e5e
  800287:	e8 34 03 00 00       	call   8005c0 <cprintf>
  80028c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80028f:	a1 20 30 80 00       	mov    0x803020,%eax
  800294:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80029a:	83 ec 08             	sub    $0x8,%esp
  80029d:	50                   	push   %eax
  80029e:	68 62 1e 80 00       	push   $0x801e62
  8002a3:	e8 18 03 00 00       	call   8005c0 <cprintf>
  8002a8:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002ab:	83 ec 0c             	sub    $0xc,%esp
  8002ae:	68 58 1d 80 00       	push   $0x801d58
  8002b3:	e8 08 03 00 00       	call   8005c0 <cprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002bb:	e8 6e 12 00 00       	call   80152e <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002c0:	e8 1f 00 00 00       	call   8002e4 <exit>
}
  8002c5:	90                   	nop
  8002c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002c9:	5b                   	pop    %ebx
  8002ca:	5e                   	pop    %esi
  8002cb:	5f                   	pop    %edi
  8002cc:	5d                   	pop    %ebp
  8002cd:	c3                   	ret    

008002ce <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002ce:	55                   	push   %ebp
  8002cf:	89 e5                	mov    %esp,%ebp
  8002d1:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	6a 00                	push   $0x0
  8002d9:	e8 7a 14 00 00       	call   801758 <sys_destroy_env>
  8002de:	83 c4 10             	add    $0x10,%esp
}
  8002e1:	90                   	nop
  8002e2:	c9                   	leave  
  8002e3:	c3                   	ret    

008002e4 <exit>:

void
exit(void)
{
  8002e4:	55                   	push   %ebp
  8002e5:	89 e5                	mov    %esp,%ebp
  8002e7:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002ea:	e8 cf 14 00 00       	call   8017be <sys_exit_env>
}
  8002ef:	90                   	nop
  8002f0:	c9                   	leave  
  8002f1:	c3                   	ret    

008002f2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002f2:	55                   	push   %ebp
  8002f3:	89 e5                	mov    %esp,%ebp
  8002f5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002f8:	8d 45 10             	lea    0x10(%ebp),%eax
  8002fb:	83 c0 04             	add    $0x4,%eax
  8002fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800301:	a1 28 31 80 00       	mov    0x803128,%eax
  800306:	85 c0                	test   %eax,%eax
  800308:	74 16                	je     800320 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80030a:	a1 28 31 80 00       	mov    0x803128,%eax
  80030f:	83 ec 08             	sub    $0x8,%esp
  800312:	50                   	push   %eax
  800313:	68 44 1f 80 00       	push   $0x801f44
  800318:	e8 a3 02 00 00       	call   8005c0 <cprintf>
  80031d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800320:	a1 04 30 80 00       	mov    0x803004,%eax
  800325:	83 ec 0c             	sub    $0xc,%esp
  800328:	ff 75 0c             	pushl  0xc(%ebp)
  80032b:	ff 75 08             	pushl  0x8(%ebp)
  80032e:	50                   	push   %eax
  80032f:	68 4c 1f 80 00       	push   $0x801f4c
  800334:	6a 74                	push   $0x74
  800336:	e8 b2 02 00 00       	call   8005ed <cprintf_colored>
  80033b:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80033e:	8b 45 10             	mov    0x10(%ebp),%eax
  800341:	83 ec 08             	sub    $0x8,%esp
  800344:	ff 75 f4             	pushl  -0xc(%ebp)
  800347:	50                   	push   %eax
  800348:	e8 04 02 00 00       	call   800551 <vcprintf>
  80034d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800350:	83 ec 08             	sub    $0x8,%esp
  800353:	6a 00                	push   $0x0
  800355:	68 74 1f 80 00       	push   $0x801f74
  80035a:	e8 f2 01 00 00       	call   800551 <vcprintf>
  80035f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800362:	e8 7d ff ff ff       	call   8002e4 <exit>

	// should not return here
	while (1) ;
  800367:	eb fe                	jmp    800367 <_panic+0x75>

00800369 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800369:	55                   	push   %ebp
  80036a:	89 e5                	mov    %esp,%ebp
  80036c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80036f:	a1 20 30 80 00       	mov    0x803020,%eax
  800374:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80037a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037d:	39 c2                	cmp    %eax,%edx
  80037f:	74 14                	je     800395 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800381:	83 ec 04             	sub    $0x4,%esp
  800384:	68 78 1f 80 00       	push   $0x801f78
  800389:	6a 26                	push   $0x26
  80038b:	68 c4 1f 80 00       	push   $0x801fc4
  800390:	e8 5d ff ff ff       	call   8002f2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800395:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80039c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003a3:	e9 c5 00 00 00       	jmp    80046d <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8003a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 d0                	add    %edx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	85 c0                	test   %eax,%eax
  8003bb:	75 08                	jne    8003c5 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8003bd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003c0:	e9 a5 00 00 00       	jmp    80046a <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8003c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003d3:	eb 69                	jmp    80043e <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003da:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003e3:	89 d0                	mov    %edx,%eax
  8003e5:	01 c0                	add    %eax,%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	c1 e0 03             	shl    $0x3,%eax
  8003ec:	01 c8                	add    %ecx,%eax
  8003ee:	8a 40 04             	mov    0x4(%eax),%al
  8003f1:	84 c0                	test   %al,%al
  8003f3:	75 46                	jne    80043b <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fa:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800400:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800403:	89 d0                	mov    %edx,%eax
  800405:	01 c0                	add    %eax,%eax
  800407:	01 d0                	add    %edx,%eax
  800409:	c1 e0 03             	shl    $0x3,%eax
  80040c:	01 c8                	add    %ecx,%eax
  80040e:	8b 00                	mov    (%eax),%eax
  800410:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800413:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800416:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80041b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80041d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800420:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	01 c8                	add    %ecx,%eax
  80042c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80042e:	39 c2                	cmp    %eax,%edx
  800430:	75 09                	jne    80043b <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800432:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800439:	eb 15                	jmp    800450 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80043b:	ff 45 e8             	incl   -0x18(%ebp)
  80043e:	a1 20 30 80 00       	mov    0x803020,%eax
  800443:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800449:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80044c:	39 c2                	cmp    %eax,%edx
  80044e:	77 85                	ja     8003d5 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800450:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800454:	75 14                	jne    80046a <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800456:	83 ec 04             	sub    $0x4,%esp
  800459:	68 d0 1f 80 00       	push   $0x801fd0
  80045e:	6a 3a                	push   $0x3a
  800460:	68 c4 1f 80 00       	push   $0x801fc4
  800465:	e8 88 fe ff ff       	call   8002f2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80046a:	ff 45 f0             	incl   -0x10(%ebp)
  80046d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800470:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800473:	0f 8c 2f ff ff ff    	jl     8003a8 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800479:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800480:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800487:	eb 26                	jmp    8004af <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800489:	a1 20 30 80 00       	mov    0x803020,%eax
  80048e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800494:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800497:	89 d0                	mov    %edx,%eax
  800499:	01 c0                	add    %eax,%eax
  80049b:	01 d0                	add    %edx,%eax
  80049d:	c1 e0 03             	shl    $0x3,%eax
  8004a0:	01 c8                	add    %ecx,%eax
  8004a2:	8a 40 04             	mov    0x4(%eax),%al
  8004a5:	3c 01                	cmp    $0x1,%al
  8004a7:	75 03                	jne    8004ac <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8004a9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004ac:	ff 45 e0             	incl   -0x20(%ebp)
  8004af:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8004ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004bd:	39 c2                	cmp    %eax,%edx
  8004bf:	77 c8                	ja     800489 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004c7:	74 14                	je     8004dd <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8004c9:	83 ec 04             	sub    $0x4,%esp
  8004cc:	68 24 20 80 00       	push   $0x802024
  8004d1:	6a 44                	push   $0x44
  8004d3:	68 c4 1f 80 00       	push   $0x801fc4
  8004d8:	e8 15 fe ff ff       	call   8002f2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004dd:	90                   	nop
  8004de:	c9                   	leave  
  8004df:	c3                   	ret    

008004e0 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8004e0:	55                   	push   %ebp
  8004e1:	89 e5                	mov    %esp,%ebp
  8004e3:	53                   	push   %ebx
  8004e4:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8004e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8004ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f2:	89 0a                	mov    %ecx,(%edx)
  8004f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8004f7:	88 d1                	mov    %dl,%cl
  8004f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800500:	8b 45 0c             	mov    0xc(%ebp),%eax
  800503:	8b 00                	mov    (%eax),%eax
  800505:	3d ff 00 00 00       	cmp    $0xff,%eax
  80050a:	75 30                	jne    80053c <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80050c:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800512:	a0 40 30 80 00       	mov    0x803040,%al
  800517:	0f b6 c0             	movzbl %al,%eax
  80051a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80051d:	8b 09                	mov    (%ecx),%ecx
  80051f:	89 cb                	mov    %ecx,%ebx
  800521:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800524:	83 c1 08             	add    $0x8,%ecx
  800527:	52                   	push   %edx
  800528:	50                   	push   %eax
  800529:	53                   	push   %ebx
  80052a:	51                   	push   %ecx
  80052b:	e8 a0 0f 00 00       	call   8014d0 <sys_cputs>
  800530:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800533:	8b 45 0c             	mov    0xc(%ebp),%eax
  800536:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053f:	8b 40 04             	mov    0x4(%eax),%eax
  800542:	8d 50 01             	lea    0x1(%eax),%edx
  800545:	8b 45 0c             	mov    0xc(%ebp),%eax
  800548:	89 50 04             	mov    %edx,0x4(%eax)
}
  80054b:	90                   	nop
  80054c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80054f:	c9                   	leave  
  800550:	c3                   	ret    

00800551 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800551:	55                   	push   %ebp
  800552:	89 e5                	mov    %esp,%ebp
  800554:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80055a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800561:	00 00 00 
	b.cnt = 0;
  800564:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80056b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	ff 75 08             	pushl  0x8(%ebp)
  800574:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80057a:	50                   	push   %eax
  80057b:	68 e0 04 80 00       	push   $0x8004e0
  800580:	e8 5a 02 00 00       	call   8007df <vprintfmt>
  800585:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800588:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80058e:	a0 40 30 80 00       	mov    0x803040,%al
  800593:	0f b6 c0             	movzbl %al,%eax
  800596:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80059c:	52                   	push   %edx
  80059d:	50                   	push   %eax
  80059e:	51                   	push   %ecx
  80059f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005a5:	83 c0 08             	add    $0x8,%eax
  8005a8:	50                   	push   %eax
  8005a9:	e8 22 0f 00 00       	call   8014d0 <sys_cputs>
  8005ae:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005b1:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8005b8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005be:	c9                   	leave  
  8005bf:	c3                   	ret    

008005c0 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8005c0:	55                   	push   %ebp
  8005c1:	89 e5                	mov    %esp,%ebp
  8005c3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005c6:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005cd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d6:	83 ec 08             	sub    $0x8,%esp
  8005d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8005dc:	50                   	push   %eax
  8005dd:	e8 6f ff ff ff       	call   800551 <vcprintf>
  8005e2:	83 c4 10             	add    $0x10,%esp
  8005e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005eb:	c9                   	leave  
  8005ec:	c3                   	ret    

008005ed <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8005ed:	55                   	push   %ebp
  8005ee:	89 e5                	mov    %esp,%ebp
  8005f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005f3:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	c1 e0 08             	shl    $0x8,%eax
  800600:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800605:	8d 45 0c             	lea    0xc(%ebp),%eax
  800608:	83 c0 04             	add    $0x4,%eax
  80060b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80060e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800611:	83 ec 08             	sub    $0x8,%esp
  800614:	ff 75 f4             	pushl  -0xc(%ebp)
  800617:	50                   	push   %eax
  800618:	e8 34 ff ff ff       	call   800551 <vcprintf>
  80061d:	83 c4 10             	add    $0x10,%esp
  800620:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800623:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  80062a:	07 00 00 

	return cnt;
  80062d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800630:	c9                   	leave  
  800631:	c3                   	ret    

00800632 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800632:	55                   	push   %ebp
  800633:	89 e5                	mov    %esp,%ebp
  800635:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800638:	e8 d7 0e 00 00       	call   801514 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80063d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800640:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	83 ec 08             	sub    $0x8,%esp
  800649:	ff 75 f4             	pushl  -0xc(%ebp)
  80064c:	50                   	push   %eax
  80064d:	e8 ff fe ff ff       	call   800551 <vcprintf>
  800652:	83 c4 10             	add    $0x10,%esp
  800655:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800658:	e8 d1 0e 00 00       	call   80152e <sys_unlock_cons>
	return cnt;
  80065d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800660:	c9                   	leave  
  800661:	c3                   	ret    

00800662 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800662:	55                   	push   %ebp
  800663:	89 e5                	mov    %esp,%ebp
  800665:	53                   	push   %ebx
  800666:	83 ec 14             	sub    $0x14,%esp
  800669:	8b 45 10             	mov    0x10(%ebp),%eax
  80066c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80066f:	8b 45 14             	mov    0x14(%ebp),%eax
  800672:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800675:	8b 45 18             	mov    0x18(%ebp),%eax
  800678:	ba 00 00 00 00       	mov    $0x0,%edx
  80067d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800680:	77 55                	ja     8006d7 <printnum+0x75>
  800682:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800685:	72 05                	jb     80068c <printnum+0x2a>
  800687:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80068a:	77 4b                	ja     8006d7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80068c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80068f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800692:	8b 45 18             	mov    0x18(%ebp),%eax
  800695:	ba 00 00 00 00       	mov    $0x0,%edx
  80069a:	52                   	push   %edx
  80069b:	50                   	push   %eax
  80069c:	ff 75 f4             	pushl  -0xc(%ebp)
  80069f:	ff 75 f0             	pushl  -0x10(%ebp)
  8006a2:	e8 71 13 00 00       	call   801a18 <__udivdi3>
  8006a7:	83 c4 10             	add    $0x10,%esp
  8006aa:	83 ec 04             	sub    $0x4,%esp
  8006ad:	ff 75 20             	pushl  0x20(%ebp)
  8006b0:	53                   	push   %ebx
  8006b1:	ff 75 18             	pushl  0x18(%ebp)
  8006b4:	52                   	push   %edx
  8006b5:	50                   	push   %eax
  8006b6:	ff 75 0c             	pushl  0xc(%ebp)
  8006b9:	ff 75 08             	pushl  0x8(%ebp)
  8006bc:	e8 a1 ff ff ff       	call   800662 <printnum>
  8006c1:	83 c4 20             	add    $0x20,%esp
  8006c4:	eb 1a                	jmp    8006e0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006c6:	83 ec 08             	sub    $0x8,%esp
  8006c9:	ff 75 0c             	pushl  0xc(%ebp)
  8006cc:	ff 75 20             	pushl  0x20(%ebp)
  8006cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d2:	ff d0                	call   *%eax
  8006d4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006d7:	ff 4d 1c             	decl   0x1c(%ebp)
  8006da:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006de:	7f e6                	jg     8006c6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006e0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006e3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ee:	53                   	push   %ebx
  8006ef:	51                   	push   %ecx
  8006f0:	52                   	push   %edx
  8006f1:	50                   	push   %eax
  8006f2:	e8 31 14 00 00       	call   801b28 <__umoddi3>
  8006f7:	83 c4 10             	add    $0x10,%esp
  8006fa:	05 94 22 80 00       	add    $0x802294,%eax
  8006ff:	8a 00                	mov    (%eax),%al
  800701:	0f be c0             	movsbl %al,%eax
  800704:	83 ec 08             	sub    $0x8,%esp
  800707:	ff 75 0c             	pushl  0xc(%ebp)
  80070a:	50                   	push   %eax
  80070b:	8b 45 08             	mov    0x8(%ebp),%eax
  80070e:	ff d0                	call   *%eax
  800710:	83 c4 10             	add    $0x10,%esp
}
  800713:	90                   	nop
  800714:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800717:	c9                   	leave  
  800718:	c3                   	ret    

00800719 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800719:	55                   	push   %ebp
  80071a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80071c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800720:	7e 1c                	jle    80073e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	8d 50 08             	lea    0x8(%eax),%edx
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	89 10                	mov    %edx,(%eax)
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	83 e8 08             	sub    $0x8,%eax
  800737:	8b 50 04             	mov    0x4(%eax),%edx
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	eb 40                	jmp    80077e <getuint+0x65>
	else if (lflag)
  80073e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800742:	74 1e                	je     800762 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	8d 50 04             	lea    0x4(%eax),%edx
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	89 10                	mov    %edx,(%eax)
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	8b 00                	mov    (%eax),%eax
  800756:	83 e8 04             	sub    $0x4,%eax
  800759:	8b 00                	mov    (%eax),%eax
  80075b:	ba 00 00 00 00       	mov    $0x0,%edx
  800760:	eb 1c                	jmp    80077e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	8b 00                	mov    (%eax),%eax
  800767:	8d 50 04             	lea    0x4(%eax),%edx
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	89 10                	mov    %edx,(%eax)
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	83 e8 04             	sub    $0x4,%eax
  800777:	8b 00                	mov    (%eax),%eax
  800779:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80077e:	5d                   	pop    %ebp
  80077f:	c3                   	ret    

00800780 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800780:	55                   	push   %ebp
  800781:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800783:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800787:	7e 1c                	jle    8007a5 <getint+0x25>
		return va_arg(*ap, long long);
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	8b 00                	mov    (%eax),%eax
  80078e:	8d 50 08             	lea    0x8(%eax),%edx
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	89 10                	mov    %edx,(%eax)
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	83 e8 08             	sub    $0x8,%eax
  80079e:	8b 50 04             	mov    0x4(%eax),%edx
  8007a1:	8b 00                	mov    (%eax),%eax
  8007a3:	eb 38                	jmp    8007dd <getint+0x5d>
	else if (lflag)
  8007a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007a9:	74 1a                	je     8007c5 <getint+0x45>
		return va_arg(*ap, long);
  8007ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ae:	8b 00                	mov    (%eax),%eax
  8007b0:	8d 50 04             	lea    0x4(%eax),%edx
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	89 10                	mov    %edx,(%eax)
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	83 e8 04             	sub    $0x4,%eax
  8007c0:	8b 00                	mov    (%eax),%eax
  8007c2:	99                   	cltd   
  8007c3:	eb 18                	jmp    8007dd <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c8:	8b 00                	mov    (%eax),%eax
  8007ca:	8d 50 04             	lea    0x4(%eax),%edx
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	89 10                	mov    %edx,(%eax)
  8007d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d5:	8b 00                	mov    (%eax),%eax
  8007d7:	83 e8 04             	sub    $0x4,%eax
  8007da:	8b 00                	mov    (%eax),%eax
  8007dc:	99                   	cltd   
}
  8007dd:	5d                   	pop    %ebp
  8007de:	c3                   	ret    

008007df <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007df:	55                   	push   %ebp
  8007e0:	89 e5                	mov    %esp,%ebp
  8007e2:	56                   	push   %esi
  8007e3:	53                   	push   %ebx
  8007e4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007e7:	eb 17                	jmp    800800 <vprintfmt+0x21>
			if (ch == '\0')
  8007e9:	85 db                	test   %ebx,%ebx
  8007eb:	0f 84 c1 03 00 00    	je     800bb2 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8007f1:	83 ec 08             	sub    $0x8,%esp
  8007f4:	ff 75 0c             	pushl  0xc(%ebp)
  8007f7:	53                   	push   %ebx
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	ff d0                	call   *%eax
  8007fd:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800800:	8b 45 10             	mov    0x10(%ebp),%eax
  800803:	8d 50 01             	lea    0x1(%eax),%edx
  800806:	89 55 10             	mov    %edx,0x10(%ebp)
  800809:	8a 00                	mov    (%eax),%al
  80080b:	0f b6 d8             	movzbl %al,%ebx
  80080e:	83 fb 25             	cmp    $0x25,%ebx
  800811:	75 d6                	jne    8007e9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800813:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800817:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80081e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800825:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80082c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800833:	8b 45 10             	mov    0x10(%ebp),%eax
  800836:	8d 50 01             	lea    0x1(%eax),%edx
  800839:	89 55 10             	mov    %edx,0x10(%ebp)
  80083c:	8a 00                	mov    (%eax),%al
  80083e:	0f b6 d8             	movzbl %al,%ebx
  800841:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800844:	83 f8 5b             	cmp    $0x5b,%eax
  800847:	0f 87 3d 03 00 00    	ja     800b8a <vprintfmt+0x3ab>
  80084d:	8b 04 85 b8 22 80 00 	mov    0x8022b8(,%eax,4),%eax
  800854:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800856:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80085a:	eb d7                	jmp    800833 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80085c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800860:	eb d1                	jmp    800833 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800862:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800869:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80086c:	89 d0                	mov    %edx,%eax
  80086e:	c1 e0 02             	shl    $0x2,%eax
  800871:	01 d0                	add    %edx,%eax
  800873:	01 c0                	add    %eax,%eax
  800875:	01 d8                	add    %ebx,%eax
  800877:	83 e8 30             	sub    $0x30,%eax
  80087a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80087d:	8b 45 10             	mov    0x10(%ebp),%eax
  800880:	8a 00                	mov    (%eax),%al
  800882:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800885:	83 fb 2f             	cmp    $0x2f,%ebx
  800888:	7e 3e                	jle    8008c8 <vprintfmt+0xe9>
  80088a:	83 fb 39             	cmp    $0x39,%ebx
  80088d:	7f 39                	jg     8008c8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80088f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800892:	eb d5                	jmp    800869 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800894:	8b 45 14             	mov    0x14(%ebp),%eax
  800897:	83 c0 04             	add    $0x4,%eax
  80089a:	89 45 14             	mov    %eax,0x14(%ebp)
  80089d:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a0:	83 e8 04             	sub    $0x4,%eax
  8008a3:	8b 00                	mov    (%eax),%eax
  8008a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008a8:	eb 1f                	jmp    8008c9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ae:	79 83                	jns    800833 <vprintfmt+0x54>
				width = 0;
  8008b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008b7:	e9 77 ff ff ff       	jmp    800833 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008bc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008c3:	e9 6b ff ff ff       	jmp    800833 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008c8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008cd:	0f 89 60 ff ff ff    	jns    800833 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008d9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008e0:	e9 4e ff ff ff       	jmp    800833 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008e5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008e8:	e9 46 ff ff ff       	jmp    800833 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f0:	83 c0 04             	add    $0x4,%eax
  8008f3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f9:	83 e8 04             	sub    $0x4,%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	83 ec 08             	sub    $0x8,%esp
  800901:	ff 75 0c             	pushl  0xc(%ebp)
  800904:	50                   	push   %eax
  800905:	8b 45 08             	mov    0x8(%ebp),%eax
  800908:	ff d0                	call   *%eax
  80090a:	83 c4 10             	add    $0x10,%esp
			break;
  80090d:	e9 9b 02 00 00       	jmp    800bad <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800912:	8b 45 14             	mov    0x14(%ebp),%eax
  800915:	83 c0 04             	add    $0x4,%eax
  800918:	89 45 14             	mov    %eax,0x14(%ebp)
  80091b:	8b 45 14             	mov    0x14(%ebp),%eax
  80091e:	83 e8 04             	sub    $0x4,%eax
  800921:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800923:	85 db                	test   %ebx,%ebx
  800925:	79 02                	jns    800929 <vprintfmt+0x14a>
				err = -err;
  800927:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800929:	83 fb 64             	cmp    $0x64,%ebx
  80092c:	7f 0b                	jg     800939 <vprintfmt+0x15a>
  80092e:	8b 34 9d 00 21 80 00 	mov    0x802100(,%ebx,4),%esi
  800935:	85 f6                	test   %esi,%esi
  800937:	75 19                	jne    800952 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800939:	53                   	push   %ebx
  80093a:	68 a5 22 80 00       	push   $0x8022a5
  80093f:	ff 75 0c             	pushl  0xc(%ebp)
  800942:	ff 75 08             	pushl  0x8(%ebp)
  800945:	e8 70 02 00 00       	call   800bba <printfmt>
  80094a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80094d:	e9 5b 02 00 00       	jmp    800bad <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800952:	56                   	push   %esi
  800953:	68 ae 22 80 00       	push   $0x8022ae
  800958:	ff 75 0c             	pushl  0xc(%ebp)
  80095b:	ff 75 08             	pushl  0x8(%ebp)
  80095e:	e8 57 02 00 00       	call   800bba <printfmt>
  800963:	83 c4 10             	add    $0x10,%esp
			break;
  800966:	e9 42 02 00 00       	jmp    800bad <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80096b:	8b 45 14             	mov    0x14(%ebp),%eax
  80096e:	83 c0 04             	add    $0x4,%eax
  800971:	89 45 14             	mov    %eax,0x14(%ebp)
  800974:	8b 45 14             	mov    0x14(%ebp),%eax
  800977:	83 e8 04             	sub    $0x4,%eax
  80097a:	8b 30                	mov    (%eax),%esi
  80097c:	85 f6                	test   %esi,%esi
  80097e:	75 05                	jne    800985 <vprintfmt+0x1a6>
				p = "(null)";
  800980:	be b1 22 80 00       	mov    $0x8022b1,%esi
			if (width > 0 && padc != '-')
  800985:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800989:	7e 6d                	jle    8009f8 <vprintfmt+0x219>
  80098b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80098f:	74 67                	je     8009f8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800991:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	50                   	push   %eax
  800998:	56                   	push   %esi
  800999:	e8 1e 03 00 00       	call   800cbc <strnlen>
  80099e:	83 c4 10             	add    $0x10,%esp
  8009a1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009a4:	eb 16                	jmp    8009bc <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009a6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009aa:	83 ec 08             	sub    $0x8,%esp
  8009ad:	ff 75 0c             	pushl  0xc(%ebp)
  8009b0:	50                   	push   %eax
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	ff d0                	call   *%eax
  8009b6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009b9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009bc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c0:	7f e4                	jg     8009a6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c2:	eb 34                	jmp    8009f8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009c4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009c8:	74 1c                	je     8009e6 <vprintfmt+0x207>
  8009ca:	83 fb 1f             	cmp    $0x1f,%ebx
  8009cd:	7e 05                	jle    8009d4 <vprintfmt+0x1f5>
  8009cf:	83 fb 7e             	cmp    $0x7e,%ebx
  8009d2:	7e 12                	jle    8009e6 <vprintfmt+0x207>
					putch('?', putdat);
  8009d4:	83 ec 08             	sub    $0x8,%esp
  8009d7:	ff 75 0c             	pushl  0xc(%ebp)
  8009da:	6a 3f                	push   $0x3f
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	ff d0                	call   *%eax
  8009e1:	83 c4 10             	add    $0x10,%esp
  8009e4:	eb 0f                	jmp    8009f5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009e6:	83 ec 08             	sub    $0x8,%esp
  8009e9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ec:	53                   	push   %ebx
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	ff d0                	call   *%eax
  8009f2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009f5:	ff 4d e4             	decl   -0x1c(%ebp)
  8009f8:	89 f0                	mov    %esi,%eax
  8009fa:	8d 70 01             	lea    0x1(%eax),%esi
  8009fd:	8a 00                	mov    (%eax),%al
  8009ff:	0f be d8             	movsbl %al,%ebx
  800a02:	85 db                	test   %ebx,%ebx
  800a04:	74 24                	je     800a2a <vprintfmt+0x24b>
  800a06:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a0a:	78 b8                	js     8009c4 <vprintfmt+0x1e5>
  800a0c:	ff 4d e0             	decl   -0x20(%ebp)
  800a0f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a13:	79 af                	jns    8009c4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a15:	eb 13                	jmp    800a2a <vprintfmt+0x24b>
				putch(' ', putdat);
  800a17:	83 ec 08             	sub    $0x8,%esp
  800a1a:	ff 75 0c             	pushl  0xc(%ebp)
  800a1d:	6a 20                	push   $0x20
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a27:	ff 4d e4             	decl   -0x1c(%ebp)
  800a2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2e:	7f e7                	jg     800a17 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a30:	e9 78 01 00 00       	jmp    800bad <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a35:	83 ec 08             	sub    $0x8,%esp
  800a38:	ff 75 e8             	pushl  -0x18(%ebp)
  800a3b:	8d 45 14             	lea    0x14(%ebp),%eax
  800a3e:	50                   	push   %eax
  800a3f:	e8 3c fd ff ff       	call   800780 <getint>
  800a44:	83 c4 10             	add    $0x10,%esp
  800a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a50:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a53:	85 d2                	test   %edx,%edx
  800a55:	79 23                	jns    800a7a <vprintfmt+0x29b>
				putch('-', putdat);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	6a 2d                	push   $0x2d
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	ff d0                	call   *%eax
  800a64:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a6d:	f7 d8                	neg    %eax
  800a6f:	83 d2 00             	adc    $0x0,%edx
  800a72:	f7 da                	neg    %edx
  800a74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a77:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a7a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a81:	e9 bc 00 00 00       	jmp    800b42 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 e8             	pushl  -0x18(%ebp)
  800a8c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a8f:	50                   	push   %eax
  800a90:	e8 84 fc ff ff       	call   800719 <getuint>
  800a95:	83 c4 10             	add    $0x10,%esp
  800a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a9e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa5:	e9 98 00 00 00       	jmp    800b42 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800aaa:	83 ec 08             	sub    $0x8,%esp
  800aad:	ff 75 0c             	pushl  0xc(%ebp)
  800ab0:	6a 58                	push   $0x58
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	ff d0                	call   *%eax
  800ab7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aba:	83 ec 08             	sub    $0x8,%esp
  800abd:	ff 75 0c             	pushl  0xc(%ebp)
  800ac0:	6a 58                	push   $0x58
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	ff d0                	call   *%eax
  800ac7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aca:	83 ec 08             	sub    $0x8,%esp
  800acd:	ff 75 0c             	pushl  0xc(%ebp)
  800ad0:	6a 58                	push   $0x58
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	ff d0                	call   *%eax
  800ad7:	83 c4 10             	add    $0x10,%esp
			break;
  800ada:	e9 ce 00 00 00       	jmp    800bad <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	6a 30                	push   $0x30
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	ff d0                	call   *%eax
  800aec:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 0c             	pushl  0xc(%ebp)
  800af5:	6a 78                	push   $0x78
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	ff d0                	call   *%eax
  800afc:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800aff:	8b 45 14             	mov    0x14(%ebp),%eax
  800b02:	83 c0 04             	add    $0x4,%eax
  800b05:	89 45 14             	mov    %eax,0x14(%ebp)
  800b08:	8b 45 14             	mov    0x14(%ebp),%eax
  800b0b:	83 e8 04             	sub    $0x4,%eax
  800b0e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b1a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b21:	eb 1f                	jmp    800b42 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b23:	83 ec 08             	sub    $0x8,%esp
  800b26:	ff 75 e8             	pushl  -0x18(%ebp)
  800b29:	8d 45 14             	lea    0x14(%ebp),%eax
  800b2c:	50                   	push   %eax
  800b2d:	e8 e7 fb ff ff       	call   800719 <getuint>
  800b32:	83 c4 10             	add    $0x10,%esp
  800b35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b38:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b3b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b42:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b46:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b49:	83 ec 04             	sub    $0x4,%esp
  800b4c:	52                   	push   %edx
  800b4d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b50:	50                   	push   %eax
  800b51:	ff 75 f4             	pushl  -0xc(%ebp)
  800b54:	ff 75 f0             	pushl  -0x10(%ebp)
  800b57:	ff 75 0c             	pushl  0xc(%ebp)
  800b5a:	ff 75 08             	pushl  0x8(%ebp)
  800b5d:	e8 00 fb ff ff       	call   800662 <printnum>
  800b62:	83 c4 20             	add    $0x20,%esp
			break;
  800b65:	eb 46                	jmp    800bad <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	53                   	push   %ebx
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
			break;
  800b76:	eb 35                	jmp    800bad <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b78:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800b7f:	eb 2c                	jmp    800bad <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800b81:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800b88:	eb 23                	jmp    800bad <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	6a 25                	push   $0x25
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	ff d0                	call   *%eax
  800b97:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b9a:	ff 4d 10             	decl   0x10(%ebp)
  800b9d:	eb 03                	jmp    800ba2 <vprintfmt+0x3c3>
  800b9f:	ff 4d 10             	decl   0x10(%ebp)
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	48                   	dec    %eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	3c 25                	cmp    $0x25,%al
  800baa:	75 f3                	jne    800b9f <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800bac:	90                   	nop
		}
	}
  800bad:	e9 35 fc ff ff       	jmp    8007e7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bb2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bb6:	5b                   	pop    %ebx
  800bb7:	5e                   	pop    %esi
  800bb8:	5d                   	pop    %ebp
  800bb9:	c3                   	ret    

00800bba <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bba:	55                   	push   %ebp
  800bbb:	89 e5                	mov    %esp,%ebp
  800bbd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bc0:	8d 45 10             	lea    0x10(%ebp),%eax
  800bc3:	83 c0 04             	add    $0x4,%eax
  800bc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcf:	50                   	push   %eax
  800bd0:	ff 75 0c             	pushl  0xc(%ebp)
  800bd3:	ff 75 08             	pushl  0x8(%ebp)
  800bd6:	e8 04 fc ff ff       	call   8007df <vprintfmt>
  800bdb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bde:	90                   	nop
  800bdf:	c9                   	leave  
  800be0:	c3                   	ret    

00800be1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800be1:	55                   	push   %ebp
  800be2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800be4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be7:	8b 40 08             	mov    0x8(%eax),%eax
  800bea:	8d 50 01             	lea    0x1(%eax),%edx
  800bed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf6:	8b 10                	mov    (%eax),%edx
  800bf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfb:	8b 40 04             	mov    0x4(%eax),%eax
  800bfe:	39 c2                	cmp    %eax,%edx
  800c00:	73 12                	jae    800c14 <sprintputch+0x33>
		*b->buf++ = ch;
  800c02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c05:	8b 00                	mov    (%eax),%eax
  800c07:	8d 48 01             	lea    0x1(%eax),%ecx
  800c0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c0d:	89 0a                	mov    %ecx,(%edx)
  800c0f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c12:	88 10                	mov    %dl,(%eax)
}
  800c14:	90                   	nop
  800c15:	5d                   	pop    %ebp
  800c16:	c3                   	ret    

00800c17 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c17:	55                   	push   %ebp
  800c18:	89 e5                	mov    %esp,%ebp
  800c1a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c26:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	01 d0                	add    %edx,%eax
  800c2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c38:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c3c:	74 06                	je     800c44 <vsnprintf+0x2d>
  800c3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c42:	7f 07                	jg     800c4b <vsnprintf+0x34>
		return -E_INVAL;
  800c44:	b8 03 00 00 00       	mov    $0x3,%eax
  800c49:	eb 20                	jmp    800c6b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c4b:	ff 75 14             	pushl  0x14(%ebp)
  800c4e:	ff 75 10             	pushl  0x10(%ebp)
  800c51:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c54:	50                   	push   %eax
  800c55:	68 e1 0b 80 00       	push   $0x800be1
  800c5a:	e8 80 fb ff ff       	call   8007df <vprintfmt>
  800c5f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c65:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c68:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c6b:	c9                   	leave  
  800c6c:	c3                   	ret    

00800c6d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
  800c70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c73:	8d 45 10             	lea    0x10(%ebp),%eax
  800c76:	83 c0 04             	add    $0x4,%eax
  800c79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c82:	50                   	push   %eax
  800c83:	ff 75 0c             	pushl  0xc(%ebp)
  800c86:	ff 75 08             	pushl  0x8(%ebp)
  800c89:	e8 89 ff ff ff       	call   800c17 <vsnprintf>
  800c8e:	83 c4 10             	add    $0x10,%esp
  800c91:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c94:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
  800c9c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ca6:	eb 06                	jmp    800cae <strlen+0x15>
		n++;
  800ca8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cab:	ff 45 08             	incl   0x8(%ebp)
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	84 c0                	test   %al,%al
  800cb5:	75 f1                	jne    800ca8 <strlen+0xf>
		n++;
	return n;
  800cb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cba:	c9                   	leave  
  800cbb:	c3                   	ret    

00800cbc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cbc:	55                   	push   %ebp
  800cbd:	89 e5                	mov    %esp,%ebp
  800cbf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cc9:	eb 09                	jmp    800cd4 <strnlen+0x18>
		n++;
  800ccb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cce:	ff 45 08             	incl   0x8(%ebp)
  800cd1:	ff 4d 0c             	decl   0xc(%ebp)
  800cd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cd8:	74 09                	je     800ce3 <strnlen+0x27>
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	84 c0                	test   %al,%al
  800ce1:	75 e8                	jne    800ccb <strnlen+0xf>
		n++;
	return n;
  800ce3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ce6:	c9                   	leave  
  800ce7:	c3                   	ret    

00800ce8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ce8:	55                   	push   %ebp
  800ce9:	89 e5                	mov    %esp,%ebp
  800ceb:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cf4:	90                   	nop
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	8d 50 01             	lea    0x1(%eax),%edx
  800cfb:	89 55 08             	mov    %edx,0x8(%ebp)
  800cfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d01:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d04:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d07:	8a 12                	mov    (%edx),%dl
  800d09:	88 10                	mov    %dl,(%eax)
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	84 c0                	test   %al,%al
  800d0f:	75 e4                	jne    800cf5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d11:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d14:	c9                   	leave  
  800d15:	c3                   	ret    

00800d16 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d29:	eb 1f                	jmp    800d4a <strncpy+0x34>
		*dst++ = *src;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8d 50 01             	lea    0x1(%eax),%edx
  800d31:	89 55 08             	mov    %edx,0x8(%ebp)
  800d34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d37:	8a 12                	mov    (%edx),%dl
  800d39:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	84 c0                	test   %al,%al
  800d42:	74 03                	je     800d47 <strncpy+0x31>
			src++;
  800d44:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d47:	ff 45 fc             	incl   -0x4(%ebp)
  800d4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d4d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d50:	72 d9                	jb     800d2b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d52:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d55:	c9                   	leave  
  800d56:	c3                   	ret    

00800d57 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d57:	55                   	push   %ebp
  800d58:	89 e5                	mov    %esp,%ebp
  800d5a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d67:	74 30                	je     800d99 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d69:	eb 16                	jmp    800d81 <strlcpy+0x2a>
			*dst++ = *src++;
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8d 50 01             	lea    0x1(%eax),%edx
  800d71:	89 55 08             	mov    %edx,0x8(%ebp)
  800d74:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d77:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d7a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7d:	8a 12                	mov    (%edx),%dl
  800d7f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d81:	ff 4d 10             	decl   0x10(%ebp)
  800d84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d88:	74 09                	je     800d93 <strlcpy+0x3c>
  800d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8d:	8a 00                	mov    (%eax),%al
  800d8f:	84 c0                	test   %al,%al
  800d91:	75 d8                	jne    800d6b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d99:	8b 55 08             	mov    0x8(%ebp),%edx
  800d9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d9f:	29 c2                	sub    %eax,%edx
  800da1:	89 d0                	mov    %edx,%eax
}
  800da3:	c9                   	leave  
  800da4:	c3                   	ret    

00800da5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800da5:	55                   	push   %ebp
  800da6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800da8:	eb 06                	jmp    800db0 <strcmp+0xb>
		p++, q++;
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	74 0e                	je     800dc7 <strcmp+0x22>
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	8a 10                	mov    (%eax),%dl
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	38 c2                	cmp    %al,%dl
  800dc5:	74 e3                	je     800daa <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	0f b6 d0             	movzbl %al,%edx
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	0f b6 c0             	movzbl %al,%eax
  800dd7:	29 c2                	sub    %eax,%edx
  800dd9:	89 d0                	mov    %edx,%eax
}
  800ddb:	5d                   	pop    %ebp
  800ddc:	c3                   	ret    

00800ddd <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ddd:	55                   	push   %ebp
  800dde:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800de0:	eb 09                	jmp    800deb <strncmp+0xe>
		n--, p++, q++;
  800de2:	ff 4d 10             	decl   0x10(%ebp)
  800de5:	ff 45 08             	incl   0x8(%ebp)
  800de8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800deb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800def:	74 17                	je     800e08 <strncmp+0x2b>
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	84 c0                	test   %al,%al
  800df8:	74 0e                	je     800e08 <strncmp+0x2b>
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8a 10                	mov    (%eax),%dl
  800dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	38 c2                	cmp    %al,%dl
  800e06:	74 da                	je     800de2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e0c:	75 07                	jne    800e15 <strncmp+0x38>
		return 0;
  800e0e:	b8 00 00 00 00       	mov    $0x0,%eax
  800e13:	eb 14                	jmp    800e29 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	8a 00                	mov    (%eax),%al
  800e1a:	0f b6 d0             	movzbl %al,%edx
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	8a 00                	mov    (%eax),%al
  800e22:	0f b6 c0             	movzbl %al,%eax
  800e25:	29 c2                	sub    %eax,%edx
  800e27:	89 d0                	mov    %edx,%eax
}
  800e29:	5d                   	pop    %ebp
  800e2a:	c3                   	ret    

00800e2b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
  800e2e:	83 ec 04             	sub    $0x4,%esp
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e37:	eb 12                	jmp    800e4b <strchr+0x20>
		if (*s == c)
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	8a 00                	mov    (%eax),%al
  800e3e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e41:	75 05                	jne    800e48 <strchr+0x1d>
			return (char *) s;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	eb 11                	jmp    800e59 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e48:	ff 45 08             	incl   0x8(%ebp)
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	84 c0                	test   %al,%al
  800e52:	75 e5                	jne    800e39 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e59:	c9                   	leave  
  800e5a:	c3                   	ret    

00800e5b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e5b:	55                   	push   %ebp
  800e5c:	89 e5                	mov    %esp,%ebp
  800e5e:	83 ec 04             	sub    $0x4,%esp
  800e61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e64:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e67:	eb 0d                	jmp    800e76 <strfind+0x1b>
		if (*s == c)
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e71:	74 0e                	je     800e81 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e73:	ff 45 08             	incl   0x8(%ebp)
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	84 c0                	test   %al,%al
  800e7d:	75 ea                	jne    800e69 <strfind+0xe>
  800e7f:	eb 01                	jmp    800e82 <strfind+0x27>
		if (*s == c)
			break;
  800e81:	90                   	nop
	return (char *) s;
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e85:	c9                   	leave  
  800e86:	c3                   	ret    

00800e87 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800e87:	55                   	push   %ebp
  800e88:	89 e5                	mov    %esp,%ebp
  800e8a:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e90:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800e93:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800e97:	76 63                	jbe    800efc <memset+0x75>
		uint64 data_block = c;
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	99                   	cltd   
  800e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea0:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea9:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800ead:	c1 e0 08             	shl    $0x8,%eax
  800eb0:	09 45 f0             	or     %eax,-0x10(%ebp)
  800eb3:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800eb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ebc:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800ec0:	c1 e0 10             	shl    $0x10,%eax
  800ec3:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ec6:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800ec9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ecc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ecf:	89 c2                	mov    %eax,%edx
  800ed1:	b8 00 00 00 00       	mov    $0x0,%eax
  800ed6:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ed9:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800edc:	eb 18                	jmp    800ef6 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800ede:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ee1:	8d 41 08             	lea    0x8(%ecx),%eax
  800ee4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800ee7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eed:	89 01                	mov    %eax,(%ecx)
  800eef:	89 51 04             	mov    %edx,0x4(%ecx)
  800ef2:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800ef6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800efa:	77 e2                	ja     800ede <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800efc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f00:	74 23                	je     800f25 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f05:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f08:	eb 0e                	jmp    800f18 <memset+0x91>
			*p8++ = (uint8)c;
  800f0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f0d:	8d 50 01             	lea    0x1(%eax),%edx
  800f10:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f16:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f18:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f1e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f21:	85 c0                	test   %eax,%eax
  800f23:	75 e5                	jne    800f0a <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f28:	c9                   	leave  
  800f29:	c3                   	ret    

00800f2a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f2a:	55                   	push   %ebp
  800f2b:	89 e5                	mov    %esp,%ebp
  800f2d:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f3c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f40:	76 24                	jbe    800f66 <memcpy+0x3c>
		while(n >= 8){
  800f42:	eb 1c                	jmp    800f60 <memcpy+0x36>
			*d64 = *s64;
  800f44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f47:	8b 50 04             	mov    0x4(%eax),%edx
  800f4a:	8b 00                	mov    (%eax),%eax
  800f4c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f4f:	89 01                	mov    %eax,(%ecx)
  800f51:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f54:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f58:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f5c:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f60:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f64:	77 de                	ja     800f44 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6a:	74 31                	je     800f9d <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f75:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f78:	eb 16                	jmp    800f90 <memcpy+0x66>
			*d8++ = *s8++;
  800f7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f7d:	8d 50 01             	lea    0x1(%eax),%edx
  800f80:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800f83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f86:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f89:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800f8c:	8a 12                	mov    (%edx),%dl
  800f8e:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800f90:	8b 45 10             	mov    0x10(%ebp),%eax
  800f93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f96:	89 55 10             	mov    %edx,0x10(%ebp)
  800f99:	85 c0                	test   %eax,%eax
  800f9b:	75 dd                	jne    800f7a <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fa0:	c9                   	leave  
  800fa1:	c3                   	ret    

00800fa2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fa2:	55                   	push   %ebp
  800fa3:	89 e5                	mov    %esp,%ebp
  800fa5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fba:	73 50                	jae    80100c <memmove+0x6a>
  800fbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc2:	01 d0                	add    %edx,%eax
  800fc4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fc7:	76 43                	jbe    80100c <memmove+0x6a>
		s += n;
  800fc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fd5:	eb 10                	jmp    800fe7 <memmove+0x45>
			*--d = *--s;
  800fd7:	ff 4d f8             	decl   -0x8(%ebp)
  800fda:	ff 4d fc             	decl   -0x4(%ebp)
  800fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe0:	8a 10                	mov    (%eax),%dl
  800fe2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fe7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fea:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fed:	89 55 10             	mov    %edx,0x10(%ebp)
  800ff0:	85 c0                	test   %eax,%eax
  800ff2:	75 e3                	jne    800fd7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ff4:	eb 23                	jmp    801019 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ff6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff9:	8d 50 01             	lea    0x1(%eax),%edx
  800ffc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801002:	8d 4a 01             	lea    0x1(%edx),%ecx
  801005:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801008:	8a 12                	mov    (%edx),%dl
  80100a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801012:	89 55 10             	mov    %edx,0x10(%ebp)
  801015:	85 c0                	test   %eax,%eax
  801017:	75 dd                	jne    800ff6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80101c:	c9                   	leave  
  80101d:	c3                   	ret    

0080101e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
  801021:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80102a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801030:	eb 2a                	jmp    80105c <memcmp+0x3e>
		if (*s1 != *s2)
  801032:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801035:	8a 10                	mov    (%eax),%dl
  801037:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	38 c2                	cmp    %al,%dl
  80103e:	74 16                	je     801056 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801040:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	0f b6 d0             	movzbl %al,%edx
  801048:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104b:	8a 00                	mov    (%eax),%al
  80104d:	0f b6 c0             	movzbl %al,%eax
  801050:	29 c2                	sub    %eax,%edx
  801052:	89 d0                	mov    %edx,%eax
  801054:	eb 18                	jmp    80106e <memcmp+0x50>
		s1++, s2++;
  801056:	ff 45 fc             	incl   -0x4(%ebp)
  801059:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80105c:	8b 45 10             	mov    0x10(%ebp),%eax
  80105f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801062:	89 55 10             	mov    %edx,0x10(%ebp)
  801065:	85 c0                	test   %eax,%eax
  801067:	75 c9                	jne    801032 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801069:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
  801073:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801076:	8b 55 08             	mov    0x8(%ebp),%edx
  801079:	8b 45 10             	mov    0x10(%ebp),%eax
  80107c:	01 d0                	add    %edx,%eax
  80107e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801081:	eb 15                	jmp    801098 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	0f b6 d0             	movzbl %al,%edx
  80108b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108e:	0f b6 c0             	movzbl %al,%eax
  801091:	39 c2                	cmp    %eax,%edx
  801093:	74 0d                	je     8010a2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801095:	ff 45 08             	incl   0x8(%ebp)
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80109e:	72 e3                	jb     801083 <memfind+0x13>
  8010a0:	eb 01                	jmp    8010a3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010a2:	90                   	nop
	return (void *) s;
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010a6:	c9                   	leave  
  8010a7:	c3                   	ret    

008010a8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010a8:	55                   	push   %ebp
  8010a9:	89 e5                	mov    %esp,%ebp
  8010ab:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010b5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010bc:	eb 03                	jmp    8010c1 <strtol+0x19>
		s++;
  8010be:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	3c 20                	cmp    $0x20,%al
  8010c8:	74 f4                	je     8010be <strtol+0x16>
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	3c 09                	cmp    $0x9,%al
  8010d1:	74 eb                	je     8010be <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	3c 2b                	cmp    $0x2b,%al
  8010da:	75 05                	jne    8010e1 <strtol+0x39>
		s++;
  8010dc:	ff 45 08             	incl   0x8(%ebp)
  8010df:	eb 13                	jmp    8010f4 <strtol+0x4c>
	else if (*s == '-')
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	3c 2d                	cmp    $0x2d,%al
  8010e8:	75 0a                	jne    8010f4 <strtol+0x4c>
		s++, neg = 1;
  8010ea:	ff 45 08             	incl   0x8(%ebp)
  8010ed:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f8:	74 06                	je     801100 <strtol+0x58>
  8010fa:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010fe:	75 20                	jne    801120 <strtol+0x78>
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	8a 00                	mov    (%eax),%al
  801105:	3c 30                	cmp    $0x30,%al
  801107:	75 17                	jne    801120 <strtol+0x78>
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	40                   	inc    %eax
  80110d:	8a 00                	mov    (%eax),%al
  80110f:	3c 78                	cmp    $0x78,%al
  801111:	75 0d                	jne    801120 <strtol+0x78>
		s += 2, base = 16;
  801113:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801117:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80111e:	eb 28                	jmp    801148 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801120:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801124:	75 15                	jne    80113b <strtol+0x93>
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 30                	cmp    $0x30,%al
  80112d:	75 0c                	jne    80113b <strtol+0x93>
		s++, base = 8;
  80112f:	ff 45 08             	incl   0x8(%ebp)
  801132:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801139:	eb 0d                	jmp    801148 <strtol+0xa0>
	else if (base == 0)
  80113b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113f:	75 07                	jne    801148 <strtol+0xa0>
		base = 10;
  801141:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 2f                	cmp    $0x2f,%al
  80114f:	7e 19                	jle    80116a <strtol+0xc2>
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	3c 39                	cmp    $0x39,%al
  801158:	7f 10                	jg     80116a <strtol+0xc2>
			dig = *s - '0';
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	0f be c0             	movsbl %al,%eax
  801162:	83 e8 30             	sub    $0x30,%eax
  801165:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801168:	eb 42                	jmp    8011ac <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 60                	cmp    $0x60,%al
  801171:	7e 19                	jle    80118c <strtol+0xe4>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 7a                	cmp    $0x7a,%al
  80117a:	7f 10                	jg     80118c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	0f be c0             	movsbl %al,%eax
  801184:	83 e8 57             	sub    $0x57,%eax
  801187:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80118a:	eb 20                	jmp    8011ac <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	3c 40                	cmp    $0x40,%al
  801193:	7e 39                	jle    8011ce <strtol+0x126>
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3c 5a                	cmp    $0x5a,%al
  80119c:	7f 30                	jg     8011ce <strtol+0x126>
			dig = *s - 'A' + 10;
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f be c0             	movsbl %al,%eax
  8011a6:	83 e8 37             	sub    $0x37,%eax
  8011a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011b2:	7d 19                	jge    8011cd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011b4:	ff 45 08             	incl   0x8(%ebp)
  8011b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ba:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011be:	89 c2                	mov    %eax,%edx
  8011c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c3:	01 d0                	add    %edx,%eax
  8011c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011c8:	e9 7b ff ff ff       	jmp    801148 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011cd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011d2:	74 08                	je     8011dc <strtol+0x134>
		*endptr = (char *) s;
  8011d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d7:	8b 55 08             	mov    0x8(%ebp),%edx
  8011da:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011e0:	74 07                	je     8011e9 <strtol+0x141>
  8011e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e5:	f7 d8                	neg    %eax
  8011e7:	eb 03                	jmp    8011ec <strtol+0x144>
  8011e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <ltostr>:

void
ltostr(long value, char *str)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
  8011f1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011fb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801202:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801206:	79 13                	jns    80121b <ltostr+0x2d>
	{
		neg = 1;
  801208:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80120f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801212:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801215:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801218:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801223:	99                   	cltd   
  801224:	f7 f9                	idiv   %ecx
  801226:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801229:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122c:	8d 50 01             	lea    0x1(%eax),%edx
  80122f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801232:	89 c2                	mov    %eax,%edx
  801234:	8b 45 0c             	mov    0xc(%ebp),%eax
  801237:	01 d0                	add    %edx,%eax
  801239:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80123c:	83 c2 30             	add    $0x30,%edx
  80123f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801241:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801244:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801249:	f7 e9                	imul   %ecx
  80124b:	c1 fa 02             	sar    $0x2,%edx
  80124e:	89 c8                	mov    %ecx,%eax
  801250:	c1 f8 1f             	sar    $0x1f,%eax
  801253:	29 c2                	sub    %eax,%edx
  801255:	89 d0                	mov    %edx,%eax
  801257:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80125a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80125e:	75 bb                	jne    80121b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801267:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126a:	48                   	dec    %eax
  80126b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80126e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801272:	74 3d                	je     8012b1 <ltostr+0xc3>
		start = 1 ;
  801274:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80127b:	eb 34                	jmp    8012b1 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80127d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801280:	8b 45 0c             	mov    0xc(%ebp),%eax
  801283:	01 d0                	add    %edx,%eax
  801285:	8a 00                	mov    (%eax),%al
  801287:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80128a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80128d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801290:	01 c2                	add    %eax,%edx
  801292:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	01 c8                	add    %ecx,%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80129e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	01 c2                	add    %eax,%edx
  8012a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8012ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012b7:	7c c4                	jl     80127d <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bf:	01 d0                	add    %edx,%eax
  8012c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012c4:	90                   	nop
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
  8012ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012cd:	ff 75 08             	pushl  0x8(%ebp)
  8012d0:	e8 c4 f9 ff ff       	call   800c99 <strlen>
  8012d5:	83 c4 04             	add    $0x4,%esp
  8012d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012db:	ff 75 0c             	pushl  0xc(%ebp)
  8012de:	e8 b6 f9 ff ff       	call   800c99 <strlen>
  8012e3:	83 c4 04             	add    $0x4,%esp
  8012e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f7:	eb 17                	jmp    801310 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ff:	01 c2                	add    %eax,%edx
  801301:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	01 c8                	add    %ecx,%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80130d:	ff 45 fc             	incl   -0x4(%ebp)
  801310:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801313:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801316:	7c e1                	jl     8012f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801318:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80131f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801326:	eb 1f                	jmp    801347 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801328:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132b:	8d 50 01             	lea    0x1(%eax),%edx
  80132e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801331:	89 c2                	mov    %eax,%edx
  801333:	8b 45 10             	mov    0x10(%ebp),%eax
  801336:	01 c2                	add    %eax,%edx
  801338:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80133b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133e:	01 c8                	add    %ecx,%eax
  801340:	8a 00                	mov    (%eax),%al
  801342:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801344:	ff 45 f8             	incl   -0x8(%ebp)
  801347:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80134d:	7c d9                	jl     801328 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80134f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801352:	8b 45 10             	mov    0x10(%ebp),%eax
  801355:	01 d0                	add    %edx,%eax
  801357:	c6 00 00             	movb   $0x0,(%eax)
}
  80135a:	90                   	nop
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801360:	8b 45 14             	mov    0x14(%ebp),%eax
  801363:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801369:	8b 45 14             	mov    0x14(%ebp),%eax
  80136c:	8b 00                	mov    (%eax),%eax
  80136e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801375:	8b 45 10             	mov    0x10(%ebp),%eax
  801378:	01 d0                	add    %edx,%eax
  80137a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801380:	eb 0c                	jmp    80138e <strsplit+0x31>
			*string++ = 0;
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	8d 50 01             	lea    0x1(%eax),%edx
  801388:	89 55 08             	mov    %edx,0x8(%ebp)
  80138b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	84 c0                	test   %al,%al
  801395:	74 18                	je     8013af <strsplit+0x52>
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	0f be c0             	movsbl %al,%eax
  80139f:	50                   	push   %eax
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	e8 83 fa ff ff       	call   800e2b <strchr>
  8013a8:	83 c4 08             	add    $0x8,%esp
  8013ab:	85 c0                	test   %eax,%eax
  8013ad:	75 d3                	jne    801382 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	8a 00                	mov    (%eax),%al
  8013b4:	84 c0                	test   %al,%al
  8013b6:	74 5a                	je     801412 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013bb:	8b 00                	mov    (%eax),%eax
  8013bd:	83 f8 0f             	cmp    $0xf,%eax
  8013c0:	75 07                	jne    8013c9 <strsplit+0x6c>
		{
			return 0;
  8013c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c7:	eb 66                	jmp    80142f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cc:	8b 00                	mov    (%eax),%eax
  8013ce:	8d 48 01             	lea    0x1(%eax),%ecx
  8013d1:	8b 55 14             	mov    0x14(%ebp),%edx
  8013d4:	89 0a                	mov    %ecx,(%edx)
  8013d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e0:	01 c2                	add    %eax,%edx
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013e7:	eb 03                	jmp    8013ec <strsplit+0x8f>
			string++;
  8013e9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	84 c0                	test   %al,%al
  8013f3:	74 8b                	je     801380 <strsplit+0x23>
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	8a 00                	mov    (%eax),%al
  8013fa:	0f be c0             	movsbl %al,%eax
  8013fd:	50                   	push   %eax
  8013fe:	ff 75 0c             	pushl  0xc(%ebp)
  801401:	e8 25 fa ff ff       	call   800e2b <strchr>
  801406:	83 c4 08             	add    $0x8,%esp
  801409:	85 c0                	test   %eax,%eax
  80140b:	74 dc                	je     8013e9 <strsplit+0x8c>
			string++;
	}
  80140d:	e9 6e ff ff ff       	jmp    801380 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801412:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801413:	8b 45 14             	mov    0x14(%ebp),%eax
  801416:	8b 00                	mov    (%eax),%eax
  801418:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80141f:	8b 45 10             	mov    0x10(%ebp),%eax
  801422:	01 d0                	add    %edx,%eax
  801424:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80142a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80142f:	c9                   	leave  
  801430:	c3                   	ret    

00801431 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
  801434:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80143d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801444:	eb 4a                	jmp    801490 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801446:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	01 c2                	add    %eax,%edx
  80144e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801451:	8b 45 0c             	mov    0xc(%ebp),%eax
  801454:	01 c8                	add    %ecx,%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80145a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801460:	01 d0                	add    %edx,%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	3c 40                	cmp    $0x40,%al
  801466:	7e 25                	jle    80148d <str2lower+0x5c>
  801468:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80146b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146e:	01 d0                	add    %edx,%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	3c 5a                	cmp    $0x5a,%al
  801474:	7f 17                	jg     80148d <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801476:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	01 d0                	add    %edx,%eax
  80147e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801481:	8b 55 08             	mov    0x8(%ebp),%edx
  801484:	01 ca                	add    %ecx,%edx
  801486:	8a 12                	mov    (%edx),%dl
  801488:	83 c2 20             	add    $0x20,%edx
  80148b:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80148d:	ff 45 fc             	incl   -0x4(%ebp)
  801490:	ff 75 0c             	pushl  0xc(%ebp)
  801493:	e8 01 f8 ff ff       	call   800c99 <strlen>
  801498:	83 c4 04             	add    $0x4,%esp
  80149b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80149e:	7f a6                	jg     801446 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014a3:	c9                   	leave  
  8014a4:	c3                   	ret    

008014a5 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	57                   	push   %edi
  8014a9:	56                   	push   %esi
  8014aa:	53                   	push   %ebx
  8014ab:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014b7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014ba:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014bd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014c0:	cd 30                	int    $0x30
  8014c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014c8:	83 c4 10             	add    $0x10,%esp
  8014cb:	5b                   	pop    %ebx
  8014cc:	5e                   	pop    %esi
  8014cd:	5f                   	pop    %edi
  8014ce:	5d                   	pop    %ebp
  8014cf:	c3                   	ret    

008014d0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
  8014d3:	83 ec 04             	sub    $0x4,%esp
  8014d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8014dc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014df:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	6a 00                	push   $0x0
  8014e8:	51                   	push   %ecx
  8014e9:	52                   	push   %edx
  8014ea:	ff 75 0c             	pushl  0xc(%ebp)
  8014ed:	50                   	push   %eax
  8014ee:	6a 00                	push   $0x0
  8014f0:	e8 b0 ff ff ff       	call   8014a5 <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	90                   	nop
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_cgetc>:

int
sys_cgetc(void)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 02                	push   $0x2
  80150a:	e8 96 ff ff ff       	call   8014a5 <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 03                	push   $0x3
  801523:	e8 7d ff ff ff       	call   8014a5 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	90                   	nop
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 04                	push   $0x4
  80153d:	e8 63 ff ff ff       	call   8014a5 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	90                   	nop
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80154b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	52                   	push   %edx
  801558:	50                   	push   %eax
  801559:	6a 08                	push   $0x8
  80155b:	e8 45 ff ff ff       	call   8014a5 <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
  801568:	56                   	push   %esi
  801569:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80156a:	8b 75 18             	mov    0x18(%ebp),%esi
  80156d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801570:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801573:	8b 55 0c             	mov    0xc(%ebp),%edx
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	56                   	push   %esi
  80157a:	53                   	push   %ebx
  80157b:	51                   	push   %ecx
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	6a 09                	push   $0x9
  801580:	e8 20 ff ff ff       	call   8014a5 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80158b:	5b                   	pop    %ebx
  80158c:	5e                   	pop    %esi
  80158d:	5d                   	pop    %ebp
  80158e:	c3                   	ret    

0080158f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	ff 75 08             	pushl  0x8(%ebp)
  80159d:	6a 0a                	push   $0xa
  80159f:	e8 01 ff ff ff       	call   8014a5 <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	ff 75 0c             	pushl  0xc(%ebp)
  8015b5:	ff 75 08             	pushl  0x8(%ebp)
  8015b8:	6a 0b                	push   $0xb
  8015ba:	e8 e6 fe ff ff       	call   8014a5 <syscall>
  8015bf:	83 c4 18             	add    $0x18,%esp
}
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 0c                	push   $0xc
  8015d3:	e8 cd fe ff ff       	call   8014a5 <syscall>
  8015d8:	83 c4 18             	add    $0x18,%esp
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 0d                	push   $0xd
  8015ec:	e8 b4 fe ff ff       	call   8014a5 <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 0e                	push   $0xe
  801605:	e8 9b fe ff ff       	call   8014a5 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 0f                	push   $0xf
  80161e:	e8 82 fe ff ff       	call   8014a5 <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	ff 75 08             	pushl  0x8(%ebp)
  801636:	6a 10                	push   $0x10
  801638:	e8 68 fe ff ff       	call   8014a5 <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 11                	push   $0x11
  801651:	e8 4f fe ff ff       	call   8014a5 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	90                   	nop
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_cputc>:

void
sys_cputc(const char c)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 04             	sub    $0x4,%esp
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801668:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	50                   	push   %eax
  801675:	6a 01                	push   $0x1
  801677:	e8 29 fe ff ff       	call   8014a5 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	90                   	nop
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 14                	push   $0x14
  801691:	e8 0f fe ff ff       	call   8014a5 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
}
  801699:	90                   	nop
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 04             	sub    $0x4,%esp
  8016a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8016a8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016ab:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	6a 00                	push   $0x0
  8016b4:	51                   	push   %ecx
  8016b5:	52                   	push   %edx
  8016b6:	ff 75 0c             	pushl  0xc(%ebp)
  8016b9:	50                   	push   %eax
  8016ba:	6a 15                	push   $0x15
  8016bc:	e8 e4 fd ff ff       	call   8014a5 <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8016c9:	8b 55 10             	mov    0x10(%ebp),%edx
  8016cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	52                   	push   %edx
  8016d4:	50                   	push   %eax
  8016d5:	ff 75 08             	pushl  0x8(%ebp)
  8016d8:	6a 16                	push   $0x16
  8016da:	e8 c6 fd ff ff       	call   8014a5 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	52                   	push   %edx
  8016f4:	50                   	push   %eax
  8016f5:	6a 17                	push   $0x17
  8016f7:	e8 a9 fd ff ff       	call   8014a5 <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801704:	8b 55 0c             	mov    0xc(%ebp),%edx
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	52                   	push   %edx
  801711:	50                   	push   %eax
  801712:	6a 18                	push   $0x18
  801714:	e8 8c fd ff ff       	call   8014a5 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	6a 00                	push   $0x0
  801726:	ff 75 14             	pushl  0x14(%ebp)
  801729:	ff 75 10             	pushl  0x10(%ebp)
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 19                	push   $0x19
  801732:	e8 6e fd ff ff       	call   8014a5 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_run_env>:

void sys_run_env(int32 envId)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	50                   	push   %eax
  80174b:	6a 1a                	push   $0x1a
  80174d:	e8 53 fd ff ff       	call   8014a5 <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	90                   	nop
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	50                   	push   %eax
  801767:	6a 1b                	push   $0x1b
  801769:	e8 37 fd ff ff       	call   8014a5 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 05                	push   $0x5
  801782:	e8 1e fd ff ff       	call   8014a5 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 06                	push   $0x6
  80179b:	e8 05 fd ff ff       	call   8014a5 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 07                	push   $0x7
  8017b4:	e8 ec fc ff ff       	call   8014a5 <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_exit_env>:


void sys_exit_env(void)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 1c                	push   $0x1c
  8017cd:	e8 d3 fc ff ff       	call   8014a5 <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	90                   	nop
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	ff 75 10             	pushl  0x10(%ebp)
  8017e2:	ff 75 0c             	pushl  0xc(%ebp)
  8017e5:	ff 75 08             	pushl  0x8(%ebp)
  8017e8:	6a 13                	push   $0x13
  8017ea:	e8 b6 fc ff ff       	call   8014a5 <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f2:	90                   	nop
}
  8017f3:	c9                   	leave  
  8017f4:	c3                   	ret    

008017f5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017f5:	55                   	push   %ebp
  8017f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 1e                	push   $0x1e
  801804:	e8 9c fc ff ff       	call   8014a5 <syscall>
  801809:	83 c4 18             	add    $0x18,%esp
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	8b 45 08             	mov    0x8(%ebp),%eax
  801817:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80181a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	50                   	push   %eax
  801827:	6a 1f                	push   $0x1f
  801829:	e8 77 fc ff ff       	call   8014a5 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
	return ;
  801831:	90                   	nop
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <rsttst>:
void rsttst()
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 21                	push   $0x21
  801843:	e8 5d fc ff ff       	call   8014a5 <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
	return ;
  80184b:	90                   	nop
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
  801851:	83 ec 04             	sub    $0x4,%esp
  801854:	8b 45 14             	mov    0x14(%ebp),%eax
  801857:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80185a:	8b 55 18             	mov    0x18(%ebp),%edx
  80185d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801861:	52                   	push   %edx
  801862:	50                   	push   %eax
  801863:	ff 75 10             	pushl  0x10(%ebp)
  801866:	ff 75 0c             	pushl  0xc(%ebp)
  801869:	ff 75 08             	pushl  0x8(%ebp)
  80186c:	6a 20                	push   $0x20
  80186e:	e8 32 fc ff ff       	call   8014a5 <syscall>
  801873:	83 c4 18             	add    $0x18,%esp
	return ;
  801876:	90                   	nop
}
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <chktst>:
void chktst(uint32 n)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	ff 75 08             	pushl  0x8(%ebp)
  801887:	6a 22                	push   $0x22
  801889:	e8 17 fc ff ff       	call   8014a5 <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
	return ;
  801891:	90                   	nop
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <inctst>:

void inctst()
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 23                	push   $0x23
  8018a3:	e8 fd fb ff ff       	call   8014a5 <syscall>
  8018a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ab:	90                   	nop
}
  8018ac:	c9                   	leave  
  8018ad:	c3                   	ret    

008018ae <gettst>:
uint32 gettst()
{
  8018ae:	55                   	push   %ebp
  8018af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 24                	push   $0x24
  8018bd:	e8 e3 fb ff ff       	call   8014a5 <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 25                	push   $0x25
  8018d6:	e8 ca fb ff ff       	call   8014a5 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
  8018de:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018e3:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	ff 75 08             	pushl  0x8(%ebp)
  801900:	6a 26                	push   $0x26
  801902:	e8 9e fb ff ff       	call   8014a5 <syscall>
  801907:	83 c4 18             	add    $0x18,%esp
	return ;
  80190a:	90                   	nop
}
  80190b:	c9                   	leave  
  80190c:	c3                   	ret    

0080190d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80190d:	55                   	push   %ebp
  80190e:	89 e5                	mov    %esp,%ebp
  801910:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801911:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801914:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801917:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191a:	8b 45 08             	mov    0x8(%ebp),%eax
  80191d:	6a 00                	push   $0x0
  80191f:	53                   	push   %ebx
  801920:	51                   	push   %ecx
  801921:	52                   	push   %edx
  801922:	50                   	push   %eax
  801923:	6a 27                	push   $0x27
  801925:	e8 7b fb ff ff       	call   8014a5 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801935:	8b 55 0c             	mov    0xc(%ebp),%edx
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	52                   	push   %edx
  801942:	50                   	push   %eax
  801943:	6a 28                	push   $0x28
  801945:	e8 5b fb ff ff       	call   8014a5 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801952:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801955:	8b 55 0c             	mov    0xc(%ebp),%edx
  801958:	8b 45 08             	mov    0x8(%ebp),%eax
  80195b:	6a 00                	push   $0x0
  80195d:	51                   	push   %ecx
  80195e:	ff 75 10             	pushl  0x10(%ebp)
  801961:	52                   	push   %edx
  801962:	50                   	push   %eax
  801963:	6a 29                	push   $0x29
  801965:	e8 3b fb ff ff       	call   8014a5 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	ff 75 10             	pushl  0x10(%ebp)
  801979:	ff 75 0c             	pushl  0xc(%ebp)
  80197c:	ff 75 08             	pushl  0x8(%ebp)
  80197f:	6a 12                	push   $0x12
  801981:	e8 1f fb ff ff       	call   8014a5 <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
	return ;
  801989:	90                   	nop
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80198f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	52                   	push   %edx
  80199c:	50                   	push   %eax
  80199d:	6a 2a                	push   $0x2a
  80199f:	e8 01 fb ff ff       	call   8014a5 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
	return;
  8019a7:	90                   	nop
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 2b                	push   $0x2b
  8019b9:	e8 e7 fa ff ff       	call   8014a5 <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
  8019c6:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8019c9:	83 ec 04             	sub    $0x4,%esp
  8019cc:	68 28 24 80 00       	push   $0x802428
  8019d1:	68 0a 01 00 00       	push   $0x10a
  8019d6:	68 38 24 80 00       	push   $0x802438
  8019db:	e8 12 e9 ff ff       	call   8002f2 <_panic>

008019e0 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	ff 75 0c             	pushl  0xc(%ebp)
  8019ec:	ff 75 08             	pushl  0x8(%ebp)
  8019ef:	6a 33                	push   $0x33
  8019f1:	e8 af fa ff ff       	call   8014a5 <syscall>
  8019f6:	83 c4 18             	add    $0x18,%esp
	return;
  8019f9:	90                   	nop
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	ff 75 0c             	pushl  0xc(%ebp)
  801a08:	ff 75 08             	pushl  0x8(%ebp)
  801a0b:	6a 34                	push   $0x34
  801a0d:	e8 93 fa ff ff       	call   8014a5 <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
	return ;
  801a15:	90                   	nop
}
  801a16:	c9                   	leave  
  801a17:	c3                   	ret    

00801a18 <__udivdi3>:
  801a18:	55                   	push   %ebp
  801a19:	57                   	push   %edi
  801a1a:	56                   	push   %esi
  801a1b:	53                   	push   %ebx
  801a1c:	83 ec 1c             	sub    $0x1c,%esp
  801a1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a2f:	89 ca                	mov    %ecx,%edx
  801a31:	89 f8                	mov    %edi,%eax
  801a33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a37:	85 f6                	test   %esi,%esi
  801a39:	75 2d                	jne    801a68 <__udivdi3+0x50>
  801a3b:	39 cf                	cmp    %ecx,%edi
  801a3d:	77 65                	ja     801aa4 <__udivdi3+0x8c>
  801a3f:	89 fd                	mov    %edi,%ebp
  801a41:	85 ff                	test   %edi,%edi
  801a43:	75 0b                	jne    801a50 <__udivdi3+0x38>
  801a45:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4a:	31 d2                	xor    %edx,%edx
  801a4c:	f7 f7                	div    %edi
  801a4e:	89 c5                	mov    %eax,%ebp
  801a50:	31 d2                	xor    %edx,%edx
  801a52:	89 c8                	mov    %ecx,%eax
  801a54:	f7 f5                	div    %ebp
  801a56:	89 c1                	mov    %eax,%ecx
  801a58:	89 d8                	mov    %ebx,%eax
  801a5a:	f7 f5                	div    %ebp
  801a5c:	89 cf                	mov    %ecx,%edi
  801a5e:	89 fa                	mov    %edi,%edx
  801a60:	83 c4 1c             	add    $0x1c,%esp
  801a63:	5b                   	pop    %ebx
  801a64:	5e                   	pop    %esi
  801a65:	5f                   	pop    %edi
  801a66:	5d                   	pop    %ebp
  801a67:	c3                   	ret    
  801a68:	39 ce                	cmp    %ecx,%esi
  801a6a:	77 28                	ja     801a94 <__udivdi3+0x7c>
  801a6c:	0f bd fe             	bsr    %esi,%edi
  801a6f:	83 f7 1f             	xor    $0x1f,%edi
  801a72:	75 40                	jne    801ab4 <__udivdi3+0x9c>
  801a74:	39 ce                	cmp    %ecx,%esi
  801a76:	72 0a                	jb     801a82 <__udivdi3+0x6a>
  801a78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a7c:	0f 87 9e 00 00 00    	ja     801b20 <__udivdi3+0x108>
  801a82:	b8 01 00 00 00       	mov    $0x1,%eax
  801a87:	89 fa                	mov    %edi,%edx
  801a89:	83 c4 1c             	add    $0x1c,%esp
  801a8c:	5b                   	pop    %ebx
  801a8d:	5e                   	pop    %esi
  801a8e:	5f                   	pop    %edi
  801a8f:	5d                   	pop    %ebp
  801a90:	c3                   	ret    
  801a91:	8d 76 00             	lea    0x0(%esi),%esi
  801a94:	31 ff                	xor    %edi,%edi
  801a96:	31 c0                	xor    %eax,%eax
  801a98:	89 fa                	mov    %edi,%edx
  801a9a:	83 c4 1c             	add    $0x1c,%esp
  801a9d:	5b                   	pop    %ebx
  801a9e:	5e                   	pop    %esi
  801a9f:	5f                   	pop    %edi
  801aa0:	5d                   	pop    %ebp
  801aa1:	c3                   	ret    
  801aa2:	66 90                	xchg   %ax,%ax
  801aa4:	89 d8                	mov    %ebx,%eax
  801aa6:	f7 f7                	div    %edi
  801aa8:	31 ff                	xor    %edi,%edi
  801aaa:	89 fa                	mov    %edi,%edx
  801aac:	83 c4 1c             	add    $0x1c,%esp
  801aaf:	5b                   	pop    %ebx
  801ab0:	5e                   	pop    %esi
  801ab1:	5f                   	pop    %edi
  801ab2:	5d                   	pop    %ebp
  801ab3:	c3                   	ret    
  801ab4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ab9:	89 eb                	mov    %ebp,%ebx
  801abb:	29 fb                	sub    %edi,%ebx
  801abd:	89 f9                	mov    %edi,%ecx
  801abf:	d3 e6                	shl    %cl,%esi
  801ac1:	89 c5                	mov    %eax,%ebp
  801ac3:	88 d9                	mov    %bl,%cl
  801ac5:	d3 ed                	shr    %cl,%ebp
  801ac7:	89 e9                	mov    %ebp,%ecx
  801ac9:	09 f1                	or     %esi,%ecx
  801acb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801acf:	89 f9                	mov    %edi,%ecx
  801ad1:	d3 e0                	shl    %cl,%eax
  801ad3:	89 c5                	mov    %eax,%ebp
  801ad5:	89 d6                	mov    %edx,%esi
  801ad7:	88 d9                	mov    %bl,%cl
  801ad9:	d3 ee                	shr    %cl,%esi
  801adb:	89 f9                	mov    %edi,%ecx
  801add:	d3 e2                	shl    %cl,%edx
  801adf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ae3:	88 d9                	mov    %bl,%cl
  801ae5:	d3 e8                	shr    %cl,%eax
  801ae7:	09 c2                	or     %eax,%edx
  801ae9:	89 d0                	mov    %edx,%eax
  801aeb:	89 f2                	mov    %esi,%edx
  801aed:	f7 74 24 0c          	divl   0xc(%esp)
  801af1:	89 d6                	mov    %edx,%esi
  801af3:	89 c3                	mov    %eax,%ebx
  801af5:	f7 e5                	mul    %ebp
  801af7:	39 d6                	cmp    %edx,%esi
  801af9:	72 19                	jb     801b14 <__udivdi3+0xfc>
  801afb:	74 0b                	je     801b08 <__udivdi3+0xf0>
  801afd:	89 d8                	mov    %ebx,%eax
  801aff:	31 ff                	xor    %edi,%edi
  801b01:	e9 58 ff ff ff       	jmp    801a5e <__udivdi3+0x46>
  801b06:	66 90                	xchg   %ax,%ax
  801b08:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b0c:	89 f9                	mov    %edi,%ecx
  801b0e:	d3 e2                	shl    %cl,%edx
  801b10:	39 c2                	cmp    %eax,%edx
  801b12:	73 e9                	jae    801afd <__udivdi3+0xe5>
  801b14:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b17:	31 ff                	xor    %edi,%edi
  801b19:	e9 40 ff ff ff       	jmp    801a5e <__udivdi3+0x46>
  801b1e:	66 90                	xchg   %ax,%ax
  801b20:	31 c0                	xor    %eax,%eax
  801b22:	e9 37 ff ff ff       	jmp    801a5e <__udivdi3+0x46>
  801b27:	90                   	nop

00801b28 <__umoddi3>:
  801b28:	55                   	push   %ebp
  801b29:	57                   	push   %edi
  801b2a:	56                   	push   %esi
  801b2b:	53                   	push   %ebx
  801b2c:	83 ec 1c             	sub    $0x1c,%esp
  801b2f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b33:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b3b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b43:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b47:	89 f3                	mov    %esi,%ebx
  801b49:	89 fa                	mov    %edi,%edx
  801b4b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b4f:	89 34 24             	mov    %esi,(%esp)
  801b52:	85 c0                	test   %eax,%eax
  801b54:	75 1a                	jne    801b70 <__umoddi3+0x48>
  801b56:	39 f7                	cmp    %esi,%edi
  801b58:	0f 86 a2 00 00 00    	jbe    801c00 <__umoddi3+0xd8>
  801b5e:	89 c8                	mov    %ecx,%eax
  801b60:	89 f2                	mov    %esi,%edx
  801b62:	f7 f7                	div    %edi
  801b64:	89 d0                	mov    %edx,%eax
  801b66:	31 d2                	xor    %edx,%edx
  801b68:	83 c4 1c             	add    $0x1c,%esp
  801b6b:	5b                   	pop    %ebx
  801b6c:	5e                   	pop    %esi
  801b6d:	5f                   	pop    %edi
  801b6e:	5d                   	pop    %ebp
  801b6f:	c3                   	ret    
  801b70:	39 f0                	cmp    %esi,%eax
  801b72:	0f 87 ac 00 00 00    	ja     801c24 <__umoddi3+0xfc>
  801b78:	0f bd e8             	bsr    %eax,%ebp
  801b7b:	83 f5 1f             	xor    $0x1f,%ebp
  801b7e:	0f 84 ac 00 00 00    	je     801c30 <__umoddi3+0x108>
  801b84:	bf 20 00 00 00       	mov    $0x20,%edi
  801b89:	29 ef                	sub    %ebp,%edi
  801b8b:	89 fe                	mov    %edi,%esi
  801b8d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b91:	89 e9                	mov    %ebp,%ecx
  801b93:	d3 e0                	shl    %cl,%eax
  801b95:	89 d7                	mov    %edx,%edi
  801b97:	89 f1                	mov    %esi,%ecx
  801b99:	d3 ef                	shr    %cl,%edi
  801b9b:	09 c7                	or     %eax,%edi
  801b9d:	89 e9                	mov    %ebp,%ecx
  801b9f:	d3 e2                	shl    %cl,%edx
  801ba1:	89 14 24             	mov    %edx,(%esp)
  801ba4:	89 d8                	mov    %ebx,%eax
  801ba6:	d3 e0                	shl    %cl,%eax
  801ba8:	89 c2                	mov    %eax,%edx
  801baa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bae:	d3 e0                	shl    %cl,%eax
  801bb0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bb4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bb8:	89 f1                	mov    %esi,%ecx
  801bba:	d3 e8                	shr    %cl,%eax
  801bbc:	09 d0                	or     %edx,%eax
  801bbe:	d3 eb                	shr    %cl,%ebx
  801bc0:	89 da                	mov    %ebx,%edx
  801bc2:	f7 f7                	div    %edi
  801bc4:	89 d3                	mov    %edx,%ebx
  801bc6:	f7 24 24             	mull   (%esp)
  801bc9:	89 c6                	mov    %eax,%esi
  801bcb:	89 d1                	mov    %edx,%ecx
  801bcd:	39 d3                	cmp    %edx,%ebx
  801bcf:	0f 82 87 00 00 00    	jb     801c5c <__umoddi3+0x134>
  801bd5:	0f 84 91 00 00 00    	je     801c6c <__umoddi3+0x144>
  801bdb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bdf:	29 f2                	sub    %esi,%edx
  801be1:	19 cb                	sbb    %ecx,%ebx
  801be3:	89 d8                	mov    %ebx,%eax
  801be5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801be9:	d3 e0                	shl    %cl,%eax
  801beb:	89 e9                	mov    %ebp,%ecx
  801bed:	d3 ea                	shr    %cl,%edx
  801bef:	09 d0                	or     %edx,%eax
  801bf1:	89 e9                	mov    %ebp,%ecx
  801bf3:	d3 eb                	shr    %cl,%ebx
  801bf5:	89 da                	mov    %ebx,%edx
  801bf7:	83 c4 1c             	add    $0x1c,%esp
  801bfa:	5b                   	pop    %ebx
  801bfb:	5e                   	pop    %esi
  801bfc:	5f                   	pop    %edi
  801bfd:	5d                   	pop    %ebp
  801bfe:	c3                   	ret    
  801bff:	90                   	nop
  801c00:	89 fd                	mov    %edi,%ebp
  801c02:	85 ff                	test   %edi,%edi
  801c04:	75 0b                	jne    801c11 <__umoddi3+0xe9>
  801c06:	b8 01 00 00 00       	mov    $0x1,%eax
  801c0b:	31 d2                	xor    %edx,%edx
  801c0d:	f7 f7                	div    %edi
  801c0f:	89 c5                	mov    %eax,%ebp
  801c11:	89 f0                	mov    %esi,%eax
  801c13:	31 d2                	xor    %edx,%edx
  801c15:	f7 f5                	div    %ebp
  801c17:	89 c8                	mov    %ecx,%eax
  801c19:	f7 f5                	div    %ebp
  801c1b:	89 d0                	mov    %edx,%eax
  801c1d:	e9 44 ff ff ff       	jmp    801b66 <__umoddi3+0x3e>
  801c22:	66 90                	xchg   %ax,%ax
  801c24:	89 c8                	mov    %ecx,%eax
  801c26:	89 f2                	mov    %esi,%edx
  801c28:	83 c4 1c             	add    $0x1c,%esp
  801c2b:	5b                   	pop    %ebx
  801c2c:	5e                   	pop    %esi
  801c2d:	5f                   	pop    %edi
  801c2e:	5d                   	pop    %ebp
  801c2f:	c3                   	ret    
  801c30:	3b 04 24             	cmp    (%esp),%eax
  801c33:	72 06                	jb     801c3b <__umoddi3+0x113>
  801c35:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c39:	77 0f                	ja     801c4a <__umoddi3+0x122>
  801c3b:	89 f2                	mov    %esi,%edx
  801c3d:	29 f9                	sub    %edi,%ecx
  801c3f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c43:	89 14 24             	mov    %edx,(%esp)
  801c46:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c4a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c4e:	8b 14 24             	mov    (%esp),%edx
  801c51:	83 c4 1c             	add    $0x1c,%esp
  801c54:	5b                   	pop    %ebx
  801c55:	5e                   	pop    %esi
  801c56:	5f                   	pop    %edi
  801c57:	5d                   	pop    %ebp
  801c58:	c3                   	ret    
  801c59:	8d 76 00             	lea    0x0(%esi),%esi
  801c5c:	2b 04 24             	sub    (%esp),%eax
  801c5f:	19 fa                	sbb    %edi,%edx
  801c61:	89 d1                	mov    %edx,%ecx
  801c63:	89 c6                	mov    %eax,%esi
  801c65:	e9 71 ff ff ff       	jmp    801bdb <__umoddi3+0xb3>
  801c6a:	66 90                	xchg   %ax,%ax
  801c6c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c70:	72 ea                	jb     801c5c <__umoddi3+0x134>
  801c72:	89 d9                	mov    %ebx,%ecx
  801c74:	e9 62 ff ff ff       	jmp    801bdb <__umoddi3+0xb3>
