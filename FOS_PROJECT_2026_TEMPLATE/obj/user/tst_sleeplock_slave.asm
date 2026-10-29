
obj/user/tst_sleeplock_slave:     file format elf32-i386


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
  800031:	e8 57 02 00 00       	call   80028d <libmain>
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
  80003e:	81 ec 7c 01 00 00    	sub    $0x17c,%esp
	int envID = sys_getenvid();
  800044:	e8 25 19 00 00       	call   80196e <sys_getenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Acquire the lock
	char cmd1[64] = "__AcquireSleepLock__";
  80004c:	8d 45 98             	lea    -0x68(%ebp),%eax
  80004f:	bb 30 20 80 00       	mov    $0x802030,%ebx
  800054:	ba 15 00 00 00       	mov    $0x15,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800061:	8d 55 ad             	lea    -0x53(%ebp),%edx
  800064:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800069:	b0 00                	mov    $0x0,%al
  80006b:	89 d7                	mov    %edx,%edi
  80006d:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, 0);
  80006f:	83 ec 08             	sub    $0x8,%esp
  800072:	6a 00                	push   $0x0
  800074:	8d 45 98             	lea    -0x68(%ebp),%eax
  800077:	50                   	push   %eax
  800078:	e8 0a 1b 00 00       	call   801b87 <sys_utilities>
  80007d:	83 c4 10             	add    $0x10,%esp
	{
		if (gettst() > 1)
  800080:	e8 24 1a 00 00       	call   801aa9 <gettst>
  800085:	83 f8 01             	cmp    $0x1,%eax
  800088:	76 44                	jbe    8000ce <_main+0x96>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  80008a:	0f 31                	rdtsc  
  80008c:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800092:	89 95 48 ff ff ff    	mov    %edx,-0xb8(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800098:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  80009e:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
  8000a4:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000a7:	89 55 dc             	mov    %edx,-0x24(%ebp)
		{
			//Other slaves: wait for a while
			env_sleep(RAND(5000, 10000));
  8000aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000ad:	b9 88 13 00 00       	mov    $0x1388,%ecx
  8000b2:	ba 00 00 00 00       	mov    $0x0,%edx
  8000b7:	f7 f1                	div    %ecx
  8000b9:	89 d0                	mov    %edx,%eax
  8000bb:	05 88 13 00 00       	add    $0x1388,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 4a 1b 00 00       	call   801c13 <env_sleep>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	eb 0b                	jmp    8000d9 <_main+0xa1>
		}
		else
		{
			//this is the first slave inside C.S.! so wait until receiving signal from master
			while (gettst() != 1);
  8000ce:	90                   	nop
  8000cf:	e8 d5 19 00 00       	call   801aa9 <gettst>
  8000d4:	83 f8 01             	cmp    $0x1,%eax
  8000d7:	75 f6                	jne    8000cf <_main+0x97>
		}

		//Check lock value inside C.S.
		int lockVal = 0;
  8000d9:	c7 85 54 ff ff ff 00 	movl   $0x0,-0xac(%ebp)
  8000e0:	00 00 00 
		char cmd2[64] = "__GetLockValue__";
  8000e3:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
  8000e9:	bb 70 20 80 00       	mov    $0x802070,%ebx
  8000ee:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f3:	89 c7                	mov    %eax,%edi
  8000f5:	89 de                	mov    %ebx,%esi
  8000f7:	89 d1                	mov    %edx,%ecx
  8000f9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000fb:	8d 95 95 fe ff ff    	lea    -0x16b(%ebp),%edx
  800101:	b9 2f 00 00 00       	mov    $0x2f,%ecx
  800106:	b0 00                	mov    $0x0,%al
  800108:	89 d7                	mov    %edx,%edi
  80010a:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd2, (int)(&lockVal));
  80010c:	8d 85 54 ff ff ff    	lea    -0xac(%ebp),%eax
  800112:	83 ec 08             	sub    $0x8,%esp
  800115:	50                   	push   %eax
  800116:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
  80011c:	50                   	push   %eax
  80011d:	e8 65 1a 00 00       	call   801b87 <sys_utilities>
  800122:	83 c4 10             	add    $0x10,%esp
		if (lockVal != 1)
  800125:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  80012b:	83 f8 01             	cmp    $0x1,%eax
  80012e:	74 14                	je     800144 <_main+0x10c>
		{
			panic("%~test sleeplock failed! lock is not held while it's expected to be");
  800130:	83 ec 04             	sub    $0x4,%esp
  800133:	68 40 1f 80 00       	push   $0x801f40
  800138:	6a 20                	push   $0x20
  80013a:	68 84 1f 80 00       	push   $0x801f84
  80013f:	e8 a9 03 00 00       	call   8004ed <_panic>
		}

		//Validate the number of blocked processes till now
		int numOfBlockedProcesses = 0;
  800144:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
  80014b:	00 00 00 
		char cmd3[64] = "__GetLockQueueSize__";
  80014e:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  800154:	bb b0 20 80 00       	mov    $0x8020b0,%ebx
  800159:	ba 15 00 00 00       	mov    $0x15,%edx
  80015e:	89 c7                	mov    %eax,%edi
  800160:	89 de                	mov    %ebx,%esi
  800162:	89 d1                	mov    %edx,%ecx
  800164:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800166:	8d 95 d9 fe ff ff    	lea    -0x127(%ebp),%edx
  80016c:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800171:	b0 00                	mov    $0x0,%al
  800173:	89 d7                	mov    %edx,%edi
  800175:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
  800177:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  80017d:	83 ec 08             	sub    $0x8,%esp
  800180:	50                   	push   %eax
  800181:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  800187:	50                   	push   %eax
  800188:	e8 fa 19 00 00       	call   801b87 <sys_utilities>
  80018d:	83 c4 10             	add    $0x10,%esp
		int numOfFinishedProcesses = gettst() -1 /*since master already incremented it by 1*/;
  800190:	e8 14 19 00 00       	call   801aa9 <gettst>
  800195:	48                   	dec    %eax
  800196:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int numOfSlaves = 0;
  800199:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%ebp)
  8001a0:	00 00 00 
		char cmd4[64] = "__NumOfSlaves@Get";
  8001a3:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001a9:	bb f0 20 80 00       	mov    $0x8020f0,%ebx
  8001ae:	ba 12 00 00 00       	mov    $0x12,%edx
  8001b3:	89 c7                	mov    %eax,%edi
  8001b5:	89 de                	mov    %ebx,%esi
  8001b7:	89 d1                	mov    %edx,%ecx
  8001b9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001bb:	8d 95 16 ff ff ff    	lea    -0xea(%ebp),%edx
  8001c1:	b9 2e 00 00 00       	mov    $0x2e,%ecx
  8001c6:	b0 00                	mov    $0x0,%al
  8001c8:	89 d7                	mov    %edx,%edi
  8001ca:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd4, (uint32)(&numOfSlaves));
  8001cc:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	50                   	push   %eax
  8001d6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001dc:	50                   	push   %eax
  8001dd:	e8 a5 19 00 00       	call   801b87 <sys_utilities>
  8001e2:	83 c4 10             	add    $0x10,%esp

		if (numOfFinishedProcesses + numOfBlockedProcesses != numOfSlaves - 1)
  8001e5:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
  8001eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001ee:	01 c2                	add    %eax,%edx
  8001f0:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  8001f6:	48                   	dec    %eax
  8001f7:	39 c2                	cmp    %eax,%edx
  8001f9:	74 28                	je     800223 <_main+0x1eb>
		{
			panic("%~test SleepLock failed! inconsistent number of blocked & waken-up processes. #wakenup %d + #blocked %d != #slaves %d", numOfFinishedProcesses, numOfBlockedProcesses, numOfSlaves-1);
  8001fb:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800201:	8d 50 ff             	lea    -0x1(%eax),%edx
  800204:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  80020a:	83 ec 08             	sub    $0x8,%esp
  80020d:	52                   	push   %edx
  80020e:	50                   	push   %eax
  80020f:	ff 75 e0             	pushl  -0x20(%ebp)
  800212:	68 a0 1f 80 00       	push   $0x801fa0
  800217:	6a 2e                	push   $0x2e
  800219:	68 84 1f 80 00       	push   $0x801f84
  80021e:	e8 ca 02 00 00       	call   8004ed <_panic>
		}

		//indicates finishing
		inctst();
  800223:	e8 67 18 00 00       	call   801a8f <inctst>
	}
	//Release the lock
	char cmd5[64] = "__ReleaseSleepLock__";
  800228:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  80022e:	bb 30 21 80 00       	mov    $0x802130,%ebx
  800233:	ba 15 00 00 00       	mov    $0x15,%edx
  800238:	89 c7                	mov    %eax,%edi
  80023a:	89 de                	mov    %ebx,%esi
  80023c:	89 d1                	mov    %edx,%ecx
  80023e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800240:	8d 95 6d ff ff ff    	lea    -0x93(%ebp),%edx
  800246:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  80024b:	b0 00                	mov    $0x0,%al
  80024d:	89 d7                	mov    %edx,%edi
  80024f:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd5, 0);
  800251:	83 ec 08             	sub    $0x8,%esp
  800254:	6a 00                	push   $0x0
  800256:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  80025c:	50                   	push   %eax
  80025d:	e8 25 19 00 00       	call   801b87 <sys_utilities>
  800262:	83 c4 10             	add    $0x10,%esp

	cprintf_colored(TEXT_light_magenta, ">>> Slave %d is Finished\n", envID);
  800265:	83 ec 04             	sub    $0x4,%esp
  800268:	ff 75 e4             	pushl  -0x1c(%ebp)
  80026b:	68 16 20 80 00       	push   $0x802016
  800270:	6a 0d                	push   $0xd
  800272:	e8 71 05 00 00       	call   8007e8 <cprintf_colored>
  800277:	83 c4 10             	add    $0x10,%esp
	printStats = 0;
  80027a:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  800281:	00 00 00 

	return;
  800284:	90                   	nop
}
  800285:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800288:	5b                   	pop    %ebx
  800289:	5e                   	pop    %esi
  80028a:	5f                   	pop    %edi
  80028b:	5d                   	pop    %ebp
  80028c:	c3                   	ret    

