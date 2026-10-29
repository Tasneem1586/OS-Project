
obj/user/tst_sleeplock_master:     file format elf32-i386


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
  800031:	e8 62 02 00 00       	call   800298 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
#define __AUTOGRADE__ 1

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec fc 00 00 00    	sub    $0xfc,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800044:	83 ec 08             	sub    $0x8,%esp
  800047:	68 40 1f 80 00       	push   $0x801f40
  80004c:	6a 0e                	push   $0xe
  80004e:	e8 a0 07 00 00       	call   8007f3 <cprintf_colored>
  800053:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	68 70 1f 80 00       	push   $0x801f70
  80005e:	6a 0e                	push   $0xe
  800060:	e8 8e 07 00 00       	call   8007f3 <cprintf_colored>
  800065:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	68 40 1f 80 00       	push   $0x801f40
  800070:	6a 0e                	push   $0xe
  800072:	e8 7c 07 00 00       	call   8007f3 <cprintf_colored>
  800077:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  80007a:	e8 fa 18 00 00       	call   801979 <sys_getenvid>
  80007f:	89 45 dc             	mov    %eax,-0x24(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  800082:	c7 45 c8 07 00 00 00 	movl   $0x7,-0x38(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800089:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80008c:	83 ec 08             	sub    $0x8,%esp
  80008f:	50                   	push   %eax
  800090:	68 cc 1f 80 00       	push   $0x801fcc
  800095:	e8 2c 07 00 00       	call   8007c6 <cprintf>
  80009a:	83 c4 10             	add    $0x10,%esp
#else
	readline("Enter the number of Slave Programs: ", slavesCnt);
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif
	//Save number of slaved to be checked later
	char cmd1[64] = "__NumOfSlaves@Set";
  80009d:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000a0:	bb 68 21 80 00       	mov    $0x802168,%ebx
  8000a5:	ba 12 00 00 00       	mov    $0x12,%edx
  8000aa:	89 c7                	mov    %eax,%edi
  8000ac:	89 de                	mov    %ebx,%esi
  8000ae:	89 d1                	mov    %edx,%ecx
  8000b0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000b2:	8d 55 9a             	lea    -0x66(%ebp),%edx
  8000b5:	b9 2e 00 00 00       	mov    $0x2e,%ecx
  8000ba:	b0 00                	mov    $0x0,%al
  8000bc:	89 d7                	mov    %edx,%edi
  8000be:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, (uint32)(&numOfSlaves));
  8000c0:	8d 45 c8             	lea    -0x38(%ebp),%eax
  8000c3:	83 ec 08             	sub    $0x8,%esp
  8000c6:	50                   	push   %eax
  8000c7:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000ca:	50                   	push   %eax
  8000cb:	e8 c2 1a 00 00       	call   801b92 <sys_utilities>
  8000d0:	83 c4 10             	add    $0x10,%esp

	rsttst();
  8000d3:	e8 62 19 00 00       	call   801a3a <rsttst>

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  8000d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000df:	eb 68                	jmp    800149 <_main+0x111>
	{
		id = sys_create_env("tstSleepLockSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e6:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f1:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fc:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800102:	51                   	push   %ecx
  800103:	52                   	push   %edx
  800104:	50                   	push   %eax
  800105:	68 f4 1f 80 00       	push   $0x801ff4
  80010a:	e8 15 18 00 00       	call   801924 <sys_create_env>
  80010f:	83 c4 10             	add    $0x10,%esp
  800112:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  800115:	83 7d d8 ee          	cmpl   $0xffffffee,-0x28(%ebp)
  800119:	75 1d                	jne    800138 <_main+0x100>
		{
			cprintf_colored(TEXT_TESTERR_CLR,"\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  80011b:	83 ec 04             	sub    $0x4,%esp
  80011e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800121:	68 08 20 80 00       	push   $0x802008
  800126:	6a 0c                	push   $0xc
  800128:	e8 c6 06 00 00       	call   8007f3 <cprintf_colored>
  80012d:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  800130:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800133:	89 45 c8             	mov    %eax,-0x38(%ebp)
			break;
  800136:	eb 19                	jmp    800151 <_main+0x119>
		}
		sys_run_env(id);
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	ff 75 d8             	pushl  -0x28(%ebp)
  80013e:	e8 ff 17 00 00       	call   801942 <sys_run_env>
  800143:	83 c4 10             	add    $0x10,%esp

	rsttst();

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  800146:	ff 45 e4             	incl   -0x1c(%ebp)
  800149:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80014c:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  80014f:	7c 90                	jl     8000e1 <_main+0xa9>
		}
		sys_run_env(id);
	}

	//Wait until all slaves, except the one inside C.S., are blocked
	int numOfBlockedProcesses = 0;
  800151:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
	char cmd2[64] = "__GetLockQueueSize__";
  800158:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  80015e:	bb a8 21 80 00       	mov    $0x8021a8,%ebx
  800163:	ba 15 00 00 00       	mov    $0x15,%edx
  800168:	89 c7                	mov    %eax,%edi
  80016a:	89 de                	mov    %ebx,%esi
  80016c:	89 d1                	mov    %edx,%ecx
  80016e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800170:	8d 95 59 ff ff ff    	lea    -0xa7(%ebp),%edx
  800176:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  80017b:	b0 00                	mov    $0x0,%al
  80017d:	89 d7                	mov    %edx,%edi
  80017f:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  800181:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800184:	83 ec 08             	sub    $0x8,%esp
  800187:	50                   	push   %eax
  800188:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  80018e:	50                   	push   %eax
  80018f:	e8 fe 19 00 00       	call   801b92 <sys_utilities>
  800194:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  800197:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (numOfBlockedProcesses != numOfSlaves-1)
  80019e:	eb 77                	jmp    800217 <_main+0x1df>
	{
		env_sleep(5000);
  8001a0:	83 ec 0c             	sub    $0xc,%esp
  8001a3:	68 88 13 00 00       	push   $0x1388
  8001a8:	e8 71 1a 00 00       	call   801c1e <env_sleep>
  8001ad:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  8001b0:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001b3:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  8001b6:	75 1d                	jne    8001d5 <_main+0x19d>
		{
			panic("%~test sleeplock failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves-1, numOfBlockedProcesses);
  8001b8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8001bb:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8001be:	4a                   	dec    %edx
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	50                   	push   %eax
  8001c3:	52                   	push   %edx
  8001c4:	68 60 20 80 00       	push   $0x802060
  8001c9:	6a 34                	push   $0x34
  8001cb:	68 ba 20 80 00       	push   $0x8020ba
  8001d0:	e8 23 03 00 00       	call   8004f8 <_panic>
		}
		char cmd3[64] = "__GetLockQueueSize__";
  8001d5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001db:	bb a8 21 80 00       	mov    $0x8021a8,%ebx
  8001e0:	ba 15 00 00 00       	mov    $0x15,%edx
  8001e5:	89 c7                	mov    %eax,%edi
  8001e7:	89 de                	mov    %ebx,%esi
  8001e9:	89 d1                	mov    %edx,%ecx
  8001eb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001ed:	8d 95 19 ff ff ff    	lea    -0xe7(%ebp),%edx
  8001f3:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8001f8:	b0 00                	mov    $0x0,%al
  8001fa:	89 d7                	mov    %edx,%edi
  8001fc:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
  8001fe:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800201:	83 ec 08             	sub    $0x8,%esp
  800204:	50                   	push   %eax
  800205:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  80020b:	50                   	push   %eax
  80020c:	e8 81 19 00 00       	call   801b92 <sys_utilities>
  800211:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  800214:	ff 45 e0             	incl   -0x20(%ebp)
	//Wait until all slaves, except the one inside C.S., are blocked
	int numOfBlockedProcesses = 0;
	char cmd2[64] = "__GetLockQueueSize__";
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves-1)
  800217:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80021a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80021d:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800220:	39 c2                	cmp    %eax,%edx
  800222:	0f 85 78 ff ff ff    	jne    8001a0 <_main+0x168>
		cnt++ ;
	}
	//cprintf("\numOfBlockedProcesses = %d\n", numOfBlockedProcesses);

	//signal the slave inside the critical section to leave it
	inctst();
  800228:	e8 6d 18 00 00       	call   801a9a <inctst>

	//Wait until all slave finished
	cnt = 0;
  80022d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (gettst() != numOfSlaves +1/*since master already increment it by 1*/)
  800234:	eb 3a                	jmp    800270 <_main+0x238>
	{
		env_sleep(15000);
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	68 98 3a 00 00       	push   $0x3a98
  80023e:	e8 db 19 00 00       	call   801c1e <env_sleep>
  800243:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800246:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800249:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  80024c:	75 1f                	jne    80026d <_main+0x235>
		{
			panic("%~test sleeplock failed! not all processes finished. Expected %d, Actual %d", numOfSlaves +1, gettst());
  80024e:	e8 61 18 00 00       	call   801ab4 <gettst>
  800253:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800256:	42                   	inc    %edx
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	50                   	push   %eax
  80025b:	52                   	push   %edx
  80025c:	68 d8 20 80 00       	push   $0x8020d8
  800261:	6a 46                	push   $0x46
  800263:	68 ba 20 80 00       	push   $0x8020ba
  800268:	e8 8b 02 00 00       	call   8004f8 <_panic>
		}
		cnt++ ;
  80026d:	ff 45 e0             	incl   -0x20(%ebp)
	//signal the slave inside the critical section to leave it
	inctst();

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves +1/*since master already increment it by 1*/)
  800270:	e8 3f 18 00 00       	call   801ab4 <gettst>
  800275:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800278:	42                   	inc    %edx
  800279:	39 d0                	cmp    %edx,%eax
  80027b:	75 b9                	jne    800236 <_main+0x1fe>
			panic("%~test sleeplock failed! not all processes finished. Expected %d, Actual %d", numOfSlaves +1, gettst());
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Sleep Lock completed successfully!!\n\n");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 24 21 80 00       	push   $0x802124
  800285:	6a 0a                	push   $0xa
  800287:	e8 67 05 00 00       	call   8007f3 <cprintf_colored>
  80028c:	83 c4 10             	add    $0x10,%esp
}
  80028f:	90                   	nop
  800290:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800293:	5b                   	pop    %ebx
  800294:	5e                   	pop    %esi
  800295:	5f                   	pop    %edi
  800296:	5d                   	pop    %ebp
  800297:	c3                   	ret    

00800298 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800298:	55                   	push   %ebp
  800299:	89 e5                	mov    %esp,%ebp
  80029b:	57                   	push   %edi
  80029c:	56                   	push   %esi
  80029d:	53                   	push   %ebx
  80029e:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002a4:	e8 e9 16 00 00       	call   801992 <sys_getenvindex>
  8002a9:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002ac:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002af:	89 d0                	mov    %edx,%eax
  8002b1:	c1 e0 03             	shl    $0x3,%eax
  8002b4:	01 d0                	add    %edx,%eax
  8002b6:	c1 e0 06             	shl    $0x6,%eax
  8002b9:	01 d0                	add    %edx,%eax
  8002bb:	c1 e0 03             	shl    $0x3,%eax
  8002be:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002c3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cd:	8a 40 10             	mov    0x10(%eax),%al
  8002d0:	84 c0                	test   %al,%al
  8002d2:	74 0d                	je     8002e1 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d9:	83 c0 10             	add    $0x10,%eax
  8002dc:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002e5:	7e 0a                	jle    8002f1 <libmain+0x59>
		binaryname = argv[0];
  8002e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ea:	8b 00                	mov    (%eax),%eax
  8002ec:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002f1:	83 ec 08             	sub    $0x8,%esp
  8002f4:	ff 75 0c             	pushl  0xc(%ebp)
  8002f7:	ff 75 08             	pushl  0x8(%ebp)
  8002fa:	e8 39 fd ff ff       	call   800038 <_main>
  8002ff:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800302:	a1 00 30 80 00       	mov    0x803000,%eax
  800307:	85 c0                	test   %eax,%eax
  800309:	0f 84 b7 01 00 00    	je     8004c6 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80030f:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800315:	bb 24 23 80 00       	mov    $0x802324,%ebx
  80031a:	ba 0e 00 00 00       	mov    $0xe,%edx
  80031f:	89 c7                	mov    %eax,%edi
  800321:	89 de                	mov    %ebx,%esi
  800323:	89 d1                	mov    %edx,%ecx
  800325:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800327:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80032d:	b9 56 00 00 00       	mov    $0x56,%ecx
  800332:	b0 00                	mov    $0x0,%al
  800334:	89 d7                	mov    %edx,%edi
  800336:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800338:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80033f:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800342:	83 ec 08             	sub    $0x8,%esp
  800345:	50                   	push   %eax
  800346:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80034c:	50                   	push   %eax
  80034d:	e8 40 18 00 00       	call   801b92 <sys_utilities>
  800352:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800355:	e8 c0 13 00 00       	call   80171a <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80035a:	83 ec 0c             	sub    $0xc,%esp
  80035d:	68 00 22 80 00       	push   $0x802200
  800362:	e8 5f 04 00 00       	call   8007c6 <cprintf>
  800367:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80036a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80036d:	85 c0                	test   %eax,%eax
  80036f:	74 58                	je     8003c9 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800371:	e8 3a 18 00 00       	call   801bb0 <sys_get_optimal_num_faults>
  800376:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800379:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80037f:	bb 88 23 80 00       	mov    $0x802388,%ebx
  800384:	ba 11 00 00 00       	mov    $0x11,%edx
  800389:	89 c7                	mov    %eax,%edi
  80038b:	89 de                	mov    %ebx,%esi
  80038d:	89 d1                	mov    %edx,%ecx
  80038f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800391:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800394:	b9 53 00 00 00       	mov    $0x53,%ecx
  800399:	b0 00                	mov    $0x0,%al
  80039b:	89 d7                	mov    %edx,%edi
  80039d:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80039f:	83 ec 08             	sub    $0x8,%esp
  8003a2:	ff 75 dc             	pushl  -0x24(%ebp)
  8003a5:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003ab:	50                   	push   %eax
  8003ac:	e8 e1 17 00 00       	call   801b92 <sys_utilities>
  8003b1:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003b4:	83 ec 08             	sub    $0x8,%esp
  8003b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8003ba:	68 28 22 80 00       	push   $0x802228
  8003bf:	e8 02 04 00 00       	call   8007c6 <cprintf>
  8003c4:	83 c4 10             	add    $0x10,%esp
  8003c7:	eb 59                	jmp    800422 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ce:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d9:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003df:	83 ec 04             	sub    $0x4,%esp
  8003e2:	52                   	push   %edx
  8003e3:	50                   	push   %eax
  8003e4:	68 4c 22 80 00       	push   $0x80224c
  8003e9:	e8 d8 03 00 00       	call   8007c6 <cprintf>
  8003ee:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f6:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800401:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800407:	a1 20 30 80 00       	mov    0x803020,%eax
  80040c:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800412:	51                   	push   %ecx
  800413:	52                   	push   %edx
  800414:	50                   	push   %eax
  800415:	68 74 22 80 00       	push   $0x802274
  80041a:	e8 a7 03 00 00       	call   8007c6 <cprintf>
  80041f:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800422:	a1 20 30 80 00       	mov    0x803020,%eax
  800427:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80042d:	83 ec 08             	sub    $0x8,%esp
  800430:	50                   	push   %eax
  800431:	68 cc 22 80 00       	push   $0x8022cc
  800436:	e8 8b 03 00 00       	call   8007c6 <cprintf>
  80043b:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80043e:	83 ec 0c             	sub    $0xc,%esp
  800441:	68 e0 22 80 00       	push   $0x8022e0
  800446:	e8 7b 03 00 00       	call   8007c6 <cprintf>
  80044b:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80044e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800455:	eb 28                	jmp    80047f <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800457:	a1 20 30 80 00       	mov    0x803020,%eax
  80045c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80045f:	81 c2 74 04 00 00    	add    $0x474,%edx
  800465:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800468:	83 ec 04             	sub    $0x4,%esp
  80046b:	50                   	push   %eax
  80046c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80046f:	68 f7 22 80 00       	push   $0x8022f7
  800474:	e8 4d 03 00 00       	call   8007c6 <cprintf>
  800479:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80047c:	ff 45 e4             	incl   -0x1c(%ebp)
  80047f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800483:	7e d2                	jle    800457 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800485:	83 ec 0c             	sub    $0xc,%esp
  800488:	68 06 23 80 00       	push   $0x802306
  80048d:	e8 34 03 00 00       	call   8007c6 <cprintf>
  800492:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800495:	a1 20 30 80 00       	mov    0x803020,%eax
  80049a:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 0a 23 80 00       	push   $0x80230a
  8004a9:	e8 18 03 00 00       	call   8007c6 <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004b1:	83 ec 0c             	sub    $0xc,%esp
  8004b4:	68 00 22 80 00       	push   $0x802200
  8004b9:	e8 08 03 00 00       	call   8007c6 <cprintf>
  8004be:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004c1:	e8 6e 12 00 00       	call   801734 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004c6:	e8 1f 00 00 00       	call   8004ea <exit>
}
  8004cb:	90                   	nop
  8004cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004cf:	5b                   	pop    %ebx
  8004d0:	5e                   	pop    %esi
  8004d1:	5f                   	pop    %edi
  8004d2:	5d                   	pop    %ebp
  8004d3:	c3                   	ret    

