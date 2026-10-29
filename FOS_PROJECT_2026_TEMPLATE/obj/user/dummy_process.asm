
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 97 00 00 00       	call   8000cd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 40             	sub    $0x40,%esp
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  80004c:	0f 31                	rdtsc  
  80004e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800051:	89 55 d8             	mov    %edx,-0x28(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  800054:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800057:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80005a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80005d:	89 55 e0             	mov    %edx,-0x20(%ebp)
	uint32 end1 = RAND(0, 5000);
  800060:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800063:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800068:	ba 00 00 00 00       	mov    $0x0,%edx
  80006d:	f7 f1                	div    %ecx
  80006f:	89 55 f0             	mov    %edx,-0x10(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  800072:	0f 31                	rdtsc  
  800074:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800077:	89 55 d0             	mov    %edx,-0x30(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  80007a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80007d:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800080:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800083:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  800086:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800089:	b9 88 13 00 00       	mov    $0x1388,%ecx
  80008e:	ba 00 00 00 00       	mov    $0x0,%edx
  800093:	f7 f1                	div    %ecx
  800095:	89 55 ec             	mov    %edx,-0x14(%ebp)
	int x = 10;
  800098:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%ebp)
	for(int i = 0; i <= end1; i++)
  80009f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8000a6:	eb 1a                	jmp    8000c2 <high_complexity_function+0x7c>
	{
		for(int i = 0; i <= end2; i++)
  8000a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000af:	eb 06                	jmp    8000b7 <high_complexity_function+0x71>
		{
			{
				 x++;
  8000b1:	ff 45 fc             	incl   -0x4(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000b4:	ff 45 f4             	incl   -0xc(%ebp)
  8000b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8000bd:	76 f2                	jbe    8000b1 <high_complexity_function+0x6b>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000bf:	ff 45 f8             	incl   -0x8(%ebp)
  8000c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8000c5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000c8:	76 de                	jbe    8000a8 <high_complexity_function+0x62>
			{
				 x++;
			}
		}
	}
}
  8000ca:	90                   	nop
  8000cb:	c9                   	leave  
  8000cc:	c3                   	ret    

008000cd <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000cd:	55                   	push   %ebp
  8000ce:	89 e5                	mov    %esp,%ebp
  8000d0:	57                   	push   %edi
  8000d1:	56                   	push   %esi
  8000d2:	53                   	push   %ebx
  8000d3:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000d9:	e8 fb 14 00 00       	call   8015d9 <sys_getenvindex>
  8000de:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000e4:	89 d0                	mov    %edx,%eax
  8000e6:	c1 e0 03             	shl    $0x3,%eax
  8000e9:	01 d0                	add    %edx,%eax
  8000eb:	c1 e0 06             	shl    $0x6,%eax
  8000ee:	01 d0                	add    %edx,%eax
  8000f0:	c1 e0 03             	shl    $0x3,%eax
  8000f3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800102:	8a 40 10             	mov    0x10(%eax),%al
  800105:	84 c0                	test   %al,%al
  800107:	74 0d                	je     800116 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	83 c0 10             	add    $0x10,%eax
  800111:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800116:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011a:	7e 0a                	jle    800126 <libmain+0x59>
		binaryname = argv[0];
  80011c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011f:	8b 00                	mov    (%eax),%eax
  800121:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800126:	83 ec 08             	sub    $0x8,%esp
  800129:	ff 75 0c             	pushl  0xc(%ebp)
  80012c:	ff 75 08             	pushl  0x8(%ebp)
  80012f:	e8 04 ff ff ff       	call   800038 <_main>
  800134:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800137:	a1 00 30 80 00       	mov    0x803000,%eax
  80013c:	85 c0                	test   %eax,%eax
  80013e:	0f 84 b7 01 00 00    	je     8002fb <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800144:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80014a:	bb fc 1d 80 00       	mov    $0x801dfc,%ebx
  80014f:	ba 0e 00 00 00       	mov    $0xe,%edx
  800154:	89 c7                	mov    %eax,%edi
  800156:	89 de                	mov    %ebx,%esi
  800158:	89 d1                	mov    %edx,%ecx
  80015a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80015c:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800162:	b9 56 00 00 00       	mov    $0x56,%ecx
  800167:	b0 00                	mov    $0x0,%al
  800169:	89 d7                	mov    %edx,%edi
  80016b:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80016d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800174:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	50                   	push   %eax
  80017b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800181:	50                   	push   %eax
  800182:	e8 52 16 00 00       	call   8017d9 <sys_utilities>
  800187:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80018a:	e8 d2 11 00 00       	call   801361 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80018f:	83 ec 0c             	sub    $0xc,%esp
  800192:	68 d8 1c 80 00       	push   $0x801cd8
  800197:	e8 71 02 00 00       	call   80040d <cprintf>
  80019c:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80019f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001a2:	85 c0                	test   %eax,%eax
  8001a4:	74 58                	je     8001fe <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8001a6:	e8 4c 16 00 00       	call   8017f7 <sys_get_optimal_num_faults>
  8001ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8001ae:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001b4:	bb 60 1e 80 00       	mov    $0x801e60,%ebx
  8001b9:	ba 11 00 00 00       	mov    $0x11,%edx
  8001be:	89 c7                	mov    %eax,%edi
  8001c0:	89 de                	mov    %ebx,%esi
  8001c2:	89 d1                	mov    %edx,%ecx
  8001c4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001c6:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001c9:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001ce:	b0 00                	mov    $0x0,%al
  8001d0:	89 d7                	mov    %edx,%edi
  8001d2:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001d4:	83 ec 08             	sub    $0x8,%esp
  8001d7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001da:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001e0:	50                   	push   %eax
  8001e1:	e8 f3 15 00 00       	call   8017d9 <sys_utilities>
  8001e6:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001e9:	83 ec 08             	sub    $0x8,%esp
  8001ec:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ef:	68 00 1d 80 00       	push   $0x801d00
  8001f4:	e8 14 02 00 00       	call   80040d <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
  8001fc:	eb 59                	jmp    800257 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800203:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800209:	a1 20 30 80 00       	mov    0x803020,%eax
  80020e:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	52                   	push   %edx
  800218:	50                   	push   %eax
  800219:	68 24 1d 80 00       	push   $0x801d24
  80021e:	e8 ea 01 00 00       	call   80040d <cprintf>
  800223:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800226:	a1 20 30 80 00       	mov    0x803020,%eax
  80022b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800231:	a1 20 30 80 00       	mov    0x803020,%eax
  800236:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80023c:	a1 20 30 80 00       	mov    0x803020,%eax
  800241:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800247:	51                   	push   %ecx
  800248:	52                   	push   %edx
  800249:	50                   	push   %eax
  80024a:	68 4c 1d 80 00       	push   $0x801d4c
  80024f:	e8 b9 01 00 00       	call   80040d <cprintf>
  800254:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800262:	83 ec 08             	sub    $0x8,%esp
  800265:	50                   	push   %eax
  800266:	68 a4 1d 80 00       	push   $0x801da4
  80026b:	e8 9d 01 00 00       	call   80040d <cprintf>
  800270:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800273:	83 ec 0c             	sub    $0xc,%esp
  800276:	68 b8 1d 80 00       	push   $0x801db8
  80027b:	e8 8d 01 00 00       	call   80040d <cprintf>
  800280:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800283:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80028a:	eb 28                	jmp    8002b4 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80028c:	a1 20 30 80 00       	mov    0x803020,%eax
  800291:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800294:	81 c2 74 04 00 00    	add    $0x474,%edx
  80029a:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	50                   	push   %eax
  8002a1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a4:	68 cf 1d 80 00       	push   $0x801dcf
  8002a9:	e8 5f 01 00 00       	call   80040d <cprintf>
  8002ae:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002b1:	ff 45 e4             	incl   -0x1c(%ebp)
  8002b4:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8002b8:	7e d2                	jle    80028c <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8002ba:	83 ec 0c             	sub    $0xc,%esp
  8002bd:	68 de 1d 80 00       	push   $0x801dde
  8002c2:	e8 46 01 00 00       	call   80040d <cprintf>
  8002c7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cf:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002d5:	83 ec 08             	sub    $0x8,%esp
  8002d8:	50                   	push   %eax
  8002d9:	68 e2 1d 80 00       	push   $0x801de2
  8002de:	e8 2a 01 00 00       	call   80040d <cprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002e6:	83 ec 0c             	sub    $0xc,%esp
  8002e9:	68 d8 1c 80 00       	push   $0x801cd8
  8002ee:	e8 1a 01 00 00       	call   80040d <cprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002f6:	e8 80 10 00 00       	call   80137b <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002fb:	e8 1f 00 00 00       	call   80031f <exit>
}
  800300:	90                   	nop
  800301:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800304:	5b                   	pop    %ebx
  800305:	5e                   	pop    %esi
  800306:	5f                   	pop    %edi
  800307:	5d                   	pop    %ebp
  800308:	c3                   	ret    

00800309 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800309:	55                   	push   %ebp
  80030a:	89 e5                	mov    %esp,%ebp
  80030c:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80030f:	83 ec 0c             	sub    $0xc,%esp
  800312:	6a 00                	push   $0x0
  800314:	e8 8c 12 00 00       	call   8015a5 <sys_destroy_env>
  800319:	83 c4 10             	add    $0x10,%esp
}
  80031c:	90                   	nop
  80031d:	c9                   	leave  
  80031e:	c3                   	ret    

0080031f <exit>:

void
exit(void)
{
  80031f:	55                   	push   %ebp
  800320:	89 e5                	mov    %esp,%ebp
  800322:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800325:	e8 e1 12 00 00       	call   80160b <sys_exit_env>
}
  80032a:	90                   	nop
  80032b:	c9                   	leave  
  80032c:	c3                   	ret    

0080032d <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80032d:	55                   	push   %ebp
  80032e:	89 e5                	mov    %esp,%ebp
  800330:	53                   	push   %ebx
  800331:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800334:	8b 45 0c             	mov    0xc(%ebp),%eax
  800337:	8b 00                	mov    (%eax),%eax
  800339:	8d 48 01             	lea    0x1(%eax),%ecx
  80033c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80033f:	89 0a                	mov    %ecx,(%edx)
  800341:	8b 55 08             	mov    0x8(%ebp),%edx
  800344:	88 d1                	mov    %dl,%cl
  800346:	8b 55 0c             	mov    0xc(%ebp),%edx
  800349:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80034d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800350:	8b 00                	mov    (%eax),%eax
  800352:	3d ff 00 00 00       	cmp    $0xff,%eax
  800357:	75 30                	jne    800389 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800359:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80035f:	a0 40 30 80 00       	mov    0x803040,%al
  800364:	0f b6 c0             	movzbl %al,%eax
  800367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80036a:	8b 09                	mov    (%ecx),%ecx
  80036c:	89 cb                	mov    %ecx,%ebx
  80036e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800371:	83 c1 08             	add    $0x8,%ecx
  800374:	52                   	push   %edx
  800375:	50                   	push   %eax
  800376:	53                   	push   %ebx
  800377:	51                   	push   %ecx
  800378:	e8 a0 0f 00 00       	call   80131d <sys_cputs>
  80037d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800380:	8b 45 0c             	mov    0xc(%ebp),%eax
  800383:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80038c:	8b 40 04             	mov    0x4(%eax),%eax
  80038f:	8d 50 01             	lea    0x1(%eax),%edx
  800392:	8b 45 0c             	mov    0xc(%ebp),%eax
  800395:	89 50 04             	mov    %edx,0x4(%eax)
}
  800398:	90                   	nop
  800399:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80039c:	c9                   	leave  
  80039d:	c3                   	ret    

