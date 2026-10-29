
obj/user/sc_fos_add:     file format elf32-i386


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
  800031:	e8 65 00 00 00       	call   80009b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	int i1=0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	i1 = strtol("1", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 a0 1c 80 00       	push   $0x801ca0
  800058:	e8 66 0e 00 00       	call   800ec3 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 a2 1c 80 00       	push   $0x801ca2
  80006f:	e8 4f 0e 00 00       	call   800ec3 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 a4 1c 80 00       	push   $0x801ca4
  80008b:	e8 bd 03 00 00       	call   80044d <atomic_cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//cprintf("number 1 + number 2 = \n");

	inctst();
  800093:	e8 17 16 00 00       	call   8016af <inctst>
	return;
  800098:	90                   	nop
}
  800099:	c9                   	leave  
  80009a:	c3                   	ret    

0080009b <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80009b:	55                   	push   %ebp
  80009c:	89 e5                	mov    %esp,%ebp
  80009e:	57                   	push   %edi
  80009f:	56                   	push   %esi
  8000a0:	53                   	push   %ebx
  8000a1:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000a7:	e8 fb 14 00 00       	call   8015a7 <sys_getenvindex>
  8000ac:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000b2:	89 d0                	mov    %edx,%eax
  8000b4:	c1 e0 03             	shl    $0x3,%eax
  8000b7:	01 d0                	add    %edx,%eax
  8000b9:	c1 e0 06             	shl    $0x6,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 03             	shl    $0x3,%eax
  8000c1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d0:	8a 40 10             	mov    0x10(%eax),%al
  8000d3:	84 c0                	test   %al,%al
  8000d5:	74 0d                	je     8000e4 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000dc:	83 c0 10             	add    $0x10,%eax
  8000df:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e8:	7e 0a                	jle    8000f4 <libmain+0x59>
		binaryname = argv[0];
  8000ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ed:	8b 00                	mov    (%eax),%eax
  8000ef:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000f4:	83 ec 08             	sub    $0x8,%esp
  8000f7:	ff 75 0c             	pushl  0xc(%ebp)
  8000fa:	ff 75 08             	pushl  0x8(%ebp)
  8000fd:	e8 36 ff ff ff       	call   800038 <_main>
  800102:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800105:	a1 00 30 80 00       	mov    0x803000,%eax
  80010a:	85 c0                	test   %eax,%eax
  80010c:	0f 84 b7 01 00 00    	je     8002c9 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800112:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800118:	bb fc 1d 80 00       	mov    $0x801dfc,%ebx
  80011d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800122:	89 c7                	mov    %eax,%edi
  800124:	89 de                	mov    %ebx,%esi
  800126:	89 d1                	mov    %edx,%ecx
  800128:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80012a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800130:	b9 56 00 00 00       	mov    $0x56,%ecx
  800135:	b0 00                	mov    $0x0,%al
  800137:	89 d7                	mov    %edx,%edi
  800139:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80013b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800142:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800145:	83 ec 08             	sub    $0x8,%esp
  800148:	50                   	push   %eax
  800149:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80014f:	50                   	push   %eax
  800150:	e8 52 16 00 00       	call   8017a7 <sys_utilities>
  800155:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800158:	e8 d2 11 00 00       	call   80132f <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80015d:	83 ec 0c             	sub    $0xc,%esp
  800160:	68 d8 1c 80 00       	push   $0x801cd8
  800165:	e8 71 02 00 00       	call   8003db <cprintf>
  80016a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80016d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800170:	85 c0                	test   %eax,%eax
  800172:	74 58                	je     8001cc <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800174:	e8 4c 16 00 00       	call   8017c5 <sys_get_optimal_num_faults>
  800179:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80017c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800182:	bb 60 1e 80 00       	mov    $0x801e60,%ebx
  800187:	ba 11 00 00 00       	mov    $0x11,%edx
  80018c:	89 c7                	mov    %eax,%edi
  80018e:	89 de                	mov    %ebx,%esi
  800190:	89 d1                	mov    %edx,%ecx
  800192:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800194:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800197:	b9 53 00 00 00       	mov    $0x53,%ecx
  80019c:	b0 00                	mov    $0x0,%al
  80019e:	89 d7                	mov    %edx,%edi
  8001a0:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001a2:	83 ec 08             	sub    $0x8,%esp
  8001a5:	ff 75 dc             	pushl  -0x24(%ebp)
  8001a8:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001ae:	50                   	push   %eax
  8001af:	e8 f3 15 00 00       	call   8017a7 <sys_utilities>
  8001b4:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001b7:	83 ec 08             	sub    $0x8,%esp
  8001ba:	ff 75 dc             	pushl  -0x24(%ebp)
  8001bd:	68 00 1d 80 00       	push   $0x801d00
  8001c2:	e8 14 02 00 00       	call   8003db <cprintf>
  8001c7:	83 c4 10             	add    $0x10,%esp
  8001ca:	eb 59                	jmp    800225 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d1:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dc:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001e2:	83 ec 04             	sub    $0x4,%esp
  8001e5:	52                   	push   %edx
  8001e6:	50                   	push   %eax
  8001e7:	68 24 1d 80 00       	push   $0x801d24
  8001ec:	e8 ea 01 00 00       	call   8003db <cprintf>
  8001f1:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f9:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800204:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80020a:	a1 20 30 80 00       	mov    0x803020,%eax
  80020f:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800215:	51                   	push   %ecx
  800216:	52                   	push   %edx
  800217:	50                   	push   %eax
  800218:	68 4c 1d 80 00       	push   $0x801d4c
  80021d:	e8 b9 01 00 00       	call   8003db <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	50                   	push   %eax
  800234:	68 a4 1d 80 00       	push   $0x801da4
  800239:	e8 9d 01 00 00       	call   8003db <cprintf>
  80023e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800241:	83 ec 0c             	sub    $0xc,%esp
  800244:	68 b8 1d 80 00       	push   $0x801db8
  800249:	e8 8d 01 00 00       	call   8003db <cprintf>
  80024e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800251:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800258:	eb 28                	jmp    800282 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80025a:	a1 20 30 80 00       	mov    0x803020,%eax
  80025f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800262:	81 c2 74 04 00 00    	add    $0x474,%edx
  800268:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80026b:	83 ec 04             	sub    $0x4,%esp
  80026e:	50                   	push   %eax
  80026f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800272:	68 cf 1d 80 00       	push   $0x801dcf
  800277:	e8 5f 01 00 00       	call   8003db <cprintf>
  80027c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80027f:	ff 45 e4             	incl   -0x1c(%ebp)
  800282:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800286:	7e d2                	jle    80025a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800288:	83 ec 0c             	sub    $0xc,%esp
  80028b:	68 de 1d 80 00       	push   $0x801dde
  800290:	e8 46 01 00 00       	call   8003db <cprintf>
  800295:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800298:	a1 20 30 80 00       	mov    0x803020,%eax
  80029d:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002a3:	83 ec 08             	sub    $0x8,%esp
  8002a6:	50                   	push   %eax
  8002a7:	68 e2 1d 80 00       	push   $0x801de2
  8002ac:	e8 2a 01 00 00       	call   8003db <cprintf>
  8002b1:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002b4:	83 ec 0c             	sub    $0xc,%esp
  8002b7:	68 d8 1c 80 00       	push   $0x801cd8
  8002bc:	e8 1a 01 00 00       	call   8003db <cprintf>
  8002c1:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002c4:	e8 80 10 00 00       	call   801349 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002c9:	e8 1f 00 00 00       	call   8002ed <exit>
}
  8002ce:	90                   	nop
  8002cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002d2:	5b                   	pop    %ebx
  8002d3:	5e                   	pop    %esi
  8002d4:	5f                   	pop    %edi
  8002d5:	5d                   	pop    %ebp
  8002d6:	c3                   	ret    

008002d7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002dd:	83 ec 0c             	sub    $0xc,%esp
  8002e0:	6a 00                	push   $0x0
  8002e2:	e8 8c 12 00 00       	call   801573 <sys_destroy_env>
  8002e7:	83 c4 10             	add    $0x10,%esp
}
  8002ea:	90                   	nop
  8002eb:	c9                   	leave  
  8002ec:	c3                   	ret    

008002ed <exit>:

void
exit(void)
{
  8002ed:	55                   	push   %ebp
  8002ee:	89 e5                	mov    %esp,%ebp
  8002f0:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002f3:	e8 e1 12 00 00       	call   8015d9 <sys_exit_env>
}
  8002f8:	90                   	nop
  8002f9:	c9                   	leave  
  8002fa:	c3                   	ret    

008002fb <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8002fb:	55                   	push   %ebp
  8002fc:	89 e5                	mov    %esp,%ebp
  8002fe:	53                   	push   %ebx
  8002ff:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800302:	8b 45 0c             	mov    0xc(%ebp),%eax
  800305:	8b 00                	mov    (%eax),%eax
  800307:	8d 48 01             	lea    0x1(%eax),%ecx
  80030a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80030d:	89 0a                	mov    %ecx,(%edx)
  80030f:	8b 55 08             	mov    0x8(%ebp),%edx
  800312:	88 d1                	mov    %dl,%cl
  800314:	8b 55 0c             	mov    0xc(%ebp),%edx
  800317:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	8b 00                	mov    (%eax),%eax
  800320:	3d ff 00 00 00       	cmp    $0xff,%eax
  800325:	75 30                	jne    800357 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800327:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80032d:	a0 40 30 80 00       	mov    0x803040,%al
  800332:	0f b6 c0             	movzbl %al,%eax
  800335:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800338:	8b 09                	mov    (%ecx),%ecx
  80033a:	89 cb                	mov    %ecx,%ebx
  80033c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80033f:	83 c1 08             	add    $0x8,%ecx
  800342:	52                   	push   %edx
  800343:	50                   	push   %eax
  800344:	53                   	push   %ebx
  800345:	51                   	push   %ecx
  800346:	e8 a0 0f 00 00       	call   8012eb <sys_cputs>
  80034b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80034e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800351:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800357:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035a:	8b 40 04             	mov    0x4(%eax),%eax
  80035d:	8d 50 01             	lea    0x1(%eax),%edx
  800360:	8b 45 0c             	mov    0xc(%ebp),%eax
  800363:	89 50 04             	mov    %edx,0x4(%eax)
}
  800366:	90                   	nop
  800367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80036a:	c9                   	leave  
  80036b:	c3                   	ret    

0080036c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80036c:	55                   	push   %ebp
  80036d:	89 e5                	mov    %esp,%ebp
  80036f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800375:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80037c:	00 00 00 
	b.cnt = 0;
  80037f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800386:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800389:	ff 75 0c             	pushl  0xc(%ebp)
  80038c:	ff 75 08             	pushl  0x8(%ebp)
  80038f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800395:	50                   	push   %eax
  800396:	68 fb 02 80 00       	push   $0x8002fb
  80039b:	e8 5a 02 00 00       	call   8005fa <vprintfmt>
  8003a0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003a3:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003a9:	a0 40 30 80 00       	mov    0x803040,%al
  8003ae:	0f b6 c0             	movzbl %al,%eax
  8003b1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003b7:	52                   	push   %edx
  8003b8:	50                   	push   %eax
  8003b9:	51                   	push   %ecx
  8003ba:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c0:	83 c0 08             	add    $0x8,%eax
  8003c3:	50                   	push   %eax
  8003c4:	e8 22 0f 00 00       	call   8012eb <sys_cputs>
  8003c9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003cc:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8003d3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003d9:	c9                   	leave  
  8003da:	c3                   	ret    

008003db <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8003db:	55                   	push   %ebp
  8003dc:	89 e5                	mov    %esp,%ebp
  8003de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003e1:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8003e8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f1:	83 ec 08             	sub    $0x8,%esp
  8003f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f7:	50                   	push   %eax
  8003f8:	e8 6f ff ff ff       	call   80036c <vcprintf>
  8003fd:	83 c4 10             	add    $0x10,%esp
  800400:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800403:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800406:	c9                   	leave  
  800407:	c3                   	ret    

