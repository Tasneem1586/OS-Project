
obj/user/tst_invalid_access_slave1:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
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
	//[1] Kernel address
	uint32 *ptr = (uint32*)(KERN_STACK_TOP - 12) ;
  80003e:	c7 45 f4 f4 ff bf ef 	movl   $0xefbffff4,-0xc(%ebp)
	*ptr = 100 ;
  800045:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800048:	c7 00 64 00 00 00    	movl   $0x64,(%eax)

	inctst();
  80004e:	e8 16 18 00 00       	call   801869 <inctst>
	panic("tst invalid access failed:Attempt to access kernel location.\nThe env must be killed and shouldn't return here.");
  800053:	83 ec 04             	sub    $0x4,%esp
  800056:	68 60 1c 80 00       	push   $0x801c60
  80005b:	6a 0e                	push   $0xe
  80005d:	68 d0 1c 80 00       	push   $0x801cd0
  800062:	e8 60 02 00 00       	call   8002c7 <_panic>

00800067 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	57                   	push   %edi
  80006b:	56                   	push   %esi
  80006c:	53                   	push   %ebx
  80006d:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800073:	e8 e9 16 00 00       	call   801761 <sys_getenvindex>
  800078:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80007b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80007e:	89 d0                	mov    %edx,%eax
  800080:	c1 e0 03             	shl    $0x3,%eax
  800083:	01 d0                	add    %edx,%eax
  800085:	c1 e0 06             	shl    $0x6,%eax
  800088:	01 d0                	add    %edx,%eax
  80008a:	c1 e0 03             	shl    $0x3,%eax
  80008d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800092:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8a 40 10             	mov    0x10(%eax),%al
  80009f:	84 c0                	test   %al,%al
  8000a1:	74 0d                	je     8000b0 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a8:	83 c0 10             	add    $0x10,%eax
  8000ab:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000b4:	7e 0a                	jle    8000c0 <libmain+0x59>
		binaryname = argv[0];
  8000b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000b9:	8b 00                	mov    (%eax),%eax
  8000bb:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000c0:	83 ec 08             	sub    $0x8,%esp
  8000c3:	ff 75 0c             	pushl  0xc(%ebp)
  8000c6:	ff 75 08             	pushl  0x8(%ebp)
  8000c9:	e8 6a ff ff ff       	call   800038 <_main>
  8000ce:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000d1:	a1 00 30 80 00       	mov    0x803000,%eax
  8000d6:	85 c0                	test   %eax,%eax
  8000d8:	0f 84 b7 01 00 00    	je     800295 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000de:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000e4:	bb 30 1e 80 00       	mov    $0x801e30,%ebx
  8000e9:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000ee:	89 c7                	mov    %eax,%edi
  8000f0:	89 de                	mov    %ebx,%esi
  8000f2:	89 d1                	mov    %edx,%ecx
  8000f4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000f6:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8000fc:	b9 56 00 00 00       	mov    $0x56,%ecx
  800101:	b0 00                	mov    $0x0,%al
  800103:	89 d7                	mov    %edx,%edi
  800105:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800107:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80010e:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800111:	83 ec 08             	sub    $0x8,%esp
  800114:	50                   	push   %eax
  800115:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80011b:	50                   	push   %eax
  80011c:	e8 40 18 00 00       	call   801961 <sys_utilities>
  800121:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800124:	e8 c0 13 00 00       	call   8014e9 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800129:	83 ec 0c             	sub    $0xc,%esp
  80012c:	68 0c 1d 80 00       	push   $0x801d0c
  800131:	e8 5f 04 00 00       	call   800595 <cprintf>
  800136:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800139:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80013c:	85 c0                	test   %eax,%eax
  80013e:	74 58                	je     800198 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800140:	e8 3a 18 00 00       	call   80197f <sys_get_optimal_num_faults>
  800145:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800148:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80014e:	bb 94 1e 80 00       	mov    $0x801e94,%ebx
  800153:	ba 11 00 00 00       	mov    $0x11,%edx
  800158:	89 c7                	mov    %eax,%edi
  80015a:	89 de                	mov    %ebx,%esi
  80015c:	89 d1                	mov    %edx,%ecx
  80015e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800160:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800163:	b9 53 00 00 00       	mov    $0x53,%ecx
  800168:	b0 00                	mov    $0x0,%al
  80016a:	89 d7                	mov    %edx,%edi
  80016c:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 dc             	pushl  -0x24(%ebp)
  800174:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80017a:	50                   	push   %eax
  80017b:	e8 e1 17 00 00       	call   801961 <sys_utilities>
  800180:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 dc             	pushl  -0x24(%ebp)
  800189:	68 34 1d 80 00       	push   $0x801d34
  80018e:	e8 02 04 00 00       	call   800595 <cprintf>
  800193:	83 c4 10             	add    $0x10,%esp
  800196:	eb 59                	jmp    8001f1 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800198:	a1 20 30 80 00       	mov    0x803020,%eax
  80019d:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a8:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	52                   	push   %edx
  8001b2:	50                   	push   %eax
  8001b3:	68 58 1d 80 00       	push   $0x801d58
  8001b8:	e8 d8 03 00 00       	call   800595 <cprintf>
  8001bd:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c5:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d0:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001db:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001e1:	51                   	push   %ecx
  8001e2:	52                   	push   %edx
  8001e3:	50                   	push   %eax
  8001e4:	68 80 1d 80 00       	push   $0x801d80
  8001e9:	e8 a7 03 00 00       	call   800595 <cprintf>
  8001ee:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8001fc:	83 ec 08             	sub    $0x8,%esp
  8001ff:	50                   	push   %eax
  800200:	68 d8 1d 80 00       	push   $0x801dd8
  800205:	e8 8b 03 00 00       	call   800595 <cprintf>
  80020a:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80020d:	83 ec 0c             	sub    $0xc,%esp
  800210:	68 ec 1d 80 00       	push   $0x801dec
  800215:	e8 7b 03 00 00       	call   800595 <cprintf>
  80021a:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80021d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800224:	eb 28                	jmp    80024e <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800226:	a1 20 30 80 00       	mov    0x803020,%eax
  80022b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80022e:	81 c2 74 04 00 00    	add    $0x474,%edx
  800234:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800237:	83 ec 04             	sub    $0x4,%esp
  80023a:	50                   	push   %eax
  80023b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80023e:	68 03 1e 80 00       	push   $0x801e03
  800243:	e8 4d 03 00 00       	call   800595 <cprintf>
  800248:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80024b:	ff 45 e4             	incl   -0x1c(%ebp)
  80024e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800252:	7e d2                	jle    800226 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	68 12 1e 80 00       	push   $0x801e12
  80025c:	e8 34 03 00 00       	call   800595 <cprintf>
  800261:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800264:	a1 20 30 80 00       	mov    0x803020,%eax
  800269:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80026f:	83 ec 08             	sub    $0x8,%esp
  800272:	50                   	push   %eax
  800273:	68 16 1e 80 00       	push   $0x801e16
  800278:	e8 18 03 00 00       	call   800595 <cprintf>
  80027d:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	68 0c 1d 80 00       	push   $0x801d0c
  800288:	e8 08 03 00 00       	call   800595 <cprintf>
  80028d:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800290:	e8 6e 12 00 00       	call   801503 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800295:	e8 1f 00 00 00       	call   8002b9 <exit>
}
  80029a:	90                   	nop
  80029b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80029e:	5b                   	pop    %ebx
  80029f:	5e                   	pop    %esi
  8002a0:	5f                   	pop    %edi
  8002a1:	5d                   	pop    %ebp
  8002a2:	c3                   	ret    

008002a3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	6a 00                	push   $0x0
  8002ae:	e8 7a 14 00 00       	call   80172d <sys_destroy_env>
  8002b3:	83 c4 10             	add    $0x10,%esp
}
  8002b6:	90                   	nop
  8002b7:	c9                   	leave  
  8002b8:	c3                   	ret    

008002b9 <exit>:

void
exit(void)
{
  8002b9:	55                   	push   %ebp
  8002ba:	89 e5                	mov    %esp,%ebp
  8002bc:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002bf:	e8 cf 14 00 00       	call   801793 <sys_exit_env>
}
  8002c4:	90                   	nop
  8002c5:	c9                   	leave  
  8002c6:	c3                   	ret    

008002c7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002c7:	55                   	push   %ebp
  8002c8:	89 e5                	mov    %esp,%ebp
  8002ca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002cd:	8d 45 10             	lea    0x10(%ebp),%eax
  8002d0:	83 c0 04             	add    $0x4,%eax
  8002d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002d6:	a1 28 31 80 00       	mov    0x803128,%eax
  8002db:	85 c0                	test   %eax,%eax
  8002dd:	74 16                	je     8002f5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002df:	a1 28 31 80 00       	mov    0x803128,%eax
  8002e4:	83 ec 08             	sub    $0x8,%esp
  8002e7:	50                   	push   %eax
  8002e8:	68 f8 1e 80 00       	push   $0x801ef8
  8002ed:	e8 a3 02 00 00       	call   800595 <cprintf>
  8002f2:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8002f5:	a1 04 30 80 00       	mov    0x803004,%eax
  8002fa:	83 ec 0c             	sub    $0xc,%esp
  8002fd:	ff 75 0c             	pushl  0xc(%ebp)
  800300:	ff 75 08             	pushl  0x8(%ebp)
  800303:	50                   	push   %eax
  800304:	68 00 1f 80 00       	push   $0x801f00
  800309:	6a 74                	push   $0x74
  80030b:	e8 b2 02 00 00       	call   8005c2 <cprintf_colored>
  800310:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800313:	8b 45 10             	mov    0x10(%ebp),%eax
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	ff 75 f4             	pushl  -0xc(%ebp)
  80031c:	50                   	push   %eax
  80031d:	e8 04 02 00 00       	call   800526 <vcprintf>
  800322:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800325:	83 ec 08             	sub    $0x8,%esp
  800328:	6a 00                	push   $0x0
  80032a:	68 28 1f 80 00       	push   $0x801f28
  80032f:	e8 f2 01 00 00       	call   800526 <vcprintf>
  800334:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800337:	e8 7d ff ff ff       	call   8002b9 <exit>

	// should not return here
	while (1) ;
  80033c:	eb fe                	jmp    80033c <_panic+0x75>

