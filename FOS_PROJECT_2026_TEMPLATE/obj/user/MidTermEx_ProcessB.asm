
obj/user/MidTermEx_ProcessB:     file format elf32-i386


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
  800031:	e8 6c 02 00 00       	call   8002a2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
extern volatile bool printStats;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 68             	sub    $0x68,%esp
	printStats = 0;
  80003e:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  800045:	00 00 00 

	int32 parentenvID = sys_getparentenvid();
  800048:	e8 a2 18 00 00       	call   8018ef <sys_getparentenvid>
  80004d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800050:	83 ec 08             	sub    $0x8,%esp
  800053:	68 a0 22 80 00       	push   $0x8022a0
  800058:	ff 75 ec             	pushl  -0x14(%ebp)
  80005b:	e8 56 15 00 00       	call   8015b6 <sget>
  800060:	83 c4 10             	add    $0x10,%esp
  800063:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int *protType = sget(parentenvID, "protType") ;
  800066:	83 ec 08             	sub    $0x8,%esp
  800069:	68 a2 22 80 00       	push   $0x8022a2
  80006e:	ff 75 ec             	pushl  -0x14(%ebp)
  800071:	e8 40 15 00 00       	call   8015b6 <sget>
  800076:	83 c4 10             	add    $0x10,%esp
  800079:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int * finishedCount = sget(parentenvID, "finishedCount") ;
  80007c:	83 ec 08             	sub    $0x8,%esp
  80007f:	68 ab 22 80 00       	push   $0x8022ab
  800084:	ff 75 ec             	pushl  -0x14(%ebp)
  800087:	e8 2a 15 00 00       	call   8015b6 <sget>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 e0             	mov    %eax,-0x20(%ebp)
	struct semaphore T, finished, finishedCountMutex ;
	struct uspinlock *sT, *sfinishedCountMutex;

	if (*protType == 1)
  800092:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800095:	8b 00                	mov    (%eax),%eax
  800097:	83 f8 01             	cmp    $0x1,%eax
  80009a:	75 47                	jne    8000e3 <_main+0xab>
	{
		T = get_semaphore(parentenvID, "T");
  80009c:	8d 45 bc             	lea    -0x44(%ebp),%eax
  80009f:	83 ec 04             	sub    $0x4,%esp
  8000a2:	68 b9 22 80 00       	push   $0x8022b9
  8000a7:	ff 75 ec             	pushl  -0x14(%ebp)
  8000aa:	50                   	push   %eax
  8000ab:	e8 be 1b 00 00       	call   801c6e <get_semaphore>
  8000b0:	83 c4 0c             	add    $0xc,%esp
		finished = get_semaphore(parentenvID, "finished");
  8000b3:	8d 45 b8             	lea    -0x48(%ebp),%eax
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	68 bb 22 80 00       	push   $0x8022bb
  8000be:	ff 75 ec             	pushl  -0x14(%ebp)
  8000c1:	50                   	push   %eax
  8000c2:	e8 a7 1b 00 00       	call   801c6e <get_semaphore>
  8000c7:	83 c4 0c             	add    $0xc,%esp
		finishedCountMutex = get_semaphore(parentenvID, "finishedCountMutex");
  8000ca:	8d 45 b4             	lea    -0x4c(%ebp),%eax
  8000cd:	83 ec 04             	sub    $0x4,%esp
  8000d0:	68 c4 22 80 00       	push   $0x8022c4
  8000d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d8:	50                   	push   %eax
  8000d9:	e8 90 1b 00 00       	call   801c6e <get_semaphore>
  8000de:	83 c4 0c             	add    $0xc,%esp
  8000e1:	eb 36                	jmp    800119 <_main+0xe1>
	}
	else if (*protType == 2)
  8000e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e6:	8b 00                	mov    (%eax),%eax
  8000e8:	83 f8 02             	cmp    $0x2,%eax
  8000eb:	75 2c                	jne    800119 <_main+0xe1>
	{
		sT = sget(parentenvID, "T");
  8000ed:	83 ec 08             	sub    $0x8,%esp
  8000f0:	68 b9 22 80 00       	push   $0x8022b9
  8000f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8000f8:	e8 b9 14 00 00       	call   8015b6 <sget>
  8000fd:	83 c4 10             	add    $0x10,%esp
  800100:	89 45 f4             	mov    %eax,-0xc(%ebp)
		sfinishedCountMutex = sget(parentenvID, "finishedCountMutex");
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	68 c4 22 80 00       	push   $0x8022c4
  80010b:	ff 75 ec             	pushl  -0x14(%ebp)
  80010e:	e8 a3 14 00 00       	call   8015b6 <sget>
  800113:	83 c4 10             	add    $0x10,%esp
  800116:	89 45 f0             	mov    %eax,-0x10(%ebp)
	}

	/*[2] DO THE JOB*/
	int Z ;
	if (*protType == 1)
  800119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	83 f8 01             	cmp    $0x1,%eax
  800121:	75 10                	jne    800133 <_main+0xfb>
	{
		wait_semaphore(T);
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	ff 75 bc             	pushl  -0x44(%ebp)
  800129:	e8 5a 1b 00 00       	call   801c88 <wait_semaphore>
  80012e:	83 c4 10             	add    $0x10,%esp
  800131:	eb 18                	jmp    80014b <_main+0x113>
	}
	else if (*protType == 2)
  800133:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800136:	8b 00                	mov    (%eax),%eax
  800138:	83 f8 02             	cmp    $0x2,%eax
  80013b:	75 0e                	jne    80014b <_main+0x113>
	{
		acquire_uspinlock(sT);
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	ff 75 f4             	pushl  -0xc(%ebp)
  800143:	e8 8c 1c 00 00       	call   801dd4 <acquire_uspinlock>
  800148:	83 c4 10             	add    $0x10,%esp
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  80014b:	0f 31                	rdtsc  
  80014d:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800150:	89 55 b0             	mov    %edx,-0x50(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800153:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800156:	8b 55 b0             	mov    -0x50(%ebp),%edx
  800159:	89 45 c0             	mov    %eax,-0x40(%ebp)
  80015c:	89 55 c4             	mov    %edx,-0x3c(%ebp)
	}

	//random delay
	delay = RAND(2000, 10000);
  80015f:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800162:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  800167:	ba 00 00 00 00       	mov    $0x0,%edx
  80016c:	f7 f1                	div    %ecx
  80016e:	89 d0                	mov    %edx,%eax
  800170:	05 d0 07 00 00       	add    $0x7d0,%eax
  800175:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  800178:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80017b:	83 ec 0c             	sub    $0xc,%esp
  80017e:	50                   	push   %eax
  80017f:	e8 43 1b 00 00       	call   801cc7 <env_sleep>
  800184:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	Z = (*X) + 1 ;
  800187:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80018a:	8b 00                	mov    (%eax),%eax
  80018c:	40                   	inc    %eax
  80018d:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800190:	0f 31                	rdtsc  
  800192:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800195:	89 55 a8             	mov    %edx,-0x58(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800198:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80019b:	8b 55 a8             	mov    -0x58(%ebp),%edx
  80019e:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001a1:	89 55 cc             	mov    %edx,-0x34(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8001a4:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001a7:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8001ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8001b1:	f7 f1                	div    %ecx
  8001b3:	89 d0                	mov    %edx,%eax
  8001b5:	05 d0 07 00 00       	add    $0x7d0,%eax
  8001ba:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  8001bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001c0:	83 ec 0c             	sub    $0xc,%esp
  8001c3:	50                   	push   %eax
  8001c4:	e8 fe 1a 00 00       	call   801cc7 <env_sleep>
  8001c9:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	(*X) = Z ;
  8001cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001cf:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8001d2:	89 10                	mov    %edx,(%eax)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  8001d4:	0f 31                	rdtsc  
  8001d6:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8001d9:	89 55 a0             	mov    %edx,-0x60(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  8001dc:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8001df:	8b 55 a0             	mov    -0x60(%ebp),%edx
  8001e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001e5:	89 55 d4             	mov    %edx,-0x2c(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8001e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001eb:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8001f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8001f5:	f7 f1                	div    %ecx
  8001f7:	89 d0                	mov    %edx,%eax
  8001f9:	05 d0 07 00 00       	add    $0x7d0,%eax
  8001fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  800201:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800204:	83 ec 0c             	sub    $0xc,%esp
  800207:	50                   	push   %eax
  800208:	e8 ba 1a 00 00       	call   801cc7 <env_sleep>
  80020d:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	/*[3] DECLARE FINISHING*/
	if (*protType == 1)
  800210:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800213:	8b 00                	mov    (%eax),%eax
  800215:	83 f8 01             	cmp    $0x1,%eax
  800218:	75 39                	jne    800253 <_main+0x21b>
	{
		signal_semaphore(finished);
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	ff 75 b8             	pushl  -0x48(%ebp)
  800220:	e8 7d 1a 00 00       	call   801ca2 <signal_semaphore>
  800225:	83 c4 10             	add    $0x10,%esp

		wait_semaphore(finishedCountMutex);
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	ff 75 b4             	pushl  -0x4c(%ebp)
  80022e:	e8 55 1a 00 00       	call   801c88 <wait_semaphore>
  800233:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
  800236:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800239:	8b 00                	mov    (%eax),%eax
  80023b:	8d 50 01             	lea    0x1(%eax),%edx
  80023e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800241:	89 10                	mov    %edx,(%eax)
		}
		signal_semaphore(finishedCountMutex);
  800243:	83 ec 0c             	sub    $0xc,%esp
  800246:	ff 75 b4             	pushl  -0x4c(%ebp)
  800249:	e8 54 1a 00 00       	call   801ca2 <signal_semaphore>
  80024e:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
		}
		sys_unlock_cons();
	}
}
  800251:	eb 4c                	jmp    80029f <_main+0x267>
		{
			(*finishedCount)++ ;
		}
		signal_semaphore(finishedCountMutex);
	}
	else if (*protType == 2)
  800253:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800256:	8b 00                	mov    (%eax),%eax
  800258:	83 f8 02             	cmp    $0x2,%eax
  80025b:	75 2b                	jne    800288 <_main+0x250>
	{
		acquire_uspinlock(sfinishedCountMutex);
  80025d:	83 ec 0c             	sub    $0xc,%esp
  800260:	ff 75 f0             	pushl  -0x10(%ebp)
  800263:	e8 6c 1b 00 00       	call   801dd4 <acquire_uspinlock>
  800268:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
  80026b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80026e:	8b 00                	mov    (%eax),%eax
  800270:	8d 50 01             	lea    0x1(%eax),%edx
  800273:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800276:	89 10                	mov    %edx,(%eax)
		}
		release_uspinlock(sfinishedCountMutex);
  800278:	83 ec 0c             	sub    $0xc,%esp
  80027b:	ff 75 f0             	pushl  -0x10(%ebp)
  80027e:	e8 83 1b 00 00       	call   801e06 <release_uspinlock>
  800283:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
		}
		sys_unlock_cons();
	}
}
  800286:	eb 17                	jmp    80029f <_main+0x267>
			(*finishedCount)++ ;
		}
		release_uspinlock(sfinishedCountMutex);
	}else
	{
		sys_lock_cons();
  800288:	e8 d1 13 00 00       	call   80165e <sys_lock_cons>
		{
			(*finishedCount)++ ;
  80028d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800290:	8b 00                	mov    (%eax),%eax
  800292:	8d 50 01             	lea    0x1(%eax),%edx
  800295:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800298:	89 10                	mov    %edx,(%eax)
		}
		sys_unlock_cons();
  80029a:	e8 d9 13 00 00       	call   801678 <sys_unlock_cons>
	}
}
  80029f:	90                   	nop
  8002a0:	c9                   	leave  
  8002a1:	c3                   	ret    

008002a2 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002a2:	55                   	push   %ebp
  8002a3:	89 e5                	mov    %esp,%ebp
  8002a5:	57                   	push   %edi
  8002a6:	56                   	push   %esi
  8002a7:	53                   	push   %ebx
  8002a8:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002ae:	e8 23 16 00 00       	call   8018d6 <sys_getenvindex>
  8002b3:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002b9:	89 d0                	mov    %edx,%eax
  8002bb:	c1 e0 03             	shl    $0x3,%eax
  8002be:	01 d0                	add    %edx,%eax
  8002c0:	c1 e0 06             	shl    $0x6,%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	c1 e0 03             	shl    $0x3,%eax
  8002c8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002cd:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d7:	8a 40 10             	mov    0x10(%eax),%al
  8002da:	84 c0                	test   %al,%al
  8002dc:	74 0d                	je     8002eb <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002de:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e3:	83 c0 10             	add    $0x10,%eax
  8002e6:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002ef:	7e 0a                	jle    8002fb <libmain+0x59>
		binaryname = argv[0];
  8002f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f4:	8b 00                	mov    (%eax),%eax
  8002f6:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002fb:	83 ec 08             	sub    $0x8,%esp
  8002fe:	ff 75 0c             	pushl  0xc(%ebp)
  800301:	ff 75 08             	pushl  0x8(%ebp)
  800304:	e8 2f fd ff ff       	call   800038 <_main>
  800309:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80030c:	a1 00 30 80 00       	mov    0x803000,%eax
  800311:	85 c0                	test   %eax,%eax
  800313:	0f 84 b7 01 00 00    	je     8004d0 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800319:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80031f:	bb 14 24 80 00       	mov    $0x802414,%ebx
  800324:	ba 0e 00 00 00       	mov    $0xe,%edx
  800329:	89 c7                	mov    %eax,%edi
  80032b:	89 de                	mov    %ebx,%esi
  80032d:	89 d1                	mov    %edx,%ecx
  80032f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800331:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800337:	b9 56 00 00 00       	mov    $0x56,%ecx
  80033c:	b0 00                	mov    $0x0,%al
  80033e:	89 d7                	mov    %edx,%edi
  800340:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800342:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800349:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	50                   	push   %eax
  800350:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800356:	50                   	push   %eax
  800357:	e8 7a 17 00 00       	call   801ad6 <sys_utilities>
  80035c:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80035f:	e8 fa 12 00 00       	call   80165e <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800364:	83 ec 0c             	sub    $0xc,%esp
  800367:	68 f0 22 80 00       	push   $0x8022f0
  80036c:	e8 71 02 00 00       	call   8005e2 <cprintf>
  800371:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800374:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800377:	85 c0                	test   %eax,%eax
  800379:	74 58                	je     8003d3 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80037b:	e8 74 17 00 00       	call   801af4 <sys_get_optimal_num_faults>
  800380:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800383:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800389:	bb 78 24 80 00       	mov    $0x802478,%ebx
  80038e:	ba 11 00 00 00       	mov    $0x11,%edx
  800393:	89 c7                	mov    %eax,%edi
  800395:	89 de                	mov    %ebx,%esi
  800397:	89 d1                	mov    %edx,%ecx
  800399:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80039b:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80039e:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003a3:	b0 00                	mov    $0x0,%al
  8003a5:	89 d7                	mov    %edx,%edi
  8003a7:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003a9:	83 ec 08             	sub    $0x8,%esp
  8003ac:	ff 75 dc             	pushl  -0x24(%ebp)
  8003af:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003b5:	50                   	push   %eax
  8003b6:	e8 1b 17 00 00       	call   801ad6 <sys_utilities>
  8003bb:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003be:	83 ec 08             	sub    $0x8,%esp
  8003c1:	ff 75 dc             	pushl  -0x24(%ebp)
  8003c4:	68 18 23 80 00       	push   $0x802318
  8003c9:	e8 14 02 00 00       	call   8005e2 <cprintf>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	eb 59                	jmp    80042c <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d8:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003e9:	83 ec 04             	sub    $0x4,%esp
  8003ec:	52                   	push   %edx
  8003ed:	50                   	push   %eax
  8003ee:	68 3c 23 80 00       	push   $0x80233c
  8003f3:	e8 ea 01 00 00       	call   8005e2 <cprintf>
  8003f8:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800400:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800411:	a1 20 30 80 00       	mov    0x803020,%eax
  800416:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80041c:	51                   	push   %ecx
  80041d:	52                   	push   %edx
  80041e:	50                   	push   %eax
  80041f:	68 64 23 80 00       	push   $0x802364
  800424:	e8 b9 01 00 00       	call   8005e2 <cprintf>
  800429:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80042c:	a1 20 30 80 00       	mov    0x803020,%eax
  800431:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800437:	83 ec 08             	sub    $0x8,%esp
  80043a:	50                   	push   %eax
  80043b:	68 bc 23 80 00       	push   $0x8023bc
  800440:	e8 9d 01 00 00       	call   8005e2 <cprintf>
  800445:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800448:	83 ec 0c             	sub    $0xc,%esp
  80044b:	68 d0 23 80 00       	push   $0x8023d0
  800450:	e8 8d 01 00 00       	call   8005e2 <cprintf>
  800455:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800458:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80045f:	eb 28                	jmp    800489 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800461:	a1 20 30 80 00       	mov    0x803020,%eax
  800466:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800469:	81 c2 74 04 00 00    	add    $0x474,%edx
  80046f:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800472:	83 ec 04             	sub    $0x4,%esp
  800475:	50                   	push   %eax
  800476:	ff 75 e4             	pushl  -0x1c(%ebp)
  800479:	68 e7 23 80 00       	push   $0x8023e7
  80047e:	e8 5f 01 00 00       	call   8005e2 <cprintf>
  800483:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800486:	ff 45 e4             	incl   -0x1c(%ebp)
  800489:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80048d:	7e d2                	jle    800461 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80048f:	83 ec 0c             	sub    $0xc,%esp
  800492:	68 f6 23 80 00       	push   $0x8023f6
  800497:	e8 46 01 00 00       	call   8005e2 <cprintf>
  80049c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80049f:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a4:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	50                   	push   %eax
  8004ae:	68 fa 23 80 00       	push   $0x8023fa
  8004b3:	e8 2a 01 00 00       	call   8005e2 <cprintf>
  8004b8:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004bb:	83 ec 0c             	sub    $0xc,%esp
  8004be:	68 f0 22 80 00       	push   $0x8022f0
  8004c3:	e8 1a 01 00 00       	call   8005e2 <cprintf>
  8004c8:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004cb:	e8 a8 11 00 00       	call   801678 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004d0:	e8 1f 00 00 00       	call   8004f4 <exit>
}
  8004d5:	90                   	nop
  8004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004d9:	5b                   	pop    %ebx
  8004da:	5e                   	pop    %esi
  8004db:	5f                   	pop    %edi
  8004dc:	5d                   	pop    %ebp
  8004dd:	c3                   	ret    

