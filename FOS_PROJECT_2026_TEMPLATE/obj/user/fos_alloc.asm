
obj/user/fos_alloc:     file format elf32-i386


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
  800031:	e8 02 01 00 00       	call   800138 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//uint32 size = 2*1024*1024 +120*4096+1;
	//uint32 size = 1*1024*1024 + 256*1024;
	//uint32 size = 1*1024*1024;
	uint32 size = 100;
  80003e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)

	unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800045:	83 ec 0c             	sub    $0xc,%esp
  800048:	ff 75 f0             	pushl  -0x10(%ebp)
  80004b:	e8 80 13 00 00       	call   8013d0 <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 40 1f 80 00       	push   $0x801f40
  800061:	e8 84 04 00 00       	call   8004ea <atomic_cprintf>
  800066:	83 c4 10             	add    $0x10,%esp

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  800069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800070:	eb 20                	jmp    800092 <_main+0x5a>
	{
		x[i] = i%256 ;
  800072:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800075:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800078:	01 c2                	add    %eax,%edx
  80007a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007d:	25 ff 00 00 80       	and    $0x800000ff,%eax
  800082:	85 c0                	test   %eax,%eax
  800084:	79 07                	jns    80008d <_main+0x55>
  800086:	48                   	dec    %eax
  800087:	0d 00 ff ff ff       	or     $0xffffff00,%eax
  80008c:	40                   	inc    %eax
  80008d:	88 02                	mov    %al,(%edx)

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  80008f:	ff 45 f4             	incl   -0xc(%ebp)
  800092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800095:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800098:	72 d8                	jb     800072 <_main+0x3a>
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  80009a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80009d:	83 e8 07             	sub    $0x7,%eax
  8000a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000a3:	eb 24                	jmp    8000c9 <_main+0x91>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
  8000a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8a 00                	mov    (%eax),%al
  8000af:	0f b6 c0             	movzbl %al,%eax
  8000b2:	83 ec 04             	sub    $0x4,%esp
  8000b5:	50                   	push   %eax
  8000b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b9:	68 53 1f 80 00       	push   $0x801f53
  8000be:	e8 27 04 00 00       	call   8004ea <atomic_cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  8000c6:	ff 45 f4             	incl   -0xc(%ebp)
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cf:	72 d4                	jb     8000a5 <_main+0x6d>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
	
	free(x);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 22 13 00 00       	call   8013fe <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 e6 12 00 00       	call   8013d0 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
	
	for (i = size-7 ; i < size ; i++)
  8000f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f3:	83 e8 07             	sub    $0x7,%eax
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000f9:	eb 24                	jmp    80011f <_main+0xe7>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
  8000fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	8a 00                	mov    (%eax),%al
  800105:	0f b6 c0             	movzbl %al,%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	50                   	push   %eax
  80010c:	ff 75 f4             	pushl  -0xc(%ebp)
  80010f:	68 53 1f 80 00       	push   $0x801f53
  800114:	e8 d1 03 00 00       	call   8004ea <atomic_cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
	
	free(x);

	x = malloc(sizeof(unsigned char)*size) ;
	
	for (i = size-7 ; i < size ; i++)
  80011c:	ff 45 f4             	incl   -0xc(%ebp)
  80011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800125:	72 d4                	jb     8000fb <_main+0xc3>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
	}

	free(x);
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	ff 75 ec             	pushl  -0x14(%ebp)
  80012d:	e8 cc 12 00 00       	call   8013fe <free>
  800132:	83 c4 10             	add    $0x10,%esp
	
	return;	
  800135:	90                   	nop
}
  800136:	c9                   	leave  
  800137:	c3                   	ret    

00800138 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800138:	55                   	push   %ebp
  800139:	89 e5                	mov    %esp,%ebp
  80013b:	57                   	push   %edi
  80013c:	56                   	push   %esi
  80013d:	53                   	push   %ebx
  80013e:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800144:	e8 23 16 00 00       	call   80176c <sys_getenvindex>
  800149:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80014c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80014f:	89 d0                	mov    %edx,%eax
  800151:	c1 e0 03             	shl    $0x3,%eax
  800154:	01 d0                	add    %edx,%eax
  800156:	c1 e0 06             	shl    $0x6,%eax
  800159:	01 d0                	add    %edx,%eax
  80015b:	c1 e0 03             	shl    $0x3,%eax
  80015e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800163:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800168:	a1 20 30 80 00       	mov    0x803020,%eax
  80016d:	8a 40 10             	mov    0x10(%eax),%al
  800170:	84 c0                	test   %al,%al
  800172:	74 0d                	je     800181 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	83 c0 10             	add    $0x10,%eax
  80017c:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800181:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800185:	7e 0a                	jle    800191 <libmain+0x59>
		binaryname = argv[0];
  800187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018a:	8b 00                	mov    (%eax),%eax
  80018c:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800191:	83 ec 08             	sub    $0x8,%esp
  800194:	ff 75 0c             	pushl  0xc(%ebp)
  800197:	ff 75 08             	pushl  0x8(%ebp)
  80019a:	e8 99 fe ff ff       	call   800038 <_main>
  80019f:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8001a2:	a1 00 30 80 00       	mov    0x803000,%eax
  8001a7:	85 c0                	test   %eax,%eax
  8001a9:	0f 84 b7 01 00 00    	je     800366 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001af:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001b5:	bb 9c 20 80 00       	mov    $0x80209c,%ebx
  8001ba:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001bf:	89 c7                	mov    %eax,%edi
  8001c1:	89 de                	mov    %ebx,%esi
  8001c3:	89 d1                	mov    %edx,%ecx
  8001c5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001c7:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8001cd:	b9 56 00 00 00       	mov    $0x56,%ecx
  8001d2:	b0 00                	mov    $0x0,%al
  8001d4:	89 d7                	mov    %edx,%edi
  8001d6:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8001d8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8001df:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8001e2:	83 ec 08             	sub    $0x8,%esp
  8001e5:	50                   	push   %eax
  8001e6:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001ec:	50                   	push   %eax
  8001ed:	e8 7a 17 00 00       	call   80196c <sys_utilities>
  8001f2:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8001f5:	e8 fa 12 00 00       	call   8014f4 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8001fa:	83 ec 0c             	sub    $0xc,%esp
  8001fd:	68 78 1f 80 00       	push   $0x801f78
  800202:	e8 71 02 00 00       	call   800478 <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80020a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80020d:	85 c0                	test   %eax,%eax
  80020f:	74 58                	je     800269 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800211:	e8 74 17 00 00       	call   80198a <sys_get_optimal_num_faults>
  800216:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800219:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80021f:	bb 00 21 80 00       	mov    $0x802100,%ebx
  800224:	ba 11 00 00 00       	mov    $0x11,%edx
  800229:	89 c7                	mov    %eax,%edi
  80022b:	89 de                	mov    %ebx,%esi
  80022d:	89 d1                	mov    %edx,%ecx
  80022f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800231:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800234:	b9 53 00 00 00       	mov    $0x53,%ecx
  800239:	b0 00                	mov    $0x0,%al
  80023b:	89 d7                	mov    %edx,%edi
  80023d:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80023f:	83 ec 08             	sub    $0x8,%esp
  800242:	ff 75 dc             	pushl  -0x24(%ebp)
  800245:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	e8 1b 17 00 00       	call   80196c <sys_utilities>
  800251:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800254:	83 ec 08             	sub    $0x8,%esp
  800257:	ff 75 dc             	pushl  -0x24(%ebp)
  80025a:	68 a0 1f 80 00       	push   $0x801fa0
  80025f:	e8 14 02 00 00       	call   800478 <cprintf>
  800264:	83 c4 10             	add    $0x10,%esp
  800267:	eb 59                	jmp    8002c2 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800274:	a1 20 30 80 00       	mov    0x803020,%eax
  800279:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	52                   	push   %edx
  800283:	50                   	push   %eax
  800284:	68 c4 1f 80 00       	push   $0x801fc4
  800289:	e8 ea 01 00 00       	call   800478 <cprintf>
  80028e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80029c:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a1:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ac:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002b2:	51                   	push   %ecx
  8002b3:	52                   	push   %edx
  8002b4:	50                   	push   %eax
  8002b5:	68 ec 1f 80 00       	push   $0x801fec
  8002ba:	e8 b9 01 00 00       	call   800478 <cprintf>
  8002bf:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c7:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8002cd:	83 ec 08             	sub    $0x8,%esp
  8002d0:	50                   	push   %eax
  8002d1:	68 44 20 80 00       	push   $0x802044
  8002d6:	e8 9d 01 00 00       	call   800478 <cprintf>
  8002db:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8002de:	83 ec 0c             	sub    $0xc,%esp
  8002e1:	68 58 20 80 00       	push   $0x802058
  8002e6:	e8 8d 01 00 00       	call   800478 <cprintf>
  8002eb:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8002ee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002f5:	eb 28                	jmp    80031f <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8002f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002ff:	81 c2 74 04 00 00    	add    $0x474,%edx
  800305:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800308:	83 ec 04             	sub    $0x4,%esp
  80030b:	50                   	push   %eax
  80030c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030f:	68 6f 20 80 00       	push   $0x80206f
  800314:	e8 5f 01 00 00       	call   800478 <cprintf>
  800319:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80031c:	ff 45 e4             	incl   -0x1c(%ebp)
  80031f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800323:	7e d2                	jle    8002f7 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800325:	83 ec 0c             	sub    $0xc,%esp
  800328:	68 7e 20 80 00       	push   $0x80207e
  80032d:	e8 46 01 00 00       	call   800478 <cprintf>
  800332:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800335:	a1 20 30 80 00       	mov    0x803020,%eax
  80033a:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800340:	83 ec 08             	sub    $0x8,%esp
  800343:	50                   	push   %eax
  800344:	68 82 20 80 00       	push   $0x802082
  800349:	e8 2a 01 00 00       	call   800478 <cprintf>
  80034e:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800351:	83 ec 0c             	sub    $0xc,%esp
  800354:	68 78 1f 80 00       	push   $0x801f78
  800359:	e8 1a 01 00 00       	call   800478 <cprintf>
  80035e:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800361:	e8 a8 11 00 00       	call   80150e <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800366:	e8 1f 00 00 00       	call   80038a <exit>
}
  80036b:	90                   	nop
  80036c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80036f:	5b                   	pop    %ebx
  800370:	5e                   	pop    %esi
  800371:	5f                   	pop    %edi
  800372:	5d                   	pop    %ebp
  800373:	c3                   	ret    

00800374 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800374:	55                   	push   %ebp
  800375:	89 e5                	mov    %esp,%ebp
  800377:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80037a:	83 ec 0c             	sub    $0xc,%esp
  80037d:	6a 00                	push   $0x0
  80037f:	e8 b4 13 00 00       	call   801738 <sys_destroy_env>
  800384:	83 c4 10             	add    $0x10,%esp
}
  800387:	90                   	nop
  800388:	c9                   	leave  
  800389:	c3                   	ret    

0080038a <exit>:

void
exit(void)
{
  80038a:	55                   	push   %ebp
  80038b:	89 e5                	mov    %esp,%ebp
  80038d:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800390:	e8 09 14 00 00       	call   80179e <sys_exit_env>
}
  800395:	90                   	nop
  800396:	c9                   	leave  
  800397:	c3                   	ret    

00800398 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800398:	55                   	push   %ebp
  800399:	89 e5                	mov    %esp,%ebp
  80039b:	53                   	push   %ebx
  80039c:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80039f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a2:	8b 00                	mov    (%eax),%eax
  8003a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8003a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003aa:	89 0a                	mov    %ecx,(%edx)
  8003ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8003af:	88 d1                	mov    %dl,%cl
  8003b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003c2:	75 30                	jne    8003f4 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8003c4:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8003ca:	a0 40 30 80 00       	mov    0x803040,%al
  8003cf:	0f b6 c0             	movzbl %al,%eax
  8003d2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003d5:	8b 09                	mov    (%ecx),%ecx
  8003d7:	89 cb                	mov    %ecx,%ebx
  8003d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dc:	83 c1 08             	add    $0x8,%ecx
  8003df:	52                   	push   %edx
  8003e0:	50                   	push   %eax
  8003e1:	53                   	push   %ebx
  8003e2:	51                   	push   %ecx
  8003e3:	e8 c8 10 00 00       	call   8014b0 <sys_cputs>
  8003e8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f7:	8b 40 04             	mov    0x4(%eax),%eax
  8003fa:	8d 50 01             	lea    0x1(%eax),%edx
  8003fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800400:	89 50 04             	mov    %edx,0x4(%eax)
}
  800403:	90                   	nop
  800404:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800407:	c9                   	leave  
  800408:	c3                   	ret    

