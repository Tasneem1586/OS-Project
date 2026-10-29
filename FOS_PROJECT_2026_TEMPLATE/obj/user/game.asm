
obj/user/game:     file format elf32-i386


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
  800031:	e8 98 00 00 00       	call   8000ce <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int i=28;
  80003e:	c7 45 f4 1c 00 00 00 	movl   $0x1c,-0xc(%ebp)
	int txtClr = TEXT_black;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	for(;i<128; i++)
  80004c:	eb 77                	jmp    8000c5 <_main+0x8d>
	{
		txtClr = (txtClr + 1) % 16;
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	40                   	inc    %eax
  800052:	25 0f 00 00 80       	and    $0x8000000f,%eax
  800057:	85 c0                	test   %eax,%eax
  800059:	79 05                	jns    800060 <_main+0x28>
  80005b:	48                   	dec    %eax
  80005c:	83 c8 f0             	or     $0xfffffff0,%eax
  80005f:	40                   	inc    %eax
  800060:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int c=0;
  800063:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;c<10; c++)
  80006a:	eb 19                	jmp    800085 <_main+0x4d>
		{
			cprintf_colored(txtClr, "%~%c",i);
  80006c:	83 ec 04             	sub    $0x4,%esp
  80006f:	ff 75 f4             	pushl  -0xc(%ebp)
  800072:	68 c0 1c 80 00       	push   $0x801cc0
  800077:	ff 75 f0             	pushl  -0x10(%ebp)
  80007a:	e8 bc 03 00 00       	call   80043b <cprintf_colored>
  80007f:	83 c4 10             	add    $0x10,%esp
	int txtClr = TEXT_black;
	for(;i<128; i++)
	{
		txtClr = (txtClr + 1) % 16;
		int c=0;
		for(;c<10; c++)
  800082:	ff 45 ec             	incl   -0x14(%ebp)
  800085:	83 7d ec 09          	cmpl   $0x9,-0x14(%ebp)
  800089:	7e e1                	jle    80006c <_main+0x34>
		{
			cprintf_colored(txtClr, "%~%c",i);
		}
		int d=0;
  80008b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for(; d< 5000000; d++);
  800092:	eb 03                	jmp    800097 <_main+0x5f>
  800094:	ff 45 e8             	incl   -0x18(%ebp)
  800097:	81 7d e8 3f 4b 4c 00 	cmpl   $0x4c4b3f,-0x18(%ebp)
  80009e:	7e f4                	jle    800094 <_main+0x5c>
		c=0;
  8000a0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;c<10; c++)
  8000a7:	eb 13                	jmp    8000bc <_main+0x84>
		{
			cprintf("%~\b");
  8000a9:	83 ec 0c             	sub    $0xc,%esp
  8000ac:	68 c5 1c 80 00       	push   $0x801cc5
  8000b1:	e8 58 03 00 00       	call   80040e <cprintf>
  8000b6:	83 c4 10             	add    $0x10,%esp
			cprintf_colored(txtClr, "%~%c",i);
		}
		int d=0;
		for(; d< 5000000; d++);
		c=0;
		for(;c<10; c++)
  8000b9:	ff 45 ec             	incl   -0x14(%ebp)
  8000bc:	83 7d ec 09          	cmpl   $0x9,-0x14(%ebp)
  8000c0:	7e e7                	jle    8000a9 <_main+0x71>
void
_main(void)
{
	int i=28;
	int txtClr = TEXT_black;
	for(;i<128; i++)
  8000c2:	ff 45 f4             	incl   -0xc(%ebp)
  8000c5:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
  8000c9:	7e 83                	jle    80004e <_main+0x16>
		{
			cprintf("%~\b");
		}
	}

	return;
  8000cb:	90                   	nop
}
  8000cc:	c9                   	leave  
  8000cd:	c3                   	ret    

008000ce <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000ce:	55                   	push   %ebp
  8000cf:	89 e5                	mov    %esp,%ebp
  8000d1:	57                   	push   %edi
  8000d2:	56                   	push   %esi
  8000d3:	53                   	push   %ebx
  8000d4:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000da:	e8 fb 14 00 00       	call   8015da <sys_getenvindex>
  8000df:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000e5:	89 d0                	mov    %edx,%eax
  8000e7:	c1 e0 03             	shl    $0x3,%eax
  8000ea:	01 d0                	add    %edx,%eax
  8000ec:	c1 e0 06             	shl    $0x6,%eax
  8000ef:	01 d0                	add    %edx,%eax
  8000f1:	c1 e0 03             	shl    $0x3,%eax
  8000f4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f9:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800103:	8a 40 10             	mov    0x10(%eax),%al
  800106:	84 c0                	test   %al,%al
  800108:	74 0d                	je     800117 <libmain+0x49>
		binaryname = myEnv->prog_name;
  80010a:	a1 20 30 80 00       	mov    0x803020,%eax
  80010f:	83 c0 10             	add    $0x10,%eax
  800112:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800117:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011b:	7e 0a                	jle    800127 <libmain+0x59>
		binaryname = argv[0];
  80011d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800120:	8b 00                	mov    (%eax),%eax
  800122:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800127:	83 ec 08             	sub    $0x8,%esp
  80012a:	ff 75 0c             	pushl  0xc(%ebp)
  80012d:	ff 75 08             	pushl  0x8(%ebp)
  800130:	e8 03 ff ff ff       	call   800038 <_main>
  800135:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800138:	a1 00 30 80 00       	mov    0x803000,%eax
  80013d:	85 c0                	test   %eax,%eax
  80013f:	0f 84 b7 01 00 00    	je     8002fc <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800145:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80014b:	bb 08 1e 80 00       	mov    $0x801e08,%ebx
  800150:	ba 0e 00 00 00       	mov    $0xe,%edx
  800155:	89 c7                	mov    %eax,%edi
  800157:	89 de                	mov    %ebx,%esi
  800159:	89 d1                	mov    %edx,%ecx
  80015b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80015d:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800163:	b9 56 00 00 00       	mov    $0x56,%ecx
  800168:	b0 00                	mov    $0x0,%al
  80016a:	89 d7                	mov    %edx,%edi
  80016c:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80016e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800175:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	50                   	push   %eax
  80017c:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800182:	50                   	push   %eax
  800183:	e8 52 16 00 00       	call   8017da <sys_utilities>
  800188:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80018b:	e8 d2 11 00 00       	call   801362 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800190:	83 ec 0c             	sub    $0xc,%esp
  800193:	68 e4 1c 80 00       	push   $0x801ce4
  800198:	e8 71 02 00 00       	call   80040e <cprintf>
  80019d:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001a0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001a3:	85 c0                	test   %eax,%eax
  8001a5:	74 58                	je     8001ff <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001a7:	e8 4c 16 00 00       	call   8017f8 <sys_get_optimal_num_faults>
  8001ac:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001af:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001b5:	bb 6c 1e 80 00       	mov    $0x801e6c,%ebx
  8001ba:	ba 11 00 00 00       	mov    $0x11,%edx
  8001bf:	89 c7                	mov    %eax,%edi
  8001c1:	89 de                	mov    %ebx,%esi
  8001c3:	89 d1                	mov    %edx,%ecx
  8001c5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001c7:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001ca:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001cf:	b0 00                	mov    $0x0,%al
  8001d1:	89 d7                	mov    %edx,%edi
  8001d3:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001d5:	83 ec 08             	sub    $0x8,%esp
  8001d8:	ff 75 dc             	pushl  -0x24(%ebp)
  8001db:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001e1:	50                   	push   %eax
  8001e2:	e8 f3 15 00 00       	call   8017da <sys_utilities>
  8001e7:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001ea:	83 ec 08             	sub    $0x8,%esp
  8001ed:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f0:	68 0c 1d 80 00       	push   $0x801d0c
  8001f5:	e8 14 02 00 00       	call   80040e <cprintf>
  8001fa:	83 c4 10             	add    $0x10,%esp
  8001fd:	eb 59                	jmp    800258 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800204:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  80020a:	a1 20 30 80 00       	mov    0x803020,%eax
  80020f:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800215:	83 ec 04             	sub    $0x4,%esp
  800218:	52                   	push   %edx
  800219:	50                   	push   %eax
  80021a:	68 30 1d 80 00       	push   $0x801d30
  80021f:	e8 ea 01 00 00       	call   80040e <cprintf>
  800224:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800227:	a1 20 30 80 00       	mov    0x803020,%eax
  80022c:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800232:	a1 20 30 80 00       	mov    0x803020,%eax
  800237:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80023d:	a1 20 30 80 00       	mov    0x803020,%eax
  800242:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800248:	51                   	push   %ecx
  800249:	52                   	push   %edx
  80024a:	50                   	push   %eax
  80024b:	68 58 1d 80 00       	push   $0x801d58
  800250:	e8 b9 01 00 00       	call   80040e <cprintf>
  800255:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800263:	83 ec 08             	sub    $0x8,%esp
  800266:	50                   	push   %eax
  800267:	68 b0 1d 80 00       	push   $0x801db0
  80026c:	e8 9d 01 00 00       	call   80040e <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	68 c4 1d 80 00       	push   $0x801dc4
  80027c:	e8 8d 01 00 00       	call   80040e <cprintf>
  800281:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800284:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80028b:	eb 28                	jmp    8002b5 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800295:	81 c2 74 04 00 00    	add    $0x474,%edx
  80029b:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80029e:	83 ec 04             	sub    $0x4,%esp
  8002a1:	50                   	push   %eax
  8002a2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a5:	68 db 1d 80 00       	push   $0x801ddb
  8002aa:	e8 5f 01 00 00       	call   80040e <cprintf>
  8002af:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002b2:	ff 45 e4             	incl   -0x1c(%ebp)
  8002b5:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002b9:	7e d2                	jle    80028d <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002bb:	83 ec 0c             	sub    $0xc,%esp
  8002be:	68 ea 1d 80 00       	push   $0x801dea
  8002c3:	e8 46 01 00 00       	call   80040e <cprintf>
  8002c8:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d0:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002d6:	83 ec 08             	sub    $0x8,%esp
  8002d9:	50                   	push   %eax
  8002da:	68 ee 1d 80 00       	push   $0x801dee
  8002df:	e8 2a 01 00 00       	call   80040e <cprintf>
  8002e4:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	68 e4 1c 80 00       	push   $0x801ce4
  8002ef:	e8 1a 01 00 00       	call   80040e <cprintf>
  8002f4:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002f7:	e8 80 10 00 00       	call   80137c <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002fc:	e8 1f 00 00 00       	call   800320 <exit>
}
  800301:	90                   	nop
  800302:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800305:	5b                   	pop    %ebx
  800306:	5e                   	pop    %esi
  800307:	5f                   	pop    %edi
  800308:	5d                   	pop    %ebp
  800309:	c3                   	ret    

0080030a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80030a:	55                   	push   %ebp
  80030b:	89 e5                	mov    %esp,%ebp
  80030d:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800310:	83 ec 0c             	sub    $0xc,%esp
  800313:	6a 00                	push   $0x0
  800315:	e8 8c 12 00 00       	call   8015a6 <sys_destroy_env>
  80031a:	83 c4 10             	add    $0x10,%esp
}
  80031d:	90                   	nop
  80031e:	c9                   	leave  
  80031f:	c3                   	ret    

00800320 <exit>:

void
exit(void)
{
  800320:	55                   	push   %ebp
  800321:	89 e5                	mov    %esp,%ebp
  800323:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800326:	e8 e1 12 00 00       	call   80160c <sys_exit_env>
}
  80032b:	90                   	nop
  80032c:	c9                   	leave  
  80032d:	c3                   	ret    

