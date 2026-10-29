
obj/user/tst_chan_one_slave:     file format elf32-i386


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
  800031:	e8 b7 01 00 00       	call   8001ed <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
extern volatile bool printStats ;

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
	int envID = sys_getenvid();
  800044:	e8 85 18 00 00       	call   8018ce <sys_getenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Sleep on the channel
	char cmd0[64] = "__Sleep__";
  80004c:	8d 45 98             	lea    -0x68(%ebp),%eax
  80004f:	bb 21 1f 80 00       	mov    $0x801f21,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800061:	8d 55 a2             	lea    -0x5e(%ebp),%edx
  800064:	b9 36 00 00 00       	mov    $0x36,%ecx
  800069:	b0 00                	mov    $0x0,%al
  80006b:	89 d7                	mov    %edx,%edi
  80006d:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd0, 0);
  80006f:	83 ec 08             	sub    $0x8,%esp
  800072:	6a 00                	push   $0x0
  800074:	8d 45 98             	lea    -0x68(%ebp),%eax
  800077:	50                   	push   %eax
  800078:	e8 6a 1a 00 00       	call   801ae7 <sys_utilities>
  80007d:	83 c4 10             	add    $0x10,%esp
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800080:	0f 31                	rdtsc  
  800082:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
  800088:	89 95 cc fe ff ff    	mov    %edx,-0x134(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  80008e:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800094:	8b 95 cc fe ff ff    	mov    -0x134(%ebp),%edx
  80009a:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80009d:	89 55 dc             	mov    %edx,-0x24(%ebp)

	//wait for a while
	env_sleep(RAND(1000, 5000));
  8000a0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000a3:	b9 a0 0f 00 00       	mov    $0xfa0,%ecx
  8000a8:	ba 00 00 00 00       	mov    $0x0,%edx
  8000ad:	f7 f1                	div    %ecx
  8000af:	89 d0                	mov    %edx,%eax
  8000b1:	05 e8 03 00 00       	add    $0x3e8,%eax
  8000b6:	83 ec 0c             	sub    $0xc,%esp
  8000b9:	50                   	push   %eax
  8000ba:	e8 b4 1a 00 00       	call   801b73 <env_sleep>
  8000bf:	83 c4 10             	add    $0x10,%esp

	//Validate the number of blocked processes till now
	int numOfBlockedProcesses = 0;
  8000c2:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
	char cmd1[64] = "__GetChanQueueSize__";
  8000c9:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
  8000cf:	bb 61 1f 80 00       	mov    $0x801f61,%ebx
  8000d4:	ba 15 00 00 00       	mov    $0x15,%edx
  8000d9:	89 c7                	mov    %eax,%edi
  8000db:	89 de                	mov    %ebx,%esi
  8000dd:	89 d1                	mov    %edx,%ecx
  8000df:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000e1:	8d 95 69 ff ff ff    	lea    -0x97(%ebp),%edx
  8000e7:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8000ec:	b0 00                	mov    $0x0,%al
  8000ee:	89 d7                	mov    %edx,%edi
  8000f0:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, (uint32)(&numOfBlockedProcesses));
  8000f2:	8d 45 94             	lea    -0x6c(%ebp),%eax
  8000f5:	83 ec 08             	sub    $0x8,%esp
  8000f8:	50                   	push   %eax
  8000f9:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
  8000ff:	50                   	push   %eax
  800100:	e8 e2 19 00 00       	call   801ae7 <sys_utilities>
  800105:	83 c4 10             	add    $0x10,%esp
	int numOfWakenupProcesses = gettst() ;
  800108:	e8 fc 18 00 00       	call   801a09 <gettst>
  80010d:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int numOfSlaves = 0;
  800110:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
  800117:	00 00 00 
	char cmd2[64] = "__NumOfSlaves@Get";
  80011a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800120:	bb a1 1f 80 00       	mov    $0x801fa1,%ebx
  800125:	ba 12 00 00 00       	mov    $0x12,%edx
  80012a:	89 c7                	mov    %eax,%edi
  80012c:	89 de                	mov    %ebx,%esi
  80012e:	89 d1                	mov    %edx,%ecx
  800130:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800132:	8d 95 22 ff ff ff    	lea    -0xde(%ebp),%edx
  800138:	b9 2e 00 00 00       	mov    $0x2e,%ecx
  80013d:	b0 00                	mov    $0x0,%al
  80013f:	89 d7                	mov    %edx,%edi
  800141:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd2, (uint32)(&numOfSlaves));
  800143:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  800149:	83 ec 08             	sub    $0x8,%esp
  80014c:	50                   	push   %eax
  80014d:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800153:	50                   	push   %eax
  800154:	e8 8e 19 00 00       	call   801ae7 <sys_utilities>
  800159:	83 c4 10             	add    $0x10,%esp

	if (numOfWakenupProcesses + numOfBlockedProcesses != numOfSlaves - 1 /*Except this process since it not indicating wakeup yet*/)
  80015c:	8b 55 94             	mov    -0x6c(%ebp),%edx
  80015f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800162:	01 c2                	add    %eax,%edx
  800164:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  80016a:	48                   	dec    %eax
  80016b:	39 c2                	cmp    %eax,%edx
  80016d:	74 14                	je     800183 <_main+0x14b>
	{
		panic("%~test channels failed! inconsistent number of blocked & waken-up processes.");
  80016f:	83 ec 04             	sub    $0x4,%esp
  800172:	68 a0 1e 80 00       	push   $0x801ea0
  800177:	6a 1d                	push   $0x1d
  800179:	68 ed 1e 80 00       	push   $0x801eed
  80017e:	e8 ca 02 00 00       	call   80044d <_panic>
	}

	//indicates wakenup
	inctst();
  800183:	e8 67 18 00 00       	call   8019ef <inctst>

	//wakeup another one
	char cmd3[64] = "__WakeupOne__";
  800188:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
  80018e:	bb e1 1f 80 00       	mov    $0x801fe1,%ebx
  800193:	ba 0e 00 00 00       	mov    $0xe,%edx
  800198:	89 c7                	mov    %eax,%edi
  80019a:	89 de                	mov    %ebx,%esi
  80019c:	89 d1                	mov    %edx,%ecx
  80019e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001a0:	8d 95 de fe ff ff    	lea    -0x122(%ebp),%edx
  8001a6:	b9 32 00 00 00       	mov    $0x32,%ecx
  8001ab:	b0 00                	mov    $0x0,%al
  8001ad:	89 d7                	mov    %edx,%edi
  8001af:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd3, 0);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	6a 00                	push   $0x0
  8001b6:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
  8001bc:	50                   	push   %eax
  8001bd:	e8 25 19 00 00       	call   801ae7 <sys_utilities>
  8001c2:	83 c4 10             	add    $0x10,%esp

	cprintf_colored(TEXT_light_magenta, ">>> Slave %d is Finished\n", envID);
  8001c5:	83 ec 04             	sub    $0x4,%esp
  8001c8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001cb:	68 07 1f 80 00       	push   $0x801f07
  8001d0:	6a 0d                	push   $0xd
  8001d2:	e8 71 05 00 00       	call   800748 <cprintf_colored>
  8001d7:	83 c4 10             	add    $0x10,%esp
	printStats = 0;
  8001da:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  8001e1:	00 00 00 
	return;
  8001e4:	90                   	nop
}
  8001e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8001e8:	5b                   	pop    %ebx
  8001e9:	5e                   	pop    %esi
  8001ea:	5f                   	pop    %edi
  8001eb:	5d                   	pop    %ebp
  8001ec:	c3                   	ret    

008001ed <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8001ed:	55                   	push   %ebp
  8001ee:	89 e5                	mov    %esp,%ebp
  8001f0:	57                   	push   %edi
  8001f1:	56                   	push   %esi
  8001f2:	53                   	push   %ebx
  8001f3:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8001f9:	e8 e9 16 00 00       	call   8018e7 <sys_getenvindex>
  8001fe:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800201:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800204:	89 d0                	mov    %edx,%eax
  800206:	c1 e0 03             	shl    $0x3,%eax
  800209:	01 d0                	add    %edx,%eax
  80020b:	c1 e0 06             	shl    $0x6,%eax
  80020e:	01 d0                	add    %edx,%eax
  800210:	c1 e0 03             	shl    $0x3,%eax
  800213:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800218:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80021d:	a1 20 30 80 00       	mov    0x803020,%eax
  800222:	8a 40 10             	mov    0x10(%eax),%al
  800225:	84 c0                	test   %al,%al
  800227:	74 0d                	je     800236 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800229:	a1 20 30 80 00       	mov    0x803020,%eax
  80022e:	83 c0 10             	add    $0x10,%eax
  800231:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800236:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80023a:	7e 0a                	jle    800246 <libmain+0x59>
		binaryname = argv[0];
  80023c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023f:	8b 00                	mov    (%eax),%eax
  800241:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800246:	83 ec 08             	sub    $0x8,%esp
  800249:	ff 75 0c             	pushl  0xc(%ebp)
  80024c:	ff 75 08             	pushl  0x8(%ebp)
  80024f:	e8 e4 fd ff ff       	call   800038 <_main>
  800254:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800257:	a1 00 30 80 00       	mov    0x803000,%eax
  80025c:	85 c0                	test   %eax,%eax
  80025e:	0f 84 b7 01 00 00    	je     80041b <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800264:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80026a:	bb 60 21 80 00       	mov    $0x802160,%ebx
  80026f:	ba 0e 00 00 00       	mov    $0xe,%edx
  800274:	89 c7                	mov    %eax,%edi
  800276:	89 de                	mov    %ebx,%esi
  800278:	89 d1                	mov    %edx,%ecx
  80027a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80027c:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800282:	b9 56 00 00 00       	mov    $0x56,%ecx
  800287:	b0 00                	mov    $0x0,%al
  800289:	89 d7                	mov    %edx,%edi
  80028b:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80028d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800294:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800297:	83 ec 08             	sub    $0x8,%esp
  80029a:	50                   	push   %eax
  80029b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002a1:	50                   	push   %eax
  8002a2:	e8 40 18 00 00       	call   801ae7 <sys_utilities>
  8002a7:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8002aa:	e8 c0 13 00 00       	call   80166f <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8002af:	83 ec 0c             	sub    $0xc,%esp
  8002b2:	68 3c 20 80 00       	push   $0x80203c
  8002b7:	e8 5f 04 00 00       	call   80071b <cprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8002bf:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002c2:	85 c0                	test   %eax,%eax
  8002c4:	74 58                	je     80031e <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8002c6:	e8 3a 18 00 00       	call   801b05 <sys_get_optimal_num_faults>
  8002cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8002ce:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8002d4:	bb c4 21 80 00       	mov    $0x8021c4,%ebx
  8002d9:	ba 11 00 00 00       	mov    $0x11,%edx
  8002de:	89 c7                	mov    %eax,%edi
  8002e0:	89 de                	mov    %ebx,%esi
  8002e2:	89 d1                	mov    %edx,%ecx
  8002e4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8002e6:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8002e9:	b9 53 00 00 00       	mov    $0x53,%ecx
  8002ee:	b0 00                	mov    $0x0,%al
  8002f0:	89 d7                	mov    %edx,%edi
  8002f2:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8002f4:	83 ec 08             	sub    $0x8,%esp
  8002f7:	ff 75 dc             	pushl  -0x24(%ebp)
  8002fa:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800300:	50                   	push   %eax
  800301:	e8 e1 17 00 00       	call   801ae7 <sys_utilities>
  800306:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800309:	83 ec 08             	sub    $0x8,%esp
  80030c:	ff 75 dc             	pushl  -0x24(%ebp)
  80030f:	68 64 20 80 00       	push   $0x802064
  800314:	e8 02 04 00 00       	call   80071b <cprintf>
  800319:	83 c4 10             	add    $0x10,%esp
  80031c:	eb 59                	jmp    800377 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80031e:	a1 20 30 80 00       	mov    0x803020,%eax
  800323:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800329:	a1 20 30 80 00       	mov    0x803020,%eax
  80032e:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800334:	83 ec 04             	sub    $0x4,%esp
  800337:	52                   	push   %edx
  800338:	50                   	push   %eax
  800339:	68 88 20 80 00       	push   $0x802088
  80033e:	e8 d8 03 00 00       	call   80071b <cprintf>
  800343:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800346:	a1 20 30 80 00       	mov    0x803020,%eax
  80034b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800351:	a1 20 30 80 00       	mov    0x803020,%eax
  800356:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80035c:	a1 20 30 80 00       	mov    0x803020,%eax
  800361:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800367:	51                   	push   %ecx
  800368:	52                   	push   %edx
  800369:	50                   	push   %eax
  80036a:	68 b0 20 80 00       	push   $0x8020b0
  80036f:	e8 a7 03 00 00       	call   80071b <cprintf>
  800374:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800377:	a1 20 30 80 00       	mov    0x803020,%eax
  80037c:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800382:	83 ec 08             	sub    $0x8,%esp
  800385:	50                   	push   %eax
  800386:	68 08 21 80 00       	push   $0x802108
  80038b:	e8 8b 03 00 00       	call   80071b <cprintf>
  800390:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800393:	83 ec 0c             	sub    $0xc,%esp
  800396:	68 1c 21 80 00       	push   $0x80211c
  80039b:	e8 7b 03 00 00       	call   80071b <cprintf>
  8003a0:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8003a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8003aa:	eb 28                	jmp    8003d4 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003b4:	81 c2 74 04 00 00    	add    $0x474,%edx
  8003ba:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	50                   	push   %eax
  8003c1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003c4:	68 33 21 80 00       	push   $0x802133
  8003c9:	e8 4d 03 00 00       	call   80071b <cprintf>
  8003ce:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8003d1:	ff 45 e4             	incl   -0x1c(%ebp)
  8003d4:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8003d8:	7e d2                	jle    8003ac <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8003da:	83 ec 0c             	sub    $0xc,%esp
  8003dd:	68 42 21 80 00       	push   $0x802142
  8003e2:	e8 34 03 00 00       	call   80071b <cprintf>
  8003e7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8003f5:	83 ec 08             	sub    $0x8,%esp
  8003f8:	50                   	push   %eax
  8003f9:	68 46 21 80 00       	push   $0x802146
  8003fe:	e8 18 03 00 00       	call   80071b <cprintf>
  800403:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800406:	83 ec 0c             	sub    $0xc,%esp
  800409:	68 3c 20 80 00       	push   $0x80203c
  80040e:	e8 08 03 00 00       	call   80071b <cprintf>
  800413:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800416:	e8 6e 12 00 00       	call   801689 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80041b:	e8 1f 00 00 00       	call   80043f <exit>
}
  800420:	90                   	nop
  800421:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800424:	5b                   	pop    %ebx
  800425:	5e                   	pop    %esi
  800426:	5f                   	pop    %edi
  800427:	5d                   	pop    %ebp
  800428:	c3                   	ret    

