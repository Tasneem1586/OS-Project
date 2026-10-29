
obj/user/sc_data_on_stack:     file format elf32-i386


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
  800031:	e8 23 00 00 00       	call   800059 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 60 1c 80 00       	push   $0x801c60
  800049:	e8 bd 03 00 00       	call   80040b <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	inctst();
  800051:	e8 17 16 00 00       	call   80166d <inctst>

	return;
  800056:	90                   	nop
}
  800057:	c9                   	leave  
  800058:	c3                   	ret    

00800059 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800059:	55                   	push   %ebp
  80005a:	89 e5                	mov    %esp,%ebp
  80005c:	57                   	push   %edi
  80005d:	56                   	push   %esi
  80005e:	53                   	push   %ebx
  80005f:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800065:	e8 fb 14 00 00       	call   801565 <sys_getenvindex>
  80006a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80006d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800070:	89 d0                	mov    %edx,%eax
  800072:	c1 e0 03             	shl    $0x3,%eax
  800075:	01 d0                	add    %edx,%eax
  800077:	c1 e0 06             	shl    $0x6,%eax
  80007a:	01 d0                	add    %edx,%eax
  80007c:	c1 e0 03             	shl    $0x3,%eax
  80007f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800084:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800089:	a1 20 30 80 00       	mov    0x803020,%eax
  80008e:	8a 40 10             	mov    0x10(%eax),%al
  800091:	84 c0                	test   %al,%al
  800093:	74 0d                	je     8000a2 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800095:	a1 20 30 80 00       	mov    0x803020,%eax
  80009a:	83 c0 10             	add    $0x10,%eax
  80009d:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000a6:	7e 0a                	jle    8000b2 <libmain+0x59>
		binaryname = argv[0];
  8000a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ab:	8b 00                	mov    (%eax),%eax
  8000ad:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8000b2:	83 ec 08             	sub    $0x8,%esp
  8000b5:	ff 75 0c             	pushl  0xc(%ebp)
  8000b8:	ff 75 08             	pushl  0x8(%ebp)
  8000bb:	e8 78 ff ff ff       	call   800038 <_main>
  8000c0:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8000c3:	a1 00 30 80 00       	mov    0x803000,%eax
  8000c8:	85 c0                	test   %eax,%eax
  8000ca:	0f 84 b7 01 00 00    	je     800287 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8000d0:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8000d6:	bb c0 1d 80 00       	mov    $0x801dc0,%ebx
  8000db:	ba 0e 00 00 00       	mov    $0xe,%edx
  8000e0:	89 c7                	mov    %eax,%edi
  8000e2:	89 de                	mov    %ebx,%esi
  8000e4:	89 d1                	mov    %edx,%ecx
  8000e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000e8:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8000ee:	b9 56 00 00 00       	mov    $0x56,%ecx
  8000f3:	b0 00                	mov    $0x0,%al
  8000f5:	89 d7                	mov    %edx,%edi
  8000f7:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8000f9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800100:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	50                   	push   %eax
  800107:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80010d:	50                   	push   %eax
  80010e:	e8 52 16 00 00       	call   801765 <sys_utilities>
  800113:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800116:	e8 d2 11 00 00       	call   8012ed <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 9c 1c 80 00       	push   $0x801c9c
  800123:	e8 71 02 00 00       	call   800399 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80012b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80012e:	85 c0                	test   %eax,%eax
  800130:	74 58                	je     80018a <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800132:	e8 4c 16 00 00       	call   801783 <sys_get_optimal_num_faults>
  800137:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80013a:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800140:	bb 24 1e 80 00       	mov    $0x801e24,%ebx
  800145:	ba 11 00 00 00       	mov    $0x11,%edx
  80014a:	89 c7                	mov    %eax,%edi
  80014c:	89 de                	mov    %ebx,%esi
  80014e:	89 d1                	mov    %edx,%ecx
  800150:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800152:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800155:	b9 53 00 00 00       	mov    $0x53,%ecx
  80015a:	b0 00                	mov    $0x0,%al
  80015c:	89 d7                	mov    %edx,%edi
  80015e:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800160:	83 ec 08             	sub    $0x8,%esp
  800163:	ff 75 dc             	pushl  -0x24(%ebp)
  800166:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80016c:	50                   	push   %eax
  80016d:	e8 f3 15 00 00       	call   801765 <sys_utilities>
  800172:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 dc             	pushl  -0x24(%ebp)
  80017b:	68 c4 1c 80 00       	push   $0x801cc4
  800180:	e8 14 02 00 00       	call   800399 <cprintf>
  800185:	83 c4 10             	add    $0x10,%esp
  800188:	eb 59                	jmp    8001e3 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80018a:	a1 20 30 80 00       	mov    0x803020,%eax
  80018f:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800195:	a1 20 30 80 00       	mov    0x803020,%eax
  80019a:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001a0:	83 ec 04             	sub    $0x4,%esp
  8001a3:	52                   	push   %edx
  8001a4:	50                   	push   %eax
  8001a5:	68 e8 1c 80 00       	push   $0x801ce8
  8001aa:	e8 ea 01 00 00       	call   800399 <cprintf>
  8001af:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8001b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b7:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8001bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c2:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8001c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001cd:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8001d3:	51                   	push   %ecx
  8001d4:	52                   	push   %edx
  8001d5:	50                   	push   %eax
  8001d6:	68 10 1d 80 00       	push   $0x801d10
  8001db:	e8 b9 01 00 00       	call   800399 <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e8:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8001ee:	83 ec 08             	sub    $0x8,%esp
  8001f1:	50                   	push   %eax
  8001f2:	68 68 1d 80 00       	push   $0x801d68
  8001f7:	e8 9d 01 00 00       	call   800399 <cprintf>
  8001fc:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8001ff:	83 ec 0c             	sub    $0xc,%esp
  800202:	68 7c 1d 80 00       	push   $0x801d7c
  800207:	e8 8d 01 00 00       	call   800399 <cprintf>
  80020c:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80020f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800216:	eb 28                	jmp    800240 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800218:	a1 20 30 80 00       	mov    0x803020,%eax
  80021d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800220:	81 c2 74 04 00 00    	add    $0x474,%edx
  800226:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800229:	83 ec 04             	sub    $0x4,%esp
  80022c:	50                   	push   %eax
  80022d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800230:	68 93 1d 80 00       	push   $0x801d93
  800235:	e8 5f 01 00 00       	call   800399 <cprintf>
  80023a:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80023d:	ff 45 e4             	incl   -0x1c(%ebp)
  800240:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800244:	7e d2                	jle    800218 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 a2 1d 80 00       	push   $0x801da2
  80024e:	e8 46 01 00 00       	call   800399 <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800256:	a1 20 30 80 00       	mov    0x803020,%eax
  80025b:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800261:	83 ec 08             	sub    $0x8,%esp
  800264:	50                   	push   %eax
  800265:	68 a6 1d 80 00       	push   $0x801da6
  80026a:	e8 2a 01 00 00       	call   800399 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 9c 1c 80 00       	push   $0x801c9c
  80027a:	e8 1a 01 00 00       	call   800399 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800282:	e8 80 10 00 00       	call   801307 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800287:	e8 1f 00 00 00       	call   8002ab <exit>
}
  80028c:	90                   	nop
  80028d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800290:	5b                   	pop    %ebx
  800291:	5e                   	pop    %esi
  800292:	5f                   	pop    %edi
  800293:	5d                   	pop    %ebp
  800294:	c3                   	ret    

00800295 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800295:	55                   	push   %ebp
  800296:	89 e5                	mov    %esp,%ebp
  800298:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80029b:	83 ec 0c             	sub    $0xc,%esp
  80029e:	6a 00                	push   $0x0
  8002a0:	e8 8c 12 00 00       	call   801531 <sys_destroy_env>
  8002a5:	83 c4 10             	add    $0x10,%esp
}
  8002a8:	90                   	nop
  8002a9:	c9                   	leave  
  8002aa:	c3                   	ret    

008002ab <exit>:

void
exit(void)
{
  8002ab:	55                   	push   %ebp
  8002ac:	89 e5                	mov    %esp,%ebp
  8002ae:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8002b1:	e8 e1 12 00 00       	call   801597 <sys_exit_env>
}
  8002b6:	90                   	nop
  8002b7:	c9                   	leave  
  8002b8:	c3                   	ret    

008002b9 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8002b9:	55                   	push   %ebp
  8002ba:	89 e5                	mov    %esp,%ebp
  8002bc:	53                   	push   %ebx
  8002bd:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8002c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c3:	8b 00                	mov    (%eax),%eax
  8002c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8002c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002cb:	89 0a                	mov    %ecx,(%edx)
  8002cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8002d0:	88 d1                	mov    %dl,%cl
  8002d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002d5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002dc:	8b 00                	mov    (%eax),%eax
  8002de:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002e3:	75 30                	jne    800315 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8002e5:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8002eb:	a0 40 30 80 00       	mov    0x803040,%al
  8002f0:	0f b6 c0             	movzbl %al,%eax
  8002f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002f6:	8b 09                	mov    (%ecx),%ecx
  8002f8:	89 cb                	mov    %ecx,%ebx
  8002fa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002fd:	83 c1 08             	add    $0x8,%ecx
  800300:	52                   	push   %edx
  800301:	50                   	push   %eax
  800302:	53                   	push   %ebx
  800303:	51                   	push   %ecx
  800304:	e8 a0 0f 00 00       	call   8012a9 <sys_cputs>
  800309:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80030c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80030f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800315:	8b 45 0c             	mov    0xc(%ebp),%eax
  800318:	8b 40 04             	mov    0x4(%eax),%eax
  80031b:	8d 50 01             	lea    0x1(%eax),%edx
  80031e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800321:	89 50 04             	mov    %edx,0x4(%eax)
}
  800324:	90                   	nop
  800325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800328:	c9                   	leave  
  800329:	c3                   	ret    

0080032a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80032a:	55                   	push   %ebp
  80032b:	89 e5                	mov    %esp,%ebp
  80032d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800333:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80033a:	00 00 00 
	b.cnt = 0;
  80033d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800344:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800347:	ff 75 0c             	pushl  0xc(%ebp)
  80034a:	ff 75 08             	pushl  0x8(%ebp)
  80034d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800353:	50                   	push   %eax
  800354:	68 b9 02 80 00       	push   $0x8002b9
  800359:	e8 5a 02 00 00       	call   8005b8 <vprintfmt>
  80035e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800361:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800367:	a0 40 30 80 00       	mov    0x803040,%al
  80036c:	0f b6 c0             	movzbl %al,%eax
  80036f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800375:	52                   	push   %edx
  800376:	50                   	push   %eax
  800377:	51                   	push   %ecx
  800378:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80037e:	83 c0 08             	add    $0x8,%eax
  800381:	50                   	push   %eax
  800382:	e8 22 0f 00 00       	call   8012a9 <sys_cputs>
  800387:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80038a:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800391:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800397:	c9                   	leave  
  800398:	c3                   	ret    

00800399 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800399:	55                   	push   %ebp
  80039a:	89 e5                	mov    %esp,%ebp
  80039c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80039f:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8003a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	83 ec 08             	sub    $0x8,%esp
  8003b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b5:	50                   	push   %eax
  8003b6:	e8 6f ff ff ff       	call   80032a <vcprintf>
  8003bb:	83 c4 10             	add    $0x10,%esp
  8003be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003c4:	c9                   	leave  
  8003c5:	c3                   	ret    

008003c6 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8003c6:	55                   	push   %ebp
  8003c7:	89 e5                	mov    %esp,%ebp
  8003c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003cc:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8003d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d6:	c1 e0 08             	shl    $0x8,%eax
  8003d9:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8003de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003e1:	83 c0 04             	add    $0x4,%eax
  8003e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	83 ec 08             	sub    $0x8,%esp
  8003ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f0:	50                   	push   %eax
  8003f1:	e8 34 ff ff ff       	call   80032a <vcprintf>
  8003f6:	83 c4 10             	add    $0x10,%esp
  8003f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8003fc:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800403:	07 00 00 

	return cnt;
  800406:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800409:	c9                   	leave  
  80040a:	c3                   	ret    