0080032e <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80032e:	55                   	push   %ebp
  80032f:	89 e5                	mov    %esp,%ebp
  800331:	53                   	push   %ebx
  800332:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8b 00                	mov    (%eax),%eax
  80033a:	8d 48 01             	lea    0x1(%eax),%ecx
  80033d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800340:	89 0a                	mov    %ecx,(%edx)
  800342:	8b 55 08             	mov    0x8(%ebp),%edx
  800345:	88 d1                	mov    %dl,%cl
  800347:	8b 55 0c             	mov    0xc(%ebp),%edx
  80034a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80034e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800351:	8b 00                	mov    (%eax),%eax
  800353:	3d ff 00 00 00       	cmp    $0xff,%eax
  800358:	75 30                	jne    80038a <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80035a:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800360:	a0 40 30 80 00       	mov    0x803040,%al
  800365:	0f b6 c0             	movzbl %al,%eax
  800368:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80036b:	8b 09                	mov    (%ecx),%ecx
  80036d:	89 cb                	mov    %ecx,%ebx
  80036f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800372:	83 c1 08             	add    $0x8,%ecx
  800375:	52                   	push   %edx
  800376:	50                   	push   %eax
  800377:	53                   	push   %ebx
  800378:	51                   	push   %ecx
  800379:	e8 a0 0f 00 00       	call   80131e <sys_cputs>
  80037e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800381:	8b 45 0c             	mov    0xc(%ebp),%eax
  800384:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80038a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80038d:	8b 40 04             	mov    0x4(%eax),%eax
  800390:	8d 50 01             	lea    0x1(%eax),%edx
  800393:	8b 45 0c             	mov    0xc(%ebp),%eax
  800396:	89 50 04             	mov    %edx,0x4(%eax)
}
  800399:	90                   	nop
  80039a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003a8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003af:	00 00 00 
	b.cnt = 0;
  8003b2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003b9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003bc:	ff 75 0c             	pushl  0xc(%ebp)
  8003bf:	ff 75 08             	pushl  0x8(%ebp)
  8003c2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c8:	50                   	push   %eax
  8003c9:	68 2e 03 80 00       	push   $0x80032e
  8003ce:	e8 5a 02 00 00       	call   80062d <vprintfmt>
  8003d3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003d6:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003dc:	a0 40 30 80 00       	mov    0x803040,%al
  8003e1:	0f b6 c0             	movzbl %al,%eax
  8003e4:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003ea:	52                   	push   %edx
  8003eb:	50                   	push   %eax
  8003ec:	51                   	push   %ecx
  8003ed:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003f3:	83 c0 08             	add    $0x8,%eax
  8003f6:	50                   	push   %eax
  8003f7:	e8 22 0f 00 00       	call   80131e <sys_cputs>
  8003fc:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003ff:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800406:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80040c:	c9                   	leave  
  80040d:	c3                   	ret    

0080040e <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80040e:	55                   	push   %ebp
  80040f:	89 e5                	mov    %esp,%ebp
  800411:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800414:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80041b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80041e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	83 ec 08             	sub    $0x8,%esp
  800427:	ff 75 f4             	pushl  -0xc(%ebp)
  80042a:	50                   	push   %eax
  80042b:	e8 6f ff ff ff       	call   80039f <vcprintf>
  800430:	83 c4 10             	add    $0x10,%esp
  800433:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800436:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800439:	c9                   	leave  
  80043a:	c3                   	ret    

0080043b <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80043b:	55                   	push   %ebp
  80043c:	89 e5                	mov    %esp,%ebp
  80043e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800441:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	c1 e0 08             	shl    $0x8,%eax
  80044e:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800453:	8d 45 0c             	lea    0xc(%ebp),%eax
  800456:	83 c0 04             	add    $0x4,%eax
  800459:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80045c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045f:	83 ec 08             	sub    $0x8,%esp
  800462:	ff 75 f4             	pushl  -0xc(%ebp)
  800465:	50                   	push   %eax
  800466:	e8 34 ff ff ff       	call   80039f <vcprintf>
  80046b:	83 c4 10             	add    $0x10,%esp
  80046e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800471:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800478:	07 00 00 

	return cnt;
  80047b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80047e:	c9                   	leave  
  80047f:	c3                   	ret    

00800480 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800480:	55                   	push   %ebp
  800481:	89 e5                	mov    %esp,%ebp
  800483:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800486:	e8 d7 0e 00 00       	call   801362 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80048b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80048e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	83 ec 08             	sub    $0x8,%esp
  800497:	ff 75 f4             	pushl  -0xc(%ebp)
  80049a:	50                   	push   %eax
  80049b:	e8 ff fe ff ff       	call   80039f <vcprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp
  8004a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004a6:	e8 d1 0e 00 00       	call   80137c <sys_unlock_cons>
	return cnt;
  8004ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	53                   	push   %ebx
  8004b4:	83 ec 14             	sub    $0x14,%esp
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004c3:	8b 45 18             	mov    0x18(%ebp),%eax
  8004c6:	ba 00 00 00 00       	mov    $0x0,%edx
  8004cb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004ce:	77 55                	ja     800525 <printnum+0x75>
  8004d0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004d3:	72 05                	jb     8004da <printnum+0x2a>
  8004d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004d8:	77 4b                	ja     800525 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004da:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004dd:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004e0:	8b 45 18             	mov    0x18(%ebp),%eax
  8004e3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e8:	52                   	push   %edx
  8004e9:	50                   	push   %eax
  8004ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8004f0:	e8 5f 15 00 00       	call   801a54 <__udivdi3>
  8004f5:	83 c4 10             	add    $0x10,%esp
  8004f8:	83 ec 04             	sub    $0x4,%esp
  8004fb:	ff 75 20             	pushl  0x20(%ebp)
  8004fe:	53                   	push   %ebx
  8004ff:	ff 75 18             	pushl  0x18(%ebp)
  800502:	52                   	push   %edx
  800503:	50                   	push   %eax
  800504:	ff 75 0c             	pushl  0xc(%ebp)
  800507:	ff 75 08             	pushl  0x8(%ebp)
  80050a:	e8 a1 ff ff ff       	call   8004b0 <printnum>
  80050f:	83 c4 20             	add    $0x20,%esp
  800512:	eb 1a                	jmp    80052e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800514:	83 ec 08             	sub    $0x8,%esp
  800517:	ff 75 0c             	pushl  0xc(%ebp)
  80051a:	ff 75 20             	pushl  0x20(%ebp)
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	ff d0                	call   *%eax
  800522:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800525:	ff 4d 1c             	decl   0x1c(%ebp)
  800528:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80052c:	7f e6                	jg     800514 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80052e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800531:	bb 00 00 00 00       	mov    $0x0,%ebx
  800536:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800539:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80053c:	53                   	push   %ebx
  80053d:	51                   	push   %ecx
  80053e:	52                   	push   %edx
  80053f:	50                   	push   %eax
  800540:	e8 1f 16 00 00       	call   801b64 <__umoddi3>
  800545:	83 c4 10             	add    $0x10,%esp
  800548:	05 f4 20 80 00       	add    $0x8020f4,%eax
  80054d:	8a 00                	mov    (%eax),%al
  80054f:	0f be c0             	movsbl %al,%eax
  800552:	83 ec 08             	sub    $0x8,%esp
  800555:	ff 75 0c             	pushl  0xc(%ebp)
  800558:	50                   	push   %eax
  800559:	8b 45 08             	mov    0x8(%ebp),%eax
  80055c:	ff d0                	call   *%eax
  80055e:	83 c4 10             	add    $0x10,%esp
}
  800561:	90                   	nop
  800562:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800565:	c9                   	leave  
  800566:	c3                   	ret    

00800567 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800567:	55                   	push   %ebp
  800568:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80056a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80056e:	7e 1c                	jle    80058c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800570:	8b 45 08             	mov    0x8(%ebp),%eax
  800573:	8b 00                	mov    (%eax),%eax
  800575:	8d 50 08             	lea    0x8(%eax),%edx
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	89 10                	mov    %edx,(%eax)
  80057d:	8b 45 08             	mov    0x8(%ebp),%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	83 e8 08             	sub    $0x8,%eax
  800585:	8b 50 04             	mov    0x4(%eax),%edx
  800588:	8b 00                	mov    (%eax),%eax
  80058a:	eb 40                	jmp    8005cc <getuint+0x65>
	else if (lflag)
  80058c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800590:	74 1e                	je     8005b0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800592:	8b 45 08             	mov    0x8(%ebp),%eax
  800595:	8b 00                	mov    (%eax),%eax
  800597:	8d 50 04             	lea    0x4(%eax),%edx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	89 10                	mov    %edx,(%eax)
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	8b 00                	mov    (%eax),%eax
  8005a4:	83 e8 04             	sub    $0x4,%eax
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ae:	eb 1c                	jmp    8005cc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	8d 50 04             	lea    0x4(%eax),%edx
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	89 10                	mov    %edx,(%eax)
  8005bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	83 e8 04             	sub    $0x4,%eax
  8005c5:	8b 00                	mov    (%eax),%eax
  8005c7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005cc:	5d                   	pop    %ebp
  8005cd:	c3                   	ret    

008005ce <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005ce:	55                   	push   %ebp
  8005cf:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005d1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d5:	7e 1c                	jle    8005f3 <getint+0x25>
		return va_arg(*ap, long long);
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	8d 50 08             	lea    0x8(%eax),%edx
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	89 10                	mov    %edx,(%eax)
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	8b 00                	mov    (%eax),%eax
  8005e9:	83 e8 08             	sub    $0x8,%eax
  8005ec:	8b 50 04             	mov    0x4(%eax),%edx
  8005ef:	8b 00                	mov    (%eax),%eax
  8005f1:	eb 38                	jmp    80062b <getint+0x5d>
	else if (lflag)
  8005f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005f7:	74 1a                	je     800613 <getint+0x45>
		return va_arg(*ap, long);
  8005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fc:	8b 00                	mov    (%eax),%eax
  8005fe:	8d 50 04             	lea    0x4(%eax),%edx
  800601:	8b 45 08             	mov    0x8(%ebp),%eax
  800604:	89 10                	mov    %edx,(%eax)
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	8b 00                	mov    (%eax),%eax
  80060b:	83 e8 04             	sub    $0x4,%eax
  80060e:	8b 00                	mov    (%eax),%eax
  800610:	99                   	cltd   
  800611:	eb 18                	jmp    80062b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	8d 50 04             	lea    0x4(%eax),%edx
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	89 10                	mov    %edx,(%eax)
  800620:	8b 45 08             	mov    0x8(%ebp),%eax
  800623:	8b 00                	mov    (%eax),%eax
  800625:	83 e8 04             	sub    $0x4,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	99                   	cltd   
}
  80062b:	5d                   	pop    %ebp
  80062c:	c3                   	ret    