00800429 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800429:	55                   	push   %ebp
  80042a:	89 e5                	mov    %esp,%ebp
  80042c:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	6a 00                	push   $0x0
  800434:	e8 7a 14 00 00       	call   8018b3 <sys_destroy_env>
  800439:	83 c4 10             	add    $0x10,%esp
}
  80043c:	90                   	nop
  80043d:	c9                   	leave  
  80043e:	c3                   	ret    

0080043f <exit>:

void
exit(void)
{
  80043f:	55                   	push   %ebp
  800440:	89 e5                	mov    %esp,%ebp
  800442:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800445:	e8 cf 14 00 00       	call   801919 <sys_exit_env>
}
  80044a:	90                   	nop
  80044b:	c9                   	leave  
  80044c:	c3                   	ret    

0080044d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80044d:	55                   	push   %ebp
  80044e:	89 e5                	mov    %esp,%ebp
  800450:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800453:	8d 45 10             	lea    0x10(%ebp),%eax
  800456:	83 c0 04             	add    $0x4,%eax
  800459:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80045c:	a1 28 31 80 00       	mov    0x803128,%eax
  800461:	85 c0                	test   %eax,%eax
  800463:	74 16                	je     80047b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800465:	a1 28 31 80 00       	mov    0x803128,%eax
  80046a:	83 ec 08             	sub    $0x8,%esp
  80046d:	50                   	push   %eax
  80046e:	68 28 22 80 00       	push   $0x802228
  800473:	e8 a3 02 00 00       	call   80071b <cprintf>
  800478:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80047b:	a1 04 30 80 00       	mov    0x803004,%eax
  800480:	83 ec 0c             	sub    $0xc,%esp
  800483:	ff 75 0c             	pushl  0xc(%ebp)
  800486:	ff 75 08             	pushl  0x8(%ebp)
  800489:	50                   	push   %eax
  80048a:	68 30 22 80 00       	push   $0x802230
  80048f:	6a 74                	push   $0x74
  800491:	e8 b2 02 00 00       	call   800748 <cprintf_colored>
  800496:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800499:	8b 45 10             	mov    0x10(%ebp),%eax
  80049c:	83 ec 08             	sub    $0x8,%esp
  80049f:	ff 75 f4             	pushl  -0xc(%ebp)
  8004a2:	50                   	push   %eax
  8004a3:	e8 04 02 00 00       	call   8006ac <vcprintf>
  8004a8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004ab:	83 ec 08             	sub    $0x8,%esp
  8004ae:	6a 00                	push   $0x0
  8004b0:	68 58 22 80 00       	push   $0x802258
  8004b5:	e8 f2 01 00 00       	call   8006ac <vcprintf>
  8004ba:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004bd:	e8 7d ff ff ff       	call   80043f <exit>

	// should not return here
	while (1) ;
  8004c2:	eb fe                	jmp    8004c2 <_panic+0x75>

008004c4 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8004d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d8:	39 c2                	cmp    %eax,%edx
  8004da:	74 14                	je     8004f0 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004dc:	83 ec 04             	sub    $0x4,%esp
  8004df:	68 5c 22 80 00       	push   $0x80225c
  8004e4:	6a 26                	push   $0x26
  8004e6:	68 a8 22 80 00       	push   $0x8022a8
  8004eb:	e8 5d ff ff ff       	call   80044d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004fe:	e9 c5 00 00 00       	jmp    8005c8 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800503:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 d0                	add    %edx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	85 c0                	test   %eax,%eax
  800516:	75 08                	jne    800520 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800518:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80051b:	e9 a5 00 00 00       	jmp    8005c5 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800520:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800527:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80052e:	eb 69                	jmp    800599 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800530:	a1 20 30 80 00       	mov    0x803020,%eax
  800535:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80053b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	01 c0                	add    %eax,%eax
  800542:	01 d0                	add    %edx,%eax
  800544:	c1 e0 03             	shl    $0x3,%eax
  800547:	01 c8                	add    %ecx,%eax
  800549:	8a 40 04             	mov    0x4(%eax),%al
  80054c:	84 c0                	test   %al,%al
  80054e:	75 46                	jne    800596 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800550:	a1 20 30 80 00       	mov    0x803020,%eax
  800555:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80055b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80055e:	89 d0                	mov    %edx,%eax
  800560:	01 c0                	add    %eax,%eax
  800562:	01 d0                	add    %edx,%eax
  800564:	c1 e0 03             	shl    $0x3,%eax
  800567:	01 c8                	add    %ecx,%eax
  800569:	8b 00                	mov    (%eax),%eax
  80056b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80056e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800571:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800576:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800578:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80057b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	01 c8                	add    %ecx,%eax
  800587:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800589:	39 c2                	cmp    %eax,%edx
  80058b:	75 09                	jne    800596 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80058d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800594:	eb 15                	jmp    8005ab <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800596:	ff 45 e8             	incl   -0x18(%ebp)
  800599:	a1 20 30 80 00       	mov    0x803020,%eax
  80059e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a7:	39 c2                	cmp    %eax,%edx
  8005a9:	77 85                	ja     800530 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005af:	75 14                	jne    8005c5 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8005b1:	83 ec 04             	sub    $0x4,%esp
  8005b4:	68 b4 22 80 00       	push   $0x8022b4
  8005b9:	6a 3a                	push   $0x3a
  8005bb:	68 a8 22 80 00       	push   $0x8022a8
  8005c0:	e8 88 fe ff ff       	call   80044d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005c5:	ff 45 f0             	incl   -0x10(%ebp)
  8005c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005ce:	0f 8c 2f ff ff ff    	jl     800503 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005d4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005db:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005e2:	eb 26                	jmp    80060a <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005ef:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005f2:	89 d0                	mov    %edx,%eax
  8005f4:	01 c0                	add    %eax,%eax
  8005f6:	01 d0                	add    %edx,%eax
  8005f8:	c1 e0 03             	shl    $0x3,%eax
  8005fb:	01 c8                	add    %ecx,%eax
  8005fd:	8a 40 04             	mov    0x4(%eax),%al
  800600:	3c 01                	cmp    $0x1,%al
  800602:	75 03                	jne    800607 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800604:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800607:	ff 45 e0             	incl   -0x20(%ebp)
  80060a:	a1 20 30 80 00       	mov    0x803020,%eax
  80060f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800615:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800618:	39 c2                	cmp    %eax,%edx
  80061a:	77 c8                	ja     8005e4 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80061c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80061f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800622:	74 14                	je     800638 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800624:	83 ec 04             	sub    $0x4,%esp
  800627:	68 08 23 80 00       	push   $0x802308
  80062c:	6a 44                	push   $0x44
  80062e:	68 a8 22 80 00       	push   $0x8022a8
  800633:	e8 15 fe ff ff       	call   80044d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800638:	90                   	nop
  800639:	c9                   	leave  
  80063a:	c3                   	ret    

0080063b <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80063b:	55                   	push   %ebp
  80063c:	89 e5                	mov    %esp,%ebp
  80063e:	53                   	push   %ebx
  80063f:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800642:	8b 45 0c             	mov    0xc(%ebp),%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	8d 48 01             	lea    0x1(%eax),%ecx
  80064a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064d:	89 0a                	mov    %ecx,(%edx)
  80064f:	8b 55 08             	mov    0x8(%ebp),%edx
  800652:	88 d1                	mov    %dl,%cl
  800654:	8b 55 0c             	mov    0xc(%ebp),%edx
  800657:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80065b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	3d ff 00 00 00       	cmp    $0xff,%eax
  800665:	75 30                	jne    800697 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800667:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80066d:	a0 40 30 80 00       	mov    0x803040,%al
  800672:	0f b6 c0             	movzbl %al,%eax
  800675:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800678:	8b 09                	mov    (%ecx),%ecx
  80067a:	89 cb                	mov    %ecx,%ebx
  80067c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80067f:	83 c1 08             	add    $0x8,%ecx
  800682:	52                   	push   %edx
  800683:	50                   	push   %eax
  800684:	53                   	push   %ebx
  800685:	51                   	push   %ecx
  800686:	e8 a0 0f 00 00       	call   80162b <sys_cputs>
  80068b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80068e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800691:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800697:	8b 45 0c             	mov    0xc(%ebp),%eax
  80069a:	8b 40 04             	mov    0x4(%eax),%eax
  80069d:	8d 50 01             	lea    0x1(%eax),%edx
  8006a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006a6:	90                   	nop
  8006a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006aa:	c9                   	leave  
  8006ab:	c3                   	ret    

008006ac <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006ac:	55                   	push   %ebp
  8006ad:	89 e5                	mov    %esp,%ebp
  8006af:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006b5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006bc:	00 00 00 
	b.cnt = 0;
  8006bf:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006c6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006c9:	ff 75 0c             	pushl  0xc(%ebp)
  8006cc:	ff 75 08             	pushl  0x8(%ebp)
  8006cf:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006d5:	50                   	push   %eax
  8006d6:	68 3b 06 80 00       	push   $0x80063b
  8006db:	e8 5a 02 00 00       	call   80093a <vprintfmt>
  8006e0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8006e3:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8006e9:	a0 40 30 80 00       	mov    0x803040,%al
  8006ee:	0f b6 c0             	movzbl %al,%eax
  8006f1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8006f7:	52                   	push   %edx
  8006f8:	50                   	push   %eax
  8006f9:	51                   	push   %ecx
  8006fa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800700:	83 c0 08             	add    $0x8,%eax
  800703:	50                   	push   %eax
  800704:	e8 22 0f 00 00       	call   80162b <sys_cputs>
  800709:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80070c:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800713:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800719:	c9                   	leave  
  80071a:	c3                   	ret    

0080071b <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800721:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800728:	8d 45 0c             	lea    0xc(%ebp),%eax
  80072b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 f4             	pushl  -0xc(%ebp)
  800737:	50                   	push   %eax
  800738:	e8 6f ff ff ff       	call   8006ac <vcprintf>
  80073d:	83 c4 10             	add    $0x10,%esp
  800740:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800743:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800746:	c9                   	leave  
  800747:	c3                   	ret    

00800748 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800748:	55                   	push   %ebp
  800749:	89 e5                	mov    %esp,%ebp
  80074b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80074e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	c1 e0 08             	shl    $0x8,%eax
  80075b:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800760:	8d 45 0c             	lea    0xc(%ebp),%eax
  800763:	83 c0 04             	add    $0x4,%eax
  800766:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 f4             	pushl  -0xc(%ebp)
  800772:	50                   	push   %eax
  800773:	e8 34 ff ff ff       	call   8006ac <vcprintf>
  800778:	83 c4 10             	add    $0x10,%esp
  80077b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80077e:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800785:	07 00 00 

	return cnt;
  800788:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80078b:	c9                   	leave  
  80078c:	c3                   	ret    

