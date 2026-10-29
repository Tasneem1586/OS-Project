
obj/user/fos_add:     file format elf32-i386


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
  800031:	e8 d3 00 00 00       	call   800109 <libmain>
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
  80003b:	83 ec 28             	sub    $0x28,%esp
	int i1=0;
  80003e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int i2=0;
  800045:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	i1 = strtol("100", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 00 1d 80 00       	push   $0x801d00
  800058:	e8 d4 0e 00 00       	call   800f31 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 e8             	mov    %eax,-0x18(%ebp)
	i2 = strtol("200", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 04 1d 80 00       	push   $0x801d04
  80006f:	e8 bd 0e 00 00       	call   800f31 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	cprintf("%@number 1 + number 2 = %d\n", i1+i2);
  80007a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80007d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 08 1d 80 00       	push   $0x801d08
  80008b:	e8 b9 03 00 00       	call   800449 <cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//atomic_cprintf("%@number 1 + number 2 = %d\n",i1+i2);

	int N = 1000000;
  800093:	c7 45 e0 40 42 0f 00 	movl   $0xf4240,-0x20(%ebp)
	int64 sum = 0;
  80009a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int i = 0; i < N; ++i) {
  8000a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000af:	eb 0d                	jmp    8000be <_main+0x86>
		sum+=i ;
  8000b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b4:	99                   	cltd   
  8000b5:	01 45 f0             	add    %eax,-0x10(%ebp)
  8000b8:	11 55 f4             	adc    %edx,-0xc(%ebp)
	cprintf("%@number 1 + number 2 = %d\n", i1+i2);
	//atomic_cprintf("%@number 1 + number 2 = %d\n",i1+i2);

	int N = 1000000;
	int64 sum = 0;
	for (int i = 0; i < N; ++i) {
  8000bb:	ff 45 ec             	incl   -0x14(%ebp)
  8000be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c1:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8000c4:	7c eb                	jl     8000b1 <_main+0x79>
		sum+=i ;
	}
	sys_lock_cons();
  8000c6:	e8 d2 12 00 00       	call   80139d <sys_lock_cons>
	{
		cprintf_colored(TEXT_green + TEXTBG_blue, "sum 1->%d = %lld\n", N, sum);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8000d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8000d4:	ff 75 e0             	pushl  -0x20(%ebp)
  8000d7:	68 24 1d 80 00       	push   $0x801d24
  8000dc:	6a 12                	push   $0x12
  8000de:	e8 93 03 00 00       	call   800476 <cprintf_colored>
  8000e3:	83 c4 20             	add    $0x20,%esp
		cprintf_colored(TEXT_magenta + TEXTBG_cyan, "%~sum 1->%d = %lld\n", N, sum);
  8000e6:	83 ec 0c             	sub    $0xc,%esp
  8000e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8000ec:	ff 75 f0             	pushl  -0x10(%ebp)
  8000ef:	ff 75 e0             	pushl  -0x20(%ebp)
  8000f2:	68 36 1d 80 00       	push   $0x801d36
  8000f7:	6a 35                	push   $0x35
  8000f9:	e8 78 03 00 00       	call   800476 <cprintf_colored>
  8000fe:	83 c4 20             	add    $0x20,%esp
	}
	sys_unlock_cons();
  800101:	e8 b1 12 00 00       	call   8013b7 <sys_unlock_cons>
	return;
  800106:	90                   	nop
}
  800107:	c9                   	leave  
  800108:	c3                   	ret    

00800109 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800109:	55                   	push   %ebp
  80010a:	89 e5                	mov    %esp,%ebp
  80010c:	57                   	push   %edi
  80010d:	56                   	push   %esi
  80010e:	53                   	push   %ebx
  80010f:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800115:	e8 fb 14 00 00       	call   801615 <sys_getenvindex>
  80011a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80011d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800120:	89 d0                	mov    %edx,%eax
  800122:	c1 e0 03             	shl    $0x3,%eax
  800125:	01 d0                	add    %edx,%eax
  800127:	c1 e0 06             	shl    $0x6,%eax
  80012a:	01 d0                	add    %edx,%eax
  80012c:	c1 e0 03             	shl    $0x3,%eax
  80012f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800134:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800139:	a1 20 30 80 00       	mov    0x803020,%eax
  80013e:	8a 40 10             	mov    0x10(%eax),%al
  800141:	84 c0                	test   %al,%al
  800143:	74 0d                	je     800152 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800145:	a1 20 30 80 00       	mov    0x803020,%eax
  80014a:	83 c0 10             	add    $0x10,%eax
  80014d:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800152:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800156:	7e 0a                	jle    800162 <libmain+0x59>
		binaryname = argv[0];
  800158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80015b:	8b 00                	mov    (%eax),%eax
  80015d:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 0c             	pushl  0xc(%ebp)
  800168:	ff 75 08             	pushl  0x8(%ebp)
  80016b:	e8 c8 fe ff ff       	call   800038 <_main>
  800170:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800173:	a1 00 30 80 00       	mov    0x803000,%eax
  800178:	85 c0                	test   %eax,%eax
  80017a:	0f 84 b7 01 00 00    	je     800337 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800180:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800186:	bb 88 1e 80 00       	mov    $0x801e88,%ebx
  80018b:	ba 0e 00 00 00       	mov    $0xe,%edx
  800190:	89 c7                	mov    %eax,%edi
  800192:	89 de                	mov    %ebx,%esi
  800194:	89 d1                	mov    %edx,%ecx
  800196:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800198:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80019e:	b9 56 00 00 00       	mov    $0x56,%ecx
  8001a3:	b0 00                	mov    $0x0,%al
  8001a5:	89 d7                	mov    %edx,%edi
  8001a7:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8001a9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8001b0:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	50                   	push   %eax
  8001b7:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001bd:	50                   	push   %eax
  8001be:	e8 52 16 00 00       	call   801815 <sys_utilities>
  8001c3:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001c6:	e8 d2 11 00 00       	call   80139d <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	68 64 1d 80 00       	push   $0x801d64
  8001d3:	e8 71 02 00 00       	call   800449 <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001db:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001de:	85 c0                	test   %eax,%eax
  8001e0:	74 58                	je     80023a <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001e2:	e8 4c 16 00 00       	call   801833 <sys_get_optimal_num_faults>
  8001e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001ea:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001f0:	bb ec 1e 80 00       	mov    $0x801eec,%ebx
  8001f5:	ba 11 00 00 00       	mov    $0x11,%edx
  8001fa:	89 c7                	mov    %eax,%edi
  8001fc:	89 de                	mov    %ebx,%esi
  8001fe:	89 d1                	mov    %edx,%ecx
  800200:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800202:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800205:	b9 53 00 00 00       	mov    $0x53,%ecx
  80020a:	b0 00                	mov    $0x0,%al
  80020c:	89 d7                	mov    %edx,%edi
  80020e:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	ff 75 dc             	pushl  -0x24(%ebp)
  800216:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80021c:	50                   	push   %eax
  80021d:	e8 f3 15 00 00       	call   801815 <sys_utilities>
  800222:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800225:	83 ec 08             	sub    $0x8,%esp
  800228:	ff 75 dc             	pushl  -0x24(%ebp)
  80022b:	68 8c 1d 80 00       	push   $0x801d8c
  800230:	e8 14 02 00 00       	call   800449 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
  800238:	eb 59                	jmp    800293 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80023a:	a1 20 30 80 00       	mov    0x803020,%eax
  80023f:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800245:	a1 20 30 80 00       	mov    0x803020,%eax
  80024a:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800250:	83 ec 04             	sub    $0x4,%esp
  800253:	52                   	push   %edx
  800254:	50                   	push   %eax
  800255:	68 b0 1d 80 00       	push   $0x801db0
  80025a:	e8 ea 01 00 00       	call   800449 <cprintf>
  80025f:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800262:	a1 20 30 80 00       	mov    0x803020,%eax
  800267:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80026d:	a1 20 30 80 00       	mov    0x803020,%eax
  800272:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800278:	a1 20 30 80 00       	mov    0x803020,%eax
  80027d:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800283:	51                   	push   %ecx
  800284:	52                   	push   %edx
  800285:	50                   	push   %eax
  800286:	68 d8 1d 80 00       	push   $0x801dd8
  80028b:	e8 b9 01 00 00       	call   800449 <cprintf>
  800290:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800293:	a1 20 30 80 00       	mov    0x803020,%eax
  800298:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80029e:	83 ec 08             	sub    $0x8,%esp
  8002a1:	50                   	push   %eax
  8002a2:	68 30 1e 80 00       	push   $0x801e30
  8002a7:	e8 9d 01 00 00       	call   800449 <cprintf>
  8002ac:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8002af:	83 ec 0c             	sub    $0xc,%esp
  8002b2:	68 44 1e 80 00       	push   $0x801e44
  8002b7:	e8 8d 01 00 00       	call   800449 <cprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002bf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002c6:	eb 28                	jmp    8002f0 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002d0:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002d6:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002d9:	83 ec 04             	sub    $0x4,%esp
  8002dc:	50                   	push   %eax
  8002dd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002e0:	68 5b 1e 80 00       	push   $0x801e5b
  8002e5:	e8 5f 01 00 00       	call   800449 <cprintf>
  8002ea:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002ed:	ff 45 e4             	incl   -0x1c(%ebp)
  8002f0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002f4:	7e d2                	jle    8002c8 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002f6:	83 ec 0c             	sub    $0xc,%esp
  8002f9:	68 6a 1e 80 00       	push   $0x801e6a
  8002fe:	e8 46 01 00 00       	call   800449 <cprintf>
  800303:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800306:	a1 20 30 80 00       	mov    0x803020,%eax
  80030b:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800311:	83 ec 08             	sub    $0x8,%esp
  800314:	50                   	push   %eax
  800315:	68 6e 1e 80 00       	push   $0x801e6e
  80031a:	e8 2a 01 00 00       	call   800449 <cprintf>
  80031f:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800322:	83 ec 0c             	sub    $0xc,%esp
  800325:	68 64 1d 80 00       	push   $0x801d64
  80032a:	e8 1a 01 00 00       	call   800449 <cprintf>
  80032f:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800332:	e8 80 10 00 00       	call   8013b7 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800337:	e8 1f 00 00 00       	call   80035b <exit>
}
  80033c:	90                   	nop
  80033d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800340:	5b                   	pop    %ebx
  800341:	5e                   	pop    %esi
  800342:	5f                   	pop    %edi
  800343:	5d                   	pop    %ebp
  800344:	c3                   	ret    

00800345 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800345:	55                   	push   %ebp
  800346:	89 e5                	mov    %esp,%ebp
  800348:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80034b:	83 ec 0c             	sub    $0xc,%esp
  80034e:	6a 00                	push   $0x0
  800350:	e8 8c 12 00 00       	call   8015e1 <sys_destroy_env>
  800355:	83 c4 10             	add    $0x10,%esp
}
  800358:	90                   	nop
  800359:	c9                   	leave  
  80035a:	c3                   	ret    

0080035b <exit>:

void
exit(void)
{
  80035b:	55                   	push   %ebp
  80035c:	89 e5                	mov    %esp,%ebp
  80035e:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800361:	e8 e1 12 00 00       	call   801647 <sys_exit_env>
}
  800366:	90                   	nop
  800367:	c9                   	leave  
  800368:	c3                   	ret    

00800369 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800369:	55                   	push   %ebp
  80036a:	89 e5                	mov    %esp,%ebp
  80036c:	53                   	push   %ebx
  80036d:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800370:	8b 45 0c             	mov    0xc(%ebp),%eax
  800373:	8b 00                	mov    (%eax),%eax
  800375:	8d 48 01             	lea    0x1(%eax),%ecx
  800378:	8b 55 0c             	mov    0xc(%ebp),%edx
  80037b:	89 0a                	mov    %ecx,(%edx)
  80037d:	8b 55 08             	mov    0x8(%ebp),%edx
  800380:	88 d1                	mov    %dl,%cl
  800382:	8b 55 0c             	mov    0xc(%ebp),%edx
  800385:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800393:	75 30                	jne    8003c5 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800395:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80039b:	a0 40 30 80 00       	mov    0x803040,%al
  8003a0:	0f b6 c0             	movzbl %al,%eax
  8003a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003a6:	8b 09                	mov    (%ecx),%ecx
  8003a8:	89 cb                	mov    %ecx,%ebx
  8003aa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003ad:	83 c1 08             	add    $0x8,%ecx
  8003b0:	52                   	push   %edx
  8003b1:	50                   	push   %eax
  8003b2:	53                   	push   %ebx
  8003b3:	51                   	push   %ecx
  8003b4:	e8 a0 0f 00 00       	call   801359 <sys_cputs>
  8003b9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8b 40 04             	mov    0x4(%eax),%eax
  8003cb:	8d 50 01             	lea    0x1(%eax),%edx
  8003ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003d4:	90                   	nop
  8003d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d8:	c9                   	leave  
  8003d9:	c3                   	ret    