0080039e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80039e:	55                   	push   %ebp
  80039f:	89 e5                	mov    %esp,%ebp
  8003a1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003a7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003ae:	00 00 00 
	b.cnt = 0;
  8003b1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003b8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003bb:	ff 75 0c             	pushl  0xc(%ebp)
  8003be:	ff 75 08             	pushl  0x8(%ebp)
  8003c1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c7:	50                   	push   %eax
  8003c8:	68 2d 03 80 00       	push   $0x80032d
  8003cd:	e8 5a 02 00 00       	call   80062c <vprintfmt>
  8003d2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8003d5:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003db:	a0 40 30 80 00       	mov    0x803040,%al
  8003e0:	0f b6 c0             	movzbl %al,%eax
  8003e3:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8003e9:	52                   	push   %edx
  8003ea:	50                   	push   %eax
  8003eb:	51                   	push   %ecx
  8003ec:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003f2:	83 c0 08             	add    $0x8,%eax
  8003f5:	50                   	push   %eax
  8003f6:	e8 22 0f 00 00       	call   80131d <sys_cputs>
  8003fb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003fe:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800405:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80040b:	c9                   	leave  
  80040c:	c3                   	ret    

0080040d <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80040d:	55                   	push   %ebp
  80040e:	89 e5                	mov    %esp,%ebp
  800410:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800413:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80041a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80041d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	83 ec 08             	sub    $0x8,%esp
  800426:	ff 75 f4             	pushl  -0xc(%ebp)
  800429:	50                   	push   %eax
  80042a:	e8 6f ff ff ff       	call   80039e <vcprintf>
  80042f:	83 c4 10             	add    $0x10,%esp
  800432:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800435:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800438:	c9                   	leave  
  800439:	c3                   	ret    

0080043a <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  80043a:	55                   	push   %ebp
  80043b:	89 e5                	mov    %esp,%ebp
  80043d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800440:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	c1 e0 08             	shl    $0x8,%eax
  80044d:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  800452:	8d 45 0c             	lea    0xc(%ebp),%eax
  800455:	83 c0 04             	add    $0x4,%eax
  800458:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80045b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045e:	83 ec 08             	sub    $0x8,%esp
  800461:	ff 75 f4             	pushl  -0xc(%ebp)
  800464:	50                   	push   %eax
  800465:	e8 34 ff ff ff       	call   80039e <vcprintf>
  80046a:	83 c4 10             	add    $0x10,%esp
  80046d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800470:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800477:	07 00 00 

	return cnt;
  80047a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80047d:	c9                   	leave  
  80047e:	c3                   	ret    

0080047f <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80047f:	55                   	push   %ebp
  800480:	89 e5                	mov    %esp,%ebp
  800482:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800485:	e8 d7 0e 00 00       	call   801361 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80048a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80048d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800490:	8b 45 08             	mov    0x8(%ebp),%eax
  800493:	83 ec 08             	sub    $0x8,%esp
  800496:	ff 75 f4             	pushl  -0xc(%ebp)
  800499:	50                   	push   %eax
  80049a:	e8 ff fe ff ff       	call   80039e <vcprintf>
  80049f:	83 c4 10             	add    $0x10,%esp
  8004a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8004a5:	e8 d1 0e 00 00       	call   80137b <sys_unlock_cons>
	return cnt;
  8004aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004ad:	c9                   	leave  
  8004ae:	c3                   	ret    

008004af <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004af:	55                   	push   %ebp
  8004b0:	89 e5                	mov    %esp,%ebp
  8004b2:	53                   	push   %ebx
  8004b3:	83 ec 14             	sub    $0x14,%esp
  8004b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004c2:	8b 45 18             	mov    0x18(%ebp),%eax
  8004c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8004ca:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004cd:	77 55                	ja     800524 <printnum+0x75>
  8004cf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004d2:	72 05                	jb     8004d9 <printnum+0x2a>
  8004d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004d7:	77 4b                	ja     800524 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004d9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004dc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004df:	8b 45 18             	mov    0x18(%ebp),%eax
  8004e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e7:	52                   	push   %edx
  8004e8:	50                   	push   %eax
  8004e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ec:	ff 75 f0             	pushl  -0x10(%ebp)
  8004ef:	e8 60 15 00 00       	call   801a54 <__udivdi3>
  8004f4:	83 c4 10             	add    $0x10,%esp
  8004f7:	83 ec 04             	sub    $0x4,%esp
  8004fa:	ff 75 20             	pushl  0x20(%ebp)
  8004fd:	53                   	push   %ebx
  8004fe:	ff 75 18             	pushl  0x18(%ebp)
  800501:	52                   	push   %edx
  800502:	50                   	push   %eax
  800503:	ff 75 0c             	pushl  0xc(%ebp)
  800506:	ff 75 08             	pushl  0x8(%ebp)
  800509:	e8 a1 ff ff ff       	call   8004af <printnum>
  80050e:	83 c4 20             	add    $0x20,%esp
  800511:	eb 1a                	jmp    80052d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800513:	83 ec 08             	sub    $0x8,%esp
  800516:	ff 75 0c             	pushl  0xc(%ebp)
  800519:	ff 75 20             	pushl  0x20(%ebp)
  80051c:	8b 45 08             	mov    0x8(%ebp),%eax
  80051f:	ff d0                	call   *%eax
  800521:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800524:	ff 4d 1c             	decl   0x1c(%ebp)
  800527:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80052b:	7f e6                	jg     800513 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80052d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800530:	bb 00 00 00 00       	mov    $0x0,%ebx
  800535:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800538:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80053b:	53                   	push   %ebx
  80053c:	51                   	push   %ecx
  80053d:	52                   	push   %edx
  80053e:	50                   	push   %eax
  80053f:	e8 20 16 00 00       	call   801b64 <__umoddi3>
  800544:	83 c4 10             	add    $0x10,%esp
  800547:	05 f4 20 80 00       	add    $0x8020f4,%eax
  80054c:	8a 00                	mov    (%eax),%al
  80054e:	0f be c0             	movsbl %al,%eax
  800551:	83 ec 08             	sub    $0x8,%esp
  800554:	ff 75 0c             	pushl  0xc(%ebp)
  800557:	50                   	push   %eax
  800558:	8b 45 08             	mov    0x8(%ebp),%eax
  80055b:	ff d0                	call   *%eax
  80055d:	83 c4 10             	add    $0x10,%esp
}
  800560:	90                   	nop
  800561:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800564:	c9                   	leave  
  800565:	c3                   	ret    

00800566 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800566:	55                   	push   %ebp
  800567:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800569:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80056d:	7e 1c                	jle    80058b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80056f:	8b 45 08             	mov    0x8(%ebp),%eax
  800572:	8b 00                	mov    (%eax),%eax
  800574:	8d 50 08             	lea    0x8(%eax),%edx
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	89 10                	mov    %edx,(%eax)
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	8b 00                	mov    (%eax),%eax
  800581:	83 e8 08             	sub    $0x8,%eax
  800584:	8b 50 04             	mov    0x4(%eax),%edx
  800587:	8b 00                	mov    (%eax),%eax
  800589:	eb 40                	jmp    8005cb <getuint+0x65>
	else if (lflag)
  80058b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80058f:	74 1e                	je     8005af <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	8b 00                	mov    (%eax),%eax
  800596:	8d 50 04             	lea    0x4(%eax),%edx
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	89 10                	mov    %edx,(%eax)
  80059e:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	83 e8 04             	sub    $0x4,%eax
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ad:	eb 1c                	jmp    8005cb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	8b 00                	mov    (%eax),%eax
  8005b4:	8d 50 04             	lea    0x4(%eax),%edx
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	89 10                	mov    %edx,(%eax)
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	8b 00                	mov    (%eax),%eax
  8005c1:	83 e8 04             	sub    $0x4,%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005cb:	5d                   	pop    %ebp
  8005cc:	c3                   	ret    

008005cd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005cd:	55                   	push   %ebp
  8005ce:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005d0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d4:	7e 1c                	jle    8005f2 <getint+0x25>
		return va_arg(*ap, long long);
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	8b 00                	mov    (%eax),%eax
  8005db:	8d 50 08             	lea    0x8(%eax),%edx
  8005de:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e1:	89 10                	mov    %edx,(%eax)
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	83 e8 08             	sub    $0x8,%eax
  8005eb:	8b 50 04             	mov    0x4(%eax),%edx
  8005ee:	8b 00                	mov    (%eax),%eax
  8005f0:	eb 38                	jmp    80062a <getint+0x5d>
	else if (lflag)
  8005f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005f6:	74 1a                	je     800612 <getint+0x45>
		return va_arg(*ap, long);
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	8b 00                	mov    (%eax),%eax
  8005fd:	8d 50 04             	lea    0x4(%eax),%edx
  800600:	8b 45 08             	mov    0x8(%ebp),%eax
  800603:	89 10                	mov    %edx,(%eax)
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	8b 00                	mov    (%eax),%eax
  80060a:	83 e8 04             	sub    $0x4,%eax
  80060d:	8b 00                	mov    (%eax),%eax
  80060f:	99                   	cltd   
  800610:	eb 18                	jmp    80062a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	8d 50 04             	lea    0x4(%eax),%edx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	89 10                	mov    %edx,(%eax)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	83 e8 04             	sub    $0x4,%eax
  800627:	8b 00                	mov    (%eax),%eax
  800629:	99                   	cltd   
}
  80062a:	5d                   	pop    %ebp
  80062b:	c3                   	ret    