008004de <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004de:	55                   	push   %ebp
  8004df:	89 e5                	mov    %esp,%ebp
  8004e1:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004e4:	83 ec 0c             	sub    $0xc,%esp
  8004e7:	6a 00                	push   $0x0
  8004e9:	e8 b4 13 00 00       	call   8018a2 <sys_destroy_env>
  8004ee:	83 c4 10             	add    $0x10,%esp
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <exit>:

void
exit(void)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004fa:	e8 09 14 00 00       	call   801908 <sys_exit_env>
}
  8004ff:	90                   	nop
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	53                   	push   %ebx
  800506:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800509:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050c:	8b 00                	mov    (%eax),%eax
  80050e:	8d 48 01             	lea    0x1(%eax),%ecx
  800511:	8b 55 0c             	mov    0xc(%ebp),%edx
  800514:	89 0a                	mov    %ecx,(%edx)
  800516:	8b 55 08             	mov    0x8(%ebp),%edx
  800519:	88 d1                	mov    %dl,%cl
  80051b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800522:	8b 45 0c             	mov    0xc(%ebp),%eax
  800525:	8b 00                	mov    (%eax),%eax
  800527:	3d ff 00 00 00       	cmp    $0xff,%eax
  80052c:	75 30                	jne    80055e <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80052e:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800534:	a0 40 30 80 00       	mov    0x803040,%al
  800539:	0f b6 c0             	movzbl %al,%eax
  80053c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80053f:	8b 09                	mov    (%ecx),%ecx
  800541:	89 cb                	mov    %ecx,%ebx
  800543:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800546:	83 c1 08             	add    $0x8,%ecx
  800549:	52                   	push   %edx
  80054a:	50                   	push   %eax
  80054b:	53                   	push   %ebx
  80054c:	51                   	push   %ecx
  80054d:	e8 c8 10 00 00       	call   80161a <sys_cputs>
  800552:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800555:	8b 45 0c             	mov    0xc(%ebp),%eax
  800558:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80055e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800561:	8b 40 04             	mov    0x4(%eax),%eax
  800564:	8d 50 01             	lea    0x1(%eax),%edx
  800567:	8b 45 0c             	mov    0xc(%ebp),%eax
  80056a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80056d:	90                   	nop
  80056e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800571:	c9                   	leave  
  800572:	c3                   	ret    

00800573 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800573:	55                   	push   %ebp
  800574:	89 e5                	mov    %esp,%ebp
  800576:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80057c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800583:	00 00 00 
	b.cnt = 0;
  800586:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80058d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800590:	ff 75 0c             	pushl  0xc(%ebp)
  800593:	ff 75 08             	pushl  0x8(%ebp)
  800596:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80059c:	50                   	push   %eax
  80059d:	68 02 05 80 00       	push   $0x800502
  8005a2:	e8 5a 02 00 00       	call   800801 <vprintfmt>
  8005a7:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8005aa:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8005b0:	a0 40 30 80 00       	mov    0x803040,%al
  8005b5:	0f b6 c0             	movzbl %al,%eax
  8005b8:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8005be:	52                   	push   %edx
  8005bf:	50                   	push   %eax
  8005c0:	51                   	push   %ecx
  8005c1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c7:	83 c0 08             	add    $0x8,%eax
  8005ca:	50                   	push   %eax
  8005cb:	e8 4a 10 00 00       	call   80161a <sys_cputs>
  8005d0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005d3:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8005da:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005e0:	c9                   	leave  
  8005e1:	c3                   	ret    

008005e2 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8005e2:	55                   	push   %ebp
  8005e3:	89 e5                	mov    %esp,%ebp
  8005e5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005e8:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005ef:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f8:	83 ec 08             	sub    $0x8,%esp
  8005fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8005fe:	50                   	push   %eax
  8005ff:	e8 6f ff ff ff       	call   800573 <vcprintf>
  800604:	83 c4 10             	add    $0x10,%esp
  800607:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80060a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80060d:	c9                   	leave  
  80060e:	c3                   	ret    

0080060f <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80060f:	55                   	push   %ebp
  800610:	89 e5                	mov    %esp,%ebp
  800612:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800615:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	c1 e0 08             	shl    $0x8,%eax
  800622:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800627:	8d 45 0c             	lea    0xc(%ebp),%eax
  80062a:	83 c0 04             	add    $0x4,%eax
  80062d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800630:	8b 45 0c             	mov    0xc(%ebp),%eax
  800633:	83 ec 08             	sub    $0x8,%esp
  800636:	ff 75 f4             	pushl  -0xc(%ebp)
  800639:	50                   	push   %eax
  80063a:	e8 34 ff ff ff       	call   800573 <vcprintf>
  80063f:	83 c4 10             	add    $0x10,%esp
  800642:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800645:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  80064c:	07 00 00 

	return cnt;
  80064f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800652:	c9                   	leave  
  800653:	c3                   	ret    

00800654 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800654:	55                   	push   %ebp
  800655:	89 e5                	mov    %esp,%ebp
  800657:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80065a:	e8 ff 0f 00 00       	call   80165e <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80065f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800662:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	83 ec 08             	sub    $0x8,%esp
  80066b:	ff 75 f4             	pushl  -0xc(%ebp)
  80066e:	50                   	push   %eax
  80066f:	e8 ff fe ff ff       	call   800573 <vcprintf>
  800674:	83 c4 10             	add    $0x10,%esp
  800677:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80067a:	e8 f9 0f 00 00       	call   801678 <sys_unlock_cons>
	return cnt;
  80067f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800682:	c9                   	leave  
  800683:	c3                   	ret    

00800684 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800684:	55                   	push   %ebp
  800685:	89 e5                	mov    %esp,%ebp
  800687:	53                   	push   %ebx
  800688:	83 ec 14             	sub    $0x14,%esp
  80068b:	8b 45 10             	mov    0x10(%ebp),%eax
  80068e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800691:	8b 45 14             	mov    0x14(%ebp),%eax
  800694:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800697:	8b 45 18             	mov    0x18(%ebp),%eax
  80069a:	ba 00 00 00 00       	mov    $0x0,%edx
  80069f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a2:	77 55                	ja     8006f9 <printnum+0x75>
  8006a4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a7:	72 05                	jb     8006ae <printnum+0x2a>
  8006a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006ac:	77 4b                	ja     8006f9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006ae:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006b1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006b4:	8b 45 18             	mov    0x18(%ebp),%eax
  8006b7:	ba 00 00 00 00       	mov    $0x0,%edx
  8006bc:	52                   	push   %edx
  8006bd:	50                   	push   %eax
  8006be:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c1:	ff 75 f0             	pushl  -0x10(%ebp)
  8006c4:	e8 67 19 00 00       	call   802030 <__udivdi3>
  8006c9:	83 c4 10             	add    $0x10,%esp
  8006cc:	83 ec 04             	sub    $0x4,%esp
  8006cf:	ff 75 20             	pushl  0x20(%ebp)
  8006d2:	53                   	push   %ebx
  8006d3:	ff 75 18             	pushl  0x18(%ebp)
  8006d6:	52                   	push   %edx
  8006d7:	50                   	push   %eax
  8006d8:	ff 75 0c             	pushl  0xc(%ebp)
  8006db:	ff 75 08             	pushl  0x8(%ebp)
  8006de:	e8 a1 ff ff ff       	call   800684 <printnum>
  8006e3:	83 c4 20             	add    $0x20,%esp
  8006e6:	eb 1a                	jmp    800702 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006e8:	83 ec 08             	sub    $0x8,%esp
  8006eb:	ff 75 0c             	pushl  0xc(%ebp)
  8006ee:	ff 75 20             	pushl  0x20(%ebp)
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006f9:	ff 4d 1c             	decl   0x1c(%ebp)
  8006fc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800700:	7f e6                	jg     8006e8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800702:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800705:	bb 00 00 00 00       	mov    $0x0,%ebx
  80070a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800710:	53                   	push   %ebx
  800711:	51                   	push   %ecx
  800712:	52                   	push   %edx
  800713:	50                   	push   %eax
  800714:	e8 27 1a 00 00       	call   802140 <__umoddi3>
  800719:	83 c4 10             	add    $0x10,%esp
  80071c:	05 f4 26 80 00       	add    $0x8026f4,%eax
  800721:	8a 00                	mov    (%eax),%al
  800723:	0f be c0             	movsbl %al,%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
}
  800735:	90                   	nop
  800736:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800739:	c9                   	leave  
  80073a:	c3                   	ret    

0080073b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80073b:	55                   	push   %ebp
  80073c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80073e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800742:	7e 1c                	jle    800760 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	8d 50 08             	lea    0x8(%eax),%edx
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	89 10                	mov    %edx,(%eax)
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	8b 00                	mov    (%eax),%eax
  800756:	83 e8 08             	sub    $0x8,%eax
  800759:	8b 50 04             	mov    0x4(%eax),%edx
  80075c:	8b 00                	mov    (%eax),%eax
  80075e:	eb 40                	jmp    8007a0 <getuint+0x65>
	else if (lflag)
  800760:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800764:	74 1e                	je     800784 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	8d 50 04             	lea    0x4(%eax),%edx
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	89 10                	mov    %edx,(%eax)
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	83 e8 04             	sub    $0x4,%eax
  80077b:	8b 00                	mov    (%eax),%eax
  80077d:	ba 00 00 00 00       	mov    $0x0,%edx
  800782:	eb 1c                	jmp    8007a0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	8b 00                	mov    (%eax),%eax
  800789:	8d 50 04             	lea    0x4(%eax),%edx
  80078c:	8b 45 08             	mov    0x8(%ebp),%eax
  80078f:	89 10                	mov    %edx,(%eax)
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	8b 00                	mov    (%eax),%eax
  800796:	83 e8 04             	sub    $0x4,%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007a0:	5d                   	pop    %ebp
  8007a1:	c3                   	ret    

008007a2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007a2:	55                   	push   %ebp
  8007a3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a9:	7e 1c                	jle    8007c7 <getint+0x25>
		return va_arg(*ap, long long);
  8007ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ae:	8b 00                	mov    (%eax),%eax
  8007b0:	8d 50 08             	lea    0x8(%eax),%edx
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	89 10                	mov    %edx,(%eax)
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	83 e8 08             	sub    $0x8,%eax
  8007c0:	8b 50 04             	mov    0x4(%eax),%edx
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	eb 38                	jmp    8007ff <getint+0x5d>
	else if (lflag)
  8007c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007cb:	74 1a                	je     8007e7 <getint+0x45>
		return va_arg(*ap, long);
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	8d 50 04             	lea    0x4(%eax),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	89 10                	mov    %edx,(%eax)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	83 e8 04             	sub    $0x4,%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	99                   	cltd   
  8007e5:	eb 18                	jmp    8007ff <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	8b 00                	mov    (%eax),%eax
  8007ec:	8d 50 04             	lea    0x4(%eax),%edx
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	89 10                	mov    %edx,(%eax)
  8007f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f7:	8b 00                	mov    (%eax),%eax
  8007f9:	83 e8 04             	sub    $0x4,%eax
  8007fc:	8b 00                	mov    (%eax),%eax
  8007fe:	99                   	cltd   
}
  8007ff:	5d                   	pop    %ebp
  800800:	c3                   	ret    

