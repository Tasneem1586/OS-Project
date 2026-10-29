
obj/user/tst_protection:     file format elf32-i386


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
  800031:	e8 bc 00 00 00       	call   8000f2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	/*=================================================*/
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
#if USE_KHEAP
	{
		if (LIST_SIZE(&(myEnv->page_WS_active_list)) >= myEnv->page_WS_max_size)
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
  800049:	a1 20 30 80 00       	mov    0x803020,%eax
  80004e:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800054:	39 c2                	cmp    %eax,%edx
  800056:	72 14                	jb     80006c <_main+0x34>
			panic("Please increase the WS size");
  800058:	83 ec 04             	sub    $0x4,%esp
  80005b:	68 e0 1c 80 00       	push   $0x801ce0
  800060:	6a 0b                	push   $0xb
  800062:	68 fc 1c 80 00       	push   $0x801cfc
  800067:	e8 e6 02 00 00       	call   800352 <_panic>
#else
	panic("make sure to enable the kernel heap: USE_KHEAP=1");
#endif
	/*=================================================*/

	int numOfSlaves = 3;
  80006c:	c7 45 f0 03 00 00 00 	movl   $0x3,-0x10(%ebp)
	rsttst();
  800073:	e8 1c 18 00 00       	call   801894 <rsttst>
	//[1] Run programs that allocate many shared variables
	for (int i = 0; i < numOfSlaves; ++i) {
  800078:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80007f:	eb 45                	jmp    8000c6 <_main+0x8e>
		int32 envId = sys_create_env("protection_slave1", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  80008c:	a1 20 30 80 00       	mov    0x803020,%eax
  800091:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000a2:	51                   	push   %ecx
  8000a3:	52                   	push   %edx
  8000a4:	50                   	push   %eax
  8000a5:	68 12 1d 80 00       	push   $0x801d12
  8000aa:	e8 cf 16 00 00       	call   80177e <sys_create_env>
  8000af:	83 c4 10             	add    $0x10,%esp
  8000b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		sys_run_env(envId);
  8000b5:	83 ec 0c             	sub    $0xc,%esp
  8000b8:	ff 75 ec             	pushl  -0x14(%ebp)
  8000bb:	e8 dc 16 00 00       	call   80179c <sys_run_env>
  8000c0:	83 c4 10             	add    $0x10,%esp
	/*=================================================*/

	int numOfSlaves = 3;
	rsttst();
	//[1] Run programs that allocate many shared variables
	for (int i = 0; i < numOfSlaves; ++i) {
  8000c3:	ff 45 f4             	incl   -0xc(%ebp)
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cc:	7c b3                	jl     800081 <_main+0x49>
		int32 envId = sys_create_env("protection_slave1", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(envId);
	}

	while (gettst() != numOfSlaves) ;
  8000ce:	90                   	nop
  8000cf:	e8 3a 18 00 00       	call   80190e <gettst>
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d9:	39 c2                	cmp    %eax,%edx
  8000db:	75 f2                	jne    8000cf <_main+0x97>

	cprintf_colored(TEXT_light_green, "%~\nCongratulations... test protection is run successfully\n");
  8000dd:	83 ec 08             	sub    $0x8,%esp
  8000e0:	68 24 1d 80 00       	push   $0x801d24
  8000e5:	6a 0a                	push   $0xa
  8000e7:	e8 61 05 00 00       	call   80064d <cprintf_colored>
  8000ec:	83 c4 10             	add    $0x10,%esp

}
  8000ef:	90                   	nop
  8000f0:	c9                   	leave  
  8000f1:	c3                   	ret    

008000f2 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000f2:	55                   	push   %ebp
  8000f3:	89 e5                	mov    %esp,%ebp
  8000f5:	57                   	push   %edi
  8000f6:	56                   	push   %esi
  8000f7:	53                   	push   %ebx
  8000f8:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000fe:	e8 e9 16 00 00       	call   8017ec <sys_getenvindex>
  800103:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800106:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800109:	89 d0                	mov    %edx,%eax
  80010b:	c1 e0 03             	shl    $0x3,%eax
  80010e:	01 d0                	add    %edx,%eax
  800110:	c1 e0 06             	shl    $0x6,%eax
  800113:	01 d0                	add    %edx,%eax
  800115:	c1 e0 03             	shl    $0x3,%eax
  800118:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80011d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800122:	a1 20 30 80 00       	mov    0x803020,%eax
  800127:	8a 40 10             	mov    0x10(%eax),%al
  80012a:	84 c0                	test   %al,%al
  80012c:	74 0d                	je     80013b <libmain+0x49>
		binaryname = myEnv->prog_name;
  80012e:	a1 20 30 80 00       	mov    0x803020,%eax
  800133:	83 c0 10             	add    $0x10,%eax
  800136:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80013b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80013f:	7e 0a                	jle    80014b <libmain+0x59>
		binaryname = argv[0];
  800141:	8b 45 0c             	mov    0xc(%ebp),%eax
  800144:	8b 00                	mov    (%eax),%eax
  800146:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80014b:	83 ec 08             	sub    $0x8,%esp
  80014e:	ff 75 0c             	pushl  0xc(%ebp)
  800151:	ff 75 08             	pushl  0x8(%ebp)
  800154:	e8 df fe ff ff       	call   800038 <_main>
  800159:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80015c:	a1 00 30 80 00       	mov    0x803000,%eax
  800161:	85 c0                	test   %eax,%eax
  800163:	0f 84 b7 01 00 00    	je     800320 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800169:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80016f:	bb 9c 1e 80 00       	mov    $0x801e9c,%ebx
  800174:	ba 0e 00 00 00       	mov    $0xe,%edx
  800179:	89 c7                	mov    %eax,%edi
  80017b:	89 de                	mov    %ebx,%esi
  80017d:	89 d1                	mov    %edx,%ecx
  80017f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800181:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800187:	b9 56 00 00 00       	mov    $0x56,%ecx
  80018c:	b0 00                	mov    $0x0,%al
  80018e:	89 d7                	mov    %edx,%edi
  800190:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800192:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800199:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80019c:	83 ec 08             	sub    $0x8,%esp
  80019f:	50                   	push   %eax
  8001a0:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001a6:	50                   	push   %eax
  8001a7:	e8 40 18 00 00       	call   8019ec <sys_utilities>
  8001ac:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001af:	e8 c0 13 00 00       	call   801574 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001b4:	83 ec 0c             	sub    $0xc,%esp
  8001b7:	68 78 1d 80 00       	push   $0x801d78
  8001bc:	e8 5f 04 00 00       	call   800620 <cprintf>
  8001c1:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001c7:	85 c0                	test   %eax,%eax
  8001c9:	74 58                	je     800223 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001cb:	e8 3a 18 00 00       	call   801a0a <sys_get_optimal_num_faults>
  8001d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001d3:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001d9:	bb 00 1f 80 00       	mov    $0x801f00,%ebx
  8001de:	ba 11 00 00 00       	mov    $0x11,%edx
  8001e3:	89 c7                	mov    %eax,%edi
  8001e5:	89 de                	mov    %ebx,%esi
  8001e7:	89 d1                	mov    %edx,%ecx
  8001e9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001eb:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001ee:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001f3:	b0 00                	mov    $0x0,%al
  8001f5:	89 d7                	mov    %edx,%edi
  8001f7:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ff:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800205:	50                   	push   %eax
  800206:	e8 e1 17 00 00       	call   8019ec <sys_utilities>
  80020b:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  80020e:	83 ec 08             	sub    $0x8,%esp
  800211:	ff 75 dc             	pushl  -0x24(%ebp)
  800214:	68 a0 1d 80 00       	push   $0x801da0
  800219:	e8 02 04 00 00       	call   800620 <cprintf>
  80021e:	83 c4 10             	add    $0x10,%esp
  800221:	eb 59                	jmp    80027c <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800223:	a1 20 30 80 00       	mov    0x803020,%eax
  800228:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800239:	83 ec 04             	sub    $0x4,%esp
  80023c:	52                   	push   %edx
  80023d:	50                   	push   %eax
  80023e:	68 c4 1d 80 00       	push   $0x801dc4
  800243:	e8 d8 03 00 00       	call   800620 <cprintf>
  800248:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80024b:	a1 20 30 80 00       	mov    0x803020,%eax
  800250:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800256:	a1 20 30 80 00       	mov    0x803020,%eax
  80025b:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800261:	a1 20 30 80 00       	mov    0x803020,%eax
  800266:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80026c:	51                   	push   %ecx
  80026d:	52                   	push   %edx
  80026e:	50                   	push   %eax
  80026f:	68 ec 1d 80 00       	push   $0x801dec
  800274:	e8 a7 03 00 00       	call   800620 <cprintf>
  800279:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80027c:	a1 20 30 80 00       	mov    0x803020,%eax
  800281:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800287:	83 ec 08             	sub    $0x8,%esp
  80028a:	50                   	push   %eax
  80028b:	68 44 1e 80 00       	push   $0x801e44
  800290:	e8 8b 03 00 00       	call   800620 <cprintf>
  800295:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	68 58 1e 80 00       	push   $0x801e58
  8002a0:	e8 7b 03 00 00       	call   800620 <cprintf>
  8002a5:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002af:	eb 28                	jmp    8002d9 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002b9:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002bf:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002c2:	83 ec 04             	sub    $0x4,%esp
  8002c5:	50                   	push   %eax
  8002c6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c9:	68 6f 1e 80 00       	push   $0x801e6f
  8002ce:	e8 4d 03 00 00       	call   800620 <cprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002d6:	ff 45 e4             	incl   -0x1c(%ebp)
  8002d9:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002dd:	7e d2                	jle    8002b1 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002df:	83 ec 0c             	sub    $0xc,%esp
  8002e2:	68 7e 1e 80 00       	push   $0x801e7e
  8002e7:	e8 34 03 00 00       	call   800620 <cprintf>
  8002ec:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f4:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002fa:	83 ec 08             	sub    $0x8,%esp
  8002fd:	50                   	push   %eax
  8002fe:	68 82 1e 80 00       	push   $0x801e82
  800303:	e8 18 03 00 00       	call   800620 <cprintf>
  800308:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80030b:	83 ec 0c             	sub    $0xc,%esp
  80030e:	68 78 1d 80 00       	push   $0x801d78
  800313:	e8 08 03 00 00       	call   800620 <cprintf>
  800318:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80031b:	e8 6e 12 00 00       	call   80158e <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800320:	e8 1f 00 00 00       	call   800344 <exit>
}
  800325:	90                   	nop
  800326:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800329:	5b                   	pop    %ebx
  80032a:	5e                   	pop    %esi
  80032b:	5f                   	pop    %edi
  80032c:	5d                   	pop    %ebp
  80032d:	c3                   	ret    

0080032e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80032e:	55                   	push   %ebp
  80032f:	89 e5                	mov    %esp,%ebp
  800331:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800334:	83 ec 0c             	sub    $0xc,%esp
  800337:	6a 00                	push   $0x0
  800339:	e8 7a 14 00 00       	call   8017b8 <sys_destroy_env>
  80033e:	83 c4 10             	add    $0x10,%esp
}
  800341:	90                   	nop
  800342:	c9                   	leave  
  800343:	c3                   	ret    

00800344 <exit>:

void
exit(void)
{
  800344:	55                   	push   %ebp
  800345:	89 e5                	mov    %esp,%ebp
  800347:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80034a:	e8 cf 14 00 00       	call   80181e <sys_exit_env>
}
  80034f:	90                   	nop
  800350:	c9                   	leave  
  800351:	c3                   	ret    

00800352 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800352:	55                   	push   %ebp
  800353:	89 e5                	mov    %esp,%ebp
  800355:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800358:	8d 45 10             	lea    0x10(%ebp),%eax
  80035b:	83 c0 04             	add    $0x4,%eax
  80035e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800361:	a1 28 31 80 00       	mov    0x803128,%eax
  800366:	85 c0                	test   %eax,%eax
  800368:	74 16                	je     800380 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80036a:	a1 28 31 80 00       	mov    0x803128,%eax
  80036f:	83 ec 08             	sub    $0x8,%esp
  800372:	50                   	push   %eax
  800373:	68 64 1f 80 00       	push   $0x801f64
  800378:	e8 a3 02 00 00       	call   800620 <cprintf>
  80037d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800380:	a1 04 30 80 00       	mov    0x803004,%eax
  800385:	83 ec 0c             	sub    $0xc,%esp
  800388:	ff 75 0c             	pushl  0xc(%ebp)
  80038b:	ff 75 08             	pushl  0x8(%ebp)
  80038e:	50                   	push   %eax
  80038f:	68 6c 1f 80 00       	push   $0x801f6c
  800394:	6a 74                	push   $0x74
  800396:	e8 b2 02 00 00       	call   80064d <cprintf_colored>
  80039b:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80039e:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a1:	83 ec 08             	sub    $0x8,%esp
  8003a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a7:	50                   	push   %eax
  8003a8:	e8 04 02 00 00       	call   8005b1 <vcprintf>
  8003ad:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003b0:	83 ec 08             	sub    $0x8,%esp
  8003b3:	6a 00                	push   $0x0
  8003b5:	68 94 1f 80 00       	push   $0x801f94
  8003ba:	e8 f2 01 00 00       	call   8005b1 <vcprintf>
  8003bf:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003c2:	e8 7d ff ff ff       	call   800344 <exit>

	// should not return here
	while (1) ;
  8003c7:	eb fe                	jmp    8003c7 <_panic+0x75>

008003c9 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003c9:	55                   	push   %ebp
  8003ca:	89 e5                	mov    %esp,%ebp
  8003cc:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8003da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dd:	39 c2                	cmp    %eax,%edx
  8003df:	74 14                	je     8003f5 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	68 98 1f 80 00       	push   $0x801f98
  8003e9:	6a 26                	push   $0x26
  8003eb:	68 e4 1f 80 00       	push   $0x801fe4
  8003f0:	e8 5d ff ff ff       	call   800352 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800403:	e9 c5 00 00 00       	jmp    8004cd <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800408:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	01 d0                	add    %edx,%eax
  800417:	8b 00                	mov    (%eax),%eax
  800419:	85 c0                	test   %eax,%eax
  80041b:	75 08                	jne    800425 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80041d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800420:	e9 a5 00 00 00       	jmp    8004ca <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800425:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80042c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800433:	eb 69                	jmp    80049e <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800435:	a1 20 30 80 00       	mov    0x803020,%eax
  80043a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800440:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	01 c0                	add    %eax,%eax
  800447:	01 d0                	add    %edx,%eax
  800449:	c1 e0 03             	shl    $0x3,%eax
  80044c:	01 c8                	add    %ecx,%eax
  80044e:	8a 40 04             	mov    0x4(%eax),%al
  800451:	84 c0                	test   %al,%al
  800453:	75 46                	jne    80049b <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800455:	a1 20 30 80 00       	mov    0x803020,%eax
  80045a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800460:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800463:	89 d0                	mov    %edx,%eax
  800465:	01 c0                	add    %eax,%eax
  800467:	01 d0                	add    %edx,%eax
  800469:	c1 e0 03             	shl    $0x3,%eax
  80046c:	01 c8                	add    %ecx,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800473:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800476:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80047d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800480:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	01 c8                	add    %ecx,%eax
  80048c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80048e:	39 c2                	cmp    %eax,%edx
  800490:	75 09                	jne    80049b <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800492:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800499:	eb 15                	jmp    8004b0 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80049b:	ff 45 e8             	incl   -0x18(%ebp)
  80049e:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8004a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004ac:	39 c2                	cmp    %eax,%edx
  8004ae:	77 85                	ja     800435 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004b4:	75 14                	jne    8004ca <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8004b6:	83 ec 04             	sub    $0x4,%esp
  8004b9:	68 f0 1f 80 00       	push   $0x801ff0
  8004be:	6a 3a                	push   $0x3a
  8004c0:	68 e4 1f 80 00       	push   $0x801fe4
  8004c5:	e8 88 fe ff ff       	call   800352 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004ca:	ff 45 f0             	incl   -0x10(%ebp)
  8004cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d3:	0f 8c 2f ff ff ff    	jl     800408 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004d9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004e0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004e7:	eb 26                	jmp    80050f <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ee:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f7:	89 d0                	mov    %edx,%eax
  8004f9:	01 c0                	add    %eax,%eax
  8004fb:	01 d0                	add    %edx,%eax
  8004fd:	c1 e0 03             	shl    $0x3,%eax
  800500:	01 c8                	add    %ecx,%eax
  800502:	8a 40 04             	mov    0x4(%eax),%al
  800505:	3c 01                	cmp    $0x1,%al
  800507:	75 03                	jne    80050c <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800509:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80050c:	ff 45 e0             	incl   -0x20(%ebp)
  80050f:	a1 20 30 80 00       	mov    0x803020,%eax
  800514:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80051a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051d:	39 c2                	cmp    %eax,%edx
  80051f:	77 c8                	ja     8004e9 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800521:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800524:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800527:	74 14                	je     80053d <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800529:	83 ec 04             	sub    $0x4,%esp
  80052c:	68 44 20 80 00       	push   $0x802044
  800531:	6a 44                	push   $0x44
  800533:	68 e4 1f 80 00       	push   $0x801fe4
  800538:	e8 15 fe ff ff       	call   800352 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80053d:	90                   	nop
  80053e:	c9                   	leave  
  80053f:	c3                   	ret    

00800540 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800540:	55                   	push   %ebp
  800541:	89 e5                	mov    %esp,%ebp
  800543:	53                   	push   %ebx
  800544:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800547:	8b 45 0c             	mov    0xc(%ebp),%eax
  80054a:	8b 00                	mov    (%eax),%eax
  80054c:	8d 48 01             	lea    0x1(%eax),%ecx
  80054f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800552:	89 0a                	mov    %ecx,(%edx)
  800554:	8b 55 08             	mov    0x8(%ebp),%edx
  800557:	88 d1                	mov    %dl,%cl
  800559:	8b 55 0c             	mov    0xc(%ebp),%edx
  80055c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800560:	8b 45 0c             	mov    0xc(%ebp),%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	3d ff 00 00 00       	cmp    $0xff,%eax
  80056a:	75 30                	jne    80059c <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80056c:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800572:	a0 40 30 80 00       	mov    0x803040,%al
  800577:	0f b6 c0             	movzbl %al,%eax
  80057a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80057d:	8b 09                	mov    (%ecx),%ecx
  80057f:	89 cb                	mov    %ecx,%ebx
  800581:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800584:	83 c1 08             	add    $0x8,%ecx
  800587:	52                   	push   %edx
  800588:	50                   	push   %eax
  800589:	53                   	push   %ebx
  80058a:	51                   	push   %ecx
  80058b:	e8 a0 0f 00 00       	call   801530 <sys_cputs>
  800590:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800593:	8b 45 0c             	mov    0xc(%ebp),%eax
  800596:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80059c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80059f:	8b 40 04             	mov    0x4(%eax),%eax
  8005a2:	8d 50 01             	lea    0x1(%eax),%edx
  8005a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005ab:	90                   	nop
  8005ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005af:	c9                   	leave  
  8005b0:	c3                   	ret    

008005b1 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005b1:	55                   	push   %ebp
  8005b2:	89 e5                	mov    %esp,%ebp
  8005b4:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005ba:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005c1:	00 00 00 
	b.cnt = 0;
  8005c4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005cb:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005ce:	ff 75 0c             	pushl  0xc(%ebp)
  8005d1:	ff 75 08             	pushl  0x8(%ebp)
  8005d4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005da:	50                   	push   %eax
  8005db:	68 40 05 80 00       	push   $0x800540
  8005e0:	e8 5a 02 00 00       	call   80083f <vprintfmt>
  8005e5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8005e8:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8005ee:	a0 40 30 80 00       	mov    0x803040,%al
  8005f3:	0f b6 c0             	movzbl %al,%eax
  8005f6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8005fc:	52                   	push   %edx
  8005fd:	50                   	push   %eax
  8005fe:	51                   	push   %ecx
  8005ff:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800605:	83 c0 08             	add    $0x8,%eax
  800608:	50                   	push   %eax
  800609:	e8 22 0f 00 00       	call   801530 <sys_cputs>
  80060e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800611:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800618:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80061e:	c9                   	leave  
  80061f:	c3                   	ret    

00800620 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800620:	55                   	push   %ebp
  800621:	89 e5                	mov    %esp,%ebp
  800623:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800626:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80062d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800630:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800633:	8b 45 08             	mov    0x8(%ebp),%eax
  800636:	83 ec 08             	sub    $0x8,%esp
  800639:	ff 75 f4             	pushl  -0xc(%ebp)
  80063c:	50                   	push   %eax
  80063d:	e8 6f ff ff ff       	call   8005b1 <vcprintf>
  800642:	83 c4 10             	add    $0x10,%esp
  800645:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800648:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80064b:	c9                   	leave  
  80064c:	c3                   	ret    

0080064d <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80064d:	55                   	push   %ebp
  80064e:	89 e5                	mov    %esp,%ebp
  800650:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800653:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	c1 e0 08             	shl    $0x8,%eax
  800660:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800665:	8d 45 0c             	lea    0xc(%ebp),%eax
  800668:	83 c0 04             	add    $0x4,%eax
  80066b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80066e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800671:	83 ec 08             	sub    $0x8,%esp
  800674:	ff 75 f4             	pushl  -0xc(%ebp)
  800677:	50                   	push   %eax
  800678:	e8 34 ff ff ff       	call   8005b1 <vcprintf>
  80067d:	83 c4 10             	add    $0x10,%esp
  800680:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800683:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  80068a:	07 00 00 

	return cnt;
  80068d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800690:	c9                   	leave  
  800691:	c3                   	ret    

00800692 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800692:	55                   	push   %ebp
  800693:	89 e5                	mov    %esp,%ebp
  800695:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800698:	e8 d7 0e 00 00       	call   801574 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80069d:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	83 ec 08             	sub    $0x8,%esp
  8006a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ac:	50                   	push   %eax
  8006ad:	e8 ff fe ff ff       	call   8005b1 <vcprintf>
  8006b2:	83 c4 10             	add    $0x10,%esp
  8006b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8006b8:	e8 d1 0e 00 00       	call   80158e <sys_unlock_cons>
	return cnt;
  8006bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
  8006c5:	53                   	push   %ebx
  8006c6:	83 ec 14             	sub    $0x14,%esp
  8006c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8006cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006d5:	8b 45 18             	mov    0x18(%ebp),%eax
  8006d8:	ba 00 00 00 00       	mov    $0x0,%edx
  8006dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006e0:	77 55                	ja     800737 <printnum+0x75>
  8006e2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006e5:	72 05                	jb     8006ec <printnum+0x2a>
  8006e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006ea:	77 4b                	ja     800737 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006ec:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006ef:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006f2:	8b 45 18             	mov    0x18(%ebp),%eax
  8006f5:	ba 00 00 00 00       	mov    $0x0,%edx
  8006fa:	52                   	push   %edx
  8006fb:	50                   	push   %eax
  8006fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ff:	ff 75 f0             	pushl  -0x10(%ebp)
  800702:	e8 71 13 00 00       	call   801a78 <__udivdi3>
  800707:	83 c4 10             	add    $0x10,%esp
  80070a:	83 ec 04             	sub    $0x4,%esp
  80070d:	ff 75 20             	pushl  0x20(%ebp)
  800710:	53                   	push   %ebx
  800711:	ff 75 18             	pushl  0x18(%ebp)
  800714:	52                   	push   %edx
  800715:	50                   	push   %eax
  800716:	ff 75 0c             	pushl  0xc(%ebp)
  800719:	ff 75 08             	pushl  0x8(%ebp)
  80071c:	e8 a1 ff ff ff       	call   8006c2 <printnum>
  800721:	83 c4 20             	add    $0x20,%esp
  800724:	eb 1a                	jmp    800740 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	ff 75 20             	pushl  0x20(%ebp)
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800737:	ff 4d 1c             	decl   0x1c(%ebp)
  80073a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80073e:	7f e6                	jg     800726 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800740:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800743:	bb 00 00 00 00       	mov    $0x0,%ebx
  800748:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80074b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80074e:	53                   	push   %ebx
  80074f:	51                   	push   %ecx
  800750:	52                   	push   %edx
  800751:	50                   	push   %eax
  800752:	e8 31 14 00 00       	call   801b88 <__umoddi3>
  800757:	83 c4 10             	add    $0x10,%esp
  80075a:	05 b4 22 80 00       	add    $0x8022b4,%eax
  80075f:	8a 00                	mov    (%eax),%al
  800761:	0f be c0             	movsbl %al,%eax
  800764:	83 ec 08             	sub    $0x8,%esp
  800767:	ff 75 0c             	pushl  0xc(%ebp)
  80076a:	50                   	push   %eax
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	ff d0                	call   *%eax
  800770:	83 c4 10             	add    $0x10,%esp
}
  800773:	90                   	nop
  800774:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800777:	c9                   	leave  
  800778:	c3                   	ret    

