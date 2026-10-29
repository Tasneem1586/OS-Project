
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 e0 1f 80 00       	push   $0x801fe0
  80005e:	e8 90 0b 00 00       	call   800bf3 <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 92 10 00 00       	call   80110b <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 ef 19 00 00       	call   801a7b <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 fc 1f 80 00       	push   $0x801ffc
  80009e:	e8 50 0b 00 00       	call   800bf3 <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 52 10 00 00       	call   80110b <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 19 20 80 00       	push   $0x802019
  8000d0:	e8 b8 03 00 00       	call   80048d <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	57                   	push   %edi
  8000df:	56                   	push   %esi
  8000e0:	53                   	push   %ebx
  8000e1:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000e7:	e8 03 17 00 00       	call   8017ef <sys_getenvindex>
  8000ec:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	c1 e0 03             	shl    $0x3,%eax
  8000f7:	01 d0                	add    %edx,%eax
  8000f9:	c1 e0 06             	shl    $0x6,%eax
  8000fc:	01 d0                	add    %edx,%eax
  8000fe:	c1 e0 03             	shl    $0x3,%eax
  800101:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800106:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80010b:	a1 20 30 80 00       	mov    0x803020,%eax
  800110:	8a 40 10             	mov    0x10(%eax),%al
  800113:	84 c0                	test   %al,%al
  800115:	74 0d                	je     800124 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800117:	a1 20 30 80 00       	mov    0x803020,%eax
  80011c:	83 c0 10             	add    $0x10,%eax
  80011f:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800124:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800128:	7e 0a                	jle    800134 <libmain+0x59>
		binaryname = argv[0];
  80012a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012d:	8b 00                	mov    (%eax),%eax
  80012f:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800134:	83 ec 08             	sub    $0x8,%esp
  800137:	ff 75 0c             	pushl  0xc(%ebp)
  80013a:	ff 75 08             	pushl  0x8(%ebp)
  80013d:	e8 f6 fe ff ff       	call   800038 <_main>
  800142:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800145:	a1 00 30 80 00       	mov    0x803000,%eax
  80014a:	85 c0                	test   %eax,%eax
  80014c:	0f 84 b7 01 00 00    	je     800309 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800152:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800158:	bb 70 21 80 00       	mov    $0x802170,%ebx
  80015d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800162:	89 c7                	mov    %eax,%edi
  800164:	89 de                	mov    %ebx,%esi
  800166:	89 d1                	mov    %edx,%ecx
  800168:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80016a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800170:	b9 56 00 00 00       	mov    $0x56,%ecx
  800175:	b0 00                	mov    $0x0,%al
  800177:	89 d7                	mov    %edx,%edi
  800179:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80017b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800182:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800185:	83 ec 08             	sub    $0x8,%esp
  800188:	50                   	push   %eax
  800189:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80018f:	50                   	push   %eax
  800190:	e8 5a 18 00 00       	call   8019ef <sys_utilities>
  800195:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800198:	e8 da 13 00 00       	call   801577 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80019d:	83 ec 0c             	sub    $0xc,%esp
  8001a0:	68 4c 20 80 00       	push   $0x80204c
  8001a5:	e8 71 02 00 00       	call   80041b <cprintf>
  8001aa:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8001ad:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001b0:	85 c0                	test   %eax,%eax
  8001b2:	74 58                	je     80020c <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001b4:	e8 54 18 00 00       	call   801a0d <sys_get_optimal_num_faults>
  8001b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001bc:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001c2:	bb d4 21 80 00       	mov    $0x8021d4,%ebx
  8001c7:	ba 11 00 00 00       	mov    $0x11,%edx
  8001cc:	89 c7                	mov    %eax,%edi
  8001ce:	89 de                	mov    %ebx,%esi
  8001d0:	89 d1                	mov    %edx,%ecx
  8001d2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001d4:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001d7:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001dc:	b0 00                	mov    $0x0,%al
  8001de:	89 d7                	mov    %edx,%edi
  8001e0:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001e2:	83 ec 08             	sub    $0x8,%esp
  8001e5:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e8:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001ee:	50                   	push   %eax
  8001ef:	e8 fb 17 00 00       	call   8019ef <sys_utilities>
  8001f4:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001f7:	83 ec 08             	sub    $0x8,%esp
  8001fa:	ff 75 dc             	pushl  -0x24(%ebp)
  8001fd:	68 74 20 80 00       	push   $0x802074
  800202:	e8 14 02 00 00       	call   80041b <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	eb 59                	jmp    800265 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80020c:	a1 20 30 80 00       	mov    0x803020,%eax
  800211:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800217:	a1 20 30 80 00       	mov    0x803020,%eax
  80021c:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	52                   	push   %edx
  800226:	50                   	push   %eax
  800227:	68 98 20 80 00       	push   $0x802098
  80022c:	e8 ea 01 00 00       	call   80041b <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800234:	a1 20 30 80 00       	mov    0x803020,%eax
  800239:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80023f:	a1 20 30 80 00       	mov    0x803020,%eax
  800244:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80024a:	a1 20 30 80 00       	mov    0x803020,%eax
  80024f:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800255:	51                   	push   %ecx
  800256:	52                   	push   %edx
  800257:	50                   	push   %eax
  800258:	68 c0 20 80 00       	push   $0x8020c0
  80025d:	e8 b9 01 00 00       	call   80041b <cprintf>
  800262:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800265:	a1 20 30 80 00       	mov    0x803020,%eax
  80026a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800270:	83 ec 08             	sub    $0x8,%esp
  800273:	50                   	push   %eax
  800274:	68 18 21 80 00       	push   $0x802118
  800279:	e8 9d 01 00 00       	call   80041b <cprintf>
  80027e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800281:	83 ec 0c             	sub    $0xc,%esp
  800284:	68 2c 21 80 00       	push   $0x80212c
  800289:	e8 8d 01 00 00       	call   80041b <cprintf>
  80028e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800291:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800298:	eb 28                	jmp    8002c2 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80029a:	a1 20 30 80 00       	mov    0x803020,%eax
  80029f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002a2:	81 c2 74 04 00 00    	add    $0x474,%edx
  8002a8:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	50                   	push   %eax
  8002af:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002b2:	68 43 21 80 00       	push   $0x802143
  8002b7:	e8 5f 01 00 00       	call   80041b <cprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002bf:	ff 45 e4             	incl   -0x1c(%ebp)
  8002c2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002c6:	7e d2                	jle    80029a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002c8:	83 ec 0c             	sub    $0xc,%esp
  8002cb:	68 52 21 80 00       	push   $0x802152
  8002d0:	e8 46 01 00 00       	call   80041b <cprintf>
  8002d5:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dd:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002e3:	83 ec 08             	sub    $0x8,%esp
  8002e6:	50                   	push   %eax
  8002e7:	68 56 21 80 00       	push   $0x802156
  8002ec:	e8 2a 01 00 00       	call   80041b <cprintf>
  8002f1:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	68 4c 20 80 00       	push   $0x80204c
  8002fc:	e8 1a 01 00 00       	call   80041b <cprintf>
  800301:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800304:	e8 88 12 00 00       	call   801591 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800309:	e8 1f 00 00 00       	call   80032d <exit>
}
  80030e:	90                   	nop
  80030f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800312:	5b                   	pop    %ebx
  800313:	5e                   	pop    %esi
  800314:	5f                   	pop    %edi
  800315:	5d                   	pop    %ebp
  800316:	c3                   	ret    

00800317 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800317:	55                   	push   %ebp
  800318:	89 e5                	mov    %esp,%ebp
  80031a:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	6a 00                	push   $0x0
  800322:	e8 94 14 00 00       	call   8017bb <sys_destroy_env>
  800327:	83 c4 10             	add    $0x10,%esp
}
  80032a:	90                   	nop
  80032b:	c9                   	leave  
  80032c:	c3                   	ret    

0080032d <exit>:

void
exit(void)
{
  80032d:	55                   	push   %ebp
  80032e:	89 e5                	mov    %esp,%ebp
  800330:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800333:	e8 e9 14 00 00       	call   801821 <sys_exit_env>
}
  800338:	90                   	nop
  800339:	c9                   	leave  
  80033a:	c3                   	ret    

0080033b <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80033b:	55                   	push   %ebp
  80033c:	89 e5                	mov    %esp,%ebp
  80033e:	53                   	push   %ebx
  80033f:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800342:	8b 45 0c             	mov    0xc(%ebp),%eax
  800345:	8b 00                	mov    (%eax),%eax
  800347:	8d 48 01             	lea    0x1(%eax),%ecx
  80034a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80034d:	89 0a                	mov    %ecx,(%edx)
  80034f:	8b 55 08             	mov    0x8(%ebp),%edx
  800352:	88 d1                	mov    %dl,%cl
  800354:	8b 55 0c             	mov    0xc(%ebp),%edx
  800357:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80035b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035e:	8b 00                	mov    (%eax),%eax
  800360:	3d ff 00 00 00       	cmp    $0xff,%eax
  800365:	75 30                	jne    800397 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800367:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80036d:	a0 40 30 80 00       	mov    0x803040,%al
  800372:	0f b6 c0             	movzbl %al,%eax
  800375:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800378:	8b 09                	mov    (%ecx),%ecx
  80037a:	89 cb                	mov    %ecx,%ebx
  80037c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80037f:	83 c1 08             	add    $0x8,%ecx
  800382:	52                   	push   %edx
  800383:	50                   	push   %eax
  800384:	53                   	push   %ebx
  800385:	51                   	push   %ecx
  800386:	e8 a8 11 00 00       	call   801533 <sys_cputs>
  80038b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80038e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800391:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039a:	8b 40 04             	mov    0x4(%eax),%eax
  80039d:	8d 50 01             	lea    0x1(%eax),%edx
  8003a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003a6:	90                   	nop
  8003a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003aa:	c9                   	leave  
  8003ab:	c3                   	ret    

008003ac <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003ac:	55                   	push   %ebp
  8003ad:	89 e5                	mov    %esp,%ebp
  8003af:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003b5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003bc:	00 00 00 
	b.cnt = 0;
  8003bf:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003c6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003c9:	ff 75 0c             	pushl  0xc(%ebp)
  8003cc:	ff 75 08             	pushl  0x8(%ebp)
  8003cf:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003d5:	50                   	push   %eax
  8003d6:	68 3b 03 80 00       	push   $0x80033b
  8003db:	e8 5a 02 00 00       	call   80063a <vprintfmt>
  8003e0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003e3:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003e9:	a0 40 30 80 00       	mov    0x803040,%al
  8003ee:	0f b6 c0             	movzbl %al,%eax
  8003f1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003f7:	52                   	push   %edx
  8003f8:	50                   	push   %eax
  8003f9:	51                   	push   %ecx
  8003fa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800400:	83 c0 08             	add    $0x8,%eax
  800403:	50                   	push   %eax
  800404:	e8 2a 11 00 00       	call   801533 <sys_cputs>
  800409:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80040c:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800413:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800419:	c9                   	leave  
  80041a:	c3                   	ret    

0080041b <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80041b:	55                   	push   %ebp
  80041c:	89 e5                	mov    %esp,%ebp
  80041e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800421:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800428:	8d 45 0c             	lea    0xc(%ebp),%eax
  80042b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	83 ec 08             	sub    $0x8,%esp
  800434:	ff 75 f4             	pushl  -0xc(%ebp)
  800437:	50                   	push   %eax
  800438:	e8 6f ff ff ff       	call   8003ac <vcprintf>
  80043d:	83 c4 10             	add    $0x10,%esp
  800440:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800443:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800446:	c9                   	leave  
  800447:	c3                   	ret    

00800448 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800448:	55                   	push   %ebp
  800449:	89 e5                	mov    %esp,%ebp
  80044b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80044e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	c1 e0 08             	shl    $0x8,%eax
  80045b:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800460:	8d 45 0c             	lea    0xc(%ebp),%eax
  800463:	83 c0 04             	add    $0x4,%eax
  800466:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046c:	83 ec 08             	sub    $0x8,%esp
  80046f:	ff 75 f4             	pushl  -0xc(%ebp)
  800472:	50                   	push   %eax
  800473:	e8 34 ff ff ff       	call   8003ac <vcprintf>
  800478:	83 c4 10             	add    $0x10,%esp
  80047b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80047e:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800485:	07 00 00 

	return cnt;
  800488:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800493:	e8 df 10 00 00       	call   801577 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800498:	8d 45 0c             	lea    0xc(%ebp),%eax
  80049b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	83 ec 08             	sub    $0x8,%esp
  8004a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8004a7:	50                   	push   %eax
  8004a8:	e8 ff fe ff ff       	call   8003ac <vcprintf>
  8004ad:	83 c4 10             	add    $0x10,%esp
  8004b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004b3:	e8 d9 10 00 00       	call   801591 <sys_unlock_cons>
	return cnt;
  8004b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004bb:	c9                   	leave  
  8004bc:	c3                   	ret    