008004d4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004d4:	55                   	push   %ebp
  8004d5:	89 e5                	mov    %esp,%ebp
  8004d7:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004da:	83 ec 0c             	sub    $0xc,%esp
  8004dd:	6a 00                	push   $0x0
  8004df:	e8 7a 14 00 00       	call   80195e <sys_destroy_env>
  8004e4:	83 c4 10             	add    $0x10,%esp
}
  8004e7:	90                   	nop
  8004e8:	c9                   	leave  
  8004e9:	c3                   	ret    

008004ea <exit>:

void
exit(void)
{
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
  8004ed:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004f0:	e8 cf 14 00 00       	call   8019c4 <sys_exit_env>
}
  8004f5:	90                   	nop
  8004f6:	c9                   	leave  
  8004f7:	c3                   	ret    

008004f8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004f8:	55                   	push   %ebp
  8004f9:	89 e5                	mov    %esp,%ebp
  8004fb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004fe:	8d 45 10             	lea    0x10(%ebp),%eax
  800501:	83 c0 04             	add    $0x4,%eax
  800504:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800507:	a1 28 31 80 00       	mov    0x803128,%eax
  80050c:	85 c0                	test   %eax,%eax
  80050e:	74 16                	je     800526 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800510:	a1 28 31 80 00       	mov    0x803128,%eax
  800515:	83 ec 08             	sub    $0x8,%esp
  800518:	50                   	push   %eax
  800519:	68 ec 23 80 00       	push   $0x8023ec
  80051e:	e8 a3 02 00 00       	call   8007c6 <cprintf>
  800523:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800526:	a1 04 30 80 00       	mov    0x803004,%eax
  80052b:	83 ec 0c             	sub    $0xc,%esp
  80052e:	ff 75 0c             	pushl  0xc(%ebp)
  800531:	ff 75 08             	pushl  0x8(%ebp)
  800534:	50                   	push   %eax
  800535:	68 f4 23 80 00       	push   $0x8023f4
  80053a:	6a 74                	push   $0x74
  80053c:	e8 b2 02 00 00       	call   8007f3 <cprintf_colored>
  800541:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800544:	8b 45 10             	mov    0x10(%ebp),%eax
  800547:	83 ec 08             	sub    $0x8,%esp
  80054a:	ff 75 f4             	pushl  -0xc(%ebp)
  80054d:	50                   	push   %eax
  80054e:	e8 04 02 00 00       	call   800757 <vcprintf>
  800553:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800556:	83 ec 08             	sub    $0x8,%esp
  800559:	6a 00                	push   $0x0
  80055b:	68 1c 24 80 00       	push   $0x80241c
  800560:	e8 f2 01 00 00       	call   800757 <vcprintf>
  800565:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800568:	e8 7d ff ff ff       	call   8004ea <exit>

	// should not return here
	while (1) ;
  80056d:	eb fe                	jmp    80056d <_panic+0x75>

0080056f <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80056f:	55                   	push   %ebp
  800570:	89 e5                	mov    %esp,%ebp
  800572:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800575:	a1 20 30 80 00       	mov    0x803020,%eax
  80057a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800580:	8b 45 0c             	mov    0xc(%ebp),%eax
  800583:	39 c2                	cmp    %eax,%edx
  800585:	74 14                	je     80059b <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800587:	83 ec 04             	sub    $0x4,%esp
  80058a:	68 20 24 80 00       	push   $0x802420
  80058f:	6a 26                	push   $0x26
  800591:	68 6c 24 80 00       	push   $0x80246c
  800596:	e8 5d ff ff ff       	call   8004f8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80059b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005a9:	e9 c5 00 00 00       	jmp    800673 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	01 d0                	add    %edx,%eax
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	85 c0                	test   %eax,%eax
  8005c1:	75 08                	jne    8005cb <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005c3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005c6:	e9 a5 00 00 00       	jmp    800670 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005d2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005d9:	eb 69                	jmp    800644 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005db:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e0:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005e9:	89 d0                	mov    %edx,%eax
  8005eb:	01 c0                	add    %eax,%eax
  8005ed:	01 d0                	add    %edx,%eax
  8005ef:	c1 e0 03             	shl    $0x3,%eax
  8005f2:	01 c8                	add    %ecx,%eax
  8005f4:	8a 40 04             	mov    0x4(%eax),%al
  8005f7:	84 c0                	test   %al,%al
  8005f9:	75 46                	jne    800641 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800600:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800606:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800609:	89 d0                	mov    %edx,%eax
  80060b:	01 c0                	add    %eax,%eax
  80060d:	01 d0                	add    %edx,%eax
  80060f:	c1 e0 03             	shl    $0x3,%eax
  800612:	01 c8                	add    %ecx,%eax
  800614:	8b 00                	mov    (%eax),%eax
  800616:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800619:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80061c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800621:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800623:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800626:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	01 c8                	add    %ecx,%eax
  800632:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800634:	39 c2                	cmp    %eax,%edx
  800636:	75 09                	jne    800641 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800638:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80063f:	eb 15                	jmp    800656 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800641:	ff 45 e8             	incl   -0x18(%ebp)
  800644:	a1 20 30 80 00       	mov    0x803020,%eax
  800649:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80064f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800652:	39 c2                	cmp    %eax,%edx
  800654:	77 85                	ja     8005db <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800656:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80065a:	75 14                	jne    800670 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80065c:	83 ec 04             	sub    $0x4,%esp
  80065f:	68 78 24 80 00       	push   $0x802478
  800664:	6a 3a                	push   $0x3a
  800666:	68 6c 24 80 00       	push   $0x80246c
  80066b:	e8 88 fe ff ff       	call   8004f8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800670:	ff 45 f0             	incl   -0x10(%ebp)
  800673:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800676:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800679:	0f 8c 2f ff ff ff    	jl     8005ae <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80067f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800686:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80068d:	eb 26                	jmp    8006b5 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80068f:	a1 20 30 80 00       	mov    0x803020,%eax
  800694:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80069a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80069d:	89 d0                	mov    %edx,%eax
  80069f:	01 c0                	add    %eax,%eax
  8006a1:	01 d0                	add    %edx,%eax
  8006a3:	c1 e0 03             	shl    $0x3,%eax
  8006a6:	01 c8                	add    %ecx,%eax
  8006a8:	8a 40 04             	mov    0x4(%eax),%al
  8006ab:	3c 01                	cmp    $0x1,%al
  8006ad:	75 03                	jne    8006b2 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006af:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006b2:	ff 45 e0             	incl   -0x20(%ebp)
  8006b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ba:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c3:	39 c2                	cmp    %eax,%edx
  8006c5:	77 c8                	ja     80068f <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ca:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006cd:	74 14                	je     8006e3 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006cf:	83 ec 04             	sub    $0x4,%esp
  8006d2:	68 cc 24 80 00       	push   $0x8024cc
  8006d7:	6a 44                	push   $0x44
  8006d9:	68 6c 24 80 00       	push   $0x80246c
  8006de:	e8 15 fe ff ff       	call   8004f8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006e3:	90                   	nop
  8006e4:	c9                   	leave  
  8006e5:	c3                   	ret    

008006e6 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8006e6:	55                   	push   %ebp
  8006e7:	89 e5                	mov    %esp,%ebp
  8006e9:	53                   	push   %ebx
  8006ea:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8006ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	8d 48 01             	lea    0x1(%eax),%ecx
  8006f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006f8:	89 0a                	mov    %ecx,(%edx)
  8006fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8006fd:	88 d1                	mov    %dl,%cl
  8006ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800702:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800706:	8b 45 0c             	mov    0xc(%ebp),%eax
  800709:	8b 00                	mov    (%eax),%eax
  80070b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800710:	75 30                	jne    800742 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800712:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800718:	a0 40 30 80 00       	mov    0x803040,%al
  80071d:	0f b6 c0             	movzbl %al,%eax
  800720:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800723:	8b 09                	mov    (%ecx),%ecx
  800725:	89 cb                	mov    %ecx,%ebx
  800727:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80072a:	83 c1 08             	add    $0x8,%ecx
  80072d:	52                   	push   %edx
  80072e:	50                   	push   %eax
  80072f:	53                   	push   %ebx
  800730:	51                   	push   %ecx
  800731:	e8 a0 0f 00 00       	call   8016d6 <sys_cputs>
  800736:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800739:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800742:	8b 45 0c             	mov    0xc(%ebp),%eax
  800745:	8b 40 04             	mov    0x4(%eax),%eax
  800748:	8d 50 01             	lea    0x1(%eax),%edx
  80074b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800751:	90                   	nop
  800752:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800755:	c9                   	leave  
  800756:	c3                   	ret    

00800757 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800757:	55                   	push   %ebp
  800758:	89 e5                	mov    %esp,%ebp
  80075a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800760:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800767:	00 00 00 
	b.cnt = 0;
  80076a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800771:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	ff 75 08             	pushl  0x8(%ebp)
  80077a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800780:	50                   	push   %eax
  800781:	68 e6 06 80 00       	push   $0x8006e6
  800786:	e8 5a 02 00 00       	call   8009e5 <vprintfmt>
  80078b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80078e:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800794:	a0 40 30 80 00       	mov    0x803040,%al
  800799:	0f b6 c0             	movzbl %al,%eax
  80079c:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8007a2:	52                   	push   %edx
  8007a3:	50                   	push   %eax
  8007a4:	51                   	push   %ecx
  8007a5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007ab:	83 c0 08             	add    $0x8,%eax
  8007ae:	50                   	push   %eax
  8007af:	e8 22 0f 00 00       	call   8016d6 <sys_cputs>
  8007b4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007b7:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007be:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007c4:	c9                   	leave  
  8007c5:	c3                   	ret    

