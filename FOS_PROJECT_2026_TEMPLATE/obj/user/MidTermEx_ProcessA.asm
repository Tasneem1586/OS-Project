
obj/user/MidTermEx_ProcessA:     file format elf32-i386


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
  800031:	e8 6d 02 00 00       	call   8002a3 <libmain>
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
  800048:	e8 a3 18 00 00       	call   8018f0 <sys_getparentenvid>
  80004d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800050:	83 ec 08             	sub    $0x8,%esp
  800053:	68 a0 22 80 00       	push   $0x8022a0
  800058:	ff 75 ec             	pushl  -0x14(%ebp)
  80005b:	e8 57 15 00 00       	call   8015b7 <sget>
  800060:	83 c4 10             	add    $0x10,%esp
  800063:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int *protType = sget(parentenvID, "protType") ;
  800066:	83 ec 08             	sub    $0x8,%esp
  800069:	68 a2 22 80 00       	push   $0x8022a2
  80006e:	ff 75 ec             	pushl  -0x14(%ebp)
  800071:	e8 41 15 00 00       	call   8015b7 <sget>
  800076:	83 c4 10             	add    $0x10,%esp
  800079:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int *finishedCount = sget(parentenvID, "finishedCount") ;
  80007c:	83 ec 08             	sub    $0x8,%esp
  80007f:	68 ab 22 80 00       	push   $0x8022ab
  800084:	ff 75 ec             	pushl  -0x14(%ebp)
  800087:	e8 2b 15 00 00       	call   8015b7 <sget>
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
  8000ab:	e8 bf 1b 00 00       	call   801c6f <get_semaphore>
  8000b0:	83 c4 0c             	add    $0xc,%esp
		finished = get_semaphore(parentenvID, "finished");
  8000b3:	8d 45 b8             	lea    -0x48(%ebp),%eax
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	68 bb 22 80 00       	push   $0x8022bb
  8000be:	ff 75 ec             	pushl  -0x14(%ebp)
  8000c1:	50                   	push   %eax
  8000c2:	e8 a8 1b 00 00       	call   801c6f <get_semaphore>
  8000c7:	83 c4 0c             	add    $0xc,%esp
		finishedCountMutex = get_semaphore(parentenvID, "finishedCountMutex");
  8000ca:	8d 45 b4             	lea    -0x4c(%ebp),%eax
  8000cd:	83 ec 04             	sub    $0x4,%esp
  8000d0:	68 c4 22 80 00       	push   $0x8022c4
  8000d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d8:	50                   	push   %eax
  8000d9:	e8 91 1b 00 00       	call   801c6f <get_semaphore>
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
  8000f8:	e8 ba 14 00 00       	call   8015b7 <sget>
  8000fd:	83 c4 10             	add    $0x10,%esp
  800100:	89 45 f4             	mov    %eax,-0xc(%ebp)
		sfinishedCountMutex = sget(parentenvID, "finishedCountMutex");
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	68 c4 22 80 00       	push   $0x8022c4
  80010b:	ff 75 ec             	pushl  -0x14(%ebp)
  80010e:	e8 a4 14 00 00       	call   8015b7 <sget>
  800113:	83 c4 10             	add    $0x10,%esp
  800116:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800119:	0f 31                	rdtsc  
  80011b:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80011e:	89 55 b0             	mov    %edx,-0x50(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800121:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800124:	8b 55 b0             	mov    -0x50(%ebp),%edx
  800127:	89 45 c0             	mov    %eax,-0x40(%ebp)
  80012a:	89 55 c4             	mov    %edx,-0x3c(%ebp)
	}

	/*[2] DO THE JOB*/
	int Y ;
	//random delay
	delay = RAND(2000, 10000);
  80012d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800130:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  800135:	ba 00 00 00 00       	mov    $0x0,%edx
  80013a:	f7 f1                	div    %ecx
  80013c:	89 d0                	mov    %edx,%eax
  80013e:	05 d0 07 00 00       	add    $0x7d0,%eax
  800143:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  800146:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	50                   	push   %eax
  80014d:	e8 76 1b 00 00       	call   801cc8 <env_sleep>
  800152:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	Y = (*X) * 2 ;
  800155:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	01 c0                	add    %eax,%eax
  80015c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  80015f:	0f 31                	rdtsc  
  800161:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800164:	89 55 a8             	mov    %edx,-0x58(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800167:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80016a:	8b 55 a8             	mov    -0x58(%ebp),%edx
  80016d:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800170:	89 55 cc             	mov    %edx,-0x34(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  800173:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800176:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80017b:	ba 00 00 00 00       	mov    $0x0,%edx
  800180:	f7 f1                	div    %ecx
  800182:	89 d0                	mov    %edx,%eax
  800184:	05 d0 07 00 00       	add    $0x7d0,%eax
  800189:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  80018c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80018f:	83 ec 0c             	sub    $0xc,%esp
  800192:	50                   	push   %eax
  800193:	e8 30 1b 00 00       	call   801cc8 <env_sleep>
  800198:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	(*X) = Y ;
  80019b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80019e:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8001a1:	89 10                	mov    %edx,(%eax)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  8001a3:	0f 31                	rdtsc  
  8001a5:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8001a8:	89 55 a0             	mov    %edx,-0x60(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  8001ab:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8001ae:	8b 55 a0             	mov    -0x60(%ebp),%edx
  8001b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8001b7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001ba:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8001bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8001c4:	f7 f1                	div    %ecx
  8001c6:	89 d0                	mov    %edx,%eax
  8001c8:	05 d0 07 00 00       	add    $0x7d0,%eax
  8001cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
	env_sleep(delay);
  8001d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001d3:	83 ec 0c             	sub    $0xc,%esp
  8001d6:	50                   	push   %eax
  8001d7:	e8 ec 1a 00 00       	call   801cc8 <env_sleep>
  8001dc:	83 c4 10             	add    $0x10,%esp
	//	cprintf("delay = %d\n", delay);

	if (*protType == 1)
  8001df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e2:	8b 00                	mov    (%eax),%eax
  8001e4:	83 f8 01             	cmp    $0x1,%eax
  8001e7:	75 10                	jne    8001f9 <_main+0x1c1>
	{
		signal_semaphore(T);
  8001e9:	83 ec 0c             	sub    $0xc,%esp
  8001ec:	ff 75 bc             	pushl  -0x44(%ebp)
  8001ef:	e8 af 1a 00 00       	call   801ca3 <signal_semaphore>
  8001f4:	83 c4 10             	add    $0x10,%esp
  8001f7:	eb 18                	jmp    800211 <_main+0x1d9>
	}
	else if (*protType == 2)
  8001f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	83 f8 02             	cmp    $0x2,%eax
  800201:	75 0e                	jne    800211 <_main+0x1d9>
	{
		release_uspinlock(sT);
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	ff 75 f4             	pushl  -0xc(%ebp)
  800209:	e8 f9 1b 00 00       	call   801e07 <release_uspinlock>
  80020e:	83 c4 10             	add    $0x10,%esp
	}
	/*[3] DECLARE FINISHING*/
	if (*protType == 1)
  800211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800214:	8b 00                	mov    (%eax),%eax
  800216:	83 f8 01             	cmp    $0x1,%eax
  800219:	75 39                	jne    800254 <_main+0x21c>
	{
		signal_semaphore(finished);
  80021b:	83 ec 0c             	sub    $0xc,%esp
  80021e:	ff 75 b8             	pushl  -0x48(%ebp)
  800221:	e8 7d 1a 00 00       	call   801ca3 <signal_semaphore>
  800226:	83 c4 10             	add    $0x10,%esp

		wait_semaphore(finishedCountMutex);
  800229:	83 ec 0c             	sub    $0xc,%esp
  80022c:	ff 75 b4             	pushl  -0x4c(%ebp)
  80022f:	e8 55 1a 00 00       	call   801c89 <wait_semaphore>
  800234:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
  800237:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80023a:	8b 00                	mov    (%eax),%eax
  80023c:	8d 50 01             	lea    0x1(%eax),%edx
  80023f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800242:	89 10                	mov    %edx,(%eax)
		}
		signal_semaphore(finishedCountMutex);
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	ff 75 b4             	pushl  -0x4c(%ebp)
  80024a:	e8 54 1a 00 00       	call   801ca3 <signal_semaphore>
  80024f:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
	}


}
  800252:	eb 4c                	jmp    8002a0 <_main+0x268>
		{
			(*finishedCount)++ ;
		}
		signal_semaphore(finishedCountMutex);
	}
	else if (*protType == 2)
  800254:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800257:	8b 00                	mov    (%eax),%eax
  800259:	83 f8 02             	cmp    $0x2,%eax
  80025c:	75 2b                	jne    800289 <_main+0x251>
	{
		acquire_uspinlock(sfinishedCountMutex);
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	ff 75 f0             	pushl  -0x10(%ebp)
  800264:	e8 6c 1b 00 00       	call   801dd5 <acquire_uspinlock>
  800269:	83 c4 10             	add    $0x10,%esp
		{
			(*finishedCount)++ ;
  80026c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	8d 50 01             	lea    0x1(%eax),%edx
  800274:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800277:	89 10                	mov    %edx,(%eax)
		}
		release_uspinlock(sfinishedCountMutex);
  800279:	83 ec 0c             	sub    $0xc,%esp
  80027c:	ff 75 f0             	pushl  -0x10(%ebp)
  80027f:	e8 83 1b 00 00       	call   801e07 <release_uspinlock>
  800284:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
	}


}
  800287:	eb 17                	jmp    8002a0 <_main+0x268>
		}
		release_uspinlock(sfinishedCountMutex);
	}
	else
	{
		sys_lock_cons();
  800289:	e8 d1 13 00 00       	call   80165f <sys_lock_cons>
		{
			(*finishedCount)++ ;
  80028e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800291:	8b 00                	mov    (%eax),%eax
  800293:	8d 50 01             	lea    0x1(%eax),%edx
  800296:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800299:	89 10                	mov    %edx,(%eax)
		}
		sys_unlock_cons();
  80029b:	e8 d9 13 00 00       	call   801679 <sys_unlock_cons>
	}


}
  8002a0:	90                   	nop
  8002a1:	c9                   	leave  
  8002a2:	c3                   	ret    

