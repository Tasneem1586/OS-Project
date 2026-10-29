
obj/user/sc_fact_recursive:     file format elf32-i386


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
  800031:	e8 ad 00 00 00       	call   8000e3 <libmain>
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
	int n=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];

	n = 20 ;
  800048:	c7 45 f4 14 00 00 00 	movl   $0x14,-0xc(%ebp)
	atomic_cprintf("Please enter a number: %d\n", n);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	68 e0 1c 80 00       	push   $0x801ce0
  80005a:	e8 36 04 00 00       	call   800495 <atomic_cprintf>
  80005f:	83 c4 10             	add    $0x10,%esp
	int64 res = factorial(n) ;
  800062:	83 ec 0c             	sub    $0xc,%esp
  800065:	ff 75 f4             	pushl  -0xc(%ebp)
  800068:	e8 27 00 00 00       	call   800094 <factorial>
  80006d:	83 c4 10             	add    $0x10,%esp
  800070:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800073:	89 55 ec             	mov    %edx,-0x14(%ebp)

	atomic_cprintf("Factorial %d = %lld\n",n, res);
  800076:	ff 75 ec             	pushl  -0x14(%ebp)
  800079:	ff 75 e8             	pushl  -0x18(%ebp)
  80007c:	ff 75 f4             	pushl  -0xc(%ebp)
  80007f:	68 fb 1c 80 00       	push   $0x801cfb
  800084:	e8 0c 04 00 00       	call   800495 <atomic_cprintf>
  800089:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
	inctst();
  80008c:	e8 66 16 00 00       	call   8016f7 <inctst>
	return;
  800091:	90                   	nop
}
  800092:	c9                   	leave  
  800093:	c3                   	ret    

00800094 <factorial>:


int64 factorial(int n)
{
  800094:	55                   	push   %ebp
  800095:	89 e5                	mov    %esp,%ebp
  800097:	57                   	push   %edi
  800098:	56                   	push   %esi
  800099:	53                   	push   %ebx
  80009a:	83 ec 0c             	sub    $0xc,%esp
	if (n <= 1)
  80009d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000a1:	7f 0c                	jg     8000af <factorial+0x1b>
		return 1 ;
  8000a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8000a8:	ba 00 00 00 00       	mov    $0x0,%edx
  8000ad:	eb 2c                	jmp    8000db <factorial+0x47>
	return n * factorial(n-1) ;
  8000af:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b2:	89 c3                	mov    %eax,%ebx
  8000b4:	89 c6                	mov    %eax,%esi
  8000b6:	c1 fe 1f             	sar    $0x1f,%esi
  8000b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8000bc:	48                   	dec    %eax
  8000bd:	83 ec 0c             	sub    $0xc,%esp
  8000c0:	50                   	push   %eax
  8000c1:	e8 ce ff ff ff       	call   800094 <factorial>
  8000c6:	83 c4 10             	add    $0x10,%esp
  8000c9:	89 f7                	mov    %esi,%edi
  8000cb:	0f af f8             	imul   %eax,%edi
  8000ce:	89 d1                	mov    %edx,%ecx
  8000d0:	0f af cb             	imul   %ebx,%ecx
  8000d3:	01 f9                	add    %edi,%ecx
  8000d5:	f7 e3                	mul    %ebx
  8000d7:	01 d1                	add    %edx,%ecx
  8000d9:	89 ca                	mov    %ecx,%edx
}
  8000db:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8000de:	5b                   	pop    %ebx
  8000df:	5e                   	pop    %esi
  8000e0:	5f                   	pop    %edi
  8000e1:	5d                   	pop    %ebp
  8000e2:	c3                   	ret    

008000e3 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000e3:	55                   	push   %ebp
  8000e4:	89 e5                	mov    %esp,%ebp
  8000e6:	57                   	push   %edi
  8000e7:	56                   	push   %esi
  8000e8:	53                   	push   %ebx
  8000e9:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000ef:	e8 fb 14 00 00       	call   8015ef <sys_getenvindex>
  8000f4:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000fa:	89 d0                	mov    %edx,%eax
  8000fc:	c1 e0 03             	shl    $0x3,%eax
  8000ff:	01 d0                	add    %edx,%eax
  800101:	c1 e0 06             	shl    $0x6,%eax
  800104:	01 d0                	add    %edx,%eax
  800106:	c1 e0 03             	shl    $0x3,%eax
  800109:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80010e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8a 40 10             	mov    0x10(%eax),%al
  80011b:	84 c0                	test   %al,%al
  80011d:	74 0d                	je     80012c <libmain+0x49>
		binaryname = myEnv->prog_name;
  80011f:	a1 20 30 80 00       	mov    0x803020,%eax
  800124:	83 c0 10             	add    $0x10,%eax
  800127:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80012c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800130:	7e 0a                	jle    80013c <libmain+0x59>
		binaryname = argv[0];
  800132:	8b 45 0c             	mov    0xc(%ebp),%eax
  800135:	8b 00                	mov    (%eax),%eax
  800137:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80013c:	83 ec 08             	sub    $0x8,%esp
  80013f:	ff 75 0c             	pushl  0xc(%ebp)
  800142:	ff 75 08             	pushl  0x8(%ebp)
  800145:	e8 ee fe ff ff       	call   800038 <_main>
  80014a:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80014d:	a1 00 30 80 00       	mov    0x803000,%eax
  800152:	85 c0                	test   %eax,%eax
  800154:	0f 84 b7 01 00 00    	je     800311 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80015a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800160:	bb 4c 1e 80 00       	mov    $0x801e4c,%ebx
  800165:	ba 0e 00 00 00       	mov    $0xe,%edx
  80016a:	89 c7                	mov    %eax,%edi
  80016c:	89 de                	mov    %ebx,%esi
  80016e:	89 d1                	mov    %edx,%ecx
  800170:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800172:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800178:	b9 56 00 00 00       	mov    $0x56,%ecx
  80017d:	b0 00                	mov    $0x0,%al
  80017f:	89 d7                	mov    %edx,%edi
  800181:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800183:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80018a:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	50                   	push   %eax
  800191:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800197:	50                   	push   %eax
  800198:	e8 52 16 00 00       	call   8017ef <sys_utilities>
  80019d:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001a0:	e8 d2 11 00 00       	call   801377 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001a5:	83 ec 0c             	sub    $0xc,%esp
  8001a8:	68 28 1d 80 00       	push   $0x801d28
  8001ad:	e8 71 02 00 00       	call   800423 <cprintf>
  8001b2:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001b5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001b8:	85 c0                	test   %eax,%eax
  8001ba:	74 58                	je     800214 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001bc:	e8 4c 16 00 00       	call   80180d <sys_get_optimal_num_faults>
  8001c1:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001c4:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001ca:	bb b0 1e 80 00       	mov    $0x801eb0,%ebx
  8001cf:	ba 11 00 00 00       	mov    $0x11,%edx
  8001d4:	89 c7                	mov    %eax,%edi
  8001d6:	89 de                	mov    %ebx,%esi
  8001d8:	89 d1                	mov    %edx,%ecx
  8001da:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001dc:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001df:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001e4:	b0 00                	mov    $0x0,%al
  8001e6:	89 d7                	mov    %edx,%edi
  8001e8:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001ea:	83 ec 08             	sub    $0x8,%esp
  8001ed:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f0:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001f6:	50                   	push   %eax
  8001f7:	e8 f3 15 00 00       	call   8017ef <sys_utilities>
  8001fc:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001ff:	83 ec 08             	sub    $0x8,%esp
  800202:	ff 75 dc             	pushl  -0x24(%ebp)
  800205:	68 50 1d 80 00       	push   $0x801d50
  80020a:	e8 14 02 00 00       	call   800423 <cprintf>
  80020f:	83 c4 10             	add    $0x10,%esp
  800212:	eb 59                	jmp    80026d <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800214:	a1 20 30 80 00       	mov    0x803020,%eax
  800219:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80021f:	a1 20 30 80 00       	mov    0x803020,%eax
  800224:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80022a:	83 ec 04             	sub    $0x4,%esp
  80022d:	52                   	push   %edx
  80022e:	50                   	push   %eax
  80022f:	68 74 1d 80 00       	push   $0x801d74
  800234:	e8 ea 01 00 00       	call   800423 <cprintf>
  800239:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80023c:	a1 20 30 80 00       	mov    0x803020,%eax
  800241:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800247:	a1 20 30 80 00       	mov    0x803020,%eax
  80024c:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800252:	a1 20 30 80 00       	mov    0x803020,%eax
  800257:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80025d:	51                   	push   %ecx
  80025e:	52                   	push   %edx
  80025f:	50                   	push   %eax
  800260:	68 9c 1d 80 00       	push   $0x801d9c
  800265:	e8 b9 01 00 00       	call   800423 <cprintf>
  80026a:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80026d:	a1 20 30 80 00       	mov    0x803020,%eax
  800272:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800278:	83 ec 08             	sub    $0x8,%esp
  80027b:	50                   	push   %eax
  80027c:	68 f4 1d 80 00       	push   $0x801df4
  800281:	e8 9d 01 00 00       	call   800423 <cprintf>
  800286:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800289:	83 ec 0c             	sub    $0xc,%esp
  80028c:	68 08 1e 80 00       	push   $0x801e08
  800291:	e8 8d 01 00 00       	call   800423 <cprintf>
  800296:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800299:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002a0:	eb 28                	jmp    8002ca <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002aa:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002b0:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002b3:	83 ec 04             	sub    $0x4,%esp
  8002b6:	50                   	push   %eax
  8002b7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002ba:	68 1f 1e 80 00       	push   $0x801e1f
  8002bf:	e8 5f 01 00 00       	call   800423 <cprintf>
  8002c4:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002c7:	ff 45 e4             	incl   -0x1c(%ebp)
  8002ca:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002ce:	7e d2                	jle    8002a2 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002d0:	83 ec 0c             	sub    $0xc,%esp
  8002d3:	68 2e 1e 80 00       	push   $0x801e2e
  8002d8:	e8 46 01 00 00       	call   800423 <cprintf>
  8002dd:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e5:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002eb:	83 ec 08             	sub    $0x8,%esp
  8002ee:	50                   	push   %eax
  8002ef:	68 32 1e 80 00       	push   $0x801e32
  8002f4:	e8 2a 01 00 00       	call   800423 <cprintf>
  8002f9:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002fc:	83 ec 0c             	sub    $0xc,%esp
  8002ff:	68 28 1d 80 00       	push   $0x801d28
  800304:	e8 1a 01 00 00       	call   800423 <cprintf>
  800309:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80030c:	e8 80 10 00 00       	call   801391 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800311:	e8 1f 00 00 00       	call   800335 <exit>
}
  800316:	90                   	nop
  800317:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80031a:	5b                   	pop    %ebx
  80031b:	5e                   	pop    %esi
  80031c:	5f                   	pop    %edi
  80031d:	5d                   	pop    %ebp
  80031e:	c3                   	ret    

0080031f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80031f:	55                   	push   %ebp
  800320:	89 e5                	mov    %esp,%ebp
  800322:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800325:	83 ec 0c             	sub    $0xc,%esp
  800328:	6a 00                	push   $0x0
  80032a:	e8 8c 12 00 00       	call   8015bb <sys_destroy_env>
  80032f:	83 c4 10             	add    $0x10,%esp
}
  800332:	90                   	nop
  800333:	c9                   	leave  
  800334:	c3                   	ret    

00800335 <exit>:

void
exit(void)
{
  800335:	55                   	push   %ebp
  800336:	89 e5                	mov    %esp,%ebp
  800338:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80033b:	e8 e1 12 00 00       	call   801621 <sys_exit_env>
}
  800340:	90                   	nop
  800341:	c9                   	leave  
  800342:	c3                   	ret    