0080028d <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80028d:	55                   	push   %ebp
  80028e:	89 e5                	mov    %esp,%ebp
  800290:	57                   	push   %edi
  800291:	56                   	push   %esi
  800292:	53                   	push   %ebx
  800293:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800299:	e8 e9 16 00 00       	call   801987 <sys_getenvindex>
  80029e:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002a1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002a4:	89 d0                	mov    %edx,%eax
  8002a6:	c1 e0 03             	shl    $0x3,%eax
  8002a9:	01 d0                	add    %edx,%eax
  8002ab:	c1 e0 06             	shl    $0x6,%eax
  8002ae:	01 d0                	add    %edx,%eax
  8002b0:	c1 e0 03             	shl    $0x3,%eax
  8002b3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002b8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c2:	8a 40 10             	mov    0x10(%eax),%al
  8002c5:	84 c0                	test   %al,%al
  8002c7:	74 0d                	je     8002d6 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ce:	83 c0 10             	add    $0x10,%eax
  8002d1:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002da:	7e 0a                	jle    8002e6 <libmain+0x59>
		binaryname = argv[0];
  8002dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002df:	8b 00                	mov    (%eax),%eax
  8002e1:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002e6:	83 ec 08             	sub    $0x8,%esp
  8002e9:	ff 75 0c             	pushl  0xc(%ebp)
  8002ec:	ff 75 08             	pushl  0x8(%ebp)
  8002ef:	e8 44 fd ff ff       	call   800038 <_main>
  8002f4:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8002f7:	a1 00 30 80 00       	mov    0x803000,%eax
  8002fc:	85 c0                	test   %eax,%eax
  8002fe:	0f 84 b7 01 00 00    	je     8004bb <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800304:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80030a:	bb ac 22 80 00       	mov    $0x8022ac,%ebx
  80030f:	ba 0e 00 00 00       	mov    $0xe,%edx
  800314:	89 c7                	mov    %eax,%edi
  800316:	89 de                	mov    %ebx,%esi
  800318:	89 d1                	mov    %edx,%ecx
  80031a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80031c:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800322:	b9 56 00 00 00       	mov    $0x56,%ecx
  800327:	b0 00                	mov    $0x0,%al
  800329:	89 d7                	mov    %edx,%edi
  80032b:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80032d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800334:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800337:	83 ec 08             	sub    $0x8,%esp
  80033a:	50                   	push   %eax
  80033b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800341:	50                   	push   %eax
  800342:	e8 40 18 00 00       	call   801b87 <sys_utilities>
  800347:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80034a:	e8 c0 13 00 00       	call   80170f <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	68 88 21 80 00       	push   $0x802188
  800357:	e8 5f 04 00 00       	call   8007bb <cprintf>
  80035c:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80035f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800362:	85 c0                	test   %eax,%eax
  800364:	74 58                	je     8003be <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800366:	e8 3a 18 00 00       	call   801ba5 <sys_get_optimal_num_faults>
  80036b:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80036e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800374:	bb 10 23 80 00       	mov    $0x802310,%ebx
  800379:	ba 11 00 00 00       	mov    $0x11,%edx
  80037e:	89 c7                	mov    %eax,%edi
  800380:	89 de                	mov    %ebx,%esi
  800382:	89 d1                	mov    %edx,%ecx
  800384:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800386:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800389:	b9 53 00 00 00       	mov    $0x53,%ecx
  80038e:	b0 00                	mov    $0x0,%al
  800390:	89 d7                	mov    %edx,%edi
  800392:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800394:	83 ec 08             	sub    $0x8,%esp
  800397:	ff 75 dc             	pushl  -0x24(%ebp)
  80039a:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003a0:	50                   	push   %eax
  8003a1:	e8 e1 17 00 00       	call   801b87 <sys_utilities>
  8003a6:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003a9:	83 ec 08             	sub    $0x8,%esp
  8003ac:	ff 75 dc             	pushl  -0x24(%ebp)
  8003af:	68 b0 21 80 00       	push   $0x8021b0
  8003b4:	e8 02 04 00 00       	call   8007bb <cprintf>
  8003b9:	83 c4 10             	add    $0x10,%esp
  8003bc:	eb 59                	jmp    800417 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003be:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c3:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ce:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003d4:	83 ec 04             	sub    $0x4,%esp
  8003d7:	52                   	push   %edx
  8003d8:	50                   	push   %eax
  8003d9:	68 d4 21 80 00       	push   $0x8021d4
  8003de:	e8 d8 03 00 00       	call   8007bb <cprintf>
  8003e3:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003eb:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f6:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8003fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800401:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800407:	51                   	push   %ecx
  800408:	52                   	push   %edx
  800409:	50                   	push   %eax
  80040a:	68 fc 21 80 00       	push   $0x8021fc
  80040f:	e8 a7 03 00 00       	call   8007bb <cprintf>
  800414:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800417:	a1 20 30 80 00       	mov    0x803020,%eax
  80041c:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800422:	83 ec 08             	sub    $0x8,%esp
  800425:	50                   	push   %eax
  800426:	68 54 22 80 00       	push   $0x802254
  80042b:	e8 8b 03 00 00       	call   8007bb <cprintf>
  800430:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800433:	83 ec 0c             	sub    $0xc,%esp
  800436:	68 68 22 80 00       	push   $0x802268
  80043b:	e8 7b 03 00 00       	call   8007bb <cprintf>
  800440:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800443:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80044a:	eb 28                	jmp    800474 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80044c:	a1 20 30 80 00       	mov    0x803020,%eax
  800451:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800454:	81 c2 74 04 00 00    	add    $0x474,%edx
  80045a:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80045d:	83 ec 04             	sub    $0x4,%esp
  800460:	50                   	push   %eax
  800461:	ff 75 e4             	pushl  -0x1c(%ebp)
  800464:	68 7f 22 80 00       	push   $0x80227f
  800469:	e8 4d 03 00 00       	call   8007bb <cprintf>
  80046e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800471:	ff 45 e4             	incl   -0x1c(%ebp)
  800474:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800478:	7e d2                	jle    80044c <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80047a:	83 ec 0c             	sub    $0xc,%esp
  80047d:	68 8e 22 80 00       	push   $0x80228e
  800482:	e8 34 03 00 00       	call   8007bb <cprintf>
  800487:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80048a:	a1 20 30 80 00       	mov    0x803020,%eax
  80048f:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800495:	83 ec 08             	sub    $0x8,%esp
  800498:	50                   	push   %eax
  800499:	68 92 22 80 00       	push   $0x802292
  80049e:	e8 18 03 00 00       	call   8007bb <cprintf>
  8004a3:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004a6:	83 ec 0c             	sub    $0xc,%esp
  8004a9:	68 88 21 80 00       	push   $0x802188
  8004ae:	e8 08 03 00 00       	call   8007bb <cprintf>
  8004b3:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004b6:	e8 6e 12 00 00       	call   801729 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004bb:	e8 1f 00 00 00       	call   8004df <exit>
}
  8004c0:	90                   	nop
  8004c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004c4:	5b                   	pop    %ebx
  8004c5:	5e                   	pop    %esi
  8004c6:	5f                   	pop    %edi
  8004c7:	5d                   	pop    %ebp
  8004c8:	c3                   	ret    

008004c9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004c9:	55                   	push   %ebp
  8004ca:	89 e5                	mov    %esp,%ebp
  8004cc:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004cf:	83 ec 0c             	sub    $0xc,%esp
  8004d2:	6a 00                	push   $0x0
  8004d4:	e8 7a 14 00 00       	call   801953 <sys_destroy_env>
  8004d9:	83 c4 10             	add    $0x10,%esp
}
  8004dc:	90                   	nop
  8004dd:	c9                   	leave  
  8004de:	c3                   	ret    

008004df <exit>:

void
exit(void)
{
  8004df:	55                   	push   %ebp
  8004e0:	89 e5                	mov    %esp,%ebp
  8004e2:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004e5:	e8 cf 14 00 00       	call   8019b9 <sys_exit_env>
}
  8004ea:	90                   	nop
  8004eb:	c9                   	leave  
  8004ec:	c3                   	ret    

008004ed <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004ed:	55                   	push   %ebp
  8004ee:	89 e5                	mov    %esp,%ebp
  8004f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8004f6:	83 c0 04             	add    $0x4,%eax
  8004f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004fc:	a1 28 31 80 00       	mov    0x803128,%eax
  800501:	85 c0                	test   %eax,%eax
  800503:	74 16                	je     80051b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800505:	a1 28 31 80 00       	mov    0x803128,%eax
  80050a:	83 ec 08             	sub    $0x8,%esp
  80050d:	50                   	push   %eax
  80050e:	68 74 23 80 00       	push   $0x802374
  800513:	e8 a3 02 00 00       	call   8007bb <cprintf>
  800518:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80051b:	a1 04 30 80 00       	mov    0x803004,%eax
  800520:	83 ec 0c             	sub    $0xc,%esp
  800523:	ff 75 0c             	pushl  0xc(%ebp)
  800526:	ff 75 08             	pushl  0x8(%ebp)
  800529:	50                   	push   %eax
  80052a:	68 7c 23 80 00       	push   $0x80237c
  80052f:	6a 74                	push   $0x74
  800531:	e8 b2 02 00 00       	call   8007e8 <cprintf_colored>
  800536:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800539:	8b 45 10             	mov    0x10(%ebp),%eax
  80053c:	83 ec 08             	sub    $0x8,%esp
  80053f:	ff 75 f4             	pushl  -0xc(%ebp)
  800542:	50                   	push   %eax
  800543:	e8 04 02 00 00       	call   80074c <vcprintf>
  800548:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80054b:	83 ec 08             	sub    $0x8,%esp
  80054e:	6a 00                	push   $0x0
  800550:	68 a4 23 80 00       	push   $0x8023a4
  800555:	e8 f2 01 00 00       	call   80074c <vcprintf>
  80055a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80055d:	e8 7d ff ff ff       	call   8004df <exit>

	// should not return here
	while (1) ;
  800562:	eb fe                	jmp    800562 <_panic+0x75>

00800564 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800564:	55                   	push   %ebp
  800565:	89 e5                	mov    %esp,%ebp
  800567:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80056a:	a1 20 30 80 00       	mov    0x803020,%eax
  80056f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800575:	8b 45 0c             	mov    0xc(%ebp),%eax
  800578:	39 c2                	cmp    %eax,%edx
  80057a:	74 14                	je     800590 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 a8 23 80 00       	push   $0x8023a8
  800584:	6a 26                	push   $0x26
  800586:	68 f4 23 80 00       	push   $0x8023f4
  80058b:	e8 5d ff ff ff       	call   8004ed <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800590:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800597:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80059e:	e9 c5 00 00 00       	jmp    800668 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	8b 00                	mov    (%eax),%eax
  8005b4:	85 c0                	test   %eax,%eax
  8005b6:	75 08                	jne    8005c0 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005b8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005bb:	e9 a5 00 00 00       	jmp    800665 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005c7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005ce:	eb 69                	jmp    800639 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d5:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005db:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005de:	89 d0                	mov    %edx,%eax
  8005e0:	01 c0                	add    %eax,%eax
  8005e2:	01 d0                	add    %edx,%eax
  8005e4:	c1 e0 03             	shl    $0x3,%eax
  8005e7:	01 c8                	add    %ecx,%eax
  8005e9:	8a 40 04             	mov    0x4(%eax),%al
  8005ec:	84 c0                	test   %al,%al
  8005ee:	75 46                	jne    800636 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f5:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005fe:	89 d0                	mov    %edx,%eax
  800600:	01 c0                	add    %eax,%eax
  800602:	01 d0                	add    %edx,%eax
  800604:	c1 e0 03             	shl    $0x3,%eax
  800607:	01 c8                	add    %ecx,%eax
  800609:	8b 00                	mov    (%eax),%eax
  80060b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80060e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800611:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800616:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800618:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800622:	8b 45 08             	mov    0x8(%ebp),%eax
  800625:	01 c8                	add    %ecx,%eax
  800627:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800629:	39 c2                	cmp    %eax,%edx
  80062b:	75 09                	jne    800636 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80062d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800634:	eb 15                	jmp    80064b <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800636:	ff 45 e8             	incl   -0x18(%ebp)
  800639:	a1 20 30 80 00       	mov    0x803020,%eax
  80063e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800644:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800647:	39 c2                	cmp    %eax,%edx
  800649:	77 85                	ja     8005d0 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80064b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80064f:	75 14                	jne    800665 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800651:	83 ec 04             	sub    $0x4,%esp
  800654:	68 00 24 80 00       	push   $0x802400
  800659:	6a 3a                	push   $0x3a
  80065b:	68 f4 23 80 00       	push   $0x8023f4
  800660:	e8 88 fe ff ff       	call   8004ed <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800665:	ff 45 f0             	incl   -0x10(%ebp)
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80066e:	0f 8c 2f ff ff ff    	jl     8005a3 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800674:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80067b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800682:	eb 26                	jmp    8006aa <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80068f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800692:	89 d0                	mov    %edx,%eax
  800694:	01 c0                	add    %eax,%eax
  800696:	01 d0                	add    %edx,%eax
  800698:	c1 e0 03             	shl    $0x3,%eax
  80069b:	01 c8                	add    %ecx,%eax
  80069d:	8a 40 04             	mov    0x4(%eax),%al
  8006a0:	3c 01                	cmp    $0x1,%al
  8006a2:	75 03                	jne    8006a7 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006a4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006a7:	ff 45 e0             	incl   -0x20(%ebp)
  8006aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8006af:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b8:	39 c2                	cmp    %eax,%edx
  8006ba:	77 c8                	ja     800684 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006bf:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006c2:	74 14                	je     8006d8 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006c4:	83 ec 04             	sub    $0x4,%esp
  8006c7:	68 54 24 80 00       	push   $0x802454
  8006cc:	6a 44                	push   $0x44
  8006ce:	68 f4 23 80 00       	push   $0x8023f4
  8006d3:	e8 15 fe ff ff       	call   8004ed <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006d8:	90                   	nop
  8006d9:	c9                   	leave  
  8006da:	c3                   	ret    

008006db <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8006db:	55                   	push   %ebp
  8006dc:	89 e5                	mov    %esp,%ebp
  8006de:	53                   	push   %ebx
  8006df:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8006e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8006ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ed:	89 0a                	mov    %ecx,(%edx)
  8006ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8006f2:	88 d1                	mov    %dl,%cl
  8006f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006f7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fe:	8b 00                	mov    (%eax),%eax
  800700:	3d ff 00 00 00       	cmp    $0xff,%eax
  800705:	75 30                	jne    800737 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800707:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80070d:	a0 40 30 80 00       	mov    0x803040,%al
  800712:	0f b6 c0             	movzbl %al,%eax
  800715:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800718:	8b 09                	mov    (%ecx),%ecx
  80071a:	89 cb                	mov    %ecx,%ebx
  80071c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80071f:	83 c1 08             	add    $0x8,%ecx
  800722:	52                   	push   %edx
  800723:	50                   	push   %eax
  800724:	53                   	push   %ebx
  800725:	51                   	push   %ecx
  800726:	e8 a0 0f 00 00       	call   8016cb <sys_cputs>
  80072b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80072e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800731:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073a:	8b 40 04             	mov    0x4(%eax),%eax
  80073d:	8d 50 01             	lea    0x1(%eax),%edx
  800740:	8b 45 0c             	mov    0xc(%ebp),%eax
  800743:	89 50 04             	mov    %edx,0x4(%eax)
}
  800746:	90                   	nop
  800747:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80074a:	c9                   	leave  
  80074b:	c3                   	ret    

0080074c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80074c:	55                   	push   %ebp
  80074d:	89 e5                	mov    %esp,%ebp
  80074f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800755:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80075c:	00 00 00 
	b.cnt = 0;
  80075f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800766:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800769:	ff 75 0c             	pushl  0xc(%ebp)
  80076c:	ff 75 08             	pushl  0x8(%ebp)
  80076f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800775:	50                   	push   %eax
  800776:	68 db 06 80 00       	push   $0x8006db
  80077b:	e8 5a 02 00 00       	call   8009da <vprintfmt>
  800780:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800783:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800789:	a0 40 30 80 00       	mov    0x803040,%al
  80078e:	0f b6 c0             	movzbl %al,%eax
  800791:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800797:	52                   	push   %edx
  800798:	50                   	push   %eax
  800799:	51                   	push   %ecx
  80079a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007a0:	83 c0 08             	add    $0x8,%eax
  8007a3:	50                   	push   %eax
  8007a4:	e8 22 0f 00 00       	call   8016cb <sys_cputs>
  8007a9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007ac:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007b3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
  8007be:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007c1:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007c8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	83 ec 08             	sub    $0x8,%esp
  8007d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d7:	50                   	push   %eax
  8007d8:	e8 6f ff ff ff       	call   80074c <vcprintf>
  8007dd:	83 c4 10             	add    $0x10,%esp
  8007e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007e6:	c9                   	leave  
  8007e7:	c3                   	ret    