0080062c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80062c:	55                   	push   %ebp
  80062d:	89 e5                	mov    %esp,%ebp
  80062f:	56                   	push   %esi
  800630:	53                   	push   %ebx
  800631:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800634:	eb 17                	jmp    80064d <vprintfmt+0x21>
			if (ch == '\0')
  800636:	85 db                	test   %ebx,%ebx
  800638:	0f 84 c1 03 00 00    	je     8009ff <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80063e:	83 ec 08             	sub    $0x8,%esp
  800641:	ff 75 0c             	pushl  0xc(%ebp)
  800644:	53                   	push   %ebx
  800645:	8b 45 08             	mov    0x8(%ebp),%eax
  800648:	ff d0                	call   *%eax
  80064a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064d:	8b 45 10             	mov    0x10(%ebp),%eax
  800650:	8d 50 01             	lea    0x1(%eax),%edx
  800653:	89 55 10             	mov    %edx,0x10(%ebp)
  800656:	8a 00                	mov    (%eax),%al
  800658:	0f b6 d8             	movzbl %al,%ebx
  80065b:	83 fb 25             	cmp    $0x25,%ebx
  80065e:	75 d6                	jne    800636 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800660:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800664:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80066b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800672:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800679:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800680:	8b 45 10             	mov    0x10(%ebp),%eax
  800683:	8d 50 01             	lea    0x1(%eax),%edx
  800686:	89 55 10             	mov    %edx,0x10(%ebp)
  800689:	8a 00                	mov    (%eax),%al
  80068b:	0f b6 d8             	movzbl %al,%ebx
  80068e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800691:	83 f8 5b             	cmp    $0x5b,%eax
  800694:	0f 87 3d 03 00 00    	ja     8009d7 <vprintfmt+0x3ab>
  80069a:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  8006a1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006a3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006a7:	eb d7                	jmp    800680 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006a9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006ad:	eb d1                	jmp    800680 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006b9:	89 d0                	mov    %edx,%eax
  8006bb:	c1 e0 02             	shl    $0x2,%eax
  8006be:	01 d0                	add    %edx,%eax
  8006c0:	01 c0                	add    %eax,%eax
  8006c2:	01 d8                	add    %ebx,%eax
  8006c4:	83 e8 30             	sub    $0x30,%eax
  8006c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8006cd:	8a 00                	mov    (%eax),%al
  8006cf:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006d2:	83 fb 2f             	cmp    $0x2f,%ebx
  8006d5:	7e 3e                	jle    800715 <vprintfmt+0xe9>
  8006d7:	83 fb 39             	cmp    $0x39,%ebx
  8006da:	7f 39                	jg     800715 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006dc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006df:	eb d5                	jmp    8006b6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e4:	83 c0 04             	add    $0x4,%eax
  8006e7:	89 45 14             	mov    %eax,0x14(%ebp)
  8006ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ed:	83 e8 04             	sub    $0x4,%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006f5:	eb 1f                	jmp    800716 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006f7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fb:	79 83                	jns    800680 <vprintfmt+0x54>
				width = 0;
  8006fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800704:	e9 77 ff ff ff       	jmp    800680 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800709:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800710:	e9 6b ff ff ff       	jmp    800680 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800715:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800716:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80071a:	0f 89 60 ff ff ff    	jns    800680 <vprintfmt+0x54>
				width = precision, precision = -1;
  800720:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800723:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800726:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80072d:	e9 4e ff ff ff       	jmp    800680 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800732:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800735:	e9 46 ff ff ff       	jmp    800680 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80073a:	8b 45 14             	mov    0x14(%ebp),%eax
  80073d:	83 c0 04             	add    $0x4,%eax
  800740:	89 45 14             	mov    %eax,0x14(%ebp)
  800743:	8b 45 14             	mov    0x14(%ebp),%eax
  800746:	83 e8 04             	sub    $0x4,%eax
  800749:	8b 00                	mov    (%eax),%eax
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 0c             	pushl  0xc(%ebp)
  800751:	50                   	push   %eax
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	ff d0                	call   *%eax
  800757:	83 c4 10             	add    $0x10,%esp
			break;
  80075a:	e9 9b 02 00 00       	jmp    8009fa <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80075f:	8b 45 14             	mov    0x14(%ebp),%eax
  800762:	83 c0 04             	add    $0x4,%eax
  800765:	89 45 14             	mov    %eax,0x14(%ebp)
  800768:	8b 45 14             	mov    0x14(%ebp),%eax
  80076b:	83 e8 04             	sub    $0x4,%eax
  80076e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800770:	85 db                	test   %ebx,%ebx
  800772:	79 02                	jns    800776 <vprintfmt+0x14a>
				err = -err;
  800774:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800776:	83 fb 64             	cmp    $0x64,%ebx
  800779:	7f 0b                	jg     800786 <vprintfmt+0x15a>
  80077b:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  800782:	85 f6                	test   %esi,%esi
  800784:	75 19                	jne    80079f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800786:	53                   	push   %ebx
  800787:	68 05 21 80 00       	push   $0x802105
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	ff 75 08             	pushl  0x8(%ebp)
  800792:	e8 70 02 00 00       	call   800a07 <printfmt>
  800797:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80079a:	e9 5b 02 00 00       	jmp    8009fa <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80079f:	56                   	push   %esi
  8007a0:	68 0e 21 80 00       	push   $0x80210e
  8007a5:	ff 75 0c             	pushl  0xc(%ebp)
  8007a8:	ff 75 08             	pushl  0x8(%ebp)
  8007ab:	e8 57 02 00 00       	call   800a07 <printfmt>
  8007b0:	83 c4 10             	add    $0x10,%esp
			break;
  8007b3:	e9 42 02 00 00       	jmp    8009fa <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bb:	83 c0 04             	add    $0x4,%eax
  8007be:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c4:	83 e8 04             	sub    $0x4,%eax
  8007c7:	8b 30                	mov    (%eax),%esi
  8007c9:	85 f6                	test   %esi,%esi
  8007cb:	75 05                	jne    8007d2 <vprintfmt+0x1a6>
				p = "(null)";
  8007cd:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  8007d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d6:	7e 6d                	jle    800845 <vprintfmt+0x219>
  8007d8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007dc:	74 67                	je     800845 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007de:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e1:	83 ec 08             	sub    $0x8,%esp
  8007e4:	50                   	push   %eax
  8007e5:	56                   	push   %esi
  8007e6:	e8 1e 03 00 00       	call   800b09 <strnlen>
  8007eb:	83 c4 10             	add    $0x10,%esp
  8007ee:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007f1:	eb 16                	jmp    800809 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007f3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	50                   	push   %eax
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	ff d0                	call   *%eax
  800803:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800806:	ff 4d e4             	decl   -0x1c(%ebp)
  800809:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80080d:	7f e4                	jg     8007f3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80080f:	eb 34                	jmp    800845 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800811:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800815:	74 1c                	je     800833 <vprintfmt+0x207>
  800817:	83 fb 1f             	cmp    $0x1f,%ebx
  80081a:	7e 05                	jle    800821 <vprintfmt+0x1f5>
  80081c:	83 fb 7e             	cmp    $0x7e,%ebx
  80081f:	7e 12                	jle    800833 <vprintfmt+0x207>
					putch('?', putdat);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	6a 3f                	push   $0x3f
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	ff d0                	call   *%eax
  80082e:	83 c4 10             	add    $0x10,%esp
  800831:	eb 0f                	jmp    800842 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	53                   	push   %ebx
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800842:	ff 4d e4             	decl   -0x1c(%ebp)
  800845:	89 f0                	mov    %esi,%eax
  800847:	8d 70 01             	lea    0x1(%eax),%esi
  80084a:	8a 00                	mov    (%eax),%al
  80084c:	0f be d8             	movsbl %al,%ebx
  80084f:	85 db                	test   %ebx,%ebx
  800851:	74 24                	je     800877 <vprintfmt+0x24b>
  800853:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800857:	78 b8                	js     800811 <vprintfmt+0x1e5>
  800859:	ff 4d e0             	decl   -0x20(%ebp)
  80085c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800860:	79 af                	jns    800811 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800862:	eb 13                	jmp    800877 <vprintfmt+0x24b>
				putch(' ', putdat);
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	ff 75 0c             	pushl  0xc(%ebp)
  80086a:	6a 20                	push   $0x20
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	ff d0                	call   *%eax
  800871:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800874:	ff 4d e4             	decl   -0x1c(%ebp)
  800877:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80087b:	7f e7                	jg     800864 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80087d:	e9 78 01 00 00       	jmp    8009fa <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800882:	83 ec 08             	sub    $0x8,%esp
  800885:	ff 75 e8             	pushl  -0x18(%ebp)
  800888:	8d 45 14             	lea    0x14(%ebp),%eax
  80088b:	50                   	push   %eax
  80088c:	e8 3c fd ff ff       	call   8005cd <getint>
  800891:	83 c4 10             	add    $0x10,%esp
  800894:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800897:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80089a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80089d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008a0:	85 d2                	test   %edx,%edx
  8008a2:	79 23                	jns    8008c7 <vprintfmt+0x29b>
				putch('-', putdat);
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	6a 2d                	push   $0x2d
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	ff d0                	call   *%eax
  8008b1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ba:	f7 d8                	neg    %eax
  8008bc:	83 d2 00             	adc    $0x0,%edx
  8008bf:	f7 da                	neg    %edx
  8008c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008c7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008ce:	e9 bc 00 00 00       	jmp    80098f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008d3:	83 ec 08             	sub    $0x8,%esp
  8008d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8008d9:	8d 45 14             	lea    0x14(%ebp),%eax
  8008dc:	50                   	push   %eax
  8008dd:	e8 84 fc ff ff       	call   800566 <getuint>
  8008e2:	83 c4 10             	add    $0x10,%esp
  8008e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008eb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008f2:	e9 98 00 00 00       	jmp    80098f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	6a 58                	push   $0x58
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	ff d0                	call   *%eax
  800904:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800907:	83 ec 08             	sub    $0x8,%esp
  80090a:	ff 75 0c             	pushl  0xc(%ebp)
  80090d:	6a 58                	push   $0x58
  80090f:	8b 45 08             	mov    0x8(%ebp),%eax
  800912:	ff d0                	call   *%eax
  800914:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800917:	83 ec 08             	sub    $0x8,%esp
  80091a:	ff 75 0c             	pushl  0xc(%ebp)
  80091d:	6a 58                	push   $0x58
  80091f:	8b 45 08             	mov    0x8(%ebp),%eax
  800922:	ff d0                	call   *%eax
  800924:	83 c4 10             	add    $0x10,%esp
			break;
  800927:	e9 ce 00 00 00       	jmp    8009fa <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  80092c:	83 ec 08             	sub    $0x8,%esp
  80092f:	ff 75 0c             	pushl  0xc(%ebp)
  800932:	6a 30                	push   $0x30
  800934:	8b 45 08             	mov    0x8(%ebp),%eax
  800937:	ff d0                	call   *%eax
  800939:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80093c:	83 ec 08             	sub    $0x8,%esp
  80093f:	ff 75 0c             	pushl  0xc(%ebp)
  800942:	6a 78                	push   $0x78
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	ff d0                	call   *%eax
  800949:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80094c:	8b 45 14             	mov    0x14(%ebp),%eax
  80094f:	83 c0 04             	add    $0x4,%eax
  800952:	89 45 14             	mov    %eax,0x14(%ebp)
  800955:	8b 45 14             	mov    0x14(%ebp),%eax
  800958:	83 e8 04             	sub    $0x4,%eax
  80095b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80095d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800960:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800967:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80096e:	eb 1f                	jmp    80098f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800970:	83 ec 08             	sub    $0x8,%esp
  800973:	ff 75 e8             	pushl  -0x18(%ebp)
  800976:	8d 45 14             	lea    0x14(%ebp),%eax
  800979:	50                   	push   %eax
  80097a:	e8 e7 fb ff ff       	call   800566 <getuint>
  80097f:	83 c4 10             	add    $0x10,%esp
  800982:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800985:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800988:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80098f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800993:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800996:	83 ec 04             	sub    $0x4,%esp
  800999:	52                   	push   %edx
  80099a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80099d:	50                   	push   %eax
  80099e:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a1:	ff 75 f0             	pushl  -0x10(%ebp)
  8009a4:	ff 75 0c             	pushl  0xc(%ebp)
  8009a7:	ff 75 08             	pushl  0x8(%ebp)
  8009aa:	e8 00 fb ff ff       	call   8004af <printnum>
  8009af:	83 c4 20             	add    $0x20,%esp
			break;
  8009b2:	eb 46                	jmp    8009fa <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ba:	53                   	push   %ebx
  8009bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009be:	ff d0                	call   *%eax
  8009c0:	83 c4 10             	add    $0x10,%esp
			break;
  8009c3:	eb 35                	jmp    8009fa <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8009c5:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  8009cc:	eb 2c                	jmp    8009fa <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  8009ce:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  8009d5:	eb 23                	jmp    8009fa <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	6a 25                	push   $0x25
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	ff d0                	call   *%eax
  8009e4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009e7:	ff 4d 10             	decl   0x10(%ebp)
  8009ea:	eb 03                	jmp    8009ef <vprintfmt+0x3c3>
  8009ec:	ff 4d 10             	decl   0x10(%ebp)
  8009ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f2:	48                   	dec    %eax
  8009f3:	8a 00                	mov    (%eax),%al
  8009f5:	3c 25                	cmp    $0x25,%al
  8009f7:	75 f3                	jne    8009ec <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  8009f9:	90                   	nop
		}
	}
  8009fa:	e9 35 fc ff ff       	jmp    800634 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009ff:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a00:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a03:	5b                   	pop    %ebx
  800a04:	5e                   	pop    %esi
  800a05:	5d                   	pop    %ebp
  800a06:	c3                   	ret    