00800408 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800408:	55                   	push   %ebp
  800409:	89 e5                	mov    %esp,%ebp
  80040b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80040e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	c1 e0 08             	shl    $0x8,%eax
  80041b:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800420:	8d 45 0c             	lea    0xc(%ebp),%eax
  800423:	83 c0 04             	add    $0x4,%eax
  800426:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800429:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042c:	83 ec 08             	sub    $0x8,%esp
  80042f:	ff 75 f4             	pushl  -0xc(%ebp)
  800432:	50                   	push   %eax
  800433:	e8 34 ff ff ff       	call   80036c <vcprintf>
  800438:	83 c4 10             	add    $0x10,%esp
  80043b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80043e:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800445:	07 00 00 

	return cnt;
  800448:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80044b:	c9                   	leave  
  80044c:	c3                   	ret    

0080044d <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80044d:	55                   	push   %ebp
  80044e:	89 e5                	mov    %esp,%ebp
  800450:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800453:	e8 d7 0e 00 00       	call   80132f <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800458:	8d 45 0c             	lea    0xc(%ebp),%eax
  80045b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	83 ec 08             	sub    $0x8,%esp
  800464:	ff 75 f4             	pushl  -0xc(%ebp)
  800467:	50                   	push   %eax
  800468:	e8 ff fe ff ff       	call   80036c <vcprintf>
  80046d:	83 c4 10             	add    $0x10,%esp
  800470:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800473:	e8 d1 0e 00 00       	call   801349 <sys_unlock_cons>
	return cnt;
  800478:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	53                   	push   %ebx
  800481:	83 ec 14             	sub    $0x14,%esp
  800484:	8b 45 10             	mov    0x10(%ebp),%eax
  800487:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80048a:	8b 45 14             	mov    0x14(%ebp),%eax
  80048d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800490:	8b 45 18             	mov    0x18(%ebp),%eax
  800493:	ba 00 00 00 00       	mov    $0x0,%edx
  800498:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80049b:	77 55                	ja     8004f2 <printnum+0x75>
  80049d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004a0:	72 05                	jb     8004a7 <printnum+0x2a>
  8004a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004a5:	77 4b                	ja     8004f2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004a7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004aa:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004ad:	8b 45 18             	mov    0x18(%ebp),%eax
  8004b0:	ba 00 00 00 00       	mov    $0x0,%edx
  8004b5:	52                   	push   %edx
  8004b6:	50                   	push   %eax
  8004b7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ba:	ff 75 f0             	pushl  -0x10(%ebp)
  8004bd:	e8 62 15 00 00       	call   801a24 <__udivdi3>
  8004c2:	83 c4 10             	add    $0x10,%esp
  8004c5:	83 ec 04             	sub    $0x4,%esp
  8004c8:	ff 75 20             	pushl  0x20(%ebp)
  8004cb:	53                   	push   %ebx
  8004cc:	ff 75 18             	pushl  0x18(%ebp)
  8004cf:	52                   	push   %edx
  8004d0:	50                   	push   %eax
  8004d1:	ff 75 0c             	pushl  0xc(%ebp)
  8004d4:	ff 75 08             	pushl  0x8(%ebp)
  8004d7:	e8 a1 ff ff ff       	call   80047d <printnum>
  8004dc:	83 c4 20             	add    $0x20,%esp
  8004df:	eb 1a                	jmp    8004fb <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004e1:	83 ec 08             	sub    $0x8,%esp
  8004e4:	ff 75 0c             	pushl  0xc(%ebp)
  8004e7:	ff 75 20             	pushl  0x20(%ebp)
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	ff d0                	call   *%eax
  8004ef:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004f2:	ff 4d 1c             	decl   0x1c(%ebp)
  8004f5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004f9:	7f e6                	jg     8004e1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004fb:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004fe:	bb 00 00 00 00       	mov    $0x0,%ebx
  800503:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800506:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800509:	53                   	push   %ebx
  80050a:	51                   	push   %ecx
  80050b:	52                   	push   %edx
  80050c:	50                   	push   %eax
  80050d:	e8 22 16 00 00       	call   801b34 <__umoddi3>
  800512:	83 c4 10             	add    $0x10,%esp
  800515:	05 f4 20 80 00       	add    $0x8020f4,%eax
  80051a:	8a 00                	mov    (%eax),%al
  80051c:	0f be c0             	movsbl %al,%eax
  80051f:	83 ec 08             	sub    $0x8,%esp
  800522:	ff 75 0c             	pushl  0xc(%ebp)
  800525:	50                   	push   %eax
  800526:	8b 45 08             	mov    0x8(%ebp),%eax
  800529:	ff d0                	call   *%eax
  80052b:	83 c4 10             	add    $0x10,%esp
}
  80052e:	90                   	nop
  80052f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800532:	c9                   	leave  
  800533:	c3                   	ret    

00800534 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800534:	55                   	push   %ebp
  800535:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800537:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80053b:	7e 1c                	jle    800559 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	8d 50 08             	lea    0x8(%eax),%edx
  800545:	8b 45 08             	mov    0x8(%ebp),%eax
  800548:	89 10                	mov    %edx,(%eax)
  80054a:	8b 45 08             	mov    0x8(%ebp),%eax
  80054d:	8b 00                	mov    (%eax),%eax
  80054f:	83 e8 08             	sub    $0x8,%eax
  800552:	8b 50 04             	mov    0x4(%eax),%edx
  800555:	8b 00                	mov    (%eax),%eax
  800557:	eb 40                	jmp    800599 <getuint+0x65>
	else if (lflag)
  800559:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80055d:	74 1e                	je     80057d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80055f:	8b 45 08             	mov    0x8(%ebp),%eax
  800562:	8b 00                	mov    (%eax),%eax
  800564:	8d 50 04             	lea    0x4(%eax),%edx
  800567:	8b 45 08             	mov    0x8(%ebp),%eax
  80056a:	89 10                	mov    %edx,(%eax)
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	8b 00                	mov    (%eax),%eax
  800571:	83 e8 04             	sub    $0x4,%eax
  800574:	8b 00                	mov    (%eax),%eax
  800576:	ba 00 00 00 00       	mov    $0x0,%edx
  80057b:	eb 1c                	jmp    800599 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80057d:	8b 45 08             	mov    0x8(%ebp),%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	8d 50 04             	lea    0x4(%eax),%edx
  800585:	8b 45 08             	mov    0x8(%ebp),%eax
  800588:	89 10                	mov    %edx,(%eax)
  80058a:	8b 45 08             	mov    0x8(%ebp),%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	83 e8 04             	sub    $0x4,%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800599:	5d                   	pop    %ebp
  80059a:	c3                   	ret    

0080059b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80059b:	55                   	push   %ebp
  80059c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80059e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005a2:	7e 1c                	jle    8005c0 <getint+0x25>
		return va_arg(*ap, long long);
  8005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	8d 50 08             	lea    0x8(%eax),%edx
  8005ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8005af:	89 10                	mov    %edx,(%eax)
  8005b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	83 e8 08             	sub    $0x8,%eax
  8005b9:	8b 50 04             	mov    0x4(%eax),%edx
  8005bc:	8b 00                	mov    (%eax),%eax
  8005be:	eb 38                	jmp    8005f8 <getint+0x5d>
	else if (lflag)
  8005c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005c4:	74 1a                	je     8005e0 <getint+0x45>
		return va_arg(*ap, long);
  8005c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c9:	8b 00                	mov    (%eax),%eax
  8005cb:	8d 50 04             	lea    0x4(%eax),%edx
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	89 10                	mov    %edx,(%eax)
  8005d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	83 e8 04             	sub    $0x4,%eax
  8005db:	8b 00                	mov    (%eax),%eax
  8005dd:	99                   	cltd   
  8005de:	eb 18                	jmp    8005f8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e3:	8b 00                	mov    (%eax),%eax
  8005e5:	8d 50 04             	lea    0x4(%eax),%edx
  8005e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005eb:	89 10                	mov    %edx,(%eax)
  8005ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f0:	8b 00                	mov    (%eax),%eax
  8005f2:	83 e8 04             	sub    $0x4,%eax
  8005f5:	8b 00                	mov    (%eax),%eax
  8005f7:	99                   	cltd   
}
  8005f8:	5d                   	pop    %ebp
  8005f9:	c3                   	ret    