00800409 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
  80040c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800412:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800419:	00 00 00 
	b.cnt = 0;
  80041c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800423:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800426:	ff 75 0c             	pushl  0xc(%ebp)
  800429:	ff 75 08             	pushl  0x8(%ebp)
  80042c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800432:	50                   	push   %eax
  800433:	68 98 03 80 00       	push   $0x800398
  800438:	e8 5a 02 00 00       	call   800697 <vprintfmt>
  80043d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800440:	8b 15 28 31 80 00    	mov    0x803128,%edx
  800446:	a0 40 30 80 00       	mov    0x803040,%al
  80044b:	0f b6 c0             	movzbl %al,%eax
  80044e:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800454:	52                   	push   %edx
  800455:	50                   	push   %eax
  800456:	51                   	push   %ecx
  800457:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80045d:	83 c0 08             	add    $0x8,%eax
  800460:	50                   	push   %eax
  800461:	e8 4a 10 00 00       	call   8014b0 <sys_cputs>
  800466:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800469:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800470:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80047e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800485:	8d 45 0c             	lea    0xc(%ebp),%eax
  800488:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	83 ec 08             	sub    $0x8,%esp
  800491:	ff 75 f4             	pushl  -0xc(%ebp)
  800494:	50                   	push   %eax
  800495:	e8 6f ff ff ff       	call   800409 <vcprintf>
  80049a:	83 c4 10             	add    $0x10,%esp
  80049d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004a3:	c9                   	leave  
  8004a4:	c3                   	ret    

008004a5 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8004a5:	55                   	push   %ebp
  8004a6:	89 e5                	mov    %esp,%ebp
  8004a8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004ab:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8004b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b5:	c1 e0 08             	shl    $0x8,%eax
  8004b8:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8004bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004c0:	83 c0 04             	add    $0x4,%eax
  8004c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c9:	83 ec 08             	sub    $0x8,%esp
  8004cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8004cf:	50                   	push   %eax
  8004d0:	e8 34 ff ff ff       	call   800409 <vcprintf>
  8004d5:	83 c4 10             	add    $0x10,%esp
  8004d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8004db:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  8004e2:	07 00 00 

	return cnt;
  8004e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004e8:	c9                   	leave  
  8004e9:	c3                   	ret    

008004ea <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
  8004ed:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8004f0:	e8 ff 0f 00 00       	call   8014f4 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8004f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8004fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fe:	83 ec 08             	sub    $0x8,%esp
  800501:	ff 75 f4             	pushl  -0xc(%ebp)
  800504:	50                   	push   %eax
  800505:	e8 ff fe ff ff       	call   800409 <vcprintf>
  80050a:	83 c4 10             	add    $0x10,%esp
  80050d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800510:	e8 f9 0f 00 00       	call   80150e <sys_unlock_cons>
	return cnt;
  800515:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800518:	c9                   	leave  
  800519:	c3                   	ret    

0080051a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80051a:	55                   	push   %ebp
  80051b:	89 e5                	mov    %esp,%ebp
  80051d:	53                   	push   %ebx
  80051e:	83 ec 14             	sub    $0x14,%esp
  800521:	8b 45 10             	mov    0x10(%ebp),%eax
  800524:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800527:	8b 45 14             	mov    0x14(%ebp),%eax
  80052a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80052d:	8b 45 18             	mov    0x18(%ebp),%eax
  800530:	ba 00 00 00 00       	mov    $0x0,%edx
  800535:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800538:	77 55                	ja     80058f <printnum+0x75>
  80053a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80053d:	72 05                	jb     800544 <printnum+0x2a>
  80053f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800542:	77 4b                	ja     80058f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800544:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800547:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80054a:	8b 45 18             	mov    0x18(%ebp),%eax
  80054d:	ba 00 00 00 00       	mov    $0x0,%edx
  800552:	52                   	push   %edx
  800553:	50                   	push   %eax
  800554:	ff 75 f4             	pushl  -0xc(%ebp)
  800557:	ff 75 f0             	pushl  -0x10(%ebp)
  80055a:	e8 79 17 00 00       	call   801cd8 <__udivdi3>
  80055f:	83 c4 10             	add    $0x10,%esp
  800562:	83 ec 04             	sub    $0x4,%esp
  800565:	ff 75 20             	pushl  0x20(%ebp)
  800568:	53                   	push   %ebx
  800569:	ff 75 18             	pushl  0x18(%ebp)
  80056c:	52                   	push   %edx
  80056d:	50                   	push   %eax
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	ff 75 08             	pushl  0x8(%ebp)
  800574:	e8 a1 ff ff ff       	call   80051a <printnum>
  800579:	83 c4 20             	add    $0x20,%esp
  80057c:	eb 1a                	jmp    800598 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80057e:	83 ec 08             	sub    $0x8,%esp
  800581:	ff 75 0c             	pushl  0xc(%ebp)
  800584:	ff 75 20             	pushl  0x20(%ebp)
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	ff d0                	call   *%eax
  80058c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80058f:	ff 4d 1c             	decl   0x1c(%ebp)
  800592:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800596:	7f e6                	jg     80057e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800598:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80059b:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005a6:	53                   	push   %ebx
  8005a7:	51                   	push   %ecx
  8005a8:	52                   	push   %edx
  8005a9:	50                   	push   %eax
  8005aa:	e8 39 18 00 00       	call   801de8 <__umoddi3>
  8005af:	83 c4 10             	add    $0x10,%esp
  8005b2:	05 94 23 80 00       	add    $0x802394,%eax
  8005b7:	8a 00                	mov    (%eax),%al
  8005b9:	0f be c0             	movsbl %al,%eax
  8005bc:	83 ec 08             	sub    $0x8,%esp
  8005bf:	ff 75 0c             	pushl  0xc(%ebp)
  8005c2:	50                   	push   %eax
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	ff d0                	call   *%eax
  8005c8:	83 c4 10             	add    $0x10,%esp
}
  8005cb:	90                   	nop
  8005cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005cf:	c9                   	leave  
  8005d0:	c3                   	ret    

008005d1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005d1:	55                   	push   %ebp
  8005d2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005d4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d8:	7e 1c                	jle    8005f6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	8b 00                	mov    (%eax),%eax
  8005df:	8d 50 08             	lea    0x8(%eax),%edx
  8005e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e5:	89 10                	mov    %edx,(%eax)
  8005e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	83 e8 08             	sub    $0x8,%eax
  8005ef:	8b 50 04             	mov    0x4(%eax),%edx
  8005f2:	8b 00                	mov    (%eax),%eax
  8005f4:	eb 40                	jmp    800636 <getuint+0x65>
	else if (lflag)
  8005f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005fa:	74 1e                	je     80061a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	8b 00                	mov    (%eax),%eax
  800601:	8d 50 04             	lea    0x4(%eax),%edx
  800604:	8b 45 08             	mov    0x8(%ebp),%eax
  800607:	89 10                	mov    %edx,(%eax)
  800609:	8b 45 08             	mov    0x8(%ebp),%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	83 e8 04             	sub    $0x4,%eax
  800611:	8b 00                	mov    (%eax),%eax
  800613:	ba 00 00 00 00       	mov    $0x0,%edx
  800618:	eb 1c                	jmp    800636 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	8d 50 04             	lea    0x4(%eax),%edx
  800622:	8b 45 08             	mov    0x8(%ebp),%eax
  800625:	89 10                	mov    %edx,(%eax)
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	83 e8 04             	sub    $0x4,%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800636:	5d                   	pop    %ebp
  800637:	c3                   	ret    

00800638 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800638:	55                   	push   %ebp
  800639:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80063b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80063f:	7e 1c                	jle    80065d <getint+0x25>
		return va_arg(*ap, long long);
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	8b 00                	mov    (%eax),%eax
  800646:	8d 50 08             	lea    0x8(%eax),%edx
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	89 10                	mov    %edx,(%eax)
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	83 e8 08             	sub    $0x8,%eax
  800656:	8b 50 04             	mov    0x4(%eax),%edx
  800659:	8b 00                	mov    (%eax),%eax
  80065b:	eb 38                	jmp    800695 <getint+0x5d>
	else if (lflag)
  80065d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800661:	74 1a                	je     80067d <getint+0x45>
		return va_arg(*ap, long);
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	8b 00                	mov    (%eax),%eax
  800668:	8d 50 04             	lea    0x4(%eax),%edx
  80066b:	8b 45 08             	mov    0x8(%ebp),%eax
  80066e:	89 10                	mov    %edx,(%eax)
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8b 00                	mov    (%eax),%eax
  800675:	83 e8 04             	sub    $0x4,%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	99                   	cltd   
  80067b:	eb 18                	jmp    800695 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	8b 00                	mov    (%eax),%eax
  800682:	8d 50 04             	lea    0x4(%eax),%edx
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	89 10                	mov    %edx,(%eax)
  80068a:	8b 45 08             	mov    0x8(%ebp),%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	83 e8 04             	sub    $0x4,%eax
  800692:	8b 00                	mov    (%eax),%eax
  800694:	99                   	cltd   
}
  800695:	5d                   	pop    %ebp
  800696:	c3                   	ret    