00800801 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800801:	55                   	push   %ebp
  800802:	89 e5                	mov    %esp,%ebp
  800804:	56                   	push   %esi
  800805:	53                   	push   %ebx
  800806:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800809:	eb 17                	jmp    800822 <vprintfmt+0x21>
			if (ch == '\0')
  80080b:	85 db                	test   %ebx,%ebx
  80080d:	0f 84 c1 03 00 00    	je     800bd4 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800813:	83 ec 08             	sub    $0x8,%esp
  800816:	ff 75 0c             	pushl  0xc(%ebp)
  800819:	53                   	push   %ebx
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800822:	8b 45 10             	mov    0x10(%ebp),%eax
  800825:	8d 50 01             	lea    0x1(%eax),%edx
  800828:	89 55 10             	mov    %edx,0x10(%ebp)
  80082b:	8a 00                	mov    (%eax),%al
  80082d:	0f b6 d8             	movzbl %al,%ebx
  800830:	83 fb 25             	cmp    $0x25,%ebx
  800833:	75 d6                	jne    80080b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800835:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800839:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800840:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800847:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80084e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800855:	8b 45 10             	mov    0x10(%ebp),%eax
  800858:	8d 50 01             	lea    0x1(%eax),%edx
  80085b:	89 55 10             	mov    %edx,0x10(%ebp)
  80085e:	8a 00                	mov    (%eax),%al
  800860:	0f b6 d8             	movzbl %al,%ebx
  800863:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800866:	83 f8 5b             	cmp    $0x5b,%eax
  800869:	0f 87 3d 03 00 00    	ja     800bac <vprintfmt+0x3ab>
  80086f:	8b 04 85 18 27 80 00 	mov    0x802718(,%eax,4),%eax
  800876:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800878:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80087c:	eb d7                	jmp    800855 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80087e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800882:	eb d1                	jmp    800855 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800884:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80088b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80088e:	89 d0                	mov    %edx,%eax
  800890:	c1 e0 02             	shl    $0x2,%eax
  800893:	01 d0                	add    %edx,%eax
  800895:	01 c0                	add    %eax,%eax
  800897:	01 d8                	add    %ebx,%eax
  800899:	83 e8 30             	sub    $0x30,%eax
  80089c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80089f:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a2:	8a 00                	mov    (%eax),%al
  8008a4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008a7:	83 fb 2f             	cmp    $0x2f,%ebx
  8008aa:	7e 3e                	jle    8008ea <vprintfmt+0xe9>
  8008ac:	83 fb 39             	cmp    $0x39,%ebx
  8008af:	7f 39                	jg     8008ea <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008b4:	eb d5                	jmp    80088b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b9:	83 c0 04             	add    $0x4,%eax
  8008bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8008bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c2:	83 e8 04             	sub    $0x4,%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008ca:	eb 1f                	jmp    8008eb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d0:	79 83                	jns    800855 <vprintfmt+0x54>
				width = 0;
  8008d2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008d9:	e9 77 ff ff ff       	jmp    800855 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008de:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008e5:	e9 6b ff ff ff       	jmp    800855 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008ea:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ef:	0f 89 60 ff ff ff    	jns    800855 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008fb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800902:	e9 4e ff ff ff       	jmp    800855 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800907:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80090a:	e9 46 ff ff ff       	jmp    800855 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80090f:	8b 45 14             	mov    0x14(%ebp),%eax
  800912:	83 c0 04             	add    $0x4,%eax
  800915:	89 45 14             	mov    %eax,0x14(%ebp)
  800918:	8b 45 14             	mov    0x14(%ebp),%eax
  80091b:	83 e8 04             	sub    $0x4,%eax
  80091e:	8b 00                	mov    (%eax),%eax
  800920:	83 ec 08             	sub    $0x8,%esp
  800923:	ff 75 0c             	pushl  0xc(%ebp)
  800926:	50                   	push   %eax
  800927:	8b 45 08             	mov    0x8(%ebp),%eax
  80092a:	ff d0                	call   *%eax
  80092c:	83 c4 10             	add    $0x10,%esp
			break;
  80092f:	e9 9b 02 00 00       	jmp    800bcf <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800934:	8b 45 14             	mov    0x14(%ebp),%eax
  800937:	83 c0 04             	add    $0x4,%eax
  80093a:	89 45 14             	mov    %eax,0x14(%ebp)
  80093d:	8b 45 14             	mov    0x14(%ebp),%eax
  800940:	83 e8 04             	sub    $0x4,%eax
  800943:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800945:	85 db                	test   %ebx,%ebx
  800947:	79 02                	jns    80094b <vprintfmt+0x14a>
				err = -err;
  800949:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80094b:	83 fb 64             	cmp    $0x64,%ebx
  80094e:	7f 0b                	jg     80095b <vprintfmt+0x15a>
  800950:	8b 34 9d 60 25 80 00 	mov    0x802560(,%ebx,4),%esi
  800957:	85 f6                	test   %esi,%esi
  800959:	75 19                	jne    800974 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80095b:	53                   	push   %ebx
  80095c:	68 05 27 80 00       	push   $0x802705
  800961:	ff 75 0c             	pushl  0xc(%ebp)
  800964:	ff 75 08             	pushl  0x8(%ebp)
  800967:	e8 70 02 00 00       	call   800bdc <printfmt>
  80096c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80096f:	e9 5b 02 00 00       	jmp    800bcf <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800974:	56                   	push   %esi
  800975:	68 0e 27 80 00       	push   $0x80270e
  80097a:	ff 75 0c             	pushl  0xc(%ebp)
  80097d:	ff 75 08             	pushl  0x8(%ebp)
  800980:	e8 57 02 00 00       	call   800bdc <printfmt>
  800985:	83 c4 10             	add    $0x10,%esp
			break;
  800988:	e9 42 02 00 00       	jmp    800bcf <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80098d:	8b 45 14             	mov    0x14(%ebp),%eax
  800990:	83 c0 04             	add    $0x4,%eax
  800993:	89 45 14             	mov    %eax,0x14(%ebp)
  800996:	8b 45 14             	mov    0x14(%ebp),%eax
  800999:	83 e8 04             	sub    $0x4,%eax
  80099c:	8b 30                	mov    (%eax),%esi
  80099e:	85 f6                	test   %esi,%esi
  8009a0:	75 05                	jne    8009a7 <vprintfmt+0x1a6>
				p = "(null)";
  8009a2:	be 11 27 80 00       	mov    $0x802711,%esi
			if (width > 0 && padc != '-')
  8009a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ab:	7e 6d                	jle    800a1a <vprintfmt+0x219>
  8009ad:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009b1:	74 67                	je     800a1a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	50                   	push   %eax
  8009ba:	56                   	push   %esi
  8009bb:	e8 1e 03 00 00       	call   800cde <strnlen>
  8009c0:	83 c4 10             	add    $0x10,%esp
  8009c3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009c6:	eb 16                	jmp    8009de <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009c8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009cc:	83 ec 08             	sub    $0x8,%esp
  8009cf:	ff 75 0c             	pushl  0xc(%ebp)
  8009d2:	50                   	push   %eax
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	ff d0                	call   *%eax
  8009d8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009db:	ff 4d e4             	decl   -0x1c(%ebp)
  8009de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e2:	7f e4                	jg     8009c8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e4:	eb 34                	jmp    800a1a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009ea:	74 1c                	je     800a08 <vprintfmt+0x207>
  8009ec:	83 fb 1f             	cmp    $0x1f,%ebx
  8009ef:	7e 05                	jle    8009f6 <vprintfmt+0x1f5>
  8009f1:	83 fb 7e             	cmp    $0x7e,%ebx
  8009f4:	7e 12                	jle    800a08 <vprintfmt+0x207>
					putch('?', putdat);
  8009f6:	83 ec 08             	sub    $0x8,%esp
  8009f9:	ff 75 0c             	pushl  0xc(%ebp)
  8009fc:	6a 3f                	push   $0x3f
  8009fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800a01:	ff d0                	call   *%eax
  800a03:	83 c4 10             	add    $0x10,%esp
  800a06:	eb 0f                	jmp    800a17 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a08:	83 ec 08             	sub    $0x8,%esp
  800a0b:	ff 75 0c             	pushl  0xc(%ebp)
  800a0e:	53                   	push   %ebx
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a17:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1a:	89 f0                	mov    %esi,%eax
  800a1c:	8d 70 01             	lea    0x1(%eax),%esi
  800a1f:	8a 00                	mov    (%eax),%al
  800a21:	0f be d8             	movsbl %al,%ebx
  800a24:	85 db                	test   %ebx,%ebx
  800a26:	74 24                	je     800a4c <vprintfmt+0x24b>
  800a28:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a2c:	78 b8                	js     8009e6 <vprintfmt+0x1e5>
  800a2e:	ff 4d e0             	decl   -0x20(%ebp)
  800a31:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a35:	79 af                	jns    8009e6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a37:	eb 13                	jmp    800a4c <vprintfmt+0x24b>
				putch(' ', putdat);
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 0c             	pushl  0xc(%ebp)
  800a3f:	6a 20                	push   $0x20
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	ff d0                	call   *%eax
  800a46:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a49:	ff 4d e4             	decl   -0x1c(%ebp)
  800a4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a50:	7f e7                	jg     800a39 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a52:	e9 78 01 00 00       	jmp    800bcf <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5d:	8d 45 14             	lea    0x14(%ebp),%eax
  800a60:	50                   	push   %eax
  800a61:	e8 3c fd ff ff       	call   8007a2 <getint>
  800a66:	83 c4 10             	add    $0x10,%esp
  800a69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a75:	85 d2                	test   %edx,%edx
  800a77:	79 23                	jns    800a9c <vprintfmt+0x29b>
				putch('-', putdat);
  800a79:	83 ec 08             	sub    $0x8,%esp
  800a7c:	ff 75 0c             	pushl  0xc(%ebp)
  800a7f:	6a 2d                	push   $0x2d
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	ff d0                	call   *%eax
  800a86:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a8f:	f7 d8                	neg    %eax
  800a91:	83 d2 00             	adc    $0x0,%edx
  800a94:	f7 da                	neg    %edx
  800a96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a9c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa3:	e9 bc 00 00 00       	jmp    800b64 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 e8             	pushl  -0x18(%ebp)
  800aae:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab1:	50                   	push   %eax
  800ab2:	e8 84 fc ff ff       	call   80073b <getuint>
  800ab7:	83 c4 10             	add    $0x10,%esp
  800aba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ac0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ac7:	e9 98 00 00 00       	jmp    800b64 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800acc:	83 ec 08             	sub    $0x8,%esp
  800acf:	ff 75 0c             	pushl  0xc(%ebp)
  800ad2:	6a 58                	push   $0x58
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	ff d0                	call   *%eax
  800ad9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800adc:	83 ec 08             	sub    $0x8,%esp
  800adf:	ff 75 0c             	pushl  0xc(%ebp)
  800ae2:	6a 58                	push   $0x58
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	ff d0                	call   *%eax
  800ae9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aec:	83 ec 08             	sub    $0x8,%esp
  800aef:	ff 75 0c             	pushl  0xc(%ebp)
  800af2:	6a 58                	push   $0x58
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	ff d0                	call   *%eax
  800af9:	83 c4 10             	add    $0x10,%esp
			break;
  800afc:	e9 ce 00 00 00       	jmp    800bcf <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b01:	83 ec 08             	sub    $0x8,%esp
  800b04:	ff 75 0c             	pushl  0xc(%ebp)
  800b07:	6a 30                	push   $0x30
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	ff d0                	call   *%eax
  800b0e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b11:	83 ec 08             	sub    $0x8,%esp
  800b14:	ff 75 0c             	pushl  0xc(%ebp)
  800b17:	6a 78                	push   $0x78
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	ff d0                	call   *%eax
  800b1e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 c0 04             	add    $0x4,%eax
  800b27:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2d:	83 e8 04             	sub    $0x4,%eax
  800b30:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b32:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b3c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b43:	eb 1f                	jmp    800b64 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b45:	83 ec 08             	sub    $0x8,%esp
  800b48:	ff 75 e8             	pushl  -0x18(%ebp)
  800b4b:	8d 45 14             	lea    0x14(%ebp),%eax
  800b4e:	50                   	push   %eax
  800b4f:	e8 e7 fb ff ff       	call   80073b <getuint>
  800b54:	83 c4 10             	add    $0x10,%esp
  800b57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b5d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b64:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b68:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b6b:	83 ec 04             	sub    $0x4,%esp
  800b6e:	52                   	push   %edx
  800b6f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b72:	50                   	push   %eax
  800b73:	ff 75 f4             	pushl  -0xc(%ebp)
  800b76:	ff 75 f0             	pushl  -0x10(%ebp)
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	ff 75 08             	pushl  0x8(%ebp)
  800b7f:	e8 00 fb ff ff       	call   800684 <printnum>
  800b84:	83 c4 20             	add    $0x20,%esp
			break;
  800b87:	eb 46                	jmp    800bcf <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b89:	83 ec 08             	sub    $0x8,%esp
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	53                   	push   %ebx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	ff d0                	call   *%eax
  800b95:	83 c4 10             	add    $0x10,%esp
			break;
  800b98:	eb 35                	jmp    800bcf <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b9a:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800ba1:	eb 2c                	jmp    800bcf <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800ba3:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800baa:	eb 23                	jmp    800bcf <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bac:	83 ec 08             	sub    $0x8,%esp
  800baf:	ff 75 0c             	pushl  0xc(%ebp)
  800bb2:	6a 25                	push   $0x25
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	ff d0                	call   *%eax
  800bb9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bbc:	ff 4d 10             	decl   0x10(%ebp)
  800bbf:	eb 03                	jmp    800bc4 <vprintfmt+0x3c3>
  800bc1:	ff 4d 10             	decl   0x10(%ebp)
  800bc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc7:	48                   	dec    %eax
  800bc8:	8a 00                	mov    (%eax),%al
  800bca:	3c 25                	cmp    $0x25,%al
  800bcc:	75 f3                	jne    800bc1 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800bce:	90                   	nop
		}
	}
  800bcf:	e9 35 fc ff ff       	jmp    800809 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bd4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bd8:	5b                   	pop    %ebx
  800bd9:	5e                   	pop    %esi
  800bda:	5d                   	pop    %ebp
  800bdb:	c3                   	ret    

00800bdc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bdc:	55                   	push   %ebp
  800bdd:	89 e5                	mov    %esp,%ebp
  800bdf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800be2:	8d 45 10             	lea    0x10(%ebp),%eax
  800be5:	83 c0 04             	add    $0x4,%eax
  800be8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800beb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bee:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf1:	50                   	push   %eax
  800bf2:	ff 75 0c             	pushl  0xc(%ebp)
  800bf5:	ff 75 08             	pushl  0x8(%ebp)
  800bf8:	e8 04 fc ff ff       	call   800801 <vprintfmt>
  800bfd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c00:	90                   	nop
  800c01:	c9                   	leave  
  800c02:	c3                   	ret    

00800c03 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c03:	55                   	push   %ebp
  800c04:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	8b 40 08             	mov    0x8(%eax),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c12:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	8b 10                	mov    (%eax),%edx
  800c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1d:	8b 40 04             	mov    0x4(%eax),%eax
  800c20:	39 c2                	cmp    %eax,%edx
  800c22:	73 12                	jae    800c36 <sprintputch+0x33>
		*b->buf++ = ch;
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	8b 00                	mov    (%eax),%eax
  800c29:	8d 48 01             	lea    0x1(%eax),%ecx
  800c2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2f:	89 0a                	mov    %ecx,(%edx)
  800c31:	8b 55 08             	mov    0x8(%ebp),%edx
  800c34:	88 10                	mov    %dl,(%eax)
}
  800c36:	90                   	nop
  800c37:	5d                   	pop    %ebp
  800c38:	c3                   	ret    