008007c6 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007c6:	55                   	push   %ebp
  8007c7:	89 e5                	mov    %esp,%ebp
  8007c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007cc:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007d3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dc:	83 ec 08             	sub    $0x8,%esp
  8007df:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e2:	50                   	push   %eax
  8007e3:	e8 6f ff ff ff       	call   800757 <vcprintf>
  8007e8:	83 c4 10             	add    $0x10,%esp
  8007eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007f1:	c9                   	leave  
  8007f2:	c3                   	ret    

008007f3 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007f3:	55                   	push   %ebp
  8007f4:	89 e5                	mov    %esp,%ebp
  8007f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007f9:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800800:	8b 45 08             	mov    0x8(%ebp),%eax
  800803:	c1 e0 08             	shl    $0x8,%eax
  800806:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  80080b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80080e:	83 c0 04             	add    $0x4,%eax
  800811:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800814:	8b 45 0c             	mov    0xc(%ebp),%eax
  800817:	83 ec 08             	sub    $0x8,%esp
  80081a:	ff 75 f4             	pushl  -0xc(%ebp)
  80081d:	50                   	push   %eax
  80081e:	e8 34 ff ff ff       	call   800757 <vcprintf>
  800823:	83 c4 10             	add    $0x10,%esp
  800826:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800829:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800830:	07 00 00 

	return cnt;
  800833:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800836:	c9                   	leave  
  800837:	c3                   	ret    

00800838 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800838:	55                   	push   %ebp
  800839:	89 e5                	mov    %esp,%ebp
  80083b:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80083e:	e8 d7 0e 00 00       	call   80171a <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800843:	8d 45 0c             	lea    0xc(%ebp),%eax
  800846:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	ff 75 f4             	pushl  -0xc(%ebp)
  800852:	50                   	push   %eax
  800853:	e8 ff fe ff ff       	call   800757 <vcprintf>
  800858:	83 c4 10             	add    $0x10,%esp
  80085b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80085e:	e8 d1 0e 00 00       	call   801734 <sys_unlock_cons>
	return cnt;
  800863:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800866:	c9                   	leave  
  800867:	c3                   	ret    

00800868 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800868:	55                   	push   %ebp
  800869:	89 e5                	mov    %esp,%ebp
  80086b:	53                   	push   %ebx
  80086c:	83 ec 14             	sub    $0x14,%esp
  80086f:	8b 45 10             	mov    0x10(%ebp),%eax
  800872:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800875:	8b 45 14             	mov    0x14(%ebp),%eax
  800878:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80087b:	8b 45 18             	mov    0x18(%ebp),%eax
  80087e:	ba 00 00 00 00       	mov    $0x0,%edx
  800883:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800886:	77 55                	ja     8008dd <printnum+0x75>
  800888:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80088b:	72 05                	jb     800892 <printnum+0x2a>
  80088d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800890:	77 4b                	ja     8008dd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800892:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800895:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800898:	8b 45 18             	mov    0x18(%ebp),%eax
  80089b:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a0:	52                   	push   %edx
  8008a1:	50                   	push   %eax
  8008a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a5:	ff 75 f0             	pushl  -0x10(%ebp)
  8008a8:	e8 2f 14 00 00       	call   801cdc <__udivdi3>
  8008ad:	83 c4 10             	add    $0x10,%esp
  8008b0:	83 ec 04             	sub    $0x4,%esp
  8008b3:	ff 75 20             	pushl  0x20(%ebp)
  8008b6:	53                   	push   %ebx
  8008b7:	ff 75 18             	pushl  0x18(%ebp)
  8008ba:	52                   	push   %edx
  8008bb:	50                   	push   %eax
  8008bc:	ff 75 0c             	pushl  0xc(%ebp)
  8008bf:	ff 75 08             	pushl  0x8(%ebp)
  8008c2:	e8 a1 ff ff ff       	call   800868 <printnum>
  8008c7:	83 c4 20             	add    $0x20,%esp
  8008ca:	eb 1a                	jmp    8008e6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008cc:	83 ec 08             	sub    $0x8,%esp
  8008cf:	ff 75 0c             	pushl  0xc(%ebp)
  8008d2:	ff 75 20             	pushl  0x20(%ebp)
  8008d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d8:	ff d0                	call   *%eax
  8008da:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008dd:	ff 4d 1c             	decl   0x1c(%ebp)
  8008e0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008e4:	7f e6                	jg     8008cc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008e6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008e9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008f4:	53                   	push   %ebx
  8008f5:	51                   	push   %ecx
  8008f6:	52                   	push   %edx
  8008f7:	50                   	push   %eax
  8008f8:	e8 ef 14 00 00       	call   801dec <__umoddi3>
  8008fd:	83 c4 10             	add    $0x10,%esp
  800900:	05 34 27 80 00       	add    $0x802734,%eax
  800905:	8a 00                	mov    (%eax),%al
  800907:	0f be c0             	movsbl %al,%eax
  80090a:	83 ec 08             	sub    $0x8,%esp
  80090d:	ff 75 0c             	pushl  0xc(%ebp)
  800910:	50                   	push   %eax
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	ff d0                	call   *%eax
  800916:	83 c4 10             	add    $0x10,%esp
}
  800919:	90                   	nop
  80091a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80091d:	c9                   	leave  
  80091e:	c3                   	ret    

0080091f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80091f:	55                   	push   %ebp
  800920:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800922:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800926:	7e 1c                	jle    800944 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	8b 00                	mov    (%eax),%eax
  80092d:	8d 50 08             	lea    0x8(%eax),%edx
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	89 10                	mov    %edx,(%eax)
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	83 e8 08             	sub    $0x8,%eax
  80093d:	8b 50 04             	mov    0x4(%eax),%edx
  800940:	8b 00                	mov    (%eax),%eax
  800942:	eb 40                	jmp    800984 <getuint+0x65>
	else if (lflag)
  800944:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800948:	74 1e                	je     800968 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80094a:	8b 45 08             	mov    0x8(%ebp),%eax
  80094d:	8b 00                	mov    (%eax),%eax
  80094f:	8d 50 04             	lea    0x4(%eax),%edx
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	89 10                	mov    %edx,(%eax)
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	8b 00                	mov    (%eax),%eax
  80095c:	83 e8 04             	sub    $0x4,%eax
  80095f:	8b 00                	mov    (%eax),%eax
  800961:	ba 00 00 00 00       	mov    $0x0,%edx
  800966:	eb 1c                	jmp    800984 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800968:	8b 45 08             	mov    0x8(%ebp),%eax
  80096b:	8b 00                	mov    (%eax),%eax
  80096d:	8d 50 04             	lea    0x4(%eax),%edx
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	89 10                	mov    %edx,(%eax)
  800975:	8b 45 08             	mov    0x8(%ebp),%eax
  800978:	8b 00                	mov    (%eax),%eax
  80097a:	83 e8 04             	sub    $0x4,%eax
  80097d:	8b 00                	mov    (%eax),%eax
  80097f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800984:	5d                   	pop    %ebp
  800985:	c3                   	ret    

00800986 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800986:	55                   	push   %ebp
  800987:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800989:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80098d:	7e 1c                	jle    8009ab <getint+0x25>
		return va_arg(*ap, long long);
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	8b 00                	mov    (%eax),%eax
  800994:	8d 50 08             	lea    0x8(%eax),%edx
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	89 10                	mov    %edx,(%eax)
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	8b 00                	mov    (%eax),%eax
  8009a1:	83 e8 08             	sub    $0x8,%eax
  8009a4:	8b 50 04             	mov    0x4(%eax),%edx
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	eb 38                	jmp    8009e3 <getint+0x5d>
	else if (lflag)
  8009ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009af:	74 1a                	je     8009cb <getint+0x45>
		return va_arg(*ap, long);
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	8b 00                	mov    (%eax),%eax
  8009b6:	8d 50 04             	lea    0x4(%eax),%edx
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	89 10                	mov    %edx,(%eax)
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	8b 00                	mov    (%eax),%eax
  8009c3:	83 e8 04             	sub    $0x4,%eax
  8009c6:	8b 00                	mov    (%eax),%eax
  8009c8:	99                   	cltd   
  8009c9:	eb 18                	jmp    8009e3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ce:	8b 00                	mov    (%eax),%eax
  8009d0:	8d 50 04             	lea    0x4(%eax),%edx
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	89 10                	mov    %edx,(%eax)
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	8b 00                	mov    (%eax),%eax
  8009dd:	83 e8 04             	sub    $0x4,%eax
  8009e0:	8b 00                	mov    (%eax),%eax
  8009e2:	99                   	cltd   
}
  8009e3:	5d                   	pop    %ebp
  8009e4:	c3                   	ret    