008003da <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003da:	55                   	push   %ebp
  8003db:	89 e5                	mov    %esp,%ebp
  8003dd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003e3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003ea:	00 00 00 
	b.cnt = 0;
  8003ed:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003f4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003f7:	ff 75 0c             	pushl  0xc(%ebp)
  8003fa:	ff 75 08             	pushl  0x8(%ebp)
  8003fd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800403:	50                   	push   %eax
  800404:	68 69 03 80 00       	push   $0x800369
  800409:	e8 5a 02 00 00       	call   800668 <vprintfmt>
  80040e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800411:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800417:	a0 40 30 80 00       	mov    0x803040,%al
  80041c:	0f b6 c0             	movzbl %al,%eax
  80041f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800425:	52                   	push   %edx
  800426:	50                   	push   %eax
  800427:	51                   	push   %ecx
  800428:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80042e:	83 c0 08             	add    $0x8,%eax
  800431:	50                   	push   %eax
  800432:	e8 22 0f 00 00       	call   801359 <sys_cputs>
  800437:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80043a:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800441:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800447:	c9                   	leave  
  800448:	c3                   	ret    

00800449 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800449:	55                   	push   %ebp
  80044a:	89 e5                	mov    %esp,%ebp
  80044c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80044f:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800456:	8d 45 0c             	lea    0xc(%ebp),%eax
  800459:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	83 ec 08             	sub    $0x8,%esp
  800462:	ff 75 f4             	pushl  -0xc(%ebp)
  800465:	50                   	push   %eax
  800466:	e8 6f ff ff ff       	call   8003da <vcprintf>
  80046b:	83 c4 10             	add    $0x10,%esp
  80046e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800471:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800474:	c9                   	leave  
  800475:	c3                   	ret    

00800476 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800476:	55                   	push   %ebp
  800477:	89 e5                	mov    %esp,%ebp
  800479:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80047c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800483:	8b 45 08             	mov    0x8(%ebp),%eax
  800486:	c1 e0 08             	shl    $0x8,%eax
  800489:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  80048e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800491:	83 c0 04             	add    $0x4,%eax
  800494:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800497:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049a:	83 ec 08             	sub    $0x8,%esp
  80049d:	ff 75 f4             	pushl  -0xc(%ebp)
  8004a0:	50                   	push   %eax
  8004a1:	e8 34 ff ff ff       	call   8003da <vcprintf>
  8004a6:	83 c4 10             	add    $0x10,%esp
  8004a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8004ac:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  8004b3:	07 00 00 

	return cnt;
  8004b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004b9:	c9                   	leave  
  8004ba:	c3                   	ret    

008004bb <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8004bb:	55                   	push   %ebp
  8004bc:	89 e5                	mov    %esp,%ebp
  8004be:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8004c1:	e8 d7 0e 00 00       	call   80139d <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8004c6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8004cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cf:	83 ec 08             	sub    $0x8,%esp
  8004d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8004d5:	50                   	push   %eax
  8004d6:	e8 ff fe ff ff       	call   8003da <vcprintf>
  8004db:	83 c4 10             	add    $0x10,%esp
  8004de:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004e1:	e8 d1 0e 00 00       	call   8013b7 <sys_unlock_cons>
	return cnt;
  8004e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004e9:	c9                   	leave  
  8004ea:	c3                   	ret    

008004eb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004eb:	55                   	push   %ebp
  8004ec:	89 e5                	mov    %esp,%ebp
  8004ee:	53                   	push   %ebx
  8004ef:	83 ec 14             	sub    $0x14,%esp
  8004f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004fe:	8b 45 18             	mov    0x18(%ebp),%eax
  800501:	ba 00 00 00 00       	mov    $0x0,%edx
  800506:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800509:	77 55                	ja     800560 <printnum+0x75>
  80050b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80050e:	72 05                	jb     800515 <printnum+0x2a>
  800510:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800513:	77 4b                	ja     800560 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800515:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800518:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80051b:	8b 45 18             	mov    0x18(%ebp),%eax
  80051e:	ba 00 00 00 00       	mov    $0x0,%edx
  800523:	52                   	push   %edx
  800524:	50                   	push   %eax
  800525:	ff 75 f4             	pushl  -0xc(%ebp)
  800528:	ff 75 f0             	pushl  -0x10(%ebp)
  80052b:	e8 60 15 00 00       	call   801a90 <__udivdi3>
  800530:	83 c4 10             	add    $0x10,%esp
  800533:	83 ec 04             	sub    $0x4,%esp
  800536:	ff 75 20             	pushl  0x20(%ebp)
  800539:	53                   	push   %ebx
  80053a:	ff 75 18             	pushl  0x18(%ebp)
  80053d:	52                   	push   %edx
  80053e:	50                   	push   %eax
  80053f:	ff 75 0c             	pushl  0xc(%ebp)
  800542:	ff 75 08             	pushl  0x8(%ebp)
  800545:	e8 a1 ff ff ff       	call   8004eb <printnum>
  80054a:	83 c4 20             	add    $0x20,%esp
  80054d:	eb 1a                	jmp    800569 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80054f:	83 ec 08             	sub    $0x8,%esp
  800552:	ff 75 0c             	pushl  0xc(%ebp)
  800555:	ff 75 20             	pushl  0x20(%ebp)
  800558:	8b 45 08             	mov    0x8(%ebp),%eax
  80055b:	ff d0                	call   *%eax
  80055d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800560:	ff 4d 1c             	decl   0x1c(%ebp)
  800563:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800567:	7f e6                	jg     80054f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800569:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80056c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800571:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800574:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800577:	53                   	push   %ebx
  800578:	51                   	push   %ecx
  800579:	52                   	push   %edx
  80057a:	50                   	push   %eax
  80057b:	e8 20 16 00 00       	call   801ba0 <__umoddi3>
  800580:	83 c4 10             	add    $0x10,%esp
  800583:	05 74 21 80 00       	add    $0x802174,%eax
  800588:	8a 00                	mov    (%eax),%al
  80058a:	0f be c0             	movsbl %al,%eax
  80058d:	83 ec 08             	sub    $0x8,%esp
  800590:	ff 75 0c             	pushl  0xc(%ebp)
  800593:	50                   	push   %eax
  800594:	8b 45 08             	mov    0x8(%ebp),%eax
  800597:	ff d0                	call   *%eax
  800599:	83 c4 10             	add    $0x10,%esp
}
  80059c:	90                   	nop
  80059d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005a0:	c9                   	leave  
  8005a1:	c3                   	ret    

008005a2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005a2:	55                   	push   %ebp
  8005a3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005a5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005a9:	7e 1c                	jle    8005c7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	8d 50 08             	lea    0x8(%eax),%edx
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	89 10                	mov    %edx,(%eax)
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	83 e8 08             	sub    $0x8,%eax
  8005c0:	8b 50 04             	mov    0x4(%eax),%edx
  8005c3:	8b 00                	mov    (%eax),%eax
  8005c5:	eb 40                	jmp    800607 <getuint+0x65>
	else if (lflag)
  8005c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005cb:	74 1e                	je     8005eb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	8d 50 04             	lea    0x4(%eax),%edx
  8005d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d8:	89 10                	mov    %edx,(%eax)
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	8b 00                	mov    (%eax),%eax
  8005df:	83 e8 04             	sub    $0x4,%eax
  8005e2:	8b 00                	mov    (%eax),%eax
  8005e4:	ba 00 00 00 00       	mov    $0x0,%edx
  8005e9:	eb 1c                	jmp    800607 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ee:	8b 00                	mov    (%eax),%eax
  8005f0:	8d 50 04             	lea    0x4(%eax),%edx
  8005f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f6:	89 10                	mov    %edx,(%eax)
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	8b 00                	mov    (%eax),%eax
  8005fd:	83 e8 04             	sub    $0x4,%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800607:	5d                   	pop    %ebp
  800608:	c3                   	ret    

00800609 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800609:	55                   	push   %ebp
  80060a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80060c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800610:	7e 1c                	jle    80062e <getint+0x25>
		return va_arg(*ap, long long);
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	8d 50 08             	lea    0x8(%eax),%edx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	89 10                	mov    %edx,(%eax)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	83 e8 08             	sub    $0x8,%eax
  800627:	8b 50 04             	mov    0x4(%eax),%edx
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	eb 38                	jmp    800666 <getint+0x5d>
	else if (lflag)
  80062e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800632:	74 1a                	je     80064e <getint+0x45>
		return va_arg(*ap, long);
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	8b 00                	mov    (%eax),%eax
  800639:	8d 50 04             	lea    0x4(%eax),%edx
  80063c:	8b 45 08             	mov    0x8(%ebp),%eax
  80063f:	89 10                	mov    %edx,(%eax)
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	8b 00                	mov    (%eax),%eax
  800646:	83 e8 04             	sub    $0x4,%eax
  800649:	8b 00                	mov    (%eax),%eax
  80064b:	99                   	cltd   
  80064c:	eb 18                	jmp    800666 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	8d 50 04             	lea    0x4(%eax),%edx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	89 10                	mov    %edx,(%eax)
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	83 e8 04             	sub    $0x4,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	99                   	cltd   
}
  800666:	5d                   	pop    %ebp
  800667:	c3                   	ret    