008002a3 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	57                   	push   %edi
  8002a7:	56                   	push   %esi
  8002a8:	53                   	push   %ebx
  8002a9:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002af:	e8 23 16 00 00       	call   8018d7 <sys_getenvindex>
  8002b4:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002ba:	89 d0                	mov    %edx,%eax
  8002bc:	c1 e0 03             	shl    $0x3,%eax
  8002bf:	01 d0                	add    %edx,%eax
  8002c1:	c1 e0 06             	shl    $0x6,%eax
  8002c4:	01 d0                	add    %edx,%eax
  8002c6:	c1 e0 03             	shl    $0x3,%eax
  8002c9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002ce:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d8:	8a 40 10             	mov    0x10(%eax),%al
  8002db:	84 c0                	test   %al,%al
  8002dd:	74 0d                	je     8002ec <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002df:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e4:	83 c0 10             	add    $0x10,%eax
  8002e7:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002f0:	7e 0a                	jle    8002fc <libmain+0x59>
		binaryname = argv[0];
  8002f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f5:	8b 00                	mov    (%eax),%eax
  8002f7:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002fc:	83 ec 08             	sub    $0x8,%esp
  8002ff:	ff 75 0c             	pushl  0xc(%ebp)
  800302:	ff 75 08             	pushl  0x8(%ebp)
  800305:	e8 2e fd ff ff       	call   800038 <_main>
  80030a:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80030d:	a1 00 30 80 00       	mov    0x803000,%eax
  800312:	85 c0                	test   %eax,%eax
  800314:	0f 84 b7 01 00 00    	je     8004d1 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80031a:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800320:	bb 14 24 80 00       	mov    $0x802414,%ebx
  800325:	ba 0e 00 00 00       	mov    $0xe,%edx
  80032a:	89 c7                	mov    %eax,%edi
  80032c:	89 de                	mov    %ebx,%esi
  80032e:	89 d1                	mov    %edx,%ecx
  800330:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800332:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800338:	b9 56 00 00 00       	mov    $0x56,%ecx
  80033d:	b0 00                	mov    $0x0,%al
  80033f:	89 d7                	mov    %edx,%edi
  800341:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800343:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80034a:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80034d:	83 ec 08             	sub    $0x8,%esp
  800350:	50                   	push   %eax
  800351:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800357:	50                   	push   %eax
  800358:	e8 7a 17 00 00       	call   801ad7 <sys_utilities>
  80035d:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800360:	e8 fa 12 00 00       	call   80165f <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	68 f0 22 80 00       	push   $0x8022f0
  80036d:	e8 71 02 00 00       	call   8005e3 <cprintf>
  800372:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800375:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800378:	85 c0                	test   %eax,%eax
  80037a:	74 58                	je     8003d4 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80037c:	e8 74 17 00 00       	call   801af5 <sys_get_optimal_num_faults>
  800381:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800384:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80038a:	bb 78 24 80 00       	mov    $0x802478,%ebx
  80038f:	ba 11 00 00 00       	mov    $0x11,%edx
  800394:	89 c7                	mov    %eax,%edi
  800396:	89 de                	mov    %ebx,%esi
  800398:	89 d1                	mov    %edx,%ecx
  80039a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80039c:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80039f:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003a4:	b0 00                	mov    $0x0,%al
  8003a6:	89 d7                	mov    %edx,%edi
  8003a8:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003aa:	83 ec 08             	sub    $0x8,%esp
  8003ad:	ff 75 dc             	pushl  -0x24(%ebp)
  8003b0:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003b6:	50                   	push   %eax
  8003b7:	e8 1b 17 00 00       	call   801ad7 <sys_utilities>
  8003bc:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003bf:	83 ec 08             	sub    $0x8,%esp
  8003c2:	ff 75 dc             	pushl  -0x24(%ebp)
  8003c5:	68 18 23 80 00       	push   $0x802318
  8003ca:	e8 14 02 00 00       	call   8005e3 <cprintf>
  8003cf:	83 c4 10             	add    $0x10,%esp
  8003d2:	eb 59                	jmp    80042d <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d9:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003df:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e4:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003ea:	83 ec 04             	sub    $0x4,%esp
  8003ed:	52                   	push   %edx
  8003ee:	50                   	push   %eax
  8003ef:	68 3c 23 80 00       	push   $0x80233c
  8003f4:	e8 ea 01 00 00       	call   8005e3 <cprintf>
  8003f9:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800401:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800407:	a1 20 30 80 00       	mov    0x803020,%eax
  80040c:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800412:	a1 20 30 80 00       	mov    0x803020,%eax
  800417:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80041d:	51                   	push   %ecx
  80041e:	52                   	push   %edx
  80041f:	50                   	push   %eax
  800420:	68 64 23 80 00       	push   $0x802364
  800425:	e8 b9 01 00 00       	call   8005e3 <cprintf>
  80042a:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80042d:	a1 20 30 80 00       	mov    0x803020,%eax
  800432:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800438:	83 ec 08             	sub    $0x8,%esp
  80043b:	50                   	push   %eax
  80043c:	68 bc 23 80 00       	push   $0x8023bc
  800441:	e8 9d 01 00 00       	call   8005e3 <cprintf>
  800446:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800449:	83 ec 0c             	sub    $0xc,%esp
  80044c:	68 d0 23 80 00       	push   $0x8023d0
  800451:	e8 8d 01 00 00       	call   8005e3 <cprintf>
  800456:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800459:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800460:	eb 28                	jmp    80048a <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800462:	a1 20 30 80 00       	mov    0x803020,%eax
  800467:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80046a:	81 c2 74 04 00 00    	add    $0x474,%edx
  800470:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800473:	83 ec 04             	sub    $0x4,%esp
  800476:	50                   	push   %eax
  800477:	ff 75 e4             	pushl  -0x1c(%ebp)
  80047a:	68 e7 23 80 00       	push   $0x8023e7
  80047f:	e8 5f 01 00 00       	call   8005e3 <cprintf>
  800484:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800487:	ff 45 e4             	incl   -0x1c(%ebp)
  80048a:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80048e:	7e d2                	jle    800462 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800490:	83 ec 0c             	sub    $0xc,%esp
  800493:	68 f6 23 80 00       	push   $0x8023f6
  800498:	e8 46 01 00 00       	call   8005e3 <cprintf>
  80049d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8004a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a5:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004ab:	83 ec 08             	sub    $0x8,%esp
  8004ae:	50                   	push   %eax
  8004af:	68 fa 23 80 00       	push   $0x8023fa
  8004b4:	e8 2a 01 00 00       	call   8005e3 <cprintf>
  8004b9:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004bc:	83 ec 0c             	sub    $0xc,%esp
  8004bf:	68 f0 22 80 00       	push   $0x8022f0
  8004c4:	e8 1a 01 00 00       	call   8005e3 <cprintf>
  8004c9:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004cc:	e8 a8 11 00 00       	call   801679 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004d1:	e8 1f 00 00 00       	call   8004f5 <exit>
}
  8004d6:	90                   	nop
  8004d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004da:	5b                   	pop    %ebx
  8004db:	5e                   	pop    %esi
  8004dc:	5f                   	pop    %edi
  8004dd:	5d                   	pop    %ebp
  8004de:	c3                   	ret    

008004df <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004df:	55                   	push   %ebp
  8004e0:	89 e5                	mov    %esp,%ebp
  8004e2:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004e5:	83 ec 0c             	sub    $0xc,%esp
  8004e8:	6a 00                	push   $0x0
  8004ea:	e8 b4 13 00 00       	call   8018a3 <sys_destroy_env>
  8004ef:	83 c4 10             	add    $0x10,%esp
}
  8004f2:	90                   	nop
  8004f3:	c9                   	leave  
  8004f4:	c3                   	ret    

008004f5 <exit>:

void
exit(void)
{
  8004f5:	55                   	push   %ebp
  8004f6:	89 e5                	mov    %esp,%ebp
  8004f8:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004fb:	e8 09 14 00 00       	call   801909 <sys_exit_env>
}
  800500:	90                   	nop
  800501:	c9                   	leave  
  800502:	c3                   	ret    

00800503 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800503:	55                   	push   %ebp
  800504:	89 e5                	mov    %esp,%ebp
  800506:	53                   	push   %ebx
  800507:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80050a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050d:	8b 00                	mov    (%eax),%eax
  80050f:	8d 48 01             	lea    0x1(%eax),%ecx
  800512:	8b 55 0c             	mov    0xc(%ebp),%edx
  800515:	89 0a                	mov    %ecx,(%edx)
  800517:	8b 55 08             	mov    0x8(%ebp),%edx
  80051a:	88 d1                	mov    %dl,%cl
  80051c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800523:	8b 45 0c             	mov    0xc(%ebp),%eax
  800526:	8b 00                	mov    (%eax),%eax
  800528:	3d ff 00 00 00       	cmp    $0xff,%eax
  80052d:	75 30                	jne    80055f <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80052f:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800535:	a0 40 30 80 00       	mov    0x803040,%al
  80053a:	0f b6 c0             	movzbl %al,%eax
  80053d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800540:	8b 09                	mov    (%ecx),%ecx
  800542:	89 cb                	mov    %ecx,%ebx
  800544:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800547:	83 c1 08             	add    $0x8,%ecx
  80054a:	52                   	push   %edx
  80054b:	50                   	push   %eax
  80054c:	53                   	push   %ebx
  80054d:	51                   	push   %ecx
  80054e:	e8 c8 10 00 00       	call   80161b <sys_cputs>
  800553:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800556:	8b 45 0c             	mov    0xc(%ebp),%eax
  800559:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80055f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800562:	8b 40 04             	mov    0x4(%eax),%eax
  800565:	8d 50 01             	lea    0x1(%eax),%edx
  800568:	8b 45 0c             	mov    0xc(%ebp),%eax
  80056b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80056e:	90                   	nop
  80056f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800572:	c9                   	leave  
  800573:	c3                   	ret    

00800574 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800574:	55                   	push   %ebp
  800575:	89 e5                	mov    %esp,%ebp
  800577:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80057d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800584:	00 00 00 
	b.cnt = 0;
  800587:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80058e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800591:	ff 75 0c             	pushl  0xc(%ebp)
  800594:	ff 75 08             	pushl  0x8(%ebp)
  800597:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80059d:	50                   	push   %eax
  80059e:	68 03 05 80 00       	push   $0x800503
  8005a3:	e8 5a 02 00 00       	call   800802 <vprintfmt>
  8005a8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8005ab:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8005b1:	a0 40 30 80 00       	mov    0x803040,%al
  8005b6:	0f b6 c0             	movzbl %al,%eax
  8005b9:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8005bf:	52                   	push   %edx
  8005c0:	50                   	push   %eax
  8005c1:	51                   	push   %ecx
  8005c2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c8:	83 c0 08             	add    $0x8,%eax
  8005cb:	50                   	push   %eax
  8005cc:	e8 4a 10 00 00       	call   80161b <sys_cputs>
  8005d1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005d4:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8005db:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005e1:	c9                   	leave  
  8005e2:	c3                   	ret    

008005e3 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8005e3:	55                   	push   %ebp
  8005e4:	89 e5                	mov    %esp,%ebp
  8005e6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005e9:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005f0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	83 ec 08             	sub    $0x8,%esp
  8005fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ff:	50                   	push   %eax
  800600:	e8 6f ff ff ff       	call   800574 <vcprintf>
  800605:	83 c4 10             	add    $0x10,%esp
  800608:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80060e:	c9                   	leave  
  80060f:	c3                   	ret    

00800610 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800610:	55                   	push   %ebp
  800611:	89 e5                	mov    %esp,%ebp
  800613:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800616:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	c1 e0 08             	shl    $0x8,%eax
  800623:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800628:	8d 45 0c             	lea    0xc(%ebp),%eax
  80062b:	83 c0 04             	add    $0x4,%eax
  80062e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	83 ec 08             	sub    $0x8,%esp
  800637:	ff 75 f4             	pushl  -0xc(%ebp)
  80063a:	50                   	push   %eax
  80063b:	e8 34 ff ff ff       	call   800574 <vcprintf>
  800640:	83 c4 10             	add    $0x10,%esp
  800643:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800646:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  80064d:	07 00 00 

	return cnt;
  800650:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800653:	c9                   	leave  
  800654:	c3                   	ret    

00800655 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800655:	55                   	push   %ebp
  800656:	89 e5                	mov    %esp,%ebp
  800658:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80065b:	e8 ff 0f 00 00       	call   80165f <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800660:	8d 45 0c             	lea    0xc(%ebp),%eax
  800663:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	83 ec 08             	sub    $0x8,%esp
  80066c:	ff 75 f4             	pushl  -0xc(%ebp)
  80066f:	50                   	push   %eax
  800670:	e8 ff fe ff ff       	call   800574 <vcprintf>
  800675:	83 c4 10             	add    $0x10,%esp
  800678:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80067b:	e8 f9 0f 00 00       	call   801679 <sys_unlock_cons>
	return cnt;
  800680:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800683:	c9                   	leave  
  800684:	c3                   	ret    

00800685 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800685:	55                   	push   %ebp
  800686:	89 e5                	mov    %esp,%ebp
  800688:	53                   	push   %ebx
  800689:	83 ec 14             	sub    $0x14,%esp
  80068c:	8b 45 10             	mov    0x10(%ebp),%eax
  80068f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800692:	8b 45 14             	mov    0x14(%ebp),%eax
  800695:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800698:	8b 45 18             	mov    0x18(%ebp),%eax
  80069b:	ba 00 00 00 00       	mov    $0x0,%edx
  8006a0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a3:	77 55                	ja     8006fa <printnum+0x75>
  8006a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a8:	72 05                	jb     8006af <printnum+0x2a>
  8006aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006ad:	77 4b                	ja     8006fa <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006af:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006b2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006b5:	8b 45 18             	mov    0x18(%ebp),%eax
  8006b8:	ba 00 00 00 00       	mov    $0x0,%edx
  8006bd:	52                   	push   %edx
  8006be:	50                   	push   %eax
  8006bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c2:	ff 75 f0             	pushl  -0x10(%ebp)
  8006c5:	e8 66 19 00 00       	call   802030 <__udivdi3>
  8006ca:	83 c4 10             	add    $0x10,%esp
  8006cd:	83 ec 04             	sub    $0x4,%esp
  8006d0:	ff 75 20             	pushl  0x20(%ebp)
  8006d3:	53                   	push   %ebx
  8006d4:	ff 75 18             	pushl  0x18(%ebp)
  8006d7:	52                   	push   %edx
  8006d8:	50                   	push   %eax
  8006d9:	ff 75 0c             	pushl  0xc(%ebp)
  8006dc:	ff 75 08             	pushl  0x8(%ebp)
  8006df:	e8 a1 ff ff ff       	call   800685 <printnum>
  8006e4:	83 c4 20             	add    $0x20,%esp
  8006e7:	eb 1a                	jmp    800703 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	ff 75 20             	pushl  0x20(%ebp)
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	ff d0                	call   *%eax
  8006f7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006fa:	ff 4d 1c             	decl   0x1c(%ebp)
  8006fd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800701:	7f e6                	jg     8006e9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800703:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800706:	bb 00 00 00 00       	mov    $0x0,%ebx
  80070b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800711:	53                   	push   %ebx
  800712:	51                   	push   %ecx
  800713:	52                   	push   %edx
  800714:	50                   	push   %eax
  800715:	e8 26 1a 00 00       	call   802140 <__umoddi3>
  80071a:	83 c4 10             	add    $0x10,%esp
  80071d:	05 f4 26 80 00       	add    $0x8026f4,%eax
  800722:	8a 00                	mov    (%eax),%al
  800724:	0f be c0             	movsbl %al,%eax
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	50                   	push   %eax
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	ff d0                	call   *%eax
  800733:	83 c4 10             	add    $0x10,%esp
}
  800736:	90                   	nop
  800737:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80073a:	c9                   	leave  
  80073b:	c3                   	ret    

0080073c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80073c:	55                   	push   %ebp
  80073d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80073f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800743:	7e 1c                	jle    800761 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	8d 50 08             	lea    0x8(%eax),%edx
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	89 10                	mov    %edx,(%eax)
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	8b 00                	mov    (%eax),%eax
  800757:	83 e8 08             	sub    $0x8,%eax
  80075a:	8b 50 04             	mov    0x4(%eax),%edx
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	eb 40                	jmp    8007a1 <getuint+0x65>
	else if (lflag)
  800761:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800765:	74 1e                	je     800785 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	8d 50 04             	lea    0x4(%eax),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	89 10                	mov    %edx,(%eax)
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	8b 00                	mov    (%eax),%eax
  800779:	83 e8 04             	sub    $0x4,%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	ba 00 00 00 00       	mov    $0x0,%edx
  800783:	eb 1c                	jmp    8007a1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	8d 50 04             	lea    0x4(%eax),%edx
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	89 10                	mov    %edx,(%eax)
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	83 e8 04             	sub    $0x4,%eax
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007a1:	5d                   	pop    %ebp
  8007a2:	c3                   	ret    