008005fa <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	56                   	push   %esi
  8005fe:	53                   	push   %ebx
  8005ff:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800602:	eb 17                	jmp    80061b <vprintfmt+0x21>
			if (ch == '\0')
  800604:	85 db                	test   %ebx,%ebx
  800606:	0f 84 c1 03 00 00    	je     8009cd <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80060c:	83 ec 08             	sub    $0x8,%esp
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	53                   	push   %ebx
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	ff d0                	call   *%eax
  800618:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80061b:	8b 45 10             	mov    0x10(%ebp),%eax
  80061e:	8d 50 01             	lea    0x1(%eax),%edx
  800621:	89 55 10             	mov    %edx,0x10(%ebp)
  800624:	8a 00                	mov    (%eax),%al
  800626:	0f b6 d8             	movzbl %al,%ebx
  800629:	83 fb 25             	cmp    $0x25,%ebx
  80062c:	75 d6                	jne    800604 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80062e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800632:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800639:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800640:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800647:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80064e:	8b 45 10             	mov    0x10(%ebp),%eax
  800651:	8d 50 01             	lea    0x1(%eax),%edx
  800654:	89 55 10             	mov    %edx,0x10(%ebp)
  800657:	8a 00                	mov    (%eax),%al
  800659:	0f b6 d8             	movzbl %al,%ebx
  80065c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80065f:	83 f8 5b             	cmp    $0x5b,%eax
  800662:	0f 87 3d 03 00 00    	ja     8009a5 <vprintfmt+0x3ab>
  800668:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  80066f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800671:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800675:	eb d7                	jmp    80064e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800677:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80067b:	eb d1                	jmp    80064e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80067d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800684:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800687:	89 d0                	mov    %edx,%eax
  800689:	c1 e0 02             	shl    $0x2,%eax
  80068c:	01 d0                	add    %edx,%eax
  80068e:	01 c0                	add    %eax,%eax
  800690:	01 d8                	add    %ebx,%eax
  800692:	83 e8 30             	sub    $0x30,%eax
  800695:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800698:	8b 45 10             	mov    0x10(%ebp),%eax
  80069b:	8a 00                	mov    (%eax),%al
  80069d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006a0:	83 fb 2f             	cmp    $0x2f,%ebx
  8006a3:	7e 3e                	jle    8006e3 <vprintfmt+0xe9>
  8006a5:	83 fb 39             	cmp    $0x39,%ebx
  8006a8:	7f 39                	jg     8006e3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006aa:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006ad:	eb d5                	jmp    800684 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006af:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b2:	83 c0 04             	add    $0x4,%eax
  8006b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8006b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006bb:	83 e8 04             	sub    $0x4,%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006c3:	eb 1f                	jmp    8006e4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006c5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c9:	79 83                	jns    80064e <vprintfmt+0x54>
				width = 0;
  8006cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006d2:	e9 77 ff ff ff       	jmp    80064e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006d7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006de:	e9 6b ff ff ff       	jmp    80064e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006e3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e8:	0f 89 60 ff ff ff    	jns    80064e <vprintfmt+0x54>
				width = precision, precision = -1;
  8006ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006f4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006fb:	e9 4e ff ff ff       	jmp    80064e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800700:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800703:	e9 46 ff ff ff       	jmp    80064e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800708:	8b 45 14             	mov    0x14(%ebp),%eax
  80070b:	83 c0 04             	add    $0x4,%eax
  80070e:	89 45 14             	mov    %eax,0x14(%ebp)
  800711:	8b 45 14             	mov    0x14(%ebp),%eax
  800714:	83 e8 04             	sub    $0x4,%eax
  800717:	8b 00                	mov    (%eax),%eax
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 0c             	pushl  0xc(%ebp)
  80071f:	50                   	push   %eax
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	ff d0                	call   *%eax
  800725:	83 c4 10             	add    $0x10,%esp
			break;
  800728:	e9 9b 02 00 00       	jmp    8009c8 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80072d:	8b 45 14             	mov    0x14(%ebp),%eax
  800730:	83 c0 04             	add    $0x4,%eax
  800733:	89 45 14             	mov    %eax,0x14(%ebp)
  800736:	8b 45 14             	mov    0x14(%ebp),%eax
  800739:	83 e8 04             	sub    $0x4,%eax
  80073c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80073e:	85 db                	test   %ebx,%ebx
  800740:	79 02                	jns    800744 <vprintfmt+0x14a>
				err = -err;
  800742:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800744:	83 fb 64             	cmp    $0x64,%ebx
  800747:	7f 0b                	jg     800754 <vprintfmt+0x15a>
  800749:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  800750:	85 f6                	test   %esi,%esi
  800752:	75 19                	jne    80076d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800754:	53                   	push   %ebx
  800755:	68 05 21 80 00       	push   $0x802105
  80075a:	ff 75 0c             	pushl  0xc(%ebp)
  80075d:	ff 75 08             	pushl  0x8(%ebp)
  800760:	e8 70 02 00 00       	call   8009d5 <printfmt>
  800765:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800768:	e9 5b 02 00 00       	jmp    8009c8 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80076d:	56                   	push   %esi
  80076e:	68 0e 21 80 00       	push   $0x80210e
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	ff 75 08             	pushl  0x8(%ebp)
  800779:	e8 57 02 00 00       	call   8009d5 <printfmt>
  80077e:	83 c4 10             	add    $0x10,%esp
			break;
  800781:	e9 42 02 00 00       	jmp    8009c8 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800786:	8b 45 14             	mov    0x14(%ebp),%eax
  800789:	83 c0 04             	add    $0x4,%eax
  80078c:	89 45 14             	mov    %eax,0x14(%ebp)
  80078f:	8b 45 14             	mov    0x14(%ebp),%eax
  800792:	83 e8 04             	sub    $0x4,%eax
  800795:	8b 30                	mov    (%eax),%esi
  800797:	85 f6                	test   %esi,%esi
  800799:	75 05                	jne    8007a0 <vprintfmt+0x1a6>
				p = "(null)";
  80079b:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  8007a0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a4:	7e 6d                	jle    800813 <vprintfmt+0x219>
  8007a6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007aa:	74 67                	je     800813 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	50                   	push   %eax
  8007b3:	56                   	push   %esi
  8007b4:	e8 1e 03 00 00       	call   800ad7 <strnlen>
  8007b9:	83 c4 10             	add    $0x10,%esp
  8007bc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007bf:	eb 16                	jmp    8007d7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007c1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007c5:	83 ec 08             	sub    $0x8,%esp
  8007c8:	ff 75 0c             	pushl  0xc(%ebp)
  8007cb:	50                   	push   %eax
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	ff d0                	call   *%eax
  8007d1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007d4:	ff 4d e4             	decl   -0x1c(%ebp)
  8007d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007db:	7f e4                	jg     8007c1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007dd:	eb 34                	jmp    800813 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007df:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007e3:	74 1c                	je     800801 <vprintfmt+0x207>
  8007e5:	83 fb 1f             	cmp    $0x1f,%ebx
  8007e8:	7e 05                	jle    8007ef <vprintfmt+0x1f5>
  8007ea:	83 fb 7e             	cmp    $0x7e,%ebx
  8007ed:	7e 12                	jle    800801 <vprintfmt+0x207>
					putch('?', putdat);
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	ff 75 0c             	pushl  0xc(%ebp)
  8007f5:	6a 3f                	push   $0x3f
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	ff d0                	call   *%eax
  8007fc:	83 c4 10             	add    $0x10,%esp
  8007ff:	eb 0f                	jmp    800810 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	53                   	push   %ebx
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800810:	ff 4d e4             	decl   -0x1c(%ebp)
  800813:	89 f0                	mov    %esi,%eax
  800815:	8d 70 01             	lea    0x1(%eax),%esi
  800818:	8a 00                	mov    (%eax),%al
  80081a:	0f be d8             	movsbl %al,%ebx
  80081d:	85 db                	test   %ebx,%ebx
  80081f:	74 24                	je     800845 <vprintfmt+0x24b>
  800821:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800825:	78 b8                	js     8007df <vprintfmt+0x1e5>
  800827:	ff 4d e0             	decl   -0x20(%ebp)
  80082a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80082e:	79 af                	jns    8007df <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800830:	eb 13                	jmp    800845 <vprintfmt+0x24b>
				putch(' ', putdat);
  800832:	83 ec 08             	sub    $0x8,%esp
  800835:	ff 75 0c             	pushl  0xc(%ebp)
  800838:	6a 20                	push   $0x20
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800842:	ff 4d e4             	decl   -0x1c(%ebp)
  800845:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800849:	7f e7                	jg     800832 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80084b:	e9 78 01 00 00       	jmp    8009c8 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800850:	83 ec 08             	sub    $0x8,%esp
  800853:	ff 75 e8             	pushl  -0x18(%ebp)
  800856:	8d 45 14             	lea    0x14(%ebp),%eax
  800859:	50                   	push   %eax
  80085a:	e8 3c fd ff ff       	call   80059b <getint>
  80085f:	83 c4 10             	add    $0x10,%esp
  800862:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800865:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800868:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80086e:	85 d2                	test   %edx,%edx
  800870:	79 23                	jns    800895 <vprintfmt+0x29b>
				putch('-', putdat);
  800872:	83 ec 08             	sub    $0x8,%esp
  800875:	ff 75 0c             	pushl  0xc(%ebp)
  800878:	6a 2d                	push   $0x2d
  80087a:	8b 45 08             	mov    0x8(%ebp),%eax
  80087d:	ff d0                	call   *%eax
  80087f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800882:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800885:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800888:	f7 d8                	neg    %eax
  80088a:	83 d2 00             	adc    $0x0,%edx
  80088d:	f7 da                	neg    %edx
  80088f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800892:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800895:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80089c:	e9 bc 00 00 00       	jmp    80095d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008a1:	83 ec 08             	sub    $0x8,%esp
  8008a4:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a7:	8d 45 14             	lea    0x14(%ebp),%eax
  8008aa:	50                   	push   %eax
  8008ab:	e8 84 fc ff ff       	call   800534 <getuint>
  8008b0:	83 c4 10             	add    $0x10,%esp
  8008b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008b9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008c0:	e9 98 00 00 00       	jmp    80095d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008c5:	83 ec 08             	sub    $0x8,%esp
  8008c8:	ff 75 0c             	pushl  0xc(%ebp)
  8008cb:	6a 58                	push   $0x58
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	ff d0                	call   *%eax
  8008d2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008d5:	83 ec 08             	sub    $0x8,%esp
  8008d8:	ff 75 0c             	pushl  0xc(%ebp)
  8008db:	6a 58                	push   $0x58
  8008dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e0:	ff d0                	call   *%eax
  8008e2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008e5:	83 ec 08             	sub    $0x8,%esp
  8008e8:	ff 75 0c             	pushl  0xc(%ebp)
  8008eb:	6a 58                	push   $0x58
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	ff d0                	call   *%eax
  8008f2:	83 c4 10             	add    $0x10,%esp
			break;
  8008f5:	e9 ce 00 00 00       	jmp    8009c8 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	6a 30                	push   $0x30
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	ff d0                	call   *%eax
  800907:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80090a:	83 ec 08             	sub    $0x8,%esp
  80090d:	ff 75 0c             	pushl  0xc(%ebp)
  800910:	6a 78                	push   $0x78
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	ff d0                	call   *%eax
  800917:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80091a:	8b 45 14             	mov    0x14(%ebp),%eax
  80091d:	83 c0 04             	add    $0x4,%eax
  800920:	89 45 14             	mov    %eax,0x14(%ebp)
  800923:	8b 45 14             	mov    0x14(%ebp),%eax
  800926:	83 e8 04             	sub    $0x4,%eax
  800929:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80092b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80092e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800935:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80093c:	eb 1f                	jmp    80095d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 e8             	pushl  -0x18(%ebp)
  800944:	8d 45 14             	lea    0x14(%ebp),%eax
  800947:	50                   	push   %eax
  800948:	e8 e7 fb ff ff       	call   800534 <getuint>
  80094d:	83 c4 10             	add    $0x10,%esp
  800950:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800953:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800956:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80095d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800961:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800964:	83 ec 04             	sub    $0x4,%esp
  800967:	52                   	push   %edx
  800968:	ff 75 e4             	pushl  -0x1c(%ebp)
  80096b:	50                   	push   %eax
  80096c:	ff 75 f4             	pushl  -0xc(%ebp)
  80096f:	ff 75 f0             	pushl  -0x10(%ebp)
  800972:	ff 75 0c             	pushl  0xc(%ebp)
  800975:	ff 75 08             	pushl  0x8(%ebp)
  800978:	e8 00 fb ff ff       	call   80047d <printnum>
  80097d:	83 c4 20             	add    $0x20,%esp
			break;
  800980:	eb 46                	jmp    8009c8 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	53                   	push   %ebx
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	ff d0                	call   *%eax
  80098e:	83 c4 10             	add    $0x10,%esp
			break;
  800991:	eb 35                	jmp    8009c8 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800993:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  80099a:	eb 2c                	jmp    8009c8 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80099c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009a3:	eb 23                	jmp    8009c8 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	6a 25                	push   $0x25
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	ff d0                	call   *%eax
  8009b2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009b5:	ff 4d 10             	decl   0x10(%ebp)
  8009b8:	eb 03                	jmp    8009bd <vprintfmt+0x3c3>
  8009ba:	ff 4d 10             	decl   0x10(%ebp)
  8009bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c0:	48                   	dec    %eax
  8009c1:	8a 00                	mov    (%eax),%al
  8009c3:	3c 25                	cmp    $0x25,%al
  8009c5:	75 f3                	jne    8009ba <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8009c7:	90                   	nop
		}
	}
  8009c8:	e9 35 fc ff ff       	jmp    800602 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009cd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009d1:	5b                   	pop    %ebx
  8009d2:	5e                   	pop    %esi
  8009d3:	5d                   	pop    %ebp
  8009d4:	c3                   	ret    

008009d5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009d5:	55                   	push   %ebp
  8009d6:	89 e5                	mov    %esp,%ebp
  8009d8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009db:	8d 45 10             	lea    0x10(%ebp),%eax
  8009de:	83 c0 04             	add    $0x4,%eax
  8009e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ea:	50                   	push   %eax
  8009eb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ee:	ff 75 08             	pushl  0x8(%ebp)
  8009f1:	e8 04 fc ff ff       	call   8005fa <vprintfmt>
  8009f6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009f9:	90                   	nop
  8009fa:	c9                   	leave  
  8009fb:	c3                   	ret    

008009fc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009fc:	55                   	push   %ebp
  8009fd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a02:	8b 40 08             	mov    0x8(%eax),%eax
  800a05:	8d 50 01             	lea    0x1(%eax),%edx
  800a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a11:	8b 10                	mov    (%eax),%edx
  800a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a16:	8b 40 04             	mov    0x4(%eax),%eax
  800a19:	39 c2                	cmp    %eax,%edx
  800a1b:	73 12                	jae    800a2f <sprintputch+0x33>
		*b->buf++ = ch;
  800a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a20:	8b 00                	mov    (%eax),%eax
  800a22:	8d 48 01             	lea    0x1(%eax),%ecx
  800a25:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a28:	89 0a                	mov    %ecx,(%edx)
  800a2a:	8b 55 08             	mov    0x8(%ebp),%edx
  800a2d:	88 10                	mov    %dl,(%eax)
}
  800a2f:	90                   	nop
  800a30:	5d                   	pop    %ebp
  800a31:	c3                   	ret    