00800668 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800668:	55                   	push   %ebp
  800669:	89 e5                	mov    %esp,%ebp
  80066b:	56                   	push   %esi
  80066c:	53                   	push   %ebx
  80066d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800670:	eb 17                	jmp    800689 <vprintfmt+0x21>
			if (ch == '\0')
  800672:	85 db                	test   %ebx,%ebx
  800674:	0f 84 c1 03 00 00    	je     800a3b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 0c             	pushl  0xc(%ebp)
  800680:	53                   	push   %ebx
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	ff d0                	call   *%eax
  800686:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800689:	8b 45 10             	mov    0x10(%ebp),%eax
  80068c:	8d 50 01             	lea    0x1(%eax),%edx
  80068f:	89 55 10             	mov    %edx,0x10(%ebp)
  800692:	8a 00                	mov    (%eax),%al
  800694:	0f b6 d8             	movzbl %al,%ebx
  800697:	83 fb 25             	cmp    $0x25,%ebx
  80069a:	75 d6                	jne    800672 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80069c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006a0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006a7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006b5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8006bf:	8d 50 01             	lea    0x1(%eax),%edx
  8006c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8006c5:	8a 00                	mov    (%eax),%al
  8006c7:	0f b6 d8             	movzbl %al,%ebx
  8006ca:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006cd:	83 f8 5b             	cmp    $0x5b,%eax
  8006d0:	0f 87 3d 03 00 00    	ja     800a13 <vprintfmt+0x3ab>
  8006d6:	8b 04 85 98 21 80 00 	mov    0x802198(,%eax,4),%eax
  8006dd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006df:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006e3:	eb d7                	jmp    8006bc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006e5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006e9:	eb d1                	jmp    8006bc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006f5:	89 d0                	mov    %edx,%eax
  8006f7:	c1 e0 02             	shl    $0x2,%eax
  8006fa:	01 d0                	add    %edx,%eax
  8006fc:	01 c0                	add    %eax,%eax
  8006fe:	01 d8                	add    %ebx,%eax
  800700:	83 e8 30             	sub    $0x30,%eax
  800703:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800706:	8b 45 10             	mov    0x10(%ebp),%eax
  800709:	8a 00                	mov    (%eax),%al
  80070b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80070e:	83 fb 2f             	cmp    $0x2f,%ebx
  800711:	7e 3e                	jle    800751 <vprintfmt+0xe9>
  800713:	83 fb 39             	cmp    $0x39,%ebx
  800716:	7f 39                	jg     800751 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800718:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80071b:	eb d5                	jmp    8006f2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80071d:	8b 45 14             	mov    0x14(%ebp),%eax
  800720:	83 c0 04             	add    $0x4,%eax
  800723:	89 45 14             	mov    %eax,0x14(%ebp)
  800726:	8b 45 14             	mov    0x14(%ebp),%eax
  800729:	83 e8 04             	sub    $0x4,%eax
  80072c:	8b 00                	mov    (%eax),%eax
  80072e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800731:	eb 1f                	jmp    800752 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800733:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800737:	79 83                	jns    8006bc <vprintfmt+0x54>
				width = 0;
  800739:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800740:	e9 77 ff ff ff       	jmp    8006bc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800745:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80074c:	e9 6b ff ff ff       	jmp    8006bc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800751:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800752:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800756:	0f 89 60 ff ff ff    	jns    8006bc <vprintfmt+0x54>
				width = precision, precision = -1;
  80075c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80075f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800762:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800769:	e9 4e ff ff ff       	jmp    8006bc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80076e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800771:	e9 46 ff ff ff       	jmp    8006bc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800776:	8b 45 14             	mov    0x14(%ebp),%eax
  800779:	83 c0 04             	add    $0x4,%eax
  80077c:	89 45 14             	mov    %eax,0x14(%ebp)
  80077f:	8b 45 14             	mov    0x14(%ebp),%eax
  800782:	83 e8 04             	sub    $0x4,%eax
  800785:	8b 00                	mov    (%eax),%eax
  800787:	83 ec 08             	sub    $0x8,%esp
  80078a:	ff 75 0c             	pushl  0xc(%ebp)
  80078d:	50                   	push   %eax
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	ff d0                	call   *%eax
  800793:	83 c4 10             	add    $0x10,%esp
			break;
  800796:	e9 9b 02 00 00       	jmp    800a36 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80079b:	8b 45 14             	mov    0x14(%ebp),%eax
  80079e:	83 c0 04             	add    $0x4,%eax
  8007a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a7:	83 e8 04             	sub    $0x4,%eax
  8007aa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007ac:	85 db                	test   %ebx,%ebx
  8007ae:	79 02                	jns    8007b2 <vprintfmt+0x14a>
				err = -err;
  8007b0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007b2:	83 fb 64             	cmp    $0x64,%ebx
  8007b5:	7f 0b                	jg     8007c2 <vprintfmt+0x15a>
  8007b7:	8b 34 9d e0 1f 80 00 	mov    0x801fe0(,%ebx,4),%esi
  8007be:	85 f6                	test   %esi,%esi
  8007c0:	75 19                	jne    8007db <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007c2:	53                   	push   %ebx
  8007c3:	68 85 21 80 00       	push   $0x802185
  8007c8:	ff 75 0c             	pushl  0xc(%ebp)
  8007cb:	ff 75 08             	pushl  0x8(%ebp)
  8007ce:	e8 70 02 00 00       	call   800a43 <printfmt>
  8007d3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007d6:	e9 5b 02 00 00       	jmp    800a36 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007db:	56                   	push   %esi
  8007dc:	68 8e 21 80 00       	push   $0x80218e
  8007e1:	ff 75 0c             	pushl  0xc(%ebp)
  8007e4:	ff 75 08             	pushl  0x8(%ebp)
  8007e7:	e8 57 02 00 00       	call   800a43 <printfmt>
  8007ec:	83 c4 10             	add    $0x10,%esp
			break;
  8007ef:	e9 42 02 00 00       	jmp    800a36 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f7:	83 c0 04             	add    $0x4,%eax
  8007fa:	89 45 14             	mov    %eax,0x14(%ebp)
  8007fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800800:	83 e8 04             	sub    $0x4,%eax
  800803:	8b 30                	mov    (%eax),%esi
  800805:	85 f6                	test   %esi,%esi
  800807:	75 05                	jne    80080e <vprintfmt+0x1a6>
				p = "(null)";
  800809:	be 91 21 80 00       	mov    $0x802191,%esi
			if (width > 0 && padc != '-')
  80080e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800812:	7e 6d                	jle    800881 <vprintfmt+0x219>
  800814:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800818:	74 67                	je     800881 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80081a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	50                   	push   %eax
  800821:	56                   	push   %esi
  800822:	e8 1e 03 00 00       	call   800b45 <strnlen>
  800827:	83 c4 10             	add    $0x10,%esp
  80082a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80082d:	eb 16                	jmp    800845 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80082f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	50                   	push   %eax
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800842:	ff 4d e4             	decl   -0x1c(%ebp)
  800845:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800849:	7f e4                	jg     80082f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80084b:	eb 34                	jmp    800881 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80084d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800851:	74 1c                	je     80086f <vprintfmt+0x207>
  800853:	83 fb 1f             	cmp    $0x1f,%ebx
  800856:	7e 05                	jle    80085d <vprintfmt+0x1f5>
  800858:	83 fb 7e             	cmp    $0x7e,%ebx
  80085b:	7e 12                	jle    80086f <vprintfmt+0x207>
					putch('?', putdat);
  80085d:	83 ec 08             	sub    $0x8,%esp
  800860:	ff 75 0c             	pushl  0xc(%ebp)
  800863:	6a 3f                	push   $0x3f
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	ff d0                	call   *%eax
  80086a:	83 c4 10             	add    $0x10,%esp
  80086d:	eb 0f                	jmp    80087e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80086f:	83 ec 08             	sub    $0x8,%esp
  800872:	ff 75 0c             	pushl  0xc(%ebp)
  800875:	53                   	push   %ebx
  800876:	8b 45 08             	mov    0x8(%ebp),%eax
  800879:	ff d0                	call   *%eax
  80087b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80087e:	ff 4d e4             	decl   -0x1c(%ebp)
  800881:	89 f0                	mov    %esi,%eax
  800883:	8d 70 01             	lea    0x1(%eax),%esi
  800886:	8a 00                	mov    (%eax),%al
  800888:	0f be d8             	movsbl %al,%ebx
  80088b:	85 db                	test   %ebx,%ebx
  80088d:	74 24                	je     8008b3 <vprintfmt+0x24b>
  80088f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800893:	78 b8                	js     80084d <vprintfmt+0x1e5>
  800895:	ff 4d e0             	decl   -0x20(%ebp)
  800898:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80089c:	79 af                	jns    80084d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80089e:	eb 13                	jmp    8008b3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8008a0:	83 ec 08             	sub    $0x8,%esp
  8008a3:	ff 75 0c             	pushl  0xc(%ebp)
  8008a6:	6a 20                	push   $0x20
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	ff d0                	call   *%eax
  8008ad:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008b0:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b7:	7f e7                	jg     8008a0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008b9:	e9 78 01 00 00       	jmp    800a36 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008be:	83 ec 08             	sub    $0x8,%esp
  8008c1:	ff 75 e8             	pushl  -0x18(%ebp)
  8008c4:	8d 45 14             	lea    0x14(%ebp),%eax
  8008c7:	50                   	push   %eax
  8008c8:	e8 3c fd ff ff       	call   800609 <getint>
  8008cd:	83 c4 10             	add    $0x10,%esp
  8008d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008dc:	85 d2                	test   %edx,%edx
  8008de:	79 23                	jns    800903 <vprintfmt+0x29b>
				putch('-', putdat);
  8008e0:	83 ec 08             	sub    $0x8,%esp
  8008e3:	ff 75 0c             	pushl  0xc(%ebp)
  8008e6:	6a 2d                	push   $0x2d
  8008e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008eb:	ff d0                	call   *%eax
  8008ed:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008f6:	f7 d8                	neg    %eax
  8008f8:	83 d2 00             	adc    $0x0,%edx
  8008fb:	f7 da                	neg    %edx
  8008fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800900:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800903:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80090a:	e9 bc 00 00 00       	jmp    8009cb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80090f:	83 ec 08             	sub    $0x8,%esp
  800912:	ff 75 e8             	pushl  -0x18(%ebp)
  800915:	8d 45 14             	lea    0x14(%ebp),%eax
  800918:	50                   	push   %eax
  800919:	e8 84 fc ff ff       	call   8005a2 <getuint>
  80091e:	83 c4 10             	add    $0x10,%esp
  800921:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800924:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800927:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80092e:	e9 98 00 00 00       	jmp    8009cb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800933:	83 ec 08             	sub    $0x8,%esp
  800936:	ff 75 0c             	pushl  0xc(%ebp)
  800939:	6a 58                	push   $0x58
  80093b:	8b 45 08             	mov    0x8(%ebp),%eax
  80093e:	ff d0                	call   *%eax
  800940:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800943:	83 ec 08             	sub    $0x8,%esp
  800946:	ff 75 0c             	pushl  0xc(%ebp)
  800949:	6a 58                	push   $0x58
  80094b:	8b 45 08             	mov    0x8(%ebp),%eax
  80094e:	ff d0                	call   *%eax
  800950:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	6a 58                	push   $0x58
  80095b:	8b 45 08             	mov    0x8(%ebp),%eax
  80095e:	ff d0                	call   *%eax
  800960:	83 c4 10             	add    $0x10,%esp
			break;
  800963:	e9 ce 00 00 00       	jmp    800a36 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800968:	83 ec 08             	sub    $0x8,%esp
  80096b:	ff 75 0c             	pushl  0xc(%ebp)
  80096e:	6a 30                	push   $0x30
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	ff d0                	call   *%eax
  800975:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800978:	83 ec 08             	sub    $0x8,%esp
  80097b:	ff 75 0c             	pushl  0xc(%ebp)
  80097e:	6a 78                	push   $0x78
  800980:	8b 45 08             	mov    0x8(%ebp),%eax
  800983:	ff d0                	call   *%eax
  800985:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800988:	8b 45 14             	mov    0x14(%ebp),%eax
  80098b:	83 c0 04             	add    $0x4,%eax
  80098e:	89 45 14             	mov    %eax,0x14(%ebp)
  800991:	8b 45 14             	mov    0x14(%ebp),%eax
  800994:	83 e8 04             	sub    $0x4,%eax
  800997:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800999:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009a3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009aa:	eb 1f                	jmp    8009cb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009ac:	83 ec 08             	sub    $0x8,%esp
  8009af:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b2:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b5:	50                   	push   %eax
  8009b6:	e8 e7 fb ff ff       	call   8005a2 <getuint>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009c4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009cb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009d2:	83 ec 04             	sub    $0x4,%esp
  8009d5:	52                   	push   %edx
  8009d6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009d9:	50                   	push   %eax
  8009da:	ff 75 f4             	pushl  -0xc(%ebp)
  8009dd:	ff 75 f0             	pushl  -0x10(%ebp)
  8009e0:	ff 75 0c             	pushl  0xc(%ebp)
  8009e3:	ff 75 08             	pushl  0x8(%ebp)
  8009e6:	e8 00 fb ff ff       	call   8004eb <printnum>
  8009eb:	83 c4 20             	add    $0x20,%esp
			break;
  8009ee:	eb 46                	jmp    800a36 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009f0:	83 ec 08             	sub    $0x8,%esp
  8009f3:	ff 75 0c             	pushl  0xc(%ebp)
  8009f6:	53                   	push   %ebx
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
			break;
  8009ff:	eb 35                	jmp    800a36 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800a01:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800a08:	eb 2c                	jmp    800a36 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800a0a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800a11:	eb 23                	jmp    800a36 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	6a 25                	push   $0x25
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	ff d0                	call   *%eax
  800a20:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a23:	ff 4d 10             	decl   0x10(%ebp)
  800a26:	eb 03                	jmp    800a2b <vprintfmt+0x3c3>
  800a28:	ff 4d 10             	decl   0x10(%ebp)
  800a2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2e:	48                   	dec    %eax
  800a2f:	8a 00                	mov    (%eax),%al
  800a31:	3c 25                	cmp    $0x25,%al
  800a33:	75 f3                	jne    800a28 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a35:	90                   	nop
		}
	}
  800a36:	e9 35 fc ff ff       	jmp    800670 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a3b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a3f:	5b                   	pop    %ebx
  800a40:	5e                   	pop    %esi
  800a41:	5d                   	pop    %ebp
  800a42:	c3                   	ret    