008009e5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009e5:	55                   	push   %ebp
  8009e6:	89 e5                	mov    %esp,%ebp
  8009e8:	56                   	push   %esi
  8009e9:	53                   	push   %ebx
  8009ea:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009ed:	eb 17                	jmp    800a06 <vprintfmt+0x21>
			if (ch == '\0')
  8009ef:	85 db                	test   %ebx,%ebx
  8009f1:	0f 84 c1 03 00 00    	je     800db8 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	53                   	push   %ebx
  8009fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800a01:	ff d0                	call   *%eax
  800a03:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a06:	8b 45 10             	mov    0x10(%ebp),%eax
  800a09:	8d 50 01             	lea    0x1(%eax),%edx
  800a0c:	89 55 10             	mov    %edx,0x10(%ebp)
  800a0f:	8a 00                	mov    (%eax),%al
  800a11:	0f b6 d8             	movzbl %al,%ebx
  800a14:	83 fb 25             	cmp    $0x25,%ebx
  800a17:	75 d6                	jne    8009ef <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a19:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a1d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a24:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a2b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a32:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a39:	8b 45 10             	mov    0x10(%ebp),%eax
  800a3c:	8d 50 01             	lea    0x1(%eax),%edx
  800a3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	0f b6 d8             	movzbl %al,%ebx
  800a47:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a4a:	83 f8 5b             	cmp    $0x5b,%eax
  800a4d:	0f 87 3d 03 00 00    	ja     800d90 <vprintfmt+0x3ab>
  800a53:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  800a5a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a5c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a60:	eb d7                	jmp    800a39 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a62:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a66:	eb d1                	jmp    800a39 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a68:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a72:	89 d0                	mov    %edx,%eax
  800a74:	c1 e0 02             	shl    $0x2,%eax
  800a77:	01 d0                	add    %edx,%eax
  800a79:	01 c0                	add    %eax,%eax
  800a7b:	01 d8                	add    %ebx,%eax
  800a7d:	83 e8 30             	sub    $0x30,%eax
  800a80:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a83:	8b 45 10             	mov    0x10(%ebp),%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a8b:	83 fb 2f             	cmp    $0x2f,%ebx
  800a8e:	7e 3e                	jle    800ace <vprintfmt+0xe9>
  800a90:	83 fb 39             	cmp    $0x39,%ebx
  800a93:	7f 39                	jg     800ace <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a95:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a98:	eb d5                	jmp    800a6f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9d:	83 c0 04             	add    $0x4,%eax
  800aa0:	89 45 14             	mov    %eax,0x14(%ebp)
  800aa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa6:	83 e8 04             	sub    $0x4,%eax
  800aa9:	8b 00                	mov    (%eax),%eax
  800aab:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800aae:	eb 1f                	jmp    800acf <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ab0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab4:	79 83                	jns    800a39 <vprintfmt+0x54>
				width = 0;
  800ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800abd:	e9 77 ff ff ff       	jmp    800a39 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ac2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ac9:	e9 6b ff ff ff       	jmp    800a39 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ace:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800acf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad3:	0f 89 60 ff ff ff    	jns    800a39 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ad9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800adc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800adf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ae6:	e9 4e ff ff ff       	jmp    800a39 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800aeb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800aee:	e9 46 ff ff ff       	jmp    800a39 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800af3:	8b 45 14             	mov    0x14(%ebp),%eax
  800af6:	83 c0 04             	add    $0x4,%eax
  800af9:	89 45 14             	mov    %eax,0x14(%ebp)
  800afc:	8b 45 14             	mov    0x14(%ebp),%eax
  800aff:	83 e8 04             	sub    $0x4,%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	83 ec 08             	sub    $0x8,%esp
  800b07:	ff 75 0c             	pushl  0xc(%ebp)
  800b0a:	50                   	push   %eax
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	ff d0                	call   *%eax
  800b10:	83 c4 10             	add    $0x10,%esp
			break;
  800b13:	e9 9b 02 00 00       	jmp    800db3 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b18:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b29:	85 db                	test   %ebx,%ebx
  800b2b:	79 02                	jns    800b2f <vprintfmt+0x14a>
				err = -err;
  800b2d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b2f:	83 fb 64             	cmp    $0x64,%ebx
  800b32:	7f 0b                	jg     800b3f <vprintfmt+0x15a>
  800b34:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800b3b:	85 f6                	test   %esi,%esi
  800b3d:	75 19                	jne    800b58 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b3f:	53                   	push   %ebx
  800b40:	68 45 27 80 00       	push   $0x802745
  800b45:	ff 75 0c             	pushl  0xc(%ebp)
  800b48:	ff 75 08             	pushl  0x8(%ebp)
  800b4b:	e8 70 02 00 00       	call   800dc0 <printfmt>
  800b50:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b53:	e9 5b 02 00 00       	jmp    800db3 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b58:	56                   	push   %esi
  800b59:	68 4e 27 80 00       	push   $0x80274e
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	ff 75 08             	pushl  0x8(%ebp)
  800b64:	e8 57 02 00 00       	call   800dc0 <printfmt>
  800b69:	83 c4 10             	add    $0x10,%esp
			break;
  800b6c:	e9 42 02 00 00       	jmp    800db3 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b71:	8b 45 14             	mov    0x14(%ebp),%eax
  800b74:	83 c0 04             	add    $0x4,%eax
  800b77:	89 45 14             	mov    %eax,0x14(%ebp)
  800b7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7d:	83 e8 04             	sub    $0x4,%eax
  800b80:	8b 30                	mov    (%eax),%esi
  800b82:	85 f6                	test   %esi,%esi
  800b84:	75 05                	jne    800b8b <vprintfmt+0x1a6>
				p = "(null)";
  800b86:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800b8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b8f:	7e 6d                	jle    800bfe <vprintfmt+0x219>
  800b91:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b95:	74 67                	je     800bfe <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b9a:	83 ec 08             	sub    $0x8,%esp
  800b9d:	50                   	push   %eax
  800b9e:	56                   	push   %esi
  800b9f:	e8 1e 03 00 00       	call   800ec2 <strnlen>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800baa:	eb 16                	jmp    800bc2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bac:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bb0:	83 ec 08             	sub    $0x8,%esp
  800bb3:	ff 75 0c             	pushl  0xc(%ebp)
  800bb6:	50                   	push   %eax
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	ff d0                	call   *%eax
  800bbc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bbf:	ff 4d e4             	decl   -0x1c(%ebp)
  800bc2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bc6:	7f e4                	jg     800bac <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bc8:	eb 34                	jmp    800bfe <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bca:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bce:	74 1c                	je     800bec <vprintfmt+0x207>
  800bd0:	83 fb 1f             	cmp    $0x1f,%ebx
  800bd3:	7e 05                	jle    800bda <vprintfmt+0x1f5>
  800bd5:	83 fb 7e             	cmp    $0x7e,%ebx
  800bd8:	7e 12                	jle    800bec <vprintfmt+0x207>
					putch('?', putdat);
  800bda:	83 ec 08             	sub    $0x8,%esp
  800bdd:	ff 75 0c             	pushl  0xc(%ebp)
  800be0:	6a 3f                	push   $0x3f
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	ff d0                	call   *%eax
  800be7:	83 c4 10             	add    $0x10,%esp
  800bea:	eb 0f                	jmp    800bfb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bec:	83 ec 08             	sub    $0x8,%esp
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	53                   	push   %ebx
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	ff d0                	call   *%eax
  800bf8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bfb:	ff 4d e4             	decl   -0x1c(%ebp)
  800bfe:	89 f0                	mov    %esi,%eax
  800c00:	8d 70 01             	lea    0x1(%eax),%esi
  800c03:	8a 00                	mov    (%eax),%al
  800c05:	0f be d8             	movsbl %al,%ebx
  800c08:	85 db                	test   %ebx,%ebx
  800c0a:	74 24                	je     800c30 <vprintfmt+0x24b>
  800c0c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c10:	78 b8                	js     800bca <vprintfmt+0x1e5>
  800c12:	ff 4d e0             	decl   -0x20(%ebp)
  800c15:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c19:	79 af                	jns    800bca <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c1b:	eb 13                	jmp    800c30 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c1d:	83 ec 08             	sub    $0x8,%esp
  800c20:	ff 75 0c             	pushl  0xc(%ebp)
  800c23:	6a 20                	push   $0x20
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	ff d0                	call   *%eax
  800c2a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800c30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c34:	7f e7                	jg     800c1d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c36:	e9 78 01 00 00       	jmp    800db3 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c3b:	83 ec 08             	sub    $0x8,%esp
  800c3e:	ff 75 e8             	pushl  -0x18(%ebp)
  800c41:	8d 45 14             	lea    0x14(%ebp),%eax
  800c44:	50                   	push   %eax
  800c45:	e8 3c fd ff ff       	call   800986 <getint>
  800c4a:	83 c4 10             	add    $0x10,%esp
  800c4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c50:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c56:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c59:	85 d2                	test   %edx,%edx
  800c5b:	79 23                	jns    800c80 <vprintfmt+0x29b>
				putch('-', putdat);
  800c5d:	83 ec 08             	sub    $0x8,%esp
  800c60:	ff 75 0c             	pushl  0xc(%ebp)
  800c63:	6a 2d                	push   $0x2d
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	ff d0                	call   *%eax
  800c6a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c73:	f7 d8                	neg    %eax
  800c75:	83 d2 00             	adc    $0x0,%edx
  800c78:	f7 da                	neg    %edx
  800c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c80:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c87:	e9 bc 00 00 00       	jmp    800d48 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c8c:	83 ec 08             	sub    $0x8,%esp
  800c8f:	ff 75 e8             	pushl  -0x18(%ebp)
  800c92:	8d 45 14             	lea    0x14(%ebp),%eax
  800c95:	50                   	push   %eax
  800c96:	e8 84 fc ff ff       	call   80091f <getuint>
  800c9b:	83 c4 10             	add    $0x10,%esp
  800c9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ca4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cab:	e9 98 00 00 00       	jmp    800d48 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cb0:	83 ec 08             	sub    $0x8,%esp
  800cb3:	ff 75 0c             	pushl  0xc(%ebp)
  800cb6:	6a 58                	push   $0x58
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	ff d0                	call   *%eax
  800cbd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cc0:	83 ec 08             	sub    $0x8,%esp
  800cc3:	ff 75 0c             	pushl  0xc(%ebp)
  800cc6:	6a 58                	push   $0x58
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	ff d0                	call   *%eax
  800ccd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cd0:	83 ec 08             	sub    $0x8,%esp
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	6a 58                	push   $0x58
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	ff d0                	call   *%eax
  800cdd:	83 c4 10             	add    $0x10,%esp
			break;
  800ce0:	e9 ce 00 00 00       	jmp    800db3 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800ce5:	83 ec 08             	sub    $0x8,%esp
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	6a 30                	push   $0x30
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	ff d0                	call   *%eax
  800cf2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	6a 78                	push   $0x78
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	ff d0                	call   *%eax
  800d02:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d05:	8b 45 14             	mov    0x14(%ebp),%eax
  800d08:	83 c0 04             	add    $0x4,%eax
  800d0b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d11:	83 e8 04             	sub    $0x4,%eax
  800d14:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d20:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d27:	eb 1f                	jmp    800d48 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d29:	83 ec 08             	sub    $0x8,%esp
  800d2c:	ff 75 e8             	pushl  -0x18(%ebp)
  800d2f:	8d 45 14             	lea    0x14(%ebp),%eax
  800d32:	50                   	push   %eax
  800d33:	e8 e7 fb ff ff       	call   80091f <getuint>
  800d38:	83 c4 10             	add    $0x10,%esp
  800d3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d41:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d48:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d4f:	83 ec 04             	sub    $0x4,%esp
  800d52:	52                   	push   %edx
  800d53:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d56:	50                   	push   %eax
  800d57:	ff 75 f4             	pushl  -0xc(%ebp)
  800d5a:	ff 75 f0             	pushl  -0x10(%ebp)
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	ff 75 08             	pushl  0x8(%ebp)
  800d63:	e8 00 fb ff ff       	call   800868 <printnum>
  800d68:	83 c4 20             	add    $0x20,%esp
			break;
  800d6b:	eb 46                	jmp    800db3 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d6d:	83 ec 08             	sub    $0x8,%esp
  800d70:	ff 75 0c             	pushl  0xc(%ebp)
  800d73:	53                   	push   %ebx
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	ff d0                	call   *%eax
  800d79:	83 c4 10             	add    $0x10,%esp
			break;
  800d7c:	eb 35                	jmp    800db3 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d7e:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d85:	eb 2c                	jmp    800db3 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d87:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d8e:	eb 23                	jmp    800db3 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	6a 25                	push   $0x25
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800da0:	ff 4d 10             	decl   0x10(%ebp)
  800da3:	eb 03                	jmp    800da8 <vprintfmt+0x3c3>
  800da5:	ff 4d 10             	decl   0x10(%ebp)
  800da8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dab:	48                   	dec    %eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	3c 25                	cmp    $0x25,%al
  800db0:	75 f3                	jne    800da5 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800db2:	90                   	nop
		}
	}
  800db3:	e9 35 fc ff ff       	jmp    8009ed <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800db8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800db9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dbc:	5b                   	pop    %ebx
  800dbd:	5e                   	pop    %esi
  800dbe:	5d                   	pop    %ebp
  800dbf:	c3                   	ret    

00800dc0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dc0:	55                   	push   %ebp
  800dc1:	89 e5                	mov    %esp,%ebp
  800dc3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dc6:	8d 45 10             	lea    0x10(%ebp),%eax
  800dc9:	83 c0 04             	add    $0x4,%eax
  800dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd2:	ff 75 f4             	pushl  -0xc(%ebp)
  800dd5:	50                   	push   %eax
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	ff 75 08             	pushl  0x8(%ebp)
  800ddc:	e8 04 fc ff ff       	call   8009e5 <vprintfmt>
  800de1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800de4:	90                   	nop
  800de5:	c9                   	leave  
  800de6:	c3                   	ret    

00800de7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ded:	8b 40 08             	mov    0x8(%eax),%eax
  800df0:	8d 50 01             	lea    0x1(%eax),%edx
  800df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfc:	8b 10                	mov    (%eax),%edx
  800dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e01:	8b 40 04             	mov    0x4(%eax),%eax
  800e04:	39 c2                	cmp    %eax,%edx
  800e06:	73 12                	jae    800e1a <sprintputch+0x33>
		*b->buf++ = ch;
  800e08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	8d 48 01             	lea    0x1(%eax),%ecx
  800e10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e13:	89 0a                	mov    %ecx,(%edx)
  800e15:	8b 55 08             	mov    0x8(%ebp),%edx
  800e18:	88 10                	mov    %dl,(%eax)
}
  800e1a:	90                   	nop
  800e1b:	5d                   	pop    %ebp
  800e1c:	c3                   	ret    

00800e1d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e1d:	55                   	push   %ebp
  800e1e:	89 e5                	mov    %esp,%ebp
  800e20:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	01 d0                	add    %edx,%eax
  800e34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e3e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e42:	74 06                	je     800e4a <vsnprintf+0x2d>
  800e44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e48:	7f 07                	jg     800e51 <vsnprintf+0x34>
		return -E_INVAL;
  800e4a:	b8 03 00 00 00       	mov    $0x3,%eax
  800e4f:	eb 20                	jmp    800e71 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e51:	ff 75 14             	pushl  0x14(%ebp)
  800e54:	ff 75 10             	pushl  0x10(%ebp)
  800e57:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e5a:	50                   	push   %eax
  800e5b:	68 e7 0d 80 00       	push   $0x800de7
  800e60:	e8 80 fb ff ff       	call   8009e5 <vprintfmt>
  800e65:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e68:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e6b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e71:	c9                   	leave  
  800e72:	c3                   	ret    

00800e73 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e73:	55                   	push   %ebp
  800e74:	89 e5                	mov    %esp,%ebp
  800e76:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e79:	8d 45 10             	lea    0x10(%ebp),%eax
  800e7c:	83 c0 04             	add    $0x4,%eax
  800e7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e82:	8b 45 10             	mov    0x10(%ebp),%eax
  800e85:	ff 75 f4             	pushl  -0xc(%ebp)
  800e88:	50                   	push   %eax
  800e89:	ff 75 0c             	pushl  0xc(%ebp)
  800e8c:	ff 75 08             	pushl  0x8(%ebp)
  800e8f:	e8 89 ff ff ff       	call   800e1d <vsnprintf>
  800e94:	83 c4 10             	add    $0x10,%esp
  800e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e9d:	c9                   	leave  
  800e9e:	c3                   	ret    

00800e9f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e9f:	55                   	push   %ebp
  800ea0:	89 e5                	mov    %esp,%ebp
  800ea2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ea5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eac:	eb 06                	jmp    800eb4 <strlen+0x15>
		n++;
  800eae:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800eb1:	ff 45 08             	incl   0x8(%ebp)
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	8a 00                	mov    (%eax),%al
  800eb9:	84 c0                	test   %al,%al
  800ebb:	75 f1                	jne    800eae <strlen+0xf>
		n++;
	return n;
  800ebd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ec0:	c9                   	leave  
  800ec1:	c3                   	ret    

00800ec2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ec2:	55                   	push   %ebp
  800ec3:	89 e5                	mov    %esp,%ebp
  800ec5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ec8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ecf:	eb 09                	jmp    800eda <strnlen+0x18>
		n++;
  800ed1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ed4:	ff 45 08             	incl   0x8(%ebp)
  800ed7:	ff 4d 0c             	decl   0xc(%ebp)
  800eda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ede:	74 09                	je     800ee9 <strnlen+0x27>
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	84 c0                	test   %al,%al
  800ee7:	75 e8                	jne    800ed1 <strnlen+0xf>
		n++;
	return n;
  800ee9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eec:	c9                   	leave  
  800eed:	c3                   	ret    

00800eee <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800eee:	55                   	push   %ebp
  800eef:	89 e5                	mov    %esp,%ebp
  800ef1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800efa:	90                   	nop
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8d 50 01             	lea    0x1(%eax),%edx
  800f01:	89 55 08             	mov    %edx,0x8(%ebp)
  800f04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f07:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f0a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f0d:	8a 12                	mov    (%edx),%dl
  800f0f:	88 10                	mov    %dl,(%eax)
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	84 c0                	test   %al,%al
  800f15:	75 e4                	jne    800efb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f17:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f1a:	c9                   	leave  
  800f1b:	c3                   	ret    