00800a32 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a32:	55                   	push   %ebp
  800a33:	89 e5                	mov    %esp,%ebp
  800a35:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a41:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a44:	8b 45 08             	mov    0x8(%ebp),%eax
  800a47:	01 d0                	add    %edx,%eax
  800a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a53:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a57:	74 06                	je     800a5f <vsnprintf+0x2d>
  800a59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a5d:	7f 07                	jg     800a66 <vsnprintf+0x34>
		return -E_INVAL;
  800a5f:	b8 03 00 00 00       	mov    $0x3,%eax
  800a64:	eb 20                	jmp    800a86 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a66:	ff 75 14             	pushl  0x14(%ebp)
  800a69:	ff 75 10             	pushl  0x10(%ebp)
  800a6c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a6f:	50                   	push   %eax
  800a70:	68 fc 09 80 00       	push   $0x8009fc
  800a75:	e8 80 fb ff ff       	call   8005fa <vprintfmt>
  800a7a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a80:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a86:	c9                   	leave  
  800a87:	c3                   	ret    

00800a88 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a8e:	8d 45 10             	lea    0x10(%ebp),%eax
  800a91:	83 c0 04             	add    $0x4,%eax
  800a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a97:	8b 45 10             	mov    0x10(%ebp),%eax
  800a9a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a9d:	50                   	push   %eax
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	ff 75 08             	pushl  0x8(%ebp)
  800aa4:	e8 89 ff ff ff       	call   800a32 <vsnprintf>
  800aa9:	83 c4 10             	add    $0x10,%esp
  800aac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
  800ab7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800aba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ac1:	eb 06                	jmp    800ac9 <strlen+0x15>
		n++;
  800ac3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ac6:	ff 45 08             	incl   0x8(%ebp)
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	8a 00                	mov    (%eax),%al
  800ace:	84 c0                	test   %al,%al
  800ad0:	75 f1                	jne    800ac3 <strlen+0xf>
		n++;
	return n;
  800ad2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ad5:	c9                   	leave  
  800ad6:	c3                   	ret    

00800ad7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ad7:	55                   	push   %ebp
  800ad8:	89 e5                	mov    %esp,%ebp
  800ada:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800add:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ae4:	eb 09                	jmp    800aef <strnlen+0x18>
		n++;
  800ae6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ae9:	ff 45 08             	incl   0x8(%ebp)
  800aec:	ff 4d 0c             	decl   0xc(%ebp)
  800aef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af3:	74 09                	je     800afe <strnlen+0x27>
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	84 c0                	test   %al,%al
  800afc:	75 e8                	jne    800ae6 <strnlen+0xf>
		n++;
	return n;
  800afe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b01:	c9                   	leave  
  800b02:	c3                   	ret    

00800b03 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
  800b06:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b0f:	90                   	nop
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8d 50 01             	lea    0x1(%eax),%edx
  800b16:	89 55 08             	mov    %edx,0x8(%ebp)
  800b19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b1c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b1f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b22:	8a 12                	mov    (%edx),%dl
  800b24:	88 10                	mov    %dl,(%eax)
  800b26:	8a 00                	mov    (%eax),%al
  800b28:	84 c0                	test   %al,%al
  800b2a:	75 e4                	jne    800b10 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b2f:	c9                   	leave  
  800b30:	c3                   	ret    

00800b31 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b31:	55                   	push   %ebp
  800b32:	89 e5                	mov    %esp,%ebp
  800b34:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b44:	eb 1f                	jmp    800b65 <strncpy+0x34>
		*dst++ = *src;
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	8d 50 01             	lea    0x1(%eax),%edx
  800b4c:	89 55 08             	mov    %edx,0x8(%ebp)
  800b4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b52:	8a 12                	mov    (%edx),%dl
  800b54:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b59:	8a 00                	mov    (%eax),%al
  800b5b:	84 c0                	test   %al,%al
  800b5d:	74 03                	je     800b62 <strncpy+0x31>
			src++;
  800b5f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b62:	ff 45 fc             	incl   -0x4(%ebp)
  800b65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b68:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b6b:	72 d9                	jb     800b46 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b70:	c9                   	leave  
  800b71:	c3                   	ret    

00800b72 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b72:	55                   	push   %ebp
  800b73:	89 e5                	mov    %esp,%ebp
  800b75:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b82:	74 30                	je     800bb4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b84:	eb 16                	jmp    800b9c <strlcpy+0x2a>
			*dst++ = *src++;
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8d 50 01             	lea    0x1(%eax),%edx
  800b8c:	89 55 08             	mov    %edx,0x8(%ebp)
  800b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b92:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b95:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b98:	8a 12                	mov    (%edx),%dl
  800b9a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b9c:	ff 4d 10             	decl   0x10(%ebp)
  800b9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ba3:	74 09                	je     800bae <strlcpy+0x3c>
  800ba5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba8:	8a 00                	mov    (%eax),%al
  800baa:	84 c0                	test   %al,%al
  800bac:	75 d8                	jne    800b86 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bb4:	8b 55 08             	mov    0x8(%ebp),%edx
  800bb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bba:	29 c2                	sub    %eax,%edx
  800bbc:	89 d0                	mov    %edx,%eax
}
  800bbe:	c9                   	leave  
  800bbf:	c3                   	ret    

00800bc0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bc0:	55                   	push   %ebp
  800bc1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bc3:	eb 06                	jmp    800bcb <strcmp+0xb>
		p++, q++;
  800bc5:	ff 45 08             	incl   0x8(%ebp)
  800bc8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	84 c0                	test   %al,%al
  800bd2:	74 0e                	je     800be2 <strcmp+0x22>
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	8a 10                	mov    (%eax),%dl
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	38 c2                	cmp    %al,%dl
  800be0:	74 e3                	je     800bc5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	0f b6 d0             	movzbl %al,%edx
  800bea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bed:	8a 00                	mov    (%eax),%al
  800bef:	0f b6 c0             	movzbl %al,%eax
  800bf2:	29 c2                	sub    %eax,%edx
  800bf4:	89 d0                	mov    %edx,%eax
}
  800bf6:	5d                   	pop    %ebp
  800bf7:	c3                   	ret    

00800bf8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bf8:	55                   	push   %ebp
  800bf9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bfb:	eb 09                	jmp    800c06 <strncmp+0xe>
		n--, p++, q++;
  800bfd:	ff 4d 10             	decl   0x10(%ebp)
  800c00:	ff 45 08             	incl   0x8(%ebp)
  800c03:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c0a:	74 17                	je     800c23 <strncmp+0x2b>
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	8a 00                	mov    (%eax),%al
  800c11:	84 c0                	test   %al,%al
  800c13:	74 0e                	je     800c23 <strncmp+0x2b>
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	8a 10                	mov    (%eax),%dl
  800c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1d:	8a 00                	mov    (%eax),%al
  800c1f:	38 c2                	cmp    %al,%dl
  800c21:	74 da                	je     800bfd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c23:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c27:	75 07                	jne    800c30 <strncmp+0x38>
		return 0;
  800c29:	b8 00 00 00 00       	mov    $0x0,%eax
  800c2e:	eb 14                	jmp    800c44 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	8a 00                	mov    (%eax),%al
  800c35:	0f b6 d0             	movzbl %al,%edx
  800c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3b:	8a 00                	mov    (%eax),%al
  800c3d:	0f b6 c0             	movzbl %al,%eax
  800c40:	29 c2                	sub    %eax,%edx
  800c42:	89 d0                	mov    %edx,%eax
}
  800c44:	5d                   	pop    %ebp
  800c45:	c3                   	ret    

00800c46 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c46:	55                   	push   %ebp
  800c47:	89 e5                	mov    %esp,%ebp
  800c49:	83 ec 04             	sub    $0x4,%esp
  800c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c52:	eb 12                	jmp    800c66 <strchr+0x20>
		if (*s == c)
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8a 00                	mov    (%eax),%al
  800c59:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c5c:	75 05                	jne    800c63 <strchr+0x1d>
			return (char *) s;
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	eb 11                	jmp    800c74 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c63:	ff 45 08             	incl   0x8(%ebp)
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	8a 00                	mov    (%eax),%al
  800c6b:	84 c0                	test   %al,%al
  800c6d:	75 e5                	jne    800c54 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c74:	c9                   	leave  
  800c75:	c3                   	ret    

00800c76 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c76:	55                   	push   %ebp
  800c77:	89 e5                	mov    %esp,%ebp
  800c79:	83 ec 04             	sub    $0x4,%esp
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c82:	eb 0d                	jmp    800c91 <strfind+0x1b>
		if (*s == c)
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c8c:	74 0e                	je     800c9c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c8e:	ff 45 08             	incl   0x8(%ebp)
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	84 c0                	test   %al,%al
  800c98:	75 ea                	jne    800c84 <strfind+0xe>
  800c9a:	eb 01                	jmp    800c9d <strfind+0x27>
		if (*s == c)
			break;
  800c9c:	90                   	nop
	return (char *) s;
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ca0:	c9                   	leave  
  800ca1:	c3                   	ret    