008004bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004bd:	55                   	push   %ebp
  8004be:	89 e5                	mov    %esp,%ebp
  8004c0:	53                   	push   %ebx
  8004c1:	83 ec 14             	sub    $0x14,%esp
  8004c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8004cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8004d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004db:	77 55                	ja     800532 <printnum+0x75>
  8004dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e0:	72 05                	jb     8004e7 <printnum+0x2a>
  8004e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004e5:	77 4b                	ja     800532 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8004f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8004f5:	52                   	push   %edx
  8004f6:	50                   	push   %eax
  8004f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8004fd:	e8 6a 18 00 00       	call   801d6c <__udivdi3>
  800502:	83 c4 10             	add    $0x10,%esp
  800505:	83 ec 04             	sub    $0x4,%esp
  800508:	ff 75 20             	pushl  0x20(%ebp)
  80050b:	53                   	push   %ebx
  80050c:	ff 75 18             	pushl  0x18(%ebp)
  80050f:	52                   	push   %edx
  800510:	50                   	push   %eax
  800511:	ff 75 0c             	pushl  0xc(%ebp)
  800514:	ff 75 08             	pushl  0x8(%ebp)
  800517:	e8 a1 ff ff ff       	call   8004bd <printnum>
  80051c:	83 c4 20             	add    $0x20,%esp
  80051f:	eb 1a                	jmp    80053b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800521:	83 ec 08             	sub    $0x8,%esp
  800524:	ff 75 0c             	pushl  0xc(%ebp)
  800527:	ff 75 20             	pushl  0x20(%ebp)
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	ff d0                	call   *%eax
  80052f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800532:	ff 4d 1c             	decl   0x1c(%ebp)
  800535:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800539:	7f e6                	jg     800521 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80053b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80053e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800543:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800546:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800549:	53                   	push   %ebx
  80054a:	51                   	push   %ecx
  80054b:	52                   	push   %edx
  80054c:	50                   	push   %eax
  80054d:	e8 2a 19 00 00       	call   801e7c <__umoddi3>
  800552:	83 c4 10             	add    $0x10,%esp
  800555:	05 54 24 80 00       	add    $0x802454,%eax
  80055a:	8a 00                	mov    (%eax),%al
  80055c:	0f be c0             	movsbl %al,%eax
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	ff 75 0c             	pushl  0xc(%ebp)
  800565:	50                   	push   %eax
  800566:	8b 45 08             	mov    0x8(%ebp),%eax
  800569:	ff d0                	call   *%eax
  80056b:	83 c4 10             	add    $0x10,%esp
}
  80056e:	90                   	nop
  80056f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800572:	c9                   	leave  
  800573:	c3                   	ret    

00800574 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800574:	55                   	push   %ebp
  800575:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800577:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80057b:	7e 1c                	jle    800599 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80057d:	8b 45 08             	mov    0x8(%ebp),%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	8d 50 08             	lea    0x8(%eax),%edx
  800585:	8b 45 08             	mov    0x8(%ebp),%eax
  800588:	89 10                	mov    %edx,(%eax)
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	83 e8 08             	sub    $0x8,%eax
  800592:	8b 50 04             	mov    0x4(%eax),%edx
  800595:	8b 00                	mov    (%eax),%eax
  800597:	eb 40                	jmp    8005d9 <getuint+0x65>
	else if (lflag)
  800599:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80059d:	74 1e                	je     8005bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	8b 00                	mov    (%eax),%eax
  8005a4:	8d 50 04             	lea    0x4(%eax),%edx
  8005a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005aa:	89 10                	mov    %edx,(%eax)
  8005ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8005af:	8b 00                	mov    (%eax),%eax
  8005b1:	83 e8 04             	sub    $0x4,%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8005bb:	eb 1c                	jmp    8005d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	8d 50 04             	lea    0x4(%eax),%edx
  8005c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c8:	89 10                	mov    %edx,(%eax)
  8005ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cd:	8b 00                	mov    (%eax),%eax
  8005cf:	83 e8 04             	sub    $0x4,%eax
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005d9:	5d                   	pop    %ebp
  8005da:	c3                   	ret    

008005db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005db:	55                   	push   %ebp
  8005dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005e2:	7e 1c                	jle    800600 <getint+0x25>
		return va_arg(*ap, long long);
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	8b 00                	mov    (%eax),%eax
  8005e9:	8d 50 08             	lea    0x8(%eax),%edx
  8005ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ef:	89 10                	mov    %edx,(%eax)
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	8b 00                	mov    (%eax),%eax
  8005f6:	83 e8 08             	sub    $0x8,%eax
  8005f9:	8b 50 04             	mov    0x4(%eax),%edx
  8005fc:	8b 00                	mov    (%eax),%eax
  8005fe:	eb 38                	jmp    800638 <getint+0x5d>
	else if (lflag)
  800600:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800604:	74 1a                	je     800620 <getint+0x45>
		return va_arg(*ap, long);
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	8b 00                	mov    (%eax),%eax
  80060b:	8d 50 04             	lea    0x4(%eax),%edx
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	89 10                	mov    %edx,(%eax)
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	83 e8 04             	sub    $0x4,%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	99                   	cltd   
  80061e:	eb 18                	jmp    800638 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800620:	8b 45 08             	mov    0x8(%ebp),%eax
  800623:	8b 00                	mov    (%eax),%eax
  800625:	8d 50 04             	lea    0x4(%eax),%edx
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	89 10                	mov    %edx,(%eax)
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	8b 00                	mov    (%eax),%eax
  800632:	83 e8 04             	sub    $0x4,%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	99                   	cltd   
}
  800638:	5d                   	pop    %ebp
  800639:	c3                   	ret    

0080063a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80063a:	55                   	push   %ebp
  80063b:	89 e5                	mov    %esp,%ebp
  80063d:	56                   	push   %esi
  80063e:	53                   	push   %ebx
  80063f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800642:	eb 17                	jmp    80065b <vprintfmt+0x21>
			if (ch == '\0')
  800644:	85 db                	test   %ebx,%ebx
  800646:	0f 84 c1 03 00 00    	je     800a0d <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80064c:	83 ec 08             	sub    $0x8,%esp
  80064f:	ff 75 0c             	pushl  0xc(%ebp)
  800652:	53                   	push   %ebx
  800653:	8b 45 08             	mov    0x8(%ebp),%eax
  800656:	ff d0                	call   *%eax
  800658:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80065b:	8b 45 10             	mov    0x10(%ebp),%eax
  80065e:	8d 50 01             	lea    0x1(%eax),%edx
  800661:	89 55 10             	mov    %edx,0x10(%ebp)
  800664:	8a 00                	mov    (%eax),%al
  800666:	0f b6 d8             	movzbl %al,%ebx
  800669:	83 fb 25             	cmp    $0x25,%ebx
  80066c:	75 d6                	jne    800644 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80066e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800672:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800679:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800680:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800687:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80068e:	8b 45 10             	mov    0x10(%ebp),%eax
  800691:	8d 50 01             	lea    0x1(%eax),%edx
  800694:	89 55 10             	mov    %edx,0x10(%ebp)
  800697:	8a 00                	mov    (%eax),%al
  800699:	0f b6 d8             	movzbl %al,%ebx
  80069c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80069f:	83 f8 5b             	cmp    $0x5b,%eax
  8006a2:	0f 87 3d 03 00 00    	ja     8009e5 <vprintfmt+0x3ab>
  8006a8:	8b 04 85 78 24 80 00 	mov    0x802478(,%eax,4),%eax
  8006af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006b5:	eb d7                	jmp    80068e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006bb:	eb d1                	jmp    80068e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c7:	89 d0                	mov    %edx,%eax
  8006c9:	c1 e0 02             	shl    $0x2,%eax
  8006cc:	01 d0                	add    %edx,%eax
  8006ce:	01 c0                	add    %eax,%eax
  8006d0:	01 d8                	add    %ebx,%eax
  8006d2:	83 e8 30             	sub    $0x30,%eax
  8006d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006db:	8a 00                	mov    (%eax),%al
  8006dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8006e3:	7e 3e                	jle    800723 <vprintfmt+0xe9>
  8006e5:	83 fb 39             	cmp    $0x39,%ebx
  8006e8:	7f 39                	jg     800723 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006ed:	eb d5                	jmp    8006c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f2:	83 c0 04             	add    $0x4,%eax
  8006f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fb:	83 e8 04             	sub    $0x4,%eax
  8006fe:	8b 00                	mov    (%eax),%eax
  800700:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800703:	eb 1f                	jmp    800724 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800705:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800709:	79 83                	jns    80068e <vprintfmt+0x54>
				width = 0;
  80070b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800712:	e9 77 ff ff ff       	jmp    80068e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800717:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80071e:	e9 6b ff ff ff       	jmp    80068e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800723:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800724:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800728:	0f 89 60 ff ff ff    	jns    80068e <vprintfmt+0x54>
				width = precision, precision = -1;
  80072e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800731:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800734:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80073b:	e9 4e ff ff ff       	jmp    80068e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800740:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800743:	e9 46 ff ff ff       	jmp    80068e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800748:	8b 45 14             	mov    0x14(%ebp),%eax
  80074b:	83 c0 04             	add    $0x4,%eax
  80074e:	89 45 14             	mov    %eax,0x14(%ebp)
  800751:	8b 45 14             	mov    0x14(%ebp),%eax
  800754:	83 e8 04             	sub    $0x4,%eax
  800757:	8b 00                	mov    (%eax),%eax
  800759:	83 ec 08             	sub    $0x8,%esp
  80075c:	ff 75 0c             	pushl  0xc(%ebp)
  80075f:	50                   	push   %eax
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	ff d0                	call   *%eax
  800765:	83 c4 10             	add    $0x10,%esp
			break;
  800768:	e9 9b 02 00 00       	jmp    800a08 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80076d:	8b 45 14             	mov    0x14(%ebp),%eax
  800770:	83 c0 04             	add    $0x4,%eax
  800773:	89 45 14             	mov    %eax,0x14(%ebp)
  800776:	8b 45 14             	mov    0x14(%ebp),%eax
  800779:	83 e8 04             	sub    $0x4,%eax
  80077c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80077e:	85 db                	test   %ebx,%ebx
  800780:	79 02                	jns    800784 <vprintfmt+0x14a>
				err = -err;
  800782:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800784:	83 fb 64             	cmp    $0x64,%ebx
  800787:	7f 0b                	jg     800794 <vprintfmt+0x15a>
  800789:	8b 34 9d c0 22 80 00 	mov    0x8022c0(,%ebx,4),%esi
  800790:	85 f6                	test   %esi,%esi
  800792:	75 19                	jne    8007ad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800794:	53                   	push   %ebx
  800795:	68 65 24 80 00       	push   $0x802465
  80079a:	ff 75 0c             	pushl  0xc(%ebp)
  80079d:	ff 75 08             	pushl  0x8(%ebp)
  8007a0:	e8 70 02 00 00       	call   800a15 <printfmt>
  8007a5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007a8:	e9 5b 02 00 00       	jmp    800a08 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007ad:	56                   	push   %esi
  8007ae:	68 6e 24 80 00       	push   $0x80246e
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	ff 75 08             	pushl  0x8(%ebp)
  8007b9:	e8 57 02 00 00       	call   800a15 <printfmt>
  8007be:	83 c4 10             	add    $0x10,%esp
			break;
  8007c1:	e9 42 02 00 00       	jmp    800a08 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c9:	83 c0 04             	add    $0x4,%eax
  8007cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8007cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d2:	83 e8 04             	sub    $0x4,%eax
  8007d5:	8b 30                	mov    (%eax),%esi
  8007d7:	85 f6                	test   %esi,%esi
  8007d9:	75 05                	jne    8007e0 <vprintfmt+0x1a6>
				p = "(null)";
  8007db:	be 71 24 80 00       	mov    $0x802471,%esi
			if (width > 0 && padc != '-')
  8007e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007e4:	7e 6d                	jle    800853 <vprintfmt+0x219>
  8007e6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007ea:	74 67                	je     800853 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	50                   	push   %eax
  8007f3:	56                   	push   %esi
  8007f4:	e8 26 05 00 00       	call   800d1f <strnlen>
  8007f9:	83 c4 10             	add    $0x10,%esp
  8007fc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007ff:	eb 16                	jmp    800817 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800801:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	50                   	push   %eax
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	ff d0                	call   *%eax
  800811:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800814:	ff 4d e4             	decl   -0x1c(%ebp)
  800817:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80081b:	7f e4                	jg     800801 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80081d:	eb 34                	jmp    800853 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80081f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800823:	74 1c                	je     800841 <vprintfmt+0x207>
  800825:	83 fb 1f             	cmp    $0x1f,%ebx
  800828:	7e 05                	jle    80082f <vprintfmt+0x1f5>
  80082a:	83 fb 7e             	cmp    $0x7e,%ebx
  80082d:	7e 12                	jle    800841 <vprintfmt+0x207>
					putch('?', putdat);
  80082f:	83 ec 08             	sub    $0x8,%esp
  800832:	ff 75 0c             	pushl  0xc(%ebp)
  800835:	6a 3f                	push   $0x3f
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	ff d0                	call   *%eax
  80083c:	83 c4 10             	add    $0x10,%esp
  80083f:	eb 0f                	jmp    800850 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800841:	83 ec 08             	sub    $0x8,%esp
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	53                   	push   %ebx
  800848:	8b 45 08             	mov    0x8(%ebp),%eax
  80084b:	ff d0                	call   *%eax
  80084d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800850:	ff 4d e4             	decl   -0x1c(%ebp)
  800853:	89 f0                	mov    %esi,%eax
  800855:	8d 70 01             	lea    0x1(%eax),%esi
  800858:	8a 00                	mov    (%eax),%al
  80085a:	0f be d8             	movsbl %al,%ebx
  80085d:	85 db                	test   %ebx,%ebx
  80085f:	74 24                	je     800885 <vprintfmt+0x24b>
  800861:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800865:	78 b8                	js     80081f <vprintfmt+0x1e5>
  800867:	ff 4d e0             	decl   -0x20(%ebp)
  80086a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80086e:	79 af                	jns    80081f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800870:	eb 13                	jmp    800885 <vprintfmt+0x24b>
				putch(' ', putdat);
  800872:	83 ec 08             	sub    $0x8,%esp
  800875:	ff 75 0c             	pushl  0xc(%ebp)
  800878:	6a 20                	push   $0x20
  80087a:	8b 45 08             	mov    0x8(%ebp),%eax
  80087d:	ff d0                	call   *%eax
  80087f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800882:	ff 4d e4             	decl   -0x1c(%ebp)
  800885:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800889:	7f e7                	jg     800872 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80088b:	e9 78 01 00 00       	jmp    800a08 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800890:	83 ec 08             	sub    $0x8,%esp
  800893:	ff 75 e8             	pushl  -0x18(%ebp)
  800896:	8d 45 14             	lea    0x14(%ebp),%eax
  800899:	50                   	push   %eax
  80089a:	e8 3c fd ff ff       	call   8005db <getint>
  80089f:	83 c4 10             	add    $0x10,%esp
  8008a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ae:	85 d2                	test   %edx,%edx
  8008b0:	79 23                	jns    8008d5 <vprintfmt+0x29b>
				putch('-', putdat);
  8008b2:	83 ec 08             	sub    $0x8,%esp
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	6a 2d                	push   $0x2d
  8008ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bd:	ff d0                	call   *%eax
  8008bf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c8:	f7 d8                	neg    %eax
  8008ca:	83 d2 00             	adc    $0x0,%edx
  8008cd:	f7 da                	neg    %edx
  8008cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008d5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008dc:	e9 bc 00 00 00       	jmp    80099d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008e1:	83 ec 08             	sub    $0x8,%esp
  8008e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8008e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ea:	50                   	push   %eax
  8008eb:	e8 84 fc ff ff       	call   800574 <getuint>
  8008f0:	83 c4 10             	add    $0x10,%esp
  8008f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008f9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800900:	e9 98 00 00 00       	jmp    80099d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800905:	83 ec 08             	sub    $0x8,%esp
  800908:	ff 75 0c             	pushl  0xc(%ebp)
  80090b:	6a 58                	push   $0x58
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	ff d0                	call   *%eax
  800912:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	6a 58                	push   $0x58
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	ff d0                	call   *%eax
  800922:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800925:	83 ec 08             	sub    $0x8,%esp
  800928:	ff 75 0c             	pushl  0xc(%ebp)
  80092b:	6a 58                	push   $0x58
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	ff d0                	call   *%eax
  800932:	83 c4 10             	add    $0x10,%esp
			break;
  800935:	e9 ce 00 00 00       	jmp    800a08 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80093a:	83 ec 08             	sub    $0x8,%esp
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	6a 30                	push   $0x30
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	ff d0                	call   *%eax
  800947:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80094a:	83 ec 08             	sub    $0x8,%esp
  80094d:	ff 75 0c             	pushl  0xc(%ebp)
  800950:	6a 78                	push   $0x78
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	ff d0                	call   *%eax
  800957:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80095a:	8b 45 14             	mov    0x14(%ebp),%eax
  80095d:	83 c0 04             	add    $0x4,%eax
  800960:	89 45 14             	mov    %eax,0x14(%ebp)
  800963:	8b 45 14             	mov    0x14(%ebp),%eax
  800966:	83 e8 04             	sub    $0x4,%eax
  800969:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80096b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800975:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80097c:	eb 1f                	jmp    80099d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 e8             	pushl  -0x18(%ebp)
  800984:	8d 45 14             	lea    0x14(%ebp),%eax
  800987:	50                   	push   %eax
  800988:	e8 e7 fb ff ff       	call   800574 <getuint>
  80098d:	83 c4 10             	add    $0x10,%esp
  800990:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800993:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800996:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80099d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009a4:	83 ec 04             	sub    $0x4,%esp
  8009a7:	52                   	push   %edx
  8009a8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009ab:	50                   	push   %eax
  8009ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8009af:	ff 75 f0             	pushl  -0x10(%ebp)
  8009b2:	ff 75 0c             	pushl  0xc(%ebp)
  8009b5:	ff 75 08             	pushl  0x8(%ebp)
  8009b8:	e8 00 fb ff ff       	call   8004bd <printnum>
  8009bd:	83 c4 20             	add    $0x20,%esp
			break;
  8009c0:	eb 46                	jmp    800a08 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009c2:	83 ec 08             	sub    $0x8,%esp
  8009c5:	ff 75 0c             	pushl  0xc(%ebp)
  8009c8:	53                   	push   %ebx
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	ff d0                	call   *%eax
  8009ce:	83 c4 10             	add    $0x10,%esp
			break;
  8009d1:	eb 35                	jmp    800a08 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009d3:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009da:	eb 2c                	jmp    800a08 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009dc:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009e3:	eb 23                	jmp    800a08 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009e5:	83 ec 08             	sub    $0x8,%esp
  8009e8:	ff 75 0c             	pushl  0xc(%ebp)
  8009eb:	6a 25                	push   $0x25
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	ff d0                	call   *%eax
  8009f2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009f5:	ff 4d 10             	decl   0x10(%ebp)
  8009f8:	eb 03                	jmp    8009fd <vprintfmt+0x3c3>
  8009fa:	ff 4d 10             	decl   0x10(%ebp)
  8009fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800a00:	48                   	dec    %eax
  800a01:	8a 00                	mov    (%eax),%al
  800a03:	3c 25                	cmp    $0x25,%al
  800a05:	75 f3                	jne    8009fa <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a07:	90                   	nop
		}
	}
  800a08:	e9 35 fc ff ff       	jmp    800642 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a0d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a11:	5b                   	pop    %ebx
  800a12:	5e                   	pop    %esi
  800a13:	5d                   	pop    %ebp
  800a14:	c3                   	ret    