00800343 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800343:	55                   	push   %ebp
  800344:	89 e5                	mov    %esp,%ebp
  800346:	53                   	push   %ebx
  800347:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80034a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80034d:	8b 00                	mov    (%eax),%eax
  80034f:	8d 48 01             	lea    0x1(%eax),%ecx
  800352:	8b 55 0c             	mov    0xc(%ebp),%edx
  800355:	89 0a                	mov    %ecx,(%edx)
  800357:	8b 55 08             	mov    0x8(%ebp),%edx
  80035a:	88 d1                	mov    %dl,%cl
  80035c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80035f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800363:	8b 45 0c             	mov    0xc(%ebp),%eax
  800366:	8b 00                	mov    (%eax),%eax
  800368:	3d ff 00 00 00       	cmp    $0xff,%eax
  80036d:	75 30                	jne    80039f <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80036f:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800375:	a0 40 30 80 00       	mov    0x803040,%al
  80037a:	0f b6 c0             	movzbl %al,%eax
  80037d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800380:	8b 09                	mov    (%ecx),%ecx
  800382:	89 cb                	mov    %ecx,%ebx
  800384:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800387:	83 c1 08             	add    $0x8,%ecx
  80038a:	52                   	push   %edx
  80038b:	50                   	push   %eax
  80038c:	53                   	push   %ebx
  80038d:	51                   	push   %ecx
  80038e:	e8 a0 0f 00 00       	call   801333 <sys_cputs>
  800393:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800396:	8b 45 0c             	mov    0xc(%ebp),%eax
  800399:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80039f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a2:	8b 40 04             	mov    0x4(%eax),%eax
  8003a5:	8d 50 01             	lea    0x1(%eax),%edx
  8003a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ab:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003ae:	90                   	nop
  8003af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003b2:	c9                   	leave  
  8003b3:	c3                   	ret    

008003b4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003b4:	55                   	push   %ebp
  8003b5:	89 e5                	mov    %esp,%ebp
  8003b7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003bd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003c4:	00 00 00 
	b.cnt = 0;
  8003c7:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003ce:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003d1:	ff 75 0c             	pushl  0xc(%ebp)
  8003d4:	ff 75 08             	pushl  0x8(%ebp)
  8003d7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003dd:	50                   	push   %eax
  8003de:	68 43 03 80 00       	push   $0x800343
  8003e3:	e8 5a 02 00 00       	call   800642 <vprintfmt>
  8003e8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003eb:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003f1:	a0 40 30 80 00       	mov    0x803040,%al
  8003f6:	0f b6 c0             	movzbl %al,%eax
  8003f9:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003ff:	52                   	push   %edx
  800400:	50                   	push   %eax
  800401:	51                   	push   %ecx
  800402:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800408:	83 c0 08             	add    $0x8,%eax
  80040b:	50                   	push   %eax
  80040c:	e8 22 0f 00 00       	call   801333 <sys_cputs>
  800411:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800414:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  80041b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800421:	c9                   	leave  
  800422:	c3                   	ret    

00800423 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800429:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800430:	8d 45 0c             	lea    0xc(%ebp),%eax
  800433:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	83 ec 08             	sub    $0x8,%esp
  80043c:	ff 75 f4             	pushl  -0xc(%ebp)
  80043f:	50                   	push   %eax
  800440:	e8 6f ff ff ff       	call   8003b4 <vcprintf>
  800445:	83 c4 10             	add    $0x10,%esp
  800448:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80044b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80044e:	c9                   	leave  
  80044f:	c3                   	ret    

00800450 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800450:	55                   	push   %ebp
  800451:	89 e5                	mov    %esp,%ebp
  800453:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800456:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	c1 e0 08             	shl    $0x8,%eax
  800463:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800468:	8d 45 0c             	lea    0xc(%ebp),%eax
  80046b:	83 c0 04             	add    $0x4,%eax
  80046e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	83 ec 08             	sub    $0x8,%esp
  800477:	ff 75 f4             	pushl  -0xc(%ebp)
  80047a:	50                   	push   %eax
  80047b:	e8 34 ff ff ff       	call   8003b4 <vcprintf>
  800480:	83 c4 10             	add    $0x10,%esp
  800483:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800486:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  80048d:	07 00 00 

	return cnt;
  800490:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800493:	c9                   	leave  
  800494:	c3                   	ret    

00800495 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
  800498:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80049b:	e8 d7 0e 00 00       	call   801377 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8004a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	83 ec 08             	sub    $0x8,%esp
  8004ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8004af:	50                   	push   %eax
  8004b0:	e8 ff fe ff ff       	call   8003b4 <vcprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp
  8004b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004bb:	e8 d1 0e 00 00       	call   801391 <sys_unlock_cons>
	return cnt;
  8004c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004c3:	c9                   	leave  
  8004c4:	c3                   	ret    

008004c5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004c5:	55                   	push   %ebp
  8004c6:	89 e5                	mov    %esp,%ebp
  8004c8:	53                   	push   %ebx
  8004c9:	83 ec 14             	sub    $0x14,%esp
  8004cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8004db:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e3:	77 55                	ja     80053a <printnum+0x75>
  8004e5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e8:	72 05                	jb     8004ef <printnum+0x2a>
  8004ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004ed:	77 4b                	ja     80053a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004ef:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004f2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8004f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8004fd:	52                   	push   %edx
  8004fe:	50                   	push   %eax
  8004ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800502:	ff 75 f0             	pushl  -0x10(%ebp)
  800505:	e8 62 15 00 00       	call   801a6c <__udivdi3>
  80050a:	83 c4 10             	add    $0x10,%esp
  80050d:	83 ec 04             	sub    $0x4,%esp
  800510:	ff 75 20             	pushl  0x20(%ebp)
  800513:	53                   	push   %ebx
  800514:	ff 75 18             	pushl  0x18(%ebp)
  800517:	52                   	push   %edx
  800518:	50                   	push   %eax
  800519:	ff 75 0c             	pushl  0xc(%ebp)
  80051c:	ff 75 08             	pushl  0x8(%ebp)
  80051f:	e8 a1 ff ff ff       	call   8004c5 <printnum>
  800524:	83 c4 20             	add    $0x20,%esp
  800527:	eb 1a                	jmp    800543 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800529:	83 ec 08             	sub    $0x8,%esp
  80052c:	ff 75 0c             	pushl  0xc(%ebp)
  80052f:	ff 75 20             	pushl  0x20(%ebp)
  800532:	8b 45 08             	mov    0x8(%ebp),%eax
  800535:	ff d0                	call   *%eax
  800537:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80053a:	ff 4d 1c             	decl   0x1c(%ebp)
  80053d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800541:	7f e6                	jg     800529 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800543:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800546:	bb 00 00 00 00       	mov    $0x0,%ebx
  80054b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80054e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800551:	53                   	push   %ebx
  800552:	51                   	push   %ecx
  800553:	52                   	push   %edx
  800554:	50                   	push   %eax
  800555:	e8 22 16 00 00       	call   801b7c <__umoddi3>
  80055a:	83 c4 10             	add    $0x10,%esp
  80055d:	05 34 21 80 00       	add    $0x802134,%eax
  800562:	8a 00                	mov    (%eax),%al
  800564:	0f be c0             	movsbl %al,%eax
  800567:	83 ec 08             	sub    $0x8,%esp
  80056a:	ff 75 0c             	pushl  0xc(%ebp)
  80056d:	50                   	push   %eax
  80056e:	8b 45 08             	mov    0x8(%ebp),%eax
  800571:	ff d0                	call   *%eax
  800573:	83 c4 10             	add    $0x10,%esp
}
  800576:	90                   	nop
  800577:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80057a:	c9                   	leave  
  80057b:	c3                   	ret    

0080057c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80057c:	55                   	push   %ebp
  80057d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80057f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800583:	7e 1c                	jle    8005a1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800585:	8b 45 08             	mov    0x8(%ebp),%eax
  800588:	8b 00                	mov    (%eax),%eax
  80058a:	8d 50 08             	lea    0x8(%eax),%edx
  80058d:	8b 45 08             	mov    0x8(%ebp),%eax
  800590:	89 10                	mov    %edx,(%eax)
  800592:	8b 45 08             	mov    0x8(%ebp),%eax
  800595:	8b 00                	mov    (%eax),%eax
  800597:	83 e8 08             	sub    $0x8,%eax
  80059a:	8b 50 04             	mov    0x4(%eax),%edx
  80059d:	8b 00                	mov    (%eax),%eax
  80059f:	eb 40                	jmp    8005e1 <getuint+0x65>
	else if (lflag)
  8005a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005a5:	74 1e                	je     8005c5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005aa:	8b 00                	mov    (%eax),%eax
  8005ac:	8d 50 04             	lea    0x4(%eax),%edx
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	89 10                	mov    %edx,(%eax)
  8005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b7:	8b 00                	mov    (%eax),%eax
  8005b9:	83 e8 04             	sub    $0x4,%eax
  8005bc:	8b 00                	mov    (%eax),%eax
  8005be:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c3:	eb 1c                	jmp    8005e1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	8d 50 04             	lea    0x4(%eax),%edx
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	89 10                	mov    %edx,(%eax)
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	83 e8 04             	sub    $0x4,%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005e1:	5d                   	pop    %ebp
  8005e2:	c3                   	ret    

008005e3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005e3:	55                   	push   %ebp
  8005e4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005e6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005ea:	7e 1c                	jle    800608 <getint+0x25>
		return va_arg(*ap, long long);
  8005ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ef:	8b 00                	mov    (%eax),%eax
  8005f1:	8d 50 08             	lea    0x8(%eax),%edx
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	89 10                	mov    %edx,(%eax)
  8005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fc:	8b 00                	mov    (%eax),%eax
  8005fe:	83 e8 08             	sub    $0x8,%eax
  800601:	8b 50 04             	mov    0x4(%eax),%edx
  800604:	8b 00                	mov    (%eax),%eax
  800606:	eb 38                	jmp    800640 <getint+0x5d>
	else if (lflag)
  800608:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80060c:	74 1a                	je     800628 <getint+0x45>
		return va_arg(*ap, long);
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
  800626:	eb 18                	jmp    800640 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	8b 00                	mov    (%eax),%eax
  80062d:	8d 50 04             	lea    0x4(%eax),%edx
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	89 10                	mov    %edx,(%eax)
  800635:	8b 45 08             	mov    0x8(%ebp),%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	83 e8 04             	sub    $0x4,%eax
  80063d:	8b 00                	mov    (%eax),%eax
  80063f:	99                   	cltd   
}
  800640:	5d                   	pop    %ebp
  800641:	c3                   	ret    