00800ca2 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800ca2:	55                   	push   %ebp
  800ca3:	89 e5                	mov    %esp,%ebp
  800ca5:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800cae:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800cb2:	76 63                	jbe    800d17 <memset+0x75>
		uint64 data_block = c;
  800cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb7:	99                   	cltd   
  800cb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cbb:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cc4:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800cc8:	c1 e0 08             	shl    $0x8,%eax
  800ccb:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cce:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800cd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cd7:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800cdb:	c1 e0 10             	shl    $0x10,%eax
  800cde:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ce1:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800ce4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ce7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cea:	89 c2                	mov    %eax,%edx
  800cec:	b8 00 00 00 00       	mov    $0x0,%eax
  800cf1:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cf4:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800cf7:	eb 18                	jmp    800d11 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800cf9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800cfc:	8d 41 08             	lea    0x8(%ecx),%eax
  800cff:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d08:	89 01                	mov    %eax,(%ecx)
  800d0a:	89 51 04             	mov    %edx,0x4(%ecx)
  800d0d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d11:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d15:	77 e2                	ja     800cf9 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d17:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1b:	74 23                	je     800d40 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d20:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d23:	eb 0e                	jmp    800d33 <memset+0x91>
			*p8++ = (uint8)c;
  800d25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d28:	8d 50 01             	lea    0x1(%eax),%edx
  800d2b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d31:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d33:	8b 45 10             	mov    0x10(%ebp),%eax
  800d36:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d39:	89 55 10             	mov    %edx,0x10(%ebp)
  800d3c:	85 c0                	test   %eax,%eax
  800d3e:	75 e5                	jne    800d25 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d57:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d5b:	76 24                	jbe    800d81 <memcpy+0x3c>
		while(n >= 8){
  800d5d:	eb 1c                	jmp    800d7b <memcpy+0x36>
			*d64 = *s64;
  800d5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d62:	8b 50 04             	mov    0x4(%eax),%edx
  800d65:	8b 00                	mov    (%eax),%eax
  800d67:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d6a:	89 01                	mov    %eax,(%ecx)
  800d6c:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d6f:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d73:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d77:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d7b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d7f:	77 de                	ja     800d5f <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d85:	74 31                	je     800db8 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d90:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800d93:	eb 16                	jmp    800dab <memcpy+0x66>
			*d8++ = *s8++;
  800d95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d98:	8d 50 01             	lea    0x1(%eax),%edx
  800d9b:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800d9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da4:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800da7:	8a 12                	mov    (%edx),%dl
  800da9:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800dab:	8b 45 10             	mov    0x10(%ebp),%eax
  800dae:	8d 50 ff             	lea    -0x1(%eax),%edx
  800db1:	89 55 10             	mov    %edx,0x10(%ebp)
  800db4:	85 c0                	test   %eax,%eax
  800db6:	75 dd                	jne    800d95 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dbb:	c9                   	leave  
  800dbc:	c3                   	ret    

00800dbd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dbd:	55                   	push   %ebp
  800dbe:	89 e5                	mov    %esp,%ebp
  800dc0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd5:	73 50                	jae    800e27 <memmove+0x6a>
  800dd7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dda:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddd:	01 d0                	add    %edx,%eax
  800ddf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de2:	76 43                	jbe    800e27 <memmove+0x6a>
		s += n;
  800de4:	8b 45 10             	mov    0x10(%ebp),%eax
  800de7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dea:	8b 45 10             	mov    0x10(%ebp),%eax
  800ded:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800df0:	eb 10                	jmp    800e02 <memmove+0x45>
			*--d = *--s;
  800df2:	ff 4d f8             	decl   -0x8(%ebp)
  800df5:	ff 4d fc             	decl   -0x4(%ebp)
  800df8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dfb:	8a 10                	mov    (%eax),%dl
  800dfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e00:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e02:	8b 45 10             	mov    0x10(%ebp),%eax
  800e05:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e08:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0b:	85 c0                	test   %eax,%eax
  800e0d:	75 e3                	jne    800df2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e0f:	eb 23                	jmp    800e34 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e14:	8d 50 01             	lea    0x1(%eax),%edx
  800e17:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e1d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e20:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e23:	8a 12                	mov    (%edx),%dl
  800e25:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e27:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e2d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e30:	85 c0                	test   %eax,%eax
  800e32:	75 dd                	jne    800e11 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e37:	c9                   	leave  
  800e38:	c3                   	ret    

00800e39 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e39:	55                   	push   %ebp
  800e3a:	89 e5                	mov    %esp,%ebp
  800e3c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e48:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e4b:	eb 2a                	jmp    800e77 <memcmp+0x3e>
		if (*s1 != *s2)
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e50:	8a 10                	mov    (%eax),%dl
  800e52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e55:	8a 00                	mov    (%eax),%al
  800e57:	38 c2                	cmp    %al,%dl
  800e59:	74 16                	je     800e71 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	0f b6 d0             	movzbl %al,%edx
  800e63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	0f b6 c0             	movzbl %al,%eax
  800e6b:	29 c2                	sub    %eax,%edx
  800e6d:	89 d0                	mov    %edx,%eax
  800e6f:	eb 18                	jmp    800e89 <memcmp+0x50>
		s1++, s2++;
  800e71:	ff 45 fc             	incl   -0x4(%ebp)
  800e74:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e77:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e7d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e80:	85 c0                	test   %eax,%eax
  800e82:	75 c9                	jne    800e4d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e84:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e89:	c9                   	leave  
  800e8a:	c3                   	ret    

00800e8b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e8b:	55                   	push   %ebp
  800e8c:	89 e5                	mov    %esp,%ebp
  800e8e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e91:	8b 55 08             	mov    0x8(%ebp),%edx
  800e94:	8b 45 10             	mov    0x10(%ebp),%eax
  800e97:	01 d0                	add    %edx,%eax
  800e99:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e9c:	eb 15                	jmp    800eb3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	0f b6 d0             	movzbl %al,%edx
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	0f b6 c0             	movzbl %al,%eax
  800eac:	39 c2                	cmp    %eax,%edx
  800eae:	74 0d                	je     800ebd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800eb0:	ff 45 08             	incl   0x8(%ebp)
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eb9:	72 e3                	jb     800e9e <memfind+0x13>
  800ebb:	eb 01                	jmp    800ebe <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ebd:	90                   	nop
	return (void *) s;
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec1:	c9                   	leave  
  800ec2:	c3                   	ret    

00800ec3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ec3:	55                   	push   %ebp
  800ec4:	89 e5                	mov    %esp,%ebp
  800ec6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ec9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ed0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed7:	eb 03                	jmp    800edc <strtol+0x19>
		s++;
  800ed9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	8a 00                	mov    (%eax),%al
  800ee1:	3c 20                	cmp    $0x20,%al
  800ee3:	74 f4                	je     800ed9 <strtol+0x16>
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	3c 09                	cmp    $0x9,%al
  800eec:	74 eb                	je     800ed9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 2b                	cmp    $0x2b,%al
  800ef5:	75 05                	jne    800efc <strtol+0x39>
		s++;
  800ef7:	ff 45 08             	incl   0x8(%ebp)
  800efa:	eb 13                	jmp    800f0f <strtol+0x4c>
	else if (*s == '-')
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	3c 2d                	cmp    $0x2d,%al
  800f03:	75 0a                	jne    800f0f <strtol+0x4c>
		s++, neg = 1;
  800f05:	ff 45 08             	incl   0x8(%ebp)
  800f08:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f13:	74 06                	je     800f1b <strtol+0x58>
  800f15:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f19:	75 20                	jne    800f3b <strtol+0x78>
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	3c 30                	cmp    $0x30,%al
  800f22:	75 17                	jne    800f3b <strtol+0x78>
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	40                   	inc    %eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 78                	cmp    $0x78,%al
  800f2c:	75 0d                	jne    800f3b <strtol+0x78>
		s += 2, base = 16;
  800f2e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f32:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f39:	eb 28                	jmp    800f63 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3f:	75 15                	jne    800f56 <strtol+0x93>
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3c 30                	cmp    $0x30,%al
  800f48:	75 0c                	jne    800f56 <strtol+0x93>
		s++, base = 8;
  800f4a:	ff 45 08             	incl   0x8(%ebp)
  800f4d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f54:	eb 0d                	jmp    800f63 <strtol+0xa0>
	else if (base == 0)
  800f56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5a:	75 07                	jne    800f63 <strtol+0xa0>
		base = 10;
  800f5c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	3c 2f                	cmp    $0x2f,%al
  800f6a:	7e 19                	jle    800f85 <strtol+0xc2>
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3c 39                	cmp    $0x39,%al
  800f73:	7f 10                	jg     800f85 <strtol+0xc2>
			dig = *s - '0';
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f be c0             	movsbl %al,%eax
  800f7d:	83 e8 30             	sub    $0x30,%eax
  800f80:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f83:	eb 42                	jmp    800fc7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	3c 60                	cmp    $0x60,%al
  800f8c:	7e 19                	jle    800fa7 <strtol+0xe4>
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	3c 7a                	cmp    $0x7a,%al
  800f95:	7f 10                	jg     800fa7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	0f be c0             	movsbl %al,%eax
  800f9f:	83 e8 57             	sub    $0x57,%eax
  800fa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa5:	eb 20                	jmp    800fc7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	3c 40                	cmp    $0x40,%al
  800fae:	7e 39                	jle    800fe9 <strtol+0x126>
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	3c 5a                	cmp    $0x5a,%al
  800fb7:	7f 30                	jg     800fe9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	8a 00                	mov    (%eax),%al
  800fbe:	0f be c0             	movsbl %al,%eax
  800fc1:	83 e8 37             	sub    $0x37,%eax
  800fc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fca:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fcd:	7d 19                	jge    800fe8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fcf:	ff 45 08             	incl   0x8(%ebp)
  800fd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fd9:	89 c2                	mov    %eax,%edx
  800fdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fde:	01 d0                	add    %edx,%eax
  800fe0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fe3:	e9 7b ff ff ff       	jmp    800f63 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fe8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fe9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fed:	74 08                	je     800ff7 <strtol+0x134>
		*endptr = (char *) s;
  800fef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff2:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ff7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ffb:	74 07                	je     801004 <strtol+0x141>
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	f7 d8                	neg    %eax
  801002:	eb 03                	jmp    801007 <strtol+0x144>
  801004:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801007:	c9                   	leave  
  801008:	c3                   	ret    

00801009 <ltostr>:

void
ltostr(long value, char *str)
{
  801009:	55                   	push   %ebp
  80100a:	89 e5                	mov    %esp,%ebp
  80100c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80100f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801016:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80101d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801021:	79 13                	jns    801036 <ltostr+0x2d>
	{
		neg = 1;
  801023:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80102a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801030:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801033:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80103e:	99                   	cltd   
  80103f:	f7 f9                	idiv   %ecx
  801041:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801044:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801047:	8d 50 01             	lea    0x1(%eax),%edx
  80104a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80104d:	89 c2                	mov    %eax,%edx
  80104f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801057:	83 c2 30             	add    $0x30,%edx
  80105a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80105c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80105f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801064:	f7 e9                	imul   %ecx
  801066:	c1 fa 02             	sar    $0x2,%edx
  801069:	89 c8                	mov    %ecx,%eax
  80106b:	c1 f8 1f             	sar    $0x1f,%eax
  80106e:	29 c2                	sub    %eax,%edx
  801070:	89 d0                	mov    %edx,%eax
  801072:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801075:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801079:	75 bb                	jne    801036 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80107b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801082:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801085:	48                   	dec    %eax
  801086:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801089:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80108d:	74 3d                	je     8010cc <ltostr+0xc3>
		start = 1 ;
  80108f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801096:	eb 34                	jmp    8010cc <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801098:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ab:	01 c2                	add    %eax,%edx
  8010ad:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	01 c8                	add    %ecx,%eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bf:	01 c2                	add    %eax,%edx
  8010c1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010c4:	88 02                	mov    %al,(%edx)
		start++ ;
  8010c6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010c9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010d2:	7c c4                	jl     801098 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	01 d0                	add    %edx,%eax
  8010dc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010df:	90                   	nop
  8010e0:	c9                   	leave  
  8010e1:	c3                   	ret    

008010e2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
  8010e5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010e8:	ff 75 08             	pushl  0x8(%ebp)
  8010eb:	e8 c4 f9 ff ff       	call   800ab4 <strlen>
  8010f0:	83 c4 04             	add    $0x4,%esp
  8010f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010f6:	ff 75 0c             	pushl  0xc(%ebp)
  8010f9:	e8 b6 f9 ff ff       	call   800ab4 <strlen>
  8010fe:	83 c4 04             	add    $0x4,%esp
  801101:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80110b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801112:	eb 17                	jmp    80112b <strcconcat+0x49>
		final[s] = str1[s] ;
  801114:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801117:	8b 45 10             	mov    0x10(%ebp),%eax
  80111a:	01 c2                	add    %eax,%edx
  80111c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
  801122:	01 c8                	add    %ecx,%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801128:	ff 45 fc             	incl   -0x4(%ebp)
  80112b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801131:	7c e1                	jl     801114 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801133:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80113a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801141:	eb 1f                	jmp    801162 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801143:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801146:	8d 50 01             	lea    0x1(%eax),%edx
  801149:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80114c:	89 c2                	mov    %eax,%edx
  80114e:	8b 45 10             	mov    0x10(%ebp),%eax
  801151:	01 c2                	add    %eax,%edx
  801153:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	01 c8                	add    %ecx,%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80115f:	ff 45 f8             	incl   -0x8(%ebp)
  801162:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801165:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801168:	7c d9                	jl     801143 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80116a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116d:	8b 45 10             	mov    0x10(%ebp),%eax
  801170:	01 d0                	add    %edx,%eax
  801172:	c6 00 00             	movb   $0x0,(%eax)
}
  801175:	90                   	nop
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80117b:	8b 45 14             	mov    0x14(%ebp),%eax
  80117e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801184:	8b 45 14             	mov    0x14(%ebp),%eax
  801187:	8b 00                	mov    (%eax),%eax
  801189:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801190:	8b 45 10             	mov    0x10(%ebp),%eax
  801193:	01 d0                	add    %edx,%eax
  801195:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119b:	eb 0c                	jmp    8011a9 <strsplit+0x31>
			*string++ = 0;
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8d 50 01             	lea    0x1(%eax),%edx
  8011a3:	89 55 08             	mov    %edx,0x8(%ebp)
  8011a6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ac:	8a 00                	mov    (%eax),%al
  8011ae:	84 c0                	test   %al,%al
  8011b0:	74 18                	je     8011ca <strsplit+0x52>
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	0f be c0             	movsbl %al,%eax
  8011ba:	50                   	push   %eax
  8011bb:	ff 75 0c             	pushl  0xc(%ebp)
  8011be:	e8 83 fa ff ff       	call   800c46 <strchr>
  8011c3:	83 c4 08             	add    $0x8,%esp
  8011c6:	85 c0                	test   %eax,%eax
  8011c8:	75 d3                	jne    80119d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	84 c0                	test   %al,%al
  8011d1:	74 5a                	je     80122d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d6:	8b 00                	mov    (%eax),%eax
  8011d8:	83 f8 0f             	cmp    $0xf,%eax
  8011db:	75 07                	jne    8011e4 <strsplit+0x6c>
		{
			return 0;
  8011dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8011e2:	eb 66                	jmp    80124a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e7:	8b 00                	mov    (%eax),%eax
  8011e9:	8d 48 01             	lea    0x1(%eax),%ecx
  8011ec:	8b 55 14             	mov    0x14(%ebp),%edx
  8011ef:	89 0a                	mov    %ecx,(%edx)
  8011f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fb:	01 c2                	add    %eax,%edx
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801202:	eb 03                	jmp    801207 <strsplit+0x8f>
			string++;
  801204:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	84 c0                	test   %al,%al
  80120e:	74 8b                	je     80119b <strsplit+0x23>
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	0f be c0             	movsbl %al,%eax
  801218:	50                   	push   %eax
  801219:	ff 75 0c             	pushl  0xc(%ebp)
  80121c:	e8 25 fa ff ff       	call   800c46 <strchr>
  801221:	83 c4 08             	add    $0x8,%esp
  801224:	85 c0                	test   %eax,%eax
  801226:	74 dc                	je     801204 <strsplit+0x8c>
			string++;
	}
  801228:	e9 6e ff ff ff       	jmp    80119b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80122d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80122e:	8b 45 14             	mov    0x14(%ebp),%eax
  801231:	8b 00                	mov    (%eax),%eax
  801233:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123a:	8b 45 10             	mov    0x10(%ebp),%eax
  80123d:	01 d0                	add    %edx,%eax
  80123f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801245:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
  80124f:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80125f:	eb 4a                	jmp    8012ab <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801261:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	01 c2                	add    %eax,%edx
  801269:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	01 c8                	add    %ecx,%eax
  801271:	8a 00                	mov    (%eax),%al
  801273:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801275:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	3c 40                	cmp    $0x40,%al
  801281:	7e 25                	jle    8012a8 <str2lower+0x5c>
  801283:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	01 d0                	add    %edx,%eax
  80128b:	8a 00                	mov    (%eax),%al
  80128d:	3c 5a                	cmp    $0x5a,%al
  80128f:	7f 17                	jg     8012a8 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801291:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	01 d0                	add    %edx,%eax
  801299:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80129c:	8b 55 08             	mov    0x8(%ebp),%edx
  80129f:	01 ca                	add    %ecx,%edx
  8012a1:	8a 12                	mov    (%edx),%dl
  8012a3:	83 c2 20             	add    $0x20,%edx
  8012a6:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012a8:	ff 45 fc             	incl   -0x4(%ebp)
  8012ab:	ff 75 0c             	pushl  0xc(%ebp)
  8012ae:	e8 01 f8 ff ff       	call   800ab4 <strlen>
  8012b3:	83 c4 04             	add    $0x4,%esp
  8012b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012b9:	7f a6                	jg     801261 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8012bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012be:	c9                   	leave  
  8012bf:	c3                   	ret    

008012c0 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
  8012c3:	57                   	push   %edi
  8012c4:	56                   	push   %esi
  8012c5:	53                   	push   %ebx
  8012c6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012d5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012d8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012db:	cd 30                	int    $0x30
  8012dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012e3:	83 c4 10             	add    $0x10,%esp
  8012e6:	5b                   	pop    %ebx
  8012e7:	5e                   	pop    %esi
  8012e8:	5f                   	pop    %edi
  8012e9:	5d                   	pop    %ebp
  8012ea:	c3                   	ret    

008012eb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 04             	sub    $0x4,%esp
  8012f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8012f7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012fa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	6a 00                	push   $0x0
  801303:	51                   	push   %ecx
  801304:	52                   	push   %edx
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	50                   	push   %eax
  801309:	6a 00                	push   $0x0
  80130b:	e8 b0 ff ff ff       	call   8012c0 <syscall>
  801310:	83 c4 18             	add    $0x18,%esp
}
  801313:	90                   	nop
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_cgetc>:

int
sys_cgetc(void)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 02                	push   $0x2
  801325:	e8 96 ff ff ff       	call   8012c0 <syscall>
  80132a:	83 c4 18             	add    $0x18,%esp
}
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <sys_lock_cons>:

void sys_lock_cons(void)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 03                	push   $0x3
  80133e:	e8 7d ff ff ff       	call   8012c0 <syscall>
  801343:	83 c4 18             	add    $0x18,%esp
}
  801346:	90                   	nop
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 04                	push   $0x4
  801358:	e8 63 ff ff ff       	call   8012c0 <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	90                   	nop
  801361:	c9                   	leave  
  801362:	c3                   	ret    

00801363 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801366:	8b 55 0c             	mov    0xc(%ebp),%edx
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	52                   	push   %edx
  801373:	50                   	push   %eax
  801374:	6a 08                	push   $0x8
  801376:	e8 45 ff ff ff       	call   8012c0 <syscall>
  80137b:	83 c4 18             	add    $0x18,%esp
}
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
  801383:	56                   	push   %esi
  801384:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801385:	8b 75 18             	mov    0x18(%ebp),%esi
  801388:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80138b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80138e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	56                   	push   %esi
  801395:	53                   	push   %ebx
  801396:	51                   	push   %ecx
  801397:	52                   	push   %edx
  801398:	50                   	push   %eax
  801399:	6a 09                	push   $0x9
  80139b:	e8 20 ff ff ff       	call   8012c0 <syscall>
  8013a0:	83 c4 18             	add    $0x18,%esp
}
  8013a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013a6:	5b                   	pop    %ebx
  8013a7:	5e                   	pop    %esi
  8013a8:	5d                   	pop    %ebp
  8013a9:	c3                   	ret    

008013aa <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	ff 75 08             	pushl  0x8(%ebp)
  8013b8:	6a 0a                	push   $0xa
  8013ba:	e8 01 ff ff ff       	call   8012c0 <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	ff 75 0c             	pushl  0xc(%ebp)
  8013d0:	ff 75 08             	pushl  0x8(%ebp)
  8013d3:	6a 0b                	push   $0xb
  8013d5:	e8 e6 fe ff ff       	call   8012c0 <syscall>
  8013da:	83 c4 18             	add    $0x18,%esp
}
  8013dd:	c9                   	leave  
  8013de:	c3                   	ret    

008013df <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 0c                	push   $0xc
  8013ee:	e8 cd fe ff ff       	call   8012c0 <syscall>
  8013f3:	83 c4 18             	add    $0x18,%esp
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 0d                	push   $0xd
  801407:	e8 b4 fe ff ff       	call   8012c0 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 0e                	push   $0xe
  801420:	e8 9b fe ff ff       	call   8012c0 <syscall>
  801425:	83 c4 18             	add    $0x18,%esp
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 0f                	push   $0xf
  801439:	e8 82 fe ff ff       	call   8012c0 <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	ff 75 08             	pushl  0x8(%ebp)
  801451:	6a 10                	push   $0x10
  801453:	e8 68 fe ff ff       	call   8012c0 <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 11                	push   $0x11
  80146c:	e8 4f fe ff ff       	call   8012c0 <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
}
  801474:	90                   	nop
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_cputc>:

void
sys_cputc(const char c)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
  80147a:	83 ec 04             	sub    $0x4,%esp
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801483:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	50                   	push   %eax
  801490:	6a 01                	push   $0x1
  801492:	e8 29 fe ff ff       	call   8012c0 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 14                	push   $0x14
  8014ac:	e8 0f fe ff ff       	call   8012c0 <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	90                   	nop
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8014c3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014c6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	6a 00                	push   $0x0
  8014cf:	51                   	push   %ecx
  8014d0:	52                   	push   %edx
  8014d1:	ff 75 0c             	pushl  0xc(%ebp)
  8014d4:	50                   	push   %eax
  8014d5:	6a 15                	push   $0x15
  8014d7:	e8 e4 fd ff ff       	call   8012c0 <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8014e4:	8b 55 10             	mov    0x10(%ebp),%edx
  8014e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	52                   	push   %edx
  8014ef:	50                   	push   %eax
  8014f0:	ff 75 08             	pushl  0x8(%ebp)
  8014f3:	6a 16                	push   $0x16
  8014f5:	e8 c6 fd ff ff       	call   8012c0 <syscall>
  8014fa:	83 c4 18             	add    $0x18,%esp
}
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801502:	8b 55 0c             	mov    0xc(%ebp),%edx
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	52                   	push   %edx
  80150f:	50                   	push   %eax
  801510:	6a 17                	push   $0x17
  801512:	e8 a9 fd ff ff       	call   8012c0 <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80151f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	52                   	push   %edx
  80152c:	50                   	push   %eax
  80152d:	6a 18                	push   $0x18
  80152f:	e8 8c fd ff ff       	call   8012c0 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	ff 75 14             	pushl  0x14(%ebp)
  801544:	ff 75 10             	pushl  0x10(%ebp)
  801547:	ff 75 0c             	pushl  0xc(%ebp)
  80154a:	50                   	push   %eax
  80154b:	6a 19                	push   $0x19
  80154d:	e8 6e fd ff ff       	call   8012c0 <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	50                   	push   %eax
  801566:	6a 1a                	push   $0x1a
  801568:	e8 53 fd ff ff       	call   8012c0 <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	90                   	nop
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	50                   	push   %eax
  801582:	6a 1b                	push   $0x1b
  801584:	e8 37 fd ff ff       	call   8012c0 <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 05                	push   $0x5
  80159d:	e8 1e fd ff ff       	call   8012c0 <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 06                	push   $0x6
  8015b6:	e8 05 fd ff ff       	call   8012c0 <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 07                	push   $0x7
  8015cf:	e8 ec fc ff ff       	call   8012c0 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_exit_env>:


void sys_exit_env(void)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 1c                	push   $0x1c
  8015e8:	e8 d3 fc ff ff       	call   8012c0 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	ff 75 10             	pushl  0x10(%ebp)
  8015fd:	ff 75 0c             	pushl  0xc(%ebp)
  801600:	ff 75 08             	pushl  0x8(%ebp)
  801603:	6a 13                	push   $0x13
  801605:	e8 b6 fc ff ff       	call   8012c0 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
	return ;
  80160d:	90                   	nop
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_rcr2>:
uint32 sys_rcr2()
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 1e                	push   $0x1e
  80161f:	e8 9c fc ff ff       	call   8012c0 <syscall>
  801624:	83 c4 18             	add    $0x18,%esp
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
  80162c:	83 ec 04             	sub    $0x4,%esp
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801635:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	50                   	push   %eax
  801642:	6a 1f                	push   $0x1f
  801644:	e8 77 fc ff ff       	call   8012c0 <syscall>
  801649:	83 c4 18             	add    $0x18,%esp
	return ;
  80164c:	90                   	nop
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <rsttst>:
void rsttst()
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 21                	push   $0x21
  80165e:	e8 5d fc ff ff       	call   8012c0 <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
	return ;
  801666:	90                   	nop
}
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
  80166c:	83 ec 04             	sub    $0x4,%esp
  80166f:	8b 45 14             	mov    0x14(%ebp),%eax
  801672:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801675:	8b 55 18             	mov    0x18(%ebp),%edx
  801678:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80167c:	52                   	push   %edx
  80167d:	50                   	push   %eax
  80167e:	ff 75 10             	pushl  0x10(%ebp)
  801681:	ff 75 0c             	pushl  0xc(%ebp)
  801684:	ff 75 08             	pushl  0x8(%ebp)
  801687:	6a 20                	push   $0x20
  801689:	e8 32 fc ff ff       	call   8012c0 <syscall>
  80168e:	83 c4 18             	add    $0x18,%esp
	return ;
  801691:	90                   	nop
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <chktst>:
void chktst(uint32 n)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	ff 75 08             	pushl  0x8(%ebp)
  8016a2:	6a 22                	push   $0x22
  8016a4:	e8 17 fc ff ff       	call   8012c0 <syscall>
  8016a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ac:	90                   	nop
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <inctst>:

void inctst()
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 23                	push   $0x23
  8016be:	e8 fd fb ff ff       	call   8012c0 <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c6:	90                   	nop
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <gettst>:
uint32 gettst()
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 24                	push   $0x24
  8016d8:	e8 e3 fb ff ff       	call   8012c0 <syscall>
  8016dd:	83 c4 18             	add    $0x18,%esp
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 25                	push   $0x25
  8016f1:	e8 ca fb ff ff       	call   8012c0 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
  8016f9:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8016fe:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	ff 75 08             	pushl  0x8(%ebp)
  80171b:	6a 26                	push   $0x26
  80171d:	e8 9e fb ff ff       	call   8012c0 <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
	return ;
  801725:	90                   	nop
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80172c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80172f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801732:	8b 55 0c             	mov    0xc(%ebp),%edx
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	6a 00                	push   $0x0
  80173a:	53                   	push   %ebx
  80173b:	51                   	push   %ecx
  80173c:	52                   	push   %edx
  80173d:	50                   	push   %eax
  80173e:	6a 27                	push   $0x27
  801740:	e8 7b fb ff ff       	call   8012c0 <syscall>
  801745:	83 c4 18             	add    $0x18,%esp
}
  801748:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801750:	8b 55 0c             	mov    0xc(%ebp),%edx
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	52                   	push   %edx
  80175d:	50                   	push   %eax
  80175e:	6a 28                	push   $0x28
  801760:	e8 5b fb ff ff       	call   8012c0 <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80176d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801770:	8b 55 0c             	mov    0xc(%ebp),%edx
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	6a 00                	push   $0x0
  801778:	51                   	push   %ecx
  801779:	ff 75 10             	pushl  0x10(%ebp)
  80177c:	52                   	push   %edx
  80177d:	50                   	push   %eax
  80177e:	6a 29                	push   $0x29
  801780:	e8 3b fb ff ff       	call   8012c0 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	ff 75 10             	pushl  0x10(%ebp)
  801794:	ff 75 0c             	pushl  0xc(%ebp)
  801797:	ff 75 08             	pushl  0x8(%ebp)
  80179a:	6a 12                	push   $0x12
  80179c:	e8 1f fb ff ff       	call   8012c0 <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a4:	90                   	nop
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	52                   	push   %edx
  8017b7:	50                   	push   %eax
  8017b8:	6a 2a                	push   $0x2a
  8017ba:	e8 01 fb ff ff       	call   8012c0 <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
	return;
  8017c2:	90                   	nop
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 2b                	push   $0x2b
  8017d4:	e8 e7 fa ff ff       	call   8012c0 <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
}
  8017dc:	c9                   	leave  
  8017dd:	c3                   	ret    

008017de <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
  8017e1:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8017e4:	83 ec 04             	sub    $0x4,%esp
  8017e7:	68 88 22 80 00       	push   $0x802288
  8017ec:	68 0a 01 00 00       	push   $0x10a
  8017f1:	68 98 22 80 00       	push   $0x802298
  8017f6:	e8 38 00 00 00       	call   801833 <_panic>

008017fb <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	ff 75 0c             	pushl  0xc(%ebp)
  801807:	ff 75 08             	pushl  0x8(%ebp)
  80180a:	6a 33                	push   $0x33
  80180c:	e8 af fa ff ff       	call   8012c0 <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
	return;
  801814:	90                   	nop
}
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	ff 75 0c             	pushl  0xc(%ebp)
  801823:	ff 75 08             	pushl  0x8(%ebp)
  801826:	6a 34                	push   $0x34
  801828:	e8 93 fa ff ff       	call   8012c0 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
	return ;
  801830:	90                   	nop
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801839:	8d 45 10             	lea    0x10(%ebp),%eax
  80183c:	83 c0 04             	add    $0x4,%eax
  80183f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801842:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801847:	85 c0                	test   %eax,%eax
  801849:	74 16                	je     801861 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80184b:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801850:	83 ec 08             	sub    $0x8,%esp
  801853:	50                   	push   %eax
  801854:	68 a8 22 80 00       	push   $0x8022a8
  801859:	e8 7d eb ff ff       	call   8003db <cprintf>
  80185e:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801861:	a1 04 30 80 00       	mov    0x803004,%eax
  801866:	83 ec 0c             	sub    $0xc,%esp
  801869:	ff 75 0c             	pushl  0xc(%ebp)
  80186c:	ff 75 08             	pushl  0x8(%ebp)
  80186f:	50                   	push   %eax
  801870:	68 b0 22 80 00       	push   $0x8022b0
  801875:	6a 74                	push   $0x74
  801877:	e8 8c eb ff ff       	call   800408 <cprintf_colored>
  80187c:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80187f:	8b 45 10             	mov    0x10(%ebp),%eax
  801882:	83 ec 08             	sub    $0x8,%esp
  801885:	ff 75 f4             	pushl  -0xc(%ebp)
  801888:	50                   	push   %eax
  801889:	e8 de ea ff ff       	call   80036c <vcprintf>
  80188e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801891:	83 ec 08             	sub    $0x8,%esp
  801894:	6a 00                	push   $0x0
  801896:	68 d8 22 80 00       	push   $0x8022d8
  80189b:	e8 cc ea ff ff       	call   80036c <vcprintf>
  8018a0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018a3:	e8 45 ea ff ff       	call   8002ed <exit>

	// should not return here
	while (1) ;
  8018a8:	eb fe                	jmp    8018a8 <_panic+0x75>

008018aa <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
  8018ad:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8018b5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8018bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018be:	39 c2                	cmp    %eax,%edx
  8018c0:	74 14                	je     8018d6 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018c2:	83 ec 04             	sub    $0x4,%esp
  8018c5:	68 dc 22 80 00       	push   $0x8022dc
  8018ca:	6a 26                	push   $0x26
  8018cc:	68 28 23 80 00       	push   $0x802328
  8018d1:	e8 5d ff ff ff       	call   801833 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018e4:	e9 c5 00 00 00       	jmp    8019ae <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8018e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f6:	01 d0                	add    %edx,%eax
  8018f8:	8b 00                	mov    (%eax),%eax
  8018fa:	85 c0                	test   %eax,%eax
  8018fc:	75 08                	jne    801906 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8018fe:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801901:	e9 a5 00 00 00       	jmp    8019ab <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801906:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80190d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801914:	eb 69                	jmp    80197f <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801916:	a1 20 30 80 00       	mov    0x803020,%eax
  80191b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801921:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801924:	89 d0                	mov    %edx,%eax
  801926:	01 c0                	add    %eax,%eax
  801928:	01 d0                	add    %edx,%eax
  80192a:	c1 e0 03             	shl    $0x3,%eax
  80192d:	01 c8                	add    %ecx,%eax
  80192f:	8a 40 04             	mov    0x4(%eax),%al
  801932:	84 c0                	test   %al,%al
  801934:	75 46                	jne    80197c <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801936:	a1 20 30 80 00       	mov    0x803020,%eax
  80193b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801941:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801944:	89 d0                	mov    %edx,%eax
  801946:	01 c0                	add    %eax,%eax
  801948:	01 d0                	add    %edx,%eax
  80194a:	c1 e0 03             	shl    $0x3,%eax
  80194d:	01 c8                	add    %ecx,%eax
  80194f:	8b 00                	mov    (%eax),%eax
  801951:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801954:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801957:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80195c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80195e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801961:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801968:	8b 45 08             	mov    0x8(%ebp),%eax
  80196b:	01 c8                	add    %ecx,%eax
  80196d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80196f:	39 c2                	cmp    %eax,%edx
  801971:	75 09                	jne    80197c <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801973:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80197a:	eb 15                	jmp    801991 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80197c:	ff 45 e8             	incl   -0x18(%ebp)
  80197f:	a1 20 30 80 00       	mov    0x803020,%eax
  801984:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80198a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80198d:	39 c2                	cmp    %eax,%edx
  80198f:	77 85                	ja     801916 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801991:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801995:	75 14                	jne    8019ab <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801997:	83 ec 04             	sub    $0x4,%esp
  80199a:	68 34 23 80 00       	push   $0x802334
  80199f:	6a 3a                	push   $0x3a
  8019a1:	68 28 23 80 00       	push   $0x802328
  8019a6:	e8 88 fe ff ff       	call   801833 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019ab:	ff 45 f0             	incl   -0x10(%ebp)
  8019ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019b4:	0f 8c 2f ff ff ff    	jl     8018e9 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019c1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019c8:	eb 26                	jmp    8019f0 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8019cf:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8019d5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019d8:	89 d0                	mov    %edx,%eax
  8019da:	01 c0                	add    %eax,%eax
  8019dc:	01 d0                	add    %edx,%eax
  8019de:	c1 e0 03             	shl    $0x3,%eax
  8019e1:	01 c8                	add    %ecx,%eax
  8019e3:	8a 40 04             	mov    0x4(%eax),%al
  8019e6:	3c 01                	cmp    $0x1,%al
  8019e8:	75 03                	jne    8019ed <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019ea:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ed:	ff 45 e0             	incl   -0x20(%ebp)
  8019f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8019f5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019fe:	39 c2                	cmp    %eax,%edx
  801a00:	77 c8                	ja     8019ca <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a05:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a08:	74 14                	je     801a1e <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a0a:	83 ec 04             	sub    $0x4,%esp
  801a0d:	68 88 23 80 00       	push   $0x802388
  801a12:	6a 44                	push   $0x44
  801a14:	68 28 23 80 00       	push   $0x802328
  801a19:	e8 15 fe ff ff       	call   801833 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a1e:	90                   	nop
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    
  801a21:	66 90                	xchg   %ax,%ax
  801a23:	90                   	nop