00800f1c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f1c:	55                   	push   %ebp
  800f1d:	89 e5                	mov    %esp,%ebp
  800f1f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f2f:	eb 1f                	jmp    800f50 <strncpy+0x34>
		*dst++ = *src;
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8d 50 01             	lea    0x1(%eax),%edx
  800f37:	89 55 08             	mov    %edx,0x8(%ebp)
  800f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3d:	8a 12                	mov    (%edx),%dl
  800f3f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	84 c0                	test   %al,%al
  800f48:	74 03                	je     800f4d <strncpy+0x31>
			src++;
  800f4a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f4d:	ff 45 fc             	incl   -0x4(%ebp)
  800f50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f53:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f56:	72 d9                	jb     800f31 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f58:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f5b:	c9                   	leave  
  800f5c:	c3                   	ret    

00800f5d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f5d:	55                   	push   %ebp
  800f5e:	89 e5                	mov    %esp,%ebp
  800f60:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6d:	74 30                	je     800f9f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f6f:	eb 16                	jmp    800f87 <strlcpy+0x2a>
			*dst++ = *src++;
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8d 50 01             	lea    0x1(%eax),%edx
  800f77:	89 55 08             	mov    %edx,0x8(%ebp)
  800f7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f80:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f83:	8a 12                	mov    (%edx),%dl
  800f85:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f87:	ff 4d 10             	decl   0x10(%ebp)
  800f8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8e:	74 09                	je     800f99 <strlcpy+0x3c>
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	84 c0                	test   %al,%al
  800f97:	75 d8                	jne    800f71 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa5:	29 c2                	sub    %eax,%edx
  800fa7:	89 d0                	mov    %edx,%eax
}
  800fa9:	c9                   	leave  
  800faa:	c3                   	ret    

00800fab <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fab:	55                   	push   %ebp
  800fac:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fae:	eb 06                	jmp    800fb6 <strcmp+0xb>
		p++, q++;
  800fb0:	ff 45 08             	incl   0x8(%ebp)
  800fb3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	84 c0                	test   %al,%al
  800fbd:	74 0e                	je     800fcd <strcmp+0x22>
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	8a 10                	mov    (%eax),%dl
  800fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	38 c2                	cmp    %al,%dl
  800fcb:	74 e3                	je     800fb0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	0f b6 d0             	movzbl %al,%edx
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	0f b6 c0             	movzbl %al,%eax
  800fdd:	29 c2                	sub    %eax,%edx
  800fdf:	89 d0                	mov    %edx,%eax
}
  800fe1:	5d                   	pop    %ebp
  800fe2:	c3                   	ret    

00800fe3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fe3:	55                   	push   %ebp
  800fe4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fe6:	eb 09                	jmp    800ff1 <strncmp+0xe>
		n--, p++, q++;
  800fe8:	ff 4d 10             	decl   0x10(%ebp)
  800feb:	ff 45 08             	incl   0x8(%ebp)
  800fee:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ff1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff5:	74 17                	je     80100e <strncmp+0x2b>
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	84 c0                	test   %al,%al
  800ffe:	74 0e                	je     80100e <strncmp+0x2b>
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
  801003:	8a 10                	mov    (%eax),%dl
  801005:	8b 45 0c             	mov    0xc(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	38 c2                	cmp    %al,%dl
  80100c:	74 da                	je     800fe8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80100e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801012:	75 07                	jne    80101b <strncmp+0x38>
		return 0;
  801014:	b8 00 00 00 00       	mov    $0x0,%eax
  801019:	eb 14                	jmp    80102f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	0f b6 d0             	movzbl %al,%edx
  801023:	8b 45 0c             	mov    0xc(%ebp),%eax
  801026:	8a 00                	mov    (%eax),%al
  801028:	0f b6 c0             	movzbl %al,%eax
  80102b:	29 c2                	sub    %eax,%edx
  80102d:	89 d0                	mov    %edx,%eax
}
  80102f:	5d                   	pop    %ebp
  801030:	c3                   	ret    

