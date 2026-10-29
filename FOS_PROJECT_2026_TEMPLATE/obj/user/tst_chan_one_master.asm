
obj/user/tst_chan_one_master:     file format elf32-i386


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
  800031:	e8 86 02 00 00       	call   8002bc <libmain>
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
  80003e:	81 ec 3c 01 00 00    	sub    $0x13c,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800044:	83 ec 08             	sub    $0x8,%esp
  800047:	68 80 1f 80 00       	push   $0x801f80
  80004c:	6a 0e                	push   $0xe
  80004e:	e8 c4 07 00 00       	call   800817 <cprintf_colored>
  800053:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	68 b0 1f 80 00       	push   $0x801fb0
  80005e:	6a 0e                	push   $0xe
  800060:	e8 b2 07 00 00       	call   800817 <cprintf_colored>
  800065:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	68 80 1f 80 00       	push   $0x801f80
  800070:	6a 0e                	push   $0xe
  800072:	e8 a0 07 00 00       	call   800817 <cprintf_colored>
  800077:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  80007a:	e8 1e 19 00 00       	call   80199d <sys_getenvid>
  80007f:	89 45 dc             	mov    %eax,-0x24(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  800082:	c7 45 c8 07 00 00 00 	movl   $0x7,-0x38(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800089:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80008c:	83 ec 08             	sub    $0x8,%esp
  80008f:	50                   	push   %eax
  800090:	68 0c 20 80 00       	push   $0x80200c
  800095:	e8 50 07 00 00       	call   8007ea <cprintf>
  80009a:	83 c4 10             	add    $0x10,%esp
	readline("Enter the number of Slave Programs: ", slavesCnt);
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Save number of slaved to be checked later
	char cmd1[64] = "__NumOfSlaves@Set";
  80009d:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000a0:	bb 96 21 80 00       	mov    $0x802196,%ebx
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
  8000cb:	e8 e6 1a 00 00       	call   801bb6 <sys_utilities>
  8000d0:	83 c4 10             	add    $0x10,%esp

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  8000d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000da:	eb 68                	jmp    800144 <_main+0x10c>
	{
		id = sys_create_env("tstChanOneSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e1:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ec:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f7:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000fd:	51                   	push   %ecx
  8000fe:	52                   	push   %edx
  8000ff:	50                   	push   %eax
  800100:	68 34 20 80 00       	push   $0x802034
  800105:	e8 3e 18 00 00       	call   801948 <sys_create_env>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  800110:	83 7d d8 ee          	cmpl   $0xffffffee,-0x28(%ebp)
  800114:	75 1d                	jne    800133 <_main+0xfb>
		{
			cprintf_colored(TEXT_TESTERR_CLR, "\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  800116:	83 ec 04             	sub    $0x4,%esp
  800119:	ff 75 e4             	pushl  -0x1c(%ebp)
  80011c:	68 44 20 80 00       	push   $0x802044
  800121:	6a 0c                	push   $0xc
  800123:	e8 ef 06 00 00       	call   800817 <cprintf_colored>
  800128:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  80012b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80012e:	89 45 c8             	mov    %eax,-0x38(%ebp)
			break;
  800131:	eb 19                	jmp    80014c <_main+0x114>
		}
		sys_run_env(id);
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	ff 75 d8             	pushl  -0x28(%ebp)
  800139:	e8 28 18 00 00       	call   801966 <sys_run_env>
  80013e:	83 c4 10             	add    $0x10,%esp
	char cmd1[64] = "__NumOfSlaves@Set";
	sys_utilities(cmd1, (uint32)(&numOfSlaves));

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  800141:	ff 45 e4             	incl   -0x1c(%ebp)
  800144:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800147:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  80014a:	7c 90                	jl     8000dc <_main+0xa4>
		}
		sys_run_env(id);
	}

	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
  80014c:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
	char cmd2[64] = "__GetChanQueueSize__";
  800153:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800159:	bb d6 21 80 00       	mov    $0x8021d6,%ebx
  80015e:	ba 15 00 00 00       	mov    $0x15,%edx
  800163:	89 c7                	mov    %eax,%edi
  800165:	89 de                	mov    %ebx,%esi
  800167:	89 d1                	mov    %edx,%ecx
  800169:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80016b:	8d 95 59 ff ff ff    	lea    -0xa7(%ebp),%edx
  800171:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800176:	b0 00                	mov    $0x0,%al
  800178:	89 d7                	mov    %edx,%edi
  80017a:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  80017c:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80017f:	83 ec 08             	sub    $0x8,%esp
  800182:	50                   	push   %eax
  800183:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800189:	50                   	push   %eax
  80018a:	e8 27 1a 00 00       	call   801bb6 <sys_utilities>
  80018f:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  800192:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (numOfBlockedProcesses != numOfSlaves)
  800199:	eb 76                	jmp    800211 <_main+0x1d9>
	{
		env_sleep(5000);
  80019b:	83 ec 0c             	sub    $0xc,%esp
  80019e:	68 88 13 00 00       	push   $0x1388
  8001a3:	e8 9a 1a 00 00       	call   801c42 <env_sleep>
  8001a8:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  8001ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001ae:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  8001b1:	75 1c                	jne    8001cf <_main+0x197>
		{
			panic("%~test channels failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves, numOfBlockedProcesses);
  8001b3:	8b 55 84             	mov    -0x7c(%ebp),%edx
  8001b6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001b9:	83 ec 0c             	sub    $0xc,%esp
  8001bc:	52                   	push   %edx
  8001bd:	50                   	push   %eax
  8001be:	68 9c 20 80 00       	push   $0x80209c
  8001c3:	6a 33                	push   $0x33
  8001c5:	68 f5 20 80 00       	push   $0x8020f5
  8001ca:	e8 4d 03 00 00       	call   80051c <_panic>
		}
		char cmd3[64] = "__GetChanQueueSize__";
  8001cf:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  8001d5:	bb d6 21 80 00       	mov    $0x8021d6,%ebx
  8001da:	ba 15 00 00 00       	mov    $0x15,%edx
  8001df:	89 c7                	mov    %eax,%edi
  8001e1:	89 de                	mov    %ebx,%esi
  8001e3:	89 d1                	mov    %edx,%ecx
  8001e5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001e7:	8d 95 d9 fe ff ff    	lea    -0x127(%ebp),%edx
  8001ed:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8001f2:	b0 00                	mov    $0x0,%al
  8001f4:	89 d7                	mov    %edx,%edi
  8001f6:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
  8001f8:	8d 45 84             	lea    -0x7c(%ebp),%eax
  8001fb:	83 ec 08             	sub    $0x8,%esp
  8001fe:	50                   	push   %eax
  8001ff:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  800205:	50                   	push   %eax
  800206:	e8 ab 19 00 00       	call   801bb6 <sys_utilities>
  80020b:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  80020e:	ff 45 e0             	incl   -0x20(%ebp)
	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
	char cmd2[64] = "__GetChanQueueSize__";
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves)
  800211:	8b 55 84             	mov    -0x7c(%ebp),%edx
  800214:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800217:	39 c2                	cmp    %eax,%edx
  800219:	75 80                	jne    80019b <_main+0x163>
		char cmd3[64] = "__GetChanQueueSize__";
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
		cnt++ ;
	}

	rsttst();
  80021b:	e8 3e 18 00 00       	call   801a5e <rsttst>

	//Wakeup one
	char cmd4[64] = "__WakeupOne__";
  800220:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  800226:	bb 16 22 80 00       	mov    $0x802216,%ebx
  80022b:	ba 0e 00 00 00       	mov    $0xe,%edx
  800230:	89 c7                	mov    %eax,%edi
  800232:	89 de                	mov    %ebx,%esi
  800234:	89 d1                	mov    %edx,%ecx
  800236:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800238:	8d 95 12 ff ff ff    	lea    -0xee(%ebp),%edx
  80023e:	b9 32 00 00 00       	mov    $0x32,%ecx
  800243:	b0 00                	mov    $0x0,%al
  800245:	89 d7                	mov    %edx,%edi
  800247:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd4, 0);
  800249:	83 ec 08             	sub    $0x8,%esp
  80024c:	6a 00                	push   $0x0
  80024e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  800254:	50                   	push   %eax
  800255:	e8 5c 19 00 00       	call   801bb6 <sys_utilities>
  80025a:	83 c4 10             	add    $0x10,%esp

	//Wait until all slave finished
	cnt = 0;
  80025d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (gettst() != numOfSlaves)
  800264:	eb 2f                	jmp    800295 <_main+0x25d>
	{
		env_sleep(10000);
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	68 10 27 00 00       	push   $0x2710
  80026e:	e8 cf 19 00 00       	call   801c42 <env_sleep>
  800273:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800276:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800279:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  80027c:	75 14                	jne    800292 <_main+0x25a>
		{
			panic("%~test channels failed! not all slaves finished");
  80027e:	83 ec 04             	sub    $0x4,%esp
  800281:	68 10 21 80 00       	push   $0x802110
  800286:	6a 47                	push   $0x47
  800288:	68 f5 20 80 00       	push   $0x8020f5
  80028d:	e8 8a 02 00 00       	call   80051c <_panic>
		}
		cnt++ ;
  800292:	ff 45 e0             	incl   -0x20(%ebp)
	char cmd4[64] = "__WakeupOne__";
	sys_utilities(cmd4, 0);

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves)
  800295:	e8 3e 18 00 00       	call   801ad8 <gettst>
  80029a:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80029d:	39 d0                	cmp    %edx,%eax
  80029f:	75 c5                	jne    800266 <_main+0x22e>
			panic("%~test channels failed! not all slaves finished");
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Channel (sleep & wakeup ONE) completed successfully!!\n\n");
  8002a1:	83 ec 08             	sub    $0x8,%esp
  8002a4:	68 40 21 80 00       	push   $0x802140
  8002a9:	6a 0a                	push   $0xa
  8002ab:	e8 67 05 00 00       	call   800817 <cprintf_colored>
  8002b0:	83 c4 10             	add    $0x10,%esp

	return;
  8002b3:	90                   	nop
}
  8002b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002b7:	5b                   	pop    %ebx
  8002b8:	5e                   	pop    %esi
  8002b9:	5f                   	pop    %edi
  8002ba:	5d                   	pop    %ebp
  8002bb:	c3                   	ret    

008002bc <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002bc:	55                   	push   %ebp
  8002bd:	89 e5                	mov    %esp,%ebp
  8002bf:	57                   	push   %edi
  8002c0:	56                   	push   %esi
  8002c1:	53                   	push   %ebx
  8002c2:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002c8:	e8 e9 16 00 00       	call   8019b6 <sys_getenvindex>
  8002cd:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002d3:	89 d0                	mov    %edx,%eax
  8002d5:	c1 e0 03             	shl    $0x3,%eax
  8002d8:	01 d0                	add    %edx,%eax
  8002da:	c1 e0 06             	shl    $0x6,%eax
  8002dd:	01 d0                	add    %edx,%eax
  8002df:	c1 e0 03             	shl    $0x3,%eax
  8002e2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002e7:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f1:	8a 40 10             	mov    0x10(%eax),%al
  8002f4:	84 c0                	test   %al,%al
  8002f6:	74 0d                	je     800305 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fd:	83 c0 10             	add    $0x10,%eax
  800300:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800305:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800309:	7e 0a                	jle    800315 <libmain+0x59>
		binaryname = argv[0];
  80030b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030e:	8b 00                	mov    (%eax),%eax
  800310:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800315:	83 ec 08             	sub    $0x8,%esp
  800318:	ff 75 0c             	pushl  0xc(%ebp)
  80031b:	ff 75 08             	pushl  0x8(%ebp)
  80031e:	e8 15 fd ff ff       	call   800038 <_main>
  800323:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800326:	a1 00 30 80 00       	mov    0x803000,%eax
  80032b:	85 c0                	test   %eax,%eax
  80032d:	0f 84 b7 01 00 00    	je     8004ea <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800333:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800339:	bb 94 23 80 00       	mov    $0x802394,%ebx
  80033e:	ba 0e 00 00 00       	mov    $0xe,%edx
  800343:	89 c7                	mov    %eax,%edi
  800345:	89 de                	mov    %ebx,%esi
  800347:	89 d1                	mov    %edx,%ecx
  800349:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80034b:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800351:	b9 56 00 00 00       	mov    $0x56,%ecx
  800356:	b0 00                	mov    $0x0,%al
  800358:	89 d7                	mov    %edx,%edi
  80035a:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80035c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800363:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800366:	83 ec 08             	sub    $0x8,%esp
  800369:	50                   	push   %eax
  80036a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800370:	50                   	push   %eax
  800371:	e8 40 18 00 00       	call   801bb6 <sys_utilities>
  800376:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800379:	e8 c0 13 00 00       	call   80173e <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80037e:	83 ec 0c             	sub    $0xc,%esp
  800381:	68 70 22 80 00       	push   $0x802270
  800386:	e8 5f 04 00 00       	call   8007ea <cprintf>
  80038b:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80038e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800391:	85 c0                	test   %eax,%eax
  800393:	74 58                	je     8003ed <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800395:	e8 3a 18 00 00       	call   801bd4 <sys_get_optimal_num_faults>
  80039a:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80039d:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003a3:	bb f8 23 80 00       	mov    $0x8023f8,%ebx
  8003a8:	ba 11 00 00 00       	mov    $0x11,%edx
  8003ad:	89 c7                	mov    %eax,%edi
  8003af:	89 de                	mov    %ebx,%esi
  8003b1:	89 d1                	mov    %edx,%ecx
  8003b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8003b5:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8003b8:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003bd:	b0 00                	mov    $0x0,%al
  8003bf:	89 d7                	mov    %edx,%edi
  8003c1:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003c3:	83 ec 08             	sub    $0x8,%esp
  8003c6:	ff 75 dc             	pushl  -0x24(%ebp)
  8003c9:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003cf:	50                   	push   %eax
  8003d0:	e8 e1 17 00 00       	call   801bb6 <sys_utilities>
  8003d5:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003d8:	83 ec 08             	sub    $0x8,%esp
  8003db:	ff 75 dc             	pushl  -0x24(%ebp)
  8003de:	68 98 22 80 00       	push   $0x802298
  8003e3:	e8 02 04 00 00       	call   8007ea <cprintf>
  8003e8:	83 c4 10             	add    $0x10,%esp
  8003eb:	eb 59                	jmp    800446 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f2:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fd:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800403:	83 ec 04             	sub    $0x4,%esp
  800406:	52                   	push   %edx
  800407:	50                   	push   %eax
  800408:	68 bc 22 80 00       	push   $0x8022bc
  80040d:	e8 d8 03 00 00       	call   8007ea <cprintf>
  800412:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800415:	a1 20 30 80 00       	mov    0x803020,%eax
  80041a:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800420:	a1 20 30 80 00       	mov    0x803020,%eax
  800425:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80042b:	a1 20 30 80 00       	mov    0x803020,%eax
  800430:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800436:	51                   	push   %ecx
  800437:	52                   	push   %edx
  800438:	50                   	push   %eax
  800439:	68 e4 22 80 00       	push   $0x8022e4
  80043e:	e8 a7 03 00 00       	call   8007ea <cprintf>
  800443:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800446:	a1 20 30 80 00       	mov    0x803020,%eax
  80044b:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800451:	83 ec 08             	sub    $0x8,%esp
  800454:	50                   	push   %eax
  800455:	68 3c 23 80 00       	push   $0x80233c
  80045a:	e8 8b 03 00 00       	call   8007ea <cprintf>
  80045f:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	68 50 23 80 00       	push   $0x802350
  80046a:	e8 7b 03 00 00       	call   8007ea <cprintf>
  80046f:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800472:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800479:	eb 28                	jmp    8004a3 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80047b:	a1 20 30 80 00       	mov    0x803020,%eax
  800480:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800483:	81 c2 74 04 00 00    	add    $0x474,%edx
  800489:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80048c:	83 ec 04             	sub    $0x4,%esp
  80048f:	50                   	push   %eax
  800490:	ff 75 e4             	pushl  -0x1c(%ebp)
  800493:	68 67 23 80 00       	push   $0x802367
  800498:	e8 4d 03 00 00       	call   8007ea <cprintf>
  80049d:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8004a0:	ff 45 e4             	incl   -0x1c(%ebp)
  8004a3:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004a7:	7e d2                	jle    80047b <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8004a9:	83 ec 0c             	sub    $0xc,%esp
  8004ac:	68 76 23 80 00       	push   $0x802376
  8004b1:	e8 34 03 00 00       	call   8007ea <cprintf>
  8004b6:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8004b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004be:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004c4:	83 ec 08             	sub    $0x8,%esp
  8004c7:	50                   	push   %eax
  8004c8:	68 7a 23 80 00       	push   $0x80237a
  8004cd:	e8 18 03 00 00       	call   8007ea <cprintf>
  8004d2:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004d5:	83 ec 0c             	sub    $0xc,%esp
  8004d8:	68 70 22 80 00       	push   $0x802270
  8004dd:	e8 08 03 00 00       	call   8007ea <cprintf>
  8004e2:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004e5:	e8 6e 12 00 00       	call   801758 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004ea:	e8 1f 00 00 00       	call   80050e <exit>
}
  8004ef:	90                   	nop
  8004f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004f3:	5b                   	pop    %ebx
  8004f4:	5e                   	pop    %esi
  8004f5:	5f                   	pop    %edi
  8004f6:	5d                   	pop    %ebp
  8004f7:	c3                   	ret    