00800a15 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a15:	55                   	push   %ebp
  800a16:	89 e5                	mov    %esp,%ebp
  800a18:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a1b:	8d 45 10             	lea    0x10(%ebp),%eax
  800a1e:	83 c0 04             	add    $0x4,%eax
  800a21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a24:	8b 45 10             	mov    0x10(%ebp),%eax
  800a27:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2a:	50                   	push   %eax
  800a2b:	ff 75 0c             	pushl  0xc(%ebp)
  800a2e:	ff 75 08             	pushl  0x8(%ebp)
  800a31:	e8 04 fc ff ff       	call   80063a <vprintfmt>
  800a36:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a39:	90                   	nop
  800a3a:	c9                   	leave  
  800a3b:	c3                   	ret    

00800a3c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a3c:	55                   	push   %ebp
  800a3d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	8b 40 08             	mov    0x8(%eax),%eax
  800a45:	8d 50 01             	lea    0x1(%eax),%edx
  800a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a51:	8b 10                	mov    (%eax),%edx
  800a53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a56:	8b 40 04             	mov    0x4(%eax),%eax
  800a59:	39 c2                	cmp    %eax,%edx
  800a5b:	73 12                	jae    800a6f <sprintputch+0x33>
		*b->buf++ = ch;
  800a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a60:	8b 00                	mov    (%eax),%eax
  800a62:	8d 48 01             	lea    0x1(%eax),%ecx
  800a65:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a68:	89 0a                	mov    %ecx,(%edx)
  800a6a:	8b 55 08             	mov    0x8(%ebp),%edx
  800a6d:	88 10                	mov    %dl,(%eax)
}
  800a6f:	90                   	nop
  800a70:	5d                   	pop    %ebp
  800a71:	c3                   	ret    

00800a72 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
  800a75:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	01 d0                	add    %edx,%eax
  800a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a93:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a97:	74 06                	je     800a9f <vsnprintf+0x2d>
  800a99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a9d:	7f 07                	jg     800aa6 <vsnprintf+0x34>
		return -E_INVAL;
  800a9f:	b8 03 00 00 00       	mov    $0x3,%eax
  800aa4:	eb 20                	jmp    800ac6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800aa6:	ff 75 14             	pushl  0x14(%ebp)
  800aa9:	ff 75 10             	pushl  0x10(%ebp)
  800aac:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aaf:	50                   	push   %eax
  800ab0:	68 3c 0a 80 00       	push   $0x800a3c
  800ab5:	e8 80 fb ff ff       	call   80063a <vprintfmt>
  800aba:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800abd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ac0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ac3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ac6:	c9                   	leave  
  800ac7:	c3                   	ret    