00800642 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800642:	55                   	push   %ebp
  800643:	89 e5                	mov    %esp,%ebp
  800645:	56                   	push   %esi
  800646:	53                   	push   %ebx
  800647:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064a:	eb 17                	jmp    800663 <vprintfmt+0x21>
			if (ch == '\0')
  80064c:	85 db                	test   %ebx,%ebx
  80064e:	0f 84 c1 03 00 00    	je     800a15 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	53                   	push   %ebx
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	ff d0                	call   *%eax
  800660:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800663:	8b 45 10             	mov    0x10(%ebp),%eax
  800666:	8d 50 01             	lea    0x1(%eax),%edx
  800669:	89 55 10             	mov    %edx,0x10(%ebp)
  80066c:	8a 00                	mov    (%eax),%al
  80066e:	0f b6 d8             	movzbl %al,%ebx
  800671:	83 fb 25             	cmp    $0x25,%ebx
  800674:	75 d6                	jne    80064c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800676:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80067a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800681:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800688:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80068f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800696:	8b 45 10             	mov    0x10(%ebp),%eax
  800699:	8d 50 01             	lea    0x1(%eax),%edx
  80069c:	89 55 10             	mov    %edx,0x10(%ebp)
  80069f:	8a 00                	mov    (%eax),%al
  8006a1:	0f b6 d8             	movzbl %al,%ebx
  8006a4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006a7:	83 f8 5b             	cmp    $0x5b,%eax
  8006aa:	0f 87 3d 03 00 00    	ja     8009ed <vprintfmt+0x3ab>
  8006b0:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  8006b7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006b9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006bd:	eb d7                	jmp    800696 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006bf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006c3:	eb d1                	jmp    800696 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006cf:	89 d0                	mov    %edx,%eax
  8006d1:	c1 e0 02             	shl    $0x2,%eax
  8006d4:	01 d0                	add    %edx,%eax
  8006d6:	01 c0                	add    %eax,%eax
  8006d8:	01 d8                	add    %ebx,%eax
  8006da:	83 e8 30             	sub    $0x30,%eax
  8006dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e3:	8a 00                	mov    (%eax),%al
  8006e5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006e8:	83 fb 2f             	cmp    $0x2f,%ebx
  8006eb:	7e 3e                	jle    80072b <vprintfmt+0xe9>
  8006ed:	83 fb 39             	cmp    $0x39,%ebx
  8006f0:	7f 39                	jg     80072b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006f2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006f5:	eb d5                	jmp    8006cc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fa:	83 c0 04             	add    $0x4,%eax
  8006fd:	89 45 14             	mov    %eax,0x14(%ebp)
  800700:	8b 45 14             	mov    0x14(%ebp),%eax
  800703:	83 e8 04             	sub    $0x4,%eax
  800706:	8b 00                	mov    (%eax),%eax
  800708:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80070b:	eb 1f                	jmp    80072c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80070d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800711:	79 83                	jns    800696 <vprintfmt+0x54>
				width = 0;
  800713:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80071a:	e9 77 ff ff ff       	jmp    800696 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80071f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800726:	e9 6b ff ff ff       	jmp    800696 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80072b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80072c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800730:	0f 89 60 ff ff ff    	jns    800696 <vprintfmt+0x54>
				width = precision, precision = -1;
  800736:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800739:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80073c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800743:	e9 4e ff ff ff       	jmp    800696 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800748:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80074b:	e9 46 ff ff ff       	jmp    800696 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800750:	8b 45 14             	mov    0x14(%ebp),%eax
  800753:	83 c0 04             	add    $0x4,%eax
  800756:	89 45 14             	mov    %eax,0x14(%ebp)
  800759:	8b 45 14             	mov    0x14(%ebp),%eax
  80075c:	83 e8 04             	sub    $0x4,%eax
  80075f:	8b 00                	mov    (%eax),%eax
  800761:	83 ec 08             	sub    $0x8,%esp
  800764:	ff 75 0c             	pushl  0xc(%ebp)
  800767:	50                   	push   %eax
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
			break;
  800770:	e9 9b 02 00 00       	jmp    800a10 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800775:	8b 45 14             	mov    0x14(%ebp),%eax
  800778:	83 c0 04             	add    $0x4,%eax
  80077b:	89 45 14             	mov    %eax,0x14(%ebp)
  80077e:	8b 45 14             	mov    0x14(%ebp),%eax
  800781:	83 e8 04             	sub    $0x4,%eax
  800784:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800786:	85 db                	test   %ebx,%ebx
  800788:	79 02                	jns    80078c <vprintfmt+0x14a>
				err = -err;
  80078a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80078c:	83 fb 64             	cmp    $0x64,%ebx
  80078f:	7f 0b                	jg     80079c <vprintfmt+0x15a>
  800791:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  800798:	85 f6                	test   %esi,%esi
  80079a:	75 19                	jne    8007b5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80079c:	53                   	push   %ebx
  80079d:	68 45 21 80 00       	push   $0x802145
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	ff 75 08             	pushl  0x8(%ebp)
  8007a8:	e8 70 02 00 00       	call   800a1d <printfmt>
  8007ad:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007b0:	e9 5b 02 00 00       	jmp    800a10 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007b5:	56                   	push   %esi
  8007b6:	68 4e 21 80 00       	push   $0x80214e
  8007bb:	ff 75 0c             	pushl  0xc(%ebp)
  8007be:	ff 75 08             	pushl  0x8(%ebp)
  8007c1:	e8 57 02 00 00       	call   800a1d <printfmt>
  8007c6:	83 c4 10             	add    $0x10,%esp
			break;
  8007c9:	e9 42 02 00 00       	jmp    800a10 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d1:	83 c0 04             	add    $0x4,%eax
  8007d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007da:	83 e8 04             	sub    $0x4,%eax
  8007dd:	8b 30                	mov    (%eax),%esi
  8007df:	85 f6                	test   %esi,%esi
  8007e1:	75 05                	jne    8007e8 <vprintfmt+0x1a6>
				p = "(null)";
  8007e3:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  8007e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ec:	7e 6d                	jle    80085b <vprintfmt+0x219>
  8007ee:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007f2:	74 67                	je     80085b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	50                   	push   %eax
  8007fb:	56                   	push   %esi
  8007fc:	e8 1e 03 00 00       	call   800b1f <strnlen>
  800801:	83 c4 10             	add    $0x10,%esp
  800804:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800807:	eb 16                	jmp    80081f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800809:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	50                   	push   %eax
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	ff d0                	call   *%eax
  800819:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80081c:	ff 4d e4             	decl   -0x1c(%ebp)
  80081f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800823:	7f e4                	jg     800809 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800825:	eb 34                	jmp    80085b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800827:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80082b:	74 1c                	je     800849 <vprintfmt+0x207>
  80082d:	83 fb 1f             	cmp    $0x1f,%ebx
  800830:	7e 05                	jle    800837 <vprintfmt+0x1f5>
  800832:	83 fb 7e             	cmp    $0x7e,%ebx
  800835:	7e 12                	jle    800849 <vprintfmt+0x207>
					putch('?', putdat);
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	ff 75 0c             	pushl  0xc(%ebp)
  80083d:	6a 3f                	push   $0x3f
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	ff d0                	call   *%eax
  800844:	83 c4 10             	add    $0x10,%esp
  800847:	eb 0f                	jmp    800858 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800849:	83 ec 08             	sub    $0x8,%esp
  80084c:	ff 75 0c             	pushl  0xc(%ebp)
  80084f:	53                   	push   %ebx
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	ff d0                	call   *%eax
  800855:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800858:	ff 4d e4             	decl   -0x1c(%ebp)
  80085b:	89 f0                	mov    %esi,%eax
  80085d:	8d 70 01             	lea    0x1(%eax),%esi
  800860:	8a 00                	mov    (%eax),%al
  800862:	0f be d8             	movsbl %al,%ebx
  800865:	85 db                	test   %ebx,%ebx
  800867:	74 24                	je     80088d <vprintfmt+0x24b>
  800869:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80086d:	78 b8                	js     800827 <vprintfmt+0x1e5>
  80086f:	ff 4d e0             	decl   -0x20(%ebp)
  800872:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800876:	79 af                	jns    800827 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800878:	eb 13                	jmp    80088d <vprintfmt+0x24b>
				putch(' ', putdat);
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	6a 20                	push   $0x20
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	ff d0                	call   *%eax
  800887:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80088a:	ff 4d e4             	decl   -0x1c(%ebp)
  80088d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800891:	7f e7                	jg     80087a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800893:	e9 78 01 00 00       	jmp    800a10 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800898:	83 ec 08             	sub    $0x8,%esp
  80089b:	ff 75 e8             	pushl  -0x18(%ebp)
  80089e:	8d 45 14             	lea    0x14(%ebp),%eax
  8008a1:	50                   	push   %eax
  8008a2:	e8 3c fd ff ff       	call   8005e3 <getint>
  8008a7:	83 c4 10             	add    $0x10,%esp
  8008aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b6:	85 d2                	test   %edx,%edx
  8008b8:	79 23                	jns    8008dd <vprintfmt+0x29b>
				putch('-', putdat);
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 0c             	pushl  0xc(%ebp)
  8008c0:	6a 2d                	push   $0x2d
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	ff d0                	call   *%eax
  8008c7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d0:	f7 d8                	neg    %eax
  8008d2:	83 d2 00             	adc    $0x0,%edx
  8008d5:	f7 da                	neg    %edx
  8008d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008da:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008dd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008e4:	e9 bc 00 00 00       	jmp    8009a5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008e9:	83 ec 08             	sub    $0x8,%esp
  8008ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8008ef:	8d 45 14             	lea    0x14(%ebp),%eax
  8008f2:	50                   	push   %eax
  8008f3:	e8 84 fc ff ff       	call   80057c <getuint>
  8008f8:	83 c4 10             	add    $0x10,%esp
  8008fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800901:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800908:	e9 98 00 00 00       	jmp    8009a5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80090d:	83 ec 08             	sub    $0x8,%esp
  800910:	ff 75 0c             	pushl  0xc(%ebp)
  800913:	6a 58                	push   $0x58
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	ff d0                	call   *%eax
  80091a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80091d:	83 ec 08             	sub    $0x8,%esp
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	6a 58                	push   $0x58
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	ff d0                	call   *%eax
  80092a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	6a 58                	push   $0x58
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	ff d0                	call   *%eax
  80093a:	83 c4 10             	add    $0x10,%esp
			break;
  80093d:	e9 ce 00 00 00       	jmp    800a10 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800942:	83 ec 08             	sub    $0x8,%esp
  800945:	ff 75 0c             	pushl  0xc(%ebp)
  800948:	6a 30                	push   $0x30
  80094a:	8b 45 08             	mov    0x8(%ebp),%eax
  80094d:	ff d0                	call   *%eax
  80094f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 0c             	pushl  0xc(%ebp)
  800958:	6a 78                	push   $0x78
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	ff d0                	call   *%eax
  80095f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800962:	8b 45 14             	mov    0x14(%ebp),%eax
  800965:	83 c0 04             	add    $0x4,%eax
  800968:	89 45 14             	mov    %eax,0x14(%ebp)
  80096b:	8b 45 14             	mov    0x14(%ebp),%eax
  80096e:	83 e8 04             	sub    $0x4,%eax
  800971:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800973:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800976:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80097d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800984:	eb 1f                	jmp    8009a5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800986:	83 ec 08             	sub    $0x8,%esp
  800989:	ff 75 e8             	pushl  -0x18(%ebp)
  80098c:	8d 45 14             	lea    0x14(%ebp),%eax
  80098f:	50                   	push   %eax
  800990:	e8 e7 fb ff ff       	call   80057c <getuint>
  800995:	83 c4 10             	add    $0x10,%esp
  800998:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80099e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009a5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009ac:	83 ec 04             	sub    $0x4,%esp
  8009af:	52                   	push   %edx
  8009b0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009b3:	50                   	push   %eax
  8009b4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b7:	ff 75 f0             	pushl  -0x10(%ebp)
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	ff 75 08             	pushl  0x8(%ebp)
  8009c0:	e8 00 fb ff ff       	call   8004c5 <printnum>
  8009c5:	83 c4 20             	add    $0x20,%esp
			break;
  8009c8:	eb 46                	jmp    800a10 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009ca:	83 ec 08             	sub    $0x8,%esp
  8009cd:	ff 75 0c             	pushl  0xc(%ebp)
  8009d0:	53                   	push   %ebx
  8009d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d4:	ff d0                	call   *%eax
  8009d6:	83 c4 10             	add    $0x10,%esp
			break;
  8009d9:	eb 35                	jmp    800a10 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009db:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009e2:	eb 2c                	jmp    800a10 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009e4:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009eb:	eb 23                	jmp    800a10 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009ed:	83 ec 08             	sub    $0x8,%esp
  8009f0:	ff 75 0c             	pushl  0xc(%ebp)
  8009f3:	6a 25                	push   $0x25
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	ff d0                	call   *%eax
  8009fa:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009fd:	ff 4d 10             	decl   0x10(%ebp)
  800a00:	eb 03                	jmp    800a05 <vprintfmt+0x3c3>
  800a02:	ff 4d 10             	decl   0x10(%ebp)
  800a05:	8b 45 10             	mov    0x10(%ebp),%eax
  800a08:	48                   	dec    %eax
  800a09:	8a 00                	mov    (%eax),%al
  800a0b:	3c 25                	cmp    $0x25,%al
  800a0d:	75 f3                	jne    800a02 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a0f:	90                   	nop
		}
	}
  800a10:	e9 35 fc ff ff       	jmp    80064a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a15:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a16:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a19:	5b                   	pop    %ebx
  800a1a:	5e                   	pop    %esi
  800a1b:	5d                   	pop    %ebp
  800a1c:	c3                   	ret    