008007a3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007a3:	55                   	push   %ebp
  8007a4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007aa:	7e 1c                	jle    8007c8 <getint+0x25>
		return va_arg(*ap, long long);
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	8d 50 08             	lea    0x8(%eax),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	89 10                	mov    %edx,(%eax)
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	8b 00                	mov    (%eax),%eax
  8007be:	83 e8 08             	sub    $0x8,%eax
  8007c1:	8b 50 04             	mov    0x4(%eax),%edx
  8007c4:	8b 00                	mov    (%eax),%eax
  8007c6:	eb 38                	jmp    800800 <getint+0x5d>
	else if (lflag)
  8007c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007cc:	74 1a                	je     8007e8 <getint+0x45>
		return va_arg(*ap, long);
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	8d 50 04             	lea    0x4(%eax),%edx
  8007d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d9:	89 10                	mov    %edx,(%eax)
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	83 e8 04             	sub    $0x4,%eax
  8007e3:	8b 00                	mov    (%eax),%eax
  8007e5:	99                   	cltd   
  8007e6:	eb 18                	jmp    800800 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007eb:	8b 00                	mov    (%eax),%eax
  8007ed:	8d 50 04             	lea    0x4(%eax),%edx
  8007f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f3:	89 10                	mov    %edx,(%eax)
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	8b 00                	mov    (%eax),%eax
  8007fa:	83 e8 04             	sub    $0x4,%eax
  8007fd:	8b 00                	mov    (%eax),%eax
  8007ff:	99                   	cltd   
}
  800800:	5d                   	pop    %ebp
  800801:	c3                   	ret    

00800802 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800802:	55                   	push   %ebp
  800803:	89 e5                	mov    %esp,%ebp
  800805:	56                   	push   %esi
  800806:	53                   	push   %ebx
  800807:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80080a:	eb 17                	jmp    800823 <vprintfmt+0x21>
			if (ch == '\0')
  80080c:	85 db                	test   %ebx,%ebx
  80080e:	0f 84 c1 03 00 00    	je     800bd5 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800814:	83 ec 08             	sub    $0x8,%esp
  800817:	ff 75 0c             	pushl  0xc(%ebp)
  80081a:	53                   	push   %ebx
  80081b:	8b 45 08             	mov    0x8(%ebp),%eax
  80081e:	ff d0                	call   *%eax
  800820:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800823:	8b 45 10             	mov    0x10(%ebp),%eax
  800826:	8d 50 01             	lea    0x1(%eax),%edx
  800829:	89 55 10             	mov    %edx,0x10(%ebp)
  80082c:	8a 00                	mov    (%eax),%al
  80082e:	0f b6 d8             	movzbl %al,%ebx
  800831:	83 fb 25             	cmp    $0x25,%ebx
  800834:	75 d6                	jne    80080c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800836:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80083a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800841:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800848:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80084f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800856:	8b 45 10             	mov    0x10(%ebp),%eax
  800859:	8d 50 01             	lea    0x1(%eax),%edx
  80085c:	89 55 10             	mov    %edx,0x10(%ebp)
  80085f:	8a 00                	mov    (%eax),%al
  800861:	0f b6 d8             	movzbl %al,%ebx
  800864:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800867:	83 f8 5b             	cmp    $0x5b,%eax
  80086a:	0f 87 3d 03 00 00    	ja     800bad <vprintfmt+0x3ab>
  800870:	8b 04 85 18 27 80 00 	mov    0x802718(,%eax,4),%eax
  800877:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800879:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80087d:	eb d7                	jmp    800856 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80087f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800883:	eb d1                	jmp    800856 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800885:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80088c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80088f:	89 d0                	mov    %edx,%eax
  800891:	c1 e0 02             	shl    $0x2,%eax
  800894:	01 d0                	add    %edx,%eax
  800896:	01 c0                	add    %eax,%eax
  800898:	01 d8                	add    %ebx,%eax
  80089a:	83 e8 30             	sub    $0x30,%eax
  80089d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a3:	8a 00                	mov    (%eax),%al
  8008a5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008a8:	83 fb 2f             	cmp    $0x2f,%ebx
  8008ab:	7e 3e                	jle    8008eb <vprintfmt+0xe9>
  8008ad:	83 fb 39             	cmp    $0x39,%ebx
  8008b0:	7f 39                	jg     8008eb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008b5:	eb d5                	jmp    80088c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ba:	83 c0 04             	add    $0x4,%eax
  8008bd:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c3:	83 e8 04             	sub    $0x4,%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008cb:	eb 1f                	jmp    8008ec <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d1:	79 83                	jns    800856 <vprintfmt+0x54>
				width = 0;
  8008d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008da:	e9 77 ff ff ff       	jmp    800856 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008df:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008e6:	e9 6b ff ff ff       	jmp    800856 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008eb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f0:	0f 89 60 ff ff ff    	jns    800856 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008fc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800903:	e9 4e ff ff ff       	jmp    800856 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800908:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80090b:	e9 46 ff ff ff       	jmp    800856 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800910:	8b 45 14             	mov    0x14(%ebp),%eax
  800913:	83 c0 04             	add    $0x4,%eax
  800916:	89 45 14             	mov    %eax,0x14(%ebp)
  800919:	8b 45 14             	mov    0x14(%ebp),%eax
  80091c:	83 e8 04             	sub    $0x4,%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	ff 75 0c             	pushl  0xc(%ebp)
  800927:	50                   	push   %eax
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	ff d0                	call   *%eax
  80092d:	83 c4 10             	add    $0x10,%esp
			break;
  800930:	e9 9b 02 00 00       	jmp    800bd0 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800935:	8b 45 14             	mov    0x14(%ebp),%eax
  800938:	83 c0 04             	add    $0x4,%eax
  80093b:	89 45 14             	mov    %eax,0x14(%ebp)
  80093e:	8b 45 14             	mov    0x14(%ebp),%eax
  800941:	83 e8 04             	sub    $0x4,%eax
  800944:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800946:	85 db                	test   %ebx,%ebx
  800948:	79 02                	jns    80094c <vprintfmt+0x14a>
				err = -err;
  80094a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80094c:	83 fb 64             	cmp    $0x64,%ebx
  80094f:	7f 0b                	jg     80095c <vprintfmt+0x15a>
  800951:	8b 34 9d 60 25 80 00 	mov    0x802560(,%ebx,4),%esi
  800958:	85 f6                	test   %esi,%esi
  80095a:	75 19                	jne    800975 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80095c:	53                   	push   %ebx
  80095d:	68 05 27 80 00       	push   $0x802705
  800962:	ff 75 0c             	pushl  0xc(%ebp)
  800965:	ff 75 08             	pushl  0x8(%ebp)
  800968:	e8 70 02 00 00       	call   800bdd <printfmt>
  80096d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800970:	e9 5b 02 00 00       	jmp    800bd0 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800975:	56                   	push   %esi
  800976:	68 0e 27 80 00       	push   $0x80270e
  80097b:	ff 75 0c             	pushl  0xc(%ebp)
  80097e:	ff 75 08             	pushl  0x8(%ebp)
  800981:	e8 57 02 00 00       	call   800bdd <printfmt>
  800986:	83 c4 10             	add    $0x10,%esp
			break;
  800989:	e9 42 02 00 00       	jmp    800bd0 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80098e:	8b 45 14             	mov    0x14(%ebp),%eax
  800991:	83 c0 04             	add    $0x4,%eax
  800994:	89 45 14             	mov    %eax,0x14(%ebp)
  800997:	8b 45 14             	mov    0x14(%ebp),%eax
  80099a:	83 e8 04             	sub    $0x4,%eax
  80099d:	8b 30                	mov    (%eax),%esi
  80099f:	85 f6                	test   %esi,%esi
  8009a1:	75 05                	jne    8009a8 <vprintfmt+0x1a6>
				p = "(null)";
  8009a3:	be 11 27 80 00       	mov    $0x802711,%esi
			if (width > 0 && padc != '-')
  8009a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ac:	7e 6d                	jle    800a1b <vprintfmt+0x219>
  8009ae:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009b2:	74 67                	je     800a1b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b7:	83 ec 08             	sub    $0x8,%esp
  8009ba:	50                   	push   %eax
  8009bb:	56                   	push   %esi
  8009bc:	e8 1e 03 00 00       	call   800cdf <strnlen>
  8009c1:	83 c4 10             	add    $0x10,%esp
  8009c4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009c7:	eb 16                	jmp    8009df <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009c9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 0c             	pushl  0xc(%ebp)
  8009d3:	50                   	push   %eax
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	ff d0                	call   *%eax
  8009d9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009dc:	ff 4d e4             	decl   -0x1c(%ebp)
  8009df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e3:	7f e4                	jg     8009c9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e5:	eb 34                	jmp    800a1b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009e7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009eb:	74 1c                	je     800a09 <vprintfmt+0x207>
  8009ed:	83 fb 1f             	cmp    $0x1f,%ebx
  8009f0:	7e 05                	jle    8009f7 <vprintfmt+0x1f5>
  8009f2:	83 fb 7e             	cmp    $0x7e,%ebx
  8009f5:	7e 12                	jle    800a09 <vprintfmt+0x207>
					putch('?', putdat);
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	6a 3f                	push   $0x3f
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	ff d0                	call   *%eax
  800a04:	83 c4 10             	add    $0x10,%esp
  800a07:	eb 0f                	jmp    800a18 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a09:	83 ec 08             	sub    $0x8,%esp
  800a0c:	ff 75 0c             	pushl  0xc(%ebp)
  800a0f:	53                   	push   %ebx
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	ff d0                	call   *%eax
  800a15:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a18:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1b:	89 f0                	mov    %esi,%eax
  800a1d:	8d 70 01             	lea    0x1(%eax),%esi
  800a20:	8a 00                	mov    (%eax),%al
  800a22:	0f be d8             	movsbl %al,%ebx
  800a25:	85 db                	test   %ebx,%ebx
  800a27:	74 24                	je     800a4d <vprintfmt+0x24b>
  800a29:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a2d:	78 b8                	js     8009e7 <vprintfmt+0x1e5>
  800a2f:	ff 4d e0             	decl   -0x20(%ebp)
  800a32:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a36:	79 af                	jns    8009e7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a38:	eb 13                	jmp    800a4d <vprintfmt+0x24b>
				putch(' ', putdat);
  800a3a:	83 ec 08             	sub    $0x8,%esp
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	6a 20                	push   $0x20
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	ff d0                	call   *%eax
  800a47:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a4a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a4d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a51:	7f e7                	jg     800a3a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a53:	e9 78 01 00 00       	jmp    800bd0 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a61:	50                   	push   %eax
  800a62:	e8 3c fd ff ff       	call   8007a3 <getint>
  800a67:	83 c4 10             	add    $0x10,%esp
  800a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a70:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a73:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a76:	85 d2                	test   %edx,%edx
  800a78:	79 23                	jns    800a9d <vprintfmt+0x29b>
				putch('-', putdat);
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	6a 2d                	push   $0x2d
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	ff d0                	call   *%eax
  800a87:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a90:	f7 d8                	neg    %eax
  800a92:	83 d2 00             	adc    $0x0,%edx
  800a95:	f7 da                	neg    %edx
  800a97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a9d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa4:	e9 bc 00 00 00       	jmp    800b65 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	ff 75 e8             	pushl  -0x18(%ebp)
  800aaf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab2:	50                   	push   %eax
  800ab3:	e8 84 fc ff ff       	call   80073c <getuint>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ac1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ac8:	e9 98 00 00 00       	jmp    800b65 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800acd:	83 ec 08             	sub    $0x8,%esp
  800ad0:	ff 75 0c             	pushl  0xc(%ebp)
  800ad3:	6a 58                	push   $0x58
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	ff d0                	call   *%eax
  800ada:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800add:	83 ec 08             	sub    $0x8,%esp
  800ae0:	ff 75 0c             	pushl  0xc(%ebp)
  800ae3:	6a 58                	push   $0x58
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	ff d0                	call   *%eax
  800aea:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aed:	83 ec 08             	sub    $0x8,%esp
  800af0:	ff 75 0c             	pushl  0xc(%ebp)
  800af3:	6a 58                	push   $0x58
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	ff d0                	call   *%eax
  800afa:	83 c4 10             	add    $0x10,%esp
			break;
  800afd:	e9 ce 00 00 00       	jmp    800bd0 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b02:	83 ec 08             	sub    $0x8,%esp
  800b05:	ff 75 0c             	pushl  0xc(%ebp)
  800b08:	6a 30                	push   $0x30
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	ff d0                	call   *%eax
  800b0f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b12:	83 ec 08             	sub    $0x8,%esp
  800b15:	ff 75 0c             	pushl  0xc(%ebp)
  800b18:	6a 78                	push   $0x78
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	ff d0                	call   *%eax
  800b1f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b22:	8b 45 14             	mov    0x14(%ebp),%eax
  800b25:	83 c0 04             	add    $0x4,%eax
  800b28:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2e:	83 e8 04             	sub    $0x4,%eax
  800b31:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b3d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b44:	eb 1f                	jmp    800b65 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b46:	83 ec 08             	sub    $0x8,%esp
  800b49:	ff 75 e8             	pushl  -0x18(%ebp)
  800b4c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b4f:	50                   	push   %eax
  800b50:	e8 e7 fb ff ff       	call   80073c <getuint>
  800b55:	83 c4 10             	add    $0x10,%esp
  800b58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b5e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b65:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b69:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b6c:	83 ec 04             	sub    $0x4,%esp
  800b6f:	52                   	push   %edx
  800b70:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b73:	50                   	push   %eax
  800b74:	ff 75 f4             	pushl  -0xc(%ebp)
  800b77:	ff 75 f0             	pushl  -0x10(%ebp)
  800b7a:	ff 75 0c             	pushl  0xc(%ebp)
  800b7d:	ff 75 08             	pushl  0x8(%ebp)
  800b80:	e8 00 fb ff ff       	call   800685 <printnum>
  800b85:	83 c4 20             	add    $0x20,%esp
			break;
  800b88:	eb 46                	jmp    800bd0 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	53                   	push   %ebx
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	ff d0                	call   *%eax
  800b96:	83 c4 10             	add    $0x10,%esp
			break;
  800b99:	eb 35                	jmp    800bd0 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b9b:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800ba2:	eb 2c                	jmp    800bd0 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800ba4:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800bab:	eb 23                	jmp    800bd0 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 0c             	pushl  0xc(%ebp)
  800bb3:	6a 25                	push   $0x25
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	ff d0                	call   *%eax
  800bba:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bbd:	ff 4d 10             	decl   0x10(%ebp)
  800bc0:	eb 03                	jmp    800bc5 <vprintfmt+0x3c3>
  800bc2:	ff 4d 10             	decl   0x10(%ebp)
  800bc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc8:	48                   	dec    %eax
  800bc9:	8a 00                	mov    (%eax),%al
  800bcb:	3c 25                	cmp    $0x25,%al
  800bcd:	75 f3                	jne    800bc2 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800bcf:	90                   	nop
		}
	}
  800bd0:	e9 35 fc ff ff       	jmp    80080a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bd5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bd9:	5b                   	pop    %ebx
  800bda:	5e                   	pop    %esi
  800bdb:	5d                   	pop    %ebp
  800bdc:	c3                   	ret    