00800a43 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a43:	55                   	push   %ebp
  800a44:	89 e5                	mov    %esp,%ebp
  800a46:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a49:	8d 45 10             	lea    0x10(%ebp),%eax
  800a4c:	83 c0 04             	add    $0x4,%eax
  800a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a52:	8b 45 10             	mov    0x10(%ebp),%eax
  800a55:	ff 75 f4             	pushl  -0xc(%ebp)
  800a58:	50                   	push   %eax
  800a59:	ff 75 0c             	pushl  0xc(%ebp)
  800a5c:	ff 75 08             	pushl  0x8(%ebp)
  800a5f:	e8 04 fc ff ff       	call   800668 <vprintfmt>
  800a64:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a67:	90                   	nop
  800a68:	c9                   	leave  
  800a69:	c3                   	ret    

00800a6a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a6a:	55                   	push   %ebp
  800a6b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a70:	8b 40 08             	mov    0x8(%eax),%eax
  800a73:	8d 50 01             	lea    0x1(%eax),%edx
  800a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a79:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7f:	8b 10                	mov    (%eax),%edx
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	8b 40 04             	mov    0x4(%eax),%eax
  800a87:	39 c2                	cmp    %eax,%edx
  800a89:	73 12                	jae    800a9d <sprintputch+0x33>
		*b->buf++ = ch;
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	8b 00                	mov    (%eax),%eax
  800a90:	8d 48 01             	lea    0x1(%eax),%ecx
  800a93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a96:	89 0a                	mov    %ecx,(%edx)
  800a98:	8b 55 08             	mov    0x8(%ebp),%edx
  800a9b:	88 10                	mov    %dl,(%eax)
}
  800a9d:	90                   	nop
  800a9e:	5d                   	pop    %ebp
  800a9f:	c3                   	ret    

00800aa0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
  800aa3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800aac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	01 d0                	add    %edx,%eax
  800ab7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ac1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ac5:	74 06                	je     800acd <vsnprintf+0x2d>
  800ac7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800acb:	7f 07                	jg     800ad4 <vsnprintf+0x34>
		return -E_INVAL;
  800acd:	b8 03 00 00 00       	mov    $0x3,%eax
  800ad2:	eb 20                	jmp    800af4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ad4:	ff 75 14             	pushl  0x14(%ebp)
  800ad7:	ff 75 10             	pushl  0x10(%ebp)
  800ada:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800add:	50                   	push   %eax
  800ade:	68 6a 0a 80 00       	push   $0x800a6a
  800ae3:	e8 80 fb ff ff       	call   800668 <vprintfmt>
  800ae8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aee:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800af4:	c9                   	leave  
  800af5:	c3                   	ret    

00800af6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
  800af9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800afc:	8d 45 10             	lea    0x10(%ebp),%eax
  800aff:	83 c0 04             	add    $0x4,%eax
  800b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b05:	8b 45 10             	mov    0x10(%ebp),%eax
  800b08:	ff 75 f4             	pushl  -0xc(%ebp)
  800b0b:	50                   	push   %eax
  800b0c:	ff 75 0c             	pushl  0xc(%ebp)
  800b0f:	ff 75 08             	pushl  0x8(%ebp)
  800b12:	e8 89 ff ff ff       	call   800aa0 <vsnprintf>
  800b17:	83 c4 10             	add    $0x10,%esp
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b20:	c9                   	leave  
  800b21:	c3                   	ret    

00800b22 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b2f:	eb 06                	jmp    800b37 <strlen+0x15>
		n++;
  800b31:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b34:	ff 45 08             	incl   0x8(%ebp)
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8a 00                	mov    (%eax),%al
  800b3c:	84 c0                	test   %al,%al
  800b3e:	75 f1                	jne    800b31 <strlen+0xf>
		n++;
	return n;
  800b40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b43:	c9                   	leave  
  800b44:	c3                   	ret    

00800b45 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b4b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b52:	eb 09                	jmp    800b5d <strnlen+0x18>
		n++;
  800b54:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b57:	ff 45 08             	incl   0x8(%ebp)
  800b5a:	ff 4d 0c             	decl   0xc(%ebp)
  800b5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b61:	74 09                	je     800b6c <strnlen+0x27>
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	84 c0                	test   %al,%al
  800b6a:	75 e8                	jne    800b54 <strnlen+0xf>
		n++;
	return n;
  800b6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b7d:	90                   	nop
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	8d 50 01             	lea    0x1(%eax),%edx
  800b84:	89 55 08             	mov    %edx,0x8(%ebp)
  800b87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b8d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b90:	8a 12                	mov    (%edx),%dl
  800b92:	88 10                	mov    %dl,(%eax)
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	84 c0                	test   %al,%al
  800b98:	75 e4                	jne    800b7e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9d:	c9                   	leave  
  800b9e:	c3                   	ret    

00800b9f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b9f:	55                   	push   %ebp
  800ba0:	89 e5                	mov    %esp,%ebp
  800ba2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb2:	eb 1f                	jmp    800bd3 <strncpy+0x34>
		*dst++ = *src;
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	8d 50 01             	lea    0x1(%eax),%edx
  800bba:	89 55 08             	mov    %edx,0x8(%ebp)
  800bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc0:	8a 12                	mov    (%edx),%dl
  800bc2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	84 c0                	test   %al,%al
  800bcb:	74 03                	je     800bd0 <strncpy+0x31>
			src++;
  800bcd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bd0:	ff 45 fc             	incl   -0x4(%ebp)
  800bd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bd9:	72 d9                	jb     800bb4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bdb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bde:	c9                   	leave  
  800bdf:	c3                   	ret    

00800be0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800be0:	55                   	push   %ebp
  800be1:	89 e5                	mov    %esp,%ebp
  800be3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bf0:	74 30                	je     800c22 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bf2:	eb 16                	jmp    800c0a <strlcpy+0x2a>
			*dst++ = *src++;
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8d 50 01             	lea    0x1(%eax),%edx
  800bfa:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c00:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c03:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c06:	8a 12                	mov    (%edx),%dl
  800c08:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c0a:	ff 4d 10             	decl   0x10(%ebp)
  800c0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c11:	74 09                	je     800c1c <strlcpy+0x3c>
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	84 c0                	test   %al,%al
  800c1a:	75 d8                	jne    800bf4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c22:	8b 55 08             	mov    0x8(%ebp),%edx
  800c25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c28:	29 c2                	sub    %eax,%edx
  800c2a:	89 d0                	mov    %edx,%eax
}
  800c2c:	c9                   	leave  
  800c2d:	c3                   	ret    

00800c2e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c2e:	55                   	push   %ebp
  800c2f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c31:	eb 06                	jmp    800c39 <strcmp+0xb>
		p++, q++;
  800c33:	ff 45 08             	incl   0x8(%ebp)
  800c36:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	84 c0                	test   %al,%al
  800c40:	74 0e                	je     800c50 <strcmp+0x22>
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8a 10                	mov    (%eax),%dl
  800c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4a:	8a 00                	mov    (%eax),%al
  800c4c:	38 c2                	cmp    %al,%dl
  800c4e:	74 e3                	je     800c33 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	0f b6 d0             	movzbl %al,%edx
  800c58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	0f b6 c0             	movzbl %al,%eax
  800c60:	29 c2                	sub    %eax,%edx
  800c62:	89 d0                	mov    %edx,%eax
}
  800c64:	5d                   	pop    %ebp
  800c65:	c3                   	ret    

00800c66 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c66:	55                   	push   %ebp
  800c67:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c69:	eb 09                	jmp    800c74 <strncmp+0xe>
		n--, p++, q++;
  800c6b:	ff 4d 10             	decl   0x10(%ebp)
  800c6e:	ff 45 08             	incl   0x8(%ebp)
  800c71:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c78:	74 17                	je     800c91 <strncmp+0x2b>
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	8a 00                	mov    (%eax),%al
  800c7f:	84 c0                	test   %al,%al
  800c81:	74 0e                	je     800c91 <strncmp+0x2b>
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 10                	mov    (%eax),%dl
  800c88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8b:	8a 00                	mov    (%eax),%al
  800c8d:	38 c2                	cmp    %al,%dl
  800c8f:	74 da                	je     800c6b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c95:	75 07                	jne    800c9e <strncmp+0x38>
		return 0;
  800c97:	b8 00 00 00 00       	mov    $0x0,%eax
  800c9c:	eb 14                	jmp    800cb2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	8a 00                	mov    (%eax),%al
  800ca3:	0f b6 d0             	movzbl %al,%edx
  800ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	0f b6 c0             	movzbl %al,%eax
  800cae:	29 c2                	sub    %eax,%edx
  800cb0:	89 d0                	mov    %edx,%eax
}
  800cb2:	5d                   	pop    %ebp
  800cb3:	c3                   	ret    

00800cb4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cb4:	55                   	push   %ebp
  800cb5:	89 e5                	mov    %esp,%ebp
  800cb7:	83 ec 04             	sub    $0x4,%esp
  800cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cc0:	eb 12                	jmp    800cd4 <strchr+0x20>
		if (*s == c)
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cca:	75 05                	jne    800cd1 <strchr+0x1d>
			return (char *) s;
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	eb 11                	jmp    800ce2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cd1:	ff 45 08             	incl   0x8(%ebp)
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	84 c0                	test   %al,%al
  800cdb:	75 e5                	jne    800cc2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
  800ce7:	83 ec 04             	sub    $0x4,%esp
  800cea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ced:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf0:	eb 0d                	jmp    800cff <strfind+0x1b>
		if (*s == c)
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8a 00                	mov    (%eax),%al
  800cf7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cfa:	74 0e                	je     800d0a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cfc:	ff 45 08             	incl   0x8(%ebp)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	84 c0                	test   %al,%al
  800d06:	75 ea                	jne    800cf2 <strfind+0xe>
  800d08:	eb 01                	jmp    800d0b <strfind+0x27>
		if (*s == c)
			break;
  800d0a:	90                   	nop
	return (char *) s;
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d0e:	c9                   	leave  
  800d0f:	c3                   	ret    

