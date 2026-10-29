
obj/user/ef_MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 87 02 00 00       	call   8002bd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
	/*[1] CREATE SHARED VARIABLE & INITIALIZE IT*/
	int *X = smalloc("X", sizeof(int) , 1) ;
  800044:	83 ec 04             	sub    $0x4,%esp
  800047:	6a 01                	push   $0x1
  800049:	6a 04                	push   $0x4
  80004b:	68 40 21 80 00       	push   $0x802140
  800050:	e8 36 17 00 00       	call   80178b <smalloc>
  800055:	83 c4 10             	add    $0x10,%esp
  800058:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	*X = 5 ;
  80005b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80005e:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	//cprintf("Do you want to use semaphore (y/n)? ") ;
	//char select = getchar() ;
	char select = 'y';
  800064:	c6 45 e3 79          	movb   $0x79,-0x1d(%ebp)
	//cputchar(select);
	//cputchar('\n');

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *useSem = smalloc("useSem", sizeof(int) , 0) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	6a 04                	push   $0x4
  80006f:	68 42 21 80 00       	push   $0x802142
  800074:	e8 12 17 00 00       	call   80178b <smalloc>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 dc             	mov    %eax,-0x24(%ebp)
	*useSem = 0 ;
  80007f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800082:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == 'Y' || select == 'y')
  800088:	80 7d e3 59          	cmpb   $0x59,-0x1d(%ebp)
  80008c:	74 06                	je     800094 <_main+0x5c>
  80008e:	80 7d e3 79          	cmpb   $0x79,-0x1d(%ebp)
  800092:	75 09                	jne    80009d <_main+0x65>
		*useSem = 1 ;
  800094:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800097:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

	struct semaphore T, finished, finishedCountMutex ;
	int *numOfFinished ;
	//Create the check-finishing counter
	numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80009d:	83 ec 04             	sub    $0x4,%esp
  8000a0:	6a 01                	push   $0x1
  8000a2:	6a 04                	push   $0x4
  8000a4:	68 49 21 80 00       	push   $0x802149
  8000a9:	e8 dd 16 00 00       	call   80178b <smalloc>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	89 45 d8             	mov    %eax,-0x28(%ebp)
	*numOfFinished = 0 ;
  8000b4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	if (*useSem == 1)
  8000bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000c0:	8b 00                	mov    (%eax),%eax
  8000c2:	83 f8 01             	cmp    $0x1,%eax
  8000c5:	75 42                	jne    800109 <_main+0xd1>
	{
		T = create_semaphore("T", 0);
  8000c7:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	6a 00                	push   $0x0
  8000cf:	68 57 21 80 00       	push   $0x802157
  8000d4:	50                   	push   %eax
  8000d5:	e8 83 1d 00 00       	call   801e5d <create_semaphore>
  8000da:	83 c4 0c             	add    $0xc,%esp
		finished = create_semaphore("finished", 0);
  8000dd:	8d 45 c0             	lea    -0x40(%ebp),%eax
  8000e0:	83 ec 04             	sub    $0x4,%esp
  8000e3:	6a 00                	push   $0x0
  8000e5:	68 59 21 80 00       	push   $0x802159
  8000ea:	50                   	push   %eax
  8000eb:	e8 6d 1d 00 00       	call   801e5d <create_semaphore>
  8000f0:	83 c4 0c             	add    $0xc,%esp
		finishedCountMutex = create_semaphore("finishedCountMutex", 1);
  8000f3:	8d 45 bc             	lea    -0x44(%ebp),%eax
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	6a 01                	push   $0x1
  8000fb:	68 62 21 80 00       	push   $0x802162
  800100:	50                   	push   %eax
  800101:	e8 57 1d 00 00       	call   801e5d <create_semaphore>
  800106:	83 c4 0c             	add    $0xc,%esp
	}

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), 50);
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  80011f:	6a 32                	push   $0x32
  800121:	52                   	push   %edx
  800122:	50                   	push   %eax
  800123:	68 75 21 80 00       	push   $0x802175
  800128:	e8 44 19 00 00       	call   801a71 <sys_create_env>
  80012d:	83 c4 10             	add    $0x10,%esp
  800130:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), 50);
  800133:	a1 20 30 80 00       	mov    0x803020,%eax
  800138:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  80013e:	a1 20 30 80 00       	mov    0x803020,%eax
  800143:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800149:	6a 32                	push   $0x32
  80014b:	52                   	push   %edx
  80014c:	50                   	push   %eax
  80014d:	68 7f 21 80 00       	push   $0x80217f
  800152:	e8 1a 19 00 00       	call   801a71 <sys_create_env>
  800157:	83 c4 10             	add    $0x10,%esp
  80015a:	89 45 d0             	mov    %eax,-0x30(%ebp)
	if (envIdProcessA == E_ENV_CREATION_ERROR || envIdProcessB == E_ENV_CREATION_ERROR)
  80015d:	83 7d d4 ee          	cmpl   $0xffffffee,-0x2c(%ebp)
  800161:	74 06                	je     800169 <_main+0x131>
  800163:	83 7d d0 ee          	cmpl   $0xffffffee,-0x30(%ebp)
  800167:	75 14                	jne    80017d <_main+0x145>
		panic("NO AVAILABLE ENVs...");
  800169:	83 ec 04             	sub    $0x4,%esp
  80016c:	68 89 21 80 00       	push   $0x802189
  800171:	6a 2b                	push   $0x2b
  800173:	68 9e 21 80 00       	push   $0x80219e
  800178:	e8 a0 03 00 00       	call   80051d <_panic>

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  80017d:	83 ec 0c             	sub    $0xc,%esp
  800180:	ff 75 d4             	pushl  -0x2c(%ebp)
  800183:	e8 07 19 00 00       	call   801a8f <sys_run_env>
  800188:	83 c4 10             	add    $0x10,%esp
	//env_sleep(10000);
	sys_run_env(envIdProcessB);
  80018b:	83 ec 0c             	sub    $0xc,%esp
  80018e:	ff 75 d0             	pushl  -0x30(%ebp)
  800191:	e8 f9 18 00 00       	call   801a8f <sys_run_env>
  800196:	83 c4 10             	add    $0x10,%esp

	/*[5] BUSY-WAIT TILL FINISHING BOTH PROCESSES*/
	if (*useSem == 1)
  800199:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80019c:	8b 00                	mov    (%eax),%eax
  80019e:	83 f8 01             	cmp    $0x1,%eax
  8001a1:	75 1e                	jne    8001c1 <_main+0x189>
	{
		wait_semaphore(finished);
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	ff 75 c0             	pushl  -0x40(%ebp)
  8001a9:	e8 e3 1c 00 00       	call   801e91 <wait_semaphore>
  8001ae:	83 c4 10             	add    $0x10,%esp
		wait_semaphore(finished);
  8001b1:	83 ec 0c             	sub    $0xc,%esp
  8001b4:	ff 75 c0             	pushl  -0x40(%ebp)
  8001b7:	e8 d5 1c 00 00       	call   801e91 <wait_semaphore>
  8001bc:	83 c4 10             	add    $0x10,%esp
  8001bf:	eb 0b                	jmp    8001cc <_main+0x194>
	}
	else
	{
		while (*numOfFinished != 2) ;
  8001c1:	90                   	nop
  8001c2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001c5:	8b 00                	mov    (%eax),%eax
  8001c7:	83 f8 02             	cmp    $0x2,%eax
  8001ca:	75 f6                	jne    8001c2 <_main+0x18a>
	}

	/*[6] PRINT X*/
	atomic_cprintf("Final value of X = %d\n", *X);
  8001cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cf:	8b 00                	mov    (%eax),%eax
  8001d1:	83 ec 08             	sub    $0x8,%esp
  8001d4:	50                   	push   %eax
  8001d5:	68 b9 21 80 00       	push   $0x8021b9
  8001da:	e8 7e 06 00 00       	call   80085d <atomic_cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp

	//ensure that X has the expected value (=11)
	if (*X != 11)
  8001e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e5:	8b 00                	mov    (%eax),%eax
  8001e7:	83 f8 0b             	cmp    $0xb,%eax
  8001ea:	74 14                	je     800200 <_main+0x1c8>
		panic("Final value of X is not correct. Semaphore and/or shared variables are not working correctly\n");
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 d0 21 80 00       	push   $0x8021d0
  8001f4:	6a 42                	push   $0x42
  8001f6:	68 9e 21 80 00       	push   $0x80219e
  8001fb:	e8 1d 03 00 00       	call   80051d <_panic>

	int32 parentenvID = sys_getparentenvid();
  800200:	e8 f3 18 00 00       	call   801af8 <sys_getparentenvid>
  800205:	89 45 cc             	mov    %eax,-0x34(%ebp)
	if(parentenvID > 0)
  800208:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  80020c:	0f 8e a2 00 00 00    	jle    8002b4 <_main+0x27c>
	{
		//Get the check-finishing counter
		int *AllFinish = NULL;
  800212:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
		AllFinish = sget(parentenvID, "finishedCount") ;
  800219:	83 ec 08             	sub    $0x8,%esp
  80021c:	68 49 21 80 00       	push   $0x802149
  800221:	ff 75 cc             	pushl  -0x34(%ebp)
  800224:	e8 96 15 00 00       	call   8017bf <sget>
  800229:	83 c4 10             	add    $0x10,%esp
  80022c:	89 45 c8             	mov    %eax,-0x38(%ebp)

		//DISABLE the interrupt to ensure the env_free is done as a whole without preemption
		//to avoid context switch (due to clock interrupt) while freeing the env to prevent:
		//	1. context switching to a wrong process specially in the part of temporarily switching the CPU process for freeing shared variables
		//	2. changing the # free frames
		char changeIntCmd[100] = "__changeInterruptStatus__";
  80022f:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  800235:	bb 2e 22 80 00       	mov    $0x80222e,%ebx
  80023a:	ba 1a 00 00 00       	mov    $0x1a,%edx
  80023f:	89 c7                	mov    %eax,%edi
  800241:	89 de                	mov    %ebx,%esi
  800243:	89 d1                	mov    %edx,%ecx
  800245:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800247:	8d 95 72 ff ff ff    	lea    -0x8e(%ebp),%edx
  80024d:	b9 4a 00 00 00       	mov    $0x4a,%ecx
  800252:	b0 00                	mov    $0x0,%al
  800254:	89 d7                	mov    %edx,%edi
  800256:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(changeIntCmd, 0);
  800258:	83 ec 08             	sub    $0x8,%esp
  80025b:	6a 00                	push   $0x0
  80025d:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	e8 76 1a 00 00       	call   801cdf <sys_utilities>
  800269:	83 c4 10             	add    $0x10,%esp
		{
			sys_destroy_env(envIdProcessA);
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	ff 75 d4             	pushl  -0x2c(%ebp)
  800272:	e8 34 18 00 00       	call   801aab <sys_destroy_env>
  800277:	83 c4 10             	add    $0x10,%esp
			sys_destroy_env(envIdProcessB);
  80027a:	83 ec 0c             	sub    $0xc,%esp
  80027d:	ff 75 d0             	pushl  -0x30(%ebp)
  800280:	e8 26 18 00 00       	call   801aab <sys_destroy_env>
  800285:	83 c4 10             	add    $0x10,%esp
		}
		sys_utilities(changeIntCmd, 1);
  800288:	83 ec 08             	sub    $0x8,%esp
  80028b:	6a 01                	push   $0x1
  80028d:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
  800293:	50                   	push   %eax
  800294:	e8 46 1a 00 00       	call   801cdf <sys_utilities>
  800299:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80029c:	e8 c6 15 00 00       	call   801867 <sys_lock_cons>
		{
			(*AllFinish)++ ;
  8002a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8002a4:	8b 00                	mov    (%eax),%eax
  8002a6:	8d 50 01             	lea    0x1(%eax),%edx
  8002a9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8002ac:	89 10                	mov    %edx,(%eax)
		}
		sys_unlock_cons();
  8002ae:	e8 ce 15 00 00       	call   801881 <sys_unlock_cons>
	}

	return;
  8002b3:	90                   	nop
  8002b4:	90                   	nop
}
  8002b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002b8:	5b                   	pop    %ebx
  8002b9:	5e                   	pop    %esi
  8002ba:	5f                   	pop    %edi
  8002bb:	5d                   	pop    %ebp
  8002bc:	c3                   	ret    