00800779 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800779:	55                   	push   %ebp
  80077a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80077c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800780:	7e 1c                	jle    80079e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	8b 00                	mov    (%eax),%eax
  800787:	8d 50 08             	lea    0x8(%eax),%edx
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	89 10                	mov    %edx,(%eax)
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	8b 00                	mov    (%eax),%eax
  800794:	83 e8 08             	sub    $0x8,%eax
  800797:	8b 50 04             	mov    0x4(%eax),%edx
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	eb 40                	jmp    8007de <getuint+0x65>
	else if (lflag)
  80079e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007a2:	74 1e                	je     8007c2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a7:	8b 00                	mov    (%eax),%eax
  8007a9:	8d 50 04             	lea    0x4(%eax),%edx
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	89 10                	mov    %edx,(%eax)
  8007b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	83 e8 04             	sub    $0x4,%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	ba 00 00 00 00       	mov    $0x0,%edx
  8007c0:	eb 1c                	jmp    8007de <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c5:	8b 00                	mov    (%eax),%eax
  8007c7:	8d 50 04             	lea    0x4(%eax),%edx
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	89 10                	mov    %edx,(%eax)
  8007cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d2:	8b 00                	mov    (%eax),%eax
  8007d4:	83 e8 04             	sub    $0x4,%eax
  8007d7:	8b 00                	mov    (%eax),%eax
  8007d9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007de:	5d                   	pop    %ebp
  8007df:	c3                   	ret    