00801a24 <__udivdi3>:
  801a24:	55                   	push   %ebp
  801a25:	57                   	push   %edi
  801a26:	56                   	push   %esi
  801a27:	53                   	push   %ebx
  801a28:	83 ec 1c             	sub    $0x1c,%esp
  801a2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a3b:	89 ca                	mov    %ecx,%edx
  801a3d:	89 f8                	mov    %edi,%eax
  801a3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a43:	85 f6                	test   %esi,%esi
  801a45:	75 2d                	jne    801a74 <__udivdi3+0x50>
  801a47:	39 cf                	cmp    %ecx,%edi
  801a49:	77 65                	ja     801ab0 <__udivdi3+0x8c>
  801a4b:	89 fd                	mov    %edi,%ebp
  801a4d:	85 ff                	test   %edi,%edi
  801a4f:	75 0b                	jne    801a5c <__udivdi3+0x38>
  801a51:	b8 01 00 00 00       	mov    $0x1,%eax
  801a56:	31 d2                	xor    %edx,%edx
  801a58:	f7 f7                	div    %edi
  801a5a:	89 c5                	mov    %eax,%ebp
  801a5c:	31 d2                	xor    %edx,%edx
  801a5e:	89 c8                	mov    %ecx,%eax
  801a60:	f7 f5                	div    %ebp
  801a62:	89 c1                	mov    %eax,%ecx
  801a64:	89 d8                	mov    %ebx,%eax
  801a66:	f7 f5                	div    %ebp
  801a68:	89 cf                	mov    %ecx,%edi
  801a6a:	89 fa                	mov    %edi,%edx
  801a6c:	83 c4 1c             	add    $0x1c,%esp
  801a6f:	5b                   	pop    %ebx
  801a70:	5e                   	pop    %esi
  801a71:	5f                   	pop    %edi
  801a72:	5d                   	pop    %ebp
  801a73:	c3                   	ret    
  801a74:	39 ce                	cmp    %ecx,%esi
  801a76:	77 28                	ja     801aa0 <__udivdi3+0x7c>
  801a78:	0f bd fe             	bsr    %esi,%edi
  801a7b:	83 f7 1f             	xor    $0x1f,%edi
  801a7e:	75 40                	jne    801ac0 <__udivdi3+0x9c>
  801a80:	39 ce                	cmp    %ecx,%esi
  801a82:	72 0a                	jb     801a8e <__udivdi3+0x6a>
  801a84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a88:	0f 87 9e 00 00 00    	ja     801b2c <__udivdi3+0x108>
  801a8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a93:	89 fa                	mov    %edi,%edx
  801a95:	83 c4 1c             	add    $0x1c,%esp
  801a98:	5b                   	pop    %ebx
  801a99:	5e                   	pop    %esi
  801a9a:	5f                   	pop    %edi
  801a9b:	5d                   	pop    %ebp
  801a9c:	c3                   	ret    
  801a9d:	8d 76 00             	lea    0x0(%esi),%esi
  801aa0:	31 ff                	xor    %edi,%edi
  801aa2:	31 c0                	xor    %eax,%eax
  801aa4:	89 fa                	mov    %edi,%edx
  801aa6:	83 c4 1c             	add    $0x1c,%esp
  801aa9:	5b                   	pop    %ebx
  801aaa:	5e                   	pop    %esi
  801aab:	5f                   	pop    %edi
  801aac:	5d                   	pop    %ebp
  801aad:	c3                   	ret    
  801aae:	66 90                	xchg   %ax,%ax
  801ab0:	89 d8                	mov    %ebx,%eax
  801ab2:	f7 f7                	div    %edi
  801ab4:	31 ff                	xor    %edi,%edi
  801ab6:	89 fa                	mov    %edi,%edx
  801ab8:	83 c4 1c             	add    $0x1c,%esp
  801abb:	5b                   	pop    %ebx
  801abc:	5e                   	pop    %esi
  801abd:	5f                   	pop    %edi
  801abe:	5d                   	pop    %ebp
  801abf:	c3                   	ret    
  801ac0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ac5:	89 eb                	mov    %ebp,%ebx
  801ac7:	29 fb                	sub    %edi,%ebx
  801ac9:	89 f9                	mov    %edi,%ecx
  801acb:	d3 e6                	shl    %cl,%esi
  801acd:	89 c5                	mov    %eax,%ebp
  801acf:	88 d9                	mov    %bl,%cl
  801ad1:	d3 ed                	shr    %cl,%ebp
  801ad3:	89 e9                	mov    %ebp,%ecx
  801ad5:	09 f1                	or     %esi,%ecx
  801ad7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801adb:	89 f9                	mov    %edi,%ecx
  801add:	d3 e0                	shl    %cl,%eax
  801adf:	89 c5                	mov    %eax,%ebp
  801ae1:	89 d6                	mov    %edx,%esi
  801ae3:	88 d9                	mov    %bl,%cl
  801ae5:	d3 ee                	shr    %cl,%esi
  801ae7:	89 f9                	mov    %edi,%ecx
  801ae9:	d3 e2                	shl    %cl,%edx
  801aeb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aef:	88 d9                	mov    %bl,%cl
  801af1:	d3 e8                	shr    %cl,%eax
  801af3:	09 c2                	or     %eax,%edx
  801af5:	89 d0                	mov    %edx,%eax
  801af7:	89 f2                	mov    %esi,%edx
  801af9:	f7 74 24 0c          	divl   0xc(%esp)
  801afd:	89 d6                	mov    %edx,%esi
  801aff:	89 c3                	mov    %eax,%ebx
  801b01:	f7 e5                	mul    %ebp
  801b03:	39 d6                	cmp    %edx,%esi
  801b05:	72 19                	jb     801b20 <__udivdi3+0xfc>
  801b07:	74 0b                	je     801b14 <__udivdi3+0xf0>
  801b09:	89 d8                	mov    %ebx,%eax
  801b0b:	31 ff                	xor    %edi,%edi
  801b0d:	e9 58 ff ff ff       	jmp    801a6a <__udivdi3+0x46>
  801b12:	66 90                	xchg   %ax,%ax
  801b14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b18:	89 f9                	mov    %edi,%ecx
  801b1a:	d3 e2                	shl    %cl,%edx
  801b1c:	39 c2                	cmp    %eax,%edx
  801b1e:	73 e9                	jae    801b09 <__udivdi3+0xe5>
  801b20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b23:	31 ff                	xor    %edi,%edi
  801b25:	e9 40 ff ff ff       	jmp    801a6a <__udivdi3+0x46>
  801b2a:	66 90                	xchg   %ax,%ax
  801b2c:	31 c0                	xor    %eax,%eax
  801b2e:	e9 37 ff ff ff       	jmp    801a6a <__udivdi3+0x46>
  801b33:	90                   	nop

00801b34 <__umoddi3>:
  801b34:	55                   	push   %ebp
  801b35:	57                   	push   %edi
  801b36:	56                   	push   %esi
  801b37:	53                   	push   %ebx
  801b38:	83 ec 1c             	sub    $0x1c,%esp
  801b3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b53:	89 f3                	mov    %esi,%ebx
  801b55:	89 fa                	mov    %edi,%edx
  801b57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b5b:	89 34 24             	mov    %esi,(%esp)
  801b5e:	85 c0                	test   %eax,%eax
  801b60:	75 1a                	jne    801b7c <__umoddi3+0x48>
  801b62:	39 f7                	cmp    %esi,%edi
  801b64:	0f 86 a2 00 00 00    	jbe    801c0c <__umoddi3+0xd8>
  801b6a:	89 c8                	mov    %ecx,%eax
  801b6c:	89 f2                	mov    %esi,%edx
  801b6e:	f7 f7                	div    %edi
  801b70:	89 d0                	mov    %edx,%eax
  801b72:	31 d2                	xor    %edx,%edx
  801b74:	83 c4 1c             	add    $0x1c,%esp
  801b77:	5b                   	pop    %ebx
  801b78:	5e                   	pop    %esi
  801b79:	5f                   	pop    %edi
  801b7a:	5d                   	pop    %ebp
  801b7b:	c3                   	ret    
  801b7c:	39 f0                	cmp    %esi,%eax
  801b7e:	0f 87 ac 00 00 00    	ja     801c30 <__umoddi3+0xfc>
  801b84:	0f bd e8             	bsr    %eax,%ebp
  801b87:	83 f5 1f             	xor    $0x1f,%ebp
  801b8a:	0f 84 ac 00 00 00    	je     801c3c <__umoddi3+0x108>
  801b90:	bf 20 00 00 00       	mov    $0x20,%edi
  801b95:	29 ef                	sub    %ebp,%edi
  801b97:	89 fe                	mov    %edi,%esi
  801b99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b9d:	89 e9                	mov    %ebp,%ecx
  801b9f:	d3 e0                	shl    %cl,%eax
  801ba1:	89 d7                	mov    %edx,%edi
  801ba3:	89 f1                	mov    %esi,%ecx
  801ba5:	d3 ef                	shr    %cl,%edi
  801ba7:	09 c7                	or     %eax,%edi
  801ba9:	89 e9                	mov    %ebp,%ecx
  801bab:	d3 e2                	shl    %cl,%edx
  801bad:	89 14 24             	mov    %edx,(%esp)
  801bb0:	89 d8                	mov    %ebx,%eax
  801bb2:	d3 e0                	shl    %cl,%eax
  801bb4:	89 c2                	mov    %eax,%edx
  801bb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bba:	d3 e0                	shl    %cl,%eax
  801bbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc4:	89 f1                	mov    %esi,%ecx
  801bc6:	d3 e8                	shr    %cl,%eax
  801bc8:	09 d0                	or     %edx,%eax
  801bca:	d3 eb                	shr    %cl,%ebx
  801bcc:	89 da                	mov    %ebx,%edx
  801bce:	f7 f7                	div    %edi
  801bd0:	89 d3                	mov    %edx,%ebx
  801bd2:	f7 24 24             	mull   (%esp)
  801bd5:	89 c6                	mov    %eax,%esi
  801bd7:	89 d1                	mov    %edx,%ecx
  801bd9:	39 d3                	cmp    %edx,%ebx
  801bdb:	0f 82 87 00 00 00    	jb     801c68 <__umoddi3+0x134>
  801be1:	0f 84 91 00 00 00    	je     801c78 <__umoddi3+0x144>
  801be7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801beb:	29 f2                	sub    %esi,%edx
  801bed:	19 cb                	sbb    %ecx,%ebx
  801bef:	89 d8                	mov    %ebx,%eax
  801bf1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bf5:	d3 e0                	shl    %cl,%eax
  801bf7:	89 e9                	mov    %ebp,%ecx
  801bf9:	d3 ea                	shr    %cl,%edx
  801bfb:	09 d0                	or     %edx,%eax
  801bfd:	89 e9                	mov    %ebp,%ecx
  801bff:	d3 eb                	shr    %cl,%ebx
  801c01:	89 da                	mov    %ebx,%edx
  801c03:	83 c4 1c             	add    $0x1c,%esp
  801c06:	5b                   	pop    %ebx
  801c07:	5e                   	pop    %esi
  801c08:	5f                   	pop    %edi
  801c09:	5d                   	pop    %ebp
  801c0a:	c3                   	ret    
  801c0b:	90                   	nop
  801c0c:	89 fd                	mov    %edi,%ebp
  801c0e:	85 ff                	test   %edi,%edi
  801c10:	75 0b                	jne    801c1d <__umoddi3+0xe9>
  801c12:	b8 01 00 00 00       	mov    $0x1,%eax
  801c17:	31 d2                	xor    %edx,%edx
  801c19:	f7 f7                	div    %edi
  801c1b:	89 c5                	mov    %eax,%ebp
  801c1d:	89 f0                	mov    %esi,%eax
  801c1f:	31 d2                	xor    %edx,%edx
  801c21:	f7 f5                	div    %ebp
  801c23:	89 c8                	mov    %ecx,%eax
  801c25:	f7 f5                	div    %ebp
  801c27:	89 d0                	mov    %edx,%eax
  801c29:	e9 44 ff ff ff       	jmp    801b72 <__umoddi3+0x3e>
  801c2e:	66 90                	xchg   %ax,%ax
  801c30:	89 c8                	mov    %ecx,%eax
  801c32:	89 f2                	mov    %esi,%edx
  801c34:	83 c4 1c             	add    $0x1c,%esp
  801c37:	5b                   	pop    %ebx
  801c38:	5e                   	pop    %esi
  801c39:	5f                   	pop    %edi
  801c3a:	5d                   	pop    %ebp
  801c3b:	c3                   	ret    
  801c3c:	3b 04 24             	cmp    (%esp),%eax
  801c3f:	72 06                	jb     801c47 <__umoddi3+0x113>
  801c41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c45:	77 0f                	ja     801c56 <__umoddi3+0x122>
  801c47:	89 f2                	mov    %esi,%edx
  801c49:	29 f9                	sub    %edi,%ecx
  801c4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c4f:	89 14 24             	mov    %edx,(%esp)
  801c52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c5a:	8b 14 24             	mov    (%esp),%edx
  801c5d:	83 c4 1c             	add    $0x1c,%esp
  801c60:	5b                   	pop    %ebx
  801c61:	5e                   	pop    %esi
  801c62:	5f                   	pop    %edi
  801c63:	5d                   	pop    %ebp
  801c64:	c3                   	ret    
  801c65:	8d 76 00             	lea    0x0(%esi),%esi
  801c68:	2b 04 24             	sub    (%esp),%eax
  801c6b:	19 fa                	sbb    %edi,%edx
  801c6d:	89 d1                	mov    %edx,%ecx
  801c6f:	89 c6                	mov    %eax,%esi
  801c71:	e9 71 ff ff ff       	jmp    801be7 <__umoddi3+0xb3>
  801c76:	66 90                	xchg   %ax,%ax
  801c78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c7c:	72 ea                	jb     801c68 <__umoddi3+0x134>
  801c7e:	89 d9                	mov    %ebx,%ecx
  801c80:	e9 62 ff ff ff       	jmp    801be7 <__umoddi3+0xb3>