00800c39 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	01 d0                	add    %edx,%eax
  800c50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c5a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c5e:	74 06                	je     800c66 <vsnprintf+0x2d>
  800c60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c64:	7f 07                	jg     800c6d <vsnprintf+0x34>
		return -E_INVAL;
  800c66:	b8 03 00 00 00       	mov    $0x3,%eax
  800c6b:	eb 20                	jmp    800c8d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c6d:	ff 75 14             	pushl  0x14(%ebp)
  800c70:	ff 75 10             	pushl  0x10(%ebp)
  800c73:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c76:	50                   	push   %eax
  800c77:	68 03 0c 80 00       	push   $0x800c03
  800c7c:	e8 80 fb ff ff       	call   800801 <vprintfmt>
  800c81:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c87:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c8d:	c9                   	leave  
  800c8e:	c3                   	ret    

00800c8f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
  800c92:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c95:	8d 45 10             	lea    0x10(%ebp),%eax
  800c98:	83 c0 04             	add    $0x4,%eax
  800c9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca4:	50                   	push   %eax
  800ca5:	ff 75 0c             	pushl  0xc(%ebp)
  800ca8:	ff 75 08             	pushl  0x8(%ebp)
  800cab:	e8 89 ff ff ff       	call   800c39 <vsnprintf>
  800cb0:	83 c4 10             	add    $0x10,%esp
  800cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cc8:	eb 06                	jmp    800cd0 <strlen+0x15>
		n++;
  800cca:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ccd:	ff 45 08             	incl   0x8(%ebp)
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	84 c0                	test   %al,%al
  800cd7:	75 f1                	jne    800cca <strlen+0xf>
		n++;
	return n;
  800cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cdc:	c9                   	leave  
  800cdd:	c3                   	ret    

00800cde <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ce4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ceb:	eb 09                	jmp    800cf6 <strnlen+0x18>
		n++;
  800ced:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cf0:	ff 45 08             	incl   0x8(%ebp)
  800cf3:	ff 4d 0c             	decl   0xc(%ebp)
  800cf6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cfa:	74 09                	je     800d05 <strnlen+0x27>
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	84 c0                	test   %al,%al
  800d03:	75 e8                	jne    800ced <strnlen+0xf>
		n++;
	return n;
  800d05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d08:	c9                   	leave  
  800d09:	c3                   	ret    

00800d0a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d0a:	55                   	push   %ebp
  800d0b:	89 e5                	mov    %esp,%ebp
  800d0d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d16:	90                   	nop
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1a:	8d 50 01             	lea    0x1(%eax),%edx
  800d1d:	89 55 08             	mov    %edx,0x8(%ebp)
  800d20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d23:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d26:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d29:	8a 12                	mov    (%edx),%dl
  800d2b:	88 10                	mov    %dl,(%eax)
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	84 c0                	test   %al,%al
  800d31:	75 e4                	jne    800d17 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d33:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d36:	c9                   	leave  
  800d37:	c3                   	ret    

00800d38 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d38:	55                   	push   %ebp
  800d39:	89 e5                	mov    %esp,%ebp
  800d3b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d44:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d4b:	eb 1f                	jmp    800d6c <strncpy+0x34>
		*dst++ = *src;
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	8d 50 01             	lea    0x1(%eax),%edx
  800d53:	89 55 08             	mov    %edx,0x8(%ebp)
  800d56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d59:	8a 12                	mov    (%edx),%dl
  800d5b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	84 c0                	test   %al,%al
  800d64:	74 03                	je     800d69 <strncpy+0x31>
			src++;
  800d66:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d69:	ff 45 fc             	incl   -0x4(%ebp)
  800d6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d6f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d72:	72 d9                	jb     800d4d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d74:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d77:	c9                   	leave  
  800d78:	c3                   	ret    

00800d79 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
  800d7c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d89:	74 30                	je     800dbb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d8b:	eb 16                	jmp    800da3 <strlcpy+0x2a>
			*dst++ = *src++;
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 08             	mov    %edx,0x8(%ebp)
  800d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d9f:	8a 12                	mov    (%edx),%dl
  800da1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800da3:	ff 4d 10             	decl   0x10(%ebp)
  800da6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800daa:	74 09                	je     800db5 <strlcpy+0x3c>
  800dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daf:	8a 00                	mov    (%eax),%al
  800db1:	84 c0                	test   %al,%al
  800db3:	75 d8                	jne    800d8d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dbb:	8b 55 08             	mov    0x8(%ebp),%edx
  800dbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc1:	29 c2                	sub    %eax,%edx
  800dc3:	89 d0                	mov    %edx,%eax
}
  800dc5:	c9                   	leave  
  800dc6:	c3                   	ret    

00800dc7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dc7:	55                   	push   %ebp
  800dc8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dca:	eb 06                	jmp    800dd2 <strcmp+0xb>
		p++, q++;
  800dcc:	ff 45 08             	incl   0x8(%ebp)
  800dcf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	84 c0                	test   %al,%al
  800dd9:	74 0e                	je     800de9 <strcmp+0x22>
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	8a 10                	mov    (%eax),%dl
  800de0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	38 c2                	cmp    %al,%dl
  800de7:	74 e3                	je     800dcc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800de9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dec:	8a 00                	mov    (%eax),%al
  800dee:	0f b6 d0             	movzbl %al,%edx
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	0f b6 c0             	movzbl %al,%eax
  800df9:	29 c2                	sub    %eax,%edx
  800dfb:	89 d0                	mov    %edx,%eax
}
  800dfd:	5d                   	pop    %ebp
  800dfe:	c3                   	ret    

00800dff <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dff:	55                   	push   %ebp
  800e00:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e02:	eb 09                	jmp    800e0d <strncmp+0xe>
		n--, p++, q++;
  800e04:	ff 4d 10             	decl   0x10(%ebp)
  800e07:	ff 45 08             	incl   0x8(%ebp)
  800e0a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e11:	74 17                	je     800e2a <strncmp+0x2b>
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	74 0e                	je     800e2a <strncmp+0x2b>
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 10                	mov    (%eax),%dl
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	8a 00                	mov    (%eax),%al
  800e26:	38 c2                	cmp    %al,%dl
  800e28:	74 da                	je     800e04 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e2e:	75 07                	jne    800e37 <strncmp+0x38>
		return 0;
  800e30:	b8 00 00 00 00       	mov    $0x0,%eax
  800e35:	eb 14                	jmp    800e4b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	0f b6 d0             	movzbl %al,%edx
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	8a 00                	mov    (%eax),%al
  800e44:	0f b6 c0             	movzbl %al,%eax
  800e47:	29 c2                	sub    %eax,%edx
  800e49:	89 d0                	mov    %edx,%eax
}
  800e4b:	5d                   	pop    %ebp
  800e4c:	c3                   	ret    

00800e4d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e4d:	55                   	push   %ebp
  800e4e:	89 e5                	mov    %esp,%ebp
  800e50:	83 ec 04             	sub    $0x4,%esp
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e59:	eb 12                	jmp    800e6d <strchr+0x20>
		if (*s == c)
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e63:	75 05                	jne    800e6a <strchr+0x1d>
			return (char *) s;
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	eb 11                	jmp    800e7b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e6a:	ff 45 08             	incl   0x8(%ebp)
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	8a 00                	mov    (%eax),%al
  800e72:	84 c0                	test   %al,%al
  800e74:	75 e5                	jne    800e5b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e7b:	c9                   	leave  
  800e7c:	c3                   	ret    

00800e7d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
  800e80:	83 ec 04             	sub    $0x4,%esp
  800e83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e86:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e89:	eb 0d                	jmp    800e98 <strfind+0x1b>
		if (*s == c)
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	8a 00                	mov    (%eax),%al
  800e90:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e93:	74 0e                	je     800ea3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e95:	ff 45 08             	incl   0x8(%ebp)
  800e98:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	84 c0                	test   %al,%al
  800e9f:	75 ea                	jne    800e8b <strfind+0xe>
  800ea1:	eb 01                	jmp    800ea4 <strfind+0x27>
		if (*s == c)
			break;
  800ea3:	90                   	nop
	return (char *) s;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800eb5:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800eb9:	76 63                	jbe    800f1e <memset+0x75>
		uint64 data_block = c;
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	99                   	cltd   
  800ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec2:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ecb:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800ecf:	c1 e0 08             	shl    $0x8,%eax
  800ed2:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ed5:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ed8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800edb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ede:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800ee2:	c1 e0 10             	shl    $0x10,%eax
  800ee5:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ee8:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800eeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef1:	89 c2                	mov    %eax,%edx
  800ef3:	b8 00 00 00 00       	mov    $0x0,%eax
  800ef8:	09 45 f0             	or     %eax,-0x10(%ebp)
  800efb:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800efe:	eb 18                	jmp    800f18 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f00:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f03:	8d 41 08             	lea    0x8(%ecx),%eax
  800f06:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0f:	89 01                	mov    %eax,(%ecx)
  800f11:	89 51 04             	mov    %edx,0x4(%ecx)
  800f14:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f18:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f1c:	77 e2                	ja     800f00 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f22:	74 23                	je     800f47 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f27:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f2a:	eb 0e                	jmp    800f3a <memset+0x91>
			*p8++ = (uint8)c;
  800f2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f2f:	8d 50 01             	lea    0x1(%eax),%edx
  800f32:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f35:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f38:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f40:	89 55 10             	mov    %edx,0x10(%ebp)
  800f43:	85 c0                	test   %eax,%eax
  800f45:	75 e5                	jne    800f2c <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4a:	c9                   	leave  
  800f4b:	c3                   	ret    