00800ac8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ac8:	55                   	push   %ebp
  800ac9:	89 e5                	mov    %esp,%ebp
  800acb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ace:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad1:	83 c0 04             	add    $0x4,%eax
  800ad4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ad7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ada:	ff 75 f4             	pushl  -0xc(%ebp)
  800add:	50                   	push   %eax
  800ade:	ff 75 0c             	pushl  0xc(%ebp)
  800ae1:	ff 75 08             	pushl  0x8(%ebp)
  800ae4:	e8 89 ff ff ff       	call   800a72 <vsnprintf>
  800ae9:	83 c4 10             	add    $0x10,%esp
  800aec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800aef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
  800af7:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  800afa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800afe:	74 13                	je     800b13 <readline+0x1f>
		cprintf("%s", prompt);
  800b00:	83 ec 08             	sub    $0x8,%esp
  800b03:	ff 75 08             	pushl  0x8(%ebp)
  800b06:	68 e8 25 80 00       	push   $0x8025e8
  800b0b:	e8 0b f9 ff ff       	call   80041b <cprintf>
  800b10:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800b13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800b1a:	83 ec 0c             	sub    $0xc,%esp
  800b1d:	6a 00                	push   $0x0
  800b1f:	e8 4d 10 00 00       	call   801b71 <iscons>
  800b24:	83 c4 10             	add    $0x10,%esp
  800b27:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800b2a:	e8 29 10 00 00       	call   801b58 <getchar>
  800b2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800b32:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b36:	79 22                	jns    800b5a <readline+0x66>
			if (c != -E_EOF)
  800b38:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800b3c:	0f 84 ad 00 00 00    	je     800bef <readline+0xfb>
				cprintf("read error: %e\n", c);
  800b42:	83 ec 08             	sub    $0x8,%esp
  800b45:	ff 75 ec             	pushl  -0x14(%ebp)
  800b48:	68 eb 25 80 00       	push   $0x8025eb
  800b4d:	e8 c9 f8 ff ff       	call   80041b <cprintf>
  800b52:	83 c4 10             	add    $0x10,%esp
			break;
  800b55:	e9 95 00 00 00       	jmp    800bef <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800b5a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800b5e:	7e 34                	jle    800b94 <readline+0xa0>
  800b60:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800b67:	7f 2b                	jg     800b94 <readline+0xa0>
			if (echoing)
  800b69:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b6d:	74 0e                	je     800b7d <readline+0x89>
				cputchar(c);
  800b6f:	83 ec 0c             	sub    $0xc,%esp
  800b72:	ff 75 ec             	pushl  -0x14(%ebp)
  800b75:	e8 bf 0f 00 00       	call   801b39 <cputchar>
  800b7a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b80:	8d 50 01             	lea    0x1(%eax),%edx
  800b83:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b86:	89 c2                	mov    %eax,%edx
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	01 d0                	add    %edx,%eax
  800b8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b90:	88 10                	mov    %dl,(%eax)
  800b92:	eb 56                	jmp    800bea <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800b94:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b98:	75 1f                	jne    800bb9 <readline+0xc5>
  800b9a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b9e:	7e 19                	jle    800bb9 <readline+0xc5>
			if (echoing)
  800ba0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ba4:	74 0e                	je     800bb4 <readline+0xc0>
				cputchar(c);
  800ba6:	83 ec 0c             	sub    $0xc,%esp
  800ba9:	ff 75 ec             	pushl  -0x14(%ebp)
  800bac:	e8 88 0f 00 00       	call   801b39 <cputchar>
  800bb1:	83 c4 10             	add    $0x10,%esp

			i--;
  800bb4:	ff 4d f4             	decl   -0xc(%ebp)
  800bb7:	eb 31                	jmp    800bea <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800bb9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800bbd:	74 0a                	je     800bc9 <readline+0xd5>
  800bbf:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800bc3:	0f 85 61 ff ff ff    	jne    800b2a <readline+0x36>
			if (echoing)
  800bc9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bcd:	74 0e                	je     800bdd <readline+0xe9>
				cputchar(c);
  800bcf:	83 ec 0c             	sub    $0xc,%esp
  800bd2:	ff 75 ec             	pushl  -0x14(%ebp)
  800bd5:	e8 5f 0f 00 00       	call   801b39 <cputchar>
  800bda:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800bdd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	c6 00 00             	movb   $0x0,(%eax)
			break;
  800be8:	eb 06                	jmp    800bf0 <readline+0xfc>
		}
	}
  800bea:	e9 3b ff ff ff       	jmp    800b2a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  800bef:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  800bf0:	90                   	nop
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
  800bf6:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  800bf9:	e8 79 09 00 00       	call   801577 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  800bfe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c02:	74 13                	je     800c17 <atomic_readline+0x24>
			cprintf("%s", prompt);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 08             	pushl  0x8(%ebp)
  800c0a:	68 e8 25 80 00       	push   $0x8025e8
  800c0f:	e8 07 f8 ff ff       	call   80041b <cprintf>
  800c14:	83 c4 10             	add    $0x10,%esp

		i = 0;
  800c17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  800c1e:	83 ec 0c             	sub    $0xc,%esp
  800c21:	6a 00                	push   $0x0
  800c23:	e8 49 0f 00 00       	call   801b71 <iscons>
  800c28:	83 c4 10             	add    $0x10,%esp
  800c2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  800c2e:	e8 25 0f 00 00       	call   801b58 <getchar>
  800c33:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  800c36:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c3a:	79 22                	jns    800c5e <atomic_readline+0x6b>
				if (c != -E_EOF)
  800c3c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c40:	0f 84 ad 00 00 00    	je     800cf3 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  800c46:	83 ec 08             	sub    $0x8,%esp
  800c49:	ff 75 ec             	pushl  -0x14(%ebp)
  800c4c:	68 eb 25 80 00       	push   $0x8025eb
  800c51:	e8 c5 f7 ff ff       	call   80041b <cprintf>
  800c56:	83 c4 10             	add    $0x10,%esp
				break;
  800c59:	e9 95 00 00 00       	jmp    800cf3 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  800c5e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c62:	7e 34                	jle    800c98 <atomic_readline+0xa5>
  800c64:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c6b:	7f 2b                	jg     800c98 <atomic_readline+0xa5>
				if (echoing)
  800c6d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c71:	74 0e                	je     800c81 <atomic_readline+0x8e>
					cputchar(c);
  800c73:	83 ec 0c             	sub    $0xc,%esp
  800c76:	ff 75 ec             	pushl  -0x14(%ebp)
  800c79:	e8 bb 0e 00 00       	call   801b39 <cputchar>
  800c7e:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  800c81:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c84:	8d 50 01             	lea    0x1(%eax),%edx
  800c87:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800c8a:	89 c2                	mov    %eax,%edx
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	01 d0                	add    %edx,%eax
  800c91:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800c94:	88 10                	mov    %dl,(%eax)
  800c96:	eb 56                	jmp    800cee <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  800c98:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800c9c:	75 1f                	jne    800cbd <atomic_readline+0xca>
  800c9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ca2:	7e 19                	jle    800cbd <atomic_readline+0xca>
				if (echoing)
  800ca4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ca8:	74 0e                	je     800cb8 <atomic_readline+0xc5>
					cputchar(c);
  800caa:	83 ec 0c             	sub    $0xc,%esp
  800cad:	ff 75 ec             	pushl  -0x14(%ebp)
  800cb0:	e8 84 0e 00 00       	call   801b39 <cputchar>
  800cb5:	83 c4 10             	add    $0x10,%esp
				i--;
  800cb8:	ff 4d f4             	decl   -0xc(%ebp)
  800cbb:	eb 31                	jmp    800cee <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  800cbd:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800cc1:	74 0a                	je     800ccd <atomic_readline+0xda>
  800cc3:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800cc7:	0f 85 61 ff ff ff    	jne    800c2e <atomic_readline+0x3b>
				if (echoing)
  800ccd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cd1:	74 0e                	je     800ce1 <atomic_readline+0xee>
					cputchar(c);
  800cd3:	83 ec 0c             	sub    $0xc,%esp
  800cd6:	ff 75 ec             	pushl  -0x14(%ebp)
  800cd9:	e8 5b 0e 00 00       	call   801b39 <cputchar>
  800cde:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  800ce1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce7:	01 d0                	add    %edx,%eax
  800ce9:	c6 00 00             	movb   $0x0,(%eax)
				break;
  800cec:	eb 06                	jmp    800cf4 <atomic_readline+0x101>
			}
		}
  800cee:	e9 3b ff ff ff       	jmp    800c2e <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  800cf3:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  800cf4:	e8 98 08 00 00       	call   801591 <sys_unlock_cons>
}
  800cf9:	90                   	nop
  800cfa:	c9                   	leave  
  800cfb:	c3                   	ret    

00800cfc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cfc:	55                   	push   %ebp
  800cfd:	89 e5                	mov    %esp,%ebp
  800cff:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d09:	eb 06                	jmp    800d11 <strlen+0x15>
		n++;
  800d0b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d0e:	ff 45 08             	incl   0x8(%ebp)
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	84 c0                	test   %al,%al
  800d18:	75 f1                	jne    800d0b <strlen+0xf>
		n++;
	return n;
  800d1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d1d:	c9                   	leave  
  800d1e:	c3                   	ret    

00800d1f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
  800d22:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d2c:	eb 09                	jmp    800d37 <strnlen+0x18>
		n++;
  800d2e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d31:	ff 45 08             	incl   0x8(%ebp)
  800d34:	ff 4d 0c             	decl   0xc(%ebp)
  800d37:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d3b:	74 09                	je     800d46 <strnlen+0x27>
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	84 c0                	test   %al,%al
  800d44:	75 e8                	jne    800d2e <strnlen+0xf>
		n++;
	return n;
  800d46:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d49:	c9                   	leave  
  800d4a:	c3                   	ret    

00800d4b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d4b:	55                   	push   %ebp
  800d4c:	89 e5                	mov    %esp,%ebp
  800d4e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d57:	90                   	nop
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8d 50 01             	lea    0x1(%eax),%edx
  800d5e:	89 55 08             	mov    %edx,0x8(%ebp)
  800d61:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d64:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d67:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d6a:	8a 12                	mov    (%edx),%dl
  800d6c:	88 10                	mov    %dl,(%eax)
  800d6e:	8a 00                	mov    (%eax),%al
  800d70:	84 c0                	test   %al,%al
  800d72:	75 e4                	jne    800d58 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d77:	c9                   	leave  
  800d78:	c3                   	ret    

00800d79 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
  800d7c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d8c:	eb 1f                	jmp    800dad <strncpy+0x34>
		*dst++ = *src;
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8d 50 01             	lea    0x1(%eax),%edx
  800d94:	89 55 08             	mov    %edx,0x8(%ebp)
  800d97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9a:	8a 12                	mov    (%edx),%dl
  800d9c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da1:	8a 00                	mov    (%eax),%al
  800da3:	84 c0                	test   %al,%al
  800da5:	74 03                	je     800daa <strncpy+0x31>
			src++;
  800da7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800daa:	ff 45 fc             	incl   -0x4(%ebp)
  800dad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800db3:	72 d9                	jb     800d8e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800db5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db8:	c9                   	leave  
  800db9:	c3                   	ret    

00800dba <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dba:	55                   	push   %ebp
  800dbb:	89 e5                	mov    %esp,%ebp
  800dbd:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dca:	74 30                	je     800dfc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dcc:	eb 16                	jmp    800de4 <strlcpy+0x2a>
			*dst++ = *src++;
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8d 50 01             	lea    0x1(%eax),%edx
  800dd4:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dda:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ddd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800de0:	8a 12                	mov    (%edx),%dl
  800de2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800de4:	ff 4d 10             	decl   0x10(%ebp)
  800de7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800deb:	74 09                	je     800df6 <strlcpy+0x3c>
  800ded:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df0:	8a 00                	mov    (%eax),%al
  800df2:	84 c0                	test   %al,%al
  800df4:	75 d8                	jne    800dce <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dfc:	8b 55 08             	mov    0x8(%ebp),%edx
  800dff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e02:	29 c2                	sub    %eax,%edx
  800e04:	89 d0                	mov    %edx,%eax
}
  800e06:	c9                   	leave  
  800e07:	c3                   	ret    

00800e08 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e08:	55                   	push   %ebp
  800e09:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e0b:	eb 06                	jmp    800e13 <strcmp+0xb>
		p++, q++;
  800e0d:	ff 45 08             	incl   0x8(%ebp)
  800e10:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	74 0e                	je     800e2a <strcmp+0x22>
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 10                	mov    (%eax),%dl
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	8a 00                	mov    (%eax),%al
  800e26:	38 c2                	cmp    %al,%dl
  800e28:	74 e3                	je     800e0d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	8a 00                	mov    (%eax),%al
  800e2f:	0f b6 d0             	movzbl %al,%edx
  800e32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e35:	8a 00                	mov    (%eax),%al
  800e37:	0f b6 c0             	movzbl %al,%eax
  800e3a:	29 c2                	sub    %eax,%edx
  800e3c:	89 d0                	mov    %edx,%eax
}
  800e3e:	5d                   	pop    %ebp
  800e3f:	c3                   	ret    

00800e40 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e40:	55                   	push   %ebp
  800e41:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e43:	eb 09                	jmp    800e4e <strncmp+0xe>
		n--, p++, q++;
  800e45:	ff 4d 10             	decl   0x10(%ebp)
  800e48:	ff 45 08             	incl   0x8(%ebp)
  800e4b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e52:	74 17                	je     800e6b <strncmp+0x2b>
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	84 c0                	test   %al,%al
  800e5b:	74 0e                	je     800e6b <strncmp+0x2b>
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	8a 10                	mov    (%eax),%dl
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	38 c2                	cmp    %al,%dl
  800e69:	74 da                	je     800e45 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6f:	75 07                	jne    800e78 <strncmp+0x38>
		return 0;
  800e71:	b8 00 00 00 00       	mov    $0x0,%eax
  800e76:	eb 14                	jmp    800e8c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	0f b6 d0             	movzbl %al,%edx
  800e80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e83:	8a 00                	mov    (%eax),%al
  800e85:	0f b6 c0             	movzbl %al,%eax
  800e88:	29 c2                	sub    %eax,%edx
  800e8a:	89 d0                	mov    %edx,%eax
}
  800e8c:	5d                   	pop    %ebp
  800e8d:	c3                   	ret    

00800e8e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e8e:	55                   	push   %ebp
  800e8f:	89 e5                	mov    %esp,%ebp
  800e91:	83 ec 04             	sub    $0x4,%esp
  800e94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e97:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e9a:	eb 12                	jmp    800eae <strchr+0x20>
		if (*s == c)
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ea4:	75 05                	jne    800eab <strchr+0x1d>
			return (char *) s;
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	eb 11                	jmp    800ebc <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800eab:	ff 45 08             	incl   0x8(%ebp)
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	84 c0                	test   %al,%al
  800eb5:	75 e5                	jne    800e9c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebc:	c9                   	leave  
  800ebd:	c3                   	ret    

00800ebe <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ebe:	55                   	push   %ebp
  800ebf:	89 e5                	mov    %esp,%ebp
  800ec1:	83 ec 04             	sub    $0x4,%esp
  800ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eca:	eb 0d                	jmp    800ed9 <strfind+0x1b>
		if (*s == c)
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	8a 00                	mov    (%eax),%al
  800ed1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed4:	74 0e                	je     800ee4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ed6:	ff 45 08             	incl   0x8(%ebp)
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	84 c0                	test   %al,%al
  800ee0:	75 ea                	jne    800ecc <strfind+0xe>
  800ee2:	eb 01                	jmp    800ee5 <strfind+0x27>
		if (*s == c)
			break;
  800ee4:	90                   	nop
	return (char *) s;
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
  800eed:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800ef6:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800efa:	76 63                	jbe    800f5f <memset+0x75>
		uint64 data_block = c;
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	99                   	cltd   
  800f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f03:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f09:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0c:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f10:	c1 e0 08             	shl    $0x8,%eax
  800f13:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f16:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1f:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f23:	c1 e0 10             	shl    $0x10,%eax
  800f26:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f29:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f32:	89 c2                	mov    %eax,%edx
  800f34:	b8 00 00 00 00       	mov    $0x0,%eax
  800f39:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f3c:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f3f:	eb 18                	jmp    800f59 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f41:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f44:	8d 41 08             	lea    0x8(%ecx),%eax
  800f47:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f50:	89 01                	mov    %eax,(%ecx)
  800f52:	89 51 04             	mov    %edx,0x4(%ecx)
  800f55:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f59:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f5d:	77 e2                	ja     800f41 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f63:	74 23                	je     800f88 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f68:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f6b:	eb 0e                	jmp    800f7b <memset+0x91>
			*p8++ = (uint8)c;
  800f6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f70:	8d 50 01             	lea    0x1(%eax),%edx
  800f73:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f76:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f79:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f81:	89 55 10             	mov    %edx,0x10(%ebp)
  800f84:	85 c0                	test   %eax,%eax
  800f86:	75 e5                	jne    800f6d <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f8b:	c9                   	leave  
  800f8c:	c3                   	ret    