00800697 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800697:	55                   	push   %ebp
  800698:	89 e5                	mov    %esp,%ebp
  80069a:	56                   	push   %esi
  80069b:	53                   	push   %ebx
  80069c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80069f:	eb 17                	jmp    8006b8 <vprintfmt+0x21>
			if (ch == '\0')
  8006a1:	85 db                	test   %ebx,%ebx
  8006a3:	0f 84 c1 03 00 00    	je     800a6a <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 0c             	pushl  0xc(%ebp)
  8006af:	53                   	push   %ebx
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	ff d0                	call   *%eax
  8006b5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006bb:	8d 50 01             	lea    0x1(%eax),%edx
  8006be:	89 55 10             	mov    %edx,0x10(%ebp)
  8006c1:	8a 00                	mov    (%eax),%al
  8006c3:	0f b6 d8             	movzbl %al,%ebx
  8006c6:	83 fb 25             	cmp    $0x25,%ebx
  8006c9:	75 d6                	jne    8006a1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006cb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006cf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006d6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006dd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006e4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ee:	8d 50 01             	lea    0x1(%eax),%edx
  8006f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8006f4:	8a 00                	mov    (%eax),%al
  8006f6:	0f b6 d8             	movzbl %al,%ebx
  8006f9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006fc:	83 f8 5b             	cmp    $0x5b,%eax
  8006ff:	0f 87 3d 03 00 00    	ja     800a42 <vprintfmt+0x3ab>
  800705:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  80070c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80070e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800712:	eb d7                	jmp    8006eb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800714:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800718:	eb d1                	jmp    8006eb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80071a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800721:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800724:	89 d0                	mov    %edx,%eax
  800726:	c1 e0 02             	shl    $0x2,%eax
  800729:	01 d0                	add    %edx,%eax
  80072b:	01 c0                	add    %eax,%eax
  80072d:	01 d8                	add    %ebx,%eax
  80072f:	83 e8 30             	sub    $0x30,%eax
  800732:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800735:	8b 45 10             	mov    0x10(%ebp),%eax
  800738:	8a 00                	mov    (%eax),%al
  80073a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80073d:	83 fb 2f             	cmp    $0x2f,%ebx
  800740:	7e 3e                	jle    800780 <vprintfmt+0xe9>
  800742:	83 fb 39             	cmp    $0x39,%ebx
  800745:	7f 39                	jg     800780 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800747:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80074a:	eb d5                	jmp    800721 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80074c:	8b 45 14             	mov    0x14(%ebp),%eax
  80074f:	83 c0 04             	add    $0x4,%eax
  800752:	89 45 14             	mov    %eax,0x14(%ebp)
  800755:	8b 45 14             	mov    0x14(%ebp),%eax
  800758:	83 e8 04             	sub    $0x4,%eax
  80075b:	8b 00                	mov    (%eax),%eax
  80075d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800760:	eb 1f                	jmp    800781 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800762:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800766:	79 83                	jns    8006eb <vprintfmt+0x54>
				width = 0;
  800768:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80076f:	e9 77 ff ff ff       	jmp    8006eb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800774:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80077b:	e9 6b ff ff ff       	jmp    8006eb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800780:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800781:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800785:	0f 89 60 ff ff ff    	jns    8006eb <vprintfmt+0x54>
				width = precision, precision = -1;
  80078b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80078e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800791:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800798:	e9 4e ff ff ff       	jmp    8006eb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80079d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007a0:	e9 46 ff ff ff       	jmp    8006eb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a8:	83 c0 04             	add    $0x4,%eax
  8007ab:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	83 ec 08             	sub    $0x8,%esp
  8007b9:	ff 75 0c             	pushl  0xc(%ebp)
  8007bc:	50                   	push   %eax
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	ff d0                	call   *%eax
  8007c2:	83 c4 10             	add    $0x10,%esp
			break;
  8007c5:	e9 9b 02 00 00       	jmp    800a65 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cd:	83 c0 04             	add    $0x4,%eax
  8007d0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d6:	83 e8 04             	sub    $0x4,%eax
  8007d9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007db:	85 db                	test   %ebx,%ebx
  8007dd:	79 02                	jns    8007e1 <vprintfmt+0x14a>
				err = -err;
  8007df:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007e1:	83 fb 64             	cmp    $0x64,%ebx
  8007e4:	7f 0b                	jg     8007f1 <vprintfmt+0x15a>
  8007e6:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  8007ed:	85 f6                	test   %esi,%esi
  8007ef:	75 19                	jne    80080a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007f1:	53                   	push   %ebx
  8007f2:	68 a5 23 80 00       	push   $0x8023a5
  8007f7:	ff 75 0c             	pushl  0xc(%ebp)
  8007fa:	ff 75 08             	pushl  0x8(%ebp)
  8007fd:	e8 70 02 00 00       	call   800a72 <printfmt>
  800802:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800805:	e9 5b 02 00 00       	jmp    800a65 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80080a:	56                   	push   %esi
  80080b:	68 ae 23 80 00       	push   $0x8023ae
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 57 02 00 00       	call   800a72 <printfmt>
  80081b:	83 c4 10             	add    $0x10,%esp
			break;
  80081e:	e9 42 02 00 00       	jmp    800a65 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800823:	8b 45 14             	mov    0x14(%ebp),%eax
  800826:	83 c0 04             	add    $0x4,%eax
  800829:	89 45 14             	mov    %eax,0x14(%ebp)
  80082c:	8b 45 14             	mov    0x14(%ebp),%eax
  80082f:	83 e8 04             	sub    $0x4,%eax
  800832:	8b 30                	mov    (%eax),%esi
  800834:	85 f6                	test   %esi,%esi
  800836:	75 05                	jne    80083d <vprintfmt+0x1a6>
				p = "(null)";
  800838:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  80083d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800841:	7e 6d                	jle    8008b0 <vprintfmt+0x219>
  800843:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800847:	74 67                	je     8008b0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800849:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	50                   	push   %eax
  800850:	56                   	push   %esi
  800851:	e8 1e 03 00 00       	call   800b74 <strnlen>
  800856:	83 c4 10             	add    $0x10,%esp
  800859:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80085c:	eb 16                	jmp    800874 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80085e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	ff 75 0c             	pushl  0xc(%ebp)
  800868:	50                   	push   %eax
  800869:	8b 45 08             	mov    0x8(%ebp),%eax
  80086c:	ff d0                	call   *%eax
  80086e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800871:	ff 4d e4             	decl   -0x1c(%ebp)
  800874:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800878:	7f e4                	jg     80085e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80087a:	eb 34                	jmp    8008b0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80087c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800880:	74 1c                	je     80089e <vprintfmt+0x207>
  800882:	83 fb 1f             	cmp    $0x1f,%ebx
  800885:	7e 05                	jle    80088c <vprintfmt+0x1f5>
  800887:	83 fb 7e             	cmp    $0x7e,%ebx
  80088a:	7e 12                	jle    80089e <vprintfmt+0x207>
					putch('?', putdat);
  80088c:	83 ec 08             	sub    $0x8,%esp
  80088f:	ff 75 0c             	pushl  0xc(%ebp)
  800892:	6a 3f                	push   $0x3f
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	ff d0                	call   *%eax
  800899:	83 c4 10             	add    $0x10,%esp
  80089c:	eb 0f                	jmp    8008ad <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80089e:	83 ec 08             	sub    $0x8,%esp
  8008a1:	ff 75 0c             	pushl  0xc(%ebp)
  8008a4:	53                   	push   %ebx
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	ff d0                	call   *%eax
  8008aa:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ad:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b0:	89 f0                	mov    %esi,%eax
  8008b2:	8d 70 01             	lea    0x1(%eax),%esi
  8008b5:	8a 00                	mov    (%eax),%al
  8008b7:	0f be d8             	movsbl %al,%ebx
  8008ba:	85 db                	test   %ebx,%ebx
  8008bc:	74 24                	je     8008e2 <vprintfmt+0x24b>
  8008be:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008c2:	78 b8                	js     80087c <vprintfmt+0x1e5>
  8008c4:	ff 4d e0             	decl   -0x20(%ebp)
  8008c7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008cb:	79 af                	jns    80087c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008cd:	eb 13                	jmp    8008e2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	6a 20                	push   $0x20
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	ff d0                	call   *%eax
  8008dc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008df:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e6:	7f e7                	jg     8008cf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008e8:	e9 78 01 00 00       	jmp    800a65 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008ed:	83 ec 08             	sub    $0x8,%esp
  8008f0:	ff 75 e8             	pushl  -0x18(%ebp)
  8008f3:	8d 45 14             	lea    0x14(%ebp),%eax
  8008f6:	50                   	push   %eax
  8008f7:	e8 3c fd ff ff       	call   800638 <getint>
  8008fc:	83 c4 10             	add    $0x10,%esp
  8008ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800902:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800905:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800908:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80090b:	85 d2                	test   %edx,%edx
  80090d:	79 23                	jns    800932 <vprintfmt+0x29b>
				putch('-', putdat);
  80090f:	83 ec 08             	sub    $0x8,%esp
  800912:	ff 75 0c             	pushl  0xc(%ebp)
  800915:	6a 2d                	push   $0x2d
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	ff d0                	call   *%eax
  80091c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80091f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800922:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800925:	f7 d8                	neg    %eax
  800927:	83 d2 00             	adc    $0x0,%edx
  80092a:	f7 da                	neg    %edx
  80092c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80092f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800932:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800939:	e9 bc 00 00 00       	jmp    8009fa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 e8             	pushl  -0x18(%ebp)
  800944:	8d 45 14             	lea    0x14(%ebp),%eax
  800947:	50                   	push   %eax
  800948:	e8 84 fc ff ff       	call   8005d1 <getuint>
  80094d:	83 c4 10             	add    $0x10,%esp
  800950:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800953:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800956:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80095d:	e9 98 00 00 00       	jmp    8009fa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800962:	83 ec 08             	sub    $0x8,%esp
  800965:	ff 75 0c             	pushl  0xc(%ebp)
  800968:	6a 58                	push   $0x58
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	ff d0                	call   *%eax
  80096f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	6a 58                	push   $0x58
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	ff d0                	call   *%eax
  80097f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	6a 58                	push   $0x58
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	ff d0                	call   *%eax
  80098f:	83 c4 10             	add    $0x10,%esp
			break;
  800992:	e9 ce 00 00 00       	jmp    800a65 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800997:	83 ec 08             	sub    $0x8,%esp
  80099a:	ff 75 0c             	pushl  0xc(%ebp)
  80099d:	6a 30                	push   $0x30
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	ff d0                	call   *%eax
  8009a4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	6a 78                	push   $0x78
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	ff d0                	call   *%eax
  8009b4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ba:	83 c0 04             	add    $0x4,%eax
  8009bd:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c3:	83 e8 04             	sub    $0x4,%eax
  8009c6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009d2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009d9:	eb 1f                	jmp    8009fa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009db:	83 ec 08             	sub    $0x8,%esp
  8009de:	ff 75 e8             	pushl  -0x18(%ebp)
  8009e1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009e4:	50                   	push   %eax
  8009e5:	e8 e7 fb ff ff       	call   8005d1 <getuint>
  8009ea:	83 c4 10             	add    $0x10,%esp
  8009ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009f3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009fa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a01:	83 ec 04             	sub    $0x4,%esp
  800a04:	52                   	push   %edx
  800a05:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a08:	50                   	push   %eax
  800a09:	ff 75 f4             	pushl  -0xc(%ebp)
  800a0c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	ff 75 08             	pushl  0x8(%ebp)
  800a15:	e8 00 fb ff ff       	call   80051a <printnum>
  800a1a:	83 c4 20             	add    $0x20,%esp
			break;
  800a1d:	eb 46                	jmp    800a65 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a1f:	83 ec 08             	sub    $0x8,%esp
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	53                   	push   %ebx
  800a26:	8b 45 08             	mov    0x8(%ebp),%eax
  800a29:	ff d0                	call   *%eax
  800a2b:	83 c4 10             	add    $0x10,%esp
			break;
  800a2e:	eb 35                	jmp    800a65 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800a30:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800a37:	eb 2c                	jmp    800a65 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800a39:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800a40:	eb 23                	jmp    800a65 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	ff 75 0c             	pushl  0xc(%ebp)
  800a48:	6a 25                	push   $0x25
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	ff d0                	call   *%eax
  800a4f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a52:	ff 4d 10             	decl   0x10(%ebp)
  800a55:	eb 03                	jmp    800a5a <vprintfmt+0x3c3>
  800a57:	ff 4d 10             	decl   0x10(%ebp)
  800a5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5d:	48                   	dec    %eax
  800a5e:	8a 00                	mov    (%eax),%al
  800a60:	3c 25                	cmp    $0x25,%al
  800a62:	75 f3                	jne    800a57 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800a64:	90                   	nop
		}
	}
  800a65:	e9 35 fc ff ff       	jmp    80069f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a6a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a6b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a6e:	5b                   	pop    %ebx
  800a6f:	5e                   	pop    %esi
  800a70:	5d                   	pop    %ebp
  800a71:	c3                   	ret    

00800a72 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
  800a75:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a78:	8d 45 10             	lea    0x10(%ebp),%eax
  800a7b:	83 c0 04             	add    $0x4,%eax
  800a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a81:	8b 45 10             	mov    0x10(%ebp),%eax
  800a84:	ff 75 f4             	pushl  -0xc(%ebp)
  800a87:	50                   	push   %eax
  800a88:	ff 75 0c             	pushl  0xc(%ebp)
  800a8b:	ff 75 08             	pushl  0x8(%ebp)
  800a8e:	e8 04 fc ff ff       	call   800697 <vprintfmt>
  800a93:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a96:	90                   	nop
  800a97:	c9                   	leave  
  800a98:	c3                   	ret    

00800a99 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a99:	55                   	push   %ebp
  800a9a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9f:	8b 40 08             	mov    0x8(%eax),%eax
  800aa2:	8d 50 01             	lea    0x1(%eax),%edx
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800aab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aae:	8b 10                	mov    (%eax),%edx
  800ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab3:	8b 40 04             	mov    0x4(%eax),%eax
  800ab6:	39 c2                	cmp    %eax,%edx
  800ab8:	73 12                	jae    800acc <sprintputch+0x33>
		*b->buf++ = ch;
  800aba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	8d 48 01             	lea    0x1(%eax),%ecx
  800ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac5:	89 0a                	mov    %ecx,(%edx)
  800ac7:	8b 55 08             	mov    0x8(%ebp),%edx
  800aca:	88 10                	mov    %dl,(%eax)
}
  800acc:	90                   	nop
  800acd:	5d                   	pop    %ebp
  800ace:	c3                   	ret    

00800acf <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800acf:	55                   	push   %ebp
  800ad0:	89 e5                	mov    %esp,%ebp
  800ad2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	01 d0                	add    %edx,%eax
  800ae6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800af0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800af4:	74 06                	je     800afc <vsnprintf+0x2d>
  800af6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afa:	7f 07                	jg     800b03 <vsnprintf+0x34>
		return -E_INVAL;
  800afc:	b8 03 00 00 00       	mov    $0x3,%eax
  800b01:	eb 20                	jmp    800b23 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b03:	ff 75 14             	pushl  0x14(%ebp)
  800b06:	ff 75 10             	pushl  0x10(%ebp)
  800b09:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b0c:	50                   	push   %eax
  800b0d:	68 99 0a 80 00       	push   $0x800a99
  800b12:	e8 80 fb ff ff       	call   800697 <vprintfmt>
  800b17:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b1d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b23:	c9                   	leave  
  800b24:	c3                   	ret    

00800b25 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b2b:	8d 45 10             	lea    0x10(%ebp),%eax
  800b2e:	83 c0 04             	add    $0x4,%eax
  800b31:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b34:	8b 45 10             	mov    0x10(%ebp),%eax
  800b37:	ff 75 f4             	pushl  -0xc(%ebp)
  800b3a:	50                   	push   %eax
  800b3b:	ff 75 0c             	pushl  0xc(%ebp)
  800b3e:	ff 75 08             	pushl  0x8(%ebp)
  800b41:	e8 89 ff ff ff       	call   800acf <vsnprintf>
  800b46:	83 c4 10             	add    $0x10,%esp
  800b49:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b4f:	c9                   	leave  
  800b50:	c3                   	ret    

00800b51 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b51:	55                   	push   %ebp
  800b52:	89 e5                	mov    %esp,%ebp
  800b54:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b5e:	eb 06                	jmp    800b66 <strlen+0x15>
		n++;
  800b60:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b63:	ff 45 08             	incl   0x8(%ebp)
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	8a 00                	mov    (%eax),%al
  800b6b:	84 c0                	test   %al,%al
  800b6d:	75 f1                	jne    800b60 <strlen+0xf>
		n++;
	return n;
  800b6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b72:	c9                   	leave  
  800b73:	c3                   	ret    