0080078d <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80078d:	55                   	push   %ebp
  80078e:	89 e5                	mov    %esp,%ebp
  800790:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800793:	e8 d7 0e 00 00       	call   80166f <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800798:	8d 45 0c             	lea    0xc(%ebp),%eax
  80079b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a7:	50                   	push   %eax
  8007a8:	e8 ff fe ff ff       	call   8006ac <vcprintf>
  8007ad:	83 c4 10             	add    $0x10,%esp
  8007b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8007b3:	e8 d1 0e 00 00       	call   801689 <sys_unlock_cons>
	return cnt;
  8007b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007bb:	c9                   	leave  
  8007bc:	c3                   	ret    

008007bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007bd:	55                   	push   %ebp
  8007be:	89 e5                	mov    %esp,%ebp
  8007c0:	53                   	push   %ebx
  8007c1:	83 ec 14             	sub    $0x14,%esp
  8007c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007db:	77 55                	ja     800832 <printnum+0x75>
  8007dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e0:	72 05                	jb     8007e7 <printnum+0x2a>
  8007e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007e5:	77 4b                	ja     800832 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f5:	52                   	push   %edx
  8007f6:	50                   	push   %eax
  8007f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fd:	e8 32 14 00 00       	call   801c34 <__udivdi3>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	83 ec 04             	sub    $0x4,%esp
  800808:	ff 75 20             	pushl  0x20(%ebp)
  80080b:	53                   	push   %ebx
  80080c:	ff 75 18             	pushl  0x18(%ebp)
  80080f:	52                   	push   %edx
  800810:	50                   	push   %eax
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	ff 75 08             	pushl  0x8(%ebp)
  800817:	e8 a1 ff ff ff       	call   8007bd <printnum>
  80081c:	83 c4 20             	add    $0x20,%esp
  80081f:	eb 1a                	jmp    80083b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	ff 75 20             	pushl  0x20(%ebp)
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800832:	ff 4d 1c             	decl   0x1c(%ebp)
  800835:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800839:	7f e6                	jg     800821 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80083b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80083e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800843:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800846:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800849:	53                   	push   %ebx
  80084a:	51                   	push   %ecx
  80084b:	52                   	push   %edx
  80084c:	50                   	push   %eax
  80084d:	e8 f2 14 00 00       	call   801d44 <__umoddi3>
  800852:	83 c4 10             	add    $0x10,%esp
  800855:	05 74 25 80 00       	add    $0x802574,%eax
  80085a:	8a 00                	mov    (%eax),%al
  80085c:	0f be c0             	movsbl %al,%eax
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 0c             	pushl  0xc(%ebp)
  800865:	50                   	push   %eax
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	ff d0                	call   *%eax
  80086b:	83 c4 10             	add    $0x10,%esp
}
  80086e:	90                   	nop
  80086f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800872:	c9                   	leave  
  800873:	c3                   	ret    

00800874 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800874:	55                   	push   %ebp
  800875:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800877:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80087b:	7e 1c                	jle    800899 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 50 08             	lea    0x8(%eax),%edx
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	89 10                	mov    %edx,(%eax)
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	8b 00                	mov    (%eax),%eax
  80088f:	83 e8 08             	sub    $0x8,%eax
  800892:	8b 50 04             	mov    0x4(%eax),%edx
  800895:	8b 00                	mov    (%eax),%eax
  800897:	eb 40                	jmp    8008d9 <getuint+0x65>
	else if (lflag)
  800899:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80089d:	74 1e                	je     8008bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80089f:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a2:	8b 00                	mov    (%eax),%eax
  8008a4:	8d 50 04             	lea    0x4(%eax),%edx
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	89 10                	mov    %edx,(%eax)
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	8b 00                	mov    (%eax),%eax
  8008b1:	83 e8 04             	sub    $0x4,%eax
  8008b4:	8b 00                	mov    (%eax),%eax
  8008b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8008bb:	eb 1c                	jmp    8008d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	8b 00                	mov    (%eax),%eax
  8008c2:	8d 50 04             	lea    0x4(%eax),%edx
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	89 10                	mov    %edx,(%eax)
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	83 e8 04             	sub    $0x4,%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008d9:	5d                   	pop    %ebp
  8008da:	c3                   	ret    

008008db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e2:	7e 1c                	jle    800900 <getint+0x25>
		return va_arg(*ap, long long);
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	8d 50 08             	lea    0x8(%eax),%edx
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	89 10                	mov    %edx,(%eax)
  8008f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	83 e8 08             	sub    $0x8,%eax
  8008f9:	8b 50 04             	mov    0x4(%eax),%edx
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	eb 38                	jmp    800938 <getint+0x5d>
	else if (lflag)
  800900:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800904:	74 1a                	je     800920 <getint+0x45>
		return va_arg(*ap, long);
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	8b 00                	mov    (%eax),%eax
  80090b:	8d 50 04             	lea    0x4(%eax),%edx
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	89 10                	mov    %edx,(%eax)
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	83 e8 04             	sub    $0x4,%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	99                   	cltd   
  80091e:	eb 18                	jmp    800938 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	8b 00                	mov    (%eax),%eax
  800925:	8d 50 04             	lea    0x4(%eax),%edx
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	89 10                	mov    %edx,(%eax)
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	83 e8 04             	sub    $0x4,%eax
  800935:	8b 00                	mov    (%eax),%eax
  800937:	99                   	cltd   
}
  800938:	5d                   	pop    %ebp
  800939:	c3                   	ret    

0080093a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80093a:	55                   	push   %ebp
  80093b:	89 e5                	mov    %esp,%ebp
  80093d:	56                   	push   %esi
  80093e:	53                   	push   %ebx
  80093f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800942:	eb 17                	jmp    80095b <vprintfmt+0x21>
			if (ch == '\0')
  800944:	85 db                	test   %ebx,%ebx
  800946:	0f 84 c1 03 00 00    	je     800d0d <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	53                   	push   %ebx
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	ff d0                	call   *%eax
  800958:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80095b:	8b 45 10             	mov    0x10(%ebp),%eax
  80095e:	8d 50 01             	lea    0x1(%eax),%edx
  800961:	89 55 10             	mov    %edx,0x10(%ebp)
  800964:	8a 00                	mov    (%eax),%al
  800966:	0f b6 d8             	movzbl %al,%ebx
  800969:	83 fb 25             	cmp    $0x25,%ebx
  80096c:	75 d6                	jne    800944 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80096e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800972:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800979:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800980:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800987:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80098e:	8b 45 10             	mov    0x10(%ebp),%eax
  800991:	8d 50 01             	lea    0x1(%eax),%edx
  800994:	89 55 10             	mov    %edx,0x10(%ebp)
  800997:	8a 00                	mov    (%eax),%al
  800999:	0f b6 d8             	movzbl %al,%ebx
  80099c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80099f:	83 f8 5b             	cmp    $0x5b,%eax
  8009a2:	0f 87 3d 03 00 00    	ja     800ce5 <vprintfmt+0x3ab>
  8009a8:	8b 04 85 98 25 80 00 	mov    0x802598(,%eax,4),%eax
  8009af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009b5:	eb d7                	jmp    80098e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009bb:	eb d1                	jmp    80098e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c7:	89 d0                	mov    %edx,%eax
  8009c9:	c1 e0 02             	shl    $0x2,%eax
  8009cc:	01 d0                	add    %edx,%eax
  8009ce:	01 c0                	add    %eax,%eax
  8009d0:	01 d8                	add    %ebx,%eax
  8009d2:	83 e8 30             	sub    $0x30,%eax
  8009d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009db:	8a 00                	mov    (%eax),%al
  8009dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8009e3:	7e 3e                	jle    800a23 <vprintfmt+0xe9>
  8009e5:	83 fb 39             	cmp    $0x39,%ebx
  8009e8:	7f 39                	jg     800a23 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009ed:	eb d5                	jmp    8009c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f2:	83 c0 04             	add    $0x4,%eax
  8009f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fb:	83 e8 04             	sub    $0x4,%eax
  8009fe:	8b 00                	mov    (%eax),%eax
  800a00:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a03:	eb 1f                	jmp    800a24 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a09:	79 83                	jns    80098e <vprintfmt+0x54>
				width = 0;
  800a0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a12:	e9 77 ff ff ff       	jmp    80098e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a17:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a1e:	e9 6b ff ff ff       	jmp    80098e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a23:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a28:	0f 89 60 ff ff ff    	jns    80098e <vprintfmt+0x54>
				width = precision, precision = -1;
  800a2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a34:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a3b:	e9 4e ff ff ff       	jmp    80098e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a40:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a43:	e9 46 ff ff ff       	jmp    80098e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a48:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4b:	83 c0 04             	add    $0x4,%eax
  800a4e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a51:	8b 45 14             	mov    0x14(%ebp),%eax
  800a54:	83 e8 04             	sub    $0x4,%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	50                   	push   %eax
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
			break;
  800a68:	e9 9b 02 00 00       	jmp    800d08 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a70:	83 c0 04             	add    $0x4,%eax
  800a73:	89 45 14             	mov    %eax,0x14(%ebp)
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 e8 04             	sub    $0x4,%eax
  800a7c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a7e:	85 db                	test   %ebx,%ebx
  800a80:	79 02                	jns    800a84 <vprintfmt+0x14a>
				err = -err;
  800a82:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a84:	83 fb 64             	cmp    $0x64,%ebx
  800a87:	7f 0b                	jg     800a94 <vprintfmt+0x15a>
  800a89:	8b 34 9d e0 23 80 00 	mov    0x8023e0(,%ebx,4),%esi
  800a90:	85 f6                	test   %esi,%esi
  800a92:	75 19                	jne    800aad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a94:	53                   	push   %ebx
  800a95:	68 85 25 80 00       	push   $0x802585
  800a9a:	ff 75 0c             	pushl  0xc(%ebp)
  800a9d:	ff 75 08             	pushl  0x8(%ebp)
  800aa0:	e8 70 02 00 00       	call   800d15 <printfmt>
  800aa5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800aa8:	e9 5b 02 00 00       	jmp    800d08 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800aad:	56                   	push   %esi
  800aae:	68 8e 25 80 00       	push   $0x80258e
  800ab3:	ff 75 0c             	pushl  0xc(%ebp)
  800ab6:	ff 75 08             	pushl  0x8(%ebp)
  800ab9:	e8 57 02 00 00       	call   800d15 <printfmt>
  800abe:	83 c4 10             	add    $0x10,%esp
			break;
  800ac1:	e9 42 02 00 00       	jmp    800d08 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ac6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac9:	83 c0 04             	add    $0x4,%eax
  800acc:	89 45 14             	mov    %eax,0x14(%ebp)
  800acf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad2:	83 e8 04             	sub    $0x4,%eax
  800ad5:	8b 30                	mov    (%eax),%esi
  800ad7:	85 f6                	test   %esi,%esi
  800ad9:	75 05                	jne    800ae0 <vprintfmt+0x1a6>
				p = "(null)";
  800adb:	be 91 25 80 00       	mov    $0x802591,%esi
			if (width > 0 && padc != '-')
  800ae0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ae4:	7e 6d                	jle    800b53 <vprintfmt+0x219>
  800ae6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800aea:	74 67                	je     800b53 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	50                   	push   %eax
  800af3:	56                   	push   %esi
  800af4:	e8 1e 03 00 00       	call   800e17 <strnlen>
  800af9:	83 c4 10             	add    $0x10,%esp
  800afc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800aff:	eb 16                	jmp    800b17 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b01:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	50                   	push   %eax
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	ff d0                	call   *%eax
  800b11:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b14:	ff 4d e4             	decl   -0x1c(%ebp)
  800b17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b1b:	7f e4                	jg     800b01 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b1d:	eb 34                	jmp    800b53 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b1f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b23:	74 1c                	je     800b41 <vprintfmt+0x207>
  800b25:	83 fb 1f             	cmp    $0x1f,%ebx
  800b28:	7e 05                	jle    800b2f <vprintfmt+0x1f5>
  800b2a:	83 fb 7e             	cmp    $0x7e,%ebx
  800b2d:	7e 12                	jle    800b41 <vprintfmt+0x207>
					putch('?', putdat);
  800b2f:	83 ec 08             	sub    $0x8,%esp
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	6a 3f                	push   $0x3f
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
  800b3f:	eb 0f                	jmp    800b50 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	53                   	push   %ebx
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b50:	ff 4d e4             	decl   -0x1c(%ebp)
  800b53:	89 f0                	mov    %esi,%eax
  800b55:	8d 70 01             	lea    0x1(%eax),%esi
  800b58:	8a 00                	mov    (%eax),%al
  800b5a:	0f be d8             	movsbl %al,%ebx
  800b5d:	85 db                	test   %ebx,%ebx
  800b5f:	74 24                	je     800b85 <vprintfmt+0x24b>
  800b61:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b65:	78 b8                	js     800b1f <vprintfmt+0x1e5>
  800b67:	ff 4d e0             	decl   -0x20(%ebp)
  800b6a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6e:	79 af                	jns    800b1f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b70:	eb 13                	jmp    800b85 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b72:	83 ec 08             	sub    $0x8,%esp
  800b75:	ff 75 0c             	pushl  0xc(%ebp)
  800b78:	6a 20                	push   $0x20
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	ff d0                	call   *%eax
  800b7f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b82:	ff 4d e4             	decl   -0x1c(%ebp)
  800b85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b89:	7f e7                	jg     800b72 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b8b:	e9 78 01 00 00       	jmp    800d08 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b90:	83 ec 08             	sub    $0x8,%esp
  800b93:	ff 75 e8             	pushl  -0x18(%ebp)
  800b96:	8d 45 14             	lea    0x14(%ebp),%eax
  800b99:	50                   	push   %eax
  800b9a:	e8 3c fd ff ff       	call   8008db <getint>
  800b9f:	83 c4 10             	add    $0x10,%esp
  800ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bae:	85 d2                	test   %edx,%edx
  800bb0:	79 23                	jns    800bd5 <vprintfmt+0x29b>
				putch('-', putdat);
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	6a 2d                	push   $0x2d
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	ff d0                	call   *%eax
  800bbf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc8:	f7 d8                	neg    %eax
  800bca:	83 d2 00             	adc    $0x0,%edx
  800bcd:	f7 da                	neg    %edx
  800bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bd5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bdc:	e9 bc 00 00 00       	jmp    800c9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 e8             	pushl  -0x18(%ebp)
  800be7:	8d 45 14             	lea    0x14(%ebp),%eax
  800bea:	50                   	push   %eax
  800beb:	e8 84 fc ff ff       	call   800874 <getuint>
  800bf0:	83 c4 10             	add    $0x10,%esp
  800bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bf9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c00:	e9 98 00 00 00       	jmp    800c9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c05:	83 ec 08             	sub    $0x8,%esp
  800c08:	ff 75 0c             	pushl  0xc(%ebp)
  800c0b:	6a 58                	push   $0x58
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	ff d0                	call   *%eax
  800c12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c15:	83 ec 08             	sub    $0x8,%esp
  800c18:	ff 75 0c             	pushl  0xc(%ebp)
  800c1b:	6a 58                	push   $0x58
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	ff d0                	call   *%eax
  800c22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c25:	83 ec 08             	sub    $0x8,%esp
  800c28:	ff 75 0c             	pushl  0xc(%ebp)
  800c2b:	6a 58                	push   $0x58
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	ff d0                	call   *%eax
  800c32:	83 c4 10             	add    $0x10,%esp
			break;
  800c35:	e9 ce 00 00 00       	jmp    800d08 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	6a 30                	push   $0x30
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	ff d0                	call   *%eax
  800c47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	6a 78                	push   $0x78
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5d:	83 c0 04             	add    $0x4,%eax
  800c60:	89 45 14             	mov    %eax,0x14(%ebp)
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	83 e8 04             	sub    $0x4,%eax
  800c69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c7c:	eb 1f                	jmp    800c9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c7e:	83 ec 08             	sub    $0x8,%esp
  800c81:	ff 75 e8             	pushl  -0x18(%ebp)
  800c84:	8d 45 14             	lea    0x14(%ebp),%eax
  800c87:	50                   	push   %eax
  800c88:	e8 e7 fb ff ff       	call   800874 <getuint>
  800c8d:	83 c4 10             	add    $0x10,%esp
  800c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ca1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ca4:	83 ec 04             	sub    $0x4,%esp
  800ca7:	52                   	push   %edx
  800ca8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cab:	50                   	push   %eax
  800cac:	ff 75 f4             	pushl  -0xc(%ebp)
  800caf:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb2:	ff 75 0c             	pushl  0xc(%ebp)
  800cb5:	ff 75 08             	pushl  0x8(%ebp)
  800cb8:	e8 00 fb ff ff       	call   8007bd <printnum>
  800cbd:	83 c4 20             	add    $0x20,%esp
			break;
  800cc0:	eb 46                	jmp    800d08 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cc2:	83 ec 08             	sub    $0x8,%esp
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	53                   	push   %ebx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			break;
  800cd1:	eb 35                	jmp    800d08 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800cd3:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800cda:	eb 2c                	jmp    800d08 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800cdc:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800ce3:	eb 23                	jmp    800d08 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ce5:	83 ec 08             	sub    $0x8,%esp
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	6a 25                	push   $0x25
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	ff d0                	call   *%eax
  800cf2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cf5:	ff 4d 10             	decl   0x10(%ebp)
  800cf8:	eb 03                	jmp    800cfd <vprintfmt+0x3c3>
  800cfa:	ff 4d 10             	decl   0x10(%ebp)
  800cfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800d00:	48                   	dec    %eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	3c 25                	cmp    $0x25,%al
  800d05:	75 f3                	jne    800cfa <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800d07:	90                   	nop
		}
	}
  800d08:	e9 35 fc ff ff       	jmp    800942 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d0d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d11:	5b                   	pop    %ebx
  800d12:	5e                   	pop    %esi
  800d13:	5d                   	pop    %ebp
  800d14:	c3                   	ret    