00800f8d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f8d:	55                   	push   %ebp
  800f8e:	89 e5                	mov    %esp,%ebp
  800f90:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f9f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fa3:	76 24                	jbe    800fc9 <memcpy+0x3c>
		while(n >= 8){
  800fa5:	eb 1c                	jmp    800fc3 <memcpy+0x36>
			*d64 = *s64;
  800fa7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800faa:	8b 50 04             	mov    0x4(%eax),%edx
  800fad:	8b 00                	mov    (%eax),%eax
  800faf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fb2:	89 01                	mov    %eax,(%ecx)
  800fb4:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800fb7:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800fbb:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800fbf:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800fc3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fc7:	77 de                	ja     800fa7 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800fc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcd:	74 31                	je     801000 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800fcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800fd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800fdb:	eb 16                	jmp    800ff3 <memcpy+0x66>
			*d8++ = *s8++;
  800fdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe0:	8d 50 01             	lea    0x1(%eax),%edx
  800fe3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fe6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fec:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800fef:	8a 12                	mov    (%edx),%dl
  800ff1:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800ff3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ffc:	85 c0                	test   %eax,%eax
  800ffe:	75 dd                	jne    800fdd <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801003:	c9                   	leave  
  801004:	c3                   	ret    

00801005 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801005:	55                   	push   %ebp
  801006:	89 e5                	mov    %esp,%ebp
  801008:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80100b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801017:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80101d:	73 50                	jae    80106f <memmove+0x6a>
  80101f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801022:	8b 45 10             	mov    0x10(%ebp),%eax
  801025:	01 d0                	add    %edx,%eax
  801027:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80102a:	76 43                	jbe    80106f <memmove+0x6a>
		s += n;
  80102c:	8b 45 10             	mov    0x10(%ebp),%eax
  80102f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801038:	eb 10                	jmp    80104a <memmove+0x45>
			*--d = *--s;
  80103a:	ff 4d f8             	decl   -0x8(%ebp)
  80103d:	ff 4d fc             	decl   -0x4(%ebp)
  801040:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801043:	8a 10                	mov    (%eax),%dl
  801045:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801048:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80104a:	8b 45 10             	mov    0x10(%ebp),%eax
  80104d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801050:	89 55 10             	mov    %edx,0x10(%ebp)
  801053:	85 c0                	test   %eax,%eax
  801055:	75 e3                	jne    80103a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801057:	eb 23                	jmp    80107c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801059:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105c:	8d 50 01             	lea    0x1(%eax),%edx
  80105f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801062:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801065:	8d 4a 01             	lea    0x1(%edx),%ecx
  801068:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80106b:	8a 12                	mov    (%edx),%dl
  80106d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80106f:	8b 45 10             	mov    0x10(%ebp),%eax
  801072:	8d 50 ff             	lea    -0x1(%eax),%edx
  801075:	89 55 10             	mov    %edx,0x10(%ebp)
  801078:	85 c0                	test   %eax,%eax
  80107a:	75 dd                	jne    801059 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80107f:	c9                   	leave  
  801080:	c3                   	ret    

00801081 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801081:	55                   	push   %ebp
  801082:	89 e5                	mov    %esp,%ebp
  801084:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801093:	eb 2a                	jmp    8010bf <memcmp+0x3e>
		if (*s1 != *s2)
  801095:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801098:	8a 10                	mov    (%eax),%dl
  80109a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	38 c2                	cmp    %al,%dl
  8010a1:	74 16                	je     8010b9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	0f b6 d0             	movzbl %al,%edx
  8010ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	0f b6 c0             	movzbl %al,%eax
  8010b3:	29 c2                	sub    %eax,%edx
  8010b5:	89 d0                	mov    %edx,%eax
  8010b7:	eb 18                	jmp    8010d1 <memcmp+0x50>
		s1++, s2++;
  8010b9:	ff 45 fc             	incl   -0x4(%ebp)
  8010bc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8010c8:	85 c0                	test   %eax,%eax
  8010ca:	75 c9                	jne    801095 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
  8010d6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8010dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010df:	01 d0                	add    %edx,%eax
  8010e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010e4:	eb 15                	jmp    8010fb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e9:	8a 00                	mov    (%eax),%al
  8010eb:	0f b6 d0             	movzbl %al,%edx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	0f b6 c0             	movzbl %al,%eax
  8010f4:	39 c2                	cmp    %eax,%edx
  8010f6:	74 0d                	je     801105 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010f8:	ff 45 08             	incl   0x8(%ebp)
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801101:	72 e3                	jb     8010e6 <memfind+0x13>
  801103:	eb 01                	jmp    801106 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801105:	90                   	nop
	return (void *) s;
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801109:	c9                   	leave  
  80110a:	c3                   	ret    

0080110b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
  80110e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801111:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801118:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80111f:	eb 03                	jmp    801124 <strtol+0x19>
		s++;
  801121:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	8a 00                	mov    (%eax),%al
  801129:	3c 20                	cmp    $0x20,%al
  80112b:	74 f4                	je     801121 <strtol+0x16>
  80112d:	8b 45 08             	mov    0x8(%ebp),%eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	3c 09                	cmp    $0x9,%al
  801134:	74 eb                	je     801121 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	3c 2b                	cmp    $0x2b,%al
  80113d:	75 05                	jne    801144 <strtol+0x39>
		s++;
  80113f:	ff 45 08             	incl   0x8(%ebp)
  801142:	eb 13                	jmp    801157 <strtol+0x4c>
	else if (*s == '-')
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	3c 2d                	cmp    $0x2d,%al
  80114b:	75 0a                	jne    801157 <strtol+0x4c>
		s++, neg = 1;
  80114d:	ff 45 08             	incl   0x8(%ebp)
  801150:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801157:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115b:	74 06                	je     801163 <strtol+0x58>
  80115d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801161:	75 20                	jne    801183 <strtol+0x78>
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	3c 30                	cmp    $0x30,%al
  80116a:	75 17                	jne    801183 <strtol+0x78>
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	40                   	inc    %eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	3c 78                	cmp    $0x78,%al
  801174:	75 0d                	jne    801183 <strtol+0x78>
		s += 2, base = 16;
  801176:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80117a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801181:	eb 28                	jmp    8011ab <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801183:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801187:	75 15                	jne    80119e <strtol+0x93>
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	8a 00                	mov    (%eax),%al
  80118e:	3c 30                	cmp    $0x30,%al
  801190:	75 0c                	jne    80119e <strtol+0x93>
		s++, base = 8;
  801192:	ff 45 08             	incl   0x8(%ebp)
  801195:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80119c:	eb 0d                	jmp    8011ab <strtol+0xa0>
	else if (base == 0)
  80119e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a2:	75 07                	jne    8011ab <strtol+0xa0>
		base = 10;
  8011a4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	3c 2f                	cmp    $0x2f,%al
  8011b2:	7e 19                	jle    8011cd <strtol+0xc2>
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	3c 39                	cmp    $0x39,%al
  8011bb:	7f 10                	jg     8011cd <strtol+0xc2>
			dig = *s - '0';
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	0f be c0             	movsbl %al,%eax
  8011c5:	83 e8 30             	sub    $0x30,%eax
  8011c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011cb:	eb 42                	jmp    80120f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3c 60                	cmp    $0x60,%al
  8011d4:	7e 19                	jle    8011ef <strtol+0xe4>
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	3c 7a                	cmp    $0x7a,%al
  8011dd:	7f 10                	jg     8011ef <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	0f be c0             	movsbl %al,%eax
  8011e7:	83 e8 57             	sub    $0x57,%eax
  8011ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ed:	eb 20                	jmp    80120f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	3c 40                	cmp    $0x40,%al
  8011f6:	7e 39                	jle    801231 <strtol+0x126>
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	3c 5a                	cmp    $0x5a,%al
  8011ff:	7f 30                	jg     801231 <strtol+0x126>
			dig = *s - 'A' + 10;
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	0f be c0             	movsbl %al,%eax
  801209:	83 e8 37             	sub    $0x37,%eax
  80120c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80120f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801212:	3b 45 10             	cmp    0x10(%ebp),%eax
  801215:	7d 19                	jge    801230 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801217:	ff 45 08             	incl   0x8(%ebp)
  80121a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801221:	89 c2                	mov    %eax,%edx
  801223:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801226:	01 d0                	add    %edx,%eax
  801228:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80122b:	e9 7b ff ff ff       	jmp    8011ab <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801230:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801231:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801235:	74 08                	je     80123f <strtol+0x134>
		*endptr = (char *) s;
  801237:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123a:	8b 55 08             	mov    0x8(%ebp),%edx
  80123d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80123f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801243:	74 07                	je     80124c <strtol+0x141>
  801245:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801248:	f7 d8                	neg    %eax
  80124a:	eb 03                	jmp    80124f <strtol+0x144>
  80124c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80124f:	c9                   	leave  
  801250:	c3                   	ret    

00801251 <ltostr>:

void
ltostr(long value, char *str)
{
  801251:	55                   	push   %ebp
  801252:	89 e5                	mov    %esp,%ebp
  801254:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80125e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801265:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801269:	79 13                	jns    80127e <ltostr+0x2d>
	{
		neg = 1;
  80126b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801278:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80127b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801286:	99                   	cltd   
  801287:	f7 f9                	idiv   %ecx
  801289:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80128c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128f:	8d 50 01             	lea    0x1(%eax),%edx
  801292:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801295:	89 c2                	mov    %eax,%edx
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80129f:	83 c2 30             	add    $0x30,%edx
  8012a2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012a7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012ac:	f7 e9                	imul   %ecx
  8012ae:	c1 fa 02             	sar    $0x2,%edx
  8012b1:	89 c8                	mov    %ecx,%eax
  8012b3:	c1 f8 1f             	sar    $0x1f,%eax
  8012b6:	29 c2                	sub    %eax,%edx
  8012b8:	89 d0                	mov    %edx,%eax
  8012ba:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c1:	75 bb                	jne    80127e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cd:	48                   	dec    %eax
  8012ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012d5:	74 3d                	je     801314 <ltostr+0xc3>
		start = 1 ;
  8012d7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012de:	eb 34                	jmp    801314 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e6:	01 d0                	add    %edx,%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	01 c2                	add    %eax,%edx
  8012f5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fb:	01 c8                	add    %ecx,%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801301:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	01 c2                	add    %eax,%edx
  801309:	8a 45 eb             	mov    -0x15(%ebp),%al
  80130c:	88 02                	mov    %al,(%edx)
		start++ ;
  80130e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801311:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801314:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801317:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80131a:	7c c4                	jl     8012e0 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80131c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80131f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801322:	01 d0                	add    %edx,%eax
  801324:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801327:	90                   	nop
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
  80132d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801330:	ff 75 08             	pushl  0x8(%ebp)
  801333:	e8 c4 f9 ff ff       	call   800cfc <strlen>
  801338:	83 c4 04             	add    $0x4,%esp
  80133b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80133e:	ff 75 0c             	pushl  0xc(%ebp)
  801341:	e8 b6 f9 ff ff       	call   800cfc <strlen>
  801346:	83 c4 04             	add    $0x4,%esp
  801349:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80134c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801353:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80135a:	eb 17                	jmp    801373 <strcconcat+0x49>
		final[s] = str1[s] ;
  80135c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80135f:	8b 45 10             	mov    0x10(%ebp),%eax
  801362:	01 c2                	add    %eax,%edx
  801364:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	01 c8                	add    %ecx,%eax
  80136c:	8a 00                	mov    (%eax),%al
  80136e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801370:	ff 45 fc             	incl   -0x4(%ebp)
  801373:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801376:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801379:	7c e1                	jl     80135c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80137b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801382:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801389:	eb 1f                	jmp    8013aa <strcconcat+0x80>
		final[s++] = str2[i] ;
  80138b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80138e:	8d 50 01             	lea    0x1(%eax),%edx
  801391:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801394:	89 c2                	mov    %eax,%edx
  801396:	8b 45 10             	mov    0x10(%ebp),%eax
  801399:	01 c2                	add    %eax,%edx
  80139b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80139e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a1:	01 c8                	add    %ecx,%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013a7:	ff 45 f8             	incl   -0x8(%ebp)
  8013aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013b0:	7c d9                	jl     80138b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b8:	01 d0                	add    %edx,%eax
  8013ba:	c6 00 00             	movb   $0x0,(%eax)
}
  8013bd:	90                   	nop
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cf:	8b 00                	mov    (%eax),%eax
  8013d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013db:	01 d0                	add    %edx,%eax
  8013dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013e3:	eb 0c                	jmp    8013f1 <strsplit+0x31>
			*string++ = 0;
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	8d 50 01             	lea    0x1(%eax),%edx
  8013eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ee:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	84 c0                	test   %al,%al
  8013f8:	74 18                	je     801412 <strsplit+0x52>
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	0f be c0             	movsbl %al,%eax
  801402:	50                   	push   %eax
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	e8 83 fa ff ff       	call   800e8e <strchr>
  80140b:	83 c4 08             	add    $0x8,%esp
  80140e:	85 c0                	test   %eax,%eax
  801410:	75 d3                	jne    8013e5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	84 c0                	test   %al,%al
  801419:	74 5a                	je     801475 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80141b:	8b 45 14             	mov    0x14(%ebp),%eax
  80141e:	8b 00                	mov    (%eax),%eax
  801420:	83 f8 0f             	cmp    $0xf,%eax
  801423:	75 07                	jne    80142c <strsplit+0x6c>
		{
			return 0;
  801425:	b8 00 00 00 00       	mov    $0x0,%eax
  80142a:	eb 66                	jmp    801492 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80142c:	8b 45 14             	mov    0x14(%ebp),%eax
  80142f:	8b 00                	mov    (%eax),%eax
  801431:	8d 48 01             	lea    0x1(%eax),%ecx
  801434:	8b 55 14             	mov    0x14(%ebp),%edx
  801437:	89 0a                	mov    %ecx,(%edx)
  801439:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801440:	8b 45 10             	mov    0x10(%ebp),%eax
  801443:	01 c2                	add    %eax,%edx
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80144a:	eb 03                	jmp    80144f <strsplit+0x8f>
			string++;
  80144c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	84 c0                	test   %al,%al
  801456:	74 8b                	je     8013e3 <strsplit+0x23>
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	0f be c0             	movsbl %al,%eax
  801460:	50                   	push   %eax
  801461:	ff 75 0c             	pushl  0xc(%ebp)
  801464:	e8 25 fa ff ff       	call   800e8e <strchr>
  801469:	83 c4 08             	add    $0x8,%esp
  80146c:	85 c0                	test   %eax,%eax
  80146e:	74 dc                	je     80144c <strsplit+0x8c>
			string++;
	}
  801470:	e9 6e ff ff ff       	jmp    8013e3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801475:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801476:	8b 45 14             	mov    0x14(%ebp),%eax
  801479:	8b 00                	mov    (%eax),%eax
  80147b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801482:	8b 45 10             	mov    0x10(%ebp),%eax
  801485:	01 d0                	add    %edx,%eax
  801487:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80148d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
  801497:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8014a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a7:	eb 4a                	jmp    8014f3 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	01 c2                	add    %eax,%edx
  8014b1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	01 c8                	add    %ecx,%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	01 d0                	add    %edx,%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	3c 40                	cmp    $0x40,%al
  8014c9:	7e 25                	jle    8014f0 <str2lower+0x5c>
  8014cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d1:	01 d0                	add    %edx,%eax
  8014d3:	8a 00                	mov    (%eax),%al
  8014d5:	3c 5a                	cmp    $0x5a,%al
  8014d7:	7f 17                	jg     8014f0 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8014d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	01 d0                	add    %edx,%eax
  8014e1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014e7:	01 ca                	add    %ecx,%edx
  8014e9:	8a 12                	mov    (%edx),%dl
  8014eb:	83 c2 20             	add    $0x20,%edx
  8014ee:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014f0:	ff 45 fc             	incl   -0x4(%ebp)
  8014f3:	ff 75 0c             	pushl  0xc(%ebp)
  8014f6:	e8 01 f8 ff ff       	call   800cfc <strlen>
  8014fb:	83 c4 04             	add    $0x4,%esp
  8014fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801501:	7f a6                	jg     8014a9 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801503:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
  80150b:	57                   	push   %edi
  80150c:	56                   	push   %esi
  80150d:	53                   	push   %ebx
  80150e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	8b 55 0c             	mov    0xc(%ebp),%edx
  801517:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80151a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80151d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801520:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801523:	cd 30                	int    $0x30
  801525:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801528:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80152b:	83 c4 10             	add    $0x10,%esp
  80152e:	5b                   	pop    %ebx
  80152f:	5e                   	pop    %esi
  801530:	5f                   	pop    %edi
  801531:	5d                   	pop    %ebp
  801532:	c3                   	ret    

00801533 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
  801536:	83 ec 04             	sub    $0x4,%esp
  801539:	8b 45 10             	mov    0x10(%ebp),%eax
  80153c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  80153f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801542:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	6a 00                	push   $0x0
  80154b:	51                   	push   %ecx
  80154c:	52                   	push   %edx
  80154d:	ff 75 0c             	pushl  0xc(%ebp)
  801550:	50                   	push   %eax
  801551:	6a 00                	push   $0x0
  801553:	e8 b0 ff ff ff       	call   801508 <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	90                   	nop
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_cgetc>:

int
sys_cgetc(void)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 02                	push   $0x2
  80156d:	e8 96 ff ff ff       	call   801508 <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
}
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 03                	push   $0x3
  801586:	e8 7d ff ff ff       	call   801508 <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	90                   	nop
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 04                	push   $0x4
  8015a0:	e8 63 ff ff ff       	call   801508 <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	90                   	nop
  8015a9:	c9                   	leave  
  8015aa:	c3                   	ret    

008015ab <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8015ab:	55                   	push   %ebp
  8015ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	52                   	push   %edx
  8015bb:	50                   	push   %eax
  8015bc:	6a 08                	push   $0x8
  8015be:	e8 45 ff ff ff       	call   801508 <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
  8015cb:	56                   	push   %esi
  8015cc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015cd:	8b 75 18             	mov    0x18(%ebp),%esi
  8015d0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	56                   	push   %esi
  8015dd:	53                   	push   %ebx
  8015de:	51                   	push   %ecx
  8015df:	52                   	push   %edx
  8015e0:	50                   	push   %eax
  8015e1:	6a 09                	push   $0x9
  8015e3:	e8 20 ff ff ff       	call   801508 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
}
  8015eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015ee:	5b                   	pop    %ebx
  8015ef:	5e                   	pop    %esi
  8015f0:	5d                   	pop    %ebp
  8015f1:	c3                   	ret    

