
obj/user/tst_chan_all_master:     file format elf32-i386


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
  800031:	e8 45 02 00 00       	call   80027b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create and run slaves, wait them to finish
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
  80004e:	e8 83 07 00 00       	call   8007d6 <cprintf_colored>
  800053:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	68 70 1f 80 00       	push   $0x801f70
  80005e:	6a 0e                	push   $0xe
  800060:	e8 71 07 00 00       	call   8007d6 <cprintf_colored>
  800065:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	68 40 1f 80 00       	push   $0x801f40
  800070:	6a 0e                	push   $0xe
  800072:	e8 5f 07 00 00       	call   8007d6 <cprintf_colored>
  800077:	83 c4 10             	add    $0x10,%esp


	int envID = sys_getenvid();
  80007a:	e8 dd 18 00 00       	call   80195c <sys_getenvid>
  80007f:	89 45 d8             	mov    %eax,-0x28(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  800082:	c7 45 e4 07 00 00 00 	movl   $0x7,-0x1c(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800089:	83 ec 08             	sub    $0x8,%esp
  80008c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80008f:	68 cc 1f 80 00       	push   $0x801fcc
  800094:	e8 10 07 00 00       	call   8007a9 <cprintf>
  800099:	83 c4 10             	add    $0x10,%esp
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  80009c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8000a3:	eb 68                	jmp    80010d <_main+0xd5>
	{
		id = sys_create_env("tstChanAllSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000aa:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b5:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c0:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000c6:	51                   	push   %ecx
  8000c7:	52                   	push   %edx
  8000c8:	50                   	push   %eax
  8000c9:	68 f4 1f 80 00       	push   $0x801ff4
  8000ce:	e8 34 18 00 00       	call   801907 <sys_create_env>
  8000d3:	83 c4 10             	add    $0x10,%esp
  8000d6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  8000d9:	83 7d d4 ee          	cmpl   $0xffffffee,-0x2c(%ebp)
  8000dd:	75 1d                	jne    8000fc <_main+0xc4>
		{
			cprintf_colored(TEXT_TESTERR_CLR, "\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  8000df:	83 ec 04             	sub    $0x4,%esp
  8000e2:	ff 75 e0             	pushl  -0x20(%ebp)
  8000e5:	68 04 20 80 00       	push   $0x802004
  8000ea:	6a 0c                	push   $0xc
  8000ec:	e8 e5 06 00 00       	call   8007d6 <cprintf_colored>
  8000f1:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  8000f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			break;
  8000fa:	eb 19                	jmp    800115 <_main+0xdd>
		}
		sys_run_env(id);
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	ff 75 d4             	pushl  -0x2c(%ebp)
  800102:	e8 1e 18 00 00       	call   801925 <sys_run_env>
  800107:	83 c4 10             	add    $0x10,%esp
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  80010a:	ff 45 e0             	incl   -0x20(%ebp)
  80010d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800110:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800113:	7c 90                	jl     8000a5 <_main+0x6d>
		}
		sys_run_env(id);
	}

	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
  800115:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
	char cmd1[64] = "__GetChanQueueSize__";
  80011c:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80011f:	bb 56 21 80 00       	mov    $0x802156,%ebx
  800124:	ba 15 00 00 00       	mov    $0x15,%edx
  800129:	89 c7                	mov    %eax,%edi
  80012b:	89 de                	mov    %ebx,%esi
  80012d:	89 d1                	mov    %edx,%ecx
  80012f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800131:	8d 55 99             	lea    -0x67(%ebp),%edx
  800134:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800139:	b0 00                	mov    $0x0,%al
  80013b:	89 d7                	mov    %edx,%edi
  80013d:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, (uint32)(&numOfBlockedProcesses));
  80013f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  800142:	83 ec 08             	sub    $0x8,%esp
  800145:	50                   	push   %eax
  800146:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800149:	50                   	push   %eax
  80014a:	e8 26 1a 00 00       	call   801b75 <sys_utilities>
  80014f:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  800152:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	while (numOfBlockedProcesses != numOfSlaves)
  800159:	eb 75                	jmp    8001d0 <_main+0x198>
	{
		env_sleep(5000);
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	68 88 13 00 00       	push   $0x1388
  800163:	e8 99 1a 00 00       	call   801c01 <env_sleep>
  800168:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  80016b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80016e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800171:	75 1b                	jne    80018e <_main+0x156>
		{
			panic("%~test channels failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves, numOfBlockedProcesses);
  800173:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800176:	83 ec 0c             	sub    $0xc,%esp
  800179:	50                   	push   %eax
  80017a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80017d:	68 5c 20 80 00       	push   $0x80205c
  800182:	6a 2f                	push   $0x2f
  800184:	68 b5 20 80 00       	push   $0x8020b5
  800189:	e8 4d 03 00 00       	call   8004db <_panic>
		}
		char cmd2[64] = "__GetChanQueueSize__";
  80018e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  800194:	bb 56 21 80 00       	mov    $0x802156,%ebx
  800199:	ba 15 00 00 00       	mov    $0x15,%edx
  80019e:	89 c7                	mov    %eax,%edi
  8001a0:	89 de                	mov    %ebx,%esi
  8001a2:	89 d1                	mov    %edx,%ecx
  8001a4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001a6:	8d 95 19 ff ff ff    	lea    -0xe7(%ebp),%edx
  8001ac:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8001b1:	b0 00                	mov    $0x0,%al
  8001b3:	89 d7                	mov    %edx,%edi
  8001b5:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  8001b7:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  8001ba:	83 ec 08             	sub    $0x8,%esp
  8001bd:	50                   	push   %eax
  8001be:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001c4:	50                   	push   %eax
  8001c5:	e8 ab 19 00 00       	call   801b75 <sys_utilities>
  8001ca:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  8001cd:	ff 45 dc             	incl   -0x24(%ebp)
	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
	char cmd1[64] = "__GetChanQueueSize__";
	sys_utilities(cmd1, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves)
  8001d0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001d3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8001d6:	75 83                	jne    80015b <_main+0x123>
		char cmd2[64] = "__GetChanQueueSize__";
		sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
		cnt++ ;
	}

	rsttst();
  8001d8:	e8 40 18 00 00       	call   801a1d <rsttst>

	//Wakeup all
	char cmd3[64] = "__WakeupAll__";
  8001dd:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  8001e3:	bb 96 21 80 00       	mov    $0x802196,%ebx
  8001e8:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001ed:	89 c7                	mov    %eax,%edi
  8001ef:	89 de                	mov    %ebx,%esi
  8001f1:	89 d1                	mov    %edx,%ecx
  8001f3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001f5:	8d 95 52 ff ff ff    	lea    -0xae(%ebp),%edx
  8001fb:	b9 32 00 00 00       	mov    $0x32,%ecx
  800200:	b0 00                	mov    $0x0,%al
  800202:	89 d7                	mov    %edx,%edi
  800204:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd3, 0);
  800206:	83 ec 08             	sub    $0x8,%esp
  800209:	6a 00                	push   $0x0
  80020b:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800211:	50                   	push   %eax
  800212:	e8 5e 19 00 00       	call   801b75 <sys_utilities>
  800217:	83 c4 10             	add    $0x10,%esp

	//Wait until all slave finished
	cnt = 0;
  80021a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	while (gettst() != numOfSlaves)
  800221:	eb 2f                	jmp    800252 <_main+0x21a>
	{
		env_sleep(5000);
  800223:	83 ec 0c             	sub    $0xc,%esp
  800226:	68 88 13 00 00       	push   $0x1388
  80022b:	e8 d1 19 00 00       	call   801c01 <env_sleep>
  800230:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800233:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800236:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800239:	75 14                	jne    80024f <_main+0x217>
		{
			panic("%~test channels failed! not all slaves finished");
  80023b:	83 ec 04             	sub    $0x4,%esp
  80023e:	68 d0 20 80 00       	push   $0x8020d0
  800243:	6a 43                	push   $0x43
  800245:	68 b5 20 80 00       	push   $0x8020b5
  80024a:	e8 8c 02 00 00       	call   8004db <_panic>
		}
		cnt++ ;
  80024f:	ff 45 dc             	incl   -0x24(%ebp)
	char cmd3[64] = "__WakeupAll__";
	sys_utilities(cmd3, 0);

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves)
  800252:	e8 40 18 00 00       	call   801a97 <gettst>
  800257:	89 c2                	mov    %eax,%edx
  800259:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025c:	39 c2                	cmp    %eax,%edx
  80025e:	75 c3                	jne    800223 <_main+0x1eb>
			panic("%~test channels failed! not all slaves finished");
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Channel (sleep & wakeup ALL) completed successfully!!\n\n");
  800260:	83 ec 08             	sub    $0x8,%esp
  800263:	68 00 21 80 00       	push   $0x802100
  800268:	6a 0a                	push   $0xa
  80026a:	e8 67 05 00 00       	call   8007d6 <cprintf_colored>
  80026f:	83 c4 10             	add    $0x10,%esp

	return;
  800272:	90                   	nop
}
  800273:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800276:	5b                   	pop    %ebx
  800277:	5e                   	pop    %esi
  800278:	5f                   	pop    %edi
  800279:	5d                   	pop    %ebp
  80027a:	c3                   	ret    

0080027b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80027b:	55                   	push   %ebp
  80027c:	89 e5                	mov    %esp,%ebp
  80027e:	57                   	push   %edi
  80027f:	56                   	push   %esi
  800280:	53                   	push   %ebx
  800281:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800287:	e8 e9 16 00 00       	call   801975 <sys_getenvindex>
  80028c:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80028f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800292:	89 d0                	mov    %edx,%eax
  800294:	c1 e0 03             	shl    $0x3,%eax
  800297:	01 d0                	add    %edx,%eax
  800299:	c1 e0 06             	shl    $0x6,%eax
  80029c:	01 d0                	add    %edx,%eax
  80029e:	c1 e0 03             	shl    $0x3,%eax
  8002a1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002a6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b0:	8a 40 10             	mov    0x10(%eax),%al
  8002b3:	84 c0                	test   %al,%al
  8002b5:	74 0d                	je     8002c4 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bc:	83 c0 10             	add    $0x10,%eax
  8002bf:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002c8:	7e 0a                	jle    8002d4 <libmain+0x59>
		binaryname = argv[0];
  8002ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cd:	8b 00                	mov    (%eax),%eax
  8002cf:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002d4:	83 ec 08             	sub    $0x8,%esp
  8002d7:	ff 75 0c             	pushl  0xc(%ebp)
  8002da:	ff 75 08             	pushl  0x8(%ebp)
  8002dd:	e8 56 fd ff ff       	call   800038 <_main>
  8002e2:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8002e5:	a1 00 30 80 00       	mov    0x803000,%eax
  8002ea:	85 c0                	test   %eax,%eax
  8002ec:	0f 84 b7 01 00 00    	je     8004a9 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8002f2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002f8:	bb 14 23 80 00       	mov    $0x802314,%ebx
  8002fd:	ba 0e 00 00 00       	mov    $0xe,%edx
  800302:	89 c7                	mov    %eax,%edi
  800304:	89 de                	mov    %ebx,%esi
  800306:	89 d1                	mov    %edx,%ecx
  800308:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80030a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800310:	b9 56 00 00 00       	mov    $0x56,%ecx
  800315:	b0 00                	mov    $0x0,%al
  800317:	89 d7                	mov    %edx,%edi
  800319:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80031b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800322:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800325:	83 ec 08             	sub    $0x8,%esp
  800328:	50                   	push   %eax
  800329:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80032f:	50                   	push   %eax
  800330:	e8 40 18 00 00       	call   801b75 <sys_utilities>
  800335:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800338:	e8 c0 13 00 00       	call   8016fd <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80033d:	83 ec 0c             	sub    $0xc,%esp
  800340:	68 f0 21 80 00       	push   $0x8021f0
  800345:	e8 5f 04 00 00       	call   8007a9 <cprintf>
  80034a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80034d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800350:	85 c0                	test   %eax,%eax
  800352:	74 58                	je     8003ac <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800354:	e8 3a 18 00 00       	call   801b93 <sys_get_optimal_num_faults>
  800359:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80035c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800362:	bb 78 23 80 00       	mov    $0x802378,%ebx
  800367:	ba 11 00 00 00       	mov    $0x11,%edx
  80036c:	89 c7                	mov    %eax,%edi
  80036e:	89 de                	mov    %ebx,%esi
  800370:	89 d1                	mov    %edx,%ecx
  800372:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800374:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800377:	b9 53 00 00 00       	mov    $0x53,%ecx
  80037c:	b0 00                	mov    $0x0,%al
  80037e:	89 d7                	mov    %edx,%edi
  800380:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800382:	83 ec 08             	sub    $0x8,%esp
  800385:	ff 75 dc             	pushl  -0x24(%ebp)
  800388:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80038e:	50                   	push   %eax
  80038f:	e8 e1 17 00 00       	call   801b75 <sys_utilities>
  800394:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800397:	83 ec 08             	sub    $0x8,%esp
  80039a:	ff 75 dc             	pushl  -0x24(%ebp)
  80039d:	68 18 22 80 00       	push   $0x802218
  8003a2:	e8 02 04 00 00       	call   8007a9 <cprintf>
  8003a7:	83 c4 10             	add    $0x10,%esp
  8003aa:	eb 59                	jmp    800405 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bc:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	52                   	push   %edx
  8003c6:	50                   	push   %eax
  8003c7:	68 3c 22 80 00       	push   $0x80223c
  8003cc:	e8 d8 03 00 00       	call   8007a9 <cprintf>
  8003d1:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d9:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003df:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e4:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8003f5:	51                   	push   %ecx
  8003f6:	52                   	push   %edx
  8003f7:	50                   	push   %eax
  8003f8:	68 64 22 80 00       	push   $0x802264
  8003fd:	e8 a7 03 00 00       	call   8007a9 <cprintf>
  800402:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800405:	a1 20 30 80 00       	mov    0x803020,%eax
  80040a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800410:	83 ec 08             	sub    $0x8,%esp
  800413:	50                   	push   %eax
  800414:	68 bc 22 80 00       	push   $0x8022bc
  800419:	e8 8b 03 00 00       	call   8007a9 <cprintf>
  80041e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800421:	83 ec 0c             	sub    $0xc,%esp
  800424:	68 d0 22 80 00       	push   $0x8022d0
  800429:	e8 7b 03 00 00       	call   8007a9 <cprintf>
  80042e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800431:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800438:	eb 28                	jmp    800462 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80043a:	a1 20 30 80 00       	mov    0x803020,%eax
  80043f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800442:	81 c2 74 04 00 00    	add    $0x474,%edx
  800448:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80044b:	83 ec 04             	sub    $0x4,%esp
  80044e:	50                   	push   %eax
  80044f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800452:	68 e7 22 80 00       	push   $0x8022e7
  800457:	e8 4d 03 00 00       	call   8007a9 <cprintf>
  80045c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80045f:	ff 45 e4             	incl   -0x1c(%ebp)
  800462:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800466:	7e d2                	jle    80043a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800468:	83 ec 0c             	sub    $0xc,%esp
  80046b:	68 f6 22 80 00       	push   $0x8022f6
  800470:	e8 34 03 00 00       	call   8007a9 <cprintf>
  800475:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800478:	a1 20 30 80 00       	mov    0x803020,%eax
  80047d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800483:	83 ec 08             	sub    $0x8,%esp
  800486:	50                   	push   %eax
  800487:	68 fa 22 80 00       	push   $0x8022fa
  80048c:	e8 18 03 00 00       	call   8007a9 <cprintf>
  800491:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	68 f0 21 80 00       	push   $0x8021f0
  80049c:	e8 08 03 00 00       	call   8007a9 <cprintf>
  8004a1:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004a4:	e8 6e 12 00 00       	call   801717 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004a9:	e8 1f 00 00 00       	call   8004cd <exit>
}
  8004ae:	90                   	nop
  8004af:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004b2:	5b                   	pop    %ebx
  8004b3:	5e                   	pop    %esi
  8004b4:	5f                   	pop    %edi
  8004b5:	5d                   	pop    %ebp
  8004b6:	c3                   	ret    