008002bd <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	57                   	push   %edi
  8002c1:	56                   	push   %esi
  8002c2:	53                   	push   %ebx
  8002c3:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002c9:	e8 11 18 00 00       	call   801adf <sys_getenvindex>
  8002ce:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002d1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002d4:	89 d0                	mov    %edx,%eax
  8002d6:	c1 e0 03             	shl    $0x3,%eax
  8002d9:	01 d0                	add    %edx,%eax
  8002db:	c1 e0 06             	shl    $0x6,%eax
  8002de:	01 d0                	add    %edx,%eax
  8002e0:	c1 e0 03             	shl    $0x3,%eax
  8002e3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002e8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f2:	8a 40 10             	mov    0x10(%eax),%al
  8002f5:	84 c0                	test   %al,%al
  8002f7:	74 0d                	je     800306 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fe:	83 c0 10             	add    $0x10,%eax
  800301:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800306:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80030a:	7e 0a                	jle    800316 <libmain+0x59>
		binaryname = argv[0];
  80030c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030f:	8b 00                	mov    (%eax),%eax
  800311:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	ff 75 0c             	pushl  0xc(%ebp)
  80031c:	ff 75 08             	pushl  0x8(%ebp)
  80031f:	e8 14 fd ff ff       	call   800038 <_main>
  800324:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800327:	a1 00 30 80 00       	mov    0x803000,%eax
  80032c:	85 c0                	test   %eax,%eax
  80032e:	0f 84 b7 01 00 00    	je     8004eb <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800334:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80033a:	bb d0 23 80 00       	mov    $0x8023d0,%ebx
  80033f:	ba 0e 00 00 00       	mov    $0xe,%edx
  800344:	89 c7                	mov    %eax,%edi
  800346:	89 de                	mov    %ebx,%esi
  800348:	89 d1                	mov    %edx,%ecx
  80034a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80034c:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800352:	b9 56 00 00 00       	mov    $0x56,%ecx
  800357:	b0 00                	mov    $0x0,%al
  800359:	89 d7                	mov    %edx,%edi
  80035b:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80035d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800364:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800367:	83 ec 08             	sub    $0x8,%esp
  80036a:	50                   	push   %eax
  80036b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800371:	50                   	push   %eax
  800372:	e8 68 19 00 00       	call   801cdf <sys_utilities>
  800377:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80037a:	e8 e8 14 00 00       	call   801867 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80037f:	83 ec 0c             	sub    $0xc,%esp
  800382:	68 ac 22 80 00       	push   $0x8022ac
  800387:	e8 5f 04 00 00       	call   8007eb <cprintf>
  80038c:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80038f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800392:	85 c0                	test   %eax,%eax
  800394:	74 58                	je     8003ee <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800396:	e8 62 19 00 00       	call   801cfd <sys_get_optimal_num_faults>
  80039b:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80039e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003a4:	bb 34 24 80 00       	mov    $0x802434,%ebx
  8003a9:	ba 11 00 00 00       	mov    $0x11,%edx
  8003ae:	89 c7                	mov    %eax,%edi
  8003b0:	89 de                	mov    %ebx,%esi
  8003b2:	89 d1                	mov    %edx,%ecx
  8003b4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8003b6:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8003b9:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003be:	b0 00                	mov    $0x0,%al
  8003c0:	89 d7                	mov    %edx,%edi
  8003c2:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003c4:	83 ec 08             	sub    $0x8,%esp
  8003c7:	ff 75 dc             	pushl  -0x24(%ebp)
  8003ca:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003d0:	50                   	push   %eax
  8003d1:	e8 09 19 00 00       	call   801cdf <sys_utilities>
  8003d6:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003d9:	83 ec 08             	sub    $0x8,%esp
  8003dc:	ff 75 dc             	pushl  -0x24(%ebp)
  8003df:	68 d4 22 80 00       	push   $0x8022d4
  8003e4:	e8 02 04 00 00       	call   8007eb <cprintf>
  8003e9:	83 c4 10             	add    $0x10,%esp
  8003ec:	eb 59                	jmp    800447 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fe:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	52                   	push   %edx
  800408:	50                   	push   %eax
  800409:	68 f8 22 80 00       	push   $0x8022f8
  80040e:	e8 d8 03 00 00       	call   8007eb <cprintf>
  800413:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800416:	a1 20 30 80 00       	mov    0x803020,%eax
  80041b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800421:	a1 20 30 80 00       	mov    0x803020,%eax
  800426:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80042c:	a1 20 30 80 00       	mov    0x803020,%eax
  800431:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800437:	51                   	push   %ecx
  800438:	52                   	push   %edx
  800439:	50                   	push   %eax
  80043a:	68 20 23 80 00       	push   $0x802320
  80043f:	e8 a7 03 00 00       	call   8007eb <cprintf>
  800444:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800447:	a1 20 30 80 00       	mov    0x803020,%eax
  80044c:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800452:	83 ec 08             	sub    $0x8,%esp
  800455:	50                   	push   %eax
  800456:	68 78 23 80 00       	push   $0x802378
  80045b:	e8 8b 03 00 00       	call   8007eb <cprintf>
  800460:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800463:	83 ec 0c             	sub    $0xc,%esp
  800466:	68 8c 23 80 00       	push   $0x80238c
  80046b:	e8 7b 03 00 00       	call   8007eb <cprintf>
  800470:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800473:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80047a:	eb 28                	jmp    8004a4 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80047c:	a1 20 30 80 00       	mov    0x803020,%eax
  800481:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800484:	81 c2 74 04 00 00    	add    $0x474,%edx
  80048a:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80048d:	83 ec 04             	sub    $0x4,%esp
  800490:	50                   	push   %eax
  800491:	ff 75 e4             	pushl  -0x1c(%ebp)
  800494:	68 a3 23 80 00       	push   $0x8023a3
  800499:	e8 4d 03 00 00       	call   8007eb <cprintf>
  80049e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8004a1:	ff 45 e4             	incl   -0x1c(%ebp)
  8004a4:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004a8:	7e d2                	jle    80047c <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8004aa:	83 ec 0c             	sub    $0xc,%esp
  8004ad:	68 b2 23 80 00       	push   $0x8023b2
  8004b2:	e8 34 03 00 00       	call   8007eb <cprintf>
  8004b7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8004ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bf:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004c5:	83 ec 08             	sub    $0x8,%esp
  8004c8:	50                   	push   %eax
  8004c9:	68 b6 23 80 00       	push   $0x8023b6
  8004ce:	e8 18 03 00 00       	call   8007eb <cprintf>
  8004d3:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004d6:	83 ec 0c             	sub    $0xc,%esp
  8004d9:	68 ac 22 80 00       	push   $0x8022ac
  8004de:	e8 08 03 00 00       	call   8007eb <cprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004e6:	e8 96 13 00 00       	call   801881 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004eb:	e8 1f 00 00 00       	call   80050f <exit>
}
  8004f0:	90                   	nop
  8004f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004f4:	5b                   	pop    %ebx
  8004f5:	5e                   	pop    %esi
  8004f6:	5f                   	pop    %edi
  8004f7:	5d                   	pop    %ebp
  8004f8:	c3                   	ret    

008004f9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004f9:	55                   	push   %ebp
  8004fa:	89 e5                	mov    %esp,%ebp
  8004fc:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004ff:	83 ec 0c             	sub    $0xc,%esp
  800502:	6a 00                	push   $0x0
  800504:	e8 a2 15 00 00       	call   801aab <sys_destroy_env>
  800509:	83 c4 10             	add    $0x10,%esp
}
  80050c:	90                   	nop
  80050d:	c9                   	leave  
  80050e:	c3                   	ret    

0080050f <exit>:

void
exit(void)
{
  80050f:	55                   	push   %ebp
  800510:	89 e5                	mov    %esp,%ebp
  800512:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800515:	e8 f7 15 00 00       	call   801b11 <sys_exit_env>
}
  80051a:	90                   	nop
  80051b:	c9                   	leave  
  80051c:	c3                   	ret    

0080051d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80051d:	55                   	push   %ebp
  80051e:	89 e5                	mov    %esp,%ebp
  800520:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800523:	8d 45 10             	lea    0x10(%ebp),%eax
  800526:	83 c0 04             	add    $0x4,%eax
  800529:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80052c:	a1 28 31 80 00       	mov    0x803128,%eax
  800531:	85 c0                	test   %eax,%eax
  800533:	74 16                	je     80054b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800535:	a1 28 31 80 00       	mov    0x803128,%eax
  80053a:	83 ec 08             	sub    $0x8,%esp
  80053d:	50                   	push   %eax
  80053e:	68 98 24 80 00       	push   $0x802498
  800543:	e8 a3 02 00 00       	call   8007eb <cprintf>
  800548:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80054b:	a1 04 30 80 00       	mov    0x803004,%eax
  800550:	83 ec 0c             	sub    $0xc,%esp
  800553:	ff 75 0c             	pushl  0xc(%ebp)
  800556:	ff 75 08             	pushl  0x8(%ebp)
  800559:	50                   	push   %eax
  80055a:	68 a0 24 80 00       	push   $0x8024a0
  80055f:	6a 74                	push   $0x74
  800561:	e8 b2 02 00 00       	call   800818 <cprintf_colored>
  800566:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800569:	8b 45 10             	mov    0x10(%ebp),%eax
  80056c:	83 ec 08             	sub    $0x8,%esp
  80056f:	ff 75 f4             	pushl  -0xc(%ebp)
  800572:	50                   	push   %eax
  800573:	e8 04 02 00 00       	call   80077c <vcprintf>
  800578:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80057b:	83 ec 08             	sub    $0x8,%esp
  80057e:	6a 00                	push   $0x0
  800580:	68 c8 24 80 00       	push   $0x8024c8
  800585:	e8 f2 01 00 00       	call   80077c <vcprintf>
  80058a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80058d:	e8 7d ff ff ff       	call   80050f <exit>

	// should not return here
	while (1) ;
  800592:	eb fe                	jmp    800592 <_panic+0x75>

00800594 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800594:	55                   	push   %ebp
  800595:	89 e5                	mov    %esp,%ebp
  800597:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80059a:	a1 20 30 80 00       	mov    0x803020,%eax
  80059f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a8:	39 c2                	cmp    %eax,%edx
  8005aa:	74 14                	je     8005c0 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 cc 24 80 00       	push   $0x8024cc
  8005b4:	6a 26                	push   $0x26
  8005b6:	68 18 25 80 00       	push   $0x802518
  8005bb:	e8 5d ff ff ff       	call   80051d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005ce:	e9 c5 00 00 00       	jmp    800698 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e0:	01 d0                	add    %edx,%eax
  8005e2:	8b 00                	mov    (%eax),%eax
  8005e4:	85 c0                	test   %eax,%eax
  8005e6:	75 08                	jne    8005f0 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005e8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005eb:	e9 a5 00 00 00       	jmp    800695 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005fe:	eb 69                	jmp    800669 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800600:	a1 20 30 80 00       	mov    0x803020,%eax
  800605:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80060b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80060e:	89 d0                	mov    %edx,%eax
  800610:	01 c0                	add    %eax,%eax
  800612:	01 d0                	add    %edx,%eax
  800614:	c1 e0 03             	shl    $0x3,%eax
  800617:	01 c8                	add    %ecx,%eax
  800619:	8a 40 04             	mov    0x4(%eax),%al
  80061c:	84 c0                	test   %al,%al
  80061e:	75 46                	jne    800666 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800620:	a1 20 30 80 00       	mov    0x803020,%eax
  800625:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80062b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80062e:	89 d0                	mov    %edx,%eax
  800630:	01 c0                	add    %eax,%eax
  800632:	01 d0                	add    %edx,%eax
  800634:	c1 e0 03             	shl    $0x3,%eax
  800637:	01 c8                	add    %ecx,%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80063e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800641:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800646:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800648:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	01 c8                	add    %ecx,%eax
  800657:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800659:	39 c2                	cmp    %eax,%edx
  80065b:	75 09                	jne    800666 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80065d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800664:	eb 15                	jmp    80067b <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800666:	ff 45 e8             	incl   -0x18(%ebp)
  800669:	a1 20 30 80 00       	mov    0x803020,%eax
  80066e:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800674:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800677:	39 c2                	cmp    %eax,%edx
  800679:	77 85                	ja     800600 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80067b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80067f:	75 14                	jne    800695 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800681:	83 ec 04             	sub    $0x4,%esp
  800684:	68 24 25 80 00       	push   $0x802524
  800689:	6a 3a                	push   $0x3a
  80068b:	68 18 25 80 00       	push   $0x802518
  800690:	e8 88 fe ff ff       	call   80051d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800695:	ff 45 f0             	incl   -0x10(%ebp)
  800698:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80069e:	0f 8c 2f ff ff ff    	jl     8005d3 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006b2:	eb 26                	jmp    8006da <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8006bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c2:	89 d0                	mov    %edx,%eax
  8006c4:	01 c0                	add    %eax,%eax
  8006c6:	01 d0                	add    %edx,%eax
  8006c8:	c1 e0 03             	shl    $0x3,%eax
  8006cb:	01 c8                	add    %ecx,%eax
  8006cd:	8a 40 04             	mov    0x4(%eax),%al
  8006d0:	3c 01                	cmp    $0x1,%al
  8006d2:	75 03                	jne    8006d7 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006d4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006d7:	ff 45 e0             	incl   -0x20(%ebp)
  8006da:	a1 20 30 80 00       	mov    0x803020,%eax
  8006df:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006e8:	39 c2                	cmp    %eax,%edx
  8006ea:	77 c8                	ja     8006b4 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006f2:	74 14                	je     800708 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006f4:	83 ec 04             	sub    $0x4,%esp
  8006f7:	68 78 25 80 00       	push   $0x802578
  8006fc:	6a 44                	push   $0x44
  8006fe:	68 18 25 80 00       	push   $0x802518
  800703:	e8 15 fe ff ff       	call   80051d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800708:	90                   	nop
  800709:	c9                   	leave  
  80070a:	c3                   	ret    

0080070b <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80070b:	55                   	push   %ebp
  80070c:	89 e5                	mov    %esp,%ebp
  80070e:	53                   	push   %ebx
  80070f:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800712:	8b 45 0c             	mov    0xc(%ebp),%eax
  800715:	8b 00                	mov    (%eax),%eax
  800717:	8d 48 01             	lea    0x1(%eax),%ecx
  80071a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80071d:	89 0a                	mov    %ecx,(%edx)
  80071f:	8b 55 08             	mov    0x8(%ebp),%edx
  800722:	88 d1                	mov    %dl,%cl
  800724:	8b 55 0c             	mov    0xc(%ebp),%edx
  800727:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80072b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	3d ff 00 00 00       	cmp    $0xff,%eax
  800735:	75 30                	jne    800767 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800737:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80073d:	a0 40 30 80 00       	mov    0x803040,%al
  800742:	0f b6 c0             	movzbl %al,%eax
  800745:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800748:	8b 09                	mov    (%ecx),%ecx
  80074a:	89 cb                	mov    %ecx,%ebx
  80074c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80074f:	83 c1 08             	add    $0x8,%ecx
  800752:	52                   	push   %edx
  800753:	50                   	push   %eax
  800754:	53                   	push   %ebx
  800755:	51                   	push   %ecx
  800756:	e8 c8 10 00 00       	call   801823 <sys_cputs>
  80075b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80075e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800761:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076a:	8b 40 04             	mov    0x4(%eax),%eax
  80076d:	8d 50 01             	lea    0x1(%eax),%edx
  800770:	8b 45 0c             	mov    0xc(%ebp),%eax
  800773:	89 50 04             	mov    %edx,0x4(%eax)
}
  800776:	90                   	nop
  800777:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80077a:	c9                   	leave  
  80077b:	c3                   	ret    

0080077c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80077c:	55                   	push   %ebp
  80077d:	89 e5                	mov    %esp,%ebp
  80077f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800785:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80078c:	00 00 00 
	b.cnt = 0;
  80078f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800796:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	ff 75 08             	pushl  0x8(%ebp)
  80079f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007a5:	50                   	push   %eax
  8007a6:	68 0b 07 80 00       	push   $0x80070b
  8007ab:	e8 5a 02 00 00       	call   800a0a <vprintfmt>
  8007b0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8007b3:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8007b9:	a0 40 30 80 00       	mov    0x803040,%al
  8007be:	0f b6 c0             	movzbl %al,%eax
  8007c1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8007c7:	52                   	push   %edx
  8007c8:	50                   	push   %eax
  8007c9:	51                   	push   %ecx
  8007ca:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007d0:	83 c0 08             	add    $0x8,%eax
  8007d3:	50                   	push   %eax
  8007d4:	e8 4a 10 00 00       	call   801823 <sys_cputs>
  8007d9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007dc:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007e3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007e9:	c9                   	leave  
  8007ea:	c3                   	ret    

