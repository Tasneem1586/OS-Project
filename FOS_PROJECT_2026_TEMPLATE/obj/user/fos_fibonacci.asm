
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 b7 00 00 00       	call   8000ed <libmain>
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
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];

	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 40 1f 80 00       	push   $0x801f40
  800057:	e8 a9 0b 00 00       	call   800c05 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp

	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 ab 10 00 00       	call   80111d <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int64 res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 22 00 00 00       	call   8000a5 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800089:	89 55 ec             	mov    %edx,-0x14(%ebp)

	atomic_cprintf("%@Fibonacci #%d = %lld\n",i1, res);
  80008c:	ff 75 ec             	pushl  -0x14(%ebp)
  80008f:	ff 75 e8             	pushl  -0x18(%ebp)
  800092:	ff 75 f4             	pushl  -0xc(%ebp)
  800095:	68 5e 1f 80 00       	push   $0x801f5e
  80009a:	e8 00 04 00 00       	call   80049f <atomic_cprintf>
  80009f:	83 c4 10             	add    $0x10,%esp

	return;
  8000a2:	90                   	nop
}
  8000a3:	c9                   	leave  
  8000a4:	c3                   	ret    

008000a5 <fibonacci>:


int64 fibonacci(int n)
{
  8000a5:	55                   	push   %ebp
  8000a6:	89 e5                	mov    %esp,%ebp
  8000a8:	56                   	push   %esi
  8000a9:	53                   	push   %ebx
	if (n <= 1)
  8000aa:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ae:	7f 0c                	jg     8000bc <fibonacci+0x17>
		return 1 ;
  8000b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8000ba:	eb 2a                	jmp    8000e6 <fibonacci+0x41>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8000bf:	48                   	dec    %eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 dc ff ff ff       	call   8000a5 <fibonacci>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 c3                	mov    %eax,%ebx
  8000ce:	89 d6                	mov    %edx,%esi
  8000d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8000d3:	83 e8 02             	sub    $0x2,%eax
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	50                   	push   %eax
  8000da:	e8 c6 ff ff ff       	call   8000a5 <fibonacci>
  8000df:	83 c4 10             	add    $0x10,%esp
  8000e2:	01 d8                	add    %ebx,%eax
  8000e4:	11 f2                	adc    %esi,%edx
}
  8000e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8000e9:	5b                   	pop    %ebx
  8000ea:	5e                   	pop    %esi
  8000eb:	5d                   	pop    %ebp
  8000ec:	c3                   	ret    

008000ed <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000ed:	55                   	push   %ebp
  8000ee:	89 e5                	mov    %esp,%ebp
  8000f0:	57                   	push   %edi
  8000f1:	56                   	push   %esi
  8000f2:	53                   	push   %ebx
  8000f3:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000f9:	e8 03 17 00 00       	call   801801 <sys_getenvindex>
  8000fe:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800101:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800104:	89 d0                	mov    %edx,%eax
  800106:	c1 e0 03             	shl    $0x3,%eax
  800109:	01 d0                	add    %edx,%eax
  80010b:	c1 e0 06             	shl    $0x6,%eax
  80010e:	01 d0                	add    %edx,%eax
  800110:	c1 e0 03             	shl    $0x3,%eax
  800113:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800118:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80011d:	a1 20 30 80 00       	mov    0x803020,%eax
  800122:	8a 40 10             	mov    0x10(%eax),%al
  800125:	84 c0                	test   %al,%al
  800127:	74 0d                	je     800136 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800129:	a1 20 30 80 00       	mov    0x803020,%eax
  80012e:	83 c0 10             	add    $0x10,%eax
  800131:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800136:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80013a:	7e 0a                	jle    800146 <libmain+0x59>
		binaryname = argv[0];
  80013c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80013f:	8b 00                	mov    (%eax),%eax
  800141:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800146:	83 ec 08             	sub    $0x8,%esp
  800149:	ff 75 0c             	pushl  0xc(%ebp)
  80014c:	ff 75 08             	pushl  0x8(%ebp)
  80014f:	e8 e4 fe ff ff       	call   800038 <_main>
  800154:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800157:	a1 00 30 80 00       	mov    0x803000,%eax
  80015c:	85 c0                	test   %eax,%eax
  80015e:	0f 84 b7 01 00 00    	je     80031b <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800164:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80016a:	bb b4 20 80 00       	mov    $0x8020b4,%ebx
  80016f:	ba 0e 00 00 00       	mov    $0xe,%edx
  800174:	89 c7                	mov    %eax,%edi
  800176:	89 de                	mov    %ebx,%esi
  800178:	89 d1                	mov    %edx,%ecx
  80017a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80017c:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800182:	b9 56 00 00 00       	mov    $0x56,%ecx
  800187:	b0 00                	mov    $0x0,%al
  800189:	89 d7                	mov    %edx,%edi
  80018b:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80018d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800194:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	50                   	push   %eax
  80019b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001a1:	50                   	push   %eax
  8001a2:	e8 5a 18 00 00       	call   801a01 <sys_utilities>
  8001a7:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001aa:	e8 da 13 00 00       	call   801589 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001af:	83 ec 0c             	sub    $0xc,%esp
  8001b2:	68 90 1f 80 00       	push   $0x801f90
  8001b7:	e8 71 02 00 00       	call   80042d <cprintf>
  8001bc:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001bf:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001c2:	85 c0                	test   %eax,%eax
  8001c4:	74 58                	je     80021e <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001c6:	e8 54 18 00 00       	call   801a1f <sys_get_optimal_num_faults>
  8001cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001ce:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001d4:	bb 18 21 80 00       	mov    $0x802118,%ebx
  8001d9:	ba 11 00 00 00       	mov    $0x11,%edx
  8001de:	89 c7                	mov    %eax,%edi
  8001e0:	89 de                	mov    %ebx,%esi
  8001e2:	89 d1                	mov    %edx,%ecx
  8001e4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001e6:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001e9:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001ee:	b0 00                	mov    $0x0,%al
  8001f0:	89 d7                	mov    %edx,%edi
  8001f2:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001f4:	83 ec 08             	sub    $0x8,%esp
  8001f7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001fa:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800200:	50                   	push   %eax
  800201:	e8 fb 17 00 00       	call   801a01 <sys_utilities>
  800206:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800209:	83 ec 08             	sub    $0x8,%esp
  80020c:	ff 75 dc             	pushl  -0x24(%ebp)
  80020f:	68 b8 1f 80 00       	push   $0x801fb8
  800214:	e8 14 02 00 00       	call   80042d <cprintf>
  800219:	83 c4 10             	add    $0x10,%esp
  80021c:	eb 59                	jmp    800277 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80021e:	a1 20 30 80 00       	mov    0x803020,%eax
  800223:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800229:	a1 20 30 80 00       	mov    0x803020,%eax
  80022e:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800234:	83 ec 04             	sub    $0x4,%esp
  800237:	52                   	push   %edx
  800238:	50                   	push   %eax
  800239:	68 dc 1f 80 00       	push   $0x801fdc
  80023e:	e8 ea 01 00 00       	call   80042d <cprintf>
  800243:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800246:	a1 20 30 80 00       	mov    0x803020,%eax
  80024b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800251:	a1 20 30 80 00       	mov    0x803020,%eax
  800256:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80025c:	a1 20 30 80 00       	mov    0x803020,%eax
  800261:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800267:	51                   	push   %ecx
  800268:	52                   	push   %edx
  800269:	50                   	push   %eax
  80026a:	68 04 20 80 00       	push   $0x802004
  80026f:	e8 b9 01 00 00       	call   80042d <cprintf>
  800274:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800277:	a1 20 30 80 00       	mov    0x803020,%eax
  80027c:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800282:	83 ec 08             	sub    $0x8,%esp
  800285:	50                   	push   %eax
  800286:	68 5c 20 80 00       	push   $0x80205c
  80028b:	e8 9d 01 00 00       	call   80042d <cprintf>
  800290:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800293:	83 ec 0c             	sub    $0xc,%esp
  800296:	68 70 20 80 00       	push   $0x802070
  80029b:	e8 8d 01 00 00       	call   80042d <cprintf>
  8002a0:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002aa:	eb 28                	jmp    8002d4 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002b4:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002ba:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002bd:	83 ec 04             	sub    $0x4,%esp
  8002c0:	50                   	push   %eax
  8002c1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c4:	68 87 20 80 00       	push   $0x802087
  8002c9:	e8 5f 01 00 00       	call   80042d <cprintf>
  8002ce:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002d1:	ff 45 e4             	incl   -0x1c(%ebp)
  8002d4:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002d8:	7e d2                	jle    8002ac <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002da:	83 ec 0c             	sub    $0xc,%esp
  8002dd:	68 96 20 80 00       	push   $0x802096
  8002e2:	e8 46 01 00 00       	call   80042d <cprintf>
  8002e7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ef:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002f5:	83 ec 08             	sub    $0x8,%esp
  8002f8:	50                   	push   %eax
  8002f9:	68 9a 20 80 00       	push   $0x80209a
  8002fe:	e8 2a 01 00 00       	call   80042d <cprintf>
  800303:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800306:	83 ec 0c             	sub    $0xc,%esp
  800309:	68 90 1f 80 00       	push   $0x801f90
  80030e:	e8 1a 01 00 00       	call   80042d <cprintf>
  800313:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800316:	e8 88 12 00 00       	call   8015a3 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80031b:	e8 1f 00 00 00       	call   80033f <exit>
}
  800320:	90                   	nop
  800321:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800324:	5b                   	pop    %ebx
  800325:	5e                   	pop    %esi
  800326:	5f                   	pop    %edi
  800327:	5d                   	pop    %ebp
  800328:	c3                   	ret    

00800329 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	6a 00                	push   $0x0
  800334:	e8 94 14 00 00       	call   8017cd <sys_destroy_env>
  800339:	83 c4 10             	add    $0x10,%esp
}
  80033c:	90                   	nop
  80033d:	c9                   	leave  
  80033e:	c3                   	ret    

0080033f <exit>:

void
exit(void)
{
  80033f:	55                   	push   %ebp
  800340:	89 e5                	mov    %esp,%ebp
  800342:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800345:	e8 e9 14 00 00       	call   801833 <sys_exit_env>
}
  80034a:	90                   	nop
  80034b:	c9                   	leave  
  80034c:	c3                   	ret    

0080034d <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80034d:	55                   	push   %ebp
  80034e:	89 e5                	mov    %esp,%ebp
  800350:	53                   	push   %ebx
  800351:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800354:	8b 45 0c             	mov    0xc(%ebp),%eax
  800357:	8b 00                	mov    (%eax),%eax
  800359:	8d 48 01             	lea    0x1(%eax),%ecx
  80035c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80035f:	89 0a                	mov    %ecx,(%edx)
  800361:	8b 55 08             	mov    0x8(%ebp),%edx
  800364:	88 d1                	mov    %dl,%cl
  800366:	8b 55 0c             	mov    0xc(%ebp),%edx
  800369:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80036d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800370:	8b 00                	mov    (%eax),%eax
  800372:	3d ff 00 00 00       	cmp    $0xff,%eax
  800377:	75 30                	jne    8003a9 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800379:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80037f:	a0 40 30 80 00       	mov    0x803040,%al
  800384:	0f b6 c0             	movzbl %al,%eax
  800387:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80038a:	8b 09                	mov    (%ecx),%ecx
  80038c:	89 cb                	mov    %ecx,%ebx
  80038e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800391:	83 c1 08             	add    $0x8,%ecx
  800394:	52                   	push   %edx
  800395:	50                   	push   %eax
  800396:	53                   	push   %ebx
  800397:	51                   	push   %ecx
  800398:	e8 a8 11 00 00       	call   801545 <sys_cputs>
  80039d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ac:	8b 40 04             	mov    0x4(%eax),%eax
  8003af:	8d 50 01             	lea    0x1(%eax),%edx
  8003b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003b8:	90                   	nop
  8003b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003bc:	c9                   	leave  
  8003bd:	c3                   	ret    

008003be <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003be:	55                   	push   %ebp
  8003bf:	89 e5                	mov    %esp,%ebp
  8003c1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003c7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003ce:	00 00 00 
	b.cnt = 0;
  8003d1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003d8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003db:	ff 75 0c             	pushl  0xc(%ebp)
  8003de:	ff 75 08             	pushl  0x8(%ebp)
  8003e1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003e7:	50                   	push   %eax
  8003e8:	68 4d 03 80 00       	push   $0x80034d
  8003ed:	e8 5a 02 00 00       	call   80064c <vprintfmt>
  8003f2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003f5:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003fb:	a0 40 30 80 00       	mov    0x803040,%al
  800400:	0f b6 c0             	movzbl %al,%eax
  800403:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800409:	52                   	push   %edx
  80040a:	50                   	push   %eax
  80040b:	51                   	push   %ecx
  80040c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800412:	83 c0 08             	add    $0x8,%eax
  800415:	50                   	push   %eax
  800416:	e8 2a 11 00 00       	call   801545 <sys_cputs>
  80041b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80041e:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800425:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80042b:	c9                   	leave  
  80042c:	c3                   	ret    