00801031 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
  801034:	83 ec 04             	sub    $0x4,%esp
  801037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80103d:	eb 12                	jmp    801051 <strchr+0x20>
		if (*s == c)
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801047:	75 05                	jne    80104e <strchr+0x1d>
			return (char *) s;
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	eb 11                	jmp    80105f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80104e:	ff 45 08             	incl   0x8(%ebp)
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8a 00                	mov    (%eax),%al
  801056:	84 c0                	test   %al,%al
  801058:	75 e5                	jne    80103f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80105a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 04             	sub    $0x4,%esp
  801067:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80106d:	eb 0d                	jmp    80107c <strfind+0x1b>
		if (*s == c)
  80106f:	8b 45 08             	mov    0x8(%ebp),%eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801077:	74 0e                	je     801087 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801079:	ff 45 08             	incl   0x8(%ebp)
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	8a 00                	mov    (%eax),%al
  801081:	84 c0                	test   %al,%al
  801083:	75 ea                	jne    80106f <strfind+0xe>
  801085:	eb 01                	jmp    801088 <strfind+0x27>
		if (*s == c)
			break;
  801087:	90                   	nop
	return (char *) s;
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
  801090:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801099:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80109d:	76 63                	jbe    801102 <memset+0x75>
		uint64 data_block = c;
  80109f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a2:	99                   	cltd   
  8010a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8010a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010af:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010b3:	c1 e0 08             	shl    $0x8,%eax
  8010b6:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010b9:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c2:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010c6:	c1 e0 10             	shl    $0x10,%eax
  8010c9:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010cc:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d5:	89 c2                	mov    %eax,%edx
  8010d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8010dc:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010df:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8010e2:	eb 18                	jmp    8010fc <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8010e4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010e7:	8d 41 08             	lea    0x8(%ecx),%eax
  8010ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8010ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f3:	89 01                	mov    %eax,(%ecx)
  8010f5:	89 51 04             	mov    %edx,0x4(%ecx)
  8010f8:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8010fc:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801100:	77 e2                	ja     8010e4 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801102:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801106:	74 23                	je     80112b <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801108:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80110b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  80110e:	eb 0e                	jmp    80111e <memset+0x91>
			*p8++ = (uint8)c;
  801110:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801113:	8d 50 01             	lea    0x1(%eax),%edx
  801116:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801119:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111c:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80111e:	8b 45 10             	mov    0x10(%ebp),%eax
  801121:	8d 50 ff             	lea    -0x1(%eax),%edx
  801124:	89 55 10             	mov    %edx,0x10(%ebp)
  801127:	85 c0                	test   %eax,%eax
  801129:	75 e5                	jne    801110 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801136:	8b 45 0c             	mov    0xc(%ebp),%eax
  801139:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801142:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801146:	76 24                	jbe    80116c <memcpy+0x3c>
		while(n >= 8){
  801148:	eb 1c                	jmp    801166 <memcpy+0x36>
			*d64 = *s64;
  80114a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114d:	8b 50 04             	mov    0x4(%eax),%edx
  801150:	8b 00                	mov    (%eax),%eax
  801152:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801155:	89 01                	mov    %eax,(%ecx)
  801157:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80115a:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80115e:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801162:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801166:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80116a:	77 de                	ja     80114a <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80116c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801170:	74 31                	je     8011a3 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801172:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801175:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801178:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80117e:	eb 16                	jmp    801196 <memcpy+0x66>
			*d8++ = *s8++;
  801180:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801183:	8d 50 01             	lea    0x1(%eax),%edx
  801186:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801189:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80118c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80118f:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801192:	8a 12                	mov    (%edx),%dl
  801194:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801196:	8b 45 10             	mov    0x10(%ebp),%eax
  801199:	8d 50 ff             	lea    -0x1(%eax),%edx
  80119c:	89 55 10             	mov    %edx,0x10(%ebp)
  80119f:	85 c0                	test   %eax,%eax
  8011a1:	75 dd                	jne    801180 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8011a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
  8011ab:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011bd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011c0:	73 50                	jae    801212 <memmove+0x6a>
  8011c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c8:	01 d0                	add    %edx,%eax
  8011ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011cd:	76 43                	jbe    801212 <memmove+0x6a>
		s += n;
  8011cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011db:	eb 10                	jmp    8011ed <memmove+0x45>
			*--d = *--s;
  8011dd:	ff 4d f8             	decl   -0x8(%ebp)
  8011e0:	ff 4d fc             	decl   -0x4(%ebp)
  8011e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e6:	8a 10                	mov    (%eax),%dl
  8011e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011eb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8011f6:	85 c0                	test   %eax,%eax
  8011f8:	75 e3                	jne    8011dd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011fa:	eb 23                	jmp    80121f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ff:	8d 50 01             	lea    0x1(%eax),%edx
  801202:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801205:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801208:	8d 4a 01             	lea    0x1(%edx),%ecx
  80120b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80120e:	8a 12                	mov    (%edx),%dl
  801210:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801212:	8b 45 10             	mov    0x10(%ebp),%eax
  801215:	8d 50 ff             	lea    -0x1(%eax),%edx
  801218:	89 55 10             	mov    %edx,0x10(%ebp)
  80121b:	85 c0                	test   %eax,%eax
  80121d:	75 dd                	jne    8011fc <memmove+0x54>
			*d++ = *s++;

	return dst;
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801230:	8b 45 0c             	mov    0xc(%ebp),%eax
  801233:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801236:	eb 2a                	jmp    801262 <memcmp+0x3e>
		if (*s1 != *s2)
  801238:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123b:	8a 10                	mov    (%eax),%dl
  80123d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	38 c2                	cmp    %al,%dl
  801244:	74 16                	je     80125c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801246:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	0f b6 d0             	movzbl %al,%edx
  80124e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	0f b6 c0             	movzbl %al,%eax
  801256:	29 c2                	sub    %eax,%edx
  801258:	89 d0                	mov    %edx,%eax
  80125a:	eb 18                	jmp    801274 <memcmp+0x50>
		s1++, s2++;
  80125c:	ff 45 fc             	incl   -0x4(%ebp)
  80125f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801262:	8b 45 10             	mov    0x10(%ebp),%eax
  801265:	8d 50 ff             	lea    -0x1(%eax),%edx
  801268:	89 55 10             	mov    %edx,0x10(%ebp)
  80126b:	85 c0                	test   %eax,%eax
  80126d:	75 c9                	jne    801238 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80126f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801274:	c9                   	leave  
  801275:	c3                   	ret    

00801276 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
  801279:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80127c:	8b 55 08             	mov    0x8(%ebp),%edx
  80127f:	8b 45 10             	mov    0x10(%ebp),%eax
  801282:	01 d0                	add    %edx,%eax
  801284:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801287:	eb 15                	jmp    80129e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	0f b6 d0             	movzbl %al,%edx
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	0f b6 c0             	movzbl %al,%eax
  801297:	39 c2                	cmp    %eax,%edx
  801299:	74 0d                	je     8012a8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80129b:	ff 45 08             	incl   0x8(%ebp)
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012a4:	72 e3                	jb     801289 <memfind+0x13>
  8012a6:	eb 01                	jmp    8012a9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012a8:	90                   	nop
	return (void *) s;
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012c2:	eb 03                	jmp    8012c7 <strtol+0x19>
		s++;
  8012c4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	8a 00                	mov    (%eax),%al
  8012cc:	3c 20                	cmp    $0x20,%al
  8012ce:	74 f4                	je     8012c4 <strtol+0x16>
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	8a 00                	mov    (%eax),%al
  8012d5:	3c 09                	cmp    $0x9,%al
  8012d7:	74 eb                	je     8012c4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	8a 00                	mov    (%eax),%al
  8012de:	3c 2b                	cmp    $0x2b,%al
  8012e0:	75 05                	jne    8012e7 <strtol+0x39>
		s++;
  8012e2:	ff 45 08             	incl   0x8(%ebp)
  8012e5:	eb 13                	jmp    8012fa <strtol+0x4c>
	else if (*s == '-')
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	3c 2d                	cmp    $0x2d,%al
  8012ee:	75 0a                	jne    8012fa <strtol+0x4c>
		s++, neg = 1;
  8012f0:	ff 45 08             	incl   0x8(%ebp)
  8012f3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012fe:	74 06                	je     801306 <strtol+0x58>
  801300:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801304:	75 20                	jne    801326 <strtol+0x78>
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	3c 30                	cmp    $0x30,%al
  80130d:	75 17                	jne    801326 <strtol+0x78>
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	40                   	inc    %eax
  801313:	8a 00                	mov    (%eax),%al
  801315:	3c 78                	cmp    $0x78,%al
  801317:	75 0d                	jne    801326 <strtol+0x78>
		s += 2, base = 16;
  801319:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80131d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801324:	eb 28                	jmp    80134e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801326:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80132a:	75 15                	jne    801341 <strtol+0x93>
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	8a 00                	mov    (%eax),%al
  801331:	3c 30                	cmp    $0x30,%al
  801333:	75 0c                	jne    801341 <strtol+0x93>
		s++, base = 8;
  801335:	ff 45 08             	incl   0x8(%ebp)
  801338:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80133f:	eb 0d                	jmp    80134e <strtol+0xa0>
	else if (base == 0)
  801341:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801345:	75 07                	jne    80134e <strtol+0xa0>
		base = 10;
  801347:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	3c 2f                	cmp    $0x2f,%al
  801355:	7e 19                	jle    801370 <strtol+0xc2>
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	3c 39                	cmp    $0x39,%al
  80135e:	7f 10                	jg     801370 <strtol+0xc2>
			dig = *s - '0';
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	0f be c0             	movsbl %al,%eax
  801368:	83 e8 30             	sub    $0x30,%eax
  80136b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80136e:	eb 42                	jmp    8013b2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 00                	mov    (%eax),%al
  801375:	3c 60                	cmp    $0x60,%al
  801377:	7e 19                	jle    801392 <strtol+0xe4>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	3c 7a                	cmp    $0x7a,%al
  801380:	7f 10                	jg     801392 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	0f be c0             	movsbl %al,%eax
  80138a:	83 e8 57             	sub    $0x57,%eax
  80138d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801390:	eb 20                	jmp    8013b2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	3c 40                	cmp    $0x40,%al
  801399:	7e 39                	jle    8013d4 <strtol+0x126>
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8a 00                	mov    (%eax),%al
  8013a0:	3c 5a                	cmp    $0x5a,%al
  8013a2:	7f 30                	jg     8013d4 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f be c0             	movsbl %al,%eax
  8013ac:	83 e8 37             	sub    $0x37,%eax
  8013af:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013b8:	7d 19                	jge    8013d3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013ba:	ff 45 08             	incl   0x8(%ebp)
  8013bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013c4:	89 c2                	mov    %eax,%edx
  8013c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013c9:	01 d0                	add    %edx,%eax
  8013cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013ce:	e9 7b ff ff ff       	jmp    80134e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013d3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013d8:	74 08                	je     8013e2 <strtol+0x134>
		*endptr = (char *) s;
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	8b 55 08             	mov    0x8(%ebp),%edx
  8013e0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013e6:	74 07                	je     8013ef <strtol+0x141>
  8013e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013eb:	f7 d8                	neg    %eax
  8013ed:	eb 03                	jmp    8013f2 <strtol+0x144>
  8013ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <ltostr>:

void
ltostr(long value, char *str)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
  8013f7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801401:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801408:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80140c:	79 13                	jns    801421 <ltostr+0x2d>
	{
		neg = 1;
  80140e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801415:	8b 45 0c             	mov    0xc(%ebp),%eax
  801418:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80141b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80141e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801429:	99                   	cltd   
  80142a:	f7 f9                	idiv   %ecx
  80142c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80142f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801432:	8d 50 01             	lea    0x1(%eax),%edx
  801435:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801438:	89 c2                	mov    %eax,%edx
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	01 d0                	add    %edx,%eax
  80143f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801442:	83 c2 30             	add    $0x30,%edx
  801445:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801447:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80144a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80144f:	f7 e9                	imul   %ecx
  801451:	c1 fa 02             	sar    $0x2,%edx
  801454:	89 c8                	mov    %ecx,%eax
  801456:	c1 f8 1f             	sar    $0x1f,%eax
  801459:	29 c2                	sub    %eax,%edx
  80145b:	89 d0                	mov    %edx,%eax
  80145d:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801460:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801464:	75 bb                	jne    801421 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801466:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80146d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801470:	48                   	dec    %eax
  801471:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801474:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801478:	74 3d                	je     8014b7 <ltostr+0xc3>
		start = 1 ;
  80147a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801481:	eb 34                	jmp    8014b7 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801483:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801486:	8b 45 0c             	mov    0xc(%ebp),%eax
  801489:	01 d0                	add    %edx,%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801490:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801493:	8b 45 0c             	mov    0xc(%ebp),%eax
  801496:	01 c2                	add    %eax,%edx
  801498:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80149b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149e:	01 c8                	add    %ecx,%eax
  8014a0:	8a 00                	mov    (%eax),%al
  8014a2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014aa:	01 c2                	add    %eax,%edx
  8014ac:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014af:	88 02                	mov    %al,(%edx)
		start++ ;
  8014b1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014b4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014bd:	7c c4                	jl     801483 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c5:	01 d0                	add    %edx,%eax
  8014c7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014ca:	90                   	nop
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014d3:	ff 75 08             	pushl  0x8(%ebp)
  8014d6:	e8 c4 f9 ff ff       	call   800e9f <strlen>
  8014db:	83 c4 04             	add    $0x4,%esp
  8014de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014e1:	ff 75 0c             	pushl  0xc(%ebp)
  8014e4:	e8 b6 f9 ff ff       	call   800e9f <strlen>
  8014e9:	83 c4 04             	add    $0x4,%esp
  8014ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014fd:	eb 17                	jmp    801516 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801502:	8b 45 10             	mov    0x10(%ebp),%eax
  801505:	01 c2                	add    %eax,%edx
  801507:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	01 c8                	add    %ecx,%eax
  80150f:	8a 00                	mov    (%eax),%al
  801511:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801513:	ff 45 fc             	incl   -0x4(%ebp)
  801516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801519:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80151c:	7c e1                	jl     8014ff <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80151e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801525:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80152c:	eb 1f                	jmp    80154d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80152e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801531:	8d 50 01             	lea    0x1(%eax),%edx
  801534:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801537:	89 c2                	mov    %eax,%edx
  801539:	8b 45 10             	mov    0x10(%ebp),%eax
  80153c:	01 c2                	add    %eax,%edx
  80153e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801541:	8b 45 0c             	mov    0xc(%ebp),%eax
  801544:	01 c8                	add    %ecx,%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80154a:	ff 45 f8             	incl   -0x8(%ebp)
  80154d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801550:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801553:	7c d9                	jl     80152e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801555:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801558:	8b 45 10             	mov    0x10(%ebp),%eax
  80155b:	01 d0                	add    %edx,%eax
  80155d:	c6 00 00             	movb   $0x0,(%eax)
}
  801560:	90                   	nop
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801566:	8b 45 14             	mov    0x14(%ebp),%eax
  801569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80156f:	8b 45 14             	mov    0x14(%ebp),%eax
  801572:	8b 00                	mov    (%eax),%eax
  801574:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80157b:	8b 45 10             	mov    0x10(%ebp),%eax
  80157e:	01 d0                	add    %edx,%eax
  801580:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801586:	eb 0c                	jmp    801594 <strsplit+0x31>
			*string++ = 0;
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	8d 50 01             	lea    0x1(%eax),%edx
  80158e:	89 55 08             	mov    %edx,0x8(%ebp)
  801591:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	84 c0                	test   %al,%al
  80159b:	74 18                	je     8015b5 <strsplit+0x52>
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	8a 00                	mov    (%eax),%al
  8015a2:	0f be c0             	movsbl %al,%eax
  8015a5:	50                   	push   %eax
  8015a6:	ff 75 0c             	pushl  0xc(%ebp)
  8015a9:	e8 83 fa ff ff       	call   801031 <strchr>
  8015ae:	83 c4 08             	add    $0x8,%esp
  8015b1:	85 c0                	test   %eax,%eax
  8015b3:	75 d3                	jne    801588 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b8:	8a 00                	mov    (%eax),%al
  8015ba:	84 c0                	test   %al,%al
  8015bc:	74 5a                	je     801618 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015be:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c1:	8b 00                	mov    (%eax),%eax
  8015c3:	83 f8 0f             	cmp    $0xf,%eax
  8015c6:	75 07                	jne    8015cf <strsplit+0x6c>
		{
			return 0;
  8015c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8015cd:	eb 66                	jmp    801635 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8015d2:	8b 00                	mov    (%eax),%eax
  8015d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8015d7:	8b 55 14             	mov    0x14(%ebp),%edx
  8015da:	89 0a                	mov    %ecx,(%edx)
  8015dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e6:	01 c2                	add    %eax,%edx
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015ed:	eb 03                	jmp    8015f2 <strsplit+0x8f>
			string++;
  8015ef:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	84 c0                	test   %al,%al
  8015f9:	74 8b                	je     801586 <strsplit+0x23>
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	8a 00                	mov    (%eax),%al
  801600:	0f be c0             	movsbl %al,%eax
  801603:	50                   	push   %eax
  801604:	ff 75 0c             	pushl  0xc(%ebp)
  801607:	e8 25 fa ff ff       	call   801031 <strchr>
  80160c:	83 c4 08             	add    $0x8,%esp
  80160f:	85 c0                	test   %eax,%eax
  801611:	74 dc                	je     8015ef <strsplit+0x8c>
			string++;
	}
  801613:	e9 6e ff ff ff       	jmp    801586 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801618:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801619:	8b 45 14             	mov    0x14(%ebp),%eax
  80161c:	8b 00                	mov    (%eax),%eax
  80161e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801625:	8b 45 10             	mov    0x10(%ebp),%eax
  801628:	01 d0                	add    %edx,%eax
  80162a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801630:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801635:	c9                   	leave  
  801636:	c3                   	ret    

00801637 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801637:	55                   	push   %ebp
  801638:	89 e5                	mov    %esp,%ebp
  80163a:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801643:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80164a:	eb 4a                	jmp    801696 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80164c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164f:	8b 45 08             	mov    0x8(%ebp),%eax
  801652:	01 c2                	add    %eax,%edx
  801654:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801657:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165a:	01 c8                	add    %ecx,%eax
  80165c:	8a 00                	mov    (%eax),%al
  80165e:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801660:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801663:	8b 45 0c             	mov    0xc(%ebp),%eax
  801666:	01 d0                	add    %edx,%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	3c 40                	cmp    $0x40,%al
  80166c:	7e 25                	jle    801693 <str2lower+0x5c>
  80166e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801671:	8b 45 0c             	mov    0xc(%ebp),%eax
  801674:	01 d0                	add    %edx,%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	3c 5a                	cmp    $0x5a,%al
  80167a:	7f 17                	jg     801693 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80167c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	01 d0                	add    %edx,%eax
  801684:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801687:	8b 55 08             	mov    0x8(%ebp),%edx
  80168a:	01 ca                	add    %ecx,%edx
  80168c:	8a 12                	mov    (%edx),%dl
  80168e:	83 c2 20             	add    $0x20,%edx
  801691:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801693:	ff 45 fc             	incl   -0x4(%ebp)
  801696:	ff 75 0c             	pushl  0xc(%ebp)
  801699:	e8 01 f8 ff ff       	call   800e9f <strlen>
  80169e:	83 c4 04             	add    $0x4,%esp
  8016a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016a4:	7f a6                	jg     80164c <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8016a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    

008016ab <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016ab:	55                   	push   %ebp
  8016ac:	89 e5                	mov    %esp,%ebp
  8016ae:	57                   	push   %edi
  8016af:	56                   	push   %esi
  8016b0:	53                   	push   %ebx
  8016b1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016bd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016c0:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016c3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016c6:	cd 30                	int    $0x30
  8016c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ce:	83 c4 10             	add    $0x10,%esp
  8016d1:	5b                   	pop    %ebx
  8016d2:	5e                   	pop    %esi
  8016d3:	5f                   	pop    %edi
  8016d4:	5d                   	pop    %ebp
  8016d5:	c3                   	ret    

008016d6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
  8016d9:	83 ec 04             	sub    $0x4,%esp
  8016dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016e2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016e5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	6a 00                	push   $0x0
  8016ee:	51                   	push   %ecx
  8016ef:	52                   	push   %edx
  8016f0:	ff 75 0c             	pushl  0xc(%ebp)
  8016f3:	50                   	push   %eax
  8016f4:	6a 00                	push   $0x0
  8016f6:	e8 b0 ff ff ff       	call   8016ab <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
}
  8016fe:	90                   	nop
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_cgetc>:

int
sys_cgetc(void)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 02                	push   $0x2
  801710:	e8 96 ff ff ff       	call   8016ab <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <sys_lock_cons>:

void sys_lock_cons(void)
{
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 03                	push   $0x3
  801729:	e8 7d ff ff ff       	call   8016ab <syscall>
  80172e:	83 c4 18             	add    $0x18,%esp
}
  801731:	90                   	nop
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 04                	push   $0x4
  801743:	e8 63 ff ff ff       	call   8016ab <syscall>
  801748:	83 c4 18             	add    $0x18,%esp
}
  80174b:	90                   	nop
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801751:	8b 55 0c             	mov    0xc(%ebp),%edx
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	52                   	push   %edx
  80175e:	50                   	push   %eax
  80175f:	6a 08                	push   $0x8
  801761:	e8 45 ff ff ff       	call   8016ab <syscall>
  801766:	83 c4 18             	add    $0x18,%esp
}
  801769:	c9                   	leave  
  80176a:	c3                   	ret    

0080176b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
  80176e:	56                   	push   %esi
  80176f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801770:	8b 75 18             	mov    0x18(%ebp),%esi
  801773:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801776:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801779:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	56                   	push   %esi
  801780:	53                   	push   %ebx
  801781:	51                   	push   %ecx
  801782:	52                   	push   %edx
  801783:	50                   	push   %eax
  801784:	6a 09                	push   $0x9
  801786:	e8 20 ff ff ff       	call   8016ab <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
}
  80178e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801791:	5b                   	pop    %ebx
  801792:	5e                   	pop    %esi
  801793:	5d                   	pop    %ebp
  801794:	c3                   	ret    

00801795 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	ff 75 08             	pushl  0x8(%ebp)
  8017a3:	6a 0a                	push   $0xa
  8017a5:	e8 01 ff ff ff       	call   8016ab <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	ff 75 0c             	pushl  0xc(%ebp)
  8017bb:	ff 75 08             	pushl  0x8(%ebp)
  8017be:	6a 0b                	push   $0xb
  8017c0:	e8 e6 fe ff ff       	call   8016ab <syscall>
  8017c5:	83 c4 18             	add    $0x18,%esp
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 0c                	push   $0xc
  8017d9:	e8 cd fe ff ff       	call   8016ab <syscall>
  8017de:	83 c4 18             	add    $0x18,%esp
}
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 0d                	push   $0xd
  8017f2:	e8 b4 fe ff ff       	call   8016ab <syscall>
  8017f7:	83 c4 18             	add    $0x18,%esp
}
  8017fa:	c9                   	leave  
  8017fb:	c3                   	ret    