00800a07 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
  800a0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a0d:	8d 45 10             	lea    0x10(%ebp),%eax
  800a10:	83 c0 04             	add    $0x4,%eax
  800a13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a16:	8b 45 10             	mov    0x10(%ebp),%eax
  800a19:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1c:	50                   	push   %eax
  800a1d:	ff 75 0c             	pushl  0xc(%ebp)
  800a20:	ff 75 08             	pushl  0x8(%ebp)
  800a23:	e8 04 fc ff ff       	call   80062c <vprintfmt>
  800a28:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a2b:	90                   	nop
  800a2c:	c9                   	leave  
  800a2d:	c3                   	ret    

00800a2e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a34:	8b 40 08             	mov    0x8(%eax),%eax
  800a37:	8d 50 01             	lea    0x1(%eax),%edx
  800a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	8b 10                	mov    (%eax),%edx
  800a45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a48:	8b 40 04             	mov    0x4(%eax),%eax
  800a4b:	39 c2                	cmp    %eax,%edx
  800a4d:	73 12                	jae    800a61 <sprintputch+0x33>
		*b->buf++ = ch;
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	8b 00                	mov    (%eax),%eax
  800a54:	8d 48 01             	lea    0x1(%eax),%ecx
  800a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5a:	89 0a                	mov    %ecx,(%edx)
  800a5c:	8b 55 08             	mov    0x8(%ebp),%edx
  800a5f:	88 10                	mov    %dl,(%eax)
}
  800a61:	90                   	nop
  800a62:	5d                   	pop    %ebp
  800a63:	c3                   	ret    

00800a64 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a64:	55                   	push   %ebp
  800a65:	89 e5                	mov    %esp,%ebp
  800a67:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	01 d0                	add    %edx,%eax
  800a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a85:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a89:	74 06                	je     800a91 <vsnprintf+0x2d>
  800a8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a8f:	7f 07                	jg     800a98 <vsnprintf+0x34>
		return -E_INVAL;
  800a91:	b8 03 00 00 00       	mov    $0x3,%eax
  800a96:	eb 20                	jmp    800ab8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a98:	ff 75 14             	pushl  0x14(%ebp)
  800a9b:	ff 75 10             	pushl  0x10(%ebp)
  800a9e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aa1:	50                   	push   %eax
  800aa2:	68 2e 0a 80 00       	push   $0x800a2e
  800aa7:	e8 80 fb ff ff       	call   80062c <vprintfmt>
  800aac:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ab8:	c9                   	leave  
  800ab9:	c3                   	ret    

00800aba <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800aba:	55                   	push   %ebp
  800abb:	89 e5                	mov    %esp,%ebp
  800abd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ac0:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac3:	83 c0 04             	add    $0x4,%eax
  800ac6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ac9:	8b 45 10             	mov    0x10(%ebp),%eax
  800acc:	ff 75 f4             	pushl  -0xc(%ebp)
  800acf:	50                   	push   %eax
  800ad0:	ff 75 0c             	pushl  0xc(%ebp)
  800ad3:	ff 75 08             	pushl  0x8(%ebp)
  800ad6:	e8 89 ff ff ff       	call   800a64 <vsnprintf>
  800adb:	83 c4 10             	add    $0x10,%esp
  800ade:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae4:	c9                   	leave  
  800ae5:	c3                   	ret    

00800ae6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ae6:	55                   	push   %ebp
  800ae7:	89 e5                	mov    %esp,%ebp
  800ae9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800aec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af3:	eb 06                	jmp    800afb <strlen+0x15>
		n++;
  800af5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800af8:	ff 45 08             	incl   0x8(%ebp)
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	84 c0                	test   %al,%al
  800b02:	75 f1                	jne    800af5 <strlen+0xf>
		n++;
	return n;
  800b04:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b07:	c9                   	leave  
  800b08:	c3                   	ret    

00800b09 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b09:	55                   	push   %ebp
  800b0a:	89 e5                	mov    %esp,%ebp
  800b0c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b16:	eb 09                	jmp    800b21 <strnlen+0x18>
		n++;
  800b18:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b1b:	ff 45 08             	incl   0x8(%ebp)
  800b1e:	ff 4d 0c             	decl   0xc(%ebp)
  800b21:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b25:	74 09                	je     800b30 <strnlen+0x27>
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8a 00                	mov    (%eax),%al
  800b2c:	84 c0                	test   %al,%al
  800b2e:	75 e8                	jne    800b18 <strnlen+0xf>
		n++;
	return n;
  800b30:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b33:	c9                   	leave  
  800b34:	c3                   	ret    

00800b35 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b35:	55                   	push   %ebp
  800b36:	89 e5                	mov    %esp,%ebp
  800b38:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b41:	90                   	nop
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	8d 50 01             	lea    0x1(%eax),%edx
  800b48:	89 55 08             	mov    %edx,0x8(%ebp)
  800b4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b51:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b54:	8a 12                	mov    (%edx),%dl
  800b56:	88 10                	mov    %dl,(%eax)
  800b58:	8a 00                	mov    (%eax),%al
  800b5a:	84 c0                	test   %al,%al
  800b5c:	75 e4                	jne    800b42 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b61:	c9                   	leave  
  800b62:	c3                   	ret    

00800b63 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b63:	55                   	push   %ebp
  800b64:	89 e5                	mov    %esp,%ebp
  800b66:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b76:	eb 1f                	jmp    800b97 <strncpy+0x34>
		*dst++ = *src;
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	8d 50 01             	lea    0x1(%eax),%edx
  800b7e:	89 55 08             	mov    %edx,0x8(%ebp)
  800b81:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b84:	8a 12                	mov    (%edx),%dl
  800b86:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	8a 00                	mov    (%eax),%al
  800b8d:	84 c0                	test   %al,%al
  800b8f:	74 03                	je     800b94 <strncpy+0x31>
			src++;
  800b91:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b94:	ff 45 fc             	incl   -0x4(%ebp)
  800b97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b9d:	72 d9                	jb     800b78 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bb0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb4:	74 30                	je     800be6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bb6:	eb 16                	jmp    800bce <strlcpy+0x2a>
			*dst++ = *src++;
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bca:	8a 12                	mov    (%edx),%dl
  800bcc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bce:	ff 4d 10             	decl   0x10(%ebp)
  800bd1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd5:	74 09                	je     800be0 <strlcpy+0x3c>
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	8a 00                	mov    (%eax),%al
  800bdc:	84 c0                	test   %al,%al
  800bde:	75 d8                	jne    800bb8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800be6:	8b 55 08             	mov    0x8(%ebp),%edx
  800be9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bec:	29 c2                	sub    %eax,%edx
  800bee:	89 d0                	mov    %edx,%eax
}
  800bf0:	c9                   	leave  
  800bf1:	c3                   	ret    