00800b74 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b74:	55                   	push   %ebp
  800b75:	89 e5                	mov    %esp,%ebp
  800b77:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b81:	eb 09                	jmp    800b8c <strnlen+0x18>
		n++;
  800b83:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b86:	ff 45 08             	incl   0x8(%ebp)
  800b89:	ff 4d 0c             	decl   0xc(%ebp)
  800b8c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b90:	74 09                	je     800b9b <strnlen+0x27>
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	8a 00                	mov    (%eax),%al
  800b97:	84 c0                	test   %al,%al
  800b99:	75 e8                	jne    800b83 <strnlen+0xf>
		n++;
	return n;
  800b9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9e:	c9                   	leave  
  800b9f:	c3                   	ret    

00800ba0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ba0:	55                   	push   %ebp
  800ba1:	89 e5                	mov    %esp,%ebp
  800ba3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bac:	90                   	nop
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	8d 50 01             	lea    0x1(%eax),%edx
  800bb3:	89 55 08             	mov    %edx,0x8(%ebp)
  800bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bbf:	8a 12                	mov    (%edx),%dl
  800bc1:	88 10                	mov    %dl,(%eax)
  800bc3:	8a 00                	mov    (%eax),%al
  800bc5:	84 c0                	test   %al,%al
  800bc7:	75 e4                	jne    800bad <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcc:	c9                   	leave  
  800bcd:	c3                   	ret    

00800bce <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be1:	eb 1f                	jmp    800c02 <strncpy+0x34>
		*dst++ = *src;
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	8d 50 01             	lea    0x1(%eax),%edx
  800be9:	89 55 08             	mov    %edx,0x8(%ebp)
  800bec:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bef:	8a 12                	mov    (%edx),%dl
  800bf1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	84 c0                	test   %al,%al
  800bfa:	74 03                	je     800bff <strncpy+0x31>
			src++;
  800bfc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bff:	ff 45 fc             	incl   -0x4(%ebp)
  800c02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c05:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c08:	72 d9                	jb     800be3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c0d:	c9                   	leave  
  800c0e:	c3                   	ret    

00800c0f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c0f:	55                   	push   %ebp
  800c10:	89 e5                	mov    %esp,%ebp
  800c12:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1f:	74 30                	je     800c51 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c21:	eb 16                	jmp    800c39 <strlcpy+0x2a>
			*dst++ = *src++;
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	8d 50 01             	lea    0x1(%eax),%edx
  800c29:	89 55 08             	mov    %edx,0x8(%ebp)
  800c2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c32:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c35:	8a 12                	mov    (%edx),%dl
  800c37:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c39:	ff 4d 10             	decl   0x10(%ebp)
  800c3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c40:	74 09                	je     800c4b <strlcpy+0x3c>
  800c42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	84 c0                	test   %al,%al
  800c49:	75 d8                	jne    800c23 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c51:	8b 55 08             	mov    0x8(%ebp),%edx
  800c54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c57:	29 c2                	sub    %eax,%edx
  800c59:	89 d0                	mov    %edx,%eax
}
  800c5b:	c9                   	leave  
  800c5c:	c3                   	ret    

00800c5d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c5d:	55                   	push   %ebp
  800c5e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c60:	eb 06                	jmp    800c68 <strcmp+0xb>
		p++, q++;
  800c62:	ff 45 08             	incl   0x8(%ebp)
  800c65:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	84 c0                	test   %al,%al
  800c6f:	74 0e                	je     800c7f <strcmp+0x22>
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	8a 10                	mov    (%eax),%dl
  800c76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	38 c2                	cmp    %al,%dl
  800c7d:	74 e3                	je     800c62 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	0f b6 d0             	movzbl %al,%edx
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	0f b6 c0             	movzbl %al,%eax
  800c8f:	29 c2                	sub    %eax,%edx
  800c91:	89 d0                	mov    %edx,%eax
}
  800c93:	5d                   	pop    %ebp
  800c94:	c3                   	ret    

00800c95 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c95:	55                   	push   %ebp
  800c96:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c98:	eb 09                	jmp    800ca3 <strncmp+0xe>
		n--, p++, q++;
  800c9a:	ff 4d 10             	decl   0x10(%ebp)
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca7:	74 17                	je     800cc0 <strncmp+0x2b>
  800ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	84 c0                	test   %al,%al
  800cb0:	74 0e                	je     800cc0 <strncmp+0x2b>
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 10                	mov    (%eax),%dl
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	38 c2                	cmp    %al,%dl
  800cbe:	74 da                	je     800c9a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc4:	75 07                	jne    800ccd <strncmp+0x38>
		return 0;
  800cc6:	b8 00 00 00 00       	mov    $0x0,%eax
  800ccb:	eb 14                	jmp    800ce1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8a 00                	mov    (%eax),%al
  800cd2:	0f b6 d0             	movzbl %al,%edx
  800cd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	0f b6 c0             	movzbl %al,%eax
  800cdd:	29 c2                	sub    %eax,%edx
  800cdf:	89 d0                	mov    %edx,%eax
}
  800ce1:	5d                   	pop    %ebp
  800ce2:	c3                   	ret    

00800ce3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce3:	55                   	push   %ebp
  800ce4:	89 e5                	mov    %esp,%ebp
  800ce6:	83 ec 04             	sub    $0x4,%esp
  800ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cec:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cef:	eb 12                	jmp    800d03 <strchr+0x20>
		if (*s == c)
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cf9:	75 05                	jne    800d00 <strchr+0x1d>
			return (char *) s;
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	eb 11                	jmp    800d11 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d00:	ff 45 08             	incl   0x8(%ebp)
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	84 c0                	test   %al,%al
  800d0a:	75 e5                	jne    800cf1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d11:	c9                   	leave  
  800d12:	c3                   	ret    

00800d13 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 04             	sub    $0x4,%esp
  800d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1f:	eb 0d                	jmp    800d2e <strfind+0x1b>
		if (*s == c)
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d29:	74 0e                	je     800d39 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d2b:	ff 45 08             	incl   0x8(%ebp)
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	84 c0                	test   %al,%al
  800d35:	75 ea                	jne    800d21 <strfind+0xe>
  800d37:	eb 01                	jmp    800d3a <strfind+0x27>
		if (*s == c)
			break;
  800d39:	90                   	nop
	return (char *) s;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3d:	c9                   	leave  
  800d3e:	c3                   	ret    

00800d3f <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800d4b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800d4f:	76 63                	jbe    800db4 <memset+0x75>
		uint64 data_block = c;
  800d51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d54:	99                   	cltd   
  800d55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d58:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d61:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800d65:	c1 e0 08             	shl    $0x8,%eax
  800d68:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d6b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800d6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d74:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800d78:	c1 e0 10             	shl    $0x10,%eax
  800d7b:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d7e:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d87:	89 c2                	mov    %eax,%edx
  800d89:	b8 00 00 00 00       	mov    $0x0,%eax
  800d8e:	09 45 f0             	or     %eax,-0x10(%ebp)
  800d91:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800d94:	eb 18                	jmp    800dae <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800d96:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800d99:	8d 41 08             	lea    0x8(%ecx),%eax
  800d9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da5:	89 01                	mov    %eax,(%ecx)
  800da7:	89 51 04             	mov    %edx,0x4(%ecx)
  800daa:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800dae:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800db2:	77 e2                	ja     800d96 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800db4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db8:	74 23                	je     800ddd <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800dba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dc0:	eb 0e                	jmp    800dd0 <memset+0x91>
			*p8++ = (uint8)c;
  800dc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc5:	8d 50 01             	lea    0x1(%eax),%edx
  800dc8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dce:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800dd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd6:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd9:	85 c0                	test   %eax,%eax
  800ddb:	75 e5                	jne    800dc2 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de0:	c9                   	leave  
  800de1:	c3                   	ret    