008017fc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017fc:	55                   	push   %ebp
  8017fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 0e                	push   $0xe
  80180b:	e8 9b fe ff ff       	call   8016ab <syscall>
  801810:	83 c4 18             	add    $0x18,%esp
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 0f                	push   $0xf
  801824:	e8 82 fe ff ff       	call   8016ab <syscall>
  801829:	83 c4 18             	add    $0x18,%esp
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	ff 75 08             	pushl  0x8(%ebp)
  80183c:	6a 10                	push   $0x10
  80183e:	e8 68 fe ff ff       	call   8016ab <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
}
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 11                	push   $0x11
  801857:	e8 4f fe ff ff       	call   8016ab <syscall>
  80185c:	83 c4 18             	add    $0x18,%esp
}
  80185f:	90                   	nop
  801860:	c9                   	leave  
  801861:	c3                   	ret    

00801862 <sys_cputc>:

void
sys_cputc(const char c)
{
  801862:	55                   	push   %ebp
  801863:	89 e5                	mov    %esp,%ebp
  801865:	83 ec 04             	sub    $0x4,%esp
  801868:	8b 45 08             	mov    0x8(%ebp),%eax
  80186b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80186e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	50                   	push   %eax
  80187b:	6a 01                	push   $0x1
  80187d:	e8 29 fe ff ff       	call   8016ab <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	90                   	nop
  801886:	c9                   	leave  
  801887:	c3                   	ret    

00801888 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801888:	55                   	push   %ebp
  801889:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 14                	push   $0x14
  801897:	e8 0f fe ff ff       	call   8016ab <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	90                   	nop
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
  8018a5:	83 ec 04             	sub    $0x4,%esp
  8018a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018ae:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018b1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	51                   	push   %ecx
  8018bb:	52                   	push   %edx
  8018bc:	ff 75 0c             	pushl  0xc(%ebp)
  8018bf:	50                   	push   %eax
  8018c0:	6a 15                	push   $0x15
  8018c2:	e8 e4 fd ff ff       	call   8016ab <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018cf:	8b 55 10             	mov    0x10(%ebp),%edx
  8018d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	52                   	push   %edx
  8018da:	50                   	push   %eax
  8018db:	ff 75 08             	pushl  0x8(%ebp)
  8018de:	6a 16                	push   $0x16
  8018e0:	e8 c6 fd ff ff       	call   8016ab <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	52                   	push   %edx
  8018fa:	50                   	push   %eax
  8018fb:	6a 17                	push   $0x17
  8018fd:	e8 a9 fd ff ff       	call   8016ab <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80190a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	52                   	push   %edx
  801917:	50                   	push   %eax
  801918:	6a 18                	push   $0x18
  80191a:	e8 8c fd ff ff       	call   8016ab <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801927:	8b 45 08             	mov    0x8(%ebp),%eax
  80192a:	6a 00                	push   $0x0
  80192c:	ff 75 14             	pushl  0x14(%ebp)
  80192f:	ff 75 10             	pushl  0x10(%ebp)
  801932:	ff 75 0c             	pushl  0xc(%ebp)
  801935:	50                   	push   %eax
  801936:	6a 19                	push   $0x19
  801938:	e8 6e fd ff ff       	call   8016ab <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
}
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	50                   	push   %eax
  801951:	6a 1a                	push   $0x1a
  801953:	e8 53 fd ff ff       	call   8016ab <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	90                   	nop
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	50                   	push   %eax
  80196d:	6a 1b                	push   $0x1b
  80196f:	e8 37 fd ff ff       	call   8016ab <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 05                	push   $0x5
  801988:	e8 1e fd ff ff       	call   8016ab <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 06                	push   $0x6
  8019a1:	e8 05 fd ff ff       	call   8016ab <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 07                	push   $0x7
  8019ba:	e8 ec fc ff ff       	call   8016ab <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
}
  8019c2:	c9                   	leave  
  8019c3:	c3                   	ret    

008019c4 <sys_exit_env>:


void sys_exit_env(void)
{
  8019c4:	55                   	push   %ebp
  8019c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 1c                	push   $0x1c
  8019d3:	e8 d3 fc ff ff       	call   8016ab <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
}
  8019db:	90                   	nop
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	ff 75 10             	pushl  0x10(%ebp)
  8019e8:	ff 75 0c             	pushl  0xc(%ebp)
  8019eb:	ff 75 08             	pushl  0x8(%ebp)
  8019ee:	6a 13                	push   $0x13
  8019f0:	e8 b6 fc ff ff       	call   8016ab <syscall>
  8019f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f8:	90                   	nop
}
  8019f9:	c9                   	leave  
  8019fa:	c3                   	ret    

008019fb <sys_rcr2>:
uint32 sys_rcr2()
{
  8019fb:	55                   	push   %ebp
  8019fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 1e                	push   $0x1e
  801a0a:	e8 9c fc ff ff       	call   8016ab <syscall>
  801a0f:	83 c4 18             	add    $0x18,%esp
}
  801a12:	c9                   	leave  
  801a13:	c3                   	ret    

00801a14 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a14:	55                   	push   %ebp
  801a15:	89 e5                	mov    %esp,%ebp
  801a17:	83 ec 04             	sub    $0x4,%esp
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a20:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	50                   	push   %eax
  801a2d:	6a 1f                	push   $0x1f
  801a2f:	e8 77 fc ff ff       	call   8016ab <syscall>
  801a34:	83 c4 18             	add    $0x18,%esp
	return ;
  801a37:	90                   	nop
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <rsttst>:
void rsttst()
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 21                	push   $0x21
  801a49:	e8 5d fc ff ff       	call   8016ab <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a51:	90                   	nop
}
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
  801a57:	83 ec 04             	sub    $0x4,%esp
  801a5a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a60:	8b 55 18             	mov    0x18(%ebp),%edx
  801a63:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a67:	52                   	push   %edx
  801a68:	50                   	push   %eax
  801a69:	ff 75 10             	pushl  0x10(%ebp)
  801a6c:	ff 75 0c             	pushl  0xc(%ebp)
  801a6f:	ff 75 08             	pushl  0x8(%ebp)
  801a72:	6a 20                	push   $0x20
  801a74:	e8 32 fc ff ff       	call   8016ab <syscall>
  801a79:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7c:	90                   	nop
}
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <chktst>:
void chktst(uint32 n)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	ff 75 08             	pushl  0x8(%ebp)
  801a8d:	6a 22                	push   $0x22
  801a8f:	e8 17 fc ff ff       	call   8016ab <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
	return ;
  801a97:	90                   	nop
}
  801a98:	c9                   	leave  
  801a99:	c3                   	ret    

00801a9a <inctst>:

void inctst()
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 23                	push   $0x23
  801aa9:	e8 fd fb ff ff       	call   8016ab <syscall>
  801aae:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab1:	90                   	nop
}
  801ab2:	c9                   	leave  
  801ab3:	c3                   	ret    

00801ab4 <gettst>:
uint32 gettst()
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 24                	push   $0x24
  801ac3:	e8 e3 fb ff ff       	call   8016ab <syscall>
  801ac8:	83 c4 18             	add    $0x18,%esp
}
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    

00801acd <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 25                	push   $0x25
  801adc:	e8 ca fb ff ff       	call   8016ab <syscall>
  801ae1:	83 c4 18             	add    $0x18,%esp
  801ae4:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801ae9:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	ff 75 08             	pushl  0x8(%ebp)
  801b06:	6a 26                	push   $0x26
  801b08:	e8 9e fb ff ff       	call   8016ab <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801b10:	90                   	nop
}
  801b11:	c9                   	leave  
  801b12:	c3                   	ret    

00801b13 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b13:	55                   	push   %ebp
  801b14:	89 e5                	mov    %esp,%ebp
  801b16:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b17:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b1a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b20:	8b 45 08             	mov    0x8(%ebp),%eax
  801b23:	6a 00                	push   $0x0
  801b25:	53                   	push   %ebx
  801b26:	51                   	push   %ecx
  801b27:	52                   	push   %edx
  801b28:	50                   	push   %eax
  801b29:	6a 27                	push   $0x27
  801b2b:	e8 7b fb ff ff       	call   8016ab <syscall>
  801b30:	83 c4 18             	add    $0x18,%esp
}
  801b33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	52                   	push   %edx
  801b48:	50                   	push   %eax
  801b49:	6a 28                	push   $0x28
  801b4b:	e8 5b fb ff ff       	call   8016ab <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
}
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b58:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b61:	6a 00                	push   $0x0
  801b63:	51                   	push   %ecx
  801b64:	ff 75 10             	pushl  0x10(%ebp)
  801b67:	52                   	push   %edx
  801b68:	50                   	push   %eax
  801b69:	6a 29                	push   $0x29
  801b6b:	e8 3b fb ff ff       	call   8016ab <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	ff 75 10             	pushl  0x10(%ebp)
  801b7f:	ff 75 0c             	pushl  0xc(%ebp)
  801b82:	ff 75 08             	pushl  0x8(%ebp)
  801b85:	6a 12                	push   $0x12
  801b87:	e8 1f fb ff ff       	call   8016ab <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8f:	90                   	nop
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b98:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	52                   	push   %edx
  801ba2:	50                   	push   %eax
  801ba3:	6a 2a                	push   $0x2a
  801ba5:	e8 01 fb ff ff       	call   8016ab <syscall>
  801baa:	83 c4 18             	add    $0x18,%esp
	return;
  801bad:	90                   	nop
}
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 2b                	push   $0x2b
  801bbf:	e8 e7 fa ff ff       	call   8016ab <syscall>
  801bc4:	83 c4 18             	add    $0x18,%esp
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
  801bcc:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bcf:	83 ec 04             	sub    $0x4,%esp
  801bd2:	68 c8 28 80 00       	push   $0x8028c8
  801bd7:	68 0a 01 00 00       	push   $0x10a
  801bdc:	68 d8 28 80 00       	push   $0x8028d8
  801be1:	e8 12 e9 ff ff       	call   8004f8 <_panic>