00800bf2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bf2:	55                   	push   %ebp
  800bf3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bf5:	eb 06                	jmp    800bfd <strcmp+0xb>
		p++, q++;
  800bf7:	ff 45 08             	incl   0x8(%ebp)
  800bfa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	8a 00                	mov    (%eax),%al
  800c02:	84 c0                	test   %al,%al
  800c04:	74 0e                	je     800c14 <strcmp+0x22>
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8a 10                	mov    (%eax),%dl
  800c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0e:	8a 00                	mov    (%eax),%al
  800c10:	38 c2                	cmp    %al,%dl
  800c12:	74 e3                	je     800bf7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	8a 00                	mov    (%eax),%al
  800c19:	0f b6 d0             	movzbl %al,%edx
  800c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	0f b6 c0             	movzbl %al,%eax
  800c24:	29 c2                	sub    %eax,%edx
  800c26:	89 d0                	mov    %edx,%eax
}
  800c28:	5d                   	pop    %ebp
  800c29:	c3                   	ret    

00800c2a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c2d:	eb 09                	jmp    800c38 <strncmp+0xe>
		n--, p++, q++;
  800c2f:	ff 4d 10             	decl   0x10(%ebp)
  800c32:	ff 45 08             	incl   0x8(%ebp)
  800c35:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c38:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3c:	74 17                	je     800c55 <strncmp+0x2b>
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	84 c0                	test   %al,%al
  800c45:	74 0e                	je     800c55 <strncmp+0x2b>
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	8a 10                	mov    (%eax),%dl
  800c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4f:	8a 00                	mov    (%eax),%al
  800c51:	38 c2                	cmp    %al,%dl
  800c53:	74 da                	je     800c2f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c59:	75 07                	jne    800c62 <strncmp+0x38>
		return 0;
  800c5b:	b8 00 00 00 00       	mov    $0x0,%eax
  800c60:	eb 14                	jmp    800c76 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
  800c65:	8a 00                	mov    (%eax),%al
  800c67:	0f b6 d0             	movzbl %al,%edx
  800c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	0f b6 c0             	movzbl %al,%eax
  800c72:	29 c2                	sub    %eax,%edx
  800c74:	89 d0                	mov    %edx,%eax
}
  800c76:	5d                   	pop    %ebp
  800c77:	c3                   	ret    

00800c78 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c78:	55                   	push   %ebp
  800c79:	89 e5                	mov    %esp,%ebp
  800c7b:	83 ec 04             	sub    $0x4,%esp
  800c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c81:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c84:	eb 12                	jmp    800c98 <strchr+0x20>
		if (*s == c)
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	8a 00                	mov    (%eax),%al
  800c8b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c8e:	75 05                	jne    800c95 <strchr+0x1d>
			return (char *) s;
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	eb 11                	jmp    800ca6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c95:	ff 45 08             	incl   0x8(%ebp)
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	84 c0                	test   %al,%al
  800c9f:	75 e5                	jne    800c86 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ca1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
  800cab:	83 ec 04             	sub    $0x4,%esp
  800cae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cb4:	eb 0d                	jmp    800cc3 <strfind+0x1b>
		if (*s == c)
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cbe:	74 0e                	je     800cce <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	84 c0                	test   %al,%al
  800cca:	75 ea                	jne    800cb6 <strfind+0xe>
  800ccc:	eb 01                	jmp    800ccf <strfind+0x27>
		if (*s == c)
			break;
  800cce:	90                   	nop
	return (char *) s;
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cd2:	c9                   	leave  
  800cd3:	c3                   	ret    

00800cd4 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800cd4:	55                   	push   %ebp
  800cd5:	89 e5                	mov    %esp,%ebp
  800cd7:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800ce0:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ce4:	76 63                	jbe    800d49 <memset+0x75>
		uint64 data_block = c;
  800ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce9:	99                   	cltd   
  800cea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ced:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800cf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cf3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf6:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800cfa:	c1 e0 08             	shl    $0x8,%eax
  800cfd:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d00:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800d03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d09:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d0d:	c1 e0 10             	shl    $0x10,%eax
  800d10:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d13:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d1c:	89 c2                	mov    %eax,%edx
  800d1e:	b8 00 00 00 00       	mov    $0x0,%eax
  800d23:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d26:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d29:	eb 18                	jmp    800d43 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d2b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d2e:	8d 41 08             	lea    0x8(%ecx),%eax
  800d31:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d37:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d3a:	89 01                	mov    %eax,(%ecx)
  800d3c:	89 51 04             	mov    %edx,0x4(%ecx)
  800d3f:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800d43:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d47:	77 e2                	ja     800d2b <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800d49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4d:	74 23                	je     800d72 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800d4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d52:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d55:	eb 0e                	jmp    800d65 <memset+0x91>
			*p8++ = (uint8)c;
  800d57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d5a:	8d 50 01             	lea    0x1(%eax),%edx
  800d5d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d63:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800d65:	8b 45 10             	mov    0x10(%ebp),%eax
  800d68:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6b:	89 55 10             	mov    %edx,0x10(%ebp)
  800d6e:	85 c0                	test   %eax,%eax
  800d70:	75 e5                	jne    800d57 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d75:	c9                   	leave  
  800d76:	c3                   	ret    