0080040b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80040b:	55                   	push   %ebp
  80040c:	89 e5                	mov    %esp,%ebp
  80040e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800411:	e8 d7 0e 00 00       	call   8012ed <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800416:	8d 45 0c             	lea    0xc(%ebp),%eax
  800419:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80041c:	8b 45 08             	mov    0x8(%ebp),%eax
  80041f:	83 ec 08             	sub    $0x8,%esp
  800422:	ff 75 f4             	pushl  -0xc(%ebp)
  800425:	50                   	push   %eax
  800426:	e8 ff fe ff ff       	call   80032a <vcprintf>
  80042b:	83 c4 10             	add    $0x10,%esp
  80042e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800431:	e8 d1 0e 00 00       	call   801307 <sys_unlock_cons>
	return cnt;
  800436:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800439:	c9                   	leave  
  80043a:	c3                   	ret    

0080043b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80043b:	55                   	push   %ebp
  80043c:	89 e5                	mov    %esp,%ebp
  80043e:	53                   	push   %ebx
  80043f:	83 ec 14             	sub    $0x14,%esp
  800442:	8b 45 10             	mov    0x10(%ebp),%eax
  800445:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800448:	8b 45 14             	mov    0x14(%ebp),%eax
  80044b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80044e:	8b 45 18             	mov    0x18(%ebp),%eax
  800451:	ba 00 00 00 00       	mov    $0x0,%edx
  800456:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800459:	77 55                	ja     8004b0 <printnum+0x75>
  80045b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80045e:	72 05                	jb     800465 <printnum+0x2a>
  800460:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800463:	77 4b                	ja     8004b0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800465:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800468:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80046b:	8b 45 18             	mov    0x18(%ebp),%eax
  80046e:	ba 00 00 00 00       	mov    $0x0,%edx
  800473:	52                   	push   %edx
  800474:	50                   	push   %eax
  800475:	ff 75 f4             	pushl  -0xc(%ebp)
  800478:	ff 75 f0             	pushl  -0x10(%ebp)
  80047b:	e8 60 15 00 00       	call   8019e0 <__udivdi3>
  800480:	83 c4 10             	add    $0x10,%esp
  800483:	83 ec 04             	sub    $0x4,%esp
  800486:	ff 75 20             	pushl  0x20(%ebp)
  800489:	53                   	push   %ebx
  80048a:	ff 75 18             	pushl  0x18(%ebp)
  80048d:	52                   	push   %edx
  80048e:	50                   	push   %eax
  80048f:	ff 75 0c             	pushl  0xc(%ebp)
  800492:	ff 75 08             	pushl  0x8(%ebp)
  800495:	e8 a1 ff ff ff       	call   80043b <printnum>
  80049a:	83 c4 20             	add    $0x20,%esp
  80049d:	eb 1a                	jmp    8004b9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80049f:	83 ec 08             	sub    $0x8,%esp
  8004a2:	ff 75 0c             	pushl  0xc(%ebp)
  8004a5:	ff 75 20             	pushl  0x20(%ebp)
  8004a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ab:	ff d0                	call   *%eax
  8004ad:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004b0:	ff 4d 1c             	decl   0x1c(%ebp)
  8004b3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004b7:	7f e6                	jg     80049f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004b9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004bc:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004c7:	53                   	push   %ebx
  8004c8:	51                   	push   %ecx
  8004c9:	52                   	push   %edx
  8004ca:	50                   	push   %eax
  8004cb:	e8 20 16 00 00       	call   801af0 <__umoddi3>
  8004d0:	83 c4 10             	add    $0x10,%esp
  8004d3:	05 b4 20 80 00       	add    $0x8020b4,%eax
  8004d8:	8a 00                	mov    (%eax),%al
  8004da:	0f be c0             	movsbl %al,%eax
  8004dd:	83 ec 08             	sub    $0x8,%esp
  8004e0:	ff 75 0c             	pushl  0xc(%ebp)
  8004e3:	50                   	push   %eax
  8004e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e7:	ff d0                	call   *%eax
  8004e9:	83 c4 10             	add    $0x10,%esp
}
  8004ec:	90                   	nop
  8004ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004f0:	c9                   	leave  
  8004f1:	c3                   	ret    

008004f2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004f2:	55                   	push   %ebp
  8004f3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004f5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004f9:	7e 1c                	jle    800517 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fe:	8b 00                	mov    (%eax),%eax
  800500:	8d 50 08             	lea    0x8(%eax),%edx
  800503:	8b 45 08             	mov    0x8(%ebp),%eax
  800506:	89 10                	mov    %edx,(%eax)
  800508:	8b 45 08             	mov    0x8(%ebp),%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	83 e8 08             	sub    $0x8,%eax
  800510:	8b 50 04             	mov    0x4(%eax),%edx
  800513:	8b 00                	mov    (%eax),%eax
  800515:	eb 40                	jmp    800557 <getuint+0x65>
	else if (lflag)
  800517:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80051b:	74 1e                	je     80053b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	8d 50 04             	lea    0x4(%eax),%edx
  800525:	8b 45 08             	mov    0x8(%ebp),%eax
  800528:	89 10                	mov    %edx,(%eax)
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	83 e8 04             	sub    $0x4,%eax
  800532:	8b 00                	mov    (%eax),%eax
  800534:	ba 00 00 00 00       	mov    $0x0,%edx
  800539:	eb 1c                	jmp    800557 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80053b:	8b 45 08             	mov    0x8(%ebp),%eax
  80053e:	8b 00                	mov    (%eax),%eax
  800540:	8d 50 04             	lea    0x4(%eax),%edx
  800543:	8b 45 08             	mov    0x8(%ebp),%eax
  800546:	89 10                	mov    %edx,(%eax)
  800548:	8b 45 08             	mov    0x8(%ebp),%eax
  80054b:	8b 00                	mov    (%eax),%eax
  80054d:	83 e8 04             	sub    $0x4,%eax
  800550:	8b 00                	mov    (%eax),%eax
  800552:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800557:	5d                   	pop    %ebp
  800558:	c3                   	ret    

00800559 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800559:	55                   	push   %ebp
  80055a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80055c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800560:	7e 1c                	jle    80057e <getint+0x25>
		return va_arg(*ap, long long);
  800562:	8b 45 08             	mov    0x8(%ebp),%eax
  800565:	8b 00                	mov    (%eax),%eax
  800567:	8d 50 08             	lea    0x8(%eax),%edx
  80056a:	8b 45 08             	mov    0x8(%ebp),%eax
  80056d:	89 10                	mov    %edx,(%eax)
  80056f:	8b 45 08             	mov    0x8(%ebp),%eax
  800572:	8b 00                	mov    (%eax),%eax
  800574:	83 e8 08             	sub    $0x8,%eax
  800577:	8b 50 04             	mov    0x4(%eax),%edx
  80057a:	8b 00                	mov    (%eax),%eax
  80057c:	eb 38                	jmp    8005b6 <getint+0x5d>
	else if (lflag)
  80057e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800582:	74 1a                	je     80059e <getint+0x45>
		return va_arg(*ap, long);
  800584:	8b 45 08             	mov    0x8(%ebp),%eax
  800587:	8b 00                	mov    (%eax),%eax
  800589:	8d 50 04             	lea    0x4(%eax),%edx
  80058c:	8b 45 08             	mov    0x8(%ebp),%eax
  80058f:	89 10                	mov    %edx,(%eax)
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	8b 00                	mov    (%eax),%eax
  800596:	83 e8 04             	sub    $0x4,%eax
  800599:	8b 00                	mov    (%eax),%eax
  80059b:	99                   	cltd   
  80059c:	eb 18                	jmp    8005b6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	8d 50 04             	lea    0x4(%eax),%edx
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	89 10                	mov    %edx,(%eax)
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	83 e8 04             	sub    $0x4,%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	99                   	cltd   
}
  8005b6:	5d                   	pop    %ebp
  8005b7:	c3                   	ret    