0080042d <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80042d:	55                   	push   %ebp
  80042e:	89 e5                	mov    %esp,%ebp
  800430:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800433:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80043a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80043d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	83 ec 08             	sub    $0x8,%esp
  800446:	ff 75 f4             	pushl  -0xc(%ebp)
  800449:	50                   	push   %eax
  80044a:	e8 6f ff ff ff       	call   8003be <vcprintf>
  80044f:	83 c4 10             	add    $0x10,%esp
  800452:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800455:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800458:	c9                   	leave  
  800459:	c3                   	ret    

0080045a <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80045a:	55                   	push   %ebp
  80045b:	89 e5                	mov    %esp,%ebp
  80045d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800460:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	c1 e0 08             	shl    $0x8,%eax
  80046d:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800472:	8d 45 0c             	lea    0xc(%ebp),%eax
  800475:	83 c0 04             	add    $0x4,%eax
  800478:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80047b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047e:	83 ec 08             	sub    $0x8,%esp
  800481:	ff 75 f4             	pushl  -0xc(%ebp)
  800484:	50                   	push   %eax
  800485:	e8 34 ff ff ff       	call   8003be <vcprintf>
  80048a:	83 c4 10             	add    $0x10,%esp
  80048d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800490:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800497:	07 00 00 

	return cnt;
  80049a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80049d:	c9                   	leave  
  80049e:	c3                   	ret    

0080049f <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80049f:	55                   	push   %ebp
  8004a0:	89 e5                	mov    %esp,%ebp
  8004a2:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8004a5:	e8 df 10 00 00       	call   801589 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8004aa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8004b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b3:	83 ec 08             	sub    $0x8,%esp
  8004b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8004b9:	50                   	push   %eax
  8004ba:	e8 ff fe ff ff       	call   8003be <vcprintf>
  8004bf:	83 c4 10             	add    $0x10,%esp
  8004c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004c5:	e8 d9 10 00 00       	call   8015a3 <sys_unlock_cons>
	return cnt;
  8004ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004cd:	c9                   	leave  
  8004ce:	c3                   	ret    

008004cf <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004cf:	55                   	push   %ebp
  8004d0:	89 e5                	mov    %esp,%ebp
  8004d2:	53                   	push   %ebx
  8004d3:	83 ec 14             	sub    $0x14,%esp
  8004d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004e2:	8b 45 18             	mov    0x18(%ebp),%eax
  8004e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8004ea:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004ed:	77 55                	ja     800544 <printnum+0x75>
  8004ef:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004f2:	72 05                	jb     8004f9 <printnum+0x2a>
  8004f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004f7:	77 4b                	ja     800544 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004f9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004fc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004ff:	8b 45 18             	mov    0x18(%ebp),%eax
  800502:	ba 00 00 00 00       	mov    $0x0,%edx
  800507:	52                   	push   %edx
  800508:	50                   	push   %eax
  800509:	ff 75 f4             	pushl  -0xc(%ebp)
  80050c:	ff 75 f0             	pushl  -0x10(%ebp)
  80050f:	e8 ac 17 00 00       	call   801cc0 <__udivdi3>
  800514:	83 c4 10             	add    $0x10,%esp
  800517:	83 ec 04             	sub    $0x4,%esp
  80051a:	ff 75 20             	pushl  0x20(%ebp)
  80051d:	53                   	push   %ebx
  80051e:	ff 75 18             	pushl  0x18(%ebp)
  800521:	52                   	push   %edx
  800522:	50                   	push   %eax
  800523:	ff 75 0c             	pushl  0xc(%ebp)
  800526:	ff 75 08             	pushl  0x8(%ebp)
  800529:	e8 a1 ff ff ff       	call   8004cf <printnum>
  80052e:	83 c4 20             	add    $0x20,%esp
  800531:	eb 1a                	jmp    80054d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800533:	83 ec 08             	sub    $0x8,%esp
  800536:	ff 75 0c             	pushl  0xc(%ebp)
  800539:	ff 75 20             	pushl  0x20(%ebp)
  80053c:	8b 45 08             	mov    0x8(%ebp),%eax
  80053f:	ff d0                	call   *%eax
  800541:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800544:	ff 4d 1c             	decl   0x1c(%ebp)
  800547:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80054b:	7f e6                	jg     800533 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80054d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800550:	bb 00 00 00 00       	mov    $0x0,%ebx
  800555:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800558:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80055b:	53                   	push   %ebx
  80055c:	51                   	push   %ecx
  80055d:	52                   	push   %edx
  80055e:	50                   	push   %eax
  80055f:	e8 6c 18 00 00       	call   801dd0 <__umoddi3>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	05 94 23 80 00       	add    $0x802394,%eax
  80056c:	8a 00                	mov    (%eax),%al
  80056e:	0f be c0             	movsbl %al,%eax
  800571:	83 ec 08             	sub    $0x8,%esp
  800574:	ff 75 0c             	pushl  0xc(%ebp)
  800577:	50                   	push   %eax
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	ff d0                	call   *%eax
  80057d:	83 c4 10             	add    $0x10,%esp
}
  800580:	90                   	nop
  800581:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800584:	c9                   	leave  
  800585:	c3                   	ret    

00800586 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800586:	55                   	push   %ebp
  800587:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800589:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80058d:	7e 1c                	jle    8005ab <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	8d 50 08             	lea    0x8(%eax),%edx
  800597:	8b 45 08             	mov    0x8(%ebp),%eax
  80059a:	89 10                	mov    %edx,(%eax)
  80059c:	8b 45 08             	mov    0x8(%ebp),%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 e8 08             	sub    $0x8,%eax
  8005a4:	8b 50 04             	mov    0x4(%eax),%edx
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	eb 40                	jmp    8005eb <getuint+0x65>
	else if (lflag)
  8005ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005af:	74 1e                	je     8005cf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	8d 50 04             	lea    0x4(%eax),%edx
  8005b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bc:	89 10                	mov    %edx,(%eax)
  8005be:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	83 e8 04             	sub    $0x4,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005cd:	eb 1c                	jmp    8005eb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	8d 50 04             	lea    0x4(%eax),%edx
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	89 10                	mov    %edx,(%eax)
  8005dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	83 e8 04             	sub    $0x4,%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005eb:	5d                   	pop    %ebp
  8005ec:	c3                   	ret    

008005ed <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005ed:	55                   	push   %ebp
  8005ee:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005f0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005f4:	7e 1c                	jle    800612 <getint+0x25>
		return va_arg(*ap, long long);
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	8d 50 08             	lea    0x8(%eax),%edx
  8005fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800601:	89 10                	mov    %edx,(%eax)
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	8b 00                	mov    (%eax),%eax
  800608:	83 e8 08             	sub    $0x8,%eax
  80060b:	8b 50 04             	mov    0x4(%eax),%edx
  80060e:	8b 00                	mov    (%eax),%eax
  800610:	eb 38                	jmp    80064a <getint+0x5d>
	else if (lflag)
  800612:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800616:	74 1a                	je     800632 <getint+0x45>
		return va_arg(*ap, long);
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	8d 50 04             	lea    0x4(%eax),%edx
  800620:	8b 45 08             	mov    0x8(%ebp),%eax
  800623:	89 10                	mov    %edx,(%eax)
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	83 e8 04             	sub    $0x4,%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	99                   	cltd   
  800630:	eb 18                	jmp    80064a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	8d 50 04             	lea    0x4(%eax),%edx
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	89 10                	mov    %edx,(%eax)
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	83 e8 04             	sub    $0x4,%eax
  800647:	8b 00                	mov    (%eax),%eax
  800649:	99                   	cltd   
}
  80064a:	5d                   	pop    %ebp
  80064b:	c3                   	ret    