00800d77 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d77:	55                   	push   %ebp
  800d78:	89 e5                	mov    %esp,%ebp
  800d7a:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800d89:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d8d:	76 24                	jbe    800db3 <memcpy+0x3c>
		while(n >= 8){
  800d8f:	eb 1c                	jmp    800dad <memcpy+0x36>
			*d64 = *s64;
  800d91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d94:	8b 50 04             	mov    0x4(%eax),%edx
  800d97:	8b 00                	mov    (%eax),%eax
  800d99:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800d9c:	89 01                	mov    %eax,(%ecx)
  800d9e:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800da1:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800da5:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800da9:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800dad:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800db1:	77 de                	ja     800d91 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800db3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db7:	74 31                	je     800dea <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800db9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800dbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800dc5:	eb 16                	jmp    800ddd <memcpy+0x66>
			*d8++ = *s8++;
  800dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dca:	8d 50 01             	lea    0x1(%eax),%edx
  800dcd:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800dd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dd3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd6:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800dd9:	8a 12                	mov    (%edx),%dl
  800ddb:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800ddd:	8b 45 10             	mov    0x10(%ebp),%eax
  800de0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de3:	89 55 10             	mov    %edx,0x10(%ebp)
  800de6:	85 c0                	test   %eax,%eax
  800de8:	75 dd                	jne    800dc7 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ded:	c9                   	leave  
  800dee:	c3                   	ret    

00800def <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800def:	55                   	push   %ebp
  800df0:	89 e5                	mov    %esp,%ebp
  800df2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800df5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e04:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e07:	73 50                	jae    800e59 <memmove+0x6a>
  800e09:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0f:	01 d0                	add    %edx,%eax
  800e11:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e14:	76 43                	jbe    800e59 <memmove+0x6a>
		s += n;
  800e16:	8b 45 10             	mov    0x10(%ebp),%eax
  800e19:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e22:	eb 10                	jmp    800e34 <memmove+0x45>
			*--d = *--s;
  800e24:	ff 4d f8             	decl   -0x8(%ebp)
  800e27:	ff 4d fc             	decl   -0x4(%ebp)
  800e2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2d:	8a 10                	mov    (%eax),%dl
  800e2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e32:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e34:	8b 45 10             	mov    0x10(%ebp),%eax
  800e37:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3a:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3d:	85 c0                	test   %eax,%eax
  800e3f:	75 e3                	jne    800e24 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e41:	eb 23                	jmp    800e66 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e46:	8d 50 01             	lea    0x1(%eax),%edx
  800e49:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e52:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e55:	8a 12                	mov    (%edx),%dl
  800e57:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e59:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e62:	85 c0                	test   %eax,%eax
  800e64:	75 dd                	jne    800e43 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e69:	c9                   	leave  
  800e6a:	c3                   	ret    

00800e6b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e6b:	55                   	push   %ebp
  800e6c:	89 e5                	mov    %esp,%ebp
  800e6e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e7d:	eb 2a                	jmp    800ea9 <memcmp+0x3e>
		if (*s1 != *s2)
  800e7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e82:	8a 10                	mov    (%eax),%dl
  800e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	38 c2                	cmp    %al,%dl
  800e8b:	74 16                	je     800ea3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	0f b6 d0             	movzbl %al,%edx
  800e95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e98:	8a 00                	mov    (%eax),%al
  800e9a:	0f b6 c0             	movzbl %al,%eax
  800e9d:	29 c2                	sub    %eax,%edx
  800e9f:	89 d0                	mov    %edx,%eax
  800ea1:	eb 18                	jmp    800ebb <memcmp+0x50>
		s1++, s2++;
  800ea3:	ff 45 fc             	incl   -0x4(%ebp)
  800ea6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ea9:	8b 45 10             	mov    0x10(%ebp),%eax
  800eac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eaf:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb2:	85 c0                	test   %eax,%eax
  800eb4:	75 c9                	jne    800e7f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebb:	c9                   	leave  
  800ebc:	c3                   	ret    

00800ebd <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ebd:	55                   	push   %ebp
  800ebe:	89 e5                	mov    %esp,%ebp
  800ec0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ec3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec9:	01 d0                	add    %edx,%eax
  800ecb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ece:	eb 15                	jmp    800ee5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	0f b6 d0             	movzbl %al,%edx
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	0f b6 c0             	movzbl %al,%eax
  800ede:	39 c2                	cmp    %eax,%edx
  800ee0:	74 0d                	je     800eef <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ee2:	ff 45 08             	incl   0x8(%ebp)
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eeb:	72 e3                	jb     800ed0 <memfind+0x13>
  800eed:	eb 01                	jmp    800ef0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eef:	90                   	nop
	return (void *) s;
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef3:	c9                   	leave  
  800ef4:	c3                   	ret    

00800ef5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ef5:	55                   	push   %ebp
  800ef6:	89 e5                	mov    %esp,%ebp
  800ef8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800efb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f02:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f09:	eb 03                	jmp    800f0e <strtol+0x19>
		s++;
  800f0b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	3c 20                	cmp    $0x20,%al
  800f15:	74 f4                	je     800f0b <strtol+0x16>
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	3c 09                	cmp    $0x9,%al
  800f1e:	74 eb                	je     800f0b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	3c 2b                	cmp    $0x2b,%al
  800f27:	75 05                	jne    800f2e <strtol+0x39>
		s++;
  800f29:	ff 45 08             	incl   0x8(%ebp)
  800f2c:	eb 13                	jmp    800f41 <strtol+0x4c>
	else if (*s == '-')
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	3c 2d                	cmp    $0x2d,%al
  800f35:	75 0a                	jne    800f41 <strtol+0x4c>
		s++, neg = 1;
  800f37:	ff 45 08             	incl   0x8(%ebp)
  800f3a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f45:	74 06                	je     800f4d <strtol+0x58>
  800f47:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f4b:	75 20                	jne    800f6d <strtol+0x78>
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	3c 30                	cmp    $0x30,%al
  800f54:	75 17                	jne    800f6d <strtol+0x78>
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	40                   	inc    %eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	3c 78                	cmp    $0x78,%al
  800f5e:	75 0d                	jne    800f6d <strtol+0x78>
		s += 2, base = 16;
  800f60:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f64:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f6b:	eb 28                	jmp    800f95 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f71:	75 15                	jne    800f88 <strtol+0x93>
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	3c 30                	cmp    $0x30,%al
  800f7a:	75 0c                	jne    800f88 <strtol+0x93>
		s++, base = 8;
  800f7c:	ff 45 08             	incl   0x8(%ebp)
  800f7f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f86:	eb 0d                	jmp    800f95 <strtol+0xa0>
	else if (base == 0)
  800f88:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8c:	75 07                	jne    800f95 <strtol+0xa0>
		base = 10;
  800f8e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	3c 2f                	cmp    $0x2f,%al
  800f9c:	7e 19                	jle    800fb7 <strtol+0xc2>
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	3c 39                	cmp    $0x39,%al
  800fa5:	7f 10                	jg     800fb7 <strtol+0xc2>
			dig = *s - '0';
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	0f be c0             	movsbl %al,%eax
  800faf:	83 e8 30             	sub    $0x30,%eax
  800fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb5:	eb 42                	jmp    800ff9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 60                	cmp    $0x60,%al
  800fbe:	7e 19                	jle    800fd9 <strtol+0xe4>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 7a                	cmp    $0x7a,%al
  800fc7:	7f 10                	jg     800fd9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	0f be c0             	movsbl %al,%eax
  800fd1:	83 e8 57             	sub    $0x57,%eax
  800fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd7:	eb 20                	jmp    800ff9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	8a 00                	mov    (%eax),%al
  800fde:	3c 40                	cmp    $0x40,%al
  800fe0:	7e 39                	jle    80101b <strtol+0x126>
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	3c 5a                	cmp    $0x5a,%al
  800fe9:	7f 30                	jg     80101b <strtol+0x126>
			dig = *s - 'A' + 10;
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	0f be c0             	movsbl %al,%eax
  800ff3:	83 e8 37             	sub    $0x37,%eax
  800ff6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffc:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fff:	7d 19                	jge    80101a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801001:	ff 45 08             	incl   0x8(%ebp)
  801004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801007:	0f af 45 10          	imul   0x10(%ebp),%eax
  80100b:	89 c2                	mov    %eax,%edx
  80100d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801010:	01 d0                	add    %edx,%eax
  801012:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801015:	e9 7b ff ff ff       	jmp    800f95 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80101a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80101b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80101f:	74 08                	je     801029 <strtol+0x134>
		*endptr = (char *) s;
  801021:	8b 45 0c             	mov    0xc(%ebp),%eax
  801024:	8b 55 08             	mov    0x8(%ebp),%edx
  801027:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801029:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80102d:	74 07                	je     801036 <strtol+0x141>
  80102f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801032:	f7 d8                	neg    %eax
  801034:	eb 03                	jmp    801039 <strtol+0x144>
  801036:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801039:	c9                   	leave  
  80103a:	c3                   	ret    

0080103b <ltostr>:

void
ltostr(long value, char *str)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
  80103e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801041:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801048:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80104f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801053:	79 13                	jns    801068 <ltostr+0x2d>
	{
		neg = 1;
  801055:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80105c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801062:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801065:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801070:	99                   	cltd   
  801071:	f7 f9                	idiv   %ecx
  801073:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801076:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801079:	8d 50 01             	lea    0x1(%eax),%edx
  80107c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80107f:	89 c2                	mov    %eax,%edx
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	01 d0                	add    %edx,%eax
  801086:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801089:	83 c2 30             	add    $0x30,%edx
  80108c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80108e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801091:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801096:	f7 e9                	imul   %ecx
  801098:	c1 fa 02             	sar    $0x2,%edx
  80109b:	89 c8                	mov    %ecx,%eax
  80109d:	c1 f8 1f             	sar    $0x1f,%eax
  8010a0:	29 c2                	sub    %eax,%edx
  8010a2:	89 d0                	mov    %edx,%eax
  8010a4:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8010a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ab:	75 bb                	jne    801068 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b7:	48                   	dec    %eax
  8010b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010bf:	74 3d                	je     8010fe <ltostr+0xc3>
		start = 1 ;
  8010c1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c8:	eb 34                	jmp    8010fe <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8010ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d0:	01 d0                	add    %edx,%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dd:	01 c2                	add    %eax,%edx
  8010df:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e5:	01 c8                	add    %ecx,%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010eb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 c2                	add    %eax,%edx
  8010f3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f6:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010fb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801101:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801104:	7c c4                	jl     8010ca <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801106:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801109:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110c:	01 d0                	add    %edx,%eax
  80110e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801111:	90                   	nop
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
  801117:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80111a:	ff 75 08             	pushl  0x8(%ebp)
  80111d:	e8 c4 f9 ff ff       	call   800ae6 <strlen>
  801122:	83 c4 04             	add    $0x4,%esp
  801125:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801128:	ff 75 0c             	pushl  0xc(%ebp)
  80112b:	e8 b6 f9 ff ff       	call   800ae6 <strlen>
  801130:	83 c4 04             	add    $0x4,%esp
  801133:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801136:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80113d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801144:	eb 17                	jmp    80115d <strcconcat+0x49>
		final[s] = str1[s] ;
  801146:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801149:	8b 45 10             	mov    0x10(%ebp),%eax
  80114c:	01 c2                	add    %eax,%edx
  80114e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	01 c8                	add    %ecx,%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80115a:	ff 45 fc             	incl   -0x4(%ebp)
  80115d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801160:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801163:	7c e1                	jl     801146 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801165:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80116c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801173:	eb 1f                	jmp    801194 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801175:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801178:	8d 50 01             	lea    0x1(%eax),%edx
  80117b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80117e:	89 c2                	mov    %eax,%edx
  801180:	8b 45 10             	mov    0x10(%ebp),%eax
  801183:	01 c2                	add    %eax,%edx
  801185:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118b:	01 c8                	add    %ecx,%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801191:	ff 45 f8             	incl   -0x8(%ebp)
  801194:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801197:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80119a:	7c d9                	jl     801175 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80119c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	01 d0                	add    %edx,%eax
  8011a4:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a7:	90                   	nop
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b9:	8b 00                	mov    (%eax),%eax
  8011bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c5:	01 d0                	add    %edx,%eax
  8011c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011cd:	eb 0c                	jmp    8011db <strsplit+0x31>
			*string++ = 0;
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d2:	8d 50 01             	lea    0x1(%eax),%edx
  8011d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	84 c0                	test   %al,%al
  8011e2:	74 18                	je     8011fc <strsplit+0x52>
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	8a 00                	mov    (%eax),%al
  8011e9:	0f be c0             	movsbl %al,%eax
  8011ec:	50                   	push   %eax
  8011ed:	ff 75 0c             	pushl  0xc(%ebp)
  8011f0:	e8 83 fa ff ff       	call   800c78 <strchr>
  8011f5:	83 c4 08             	add    $0x8,%esp
  8011f8:	85 c0                	test   %eax,%eax
  8011fa:	75 d3                	jne    8011cf <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	74 5a                	je     80125f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801205:	8b 45 14             	mov    0x14(%ebp),%eax
  801208:	8b 00                	mov    (%eax),%eax
  80120a:	83 f8 0f             	cmp    $0xf,%eax
  80120d:	75 07                	jne    801216 <strsplit+0x6c>
		{
			return 0;
  80120f:	b8 00 00 00 00       	mov    $0x0,%eax
  801214:	eb 66                	jmp    80127c <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801216:	8b 45 14             	mov    0x14(%ebp),%eax
  801219:	8b 00                	mov    (%eax),%eax
  80121b:	8d 48 01             	lea    0x1(%eax),%ecx
  80121e:	8b 55 14             	mov    0x14(%ebp),%edx
  801221:	89 0a                	mov    %ecx,(%edx)
  801223:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122a:	8b 45 10             	mov    0x10(%ebp),%eax
  80122d:	01 c2                	add    %eax,%edx
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801234:	eb 03                	jmp    801239 <strsplit+0x8f>
			string++;
  801236:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801239:	8b 45 08             	mov    0x8(%ebp),%eax
  80123c:	8a 00                	mov    (%eax),%al
  80123e:	84 c0                	test   %al,%al
  801240:	74 8b                	je     8011cd <strsplit+0x23>
  801242:	8b 45 08             	mov    0x8(%ebp),%eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	0f be c0             	movsbl %al,%eax
  80124a:	50                   	push   %eax
  80124b:	ff 75 0c             	pushl  0xc(%ebp)
  80124e:	e8 25 fa ff ff       	call   800c78 <strchr>
  801253:	83 c4 08             	add    $0x8,%esp
  801256:	85 c0                	test   %eax,%eax
  801258:	74 dc                	je     801236 <strsplit+0x8c>
			string++;
	}
  80125a:	e9 6e ff ff ff       	jmp    8011cd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80125f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801260:	8b 45 14             	mov    0x14(%ebp),%eax
  801263:	8b 00                	mov    (%eax),%eax
  801265:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801277:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
  801281:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80128a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801291:	eb 4a                	jmp    8012dd <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801293:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	01 c2                	add    %eax,%edx
  80129b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	01 c8                	add    %ecx,%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8012a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	01 d0                	add    %edx,%eax
  8012af:	8a 00                	mov    (%eax),%al
  8012b1:	3c 40                	cmp    $0x40,%al
  8012b3:	7e 25                	jle    8012da <str2lower+0x5c>
  8012b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bb:	01 d0                	add    %edx,%eax
  8012bd:	8a 00                	mov    (%eax),%al
  8012bf:	3c 5a                	cmp    $0x5a,%al
  8012c1:	7f 17                	jg     8012da <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8012c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	01 d0                	add    %edx,%eax
  8012cb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8012d1:	01 ca                	add    %ecx,%edx
  8012d3:	8a 12                	mov    (%edx),%dl
  8012d5:	83 c2 20             	add    $0x20,%edx
  8012d8:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8012da:	ff 45 fc             	incl   -0x4(%ebp)
  8012dd:	ff 75 0c             	pushl  0xc(%ebp)
  8012e0:	e8 01 f8 ff ff       	call   800ae6 <strlen>
  8012e5:	83 c4 04             	add    $0x4,%esp
  8012e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012eb:	7f a6                	jg     801293 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8012ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f0:	c9                   	leave  
  8012f1:	c3                   	ret    

008012f2 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012f2:	55                   	push   %ebp
  8012f3:	89 e5                	mov    %esp,%ebp
  8012f5:	57                   	push   %edi
  8012f6:	56                   	push   %esi
  8012f7:	53                   	push   %ebx
  8012f8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801301:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801304:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801307:	8b 7d 18             	mov    0x18(%ebp),%edi
  80130a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80130d:	cd 30                	int    $0x30
  80130f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801315:	83 c4 10             	add    $0x10,%esp
  801318:	5b                   	pop    %ebx
  801319:	5e                   	pop    %esi
  80131a:	5f                   	pop    %edi
  80131b:	5d                   	pop    %ebp
  80131c:	c3                   	ret    

0080131d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
  801320:	83 ec 04             	sub    $0x4,%esp
  801323:	8b 45 10             	mov    0x10(%ebp),%eax
  801326:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801329:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80132c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	6a 00                	push   $0x0
  801335:	51                   	push   %ecx
  801336:	52                   	push   %edx
  801337:	ff 75 0c             	pushl  0xc(%ebp)
  80133a:	50                   	push   %eax
  80133b:	6a 00                	push   $0x0
  80133d:	e8 b0 ff ff ff       	call   8012f2 <syscall>
  801342:	83 c4 18             	add    $0x18,%esp
}
  801345:	90                   	nop
  801346:	c9                   	leave  
  801347:	c3                   	ret    

00801348 <sys_cgetc>:

int
sys_cgetc(void)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 02                	push   $0x2
  801357:	e8 96 ff ff ff       	call   8012f2 <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	c9                   	leave  
  801360:	c3                   	ret    

00801361 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801361:	55                   	push   %ebp
  801362:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	6a 03                	push   $0x3
  801370:	e8 7d ff ff ff       	call   8012f2 <syscall>
  801375:	83 c4 18             	add    $0x18,%esp
}
  801378:	90                   	nop
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 04                	push   $0x4
  80138a:	e8 63 ff ff ff       	call   8012f2 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	90                   	nop
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	52                   	push   %edx
  8013a5:	50                   	push   %eax
  8013a6:	6a 08                	push   $0x8
  8013a8:	e8 45 ff ff ff       	call   8012f2 <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
  8013b5:	56                   	push   %esi
  8013b6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013b7:	8b 75 18             	mov    0x18(%ebp),%esi
  8013ba:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	56                   	push   %esi
  8013c7:	53                   	push   %ebx
  8013c8:	51                   	push   %ecx
  8013c9:	52                   	push   %edx
  8013ca:	50                   	push   %eax
  8013cb:	6a 09                	push   $0x9
  8013cd:	e8 20 ff ff ff       	call   8012f2 <syscall>
  8013d2:	83 c4 18             	add    $0x18,%esp
}
  8013d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013d8:	5b                   	pop    %ebx
  8013d9:	5e                   	pop    %esi
  8013da:	5d                   	pop    %ebp
  8013db:	c3                   	ret    