00800a1d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a1d:	55                   	push   %ebp
  800a1e:	89 e5                	mov    %esp,%ebp
  800a20:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a23:	8d 45 10             	lea    0x10(%ebp),%eax
  800a26:	83 c0 04             	add    $0x4,%eax
  800a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a32:	50                   	push   %eax
  800a33:	ff 75 0c             	pushl  0xc(%ebp)
  800a36:	ff 75 08             	pushl  0x8(%ebp)
  800a39:	e8 04 fc ff ff       	call   800642 <vprintfmt>
  800a3e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a41:	90                   	nop
  800a42:	c9                   	leave  
  800a43:	c3                   	ret    

00800a44 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a44:	55                   	push   %ebp
  800a45:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4a:	8b 40 08             	mov    0x8(%eax),%eax
  800a4d:	8d 50 01             	lea    0x1(%eax),%edx
  800a50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a53:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a59:	8b 10                	mov    (%eax),%edx
  800a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5e:	8b 40 04             	mov    0x4(%eax),%eax
  800a61:	39 c2                	cmp    %eax,%edx
  800a63:	73 12                	jae    800a77 <sprintputch+0x33>
		*b->buf++ = ch;
  800a65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a68:	8b 00                	mov    (%eax),%eax
  800a6a:	8d 48 01             	lea    0x1(%eax),%ecx
  800a6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a70:	89 0a                	mov    %ecx,(%edx)
  800a72:	8b 55 08             	mov    0x8(%ebp),%edx
  800a75:	88 10                	mov    %dl,(%eax)
}
  800a77:	90                   	nop
  800a78:	5d                   	pop    %ebp
  800a79:	c3                   	ret    

00800a7a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a7a:	55                   	push   %ebp
  800a7b:	89 e5                	mov    %esp,%ebp
  800a7d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a89:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	01 d0                	add    %edx,%eax
  800a91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a9b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a9f:	74 06                	je     800aa7 <vsnprintf+0x2d>
  800aa1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa5:	7f 07                	jg     800aae <vsnprintf+0x34>
		return -E_INVAL;
  800aa7:	b8 03 00 00 00       	mov    $0x3,%eax
  800aac:	eb 20                	jmp    800ace <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800aae:	ff 75 14             	pushl  0x14(%ebp)
  800ab1:	ff 75 10             	pushl  0x10(%ebp)
  800ab4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ab7:	50                   	push   %eax
  800ab8:	68 44 0a 80 00       	push   $0x800a44
  800abd:	e8 80 fb ff ff       	call   800642 <vprintfmt>
  800ac2:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ac5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ac8:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ad6:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad9:	83 c0 04             	add    $0x4,%eax
  800adc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800adf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae5:	50                   	push   %eax
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	ff 75 08             	pushl  0x8(%ebp)
  800aec:	e8 89 ff ff ff       	call   800a7a <vsnprintf>
  800af1:	83 c4 10             	add    $0x10,%esp
  800af4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800afa:	c9                   	leave  
  800afb:	c3                   	ret    

00800afc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800afc:	55                   	push   %ebp
  800afd:	89 e5                	mov    %esp,%ebp
  800aff:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b09:	eb 06                	jmp    800b11 <strlen+0x15>
		n++;
  800b0b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b0e:	ff 45 08             	incl   0x8(%ebp)
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	8a 00                	mov    (%eax),%al
  800b16:	84 c0                	test   %al,%al
  800b18:	75 f1                	jne    800b0b <strlen+0xf>
		n++;
	return n;
  800b1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b2c:	eb 09                	jmp    800b37 <strnlen+0x18>
		n++;
  800b2e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b31:	ff 45 08             	incl   0x8(%ebp)
  800b34:	ff 4d 0c             	decl   0xc(%ebp)
  800b37:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b3b:	74 09                	je     800b46 <strnlen+0x27>
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8a 00                	mov    (%eax),%al
  800b42:	84 c0                	test   %al,%al
  800b44:	75 e8                	jne    800b2e <strnlen+0xf>
		n++;
	return n;
  800b46:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b49:	c9                   	leave  
  800b4a:	c3                   	ret    

00800b4b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b4b:	55                   	push   %ebp
  800b4c:	89 e5                	mov    %esp,%ebp
  800b4e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b57:	90                   	nop
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8d 50 01             	lea    0x1(%eax),%edx
  800b5e:	89 55 08             	mov    %edx,0x8(%ebp)
  800b61:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b64:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b67:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b6a:	8a 12                	mov    (%edx),%dl
  800b6c:	88 10                	mov    %dl,(%eax)
  800b6e:	8a 00                	mov    (%eax),%al
  800b70:	84 c0                	test   %al,%al
  800b72:	75 e4                	jne    800b58 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8c:	eb 1f                	jmp    800bad <strncpy+0x34>
		*dst++ = *src;
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8d 50 01             	lea    0x1(%eax),%edx
  800b94:	89 55 08             	mov    %edx,0x8(%ebp)
  800b97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9a:	8a 12                	mov    (%edx),%dl
  800b9c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	8a 00                	mov    (%eax),%al
  800ba3:	84 c0                	test   %al,%al
  800ba5:	74 03                	je     800baa <strncpy+0x31>
			src++;
  800ba7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800baa:	ff 45 fc             	incl   -0x4(%ebp)
  800bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bb3:	72 d9                	jb     800b8e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bb8:	c9                   	leave  
  800bb9:	c3                   	ret    

00800bba <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bba:	55                   	push   %ebp
  800bbb:	89 e5                	mov    %esp,%ebp
  800bbd:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bca:	74 30                	je     800bfc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bcc:	eb 16                	jmp    800be4 <strlcpy+0x2a>
			*dst++ = *src++;
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	8d 50 01             	lea    0x1(%eax),%edx
  800bd4:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bda:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bdd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800be0:	8a 12                	mov    (%edx),%dl
  800be2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800be4:	ff 4d 10             	decl   0x10(%ebp)
  800be7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800beb:	74 09                	je     800bf6 <strlcpy+0x3c>
  800bed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	84 c0                	test   %al,%al
  800bf4:	75 d8                	jne    800bce <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bfc:	8b 55 08             	mov    0x8(%ebp),%edx
  800bff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c02:	29 c2                	sub    %eax,%edx
  800c04:	89 d0                	mov    %edx,%eax
}
  800c06:	c9                   	leave  
  800c07:	c3                   	ret    

00800c08 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c08:	55                   	push   %ebp
  800c09:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c0b:	eb 06                	jmp    800c13 <strcmp+0xb>
		p++, q++;
  800c0d:	ff 45 08             	incl   0x8(%ebp)
  800c10:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	84 c0                	test   %al,%al
  800c1a:	74 0e                	je     800c2a <strcmp+0x22>
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8a 10                	mov    (%eax),%dl
  800c21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	38 c2                	cmp    %al,%dl
  800c28:	74 e3                	je     800c0d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	0f b6 d0             	movzbl %al,%edx
  800c32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	0f b6 c0             	movzbl %al,%eax
  800c3a:	29 c2                	sub    %eax,%edx
  800c3c:	89 d0                	mov    %edx,%eax
}
  800c3e:	5d                   	pop    %ebp
  800c3f:	c3                   	ret    

00800c40 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c43:	eb 09                	jmp    800c4e <strncmp+0xe>
		n--, p++, q++;
  800c45:	ff 4d 10             	decl   0x10(%ebp)
  800c48:	ff 45 08             	incl   0x8(%ebp)
  800c4b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c52:	74 17                	je     800c6b <strncmp+0x2b>
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8a 00                	mov    (%eax),%al
  800c59:	84 c0                	test   %al,%al
  800c5b:	74 0e                	je     800c6b <strncmp+0x2b>
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	8a 10                	mov    (%eax),%dl
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	8a 00                	mov    (%eax),%al
  800c67:	38 c2                	cmp    %al,%dl
  800c69:	74 da                	je     800c45 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c6f:	75 07                	jne    800c78 <strncmp+0x38>
		return 0;
  800c71:	b8 00 00 00 00       	mov    $0x0,%eax
  800c76:	eb 14                	jmp    800c8c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	8a 00                	mov    (%eax),%al
  800c7d:	0f b6 d0             	movzbl %al,%edx
  800c80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	0f b6 c0             	movzbl %al,%eax
  800c88:	29 c2                	sub    %eax,%edx
  800c8a:	89 d0                	mov    %edx,%eax
}
  800c8c:	5d                   	pop    %ebp
  800c8d:	c3                   	ret    

00800c8e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
  800c91:	83 ec 04             	sub    $0x4,%esp
  800c94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c97:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c9a:	eb 12                	jmp    800cae <strchr+0x20>
		if (*s == c)
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	8a 00                	mov    (%eax),%al
  800ca1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ca4:	75 05                	jne    800cab <strchr+0x1d>
			return (char *) s;
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	eb 11                	jmp    800cbc <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cab:	ff 45 08             	incl   0x8(%ebp)
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	84 c0                	test   %al,%al
  800cb5:	75 e5                	jne    800c9c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cbc:	c9                   	leave  
  800cbd:	c3                   	ret    

00800cbe <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cbe:	55                   	push   %ebp
  800cbf:	89 e5                	mov    %esp,%ebp
  800cc1:	83 ec 04             	sub    $0x4,%esp
  800cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cca:	eb 0d                	jmp    800cd9 <strfind+0x1b>
		if (*s == c)
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cd4:	74 0e                	je     800ce4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cd6:	ff 45 08             	incl   0x8(%ebp)
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	84 c0                	test   %al,%al
  800ce0:	75 ea                	jne    800ccc <strfind+0xe>
  800ce2:	eb 01                	jmp    800ce5 <strfind+0x27>
		if (*s == c)
			break;
  800ce4:	90                   	nop
	return (char *) s;
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ce8:	c9                   	leave  
  800ce9:	c3                   	ret    

00800cea <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800cea:	55                   	push   %ebp
  800ceb:	89 e5                	mov    %esp,%ebp
  800ced:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800cf6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800cfa:	76 63                	jbe    800d5f <memset+0x75>
		uint64 data_block = c;
  800cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cff:	99                   	cltd   
  800d00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d03:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d09:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d0c:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800d10:	c1 e0 08             	shl    $0x8,%eax
  800d13:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d16:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800d19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d1f:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d23:	c1 e0 10             	shl    $0x10,%eax
  800d26:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d29:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d32:	89 c2                	mov    %eax,%edx
  800d34:	b8 00 00 00 00       	mov    $0x0,%eax
  800d39:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d3c:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d3f:	eb 18                	jmp    800d59 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d41:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d44:	8d 41 08             	lea    0x8(%ecx),%eax
  800d47:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d50:	89 01                	mov    %eax,(%ecx)
  800d52:	89 51 04             	mov    %edx,0x4(%ecx)
  800d55:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d59:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d5d:	77 e2                	ja     800d41 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d63:	74 23                	je     800d88 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d68:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d6b:	eb 0e                	jmp    800d7b <memset+0x91>
			*p8++ = (uint8)c;
  800d6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d70:	8d 50 01             	lea    0x1(%eax),%edx
  800d73:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d76:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d79:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d81:	89 55 10             	mov    %edx,0x10(%ebp)
  800d84:	85 c0                	test   %eax,%eax
  800d86:	75 e5                	jne    800d6d <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8b:	c9                   	leave  
  800d8c:	c3                   	ret    