00800d15 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d15:	55                   	push   %ebp
  800d16:	89 e5                	mov    %esp,%ebp
  800d18:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d1b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d1e:	83 c0 04             	add    $0x4,%eax
  800d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d24:	8b 45 10             	mov    0x10(%ebp),%eax
  800d27:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2a:	50                   	push   %eax
  800d2b:	ff 75 0c             	pushl  0xc(%ebp)
  800d2e:	ff 75 08             	pushl  0x8(%ebp)
  800d31:	e8 04 fc ff ff       	call   80093a <vprintfmt>
  800d36:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d39:	90                   	nop
  800d3a:	c9                   	leave  
  800d3b:	c3                   	ret    

00800d3c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d3c:	55                   	push   %ebp
  800d3d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d42:	8b 40 08             	mov    0x8(%eax),%eax
  800d45:	8d 50 01             	lea    0x1(%eax),%edx
  800d48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d51:	8b 10                	mov    (%eax),%edx
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	8b 40 04             	mov    0x4(%eax),%eax
  800d59:	39 c2                	cmp    %eax,%edx
  800d5b:	73 12                	jae    800d6f <sprintputch+0x33>
		*b->buf++ = ch;
  800d5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d60:	8b 00                	mov    (%eax),%eax
  800d62:	8d 48 01             	lea    0x1(%eax),%ecx
  800d65:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d68:	89 0a                	mov    %ecx,(%edx)
  800d6a:	8b 55 08             	mov    0x8(%ebp),%edx
  800d6d:	88 10                	mov    %dl,(%eax)
}
  800d6f:	90                   	nop
  800d70:	5d                   	pop    %ebp
  800d71:	c3                   	ret    

00800d72 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d72:	55                   	push   %ebp
  800d73:	89 e5                	mov    %esp,%ebp
  800d75:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	01 d0                	add    %edx,%eax
  800d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d93:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d97:	74 06                	je     800d9f <vsnprintf+0x2d>
  800d99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9d:	7f 07                	jg     800da6 <vsnprintf+0x34>
		return -E_INVAL;
  800d9f:	b8 03 00 00 00       	mov    $0x3,%eax
  800da4:	eb 20                	jmp    800dc6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800da6:	ff 75 14             	pushl  0x14(%ebp)
  800da9:	ff 75 10             	pushl  0x10(%ebp)
  800dac:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800daf:	50                   	push   %eax
  800db0:	68 3c 0d 80 00       	push   $0x800d3c
  800db5:	e8 80 fb ff ff       	call   80093a <vprintfmt>
  800dba:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dc0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dc6:	c9                   	leave  
  800dc7:	c3                   	ret    

00800dc8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dc8:	55                   	push   %ebp
  800dc9:	89 e5                	mov    %esp,%ebp
  800dcb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dce:	8d 45 10             	lea    0x10(%ebp),%eax
  800dd1:	83 c0 04             	add    $0x4,%eax
  800dd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dda:	ff 75 f4             	pushl  -0xc(%ebp)
  800ddd:	50                   	push   %eax
  800dde:	ff 75 0c             	pushl  0xc(%ebp)
  800de1:	ff 75 08             	pushl  0x8(%ebp)
  800de4:	e8 89 ff ff ff       	call   800d72 <vsnprintf>
  800de9:	83 c4 10             	add    $0x10,%esp
  800dec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800def:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800df2:	c9                   	leave  
  800df3:	c3                   	ret    

00800df4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800df4:	55                   	push   %ebp
  800df5:	89 e5                	mov    %esp,%ebp
  800df7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e01:	eb 06                	jmp    800e09 <strlen+0x15>
		n++;
  800e03:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e06:	ff 45 08             	incl   0x8(%ebp)
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	84 c0                	test   %al,%al
  800e10:	75 f1                	jne    800e03 <strlen+0xf>
		n++;
	return n;
  800e12:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e15:	c9                   	leave  
  800e16:	c3                   	ret    

00800e17 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e17:	55                   	push   %ebp
  800e18:	89 e5                	mov    %esp,%ebp
  800e1a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e1d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e24:	eb 09                	jmp    800e2f <strnlen+0x18>
		n++;
  800e26:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e29:	ff 45 08             	incl   0x8(%ebp)
  800e2c:	ff 4d 0c             	decl   0xc(%ebp)
  800e2f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e33:	74 09                	je     800e3e <strnlen+0x27>
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	84 c0                	test   %al,%al
  800e3c:	75 e8                	jne    800e26 <strnlen+0xf>
		n++;
	return n;
  800e3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e41:	c9                   	leave  
  800e42:	c3                   	ret    

00800e43 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e43:	55                   	push   %ebp
  800e44:	89 e5                	mov    %esp,%ebp
  800e46:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e4f:	90                   	nop
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8d 50 01             	lea    0x1(%eax),%edx
  800e56:	89 55 08             	mov    %edx,0x8(%ebp)
  800e59:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e5f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e62:	8a 12                	mov    (%edx),%dl
  800e64:	88 10                	mov    %dl,(%eax)
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	84 c0                	test   %al,%al
  800e6a:	75 e4                	jne    800e50 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e6f:	c9                   	leave  
  800e70:	c3                   	ret    

00800e71 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e71:	55                   	push   %ebp
  800e72:	89 e5                	mov    %esp,%ebp
  800e74:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e84:	eb 1f                	jmp    800ea5 <strncpy+0x34>
		*dst++ = *src;
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	8d 50 01             	lea    0x1(%eax),%edx
  800e8c:	89 55 08             	mov    %edx,0x8(%ebp)
  800e8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e92:	8a 12                	mov    (%edx),%dl
  800e94:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	84 c0                	test   %al,%al
  800e9d:	74 03                	je     800ea2 <strncpy+0x31>
			src++;
  800e9f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ea2:	ff 45 fc             	incl   -0x4(%ebp)
  800ea5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800eab:	72 d9                	jb     800e86 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ead:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ebe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec2:	74 30                	je     800ef4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ec4:	eb 16                	jmp    800edc <strlcpy+0x2a>
			*dst++ = *src++;
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	8d 50 01             	lea    0x1(%eax),%edx
  800ecc:	89 55 08             	mov    %edx,0x8(%ebp)
  800ecf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ed5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ed8:	8a 12                	mov    (%edx),%dl
  800eda:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800edc:	ff 4d 10             	decl   0x10(%ebp)
  800edf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee3:	74 09                	je     800eee <strlcpy+0x3c>
  800ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	84 c0                	test   %al,%al
  800eec:	75 d8                	jne    800ec6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ef4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ef7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efa:	29 c2                	sub    %eax,%edx
  800efc:	89 d0                	mov    %edx,%eax
}
  800efe:	c9                   	leave  
  800eff:	c3                   	ret    

00800f00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f00:	55                   	push   %ebp
  800f01:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f03:	eb 06                	jmp    800f0b <strcmp+0xb>
		p++, q++;
  800f05:	ff 45 08             	incl   0x8(%ebp)
  800f08:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	84 c0                	test   %al,%al
  800f12:	74 0e                	je     800f22 <strcmp+0x22>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 10                	mov    (%eax),%dl
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	38 c2                	cmp    %al,%dl
  800f20:	74 e3                	je     800f05 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	0f b6 d0             	movzbl %al,%edx
  800f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	0f b6 c0             	movzbl %al,%eax
  800f32:	29 c2                	sub    %eax,%edx
  800f34:	89 d0                	mov    %edx,%eax
}
  800f36:	5d                   	pop    %ebp
  800f37:	c3                   	ret    