008015f2 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	ff 75 08             	pushl  0x8(%ebp)
  801600:	6a 0a                	push   $0xa
  801602:	e8 01 ff ff ff       	call   801508 <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	ff 75 0c             	pushl  0xc(%ebp)
  801618:	ff 75 08             	pushl  0x8(%ebp)
  80161b:	6a 0b                	push   $0xb
  80161d:	e8 e6 fe ff ff       	call   801508 <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 0c                	push   $0xc
  801636:	e8 cd fe ff ff       	call   801508 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 0d                	push   $0xd
  80164f:	e8 b4 fe ff ff       	call   801508 <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
}
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 0e                	push   $0xe
  801668:	e8 9b fe ff ff       	call   801508 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 0f                	push   $0xf
  801681:	e8 82 fe ff ff       	call   801508 <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
}
  801689:	c9                   	leave  
  80168a:	c3                   	ret    

0080168b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	ff 75 08             	pushl  0x8(%ebp)
  801699:	6a 10                	push   $0x10
  80169b:	e8 68 fe ff ff       	call   801508 <syscall>
  8016a0:	83 c4 18             	add    $0x18,%esp
}
  8016a3:	c9                   	leave  
  8016a4:	c3                   	ret    

008016a5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 11                	push   $0x11
  8016b4:	e8 4f fe ff ff       	call   801508 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
}
  8016bc:	90                   	nop
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_cputc>:

void
sys_cputc(const char c)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
  8016c2:	83 ec 04             	sub    $0x4,%esp
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	50                   	push   %eax
  8016d8:	6a 01                	push   $0x1
  8016da:	e8 29 fe ff ff       	call   801508 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	90                   	nop
  8016e3:	c9                   	leave  
  8016e4:	c3                   	ret    

008016e5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016e5:	55                   	push   %ebp
  8016e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 14                	push   $0x14
  8016f4:	e8 0f fe ff ff       	call   801508 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
}
  8016fc:	90                   	nop
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	83 ec 04             	sub    $0x4,%esp
  801705:	8b 45 10             	mov    0x10(%ebp),%eax
  801708:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80170b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80170e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	6a 00                	push   $0x0
  801717:	51                   	push   %ecx
  801718:	52                   	push   %edx
  801719:	ff 75 0c             	pushl  0xc(%ebp)
  80171c:	50                   	push   %eax
  80171d:	6a 15                	push   $0x15
  80171f:	e8 e4 fd ff ff       	call   801508 <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
}
  801727:	c9                   	leave  
  801728:	c3                   	ret    

00801729 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80172c:	8b 55 10             	mov    0x10(%ebp),%edx
  80172f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	52                   	push   %edx
  801737:	50                   	push   %eax
  801738:	ff 75 08             	pushl  0x8(%ebp)
  80173b:	6a 16                	push   $0x16
  80173d:	e8 c6 fd ff ff       	call   801508 <syscall>
  801742:	83 c4 18             	add    $0x18,%esp
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80174a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174d:	8b 45 08             	mov    0x8(%ebp),%eax
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	52                   	push   %edx
  801757:	50                   	push   %eax
  801758:	6a 17                	push   $0x17
  80175a:	e8 a9 fd ff ff       	call   801508 <syscall>
  80175f:	83 c4 18             	add    $0x18,%esp
}
  801762:	c9                   	leave  
  801763:	c3                   	ret    

00801764 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801764:	55                   	push   %ebp
  801765:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801767:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176a:	8b 45 08             	mov    0x8(%ebp),%eax
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	52                   	push   %edx
  801774:	50                   	push   %eax
  801775:	6a 18                	push   $0x18
  801777:	e8 8c fd ff ff       	call   801508 <syscall>
  80177c:	83 c4 18             	add    $0x18,%esp
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801784:	8b 45 08             	mov    0x8(%ebp),%eax
  801787:	6a 00                	push   $0x0
  801789:	ff 75 14             	pushl  0x14(%ebp)
  80178c:	ff 75 10             	pushl  0x10(%ebp)
  80178f:	ff 75 0c             	pushl  0xc(%ebp)
  801792:	50                   	push   %eax
  801793:	6a 19                	push   $0x19
  801795:	e8 6e fd ff ff       	call   801508 <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <sys_run_env>:

void sys_run_env(int32 envId)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	50                   	push   %eax
  8017ae:	6a 1a                	push   $0x1a
  8017b0:	e8 53 fd ff ff       	call   801508 <syscall>
  8017b5:	83 c4 18             	add    $0x18,%esp
}
  8017b8:	90                   	nop
  8017b9:	c9                   	leave  
  8017ba:	c3                   	ret    

008017bb <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8017bb:	55                   	push   %ebp
  8017bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	50                   	push   %eax
  8017ca:	6a 1b                	push   $0x1b
  8017cc:	e8 37 fd ff ff       	call   801508 <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 05                	push   $0x5
  8017e5:	e8 1e fd ff ff       	call   801508 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 06                	push   $0x6
  8017fe:	e8 05 fd ff ff       	call   801508 <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 07                	push   $0x7
  801817:	e8 ec fc ff ff       	call   801508 <syscall>
  80181c:	83 c4 18             	add    $0x18,%esp
}
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <sys_exit_env>:


void sys_exit_env(void)
{
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 1c                	push   $0x1c
  801830:	e8 d3 fc ff ff       	call   801508 <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
}
  801838:	90                   	nop
  801839:	c9                   	leave  
  80183a:	c3                   	ret    

0080183b <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80183b:	55                   	push   %ebp
  80183c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	ff 75 10             	pushl  0x10(%ebp)
  801845:	ff 75 0c             	pushl  0xc(%ebp)
  801848:	ff 75 08             	pushl  0x8(%ebp)
  80184b:	6a 13                	push   $0x13
  80184d:	e8 b6 fc ff ff       	call   801508 <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
	return ;
  801855:	90                   	nop
}
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <sys_rcr2>:
uint32 sys_rcr2()
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 1e                	push   $0x1e
  801867:	e8 9c fc ff ff       	call   801508 <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
}
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
  801874:	83 ec 04             	sub    $0x4,%esp
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
  80187a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80187d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	50                   	push   %eax
  80188a:	6a 1f                	push   $0x1f
  80188c:	e8 77 fc ff ff       	call   801508 <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
	return ;
  801894:	90                   	nop
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <rsttst>:
void rsttst()
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 21                	push   $0x21
  8018a6:	e8 5d fc ff ff       	call   801508 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ae:	90                   	nop
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
  8018b4:	83 ec 04             	sub    $0x4,%esp
  8018b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018bd:	8b 55 18             	mov    0x18(%ebp),%edx
  8018c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018c4:	52                   	push   %edx
  8018c5:	50                   	push   %eax
  8018c6:	ff 75 10             	pushl  0x10(%ebp)
  8018c9:	ff 75 0c             	pushl  0xc(%ebp)
  8018cc:	ff 75 08             	pushl  0x8(%ebp)
  8018cf:	6a 20                	push   $0x20
  8018d1:	e8 32 fc ff ff       	call   801508 <syscall>
  8018d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d9:	90                   	nop
}
  8018da:	c9                   	leave  
  8018db:	c3                   	ret    