0080064c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80064c:	55                   	push   %ebp
  80064d:	89 e5                	mov    %esp,%ebp
  80064f:	56                   	push   %esi
  800650:	53                   	push   %ebx
  800651:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800654:	eb 17                	jmp    80066d <vprintfmt+0x21>
			if (ch == '\0')
  800656:	85 db                	test   %ebx,%ebx
  800658:	0f 84 c1 03 00 00    	je     800a1f <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80065e:	83 ec 08             	sub    $0x8,%esp
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	53                   	push   %ebx
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	ff d0                	call   *%eax
  80066a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80066d:	8b 45 10             	mov    0x10(%ebp),%eax
  800670:	8d 50 01             	lea    0x1(%eax),%edx
  800673:	89 55 10             	mov    %edx,0x10(%ebp)
  800676:	8a 00                	mov    (%eax),%al
  800678:	0f b6 d8             	movzbl %al,%ebx
  80067b:	83 fb 25             	cmp    $0x25,%ebx
  80067e:	75 d6                	jne    800656 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800680:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800684:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80068b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800692:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800699:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8006a9:	8a 00                	mov    (%eax),%al
  8006ab:	0f b6 d8             	movzbl %al,%ebx
  8006ae:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006b1:	83 f8 5b             	cmp    $0x5b,%eax
  8006b4:	0f 87 3d 03 00 00    	ja     8009f7 <vprintfmt+0x3ab>
  8006ba:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  8006c1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006c3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006c7:	eb d7                	jmp    8006a0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006c9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006cd:	eb d1                	jmp    8006a0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006cf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006d9:	89 d0                	mov    %edx,%eax
  8006db:	c1 e0 02             	shl    $0x2,%eax
  8006de:	01 d0                	add    %edx,%eax
  8006e0:	01 c0                	add    %eax,%eax
  8006e2:	01 d8                	add    %ebx,%eax
  8006e4:	83 e8 30             	sub    $0x30,%eax
  8006e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ed:	8a 00                	mov    (%eax),%al
  8006ef:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006f2:	83 fb 2f             	cmp    $0x2f,%ebx
  8006f5:	7e 3e                	jle    800735 <vprintfmt+0xe9>
  8006f7:	83 fb 39             	cmp    $0x39,%ebx
  8006fa:	7f 39                	jg     800735 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006fc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006ff:	eb d5                	jmp    8006d6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800701:	8b 45 14             	mov    0x14(%ebp),%eax
  800704:	83 c0 04             	add    $0x4,%eax
  800707:	89 45 14             	mov    %eax,0x14(%ebp)
  80070a:	8b 45 14             	mov    0x14(%ebp),%eax
  80070d:	83 e8 04             	sub    $0x4,%eax
  800710:	8b 00                	mov    (%eax),%eax
  800712:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800715:	eb 1f                	jmp    800736 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800717:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80071b:	79 83                	jns    8006a0 <vprintfmt+0x54>
				width = 0;
  80071d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800724:	e9 77 ff ff ff       	jmp    8006a0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800729:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800730:	e9 6b ff ff ff       	jmp    8006a0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800735:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800736:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80073a:	0f 89 60 ff ff ff    	jns    8006a0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800740:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800743:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800746:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80074d:	e9 4e ff ff ff       	jmp    8006a0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800752:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800755:	e9 46 ff ff ff       	jmp    8006a0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80075a:	8b 45 14             	mov    0x14(%ebp),%eax
  80075d:	83 c0 04             	add    $0x4,%eax
  800760:	89 45 14             	mov    %eax,0x14(%ebp)
  800763:	8b 45 14             	mov    0x14(%ebp),%eax
  800766:	83 e8 04             	sub    $0x4,%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	ff 75 0c             	pushl  0xc(%ebp)
  800771:	50                   	push   %eax
  800772:	8b 45 08             	mov    0x8(%ebp),%eax
  800775:	ff d0                	call   *%eax
  800777:	83 c4 10             	add    $0x10,%esp
			break;
  80077a:	e9 9b 02 00 00       	jmp    800a1a <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80077f:	8b 45 14             	mov    0x14(%ebp),%eax
  800782:	83 c0 04             	add    $0x4,%eax
  800785:	89 45 14             	mov    %eax,0x14(%ebp)
  800788:	8b 45 14             	mov    0x14(%ebp),%eax
  80078b:	83 e8 04             	sub    $0x4,%eax
  80078e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800790:	85 db                	test   %ebx,%ebx
  800792:	79 02                	jns    800796 <vprintfmt+0x14a>
				err = -err;
  800794:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800796:	83 fb 64             	cmp    $0x64,%ebx
  800799:	7f 0b                	jg     8007a6 <vprintfmt+0x15a>
  80079b:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  8007a2:	85 f6                	test   %esi,%esi
  8007a4:	75 19                	jne    8007bf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007a6:	53                   	push   %ebx
  8007a7:	68 a5 23 80 00       	push   $0x8023a5
  8007ac:	ff 75 0c             	pushl  0xc(%ebp)
  8007af:	ff 75 08             	pushl  0x8(%ebp)
  8007b2:	e8 70 02 00 00       	call   800a27 <printfmt>
  8007b7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007ba:	e9 5b 02 00 00       	jmp    800a1a <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007bf:	56                   	push   %esi
  8007c0:	68 ae 23 80 00       	push   $0x8023ae
  8007c5:	ff 75 0c             	pushl  0xc(%ebp)
  8007c8:	ff 75 08             	pushl  0x8(%ebp)
  8007cb:	e8 57 02 00 00       	call   800a27 <printfmt>
  8007d0:	83 c4 10             	add    $0x10,%esp
			break;
  8007d3:	e9 42 02 00 00       	jmp    800a1a <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007db:	83 c0 04             	add    $0x4,%eax
  8007de:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e4:	83 e8 04             	sub    $0x4,%eax
  8007e7:	8b 30                	mov    (%eax),%esi
  8007e9:	85 f6                	test   %esi,%esi
  8007eb:	75 05                	jne    8007f2 <vprintfmt+0x1a6>
				p = "(null)";
  8007ed:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  8007f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f6:	7e 6d                	jle    800865 <vprintfmt+0x219>
  8007f8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007fc:	74 67                	je     800865 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	50                   	push   %eax
  800805:	56                   	push   %esi
  800806:	e8 26 05 00 00       	call   800d31 <strnlen>
  80080b:	83 c4 10             	add    $0x10,%esp
  80080e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800811:	eb 16                	jmp    800829 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800813:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800817:	83 ec 08             	sub    $0x8,%esp
  80081a:	ff 75 0c             	pushl  0xc(%ebp)
  80081d:	50                   	push   %eax
  80081e:	8b 45 08             	mov    0x8(%ebp),%eax
  800821:	ff d0                	call   *%eax
  800823:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800826:	ff 4d e4             	decl   -0x1c(%ebp)
  800829:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80082d:	7f e4                	jg     800813 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80082f:	eb 34                	jmp    800865 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800831:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800835:	74 1c                	je     800853 <vprintfmt+0x207>
  800837:	83 fb 1f             	cmp    $0x1f,%ebx
  80083a:	7e 05                	jle    800841 <vprintfmt+0x1f5>
  80083c:	83 fb 7e             	cmp    $0x7e,%ebx
  80083f:	7e 12                	jle    800853 <vprintfmt+0x207>
					putch('?', putdat);
  800841:	83 ec 08             	sub    $0x8,%esp
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	6a 3f                	push   $0x3f
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	ff d0                	call   *%eax
  80084e:	83 c4 10             	add    $0x10,%esp
  800851:	eb 0f                	jmp    800862 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800853:	83 ec 08             	sub    $0x8,%esp
  800856:	ff 75 0c             	pushl  0xc(%ebp)
  800859:	53                   	push   %ebx
  80085a:	8b 45 08             	mov    0x8(%ebp),%eax
  80085d:	ff d0                	call   *%eax
  80085f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800862:	ff 4d e4             	decl   -0x1c(%ebp)
  800865:	89 f0                	mov    %esi,%eax
  800867:	8d 70 01             	lea    0x1(%eax),%esi
  80086a:	8a 00                	mov    (%eax),%al
  80086c:	0f be d8             	movsbl %al,%ebx
  80086f:	85 db                	test   %ebx,%ebx
  800871:	74 24                	je     800897 <vprintfmt+0x24b>
  800873:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800877:	78 b8                	js     800831 <vprintfmt+0x1e5>
  800879:	ff 4d e0             	decl   -0x20(%ebp)
  80087c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800880:	79 af                	jns    800831 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800882:	eb 13                	jmp    800897 <vprintfmt+0x24b>
				putch(' ', putdat);
  800884:	83 ec 08             	sub    $0x8,%esp
  800887:	ff 75 0c             	pushl  0xc(%ebp)
  80088a:	6a 20                	push   $0x20
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	ff d0                	call   *%eax
  800891:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800894:	ff 4d e4             	decl   -0x1c(%ebp)
  800897:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089b:	7f e7                	jg     800884 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80089d:	e9 78 01 00 00       	jmp    800a1a <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ab:	50                   	push   %eax
  8008ac:	e8 3c fd ff ff       	call   8005ed <getint>
  8008b1:	83 c4 10             	add    $0x10,%esp
  8008b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c0:	85 d2                	test   %edx,%edx
  8008c2:	79 23                	jns    8008e7 <vprintfmt+0x29b>
				putch('-', putdat);
  8008c4:	83 ec 08             	sub    $0x8,%esp
  8008c7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ca:	6a 2d                	push   $0x2d
  8008cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cf:	ff d0                	call   *%eax
  8008d1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008da:	f7 d8                	neg    %eax
  8008dc:	83 d2 00             	adc    $0x0,%edx
  8008df:	f7 da                	neg    %edx
  8008e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008e7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008ee:	e9 bc 00 00 00       	jmp    8009af <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008f3:	83 ec 08             	sub    $0x8,%esp
  8008f6:	ff 75 e8             	pushl  -0x18(%ebp)
  8008f9:	8d 45 14             	lea    0x14(%ebp),%eax
  8008fc:	50                   	push   %eax
  8008fd:	e8 84 fc ff ff       	call   800586 <getuint>
  800902:	83 c4 10             	add    $0x10,%esp
  800905:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800908:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80090b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800912:	e9 98 00 00 00       	jmp    8009af <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800917:	83 ec 08             	sub    $0x8,%esp
  80091a:	ff 75 0c             	pushl  0xc(%ebp)
  80091d:	6a 58                	push   $0x58
  80091f:	8b 45 08             	mov    0x8(%ebp),%eax
  800922:	ff d0                	call   *%eax
  800924:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	6a 58                	push   $0x58
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	ff d0                	call   *%eax
  800934:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	6a 58                	push   $0x58
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
			break;
  800947:	e9 ce 00 00 00       	jmp    800a1a <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	6a 30                	push   $0x30
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	ff d0                	call   *%eax
  800959:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	6a 78                	push   $0x78
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	ff d0                	call   *%eax
  800969:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 c0 04             	add    $0x4,%eax
  800972:	89 45 14             	mov    %eax,0x14(%ebp)
  800975:	8b 45 14             	mov    0x14(%ebp),%eax
  800978:	83 e8 04             	sub    $0x4,%eax
  80097b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80097d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800980:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800987:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80098e:	eb 1f                	jmp    8009af <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800990:	83 ec 08             	sub    $0x8,%esp
  800993:	ff 75 e8             	pushl  -0x18(%ebp)
  800996:	8d 45 14             	lea    0x14(%ebp),%eax
  800999:	50                   	push   %eax
  80099a:	e8 e7 fb ff ff       	call   800586 <getuint>
  80099f:	83 c4 10             	add    $0x10,%esp
  8009a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009a8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009af:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009b6:	83 ec 04             	sub    $0x4,%esp
  8009b9:	52                   	push   %edx
  8009ba:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009bd:	50                   	push   %eax
  8009be:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c1:	ff 75 f0             	pushl  -0x10(%ebp)
  8009c4:	ff 75 0c             	pushl  0xc(%ebp)
  8009c7:	ff 75 08             	pushl  0x8(%ebp)
  8009ca:	e8 00 fb ff ff       	call   8004cf <printnum>
  8009cf:	83 c4 20             	add    $0x20,%esp
			break;
  8009d2:	eb 46                	jmp    800a1a <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009d4:	83 ec 08             	sub    $0x8,%esp
  8009d7:	ff 75 0c             	pushl  0xc(%ebp)
  8009da:	53                   	push   %ebx
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	ff d0                	call   *%eax
  8009e0:	83 c4 10             	add    $0x10,%esp
			break;
  8009e3:	eb 35                	jmp    800a1a <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009e5:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009ec:	eb 2c                	jmp    800a1a <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009ee:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009f5:	eb 23                	jmp    800a1a <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	6a 25                	push   $0x25
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	ff d0                	call   *%eax
  800a04:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a07:	ff 4d 10             	decl   0x10(%ebp)
  800a0a:	eb 03                	jmp    800a0f <vprintfmt+0x3c3>
  800a0c:	ff 4d 10             	decl   0x10(%ebp)
  800a0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a12:	48                   	dec    %eax
  800a13:	8a 00                	mov    (%eax),%al
  800a15:	3c 25                	cmp    $0x25,%al
  800a17:	75 f3                	jne    800a0c <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a19:	90                   	nop
		}
	}
  800a1a:	e9 35 fc ff ff       	jmp    800654 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a1f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a20:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a23:	5b                   	pop    %ebx
  800a24:	5e                   	pop    %esi
  800a25:	5d                   	pop    %ebp
  800a26:	c3                   	ret    

00800a27 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
  800a2a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a2d:	8d 45 10             	lea    0x10(%ebp),%eax
  800a30:	83 c0 04             	add    $0x4,%eax
  800a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a36:	8b 45 10             	mov    0x10(%ebp),%eax
  800a39:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3c:	50                   	push   %eax
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	ff 75 08             	pushl  0x8(%ebp)
  800a43:	e8 04 fc ff ff       	call   80064c <vprintfmt>
  800a48:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a4b:	90                   	nop
  800a4c:	c9                   	leave  
  800a4d:	c3                   	ret    

00800a4e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a4e:	55                   	push   %ebp
  800a4f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a54:	8b 40 08             	mov    0x8(%eax),%eax
  800a57:	8d 50 01             	lea    0x1(%eax),%edx
  800a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a63:	8b 10                	mov    (%eax),%edx
  800a65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a68:	8b 40 04             	mov    0x4(%eax),%eax
  800a6b:	39 c2                	cmp    %eax,%edx
  800a6d:	73 12                	jae    800a81 <sprintputch+0x33>
		*b->buf++ = ch;
  800a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a72:	8b 00                	mov    (%eax),%eax
  800a74:	8d 48 01             	lea    0x1(%eax),%ecx
  800a77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7a:	89 0a                	mov    %ecx,(%edx)
  800a7c:	8b 55 08             	mov    0x8(%ebp),%edx
  800a7f:	88 10                	mov    %dl,(%eax)
}
  800a81:	90                   	nop
  800a82:	5d                   	pop    %ebp
  800a83:	c3                   	ret    

00800a84 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a84:	55                   	push   %ebp
  800a85:	89 e5                	mov    %esp,%ebp
  800a87:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	01 d0                	add    %edx,%eax
  800a9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800aa5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800aa9:	74 06                	je     800ab1 <vsnprintf+0x2d>
  800aab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aaf:	7f 07                	jg     800ab8 <vsnprintf+0x34>
		return -E_INVAL;
  800ab1:	b8 03 00 00 00       	mov    $0x3,%eax
  800ab6:	eb 20                	jmp    800ad8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ab8:	ff 75 14             	pushl  0x14(%ebp)
  800abb:	ff 75 10             	pushl  0x10(%ebp)
  800abe:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ac1:	50                   	push   %eax
  800ac2:	68 4e 0a 80 00       	push   $0x800a4e
  800ac7:	e8 80 fb ff ff       	call   80064c <vprintfmt>
  800acc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800acf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ad8:	c9                   	leave  
  800ad9:	c3                   	ret    

00800ada <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ada:	55                   	push   %ebp
  800adb:	89 e5                	mov    %esp,%ebp
  800add:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ae0:	8d 45 10             	lea    0x10(%ebp),%eax
  800ae3:	83 c0 04             	add    $0x4,%eax
  800ae6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ae9:	8b 45 10             	mov    0x10(%ebp),%eax
  800aec:	ff 75 f4             	pushl  -0xc(%ebp)
  800aef:	50                   	push   %eax
  800af0:	ff 75 0c             	pushl  0xc(%ebp)
  800af3:	ff 75 08             	pushl  0x8(%ebp)
  800af6:	e8 89 ff ff ff       	call   800a84 <vsnprintf>
  800afb:	83 c4 10             	add    $0x10,%esp
  800afe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b01:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b04:	c9                   	leave  
  800b05:	c3                   	ret    