008005b8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005b8:	55                   	push   %ebp
  8005b9:	89 e5                	mov    %esp,%ebp
  8005bb:	56                   	push   %esi
  8005bc:	53                   	push   %ebx
  8005bd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005c0:	eb 17                	jmp    8005d9 <vprintfmt+0x21>
			if (ch == '\0')
  8005c2:	85 db                	test   %ebx,%ebx
  8005c4:	0f 84 c1 03 00 00    	je     80098b <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8005ca:	83 ec 08             	sub    $0x8,%esp
  8005cd:	ff 75 0c             	pushl  0xc(%ebp)
  8005d0:	53                   	push   %ebx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	ff d0                	call   *%eax
  8005d6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005dc:	8d 50 01             	lea    0x1(%eax),%edx
  8005df:	89 55 10             	mov    %edx,0x10(%ebp)
  8005e2:	8a 00                	mov    (%eax),%al
  8005e4:	0f b6 d8             	movzbl %al,%ebx
  8005e7:	83 fb 25             	cmp    $0x25,%ebx
  8005ea:	75 d6                	jne    8005c2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005ec:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005f0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005f7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005fe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800605:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80060c:	8b 45 10             	mov    0x10(%ebp),%eax
  80060f:	8d 50 01             	lea    0x1(%eax),%edx
  800612:	89 55 10             	mov    %edx,0x10(%ebp)
  800615:	8a 00                	mov    (%eax),%al
  800617:	0f b6 d8             	movzbl %al,%ebx
  80061a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80061d:	83 f8 5b             	cmp    $0x5b,%eax
  800620:	0f 87 3d 03 00 00    	ja     800963 <vprintfmt+0x3ab>
  800626:	8b 04 85 d8 20 80 00 	mov    0x8020d8(,%eax,4),%eax
  80062d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80062f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800633:	eb d7                	jmp    80060c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800635:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800639:	eb d1                	jmp    80060c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80063b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800642:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800645:	89 d0                	mov    %edx,%eax
  800647:	c1 e0 02             	shl    $0x2,%eax
  80064a:	01 d0                	add    %edx,%eax
  80064c:	01 c0                	add    %eax,%eax
  80064e:	01 d8                	add    %ebx,%eax
  800650:	83 e8 30             	sub    $0x30,%eax
  800653:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800656:	8b 45 10             	mov    0x10(%ebp),%eax
  800659:	8a 00                	mov    (%eax),%al
  80065b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80065e:	83 fb 2f             	cmp    $0x2f,%ebx
  800661:	7e 3e                	jle    8006a1 <vprintfmt+0xe9>
  800663:	83 fb 39             	cmp    $0x39,%ebx
  800666:	7f 39                	jg     8006a1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800668:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80066b:	eb d5                	jmp    800642 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80066d:	8b 45 14             	mov    0x14(%ebp),%eax
  800670:	83 c0 04             	add    $0x4,%eax
  800673:	89 45 14             	mov    %eax,0x14(%ebp)
  800676:	8b 45 14             	mov    0x14(%ebp),%eax
  800679:	83 e8 04             	sub    $0x4,%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800681:	eb 1f                	jmp    8006a2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800683:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800687:	79 83                	jns    80060c <vprintfmt+0x54>
				width = 0;
  800689:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800690:	e9 77 ff ff ff       	jmp    80060c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800695:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80069c:	e9 6b ff ff ff       	jmp    80060c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006a1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a6:	0f 89 60 ff ff ff    	jns    80060c <vprintfmt+0x54>
				width = precision, precision = -1;
  8006ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006b2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006b9:	e9 4e ff ff ff       	jmp    80060c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006be:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006c1:	e9 46 ff ff ff       	jmp    80060c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c9:	83 c0 04             	add    $0x4,%eax
  8006cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8006cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d2:	83 e8 04             	sub    $0x4,%eax
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	83 ec 08             	sub    $0x8,%esp
  8006da:	ff 75 0c             	pushl  0xc(%ebp)
  8006dd:	50                   	push   %eax
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	ff d0                	call   *%eax
  8006e3:	83 c4 10             	add    $0x10,%esp
			break;
  8006e6:	e9 9b 02 00 00       	jmp    800986 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ee:	83 c0 04             	add    $0x4,%eax
  8006f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f7:	83 e8 04             	sub    $0x4,%eax
  8006fa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006fc:	85 db                	test   %ebx,%ebx
  8006fe:	79 02                	jns    800702 <vprintfmt+0x14a>
				err = -err;
  800700:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800702:	83 fb 64             	cmp    $0x64,%ebx
  800705:	7f 0b                	jg     800712 <vprintfmt+0x15a>
  800707:	8b 34 9d 20 1f 80 00 	mov    0x801f20(,%ebx,4),%esi
  80070e:	85 f6                	test   %esi,%esi
  800710:	75 19                	jne    80072b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800712:	53                   	push   %ebx
  800713:	68 c5 20 80 00       	push   $0x8020c5
  800718:	ff 75 0c             	pushl  0xc(%ebp)
  80071b:	ff 75 08             	pushl  0x8(%ebp)
  80071e:	e8 70 02 00 00       	call   800993 <printfmt>
  800723:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800726:	e9 5b 02 00 00       	jmp    800986 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80072b:	56                   	push   %esi
  80072c:	68 ce 20 80 00       	push   $0x8020ce
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	ff 75 08             	pushl  0x8(%ebp)
  800737:	e8 57 02 00 00       	call   800993 <printfmt>
  80073c:	83 c4 10             	add    $0x10,%esp
			break;
  80073f:	e9 42 02 00 00       	jmp    800986 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800744:	8b 45 14             	mov    0x14(%ebp),%eax
  800747:	83 c0 04             	add    $0x4,%eax
  80074a:	89 45 14             	mov    %eax,0x14(%ebp)
  80074d:	8b 45 14             	mov    0x14(%ebp),%eax
  800750:	83 e8 04             	sub    $0x4,%eax
  800753:	8b 30                	mov    (%eax),%esi
  800755:	85 f6                	test   %esi,%esi
  800757:	75 05                	jne    80075e <vprintfmt+0x1a6>
				p = "(null)";
  800759:	be d1 20 80 00       	mov    $0x8020d1,%esi
			if (width > 0 && padc != '-')
  80075e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800762:	7e 6d                	jle    8007d1 <vprintfmt+0x219>
  800764:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800768:	74 67                	je     8007d1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80076a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	50                   	push   %eax
  800771:	56                   	push   %esi
  800772:	e8 1e 03 00 00       	call   800a95 <strnlen>
  800777:	83 c4 10             	add    $0x10,%esp
  80077a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80077d:	eb 16                	jmp    800795 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80077f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	50                   	push   %eax
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	ff d0                	call   *%eax
  80078f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800792:	ff 4d e4             	decl   -0x1c(%ebp)
  800795:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800799:	7f e4                	jg     80077f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80079b:	eb 34                	jmp    8007d1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80079d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007a1:	74 1c                	je     8007bf <vprintfmt+0x207>
  8007a3:	83 fb 1f             	cmp    $0x1f,%ebx
  8007a6:	7e 05                	jle    8007ad <vprintfmt+0x1f5>
  8007a8:	83 fb 7e             	cmp    $0x7e,%ebx
  8007ab:	7e 12                	jle    8007bf <vprintfmt+0x207>
					putch('?', putdat);
  8007ad:	83 ec 08             	sub    $0x8,%esp
  8007b0:	ff 75 0c             	pushl  0xc(%ebp)
  8007b3:	6a 3f                	push   $0x3f
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	ff d0                	call   *%eax
  8007ba:	83 c4 10             	add    $0x10,%esp
  8007bd:	eb 0f                	jmp    8007ce <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 0c             	pushl  0xc(%ebp)
  8007c5:	53                   	push   %ebx
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	ff d0                	call   *%eax
  8007cb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007ce:	ff 4d e4             	decl   -0x1c(%ebp)
  8007d1:	89 f0                	mov    %esi,%eax
  8007d3:	8d 70 01             	lea    0x1(%eax),%esi
  8007d6:	8a 00                	mov    (%eax),%al
  8007d8:	0f be d8             	movsbl %al,%ebx
  8007db:	85 db                	test   %ebx,%ebx
  8007dd:	74 24                	je     800803 <vprintfmt+0x24b>
  8007df:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007e3:	78 b8                	js     80079d <vprintfmt+0x1e5>
  8007e5:	ff 4d e0             	decl   -0x20(%ebp)
  8007e8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007ec:	79 af                	jns    80079d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007ee:	eb 13                	jmp    800803 <vprintfmt+0x24b>
				putch(' ', putdat);
  8007f0:	83 ec 08             	sub    $0x8,%esp
  8007f3:	ff 75 0c             	pushl  0xc(%ebp)
  8007f6:	6a 20                	push   $0x20
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	ff d0                	call   *%eax
  8007fd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800800:	ff 4d e4             	decl   -0x1c(%ebp)
  800803:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800807:	7f e7                	jg     8007f0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800809:	e9 78 01 00 00       	jmp    800986 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 e8             	pushl  -0x18(%ebp)
  800814:	8d 45 14             	lea    0x14(%ebp),%eax
  800817:	50                   	push   %eax
  800818:	e8 3c fd ff ff       	call   800559 <getint>
  80081d:	83 c4 10             	add    $0x10,%esp
  800820:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800823:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800826:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800829:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80082c:	85 d2                	test   %edx,%edx
  80082e:	79 23                	jns    800853 <vprintfmt+0x29b>
				putch('-', putdat);
  800830:	83 ec 08             	sub    $0x8,%esp
  800833:	ff 75 0c             	pushl  0xc(%ebp)
  800836:	6a 2d                	push   $0x2d
  800838:	8b 45 08             	mov    0x8(%ebp),%eax
  80083b:	ff d0                	call   *%eax
  80083d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800840:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800843:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800846:	f7 d8                	neg    %eax
  800848:	83 d2 00             	adc    $0x0,%edx
  80084b:	f7 da                	neg    %edx
  80084d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800850:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800853:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80085a:	e9 bc 00 00 00       	jmp    80091b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 e8             	pushl  -0x18(%ebp)
  800865:	8d 45 14             	lea    0x14(%ebp),%eax
  800868:	50                   	push   %eax
  800869:	e8 84 fc ff ff       	call   8004f2 <getuint>
  80086e:	83 c4 10             	add    $0x10,%esp
  800871:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800874:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800877:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80087e:	e9 98 00 00 00       	jmp    80091b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800883:	83 ec 08             	sub    $0x8,%esp
  800886:	ff 75 0c             	pushl  0xc(%ebp)
  800889:	6a 58                	push   $0x58
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	ff d0                	call   *%eax
  800890:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800893:	83 ec 08             	sub    $0x8,%esp
  800896:	ff 75 0c             	pushl  0xc(%ebp)
  800899:	6a 58                	push   $0x58
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	ff d0                	call   *%eax
  8008a0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008a3:	83 ec 08             	sub    $0x8,%esp
  8008a6:	ff 75 0c             	pushl  0xc(%ebp)
  8008a9:	6a 58                	push   $0x58
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	ff d0                	call   *%eax
  8008b0:	83 c4 10             	add    $0x10,%esp
			break;
  8008b3:	e9 ce 00 00 00       	jmp    800986 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  8008b8:	83 ec 08             	sub    $0x8,%esp
  8008bb:	ff 75 0c             	pushl  0xc(%ebp)
  8008be:	6a 30                	push   $0x30
  8008c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c3:	ff d0                	call   *%eax
  8008c5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008c8:	83 ec 08             	sub    $0x8,%esp
  8008cb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ce:	6a 78                	push   $0x78
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	ff d0                	call   *%eax
  8008d5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008db:	83 c0 04             	add    $0x4,%eax
  8008de:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e4:	83 e8 04             	sub    $0x4,%eax
  8008e7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008f3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008fa:	eb 1f                	jmp    80091b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 e8             	pushl  -0x18(%ebp)
  800902:	8d 45 14             	lea    0x14(%ebp),%eax
  800905:	50                   	push   %eax
  800906:	e8 e7 fb ff ff       	call   8004f2 <getuint>
  80090b:	83 c4 10             	add    $0x10,%esp
  80090e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800911:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800914:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80091b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80091f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	52                   	push   %edx
  800926:	ff 75 e4             	pushl  -0x1c(%ebp)
  800929:	50                   	push   %eax
  80092a:	ff 75 f4             	pushl  -0xc(%ebp)
  80092d:	ff 75 f0             	pushl  -0x10(%ebp)
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	ff 75 08             	pushl  0x8(%ebp)
  800936:	e8 00 fb ff ff       	call   80043b <printnum>
  80093b:	83 c4 20             	add    $0x20,%esp
			break;
  80093e:	eb 46                	jmp    800986 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800940:	83 ec 08             	sub    $0x8,%esp
  800943:	ff 75 0c             	pushl  0xc(%ebp)
  800946:	53                   	push   %ebx
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	ff d0                	call   *%eax
  80094c:	83 c4 10             	add    $0x10,%esp
			break;
  80094f:	eb 35                	jmp    800986 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800951:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800958:	eb 2c                	jmp    800986 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80095a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800961:	eb 23                	jmp    800986 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	ff 75 0c             	pushl  0xc(%ebp)
  800969:	6a 25                	push   $0x25
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	ff d0                	call   *%eax
  800970:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800973:	ff 4d 10             	decl   0x10(%ebp)
  800976:	eb 03                	jmp    80097b <vprintfmt+0x3c3>
  800978:	ff 4d 10             	decl   0x10(%ebp)
  80097b:	8b 45 10             	mov    0x10(%ebp),%eax
  80097e:	48                   	dec    %eax
  80097f:	8a 00                	mov    (%eax),%al
  800981:	3c 25                	cmp    $0x25,%al
  800983:	75 f3                	jne    800978 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800985:	90                   	nop
		}
	}
  800986:	e9 35 fc ff ff       	jmp    8005c0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80098b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80098c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80098f:	5b                   	pop    %ebx
  800990:	5e                   	pop    %esi
  800991:	5d                   	pop    %ebp
  800992:	c3                   	ret    

00800993 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800993:	55                   	push   %ebp
  800994:	89 e5                	mov    %esp,%ebp
  800996:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800999:	8d 45 10             	lea    0x10(%ebp),%eax
  80099c:	83 c0 04             	add    $0x4,%eax
  80099f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a8:	50                   	push   %eax
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	ff 75 08             	pushl  0x8(%ebp)
  8009af:	e8 04 fc ff ff       	call   8005b8 <vprintfmt>
  8009b4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009b7:	90                   	nop
  8009b8:	c9                   	leave  
  8009b9:	c3                   	ret    

008009ba <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009ba:	55                   	push   %ebp
  8009bb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c0:	8b 40 08             	mov    0x8(%eax),%eax
  8009c3:	8d 50 01             	lea    0x1(%eax),%edx
  8009c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cf:	8b 10                	mov    (%eax),%edx
  8009d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d4:	8b 40 04             	mov    0x4(%eax),%eax
  8009d7:	39 c2                	cmp    %eax,%edx
  8009d9:	73 12                	jae    8009ed <sprintputch+0x33>
		*b->buf++ = ch;
  8009db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009de:	8b 00                	mov    (%eax),%eax
  8009e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8009e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e6:	89 0a                	mov    %ecx,(%edx)
  8009e8:	8b 55 08             	mov    0x8(%ebp),%edx
  8009eb:	88 10                	mov    %dl,(%eax)
}
  8009ed:	90                   	nop
  8009ee:	5d                   	pop    %ebp
  8009ef:	c3                   	ret    

008009f0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009f0:	55                   	push   %ebp
  8009f1:	89 e5                	mov    %esp,%ebp
  8009f3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	01 d0                	add    %edx,%eax
  800a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a11:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a15:	74 06                	je     800a1d <vsnprintf+0x2d>
  800a17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a1b:	7f 07                	jg     800a24 <vsnprintf+0x34>
		return -E_INVAL;
  800a1d:	b8 03 00 00 00       	mov    $0x3,%eax
  800a22:	eb 20                	jmp    800a44 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a24:	ff 75 14             	pushl  0x14(%ebp)
  800a27:	ff 75 10             	pushl  0x10(%ebp)
  800a2a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a2d:	50                   	push   %eax
  800a2e:	68 ba 09 80 00       	push   $0x8009ba
  800a33:	e8 80 fb ff ff       	call   8005b8 <vprintfmt>
  800a38:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a3e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a44:	c9                   	leave  
  800a45:	c3                   	ret    