00800bdd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bdd:	55                   	push   %ebp
  800bde:	89 e5                	mov    %esp,%ebp
  800be0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800be3:	8d 45 10             	lea    0x10(%ebp),%eax
  800be6:	83 c0 04             	add    $0x4,%eax
  800be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bec:	8b 45 10             	mov    0x10(%ebp),%eax
  800bef:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf2:	50                   	push   %eax
  800bf3:	ff 75 0c             	pushl  0xc(%ebp)
  800bf6:	ff 75 08             	pushl  0x8(%ebp)
  800bf9:	e8 04 fc ff ff       	call   800802 <vprintfmt>
  800bfe:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c01:	90                   	nop
  800c02:	c9                   	leave  
  800c03:	c3                   	ret    

00800c04 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c04:	55                   	push   %ebp
  800c05:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0a:	8b 40 08             	mov    0x8(%eax),%eax
  800c0d:	8d 50 01             	lea    0x1(%eax),%edx
  800c10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c13:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	8b 10                	mov    (%eax),%edx
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	8b 40 04             	mov    0x4(%eax),%eax
  800c21:	39 c2                	cmp    %eax,%edx
  800c23:	73 12                	jae    800c37 <sprintputch+0x33>
		*b->buf++ = ch;
  800c25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c28:	8b 00                	mov    (%eax),%eax
  800c2a:	8d 48 01             	lea    0x1(%eax),%ecx
  800c2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c30:	89 0a                	mov    %ecx,(%edx)
  800c32:	8b 55 08             	mov    0x8(%ebp),%edx
  800c35:	88 10                	mov    %dl,(%eax)
}
  800c37:	90                   	nop
  800c38:	5d                   	pop    %ebp
  800c39:	c3                   	ret    

00800c3a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
  800c3d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	01 d0                	add    %edx,%eax
  800c51:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c5b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c5f:	74 06                	je     800c67 <vsnprintf+0x2d>
  800c61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c65:	7f 07                	jg     800c6e <vsnprintf+0x34>
		return -E_INVAL;
  800c67:	b8 03 00 00 00       	mov    $0x3,%eax
  800c6c:	eb 20                	jmp    800c8e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c6e:	ff 75 14             	pushl  0x14(%ebp)
  800c71:	ff 75 10             	pushl  0x10(%ebp)
  800c74:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c77:	50                   	push   %eax
  800c78:	68 04 0c 80 00       	push   $0x800c04
  800c7d:	e8 80 fb ff ff       	call   800802 <vprintfmt>
  800c82:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c85:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c88:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c8e:	c9                   	leave  
  800c8f:	c3                   	ret    

00800c90 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c90:	55                   	push   %ebp
  800c91:	89 e5                	mov    %esp,%ebp
  800c93:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c96:	8d 45 10             	lea    0x10(%ebp),%eax
  800c99:	83 c0 04             	add    $0x4,%eax
  800c9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca5:	50                   	push   %eax
  800ca6:	ff 75 0c             	pushl  0xc(%ebp)
  800ca9:	ff 75 08             	pushl  0x8(%ebp)
  800cac:	e8 89 ff ff ff       	call   800c3a <vsnprintf>
  800cb1:	83 c4 10             	add    $0x10,%esp
  800cb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cba:	c9                   	leave  
  800cbb:	c3                   	ret    

00800cbc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cbc:	55                   	push   %ebp
  800cbd:	89 e5                	mov    %esp,%ebp
  800cbf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cc9:	eb 06                	jmp    800cd1 <strlen+0x15>
		n++;
  800ccb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cce:	ff 45 08             	incl   0x8(%ebp)
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	84 c0                	test   %al,%al
  800cd8:	75 f1                	jne    800ccb <strlen+0xf>
		n++;
	return n;
  800cda:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cdd:	c9                   	leave  
  800cde:	c3                   	ret    

00800cdf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cdf:	55                   	push   %ebp
  800ce0:	89 e5                	mov    %esp,%ebp
  800ce2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ce5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cec:	eb 09                	jmp    800cf7 <strnlen+0x18>
		n++;
  800cee:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cf1:	ff 45 08             	incl   0x8(%ebp)
  800cf4:	ff 4d 0c             	decl   0xc(%ebp)
  800cf7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cfb:	74 09                	je     800d06 <strnlen+0x27>
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	84 c0                	test   %al,%al
  800d04:	75 e8                	jne    800cee <strnlen+0xf>
		n++;
	return n;
  800d06:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d09:	c9                   	leave  
  800d0a:	c3                   	ret    

00800d0b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
  800d0e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d17:	90                   	nop
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8d 50 01             	lea    0x1(%eax),%edx
  800d1e:	89 55 08             	mov    %edx,0x8(%ebp)
  800d21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d24:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d27:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d2a:	8a 12                	mov    (%edx),%dl
  800d2c:	88 10                	mov    %dl,(%eax)
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	84 c0                	test   %al,%al
  800d32:	75 e4                	jne    800d18 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d37:	c9                   	leave  
  800d38:	c3                   	ret    

00800d39 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d39:	55                   	push   %ebp
  800d3a:	89 e5                	mov    %esp,%ebp
  800d3c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d4c:	eb 1f                	jmp    800d6d <strncpy+0x34>
		*dst++ = *src;
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8d 50 01             	lea    0x1(%eax),%edx
  800d54:	89 55 08             	mov    %edx,0x8(%ebp)
  800d57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5a:	8a 12                	mov    (%edx),%dl
  800d5c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	84 c0                	test   %al,%al
  800d65:	74 03                	je     800d6a <strncpy+0x31>
			src++;
  800d67:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d6a:	ff 45 fc             	incl   -0x4(%ebp)
  800d6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d70:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d73:	72 d9                	jb     800d4e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d75:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
  800d7d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d8a:	74 30                	je     800dbc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d8c:	eb 16                	jmp    800da4 <strlcpy+0x2a>
			*dst++ = *src++;
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8d 50 01             	lea    0x1(%eax),%edx
  800d94:	89 55 08             	mov    %edx,0x8(%ebp)
  800d97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800da0:	8a 12                	mov    (%edx),%dl
  800da2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800da4:	ff 4d 10             	decl   0x10(%ebp)
  800da7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dab:	74 09                	je     800db6 <strlcpy+0x3c>
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	84 c0                	test   %al,%al
  800db4:	75 d8                	jne    800d8e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dbc:	8b 55 08             	mov    0x8(%ebp),%edx
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	29 c2                	sub    %eax,%edx
  800dc4:	89 d0                	mov    %edx,%eax
}
  800dc6:	c9                   	leave  
  800dc7:	c3                   	ret    

00800dc8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dc8:	55                   	push   %ebp
  800dc9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dcb:	eb 06                	jmp    800dd3 <strcmp+0xb>
		p++, q++;
  800dcd:	ff 45 08             	incl   0x8(%ebp)
  800dd0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	84 c0                	test   %al,%al
  800dda:	74 0e                	je     800dea <strcmp+0x22>
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	8a 10                	mov    (%eax),%dl
  800de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	38 c2                	cmp    %al,%dl
  800de8:	74 e3                	je     800dcd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	0f b6 d0             	movzbl %al,%edx
  800df2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	0f b6 c0             	movzbl %al,%eax
  800dfa:	29 c2                	sub    %eax,%edx
  800dfc:	89 d0                	mov    %edx,%eax
}
  800dfe:	5d                   	pop    %ebp
  800dff:	c3                   	ret    

00800e00 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e03:	eb 09                	jmp    800e0e <strncmp+0xe>
		n--, p++, q++;
  800e05:	ff 4d 10             	decl   0x10(%ebp)
  800e08:	ff 45 08             	incl   0x8(%ebp)
  800e0b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e12:	74 17                	je     800e2b <strncmp+0x2b>
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	8a 00                	mov    (%eax),%al
  800e19:	84 c0                	test   %al,%al
  800e1b:	74 0e                	je     800e2b <strncmp+0x2b>
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8a 10                	mov    (%eax),%dl
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	38 c2                	cmp    %al,%dl
  800e29:	74 da                	je     800e05 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e2f:	75 07                	jne    800e38 <strncmp+0x38>
		return 0;
  800e31:	b8 00 00 00 00       	mov    $0x0,%eax
  800e36:	eb 14                	jmp    800e4c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	8a 00                	mov    (%eax),%al
  800e3d:	0f b6 d0             	movzbl %al,%edx
  800e40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e43:	8a 00                	mov    (%eax),%al
  800e45:	0f b6 c0             	movzbl %al,%eax
  800e48:	29 c2                	sub    %eax,%edx
  800e4a:	89 d0                	mov    %edx,%eax
}
  800e4c:	5d                   	pop    %ebp
  800e4d:	c3                   	ret    

00800e4e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e4e:	55                   	push   %ebp
  800e4f:	89 e5                	mov    %esp,%ebp
  800e51:	83 ec 04             	sub    $0x4,%esp
  800e54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e57:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e5a:	eb 12                	jmp    800e6e <strchr+0x20>
		if (*s == c)
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e64:	75 05                	jne    800e6b <strchr+0x1d>
			return (char *) s;
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	eb 11                	jmp    800e7c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e6b:	ff 45 08             	incl   0x8(%ebp)
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8a 00                	mov    (%eax),%al
  800e73:	84 c0                	test   %al,%al
  800e75:	75 e5                	jne    800e5c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e77:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e7c:	c9                   	leave  
  800e7d:	c3                   	ret    

00800e7e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
  800e81:	83 ec 04             	sub    $0x4,%esp
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e8a:	eb 0d                	jmp    800e99 <strfind+0x1b>
		if (*s == c)
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e94:	74 0e                	je     800ea4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e96:	ff 45 08             	incl   0x8(%ebp)
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	8a 00                	mov    (%eax),%al
  800e9e:	84 c0                	test   %al,%al
  800ea0:	75 ea                	jne    800e8c <strfind+0xe>
  800ea2:	eb 01                	jmp    800ea5 <strfind+0x27>
		if (*s == c)
			break;
  800ea4:	90                   	nop
	return (char *) s;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea8:	c9                   	leave  
  800ea9:	c3                   	ret    

00800eaa <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800eaa:	55                   	push   %ebp
  800eab:	89 e5                	mov    %esp,%ebp
  800ead:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800eb6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800eba:	76 63                	jbe    800f1f <memset+0x75>
		uint64 data_block = c;
  800ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebf:	99                   	cltd   
  800ec0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec3:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ecc:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800ed0:	c1 e0 08             	shl    $0x8,%eax
  800ed3:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ed6:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ed9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800edc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800edf:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800ee3:	c1 e0 10             	shl    $0x10,%eax
  800ee6:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ee9:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800eec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef2:	89 c2                	mov    %eax,%edx
  800ef4:	b8 00 00 00 00       	mov    $0x0,%eax
  800ef9:	09 45 f0             	or     %eax,-0x10(%ebp)
  800efc:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800eff:	eb 18                	jmp    800f19 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f01:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f04:	8d 41 08             	lea    0x8(%ecx),%eax
  800f07:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f10:	89 01                	mov    %eax,(%ecx)
  800f12:	89 51 04             	mov    %edx,0x4(%ecx)
  800f15:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f19:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f1d:	77 e2                	ja     800f01 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f1f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f23:	74 23                	je     800f48 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f28:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f2b:	eb 0e                	jmp    800f3b <memset+0x91>
			*p8++ = (uint8)c;
  800f2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f30:	8d 50 01             	lea    0x1(%eax),%edx
  800f33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f36:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f39:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f41:	89 55 10             	mov    %edx,0x10(%ebp)
  800f44:	85 c0                	test   %eax,%eax
  800f46:	75 e5                	jne    800f2d <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4b:	c9                   	leave  
  800f4c:	c3                   	ret    