00800de2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800de2:	55                   	push   %ebp
  800de3:	89 e5                	mov    %esp,%ebp
  800de5:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800df4:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800df8:	76 24                	jbe    800e1e <memcpy+0x3c>
		while(n >= 8){
  800dfa:	eb 1c                	jmp    800e18 <memcpy+0x36>
			*d64 = *s64;
  800dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dff:	8b 50 04             	mov    0x4(%eax),%edx
  800e02:	8b 00                	mov    (%eax),%eax
  800e04:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800e07:	89 01                	mov    %eax,(%ecx)
  800e09:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800e0c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800e10:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800e14:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800e18:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800e1c:	77 de                	ja     800dfc <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800e1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e22:	74 31                	je     800e55 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800e24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e27:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800e30:	eb 16                	jmp    800e48 <memcpy+0x66>
			*d8++ = *s8++;
  800e32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e35:	8d 50 01             	lea    0x1(%eax),%edx
  800e38:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800e3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e41:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800e44:	8a 12                	mov    (%edx),%dl
  800e46:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800e48:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4e:	89 55 10             	mov    %edx,0x10(%ebp)
  800e51:	85 c0                	test   %eax,%eax
  800e53:	75 dd                	jne    800e32 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e58:	c9                   	leave  
  800e59:	c3                   	ret    

00800e5a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e72:	73 50                	jae    800ec4 <memmove+0x6a>
  800e74:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e77:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7a:	01 d0                	add    %edx,%eax
  800e7c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e7f:	76 43                	jbe    800ec4 <memmove+0x6a>
		s += n;
  800e81:	8b 45 10             	mov    0x10(%ebp),%eax
  800e84:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e87:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e8d:	eb 10                	jmp    800e9f <memmove+0x45>
			*--d = *--s;
  800e8f:	ff 4d f8             	decl   -0x8(%ebp)
  800e92:	ff 4d fc             	decl   -0x4(%ebp)
  800e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e98:	8a 10                	mov    (%eax),%dl
  800e9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea8:	85 c0                	test   %eax,%eax
  800eaa:	75 e3                	jne    800e8f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800eac:	eb 23                	jmp    800ed1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800eae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb1:	8d 50 01             	lea    0x1(%eax),%edx
  800eb4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eba:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ebd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ec0:	8a 12                	mov    (%edx),%dl
  800ec2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ec4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eca:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecd:	85 c0                	test   %eax,%eax
  800ecf:	75 dd                	jne    800eae <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed4:	c9                   	leave  
  800ed5:	c3                   	ret    

00800ed6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ed6:	55                   	push   %ebp
  800ed7:	89 e5                	mov    %esp,%ebp
  800ed9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ee8:	eb 2a                	jmp    800f14 <memcmp+0x3e>
		if (*s1 != *s2)
  800eea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eed:	8a 10                	mov    (%eax),%dl
  800eef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef2:	8a 00                	mov    (%eax),%al
  800ef4:	38 c2                	cmp    %al,%dl
  800ef6:	74 16                	je     800f0e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	0f b6 d0             	movzbl %al,%edx
  800f00:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	0f b6 c0             	movzbl %al,%eax
  800f08:	29 c2                	sub    %eax,%edx
  800f0a:	89 d0                	mov    %edx,%eax
  800f0c:	eb 18                	jmp    800f26 <memcmp+0x50>
		s1++, s2++;
  800f0e:	ff 45 fc             	incl   -0x4(%ebp)
  800f11:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f14:	8b 45 10             	mov    0x10(%ebp),%eax
  800f17:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f1a:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1d:	85 c0                	test   %eax,%eax
  800f1f:	75 c9                	jne    800eea <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f26:	c9                   	leave  
  800f27:	c3                   	ret    

00800f28 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f28:	55                   	push   %ebp
  800f29:	89 e5                	mov    %esp,%ebp
  800f2b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f2e:	8b 55 08             	mov    0x8(%ebp),%edx
  800f31:	8b 45 10             	mov    0x10(%ebp),%eax
  800f34:	01 d0                	add    %edx,%eax
  800f36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f39:	eb 15                	jmp    800f50 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	0f b6 d0             	movzbl %al,%edx
  800f43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f46:	0f b6 c0             	movzbl %al,%eax
  800f49:	39 c2                	cmp    %eax,%edx
  800f4b:	74 0d                	je     800f5a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f4d:	ff 45 08             	incl   0x8(%ebp)
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f56:	72 e3                	jb     800f3b <memfind+0x13>
  800f58:	eb 01                	jmp    800f5b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f5a:	90                   	nop
	return (void *) s;
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5e:	c9                   	leave  
  800f5f:	c3                   	ret    

00800f60 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f60:	55                   	push   %ebp
  800f61:	89 e5                	mov    %esp,%ebp
  800f63:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f66:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f6d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f74:	eb 03                	jmp    800f79 <strtol+0x19>
		s++;
  800f76:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	3c 20                	cmp    $0x20,%al
  800f80:	74 f4                	je     800f76 <strtol+0x16>
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	3c 09                	cmp    $0x9,%al
  800f89:	74 eb                	je     800f76 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	3c 2b                	cmp    $0x2b,%al
  800f92:	75 05                	jne    800f99 <strtol+0x39>
		s++;
  800f94:	ff 45 08             	incl   0x8(%ebp)
  800f97:	eb 13                	jmp    800fac <strtol+0x4c>
	else if (*s == '-')
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3c 2d                	cmp    $0x2d,%al
  800fa0:	75 0a                	jne    800fac <strtol+0x4c>
		s++, neg = 1;
  800fa2:	ff 45 08             	incl   0x8(%ebp)
  800fa5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb0:	74 06                	je     800fb8 <strtol+0x58>
  800fb2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fb6:	75 20                	jne    800fd8 <strtol+0x78>
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 30                	cmp    $0x30,%al
  800fbf:	75 17                	jne    800fd8 <strtol+0x78>
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	40                   	inc    %eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	3c 78                	cmp    $0x78,%al
  800fc9:	75 0d                	jne    800fd8 <strtol+0x78>
		s += 2, base = 16;
  800fcb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fcf:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fd6:	eb 28                	jmp    801000 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fdc:	75 15                	jne    800ff3 <strtol+0x93>
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	8a 00                	mov    (%eax),%al
  800fe3:	3c 30                	cmp    $0x30,%al
  800fe5:	75 0c                	jne    800ff3 <strtol+0x93>
		s++, base = 8;
  800fe7:	ff 45 08             	incl   0x8(%ebp)
  800fea:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ff1:	eb 0d                	jmp    801000 <strtol+0xa0>
	else if (base == 0)
  800ff3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff7:	75 07                	jne    801000 <strtol+0xa0>
		base = 10;
  800ff9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	3c 2f                	cmp    $0x2f,%al
  801007:	7e 19                	jle    801022 <strtol+0xc2>
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	8a 00                	mov    (%eax),%al
  80100e:	3c 39                	cmp    $0x39,%al
  801010:	7f 10                	jg     801022 <strtol+0xc2>
			dig = *s - '0';
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8a 00                	mov    (%eax),%al
  801017:	0f be c0             	movsbl %al,%eax
  80101a:	83 e8 30             	sub    $0x30,%eax
  80101d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801020:	eb 42                	jmp    801064 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	3c 60                	cmp    $0x60,%al
  801029:	7e 19                	jle    801044 <strtol+0xe4>
  80102b:	8b 45 08             	mov    0x8(%ebp),%eax
  80102e:	8a 00                	mov    (%eax),%al
  801030:	3c 7a                	cmp    $0x7a,%al
  801032:	7f 10                	jg     801044 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	0f be c0             	movsbl %al,%eax
  80103c:	83 e8 57             	sub    $0x57,%eax
  80103f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801042:	eb 20                	jmp    801064 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	3c 40                	cmp    $0x40,%al
  80104b:	7e 39                	jle    801086 <strtol+0x126>
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	3c 5a                	cmp    $0x5a,%al
  801054:	7f 30                	jg     801086 <strtol+0x126>
			dig = *s - 'A' + 10;
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	8a 00                	mov    (%eax),%al
  80105b:	0f be c0             	movsbl %al,%eax
  80105e:	83 e8 37             	sub    $0x37,%eax
  801061:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801064:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801067:	3b 45 10             	cmp    0x10(%ebp),%eax
  80106a:	7d 19                	jge    801085 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80106c:	ff 45 08             	incl   0x8(%ebp)
  80106f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801072:	0f af 45 10          	imul   0x10(%ebp),%eax
  801076:	89 c2                	mov    %eax,%edx
  801078:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80107b:	01 d0                	add    %edx,%eax
  80107d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801080:	e9 7b ff ff ff       	jmp    801000 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801085:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801086:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80108a:	74 08                	je     801094 <strtol+0x134>
		*endptr = (char *) s;
  80108c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108f:	8b 55 08             	mov    0x8(%ebp),%edx
  801092:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801094:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801098:	74 07                	je     8010a1 <strtol+0x141>
  80109a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109d:	f7 d8                	neg    %eax
  80109f:	eb 03                	jmp    8010a4 <strtol+0x144>
  8010a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a4:	c9                   	leave  
  8010a5:	c3                   	ret    

008010a6 <ltostr>:

void
ltostr(long value, char *str)
{
  8010a6:	55                   	push   %ebp
  8010a7:	89 e5                	mov    %esp,%ebp
  8010a9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010b3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010be:	79 13                	jns    8010d3 <ltostr+0x2d>
	{
		neg = 1;
  8010c0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ca:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010cd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010d0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010db:	99                   	cltd   
  8010dc:	f7 f9                	idiv   %ecx
  8010de:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e4:	8d 50 01             	lea    0x1(%eax),%edx
  8010e7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010ea:	89 c2                	mov    %eax,%edx
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	01 d0                	add    %edx,%eax
  8010f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010f4:	83 c2 30             	add    $0x30,%edx
  8010f7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010fc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801101:	f7 e9                	imul   %ecx
  801103:	c1 fa 02             	sar    $0x2,%edx
  801106:	89 c8                	mov    %ecx,%eax
  801108:	c1 f8 1f             	sar    $0x1f,%eax
  80110b:	29 c2                	sub    %eax,%edx
  80110d:	89 d0                	mov    %edx,%eax
  80110f:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801112:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801116:	75 bb                	jne    8010d3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801118:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80111f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801122:	48                   	dec    %eax
  801123:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801126:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80112a:	74 3d                	je     801169 <ltostr+0xc3>
		start = 1 ;
  80112c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801133:	eb 34                	jmp    801169 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801135:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801138:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113b:	01 d0                	add    %edx,%eax
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801142:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801145:	8b 45 0c             	mov    0xc(%ebp),%eax
  801148:	01 c2                	add    %eax,%edx
  80114a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80114d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801150:	01 c8                	add    %ecx,%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801156:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801159:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115c:	01 c2                	add    %eax,%edx
  80115e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801161:	88 02                	mov    %al,(%edx)
		start++ ;
  801163:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801166:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801169:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80116f:	7c c4                	jl     801135 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801171:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	01 d0                	add    %edx,%eax
  801179:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80117c:	90                   	nop
  80117d:	c9                   	leave  
  80117e:	c3                   	ret    

0080117f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
  801182:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801185:	ff 75 08             	pushl  0x8(%ebp)
  801188:	e8 c4 f9 ff ff       	call   800b51 <strlen>
  80118d:	83 c4 04             	add    $0x4,%esp
  801190:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801193:	ff 75 0c             	pushl  0xc(%ebp)
  801196:	e8 b6 f9 ff ff       	call   800b51 <strlen>
  80119b:	83 c4 04             	add    $0x4,%esp
  80119e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011af:	eb 17                	jmp    8011c8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b7:	01 c2                	add    %eax,%edx
  8011b9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	01 c8                	add    %ecx,%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011c5:	ff 45 fc             	incl   -0x4(%ebp)
  8011c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011ce:	7c e1                	jl     8011b1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011de:	eb 1f                	jmp    8011ff <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e3:	8d 50 01             	lea    0x1(%eax),%edx
  8011e6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011e9:	89 c2                	mov    %eax,%edx
  8011eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ee:	01 c2                	add    %eax,%edx
  8011f0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f6:	01 c8                	add    %ecx,%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011fc:	ff 45 f8             	incl   -0x8(%ebp)
  8011ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801202:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801205:	7c d9                	jl     8011e0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801207:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80120a:	8b 45 10             	mov    0x10(%ebp),%eax
  80120d:	01 d0                	add    %edx,%eax
  80120f:	c6 00 00             	movb   $0x0,(%eax)
}
  801212:	90                   	nop
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801218:	8b 45 14             	mov    0x14(%ebp),%eax
  80121b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	8b 00                	mov    (%eax),%eax
  801226:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122d:	8b 45 10             	mov    0x10(%ebp),%eax
  801230:	01 d0                	add    %edx,%eax
  801232:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801238:	eb 0c                	jmp    801246 <strsplit+0x31>
			*string++ = 0;
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8d 50 01             	lea    0x1(%eax),%edx
  801240:	89 55 08             	mov    %edx,0x8(%ebp)
  801243:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	84 c0                	test   %al,%al
  80124d:	74 18                	je     801267 <strsplit+0x52>
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	0f be c0             	movsbl %al,%eax
  801257:	50                   	push   %eax
  801258:	ff 75 0c             	pushl  0xc(%ebp)
  80125b:	e8 83 fa ff ff       	call   800ce3 <strchr>
  801260:	83 c4 08             	add    $0x8,%esp
  801263:	85 c0                	test   %eax,%eax
  801265:	75 d3                	jne    80123a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	84 c0                	test   %al,%al
  80126e:	74 5a                	je     8012ca <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801270:	8b 45 14             	mov    0x14(%ebp),%eax
  801273:	8b 00                	mov    (%eax),%eax
  801275:	83 f8 0f             	cmp    $0xf,%eax
  801278:	75 07                	jne    801281 <strsplit+0x6c>
		{
			return 0;
  80127a:	b8 00 00 00 00       	mov    $0x0,%eax
  80127f:	eb 66                	jmp    8012e7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801281:	8b 45 14             	mov    0x14(%ebp),%eax
  801284:	8b 00                	mov    (%eax),%eax
  801286:	8d 48 01             	lea    0x1(%eax),%ecx
  801289:	8b 55 14             	mov    0x14(%ebp),%edx
  80128c:	89 0a                	mov    %ecx,(%edx)
  80128e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801295:	8b 45 10             	mov    0x10(%ebp),%eax
  801298:	01 c2                	add    %eax,%edx
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80129f:	eb 03                	jmp    8012a4 <strsplit+0x8f>
			string++;
  8012a1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8a 00                	mov    (%eax),%al
  8012a9:	84 c0                	test   %al,%al
  8012ab:	74 8b                	je     801238 <strsplit+0x23>
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	0f be c0             	movsbl %al,%eax
  8012b5:	50                   	push   %eax
  8012b6:	ff 75 0c             	pushl  0xc(%ebp)
  8012b9:	e8 25 fa ff ff       	call   800ce3 <strchr>
  8012be:	83 c4 08             	add    $0x8,%esp
  8012c1:	85 c0                	test   %eax,%eax
  8012c3:	74 dc                	je     8012a1 <strsplit+0x8c>
			string++;
	}
  8012c5:	e9 6e ff ff ff       	jmp    801238 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012ca:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ce:	8b 00                	mov    (%eax),%eax
  8012d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012da:	01 d0                	add    %edx,%eax
  8012dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012e2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
  8012ec:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8012ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8012f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012fc:	eb 4a                	jmp    801348 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8012fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	01 c2                	add    %eax,%edx
  801306:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130c:	01 c8                	add    %ecx,%eax
  80130e:	8a 00                	mov    (%eax),%al
  801310:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801312:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801315:	8b 45 0c             	mov    0xc(%ebp),%eax
  801318:	01 d0                	add    %edx,%eax
  80131a:	8a 00                	mov    (%eax),%al
  80131c:	3c 40                	cmp    $0x40,%al
  80131e:	7e 25                	jle    801345 <str2lower+0x5c>
  801320:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801323:	8b 45 0c             	mov    0xc(%ebp),%eax
  801326:	01 d0                	add    %edx,%eax
  801328:	8a 00                	mov    (%eax),%al
  80132a:	3c 5a                	cmp    $0x5a,%al
  80132c:	7f 17                	jg     801345 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80132e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	01 d0                	add    %edx,%eax
  801336:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801339:	8b 55 08             	mov    0x8(%ebp),%edx
  80133c:	01 ca                	add    %ecx,%edx
  80133e:	8a 12                	mov    (%edx),%dl
  801340:	83 c2 20             	add    $0x20,%edx
  801343:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801345:	ff 45 fc             	incl   -0x4(%ebp)
  801348:	ff 75 0c             	pushl  0xc(%ebp)
  80134b:	e8 01 f8 ff ff       	call   800b51 <strlen>
  801350:	83 c4 04             	add    $0x4,%esp
  801353:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801356:	7f a6                	jg     8012fe <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801358:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801363:	a1 08 30 80 00       	mov    0x803008,%eax
  801368:	85 c0                	test   %eax,%eax
  80136a:	74 2d                	je     801399 <uheap_init+0x3c>
	{
		buddy_init();
  80136c:	e8 87 06 00 00       	call   8019f8 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801371:	e8 31 05 00 00       	call   8018a7 <sys_get_uheap_strategy>
  801376:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  80137b:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  801382:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801385:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  80138c:	00 00 80 
		__firstTimeFlag = 0;
  80138f:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  801396:	00 00 00 
	}
}
  801399:	90                   	nop
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
  80139f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  8013a2:	83 ec 04             	sub    $0x4,%esp
  8013a5:	68 28 25 80 00       	push   $0x802528
  8013aa:	6a 25                	push   $0x25
  8013ac:	68 59 25 80 00       	push   $0x802559
  8013b1:	e8 34 07 00 00       	call   801aea <_panic>

008013b6 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
  8013b9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  8013bc:	83 ec 04             	sub    $0x4,%esp
  8013bf:	68 68 25 80 00       	push   $0x802568
  8013c4:	6a 2f                	push   $0x2f
  8013c6:	68 59 25 80 00       	push   $0x802559
  8013cb:	e8 1a 07 00 00       	call   801aea <_panic>

008013d0 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
  8013d3:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8013d6:	e8 82 ff ff ff       	call   80135d <uheap_init>
	if (size == 0) return NULL ;
  8013db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013df:	75 07                	jne    8013e8 <malloc+0x18>
  8013e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e6:	eb 14                	jmp    8013fc <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  8013e8:	83 ec 04             	sub    $0x4,%esp
  8013eb:	68 9c 25 80 00       	push   $0x80259c
  8013f0:	6a 43                	push   $0x43
  8013f2:	68 59 25 80 00       	push   $0x802559
  8013f7:	e8 ee 06 00 00       	call   801aea <_panic>
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
  801401:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801404:	83 ec 04             	sub    $0x4,%esp
  801407:	68 c4 25 80 00       	push   $0x8025c4
  80140c:	6a 4e                	push   $0x4e
  80140e:	68 59 25 80 00       	push   $0x802559
  801413:	e8 d2 06 00 00       	call   801aea <_panic>

00801418 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 18             	sub    $0x18,%esp
  80141e:	8b 45 10             	mov    0x10(%ebp),%eax
  801421:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801424:	e8 34 ff ff ff       	call   80135d <uheap_init>
	if (size == 0) return NULL ;
  801429:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80142d:	75 07                	jne    801436 <smalloc+0x1e>
  80142f:	b8 00 00 00 00       	mov    $0x0,%eax
  801434:	eb 14                	jmp    80144a <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801436:	83 ec 04             	sub    $0x4,%esp
  801439:	68 e8 25 80 00       	push   $0x8025e8
  80143e:	6a 5f                	push   $0x5f
  801440:	68 59 25 80 00       	push   $0x802559
  801445:	e8 a0 06 00 00       	call   801aea <_panic>
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
  80144f:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801452:	e8 06 ff ff ff       	call   80135d <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801457:	83 ec 04             	sub    $0x4,%esp
  80145a:	68 10 26 80 00       	push   $0x802610
  80145f:	6a 6f                	push   $0x6f
  801461:	68 59 25 80 00       	push   $0x802559
  801466:	e8 7f 06 00 00       	call   801aea <_panic>

0080146b <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  80146b:	55                   	push   %ebp
  80146c:	89 e5                	mov    %esp,%ebp
  80146e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801471:	83 ec 04             	sub    $0x4,%esp
  801474:	68 34 26 80 00       	push   $0x802634
  801479:	6a 7e                	push   $0x7e
  80147b:	68 59 25 80 00       	push   $0x802559
  801480:	e8 65 06 00 00       	call   801aea <_panic>

00801485 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
  801488:	57                   	push   %edi
  801489:	56                   	push   %esi
  80148a:	53                   	push   %ebx
  80148b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8b 55 0c             	mov    0xc(%ebp),%edx
  801494:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801497:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80149a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80149d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014a0:	cd 30                	int    $0x30
  8014a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014a8:	83 c4 10             	add    $0x10,%esp
  8014ab:	5b                   	pop    %ebx
  8014ac:	5e                   	pop    %esi
  8014ad:	5f                   	pop    %edi
  8014ae:	5d                   	pop    %ebp
  8014af:	c3                   	ret    

008014b0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
  8014b3:	83 ec 04             	sub    $0x4,%esp
  8014b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8014bc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014bf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	6a 00                	push   $0x0
  8014c8:	51                   	push   %ecx
  8014c9:	52                   	push   %edx
  8014ca:	ff 75 0c             	pushl  0xc(%ebp)
  8014cd:	50                   	push   %eax
  8014ce:	6a 00                	push   $0x0
  8014d0:	e8 b0 ff ff ff       	call   801485 <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
}
  8014d8:	90                   	nop
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <sys_cgetc>:

int
sys_cgetc(void)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 02                	push   $0x2
  8014ea:	e8 96 ff ff ff       	call   801485 <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
}
  8014f2:	c9                   	leave  
  8014f3:	c3                   	ret    

008014f4 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 03                	push   $0x3
  801503:	e8 7d ff ff ff       	call   801485 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	90                   	nop
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 04                	push   $0x4
  80151d:	e8 63 ff ff ff       	call   801485 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	90                   	nop
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80152b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	52                   	push   %edx
  801538:	50                   	push   %eax
  801539:	6a 08                	push   $0x8
  80153b:	e8 45 ff ff ff       	call   801485 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
  801548:	56                   	push   %esi
  801549:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80154a:	8b 75 18             	mov    0x18(%ebp),%esi
  80154d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801550:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801553:	8b 55 0c             	mov    0xc(%ebp),%edx
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
  801559:	56                   	push   %esi
  80155a:	53                   	push   %ebx
  80155b:	51                   	push   %ecx
  80155c:	52                   	push   %edx
  80155d:	50                   	push   %eax
  80155e:	6a 09                	push   $0x9
  801560:	e8 20 ff ff ff       	call   801485 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
}
  801568:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80156b:	5b                   	pop    %ebx
  80156c:	5e                   	pop    %esi
  80156d:	5d                   	pop    %ebp
  80156e:	c3                   	ret    

0080156f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	ff 75 08             	pushl  0x8(%ebp)
  80157d:	6a 0a                	push   $0xa
  80157f:	e8 01 ff ff ff       	call   801485 <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	ff 75 0c             	pushl  0xc(%ebp)
  801595:	ff 75 08             	pushl  0x8(%ebp)
  801598:	6a 0b                	push   $0xb
  80159a:	e8 e6 fe ff ff       	call   801485 <syscall>
  80159f:	83 c4 18             	add    $0x18,%esp
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 0c                	push   $0xc
  8015b3:	e8 cd fe ff ff       	call   801485 <syscall>
  8015b8:	83 c4 18             	add    $0x18,%esp
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 0d                	push   $0xd
  8015cc:	e8 b4 fe ff ff       	call   801485 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 0e                	push   $0xe
  8015e5:	e8 9b fe ff ff       	call   801485 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 0f                	push   $0xf
  8015fe:	e8 82 fe ff ff       	call   801485 <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	ff 75 08             	pushl  0x8(%ebp)
  801616:	6a 10                	push   $0x10
  801618:	e8 68 fe ff ff       	call   801485 <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 11                	push   $0x11
  801631:	e8 4f fe ff ff       	call   801485 <syscall>
  801636:	83 c4 18             	add    $0x18,%esp
}
  801639:	90                   	nop
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <sys_cputc>:

void
sys_cputc(const char c)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
  80163f:	83 ec 04             	sub    $0x4,%esp
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801648:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	50                   	push   %eax
  801655:	6a 01                	push   $0x1
  801657:	e8 29 fe ff ff       	call   801485 <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 14                	push   $0x14
  801671:	e8 0f fe ff ff       	call   801485 <syscall>
  801676:	83 c4 18             	add    $0x18,%esp
}
  801679:	90                   	nop
  80167a:	c9                   	leave  
  80167b:	c3                   	ret    

0080167c <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80167c:	55                   	push   %ebp
  80167d:	89 e5                	mov    %esp,%ebp
  80167f:	83 ec 04             	sub    $0x4,%esp
  801682:	8b 45 10             	mov    0x10(%ebp),%eax
  801685:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801688:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80168b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	6a 00                	push   $0x0
  801694:	51                   	push   %ecx
  801695:	52                   	push   %edx
  801696:	ff 75 0c             	pushl  0xc(%ebp)
  801699:	50                   	push   %eax
  80169a:	6a 15                	push   $0x15
  80169c:	e8 e4 fd ff ff       	call   801485 <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
}
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8016a9:	8b 55 10             	mov    0x10(%ebp),%edx
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	52                   	push   %edx
  8016b4:	50                   	push   %eax
  8016b5:	ff 75 08             	pushl  0x8(%ebp)
  8016b8:	6a 16                	push   $0x16
  8016ba:	e8 c6 fd ff ff       	call   801485 <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
}
  8016c2:	c9                   	leave  
  8016c3:	c3                   	ret    

008016c4 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016c4:	55                   	push   %ebp
  8016c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	52                   	push   %edx
  8016d4:	50                   	push   %eax
  8016d5:	6a 17                	push   $0x17
  8016d7:	e8 a9 fd ff ff       	call   801485 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	52                   	push   %edx
  8016f1:	50                   	push   %eax
  8016f2:	6a 18                	push   $0x18
  8016f4:	e8 8c fd ff ff       	call   801485 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	6a 00                	push   $0x0
  801706:	ff 75 14             	pushl  0x14(%ebp)
  801709:	ff 75 10             	pushl  0x10(%ebp)
  80170c:	ff 75 0c             	pushl  0xc(%ebp)
  80170f:	50                   	push   %eax
  801710:	6a 19                	push   $0x19
  801712:	e8 6e fd ff ff       	call   801485 <syscall>
  801717:	83 c4 18             	add    $0x18,%esp
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <sys_run_env>:

void sys_run_env(int32 envId)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80171f:	8b 45 08             	mov    0x8(%ebp),%eax
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	50                   	push   %eax
  80172b:	6a 1a                	push   $0x1a
  80172d:	e8 53 fd ff ff       	call   801485 <syscall>
  801732:	83 c4 18             	add    $0x18,%esp
}
  801735:	90                   	nop
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	50                   	push   %eax
  801747:	6a 1b                	push   $0x1b
  801749:	e8 37 fd ff ff       	call   801485 <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 05                	push   $0x5
  801762:	e8 1e fd ff ff       	call   801485 <syscall>
  801767:	83 c4 18             	add    $0x18,%esp
}
  80176a:	c9                   	leave  
  80176b:	c3                   	ret    

0080176c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 06                	push   $0x6
  80177b:	e8 05 fd ff ff       	call   801485 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 07                	push   $0x7
  801794:	e8 ec fc ff ff       	call   801485 <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
}
  80179c:	c9                   	leave  
  80179d:	c3                   	ret    

0080179e <sys_exit_env>:


void sys_exit_env(void)
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 1c                	push   $0x1c
  8017ad:	e8 d3 fc ff ff       	call   801485 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	90                   	nop
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	ff 75 10             	pushl  0x10(%ebp)
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	6a 13                	push   $0x13
  8017ca:	e8 b6 fc ff ff       	call   801485 <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d2:	90                   	nop
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 1e                	push   $0x1e
  8017e4:	e8 9c fc ff ff       	call   801485 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
}
  8017ec:	c9                   	leave  
  8017ed:	c3                   	ret    

008017ee <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8017ee:	55                   	push   %ebp
  8017ef:	89 e5                	mov    %esp,%ebp
  8017f1:	83 ec 04             	sub    $0x4,%esp
  8017f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017fa:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	50                   	push   %eax
  801807:	6a 1f                	push   $0x1f
  801809:	e8 77 fc ff ff       	call   801485 <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
	return ;
  801811:	90                   	nop
}
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <rsttst>:
void rsttst()
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 21                	push   $0x21
  801823:	e8 5d fc ff ff       	call   801485 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
	return ;
  80182b:	90                   	nop
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 04             	sub    $0x4,%esp
  801834:	8b 45 14             	mov    0x14(%ebp),%eax
  801837:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80183a:	8b 55 18             	mov    0x18(%ebp),%edx
  80183d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801841:	52                   	push   %edx
  801842:	50                   	push   %eax
  801843:	ff 75 10             	pushl  0x10(%ebp)
  801846:	ff 75 0c             	pushl  0xc(%ebp)
  801849:	ff 75 08             	pushl  0x8(%ebp)
  80184c:	6a 20                	push   $0x20
  80184e:	e8 32 fc ff ff       	call   801485 <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
	return ;
  801856:	90                   	nop
}
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <chktst>:
void chktst(uint32 n)
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	ff 75 08             	pushl  0x8(%ebp)
  801867:	6a 22                	push   $0x22
  801869:	e8 17 fc ff ff       	call   801485 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
	return ;
  801871:	90                   	nop
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <inctst>:

void inctst()
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 23                	push   $0x23
  801883:	e8 fd fb ff ff       	call   801485 <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
	return ;
  80188b:	90                   	nop
}
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <gettst>:
uint32 gettst()
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 24                	push   $0x24
  80189d:	e8 e3 fb ff ff       	call   801485 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 25                	push   $0x25
  8018b6:	e8 ca fb ff ff       	call   801485 <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
  8018be:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018c3:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8018cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d0:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	ff 75 08             	pushl  0x8(%ebp)
  8018e0:	6a 26                	push   $0x26
  8018e2:	e8 9e fb ff ff       	call   801485 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ea:	90                   	nop
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
  8018f0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018f1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018f4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	6a 00                	push   $0x0
  8018ff:	53                   	push   %ebx
  801900:	51                   	push   %ecx
  801901:	52                   	push   %edx
  801902:	50                   	push   %eax
  801903:	6a 27                	push   $0x27
  801905:	e8 7b fb ff ff       	call   801485 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
}
  80190d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801915:	8b 55 0c             	mov    0xc(%ebp),%edx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	52                   	push   %edx
  801922:	50                   	push   %eax
  801923:	6a 28                	push   $0x28
  801925:	e8 5b fb ff ff       	call   801485 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801932:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801935:	8b 55 0c             	mov    0xc(%ebp),%edx
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	6a 00                	push   $0x0
  80193d:	51                   	push   %ecx
  80193e:	ff 75 10             	pushl  0x10(%ebp)
  801941:	52                   	push   %edx
  801942:	50                   	push   %eax
  801943:	6a 29                	push   $0x29
  801945:	e8 3b fb ff ff       	call   801485 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	ff 75 10             	pushl  0x10(%ebp)
  801959:	ff 75 0c             	pushl  0xc(%ebp)
  80195c:	ff 75 08             	pushl  0x8(%ebp)
  80195f:	6a 12                	push   $0x12
  801961:	e8 1f fb ff ff       	call   801485 <syscall>
  801966:	83 c4 18             	add    $0x18,%esp
	return ;
  801969:	90                   	nop
}
  80196a:	c9                   	leave  
  80196b:	c3                   	ret    