008007eb <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007eb:	55                   	push   %ebp
  8007ec:	89 e5                	mov    %esp,%ebp
  8007ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007f1:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007f8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 f4             	pushl  -0xc(%ebp)
  800807:	50                   	push   %eax
  800808:	e8 6f ff ff ff       	call   80077c <vcprintf>
  80080d:	83 c4 10             	add    $0x10,%esp
  800810:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800813:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800816:	c9                   	leave  
  800817:	c3                   	ret    

00800818 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800818:	55                   	push   %ebp
  800819:	89 e5                	mov    %esp,%ebp
  80081b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80081e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	c1 e0 08             	shl    $0x8,%eax
  80082b:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800830:	8d 45 0c             	lea    0xc(%ebp),%eax
  800833:	83 c0 04             	add    $0x4,%eax
  800836:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083c:	83 ec 08             	sub    $0x8,%esp
  80083f:	ff 75 f4             	pushl  -0xc(%ebp)
  800842:	50                   	push   %eax
  800843:	e8 34 ff ff ff       	call   80077c <vcprintf>
  800848:	83 c4 10             	add    $0x10,%esp
  80084b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80084e:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800855:	07 00 00 

	return cnt;
  800858:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80085b:	c9                   	leave  
  80085c:	c3                   	ret    

0080085d <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80085d:	55                   	push   %ebp
  80085e:	89 e5                	mov    %esp,%ebp
  800860:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800863:	e8 ff 0f 00 00       	call   801867 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800868:	8d 45 0c             	lea    0xc(%ebp),%eax
  80086b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	83 ec 08             	sub    $0x8,%esp
  800874:	ff 75 f4             	pushl  -0xc(%ebp)
  800877:	50                   	push   %eax
  800878:	e8 ff fe ff ff       	call   80077c <vcprintf>
  80087d:	83 c4 10             	add    $0x10,%esp
  800880:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800883:	e8 f9 0f 00 00       	call   801881 <sys_unlock_cons>
	return cnt;
  800888:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80088b:	c9                   	leave  
  80088c:	c3                   	ret    

0080088d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80088d:	55                   	push   %ebp
  80088e:	89 e5                	mov    %esp,%ebp
  800890:	53                   	push   %ebx
  800891:	83 ec 14             	sub    $0x14,%esp
  800894:	8b 45 10             	mov    0x10(%ebp),%eax
  800897:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089a:	8b 45 14             	mov    0x14(%ebp),%eax
  80089d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008a0:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a3:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008ab:	77 55                	ja     800902 <printnum+0x75>
  8008ad:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008b0:	72 05                	jb     8008b7 <printnum+0x2a>
  8008b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008b5:	77 4b                	ja     800902 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008b7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008ba:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008bd:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c0:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c5:	52                   	push   %edx
  8008c6:	50                   	push   %eax
  8008c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8008cd:	e8 fe 15 00 00       	call   801ed0 <__udivdi3>
  8008d2:	83 c4 10             	add    $0x10,%esp
  8008d5:	83 ec 04             	sub    $0x4,%esp
  8008d8:	ff 75 20             	pushl  0x20(%ebp)
  8008db:	53                   	push   %ebx
  8008dc:	ff 75 18             	pushl  0x18(%ebp)
  8008df:	52                   	push   %edx
  8008e0:	50                   	push   %eax
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	ff 75 08             	pushl  0x8(%ebp)
  8008e7:	e8 a1 ff ff ff       	call   80088d <printnum>
  8008ec:	83 c4 20             	add    $0x20,%esp
  8008ef:	eb 1a                	jmp    80090b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008f1:	83 ec 08             	sub    $0x8,%esp
  8008f4:	ff 75 0c             	pushl  0xc(%ebp)
  8008f7:	ff 75 20             	pushl  0x20(%ebp)
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	ff d0                	call   *%eax
  8008ff:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800902:	ff 4d 1c             	decl   0x1c(%ebp)
  800905:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800909:	7f e6                	jg     8008f1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80090b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80090e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800913:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800916:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800919:	53                   	push   %ebx
  80091a:	51                   	push   %ecx
  80091b:	52                   	push   %edx
  80091c:	50                   	push   %eax
  80091d:	e8 be 16 00 00       	call   801fe0 <__umoddi3>
  800922:	83 c4 10             	add    $0x10,%esp
  800925:	05 f4 27 80 00       	add    $0x8027f4,%eax
  80092a:	8a 00                	mov    (%eax),%al
  80092c:	0f be c0             	movsbl %al,%eax
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 0c             	pushl  0xc(%ebp)
  800935:	50                   	push   %eax
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	ff d0                	call   *%eax
  80093b:	83 c4 10             	add    $0x10,%esp
}
  80093e:	90                   	nop
  80093f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800942:	c9                   	leave  
  800943:	c3                   	ret    

00800944 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800947:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80094b:	7e 1c                	jle    800969 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80094d:	8b 45 08             	mov    0x8(%ebp),%eax
  800950:	8b 00                	mov    (%eax),%eax
  800952:	8d 50 08             	lea    0x8(%eax),%edx
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	89 10                	mov    %edx,(%eax)
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	8b 00                	mov    (%eax),%eax
  80095f:	83 e8 08             	sub    $0x8,%eax
  800962:	8b 50 04             	mov    0x4(%eax),%edx
  800965:	8b 00                	mov    (%eax),%eax
  800967:	eb 40                	jmp    8009a9 <getuint+0x65>
	else if (lflag)
  800969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096d:	74 1e                	je     80098d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	8d 50 04             	lea    0x4(%eax),%edx
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 10                	mov    %edx,(%eax)
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	ba 00 00 00 00       	mov    $0x0,%edx
  80098b:	eb 1c                	jmp    8009a9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	8d 50 04             	lea    0x4(%eax),%edx
  800995:	8b 45 08             	mov    0x8(%ebp),%eax
  800998:	89 10                	mov    %edx,(%eax)
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	83 e8 04             	sub    $0x4,%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009a9:	5d                   	pop    %ebp
  8009aa:	c3                   	ret    

008009ab <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009ae:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009b2:	7e 1c                	jle    8009d0 <getint+0x25>
		return va_arg(*ap, long long);
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	8b 00                	mov    (%eax),%eax
  8009b9:	8d 50 08             	lea    0x8(%eax),%edx
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	89 10                	mov    %edx,(%eax)
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	8b 00                	mov    (%eax),%eax
  8009c6:	83 e8 08             	sub    $0x8,%eax
  8009c9:	8b 50 04             	mov    0x4(%eax),%edx
  8009cc:	8b 00                	mov    (%eax),%eax
  8009ce:	eb 38                	jmp    800a08 <getint+0x5d>
	else if (lflag)
  8009d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d4:	74 1a                	je     8009f0 <getint+0x45>
		return va_arg(*ap, long);
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	8b 00                	mov    (%eax),%eax
  8009db:	8d 50 04             	lea    0x4(%eax),%edx
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	89 10                	mov    %edx,(%eax)
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	8b 00                	mov    (%eax),%eax
  8009e8:	83 e8 04             	sub    $0x4,%eax
  8009eb:	8b 00                	mov    (%eax),%eax
  8009ed:	99                   	cltd   
  8009ee:	eb 18                	jmp    800a08 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	8b 00                	mov    (%eax),%eax
  8009f5:	8d 50 04             	lea    0x4(%eax),%edx
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	89 10                	mov    %edx,(%eax)
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	8b 00                	mov    (%eax),%eax
  800a02:	83 e8 04             	sub    $0x4,%eax
  800a05:	8b 00                	mov    (%eax),%eax
  800a07:	99                   	cltd   
}
  800a08:	5d                   	pop    %ebp
  800a09:	c3                   	ret    

00800a0a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
  800a0d:	56                   	push   %esi
  800a0e:	53                   	push   %ebx
  800a0f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a12:	eb 17                	jmp    800a2b <vprintfmt+0x21>
			if (ch == '\0')
  800a14:	85 db                	test   %ebx,%ebx
  800a16:	0f 84 c1 03 00 00    	je     800ddd <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800a1c:	83 ec 08             	sub    $0x8,%esp
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	53                   	push   %ebx
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	ff d0                	call   *%eax
  800a28:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2e:	8d 50 01             	lea    0x1(%eax),%edx
  800a31:	89 55 10             	mov    %edx,0x10(%ebp)
  800a34:	8a 00                	mov    (%eax),%al
  800a36:	0f b6 d8             	movzbl %al,%ebx
  800a39:	83 fb 25             	cmp    $0x25,%ebx
  800a3c:	75 d6                	jne    800a14 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a3e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a42:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a49:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a50:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a57:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a61:	8d 50 01             	lea    0x1(%eax),%edx
  800a64:	89 55 10             	mov    %edx,0x10(%ebp)
  800a67:	8a 00                	mov    (%eax),%al
  800a69:	0f b6 d8             	movzbl %al,%ebx
  800a6c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a6f:	83 f8 5b             	cmp    $0x5b,%eax
  800a72:	0f 87 3d 03 00 00    	ja     800db5 <vprintfmt+0x3ab>
  800a78:	8b 04 85 18 28 80 00 	mov    0x802818(,%eax,4),%eax
  800a7f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a81:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a85:	eb d7                	jmp    800a5e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a87:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a8b:	eb d1                	jmp    800a5e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a8d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a94:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a97:	89 d0                	mov    %edx,%eax
  800a99:	c1 e0 02             	shl    $0x2,%eax
  800a9c:	01 d0                	add    %edx,%eax
  800a9e:	01 c0                	add    %eax,%eax
  800aa0:	01 d8                	add    %ebx,%eax
  800aa2:	83 e8 30             	sub    $0x30,%eax
  800aa5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800aa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ab0:	83 fb 2f             	cmp    $0x2f,%ebx
  800ab3:	7e 3e                	jle    800af3 <vprintfmt+0xe9>
  800ab5:	83 fb 39             	cmp    $0x39,%ebx
  800ab8:	7f 39                	jg     800af3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800aba:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800abd:	eb d5                	jmp    800a94 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800abf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac2:	83 c0 04             	add    $0x4,%eax
  800ac5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	83 e8 04             	sub    $0x4,%eax
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ad3:	eb 1f                	jmp    800af4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ad5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad9:	79 83                	jns    800a5e <vprintfmt+0x54>
				width = 0;
  800adb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ae2:	e9 77 ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ae7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aee:	e9 6b ff ff ff       	jmp    800a5e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800af3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800af4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800af8:	0f 89 60 ff ff ff    	jns    800a5e <vprintfmt+0x54>
				width = precision, precision = -1;
  800afe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b04:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b0b:	e9 4e ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b10:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b13:	e9 46 ff ff ff       	jmp    800a5e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b18:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	83 ec 08             	sub    $0x8,%esp
  800b2c:	ff 75 0c             	pushl  0xc(%ebp)
  800b2f:	50                   	push   %eax
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	ff d0                	call   *%eax
  800b35:	83 c4 10             	add    $0x10,%esp
			break;
  800b38:	e9 9b 02 00 00       	jmp    800dd8 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b40:	83 c0 04             	add    $0x4,%eax
  800b43:	89 45 14             	mov    %eax,0x14(%ebp)
  800b46:	8b 45 14             	mov    0x14(%ebp),%eax
  800b49:	83 e8 04             	sub    $0x4,%eax
  800b4c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b4e:	85 db                	test   %ebx,%ebx
  800b50:	79 02                	jns    800b54 <vprintfmt+0x14a>
				err = -err;
  800b52:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b54:	83 fb 64             	cmp    $0x64,%ebx
  800b57:	7f 0b                	jg     800b64 <vprintfmt+0x15a>
  800b59:	8b 34 9d 60 26 80 00 	mov    0x802660(,%ebx,4),%esi
  800b60:	85 f6                	test   %esi,%esi
  800b62:	75 19                	jne    800b7d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b64:	53                   	push   %ebx
  800b65:	68 05 28 80 00       	push   $0x802805
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	ff 75 08             	pushl  0x8(%ebp)
  800b70:	e8 70 02 00 00       	call   800de5 <printfmt>
  800b75:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b78:	e9 5b 02 00 00       	jmp    800dd8 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b7d:	56                   	push   %esi
  800b7e:	68 0e 28 80 00       	push   $0x80280e
  800b83:	ff 75 0c             	pushl  0xc(%ebp)
  800b86:	ff 75 08             	pushl  0x8(%ebp)
  800b89:	e8 57 02 00 00       	call   800de5 <printfmt>
  800b8e:	83 c4 10             	add    $0x10,%esp
			break;
  800b91:	e9 42 02 00 00       	jmp    800dd8 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b96:	8b 45 14             	mov    0x14(%ebp),%eax
  800b99:	83 c0 04             	add    $0x4,%eax
  800b9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba2:	83 e8 04             	sub    $0x4,%eax
  800ba5:	8b 30                	mov    (%eax),%esi
  800ba7:	85 f6                	test   %esi,%esi
  800ba9:	75 05                	jne    800bb0 <vprintfmt+0x1a6>
				p = "(null)";
  800bab:	be 11 28 80 00       	mov    $0x802811,%esi
			if (width > 0 && padc != '-')
  800bb0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb4:	7e 6d                	jle    800c23 <vprintfmt+0x219>
  800bb6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bba:	74 67                	je     800c23 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	50                   	push   %eax
  800bc3:	56                   	push   %esi
  800bc4:	e8 1e 03 00 00       	call   800ee7 <strnlen>
  800bc9:	83 c4 10             	add    $0x10,%esp
  800bcc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bcf:	eb 16                	jmp    800be7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bd1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bd5:	83 ec 08             	sub    $0x8,%esp
  800bd8:	ff 75 0c             	pushl  0xc(%ebp)
  800bdb:	50                   	push   %eax
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	ff d0                	call   *%eax
  800be1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800be4:	ff 4d e4             	decl   -0x1c(%ebp)
  800be7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800beb:	7f e4                	jg     800bd1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bed:	eb 34                	jmp    800c23 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bef:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bf3:	74 1c                	je     800c11 <vprintfmt+0x207>
  800bf5:	83 fb 1f             	cmp    $0x1f,%ebx
  800bf8:	7e 05                	jle    800bff <vprintfmt+0x1f5>
  800bfa:	83 fb 7e             	cmp    $0x7e,%ebx
  800bfd:	7e 12                	jle    800c11 <vprintfmt+0x207>
					putch('?', putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	6a 3f                	push   $0x3f
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
  800c0f:	eb 0f                	jmp    800c20 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c11:	83 ec 08             	sub    $0x8,%esp
  800c14:	ff 75 0c             	pushl  0xc(%ebp)
  800c17:	53                   	push   %ebx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	ff d0                	call   *%eax
  800c1d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c20:	ff 4d e4             	decl   -0x1c(%ebp)
  800c23:	89 f0                	mov    %esi,%eax
  800c25:	8d 70 01             	lea    0x1(%eax),%esi
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	0f be d8             	movsbl %al,%ebx
  800c2d:	85 db                	test   %ebx,%ebx
  800c2f:	74 24                	je     800c55 <vprintfmt+0x24b>
  800c31:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c35:	78 b8                	js     800bef <vprintfmt+0x1e5>
  800c37:	ff 4d e0             	decl   -0x20(%ebp)
  800c3a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c3e:	79 af                	jns    800bef <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c40:	eb 13                	jmp    800c55 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c42:	83 ec 08             	sub    $0x8,%esp
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	6a 20                	push   $0x20
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	ff d0                	call   *%eax
  800c4f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c52:	ff 4d e4             	decl   -0x1c(%ebp)
  800c55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c59:	7f e7                	jg     800c42 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c5b:	e9 78 01 00 00       	jmp    800dd8 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 e8             	pushl  -0x18(%ebp)
  800c66:	8d 45 14             	lea    0x14(%ebp),%eax
  800c69:	50                   	push   %eax
  800c6a:	e8 3c fd ff ff       	call   8009ab <getint>
  800c6f:	83 c4 10             	add    $0x10,%esp
  800c72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7e:	85 d2                	test   %edx,%edx
  800c80:	79 23                	jns    800ca5 <vprintfmt+0x29b>
				putch('-', putdat);
  800c82:	83 ec 08             	sub    $0x8,%esp
  800c85:	ff 75 0c             	pushl  0xc(%ebp)
  800c88:	6a 2d                	push   $0x2d
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	ff d0                	call   *%eax
  800c8f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c95:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c98:	f7 d8                	neg    %eax
  800c9a:	83 d2 00             	adc    $0x0,%edx
  800c9d:	f7 da                	neg    %edx
  800c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ca5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cac:	e9 bc 00 00 00       	jmp    800d6d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cb1:	83 ec 08             	sub    $0x8,%esp
  800cb4:	ff 75 e8             	pushl  -0x18(%ebp)
  800cb7:	8d 45 14             	lea    0x14(%ebp),%eax
  800cba:	50                   	push   %eax
  800cbb:	e8 84 fc ff ff       	call   800944 <getuint>
  800cc0:	83 c4 10             	add    $0x10,%esp
  800cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cc9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd0:	e9 98 00 00 00       	jmp    800d6d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cd5:	83 ec 08             	sub    $0x8,%esp
  800cd8:	ff 75 0c             	pushl  0xc(%ebp)
  800cdb:	6a 58                	push   $0x58
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	ff d0                	call   *%eax
  800ce2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ce5:	83 ec 08             	sub    $0x8,%esp
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	6a 58                	push   $0x58
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	ff d0                	call   *%eax
  800cf2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	6a 58                	push   $0x58
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	ff d0                	call   *%eax
  800d02:	83 c4 10             	add    $0x10,%esp
			break;
  800d05:	e9 ce 00 00 00       	jmp    800dd8 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800d0a:	83 ec 08             	sub    $0x8,%esp
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	6a 30                	push   $0x30
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	ff d0                	call   *%eax
  800d17:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d1a:	83 ec 08             	sub    $0x8,%esp
  800d1d:	ff 75 0c             	pushl  0xc(%ebp)
  800d20:	6a 78                	push   $0x78
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	ff d0                	call   *%eax
  800d27:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2d:	83 c0 04             	add    $0x4,%eax
  800d30:	89 45 14             	mov    %eax,0x14(%ebp)
  800d33:	8b 45 14             	mov    0x14(%ebp),%eax
  800d36:	83 e8 04             	sub    $0x4,%eax
  800d39:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d45:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d4c:	eb 1f                	jmp    800d6d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d4e:	83 ec 08             	sub    $0x8,%esp
  800d51:	ff 75 e8             	pushl  -0x18(%ebp)
  800d54:	8d 45 14             	lea    0x14(%ebp),%eax
  800d57:	50                   	push   %eax
  800d58:	e8 e7 fb ff ff       	call   800944 <getuint>
  800d5d:	83 c4 10             	add    $0x10,%esp
  800d60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d63:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d66:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d6d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d71:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d74:	83 ec 04             	sub    $0x4,%esp
  800d77:	52                   	push   %edx
  800d78:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d7b:	50                   	push   %eax
  800d7c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7f:	ff 75 f0             	pushl  -0x10(%ebp)
  800d82:	ff 75 0c             	pushl  0xc(%ebp)
  800d85:	ff 75 08             	pushl  0x8(%ebp)
  800d88:	e8 00 fb ff ff       	call   80088d <printnum>
  800d8d:	83 c4 20             	add    $0x20,%esp
			break;
  800d90:	eb 46                	jmp    800dd8 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d92:	83 ec 08             	sub    $0x8,%esp
  800d95:	ff 75 0c             	pushl  0xc(%ebp)
  800d98:	53                   	push   %ebx
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	ff d0                	call   *%eax
  800d9e:	83 c4 10             	add    $0x10,%esp
			break;
  800da1:	eb 35                	jmp    800dd8 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800da3:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800daa:	eb 2c                	jmp    800dd8 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800dac:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800db3:	eb 23                	jmp    800dd8 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800db5:	83 ec 08             	sub    $0x8,%esp
  800db8:	ff 75 0c             	pushl  0xc(%ebp)
  800dbb:	6a 25                	push   $0x25
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	ff d0                	call   *%eax
  800dc2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800dc5:	ff 4d 10             	decl   0x10(%ebp)
  800dc8:	eb 03                	jmp    800dcd <vprintfmt+0x3c3>
  800dca:	ff 4d 10             	decl   0x10(%ebp)
  800dcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd0:	48                   	dec    %eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	3c 25                	cmp    $0x25,%al
  800dd5:	75 f3                	jne    800dca <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800dd7:	90                   	nop
		}
	}
  800dd8:	e9 35 fc ff ff       	jmp    800a12 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ddd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dde:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800de1:	5b                   	pop    %ebx
  800de2:	5e                   	pop    %esi
  800de3:	5d                   	pop    %ebp
  800de4:	c3                   	ret    