008004b7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004b7:	55                   	push   %ebp
  8004b8:	89 e5                	mov    %esp,%ebp
  8004ba:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004bd:	83 ec 0c             	sub    $0xc,%esp
  8004c0:	6a 00                	push   $0x0
  8004c2:	e8 7a 14 00 00       	call   801941 <sys_destroy_env>
  8004c7:	83 c4 10             	add    $0x10,%esp
}
  8004ca:	90                   	nop
  8004cb:	c9                   	leave  
  8004cc:	c3                   	ret    

008004cd <exit>:

void
exit(void)
{
  8004cd:	55                   	push   %ebp
  8004ce:	89 e5                	mov    %esp,%ebp
  8004d0:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004d3:	e8 cf 14 00 00       	call   8019a7 <sys_exit_env>
}
  8004d8:	90                   	nop
  8004d9:	c9                   	leave  
  8004da:	c3                   	ret    

008004db <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004db:	55                   	push   %ebp
  8004dc:	89 e5                	mov    %esp,%ebp
  8004de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004e1:	8d 45 10             	lea    0x10(%ebp),%eax
  8004e4:	83 c0 04             	add    $0x4,%eax
  8004e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004ea:	a1 28 31 80 00       	mov    0x803128,%eax
  8004ef:	85 c0                	test   %eax,%eax
  8004f1:	74 16                	je     800509 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004f3:	a1 28 31 80 00       	mov    0x803128,%eax
  8004f8:	83 ec 08             	sub    $0x8,%esp
  8004fb:	50                   	push   %eax
  8004fc:	68 dc 23 80 00       	push   $0x8023dc
  800501:	e8 a3 02 00 00       	call   8007a9 <cprintf>
  800506:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800509:	a1 04 30 80 00       	mov    0x803004,%eax
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	ff 75 0c             	pushl  0xc(%ebp)
  800514:	ff 75 08             	pushl  0x8(%ebp)
  800517:	50                   	push   %eax
  800518:	68 e4 23 80 00       	push   $0x8023e4
  80051d:	6a 74                	push   $0x74
  80051f:	e8 b2 02 00 00       	call   8007d6 <cprintf_colored>
  800524:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800527:	8b 45 10             	mov    0x10(%ebp),%eax
  80052a:	83 ec 08             	sub    $0x8,%esp
  80052d:	ff 75 f4             	pushl  -0xc(%ebp)
  800530:	50                   	push   %eax
  800531:	e8 04 02 00 00       	call   80073a <vcprintf>
  800536:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800539:	83 ec 08             	sub    $0x8,%esp
  80053c:	6a 00                	push   $0x0
  80053e:	68 0c 24 80 00       	push   $0x80240c
  800543:	e8 f2 01 00 00       	call   80073a <vcprintf>
  800548:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80054b:	e8 7d ff ff ff       	call   8004cd <exit>

	// should not return here
	while (1) ;
  800550:	eb fe                	jmp    800550 <_panic+0x75>

00800552 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800552:	55                   	push   %ebp
  800553:	89 e5                	mov    %esp,%ebp
  800555:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800563:	8b 45 0c             	mov    0xc(%ebp),%eax
  800566:	39 c2                	cmp    %eax,%edx
  800568:	74 14                	je     80057e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 10 24 80 00       	push   $0x802410
  800572:	6a 26                	push   $0x26
  800574:	68 5c 24 80 00       	push   $0x80245c
  800579:	e8 5d ff ff ff       	call   8004db <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80057e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800585:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80058c:	e9 c5 00 00 00       	jmp    800656 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800591:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800594:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059b:	8b 45 08             	mov    0x8(%ebp),%eax
  80059e:	01 d0                	add    %edx,%eax
  8005a0:	8b 00                	mov    (%eax),%eax
  8005a2:	85 c0                	test   %eax,%eax
  8005a4:	75 08                	jne    8005ae <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005a6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005a9:	e9 a5 00 00 00       	jmp    800653 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005b5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005bc:	eb 69                	jmp    800627 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005be:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005c9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005cc:	89 d0                	mov    %edx,%eax
  8005ce:	01 c0                	add    %eax,%eax
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	c1 e0 03             	shl    $0x3,%eax
  8005d5:	01 c8                	add    %ecx,%eax
  8005d7:	8a 40 04             	mov    0x4(%eax),%al
  8005da:	84 c0                	test   %al,%al
  8005dc:	75 46                	jne    800624 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005de:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005ec:	89 d0                	mov    %edx,%eax
  8005ee:	01 c0                	add    %eax,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	c1 e0 03             	shl    $0x3,%eax
  8005f5:	01 c8                	add    %ecx,%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800604:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800606:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800609:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	01 c8                	add    %ecx,%eax
  800615:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800617:	39 c2                	cmp    %eax,%edx
  800619:	75 09                	jne    800624 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80061b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800622:	eb 15                	jmp    800639 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800624:	ff 45 e8             	incl   -0x18(%ebp)
  800627:	a1 20 30 80 00       	mov    0x803020,%eax
  80062c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800632:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800635:	39 c2                	cmp    %eax,%edx
  800637:	77 85                	ja     8005be <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800639:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80063d:	75 14                	jne    800653 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80063f:	83 ec 04             	sub    $0x4,%esp
  800642:	68 68 24 80 00       	push   $0x802468
  800647:	6a 3a                	push   $0x3a
  800649:	68 5c 24 80 00       	push   $0x80245c
  80064e:	e8 88 fe ff ff       	call   8004db <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800653:	ff 45 f0             	incl   -0x10(%ebp)
  800656:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800659:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80065c:	0f 8c 2f ff ff ff    	jl     800591 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800662:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800669:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800670:	eb 26                	jmp    800698 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800672:	a1 20 30 80 00       	mov    0x803020,%eax
  800677:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80067d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800680:	89 d0                	mov    %edx,%eax
  800682:	01 c0                	add    %eax,%eax
  800684:	01 d0                	add    %edx,%eax
  800686:	c1 e0 03             	shl    $0x3,%eax
  800689:	01 c8                	add    %ecx,%eax
  80068b:	8a 40 04             	mov    0x4(%eax),%al
  80068e:	3c 01                	cmp    $0x1,%al
  800690:	75 03                	jne    800695 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800692:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800695:	ff 45 e0             	incl   -0x20(%ebp)
  800698:	a1 20 30 80 00       	mov    0x803020,%eax
  80069d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a6:	39 c2                	cmp    %eax,%edx
  8006a8:	77 c8                	ja     800672 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006b0:	74 14                	je     8006c6 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006b2:	83 ec 04             	sub    $0x4,%esp
  8006b5:	68 bc 24 80 00       	push   $0x8024bc
  8006ba:	6a 44                	push   $0x44
  8006bc:	68 5c 24 80 00       	push   $0x80245c
  8006c1:	e8 15 fe ff ff       	call   8004db <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006c6:	90                   	nop
  8006c7:	c9                   	leave  
  8006c8:	c3                   	ret    