008004f8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004f8:	55                   	push   %ebp
  8004f9:	89 e5                	mov    %esp,%ebp
  8004fb:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004fe:	83 ec 0c             	sub    $0xc,%esp
  800501:	6a 00                	push   $0x0
  800503:	e8 7a 14 00 00       	call   801982 <sys_destroy_env>
  800508:	83 c4 10             	add    $0x10,%esp
}
  80050b:	90                   	nop
  80050c:	c9                   	leave  
  80050d:	c3                   	ret    

0080050e <exit>:

void
exit(void)
{
  80050e:	55                   	push   %ebp
  80050f:	89 e5                	mov    %esp,%ebp
  800511:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800514:	e8 cf 14 00 00       	call   8019e8 <sys_exit_env>
}
  800519:	90                   	nop
  80051a:	c9                   	leave  
  80051b:	c3                   	ret    

0080051c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80051c:	55                   	push   %ebp
  80051d:	89 e5                	mov    %esp,%ebp
  80051f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800522:	8d 45 10             	lea    0x10(%ebp),%eax
  800525:	83 c0 04             	add    $0x4,%eax
  800528:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80052b:	a1 28 31 80 00       	mov    0x803128,%eax
  800530:	85 c0                	test   %eax,%eax
  800532:	74 16                	je     80054a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800534:	a1 28 31 80 00       	mov    0x803128,%eax
  800539:	83 ec 08             	sub    $0x8,%esp
  80053c:	50                   	push   %eax
  80053d:	68 5c 24 80 00       	push   $0x80245c
  800542:	e8 a3 02 00 00       	call   8007ea <cprintf>
  800547:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80054a:	a1 04 30 80 00       	mov    0x803004,%eax
  80054f:	83 ec 0c             	sub    $0xc,%esp
  800552:	ff 75 0c             	pushl  0xc(%ebp)
  800555:	ff 75 08             	pushl  0x8(%ebp)
  800558:	50                   	push   %eax
  800559:	68 64 24 80 00       	push   $0x802464
  80055e:	6a 74                	push   $0x74
  800560:	e8 b2 02 00 00       	call   800817 <cprintf_colored>
  800565:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800568:	8b 45 10             	mov    0x10(%ebp),%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 f4             	pushl  -0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	e8 04 02 00 00       	call   80077b <vcprintf>
  800577:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80057a:	83 ec 08             	sub    $0x8,%esp
  80057d:	6a 00                	push   $0x0
  80057f:	68 8c 24 80 00       	push   $0x80248c
  800584:	e8 f2 01 00 00       	call   80077b <vcprintf>
  800589:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80058c:	e8 7d ff ff ff       	call   80050e <exit>

	// should not return here
	while (1) ;
  800591:	eb fe                	jmp    800591 <_panic+0x75>

00800593 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800593:	55                   	push   %ebp
  800594:	89 e5                	mov    %esp,%ebp
  800596:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800599:	a1 20 30 80 00       	mov    0x803020,%eax
  80059e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a7:	39 c2                	cmp    %eax,%edx
  8005a9:	74 14                	je     8005bf <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005ab:	83 ec 04             	sub    $0x4,%esp
  8005ae:	68 90 24 80 00       	push   $0x802490
  8005b3:	6a 26                	push   $0x26
  8005b5:	68 dc 24 80 00       	push   $0x8024dc
  8005ba:	e8 5d ff ff ff       	call   80051c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005cd:	e9 c5 00 00 00       	jmp    800697 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005df:	01 d0                	add    %edx,%eax
  8005e1:	8b 00                	mov    (%eax),%eax
  8005e3:	85 c0                	test   %eax,%eax
  8005e5:	75 08                	jne    8005ef <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005e7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005ea:	e9 a5 00 00 00       	jmp    800694 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005fd:	eb 69                	jmp    800668 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800604:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80060a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80060d:	89 d0                	mov    %edx,%eax
  80060f:	01 c0                	add    %eax,%eax
  800611:	01 d0                	add    %edx,%eax
  800613:	c1 e0 03             	shl    $0x3,%eax
  800616:	01 c8                	add    %ecx,%eax
  800618:	8a 40 04             	mov    0x4(%eax),%al
  80061b:	84 c0                	test   %al,%al
  80061d:	75 46                	jne    800665 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80061f:	a1 20 30 80 00       	mov    0x803020,%eax
  800624:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80062a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80062d:	89 d0                	mov    %edx,%eax
  80062f:	01 c0                	add    %eax,%eax
  800631:	01 d0                	add    %edx,%eax
  800633:	c1 e0 03             	shl    $0x3,%eax
  800636:	01 c8                	add    %ecx,%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80063d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800640:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800645:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800647:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800651:	8b 45 08             	mov    0x8(%ebp),%eax
  800654:	01 c8                	add    %ecx,%eax
  800656:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800658:	39 c2                	cmp    %eax,%edx
  80065a:	75 09                	jne    800665 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80065c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800663:	eb 15                	jmp    80067a <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800665:	ff 45 e8             	incl   -0x18(%ebp)
  800668:	a1 20 30 80 00       	mov    0x803020,%eax
  80066d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800673:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800676:	39 c2                	cmp    %eax,%edx
  800678:	77 85                	ja     8005ff <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80067a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80067e:	75 14                	jne    800694 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 e8 24 80 00       	push   $0x8024e8
  800688:	6a 3a                	push   $0x3a
  80068a:	68 dc 24 80 00       	push   $0x8024dc
  80068f:	e8 88 fe ff ff       	call   80051c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800694:	ff 45 f0             	incl   -0x10(%ebp)
  800697:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80069d:	0f 8c 2f ff ff ff    	jl     8005d2 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006aa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006b1:	eb 26                	jmp    8006d9 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b8:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8006be:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c1:	89 d0                	mov    %edx,%eax
  8006c3:	01 c0                	add    %eax,%eax
  8006c5:	01 d0                	add    %edx,%eax
  8006c7:	c1 e0 03             	shl    $0x3,%eax
  8006ca:	01 c8                	add    %ecx,%eax
  8006cc:	8a 40 04             	mov    0x4(%eax),%al
  8006cf:	3c 01                	cmp    $0x1,%al
  8006d1:	75 03                	jne    8006d6 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006d3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006d6:	ff 45 e0             	incl   -0x20(%ebp)
  8006d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006de:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006e7:	39 c2                	cmp    %eax,%edx
  8006e9:	77 c8                	ja     8006b3 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ee:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006f1:	74 14                	je     800707 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006f3:	83 ec 04             	sub    $0x4,%esp
  8006f6:	68 3c 25 80 00       	push   $0x80253c
  8006fb:	6a 44                	push   $0x44
  8006fd:	68 dc 24 80 00       	push   $0x8024dc
  800702:	e8 15 fe ff ff       	call   80051c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800707:	90                   	nop
  800708:	c9                   	leave  
  800709:	c3                   	ret    

0080070a <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80070a:	55                   	push   %ebp
  80070b:	89 e5                	mov    %esp,%ebp
  80070d:	53                   	push   %ebx
  80070e:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800711:	8b 45 0c             	mov    0xc(%ebp),%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	8d 48 01             	lea    0x1(%eax),%ecx
  800719:	8b 55 0c             	mov    0xc(%ebp),%edx
  80071c:	89 0a                	mov    %ecx,(%edx)
  80071e:	8b 55 08             	mov    0x8(%ebp),%edx
  800721:	88 d1                	mov    %dl,%cl
  800723:	8b 55 0c             	mov    0xc(%ebp),%edx
  800726:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80072a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072d:	8b 00                	mov    (%eax),%eax
  80072f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800734:	75 30                	jne    800766 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800736:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80073c:	a0 40 30 80 00       	mov    0x803040,%al
  800741:	0f b6 c0             	movzbl %al,%eax
  800744:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800747:	8b 09                	mov    (%ecx),%ecx
  800749:	89 cb                	mov    %ecx,%ebx
  80074b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80074e:	83 c1 08             	add    $0x8,%ecx
  800751:	52                   	push   %edx
  800752:	50                   	push   %eax
  800753:	53                   	push   %ebx
  800754:	51                   	push   %ecx
  800755:	e8 a0 0f 00 00       	call   8016fa <sys_cputs>
  80075a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80075d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800760:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800766:	8b 45 0c             	mov    0xc(%ebp),%eax
  800769:	8b 40 04             	mov    0x4(%eax),%eax
  80076c:	8d 50 01             	lea    0x1(%eax),%edx
  80076f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800772:	89 50 04             	mov    %edx,0x4(%eax)
}
  800775:	90                   	nop
  800776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800779:	c9                   	leave  
  80077a:	c3                   	ret    