0080033e <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80033e:	55                   	push   %ebp
  80033f:	89 e5                	mov    %esp,%ebp
  800341:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800344:	a1 20 30 80 00       	mov    0x803020,%eax
  800349:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80034f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800352:	39 c2                	cmp    %eax,%edx
  800354:	74 14                	je     80036a <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800356:	83 ec 04             	sub    $0x4,%esp
  800359:	68 2c 1f 80 00       	push   $0x801f2c
  80035e:	6a 26                	push   $0x26
  800360:	68 78 1f 80 00       	push   $0x801f78
  800365:	e8 5d ff ff ff       	call   8002c7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80036a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800371:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800378:	e9 c5 00 00 00       	jmp    800442 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80037d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 d0                	add    %edx,%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	85 c0                	test   %eax,%eax
  800390:	75 08                	jne    80039a <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800392:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800395:	e9 a5 00 00 00       	jmp    80043f <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80039a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003a8:	eb 69                	jmp    800413 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8003af:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003b5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003b8:	89 d0                	mov    %edx,%eax
  8003ba:	01 c0                	add    %eax,%eax
  8003bc:	01 d0                	add    %edx,%eax
  8003be:	c1 e0 03             	shl    $0x3,%eax
  8003c1:	01 c8                	add    %ecx,%eax
  8003c3:	8a 40 04             	mov    0x4(%eax),%al
  8003c6:	84 c0                	test   %al,%al
  8003c8:	75 46                	jne    800410 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cf:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003d5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003d8:	89 d0                	mov    %edx,%eax
  8003da:	01 c0                	add    %eax,%eax
  8003dc:	01 d0                	add    %edx,%eax
  8003de:	c1 e0 03             	shl    $0x3,%eax
  8003e1:	01 c8                	add    %ecx,%eax
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003e8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	01 c8                	add    %ecx,%eax
  800401:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800403:	39 c2                	cmp    %eax,%edx
  800405:	75 09                	jne    800410 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800407:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80040e:	eb 15                	jmp    800425 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800410:	ff 45 e8             	incl   -0x18(%ebp)
  800413:	a1 20 30 80 00       	mov    0x803020,%eax
  800418:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80041e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800421:	39 c2                	cmp    %eax,%edx
  800423:	77 85                	ja     8003aa <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800425:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800429:	75 14                	jne    80043f <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80042b:	83 ec 04             	sub    $0x4,%esp
  80042e:	68 84 1f 80 00       	push   $0x801f84
  800433:	6a 3a                	push   $0x3a
  800435:	68 78 1f 80 00       	push   $0x801f78
  80043a:	e8 88 fe ff ff       	call   8002c7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80043f:	ff 45 f0             	incl   -0x10(%ebp)
  800442:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800445:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800448:	0f 8c 2f ff ff ff    	jl     80037d <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80044e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800455:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80045c:	eb 26                	jmp    800484 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80045e:	a1 20 30 80 00       	mov    0x803020,%eax
  800463:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800469:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80046c:	89 d0                	mov    %edx,%eax
  80046e:	01 c0                	add    %eax,%eax
  800470:	01 d0                	add    %edx,%eax
  800472:	c1 e0 03             	shl    $0x3,%eax
  800475:	01 c8                	add    %ecx,%eax
  800477:	8a 40 04             	mov    0x4(%eax),%al
  80047a:	3c 01                	cmp    $0x1,%al
  80047c:	75 03                	jne    800481 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  80047e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800481:	ff 45 e0             	incl   -0x20(%ebp)
  800484:	a1 20 30 80 00       	mov    0x803020,%eax
  800489:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80048f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800492:	39 c2                	cmp    %eax,%edx
  800494:	77 c8                	ja     80045e <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800496:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800499:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80049c:	74 14                	je     8004b2 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  80049e:	83 ec 04             	sub    $0x4,%esp
  8004a1:	68 d8 1f 80 00       	push   $0x801fd8
  8004a6:	6a 44                	push   $0x44
  8004a8:	68 78 1f 80 00       	push   $0x801f78
  8004ad:	e8 15 fe ff ff       	call   8002c7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004b2:	90                   	nop
  8004b3:	c9                   	leave  
  8004b4:	c3                   	ret    

008004b5 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8004b5:	55                   	push   %ebp
  8004b6:	89 e5                	mov    %esp,%ebp
  8004b8:	53                   	push   %ebx
  8004b9:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8004bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bf:	8b 00                	mov    (%eax),%eax
  8004c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8004c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c7:	89 0a                	mov    %ecx,(%edx)
  8004c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8004cc:	88 d1                	mov    %dl,%cl
  8004ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d1:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d8:	8b 00                	mov    (%eax),%eax
  8004da:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004df:	75 30                	jne    800511 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8004e1:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8004e7:	a0 40 30 80 00       	mov    0x803040,%al
  8004ec:	0f b6 c0             	movzbl %al,%eax
  8004ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004f2:	8b 09                	mov    (%ecx),%ecx
  8004f4:	89 cb                	mov    %ecx,%ebx
  8004f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004f9:	83 c1 08             	add    $0x8,%ecx
  8004fc:	52                   	push   %edx
  8004fd:	50                   	push   %eax
  8004fe:	53                   	push   %ebx
  8004ff:	51                   	push   %ecx
  800500:	e8 a0 0f 00 00       	call   8014a5 <sys_cputs>
  800505:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800511:	8b 45 0c             	mov    0xc(%ebp),%eax
  800514:	8b 40 04             	mov    0x4(%eax),%eax
  800517:	8d 50 01             	lea    0x1(%eax),%edx
  80051a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800520:	90                   	nop
  800521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800524:	c9                   	leave  
  800525:	c3                   	ret    

00800526 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800526:	55                   	push   %ebp
  800527:	89 e5                	mov    %esp,%ebp
  800529:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80052f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800536:	00 00 00 
	b.cnt = 0;
  800539:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800540:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800543:	ff 75 0c             	pushl  0xc(%ebp)
  800546:	ff 75 08             	pushl  0x8(%ebp)
  800549:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80054f:	50                   	push   %eax
  800550:	68 b5 04 80 00       	push   $0x8004b5
  800555:	e8 5a 02 00 00       	call   8007b4 <vprintfmt>
  80055a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80055d:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800563:	a0 40 30 80 00       	mov    0x803040,%al
  800568:	0f b6 c0             	movzbl %al,%eax
  80056b:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800571:	52                   	push   %edx
  800572:	50                   	push   %eax
  800573:	51                   	push   %ecx
  800574:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80057a:	83 c0 08             	add    $0x8,%eax
  80057d:	50                   	push   %eax
  80057e:	e8 22 0f 00 00       	call   8014a5 <sys_cputs>
  800583:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800586:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  80058d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800593:	c9                   	leave  
  800594:	c3                   	ret    

00800595 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800595:	55                   	push   %ebp
  800596:	89 e5                	mov    %esp,%ebp
  800598:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80059b:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005a2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ab:	83 ec 08             	sub    $0x8,%esp
  8005ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b1:	50                   	push   %eax
  8005b2:	e8 6f ff ff ff       	call   800526 <vcprintf>
  8005b7:	83 c4 10             	add    $0x10,%esp
  8005ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005c0:	c9                   	leave  
  8005c1:	c3                   	ret    

008005c2 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8005c2:	55                   	push   %ebp
  8005c3:	89 e5                	mov    %esp,%ebp
  8005c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005c8:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	c1 e0 08             	shl    $0x8,%eax
  8005d5:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8005da:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005dd:	83 c0 04             	add    $0x4,%eax
  8005e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e6:	83 ec 08             	sub    $0x8,%esp
  8005e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ec:	50                   	push   %eax
  8005ed:	e8 34 ff ff ff       	call   800526 <vcprintf>
  8005f2:	83 c4 10             	add    $0x10,%esp
  8005f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8005f8:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  8005ff:	07 00 00 

	return cnt;
  800602:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800605:	c9                   	leave  
  800606:	c3                   	ret    

00800607 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800607:	55                   	push   %ebp
  800608:	89 e5                	mov    %esp,%ebp
  80060a:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80060d:	e8 d7 0e 00 00       	call   8014e9 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800612:	8d 45 0c             	lea    0xc(%ebp),%eax
  800615:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	83 ec 08             	sub    $0x8,%esp
  80061e:	ff 75 f4             	pushl  -0xc(%ebp)
  800621:	50                   	push   %eax
  800622:	e8 ff fe ff ff       	call   800526 <vcprintf>
  800627:	83 c4 10             	add    $0x10,%esp
  80062a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80062d:	e8 d1 0e 00 00       	call   801503 <sys_unlock_cons>
	return cnt;
  800632:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800635:	c9                   	leave  
  800636:	c3                   	ret    

00800637 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800637:	55                   	push   %ebp
  800638:	89 e5                	mov    %esp,%ebp
  80063a:	53                   	push   %ebx
  80063b:	83 ec 14             	sub    $0x14,%esp
  80063e:	8b 45 10             	mov    0x10(%ebp),%eax
  800641:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800644:	8b 45 14             	mov    0x14(%ebp),%eax
  800647:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80064a:	8b 45 18             	mov    0x18(%ebp),%eax
  80064d:	ba 00 00 00 00       	mov    $0x0,%edx
  800652:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800655:	77 55                	ja     8006ac <printnum+0x75>
  800657:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80065a:	72 05                	jb     800661 <printnum+0x2a>
  80065c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80065f:	77 4b                	ja     8006ac <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800661:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800664:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800667:	8b 45 18             	mov    0x18(%ebp),%eax
  80066a:	ba 00 00 00 00       	mov    $0x0,%edx
  80066f:	52                   	push   %edx
  800670:	50                   	push   %eax
  800671:	ff 75 f4             	pushl  -0xc(%ebp)
  800674:	ff 75 f0             	pushl  -0x10(%ebp)
  800677:	e8 74 13 00 00       	call   8019f0 <__udivdi3>
  80067c:	83 c4 10             	add    $0x10,%esp
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	ff 75 20             	pushl  0x20(%ebp)
  800685:	53                   	push   %ebx
  800686:	ff 75 18             	pushl  0x18(%ebp)
  800689:	52                   	push   %edx
  80068a:	50                   	push   %eax
  80068b:	ff 75 0c             	pushl  0xc(%ebp)
  80068e:	ff 75 08             	pushl  0x8(%ebp)
  800691:	e8 a1 ff ff ff       	call   800637 <printnum>
  800696:	83 c4 20             	add    $0x20,%esp
  800699:	eb 1a                	jmp    8006b5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80069b:	83 ec 08             	sub    $0x8,%esp
  80069e:	ff 75 0c             	pushl  0xc(%ebp)
  8006a1:	ff 75 20             	pushl  0x20(%ebp)
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	ff d0                	call   *%eax
  8006a9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006ac:	ff 4d 1c             	decl   0x1c(%ebp)
  8006af:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006b3:	7f e6                	jg     80069b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006b5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006b8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c3:	53                   	push   %ebx
  8006c4:	51                   	push   %ecx
  8006c5:	52                   	push   %edx
  8006c6:	50                   	push   %eax
  8006c7:	e8 34 14 00 00       	call   801b00 <__umoddi3>
  8006cc:	83 c4 10             	add    $0x10,%esp
  8006cf:	05 54 22 80 00       	add    $0x802254,%eax
  8006d4:	8a 00                	mov    (%eax),%al
  8006d6:	0f be c0             	movsbl %al,%eax
  8006d9:	83 ec 08             	sub    $0x8,%esp
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	50                   	push   %eax
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	ff d0                	call   *%eax
  8006e5:	83 c4 10             	add    $0x10,%esp
}
  8006e8:	90                   	nop
  8006e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006ec:	c9                   	leave  
  8006ed:	c3                   	ret    

008006ee <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006ee:	55                   	push   %ebp
  8006ef:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006f1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006f5:	7e 1c                	jle    800713 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	8d 50 08             	lea    0x8(%eax),%edx
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	89 10                	mov    %edx,(%eax)
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	83 e8 08             	sub    $0x8,%eax
  80070c:	8b 50 04             	mov    0x4(%eax),%edx
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	eb 40                	jmp    800753 <getuint+0x65>
	else if (lflag)
  800713:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800717:	74 1e                	je     800737 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	8b 00                	mov    (%eax),%eax
  80071e:	8d 50 04             	lea    0x4(%eax),%edx
  800721:	8b 45 08             	mov    0x8(%ebp),%eax
  800724:	89 10                	mov    %edx,(%eax)
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	8b 00                	mov    (%eax),%eax
  80072b:	83 e8 04             	sub    $0x4,%eax
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	ba 00 00 00 00       	mov    $0x0,%edx
  800735:	eb 1c                	jmp    800753 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	8d 50 04             	lea    0x4(%eax),%edx
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	89 10                	mov    %edx,(%eax)
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	83 e8 04             	sub    $0x4,%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800753:	5d                   	pop    %ebp
  800754:	c3                   	ret    