00800d8d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d8d:	55                   	push   %ebp
  800d8e:	89 e5                	mov    %esp,%ebp
  800d90:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d9f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800da3:	76 24                	jbe    800dc9 <memcpy+0x3c>
		while(n >= 8){
  800da5:	eb 1c                	jmp    800dc3 <memcpy+0x36>
			*d64 = *s64;
  800da7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800daa:	8b 50 04             	mov    0x4(%eax),%edx
  800dad:	8b 00                	mov    (%eax),%eax
  800daf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800db2:	89 01                	mov    %eax,(%ecx)
  800db4:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800db7:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800dbb:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800dbf:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800dc3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800dc7:	77 de                	ja     800da7 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800dc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dcd:	74 31                	je     800e00 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800dd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800ddb:	eb 16                	jmp    800df3 <memcpy+0x66>
			*d8++ = *s8++;
  800ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de0:	8d 50 01             	lea    0x1(%eax),%edx
  800de3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800de6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dec:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800def:	8a 12                	mov    (%edx),%dl
  800df1:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfc:	85 c0                	test   %eax,%eax
  800dfe:	75 dd                	jne    800ddd <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e03:	c9                   	leave  
  800e04:	c3                   	ret    

00800e05 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e05:	55                   	push   %ebp
  800e06:	89 e5                	mov    %esp,%ebp
  800e08:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e1d:	73 50                	jae    800e6f <memmove+0x6a>
  800e1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e22:	8b 45 10             	mov    0x10(%ebp),%eax
  800e25:	01 d0                	add    %edx,%eax
  800e27:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2a:	76 43                	jbe    800e6f <memmove+0x6a>
		s += n;
  800e2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e32:	8b 45 10             	mov    0x10(%ebp),%eax
  800e35:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e38:	eb 10                	jmp    800e4a <memmove+0x45>
			*--d = *--s;
  800e3a:	ff 4d f8             	decl   -0x8(%ebp)
  800e3d:	ff 4d fc             	decl   -0x4(%ebp)
  800e40:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e43:	8a 10                	mov    (%eax),%dl
  800e45:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e48:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e50:	89 55 10             	mov    %edx,0x10(%ebp)
  800e53:	85 c0                	test   %eax,%eax
  800e55:	75 e3                	jne    800e3a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e57:	eb 23                	jmp    800e7c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5c:	8d 50 01             	lea    0x1(%eax),%edx
  800e5f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e62:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e65:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e68:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6b:	8a 12                	mov    (%edx),%dl
  800e6d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e72:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e75:	89 55 10             	mov    %edx,0x10(%ebp)
  800e78:	85 c0                	test   %eax,%eax
  800e7a:	75 dd                	jne    800e59 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7f:	c9                   	leave  
  800e80:	c3                   	ret    

00800e81 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e81:	55                   	push   %ebp
  800e82:	89 e5                	mov    %esp,%ebp
  800e84:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e93:	eb 2a                	jmp    800ebf <memcmp+0x3e>
		if (*s1 != *s2)
  800e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e98:	8a 10                	mov    (%eax),%dl
  800e9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9d:	8a 00                	mov    (%eax),%al
  800e9f:	38 c2                	cmp    %al,%dl
  800ea1:	74 16                	je     800eb9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	0f b6 d0             	movzbl %al,%edx
  800eab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eae:	8a 00                	mov    (%eax),%al
  800eb0:	0f b6 c0             	movzbl %al,%eax
  800eb3:	29 c2                	sub    %eax,%edx
  800eb5:	89 d0                	mov    %edx,%eax
  800eb7:	eb 18                	jmp    800ed1 <memcmp+0x50>
		s1++, s2++;
  800eb9:	ff 45 fc             	incl   -0x4(%ebp)
  800ebc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ebf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec8:	85 c0                	test   %eax,%eax
  800eca:	75 c9                	jne    800e95 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ecc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ed9:	8b 55 08             	mov    0x8(%ebp),%edx
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	01 d0                	add    %edx,%eax
  800ee1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee4:	eb 15                	jmp    800efb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	0f b6 d0             	movzbl %al,%edx
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	0f b6 c0             	movzbl %al,%eax
  800ef4:	39 c2                	cmp    %eax,%edx
  800ef6:	74 0d                	je     800f05 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ef8:	ff 45 08             	incl   0x8(%ebp)
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f01:	72 e3                	jb     800ee6 <memfind+0x13>
  800f03:	eb 01                	jmp    800f06 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f05:	90                   	nop
	return (void *) s;
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f09:	c9                   	leave  
  800f0a:	c3                   	ret    

00800f0b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0b:	55                   	push   %ebp
  800f0c:	89 e5                	mov    %esp,%ebp
  800f0e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f11:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f18:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f1f:	eb 03                	jmp    800f24 <strtol+0x19>
		s++;
  800f21:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	3c 20                	cmp    $0x20,%al
  800f2b:	74 f4                	je     800f21 <strtol+0x16>
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	3c 09                	cmp    $0x9,%al
  800f34:	74 eb                	je     800f21 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	3c 2b                	cmp    $0x2b,%al
  800f3d:	75 05                	jne    800f44 <strtol+0x39>
		s++;
  800f3f:	ff 45 08             	incl   0x8(%ebp)
  800f42:	eb 13                	jmp    800f57 <strtol+0x4c>
	else if (*s == '-')
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	3c 2d                	cmp    $0x2d,%al
  800f4b:	75 0a                	jne    800f57 <strtol+0x4c>
		s++, neg = 1;
  800f4d:	ff 45 08             	incl   0x8(%ebp)
  800f50:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5b:	74 06                	je     800f63 <strtol+0x58>
  800f5d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f61:	75 20                	jne    800f83 <strtol+0x78>
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	3c 30                	cmp    $0x30,%al
  800f6a:	75 17                	jne    800f83 <strtol+0x78>
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	40                   	inc    %eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	3c 78                	cmp    $0x78,%al
  800f74:	75 0d                	jne    800f83 <strtol+0x78>
		s += 2, base = 16;
  800f76:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f81:	eb 28                	jmp    800fab <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f87:	75 15                	jne    800f9e <strtol+0x93>
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	3c 30                	cmp    $0x30,%al
  800f90:	75 0c                	jne    800f9e <strtol+0x93>
		s++, base = 8;
  800f92:	ff 45 08             	incl   0x8(%ebp)
  800f95:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9c:	eb 0d                	jmp    800fab <strtol+0xa0>
	else if (base == 0)
  800f9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa2:	75 07                	jne    800fab <strtol+0xa0>
		base = 10;
  800fa4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	3c 2f                	cmp    $0x2f,%al
  800fb2:	7e 19                	jle    800fcd <strtol+0xc2>
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	3c 39                	cmp    $0x39,%al
  800fbb:	7f 10                	jg     800fcd <strtol+0xc2>
			dig = *s - '0';
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	0f be c0             	movsbl %al,%eax
  800fc5:	83 e8 30             	sub    $0x30,%eax
  800fc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcb:	eb 42                	jmp    80100f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	3c 60                	cmp    $0x60,%al
  800fd4:	7e 19                	jle    800fef <strtol+0xe4>
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	3c 7a                	cmp    $0x7a,%al
  800fdd:	7f 10                	jg     800fef <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	8a 00                	mov    (%eax),%al
  800fe4:	0f be c0             	movsbl %al,%eax
  800fe7:	83 e8 57             	sub    $0x57,%eax
  800fea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fed:	eb 20                	jmp    80100f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	8a 00                	mov    (%eax),%al
  800ff4:	3c 40                	cmp    $0x40,%al
  800ff6:	7e 39                	jle    801031 <strtol+0x126>
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	8a 00                	mov    (%eax),%al
  800ffd:	3c 5a                	cmp    $0x5a,%al
  800fff:	7f 30                	jg     801031 <strtol+0x126>
			dig = *s - 'A' + 10;
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	0f be c0             	movsbl %al,%eax
  801009:	83 e8 37             	sub    $0x37,%eax
  80100c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80100f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801012:	3b 45 10             	cmp    0x10(%ebp),%eax
  801015:	7d 19                	jge    801030 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801017:	ff 45 08             	incl   0x8(%ebp)
  80101a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801021:	89 c2                	mov    %eax,%edx
  801023:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801026:	01 d0                	add    %edx,%eax
  801028:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102b:	e9 7b ff ff ff       	jmp    800fab <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801030:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801031:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801035:	74 08                	je     80103f <strtol+0x134>
		*endptr = (char *) s;
  801037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103a:	8b 55 08             	mov    0x8(%ebp),%edx
  80103d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80103f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801043:	74 07                	je     80104c <strtol+0x141>
  801045:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801048:	f7 d8                	neg    %eax
  80104a:	eb 03                	jmp    80104f <strtol+0x144>
  80104c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80104f:	c9                   	leave  
  801050:	c3                   	ret    

00801051 <ltostr>:

void
ltostr(long value, char *str)
{
  801051:	55                   	push   %ebp
  801052:	89 e5                	mov    %esp,%ebp
  801054:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801057:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80105e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801065:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801069:	79 13                	jns    80107e <ltostr+0x2d>
	{
		neg = 1;
  80106b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801072:	8b 45 0c             	mov    0xc(%ebp),%eax
  801075:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801078:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801086:	99                   	cltd   
  801087:	f7 f9                	idiv   %ecx
  801089:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108f:	8d 50 01             	lea    0x1(%eax),%edx
  801092:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801095:	89 c2                	mov    %eax,%edx
  801097:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109a:	01 d0                	add    %edx,%eax
  80109c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80109f:	83 c2 30             	add    $0x30,%edx
  8010a2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ac:	f7 e9                	imul   %ecx
  8010ae:	c1 fa 02             	sar    $0x2,%edx
  8010b1:	89 c8                	mov    %ecx,%eax
  8010b3:	c1 f8 1f             	sar    $0x1f,%eax
  8010b6:	29 c2                	sub    %eax,%edx
  8010b8:	89 d0                	mov    %edx,%eax
  8010ba:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8010bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010c1:	75 bb                	jne    80107e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cd:	48                   	dec    %eax
  8010ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d5:	74 3d                	je     801114 <ltostr+0xc3>
		start = 1 ;
  8010d7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010de:	eb 34                	jmp    801114 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8010e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e6:	01 d0                	add    %edx,%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f3:	01 c2                	add    %eax,%edx
  8010f5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fb:	01 c8                	add    %ecx,%eax
  8010fd:	8a 00                	mov    (%eax),%al
  8010ff:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801101:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	01 c2                	add    %eax,%edx
  801109:	8a 45 eb             	mov    -0x15(%ebp),%al
  80110c:	88 02                	mov    %al,(%edx)
		start++ ;
  80110e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801111:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801114:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801117:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80111a:	7c c4                	jl     8010e0 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80111c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	01 d0                	add    %edx,%eax
  801124:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801127:	90                   	nop
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
  80112d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801130:	ff 75 08             	pushl  0x8(%ebp)
  801133:	e8 c4 f9 ff ff       	call   800afc <strlen>
  801138:	83 c4 04             	add    $0x4,%esp
  80113b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80113e:	ff 75 0c             	pushl  0xc(%ebp)
  801141:	e8 b6 f9 ff ff       	call   800afc <strlen>
  801146:	83 c4 04             	add    $0x4,%esp
  801149:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80114c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801153:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80115a:	eb 17                	jmp    801173 <strcconcat+0x49>
		final[s] = str1[s] ;
  80115c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115f:	8b 45 10             	mov    0x10(%ebp),%eax
  801162:	01 c2                	add    %eax,%edx
  801164:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	01 c8                	add    %ecx,%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801170:	ff 45 fc             	incl   -0x4(%ebp)
  801173:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801176:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801179:	7c e1                	jl     80115c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80117b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801182:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801189:	eb 1f                	jmp    8011aa <strcconcat+0x80>
		final[s++] = str2[i] ;
  80118b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118e:	8d 50 01             	lea    0x1(%eax),%edx
  801191:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801194:	89 c2                	mov    %eax,%edx
  801196:	8b 45 10             	mov    0x10(%ebp),%eax
  801199:	01 c2                	add    %eax,%edx
  80119b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80119e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a1:	01 c8                	add    %ecx,%eax
  8011a3:	8a 00                	mov    (%eax),%al
  8011a5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011a7:	ff 45 f8             	incl   -0x8(%ebp)
  8011aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011b0:	7c d9                	jl     80118b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b8:	01 d0                	add    %edx,%eax
  8011ba:	c6 00 00             	movb   $0x0,(%eax)
}
  8011bd:	90                   	nop
  8011be:	c9                   	leave  
  8011bf:	c3                   	ret    

008011c0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cf:	8b 00                	mov    (%eax),%eax
  8011d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011db:	01 d0                	add    %edx,%eax
  8011dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e3:	eb 0c                	jmp    8011f1 <strsplit+0x31>
			*string++ = 0;
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8d 50 01             	lea    0x1(%eax),%edx
  8011eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ee:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	84 c0                	test   %al,%al
  8011f8:	74 18                	je     801212 <strsplit+0x52>
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	0f be c0             	movsbl %al,%eax
  801202:	50                   	push   %eax
  801203:	ff 75 0c             	pushl  0xc(%ebp)
  801206:	e8 83 fa ff ff       	call   800c8e <strchr>
  80120b:	83 c4 08             	add    $0x8,%esp
  80120e:	85 c0                	test   %eax,%eax
  801210:	75 d3                	jne    8011e5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	84 c0                	test   %al,%al
  801219:	74 5a                	je     801275 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80121b:	8b 45 14             	mov    0x14(%ebp),%eax
  80121e:	8b 00                	mov    (%eax),%eax
  801220:	83 f8 0f             	cmp    $0xf,%eax
  801223:	75 07                	jne    80122c <strsplit+0x6c>
		{
			return 0;
  801225:	b8 00 00 00 00       	mov    $0x0,%eax
  80122a:	eb 66                	jmp    801292 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80122c:	8b 45 14             	mov    0x14(%ebp),%eax
  80122f:	8b 00                	mov    (%eax),%eax
  801231:	8d 48 01             	lea    0x1(%eax),%ecx
  801234:	8b 55 14             	mov    0x14(%ebp),%edx
  801237:	89 0a                	mov    %ecx,(%edx)
  801239:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801240:	8b 45 10             	mov    0x10(%ebp),%eax
  801243:	01 c2                	add    %eax,%edx
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124a:	eb 03                	jmp    80124f <strsplit+0x8f>
			string++;
  80124c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	84 c0                	test   %al,%al
  801256:	74 8b                	je     8011e3 <strsplit+0x23>
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	0f be c0             	movsbl %al,%eax
  801260:	50                   	push   %eax
  801261:	ff 75 0c             	pushl  0xc(%ebp)
  801264:	e8 25 fa ff ff       	call   800c8e <strchr>
  801269:	83 c4 08             	add    $0x8,%esp
  80126c:	85 c0                	test   %eax,%eax
  80126e:	74 dc                	je     80124c <strsplit+0x8c>
			string++;
	}
  801270:	e9 6e ff ff ff       	jmp    8011e3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801275:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801276:	8b 45 14             	mov    0x14(%ebp),%eax
  801279:	8b 00                	mov    (%eax),%eax
  80127b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801282:	8b 45 10             	mov    0x10(%ebp),%eax
  801285:	01 d0                	add    %edx,%eax
  801287:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80128d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
  801297:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8012a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a7:	eb 4a                	jmp    8012f3 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8012a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	01 c2                	add    %eax,%edx
  8012b1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b7:	01 c8                	add    %ecx,%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8012bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c3:	01 d0                	add    %edx,%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	3c 40                	cmp    $0x40,%al
  8012c9:	7e 25                	jle    8012f0 <str2lower+0x5c>
  8012cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	01 d0                	add    %edx,%eax
  8012d3:	8a 00                	mov    (%eax),%al
  8012d5:	3c 5a                	cmp    $0x5a,%al
  8012d7:	7f 17                	jg     8012f0 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	01 d0                	add    %edx,%eax
  8012e1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8012e7:	01 ca                	add    %ecx,%edx
  8012e9:	8a 12                	mov    (%edx),%dl
  8012eb:	83 c2 20             	add    $0x20,%edx
  8012ee:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012f0:	ff 45 fc             	incl   -0x4(%ebp)
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	e8 01 f8 ff ff       	call   800afc <strlen>
  8012fb:	83 c4 04             	add    $0x4,%esp
  8012fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801301:	7f a6                	jg     8012a9 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	57                   	push   %edi
  80130c:	56                   	push   %esi
  80130d:	53                   	push   %ebx
  80130e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801311:	8b 45 08             	mov    0x8(%ebp),%eax
  801314:	8b 55 0c             	mov    0xc(%ebp),%edx
  801317:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80131a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80131d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801320:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801323:	cd 30                	int    $0x30
  801325:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801328:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80132b:	83 c4 10             	add    $0x10,%esp
  80132e:	5b                   	pop    %ebx
  80132f:	5e                   	pop    %esi
  801330:	5f                   	pop    %edi
  801331:	5d                   	pop    %ebp
  801332:	c3                   	ret    

00801333 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
  801336:	83 ec 04             	sub    $0x4,%esp
  801339:	8b 45 10             	mov    0x10(%ebp),%eax
  80133c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80133f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801342:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	6a 00                	push   $0x0
  80134b:	51                   	push   %ecx
  80134c:	52                   	push   %edx
  80134d:	ff 75 0c             	pushl  0xc(%ebp)
  801350:	50                   	push   %eax
  801351:	6a 00                	push   $0x0
  801353:	e8 b0 ff ff ff       	call   801308 <syscall>
  801358:	83 c4 18             	add    $0x18,%esp
}
  80135b:	90                   	nop
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <sys_cgetc>:

int
sys_cgetc(void)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 02                	push   $0x2
  80136d:	e8 96 ff ff ff       	call   801308 <syscall>
  801372:	83 c4 18             	add    $0x18,%esp
}
  801375:	c9                   	leave  
  801376:	c3                   	ret    