008018dc <chktst>:
void chktst(uint32 n)
{
  8018dc:	55                   	push   %ebp
  8018dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	ff 75 08             	pushl  0x8(%ebp)
  8018ea:	6a 22                	push   $0x22
  8018ec:	e8 17 fc ff ff       	call   801508 <syscall>
  8018f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f4:	90                   	nop
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <inctst>:

void inctst()
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 23                	push   $0x23
  801906:	e8 fd fb ff ff       	call   801508 <syscall>
  80190b:	83 c4 18             	add    $0x18,%esp
	return ;
  80190e:	90                   	nop
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <gettst>:
uint32 gettst()
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 24                	push   $0x24
  801920:	e8 e3 fb ff ff       	call   801508 <syscall>
  801925:	83 c4 18             	add    $0x18,%esp
}
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 25                	push   $0x25
  801939:	e8 ca fb ff ff       	call   801508 <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
  801941:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801946:	a1 48 30 80 00       	mov    0x803048,%eax
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801950:	8b 45 08             	mov    0x8(%ebp),%eax
  801953:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	ff 75 08             	pushl  0x8(%ebp)
  801963:	6a 26                	push   $0x26
  801965:	e8 9e fb ff ff       	call   801508 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
	return ;
  80196d:	90                   	nop
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801974:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801977:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80197a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	6a 00                	push   $0x0
  801982:	53                   	push   %ebx
  801983:	51                   	push   %ecx
  801984:	52                   	push   %edx
  801985:	50                   	push   %eax
  801986:	6a 27                	push   $0x27
  801988:	e8 7b fb ff ff       	call   801508 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801998:	8b 55 0c             	mov    0xc(%ebp),%edx
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	52                   	push   %edx
  8019a5:	50                   	push   %eax
  8019a6:	6a 28                	push   $0x28
  8019a8:	e8 5b fb ff ff       	call   801508 <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  8019b5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	51                   	push   %ecx
  8019c1:	ff 75 10             	pushl  0x10(%ebp)
  8019c4:	52                   	push   %edx
  8019c5:	50                   	push   %eax
  8019c6:	6a 29                	push   $0x29
  8019c8:	e8 3b fb ff ff       	call   801508 <syscall>
  8019cd:	83 c4 18             	add    $0x18,%esp
}
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	ff 75 10             	pushl  0x10(%ebp)
  8019dc:	ff 75 0c             	pushl  0xc(%ebp)
  8019df:	ff 75 08             	pushl  0x8(%ebp)
  8019e2:	6a 12                	push   $0x12
  8019e4:	e8 1f fb ff ff       	call   801508 <syscall>
  8019e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ec:	90                   	nop
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8019f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	52                   	push   %edx
  8019ff:	50                   	push   %eax
  801a00:	6a 2a                	push   $0x2a
  801a02:	e8 01 fb ff ff       	call   801508 <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
	return;
  801a0a:	90                   	nop
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 2b                	push   $0x2b
  801a1c:	e8 e7 fa ff ff       	call   801508 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
  801a29:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801a2c:	83 ec 04             	sub    $0x4,%esp
  801a2f:	68 fb 25 80 00       	push   $0x8025fb
  801a34:	68 0a 01 00 00       	push   $0x10a
  801a39:	68 0b 26 80 00       	push   $0x80260b
  801a3e:	e8 38 01 00 00       	call   801b7b <_panic>

00801a43 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	ff 75 0c             	pushl  0xc(%ebp)
  801a4f:	ff 75 08             	pushl  0x8(%ebp)
  801a52:	6a 33                	push   $0x33
  801a54:	e8 af fa ff ff       	call   801508 <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
	return;
  801a5c:	90                   	nop
}
  801a5d:	c9                   	leave  
  801a5e:	c3                   	ret    

00801a5f <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a5f:	55                   	push   %ebp
  801a60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	ff 75 0c             	pushl  0xc(%ebp)
  801a6b:	ff 75 08             	pushl  0x8(%ebp)
  801a6e:	6a 34                	push   $0x34
  801a70:	e8 93 fa ff ff       	call   801508 <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
	return ;
  801a78:	90                   	nop
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
  801a7e:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a81:	8b 55 08             	mov    0x8(%ebp),%edx
  801a84:	89 d0                	mov    %edx,%eax
  801a86:	c1 e0 02             	shl    $0x2,%eax
  801a89:	01 d0                	add    %edx,%eax
  801a8b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a92:	01 d0                	add    %edx,%eax
  801a94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a9b:	01 d0                	add    %edx,%eax
  801a9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aa4:	01 d0                	add    %edx,%eax
  801aa6:	c1 e0 04             	shl    $0x4,%eax
  801aa9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801aac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801ab3:	0f 31                	rdtsc  
  801ab5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801ab8:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801abb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801abe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ac4:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ac7:	eb 46                	jmp    801b0f <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801ac9:	0f 31                	rdtsc  
  801acb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801ace:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801ad1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ad4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801ad7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801ada:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801add:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ae0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae3:	29 c2                	sub    %eax,%edx
  801ae5:	89 d0                	mov    %edx,%eax
  801ae7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801aea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801af0:	89 d1                	mov    %edx,%ecx
  801af2:	29 c1                	sub    %eax,%ecx
  801af4:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801af7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801afa:	39 c2                	cmp    %eax,%edx
  801afc:	0f 97 c0             	seta   %al
  801aff:	0f b6 c0             	movzbl %al,%eax
  801b02:	29 c1                	sub    %eax,%ecx
  801b04:	89 c8                	mov    %ecx,%eax
  801b06:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801b09:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801b0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801b0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b12:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b15:	72 b2                	jb     801ac9 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801b17:	90                   	nop
  801b18:	c9                   	leave  
  801b19:	c3                   	ret    

00801b1a <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
  801b1d:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801b20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801b27:	eb 03                	jmp    801b2c <busy_wait+0x12>
  801b29:	ff 45 fc             	incl   -0x4(%ebp)
  801b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b2f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801b32:	72 f5                	jb     801b29 <busy_wait+0xf>
	return i;
  801b34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
  801b3c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b42:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801b45:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801b49:	83 ec 0c             	sub    $0xc,%esp
  801b4c:	50                   	push   %eax
  801b4d:	e8 6d fb ff ff       	call   8016bf <sys_cputc>
  801b52:	83 c4 10             	add    $0x10,%esp
}
  801b55:	90                   	nop
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <getchar>:


int
getchar(void)
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
  801b5b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  801b5e:	e8 fb f9 ff ff       	call   80155e <sys_cgetc>
  801b63:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801b6a:	74 f2                	je     801b5e <getchar+0x6>
	return c;
  801b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <iscons>:

int iscons(int fdnum)
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801b74:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b79:	5d                   	pop    %ebp
  801b7a:	c3                   	ret    

00801b7b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
  801b7e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b81:	8d 45 10             	lea    0x10(%ebp),%eax
  801b84:	83 c0 04             	add    $0x4,%eax
  801b87:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801b8a:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b8f:	85 c0                	test   %eax,%eax
  801b91:	74 16                	je     801ba9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b93:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b98:	83 ec 08             	sub    $0x8,%esp
  801b9b:	50                   	push   %eax
  801b9c:	68 1c 26 80 00       	push   $0x80261c
  801ba1:	e8 75 e8 ff ff       	call   80041b <cprintf>
  801ba6:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801ba9:	a1 04 30 80 00       	mov    0x803004,%eax
  801bae:	83 ec 0c             	sub    $0xc,%esp
  801bb1:	ff 75 0c             	pushl  0xc(%ebp)
  801bb4:	ff 75 08             	pushl  0x8(%ebp)
  801bb7:	50                   	push   %eax
  801bb8:	68 24 26 80 00       	push   $0x802624
  801bbd:	6a 74                	push   $0x74
  801bbf:	e8 84 e8 ff ff       	call   800448 <cprintf_colored>
  801bc4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801bc7:	8b 45 10             	mov    0x10(%ebp),%eax
  801bca:	83 ec 08             	sub    $0x8,%esp
  801bcd:	ff 75 f4             	pushl  -0xc(%ebp)
  801bd0:	50                   	push   %eax
  801bd1:	e8 d6 e7 ff ff       	call   8003ac <vcprintf>
  801bd6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801bd9:	83 ec 08             	sub    $0x8,%esp
  801bdc:	6a 00                	push   $0x0
  801bde:	68 4c 26 80 00       	push   $0x80264c
  801be3:	e8 c4 e7 ff ff       	call   8003ac <vcprintf>
  801be8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801beb:	e8 3d e7 ff ff       	call   80032d <exit>

	// should not return here
	while (1) ;
  801bf0:	eb fe                	jmp    801bf0 <_panic+0x75>

00801bf2 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801bf2:	55                   	push   %ebp
  801bf3:	89 e5                	mov    %esp,%ebp
  801bf5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801bf8:	a1 20 30 80 00       	mov    0x803020,%eax
  801bfd:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c03:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c06:	39 c2                	cmp    %eax,%edx
  801c08:	74 14                	je     801c1e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801c0a:	83 ec 04             	sub    $0x4,%esp
  801c0d:	68 50 26 80 00       	push   $0x802650
  801c12:	6a 26                	push   $0x26
  801c14:	68 9c 26 80 00       	push   $0x80269c
  801c19:	e8 5d ff ff ff       	call   801b7b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801c1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c25:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c2c:	e9 c5 00 00 00       	jmp    801cf6 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801c31:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c34:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3e:	01 d0                	add    %edx,%eax
  801c40:	8b 00                	mov    (%eax),%eax
  801c42:	85 c0                	test   %eax,%eax
  801c44:	75 08                	jne    801c4e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801c46:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801c49:	e9 a5 00 00 00       	jmp    801cf3 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801c4e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c55:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801c5c:	eb 69                	jmp    801cc7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801c5e:	a1 20 30 80 00       	mov    0x803020,%eax
  801c63:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c69:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c6c:	89 d0                	mov    %edx,%eax
  801c6e:	01 c0                	add    %eax,%eax
  801c70:	01 d0                	add    %edx,%eax
  801c72:	c1 e0 03             	shl    $0x3,%eax
  801c75:	01 c8                	add    %ecx,%eax
  801c77:	8a 40 04             	mov    0x4(%eax),%al
  801c7a:	84 c0                	test   %al,%al
  801c7c:	75 46                	jne    801cc4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c7e:	a1 20 30 80 00       	mov    0x803020,%eax
  801c83:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c89:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c8c:	89 d0                	mov    %edx,%eax
  801c8e:	01 c0                	add    %eax,%eax
  801c90:	01 d0                	add    %edx,%eax
  801c92:	c1 e0 03             	shl    $0x3,%eax
  801c95:	01 c8                	add    %ecx,%eax
  801c97:	8b 00                	mov    (%eax),%eax
  801c99:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ca4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801ca6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ca9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb3:	01 c8                	add    %ecx,%eax
  801cb5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801cb7:	39 c2                	cmp    %eax,%edx
  801cb9:	75 09                	jne    801cc4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801cbb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801cc2:	eb 15                	jmp    801cd9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cc4:	ff 45 e8             	incl   -0x18(%ebp)
  801cc7:	a1 20 30 80 00       	mov    0x803020,%eax
  801ccc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801cd2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cd5:	39 c2                	cmp    %eax,%edx
  801cd7:	77 85                	ja     801c5e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801cd9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801cdd:	75 14                	jne    801cf3 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801cdf:	83 ec 04             	sub    $0x4,%esp
  801ce2:	68 a8 26 80 00       	push   $0x8026a8
  801ce7:	6a 3a                	push   $0x3a
  801ce9:	68 9c 26 80 00       	push   $0x80269c
  801cee:	e8 88 fe ff ff       	call   801b7b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801cf3:	ff 45 f0             	incl   -0x10(%ebp)
  801cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cf9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801cfc:	0f 8c 2f ff ff ff    	jl     801c31 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d02:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d09:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801d10:	eb 26                	jmp    801d38 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801d12:	a1 20 30 80 00       	mov    0x803020,%eax
  801d17:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801d1d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d20:	89 d0                	mov    %edx,%eax
  801d22:	01 c0                	add    %eax,%eax
  801d24:	01 d0                	add    %edx,%eax
  801d26:	c1 e0 03             	shl    $0x3,%eax
  801d29:	01 c8                	add    %ecx,%eax
  801d2b:	8a 40 04             	mov    0x4(%eax),%al
  801d2e:	3c 01                	cmp    $0x1,%al
  801d30:	75 03                	jne    801d35 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801d32:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d35:	ff 45 e0             	incl   -0x20(%ebp)
  801d38:	a1 20 30 80 00       	mov    0x803020,%eax
  801d3d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801d43:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d46:	39 c2                	cmp    %eax,%edx
  801d48:	77 c8                	ja     801d12 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d4d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d50:	74 14                	je     801d66 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801d52:	83 ec 04             	sub    $0x4,%esp
  801d55:	68 fc 26 80 00       	push   $0x8026fc
  801d5a:	6a 44                	push   $0x44
  801d5c:	68 9c 26 80 00       	push   $0x80269c
  801d61:	e8 15 fe ff ff       	call   801b7b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801d66:	90                   	nop
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    
  801d69:	66 90                	xchg   %ax,%ax
  801d6b:	90                   	nop