008006c9 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8006c9:	55                   	push   %ebp
  8006ca:	89 e5                	mov    %esp,%ebp
  8006cc:	53                   	push   %ebx
  8006cd:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8006d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	8d 48 01             	lea    0x1(%eax),%ecx
  8006d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006db:	89 0a                	mov    %ecx,(%edx)
  8006dd:	8b 55 08             	mov    0x8(%ebp),%edx
  8006e0:	88 d1                	mov    %dl,%cl
  8006e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ec:	8b 00                	mov    (%eax),%eax
  8006ee:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006f3:	75 30                	jne    800725 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8006f5:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8006fb:	a0 40 30 80 00       	mov    0x803040,%al
  800700:	0f b6 c0             	movzbl %al,%eax
  800703:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800706:	8b 09                	mov    (%ecx),%ecx
  800708:	89 cb                	mov    %ecx,%ebx
  80070a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80070d:	83 c1 08             	add    $0x8,%ecx
  800710:	52                   	push   %edx
  800711:	50                   	push   %eax
  800712:	53                   	push   %ebx
  800713:	51                   	push   %ecx
  800714:	e8 a0 0f 00 00       	call   8016b9 <sys_cputs>
  800719:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80071c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80071f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800725:	8b 45 0c             	mov    0xc(%ebp),%eax
  800728:	8b 40 04             	mov    0x4(%eax),%eax
  80072b:	8d 50 01             	lea    0x1(%eax),%edx
  80072e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800731:	89 50 04             	mov    %edx,0x4(%eax)
}
  800734:	90                   	nop
  800735:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800738:	c9                   	leave  
  800739:	c3                   	ret    

0080073a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80073a:	55                   	push   %ebp
  80073b:	89 e5                	mov    %esp,%ebp
  80073d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800743:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80074a:	00 00 00 
	b.cnt = 0;
  80074d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800754:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	ff 75 08             	pushl  0x8(%ebp)
  80075d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800763:	50                   	push   %eax
  800764:	68 c9 06 80 00       	push   $0x8006c9
  800769:	e8 5a 02 00 00       	call   8009c8 <vprintfmt>
  80076e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800771:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800777:	a0 40 30 80 00       	mov    0x803040,%al
  80077c:	0f b6 c0             	movzbl %al,%eax
  80077f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800785:	52                   	push   %edx
  800786:	50                   	push   %eax
  800787:	51                   	push   %ecx
  800788:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80078e:	83 c0 08             	add    $0x8,%eax
  800791:	50                   	push   %eax
  800792:	e8 22 0f 00 00       	call   8016b9 <sys_cputs>
  800797:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80079a:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007a1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007a7:	c9                   	leave  
  8007a8:	c3                   	ret    

008007a9 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007af:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007b6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c5:	50                   	push   %eax
  8007c6:	e8 6f ff ff ff       	call   80073a <vcprintf>
  8007cb:	83 c4 10             	add    $0x10,%esp
  8007ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007d4:	c9                   	leave  
  8007d5:	c3                   	ret    

008007d6 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007d6:	55                   	push   %ebp
  8007d7:	89 e5                	mov    %esp,%ebp
  8007d9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007dc:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	c1 e0 08             	shl    $0x8,%eax
  8007e9:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8007ee:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007f1:	83 c0 04             	add    $0x4,%eax
  8007f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fa:	83 ec 08             	sub    $0x8,%esp
  8007fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800800:	50                   	push   %eax
  800801:	e8 34 ff ff ff       	call   80073a <vcprintf>
  800806:	83 c4 10             	add    $0x10,%esp
  800809:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80080c:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800813:	07 00 00 

	return cnt;
  800816:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800819:	c9                   	leave  
  80081a:	c3                   	ret    

0080081b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80081b:	55                   	push   %ebp
  80081c:	89 e5                	mov    %esp,%ebp
  80081e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800821:	e8 d7 0e 00 00       	call   8016fd <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800826:	8d 45 0c             	lea    0xc(%ebp),%eax
  800829:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	83 ec 08             	sub    $0x8,%esp
  800832:	ff 75 f4             	pushl  -0xc(%ebp)
  800835:	50                   	push   %eax
  800836:	e8 ff fe ff ff       	call   80073a <vcprintf>
  80083b:	83 c4 10             	add    $0x10,%esp
  80083e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800841:	e8 d1 0e 00 00       	call   801717 <sys_unlock_cons>
	return cnt;
  800846:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800849:	c9                   	leave  
  80084a:	c3                   	ret    

0080084b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80084b:	55                   	push   %ebp
  80084c:	89 e5                	mov    %esp,%ebp
  80084e:	53                   	push   %ebx
  80084f:	83 ec 14             	sub    $0x14,%esp
  800852:	8b 45 10             	mov    0x10(%ebp),%eax
  800855:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800858:	8b 45 14             	mov    0x14(%ebp),%eax
  80085b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80085e:	8b 45 18             	mov    0x18(%ebp),%eax
  800861:	ba 00 00 00 00       	mov    $0x0,%edx
  800866:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800869:	77 55                	ja     8008c0 <printnum+0x75>
  80086b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80086e:	72 05                	jb     800875 <printnum+0x2a>
  800870:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800873:	77 4b                	ja     8008c0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800875:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800878:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80087b:	8b 45 18             	mov    0x18(%ebp),%eax
  80087e:	ba 00 00 00 00       	mov    $0x0,%edx
  800883:	52                   	push   %edx
  800884:	50                   	push   %eax
  800885:	ff 75 f4             	pushl  -0xc(%ebp)
  800888:	ff 75 f0             	pushl  -0x10(%ebp)
  80088b:	e8 30 14 00 00       	call   801cc0 <__udivdi3>
  800890:	83 c4 10             	add    $0x10,%esp
  800893:	83 ec 04             	sub    $0x4,%esp
  800896:	ff 75 20             	pushl  0x20(%ebp)
  800899:	53                   	push   %ebx
  80089a:	ff 75 18             	pushl  0x18(%ebp)
  80089d:	52                   	push   %edx
  80089e:	50                   	push   %eax
  80089f:	ff 75 0c             	pushl  0xc(%ebp)
  8008a2:	ff 75 08             	pushl  0x8(%ebp)
  8008a5:	e8 a1 ff ff ff       	call   80084b <printnum>
  8008aa:	83 c4 20             	add    $0x20,%esp
  8008ad:	eb 1a                	jmp    8008c9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008af:	83 ec 08             	sub    $0x8,%esp
  8008b2:	ff 75 0c             	pushl  0xc(%ebp)
  8008b5:	ff 75 20             	pushl  0x20(%ebp)
  8008b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bb:	ff d0                	call   *%eax
  8008bd:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008c0:	ff 4d 1c             	decl   0x1c(%ebp)
  8008c3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008c7:	7f e6                	jg     8008af <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008c9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008cc:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d7:	53                   	push   %ebx
  8008d8:	51                   	push   %ecx
  8008d9:	52                   	push   %edx
  8008da:	50                   	push   %eax
  8008db:	e8 f0 14 00 00       	call   801dd0 <__umoddi3>
  8008e0:	83 c4 10             	add    $0x10,%esp
  8008e3:	05 34 27 80 00       	add    $0x802734,%eax
  8008e8:	8a 00                	mov    (%eax),%al
  8008ea:	0f be c0             	movsbl %al,%eax
  8008ed:	83 ec 08             	sub    $0x8,%esp
  8008f0:	ff 75 0c             	pushl  0xc(%ebp)
  8008f3:	50                   	push   %eax
  8008f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f7:	ff d0                	call   *%eax
  8008f9:	83 c4 10             	add    $0x10,%esp
}
  8008fc:	90                   	nop
  8008fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800900:	c9                   	leave  
  800901:	c3                   	ret    

00800902 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800902:	55                   	push   %ebp
  800903:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800905:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800909:	7e 1c                	jle    800927 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	8b 00                	mov    (%eax),%eax
  800910:	8d 50 08             	lea    0x8(%eax),%edx
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	89 10                	mov    %edx,(%eax)
  800918:	8b 45 08             	mov    0x8(%ebp),%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	83 e8 08             	sub    $0x8,%eax
  800920:	8b 50 04             	mov    0x4(%eax),%edx
  800923:	8b 00                	mov    (%eax),%eax
  800925:	eb 40                	jmp    800967 <getuint+0x65>
	else if (lflag)
  800927:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80092b:	74 1e                	je     80094b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	8d 50 04             	lea    0x4(%eax),%edx
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	89 10                	mov    %edx,(%eax)
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	83 e8 04             	sub    $0x4,%eax
  800942:	8b 00                	mov    (%eax),%eax
  800944:	ba 00 00 00 00       	mov    $0x0,%edx
  800949:	eb 1c                	jmp    800967 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80094b:	8b 45 08             	mov    0x8(%ebp),%eax
  80094e:	8b 00                	mov    (%eax),%eax
  800950:	8d 50 04             	lea    0x4(%eax),%edx
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	89 10                	mov    %edx,(%eax)
  800958:	8b 45 08             	mov    0x8(%ebp),%eax
  80095b:	8b 00                	mov    (%eax),%eax
  80095d:	83 e8 04             	sub    $0x4,%eax
  800960:	8b 00                	mov    (%eax),%eax
  800962:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800967:	5d                   	pop    %ebp
  800968:	c3                   	ret    

00800969 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800969:	55                   	push   %ebp
  80096a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80096c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800970:	7e 1c                	jle    80098e <getint+0x25>
		return va_arg(*ap, long long);
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	8b 00                	mov    (%eax),%eax
  800977:	8d 50 08             	lea    0x8(%eax),%edx
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	89 10                	mov    %edx,(%eax)
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	8b 00                	mov    (%eax),%eax
  800984:	83 e8 08             	sub    $0x8,%eax
  800987:	8b 50 04             	mov    0x4(%eax),%edx
  80098a:	8b 00                	mov    (%eax),%eax
  80098c:	eb 38                	jmp    8009c6 <getint+0x5d>
	else if (lflag)
  80098e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800992:	74 1a                	je     8009ae <getint+0x45>
		return va_arg(*ap, long);
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	8b 00                	mov    (%eax),%eax
  800999:	8d 50 04             	lea    0x4(%eax),%edx
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	89 10                	mov    %edx,(%eax)
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	8b 00                	mov    (%eax),%eax
  8009a6:	83 e8 04             	sub    $0x4,%eax
  8009a9:	8b 00                	mov    (%eax),%eax
  8009ab:	99                   	cltd   
  8009ac:	eb 18                	jmp    8009c6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	8b 00                	mov    (%eax),%eax
  8009b3:	8d 50 04             	lea    0x4(%eax),%edx
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	89 10                	mov    %edx,(%eax)
  8009bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009be:	8b 00                	mov    (%eax),%eax
  8009c0:	83 e8 04             	sub    $0x4,%eax
  8009c3:	8b 00                	mov    (%eax),%eax
  8009c5:	99                   	cltd   
}
  8009c6:	5d                   	pop    %ebp
  8009c7:	c3                   	ret    