00801377 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801377:	55                   	push   %ebp
  801378:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 03                	push   $0x3
  801386:	e8 7d ff ff ff       	call   801308 <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	90                   	nop
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 04                	push   $0x4
  8013a0:	e8 63 ff ff ff       	call   801308 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	90                   	nop
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	52                   	push   %edx
  8013bb:	50                   	push   %eax
  8013bc:	6a 08                	push   $0x8
  8013be:	e8 45 ff ff ff       	call   801308 <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
  8013cb:	56                   	push   %esi
  8013cc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013cd:	8b 75 18             	mov    0x18(%ebp),%esi
  8013d0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	56                   	push   %esi
  8013dd:	53                   	push   %ebx
  8013de:	51                   	push   %ecx
  8013df:	52                   	push   %edx
  8013e0:	50                   	push   %eax
  8013e1:	6a 09                	push   $0x9
  8013e3:	e8 20 ff ff ff       	call   801308 <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
}
  8013eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013ee:	5b                   	pop    %ebx
  8013ef:	5e                   	pop    %esi
  8013f0:	5d                   	pop    %ebp
  8013f1:	c3                   	ret    

008013f2 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	ff 75 08             	pushl  0x8(%ebp)
  801400:	6a 0a                	push   $0xa
  801402:	e8 01 ff ff ff       	call   801308 <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	ff 75 0c             	pushl  0xc(%ebp)
  801418:	ff 75 08             	pushl  0x8(%ebp)
  80141b:	6a 0b                	push   $0xb
  80141d:	e8 e6 fe ff ff       	call   801308 <syscall>
  801422:	83 c4 18             	add    $0x18,%esp
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 0c                	push   $0xc
  801436:	e8 cd fe ff ff       	call   801308 <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 0d                	push   $0xd
  80144f:	e8 b4 fe ff ff       	call   801308 <syscall>
  801454:	83 c4 18             	add    $0x18,%esp
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 0e                	push   $0xe
  801468:	e8 9b fe ff ff       	call   801308 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 0f                	push   $0xf
  801481:	e8 82 fe ff ff       	call   801308 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	ff 75 08             	pushl  0x8(%ebp)
  801499:	6a 10                	push   $0x10
  80149b:	e8 68 fe ff ff       	call   801308 <syscall>
  8014a0:	83 c4 18             	add    $0x18,%esp
}
  8014a3:	c9                   	leave  
  8014a4:	c3                   	ret    

008014a5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 11                	push   $0x11
  8014b4:	e8 4f fe ff ff       	call   801308 <syscall>
  8014b9:	83 c4 18             	add    $0x18,%esp
}
  8014bc:	90                   	nop
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <sys_cputc>:

void
sys_cputc(const char c)
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
  8014c2:	83 ec 04             	sub    $0x4,%esp
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	50                   	push   %eax
  8014d8:	6a 01                	push   $0x1
  8014da:	e8 29 fe ff ff       	call   801308 <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
}
  8014e2:	90                   	nop
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 14                	push   $0x14
  8014f4:	e8 0f fe ff ff       	call   801308 <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	90                   	nop
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	8b 45 10             	mov    0x10(%ebp),%eax
  801508:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80150b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80150e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	6a 00                	push   $0x0
  801517:	51                   	push   %ecx
  801518:	52                   	push   %edx
  801519:	ff 75 0c             	pushl  0xc(%ebp)
  80151c:	50                   	push   %eax
  80151d:	6a 15                	push   $0x15
  80151f:	e8 e4 fd ff ff       	call   801308 <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80152c:	8b 55 10             	mov    0x10(%ebp),%edx
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	52                   	push   %edx
  801537:	50                   	push   %eax
  801538:	ff 75 08             	pushl  0x8(%ebp)
  80153b:	6a 16                	push   $0x16
  80153d:	e8 c6 fd ff ff       	call   801308 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80154a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	52                   	push   %edx
  801557:	50                   	push   %eax
  801558:	6a 17                	push   $0x17
  80155a:	e8 a9 fd ff ff       	call   801308 <syscall>
  80155f:	83 c4 18             	add    $0x18,%esp
}
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801567:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	52                   	push   %edx
  801574:	50                   	push   %eax
  801575:	6a 18                	push   $0x18
  801577:	e8 8c fd ff ff       	call   801308 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	ff 75 14             	pushl  0x14(%ebp)
  80158c:	ff 75 10             	pushl  0x10(%ebp)
  80158f:	ff 75 0c             	pushl  0xc(%ebp)
  801592:	50                   	push   %eax
  801593:	6a 19                	push   $0x19
  801595:	e8 6e fd ff ff       	call   801308 <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_run_env>:

void sys_run_env(int32 envId)
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	50                   	push   %eax
  8015ae:	6a 1a                	push   $0x1a
  8015b0:	e8 53 fd ff ff       	call   801308 <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	90                   	nop
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	50                   	push   %eax
  8015ca:	6a 1b                	push   $0x1b
  8015cc:	e8 37 fd ff ff       	call   801308 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 05                	push   $0x5
  8015e5:	e8 1e fd ff ff       	call   801308 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 06                	push   $0x6
  8015fe:	e8 05 fd ff ff       	call   801308 <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 07                	push   $0x7
  801617:	e8 ec fc ff ff       	call   801308 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_exit_env>:


void sys_exit_env(void)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 1c                	push   $0x1c
  801630:	e8 d3 fc ff ff       	call   801308 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	90                   	nop
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	ff 75 10             	pushl  0x10(%ebp)
  801645:	ff 75 0c             	pushl  0xc(%ebp)
  801648:	ff 75 08             	pushl  0x8(%ebp)
  80164b:	6a 13                	push   $0x13
  80164d:	e8 b6 fc ff ff       	call   801308 <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
	return ;
  801655:	90                   	nop
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_rcr2>:
uint32 sys_rcr2()
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 1e                	push   $0x1e
  801667:	e8 9c fc ff ff       	call   801308 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
  801674:	83 ec 04             	sub    $0x4,%esp
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80167d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	50                   	push   %eax
  80168a:	6a 1f                	push   $0x1f
  80168c:	e8 77 fc ff ff       	call   801308 <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
	return ;
  801694:	90                   	nop
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <rsttst>:
void rsttst()
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 21                	push   $0x21
  8016a6:	e8 5d fc ff ff       	call   801308 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ae:	90                   	nop
}
  8016af:	c9                   	leave  
  8016b0:	c3                   	ret    

008016b1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016b1:	55                   	push   %ebp
  8016b2:	89 e5                	mov    %esp,%ebp
  8016b4:	83 ec 04             	sub    $0x4,%esp
  8016b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016bd:	8b 55 18             	mov    0x18(%ebp),%edx
  8016c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016c4:	52                   	push   %edx
  8016c5:	50                   	push   %eax
  8016c6:	ff 75 10             	pushl  0x10(%ebp)
  8016c9:	ff 75 0c             	pushl  0xc(%ebp)
  8016cc:	ff 75 08             	pushl  0x8(%ebp)
  8016cf:	6a 20                	push   $0x20
  8016d1:	e8 32 fc ff ff       	call   801308 <syscall>
  8016d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d9:	90                   	nop
}
  8016da:	c9                   	leave  
  8016db:	c3                   	ret    