008007e8 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007e8:	55                   	push   %ebp
  8007e9:	89 e5                	mov    %esp,%ebp
  8007eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007ee:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	c1 e0 08             	shl    $0x8,%eax
  8007fb:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800800:	8d 45 0c             	lea    0xc(%ebp),%eax
  800803:	83 c0 04             	add    $0x4,%eax
  800806:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800809:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080c:	83 ec 08             	sub    $0x8,%esp
  80080f:	ff 75 f4             	pushl  -0xc(%ebp)
  800812:	50                   	push   %eax
  800813:	e8 34 ff ff ff       	call   80074c <vcprintf>
  800818:	83 c4 10             	add    $0x10,%esp
  80081b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80081e:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800825:	07 00 00 

	return cnt;
  800828:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80082b:	c9                   	leave  
  80082c:	c3                   	ret    

0080082d <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80082d:	55                   	push   %ebp
  80082e:	89 e5                	mov    %esp,%ebp
  800830:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800833:	e8 d7 0e 00 00       	call   80170f <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800838:	8d 45 0c             	lea    0xc(%ebp),%eax
  80083b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80083e:	8b 45 08             	mov    0x8(%ebp),%eax
  800841:	83 ec 08             	sub    $0x8,%esp
  800844:	ff 75 f4             	pushl  -0xc(%ebp)
  800847:	50                   	push   %eax
  800848:	e8 ff fe ff ff       	call   80074c <vcprintf>
  80084d:	83 c4 10             	add    $0x10,%esp
  800850:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800853:	e8 d1 0e 00 00       	call   801729 <sys_unlock_cons>
	return cnt;
  800858:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80085b:	c9                   	leave  
  80085c:	c3                   	ret    

0080085d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80085d:	55                   	push   %ebp
  80085e:	89 e5                	mov    %esp,%ebp
  800860:	53                   	push   %ebx
  800861:	83 ec 14             	sub    $0x14,%esp
  800864:	8b 45 10             	mov    0x10(%ebp),%eax
  800867:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086a:	8b 45 14             	mov    0x14(%ebp),%eax
  80086d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800870:	8b 45 18             	mov    0x18(%ebp),%eax
  800873:	ba 00 00 00 00       	mov    $0x0,%edx
  800878:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80087b:	77 55                	ja     8008d2 <printnum+0x75>
  80087d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800880:	72 05                	jb     800887 <printnum+0x2a>
  800882:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800885:	77 4b                	ja     8008d2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800887:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80088a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80088d:	8b 45 18             	mov    0x18(%ebp),%eax
  800890:	ba 00 00 00 00       	mov    $0x0,%edx
  800895:	52                   	push   %edx
  800896:	50                   	push   %eax
  800897:	ff 75 f4             	pushl  -0xc(%ebp)
  80089a:	ff 75 f0             	pushl  -0x10(%ebp)
  80089d:	e8 32 14 00 00       	call   801cd4 <__udivdi3>
  8008a2:	83 c4 10             	add    $0x10,%esp
  8008a5:	83 ec 04             	sub    $0x4,%esp
  8008a8:	ff 75 20             	pushl  0x20(%ebp)
  8008ab:	53                   	push   %ebx
  8008ac:	ff 75 18             	pushl  0x18(%ebp)
  8008af:	52                   	push   %edx
  8008b0:	50                   	push   %eax
  8008b1:	ff 75 0c             	pushl  0xc(%ebp)
  8008b4:	ff 75 08             	pushl  0x8(%ebp)
  8008b7:	e8 a1 ff ff ff       	call   80085d <printnum>
  8008bc:	83 c4 20             	add    $0x20,%esp
  8008bf:	eb 1a                	jmp    8008db <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008c1:	83 ec 08             	sub    $0x8,%esp
  8008c4:	ff 75 0c             	pushl  0xc(%ebp)
  8008c7:	ff 75 20             	pushl  0x20(%ebp)
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	ff d0                	call   *%eax
  8008cf:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008d2:	ff 4d 1c             	decl   0x1c(%ebp)
  8008d5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008d9:	7f e6                	jg     8008c1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008db:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008de:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008e9:	53                   	push   %ebx
  8008ea:	51                   	push   %ecx
  8008eb:	52                   	push   %edx
  8008ec:	50                   	push   %eax
  8008ed:	e8 f2 14 00 00       	call   801de4 <__umoddi3>
  8008f2:	83 c4 10             	add    $0x10,%esp
  8008f5:	05 b4 26 80 00       	add    $0x8026b4,%eax
  8008fa:	8a 00                	mov    (%eax),%al
  8008fc:	0f be c0             	movsbl %al,%eax
  8008ff:	83 ec 08             	sub    $0x8,%esp
  800902:	ff 75 0c             	pushl  0xc(%ebp)
  800905:	50                   	push   %eax
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	ff d0                	call   *%eax
  80090b:	83 c4 10             	add    $0x10,%esp
}
  80090e:	90                   	nop
  80090f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800912:	c9                   	leave  
  800913:	c3                   	ret    

00800914 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800914:	55                   	push   %ebp
  800915:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800917:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80091b:	7e 1c                	jle    800939 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	8b 00                	mov    (%eax),%eax
  800922:	8d 50 08             	lea    0x8(%eax),%edx
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	89 10                	mov    %edx,(%eax)
  80092a:	8b 45 08             	mov    0x8(%ebp),%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	83 e8 08             	sub    $0x8,%eax
  800932:	8b 50 04             	mov    0x4(%eax),%edx
  800935:	8b 00                	mov    (%eax),%eax
  800937:	eb 40                	jmp    800979 <getuint+0x65>
	else if (lflag)
  800939:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80093d:	74 1e                	je     80095d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	8b 00                	mov    (%eax),%eax
  800944:	8d 50 04             	lea    0x4(%eax),%edx
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	89 10                	mov    %edx,(%eax)
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	8b 00                	mov    (%eax),%eax
  800951:	83 e8 04             	sub    $0x4,%eax
  800954:	8b 00                	mov    (%eax),%eax
  800956:	ba 00 00 00 00       	mov    $0x0,%edx
  80095b:	eb 1c                	jmp    800979 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	8b 00                	mov    (%eax),%eax
  800962:	8d 50 04             	lea    0x4(%eax),%edx
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	89 10                	mov    %edx,(%eax)
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	8b 00                	mov    (%eax),%eax
  80096f:	83 e8 04             	sub    $0x4,%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800979:	5d                   	pop    %ebp
  80097a:	c3                   	ret    

0080097b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80097b:	55                   	push   %ebp
  80097c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80097e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800982:	7e 1c                	jle    8009a0 <getint+0x25>
		return va_arg(*ap, long long);
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	8b 00                	mov    (%eax),%eax
  800989:	8d 50 08             	lea    0x8(%eax),%edx
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	89 10                	mov    %edx,(%eax)
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	8b 00                	mov    (%eax),%eax
  800996:	83 e8 08             	sub    $0x8,%eax
  800999:	8b 50 04             	mov    0x4(%eax),%edx
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	eb 38                	jmp    8009d8 <getint+0x5d>
	else if (lflag)
  8009a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009a4:	74 1a                	je     8009c0 <getint+0x45>
		return va_arg(*ap, long);
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	8b 00                	mov    (%eax),%eax
  8009ab:	8d 50 04             	lea    0x4(%eax),%edx
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	89 10                	mov    %edx,(%eax)
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	8b 00                	mov    (%eax),%eax
  8009b8:	83 e8 04             	sub    $0x4,%eax
  8009bb:	8b 00                	mov    (%eax),%eax
  8009bd:	99                   	cltd   
  8009be:	eb 18                	jmp    8009d8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	8b 00                	mov    (%eax),%eax
  8009c5:	8d 50 04             	lea    0x4(%eax),%edx
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	89 10                	mov    %edx,(%eax)
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	8b 00                	mov    (%eax),%eax
  8009d2:	83 e8 04             	sub    $0x4,%eax
  8009d5:	8b 00                	mov    (%eax),%eax
  8009d7:	99                   	cltd   
}
  8009d8:	5d                   	pop    %ebp
  8009d9:	c3                   	ret    