0080077b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80077b:	55                   	push   %ebp
  80077c:	89 e5                	mov    %esp,%ebp
  80077e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800784:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80078b:	00 00 00 
	b.cnt = 0;
  80078e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800795:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800798:	ff 75 0c             	pushl  0xc(%ebp)
  80079b:	ff 75 08             	pushl  0x8(%ebp)
  80079e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007a4:	50                   	push   %eax
  8007a5:	68 0a 07 80 00       	push   $0x80070a
  8007aa:	e8 5a 02 00 00       	call   800a09 <vprintfmt>
  8007af:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8007b2:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8007b8:	a0 40 30 80 00       	mov    0x803040,%al
  8007bd:	0f b6 c0             	movzbl %al,%eax
  8007c0:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8007c6:	52                   	push   %edx
  8007c7:	50                   	push   %eax
  8007c8:	51                   	push   %ecx
  8007c9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007cf:	83 c0 08             	add    $0x8,%eax
  8007d2:	50                   	push   %eax
  8007d3:	e8 22 0f 00 00       	call   8016fa <sys_cputs>
  8007d8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007db:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007e2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007e8:	c9                   	leave  
  8007e9:	c3                   	ret    

008007ea <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007ea:	55                   	push   %ebp
  8007eb:	89 e5                	mov    %esp,%ebp
  8007ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007f0:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007f7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	83 ec 08             	sub    $0x8,%esp
  800803:	ff 75 f4             	pushl  -0xc(%ebp)
  800806:	50                   	push   %eax
  800807:	e8 6f ff ff ff       	call   80077b <vcprintf>
  80080c:	83 c4 10             	add    $0x10,%esp
  80080f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800812:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800815:	c9                   	leave  
  800816:	c3                   	ret    

00800817 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800817:	55                   	push   %ebp
  800818:	89 e5                	mov    %esp,%ebp
  80081a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80081d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	c1 e0 08             	shl    $0x8,%eax
  80082a:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  80082f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800832:	83 c0 04             	add    $0x4,%eax
  800835:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083b:	83 ec 08             	sub    $0x8,%esp
  80083e:	ff 75 f4             	pushl  -0xc(%ebp)
  800841:	50                   	push   %eax
  800842:	e8 34 ff ff ff       	call   80077b <vcprintf>
  800847:	83 c4 10             	add    $0x10,%esp
  80084a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80084d:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800854:	07 00 00 

	return cnt;
  800857:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80085a:	c9                   	leave  
  80085b:	c3                   	ret    

0080085c <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80085c:	55                   	push   %ebp
  80085d:	89 e5                	mov    %esp,%ebp
  80085f:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800862:	e8 d7 0e 00 00       	call   80173e <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800867:	8d 45 0c             	lea    0xc(%ebp),%eax
  80086a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	83 ec 08             	sub    $0x8,%esp
  800873:	ff 75 f4             	pushl  -0xc(%ebp)
  800876:	50                   	push   %eax
  800877:	e8 ff fe ff ff       	call   80077b <vcprintf>
  80087c:	83 c4 10             	add    $0x10,%esp
  80087f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800882:	e8 d1 0e 00 00       	call   801758 <sys_unlock_cons>
	return cnt;
  800887:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80088a:	c9                   	leave  
  80088b:	c3                   	ret    

0080088c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80088c:	55                   	push   %ebp
  80088d:	89 e5                	mov    %esp,%ebp
  80088f:	53                   	push   %ebx
  800890:	83 ec 14             	sub    $0x14,%esp
  800893:	8b 45 10             	mov    0x10(%ebp),%eax
  800896:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800899:	8b 45 14             	mov    0x14(%ebp),%eax
  80089c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80089f:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008aa:	77 55                	ja     800901 <printnum+0x75>
  8008ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008af:	72 05                	jb     8008b6 <printnum+0x2a>
  8008b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008b4:	77 4b                	ja     800901 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008b6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008b9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008bc:	8b 45 18             	mov    0x18(%ebp),%eax
  8008bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c4:	52                   	push   %edx
  8008c5:	50                   	push   %eax
  8008c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8008cc:	e8 2f 14 00 00       	call   801d00 <__udivdi3>
  8008d1:	83 c4 10             	add    $0x10,%esp
  8008d4:	83 ec 04             	sub    $0x4,%esp
  8008d7:	ff 75 20             	pushl  0x20(%ebp)
  8008da:	53                   	push   %ebx
  8008db:	ff 75 18             	pushl  0x18(%ebp)
  8008de:	52                   	push   %edx
  8008df:	50                   	push   %eax
  8008e0:	ff 75 0c             	pushl  0xc(%ebp)
  8008e3:	ff 75 08             	pushl  0x8(%ebp)
  8008e6:	e8 a1 ff ff ff       	call   80088c <printnum>
  8008eb:	83 c4 20             	add    $0x20,%esp
  8008ee:	eb 1a                	jmp    80090a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008f0:	83 ec 08             	sub    $0x8,%esp
  8008f3:	ff 75 0c             	pushl  0xc(%ebp)
  8008f6:	ff 75 20             	pushl  0x20(%ebp)
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	ff d0                	call   *%eax
  8008fe:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800901:	ff 4d 1c             	decl   0x1c(%ebp)
  800904:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800908:	7f e6                	jg     8008f0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80090a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80090d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800912:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800915:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800918:	53                   	push   %ebx
  800919:	51                   	push   %ecx
  80091a:	52                   	push   %edx
  80091b:	50                   	push   %eax
  80091c:	e8 ef 14 00 00       	call   801e10 <__umoddi3>
  800921:	83 c4 10             	add    $0x10,%esp
  800924:	05 b4 27 80 00       	add    $0x8027b4,%eax
  800929:	8a 00                	mov    (%eax),%al
  80092b:	0f be c0             	movsbl %al,%eax
  80092e:	83 ec 08             	sub    $0x8,%esp
  800931:	ff 75 0c             	pushl  0xc(%ebp)
  800934:	50                   	push   %eax
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	ff d0                	call   *%eax
  80093a:	83 c4 10             	add    $0x10,%esp
}
  80093d:	90                   	nop
  80093e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800941:	c9                   	leave  
  800942:	c3                   	ret    

00800943 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800943:	55                   	push   %ebp
  800944:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800946:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80094a:	7e 1c                	jle    800968 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	8b 00                	mov    (%eax),%eax
  800951:	8d 50 08             	lea    0x8(%eax),%edx
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	89 10                	mov    %edx,(%eax)
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	8b 00                	mov    (%eax),%eax
  80095e:	83 e8 08             	sub    $0x8,%eax
  800961:	8b 50 04             	mov    0x4(%eax),%edx
  800964:	8b 00                	mov    (%eax),%eax
  800966:	eb 40                	jmp    8009a8 <getuint+0x65>
	else if (lflag)
  800968:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096c:	74 1e                	je     80098c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	8b 00                	mov    (%eax),%eax
  800973:	8d 50 04             	lea    0x4(%eax),%edx
  800976:	8b 45 08             	mov    0x8(%ebp),%eax
  800979:	89 10                	mov    %edx,(%eax)
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	8b 00                	mov    (%eax),%eax
  800980:	83 e8 04             	sub    $0x4,%eax
  800983:	8b 00                	mov    (%eax),%eax
  800985:	ba 00 00 00 00       	mov    $0x0,%edx
  80098a:	eb 1c                	jmp    8009a8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	8b 00                	mov    (%eax),%eax
  800991:	8d 50 04             	lea    0x4(%eax),%edx
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	89 10                	mov    %edx,(%eax)
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	83 e8 04             	sub    $0x4,%eax
  8009a1:	8b 00                	mov    (%eax),%eax
  8009a3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009a8:	5d                   	pop    %ebp
  8009a9:	c3                   	ret    

008009aa <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009aa:	55                   	push   %ebp
  8009ab:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009ad:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009b1:	7e 1c                	jle    8009cf <getint+0x25>
		return va_arg(*ap, long long);
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	8b 00                	mov    (%eax),%eax
  8009b8:	8d 50 08             	lea    0x8(%eax),%edx
  8009bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009be:	89 10                	mov    %edx,(%eax)
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	8b 00                	mov    (%eax),%eax
  8009c5:	83 e8 08             	sub    $0x8,%eax
  8009c8:	8b 50 04             	mov    0x4(%eax),%edx
  8009cb:	8b 00                	mov    (%eax),%eax
  8009cd:	eb 38                	jmp    800a07 <getint+0x5d>
	else if (lflag)
  8009cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d3:	74 1a                	je     8009ef <getint+0x45>
		return va_arg(*ap, long);
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	8b 00                	mov    (%eax),%eax
  8009da:	8d 50 04             	lea    0x4(%eax),%edx
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	89 10                	mov    %edx,(%eax)
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	8b 00                	mov    (%eax),%eax
  8009e7:	83 e8 04             	sub    $0x4,%eax
  8009ea:	8b 00                	mov    (%eax),%eax
  8009ec:	99                   	cltd   
  8009ed:	eb 18                	jmp    800a07 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	8b 00                	mov    (%eax),%eax
  8009f4:	8d 50 04             	lea    0x4(%eax),%edx
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	89 10                	mov    %edx,(%eax)
  8009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ff:	8b 00                	mov    (%eax),%eax
  800a01:	83 e8 04             	sub    $0x4,%eax
  800a04:	8b 00                	mov    (%eax),%eax
  800a06:	99                   	cltd   
}
  800a07:	5d                   	pop    %ebp
  800a08:	c3                   	ret    