00800f4d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f4d:	55                   	push   %ebp
  800f4e:	89 e5                	mov    %esp,%ebp
  800f50:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f5f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f63:	76 24                	jbe    800f89 <memcpy+0x3c>
		while(n >= 8){
  800f65:	eb 1c                	jmp    800f83 <memcpy+0x36>
			*d64 = *s64;
  800f67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6a:	8b 50 04             	mov    0x4(%eax),%edx
  800f6d:	8b 00                	mov    (%eax),%eax
  800f6f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f72:	89 01                	mov    %eax,(%ecx)
  800f74:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f77:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f7b:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f7f:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f83:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f87:	77 de                	ja     800f67 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f89:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8d:	74 31                	je     800fc0 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f92:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f98:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f9b:	eb 16                	jmp    800fb3 <memcpy+0x66>
			*d8++ = *s8++;
  800f9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa0:	8d 50 01             	lea    0x1(%eax),%edx
  800fa3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fa6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fac:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800faf:	8a 12                	mov    (%edx),%dl
  800fb1:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800fb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb9:	89 55 10             	mov    %edx,0x10(%ebp)
  800fbc:	85 c0                	test   %eax,%eax
  800fbe:	75 dd                	jne    800f9d <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc3:	c9                   	leave  
  800fc4:	c3                   	ret    

00800fc5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fda:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fdd:	73 50                	jae    80102f <memmove+0x6a>
  800fdf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe5:	01 d0                	add    %edx,%eax
  800fe7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fea:	76 43                	jbe    80102f <memmove+0x6a>
		s += n;
  800fec:	8b 45 10             	mov    0x10(%ebp),%eax
  800fef:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ff8:	eb 10                	jmp    80100a <memmove+0x45>
			*--d = *--s;
  800ffa:	ff 4d f8             	decl   -0x8(%ebp)
  800ffd:	ff 4d fc             	decl   -0x4(%ebp)
  801000:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801003:	8a 10                	mov    (%eax),%dl
  801005:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801008:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80100a:	8b 45 10             	mov    0x10(%ebp),%eax
  80100d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801010:	89 55 10             	mov    %edx,0x10(%ebp)
  801013:	85 c0                	test   %eax,%eax
  801015:	75 e3                	jne    800ffa <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801017:	eb 23                	jmp    80103c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801019:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101c:	8d 50 01             	lea    0x1(%eax),%edx
  80101f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801022:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801025:	8d 4a 01             	lea    0x1(%edx),%ecx
  801028:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80102b:	8a 12                	mov    (%edx),%dl
  80102d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80102f:	8b 45 10             	mov    0x10(%ebp),%eax
  801032:	8d 50 ff             	lea    -0x1(%eax),%edx
  801035:	89 55 10             	mov    %edx,0x10(%ebp)
  801038:	85 c0                	test   %eax,%eax
  80103a:	75 dd                	jne    801019 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103f:	c9                   	leave  
  801040:	c3                   	ret    

00801041 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801041:	55                   	push   %ebp
  801042:	89 e5                	mov    %esp,%ebp
  801044:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80104d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801050:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801053:	eb 2a                	jmp    80107f <memcmp+0x3e>
		if (*s1 != *s2)
  801055:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801058:	8a 10                	mov    (%eax),%dl
  80105a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105d:	8a 00                	mov    (%eax),%al
  80105f:	38 c2                	cmp    %al,%dl
  801061:	74 16                	je     801079 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801063:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801066:	8a 00                	mov    (%eax),%al
  801068:	0f b6 d0             	movzbl %al,%edx
  80106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	0f b6 c0             	movzbl %al,%eax
  801073:	29 c2                	sub    %eax,%edx
  801075:	89 d0                	mov    %edx,%eax
  801077:	eb 18                	jmp    801091 <memcmp+0x50>
		s1++, s2++;
  801079:	ff 45 fc             	incl   -0x4(%ebp)
  80107c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80107f:	8b 45 10             	mov    0x10(%ebp),%eax
  801082:	8d 50 ff             	lea    -0x1(%eax),%edx
  801085:	89 55 10             	mov    %edx,0x10(%ebp)
  801088:	85 c0                	test   %eax,%eax
  80108a:	75 c9                	jne    801055 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80108c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801091:	c9                   	leave  
  801092:	c3                   	ret    

00801093 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801093:	55                   	push   %ebp
  801094:	89 e5                	mov    %esp,%ebp
  801096:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801099:	8b 55 08             	mov    0x8(%ebp),%edx
  80109c:	8b 45 10             	mov    0x10(%ebp),%eax
  80109f:	01 d0                	add    %edx,%eax
  8010a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010a4:	eb 15                	jmp    8010bb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8a 00                	mov    (%eax),%al
  8010ab:	0f b6 d0             	movzbl %al,%edx
  8010ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b1:	0f b6 c0             	movzbl %al,%eax
  8010b4:	39 c2                	cmp    %eax,%edx
  8010b6:	74 0d                	je     8010c5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010b8:	ff 45 08             	incl   0x8(%ebp)
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010c1:	72 e3                	jb     8010a6 <memfind+0x13>
  8010c3:	eb 01                	jmp    8010c6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010c5:	90                   	nop
	return (void *) s;
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c9:	c9                   	leave  
  8010ca:	c3                   	ret    

008010cb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010cb:	55                   	push   %ebp
  8010cc:	89 e5                	mov    %esp,%ebp
  8010ce:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010df:	eb 03                	jmp    8010e4 <strtol+0x19>
		s++;
  8010e1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	3c 20                	cmp    $0x20,%al
  8010eb:	74 f4                	je     8010e1 <strtol+0x16>
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8a 00                	mov    (%eax),%al
  8010f2:	3c 09                	cmp    $0x9,%al
  8010f4:	74 eb                	je     8010e1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f9:	8a 00                	mov    (%eax),%al
  8010fb:	3c 2b                	cmp    $0x2b,%al
  8010fd:	75 05                	jne    801104 <strtol+0x39>
		s++;
  8010ff:	ff 45 08             	incl   0x8(%ebp)
  801102:	eb 13                	jmp    801117 <strtol+0x4c>
	else if (*s == '-')
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	3c 2d                	cmp    $0x2d,%al
  80110b:	75 0a                	jne    801117 <strtol+0x4c>
		s++, neg = 1;
  80110d:	ff 45 08             	incl   0x8(%ebp)
  801110:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801117:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111b:	74 06                	je     801123 <strtol+0x58>
  80111d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801121:	75 20                	jne    801143 <strtol+0x78>
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	3c 30                	cmp    $0x30,%al
  80112a:	75 17                	jne    801143 <strtol+0x78>
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	40                   	inc    %eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	3c 78                	cmp    $0x78,%al
  801134:	75 0d                	jne    801143 <strtol+0x78>
		s += 2, base = 16;
  801136:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80113a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801141:	eb 28                	jmp    80116b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801143:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801147:	75 15                	jne    80115e <strtol+0x93>
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 00                	mov    (%eax),%al
  80114e:	3c 30                	cmp    $0x30,%al
  801150:	75 0c                	jne    80115e <strtol+0x93>
		s++, base = 8;
  801152:	ff 45 08             	incl   0x8(%ebp)
  801155:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80115c:	eb 0d                	jmp    80116b <strtol+0xa0>
	else if (base == 0)
  80115e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801162:	75 07                	jne    80116b <strtol+0xa0>
		base = 10;
  801164:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	3c 2f                	cmp    $0x2f,%al
  801172:	7e 19                	jle    80118d <strtol+0xc2>
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	3c 39                	cmp    $0x39,%al
  80117b:	7f 10                	jg     80118d <strtol+0xc2>
			dig = *s - '0';
  80117d:	8b 45 08             	mov    0x8(%ebp),%eax
  801180:	8a 00                	mov    (%eax),%al
  801182:	0f be c0             	movsbl %al,%eax
  801185:	83 e8 30             	sub    $0x30,%eax
  801188:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80118b:	eb 42                	jmp    8011cf <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	8a 00                	mov    (%eax),%al
  801192:	3c 60                	cmp    $0x60,%al
  801194:	7e 19                	jle    8011af <strtol+0xe4>
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	3c 7a                	cmp    $0x7a,%al
  80119d:	7f 10                	jg     8011af <strtol+0xe4>
			dig = *s - 'a' + 10;
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8a 00                	mov    (%eax),%al
  8011a4:	0f be c0             	movsbl %al,%eax
  8011a7:	83 e8 57             	sub    $0x57,%eax
  8011aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ad:	eb 20                	jmp    8011cf <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	3c 40                	cmp    $0x40,%al
  8011b6:	7e 39                	jle    8011f1 <strtol+0x126>
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	3c 5a                	cmp    $0x5a,%al
  8011bf:	7f 30                	jg     8011f1 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	0f be c0             	movsbl %al,%eax
  8011c9:	83 e8 37             	sub    $0x37,%eax
  8011cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011d5:	7d 19                	jge    8011f0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011d7:	ff 45 08             	incl   0x8(%ebp)
  8011da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011dd:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011e1:	89 c2                	mov    %eax,%edx
  8011e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e6:	01 d0                	add    %edx,%eax
  8011e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011eb:	e9 7b ff ff ff       	jmp    80116b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011f0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011f5:	74 08                	je     8011ff <strtol+0x134>
		*endptr = (char *) s;
  8011f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8011fd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011ff:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801203:	74 07                	je     80120c <strtol+0x141>
  801205:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801208:	f7 d8                	neg    %eax
  80120a:	eb 03                	jmp    80120f <strtol+0x144>
  80120c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <ltostr>:

void
ltostr(long value, char *str)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
  801214:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801217:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80121e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801225:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801229:	79 13                	jns    80123e <ltostr+0x2d>
	{
		neg = 1;
  80122b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801232:	8b 45 0c             	mov    0xc(%ebp),%eax
  801235:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801238:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80123b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
  801241:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801246:	99                   	cltd   
  801247:	f7 f9                	idiv   %ecx
  801249:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80124c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124f:	8d 50 01             	lea    0x1(%eax),%edx
  801252:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801255:	89 c2                	mov    %eax,%edx
  801257:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125a:	01 d0                	add    %edx,%eax
  80125c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80125f:	83 c2 30             	add    $0x30,%edx
  801262:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801267:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80126c:	f7 e9                	imul   %ecx
  80126e:	c1 fa 02             	sar    $0x2,%edx
  801271:	89 c8                	mov    %ecx,%eax
  801273:	c1 f8 1f             	sar    $0x1f,%eax
  801276:	29 c2                	sub    %eax,%edx
  801278:	89 d0                	mov    %edx,%eax
  80127a:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80127d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801281:	75 bb                	jne    80123e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801283:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80128a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128d:	48                   	dec    %eax
  80128e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801291:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801295:	74 3d                	je     8012d4 <ltostr+0xc3>
		start = 1 ;
  801297:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80129e:	eb 34                	jmp    8012d4 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b3:	01 c2                	add    %eax,%edx
  8012b5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bb:	01 c8                	add    %ecx,%eax
  8012bd:	8a 00                	mov    (%eax),%al
  8012bf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c7:	01 c2                	add    %eax,%edx
  8012c9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012cc:	88 02                	mov    %al,(%edx)
		start++ ;
  8012ce:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012d1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012da:	7c c4                	jl     8012a0 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	01 d0                	add    %edx,%eax
  8012e4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012e7:	90                   	nop
  8012e8:	c9                   	leave  
  8012e9:	c3                   	ret    

008012ea <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012ea:	55                   	push   %ebp
  8012eb:	89 e5                	mov    %esp,%ebp
  8012ed:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012f0:	ff 75 08             	pushl  0x8(%ebp)
  8012f3:	e8 c4 f9 ff ff       	call   800cbc <strlen>
  8012f8:	83 c4 04             	add    $0x4,%esp
  8012fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012fe:	ff 75 0c             	pushl  0xc(%ebp)
  801301:	e8 b6 f9 ff ff       	call   800cbc <strlen>
  801306:	83 c4 04             	add    $0x4,%esp
  801309:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80130c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801313:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80131a:	eb 17                	jmp    801333 <strcconcat+0x49>
		final[s] = str1[s] ;
  80131c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80131f:	8b 45 10             	mov    0x10(%ebp),%eax
  801322:	01 c2                	add    %eax,%edx
  801324:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	01 c8                	add    %ecx,%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801330:	ff 45 fc             	incl   -0x4(%ebp)
  801333:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801336:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801339:	7c e1                	jl     80131c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80133b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801342:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801349:	eb 1f                	jmp    80136a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80134b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134e:	8d 50 01             	lea    0x1(%eax),%edx
  801351:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801354:	89 c2                	mov    %eax,%edx
  801356:	8b 45 10             	mov    0x10(%ebp),%eax
  801359:	01 c2                	add    %eax,%edx
  80135b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80135e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801361:	01 c8                	add    %ecx,%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801367:	ff 45 f8             	incl   -0x8(%ebp)
  80136a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80136d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801370:	7c d9                	jl     80134b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801372:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801375:	8b 45 10             	mov    0x10(%ebp),%eax
  801378:	01 d0                	add    %edx,%eax
  80137a:	c6 00 00             	movb   $0x0,(%eax)
}
  80137d:	90                   	nop
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801383:	8b 45 14             	mov    0x14(%ebp),%eax
  801386:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80138c:	8b 45 14             	mov    0x14(%ebp),%eax
  80138f:	8b 00                	mov    (%eax),%eax
  801391:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801398:	8b 45 10             	mov    0x10(%ebp),%eax
  80139b:	01 d0                	add    %edx,%eax
  80139d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013a3:	eb 0c                	jmp    8013b1 <strsplit+0x31>
			*string++ = 0;
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8d 50 01             	lea    0x1(%eax),%edx
  8013ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ae:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	84 c0                	test   %al,%al
  8013b8:	74 18                	je     8013d2 <strsplit+0x52>
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	8a 00                	mov    (%eax),%al
  8013bf:	0f be c0             	movsbl %al,%eax
  8013c2:	50                   	push   %eax
  8013c3:	ff 75 0c             	pushl  0xc(%ebp)
  8013c6:	e8 83 fa ff ff       	call   800e4e <strchr>
  8013cb:	83 c4 08             	add    $0x8,%esp
  8013ce:	85 c0                	test   %eax,%eax
  8013d0:	75 d3                	jne    8013a5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	84 c0                	test   %al,%al
  8013d9:	74 5a                	je     801435 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013db:	8b 45 14             	mov    0x14(%ebp),%eax
  8013de:	8b 00                	mov    (%eax),%eax
  8013e0:	83 f8 0f             	cmp    $0xf,%eax
  8013e3:	75 07                	jne    8013ec <strsplit+0x6c>
		{
			return 0;
  8013e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ea:	eb 66                	jmp    801452 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ef:	8b 00                	mov    (%eax),%eax
  8013f1:	8d 48 01             	lea    0x1(%eax),%ecx
  8013f4:	8b 55 14             	mov    0x14(%ebp),%edx
  8013f7:	89 0a                	mov    %ecx,(%edx)
  8013f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801400:	8b 45 10             	mov    0x10(%ebp),%eax
  801403:	01 c2                	add    %eax,%edx
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80140a:	eb 03                	jmp    80140f <strsplit+0x8f>
			string++;
  80140c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	84 c0                	test   %al,%al
  801416:	74 8b                	je     8013a3 <strsplit+0x23>
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	0f be c0             	movsbl %al,%eax
  801420:	50                   	push   %eax
  801421:	ff 75 0c             	pushl  0xc(%ebp)
  801424:	e8 25 fa ff ff       	call   800e4e <strchr>
  801429:	83 c4 08             	add    $0x8,%esp
  80142c:	85 c0                	test   %eax,%eax
  80142e:	74 dc                	je     80140c <strsplit+0x8c>
			string++;
	}
  801430:	e9 6e ff ff ff       	jmp    8013a3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801435:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801436:	8b 45 14             	mov    0x14(%ebp),%eax
  801439:	8b 00                	mov    (%eax),%eax
  80143b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801442:	8b 45 10             	mov    0x10(%ebp),%eax
  801445:	01 d0                	add    %edx,%eax
  801447:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80144d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
  801457:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801460:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801467:	eb 4a                	jmp    8014b3 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801469:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	01 c2                	add    %eax,%edx
  801471:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801474:	8b 45 0c             	mov    0xc(%ebp),%eax
  801477:	01 c8                	add    %ecx,%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80147d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	01 d0                	add    %edx,%eax
  801485:	8a 00                	mov    (%eax),%al
  801487:	3c 40                	cmp    $0x40,%al
  801489:	7e 25                	jle    8014b0 <str2lower+0x5c>
  80148b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801491:	01 d0                	add    %edx,%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	3c 5a                	cmp    $0x5a,%al
  801497:	7f 17                	jg     8014b0 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801499:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	01 d0                	add    %edx,%eax
  8014a1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a7:	01 ca                	add    %ecx,%edx
  8014a9:	8a 12                	mov    (%edx),%dl
  8014ab:	83 c2 20             	add    $0x20,%edx
  8014ae:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014b0:	ff 45 fc             	incl   -0x4(%ebp)
  8014b3:	ff 75 0c             	pushl  0xc(%ebp)
  8014b6:	e8 01 f8 ff ff       	call   800cbc <strlen>
  8014bb:	83 c4 04             	add    $0x4,%esp
  8014be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014c1:	7f a6                	jg     801469 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8014ce:	a1 08 30 80 00       	mov    0x803008,%eax
  8014d3:	85 c0                	test   %eax,%eax
  8014d5:	74 2d                	je     801504 <uheap_init+0x3c>
	{
		buddy_init();
  8014d7:	e8 87 06 00 00       	call   801b63 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8014dc:	e8 31 05 00 00       	call   801a12 <sys_get_uheap_strategy>
  8014e1:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  8014e6:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8014ed:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8014f0:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8014f7:	00 00 80 
		__firstTimeFlag = 0;
  8014fa:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801501:	00 00 00 
	}
}
  801504:	90                   	nop
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
  80150a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  80150d:	83 ec 04             	sub    $0x4,%esp
  801510:	68 88 28 80 00       	push   $0x802888
  801515:	6a 25                	push   $0x25
  801517:	68 b9 28 80 00       	push   $0x8028b9
  80151c:	e8 21 09 00 00       	call   801e42 <_panic>