00800a46 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a46:	55                   	push   %ebp
  800a47:	89 e5                	mov    %esp,%ebp
  800a49:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a4c:	8d 45 10             	lea    0x10(%ebp),%eax
  800a4f:	83 c0 04             	add    $0x4,%eax
  800a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a55:	8b 45 10             	mov    0x10(%ebp),%eax
  800a58:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5b:	50                   	push   %eax
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	ff 75 08             	pushl  0x8(%ebp)
  800a62:	e8 89 ff ff ff       	call   8009f0 <vsnprintf>
  800a67:	83 c4 10             	add    $0x10,%esp
  800a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a70:	c9                   	leave  
  800a71:	c3                   	ret    

00800a72 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
  800a75:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a7f:	eb 06                	jmp    800a87 <strlen+0x15>
		n++;
  800a81:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a84:	ff 45 08             	incl   0x8(%ebp)
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	8a 00                	mov    (%eax),%al
  800a8c:	84 c0                	test   %al,%al
  800a8e:	75 f1                	jne    800a81 <strlen+0xf>
		n++;
	return n;
  800a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a93:	c9                   	leave  
  800a94:	c3                   	ret    

00800a95 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a95:	55                   	push   %ebp
  800a96:	89 e5                	mov    %esp,%ebp
  800a98:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800aa2:	eb 09                	jmp    800aad <strnlen+0x18>
		n++;
  800aa4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800aa7:	ff 45 08             	incl   0x8(%ebp)
  800aaa:	ff 4d 0c             	decl   0xc(%ebp)
  800aad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab1:	74 09                	je     800abc <strnlen+0x27>
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	8a 00                	mov    (%eax),%al
  800ab8:	84 c0                	test   %al,%al
  800aba:	75 e8                	jne    800aa4 <strnlen+0xf>
		n++;
	return n;
  800abc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800abf:	c9                   	leave  
  800ac0:	c3                   	ret    

00800ac1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ac1:	55                   	push   %ebp
  800ac2:	89 e5                	mov    %esp,%ebp
  800ac4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800acd:	90                   	nop
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	8d 50 01             	lea    0x1(%eax),%edx
  800ad4:	89 55 08             	mov    %edx,0x8(%ebp)
  800ad7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ada:	8d 4a 01             	lea    0x1(%edx),%ecx
  800add:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ae0:	8a 12                	mov    (%edx),%dl
  800ae2:	88 10                	mov    %dl,(%eax)
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	84 c0                	test   %al,%al
  800ae8:	75 e4                	jne    800ace <strcpy+0xd>
		/* do nothing */;
	return ret;
  800aea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aed:	c9                   	leave  
  800aee:	c3                   	ret    

00800aef <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800afb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b02:	eb 1f                	jmp    800b23 <strncpy+0x34>
		*dst++ = *src;
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	8d 50 01             	lea    0x1(%eax),%edx
  800b0a:	89 55 08             	mov    %edx,0x8(%ebp)
  800b0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b10:	8a 12                	mov    (%edx),%dl
  800b12:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	8a 00                	mov    (%eax),%al
  800b19:	84 c0                	test   %al,%al
  800b1b:	74 03                	je     800b20 <strncpy+0x31>
			src++;
  800b1d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b20:	ff 45 fc             	incl   -0x4(%ebp)
  800b23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b26:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b29:	72 d9                	jb     800b04 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b2e:	c9                   	leave  
  800b2f:	c3                   	ret    

00800b30 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b30:	55                   	push   %ebp
  800b31:	89 e5                	mov    %esp,%ebp
  800b33:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b40:	74 30                	je     800b72 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b42:	eb 16                	jmp    800b5a <strlcpy+0x2a>
			*dst++ = *src++;
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
  800b47:	8d 50 01             	lea    0x1(%eax),%edx
  800b4a:	89 55 08             	mov    %edx,0x8(%ebp)
  800b4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b50:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b53:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b56:	8a 12                	mov    (%edx),%dl
  800b58:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b5a:	ff 4d 10             	decl   0x10(%ebp)
  800b5d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b61:	74 09                	je     800b6c <strlcpy+0x3c>
  800b63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	84 c0                	test   %al,%al
  800b6a:	75 d8                	jne    800b44 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b72:	8b 55 08             	mov    0x8(%ebp),%edx
  800b75:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b78:	29 c2                	sub    %eax,%edx
  800b7a:	89 d0                	mov    %edx,%eax
}
  800b7c:	c9                   	leave  
  800b7d:	c3                   	ret    

00800b7e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b7e:	55                   	push   %ebp
  800b7f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b81:	eb 06                	jmp    800b89 <strcmp+0xb>
		p++, q++;
  800b83:	ff 45 08             	incl   0x8(%ebp)
  800b86:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8a 00                	mov    (%eax),%al
  800b8e:	84 c0                	test   %al,%al
  800b90:	74 0e                	je     800ba0 <strcmp+0x22>
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	8a 10                	mov    (%eax),%dl
  800b97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9a:	8a 00                	mov    (%eax),%al
  800b9c:	38 c2                	cmp    %al,%dl
  800b9e:	74 e3                	je     800b83 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8a 00                	mov    (%eax),%al
  800ba5:	0f b6 d0             	movzbl %al,%edx
  800ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	0f b6 c0             	movzbl %al,%eax
  800bb0:	29 c2                	sub    %eax,%edx
  800bb2:	89 d0                	mov    %edx,%eax
}
  800bb4:	5d                   	pop    %ebp
  800bb5:	c3                   	ret    

00800bb6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bb9:	eb 09                	jmp    800bc4 <strncmp+0xe>
		n--, p++, q++;
  800bbb:	ff 4d 10             	decl   0x10(%ebp)
  800bbe:	ff 45 08             	incl   0x8(%ebp)
  800bc1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bc8:	74 17                	je     800be1 <strncmp+0x2b>
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	84 c0                	test   %al,%al
  800bd1:	74 0e                	je     800be1 <strncmp+0x2b>
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	8a 10                	mov    (%eax),%dl
  800bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdb:	8a 00                	mov    (%eax),%al
  800bdd:	38 c2                	cmp    %al,%dl
  800bdf:	74 da                	je     800bbb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800be1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800be5:	75 07                	jne    800bee <strncmp+0x38>
		return 0;
  800be7:	b8 00 00 00 00       	mov    $0x0,%eax
  800bec:	eb 14                	jmp    800c02 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	0f b6 d0             	movzbl %al,%edx
  800bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f b6 c0             	movzbl %al,%eax
  800bfe:	29 c2                	sub    %eax,%edx
  800c00:	89 d0                	mov    %edx,%eax
}
  800c02:	5d                   	pop    %ebp
  800c03:	c3                   	ret    

00800c04 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c04:	55                   	push   %ebp
  800c05:	89 e5                	mov    %esp,%ebp
  800c07:	83 ec 04             	sub    $0x4,%esp
  800c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c10:	eb 12                	jmp    800c24 <strchr+0x20>
		if (*s == c)
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8a 00                	mov    (%eax),%al
  800c17:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c1a:	75 05                	jne    800c21 <strchr+0x1d>
			return (char *) s;
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	eb 11                	jmp    800c32 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c21:	ff 45 08             	incl   0x8(%ebp)
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	84 c0                	test   %al,%al
  800c2b:	75 e5                	jne    800c12 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c2d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c32:	c9                   	leave  
  800c33:	c3                   	ret    

00800c34 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c34:	55                   	push   %ebp
  800c35:	89 e5                	mov    %esp,%ebp
  800c37:	83 ec 04             	sub    $0x4,%esp
  800c3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c40:	eb 0d                	jmp    800c4f <strfind+0x1b>
		if (*s == c)
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c4a:	74 0e                	je     800c5a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c4c:	ff 45 08             	incl   0x8(%ebp)
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	84 c0                	test   %al,%al
  800c56:	75 ea                	jne    800c42 <strfind+0xe>
  800c58:	eb 01                	jmp    800c5b <strfind+0x27>
		if (*s == c)
			break;
  800c5a:	90                   	nop
	return (char *) s;
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5e:	c9                   	leave  
  800c5f:	c3                   	ret    

00800c60 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800c60:	55                   	push   %ebp
  800c61:	89 e5                	mov    %esp,%ebp
  800c63:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800c6c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800c70:	76 63                	jbe    800cd5 <memset+0x75>
		uint64 data_block = c;
  800c72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c75:	99                   	cltd   
  800c76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c79:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c82:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800c86:	c1 e0 08             	shl    $0x8,%eax
  800c89:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c8c:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c92:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c95:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800c99:	c1 e0 10             	shl    $0x10,%eax
  800c9c:	09 45 f0             	or     %eax,-0x10(%ebp)
  800c9f:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ca5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca8:	89 c2                	mov    %eax,%edx
  800caa:	b8 00 00 00 00       	mov    $0x0,%eax
  800caf:	09 45 f0             	or     %eax,-0x10(%ebp)
  800cb2:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800cb5:	eb 18                	jmp    800ccf <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800cb7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800cba:	8d 41 08             	lea    0x8(%ecx),%eax
  800cbd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800cc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cc6:	89 01                	mov    %eax,(%ecx)
  800cc8:	89 51 04             	mov    %edx,0x4(%ecx)
  800ccb:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800ccf:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800cd3:	77 e2                	ja     800cb7 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800cd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd9:	74 23                	je     800cfe <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800cdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cde:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ce1:	eb 0e                	jmp    800cf1 <memset+0x91>
			*p8++ = (uint8)c;
  800ce3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ce6:	8d 50 01             	lea    0x1(%eax),%edx
  800ce9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cec:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cef:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800cf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf7:	89 55 10             	mov    %edx,0x10(%ebp)
  800cfa:	85 c0                	test   %eax,%eax
  800cfc:	75 e5                	jne    800ce3 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d01:	c9                   	leave  
  800d02:	c3                   	ret    