008007e0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007e0:	55                   	push   %ebp
  8007e1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007e3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007e7:	7e 1c                	jle    800805 <getint+0x25>
		return va_arg(*ap, long long);
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	8b 00                	mov    (%eax),%eax
  8007ee:	8d 50 08             	lea    0x8(%eax),%edx
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	89 10                	mov    %edx,(%eax)
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	83 e8 08             	sub    $0x8,%eax
  8007fe:	8b 50 04             	mov    0x4(%eax),%edx
  800801:	8b 00                	mov    (%eax),%eax
  800803:	eb 38                	jmp    80083d <getint+0x5d>
	else if (lflag)
  800805:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800809:	74 1a                	je     800825 <getint+0x45>
		return va_arg(*ap, long);
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	8d 50 04             	lea    0x4(%eax),%edx
  800813:	8b 45 08             	mov    0x8(%ebp),%eax
  800816:	89 10                	mov    %edx,(%eax)
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	8b 00                	mov    (%eax),%eax
  80081d:	83 e8 04             	sub    $0x4,%eax
  800820:	8b 00                	mov    (%eax),%eax
  800822:	99                   	cltd   
  800823:	eb 18                	jmp    80083d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	8d 50 04             	lea    0x4(%eax),%edx
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	89 10                	mov    %edx,(%eax)
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	83 e8 04             	sub    $0x4,%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	99                   	cltd   
}
  80083d:	5d                   	pop    %ebp
  80083e:	c3                   	ret    

0080083f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80083f:	55                   	push   %ebp
  800840:	89 e5                	mov    %esp,%ebp
  800842:	56                   	push   %esi
  800843:	53                   	push   %ebx
  800844:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800847:	eb 17                	jmp    800860 <vprintfmt+0x21>
			if (ch == '\0')
  800849:	85 db                	test   %ebx,%ebx
  80084b:	0f 84 c1 03 00 00    	je     800c12 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800851:	83 ec 08             	sub    $0x8,%esp
  800854:	ff 75 0c             	pushl  0xc(%ebp)
  800857:	53                   	push   %ebx
  800858:	8b 45 08             	mov    0x8(%ebp),%eax
  80085b:	ff d0                	call   *%eax
  80085d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800860:	8b 45 10             	mov    0x10(%ebp),%eax
  800863:	8d 50 01             	lea    0x1(%eax),%edx
  800866:	89 55 10             	mov    %edx,0x10(%ebp)
  800869:	8a 00                	mov    (%eax),%al
  80086b:	0f b6 d8             	movzbl %al,%ebx
  80086e:	83 fb 25             	cmp    $0x25,%ebx
  800871:	75 d6                	jne    800849 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800873:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800877:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80087e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800885:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80088c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800893:	8b 45 10             	mov    0x10(%ebp),%eax
  800896:	8d 50 01             	lea    0x1(%eax),%edx
  800899:	89 55 10             	mov    %edx,0x10(%ebp)
  80089c:	8a 00                	mov    (%eax),%al
  80089e:	0f b6 d8             	movzbl %al,%ebx
  8008a1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008a4:	83 f8 5b             	cmp    $0x5b,%eax
  8008a7:	0f 87 3d 03 00 00    	ja     800bea <vprintfmt+0x3ab>
  8008ad:	8b 04 85 d8 22 80 00 	mov    0x8022d8(,%eax,4),%eax
  8008b4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008b6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008ba:	eb d7                	jmp    800893 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008bc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008c0:	eb d1                	jmp    800893 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008c2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008cc:	89 d0                	mov    %edx,%eax
  8008ce:	c1 e0 02             	shl    $0x2,%eax
  8008d1:	01 d0                	add    %edx,%eax
  8008d3:	01 c0                	add    %eax,%eax
  8008d5:	01 d8                	add    %ebx,%eax
  8008d7:	83 e8 30             	sub    $0x30,%eax
  8008da:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e0:	8a 00                	mov    (%eax),%al
  8008e2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008e5:	83 fb 2f             	cmp    $0x2f,%ebx
  8008e8:	7e 3e                	jle    800928 <vprintfmt+0xe9>
  8008ea:	83 fb 39             	cmp    $0x39,%ebx
  8008ed:	7f 39                	jg     800928 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008ef:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008f2:	eb d5                	jmp    8008c9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f7:	83 c0 04             	add    $0x4,%eax
  8008fa:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800900:	83 e8 04             	sub    $0x4,%eax
  800903:	8b 00                	mov    (%eax),%eax
  800905:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800908:	eb 1f                	jmp    800929 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80090a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80090e:	79 83                	jns    800893 <vprintfmt+0x54>
				width = 0;
  800910:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800917:	e9 77 ff ff ff       	jmp    800893 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80091c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800923:	e9 6b ff ff ff       	jmp    800893 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800928:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800929:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092d:	0f 89 60 ff ff ff    	jns    800893 <vprintfmt+0x54>
				width = precision, precision = -1;
  800933:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800936:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800939:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800940:	e9 4e ff ff ff       	jmp    800893 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800945:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800948:	e9 46 ff ff ff       	jmp    800893 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80094d:	8b 45 14             	mov    0x14(%ebp),%eax
  800950:	83 c0 04             	add    $0x4,%eax
  800953:	89 45 14             	mov    %eax,0x14(%ebp)
  800956:	8b 45 14             	mov    0x14(%ebp),%eax
  800959:	83 e8 04             	sub    $0x4,%eax
  80095c:	8b 00                	mov    (%eax),%eax
  80095e:	83 ec 08             	sub    $0x8,%esp
  800961:	ff 75 0c             	pushl  0xc(%ebp)
  800964:	50                   	push   %eax
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	ff d0                	call   *%eax
  80096a:	83 c4 10             	add    $0x10,%esp
			break;
  80096d:	e9 9b 02 00 00       	jmp    800c0d <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800972:	8b 45 14             	mov    0x14(%ebp),%eax
  800975:	83 c0 04             	add    $0x4,%eax
  800978:	89 45 14             	mov    %eax,0x14(%ebp)
  80097b:	8b 45 14             	mov    0x14(%ebp),%eax
  80097e:	83 e8 04             	sub    $0x4,%eax
  800981:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800983:	85 db                	test   %ebx,%ebx
  800985:	79 02                	jns    800989 <vprintfmt+0x14a>
				err = -err;
  800987:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800989:	83 fb 64             	cmp    $0x64,%ebx
  80098c:	7f 0b                	jg     800999 <vprintfmt+0x15a>
  80098e:	8b 34 9d 20 21 80 00 	mov    0x802120(,%ebx,4),%esi
  800995:	85 f6                	test   %esi,%esi
  800997:	75 19                	jne    8009b2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800999:	53                   	push   %ebx
  80099a:	68 c5 22 80 00       	push   $0x8022c5
  80099f:	ff 75 0c             	pushl  0xc(%ebp)
  8009a2:	ff 75 08             	pushl  0x8(%ebp)
  8009a5:	e8 70 02 00 00       	call   800c1a <printfmt>
  8009aa:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009ad:	e9 5b 02 00 00       	jmp    800c0d <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009b2:	56                   	push   %esi
  8009b3:	68 ce 22 80 00       	push   $0x8022ce
  8009b8:	ff 75 0c             	pushl  0xc(%ebp)
  8009bb:	ff 75 08             	pushl  0x8(%ebp)
  8009be:	e8 57 02 00 00       	call   800c1a <printfmt>
  8009c3:	83 c4 10             	add    $0x10,%esp
			break;
  8009c6:	e9 42 02 00 00       	jmp    800c0d <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ce:	83 c0 04             	add    $0x4,%eax
  8009d1:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d7:	83 e8 04             	sub    $0x4,%eax
  8009da:	8b 30                	mov    (%eax),%esi
  8009dc:	85 f6                	test   %esi,%esi
  8009de:	75 05                	jne    8009e5 <vprintfmt+0x1a6>
				p = "(null)";
  8009e0:	be d1 22 80 00       	mov    $0x8022d1,%esi
			if (width > 0 && padc != '-')
  8009e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e9:	7e 6d                	jle    800a58 <vprintfmt+0x219>
  8009eb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009ef:	74 67                	je     800a58 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f4:	83 ec 08             	sub    $0x8,%esp
  8009f7:	50                   	push   %eax
  8009f8:	56                   	push   %esi
  8009f9:	e8 1e 03 00 00       	call   800d1c <strnlen>
  8009fe:	83 c4 10             	add    $0x10,%esp
  800a01:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a04:	eb 16                	jmp    800a1c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a06:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 0c             	pushl  0xc(%ebp)
  800a10:	50                   	push   %eax
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	ff d0                	call   *%eax
  800a16:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a19:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a20:	7f e4                	jg     800a06 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a22:	eb 34                	jmp    800a58 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a24:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a28:	74 1c                	je     800a46 <vprintfmt+0x207>
  800a2a:	83 fb 1f             	cmp    $0x1f,%ebx
  800a2d:	7e 05                	jle    800a34 <vprintfmt+0x1f5>
  800a2f:	83 fb 7e             	cmp    $0x7e,%ebx
  800a32:	7e 12                	jle    800a46 <vprintfmt+0x207>
					putch('?', putdat);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	6a 3f                	push   $0x3f
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	ff d0                	call   *%eax
  800a41:	83 c4 10             	add    $0x10,%esp
  800a44:	eb 0f                	jmp    800a55 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a46:	83 ec 08             	sub    $0x8,%esp
  800a49:	ff 75 0c             	pushl  0xc(%ebp)
  800a4c:	53                   	push   %ebx
  800a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a50:	ff d0                	call   *%eax
  800a52:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a55:	ff 4d e4             	decl   -0x1c(%ebp)
  800a58:	89 f0                	mov    %esi,%eax
  800a5a:	8d 70 01             	lea    0x1(%eax),%esi
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	0f be d8             	movsbl %al,%ebx
  800a62:	85 db                	test   %ebx,%ebx
  800a64:	74 24                	je     800a8a <vprintfmt+0x24b>
  800a66:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a6a:	78 b8                	js     800a24 <vprintfmt+0x1e5>
  800a6c:	ff 4d e0             	decl   -0x20(%ebp)
  800a6f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a73:	79 af                	jns    800a24 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a75:	eb 13                	jmp    800a8a <vprintfmt+0x24b>
				putch(' ', putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	6a 20                	push   $0x20
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a87:	ff 4d e4             	decl   -0x1c(%ebp)
  800a8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a8e:	7f e7                	jg     800a77 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a90:	e9 78 01 00 00       	jmp    800c0d <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a95:	83 ec 08             	sub    $0x8,%esp
  800a98:	ff 75 e8             	pushl  -0x18(%ebp)
  800a9b:	8d 45 14             	lea    0x14(%ebp),%eax
  800a9e:	50                   	push   %eax
  800a9f:	e8 3c fd ff ff       	call   8007e0 <getint>
  800aa4:	83 c4 10             	add    $0x10,%esp
  800aa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aaa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab3:	85 d2                	test   %edx,%edx
  800ab5:	79 23                	jns    800ada <vprintfmt+0x29b>
				putch('-', putdat);
  800ab7:	83 ec 08             	sub    $0x8,%esp
  800aba:	ff 75 0c             	pushl  0xc(%ebp)
  800abd:	6a 2d                	push   $0x2d
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800acd:	f7 d8                	neg    %eax
  800acf:	83 d2 00             	adc    $0x0,%edx
  800ad2:	f7 da                	neg    %edx
  800ad4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ada:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ae1:	e9 bc 00 00 00       	jmp    800ba2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ae6:	83 ec 08             	sub    $0x8,%esp
  800ae9:	ff 75 e8             	pushl  -0x18(%ebp)
  800aec:	8d 45 14             	lea    0x14(%ebp),%eax
  800aef:	50                   	push   %eax
  800af0:	e8 84 fc ff ff       	call   800779 <getuint>
  800af5:	83 c4 10             	add    $0x10,%esp
  800af8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800afb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800afe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b05:	e9 98 00 00 00       	jmp    800ba2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b0a:	83 ec 08             	sub    $0x8,%esp
  800b0d:	ff 75 0c             	pushl  0xc(%ebp)
  800b10:	6a 58                	push   $0x58
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	ff d0                	call   *%eax
  800b17:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b1a:	83 ec 08             	sub    $0x8,%esp
  800b1d:	ff 75 0c             	pushl  0xc(%ebp)
  800b20:	6a 58                	push   $0x58
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	ff d0                	call   *%eax
  800b27:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b2a:	83 ec 08             	sub    $0x8,%esp
  800b2d:	ff 75 0c             	pushl  0xc(%ebp)
  800b30:	6a 58                	push   $0x58
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	ff d0                	call   *%eax
  800b37:	83 c4 10             	add    $0x10,%esp
			break;
  800b3a:	e9 ce 00 00 00       	jmp    800c0d <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b3f:	83 ec 08             	sub    $0x8,%esp
  800b42:	ff 75 0c             	pushl  0xc(%ebp)
  800b45:	6a 30                	push   $0x30
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	ff d0                	call   *%eax
  800b4c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b4f:	83 ec 08             	sub    $0x8,%esp
  800b52:	ff 75 0c             	pushl  0xc(%ebp)
  800b55:	6a 78                	push   $0x78
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	ff d0                	call   *%eax
  800b5c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b62:	83 c0 04             	add    $0x4,%eax
  800b65:	89 45 14             	mov    %eax,0x14(%ebp)
  800b68:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6b:	83 e8 04             	sub    $0x4,%eax
  800b6e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b7a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b81:	eb 1f                	jmp    800ba2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 e8             	pushl  -0x18(%ebp)
  800b89:	8d 45 14             	lea    0x14(%ebp),%eax
  800b8c:	50                   	push   %eax
  800b8d:	e8 e7 fb ff ff       	call   800779 <getuint>
  800b92:	83 c4 10             	add    $0x10,%esp
  800b95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b98:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b9b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ba2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ba6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ba9:	83 ec 04             	sub    $0x4,%esp
  800bac:	52                   	push   %edx
  800bad:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bb0:	50                   	push   %eax
  800bb1:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb4:	ff 75 f0             	pushl  -0x10(%ebp)
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	ff 75 08             	pushl  0x8(%ebp)
  800bbd:	e8 00 fb ff ff       	call   8006c2 <printnum>
  800bc2:	83 c4 20             	add    $0x20,%esp
			break;
  800bc5:	eb 46                	jmp    800c0d <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 0c             	pushl  0xc(%ebp)
  800bcd:	53                   	push   %ebx
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	ff d0                	call   *%eax
  800bd3:	83 c4 10             	add    $0x10,%esp
			break;
  800bd6:	eb 35                	jmp    800c0d <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800bd8:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800bdf:	eb 2c                	jmp    800c0d <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800be1:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800be8:	eb 23                	jmp    800c0d <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bea:	83 ec 08             	sub    $0x8,%esp
  800bed:	ff 75 0c             	pushl  0xc(%ebp)
  800bf0:	6a 25                	push   $0x25
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	ff d0                	call   *%eax
  800bf7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bfa:	ff 4d 10             	decl   0x10(%ebp)
  800bfd:	eb 03                	jmp    800c02 <vprintfmt+0x3c3>
  800bff:	ff 4d 10             	decl   0x10(%ebp)
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	48                   	dec    %eax
  800c06:	8a 00                	mov    (%eax),%al
  800c08:	3c 25                	cmp    $0x25,%al
  800c0a:	75 f3                	jne    800bff <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c0c:	90                   	nop
		}
	}
  800c0d:	e9 35 fc ff ff       	jmp    800847 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c12:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c13:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c16:	5b                   	pop    %ebx
  800c17:	5e                   	pop    %esi
  800c18:	5d                   	pop    %ebp
  800c19:	c3                   	ret    