00801521 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
  801524:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801527:	83 ec 04             	sub    $0x4,%esp
  80152a:	68 c8 28 80 00       	push   $0x8028c8
  80152f:	6a 2f                	push   $0x2f
  801531:	68 b9 28 80 00       	push   $0x8028b9
  801536:	e8 07 09 00 00       	call   801e42 <_panic>

0080153b <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
  80153e:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801541:	e8 82 ff ff ff       	call   8014c8 <uheap_init>
	if (size == 0) return NULL ;
  801546:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80154a:	75 07                	jne    801553 <malloc+0x18>
  80154c:	b8 00 00 00 00       	mov    $0x0,%eax
  801551:	eb 14                	jmp    801567 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801553:	83 ec 04             	sub    $0x4,%esp
  801556:	68 fc 28 80 00       	push   $0x8028fc
  80155b:	6a 43                	push   $0x43
  80155d:	68 b9 28 80 00       	push   $0x8028b9
  801562:	e8 db 08 00 00       	call   801e42 <_panic>
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
  80156c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  80156f:	83 ec 04             	sub    $0x4,%esp
  801572:	68 24 29 80 00       	push   $0x802924
  801577:	6a 4e                	push   $0x4e
  801579:	68 b9 28 80 00       	push   $0x8028b9
  80157e:	e8 bf 08 00 00       	call   801e42 <_panic>

00801583 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
  801586:	83 ec 18             	sub    $0x18,%esp
  801589:	8b 45 10             	mov    0x10(%ebp),%eax
  80158c:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80158f:	e8 34 ff ff ff       	call   8014c8 <uheap_init>
	if (size == 0) return NULL ;
  801594:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801598:	75 07                	jne    8015a1 <smalloc+0x1e>
  80159a:	b8 00 00 00 00       	mov    $0x0,%eax
  80159f:	eb 14                	jmp    8015b5 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  8015a1:	83 ec 04             	sub    $0x4,%esp
  8015a4:	68 48 29 80 00       	push   $0x802948
  8015a9:	6a 5f                	push   $0x5f
  8015ab:	68 b9 28 80 00       	push   $0x8028b9
  8015b0:	e8 8d 08 00 00       	call   801e42 <_panic>
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8015bd:	e8 06 ff ff ff       	call   8014c8 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  8015c2:	83 ec 04             	sub    $0x4,%esp
  8015c5:	68 70 29 80 00       	push   $0x802970
  8015ca:	6a 6f                	push   $0x6f
  8015cc:	68 b9 28 80 00       	push   $0x8028b9
  8015d1:	e8 6c 08 00 00       	call   801e42 <_panic>

008015d6 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
  8015d9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8015dc:	83 ec 04             	sub    $0x4,%esp
  8015df:	68 94 29 80 00       	push   $0x802994
  8015e4:	6a 7e                	push   $0x7e
  8015e6:	68 b9 28 80 00       	push   $0x8028b9
  8015eb:	e8 52 08 00 00       	call   801e42 <_panic>

008015f0 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
  8015f3:	57                   	push   %edi
  8015f4:	56                   	push   %esi
  8015f5:	53                   	push   %ebx
  8015f6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801602:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801605:	8b 7d 18             	mov    0x18(%ebp),%edi
  801608:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80160b:	cd 30                	int    $0x30
  80160d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801610:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801613:	83 c4 10             	add    $0x10,%esp
  801616:	5b                   	pop    %ebx
  801617:	5e                   	pop    %esi
  801618:	5f                   	pop    %edi
  801619:	5d                   	pop    %ebp
  80161a:	c3                   	ret    

0080161b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80161b:	55                   	push   %ebp
  80161c:	89 e5                	mov    %esp,%ebp
  80161e:	83 ec 04             	sub    $0x4,%esp
  801621:	8b 45 10             	mov    0x10(%ebp),%eax
  801624:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801627:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80162a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	6a 00                	push   $0x0
  801633:	51                   	push   %ecx
  801634:	52                   	push   %edx
  801635:	ff 75 0c             	pushl  0xc(%ebp)
  801638:	50                   	push   %eax
  801639:	6a 00                	push   $0x0
  80163b:	e8 b0 ff ff ff       	call   8015f0 <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	90                   	nop
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_cgetc>:

int
sys_cgetc(void)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 02                	push   $0x2
  801655:	e8 96 ff ff ff       	call   8015f0 <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
}
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <sys_lock_cons>:

void sys_lock_cons(void)
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 03                	push   $0x3
  80166e:	e8 7d ff ff ff       	call   8015f0 <syscall>
  801673:	83 c4 18             	add    $0x18,%esp
}
  801676:	90                   	nop
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 04                	push   $0x4
  801688:	e8 63 ff ff ff       	call   8015f0 <syscall>
  80168d:	83 c4 18             	add    $0x18,%esp
}
  801690:	90                   	nop
  801691:	c9                   	leave  
  801692:	c3                   	ret    

00801693 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801696:	8b 55 0c             	mov    0xc(%ebp),%edx
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	52                   	push   %edx
  8016a3:	50                   	push   %eax
  8016a4:	6a 08                	push   $0x8
  8016a6:	e8 45 ff ff ff       	call   8015f0 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
  8016b3:	56                   	push   %esi
  8016b4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016b5:	8b 75 18             	mov    0x18(%ebp),%esi
  8016b8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	56                   	push   %esi
  8016c5:	53                   	push   %ebx
  8016c6:	51                   	push   %ecx
  8016c7:	52                   	push   %edx
  8016c8:	50                   	push   %eax
  8016c9:	6a 09                	push   $0x9
  8016cb:	e8 20 ff ff ff       	call   8015f0 <syscall>
  8016d0:	83 c4 18             	add    $0x18,%esp
}
  8016d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016d6:	5b                   	pop    %ebx
  8016d7:	5e                   	pop    %esi
  8016d8:	5d                   	pop    %ebp
  8016d9:	c3                   	ret    

008016da <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	ff 75 08             	pushl  0x8(%ebp)
  8016e8:	6a 0a                	push   $0xa
  8016ea:	e8 01 ff ff ff       	call   8015f0 <syscall>
  8016ef:	83 c4 18             	add    $0x18,%esp
}
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	ff 75 0c             	pushl  0xc(%ebp)
  801700:	ff 75 08             	pushl  0x8(%ebp)
  801703:	6a 0b                	push   $0xb
  801705:	e8 e6 fe ff ff       	call   8015f0 <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 0c                	push   $0xc
  80171e:	e8 cd fe ff ff       	call   8015f0 <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 0d                	push   $0xd
  801737:	e8 b4 fe ff ff       	call   8015f0 <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 0e                	push   $0xe
  801750:	e8 9b fe ff ff       	call   8015f0 <syscall>
  801755:	83 c4 18             	add    $0x18,%esp
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 0f                	push   $0xf
  801769:	e8 82 fe ff ff       	call   8015f0 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	ff 75 08             	pushl  0x8(%ebp)
  801781:	6a 10                	push   $0x10
  801783:	e8 68 fe ff ff       	call   8015f0 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 11                	push   $0x11
  80179c:	e8 4f fe ff ff       	call   8015f0 <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	90                   	nop
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_cputc>:

void
sys_cputc(const char c)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
  8017aa:	83 ec 04             	sub    $0x4,%esp
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017b3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	50                   	push   %eax
  8017c0:	6a 01                	push   $0x1
  8017c2:	e8 29 fe ff ff       	call   8015f0 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	90                   	nop
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 14                	push   $0x14
  8017dc:	e8 0f fe ff ff       	call   8015f0 <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
}
  8017e4:	90                   	nop
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
  8017ea:	83 ec 04             	sub    $0x4,%esp
  8017ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8017f3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017f6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	6a 00                	push   $0x0
  8017ff:	51                   	push   %ecx
  801800:	52                   	push   %edx
  801801:	ff 75 0c             	pushl  0xc(%ebp)
  801804:	50                   	push   %eax
  801805:	6a 15                	push   $0x15
  801807:	e8 e4 fd ff ff       	call   8015f0 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801814:	8b 55 10             	mov    0x10(%ebp),%edx
  801817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	52                   	push   %edx
  80181f:	50                   	push   %eax
  801820:	ff 75 08             	pushl  0x8(%ebp)
  801823:	6a 16                	push   $0x16
  801825:	e8 c6 fd ff ff       	call   8015f0 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
}
  80182d:	c9                   	leave  
  80182e:	c3                   	ret    