008016dc <chktst>:
void chktst(uint32 n)
{
  8016dc:	55                   	push   %ebp
  8016dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	ff 75 08             	pushl  0x8(%ebp)
  8016ea:	6a 22                	push   $0x22
  8016ec:	e8 17 fc ff ff       	call   801308 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f4:	90                   	nop
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <inctst>:

void inctst()
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 23                	push   $0x23
  801706:	e8 fd fb ff ff       	call   801308 <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
	return ;
  80170e:	90                   	nop
}
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <gettst>:
uint32 gettst()
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 24                	push   $0x24
  801720:	e8 e3 fb ff ff       	call   801308 <syscall>
  801725:	83 c4 18             	add    $0x18,%esp
}
  801728:	c9                   	leave  
  801729:	c3                   	ret    

0080172a <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80172a:	55                   	push   %ebp
  80172b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 25                	push   $0x25
  801739:	e8 ca fb ff ff       	call   801308 <syscall>
  80173e:	83 c4 18             	add    $0x18,%esp
  801741:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801746:	a1 48 30 80 00       	mov    0x803048,%eax
}
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	ff 75 08             	pushl  0x8(%ebp)
  801763:	6a 26                	push   $0x26
  801765:	e8 9e fb ff ff       	call   801308 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
	return ;
  80176d:	90                   	nop
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801774:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801777:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80177a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177d:	8b 45 08             	mov    0x8(%ebp),%eax
  801780:	6a 00                	push   $0x0
  801782:	53                   	push   %ebx
  801783:	51                   	push   %ecx
  801784:	52                   	push   %edx
  801785:	50                   	push   %eax
  801786:	6a 27                	push   $0x27
  801788:	e8 7b fb ff ff       	call   801308 <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801798:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	52                   	push   %edx
  8017a5:	50                   	push   %eax
  8017a6:	6a 28                	push   $0x28
  8017a8:	e8 5b fb ff ff       	call   801308 <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8017b5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	51                   	push   %ecx
  8017c1:	ff 75 10             	pushl  0x10(%ebp)
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 29                	push   $0x29
  8017c8:	e8 3b fb ff ff       	call   801308 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	ff 75 10             	pushl  0x10(%ebp)
  8017dc:	ff 75 0c             	pushl  0xc(%ebp)
  8017df:	ff 75 08             	pushl  0x8(%ebp)
  8017e2:	6a 12                	push   $0x12
  8017e4:	e8 1f fb ff ff       	call   801308 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ec:	90                   	nop
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	52                   	push   %edx
  8017ff:	50                   	push   %eax
  801800:	6a 2a                	push   $0x2a
  801802:	e8 01 fb ff ff       	call   801308 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
	return;
  80180a:	90                   	nop
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 2b                	push   $0x2b
  80181c:	e8 e7 fa ff ff       	call   801308 <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
  801829:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  80182c:	83 ec 04             	sub    $0x4,%esp
  80182f:	68 c8 22 80 00       	push   $0x8022c8
  801834:	68 0a 01 00 00       	push   $0x10a
  801839:	68 d8 22 80 00       	push   $0x8022d8
  80183e:	e8 38 00 00 00       	call   80187b <_panic>

00801843 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	ff 75 0c             	pushl  0xc(%ebp)
  80184f:	ff 75 08             	pushl  0x8(%ebp)
  801852:	6a 33                	push   $0x33
  801854:	e8 af fa ff ff       	call   801308 <syscall>
  801859:	83 c4 18             	add    $0x18,%esp
	return;
  80185c:	90                   	nop
}
  80185d:	c9                   	leave  
  80185e:	c3                   	ret    

0080185f <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	ff 75 0c             	pushl  0xc(%ebp)
  80186b:	ff 75 08             	pushl  0x8(%ebp)
  80186e:	6a 34                	push   $0x34
  801870:	e8 93 fa ff ff       	call   801308 <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
	return ;
  801878:	90                   	nop
}
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
  80187e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801881:	8d 45 10             	lea    0x10(%ebp),%eax
  801884:	83 c0 04             	add    $0x4,%eax
  801887:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80188a:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80188f:	85 c0                	test   %eax,%eax
  801891:	74 16                	je     8018a9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801893:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801898:	83 ec 08             	sub    $0x8,%esp
  80189b:	50                   	push   %eax
  80189c:	68 e8 22 80 00       	push   $0x8022e8
  8018a1:	e8 7d eb ff ff       	call   800423 <cprintf>
  8018a6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8018a9:	a1 04 30 80 00       	mov    0x803004,%eax
  8018ae:	83 ec 0c             	sub    $0xc,%esp
  8018b1:	ff 75 0c             	pushl  0xc(%ebp)
  8018b4:	ff 75 08             	pushl  0x8(%ebp)
  8018b7:	50                   	push   %eax
  8018b8:	68 f0 22 80 00       	push   $0x8022f0
  8018bd:	6a 74                	push   $0x74
  8018bf:	e8 8c eb ff ff       	call   800450 <cprintf_colored>
  8018c4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8018c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ca:	83 ec 08             	sub    $0x8,%esp
  8018cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8018d0:	50                   	push   %eax
  8018d1:	e8 de ea ff ff       	call   8003b4 <vcprintf>
  8018d6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018d9:	83 ec 08             	sub    $0x8,%esp
  8018dc:	6a 00                	push   $0x0
  8018de:	68 18 23 80 00       	push   $0x802318
  8018e3:	e8 cc ea ff ff       	call   8003b4 <vcprintf>
  8018e8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018eb:	e8 45 ea ff ff       	call   800335 <exit>

	// should not return here
	while (1) ;
  8018f0:	eb fe                	jmp    8018f0 <_panic+0x75>

008018f2 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
  8018f5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8018fd:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801903:	8b 45 0c             	mov    0xc(%ebp),%eax
  801906:	39 c2                	cmp    %eax,%edx
  801908:	74 14                	je     80191e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80190a:	83 ec 04             	sub    $0x4,%esp
  80190d:	68 1c 23 80 00       	push   $0x80231c
  801912:	6a 26                	push   $0x26
  801914:	68 68 23 80 00       	push   $0x802368
  801919:	e8 5d ff ff ff       	call   80187b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80191e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801925:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80192c:	e9 c5 00 00 00       	jmp    8019f6 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801931:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801934:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	01 d0                	add    %edx,%eax
  801940:	8b 00                	mov    (%eax),%eax
  801942:	85 c0                	test   %eax,%eax
  801944:	75 08                	jne    80194e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801946:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801949:	e9 a5 00 00 00       	jmp    8019f3 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80194e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801955:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80195c:	eb 69                	jmp    8019c7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80195e:	a1 20 30 80 00       	mov    0x803020,%eax
  801963:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801969:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80196c:	89 d0                	mov    %edx,%eax
  80196e:	01 c0                	add    %eax,%eax
  801970:	01 d0                	add    %edx,%eax
  801972:	c1 e0 03             	shl    $0x3,%eax
  801975:	01 c8                	add    %ecx,%eax
  801977:	8a 40 04             	mov    0x4(%eax),%al
  80197a:	84 c0                	test   %al,%al
  80197c:	75 46                	jne    8019c4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80197e:	a1 20 30 80 00       	mov    0x803020,%eax
  801983:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801989:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80198c:	89 d0                	mov    %edx,%eax
  80198e:	01 c0                	add    %eax,%eax
  801990:	01 d0                	add    %edx,%eax
  801992:	c1 e0 03             	shl    $0x3,%eax
  801995:	01 c8                	add    %ecx,%eax
  801997:	8b 00                	mov    (%eax),%eax
  801999:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80199c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80199f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8019a4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8019a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	01 c8                	add    %ecx,%eax
  8019b5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019b7:	39 c2                	cmp    %eax,%edx
  8019b9:	75 09                	jne    8019c4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8019bb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019c2:	eb 15                	jmp    8019d9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019c4:	ff 45 e8             	incl   -0x18(%ebp)
  8019c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8019cc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d5:	39 c2                	cmp    %eax,%edx
  8019d7:	77 85                	ja     80195e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019dd:	75 14                	jne    8019f3 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8019df:	83 ec 04             	sub    $0x4,%esp
  8019e2:	68 74 23 80 00       	push   $0x802374
  8019e7:	6a 3a                	push   $0x3a
  8019e9:	68 68 23 80 00       	push   $0x802368
  8019ee:	e8 88 fe ff ff       	call   80187b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019f3:	ff 45 f0             	incl   -0x10(%ebp)
  8019f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019fc:	0f 8c 2f ff ff ff    	jl     801931 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a02:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a09:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801a10:	eb 26                	jmp    801a38 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801a12:	a1 20 30 80 00       	mov    0x803020,%eax
  801a17:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801a1d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a20:	89 d0                	mov    %edx,%eax
  801a22:	01 c0                	add    %eax,%eax
  801a24:	01 d0                	add    %edx,%eax
  801a26:	c1 e0 03             	shl    $0x3,%eax
  801a29:	01 c8                	add    %ecx,%eax
  801a2b:	8a 40 04             	mov    0x4(%eax),%al
  801a2e:	3c 01                	cmp    $0x1,%al
  801a30:	75 03                	jne    801a35 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801a32:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a35:	ff 45 e0             	incl   -0x20(%ebp)
  801a38:	a1 20 30 80 00       	mov    0x803020,%eax
  801a3d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a43:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a46:	39 c2                	cmp    %eax,%edx
  801a48:	77 c8                	ja     801a12 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a4d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a50:	74 14                	je     801a66 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a52:	83 ec 04             	sub    $0x4,%esp
  801a55:	68 c8 23 80 00       	push   $0x8023c8
  801a5a:	6a 44                	push   $0x44
  801a5c:	68 68 23 80 00       	push   $0x802368
  801a61:	e8 15 fe ff ff       	call   80187b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a66:	90                   	nop
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    
  801a69:	66 90                	xchg   %ax,%ax
  801a6b:	90                   	nop