00800c1a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c1a:	55                   	push   %ebp
  800c1b:	89 e5                	mov    %esp,%ebp
  800c1d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c20:	8d 45 10             	lea    0x10(%ebp),%eax
  800c23:	83 c0 04             	add    $0x4,%eax
  800c26:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c29:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2f:	50                   	push   %eax
  800c30:	ff 75 0c             	pushl  0xc(%ebp)
  800c33:	ff 75 08             	pushl  0x8(%ebp)
  800c36:	e8 04 fc ff ff       	call   80083f <vprintfmt>
  800c3b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c3e:	90                   	nop
  800c3f:	c9                   	leave  
  800c40:	c3                   	ret    

00800c41 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c41:	55                   	push   %ebp
  800c42:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	8b 40 08             	mov    0x8(%eax),%eax
  800c4a:	8d 50 01             	lea    0x1(%eax),%edx
  800c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c50:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c56:	8b 10                	mov    (%eax),%edx
  800c58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5b:	8b 40 04             	mov    0x4(%eax),%eax
  800c5e:	39 c2                	cmp    %eax,%edx
  800c60:	73 12                	jae    800c74 <sprintputch+0x33>
		*b->buf++ = ch;
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	8b 00                	mov    (%eax),%eax
  800c67:	8d 48 01             	lea    0x1(%eax),%ecx
  800c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c6d:	89 0a                	mov    %ecx,(%edx)
  800c6f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c72:	88 10                	mov    %dl,(%eax)
}
  800c74:	90                   	nop
  800c75:	5d                   	pop    %ebp
  800c76:	c3                   	ret    

00800c77 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c77:	55                   	push   %ebp
  800c78:	89 e5                	mov    %esp,%ebp
  800c7a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c86:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	01 d0                	add    %edx,%eax
  800c8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c98:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c9c:	74 06                	je     800ca4 <vsnprintf+0x2d>
  800c9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca2:	7f 07                	jg     800cab <vsnprintf+0x34>
		return -E_INVAL;
  800ca4:	b8 03 00 00 00       	mov    $0x3,%eax
  800ca9:	eb 20                	jmp    800ccb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cab:	ff 75 14             	pushl  0x14(%ebp)
  800cae:	ff 75 10             	pushl  0x10(%ebp)
  800cb1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cb4:	50                   	push   %eax
  800cb5:	68 41 0c 80 00       	push   $0x800c41
  800cba:	e8 80 fb ff ff       	call   80083f <vprintfmt>
  800cbf:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ccb:	c9                   	leave  
  800ccc:	c3                   	ret    

00800ccd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ccd:	55                   	push   %ebp
  800cce:	89 e5                	mov    %esp,%ebp
  800cd0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cd3:	8d 45 10             	lea    0x10(%ebp),%eax
  800cd6:	83 c0 04             	add    $0x4,%eax
  800cd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce2:	50                   	push   %eax
  800ce3:	ff 75 0c             	pushl  0xc(%ebp)
  800ce6:	ff 75 08             	pushl  0x8(%ebp)
  800ce9:	e8 89 ff ff ff       	call   800c77 <vsnprintf>
  800cee:	83 c4 10             	add    $0x10,%esp
  800cf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf7:	c9                   	leave  
  800cf8:	c3                   	ret    

00800cf9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
  800cfc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d06:	eb 06                	jmp    800d0e <strlen+0x15>
		n++;
  800d08:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d0b:	ff 45 08             	incl   0x8(%ebp)
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	84 c0                	test   %al,%al
  800d15:	75 f1                	jne    800d08 <strlen+0xf>
		n++;
	return n;
  800d17:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d1a:	c9                   	leave  
  800d1b:	c3                   	ret    

00800d1c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
  800d1f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d29:	eb 09                	jmp    800d34 <strnlen+0x18>
		n++;
  800d2b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d2e:	ff 45 08             	incl   0x8(%ebp)
  800d31:	ff 4d 0c             	decl   0xc(%ebp)
  800d34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d38:	74 09                	je     800d43 <strnlen+0x27>
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	84 c0                	test   %al,%al
  800d41:	75 e8                	jne    800d2b <strnlen+0xf>
		n++;
	return n;
  800d43:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d46:	c9                   	leave  
  800d47:	c3                   	ret    

00800d48 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d48:	55                   	push   %ebp
  800d49:	89 e5                	mov    %esp,%ebp
  800d4b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d54:	90                   	nop
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8d 50 01             	lea    0x1(%eax),%edx
  800d5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800d5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d61:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d64:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d67:	8a 12                	mov    (%edx),%dl
  800d69:	88 10                	mov    %dl,(%eax)
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	84 c0                	test   %al,%al
  800d6f:	75 e4                	jne    800d55 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d74:	c9                   	leave  
  800d75:	c3                   	ret    

00800d76 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d76:	55                   	push   %ebp
  800d77:	89 e5                	mov    %esp,%ebp
  800d79:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d89:	eb 1f                	jmp    800daa <strncpy+0x34>
		*dst++ = *src;
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8d 50 01             	lea    0x1(%eax),%edx
  800d91:	89 55 08             	mov    %edx,0x8(%ebp)
  800d94:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d97:	8a 12                	mov    (%edx),%dl
  800d99:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	84 c0                	test   %al,%al
  800da2:	74 03                	je     800da7 <strncpy+0x31>
			src++;
  800da4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800da7:	ff 45 fc             	incl   -0x4(%ebp)
  800daa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dad:	3b 45 10             	cmp    0x10(%ebp),%eax
  800db0:	72 d9                	jb     800d8b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800db2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db5:	c9                   	leave  
  800db6:	c3                   	ret    

00800db7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800db7:	55                   	push   %ebp
  800db8:	89 e5                	mov    %esp,%ebp
  800dba:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dc3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc7:	74 30                	je     800df9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dc9:	eb 16                	jmp    800de1 <strlcpy+0x2a>
			*dst++ = *src++;
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8d 50 01             	lea    0x1(%eax),%edx
  800dd1:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dda:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ddd:	8a 12                	mov    (%edx),%dl
  800ddf:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800de1:	ff 4d 10             	decl   0x10(%ebp)
  800de4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de8:	74 09                	je     800df3 <strlcpy+0x3c>
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	84 c0                	test   %al,%al
  800df1:	75 d8                	jne    800dcb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800df9:	8b 55 08             	mov    0x8(%ebp),%edx
  800dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dff:	29 c2                	sub    %eax,%edx
  800e01:	89 d0                	mov    %edx,%eax
}
  800e03:	c9                   	leave  
  800e04:	c3                   	ret    