00800755 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800755:	55                   	push   %ebp
  800756:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800758:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80075c:	7e 1c                	jle    80077a <getint+0x25>
		return va_arg(*ap, long long);
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	8b 00                	mov    (%eax),%eax
  800763:	8d 50 08             	lea    0x8(%eax),%edx
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	89 10                	mov    %edx,(%eax)
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	8b 00                	mov    (%eax),%eax
  800770:	83 e8 08             	sub    $0x8,%eax
  800773:	8b 50 04             	mov    0x4(%eax),%edx
  800776:	8b 00                	mov    (%eax),%eax
  800778:	eb 38                	jmp    8007b2 <getint+0x5d>
	else if (lflag)
  80077a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80077e:	74 1a                	je     80079a <getint+0x45>
		return va_arg(*ap, long);
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	8d 50 04             	lea    0x4(%eax),%edx
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	89 10                	mov    %edx,(%eax)
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	83 e8 04             	sub    $0x4,%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	99                   	cltd   
  800798:	eb 18                	jmp    8007b2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	8d 50 04             	lea    0x4(%eax),%edx
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	89 10                	mov    %edx,(%eax)
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	8b 00                	mov    (%eax),%eax
  8007ac:	83 e8 04             	sub    $0x4,%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	99                   	cltd   
}
  8007b2:	5d                   	pop    %ebp
  8007b3:	c3                   	ret    

008007b4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007b4:	55                   	push   %ebp
  8007b5:	89 e5                	mov    %esp,%ebp
  8007b7:	56                   	push   %esi
  8007b8:	53                   	push   %ebx
  8007b9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007bc:	eb 17                	jmp    8007d5 <vprintfmt+0x21>
			if (ch == '\0')
  8007be:	85 db                	test   %ebx,%ebx
  8007c0:	0f 84 c1 03 00 00    	je     800b87 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8007c6:	83 ec 08             	sub    $0x8,%esp
  8007c9:	ff 75 0c             	pushl  0xc(%ebp)
  8007cc:	53                   	push   %ebx
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	ff d0                	call   *%eax
  8007d2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d8:	8d 50 01             	lea    0x1(%eax),%edx
  8007db:	89 55 10             	mov    %edx,0x10(%ebp)
  8007de:	8a 00                	mov    (%eax),%al
  8007e0:	0f b6 d8             	movzbl %al,%ebx
  8007e3:	83 fb 25             	cmp    $0x25,%ebx
  8007e6:	75 d6                	jne    8007be <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007e8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007ec:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007f3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800801:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800808:	8b 45 10             	mov    0x10(%ebp),%eax
  80080b:	8d 50 01             	lea    0x1(%eax),%edx
  80080e:	89 55 10             	mov    %edx,0x10(%ebp)
  800811:	8a 00                	mov    (%eax),%al
  800813:	0f b6 d8             	movzbl %al,%ebx
  800816:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800819:	83 f8 5b             	cmp    $0x5b,%eax
  80081c:	0f 87 3d 03 00 00    	ja     800b5f <vprintfmt+0x3ab>
  800822:	8b 04 85 78 22 80 00 	mov    0x802278(,%eax,4),%eax
  800829:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80082b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80082f:	eb d7                	jmp    800808 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800831:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800835:	eb d1                	jmp    800808 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800837:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80083e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800841:	89 d0                	mov    %edx,%eax
  800843:	c1 e0 02             	shl    $0x2,%eax
  800846:	01 d0                	add    %edx,%eax
  800848:	01 c0                	add    %eax,%eax
  80084a:	01 d8                	add    %ebx,%eax
  80084c:	83 e8 30             	sub    $0x30,%eax
  80084f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800852:	8b 45 10             	mov    0x10(%ebp),%eax
  800855:	8a 00                	mov    (%eax),%al
  800857:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80085a:	83 fb 2f             	cmp    $0x2f,%ebx
  80085d:	7e 3e                	jle    80089d <vprintfmt+0xe9>
  80085f:	83 fb 39             	cmp    $0x39,%ebx
  800862:	7f 39                	jg     80089d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800864:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800867:	eb d5                	jmp    80083e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800869:	8b 45 14             	mov    0x14(%ebp),%eax
  80086c:	83 c0 04             	add    $0x4,%eax
  80086f:	89 45 14             	mov    %eax,0x14(%ebp)
  800872:	8b 45 14             	mov    0x14(%ebp),%eax
  800875:	83 e8 04             	sub    $0x4,%eax
  800878:	8b 00                	mov    (%eax),%eax
  80087a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80087d:	eb 1f                	jmp    80089e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80087f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800883:	79 83                	jns    800808 <vprintfmt+0x54>
				width = 0;
  800885:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80088c:	e9 77 ff ff ff       	jmp    800808 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800891:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800898:	e9 6b ff ff ff       	jmp    800808 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80089d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80089e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008a2:	0f 89 60 ff ff ff    	jns    800808 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008ae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008b5:	e9 4e ff ff ff       	jmp    800808 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008ba:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008bd:	e9 46 ff ff ff       	jmp    800808 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c5:	83 c0 04             	add    $0x4,%eax
  8008c8:	89 45 14             	mov    %eax,0x14(%ebp)
  8008cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ce:	83 e8 04             	sub    $0x4,%eax
  8008d1:	8b 00                	mov    (%eax),%eax
  8008d3:	83 ec 08             	sub    $0x8,%esp
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	50                   	push   %eax
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	ff d0                	call   *%eax
  8008df:	83 c4 10             	add    $0x10,%esp
			break;
  8008e2:	e9 9b 02 00 00       	jmp    800b82 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ea:	83 c0 04             	add    $0x4,%eax
  8008ed:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f3:	83 e8 04             	sub    $0x4,%eax
  8008f6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008f8:	85 db                	test   %ebx,%ebx
  8008fa:	79 02                	jns    8008fe <vprintfmt+0x14a>
				err = -err;
  8008fc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008fe:	83 fb 64             	cmp    $0x64,%ebx
  800901:	7f 0b                	jg     80090e <vprintfmt+0x15a>
  800903:	8b 34 9d c0 20 80 00 	mov    0x8020c0(,%ebx,4),%esi
  80090a:	85 f6                	test   %esi,%esi
  80090c:	75 19                	jne    800927 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80090e:	53                   	push   %ebx
  80090f:	68 65 22 80 00       	push   $0x802265
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	ff 75 08             	pushl  0x8(%ebp)
  80091a:	e8 70 02 00 00       	call   800b8f <printfmt>
  80091f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800922:	e9 5b 02 00 00       	jmp    800b82 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800927:	56                   	push   %esi
  800928:	68 6e 22 80 00       	push   $0x80226e
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	ff 75 08             	pushl  0x8(%ebp)
  800933:	e8 57 02 00 00       	call   800b8f <printfmt>
  800938:	83 c4 10             	add    $0x10,%esp
			break;
  80093b:	e9 42 02 00 00       	jmp    800b82 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800940:	8b 45 14             	mov    0x14(%ebp),%eax
  800943:	83 c0 04             	add    $0x4,%eax
  800946:	89 45 14             	mov    %eax,0x14(%ebp)
  800949:	8b 45 14             	mov    0x14(%ebp),%eax
  80094c:	83 e8 04             	sub    $0x4,%eax
  80094f:	8b 30                	mov    (%eax),%esi
  800951:	85 f6                	test   %esi,%esi
  800953:	75 05                	jne    80095a <vprintfmt+0x1a6>
				p = "(null)";
  800955:	be 71 22 80 00       	mov    $0x802271,%esi
			if (width > 0 && padc != '-')
  80095a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80095e:	7e 6d                	jle    8009cd <vprintfmt+0x219>
  800960:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800964:	74 67                	je     8009cd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800966:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800969:	83 ec 08             	sub    $0x8,%esp
  80096c:	50                   	push   %eax
  80096d:	56                   	push   %esi
  80096e:	e8 1e 03 00 00       	call   800c91 <strnlen>
  800973:	83 c4 10             	add    $0x10,%esp
  800976:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800979:	eb 16                	jmp    800991 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80097b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80097f:	83 ec 08             	sub    $0x8,%esp
  800982:	ff 75 0c             	pushl  0xc(%ebp)
  800985:	50                   	push   %eax
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	ff d0                	call   *%eax
  80098b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80098e:	ff 4d e4             	decl   -0x1c(%ebp)
  800991:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800995:	7f e4                	jg     80097b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800997:	eb 34                	jmp    8009cd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800999:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80099d:	74 1c                	je     8009bb <vprintfmt+0x207>
  80099f:	83 fb 1f             	cmp    $0x1f,%ebx
  8009a2:	7e 05                	jle    8009a9 <vprintfmt+0x1f5>
  8009a4:	83 fb 7e             	cmp    $0x7e,%ebx
  8009a7:	7e 12                	jle    8009bb <vprintfmt+0x207>
					putch('?', putdat);
  8009a9:	83 ec 08             	sub    $0x8,%esp
  8009ac:	ff 75 0c             	pushl  0xc(%ebp)
  8009af:	6a 3f                	push   $0x3f
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	ff d0                	call   *%eax
  8009b6:	83 c4 10             	add    $0x10,%esp
  8009b9:	eb 0f                	jmp    8009ca <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 0c             	pushl  0xc(%ebp)
  8009c1:	53                   	push   %ebx
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	ff d0                	call   *%eax
  8009c7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009ca:	ff 4d e4             	decl   -0x1c(%ebp)
  8009cd:	89 f0                	mov    %esi,%eax
  8009cf:	8d 70 01             	lea    0x1(%eax),%esi
  8009d2:	8a 00                	mov    (%eax),%al
  8009d4:	0f be d8             	movsbl %al,%ebx
  8009d7:	85 db                	test   %ebx,%ebx
  8009d9:	74 24                	je     8009ff <vprintfmt+0x24b>
  8009db:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009df:	78 b8                	js     800999 <vprintfmt+0x1e5>
  8009e1:	ff 4d e0             	decl   -0x20(%ebp)
  8009e4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009e8:	79 af                	jns    800999 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009ea:	eb 13                	jmp    8009ff <vprintfmt+0x24b>
				putch(' ', putdat);
  8009ec:	83 ec 08             	sub    $0x8,%esp
  8009ef:	ff 75 0c             	pushl  0xc(%ebp)
  8009f2:	6a 20                	push   $0x20
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	ff d0                	call   *%eax
  8009f9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009fc:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a03:	7f e7                	jg     8009ec <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a05:	e9 78 01 00 00       	jmp    800b82 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a10:	8d 45 14             	lea    0x14(%ebp),%eax
  800a13:	50                   	push   %eax
  800a14:	e8 3c fd ff ff       	call   800755 <getint>
  800a19:	83 c4 10             	add    $0x10,%esp
  800a1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a28:	85 d2                	test   %edx,%edx
  800a2a:	79 23                	jns    800a4f <vprintfmt+0x29b>
				putch('-', putdat);
  800a2c:	83 ec 08             	sub    $0x8,%esp
  800a2f:	ff 75 0c             	pushl  0xc(%ebp)
  800a32:	6a 2d                	push   $0x2d
  800a34:	8b 45 08             	mov    0x8(%ebp),%eax
  800a37:	ff d0                	call   *%eax
  800a39:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a42:	f7 d8                	neg    %eax
  800a44:	83 d2 00             	adc    $0x0,%edx
  800a47:	f7 da                	neg    %edx
  800a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a4f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a56:	e9 bc 00 00 00       	jmp    800b17 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a61:	8d 45 14             	lea    0x14(%ebp),%eax
  800a64:	50                   	push   %eax
  800a65:	e8 84 fc ff ff       	call   8006ee <getuint>
  800a6a:	83 c4 10             	add    $0x10,%esp
  800a6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a73:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a7a:	e9 98 00 00 00       	jmp    800b17 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a7f:	83 ec 08             	sub    $0x8,%esp
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	6a 58                	push   $0x58
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	ff d0                	call   *%eax
  800a8c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a8f:	83 ec 08             	sub    $0x8,%esp
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	6a 58                	push   $0x58
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	ff d0                	call   *%eax
  800a9c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 0c             	pushl  0xc(%ebp)
  800aa5:	6a 58                	push   $0x58
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	ff d0                	call   *%eax
  800aac:	83 c4 10             	add    $0x10,%esp
			break;
  800aaf:	e9 ce 00 00 00       	jmp    800b82 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800ab4:	83 ec 08             	sub    $0x8,%esp
  800ab7:	ff 75 0c             	pushl  0xc(%ebp)
  800aba:	6a 30                	push   $0x30
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	ff d0                	call   *%eax
  800ac1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ac4:	83 ec 08             	sub    $0x8,%esp
  800ac7:	ff 75 0c             	pushl  0xc(%ebp)
  800aca:	6a 78                	push   $0x78
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	ff d0                	call   *%eax
  800ad1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ad4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad7:	83 c0 04             	add    $0x4,%eax
  800ada:	89 45 14             	mov    %eax,0x14(%ebp)
  800add:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae0:	83 e8 04             	sub    $0x4,%eax
  800ae3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ae5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800af6:	eb 1f                	jmp    800b17 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800af8:	83 ec 08             	sub    $0x8,%esp
  800afb:	ff 75 e8             	pushl  -0x18(%ebp)
  800afe:	8d 45 14             	lea    0x14(%ebp),%eax
  800b01:	50                   	push   %eax
  800b02:	e8 e7 fb ff ff       	call   8006ee <getuint>
  800b07:	83 c4 10             	add    $0x10,%esp
  800b0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b0d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b10:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b17:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b1e:	83 ec 04             	sub    $0x4,%esp
  800b21:	52                   	push   %edx
  800b22:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b25:	50                   	push   %eax
  800b26:	ff 75 f4             	pushl  -0xc(%ebp)
  800b29:	ff 75 f0             	pushl  -0x10(%ebp)
  800b2c:	ff 75 0c             	pushl  0xc(%ebp)
  800b2f:	ff 75 08             	pushl  0x8(%ebp)
  800b32:	e8 00 fb ff ff       	call   800637 <printnum>
  800b37:	83 c4 20             	add    $0x20,%esp
			break;
  800b3a:	eb 46                	jmp    800b82 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b3c:	83 ec 08             	sub    $0x8,%esp
  800b3f:	ff 75 0c             	pushl  0xc(%ebp)
  800b42:	53                   	push   %ebx
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	ff d0                	call   *%eax
  800b48:	83 c4 10             	add    $0x10,%esp
			break;
  800b4b:	eb 35                	jmp    800b82 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b4d:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800b54:	eb 2c                	jmp    800b82 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800b56:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800b5d:	eb 23                	jmp    800b82 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	6a 25                	push   $0x25
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	ff d0                	call   *%eax
  800b6c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b6f:	ff 4d 10             	decl   0x10(%ebp)
  800b72:	eb 03                	jmp    800b77 <vprintfmt+0x3c3>
  800b74:	ff 4d 10             	decl   0x10(%ebp)
  800b77:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7a:	48                   	dec    %eax
  800b7b:	8a 00                	mov    (%eax),%al
  800b7d:	3c 25                	cmp    $0x25,%al
  800b7f:	75 f3                	jne    800b74 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800b81:	90                   	nop
		}
	}
  800b82:	e9 35 fc ff ff       	jmp    8007bc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b87:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b88:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b8b:	5b                   	pop    %ebx
  800b8c:	5e                   	pop    %esi
  800b8d:	5d                   	pop    %ebp
  800b8e:	c3                   	ret    