0080062d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80062d:	55                   	push   %ebp
  80062e:	89 e5                	mov    %esp,%ebp
  800630:	56                   	push   %esi
  800631:	53                   	push   %ebx
  800632:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800635:	eb 17                	jmp    80064e <vprintfmt+0x21>
			if (ch == '\0')
  800637:	85 db                	test   %ebx,%ebx
  800639:	0f 84 c1 03 00 00    	je     800a00 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80063f:	83 ec 08             	sub    $0x8,%esp
  800642:	ff 75 0c             	pushl  0xc(%ebp)
  800645:	53                   	push   %ebx
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	ff d0                	call   *%eax
  80064b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064e:	8b 45 10             	mov    0x10(%ebp),%eax
  800651:	8d 50 01             	lea    0x1(%eax),%edx
  800654:	89 55 10             	mov    %edx,0x10(%ebp)
  800657:	8a 00                	mov    (%eax),%al
  800659:	0f b6 d8             	movzbl %al,%ebx
  80065c:	83 fb 25             	cmp    $0x25,%ebx
  80065f:	75 d6                	jne    800637 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800661:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800665:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80066c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800673:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80067a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800681:	8b 45 10             	mov    0x10(%ebp),%eax
  800684:	8d 50 01             	lea    0x1(%eax),%edx
  800687:	89 55 10             	mov    %edx,0x10(%ebp)
  80068a:	8a 00                	mov    (%eax),%al
  80068c:	0f b6 d8             	movzbl %al,%ebx
  80068f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800692:	83 f8 5b             	cmp    $0x5b,%eax
  800695:	0f 87 3d 03 00 00    	ja     8009d8 <vprintfmt+0x3ab>
  80069b:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  8006a2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006a4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006a8:	eb d7                	jmp    800681 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006aa:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006ae:	eb d1                	jmp    800681 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006b0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006ba:	89 d0                	mov    %edx,%eax
  8006bc:	c1 e0 02             	shl    $0x2,%eax
  8006bf:	01 d0                	add    %edx,%eax
  8006c1:	01 c0                	add    %eax,%eax
  8006c3:	01 d8                	add    %ebx,%eax
  8006c5:	83 e8 30             	sub    $0x30,%eax
  8006c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ce:	8a 00                	mov    (%eax),%al
  8006d0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006d3:	83 fb 2f             	cmp    $0x2f,%ebx
  8006d6:	7e 3e                	jle    800716 <vprintfmt+0xe9>
  8006d8:	83 fb 39             	cmp    $0x39,%ebx
  8006db:	7f 39                	jg     800716 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006dd:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006e0:	eb d5                	jmp    8006b7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e5:	83 c0 04             	add    $0x4,%eax
  8006e8:	89 45 14             	mov    %eax,0x14(%ebp)
  8006eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ee:	83 e8 04             	sub    $0x4,%eax
  8006f1:	8b 00                	mov    (%eax),%eax
  8006f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006f6:	eb 1f                	jmp    800717 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fc:	79 83                	jns    800681 <vprintfmt+0x54>
				width = 0;
  8006fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800705:	e9 77 ff ff ff       	jmp    800681 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80070a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800711:	e9 6b ff ff ff       	jmp    800681 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800716:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800717:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80071b:	0f 89 60 ff ff ff    	jns    800681 <vprintfmt+0x54>
				width = precision, precision = -1;
  800721:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800724:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800727:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80072e:	e9 4e ff ff ff       	jmp    800681 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800733:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800736:	e9 46 ff ff ff       	jmp    800681 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80073b:	8b 45 14             	mov    0x14(%ebp),%eax
  80073e:	83 c0 04             	add    $0x4,%eax
  800741:	89 45 14             	mov    %eax,0x14(%ebp)
  800744:	8b 45 14             	mov    0x14(%ebp),%eax
  800747:	83 e8 04             	sub    $0x4,%eax
  80074a:	8b 00                	mov    (%eax),%eax
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 0c             	pushl  0xc(%ebp)
  800752:	50                   	push   %eax
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	ff d0                	call   *%eax
  800758:	83 c4 10             	add    $0x10,%esp
			break;
  80075b:	e9 9b 02 00 00       	jmp    8009fb <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800760:	8b 45 14             	mov    0x14(%ebp),%eax
  800763:	83 c0 04             	add    $0x4,%eax
  800766:	89 45 14             	mov    %eax,0x14(%ebp)
  800769:	8b 45 14             	mov    0x14(%ebp),%eax
  80076c:	83 e8 04             	sub    $0x4,%eax
  80076f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800771:	85 db                	test   %ebx,%ebx
  800773:	79 02                	jns    800777 <vprintfmt+0x14a>
				err = -err;
  800775:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800777:	83 fb 64             	cmp    $0x64,%ebx
  80077a:	7f 0b                	jg     800787 <vprintfmt+0x15a>
  80077c:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  800783:	85 f6                	test   %esi,%esi
  800785:	75 19                	jne    8007a0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800787:	53                   	push   %ebx
  800788:	68 05 21 80 00       	push   $0x802105
  80078d:	ff 75 0c             	pushl  0xc(%ebp)
  800790:	ff 75 08             	pushl  0x8(%ebp)
  800793:	e8 70 02 00 00       	call   800a08 <printfmt>
  800798:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80079b:	e9 5b 02 00 00       	jmp    8009fb <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007a0:	56                   	push   %esi
  8007a1:	68 0e 21 80 00       	push   $0x80210e
  8007a6:	ff 75 0c             	pushl  0xc(%ebp)
  8007a9:	ff 75 08             	pushl  0x8(%ebp)
  8007ac:	e8 57 02 00 00       	call   800a08 <printfmt>
  8007b1:	83 c4 10             	add    $0x10,%esp
			break;
  8007b4:	e9 42 02 00 00       	jmp    8009fb <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bc:	83 c0 04             	add    $0x4,%eax
  8007bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c5:	83 e8 04             	sub    $0x4,%eax
  8007c8:	8b 30                	mov    (%eax),%esi
  8007ca:	85 f6                	test   %esi,%esi
  8007cc:	75 05                	jne    8007d3 <vprintfmt+0x1a6>
				p = "(null)";
  8007ce:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  8007d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d7:	7e 6d                	jle    800846 <vprintfmt+0x219>
  8007d9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007dd:	74 67                	je     800846 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007df:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	50                   	push   %eax
  8007e6:	56                   	push   %esi
  8007e7:	e8 1e 03 00 00       	call   800b0a <strnlen>
  8007ec:	83 c4 10             	add    $0x10,%esp
  8007ef:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007f2:	eb 16                	jmp    80080a <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007f4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	50                   	push   %eax
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800807:	ff 4d e4             	decl   -0x1c(%ebp)
  80080a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80080e:	7f e4                	jg     8007f4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800810:	eb 34                	jmp    800846 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800812:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800816:	74 1c                	je     800834 <vprintfmt+0x207>
  800818:	83 fb 1f             	cmp    $0x1f,%ebx
  80081b:	7e 05                	jle    800822 <vprintfmt+0x1f5>
  80081d:	83 fb 7e             	cmp    $0x7e,%ebx
  800820:	7e 12                	jle    800834 <vprintfmt+0x207>
					putch('?', putdat);
  800822:	83 ec 08             	sub    $0x8,%esp
  800825:	ff 75 0c             	pushl  0xc(%ebp)
  800828:	6a 3f                	push   $0x3f
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
  800832:	eb 0f                	jmp    800843 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800834:	83 ec 08             	sub    $0x8,%esp
  800837:	ff 75 0c             	pushl  0xc(%ebp)
  80083a:	53                   	push   %ebx
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	ff d0                	call   *%eax
  800840:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800843:	ff 4d e4             	decl   -0x1c(%ebp)
  800846:	89 f0                	mov    %esi,%eax
  800848:	8d 70 01             	lea    0x1(%eax),%esi
  80084b:	8a 00                	mov    (%eax),%al
  80084d:	0f be d8             	movsbl %al,%ebx
  800850:	85 db                	test   %ebx,%ebx
  800852:	74 24                	je     800878 <vprintfmt+0x24b>
  800854:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800858:	78 b8                	js     800812 <vprintfmt+0x1e5>
  80085a:	ff 4d e0             	decl   -0x20(%ebp)
  80085d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800861:	79 af                	jns    800812 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800863:	eb 13                	jmp    800878 <vprintfmt+0x24b>
				putch(' ', putdat);
  800865:	83 ec 08             	sub    $0x8,%esp
  800868:	ff 75 0c             	pushl  0xc(%ebp)
  80086b:	6a 20                	push   $0x20
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	ff d0                	call   *%eax
  800872:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800875:	ff 4d e4             	decl   -0x1c(%ebp)
  800878:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80087c:	7f e7                	jg     800865 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80087e:	e9 78 01 00 00       	jmp    8009fb <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800883:	83 ec 08             	sub    $0x8,%esp
  800886:	ff 75 e8             	pushl  -0x18(%ebp)
  800889:	8d 45 14             	lea    0x14(%ebp),%eax
  80088c:	50                   	push   %eax
  80088d:	e8 3c fd ff ff       	call   8005ce <getint>
  800892:	83 c4 10             	add    $0x10,%esp
  800895:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800898:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80089b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80089e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008a1:	85 d2                	test   %edx,%edx
  8008a3:	79 23                	jns    8008c8 <vprintfmt+0x29b>
				putch('-', putdat);
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	6a 2d                	push   $0x2d
  8008ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b0:	ff d0                	call   *%eax
  8008b2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008bb:	f7 d8                	neg    %eax
  8008bd:	83 d2 00             	adc    $0x0,%edx
  8008c0:	f7 da                	neg    %edx
  8008c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008c8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008cf:	e9 bc 00 00 00       	jmp    800990 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008d4:	83 ec 08             	sub    $0x8,%esp
  8008d7:	ff 75 e8             	pushl  -0x18(%ebp)
  8008da:	8d 45 14             	lea    0x14(%ebp),%eax
  8008dd:	50                   	push   %eax
  8008de:	e8 84 fc ff ff       	call   800567 <getuint>
  8008e3:	83 c4 10             	add    $0x10,%esp
  8008e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008ec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008f3:	e9 98 00 00 00       	jmp    800990 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008f8:	83 ec 08             	sub    $0x8,%esp
  8008fb:	ff 75 0c             	pushl  0xc(%ebp)
  8008fe:	6a 58                	push   $0x58
  800900:	8b 45 08             	mov    0x8(%ebp),%eax
  800903:	ff d0                	call   *%eax
  800905:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800908:	83 ec 08             	sub    $0x8,%esp
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	6a 58                	push   $0x58
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	ff d0                	call   *%eax
  800915:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800918:	83 ec 08             	sub    $0x8,%esp
  80091b:	ff 75 0c             	pushl  0xc(%ebp)
  80091e:	6a 58                	push   $0x58
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	ff d0                	call   *%eax
  800925:	83 c4 10             	add    $0x10,%esp
			break;
  800928:	e9 ce 00 00 00       	jmp    8009fb <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	6a 30                	push   $0x30
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	ff d0                	call   *%eax
  80093a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80093d:	83 ec 08             	sub    $0x8,%esp
  800940:	ff 75 0c             	pushl  0xc(%ebp)
  800943:	6a 78                	push   $0x78
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	ff d0                	call   *%eax
  80094a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80094d:	8b 45 14             	mov    0x14(%ebp),%eax
  800950:	83 c0 04             	add    $0x4,%eax
  800953:	89 45 14             	mov    %eax,0x14(%ebp)
  800956:	8b 45 14             	mov    0x14(%ebp),%eax
  800959:	83 e8 04             	sub    $0x4,%eax
  80095c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80095e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800961:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800968:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80096f:	eb 1f                	jmp    800990 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800971:	83 ec 08             	sub    $0x8,%esp
  800974:	ff 75 e8             	pushl  -0x18(%ebp)
  800977:	8d 45 14             	lea    0x14(%ebp),%eax
  80097a:	50                   	push   %eax
  80097b:	e8 e7 fb ff ff       	call   800567 <getuint>
  800980:	83 c4 10             	add    $0x10,%esp
  800983:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800986:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800989:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800990:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800994:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800997:	83 ec 04             	sub    $0x4,%esp
  80099a:	52                   	push   %edx
  80099b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80099e:	50                   	push   %eax
  80099f:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a2:	ff 75 f0             	pushl  -0x10(%ebp)
  8009a5:	ff 75 0c             	pushl  0xc(%ebp)
  8009a8:	ff 75 08             	pushl  0x8(%ebp)
  8009ab:	e8 00 fb ff ff       	call   8004b0 <printnum>
  8009b0:	83 c4 20             	add    $0x20,%esp
			break;
  8009b3:	eb 46                	jmp    8009fb <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	ff 75 0c             	pushl  0xc(%ebp)
  8009bb:	53                   	push   %ebx
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
			break;
  8009c4:	eb 35                	jmp    8009fb <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009c6:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009cd:	eb 2c                	jmp    8009fb <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009cf:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009d6:	eb 23                	jmp    8009fb <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009d8:	83 ec 08             	sub    $0x8,%esp
  8009db:	ff 75 0c             	pushl  0xc(%ebp)
  8009de:	6a 25                	push   $0x25
  8009e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e3:	ff d0                	call   *%eax
  8009e5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009e8:	ff 4d 10             	decl   0x10(%ebp)
  8009eb:	eb 03                	jmp    8009f0 <vprintfmt+0x3c3>
  8009ed:	ff 4d 10             	decl   0x10(%ebp)
  8009f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f3:	48                   	dec    %eax
  8009f4:	8a 00                	mov    (%eax),%al
  8009f6:	3c 25                	cmp    $0x25,%al
  8009f8:	75 f3                	jne    8009ed <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8009fa:	90                   	nop
		}
	}
  8009fb:	e9 35 fc ff ff       	jmp    800635 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a00:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a01:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a04:	5b                   	pop    %ebx
  800a05:	5e                   	pop    %esi
  800a06:	5d                   	pop    %ebp
  800a07:	c3                   	ret    