00800f38 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f38:	55                   	push   %ebp
  800f39:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f3b:	eb 09                	jmp    800f46 <strncmp+0xe>
		n--, p++, q++;
  800f3d:	ff 4d 10             	decl   0x10(%ebp)
  800f40:	ff 45 08             	incl   0x8(%ebp)
  800f43:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4a:	74 17                	je     800f63 <strncmp+0x2b>
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	84 c0                	test   %al,%al
  800f53:	74 0e                	je     800f63 <strncmp+0x2b>
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 10                	mov    (%eax),%dl
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	38 c2                	cmp    %al,%dl
  800f61:	74 da                	je     800f3d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f67:	75 07                	jne    800f70 <strncmp+0x38>
		return 0;
  800f69:	b8 00 00 00 00       	mov    $0x0,%eax
  800f6e:	eb 14                	jmp    800f84 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	0f b6 d0             	movzbl %al,%edx
  800f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	0f b6 c0             	movzbl %al,%eax
  800f80:	29 c2                	sub    %eax,%edx
  800f82:	89 d0                	mov    %edx,%eax
}
  800f84:	5d                   	pop    %ebp
  800f85:	c3                   	ret    

00800f86 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f86:	55                   	push   %ebp
  800f87:	89 e5                	mov    %esp,%ebp
  800f89:	83 ec 04             	sub    $0x4,%esp
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f92:	eb 12                	jmp    800fa6 <strchr+0x20>
		if (*s == c)
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f9c:	75 05                	jne    800fa3 <strchr+0x1d>
			return (char *) s;
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	eb 11                	jmp    800fb4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fa3:	ff 45 08             	incl   0x8(%ebp)
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	84 c0                	test   %al,%al
  800fad:	75 e5                	jne    800f94 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800faf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fb4:	c9                   	leave  
  800fb5:	c3                   	ret    

00800fb6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fb6:	55                   	push   %ebp
  800fb7:	89 e5                	mov    %esp,%ebp
  800fb9:	83 ec 04             	sub    $0x4,%esp
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fc2:	eb 0d                	jmp    800fd1 <strfind+0x1b>
		if (*s == c)
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fcc:	74 0e                	je     800fdc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fce:	ff 45 08             	incl   0x8(%ebp)
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	84 c0                	test   %al,%al
  800fd8:	75 ea                	jne    800fc4 <strfind+0xe>
  800fda:	eb 01                	jmp    800fdd <strfind+0x27>
		if (*s == c)
			break;
  800fdc:	90                   	nop
	return (char *) s;
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  800feb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800fee:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ff2:	76 63                	jbe    801057 <memset+0x75>
		uint64 data_block = c;
  800ff4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff7:	99                   	cltd   
  800ff8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ffb:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ffe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801001:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801004:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801008:	c1 e0 08             	shl    $0x8,%eax
  80100b:	09 45 f0             	or     %eax,-0x10(%ebp)
  80100e:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801011:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801014:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801017:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  80101b:	c1 e0 10             	shl    $0x10,%eax
  80101e:	09 45 f0             	or     %eax,-0x10(%ebp)
  801021:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801024:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801027:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80102a:	89 c2                	mov    %eax,%edx
  80102c:	b8 00 00 00 00       	mov    $0x0,%eax
  801031:	09 45 f0             	or     %eax,-0x10(%ebp)
  801034:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801037:	eb 18                	jmp    801051 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801039:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80103c:	8d 41 08             	lea    0x8(%ecx),%eax
  80103f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801042:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801045:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801048:	89 01                	mov    %eax,(%ecx)
  80104a:	89 51 04             	mov    %edx,0x4(%ecx)
  80104d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801051:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801055:	77 e2                	ja     801039 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801057:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80105b:	74 23                	je     801080 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80105d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801060:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801063:	eb 0e                	jmp    801073 <memset+0x91>
			*p8++ = (uint8)c;
  801065:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801068:	8d 50 01             	lea    0x1(%eax),%edx
  80106b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801071:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801073:	8b 45 10             	mov    0x10(%ebp),%eax
  801076:	8d 50 ff             	lea    -0x1(%eax),%edx
  801079:	89 55 10             	mov    %edx,0x10(%ebp)
  80107c:	85 c0                	test   %eax,%eax
  80107e:	75 e5                	jne    801065 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
  801088:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80108b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801097:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80109b:	76 24                	jbe    8010c1 <memcpy+0x3c>
		while(n >= 8){
  80109d:	eb 1c                	jmp    8010bb <memcpy+0x36>
			*d64 = *s64;
  80109f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a2:	8b 50 04             	mov    0x4(%eax),%edx
  8010a5:	8b 00                	mov    (%eax),%eax
  8010a7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010aa:	89 01                	mov    %eax,(%ecx)
  8010ac:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8010af:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8010b3:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8010b7:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8010bb:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010bf:	77 de                	ja     80109f <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8010c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c5:	74 31                	je     8010f8 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8010c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8010cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8010d3:	eb 16                	jmp    8010eb <memcpy+0x66>
			*d8++ = *s8++;
  8010d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d8:	8d 50 01             	lea    0x1(%eax),%edx
  8010db:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8010de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e4:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8010e7:	8a 12                	mov    (%edx),%dl
  8010e9:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8010eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f4:	85 c0                	test   %eax,%eax
  8010f6:	75 dd                	jne    8010d5 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010fb:	c9                   	leave  
  8010fc:	c3                   	ret    

008010fd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010fd:	55                   	push   %ebp
  8010fe:	89 e5                	mov    %esp,%ebp
  801100:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80110f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801112:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801115:	73 50                	jae    801167 <memmove+0x6a>
  801117:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80111a:	8b 45 10             	mov    0x10(%ebp),%eax
  80111d:	01 d0                	add    %edx,%eax
  80111f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801122:	76 43                	jbe    801167 <memmove+0x6a>
		s += n;
  801124:	8b 45 10             	mov    0x10(%ebp),%eax
  801127:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80112a:	8b 45 10             	mov    0x10(%ebp),%eax
  80112d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801130:	eb 10                	jmp    801142 <memmove+0x45>
			*--d = *--s;
  801132:	ff 4d f8             	decl   -0x8(%ebp)
  801135:	ff 4d fc             	decl   -0x4(%ebp)
  801138:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113b:	8a 10                	mov    (%eax),%dl
  80113d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801140:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	8d 50 ff             	lea    -0x1(%eax),%edx
  801148:	89 55 10             	mov    %edx,0x10(%ebp)
  80114b:	85 c0                	test   %eax,%eax
  80114d:	75 e3                	jne    801132 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80114f:	eb 23                	jmp    801174 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801151:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801154:	8d 50 01             	lea    0x1(%eax),%edx
  801157:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80115a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801160:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801163:	8a 12                	mov    (%edx),%dl
  801165:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801167:	8b 45 10             	mov    0x10(%ebp),%eax
  80116a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80116d:	89 55 10             	mov    %edx,0x10(%ebp)
  801170:	85 c0                	test   %eax,%eax
  801172:	75 dd                	jne    801151 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801177:	c9                   	leave  
  801178:	c3                   	ret    

00801179 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801179:	55                   	push   %ebp
  80117a:	89 e5                	mov    %esp,%ebp
  80117c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80118b:	eb 2a                	jmp    8011b7 <memcmp+0x3e>
		if (*s1 != *s2)
  80118d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801190:	8a 10                	mov    (%eax),%dl
  801192:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	38 c2                	cmp    %al,%dl
  801199:	74 16                	je     8011b1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80119b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	0f b6 d0             	movzbl %al,%edx
  8011a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	0f b6 c0             	movzbl %al,%eax
  8011ab:	29 c2                	sub    %eax,%edx
  8011ad:	89 d0                	mov    %edx,%eax
  8011af:	eb 18                	jmp    8011c9 <memcmp+0x50>
		s1++, s2++;
  8011b1:	ff 45 fc             	incl   -0x4(%ebp)
  8011b4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8011c0:	85 c0                	test   %eax,%eax
  8011c2:	75 c9                	jne    80118d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011c9:	c9                   	leave  
  8011ca:	c3                   	ret    

008011cb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011cb:	55                   	push   %ebp
  8011cc:	89 e5                	mov    %esp,%ebp
  8011ce:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8011d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8011d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d7:	01 d0                	add    %edx,%eax
  8011d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011dc:	eb 15                	jmp    8011f3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	0f b6 d0             	movzbl %al,%edx
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	0f b6 c0             	movzbl %al,%eax
  8011ec:	39 c2                	cmp    %eax,%edx
  8011ee:	74 0d                	je     8011fd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011f0:	ff 45 08             	incl   0x8(%ebp)
  8011f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011f9:	72 e3                	jb     8011de <memfind+0x13>
  8011fb:	eb 01                	jmp    8011fe <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011fd:	90                   	nop
	return (void *) s;
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
  801206:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801210:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801217:	eb 03                	jmp    80121c <strtol+0x19>
		s++;
  801219:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	3c 20                	cmp    $0x20,%al
  801223:	74 f4                	je     801219 <strtol+0x16>
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3c 09                	cmp    $0x9,%al
  80122c:	74 eb                	je     801219 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	3c 2b                	cmp    $0x2b,%al
  801235:	75 05                	jne    80123c <strtol+0x39>
		s++;
  801237:	ff 45 08             	incl   0x8(%ebp)
  80123a:	eb 13                	jmp    80124f <strtol+0x4c>
	else if (*s == '-')
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	3c 2d                	cmp    $0x2d,%al
  801243:	75 0a                	jne    80124f <strtol+0x4c>
		s++, neg = 1;
  801245:	ff 45 08             	incl   0x8(%ebp)
  801248:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80124f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801253:	74 06                	je     80125b <strtol+0x58>
  801255:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801259:	75 20                	jne    80127b <strtol+0x78>
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	8a 00                	mov    (%eax),%al
  801260:	3c 30                	cmp    $0x30,%al
  801262:	75 17                	jne    80127b <strtol+0x78>
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	40                   	inc    %eax
  801268:	8a 00                	mov    (%eax),%al
  80126a:	3c 78                	cmp    $0x78,%al
  80126c:	75 0d                	jne    80127b <strtol+0x78>
		s += 2, base = 16;
  80126e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801272:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801279:	eb 28                	jmp    8012a3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80127b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80127f:	75 15                	jne    801296 <strtol+0x93>
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	3c 30                	cmp    $0x30,%al
  801288:	75 0c                	jne    801296 <strtol+0x93>
		s++, base = 8;
  80128a:	ff 45 08             	incl   0x8(%ebp)
  80128d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801294:	eb 0d                	jmp    8012a3 <strtol+0xa0>
	else if (base == 0)
  801296:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80129a:	75 07                	jne    8012a3 <strtol+0xa0>
		base = 10;
  80129c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8a 00                	mov    (%eax),%al
  8012a8:	3c 2f                	cmp    $0x2f,%al
  8012aa:	7e 19                	jle    8012c5 <strtol+0xc2>
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	8a 00                	mov    (%eax),%al
  8012b1:	3c 39                	cmp    $0x39,%al
  8012b3:	7f 10                	jg     8012c5 <strtol+0xc2>
			dig = *s - '0';
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	0f be c0             	movsbl %al,%eax
  8012bd:	83 e8 30             	sub    $0x30,%eax
  8012c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012c3:	eb 42                	jmp    801307 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	8a 00                	mov    (%eax),%al
  8012ca:	3c 60                	cmp    $0x60,%al
  8012cc:	7e 19                	jle    8012e7 <strtol+0xe4>
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	3c 7a                	cmp    $0x7a,%al
  8012d5:	7f 10                	jg     8012e7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	0f be c0             	movsbl %al,%eax
  8012df:	83 e8 57             	sub    $0x57,%eax
  8012e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012e5:	eb 20                	jmp    801307 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	3c 40                	cmp    $0x40,%al
  8012ee:	7e 39                	jle    801329 <strtol+0x126>
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8a 00                	mov    (%eax),%al
  8012f5:	3c 5a                	cmp    $0x5a,%al
  8012f7:	7f 30                	jg     801329 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	0f be c0             	movsbl %al,%eax
  801301:	83 e8 37             	sub    $0x37,%eax
  801304:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80130a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80130d:	7d 19                	jge    801328 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80130f:	ff 45 08             	incl   0x8(%ebp)
  801312:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801315:	0f af 45 10          	imul   0x10(%ebp),%eax
  801319:	89 c2                	mov    %eax,%edx
  80131b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80131e:	01 d0                	add    %edx,%eax
  801320:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801323:	e9 7b ff ff ff       	jmp    8012a3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801328:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801329:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80132d:	74 08                	je     801337 <strtol+0x134>
		*endptr = (char *) s;
  80132f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801332:	8b 55 08             	mov    0x8(%ebp),%edx
  801335:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801337:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80133b:	74 07                	je     801344 <strtol+0x141>
  80133d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801340:	f7 d8                	neg    %eax
  801342:	eb 03                	jmp    801347 <strtol+0x144>
  801344:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <ltostr>:

void
ltostr(long value, char *str)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
  80134c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80134f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801356:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80135d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801361:	79 13                	jns    801376 <ltostr+0x2d>
	{
		neg = 1;
  801363:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80136a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801370:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801373:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80137e:	99                   	cltd   
  80137f:	f7 f9                	idiv   %ecx
  801381:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801384:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801387:	8d 50 01             	lea    0x1(%eax),%edx
  80138a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80138d:	89 c2                	mov    %eax,%edx
  80138f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801392:	01 d0                	add    %edx,%eax
  801394:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801397:	83 c2 30             	add    $0x30,%edx
  80139a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80139c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80139f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013a4:	f7 e9                	imul   %ecx
  8013a6:	c1 fa 02             	sar    $0x2,%edx
  8013a9:	89 c8                	mov    %ecx,%eax
  8013ab:	c1 f8 1f             	sar    $0x1f,%eax
  8013ae:	29 c2                	sub    %eax,%edx
  8013b0:	89 d0                	mov    %edx,%eax
  8013b2:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8013b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013b9:	75 bb                	jne    801376 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8013bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c5:	48                   	dec    %eax
  8013c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013cd:	74 3d                	je     80140c <ltostr+0xc3>
		start = 1 ;
  8013cf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013d6:	eb 34                	jmp    80140c <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8013d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013de:	01 d0                	add    %edx,%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013eb:	01 c2                	add    %eax,%edx
  8013ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f3:	01 c8                	add    %ecx,%eax
  8013f5:	8a 00                	mov    (%eax),%al
  8013f7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013f9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ff:	01 c2                	add    %eax,%edx
  801401:	8a 45 eb             	mov    -0x15(%ebp),%al
  801404:	88 02                	mov    %al,(%edx)
		start++ ;
  801406:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801409:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80140c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80140f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801412:	7c c4                	jl     8013d8 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801414:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141a:	01 d0                	add    %edx,%eax
  80141c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80141f:	90                   	nop
  801420:	c9                   	leave  
  801421:	c3                   	ret    

00801422 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801422:	55                   	push   %ebp
  801423:	89 e5                	mov    %esp,%ebp
  801425:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801428:	ff 75 08             	pushl  0x8(%ebp)
  80142b:	e8 c4 f9 ff ff       	call   800df4 <strlen>
  801430:	83 c4 04             	add    $0x4,%esp
  801433:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801436:	ff 75 0c             	pushl  0xc(%ebp)
  801439:	e8 b6 f9 ff ff       	call   800df4 <strlen>
  80143e:	83 c4 04             	add    $0x4,%esp
  801441:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801444:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80144b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801452:	eb 17                	jmp    80146b <strcconcat+0x49>
		final[s] = str1[s] ;
  801454:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801457:	8b 45 10             	mov    0x10(%ebp),%eax
  80145a:	01 c2                	add    %eax,%edx
  80145c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	01 c8                	add    %ecx,%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801468:	ff 45 fc             	incl   -0x4(%ebp)
  80146b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80146e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801471:	7c e1                	jl     801454 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801473:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80147a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801481:	eb 1f                	jmp    8014a2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801483:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801486:	8d 50 01             	lea    0x1(%eax),%edx
  801489:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80148c:	89 c2                	mov    %eax,%edx
  80148e:	8b 45 10             	mov    0x10(%ebp),%eax
  801491:	01 c2                	add    %eax,%edx
  801493:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	01 c8                	add    %ecx,%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80149f:	ff 45 f8             	incl   -0x8(%ebp)
  8014a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014a8:	7c d9                	jl     801483 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b0:	01 d0                	add    %edx,%eax
  8014b2:	c6 00 00             	movb   $0x0,(%eax)
}
  8014b5:	90                   	nop
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8014bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c7:	8b 00                	mov    (%eax),%eax
  8014c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d3:	01 d0                	add    %edx,%eax
  8014d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014db:	eb 0c                	jmp    8014e9 <strsplit+0x31>
			*string++ = 0;
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	8d 50 01             	lea    0x1(%eax),%edx
  8014e3:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ec:	8a 00                	mov    (%eax),%al
  8014ee:	84 c0                	test   %al,%al
  8014f0:	74 18                	je     80150a <strsplit+0x52>
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	8a 00                	mov    (%eax),%al
  8014f7:	0f be c0             	movsbl %al,%eax
  8014fa:	50                   	push   %eax
  8014fb:	ff 75 0c             	pushl  0xc(%ebp)
  8014fe:	e8 83 fa ff ff       	call   800f86 <strchr>
  801503:	83 c4 08             	add    $0x8,%esp
  801506:	85 c0                	test   %eax,%eax
  801508:	75 d3                	jne    8014dd <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	8a 00                	mov    (%eax),%al
  80150f:	84 c0                	test   %al,%al
  801511:	74 5a                	je     80156d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801513:	8b 45 14             	mov    0x14(%ebp),%eax
  801516:	8b 00                	mov    (%eax),%eax
  801518:	83 f8 0f             	cmp    $0xf,%eax
  80151b:	75 07                	jne    801524 <strsplit+0x6c>
		{
			return 0;
  80151d:	b8 00 00 00 00       	mov    $0x0,%eax
  801522:	eb 66                	jmp    80158a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801524:	8b 45 14             	mov    0x14(%ebp),%eax
  801527:	8b 00                	mov    (%eax),%eax
  801529:	8d 48 01             	lea    0x1(%eax),%ecx
  80152c:	8b 55 14             	mov    0x14(%ebp),%edx
  80152f:	89 0a                	mov    %ecx,(%edx)
  801531:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801538:	8b 45 10             	mov    0x10(%ebp),%eax
  80153b:	01 c2                	add    %eax,%edx
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801542:	eb 03                	jmp    801547 <strsplit+0x8f>
			string++;
  801544:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801547:	8b 45 08             	mov    0x8(%ebp),%eax
  80154a:	8a 00                	mov    (%eax),%al
  80154c:	84 c0                	test   %al,%al
  80154e:	74 8b                	je     8014db <strsplit+0x23>
  801550:	8b 45 08             	mov    0x8(%ebp),%eax
  801553:	8a 00                	mov    (%eax),%al
  801555:	0f be c0             	movsbl %al,%eax
  801558:	50                   	push   %eax
  801559:	ff 75 0c             	pushl  0xc(%ebp)
  80155c:	e8 25 fa ff ff       	call   800f86 <strchr>
  801561:	83 c4 08             	add    $0x8,%esp
  801564:	85 c0                	test   %eax,%eax
  801566:	74 dc                	je     801544 <strsplit+0x8c>
			string++;
	}
  801568:	e9 6e ff ff ff       	jmp    8014db <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80156d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80156e:	8b 45 14             	mov    0x14(%ebp),%eax
  801571:	8b 00                	mov    (%eax),%eax
  801573:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80157a:	8b 45 10             	mov    0x10(%ebp),%eax
  80157d:	01 d0                	add    %edx,%eax
  80157f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801585:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801598:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80159f:	eb 4a                	jmp    8015eb <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8015a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	01 c2                	add    %eax,%edx
  8015a9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	01 c8                	add    %ecx,%eax
  8015b1:	8a 00                	mov    (%eax),%al
  8015b3:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8015b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bb:	01 d0                	add    %edx,%eax
  8015bd:	8a 00                	mov    (%eax),%al
  8015bf:	3c 40                	cmp    $0x40,%al
  8015c1:	7e 25                	jle    8015e8 <str2lower+0x5c>
  8015c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c9:	01 d0                	add    %edx,%eax
  8015cb:	8a 00                	mov    (%eax),%al
  8015cd:	3c 5a                	cmp    $0x5a,%al
  8015cf:	7f 17                	jg     8015e8 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8015d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	01 d0                	add    %edx,%eax
  8015d9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8015df:	01 ca                	add    %ecx,%edx
  8015e1:	8a 12                	mov    (%edx),%dl
  8015e3:	83 c2 20             	add    $0x20,%edx
  8015e6:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8015e8:	ff 45 fc             	incl   -0x4(%ebp)
  8015eb:	ff 75 0c             	pushl  0xc(%ebp)
  8015ee:	e8 01 f8 ff ff       	call   800df4 <strlen>
  8015f3:	83 c4 04             	add    $0x4,%esp
  8015f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015f9:	7f a6                	jg     8015a1 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8015fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
  801603:	57                   	push   %edi
  801604:	56                   	push   %esi
  801605:	53                   	push   %ebx
  801606:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801612:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801615:	8b 7d 18             	mov    0x18(%ebp),%edi
  801618:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80161b:	cd 30                	int    $0x30
  80161d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801620:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801623:	83 c4 10             	add    $0x10,%esp
  801626:	5b                   	pop    %ebx
  801627:	5e                   	pop    %esi
  801628:	5f                   	pop    %edi
  801629:	5d                   	pop    %ebp
  80162a:	c3                   	ret    

0080162b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
  80162e:	83 ec 04             	sub    $0x4,%esp
  801631:	8b 45 10             	mov    0x10(%ebp),%eax
  801634:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801637:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80163a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	6a 00                	push   $0x0
  801643:	51                   	push   %ecx
  801644:	52                   	push   %edx
  801645:	ff 75 0c             	pushl  0xc(%ebp)
  801648:	50                   	push   %eax
  801649:	6a 00                	push   $0x0
  80164b:	e8 b0 ff ff ff       	call   801600 <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_cgetc>:

int
sys_cgetc(void)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 02                	push   $0x2
  801665:	e8 96 ff ff ff       	call   801600 <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_lock_cons>:

void sys_lock_cons(void)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 03                	push   $0x3
  80167e:	e8 7d ff ff ff       	call   801600 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	90                   	nop
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 04                	push   $0x4
  801698:	e8 63 ff ff ff       	call   801600 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	90                   	nop
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	52                   	push   %edx
  8016b3:	50                   	push   %eax
  8016b4:	6a 08                	push   $0x8
  8016b6:	e8 45 ff ff ff       	call   801600 <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
}
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
  8016c3:	56                   	push   %esi
  8016c4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016c5:	8b 75 18             	mov    0x18(%ebp),%esi
  8016c8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	56                   	push   %esi
  8016d5:	53                   	push   %ebx
  8016d6:	51                   	push   %ecx
  8016d7:	52                   	push   %edx
  8016d8:	50                   	push   %eax
  8016d9:	6a 09                	push   $0x9
  8016db:	e8 20 ff ff ff       	call   801600 <syscall>
  8016e0:	83 c4 18             	add    $0x18,%esp
}
  8016e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016e6:	5b                   	pop    %ebx
  8016e7:	5e                   	pop    %esi
  8016e8:	5d                   	pop    %ebp
  8016e9:	c3                   	ret    