00800d10 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
  800d13:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800d1c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d20:	76 63                	jbe    800d85 <memset+0x75>
		uint64 data_block = c;
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	99                   	cltd   
  800d26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d29:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d32:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800d36:	c1 e0 08             	shl    $0x8,%eax
  800d39:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d3c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d45:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d49:	c1 e0 10             	shl    $0x10,%eax
  800d4c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d4f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d58:	89 c2                	mov    %eax,%edx
  800d5a:	b8 00 00 00 00       	mov    $0x0,%eax
  800d5f:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d62:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d65:	eb 18                	jmp    800d7f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d67:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d6a:	8d 41 08             	lea    0x8(%ecx),%eax
  800d6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d70:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d73:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d76:	89 01                	mov    %eax,(%ecx)
  800d78:	89 51 04             	mov    %edx,0x4(%ecx)
  800d7b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d7f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d83:	77 e2                	ja     800d67 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d89:	74 23                	je     800dae <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d91:	eb 0e                	jmp    800da1 <memset+0x91>
			*p8++ = (uint8)c;
  800d93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d96:	8d 50 01             	lea    0x1(%eax),%edx
  800d99:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800da1:	8b 45 10             	mov    0x10(%ebp),%eax
  800da4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da7:	89 55 10             	mov    %edx,0x10(%ebp)
  800daa:	85 c0                	test   %eax,%eax
  800dac:	75 e5                	jne    800d93 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800dc5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800dc9:	76 24                	jbe    800def <memcpy+0x3c>
		while(n >= 8){
  800dcb:	eb 1c                	jmp    800de9 <memcpy+0x36>
			*d64 = *s64;
  800dcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd0:	8b 50 04             	mov    0x4(%eax),%edx
  800dd3:	8b 00                	mov    (%eax),%eax
  800dd5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800dd8:	89 01                	mov    %eax,(%ecx)
  800dda:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800ddd:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800de1:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800de5:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800de9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ded:	77 de                	ja     800dcd <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800def:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800df3:	74 31                	je     800e26 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800df5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800dfb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800e01:	eb 16                	jmp    800e19 <memcpy+0x66>
			*d8++ = *s8++;
  800e03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800e0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e12:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800e15:	8a 12                	mov    (%edx),%dl
  800e17:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e1f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e22:	85 c0                	test   %eax,%eax
  800e24:	75 dd                	jne    800e03 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e29:	c9                   	leave  
  800e2a:	c3                   	ret    

00800e2b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
  800e2e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e40:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e43:	73 50                	jae    800e95 <memmove+0x6a>
  800e45:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e48:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4b:	01 d0                	add    %edx,%eax
  800e4d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e50:	76 43                	jbe    800e95 <memmove+0x6a>
		s += n;
  800e52:	8b 45 10             	mov    0x10(%ebp),%eax
  800e55:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e58:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e5e:	eb 10                	jmp    800e70 <memmove+0x45>
			*--d = *--s;
  800e60:	ff 4d f8             	decl   -0x8(%ebp)
  800e63:	ff 4d fc             	decl   -0x4(%ebp)
  800e66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e69:	8a 10                	mov    (%eax),%dl
  800e6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e70:	8b 45 10             	mov    0x10(%ebp),%eax
  800e73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e76:	89 55 10             	mov    %edx,0x10(%ebp)
  800e79:	85 c0                	test   %eax,%eax
  800e7b:	75 e3                	jne    800e60 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e7d:	eb 23                	jmp    800ea2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e82:	8d 50 01             	lea    0x1(%eax),%edx
  800e85:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e88:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e8b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e8e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e91:	8a 12                	mov    (%edx),%dl
  800e93:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e95:	8b 45 10             	mov    0x10(%ebp),%eax
  800e98:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9e:	85 c0                	test   %eax,%eax
  800ea0:	75 dd                	jne    800e7f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea5:	c9                   	leave  
  800ea6:	c3                   	ret    

00800ea7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ea7:	55                   	push   %ebp
  800ea8:	89 e5                	mov    %esp,%ebp
  800eaa:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800eb9:	eb 2a                	jmp    800ee5 <memcmp+0x3e>
		if (*s1 != *s2)
  800ebb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebe:	8a 10                	mov    (%eax),%dl
  800ec0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	38 c2                	cmp    %al,%dl
  800ec7:	74 16                	je     800edf <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ec9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	0f b6 d0             	movzbl %al,%edx
  800ed1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	0f b6 c0             	movzbl %al,%eax
  800ed9:	29 c2                	sub    %eax,%edx
  800edb:	89 d0                	mov    %edx,%eax
  800edd:	eb 18                	jmp    800ef7 <memcmp+0x50>
		s1++, s2++;
  800edf:	ff 45 fc             	incl   -0x4(%ebp)
  800ee2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ee5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eeb:	89 55 10             	mov    %edx,0x10(%ebp)
  800eee:	85 c0                	test   %eax,%eax
  800ef0:	75 c9                	jne    800ebb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ef2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ef7:	c9                   	leave  
  800ef8:	c3                   	ret    

00800ef9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ef9:	55                   	push   %ebp
  800efa:	89 e5                	mov    %esp,%ebp
  800efc:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eff:	8b 55 08             	mov    0x8(%ebp),%edx
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	01 d0                	add    %edx,%eax
  800f07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f0a:	eb 15                	jmp    800f21 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	0f b6 d0             	movzbl %al,%edx
  800f14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f17:	0f b6 c0             	movzbl %al,%eax
  800f1a:	39 c2                	cmp    %eax,%edx
  800f1c:	74 0d                	je     800f2b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f27:	72 e3                	jb     800f0c <memfind+0x13>
  800f29:	eb 01                	jmp    800f2c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f2b:	90                   	nop
	return (void *) s;
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2f:	c9                   	leave  
  800f30:	c3                   	ret    

00800f31 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f31:	55                   	push   %ebp
  800f32:	89 e5                	mov    %esp,%ebp
  800f34:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f3e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f45:	eb 03                	jmp    800f4a <strtol+0x19>
		s++;
  800f47:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	3c 20                	cmp    $0x20,%al
  800f51:	74 f4                	je     800f47 <strtol+0x16>
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3c 09                	cmp    $0x9,%al
  800f5a:	74 eb                	je     800f47 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	3c 2b                	cmp    $0x2b,%al
  800f63:	75 05                	jne    800f6a <strtol+0x39>
		s++;
  800f65:	ff 45 08             	incl   0x8(%ebp)
  800f68:	eb 13                	jmp    800f7d <strtol+0x4c>
	else if (*s == '-')
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	3c 2d                	cmp    $0x2d,%al
  800f71:	75 0a                	jne    800f7d <strtol+0x4c>
		s++, neg = 1;
  800f73:	ff 45 08             	incl   0x8(%ebp)
  800f76:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f81:	74 06                	je     800f89 <strtol+0x58>
  800f83:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f87:	75 20                	jne    800fa9 <strtol+0x78>
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	3c 30                	cmp    $0x30,%al
  800f90:	75 17                	jne    800fa9 <strtol+0x78>
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	40                   	inc    %eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 78                	cmp    $0x78,%al
  800f9a:	75 0d                	jne    800fa9 <strtol+0x78>
		s += 2, base = 16;
  800f9c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fa0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fa7:	eb 28                	jmp    800fd1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fa9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fad:	75 15                	jne    800fc4 <strtol+0x93>
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 30                	cmp    $0x30,%al
  800fb6:	75 0c                	jne    800fc4 <strtol+0x93>
		s++, base = 8;
  800fb8:	ff 45 08             	incl   0x8(%ebp)
  800fbb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fc2:	eb 0d                	jmp    800fd1 <strtol+0xa0>
	else if (base == 0)
  800fc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc8:	75 07                	jne    800fd1 <strtol+0xa0>
		base = 10;
  800fca:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 2f                	cmp    $0x2f,%al
  800fd8:	7e 19                	jle    800ff3 <strtol+0xc2>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 39                	cmp    $0x39,%al
  800fe1:	7f 10                	jg     800ff3 <strtol+0xc2>
			dig = *s - '0';
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f be c0             	movsbl %al,%eax
  800feb:	83 e8 30             	sub    $0x30,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff1:	eb 42                	jmp    801035 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 60                	cmp    $0x60,%al
  800ffa:	7e 19                	jle    801015 <strtol+0xe4>
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	3c 7a                	cmp    $0x7a,%al
  801003:	7f 10                	jg     801015 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	0f be c0             	movsbl %al,%eax
  80100d:	83 e8 57             	sub    $0x57,%eax
  801010:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801013:	eb 20                	jmp    801035 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	3c 40                	cmp    $0x40,%al
  80101c:	7e 39                	jle    801057 <strtol+0x126>
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	3c 5a                	cmp    $0x5a,%al
  801025:	7f 30                	jg     801057 <strtol+0x126>
			dig = *s - 'A' + 10;
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	0f be c0             	movsbl %al,%eax
  80102f:	83 e8 37             	sub    $0x37,%eax
  801032:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801035:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801038:	3b 45 10             	cmp    0x10(%ebp),%eax
  80103b:	7d 19                	jge    801056 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80103d:	ff 45 08             	incl   0x8(%ebp)
  801040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801043:	0f af 45 10          	imul   0x10(%ebp),%eax
  801047:	89 c2                	mov    %eax,%edx
  801049:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80104c:	01 d0                	add    %edx,%eax
  80104e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801051:	e9 7b ff ff ff       	jmp    800fd1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801056:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801057:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105b:	74 08                	je     801065 <strtol+0x134>
		*endptr = (char *) s;
  80105d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801060:	8b 55 08             	mov    0x8(%ebp),%edx
  801063:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801065:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801069:	74 07                	je     801072 <strtol+0x141>
  80106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106e:	f7 d8                	neg    %eax
  801070:	eb 03                	jmp    801075 <strtol+0x144>
  801072:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <ltostr>:

void
ltostr(long value, char *str)
{
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
  80107a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80107d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801084:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80108b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80108f:	79 13                	jns    8010a4 <ltostr+0x2d>
	{
		neg = 1;
  801091:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801098:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80109e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010a1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010ac:	99                   	cltd   
  8010ad:	f7 f9                	idiv   %ecx
  8010af:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b5:	8d 50 01             	lea    0x1(%eax),%edx
  8010b8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010bb:	89 c2                	mov    %eax,%edx
  8010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c0:	01 d0                	add    %edx,%eax
  8010c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010c5:	83 c2 30             	add    $0x30,%edx
  8010c8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010cd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010d2:	f7 e9                	imul   %ecx
  8010d4:	c1 fa 02             	sar    $0x2,%edx
  8010d7:	89 c8                	mov    %ecx,%eax
  8010d9:	c1 f8 1f             	sar    $0x1f,%eax
  8010dc:	29 c2                	sub    %eax,%edx
  8010de:	89 d0                	mov    %edx,%eax
  8010e0:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8010e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010e7:	75 bb                	jne    8010a4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f3:	48                   	dec    %eax
  8010f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010fb:	74 3d                	je     80113a <ltostr+0xc3>
		start = 1 ;
  8010fd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801104:	eb 34                	jmp    80113a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801106:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801109:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110c:	01 d0                	add    %edx,%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801113:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801116:	8b 45 0c             	mov    0xc(%ebp),%eax
  801119:	01 c2                	add    %eax,%edx
  80111b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80111e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801121:	01 c8                	add    %ecx,%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801127:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80112a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112d:	01 c2                	add    %eax,%edx
  80112f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801132:	88 02                	mov    %al,(%edx)
		start++ ;
  801134:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801137:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80113a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801140:	7c c4                	jl     801106 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801142:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801145:	8b 45 0c             	mov    0xc(%ebp),%eax
  801148:	01 d0                	add    %edx,%eax
  80114a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80114d:	90                   	nop
  80114e:	c9                   	leave  
  80114f:	c3                   	ret    

00801150 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
  801153:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801156:	ff 75 08             	pushl  0x8(%ebp)
  801159:	e8 c4 f9 ff ff       	call   800b22 <strlen>
  80115e:	83 c4 04             	add    $0x4,%esp
  801161:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801164:	ff 75 0c             	pushl  0xc(%ebp)
  801167:	e8 b6 f9 ff ff       	call   800b22 <strlen>
  80116c:	83 c4 04             	add    $0x4,%esp
  80116f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801172:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801179:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801180:	eb 17                	jmp    801199 <strcconcat+0x49>
		final[s] = str1[s] ;
  801182:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801185:	8b 45 10             	mov    0x10(%ebp),%eax
  801188:	01 c2                	add    %eax,%edx
  80118a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	01 c8                	add    %ecx,%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801196:	ff 45 fc             	incl   -0x4(%ebp)
  801199:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80119f:	7c e1                	jl     801182 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011af:	eb 1f                	jmp    8011d0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b4:	8d 50 01             	lea    0x1(%eax),%edx
  8011b7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011ba:	89 c2                	mov    %eax,%edx
  8011bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bf:	01 c2                	add    %eax,%edx
  8011c1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c7:	01 c8                	add    %ecx,%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011cd:	ff 45 f8             	incl   -0x8(%ebp)
  8011d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d6:	7c d9                	jl     8011b1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011db:	8b 45 10             	mov    0x10(%ebp),%eax
  8011de:	01 d0                	add    %edx,%eax
  8011e0:	c6 00 00             	movb   $0x0,(%eax)
}
  8011e3:	90                   	nop
  8011e4:	c9                   	leave  
  8011e5:	c3                   	ret    

008011e6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e6:	55                   	push   %ebp
  8011e7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f5:	8b 00                	mov    (%eax),%eax
  8011f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801201:	01 d0                	add    %edx,%eax
  801203:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801209:	eb 0c                	jmp    801217 <strsplit+0x31>
			*string++ = 0;
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8d 50 01             	lea    0x1(%eax),%edx
  801211:	89 55 08             	mov    %edx,0x8(%ebp)
  801214:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	8a 00                	mov    (%eax),%al
  80121c:	84 c0                	test   %al,%al
  80121e:	74 18                	je     801238 <strsplit+0x52>
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	0f be c0             	movsbl %al,%eax
  801228:	50                   	push   %eax
  801229:	ff 75 0c             	pushl  0xc(%ebp)
  80122c:	e8 83 fa ff ff       	call   800cb4 <strchr>
  801231:	83 c4 08             	add    $0x8,%esp
  801234:	85 c0                	test   %eax,%eax
  801236:	75 d3                	jne    80120b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	84 c0                	test   %al,%al
  80123f:	74 5a                	je     80129b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801241:	8b 45 14             	mov    0x14(%ebp),%eax
  801244:	8b 00                	mov    (%eax),%eax
  801246:	83 f8 0f             	cmp    $0xf,%eax
  801249:	75 07                	jne    801252 <strsplit+0x6c>
		{
			return 0;
  80124b:	b8 00 00 00 00       	mov    $0x0,%eax
  801250:	eb 66                	jmp    8012b8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801252:	8b 45 14             	mov    0x14(%ebp),%eax
  801255:	8b 00                	mov    (%eax),%eax
  801257:	8d 48 01             	lea    0x1(%eax),%ecx
  80125a:	8b 55 14             	mov    0x14(%ebp),%edx
  80125d:	89 0a                	mov    %ecx,(%edx)
  80125f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801266:	8b 45 10             	mov    0x10(%ebp),%eax
  801269:	01 c2                	add    %eax,%edx
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801270:	eb 03                	jmp    801275 <strsplit+0x8f>
			string++;
  801272:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801275:	8b 45 08             	mov    0x8(%ebp),%eax
  801278:	8a 00                	mov    (%eax),%al
  80127a:	84 c0                	test   %al,%al
  80127c:	74 8b                	je     801209 <strsplit+0x23>
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	0f be c0             	movsbl %al,%eax
  801286:	50                   	push   %eax
  801287:	ff 75 0c             	pushl  0xc(%ebp)
  80128a:	e8 25 fa ff ff       	call   800cb4 <strchr>
  80128f:	83 c4 08             	add    $0x8,%esp
  801292:	85 c0                	test   %eax,%eax
  801294:	74 dc                	je     801272 <strsplit+0x8c>
			string++;
	}
  801296:	e9 6e ff ff ff       	jmp    801209 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80129b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80129c:	8b 45 14             	mov    0x14(%ebp),%eax
  80129f:	8b 00                	mov    (%eax),%eax
  8012a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ab:	01 d0                	add    %edx,%eax
  8012ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012b3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8012c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012cd:	eb 4a                	jmp    801319 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8012cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	01 c2                	add    %eax,%edx
  8012d7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dd:	01 c8                	add    %ecx,%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8012e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e9:	01 d0                	add    %edx,%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	3c 40                	cmp    $0x40,%al
  8012ef:	7e 25                	jle    801316 <str2lower+0x5c>
  8012f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	3c 5a                	cmp    $0x5a,%al
  8012fd:	7f 17                	jg     801316 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	01 d0                	add    %edx,%eax
  801307:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80130a:	8b 55 08             	mov    0x8(%ebp),%edx
  80130d:	01 ca                	add    %ecx,%edx
  80130f:	8a 12                	mov    (%edx),%dl
  801311:	83 c2 20             	add    $0x20,%edx
  801314:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801316:	ff 45 fc             	incl   -0x4(%ebp)
  801319:	ff 75 0c             	pushl  0xc(%ebp)
  80131c:	e8 01 f8 ff ff       	call   800b22 <strlen>
  801321:	83 c4 04             	add    $0x4,%esp
  801324:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801327:	7f a6                	jg     8012cf <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801329:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
  801331:	57                   	push   %edi
  801332:	56                   	push   %esi
  801333:	53                   	push   %ebx
  801334:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
  80133a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801340:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801343:	8b 7d 18             	mov    0x18(%ebp),%edi
  801346:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801349:	cd 30                	int    $0x30
  80134b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80134e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801351:	83 c4 10             	add    $0x10,%esp
  801354:	5b                   	pop    %ebx
  801355:	5e                   	pop    %esi
  801356:	5f                   	pop    %edi
  801357:	5d                   	pop    %ebp
  801358:	c3                   	ret    

00801359 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
  80135c:	83 ec 04             	sub    $0x4,%esp
  80135f:	8b 45 10             	mov    0x10(%ebp),%eax
  801362:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801365:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801368:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	6a 00                	push   $0x0
  801371:	51                   	push   %ecx
  801372:	52                   	push   %edx
  801373:	ff 75 0c             	pushl  0xc(%ebp)
  801376:	50                   	push   %eax
  801377:	6a 00                	push   $0x0
  801379:	e8 b0 ff ff ff       	call   80132e <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	90                   	nop
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <sys_cgetc>:

int
sys_cgetc(void)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 02                	push   $0x2
  801393:	e8 96 ff ff ff       	call   80132e <syscall>
  801398:	83 c4 18             	add    $0x18,%esp
}
  80139b:	c9                   	leave  
  80139c:	c3                   	ret    

0080139d <sys_lock_cons>:

void sys_lock_cons(void)
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 03                	push   $0x3
  8013ac:	e8 7d ff ff ff       	call   80132e <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	90                   	nop
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 04                	push   $0x4
  8013c6:	e8 63 ff ff ff       	call   80132e <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	90                   	nop
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	52                   	push   %edx
  8013e1:	50                   	push   %eax
  8013e2:	6a 08                	push   $0x8
  8013e4:	e8 45 ff ff ff       	call   80132e <syscall>
  8013e9:	83 c4 18             	add    $0x18,%esp
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	56                   	push   %esi
  8013f2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013f3:	8b 75 18             	mov    0x18(%ebp),%esi
  8013f6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	56                   	push   %esi
  801403:	53                   	push   %ebx
  801404:	51                   	push   %ecx
  801405:	52                   	push   %edx
  801406:	50                   	push   %eax
  801407:	6a 09                	push   $0x9
  801409:	e8 20 ff ff ff       	call   80132e <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801414:	5b                   	pop    %ebx
  801415:	5e                   	pop    %esi
  801416:	5d                   	pop    %ebp
  801417:	c3                   	ret    

00801418 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	ff 75 08             	pushl  0x8(%ebp)
  801426:	6a 0a                	push   $0xa
  801428:	e8 01 ff ff ff       	call   80132e <syscall>
  80142d:	83 c4 18             	add    $0x18,%esp
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	ff 75 0c             	pushl  0xc(%ebp)
  80143e:	ff 75 08             	pushl  0x8(%ebp)
  801441:	6a 0b                	push   $0xb
  801443:	e8 e6 fe ff ff       	call   80132e <syscall>
  801448:	83 c4 18             	add    $0x18,%esp
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 0c                	push   $0xc
  80145c:	e8 cd fe ff ff       	call   80132e <syscall>
  801461:	83 c4 18             	add    $0x18,%esp
}
  801464:	c9                   	leave  
  801465:	c3                   	ret    