0080196c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  80196c:	55                   	push   %ebp
  80196d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80196f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	52                   	push   %edx
  80197c:	50                   	push   %eax
  80197d:	6a 2a                	push   $0x2a
  80197f:	e8 01 fb ff ff       	call   801485 <syscall>
  801984:	83 c4 18             	add    $0x18,%esp
	return;
  801987:	90                   	nop
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 2b                	push   $0x2b
  801999:	e8 e7 fa ff ff       	call   801485 <syscall>
  80199e:	83 c4 18             	add    $0x18,%esp
}
  8019a1:	c9                   	leave  
  8019a2:	c3                   	ret    

008019a3 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
  8019a6:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8019a9:	83 ec 04             	sub    $0x4,%esp
  8019ac:	68 58 26 80 00       	push   $0x802658
  8019b1:	68 0a 01 00 00       	push   $0x10a
  8019b6:	68 68 26 80 00       	push   $0x802668
  8019bb:	e8 2a 01 00 00       	call   801aea <_panic>

008019c0 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	ff 75 0c             	pushl  0xc(%ebp)
  8019cc:	ff 75 08             	pushl  0x8(%ebp)
  8019cf:	6a 33                	push   $0x33
  8019d1:	e8 af fa ff ff       	call   801485 <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
	return;
  8019d9:	90                   	nop
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	ff 75 0c             	pushl  0xc(%ebp)
  8019e8:	ff 75 08             	pushl  0x8(%ebp)
  8019eb:	6a 34                	push   $0x34
  8019ed:	e8 93 fa ff ff       	call   801485 <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f5:	90                   	nop
}
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
  8019fb:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8019fe:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801a05:	eb 36                	jmp    801a3d <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801a07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0a:	c1 e0 04             	shl    $0x4,%eax
  801a0d:	05 60 30 80 00       	add    $0x803060,%eax
  801a12:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801a18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1b:	c1 e0 04             	shl    $0x4,%eax
  801a1e:	05 64 30 80 00       	add    $0x803064,%eax
  801a23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a2c:	c1 e0 04             	shl    $0x4,%eax
  801a2f:	05 6c 30 80 00       	add    $0x80306c,%eax
  801a34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801a3a:	ff 45 fc             	incl   -0x4(%ebp)
  801a3d:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801a41:	7e c4                	jle    801a07 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801a43:	90                   	nop
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801a4c:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801a53:	eb 24                	jmp    801a79 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a58:	c1 e0 04             	shl    $0x4,%eax
  801a5b:	05 6c 30 80 00       	add    $0x80306c,%eax
  801a60:	8b 00                	mov    (%eax),%eax
  801a62:	83 ec 04             	sub    $0x4,%esp
  801a65:	50                   	push   %eax
  801a66:	ff 75 f4             	pushl  -0xc(%ebp)
  801a69:	68 78 26 80 00       	push   $0x802678
  801a6e:	e8 05 ea ff ff       	call   800478 <cprintf>
  801a73:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801a76:	ff 45 f4             	incl   -0xc(%ebp)
  801a79:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801a7d:	7e d6                	jle    801a55 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801a7f:	90                   	nop
  801a80:	c9                   	leave  
  801a81:	c3                   	ret    

00801a82 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801a82:	55                   	push   %ebp
  801a83:	89 e5                	mov    %esp,%ebp
  801a85:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801a88:	83 ec 04             	sub    $0x4,%esp
  801a8b:	68 88 26 80 00       	push   $0x802688
  801a90:	6a 33                	push   $0x33
  801a92:	68 a9 26 80 00       	push   $0x8026a9
  801a97:	e8 4e 00 00 00       	call   801aea <_panic>

00801a9c <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
  801a9f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801aa2:	83 ec 04             	sub    $0x4,%esp
  801aa5:	68 c1 26 80 00       	push   $0x8026c1
  801aaa:	6a 3e                	push   $0x3e
  801aac:	68 a9 26 80 00       	push   $0x8026a9
  801ab1:	e8 34 00 00 00       	call   801aea <_panic>

00801ab6 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
  801ab9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801abc:	83 ec 04             	sub    $0x4,%esp
  801abf:	68 df 26 80 00       	push   $0x8026df
  801ac4:	6a 49                	push   $0x49
  801ac6:	68 a9 26 80 00       	push   $0x8026a9
  801acb:	e8 1a 00 00 00       	call   801aea <_panic>

00801ad0 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
  801ad3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801ad6:	83 ec 04             	sub    $0x4,%esp
  801ad9:	68 fc 26 80 00       	push   $0x8026fc
  801ade:	6a 58                	push   $0x58
  801ae0:	68 a9 26 80 00       	push   $0x8026a9
  801ae5:	e8 00 00 00 00       	call   801aea <_panic>

00801aea <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
  801aed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801af0:	8d 45 10             	lea    0x10(%ebp),%eax
  801af3:	83 c0 04             	add    $0x4,%eax
  801af6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801af9:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801afe:	85 c0                	test   %eax,%eax
  801b00:	74 16                	je     801b18 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b02:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b07:	83 ec 08             	sub    $0x8,%esp
  801b0a:	50                   	push   %eax
  801b0b:	68 20 27 80 00       	push   $0x802720
  801b10:	e8 63 e9 ff ff       	call   800478 <cprintf>
  801b15:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801b18:	a1 04 30 80 00       	mov    0x803004,%eax
  801b1d:	83 ec 0c             	sub    $0xc,%esp
  801b20:	ff 75 0c             	pushl  0xc(%ebp)
  801b23:	ff 75 08             	pushl  0x8(%ebp)
  801b26:	50                   	push   %eax
  801b27:	68 28 27 80 00       	push   $0x802728
  801b2c:	6a 74                	push   $0x74
  801b2e:	e8 72 e9 ff ff       	call   8004a5 <cprintf_colored>
  801b33:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801b36:	8b 45 10             	mov    0x10(%ebp),%eax
  801b39:	83 ec 08             	sub    $0x8,%esp
  801b3c:	ff 75 f4             	pushl  -0xc(%ebp)
  801b3f:	50                   	push   %eax
  801b40:	e8 c4 e8 ff ff       	call   800409 <vcprintf>
  801b45:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b48:	83 ec 08             	sub    $0x8,%esp
  801b4b:	6a 00                	push   $0x0
  801b4d:	68 50 27 80 00       	push   $0x802750
  801b52:	e8 b2 e8 ff ff       	call   800409 <vcprintf>
  801b57:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b5a:	e8 2b e8 ff ff       	call   80038a <exit>

	// should not return here
	while (1) ;
  801b5f:	eb fe                	jmp    801b5f <_panic+0x75>

00801b61 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
  801b64:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b67:	a1 20 30 80 00       	mov    0x803020,%eax
  801b6c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801b72:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b75:	39 c2                	cmp    %eax,%edx
  801b77:	74 14                	je     801b8d <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b79:	83 ec 04             	sub    $0x4,%esp
  801b7c:	68 54 27 80 00       	push   $0x802754
  801b81:	6a 26                	push   $0x26
  801b83:	68 a0 27 80 00       	push   $0x8027a0
  801b88:	e8 5d ff ff ff       	call   801aea <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b94:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b9b:	e9 c5 00 00 00       	jmp    801c65 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801ba0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ba3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801baa:	8b 45 08             	mov    0x8(%ebp),%eax
  801bad:	01 d0                	add    %edx,%eax
  801baf:	8b 00                	mov    (%eax),%eax
  801bb1:	85 c0                	test   %eax,%eax
  801bb3:	75 08                	jne    801bbd <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801bb5:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801bb8:	e9 a5 00 00 00       	jmp    801c62 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801bbd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bc4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801bcb:	eb 69                	jmp    801c36 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801bcd:	a1 20 30 80 00       	mov    0x803020,%eax
  801bd2:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bd8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bdb:	89 d0                	mov    %edx,%eax
  801bdd:	01 c0                	add    %eax,%eax
  801bdf:	01 d0                	add    %edx,%eax
  801be1:	c1 e0 03             	shl    $0x3,%eax
  801be4:	01 c8                	add    %ecx,%eax
  801be6:	8a 40 04             	mov    0x4(%eax),%al
  801be9:	84 c0                	test   %al,%al
  801beb:	75 46                	jne    801c33 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801bed:	a1 20 30 80 00       	mov    0x803020,%eax
  801bf2:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bf8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bfb:	89 d0                	mov    %edx,%eax
  801bfd:	01 c0                	add    %eax,%eax
  801bff:	01 d0                	add    %edx,%eax
  801c01:	c1 e0 03             	shl    $0x3,%eax
  801c04:	01 c8                	add    %ecx,%eax
  801c06:	8b 00                	mov    (%eax),%eax
  801c08:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c0b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c0e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c13:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c18:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c22:	01 c8                	add    %ecx,%eax
  801c24:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c26:	39 c2                	cmp    %eax,%edx
  801c28:	75 09                	jne    801c33 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801c2a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c31:	eb 15                	jmp    801c48 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c33:	ff 45 e8             	incl   -0x18(%ebp)
  801c36:	a1 20 30 80 00       	mov    0x803020,%eax
  801c3b:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c41:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c44:	39 c2                	cmp    %eax,%edx
  801c46:	77 85                	ja     801bcd <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c48:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c4c:	75 14                	jne    801c62 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801c4e:	83 ec 04             	sub    $0x4,%esp
  801c51:	68 ac 27 80 00       	push   $0x8027ac
  801c56:	6a 3a                	push   $0x3a
  801c58:	68 a0 27 80 00       	push   $0x8027a0
  801c5d:	e8 88 fe ff ff       	call   801aea <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c62:	ff 45 f0             	incl   -0x10(%ebp)
  801c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c68:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c6b:	0f 8c 2f ff ff ff    	jl     801ba0 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c71:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c78:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c7f:	eb 26                	jmp    801ca7 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c81:	a1 20 30 80 00       	mov    0x803020,%eax
  801c86:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c8c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c8f:	89 d0                	mov    %edx,%eax
  801c91:	01 c0                	add    %eax,%eax
  801c93:	01 d0                	add    %edx,%eax
  801c95:	c1 e0 03             	shl    $0x3,%eax
  801c98:	01 c8                	add    %ecx,%eax
  801c9a:	8a 40 04             	mov    0x4(%eax),%al
  801c9d:	3c 01                	cmp    $0x1,%al
  801c9f:	75 03                	jne    801ca4 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801ca1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ca4:	ff 45 e0             	incl   -0x20(%ebp)
  801ca7:	a1 20 30 80 00       	mov    0x803020,%eax
  801cac:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801cb2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cb5:	39 c2                	cmp    %eax,%edx
  801cb7:	77 c8                	ja     801c81 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cbc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cbf:	74 14                	je     801cd5 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801cc1:	83 ec 04             	sub    $0x4,%esp
  801cc4:	68 00 28 80 00       	push   $0x802800
  801cc9:	6a 44                	push   $0x44
  801ccb:	68 a0 27 80 00       	push   $0x8027a0
  801cd0:	e8 15 fe ff ff       	call   801aea <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801cd5:	90                   	nop
  801cd6:	c9                   	leave  
  801cd7:	c3                   	ret    