00800d03 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
  800d06:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d15:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d19:	76 24                	jbe    800d3f <memcpy+0x3c>
		while(n >= 8){
  800d1b:	eb 1c                	jmp    800d39 <memcpy+0x36>
			*d64 = *s64;
  800d1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d20:	8b 50 04             	mov    0x4(%eax),%edx
  800d23:	8b 00                	mov    (%eax),%eax
  800d25:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d28:	89 01                	mov    %eax,(%ecx)
  800d2a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800d2d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800d31:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800d35:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800d39:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d3d:	77 de                	ja     800d1d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800d3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d43:	74 31                	je     800d76 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800d45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800d4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800d51:	eb 16                	jmp    800d69 <memcpy+0x66>
			*d8++ = *s8++;
  800d53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d56:	8d 50 01             	lea    0x1(%eax),%edx
  800d59:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800d5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d5f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d62:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800d65:	8a 12                	mov    (%edx),%dl
  800d67:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800d69:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d72:	85 c0                	test   %eax,%eax
  800d74:	75 dd                	jne    800d53 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d79:	c9                   	leave  
  800d7a:	c3                   	ret    

00800d7b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d7b:	55                   	push   %ebp
  800d7c:	89 e5                	mov    %esp,%ebp
  800d7e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d90:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d93:	73 50                	jae    800de5 <memmove+0x6a>
  800d95:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d98:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9b:	01 d0                	add    %edx,%eax
  800d9d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da0:	76 43                	jbe    800de5 <memmove+0x6a>
		s += n;
  800da2:	8b 45 10             	mov    0x10(%ebp),%eax
  800da5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800da8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dab:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dae:	eb 10                	jmp    800dc0 <memmove+0x45>
			*--d = *--s;
  800db0:	ff 4d f8             	decl   -0x8(%ebp)
  800db3:	ff 4d fc             	decl   -0x4(%ebp)
  800db6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db9:	8a 10                	mov    (%eax),%dl
  800dbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc6:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc9:	85 c0                	test   %eax,%eax
  800dcb:	75 e3                	jne    800db0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dcd:	eb 23                	jmp    800df2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd2:	8d 50 01             	lea    0x1(%eax),%edx
  800dd5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ddb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dde:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800de1:	8a 12                	mov    (%edx),%dl
  800de3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800de5:	8b 45 10             	mov    0x10(%ebp),%eax
  800de8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800deb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dee:	85 c0                	test   %eax,%eax
  800df0:	75 dd                	jne    800dcf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800df5:	c9                   	leave  
  800df6:	c3                   	ret    

00800df7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800df7:	55                   	push   %ebp
  800df8:	89 e5                	mov    %esp,%ebp
  800dfa:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e06:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e09:	eb 2a                	jmp    800e35 <memcmp+0x3e>
		if (*s1 != *s2)
  800e0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0e:	8a 10                	mov    (%eax),%dl
  800e10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	38 c2                	cmp    %al,%dl
  800e17:	74 16                	je     800e2f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f b6 d0             	movzbl %al,%edx
  800e21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e24:	8a 00                	mov    (%eax),%al
  800e26:	0f b6 c0             	movzbl %al,%eax
  800e29:	29 c2                	sub    %eax,%edx
  800e2b:	89 d0                	mov    %edx,%eax
  800e2d:	eb 18                	jmp    800e47 <memcmp+0x50>
		s1++, s2++;
  800e2f:	ff 45 fc             	incl   -0x4(%ebp)
  800e32:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e35:	8b 45 10             	mov    0x10(%ebp),%eax
  800e38:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3e:	85 c0                	test   %eax,%eax
  800e40:	75 c9                	jne    800e0b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e42:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e47:	c9                   	leave  
  800e48:	c3                   	ret    

00800e49 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e49:	55                   	push   %ebp
  800e4a:	89 e5                	mov    %esp,%ebp
  800e4c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800e52:	8b 45 10             	mov    0x10(%ebp),%eax
  800e55:	01 d0                	add    %edx,%eax
  800e57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e5a:	eb 15                	jmp    800e71 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f b6 d0             	movzbl %al,%edx
  800e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e67:	0f b6 c0             	movzbl %al,%eax
  800e6a:	39 c2                	cmp    %eax,%edx
  800e6c:	74 0d                	je     800e7b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e6e:	ff 45 08             	incl   0x8(%ebp)
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e77:	72 e3                	jb     800e5c <memfind+0x13>
  800e79:	eb 01                	jmp    800e7c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e7b:	90                   	nop
	return (void *) s;
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7f:	c9                   	leave  
  800e80:	c3                   	ret    

00800e81 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e81:	55                   	push   %ebp
  800e82:	89 e5                	mov    %esp,%ebp
  800e84:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e8e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e95:	eb 03                	jmp    800e9a <strtol+0x19>
		s++;
  800e97:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8a 00                	mov    (%eax),%al
  800e9f:	3c 20                	cmp    $0x20,%al
  800ea1:	74 f4                	je     800e97 <strtol+0x16>
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	3c 09                	cmp    $0x9,%al
  800eaa:	74 eb                	je     800e97 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	3c 2b                	cmp    $0x2b,%al
  800eb3:	75 05                	jne    800eba <strtol+0x39>
		s++;
  800eb5:	ff 45 08             	incl   0x8(%ebp)
  800eb8:	eb 13                	jmp    800ecd <strtol+0x4c>
	else if (*s == '-')
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	8a 00                	mov    (%eax),%al
  800ebf:	3c 2d                	cmp    $0x2d,%al
  800ec1:	75 0a                	jne    800ecd <strtol+0x4c>
		s++, neg = 1;
  800ec3:	ff 45 08             	incl   0x8(%ebp)
  800ec6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ecd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed1:	74 06                	je     800ed9 <strtol+0x58>
  800ed3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ed7:	75 20                	jne    800ef9 <strtol+0x78>
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	3c 30                	cmp    $0x30,%al
  800ee0:	75 17                	jne    800ef9 <strtol+0x78>
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	40                   	inc    %eax
  800ee6:	8a 00                	mov    (%eax),%al
  800ee8:	3c 78                	cmp    $0x78,%al
  800eea:	75 0d                	jne    800ef9 <strtol+0x78>
		s += 2, base = 16;
  800eec:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ef0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ef7:	eb 28                	jmp    800f21 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ef9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800efd:	75 15                	jne    800f14 <strtol+0x93>
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	3c 30                	cmp    $0x30,%al
  800f06:	75 0c                	jne    800f14 <strtol+0x93>
		s++, base = 8;
  800f08:	ff 45 08             	incl   0x8(%ebp)
  800f0b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f12:	eb 0d                	jmp    800f21 <strtol+0xa0>
	else if (base == 0)
  800f14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f18:	75 07                	jne    800f21 <strtol+0xa0>
		base = 10;
  800f1a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	3c 2f                	cmp    $0x2f,%al
  800f28:	7e 19                	jle    800f43 <strtol+0xc2>
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	3c 39                	cmp    $0x39,%al
  800f31:	7f 10                	jg     800f43 <strtol+0xc2>
			dig = *s - '0';
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f be c0             	movsbl %al,%eax
  800f3b:	83 e8 30             	sub    $0x30,%eax
  800f3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f41:	eb 42                	jmp    800f85 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	3c 60                	cmp    $0x60,%al
  800f4a:	7e 19                	jle    800f65 <strtol+0xe4>
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 7a                	cmp    $0x7a,%al
  800f53:	7f 10                	jg     800f65 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	0f be c0             	movsbl %al,%eax
  800f5d:	83 e8 57             	sub    $0x57,%eax
  800f60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f63:	eb 20                	jmp    800f85 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	3c 40                	cmp    $0x40,%al
  800f6c:	7e 39                	jle    800fa7 <strtol+0x126>
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 5a                	cmp    $0x5a,%al
  800f75:	7f 30                	jg     800fa7 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f be c0             	movsbl %al,%eax
  800f7f:	83 e8 37             	sub    $0x37,%eax
  800f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f88:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f8b:	7d 19                	jge    800fa6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f8d:	ff 45 08             	incl   0x8(%ebp)
  800f90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f93:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f97:	89 c2                	mov    %eax,%edx
  800f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f9c:	01 d0                	add    %edx,%eax
  800f9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fa1:	e9 7b ff ff ff       	jmp    800f21 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fa6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fa7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fab:	74 08                	je     800fb5 <strtol+0x134>
		*endptr = (char *) s;
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fb5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fb9:	74 07                	je     800fc2 <strtol+0x141>
  800fbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbe:	f7 d8                	neg    %eax
  800fc0:	eb 03                	jmp    800fc5 <strtol+0x144>
  800fc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fc5:	c9                   	leave  
  800fc6:	c3                   	ret    

00800fc7 <ltostr>:

void
ltostr(long value, char *str)
{
  800fc7:	55                   	push   %ebp
  800fc8:	89 e5                	mov    %esp,%ebp
  800fca:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fd4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fdb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fdf:	79 13                	jns    800ff4 <ltostr+0x2d>
	{
		neg = 1;
  800fe1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fee:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ff1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ffc:	99                   	cltd   
  800ffd:	f7 f9                	idiv   %ecx
  800fff:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801002:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801005:	8d 50 01             	lea    0x1(%eax),%edx
  801008:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80100b:	89 c2                	mov    %eax,%edx
  80100d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801010:	01 d0                	add    %edx,%eax
  801012:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801015:	83 c2 30             	add    $0x30,%edx
  801018:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80101a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80101d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801022:	f7 e9                	imul   %ecx
  801024:	c1 fa 02             	sar    $0x2,%edx
  801027:	89 c8                	mov    %ecx,%eax
  801029:	c1 f8 1f             	sar    $0x1f,%eax
  80102c:	29 c2                	sub    %eax,%edx
  80102e:	89 d0                	mov    %edx,%eax
  801030:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801033:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801037:	75 bb                	jne    800ff4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801039:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801043:	48                   	dec    %eax
  801044:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801047:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80104b:	74 3d                	je     80108a <ltostr+0xc3>
		start = 1 ;
  80104d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801054:	eb 34                	jmp    80108a <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801056:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801059:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105c:	01 d0                	add    %edx,%eax
  80105e:	8a 00                	mov    (%eax),%al
  801060:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801063:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801066:	8b 45 0c             	mov    0xc(%ebp),%eax
  801069:	01 c2                	add    %eax,%edx
  80106b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	01 c8                	add    %ecx,%eax
  801073:	8a 00                	mov    (%eax),%al
  801075:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801077:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80107a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107d:	01 c2                	add    %eax,%edx
  80107f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801082:	88 02                	mov    %al,(%edx)
		start++ ;
  801084:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801087:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80108a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80108d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801090:	7c c4                	jl     801056 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801092:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801095:	8b 45 0c             	mov    0xc(%ebp),%eax
  801098:	01 d0                	add    %edx,%eax
  80109a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80109d:	90                   	nop
  80109e:	c9                   	leave  
  80109f:	c3                   	ret    

008010a0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010a0:	55                   	push   %ebp
  8010a1:	89 e5                	mov    %esp,%ebp
  8010a3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010a6:	ff 75 08             	pushl  0x8(%ebp)
  8010a9:	e8 c4 f9 ff ff       	call   800a72 <strlen>
  8010ae:	83 c4 04             	add    $0x4,%esp
  8010b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010b4:	ff 75 0c             	pushl  0xc(%ebp)
  8010b7:	e8 b6 f9 ff ff       	call   800a72 <strlen>
  8010bc:	83 c4 04             	add    $0x4,%esp
  8010bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010d0:	eb 17                	jmp    8010e9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d8:	01 c2                	add    %eax,%edx
  8010da:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	01 c8                	add    %ecx,%eax
  8010e2:	8a 00                	mov    (%eax),%al
  8010e4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010e6:	ff 45 fc             	incl   -0x4(%ebp)
  8010e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010ef:	7c e1                	jl     8010d2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010ff:	eb 1f                	jmp    801120 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801101:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801104:	8d 50 01             	lea    0x1(%eax),%edx
  801107:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80110a:	89 c2                	mov    %eax,%edx
  80110c:	8b 45 10             	mov    0x10(%ebp),%eax
  80110f:	01 c2                	add    %eax,%edx
  801111:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801114:	8b 45 0c             	mov    0xc(%ebp),%eax
  801117:	01 c8                	add    %ecx,%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80111d:	ff 45 f8             	incl   -0x8(%ebp)
  801120:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801123:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801126:	7c d9                	jl     801101 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801128:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80112b:	8b 45 10             	mov    0x10(%ebp),%eax
  80112e:	01 d0                	add    %edx,%eax
  801130:	c6 00 00             	movb   $0x0,(%eax)
}
  801133:	90                   	nop
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801139:	8b 45 14             	mov    0x14(%ebp),%eax
  80113c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801142:	8b 45 14             	mov    0x14(%ebp),%eax
  801145:	8b 00                	mov    (%eax),%eax
  801147:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80114e:	8b 45 10             	mov    0x10(%ebp),%eax
  801151:	01 d0                	add    %edx,%eax
  801153:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801159:	eb 0c                	jmp    801167 <strsplit+0x31>
			*string++ = 0;
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8d 50 01             	lea    0x1(%eax),%edx
  801161:	89 55 08             	mov    %edx,0x8(%ebp)
  801164:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	84 c0                	test   %al,%al
  80116e:	74 18                	je     801188 <strsplit+0x52>
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	8a 00                	mov    (%eax),%al
  801175:	0f be c0             	movsbl %al,%eax
  801178:	50                   	push   %eax
  801179:	ff 75 0c             	pushl  0xc(%ebp)
  80117c:	e8 83 fa ff ff       	call   800c04 <strchr>
  801181:	83 c4 08             	add    $0x8,%esp
  801184:	85 c0                	test   %eax,%eax
  801186:	75 d3                	jne    80115b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	84 c0                	test   %al,%al
  80118f:	74 5a                	je     8011eb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801191:	8b 45 14             	mov    0x14(%ebp),%eax
  801194:	8b 00                	mov    (%eax),%eax
  801196:	83 f8 0f             	cmp    $0xf,%eax
  801199:	75 07                	jne    8011a2 <strsplit+0x6c>
		{
			return 0;
  80119b:	b8 00 00 00 00       	mov    $0x0,%eax
  8011a0:	eb 66                	jmp    801208 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a5:	8b 00                	mov    (%eax),%eax
  8011a7:	8d 48 01             	lea    0x1(%eax),%ecx
  8011aa:	8b 55 14             	mov    0x14(%ebp),%edx
  8011ad:	89 0a                	mov    %ecx,(%edx)
  8011af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b9:	01 c2                	add    %eax,%edx
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011c0:	eb 03                	jmp    8011c5 <strsplit+0x8f>
			string++;
  8011c2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	84 c0                	test   %al,%al
  8011cc:	74 8b                	je     801159 <strsplit+0x23>
  8011ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d1:	8a 00                	mov    (%eax),%al
  8011d3:	0f be c0             	movsbl %al,%eax
  8011d6:	50                   	push   %eax
  8011d7:	ff 75 0c             	pushl  0xc(%ebp)
  8011da:	e8 25 fa ff ff       	call   800c04 <strchr>
  8011df:	83 c4 08             	add    $0x8,%esp
  8011e2:	85 c0                	test   %eax,%eax
  8011e4:	74 dc                	je     8011c2 <strsplit+0x8c>
			string++;
	}
  8011e6:	e9 6e ff ff ff       	jmp    801159 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011eb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ef:	8b 00                	mov    (%eax),%eax
  8011f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fb:	01 d0                	add    %edx,%eax
  8011fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801203:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
  80120d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801216:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121d:	eb 4a                	jmp    801269 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80121f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
  801225:	01 c2                	add    %eax,%edx
  801227:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80122a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122d:	01 c8                	add    %ecx,%eax
  80122f:	8a 00                	mov    (%eax),%al
  801231:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801233:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801236:	8b 45 0c             	mov    0xc(%ebp),%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	3c 40                	cmp    $0x40,%al
  80123f:	7e 25                	jle    801266 <str2lower+0x5c>
  801241:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801244:	8b 45 0c             	mov    0xc(%ebp),%eax
  801247:	01 d0                	add    %edx,%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	3c 5a                	cmp    $0x5a,%al
  80124d:	7f 17                	jg     801266 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80124f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	01 d0                	add    %edx,%eax
  801257:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80125a:	8b 55 08             	mov    0x8(%ebp),%edx
  80125d:	01 ca                	add    %ecx,%edx
  80125f:	8a 12                	mov    (%edx),%dl
  801261:	83 c2 20             	add    $0x20,%edx
  801264:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801266:	ff 45 fc             	incl   -0x4(%ebp)
  801269:	ff 75 0c             	pushl  0xc(%ebp)
  80126c:	e8 01 f8 ff ff       	call   800a72 <strlen>
  801271:	83 c4 04             	add    $0x4,%esp
  801274:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801277:	7f a6                	jg     80121f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801279:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
  801281:	57                   	push   %edi
  801282:	56                   	push   %esi
  801283:	53                   	push   %ebx
  801284:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801287:	8b 45 08             	mov    0x8(%ebp),%eax
  80128a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801290:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801293:	8b 7d 18             	mov    0x18(%ebp),%edi
  801296:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801299:	cd 30                	int    $0x30
  80129b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80129e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012a1:	83 c4 10             	add    $0x10,%esp
  8012a4:	5b                   	pop    %ebx
  8012a5:	5e                   	pop    %esi
  8012a6:	5f                   	pop    %edi
  8012a7:	5d                   	pop    %ebp
  8012a8:	c3                   	ret    

008012a9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8012a9:	55                   	push   %ebp
  8012aa:	89 e5                	mov    %esp,%ebp
  8012ac:	83 ec 04             	sub    $0x4,%esp
  8012af:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8012b5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012b8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	6a 00                	push   $0x0
  8012c1:	51                   	push   %ecx
  8012c2:	52                   	push   %edx
  8012c3:	ff 75 0c             	pushl  0xc(%ebp)
  8012c6:	50                   	push   %eax
  8012c7:	6a 00                	push   $0x0
  8012c9:	e8 b0 ff ff ff       	call   80127e <syscall>
  8012ce:	83 c4 18             	add    $0x18,%esp
}
  8012d1:	90                   	nop
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 02                	push   $0x2
  8012e3:	e8 96 ff ff ff       	call   80127e <syscall>
  8012e8:	83 c4 18             	add    $0x18,%esp
}
  8012eb:	c9                   	leave  
  8012ec:	c3                   	ret    