008013dc <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	ff 75 08             	pushl  0x8(%ebp)
  8013ea:	6a 0a                	push   $0xa
  8013ec:	e8 01 ff ff ff       	call   8012f2 <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	ff 75 0c             	pushl  0xc(%ebp)
  801402:	ff 75 08             	pushl  0x8(%ebp)
  801405:	6a 0b                	push   $0xb
  801407:	e8 e6 fe ff ff       	call   8012f2 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 0c                	push   $0xc
  801420:	e8 cd fe ff ff       	call   8012f2 <syscall>
  801425:	83 c4 18             	add    $0x18,%esp
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 0d                	push   $0xd
  801439:	e8 b4 fe ff ff       	call   8012f2 <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 0e                	push   $0xe
  801452:	e8 9b fe ff ff       	call   8012f2 <syscall>
  801457:	83 c4 18             	add    $0x18,%esp
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 0f                	push   $0xf
  80146b:	e8 82 fe ff ff       	call   8012f2 <syscall>
  801470:	83 c4 18             	add    $0x18,%esp
}
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	ff 75 08             	pushl  0x8(%ebp)
  801483:	6a 10                	push   $0x10
  801485:	e8 68 fe ff ff       	call   8012f2 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	c9                   	leave  
  80148e:	c3                   	ret    

0080148f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80148f:	55                   	push   %ebp
  801490:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 11                	push   $0x11
  80149e:	e8 4f fe ff ff       	call   8012f2 <syscall>
  8014a3:	83 c4 18             	add    $0x18,%esp
}
  8014a6:	90                   	nop
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <sys_cputc>:

void
sys_cputc(const char c)
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
  8014ac:	83 ec 04             	sub    $0x4,%esp
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014b5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	50                   	push   %eax
  8014c2:	6a 01                	push   $0x1
  8014c4:	e8 29 fe ff ff       	call   8012f2 <syscall>
  8014c9:	83 c4 18             	add    $0x18,%esp
}
  8014cc:	90                   	nop
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 14                	push   $0x14
  8014de:	e8 0f fe ff ff       	call   8012f2 <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
}
  8014e6:	90                   	nop
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 04             	sub    $0x4,%esp
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8014f5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014f8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	6a 00                	push   $0x0
  801501:	51                   	push   %ecx
  801502:	52                   	push   %edx
  801503:	ff 75 0c             	pushl  0xc(%ebp)
  801506:	50                   	push   %eax
  801507:	6a 15                	push   $0x15
  801509:	e8 e4 fd ff ff       	call   8012f2 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801516:	8b 55 10             	mov    0x10(%ebp),%edx
  801519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	52                   	push   %edx
  801521:	50                   	push   %eax
  801522:	ff 75 08             	pushl  0x8(%ebp)
  801525:	6a 16                	push   $0x16
  801527:	e8 c6 fd ff ff       	call   8012f2 <syscall>
  80152c:	83 c4 18             	add    $0x18,%esp
}
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801534:	8b 55 0c             	mov    0xc(%ebp),%edx
  801537:	8b 45 08             	mov    0x8(%ebp),%eax
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	52                   	push   %edx
  801541:	50                   	push   %eax
  801542:	6a 17                	push   $0x17
  801544:	e8 a9 fd ff ff       	call   8012f2 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801551:	8b 55 0c             	mov    0xc(%ebp),%edx
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	52                   	push   %edx
  80155e:	50                   	push   %eax
  80155f:	6a 18                	push   $0x18
  801561:	e8 8c fd ff ff       	call   8012f2 <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
}
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	6a 00                	push   $0x0
  801573:	ff 75 14             	pushl  0x14(%ebp)
  801576:	ff 75 10             	pushl  0x10(%ebp)
  801579:	ff 75 0c             	pushl  0xc(%ebp)
  80157c:	50                   	push   %eax
  80157d:	6a 19                	push   $0x19
  80157f:	e8 6e fd ff ff       	call   8012f2 <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	50                   	push   %eax
  801598:	6a 1a                	push   $0x1a
  80159a:	e8 53 fd ff ff       	call   8012f2 <syscall>
  80159f:	83 c4 18             	add    $0x18,%esp
}
  8015a2:	90                   	nop
  8015a3:	c9                   	leave  
  8015a4:	c3                   	ret    

008015a5 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	50                   	push   %eax
  8015b4:	6a 1b                	push   $0x1b
  8015b6:	e8 37 fd ff ff       	call   8012f2 <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 05                	push   $0x5
  8015cf:	e8 1e fd ff ff       	call   8012f2 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 06                	push   $0x6
  8015e8:	e8 05 fd ff ff       	call   8012f2 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 07                	push   $0x7
  801601:	e8 ec fc ff ff       	call   8012f2 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_exit_env>:


void sys_exit_env(void)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 1c                	push   $0x1c
  80161a:	e8 d3 fc ff ff       	call   8012f2 <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
}
  801622:	90                   	nop
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	ff 75 10             	pushl  0x10(%ebp)
  80162f:	ff 75 0c             	pushl  0xc(%ebp)
  801632:	ff 75 08             	pushl  0x8(%ebp)
  801635:	6a 13                	push   $0x13
  801637:	e8 b6 fc ff ff       	call   8012f2 <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
	return ;
  80163f:	90                   	nop
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_rcr2>:
uint32 sys_rcr2()
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 1e                	push   $0x1e
  801651:	e8 9c fc ff ff       	call   8012f2 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
  80165e:	83 ec 04             	sub    $0x4,%esp
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801667:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	50                   	push   %eax
  801674:	6a 1f                	push   $0x1f
  801676:	e8 77 fc ff ff       	call   8012f2 <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
	return ;
  80167e:	90                   	nop
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <rsttst>:
void rsttst()
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 21                	push   $0x21
  801690:	e8 5d fc ff ff       	call   8012f2 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
	return ;
  801698:	90                   	nop
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
  80169e:	83 ec 04             	sub    $0x4,%esp
  8016a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016a7:	8b 55 18             	mov    0x18(%ebp),%edx
  8016aa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016ae:	52                   	push   %edx
  8016af:	50                   	push   %eax
  8016b0:	ff 75 10             	pushl  0x10(%ebp)
  8016b3:	ff 75 0c             	pushl  0xc(%ebp)
  8016b6:	ff 75 08             	pushl  0x8(%ebp)
  8016b9:	6a 20                	push   $0x20
  8016bb:	e8 32 fc ff ff       	call   8012f2 <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c3:	90                   	nop
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <chktst>:
void chktst(uint32 n)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	ff 75 08             	pushl  0x8(%ebp)
  8016d4:	6a 22                	push   $0x22
  8016d6:	e8 17 fc ff ff       	call   8012f2 <syscall>
  8016db:	83 c4 18             	add    $0x18,%esp
	return ;
  8016de:	90                   	nop
}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <inctst>:

void inctst()
{
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 23                	push   $0x23
  8016f0:	e8 fd fb ff ff       	call   8012f2 <syscall>
  8016f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f8:	90                   	nop
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <gettst>:
uint32 gettst()
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 24                	push   $0x24
  80170a:	e8 e3 fb ff ff       	call   8012f2 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 25                	push   $0x25
  801723:	e8 ca fb ff ff       	call   8012f2 <syscall>
  801728:	83 c4 18             	add    $0x18,%esp
  80172b:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801730:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  80173a:	8b 45 08             	mov    0x8(%ebp),%eax
  80173d:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	ff 75 08             	pushl  0x8(%ebp)
  80174d:	6a 26                	push   $0x26
  80174f:	e8 9e fb ff ff       	call   8012f2 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
	return ;
  801757:	90                   	nop
}
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
  80175d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80175e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801761:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801764:	8b 55 0c             	mov    0xc(%ebp),%edx
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	6a 00                	push   $0x0
  80176c:	53                   	push   %ebx
  80176d:	51                   	push   %ecx
  80176e:	52                   	push   %edx
  80176f:	50                   	push   %eax
  801770:	6a 27                	push   $0x27
  801772:	e8 7b fb ff ff       	call   8012f2 <syscall>
  801777:	83 c4 18             	add    $0x18,%esp
}
  80177a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80177d:	c9                   	leave  
  80177e:	c3                   	ret    

0080177f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80177f:	55                   	push   %ebp
  801780:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801782:	8b 55 0c             	mov    0xc(%ebp),%edx
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	52                   	push   %edx
  80178f:	50                   	push   %eax
  801790:	6a 28                	push   $0x28
  801792:	e8 5b fb ff ff       	call   8012f2 <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80179f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	6a 00                	push   $0x0
  8017aa:	51                   	push   %ecx
  8017ab:	ff 75 10             	pushl  0x10(%ebp)
  8017ae:	52                   	push   %edx
  8017af:	50                   	push   %eax
  8017b0:	6a 29                	push   $0x29
  8017b2:	e8 3b fb ff ff       	call   8012f2 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	ff 75 10             	pushl  0x10(%ebp)
  8017c6:	ff 75 0c             	pushl  0xc(%ebp)
  8017c9:	ff 75 08             	pushl  0x8(%ebp)
  8017cc:	6a 12                	push   $0x12
  8017ce:	e8 1f fb ff ff       	call   8012f2 <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d6:	90                   	nop
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8017dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	52                   	push   %edx
  8017e9:	50                   	push   %eax
  8017ea:	6a 2a                	push   $0x2a
  8017ec:	e8 01 fb ff ff       	call   8012f2 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
	return;
  8017f4:	90                   	nop
}
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 2b                	push   $0x2b
  801806:	e8 e7 fa ff ff       	call   8012f2 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
}
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801816:	83 ec 04             	sub    $0x4,%esp
  801819:	68 88 22 80 00       	push   $0x802288
  80181e:	68 0a 01 00 00       	push   $0x10a
  801823:	68 98 22 80 00       	push   $0x802298
  801828:	e8 38 00 00 00       	call   801865 <_panic>

0080182d <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	ff 75 0c             	pushl  0xc(%ebp)
  801839:	ff 75 08             	pushl  0x8(%ebp)
  80183c:	6a 33                	push   $0x33
  80183e:	e8 af fa ff ff       	call   8012f2 <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
	return;
  801846:	90                   	nop
}
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	ff 75 0c             	pushl  0xc(%ebp)
  801855:	ff 75 08             	pushl  0x8(%ebp)
  801858:	6a 34                	push   $0x34
  80185a:	e8 93 fa ff ff       	call   8012f2 <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
	return ;
  801862:	90                   	nop
}
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
  801868:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80186b:	8d 45 10             	lea    0x10(%ebp),%eax
  80186e:	83 c0 04             	add    $0x4,%eax
  801871:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801874:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801879:	85 c0                	test   %eax,%eax
  80187b:	74 16                	je     801893 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80187d:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801882:	83 ec 08             	sub    $0x8,%esp
  801885:	50                   	push   %eax
  801886:	68 a8 22 80 00       	push   $0x8022a8
  80188b:	e8 7d eb ff ff       	call   80040d <cprintf>
  801890:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801893:	a1 04 30 80 00       	mov    0x803004,%eax
  801898:	83 ec 0c             	sub    $0xc,%esp
  80189b:	ff 75 0c             	pushl  0xc(%ebp)
  80189e:	ff 75 08             	pushl  0x8(%ebp)
  8018a1:	50                   	push   %eax
  8018a2:	68 b0 22 80 00       	push   $0x8022b0
  8018a7:	6a 74                	push   $0x74
  8018a9:	e8 8c eb ff ff       	call   80043a <cprintf_colored>
  8018ae:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8018b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b4:	83 ec 08             	sub    $0x8,%esp
  8018b7:	ff 75 f4             	pushl  -0xc(%ebp)
  8018ba:	50                   	push   %eax
  8018bb:	e8 de ea ff ff       	call   80039e <vcprintf>
  8018c0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8018c3:	83 ec 08             	sub    $0x8,%esp
  8018c6:	6a 00                	push   $0x0
  8018c8:	68 d8 22 80 00       	push   $0x8022d8
  8018cd:	e8 cc ea ff ff       	call   80039e <vcprintf>
  8018d2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8018d5:	e8 45 ea ff ff       	call   80031f <exit>

	// should not return here
	while (1) ;
  8018da:	eb fe                	jmp    8018da <_panic+0x75>

008018dc <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018dc:	55                   	push   %ebp
  8018dd:	89 e5                	mov    %esp,%ebp
  8018df:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8018e7:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8018ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f0:	39 c2                	cmp    %eax,%edx
  8018f2:	74 14                	je     801908 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018f4:	83 ec 04             	sub    $0x4,%esp
  8018f7:	68 dc 22 80 00       	push   $0x8022dc
  8018fc:	6a 26                	push   $0x26
  8018fe:	68 28 23 80 00       	push   $0x802328
  801903:	e8 5d ff ff ff       	call   801865 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801908:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80190f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801916:	e9 c5 00 00 00       	jmp    8019e0 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80191b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	01 d0                	add    %edx,%eax
  80192a:	8b 00                	mov    (%eax),%eax
  80192c:	85 c0                	test   %eax,%eax
  80192e:	75 08                	jne    801938 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801930:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801933:	e9 a5 00 00 00       	jmp    8019dd <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801938:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80193f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801946:	eb 69                	jmp    8019b1 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801948:	a1 20 30 80 00       	mov    0x803020,%eax
  80194d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801953:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801956:	89 d0                	mov    %edx,%eax
  801958:	01 c0                	add    %eax,%eax
  80195a:	01 d0                	add    %edx,%eax
  80195c:	c1 e0 03             	shl    $0x3,%eax
  80195f:	01 c8                	add    %ecx,%eax
  801961:	8a 40 04             	mov    0x4(%eax),%al
  801964:	84 c0                	test   %al,%al
  801966:	75 46                	jne    8019ae <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801968:	a1 20 30 80 00       	mov    0x803020,%eax
  80196d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801973:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801976:	89 d0                	mov    %edx,%eax
  801978:	01 c0                	add    %eax,%eax
  80197a:	01 d0                	add    %edx,%eax
  80197c:	c1 e0 03             	shl    $0x3,%eax
  80197f:	01 c8                	add    %ecx,%eax
  801981:	8b 00                	mov    (%eax),%eax
  801983:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801986:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801989:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80198e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801990:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801993:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	01 c8                	add    %ecx,%eax
  80199f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019a1:	39 c2                	cmp    %eax,%edx
  8019a3:	75 09                	jne    8019ae <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8019a5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019ac:	eb 15                	jmp    8019c3 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ae:	ff 45 e8             	incl   -0x18(%ebp)
  8019b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8019b6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8019bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019bf:	39 c2                	cmp    %eax,%edx
  8019c1:	77 85                	ja     801948 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019c7:	75 14                	jne    8019dd <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8019c9:	83 ec 04             	sub    $0x4,%esp
  8019cc:	68 34 23 80 00       	push   $0x802334
  8019d1:	6a 3a                	push   $0x3a
  8019d3:	68 28 23 80 00       	push   $0x802328
  8019d8:	e8 88 fe ff ff       	call   801865 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8019dd:	ff 45 f0             	incl   -0x10(%ebp)
  8019e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8019e6:	0f 8c 2f ff ff ff    	jl     80191b <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019fa:	eb 26                	jmp    801a22 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019fc:	a1 20 30 80 00       	mov    0x803020,%eax
  801a01:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801a07:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a0a:	89 d0                	mov    %edx,%eax
  801a0c:	01 c0                	add    %eax,%eax
  801a0e:	01 d0                	add    %edx,%eax
  801a10:	c1 e0 03             	shl    $0x3,%eax
  801a13:	01 c8                	add    %ecx,%eax
  801a15:	8a 40 04             	mov    0x4(%eax),%al
  801a18:	3c 01                	cmp    $0x1,%al
  801a1a:	75 03                	jne    801a1f <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801a1c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a1f:	ff 45 e0             	incl   -0x20(%ebp)
  801a22:	a1 20 30 80 00       	mov    0x803020,%eax
  801a27:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801a2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a30:	39 c2                	cmp    %eax,%edx
  801a32:	77 c8                	ja     8019fc <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a37:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a3a:	74 14                	je     801a50 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801a3c:	83 ec 04             	sub    $0x4,%esp
  801a3f:	68 88 23 80 00       	push   $0x802388
  801a44:	6a 44                	push   $0x44
  801a46:	68 28 23 80 00       	push   $0x802328
  801a4b:	e8 15 fe ff ff       	call   801865 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a50:	90                   	nop
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    
  801a53:	90                   	nop

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