00800e05 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e05:	55                   	push   %ebp
  800e06:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e08:	eb 06                	jmp    800e10 <strcmp+0xb>
		p++, q++;
  800e0a:	ff 45 08             	incl   0x8(%ebp)
  800e0d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	84 c0                	test   %al,%al
  800e17:	74 0e                	je     800e27 <strcmp+0x22>
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	8a 10                	mov    (%eax),%dl
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8a 00                	mov    (%eax),%al
  800e23:	38 c2                	cmp    %al,%dl
  800e25:	74 e3                	je     800e0a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	0f b6 d0             	movzbl %al,%edx
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	8a 00                	mov    (%eax),%al
  800e34:	0f b6 c0             	movzbl %al,%eax
  800e37:	29 c2                	sub    %eax,%edx
  800e39:	89 d0                	mov    %edx,%eax
}
  800e3b:	5d                   	pop    %ebp
  800e3c:	c3                   	ret    

00800e3d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e40:	eb 09                	jmp    800e4b <strncmp+0xe>
		n--, p++, q++;
  800e42:	ff 4d 10             	decl   0x10(%ebp)
  800e45:	ff 45 08             	incl   0x8(%ebp)
  800e48:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e4f:	74 17                	je     800e68 <strncmp+0x2b>
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	84 c0                	test   %al,%al
  800e58:	74 0e                	je     800e68 <strncmp+0x2b>
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8a 10                	mov    (%eax),%dl
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	38 c2                	cmp    %al,%dl
  800e66:	74 da                	je     800e42 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6c:	75 07                	jne    800e75 <strncmp+0x38>
		return 0;
  800e6e:	b8 00 00 00 00       	mov    $0x0,%eax
  800e73:	eb 14                	jmp    800e89 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	8a 00                	mov    (%eax),%al
  800e7a:	0f b6 d0             	movzbl %al,%edx
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	8a 00                	mov    (%eax),%al
  800e82:	0f b6 c0             	movzbl %al,%eax
  800e85:	29 c2                	sub    %eax,%edx
  800e87:	89 d0                	mov    %edx,%eax
}
  800e89:	5d                   	pop    %ebp
  800e8a:	c3                   	ret    

00800e8b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e8b:	55                   	push   %ebp
  800e8c:	89 e5                	mov    %esp,%ebp
  800e8e:	83 ec 04             	sub    $0x4,%esp
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e97:	eb 12                	jmp    800eab <strchr+0x20>
		if (*s == c)
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	8a 00                	mov    (%eax),%al
  800e9e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ea1:	75 05                	jne    800ea8 <strchr+0x1d>
			return (char *) s;
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	eb 11                	jmp    800eb9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ea8:	ff 45 08             	incl   0x8(%ebp)
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	84 c0                	test   %al,%al
  800eb2:	75 e5                	jne    800e99 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 04             	sub    $0x4,%esp
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ec7:	eb 0d                	jmp    800ed6 <strfind+0x1b>
		if (*s == c)
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed1:	74 0e                	je     800ee1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ed3:	ff 45 08             	incl   0x8(%ebp)
  800ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed9:	8a 00                	mov    (%eax),%al
  800edb:	84 c0                	test   %al,%al
  800edd:	75 ea                	jne    800ec9 <strfind+0xe>
  800edf:	eb 01                	jmp    800ee2 <strfind+0x27>
		if (*s == c)
			break;
  800ee1:	90                   	nop
	return (char *) s;
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee5:	c9                   	leave  
  800ee6:	c3                   	ret    

00800ee7 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800ee7:	55                   	push   %ebp
  800ee8:	89 e5                	mov    %esp,%ebp
  800eea:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800ef3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ef7:	76 63                	jbe    800f5c <memset+0x75>
		uint64 data_block = c;
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	99                   	cltd   
  800efd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f00:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f09:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f0d:	c1 e0 08             	shl    $0x8,%eax
  800f10:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f13:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1c:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f20:	c1 e0 10             	shl    $0x10,%eax
  800f23:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f26:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f2f:	89 c2                	mov    %eax,%edx
  800f31:	b8 00 00 00 00       	mov    $0x0,%eax
  800f36:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f39:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f3c:	eb 18                	jmp    800f56 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f3e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f41:	8d 41 08             	lea    0x8(%ecx),%eax
  800f44:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f4d:	89 01                	mov    %eax,(%ecx)
  800f4f:	89 51 04             	mov    %edx,0x4(%ecx)
  800f52:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f56:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f5a:	77 e2                	ja     800f3e <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f60:	74 23                	je     800f85 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f65:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f68:	eb 0e                	jmp    800f78 <memset+0x91>
			*p8++ = (uint8)c;
  800f6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f6d:	8d 50 01             	lea    0x1(%eax),%edx
  800f70:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f76:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f78:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f7e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f81:	85 c0                	test   %eax,%eax
  800f83:	75 e5                	jne    800f6a <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f88:	c9                   	leave  
  800f89:	c3                   	ret    