00800de5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800de5:	55                   	push   %ebp
  800de6:	89 e5                	mov    %esp,%ebp
  800de8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800deb:	8d 45 10             	lea    0x10(%ebp),%eax
  800dee:	83 c0 04             	add    $0x4,%eax
  800df1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	ff 75 f4             	pushl  -0xc(%ebp)
  800dfa:	50                   	push   %eax
  800dfb:	ff 75 0c             	pushl  0xc(%ebp)
  800dfe:	ff 75 08             	pushl  0x8(%ebp)
  800e01:	e8 04 fc ff ff       	call   800a0a <vprintfmt>
  800e06:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e09:	90                   	nop
  800e0a:	c9                   	leave  
  800e0b:	c3                   	ret    

00800e0c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e0c:	55                   	push   %ebp
  800e0d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	8b 40 08             	mov    0x8(%eax),%eax
  800e15:	8d 50 01             	lea    0x1(%eax),%edx
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8b 10                	mov    (%eax),%edx
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	8b 40 04             	mov    0x4(%eax),%eax
  800e29:	39 c2                	cmp    %eax,%edx
  800e2b:	73 12                	jae    800e3f <sprintputch+0x33>
		*b->buf++ = ch;
  800e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e30:	8b 00                	mov    (%eax),%eax
  800e32:	8d 48 01             	lea    0x1(%eax),%ecx
  800e35:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e38:	89 0a                	mov    %ecx,(%edx)
  800e3a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e3d:	88 10                	mov    %dl,(%eax)
}
  800e3f:	90                   	nop
  800e40:	5d                   	pop    %ebp
  800e41:	c3                   	ret    

00800e42 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e42:	55                   	push   %ebp
  800e43:	89 e5                	mov    %esp,%ebp
  800e45:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	01 d0                	add    %edx,%eax
  800e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e67:	74 06                	je     800e6f <vsnprintf+0x2d>
  800e69:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e6d:	7f 07                	jg     800e76 <vsnprintf+0x34>
		return -E_INVAL;
  800e6f:	b8 03 00 00 00       	mov    $0x3,%eax
  800e74:	eb 20                	jmp    800e96 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e76:	ff 75 14             	pushl  0x14(%ebp)
  800e79:	ff 75 10             	pushl  0x10(%ebp)
  800e7c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e7f:	50                   	push   %eax
  800e80:	68 0c 0e 80 00       	push   $0x800e0c
  800e85:	e8 80 fb ff ff       	call   800a0a <vprintfmt>
  800e8a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e90:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e96:	c9                   	leave  
  800e97:	c3                   	ret    

00800e98 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e98:	55                   	push   %ebp
  800e99:	89 e5                	mov    %esp,%ebp
  800e9b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e9e:	8d 45 10             	lea    0x10(%ebp),%eax
  800ea1:	83 c0 04             	add    $0x4,%eax
  800ea4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ea7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaa:	ff 75 f4             	pushl  -0xc(%ebp)
  800ead:	50                   	push   %eax
  800eae:	ff 75 0c             	pushl  0xc(%ebp)
  800eb1:	ff 75 08             	pushl  0x8(%ebp)
  800eb4:	e8 89 ff ff ff       	call   800e42 <vsnprintf>
  800eb9:	83 c4 10             	add    $0x10,%esp
  800ebc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ec2:	c9                   	leave  
  800ec3:	c3                   	ret    

00800ec4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ec4:	55                   	push   %ebp
  800ec5:	89 e5                	mov    %esp,%ebp
  800ec7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800eca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed1:	eb 06                	jmp    800ed9 <strlen+0x15>
		n++;
  800ed3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ed6:	ff 45 08             	incl   0x8(%ebp)
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	84 c0                	test   %al,%al
  800ee0:	75 f1                	jne    800ed3 <strlen+0xf>
		n++;
	return n;
  800ee2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee5:	c9                   	leave  
  800ee6:	c3                   	ret    

00800ee7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ee7:	55                   	push   %ebp
  800ee8:	89 e5                	mov    %esp,%ebp
  800eea:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef4:	eb 09                	jmp    800eff <strnlen+0x18>
		n++;
  800ef6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ef9:	ff 45 08             	incl   0x8(%ebp)
  800efc:	ff 4d 0c             	decl   0xc(%ebp)
  800eff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f03:	74 09                	je     800f0e <strnlen+0x27>
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8a 00                	mov    (%eax),%al
  800f0a:	84 c0                	test   %al,%al
  800f0c:	75 e8                	jne    800ef6 <strnlen+0xf>
		n++;
	return n;
  800f0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f11:	c9                   	leave  
  800f12:	c3                   	ret    

00800f13 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f13:	55                   	push   %ebp
  800f14:	89 e5                	mov    %esp,%ebp
  800f16:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f1f:	90                   	nop
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	8d 50 01             	lea    0x1(%eax),%edx
  800f26:	89 55 08             	mov    %edx,0x8(%ebp)
  800f29:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f2f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f32:	8a 12                	mov    (%edx),%dl
  800f34:	88 10                	mov    %dl,(%eax)
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	84 c0                	test   %al,%al
  800f3a:	75 e4                	jne    800f20 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f3f:	c9                   	leave  
  800f40:	c3                   	ret    

00800f41 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
  800f44:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f54:	eb 1f                	jmp    800f75 <strncpy+0x34>
		*dst++ = *src;
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	8d 50 01             	lea    0x1(%eax),%edx
  800f5c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f62:	8a 12                	mov    (%edx),%dl
  800f64:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	84 c0                	test   %al,%al
  800f6d:	74 03                	je     800f72 <strncpy+0x31>
			src++;
  800f6f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f72:	ff 45 fc             	incl   -0x4(%ebp)
  800f75:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f78:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f7b:	72 d9                	jb     800f56 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f80:	c9                   	leave  
  800f81:	c3                   	ret    

00800f82 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f82:	55                   	push   %ebp
  800f83:	89 e5                	mov    %esp,%ebp
  800f85:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f92:	74 30                	je     800fc4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f94:	eb 16                	jmp    800fac <strlcpy+0x2a>
			*dst++ = *src++;
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8d 50 01             	lea    0x1(%eax),%edx
  800f9c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fa8:	8a 12                	mov    (%edx),%dl
  800faa:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fac:	ff 4d 10             	decl   0x10(%ebp)
  800faf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb3:	74 09                	je     800fbe <strlcpy+0x3c>
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	84 c0                	test   %al,%al
  800fbc:	75 d8                	jne    800f96 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fc4:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fca:	29 c2                	sub    %eax,%edx
  800fcc:	89 d0                	mov    %edx,%eax
}
  800fce:	c9                   	leave  
  800fcf:	c3                   	ret    

00800fd0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fd3:	eb 06                	jmp    800fdb <strcmp+0xb>
		p++, q++;
  800fd5:	ff 45 08             	incl   0x8(%ebp)
  800fd8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	8a 00                	mov    (%eax),%al
  800fe0:	84 c0                	test   %al,%al
  800fe2:	74 0e                	je     800ff2 <strcmp+0x22>
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 10                	mov    (%eax),%dl
  800fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fec:	8a 00                	mov    (%eax),%al
  800fee:	38 c2                	cmp    %al,%dl
  800ff0:	74 e3                	je     800fd5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	0f b6 d0             	movzbl %al,%edx
  800ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	0f b6 c0             	movzbl %al,%eax
  801002:	29 c2                	sub    %eax,%edx
  801004:	89 d0                	mov    %edx,%eax
}
  801006:	5d                   	pop    %ebp
  801007:	c3                   	ret    

00801008 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80100b:	eb 09                	jmp    801016 <strncmp+0xe>
		n--, p++, q++;
  80100d:	ff 4d 10             	decl   0x10(%ebp)
  801010:	ff 45 08             	incl   0x8(%ebp)
  801013:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801016:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101a:	74 17                	je     801033 <strncmp+0x2b>
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	8a 00                	mov    (%eax),%al
  801021:	84 c0                	test   %al,%al
  801023:	74 0e                	je     801033 <strncmp+0x2b>
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 10                	mov    (%eax),%dl
  80102a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102d:	8a 00                	mov    (%eax),%al
  80102f:	38 c2                	cmp    %al,%dl
  801031:	74 da                	je     80100d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801033:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801037:	75 07                	jne    801040 <strncmp+0x38>
		return 0;
  801039:	b8 00 00 00 00       	mov    $0x0,%eax
  80103e:	eb 14                	jmp    801054 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	0f b6 d0             	movzbl %al,%edx
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	8a 00                	mov    (%eax),%al
  80104d:	0f b6 c0             	movzbl %al,%eax
  801050:	29 c2                	sub    %eax,%edx
  801052:	89 d0                	mov    %edx,%eax
}
  801054:	5d                   	pop    %ebp
  801055:	c3                   	ret    