00801be6 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801be6:	55                   	push   %ebp
  801be7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	ff 75 0c             	pushl  0xc(%ebp)
  801bf2:	ff 75 08             	pushl  0x8(%ebp)
  801bf5:	6a 33                	push   $0x33
  801bf7:	e8 af fa ff ff       	call   8016ab <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
	return;
  801bff:	90                   	nop
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	ff 75 0c             	pushl  0xc(%ebp)
  801c0e:	ff 75 08             	pushl  0x8(%ebp)
  801c11:	6a 34                	push   $0x34
  801c13:	e8 93 fa ff ff       	call   8016ab <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1b:	90                   	nop
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
  801c21:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c24:	8b 55 08             	mov    0x8(%ebp),%edx
  801c27:	89 d0                	mov    %edx,%eax
  801c29:	c1 e0 02             	shl    $0x2,%eax
  801c2c:	01 d0                	add    %edx,%eax
  801c2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c35:	01 d0                	add    %edx,%eax
  801c37:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c3e:	01 d0                	add    %edx,%eax
  801c40:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c47:	01 d0                	add    %edx,%eax
  801c49:	c1 e0 04             	shl    $0x4,%eax
  801c4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c4f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c56:	0f 31                	rdtsc  
  801c58:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c5b:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c61:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c67:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c6a:	eb 46                	jmp    801cb2 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c6c:	0f 31                	rdtsc  
  801c6e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c71:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c74:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c77:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c7a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801c7d:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c80:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c86:	29 c2                	sub    %eax,%edx
  801c88:	89 d0                	mov    %edx,%eax
  801c8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c8d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c93:	89 d1                	mov    %edx,%ecx
  801c95:	29 c1                	sub    %eax,%ecx
  801c97:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c9d:	39 c2                	cmp    %eax,%edx
  801c9f:	0f 97 c0             	seta   %al
  801ca2:	0f b6 c0             	movzbl %al,%eax
  801ca5:	29 c1                	sub    %eax,%ecx
  801ca7:	89 c8                	mov    %ecx,%eax
  801ca9:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801cac:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801caf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801cb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cb5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801cb8:	72 b2                	jb     801c6c <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801cba:	90                   	nop
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
  801cc0:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cc3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cca:	eb 03                	jmp    801ccf <busy_wait+0x12>
  801ccc:	ff 45 fc             	incl   -0x4(%ebp)
  801ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cd2:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cd5:	72 f5                	jb     801ccc <busy_wait+0xf>
	return i;
  801cd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <__udivdi3>:
  801cdc:	55                   	push   %ebp
  801cdd:	57                   	push   %edi
  801cde:	56                   	push   %esi
  801cdf:	53                   	push   %ebx
  801ce0:	83 ec 1c             	sub    $0x1c,%esp
  801ce3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ce7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ceb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cf3:	89 ca                	mov    %ecx,%edx
  801cf5:	89 f8                	mov    %edi,%eax
  801cf7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cfb:	85 f6                	test   %esi,%esi
  801cfd:	75 2d                	jne    801d2c <__udivdi3+0x50>
  801cff:	39 cf                	cmp    %ecx,%edi
  801d01:	77 65                	ja     801d68 <__udivdi3+0x8c>
  801d03:	89 fd                	mov    %edi,%ebp
  801d05:	85 ff                	test   %edi,%edi
  801d07:	75 0b                	jne    801d14 <__udivdi3+0x38>
  801d09:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0e:	31 d2                	xor    %edx,%edx
  801d10:	f7 f7                	div    %edi
  801d12:	89 c5                	mov    %eax,%ebp
  801d14:	31 d2                	xor    %edx,%edx
  801d16:	89 c8                	mov    %ecx,%eax
  801d18:	f7 f5                	div    %ebp
  801d1a:	89 c1                	mov    %eax,%ecx
  801d1c:	89 d8                	mov    %ebx,%eax
  801d1e:	f7 f5                	div    %ebp
  801d20:	89 cf                	mov    %ecx,%edi
  801d22:	89 fa                	mov    %edi,%edx
  801d24:	83 c4 1c             	add    $0x1c,%esp
  801d27:	5b                   	pop    %ebx
  801d28:	5e                   	pop    %esi
  801d29:	5f                   	pop    %edi
  801d2a:	5d                   	pop    %ebp
  801d2b:	c3                   	ret    
  801d2c:	39 ce                	cmp    %ecx,%esi
  801d2e:	77 28                	ja     801d58 <__udivdi3+0x7c>
  801d30:	0f bd fe             	bsr    %esi,%edi
  801d33:	83 f7 1f             	xor    $0x1f,%edi
  801d36:	75 40                	jne    801d78 <__udivdi3+0x9c>
  801d38:	39 ce                	cmp    %ecx,%esi
  801d3a:	72 0a                	jb     801d46 <__udivdi3+0x6a>
  801d3c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d40:	0f 87 9e 00 00 00    	ja     801de4 <__udivdi3+0x108>
  801d46:	b8 01 00 00 00       	mov    $0x1,%eax
  801d4b:	89 fa                	mov    %edi,%edx
  801d4d:	83 c4 1c             	add    $0x1c,%esp
  801d50:	5b                   	pop    %ebx
  801d51:	5e                   	pop    %esi
  801d52:	5f                   	pop    %edi
  801d53:	5d                   	pop    %ebp
  801d54:	c3                   	ret    
  801d55:	8d 76 00             	lea    0x0(%esi),%esi
  801d58:	31 ff                	xor    %edi,%edi
  801d5a:	31 c0                	xor    %eax,%eax
  801d5c:	89 fa                	mov    %edi,%edx
  801d5e:	83 c4 1c             	add    $0x1c,%esp
  801d61:	5b                   	pop    %ebx
  801d62:	5e                   	pop    %esi
  801d63:	5f                   	pop    %edi
  801d64:	5d                   	pop    %ebp
  801d65:	c3                   	ret    
  801d66:	66 90                	xchg   %ax,%ax
  801d68:	89 d8                	mov    %ebx,%eax
  801d6a:	f7 f7                	div    %edi
  801d6c:	31 ff                	xor    %edi,%edi
  801d6e:	89 fa                	mov    %edi,%edx
  801d70:	83 c4 1c             	add    $0x1c,%esp
  801d73:	5b                   	pop    %ebx
  801d74:	5e                   	pop    %esi
  801d75:	5f                   	pop    %edi
  801d76:	5d                   	pop    %ebp
  801d77:	c3                   	ret    
  801d78:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d7d:	89 eb                	mov    %ebp,%ebx
  801d7f:	29 fb                	sub    %edi,%ebx
  801d81:	89 f9                	mov    %edi,%ecx
  801d83:	d3 e6                	shl    %cl,%esi
  801d85:	89 c5                	mov    %eax,%ebp
  801d87:	88 d9                	mov    %bl,%cl
  801d89:	d3 ed                	shr    %cl,%ebp
  801d8b:	89 e9                	mov    %ebp,%ecx
  801d8d:	09 f1                	or     %esi,%ecx
  801d8f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d93:	89 f9                	mov    %edi,%ecx
  801d95:	d3 e0                	shl    %cl,%eax
  801d97:	89 c5                	mov    %eax,%ebp
  801d99:	89 d6                	mov    %edx,%esi
  801d9b:	88 d9                	mov    %bl,%cl
  801d9d:	d3 ee                	shr    %cl,%esi
  801d9f:	89 f9                	mov    %edi,%ecx
  801da1:	d3 e2                	shl    %cl,%edx
  801da3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801da7:	88 d9                	mov    %bl,%cl
  801da9:	d3 e8                	shr    %cl,%eax
  801dab:	09 c2                	or     %eax,%edx
  801dad:	89 d0                	mov    %edx,%eax
  801daf:	89 f2                	mov    %esi,%edx
  801db1:	f7 74 24 0c          	divl   0xc(%esp)
  801db5:	89 d6                	mov    %edx,%esi
  801db7:	89 c3                	mov    %eax,%ebx
  801db9:	f7 e5                	mul    %ebp
  801dbb:	39 d6                	cmp    %edx,%esi
  801dbd:	72 19                	jb     801dd8 <__udivdi3+0xfc>
  801dbf:	74 0b                	je     801dcc <__udivdi3+0xf0>
  801dc1:	89 d8                	mov    %ebx,%eax
  801dc3:	31 ff                	xor    %edi,%edi
  801dc5:	e9 58 ff ff ff       	jmp    801d22 <__udivdi3+0x46>
  801dca:	66 90                	xchg   %ax,%ax
  801dcc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dd0:	89 f9                	mov    %edi,%ecx
  801dd2:	d3 e2                	shl    %cl,%edx
  801dd4:	39 c2                	cmp    %eax,%edx
  801dd6:	73 e9                	jae    801dc1 <__udivdi3+0xe5>
  801dd8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ddb:	31 ff                	xor    %edi,%edi
  801ddd:	e9 40 ff ff ff       	jmp    801d22 <__udivdi3+0x46>
  801de2:	66 90                	xchg   %ax,%ax
  801de4:	31 c0                	xor    %eax,%eax
  801de6:	e9 37 ff ff ff       	jmp    801d22 <__udivdi3+0x46>
  801deb:	90                   	nop

00801dec <__umoddi3>:
  801dec:	55                   	push   %ebp
  801ded:	57                   	push   %edi
  801dee:	56                   	push   %esi
  801def:	53                   	push   %ebx
  801df0:	83 ec 1c             	sub    $0x1c,%esp
  801df3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801df7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801dfb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e03:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e07:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e0b:	89 f3                	mov    %esi,%ebx
  801e0d:	89 fa                	mov    %edi,%edx
  801e0f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e13:	89 34 24             	mov    %esi,(%esp)
  801e16:	85 c0                	test   %eax,%eax
  801e18:	75 1a                	jne    801e34 <__umoddi3+0x48>
  801e1a:	39 f7                	cmp    %esi,%edi
  801e1c:	0f 86 a2 00 00 00    	jbe    801ec4 <__umoddi3+0xd8>
  801e22:	89 c8                	mov    %ecx,%eax
  801e24:	89 f2                	mov    %esi,%edx
  801e26:	f7 f7                	div    %edi
  801e28:	89 d0                	mov    %edx,%eax
  801e2a:	31 d2                	xor    %edx,%edx
  801e2c:	83 c4 1c             	add    $0x1c,%esp
  801e2f:	5b                   	pop    %ebx
  801e30:	5e                   	pop    %esi
  801e31:	5f                   	pop    %edi
  801e32:	5d                   	pop    %ebp
  801e33:	c3                   	ret    
  801e34:	39 f0                	cmp    %esi,%eax
  801e36:	0f 87 ac 00 00 00    	ja     801ee8 <__umoddi3+0xfc>
  801e3c:	0f bd e8             	bsr    %eax,%ebp
  801e3f:	83 f5 1f             	xor    $0x1f,%ebp
  801e42:	0f 84 ac 00 00 00    	je     801ef4 <__umoddi3+0x108>
  801e48:	bf 20 00 00 00       	mov    $0x20,%edi
  801e4d:	29 ef                	sub    %ebp,%edi
  801e4f:	89 fe                	mov    %edi,%esi
  801e51:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e55:	89 e9                	mov    %ebp,%ecx
  801e57:	d3 e0                	shl    %cl,%eax
  801e59:	89 d7                	mov    %edx,%edi
  801e5b:	89 f1                	mov    %esi,%ecx
  801e5d:	d3 ef                	shr    %cl,%edi
  801e5f:	09 c7                	or     %eax,%edi
  801e61:	89 e9                	mov    %ebp,%ecx
  801e63:	d3 e2                	shl    %cl,%edx
  801e65:	89 14 24             	mov    %edx,(%esp)
  801e68:	89 d8                	mov    %ebx,%eax
  801e6a:	d3 e0                	shl    %cl,%eax
  801e6c:	89 c2                	mov    %eax,%edx
  801e6e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e72:	d3 e0                	shl    %cl,%eax
  801e74:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e78:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e7c:	89 f1                	mov    %esi,%ecx
  801e7e:	d3 e8                	shr    %cl,%eax
  801e80:	09 d0                	or     %edx,%eax
  801e82:	d3 eb                	shr    %cl,%ebx
  801e84:	89 da                	mov    %ebx,%edx
  801e86:	f7 f7                	div    %edi
  801e88:	89 d3                	mov    %edx,%ebx
  801e8a:	f7 24 24             	mull   (%esp)
  801e8d:	89 c6                	mov    %eax,%esi
  801e8f:	89 d1                	mov    %edx,%ecx
  801e91:	39 d3                	cmp    %edx,%ebx
  801e93:	0f 82 87 00 00 00    	jb     801f20 <__umoddi3+0x134>
  801e99:	0f 84 91 00 00 00    	je     801f30 <__umoddi3+0x144>
  801e9f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ea3:	29 f2                	sub    %esi,%edx
  801ea5:	19 cb                	sbb    %ecx,%ebx
  801ea7:	89 d8                	mov    %ebx,%eax
  801ea9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ead:	d3 e0                	shl    %cl,%eax
  801eaf:	89 e9                	mov    %ebp,%ecx
  801eb1:	d3 ea                	shr    %cl,%edx
  801eb3:	09 d0                	or     %edx,%eax
  801eb5:	89 e9                	mov    %ebp,%ecx
  801eb7:	d3 eb                	shr    %cl,%ebx
  801eb9:	89 da                	mov    %ebx,%edx
  801ebb:	83 c4 1c             	add    $0x1c,%esp
  801ebe:	5b                   	pop    %ebx
  801ebf:	5e                   	pop    %esi
  801ec0:	5f                   	pop    %edi
  801ec1:	5d                   	pop    %ebp
  801ec2:	c3                   	ret    
  801ec3:	90                   	nop
  801ec4:	89 fd                	mov    %edi,%ebp
  801ec6:	85 ff                	test   %edi,%edi
  801ec8:	75 0b                	jne    801ed5 <__umoddi3+0xe9>
  801eca:	b8 01 00 00 00       	mov    $0x1,%eax
  801ecf:	31 d2                	xor    %edx,%edx
  801ed1:	f7 f7                	div    %edi
  801ed3:	89 c5                	mov    %eax,%ebp
  801ed5:	89 f0                	mov    %esi,%eax
  801ed7:	31 d2                	xor    %edx,%edx
  801ed9:	f7 f5                	div    %ebp
  801edb:	89 c8                	mov    %ecx,%eax
  801edd:	f7 f5                	div    %ebp
  801edf:	89 d0                	mov    %edx,%eax
  801ee1:	e9 44 ff ff ff       	jmp    801e2a <__umoddi3+0x3e>
  801ee6:	66 90                	xchg   %ax,%ax
  801ee8:	89 c8                	mov    %ecx,%eax
  801eea:	89 f2                	mov    %esi,%edx
  801eec:	83 c4 1c             	add    $0x1c,%esp
  801eef:	5b                   	pop    %ebx
  801ef0:	5e                   	pop    %esi
  801ef1:	5f                   	pop    %edi
  801ef2:	5d                   	pop    %ebp
  801ef3:	c3                   	ret    
  801ef4:	3b 04 24             	cmp    (%esp),%eax
  801ef7:	72 06                	jb     801eff <__umoddi3+0x113>
  801ef9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801efd:	77 0f                	ja     801f0e <__umoddi3+0x122>
  801eff:	89 f2                	mov    %esi,%edx
  801f01:	29 f9                	sub    %edi,%ecx
  801f03:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f07:	89 14 24             	mov    %edx,(%esp)
  801f0a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f0e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f12:	8b 14 24             	mov    (%esp),%edx
  801f15:	83 c4 1c             	add    $0x1c,%esp
  801f18:	5b                   	pop    %ebx
  801f19:	5e                   	pop    %esi
  801f1a:	5f                   	pop    %edi
  801f1b:	5d                   	pop    %ebp
  801f1c:	c3                   	ret    
  801f1d:	8d 76 00             	lea    0x0(%esi),%esi
  801f20:	2b 04 24             	sub    (%esp),%eax
  801f23:	19 fa                	sbb    %edi,%edx
  801f25:	89 d1                	mov    %edx,%ecx
  801f27:	89 c6                	mov    %eax,%esi
  801f29:	e9 71 ff ff ff       	jmp    801e9f <__umoddi3+0xb3>
  801f2e:	66 90                	xchg   %ax,%ax
  801f30:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f34:	72 ea                	jb     801f20 <__umoddi3+0x134>
  801f36:	89 d9                	mov    %ebx,%ecx
  801f38:	e9 62 ff ff ff       	jmp    801e9f <__umoddi3+0xb3>