008012ed <sys_lock_cons>:

void sys_lock_cons(void)
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 03                	push   $0x3
  8012fc:	e8 7d ff ff ff       	call   80127e <syscall>
  801301:	83 c4 18             	add    $0x18,%esp
}
  801304:	90                   	nop
  801305:	c9                   	leave  
  801306:	c3                   	ret    

00801307 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801307:	55                   	push   %ebp
  801308:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 04                	push   $0x4
  801316:	e8 63 ff ff ff       	call   80127e <syscall>
  80131b:	83 c4 18             	add    $0x18,%esp
}
  80131e:	90                   	nop
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801324:	8b 55 0c             	mov    0xc(%ebp),%edx
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	52                   	push   %edx
  801331:	50                   	push   %eax
  801332:	6a 08                	push   $0x8
  801334:	e8 45 ff ff ff       	call   80127e <syscall>
  801339:	83 c4 18             	add    $0x18,%esp
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	56                   	push   %esi
  801342:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801343:	8b 75 18             	mov    0x18(%ebp),%esi
  801346:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801349:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80134c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	56                   	push   %esi
  801353:	53                   	push   %ebx
  801354:	51                   	push   %ecx
  801355:	52                   	push   %edx
  801356:	50                   	push   %eax
  801357:	6a 09                	push   $0x9
  801359:	e8 20 ff ff ff       	call   80127e <syscall>
  80135e:	83 c4 18             	add    $0x18,%esp
}
  801361:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801364:	5b                   	pop    %ebx
  801365:	5e                   	pop    %esi
  801366:	5d                   	pop    %ebp
  801367:	c3                   	ret    

00801368 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	ff 75 08             	pushl  0x8(%ebp)
  801376:	6a 0a                	push   $0xa
  801378:	e8 01 ff ff ff       	call   80127e <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	ff 75 0c             	pushl  0xc(%ebp)
  80138e:	ff 75 08             	pushl  0x8(%ebp)
  801391:	6a 0b                	push   $0xb
  801393:	e8 e6 fe ff ff       	call   80127e <syscall>
  801398:	83 c4 18             	add    $0x18,%esp
}
  80139b:	c9                   	leave  
  80139c:	c3                   	ret    

0080139d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 0c                	push   $0xc
  8013ac:	e8 cd fe ff ff       	call   80127e <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 0d                	push   $0xd
  8013c5:	e8 b4 fe ff ff       	call   80127e <syscall>
  8013ca:	83 c4 18             	add    $0x18,%esp
}
  8013cd:	c9                   	leave  
  8013ce:	c3                   	ret    

008013cf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 0e                	push   $0xe
  8013de:	e8 9b fe ff ff       	call   80127e <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 0f                	push   $0xf
  8013f7:	e8 82 fe ff ff       	call   80127e <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	ff 75 08             	pushl  0x8(%ebp)
  80140f:	6a 10                	push   $0x10
  801411:	e8 68 fe ff ff       	call   80127e <syscall>
  801416:	83 c4 18             	add    $0x18,%esp
}
  801419:	c9                   	leave  
  80141a:	c3                   	ret    

0080141b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 11                	push   $0x11
  80142a:	e8 4f fe ff ff       	call   80127e <syscall>
  80142f:	83 c4 18             	add    $0x18,%esp
}
  801432:	90                   	nop
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <sys_cputc>:

void
sys_cputc(const char c)
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
  801438:	83 ec 04             	sub    $0x4,%esp
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801441:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	50                   	push   %eax
  80144e:	6a 01                	push   $0x1
  801450:	e8 29 fe ff ff       	call   80127e <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	90                   	nop
  801459:	c9                   	leave  
  80145a:	c3                   	ret    

0080145b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 14                	push   $0x14
  80146a:	e8 0f fe ff ff       	call   80127e <syscall>
  80146f:	83 c4 18             	add    $0x18,%esp
}
  801472:	90                   	nop
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
  801478:	83 ec 04             	sub    $0x4,%esp
  80147b:	8b 45 10             	mov    0x10(%ebp),%eax
  80147e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801481:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801484:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	6a 00                	push   $0x0
  80148d:	51                   	push   %ecx
  80148e:	52                   	push   %edx
  80148f:	ff 75 0c             	pushl  0xc(%ebp)
  801492:	50                   	push   %eax
  801493:	6a 15                	push   $0x15
  801495:	e8 e4 fd ff ff       	call   80127e <syscall>
  80149a:	83 c4 18             	add    $0x18,%esp
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8014a2:	8b 55 10             	mov    0x10(%ebp),%edx
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	52                   	push   %edx
  8014ad:	50                   	push   %eax
  8014ae:	ff 75 08             	pushl  0x8(%ebp)
  8014b1:	6a 16                	push   $0x16
  8014b3:	e8 c6 fd ff ff       	call   80127e <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	52                   	push   %edx
  8014cd:	50                   	push   %eax
  8014ce:	6a 17                	push   $0x17
  8014d0:	e8 a9 fd ff ff       	call   80127e <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8014dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	52                   	push   %edx
  8014ea:	50                   	push   %eax
  8014eb:	6a 18                	push   $0x18
  8014ed:	e8 8c fd ff ff       	call   80127e <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fd:	6a 00                	push   $0x0
  8014ff:	ff 75 14             	pushl  0x14(%ebp)
  801502:	ff 75 10             	pushl  0x10(%ebp)
  801505:	ff 75 0c             	pushl  0xc(%ebp)
  801508:	50                   	push   %eax
  801509:	6a 19                	push   $0x19
  80150b:	e8 6e fd ff ff       	call   80127e <syscall>
  801510:	83 c4 18             	add    $0x18,%esp
}
  801513:	c9                   	leave  
  801514:	c3                   	ret    

00801515 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801515:	55                   	push   %ebp
  801516:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	50                   	push   %eax
  801524:	6a 1a                	push   $0x1a
  801526:	e8 53 fd ff ff       	call   80127e <syscall>
  80152b:	83 c4 18             	add    $0x18,%esp
}
  80152e:	90                   	nop
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	50                   	push   %eax
  801540:	6a 1b                	push   $0x1b
  801542:	e8 37 fd ff ff       	call   80127e <syscall>
  801547:	83 c4 18             	add    $0x18,%esp
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 05                	push   $0x5
  80155b:	e8 1e fd ff ff       	call   80127e <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 06                	push   $0x6
  801574:	e8 05 fd ff ff       	call   80127e <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 07                	push   $0x7
  80158d:	e8 ec fc ff ff       	call   80127e <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <sys_exit_env>:


void sys_exit_env(void)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 1c                	push   $0x1c
  8015a6:	e8 d3 fc ff ff       	call   80127e <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
}
  8015ae:	90                   	nop
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	ff 75 10             	pushl  0x10(%ebp)
  8015bb:	ff 75 0c             	pushl  0xc(%ebp)
  8015be:	ff 75 08             	pushl  0x8(%ebp)
  8015c1:	6a 13                	push   $0x13
  8015c3:	e8 b6 fc ff ff       	call   80127e <syscall>
  8015c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8015cb:	90                   	nop
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <sys_rcr2>:
uint32 sys_rcr2()
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 1e                	push   $0x1e
  8015dd:	e8 9c fc ff ff       	call   80127e <syscall>
  8015e2:	83 c4 18             	add    $0x18,%esp
}
  8015e5:	c9                   	leave  
  8015e6:	c3                   	ret    

008015e7 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8015e7:	55                   	push   %ebp
  8015e8:	89 e5                	mov    %esp,%ebp
  8015ea:	83 ec 04             	sub    $0x4,%esp
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015f3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	50                   	push   %eax
  801600:	6a 1f                	push   $0x1f
  801602:	e8 77 fc ff ff       	call   80127e <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
	return ;
  80160a:	90                   	nop
}
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <rsttst>:
void rsttst()
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 21                	push   $0x21
  80161c:	e8 5d fc ff ff       	call   80127e <syscall>
  801621:	83 c4 18             	add    $0x18,%esp
	return ;
  801624:	90                   	nop
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
  80162a:	83 ec 04             	sub    $0x4,%esp
  80162d:	8b 45 14             	mov    0x14(%ebp),%eax
  801630:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801633:	8b 55 18             	mov    0x18(%ebp),%edx
  801636:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80163a:	52                   	push   %edx
  80163b:	50                   	push   %eax
  80163c:	ff 75 10             	pushl  0x10(%ebp)
  80163f:	ff 75 0c             	pushl  0xc(%ebp)
  801642:	ff 75 08             	pushl  0x8(%ebp)
  801645:	6a 20                	push   $0x20
  801647:	e8 32 fc ff ff       	call   80127e <syscall>
  80164c:	83 c4 18             	add    $0x18,%esp
	return ;
  80164f:	90                   	nop
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <chktst>:
void chktst(uint32 n)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	ff 75 08             	pushl  0x8(%ebp)
  801660:	6a 22                	push   $0x22
  801662:	e8 17 fc ff ff       	call   80127e <syscall>
  801667:	83 c4 18             	add    $0x18,%esp
	return ;
  80166a:	90                   	nop
}
  80166b:	c9                   	leave  
  80166c:	c3                   	ret    