00801056 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 04             	sub    $0x4,%esp
  80105c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801062:	eb 12                	jmp    801076 <strchr+0x20>
		if (*s == c)
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80106c:	75 05                	jne    801073 <strchr+0x1d>
			return (char *) s;
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	eb 11                	jmp    801084 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801073:	ff 45 08             	incl   0x8(%ebp)
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	84 c0                	test   %al,%al
  80107d:	75 e5                	jne    801064 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80107f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801084:	c9                   	leave  
  801085:	c3                   	ret    

00801086 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 04             	sub    $0x4,%esp
  80108c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801092:	eb 0d                	jmp    8010a1 <strfind+0x1b>
		if (*s == c)
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	8a 00                	mov    (%eax),%al
  801099:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80109c:	74 0e                	je     8010ac <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80109e:	ff 45 08             	incl   0x8(%ebp)
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	8a 00                	mov    (%eax),%al
  8010a6:	84 c0                	test   %al,%al
  8010a8:	75 ea                	jne    801094 <strfind+0xe>
  8010aa:	eb 01                	jmp    8010ad <strfind+0x27>
		if (*s == c)
			break;
  8010ac:	90                   	nop
	return (char *) s;
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8010be:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010c2:	76 63                	jbe    801127 <memset+0x75>
		uint64 data_block = c;
  8010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c7:	99                   	cltd   
  8010c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8010ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d4:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010d8:	c1 e0 08             	shl    $0x8,%eax
  8010db:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010de:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e7:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010eb:	c1 e0 10             	shl    $0x10,%eax
  8010ee:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010f1:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fa:	89 c2                	mov    %eax,%edx
  8010fc:	b8 00 00 00 00       	mov    $0x0,%eax
  801101:	09 45 f0             	or     %eax,-0x10(%ebp)
  801104:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801107:	eb 18                	jmp    801121 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801109:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80110c:	8d 41 08             	lea    0x8(%ecx),%eax
  80110f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801112:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801115:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801118:	89 01                	mov    %eax,(%ecx)
  80111a:	89 51 04             	mov    %edx,0x4(%ecx)
  80111d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801121:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801125:	77 e2                	ja     801109 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801127:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112b:	74 23                	je     801150 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80112d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801130:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801133:	eb 0e                	jmp    801143 <memset+0x91>
			*p8++ = (uint8)c;
  801135:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801138:	8d 50 01             	lea    0x1(%eax),%edx
  80113b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80113e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801141:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801143:	8b 45 10             	mov    0x10(%ebp),%eax
  801146:	8d 50 ff             	lea    -0x1(%eax),%edx
  801149:	89 55 10             	mov    %edx,0x10(%ebp)
  80114c:	85 c0                	test   %eax,%eax
  80114e:	75 e5                	jne    801135 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801153:	c9                   	leave  
  801154:	c3                   	ret    

00801155 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801155:	55                   	push   %ebp
  801156:	89 e5                	mov    %esp,%ebp
  801158:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80115b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801167:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80116b:	76 24                	jbe    801191 <memcpy+0x3c>
		while(n >= 8){
  80116d:	eb 1c                	jmp    80118b <memcpy+0x36>
			*d64 = *s64;
  80116f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801172:	8b 50 04             	mov    0x4(%eax),%edx
  801175:	8b 00                	mov    (%eax),%eax
  801177:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80117a:	89 01                	mov    %eax,(%ecx)
  80117c:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80117f:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801183:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801187:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80118b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80118f:	77 de                	ja     80116f <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801191:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801195:	74 31                	je     8011c8 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801197:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80119d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8011a3:	eb 16                	jmp    8011bb <memcpy+0x66>
			*d8++ = *s8++;
  8011a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011a8:	8d 50 01             	lea    0x1(%eax),%edx
  8011ab:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8011ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011b1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011b4:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8011b7:	8a 12                	mov    (%edx),%dl
  8011b9:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8011bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011be:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8011c4:	85 c0                	test   %eax,%eax
  8011c6:	75 dd                	jne    8011a5 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011cb:	c9                   	leave  
  8011cc:	c3                   	ret    

008011cd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011cd:	55                   	push   %ebp
  8011ce:	89 e5                	mov    %esp,%ebp
  8011d0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011e5:	73 50                	jae    801237 <memmove+0x6a>
  8011e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	01 d0                	add    %edx,%eax
  8011ef:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011f2:	76 43                	jbe    801237 <memmove+0x6a>
		s += n;
  8011f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801200:	eb 10                	jmp    801212 <memmove+0x45>
			*--d = *--s;
  801202:	ff 4d f8             	decl   -0x8(%ebp)
  801205:	ff 4d fc             	decl   -0x4(%ebp)
  801208:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120b:	8a 10                	mov    (%eax),%dl
  80120d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801210:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801212:	8b 45 10             	mov    0x10(%ebp),%eax
  801215:	8d 50 ff             	lea    -0x1(%eax),%edx
  801218:	89 55 10             	mov    %edx,0x10(%ebp)
  80121b:	85 c0                	test   %eax,%eax
  80121d:	75 e3                	jne    801202 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80121f:	eb 23                	jmp    801244 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801221:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801224:	8d 50 01             	lea    0x1(%eax),%edx
  801227:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80122a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80122d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801230:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801233:	8a 12                	mov    (%edx),%dl
  801235:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801237:	8b 45 10             	mov    0x10(%ebp),%eax
  80123a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80123d:	89 55 10             	mov    %edx,0x10(%ebp)
  801240:	85 c0                	test   %eax,%eax
  801242:	75 dd                	jne    801221 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801247:	c9                   	leave  
  801248:	c3                   	ret    

00801249 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801249:	55                   	push   %ebp
  80124a:	89 e5                	mov    %esp,%ebp
  80124c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801255:	8b 45 0c             	mov    0xc(%ebp),%eax
  801258:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80125b:	eb 2a                	jmp    801287 <memcmp+0x3e>
		if (*s1 != *s2)
  80125d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801260:	8a 10                	mov    (%eax),%dl
  801262:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	38 c2                	cmp    %al,%dl
  801269:	74 16                	je     801281 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80126b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	0f b6 d0             	movzbl %al,%edx
  801273:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801276:	8a 00                	mov    (%eax),%al
  801278:	0f b6 c0             	movzbl %al,%eax
  80127b:	29 c2                	sub    %eax,%edx
  80127d:	89 d0                	mov    %edx,%eax
  80127f:	eb 18                	jmp    801299 <memcmp+0x50>
		s1++, s2++;
  801281:	ff 45 fc             	incl   -0x4(%ebp)
  801284:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128d:	89 55 10             	mov    %edx,0x10(%ebp)
  801290:	85 c0                	test   %eax,%eax
  801292:	75 c9                	jne    80125d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801294:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
  80129e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012a1:	8b 55 08             	mov    0x8(%ebp),%edx
  8012a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a7:	01 d0                	add    %edx,%eax
  8012a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012ac:	eb 15                	jmp    8012c3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	8a 00                	mov    (%eax),%al
  8012b3:	0f b6 d0             	movzbl %al,%edx
  8012b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b9:	0f b6 c0             	movzbl %al,%eax
  8012bc:	39 c2                	cmp    %eax,%edx
  8012be:	74 0d                	je     8012cd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012c0:	ff 45 08             	incl   0x8(%ebp)
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012c9:	72 e3                	jb     8012ae <memfind+0x13>
  8012cb:	eb 01                	jmp    8012ce <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012cd:	90                   	nop
	return (void *) s;
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
  8012d6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012e7:	eb 03                	jmp    8012ec <strtol+0x19>
		s++;
  8012e9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	3c 20                	cmp    $0x20,%al
  8012f3:	74 f4                	je     8012e9 <strtol+0x16>
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	3c 09                	cmp    $0x9,%al
  8012fc:	74 eb                	je     8012e9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	3c 2b                	cmp    $0x2b,%al
  801305:	75 05                	jne    80130c <strtol+0x39>
		s++;
  801307:	ff 45 08             	incl   0x8(%ebp)
  80130a:	eb 13                	jmp    80131f <strtol+0x4c>
	else if (*s == '-')
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	8a 00                	mov    (%eax),%al
  801311:	3c 2d                	cmp    $0x2d,%al
  801313:	75 0a                	jne    80131f <strtol+0x4c>
		s++, neg = 1;
  801315:	ff 45 08             	incl   0x8(%ebp)
  801318:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80131f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801323:	74 06                	je     80132b <strtol+0x58>
  801325:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801329:	75 20                	jne    80134b <strtol+0x78>
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	3c 30                	cmp    $0x30,%al
  801332:	75 17                	jne    80134b <strtol+0x78>
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	40                   	inc    %eax
  801338:	8a 00                	mov    (%eax),%al
  80133a:	3c 78                	cmp    $0x78,%al
  80133c:	75 0d                	jne    80134b <strtol+0x78>
		s += 2, base = 16;
  80133e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801342:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801349:	eb 28                	jmp    801373 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80134b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134f:	75 15                	jne    801366 <strtol+0x93>
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	8a 00                	mov    (%eax),%al
  801356:	3c 30                	cmp    $0x30,%al
  801358:	75 0c                	jne    801366 <strtol+0x93>
		s++, base = 8;
  80135a:	ff 45 08             	incl   0x8(%ebp)
  80135d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801364:	eb 0d                	jmp    801373 <strtol+0xa0>
	else if (base == 0)
  801366:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136a:	75 07                	jne    801373 <strtol+0xa0>
		base = 10;
  80136c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	3c 2f                	cmp    $0x2f,%al
  80137a:	7e 19                	jle    801395 <strtol+0xc2>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	3c 39                	cmp    $0x39,%al
  801383:	7f 10                	jg     801395 <strtol+0xc2>
			dig = *s - '0';
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	0f be c0             	movsbl %al,%eax
  80138d:	83 e8 30             	sub    $0x30,%eax
  801390:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801393:	eb 42                	jmp    8013d7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	3c 60                	cmp    $0x60,%al
  80139c:	7e 19                	jle    8013b7 <strtol+0xe4>
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	3c 7a                	cmp    $0x7a,%al
  8013a5:	7f 10                	jg     8013b7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	0f be c0             	movsbl %al,%eax
  8013af:	83 e8 57             	sub    $0x57,%eax
  8013b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013b5:	eb 20                	jmp    8013d7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	3c 40                	cmp    $0x40,%al
  8013be:	7e 39                	jle    8013f9 <strtol+0x126>
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	3c 5a                	cmp    $0x5a,%al
  8013c7:	7f 30                	jg     8013f9 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	0f be c0             	movsbl %al,%eax
  8013d1:	83 e8 37             	sub    $0x37,%eax
  8013d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013da:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013dd:	7d 19                	jge    8013f8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013df:	ff 45 08             	incl   0x8(%ebp)
  8013e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013e9:	89 c2                	mov    %eax,%edx
  8013eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ee:	01 d0                	add    %edx,%eax
  8013f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013f3:	e9 7b ff ff ff       	jmp    801373 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013f8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013fd:	74 08                	je     801407 <strtol+0x134>
		*endptr = (char *) s;
  8013ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801402:	8b 55 08             	mov    0x8(%ebp),%edx
  801405:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801407:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80140b:	74 07                	je     801414 <strtol+0x141>
  80140d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801410:	f7 d8                	neg    %eax
  801412:	eb 03                	jmp    801417 <strtol+0x144>
  801414:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801417:	c9                   	leave  
  801418:	c3                   	ret    

00801419 <ltostr>:

void
ltostr(long value, char *str)
{
  801419:	55                   	push   %ebp
  80141a:	89 e5                	mov    %esp,%ebp
  80141c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80141f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801426:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80142d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801431:	79 13                	jns    801446 <ltostr+0x2d>
	{
		neg = 1;
  801433:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801440:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801443:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80144e:	99                   	cltd   
  80144f:	f7 f9                	idiv   %ecx
  801451:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801454:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801457:	8d 50 01             	lea    0x1(%eax),%edx
  80145a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145d:	89 c2                	mov    %eax,%edx
  80145f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801462:	01 d0                	add    %edx,%eax
  801464:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801467:	83 c2 30             	add    $0x30,%edx
  80146a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80146c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80146f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801474:	f7 e9                	imul   %ecx
  801476:	c1 fa 02             	sar    $0x2,%edx
  801479:	89 c8                	mov    %ecx,%eax
  80147b:	c1 f8 1f             	sar    $0x1f,%eax
  80147e:	29 c2                	sub    %eax,%edx
  801480:	89 d0                	mov    %edx,%eax
  801482:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801485:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801489:	75 bb                	jne    801446 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80148b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801492:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801495:	48                   	dec    %eax
  801496:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801499:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80149d:	74 3d                	je     8014dc <ltostr+0xc3>
		start = 1 ;
  80149f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014a6:	eb 34                	jmp    8014dc <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8014a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ae:	01 d0                	add    %edx,%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bb:	01 c2                	add    %eax,%edx
  8014bd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	01 c8                	add    %ecx,%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014c9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cf:	01 c2                	add    %eax,%edx
  8014d1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014d4:	88 02                	mov    %al,(%edx)
		start++ ;
  8014d6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014d9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014e2:	7c c4                	jl     8014a8 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ea:	01 d0                	add    %edx,%eax
  8014ec:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014ef:	90                   	nop
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014f8:	ff 75 08             	pushl  0x8(%ebp)
  8014fb:	e8 c4 f9 ff ff       	call   800ec4 <strlen>
  801500:	83 c4 04             	add    $0x4,%esp
  801503:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801506:	ff 75 0c             	pushl  0xc(%ebp)
  801509:	e8 b6 f9 ff ff       	call   800ec4 <strlen>
  80150e:	83 c4 04             	add    $0x4,%esp
  801511:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801514:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80151b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801522:	eb 17                	jmp    80153b <strcconcat+0x49>
		final[s] = str1[s] ;
  801524:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801527:	8b 45 10             	mov    0x10(%ebp),%eax
  80152a:	01 c2                	add    %eax,%edx
  80152c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	01 c8                	add    %ecx,%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801538:	ff 45 fc             	incl   -0x4(%ebp)
  80153b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801541:	7c e1                	jl     801524 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801543:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80154a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801551:	eb 1f                	jmp    801572 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801553:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801556:	8d 50 01             	lea    0x1(%eax),%edx
  801559:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80155c:	89 c2                	mov    %eax,%edx
  80155e:	8b 45 10             	mov    0x10(%ebp),%eax
  801561:	01 c2                	add    %eax,%edx
  801563:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801566:	8b 45 0c             	mov    0xc(%ebp),%eax
  801569:	01 c8                	add    %ecx,%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80156f:	ff 45 f8             	incl   -0x8(%ebp)
  801572:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801575:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801578:	7c d9                	jl     801553 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80157a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157d:	8b 45 10             	mov    0x10(%ebp),%eax
  801580:	01 d0                	add    %edx,%eax
  801582:	c6 00 00             	movb   $0x0,(%eax)
}
  801585:	90                   	nop
  801586:	c9                   	leave  
  801587:	c3                   	ret    

00801588 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80158b:	8b 45 14             	mov    0x14(%ebp),%eax
  80158e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801594:	8b 45 14             	mov    0x14(%ebp),%eax
  801597:	8b 00                	mov    (%eax),%eax
  801599:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a3:	01 d0                	add    %edx,%eax
  8015a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015ab:	eb 0c                	jmp    8015b9 <strsplit+0x31>
			*string++ = 0;
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	8d 50 01             	lea    0x1(%eax),%edx
  8015b3:	89 55 08             	mov    %edx,0x8(%ebp)
  8015b6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	84 c0                	test   %al,%al
  8015c0:	74 18                	je     8015da <strsplit+0x52>
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8a 00                	mov    (%eax),%al
  8015c7:	0f be c0             	movsbl %al,%eax
  8015ca:	50                   	push   %eax
  8015cb:	ff 75 0c             	pushl  0xc(%ebp)
  8015ce:	e8 83 fa ff ff       	call   801056 <strchr>
  8015d3:	83 c4 08             	add    $0x8,%esp
  8015d6:	85 c0                	test   %eax,%eax
  8015d8:	75 d3                	jne    8015ad <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	84 c0                	test   %al,%al
  8015e1:	74 5a                	je     80163d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8015e6:	8b 00                	mov    (%eax),%eax
  8015e8:	83 f8 0f             	cmp    $0xf,%eax
  8015eb:	75 07                	jne    8015f4 <strsplit+0x6c>
		{
			return 0;
  8015ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8015f2:	eb 66                	jmp    80165a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f7:	8b 00                	mov    (%eax),%eax
  8015f9:	8d 48 01             	lea    0x1(%eax),%ecx
  8015fc:	8b 55 14             	mov    0x14(%ebp),%edx
  8015ff:	89 0a                	mov    %ecx,(%edx)
  801601:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801608:	8b 45 10             	mov    0x10(%ebp),%eax
  80160b:	01 c2                	add    %eax,%edx
  80160d:	8b 45 08             	mov    0x8(%ebp),%eax
  801610:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801612:	eb 03                	jmp    801617 <strsplit+0x8f>
			string++;
  801614:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8a 00                	mov    (%eax),%al
  80161c:	84 c0                	test   %al,%al
  80161e:	74 8b                	je     8015ab <strsplit+0x23>
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	0f be c0             	movsbl %al,%eax
  801628:	50                   	push   %eax
  801629:	ff 75 0c             	pushl  0xc(%ebp)
  80162c:	e8 25 fa ff ff       	call   801056 <strchr>
  801631:	83 c4 08             	add    $0x8,%esp
  801634:	85 c0                	test   %eax,%eax
  801636:	74 dc                	je     801614 <strsplit+0x8c>
			string++;
	}
  801638:	e9 6e ff ff ff       	jmp    8015ab <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80163d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80163e:	8b 45 14             	mov    0x14(%ebp),%eax
  801641:	8b 00                	mov    (%eax),%eax
  801643:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80164a:	8b 45 10             	mov    0x10(%ebp),%eax
  80164d:	01 d0                	add    %edx,%eax
  80164f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801655:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801668:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80166f:	eb 4a                	jmp    8016bb <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801671:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	01 c2                	add    %eax,%edx
  801679:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80167c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167f:	01 c8                	add    %ecx,%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801685:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801688:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168b:	01 d0                	add    %edx,%eax
  80168d:	8a 00                	mov    (%eax),%al
  80168f:	3c 40                	cmp    $0x40,%al
  801691:	7e 25                	jle    8016b8 <str2lower+0x5c>
  801693:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801696:	8b 45 0c             	mov    0xc(%ebp),%eax
  801699:	01 d0                	add    %edx,%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	3c 5a                	cmp    $0x5a,%al
  80169f:	7f 17                	jg     8016b8 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8016a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	01 d0                	add    %edx,%eax
  8016a9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8016af:	01 ca                	add    %ecx,%edx
  8016b1:	8a 12                	mov    (%edx),%dl
  8016b3:	83 c2 20             	add    $0x20,%edx
  8016b6:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8016b8:	ff 45 fc             	incl   -0x4(%ebp)
  8016bb:	ff 75 0c             	pushl  0xc(%ebp)
  8016be:	e8 01 f8 ff ff       	call   800ec4 <strlen>
  8016c3:	83 c4 04             	add    $0x4,%esp
  8016c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016c9:	7f a6                	jg     801671 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8016cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8016d6:	a1 08 30 80 00       	mov    0x803008,%eax
  8016db:	85 c0                	test   %eax,%eax
  8016dd:	74 2d                	je     80170c <uheap_init+0x3c>
	{
		buddy_init();
  8016df:	e8 87 06 00 00       	call   801d6b <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8016e4:	e8 31 05 00 00       	call   801c1a <sys_get_uheap_strategy>
  8016e9:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  8016ee:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8016f5:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8016f8:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8016ff:	00 00 80 
		__firstTimeFlag = 0;
  801702:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801709:	00 00 00 
	}
}
  80170c:	90                   	nop
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801715:	83 ec 04             	sub    $0x4,%esp
  801718:	68 88 29 80 00       	push   $0x802988
  80171d:	6a 25                	push   $0x25
  80171f:	68 b9 29 80 00       	push   $0x8029b9
  801724:	e8 f4 ed ff ff       	call   80051d <_panic>

00801729 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
  80172c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  80172f:	83 ec 04             	sub    $0x4,%esp
  801732:	68 c8 29 80 00       	push   $0x8029c8
  801737:	6a 2f                	push   $0x2f
  801739:	68 b9 29 80 00       	push   $0x8029b9
  80173e:	e8 da ed ff ff       	call   80051d <_panic>

00801743 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
  801746:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801749:	e8 82 ff ff ff       	call   8016d0 <uheap_init>
	if (size == 0) return NULL ;
  80174e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801752:	75 07                	jne    80175b <malloc+0x18>
  801754:	b8 00 00 00 00       	mov    $0x0,%eax
  801759:	eb 14                	jmp    80176f <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	68 fc 29 80 00       	push   $0x8029fc
  801763:	6a 43                	push   $0x43
  801765:	68 b9 29 80 00       	push   $0x8029b9
  80176a:	e8 ae ed ff ff       	call   80051d <_panic>
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801777:	83 ec 04             	sub    $0x4,%esp
  80177a:	68 24 2a 80 00       	push   $0x802a24
  80177f:	6a 4e                	push   $0x4e
  801781:	68 b9 29 80 00       	push   $0x8029b9
  801786:	e8 92 ed ff ff       	call   80051d <_panic>

0080178b <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80178b:	55                   	push   %ebp
  80178c:	89 e5                	mov    %esp,%ebp
  80178e:	83 ec 18             	sub    $0x18,%esp
  801791:	8b 45 10             	mov    0x10(%ebp),%eax
  801794:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801797:	e8 34 ff ff ff       	call   8016d0 <uheap_init>
	if (size == 0) return NULL ;
  80179c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017a0:	75 07                	jne    8017a9 <smalloc+0x1e>
  8017a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8017a7:	eb 14                	jmp    8017bd <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  8017a9:	83 ec 04             	sub    $0x4,%esp
  8017ac:	68 48 2a 80 00       	push   $0x802a48
  8017b1:	6a 5f                	push   $0x5f
  8017b3:	68 b9 29 80 00       	push   $0x8029b9
  8017b8:	e8 60 ed ff ff       	call   80051d <_panic>
}
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
  8017c2:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8017c5:	e8 06 ff ff ff       	call   8016d0 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  8017ca:	83 ec 04             	sub    $0x4,%esp
  8017cd:	68 70 2a 80 00       	push   $0x802a70
  8017d2:	6a 6f                	push   $0x6f
  8017d4:	68 b9 29 80 00       	push   $0x8029b9
  8017d9:	e8 3f ed ff ff       	call   80051d <_panic>