00800b06 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800b06:	55                   	push   %ebp
  800b07:	89 e5                	mov    %esp,%ebp
  800b09:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  800b0c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b10:	74 13                	je     800b25 <readline+0x1f>
		cprintf("%s", prompt);
  800b12:	83 ec 08             	sub    $0x8,%esp
  800b15:	ff 75 08             	pushl  0x8(%ebp)
  800b18:	68 28 25 80 00       	push   $0x802528
  800b1d:	e8 0b f9 ff ff       	call   80042d <cprintf>
  800b22:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800b25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800b2c:	83 ec 0c             	sub    $0xc,%esp
  800b2f:	6a 00                	push   $0x0
  800b31:	e8 8f 0f 00 00       	call   801ac5 <iscons>
  800b36:	83 c4 10             	add    $0x10,%esp
  800b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800b3c:	e8 6b 0f 00 00       	call   801aac <getchar>
  800b41:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800b44:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b48:	79 22                	jns    800b6c <readline+0x66>
			if (c != -E_EOF)
  800b4a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800b4e:	0f 84 ad 00 00 00    	je     800c01 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 ec             	pushl  -0x14(%ebp)
  800b5a:	68 2b 25 80 00       	push   $0x80252b
  800b5f:	e8 c9 f8 ff ff       	call   80042d <cprintf>
  800b64:	83 c4 10             	add    $0x10,%esp
			break;
  800b67:	e9 95 00 00 00       	jmp    800c01 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800b6c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800b70:	7e 34                	jle    800ba6 <readline+0xa0>
  800b72:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800b79:	7f 2b                	jg     800ba6 <readline+0xa0>
			if (echoing)
  800b7b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b7f:	74 0e                	je     800b8f <readline+0x89>
				cputchar(c);
  800b81:	83 ec 0c             	sub    $0xc,%esp
  800b84:	ff 75 ec             	pushl  -0x14(%ebp)
  800b87:	e8 01 0f 00 00       	call   801a8d <cputchar>
  800b8c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b92:	8d 50 01             	lea    0x1(%eax),%edx
  800b95:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b98:	89 c2                	mov    %eax,%edx
  800b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9d:	01 d0                	add    %edx,%eax
  800b9f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ba2:	88 10                	mov    %dl,(%eax)
  800ba4:	eb 56                	jmp    800bfc <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800ba6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800baa:	75 1f                	jne    800bcb <readline+0xc5>
  800bac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800bb0:	7e 19                	jle    800bcb <readline+0xc5>
			if (echoing)
  800bb2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bb6:	74 0e                	je     800bc6 <readline+0xc0>
				cputchar(c);
  800bb8:	83 ec 0c             	sub    $0xc,%esp
  800bbb:	ff 75 ec             	pushl  -0x14(%ebp)
  800bbe:	e8 ca 0e 00 00       	call   801a8d <cputchar>
  800bc3:	83 c4 10             	add    $0x10,%esp

			i--;
  800bc6:	ff 4d f4             	decl   -0xc(%ebp)
  800bc9:	eb 31                	jmp    800bfc <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800bcb:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800bcf:	74 0a                	je     800bdb <readline+0xd5>
  800bd1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800bd5:	0f 85 61 ff ff ff    	jne    800b3c <readline+0x36>
			if (echoing)
  800bdb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bdf:	74 0e                	je     800bef <readline+0xe9>
				cputchar(c);
  800be1:	83 ec 0c             	sub    $0xc,%esp
  800be4:	ff 75 ec             	pushl  -0x14(%ebp)
  800be7:	e8 a1 0e 00 00       	call   801a8d <cputchar>
  800bec:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800bef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf5:	01 d0                	add    %edx,%eax
  800bf7:	c6 00 00             	movb   $0x0,(%eax)
			break;
  800bfa:	eb 06                	jmp    800c02 <readline+0xfc>
		}
	}
  800bfc:	e9 3b ff ff ff       	jmp    800b3c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  800c01:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  800c02:	90                   	nop
  800c03:	c9                   	leave  
  800c04:	c3                   	ret    

00800c05 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800c05:	55                   	push   %ebp
  800c06:	89 e5                	mov    %esp,%ebp
  800c08:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  800c0b:	e8 79 09 00 00       	call   801589 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  800c10:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c14:	74 13                	je     800c29 <atomic_readline+0x24>
			cprintf("%s", prompt);
  800c16:	83 ec 08             	sub    $0x8,%esp
  800c19:	ff 75 08             	pushl  0x8(%ebp)
  800c1c:	68 28 25 80 00       	push   $0x802528
  800c21:	e8 07 f8 ff ff       	call   80042d <cprintf>
  800c26:	83 c4 10             	add    $0x10,%esp

		i = 0;
  800c29:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  800c30:	83 ec 0c             	sub    $0xc,%esp
  800c33:	6a 00                	push   $0x0
  800c35:	e8 8b 0e 00 00       	call   801ac5 <iscons>
  800c3a:	83 c4 10             	add    $0x10,%esp
  800c3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  800c40:	e8 67 0e 00 00       	call   801aac <getchar>
  800c45:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  800c48:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c4c:	79 22                	jns    800c70 <atomic_readline+0x6b>
				if (c != -E_EOF)
  800c4e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c52:	0f 84 ad 00 00 00    	je     800d05 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  800c58:	83 ec 08             	sub    $0x8,%esp
  800c5b:	ff 75 ec             	pushl  -0x14(%ebp)
  800c5e:	68 2b 25 80 00       	push   $0x80252b
  800c63:	e8 c5 f7 ff ff       	call   80042d <cprintf>
  800c68:	83 c4 10             	add    $0x10,%esp
				break;
  800c6b:	e9 95 00 00 00       	jmp    800d05 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  800c70:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c74:	7e 34                	jle    800caa <atomic_readline+0xa5>
  800c76:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c7d:	7f 2b                	jg     800caa <atomic_readline+0xa5>
				if (echoing)
  800c7f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c83:	74 0e                	je     800c93 <atomic_readline+0x8e>
					cputchar(c);
  800c85:	83 ec 0c             	sub    $0xc,%esp
  800c88:	ff 75 ec             	pushl  -0x14(%ebp)
  800c8b:	e8 fd 0d 00 00       	call   801a8d <cputchar>
  800c90:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  800c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c96:	8d 50 01             	lea    0x1(%eax),%edx
  800c99:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800c9c:	89 c2                	mov    %eax,%edx
  800c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca1:	01 d0                	add    %edx,%eax
  800ca3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ca6:	88 10                	mov    %dl,(%eax)
  800ca8:	eb 56                	jmp    800d00 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  800caa:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800cae:	75 1f                	jne    800ccf <atomic_readline+0xca>
  800cb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800cb4:	7e 19                	jle    800ccf <atomic_readline+0xca>
				if (echoing)
  800cb6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cba:	74 0e                	je     800cca <atomic_readline+0xc5>
					cputchar(c);
  800cbc:	83 ec 0c             	sub    $0xc,%esp
  800cbf:	ff 75 ec             	pushl  -0x14(%ebp)
  800cc2:	e8 c6 0d 00 00       	call   801a8d <cputchar>
  800cc7:	83 c4 10             	add    $0x10,%esp
				i--;
  800cca:	ff 4d f4             	decl   -0xc(%ebp)
  800ccd:	eb 31                	jmp    800d00 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  800ccf:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800cd3:	74 0a                	je     800cdf <atomic_readline+0xda>
  800cd5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800cd9:	0f 85 61 ff ff ff    	jne    800c40 <atomic_readline+0x3b>
				if (echoing)
  800cdf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ce3:	74 0e                	je     800cf3 <atomic_readline+0xee>
					cputchar(c);
  800ce5:	83 ec 0c             	sub    $0xc,%esp
  800ce8:	ff 75 ec             	pushl  -0x14(%ebp)
  800ceb:	e8 9d 0d 00 00       	call   801a8d <cputchar>
  800cf0:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  800cf3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf9:	01 d0                	add    %edx,%eax
  800cfb:	c6 00 00             	movb   $0x0,(%eax)
				break;
  800cfe:	eb 06                	jmp    800d06 <atomic_readline+0x101>
			}
		}
  800d00:	e9 3b ff ff ff       	jmp    800c40 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  800d05:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  800d06:	e8 98 08 00 00       	call   8015a3 <sys_unlock_cons>
}
  800d0b:	90                   	nop
  800d0c:	c9                   	leave  
  800d0d:	c3                   	ret    

00800d0e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1b:	eb 06                	jmp    800d23 <strlen+0x15>
		n++;
  800d1d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 f1                	jne    800d1d <strlen+0xf>
		n++;
	return n;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3e:	eb 09                	jmp    800d49 <strnlen+0x18>
		n++;
  800d40:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d43:	ff 45 08             	incl   0x8(%ebp)
  800d46:	ff 4d 0c             	decl   0xc(%ebp)
  800d49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d4d:	74 09                	je     800d58 <strnlen+0x27>
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	84 c0                	test   %al,%al
  800d56:	75 e8                	jne    800d40 <strnlen+0xf>
		n++;
	return n;
  800d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d69:	90                   	nop
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8d 50 01             	lea    0x1(%eax),%edx
  800d70:	89 55 08             	mov    %edx,0x8(%ebp)
  800d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d79:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7c:	8a 12                	mov    (%edx),%dl
  800d7e:	88 10                	mov    %dl,(%eax)
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	84 c0                	test   %al,%al
  800d84:	75 e4                	jne    800d6a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d89:	c9                   	leave  
  800d8a:	c3                   	ret    

00800d8b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d8b:	55                   	push   %ebp
  800d8c:	89 e5                	mov    %esp,%ebp
  800d8e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d9e:	eb 1f                	jmp    800dbf <strncpy+0x34>
		*dst++ = *src;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8d 50 01             	lea    0x1(%eax),%edx
  800da6:	89 55 08             	mov    %edx,0x8(%ebp)
  800da9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dac:	8a 12                	mov    (%edx),%dl
  800dae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	74 03                	je     800dbc <strncpy+0x31>
			src++;
  800db9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dbc:	ff 45 fc             	incl   -0x4(%ebp)
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc5:	72 d9                	jb     800da0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddc:	74 30                	je     800e0e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dde:	eb 16                	jmp    800df6 <strlcpy+0x2a>
			*dst++ = *src++;
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8d 50 01             	lea    0x1(%eax),%edx
  800de6:	89 55 08             	mov    %edx,0x8(%ebp)
  800de9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800def:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df2:	8a 12                	mov    (%edx),%dl
  800df4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800df6:	ff 4d 10             	decl   0x10(%ebp)
  800df9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfd:	74 09                	je     800e08 <strlcpy+0x3c>
  800dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	84 c0                	test   %al,%al
  800e06:	75 d8                	jne    800de0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e0e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	29 c2                	sub    %eax,%edx
  800e16:	89 d0                	mov    %edx,%eax
}
  800e18:	c9                   	leave  
  800e19:	c3                   	ret    

00800e1a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e1a:	55                   	push   %ebp
  800e1b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e1d:	eb 06                	jmp    800e25 <strcmp+0xb>
		p++, q++;
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	84 c0                	test   %al,%al
  800e2c:	74 0e                	je     800e3c <strcmp+0x22>
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 10                	mov    (%eax),%dl
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	8a 00                	mov    (%eax),%al
  800e38:	38 c2                	cmp    %al,%dl
  800e3a:	74 e3                	je     800e1f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8a 00                	mov    (%eax),%al
  800e41:	0f b6 d0             	movzbl %al,%edx
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	0f b6 c0             	movzbl %al,%eax
  800e4c:	29 c2                	sub    %eax,%edx
  800e4e:	89 d0                	mov    %edx,%eax
}
  800e50:	5d                   	pop    %ebp
  800e51:	c3                   	ret    

00800e52 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e55:	eb 09                	jmp    800e60 <strncmp+0xe>
		n--, p++, q++;
  800e57:	ff 4d 10             	decl   0x10(%ebp)
  800e5a:	ff 45 08             	incl   0x8(%ebp)
  800e5d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e64:	74 17                	je     800e7d <strncmp+0x2b>
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	8a 00                	mov    (%eax),%al
  800e6b:	84 c0                	test   %al,%al
  800e6d:	74 0e                	je     800e7d <strncmp+0x2b>
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8a 10                	mov    (%eax),%dl
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	38 c2                	cmp    %al,%dl
  800e7b:	74 da                	je     800e57 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	75 07                	jne    800e8a <strncmp+0x38>
		return 0;
  800e83:	b8 00 00 00 00       	mov    $0x0,%eax
  800e88:	eb 14                	jmp    800e9e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 d0             	movzbl %al,%edx
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f b6 c0             	movzbl %al,%eax
  800e9a:	29 c2                	sub    %eax,%edx
  800e9c:	89 d0                	mov    %edx,%eax
}
  800e9e:	5d                   	pop    %ebp
  800e9f:	c3                   	ret    

00800ea0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 04             	sub    $0x4,%esp
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eac:	eb 12                	jmp    800ec0 <strchr+0x20>
		if (*s == c)
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb6:	75 05                	jne    800ebd <strchr+0x1d>
			return (char *) s;
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	eb 11                	jmp    800ece <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	84 c0                	test   %al,%al
  800ec7:	75 e5                	jne    800eae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ec9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ece:	c9                   	leave  
  800ecf:	c3                   	ret    