00801466 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 0d                	push   $0xd
  801475:	e8 b4 fe ff ff       	call   80132e <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
}
  80147d:	c9                   	leave  
  80147e:	c3                   	ret    

0080147f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 0e                	push   $0xe
  80148e:	e8 9b fe ff ff       	call   80132e <syscall>
  801493:	83 c4 18             	add    $0x18,%esp
}
  801496:	c9                   	leave  
  801497:	c3                   	ret    

00801498 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801498:	55                   	push   %ebp
  801499:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 0f                	push   $0xf
  8014a7:	e8 82 fe ff ff       	call   80132e <syscall>
  8014ac:	83 c4 18             	add    $0x18,%esp
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	ff 75 08             	pushl  0x8(%ebp)
  8014bf:	6a 10                	push   $0x10
  8014c1:	e8 68 fe ff ff       	call   80132e <syscall>
  8014c6:	83 c4 18             	add    $0x18,%esp
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 11                	push   $0x11
  8014da:	e8 4f fe ff ff       	call   80132e <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
}
  8014e2:	90                   	nop
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_cputc>:

void
sys_cputc(const char c)
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
  8014e8:	83 ec 04             	sub    $0x4,%esp
  8014eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014f1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	50                   	push   %eax
  8014fe:	6a 01                	push   $0x1
  801500:	e8 29 fe ff ff       	call   80132e <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	90                   	nop
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 14                	push   $0x14
  80151a:	e8 0f fe ff ff       	call   80132e <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
}
  801522:	90                   	nop
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
  801528:	83 ec 04             	sub    $0x4,%esp
  80152b:	8b 45 10             	mov    0x10(%ebp),%eax
  80152e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801531:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801534:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	6a 00                	push   $0x0
  80153d:	51                   	push   %ecx
  80153e:	52                   	push   %edx
  80153f:	ff 75 0c             	pushl  0xc(%ebp)
  801542:	50                   	push   %eax
  801543:	6a 15                	push   $0x15
  801545:	e8 e4 fd ff ff       	call   80132e <syscall>
  80154a:	83 c4 18             	add    $0x18,%esp
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801552:	8b 55 10             	mov    0x10(%ebp),%edx
  801555:	8b 45 0c             	mov    0xc(%ebp),%eax
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	52                   	push   %edx
  80155d:	50                   	push   %eax
  80155e:	ff 75 08             	pushl  0x8(%ebp)
  801561:	6a 16                	push   $0x16
  801563:	e8 c6 fd ff ff       	call   80132e <syscall>
  801568:	83 c4 18             	add    $0x18,%esp
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801570:	8b 55 0c             	mov    0xc(%ebp),%edx
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	6a 17                	push   $0x17
  801580:	e8 a9 fd ff ff       	call   80132e <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80158d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	52                   	push   %edx
  80159a:	50                   	push   %eax
  80159b:	6a 18                	push   $0x18
  80159d:	e8 8c fd ff ff       	call   80132e <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	6a 00                	push   $0x0
  8015af:	ff 75 14             	pushl  0x14(%ebp)
  8015b2:	ff 75 10             	pushl  0x10(%ebp)
  8015b5:	ff 75 0c             	pushl  0xc(%ebp)
  8015b8:	50                   	push   %eax
  8015b9:	6a 19                	push   $0x19
  8015bb:	e8 6e fd ff ff       	call   80132e <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	50                   	push   %eax
  8015d4:	6a 1a                	push   $0x1a
  8015d6:	e8 53 fd ff ff       	call   80132e <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
}
  8015de:	90                   	nop
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	50                   	push   %eax
  8015f0:	6a 1b                	push   $0x1b
  8015f2:	e8 37 fd ff ff       	call   80132e <syscall>
  8015f7:	83 c4 18             	add    $0x18,%esp
}
  8015fa:	c9                   	leave  
  8015fb:	c3                   	ret    

008015fc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 05                	push   $0x5
  80160b:	e8 1e fd ff ff       	call   80132e <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 06                	push   $0x6
  801624:	e8 05 fd ff ff       	call   80132e <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 07                	push   $0x7
  80163d:	e8 ec fc ff ff       	call   80132e <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <sys_exit_env>:


void sys_exit_env(void)
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 1c                	push   $0x1c
  801656:	e8 d3 fc ff ff       	call   80132e <syscall>
  80165b:	83 c4 18             	add    $0x18,%esp
}
  80165e:	90                   	nop
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	ff 75 10             	pushl  0x10(%ebp)
  80166b:	ff 75 0c             	pushl  0xc(%ebp)
  80166e:	ff 75 08             	pushl  0x8(%ebp)
  801671:	6a 13                	push   $0x13
  801673:	e8 b6 fc ff ff       	call   80132e <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
	return ;
  80167b:	90                   	nop
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <sys_rcr2>:
uint32 sys_rcr2()
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 1e                	push   $0x1e
  80168d:	e8 9c fc ff ff       	call   80132e <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
  80169a:	83 ec 04             	sub    $0x4,%esp
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016a3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	50                   	push   %eax
  8016b0:	6a 1f                	push   $0x1f
  8016b2:	e8 77 fc ff ff       	call   80132e <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ba:	90                   	nop
}
  8016bb:	c9                   	leave  
  8016bc:	c3                   	ret    