00800f4c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
  800f4f:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f5e:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f62:	76 24                	jbe    800f88 <memcpy+0x3c>
		while(n >= 8){
  800f64:	eb 1c                	jmp    800f82 <memcpy+0x36>
			*d64 = *s64;
  800f66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f69:	8b 50 04             	mov    0x4(%eax),%edx
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f71:	89 01                	mov    %eax,(%ecx)
  800f73:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f76:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f7a:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f7e:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f82:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f86:	77 de                	ja     800f66 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f88:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8c:	74 31                	je     800fbf <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f91:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f97:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f9a:	eb 16                	jmp    800fb2 <memcpy+0x66>
			*d8++ = *s8++;
  800f9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f9f:	8d 50 01             	lea    0x1(%eax),%edx
  800fa2:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fab:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800fae:	8a 12                	mov    (%edx),%dl
  800fb0:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800fb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800fbb:	85 c0                	test   %eax,%eax
  800fbd:	75 dd                	jne    800f9c <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc2:	c9                   	leave  
  800fc3:	c3                   	ret    

00800fc4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fc4:	55                   	push   %ebp
  800fc5:	89 e5                	mov    %esp,%ebp
  800fc7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fdc:	73 50                	jae    80102e <memmove+0x6a>
  800fde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	01 d0                	add    %edx,%eax
  800fe6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe9:	76 43                	jbe    80102e <memmove+0x6a>
		s += n;
  800feb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fee:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ff7:	eb 10                	jmp    801009 <memmove+0x45>
			*--d = *--s;
  800ff9:	ff 4d f8             	decl   -0x8(%ebp)
  800ffc:	ff 4d fc             	decl   -0x4(%ebp)
  800fff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801002:	8a 10                	mov    (%eax),%dl
  801004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801007:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801009:	8b 45 10             	mov    0x10(%ebp),%eax
  80100c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100f:	89 55 10             	mov    %edx,0x10(%ebp)
  801012:	85 c0                	test   %eax,%eax
  801014:	75 e3                	jne    800ff9 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801016:	eb 23                	jmp    80103b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801018:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101b:	8d 50 01             	lea    0x1(%eax),%edx
  80101e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801021:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801024:	8d 4a 01             	lea    0x1(%edx),%ecx
  801027:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80102a:	8a 12                	mov    (%edx),%dl
  80102c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	8d 50 ff             	lea    -0x1(%eax),%edx
  801034:	89 55 10             	mov    %edx,0x10(%ebp)
  801037:	85 c0                	test   %eax,%eax
  801039:	75 dd                	jne    801018 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103e:	c9                   	leave  
  80103f:	c3                   	ret    

00801040 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801040:	55                   	push   %ebp
  801041:	89 e5                	mov    %esp,%ebp
  801043:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801052:	eb 2a                	jmp    80107e <memcmp+0x3e>
		if (*s1 != *s2)
  801054:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801057:	8a 10                	mov    (%eax),%dl
  801059:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	38 c2                	cmp    %al,%dl
  801060:	74 16                	je     801078 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801062:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801065:	8a 00                	mov    (%eax),%al
  801067:	0f b6 d0             	movzbl %al,%edx
  80106a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	0f b6 c0             	movzbl %al,%eax
  801072:	29 c2                	sub    %eax,%edx
  801074:	89 d0                	mov    %edx,%eax
  801076:	eb 18                	jmp    801090 <memcmp+0x50>
		s1++, s2++;
  801078:	ff 45 fc             	incl   -0x4(%ebp)
  80107b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80107e:	8b 45 10             	mov    0x10(%ebp),%eax
  801081:	8d 50 ff             	lea    -0x1(%eax),%edx
  801084:	89 55 10             	mov    %edx,0x10(%ebp)
  801087:	85 c0                	test   %eax,%eax
  801089:	75 c9                	jne    801054 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80108b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801098:	8b 55 08             	mov    0x8(%ebp),%edx
  80109b:	8b 45 10             	mov    0x10(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010a3:	eb 15                	jmp    8010ba <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	0f b6 d0             	movzbl %al,%edx
  8010ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b0:	0f b6 c0             	movzbl %al,%eax
  8010b3:	39 c2                	cmp    %eax,%edx
  8010b5:	74 0d                	je     8010c4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010b7:	ff 45 08             	incl   0x8(%ebp)
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010c0:	72 e3                	jb     8010a5 <memfind+0x13>
  8010c2:	eb 01                	jmp    8010c5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010c4:	90                   	nop
	return (void *) s;
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
  8010cd:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010de:	eb 03                	jmp    8010e3 <strtol+0x19>
		s++;
  8010e0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	3c 20                	cmp    $0x20,%al
  8010ea:	74 f4                	je     8010e0 <strtol+0x16>
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 09                	cmp    $0x9,%al
  8010f3:	74 eb                	je     8010e0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	3c 2b                	cmp    $0x2b,%al
  8010fc:	75 05                	jne    801103 <strtol+0x39>
		s++;
  8010fe:	ff 45 08             	incl   0x8(%ebp)
  801101:	eb 13                	jmp    801116 <strtol+0x4c>
	else if (*s == '-')
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	3c 2d                	cmp    $0x2d,%al
  80110a:	75 0a                	jne    801116 <strtol+0x4c>
		s++, neg = 1;
  80110c:	ff 45 08             	incl   0x8(%ebp)
  80110f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801116:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111a:	74 06                	je     801122 <strtol+0x58>
  80111c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801120:	75 20                	jne    801142 <strtol+0x78>
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	3c 30                	cmp    $0x30,%al
  801129:	75 17                	jne    801142 <strtol+0x78>
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	40                   	inc    %eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	3c 78                	cmp    $0x78,%al
  801133:	75 0d                	jne    801142 <strtol+0x78>
		s += 2, base = 16;
  801135:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801139:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801140:	eb 28                	jmp    80116a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801142:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801146:	75 15                	jne    80115d <strtol+0x93>
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 30                	cmp    $0x30,%al
  80114f:	75 0c                	jne    80115d <strtol+0x93>
		s++, base = 8;
  801151:	ff 45 08             	incl   0x8(%ebp)
  801154:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80115b:	eb 0d                	jmp    80116a <strtol+0xa0>
	else if (base == 0)
  80115d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801161:	75 07                	jne    80116a <strtol+0xa0>
		base = 10;
  801163:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 2f                	cmp    $0x2f,%al
  801171:	7e 19                	jle    80118c <strtol+0xc2>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 39                	cmp    $0x39,%al
  80117a:	7f 10                	jg     80118c <strtol+0xc2>
			dig = *s - '0';
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	0f be c0             	movsbl %al,%eax
  801184:	83 e8 30             	sub    $0x30,%eax
  801187:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80118a:	eb 42                	jmp    8011ce <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	3c 60                	cmp    $0x60,%al
  801193:	7e 19                	jle    8011ae <strtol+0xe4>
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3c 7a                	cmp    $0x7a,%al
  80119c:	7f 10                	jg     8011ae <strtol+0xe4>
			dig = *s - 'a' + 10;
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f be c0             	movsbl %al,%eax
  8011a6:	83 e8 57             	sub    $0x57,%eax
  8011a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ac:	eb 20                	jmp    8011ce <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	3c 40                	cmp    $0x40,%al
  8011b5:	7e 39                	jle    8011f0 <strtol+0x126>
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	3c 5a                	cmp    $0x5a,%al
  8011be:	7f 30                	jg     8011f0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	0f be c0             	movsbl %al,%eax
  8011c8:	83 e8 37             	sub    $0x37,%eax
  8011cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011d4:	7d 19                	jge    8011ef <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011d6:	ff 45 08             	incl   0x8(%ebp)
  8011d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011dc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011e0:	89 c2                	mov    %eax,%edx
  8011e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e5:	01 d0                	add    %edx,%eax
  8011e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011ea:	e9 7b ff ff ff       	jmp    80116a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011ef:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011f4:	74 08                	je     8011fe <strtol+0x134>
		*endptr = (char *) s;
  8011f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8011fc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801202:	74 07                	je     80120b <strtol+0x141>
  801204:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801207:	f7 d8                	neg    %eax
  801209:	eb 03                	jmp    80120e <strtol+0x144>
  80120b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <ltostr>:

void
ltostr(long value, char *str)
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
  801213:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801216:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80121d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801224:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801228:	79 13                	jns    80123d <ltostr+0x2d>
	{
		neg = 1;
  80122a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801237:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80123a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801245:	99                   	cltd   
  801246:	f7 f9                	idiv   %ecx
  801248:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124e:	8d 50 01             	lea    0x1(%eax),%edx
  801251:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801254:	89 c2                	mov    %eax,%edx
  801256:	8b 45 0c             	mov    0xc(%ebp),%eax
  801259:	01 d0                	add    %edx,%eax
  80125b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80125e:	83 c2 30             	add    $0x30,%edx
  801261:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801266:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80126b:	f7 e9                	imul   %ecx
  80126d:	c1 fa 02             	sar    $0x2,%edx
  801270:	89 c8                	mov    %ecx,%eax
  801272:	c1 f8 1f             	sar    $0x1f,%eax
  801275:	29 c2                	sub    %eax,%edx
  801277:	89 d0                	mov    %edx,%eax
  801279:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80127c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801280:	75 bb                	jne    80123d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801282:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801289:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128c:	48                   	dec    %eax
  80128d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801290:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801294:	74 3d                	je     8012d3 <ltostr+0xc3>
		start = 1 ;
  801296:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80129d:	eb 34                	jmp    8012d3 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80129f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a5:	01 d0                	add    %edx,%eax
  8012a7:	8a 00                	mov    (%eax),%al
  8012a9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b2:	01 c2                	add    %eax,%edx
  8012b4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ba:	01 c8                	add    %ecx,%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c6:	01 c2                	add    %eax,%edx
  8012c8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012cb:	88 02                	mov    %al,(%edx)
		start++ ;
  8012cd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012d0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012d9:	7c c4                	jl     80129f <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012db:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e1:	01 d0                	add    %edx,%eax
  8012e3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012e6:	90                   	nop
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
  8012ec:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012ef:	ff 75 08             	pushl  0x8(%ebp)
  8012f2:	e8 c4 f9 ff ff       	call   800cbb <strlen>
  8012f7:	83 c4 04             	add    $0x4,%esp
  8012fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012fd:	ff 75 0c             	pushl  0xc(%ebp)
  801300:	e8 b6 f9 ff ff       	call   800cbb <strlen>
  801305:	83 c4 04             	add    $0x4,%esp
  801308:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80130b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801312:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801319:	eb 17                	jmp    801332 <strcconcat+0x49>
		final[s] = str1[s] ;
  80131b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80131e:	8b 45 10             	mov    0x10(%ebp),%eax
  801321:	01 c2                	add    %eax,%edx
  801323:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	01 c8                	add    %ecx,%eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80132f:	ff 45 fc             	incl   -0x4(%ebp)
  801332:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801335:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801338:	7c e1                	jl     80131b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80133a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801341:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801348:	eb 1f                	jmp    801369 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80134a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134d:	8d 50 01             	lea    0x1(%eax),%edx
  801350:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801353:	89 c2                	mov    %eax,%edx
  801355:	8b 45 10             	mov    0x10(%ebp),%eax
  801358:	01 c2                	add    %eax,%edx
  80135a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80135d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801360:	01 c8                	add    %ecx,%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801366:	ff 45 f8             	incl   -0x8(%ebp)
  801369:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80136c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80136f:	7c d9                	jl     80134a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801371:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801374:	8b 45 10             	mov    0x10(%ebp),%eax
  801377:	01 d0                	add    %edx,%eax
  801379:	c6 00 00             	movb   $0x0,(%eax)
}
  80137c:	90                   	nop
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801382:	8b 45 14             	mov    0x14(%ebp),%eax
  801385:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80138b:	8b 45 14             	mov    0x14(%ebp),%eax
  80138e:	8b 00                	mov    (%eax),%eax
  801390:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801397:	8b 45 10             	mov    0x10(%ebp),%eax
  80139a:	01 d0                	add    %edx,%eax
  80139c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013a2:	eb 0c                	jmp    8013b0 <strsplit+0x31>
			*string++ = 0;
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8d 50 01             	lea    0x1(%eax),%edx
  8013aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ad:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	84 c0                	test   %al,%al
  8013b7:	74 18                	je     8013d1 <strsplit+0x52>
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	0f be c0             	movsbl %al,%eax
  8013c1:	50                   	push   %eax
  8013c2:	ff 75 0c             	pushl  0xc(%ebp)
  8013c5:	e8 83 fa ff ff       	call   800e4d <strchr>
  8013ca:	83 c4 08             	add    $0x8,%esp
  8013cd:	85 c0                	test   %eax,%eax
  8013cf:	75 d3                	jne    8013a4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	84 c0                	test   %al,%al
  8013d8:	74 5a                	je     801434 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013da:	8b 45 14             	mov    0x14(%ebp),%eax
  8013dd:	8b 00                	mov    (%eax),%eax
  8013df:	83 f8 0f             	cmp    $0xf,%eax
  8013e2:	75 07                	jne    8013eb <strsplit+0x6c>
		{
			return 0;
  8013e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e9:	eb 66                	jmp    801451 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ee:	8b 00                	mov    (%eax),%eax
  8013f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8013f3:	8b 55 14             	mov    0x14(%ebp),%edx
  8013f6:	89 0a                	mov    %ecx,(%edx)
  8013f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801402:	01 c2                	add    %eax,%edx
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801409:	eb 03                	jmp    80140e <strsplit+0x8f>
			string++;
  80140b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	84 c0                	test   %al,%al
  801415:	74 8b                	je     8013a2 <strsplit+0x23>
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	0f be c0             	movsbl %al,%eax
  80141f:	50                   	push   %eax
  801420:	ff 75 0c             	pushl  0xc(%ebp)
  801423:	e8 25 fa ff ff       	call   800e4d <strchr>
  801428:	83 c4 08             	add    $0x8,%esp
  80142b:	85 c0                	test   %eax,%eax
  80142d:	74 dc                	je     80140b <strsplit+0x8c>
			string++;
	}
  80142f:	e9 6e ff ff ff       	jmp    8013a2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801434:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801435:	8b 45 14             	mov    0x14(%ebp),%eax
  801438:	8b 00                	mov    (%eax),%eax
  80143a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801441:	8b 45 10             	mov    0x10(%ebp),%eax
  801444:	01 d0                	add    %edx,%eax
  801446:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80144c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
  801456:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80145f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801466:	eb 4a                	jmp    8014b2 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801468:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	01 c2                	add    %eax,%edx
  801470:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	01 c8                	add    %ecx,%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80147c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801482:	01 d0                	add    %edx,%eax
  801484:	8a 00                	mov    (%eax),%al
  801486:	3c 40                	cmp    $0x40,%al
  801488:	7e 25                	jle    8014af <str2lower+0x5c>
  80148a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801490:	01 d0                	add    %edx,%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	3c 5a                	cmp    $0x5a,%al
  801496:	7f 17                	jg     8014af <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801498:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149b:	8b 45 08             	mov    0x8(%ebp),%eax
  80149e:	01 d0                	add    %edx,%eax
  8014a0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a6:	01 ca                	add    %ecx,%edx
  8014a8:	8a 12                	mov    (%edx),%dl
  8014aa:	83 c2 20             	add    $0x20,%edx
  8014ad:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014af:	ff 45 fc             	incl   -0x4(%ebp)
  8014b2:	ff 75 0c             	pushl  0xc(%ebp)
  8014b5:	e8 01 f8 ff ff       	call   800cbb <strlen>
  8014ba:	83 c4 04             	add    $0x4,%esp
  8014bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014c0:	7f a6                	jg     801468 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8014c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
  8014ca:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8014cd:	a1 08 30 80 00       	mov    0x803008,%eax
  8014d2:	85 c0                	test   %eax,%eax
  8014d4:	74 2d                	je     801503 <uheap_init+0x3c>
	{
		buddy_init();
  8014d6:	e8 87 06 00 00       	call   801b62 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8014db:	e8 31 05 00 00       	call   801a11 <sys_get_uheap_strategy>
  8014e0:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  8014e5:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8014ec:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8014ef:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8014f6:	00 00 80 
		__firstTimeFlag = 0;
  8014f9:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801500:	00 00 00 
	}
}
  801503:	90                   	nop
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  80150c:	83 ec 04             	sub    $0x4,%esp
  80150f:	68 88 28 80 00       	push   $0x802888
  801514:	6a 25                	push   $0x25
  801516:	68 b9 28 80 00       	push   $0x8028b9
  80151b:	e8 21 09 00 00       	call   801e41 <_panic>

00801520 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
  801523:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801526:	83 ec 04             	sub    $0x4,%esp
  801529:	68 c8 28 80 00       	push   $0x8028c8
  80152e:	6a 2f                	push   $0x2f
  801530:	68 b9 28 80 00       	push   $0x8028b9
  801535:	e8 07 09 00 00       	call   801e41 <_panic>

0080153a <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
  80153d:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801540:	e8 82 ff ff ff       	call   8014c7 <uheap_init>
	if (size == 0) return NULL ;
  801545:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801549:	75 07                	jne    801552 <malloc+0x18>
  80154b:	b8 00 00 00 00       	mov    $0x0,%eax
  801550:	eb 14                	jmp    801566 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801552:	83 ec 04             	sub    $0x4,%esp
  801555:	68 fc 28 80 00       	push   $0x8028fc
  80155a:	6a 43                	push   $0x43
  80155c:	68 b9 28 80 00       	push   $0x8028b9
  801561:	e8 db 08 00 00       	call   801e41 <_panic>
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
  80156b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  80156e:	83 ec 04             	sub    $0x4,%esp
  801571:	68 24 29 80 00       	push   $0x802924
  801576:	6a 4e                	push   $0x4e
  801578:	68 b9 28 80 00       	push   $0x8028b9
  80157d:	e8 bf 08 00 00       	call   801e41 <_panic>

00801582 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 18             	sub    $0x18,%esp
  801588:	8b 45 10             	mov    0x10(%ebp),%eax
  80158b:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80158e:	e8 34 ff ff ff       	call   8014c7 <uheap_init>
	if (size == 0) return NULL ;
  801593:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801597:	75 07                	jne    8015a0 <smalloc+0x1e>
  801599:	b8 00 00 00 00       	mov    $0x0,%eax
  80159e:	eb 14                	jmp    8015b4 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  8015a0:	83 ec 04             	sub    $0x4,%esp
  8015a3:	68 48 29 80 00       	push   $0x802948
  8015a8:	6a 5f                	push   $0x5f
  8015aa:	68 b9 28 80 00       	push   $0x8028b9
  8015af:	e8 8d 08 00 00       	call   801e41 <_panic>
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
  8015b9:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8015bc:	e8 06 ff ff ff       	call   8014c7 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  8015c1:	83 ec 04             	sub    $0x4,%esp
  8015c4:	68 70 29 80 00       	push   $0x802970
  8015c9:	6a 6f                	push   $0x6f
  8015cb:	68 b9 28 80 00       	push   $0x8028b9
  8015d0:	e8 6c 08 00 00       	call   801e41 <_panic>

008015d5 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
  8015d8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8015db:	83 ec 04             	sub    $0x4,%esp
  8015de:	68 94 29 80 00       	push   $0x802994
  8015e3:	6a 7e                	push   $0x7e
  8015e5:	68 b9 28 80 00       	push   $0x8028b9
  8015ea:	e8 52 08 00 00       	call   801e41 <_panic>

008015ef <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
  8015f2:	57                   	push   %edi
  8015f3:	56                   	push   %esi
  8015f4:	53                   	push   %ebx
  8015f5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801601:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801604:	8b 7d 18             	mov    0x18(%ebp),%edi
  801607:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80160a:	cd 30                	int    $0x30
  80160c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80160f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801612:	83 c4 10             	add    $0x10,%esp
  801615:	5b                   	pop    %ebx
  801616:	5e                   	pop    %esi
  801617:	5f                   	pop    %edi
  801618:	5d                   	pop    %ebp
  801619:	c3                   	ret    

0080161a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
  80161d:	83 ec 04             	sub    $0x4,%esp
  801620:	8b 45 10             	mov    0x10(%ebp),%eax
  801623:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801626:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801629:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	6a 00                	push   $0x0
  801632:	51                   	push   %ecx
  801633:	52                   	push   %edx
  801634:	ff 75 0c             	pushl  0xc(%ebp)
  801637:	50                   	push   %eax
  801638:	6a 00                	push   $0x0
  80163a:	e8 b0 ff ff ff       	call   8015ef <syscall>
  80163f:	83 c4 18             	add    $0x18,%esp
}
  801642:	90                   	nop
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <sys_cgetc>:

int
sys_cgetc(void)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 02                	push   $0x2
  801654:	e8 96 ff ff ff       	call   8015ef <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
}
  80165c:	c9                   	leave  
  80165d:	c3                   	ret    

0080165e <sys_lock_cons>:

void sys_lock_cons(void)
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 03                	push   $0x3
  80166d:	e8 7d ff ff ff       	call   8015ef <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	90                   	nop
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 04                	push   $0x4
  801687:	e8 63 ff ff ff       	call   8015ef <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	90                   	nop
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801695:	8b 55 0c             	mov    0xc(%ebp),%edx
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	52                   	push   %edx
  8016a2:	50                   	push   %eax
  8016a3:	6a 08                	push   $0x8
  8016a5:	e8 45 ff ff ff       	call   8015ef <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
  8016b2:	56                   	push   %esi
  8016b3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016b4:	8b 75 18             	mov    0x18(%ebp),%esi
  8016b7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c3:	56                   	push   %esi
  8016c4:	53                   	push   %ebx
  8016c5:	51                   	push   %ecx
  8016c6:	52                   	push   %edx
  8016c7:	50                   	push   %eax
  8016c8:	6a 09                	push   $0x9
  8016ca:	e8 20 ff ff ff       	call   8015ef <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
}
  8016d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016d5:	5b                   	pop    %ebx
  8016d6:	5e                   	pop    %esi
  8016d7:	5d                   	pop    %ebp
  8016d8:	c3                   	ret    

008016d9 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	ff 75 08             	pushl  0x8(%ebp)
  8016e7:	6a 0a                	push   $0xa
  8016e9:	e8 01 ff ff ff       	call   8015ef <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	ff 75 0c             	pushl  0xc(%ebp)
  8016ff:	ff 75 08             	pushl  0x8(%ebp)
  801702:	6a 0b                	push   $0xb
  801704:	e8 e6 fe ff ff       	call   8015ef <syscall>
  801709:	83 c4 18             	add    $0x18,%esp
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 0c                	push   $0xc
  80171d:	e8 cd fe ff ff       	call   8015ef <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 0d                	push   $0xd
  801736:	e8 b4 fe ff ff       	call   8015ef <syscall>
  80173b:	83 c4 18             	add    $0x18,%esp
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 0e                	push   $0xe
  80174f:	e8 9b fe ff ff       	call   8015ef <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 0f                	push   $0xf
  801768:	e8 82 fe ff ff       	call   8015ef <syscall>
  80176d:	83 c4 18             	add    $0x18,%esp
}
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	ff 75 08             	pushl  0x8(%ebp)
  801780:	6a 10                	push   $0x10
  801782:	e8 68 fe ff ff       	call   8015ef <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 11                	push   $0x11
  80179b:	e8 4f fe ff ff       	call   8015ef <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	90                   	nop
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_cputc>:

void
sys_cputc(const char c)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	83 ec 04             	sub    $0x4,%esp
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017b2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	50                   	push   %eax
  8017bf:	6a 01                	push   $0x1
  8017c1:	e8 29 fe ff ff       	call   8015ef <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	90                   	nop
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 14                	push   $0x14
  8017db:	e8 0f fe ff ff       	call   8015ef <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	90                   	nop
  8017e4:	c9                   	leave  
  8017e5:	c3                   	ret    

008017e6 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
  8017e9:	83 ec 04             	sub    $0x4,%esp
  8017ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8017f2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017f5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	6a 00                	push   $0x0
  8017fe:	51                   	push   %ecx
  8017ff:	52                   	push   %edx
  801800:	ff 75 0c             	pushl  0xc(%ebp)
  801803:	50                   	push   %eax
  801804:	6a 15                	push   $0x15
  801806:	e8 e4 fd ff ff       	call   8015ef <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
}
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801813:	8b 55 10             	mov    0x10(%ebp),%edx
  801816:	8b 45 0c             	mov    0xc(%ebp),%eax
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	52                   	push   %edx
  80181e:	50                   	push   %eax
  80181f:	ff 75 08             	pushl  0x8(%ebp)
  801822:	6a 16                	push   $0x16
  801824:	e8 c6 fd ff ff       	call   8015ef <syscall>
  801829:	83 c4 18             	add    $0x18,%esp
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801831:	8b 55 0c             	mov    0xc(%ebp),%edx
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	52                   	push   %edx
  80183e:	50                   	push   %eax
  80183f:	6a 17                	push   $0x17
  801841:	e8 a9 fd ff ff       	call   8015ef <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80184e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	52                   	push   %edx
  80185b:	50                   	push   %eax
  80185c:	6a 18                	push   $0x18
  80185e:	e8 8c fd ff ff       	call   8015ef <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
}
  801866:	c9                   	leave  
  801867:	c3                   	ret    

00801868 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801868:	55                   	push   %ebp
  801869:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	6a 00                	push   $0x0
  801870:	ff 75 14             	pushl  0x14(%ebp)
  801873:	ff 75 10             	pushl  0x10(%ebp)
  801876:	ff 75 0c             	pushl  0xc(%ebp)
  801879:	50                   	push   %eax
  80187a:	6a 19                	push   $0x19
  80187c:	e8 6e fd ff ff       	call   8015ef <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	50                   	push   %eax
  801895:	6a 1a                	push   $0x1a
  801897:	e8 53 fd ff ff       	call   8015ef <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	90                   	nop
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8018a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	50                   	push   %eax
  8018b1:	6a 1b                	push   $0x1b
  8018b3:	e8 37 fd ff ff       	call   8015ef <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	c9                   	leave  
  8018bc:	c3                   	ret    

008018bd <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 05                	push   $0x5
  8018cc:	e8 1e fd ff ff       	call   8015ef <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 06                	push   $0x6
  8018e5:	e8 05 fd ff ff       	call   8015ef <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 07                	push   $0x7
  8018fe:	e8 ec fc ff ff       	call   8015ef <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_exit_env>:


void sys_exit_env(void)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 1c                	push   $0x1c
  801917:	e8 d3 fc ff ff       	call   8015ef <syscall>
  80191c:	83 c4 18             	add    $0x18,%esp
}
  80191f:	90                   	nop
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	ff 75 10             	pushl  0x10(%ebp)
  80192c:	ff 75 0c             	pushl  0xc(%ebp)
  80192f:	ff 75 08             	pushl  0x8(%ebp)
  801932:	6a 13                	push   $0x13
  801934:	e8 b6 fc ff ff       	call   8015ef <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
	return ;
  80193c:	90                   	nop
}
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <sys_rcr2>:
uint32 sys_rcr2()
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 1e                	push   $0x1e
  80194e:	e8 9c fc ff ff       	call   8015ef <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
}
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
  80195b:	83 ec 04             	sub    $0x4,%esp
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801964:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	50                   	push   %eax
  801971:	6a 1f                	push   $0x1f
  801973:	e8 77 fc ff ff       	call   8015ef <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
	return ;
  80197b:	90                   	nop
}
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <rsttst>:
void rsttst()
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 21                	push   $0x21
  80198d:	e8 5d fc ff ff       	call   8015ef <syscall>
  801992:	83 c4 18             	add    $0x18,%esp
	return ;
  801995:	90                   	nop
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 04             	sub    $0x4,%esp
  80199e:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019a4:	8b 55 18             	mov    0x18(%ebp),%edx
  8019a7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019ab:	52                   	push   %edx
  8019ac:	50                   	push   %eax
  8019ad:	ff 75 10             	pushl  0x10(%ebp)
  8019b0:	ff 75 0c             	pushl  0xc(%ebp)
  8019b3:	ff 75 08             	pushl  0x8(%ebp)
  8019b6:	6a 20                	push   $0x20
  8019b8:	e8 32 fc ff ff       	call   8015ef <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c0:	90                   	nop
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <chktst>:
void chktst(uint32 n)
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	ff 75 08             	pushl  0x8(%ebp)
  8019d1:	6a 22                	push   $0x22
  8019d3:	e8 17 fc ff ff       	call   8015ef <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019db:	90                   	nop
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <inctst>:

void inctst()
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 23                	push   $0x23
  8019ed:	e8 fd fb ff ff       	call   8015ef <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f5:	90                   	nop
}
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <gettst>:
uint32 gettst()
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 24                	push   $0x24
  801a07:	e8 e3 fb ff ff       	call   8015ef <syscall>
  801a0c:	83 c4 18             	add    $0x18,%esp
}
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 25                	push   $0x25
  801a20:	e8 ca fb ff ff       	call   8015ef <syscall>
  801a25:	83 c4 18             	add    $0x18,%esp
  801a28:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801a2d:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	ff 75 08             	pushl  0x8(%ebp)
  801a4a:	6a 26                	push   $0x26
  801a4c:	e8 9e fb ff ff       	call   8015ef <syscall>
  801a51:	83 c4 18             	add    $0x18,%esp
	return ;
  801a54:	90                   	nop
}
  801a55:	c9                   	leave  
  801a56:	c3                   	ret    

00801a57 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a57:	55                   	push   %ebp
  801a58:	89 e5                	mov    %esp,%ebp
  801a5a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a5b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a64:	8b 45 08             	mov    0x8(%ebp),%eax
  801a67:	6a 00                	push   $0x0
  801a69:	53                   	push   %ebx
  801a6a:	51                   	push   %ecx
  801a6b:	52                   	push   %edx
  801a6c:	50                   	push   %eax
  801a6d:	6a 27                	push   $0x27
  801a6f:	e8 7b fb ff ff       	call   8015ef <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
}
  801a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a7a:	c9                   	leave  
  801a7b:	c3                   	ret    

00801a7c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	52                   	push   %edx
  801a8c:	50                   	push   %eax
  801a8d:	6a 28                	push   $0x28
  801a8f:	e8 5b fb ff ff       	call   8015ef <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
}
  801a97:	c9                   	leave  
  801a98:	c3                   	ret    

00801a99 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801a99:	55                   	push   %ebp
  801a9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801a9c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	6a 00                	push   $0x0
  801aa7:	51                   	push   %ecx
  801aa8:	ff 75 10             	pushl  0x10(%ebp)
  801aab:	52                   	push   %edx
  801aac:	50                   	push   %eax
  801aad:	6a 29                	push   $0x29
  801aaf:	e8 3b fb ff ff       	call   8015ef <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
}
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	ff 75 10             	pushl  0x10(%ebp)
  801ac3:	ff 75 0c             	pushl  0xc(%ebp)
  801ac6:	ff 75 08             	pushl  0x8(%ebp)
  801ac9:	6a 12                	push   $0x12
  801acb:	e8 1f fb ff ff       	call   8015ef <syscall>
  801ad0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad3:	90                   	nop
}
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801ad9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801adc:	8b 45 08             	mov    0x8(%ebp),%eax
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	52                   	push   %edx
  801ae6:	50                   	push   %eax
  801ae7:	6a 2a                	push   $0x2a
  801ae9:	e8 01 fb ff ff       	call   8015ef <syscall>
  801aee:	83 c4 18             	add    $0x18,%esp
	return;
  801af1:	90                   	nop
}
  801af2:	c9                   	leave  
  801af3:	c3                   	ret    

00801af4 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 2b                	push   $0x2b
  801b03:	e8 e7 fa ff ff       	call   8015ef <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
}
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
  801b10:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801b13:	83 ec 04             	sub    $0x4,%esp
  801b16:	68 b8 29 80 00       	push   $0x8029b8
  801b1b:	68 0a 01 00 00       	push   $0x10a
  801b20:	68 c8 29 80 00       	push   $0x8029c8
  801b25:	e8 17 03 00 00       	call   801e41 <_panic>

00801b2a <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801b2a:	55                   	push   %ebp
  801b2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	ff 75 0c             	pushl  0xc(%ebp)
  801b36:	ff 75 08             	pushl  0x8(%ebp)
  801b39:	6a 33                	push   $0x33
  801b3b:	e8 af fa ff ff       	call   8015ef <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
	return;
  801b43:	90                   	nop
}
  801b44:	c9                   	leave  
  801b45:	c3                   	ret    

00801b46 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	ff 75 0c             	pushl  0xc(%ebp)
  801b52:	ff 75 08             	pushl  0x8(%ebp)
  801b55:	6a 34                	push   $0x34
  801b57:	e8 93 fa ff ff       	call   8015ef <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5f:	90                   	nop
}
  801b60:	c9                   	leave  
  801b61:	c3                   	ret    

00801b62 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801b62:	55                   	push   %ebp
  801b63:	89 e5                	mov    %esp,%ebp
  801b65:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801b68:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801b6f:	eb 36                	jmp    801ba7 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801b71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b74:	c1 e0 04             	shl    $0x4,%eax
  801b77:	05 60 30 80 00       	add    $0x803060,%eax
  801b7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801b82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b85:	c1 e0 04             	shl    $0x4,%eax
  801b88:	05 64 30 80 00       	add    $0x803064,%eax
  801b8d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801b93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b96:	c1 e0 04             	shl    $0x4,%eax
  801b99:	05 6c 30 80 00       	add    $0x80306c,%eax
  801b9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801ba4:	ff 45 fc             	incl   -0x4(%ebp)
  801ba7:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801bab:	7e c4                	jle    801b71 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801bad:	90                   	nop
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
  801bb3:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801bb6:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801bbd:	eb 24                	jmp    801be3 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bc2:	c1 e0 04             	shl    $0x4,%eax
  801bc5:	05 6c 30 80 00       	add    $0x80306c,%eax
  801bca:	8b 00                	mov    (%eax),%eax
  801bcc:	83 ec 04             	sub    $0x4,%esp
  801bcf:	50                   	push   %eax
  801bd0:	ff 75 f4             	pushl  -0xc(%ebp)
  801bd3:	68 d8 29 80 00       	push   $0x8029d8
  801bd8:	e8 05 ea ff ff       	call   8005e2 <cprintf>
  801bdd:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801be0:	ff 45 f4             	incl   -0xc(%ebp)
  801be3:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801be7:	7e d6                	jle    801bbf <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801be9:	90                   	nop
  801bea:	c9                   	leave  
  801beb:	c3                   	ret    

00801bec <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
  801bef:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801bf2:	83 ec 04             	sub    $0x4,%esp
  801bf5:	68 e8 29 80 00       	push   $0x8029e8
  801bfa:	6a 33                	push   $0x33
  801bfc:	68 09 2a 80 00       	push   $0x802a09
  801c01:	e8 3b 02 00 00       	call   801e41 <_panic>

00801c06 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801c06:	55                   	push   %ebp
  801c07:	89 e5                	mov    %esp,%ebp
  801c09:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801c0c:	83 ec 04             	sub    $0x4,%esp
  801c0f:	68 21 2a 80 00       	push   $0x802a21
  801c14:	6a 3e                	push   $0x3e
  801c16:	68 09 2a 80 00       	push   $0x802a09
  801c1b:	e8 21 02 00 00       	call   801e41 <_panic>

00801c20 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
  801c23:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801c26:	83 ec 04             	sub    $0x4,%esp
  801c29:	68 3f 2a 80 00       	push   $0x802a3f
  801c2e:	6a 49                	push   $0x49
  801c30:	68 09 2a 80 00       	push   $0x802a09
  801c35:	e8 07 02 00 00       	call   801e41 <_panic>