008009da <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009da:	55                   	push   %ebp
  8009db:	89 e5                	mov    %esp,%ebp
  8009dd:	56                   	push   %esi
  8009de:	53                   	push   %ebx
  8009df:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009e2:	eb 17                	jmp    8009fb <vprintfmt+0x21>
			if (ch == '\0')
  8009e4:	85 db                	test   %ebx,%ebx
  8009e6:	0f 84 c1 03 00 00    	je     800dad <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8009ec:	83 ec 08             	sub    $0x8,%esp
  8009ef:	ff 75 0c             	pushl  0xc(%ebp)
  8009f2:	53                   	push   %ebx
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	ff d0                	call   *%eax
  8009f8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8009fe:	8d 50 01             	lea    0x1(%eax),%edx
  800a01:	89 55 10             	mov    %edx,0x10(%ebp)
  800a04:	8a 00                	mov    (%eax),%al
  800a06:	0f b6 d8             	movzbl %al,%ebx
  800a09:	83 fb 25             	cmp    $0x25,%ebx
  800a0c:	75 d6                	jne    8009e4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a0e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a12:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a19:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a20:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a27:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a31:	8d 50 01             	lea    0x1(%eax),%edx
  800a34:	89 55 10             	mov    %edx,0x10(%ebp)
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	0f b6 d8             	movzbl %al,%ebx
  800a3c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a3f:	83 f8 5b             	cmp    $0x5b,%eax
  800a42:	0f 87 3d 03 00 00    	ja     800d85 <vprintfmt+0x3ab>
  800a48:	8b 04 85 d8 26 80 00 	mov    0x8026d8(,%eax,4),%eax
  800a4f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a51:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a55:	eb d7                	jmp    800a2e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a57:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a5b:	eb d1                	jmp    800a2e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a5d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a64:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a67:	89 d0                	mov    %edx,%eax
  800a69:	c1 e0 02             	shl    $0x2,%eax
  800a6c:	01 d0                	add    %edx,%eax
  800a6e:	01 c0                	add    %eax,%eax
  800a70:	01 d8                	add    %ebx,%eax
  800a72:	83 e8 30             	sub    $0x30,%eax
  800a75:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a78:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7b:	8a 00                	mov    (%eax),%al
  800a7d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a80:	83 fb 2f             	cmp    $0x2f,%ebx
  800a83:	7e 3e                	jle    800ac3 <vprintfmt+0xe9>
  800a85:	83 fb 39             	cmp    $0x39,%ebx
  800a88:	7f 39                	jg     800ac3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a8a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a8d:	eb d5                	jmp    800a64 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a92:	83 c0 04             	add    $0x4,%eax
  800a95:	89 45 14             	mov    %eax,0x14(%ebp)
  800a98:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9b:	83 e8 04             	sub    $0x4,%eax
  800a9e:	8b 00                	mov    (%eax),%eax
  800aa0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800aa3:	eb 1f                	jmp    800ac4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800aa5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa9:	79 83                	jns    800a2e <vprintfmt+0x54>
				width = 0;
  800aab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ab2:	e9 77 ff ff ff       	jmp    800a2e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ab7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800abe:	e9 6b ff ff ff       	jmp    800a2e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ac3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ac4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac8:	0f 89 60 ff ff ff    	jns    800a2e <vprintfmt+0x54>
				width = precision, precision = -1;
  800ace:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ad1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ad4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800adb:	e9 4e ff ff ff       	jmp    800a2e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ae0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ae3:	e9 46 ff ff ff       	jmp    800a2e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ae8:	8b 45 14             	mov    0x14(%ebp),%eax
  800aeb:	83 c0 04             	add    $0x4,%eax
  800aee:	89 45 14             	mov    %eax,0x14(%ebp)
  800af1:	8b 45 14             	mov    0x14(%ebp),%eax
  800af4:	83 e8 04             	sub    $0x4,%eax
  800af7:	8b 00                	mov    (%eax),%eax
  800af9:	83 ec 08             	sub    $0x8,%esp
  800afc:	ff 75 0c             	pushl  0xc(%ebp)
  800aff:	50                   	push   %eax
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	ff d0                	call   *%eax
  800b05:	83 c4 10             	add    $0x10,%esp
			break;
  800b08:	e9 9b 02 00 00       	jmp    800da8 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b10:	83 c0 04             	add    $0x4,%eax
  800b13:	89 45 14             	mov    %eax,0x14(%ebp)
  800b16:	8b 45 14             	mov    0x14(%ebp),%eax
  800b19:	83 e8 04             	sub    $0x4,%eax
  800b1c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b1e:	85 db                	test   %ebx,%ebx
  800b20:	79 02                	jns    800b24 <vprintfmt+0x14a>
				err = -err;
  800b22:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b24:	83 fb 64             	cmp    $0x64,%ebx
  800b27:	7f 0b                	jg     800b34 <vprintfmt+0x15a>
  800b29:	8b 34 9d 20 25 80 00 	mov    0x802520(,%ebx,4),%esi
  800b30:	85 f6                	test   %esi,%esi
  800b32:	75 19                	jne    800b4d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b34:	53                   	push   %ebx
  800b35:	68 c5 26 80 00       	push   $0x8026c5
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	ff 75 08             	pushl  0x8(%ebp)
  800b40:	e8 70 02 00 00       	call   800db5 <printfmt>
  800b45:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b48:	e9 5b 02 00 00       	jmp    800da8 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b4d:	56                   	push   %esi
  800b4e:	68 ce 26 80 00       	push   $0x8026ce
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	ff 75 08             	pushl  0x8(%ebp)
  800b59:	e8 57 02 00 00       	call   800db5 <printfmt>
  800b5e:	83 c4 10             	add    $0x10,%esp
			break;
  800b61:	e9 42 02 00 00       	jmp    800da8 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b66:	8b 45 14             	mov    0x14(%ebp),%eax
  800b69:	83 c0 04             	add    $0x4,%eax
  800b6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b72:	83 e8 04             	sub    $0x4,%eax
  800b75:	8b 30                	mov    (%eax),%esi
  800b77:	85 f6                	test   %esi,%esi
  800b79:	75 05                	jne    800b80 <vprintfmt+0x1a6>
				p = "(null)";
  800b7b:	be d1 26 80 00       	mov    $0x8026d1,%esi
			if (width > 0 && padc != '-')
  800b80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b84:	7e 6d                	jle    800bf3 <vprintfmt+0x219>
  800b86:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b8a:	74 67                	je     800bf3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b8f:	83 ec 08             	sub    $0x8,%esp
  800b92:	50                   	push   %eax
  800b93:	56                   	push   %esi
  800b94:	e8 1e 03 00 00       	call   800eb7 <strnlen>
  800b99:	83 c4 10             	add    $0x10,%esp
  800b9c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b9f:	eb 16                	jmp    800bb7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ba1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ba5:	83 ec 08             	sub    $0x8,%esp
  800ba8:	ff 75 0c             	pushl  0xc(%ebp)
  800bab:	50                   	push   %eax
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	ff d0                	call   *%eax
  800bb1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bb4:	ff 4d e4             	decl   -0x1c(%ebp)
  800bb7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bbb:	7f e4                	jg     800ba1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bbd:	eb 34                	jmp    800bf3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bbf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bc3:	74 1c                	je     800be1 <vprintfmt+0x207>
  800bc5:	83 fb 1f             	cmp    $0x1f,%ebx
  800bc8:	7e 05                	jle    800bcf <vprintfmt+0x1f5>
  800bca:	83 fb 7e             	cmp    $0x7e,%ebx
  800bcd:	7e 12                	jle    800be1 <vprintfmt+0x207>
					putch('?', putdat);
  800bcf:	83 ec 08             	sub    $0x8,%esp
  800bd2:	ff 75 0c             	pushl  0xc(%ebp)
  800bd5:	6a 3f                	push   $0x3f
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	ff d0                	call   *%eax
  800bdc:	83 c4 10             	add    $0x10,%esp
  800bdf:	eb 0f                	jmp    800bf0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 0c             	pushl  0xc(%ebp)
  800be7:	53                   	push   %ebx
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	ff d0                	call   *%eax
  800bed:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bf0:	ff 4d e4             	decl   -0x1c(%ebp)
  800bf3:	89 f0                	mov    %esi,%eax
  800bf5:	8d 70 01             	lea    0x1(%eax),%esi
  800bf8:	8a 00                	mov    (%eax),%al
  800bfa:	0f be d8             	movsbl %al,%ebx
  800bfd:	85 db                	test   %ebx,%ebx
  800bff:	74 24                	je     800c25 <vprintfmt+0x24b>
  800c01:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c05:	78 b8                	js     800bbf <vprintfmt+0x1e5>
  800c07:	ff 4d e0             	decl   -0x20(%ebp)
  800c0a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c0e:	79 af                	jns    800bbf <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c10:	eb 13                	jmp    800c25 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c12:	83 ec 08             	sub    $0x8,%esp
  800c15:	ff 75 0c             	pushl  0xc(%ebp)
  800c18:	6a 20                	push   $0x20
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	ff d0                	call   *%eax
  800c1f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c22:	ff 4d e4             	decl   -0x1c(%ebp)
  800c25:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c29:	7f e7                	jg     800c12 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c2b:	e9 78 01 00 00       	jmp    800da8 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c30:	83 ec 08             	sub    $0x8,%esp
  800c33:	ff 75 e8             	pushl  -0x18(%ebp)
  800c36:	8d 45 14             	lea    0x14(%ebp),%eax
  800c39:	50                   	push   %eax
  800c3a:	e8 3c fd ff ff       	call   80097b <getint>
  800c3f:	83 c4 10             	add    $0x10,%esp
  800c42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c45:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c4e:	85 d2                	test   %edx,%edx
  800c50:	79 23                	jns    800c75 <vprintfmt+0x29b>
				putch('-', putdat);
  800c52:	83 ec 08             	sub    $0x8,%esp
  800c55:	ff 75 0c             	pushl  0xc(%ebp)
  800c58:	6a 2d                	push   $0x2d
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c68:	f7 d8                	neg    %eax
  800c6a:	83 d2 00             	adc    $0x0,%edx
  800c6d:	f7 da                	neg    %edx
  800c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c72:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c75:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c7c:	e9 bc 00 00 00       	jmp    800d3d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 e8             	pushl  -0x18(%ebp)
  800c87:	8d 45 14             	lea    0x14(%ebp),%eax
  800c8a:	50                   	push   %eax
  800c8b:	e8 84 fc ff ff       	call   800914 <getuint>
  800c90:	83 c4 10             	add    $0x10,%esp
  800c93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c96:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c99:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ca0:	e9 98 00 00 00       	jmp    800d3d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ca5:	83 ec 08             	sub    $0x8,%esp
  800ca8:	ff 75 0c             	pushl  0xc(%ebp)
  800cab:	6a 58                	push   $0x58
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	ff d0                	call   *%eax
  800cb2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cb5:	83 ec 08             	sub    $0x8,%esp
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	6a 58                	push   $0x58
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	ff d0                	call   *%eax
  800cc2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cc5:	83 ec 08             	sub    $0x8,%esp
  800cc8:	ff 75 0c             	pushl  0xc(%ebp)
  800ccb:	6a 58                	push   $0x58
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	ff d0                	call   *%eax
  800cd2:	83 c4 10             	add    $0x10,%esp
			break;
  800cd5:	e9 ce 00 00 00       	jmp    800da8 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	ff 75 0c             	pushl  0xc(%ebp)
  800ce0:	6a 30                	push   $0x30
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	ff d0                	call   *%eax
  800ce7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cea:	83 ec 08             	sub    $0x8,%esp
  800ced:	ff 75 0c             	pushl  0xc(%ebp)
  800cf0:	6a 78                	push   $0x78
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	ff d0                	call   *%eax
  800cf7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cfa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfd:	83 c0 04             	add    $0x4,%eax
  800d00:	89 45 14             	mov    %eax,0x14(%ebp)
  800d03:	8b 45 14             	mov    0x14(%ebp),%eax
  800d06:	83 e8 04             	sub    $0x4,%eax
  800d09:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d0e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d15:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d1c:	eb 1f                	jmp    800d3d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d1e:	83 ec 08             	sub    $0x8,%esp
  800d21:	ff 75 e8             	pushl  -0x18(%ebp)
  800d24:	8d 45 14             	lea    0x14(%ebp),%eax
  800d27:	50                   	push   %eax
  800d28:	e8 e7 fb ff ff       	call   800914 <getuint>
  800d2d:	83 c4 10             	add    $0x10,%esp
  800d30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d36:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d3d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d41:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d44:	83 ec 04             	sub    $0x4,%esp
  800d47:	52                   	push   %edx
  800d48:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d4b:	50                   	push   %eax
  800d4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d4f:	ff 75 f0             	pushl  -0x10(%ebp)
  800d52:	ff 75 0c             	pushl  0xc(%ebp)
  800d55:	ff 75 08             	pushl  0x8(%ebp)
  800d58:	e8 00 fb ff ff       	call   80085d <printnum>
  800d5d:	83 c4 20             	add    $0x20,%esp
			break;
  800d60:	eb 46                	jmp    800da8 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	53                   	push   %ebx
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	ff d0                	call   *%eax
  800d6e:	83 c4 10             	add    $0x10,%esp
			break;
  800d71:	eb 35                	jmp    800da8 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d73:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d7a:	eb 2c                	jmp    800da8 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d7c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d83:	eb 23                	jmp    800da8 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d85:	83 ec 08             	sub    $0x8,%esp
  800d88:	ff 75 0c             	pushl  0xc(%ebp)
  800d8b:	6a 25                	push   $0x25
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	ff d0                	call   *%eax
  800d92:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d95:	ff 4d 10             	decl   0x10(%ebp)
  800d98:	eb 03                	jmp    800d9d <vprintfmt+0x3c3>
  800d9a:	ff 4d 10             	decl   0x10(%ebp)
  800d9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800da0:	48                   	dec    %eax
  800da1:	8a 00                	mov    (%eax),%al
  800da3:	3c 25                	cmp    $0x25,%al
  800da5:	75 f3                	jne    800d9a <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800da7:	90                   	nop
		}
	}
  800da8:	e9 35 fc ff ff       	jmp    8009e2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dad:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dae:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800db1:	5b                   	pop    %ebx
  800db2:	5e                   	pop    %esi
  800db3:	5d                   	pop    %ebp
  800db4:	c3                   	ret    

00800db5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dbb:	8d 45 10             	lea    0x10(%ebp),%eax
  800dbe:	83 c0 04             	add    $0x4,%eax
  800dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800dca:	50                   	push   %eax
  800dcb:	ff 75 0c             	pushl  0xc(%ebp)
  800dce:	ff 75 08             	pushl  0x8(%ebp)
  800dd1:	e8 04 fc ff ff       	call   8009da <vprintfmt>
  800dd6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dd9:	90                   	nop
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	8b 40 08             	mov    0x8(%eax),%eax
  800de5:	8d 50 01             	lea    0x1(%eax),%edx
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	8b 10                	mov    (%eax),%edx
  800df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df6:	8b 40 04             	mov    0x4(%eax),%eax
  800df9:	39 c2                	cmp    %eax,%edx
  800dfb:	73 12                	jae    800e0f <sprintputch+0x33>
		*b->buf++ = ch;
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	8b 00                	mov    (%eax),%eax
  800e02:	8d 48 01             	lea    0x1(%eax),%ecx
  800e05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e08:	89 0a                	mov    %ecx,(%edx)
  800e0a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e0d:	88 10                	mov    %dl,(%eax)
}
  800e0f:	90                   	nop
  800e10:	5d                   	pop    %ebp
  800e11:	c3                   	ret    

00800e12 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e12:	55                   	push   %ebp
  800e13:	89 e5                	mov    %esp,%ebp
  800e15:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	01 d0                	add    %edx,%eax
  800e29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e37:	74 06                	je     800e3f <vsnprintf+0x2d>
  800e39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3d:	7f 07                	jg     800e46 <vsnprintf+0x34>
		return -E_INVAL;
  800e3f:	b8 03 00 00 00       	mov    $0x3,%eax
  800e44:	eb 20                	jmp    800e66 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e46:	ff 75 14             	pushl  0x14(%ebp)
  800e49:	ff 75 10             	pushl  0x10(%ebp)
  800e4c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e4f:	50                   	push   %eax
  800e50:	68 dc 0d 80 00       	push   $0x800ddc
  800e55:	e8 80 fb ff ff       	call   8009da <vprintfmt>
  800e5a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e60:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e66:	c9                   	leave  
  800e67:	c3                   	ret    

00800e68 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e68:	55                   	push   %ebp
  800e69:	89 e5                	mov    %esp,%ebp
  800e6b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e6e:	8d 45 10             	lea    0x10(%ebp),%eax
  800e71:	83 c0 04             	add    $0x4,%eax
  800e74:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e77:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7a:	ff 75 f4             	pushl  -0xc(%ebp)
  800e7d:	50                   	push   %eax
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	ff 75 08             	pushl  0x8(%ebp)
  800e84:	e8 89 ff ff ff       	call   800e12 <vsnprintf>
  800e89:	83 c4 10             	add    $0x10,%esp
  800e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e92:	c9                   	leave  
  800e93:	c3                   	ret    

00800e94 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e94:	55                   	push   %ebp
  800e95:	89 e5                	mov    %esp,%ebp
  800e97:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ea1:	eb 06                	jmp    800ea9 <strlen+0x15>
		n++;
  800ea3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ea6:	ff 45 08             	incl   0x8(%ebp)
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	84 c0                	test   %al,%al
  800eb0:	75 f1                	jne    800ea3 <strlen+0xf>
		n++;
	return n;
  800eb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eb5:	c9                   	leave  
  800eb6:	c3                   	ret    