00800f8a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f8a:	55                   	push   %ebp
  800f8b:	89 e5                	mov    %esp,%ebp
  800f8d:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f9c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fa0:	76 24                	jbe    800fc6 <memcpy+0x3c>
		while(n >= 8){
  800fa2:	eb 1c                	jmp    800fc0 <memcpy+0x36>
			*d64 = *s64;
  800fa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa7:	8b 50 04             	mov    0x4(%eax),%edx
  800faa:	8b 00                	mov    (%eax),%eax
  800fac:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800faf:	89 01                	mov    %eax,(%ecx)
  800fb1:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800fb4:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800fb8:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800fbc:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800fc0:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fc4:	77 de                	ja     800fa4 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800fc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fca:	74 31                	je     800ffd <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800fcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800fd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800fd8:	eb 16                	jmp    800ff0 <memcpy+0x66>
			*d8++ = *s8++;
  800fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fdd:	8d 50 01             	lea    0x1(%eax),%edx
  800fe0:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fe3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fe9:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800fec:	8a 12                	mov    (%edx),%dl
  800fee:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800ff0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ff9:	85 c0                	test   %eax,%eax
  800ffb:	75 dd                	jne    800fda <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801000:	c9                   	leave  
  801001:	c3                   	ret    

00801002 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801002:	55                   	push   %ebp
  801003:	89 e5                	mov    %esp,%ebp
  801005:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801008:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801014:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801017:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80101a:	73 50                	jae    80106c <memmove+0x6a>
  80101c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	01 d0                	add    %edx,%eax
  801024:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801027:	76 43                	jbe    80106c <memmove+0x6a>
		s += n;
  801029:	8b 45 10             	mov    0x10(%ebp),%eax
  80102c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80102f:	8b 45 10             	mov    0x10(%ebp),%eax
  801032:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801035:	eb 10                	jmp    801047 <memmove+0x45>
			*--d = *--s;
  801037:	ff 4d f8             	decl   -0x8(%ebp)
  80103a:	ff 4d fc             	decl   -0x4(%ebp)
  80103d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801040:	8a 10                	mov    (%eax),%dl
  801042:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801045:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801047:	8b 45 10             	mov    0x10(%ebp),%eax
  80104a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104d:	89 55 10             	mov    %edx,0x10(%ebp)
  801050:	85 c0                	test   %eax,%eax
  801052:	75 e3                	jne    801037 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801054:	eb 23                	jmp    801079 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801056:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801059:	8d 50 01             	lea    0x1(%eax),%edx
  80105c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80105f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801062:	8d 4a 01             	lea    0x1(%edx),%ecx
  801065:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801068:	8a 12                	mov    (%edx),%dl
  80106a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80106c:	8b 45 10             	mov    0x10(%ebp),%eax
  80106f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801072:	89 55 10             	mov    %edx,0x10(%ebp)
  801075:	85 c0                	test   %eax,%eax
  801077:	75 dd                	jne    801056 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80107c:	c9                   	leave  
  80107d:	c3                   	ret    

0080107e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80107e:	55                   	push   %ebp
  80107f:	89 e5                	mov    %esp,%ebp
  801081:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80108a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801090:	eb 2a                	jmp    8010bc <memcmp+0x3e>
		if (*s1 != *s2)
  801092:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801095:	8a 10                	mov    (%eax),%dl
  801097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	38 c2                	cmp    %al,%dl
  80109e:	74 16                	je     8010b6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a3:	8a 00                	mov    (%eax),%al
  8010a5:	0f b6 d0             	movzbl %al,%edx
  8010a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	0f b6 c0             	movzbl %al,%eax
  8010b0:	29 c2                	sub    %eax,%edx
  8010b2:	89 d0                	mov    %edx,%eax
  8010b4:	eb 18                	jmp    8010ce <memcmp+0x50>
		s1++, s2++;
  8010b6:	ff 45 fc             	incl   -0x4(%ebp)
  8010b9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010c5:	85 c0                	test   %eax,%eax
  8010c7:	75 c9                	jne    801092 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
  8010d3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010d6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010e1:	eb 15                	jmp    8010f8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	0f b6 d0             	movzbl %al,%edx
  8010eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ee:	0f b6 c0             	movzbl %al,%eax
  8010f1:	39 c2                	cmp    %eax,%edx
  8010f3:	74 0d                	je     801102 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010f5:	ff 45 08             	incl   0x8(%ebp)
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010fe:	72 e3                	jb     8010e3 <memfind+0x13>
  801100:	eb 01                	jmp    801103 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801102:	90                   	nop
	return (void *) s;
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801106:	c9                   	leave  
  801107:	c3                   	ret    

00801108 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801108:	55                   	push   %ebp
  801109:	89 e5                	mov    %esp,%ebp
  80110b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80110e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801115:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80111c:	eb 03                	jmp    801121 <strtol+0x19>
		s++;
  80111e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	3c 20                	cmp    $0x20,%al
  801128:	74 f4                	je     80111e <strtol+0x16>
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 09                	cmp    $0x9,%al
  801131:	74 eb                	je     80111e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3c 2b                	cmp    $0x2b,%al
  80113a:	75 05                	jne    801141 <strtol+0x39>
		s++;
  80113c:	ff 45 08             	incl   0x8(%ebp)
  80113f:	eb 13                	jmp    801154 <strtol+0x4c>
	else if (*s == '-')
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	8a 00                	mov    (%eax),%al
  801146:	3c 2d                	cmp    $0x2d,%al
  801148:	75 0a                	jne    801154 <strtol+0x4c>
		s++, neg = 1;
  80114a:	ff 45 08             	incl   0x8(%ebp)
  80114d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801154:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801158:	74 06                	je     801160 <strtol+0x58>
  80115a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80115e:	75 20                	jne    801180 <strtol+0x78>
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	8a 00                	mov    (%eax),%al
  801165:	3c 30                	cmp    $0x30,%al
  801167:	75 17                	jne    801180 <strtol+0x78>
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	40                   	inc    %eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 78                	cmp    $0x78,%al
  801171:	75 0d                	jne    801180 <strtol+0x78>
		s += 2, base = 16;
  801173:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801177:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80117e:	eb 28                	jmp    8011a8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801180:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801184:	75 15                	jne    80119b <strtol+0x93>
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	3c 30                	cmp    $0x30,%al
  80118d:	75 0c                	jne    80119b <strtol+0x93>
		s++, base = 8;
  80118f:	ff 45 08             	incl   0x8(%ebp)
  801192:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801199:	eb 0d                	jmp    8011a8 <strtol+0xa0>
	else if (base == 0)
  80119b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119f:	75 07                	jne    8011a8 <strtol+0xa0>
		base = 10;
  8011a1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	3c 2f                	cmp    $0x2f,%al
  8011af:	7e 19                	jle    8011ca <strtol+0xc2>
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	3c 39                	cmp    $0x39,%al
  8011b8:	7f 10                	jg     8011ca <strtol+0xc2>
			dig = *s - '0';
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	0f be c0             	movsbl %al,%eax
  8011c2:	83 e8 30             	sub    $0x30,%eax
  8011c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011c8:	eb 42                	jmp    80120c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	3c 60                	cmp    $0x60,%al
  8011d1:	7e 19                	jle    8011ec <strtol+0xe4>
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	3c 7a                	cmp    $0x7a,%al
  8011da:	7f 10                	jg     8011ec <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	0f be c0             	movsbl %al,%eax
  8011e4:	83 e8 57             	sub    $0x57,%eax
  8011e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ea:	eb 20                	jmp    80120c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ef:	8a 00                	mov    (%eax),%al
  8011f1:	3c 40                	cmp    $0x40,%al
  8011f3:	7e 39                	jle    80122e <strtol+0x126>
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3c 5a                	cmp    $0x5a,%al
  8011fc:	7f 30                	jg     80122e <strtol+0x126>
			dig = *s - 'A' + 10;
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	0f be c0             	movsbl %al,%eax
  801206:	83 e8 37             	sub    $0x37,%eax
  801209:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80120c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80120f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801212:	7d 19                	jge    80122d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801214:	ff 45 08             	incl   0x8(%ebp)
  801217:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80121e:	89 c2                	mov    %eax,%edx
  801220:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801223:	01 d0                	add    %edx,%eax
  801225:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801228:	e9 7b ff ff ff       	jmp    8011a8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80122d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80122e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801232:	74 08                	je     80123c <strtol+0x134>
		*endptr = (char *) s;
  801234:	8b 45 0c             	mov    0xc(%ebp),%eax
  801237:	8b 55 08             	mov    0x8(%ebp),%edx
  80123a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80123c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801240:	74 07                	je     801249 <strtol+0x141>
  801242:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801245:	f7 d8                	neg    %eax
  801247:	eb 03                	jmp    80124c <strtol+0x144>
  801249:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <ltostr>:

void
ltostr(long value, char *str)
{
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
  801251:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80125b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801262:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801266:	79 13                	jns    80127b <ltostr+0x2d>
	{
		neg = 1;
  801268:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80126f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801272:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801275:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801278:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801283:	99                   	cltd   
  801284:	f7 f9                	idiv   %ecx
  801286:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801289:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128c:	8d 50 01             	lea    0x1(%eax),%edx
  80128f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801292:	89 c2                	mov    %eax,%edx
  801294:	8b 45 0c             	mov    0xc(%ebp),%eax
  801297:	01 d0                	add    %edx,%eax
  801299:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80129c:	83 c2 30             	add    $0x30,%edx
  80129f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012a4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012a9:	f7 e9                	imul   %ecx
  8012ab:	c1 fa 02             	sar    $0x2,%edx
  8012ae:	89 c8                	mov    %ecx,%eax
  8012b0:	c1 f8 1f             	sar    $0x1f,%eax
  8012b3:	29 c2                	sub    %eax,%edx
  8012b5:	89 d0                	mov    %edx,%eax
  8012b7:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012be:	75 bb                	jne    80127b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ca:	48                   	dec    %eax
  8012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012ce:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012d2:	74 3d                	je     801311 <ltostr+0xc3>
		start = 1 ;
  8012d4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012db:	eb 34                	jmp    801311 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e3:	01 d0                	add    %edx,%eax
  8012e5:	8a 00                	mov    (%eax),%al
  8012e7:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f0:	01 c2                	add    %eax,%edx
  8012f2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f8:	01 c8                	add    %ecx,%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801301:	8b 45 0c             	mov    0xc(%ebp),%eax
  801304:	01 c2                	add    %eax,%edx
  801306:	8a 45 eb             	mov    -0x15(%ebp),%al
  801309:	88 02                	mov    %al,(%edx)
		start++ ;
  80130b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80130e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801311:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801314:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801317:	7c c4                	jl     8012dd <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801319:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80131c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131f:	01 d0                	add    %edx,%eax
  801321:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801324:	90                   	nop
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80132d:	ff 75 08             	pushl  0x8(%ebp)
  801330:	e8 c4 f9 ff ff       	call   800cf9 <strlen>
  801335:	83 c4 04             	add    $0x4,%esp
  801338:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80133b:	ff 75 0c             	pushl  0xc(%ebp)
  80133e:	e8 b6 f9 ff ff       	call   800cf9 <strlen>
  801343:	83 c4 04             	add    $0x4,%esp
  801346:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801349:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801350:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801357:	eb 17                	jmp    801370 <strcconcat+0x49>
		final[s] = str1[s] ;
  801359:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80135c:	8b 45 10             	mov    0x10(%ebp),%eax
  80135f:	01 c2                	add    %eax,%edx
  801361:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	01 c8                	add    %ecx,%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80136d:	ff 45 fc             	incl   -0x4(%ebp)
  801370:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801373:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801376:	7c e1                	jl     801359 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801378:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80137f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801386:	eb 1f                	jmp    8013a7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801388:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80138b:	8d 50 01             	lea    0x1(%eax),%edx
  80138e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801391:	89 c2                	mov    %eax,%edx
  801393:	8b 45 10             	mov    0x10(%ebp),%eax
  801396:	01 c2                	add    %eax,%edx
  801398:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80139b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139e:	01 c8                	add    %ecx,%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013a4:	ff 45 f8             	incl   -0x8(%ebp)
  8013a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ad:	7c d9                	jl     801388 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b5:	01 d0                	add    %edx,%eax
  8013b7:	c6 00 00             	movb   $0x0,(%eax)
}
  8013ba:	90                   	nop
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cc:	8b 00                	mov    (%eax),%eax
  8013ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d8:	01 d0                	add    %edx,%eax
  8013da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013e0:	eb 0c                	jmp    8013ee <strsplit+0x31>
			*string++ = 0;
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	8d 50 01             	lea    0x1(%eax),%edx
  8013e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8013eb:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	84 c0                	test   %al,%al
  8013f5:	74 18                	je     80140f <strsplit+0x52>
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	0f be c0             	movsbl %al,%eax
  8013ff:	50                   	push   %eax
  801400:	ff 75 0c             	pushl  0xc(%ebp)
  801403:	e8 83 fa ff ff       	call   800e8b <strchr>
  801408:	83 c4 08             	add    $0x8,%esp
  80140b:	85 c0                	test   %eax,%eax
  80140d:	75 d3                	jne    8013e2 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	84 c0                	test   %al,%al
  801416:	74 5a                	je     801472 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801418:	8b 45 14             	mov    0x14(%ebp),%eax
  80141b:	8b 00                	mov    (%eax),%eax
  80141d:	83 f8 0f             	cmp    $0xf,%eax
  801420:	75 07                	jne    801429 <strsplit+0x6c>
		{
			return 0;
  801422:	b8 00 00 00 00       	mov    $0x0,%eax
  801427:	eb 66                	jmp    80148f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801429:	8b 45 14             	mov    0x14(%ebp),%eax
  80142c:	8b 00                	mov    (%eax),%eax
  80142e:	8d 48 01             	lea    0x1(%eax),%ecx
  801431:	8b 55 14             	mov    0x14(%ebp),%edx
  801434:	89 0a                	mov    %ecx,(%edx)
  801436:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80143d:	8b 45 10             	mov    0x10(%ebp),%eax
  801440:	01 c2                	add    %eax,%edx
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801447:	eb 03                	jmp    80144c <strsplit+0x8f>
			string++;
  801449:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	84 c0                	test   %al,%al
  801453:	74 8b                	je     8013e0 <strsplit+0x23>
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	0f be c0             	movsbl %al,%eax
  80145d:	50                   	push   %eax
  80145e:	ff 75 0c             	pushl  0xc(%ebp)
  801461:	e8 25 fa ff ff       	call   800e8b <strchr>
  801466:	83 c4 08             	add    $0x8,%esp
  801469:	85 c0                	test   %eax,%eax
  80146b:	74 dc                	je     801449 <strsplit+0x8c>
			string++;
	}
  80146d:	e9 6e ff ff ff       	jmp    8013e0 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801472:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801473:	8b 45 14             	mov    0x14(%ebp),%eax
  801476:	8b 00                	mov    (%eax),%eax
  801478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147f:	8b 45 10             	mov    0x10(%ebp),%eax
  801482:	01 d0                	add    %edx,%eax
  801484:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80148a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
  801494:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80149d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a4:	eb 4a                	jmp    8014f0 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	01 c2                	add    %eax,%edx
  8014ae:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b4:	01 c8                	add    %ecx,%eax
  8014b6:	8a 00                	mov    (%eax),%al
  8014b8:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c0:	01 d0                	add    %edx,%eax
  8014c2:	8a 00                	mov    (%eax),%al
  8014c4:	3c 40                	cmp    $0x40,%al
  8014c6:	7e 25                	jle    8014ed <str2lower+0x5c>
  8014c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ce:	01 d0                	add    %edx,%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	3c 5a                	cmp    $0x5a,%al
  8014d4:	7f 17                	jg     8014ed <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8014d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dc:	01 d0                	add    %edx,%eax
  8014de:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014e1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014e4:	01 ca                	add    %ecx,%edx
  8014e6:	8a 12                	mov    (%edx),%dl
  8014e8:	83 c2 20             	add    $0x20,%edx
  8014eb:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014ed:	ff 45 fc             	incl   -0x4(%ebp)
  8014f0:	ff 75 0c             	pushl  0xc(%ebp)
  8014f3:	e8 01 f8 ff ff       	call   800cf9 <strlen>
  8014f8:	83 c4 04             	add    $0x4,%esp
  8014fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014fe:	7f a6                	jg     8014a6 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801500:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
  801508:	57                   	push   %edi
  801509:	56                   	push   %esi
  80150a:	53                   	push   %ebx
  80150b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	8b 55 0c             	mov    0xc(%ebp),%edx
  801514:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801517:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80151a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80151d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801520:	cd 30                	int    $0x30
  801522:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801525:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801528:	83 c4 10             	add    $0x10,%esp
  80152b:	5b                   	pop    %ebx
  80152c:	5e                   	pop    %esi
  80152d:	5f                   	pop    %edi
  80152e:	5d                   	pop    %ebp
  80152f:	c3                   	ret    

00801530 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 04             	sub    $0x4,%esp
  801536:	8b 45 10             	mov    0x10(%ebp),%eax
  801539:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80153c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80153f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	6a 00                	push   $0x0
  801548:	51                   	push   %ecx
  801549:	52                   	push   %edx
  80154a:	ff 75 0c             	pushl  0xc(%ebp)
  80154d:	50                   	push   %eax
  80154e:	6a 00                	push   $0x0
  801550:	e8 b0 ff ff ff       	call   801505 <syscall>
  801555:	83 c4 18             	add    $0x18,%esp
}
  801558:	90                   	nop
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_cgetc>:

int
sys_cgetc(void)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 02                	push   $0x2
  80156a:	e8 96 ff ff ff       	call   801505 <syscall>
  80156f:	83 c4 18             	add    $0x18,%esp
}
  801572:	c9                   	leave  
  801573:	c3                   	ret    

00801574 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801574:	55                   	push   %ebp
  801575:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 03                	push   $0x3
  801583:	e8 7d ff ff ff       	call   801505 <syscall>
  801588:	83 c4 18             	add    $0x18,%esp
}
  80158b:	90                   	nop
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 04                	push   $0x4
  80159d:	e8 63 ff ff ff       	call   801505 <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	90                   	nop
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	52                   	push   %edx
  8015b8:	50                   	push   %eax
  8015b9:	6a 08                	push   $0x8
  8015bb:	e8 45 ff ff ff       	call   801505 <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	56                   	push   %esi
  8015c9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015ca:	8b 75 18             	mov    0x18(%ebp),%esi
  8015cd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015d0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	56                   	push   %esi
  8015da:	53                   	push   %ebx
  8015db:	51                   	push   %ecx
  8015dc:	52                   	push   %edx
  8015dd:	50                   	push   %eax
  8015de:	6a 09                	push   $0x9
  8015e0:	e8 20 ff ff ff       	call   801505 <syscall>
  8015e5:	83 c4 18             	add    $0x18,%esp
}
  8015e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015eb:	5b                   	pop    %ebx
  8015ec:	5e                   	pop    %esi
  8015ed:	5d                   	pop    %ebp
  8015ee:	c3                   	ret    