00800a08 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a08:	55                   	push   %ebp
  800a09:	89 e5                	mov    %esp,%ebp
  800a0b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a0e:	8d 45 10             	lea    0x10(%ebp),%eax
  800a11:	83 c0 04             	add    $0x4,%eax
  800a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a17:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1d:	50                   	push   %eax
  800a1e:	ff 75 0c             	pushl  0xc(%ebp)
  800a21:	ff 75 08             	pushl  0x8(%ebp)
  800a24:	e8 04 fc ff ff       	call   80062d <vprintfmt>
  800a29:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a2c:	90                   	nop
  800a2d:	c9                   	leave  
  800a2e:	c3                   	ret    

00800a2f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a2f:	55                   	push   %ebp
  800a30:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a35:	8b 40 08             	mov    0x8(%eax),%eax
  800a38:	8d 50 01             	lea    0x1(%eax),%edx
  800a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a44:	8b 10                	mov    (%eax),%edx
  800a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a49:	8b 40 04             	mov    0x4(%eax),%eax
  800a4c:	39 c2                	cmp    %eax,%edx
  800a4e:	73 12                	jae    800a62 <sprintputch+0x33>
		*b->buf++ = ch;
  800a50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a53:	8b 00                	mov    (%eax),%eax
  800a55:	8d 48 01             	lea    0x1(%eax),%ecx
  800a58:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5b:	89 0a                	mov    %ecx,(%edx)
  800a5d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a60:	88 10                	mov    %dl,(%eax)
}
  800a62:	90                   	nop
  800a63:	5d                   	pop    %ebp
  800a64:	c3                   	ret    

00800a65 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a65:	55                   	push   %ebp
  800a66:	89 e5                	mov    %esp,%ebp
  800a68:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	01 d0                	add    %edx,%eax
  800a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a86:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a8a:	74 06                	je     800a92 <vsnprintf+0x2d>
  800a8c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a90:	7f 07                	jg     800a99 <vsnprintf+0x34>
		return -E_INVAL;
  800a92:	b8 03 00 00 00       	mov    $0x3,%eax
  800a97:	eb 20                	jmp    800ab9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a99:	ff 75 14             	pushl  0x14(%ebp)
  800a9c:	ff 75 10             	pushl  0x10(%ebp)
  800a9f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aa2:	50                   	push   %eax
  800aa3:	68 2f 0a 80 00       	push   $0x800a2f
  800aa8:	e8 80 fb ff ff       	call   80062d <vprintfmt>
  800aad:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ab0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
  800abe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ac1:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac4:	83 c0 04             	add    $0x4,%eax
  800ac7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800aca:	8b 45 10             	mov    0x10(%ebp),%eax
  800acd:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad0:	50                   	push   %eax
  800ad1:	ff 75 0c             	pushl  0xc(%ebp)
  800ad4:	ff 75 08             	pushl  0x8(%ebp)
  800ad7:	e8 89 ff ff ff       	call   800a65 <vsnprintf>
  800adc:	83 c4 10             	add    $0x10,%esp
  800adf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae5:	c9                   	leave  
  800ae6:	c3                   	ret    

00800ae7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ae7:	55                   	push   %ebp
  800ae8:	89 e5                	mov    %esp,%ebp
  800aea:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800aed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af4:	eb 06                	jmp    800afc <strlen+0x15>
		n++;
  800af6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800af9:	ff 45 08             	incl   0x8(%ebp)
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8a 00                	mov    (%eax),%al
  800b01:	84 c0                	test   %al,%al
  800b03:	75 f1                	jne    800af6 <strlen+0xf>
		n++;
	return n;
  800b05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b08:	c9                   	leave  
  800b09:	c3                   	ret    

00800b0a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b0a:	55                   	push   %ebp
  800b0b:	89 e5                	mov    %esp,%ebp
  800b0d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b17:	eb 09                	jmp    800b22 <strnlen+0x18>
		n++;
  800b19:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b1c:	ff 45 08             	incl   0x8(%ebp)
  800b1f:	ff 4d 0c             	decl   0xc(%ebp)
  800b22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b26:	74 09                	je     800b31 <strnlen+0x27>
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	8a 00                	mov    (%eax),%al
  800b2d:	84 c0                	test   %al,%al
  800b2f:	75 e8                	jne    800b19 <strnlen+0xf>
		n++;
	return n;
  800b31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b42:	90                   	nop
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8d 50 01             	lea    0x1(%eax),%edx
  800b49:	89 55 08             	mov    %edx,0x8(%ebp)
  800b4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b52:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b55:	8a 12                	mov    (%edx),%dl
  800b57:	88 10                	mov    %dl,(%eax)
  800b59:	8a 00                	mov    (%eax),%al
  800b5b:	84 c0                	test   %al,%al
  800b5d:	75 e4                	jne    800b43 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b62:	c9                   	leave  
  800b63:	c3                   	ret    

00800b64 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b64:	55                   	push   %ebp
  800b65:	89 e5                	mov    %esp,%ebp
  800b67:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b77:	eb 1f                	jmp    800b98 <strncpy+0x34>
		*dst++ = *src;
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 08             	mov    %edx,0x8(%ebp)
  800b82:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b85:	8a 12                	mov    (%edx),%dl
  800b87:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8c:	8a 00                	mov    (%eax),%al
  800b8e:	84 c0                	test   %al,%al
  800b90:	74 03                	je     800b95 <strncpy+0x31>
			src++;
  800b92:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b95:	ff 45 fc             	incl   -0x4(%ebp)
  800b98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b9e:	72 d9                	jb     800b79 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ba0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ba3:	c9                   	leave  
  800ba4:	c3                   	ret    

00800ba5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ba5:	55                   	push   %ebp
  800ba6:	89 e5                	mov    %esp,%ebp
  800ba8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bb1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb5:	74 30                	je     800be7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bb7:	eb 16                	jmp    800bcf <strlcpy+0x2a>
			*dst++ = *src++;
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	8d 50 01             	lea    0x1(%eax),%edx
  800bbf:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bcb:	8a 12                	mov    (%edx),%dl
  800bcd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bcf:	ff 4d 10             	decl   0x10(%ebp)
  800bd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd6:	74 09                	je     800be1 <strlcpy+0x3c>
  800bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdb:	8a 00                	mov    (%eax),%al
  800bdd:	84 c0                	test   %al,%al
  800bdf:	75 d8                	jne    800bb9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800be7:	8b 55 08             	mov    0x8(%ebp),%edx
  800bea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bed:	29 c2                	sub    %eax,%edx
  800bef:	89 d0                	mov    %edx,%eax
}
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bf6:	eb 06                	jmp    800bfe <strcmp+0xb>
		p++, q++;
  800bf8:	ff 45 08             	incl   0x8(%ebp)
  800bfb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	84 c0                	test   %al,%al
  800c05:	74 0e                	je     800c15 <strcmp+0x22>
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	8a 10                	mov    (%eax),%dl
  800c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0f:	8a 00                	mov    (%eax),%al
  800c11:	38 c2                	cmp    %al,%dl
  800c13:	74 e3                	je     800bf8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	0f b6 d0             	movzbl %al,%edx
  800c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	0f b6 c0             	movzbl %al,%eax
  800c25:	29 c2                	sub    %eax,%edx
  800c27:	89 d0                	mov    %edx,%eax
}
  800c29:	5d                   	pop    %ebp
  800c2a:	c3                   	ret    

00800c2b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c2b:	55                   	push   %ebp
  800c2c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c2e:	eb 09                	jmp    800c39 <strncmp+0xe>
		n--, p++, q++;
  800c30:	ff 4d 10             	decl   0x10(%ebp)
  800c33:	ff 45 08             	incl   0x8(%ebp)
  800c36:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3d:	74 17                	je     800c56 <strncmp+0x2b>
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	84 c0                	test   %al,%al
  800c46:	74 0e                	je     800c56 <strncmp+0x2b>
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	8a 10                	mov    (%eax),%dl
  800c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	38 c2                	cmp    %al,%dl
  800c54:	74 da                	je     800c30 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c5a:	75 07                	jne    800c63 <strncmp+0x38>
		return 0;
  800c5c:	b8 00 00 00 00       	mov    $0x0,%eax
  800c61:	eb 14                	jmp    800c77 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	0f b6 d0             	movzbl %al,%edx
  800c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6e:	8a 00                	mov    (%eax),%al
  800c70:	0f b6 c0             	movzbl %al,%eax
  800c73:	29 c2                	sub    %eax,%edx
  800c75:	89 d0                	mov    %edx,%eax
}
  800c77:	5d                   	pop    %ebp
  800c78:	c3                   	ret    

00800c79 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
  800c7c:	83 ec 04             	sub    $0x4,%esp
  800c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c82:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c85:	eb 12                	jmp    800c99 <strchr+0x20>
		if (*s == c)
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c8f:	75 05                	jne    800c96 <strchr+0x1d>
			return (char *) s;
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	eb 11                	jmp    800ca7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c96:	ff 45 08             	incl   0x8(%ebp)
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	84 c0                	test   %al,%al
  800ca0:	75 e5                	jne    800c87 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ca2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ca7:	c9                   	leave  
  800ca8:	c3                   	ret    

00800ca9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ca9:	55                   	push   %ebp
  800caa:	89 e5                	mov    %esp,%ebp
  800cac:	83 ec 04             	sub    $0x4,%esp
  800caf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cb5:	eb 0d                	jmp    800cc4 <strfind+0x1b>
		if (*s == c)
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cbf:	74 0e                	je     800ccf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cc1:	ff 45 08             	incl   0x8(%ebp)
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	84 c0                	test   %al,%al
  800ccb:	75 ea                	jne    800cb7 <strfind+0xe>
  800ccd:	eb 01                	jmp    800cd0 <strfind+0x27>
		if (*s == c)
			break;
  800ccf:	90                   	nop
	return (char *) s;
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cd3:	c9                   	leave  
  800cd4:	c3                   	ret    