00800b8f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b95:	8d 45 10             	lea    0x10(%ebp),%eax
  800b98:	83 c0 04             	add    $0x4,%eax
  800b9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba4:	50                   	push   %eax
  800ba5:	ff 75 0c             	pushl  0xc(%ebp)
  800ba8:	ff 75 08             	pushl  0x8(%ebp)
  800bab:	e8 04 fc ff ff       	call   8007b4 <vprintfmt>
  800bb0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bb3:	90                   	nop
  800bb4:	c9                   	leave  
  800bb5:	c3                   	ret    

00800bb6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbc:	8b 40 08             	mov    0x8(%eax),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcb:	8b 10                	mov    (%eax),%edx
  800bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd0:	8b 40 04             	mov    0x4(%eax),%eax
  800bd3:	39 c2                	cmp    %eax,%edx
  800bd5:	73 12                	jae    800be9 <sprintputch+0x33>
		*b->buf++ = ch;
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	8b 00                	mov    (%eax),%eax
  800bdc:	8d 48 01             	lea    0x1(%eax),%ecx
  800bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be2:	89 0a                	mov    %ecx,(%edx)
  800be4:	8b 55 08             	mov    0x8(%ebp),%edx
  800be7:	88 10                	mov    %dl,(%eax)
}
  800be9:	90                   	nop
  800bea:	5d                   	pop    %ebp
  800beb:	c3                   	ret    

00800bec <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bec:	55                   	push   %ebp
  800bed:	89 e5                	mov    %esp,%ebp
  800bef:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	01 d0                	add    %edx,%eax
  800c03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c11:	74 06                	je     800c19 <vsnprintf+0x2d>
  800c13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c17:	7f 07                	jg     800c20 <vsnprintf+0x34>
		return -E_INVAL;
  800c19:	b8 03 00 00 00       	mov    $0x3,%eax
  800c1e:	eb 20                	jmp    800c40 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c20:	ff 75 14             	pushl  0x14(%ebp)
  800c23:	ff 75 10             	pushl  0x10(%ebp)
  800c26:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c29:	50                   	push   %eax
  800c2a:	68 b6 0b 80 00       	push   $0x800bb6
  800c2f:	e8 80 fb ff ff       	call   8007b4 <vprintfmt>
  800c34:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c3a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
  800c45:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c48:	8d 45 10             	lea    0x10(%ebp),%eax
  800c4b:	83 c0 04             	add    $0x4,%eax
  800c4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c51:	8b 45 10             	mov    0x10(%ebp),%eax
  800c54:	ff 75 f4             	pushl  -0xc(%ebp)
  800c57:	50                   	push   %eax
  800c58:	ff 75 0c             	pushl  0xc(%ebp)
  800c5b:	ff 75 08             	pushl  0x8(%ebp)
  800c5e:	e8 89 ff ff ff       	call   800bec <vsnprintf>
  800c63:	83 c4 10             	add    $0x10,%esp
  800c66:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c7b:	eb 06                	jmp    800c83 <strlen+0x15>
		n++;
  800c7d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c80:	ff 45 08             	incl   0x8(%ebp)
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	84 c0                	test   %al,%al
  800c8a:	75 f1                	jne    800c7d <strlen+0xf>
		n++;
	return n;
  800c8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c9e:	eb 09                	jmp    800ca9 <strnlen+0x18>
		n++;
  800ca0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ca3:	ff 45 08             	incl   0x8(%ebp)
  800ca6:	ff 4d 0c             	decl   0xc(%ebp)
  800ca9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cad:	74 09                	je     800cb8 <strnlen+0x27>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	84 c0                	test   %al,%al
  800cb6:	75 e8                	jne    800ca0 <strnlen+0xf>
		n++;
	return n;
  800cb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cbb:	c9                   	leave  
  800cbc:	c3                   	ret    

00800cbd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
  800cc0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cc9:	90                   	nop
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8d 50 01             	lea    0x1(%eax),%edx
  800cd0:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cd9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cdc:	8a 12                	mov    (%edx),%dl
  800cde:	88 10                	mov    %dl,(%eax)
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	84 c0                	test   %al,%al
  800ce4:	75 e4                	jne    800cca <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ce6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cf7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cfe:	eb 1f                	jmp    800d1f <strncpy+0x34>
		*dst++ = *src;
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8d 50 01             	lea    0x1(%eax),%edx
  800d06:	89 55 08             	mov    %edx,0x8(%ebp)
  800d09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d0c:	8a 12                	mov    (%edx),%dl
  800d0e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	84 c0                	test   %al,%al
  800d17:	74 03                	je     800d1c <strncpy+0x31>
			src++;
  800d19:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d1c:	ff 45 fc             	incl   -0x4(%ebp)
  800d1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d22:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d25:	72 d9                	jb     800d00 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d27:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d2a:	c9                   	leave  
  800d2b:	c3                   	ret    

00800d2c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d2c:	55                   	push   %ebp
  800d2d:	89 e5                	mov    %esp,%ebp
  800d2f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d38:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3c:	74 30                	je     800d6e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d3e:	eb 16                	jmp    800d56 <strlcpy+0x2a>
			*dst++ = *src++;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
  800d43:	8d 50 01             	lea    0x1(%eax),%edx
  800d46:	89 55 08             	mov    %edx,0x8(%ebp)
  800d49:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d4f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d52:	8a 12                	mov    (%edx),%dl
  800d54:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d56:	ff 4d 10             	decl   0x10(%ebp)
  800d59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5d:	74 09                	je     800d68 <strlcpy+0x3c>
  800d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 d8                	jne    800d40 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d6e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d74:	29 c2                	sub    %eax,%edx
  800d76:	89 d0                	mov    %edx,%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d7d:	eb 06                	jmp    800d85 <strcmp+0xb>
		p++, q++;
  800d7f:	ff 45 08             	incl   0x8(%ebp)
  800d82:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	84 c0                	test   %al,%al
  800d8c:	74 0e                	je     800d9c <strcmp+0x22>
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8a 10                	mov    (%eax),%dl
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	38 c2                	cmp    %al,%dl
  800d9a:	74 e3                	je     800d7f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	0f b6 d0             	movzbl %al,%edx
  800da4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da7:	8a 00                	mov    (%eax),%al
  800da9:	0f b6 c0             	movzbl %al,%eax
  800dac:	29 c2                	sub    %eax,%edx
  800dae:	89 d0                	mov    %edx,%eax
}
  800db0:	5d                   	pop    %ebp
  800db1:	c3                   	ret    

00800db2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800db2:	55                   	push   %ebp
  800db3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800db5:	eb 09                	jmp    800dc0 <strncmp+0xe>
		n--, p++, q++;
  800db7:	ff 4d 10             	decl   0x10(%ebp)
  800dba:	ff 45 08             	incl   0x8(%ebp)
  800dbd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc4:	74 17                	je     800ddd <strncmp+0x2b>
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	84 c0                	test   %al,%al
  800dcd:	74 0e                	je     800ddd <strncmp+0x2b>
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8a 10                	mov    (%eax),%dl
  800dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	38 c2                	cmp    %al,%dl
  800ddb:	74 da                	je     800db7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ddd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de1:	75 07                	jne    800dea <strncmp+0x38>
		return 0;
  800de3:	b8 00 00 00 00       	mov    $0x0,%eax
  800de8:	eb 14                	jmp    800dfe <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	0f b6 d0             	movzbl %al,%edx
  800df2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	0f b6 c0             	movzbl %al,%eax
  800dfa:	29 c2                	sub    %eax,%edx
  800dfc:	89 d0                	mov    %edx,%eax
}
  800dfe:	5d                   	pop    %ebp
  800dff:	c3                   	ret    