00800a09 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a09:	55                   	push   %ebp
  800a0a:	89 e5                	mov    %esp,%ebp
  800a0c:	56                   	push   %esi
  800a0d:	53                   	push   %ebx
  800a0e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a11:	eb 17                	jmp    800a2a <vprintfmt+0x21>
			if (ch == '\0')
  800a13:	85 db                	test   %ebx,%ebx
  800a15:	0f 84 c1 03 00 00    	je     800ddc <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	ff 75 0c             	pushl  0xc(%ebp)
  800a21:	53                   	push   %ebx
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	ff d0                	call   *%eax
  800a27:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2d:	8d 50 01             	lea    0x1(%eax),%edx
  800a30:	89 55 10             	mov    %edx,0x10(%ebp)
  800a33:	8a 00                	mov    (%eax),%al
  800a35:	0f b6 d8             	movzbl %al,%ebx
  800a38:	83 fb 25             	cmp    $0x25,%ebx
  800a3b:	75 d6                	jne    800a13 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a3d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a41:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a48:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a4f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a56:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a60:	8d 50 01             	lea    0x1(%eax),%edx
  800a63:	89 55 10             	mov    %edx,0x10(%ebp)
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	0f b6 d8             	movzbl %al,%ebx
  800a6b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a6e:	83 f8 5b             	cmp    $0x5b,%eax
  800a71:	0f 87 3d 03 00 00    	ja     800db4 <vprintfmt+0x3ab>
  800a77:	8b 04 85 d8 27 80 00 	mov    0x8027d8(,%eax,4),%eax
  800a7e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a80:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a84:	eb d7                	jmp    800a5d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a86:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a8a:	eb d1                	jmp    800a5d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a8c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a93:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a96:	89 d0                	mov    %edx,%eax
  800a98:	c1 e0 02             	shl    $0x2,%eax
  800a9b:	01 d0                	add    %edx,%eax
  800a9d:	01 c0                	add    %eax,%eax
  800a9f:	01 d8                	add    %ebx,%eax
  800aa1:	83 e8 30             	sub    $0x30,%eax
  800aa4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800aa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800aaf:	83 fb 2f             	cmp    $0x2f,%ebx
  800ab2:	7e 3e                	jle    800af2 <vprintfmt+0xe9>
  800ab4:	83 fb 39             	cmp    $0x39,%ebx
  800ab7:	7f 39                	jg     800af2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ab9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800abc:	eb d5                	jmp    800a93 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800abe:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac1:	83 c0 04             	add    $0x4,%eax
  800ac4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac7:	8b 45 14             	mov    0x14(%ebp),%eax
  800aca:	83 e8 04             	sub    $0x4,%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ad2:	eb 1f                	jmp    800af3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ad4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad8:	79 83                	jns    800a5d <vprintfmt+0x54>
				width = 0;
  800ada:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ae1:	e9 77 ff ff ff       	jmp    800a5d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ae6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aed:	e9 6b ff ff ff       	jmp    800a5d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800af2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800af3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800af7:	0f 89 60 ff ff ff    	jns    800a5d <vprintfmt+0x54>
				width = precision, precision = -1;
  800afd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b00:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b03:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b0a:	e9 4e ff ff ff       	jmp    800a5d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b0f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b12:	e9 46 ff ff ff       	jmp    800a5d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b17:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1a:	83 c0 04             	add    $0x4,%eax
  800b1d:	89 45 14             	mov    %eax,0x14(%ebp)
  800b20:	8b 45 14             	mov    0x14(%ebp),%eax
  800b23:	83 e8 04             	sub    $0x4,%eax
  800b26:	8b 00                	mov    (%eax),%eax
  800b28:	83 ec 08             	sub    $0x8,%esp
  800b2b:	ff 75 0c             	pushl  0xc(%ebp)
  800b2e:	50                   	push   %eax
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	ff d0                	call   *%eax
  800b34:	83 c4 10             	add    $0x10,%esp
			break;
  800b37:	e9 9b 02 00 00       	jmp    800dd7 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3f:	83 c0 04             	add    $0x4,%eax
  800b42:	89 45 14             	mov    %eax,0x14(%ebp)
  800b45:	8b 45 14             	mov    0x14(%ebp),%eax
  800b48:	83 e8 04             	sub    $0x4,%eax
  800b4b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b4d:	85 db                	test   %ebx,%ebx
  800b4f:	79 02                	jns    800b53 <vprintfmt+0x14a>
				err = -err;
  800b51:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b53:	83 fb 64             	cmp    $0x64,%ebx
  800b56:	7f 0b                	jg     800b63 <vprintfmt+0x15a>
  800b58:	8b 34 9d 20 26 80 00 	mov    0x802620(,%ebx,4),%esi
  800b5f:	85 f6                	test   %esi,%esi
  800b61:	75 19                	jne    800b7c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b63:	53                   	push   %ebx
  800b64:	68 c5 27 80 00       	push   $0x8027c5
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	ff 75 08             	pushl  0x8(%ebp)
  800b6f:	e8 70 02 00 00       	call   800de4 <printfmt>
  800b74:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b77:	e9 5b 02 00 00       	jmp    800dd7 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b7c:	56                   	push   %esi
  800b7d:	68 ce 27 80 00       	push   $0x8027ce
  800b82:	ff 75 0c             	pushl  0xc(%ebp)
  800b85:	ff 75 08             	pushl  0x8(%ebp)
  800b88:	e8 57 02 00 00       	call   800de4 <printfmt>
  800b8d:	83 c4 10             	add    $0x10,%esp
			break;
  800b90:	e9 42 02 00 00       	jmp    800dd7 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b95:	8b 45 14             	mov    0x14(%ebp),%eax
  800b98:	83 c0 04             	add    $0x4,%eax
  800b9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800b9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba1:	83 e8 04             	sub    $0x4,%eax
  800ba4:	8b 30                	mov    (%eax),%esi
  800ba6:	85 f6                	test   %esi,%esi
  800ba8:	75 05                	jne    800baf <vprintfmt+0x1a6>
				p = "(null)";
  800baa:	be d1 27 80 00       	mov    $0x8027d1,%esi
			if (width > 0 && padc != '-')
  800baf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb3:	7e 6d                	jle    800c22 <vprintfmt+0x219>
  800bb5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bb9:	74 67                	je     800c22 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bbe:	83 ec 08             	sub    $0x8,%esp
  800bc1:	50                   	push   %eax
  800bc2:	56                   	push   %esi
  800bc3:	e8 1e 03 00 00       	call   800ee6 <strnlen>
  800bc8:	83 c4 10             	add    $0x10,%esp
  800bcb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bce:	eb 16                	jmp    800be6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bd0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bd4:	83 ec 08             	sub    $0x8,%esp
  800bd7:	ff 75 0c             	pushl  0xc(%ebp)
  800bda:	50                   	push   %eax
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	ff d0                	call   *%eax
  800be0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800be3:	ff 4d e4             	decl   -0x1c(%ebp)
  800be6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bea:	7f e4                	jg     800bd0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bec:	eb 34                	jmp    800c22 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bee:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bf2:	74 1c                	je     800c10 <vprintfmt+0x207>
  800bf4:	83 fb 1f             	cmp    $0x1f,%ebx
  800bf7:	7e 05                	jle    800bfe <vprintfmt+0x1f5>
  800bf9:	83 fb 7e             	cmp    $0x7e,%ebx
  800bfc:	7e 12                	jle    800c10 <vprintfmt+0x207>
					putch('?', putdat);
  800bfe:	83 ec 08             	sub    $0x8,%esp
  800c01:	ff 75 0c             	pushl  0xc(%ebp)
  800c04:	6a 3f                	push   $0x3f
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	ff d0                	call   *%eax
  800c0b:	83 c4 10             	add    $0x10,%esp
  800c0e:	eb 0f                	jmp    800c1f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c10:	83 ec 08             	sub    $0x8,%esp
  800c13:	ff 75 0c             	pushl  0xc(%ebp)
  800c16:	53                   	push   %ebx
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	ff d0                	call   *%eax
  800c1c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c1f:	ff 4d e4             	decl   -0x1c(%ebp)
  800c22:	89 f0                	mov    %esi,%eax
  800c24:	8d 70 01             	lea    0x1(%eax),%esi
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	0f be d8             	movsbl %al,%ebx
  800c2c:	85 db                	test   %ebx,%ebx
  800c2e:	74 24                	je     800c54 <vprintfmt+0x24b>
  800c30:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c34:	78 b8                	js     800bee <vprintfmt+0x1e5>
  800c36:	ff 4d e0             	decl   -0x20(%ebp)
  800c39:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c3d:	79 af                	jns    800bee <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c3f:	eb 13                	jmp    800c54 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c41:	83 ec 08             	sub    $0x8,%esp
  800c44:	ff 75 0c             	pushl  0xc(%ebp)
  800c47:	6a 20                	push   $0x20
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4c:	ff d0                	call   *%eax
  800c4e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c51:	ff 4d e4             	decl   -0x1c(%ebp)
  800c54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c58:	7f e7                	jg     800c41 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c5a:	e9 78 01 00 00       	jmp    800dd7 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 e8             	pushl  -0x18(%ebp)
  800c65:	8d 45 14             	lea    0x14(%ebp),%eax
  800c68:	50                   	push   %eax
  800c69:	e8 3c fd ff ff       	call   8009aa <getint>
  800c6e:	83 c4 10             	add    $0x10,%esp
  800c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c74:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7d:	85 d2                	test   %edx,%edx
  800c7f:	79 23                	jns    800ca4 <vprintfmt+0x29b>
				putch('-', putdat);
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	6a 2d                	push   $0x2d
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	ff d0                	call   *%eax
  800c8e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c97:	f7 d8                	neg    %eax
  800c99:	83 d2 00             	adc    $0x0,%edx
  800c9c:	f7 da                	neg    %edx
  800c9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ca4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cab:	e9 bc 00 00 00       	jmp    800d6c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cb0:	83 ec 08             	sub    $0x8,%esp
  800cb3:	ff 75 e8             	pushl  -0x18(%ebp)
  800cb6:	8d 45 14             	lea    0x14(%ebp),%eax
  800cb9:	50                   	push   %eax
  800cba:	e8 84 fc ff ff       	call   800943 <getuint>
  800cbf:	83 c4 10             	add    $0x10,%esp
  800cc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cc8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ccf:	e9 98 00 00 00       	jmp    800d6c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cd4:	83 ec 08             	sub    $0x8,%esp
  800cd7:	ff 75 0c             	pushl  0xc(%ebp)
  800cda:	6a 58                	push   $0x58
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	ff d0                	call   *%eax
  800ce1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ce4:	83 ec 08             	sub    $0x8,%esp
  800ce7:	ff 75 0c             	pushl  0xc(%ebp)
  800cea:	6a 58                	push   $0x58
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	ff d0                	call   *%eax
  800cf1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cf4:	83 ec 08             	sub    $0x8,%esp
  800cf7:	ff 75 0c             	pushl  0xc(%ebp)
  800cfa:	6a 58                	push   $0x58
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	ff d0                	call   *%eax
  800d01:	83 c4 10             	add    $0x10,%esp
			break;
  800d04:	e9 ce 00 00 00       	jmp    800dd7 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	6a 30                	push   $0x30
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	ff d0                	call   *%eax
  800d16:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d19:	83 ec 08             	sub    $0x8,%esp
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	6a 78                	push   $0x78
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	ff d0                	call   *%eax
  800d26:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d29:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2c:	83 c0 04             	add    $0x4,%eax
  800d2f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d32:	8b 45 14             	mov    0x14(%ebp),%eax
  800d35:	83 e8 04             	sub    $0x4,%eax
  800d38:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d44:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d4b:	eb 1f                	jmp    800d6c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d4d:	83 ec 08             	sub    $0x8,%esp
  800d50:	ff 75 e8             	pushl  -0x18(%ebp)
  800d53:	8d 45 14             	lea    0x14(%ebp),%eax
  800d56:	50                   	push   %eax
  800d57:	e8 e7 fb ff ff       	call   800943 <getuint>
  800d5c:	83 c4 10             	add    $0x10,%esp
  800d5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d62:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d65:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d6c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d73:	83 ec 04             	sub    $0x4,%esp
  800d76:	52                   	push   %edx
  800d77:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d7a:	50                   	push   %eax
  800d7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7e:	ff 75 f0             	pushl  -0x10(%ebp)
  800d81:	ff 75 0c             	pushl  0xc(%ebp)
  800d84:	ff 75 08             	pushl  0x8(%ebp)
  800d87:	e8 00 fb ff ff       	call   80088c <printnum>
  800d8c:	83 c4 20             	add    $0x20,%esp
			break;
  800d8f:	eb 46                	jmp    800dd7 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d91:	83 ec 08             	sub    $0x8,%esp
  800d94:	ff 75 0c             	pushl  0xc(%ebp)
  800d97:	53                   	push   %ebx
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
			break;
  800da0:	eb 35                	jmp    800dd7 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800da2:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800da9:	eb 2c                	jmp    800dd7 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800dab:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800db2:	eb 23                	jmp    800dd7 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800db4:	83 ec 08             	sub    $0x8,%esp
  800db7:	ff 75 0c             	pushl  0xc(%ebp)
  800dba:	6a 25                	push   $0x25
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	ff d0                	call   *%eax
  800dc1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800dc4:	ff 4d 10             	decl   0x10(%ebp)
  800dc7:	eb 03                	jmp    800dcc <vprintfmt+0x3c3>
  800dc9:	ff 4d 10             	decl   0x10(%ebp)
  800dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcf:	48                   	dec    %eax
  800dd0:	8a 00                	mov    (%eax),%al
  800dd2:	3c 25                	cmp    $0x25,%al
  800dd4:	75 f3                	jne    800dc9 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800dd6:	90                   	nop
		}
	}
  800dd7:	e9 35 fc ff ff       	jmp    800a11 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ddc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ddd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800de0:	5b                   	pop    %ebx
  800de1:	5e                   	pop    %esi
  800de2:	5d                   	pop    %ebp
  800de3:	c3                   	ret    

00800de4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dea:	8d 45 10             	lea    0x10(%ebp),%eax
  800ded:	83 c0 04             	add    $0x4,%eax
  800df0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	ff 75 f4             	pushl  -0xc(%ebp)
  800df9:	50                   	push   %eax
  800dfa:	ff 75 0c             	pushl  0xc(%ebp)
  800dfd:	ff 75 08             	pushl  0x8(%ebp)
  800e00:	e8 04 fc ff ff       	call   800a09 <vprintfmt>
  800e05:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e08:	90                   	nop
  800e09:	c9                   	leave  
  800e0a:	c3                   	ret    

00800e0b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e0b:	55                   	push   %ebp
  800e0c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	8b 40 08             	mov    0x8(%eax),%eax
  800e14:	8d 50 01             	lea    0x1(%eax),%edx
  800e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	8b 10                	mov    (%eax),%edx
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	8b 40 04             	mov    0x4(%eax),%eax
  800e28:	39 c2                	cmp    %eax,%edx
  800e2a:	73 12                	jae    800e3e <sprintputch+0x33>
		*b->buf++ = ch;
  800e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2f:	8b 00                	mov    (%eax),%eax
  800e31:	8d 48 01             	lea    0x1(%eax),%ecx
  800e34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e37:	89 0a                	mov    %ecx,(%edx)
  800e39:	8b 55 08             	mov    0x8(%ebp),%edx
  800e3c:	88 10                	mov    %dl,(%eax)
}
  800e3e:	90                   	nop
  800e3f:	5d                   	pop    %ebp
  800e40:	c3                   	ret    

00800e41 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e41:	55                   	push   %ebp
  800e42:	89 e5                	mov    %esp,%ebp
  800e44:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	01 d0                	add    %edx,%eax
  800e58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e62:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e66:	74 06                	je     800e6e <vsnprintf+0x2d>
  800e68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e6c:	7f 07                	jg     800e75 <vsnprintf+0x34>
		return -E_INVAL;
  800e6e:	b8 03 00 00 00       	mov    $0x3,%eax
  800e73:	eb 20                	jmp    800e95 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e75:	ff 75 14             	pushl  0x14(%ebp)
  800e78:	ff 75 10             	pushl  0x10(%ebp)
  800e7b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e7e:	50                   	push   %eax
  800e7f:	68 0b 0e 80 00       	push   $0x800e0b
  800e84:	e8 80 fb ff ff       	call   800a09 <vprintfmt>
  800e89:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e8f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e92:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e95:	c9                   	leave  
  800e96:	c3                   	ret    

00800e97 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e97:	55                   	push   %ebp
  800e98:	89 e5                	mov    %esp,%ebp
  800e9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e9d:	8d 45 10             	lea    0x10(%ebp),%eax
  800ea0:	83 c0 04             	add    $0x4,%eax
  800ea3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ea6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea9:	ff 75 f4             	pushl  -0xc(%ebp)
  800eac:	50                   	push   %eax
  800ead:	ff 75 0c             	pushl  0xc(%ebp)
  800eb0:	ff 75 08             	pushl  0x8(%ebp)
  800eb3:	e8 89 ff ff ff       	call   800e41 <vsnprintf>
  800eb8:	83 c4 10             	add    $0x10,%esp
  800ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ebe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ec1:	c9                   	leave  
  800ec2:	c3                   	ret    