008009c8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009c8:	55                   	push   %ebp
  8009c9:	89 e5                	mov    %esp,%ebp
  8009cb:	56                   	push   %esi
  8009cc:	53                   	push   %ebx
  8009cd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009d0:	eb 17                	jmp    8009e9 <vprintfmt+0x21>
			if (ch == '\0')
  8009d2:	85 db                	test   %ebx,%ebx
  8009d4:	0f 84 c1 03 00 00    	je     800d9b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	53                   	push   %ebx
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ec:	8d 50 01             	lea    0x1(%eax),%edx
  8009ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	0f b6 d8             	movzbl %al,%ebx
  8009f7:	83 fb 25             	cmp    $0x25,%ebx
  8009fa:	75 d6                	jne    8009d2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009fc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a00:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a07:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a0e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a15:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1f:	8d 50 01             	lea    0x1(%eax),%edx
  800a22:	89 55 10             	mov    %edx,0x10(%ebp)
  800a25:	8a 00                	mov    (%eax),%al
  800a27:	0f b6 d8             	movzbl %al,%ebx
  800a2a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a2d:	83 f8 5b             	cmp    $0x5b,%eax
  800a30:	0f 87 3d 03 00 00    	ja     800d73 <vprintfmt+0x3ab>
  800a36:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  800a3d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a3f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a43:	eb d7                	jmp    800a1c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a45:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a49:	eb d1                	jmp    800a1c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a4b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a52:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a55:	89 d0                	mov    %edx,%eax
  800a57:	c1 e0 02             	shl    $0x2,%eax
  800a5a:	01 d0                	add    %edx,%eax
  800a5c:	01 c0                	add    %eax,%eax
  800a5e:	01 d8                	add    %ebx,%eax
  800a60:	83 e8 30             	sub    $0x30,%eax
  800a63:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a66:	8b 45 10             	mov    0x10(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a6e:	83 fb 2f             	cmp    $0x2f,%ebx
  800a71:	7e 3e                	jle    800ab1 <vprintfmt+0xe9>
  800a73:	83 fb 39             	cmp    $0x39,%ebx
  800a76:	7f 39                	jg     800ab1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a78:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a7b:	eb d5                	jmp    800a52 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a80:	83 c0 04             	add    $0x4,%eax
  800a83:	89 45 14             	mov    %eax,0x14(%ebp)
  800a86:	8b 45 14             	mov    0x14(%ebp),%eax
  800a89:	83 e8 04             	sub    $0x4,%eax
  800a8c:	8b 00                	mov    (%eax),%eax
  800a8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a91:	eb 1f                	jmp    800ab2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a93:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a97:	79 83                	jns    800a1c <vprintfmt+0x54>
				width = 0;
  800a99:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800aa0:	e9 77 ff ff ff       	jmp    800a1c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800aa5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aac:	e9 6b ff ff ff       	jmp    800a1c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ab1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ab2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab6:	0f 89 60 ff ff ff    	jns    800a1c <vprintfmt+0x54>
				width = precision, precision = -1;
  800abc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800abf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ac2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ac9:	e9 4e ff ff ff       	jmp    800a1c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ace:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ad1:	e9 46 ff ff ff       	jmp    800a1c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ad6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad9:	83 c0 04             	add    $0x4,%eax
  800adc:	89 45 14             	mov    %eax,0x14(%ebp)
  800adf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae2:	83 e8 04             	sub    $0x4,%eax
  800ae5:	8b 00                	mov    (%eax),%eax
  800ae7:	83 ec 08             	sub    $0x8,%esp
  800aea:	ff 75 0c             	pushl  0xc(%ebp)
  800aed:	50                   	push   %eax
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	ff d0                	call   *%eax
  800af3:	83 c4 10             	add    $0x10,%esp
			break;
  800af6:	e9 9b 02 00 00       	jmp    800d96 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800afb:	8b 45 14             	mov    0x14(%ebp),%eax
  800afe:	83 c0 04             	add    $0x4,%eax
  800b01:	89 45 14             	mov    %eax,0x14(%ebp)
  800b04:	8b 45 14             	mov    0x14(%ebp),%eax
  800b07:	83 e8 04             	sub    $0x4,%eax
  800b0a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b0c:	85 db                	test   %ebx,%ebx
  800b0e:	79 02                	jns    800b12 <vprintfmt+0x14a>
				err = -err;
  800b10:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b12:	83 fb 64             	cmp    $0x64,%ebx
  800b15:	7f 0b                	jg     800b22 <vprintfmt+0x15a>
  800b17:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800b1e:	85 f6                	test   %esi,%esi
  800b20:	75 19                	jne    800b3b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b22:	53                   	push   %ebx
  800b23:	68 45 27 80 00       	push   $0x802745
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 08             	pushl  0x8(%ebp)
  800b2e:	e8 70 02 00 00       	call   800da3 <printfmt>
  800b33:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b36:	e9 5b 02 00 00       	jmp    800d96 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b3b:	56                   	push   %esi
  800b3c:	68 4e 27 80 00       	push   $0x80274e
  800b41:	ff 75 0c             	pushl  0xc(%ebp)
  800b44:	ff 75 08             	pushl  0x8(%ebp)
  800b47:	e8 57 02 00 00       	call   800da3 <printfmt>
  800b4c:	83 c4 10             	add    $0x10,%esp
			break;
  800b4f:	e9 42 02 00 00       	jmp    800d96 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b54:	8b 45 14             	mov    0x14(%ebp),%eax
  800b57:	83 c0 04             	add    $0x4,%eax
  800b5a:	89 45 14             	mov    %eax,0x14(%ebp)
  800b5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b60:	83 e8 04             	sub    $0x4,%eax
  800b63:	8b 30                	mov    (%eax),%esi
  800b65:	85 f6                	test   %esi,%esi
  800b67:	75 05                	jne    800b6e <vprintfmt+0x1a6>
				p = "(null)";
  800b69:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800b6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b72:	7e 6d                	jle    800be1 <vprintfmt+0x219>
  800b74:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b78:	74 67                	je     800be1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b7d:	83 ec 08             	sub    $0x8,%esp
  800b80:	50                   	push   %eax
  800b81:	56                   	push   %esi
  800b82:	e8 1e 03 00 00       	call   800ea5 <strnlen>
  800b87:	83 c4 10             	add    $0x10,%esp
  800b8a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b8d:	eb 16                	jmp    800ba5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b8f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b93:	83 ec 08             	sub    $0x8,%esp
  800b96:	ff 75 0c             	pushl  0xc(%ebp)
  800b99:	50                   	push   %eax
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	ff d0                	call   *%eax
  800b9f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ba2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ba5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ba9:	7f e4                	jg     800b8f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bab:	eb 34                	jmp    800be1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bad:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bb1:	74 1c                	je     800bcf <vprintfmt+0x207>
  800bb3:	83 fb 1f             	cmp    $0x1f,%ebx
  800bb6:	7e 05                	jle    800bbd <vprintfmt+0x1f5>
  800bb8:	83 fb 7e             	cmp    $0x7e,%ebx
  800bbb:	7e 12                	jle    800bcf <vprintfmt+0x207>
					putch('?', putdat);
  800bbd:	83 ec 08             	sub    $0x8,%esp
  800bc0:	ff 75 0c             	pushl  0xc(%ebp)
  800bc3:	6a 3f                	push   $0x3f
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	ff d0                	call   *%eax
  800bca:	83 c4 10             	add    $0x10,%esp
  800bcd:	eb 0f                	jmp    800bde <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bcf:	83 ec 08             	sub    $0x8,%esp
  800bd2:	ff 75 0c             	pushl  0xc(%ebp)
  800bd5:	53                   	push   %ebx
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	ff d0                	call   *%eax
  800bdb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bde:	ff 4d e4             	decl   -0x1c(%ebp)
  800be1:	89 f0                	mov    %esi,%eax
  800be3:	8d 70 01             	lea    0x1(%eax),%esi
  800be6:	8a 00                	mov    (%eax),%al
  800be8:	0f be d8             	movsbl %al,%ebx
  800beb:	85 db                	test   %ebx,%ebx
  800bed:	74 24                	je     800c13 <vprintfmt+0x24b>
  800bef:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bf3:	78 b8                	js     800bad <vprintfmt+0x1e5>
  800bf5:	ff 4d e0             	decl   -0x20(%ebp)
  800bf8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bfc:	79 af                	jns    800bad <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bfe:	eb 13                	jmp    800c13 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c00:	83 ec 08             	sub    $0x8,%esp
  800c03:	ff 75 0c             	pushl  0xc(%ebp)
  800c06:	6a 20                	push   $0x20
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	ff d0                	call   *%eax
  800c0d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c10:	ff 4d e4             	decl   -0x1c(%ebp)
  800c13:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c17:	7f e7                	jg     800c00 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c19:	e9 78 01 00 00       	jmp    800d96 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c1e:	83 ec 08             	sub    $0x8,%esp
  800c21:	ff 75 e8             	pushl  -0x18(%ebp)
  800c24:	8d 45 14             	lea    0x14(%ebp),%eax
  800c27:	50                   	push   %eax
  800c28:	e8 3c fd ff ff       	call   800969 <getint>
  800c2d:	83 c4 10             	add    $0x10,%esp
  800c30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c39:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c3c:	85 d2                	test   %edx,%edx
  800c3e:	79 23                	jns    800c63 <vprintfmt+0x29b>
				putch('-', putdat);
  800c40:	83 ec 08             	sub    $0x8,%esp
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	6a 2d                	push   $0x2d
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	ff d0                	call   *%eax
  800c4d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c56:	f7 d8                	neg    %eax
  800c58:	83 d2 00             	adc    $0x0,%edx
  800c5b:	f7 da                	neg    %edx
  800c5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c60:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c63:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c6a:	e9 bc 00 00 00       	jmp    800d2b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c6f:	83 ec 08             	sub    $0x8,%esp
  800c72:	ff 75 e8             	pushl  -0x18(%ebp)
  800c75:	8d 45 14             	lea    0x14(%ebp),%eax
  800c78:	50                   	push   %eax
  800c79:	e8 84 fc ff ff       	call   800902 <getuint>
  800c7e:	83 c4 10             	add    $0x10,%esp
  800c81:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c84:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c87:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c8e:	e9 98 00 00 00       	jmp    800d2b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 0c             	pushl  0xc(%ebp)
  800c99:	6a 58                	push   $0x58
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	ff d0                	call   *%eax
  800ca0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ca3:	83 ec 08             	sub    $0x8,%esp
  800ca6:	ff 75 0c             	pushl  0xc(%ebp)
  800ca9:	6a 58                	push   $0x58
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	ff d0                	call   *%eax
  800cb0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cb3:	83 ec 08             	sub    $0x8,%esp
  800cb6:	ff 75 0c             	pushl  0xc(%ebp)
  800cb9:	6a 58                	push   $0x58
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	ff d0                	call   *%eax
  800cc0:	83 c4 10             	add    $0x10,%esp
			break;
  800cc3:	e9 ce 00 00 00       	jmp    800d96 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800cc8:	83 ec 08             	sub    $0x8,%esp
  800ccb:	ff 75 0c             	pushl  0xc(%ebp)
  800cce:	6a 30                	push   $0x30
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	ff d0                	call   *%eax
  800cd5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cd8:	83 ec 08             	sub    $0x8,%esp
  800cdb:	ff 75 0c             	pushl  0xc(%ebp)
  800cde:	6a 78                	push   $0x78
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	ff d0                	call   *%eax
  800ce5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ce8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ceb:	83 c0 04             	add    $0x4,%eax
  800cee:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf4:	83 e8 04             	sub    $0x4,%eax
  800cf7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cf9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d03:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d0a:	eb 1f                	jmp    800d2b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d0c:	83 ec 08             	sub    $0x8,%esp
  800d0f:	ff 75 e8             	pushl  -0x18(%ebp)
  800d12:	8d 45 14             	lea    0x14(%ebp),%eax
  800d15:	50                   	push   %eax
  800d16:	e8 e7 fb ff ff       	call   800902 <getuint>
  800d1b:	83 c4 10             	add    $0x10,%esp
  800d1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d21:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d24:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d2b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d32:	83 ec 04             	sub    $0x4,%esp
  800d35:	52                   	push   %edx
  800d36:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d39:	50                   	push   %eax
  800d3a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3d:	ff 75 f0             	pushl  -0x10(%ebp)
  800d40:	ff 75 0c             	pushl  0xc(%ebp)
  800d43:	ff 75 08             	pushl  0x8(%ebp)
  800d46:	e8 00 fb ff ff       	call   80084b <printnum>
  800d4b:	83 c4 20             	add    $0x20,%esp
			break;
  800d4e:	eb 46                	jmp    800d96 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d50:	83 ec 08             	sub    $0x8,%esp
  800d53:	ff 75 0c             	pushl  0xc(%ebp)
  800d56:	53                   	push   %ebx
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	ff d0                	call   *%eax
  800d5c:	83 c4 10             	add    $0x10,%esp
			break;
  800d5f:	eb 35                	jmp    800d96 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d61:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d68:	eb 2c                	jmp    800d96 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d6a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d71:	eb 23                	jmp    800d96 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d73:	83 ec 08             	sub    $0x8,%esp
  800d76:	ff 75 0c             	pushl  0xc(%ebp)
  800d79:	6a 25                	push   $0x25
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	ff d0                	call   *%eax
  800d80:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d83:	ff 4d 10             	decl   0x10(%ebp)
  800d86:	eb 03                	jmp    800d8b <vprintfmt+0x3c3>
  800d88:	ff 4d 10             	decl   0x10(%ebp)
  800d8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8e:	48                   	dec    %eax
  800d8f:	8a 00                	mov    (%eax),%al
  800d91:	3c 25                	cmp    $0x25,%al
  800d93:	75 f3                	jne    800d88 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800d95:	90                   	nop
		}
	}
  800d96:	e9 35 fc ff ff       	jmp    8009d0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d9b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d9c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d9f:	5b                   	pop    %ebx
  800da0:	5e                   	pop    %esi
  800da1:	5d                   	pop    %ebp
  800da2:	c3                   	ret    