00800cd5 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800ce1:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ce5:	76 63                	jbe    800d4a <memset+0x75>
		uint64 data_block = c;
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	99                   	cltd   
  800ceb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cee:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800cf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cf4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf7:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800cfb:	c1 e0 08             	shl    $0x8,%eax
  800cfe:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d01:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800d04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d0a:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d0e:	c1 e0 10             	shl    $0x10,%eax
  800d11:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d14:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d1d:	89 c2                	mov    %eax,%edx
  800d1f:	b8 00 00 00 00       	mov    $0x0,%eax
  800d24:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d27:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d2a:	eb 18                	jmp    800d44 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d2c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d2f:	8d 41 08             	lea    0x8(%ecx),%eax
  800d32:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d38:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d3b:	89 01                	mov    %eax,(%ecx)
  800d3d:	89 51 04             	mov    %edx,0x4(%ecx)
  800d40:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d44:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d48:	77 e2                	ja     800d2c <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4e:	74 23                	je     800d73 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d53:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d56:	eb 0e                	jmp    800d66 <memset+0x91>
			*p8++ = (uint8)c;
  800d58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d5b:	8d 50 01             	lea    0x1(%eax),%edx
  800d5e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d61:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d64:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d66:	8b 45 10             	mov    0x10(%ebp),%eax
  800d69:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6f:	85 c0                	test   %eax,%eax
  800d71:	75 e5                	jne    800d58 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d8a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d8e:	76 24                	jbe    800db4 <memcpy+0x3c>
		while(n >= 8){
  800d90:	eb 1c                	jmp    800dae <memcpy+0x36>
			*d64 = *s64;
  800d92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d95:	8b 50 04             	mov    0x4(%eax),%edx
  800d98:	8b 00                	mov    (%eax),%eax
  800d9a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d9d:	89 01                	mov    %eax,(%ecx)
  800d9f:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800da2:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800da6:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800daa:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800dae:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800db2:	77 de                	ja     800d92 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800db4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db8:	74 31                	je     800deb <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800dba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800dc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800dc6:	eb 16                	jmp    800dde <memcpy+0x66>
			*d8++ = *s8++;
  800dc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dcb:	8d 50 01             	lea    0x1(%eax),%edx
  800dce:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800dd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dd4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd7:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800dda:	8a 12                	mov    (%edx),%dl
  800ddc:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800dde:	8b 45 10             	mov    0x10(%ebp),%eax
  800de1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de4:	89 55 10             	mov    %edx,0x10(%ebp)
  800de7:	85 c0                	test   %eax,%eax
  800de9:	75 dd                	jne    800dc8 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dee:	c9                   	leave  
  800def:	c3                   	ret    

00800df0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800df0:	55                   	push   %ebp
  800df1:	89 e5                	mov    %esp,%ebp
  800df3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800df6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e05:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e08:	73 50                	jae    800e5a <memmove+0x6a>
  800e0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e10:	01 d0                	add    %edx,%eax
  800e12:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e15:	76 43                	jbe    800e5a <memmove+0x6a>
		s += n;
  800e17:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e20:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e23:	eb 10                	jmp    800e35 <memmove+0x45>
			*--d = *--s;
  800e25:	ff 4d f8             	decl   -0x8(%ebp)
  800e28:	ff 4d fc             	decl   -0x4(%ebp)
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2e:	8a 10                	mov    (%eax),%dl
  800e30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e33:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e35:	8b 45 10             	mov    0x10(%ebp),%eax
  800e38:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3e:	85 c0                	test   %eax,%eax
  800e40:	75 e3                	jne    800e25 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e42:	eb 23                	jmp    800e67 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e47:	8d 50 01             	lea    0x1(%eax),%edx
  800e4a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e50:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e53:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e56:	8a 12                	mov    (%edx),%dl
  800e58:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e60:	89 55 10             	mov    %edx,0x10(%ebp)
  800e63:	85 c0                	test   %eax,%eax
  800e65:	75 dd                	jne    800e44 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6a:	c9                   	leave  
  800e6b:	c3                   	ret    

00800e6c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e6c:	55                   	push   %ebp
  800e6d:	89 e5                	mov    %esp,%ebp
  800e6f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e7e:	eb 2a                	jmp    800eaa <memcmp+0x3e>
		if (*s1 != *s2)
  800e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e83:	8a 10                	mov    (%eax),%dl
  800e85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	38 c2                	cmp    %al,%dl
  800e8c:	74 16                	je     800ea4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e91:	8a 00                	mov    (%eax),%al
  800e93:	0f b6 d0             	movzbl %al,%edx
  800e96:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	0f b6 c0             	movzbl %al,%eax
  800e9e:	29 c2                	sub    %eax,%edx
  800ea0:	89 d0                	mov    %edx,%eax
  800ea2:	eb 18                	jmp    800ebc <memcmp+0x50>
		s1++, s2++;
  800ea4:	ff 45 fc             	incl   -0x4(%ebp)
  800ea7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800eaa:	8b 45 10             	mov    0x10(%ebp),%eax
  800ead:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb0:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb3:	85 c0                	test   %eax,%eax
  800eb5:	75 c9                	jne    800e80 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebc:	c9                   	leave  
  800ebd:	c3                   	ret    

00800ebe <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ebe:	55                   	push   %ebp
  800ebf:	89 e5                	mov    %esp,%ebp
  800ec1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ec4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eca:	01 d0                	add    %edx,%eax
  800ecc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ecf:	eb 15                	jmp    800ee6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	0f b6 d0             	movzbl %al,%edx
  800ed9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edc:	0f b6 c0             	movzbl %al,%eax
  800edf:	39 c2                	cmp    %eax,%edx
  800ee1:	74 0d                	je     800ef0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ee3:	ff 45 08             	incl   0x8(%ebp)
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eec:	72 e3                	jb     800ed1 <memfind+0x13>
  800eee:	eb 01                	jmp    800ef1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ef0:	90                   	nop
	return (void *) s;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef4:	c9                   	leave  
  800ef5:	c3                   	ret    

00800ef6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ef6:	55                   	push   %ebp
  800ef7:	89 e5                	mov    %esp,%ebp
  800ef9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800efc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f03:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0a:	eb 03                	jmp    800f0f <strtol+0x19>
		s++;
  800f0c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	3c 20                	cmp    $0x20,%al
  800f16:	74 f4                	je     800f0c <strtol+0x16>
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 09                	cmp    $0x9,%al
  800f1f:	74 eb                	je     800f0c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	3c 2b                	cmp    $0x2b,%al
  800f28:	75 05                	jne    800f2f <strtol+0x39>
		s++;
  800f2a:	ff 45 08             	incl   0x8(%ebp)
  800f2d:	eb 13                	jmp    800f42 <strtol+0x4c>
	else if (*s == '-')
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	3c 2d                	cmp    $0x2d,%al
  800f36:	75 0a                	jne    800f42 <strtol+0x4c>
		s++, neg = 1;
  800f38:	ff 45 08             	incl   0x8(%ebp)
  800f3b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f46:	74 06                	je     800f4e <strtol+0x58>
  800f48:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f4c:	75 20                	jne    800f6e <strtol+0x78>
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	3c 30                	cmp    $0x30,%al
  800f55:	75 17                	jne    800f6e <strtol+0x78>
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	40                   	inc    %eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	3c 78                	cmp    $0x78,%al
  800f5f:	75 0d                	jne    800f6e <strtol+0x78>
		s += 2, base = 16;
  800f61:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f65:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f6c:	eb 28                	jmp    800f96 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f6e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f72:	75 15                	jne    800f89 <strtol+0x93>
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	3c 30                	cmp    $0x30,%al
  800f7b:	75 0c                	jne    800f89 <strtol+0x93>
		s++, base = 8;
  800f7d:	ff 45 08             	incl   0x8(%ebp)
  800f80:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f87:	eb 0d                	jmp    800f96 <strtol+0xa0>
	else if (base == 0)
  800f89:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8d:	75 07                	jne    800f96 <strtol+0xa0>
		base = 10;
  800f8f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	3c 2f                	cmp    $0x2f,%al
  800f9d:	7e 19                	jle    800fb8 <strtol+0xc2>
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	3c 39                	cmp    $0x39,%al
  800fa6:	7f 10                	jg     800fb8 <strtol+0xc2>
			dig = *s - '0';
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	0f be c0             	movsbl %al,%eax
  800fb0:	83 e8 30             	sub    $0x30,%eax
  800fb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb6:	eb 42                	jmp    800ffa <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 60                	cmp    $0x60,%al
  800fbf:	7e 19                	jle    800fda <strtol+0xe4>
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	3c 7a                	cmp    $0x7a,%al
  800fc8:	7f 10                	jg     800fda <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	0f be c0             	movsbl %al,%eax
  800fd2:	83 e8 57             	sub    $0x57,%eax
  800fd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd8:	eb 20                	jmp    800ffa <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 40                	cmp    $0x40,%al
  800fe1:	7e 39                	jle    80101c <strtol+0x126>
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	3c 5a                	cmp    $0x5a,%al
  800fea:	7f 30                	jg     80101c <strtol+0x126>
			dig = *s - 'A' + 10;
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	0f be c0             	movsbl %al,%eax
  800ff4:	83 e8 37             	sub    $0x37,%eax
  800ff7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ffa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffd:	3b 45 10             	cmp    0x10(%ebp),%eax
  801000:	7d 19                	jge    80101b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801002:	ff 45 08             	incl   0x8(%ebp)
  801005:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801008:	0f af 45 10          	imul   0x10(%ebp),%eax
  80100c:	89 c2                	mov    %eax,%edx
  80100e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801011:	01 d0                	add    %edx,%eax
  801013:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801016:	e9 7b ff ff ff       	jmp    800f96 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80101b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80101c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801020:	74 08                	je     80102a <strtol+0x134>
		*endptr = (char *) s;
  801022:	8b 45 0c             	mov    0xc(%ebp),%eax
  801025:	8b 55 08             	mov    0x8(%ebp),%edx
  801028:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80102a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80102e:	74 07                	je     801037 <strtol+0x141>
  801030:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801033:	f7 d8                	neg    %eax
  801035:	eb 03                	jmp    80103a <strtol+0x144>
  801037:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <ltostr>:

void
ltostr(long value, char *str)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801042:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801049:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801050:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801054:	79 13                	jns    801069 <ltostr+0x2d>
	{
		neg = 1;
  801056:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80105d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801060:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801063:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801066:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801071:	99                   	cltd   
  801072:	f7 f9                	idiv   %ecx
  801074:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801077:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107a:	8d 50 01             	lea    0x1(%eax),%edx
  80107d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801080:	89 c2                	mov    %eax,%edx
  801082:	8b 45 0c             	mov    0xc(%ebp),%eax
  801085:	01 d0                	add    %edx,%eax
  801087:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80108a:	83 c2 30             	add    $0x30,%edx
  80108d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80108f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801092:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801097:	f7 e9                	imul   %ecx
  801099:	c1 fa 02             	sar    $0x2,%edx
  80109c:	89 c8                	mov    %ecx,%eax
  80109e:	c1 f8 1f             	sar    $0x1f,%eax
  8010a1:	29 c2                	sub    %eax,%edx
  8010a3:	89 d0                	mov    %edx,%eax
  8010a5:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8010a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ac:	75 bb                	jne    801069 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b8:	48                   	dec    %eax
  8010b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010c0:	74 3d                	je     8010ff <ltostr+0xc3>
		start = 1 ;
  8010c2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c9:	eb 34                	jmp    8010ff <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8010cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d1:	01 d0                	add    %edx,%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010de:	01 c2                	add    %eax,%edx
  8010e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e6:	01 c8                	add    %ecx,%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f2:	01 c2                	add    %eax,%edx
  8010f4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f7:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010fc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801102:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801105:	7c c4                	jl     8010cb <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801107:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80110a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110d:	01 d0                	add    %edx,%eax
  80110f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801112:	90                   	nop
  801113:	c9                   	leave  
  801114:	c3                   	ret    

00801115 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801115:	55                   	push   %ebp
  801116:	89 e5                	mov    %esp,%ebp
  801118:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80111b:	ff 75 08             	pushl  0x8(%ebp)
  80111e:	e8 c4 f9 ff ff       	call   800ae7 <strlen>
  801123:	83 c4 04             	add    $0x4,%esp
  801126:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801129:	ff 75 0c             	pushl  0xc(%ebp)
  80112c:	e8 b6 f9 ff ff       	call   800ae7 <strlen>
  801131:	83 c4 04             	add    $0x4,%esp
  801134:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801137:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80113e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801145:	eb 17                	jmp    80115e <strcconcat+0x49>
		final[s] = str1[s] ;
  801147:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80114a:	8b 45 10             	mov    0x10(%ebp),%eax
  80114d:	01 c2                	add    %eax,%edx
  80114f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	01 c8                	add    %ecx,%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80115b:	ff 45 fc             	incl   -0x4(%ebp)
  80115e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801161:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801164:	7c e1                	jl     801147 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801166:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80116d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801174:	eb 1f                	jmp    801195 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801176:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801179:	8d 50 01             	lea    0x1(%eax),%edx
  80117c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80117f:	89 c2                	mov    %eax,%edx
  801181:	8b 45 10             	mov    0x10(%ebp),%eax
  801184:	01 c2                	add    %eax,%edx
  801186:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118c:	01 c8                	add    %ecx,%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801192:	ff 45 f8             	incl   -0x8(%ebp)
  801195:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801198:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80119b:	7c d9                	jl     801176 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80119d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a3:	01 d0                	add    %edx,%eax
  8011a5:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a8:	90                   	nop
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ba:	8b 00                	mov    (%eax),%eax
  8011bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c6:	01 d0                	add    %edx,%eax
  8011c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ce:	eb 0c                	jmp    8011dc <strsplit+0x31>
			*string++ = 0;
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8d 50 01             	lea    0x1(%eax),%edx
  8011d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	84 c0                	test   %al,%al
  8011e3:	74 18                	je     8011fd <strsplit+0x52>
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	0f be c0             	movsbl %al,%eax
  8011ed:	50                   	push   %eax
  8011ee:	ff 75 0c             	pushl  0xc(%ebp)
  8011f1:	e8 83 fa ff ff       	call   800c79 <strchr>
  8011f6:	83 c4 08             	add    $0x8,%esp
  8011f9:	85 c0                	test   %eax,%eax
  8011fb:	75 d3                	jne    8011d0 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	84 c0                	test   %al,%al
  801204:	74 5a                	je     801260 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801206:	8b 45 14             	mov    0x14(%ebp),%eax
  801209:	8b 00                	mov    (%eax),%eax
  80120b:	83 f8 0f             	cmp    $0xf,%eax
  80120e:	75 07                	jne    801217 <strsplit+0x6c>
		{
			return 0;
  801210:	b8 00 00 00 00       	mov    $0x0,%eax
  801215:	eb 66                	jmp    80127d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801217:	8b 45 14             	mov    0x14(%ebp),%eax
  80121a:	8b 00                	mov    (%eax),%eax
  80121c:	8d 48 01             	lea    0x1(%eax),%ecx
  80121f:	8b 55 14             	mov    0x14(%ebp),%edx
  801222:	89 0a                	mov    %ecx,(%edx)
  801224:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122b:	8b 45 10             	mov    0x10(%ebp),%eax
  80122e:	01 c2                	add    %eax,%edx
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801235:	eb 03                	jmp    80123a <strsplit+0x8f>
			string++;
  801237:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8a 00                	mov    (%eax),%al
  80123f:	84 c0                	test   %al,%al
  801241:	74 8b                	je     8011ce <strsplit+0x23>
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	8a 00                	mov    (%eax),%al
  801248:	0f be c0             	movsbl %al,%eax
  80124b:	50                   	push   %eax
  80124c:	ff 75 0c             	pushl  0xc(%ebp)
  80124f:	e8 25 fa ff ff       	call   800c79 <strchr>
  801254:	83 c4 08             	add    $0x8,%esp
  801257:	85 c0                	test   %eax,%eax
  801259:	74 dc                	je     801237 <strsplit+0x8c>
			string++;
	}
  80125b:	e9 6e ff ff ff       	jmp    8011ce <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801260:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801261:	8b 45 14             	mov    0x14(%ebp),%eax
  801264:	8b 00                	mov    (%eax),%eax
  801266:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	01 d0                	add    %edx,%eax
  801272:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801278:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80127d:	c9                   	leave  
  80127e:	c3                   	ret    

0080127f <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
  801282:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80128b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801292:	eb 4a                	jmp    8012de <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801294:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	01 c2                	add    %eax,%edx
  80129c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80129f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a2:	01 c8                	add    %ecx,%eax
  8012a4:	8a 00                	mov    (%eax),%al
  8012a6:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8012a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ae:	01 d0                	add    %edx,%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	3c 40                	cmp    $0x40,%al
  8012b4:	7e 25                	jle    8012db <str2lower+0x5c>
  8012b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bc:	01 d0                	add    %edx,%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	3c 5a                	cmp    $0x5a,%al
  8012c2:	7f 17                	jg     8012db <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	01 d0                	add    %edx,%eax
  8012cc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8012d2:	01 ca                	add    %ecx,%edx
  8012d4:	8a 12                	mov    (%edx),%dl
  8012d6:	83 c2 20             	add    $0x20,%edx
  8012d9:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012db:	ff 45 fc             	incl   -0x4(%ebp)
  8012de:	ff 75 0c             	pushl  0xc(%ebp)
  8012e1:	e8 01 f8 ff ff       	call   800ae7 <strlen>
  8012e6:	83 c4 04             	add    $0x4,%esp
  8012e9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012ec:	7f a6                	jg     801294 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8012ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
  8012f6:	57                   	push   %edi
  8012f7:	56                   	push   %esi
  8012f8:	53                   	push   %ebx
  8012f9:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801302:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801305:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801308:	8b 7d 18             	mov    0x18(%ebp),%edi
  80130b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80130e:	cd 30                	int    $0x30
  801310:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801313:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801316:	83 c4 10             	add    $0x10,%esp
  801319:	5b                   	pop    %ebx
  80131a:	5e                   	pop    %esi
  80131b:	5f                   	pop    %edi
  80131c:	5d                   	pop    %ebp
  80131d:	c3                   	ret    

0080131e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
  801321:	83 ec 04             	sub    $0x4,%esp
  801324:	8b 45 10             	mov    0x10(%ebp),%eax
  801327:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80132a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80132d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	6a 00                	push   $0x0
  801336:	51                   	push   %ecx
  801337:	52                   	push   %edx
  801338:	ff 75 0c             	pushl  0xc(%ebp)
  80133b:	50                   	push   %eax
  80133c:	6a 00                	push   $0x0
  80133e:	e8 b0 ff ff ff       	call   8012f3 <syscall>
  801343:	83 c4 18             	add    $0x18,%esp
}
  801346:	90                   	nop
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <sys_cgetc>:

int
sys_cgetc(void)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 02                	push   $0x2
  801358:	e8 96 ff ff ff       	call   8012f3 <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 03                	push   $0x3
  801371:	e8 7d ff ff ff       	call   8012f3 <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	90                   	nop
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 04                	push   $0x4
  80138b:	e8 63 ff ff ff       	call   8012f3 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	90                   	nop
  801394:	c9                   	leave  
  801395:	c3                   	ret    

00801396 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801396:	55                   	push   %ebp
  801397:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801399:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	52                   	push   %edx
  8013a6:	50                   	push   %eax
  8013a7:	6a 08                	push   $0x8
  8013a9:	e8 45 ff ff ff       	call   8012f3 <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
  8013b6:	56                   	push   %esi
  8013b7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013b8:	8b 75 18             	mov    0x18(%ebp),%esi
  8013bb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013be:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	56                   	push   %esi
  8013c8:	53                   	push   %ebx
  8013c9:	51                   	push   %ecx
  8013ca:	52                   	push   %edx
  8013cb:	50                   	push   %eax
  8013cc:	6a 09                	push   $0x9
  8013ce:	e8 20 ff ff ff       	call   8012f3 <syscall>
  8013d3:	83 c4 18             	add    $0x18,%esp
}
  8013d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013d9:	5b                   	pop    %ebx
  8013da:	5e                   	pop    %esi
  8013db:	5d                   	pop    %ebp
  8013dc:	c3                   	ret    