00800ec3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ec3:	55                   	push   %ebp
  800ec4:	89 e5                	mov    %esp,%ebp
  800ec6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ec9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed0:	eb 06                	jmp    800ed8 <strlen+0x15>
		n++;
  800ed2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ed5:	ff 45 08             	incl   0x8(%ebp)
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	84 c0                	test   %al,%al
  800edf:	75 f1                	jne    800ed2 <strlen+0xf>
		n++;
	return n;
  800ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee4:	c9                   	leave  
  800ee5:	c3                   	ret    

00800ee6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ee6:	55                   	push   %ebp
  800ee7:	89 e5                	mov    %esp,%ebp
  800ee9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef3:	eb 09                	jmp    800efe <strnlen+0x18>
		n++;
  800ef5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ef8:	ff 45 08             	incl   0x8(%ebp)
  800efb:	ff 4d 0c             	decl   0xc(%ebp)
  800efe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f02:	74 09                	je     800f0d <strnlen+0x27>
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	84 c0                	test   %al,%al
  800f0b:	75 e8                	jne    800ef5 <strnlen+0xf>
		n++;
	return n;
  800f0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f10:	c9                   	leave  
  800f11:	c3                   	ret    

00800f12 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f12:	55                   	push   %ebp
  800f13:	89 e5                	mov    %esp,%ebp
  800f15:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f1e:	90                   	nop
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8d 50 01             	lea    0x1(%eax),%edx
  800f25:	89 55 08             	mov    %edx,0x8(%ebp)
  800f28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f2e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f31:	8a 12                	mov    (%edx),%dl
  800f33:	88 10                	mov    %dl,(%eax)
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	84 c0                	test   %al,%al
  800f39:	75 e4                	jne    800f1f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f3e:	c9                   	leave  
  800f3f:	c3                   	ret    

00800f40 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f40:	55                   	push   %ebp
  800f41:	89 e5                	mov    %esp,%ebp
  800f43:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f53:	eb 1f                	jmp    800f74 <strncpy+0x34>
		*dst++ = *src;
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8d 50 01             	lea    0x1(%eax),%edx
  800f5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f61:	8a 12                	mov    (%edx),%dl
  800f63:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	84 c0                	test   %al,%al
  800f6c:	74 03                	je     800f71 <strncpy+0x31>
			src++;
  800f6e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f71:	ff 45 fc             	incl   -0x4(%ebp)
  800f74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f77:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f7a:	72 d9                	jb     800f55 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f7f:	c9                   	leave  
  800f80:	c3                   	ret    

00800f81 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f81:	55                   	push   %ebp
  800f82:	89 e5                	mov    %esp,%ebp
  800f84:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f91:	74 30                	je     800fc3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f93:	eb 16                	jmp    800fab <strlcpy+0x2a>
			*dst++ = *src++;
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8d 50 01             	lea    0x1(%eax),%edx
  800f9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fa7:	8a 12                	mov    (%edx),%dl
  800fa9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fab:	ff 4d 10             	decl   0x10(%ebp)
  800fae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb2:	74 09                	je     800fbd <strlcpy+0x3c>
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	84 c0                	test   %al,%al
  800fbb:	75 d8                	jne    800f95 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fc3:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc9:	29 c2                	sub    %eax,%edx
  800fcb:	89 d0                	mov    %edx,%eax
}
  800fcd:	c9                   	leave  
  800fce:	c3                   	ret    

00800fcf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fcf:	55                   	push   %ebp
  800fd0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fd2:	eb 06                	jmp    800fda <strcmp+0xb>
		p++, q++;
  800fd4:	ff 45 08             	incl   0x8(%ebp)
  800fd7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	84 c0                	test   %al,%al
  800fe1:	74 0e                	je     800ff1 <strcmp+0x22>
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 10                	mov    (%eax),%dl
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	38 c2                	cmp    %al,%dl
  800fef:	74 e3                	je     800fd4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	0f b6 d0             	movzbl %al,%edx
  800ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	0f b6 c0             	movzbl %al,%eax
  801001:	29 c2                	sub    %eax,%edx
  801003:	89 d0                	mov    %edx,%eax
}
  801005:	5d                   	pop    %ebp
  801006:	c3                   	ret    

00801007 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801007:	55                   	push   %ebp
  801008:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80100a:	eb 09                	jmp    801015 <strncmp+0xe>
		n--, p++, q++;
  80100c:	ff 4d 10             	decl   0x10(%ebp)
  80100f:	ff 45 08             	incl   0x8(%ebp)
  801012:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801015:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801019:	74 17                	je     801032 <strncmp+0x2b>
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	84 c0                	test   %al,%al
  801022:	74 0e                	je     801032 <strncmp+0x2b>
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8a 10                	mov    (%eax),%dl
  801029:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	38 c2                	cmp    %al,%dl
  801030:	74 da                	je     80100c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801032:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801036:	75 07                	jne    80103f <strncmp+0x38>
		return 0;
  801038:	b8 00 00 00 00       	mov    $0x0,%eax
  80103d:	eb 14                	jmp    801053 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	0f b6 d0             	movzbl %al,%edx
  801047:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	0f b6 c0             	movzbl %al,%eax
  80104f:	29 c2                	sub    %eax,%edx
  801051:	89 d0                	mov    %edx,%eax
}
  801053:	5d                   	pop    %ebp
  801054:	c3                   	ret    

00801055 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 04             	sub    $0x4,%esp
  80105b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801061:	eb 12                	jmp    801075 <strchr+0x20>
		if (*s == c)
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	8a 00                	mov    (%eax),%al
  801068:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80106b:	75 05                	jne    801072 <strchr+0x1d>
			return (char *) s;
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	eb 11                	jmp    801083 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801072:	ff 45 08             	incl   0x8(%ebp)
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	84 c0                	test   %al,%al
  80107c:	75 e5                	jne    801063 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80107e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
  801088:	83 ec 04             	sub    $0x4,%esp
  80108b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801091:	eb 0d                	jmp    8010a0 <strfind+0x1b>
		if (*s == c)
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	8a 00                	mov    (%eax),%al
  801098:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80109b:	74 0e                	je     8010ab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80109d:	ff 45 08             	incl   0x8(%ebp)
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	8a 00                	mov    (%eax),%al
  8010a5:	84 c0                	test   %al,%al
  8010a7:	75 ea                	jne    801093 <strfind+0xe>
  8010a9:	eb 01                	jmp    8010ac <strfind+0x27>
		if (*s == c)
			break;
  8010ab:	90                   	nop
	return (char *) s;
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010af:	c9                   	leave  
  8010b0:	c3                   	ret    