00800da3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800da3:	55                   	push   %ebp
  800da4:	89 e5                	mov    %esp,%ebp
  800da6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800da9:	8d 45 10             	lea    0x10(%ebp),%eax
  800dac:	83 c0 04             	add    $0x4,%eax
  800daf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800db2:	8b 45 10             	mov    0x10(%ebp),%eax
  800db5:	ff 75 f4             	pushl  -0xc(%ebp)
  800db8:	50                   	push   %eax
  800db9:	ff 75 0c             	pushl  0xc(%ebp)
  800dbc:	ff 75 08             	pushl  0x8(%ebp)
  800dbf:	e8 04 fc ff ff       	call   8009c8 <vprintfmt>
  800dc4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dc7:	90                   	nop
  800dc8:	c9                   	leave  
  800dc9:	c3                   	ret    

00800dca <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800dca:	55                   	push   %ebp
  800dcb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd0:	8b 40 08             	mov    0x8(%eax),%eax
  800dd3:	8d 50 01             	lea    0x1(%eax),%edx
  800dd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddf:	8b 10                	mov    (%eax),%edx
  800de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de4:	8b 40 04             	mov    0x4(%eax),%eax
  800de7:	39 c2                	cmp    %eax,%edx
  800de9:	73 12                	jae    800dfd <sprintputch+0x33>
		*b->buf++ = ch;
  800deb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dee:	8b 00                	mov    (%eax),%eax
  800df0:	8d 48 01             	lea    0x1(%eax),%ecx
  800df3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df6:	89 0a                	mov    %ecx,(%edx)
  800df8:	8b 55 08             	mov    0x8(%ebp),%edx
  800dfb:	88 10                	mov    %dl,(%eax)
}
  800dfd:	90                   	nop
  800dfe:	5d                   	pop    %ebp
  800dff:	c3                   	ret    

00800e00 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e06:	8b 45 08             	mov    0x8(%ebp),%eax
  800e09:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	01 d0                	add    %edx,%eax
  800e17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e21:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e25:	74 06                	je     800e2d <vsnprintf+0x2d>
  800e27:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e2b:	7f 07                	jg     800e34 <vsnprintf+0x34>
		return -E_INVAL;
  800e2d:	b8 03 00 00 00       	mov    $0x3,%eax
  800e32:	eb 20                	jmp    800e54 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e34:	ff 75 14             	pushl  0x14(%ebp)
  800e37:	ff 75 10             	pushl  0x10(%ebp)
  800e3a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e3d:	50                   	push   %eax
  800e3e:	68 ca 0d 80 00       	push   $0x800dca
  800e43:	e8 80 fb ff ff       	call   8009c8 <vprintfmt>
  800e48:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e4e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e54:	c9                   	leave  
  800e55:	c3                   	ret    

00800e56 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e56:	55                   	push   %ebp
  800e57:	89 e5                	mov    %esp,%ebp
  800e59:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e5c:	8d 45 10             	lea    0x10(%ebp),%eax
  800e5f:	83 c0 04             	add    $0x4,%eax
  800e62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e65:	8b 45 10             	mov    0x10(%ebp),%eax
  800e68:	ff 75 f4             	pushl  -0xc(%ebp)
  800e6b:	50                   	push   %eax
  800e6c:	ff 75 0c             	pushl  0xc(%ebp)
  800e6f:	ff 75 08             	pushl  0x8(%ebp)
  800e72:	e8 89 ff ff ff       	call   800e00 <vsnprintf>
  800e77:	83 c4 10             	add    $0x10,%esp
  800e7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e80:	c9                   	leave  
  800e81:	c3                   	ret    

00800e82 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e8f:	eb 06                	jmp    800e97 <strlen+0x15>
		n++;
  800e91:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e94:	ff 45 08             	incl   0x8(%ebp)
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	84 c0                	test   %al,%al
  800e9e:	75 f1                	jne    800e91 <strlen+0xf>
		n++;
	return n;
  800ea0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ea3:	c9                   	leave  
  800ea4:	c3                   	ret    

00800ea5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ea5:	55                   	push   %ebp
  800ea6:	89 e5                	mov    %esp,%ebp
  800ea8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eb2:	eb 09                	jmp    800ebd <strnlen+0x18>
		n++;
  800eb4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eb7:	ff 45 08             	incl   0x8(%ebp)
  800eba:	ff 4d 0c             	decl   0xc(%ebp)
  800ebd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ec1:	74 09                	je     800ecc <strnlen+0x27>
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	8a 00                	mov    (%eax),%al
  800ec8:	84 c0                	test   %al,%al
  800eca:	75 e8                	jne    800eb4 <strnlen+0xf>
		n++;
	return n;
  800ecc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ecf:	c9                   	leave  
  800ed0:	c3                   	ret    

00800ed1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800edd:	90                   	nop
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8d 50 01             	lea    0x1(%eax),%edx
  800ee4:	89 55 08             	mov    %edx,0x8(%ebp)
  800ee7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eed:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ef0:	8a 12                	mov    (%edx),%dl
  800ef2:	88 10                	mov    %dl,(%eax)
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	84 c0                	test   %al,%al
  800ef8:	75 e4                	jne    800ede <strcpy+0xd>
		/* do nothing */;
	return ret;
  800efa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f12:	eb 1f                	jmp    800f33 <strncpy+0x34>
		*dst++ = *src;
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8d 50 01             	lea    0x1(%eax),%edx
  800f1a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f20:	8a 12                	mov    (%edx),%dl
  800f22:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	84 c0                	test   %al,%al
  800f2b:	74 03                	je     800f30 <strncpy+0x31>
			src++;
  800f2d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f30:	ff 45 fc             	incl   -0x4(%ebp)
  800f33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f36:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f39:	72 d9                	jb     800f14 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f3e:	c9                   	leave  
  800f3f:	c3                   	ret    

00800f40 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f40:	55                   	push   %ebp
  800f41:	89 e5                	mov    %esp,%ebp
  800f43:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f50:	74 30                	je     800f82 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f52:	eb 16                	jmp    800f6a <strlcpy+0x2a>
			*dst++ = *src++;
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	8d 50 01             	lea    0x1(%eax),%edx
  800f5a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f60:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f63:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f66:	8a 12                	mov    (%edx),%dl
  800f68:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f6a:	ff 4d 10             	decl   0x10(%ebp)
  800f6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f71:	74 09                	je     800f7c <strlcpy+0x3c>
  800f73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	84 c0                	test   %al,%al
  800f7a:	75 d8                	jne    800f54 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f82:	8b 55 08             	mov    0x8(%ebp),%edx
  800f85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f88:	29 c2                	sub    %eax,%edx
  800f8a:	89 d0                	mov    %edx,%eax
}
  800f8c:	c9                   	leave  
  800f8d:	c3                   	ret    

00800f8e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f8e:	55                   	push   %ebp
  800f8f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f91:	eb 06                	jmp    800f99 <strcmp+0xb>
		p++, q++;
  800f93:	ff 45 08             	incl   0x8(%ebp)
  800f96:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	84 c0                	test   %al,%al
  800fa0:	74 0e                	je     800fb0 <strcmp+0x22>
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 10                	mov    (%eax),%dl
  800fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	38 c2                	cmp    %al,%dl
  800fae:	74 e3                	je     800f93 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	0f b6 d0             	movzbl %al,%edx
  800fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	0f b6 c0             	movzbl %al,%eax
  800fc0:	29 c2                	sub    %eax,%edx
  800fc2:	89 d0                	mov    %edx,%eax
}
  800fc4:	5d                   	pop    %ebp
  800fc5:	c3                   	ret    

00800fc6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fc6:	55                   	push   %ebp
  800fc7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fc9:	eb 09                	jmp    800fd4 <strncmp+0xe>
		n--, p++, q++;
  800fcb:	ff 4d 10             	decl   0x10(%ebp)
  800fce:	ff 45 08             	incl   0x8(%ebp)
  800fd1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd8:	74 17                	je     800ff1 <strncmp+0x2b>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	84 c0                	test   %al,%al
  800fe1:	74 0e                	je     800ff1 <strncmp+0x2b>
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 10                	mov    (%eax),%dl
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	38 c2                	cmp    %al,%dl
  800fef:	74 da                	je     800fcb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ff1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff5:	75 07                	jne    800ffe <strncmp+0x38>
		return 0;
  800ff7:	b8 00 00 00 00       	mov    $0x0,%eax
  800ffc:	eb 14                	jmp    801012 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	8a 00                	mov    (%eax),%al
  801003:	0f b6 d0             	movzbl %al,%edx
  801006:	8b 45 0c             	mov    0xc(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	0f b6 c0             	movzbl %al,%eax
  80100e:	29 c2                	sub    %eax,%edx
  801010:	89 d0                	mov    %edx,%eax
}
  801012:	5d                   	pop    %ebp
  801013:	c3                   	ret    