008013dd <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	ff 75 08             	pushl  0x8(%ebp)
  8013eb:	6a 0a                	push   $0xa
  8013ed:	e8 01 ff ff ff       	call   8012f3 <syscall>
  8013f2:	83 c4 18             	add    $0x18,%esp
}
  8013f5:	c9                   	leave  
  8013f6:	c3                   	ret    

008013f7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	ff 75 0c             	pushl  0xc(%ebp)
  801403:	ff 75 08             	pushl  0x8(%ebp)
  801406:	6a 0b                	push   $0xb
  801408:	e8 e6 fe ff ff       	call   8012f3 <syscall>
  80140d:	83 c4 18             	add    $0x18,%esp
}
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 0c                	push   $0xc
  801421:	e8 cd fe ff ff       	call   8012f3 <syscall>
  801426:	83 c4 18             	add    $0x18,%esp
}
  801429:	c9                   	leave  
  80142a:	c3                   	ret    

0080142b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80142b:	55                   	push   %ebp
  80142c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 0d                	push   $0xd
  80143a:	e8 b4 fe ff ff       	call   8012f3 <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
}
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 0e                	push   $0xe
  801453:	e8 9b fe ff ff       	call   8012f3 <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 0f                	push   $0xf
  80146c:	e8 82 fe ff ff       	call   8012f3 <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	ff 75 08             	pushl  0x8(%ebp)
  801484:	6a 10                	push   $0x10
  801486:	e8 68 fe ff ff       	call   8012f3 <syscall>
  80148b:	83 c4 18             	add    $0x18,%esp
}
  80148e:	c9                   	leave  
  80148f:	c3                   	ret    

00801490 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 11                	push   $0x11
  80149f:	e8 4f fe ff ff       	call   8012f3 <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
}
  8014a7:	90                   	nop
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <sys_cputc>:

void
sys_cputc(const char c)
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
  8014ad:	83 ec 04             	sub    $0x4,%esp
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014b6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	50                   	push   %eax
  8014c3:	6a 01                	push   $0x1
  8014c5:	e8 29 fe ff ff       	call   8012f3 <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
}
  8014cd:	90                   	nop
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 14                	push   $0x14
  8014df:	e8 0f fe ff ff       	call   8012f3 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	90                   	nop
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 04             	sub    $0x4,%esp
  8014f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8014f6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014f9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	6a 00                	push   $0x0
  801502:	51                   	push   %ecx
  801503:	52                   	push   %edx
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	50                   	push   %eax
  801508:	6a 15                	push   $0x15
  80150a:	e8 e4 fd ff ff       	call   8012f3 <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801517:	8b 55 10             	mov    0x10(%ebp),%edx
  80151a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	52                   	push   %edx
  801522:	50                   	push   %eax
  801523:	ff 75 08             	pushl  0x8(%ebp)
  801526:	6a 16                	push   $0x16
  801528:	e8 c6 fd ff ff       	call   8012f3 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
}
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801535:	8b 55 0c             	mov    0xc(%ebp),%edx
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	52                   	push   %edx
  801542:	50                   	push   %eax
  801543:	6a 17                	push   $0x17
  801545:	e8 a9 fd ff ff       	call   8012f3 <syscall>
  80154a:	83 c4 18             	add    $0x18,%esp
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801552:	8b 55 0c             	mov    0xc(%ebp),%edx
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	52                   	push   %edx
  80155f:	50                   	push   %eax
  801560:	6a 18                	push   $0x18
  801562:	e8 8c fd ff ff       	call   8012f3 <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
  801572:	6a 00                	push   $0x0
  801574:	ff 75 14             	pushl  0x14(%ebp)
  801577:	ff 75 10             	pushl  0x10(%ebp)
  80157a:	ff 75 0c             	pushl  0xc(%ebp)
  80157d:	50                   	push   %eax
  80157e:	6a 19                	push   $0x19
  801580:	e8 6e fd ff ff       	call   8012f3 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_run_env>:

void sys_run_env(int32 envId)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	50                   	push   %eax
  801599:	6a 1a                	push   $0x1a
  80159b:	e8 53 fd ff ff       	call   8012f3 <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
}
  8015a3:	90                   	nop
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	50                   	push   %eax
  8015b5:	6a 1b                	push   $0x1b
  8015b7:	e8 37 fd ff ff       	call   8012f3 <syscall>
  8015bc:	83 c4 18             	add    $0x18,%esp
}
  8015bf:	c9                   	leave  
  8015c0:	c3                   	ret    

008015c1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015c1:	55                   	push   %ebp
  8015c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 05                	push   $0x5
  8015d0:	e8 1e fd ff ff       	call   8012f3 <syscall>
  8015d5:	83 c4 18             	add    $0x18,%esp
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 06                	push   $0x6
  8015e9:	e8 05 fd ff ff       	call   8012f3 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 07                	push   $0x7
  801602:	e8 ec fc ff ff       	call   8012f3 <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_exit_env>:


void sys_exit_env(void)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 1c                	push   $0x1c
  80161b:	e8 d3 fc ff ff       	call   8012f3 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	90                   	nop
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	ff 75 10             	pushl  0x10(%ebp)
  801630:	ff 75 0c             	pushl  0xc(%ebp)
  801633:	ff 75 08             	pushl  0x8(%ebp)
  801636:	6a 13                	push   $0x13
  801638:	e8 b6 fc ff ff       	call   8012f3 <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
	return ;
  801640:	90                   	nop
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_rcr2>:
uint32 sys_rcr2()
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 1e                	push   $0x1e
  801652:	e8 9c fc ff ff       	call   8012f3 <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 04             	sub    $0x4,%esp
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801668:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	50                   	push   %eax
  801675:	6a 1f                	push   $0x1f
  801677:	e8 77 fc ff ff       	call   8012f3 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
	return ;
  80167f:	90                   	nop
}
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <rsttst>:
void rsttst()
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 21                	push   $0x21
  801691:	e8 5d fc ff ff       	call   8012f3 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
	return ;
  801699:	90                   	nop
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 04             	sub    $0x4,%esp
  8016a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016a8:	8b 55 18             	mov    0x18(%ebp),%edx
  8016ab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016af:	52                   	push   %edx
  8016b0:	50                   	push   %eax
  8016b1:	ff 75 10             	pushl  0x10(%ebp)
  8016b4:	ff 75 0c             	pushl  0xc(%ebp)
  8016b7:	ff 75 08             	pushl  0x8(%ebp)
  8016ba:	6a 20                	push   $0x20
  8016bc:	e8 32 fc ff ff       	call   8012f3 <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c4:	90                   	nop
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <chktst>:
void chktst(uint32 n)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	ff 75 08             	pushl  0x8(%ebp)
  8016d5:	6a 22                	push   $0x22
  8016d7:	e8 17 fc ff ff       	call   8012f3 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016df:	90                   	nop
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <inctst>:

void inctst()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 23                	push   $0x23
  8016f1:	e8 fd fb ff ff       	call   8012f3 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f9:	90                   	nop
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <gettst>:
uint32 gettst()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 24                	push   $0x24
  80170b:	e8 e3 fb ff ff       	call   8012f3 <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
}
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 25                	push   $0x25
  801724:	e8 ca fb ff ff       	call   8012f3 <syscall>
  801729:	83 c4 18             	add    $0x18,%esp
  80172c:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801731:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	ff 75 08             	pushl  0x8(%ebp)
  80174e:	6a 26                	push   $0x26
  801750:	e8 9e fb ff ff       	call   8012f3 <syscall>
  801755:	83 c4 18             	add    $0x18,%esp
	return ;
  801758:	90                   	nop
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
  80175e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80175f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801762:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801765:	8b 55 0c             	mov    0xc(%ebp),%edx
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	6a 00                	push   $0x0
  80176d:	53                   	push   %ebx
  80176e:	51                   	push   %ecx
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 27                	push   $0x27
  801773:	e8 7b fb ff ff       	call   8012f3 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80177e:	c9                   	leave  
  80177f:	c3                   	ret    

00801780 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801783:	8b 55 0c             	mov    0xc(%ebp),%edx
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	52                   	push   %edx
  801790:	50                   	push   %eax
  801791:	6a 28                	push   $0x28
  801793:	e8 5b fb ff ff       	call   8012f3 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8017a0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a9:	6a 00                	push   $0x0
  8017ab:	51                   	push   %ecx
  8017ac:	ff 75 10             	pushl  0x10(%ebp)
  8017af:	52                   	push   %edx
  8017b0:	50                   	push   %eax
  8017b1:	6a 29                	push   $0x29
  8017b3:	e8 3b fb ff ff       	call   8012f3 <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	ff 75 10             	pushl  0x10(%ebp)
  8017c7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ca:	ff 75 08             	pushl  0x8(%ebp)
  8017cd:	6a 12                	push   $0x12
  8017cf:	e8 1f fb ff ff       	call   8012f3 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d7:	90                   	nop
}
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	52                   	push   %edx
  8017ea:	50                   	push   %eax
  8017eb:	6a 2a                	push   $0x2a
  8017ed:	e8 01 fb ff ff       	call   8012f3 <syscall>
  8017f2:	83 c4 18             	add    $0x18,%esp
	return;
  8017f5:	90                   	nop
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 2b                	push   $0x2b
  801807:	e8 e7 fa ff ff       	call   8012f3 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
  801814:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801817:	83 ec 04             	sub    $0x4,%esp
  80181a:	68 88 22 80 00       	push   $0x802288
  80181f:	68 0a 01 00 00       	push   $0x10a
  801824:	68 98 22 80 00       	push   $0x802298
  801829:	e8 38 00 00 00       	call   801866 <_panic>

0080182e <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	ff 75 0c             	pushl  0xc(%ebp)
  80183a:	ff 75 08             	pushl  0x8(%ebp)
  80183d:	6a 33                	push   $0x33
  80183f:	e8 af fa ff ff       	call   8012f3 <syscall>
  801844:	83 c4 18             	add    $0x18,%esp
	return;
  801847:	90                   	nop
}
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	ff 75 0c             	pushl  0xc(%ebp)
  801856:	ff 75 08             	pushl  0x8(%ebp)
  801859:	6a 34                	push   $0x34
  80185b:	e8 93 fa ff ff       	call   8012f3 <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
	return ;
  801863:	90                   	nop
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
  801869:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80186c:	8d 45 10             	lea    0x10(%ebp),%eax
  80186f:	83 c0 04             	add    $0x4,%eax
  801872:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801875:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80187a:	85 c0                	test   %eax,%eax
  80187c:	74 16                	je     801894 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80187e:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801883:	83 ec 08             	sub    $0x8,%esp
  801886:	50                   	push   %eax
  801887:	68 a8 22 80 00       	push   $0x8022a8
  80188c:	e8 7d eb ff ff       	call   80040e <cprintf>
  801891:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801894:	a1 04 30 80 00       	mov    0x803004,%eax
  801899:	83 ec 0c             	sub    $0xc,%esp
  80189c:	ff 75 0c             	pushl  0xc(%ebp)
  80189f:	ff 75 08             	pushl  0x8(%ebp)
  8018a2:	50                   	push   %eax
  8018a3:	68 b0 22 80 00       	push   $0x8022b0
  8018a8:	6a 74                	push   $0x74
  8018aa:	e8 8c eb ff ff       	call   80043b <cprintf_colored>
  8018af:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8018b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b5:	83 ec 08             	sub    $0x8,%esp
  8018b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8018bb:	50                   	push   %eax
  8018bc:	e8 de ea ff ff       	call   80039f <vcprintf>
  8018c1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018c4:	83 ec 08             	sub    $0x8,%esp
  8018c7:	6a 00                	push   $0x0
  8018c9:	68 d8 22 80 00       	push   $0x8022d8
  8018ce:	e8 cc ea ff ff       	call   80039f <vcprintf>
  8018d3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018d6:	e8 45 ea ff ff       	call   800320 <exit>

	// should not return here
	while (1) ;
  8018db:	eb fe                	jmp    8018db <_panic+0x75>

008018dd <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018dd:	55                   	push   %ebp
  8018de:	89 e5                	mov    %esp,%ebp
  8018e0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8018e8:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8018ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f1:	39 c2                	cmp    %eax,%edx
  8018f3:	74 14                	je     801909 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018f5:	83 ec 04             	sub    $0x4,%esp
  8018f8:	68 dc 22 80 00       	push   $0x8022dc
  8018fd:	6a 26                	push   $0x26
  8018ff:	68 28 23 80 00       	push   $0x802328
  801904:	e8 5d ff ff ff       	call   801866 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801909:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801910:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801917:	e9 c5 00 00 00       	jmp    8019e1 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80191c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	01 d0                	add    %edx,%eax
  80192b:	8b 00                	mov    (%eax),%eax
  80192d:	85 c0                	test   %eax,%eax
  80192f:	75 08                	jne    801939 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801931:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801934:	e9 a5 00 00 00       	jmp    8019de <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801939:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801940:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801947:	eb 69                	jmp    8019b2 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801949:	a1 20 30 80 00       	mov    0x803020,%eax
  80194e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801954:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801957:	89 d0                	mov    %edx,%eax
  801959:	01 c0                	add    %eax,%eax
  80195b:	01 d0                	add    %edx,%eax
  80195d:	c1 e0 03             	shl    $0x3,%eax
  801960:	01 c8                	add    %ecx,%eax
  801962:	8a 40 04             	mov    0x4(%eax),%al
  801965:	84 c0                	test   %al,%al
  801967:	75 46                	jne    8019af <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801969:	a1 20 30 80 00       	mov    0x803020,%eax
  80196e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801974:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801977:	89 d0                	mov    %edx,%eax
  801979:	01 c0                	add    %eax,%eax
  80197b:	01 d0                	add    %edx,%eax
  80197d:	c1 e0 03             	shl    $0x3,%eax
  801980:	01 c8                	add    %ecx,%eax
  801982:	8b 00                	mov    (%eax),%eax
  801984:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801987:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80198a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80198f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801991:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801994:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	01 c8                	add    %ecx,%eax
  8019a0:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019a2:	39 c2                	cmp    %eax,%edx
  8019a4:	75 09                	jne    8019af <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8019a6:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019ad:	eb 15                	jmp    8019c4 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019af:	ff 45 e8             	incl   -0x18(%ebp)
  8019b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8019b7:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019c0:	39 c2                	cmp    %eax,%edx
  8019c2:	77 85                	ja     801949 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019c8:	75 14                	jne    8019de <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8019ca:	83 ec 04             	sub    $0x4,%esp
  8019cd:	68 34 23 80 00       	push   $0x802334
  8019d2:	6a 3a                	push   $0x3a
  8019d4:	68 28 23 80 00       	push   $0x802328
  8019d9:	e8 88 fe ff ff       	call   801866 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019de:	ff 45 f0             	incl   -0x10(%ebp)
  8019e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019e7:	0f 8c 2f ff ff ff    	jl     80191c <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019fb:	eb 26                	jmp    801a23 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019fd:	a1 20 30 80 00       	mov    0x803020,%eax
  801a02:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801a08:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a0b:	89 d0                	mov    %edx,%eax
  801a0d:	01 c0                	add    %eax,%eax
  801a0f:	01 d0                	add    %edx,%eax
  801a11:	c1 e0 03             	shl    $0x3,%eax
  801a14:	01 c8                	add    %ecx,%eax
  801a16:	8a 40 04             	mov    0x4(%eax),%al
  801a19:	3c 01                	cmp    $0x1,%al
  801a1b:	75 03                	jne    801a20 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801a1d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a20:	ff 45 e0             	incl   -0x20(%ebp)
  801a23:	a1 20 30 80 00       	mov    0x803020,%eax
  801a28:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a31:	39 c2                	cmp    %eax,%edx
  801a33:	77 c8                	ja     8019fd <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a38:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a3b:	74 14                	je     801a51 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a3d:	83 ec 04             	sub    $0x4,%esp
  801a40:	68 88 23 80 00       	push   $0x802388
  801a45:	6a 44                	push   $0x44
  801a47:	68 28 23 80 00       	push   $0x802328
  801a4c:	e8 15 fe ff ff       	call   801866 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a51:	90                   	nop
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <__udivdi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a6b:	89 ca                	mov    %ecx,%edx
  801a6d:	89 f8                	mov    %edi,%eax
  801a6f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a73:	85 f6                	test   %esi,%esi
  801a75:	75 2d                	jne    801aa4 <__udivdi3+0x50>
  801a77:	39 cf                	cmp    %ecx,%edi
  801a79:	77 65                	ja     801ae0 <__udivdi3+0x8c>
  801a7b:	89 fd                	mov    %edi,%ebp
  801a7d:	85 ff                	test   %edi,%edi
  801a7f:	75 0b                	jne    801a8c <__udivdi3+0x38>
  801a81:	b8 01 00 00 00       	mov    $0x1,%eax
  801a86:	31 d2                	xor    %edx,%edx
  801a88:	f7 f7                	div    %edi
  801a8a:	89 c5                	mov    %eax,%ebp
  801a8c:	31 d2                	xor    %edx,%edx
  801a8e:	89 c8                	mov    %ecx,%eax
  801a90:	f7 f5                	div    %ebp
  801a92:	89 c1                	mov    %eax,%ecx
  801a94:	89 d8                	mov    %ebx,%eax
  801a96:	f7 f5                	div    %ebp
  801a98:	89 cf                	mov    %ecx,%edi
  801a9a:	89 fa                	mov    %edi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	39 ce                	cmp    %ecx,%esi
  801aa6:	77 28                	ja     801ad0 <__udivdi3+0x7c>
  801aa8:	0f bd fe             	bsr    %esi,%edi
  801aab:	83 f7 1f             	xor    $0x1f,%edi
  801aae:	75 40                	jne    801af0 <__udivdi3+0x9c>
  801ab0:	39 ce                	cmp    %ecx,%esi
  801ab2:	72 0a                	jb     801abe <__udivdi3+0x6a>
  801ab4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab8:	0f 87 9e 00 00 00    	ja     801b5c <__udivdi3+0x108>
  801abe:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac3:	89 fa                	mov    %edi,%edx
  801ac5:	83 c4 1c             	add    $0x1c,%esp
  801ac8:	5b                   	pop    %ebx
  801ac9:	5e                   	pop    %esi
  801aca:	5f                   	pop    %edi
  801acb:	5d                   	pop    %ebp
  801acc:	c3                   	ret    
  801acd:	8d 76 00             	lea    0x0(%esi),%esi
  801ad0:	31 ff                	xor    %edi,%edi
  801ad2:	31 c0                	xor    %eax,%eax
  801ad4:	89 fa                	mov    %edi,%edx
  801ad6:	83 c4 1c             	add    $0x1c,%esp
  801ad9:	5b                   	pop    %ebx
  801ada:	5e                   	pop    %esi
  801adb:	5f                   	pop    %edi
  801adc:	5d                   	pop    %ebp
  801add:	c3                   	ret    
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	89 d8                	mov    %ebx,%eax
  801ae2:	f7 f7                	div    %edi
  801ae4:	31 ff                	xor    %edi,%edi
  801ae6:	89 fa                	mov    %edi,%edx
  801ae8:	83 c4 1c             	add    $0x1c,%esp
  801aeb:	5b                   	pop    %ebx
  801aec:	5e                   	pop    %esi
  801aed:	5f                   	pop    %edi
  801aee:	5d                   	pop    %ebp
  801aef:	c3                   	ret    
  801af0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af5:	89 eb                	mov    %ebp,%ebx
  801af7:	29 fb                	sub    %edi,%ebx
  801af9:	89 f9                	mov    %edi,%ecx
  801afb:	d3 e6                	shl    %cl,%esi
  801afd:	89 c5                	mov    %eax,%ebp
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 ed                	shr    %cl,%ebp
  801b03:	89 e9                	mov    %ebp,%ecx
  801b05:	09 f1                	or     %esi,%ecx
  801b07:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b0b:	89 f9                	mov    %edi,%ecx
  801b0d:	d3 e0                	shl    %cl,%eax
  801b0f:	89 c5                	mov    %eax,%ebp
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	88 d9                	mov    %bl,%cl
  801b15:	d3 ee                	shr    %cl,%esi
  801b17:	89 f9                	mov    %edi,%ecx
  801b19:	d3 e2                	shl    %cl,%edx
  801b1b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1f:	88 d9                	mov    %bl,%cl
  801b21:	d3 e8                	shr    %cl,%eax
  801b23:	09 c2                	or     %eax,%edx
  801b25:	89 d0                	mov    %edx,%eax
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	f7 74 24 0c          	divl   0xc(%esp)
  801b2d:	89 d6                	mov    %edx,%esi
  801b2f:	89 c3                	mov    %eax,%ebx
  801b31:	f7 e5                	mul    %ebp
  801b33:	39 d6                	cmp    %edx,%esi
  801b35:	72 19                	jb     801b50 <__udivdi3+0xfc>
  801b37:	74 0b                	je     801b44 <__udivdi3+0xf0>
  801b39:	89 d8                	mov    %ebx,%eax
  801b3b:	31 ff                	xor    %edi,%edi
  801b3d:	e9 58 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b42:	66 90                	xchg   %ax,%ax
  801b44:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b48:	89 f9                	mov    %edi,%ecx
  801b4a:	d3 e2                	shl    %cl,%edx
  801b4c:	39 c2                	cmp    %eax,%edx
  801b4e:	73 e9                	jae    801b39 <__udivdi3+0xe5>
  801b50:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b53:	31 ff                	xor    %edi,%edi
  801b55:	e9 40 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	31 c0                	xor    %eax,%eax
  801b5e:	e9 37 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b63:	90                   	nop