00801a6c <__udivdi3>:
  801a6c:	55                   	push   %ebp
  801a6d:	57                   	push   %edi
  801a6e:	56                   	push   %esi
  801a6f:	53                   	push   %ebx
  801a70:	83 ec 1c             	sub    $0x1c,%esp
  801a73:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a77:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a7b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a7f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a83:	89 ca                	mov    %ecx,%edx
  801a85:	89 f8                	mov    %edi,%eax
  801a87:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a8b:	85 f6                	test   %esi,%esi
  801a8d:	75 2d                	jne    801abc <__udivdi3+0x50>
  801a8f:	39 cf                	cmp    %ecx,%edi
  801a91:	77 65                	ja     801af8 <__udivdi3+0x8c>
  801a93:	89 fd                	mov    %edi,%ebp
  801a95:	85 ff                	test   %edi,%edi
  801a97:	75 0b                	jne    801aa4 <__udivdi3+0x38>
  801a99:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9e:	31 d2                	xor    %edx,%edx
  801aa0:	f7 f7                	div    %edi
  801aa2:	89 c5                	mov    %eax,%ebp
  801aa4:	31 d2                	xor    %edx,%edx
  801aa6:	89 c8                	mov    %ecx,%eax
  801aa8:	f7 f5                	div    %ebp
  801aaa:	89 c1                	mov    %eax,%ecx
  801aac:	89 d8                	mov    %ebx,%eax
  801aae:	f7 f5                	div    %ebp
  801ab0:	89 cf                	mov    %ecx,%edi
  801ab2:	89 fa                	mov    %edi,%edx
  801ab4:	83 c4 1c             	add    $0x1c,%esp
  801ab7:	5b                   	pop    %ebx
  801ab8:	5e                   	pop    %esi
  801ab9:	5f                   	pop    %edi
  801aba:	5d                   	pop    %ebp
  801abb:	c3                   	ret    
  801abc:	39 ce                	cmp    %ecx,%esi
  801abe:	77 28                	ja     801ae8 <__udivdi3+0x7c>
  801ac0:	0f bd fe             	bsr    %esi,%edi
  801ac3:	83 f7 1f             	xor    $0x1f,%edi
  801ac6:	75 40                	jne    801b08 <__udivdi3+0x9c>
  801ac8:	39 ce                	cmp    %ecx,%esi
  801aca:	72 0a                	jb     801ad6 <__udivdi3+0x6a>
  801acc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ad0:	0f 87 9e 00 00 00    	ja     801b74 <__udivdi3+0x108>
  801ad6:	b8 01 00 00 00       	mov    $0x1,%eax
  801adb:	89 fa                	mov    %edi,%edx
  801add:	83 c4 1c             	add    $0x1c,%esp
  801ae0:	5b                   	pop    %ebx
  801ae1:	5e                   	pop    %esi
  801ae2:	5f                   	pop    %edi
  801ae3:	5d                   	pop    %ebp
  801ae4:	c3                   	ret    
  801ae5:	8d 76 00             	lea    0x0(%esi),%esi
  801ae8:	31 ff                	xor    %edi,%edi
  801aea:	31 c0                	xor    %eax,%eax
  801aec:	89 fa                	mov    %edi,%edx
  801aee:	83 c4 1c             	add    $0x1c,%esp
  801af1:	5b                   	pop    %ebx
  801af2:	5e                   	pop    %esi
  801af3:	5f                   	pop    %edi
  801af4:	5d                   	pop    %ebp
  801af5:	c3                   	ret    
  801af6:	66 90                	xchg   %ax,%ax
  801af8:	89 d8                	mov    %ebx,%eax
  801afa:	f7 f7                	div    %edi
  801afc:	31 ff                	xor    %edi,%edi
  801afe:	89 fa                	mov    %edi,%edx
  801b00:	83 c4 1c             	add    $0x1c,%esp
  801b03:	5b                   	pop    %ebx
  801b04:	5e                   	pop    %esi
  801b05:	5f                   	pop    %edi
  801b06:	5d                   	pop    %ebp
  801b07:	c3                   	ret    
  801b08:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b0d:	89 eb                	mov    %ebp,%ebx
  801b0f:	29 fb                	sub    %edi,%ebx
  801b11:	89 f9                	mov    %edi,%ecx
  801b13:	d3 e6                	shl    %cl,%esi
  801b15:	89 c5                	mov    %eax,%ebp
  801b17:	88 d9                	mov    %bl,%cl
  801b19:	d3 ed                	shr    %cl,%ebp
  801b1b:	89 e9                	mov    %ebp,%ecx
  801b1d:	09 f1                	or     %esi,%ecx
  801b1f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b23:	89 f9                	mov    %edi,%ecx
  801b25:	d3 e0                	shl    %cl,%eax
  801b27:	89 c5                	mov    %eax,%ebp
  801b29:	89 d6                	mov    %edx,%esi
  801b2b:	88 d9                	mov    %bl,%cl
  801b2d:	d3 ee                	shr    %cl,%esi
  801b2f:	89 f9                	mov    %edi,%ecx
  801b31:	d3 e2                	shl    %cl,%edx
  801b33:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b37:	88 d9                	mov    %bl,%cl
  801b39:	d3 e8                	shr    %cl,%eax
  801b3b:	09 c2                	or     %eax,%edx
  801b3d:	89 d0                	mov    %edx,%eax
  801b3f:	89 f2                	mov    %esi,%edx
  801b41:	f7 74 24 0c          	divl   0xc(%esp)
  801b45:	89 d6                	mov    %edx,%esi
  801b47:	89 c3                	mov    %eax,%ebx
  801b49:	f7 e5                	mul    %ebp
  801b4b:	39 d6                	cmp    %edx,%esi
  801b4d:	72 19                	jb     801b68 <__udivdi3+0xfc>
  801b4f:	74 0b                	je     801b5c <__udivdi3+0xf0>
  801b51:	89 d8                	mov    %ebx,%eax
  801b53:	31 ff                	xor    %edi,%edi
  801b55:	e9 58 ff ff ff       	jmp    801ab2 <__udivdi3+0x46>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b60:	89 f9                	mov    %edi,%ecx
  801b62:	d3 e2                	shl    %cl,%edx
  801b64:	39 c2                	cmp    %eax,%edx
  801b66:	73 e9                	jae    801b51 <__udivdi3+0xe5>
  801b68:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b6b:	31 ff                	xor    %edi,%edi
  801b6d:	e9 40 ff ff ff       	jmp    801ab2 <__udivdi3+0x46>
  801b72:	66 90                	xchg   %ax,%ax
  801b74:	31 c0                	xor    %eax,%eax
  801b76:	e9 37 ff ff ff       	jmp    801ab2 <__udivdi3+0x46>
  801b7b:	90                   	nop

00801b7c <__umoddi3>:
  801b7c:	55                   	push   %ebp
  801b7d:	57                   	push   %edi
  801b7e:	56                   	push   %esi
  801b7f:	53                   	push   %ebx
  801b80:	83 ec 1c             	sub    $0x1c,%esp
  801b83:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b87:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b8b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b8f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b93:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b97:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b9b:	89 f3                	mov    %esi,%ebx
  801b9d:	89 fa                	mov    %edi,%edx
  801b9f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ba3:	89 34 24             	mov    %esi,(%esp)
  801ba6:	85 c0                	test   %eax,%eax
  801ba8:	75 1a                	jne    801bc4 <__umoddi3+0x48>
  801baa:	39 f7                	cmp    %esi,%edi
  801bac:	0f 86 a2 00 00 00    	jbe    801c54 <__umoddi3+0xd8>
  801bb2:	89 c8                	mov    %ecx,%eax
  801bb4:	89 f2                	mov    %esi,%edx
  801bb6:	f7 f7                	div    %edi
  801bb8:	89 d0                	mov    %edx,%eax
  801bba:	31 d2                	xor    %edx,%edx
  801bbc:	83 c4 1c             	add    $0x1c,%esp
  801bbf:	5b                   	pop    %ebx
  801bc0:	5e                   	pop    %esi
  801bc1:	5f                   	pop    %edi
  801bc2:	5d                   	pop    %ebp
  801bc3:	c3                   	ret    
  801bc4:	39 f0                	cmp    %esi,%eax
  801bc6:	0f 87 ac 00 00 00    	ja     801c78 <__umoddi3+0xfc>
  801bcc:	0f bd e8             	bsr    %eax,%ebp
  801bcf:	83 f5 1f             	xor    $0x1f,%ebp
  801bd2:	0f 84 ac 00 00 00    	je     801c84 <__umoddi3+0x108>
  801bd8:	bf 20 00 00 00       	mov    $0x20,%edi
  801bdd:	29 ef                	sub    %ebp,%edi
  801bdf:	89 fe                	mov    %edi,%esi
  801be1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801be5:	89 e9                	mov    %ebp,%ecx
  801be7:	d3 e0                	shl    %cl,%eax
  801be9:	89 d7                	mov    %edx,%edi
  801beb:	89 f1                	mov    %esi,%ecx
  801bed:	d3 ef                	shr    %cl,%edi
  801bef:	09 c7                	or     %eax,%edi
  801bf1:	89 e9                	mov    %ebp,%ecx
  801bf3:	d3 e2                	shl    %cl,%edx
  801bf5:	89 14 24             	mov    %edx,(%esp)
  801bf8:	89 d8                	mov    %ebx,%eax
  801bfa:	d3 e0                	shl    %cl,%eax
  801bfc:	89 c2                	mov    %eax,%edx
  801bfe:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c02:	d3 e0                	shl    %cl,%eax
  801c04:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c08:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c0c:	89 f1                	mov    %esi,%ecx
  801c0e:	d3 e8                	shr    %cl,%eax
  801c10:	09 d0                	or     %edx,%eax
  801c12:	d3 eb                	shr    %cl,%ebx
  801c14:	89 da                	mov    %ebx,%edx
  801c16:	f7 f7                	div    %edi
  801c18:	89 d3                	mov    %edx,%ebx
  801c1a:	f7 24 24             	mull   (%esp)
  801c1d:	89 c6                	mov    %eax,%esi
  801c1f:	89 d1                	mov    %edx,%ecx
  801c21:	39 d3                	cmp    %edx,%ebx
  801c23:	0f 82 87 00 00 00    	jb     801cb0 <__umoddi3+0x134>
  801c29:	0f 84 91 00 00 00    	je     801cc0 <__umoddi3+0x144>
  801c2f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c33:	29 f2                	sub    %esi,%edx
  801c35:	19 cb                	sbb    %ecx,%ebx
  801c37:	89 d8                	mov    %ebx,%eax
  801c39:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c3d:	d3 e0                	shl    %cl,%eax
  801c3f:	89 e9                	mov    %ebp,%ecx
  801c41:	d3 ea                	shr    %cl,%edx
  801c43:	09 d0                	or     %edx,%eax
  801c45:	89 e9                	mov    %ebp,%ecx
  801c47:	d3 eb                	shr    %cl,%ebx
  801c49:	89 da                	mov    %ebx,%edx
  801c4b:	83 c4 1c             	add    $0x1c,%esp
  801c4e:	5b                   	pop    %ebx
  801c4f:	5e                   	pop    %esi
  801c50:	5f                   	pop    %edi
  801c51:	5d                   	pop    %ebp
  801c52:	c3                   	ret    
  801c53:	90                   	nop
  801c54:	89 fd                	mov    %edi,%ebp
  801c56:	85 ff                	test   %edi,%edi
  801c58:	75 0b                	jne    801c65 <__umoddi3+0xe9>
  801c5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c5f:	31 d2                	xor    %edx,%edx
  801c61:	f7 f7                	div    %edi
  801c63:	89 c5                	mov    %eax,%ebp
  801c65:	89 f0                	mov    %esi,%eax
  801c67:	31 d2                	xor    %edx,%edx
  801c69:	f7 f5                	div    %ebp
  801c6b:	89 c8                	mov    %ecx,%eax
  801c6d:	f7 f5                	div    %ebp
  801c6f:	89 d0                	mov    %edx,%eax
  801c71:	e9 44 ff ff ff       	jmp    801bba <__umoddi3+0x3e>
  801c76:	66 90                	xchg   %ax,%ax
  801c78:	89 c8                	mov    %ecx,%eax
  801c7a:	89 f2                	mov    %esi,%edx
  801c7c:	83 c4 1c             	add    $0x1c,%esp
  801c7f:	5b                   	pop    %ebx
  801c80:	5e                   	pop    %esi
  801c81:	5f                   	pop    %edi
  801c82:	5d                   	pop    %ebp
  801c83:	c3                   	ret    
  801c84:	3b 04 24             	cmp    (%esp),%eax
  801c87:	72 06                	jb     801c8f <__umoddi3+0x113>
  801c89:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c8d:	77 0f                	ja     801c9e <__umoddi3+0x122>
  801c8f:	89 f2                	mov    %esi,%edx
  801c91:	29 f9                	sub    %edi,%ecx
  801c93:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c97:	89 14 24             	mov    %edx,(%esp)
  801c9a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c9e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ca2:	8b 14 24             	mov    (%esp),%edx
  801ca5:	83 c4 1c             	add    $0x1c,%esp
  801ca8:	5b                   	pop    %ebx
  801ca9:	5e                   	pop    %esi
  801caa:	5f                   	pop    %edi
  801cab:	5d                   	pop    %ebp
  801cac:	c3                   	ret    
  801cad:	8d 76 00             	lea    0x0(%esi),%esi
  801cb0:	2b 04 24             	sub    (%esp),%eax
  801cb3:	19 fa                	sbb    %edi,%edx
  801cb5:	89 d1                	mov    %edx,%ecx
  801cb7:	89 c6                	mov    %eax,%esi
  801cb9:	e9 71 ff ff ff       	jmp    801c2f <__umoddi3+0xb3>
  801cbe:	66 90                	xchg   %ax,%ax
  801cc0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cc4:	72 ea                	jb     801cb0 <__umoddi3+0x134>
  801cc6:	89 d9                	mov    %ebx,%ecx
  801cc8:	e9 62 ff ff ff       	jmp    801c2f <__umoddi3+0xb3>