008017de <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
  8017e1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8017e4:	83 ec 04             	sub    $0x4,%esp
  8017e7:	68 94 2a 80 00       	push   $0x802a94
  8017ec:	6a 7e                	push   $0x7e
  8017ee:	68 b9 29 80 00       	push   $0x8029b9
  8017f3:	e8 25 ed ff ff       	call   80051d <_panic>

008017f8 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
  8017fb:	57                   	push   %edi
  8017fc:	56                   	push   %esi
  8017fd:	53                   	push   %ebx
  8017fe:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	8b 55 0c             	mov    0xc(%ebp),%edx
  801807:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80180a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80180d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801810:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801813:	cd 30                	int    $0x30
  801815:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801818:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80181b:	83 c4 10             	add    $0x10,%esp
  80181e:	5b                   	pop    %ebx
  80181f:	5e                   	pop    %esi
  801820:	5f                   	pop    %edi
  801821:	5d                   	pop    %ebp
  801822:	c3                   	ret    

00801823 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
  801826:	83 ec 04             	sub    $0x4,%esp
  801829:	8b 45 10             	mov    0x10(%ebp),%eax
  80182c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80182f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801832:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	6a 00                	push   $0x0
  80183b:	51                   	push   %ecx
  80183c:	52                   	push   %edx
  80183d:	ff 75 0c             	pushl  0xc(%ebp)
  801840:	50                   	push   %eax
  801841:	6a 00                	push   $0x0
  801843:	e8 b0 ff ff ff       	call   8017f8 <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
}
  80184b:	90                   	nop
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <sys_cgetc>:

int
sys_cgetc(void)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 02                	push   $0x2
  80185d:	e8 96 ff ff ff       	call   8017f8 <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 03                	push   $0x3
  801876:	e8 7d ff ff ff       	call   8017f8 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
}
  80187e:	90                   	nop
  80187f:	c9                   	leave  
  801880:	c3                   	ret    

00801881 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801881:	55                   	push   %ebp
  801882:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 04                	push   $0x4
  801890:	e8 63 ff ff ff       	call   8017f8 <syscall>
  801895:	83 c4 18             	add    $0x18,%esp
}
  801898:	90                   	nop
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80189e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	52                   	push   %edx
  8018ab:	50                   	push   %eax
  8018ac:	6a 08                	push   $0x8
  8018ae:	e8 45 ff ff ff       	call   8017f8 <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
  8018bb:	56                   	push   %esi
  8018bc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018bd:	8b 75 18             	mov    0x18(%ebp),%esi
  8018c0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	56                   	push   %esi
  8018cd:	53                   	push   %ebx
  8018ce:	51                   	push   %ecx
  8018cf:	52                   	push   %edx
  8018d0:	50                   	push   %eax
  8018d1:	6a 09                	push   $0x9
  8018d3:	e8 20 ff ff ff       	call   8017f8 <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018de:	5b                   	pop    %ebx
  8018df:	5e                   	pop    %esi
  8018e0:	5d                   	pop    %ebp
  8018e1:	c3                   	ret    

008018e2 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	ff 75 08             	pushl  0x8(%ebp)
  8018f0:	6a 0a                	push   $0xa
  8018f2:	e8 01 ff ff ff       	call   8017f8 <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
}
  8018fa:	c9                   	leave  
  8018fb:	c3                   	ret    

008018fc <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018fc:	55                   	push   %ebp
  8018fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	ff 75 0c             	pushl  0xc(%ebp)
  801908:	ff 75 08             	pushl  0x8(%ebp)
  80190b:	6a 0b                	push   $0xb
  80190d:	e8 e6 fe ff ff       	call   8017f8 <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
}
  801915:	c9                   	leave  
  801916:	c3                   	ret    

00801917 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 0c                	push   $0xc
  801926:	e8 cd fe ff ff       	call   8017f8 <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
}
  80192e:	c9                   	leave  
  80192f:	c3                   	ret    

00801930 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801930:	55                   	push   %ebp
  801931:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 0d                	push   $0xd
  80193f:	e8 b4 fe ff ff       	call   8017f8 <syscall>
  801944:	83 c4 18             	add    $0x18,%esp
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 0e                	push   $0xe
  801958:	e8 9b fe ff ff       	call   8017f8 <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
}
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 0f                	push   $0xf
  801971:	e8 82 fe ff ff       	call   8017f8 <syscall>
  801976:	83 c4 18             	add    $0x18,%esp
}
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	ff 75 08             	pushl  0x8(%ebp)
  801989:	6a 10                	push   $0x10
  80198b:	e8 68 fe ff ff       	call   8017f8 <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 11                	push   $0x11
  8019a4:	e8 4f fe ff ff       	call   8017f8 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
}
  8019ac:	90                   	nop
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_cputc>:

void
sys_cputc(const char c)
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
  8019b2:	83 ec 04             	sub    $0x4,%esp
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019bb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	50                   	push   %eax
  8019c8:	6a 01                	push   $0x1
  8019ca:	e8 29 fe ff ff       	call   8017f8 <syscall>
  8019cf:	83 c4 18             	add    $0x18,%esp
}
  8019d2:	90                   	nop
  8019d3:	c9                   	leave  
  8019d4:	c3                   	ret    