008016bd <rsttst>:
void rsttst()
{
  8016bd:	55                   	push   %ebp
  8016be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 21                	push   $0x21
  8016cc:	e8 5d fc ff ff       	call   80132e <syscall>
  8016d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d4:	90                   	nop
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
  8016da:	83 ec 04             	sub    $0x4,%esp
  8016dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016e3:	8b 55 18             	mov    0x18(%ebp),%edx
  8016e6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016ea:	52                   	push   %edx
  8016eb:	50                   	push   %eax
  8016ec:	ff 75 10             	pushl  0x10(%ebp)
  8016ef:	ff 75 0c             	pushl  0xc(%ebp)
  8016f2:	ff 75 08             	pushl  0x8(%ebp)
  8016f5:	6a 20                	push   $0x20
  8016f7:	e8 32 fc ff ff       	call   80132e <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ff:	90                   	nop
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <chktst>:
void chktst(uint32 n)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	ff 75 08             	pushl  0x8(%ebp)
  801710:	6a 22                	push   $0x22
  801712:	e8 17 fc ff ff       	call   80132e <syscall>
  801717:	83 c4 18             	add    $0x18,%esp
	return ;
  80171a:	90                   	nop
}
  80171b:	c9                   	leave  
  80171c:	c3                   	ret    

0080171d <inctst>:

void inctst()
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 23                	push   $0x23
  80172c:	e8 fd fb ff ff       	call   80132e <syscall>
  801731:	83 c4 18             	add    $0x18,%esp
	return ;
  801734:	90                   	nop
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <gettst>:
uint32 gettst()
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 24                	push   $0x24
  801746:	e8 e3 fb ff ff       	call   80132e <syscall>
  80174b:	83 c4 18             	add    $0x18,%esp
}
  80174e:	c9                   	leave  
  80174f:	c3                   	ret    

00801750 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801750:	55                   	push   %ebp
  801751:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 25                	push   $0x25
  80175f:	e8 ca fb ff ff       	call   80132e <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
  801767:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  80176c:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801776:	8b 45 08             	mov    0x8(%ebp),%eax
  801779:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	ff 75 08             	pushl  0x8(%ebp)
  801789:	6a 26                	push   $0x26
  80178b:	e8 9e fb ff ff       	call   80132e <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
	return ;
  801793:	90                   	nop
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
  801799:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80179a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80179d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	6a 00                	push   $0x0
  8017a8:	53                   	push   %ebx
  8017a9:	51                   	push   %ecx
  8017aa:	52                   	push   %edx
  8017ab:	50                   	push   %eax
  8017ac:	6a 27                	push   $0x27
  8017ae:	e8 7b fb ff ff       	call   80132e <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8017be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	52                   	push   %edx
  8017cb:	50                   	push   %eax
  8017cc:	6a 28                	push   $0x28
  8017ce:	e8 5b fb ff ff       	call   80132e <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8017db:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	6a 00                	push   $0x0
  8017e6:	51                   	push   %ecx
  8017e7:	ff 75 10             	pushl  0x10(%ebp)
  8017ea:	52                   	push   %edx
  8017eb:	50                   	push   %eax
  8017ec:	6a 29                	push   $0x29
  8017ee:	e8 3b fb ff ff       	call   80132e <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	ff 75 10             	pushl  0x10(%ebp)
  801802:	ff 75 0c             	pushl  0xc(%ebp)
  801805:	ff 75 08             	pushl  0x8(%ebp)
  801808:	6a 12                	push   $0x12
  80180a:	e8 1f fb ff ff       	call   80132e <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
	return ;
  801812:	90                   	nop
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801818:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181b:	8b 45 08             	mov    0x8(%ebp),%eax
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	52                   	push   %edx
  801825:	50                   	push   %eax
  801826:	6a 2a                	push   $0x2a
  801828:	e8 01 fb ff ff       	call   80132e <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
	return;
  801830:	90                   	nop
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 2b                	push   $0x2b
  801842:	e8 e7 fa ff ff       	call   80132e <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
  80184f:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801852:	83 ec 04             	sub    $0x4,%esp
  801855:	68 08 23 80 00       	push   $0x802308
  80185a:	68 0a 01 00 00       	push   $0x10a
  80185f:	68 18 23 80 00       	push   $0x802318
  801864:	e8 38 00 00 00       	call   8018a1 <_panic>

00801869 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	ff 75 0c             	pushl  0xc(%ebp)
  801875:	ff 75 08             	pushl  0x8(%ebp)
  801878:	6a 33                	push   $0x33
  80187a:	e8 af fa ff ff       	call   80132e <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
	return;
  801882:	90                   	nop
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	ff 75 0c             	pushl  0xc(%ebp)
  801891:	ff 75 08             	pushl  0x8(%ebp)
  801894:	6a 34                	push   $0x34
  801896:	e8 93 fa ff ff       	call   80132e <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
	return ;
  80189e:	90                   	nop
}
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
  8018a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8018a7:	8d 45 10             	lea    0x10(%ebp),%eax
  8018aa:	83 c0 04             	add    $0x4,%eax
  8018ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8018b0:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8018b5:	85 c0                	test   %eax,%eax
  8018b7:	74 16                	je     8018cf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8018b9:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8018be:	83 ec 08             	sub    $0x8,%esp
  8018c1:	50                   	push   %eax
  8018c2:	68 28 23 80 00       	push   $0x802328
  8018c7:	e8 7d eb ff ff       	call   800449 <cprintf>
  8018cc:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8018cf:	a1 04 30 80 00       	mov    0x803004,%eax
  8018d4:	83 ec 0c             	sub    $0xc,%esp
  8018d7:	ff 75 0c             	pushl  0xc(%ebp)
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	50                   	push   %eax
  8018de:	68 30 23 80 00       	push   $0x802330
  8018e3:	6a 74                	push   $0x74
  8018e5:	e8 8c eb ff ff       	call   800476 <cprintf_colored>
  8018ea:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8018ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f0:	83 ec 08             	sub    $0x8,%esp
  8018f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8018f6:	50                   	push   %eax
  8018f7:	e8 de ea ff ff       	call   8003da <vcprintf>
  8018fc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018ff:	83 ec 08             	sub    $0x8,%esp
  801902:	6a 00                	push   $0x0
  801904:	68 58 23 80 00       	push   $0x802358
  801909:	e8 cc ea ff ff       	call   8003da <vcprintf>
  80190e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801911:	e8 45 ea ff ff       	call   80035b <exit>

	// should not return here
	while (1) ;
  801916:	eb fe                	jmp    801916 <_panic+0x75>

00801918 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
  80191b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80191e:	a1 20 30 80 00       	mov    0x803020,%eax
  801923:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801929:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192c:	39 c2                	cmp    %eax,%edx
  80192e:	74 14                	je     801944 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801930:	83 ec 04             	sub    $0x4,%esp
  801933:	68 5c 23 80 00       	push   $0x80235c
  801938:	6a 26                	push   $0x26
  80193a:	68 a8 23 80 00       	push   $0x8023a8
  80193f:	e8 5d ff ff ff       	call   8018a1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801944:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80194b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801952:	e9 c5 00 00 00       	jmp    801a1c <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801957:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80195a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	85 c0                	test   %eax,%eax
  80196a:	75 08                	jne    801974 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80196c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80196f:	e9 a5 00 00 00       	jmp    801a19 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801974:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80197b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801982:	eb 69                	jmp    8019ed <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801984:	a1 20 30 80 00       	mov    0x803020,%eax
  801989:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80198f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801992:	89 d0                	mov    %edx,%eax
  801994:	01 c0                	add    %eax,%eax
  801996:	01 d0                	add    %edx,%eax
  801998:	c1 e0 03             	shl    $0x3,%eax
  80199b:	01 c8                	add    %ecx,%eax
  80199d:	8a 40 04             	mov    0x4(%eax),%al
  8019a0:	84 c0                	test   %al,%al
  8019a2:	75 46                	jne    8019ea <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8019a9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8019af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8019b2:	89 d0                	mov    %edx,%eax
  8019b4:	01 c0                	add    %eax,%eax
  8019b6:	01 d0                	add    %edx,%eax
  8019b8:	c1 e0 03             	shl    $0x3,%eax
  8019bb:	01 c8                	add    %ecx,%eax
  8019bd:	8b 00                	mov    (%eax),%eax
  8019bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8019c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8019ca:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8019cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019cf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8019d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d9:	01 c8                	add    %ecx,%eax
  8019db:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019dd:	39 c2                	cmp    %eax,%edx
  8019df:	75 09                	jne    8019ea <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8019e1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019e8:	eb 15                	jmp    8019ff <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ea:	ff 45 e8             	incl   -0x18(%ebp)
  8019ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8019f2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019fb:	39 c2                	cmp    %eax,%edx
  8019fd:	77 85                	ja     801984 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a03:	75 14                	jne    801a19 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801a05:	83 ec 04             	sub    $0x4,%esp
  801a08:	68 b4 23 80 00       	push   $0x8023b4
  801a0d:	6a 3a                	push   $0x3a
  801a0f:	68 a8 23 80 00       	push   $0x8023a8
  801a14:	e8 88 fe ff ff       	call   8018a1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801a19:	ff 45 f0             	incl   -0x10(%ebp)
  801a1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a1f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801a22:	0f 8c 2f ff ff ff    	jl     801957 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a28:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a2f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801a36:	eb 26                	jmp    801a5e <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801a38:	a1 20 30 80 00       	mov    0x803020,%eax
  801a3d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801a43:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a46:	89 d0                	mov    %edx,%eax
  801a48:	01 c0                	add    %eax,%eax
  801a4a:	01 d0                	add    %edx,%eax
  801a4c:	c1 e0 03             	shl    $0x3,%eax
  801a4f:	01 c8                	add    %ecx,%eax
  801a51:	8a 40 04             	mov    0x4(%eax),%al
  801a54:	3c 01                	cmp    $0x1,%al
  801a56:	75 03                	jne    801a5b <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801a58:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a5b:	ff 45 e0             	incl   -0x20(%ebp)
  801a5e:	a1 20 30 80 00       	mov    0x803020,%eax
  801a63:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a69:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a6c:	39 c2                	cmp    %eax,%edx
  801a6e:	77 c8                	ja     801a38 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a73:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a76:	74 14                	je     801a8c <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a78:	83 ec 04             	sub    $0x4,%esp
  801a7b:	68 08 24 80 00       	push   $0x802408
  801a80:	6a 44                	push   $0x44
  801a82:	68 a8 23 80 00       	push   $0x8023a8
  801a87:	e8 15 fe ff ff       	call   8018a1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a8c:	90                   	nop
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    
  801a8f:	90                   	nop