00800eb7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800eb7:	55                   	push   %ebp
  800eb8:	89 e5                	mov    %esp,%ebp
  800eba:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ebd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec4:	eb 09                	jmp    800ecf <strnlen+0x18>
		n++;
  800ec6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ec9:	ff 45 08             	incl   0x8(%ebp)
  800ecc:	ff 4d 0c             	decl   0xc(%ebp)
  800ecf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ed3:	74 09                	je     800ede <strnlen+0x27>
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	84 c0                	test   %al,%al
  800edc:	75 e8                	jne    800ec6 <strnlen+0xf>
		n++;
	return n;
  800ede:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
  800ee6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eef:	90                   	nop
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8d 50 01             	lea    0x1(%eax),%edx
  800ef6:	89 55 08             	mov    %edx,0x8(%ebp)
  800ef9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f02:	8a 12                	mov    (%edx),%dl
  800f04:	88 10                	mov    %dl,(%eax)
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	84 c0                	test   %al,%al
  800f0a:	75 e4                	jne    800ef0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f0f:	c9                   	leave  
  800f10:	c3                   	ret    

00800f11 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f11:	55                   	push   %ebp
  800f12:	89 e5                	mov    %esp,%ebp
  800f14:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f1d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f24:	eb 1f                	jmp    800f45 <strncpy+0x34>
		*dst++ = *src;
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	8d 50 01             	lea    0x1(%eax),%edx
  800f2c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f32:	8a 12                	mov    (%edx),%dl
  800f34:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	84 c0                	test   %al,%al
  800f3d:	74 03                	je     800f42 <strncpy+0x31>
			src++;
  800f3f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f42:	ff 45 fc             	incl   -0x4(%ebp)
  800f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f48:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f4b:	72 d9                	jb     800f26 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f50:	c9                   	leave  
  800f51:	c3                   	ret    

00800f52 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f5e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f62:	74 30                	je     800f94 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f64:	eb 16                	jmp    800f7c <strlcpy+0x2a>
			*dst++ = *src++;
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8d 50 01             	lea    0x1(%eax),%edx
  800f6c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f72:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f75:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f78:	8a 12                	mov    (%edx),%dl
  800f7a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f7c:	ff 4d 10             	decl   0x10(%ebp)
  800f7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f83:	74 09                	je     800f8e <strlcpy+0x3c>
  800f85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	84 c0                	test   %al,%al
  800f8c:	75 d8                	jne    800f66 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f94:	8b 55 08             	mov    0x8(%ebp),%edx
  800f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9a:	29 c2                	sub    %eax,%edx
  800f9c:	89 d0                	mov    %edx,%eax
}
  800f9e:	c9                   	leave  
  800f9f:	c3                   	ret    

00800fa0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fa3:	eb 06                	jmp    800fab <strcmp+0xb>
		p++, q++;
  800fa5:	ff 45 08             	incl   0x8(%ebp)
  800fa8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	84 c0                	test   %al,%al
  800fb2:	74 0e                	je     800fc2 <strcmp+0x22>
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 10                	mov    (%eax),%dl
  800fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbc:	8a 00                	mov    (%eax),%al
  800fbe:	38 c2                	cmp    %al,%dl
  800fc0:	74 e3                	je     800fa5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	0f b6 d0             	movzbl %al,%edx
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	0f b6 c0             	movzbl %al,%eax
  800fd2:	29 c2                	sub    %eax,%edx
  800fd4:	89 d0                	mov    %edx,%eax
}
  800fd6:	5d                   	pop    %ebp
  800fd7:	c3                   	ret    

00800fd8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fd8:	55                   	push   %ebp
  800fd9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fdb:	eb 09                	jmp    800fe6 <strncmp+0xe>
		n--, p++, q++;
  800fdd:	ff 4d 10             	decl   0x10(%ebp)
  800fe0:	ff 45 08             	incl   0x8(%ebp)
  800fe3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fe6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fea:	74 17                	je     801003 <strncmp+0x2b>
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	84 c0                	test   %al,%al
  800ff3:	74 0e                	je     801003 <strncmp+0x2b>
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 10                	mov    (%eax),%dl
  800ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	38 c2                	cmp    %al,%dl
  801001:	74 da                	je     800fdd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801003:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801007:	75 07                	jne    801010 <strncmp+0x38>
		return 0;
  801009:	b8 00 00 00 00       	mov    $0x0,%eax
  80100e:	eb 14                	jmp    801024 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	0f b6 d0             	movzbl %al,%edx
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	0f b6 c0             	movzbl %al,%eax
  801020:	29 c2                	sub    %eax,%edx
  801022:	89 d0                	mov    %edx,%eax
}
  801024:	5d                   	pop    %ebp
  801025:	c3                   	ret    

00801026 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801026:	55                   	push   %ebp
  801027:	89 e5                	mov    %esp,%ebp
  801029:	83 ec 04             	sub    $0x4,%esp
  80102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801032:	eb 12                	jmp    801046 <strchr+0x20>
		if (*s == c)
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80103c:	75 05                	jne    801043 <strchr+0x1d>
			return (char *) s;
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	eb 11                	jmp    801054 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801043:	ff 45 08             	incl   0x8(%ebp)
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8a 00                	mov    (%eax),%al
  80104b:	84 c0                	test   %al,%al
  80104d:	75 e5                	jne    801034 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80104f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 04             	sub    $0x4,%esp
  80105c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801062:	eb 0d                	jmp    801071 <strfind+0x1b>
		if (*s == c)
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80106c:	74 0e                	je     80107c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80106e:	ff 45 08             	incl   0x8(%ebp)
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	84 c0                	test   %al,%al
  801078:	75 ea                	jne    801064 <strfind+0xe>
  80107a:	eb 01                	jmp    80107d <strfind+0x27>
		if (*s == c)
			break;
  80107c:	90                   	nop
	return (char *) s;
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801080:	c9                   	leave  
  801081:	c3                   	ret    

00801082 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801082:	55                   	push   %ebp
  801083:	89 e5                	mov    %esp,%ebp
  801085:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  80108e:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801092:	76 63                	jbe    8010f7 <memset+0x75>
		uint64 data_block = c;
  801094:	8b 45 0c             	mov    0xc(%ebp),%eax
  801097:	99                   	cltd   
  801098:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80109b:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  80109e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a4:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010a8:	c1 e0 08             	shl    $0x8,%eax
  8010ab:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010ae:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b7:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010bb:	c1 e0 10             	shl    $0x10,%eax
  8010be:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010c1:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ca:	89 c2                	mov    %eax,%edx
  8010cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8010d1:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010d4:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8010d7:	eb 18                	jmp    8010f1 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8010d9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010dc:	8d 41 08             	lea    0x8(%ecx),%eax
  8010df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8010e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e8:	89 01                	mov    %eax,(%ecx)
  8010ea:	89 51 04             	mov    %edx,0x4(%ecx)
  8010ed:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8010f1:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010f5:	77 e2                	ja     8010d9 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8010f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fb:	74 23                	je     801120 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8010fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801100:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801103:	eb 0e                	jmp    801113 <memset+0x91>
			*p8++ = (uint8)c;
  801105:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801108:	8d 50 01             	lea    0x1(%eax),%edx
  80110b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80110e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801111:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801113:	8b 45 10             	mov    0x10(%ebp),%eax
  801116:	8d 50 ff             	lea    -0x1(%eax),%edx
  801119:	89 55 10             	mov    %edx,0x10(%ebp)
  80111c:	85 c0                	test   %eax,%eax
  80111e:	75 e5                	jne    801105 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801123:	c9                   	leave  
  801124:	c3                   	ret    