008016ea <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	ff 75 08             	pushl  0x8(%ebp)
  8016f8:	6a 0a                	push   $0xa
  8016fa:	e8 01 ff ff ff       	call   801600 <syscall>
  8016ff:	83 c4 18             	add    $0x18,%esp
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	ff 75 0c             	pushl  0xc(%ebp)
  801710:	ff 75 08             	pushl  0x8(%ebp)
  801713:	6a 0b                	push   $0xb
  801715:	e8 e6 fe ff ff       	call   801600 <syscall>
  80171a:	83 c4 18             	add    $0x18,%esp
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 0c                	push   $0xc
  80172e:	e8 cd fe ff ff       	call   801600 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 0d                	push   $0xd
  801747:	e8 b4 fe ff ff       	call   801600 <syscall>
  80174c:	83 c4 18             	add    $0x18,%esp
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 0e                	push   $0xe
  801760:	e8 9b fe ff ff       	call   801600 <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 0f                	push   $0xf
  801779:	e8 82 fe ff ff       	call   801600 <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	ff 75 08             	pushl  0x8(%ebp)
  801791:	6a 10                	push   $0x10
  801793:	e8 68 fe ff ff       	call   801600 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 11                	push   $0x11
  8017ac:	e8 4f fe ff ff       	call   801600 <syscall>
  8017b1:	83 c4 18             	add    $0x18,%esp
}
  8017b4:	90                   	nop
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <sys_cputc>:

void
sys_cputc(const char c)
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
  8017ba:	83 ec 04             	sub    $0x4,%esp
  8017bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017c3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	50                   	push   %eax
  8017d0:	6a 01                	push   $0x1
  8017d2:	e8 29 fe ff ff       	call   801600 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	90                   	nop
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 14                	push   $0x14
  8017ec:	e8 0f fe ff ff       	call   801600 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	90                   	nop
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
  8017fa:	83 ec 04             	sub    $0x4,%esp
  8017fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801800:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801803:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801806:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	6a 00                	push   $0x0
  80180f:	51                   	push   %ecx
  801810:	52                   	push   %edx
  801811:	ff 75 0c             	pushl  0xc(%ebp)
  801814:	50                   	push   %eax
  801815:	6a 15                	push   $0x15
  801817:	e8 e4 fd ff ff       	call   801600 <syscall>
  80181c:	83 c4 18             	add    $0x18,%esp
}
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801824:	8b 55 10             	mov    0x10(%ebp),%edx
  801827:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	52                   	push   %edx
  80182f:	50                   	push   %eax
  801830:	ff 75 08             	pushl  0x8(%ebp)
  801833:	6a 16                	push   $0x16
  801835:	e8 c6 fd ff ff       	call   801600 <syscall>
  80183a:	83 c4 18             	add    $0x18,%esp
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801842:	8b 55 0c             	mov    0xc(%ebp),%edx
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	52                   	push   %edx
  80184f:	50                   	push   %eax
  801850:	6a 17                	push   $0x17
  801852:	e8 a9 fd ff ff       	call   801600 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80185f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	52                   	push   %edx
  80186c:	50                   	push   %eax
  80186d:	6a 18                	push   $0x18
  80186f:	e8 8c fd ff ff       	call   801600 <syscall>
  801874:	83 c4 18             	add    $0x18,%esp
}
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80187c:	8b 45 08             	mov    0x8(%ebp),%eax
  80187f:	6a 00                	push   $0x0
  801881:	ff 75 14             	pushl  0x14(%ebp)
  801884:	ff 75 10             	pushl  0x10(%ebp)
  801887:	ff 75 0c             	pushl  0xc(%ebp)
  80188a:	50                   	push   %eax
  80188b:	6a 19                	push   $0x19
  80188d:	e8 6e fd ff ff       	call   801600 <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80189a:	8b 45 08             	mov    0x8(%ebp),%eax
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	50                   	push   %eax
  8018a6:	6a 1a                	push   $0x1a
  8018a8:	e8 53 fd ff ff       	call   801600 <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
}
  8018b0:	90                   	nop
  8018b1:	c9                   	leave  
  8018b2:	c3                   	ret    

008018b3 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	50                   	push   %eax
  8018c2:	6a 1b                	push   $0x1b
  8018c4:	e8 37 fd ff ff       	call   801600 <syscall>
  8018c9:	83 c4 18             	add    $0x18,%esp
}
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 05                	push   $0x5
  8018dd:	e8 1e fd ff ff       	call   801600 <syscall>
  8018e2:	83 c4 18             	add    $0x18,%esp
}
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 06                	push   $0x6
  8018f6:	e8 05 fd ff ff       	call   801600 <syscall>
  8018fb:	83 c4 18             	add    $0x18,%esp
}
  8018fe:	c9                   	leave  
  8018ff:	c3                   	ret    

00801900 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801900:	55                   	push   %ebp
  801901:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 07                	push   $0x7
  80190f:	e8 ec fc ff ff       	call   801600 <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <sys_exit_env>:


void sys_exit_env(void)
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 1c                	push   $0x1c
  801928:	e8 d3 fc ff ff       	call   801600 <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	90                   	nop
  801931:	c9                   	leave  
  801932:	c3                   	ret    

00801933 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801933:	55                   	push   %ebp
  801934:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	ff 75 10             	pushl  0x10(%ebp)
  80193d:	ff 75 0c             	pushl  0xc(%ebp)
  801940:	ff 75 08             	pushl  0x8(%ebp)
  801943:	6a 13                	push   $0x13
  801945:	e8 b6 fc ff ff       	call   801600 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
	return ;
  80194d:	90                   	nop
}
  80194e:	c9                   	leave  
  80194f:	c3                   	ret    

00801950 <sys_rcr2>:
uint32 sys_rcr2()
{
  801950:	55                   	push   %ebp
  801951:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 1e                	push   $0x1e
  80195f:	e8 9c fc ff ff       	call   801600 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
  80196c:	83 ec 04             	sub    $0x4,%esp
  80196f:	8b 45 08             	mov    0x8(%ebp),%eax
  801972:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801975:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	50                   	push   %eax
  801982:	6a 1f                	push   $0x1f
  801984:	e8 77 fc ff ff       	call   801600 <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
	return ;
  80198c:	90                   	nop
}
  80198d:	c9                   	leave  
  80198e:	c3                   	ret    

0080198f <rsttst>:
void rsttst()
{
  80198f:	55                   	push   %ebp
  801990:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 21                	push   $0x21
  80199e:	e8 5d fc ff ff       	call   801600 <syscall>
  8019a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a6:	90                   	nop
}
  8019a7:	c9                   	leave  
  8019a8:	c3                   	ret    

008019a9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019a9:	55                   	push   %ebp
  8019aa:	89 e5                	mov    %esp,%ebp
  8019ac:	83 ec 04             	sub    $0x4,%esp
  8019af:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019b5:	8b 55 18             	mov    0x18(%ebp),%edx
  8019b8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019bc:	52                   	push   %edx
  8019bd:	50                   	push   %eax
  8019be:	ff 75 10             	pushl  0x10(%ebp)
  8019c1:	ff 75 0c             	pushl  0xc(%ebp)
  8019c4:	ff 75 08             	pushl  0x8(%ebp)
  8019c7:	6a 20                	push   $0x20
  8019c9:	e8 32 fc ff ff       	call   801600 <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d1:	90                   	nop
}
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <chktst>:
void chktst(uint32 n)
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	ff 75 08             	pushl  0x8(%ebp)
  8019e2:	6a 22                	push   $0x22
  8019e4:	e8 17 fc ff ff       	call   801600 <syscall>
  8019e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ec:	90                   	nop
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <inctst>:

void inctst()
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 23                	push   $0x23
  8019fe:	e8 fd fb ff ff       	call   801600 <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
	return ;
  801a06:	90                   	nop
}
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <gettst>:
uint32 gettst()
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 24                	push   $0x24
  801a18:	e8 e3 fb ff ff       	call   801600 <syscall>
  801a1d:	83 c4 18             	add    $0x18,%esp
}
  801a20:	c9                   	leave  
  801a21:	c3                   	ret    

00801a22 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801a22:	55                   	push   %ebp
  801a23:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 25                	push   $0x25
  801a31:	e8 ca fb ff ff       	call   801600 <syscall>
  801a36:	83 c4 18             	add    $0x18,%esp
  801a39:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801a3e:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801a48:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4b:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	ff 75 08             	pushl  0x8(%ebp)
  801a5b:	6a 26                	push   $0x26
  801a5d:	e8 9e fb ff ff       	call   801600 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
	return ;
  801a65:	90                   	nop
}
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
  801a6b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a6c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a6f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	6a 00                	push   $0x0
  801a7a:	53                   	push   %ebx
  801a7b:	51                   	push   %ecx
  801a7c:	52                   	push   %edx
  801a7d:	50                   	push   %eax
  801a7e:	6a 27                	push   $0x27
  801a80:	e8 7b fb ff ff       	call   801600 <syscall>
  801a85:	83 c4 18             	add    $0x18,%esp
}
  801a88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	52                   	push   %edx
  801a9d:	50                   	push   %eax
  801a9e:	6a 28                	push   $0x28
  801aa0:	e8 5b fb ff ff       	call   801600 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801aad:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ab0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab6:	6a 00                	push   $0x0
  801ab8:	51                   	push   %ecx
  801ab9:	ff 75 10             	pushl  0x10(%ebp)
  801abc:	52                   	push   %edx
  801abd:	50                   	push   %eax
  801abe:	6a 29                	push   $0x29
  801ac0:	e8 3b fb ff ff       	call   801600 <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
}
  801ac8:	c9                   	leave  
  801ac9:	c3                   	ret    

00801aca <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	ff 75 10             	pushl  0x10(%ebp)
  801ad4:	ff 75 0c             	pushl  0xc(%ebp)
  801ad7:	ff 75 08             	pushl  0x8(%ebp)
  801ada:	6a 12                	push   $0x12
  801adc:	e8 1f fb ff ff       	call   801600 <syscall>
  801ae1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae4:	90                   	nop
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801aea:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	52                   	push   %edx
  801af7:	50                   	push   %eax
  801af8:	6a 2a                	push   $0x2a
  801afa:	e8 01 fb ff ff       	call   801600 <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
	return;
  801b02:	90                   	nop
}
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 2b                	push   $0x2b
  801b14:	e8 e7 fa ff ff       	call   801600 <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
}
  801b1c:	c9                   	leave  
  801b1d:	c3                   	ret    

00801b1e <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801b1e:	55                   	push   %ebp
  801b1f:	89 e5                	mov    %esp,%ebp
  801b21:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801b24:	83 ec 04             	sub    $0x4,%esp
  801b27:	68 08 27 80 00       	push   $0x802708
  801b2c:	68 0a 01 00 00       	push   $0x10a
  801b31:	68 18 27 80 00       	push   $0x802718
  801b36:	e8 12 e9 ff ff       	call   80044d <_panic>

00801b3b <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801b3b:	55                   	push   %ebp
  801b3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	ff 75 0c             	pushl  0xc(%ebp)
  801b47:	ff 75 08             	pushl  0x8(%ebp)
  801b4a:	6a 33                	push   $0x33
  801b4c:	e8 af fa ff ff       	call   801600 <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
	return;
  801b54:	90                   	nop
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	ff 75 0c             	pushl  0xc(%ebp)
  801b63:	ff 75 08             	pushl  0x8(%ebp)
  801b66:	6a 34                	push   $0x34
  801b68:	e8 93 fa ff ff       	call   801600 <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
	return ;
  801b70:	90                   	nop
}
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
  801b76:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801b79:	8b 55 08             	mov    0x8(%ebp),%edx
  801b7c:	89 d0                	mov    %edx,%eax
  801b7e:	c1 e0 02             	shl    $0x2,%eax
  801b81:	01 d0                	add    %edx,%eax
  801b83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b8a:	01 d0                	add    %edx,%eax
  801b8c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b93:	01 d0                	add    %edx,%eax
  801b95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b9c:	01 d0                	add    %edx,%eax
  801b9e:	c1 e0 04             	shl    $0x4,%eax
  801ba1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801ba4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801bab:	0f 31                	rdtsc  
  801bad:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801bb0:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801bb3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bb6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801bbc:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801bbf:	eb 46                	jmp    801c07 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801bc1:	0f 31                	rdtsc  
  801bc3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801bc6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801bc9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bcc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801bcf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801bd2:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801bd5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdb:	29 c2                	sub    %eax,%edx
  801bdd:	89 d0                	mov    %edx,%eax
  801bdf:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801be2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be8:	89 d1                	mov    %edx,%ecx
  801bea:	29 c1                	sub    %eax,%ecx
  801bec:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801bef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bf2:	39 c2                	cmp    %eax,%edx
  801bf4:	0f 97 c0             	seta   %al
  801bf7:	0f b6 c0             	movzbl %al,%eax
  801bfa:	29 c1                	sub    %eax,%ecx
  801bfc:	89 c8                	mov    %ecx,%eax
  801bfe:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c01:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c0a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801c0d:	72 b2                	jb     801bc1 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801c0f:	90                   	nop
  801c10:	c9                   	leave  
  801c11:	c3                   	ret    

00801c12 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
  801c15:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801c18:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801c1f:	eb 03                	jmp    801c24 <busy_wait+0x12>
  801c21:	ff 45 fc             	incl   -0x4(%ebp)
  801c24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c27:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c2a:	72 f5                	jb     801c21 <busy_wait+0xf>
	return i;
  801c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c2f:	c9                   	leave  
  801c30:	c3                   	ret    
  801c31:	66 90                	xchg   %ax,%ax
  801c33:	90                   	nop