0080182f <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80182f:	55                   	push   %ebp
  801830:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801832:	8b 55 0c             	mov    0xc(%ebp),%edx
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	52                   	push   %edx
  80183f:	50                   	push   %eax
  801840:	6a 17                	push   $0x17
  801842:	e8 a9 fd ff ff       	call   8015f0 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80184f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	52                   	push   %edx
  80185c:	50                   	push   %eax
  80185d:	6a 18                	push   $0x18
  80185f:	e8 8c fd ff ff       	call   8015f0 <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80186c:	8b 45 08             	mov    0x8(%ebp),%eax
  80186f:	6a 00                	push   $0x0
  801871:	ff 75 14             	pushl  0x14(%ebp)
  801874:	ff 75 10             	pushl  0x10(%ebp)
  801877:	ff 75 0c             	pushl  0xc(%ebp)
  80187a:	50                   	push   %eax
  80187b:	6a 19                	push   $0x19
  80187d:	e8 6e fd ff ff       	call   8015f0 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80188a:	8b 45 08             	mov    0x8(%ebp),%eax
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	50                   	push   %eax
  801896:	6a 1a                	push   $0x1a
  801898:	e8 53 fd ff ff       	call   8015f0 <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	90                   	nop
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	50                   	push   %eax
  8018b2:	6a 1b                	push   $0x1b
  8018b4:	e8 37 fd ff ff       	call   8015f0 <syscall>
  8018b9:	83 c4 18             	add    $0x18,%esp
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 05                	push   $0x5
  8018cd:	e8 1e fd ff ff       	call   8015f0 <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 06                	push   $0x6
  8018e6:	e8 05 fd ff ff       	call   8015f0 <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 07                	push   $0x7
  8018ff:	e8 ec fc ff ff       	call   8015f0 <syscall>
  801904:	83 c4 18             	add    $0x18,%esp
}
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <sys_exit_env>:


void sys_exit_env(void)
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 1c                	push   $0x1c
  801918:	e8 d3 fc ff ff       	call   8015f0 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	90                   	nop
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	ff 75 10             	pushl  0x10(%ebp)
  80192d:	ff 75 0c             	pushl  0xc(%ebp)
  801930:	ff 75 08             	pushl  0x8(%ebp)
  801933:	6a 13                	push   $0x13
  801935:	e8 b6 fc ff ff       	call   8015f0 <syscall>
  80193a:	83 c4 18             	add    $0x18,%esp
	return ;
  80193d:	90                   	nop
}
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <sys_rcr2>:
uint32 sys_rcr2()
{
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 1e                	push   $0x1e
  80194f:	e8 9c fc ff ff       	call   8015f0 <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
}
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
  80195c:	83 ec 04             	sub    $0x4,%esp
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801965:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	50                   	push   %eax
  801972:	6a 1f                	push   $0x1f
  801974:	e8 77 fc ff ff       	call   8015f0 <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
	return ;
  80197c:	90                   	nop
}
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <rsttst>:
void rsttst()
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 21                	push   $0x21
  80198e:	e8 5d fc ff ff       	call   8015f0 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
	return ;
  801996:	90                   	nop
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
  80199c:	83 ec 04             	sub    $0x4,%esp
  80199f:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019a5:	8b 55 18             	mov    0x18(%ebp),%edx
  8019a8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019ac:	52                   	push   %edx
  8019ad:	50                   	push   %eax
  8019ae:	ff 75 10             	pushl  0x10(%ebp)
  8019b1:	ff 75 0c             	pushl  0xc(%ebp)
  8019b4:	ff 75 08             	pushl  0x8(%ebp)
  8019b7:	6a 20                	push   $0x20
  8019b9:	e8 32 fc ff ff       	call   8015f0 <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c1:	90                   	nop
}
  8019c2:	c9                   	leave  
  8019c3:	c3                   	ret    

008019c4 <chktst>:
void chktst(uint32 n)
{
  8019c4:	55                   	push   %ebp
  8019c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	ff 75 08             	pushl  0x8(%ebp)
  8019d2:	6a 22                	push   $0x22
  8019d4:	e8 17 fc ff ff       	call   8015f0 <syscall>
  8019d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019dc:	90                   	nop
}
  8019dd:	c9                   	leave  
  8019de:	c3                   	ret    

008019df <inctst>:

void inctst()
{
  8019df:	55                   	push   %ebp
  8019e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 23                	push   $0x23
  8019ee:	e8 fd fb ff ff       	call   8015f0 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f6:	90                   	nop
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <gettst>:
uint32 gettst()
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 24                	push   $0x24
  801a08:	e8 e3 fb ff ff       	call   8015f0 <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
}
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 25                	push   $0x25
  801a21:	e8 ca fb ff ff       	call   8015f0 <syscall>
  801a26:	83 c4 18             	add    $0x18,%esp
  801a29:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801a2e:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	ff 75 08             	pushl  0x8(%ebp)
  801a4b:	6a 26                	push   $0x26
  801a4d:	e8 9e fb ff ff       	call   8015f0 <syscall>
  801a52:	83 c4 18             	add    $0x18,%esp
	return ;
  801a55:	90                   	nop
}
  801a56:	c9                   	leave  
  801a57:	c3                   	ret    

00801a58 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a58:	55                   	push   %ebp
  801a59:	89 e5                	mov    %esp,%ebp
  801a5b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a5c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a65:	8b 45 08             	mov    0x8(%ebp),%eax
  801a68:	6a 00                	push   $0x0
  801a6a:	53                   	push   %ebx
  801a6b:	51                   	push   %ecx
  801a6c:	52                   	push   %edx
  801a6d:	50                   	push   %eax
  801a6e:	6a 27                	push   $0x27
  801a70:	e8 7b fb ff ff       	call   8015f0 <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a80:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	52                   	push   %edx
  801a8d:	50                   	push   %eax
  801a8e:	6a 28                	push   $0x28
  801a90:	e8 5b fb ff ff       	call   8015f0 <syscall>
  801a95:	83 c4 18             	add    $0x18,%esp
}
  801a98:	c9                   	leave  
  801a99:	c3                   	ret    

00801a9a <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801a9d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801aa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa6:	6a 00                	push   $0x0
  801aa8:	51                   	push   %ecx
  801aa9:	ff 75 10             	pushl  0x10(%ebp)
  801aac:	52                   	push   %edx
  801aad:	50                   	push   %eax
  801aae:	6a 29                	push   $0x29
  801ab0:	e8 3b fb ff ff       	call   8015f0 <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	ff 75 10             	pushl  0x10(%ebp)
  801ac4:	ff 75 0c             	pushl  0xc(%ebp)
  801ac7:	ff 75 08             	pushl  0x8(%ebp)
  801aca:	6a 12                	push   $0x12
  801acc:	e8 1f fb ff ff       	call   8015f0 <syscall>
  801ad1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad4:	90                   	nop
}
  801ad5:	c9                   	leave  
  801ad6:	c3                   	ret    

00801ad7 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801ada:	8b 55 0c             	mov    0xc(%ebp),%edx
  801add:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	52                   	push   %edx
  801ae7:	50                   	push   %eax
  801ae8:	6a 2a                	push   $0x2a
  801aea:	e8 01 fb ff ff       	call   8015f0 <syscall>
  801aef:	83 c4 18             	add    $0x18,%esp
	return;
  801af2:	90                   	nop
}
  801af3:	c9                   	leave  
  801af4:	c3                   	ret    

00801af5 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 2b                	push   $0x2b
  801b04:	e8 e7 fa ff ff       	call   8015f0 <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
}
  801b0c:	c9                   	leave  
  801b0d:	c3                   	ret    

00801b0e <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
  801b11:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801b14:	83 ec 04             	sub    $0x4,%esp
  801b17:	68 b8 29 80 00       	push   $0x8029b8
  801b1c:	68 0a 01 00 00       	push   $0x10a
  801b21:	68 c8 29 80 00       	push   $0x8029c8
  801b26:	e8 17 03 00 00       	call   801e42 <_panic>

00801b2b <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	ff 75 0c             	pushl  0xc(%ebp)
  801b37:	ff 75 08             	pushl  0x8(%ebp)
  801b3a:	6a 33                	push   $0x33
  801b3c:	e8 af fa ff ff       	call   8015f0 <syscall>
  801b41:	83 c4 18             	add    $0x18,%esp
	return;
  801b44:	90                   	nop
}
  801b45:	c9                   	leave  
  801b46:	c3                   	ret    

00801b47 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	ff 75 0c             	pushl  0xc(%ebp)
  801b53:	ff 75 08             	pushl  0x8(%ebp)
  801b56:	6a 34                	push   $0x34
  801b58:	e8 93 fa ff ff       	call   8015f0 <syscall>
  801b5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801b60:	90                   	nop
}
  801b61:	c9                   	leave  
  801b62:	c3                   	ret    

00801b63 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
  801b66:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801b69:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801b70:	eb 36                	jmp    801ba8 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801b72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b75:	c1 e0 04             	shl    $0x4,%eax
  801b78:	05 60 30 80 00       	add    $0x803060,%eax
  801b7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801b83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b86:	c1 e0 04             	shl    $0x4,%eax
  801b89:	05 64 30 80 00       	add    $0x803064,%eax
  801b8e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801b94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b97:	c1 e0 04             	shl    $0x4,%eax
  801b9a:	05 6c 30 80 00       	add    $0x80306c,%eax
  801b9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801ba5:	ff 45 fc             	incl   -0x4(%ebp)
  801ba8:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801bac:	7e c4                	jle    801b72 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801bae:	90                   	nop
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
  801bb4:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801bb7:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801bbe:	eb 24                	jmp    801be4 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bc3:	c1 e0 04             	shl    $0x4,%eax
  801bc6:	05 6c 30 80 00       	add    $0x80306c,%eax
  801bcb:	8b 00                	mov    (%eax),%eax
  801bcd:	83 ec 04             	sub    $0x4,%esp
  801bd0:	50                   	push   %eax
  801bd1:	ff 75 f4             	pushl  -0xc(%ebp)
  801bd4:	68 d8 29 80 00       	push   $0x8029d8
  801bd9:	e8 05 ea ff ff       	call   8005e3 <cprintf>
  801bde:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801be1:	ff 45 f4             	incl   -0xc(%ebp)
  801be4:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801be8:	7e d6                	jle    801bc0 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801bea:	90                   	nop
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801bf3:	83 ec 04             	sub    $0x4,%esp
  801bf6:	68 e8 29 80 00       	push   $0x8029e8
  801bfb:	6a 33                	push   $0x33
  801bfd:	68 09 2a 80 00       	push   $0x802a09
  801c02:	e8 3b 02 00 00       	call   801e42 <_panic>

00801c07 <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
  801c0a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801c0d:	83 ec 04             	sub    $0x4,%esp
  801c10:	68 21 2a 80 00       	push   $0x802a21
  801c15:	6a 3e                	push   $0x3e
  801c17:	68 09 2a 80 00       	push   $0x802a09
  801c1c:	e8 21 02 00 00       	call   801e42 <_panic>

00801c21 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801c21:	55                   	push   %ebp
  801c22:	89 e5                	mov    %esp,%ebp
  801c24:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801c27:	83 ec 04             	sub    $0x4,%esp
  801c2a:	68 3f 2a 80 00       	push   $0x802a3f
  801c2f:	6a 49                	push   $0x49
  801c31:	68 09 2a 80 00       	push   $0x802a09
  801c36:	e8 07 02 00 00       	call   801e42 <_panic>

00801c3b <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
  801c3e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801c41:	83 ec 04             	sub    $0x4,%esp
  801c44:	68 5c 2a 80 00       	push   $0x802a5c
  801c49:	6a 58                	push   $0x58
  801c4b:	68 09 2a 80 00       	push   $0x802a09
  801c50:	e8 ed 01 00 00       	call   801e42 <_panic>

00801c55 <create_semaphore>:
// User-level Semaphore

#include "inc/lib.h"

struct semaphore create_semaphore(char *semaphoreName, uint32 value)
{
  801c55:	55                   	push   %ebp
  801c56:	89 e5                	mov    %esp,%ebp
  801c58:	83 ec 08             	sub    $0x8,%esp
	panic("create_semaphore() is not implemented yet...!!");
  801c5b:	83 ec 04             	sub    $0x4,%esp
  801c5e:	68 80 2a 80 00       	push   $0x802a80
  801c63:	6a 07                	push   $0x7
  801c65:	68 af 2a 80 00       	push   $0x802aaf
  801c6a:	e8 d3 01 00 00       	call   801e42 <_panic>

00801c6f <get_semaphore>:
}
struct semaphore get_semaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c6f:	55                   	push   %ebp
  801c70:	89 e5                	mov    %esp,%ebp
  801c72:	83 ec 08             	sub    $0x8,%esp
	panic("get_semaphore() is not implemented yet...!!");
  801c75:	83 ec 04             	sub    $0x4,%esp
  801c78:	68 c0 2a 80 00       	push   $0x802ac0
  801c7d:	6a 0b                	push   $0xb
  801c7f:	68 af 2a 80 00       	push   $0x802aaf
  801c84:	e8 b9 01 00 00       	call   801e42 <_panic>

00801c89 <wait_semaphore>:
}

void wait_semaphore(struct semaphore sem)
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 08             	sub    $0x8,%esp
	panic("wait_semaphore() is not implemented yet...!!");
  801c8f:	83 ec 04             	sub    $0x4,%esp
  801c92:	68 ec 2a 80 00       	push   $0x802aec
  801c97:	6a 10                	push   $0x10
  801c99:	68 af 2a 80 00       	push   $0x802aaf
  801c9e:	e8 9f 01 00 00       	call   801e42 <_panic>

00801ca3 <signal_semaphore>:
}

void signal_semaphore(struct semaphore sem)
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
  801ca6:	83 ec 08             	sub    $0x8,%esp
	panic("signal_semaphore() is not implemented yet...!!");
  801ca9:	83 ec 04             	sub    $0x4,%esp
  801cac:	68 1c 2b 80 00       	push   $0x802b1c
  801cb1:	6a 15                	push   $0x15
  801cb3:	68 af 2a 80 00       	push   $0x802aaf
  801cb8:	e8 85 01 00 00       	call   801e42 <_panic>