00800e00 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 04             	sub    $0x4,%esp
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e0c:	eb 12                	jmp    800e20 <strchr+0x20>
		if (*s == c)
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e16:	75 05                	jne    800e1d <strchr+0x1d>
			return (char *) s;
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	eb 11                	jmp    800e2e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e1d:	ff 45 08             	incl   0x8(%ebp)
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	84 c0                	test   %al,%al
  800e27:	75 e5                	jne    800e0e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e29:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 04             	sub    $0x4,%esp
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e3c:	eb 0d                	jmp    800e4b <strfind+0x1b>
		if (*s == c)
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e46:	74 0e                	je     800e56 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e48:	ff 45 08             	incl   0x8(%ebp)
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	84 c0                	test   %al,%al
  800e52:	75 ea                	jne    800e3e <strfind+0xe>
  800e54:	eb 01                	jmp    800e57 <strfind+0x27>
		if (*s == c)
			break;
  800e56:	90                   	nop
	return (char *) s;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e5a:	c9                   	leave  
  800e5b:	c3                   	ret    

00800e5c <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800e5c:	55                   	push   %ebp
  800e5d:	89 e5                	mov    %esp,%ebp
  800e5f:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800e68:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800e6c:	76 63                	jbe    800ed1 <memset+0x75>
		uint64 data_block = c;
  800e6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e71:	99                   	cltd   
  800e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e75:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800e78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7e:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800e82:	c1 e0 08             	shl    $0x8,%eax
  800e85:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e88:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800e8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e91:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800e95:	c1 e0 10             	shl    $0x10,%eax
  800e98:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e9b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800e9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea4:	89 c2                	mov    %eax,%edx
  800ea6:	b8 00 00 00 00       	mov    $0x0,%eax
  800eab:	09 45 f0             	or     %eax,-0x10(%ebp)
  800eae:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800eb1:	eb 18                	jmp    800ecb <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800eb3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eb6:	8d 41 08             	lea    0x8(%ecx),%eax
  800eb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800ebc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ebf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec2:	89 01                	mov    %eax,(%ecx)
  800ec4:	89 51 04             	mov    %edx,0x4(%ecx)
  800ec7:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800ecb:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ecf:	77 e2                	ja     800eb3 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800ed1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed5:	74 23                	je     800efa <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eda:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800edd:	eb 0e                	jmp    800eed <memset+0x91>
			*p8++ = (uint8)c;
  800edf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee2:	8d 50 01             	lea    0x1(%eax),%edx
  800ee5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ee8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eeb:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800eed:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef6:	85 c0                	test   %eax,%eax
  800ef8:	75 e5                	jne    800edf <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f11:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f15:	76 24                	jbe    800f3b <memcpy+0x3c>
		while(n >= 8){
  800f17:	eb 1c                	jmp    800f35 <memcpy+0x36>
			*d64 = *s64;
  800f19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1c:	8b 50 04             	mov    0x4(%eax),%edx
  800f1f:	8b 00                	mov    (%eax),%eax
  800f21:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f24:	89 01                	mov    %eax,(%ecx)
  800f26:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f29:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f2d:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f31:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f35:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f39:	77 de                	ja     800f19 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3f:	74 31                	je     800f72 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f44:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f4d:	eb 16                	jmp    800f65 <memcpy+0x66>
			*d8++ = *s8++;
  800f4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f52:	8d 50 01             	lea    0x1(%eax),%edx
  800f55:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800f58:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f5e:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800f61:	8a 12                	mov    (%edx),%dl
  800f63:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800f65:	8b 45 10             	mov    0x10(%ebp),%eax
  800f68:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f6b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f6e:	85 c0                	test   %eax,%eax
  800f70:	75 dd                	jne    800f4f <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f75:	c9                   	leave  
  800f76:	c3                   	ret    

00800f77 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
  800f7a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f8f:	73 50                	jae    800fe1 <memmove+0x6a>
  800f91:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f94:	8b 45 10             	mov    0x10(%ebp),%eax
  800f97:	01 d0                	add    %edx,%eax
  800f99:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f9c:	76 43                	jbe    800fe1 <memmove+0x6a>
		s += n;
  800f9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fa4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800faa:	eb 10                	jmp    800fbc <memmove+0x45>
			*--d = *--s;
  800fac:	ff 4d f8             	decl   -0x8(%ebp)
  800faf:	ff 4d fc             	decl   -0x4(%ebp)
  800fb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb5:	8a 10                	mov    (%eax),%dl
  800fb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fba:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc5:	85 c0                	test   %eax,%eax
  800fc7:	75 e3                	jne    800fac <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fc9:	eb 23                	jmp    800fee <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fce:	8d 50 01             	lea    0x1(%eax),%edx
  800fd1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fda:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fdd:	8a 12                	mov    (%edx),%dl
  800fdf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fea:	85 c0                	test   %eax,%eax
  800fec:	75 dd                	jne    800fcb <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff1:	c9                   	leave  
  800ff2:	c3                   	ret    

00800ff3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ff3:	55                   	push   %ebp
  800ff4:	89 e5                	mov    %esp,%ebp
  800ff6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801002:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801005:	eb 2a                	jmp    801031 <memcmp+0x3e>
		if (*s1 != *s2)
  801007:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100a:	8a 10                	mov    (%eax),%dl
  80100c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100f:	8a 00                	mov    (%eax),%al
  801011:	38 c2                	cmp    %al,%dl
  801013:	74 16                	je     80102b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801015:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	0f b6 d0             	movzbl %al,%edx
  80101d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	0f b6 c0             	movzbl %al,%eax
  801025:	29 c2                	sub    %eax,%edx
  801027:	89 d0                	mov    %edx,%eax
  801029:	eb 18                	jmp    801043 <memcmp+0x50>
		s1++, s2++;
  80102b:	ff 45 fc             	incl   -0x4(%ebp)
  80102e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801031:	8b 45 10             	mov    0x10(%ebp),%eax
  801034:	8d 50 ff             	lea    -0x1(%eax),%edx
  801037:	89 55 10             	mov    %edx,0x10(%ebp)
  80103a:	85 c0                	test   %eax,%eax
  80103c:	75 c9                	jne    801007 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80103e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801043:	c9                   	leave  
  801044:	c3                   	ret    

00801045 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801045:	55                   	push   %ebp
  801046:	89 e5                	mov    %esp,%ebp
  801048:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80104b:	8b 55 08             	mov    0x8(%ebp),%edx
  80104e:	8b 45 10             	mov    0x10(%ebp),%eax
  801051:	01 d0                	add    %edx,%eax
  801053:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801056:	eb 15                	jmp    80106d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	0f b6 d0             	movzbl %al,%edx
  801060:	8b 45 0c             	mov    0xc(%ebp),%eax
  801063:	0f b6 c0             	movzbl %al,%eax
  801066:	39 c2                	cmp    %eax,%edx
  801068:	74 0d                	je     801077 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80106a:	ff 45 08             	incl   0x8(%ebp)
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801073:	72 e3                	jb     801058 <memfind+0x13>
  801075:	eb 01                	jmp    801078 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801077:	90                   	nop
	return (void *) s;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801083:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80108a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801091:	eb 03                	jmp    801096 <strtol+0x19>
		s++;
  801093:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	8a 00                	mov    (%eax),%al
  80109b:	3c 20                	cmp    $0x20,%al
  80109d:	74 f4                	je     801093 <strtol+0x16>
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	3c 09                	cmp    $0x9,%al
  8010a6:	74 eb                	je     801093 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	3c 2b                	cmp    $0x2b,%al
  8010af:	75 05                	jne    8010b6 <strtol+0x39>
		s++;
  8010b1:	ff 45 08             	incl   0x8(%ebp)
  8010b4:	eb 13                	jmp    8010c9 <strtol+0x4c>
	else if (*s == '-')
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	8a 00                	mov    (%eax),%al
  8010bb:	3c 2d                	cmp    $0x2d,%al
  8010bd:	75 0a                	jne    8010c9 <strtol+0x4c>
		s++, neg = 1;
  8010bf:	ff 45 08             	incl   0x8(%ebp)
  8010c2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010cd:	74 06                	je     8010d5 <strtol+0x58>
  8010cf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010d3:	75 20                	jne    8010f5 <strtol+0x78>
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	8a 00                	mov    (%eax),%al
  8010da:	3c 30                	cmp    $0x30,%al
  8010dc:	75 17                	jne    8010f5 <strtol+0x78>
  8010de:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e1:	40                   	inc    %eax
  8010e2:	8a 00                	mov    (%eax),%al
  8010e4:	3c 78                	cmp    $0x78,%al
  8010e6:	75 0d                	jne    8010f5 <strtol+0x78>
		s += 2, base = 16;
  8010e8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010ec:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010f3:	eb 28                	jmp    80111d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f9:	75 15                	jne    801110 <strtol+0x93>
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	3c 30                	cmp    $0x30,%al
  801102:	75 0c                	jne    801110 <strtol+0x93>
		s++, base = 8;
  801104:	ff 45 08             	incl   0x8(%ebp)
  801107:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80110e:	eb 0d                	jmp    80111d <strtol+0xa0>
	else if (base == 0)
  801110:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801114:	75 07                	jne    80111d <strtol+0xa0>
		base = 10;
  801116:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	3c 2f                	cmp    $0x2f,%al
  801124:	7e 19                	jle    80113f <strtol+0xc2>
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 39                	cmp    $0x39,%al
  80112d:	7f 10                	jg     80113f <strtol+0xc2>
			dig = *s - '0';
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	0f be c0             	movsbl %al,%eax
  801137:	83 e8 30             	sub    $0x30,%eax
  80113a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80113d:	eb 42                	jmp    801181 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	3c 60                	cmp    $0x60,%al
  801146:	7e 19                	jle    801161 <strtol+0xe4>
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 7a                	cmp    $0x7a,%al
  80114f:	7f 10                	jg     801161 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f be c0             	movsbl %al,%eax
  801159:	83 e8 57             	sub    $0x57,%eax
  80115c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80115f:	eb 20                	jmp    801181 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	3c 40                	cmp    $0x40,%al
  801168:	7e 39                	jle    8011a3 <strtol+0x126>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 5a                	cmp    $0x5a,%al
  801171:	7f 30                	jg     8011a3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	0f be c0             	movsbl %al,%eax
  80117b:	83 e8 37             	sub    $0x37,%eax
  80117e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801181:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801184:	3b 45 10             	cmp    0x10(%ebp),%eax
  801187:	7d 19                	jge    8011a2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801189:	ff 45 08             	incl   0x8(%ebp)
  80118c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801193:	89 c2                	mov    %eax,%edx
  801195:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801198:	01 d0                	add    %edx,%eax
  80119a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80119d:	e9 7b ff ff ff       	jmp    80111d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011a2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011a7:	74 08                	je     8011b1 <strtol+0x134>
		*endptr = (char *) s;
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8011af:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011b5:	74 07                	je     8011be <strtol+0x141>
  8011b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ba:	f7 d8                	neg    %eax
  8011bc:	eb 03                	jmp    8011c1 <strtol+0x144>
  8011be:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <ltostr>:

void
ltostr(long value, char *str)
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
  8011c6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011db:	79 13                	jns    8011f0 <ltostr+0x2d>
	{
		neg = 1;
  8011dd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011ea:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011ed:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011f8:	99                   	cltd   
  8011f9:	f7 f9                	idiv   %ecx
  8011fb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801201:	8d 50 01             	lea    0x1(%eax),%edx
  801204:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801207:	89 c2                	mov    %eax,%edx
  801209:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120c:	01 d0                	add    %edx,%eax
  80120e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801211:	83 c2 30             	add    $0x30,%edx
  801214:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801216:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801219:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80121e:	f7 e9                	imul   %ecx
  801220:	c1 fa 02             	sar    $0x2,%edx
  801223:	89 c8                	mov    %ecx,%eax
  801225:	c1 f8 1f             	sar    $0x1f,%eax
  801228:	29 c2                	sub    %eax,%edx
  80122a:	89 d0                	mov    %edx,%eax
  80122c:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80122f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801233:	75 bb                	jne    8011f0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801235:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80123c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123f:	48                   	dec    %eax
  801240:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801243:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801247:	74 3d                	je     801286 <ltostr+0xc3>
		start = 1 ;
  801249:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801250:	eb 34                	jmp    801286 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801252:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801255:	8b 45 0c             	mov    0xc(%ebp),%eax
  801258:	01 d0                	add    %edx,%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80125f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801262:	8b 45 0c             	mov    0xc(%ebp),%eax
  801265:	01 c2                	add    %eax,%edx
  801267:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80126a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126d:	01 c8                	add    %ecx,%eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801273:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801276:	8b 45 0c             	mov    0xc(%ebp),%eax
  801279:	01 c2                	add    %eax,%edx
  80127b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80127e:	88 02                	mov    %al,(%edx)
		start++ ;
  801280:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801283:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801286:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801289:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80128c:	7c c4                	jl     801252 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80128e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	01 d0                	add    %edx,%eax
  801296:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801299:	90                   	nop
  80129a:	c9                   	leave  
  80129b:	c3                   	ret    

0080129c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80129c:	55                   	push   %ebp
  80129d:	89 e5                	mov    %esp,%ebp
  80129f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012a2:	ff 75 08             	pushl  0x8(%ebp)
  8012a5:	e8 c4 f9 ff ff       	call   800c6e <strlen>
  8012aa:	83 c4 04             	add    $0x4,%esp
  8012ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012b0:	ff 75 0c             	pushl  0xc(%ebp)
  8012b3:	e8 b6 f9 ff ff       	call   800c6e <strlen>
  8012b8:	83 c4 04             	add    $0x4,%esp
  8012bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012cc:	eb 17                	jmp    8012e5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d4:	01 c2                	add    %eax,%edx
  8012d6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	01 c8                	add    %ecx,%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012e2:	ff 45 fc             	incl   -0x4(%ebp)
  8012e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012eb:	7c e1                	jl     8012ce <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012f4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012fb:	eb 1f                	jmp    80131c <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801300:	8d 50 01             	lea    0x1(%eax),%edx
  801303:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801306:	89 c2                	mov    %eax,%edx
  801308:	8b 45 10             	mov    0x10(%ebp),%eax
  80130b:	01 c2                	add    %eax,%edx
  80130d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801310:	8b 45 0c             	mov    0xc(%ebp),%eax
  801313:	01 c8                	add    %ecx,%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801319:	ff 45 f8             	incl   -0x8(%ebp)
  80131c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80131f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801322:	7c d9                	jl     8012fd <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801324:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801327:	8b 45 10             	mov    0x10(%ebp),%eax
  80132a:	01 d0                	add    %edx,%eax
  80132c:	c6 00 00             	movb   $0x0,(%eax)
}
  80132f:	90                   	nop
  801330:	c9                   	leave  
  801331:	c3                   	ret    

00801332 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801332:	55                   	push   %ebp
  801333:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801335:	8b 45 14             	mov    0x14(%ebp),%eax
  801338:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80133e:	8b 45 14             	mov    0x14(%ebp),%eax
  801341:	8b 00                	mov    (%eax),%eax
  801343:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80134a:	8b 45 10             	mov    0x10(%ebp),%eax
  80134d:	01 d0                	add    %edx,%eax
  80134f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801355:	eb 0c                	jmp    801363 <strsplit+0x31>
			*string++ = 0;
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8d 50 01             	lea    0x1(%eax),%edx
  80135d:	89 55 08             	mov    %edx,0x8(%ebp)
  801360:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	8a 00                	mov    (%eax),%al
  801368:	84 c0                	test   %al,%al
  80136a:	74 18                	je     801384 <strsplit+0x52>
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	0f be c0             	movsbl %al,%eax
  801374:	50                   	push   %eax
  801375:	ff 75 0c             	pushl  0xc(%ebp)
  801378:	e8 83 fa ff ff       	call   800e00 <strchr>
  80137d:	83 c4 08             	add    $0x8,%esp
  801380:	85 c0                	test   %eax,%eax
  801382:	75 d3                	jne    801357 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	84 c0                	test   %al,%al
  80138b:	74 5a                	je     8013e7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80138d:	8b 45 14             	mov    0x14(%ebp),%eax
  801390:	8b 00                	mov    (%eax),%eax
  801392:	83 f8 0f             	cmp    $0xf,%eax
  801395:	75 07                	jne    80139e <strsplit+0x6c>
		{
			return 0;
  801397:	b8 00 00 00 00       	mov    $0x0,%eax
  80139c:	eb 66                	jmp    801404 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80139e:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a1:	8b 00                	mov    (%eax),%eax
  8013a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8013a6:	8b 55 14             	mov    0x14(%ebp),%edx
  8013a9:	89 0a                	mov    %ecx,(%edx)
  8013ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b5:	01 c2                	add    %eax,%edx
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013bc:	eb 03                	jmp    8013c1 <strsplit+0x8f>
			string++;
  8013be:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	84 c0                	test   %al,%al
  8013c8:	74 8b                	je     801355 <strsplit+0x23>
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	0f be c0             	movsbl %al,%eax
  8013d2:	50                   	push   %eax
  8013d3:	ff 75 0c             	pushl  0xc(%ebp)
  8013d6:	e8 25 fa ff ff       	call   800e00 <strchr>
  8013db:	83 c4 08             	add    $0x8,%esp
  8013de:	85 c0                	test   %eax,%eax
  8013e0:	74 dc                	je     8013be <strsplit+0x8c>
			string++;
	}
  8013e2:	e9 6e ff ff ff       	jmp    801355 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013e7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013eb:	8b 00                	mov    (%eax),%eax
  8013ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013ff:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
  801409:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801412:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801419:	eb 4a                	jmp    801465 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80141b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	01 c2                	add    %eax,%edx
  801423:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801426:	8b 45 0c             	mov    0xc(%ebp),%eax
  801429:	01 c8                	add    %ecx,%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80142f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801432:	8b 45 0c             	mov    0xc(%ebp),%eax
  801435:	01 d0                	add    %edx,%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	3c 40                	cmp    $0x40,%al
  80143b:	7e 25                	jle    801462 <str2lower+0x5c>
  80143d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801440:	8b 45 0c             	mov    0xc(%ebp),%eax
  801443:	01 d0                	add    %edx,%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	3c 5a                	cmp    $0x5a,%al
  801449:	7f 17                	jg     801462 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80144b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	01 d0                	add    %edx,%eax
  801453:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801456:	8b 55 08             	mov    0x8(%ebp),%edx
  801459:	01 ca                	add    %ecx,%edx
  80145b:	8a 12                	mov    (%edx),%dl
  80145d:	83 c2 20             	add    $0x20,%edx
  801460:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801462:	ff 45 fc             	incl   -0x4(%ebp)
  801465:	ff 75 0c             	pushl  0xc(%ebp)
  801468:	e8 01 f8 ff ff       	call   800c6e <strlen>
  80146d:	83 c4 04             	add    $0x4,%esp
  801470:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801473:	7f a6                	jg     80141b <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801475:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	57                   	push   %edi
  80147e:	56                   	push   %esi
  80147f:	53                   	push   %ebx
  801480:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8b 55 0c             	mov    0xc(%ebp),%edx
  801489:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80148c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80148f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801492:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801495:	cd 30                	int    $0x30
  801497:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80149a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80149d:	83 c4 10             	add    $0x10,%esp
  8014a0:	5b                   	pop    %ebx
  8014a1:	5e                   	pop    %esi
  8014a2:	5f                   	pop    %edi
  8014a3:	5d                   	pop    %ebp
  8014a4:	c3                   	ret    

008014a5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 04             	sub    $0x4,%esp
  8014ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8014b1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014b4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	6a 00                	push   $0x0
  8014bd:	51                   	push   %ecx
  8014be:	52                   	push   %edx
  8014bf:	ff 75 0c             	pushl  0xc(%ebp)
  8014c2:	50                   	push   %eax
  8014c3:	6a 00                	push   $0x0
  8014c5:	e8 b0 ff ff ff       	call   80147a <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
}
  8014cd:	90                   	nop
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 02                	push   $0x2
  8014df:	e8 96 ff ff ff       	call   80147a <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 03                	push   $0x3
  8014f8:	e8 7d ff ff ff       	call   80147a <syscall>
  8014fd:	83 c4 18             	add    $0x18,%esp
}
  801500:	90                   	nop
  801501:	c9                   	leave  
  801502:	c3                   	ret    