00801c34 <__udivdi3>:
  801c34:	55                   	push   %ebp
  801c35:	57                   	push   %edi
  801c36:	56                   	push   %esi
  801c37:	53                   	push   %ebx
  801c38:	83 ec 1c             	sub    $0x1c,%esp
  801c3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c4b:	89 ca                	mov    %ecx,%edx
  801c4d:	89 f8                	mov    %edi,%eax
  801c4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c53:	85 f6                	test   %esi,%esi
  801c55:	75 2d                	jne    801c84 <__udivdi3+0x50>
  801c57:	39 cf                	cmp    %ecx,%edi
  801c59:	77 65                	ja     801cc0 <__udivdi3+0x8c>
  801c5b:	89 fd                	mov    %edi,%ebp
  801c5d:	85 ff                	test   %edi,%edi
  801c5f:	75 0b                	jne    801c6c <__udivdi3+0x38>
  801c61:	b8 01 00 00 00       	mov    $0x1,%eax
  801c66:	31 d2                	xor    %edx,%edx
  801c68:	f7 f7                	div    %edi
  801c6a:	89 c5                	mov    %eax,%ebp
  801c6c:	31 d2                	xor    %edx,%edx
  801c6e:	89 c8                	mov    %ecx,%eax
  801c70:	f7 f5                	div    %ebp
  801c72:	89 c1                	mov    %eax,%ecx
  801c74:	89 d8                	mov    %ebx,%eax
  801c76:	f7 f5                	div    %ebp
  801c78:	89 cf                	mov    %ecx,%edi
  801c7a:	89 fa                	mov    %edi,%edx
  801c7c:	83 c4 1c             	add    $0x1c,%esp
  801c7f:	5b                   	pop    %ebx
  801c80:	5e                   	pop    %esi
  801c81:	5f                   	pop    %edi
  801c82:	5d                   	pop    %ebp
  801c83:	c3                   	ret    
  801c84:	39 ce                	cmp    %ecx,%esi
  801c86:	77 28                	ja     801cb0 <__udivdi3+0x7c>
  801c88:	0f bd fe             	bsr    %esi,%edi
  801c8b:	83 f7 1f             	xor    $0x1f,%edi
  801c8e:	75 40                	jne    801cd0 <__udivdi3+0x9c>
  801c90:	39 ce                	cmp    %ecx,%esi
  801c92:	72 0a                	jb     801c9e <__udivdi3+0x6a>
  801c94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c98:	0f 87 9e 00 00 00    	ja     801d3c <__udivdi3+0x108>
  801c9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca3:	89 fa                	mov    %edi,%edx
  801ca5:	83 c4 1c             	add    $0x1c,%esp
  801ca8:	5b                   	pop    %ebx
  801ca9:	5e                   	pop    %esi
  801caa:	5f                   	pop    %edi
  801cab:	5d                   	pop    %ebp
  801cac:	c3                   	ret    
  801cad:	8d 76 00             	lea    0x0(%esi),%esi
  801cb0:	31 ff                	xor    %edi,%edi
  801cb2:	31 c0                	xor    %eax,%eax
  801cb4:	89 fa                	mov    %edi,%edx
  801cb6:	83 c4 1c             	add    $0x1c,%esp
  801cb9:	5b                   	pop    %ebx
  801cba:	5e                   	pop    %esi
  801cbb:	5f                   	pop    %edi
  801cbc:	5d                   	pop    %ebp
  801cbd:	c3                   	ret    
  801cbe:	66 90                	xchg   %ax,%ax
  801cc0:	89 d8                	mov    %ebx,%eax
  801cc2:	f7 f7                	div    %edi
  801cc4:	31 ff                	xor    %edi,%edi
  801cc6:	89 fa                	mov    %edi,%edx
  801cc8:	83 c4 1c             	add    $0x1c,%esp
  801ccb:	5b                   	pop    %ebx
  801ccc:	5e                   	pop    %esi
  801ccd:	5f                   	pop    %edi
  801cce:	5d                   	pop    %ebp
  801ccf:	c3                   	ret    
  801cd0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cd5:	89 eb                	mov    %ebp,%ebx
  801cd7:	29 fb                	sub    %edi,%ebx
  801cd9:	89 f9                	mov    %edi,%ecx
  801cdb:	d3 e6                	shl    %cl,%esi
  801cdd:	89 c5                	mov    %eax,%ebp
  801cdf:	88 d9                	mov    %bl,%cl
  801ce1:	d3 ed                	shr    %cl,%ebp
  801ce3:	89 e9                	mov    %ebp,%ecx
  801ce5:	09 f1                	or     %esi,%ecx
  801ce7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ceb:	89 f9                	mov    %edi,%ecx
  801ced:	d3 e0                	shl    %cl,%eax
  801cef:	89 c5                	mov    %eax,%ebp
  801cf1:	89 d6                	mov    %edx,%esi
  801cf3:	88 d9                	mov    %bl,%cl
  801cf5:	d3 ee                	shr    %cl,%esi
  801cf7:	89 f9                	mov    %edi,%ecx
  801cf9:	d3 e2                	shl    %cl,%edx
  801cfb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cff:	88 d9                	mov    %bl,%cl
  801d01:	d3 e8                	shr    %cl,%eax
  801d03:	09 c2                	or     %eax,%edx
  801d05:	89 d0                	mov    %edx,%eax
  801d07:	89 f2                	mov    %esi,%edx
  801d09:	f7 74 24 0c          	divl   0xc(%esp)
  801d0d:	89 d6                	mov    %edx,%esi
  801d0f:	89 c3                	mov    %eax,%ebx
  801d11:	f7 e5                	mul    %ebp
  801d13:	39 d6                	cmp    %edx,%esi
  801d15:	72 19                	jb     801d30 <__udivdi3+0xfc>
  801d17:	74 0b                	je     801d24 <__udivdi3+0xf0>
  801d19:	89 d8                	mov    %ebx,%eax
  801d1b:	31 ff                	xor    %edi,%edi
  801d1d:	e9 58 ff ff ff       	jmp    801c7a <__udivdi3+0x46>
  801d22:	66 90                	xchg   %ax,%ax
  801d24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d28:	89 f9                	mov    %edi,%ecx
  801d2a:	d3 e2                	shl    %cl,%edx
  801d2c:	39 c2                	cmp    %eax,%edx
  801d2e:	73 e9                	jae    801d19 <__udivdi3+0xe5>
  801d30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d33:	31 ff                	xor    %edi,%edi
  801d35:	e9 40 ff ff ff       	jmp    801c7a <__udivdi3+0x46>
  801d3a:	66 90                	xchg   %ax,%ax
  801d3c:	31 c0                	xor    %eax,%eax
  801d3e:	e9 37 ff ff ff       	jmp    801c7a <__udivdi3+0x46>
  801d43:	90                   	nop

00801d44 <__umoddi3>:
  801d44:	55                   	push   %ebp
  801d45:	57                   	push   %edi
  801d46:	56                   	push   %esi
  801d47:	53                   	push   %ebx
  801d48:	83 ec 1c             	sub    $0x1c,%esp
  801d4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d63:	89 f3                	mov    %esi,%ebx
  801d65:	89 fa                	mov    %edi,%edx
  801d67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d6b:	89 34 24             	mov    %esi,(%esp)
  801d6e:	85 c0                	test   %eax,%eax
  801d70:	75 1a                	jne    801d8c <__umoddi3+0x48>
  801d72:	39 f7                	cmp    %esi,%edi
  801d74:	0f 86 a2 00 00 00    	jbe    801e1c <__umoddi3+0xd8>
  801d7a:	89 c8                	mov    %ecx,%eax
  801d7c:	89 f2                	mov    %esi,%edx
  801d7e:	f7 f7                	div    %edi
  801d80:	89 d0                	mov    %edx,%eax
  801d82:	31 d2                	xor    %edx,%edx
  801d84:	83 c4 1c             	add    $0x1c,%esp
  801d87:	5b                   	pop    %ebx
  801d88:	5e                   	pop    %esi
  801d89:	5f                   	pop    %edi
  801d8a:	5d                   	pop    %ebp
  801d8b:	c3                   	ret    
  801d8c:	39 f0                	cmp    %esi,%eax
  801d8e:	0f 87 ac 00 00 00    	ja     801e40 <__umoddi3+0xfc>
  801d94:	0f bd e8             	bsr    %eax,%ebp
  801d97:	83 f5 1f             	xor    $0x1f,%ebp
  801d9a:	0f 84 ac 00 00 00    	je     801e4c <__umoddi3+0x108>
  801da0:	bf 20 00 00 00       	mov    $0x20,%edi
  801da5:	29 ef                	sub    %ebp,%edi
  801da7:	89 fe                	mov    %edi,%esi
  801da9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801dad:	89 e9                	mov    %ebp,%ecx
  801daf:	d3 e0                	shl    %cl,%eax
  801db1:	89 d7                	mov    %edx,%edi
  801db3:	89 f1                	mov    %esi,%ecx
  801db5:	d3 ef                	shr    %cl,%edi
  801db7:	09 c7                	or     %eax,%edi
  801db9:	89 e9                	mov    %ebp,%ecx
  801dbb:	d3 e2                	shl    %cl,%edx
  801dbd:	89 14 24             	mov    %edx,(%esp)
  801dc0:	89 d8                	mov    %ebx,%eax
  801dc2:	d3 e0                	shl    %cl,%eax
  801dc4:	89 c2                	mov    %eax,%edx
  801dc6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dca:	d3 e0                	shl    %cl,%eax
  801dcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dd0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd4:	89 f1                	mov    %esi,%ecx
  801dd6:	d3 e8                	shr    %cl,%eax
  801dd8:	09 d0                	or     %edx,%eax
  801dda:	d3 eb                	shr    %cl,%ebx
  801ddc:	89 da                	mov    %ebx,%edx
  801dde:	f7 f7                	div    %edi
  801de0:	89 d3                	mov    %edx,%ebx
  801de2:	f7 24 24             	mull   (%esp)
  801de5:	89 c6                	mov    %eax,%esi
  801de7:	89 d1                	mov    %edx,%ecx
  801de9:	39 d3                	cmp    %edx,%ebx
  801deb:	0f 82 87 00 00 00    	jb     801e78 <__umoddi3+0x134>
  801df1:	0f 84 91 00 00 00    	je     801e88 <__umoddi3+0x144>
  801df7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801dfb:	29 f2                	sub    %esi,%edx
  801dfd:	19 cb                	sbb    %ecx,%ebx
  801dff:	89 d8                	mov    %ebx,%eax
  801e01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e05:	d3 e0                	shl    %cl,%eax
  801e07:	89 e9                	mov    %ebp,%ecx
  801e09:	d3 ea                	shr    %cl,%edx
  801e0b:	09 d0                	or     %edx,%eax
  801e0d:	89 e9                	mov    %ebp,%ecx
  801e0f:	d3 eb                	shr    %cl,%ebx
  801e11:	89 da                	mov    %ebx,%edx
  801e13:	83 c4 1c             	add    $0x1c,%esp
  801e16:	5b                   	pop    %ebx
  801e17:	5e                   	pop    %esi
  801e18:	5f                   	pop    %edi
  801e19:	5d                   	pop    %ebp
  801e1a:	c3                   	ret    
  801e1b:	90                   	nop
  801e1c:	89 fd                	mov    %edi,%ebp
  801e1e:	85 ff                	test   %edi,%edi
  801e20:	75 0b                	jne    801e2d <__umoddi3+0xe9>
  801e22:	b8 01 00 00 00       	mov    $0x1,%eax
  801e27:	31 d2                	xor    %edx,%edx
  801e29:	f7 f7                	div    %edi
  801e2b:	89 c5                	mov    %eax,%ebp
  801e2d:	89 f0                	mov    %esi,%eax
  801e2f:	31 d2                	xor    %edx,%edx
  801e31:	f7 f5                	div    %ebp
  801e33:	89 c8                	mov    %ecx,%eax
  801e35:	f7 f5                	div    %ebp
  801e37:	89 d0                	mov    %edx,%eax
  801e39:	e9 44 ff ff ff       	jmp    801d82 <__umoddi3+0x3e>
  801e3e:	66 90                	xchg   %ax,%ax
  801e40:	89 c8                	mov    %ecx,%eax
  801e42:	89 f2                	mov    %esi,%edx
  801e44:	83 c4 1c             	add    $0x1c,%esp
  801e47:	5b                   	pop    %ebx
  801e48:	5e                   	pop    %esi
  801e49:	5f                   	pop    %edi
  801e4a:	5d                   	pop    %ebp
  801e4b:	c3                   	ret    
  801e4c:	3b 04 24             	cmp    (%esp),%eax
  801e4f:	72 06                	jb     801e57 <__umoddi3+0x113>
  801e51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e55:	77 0f                	ja     801e66 <__umoddi3+0x122>
  801e57:	89 f2                	mov    %esi,%edx
  801e59:	29 f9                	sub    %edi,%ecx
  801e5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e5f:	89 14 24             	mov    %edx,(%esp)
  801e62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e6a:	8b 14 24             	mov    (%esp),%edx
  801e6d:	83 c4 1c             	add    $0x1c,%esp
  801e70:	5b                   	pop    %ebx
  801e71:	5e                   	pop    %esi
  801e72:	5f                   	pop    %edi
  801e73:	5d                   	pop    %ebp
  801e74:	c3                   	ret    
  801e75:	8d 76 00             	lea    0x0(%esi),%esi
  801e78:	2b 04 24             	sub    (%esp),%eax
  801e7b:	19 fa                	sbb    %edi,%edx
  801e7d:	89 d1                	mov    %edx,%ecx
  801e7f:	89 c6                	mov    %eax,%esi
  801e81:	e9 71 ff ff ff       	jmp    801df7 <__umoddi3+0xb3>
  801e86:	66 90                	xchg   %ax,%ax
  801e88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e8c:	72 ea                	jb     801e78 <__umoddi3+0x134>
  801e8e:	89 d9                	mov    %ebx,%ecx
  801e90:	e9 62 ff ff ff       	jmp    801df7 <__umoddi3+0xb3>