00801d6c <__udivdi3>:
  801d6c:	55                   	push   %ebp
  801d6d:	57                   	push   %edi
  801d6e:	56                   	push   %esi
  801d6f:	53                   	push   %ebx
  801d70:	83 ec 1c             	sub    $0x1c,%esp
  801d73:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d77:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d7b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d7f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d83:	89 ca                	mov    %ecx,%edx
  801d85:	89 f8                	mov    %edi,%eax
  801d87:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d8b:	85 f6                	test   %esi,%esi
  801d8d:	75 2d                	jne    801dbc <__udivdi3+0x50>
  801d8f:	39 cf                	cmp    %ecx,%edi
  801d91:	77 65                	ja     801df8 <__udivdi3+0x8c>
  801d93:	89 fd                	mov    %edi,%ebp
  801d95:	85 ff                	test   %edi,%edi
  801d97:	75 0b                	jne    801da4 <__udivdi3+0x38>
  801d99:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9e:	31 d2                	xor    %edx,%edx
  801da0:	f7 f7                	div    %edi
  801da2:	89 c5                	mov    %eax,%ebp
  801da4:	31 d2                	xor    %edx,%edx
  801da6:	89 c8                	mov    %ecx,%eax
  801da8:	f7 f5                	div    %ebp
  801daa:	89 c1                	mov    %eax,%ecx
  801dac:	89 d8                	mov    %ebx,%eax
  801dae:	f7 f5                	div    %ebp
  801db0:	89 cf                	mov    %ecx,%edi
  801db2:	89 fa                	mov    %edi,%edx
  801db4:	83 c4 1c             	add    $0x1c,%esp
  801db7:	5b                   	pop    %ebx
  801db8:	5e                   	pop    %esi
  801db9:	5f                   	pop    %edi
  801dba:	5d                   	pop    %ebp
  801dbb:	c3                   	ret    
  801dbc:	39 ce                	cmp    %ecx,%esi
  801dbe:	77 28                	ja     801de8 <__udivdi3+0x7c>
  801dc0:	0f bd fe             	bsr    %esi,%edi
  801dc3:	83 f7 1f             	xor    $0x1f,%edi
  801dc6:	75 40                	jne    801e08 <__udivdi3+0x9c>
  801dc8:	39 ce                	cmp    %ecx,%esi
  801dca:	72 0a                	jb     801dd6 <__udivdi3+0x6a>
  801dcc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dd0:	0f 87 9e 00 00 00    	ja     801e74 <__udivdi3+0x108>
  801dd6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ddb:	89 fa                	mov    %edi,%edx
  801ddd:	83 c4 1c             	add    $0x1c,%esp
  801de0:	5b                   	pop    %ebx
  801de1:	5e                   	pop    %esi
  801de2:	5f                   	pop    %edi
  801de3:	5d                   	pop    %ebp
  801de4:	c3                   	ret    
  801de5:	8d 76 00             	lea    0x0(%esi),%esi
  801de8:	31 ff                	xor    %edi,%edi
  801dea:	31 c0                	xor    %eax,%eax
  801dec:	89 fa                	mov    %edi,%edx
  801dee:	83 c4 1c             	add    $0x1c,%esp
  801df1:	5b                   	pop    %ebx
  801df2:	5e                   	pop    %esi
  801df3:	5f                   	pop    %edi
  801df4:	5d                   	pop    %ebp
  801df5:	c3                   	ret    
  801df6:	66 90                	xchg   %ax,%ax
  801df8:	89 d8                	mov    %ebx,%eax
  801dfa:	f7 f7                	div    %edi
  801dfc:	31 ff                	xor    %edi,%edi
  801dfe:	89 fa                	mov    %edi,%edx
  801e00:	83 c4 1c             	add    $0x1c,%esp
  801e03:	5b                   	pop    %ebx
  801e04:	5e                   	pop    %esi
  801e05:	5f                   	pop    %edi
  801e06:	5d                   	pop    %ebp
  801e07:	c3                   	ret    
  801e08:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e0d:	89 eb                	mov    %ebp,%ebx
  801e0f:	29 fb                	sub    %edi,%ebx
  801e11:	89 f9                	mov    %edi,%ecx
  801e13:	d3 e6                	shl    %cl,%esi
  801e15:	89 c5                	mov    %eax,%ebp
  801e17:	88 d9                	mov    %bl,%cl
  801e19:	d3 ed                	shr    %cl,%ebp
  801e1b:	89 e9                	mov    %ebp,%ecx
  801e1d:	09 f1                	or     %esi,%ecx
  801e1f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e23:	89 f9                	mov    %edi,%ecx
  801e25:	d3 e0                	shl    %cl,%eax
  801e27:	89 c5                	mov    %eax,%ebp
  801e29:	89 d6                	mov    %edx,%esi
  801e2b:	88 d9                	mov    %bl,%cl
  801e2d:	d3 ee                	shr    %cl,%esi
  801e2f:	89 f9                	mov    %edi,%ecx
  801e31:	d3 e2                	shl    %cl,%edx
  801e33:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e37:	88 d9                	mov    %bl,%cl
  801e39:	d3 e8                	shr    %cl,%eax
  801e3b:	09 c2                	or     %eax,%edx
  801e3d:	89 d0                	mov    %edx,%eax
  801e3f:	89 f2                	mov    %esi,%edx
  801e41:	f7 74 24 0c          	divl   0xc(%esp)
  801e45:	89 d6                	mov    %edx,%esi
  801e47:	89 c3                	mov    %eax,%ebx
  801e49:	f7 e5                	mul    %ebp
  801e4b:	39 d6                	cmp    %edx,%esi
  801e4d:	72 19                	jb     801e68 <__udivdi3+0xfc>
  801e4f:	74 0b                	je     801e5c <__udivdi3+0xf0>
  801e51:	89 d8                	mov    %ebx,%eax
  801e53:	31 ff                	xor    %edi,%edi
  801e55:	e9 58 ff ff ff       	jmp    801db2 <__udivdi3+0x46>
  801e5a:	66 90                	xchg   %ax,%ax
  801e5c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e60:	89 f9                	mov    %edi,%ecx
  801e62:	d3 e2                	shl    %cl,%edx
  801e64:	39 c2                	cmp    %eax,%edx
  801e66:	73 e9                	jae    801e51 <__udivdi3+0xe5>
  801e68:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e6b:	31 ff                	xor    %edi,%edi
  801e6d:	e9 40 ff ff ff       	jmp    801db2 <__udivdi3+0x46>
  801e72:	66 90                	xchg   %ax,%ax
  801e74:	31 c0                	xor    %eax,%eax
  801e76:	e9 37 ff ff ff       	jmp    801db2 <__udivdi3+0x46>
  801e7b:	90                   	nop

00801e7c <__umoddi3>:
  801e7c:	55                   	push   %ebp
  801e7d:	57                   	push   %edi
  801e7e:	56                   	push   %esi
  801e7f:	53                   	push   %ebx
  801e80:	83 ec 1c             	sub    $0x1c,%esp
  801e83:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e87:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e8b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e8f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e93:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e97:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e9b:	89 f3                	mov    %esi,%ebx
  801e9d:	89 fa                	mov    %edi,%edx
  801e9f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ea3:	89 34 24             	mov    %esi,(%esp)
  801ea6:	85 c0                	test   %eax,%eax
  801ea8:	75 1a                	jne    801ec4 <__umoddi3+0x48>
  801eaa:	39 f7                	cmp    %esi,%edi
  801eac:	0f 86 a2 00 00 00    	jbe    801f54 <__umoddi3+0xd8>
  801eb2:	89 c8                	mov    %ecx,%eax
  801eb4:	89 f2                	mov    %esi,%edx
  801eb6:	f7 f7                	div    %edi
  801eb8:	89 d0                	mov    %edx,%eax
  801eba:	31 d2                	xor    %edx,%edx
  801ebc:	83 c4 1c             	add    $0x1c,%esp
  801ebf:	5b                   	pop    %ebx
  801ec0:	5e                   	pop    %esi
  801ec1:	5f                   	pop    %edi
  801ec2:	5d                   	pop    %ebp
  801ec3:	c3                   	ret    
  801ec4:	39 f0                	cmp    %esi,%eax
  801ec6:	0f 87 ac 00 00 00    	ja     801f78 <__umoddi3+0xfc>
  801ecc:	0f bd e8             	bsr    %eax,%ebp
  801ecf:	83 f5 1f             	xor    $0x1f,%ebp
  801ed2:	0f 84 ac 00 00 00    	je     801f84 <__umoddi3+0x108>
  801ed8:	bf 20 00 00 00       	mov    $0x20,%edi
  801edd:	29 ef                	sub    %ebp,%edi
  801edf:	89 fe                	mov    %edi,%esi
  801ee1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ee5:	89 e9                	mov    %ebp,%ecx
  801ee7:	d3 e0                	shl    %cl,%eax
  801ee9:	89 d7                	mov    %edx,%edi
  801eeb:	89 f1                	mov    %esi,%ecx
  801eed:	d3 ef                	shr    %cl,%edi
  801eef:	09 c7                	or     %eax,%edi
  801ef1:	89 e9                	mov    %ebp,%ecx
  801ef3:	d3 e2                	shl    %cl,%edx
  801ef5:	89 14 24             	mov    %edx,(%esp)
  801ef8:	89 d8                	mov    %ebx,%eax
  801efa:	d3 e0                	shl    %cl,%eax
  801efc:	89 c2                	mov    %eax,%edx
  801efe:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f02:	d3 e0                	shl    %cl,%eax
  801f04:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f08:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f0c:	89 f1                	mov    %esi,%ecx
  801f0e:	d3 e8                	shr    %cl,%eax
  801f10:	09 d0                	or     %edx,%eax
  801f12:	d3 eb                	shr    %cl,%ebx
  801f14:	89 da                	mov    %ebx,%edx
  801f16:	f7 f7                	div    %edi
  801f18:	89 d3                	mov    %edx,%ebx
  801f1a:	f7 24 24             	mull   (%esp)
  801f1d:	89 c6                	mov    %eax,%esi
  801f1f:	89 d1                	mov    %edx,%ecx
  801f21:	39 d3                	cmp    %edx,%ebx
  801f23:	0f 82 87 00 00 00    	jb     801fb0 <__umoddi3+0x134>
  801f29:	0f 84 91 00 00 00    	je     801fc0 <__umoddi3+0x144>
  801f2f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f33:	29 f2                	sub    %esi,%edx
  801f35:	19 cb                	sbb    %ecx,%ebx
  801f37:	89 d8                	mov    %ebx,%eax
  801f39:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f3d:	d3 e0                	shl    %cl,%eax
  801f3f:	89 e9                	mov    %ebp,%ecx
  801f41:	d3 ea                	shr    %cl,%edx
  801f43:	09 d0                	or     %edx,%eax
  801f45:	89 e9                	mov    %ebp,%ecx
  801f47:	d3 eb                	shr    %cl,%ebx
  801f49:	89 da                	mov    %ebx,%edx
  801f4b:	83 c4 1c             	add    $0x1c,%esp
  801f4e:	5b                   	pop    %ebx
  801f4f:	5e                   	pop    %esi
  801f50:	5f                   	pop    %edi
  801f51:	5d                   	pop    %ebp
  801f52:	c3                   	ret    
  801f53:	90                   	nop
  801f54:	89 fd                	mov    %edi,%ebp
  801f56:	85 ff                	test   %edi,%edi
  801f58:	75 0b                	jne    801f65 <__umoddi3+0xe9>
  801f5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f5f:	31 d2                	xor    %edx,%edx
  801f61:	f7 f7                	div    %edi
  801f63:	89 c5                	mov    %eax,%ebp
  801f65:	89 f0                	mov    %esi,%eax
  801f67:	31 d2                	xor    %edx,%edx
  801f69:	f7 f5                	div    %ebp
  801f6b:	89 c8                	mov    %ecx,%eax
  801f6d:	f7 f5                	div    %ebp
  801f6f:	89 d0                	mov    %edx,%eax
  801f71:	e9 44 ff ff ff       	jmp    801eba <__umoddi3+0x3e>
  801f76:	66 90                	xchg   %ax,%ax
  801f78:	89 c8                	mov    %ecx,%eax
  801f7a:	89 f2                	mov    %esi,%edx
  801f7c:	83 c4 1c             	add    $0x1c,%esp
  801f7f:	5b                   	pop    %ebx
  801f80:	5e                   	pop    %esi
  801f81:	5f                   	pop    %edi
  801f82:	5d                   	pop    %ebp
  801f83:	c3                   	ret    
  801f84:	3b 04 24             	cmp    (%esp),%eax
  801f87:	72 06                	jb     801f8f <__umoddi3+0x113>
  801f89:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f8d:	77 0f                	ja     801f9e <__umoddi3+0x122>
  801f8f:	89 f2                	mov    %esi,%edx
  801f91:	29 f9                	sub    %edi,%ecx
  801f93:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f97:	89 14 24             	mov    %edx,(%esp)
  801f9a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f9e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fa2:	8b 14 24             	mov    (%esp),%edx
  801fa5:	83 c4 1c             	add    $0x1c,%esp
  801fa8:	5b                   	pop    %ebx
  801fa9:	5e                   	pop    %esi
  801faa:	5f                   	pop    %edi
  801fab:	5d                   	pop    %ebp
  801fac:	c3                   	ret    
  801fad:	8d 76 00             	lea    0x0(%esi),%esi
  801fb0:	2b 04 24             	sub    (%esp),%eax
  801fb3:	19 fa                	sbb    %edi,%edx
  801fb5:	89 d1                	mov    %edx,%ecx
  801fb7:	89 c6                	mov    %eax,%esi
  801fb9:	e9 71 ff ff ff       	jmp    801f2f <__umoddi3+0xb3>
  801fbe:	66 90                	xchg   %ax,%ax
  801fc0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fc4:	72 ea                	jb     801fb0 <__umoddi3+0x134>
  801fc6:	89 d9                	mov    %ebx,%ecx
  801fc8:	e9 62 ff ff ff       	jmp    801f2f <__umoddi3+0xb3>