00801b64 <__umoddi3>:
  801b64:	55                   	push   %ebp
  801b65:	57                   	push   %edi
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	83 ec 1c             	sub    $0x1c,%esp
  801b6b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b77:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b83:	89 f3                	mov    %esi,%ebx
  801b85:	89 fa                	mov    %edi,%edx
  801b87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b8b:	89 34 24             	mov    %esi,(%esp)
  801b8e:	85 c0                	test   %eax,%eax
  801b90:	75 1a                	jne    801bac <__umoddi3+0x48>
  801b92:	39 f7                	cmp    %esi,%edi
  801b94:	0f 86 a2 00 00 00    	jbe    801c3c <__umoddi3+0xd8>
  801b9a:	89 c8                	mov    %ecx,%eax
  801b9c:	89 f2                	mov    %esi,%edx
  801b9e:	f7 f7                	div    %edi
  801ba0:	89 d0                	mov    %edx,%eax
  801ba2:	31 d2                	xor    %edx,%edx
  801ba4:	83 c4 1c             	add    $0x1c,%esp
  801ba7:	5b                   	pop    %ebx
  801ba8:	5e                   	pop    %esi
  801ba9:	5f                   	pop    %edi
  801baa:	5d                   	pop    %ebp
  801bab:	c3                   	ret    
  801bac:	39 f0                	cmp    %esi,%eax
  801bae:	0f 87 ac 00 00 00    	ja     801c60 <__umoddi3+0xfc>
  801bb4:	0f bd e8             	bsr    %eax,%ebp
  801bb7:	83 f5 1f             	xor    $0x1f,%ebp
  801bba:	0f 84 ac 00 00 00    	je     801c6c <__umoddi3+0x108>
  801bc0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc5:	29 ef                	sub    %ebp,%edi
  801bc7:	89 fe                	mov    %edi,%esi
  801bc9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bcd:	89 e9                	mov    %ebp,%ecx
  801bcf:	d3 e0                	shl    %cl,%eax
  801bd1:	89 d7                	mov    %edx,%edi
  801bd3:	89 f1                	mov    %esi,%ecx
  801bd5:	d3 ef                	shr    %cl,%edi
  801bd7:	09 c7                	or     %eax,%edi
  801bd9:	89 e9                	mov    %ebp,%ecx
  801bdb:	d3 e2                	shl    %cl,%edx
  801bdd:	89 14 24             	mov    %edx,(%esp)
  801be0:	89 d8                	mov    %ebx,%eax
  801be2:	d3 e0                	shl    %cl,%eax
  801be4:	89 c2                	mov    %eax,%edx
  801be6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bea:	d3 e0                	shl    %cl,%eax
  801bec:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bf0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf4:	89 f1                	mov    %esi,%ecx
  801bf6:	d3 e8                	shr    %cl,%eax
  801bf8:	09 d0                	or     %edx,%eax
  801bfa:	d3 eb                	shr    %cl,%ebx
  801bfc:	89 da                	mov    %ebx,%edx
  801bfe:	f7 f7                	div    %edi
  801c00:	89 d3                	mov    %edx,%ebx
  801c02:	f7 24 24             	mull   (%esp)
  801c05:	89 c6                	mov    %eax,%esi
  801c07:	89 d1                	mov    %edx,%ecx
  801c09:	39 d3                	cmp    %edx,%ebx
  801c0b:	0f 82 87 00 00 00    	jb     801c98 <__umoddi3+0x134>
  801c11:	0f 84 91 00 00 00    	je     801ca8 <__umoddi3+0x144>
  801c17:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c1b:	29 f2                	sub    %esi,%edx
  801c1d:	19 cb                	sbb    %ecx,%ebx
  801c1f:	89 d8                	mov    %ebx,%eax
  801c21:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c25:	d3 e0                	shl    %cl,%eax
  801c27:	89 e9                	mov    %ebp,%ecx
  801c29:	d3 ea                	shr    %cl,%edx
  801c2b:	09 d0                	or     %edx,%eax
  801c2d:	89 e9                	mov    %ebp,%ecx
  801c2f:	d3 eb                	shr    %cl,%ebx
  801c31:	89 da                	mov    %ebx,%edx
  801c33:	83 c4 1c             	add    $0x1c,%esp
  801c36:	5b                   	pop    %ebx
  801c37:	5e                   	pop    %esi
  801c38:	5f                   	pop    %edi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    
  801c3b:	90                   	nop
  801c3c:	89 fd                	mov    %edi,%ebp
  801c3e:	85 ff                	test   %edi,%edi
  801c40:	75 0b                	jne    801c4d <__umoddi3+0xe9>
  801c42:	b8 01 00 00 00       	mov    $0x1,%eax
  801c47:	31 d2                	xor    %edx,%edx
  801c49:	f7 f7                	div    %edi
  801c4b:	89 c5                	mov    %eax,%ebp
  801c4d:	89 f0                	mov    %esi,%eax
  801c4f:	31 d2                	xor    %edx,%edx
  801c51:	f7 f5                	div    %ebp
  801c53:	89 c8                	mov    %ecx,%eax
  801c55:	f7 f5                	div    %ebp
  801c57:	89 d0                	mov    %edx,%eax
  801c59:	e9 44 ff ff ff       	jmp    801ba2 <__umoddi3+0x3e>
  801c5e:	66 90                	xchg   %ax,%ax
  801c60:	89 c8                	mov    %ecx,%eax
  801c62:	89 f2                	mov    %esi,%edx
  801c64:	83 c4 1c             	add    $0x1c,%esp
  801c67:	5b                   	pop    %ebx
  801c68:	5e                   	pop    %esi
  801c69:	5f                   	pop    %edi
  801c6a:	5d                   	pop    %ebp
  801c6b:	c3                   	ret    
  801c6c:	3b 04 24             	cmp    (%esp),%eax
  801c6f:	72 06                	jb     801c77 <__umoddi3+0x113>
  801c71:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c75:	77 0f                	ja     801c86 <__umoddi3+0x122>
  801c77:	89 f2                	mov    %esi,%edx
  801c79:	29 f9                	sub    %edi,%ecx
  801c7b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7f:	89 14 24             	mov    %edx,(%esp)
  801c82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c86:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c8a:	8b 14 24             	mov    (%esp),%edx
  801c8d:	83 c4 1c             	add    $0x1c,%esp
  801c90:	5b                   	pop    %ebx
  801c91:	5e                   	pop    %esi
  801c92:	5f                   	pop    %edi
  801c93:	5d                   	pop    %ebp
  801c94:	c3                   	ret    
  801c95:	8d 76 00             	lea    0x0(%esi),%esi
  801c98:	2b 04 24             	sub    (%esp),%eax
  801c9b:	19 fa                	sbb    %edi,%edx
  801c9d:	89 d1                	mov    %edx,%ecx
  801c9f:	89 c6                	mov    %eax,%esi
  801ca1:	e9 71 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
  801ca6:	66 90                	xchg   %ax,%ax
  801ca8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cac:	72 ea                	jb     801c98 <__umoddi3+0x134>
  801cae:	89 d9                	mov    %ebx,%ecx
  801cb0:	e9 62 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