00801503 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801503:	55                   	push   %ebp
  801504:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 04                	push   $0x4
  801512:	e8 63 ff ff ff       	call   80147a <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	90                   	nop
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801520:	8b 55 0c             	mov    0xc(%ebp),%edx
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	52                   	push   %edx
  80152d:	50                   	push   %eax
  80152e:	6a 08                	push   $0x8
  801530:	e8 45 ff ff ff       	call   80147a <syscall>
  801535:	83 c4 18             	add    $0x18,%esp
}
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
  80153d:	56                   	push   %esi
  80153e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80153f:	8b 75 18             	mov    0x18(%ebp),%esi
  801542:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801545:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	56                   	push   %esi
  80154f:	53                   	push   %ebx
  801550:	51                   	push   %ecx
  801551:	52                   	push   %edx
  801552:	50                   	push   %eax
  801553:	6a 09                	push   $0x9
  801555:	e8 20 ff ff ff       	call   80147a <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
}
  80155d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801560:	5b                   	pop    %ebx
  801561:	5e                   	pop    %esi
  801562:	5d                   	pop    %ebp
  801563:	c3                   	ret    

00801564 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	ff 75 08             	pushl  0x8(%ebp)
  801572:	6a 0a                	push   $0xa
  801574:	e8 01 ff ff ff       	call   80147a <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	ff 75 0c             	pushl  0xc(%ebp)
  80158a:	ff 75 08             	pushl  0x8(%ebp)
  80158d:	6a 0b                	push   $0xb
  80158f:	e8 e6 fe ff ff       	call   80147a <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
}
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 0c                	push   $0xc
  8015a8:	e8 cd fe ff ff       	call   80147a <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 0d                	push   $0xd
  8015c1:	e8 b4 fe ff ff       	call   80147a <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 0e                	push   $0xe
  8015da:	e8 9b fe ff ff       	call   80147a <syscall>
  8015df:	83 c4 18             	add    $0x18,%esp
}
  8015e2:	c9                   	leave  
  8015e3:	c3                   	ret    