008019d5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 14                	push   $0x14
  8019e4:	e8 0f fe ff ff       	call   8017f8 <syscall>
  8019e9:	83 c4 18             	add    $0x18,%esp
}
  8019ec:	90                   	nop
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
  8019f2:	83 ec 04             	sub    $0x4,%esp
  8019f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8019fb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019fe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	6a 00                	push   $0x0
  801a07:	51                   	push   %ecx
  801a08:	52                   	push   %edx
  801a09:	ff 75 0c             	pushl  0xc(%ebp)
  801a0c:	50                   	push   %eax
  801a0d:	6a 15                	push   $0x15
  801a0f:	e8 e4 fd ff ff       	call   8017f8 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801a1c:	8b 55 10             	mov    0x10(%ebp),%edx
  801a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	52                   	push   %edx
  801a27:	50                   	push   %eax
  801a28:	ff 75 08             	pushl  0x8(%ebp)
  801a2b:	6a 16                	push   $0x16
  801a2d:	e8 c6 fd ff ff       	call   8017f8 <syscall>
  801a32:	83 c4 18             	add    $0x18,%esp
}
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801a3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	52                   	push   %edx
  801a47:	50                   	push   %eax
  801a48:	6a 17                	push   $0x17
  801a4a:	e8 a9 fd ff ff       	call   8017f8 <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
}
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	52                   	push   %edx
  801a64:	50                   	push   %eax
  801a65:	6a 18                	push   $0x18
  801a67:	e8 8c fd ff ff       	call   8017f8 <syscall>
  801a6c:	83 c4 18             	add    $0x18,%esp
}
  801a6f:	c9                   	leave  
  801a70:	c3                   	ret    

00801a71 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801a71:	55                   	push   %ebp
  801a72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	6a 00                	push   $0x0
  801a79:	ff 75 14             	pushl  0x14(%ebp)
  801a7c:	ff 75 10             	pushl  0x10(%ebp)
  801a7f:	ff 75 0c             	pushl  0xc(%ebp)
  801a82:	50                   	push   %eax
  801a83:	6a 19                	push   $0x19
  801a85:	e8 6e fd ff ff       	call   8017f8 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_run_env>:

void sys_run_env(int32 envId)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a92:	8b 45 08             	mov    0x8(%ebp),%eax
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	50                   	push   %eax
  801a9e:	6a 1a                	push   $0x1a
  801aa0:	e8 53 fd ff ff       	call   8017f8 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	90                   	nop
  801aa9:	c9                   	leave  
  801aaa:	c3                   	ret    

00801aab <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801aab:	55                   	push   %ebp
  801aac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801aae:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	50                   	push   %eax
  801aba:	6a 1b                	push   $0x1b
  801abc:	e8 37 fd ff ff       	call   8017f8 <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 05                	push   $0x5
  801ad5:	e8 1e fd ff ff       	call   8017f8 <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
}
  801add:	c9                   	leave  
  801ade:	c3                   	ret    

00801adf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801adf:	55                   	push   %ebp
  801ae0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 06                	push   $0x6
  801aee:	e8 05 fd ff ff       	call   8017f8 <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
}
  801af6:	c9                   	leave  
  801af7:	c3                   	ret    

00801af8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 07                	push   $0x7
  801b07:	e8 ec fc ff ff       	call   8017f8 <syscall>
  801b0c:	83 c4 18             	add    $0x18,%esp
}
  801b0f:	c9                   	leave  
  801b10:	c3                   	ret    

00801b11 <sys_exit_env>:


void sys_exit_env(void)
{
  801b11:	55                   	push   %ebp
  801b12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 1c                	push   $0x1c
  801b20:	e8 d3 fc ff ff       	call   8017f8 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	90                   	nop
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	ff 75 10             	pushl  0x10(%ebp)
  801b35:	ff 75 0c             	pushl  0xc(%ebp)
  801b38:	ff 75 08             	pushl  0x8(%ebp)
  801b3b:	6a 13                	push   $0x13
  801b3d:	e8 b6 fc ff ff       	call   8017f8 <syscall>
  801b42:	83 c4 18             	add    $0x18,%esp
	return ;
  801b45:	90                   	nop
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 1e                	push   $0x1e
  801b57:	e8 9c fc ff ff       	call   8017f8 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
  801b64:	83 ec 04             	sub    $0x4,%esp
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b6d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	50                   	push   %eax
  801b7a:	6a 1f                	push   $0x1f
  801b7c:	e8 77 fc ff ff       	call   8017f8 <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
	return ;
  801b84:	90                   	nop
}
  801b85:	c9                   	leave  
  801b86:	c3                   	ret    

00801b87 <rsttst>:
void rsttst()
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 21                	push   $0x21
  801b96:	e8 5d fc ff ff       	call   8017f8 <syscall>
  801b9b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9e:	90                   	nop
}
  801b9f:	c9                   	leave  
  801ba0:	c3                   	ret    

00801ba1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ba1:	55                   	push   %ebp
  801ba2:	89 e5                	mov    %esp,%ebp
  801ba4:	83 ec 04             	sub    $0x4,%esp
  801ba7:	8b 45 14             	mov    0x14(%ebp),%eax
  801baa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bad:	8b 55 18             	mov    0x18(%ebp),%edx
  801bb0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bb4:	52                   	push   %edx
  801bb5:	50                   	push   %eax
  801bb6:	ff 75 10             	pushl  0x10(%ebp)
  801bb9:	ff 75 0c             	pushl  0xc(%ebp)
  801bbc:	ff 75 08             	pushl  0x8(%ebp)
  801bbf:	6a 20                	push   $0x20
  801bc1:	e8 32 fc ff ff       	call   8017f8 <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc9:	90                   	nop
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <chktst>:
void chktst(uint32 n)
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	ff 75 08             	pushl  0x8(%ebp)
  801bda:	6a 22                	push   $0x22
  801bdc:	e8 17 fc ff ff       	call   8017f8 <syscall>
  801be1:	83 c4 18             	add    $0x18,%esp
	return ;
  801be4:	90                   	nop
}
  801be5:	c9                   	leave  
  801be6:	c3                   	ret    

00801be7 <inctst>:

void inctst()
{
  801be7:	55                   	push   %ebp
  801be8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 23                	push   $0x23
  801bf6:	e8 fd fb ff ff       	call   8017f8 <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfe:	90                   	nop
}
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <gettst>:
uint32 gettst()
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 24                	push   $0x24
  801c10:	e8 e3 fb ff ff       	call   8017f8 <syscall>
  801c15:	83 c4 18             	add    $0x18,%esp
}
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 25                	push   $0x25
  801c29:	e8 ca fb ff ff       	call   8017f8 <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
  801c31:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801c36:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	ff 75 08             	pushl  0x8(%ebp)
  801c53:	6a 26                	push   $0x26
  801c55:	e8 9e fb ff ff       	call   8017f8 <syscall>
  801c5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5d:	90                   	nop
}
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
  801c63:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c64:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c67:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c70:	6a 00                	push   $0x0
  801c72:	53                   	push   %ebx
  801c73:	51                   	push   %ecx
  801c74:	52                   	push   %edx
  801c75:	50                   	push   %eax
  801c76:	6a 27                	push   $0x27
  801c78:	e8 7b fb ff ff       	call   8017f8 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	52                   	push   %edx
  801c95:	50                   	push   %eax
  801c96:	6a 28                	push   $0x28
  801c98:	e8 5b fb ff ff       	call   8017f8 <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801ca5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ca8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cab:	8b 45 08             	mov    0x8(%ebp),%eax
  801cae:	6a 00                	push   $0x0
  801cb0:	51                   	push   %ecx
  801cb1:	ff 75 10             	pushl  0x10(%ebp)
  801cb4:	52                   	push   %edx
  801cb5:	50                   	push   %eax
  801cb6:	6a 29                	push   $0x29
  801cb8:	e8 3b fb ff ff       	call   8017f8 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	ff 75 10             	pushl  0x10(%ebp)
  801ccc:	ff 75 0c             	pushl  0xc(%ebp)
  801ccf:	ff 75 08             	pushl  0x8(%ebp)
  801cd2:	6a 12                	push   $0x12
  801cd4:	e8 1f fb ff ff       	call   8017f8 <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
	return ;
  801cdc:	90                   	nop
}
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801ce2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	52                   	push   %edx
  801cef:	50                   	push   %eax
  801cf0:	6a 2a                	push   $0x2a
  801cf2:	e8 01 fb ff ff       	call   8017f8 <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
	return;
  801cfa:	90                   	nop
}
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 2b                	push   $0x2b
  801d0c:	e8 e7 fa ff ff       	call   8017f8 <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
  801d19:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801d1c:	83 ec 04             	sub    $0x4,%esp
  801d1f:	68 b8 2a 80 00       	push   $0x802ab8
  801d24:	68 0a 01 00 00       	push   $0x10a
  801d29:	68 c8 2a 80 00       	push   $0x802ac8
  801d2e:	e8 ea e7 ff ff       	call   80051d <_panic>

00801d33 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	ff 75 0c             	pushl  0xc(%ebp)
  801d3f:	ff 75 08             	pushl  0x8(%ebp)
  801d42:	6a 33                	push   $0x33
  801d44:	e8 af fa ff ff       	call   8017f8 <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
	return;
  801d4c:	90                   	nop
}
  801d4d:	c9                   	leave  
  801d4e:	c3                   	ret    

00801d4f <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801d4f:	55                   	push   %ebp
  801d50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	ff 75 0c             	pushl  0xc(%ebp)
  801d5b:	ff 75 08             	pushl  0x8(%ebp)
  801d5e:	6a 34                	push   $0x34
  801d60:	e8 93 fa ff ff       	call   8017f8 <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
	return ;
  801d68:	90                   	nop
}
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
  801d6e:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801d71:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801d78:	eb 36                	jmp    801db0 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801d7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d7d:	c1 e0 04             	shl    $0x4,%eax
  801d80:	05 60 30 80 00       	add    $0x803060,%eax
  801d85:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d8e:	c1 e0 04             	shl    $0x4,%eax
  801d91:	05 64 30 80 00       	add    $0x803064,%eax
  801d96:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801d9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d9f:	c1 e0 04             	shl    $0x4,%eax
  801da2:	05 6c 30 80 00       	add    $0x80306c,%eax
  801da7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801dad:	ff 45 fc             	incl   -0x4(%ebp)
  801db0:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801db4:	7e c4                	jle    801d7a <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801db6:	90                   	nop
  801db7:	c9                   	leave  
  801db8:	c3                   	ret    

00801db9 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801db9:	55                   	push   %ebp
  801dba:	89 e5                	mov    %esp,%ebp
  801dbc:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801dbf:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801dc6:	eb 24                	jmp    801dec <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dcb:	c1 e0 04             	shl    $0x4,%eax
  801dce:	05 6c 30 80 00       	add    $0x80306c,%eax
  801dd3:	8b 00                	mov    (%eax),%eax
  801dd5:	83 ec 04             	sub    $0x4,%esp
  801dd8:	50                   	push   %eax
  801dd9:	ff 75 f4             	pushl  -0xc(%ebp)
  801ddc:	68 d8 2a 80 00       	push   $0x802ad8
  801de1:	e8 05 ea ff ff       	call   8007eb <cprintf>
  801de6:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801de9:	ff 45 f4             	incl   -0xc(%ebp)
  801dec:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801df0:	7e d6                	jle    801dc8 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801df2:	90                   	nop
  801df3:	c9                   	leave  
  801df4:	c3                   	ret    

00801df5 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801df5:	55                   	push   %ebp
  801df6:	89 e5                	mov    %esp,%ebp
  801df8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801dfb:	83 ec 04             	sub    $0x4,%esp
  801dfe:	68 e8 2a 80 00       	push   $0x802ae8
  801e03:	6a 33                	push   $0x33
  801e05:	68 09 2b 80 00       	push   $0x802b09
  801e0a:	e8 0e e7 ff ff       	call   80051d <_panic>

00801e0f <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
  801e12:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801e15:	83 ec 04             	sub    $0x4,%esp
  801e18:	68 21 2b 80 00       	push   $0x802b21
  801e1d:	6a 3e                	push   $0x3e
  801e1f:	68 09 2b 80 00       	push   $0x802b09
  801e24:	e8 f4 e6 ff ff       	call   80051d <_panic>

00801e29 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
  801e2c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801e2f:	83 ec 04             	sub    $0x4,%esp
  801e32:	68 3f 2b 80 00       	push   $0x802b3f
  801e37:	6a 49                	push   $0x49
  801e39:	68 09 2b 80 00       	push   $0x802b09
  801e3e:	e8 da e6 ff ff       	call   80051d <_panic>

00801e43 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
  801e46:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801e49:	83 ec 04             	sub    $0x4,%esp
  801e4c:	68 5c 2b 80 00       	push   $0x802b5c
  801e51:	6a 58                	push   $0x58
  801e53:	68 09 2b 80 00       	push   $0x802b09
  801e58:	e8 c0 e6 ff ff       	call   80051d <_panic>

00801e5d <create_semaphore>:
// User-level Semaphore

#include "inc/lib.h"

struct semaphore create_semaphore(char *semaphoreName, uint32 value)
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
  801e60:	83 ec 08             	sub    $0x8,%esp
	panic("create_semaphore() is not implemented yet...!!");
  801e63:	83 ec 04             	sub    $0x4,%esp
  801e66:	68 80 2b 80 00       	push   $0x802b80
  801e6b:	6a 07                	push   $0x7
  801e6d:	68 af 2b 80 00       	push   $0x802baf
  801e72:	e8 a6 e6 ff ff       	call   80051d <_panic>

00801e77 <get_semaphore>:
}
struct semaphore get_semaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
  801e7a:	83 ec 08             	sub    $0x8,%esp
	panic("get_semaphore() is not implemented yet...!!");
  801e7d:	83 ec 04             	sub    $0x4,%esp
  801e80:	68 c0 2b 80 00       	push   $0x802bc0
  801e85:	6a 0b                	push   $0xb
  801e87:	68 af 2b 80 00       	push   $0x802baf
  801e8c:	e8 8c e6 ff ff       	call   80051d <_panic>

00801e91 <wait_semaphore>:
}

void wait_semaphore(struct semaphore sem)
{
  801e91:	55                   	push   %ebp
  801e92:	89 e5                	mov    %esp,%ebp
  801e94:	83 ec 08             	sub    $0x8,%esp
	panic("wait_semaphore() is not implemented yet...!!");
  801e97:	83 ec 04             	sub    $0x4,%esp
  801e9a:	68 ec 2b 80 00       	push   $0x802bec
  801e9f:	6a 10                	push   $0x10
  801ea1:	68 af 2b 80 00       	push   $0x802baf
  801ea6:	e8 72 e6 ff ff       	call   80051d <_panic>

00801eab <signal_semaphore>:
}

void signal_semaphore(struct semaphore sem)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 08             	sub    $0x8,%esp
	panic("signal_semaphore() is not implemented yet...!!");
  801eb1:	83 ec 04             	sub    $0x4,%esp
  801eb4:	68 1c 2c 80 00       	push   $0x802c1c
  801eb9:	6a 15                	push   $0x15
  801ebb:	68 af 2b 80 00       	push   $0x802baf
  801ec0:	e8 58 e6 ff ff       	call   80051d <_panic>

00801ec5 <semaphore_count>:
}