008015ef <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	ff 75 08             	pushl  0x8(%ebp)
  8015fd:	6a 0a                	push   $0xa
  8015ff:	e8 01 ff ff ff       	call   801505 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	ff 75 0c             	pushl  0xc(%ebp)
  801615:	ff 75 08             	pushl  0x8(%ebp)
  801618:	6a 0b                	push   $0xb
  80161a:	e8 e6 fe ff ff       	call   801505 <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 0c                	push   $0xc
  801633:	e8 cd fe ff ff       	call   801505 <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 0d                	push   $0xd
  80164c:	e8 b4 fe ff ff       	call   801505 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 0e                	push   $0xe
  801665:	e8 9b fe ff ff       	call   801505 <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 0f                	push   $0xf
  80167e:	e8 82 fe ff ff       	call   801505 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	ff 75 08             	pushl  0x8(%ebp)
  801696:	6a 10                	push   $0x10
  801698:	e8 68 fe ff ff       	call   801505 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 11                	push   $0x11
  8016b1:	e8 4f fe ff ff       	call   801505 <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
}
  8016b9:	90                   	nop
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_cputc>:

void
sys_cputc(const char c)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	83 ec 04             	sub    $0x4,%esp
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016c8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	50                   	push   %eax
  8016d5:	6a 01                	push   $0x1
  8016d7:	e8 29 fe ff ff       	call   801505 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	90                   	nop
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 14                	push   $0x14
  8016f1:	e8 0f fe ff ff       	call   801505 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	90                   	nop
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
  8016ff:	83 ec 04             	sub    $0x4,%esp
  801702:	8b 45 10             	mov    0x10(%ebp),%eax
  801705:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801708:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80170b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	6a 00                	push   $0x0
  801714:	51                   	push   %ecx
  801715:	52                   	push   %edx
  801716:	ff 75 0c             	pushl  0xc(%ebp)
  801719:	50                   	push   %eax
  80171a:	6a 15                	push   $0x15
  80171c:	e8 e4 fd ff ff       	call   801505 <syscall>
  801721:	83 c4 18             	add    $0x18,%esp
}
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801729:	8b 55 10             	mov    0x10(%ebp),%edx
  80172c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	52                   	push   %edx
  801734:	50                   	push   %eax
  801735:	ff 75 08             	pushl  0x8(%ebp)
  801738:	6a 16                	push   $0x16
  80173a:	e8 c6 fd ff ff       	call   801505 <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
}
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801744:	55                   	push   %ebp
  801745:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801747:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	52                   	push   %edx
  801754:	50                   	push   %eax
  801755:	6a 17                	push   $0x17
  801757:	e8 a9 fd ff ff       	call   801505 <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
}
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801764:	8b 55 0c             	mov    0xc(%ebp),%edx
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	52                   	push   %edx
  801771:	50                   	push   %eax
  801772:	6a 18                	push   $0x18
  801774:	e8 8c fd ff ff       	call   801505 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	6a 00                	push   $0x0
  801786:	ff 75 14             	pushl  0x14(%ebp)
  801789:	ff 75 10             	pushl  0x10(%ebp)
  80178c:	ff 75 0c             	pushl  0xc(%ebp)
  80178f:	50                   	push   %eax
  801790:	6a 19                	push   $0x19
  801792:	e8 6e fd ff ff       	call   801505 <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_run_env>:

void sys_run_env(int32 envId)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	50                   	push   %eax
  8017ab:	6a 1a                	push   $0x1a
  8017ad:	e8 53 fd ff ff       	call   801505 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	90                   	nop
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	50                   	push   %eax
  8017c7:	6a 1b                	push   $0x1b
  8017c9:	e8 37 fd ff ff       	call   801505 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	c9                   	leave  
  8017d2:	c3                   	ret    

008017d3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 05                	push   $0x5
  8017e2:	e8 1e fd ff ff       	call   801505 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 06                	push   $0x6
  8017fb:	e8 05 fd ff ff       	call   801505 <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
}
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 07                	push   $0x7
  801814:	e8 ec fc ff ff       	call   801505 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
}
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <sys_exit_env>:


void sys_exit_env(void)
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 1c                	push   $0x1c
  80182d:	e8 d3 fc ff ff       	call   801505 <syscall>
  801832:	83 c4 18             	add    $0x18,%esp
}
  801835:	90                   	nop
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	ff 75 10             	pushl  0x10(%ebp)
  801842:	ff 75 0c             	pushl  0xc(%ebp)
  801845:	ff 75 08             	pushl  0x8(%ebp)
  801848:	6a 13                	push   $0x13
  80184a:	e8 b6 fc ff ff       	call   801505 <syscall>
  80184f:	83 c4 18             	add    $0x18,%esp
	return ;
  801852:	90                   	nop
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_rcr2>:
uint32 sys_rcr2()
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 1e                	push   $0x1e
  801864:	e8 9c fc ff ff       	call   801505 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
  801871:	83 ec 04             	sub    $0x4,%esp
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80187a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	50                   	push   %eax
  801887:	6a 1f                	push   $0x1f
  801889:	e8 77 fc ff ff       	call   801505 <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
	return ;
  801891:	90                   	nop
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <rsttst>:
void rsttst()
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 21                	push   $0x21
  8018a3:	e8 5d fc ff ff       	call   801505 <syscall>
  8018a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ab:	90                   	nop
}
  8018ac:	c9                   	leave  
  8018ad:	c3                   	ret    

008018ae <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018ae:	55                   	push   %ebp
  8018af:	89 e5                	mov    %esp,%ebp
  8018b1:	83 ec 04             	sub    $0x4,%esp
  8018b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018ba:	8b 55 18             	mov    0x18(%ebp),%edx
  8018bd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018c1:	52                   	push   %edx
  8018c2:	50                   	push   %eax
  8018c3:	ff 75 10             	pushl  0x10(%ebp)
  8018c6:	ff 75 0c             	pushl  0xc(%ebp)
  8018c9:	ff 75 08             	pushl  0x8(%ebp)
  8018cc:	6a 20                	push   $0x20
  8018ce:	e8 32 fc ff ff       	call   801505 <syscall>
  8018d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d6:	90                   	nop
}
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <chktst>:
void chktst(uint32 n)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	ff 75 08             	pushl  0x8(%ebp)
  8018e7:	6a 22                	push   $0x22
  8018e9:	e8 17 fc ff ff       	call   801505 <syscall>
  8018ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f1:	90                   	nop
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <inctst>:

void inctst()
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 23                	push   $0x23
  801903:	e8 fd fb ff ff       	call   801505 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
	return ;
  80190b:	90                   	nop
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <gettst>:
uint32 gettst()
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 24                	push   $0x24
  80191d:	e8 e3 fb ff ff       	call   801505 <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 25                	push   $0x25
  801936:	e8 ca fb ff ff       	call   801505 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
  80193e:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801943:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80194d:	8b 45 08             	mov    0x8(%ebp),%eax
  801950:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	ff 75 08             	pushl  0x8(%ebp)
  801960:	6a 26                	push   $0x26
  801962:	e8 9e fb ff ff       	call   801505 <syscall>
  801967:	83 c4 18             	add    $0x18,%esp
	return ;
  80196a:	90                   	nop
}
  80196b:	c9                   	leave  
  80196c:	c3                   	ret    

0080196d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80196d:	55                   	push   %ebp
  80196e:	89 e5                	mov    %esp,%ebp
  801970:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801971:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801974:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801977:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197a:	8b 45 08             	mov    0x8(%ebp),%eax
  80197d:	6a 00                	push   $0x0
  80197f:	53                   	push   %ebx
  801980:	51                   	push   %ecx
  801981:	52                   	push   %edx
  801982:	50                   	push   %eax
  801983:	6a 27                	push   $0x27
  801985:	e8 7b fb ff ff       	call   801505 <syscall>
  80198a:	83 c4 18             	add    $0x18,%esp
}
  80198d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801995:	8b 55 0c             	mov    0xc(%ebp),%edx
  801998:	8b 45 08             	mov    0x8(%ebp),%eax
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	52                   	push   %edx
  8019a2:	50                   	push   %eax
  8019a3:	6a 28                	push   $0x28
  8019a5:	e8 5b fb ff ff       	call   801505 <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8019b2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	6a 00                	push   $0x0
  8019bd:	51                   	push   %ecx
  8019be:	ff 75 10             	pushl  0x10(%ebp)
  8019c1:	52                   	push   %edx
  8019c2:	50                   	push   %eax
  8019c3:	6a 29                	push   $0x29
  8019c5:	e8 3b fb ff ff       	call   801505 <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	ff 75 10             	pushl  0x10(%ebp)
  8019d9:	ff 75 0c             	pushl  0xc(%ebp)
  8019dc:	ff 75 08             	pushl  0x8(%ebp)
  8019df:	6a 12                	push   $0x12
  8019e1:	e8 1f fb ff ff       	call   801505 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e9:	90                   	nop
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8019ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	52                   	push   %edx
  8019fc:	50                   	push   %eax
  8019fd:	6a 2a                	push   $0x2a
  8019ff:	e8 01 fb ff ff       	call   801505 <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
	return;
  801a07:	90                   	nop
}
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 2b                	push   $0x2b
  801a19:	e8 e7 fa ff ff       	call   801505 <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
}
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
  801a26:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801a29:	83 ec 04             	sub    $0x4,%esp
  801a2c:	68 48 24 80 00       	push   $0x802448
  801a31:	68 0a 01 00 00       	push   $0x10a
  801a36:	68 58 24 80 00       	push   $0x802458
  801a3b:	e8 12 e9 ff ff       	call   800352 <_panic>