00801125 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801137:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80113b:	76 24                	jbe    801161 <memcpy+0x3c>
		while(n >= 8){
  80113d:	eb 1c                	jmp    80115b <memcpy+0x36>
			*d64 = *s64;
  80113f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801142:	8b 50 04             	mov    0x4(%eax),%edx
  801145:	8b 00                	mov    (%eax),%eax
  801147:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80114a:	89 01                	mov    %eax,(%ecx)
  80114c:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80114f:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801153:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801157:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80115b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80115f:	77 de                	ja     80113f <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801161:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801165:	74 31                	je     801198 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801167:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80116d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801170:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801173:	eb 16                	jmp    80118b <memcpy+0x66>
			*d8++ = *s8++;
  801175:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801178:	8d 50 01             	lea    0x1(%eax),%edx
  80117b:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80117e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801181:	8d 4a 01             	lea    0x1(%edx),%ecx
  801184:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801187:	8a 12                	mov    (%edx),%dl
  801189:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  80118b:	8b 45 10             	mov    0x10(%ebp),%eax
  80118e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801191:	89 55 10             	mov    %edx,0x10(%ebp)
  801194:	85 c0                	test   %eax,%eax
  801196:	75 dd                	jne    801175 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80119b:	c9                   	leave  
  80119c:	c3                   	ret    

0080119d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80119d:	55                   	push   %ebp
  80119e:	89 e5                	mov    %esp,%ebp
  8011a0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011b5:	73 50                	jae    801207 <memmove+0x6a>
  8011b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bd:	01 d0                	add    %edx,%eax
  8011bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011c2:	76 43                	jbe    801207 <memmove+0x6a>
		s += n;
  8011c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8011cd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011d0:	eb 10                	jmp    8011e2 <memmove+0x45>
			*--d = *--s;
  8011d2:	ff 4d f8             	decl   -0x8(%ebp)
  8011d5:	ff 4d fc             	decl   -0x4(%ebp)
  8011d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011db:	8a 10                	mov    (%eax),%dl
  8011dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8011eb:	85 c0                	test   %eax,%eax
  8011ed:	75 e3                	jne    8011d2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011ef:	eb 23                	jmp    801214 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f4:	8d 50 01             	lea    0x1(%eax),%edx
  8011f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801200:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801203:	8a 12                	mov    (%edx),%dl
  801205:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80120d:	89 55 10             	mov    %edx,0x10(%ebp)
  801210:	85 c0                	test   %eax,%eax
  801212:	75 dd                	jne    8011f1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801217:	c9                   	leave  
  801218:	c3                   	ret    

00801219 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
  80121c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80122b:	eb 2a                	jmp    801257 <memcmp+0x3e>
		if (*s1 != *s2)
  80122d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801230:	8a 10                	mov    (%eax),%dl
  801232:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	38 c2                	cmp    %al,%dl
  801239:	74 16                	je     801251 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80123b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123e:	8a 00                	mov    (%eax),%al
  801240:	0f b6 d0             	movzbl %al,%edx
  801243:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801246:	8a 00                	mov    (%eax),%al
  801248:	0f b6 c0             	movzbl %al,%eax
  80124b:	29 c2                	sub    %eax,%edx
  80124d:	89 d0                	mov    %edx,%eax
  80124f:	eb 18                	jmp    801269 <memcmp+0x50>
		s1++, s2++;
  801251:	ff 45 fc             	incl   -0x4(%ebp)
  801254:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801257:	8b 45 10             	mov    0x10(%ebp),%eax
  80125a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80125d:	89 55 10             	mov    %edx,0x10(%ebp)
  801260:	85 c0                	test   %eax,%eax
  801262:	75 c9                	jne    80122d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801264:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801269:	c9                   	leave  
  80126a:	c3                   	ret    

0080126b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
  80126e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801271:	8b 55 08             	mov    0x8(%ebp),%edx
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 d0                	add    %edx,%eax
  801279:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80127c:	eb 15                	jmp    801293 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	0f b6 d0             	movzbl %al,%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	0f b6 c0             	movzbl %al,%eax
  80128c:	39 c2                	cmp    %eax,%edx
  80128e:	74 0d                	je     80129d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801290:	ff 45 08             	incl   0x8(%ebp)
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801299:	72 e3                	jb     80127e <memfind+0x13>
  80129b:	eb 01                	jmp    80129e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80129d:	90                   	nop
	return (void *) s;
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a1:	c9                   	leave  
  8012a2:	c3                   	ret    

008012a3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012a3:	55                   	push   %ebp
  8012a4:	89 e5                	mov    %esp,%ebp
  8012a6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012b7:	eb 03                	jmp    8012bc <strtol+0x19>
		s++;
  8012b9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	3c 20                	cmp    $0x20,%al
  8012c3:	74 f4                	je     8012b9 <strtol+0x16>
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	8a 00                	mov    (%eax),%al
  8012ca:	3c 09                	cmp    $0x9,%al
  8012cc:	74 eb                	je     8012b9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	3c 2b                	cmp    $0x2b,%al
  8012d5:	75 05                	jne    8012dc <strtol+0x39>
		s++;
  8012d7:	ff 45 08             	incl   0x8(%ebp)
  8012da:	eb 13                	jmp    8012ef <strtol+0x4c>
	else if (*s == '-')
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	3c 2d                	cmp    $0x2d,%al
  8012e3:	75 0a                	jne    8012ef <strtol+0x4c>
		s++, neg = 1;
  8012e5:	ff 45 08             	incl   0x8(%ebp)
  8012e8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012f3:	74 06                	je     8012fb <strtol+0x58>
  8012f5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012f9:	75 20                	jne    80131b <strtol+0x78>
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	3c 30                	cmp    $0x30,%al
  801302:	75 17                	jne    80131b <strtol+0x78>
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	40                   	inc    %eax
  801308:	8a 00                	mov    (%eax),%al
  80130a:	3c 78                	cmp    $0x78,%al
  80130c:	75 0d                	jne    80131b <strtol+0x78>
		s += 2, base = 16;
  80130e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801312:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801319:	eb 28                	jmp    801343 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80131b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80131f:	75 15                	jne    801336 <strtol+0x93>
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	3c 30                	cmp    $0x30,%al
  801328:	75 0c                	jne    801336 <strtol+0x93>
		s++, base = 8;
  80132a:	ff 45 08             	incl   0x8(%ebp)
  80132d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801334:	eb 0d                	jmp    801343 <strtol+0xa0>
	else if (base == 0)
  801336:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133a:	75 07                	jne    801343 <strtol+0xa0>
		base = 10;
  80133c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	3c 2f                	cmp    $0x2f,%al
  80134a:	7e 19                	jle    801365 <strtol+0xc2>
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	8a 00                	mov    (%eax),%al
  801351:	3c 39                	cmp    $0x39,%al
  801353:	7f 10                	jg     801365 <strtol+0xc2>
			dig = *s - '0';
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	0f be c0             	movsbl %al,%eax
  80135d:	83 e8 30             	sub    $0x30,%eax
  801360:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801363:	eb 42                	jmp    8013a7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8a 00                	mov    (%eax),%al
  80136a:	3c 60                	cmp    $0x60,%al
  80136c:	7e 19                	jle    801387 <strtol+0xe4>
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	8a 00                	mov    (%eax),%al
  801373:	3c 7a                	cmp    $0x7a,%al
  801375:	7f 10                	jg     801387 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 00                	mov    (%eax),%al
  80137c:	0f be c0             	movsbl %al,%eax
  80137f:	83 e8 57             	sub    $0x57,%eax
  801382:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801385:	eb 20                	jmp    8013a7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	3c 40                	cmp    $0x40,%al
  80138e:	7e 39                	jle    8013c9 <strtol+0x126>
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	3c 5a                	cmp    $0x5a,%al
  801397:	7f 30                	jg     8013c9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	0f be c0             	movsbl %al,%eax
  8013a1:	83 e8 37             	sub    $0x37,%eax
  8013a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013aa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ad:	7d 19                	jge    8013c8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013af:	ff 45 08             	incl   0x8(%ebp)
  8013b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013b5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013b9:	89 c2                	mov    %eax,%edx
  8013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013be:	01 d0                	add    %edx,%eax
  8013c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013c3:	e9 7b ff ff ff       	jmp    801343 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013c8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013cd:	74 08                	je     8013d7 <strtol+0x134>
		*endptr = (char *) s;
  8013cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8013d5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013db:	74 07                	je     8013e4 <strtol+0x141>
  8013dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e0:	f7 d8                	neg    %eax
  8013e2:	eb 03                	jmp    8013e7 <strtol+0x144>
  8013e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <ltostr>:

void
ltostr(long value, char *str)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
  8013ec:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801401:	79 13                	jns    801416 <ltostr+0x2d>
	{
		neg = 1;
  801403:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80140a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801410:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801413:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80141e:	99                   	cltd   
  80141f:	f7 f9                	idiv   %ecx
  801421:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801424:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801427:	8d 50 01             	lea    0x1(%eax),%edx
  80142a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80142d:	89 c2                	mov    %eax,%edx
  80142f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801432:	01 d0                	add    %edx,%eax
  801434:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801437:	83 c2 30             	add    $0x30,%edx
  80143a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80143c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80143f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801444:	f7 e9                	imul   %ecx
  801446:	c1 fa 02             	sar    $0x2,%edx
  801449:	89 c8                	mov    %ecx,%eax
  80144b:	c1 f8 1f             	sar    $0x1f,%eax
  80144e:	29 c2                	sub    %eax,%edx
  801450:	89 d0                	mov    %edx,%eax
  801452:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801455:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801459:	75 bb                	jne    801416 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80145b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801462:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801465:	48                   	dec    %eax
  801466:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801469:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80146d:	74 3d                	je     8014ac <ltostr+0xc3>
		start = 1 ;
  80146f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801476:	eb 34                	jmp    8014ac <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801478:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80147b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147e:	01 d0                	add    %edx,%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801485:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801488:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148b:	01 c2                	add    %eax,%edx
  80148d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801490:	8b 45 0c             	mov    0xc(%ebp),%eax
  801493:	01 c8                	add    %ecx,%eax
  801495:	8a 00                	mov    (%eax),%al
  801497:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801499:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	01 c2                	add    %eax,%edx
  8014a1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014a4:	88 02                	mov    %al,(%edx)
		start++ ;
  8014a6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014a9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014b2:	7c c4                	jl     801478 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ba:	01 d0                	add    %edx,%eax
  8014bc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014bf:	90                   	nop
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
  8014c5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014c8:	ff 75 08             	pushl  0x8(%ebp)
  8014cb:	e8 c4 f9 ff ff       	call   800e94 <strlen>
  8014d0:	83 c4 04             	add    $0x4,%esp
  8014d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014d6:	ff 75 0c             	pushl  0xc(%ebp)
  8014d9:	e8 b6 f9 ff ff       	call   800e94 <strlen>
  8014de:	83 c4 04             	add    $0x4,%esp
  8014e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014f2:	eb 17                	jmp    80150b <strcconcat+0x49>
		final[s] = str1[s] ;
  8014f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fa:	01 c2                	add    %eax,%edx
  8014fc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	01 c8                	add    %ecx,%eax
  801504:	8a 00                	mov    (%eax),%al
  801506:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801508:	ff 45 fc             	incl   -0x4(%ebp)
  80150b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801511:	7c e1                	jl     8014f4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801513:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80151a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801521:	eb 1f                	jmp    801542 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801523:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801526:	8d 50 01             	lea    0x1(%eax),%edx
  801529:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80152c:	89 c2                	mov    %eax,%edx
  80152e:	8b 45 10             	mov    0x10(%ebp),%eax
  801531:	01 c2                	add    %eax,%edx
  801533:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801536:	8b 45 0c             	mov    0xc(%ebp),%eax
  801539:	01 c8                	add    %ecx,%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80153f:	ff 45 f8             	incl   -0x8(%ebp)
  801542:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801545:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801548:	7c d9                	jl     801523 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80154a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154d:	8b 45 10             	mov    0x10(%ebp),%eax
  801550:	01 d0                	add    %edx,%eax
  801552:	c6 00 00             	movb   $0x0,(%eax)
}
  801555:	90                   	nop
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80155b:	8b 45 14             	mov    0x14(%ebp),%eax
  80155e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801564:	8b 45 14             	mov    0x14(%ebp),%eax
  801567:	8b 00                	mov    (%eax),%eax
  801569:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801570:	8b 45 10             	mov    0x10(%ebp),%eax
  801573:	01 d0                	add    %edx,%eax
  801575:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80157b:	eb 0c                	jmp    801589 <strsplit+0x31>
			*string++ = 0;
  80157d:	8b 45 08             	mov    0x8(%ebp),%eax
  801580:	8d 50 01             	lea    0x1(%eax),%edx
  801583:	89 55 08             	mov    %edx,0x8(%ebp)
  801586:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	84 c0                	test   %al,%al
  801590:	74 18                	je     8015aa <strsplit+0x52>
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	8a 00                	mov    (%eax),%al
  801597:	0f be c0             	movsbl %al,%eax
  80159a:	50                   	push   %eax
  80159b:	ff 75 0c             	pushl  0xc(%ebp)
  80159e:	e8 83 fa ff ff       	call   801026 <strchr>
  8015a3:	83 c4 08             	add    $0x8,%esp
  8015a6:	85 c0                	test   %eax,%eax
  8015a8:	75 d3                	jne    80157d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	84 c0                	test   %al,%al
  8015b1:	74 5a                	je     80160d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b6:	8b 00                	mov    (%eax),%eax
  8015b8:	83 f8 0f             	cmp    $0xf,%eax
  8015bb:	75 07                	jne    8015c4 <strsplit+0x6c>
		{
			return 0;
  8015bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8015c2:	eb 66                	jmp    80162a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c7:	8b 00                	mov    (%eax),%eax
  8015c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8015cc:	8b 55 14             	mov    0x14(%ebp),%edx
  8015cf:	89 0a                	mov    %ecx,(%edx)
  8015d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015db:	01 c2                	add    %eax,%edx
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015e2:	eb 03                	jmp    8015e7 <strsplit+0x8f>
			string++;
  8015e4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	84 c0                	test   %al,%al
  8015ee:	74 8b                	je     80157b <strsplit+0x23>
  8015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f3:	8a 00                	mov    (%eax),%al
  8015f5:	0f be c0             	movsbl %al,%eax
  8015f8:	50                   	push   %eax
  8015f9:	ff 75 0c             	pushl  0xc(%ebp)
  8015fc:	e8 25 fa ff ff       	call   801026 <strchr>
  801601:	83 c4 08             	add    $0x8,%esp
  801604:	85 c0                	test   %eax,%eax
  801606:	74 dc                	je     8015e4 <strsplit+0x8c>
			string++;
	}
  801608:	e9 6e ff ff ff       	jmp    80157b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80160d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80160e:	8b 45 14             	mov    0x14(%ebp),%eax
  801611:	8b 00                	mov    (%eax),%eax
  801613:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80161a:	8b 45 10             	mov    0x10(%ebp),%eax
  80161d:	01 d0                	add    %edx,%eax
  80161f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801625:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
  80162f:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801638:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80163f:	eb 4a                	jmp    80168b <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801641:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	01 c2                	add    %eax,%edx
  801649:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80164c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164f:	01 c8                	add    %ecx,%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801655:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801658:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165b:	01 d0                	add    %edx,%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	3c 40                	cmp    $0x40,%al
  801661:	7e 25                	jle    801688 <str2lower+0x5c>
  801663:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801666:	8b 45 0c             	mov    0xc(%ebp),%eax
  801669:	01 d0                	add    %edx,%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 5a                	cmp    $0x5a,%al
  80166f:	7f 17                	jg     801688 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801671:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	01 d0                	add    %edx,%eax
  801679:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80167c:	8b 55 08             	mov    0x8(%ebp),%edx
  80167f:	01 ca                	add    %ecx,%edx
  801681:	8a 12                	mov    (%edx),%dl
  801683:	83 c2 20             	add    $0x20,%edx
  801686:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801688:	ff 45 fc             	incl   -0x4(%ebp)
  80168b:	ff 75 0c             	pushl  0xc(%ebp)
  80168e:	e8 01 f8 ff ff       	call   800e94 <strlen>
  801693:	83 c4 04             	add    $0x4,%esp
  801696:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801699:	7f a6                	jg     801641 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80169b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80169e:	c9                   	leave  
  80169f:	c3                   	ret    

008016a0 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
  8016a3:	57                   	push   %edi
  8016a4:	56                   	push   %esi
  8016a5:	53                   	push   %ebx
  8016a6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016b8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016bb:	cd 30                	int    $0x30
  8016bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016c3:	83 c4 10             	add    $0x10,%esp
  8016c6:	5b                   	pop    %ebx
  8016c7:	5e                   	pop    %esi
  8016c8:	5f                   	pop    %edi
  8016c9:	5d                   	pop    %ebp
  8016ca:	c3                   	ret    

008016cb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
  8016ce:	83 ec 04             	sub    $0x4,%esp
  8016d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016d7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016da:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	51                   	push   %ecx
  8016e4:	52                   	push   %edx
  8016e5:	ff 75 0c             	pushl  0xc(%ebp)
  8016e8:	50                   	push   %eax
  8016e9:	6a 00                	push   $0x0
  8016eb:	e8 b0 ff ff ff       	call   8016a0 <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
}
  8016f3:	90                   	nop
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 02                	push   $0x2
  801705:	e8 96 ff ff ff       	call   8016a0 <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <sys_lock_cons>:

void sys_lock_cons(void)
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 03                	push   $0x3
  80171e:	e8 7d ff ff ff       	call   8016a0 <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	90                   	nop
  801727:	c9                   	leave  
  801728:	c3                   	ret    

00801729 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 04                	push   $0x4
  801738:	e8 63 ff ff ff       	call   8016a0 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
}
  801740:	90                   	nop
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801746:	8b 55 0c             	mov    0xc(%ebp),%edx
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	52                   	push   %edx
  801753:	50                   	push   %eax
  801754:	6a 08                	push   $0x8
  801756:	e8 45 ff ff ff       	call   8016a0 <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
  801763:	56                   	push   %esi
  801764:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801765:	8b 75 18             	mov    0x18(%ebp),%esi
  801768:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80176b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80176e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	56                   	push   %esi
  801775:	53                   	push   %ebx
  801776:	51                   	push   %ecx
  801777:	52                   	push   %edx
  801778:	50                   	push   %eax
  801779:	6a 09                	push   $0x9
  80177b:	e8 20 ff ff ff       	call   8016a0 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801786:	5b                   	pop    %ebx
  801787:	5e                   	pop    %esi
  801788:	5d                   	pop    %ebp
  801789:	c3                   	ret    

0080178a <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	ff 75 08             	pushl  0x8(%ebp)
  801798:	6a 0a                	push   $0xa
  80179a:	e8 01 ff ff ff       	call   8016a0 <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	ff 75 0c             	pushl  0xc(%ebp)
  8017b0:	ff 75 08             	pushl  0x8(%ebp)
  8017b3:	6a 0b                	push   $0xb
  8017b5:	e8 e6 fe ff ff       	call   8016a0 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
}
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 0c                	push   $0xc
  8017ce:	e8 cd fe ff ff       	call   8016a0 <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 0d                	push   $0xd
  8017e7:	e8 b4 fe ff ff       	call   8016a0 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 0e                	push   $0xe
  801800:	e8 9b fe ff ff       	call   8016a0 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 0f                	push   $0xf
  801819:	e8 82 fe ff ff       	call   8016a0 <syscall>
  80181e:	83 c4 18             	add    $0x18,%esp
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	ff 75 08             	pushl  0x8(%ebp)
  801831:	6a 10                	push   $0x10
  801833:	e8 68 fe ff ff       	call   8016a0 <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 11                	push   $0x11
  80184c:	e8 4f fe ff ff       	call   8016a0 <syscall>
  801851:	83 c4 18             	add    $0x18,%esp
}
  801854:	90                   	nop
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_cputc>:

void
sys_cputc(const char c)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
  80185a:	83 ec 04             	sub    $0x4,%esp
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801863:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	50                   	push   %eax
  801870:	6a 01                	push   $0x1
  801872:	e8 29 fe ff ff       	call   8016a0 <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	90                   	nop
  80187b:	c9                   	leave  
  80187c:	c3                   	ret    

0080187d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80187d:	55                   	push   %ebp
  80187e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 14                	push   $0x14
  80188c:	e8 0f fe ff ff       	call   8016a0 <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	90                   	nop
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 04             	sub    $0x4,%esp
  80189d:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018a3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018a6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	6a 00                	push   $0x0
  8018af:	51                   	push   %ecx
  8018b0:	52                   	push   %edx
  8018b1:	ff 75 0c             	pushl  0xc(%ebp)
  8018b4:	50                   	push   %eax
  8018b5:	6a 15                	push   $0x15
  8018b7:	e8 e4 fd ff ff       	call   8016a0 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018c4:	8b 55 10             	mov    0x10(%ebp),%edx
  8018c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	52                   	push   %edx
  8018cf:	50                   	push   %eax
  8018d0:	ff 75 08             	pushl  0x8(%ebp)
  8018d3:	6a 16                	push   $0x16
  8018d5:	e8 c6 fd ff ff       	call   8016a0 <syscall>
  8018da:	83 c4 18             	add    $0x18,%esp
}
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	52                   	push   %edx
  8018ef:	50                   	push   %eax
  8018f0:	6a 17                	push   $0x17
  8018f2:	e8 a9 fd ff ff       	call   8016a0 <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
}
  8018fa:	c9                   	leave  
  8018fb:	c3                   	ret    

008018fc <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8018fc:	55                   	push   %ebp
  8018fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801902:	8b 45 08             	mov    0x8(%ebp),%eax
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	52                   	push   %edx
  80190c:	50                   	push   %eax
  80190d:	6a 18                	push   $0x18
  80190f:	e8 8c fd ff ff       	call   8016a0 <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	6a 00                	push   $0x0
  801921:	ff 75 14             	pushl  0x14(%ebp)
  801924:	ff 75 10             	pushl  0x10(%ebp)
  801927:	ff 75 0c             	pushl  0xc(%ebp)
  80192a:	50                   	push   %eax
  80192b:	6a 19                	push   $0x19
  80192d:	e8 6e fd ff ff       	call   8016a0 <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
}
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80193a:	8b 45 08             	mov    0x8(%ebp),%eax
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	50                   	push   %eax
  801946:	6a 1a                	push   $0x1a
  801948:	e8 53 fd ff ff       	call   8016a0 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	90                   	nop
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	50                   	push   %eax
  801962:	6a 1b                	push   $0x1b
  801964:	e8 37 fd ff ff       	call   8016a0 <syscall>
  801969:	83 c4 18             	add    $0x18,%esp
}
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 05                	push   $0x5
  80197d:	e8 1e fd ff ff       	call   8016a0 <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
}
  801985:	c9                   	leave  
  801986:	c3                   	ret    

00801987 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801987:	55                   	push   %ebp
  801988:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 06                	push   $0x6
  801996:	e8 05 fd ff ff       	call   8016a0 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
}
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 07                	push   $0x7
  8019af:	e8 ec fc ff ff       	call   8016a0 <syscall>
  8019b4:	83 c4 18             	add    $0x18,%esp
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_exit_env>:


void sys_exit_env(void)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 1c                	push   $0x1c
  8019c8:	e8 d3 fc ff ff       	call   8016a0 <syscall>
  8019cd:	83 c4 18             	add    $0x18,%esp
}
  8019d0:	90                   	nop
  8019d1:	c9                   	leave  
  8019d2:	c3                   	ret    

008019d3 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019d3:	55                   	push   %ebp
  8019d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	ff 75 10             	pushl  0x10(%ebp)
  8019dd:	ff 75 0c             	pushl  0xc(%ebp)
  8019e0:	ff 75 08             	pushl  0x8(%ebp)
  8019e3:	6a 13                	push   $0x13
  8019e5:	e8 b6 fc ff ff       	call   8016a0 <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ed:	90                   	nop
}
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 1e                	push   $0x1e
  8019ff:	e8 9c fc ff ff       	call   8016a0 <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
}
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
  801a0c:	83 ec 04             	sub    $0x4,%esp
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a15:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	50                   	push   %eax
  801a22:	6a 1f                	push   $0x1f
  801a24:	e8 77 fc ff ff       	call   8016a0 <syscall>
  801a29:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2c:	90                   	nop
}
  801a2d:	c9                   	leave  
  801a2e:	c3                   	ret    

00801a2f <rsttst>:
void rsttst()
{
  801a2f:	55                   	push   %ebp
  801a30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 21                	push   $0x21
  801a3e:	e8 5d fc ff ff       	call   8016a0 <syscall>
  801a43:	83 c4 18             	add    $0x18,%esp
	return ;
  801a46:	90                   	nop
}
  801a47:	c9                   	leave  
  801a48:	c3                   	ret    

00801a49 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
  801a4c:	83 ec 04             	sub    $0x4,%esp
  801a4f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a52:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a55:	8b 55 18             	mov    0x18(%ebp),%edx
  801a58:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a5c:	52                   	push   %edx
  801a5d:	50                   	push   %eax
  801a5e:	ff 75 10             	pushl  0x10(%ebp)
  801a61:	ff 75 0c             	pushl  0xc(%ebp)
  801a64:	ff 75 08             	pushl  0x8(%ebp)
  801a67:	6a 20                	push   $0x20
  801a69:	e8 32 fc ff ff       	call   8016a0 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a71:	90                   	nop
}
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <chktst>:
void chktst(uint32 n)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	ff 75 08             	pushl  0x8(%ebp)
  801a82:	6a 22                	push   $0x22
  801a84:	e8 17 fc ff ff       	call   8016a0 <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8c:	90                   	nop
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <inctst>:

void inctst()
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 23                	push   $0x23
  801a9e:	e8 fd fb ff ff       	call   8016a0 <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa6:	90                   	nop
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <gettst>:
uint32 gettst()
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 24                	push   $0x24
  801ab8:	e8 e3 fb ff ff       	call   8016a0 <syscall>
  801abd:	83 c4 18             	add    $0x18,%esp
}
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 25                	push   $0x25
  801ad1:	e8 ca fb ff ff       	call   8016a0 <syscall>
  801ad6:	83 c4 18             	add    $0x18,%esp
  801ad9:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801ade:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aeb:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	ff 75 08             	pushl  0x8(%ebp)
  801afb:	6a 26                	push   $0x26
  801afd:	e8 9e fb ff ff       	call   8016a0 <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
	return ;
  801b05:	90                   	nop
}
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
  801b0b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b0c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b15:	8b 45 08             	mov    0x8(%ebp),%eax
  801b18:	6a 00                	push   $0x0
  801b1a:	53                   	push   %ebx
  801b1b:	51                   	push   %ecx
  801b1c:	52                   	push   %edx
  801b1d:	50                   	push   %eax
  801b1e:	6a 27                	push   $0x27
  801b20:	e8 7b fb ff ff       	call   8016a0 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b2b:	c9                   	leave  
  801b2c:	c3                   	ret    

00801b2d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b2d:	55                   	push   %ebp
  801b2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b33:	8b 45 08             	mov    0x8(%ebp),%eax
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	52                   	push   %edx
  801b3d:	50                   	push   %eax
  801b3e:	6a 28                	push   $0x28
  801b40:	e8 5b fb ff ff       	call   8016a0 <syscall>
  801b45:	83 c4 18             	add    $0x18,%esp
}
  801b48:	c9                   	leave  
  801b49:	c3                   	ret    

00801b4a <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b4a:	55                   	push   %ebp
  801b4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b4d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	6a 00                	push   $0x0
  801b58:	51                   	push   %ecx
  801b59:	ff 75 10             	pushl  0x10(%ebp)
  801b5c:	52                   	push   %edx
  801b5d:	50                   	push   %eax
  801b5e:	6a 29                	push   $0x29
  801b60:	e8 3b fb ff ff       	call   8016a0 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
}
  801b68:	c9                   	leave  
  801b69:	c3                   	ret    

00801b6a <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	ff 75 10             	pushl  0x10(%ebp)
  801b74:	ff 75 0c             	pushl  0xc(%ebp)
  801b77:	ff 75 08             	pushl  0x8(%ebp)
  801b7a:	6a 12                	push   $0x12
  801b7c:	e8 1f fb ff ff       	call   8016a0 <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
	return ;
  801b84:	90                   	nop
}
  801b85:	c9                   	leave  
  801b86:	c3                   	ret    

00801b87 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	52                   	push   %edx
  801b97:	50                   	push   %eax
  801b98:	6a 2a                	push   $0x2a
  801b9a:	e8 01 fb ff ff       	call   8016a0 <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 2b                	push   $0x2b
  801bb4:	e8 e7 fa ff ff       	call   8016a0 <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
}
  801bbc:	c9                   	leave  
  801bbd:	c3                   	ret    

00801bbe <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bbe:	55                   	push   %ebp
  801bbf:	89 e5                	mov    %esp,%ebp
  801bc1:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bc4:	83 ec 04             	sub    $0x4,%esp
  801bc7:	68 48 28 80 00       	push   $0x802848
  801bcc:	68 0a 01 00 00       	push   $0x10a
  801bd1:	68 58 28 80 00       	push   $0x802858
  801bd6:	e8 12 e9 ff ff       	call   8004ed <_panic>

00801bdb <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801bdb:	55                   	push   %ebp
  801bdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	ff 75 0c             	pushl  0xc(%ebp)
  801be7:	ff 75 08             	pushl  0x8(%ebp)
  801bea:	6a 33                	push   $0x33
  801bec:	e8 af fa ff ff       	call   8016a0 <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
	return;
  801bf4:	90                   	nop
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	ff 75 0c             	pushl  0xc(%ebp)
  801c03:	ff 75 08             	pushl  0x8(%ebp)
  801c06:	6a 34                	push   $0x34
  801c08:	e8 93 fa ff ff       	call   8016a0 <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c10:	90                   	nop
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
  801c16:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c19:	8b 55 08             	mov    0x8(%ebp),%edx
  801c1c:	89 d0                	mov    %edx,%eax
  801c1e:	c1 e0 02             	shl    $0x2,%eax
  801c21:	01 d0                	add    %edx,%eax
  801c23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c2a:	01 d0                	add    %edx,%eax
  801c2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c33:	01 d0                	add    %edx,%eax
  801c35:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c3c:	01 d0                	add    %edx,%eax
  801c3e:	c1 e0 04             	shl    $0x4,%eax
  801c41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c44:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c4b:	0f 31                	rdtsc  
  801c4d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c50:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c53:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c56:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c5c:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c5f:	eb 46                	jmp    801ca7 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c61:	0f 31                	rdtsc  
  801c63:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c66:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c69:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c6c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c6f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801c72:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c75:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c7b:	29 c2                	sub    %eax,%edx
  801c7d:	89 d0                	mov    %edx,%eax
  801c7f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c82:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c88:	89 d1                	mov    %edx,%ecx
  801c8a:	29 c1                	sub    %eax,%ecx
  801c8c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c92:	39 c2                	cmp    %eax,%edx
  801c94:	0f 97 c0             	seta   %al
  801c97:	0f b6 c0             	movzbl %al,%eax
  801c9a:	29 c1                	sub    %eax,%ecx
  801c9c:	89 c8                	mov    %ecx,%eax
  801c9e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801ca1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ca4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ca7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801caa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801cad:	72 b2                	jb     801c61 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801caf:	90                   	nop
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
  801cb5:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cb8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cbf:	eb 03                	jmp    801cc4 <busy_wait+0x12>
  801cc1:	ff 45 fc             	incl   -0x4(%ebp)
  801cc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cc7:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cca:	72 f5                	jb     801cc1 <busy_wait+0xf>
	return i;
  801ccc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ccf:	c9                   	leave  
  801cd0:	c3                   	ret    
  801cd1:	66 90                	xchg   %ax,%ax
  801cd3:	90                   	nop