0080166d <inctst>:

void inctst()
{
  80166d:	55                   	push   %ebp
  80166e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 23                	push   $0x23
  80167c:	e8 fd fb ff ff       	call   80127e <syscall>
  801681:	83 c4 18             	add    $0x18,%esp
	return ;
  801684:	90                   	nop
}
  801685:	c9                   	leave  
  801686:	c3                   	ret    

00801687 <gettst>:
uint32 gettst()
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 24                	push   $0x24
  801696:	e8 e3 fb ff ff       	call   80127e <syscall>
  80169b:	83 c4 18             	add    $0x18,%esp
}
  80169e:	c9                   	leave  
  80169f:	c3                   	ret    

008016a0 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 25                	push   $0x25
  8016af:	e8 ca fb ff ff       	call   80127e <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
  8016b7:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8016bc:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	ff 75 08             	pushl  0x8(%ebp)
  8016d9:	6a 26                	push   $0x26
  8016db:	e8 9e fb ff ff       	call   80127e <syscall>
  8016e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e3:	90                   	nop
}
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
  8016e9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016ea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	6a 00                	push   $0x0
  8016f8:	53                   	push   %ebx
  8016f9:	51                   	push   %ecx
  8016fa:	52                   	push   %edx
  8016fb:	50                   	push   %eax
  8016fc:	6a 27                	push   $0x27
  8016fe:	e8 7b fb ff ff       	call   80127e <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
}
  801706:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80170e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	52                   	push   %edx
  80171b:	50                   	push   %eax
  80171c:	6a 28                	push   $0x28
  80171e:	e8 5b fb ff ff       	call   80127e <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80172b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80172e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801731:	8b 45 08             	mov    0x8(%ebp),%eax
  801734:	6a 00                	push   $0x0
  801736:	51                   	push   %ecx
  801737:	ff 75 10             	pushl  0x10(%ebp)
  80173a:	52                   	push   %edx
  80173b:	50                   	push   %eax
  80173c:	6a 29                	push   $0x29
  80173e:	e8 3b fb ff ff       	call   80127e <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	ff 75 10             	pushl  0x10(%ebp)
  801752:	ff 75 0c             	pushl  0xc(%ebp)
  801755:	ff 75 08             	pushl  0x8(%ebp)
  801758:	6a 12                	push   $0x12
  80175a:	e8 1f fb ff ff       	call   80127e <syscall>
  80175f:	83 c4 18             	add    $0x18,%esp
	return ;
  801762:	90                   	nop
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801768:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	52                   	push   %edx
  801775:	50                   	push   %eax
  801776:	6a 2a                	push   $0x2a
  801778:	e8 01 fb ff ff       	call   80127e <syscall>
  80177d:	83 c4 18             	add    $0x18,%esp
	return;
  801780:	90                   	nop
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 2b                	push   $0x2b
  801792:	e8 e7 fa ff ff       	call   80127e <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
  80179f:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8017a2:	83 ec 04             	sub    $0x4,%esp
  8017a5:	68 48 22 80 00       	push   $0x802248
  8017aa:	68 0a 01 00 00       	push   $0x10a
  8017af:	68 58 22 80 00       	push   $0x802258
  8017b4:	e8 38 00 00 00       	call   8017f1 <_panic>

008017b9 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	6a 33                	push   $0x33
  8017ca:	e8 af fa ff ff       	call   80127e <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
	return;
  8017d2:	90                   	nop
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	ff 75 0c             	pushl  0xc(%ebp)
  8017e1:	ff 75 08             	pushl  0x8(%ebp)
  8017e4:	6a 34                	push   $0x34
  8017e6:	e8 93 fa ff ff       	call   80127e <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ee:	90                   	nop
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8017f7:	8d 45 10             	lea    0x10(%ebp),%eax
  8017fa:	83 c0 04             	add    $0x4,%eax
  8017fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801800:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801805:	85 c0                	test   %eax,%eax
  801807:	74 16                	je     80181f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801809:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80180e:	83 ec 08             	sub    $0x8,%esp
  801811:	50                   	push   %eax
  801812:	68 68 22 80 00       	push   $0x802268
  801817:	e8 7d eb ff ff       	call   800399 <cprintf>
  80181c:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  80181f:	a1 04 30 80 00       	mov    0x803004,%eax
  801824:	83 ec 0c             	sub    $0xc,%esp
  801827:	ff 75 0c             	pushl  0xc(%ebp)
  80182a:	ff 75 08             	pushl  0x8(%ebp)
  80182d:	50                   	push   %eax
  80182e:	68 70 22 80 00       	push   $0x802270
  801833:	6a 74                	push   $0x74
  801835:	e8 8c eb ff ff       	call   8003c6 <cprintf_colored>
  80183a:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80183d:	8b 45 10             	mov    0x10(%ebp),%eax
  801840:	83 ec 08             	sub    $0x8,%esp
  801843:	ff 75 f4             	pushl  -0xc(%ebp)
  801846:	50                   	push   %eax
  801847:	e8 de ea ff ff       	call   80032a <vcprintf>
  80184c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80184f:	83 ec 08             	sub    $0x8,%esp
  801852:	6a 00                	push   $0x0
  801854:	68 98 22 80 00       	push   $0x802298
  801859:	e8 cc ea ff ff       	call   80032a <vcprintf>
  80185e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801861:	e8 45 ea ff ff       	call   8002ab <exit>

	// should not return here
	while (1) ;
  801866:	eb fe                	jmp    801866 <_panic+0x75>

00801868 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801868:	55                   	push   %ebp
  801869:	89 e5                	mov    %esp,%ebp
  80186b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80186e:	a1 20 30 80 00       	mov    0x803020,%eax
  801873:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801879:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187c:	39 c2                	cmp    %eax,%edx
  80187e:	74 14                	je     801894 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801880:	83 ec 04             	sub    $0x4,%esp
  801883:	68 9c 22 80 00       	push   $0x80229c
  801888:	6a 26                	push   $0x26
  80188a:	68 e8 22 80 00       	push   $0x8022e8
  80188f:	e8 5d ff ff ff       	call   8017f1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801894:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80189b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018a2:	e9 c5 00 00 00       	jmp    80196c <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8018a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b4:	01 d0                	add    %edx,%eax
  8018b6:	8b 00                	mov    (%eax),%eax
  8018b8:	85 c0                	test   %eax,%eax
  8018ba:	75 08                	jne    8018c4 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8018bc:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018bf:	e9 a5 00 00 00       	jmp    801969 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8018c4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018cb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018d2:	eb 69                	jmp    80193d <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8018d9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018df:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018e2:	89 d0                	mov    %edx,%eax
  8018e4:	01 c0                	add    %eax,%eax
  8018e6:	01 d0                	add    %edx,%eax
  8018e8:	c1 e0 03             	shl    $0x3,%eax
  8018eb:	01 c8                	add    %ecx,%eax
  8018ed:	8a 40 04             	mov    0x4(%eax),%al
  8018f0:	84 c0                	test   %al,%al
  8018f2:	75 46                	jne    80193a <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8018f9:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8018ff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801902:	89 d0                	mov    %edx,%eax
  801904:	01 c0                	add    %eax,%eax
  801906:	01 d0                	add    %edx,%eax
  801908:	c1 e0 03             	shl    $0x3,%eax
  80190b:	01 c8                	add    %ecx,%eax
  80190d:	8b 00                	mov    (%eax),%eax
  80190f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801912:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801915:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80191a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80191c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	01 c8                	add    %ecx,%eax
  80192b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80192d:	39 c2                	cmp    %eax,%edx
  80192f:	75 09                	jne    80193a <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801931:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801938:	eb 15                	jmp    80194f <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80193a:	ff 45 e8             	incl   -0x18(%ebp)
  80193d:	a1 20 30 80 00       	mov    0x803020,%eax
  801942:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801948:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80194b:	39 c2                	cmp    %eax,%edx
  80194d:	77 85                	ja     8018d4 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80194f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801953:	75 14                	jne    801969 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801955:	83 ec 04             	sub    $0x4,%esp
  801958:	68 f4 22 80 00       	push   $0x8022f4
  80195d:	6a 3a                	push   $0x3a
  80195f:	68 e8 22 80 00       	push   $0x8022e8
  801964:	e8 88 fe ff ff       	call   8017f1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801969:	ff 45 f0             	incl   -0x10(%ebp)
  80196c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80196f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801972:	0f 8c 2f ff ff ff    	jl     8018a7 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801978:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80197f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801986:	eb 26                	jmp    8019ae <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801988:	a1 20 30 80 00       	mov    0x803020,%eax
  80198d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801993:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801996:	89 d0                	mov    %edx,%eax
  801998:	01 c0                	add    %eax,%eax
  80199a:	01 d0                	add    %edx,%eax
  80199c:	c1 e0 03             	shl    $0x3,%eax
  80199f:	01 c8                	add    %ecx,%eax
  8019a1:	8a 40 04             	mov    0x4(%eax),%al
  8019a4:	3c 01                	cmp    $0x1,%al
  8019a6:	75 03                	jne    8019ab <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8019a8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ab:	ff 45 e0             	incl   -0x20(%ebp)
  8019ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8019b3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019bc:	39 c2                	cmp    %eax,%edx
  8019be:	77 c8                	ja     801988 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019c6:	74 14                	je     8019dc <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8019c8:	83 ec 04             	sub    $0x4,%esp
  8019cb:	68 48 23 80 00       	push   $0x802348
  8019d0:	6a 44                	push   $0x44
  8019d2:	68 e8 22 80 00       	push   $0x8022e8
  8019d7:	e8 15 fe ff ff       	call   8017f1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019dc:	90                   	nop
  8019dd:	c9                   	leave  
  8019de:	c3                   	ret    
  8019df:	90                   	nop