008010b1 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
  8010b4:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8010bd:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010c1:	76 63                	jbe    801126 <memset+0x75>
		uint64 data_block = c;
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	99                   	cltd   
  8010c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8010cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d3:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010d7:	c1 e0 08             	shl    $0x8,%eax
  8010da:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010dd:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e6:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010ea:	c1 e0 10             	shl    $0x10,%eax
  8010ed:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010f0:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f9:	89 c2                	mov    %eax,%edx
  8010fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801100:	09 45 f0             	or     %eax,-0x10(%ebp)
  801103:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801106:	eb 18                	jmp    801120 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801108:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80110b:	8d 41 08             	lea    0x8(%ecx),%eax
  80110e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801111:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801114:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801117:	89 01                	mov    %eax,(%ecx)
  801119:	89 51 04             	mov    %edx,0x4(%ecx)
  80111c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801120:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801124:	77 e2                	ja     801108 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801126:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112a:	74 23                	je     80114f <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80112c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801132:	eb 0e                	jmp    801142 <memset+0x91>
			*p8++ = (uint8)c;
  801134:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801137:	8d 50 01             	lea    0x1(%eax),%edx
  80113a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80113d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801140:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	8d 50 ff             	lea    -0x1(%eax),%edx
  801148:	89 55 10             	mov    %edx,0x10(%ebp)
  80114b:	85 c0                	test   %eax,%eax
  80114d:	75 e5                	jne    801134 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80115a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801166:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80116a:	76 24                	jbe    801190 <memcpy+0x3c>
		while(n >= 8){
  80116c:	eb 1c                	jmp    80118a <memcpy+0x36>
			*d64 = *s64;
  80116e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801171:	8b 50 04             	mov    0x4(%eax),%edx
  801174:	8b 00                	mov    (%eax),%eax
  801176:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801179:	89 01                	mov    %eax,(%ecx)
  80117b:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80117e:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801182:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801186:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80118a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80118e:	77 de                	ja     80116e <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801190:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801194:	74 31                	je     8011c7 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801196:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801199:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80119c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80119f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8011a2:	eb 16                	jmp    8011ba <memcpy+0x66>
			*d8++ = *s8++;
  8011a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011a7:	8d 50 01             	lea    0x1(%eax),%edx
  8011aa:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8011ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011b3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8011b6:	8a 12                	mov    (%edx),%dl
  8011b8:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8011ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011c3:	85 c0                	test   %eax,%eax
  8011c5:	75 dd                	jne    8011a4 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ca:	c9                   	leave  
  8011cb:	c3                   	ret    

008011cc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011cc:	55                   	push   %ebp
  8011cd:	89 e5                	mov    %esp,%ebp
  8011cf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011e4:	73 50                	jae    801236 <memmove+0x6a>
  8011e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ec:	01 d0                	add    %edx,%eax
  8011ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011f1:	76 43                	jbe    801236 <memmove+0x6a>
		s += n;
  8011f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011ff:	eb 10                	jmp    801211 <memmove+0x45>
			*--d = *--s;
  801201:	ff 4d f8             	decl   -0x8(%ebp)
  801204:	ff 4d fc             	decl   -0x4(%ebp)
  801207:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120a:	8a 10                	mov    (%eax),%dl
  80120c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801211:	8b 45 10             	mov    0x10(%ebp),%eax
  801214:	8d 50 ff             	lea    -0x1(%eax),%edx
  801217:	89 55 10             	mov    %edx,0x10(%ebp)
  80121a:	85 c0                	test   %eax,%eax
  80121c:	75 e3                	jne    801201 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80121e:	eb 23                	jmp    801243 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801220:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801223:	8d 50 01             	lea    0x1(%eax),%edx
  801226:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801229:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80122c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80122f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801232:	8a 12                	mov    (%edx),%dl
  801234:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801236:	8b 45 10             	mov    0x10(%ebp),%eax
  801239:	8d 50 ff             	lea    -0x1(%eax),%edx
  80123c:	89 55 10             	mov    %edx,0x10(%ebp)
  80123f:	85 c0                	test   %eax,%eax
  801241:	75 dd                	jne    801220 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801246:	c9                   	leave  
  801247:	c3                   	ret    

00801248 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801248:	55                   	push   %ebp
  801249:	89 e5                	mov    %esp,%ebp
  80124b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80125a:	eb 2a                	jmp    801286 <memcmp+0x3e>
		if (*s1 != *s2)
  80125c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125f:	8a 10                	mov    (%eax),%dl
  801261:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801264:	8a 00                	mov    (%eax),%al
  801266:	38 c2                	cmp    %al,%dl
  801268:	74 16                	je     801280 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80126a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126d:	8a 00                	mov    (%eax),%al
  80126f:	0f b6 d0             	movzbl %al,%edx
  801272:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	0f b6 c0             	movzbl %al,%eax
  80127a:	29 c2                	sub    %eax,%edx
  80127c:	89 d0                	mov    %edx,%eax
  80127e:	eb 18                	jmp    801298 <memcmp+0x50>
		s1++, s2++;
  801280:	ff 45 fc             	incl   -0x4(%ebp)
  801283:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801286:	8b 45 10             	mov    0x10(%ebp),%eax
  801289:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128c:	89 55 10             	mov    %edx,0x10(%ebp)
  80128f:	85 c0                	test   %eax,%eax
  801291:	75 c9                	jne    80125c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801293:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801298:	c9                   	leave  
  801299:	c3                   	ret    

0080129a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
  80129d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8012a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012ab:	eb 15                	jmp    8012c2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	0f b6 d0             	movzbl %al,%edx
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	0f b6 c0             	movzbl %al,%eax
  8012bb:	39 c2                	cmp    %eax,%edx
  8012bd:	74 0d                	je     8012cc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012bf:	ff 45 08             	incl   0x8(%ebp)
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012c8:	72 e3                	jb     8012ad <memfind+0x13>
  8012ca:	eb 01                	jmp    8012cd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012cc:	90                   	nop
	return (void *) s;
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
  8012d5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012e6:	eb 03                	jmp    8012eb <strtol+0x19>
		s++;
  8012e8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	8a 00                	mov    (%eax),%al
  8012f0:	3c 20                	cmp    $0x20,%al
  8012f2:	74 f4                	je     8012e8 <strtol+0x16>
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	8a 00                	mov    (%eax),%al
  8012f9:	3c 09                	cmp    $0x9,%al
  8012fb:	74 eb                	je     8012e8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	3c 2b                	cmp    $0x2b,%al
  801304:	75 05                	jne    80130b <strtol+0x39>
		s++;
  801306:	ff 45 08             	incl   0x8(%ebp)
  801309:	eb 13                	jmp    80131e <strtol+0x4c>
	else if (*s == '-')
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	8a 00                	mov    (%eax),%al
  801310:	3c 2d                	cmp    $0x2d,%al
  801312:	75 0a                	jne    80131e <strtol+0x4c>
		s++, neg = 1;
  801314:	ff 45 08             	incl   0x8(%ebp)
  801317:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80131e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801322:	74 06                	je     80132a <strtol+0x58>
  801324:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801328:	75 20                	jne    80134a <strtol+0x78>
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	3c 30                	cmp    $0x30,%al
  801331:	75 17                	jne    80134a <strtol+0x78>
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	40                   	inc    %eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	3c 78                	cmp    $0x78,%al
  80133b:	75 0d                	jne    80134a <strtol+0x78>
		s += 2, base = 16;
  80133d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801341:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801348:	eb 28                	jmp    801372 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80134a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134e:	75 15                	jne    801365 <strtol+0x93>
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	3c 30                	cmp    $0x30,%al
  801357:	75 0c                	jne    801365 <strtol+0x93>
		s++, base = 8;
  801359:	ff 45 08             	incl   0x8(%ebp)
  80135c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801363:	eb 0d                	jmp    801372 <strtol+0xa0>
	else if (base == 0)
  801365:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801369:	75 07                	jne    801372 <strtol+0xa0>
		base = 10;
  80136b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	3c 2f                	cmp    $0x2f,%al
  801379:	7e 19                	jle    801394 <strtol+0xc2>
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	8a 00                	mov    (%eax),%al
  801380:	3c 39                	cmp    $0x39,%al
  801382:	7f 10                	jg     801394 <strtol+0xc2>
			dig = *s - '0';
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	0f be c0             	movsbl %al,%eax
  80138c:	83 e8 30             	sub    $0x30,%eax
  80138f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801392:	eb 42                	jmp    8013d6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	3c 60                	cmp    $0x60,%al
  80139b:	7e 19                	jle    8013b6 <strtol+0xe4>
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	3c 7a                	cmp    $0x7a,%al
  8013a4:	7f 10                	jg     8013b6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	0f be c0             	movsbl %al,%eax
  8013ae:	83 e8 57             	sub    $0x57,%eax
  8013b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013b4:	eb 20                	jmp    8013d6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	8a 00                	mov    (%eax),%al
  8013bb:	3c 40                	cmp    $0x40,%al
  8013bd:	7e 39                	jle    8013f8 <strtol+0x126>
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3c 5a                	cmp    $0x5a,%al
  8013c6:	7f 30                	jg     8013f8 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	0f be c0             	movsbl %al,%eax
  8013d0:	83 e8 37             	sub    $0x37,%eax
  8013d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013dc:	7d 19                	jge    8013f7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013de:	ff 45 08             	incl   0x8(%ebp)
  8013e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013e8:	89 c2                	mov    %eax,%edx
  8013ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ed:	01 d0                	add    %edx,%eax
  8013ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013f2:	e9 7b ff ff ff       	jmp    801372 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013f7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013fc:	74 08                	je     801406 <strtol+0x134>
		*endptr = (char *) s;
  8013fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801401:	8b 55 08             	mov    0x8(%ebp),%edx
  801404:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801406:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80140a:	74 07                	je     801413 <strtol+0x141>
  80140c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80140f:	f7 d8                	neg    %eax
  801411:	eb 03                	jmp    801416 <strtol+0x144>
  801413:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <ltostr>:

void
ltostr(long value, char *str)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80141e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801425:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80142c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801430:	79 13                	jns    801445 <ltostr+0x2d>
	{
		neg = 1;
  801432:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801439:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80143f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801442:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80144d:	99                   	cltd   
  80144e:	f7 f9                	idiv   %ecx
  801450:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801453:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801456:	8d 50 01             	lea    0x1(%eax),%edx
  801459:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145c:	89 c2                	mov    %eax,%edx
  80145e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801461:	01 d0                	add    %edx,%eax
  801463:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801466:	83 c2 30             	add    $0x30,%edx
  801469:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80146b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80146e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801473:	f7 e9                	imul   %ecx
  801475:	c1 fa 02             	sar    $0x2,%edx
  801478:	89 c8                	mov    %ecx,%eax
  80147a:	c1 f8 1f             	sar    $0x1f,%eax
  80147d:	29 c2                	sub    %eax,%edx
  80147f:	89 d0                	mov    %edx,%eax
  801481:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801484:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801488:	75 bb                	jne    801445 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80148a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801491:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801494:	48                   	dec    %eax
  801495:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801498:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80149c:	74 3d                	je     8014db <ltostr+0xc3>
		start = 1 ;
  80149e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014a5:	eb 34                	jmp    8014db <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8014a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ad:	01 d0                	add    %edx,%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ba:	01 c2                	add    %eax,%edx
  8014bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c2:	01 c8                	add    %ecx,%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ce:	01 c2                	add    %eax,%edx
  8014d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8014d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014e1:	7c c4                	jl     8014a7 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e9:	01 d0                	add    %edx,%eax
  8014eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014ee:	90                   	nop
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
  8014f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014f7:	ff 75 08             	pushl  0x8(%ebp)
  8014fa:	e8 c4 f9 ff ff       	call   800ec3 <strlen>
  8014ff:	83 c4 04             	add    $0x4,%esp
  801502:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801505:	ff 75 0c             	pushl  0xc(%ebp)
  801508:	e8 b6 f9 ff ff       	call   800ec3 <strlen>
  80150d:	83 c4 04             	add    $0x4,%esp
  801510:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801513:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80151a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801521:	eb 17                	jmp    80153a <strcconcat+0x49>
		final[s] = str1[s] ;
  801523:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801526:	8b 45 10             	mov    0x10(%ebp),%eax
  801529:	01 c2                	add    %eax,%edx
  80152b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	01 c8                	add    %ecx,%eax
  801533:	8a 00                	mov    (%eax),%al
  801535:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801537:	ff 45 fc             	incl   -0x4(%ebp)
  80153a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801540:	7c e1                	jl     801523 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801542:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801549:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801550:	eb 1f                	jmp    801571 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801552:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801555:	8d 50 01             	lea    0x1(%eax),%edx
  801558:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80155b:	89 c2                	mov    %eax,%edx
  80155d:	8b 45 10             	mov    0x10(%ebp),%eax
  801560:	01 c2                	add    %eax,%edx
  801562:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801565:	8b 45 0c             	mov    0xc(%ebp),%eax
  801568:	01 c8                	add    %ecx,%eax
  80156a:	8a 00                	mov    (%eax),%al
  80156c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80156e:	ff 45 f8             	incl   -0x8(%ebp)
  801571:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801574:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801577:	7c d9                	jl     801552 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801579:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	01 d0                	add    %edx,%eax
  801581:	c6 00 00             	movb   $0x0,(%eax)
}
  801584:	90                   	nop
  801585:	c9                   	leave  
  801586:	c3                   	ret    

00801587 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801587:	55                   	push   %ebp
  801588:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80158a:	8b 45 14             	mov    0x14(%ebp),%eax
  80158d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801593:	8b 45 14             	mov    0x14(%ebp),%eax
  801596:	8b 00                	mov    (%eax),%eax
  801598:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80159f:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a2:	01 d0                	add    %edx,%eax
  8015a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015aa:	eb 0c                	jmp    8015b8 <strsplit+0x31>
			*string++ = 0;
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	8d 50 01             	lea    0x1(%eax),%edx
  8015b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8015b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	84 c0                	test   %al,%al
  8015bf:	74 18                	je     8015d9 <strsplit+0x52>
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	8a 00                	mov    (%eax),%al
  8015c6:	0f be c0             	movsbl %al,%eax
  8015c9:	50                   	push   %eax
  8015ca:	ff 75 0c             	pushl  0xc(%ebp)
  8015cd:	e8 83 fa ff ff       	call   801055 <strchr>
  8015d2:	83 c4 08             	add    $0x8,%esp
  8015d5:	85 c0                	test   %eax,%eax
  8015d7:	75 d3                	jne    8015ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	8a 00                	mov    (%eax),%al
  8015de:	84 c0                	test   %al,%al
  8015e0:	74 5a                	je     80163c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8015e5:	8b 00                	mov    (%eax),%eax
  8015e7:	83 f8 0f             	cmp    $0xf,%eax
  8015ea:	75 07                	jne    8015f3 <strsplit+0x6c>
		{
			return 0;
  8015ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8015f1:	eb 66                	jmp    801659 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f6:	8b 00                	mov    (%eax),%eax
  8015f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8015fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8015fe:	89 0a                	mov    %ecx,(%edx)
  801600:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	01 c2                	add    %eax,%edx
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801611:	eb 03                	jmp    801616 <strsplit+0x8f>
			string++;
  801613:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	84 c0                	test   %al,%al
  80161d:	74 8b                	je     8015aa <strsplit+0x23>
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	8a 00                	mov    (%eax),%al
  801624:	0f be c0             	movsbl %al,%eax
  801627:	50                   	push   %eax
  801628:	ff 75 0c             	pushl  0xc(%ebp)
  80162b:	e8 25 fa ff ff       	call   801055 <strchr>
  801630:	83 c4 08             	add    $0x8,%esp
  801633:	85 c0                	test   %eax,%eax
  801635:	74 dc                	je     801613 <strsplit+0x8c>
			string++;
	}
  801637:	e9 6e ff ff ff       	jmp    8015aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80163c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80163d:	8b 45 14             	mov    0x14(%ebp),%eax
  801640:	8b 00                	mov    (%eax),%eax
  801642:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	01 d0                	add    %edx,%eax
  80164e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801654:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
  80165e:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801667:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80166e:	eb 4a                	jmp    8016ba <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801670:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	01 c2                	add    %eax,%edx
  801678:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80167b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167e:	01 c8                	add    %ecx,%eax
  801680:	8a 00                	mov    (%eax),%al
  801682:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801684:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801687:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168a:	01 d0                	add    %edx,%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	3c 40                	cmp    $0x40,%al
  801690:	7e 25                	jle    8016b7 <str2lower+0x5c>
  801692:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801695:	8b 45 0c             	mov    0xc(%ebp),%eax
  801698:	01 d0                	add    %edx,%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	3c 5a                	cmp    $0x5a,%al
  80169e:	7f 17                	jg     8016b7 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8016a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	01 d0                	add    %edx,%eax
  8016a8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8016ae:	01 ca                	add    %ecx,%edx
  8016b0:	8a 12                	mov    (%edx),%dl
  8016b2:	83 c2 20             	add    $0x20,%edx
  8016b5:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8016b7:	ff 45 fc             	incl   -0x4(%ebp)
  8016ba:	ff 75 0c             	pushl  0xc(%ebp)
  8016bd:	e8 01 f8 ff ff       	call   800ec3 <strlen>
  8016c2:	83 c4 04             	add    $0x4,%esp
  8016c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016c8:	7f a6                	jg     801670 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8016ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
  8016d2:	57                   	push   %edi
  8016d3:	56                   	push   %esi
  8016d4:	53                   	push   %ebx
  8016d5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016e7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016ea:	cd 30                	int    $0x30
  8016ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016f2:	83 c4 10             	add    $0x10,%esp
  8016f5:	5b                   	pop    %ebx
  8016f6:	5e                   	pop    %esi
  8016f7:	5f                   	pop    %edi
  8016f8:	5d                   	pop    %ebp
  8016f9:	c3                   	ret    

008016fa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
  8016fd:	83 ec 04             	sub    $0x4,%esp
  801700:	8b 45 10             	mov    0x10(%ebp),%eax
  801703:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801706:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801709:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	6a 00                	push   $0x0
  801712:	51                   	push   %ecx
  801713:	52                   	push   %edx
  801714:	ff 75 0c             	pushl  0xc(%ebp)
  801717:	50                   	push   %eax
  801718:	6a 00                	push   $0x0
  80171a:	e8 b0 ff ff ff       	call   8016cf <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	90                   	nop
  801723:	c9                   	leave  
  801724:	c3                   	ret    

00801725 <sys_cgetc>:

int
sys_cgetc(void)
{
  801725:	55                   	push   %ebp
  801726:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 02                	push   $0x2
  801734:	e8 96 ff ff ff       	call   8016cf <syscall>
  801739:	83 c4 18             	add    $0x18,%esp
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_lock_cons>:

void sys_lock_cons(void)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 03                	push   $0x3
  80174d:	e8 7d ff ff ff       	call   8016cf <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	90                   	nop
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 04                	push   $0x4
  801767:	e8 63 ff ff ff       	call   8016cf <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	90                   	nop
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801775:	8b 55 0c             	mov    0xc(%ebp),%edx
  801778:	8b 45 08             	mov    0x8(%ebp),%eax
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	52                   	push   %edx
  801782:	50                   	push   %eax
  801783:	6a 08                	push   $0x8
  801785:	e8 45 ff ff ff       	call   8016cf <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
  801792:	56                   	push   %esi
  801793:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801794:	8b 75 18             	mov    0x18(%ebp),%esi
  801797:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80179a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80179d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	56                   	push   %esi
  8017a4:	53                   	push   %ebx
  8017a5:	51                   	push   %ecx
  8017a6:	52                   	push   %edx
  8017a7:	50                   	push   %eax
  8017a8:	6a 09                	push   $0x9
  8017aa:	e8 20 ff ff ff       	call   8016cf <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017b5:	5b                   	pop    %ebx
  8017b6:	5e                   	pop    %esi
  8017b7:	5d                   	pop    %ebp
  8017b8:	c3                   	ret    

008017b9 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	ff 75 08             	pushl  0x8(%ebp)
  8017c7:	6a 0a                	push   $0xa
  8017c9:	e8 01 ff ff ff       	call   8016cf <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	c9                   	leave  
  8017d2:	c3                   	ret    

008017d3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	ff 75 0c             	pushl  0xc(%ebp)
  8017df:	ff 75 08             	pushl  0x8(%ebp)
  8017e2:	6a 0b                	push   $0xb
  8017e4:	e8 e6 fe ff ff       	call   8016cf <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
}
  8017ec:	c9                   	leave  
  8017ed:	c3                   	ret    

008017ee <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017ee:	55                   	push   %ebp
  8017ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 0c                	push   $0xc
  8017fd:	e8 cd fe ff ff       	call   8016cf <syscall>
  801802:	83 c4 18             	add    $0x18,%esp
}
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 0d                	push   $0xd
  801816:	e8 b4 fe ff ff       	call   8016cf <syscall>
  80181b:	83 c4 18             	add    $0x18,%esp
}
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 0e                	push   $0xe
  80182f:	e8 9b fe ff ff       	call   8016cf <syscall>
  801834:	83 c4 18             	add    $0x18,%esp
}
  801837:	c9                   	leave  
  801838:	c3                   	ret    