00801014 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801014:	55                   	push   %ebp
  801015:	89 e5                	mov    %esp,%ebp
  801017:	83 ec 04             	sub    $0x4,%esp
  80101a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801020:	eb 12                	jmp    801034 <strchr+0x20>
		if (*s == c)
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80102a:	75 05                	jne    801031 <strchr+0x1d>
			return (char *) s;
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	eb 11                	jmp    801042 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801031:	ff 45 08             	incl   0x8(%ebp)
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	84 c0                	test   %al,%al
  80103b:	75 e5                	jne    801022 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80103d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 04             	sub    $0x4,%esp
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801050:	eb 0d                	jmp    80105f <strfind+0x1b>
		if (*s == c)
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	8a 00                	mov    (%eax),%al
  801057:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80105a:	74 0e                	je     80106a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80105c:	ff 45 08             	incl   0x8(%ebp)
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8a 00                	mov    (%eax),%al
  801064:	84 c0                	test   %al,%al
  801066:	75 ea                	jne    801052 <strfind+0xe>
  801068:	eb 01                	jmp    80106b <strfind+0x27>
		if (*s == c)
			break;
  80106a:	90                   	nop
	return (char *) s;
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
  801073:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80107c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801080:	76 63                	jbe    8010e5 <memset+0x75>
		uint64 data_block = c;
  801082:	8b 45 0c             	mov    0xc(%ebp),%eax
  801085:	99                   	cltd   
  801086:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801089:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80108c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80108f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801092:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801096:	c1 e0 08             	shl    $0x8,%eax
  801099:	09 45 f0             	or     %eax,-0x10(%ebp)
  80109c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  80109f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a5:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010a9:	c1 e0 10             	shl    $0x10,%eax
  8010ac:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010af:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b8:	89 c2                	mov    %eax,%edx
  8010ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8010bf:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010c2:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8010c5:	eb 18                	jmp    8010df <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8010c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010ca:	8d 41 08             	lea    0x8(%ecx),%eax
  8010cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8010d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d6:	89 01                	mov    %eax,(%ecx)
  8010d8:	89 51 04             	mov    %edx,0x4(%ecx)
  8010db:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8010df:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010e3:	77 e2                	ja     8010c7 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8010e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e9:	74 23                	je     80110e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8010eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010f1:	eb 0e                	jmp    801101 <memset+0x91>
			*p8++ = (uint8)c;
  8010f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f6:	8d 50 01             	lea    0x1(%eax),%edx
  8010f9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ff:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801101:	8b 45 10             	mov    0x10(%ebp),%eax
  801104:	8d 50 ff             	lea    -0x1(%eax),%edx
  801107:	89 55 10             	mov    %edx,0x10(%ebp)
  80110a:	85 c0                	test   %eax,%eax
  80110c:	75 e5                	jne    8010f3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801119:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
  801122:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801125:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801129:	76 24                	jbe    80114f <memcpy+0x3c>
		while(n >= 8){
  80112b:	eb 1c                	jmp    801149 <memcpy+0x36>
			*d64 = *s64;
  80112d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801130:	8b 50 04             	mov    0x4(%eax),%edx
  801133:	8b 00                	mov    (%eax),%eax
  801135:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801138:	89 01                	mov    %eax,(%ecx)
  80113a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80113d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801141:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801145:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801149:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80114d:	77 de                	ja     80112d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80114f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801153:	74 31                	je     801186 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801155:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801158:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80115b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801161:	eb 16                	jmp    801179 <memcpy+0x66>
			*d8++ = *s8++;
  801163:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801166:	8d 50 01             	lea    0x1(%eax),%edx
  801169:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80116c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80116f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801172:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801175:	8a 12                	mov    (%edx),%dl
  801177:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801179:	8b 45 10             	mov    0x10(%ebp),%eax
  80117c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117f:	89 55 10             	mov    %edx,0x10(%ebp)
  801182:	85 c0                	test   %eax,%eax
  801184:	75 dd                	jne    801163 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
  80118e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80119d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011a3:	73 50                	jae    8011f5 <memmove+0x6a>
  8011a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ab:	01 d0                	add    %edx,%eax
  8011ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011b0:	76 43                	jbe    8011f5 <memmove+0x6a>
		s += n;
  8011b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011be:	eb 10                	jmp    8011d0 <memmove+0x45>
			*--d = *--s;
  8011c0:	ff 4d f8             	decl   -0x8(%ebp)
  8011c3:	ff 4d fc             	decl   -0x4(%ebp)
  8011c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c9:	8a 10                	mov    (%eax),%dl
  8011cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ce:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011d6:	89 55 10             	mov    %edx,0x10(%ebp)
  8011d9:	85 c0                	test   %eax,%eax
  8011db:	75 e3                	jne    8011c0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011dd:	eb 23                	jmp    801202 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e2:	8d 50 01             	lea    0x1(%eax),%edx
  8011e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011eb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011ee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011f1:	8a 12                	mov    (%edx),%dl
  8011f3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8011fe:	85 c0                	test   %eax,%eax
  801200:	75 dd                	jne    8011df <memmove+0x54>
			*d++ = *s++;

	return dst;
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
  80120a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801213:	8b 45 0c             	mov    0xc(%ebp),%eax
  801216:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801219:	eb 2a                	jmp    801245 <memcmp+0x3e>
		if (*s1 != *s2)
  80121b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80121e:	8a 10                	mov    (%eax),%dl
  801220:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	38 c2                	cmp    %al,%dl
  801227:	74 16                	je     80123f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801229:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	0f b6 d0             	movzbl %al,%edx
  801231:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801234:	8a 00                	mov    (%eax),%al
  801236:	0f b6 c0             	movzbl %al,%eax
  801239:	29 c2                	sub    %eax,%edx
  80123b:	89 d0                	mov    %edx,%eax
  80123d:	eb 18                	jmp    801257 <memcmp+0x50>
		s1++, s2++;
  80123f:	ff 45 fc             	incl   -0x4(%ebp)
  801242:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	8d 50 ff             	lea    -0x1(%eax),%edx
  80124b:	89 55 10             	mov    %edx,0x10(%ebp)
  80124e:	85 c0                	test   %eax,%eax
  801250:	75 c9                	jne    80121b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801252:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80125f:	8b 55 08             	mov    0x8(%ebp),%edx
  801262:	8b 45 10             	mov    0x10(%ebp),%eax
  801265:	01 d0                	add    %edx,%eax
  801267:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80126a:	eb 15                	jmp    801281 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	0f b6 d0             	movzbl %al,%edx
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	0f b6 c0             	movzbl %al,%eax
  80127a:	39 c2                	cmp    %eax,%edx
  80127c:	74 0d                	je     80128b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80127e:	ff 45 08             	incl   0x8(%ebp)
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801287:	72 e3                	jb     80126c <memfind+0x13>
  801289:	eb 01                	jmp    80128c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80128b:	90                   	nop
	return (void *) s;
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801297:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80129e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012a5:	eb 03                	jmp    8012aa <strtol+0x19>
		s++;
  8012a7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	8a 00                	mov    (%eax),%al
  8012af:	3c 20                	cmp    $0x20,%al
  8012b1:	74 f4                	je     8012a7 <strtol+0x16>
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	8a 00                	mov    (%eax),%al
  8012b8:	3c 09                	cmp    $0x9,%al
  8012ba:	74 eb                	je     8012a7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	3c 2b                	cmp    $0x2b,%al
  8012c3:	75 05                	jne    8012ca <strtol+0x39>
		s++;
  8012c5:	ff 45 08             	incl   0x8(%ebp)
  8012c8:	eb 13                	jmp    8012dd <strtol+0x4c>
	else if (*s == '-')
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	8a 00                	mov    (%eax),%al
  8012cf:	3c 2d                	cmp    $0x2d,%al
  8012d1:	75 0a                	jne    8012dd <strtol+0x4c>
		s++, neg = 1;
  8012d3:	ff 45 08             	incl   0x8(%ebp)
  8012d6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e1:	74 06                	je     8012e9 <strtol+0x58>
  8012e3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012e7:	75 20                	jne    801309 <strtol+0x78>
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	3c 30                	cmp    $0x30,%al
  8012f0:	75 17                	jne    801309 <strtol+0x78>
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	40                   	inc    %eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	3c 78                	cmp    $0x78,%al
  8012fa:	75 0d                	jne    801309 <strtol+0x78>
		s += 2, base = 16;
  8012fc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801300:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801307:	eb 28                	jmp    801331 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801309:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130d:	75 15                	jne    801324 <strtol+0x93>
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8a 00                	mov    (%eax),%al
  801314:	3c 30                	cmp    $0x30,%al
  801316:	75 0c                	jne    801324 <strtol+0x93>
		s++, base = 8;
  801318:	ff 45 08             	incl   0x8(%ebp)
  80131b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801322:	eb 0d                	jmp    801331 <strtol+0xa0>
	else if (base == 0)
  801324:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801328:	75 07                	jne    801331 <strtol+0xa0>
		base = 10;
  80132a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8a 00                	mov    (%eax),%al
  801336:	3c 2f                	cmp    $0x2f,%al
  801338:	7e 19                	jle    801353 <strtol+0xc2>
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	3c 39                	cmp    $0x39,%al
  801341:	7f 10                	jg     801353 <strtol+0xc2>
			dig = *s - '0';
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	0f be c0             	movsbl %al,%eax
  80134b:	83 e8 30             	sub    $0x30,%eax
  80134e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801351:	eb 42                	jmp    801395 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8a 00                	mov    (%eax),%al
  801358:	3c 60                	cmp    $0x60,%al
  80135a:	7e 19                	jle    801375 <strtol+0xe4>
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	8a 00                	mov    (%eax),%al
  801361:	3c 7a                	cmp    $0x7a,%al
  801363:	7f 10                	jg     801375 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8a 00                	mov    (%eax),%al
  80136a:	0f be c0             	movsbl %al,%eax
  80136d:	83 e8 57             	sub    $0x57,%eax
  801370:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801373:	eb 20                	jmp    801395 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	3c 40                	cmp    $0x40,%al
  80137c:	7e 39                	jle    8013b7 <strtol+0x126>
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	3c 5a                	cmp    $0x5a,%al
  801385:	7f 30                	jg     8013b7 <strtol+0x126>
			dig = *s - 'A' + 10;
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	0f be c0             	movsbl %al,%eax
  80138f:	83 e8 37             	sub    $0x37,%eax
  801392:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801395:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801398:	3b 45 10             	cmp    0x10(%ebp),%eax
  80139b:	7d 19                	jge    8013b6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80139d:	ff 45 08             	incl   0x8(%ebp)
  8013a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013a7:	89 c2                	mov    %eax,%edx
  8013a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ac:	01 d0                	add    %edx,%eax
  8013ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013b1:	e9 7b ff ff ff       	jmp    801331 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013b6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013bb:	74 08                	je     8013c5 <strtol+0x134>
		*endptr = (char *) s;
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8013c3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013c9:	74 07                	je     8013d2 <strtol+0x141>
  8013cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ce:	f7 d8                	neg    %eax
  8013d0:	eb 03                	jmp    8013d5 <strtol+0x144>
  8013d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <ltostr>:

void
ltostr(long value, char *str)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
  8013da:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013ef:	79 13                	jns    801404 <ltostr+0x2d>
	{
		neg = 1;
  8013f1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013fe:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801401:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80140c:	99                   	cltd   
  80140d:	f7 f9                	idiv   %ecx
  80140f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801412:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801415:	8d 50 01             	lea    0x1(%eax),%edx
  801418:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80141b:	89 c2                	mov    %eax,%edx
  80141d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801420:	01 d0                	add    %edx,%eax
  801422:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801425:	83 c2 30             	add    $0x30,%edx
  801428:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80142a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80142d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801432:	f7 e9                	imul   %ecx
  801434:	c1 fa 02             	sar    $0x2,%edx
  801437:	89 c8                	mov    %ecx,%eax
  801439:	c1 f8 1f             	sar    $0x1f,%eax
  80143c:	29 c2                	sub    %eax,%edx
  80143e:	89 d0                	mov    %edx,%eax
  801440:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801443:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801447:	75 bb                	jne    801404 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801449:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801450:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801453:	48                   	dec    %eax
  801454:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801457:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80145b:	74 3d                	je     80149a <ltostr+0xc3>
		start = 1 ;
  80145d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801464:	eb 34                	jmp    80149a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801466:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146c:	01 d0                	add    %edx,%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801473:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801476:	8b 45 0c             	mov    0xc(%ebp),%eax
  801479:	01 c2                	add    %eax,%edx
  80147b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	01 c8                	add    %ecx,%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801487:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80148a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148d:	01 c2                	add    %eax,%edx
  80148f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801492:	88 02                	mov    %al,(%edx)
		start++ ;
  801494:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801497:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80149a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80149d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014a0:	7c c4                	jl     801466 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	01 d0                	add    %edx,%eax
  8014aa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014ad:	90                   	nop
  8014ae:	c9                   	leave  
  8014af:	c3                   	ret    

008014b0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
  8014b3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014b6:	ff 75 08             	pushl  0x8(%ebp)
  8014b9:	e8 c4 f9 ff ff       	call   800e82 <strlen>
  8014be:	83 c4 04             	add    $0x4,%esp
  8014c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014c4:	ff 75 0c             	pushl  0xc(%ebp)
  8014c7:	e8 b6 f9 ff ff       	call   800e82 <strlen>
  8014cc:	83 c4 04             	add    $0x4,%esp
  8014cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014e0:	eb 17                	jmp    8014f9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e8:	01 c2                	add    %eax,%edx
  8014ea:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	01 c8                	add    %ecx,%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014f6:	ff 45 fc             	incl   -0x4(%ebp)
  8014f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014ff:	7c e1                	jl     8014e2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801501:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801508:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80150f:	eb 1f                	jmp    801530 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801511:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801514:	8d 50 01             	lea    0x1(%eax),%edx
  801517:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80151a:	89 c2                	mov    %eax,%edx
  80151c:	8b 45 10             	mov    0x10(%ebp),%eax
  80151f:	01 c2                	add    %eax,%edx
  801521:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	01 c8                	add    %ecx,%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80152d:	ff 45 f8             	incl   -0x8(%ebp)
  801530:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801533:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801536:	7c d9                	jl     801511 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801538:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80153b:	8b 45 10             	mov    0x10(%ebp),%eax
  80153e:	01 d0                	add    %edx,%eax
  801540:	c6 00 00             	movb   $0x0,(%eax)
}
  801543:	90                   	nop
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801549:	8b 45 14             	mov    0x14(%ebp),%eax
  80154c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801552:	8b 45 14             	mov    0x14(%ebp),%eax
  801555:	8b 00                	mov    (%eax),%eax
  801557:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80155e:	8b 45 10             	mov    0x10(%ebp),%eax
  801561:	01 d0                	add    %edx,%eax
  801563:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801569:	eb 0c                	jmp    801577 <strsplit+0x31>
			*string++ = 0;
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8d 50 01             	lea    0x1(%eax),%edx
  801571:	89 55 08             	mov    %edx,0x8(%ebp)
  801574:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	8a 00                	mov    (%eax),%al
  80157c:	84 c0                	test   %al,%al
  80157e:	74 18                	je     801598 <strsplit+0x52>
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	8a 00                	mov    (%eax),%al
  801585:	0f be c0             	movsbl %al,%eax
  801588:	50                   	push   %eax
  801589:	ff 75 0c             	pushl  0xc(%ebp)
  80158c:	e8 83 fa ff ff       	call   801014 <strchr>
  801591:	83 c4 08             	add    $0x8,%esp
  801594:	85 c0                	test   %eax,%eax
  801596:	75 d3                	jne    80156b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	84 c0                	test   %al,%al
  80159f:	74 5a                	je     8015fb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8015a4:	8b 00                	mov    (%eax),%eax
  8015a6:	83 f8 0f             	cmp    $0xf,%eax
  8015a9:	75 07                	jne    8015b2 <strsplit+0x6c>
		{
			return 0;
  8015ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8015b0:	eb 66                	jmp    801618 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b5:	8b 00                	mov    (%eax),%eax
  8015b7:	8d 48 01             	lea    0x1(%eax),%ecx
  8015ba:	8b 55 14             	mov    0x14(%ebp),%edx
  8015bd:	89 0a                	mov    %ecx,(%edx)
  8015bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c9:	01 c2                	add    %eax,%edx
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015d0:	eb 03                	jmp    8015d5 <strsplit+0x8f>
			string++;
  8015d2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	84 c0                	test   %al,%al
  8015dc:	74 8b                	je     801569 <strsplit+0x23>
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	0f be c0             	movsbl %al,%eax
  8015e6:	50                   	push   %eax
  8015e7:	ff 75 0c             	pushl  0xc(%ebp)
  8015ea:	e8 25 fa ff ff       	call   801014 <strchr>
  8015ef:	83 c4 08             	add    $0x8,%esp
  8015f2:	85 c0                	test   %eax,%eax
  8015f4:	74 dc                	je     8015d2 <strsplit+0x8c>
			string++;
	}
  8015f6:	e9 6e ff ff ff       	jmp    801569 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015fb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8015ff:	8b 00                	mov    (%eax),%eax
  801601:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801608:	8b 45 10             	mov    0x10(%ebp),%eax
  80160b:	01 d0                	add    %edx,%eax
  80160d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801613:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
  80161d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801626:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80162d:	eb 4a                	jmp    801679 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80162f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	01 c2                	add    %eax,%edx
  801637:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80163a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163d:	01 c8                	add    %ecx,%eax
  80163f:	8a 00                	mov    (%eax),%al
  801641:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801643:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	01 d0                	add    %edx,%eax
  80164b:	8a 00                	mov    (%eax),%al
  80164d:	3c 40                	cmp    $0x40,%al
  80164f:	7e 25                	jle    801676 <str2lower+0x5c>
  801651:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801654:	8b 45 0c             	mov    0xc(%ebp),%eax
  801657:	01 d0                	add    %edx,%eax
  801659:	8a 00                	mov    (%eax),%al
  80165b:	3c 5a                	cmp    $0x5a,%al
  80165d:	7f 17                	jg     801676 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80165f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	01 d0                	add    %edx,%eax
  801667:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80166a:	8b 55 08             	mov    0x8(%ebp),%edx
  80166d:	01 ca                	add    %ecx,%edx
  80166f:	8a 12                	mov    (%edx),%dl
  801671:	83 c2 20             	add    $0x20,%edx
  801674:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801676:	ff 45 fc             	incl   -0x4(%ebp)
  801679:	ff 75 0c             	pushl  0xc(%ebp)
  80167c:	e8 01 f8 ff ff       	call   800e82 <strlen>
  801681:	83 c4 04             	add    $0x4,%esp
  801684:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801687:	7f a6                	jg     80162f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801689:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80168c:	c9                   	leave  
  80168d:	c3                   	ret    

0080168e <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
  801691:	57                   	push   %edi
  801692:	56                   	push   %esi
  801693:	53                   	push   %ebx
  801694:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016a0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016a3:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016a6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016a9:	cd 30                	int    $0x30
  8016ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016b1:	83 c4 10             	add    $0x10,%esp
  8016b4:	5b                   	pop    %ebx
  8016b5:	5e                   	pop    %esi
  8016b6:	5f                   	pop    %edi
  8016b7:	5d                   	pop    %ebp
  8016b8:	c3                   	ret    

008016b9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
  8016bc:	83 ec 04             	sub    $0x4,%esp
  8016bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016c5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016c8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	51                   	push   %ecx
  8016d2:	52                   	push   %edx
  8016d3:	ff 75 0c             	pushl  0xc(%ebp)
  8016d6:	50                   	push   %eax
  8016d7:	6a 00                	push   $0x0
  8016d9:	e8 b0 ff ff ff       	call   80168e <syscall>
  8016de:	83 c4 18             	add    $0x18,%esp
}
  8016e1:	90                   	nop
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 02                	push   $0x2
  8016f3:	e8 96 ff ff ff       	call   80168e <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
}
  8016fb:	c9                   	leave  
  8016fc:	c3                   	ret    