00801a40 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	ff 75 0c             	pushl  0xc(%ebp)
  801a4c:	ff 75 08             	pushl  0x8(%ebp)
  801a4f:	6a 33                	push   $0x33
  801a51:	e8 af fa ff ff       	call   801505 <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
	return;
  801a59:	90                   	nop
}
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	ff 75 0c             	pushl  0xc(%ebp)
  801a68:	ff 75 08             	pushl  0x8(%ebp)
  801a6b:	6a 34                	push   $0x34
  801a6d:	e8 93 fa ff ff       	call   801505 <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
	return ;
  801a75:	90                   	nop
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <__udivdi3>:
  801a78:	55                   	push   %ebp
  801a79:	57                   	push   %edi
  801a7a:	56                   	push   %esi
  801a7b:	53                   	push   %ebx
  801a7c:	83 ec 1c             	sub    $0x1c,%esp
  801a7f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a83:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a87:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a8b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a8f:	89 ca                	mov    %ecx,%edx
  801a91:	89 f8                	mov    %edi,%eax
  801a93:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a97:	85 f6                	test   %esi,%esi
  801a99:	75 2d                	jne    801ac8 <__udivdi3+0x50>
  801a9b:	39 cf                	cmp    %ecx,%edi
  801a9d:	77 65                	ja     801b04 <__udivdi3+0x8c>
  801a9f:	89 fd                	mov    %edi,%ebp
  801aa1:	85 ff                	test   %edi,%edi
  801aa3:	75 0b                	jne    801ab0 <__udivdi3+0x38>
  801aa5:	b8 01 00 00 00       	mov    $0x1,%eax
  801aaa:	31 d2                	xor    %edx,%edx
  801aac:	f7 f7                	div    %edi
  801aae:	89 c5                	mov    %eax,%ebp
  801ab0:	31 d2                	xor    %edx,%edx
  801ab2:	89 c8                	mov    %ecx,%eax
  801ab4:	f7 f5                	div    %ebp
  801ab6:	89 c1                	mov    %eax,%ecx
  801ab8:	89 d8                	mov    %ebx,%eax
  801aba:	f7 f5                	div    %ebp
  801abc:	89 cf                	mov    %ecx,%edi
  801abe:	89 fa                	mov    %edi,%edx
  801ac0:	83 c4 1c             	add    $0x1c,%esp
  801ac3:	5b                   	pop    %ebx
  801ac4:	5e                   	pop    %esi
  801ac5:	5f                   	pop    %edi
  801ac6:	5d                   	pop    %ebp
  801ac7:	c3                   	ret    
  801ac8:	39 ce                	cmp    %ecx,%esi
  801aca:	77 28                	ja     801af4 <__udivdi3+0x7c>
  801acc:	0f bd fe             	bsr    %esi,%edi
  801acf:	83 f7 1f             	xor    $0x1f,%edi
  801ad2:	75 40                	jne    801b14 <__udivdi3+0x9c>
  801ad4:	39 ce                	cmp    %ecx,%esi
  801ad6:	72 0a                	jb     801ae2 <__udivdi3+0x6a>
  801ad8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801adc:	0f 87 9e 00 00 00    	ja     801b80 <__udivdi3+0x108>
  801ae2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae7:	89 fa                	mov    %edi,%edx
  801ae9:	83 c4 1c             	add    $0x1c,%esp
  801aec:	5b                   	pop    %ebx
  801aed:	5e                   	pop    %esi
  801aee:	5f                   	pop    %edi
  801aef:	5d                   	pop    %ebp
  801af0:	c3                   	ret    
  801af1:	8d 76 00             	lea    0x0(%esi),%esi
  801af4:	31 ff                	xor    %edi,%edi
  801af6:	31 c0                	xor    %eax,%eax
  801af8:	89 fa                	mov    %edi,%edx
  801afa:	83 c4 1c             	add    $0x1c,%esp
  801afd:	5b                   	pop    %ebx
  801afe:	5e                   	pop    %esi
  801aff:	5f                   	pop    %edi
  801b00:	5d                   	pop    %ebp
  801b01:	c3                   	ret    
  801b02:	66 90                	xchg   %ax,%ax
  801b04:	89 d8                	mov    %ebx,%eax
  801b06:	f7 f7                	div    %edi
  801b08:	31 ff                	xor    %edi,%edi
  801b0a:	89 fa                	mov    %edi,%edx
  801b0c:	83 c4 1c             	add    $0x1c,%esp
  801b0f:	5b                   	pop    %ebx
  801b10:	5e                   	pop    %esi
  801b11:	5f                   	pop    %edi
  801b12:	5d                   	pop    %ebp
  801b13:	c3                   	ret    
  801b14:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b19:	89 eb                	mov    %ebp,%ebx
  801b1b:	29 fb                	sub    %edi,%ebx
  801b1d:	89 f9                	mov    %edi,%ecx
  801b1f:	d3 e6                	shl    %cl,%esi
  801b21:	89 c5                	mov    %eax,%ebp
  801b23:	88 d9                	mov    %bl,%cl
  801b25:	d3 ed                	shr    %cl,%ebp
  801b27:	89 e9                	mov    %ebp,%ecx
  801b29:	09 f1                	or     %esi,%ecx
  801b2b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b2f:	89 f9                	mov    %edi,%ecx
  801b31:	d3 e0                	shl    %cl,%eax
  801b33:	89 c5                	mov    %eax,%ebp
  801b35:	89 d6                	mov    %edx,%esi
  801b37:	88 d9                	mov    %bl,%cl
  801b39:	d3 ee                	shr    %cl,%esi
  801b3b:	89 f9                	mov    %edi,%ecx
  801b3d:	d3 e2                	shl    %cl,%edx
  801b3f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b43:	88 d9                	mov    %bl,%cl
  801b45:	d3 e8                	shr    %cl,%eax
  801b47:	09 c2                	or     %eax,%edx
  801b49:	89 d0                	mov    %edx,%eax
  801b4b:	89 f2                	mov    %esi,%edx
  801b4d:	f7 74 24 0c          	divl   0xc(%esp)
  801b51:	89 d6                	mov    %edx,%esi
  801b53:	89 c3                	mov    %eax,%ebx
  801b55:	f7 e5                	mul    %ebp
  801b57:	39 d6                	cmp    %edx,%esi
  801b59:	72 19                	jb     801b74 <__udivdi3+0xfc>
  801b5b:	74 0b                	je     801b68 <__udivdi3+0xf0>
  801b5d:	89 d8                	mov    %ebx,%eax
  801b5f:	31 ff                	xor    %edi,%edi
  801b61:	e9 58 ff ff ff       	jmp    801abe <__udivdi3+0x46>
  801b66:	66 90                	xchg   %ax,%ax
  801b68:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b6c:	89 f9                	mov    %edi,%ecx
  801b6e:	d3 e2                	shl    %cl,%edx
  801b70:	39 c2                	cmp    %eax,%edx
  801b72:	73 e9                	jae    801b5d <__udivdi3+0xe5>
  801b74:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b77:	31 ff                	xor    %edi,%edi
  801b79:	e9 40 ff ff ff       	jmp    801abe <__udivdi3+0x46>
  801b7e:	66 90                	xchg   %ax,%ax
  801b80:	31 c0                	xor    %eax,%eax
  801b82:	e9 37 ff ff ff       	jmp    801abe <__udivdi3+0x46>
  801b87:	90                   	nop

00801b88 <__umoddi3>:
  801b88:	55                   	push   %ebp
  801b89:	57                   	push   %edi
  801b8a:	56                   	push   %esi
  801b8b:	53                   	push   %ebx
  801b8c:	83 ec 1c             	sub    $0x1c,%esp
  801b8f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b93:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b97:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b9b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b9f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ba3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ba7:	89 f3                	mov    %esi,%ebx
  801ba9:	89 fa                	mov    %edi,%edx
  801bab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801baf:	89 34 24             	mov    %esi,(%esp)
  801bb2:	85 c0                	test   %eax,%eax
  801bb4:	75 1a                	jne    801bd0 <__umoddi3+0x48>
  801bb6:	39 f7                	cmp    %esi,%edi
  801bb8:	0f 86 a2 00 00 00    	jbe    801c60 <__umoddi3+0xd8>
  801bbe:	89 c8                	mov    %ecx,%eax
  801bc0:	89 f2                	mov    %esi,%edx
  801bc2:	f7 f7                	div    %edi
  801bc4:	89 d0                	mov    %edx,%eax
  801bc6:	31 d2                	xor    %edx,%edx
  801bc8:	83 c4 1c             	add    $0x1c,%esp
  801bcb:	5b                   	pop    %ebx
  801bcc:	5e                   	pop    %esi
  801bcd:	5f                   	pop    %edi
  801bce:	5d                   	pop    %ebp
  801bcf:	c3                   	ret    
  801bd0:	39 f0                	cmp    %esi,%eax
  801bd2:	0f 87 ac 00 00 00    	ja     801c84 <__umoddi3+0xfc>
  801bd8:	0f bd e8             	bsr    %eax,%ebp
  801bdb:	83 f5 1f             	xor    $0x1f,%ebp
  801bde:	0f 84 ac 00 00 00    	je     801c90 <__umoddi3+0x108>
  801be4:	bf 20 00 00 00       	mov    $0x20,%edi
  801be9:	29 ef                	sub    %ebp,%edi
  801beb:	89 fe                	mov    %edi,%esi
  801bed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bf1:	89 e9                	mov    %ebp,%ecx
  801bf3:	d3 e0                	shl    %cl,%eax
  801bf5:	89 d7                	mov    %edx,%edi
  801bf7:	89 f1                	mov    %esi,%ecx
  801bf9:	d3 ef                	shr    %cl,%edi
  801bfb:	09 c7                	or     %eax,%edi
  801bfd:	89 e9                	mov    %ebp,%ecx
  801bff:	d3 e2                	shl    %cl,%edx
  801c01:	89 14 24             	mov    %edx,(%esp)
  801c04:	89 d8                	mov    %ebx,%eax
  801c06:	d3 e0                	shl    %cl,%eax
  801c08:	89 c2                	mov    %eax,%edx
  801c0a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c0e:	d3 e0                	shl    %cl,%eax
  801c10:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c14:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c18:	89 f1                	mov    %esi,%ecx
  801c1a:	d3 e8                	shr    %cl,%eax
  801c1c:	09 d0                	or     %edx,%eax
  801c1e:	d3 eb                	shr    %cl,%ebx
  801c20:	89 da                	mov    %ebx,%edx
  801c22:	f7 f7                	div    %edi
  801c24:	89 d3                	mov    %edx,%ebx
  801c26:	f7 24 24             	mull   (%esp)
  801c29:	89 c6                	mov    %eax,%esi
  801c2b:	89 d1                	mov    %edx,%ecx
  801c2d:	39 d3                	cmp    %edx,%ebx
  801c2f:	0f 82 87 00 00 00    	jb     801cbc <__umoddi3+0x134>
  801c35:	0f 84 91 00 00 00    	je     801ccc <__umoddi3+0x144>
  801c3b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c3f:	29 f2                	sub    %esi,%edx
  801c41:	19 cb                	sbb    %ecx,%ebx
  801c43:	89 d8                	mov    %ebx,%eax
  801c45:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c49:	d3 e0                	shl    %cl,%eax
  801c4b:	89 e9                	mov    %ebp,%ecx
  801c4d:	d3 ea                	shr    %cl,%edx
  801c4f:	09 d0                	or     %edx,%eax
  801c51:	89 e9                	mov    %ebp,%ecx
  801c53:	d3 eb                	shr    %cl,%ebx
  801c55:	89 da                	mov    %ebx,%edx
  801c57:	83 c4 1c             	add    $0x1c,%esp
  801c5a:	5b                   	pop    %ebx
  801c5b:	5e                   	pop    %esi
  801c5c:	5f                   	pop    %edi
  801c5d:	5d                   	pop    %ebp
  801c5e:	c3                   	ret    
  801c5f:	90                   	nop
  801c60:	89 fd                	mov    %edi,%ebp
  801c62:	85 ff                	test   %edi,%edi
  801c64:	75 0b                	jne    801c71 <__umoddi3+0xe9>
  801c66:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6b:	31 d2                	xor    %edx,%edx
  801c6d:	f7 f7                	div    %edi
  801c6f:	89 c5                	mov    %eax,%ebp
  801c71:	89 f0                	mov    %esi,%eax
  801c73:	31 d2                	xor    %edx,%edx
  801c75:	f7 f5                	div    %ebp
  801c77:	89 c8                	mov    %ecx,%eax
  801c79:	f7 f5                	div    %ebp
  801c7b:	89 d0                	mov    %edx,%eax
  801c7d:	e9 44 ff ff ff       	jmp    801bc6 <__umoddi3+0x3e>
  801c82:	66 90                	xchg   %ax,%ax
  801c84:	89 c8                	mov    %ecx,%eax
  801c86:	89 f2                	mov    %esi,%edx
  801c88:	83 c4 1c             	add    $0x1c,%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5f                   	pop    %edi
  801c8e:	5d                   	pop    %ebp
  801c8f:	c3                   	ret    
  801c90:	3b 04 24             	cmp    (%esp),%eax
  801c93:	72 06                	jb     801c9b <__umoddi3+0x113>
  801c95:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c99:	77 0f                	ja     801caa <__umoddi3+0x122>
  801c9b:	89 f2                	mov    %esi,%edx
  801c9d:	29 f9                	sub    %edi,%ecx
  801c9f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ca3:	89 14 24             	mov    %edx,(%esp)
  801ca6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801caa:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cae:	8b 14 24             	mov    (%esp),%edx
  801cb1:	83 c4 1c             	add    $0x1c,%esp
  801cb4:	5b                   	pop    %ebx
  801cb5:	5e                   	pop    %esi
  801cb6:	5f                   	pop    %edi
  801cb7:	5d                   	pop    %ebp
  801cb8:	c3                   	ret    
  801cb9:	8d 76 00             	lea    0x0(%esi),%esi
  801cbc:	2b 04 24             	sub    (%esp),%eax
  801cbf:	19 fa                	sbb    %edi,%edx
  801cc1:	89 d1                	mov    %edx,%ecx
  801cc3:	89 c6                	mov    %eax,%esi
  801cc5:	e9 71 ff ff ff       	jmp    801c3b <__umoddi3+0xb3>
  801cca:	66 90                	xchg   %ax,%ax
  801ccc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cd0:	72 ea                	jb     801cbc <__umoddi3+0x134>
  801cd2:	89 d9                	mov    %ebx,%ecx
  801cd4:	e9 62 ff ff ff       	jmp    801c3b <__umoddi3+0xb3>