00801c3a <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801c3a:	55                   	push   %ebp
  801c3b:	89 e5                	mov    %esp,%ebp
  801c3d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801c40:	83 ec 04             	sub    $0x4,%esp
  801c43:	68 5c 2a 80 00       	push   $0x802a5c
  801c48:	6a 58                	push   $0x58
  801c4a:	68 09 2a 80 00       	push   $0x802a09
  801c4f:	e8 ed 01 00 00       	call   801e41 <_panic>

00801c54 <create_semaphore>:
// User-level Semaphore

#include "inc/lib.h"

struct semaphore create_semaphore(char *semaphoreName, uint32 value)
{
  801c54:	55                   	push   %ebp
  801c55:	89 e5                	mov    %esp,%ebp
  801c57:	83 ec 08             	sub    $0x8,%esp
	panic("create_semaphore() is not implemented yet...!!");
  801c5a:	83 ec 04             	sub    $0x4,%esp
  801c5d:	68 80 2a 80 00       	push   $0x802a80
  801c62:	6a 07                	push   $0x7
  801c64:	68 af 2a 80 00       	push   $0x802aaf
  801c69:	e8 d3 01 00 00       	call   801e41 <_panic>

00801c6e <get_semaphore>:
}
struct semaphore get_semaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
  801c71:	83 ec 08             	sub    $0x8,%esp
	panic("get_semaphore() is not implemented yet...!!");
  801c74:	83 ec 04             	sub    $0x4,%esp
  801c77:	68 c0 2a 80 00       	push   $0x802ac0
  801c7c:	6a 0b                	push   $0xb
  801c7e:	68 af 2a 80 00       	push   $0x802aaf
  801c83:	e8 b9 01 00 00       	call   801e41 <_panic>

00801c88 <wait_semaphore>:
}

void wait_semaphore(struct semaphore sem)
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
  801c8b:	83 ec 08             	sub    $0x8,%esp
	panic("wait_semaphore() is not implemented yet...!!");
  801c8e:	83 ec 04             	sub    $0x4,%esp
  801c91:	68 ec 2a 80 00       	push   $0x802aec
  801c96:	6a 10                	push   $0x10
  801c98:	68 af 2a 80 00       	push   $0x802aaf
  801c9d:	e8 9f 01 00 00       	call   801e41 <_panic>

00801ca2 <signal_semaphore>:
}

void signal_semaphore(struct semaphore sem)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
  801ca5:	83 ec 08             	sub    $0x8,%esp
	panic("signal_semaphore() is not implemented yet...!!");
  801ca8:	83 ec 04             	sub    $0x4,%esp
  801cab:	68 1c 2b 80 00       	push   $0x802b1c
  801cb0:	6a 15                	push   $0x15
  801cb2:	68 af 2a 80 00       	push   $0x802aaf
  801cb7:	e8 85 01 00 00       	call   801e41 <_panic>

00801cbc <semaphore_count>:
}

int semaphore_count(struct semaphore sem)
{
  801cbc:	55                   	push   %ebp
  801cbd:	89 e5                	mov    %esp,%ebp
	return sem.semdata->count;
  801cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc2:	8b 40 10             	mov    0x10(%eax),%eax
}
  801cc5:	5d                   	pop    %ebp
  801cc6:	c3                   	ret    

00801cc7 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
  801cca:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801ccd:	8b 55 08             	mov    0x8(%ebp),%edx
  801cd0:	89 d0                	mov    %edx,%eax
  801cd2:	c1 e0 02             	shl    $0x2,%eax
  801cd5:	01 d0                	add    %edx,%eax
  801cd7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cde:	01 d0                	add    %edx,%eax
  801ce0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ce7:	01 d0                	add    %edx,%eax
  801ce9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cf0:	01 d0                	add    %edx,%eax
  801cf2:	c1 e0 04             	shl    $0x4,%eax
  801cf5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801cf8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801cff:	0f 31                	rdtsc  
  801d01:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801d04:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801d07:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d0a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d10:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801d13:	eb 46                	jmp    801d5b <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801d15:	0f 31                	rdtsc  
  801d17:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801d1a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801d1d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d20:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801d23:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801d26:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801d29:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d2f:	29 c2                	sub    %eax,%edx
  801d31:	89 d0                	mov    %edx,%eax
  801d33:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801d36:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d3c:	89 d1                	mov    %edx,%ecx
  801d3e:	29 c1                	sub    %eax,%ecx
  801d40:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d43:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d46:	39 c2                	cmp    %eax,%edx
  801d48:	0f 97 c0             	seta   %al
  801d4b:	0f b6 c0             	movzbl %al,%eax
  801d4e:	29 c1                	sub    %eax,%ecx
  801d50:	89 c8                	mov    %ecx,%eax
  801d52:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801d55:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d58:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801d5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d5e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801d61:	72 b2                	jb     801d15 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801d63:	90                   	nop
  801d64:	c9                   	leave  
  801d65:	c3                   	ret    

00801d66 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
  801d69:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801d6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801d73:	eb 03                	jmp    801d78 <busy_wait+0x12>
  801d75:	ff 45 fc             	incl   -0x4(%ebp)
  801d78:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d7b:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d7e:	72 f5                	jb     801d75 <busy_wait+0xf>
	return i;
  801d80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <init_uspinlock>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.ALL] PROTECTION - [0] GIVEN USER SPIN LOCK

void init_uspinlock(struct uspinlock *lk, char *name, bool isOpened)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
  801d88:	83 ec 08             	sub    $0x8,%esp
	assert(isOpened == 0 || isOpened == 1);
  801d8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d8f:	74 1c                	je     801dad <init_uspinlock+0x28>
  801d91:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
  801d95:	74 16                	je     801dad <init_uspinlock+0x28>
  801d97:	68 4c 2b 80 00       	push   $0x802b4c
  801d9c:	68 6b 2b 80 00       	push   $0x802b6b
  801da1:	6a 15                	push   $0x15
  801da3:	68 80 2b 80 00       	push   $0x802b80
  801da8:	e8 94 00 00 00       	call   801e41 <_panic>
	strcpy(lk->name, name);
  801dad:	8b 45 08             	mov    0x8(%ebp),%eax
  801db0:	83 c0 04             	add    $0x4,%eax
  801db3:	83 ec 08             	sub    $0x8,%esp
  801db6:	ff 75 0c             	pushl  0xc(%ebp)
  801db9:	50                   	push   %eax
  801dba:	e8 4b ef ff ff       	call   800d0a <strcpy>
  801dbf:	83 c4 10             	add    $0x10,%esp
	lk->locked = (1 - isOpened);
  801dc2:	b8 01 00 00 00       	mov    $0x1,%eax
  801dc7:	2b 45 10             	sub    0x10(%ebp),%eax
  801dca:	89 c2                	mov    %eax,%edx
  801dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcf:	89 10                	mov    %edx,(%eax)
}
  801dd1:	90                   	nop
  801dd2:	c9                   	leave  
  801dd3:	c3                   	ret    

00801dd4 <acquire_uspinlock>:
// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void acquire_uspinlock(struct uspinlock *lk)
{
  801dd4:	55                   	push   %ebp
  801dd5:	89 e5                	mov    %esp,%ebp
  801dd7:	83 ec 10             	sub    $0x10,%esp
	// The xchg is atomic.
	while(xchg(&lk->locked, 1) != 0) ;
  801dda:	90                   	nop
  801ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dde:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801de1:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%ebp)