00800ed0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed0:	55                   	push   %ebp
  800ed1:	89 e5                	mov    %esp,%ebp
  800ed3:	83 ec 04             	sub    $0x4,%esp
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800edc:	eb 0d                	jmp    800eeb <strfind+0x1b>
		if (*s == c)
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee6:	74 0e                	je     800ef6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	84 c0                	test   %al,%al
  800ef2:	75 ea                	jne    800ede <strfind+0xe>
  800ef4:	eb 01                	jmp    800ef7 <strfind+0x27>
		if (*s == c)
			break;
  800ef6:	90                   	nop
	return (char *) s;
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f08:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f0c:	76 63                	jbe    800f71 <memset+0x75>
		uint64 data_block = c;
  800f0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f11:	99                   	cltd   
  800f12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f15:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1e:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f22:	c1 e0 08             	shl    $0x8,%eax
  800f25:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f28:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f31:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f35:	c1 e0 10             	shl    $0x10,%eax
  800f38:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f3b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f41:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f44:	89 c2                	mov    %eax,%edx
  800f46:	b8 00 00 00 00       	mov    $0x0,%eax
  800f4b:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f4e:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f51:	eb 18                	jmp    800f6b <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f53:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f56:	8d 41 08             	lea    0x8(%ecx),%eax
  800f59:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f62:	89 01                	mov    %eax,(%ecx)
  800f64:	89 51 04             	mov    %edx,0x4(%ecx)
  800f67:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f6b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f6f:	77 e2                	ja     800f53 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f75:	74 23                	je     800f9a <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f7d:	eb 0e                	jmp    800f8d <memset+0x91>
			*p8++ = (uint8)c;
  800f7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f82:	8d 50 01             	lea    0x1(%eax),%edx
  800f85:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f88:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f8b:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f90:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f93:	89 55 10             	mov    %edx,0x10(%ebp)
  800f96:	85 c0                	test   %eax,%eax
  800f98:	75 e5                	jne    800f7f <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9d:	c9                   	leave  
  800f9e:	c3                   	ret    

00800f9f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f9f:	55                   	push   %ebp
  800fa0:	89 e5                	mov    %esp,%ebp
  800fa2:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800fb1:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fb5:	76 24                	jbe    800fdb <memcpy+0x3c>
		while(n >= 8){
  800fb7:	eb 1c                	jmp    800fd5 <memcpy+0x36>
			*d64 = *s64;
  800fb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fbc:	8b 50 04             	mov    0x4(%eax),%edx
  800fbf:	8b 00                	mov    (%eax),%eax
  800fc1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fc4:	89 01                	mov    %eax,(%ecx)
  800fc6:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800fc9:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800fcd:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800fd1:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800fd5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fd9:	77 de                	ja     800fb9 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800fdb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fdf:	74 31                	je     801012 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800fe1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800fe7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800fed:	eb 16                	jmp    801005 <memcpy+0x66>
			*d8++ = *s8++;
  800fef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff2:	8d 50 01             	lea    0x1(%eax),%edx
  800ff5:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800ff8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ffe:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801001:	8a 12                	mov    (%edx),%dl
  801003:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801005:	8b 45 10             	mov    0x10(%ebp),%eax
  801008:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100b:	89 55 10             	mov    %edx,0x10(%ebp)
  80100e:	85 c0                	test   %eax,%eax
  801010:	75 dd                	jne    800fef <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80101d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801020:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801029:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80102f:	73 50                	jae    801081 <memmove+0x6a>
  801031:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801034:	8b 45 10             	mov    0x10(%ebp),%eax
  801037:	01 d0                	add    %edx,%eax
  801039:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80103c:	76 43                	jbe    801081 <memmove+0x6a>
		s += n;
  80103e:	8b 45 10             	mov    0x10(%ebp),%eax
  801041:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801044:	8b 45 10             	mov    0x10(%ebp),%eax
  801047:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80104a:	eb 10                	jmp    80105c <memmove+0x45>
			*--d = *--s;
  80104c:	ff 4d f8             	decl   -0x8(%ebp)
  80104f:	ff 4d fc             	decl   -0x4(%ebp)
  801052:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801055:	8a 10                	mov    (%eax),%dl
  801057:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80105c:	8b 45 10             	mov    0x10(%ebp),%eax
  80105f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801062:	89 55 10             	mov    %edx,0x10(%ebp)
  801065:	85 c0                	test   %eax,%eax
  801067:	75 e3                	jne    80104c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801069:	eb 23                	jmp    80108e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106e:	8d 50 01             	lea    0x1(%eax),%edx
  801071:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801074:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801077:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80107d:	8a 12                	mov    (%edx),%dl
  80107f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801081:	8b 45 10             	mov    0x10(%ebp),%eax
  801084:	8d 50 ff             	lea    -0x1(%eax),%edx
  801087:	89 55 10             	mov    %edx,0x10(%ebp)
  80108a:	85 c0                	test   %eax,%eax
  80108c:	75 dd                	jne    80106b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80108e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801091:	c9                   	leave  
  801092:	c3                   	ret    

00801093 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801093:	55                   	push   %ebp
  801094:	89 e5                	mov    %esp,%ebp
  801096:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80109f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010a5:	eb 2a                	jmp    8010d1 <memcmp+0x3e>
		if (*s1 != *s2)
  8010a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010aa:	8a 10                	mov    (%eax),%dl
  8010ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	38 c2                	cmp    %al,%dl
  8010b3:	74 16                	je     8010cb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b8:	8a 00                	mov    (%eax),%al
  8010ba:	0f b6 d0             	movzbl %al,%edx
  8010bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	0f b6 c0             	movzbl %al,%eax
  8010c5:	29 c2                	sub    %eax,%edx
  8010c7:	89 d0                	mov    %edx,%eax
  8010c9:	eb 18                	jmp    8010e3 <memcmp+0x50>
		s1++, s2++;
  8010cb:	ff 45 fc             	incl   -0x4(%ebp)
  8010ce:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d7:	89 55 10             	mov    %edx,0x10(%ebp)
  8010da:	85 c0                	test   %eax,%eax
  8010dc:	75 c9                	jne    8010a7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010e3:	c9                   	leave  
  8010e4:	c3                   	ret    

008010e5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010e5:	55                   	push   %ebp
  8010e6:	89 e5                	mov    %esp,%ebp
  8010e8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f1:	01 d0                	add    %edx,%eax
  8010f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010f6:	eb 15                	jmp    80110d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	0f b6 d0             	movzbl %al,%edx
  801100:	8b 45 0c             	mov    0xc(%ebp),%eax
  801103:	0f b6 c0             	movzbl %al,%eax
  801106:	39 c2                	cmp    %eax,%edx
  801108:	74 0d                	je     801117 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80110a:	ff 45 08             	incl   0x8(%ebp)
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801113:	72 e3                	jb     8010f8 <memfind+0x13>
  801115:	eb 01                	jmp    801118 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801117:	90                   	nop
	return (void *) s;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801123:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80112a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801131:	eb 03                	jmp    801136 <strtol+0x19>
		s++;
  801133:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	3c 20                	cmp    $0x20,%al
  80113d:	74 f4                	je     801133 <strtol+0x16>
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	3c 09                	cmp    $0x9,%al
  801146:	74 eb                	je     801133 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 2b                	cmp    $0x2b,%al
  80114f:	75 05                	jne    801156 <strtol+0x39>
		s++;
  801151:	ff 45 08             	incl   0x8(%ebp)
  801154:	eb 13                	jmp    801169 <strtol+0x4c>
	else if (*s == '-')
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8a 00                	mov    (%eax),%al
  80115b:	3c 2d                	cmp    $0x2d,%al
  80115d:	75 0a                	jne    801169 <strtol+0x4c>
		s++, neg = 1;
  80115f:	ff 45 08             	incl   0x8(%ebp)
  801162:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801169:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80116d:	74 06                	je     801175 <strtol+0x58>
  80116f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801173:	75 20                	jne    801195 <strtol+0x78>
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	3c 30                	cmp    $0x30,%al
  80117c:	75 17                	jne    801195 <strtol+0x78>
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	40                   	inc    %eax
  801182:	8a 00                	mov    (%eax),%al
  801184:	3c 78                	cmp    $0x78,%al
  801186:	75 0d                	jne    801195 <strtol+0x78>
		s += 2, base = 16;
  801188:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80118c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801193:	eb 28                	jmp    8011bd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801195:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801199:	75 15                	jne    8011b0 <strtol+0x93>
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	3c 30                	cmp    $0x30,%al
  8011a2:	75 0c                	jne    8011b0 <strtol+0x93>
		s++, base = 8;
  8011a4:	ff 45 08             	incl   0x8(%ebp)
  8011a7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011ae:	eb 0d                	jmp    8011bd <strtol+0xa0>
	else if (base == 0)
  8011b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b4:	75 07                	jne    8011bd <strtol+0xa0>
		base = 10;
  8011b6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	3c 2f                	cmp    $0x2f,%al
  8011c4:	7e 19                	jle    8011df <strtol+0xc2>
  8011c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	3c 39                	cmp    $0x39,%al
  8011cd:	7f 10                	jg     8011df <strtol+0xc2>
			dig = *s - '0';
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	0f be c0             	movsbl %al,%eax
  8011d7:	83 e8 30             	sub    $0x30,%eax
  8011da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011dd:	eb 42                	jmp    801221 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	3c 60                	cmp    $0x60,%al
  8011e6:	7e 19                	jle    801201 <strtol+0xe4>
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8a 00                	mov    (%eax),%al
  8011ed:	3c 7a                	cmp    $0x7a,%al
  8011ef:	7f 10                	jg     801201 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	0f be c0             	movsbl %al,%eax
  8011f9:	83 e8 57             	sub    $0x57,%eax
  8011fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ff:	eb 20                	jmp    801221 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	3c 40                	cmp    $0x40,%al
  801208:	7e 39                	jle    801243 <strtol+0x126>
  80120a:	8b 45 08             	mov    0x8(%ebp),%eax
  80120d:	8a 00                	mov    (%eax),%al
  80120f:	3c 5a                	cmp    $0x5a,%al
  801211:	7f 30                	jg     801243 <strtol+0x126>
			dig = *s - 'A' + 10;
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	0f be c0             	movsbl %al,%eax
  80121b:	83 e8 37             	sub    $0x37,%eax
  80121e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801221:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801224:	3b 45 10             	cmp    0x10(%ebp),%eax
  801227:	7d 19                	jge    801242 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801229:	ff 45 08             	incl   0x8(%ebp)
  80122c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801233:	89 c2                	mov    %eax,%edx
  801235:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801238:	01 d0                	add    %edx,%eax
  80123a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80123d:	e9 7b ff ff ff       	jmp    8011bd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801242:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801243:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801247:	74 08                	je     801251 <strtol+0x134>
		*endptr = (char *) s;
  801249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124c:	8b 55 08             	mov    0x8(%ebp),%edx
  80124f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801251:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801255:	74 07                	je     80125e <strtol+0x141>
  801257:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125a:	f7 d8                	neg    %eax
  80125c:	eb 03                	jmp    801261 <strtol+0x144>
  80125e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801261:	c9                   	leave  
  801262:	c3                   	ret    

00801263 <ltostr>:

void
ltostr(long value, char *str)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
  801266:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801269:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801270:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801277:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80127b:	79 13                	jns    801290 <ltostr+0x2d>
	{
		neg = 1;
  80127d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801284:	8b 45 0c             	mov    0xc(%ebp),%eax
  801287:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80128a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80128d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801298:	99                   	cltd   
  801299:	f7 f9                	idiv   %ecx
  80129b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80129e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a1:	8d 50 01             	lea    0x1(%eax),%edx
  8012a4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012a7:	89 c2                	mov    %eax,%edx
  8012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ac:	01 d0                	add    %edx,%eax
  8012ae:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b1:	83 c2 30             	add    $0x30,%edx
  8012b4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012b9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012be:	f7 e9                	imul   %ecx
  8012c0:	c1 fa 02             	sar    $0x2,%edx
  8012c3:	89 c8                	mov    %ecx,%eax
  8012c5:	c1 f8 1f             	sar    $0x1f,%eax
  8012c8:	29 c2                	sub    %eax,%edx
  8012ca:	89 d0                	mov    %edx,%eax
  8012cc:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012d3:	75 bb                	jne    801290 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012df:	48                   	dec    %eax
  8012e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012e3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012e7:	74 3d                	je     801326 <ltostr+0xc3>
		start = 1 ;
  8012e9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012f0:	eb 34                	jmp    801326 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f8:	01 d0                	add    %edx,%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801302:	8b 45 0c             	mov    0xc(%ebp),%eax
  801305:	01 c2                	add    %eax,%edx
  801307:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80130a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130d:	01 c8                	add    %ecx,%eax
  80130f:	8a 00                	mov    (%eax),%al
  801311:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801313:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801316:	8b 45 0c             	mov    0xc(%ebp),%eax
  801319:	01 c2                	add    %eax,%edx
  80131b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80131e:	88 02                	mov    %al,(%edx)
		start++ ;
  801320:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801323:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801326:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801329:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80132c:	7c c4                	jl     8012f2 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80132e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801331:	8b 45 0c             	mov    0xc(%ebp),%eax
  801334:	01 d0                	add    %edx,%eax
  801336:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801339:	90                   	nop
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
  80133f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801342:	ff 75 08             	pushl  0x8(%ebp)
  801345:	e8 c4 f9 ff ff       	call   800d0e <strlen>
  80134a:	83 c4 04             	add    $0x4,%esp
  80134d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801350:	ff 75 0c             	pushl  0xc(%ebp)
  801353:	e8 b6 f9 ff ff       	call   800d0e <strlen>
  801358:	83 c4 04             	add    $0x4,%esp
  80135b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80135e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136c:	eb 17                	jmp    801385 <strcconcat+0x49>
		final[s] = str1[s] ;
  80136e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801371:	8b 45 10             	mov    0x10(%ebp),%eax
  801374:	01 c2                	add    %eax,%edx
  801376:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	01 c8                	add    %ecx,%eax
  80137e:	8a 00                	mov    (%eax),%al
  801380:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801382:	ff 45 fc             	incl   -0x4(%ebp)
  801385:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801388:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80138b:	7c e1                	jl     80136e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80138d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801394:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80139b:	eb 1f                	jmp    8013bc <strcconcat+0x80>
		final[s++] = str2[i] ;
  80139d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a0:	8d 50 01             	lea    0x1(%eax),%edx
  8013a3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013a6:	89 c2                	mov    %eax,%edx
  8013a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ab:	01 c2                	add    %eax,%edx
  8013ad:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b3:	01 c8                	add    %ecx,%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013b9:	ff 45 f8             	incl   -0x8(%ebp)
  8013bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013c2:	7c d9                	jl     80139d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ca:	01 d0                	add    %edx,%eax
  8013cc:	c6 00 00             	movb   $0x0,(%eax)
}
  8013cf:	90                   	nop
  8013d0:	c9                   	leave  
  8013d1:	c3                   	ret    

008013d2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013de:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e1:	8b 00                	mov    (%eax),%eax
  8013e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ed:	01 d0                	add    %edx,%eax
  8013ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013f5:	eb 0c                	jmp    801403 <strsplit+0x31>
			*string++ = 0;
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8d 50 01             	lea    0x1(%eax),%edx
  8013fd:	89 55 08             	mov    %edx,0x8(%ebp)
  801400:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	84 c0                	test   %al,%al
  80140a:	74 18                	je     801424 <strsplit+0x52>
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	0f be c0             	movsbl %al,%eax
  801414:	50                   	push   %eax
  801415:	ff 75 0c             	pushl  0xc(%ebp)
  801418:	e8 83 fa ff ff       	call   800ea0 <strchr>
  80141d:	83 c4 08             	add    $0x8,%esp
  801420:	85 c0                	test   %eax,%eax
  801422:	75 d3                	jne    8013f7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	84 c0                	test   %al,%al
  80142b:	74 5a                	je     801487 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80142d:	8b 45 14             	mov    0x14(%ebp),%eax
  801430:	8b 00                	mov    (%eax),%eax
  801432:	83 f8 0f             	cmp    $0xf,%eax
  801435:	75 07                	jne    80143e <strsplit+0x6c>
		{
			return 0;
  801437:	b8 00 00 00 00       	mov    $0x0,%eax
  80143c:	eb 66                	jmp    8014a4 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80143e:	8b 45 14             	mov    0x14(%ebp),%eax
  801441:	8b 00                	mov    (%eax),%eax
  801443:	8d 48 01             	lea    0x1(%eax),%ecx
  801446:	8b 55 14             	mov    0x14(%ebp),%edx
  801449:	89 0a                	mov    %ecx,(%edx)
  80144b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801452:	8b 45 10             	mov    0x10(%ebp),%eax
  801455:	01 c2                	add    %eax,%edx
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
  80145a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80145c:	eb 03                	jmp    801461 <strsplit+0x8f>
			string++;
  80145e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	84 c0                	test   %al,%al
  801468:	74 8b                	je     8013f5 <strsplit+0x23>
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	0f be c0             	movsbl %al,%eax
  801472:	50                   	push   %eax
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	e8 25 fa ff ff       	call   800ea0 <strchr>
  80147b:	83 c4 08             	add    $0x8,%esp
  80147e:	85 c0                	test   %eax,%eax
  801480:	74 dc                	je     80145e <strsplit+0x8c>
			string++;
	}
  801482:	e9 6e ff ff ff       	jmp    8013f5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801487:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801488:	8b 45 14             	mov    0x14(%ebp),%eax
  80148b:	8b 00                	mov    (%eax),%eax
  80148d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801494:	8b 45 10             	mov    0x10(%ebp),%eax
  801497:	01 d0                	add    %edx,%eax
  801499:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80149f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
  8014a9:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8014b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014b9:	eb 4a                	jmp    801505 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	01 c2                	add    %eax,%edx
  8014c3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c9:	01 c8                	add    %ecx,%eax
  8014cb:	8a 00                	mov    (%eax),%al
  8014cd:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d5:	01 d0                	add    %edx,%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	3c 40                	cmp    $0x40,%al
  8014db:	7e 25                	jle    801502 <str2lower+0x5c>
  8014dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e3:	01 d0                	add    %edx,%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	3c 5a                	cmp    $0x5a,%al
  8014e9:	7f 17                	jg     801502 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8014eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	01 d0                	add    %edx,%eax
  8014f3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014f6:	8b 55 08             	mov    0x8(%ebp),%edx
  8014f9:	01 ca                	add    %ecx,%edx
  8014fb:	8a 12                	mov    (%edx),%dl
  8014fd:	83 c2 20             	add    $0x20,%edx
  801500:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801502:	ff 45 fc             	incl   -0x4(%ebp)
  801505:	ff 75 0c             	pushl  0xc(%ebp)
  801508:	e8 01 f8 ff ff       	call   800d0e <strlen>
  80150d:	83 c4 04             	add    $0x4,%esp
  801510:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801513:	7f a6                	jg     8014bb <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801515:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
  80151d:	57                   	push   %edi
  80151e:	56                   	push   %esi
  80151f:	53                   	push   %ebx
  801520:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	8b 55 0c             	mov    0xc(%ebp),%edx
  801529:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80152c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80152f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801532:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801535:	cd 30                	int    $0x30
  801537:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80153a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80153d:	83 c4 10             	add    $0x10,%esp
  801540:	5b                   	pop    %ebx
  801541:	5e                   	pop    %esi
  801542:	5f                   	pop    %edi
  801543:	5d                   	pop    %ebp
  801544:	c3                   	ret    

00801545 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
  801548:	83 ec 04             	sub    $0x4,%esp
  80154b:	8b 45 10             	mov    0x10(%ebp),%eax
  80154e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801551:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801554:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	6a 00                	push   $0x0
  80155d:	51                   	push   %ecx
  80155e:	52                   	push   %edx
  80155f:	ff 75 0c             	pushl  0xc(%ebp)
  801562:	50                   	push   %eax
  801563:	6a 00                	push   $0x0
  801565:	e8 b0 ff ff ff       	call   80151a <syscall>
  80156a:	83 c4 18             	add    $0x18,%esp
}
  80156d:	90                   	nop
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_cgetc>:

int
sys_cgetc(void)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 02                	push   $0x2
  80157f:	e8 96 ff ff ff       	call   80151a <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 03                	push   $0x3
  801598:	e8 7d ff ff ff       	call   80151a <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
}
  8015a0:	90                   	nop
  8015a1:	c9                   	leave  
  8015a2:	c3                   	ret    

008015a3 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 04                	push   $0x4
  8015b2:	e8 63 ff ff ff       	call   80151a <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
}
  8015ba:	90                   	nop
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	52                   	push   %edx
  8015cd:	50                   	push   %eax
  8015ce:	6a 08                	push   $0x8
  8015d0:	e8 45 ff ff ff       	call   80151a <syscall>
  8015d5:	83 c4 18             	add    $0x18,%esp
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	56                   	push   %esi
  8015de:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015df:	8b 75 18             	mov    0x18(%ebp),%esi
  8015e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	56                   	push   %esi
  8015ef:	53                   	push   %ebx
  8015f0:	51                   	push   %ecx
  8015f1:	52                   	push   %edx
  8015f2:	50                   	push   %eax
  8015f3:	6a 09                	push   $0x9
  8015f5:	e8 20 ff ff ff       	call   80151a <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
}
  8015fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801600:	5b                   	pop    %ebx
  801601:	5e                   	pop    %esi
  801602:	5d                   	pop    %ebp
  801603:	c3                   	ret    

00801604 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801604:	55                   	push   %ebp
  801605:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	ff 75 08             	pushl  0x8(%ebp)
  801612:	6a 0a                	push   $0xa
  801614:	e8 01 ff ff ff       	call   80151a <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	ff 75 0c             	pushl  0xc(%ebp)
  80162a:	ff 75 08             	pushl  0x8(%ebp)
  80162d:	6a 0b                	push   $0xb
  80162f:	e8 e6 fe ff ff       	call   80151a <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 0c                	push   $0xc
  801648:	e8 cd fe ff ff       	call   80151a <syscall>
  80164d:	83 c4 18             	add    $0x18,%esp
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 0d                	push   $0xd
  801661:	e8 b4 fe ff ff       	call   80151a <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 0e                	push   $0xe
  80167a:	e8 9b fe ff ff       	call   80151a <syscall>
  80167f:	83 c4 18             	add    $0x18,%esp
}
  801682:	c9                   	leave  
  801683:	c3                   	ret    

00801684 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801684:	55                   	push   %ebp
  801685:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 0f                	push   $0xf
  801693:	e8 82 fe ff ff       	call   80151a <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	ff 75 08             	pushl  0x8(%ebp)
  8016ab:	6a 10                	push   $0x10
  8016ad:	e8 68 fe ff ff       	call   80151a <syscall>
  8016b2:	83 c4 18             	add    $0x18,%esp
}
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 11                	push   $0x11
  8016c6:	e8 4f fe ff ff       	call   80151a <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	90                   	nop
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    

008016d1 <sys_cputc>:

void
sys_cputc(const char c)
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
  8016d4:	83 ec 04             	sub    $0x4,%esp
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016dd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	50                   	push   %eax
  8016ea:	6a 01                	push   $0x1
  8016ec:	e8 29 fe ff ff       	call   80151a <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	90                   	nop
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 14                	push   $0x14
  801706:	e8 0f fe ff ff       	call   80151a <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	90                   	nop
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
  801714:	83 ec 04             	sub    $0x4,%esp
  801717:	8b 45 10             	mov    0x10(%ebp),%eax
  80171a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80171d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801720:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	6a 00                	push   $0x0
  801729:	51                   	push   %ecx
  80172a:	52                   	push   %edx
  80172b:	ff 75 0c             	pushl  0xc(%ebp)
  80172e:	50                   	push   %eax
  80172f:	6a 15                	push   $0x15
  801731:	e8 e4 fd ff ff       	call   80151a <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80173e:	8b 55 10             	mov    0x10(%ebp),%edx
  801741:	8b 45 0c             	mov    0xc(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	52                   	push   %edx
  801749:	50                   	push   %eax
  80174a:	ff 75 08             	pushl  0x8(%ebp)
  80174d:	6a 16                	push   $0x16
  80174f:	e8 c6 fd ff ff       	call   80151a <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80175c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	52                   	push   %edx
  801769:	50                   	push   %eax
  80176a:	6a 17                	push   $0x17
  80176c:	e8 a9 fd ff ff       	call   80151a <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801779:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	52                   	push   %edx
  801786:	50                   	push   %eax
  801787:	6a 18                	push   $0x18
  801789:	e8 8c fd ff ff       	call   80151a <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	6a 00                	push   $0x0
  80179b:	ff 75 14             	pushl  0x14(%ebp)
  80179e:	ff 75 10             	pushl  0x10(%ebp)
  8017a1:	ff 75 0c             	pushl  0xc(%ebp)
  8017a4:	50                   	push   %eax
  8017a5:	6a 19                	push   $0x19
  8017a7:	e8 6e fd ff ff       	call   80151a <syscall>
  8017ac:	83 c4 18             	add    $0x18,%esp
}
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	50                   	push   %eax
  8017c0:	6a 1a                	push   $0x1a
  8017c2:	e8 53 fd ff ff       	call   80151a <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	90                   	nop
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	50                   	push   %eax
  8017dc:	6a 1b                	push   $0x1b
  8017de:	e8 37 fd ff ff       	call   80151a <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 05                	push   $0x5
  8017f7:	e8 1e fd ff ff       	call   80151a <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 06                	push   $0x6
  801810:	e8 05 fd ff ff       	call   80151a <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 07                	push   $0x7
  801829:	e8 ec fc ff ff       	call   80151a <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_exit_env>:


void sys_exit_env(void)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 1c                	push   $0x1c
  801842:	e8 d3 fc ff ff       	call   80151a <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	90                   	nop
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	ff 75 10             	pushl  0x10(%ebp)
  801857:	ff 75 0c             	pushl  0xc(%ebp)
  80185a:	ff 75 08             	pushl  0x8(%ebp)
  80185d:	6a 13                	push   $0x13
  80185f:	e8 b6 fc ff ff       	call   80151a <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
	return ;
  801867:	90                   	nop
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_rcr2>:
uint32 sys_rcr2()
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 1e                	push   $0x1e
  801879:	e8 9c fc ff ff       	call   80151a <syscall>
  80187e:	83 c4 18             	add    $0x18,%esp
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
  801886:	83 ec 04             	sub    $0x4,%esp
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80188f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	50                   	push   %eax
  80189c:	6a 1f                	push   $0x1f
  80189e:	e8 77 fc ff ff       	call   80151a <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a6:	90                   	nop
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <rsttst>:
void rsttst()
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 21                	push   $0x21
  8018b8:	e8 5d fc ff ff       	call   80151a <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c0:	90                   	nop
}
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
  8018c6:	83 ec 04             	sub    $0x4,%esp
  8018c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018cf:	8b 55 18             	mov    0x18(%ebp),%edx
  8018d2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018d6:	52                   	push   %edx
  8018d7:	50                   	push   %eax
  8018d8:	ff 75 10             	pushl  0x10(%ebp)
  8018db:	ff 75 0c             	pushl  0xc(%ebp)
  8018de:	ff 75 08             	pushl  0x8(%ebp)
  8018e1:	6a 20                	push   $0x20
  8018e3:	e8 32 fc ff ff       	call   80151a <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8018eb:	90                   	nop
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <chktst>:
void chktst(uint32 n)
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	ff 75 08             	pushl  0x8(%ebp)
  8018fc:	6a 22                	push   $0x22
  8018fe:	e8 17 fc ff ff       	call   80151a <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
	return ;
  801906:	90                   	nop
}
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <inctst>:

void inctst()
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 23                	push   $0x23
  801918:	e8 fd fb ff ff       	call   80151a <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
	return ;
  801920:	90                   	nop
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <gettst>:
uint32 gettst()
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 24                	push   $0x24
  801932:	e8 e3 fb ff ff       	call   80151a <syscall>
  801937:	83 c4 18             	add    $0x18,%esp
}
  80193a:	c9                   	leave  
  80193b:	c3                   	ret    

0080193c <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80193c:	55                   	push   %ebp
  80193d:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 25                	push   $0x25
  80194b:	e8 ca fb ff ff       	call   80151a <syscall>
  801950:	83 c4 18             	add    $0x18,%esp
  801953:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801958:	a1 48 30 80 00       	mov    0x803048,%eax
}
  80195d:	c9                   	leave  
  80195e:	c3                   	ret    

0080195f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80195f:	55                   	push   %ebp
  801960:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	ff 75 08             	pushl  0x8(%ebp)
  801975:	6a 26                	push   $0x26
  801977:	e8 9e fb ff ff       	call   80151a <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
	return ;
  80197f:	90                   	nop
}
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
  801985:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801986:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801989:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80198c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	6a 00                	push   $0x0
  801994:	53                   	push   %ebx
  801995:	51                   	push   %ecx
  801996:	52                   	push   %edx
  801997:	50                   	push   %eax
  801998:	6a 27                	push   $0x27
  80199a:	e8 7b fb ff ff       	call   80151a <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	52                   	push   %edx
  8019b7:	50                   	push   %eax
  8019b8:	6a 28                	push   $0x28
  8019ba:	e8 5b fb ff ff       	call   80151a <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
}
  8019c2:	c9                   	leave  
  8019c3:	c3                   	ret    

008019c4 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8019c4:	55                   	push   %ebp
  8019c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8019c7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	6a 00                	push   $0x0
  8019d2:	51                   	push   %ecx
  8019d3:	ff 75 10             	pushl  0x10(%ebp)
  8019d6:	52                   	push   %edx
  8019d7:	50                   	push   %eax
  8019d8:	6a 29                	push   $0x29
  8019da:	e8 3b fb ff ff       	call   80151a <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	ff 75 10             	pushl  0x10(%ebp)
  8019ee:	ff 75 0c             	pushl  0xc(%ebp)
  8019f1:	ff 75 08             	pushl  0x8(%ebp)
  8019f4:	6a 12                	push   $0x12
  8019f6:	e8 1f fb ff ff       	call   80151a <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
	return ;
  8019fe:	90                   	nop
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801a04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	52                   	push   %edx
  801a11:	50                   	push   %eax
  801a12:	6a 2a                	push   $0x2a
  801a14:	e8 01 fb ff ff       	call   80151a <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
	return;
  801a1c:	90                   	nop
}
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 2b                	push   $0x2b
  801a2e:	e8 e7 fa ff ff       	call   80151a <syscall>
  801a33:	83 c4 18             	add    $0x18,%esp
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801a3e:	83 ec 04             	sub    $0x4,%esp
  801a41:	68 3b 25 80 00       	push   $0x80253b
  801a46:	68 0a 01 00 00       	push   $0x10a
  801a4b:	68 4b 25 80 00       	push   $0x80254b
  801a50:	e8 7a 00 00 00       	call   801acf <_panic>

00801a55 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	ff 75 0c             	pushl  0xc(%ebp)
  801a61:	ff 75 08             	pushl  0x8(%ebp)
  801a64:	6a 33                	push   $0x33
  801a66:	e8 af fa ff ff       	call   80151a <syscall>
  801a6b:	83 c4 18             	add    $0x18,%esp
	return;
  801a6e:	90                   	nop
}
  801a6f:	c9                   	leave  
  801a70:	c3                   	ret    

00801a71 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a71:	55                   	push   %ebp
  801a72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	ff 75 0c             	pushl  0xc(%ebp)
  801a7d:	ff 75 08             	pushl  0x8(%ebp)
  801a80:	6a 34                	push   $0x34
  801a82:	e8 93 fa ff ff       	call   80151a <syscall>
  801a87:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8a:	90                   	nop
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
  801a90:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801a99:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801a9d:	83 ec 0c             	sub    $0xc,%esp
  801aa0:	50                   	push   %eax
  801aa1:	e8 2b fc ff ff       	call   8016d1 <sys_cputc>
  801aa6:	83 c4 10             	add    $0x10,%esp
}
  801aa9:	90                   	nop
  801aaa:	c9                   	leave  
  801aab:	c3                   	ret    

00801aac <getchar>:


int
getchar(void)
{
  801aac:	55                   	push   %ebp
  801aad:	89 e5                	mov    %esp,%ebp
  801aaf:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  801ab2:	e8 b9 fa ff ff       	call   801570 <sys_cgetc>
  801ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801aba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801abe:	74 f2                	je     801ab2 <getchar+0x6>
	return c;
  801ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801ac3:	c9                   	leave  
  801ac4:	c3                   	ret    

00801ac5 <iscons>:

int iscons(int fdnum)
{
  801ac5:	55                   	push   %ebp
  801ac6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801ac8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801acd:	5d                   	pop    %ebp
  801ace:	c3                   	ret    

00801acf <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
  801ad2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801ad5:	8d 45 10             	lea    0x10(%ebp),%eax
  801ad8:	83 c0 04             	add    $0x4,%eax
  801adb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801ade:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801ae3:	85 c0                	test   %eax,%eax
  801ae5:	74 16                	je     801afd <_panic+0x2e>
		cprintf("%s: ", argv0);
  801ae7:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801aec:	83 ec 08             	sub    $0x8,%esp
  801aef:	50                   	push   %eax
  801af0:	68 5c 25 80 00       	push   $0x80255c
  801af5:	e8 33 e9 ff ff       	call   80042d <cprintf>
  801afa:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801afd:	a1 04 30 80 00       	mov    0x803004,%eax
  801b02:	83 ec 0c             	sub    $0xc,%esp
  801b05:	ff 75 0c             	pushl  0xc(%ebp)
  801b08:	ff 75 08             	pushl  0x8(%ebp)
  801b0b:	50                   	push   %eax
  801b0c:	68 64 25 80 00       	push   $0x802564
  801b11:	6a 74                	push   $0x74
  801b13:	e8 42 e9 ff ff       	call   80045a <cprintf_colored>
  801b18:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801b1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801b1e:	83 ec 08             	sub    $0x8,%esp
  801b21:	ff 75 f4             	pushl  -0xc(%ebp)
  801b24:	50                   	push   %eax
  801b25:	e8 94 e8 ff ff       	call   8003be <vcprintf>
  801b2a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b2d:	83 ec 08             	sub    $0x8,%esp
  801b30:	6a 00                	push   $0x0
  801b32:	68 8c 25 80 00       	push   $0x80258c
  801b37:	e8 82 e8 ff ff       	call   8003be <vcprintf>
  801b3c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b3f:	e8 fb e7 ff ff       	call   80033f <exit>

	// should not return here
	while (1) ;
  801b44:	eb fe                	jmp    801b44 <_panic+0x75>

00801b46 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
  801b49:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b4c:	a1 20 30 80 00       	mov    0x803020,%eax
  801b51:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801b57:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b5a:	39 c2                	cmp    %eax,%edx
  801b5c:	74 14                	je     801b72 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b5e:	83 ec 04             	sub    $0x4,%esp
  801b61:	68 90 25 80 00       	push   $0x802590
  801b66:	6a 26                	push   $0x26
  801b68:	68 dc 25 80 00       	push   $0x8025dc
  801b6d:	e8 5d ff ff ff       	call   801acf <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b79:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b80:	e9 c5 00 00 00       	jmp    801c4a <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	01 d0                	add    %edx,%eax
  801b94:	8b 00                	mov    (%eax),%eax
  801b96:	85 c0                	test   %eax,%eax
  801b98:	75 08                	jne    801ba2 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801b9a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b9d:	e9 a5 00 00 00       	jmp    801c47 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801ba2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ba9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801bb0:	eb 69                	jmp    801c1b <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801bb2:	a1 20 30 80 00       	mov    0x803020,%eax
  801bb7:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bbd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bc0:	89 d0                	mov    %edx,%eax
  801bc2:	01 c0                	add    %eax,%eax
  801bc4:	01 d0                	add    %edx,%eax
  801bc6:	c1 e0 03             	shl    $0x3,%eax
  801bc9:	01 c8                	add    %ecx,%eax
  801bcb:	8a 40 04             	mov    0x4(%eax),%al
  801bce:	84 c0                	test   %al,%al
  801bd0:	75 46                	jne    801c18 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801bd2:	a1 20 30 80 00       	mov    0x803020,%eax
  801bd7:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bdd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801be0:	89 d0                	mov    %edx,%eax
  801be2:	01 c0                	add    %eax,%eax
  801be4:	01 d0                	add    %edx,%eax
  801be6:	c1 e0 03             	shl    $0x3,%eax
  801be9:	01 c8                	add    %ecx,%eax
  801beb:	8b 00                	mov    (%eax),%eax
  801bed:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bf0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bf3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801bf8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bfd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c04:	8b 45 08             	mov    0x8(%ebp),%eax
  801c07:	01 c8                	add    %ecx,%eax
  801c09:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c0b:	39 c2                	cmp    %eax,%edx
  801c0d:	75 09                	jne    801c18 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801c0f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c16:	eb 15                	jmp    801c2d <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c18:	ff 45 e8             	incl   -0x18(%ebp)
  801c1b:	a1 20 30 80 00       	mov    0x803020,%eax
  801c20:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c26:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c29:	39 c2                	cmp    %eax,%edx
  801c2b:	77 85                	ja     801bb2 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c2d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c31:	75 14                	jne    801c47 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801c33:	83 ec 04             	sub    $0x4,%esp
  801c36:	68 e8 25 80 00       	push   $0x8025e8
  801c3b:	6a 3a                	push   $0x3a
  801c3d:	68 dc 25 80 00       	push   $0x8025dc
  801c42:	e8 88 fe ff ff       	call   801acf <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c47:	ff 45 f0             	incl   -0x10(%ebp)
  801c4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c50:	0f 8c 2f ff ff ff    	jl     801b85 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c56:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c5d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c64:	eb 26                	jmp    801c8c <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c66:	a1 20 30 80 00       	mov    0x803020,%eax
  801c6b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c71:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c74:	89 d0                	mov    %edx,%eax
  801c76:	01 c0                	add    %eax,%eax
  801c78:	01 d0                	add    %edx,%eax
  801c7a:	c1 e0 03             	shl    $0x3,%eax
  801c7d:	01 c8                	add    %ecx,%eax
  801c7f:	8a 40 04             	mov    0x4(%eax),%al
  801c82:	3c 01                	cmp    $0x1,%al
  801c84:	75 03                	jne    801c89 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801c86:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c89:	ff 45 e0             	incl   -0x20(%ebp)
  801c8c:	a1 20 30 80 00       	mov    0x803020,%eax
  801c91:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c9a:	39 c2                	cmp    %eax,%edx
  801c9c:	77 c8                	ja     801c66 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801c9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ca1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ca4:	74 14                	je     801cba <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801ca6:	83 ec 04             	sub    $0x4,%esp
  801ca9:	68 3c 26 80 00       	push   $0x80263c
  801cae:	6a 44                	push   $0x44
  801cb0:	68 dc 25 80 00       	push   $0x8025dc
  801cb5:	e8 15 fe ff ff       	call   801acf <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801cba:	90                   	nop
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    
  801cbd:	66 90                	xchg   %ax,%ax
  801cbf:	90                   	nop

00801cc0 <__udivdi3>:
  801cc0:	55                   	push   %ebp
  801cc1:	57                   	push   %edi
  801cc2:	56                   	push   %esi
  801cc3:	53                   	push   %ebx
  801cc4:	83 ec 1c             	sub    $0x1c,%esp
  801cc7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ccb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ccf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cd3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cd7:	89 ca                	mov    %ecx,%edx
  801cd9:	89 f8                	mov    %edi,%eax
  801cdb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cdf:	85 f6                	test   %esi,%esi
  801ce1:	75 2d                	jne    801d10 <__udivdi3+0x50>
  801ce3:	39 cf                	cmp    %ecx,%edi
  801ce5:	77 65                	ja     801d4c <__udivdi3+0x8c>
  801ce7:	89 fd                	mov    %edi,%ebp
  801ce9:	85 ff                	test   %edi,%edi
  801ceb:	75 0b                	jne    801cf8 <__udivdi3+0x38>
  801ced:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf2:	31 d2                	xor    %edx,%edx
  801cf4:	f7 f7                	div    %edi
  801cf6:	89 c5                	mov    %eax,%ebp
  801cf8:	31 d2                	xor    %edx,%edx
  801cfa:	89 c8                	mov    %ecx,%eax
  801cfc:	f7 f5                	div    %ebp
  801cfe:	89 c1                	mov    %eax,%ecx
  801d00:	89 d8                	mov    %ebx,%eax
  801d02:	f7 f5                	div    %ebp
  801d04:	89 cf                	mov    %ecx,%edi
  801d06:	89 fa                	mov    %edi,%edx
  801d08:	83 c4 1c             	add    $0x1c,%esp
  801d0b:	5b                   	pop    %ebx
  801d0c:	5e                   	pop    %esi
  801d0d:	5f                   	pop    %edi
  801d0e:	5d                   	pop    %ebp
  801d0f:	c3                   	ret    
  801d10:	39 ce                	cmp    %ecx,%esi
  801d12:	77 28                	ja     801d3c <__udivdi3+0x7c>
  801d14:	0f bd fe             	bsr    %esi,%edi
  801d17:	83 f7 1f             	xor    $0x1f,%edi
  801d1a:	75 40                	jne    801d5c <__udivdi3+0x9c>
  801d1c:	39 ce                	cmp    %ecx,%esi
  801d1e:	72 0a                	jb     801d2a <__udivdi3+0x6a>
  801d20:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d24:	0f 87 9e 00 00 00    	ja     801dc8 <__udivdi3+0x108>
  801d2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2f:	89 fa                	mov    %edi,%edx
  801d31:	83 c4 1c             	add    $0x1c,%esp
  801d34:	5b                   	pop    %ebx
  801d35:	5e                   	pop    %esi
  801d36:	5f                   	pop    %edi
  801d37:	5d                   	pop    %ebp
  801d38:	c3                   	ret    
  801d39:	8d 76 00             	lea    0x0(%esi),%esi
  801d3c:	31 ff                	xor    %edi,%edi
  801d3e:	31 c0                	xor    %eax,%eax
  801d40:	89 fa                	mov    %edi,%edx
  801d42:	83 c4 1c             	add    $0x1c,%esp
  801d45:	5b                   	pop    %ebx
  801d46:	5e                   	pop    %esi
  801d47:	5f                   	pop    %edi
  801d48:	5d                   	pop    %ebp
  801d49:	c3                   	ret    
  801d4a:	66 90                	xchg   %ax,%ax
  801d4c:	89 d8                	mov    %ebx,%eax
  801d4e:	f7 f7                	div    %edi
  801d50:	31 ff                	xor    %edi,%edi
  801d52:	89 fa                	mov    %edi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d61:	89 eb                	mov    %ebp,%ebx
  801d63:	29 fb                	sub    %edi,%ebx
  801d65:	89 f9                	mov    %edi,%ecx
  801d67:	d3 e6                	shl    %cl,%esi
  801d69:	89 c5                	mov    %eax,%ebp
  801d6b:	88 d9                	mov    %bl,%cl
  801d6d:	d3 ed                	shr    %cl,%ebp
  801d6f:	89 e9                	mov    %ebp,%ecx
  801d71:	09 f1                	or     %esi,%ecx
  801d73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d77:	89 f9                	mov    %edi,%ecx
  801d79:	d3 e0                	shl    %cl,%eax
  801d7b:	89 c5                	mov    %eax,%ebp
  801d7d:	89 d6                	mov    %edx,%esi
  801d7f:	88 d9                	mov    %bl,%cl
  801d81:	d3 ee                	shr    %cl,%esi
  801d83:	89 f9                	mov    %edi,%ecx
  801d85:	d3 e2                	shl    %cl,%edx
  801d87:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d8b:	88 d9                	mov    %bl,%cl
  801d8d:	d3 e8                	shr    %cl,%eax
  801d8f:	09 c2                	or     %eax,%edx
  801d91:	89 d0                	mov    %edx,%eax
  801d93:	89 f2                	mov    %esi,%edx
  801d95:	f7 74 24 0c          	divl   0xc(%esp)
  801d99:	89 d6                	mov    %edx,%esi
  801d9b:	89 c3                	mov    %eax,%ebx
  801d9d:	f7 e5                	mul    %ebp
  801d9f:	39 d6                	cmp    %edx,%esi
  801da1:	72 19                	jb     801dbc <__udivdi3+0xfc>
  801da3:	74 0b                	je     801db0 <__udivdi3+0xf0>
  801da5:	89 d8                	mov    %ebx,%eax
  801da7:	31 ff                	xor    %edi,%edi
  801da9:	e9 58 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dae:	66 90                	xchg   %ax,%ax
  801db0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801db4:	89 f9                	mov    %edi,%ecx
  801db6:	d3 e2                	shl    %cl,%edx
  801db8:	39 c2                	cmp    %eax,%edx
  801dba:	73 e9                	jae    801da5 <__udivdi3+0xe5>
  801dbc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dbf:	31 ff                	xor    %edi,%edi
  801dc1:	e9 40 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dc6:	66 90                	xchg   %ax,%ax
  801dc8:	31 c0                	xor    %eax,%eax
  801dca:	e9 37 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dcf:	90                   	nop

00801dd0 <__umoddi3>:
  801dd0:	55                   	push   %ebp
  801dd1:	57                   	push   %edi
  801dd2:	56                   	push   %esi
  801dd3:	53                   	push   %ebx
  801dd4:	83 ec 1c             	sub    $0x1c,%esp
  801dd7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ddb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ddf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801de3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801de7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801deb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801def:	89 f3                	mov    %esi,%ebx
  801df1:	89 fa                	mov    %edi,%edx
  801df3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801df7:	89 34 24             	mov    %esi,(%esp)
  801dfa:	85 c0                	test   %eax,%eax
  801dfc:	75 1a                	jne    801e18 <__umoddi3+0x48>
  801dfe:	39 f7                	cmp    %esi,%edi
  801e00:	0f 86 a2 00 00 00    	jbe    801ea8 <__umoddi3+0xd8>
  801e06:	89 c8                	mov    %ecx,%eax
  801e08:	89 f2                	mov    %esi,%edx
  801e0a:	f7 f7                	div    %edi
  801e0c:	89 d0                	mov    %edx,%eax
  801e0e:	31 d2                	xor    %edx,%edx
  801e10:	83 c4 1c             	add    $0x1c,%esp
  801e13:	5b                   	pop    %ebx
  801e14:	5e                   	pop    %esi
  801e15:	5f                   	pop    %edi
  801e16:	5d                   	pop    %ebp
  801e17:	c3                   	ret    
  801e18:	39 f0                	cmp    %esi,%eax
  801e1a:	0f 87 ac 00 00 00    	ja     801ecc <__umoddi3+0xfc>
  801e20:	0f bd e8             	bsr    %eax,%ebp
  801e23:	83 f5 1f             	xor    $0x1f,%ebp
  801e26:	0f 84 ac 00 00 00    	je     801ed8 <__umoddi3+0x108>
  801e2c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e31:	29 ef                	sub    %ebp,%edi
  801e33:	89 fe                	mov    %edi,%esi
  801e35:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e39:	89 e9                	mov    %ebp,%ecx
  801e3b:	d3 e0                	shl    %cl,%eax
  801e3d:	89 d7                	mov    %edx,%edi
  801e3f:	89 f1                	mov    %esi,%ecx
  801e41:	d3 ef                	shr    %cl,%edi
  801e43:	09 c7                	or     %eax,%edi
  801e45:	89 e9                	mov    %ebp,%ecx
  801e47:	d3 e2                	shl    %cl,%edx
  801e49:	89 14 24             	mov    %edx,(%esp)
  801e4c:	89 d8                	mov    %ebx,%eax
  801e4e:	d3 e0                	shl    %cl,%eax
  801e50:	89 c2                	mov    %eax,%edx
  801e52:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e56:	d3 e0                	shl    %cl,%eax
  801e58:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e60:	89 f1                	mov    %esi,%ecx
  801e62:	d3 e8                	shr    %cl,%eax
  801e64:	09 d0                	or     %edx,%eax
  801e66:	d3 eb                	shr    %cl,%ebx
  801e68:	89 da                	mov    %ebx,%edx
  801e6a:	f7 f7                	div    %edi
  801e6c:	89 d3                	mov    %edx,%ebx
  801e6e:	f7 24 24             	mull   (%esp)
  801e71:	89 c6                	mov    %eax,%esi
  801e73:	89 d1                	mov    %edx,%ecx
  801e75:	39 d3                	cmp    %edx,%ebx
  801e77:	0f 82 87 00 00 00    	jb     801f04 <__umoddi3+0x134>
  801e7d:	0f 84 91 00 00 00    	je     801f14 <__umoddi3+0x144>
  801e83:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e87:	29 f2                	sub    %esi,%edx
  801e89:	19 cb                	sbb    %ecx,%ebx
  801e8b:	89 d8                	mov    %ebx,%eax
  801e8d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e91:	d3 e0                	shl    %cl,%eax
  801e93:	89 e9                	mov    %ebp,%ecx
  801e95:	d3 ea                	shr    %cl,%edx
  801e97:	09 d0                	or     %edx,%eax
  801e99:	89 e9                	mov    %ebp,%ecx
  801e9b:	d3 eb                	shr    %cl,%ebx
  801e9d:	89 da                	mov    %ebx,%edx
  801e9f:	83 c4 1c             	add    $0x1c,%esp
  801ea2:	5b                   	pop    %ebx
  801ea3:	5e                   	pop    %esi
  801ea4:	5f                   	pop    %edi
  801ea5:	5d                   	pop    %ebp
  801ea6:	c3                   	ret    
  801ea7:	90                   	nop
  801ea8:	89 fd                	mov    %edi,%ebp
  801eaa:	85 ff                	test   %edi,%edi
  801eac:	75 0b                	jne    801eb9 <__umoddi3+0xe9>
  801eae:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb3:	31 d2                	xor    %edx,%edx
  801eb5:	f7 f7                	div    %edi
  801eb7:	89 c5                	mov    %eax,%ebp
  801eb9:	89 f0                	mov    %esi,%eax
  801ebb:	31 d2                	xor    %edx,%edx
  801ebd:	f7 f5                	div    %ebp
  801ebf:	89 c8                	mov    %ecx,%eax
  801ec1:	f7 f5                	div    %ebp
  801ec3:	89 d0                	mov    %edx,%eax
  801ec5:	e9 44 ff ff ff       	jmp    801e0e <__umoddi3+0x3e>
  801eca:	66 90                	xchg   %ax,%ax
  801ecc:	89 c8                	mov    %ecx,%eax
  801ece:	89 f2                	mov    %esi,%edx
  801ed0:	83 c4 1c             	add    $0x1c,%esp
  801ed3:	5b                   	pop    %ebx
  801ed4:	5e                   	pop    %esi
  801ed5:	5f                   	pop    %edi
  801ed6:	5d                   	pop    %ebp
  801ed7:	c3                   	ret    
  801ed8:	3b 04 24             	cmp    (%esp),%eax
  801edb:	72 06                	jb     801ee3 <__umoddi3+0x113>
  801edd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ee1:	77 0f                	ja     801ef2 <__umoddi3+0x122>
  801ee3:	89 f2                	mov    %esi,%edx
  801ee5:	29 f9                	sub    %edi,%ecx
  801ee7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eeb:	89 14 24             	mov    %edx,(%esp)
  801eee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ef2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ef6:	8b 14 24             	mov    (%esp),%edx
  801ef9:	83 c4 1c             	add    $0x1c,%esp
  801efc:	5b                   	pop    %ebx
  801efd:	5e                   	pop    %esi
  801efe:	5f                   	pop    %edi
  801eff:	5d                   	pop    %ebp
  801f00:	c3                   	ret    
  801f01:	8d 76 00             	lea    0x0(%esi),%esi
  801f04:	2b 04 24             	sub    (%esp),%eax
  801f07:	19 fa                	sbb    %edi,%edx
  801f09:	89 d1                	mov    %edx,%ecx
  801f0b:	89 c6                	mov    %eax,%esi
  801f0d:	e9 71 ff ff ff       	jmp    801e83 <__umoddi3+0xb3>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f18:	72 ea                	jb     801f04 <__umoddi3+0x134>
  801f1a:	89 d9                	mov    %ebx,%ecx
  801f1c:	e9 62 ff ff ff       	jmp    801e83 <__umoddi3+0xb3>