00801839 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 0f                	push   $0xf
  801848:	e8 82 fe ff ff       	call   8016cf <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	ff 75 08             	pushl  0x8(%ebp)
  801860:	6a 10                	push   $0x10
  801862:	e8 68 fe ff ff       	call   8016cf <syscall>
  801867:	83 c4 18             	add    $0x18,%esp
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 11                	push   $0x11
  80187b:	e8 4f fe ff ff       	call   8016cf <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	90                   	nop
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_cputc>:

void
sys_cputc(const char c)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
  801889:	83 ec 04             	sub    $0x4,%esp
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801892:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	50                   	push   %eax
  80189f:	6a 01                	push   $0x1
  8018a1:	e8 29 fe ff ff       	call   8016cf <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	90                   	nop
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 14                	push   $0x14
  8018bb:	e8 0f fe ff ff       	call   8016cf <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	90                   	nop
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
  8018c9:	83 ec 04             	sub    $0x4,%esp
  8018cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018d2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018d5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	6a 00                	push   $0x0
  8018de:	51                   	push   %ecx
  8018df:	52                   	push   %edx
  8018e0:	ff 75 0c             	pushl  0xc(%ebp)
  8018e3:	50                   	push   %eax
  8018e4:	6a 15                	push   $0x15
  8018e6:	e8 e4 fd ff ff       	call   8016cf <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018f3:	8b 55 10             	mov    0x10(%ebp),%edx
  8018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	52                   	push   %edx
  8018fe:	50                   	push   %eax
  8018ff:	ff 75 08             	pushl  0x8(%ebp)
  801902:	6a 16                	push   $0x16
  801904:	e8 c6 fd ff ff       	call   8016cf <syscall>
  801909:	83 c4 18             	add    $0x18,%esp
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801911:	8b 55 0c             	mov    0xc(%ebp),%edx
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	52                   	push   %edx
  80191e:	50                   	push   %eax
  80191f:	6a 17                	push   $0x17
  801921:	e8 a9 fd ff ff       	call   8016cf <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80192e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	52                   	push   %edx
  80193b:	50                   	push   %eax
  80193c:	6a 18                	push   $0x18
  80193e:	e8 8c fd ff ff       	call   8016cf <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	6a 00                	push   $0x0
  801950:	ff 75 14             	pushl  0x14(%ebp)
  801953:	ff 75 10             	pushl  0x10(%ebp)
  801956:	ff 75 0c             	pushl  0xc(%ebp)
  801959:	50                   	push   %eax
  80195a:	6a 19                	push   $0x19
  80195c:	e8 6e fd ff ff       	call   8016cf <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801969:	8b 45 08             	mov    0x8(%ebp),%eax
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	50                   	push   %eax
  801975:	6a 1a                	push   $0x1a
  801977:	e8 53 fd ff ff       	call   8016cf <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
}
  80197f:	90                   	nop
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	50                   	push   %eax
  801991:	6a 1b                	push   $0x1b
  801993:	e8 37 fd ff ff       	call   8016cf <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 05                	push   $0x5
  8019ac:	e8 1e fd ff ff       	call   8016cf <syscall>
  8019b1:	83 c4 18             	add    $0x18,%esp
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 06                	push   $0x6
  8019c5:	e8 05 fd ff ff       	call   8016cf <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 07                	push   $0x7
  8019de:	e8 ec fc ff ff       	call   8016cf <syscall>
  8019e3:	83 c4 18             	add    $0x18,%esp
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_exit_env>:


void sys_exit_env(void)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 1c                	push   $0x1c
  8019f7:	e8 d3 fc ff ff       	call   8016cf <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	90                   	nop
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	ff 75 10             	pushl  0x10(%ebp)
  801a0c:	ff 75 0c             	pushl  0xc(%ebp)
  801a0f:	ff 75 08             	pushl  0x8(%ebp)
  801a12:	6a 13                	push   $0x13
  801a14:	e8 b6 fc ff ff       	call   8016cf <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
	return ;
  801a1c:	90                   	nop
}
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <sys_rcr2>:
uint32 sys_rcr2()
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 1e                	push   $0x1e
  801a2e:	e8 9c fc ff ff       	call   8016cf <syscall>
  801a33:	83 c4 18             	add    $0x18,%esp
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 04             	sub    $0x4,%esp
  801a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a41:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a44:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	50                   	push   %eax
  801a51:	6a 1f                	push   $0x1f
  801a53:	e8 77 fc ff ff       	call   8016cf <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5b:	90                   	nop
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <rsttst>:
void rsttst()
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 21                	push   $0x21
  801a6d:	e8 5d fc ff ff       	call   8016cf <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
	return ;
  801a75:	90                   	nop
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a78:	55                   	push   %ebp
  801a79:	89 e5                	mov    %esp,%ebp
  801a7b:	83 ec 04             	sub    $0x4,%esp
  801a7e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a81:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a84:	8b 55 18             	mov    0x18(%ebp),%edx
  801a87:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a8b:	52                   	push   %edx
  801a8c:	50                   	push   %eax
  801a8d:	ff 75 10             	pushl  0x10(%ebp)
  801a90:	ff 75 0c             	pushl  0xc(%ebp)
  801a93:	ff 75 08             	pushl  0x8(%ebp)
  801a96:	6a 20                	push   $0x20
  801a98:	e8 32 fc ff ff       	call   8016cf <syscall>
  801a9d:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa0:	90                   	nop
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <chktst>:
void chktst(uint32 n)
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	ff 75 08             	pushl  0x8(%ebp)
  801ab1:	6a 22                	push   $0x22
  801ab3:	e8 17 fc ff ff       	call   8016cf <syscall>
  801ab8:	83 c4 18             	add    $0x18,%esp
	return ;
  801abb:	90                   	nop
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <inctst>:

void inctst()
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 23                	push   $0x23
  801acd:	e8 fd fb ff ff       	call   8016cf <syscall>
  801ad2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad5:	90                   	nop
}
  801ad6:	c9                   	leave  
  801ad7:	c3                   	ret    

00801ad8 <gettst>:
uint32 gettst()
{
  801ad8:	55                   	push   %ebp
  801ad9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 24                	push   $0x24
  801ae7:	e8 e3 fb ff ff       	call   8016cf <syscall>
  801aec:	83 c4 18             	add    $0x18,%esp
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 25                	push   $0x25
  801b00:	e8 ca fb ff ff       	call   8016cf <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
  801b08:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801b0d:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801b17:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1a:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	ff 75 08             	pushl  0x8(%ebp)
  801b2a:	6a 26                	push   $0x26
  801b2c:	e8 9e fb ff ff       	call   8016cf <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
	return ;
  801b34:	90                   	nop
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
  801b3a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b3b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b44:	8b 45 08             	mov    0x8(%ebp),%eax
  801b47:	6a 00                	push   $0x0
  801b49:	53                   	push   %ebx
  801b4a:	51                   	push   %ecx
  801b4b:	52                   	push   %edx
  801b4c:	50                   	push   %eax
  801b4d:	6a 27                	push   $0x27
  801b4f:	e8 7b fb ff ff       	call   8016cf <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
}
  801b57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b5a:	c9                   	leave  
  801b5b:	c3                   	ret    

00801b5c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b5c:	55                   	push   %ebp
  801b5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	52                   	push   %edx
  801b6c:	50                   	push   %eax
  801b6d:	6a 28                	push   $0x28
  801b6f:	e8 5b fb ff ff       	call   8016cf <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b7c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	6a 00                	push   $0x0
  801b87:	51                   	push   %ecx
  801b88:	ff 75 10             	pushl  0x10(%ebp)
  801b8b:	52                   	push   %edx
  801b8c:	50                   	push   %eax
  801b8d:	6a 29                	push   $0x29
  801b8f:	e8 3b fb ff ff       	call   8016cf <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	ff 75 10             	pushl  0x10(%ebp)
  801ba3:	ff 75 0c             	pushl  0xc(%ebp)
  801ba6:	ff 75 08             	pushl  0x8(%ebp)
  801ba9:	6a 12                	push   $0x12
  801bab:	e8 1f fb ff ff       	call   8016cf <syscall>
  801bb0:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb3:	90                   	nop
}
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801bb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	52                   	push   %edx
  801bc6:	50                   	push   %eax
  801bc7:	6a 2a                	push   $0x2a
  801bc9:	e8 01 fb ff ff       	call   8016cf <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
	return;
  801bd1:	90                   	nop
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 2b                	push   $0x2b
  801be3:	e8 e7 fa ff ff       	call   8016cf <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
}
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bf3:	83 ec 04             	sub    $0x4,%esp
  801bf6:	68 48 29 80 00       	push   $0x802948
  801bfb:	68 0a 01 00 00       	push   $0x10a
  801c00:	68 58 29 80 00       	push   $0x802958
  801c05:	e8 12 e9 ff ff       	call   80051c <_panic>

00801c0a <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	ff 75 0c             	pushl  0xc(%ebp)
  801c16:	ff 75 08             	pushl  0x8(%ebp)
  801c19:	6a 33                	push   $0x33
  801c1b:	e8 af fa ff ff       	call   8016cf <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
	return;
  801c23:	90                   	nop
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	ff 75 08             	pushl  0x8(%ebp)
  801c35:	6a 34                	push   $0x34
  801c37:	e8 93 fa ff ff       	call   8016cf <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3f:	90                   	nop
}
  801c40:	c9                   	leave  
  801c41:	c3                   	ret    

00801c42 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c42:	55                   	push   %ebp
  801c43:	89 e5                	mov    %esp,%ebp
  801c45:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c48:	8b 55 08             	mov    0x8(%ebp),%edx
  801c4b:	89 d0                	mov    %edx,%eax
  801c4d:	c1 e0 02             	shl    $0x2,%eax
  801c50:	01 d0                	add    %edx,%eax
  801c52:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c59:	01 d0                	add    %edx,%eax
  801c5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c62:	01 d0                	add    %edx,%eax
  801c64:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c6b:	01 d0                	add    %edx,%eax
  801c6d:	c1 e0 04             	shl    $0x4,%eax
  801c70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c7a:	0f 31                	rdtsc  
  801c7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c7f:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c82:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c85:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c8b:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c8e:	eb 46                	jmp    801cd6 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c90:	0f 31                	rdtsc  
  801c92:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c95:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c98:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c9b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c9e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801ca1:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801ca4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ca7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801caa:	29 c2                	sub    %eax,%edx
  801cac:	89 d0                	mov    %edx,%eax
  801cae:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801cb1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cb7:	89 d1                	mov    %edx,%ecx
  801cb9:	29 c1                	sub    %eax,%ecx
  801cbb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801cbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cc1:	39 c2                	cmp    %eax,%edx
  801cc3:	0f 97 c0             	seta   %al
  801cc6:	0f b6 c0             	movzbl %al,%eax
  801cc9:	29 c1                	sub    %eax,%ecx
  801ccb:	89 c8                	mov    %ecx,%eax
  801ccd:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801cd0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801cd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801cd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cd9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801cdc:	72 b2                	jb     801c90 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801cde:	90                   	nop
  801cdf:	c9                   	leave  
  801ce0:	c3                   	ret    

00801ce1 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
  801ce4:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801ce7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cee:	eb 03                	jmp    801cf3 <busy_wait+0x12>
  801cf0:	ff 45 fc             	incl   -0x4(%ebp)
  801cf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cf6:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cf9:	72 f5                	jb     801cf0 <busy_wait+0xf>
	return i;
  801cfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801cfe:	c9                   	leave  
  801cff:	c3                   	ret    