008015e4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 0f                	push   $0xf
  8015f3:	e8 82 fe ff ff       	call   80147a <syscall>
  8015f8:	83 c4 18             	add    $0x18,%esp
}
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	ff 75 08             	pushl  0x8(%ebp)
  80160b:	6a 10                	push   $0x10
  80160d:	e8 68 fe ff ff       	call   80147a <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 11                	push   $0x11
  801626:	e8 4f fe ff ff       	call   80147a <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
}
  80162e:	90                   	nop
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <sys_cputc>:

void
sys_cputc(const char c)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
  801634:	83 ec 04             	sub    $0x4,%esp
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80163d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	50                   	push   %eax
  80164a:	6a 01                	push   $0x1
  80164c:	e8 29 fe ff ff       	call   80147a <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	90                   	nop
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 14                	push   $0x14
  801666:	e8 0f fe ff ff       	call   80147a <syscall>
  80166b:	83 c4 18             	add    $0x18,%esp
}
  80166e:	90                   	nop
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
  801674:	83 ec 04             	sub    $0x4,%esp
  801677:	8b 45 10             	mov    0x10(%ebp),%eax
  80167a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80167d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801680:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	6a 00                	push   $0x0
  801689:	51                   	push   %ecx
  80168a:	52                   	push   %edx
  80168b:	ff 75 0c             	pushl  0xc(%ebp)
  80168e:	50                   	push   %eax
  80168f:	6a 15                	push   $0x15
  801691:	e8 e4 fd ff ff       	call   80147a <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80169e:	8b 55 10             	mov    0x10(%ebp),%edx
  8016a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	52                   	push   %edx
  8016a9:	50                   	push   %eax
  8016aa:	ff 75 08             	pushl  0x8(%ebp)
  8016ad:	6a 16                	push   $0x16
  8016af:	e8 c6 fd ff ff       	call   80147a <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
}
  8016b7:	c9                   	leave  
  8016b8:	c3                   	ret    

008016b9 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	52                   	push   %edx
  8016c9:	50                   	push   %eax
  8016ca:	6a 17                	push   $0x17
  8016cc:	e8 a9 fd ff ff       	call   80147a <syscall>
  8016d1:	83 c4 18             	add    $0x18,%esp
}
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	52                   	push   %edx
  8016e6:	50                   	push   %eax
  8016e7:	6a 18                	push   $0x18
  8016e9:	e8 8c fd ff ff       	call   80147a <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	ff 75 14             	pushl  0x14(%ebp)
  8016fe:	ff 75 10             	pushl  0x10(%ebp)
  801701:	ff 75 0c             	pushl  0xc(%ebp)
  801704:	50                   	push   %eax
  801705:	6a 19                	push   $0x19
  801707:	e8 6e fd ff ff       	call   80147a <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	50                   	push   %eax
  801720:	6a 1a                	push   $0x1a
  801722:	e8 53 fd ff ff       	call   80147a <syscall>
  801727:	83 c4 18             	add    $0x18,%esp
}
  80172a:	90                   	nop
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	50                   	push   %eax
  80173c:	6a 1b                	push   $0x1b
  80173e:	e8 37 fd ff ff       	call   80147a <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 05                	push   $0x5
  801757:	e8 1e fd ff ff       	call   80147a <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
}
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 06                	push   $0x6
  801770:	e8 05 fd ff ff       	call   80147a <syscall>
  801775:	83 c4 18             	add    $0x18,%esp
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 07                	push   $0x7
  801789:	e8 ec fc ff ff       	call   80147a <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_exit_env>:


void sys_exit_env(void)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 1c                	push   $0x1c
  8017a2:	e8 d3 fc ff ff       	call   80147a <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
}
  8017aa:	90                   	nop
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	ff 75 10             	pushl  0x10(%ebp)
  8017b7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ba:	ff 75 08             	pushl  0x8(%ebp)
  8017bd:	6a 13                	push   $0x13
  8017bf:	e8 b6 fc ff ff       	call   80147a <syscall>
  8017c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c7:	90                   	nop
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <sys_rcr2>:
uint32 sys_rcr2()
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 1e                	push   $0x1e
  8017d9:	e8 9c fc ff ff       	call   80147a <syscall>
  8017de:	83 c4 18             	add    $0x18,%esp
}
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
  8017e6:	83 ec 04             	sub    $0x4,%esp
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ef:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	50                   	push   %eax
  8017fc:	6a 1f                	push   $0x1f
  8017fe:	e8 77 fc ff ff       	call   80147a <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
	return ;
  801806:	90                   	nop
}
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <rsttst>:
void rsttst()
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 21                	push   $0x21
  801818:	e8 5d fc ff ff       	call   80147a <syscall>
  80181d:	83 c4 18             	add    $0x18,%esp
	return ;
  801820:	90                   	nop
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
  801826:	83 ec 04             	sub    $0x4,%esp
  801829:	8b 45 14             	mov    0x14(%ebp),%eax
  80182c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80182f:	8b 55 18             	mov    0x18(%ebp),%edx
  801832:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801836:	52                   	push   %edx
  801837:	50                   	push   %eax
  801838:	ff 75 10             	pushl  0x10(%ebp)
  80183b:	ff 75 0c             	pushl  0xc(%ebp)
  80183e:	ff 75 08             	pushl  0x8(%ebp)
  801841:	6a 20                	push   $0x20
  801843:	e8 32 fc ff ff       	call   80147a <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
	return ;
  80184b:	90                   	nop
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <chktst>:
void chktst(uint32 n)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	ff 75 08             	pushl  0x8(%ebp)
  80185c:	6a 22                	push   $0x22
  80185e:	e8 17 fc ff ff       	call   80147a <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
	return ;
  801866:	90                   	nop
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <inctst>:

void inctst()
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 23                	push   $0x23
  801878:	e8 fd fb ff ff       	call   80147a <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
	return ;
  801880:	90                   	nop
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <gettst>:
uint32 gettst()
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 24                	push   $0x24
  801892:	e8 e3 fb ff ff       	call   80147a <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 25                	push   $0x25
  8018ab:	e8 ca fb ff ff       	call   80147a <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
  8018b3:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018b8:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8018c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c5:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	ff 75 08             	pushl  0x8(%ebp)
  8018d5:	6a 26                	push   $0x26
  8018d7:	e8 9e fb ff ff       	call   80147a <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8018df:	90                   	nop
}
  8018e0:	c9                   	leave  
  8018e1:	c3                   	ret    

008018e2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
  8018e5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018e6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f2:	6a 00                	push   $0x0
  8018f4:	53                   	push   %ebx
  8018f5:	51                   	push   %ecx
  8018f6:	52                   	push   %edx
  8018f7:	50                   	push   %eax
  8018f8:	6a 27                	push   $0x27
  8018fa:	e8 7b fb ff ff       	call   80147a <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80190a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	52                   	push   %edx
  801917:	50                   	push   %eax
  801918:	6a 28                	push   $0x28
  80191a:	e8 5b fb ff ff       	call   80147a <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801927:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80192a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192d:	8b 45 08             	mov    0x8(%ebp),%eax
  801930:	6a 00                	push   $0x0
  801932:	51                   	push   %ecx
  801933:	ff 75 10             	pushl  0x10(%ebp)
  801936:	52                   	push   %edx
  801937:	50                   	push   %eax
  801938:	6a 29                	push   $0x29
  80193a:	e8 3b fb ff ff       	call   80147a <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	ff 75 10             	pushl  0x10(%ebp)
  80194e:	ff 75 0c             	pushl  0xc(%ebp)
  801951:	ff 75 08             	pushl  0x8(%ebp)
  801954:	6a 12                	push   $0x12
  801956:	e8 1f fb ff ff       	call   80147a <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
	return ;
  80195e:	90                   	nop
}
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801964:	8b 55 0c             	mov    0xc(%ebp),%edx
  801967:	8b 45 08             	mov    0x8(%ebp),%eax
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	52                   	push   %edx
  801971:	50                   	push   %eax
  801972:	6a 2a                	push   $0x2a
  801974:	e8 01 fb ff ff       	call   80147a <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
	return;
  80197c:	90                   	nop
}
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 2b                	push   $0x2b
  80198e:	e8 e7 fa ff ff       	call   80147a <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80199e:	83 ec 04             	sub    $0x4,%esp
  8019a1:	68 e8 23 80 00       	push   $0x8023e8
  8019a6:	68 0a 01 00 00       	push   $0x10a
  8019ab:	68 f8 23 80 00       	push   $0x8023f8
  8019b0:	e8 12 e9 ff ff       	call   8002c7 <_panic>

008019b5 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	ff 75 0c             	pushl  0xc(%ebp)
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	6a 33                	push   $0x33
  8019c6:	e8 af fa ff ff       	call   80147a <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
	return;
  8019ce:	90                   	nop
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	ff 75 0c             	pushl  0xc(%ebp)
  8019dd:	ff 75 08             	pushl  0x8(%ebp)
  8019e0:	6a 34                	push   $0x34
  8019e2:	e8 93 fa ff ff       	call   80147a <syscall>
  8019e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ea:	90                   	nop
}
  8019eb:	c9                   	leave  
  8019ec:	c3                   	ret    
  8019ed:	66 90                	xchg   %ax,%ax
  8019ef:	90                   	nop