00801a90 <__udivdi3>:
  801a90:	55                   	push   %ebp
  801a91:	57                   	push   %edi
  801a92:	56                   	push   %esi
  801a93:	53                   	push   %ebx
  801a94:	83 ec 1c             	sub    $0x1c,%esp
  801a97:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a9b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aa3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801aa7:	89 ca                	mov    %ecx,%edx
  801aa9:	89 f8                	mov    %edi,%eax
  801aab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801aaf:	85 f6                	test   %esi,%esi
  801ab1:	75 2d                	jne    801ae0 <__udivdi3+0x50>
  801ab3:	39 cf                	cmp    %ecx,%edi
  801ab5:	77 65                	ja     801b1c <__udivdi3+0x8c>
  801ab7:	89 fd                	mov    %edi,%ebp
  801ab9:	85 ff                	test   %edi,%edi
  801abb:	75 0b                	jne    801ac8 <__udivdi3+0x38>
  801abd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac2:	31 d2                	xor    %edx,%edx
  801ac4:	f7 f7                	div    %edi
  801ac6:	89 c5                	mov    %eax,%ebp
  801ac8:	31 d2                	xor    %edx,%edx
  801aca:	89 c8                	mov    %ecx,%eax
  801acc:	f7 f5                	div    %ebp
  801ace:	89 c1                	mov    %eax,%ecx
  801ad0:	89 d8                	mov    %ebx,%eax
  801ad2:	f7 f5                	div    %ebp
  801ad4:	89 cf                	mov    %ecx,%edi
  801ad6:	89 fa                	mov    %edi,%edx
  801ad8:	83 c4 1c             	add    $0x1c,%esp
  801adb:	5b                   	pop    %ebx
  801adc:	5e                   	pop    %esi
  801add:	5f                   	pop    %edi
  801ade:	5d                   	pop    %ebp
  801adf:	c3                   	ret    
  801ae0:	39 ce                	cmp    %ecx,%esi
  801ae2:	77 28                	ja     801b0c <__udivdi3+0x7c>
  801ae4:	0f bd fe             	bsr    %esi,%edi
  801ae7:	83 f7 1f             	xor    $0x1f,%edi
  801aea:	75 40                	jne    801b2c <__udivdi3+0x9c>
  801aec:	39 ce                	cmp    %ecx,%esi
  801aee:	72 0a                	jb     801afa <__udivdi3+0x6a>
  801af0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801af4:	0f 87 9e 00 00 00    	ja     801b98 <__udivdi3+0x108>
  801afa:	b8 01 00 00 00       	mov    $0x1,%eax
  801aff:	89 fa                	mov    %edi,%edx
  801b01:	83 c4 1c             	add    $0x1c,%esp
  801b04:	5b                   	pop    %ebx
  801b05:	5e                   	pop    %esi
  801b06:	5f                   	pop    %edi
  801b07:	5d                   	pop    %ebp
  801b08:	c3                   	ret    
  801b09:	8d 76 00             	lea    0x0(%esi),%esi
  801b0c:	31 ff                	xor    %edi,%edi
  801b0e:	31 c0                	xor    %eax,%eax
  801b10:	89 fa                	mov    %edi,%edx
  801b12:	83 c4 1c             	add    $0x1c,%esp
  801b15:	5b                   	pop    %ebx
  801b16:	5e                   	pop    %esi
  801b17:	5f                   	pop    %edi
  801b18:	5d                   	pop    %ebp
  801b19:	c3                   	ret    
  801b1a:	66 90                	xchg   %ax,%ax
  801b1c:	89 d8                	mov    %ebx,%eax
  801b1e:	f7 f7                	div    %edi
  801b20:	31 ff                	xor    %edi,%edi
  801b22:	89 fa                	mov    %edi,%edx
  801b24:	83 c4 1c             	add    $0x1c,%esp
  801b27:	5b                   	pop    %ebx
  801b28:	5e                   	pop    %esi
  801b29:	5f                   	pop    %edi
  801b2a:	5d                   	pop    %ebp
  801b2b:	c3                   	ret    
  801b2c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b31:	89 eb                	mov    %ebp,%ebx
  801b33:	29 fb                	sub    %edi,%ebx
  801b35:	89 f9                	mov    %edi,%ecx
  801b37:	d3 e6                	shl    %cl,%esi
  801b39:	89 c5                	mov    %eax,%ebp
  801b3b:	88 d9                	mov    %bl,%cl
  801b3d:	d3 ed                	shr    %cl,%ebp
  801b3f:	89 e9                	mov    %ebp,%ecx
  801b41:	09 f1                	or     %esi,%ecx
  801b43:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b47:	89 f9                	mov    %edi,%ecx
  801b49:	d3 e0                	shl    %cl,%eax
  801b4b:	89 c5                	mov    %eax,%ebp
  801b4d:	89 d6                	mov    %edx,%esi
  801b4f:	88 d9                	mov    %bl,%cl
  801b51:	d3 ee                	shr    %cl,%esi
  801b53:	89 f9                	mov    %edi,%ecx
  801b55:	d3 e2                	shl    %cl,%edx
  801b57:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b5b:	88 d9                	mov    %bl,%cl
  801b5d:	d3 e8                	shr    %cl,%eax
  801b5f:	09 c2                	or     %eax,%edx
  801b61:	89 d0                	mov    %edx,%eax
  801b63:	89 f2                	mov    %esi,%edx
  801b65:	f7 74 24 0c          	divl   0xc(%esp)
  801b69:	89 d6                	mov    %edx,%esi
  801b6b:	89 c3                	mov    %eax,%ebx
  801b6d:	f7 e5                	mul    %ebp
  801b6f:	39 d6                	cmp    %edx,%esi
  801b71:	72 19                	jb     801b8c <__udivdi3+0xfc>
  801b73:	74 0b                	je     801b80 <__udivdi3+0xf0>
  801b75:	89 d8                	mov    %ebx,%eax
  801b77:	31 ff                	xor    %edi,%edi
  801b79:	e9 58 ff ff ff       	jmp    801ad6 <__udivdi3+0x46>
  801b7e:	66 90                	xchg   %ax,%ax
  801b80:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b84:	89 f9                	mov    %edi,%ecx
  801b86:	d3 e2                	shl    %cl,%edx
  801b88:	39 c2                	cmp    %eax,%edx
  801b8a:	73 e9                	jae    801b75 <__udivdi3+0xe5>
  801b8c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b8f:	31 ff                	xor    %edi,%edi
  801b91:	e9 40 ff ff ff       	jmp    801ad6 <__udivdi3+0x46>
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	31 c0                	xor    %eax,%eax
  801b9a:	e9 37 ff ff ff       	jmp    801ad6 <__udivdi3+0x46>
  801b9f:	90                   	nop

00801ba0 <__umoddi3>:
  801ba0:	55                   	push   %ebp
  801ba1:	57                   	push   %edi
  801ba2:	56                   	push   %esi
  801ba3:	53                   	push   %ebx
  801ba4:	83 ec 1c             	sub    $0x1c,%esp
  801ba7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bab:	8b 74 24 34          	mov    0x34(%esp),%esi
  801baf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bb3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bb7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bbb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bbf:	89 f3                	mov    %esi,%ebx
  801bc1:	89 fa                	mov    %edi,%edx
  801bc3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bc7:	89 34 24             	mov    %esi,(%esp)
  801bca:	85 c0                	test   %eax,%eax
  801bcc:	75 1a                	jne    801be8 <__umoddi3+0x48>
  801bce:	39 f7                	cmp    %esi,%edi
  801bd0:	0f 86 a2 00 00 00    	jbe    801c78 <__umoddi3+0xd8>
  801bd6:	89 c8                	mov    %ecx,%eax
  801bd8:	89 f2                	mov    %esi,%edx
  801bda:	f7 f7                	div    %edi
  801bdc:	89 d0                	mov    %edx,%eax
  801bde:	31 d2                	xor    %edx,%edx
  801be0:	83 c4 1c             	add    $0x1c,%esp
  801be3:	5b                   	pop    %ebx
  801be4:	5e                   	pop    %esi
  801be5:	5f                   	pop    %edi
  801be6:	5d                   	pop    %ebp
  801be7:	c3                   	ret    
  801be8:	39 f0                	cmp    %esi,%eax
  801bea:	0f 87 ac 00 00 00    	ja     801c9c <__umoddi3+0xfc>
  801bf0:	0f bd e8             	bsr    %eax,%ebp
  801bf3:	83 f5 1f             	xor    $0x1f,%ebp
  801bf6:	0f 84 ac 00 00 00    	je     801ca8 <__umoddi3+0x108>
  801bfc:	bf 20 00 00 00       	mov    $0x20,%edi
  801c01:	29 ef                	sub    %ebp,%edi
  801c03:	89 fe                	mov    %edi,%esi
  801c05:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c09:	89 e9                	mov    %ebp,%ecx
  801c0b:	d3 e0                	shl    %cl,%eax
  801c0d:	89 d7                	mov    %edx,%edi
  801c0f:	89 f1                	mov    %esi,%ecx
  801c11:	d3 ef                	shr    %cl,%edi
  801c13:	09 c7                	or     %eax,%edi
  801c15:	89 e9                	mov    %ebp,%ecx
  801c17:	d3 e2                	shl    %cl,%edx
  801c19:	89 14 24             	mov    %edx,(%esp)
  801c1c:	89 d8                	mov    %ebx,%eax
  801c1e:	d3 e0                	shl    %cl,%eax
  801c20:	89 c2                	mov    %eax,%edx
  801c22:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c26:	d3 e0                	shl    %cl,%eax
  801c28:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c2c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c30:	89 f1                	mov    %esi,%ecx
  801c32:	d3 e8                	shr    %cl,%eax
  801c34:	09 d0                	or     %edx,%eax
  801c36:	d3 eb                	shr    %cl,%ebx
  801c38:	89 da                	mov    %ebx,%edx
  801c3a:	f7 f7                	div    %edi
  801c3c:	89 d3                	mov    %edx,%ebx
  801c3e:	f7 24 24             	mull   (%esp)
  801c41:	89 c6                	mov    %eax,%esi
  801c43:	89 d1                	mov    %edx,%ecx
  801c45:	39 d3                	cmp    %edx,%ebx
  801c47:	0f 82 87 00 00 00    	jb     801cd4 <__umoddi3+0x134>
  801c4d:	0f 84 91 00 00 00    	je     801ce4 <__umoddi3+0x144>
  801c53:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c57:	29 f2                	sub    %esi,%edx
  801c59:	19 cb                	sbb    %ecx,%ebx
  801c5b:	89 d8                	mov    %ebx,%eax
  801c5d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c61:	d3 e0                	shl    %cl,%eax
  801c63:	89 e9                	mov    %ebp,%ecx
  801c65:	d3 ea                	shr    %cl,%edx
  801c67:	09 d0                	or     %edx,%eax
  801c69:	89 e9                	mov    %ebp,%ecx
  801c6b:	d3 eb                	shr    %cl,%ebx
  801c6d:	89 da                	mov    %ebx,%edx
  801c6f:	83 c4 1c             	add    $0x1c,%esp
  801c72:	5b                   	pop    %ebx
  801c73:	5e                   	pop    %esi
  801c74:	5f                   	pop    %edi
  801c75:	5d                   	pop    %ebp
  801c76:	c3                   	ret    
  801c77:	90                   	nop
  801c78:	89 fd                	mov    %edi,%ebp
  801c7a:	85 ff                	test   %edi,%edi
  801c7c:	75 0b                	jne    801c89 <__umoddi3+0xe9>
  801c7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c83:	31 d2                	xor    %edx,%edx
  801c85:	f7 f7                	div    %edi
  801c87:	89 c5                	mov    %eax,%ebp
  801c89:	89 f0                	mov    %esi,%eax
  801c8b:	31 d2                	xor    %edx,%edx
  801c8d:	f7 f5                	div    %ebp
  801c8f:	89 c8                	mov    %ecx,%eax
  801c91:	f7 f5                	div    %ebp
  801c93:	89 d0                	mov    %edx,%eax
  801c95:	e9 44 ff ff ff       	jmp    801bde <__umoddi3+0x3e>
  801c9a:	66 90                	xchg   %ax,%ax
  801c9c:	89 c8                	mov    %ecx,%eax
  801c9e:	89 f2                	mov    %esi,%edx
  801ca0:	83 c4 1c             	add    $0x1c,%esp
  801ca3:	5b                   	pop    %ebx
  801ca4:	5e                   	pop    %esi
  801ca5:	5f                   	pop    %edi
  801ca6:	5d                   	pop    %ebp
  801ca7:	c3                   	ret    
  801ca8:	3b 04 24             	cmp    (%esp),%eax
  801cab:	72 06                	jb     801cb3 <__umoddi3+0x113>
  801cad:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cb1:	77 0f                	ja     801cc2 <__umoddi3+0x122>
  801cb3:	89 f2                	mov    %esi,%edx
  801cb5:	29 f9                	sub    %edi,%ecx
  801cb7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cbb:	89 14 24             	mov    %edx,(%esp)
  801cbe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cc2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cc6:	8b 14 24             	mov    (%esp),%edx
  801cc9:	83 c4 1c             	add    $0x1c,%esp
  801ccc:	5b                   	pop    %ebx
  801ccd:	5e                   	pop    %esi
  801cce:	5f                   	pop    %edi
  801ccf:	5d                   	pop    %ebp
  801cd0:	c3                   	ret    
  801cd1:	8d 76 00             	lea    0x0(%esi),%esi
  801cd4:	2b 04 24             	sub    (%esp),%eax
  801cd7:	19 fa                	sbb    %edi,%edx
  801cd9:	89 d1                	mov    %edx,%ecx
  801cdb:	89 c6                	mov    %eax,%esi
  801cdd:	e9 71 ff ff ff       	jmp    801c53 <__umoddi3+0xb3>
  801ce2:	66 90                	xchg   %ax,%ax
  801ce4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ce8:	72 ea                	jb     801cd4 <__umoddi3+0x134>
  801cea:	89 d9                	mov    %ebx,%ecx
  801cec:	e9 62 ff ff ff       	jmp    801c53 <__umoddi3+0xb3>