00801d00 <__udivdi3>:
  801d00:	55                   	push   %ebp
  801d01:	57                   	push   %edi
  801d02:	56                   	push   %esi
  801d03:	53                   	push   %ebx
  801d04:	83 ec 1c             	sub    $0x1c,%esp
  801d07:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d0b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d0f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d13:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d17:	89 ca                	mov    %ecx,%edx
  801d19:	89 f8                	mov    %edi,%eax
  801d1b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d1f:	85 f6                	test   %esi,%esi
  801d21:	75 2d                	jne    801d50 <__udivdi3+0x50>
  801d23:	39 cf                	cmp    %ecx,%edi
  801d25:	77 65                	ja     801d8c <__udivdi3+0x8c>
  801d27:	89 fd                	mov    %edi,%ebp
  801d29:	85 ff                	test   %edi,%edi
  801d2b:	75 0b                	jne    801d38 <__udivdi3+0x38>
  801d2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d32:	31 d2                	xor    %edx,%edx
  801d34:	f7 f7                	div    %edi
  801d36:	89 c5                	mov    %eax,%ebp
  801d38:	31 d2                	xor    %edx,%edx
  801d3a:	89 c8                	mov    %ecx,%eax
  801d3c:	f7 f5                	div    %ebp
  801d3e:	89 c1                	mov    %eax,%ecx
  801d40:	89 d8                	mov    %ebx,%eax
  801d42:	f7 f5                	div    %ebp
  801d44:	89 cf                	mov    %ecx,%edi
  801d46:	89 fa                	mov    %edi,%edx
  801d48:	83 c4 1c             	add    $0x1c,%esp
  801d4b:	5b                   	pop    %ebx
  801d4c:	5e                   	pop    %esi
  801d4d:	5f                   	pop    %edi
  801d4e:	5d                   	pop    %ebp
  801d4f:	c3                   	ret    
  801d50:	39 ce                	cmp    %ecx,%esi
  801d52:	77 28                	ja     801d7c <__udivdi3+0x7c>
  801d54:	0f bd fe             	bsr    %esi,%edi
  801d57:	83 f7 1f             	xor    $0x1f,%edi
  801d5a:	75 40                	jne    801d9c <__udivdi3+0x9c>
  801d5c:	39 ce                	cmp    %ecx,%esi
  801d5e:	72 0a                	jb     801d6a <__udivdi3+0x6a>
  801d60:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d64:	0f 87 9e 00 00 00    	ja     801e08 <__udivdi3+0x108>
  801d6a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d6f:	89 fa                	mov    %edi,%edx
  801d71:	83 c4 1c             	add    $0x1c,%esp
  801d74:	5b                   	pop    %ebx
  801d75:	5e                   	pop    %esi
  801d76:	5f                   	pop    %edi
  801d77:	5d                   	pop    %ebp
  801d78:	c3                   	ret    
  801d79:	8d 76 00             	lea    0x0(%esi),%esi
  801d7c:	31 ff                	xor    %edi,%edi
  801d7e:	31 c0                	xor    %eax,%eax
  801d80:	89 fa                	mov    %edi,%edx
  801d82:	83 c4 1c             	add    $0x1c,%esp
  801d85:	5b                   	pop    %ebx
  801d86:	5e                   	pop    %esi
  801d87:	5f                   	pop    %edi
  801d88:	5d                   	pop    %ebp
  801d89:	c3                   	ret    
  801d8a:	66 90                	xchg   %ax,%ax
  801d8c:	89 d8                	mov    %ebx,%eax
  801d8e:	f7 f7                	div    %edi
  801d90:	31 ff                	xor    %edi,%edi
  801d92:	89 fa                	mov    %edi,%edx
  801d94:	83 c4 1c             	add    $0x1c,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    
  801d9c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801da1:	89 eb                	mov    %ebp,%ebx
  801da3:	29 fb                	sub    %edi,%ebx
  801da5:	89 f9                	mov    %edi,%ecx
  801da7:	d3 e6                	shl    %cl,%esi
  801da9:	89 c5                	mov    %eax,%ebp
  801dab:	88 d9                	mov    %bl,%cl
  801dad:	d3 ed                	shr    %cl,%ebp
  801daf:	89 e9                	mov    %ebp,%ecx
  801db1:	09 f1                	or     %esi,%ecx
  801db3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801db7:	89 f9                	mov    %edi,%ecx
  801db9:	d3 e0                	shl    %cl,%eax
  801dbb:	89 c5                	mov    %eax,%ebp
  801dbd:	89 d6                	mov    %edx,%esi
  801dbf:	88 d9                	mov    %bl,%cl
  801dc1:	d3 ee                	shr    %cl,%esi
  801dc3:	89 f9                	mov    %edi,%ecx
  801dc5:	d3 e2                	shl    %cl,%edx
  801dc7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dcb:	88 d9                	mov    %bl,%cl
  801dcd:	d3 e8                	shr    %cl,%eax
  801dcf:	09 c2                	or     %eax,%edx
  801dd1:	89 d0                	mov    %edx,%eax
  801dd3:	89 f2                	mov    %esi,%edx
  801dd5:	f7 74 24 0c          	divl   0xc(%esp)
  801dd9:	89 d6                	mov    %edx,%esi
  801ddb:	89 c3                	mov    %eax,%ebx
  801ddd:	f7 e5                	mul    %ebp
  801ddf:	39 d6                	cmp    %edx,%esi
  801de1:	72 19                	jb     801dfc <__udivdi3+0xfc>
  801de3:	74 0b                	je     801df0 <__udivdi3+0xf0>
  801de5:	89 d8                	mov    %ebx,%eax
  801de7:	31 ff                	xor    %edi,%edi
  801de9:	e9 58 ff ff ff       	jmp    801d46 <__udivdi3+0x46>
  801dee:	66 90                	xchg   %ax,%ax
  801df0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801df4:	89 f9                	mov    %edi,%ecx
  801df6:	d3 e2                	shl    %cl,%edx
  801df8:	39 c2                	cmp    %eax,%edx
  801dfa:	73 e9                	jae    801de5 <__udivdi3+0xe5>
  801dfc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dff:	31 ff                	xor    %edi,%edi
  801e01:	e9 40 ff ff ff       	jmp    801d46 <__udivdi3+0x46>
  801e06:	66 90                	xchg   %ax,%ax
  801e08:	31 c0                	xor    %eax,%eax
  801e0a:	e9 37 ff ff ff       	jmp    801d46 <__udivdi3+0x46>
  801e0f:	90                   	nop

00801e10 <__umoddi3>:
  801e10:	55                   	push   %ebp
  801e11:	57                   	push   %edi
  801e12:	56                   	push   %esi
  801e13:	53                   	push   %ebx
  801e14:	83 ec 1c             	sub    $0x1c,%esp
  801e17:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e1b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e23:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e27:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e2b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e2f:	89 f3                	mov    %esi,%ebx
  801e31:	89 fa                	mov    %edi,%edx
  801e33:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e37:	89 34 24             	mov    %esi,(%esp)
  801e3a:	85 c0                	test   %eax,%eax
  801e3c:	75 1a                	jne    801e58 <__umoddi3+0x48>
  801e3e:	39 f7                	cmp    %esi,%edi
  801e40:	0f 86 a2 00 00 00    	jbe    801ee8 <__umoddi3+0xd8>
  801e46:	89 c8                	mov    %ecx,%eax
  801e48:	89 f2                	mov    %esi,%edx
  801e4a:	f7 f7                	div    %edi
  801e4c:	89 d0                	mov    %edx,%eax
  801e4e:	31 d2                	xor    %edx,%edx
  801e50:	83 c4 1c             	add    $0x1c,%esp
  801e53:	5b                   	pop    %ebx
  801e54:	5e                   	pop    %esi
  801e55:	5f                   	pop    %edi
  801e56:	5d                   	pop    %ebp
  801e57:	c3                   	ret    
  801e58:	39 f0                	cmp    %esi,%eax
  801e5a:	0f 87 ac 00 00 00    	ja     801f0c <__umoddi3+0xfc>
  801e60:	0f bd e8             	bsr    %eax,%ebp
  801e63:	83 f5 1f             	xor    $0x1f,%ebp
  801e66:	0f 84 ac 00 00 00    	je     801f18 <__umoddi3+0x108>
  801e6c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e71:	29 ef                	sub    %ebp,%edi
  801e73:	89 fe                	mov    %edi,%esi
  801e75:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e79:	89 e9                	mov    %ebp,%ecx
  801e7b:	d3 e0                	shl    %cl,%eax
  801e7d:	89 d7                	mov    %edx,%edi
  801e7f:	89 f1                	mov    %esi,%ecx
  801e81:	d3 ef                	shr    %cl,%edi
  801e83:	09 c7                	or     %eax,%edi
  801e85:	89 e9                	mov    %ebp,%ecx
  801e87:	d3 e2                	shl    %cl,%edx
  801e89:	89 14 24             	mov    %edx,(%esp)
  801e8c:	89 d8                	mov    %ebx,%eax
  801e8e:	d3 e0                	shl    %cl,%eax
  801e90:	89 c2                	mov    %eax,%edx
  801e92:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e96:	d3 e0                	shl    %cl,%eax
  801e98:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e9c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea0:	89 f1                	mov    %esi,%ecx
  801ea2:	d3 e8                	shr    %cl,%eax
  801ea4:	09 d0                	or     %edx,%eax
  801ea6:	d3 eb                	shr    %cl,%ebx
  801ea8:	89 da                	mov    %ebx,%edx
  801eaa:	f7 f7                	div    %edi
  801eac:	89 d3                	mov    %edx,%ebx
  801eae:	f7 24 24             	mull   (%esp)
  801eb1:	89 c6                	mov    %eax,%esi
  801eb3:	89 d1                	mov    %edx,%ecx
  801eb5:	39 d3                	cmp    %edx,%ebx
  801eb7:	0f 82 87 00 00 00    	jb     801f44 <__umoddi3+0x134>
  801ebd:	0f 84 91 00 00 00    	je     801f54 <__umoddi3+0x144>
  801ec3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ec7:	29 f2                	sub    %esi,%edx
  801ec9:	19 cb                	sbb    %ecx,%ebx
  801ecb:	89 d8                	mov    %ebx,%eax
  801ecd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ed1:	d3 e0                	shl    %cl,%eax
  801ed3:	89 e9                	mov    %ebp,%ecx
  801ed5:	d3 ea                	shr    %cl,%edx
  801ed7:	09 d0                	or     %edx,%eax
  801ed9:	89 e9                	mov    %ebp,%ecx
  801edb:	d3 eb                	shr    %cl,%ebx
  801edd:	89 da                	mov    %ebx,%edx
  801edf:	83 c4 1c             	add    $0x1c,%esp
  801ee2:	5b                   	pop    %ebx
  801ee3:	5e                   	pop    %esi
  801ee4:	5f                   	pop    %edi
  801ee5:	5d                   	pop    %ebp
  801ee6:	c3                   	ret    
  801ee7:	90                   	nop
  801ee8:	89 fd                	mov    %edi,%ebp
  801eea:	85 ff                	test   %edi,%edi
  801eec:	75 0b                	jne    801ef9 <__umoddi3+0xe9>
  801eee:	b8 01 00 00 00       	mov    $0x1,%eax
  801ef3:	31 d2                	xor    %edx,%edx
  801ef5:	f7 f7                	div    %edi
  801ef7:	89 c5                	mov    %eax,%ebp
  801ef9:	89 f0                	mov    %esi,%eax
  801efb:	31 d2                	xor    %edx,%edx
  801efd:	f7 f5                	div    %ebp
  801eff:	89 c8                	mov    %ecx,%eax
  801f01:	f7 f5                	div    %ebp
  801f03:	89 d0                	mov    %edx,%eax
  801f05:	e9 44 ff ff ff       	jmp    801e4e <__umoddi3+0x3e>
  801f0a:	66 90                	xchg   %ax,%ax
  801f0c:	89 c8                	mov    %ecx,%eax
  801f0e:	89 f2                	mov    %esi,%edx
  801f10:	83 c4 1c             	add    $0x1c,%esp
  801f13:	5b                   	pop    %ebx
  801f14:	5e                   	pop    %esi
  801f15:	5f                   	pop    %edi
  801f16:	5d                   	pop    %ebp
  801f17:	c3                   	ret    
  801f18:	3b 04 24             	cmp    (%esp),%eax
  801f1b:	72 06                	jb     801f23 <__umoddi3+0x113>
  801f1d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f21:	77 0f                	ja     801f32 <__umoddi3+0x122>
  801f23:	89 f2                	mov    %esi,%edx
  801f25:	29 f9                	sub    %edi,%ecx
  801f27:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f2b:	89 14 24             	mov    %edx,(%esp)
  801f2e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f32:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f36:	8b 14 24             	mov    (%esp),%edx
  801f39:	83 c4 1c             	add    $0x1c,%esp
  801f3c:	5b                   	pop    %ebx
  801f3d:	5e                   	pop    %esi
  801f3e:	5f                   	pop    %edi
  801f3f:	5d                   	pop    %ebp
  801f40:	c3                   	ret    
  801f41:	8d 76 00             	lea    0x0(%esi),%esi
  801f44:	2b 04 24             	sub    (%esp),%eax
  801f47:	19 fa                	sbb    %edi,%edx
  801f49:	89 d1                	mov    %edx,%ecx
  801f4b:	89 c6                	mov    %eax,%esi
  801f4d:	e9 71 ff ff ff       	jmp    801ec3 <__umoddi3+0xb3>
  801f52:	66 90                	xchg   %ax,%ax
  801f54:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f58:	72 ea                	jb     801f44 <__umoddi3+0x134>
  801f5a:	89 d9                	mov    %ebx,%ecx
  801f5c:	e9 62 ff ff ff       	jmp    801ec3 <__umoddi3+0xb3>