int semaphore_count(struct semaphore sem)
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
	return sem.semdata->count;
  801ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecb:	8b 40 10             	mov    0x10(%eax),%eax
}
  801ece:	5d                   	pop    %ebp
  801ecf:	c3                   	ret    

00801ed0 <__udivdi3>:
  801ed0:	55                   	push   %ebp
  801ed1:	57                   	push   %edi
  801ed2:	56                   	push   %esi
  801ed3:	53                   	push   %ebx
  801ed4:	83 ec 1c             	sub    $0x1c,%esp
  801ed7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801edb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801edf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ee3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ee7:	89 ca                	mov    %ecx,%edx
  801ee9:	89 f8                	mov    %edi,%eax
  801eeb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801eef:	85 f6                	test   %esi,%esi
  801ef1:	75 2d                	jne    801f20 <__udivdi3+0x50>
  801ef3:	39 cf                	cmp    %ecx,%edi
  801ef5:	77 65                	ja     801f5c <__udivdi3+0x8c>
  801ef7:	89 fd                	mov    %edi,%ebp
  801ef9:	85 ff                	test   %edi,%edi
  801efb:	75 0b                	jne    801f08 <__udivdi3+0x38>
  801efd:	b8 01 00 00 00       	mov    $0x1,%eax
  801f02:	31 d2                	xor    %edx,%edx
  801f04:	f7 f7                	div    %edi
  801f06:	89 c5                	mov    %eax,%ebp
  801f08:	31 d2                	xor    %edx,%edx
  801f0a:	89 c8                	mov    %ecx,%eax
  801f0c:	f7 f5                	div    %ebp
  801f0e:	89 c1                	mov    %eax,%ecx
  801f10:	89 d8                	mov    %ebx,%eax
  801f12:	f7 f5                	div    %ebp
  801f14:	89 cf                	mov    %ecx,%edi
  801f16:	89 fa                	mov    %edi,%edx
  801f18:	83 c4 1c             	add    $0x1c,%esp
  801f1b:	5b                   	pop    %ebx
  801f1c:	5e                   	pop    %esi
  801f1d:	5f                   	pop    %edi
  801f1e:	5d                   	pop    %ebp
  801f1f:	c3                   	ret    
  801f20:	39 ce                	cmp    %ecx,%esi
  801f22:	77 28                	ja     801f4c <__udivdi3+0x7c>
  801f24:	0f bd fe             	bsr    %esi,%edi
  801f27:	83 f7 1f             	xor    $0x1f,%edi
  801f2a:	75 40                	jne    801f6c <__udivdi3+0x9c>
  801f2c:	39 ce                	cmp    %ecx,%esi
  801f2e:	72 0a                	jb     801f3a <__udivdi3+0x6a>
  801f30:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f34:	0f 87 9e 00 00 00    	ja     801fd8 <__udivdi3+0x108>
  801f3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3f:	89 fa                	mov    %edi,%edx
  801f41:	83 c4 1c             	add    $0x1c,%esp
  801f44:	5b                   	pop    %ebx
  801f45:	5e                   	pop    %esi
  801f46:	5f                   	pop    %edi
  801f47:	5d                   	pop    %ebp
  801f48:	c3                   	ret    
  801f49:	8d 76 00             	lea    0x0(%esi),%esi
  801f4c:	31 ff                	xor    %edi,%edi
  801f4e:	31 c0                	xor    %eax,%eax
  801f50:	89 fa                	mov    %edi,%edx
  801f52:	83 c4 1c             	add    $0x1c,%esp
  801f55:	5b                   	pop    %ebx
  801f56:	5e                   	pop    %esi
  801f57:	5f                   	pop    %edi
  801f58:	5d                   	pop    %ebp
  801f59:	c3                   	ret    
  801f5a:	66 90                	xchg   %ax,%ax
  801f5c:	89 d8                	mov    %ebx,%eax
  801f5e:	f7 f7                	div    %edi
  801f60:	31 ff                	xor    %edi,%edi
  801f62:	89 fa                	mov    %edi,%edx
  801f64:	83 c4 1c             	add    $0x1c,%esp
  801f67:	5b                   	pop    %ebx
  801f68:	5e                   	pop    %esi
  801f69:	5f                   	pop    %edi
  801f6a:	5d                   	pop    %ebp
  801f6b:	c3                   	ret    
  801f6c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f71:	89 eb                	mov    %ebp,%ebx
  801f73:	29 fb                	sub    %edi,%ebx
  801f75:	89 f9                	mov    %edi,%ecx
  801f77:	d3 e6                	shl    %cl,%esi
  801f79:	89 c5                	mov    %eax,%ebp
  801f7b:	88 d9                	mov    %bl,%cl
  801f7d:	d3 ed                	shr    %cl,%ebp
  801f7f:	89 e9                	mov    %ebp,%ecx
  801f81:	09 f1                	or     %esi,%ecx
  801f83:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f87:	89 f9                	mov    %edi,%ecx
  801f89:	d3 e0                	shl    %cl,%eax
  801f8b:	89 c5                	mov    %eax,%ebp
  801f8d:	89 d6                	mov    %edx,%esi
  801f8f:	88 d9                	mov    %bl,%cl
  801f91:	d3 ee                	shr    %cl,%esi
  801f93:	89 f9                	mov    %edi,%ecx
  801f95:	d3 e2                	shl    %cl,%edx
  801f97:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f9b:	88 d9                	mov    %bl,%cl
  801f9d:	d3 e8                	shr    %cl,%eax
  801f9f:	09 c2                	or     %eax,%edx
  801fa1:	89 d0                	mov    %edx,%eax
  801fa3:	89 f2                	mov    %esi,%edx
  801fa5:	f7 74 24 0c          	divl   0xc(%esp)
  801fa9:	89 d6                	mov    %edx,%esi
  801fab:	89 c3                	mov    %eax,%ebx
  801fad:	f7 e5                	mul    %ebp
  801faf:	39 d6                	cmp    %edx,%esi
  801fb1:	72 19                	jb     801fcc <__udivdi3+0xfc>
  801fb3:	74 0b                	je     801fc0 <__udivdi3+0xf0>
  801fb5:	89 d8                	mov    %ebx,%eax
  801fb7:	31 ff                	xor    %edi,%edi
  801fb9:	e9 58 ff ff ff       	jmp    801f16 <__udivdi3+0x46>
  801fbe:	66 90                	xchg   %ax,%ax
  801fc0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fc4:	89 f9                	mov    %edi,%ecx
  801fc6:	d3 e2                	shl    %cl,%edx
  801fc8:	39 c2                	cmp    %eax,%edx
  801fca:	73 e9                	jae    801fb5 <__udivdi3+0xe5>
  801fcc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fcf:	31 ff                	xor    %edi,%edi
  801fd1:	e9 40 ff ff ff       	jmp    801f16 <__udivdi3+0x46>
  801fd6:	66 90                	xchg   %ax,%ax
  801fd8:	31 c0                	xor    %eax,%eax
  801fda:	e9 37 ff ff ff       	jmp    801f16 <__udivdi3+0x46>
  801fdf:	90                   	nop

00801fe0 <__umoddi3>:
  801fe0:	55                   	push   %ebp
  801fe1:	57                   	push   %edi
  801fe2:	56                   	push   %esi
  801fe3:	53                   	push   %ebx
  801fe4:	83 ec 1c             	sub    $0x1c,%esp
  801fe7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801feb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ff3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ff7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ffb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fff:	89 f3                	mov    %esi,%ebx
  802001:	89 fa                	mov    %edi,%edx
  802003:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802007:	89 34 24             	mov    %esi,(%esp)
  80200a:	85 c0                	test   %eax,%eax
  80200c:	75 1a                	jne    802028 <__umoddi3+0x48>
  80200e:	39 f7                	cmp    %esi,%edi
  802010:	0f 86 a2 00 00 00    	jbe    8020b8 <__umoddi3+0xd8>
  802016:	89 c8                	mov    %ecx,%eax
  802018:	89 f2                	mov    %esi,%edx
  80201a:	f7 f7                	div    %edi
  80201c:	89 d0                	mov    %edx,%eax
  80201e:	31 d2                	xor    %edx,%edx
  802020:	83 c4 1c             	add    $0x1c,%esp
  802023:	5b                   	pop    %ebx
  802024:	5e                   	pop    %esi
  802025:	5f                   	pop    %edi
  802026:	5d                   	pop    %ebp
  802027:	c3                   	ret    
  802028:	39 f0                	cmp    %esi,%eax
  80202a:	0f 87 ac 00 00 00    	ja     8020dc <__umoddi3+0xfc>
  802030:	0f bd e8             	bsr    %eax,%ebp
  802033:	83 f5 1f             	xor    $0x1f,%ebp
  802036:	0f 84 ac 00 00 00    	je     8020e8 <__umoddi3+0x108>
  80203c:	bf 20 00 00 00       	mov    $0x20,%edi
  802041:	29 ef                	sub    %ebp,%edi
  802043:	89 fe                	mov    %edi,%esi
  802045:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802049:	89 e9                	mov    %ebp,%ecx
  80204b:	d3 e0                	shl    %cl,%eax
  80204d:	89 d7                	mov    %edx,%edi
  80204f:	89 f1                	mov    %esi,%ecx
  802051:	d3 ef                	shr    %cl,%edi
  802053:	09 c7                	or     %eax,%edi
  802055:	89 e9                	mov    %ebp,%ecx
  802057:	d3 e2                	shl    %cl,%edx
  802059:	89 14 24             	mov    %edx,(%esp)
  80205c:	89 d8                	mov    %ebx,%eax
  80205e:	d3 e0                	shl    %cl,%eax
  802060:	89 c2                	mov    %eax,%edx
  802062:	8b 44 24 08          	mov    0x8(%esp),%eax
  802066:	d3 e0                	shl    %cl,%eax
  802068:	89 44 24 04          	mov    %eax,0x4(%esp)
  80206c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802070:	89 f1                	mov    %esi,%ecx
  802072:	d3 e8                	shr    %cl,%eax
  802074:	09 d0                	or     %edx,%eax
  802076:	d3 eb                	shr    %cl,%ebx
  802078:	89 da                	mov    %ebx,%edx
  80207a:	f7 f7                	div    %edi
  80207c:	89 d3                	mov    %edx,%ebx
  80207e:	f7 24 24             	mull   (%esp)
  802081:	89 c6                	mov    %eax,%esi
  802083:	89 d1                	mov    %edx,%ecx
  802085:	39 d3                	cmp    %edx,%ebx
  802087:	0f 82 87 00 00 00    	jb     802114 <__umoddi3+0x134>
  80208d:	0f 84 91 00 00 00    	je     802124 <__umoddi3+0x144>
  802093:	8b 54 24 04          	mov    0x4(%esp),%edx
  802097:	29 f2                	sub    %esi,%edx
  802099:	19 cb                	sbb    %ecx,%ebx
  80209b:	89 d8                	mov    %ebx,%eax
  80209d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020a1:	d3 e0                	shl    %cl,%eax
  8020a3:	89 e9                	mov    %ebp,%ecx
  8020a5:	d3 ea                	shr    %cl,%edx
  8020a7:	09 d0                	or     %edx,%eax
  8020a9:	89 e9                	mov    %ebp,%ecx
  8020ab:	d3 eb                	shr    %cl,%ebx
  8020ad:	89 da                	mov    %ebx,%edx
  8020af:	83 c4 1c             	add    $0x1c,%esp
  8020b2:	5b                   	pop    %ebx
  8020b3:	5e                   	pop    %esi
  8020b4:	5f                   	pop    %edi
  8020b5:	5d                   	pop    %ebp
  8020b6:	c3                   	ret    
  8020b7:	90                   	nop
  8020b8:	89 fd                	mov    %edi,%ebp
  8020ba:	85 ff                	test   %edi,%edi
  8020bc:	75 0b                	jne    8020c9 <__umoddi3+0xe9>
  8020be:	b8 01 00 00 00       	mov    $0x1,%eax
  8020c3:	31 d2                	xor    %edx,%edx
  8020c5:	f7 f7                	div    %edi
  8020c7:	89 c5                	mov    %eax,%ebp
  8020c9:	89 f0                	mov    %esi,%eax
  8020cb:	31 d2                	xor    %edx,%edx
  8020cd:	f7 f5                	div    %ebp
  8020cf:	89 c8                	mov    %ecx,%eax
  8020d1:	f7 f5                	div    %ebp
  8020d3:	89 d0                	mov    %edx,%eax
  8020d5:	e9 44 ff ff ff       	jmp    80201e <__umoddi3+0x3e>
  8020da:	66 90                	xchg   %ax,%ax
  8020dc:	89 c8                	mov    %ecx,%eax
  8020de:	89 f2                	mov    %esi,%edx
  8020e0:	83 c4 1c             	add    $0x1c,%esp
  8020e3:	5b                   	pop    %ebx
  8020e4:	5e                   	pop    %esi
  8020e5:	5f                   	pop    %edi
  8020e6:	5d                   	pop    %ebp
  8020e7:	c3                   	ret    
  8020e8:	3b 04 24             	cmp    (%esp),%eax
  8020eb:	72 06                	jb     8020f3 <__umoddi3+0x113>
  8020ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020f1:	77 0f                	ja     802102 <__umoddi3+0x122>
  8020f3:	89 f2                	mov    %esi,%edx
  8020f5:	29 f9                	sub    %edi,%ecx
  8020f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020fb:	89 14 24             	mov    %edx,(%esp)
  8020fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802102:	8b 44 24 04          	mov    0x4(%esp),%eax
  802106:	8b 14 24             	mov    (%esp),%edx
  802109:	83 c4 1c             	add    $0x1c,%esp
  80210c:	5b                   	pop    %ebx
  80210d:	5e                   	pop    %esi
  80210e:	5f                   	pop    %edi
  80210f:	5d                   	pop    %ebp
  802110:	c3                   	ret    
  802111:	8d 76 00             	lea    0x0(%esi),%esi
  802114:	2b 04 24             	sub    (%esp),%eax
  802117:	19 fa                	sbb    %edi,%edx
  802119:	89 d1                	mov    %edx,%ecx
  80211b:	89 c6                	mov    %eax,%esi
  80211d:	e9 71 ff ff ff       	jmp    802093 <__umoddi3+0xb3>
  802122:	66 90                	xchg   %ax,%ax
  802124:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802128:	72 ea                	jb     802114 <__umoddi3+0x134>
  80212a:	89 d9                	mov    %ebx,%ecx
  80212c:	e9 62 ff ff ff       	jmp    802093 <__umoddi3+0xb3>