008019e0 <__udivdi3>:
  8019e0:	55                   	push   %ebp
  8019e1:	57                   	push   %edi
  8019e2:	56                   	push   %esi
  8019e3:	53                   	push   %ebx
  8019e4:	83 ec 1c             	sub    $0x1c,%esp
  8019e7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019eb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019f3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019f7:	89 ca                	mov    %ecx,%edx
  8019f9:	89 f8                	mov    %edi,%eax
  8019fb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019ff:	85 f6                	test   %esi,%esi
  801a01:	75 2d                	jne    801a30 <__udivdi3+0x50>
  801a03:	39 cf                	cmp    %ecx,%edi
  801a05:	77 65                	ja     801a6c <__udivdi3+0x8c>
  801a07:	89 fd                	mov    %edi,%ebp
  801a09:	85 ff                	test   %edi,%edi
  801a0b:	75 0b                	jne    801a18 <__udivdi3+0x38>
  801a0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a12:	31 d2                	xor    %edx,%edx
  801a14:	f7 f7                	div    %edi
  801a16:	89 c5                	mov    %eax,%ebp
  801a18:	31 d2                	xor    %edx,%edx
  801a1a:	89 c8                	mov    %ecx,%eax
  801a1c:	f7 f5                	div    %ebp
  801a1e:	89 c1                	mov    %eax,%ecx
  801a20:	89 d8                	mov    %ebx,%eax
  801a22:	f7 f5                	div    %ebp
  801a24:	89 cf                	mov    %ecx,%edi
  801a26:	89 fa                	mov    %edi,%edx
  801a28:	83 c4 1c             	add    $0x1c,%esp
  801a2b:	5b                   	pop    %ebx
  801a2c:	5e                   	pop    %esi
  801a2d:	5f                   	pop    %edi
  801a2e:	5d                   	pop    %ebp
  801a2f:	c3                   	ret    
  801a30:	39 ce                	cmp    %ecx,%esi
  801a32:	77 28                	ja     801a5c <__udivdi3+0x7c>
  801a34:	0f bd fe             	bsr    %esi,%edi
  801a37:	83 f7 1f             	xor    $0x1f,%edi
  801a3a:	75 40                	jne    801a7c <__udivdi3+0x9c>
  801a3c:	39 ce                	cmp    %ecx,%esi
  801a3e:	72 0a                	jb     801a4a <__udivdi3+0x6a>
  801a40:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a44:	0f 87 9e 00 00 00    	ja     801ae8 <__udivdi3+0x108>
  801a4a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4f:	89 fa                	mov    %edi,%edx
  801a51:	83 c4 1c             	add    $0x1c,%esp
  801a54:	5b                   	pop    %ebx
  801a55:	5e                   	pop    %esi
  801a56:	5f                   	pop    %edi
  801a57:	5d                   	pop    %ebp
  801a58:	c3                   	ret    
  801a59:	8d 76 00             	lea    0x0(%esi),%esi
  801a5c:	31 ff                	xor    %edi,%edi
  801a5e:	31 c0                	xor    %eax,%eax
  801a60:	89 fa                	mov    %edi,%edx
  801a62:	83 c4 1c             	add    $0x1c,%esp
  801a65:	5b                   	pop    %ebx
  801a66:	5e                   	pop    %esi
  801a67:	5f                   	pop    %edi
  801a68:	5d                   	pop    %ebp
  801a69:	c3                   	ret    
  801a6a:	66 90                	xchg   %ax,%ax
  801a6c:	89 d8                	mov    %ebx,%eax
  801a6e:	f7 f7                	div    %edi
  801a70:	31 ff                	xor    %edi,%edi
  801a72:	89 fa                	mov    %edi,%edx
  801a74:	83 c4 1c             	add    $0x1c,%esp
  801a77:	5b                   	pop    %ebx
  801a78:	5e                   	pop    %esi
  801a79:	5f                   	pop    %edi
  801a7a:	5d                   	pop    %ebp
  801a7b:	c3                   	ret    
  801a7c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a81:	89 eb                	mov    %ebp,%ebx
  801a83:	29 fb                	sub    %edi,%ebx
  801a85:	89 f9                	mov    %edi,%ecx
  801a87:	d3 e6                	shl    %cl,%esi
  801a89:	89 c5                	mov    %eax,%ebp
  801a8b:	88 d9                	mov    %bl,%cl
  801a8d:	d3 ed                	shr    %cl,%ebp
  801a8f:	89 e9                	mov    %ebp,%ecx
  801a91:	09 f1                	or     %esi,%ecx
  801a93:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a97:	89 f9                	mov    %edi,%ecx
  801a99:	d3 e0                	shl    %cl,%eax
  801a9b:	89 c5                	mov    %eax,%ebp
  801a9d:	89 d6                	mov    %edx,%esi
  801a9f:	88 d9                	mov    %bl,%cl
  801aa1:	d3 ee                	shr    %cl,%esi
  801aa3:	89 f9                	mov    %edi,%ecx
  801aa5:	d3 e2                	shl    %cl,%edx
  801aa7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aab:	88 d9                	mov    %bl,%cl
  801aad:	d3 e8                	shr    %cl,%eax
  801aaf:	09 c2                	or     %eax,%edx
  801ab1:	89 d0                	mov    %edx,%eax
  801ab3:	89 f2                	mov    %esi,%edx
  801ab5:	f7 74 24 0c          	divl   0xc(%esp)
  801ab9:	89 d6                	mov    %edx,%esi
  801abb:	89 c3                	mov    %eax,%ebx
  801abd:	f7 e5                	mul    %ebp
  801abf:	39 d6                	cmp    %edx,%esi
  801ac1:	72 19                	jb     801adc <__udivdi3+0xfc>
  801ac3:	74 0b                	je     801ad0 <__udivdi3+0xf0>
  801ac5:	89 d8                	mov    %ebx,%eax
  801ac7:	31 ff                	xor    %edi,%edi
  801ac9:	e9 58 ff ff ff       	jmp    801a26 <__udivdi3+0x46>
  801ace:	66 90                	xchg   %ax,%ax
  801ad0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ad4:	89 f9                	mov    %edi,%ecx
  801ad6:	d3 e2                	shl    %cl,%edx
  801ad8:	39 c2                	cmp    %eax,%edx
  801ada:	73 e9                	jae    801ac5 <__udivdi3+0xe5>
  801adc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801adf:	31 ff                	xor    %edi,%edi
  801ae1:	e9 40 ff ff ff       	jmp    801a26 <__udivdi3+0x46>
  801ae6:	66 90                	xchg   %ax,%ax
  801ae8:	31 c0                	xor    %eax,%eax
  801aea:	e9 37 ff ff ff       	jmp    801a26 <__udivdi3+0x46>
  801aef:	90                   	nop

00801af0 <__umoddi3>:
  801af0:	55                   	push   %ebp
  801af1:	57                   	push   %edi
  801af2:	56                   	push   %esi
  801af3:	53                   	push   %ebx
  801af4:	83 ec 1c             	sub    $0x1c,%esp
  801af7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801afb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801aff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b03:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b07:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b0b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b0f:	89 f3                	mov    %esi,%ebx
  801b11:	89 fa                	mov    %edi,%edx
  801b13:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b17:	89 34 24             	mov    %esi,(%esp)
  801b1a:	85 c0                	test   %eax,%eax
  801b1c:	75 1a                	jne    801b38 <__umoddi3+0x48>
  801b1e:	39 f7                	cmp    %esi,%edi
  801b20:	0f 86 a2 00 00 00    	jbe    801bc8 <__umoddi3+0xd8>
  801b26:	89 c8                	mov    %ecx,%eax
  801b28:	89 f2                	mov    %esi,%edx
  801b2a:	f7 f7                	div    %edi
  801b2c:	89 d0                	mov    %edx,%eax
  801b2e:	31 d2                	xor    %edx,%edx
  801b30:	83 c4 1c             	add    $0x1c,%esp
  801b33:	5b                   	pop    %ebx
  801b34:	5e                   	pop    %esi
  801b35:	5f                   	pop    %edi
  801b36:	5d                   	pop    %ebp
  801b37:	c3                   	ret    
  801b38:	39 f0                	cmp    %esi,%eax
  801b3a:	0f 87 ac 00 00 00    	ja     801bec <__umoddi3+0xfc>
  801b40:	0f bd e8             	bsr    %eax,%ebp
  801b43:	83 f5 1f             	xor    $0x1f,%ebp
  801b46:	0f 84 ac 00 00 00    	je     801bf8 <__umoddi3+0x108>
  801b4c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b51:	29 ef                	sub    %ebp,%edi
  801b53:	89 fe                	mov    %edi,%esi
  801b55:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b59:	89 e9                	mov    %ebp,%ecx
  801b5b:	d3 e0                	shl    %cl,%eax
  801b5d:	89 d7                	mov    %edx,%edi
  801b5f:	89 f1                	mov    %esi,%ecx
  801b61:	d3 ef                	shr    %cl,%edi
  801b63:	09 c7                	or     %eax,%edi
  801b65:	89 e9                	mov    %ebp,%ecx
  801b67:	d3 e2                	shl    %cl,%edx
  801b69:	89 14 24             	mov    %edx,(%esp)
  801b6c:	89 d8                	mov    %ebx,%eax
  801b6e:	d3 e0                	shl    %cl,%eax
  801b70:	89 c2                	mov    %eax,%edx
  801b72:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b76:	d3 e0                	shl    %cl,%eax
  801b78:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b7c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b80:	89 f1                	mov    %esi,%ecx
  801b82:	d3 e8                	shr    %cl,%eax
  801b84:	09 d0                	or     %edx,%eax
  801b86:	d3 eb                	shr    %cl,%ebx
  801b88:	89 da                	mov    %ebx,%edx
  801b8a:	f7 f7                	div    %edi
  801b8c:	89 d3                	mov    %edx,%ebx
  801b8e:	f7 24 24             	mull   (%esp)
  801b91:	89 c6                	mov    %eax,%esi
  801b93:	89 d1                	mov    %edx,%ecx
  801b95:	39 d3                	cmp    %edx,%ebx
  801b97:	0f 82 87 00 00 00    	jb     801c24 <__umoddi3+0x134>
  801b9d:	0f 84 91 00 00 00    	je     801c34 <__umoddi3+0x144>
  801ba3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ba7:	29 f2                	sub    %esi,%edx
  801ba9:	19 cb                	sbb    %ecx,%ebx
  801bab:	89 d8                	mov    %ebx,%eax
  801bad:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bb1:	d3 e0                	shl    %cl,%eax
  801bb3:	89 e9                	mov    %ebp,%ecx
  801bb5:	d3 ea                	shr    %cl,%edx
  801bb7:	09 d0                	or     %edx,%eax
  801bb9:	89 e9                	mov    %ebp,%ecx
  801bbb:	d3 eb                	shr    %cl,%ebx
  801bbd:	89 da                	mov    %ebx,%edx
  801bbf:	83 c4 1c             	add    $0x1c,%esp
  801bc2:	5b                   	pop    %ebx
  801bc3:	5e                   	pop    %esi
  801bc4:	5f                   	pop    %edi
  801bc5:	5d                   	pop    %ebp
  801bc6:	c3                   	ret    
  801bc7:	90                   	nop
  801bc8:	89 fd                	mov    %edi,%ebp
  801bca:	85 ff                	test   %edi,%edi
  801bcc:	75 0b                	jne    801bd9 <__umoddi3+0xe9>
  801bce:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd3:	31 d2                	xor    %edx,%edx
  801bd5:	f7 f7                	div    %edi
  801bd7:	89 c5                	mov    %eax,%ebp
  801bd9:	89 f0                	mov    %esi,%eax
  801bdb:	31 d2                	xor    %edx,%edx
  801bdd:	f7 f5                	div    %ebp
  801bdf:	89 c8                	mov    %ecx,%eax
  801be1:	f7 f5                	div    %ebp
  801be3:	89 d0                	mov    %edx,%eax
  801be5:	e9 44 ff ff ff       	jmp    801b2e <__umoddi3+0x3e>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	89 c8                	mov    %ecx,%eax
  801bee:	89 f2                	mov    %esi,%edx
  801bf0:	83 c4 1c             	add    $0x1c,%esp
  801bf3:	5b                   	pop    %ebx
  801bf4:	5e                   	pop    %esi
  801bf5:	5f                   	pop    %edi
  801bf6:	5d                   	pop    %ebp
  801bf7:	c3                   	ret    
  801bf8:	3b 04 24             	cmp    (%esp),%eax
  801bfb:	72 06                	jb     801c03 <__umoddi3+0x113>
  801bfd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c01:	77 0f                	ja     801c12 <__umoddi3+0x122>
  801c03:	89 f2                	mov    %esi,%edx
  801c05:	29 f9                	sub    %edi,%ecx
  801c07:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c0b:	89 14 24             	mov    %edx,(%esp)
  801c0e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c12:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c16:	8b 14 24             	mov    (%esp),%edx
  801c19:	83 c4 1c             	add    $0x1c,%esp
  801c1c:	5b                   	pop    %ebx
  801c1d:	5e                   	pop    %esi
  801c1e:	5f                   	pop    %edi
  801c1f:	5d                   	pop    %ebp
  801c20:	c3                   	ret    
  801c21:	8d 76 00             	lea    0x0(%esi),%esi
  801c24:	2b 04 24             	sub    (%esp),%eax
  801c27:	19 fa                	sbb    %edi,%edx
  801c29:	89 d1                	mov    %edx,%ecx
  801c2b:	89 c6                	mov    %eax,%esi
  801c2d:	e9 71 ff ff ff       	jmp    801ba3 <__umoddi3+0xb3>
  801c32:	66 90                	xchg   %ax,%ax
  801c34:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c38:	72 ea                	jb     801c24 <__umoddi3+0x134>
  801c3a:	89 d9                	mov    %ebx,%ecx
  801c3c:	e9 62 ff ff ff       	jmp    801ba3 <__umoddi3+0xb3>