00801cbd <semaphore_count>:
}

int semaphore_count(struct semaphore sem)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
	return sem.semdata->count;
  801cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc3:	8b 40 10             	mov    0x10(%eax),%eax
}
  801cc6:	5d                   	pop    %ebp
  801cc7:	c3                   	ret    

00801cc8 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
  801ccb:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801cce:	8b 55 08             	mov    0x8(%ebp),%edx
  801cd1:	89 d0                	mov    %edx,%eax
  801cd3:	c1 e0 02             	shl    $0x2,%eax
  801cd6:	01 d0                	add    %edx,%eax
  801cd8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cdf:	01 d0                	add    %edx,%eax
  801ce1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ce8:	01 d0                	add    %edx,%eax
  801cea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cf1:	01 d0                	add    %edx,%eax
  801cf3:	c1 e0 04             	shl    $0x4,%eax
  801cf6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801cf9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801d00:	0f 31                	rdtsc  
  801d02:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801d05:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801d08:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d0b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d11:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801d14:	eb 46                	jmp    801d5c <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801d16:	0f 31                	rdtsc  
  801d18:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801d1b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801d1e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d21:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801d24:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801d27:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801d2a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d30:	29 c2                	sub    %eax,%edx
  801d32:	89 d0                	mov    %edx,%eax
  801d34:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801d37:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d3d:	89 d1                	mov    %edx,%ecx
  801d3f:	29 c1                	sub    %eax,%ecx
  801d41:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d44:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d47:	39 c2                	cmp    %eax,%edx
  801d49:	0f 97 c0             	seta   %al
  801d4c:	0f b6 c0             	movzbl %al,%eax
  801d4f:	29 c1                	sub    %eax,%ecx
  801d51:	89 c8                	mov    %ecx,%eax
  801d53:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801d56:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801d5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d5f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801d62:	72 b2                	jb     801d16 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801d64:	90                   	nop
  801d65:	c9                   	leave  
  801d66:	c3                   	ret    

00801d67 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801d67:	55                   	push   %ebp
  801d68:	89 e5                	mov    %esp,%ebp
  801d6a:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801d6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801d74:	eb 03                	jmp    801d79 <busy_wait+0x12>
  801d76:	ff 45 fc             	incl   -0x4(%ebp)
  801d79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d7c:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d7f:	72 f5                	jb     801d76 <busy_wait+0xf>
	return i;
  801d81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d84:	c9                   	leave  
  801d85:	c3                   	ret    

00801d86 <init_uspinlock>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.ALL] PROTECTION - [0] GIVEN USER SPIN LOCK

void init_uspinlock(struct uspinlock *lk, char *name, bool isOpened)
{
  801d86:	55                   	push   %ebp
  801d87:	89 e5                	mov    %esp,%ebp
  801d89:	83 ec 08             	sub    $0x8,%esp
	assert(isOpened == 0 || isOpened == 1);
  801d8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d90:	74 1c                	je     801dae <init_uspinlock+0x28>
  801d92:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
  801d96:	74 16                	je     801dae <init_uspinlock+0x28>
  801d98:	68 4c 2b 80 00       	push   $0x802b4c
  801d9d:	68 6b 2b 80 00       	push   $0x802b6b
  801da2:	6a 15                	push   $0x15
  801da4:	68 80 2b 80 00       	push   $0x802b80
  801da9:	e8 94 00 00 00       	call   801e42 <_panic>
	strcpy(lk->name, name);
  801dae:	8b 45 08             	mov    0x8(%ebp),%eax
  801db1:	83 c0 04             	add    $0x4,%eax
  801db4:	83 ec 08             	sub    $0x8,%esp
  801db7:	ff 75 0c             	pushl  0xc(%ebp)
  801dba:	50                   	push   %eax
  801dbb:	e8 4b ef ff ff       	call   800d0b <strcpy>
  801dc0:	83 c4 10             	add    $0x10,%esp
	lk->locked = (1 - isOpened);
  801dc3:	b8 01 00 00 00       	mov    $0x1,%eax
  801dc8:	2b 45 10             	sub    0x10(%ebp),%eax
  801dcb:	89 c2                	mov    %eax,%edx
  801dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd0:	89 10                	mov    %edx,(%eax)
}
  801dd2:	90                   	nop
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <acquire_uspinlock>:
// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void acquire_uspinlock(struct uspinlock *lk)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
  801dd8:	83 ec 10             	sub    $0x10,%esp
	// The xchg is atomic.
	while(xchg(&lk->locked, 1) != 0) ;
  801ddb:	90                   	nop
  801ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801de2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%ebp)
xchg(volatile uint32 *addr, uint32 newval)
{
  uint32 result;

  // The + in "+m" denotes a read-modify-write operand.
  __asm __volatile("lock; xchgl %0, %1" :
  801de9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801def:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801df2:	f0 87 02             	lock xchg %eax,(%edx)
  801df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
  801df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dfb:	85 c0                	test   %eax,%eax
  801dfd:	75 dd                	jne    801ddc <acquire_uspinlock+0x7>
	//cprintf("[%d: %s] ACQUIRED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);

	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that the critical section's memory
	// references happen after the lock is acquired.
	__sync_synchronize();
  801dff:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
}
  801e04:	90                   	nop
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <release_uspinlock>:

// Release the lock.
void release_uspinlock(struct uspinlock *lk)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
  801e0a:	83 ec 08             	sub    $0x8,%esp
	if(!(lk->locked))
  801e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e10:	8b 00                	mov    (%eax),%eax
  801e12:	85 c0                	test   %eax,%eax
  801e14:	75 18                	jne    801e2e <release_uspinlock+0x27>
	{
		panic("release: lock \"%s\" is not held!", lk->name);
  801e16:	8b 45 08             	mov    0x8(%ebp),%eax
  801e19:	83 c0 04             	add    $0x4,%eax
  801e1c:	50                   	push   %eax
  801e1d:	68 90 2b 80 00       	push   $0x802b90
  801e22:	6a 30                	push   $0x30
  801e24:	68 80 2b 80 00       	push   $0x802b80
  801e29:	e8 14 00 00 00       	call   801e42 <_panic>
	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that all the stores in the critical
	// section are visible to other cores before the lock is released.
	// Both the C compiler and the hardware may re-order loads and
	// stores; __sync_synchronize() tells them both not to.
	__sync_synchronize();
  801e2e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

	// Release the lock, equivalent to lk->locked = 0.
	// This code can't use a C assignment, since it might
	// not be atomic. A real OS would use C atomics here.
	asm volatile("movl $0, %0" : "+m" (lk->locked) : );
  801e33:	8b 45 08             	mov    0x8(%ebp),%eax
  801e36:	8b 55 08             	mov    0x8(%ebp),%edx
  801e39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//cprintf("[%d: %s] RELEASED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);
}
  801e3f:	90                   	nop
  801e40:	c9                   	leave  
  801e41:	c3                   	ret    

00801e42 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801e42:	55                   	push   %ebp
  801e43:	89 e5                	mov    %esp,%ebp
  801e45:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801e48:	8d 45 10             	lea    0x10(%ebp),%eax
  801e4b:	83 c0 04             	add    $0x4,%eax
  801e4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801e51:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801e56:	85 c0                	test   %eax,%eax
  801e58:	74 16                	je     801e70 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801e5a:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801e5f:	83 ec 08             	sub    $0x8,%esp
  801e62:	50                   	push   %eax
  801e63:	68 b0 2b 80 00       	push   $0x802bb0
  801e68:	e8 76 e7 ff ff       	call   8005e3 <cprintf>
  801e6d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801e70:	a1 04 30 80 00       	mov    0x803004,%eax
  801e75:	83 ec 0c             	sub    $0xc,%esp
  801e78:	ff 75 0c             	pushl  0xc(%ebp)
  801e7b:	ff 75 08             	pushl  0x8(%ebp)
  801e7e:	50                   	push   %eax
  801e7f:	68 b8 2b 80 00       	push   $0x802bb8
  801e84:	6a 74                	push   $0x74
  801e86:	e8 85 e7 ff ff       	call   800610 <cprintf_colored>
  801e8b:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801e8e:	8b 45 10             	mov    0x10(%ebp),%eax
  801e91:	83 ec 08             	sub    $0x8,%esp
  801e94:	ff 75 f4             	pushl  -0xc(%ebp)
  801e97:	50                   	push   %eax
  801e98:	e8 d7 e6 ff ff       	call   800574 <vcprintf>
  801e9d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801ea0:	83 ec 08             	sub    $0x8,%esp
  801ea3:	6a 00                	push   $0x0
  801ea5:	68 e0 2b 80 00       	push   $0x802be0
  801eaa:	e8 c5 e6 ff ff       	call   800574 <vcprintf>
  801eaf:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801eb2:	e8 3e e6 ff ff       	call   8004f5 <exit>

	// should not return here
	while (1) ;
  801eb7:	eb fe                	jmp    801eb7 <_panic+0x75>

00801eb9 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
  801ebc:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801ebf:	a1 20 30 80 00       	mov    0x803020,%eax
  801ec4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ecd:	39 c2                	cmp    %eax,%edx
  801ecf:	74 14                	je     801ee5 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ed1:	83 ec 04             	sub    $0x4,%esp
  801ed4:	68 e4 2b 80 00       	push   $0x802be4
  801ed9:	6a 26                	push   $0x26
  801edb:	68 30 2c 80 00       	push   $0x802c30
  801ee0:	e8 5d ff ff ff       	call   801e42 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ee5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801eec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ef3:	e9 c5 00 00 00       	jmp    801fbd <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801ef8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801efb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f02:	8b 45 08             	mov    0x8(%ebp),%eax
  801f05:	01 d0                	add    %edx,%eax
  801f07:	8b 00                	mov    (%eax),%eax
  801f09:	85 c0                	test   %eax,%eax
  801f0b:	75 08                	jne    801f15 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801f0d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801f10:	e9 a5 00 00 00       	jmp    801fba <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801f15:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f1c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801f23:	eb 69                	jmp    801f8e <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801f25:	a1 20 30 80 00       	mov    0x803020,%eax
  801f2a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801f30:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f33:	89 d0                	mov    %edx,%eax
  801f35:	01 c0                	add    %eax,%eax
  801f37:	01 d0                	add    %edx,%eax
  801f39:	c1 e0 03             	shl    $0x3,%eax
  801f3c:	01 c8                	add    %ecx,%eax
  801f3e:	8a 40 04             	mov    0x4(%eax),%al
  801f41:	84 c0                	test   %al,%al
  801f43:	75 46                	jne    801f8b <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f45:	a1 20 30 80 00       	mov    0x803020,%eax
  801f4a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801f50:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f53:	89 d0                	mov    %edx,%eax
  801f55:	01 c0                	add    %eax,%eax
  801f57:	01 d0                	add    %edx,%eax
  801f59:	c1 e0 03             	shl    $0x3,%eax
  801f5c:	01 c8                	add    %ecx,%eax
  801f5e:	8b 00                	mov    (%eax),%eax
  801f60:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801f63:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801f66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f6b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801f6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f70:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801f77:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7a:	01 c8                	add    %ecx,%eax
  801f7c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f7e:	39 c2                	cmp    %eax,%edx
  801f80:	75 09                	jne    801f8b <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801f82:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801f89:	eb 15                	jmp    801fa0 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f8b:	ff 45 e8             	incl   -0x18(%ebp)
  801f8e:	a1 20 30 80 00       	mov    0x803020,%eax
  801f93:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801f99:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f9c:	39 c2                	cmp    %eax,%edx
  801f9e:	77 85                	ja     801f25 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801fa0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801fa4:	75 14                	jne    801fba <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801fa6:	83 ec 04             	sub    $0x4,%esp
  801fa9:	68 3c 2c 80 00       	push   $0x802c3c
  801fae:	6a 3a                	push   $0x3a
  801fb0:	68 30 2c 80 00       	push   $0x802c30
  801fb5:	e8 88 fe ff ff       	call   801e42 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801fba:	ff 45 f0             	incl   -0x10(%ebp)
  801fbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fc0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801fc3:	0f 8c 2f ff ff ff    	jl     801ef8 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801fc9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fd0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801fd7:	eb 26                	jmp    801fff <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801fd9:	a1 20 30 80 00       	mov    0x803020,%eax
  801fde:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801fe4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801fe7:	89 d0                	mov    %edx,%eax
  801fe9:	01 c0                	add    %eax,%eax
  801feb:	01 d0                	add    %edx,%eax
  801fed:	c1 e0 03             	shl    $0x3,%eax
  801ff0:	01 c8                	add    %ecx,%eax
  801ff2:	8a 40 04             	mov    0x4(%eax),%al
  801ff5:	3c 01                	cmp    $0x1,%al
  801ff7:	75 03                	jne    801ffc <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801ff9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ffc:	ff 45 e0             	incl   -0x20(%ebp)
  801fff:	a1 20 30 80 00       	mov    0x803020,%eax
  802004:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80200a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80200d:	39 c2                	cmp    %eax,%edx
  80200f:	77 c8                	ja     801fd9 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802011:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802014:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802017:	74 14                	je     80202d <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  802019:	83 ec 04             	sub    $0x4,%esp
  80201c:	68 90 2c 80 00       	push   $0x802c90
  802021:	6a 44                	push   $0x44
  802023:	68 30 2c 80 00       	push   $0x802c30
  802028:	e8 15 fe ff ff       	call   801e42 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80202d:	90                   	nop
  80202e:	c9                   	leave  
  80202f:	c3                   	ret    

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