xchg(volatile uint32 *addr, uint32 newval)
{
  uint32 result;

  // The + in "+m" denotes a read-modify-write operand.
  __asm __volatile("lock; xchgl %0, %1" :
  801de8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801deb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801dee:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801df1:	f0 87 02             	lock xchg %eax,(%edx)
  801df4:	89 45 f4             	mov    %eax,-0xc(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
  801df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dfa:	85 c0                	test   %eax,%eax
  801dfc:	75 dd                	jne    801ddb <acquire_uspinlock+0x7>
	//cprintf("[%d: %s] ACQUIRED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);

	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that the critical section's memory
	// references happen after the lock is acquired.
	__sync_synchronize();
  801dfe:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
}
  801e03:	90                   	nop
  801e04:	c9                   	leave  
  801e05:	c3                   	ret    

00801e06 <release_uspinlock>:

// Release the lock.
void release_uspinlock(struct uspinlock *lk)
{
  801e06:	55                   	push   %ebp
  801e07:	89 e5                	mov    %esp,%ebp
  801e09:	83 ec 08             	sub    $0x8,%esp
	if(!(lk->locked))
  801e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0f:	8b 00                	mov    (%eax),%eax
  801e11:	85 c0                	test   %eax,%eax
  801e13:	75 18                	jne    801e2d <release_uspinlock+0x27>
	{
		panic("release: lock \"%s\" is not held!", lk->name);
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	83 c0 04             	add    $0x4,%eax
  801e1b:	50                   	push   %eax
  801e1c:	68 90 2b 80 00       	push   $0x802b90
  801e21:	6a 30                	push   $0x30
  801e23:	68 80 2b 80 00       	push   $0x802b80
  801e28:	e8 14 00 00 00       	call   801e41 <_panic>
	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that all the stores in the critical
	// section are visible to other cores before the lock is released.
	// Both the C compiler and the hardware may re-order loads and
	// stores; __sync_synchronize() tells them both not to.
	__sync_synchronize();
  801e2d:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

	// Release the lock, equivalent to lk->locked = 0.
	// This code can't use a C assignment, since it might
	// not be atomic. A real OS would use C atomics here.
	asm volatile("movl $0, %0" : "+m" (lk->locked) : );
  801e32:	8b 45 08             	mov    0x8(%ebp),%eax
  801e35:	8b 55 08             	mov    0x8(%ebp),%edx
  801e38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//cprintf("[%d: %s] RELEASED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);
}
  801e3e:	90                   	nop
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
  801e44:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801e47:	8d 45 10             	lea    0x10(%ebp),%eax
  801e4a:	83 c0 04             	add    $0x4,%eax
  801e4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801e50:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801e55:	85 c0                	test   %eax,%eax
  801e57:	74 16                	je     801e6f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801e59:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801e5e:	83 ec 08             	sub    $0x8,%esp
  801e61:	50                   	push   %eax
  801e62:	68 b0 2b 80 00       	push   $0x802bb0
  801e67:	e8 76 e7 ff ff       	call   8005e2 <cprintf>
  801e6c:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801e6f:	a1 04 30 80 00       	mov    0x803004,%eax
  801e74:	83 ec 0c             	sub    $0xc,%esp
  801e77:	ff 75 0c             	pushl  0xc(%ebp)
  801e7a:	ff 75 08             	pushl  0x8(%ebp)
  801e7d:	50                   	push   %eax
  801e7e:	68 b8 2b 80 00       	push   $0x802bb8
  801e83:	6a 74                	push   $0x74
  801e85:	e8 85 e7 ff ff       	call   80060f <cprintf_colored>
  801e8a:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801e8d:	8b 45 10             	mov    0x10(%ebp),%eax
  801e90:	83 ec 08             	sub    $0x8,%esp
  801e93:	ff 75 f4             	pushl  -0xc(%ebp)
  801e96:	50                   	push   %eax
  801e97:	e8 d7 e6 ff ff       	call   800573 <vcprintf>
  801e9c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801e9f:	83 ec 08             	sub    $0x8,%esp
  801ea2:	6a 00                	push   $0x0
  801ea4:	68 e0 2b 80 00       	push   $0x802be0
  801ea9:	e8 c5 e6 ff ff       	call   800573 <vcprintf>
  801eae:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801eb1:	e8 3e e6 ff ff       	call   8004f4 <exit>

	// should not return here
	while (1) ;
  801eb6:	eb fe                	jmp    801eb6 <_panic+0x75>

00801eb8 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801eb8:	55                   	push   %ebp
  801eb9:	89 e5                	mov    %esp,%ebp
  801ebb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801ebe:	a1 20 30 80 00       	mov    0x803020,%eax
  801ec3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ecc:	39 c2                	cmp    %eax,%edx
  801ece:	74 14                	je     801ee4 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ed0:	83 ec 04             	sub    $0x4,%esp
  801ed3:	68 e4 2b 80 00       	push   $0x802be4
  801ed8:	6a 26                	push   $0x26
  801eda:	68 30 2c 80 00       	push   $0x802c30
  801edf:	e8 5d ff ff ff       	call   801e41 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ee4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801eeb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ef2:	e9 c5 00 00 00       	jmp    801fbc <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801ef7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801efa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f01:	8b 45 08             	mov    0x8(%ebp),%eax
  801f04:	01 d0                	add    %edx,%eax
  801f06:	8b 00                	mov    (%eax),%eax
  801f08:	85 c0                	test   %eax,%eax
  801f0a:	75 08                	jne    801f14 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801f0c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801f0f:	e9 a5 00 00 00       	jmp    801fb9 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801f14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f1b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801f22:	eb 69                	jmp    801f8d <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801f24:	a1 20 30 80 00       	mov    0x803020,%eax
  801f29:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801f2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f32:	89 d0                	mov    %edx,%eax
  801f34:	01 c0                	add    %eax,%eax
  801f36:	01 d0                	add    %edx,%eax
  801f38:	c1 e0 03             	shl    $0x3,%eax
  801f3b:	01 c8                	add    %ecx,%eax
  801f3d:	8a 40 04             	mov    0x4(%eax),%al
  801f40:	84 c0                	test   %al,%al
  801f42:	75 46                	jne    801f8a <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f44:	a1 20 30 80 00       	mov    0x803020,%eax
  801f49:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801f4f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f52:	89 d0                	mov    %edx,%eax
  801f54:	01 c0                	add    %eax,%eax
  801f56:	01 d0                	add    %edx,%eax
  801f58:	c1 e0 03             	shl    $0x3,%eax
  801f5b:	01 c8                	add    %ecx,%eax
  801f5d:	8b 00                	mov    (%eax),%eax
  801f5f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801f62:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801f65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f6a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801f6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f6f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801f76:	8b 45 08             	mov    0x8(%ebp),%eax
  801f79:	01 c8                	add    %ecx,%eax
  801f7b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f7d:	39 c2                	cmp    %eax,%edx
  801f7f:	75 09                	jne    801f8a <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801f81:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801f88:	eb 15                	jmp    801f9f <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f8a:	ff 45 e8             	incl   -0x18(%ebp)
  801f8d:	a1 20 30 80 00       	mov    0x803020,%eax
  801f92:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801f98:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f9b:	39 c2                	cmp    %eax,%edx
  801f9d:	77 85                	ja     801f24 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801f9f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801fa3:	75 14                	jne    801fb9 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801fa5:	83 ec 04             	sub    $0x4,%esp
  801fa8:	68 3c 2c 80 00       	push   $0x802c3c
  801fad:	6a 3a                	push   $0x3a
  801faf:	68 30 2c 80 00       	push   $0x802c30
  801fb4:	e8 88 fe ff ff       	call   801e41 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801fb9:	ff 45 f0             	incl   -0x10(%ebp)
  801fbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fbf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801fc2:	0f 8c 2f ff ff ff    	jl     801ef7 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801fc8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fcf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801fd6:	eb 26                	jmp    801ffe <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801fd8:	a1 20 30 80 00       	mov    0x803020,%eax
  801fdd:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801fe3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801fe6:	89 d0                	mov    %edx,%eax
  801fe8:	01 c0                	add    %eax,%eax
  801fea:	01 d0                	add    %edx,%eax
  801fec:	c1 e0 03             	shl    $0x3,%eax
  801fef:	01 c8                	add    %ecx,%eax
  801ff1:	8a 40 04             	mov    0x4(%eax),%al
  801ff4:	3c 01                	cmp    $0x1,%al
  801ff6:	75 03                	jne    801ffb <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801ff8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ffb:	ff 45 e0             	incl   -0x20(%ebp)
  801ffe:	a1 20 30 80 00       	mov    0x803020,%eax
  802003:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802009:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80200c:	39 c2                	cmp    %eax,%edx
  80200e:	77 c8                	ja     801fd8 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802010:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802013:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802016:	74 14                	je     80202c <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  802018:	83 ec 04             	sub    $0x4,%esp
  80201b:	68 90 2c 80 00       	push   $0x802c90
  802020:	6a 44                	push   $0x44
  802022:	68 30 2c 80 00       	push   $0x802c30
  802027:	e8 15 fe ff ff       	call   801e41 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80202c:	90                   	nop
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    
  80202f:	90                   	nop

00802030 <__udivdi3>:
  802030:	55                   	push   %ebp
  802031:	57                   	push   %edi
  802032:	56                   	push   %esi
  802033:	53                   	push   %ebx
  802034:	83 ec 1c             	sub    $0x1c,%esp
  802037:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80203b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80203f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802043:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802047:	89 ca                	mov    %ecx,%edx
  802049:	89 f8                	mov    %edi,%eax
  80204b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80204f:	85 f6                	test   %esi,%esi
  802051:	75 2d                	jne    802080 <__udivdi3+0x50>
  802053:	39 cf                	cmp    %ecx,%edi
  802055:	77 65                	ja     8020bc <__udivdi3+0x8c>
  802057:	89 fd                	mov    %edi,%ebp
  802059:	85 ff                	test   %edi,%edi
  80205b:	75 0b                	jne    802068 <__udivdi3+0x38>
  80205d:	b8 01 00 00 00       	mov    $0x1,%eax
  802062:	31 d2                	xor    %edx,%edx
  802064:	f7 f7                	div    %edi
  802066:	89 c5                	mov    %eax,%ebp
  802068:	31 d2                	xor    %edx,%edx
  80206a:	89 c8                	mov    %ecx,%eax
  80206c:	f7 f5                	div    %ebp
  80206e:	89 c1                	mov    %eax,%ecx
  802070:	89 d8                	mov    %ebx,%eax
  802072:	f7 f5                	div    %ebp
  802074:	89 cf                	mov    %ecx,%edi
  802076:	89 fa                	mov    %edi,%edx
  802078:	83 c4 1c             	add    $0x1c,%esp
  80207b:	5b                   	pop    %ebx
  80207c:	5e                   	pop    %esi
  80207d:	5f                   	pop    %edi
  80207e:	5d                   	pop    %ebp
  80207f:	c3                   	ret    
  802080:	39 ce                	cmp    %ecx,%esi
  802082:	77 28                	ja     8020ac <__udivdi3+0x7c>
  802084:	0f bd fe             	bsr    %esi,%edi
  802087:	83 f7 1f             	xor    $0x1f,%edi
  80208a:	75 40                	jne    8020cc <__udivdi3+0x9c>
  80208c:	39 ce                	cmp    %ecx,%esi
  80208e:	72 0a                	jb     80209a <__udivdi3+0x6a>
  802090:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802094:	0f 87 9e 00 00 00    	ja     802138 <__udivdi3+0x108>
  80209a:	b8 01 00 00 00       	mov    $0x1,%eax
  80209f:	89 fa                	mov    %edi,%edx
  8020a1:	83 c4 1c             	add    $0x1c,%esp
  8020a4:	5b                   	pop    %ebx
  8020a5:	5e                   	pop    %esi
  8020a6:	5f                   	pop    %edi
  8020a7:	5d                   	pop    %ebp
  8020a8:	c3                   	ret    
  8020a9:	8d 76 00             	lea    0x0(%esi),%esi
  8020ac:	31 ff                	xor    %edi,%edi
  8020ae:	31 c0                	xor    %eax,%eax
  8020b0:	89 fa                	mov    %edi,%edx
  8020b2:	83 c4 1c             	add    $0x1c,%esp
  8020b5:	5b                   	pop    %ebx
  8020b6:	5e                   	pop    %esi
  8020b7:	5f                   	pop    %edi
  8020b8:	5d                   	pop    %ebp
  8020b9:	c3                   	ret    
  8020ba:	66 90                	xchg   %ax,%ax
  8020bc:	89 d8                	mov    %ebx,%eax
  8020be:	f7 f7                	div    %edi
  8020c0:	31 ff                	xor    %edi,%edi
  8020c2:	89 fa                	mov    %edi,%edx
  8020c4:	83 c4 1c             	add    $0x1c,%esp
  8020c7:	5b                   	pop    %ebx
  8020c8:	5e                   	pop    %esi
  8020c9:	5f                   	pop    %edi
  8020ca:	5d                   	pop    %ebp
  8020cb:	c3                   	ret    
  8020cc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020d1:	89 eb                	mov    %ebp,%ebx
  8020d3:	29 fb                	sub    %edi,%ebx
  8020d5:	89 f9                	mov    %edi,%ecx
  8020d7:	d3 e6                	shl    %cl,%esi
  8020d9:	89 c5                	mov    %eax,%ebp
  8020db:	88 d9                	mov    %bl,%cl
  8020dd:	d3 ed                	shr    %cl,%ebp
  8020df:	89 e9                	mov    %ebp,%ecx
  8020e1:	09 f1                	or     %esi,%ecx
  8020e3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020e7:	89 f9                	mov    %edi,%ecx
  8020e9:	d3 e0                	shl    %cl,%eax
  8020eb:	89 c5                	mov    %eax,%ebp
  8020ed:	89 d6                	mov    %edx,%esi
  8020ef:	88 d9                	mov    %bl,%cl
  8020f1:	d3 ee                	shr    %cl,%esi
  8020f3:	89 f9                	mov    %edi,%ecx
  8020f5:	d3 e2                	shl    %cl,%edx
  8020f7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020fb:	88 d9                	mov    %bl,%cl
  8020fd:	d3 e8                	shr    %cl,%eax
  8020ff:	09 c2                	or     %eax,%edx
  802101:	89 d0                	mov    %edx,%eax
  802103:	89 f2                	mov    %esi,%edx
  802105:	f7 74 24 0c          	divl   0xc(%esp)
  802109:	89 d6                	mov    %edx,%esi
  80210b:	89 c3                	mov    %eax,%ebx
  80210d:	f7 e5                	mul    %ebp
  80210f:	39 d6                	cmp    %edx,%esi
  802111:	72 19                	jb     80212c <__udivdi3+0xfc>
  802113:	74 0b                	je     802120 <__udivdi3+0xf0>
  802115:	89 d8                	mov    %ebx,%eax
  802117:	31 ff                	xor    %edi,%edi
  802119:	e9 58 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  80211e:	66 90                	xchg   %ax,%ax
  802120:	8b 54 24 08          	mov    0x8(%esp),%edx
  802124:	89 f9                	mov    %edi,%ecx
  802126:	d3 e2                	shl    %cl,%edx
  802128:	39 c2                	cmp    %eax,%edx
  80212a:	73 e9                	jae    802115 <__udivdi3+0xe5>
  80212c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80212f:	31 ff                	xor    %edi,%edi
  802131:	e9 40 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  802136:	66 90                	xchg   %ax,%ax
  802138:	31 c0                	xor    %eax,%eax
  80213a:	e9 37 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  80213f:	90                   	nop

00802140 <__umoddi3>:
  802140:	55                   	push   %ebp
  802141:	57                   	push   %edi
  802142:	56                   	push   %esi
  802143:	53                   	push   %ebx
  802144:	83 ec 1c             	sub    $0x1c,%esp
  802147:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80214b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80214f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802153:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802157:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80215b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80215f:	89 f3                	mov    %esi,%ebx
  802161:	89 fa                	mov    %edi,%edx
  802163:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802167:	89 34 24             	mov    %esi,(%esp)
  80216a:	85 c0                	test   %eax,%eax
  80216c:	75 1a                	jne    802188 <__umoddi3+0x48>
  80216e:	39 f7                	cmp    %esi,%edi
  802170:	0f 86 a2 00 00 00    	jbe    802218 <__umoddi3+0xd8>
  802176:	89 c8                	mov    %ecx,%eax
  802178:	89 f2                	mov    %esi,%edx
  80217a:	f7 f7                	div    %edi
  80217c:	89 d0                	mov    %edx,%eax
  80217e:	31 d2                	xor    %edx,%edx
  802180:	83 c4 1c             	add    $0x1c,%esp
  802183:	5b                   	pop    %ebx
  802184:	5e                   	pop    %esi
  802185:	5f                   	pop    %edi
  802186:	5d                   	pop    %ebp
  802187:	c3                   	ret    
  802188:	39 f0                	cmp    %esi,%eax
  80218a:	0f 87 ac 00 00 00    	ja     80223c <__umoddi3+0xfc>
  802190:	0f bd e8             	bsr    %eax,%ebp
  802193:	83 f5 1f             	xor    $0x1f,%ebp
  802196:	0f 84 ac 00 00 00    	je     802248 <__umoddi3+0x108>
  80219c:	bf 20 00 00 00       	mov    $0x20,%edi
  8021a1:	29 ef                	sub    %ebp,%edi
  8021a3:	89 fe                	mov    %edi,%esi
  8021a5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021a9:	89 e9                	mov    %ebp,%ecx
  8021ab:	d3 e0                	shl    %cl,%eax
  8021ad:	89 d7                	mov    %edx,%edi
  8021af:	89 f1                	mov    %esi,%ecx
  8021b1:	d3 ef                	shr    %cl,%edi
  8021b3:	09 c7                	or     %eax,%edi
  8021b5:	89 e9                	mov    %ebp,%ecx
  8021b7:	d3 e2                	shl    %cl,%edx
  8021b9:	89 14 24             	mov    %edx,(%esp)
  8021bc:	89 d8                	mov    %ebx,%eax
  8021be:	d3 e0                	shl    %cl,%eax
  8021c0:	89 c2                	mov    %eax,%edx
  8021c2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021c6:	d3 e0                	shl    %cl,%eax
  8021c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021cc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021d0:	89 f1                	mov    %esi,%ecx
  8021d2:	d3 e8                	shr    %cl,%eax
  8021d4:	09 d0                	or     %edx,%eax
  8021d6:	d3 eb                	shr    %cl,%ebx
  8021d8:	89 da                	mov    %ebx,%edx
  8021da:	f7 f7                	div    %edi
  8021dc:	89 d3                	mov    %edx,%ebx
  8021de:	f7 24 24             	mull   (%esp)
  8021e1:	89 c6                	mov    %eax,%esi
  8021e3:	89 d1                	mov    %edx,%ecx
  8021e5:	39 d3                	cmp    %edx,%ebx
  8021e7:	0f 82 87 00 00 00    	jb     802274 <__umoddi3+0x134>
  8021ed:	0f 84 91 00 00 00    	je     802284 <__umoddi3+0x144>
  8021f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021f7:	29 f2                	sub    %esi,%edx
  8021f9:	19 cb                	sbb    %ecx,%ebx
  8021fb:	89 d8                	mov    %ebx,%eax
  8021fd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802201:	d3 e0                	shl    %cl,%eax
  802203:	89 e9                	mov    %ebp,%ecx
  802205:	d3 ea                	shr    %cl,%edx
  802207:	09 d0                	or     %edx,%eax
  802209:	89 e9                	mov    %ebp,%ecx
  80220b:	d3 eb                	shr    %cl,%ebx
  80220d:	89 da                	mov    %ebx,%edx
  80220f:	83 c4 1c             	add    $0x1c,%esp
  802212:	5b                   	pop    %ebx
  802213:	5e                   	pop    %esi
  802214:	5f                   	pop    %edi
  802215:	5d                   	pop    %ebp
  802216:	c3                   	ret    
  802217:	90                   	nop
  802218:	89 fd                	mov    %edi,%ebp
  80221a:	85 ff                	test   %edi,%edi
  80221c:	75 0b                	jne    802229 <__umoddi3+0xe9>
  80221e:	b8 01 00 00 00       	mov    $0x1,%eax
  802223:	31 d2                	xor    %edx,%edx
  802225:	f7 f7                	div    %edi
  802227:	89 c5                	mov    %eax,%ebp
  802229:	89 f0                	mov    %esi,%eax
  80222b:	31 d2                	xor    %edx,%edx
  80222d:	f7 f5                	div    %ebp
  80222f:	89 c8                	mov    %ecx,%eax
  802231:	f7 f5                	div    %ebp
  802233:	89 d0                	mov    %edx,%eax
  802235:	e9 44 ff ff ff       	jmp    80217e <__umoddi3+0x3e>
  80223a:	66 90                	xchg   %ax,%ax
  80223c:	89 c8                	mov    %ecx,%eax
  80223e:	89 f2                	mov    %esi,%edx
  802240:	83 c4 1c             	add    $0x1c,%esp
  802243:	5b                   	pop    %ebx
  802244:	5e                   	pop    %esi
  802245:	5f                   	pop    %edi
  802246:	5d                   	pop    %ebp
  802247:	c3                   	ret    
  802248:	3b 04 24             	cmp    (%esp),%eax
  80224b:	72 06                	jb     802253 <__umoddi3+0x113>
  80224d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802251:	77 0f                	ja     802262 <__umoddi3+0x122>
  802253:	89 f2                	mov    %esi,%edx
  802255:	29 f9                	sub    %edi,%ecx
  802257:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80225b:	89 14 24             	mov    %edx,(%esp)
  80225e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802262:	8b 44 24 04          	mov    0x4(%esp),%eax
  802266:	8b 14 24             	mov    (%esp),%edx
  802269:	83 c4 1c             	add    $0x1c,%esp
  80226c:	5b                   	pop    %ebx
  80226d:	5e                   	pop    %esi
  80226e:	5f                   	pop    %edi
  80226f:	5d                   	pop    %ebp
  802270:	c3                   	ret    
  802271:	8d 76 00             	lea    0x0(%esi),%esi
  802274:	2b 04 24             	sub    (%esp),%eax
  802277:	19 fa                	sbb    %edi,%edx
  802279:	89 d1                	mov    %edx,%ecx
  80227b:	89 c6                	mov    %eax,%esi
  80227d:	e9 71 ff ff ff       	jmp    8021f3 <__umoddi3+0xb3>
  802282:	66 90                	xchg   %ax,%ax
  802284:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802288:	72 ea                	jb     802274 <__umoddi3+0x134>
  80228a:	89 d9                	mov    %ebx,%ecx
  80228c:	e9 62 ff ff ff       	jmp    8021f3 <__umoddi3+0xb3>