00801cd8 <__udivdi3>:
  801cd8:	55                   	push   %ebp
  801cd9:	57                   	push   %edi
  801cda:	56                   	push   %esi
  801cdb:	53                   	push   %ebx
  801cdc:	83 ec 1c             	sub    $0x1c,%esp
  801cdf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ce3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ce7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ceb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cef:	89 ca                	mov    %ecx,%edx
  801cf1:	89 f8                	mov    %edi,%eax
  801cf3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cf7:	85 f6                	test   %esi,%esi
  801cf9:	75 2d                	jne    801d28 <__udivdi3+0x50>
  801cfb:	39 cf                	cmp    %ecx,%edi
  801cfd:	77 65                	ja     801d64 <__udivdi3+0x8c>
  801cff:	89 fd                	mov    %edi,%ebp
  801d01:	85 ff                	test   %edi,%edi
  801d03:	75 0b                	jne    801d10 <__udivdi3+0x38>
  801d05:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0a:	31 d2                	xor    %edx,%edx
  801d0c:	f7 f7                	div    %edi
  801d0e:	89 c5                	mov    %eax,%ebp
  801d10:	31 d2                	xor    %edx,%edx
  801d12:	89 c8                	mov    %ecx,%eax
  801d14:	f7 f5                	div    %ebp
  801d16:	89 c1                	mov    %eax,%ecx
  801d18:	89 d8                	mov    %ebx,%eax
  801d1a:	f7 f5                	div    %ebp
  801d1c:	89 cf                	mov    %ecx,%edi
  801d1e:	89 fa                	mov    %edi,%edx
  801d20:	83 c4 1c             	add    $0x1c,%esp
  801d23:	5b                   	pop    %ebx
  801d24:	5e                   	pop    %esi
  801d25:	5f                   	pop    %edi
  801d26:	5d                   	pop    %ebp
  801d27:	c3                   	ret    
  801d28:	39 ce                	cmp    %ecx,%esi
  801d2a:	77 28                	ja     801d54 <__udivdi3+0x7c>
  801d2c:	0f bd fe             	bsr    %esi,%edi
  801d2f:	83 f7 1f             	xor    $0x1f,%edi
  801d32:	75 40                	jne    801d74 <__udivdi3+0x9c>
  801d34:	39 ce                	cmp    %ecx,%esi
  801d36:	72 0a                	jb     801d42 <__udivdi3+0x6a>
  801d38:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d3c:	0f 87 9e 00 00 00    	ja     801de0 <__udivdi3+0x108>
  801d42:	b8 01 00 00 00       	mov    $0x1,%eax
  801d47:	89 fa                	mov    %edi,%edx
  801d49:	83 c4 1c             	add    $0x1c,%esp
  801d4c:	5b                   	pop    %ebx
  801d4d:	5e                   	pop    %esi
  801d4e:	5f                   	pop    %edi
  801d4f:	5d                   	pop    %ebp
  801d50:	c3                   	ret    
  801d51:	8d 76 00             	lea    0x0(%esi),%esi
  801d54:	31 ff                	xor    %edi,%edi
  801d56:	31 c0                	xor    %eax,%eax
  801d58:	89 fa                	mov    %edi,%edx
  801d5a:	83 c4 1c             	add    $0x1c,%esp
  801d5d:	5b                   	pop    %ebx
  801d5e:	5e                   	pop    %esi
  801d5f:	5f                   	pop    %edi
  801d60:	5d                   	pop    %ebp
  801d61:	c3                   	ret    
  801d62:	66 90                	xchg   %ax,%ax
  801d64:	89 d8                	mov    %ebx,%eax
  801d66:	f7 f7                	div    %edi
  801d68:	31 ff                	xor    %edi,%edi
  801d6a:	89 fa                	mov    %edi,%edx
  801d6c:	83 c4 1c             	add    $0x1c,%esp
  801d6f:	5b                   	pop    %ebx
  801d70:	5e                   	pop    %esi
  801d71:	5f                   	pop    %edi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    
  801d74:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d79:	89 eb                	mov    %ebp,%ebx
  801d7b:	29 fb                	sub    %edi,%ebx
  801d7d:	89 f9                	mov    %edi,%ecx
  801d7f:	d3 e6                	shl    %cl,%esi
  801d81:	89 c5                	mov    %eax,%ebp
  801d83:	88 d9                	mov    %bl,%cl
  801d85:	d3 ed                	shr    %cl,%ebp
  801d87:	89 e9                	mov    %ebp,%ecx
  801d89:	09 f1                	or     %esi,%ecx
  801d8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d8f:	89 f9                	mov    %edi,%ecx
  801d91:	d3 e0                	shl    %cl,%eax
  801d93:	89 c5                	mov    %eax,%ebp
  801d95:	89 d6                	mov    %edx,%esi
  801d97:	88 d9                	mov    %bl,%cl
  801d99:	d3 ee                	shr    %cl,%esi
  801d9b:	89 f9                	mov    %edi,%ecx
  801d9d:	d3 e2                	shl    %cl,%edx
  801d9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801da3:	88 d9                	mov    %bl,%cl
  801da5:	d3 e8                	shr    %cl,%eax
  801da7:	09 c2                	or     %eax,%edx
  801da9:	89 d0                	mov    %edx,%eax
  801dab:	89 f2                	mov    %esi,%edx
  801dad:	f7 74 24 0c          	divl   0xc(%esp)
  801db1:	89 d6                	mov    %edx,%esi
  801db3:	89 c3                	mov    %eax,%ebx
  801db5:	f7 e5                	mul    %ebp
  801db7:	39 d6                	cmp    %edx,%esi
  801db9:	72 19                	jb     801dd4 <__udivdi3+0xfc>
  801dbb:	74 0b                	je     801dc8 <__udivdi3+0xf0>
  801dbd:	89 d8                	mov    %ebx,%eax
  801dbf:	31 ff                	xor    %edi,%edi
  801dc1:	e9 58 ff ff ff       	jmp    801d1e <__udivdi3+0x46>
  801dc6:	66 90                	xchg   %ax,%ax
  801dc8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dcc:	89 f9                	mov    %edi,%ecx
  801dce:	d3 e2                	shl    %cl,%edx
  801dd0:	39 c2                	cmp    %eax,%edx
  801dd2:	73 e9                	jae    801dbd <__udivdi3+0xe5>
  801dd4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dd7:	31 ff                	xor    %edi,%edi
  801dd9:	e9 40 ff ff ff       	jmp    801d1e <__udivdi3+0x46>
  801dde:	66 90                	xchg   %ax,%ax
  801de0:	31 c0                	xor    %eax,%eax
  801de2:	e9 37 ff ff ff       	jmp    801d1e <__udivdi3+0x46>
  801de7:	90                   	nop

00801de8 <__umoddi3>:
  801de8:	55                   	push   %ebp
  801de9:	57                   	push   %edi
  801dea:	56                   	push   %esi
  801deb:	53                   	push   %ebx
  801dec:	83 ec 1c             	sub    $0x1c,%esp
  801def:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801df3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801df7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dfb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801dff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e03:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e07:	89 f3                	mov    %esi,%ebx
  801e09:	89 fa                	mov    %edi,%edx
  801e0b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e0f:	89 34 24             	mov    %esi,(%esp)
  801e12:	85 c0                	test   %eax,%eax
  801e14:	75 1a                	jne    801e30 <__umoddi3+0x48>
  801e16:	39 f7                	cmp    %esi,%edi
  801e18:	0f 86 a2 00 00 00    	jbe    801ec0 <__umoddi3+0xd8>
  801e1e:	89 c8                	mov    %ecx,%eax
  801e20:	89 f2                	mov    %esi,%edx
  801e22:	f7 f7                	div    %edi
  801e24:	89 d0                	mov    %edx,%eax
  801e26:	31 d2                	xor    %edx,%edx
  801e28:	83 c4 1c             	add    $0x1c,%esp
  801e2b:	5b                   	pop    %ebx
  801e2c:	5e                   	pop    %esi
  801e2d:	5f                   	pop    %edi
  801e2e:	5d                   	pop    %ebp
  801e2f:	c3                   	ret    
  801e30:	39 f0                	cmp    %esi,%eax
  801e32:	0f 87 ac 00 00 00    	ja     801ee4 <__umoddi3+0xfc>
  801e38:	0f bd e8             	bsr    %eax,%ebp
  801e3b:	83 f5 1f             	xor    $0x1f,%ebp
  801e3e:	0f 84 ac 00 00 00    	je     801ef0 <__umoddi3+0x108>
  801e44:	bf 20 00 00 00       	mov    $0x20,%edi
  801e49:	29 ef                	sub    %ebp,%edi
  801e4b:	89 fe                	mov    %edi,%esi
  801e4d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e51:	89 e9                	mov    %ebp,%ecx
  801e53:	d3 e0                	shl    %cl,%eax
  801e55:	89 d7                	mov    %edx,%edi
  801e57:	89 f1                	mov    %esi,%ecx
  801e59:	d3 ef                	shr    %cl,%edi
  801e5b:	09 c7                	or     %eax,%edi
  801e5d:	89 e9                	mov    %ebp,%ecx
  801e5f:	d3 e2                	shl    %cl,%edx
  801e61:	89 14 24             	mov    %edx,(%esp)
  801e64:	89 d8                	mov    %ebx,%eax
  801e66:	d3 e0                	shl    %cl,%eax
  801e68:	89 c2                	mov    %eax,%edx
  801e6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6e:	d3 e0                	shl    %cl,%eax
  801e70:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e74:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e78:	89 f1                	mov    %esi,%ecx
  801e7a:	d3 e8                	shr    %cl,%eax
  801e7c:	09 d0                	or     %edx,%eax
  801e7e:	d3 eb                	shr    %cl,%ebx
  801e80:	89 da                	mov    %ebx,%edx
  801e82:	f7 f7                	div    %edi
  801e84:	89 d3                	mov    %edx,%ebx
  801e86:	f7 24 24             	mull   (%esp)
  801e89:	89 c6                	mov    %eax,%esi
  801e8b:	89 d1                	mov    %edx,%ecx
  801e8d:	39 d3                	cmp    %edx,%ebx
  801e8f:	0f 82 87 00 00 00    	jb     801f1c <__umoddi3+0x134>
  801e95:	0f 84 91 00 00 00    	je     801f2c <__umoddi3+0x144>
  801e9b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e9f:	29 f2                	sub    %esi,%edx
  801ea1:	19 cb                	sbb    %ecx,%ebx
  801ea3:	89 d8                	mov    %ebx,%eax
  801ea5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ea9:	d3 e0                	shl    %cl,%eax
  801eab:	89 e9                	mov    %ebp,%ecx
  801ead:	d3 ea                	shr    %cl,%edx
  801eaf:	09 d0                	or     %edx,%eax
  801eb1:	89 e9                	mov    %ebp,%ecx
  801eb3:	d3 eb                	shr    %cl,%ebx
  801eb5:	89 da                	mov    %ebx,%edx
  801eb7:	83 c4 1c             	add    $0x1c,%esp
  801eba:	5b                   	pop    %ebx
  801ebb:	5e                   	pop    %esi
  801ebc:	5f                   	pop    %edi
  801ebd:	5d                   	pop    %ebp
  801ebe:	c3                   	ret    
  801ebf:	90                   	nop
  801ec0:	89 fd                	mov    %edi,%ebp
  801ec2:	85 ff                	test   %edi,%edi
  801ec4:	75 0b                	jne    801ed1 <__umoddi3+0xe9>
  801ec6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ecb:	31 d2                	xor    %edx,%edx
  801ecd:	f7 f7                	div    %edi
  801ecf:	89 c5                	mov    %eax,%ebp
  801ed1:	89 f0                	mov    %esi,%eax
  801ed3:	31 d2                	xor    %edx,%edx
  801ed5:	f7 f5                	div    %ebp
  801ed7:	89 c8                	mov    %ecx,%eax
  801ed9:	f7 f5                	div    %ebp
  801edb:	89 d0                	mov    %edx,%eax
  801edd:	e9 44 ff ff ff       	jmp    801e26 <__umoddi3+0x3e>
  801ee2:	66 90                	xchg   %ax,%ax
  801ee4:	89 c8                	mov    %ecx,%eax
  801ee6:	89 f2                	mov    %esi,%edx
  801ee8:	83 c4 1c             	add    $0x1c,%esp
  801eeb:	5b                   	pop    %ebx
  801eec:	5e                   	pop    %esi
  801eed:	5f                   	pop    %edi
  801eee:	5d                   	pop    %ebp
  801eef:	c3                   	ret    
  801ef0:	3b 04 24             	cmp    (%esp),%eax
  801ef3:	72 06                	jb     801efb <__umoddi3+0x113>
  801ef5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ef9:	77 0f                	ja     801f0a <__umoddi3+0x122>
  801efb:	89 f2                	mov    %esi,%edx
  801efd:	29 f9                	sub    %edi,%ecx
  801eff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f03:	89 14 24             	mov    %edx,(%esp)
  801f06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f0e:	8b 14 24             	mov    (%esp),%edx
  801f11:	83 c4 1c             	add    $0x1c,%esp
  801f14:	5b                   	pop    %ebx
  801f15:	5e                   	pop    %esi
  801f16:	5f                   	pop    %edi
  801f17:	5d                   	pop    %ebp
  801f18:	c3                   	ret    
  801f19:	8d 76 00             	lea    0x0(%esi),%esi
  801f1c:	2b 04 24             	sub    (%esp),%eax
  801f1f:	19 fa                	sbb    %edi,%edx
  801f21:	89 d1                	mov    %edx,%ecx
  801f23:	89 c6                	mov    %eax,%esi
  801f25:	e9 71 ff ff ff       	jmp    801e9b <__umoddi3+0xb3>
  801f2a:	66 90                	xchg   %ax,%ax
  801f2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f30:	72 ea                	jb     801f1c <__umoddi3+0x134>
  801f32:	89 d9                	mov    %ebx,%ecx
  801f34:	e9 62 ff ff ff       	jmp    801e9b <__umoddi3+0xb3>