00801cd4 <__udivdi3>:
  801cd4:	55                   	push   %ebp
  801cd5:	57                   	push   %edi
  801cd6:	56                   	push   %esi
  801cd7:	53                   	push   %ebx
  801cd8:	83 ec 1c             	sub    $0x1c,%esp
  801cdb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cdf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ce3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ce7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ceb:	89 ca                	mov    %ecx,%edx
  801ced:	89 f8                	mov    %edi,%eax
  801cef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cf3:	85 f6                	test   %esi,%esi
  801cf5:	75 2d                	jne    801d24 <__udivdi3+0x50>
  801cf7:	39 cf                	cmp    %ecx,%edi
  801cf9:	77 65                	ja     801d60 <__udivdi3+0x8c>
  801cfb:	89 fd                	mov    %edi,%ebp
  801cfd:	85 ff                	test   %edi,%edi
  801cff:	75 0b                	jne    801d0c <__udivdi3+0x38>
  801d01:	b8 01 00 00 00       	mov    $0x1,%eax
  801d06:	31 d2                	xor    %edx,%edx
  801d08:	f7 f7                	div    %edi
  801d0a:	89 c5                	mov    %eax,%ebp
  801d0c:	31 d2                	xor    %edx,%edx
  801d0e:	89 c8                	mov    %ecx,%eax
  801d10:	f7 f5                	div    %ebp
  801d12:	89 c1                	mov    %eax,%ecx
  801d14:	89 d8                	mov    %ebx,%eax
  801d16:	f7 f5                	div    %ebp
  801d18:	89 cf                	mov    %ecx,%edi
  801d1a:	89 fa                	mov    %edi,%edx
  801d1c:	83 c4 1c             	add    $0x1c,%esp
  801d1f:	5b                   	pop    %ebx
  801d20:	5e                   	pop    %esi
  801d21:	5f                   	pop    %edi
  801d22:	5d                   	pop    %ebp
  801d23:	c3                   	ret    
  801d24:	39 ce                	cmp    %ecx,%esi
  801d26:	77 28                	ja     801d50 <__udivdi3+0x7c>
  801d28:	0f bd fe             	bsr    %esi,%edi
  801d2b:	83 f7 1f             	xor    $0x1f,%edi
  801d2e:	75 40                	jne    801d70 <__udivdi3+0x9c>
  801d30:	39 ce                	cmp    %ecx,%esi
  801d32:	72 0a                	jb     801d3e <__udivdi3+0x6a>
  801d34:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d38:	0f 87 9e 00 00 00    	ja     801ddc <__udivdi3+0x108>
  801d3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d43:	89 fa                	mov    %edi,%edx
  801d45:	83 c4 1c             	add    $0x1c,%esp
  801d48:	5b                   	pop    %ebx
  801d49:	5e                   	pop    %esi
  801d4a:	5f                   	pop    %edi
  801d4b:	5d                   	pop    %ebp
  801d4c:	c3                   	ret    
  801d4d:	8d 76 00             	lea    0x0(%esi),%esi
  801d50:	31 ff                	xor    %edi,%edi
  801d52:	31 c0                	xor    %eax,%eax
  801d54:	89 fa                	mov    %edi,%edx
  801d56:	83 c4 1c             	add    $0x1c,%esp
  801d59:	5b                   	pop    %ebx
  801d5a:	5e                   	pop    %esi
  801d5b:	5f                   	pop    %edi
  801d5c:	5d                   	pop    %ebp
  801d5d:	c3                   	ret    
  801d5e:	66 90                	xchg   %ax,%ax
  801d60:	89 d8                	mov    %ebx,%eax
  801d62:	f7 f7                	div    %edi
  801d64:	31 ff                	xor    %edi,%edi
  801d66:	89 fa                	mov    %edi,%edx
  801d68:	83 c4 1c             	add    $0x1c,%esp
  801d6b:	5b                   	pop    %ebx
  801d6c:	5e                   	pop    %esi
  801d6d:	5f                   	pop    %edi
  801d6e:	5d                   	pop    %ebp
  801d6f:	c3                   	ret    
  801d70:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d75:	89 eb                	mov    %ebp,%ebx
  801d77:	29 fb                	sub    %edi,%ebx
  801d79:	89 f9                	mov    %edi,%ecx
  801d7b:	d3 e6                	shl    %cl,%esi
  801d7d:	89 c5                	mov    %eax,%ebp
  801d7f:	88 d9                	mov    %bl,%cl
  801d81:	d3 ed                	shr    %cl,%ebp
  801d83:	89 e9                	mov    %ebp,%ecx
  801d85:	09 f1                	or     %esi,%ecx
  801d87:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d8b:	89 f9                	mov    %edi,%ecx
  801d8d:	d3 e0                	shl    %cl,%eax
  801d8f:	89 c5                	mov    %eax,%ebp
  801d91:	89 d6                	mov    %edx,%esi
  801d93:	88 d9                	mov    %bl,%cl
  801d95:	d3 ee                	shr    %cl,%esi
  801d97:	89 f9                	mov    %edi,%ecx
  801d99:	d3 e2                	shl    %cl,%edx
  801d9b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d9f:	88 d9                	mov    %bl,%cl
  801da1:	d3 e8                	shr    %cl,%eax
  801da3:	09 c2                	or     %eax,%edx
  801da5:	89 d0                	mov    %edx,%eax
  801da7:	89 f2                	mov    %esi,%edx
  801da9:	f7 74 24 0c          	divl   0xc(%esp)
  801dad:	89 d6                	mov    %edx,%esi
  801daf:	89 c3                	mov    %eax,%ebx
  801db1:	f7 e5                	mul    %ebp
  801db3:	39 d6                	cmp    %edx,%esi
  801db5:	72 19                	jb     801dd0 <__udivdi3+0xfc>
  801db7:	74 0b                	je     801dc4 <__udivdi3+0xf0>
  801db9:	89 d8                	mov    %ebx,%eax
  801dbb:	31 ff                	xor    %edi,%edi
  801dbd:	e9 58 ff ff ff       	jmp    801d1a <__udivdi3+0x46>
  801dc2:	66 90                	xchg   %ax,%ax
  801dc4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dc8:	89 f9                	mov    %edi,%ecx
  801dca:	d3 e2                	shl    %cl,%edx
  801dcc:	39 c2                	cmp    %eax,%edx
  801dce:	73 e9                	jae    801db9 <__udivdi3+0xe5>
  801dd0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dd3:	31 ff                	xor    %edi,%edi
  801dd5:	e9 40 ff ff ff       	jmp    801d1a <__udivdi3+0x46>
  801dda:	66 90                	xchg   %ax,%ax
  801ddc:	31 c0                	xor    %eax,%eax
  801dde:	e9 37 ff ff ff       	jmp    801d1a <__udivdi3+0x46>
  801de3:	90                   	nop

00801de4 <__umoddi3>:
  801de4:	55                   	push   %ebp
  801de5:	57                   	push   %edi
  801de6:	56                   	push   %esi
  801de7:	53                   	push   %ebx
  801de8:	83 ec 1c             	sub    $0x1c,%esp
  801deb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801def:	8b 74 24 34          	mov    0x34(%esp),%esi
  801df3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801df7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801dfb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801dff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e03:	89 f3                	mov    %esi,%ebx
  801e05:	89 fa                	mov    %edi,%edx
  801e07:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e0b:	89 34 24             	mov    %esi,(%esp)
  801e0e:	85 c0                	test   %eax,%eax
  801e10:	75 1a                	jne    801e2c <__umoddi3+0x48>
  801e12:	39 f7                	cmp    %esi,%edi
  801e14:	0f 86 a2 00 00 00    	jbe    801ebc <__umoddi3+0xd8>
  801e1a:	89 c8                	mov    %ecx,%eax
  801e1c:	89 f2                	mov    %esi,%edx
  801e1e:	f7 f7                	div    %edi
  801e20:	89 d0                	mov    %edx,%eax
  801e22:	31 d2                	xor    %edx,%edx
  801e24:	83 c4 1c             	add    $0x1c,%esp
  801e27:	5b                   	pop    %ebx
  801e28:	5e                   	pop    %esi
  801e29:	5f                   	pop    %edi
  801e2a:	5d                   	pop    %ebp
  801e2b:	c3                   	ret    
  801e2c:	39 f0                	cmp    %esi,%eax
  801e2e:	0f 87 ac 00 00 00    	ja     801ee0 <__umoddi3+0xfc>
  801e34:	0f bd e8             	bsr    %eax,%ebp
  801e37:	83 f5 1f             	xor    $0x1f,%ebp
  801e3a:	0f 84 ac 00 00 00    	je     801eec <__umoddi3+0x108>
  801e40:	bf 20 00 00 00       	mov    $0x20,%edi
  801e45:	29 ef                	sub    %ebp,%edi
  801e47:	89 fe                	mov    %edi,%esi
  801e49:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e4d:	89 e9                	mov    %ebp,%ecx
  801e4f:	d3 e0                	shl    %cl,%eax
  801e51:	89 d7                	mov    %edx,%edi
  801e53:	89 f1                	mov    %esi,%ecx
  801e55:	d3 ef                	shr    %cl,%edi
  801e57:	09 c7                	or     %eax,%edi
  801e59:	89 e9                	mov    %ebp,%ecx
  801e5b:	d3 e2                	shl    %cl,%edx
  801e5d:	89 14 24             	mov    %edx,(%esp)
  801e60:	89 d8                	mov    %ebx,%eax
  801e62:	d3 e0                	shl    %cl,%eax
  801e64:	89 c2                	mov    %eax,%edx
  801e66:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6a:	d3 e0                	shl    %cl,%eax
  801e6c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e70:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e74:	89 f1                	mov    %esi,%ecx
  801e76:	d3 e8                	shr    %cl,%eax
  801e78:	09 d0                	or     %edx,%eax
  801e7a:	d3 eb                	shr    %cl,%ebx
  801e7c:	89 da                	mov    %ebx,%edx
  801e7e:	f7 f7                	div    %edi
  801e80:	89 d3                	mov    %edx,%ebx
  801e82:	f7 24 24             	mull   (%esp)
  801e85:	89 c6                	mov    %eax,%esi
  801e87:	89 d1                	mov    %edx,%ecx
  801e89:	39 d3                	cmp    %edx,%ebx
  801e8b:	0f 82 87 00 00 00    	jb     801f18 <__umoddi3+0x134>
  801e91:	0f 84 91 00 00 00    	je     801f28 <__umoddi3+0x144>
  801e97:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e9b:	29 f2                	sub    %esi,%edx
  801e9d:	19 cb                	sbb    %ecx,%ebx
  801e9f:	89 d8                	mov    %ebx,%eax
  801ea1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ea5:	d3 e0                	shl    %cl,%eax
  801ea7:	89 e9                	mov    %ebp,%ecx
  801ea9:	d3 ea                	shr    %cl,%edx
  801eab:	09 d0                	or     %edx,%eax
  801ead:	89 e9                	mov    %ebp,%ecx
  801eaf:	d3 eb                	shr    %cl,%ebx
  801eb1:	89 da                	mov    %ebx,%edx
  801eb3:	83 c4 1c             	add    $0x1c,%esp
  801eb6:	5b                   	pop    %ebx
  801eb7:	5e                   	pop    %esi
  801eb8:	5f                   	pop    %edi
  801eb9:	5d                   	pop    %ebp
  801eba:	c3                   	ret    
  801ebb:	90                   	nop
  801ebc:	89 fd                	mov    %edi,%ebp
  801ebe:	85 ff                	test   %edi,%edi
  801ec0:	75 0b                	jne    801ecd <__umoddi3+0xe9>
  801ec2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ec7:	31 d2                	xor    %edx,%edx
  801ec9:	f7 f7                	div    %edi
  801ecb:	89 c5                	mov    %eax,%ebp
  801ecd:	89 f0                	mov    %esi,%eax
  801ecf:	31 d2                	xor    %edx,%edx
  801ed1:	f7 f5                	div    %ebp
  801ed3:	89 c8                	mov    %ecx,%eax
  801ed5:	f7 f5                	div    %ebp
  801ed7:	89 d0                	mov    %edx,%eax
  801ed9:	e9 44 ff ff ff       	jmp    801e22 <__umoddi3+0x3e>
  801ede:	66 90                	xchg   %ax,%ax
  801ee0:	89 c8                	mov    %ecx,%eax
  801ee2:	89 f2                	mov    %esi,%edx
  801ee4:	83 c4 1c             	add    $0x1c,%esp
  801ee7:	5b                   	pop    %ebx
  801ee8:	5e                   	pop    %esi
  801ee9:	5f                   	pop    %edi
  801eea:	5d                   	pop    %ebp
  801eeb:	c3                   	ret    
  801eec:	3b 04 24             	cmp    (%esp),%eax
  801eef:	72 06                	jb     801ef7 <__umoddi3+0x113>
  801ef1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ef5:	77 0f                	ja     801f06 <__umoddi3+0x122>
  801ef7:	89 f2                	mov    %esi,%edx
  801ef9:	29 f9                	sub    %edi,%ecx
  801efb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eff:	89 14 24             	mov    %edx,(%esp)
  801f02:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f06:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f0a:	8b 14 24             	mov    (%esp),%edx
  801f0d:	83 c4 1c             	add    $0x1c,%esp
  801f10:	5b                   	pop    %ebx
  801f11:	5e                   	pop    %esi
  801f12:	5f                   	pop    %edi
  801f13:	5d                   	pop    %ebp
  801f14:	c3                   	ret    
  801f15:	8d 76 00             	lea    0x0(%esi),%esi
  801f18:	2b 04 24             	sub    (%esp),%eax
  801f1b:	19 fa                	sbb    %edi,%edx
  801f1d:	89 d1                	mov    %edx,%ecx
  801f1f:	89 c6                	mov    %eax,%esi
  801f21:	e9 71 ff ff ff       	jmp    801e97 <__umoddi3+0xb3>
  801f26:	66 90                	xchg   %ax,%ax
  801f28:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f2c:	72 ea                	jb     801f18 <__umoddi3+0x134>
  801f2e:	89 d9                	mov    %ebx,%ecx
  801f30:	e9 62 ff ff ff       	jmp    801e97 <__umoddi3+0xb3>