008016fd <sys_lock_cons>:

void sys_lock_cons(void)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 03                	push   $0x3
  80170c:	e8 7d ff ff ff       	call   80168e <syscall>
  801711:	83 c4 18             	add    $0x18,%esp
}
  801714:	90                   	nop
  801715:	c9                   	leave  
  801716:	c3                   	ret    

00801717 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801717:	55                   	push   %ebp
  801718:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 04                	push   $0x4
  801726:	e8 63 ff ff ff       	call   80168e <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	90                   	nop
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801734:	8b 55 0c             	mov    0xc(%ebp),%edx
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	52                   	push   %edx
  801741:	50                   	push   %eax
  801742:	6a 08                	push   $0x8
  801744:	e8 45 ff ff ff       	call   80168e <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
}
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
  801751:	56                   	push   %esi
  801752:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801753:	8b 75 18             	mov    0x18(%ebp),%esi
  801756:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801759:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80175c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	56                   	push   %esi
  801763:	53                   	push   %ebx
  801764:	51                   	push   %ecx
  801765:	52                   	push   %edx
  801766:	50                   	push   %eax
  801767:	6a 09                	push   $0x9
  801769:	e8 20 ff ff ff       	call   80168e <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801774:	5b                   	pop    %ebx
  801775:	5e                   	pop    %esi
  801776:	5d                   	pop    %ebp
  801777:	c3                   	ret    

00801778 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	ff 75 08             	pushl  0x8(%ebp)
  801786:	6a 0a                	push   $0xa
  801788:	e8 01 ff ff ff       	call   80168e <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	ff 75 0c             	pushl  0xc(%ebp)
  80179e:	ff 75 08             	pushl  0x8(%ebp)
  8017a1:	6a 0b                	push   $0xb
  8017a3:	e8 e6 fe ff ff       	call   80168e <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 0c                	push   $0xc
  8017bc:	e8 cd fe ff ff       	call   80168e <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 0d                	push   $0xd
  8017d5:	e8 b4 fe ff ff       	call   80168e <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 0e                	push   $0xe
  8017ee:	e8 9b fe ff ff       	call   80168e <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 0f                	push   $0xf
  801807:	e8 82 fe ff ff       	call   80168e <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	ff 75 08             	pushl  0x8(%ebp)
  80181f:	6a 10                	push   $0x10
  801821:	e8 68 fe ff ff       	call   80168e <syscall>
  801826:	83 c4 18             	add    $0x18,%esp
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 11                	push   $0x11
  80183a:	e8 4f fe ff ff       	call   80168e <syscall>
  80183f:	83 c4 18             	add    $0x18,%esp
}
  801842:	90                   	nop
  801843:	c9                   	leave  
  801844:	c3                   	ret    

00801845 <sys_cputc>:

void
sys_cputc(const char c)
{
  801845:	55                   	push   %ebp
  801846:	89 e5                	mov    %esp,%ebp
  801848:	83 ec 04             	sub    $0x4,%esp
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801851:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	50                   	push   %eax
  80185e:	6a 01                	push   $0x1
  801860:	e8 29 fe ff ff       	call   80168e <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	90                   	nop
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 14                	push   $0x14
  80187a:	e8 0f fe ff ff       	call   80168e <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
}
  801882:	90                   	nop
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
  801888:	83 ec 04             	sub    $0x4,%esp
  80188b:	8b 45 10             	mov    0x10(%ebp),%eax
  80188e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801891:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801894:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801898:	8b 45 08             	mov    0x8(%ebp),%eax
  80189b:	6a 00                	push   $0x0
  80189d:	51                   	push   %ecx
  80189e:	52                   	push   %edx
  80189f:	ff 75 0c             	pushl  0xc(%ebp)
  8018a2:	50                   	push   %eax
  8018a3:	6a 15                	push   $0x15
  8018a5:	e8 e4 fd ff ff       	call   80168e <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018b2:	8b 55 10             	mov    0x10(%ebp),%edx
  8018b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	52                   	push   %edx
  8018bd:	50                   	push   %eax
  8018be:	ff 75 08             	pushl  0x8(%ebp)
  8018c1:	6a 16                	push   $0x16
  8018c3:	e8 c6 fd ff ff       	call   80168e <syscall>
  8018c8:	83 c4 18             	add    $0x18,%esp
}
  8018cb:	c9                   	leave  
  8018cc:	c3                   	ret    

008018cd <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018cd:	55                   	push   %ebp
  8018ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	52                   	push   %edx
  8018dd:	50                   	push   %eax
  8018de:	6a 17                	push   $0x17
  8018e0:	e8 a9 fd ff ff       	call   80168e <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	52                   	push   %edx
  8018fa:	50                   	push   %eax
  8018fb:	6a 18                	push   $0x18
  8018fd:	e8 8c fd ff ff       	call   80168e <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	6a 00                	push   $0x0
  80190f:	ff 75 14             	pushl  0x14(%ebp)
  801912:	ff 75 10             	pushl  0x10(%ebp)
  801915:	ff 75 0c             	pushl  0xc(%ebp)
  801918:	50                   	push   %eax
  801919:	6a 19                	push   $0x19
  80191b:	e8 6e fd ff ff       	call   80168e <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
}
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	50                   	push   %eax
  801934:	6a 1a                	push   $0x1a
  801936:	e8 53 fd ff ff       	call   80168e <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
}
  80193e:	90                   	nop
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	50                   	push   %eax
  801950:	6a 1b                	push   $0x1b
  801952:	e8 37 fd ff ff       	call   80168e <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
}
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 05                	push   $0x5
  80196b:	e8 1e fd ff ff       	call   80168e <syscall>
  801970:	83 c4 18             	add    $0x18,%esp
}
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 06                	push   $0x6
  801984:	e8 05 fd ff ff       	call   80168e <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 07                	push   $0x7
  80199d:	e8 ec fc ff ff       	call   80168e <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_exit_env>:


void sys_exit_env(void)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 1c                	push   $0x1c
  8019b6:	e8 d3 fc ff ff       	call   80168e <syscall>
  8019bb:	83 c4 18             	add    $0x18,%esp
}
  8019be:	90                   	nop
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	ff 75 10             	pushl  0x10(%ebp)
  8019cb:	ff 75 0c             	pushl  0xc(%ebp)
  8019ce:	ff 75 08             	pushl  0x8(%ebp)
  8019d1:	6a 13                	push   $0x13
  8019d3:	e8 b6 fc ff ff       	call   80168e <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019db:	90                   	nop
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <sys_rcr2>:
uint32 sys_rcr2()
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 1e                	push   $0x1e
  8019ed:	e8 9c fc ff ff       	call   80168e <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
}
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
  8019fa:	83 ec 04             	sub    $0x4,%esp
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a03:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	50                   	push   %eax
  801a10:	6a 1f                	push   $0x1f
  801a12:	e8 77 fc ff ff       	call   80168e <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
	return ;
  801a1a:	90                   	nop
}
  801a1b:	c9                   	leave  
  801a1c:	c3                   	ret    

00801a1d <rsttst>:
void rsttst()
{
  801a1d:	55                   	push   %ebp
  801a1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 21                	push   $0x21
  801a2c:	e8 5d fc ff ff       	call   80168e <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
	return ;
  801a34:	90                   	nop
}
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
  801a3a:	83 ec 04             	sub    $0x4,%esp
  801a3d:	8b 45 14             	mov    0x14(%ebp),%eax
  801a40:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a43:	8b 55 18             	mov    0x18(%ebp),%edx
  801a46:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a4a:	52                   	push   %edx
  801a4b:	50                   	push   %eax
  801a4c:	ff 75 10             	pushl  0x10(%ebp)
  801a4f:	ff 75 0c             	pushl  0xc(%ebp)
  801a52:	ff 75 08             	pushl  0x8(%ebp)
  801a55:	6a 20                	push   $0x20
  801a57:	e8 32 fc ff ff       	call   80168e <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5f:	90                   	nop
}
  801a60:	c9                   	leave  
  801a61:	c3                   	ret    

00801a62 <chktst>:
void chktst(uint32 n)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	ff 75 08             	pushl  0x8(%ebp)
  801a70:	6a 22                	push   $0x22
  801a72:	e8 17 fc ff ff       	call   80168e <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7a:	90                   	nop
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <inctst>:

void inctst()
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 23                	push   $0x23
  801a8c:	e8 fd fb ff ff       	call   80168e <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
	return ;
  801a94:	90                   	nop
}
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    

00801a97 <gettst>:
uint32 gettst()
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 24                	push   $0x24
  801aa6:	e8 e3 fb ff ff       	call   80168e <syscall>
  801aab:	83 c4 18             	add    $0x18,%esp
}
  801aae:	c9                   	leave  
  801aaf:	c3                   	ret    

00801ab0 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 25                	push   $0x25
  801abf:	e8 ca fb ff ff       	call   80168e <syscall>
  801ac4:	83 c4 18             	add    $0x18,%esp
  801ac7:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801acc:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	ff 75 08             	pushl  0x8(%ebp)
  801ae9:	6a 26                	push   $0x26
  801aeb:	e8 9e fb ff ff       	call   80168e <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
	return ;
  801af3:	90                   	nop
}
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
  801af9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801afa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801afd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b03:	8b 45 08             	mov    0x8(%ebp),%eax
  801b06:	6a 00                	push   $0x0
  801b08:	53                   	push   %ebx
  801b09:	51                   	push   %ecx
  801b0a:	52                   	push   %edx
  801b0b:	50                   	push   %eax
  801b0c:	6a 27                	push   $0x27
  801b0e:	e8 7b fb ff ff       	call   80168e <syscall>
  801b13:	83 c4 18             	add    $0x18,%esp
}
  801b16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	52                   	push   %edx
  801b2b:	50                   	push   %eax
  801b2c:	6a 28                	push   $0x28
  801b2e:	e8 5b fb ff ff       	call   80168e <syscall>
  801b33:	83 c4 18             	add    $0x18,%esp
}
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b3b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b41:	8b 45 08             	mov    0x8(%ebp),%eax
  801b44:	6a 00                	push   $0x0
  801b46:	51                   	push   %ecx
  801b47:	ff 75 10             	pushl  0x10(%ebp)
  801b4a:	52                   	push   %edx
  801b4b:	50                   	push   %eax
  801b4c:	6a 29                	push   $0x29
  801b4e:	e8 3b fb ff ff       	call   80168e <syscall>
  801b53:	83 c4 18             	add    $0x18,%esp
}
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	ff 75 10             	pushl  0x10(%ebp)
  801b62:	ff 75 0c             	pushl  0xc(%ebp)
  801b65:	ff 75 08             	pushl  0x8(%ebp)
  801b68:	6a 12                	push   $0x12
  801b6a:	e8 1f fb ff ff       	call   80168e <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b72:	90                   	nop
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	52                   	push   %edx
  801b85:	50                   	push   %eax
  801b86:	6a 2a                	push   $0x2a
  801b88:	e8 01 fb ff ff       	call   80168e <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
	return;
  801b90:	90                   	nop
}
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 2b                	push   $0x2b
  801ba2:	e8 e7 fa ff ff       	call   80168e <syscall>
  801ba7:	83 c4 18             	add    $0x18,%esp
}
  801baa:	c9                   	leave  
  801bab:	c3                   	ret    

00801bac <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
  801baf:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bb2:	83 ec 04             	sub    $0x4,%esp
  801bb5:	68 c8 28 80 00       	push   $0x8028c8
  801bba:	68 0a 01 00 00       	push   $0x10a
  801bbf:	68 d8 28 80 00       	push   $0x8028d8
  801bc4:	e8 12 e9 ff ff       	call   8004db <_panic>

00801bc9 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	ff 75 0c             	pushl  0xc(%ebp)
  801bd5:	ff 75 08             	pushl  0x8(%ebp)
  801bd8:	6a 33                	push   $0x33
  801bda:	e8 af fa ff ff       	call   80168e <syscall>
  801bdf:	83 c4 18             	add    $0x18,%esp
	return;
  801be2:	90                   	nop
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	ff 75 0c             	pushl  0xc(%ebp)
  801bf1:	ff 75 08             	pushl  0x8(%ebp)
  801bf4:	6a 34                	push   $0x34
  801bf6:	e8 93 fa ff ff       	call   80168e <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfe:	90                   	nop
}
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
  801c04:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c07:	8b 55 08             	mov    0x8(%ebp),%edx
  801c0a:	89 d0                	mov    %edx,%eax
  801c0c:	c1 e0 02             	shl    $0x2,%eax
  801c0f:	01 d0                	add    %edx,%eax
  801c11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c18:	01 d0                	add    %edx,%eax
  801c1a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c21:	01 d0                	add    %edx,%eax
  801c23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c2a:	01 d0                	add    %edx,%eax
  801c2c:	c1 e0 04             	shl    $0x4,%eax
  801c2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c39:	0f 31                	rdtsc  
  801c3b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c3e:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c41:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c44:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c4a:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c4d:	eb 46                	jmp    801c95 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c4f:	0f 31                	rdtsc  
  801c51:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c54:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c57:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c5a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801c60:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c63:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c69:	29 c2                	sub    %eax,%edx
  801c6b:	89 d0                	mov    %edx,%eax
  801c6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c70:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c76:	89 d1                	mov    %edx,%ecx
  801c78:	29 c1                	sub    %eax,%ecx
  801c7a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c80:	39 c2                	cmp    %eax,%edx
  801c82:	0f 97 c0             	seta   %al
  801c85:	0f b6 c0             	movzbl %al,%eax
  801c88:	29 c1                	sub    %eax,%ecx
  801c8a:	89 c8                	mov    %ecx,%eax
  801c8c:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c8f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c98:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801c9b:	72 b2                	jb     801c4f <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801c9d:	90                   	nop
  801c9e:	c9                   	leave  
  801c9f:	c3                   	ret    

00801ca0 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801ca0:	55                   	push   %ebp
  801ca1:	89 e5                	mov    %esp,%ebp
  801ca3:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801ca6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cad:	eb 03                	jmp    801cb2 <busy_wait+0x12>
  801caf:	ff 45 fc             	incl   -0x4(%ebp)
  801cb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cb5:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cb8:	72 f5                	jb     801caf <busy_wait+0xf>
	return i;
  801cba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801cbd:	c9                   	leave  
  801cbe:	c3                   	ret    
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