008019f0 <__udivdi3>:
  8019f0:	55                   	push   %ebp
  8019f1:	57                   	push   %edi
  8019f2:	56                   	push   %esi
  8019f3:	53                   	push   %ebx
  8019f4:	83 ec 1c             	sub    $0x1c,%esp
  8019f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a03:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a07:	89 ca                	mov    %ecx,%edx
  801a09:	89 f8                	mov    %edi,%eax
  801a0b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a0f:	85 f6                	test   %esi,%esi
  801a11:	75 2d                	jne    801a40 <__udivdi3+0x50>
  801a13:	39 cf                	cmp    %ecx,%edi
  801a15:	77 65                	ja     801a7c <__udivdi3+0x8c>
  801a17:	89 fd                	mov    %edi,%ebp
  801a19:	85 ff                	test   %edi,%edi
  801a1b:	75 0b                	jne    801a28 <__udivdi3+0x38>
  801a1d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a22:	31 d2                	xor    %edx,%edx
  801a24:	f7 f7                	div    %edi
  801a26:	89 c5                	mov    %eax,%ebp
  801a28:	31 d2                	xor    %edx,%edx
  801a2a:	89 c8                	mov    %ecx,%eax
  801a2c:	f7 f5                	div    %ebp
  801a2e:	89 c1                	mov    %eax,%ecx
  801a30:	89 d8                	mov    %ebx,%eax
  801a32:	f7 f5                	div    %ebp
  801a34:	89 cf                	mov    %ecx,%edi
  801a36:	89 fa                	mov    %edi,%edx
  801a38:	83 c4 1c             	add    $0x1c,%esp
  801a3b:	5b                   	pop    %ebx
  801a3c:	5e                   	pop    %esi
  801a3d:	5f                   	pop    %edi
  801a3e:	5d                   	pop    %ebp
  801a3f:	c3                   	ret    
  801a40:	39 ce                	cmp    %ecx,%esi
  801a42:	77 28                	ja     801a6c <__udivdi3+0x7c>
  801a44:	0f bd fe             	bsr    %esi,%edi
  801a47:	83 f7 1f             	xor    $0x1f,%edi
  801a4a:	75 40                	jne    801a8c <__udivdi3+0x9c>
  801a4c:	39 ce                	cmp    %ecx,%esi
  801a4e:	72 0a                	jb     801a5a <__udivdi3+0x6a>
  801a50:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a54:	0f 87 9e 00 00 00    	ja     801af8 <__udivdi3+0x108>
  801a5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5f:	89 fa                	mov    %edi,%edx
  801a61:	83 c4 1c             	add    $0x1c,%esp
  801a64:	5b                   	pop    %ebx
  801a65:	5e                   	pop    %esi
  801a66:	5f                   	pop    %edi
  801a67:	5d                   	pop    %ebp
  801a68:	c3                   	ret    
  801a69:	8d 76 00             	lea    0x0(%esi),%esi
  801a6c:	31 ff                	xor    %edi,%edi
  801a6e:	31 c0                	xor    %eax,%eax
  801a70:	89 fa                	mov    %edi,%edx
  801a72:	83 c4 1c             	add    $0x1c,%esp
  801a75:	5b                   	pop    %ebx
  801a76:	5e                   	pop    %esi
  801a77:	5f                   	pop    %edi
  801a78:	5d                   	pop    %ebp
  801a79:	c3                   	ret    
  801a7a:	66 90                	xchg   %ax,%ax
  801a7c:	89 d8                	mov    %ebx,%eax
  801a7e:	f7 f7                	div    %edi
  801a80:	31 ff                	xor    %edi,%edi
  801a82:	89 fa                	mov    %edi,%edx
  801a84:	83 c4 1c             	add    $0x1c,%esp
  801a87:	5b                   	pop    %ebx
  801a88:	5e                   	pop    %esi
  801a89:	5f                   	pop    %edi
  801a8a:	5d                   	pop    %ebp
  801a8b:	c3                   	ret    
  801a8c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a91:	89 eb                	mov    %ebp,%ebx
  801a93:	29 fb                	sub    %edi,%ebx
  801a95:	89 f9                	mov    %edi,%ecx
  801a97:	d3 e6                	shl    %cl,%esi
  801a99:	89 c5                	mov    %eax,%ebp
  801a9b:	88 d9                	mov    %bl,%cl
  801a9d:	d3 ed                	shr    %cl,%ebp
  801a9f:	89 e9                	mov    %ebp,%ecx
  801aa1:	09 f1                	or     %esi,%ecx
  801aa3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aa7:	89 f9                	mov    %edi,%ecx
  801aa9:	d3 e0                	shl    %cl,%eax
  801aab:	89 c5                	mov    %eax,%ebp
  801aad:	89 d6                	mov    %edx,%esi
  801aaf:	88 d9                	mov    %bl,%cl
  801ab1:	d3 ee                	shr    %cl,%esi
  801ab3:	89 f9                	mov    %edi,%ecx
  801ab5:	d3 e2                	shl    %cl,%edx
  801ab7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801abb:	88 d9                	mov    %bl,%cl
  801abd:	d3 e8                	shr    %cl,%eax
  801abf:	09 c2                	or     %eax,%edx
  801ac1:	89 d0                	mov    %edx,%eax
  801ac3:	89 f2                	mov    %esi,%edx
  801ac5:	f7 74 24 0c          	divl   0xc(%esp)
  801ac9:	89 d6                	mov    %edx,%esi
  801acb:	89 c3                	mov    %eax,%ebx
  801acd:	f7 e5                	mul    %ebp
  801acf:	39 d6                	cmp    %edx,%esi
  801ad1:	72 19                	jb     801aec <__udivdi3+0xfc>
  801ad3:	74 0b                	je     801ae0 <__udivdi3+0xf0>
  801ad5:	89 d8                	mov    %ebx,%eax
  801ad7:	31 ff                	xor    %edi,%edi
  801ad9:	e9 58 ff ff ff       	jmp    801a36 <__udivdi3+0x46>
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ae4:	89 f9                	mov    %edi,%ecx
  801ae6:	d3 e2                	shl    %cl,%edx
  801ae8:	39 c2                	cmp    %eax,%edx
  801aea:	73 e9                	jae    801ad5 <__udivdi3+0xe5>
  801aec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801aef:	31 ff                	xor    %edi,%edi
  801af1:	e9 40 ff ff ff       	jmp    801a36 <__udivdi3+0x46>
  801af6:	66 90                	xchg   %ax,%ax
  801af8:	31 c0                	xor    %eax,%eax
  801afa:	e9 37 ff ff ff       	jmp    801a36 <__udivdi3+0x46>
  801aff:	90                   	nop

00801b00 <__umoddi3>:
  801b00:	55                   	push   %ebp
  801b01:	57                   	push   %edi
  801b02:	56                   	push   %esi
  801b03:	53                   	push   %ebx
  801b04:	83 ec 1c             	sub    $0x1c,%esp
  801b07:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b0b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b0f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b13:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b17:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b1b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b1f:	89 f3                	mov    %esi,%ebx
  801b21:	89 fa                	mov    %edi,%edx
  801b23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b27:	89 34 24             	mov    %esi,(%esp)
  801b2a:	85 c0                	test   %eax,%eax
  801b2c:	75 1a                	jne    801b48 <__umoddi3+0x48>
  801b2e:	39 f7                	cmp    %esi,%edi
  801b30:	0f 86 a2 00 00 00    	jbe    801bd8 <__umoddi3+0xd8>
  801b36:	89 c8                	mov    %ecx,%eax
  801b38:	89 f2                	mov    %esi,%edx
  801b3a:	f7 f7                	div    %edi
  801b3c:	89 d0                	mov    %edx,%eax
  801b3e:	31 d2                	xor    %edx,%edx
  801b40:	83 c4 1c             	add    $0x1c,%esp
  801b43:	5b                   	pop    %ebx
  801b44:	5e                   	pop    %esi
  801b45:	5f                   	pop    %edi
  801b46:	5d                   	pop    %ebp
  801b47:	c3                   	ret    
  801b48:	39 f0                	cmp    %esi,%eax
  801b4a:	0f 87 ac 00 00 00    	ja     801bfc <__umoddi3+0xfc>
  801b50:	0f bd e8             	bsr    %eax,%ebp
  801b53:	83 f5 1f             	xor    $0x1f,%ebp
  801b56:	0f 84 ac 00 00 00    	je     801c08 <__umoddi3+0x108>
  801b5c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b61:	29 ef                	sub    %ebp,%edi
  801b63:	89 fe                	mov    %edi,%esi
  801b65:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b69:	89 e9                	mov    %ebp,%ecx
  801b6b:	d3 e0                	shl    %cl,%eax
  801b6d:	89 d7                	mov    %edx,%edi
  801b6f:	89 f1                	mov    %esi,%ecx
  801b71:	d3 ef                	shr    %cl,%edi
  801b73:	09 c7                	or     %eax,%edi
  801b75:	89 e9                	mov    %ebp,%ecx
  801b77:	d3 e2                	shl    %cl,%edx
  801b79:	89 14 24             	mov    %edx,(%esp)
  801b7c:	89 d8                	mov    %ebx,%eax
  801b7e:	d3 e0                	shl    %cl,%eax
  801b80:	89 c2                	mov    %eax,%edx
  801b82:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b86:	d3 e0                	shl    %cl,%eax
  801b88:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b8c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b90:	89 f1                	mov    %esi,%ecx
  801b92:	d3 e8                	shr    %cl,%eax
  801b94:	09 d0                	or     %edx,%eax
  801b96:	d3 eb                	shr    %cl,%ebx
  801b98:	89 da                	mov    %ebx,%edx
  801b9a:	f7 f7                	div    %edi
  801b9c:	89 d3                	mov    %edx,%ebx
  801b9e:	f7 24 24             	mull   (%esp)
  801ba1:	89 c6                	mov    %eax,%esi
  801ba3:	89 d1                	mov    %edx,%ecx
  801ba5:	39 d3                	cmp    %edx,%ebx
  801ba7:	0f 82 87 00 00 00    	jb     801c34 <__umoddi3+0x134>
  801bad:	0f 84 91 00 00 00    	je     801c44 <__umoddi3+0x144>
  801bb3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bb7:	29 f2                	sub    %esi,%edx
  801bb9:	19 cb                	sbb    %ecx,%ebx
  801bbb:	89 d8                	mov    %ebx,%eax
  801bbd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bc1:	d3 e0                	shl    %cl,%eax
  801bc3:	89 e9                	mov    %ebp,%ecx
  801bc5:	d3 ea                	shr    %cl,%edx
  801bc7:	09 d0                	or     %edx,%eax
  801bc9:	89 e9                	mov    %ebp,%ecx
  801bcb:	d3 eb                	shr    %cl,%ebx
  801bcd:	89 da                	mov    %ebx,%edx
  801bcf:	83 c4 1c             	add    $0x1c,%esp
  801bd2:	5b                   	pop    %ebx
  801bd3:	5e                   	pop    %esi
  801bd4:	5f                   	pop    %edi
  801bd5:	5d                   	pop    %ebp
  801bd6:	c3                   	ret    
  801bd7:	90                   	nop
  801bd8:	89 fd                	mov    %edi,%ebp
  801bda:	85 ff                	test   %edi,%edi
  801bdc:	75 0b                	jne    801be9 <__umoddi3+0xe9>
  801bde:	b8 01 00 00 00       	mov    $0x1,%eax
  801be3:	31 d2                	xor    %edx,%edx
  801be5:	f7 f7                	div    %edi
  801be7:	89 c5                	mov    %eax,%ebp
  801be9:	89 f0                	mov    %esi,%eax
  801beb:	31 d2                	xor    %edx,%edx
  801bed:	f7 f5                	div    %ebp
  801bef:	89 c8                	mov    %ecx,%eax
  801bf1:	f7 f5                	div    %ebp
  801bf3:	89 d0                	mov    %edx,%eax
  801bf5:	e9 44 ff ff ff       	jmp    801b3e <__umoddi3+0x3e>
  801bfa:	66 90                	xchg   %ax,%ax
  801bfc:	89 c8                	mov    %ecx,%eax
  801bfe:	89 f2                	mov    %esi,%edx
  801c00:	83 c4 1c             	add    $0x1c,%esp
  801c03:	5b                   	pop    %ebx
  801c04:	5e                   	pop    %esi
  801c05:	5f                   	pop    %edi
  801c06:	5d                   	pop    %ebp
  801c07:	c3                   	ret    
  801c08:	3b 04 24             	cmp    (%esp),%eax
  801c0b:	72 06                	jb     801c13 <__umoddi3+0x113>
  801c0d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c11:	77 0f                	ja     801c22 <__umoddi3+0x122>
  801c13:	89 f2                	mov    %esi,%edx
  801c15:	29 f9                	sub    %edi,%ecx
  801c17:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c1b:	89 14 24             	mov    %edx,(%esp)
  801c1e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c22:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c26:	8b 14 24             	mov    (%esp),%edx
  801c29:	83 c4 1c             	add    $0x1c,%esp
  801c2c:	5b                   	pop    %ebx
  801c2d:	5e                   	pop    %esi
  801c2e:	5f                   	pop    %edi
  801c2f:	5d                   	pop    %ebp
  801c30:	c3                   	ret    
  801c31:	8d 76 00             	lea    0x0(%esi),%esi
  801c34:	2b 04 24             	sub    (%esp),%eax
  801c37:	19 fa                	sbb    %edi,%edx
  801c39:	89 d1                	mov    %edx,%ecx
  801c3b:	89 c6                	mov    %eax,%esi
  801c3d:	e9 71 ff ff ff       	jmp    801bb3 <__umoddi3+0xb3>
  801c42:	66 90                	xchg   %ax,%ax
  801c44:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c48:	72 ea                	jb     801c34 <__umoddi3+0x134>
  801c4a:	89 d9                	mov    %ebx,%ecx
  801c4c:	e9 62 ff ff ff       	jmp    801bb3 <__umoddi3+0xb3>
