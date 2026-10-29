
obj/user/tst_protection_slave1:     file format elf32-i386


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
  800031:	e8 34 01 00 00       	call   80016a <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 58 4e 00 00    	sub    $0x4e58,%esp

	/*=================================================*/
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
#if USE_KHEAP
	{
		if (LIST_SIZE(&(myEnv->page_WS_active_list)) >= myEnv->page_WS_max_size)
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800057:	39 c2                	cmp    %eax,%edx
  800059:	72 14                	jb     80006f <_main+0x37>
			panic("Please increase the WS size");
  80005b:	83 ec 04             	sub    $0x4,%esp
  80005e:	68 80 1f 80 00       	push   $0x801f80
  800063:	6a 0c                	push   $0xc
  800065:	68 9c 1f 80 00       	push   $0x801f9c
  80006a:	e8 5b 03 00 00       	call   8003ca <_panic>
	panic("make sure to enable the kernel heap: USE_KHEAP=1");
#endif
	/*=================================================*/

	{
		char initname[10] = "x";
  80006f:	c7 45 e6 78 00 00 00 	movl   $0x78,-0x1a(%ebp)
  800076:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
  80007d:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
		char name[10] ;
#define NUM_OF_OBJS 5000
		uint32* vars[NUM_OF_OBJS];
		for (int s = 0; s < NUM_OF_OBJS; ++s)
  800083:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80008a:	e9 88 00 00 00       	jmp    800117 <_main+0xdf>
		{
			char index[10];
			ltostr(s, index);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 45 d2             	lea    -0x2e(%ebp),%eax
  800095:	50                   	push   %eax
  800096:	ff 75 f4             	pushl  -0xc(%ebp)
  800099:	e8 28 12 00 00       	call   8012c6 <ltostr>
  80009e:	83 c4 10             	add    $0x10,%esp
			strcconcat(initname, index, name);
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	8d 45 dc             	lea    -0x24(%ebp),%eax
  8000a7:	50                   	push   %eax
  8000a8:	8d 45 d2             	lea    -0x2e(%ebp),%eax
  8000ab:	50                   	push   %eax
  8000ac:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  8000af:	50                   	push   %eax
  8000b0:	e8 ea 12 00 00       	call   80139f <strcconcat>
  8000b5:	83 c4 10             	add    $0x10,%esp
			vars[s] = smalloc(name, PAGE_SIZE, 1);
  8000b8:	83 ec 04             	sub    $0x4,%esp
  8000bb:	6a 01                	push   $0x1
  8000bd:	68 00 10 00 00       	push   $0x1000
  8000c2:	8d 45 dc             	lea    -0x24(%ebp),%eax
  8000c5:	50                   	push   %eax
  8000c6:	e8 6d 15 00 00       	call   801638 <smalloc>
  8000cb:	83 c4 10             	add    $0x10,%esp
  8000ce:	89 c2                	mov    %eax,%edx
  8000d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d3:	89 94 85 b0 b1 ff ff 	mov    %edx,-0x4e50(%ebp,%eax,4)
			*vars[s] = s;
  8000da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000dd:	8b 84 85 b0 b1 ff ff 	mov    -0x4e50(%ebp,%eax,4),%eax
  8000e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000e7:	89 10                	mov    %edx,(%eax)
			if (s % 1000 == 0)
  8000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000ec:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  8000f1:	99                   	cltd   
  8000f2:	f7 f9                	idiv   %ecx
  8000f4:	89 d0                	mov    %edx,%eax
  8000f6:	85 c0                	test   %eax,%eax
  8000f8:	75 1a                	jne    800114 <_main+0xdc>
				cprintf_colored(TEXT_light_cyan, "%d creates %d shared objects\n", myEnv->env_id, s);
  8000fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ff:	8b 00                	mov    (%eax),%eax
  800101:	ff 75 f4             	pushl  -0xc(%ebp)
  800104:	50                   	push   %eax
  800105:	68 b9 1f 80 00       	push   $0x801fb9
  80010a:	6a 0b                	push   $0xb
  80010c:	e8 b4 05 00 00       	call   8006c5 <cprintf_colored>
  800111:	83 c4 10             	add    $0x10,%esp
	{
		char initname[10] = "x";
		char name[10] ;
#define NUM_OF_OBJS 5000
		uint32* vars[NUM_OF_OBJS];
		for (int s = 0; s < NUM_OF_OBJS; ++s)
  800114:	ff 45 f4             	incl   -0xc(%ebp)
  800117:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%ebp)
  80011e:	0f 8e 6b ff ff ff    	jle    80008f <_main+0x57>
			vars[s] = smalloc(name, PAGE_SIZE, 1);
			*vars[s] = s;
			if (s % 1000 == 0)
				cprintf_colored(TEXT_light_cyan, "%d creates %d shared objects\n", myEnv->env_id, s);
		}
		for (int s = 0; s < NUM_OF_OBJS; ++s)
  800124:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80012b:	eb 2c                	jmp    800159 <_main+0x121>
		{
			assert(*vars[s] == s);
  80012d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800130:	8b 84 85 b0 b1 ff ff 	mov    -0x4e50(%ebp,%eax,4),%eax
  800137:	8b 10                	mov    (%eax),%edx
  800139:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80013c:	39 c2                	cmp    %eax,%edx
  80013e:	74 16                	je     800156 <_main+0x11e>
  800140:	68 d7 1f 80 00       	push   $0x801fd7
  800145:	68 e5 1f 80 00       	push   $0x801fe5
  80014a:	6a 24                	push   $0x24
  80014c:	68 9c 1f 80 00       	push   $0x801f9c
  800151:	e8 74 02 00 00       	call   8003ca <_panic>
			vars[s] = smalloc(name, PAGE_SIZE, 1);
			*vars[s] = s;
			if (s % 1000 == 0)
				cprintf_colored(TEXT_light_cyan, "%d creates %d shared objects\n", myEnv->env_id, s);
		}
		for (int s = 0; s < NUM_OF_OBJS; ++s)
  800156:	ff 45 f0             	incl   -0x10(%ebp)
  800159:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
  800160:	7e cb                	jle    80012d <_main+0xf5>
		{
			assert(*vars[s] == s);
		}
	}

	inctst();
  800162:	e8 2d 19 00 00       	call   801a94 <inctst>
}
  800167:	90                   	nop
  800168:	c9                   	leave  
  800169:	c3                   	ret    

0080016a <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80016a:	55                   	push   %ebp
  80016b:	89 e5                	mov    %esp,%ebp
  80016d:	57                   	push   %edi
  80016e:	56                   	push   %esi
  80016f:	53                   	push   %ebx
  800170:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800176:	e8 11 18 00 00       	call   80198c <sys_getenvindex>
  80017b:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  80017e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800181:	89 d0                	mov    %edx,%eax
  800183:	c1 e0 03             	shl    $0x3,%eax
  800186:	01 d0                	add    %edx,%eax
  800188:	c1 e0 06             	shl    $0x6,%eax
  80018b:	01 d0                	add    %edx,%eax
  80018d:	c1 e0 03             	shl    $0x3,%eax
  800190:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800195:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80019a:	a1 20 30 80 00       	mov    0x803020,%eax
  80019f:	8a 40 10             	mov    0x10(%eax),%al
  8001a2:	84 c0                	test   %al,%al
  8001a4:	74 0d                	je     8001b3 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ab:	83 c0 10             	add    $0x10,%eax
  8001ae:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001b7:	7e 0a                	jle    8001c3 <libmain+0x59>
		binaryname = argv[0];
  8001b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001bc:	8b 00                	mov    (%eax),%eax
  8001be:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8001c3:	83 ec 08             	sub    $0x8,%esp
  8001c6:	ff 75 0c             	pushl  0xc(%ebp)
  8001c9:	ff 75 08             	pushl  0x8(%ebp)
  8001cc:	e8 67 fe ff ff       	call   800038 <_main>
  8001d1:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8001d4:	a1 00 30 80 00       	mov    0x803000,%eax
  8001d9:	85 c0                	test   %eax,%eax
  8001db:	0f 84 b7 01 00 00    	je     800398 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8001e1:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8001e7:	bb 38 21 80 00       	mov    $0x802138,%ebx
  8001ec:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001f1:	89 c7                	mov    %eax,%edi
  8001f3:	89 de                	mov    %ebx,%esi
  8001f5:	89 d1                	mov    %edx,%ecx
  8001f7:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001f9:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8001ff:	b9 56 00 00 00       	mov    $0x56,%ecx
  800204:	b0 00                	mov    $0x0,%al
  800206:	89 d7                	mov    %edx,%edi
  800208:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80020a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800211:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800214:	83 ec 08             	sub    $0x8,%esp
  800217:	50                   	push   %eax
  800218:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80021e:	50                   	push   %eax
  80021f:	e8 68 19 00 00       	call   801b8c <sys_utilities>
  800224:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800227:	e8 e8 14 00 00       	call   801714 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	68 14 20 80 00       	push   $0x802014
  800234:	e8 5f 04 00 00       	call   800698 <cprintf>
  800239:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80023c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80023f:	85 c0                	test   %eax,%eax
  800241:	74 58                	je     80029b <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800243:	e8 62 19 00 00       	call   801baa <sys_get_optimal_num_faults>
  800248:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80024b:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800251:	bb 9c 21 80 00       	mov    $0x80219c,%ebx
  800256:	ba 11 00 00 00       	mov    $0x11,%edx
  80025b:	89 c7                	mov    %eax,%edi
  80025d:	89 de                	mov    %ebx,%esi
  80025f:	89 d1                	mov    %edx,%ecx
  800261:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800263:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800266:	b9 53 00 00 00       	mov    $0x53,%ecx
  80026b:	b0 00                	mov    $0x0,%al
  80026d:	89 d7                	mov    %edx,%edi
  80026f:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800271:	83 ec 08             	sub    $0x8,%esp
  800274:	ff 75 dc             	pushl  -0x24(%ebp)
  800277:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80027d:	50                   	push   %eax
  80027e:	e8 09 19 00 00       	call   801b8c <sys_utilities>
  800283:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800286:	83 ec 08             	sub    $0x8,%esp
  800289:	ff 75 dc             	pushl  -0x24(%ebp)
  80028c:	68 3c 20 80 00       	push   $0x80203c
  800291:	e8 02 04 00 00       	call   800698 <cprintf>
  800296:	83 c4 10             	add    $0x10,%esp
  800299:	eb 59                	jmp    8002f4 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80029b:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a0:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ab:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002b1:	83 ec 04             	sub    $0x4,%esp
  8002b4:	52                   	push   %edx
  8002b5:	50                   	push   %eax
  8002b6:	68 60 20 80 00       	push   $0x802060
  8002bb:	e8 d8 03 00 00       	call   800698 <cprintf>
  8002c0:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8002c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c8:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8002ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d3:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8002d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8002de:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8002e4:	51                   	push   %ecx
  8002e5:	52                   	push   %edx
  8002e6:	50                   	push   %eax
  8002e7:	68 88 20 80 00       	push   $0x802088
  8002ec:	e8 a7 03 00 00       	call   800698 <cprintf>
  8002f1:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f9:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	50                   	push   %eax
  800303:	68 e0 20 80 00       	push   $0x8020e0
  800308:	e8 8b 03 00 00       	call   800698 <cprintf>
  80030d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800310:	83 ec 0c             	sub    $0xc,%esp
  800313:	68 f4 20 80 00       	push   $0x8020f4
  800318:	e8 7b 03 00 00       	call   800698 <cprintf>
  80031d:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800320:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800327:	eb 28                	jmp    800351 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800329:	a1 20 30 80 00       	mov    0x803020,%eax
  80032e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800331:	81 c2 74 04 00 00    	add    $0x474,%edx
  800337:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80033a:	83 ec 04             	sub    $0x4,%esp
  80033d:	50                   	push   %eax
  80033e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800341:	68 0b 21 80 00       	push   $0x80210b
  800346:	e8 4d 03 00 00       	call   800698 <cprintf>
  80034b:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80034e:	ff 45 e4             	incl   -0x1c(%ebp)
  800351:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800355:	7e d2                	jle    800329 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800357:	83 ec 0c             	sub    $0xc,%esp
  80035a:	68 1a 21 80 00       	push   $0x80211a
  80035f:	e8 34 03 00 00       	call   800698 <cprintf>
  800364:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800367:	a1 20 30 80 00       	mov    0x803020,%eax
  80036c:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800372:	83 ec 08             	sub    $0x8,%esp
  800375:	50                   	push   %eax
  800376:	68 1e 21 80 00       	push   $0x80211e
  80037b:	e8 18 03 00 00       	call   800698 <cprintf>
  800380:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800383:	83 ec 0c             	sub    $0xc,%esp
  800386:	68 14 20 80 00       	push   $0x802014
  80038b:	e8 08 03 00 00       	call   800698 <cprintf>
  800390:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800393:	e8 96 13 00 00       	call   80172e <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800398:	e8 1f 00 00 00       	call   8003bc <exit>
}
  80039d:	90                   	nop
  80039e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003a1:	5b                   	pop    %ebx
  8003a2:	5e                   	pop    %esi
  8003a3:	5f                   	pop    %edi
  8003a4:	5d                   	pop    %ebp
  8003a5:	c3                   	ret    

008003a6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003a6:	55                   	push   %ebp
  8003a7:	89 e5                	mov    %esp,%ebp
  8003a9:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003ac:	83 ec 0c             	sub    $0xc,%esp
  8003af:	6a 00                	push   $0x0
  8003b1:	e8 a2 15 00 00       	call   801958 <sys_destroy_env>
  8003b6:	83 c4 10             	add    $0x10,%esp
}
  8003b9:	90                   	nop
  8003ba:	c9                   	leave  
  8003bb:	c3                   	ret    

008003bc <exit>:

void
exit(void)
{
  8003bc:	55                   	push   %ebp
  8003bd:	89 e5                	mov    %esp,%ebp
  8003bf:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8003c2:	e8 f7 15 00 00       	call   8019be <sys_exit_env>
}
  8003c7:	90                   	nop
  8003c8:	c9                   	leave  
  8003c9:	c3                   	ret    

008003ca <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003ca:	55                   	push   %ebp
  8003cb:	89 e5                	mov    %esp,%ebp
  8003cd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003d0:	8d 45 10             	lea    0x10(%ebp),%eax
  8003d3:	83 c0 04             	add    $0x4,%eax
  8003d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003d9:	a1 28 31 80 00       	mov    0x803128,%eax
  8003de:	85 c0                	test   %eax,%eax
  8003e0:	74 16                	je     8003f8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003e2:	a1 28 31 80 00       	mov    0x803128,%eax
  8003e7:	83 ec 08             	sub    $0x8,%esp
  8003ea:	50                   	push   %eax
  8003eb:	68 00 22 80 00       	push   $0x802200
  8003f0:	e8 a3 02 00 00       	call   800698 <cprintf>
  8003f5:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8003f8:	a1 04 30 80 00       	mov    0x803004,%eax
  8003fd:	83 ec 0c             	sub    $0xc,%esp
  800400:	ff 75 0c             	pushl  0xc(%ebp)
  800403:	ff 75 08             	pushl  0x8(%ebp)
  800406:	50                   	push   %eax
  800407:	68 08 22 80 00       	push   $0x802208
  80040c:	6a 74                	push   $0x74
  80040e:	e8 b2 02 00 00       	call   8006c5 <cprintf_colored>
  800413:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800416:	8b 45 10             	mov    0x10(%ebp),%eax
  800419:	83 ec 08             	sub    $0x8,%esp
  80041c:	ff 75 f4             	pushl  -0xc(%ebp)
  80041f:	50                   	push   %eax
  800420:	e8 04 02 00 00       	call   800629 <vcprintf>
  800425:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800428:	83 ec 08             	sub    $0x8,%esp
  80042b:	6a 00                	push   $0x0
  80042d:	68 30 22 80 00       	push   $0x802230
  800432:	e8 f2 01 00 00       	call   800629 <vcprintf>
  800437:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80043a:	e8 7d ff ff ff       	call   8003bc <exit>

	// should not return here
	while (1) ;
  80043f:	eb fe                	jmp    80043f <_panic+0x75>

00800441 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800441:	55                   	push   %ebp
  800442:	89 e5                	mov    %esp,%ebp
  800444:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800447:	a1 20 30 80 00       	mov    0x803020,%eax
  80044c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800452:	8b 45 0c             	mov    0xc(%ebp),%eax
  800455:	39 c2                	cmp    %eax,%edx
  800457:	74 14                	je     80046d <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800459:	83 ec 04             	sub    $0x4,%esp
  80045c:	68 34 22 80 00       	push   $0x802234
  800461:	6a 26                	push   $0x26
  800463:	68 80 22 80 00       	push   $0x802280
  800468:	e8 5d ff ff ff       	call   8003ca <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80046d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800474:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80047b:	e9 c5 00 00 00       	jmp    800545 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  800480:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800483:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048a:	8b 45 08             	mov    0x8(%ebp),%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	85 c0                	test   %eax,%eax
  800493:	75 08                	jne    80049d <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800495:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800498:	e9 a5 00 00 00       	jmp    800542 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80049d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004ab:	eb 69                	jmp    800516 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b2:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004bb:	89 d0                	mov    %edx,%eax
  8004bd:	01 c0                	add    %eax,%eax
  8004bf:	01 d0                	add    %edx,%eax
  8004c1:	c1 e0 03             	shl    $0x3,%eax
  8004c4:	01 c8                	add    %ecx,%eax
  8004c6:	8a 40 04             	mov    0x4(%eax),%al
  8004c9:	84 c0                	test   %al,%al
  8004cb:	75 46                	jne    800513 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d2:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004d8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004db:	89 d0                	mov    %edx,%eax
  8004dd:	01 c0                	add    %eax,%eax
  8004df:	01 d0                	add    %edx,%eax
  8004e1:	c1 e0 03             	shl    $0x3,%eax
  8004e4:	01 c8                	add    %ecx,%eax
  8004e6:	8b 00                	mov    (%eax),%eax
  8004e8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004eb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004f3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004f8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	01 c8                	add    %ecx,%eax
  800504:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800506:	39 c2                	cmp    %eax,%edx
  800508:	75 09                	jne    800513 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80050a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800511:	eb 15                	jmp    800528 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800513:	ff 45 e8             	incl   -0x18(%ebp)
  800516:	a1 20 30 80 00       	mov    0x803020,%eax
  80051b:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800521:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800524:	39 c2                	cmp    %eax,%edx
  800526:	77 85                	ja     8004ad <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800528:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80052c:	75 14                	jne    800542 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80052e:	83 ec 04             	sub    $0x4,%esp
  800531:	68 8c 22 80 00       	push   $0x80228c
  800536:	6a 3a                	push   $0x3a
  800538:	68 80 22 80 00       	push   $0x802280
  80053d:	e8 88 fe ff ff       	call   8003ca <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800542:	ff 45 f0             	incl   -0x10(%ebp)
  800545:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800548:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054b:	0f 8c 2f ff ff ff    	jl     800480 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800551:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800558:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80055f:	eb 26                	jmp    800587 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800561:	a1 20 30 80 00       	mov    0x803020,%eax
  800566:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80056c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80056f:	89 d0                	mov    %edx,%eax
  800571:	01 c0                	add    %eax,%eax
  800573:	01 d0                	add    %edx,%eax
  800575:	c1 e0 03             	shl    $0x3,%eax
  800578:	01 c8                	add    %ecx,%eax
  80057a:	8a 40 04             	mov    0x4(%eax),%al
  80057d:	3c 01                	cmp    $0x1,%al
  80057f:	75 03                	jne    800584 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800581:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800584:	ff 45 e0             	incl   -0x20(%ebp)
  800587:	a1 20 30 80 00       	mov    0x803020,%eax
  80058c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800592:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800595:	39 c2                	cmp    %eax,%edx
  800597:	77 c8                	ja     800561 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800599:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80059f:	74 14                	je     8005b5 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	68 e0 22 80 00       	push   $0x8022e0
  8005a9:	6a 44                	push   $0x44
  8005ab:	68 80 22 80 00       	push   $0x802280
  8005b0:	e8 15 fe ff ff       	call   8003ca <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005b5:	90                   	nop
  8005b6:	c9                   	leave  
  8005b7:	c3                   	ret    

008005b8 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8005b8:	55                   	push   %ebp
  8005b9:	89 e5                	mov    %esp,%ebp
  8005bb:	53                   	push   %ebx
  8005bc:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8005bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c2:	8b 00                	mov    (%eax),%eax
  8005c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8005c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ca:	89 0a                	mov    %ecx,(%edx)
  8005cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8005cf:	88 d1                	mov    %dl,%cl
  8005d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005db:	8b 00                	mov    (%eax),%eax
  8005dd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e2:	75 30                	jne    800614 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8005e4:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8005ea:	a0 40 30 80 00       	mov    0x803040,%al
  8005ef:	0f b6 c0             	movzbl %al,%eax
  8005f2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005f5:	8b 09                	mov    (%ecx),%ecx
  8005f7:	89 cb                	mov    %ecx,%ebx
  8005f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005fc:	83 c1 08             	add    $0x8,%ecx
  8005ff:	52                   	push   %edx
  800600:	50                   	push   %eax
  800601:	53                   	push   %ebx
  800602:	51                   	push   %ecx
  800603:	e8 c8 10 00 00       	call   8016d0 <sys_cputs>
  800608:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80060b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800614:	8b 45 0c             	mov    0xc(%ebp),%eax
  800617:	8b 40 04             	mov    0x4(%eax),%eax
  80061a:	8d 50 01             	lea    0x1(%eax),%edx
  80061d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800620:	89 50 04             	mov    %edx,0x4(%eax)
}
  800623:	90                   	nop
  800624:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800627:	c9                   	leave  
  800628:	c3                   	ret    

00800629 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800629:	55                   	push   %ebp
  80062a:	89 e5                	mov    %esp,%ebp
  80062c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800632:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800639:	00 00 00 
	b.cnt = 0;
  80063c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800643:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800646:	ff 75 0c             	pushl  0xc(%ebp)
  800649:	ff 75 08             	pushl  0x8(%ebp)
  80064c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800652:	50                   	push   %eax
  800653:	68 b8 05 80 00       	push   $0x8005b8
  800658:	e8 5a 02 00 00       	call   8008b7 <vprintfmt>
  80065d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800660:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800666:	a0 40 30 80 00       	mov    0x803040,%al
  80066b:	0f b6 c0             	movzbl %al,%eax
  80066e:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800674:	52                   	push   %edx
  800675:	50                   	push   %eax
  800676:	51                   	push   %ecx
  800677:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80067d:	83 c0 08             	add    $0x8,%eax
  800680:	50                   	push   %eax
  800681:	e8 4a 10 00 00       	call   8016d0 <sys_cputs>
  800686:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800689:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800690:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800696:	c9                   	leave  
  800697:	c3                   	ret    

00800698 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800698:	55                   	push   %ebp
  800699:	89 e5                	mov    %esp,%ebp
  80069b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80069e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8006a5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ae:	83 ec 08             	sub    $0x8,%esp
  8006b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b4:	50                   	push   %eax
  8006b5:	e8 6f ff ff ff       	call   800629 <vcprintf>
  8006ba:	83 c4 10             	add    $0x10,%esp
  8006bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006c3:	c9                   	leave  
  8006c4:	c3                   	ret    

008006c5 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8006c5:	55                   	push   %ebp
  8006c6:	89 e5                	mov    %esp,%ebp
  8006c8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006cb:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	c1 e0 08             	shl    $0x8,%eax
  8006d8:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8006dd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006e0:	83 c0 04             	add    $0x4,%eax
  8006e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ef:	50                   	push   %eax
  8006f0:	e8 34 ff ff ff       	call   800629 <vcprintf>
  8006f5:	83 c4 10             	add    $0x10,%esp
  8006f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8006fb:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800702:	07 00 00 

	return cnt;
  800705:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800708:	c9                   	leave  
  800709:	c3                   	ret    

0080070a <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80070a:	55                   	push   %ebp
  80070b:	89 e5                	mov    %esp,%ebp
  80070d:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800710:	e8 ff 0f 00 00       	call   801714 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800715:	8d 45 0c             	lea    0xc(%ebp),%eax
  800718:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80071b:	8b 45 08             	mov    0x8(%ebp),%eax
  80071e:	83 ec 08             	sub    $0x8,%esp
  800721:	ff 75 f4             	pushl  -0xc(%ebp)
  800724:	50                   	push   %eax
  800725:	e8 ff fe ff ff       	call   800629 <vcprintf>
  80072a:	83 c4 10             	add    $0x10,%esp
  80072d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800730:	e8 f9 0f 00 00       	call   80172e <sys_unlock_cons>
	return cnt;
  800735:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800738:	c9                   	leave  
  800739:	c3                   	ret    

0080073a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80073a:	55                   	push   %ebp
  80073b:	89 e5                	mov    %esp,%ebp
  80073d:	53                   	push   %ebx
  80073e:	83 ec 14             	sub    $0x14,%esp
  800741:	8b 45 10             	mov    0x10(%ebp),%eax
  800744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800747:	8b 45 14             	mov    0x14(%ebp),%eax
  80074a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80074d:	8b 45 18             	mov    0x18(%ebp),%eax
  800750:	ba 00 00 00 00       	mov    $0x0,%edx
  800755:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800758:	77 55                	ja     8007af <printnum+0x75>
  80075a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80075d:	72 05                	jb     800764 <printnum+0x2a>
  80075f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800762:	77 4b                	ja     8007af <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800764:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800767:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80076a:	8b 45 18             	mov    0x18(%ebp),%eax
  80076d:	ba 00 00 00 00       	mov    $0x0,%edx
  800772:	52                   	push   %edx
  800773:	50                   	push   %eax
  800774:	ff 75 f4             	pushl  -0xc(%ebp)
  800777:	ff 75 f0             	pushl  -0x10(%ebp)
  80077a:	e8 8d 15 00 00       	call   801d0c <__udivdi3>
  80077f:	83 c4 10             	add    $0x10,%esp
  800782:	83 ec 04             	sub    $0x4,%esp
  800785:	ff 75 20             	pushl  0x20(%ebp)
  800788:	53                   	push   %ebx
  800789:	ff 75 18             	pushl  0x18(%ebp)
  80078c:	52                   	push   %edx
  80078d:	50                   	push   %eax
  80078e:	ff 75 0c             	pushl  0xc(%ebp)
  800791:	ff 75 08             	pushl  0x8(%ebp)
  800794:	e8 a1 ff ff ff       	call   80073a <printnum>
  800799:	83 c4 20             	add    $0x20,%esp
  80079c:	eb 1a                	jmp    8007b8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80079e:	83 ec 08             	sub    $0x8,%esp
  8007a1:	ff 75 0c             	pushl  0xc(%ebp)
  8007a4:	ff 75 20             	pushl  0x20(%ebp)
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	ff d0                	call   *%eax
  8007ac:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007af:	ff 4d 1c             	decl   0x1c(%ebp)
  8007b2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007b6:	7f e6                	jg     80079e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007b8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007bb:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c6:	53                   	push   %ebx
  8007c7:	51                   	push   %ecx
  8007c8:	52                   	push   %edx
  8007c9:	50                   	push   %eax
  8007ca:	e8 4d 16 00 00       	call   801e1c <__umoddi3>
  8007cf:	83 c4 10             	add    $0x10,%esp
  8007d2:	05 54 25 80 00       	add    $0x802554,%eax
  8007d7:	8a 00                	mov    (%eax),%al
  8007d9:	0f be c0             	movsbl %al,%eax
  8007dc:	83 ec 08             	sub    $0x8,%esp
  8007df:	ff 75 0c             	pushl  0xc(%ebp)
  8007e2:	50                   	push   %eax
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	ff d0                	call   *%eax
  8007e8:	83 c4 10             	add    $0x10,%esp
}
  8007eb:	90                   	nop
  8007ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007ef:	c9                   	leave  
  8007f0:	c3                   	ret    

008007f1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007f1:	55                   	push   %ebp
  8007f2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007f4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007f8:	7e 1c                	jle    800816 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	8b 00                	mov    (%eax),%eax
  8007ff:	8d 50 08             	lea    0x8(%eax),%edx
  800802:	8b 45 08             	mov    0x8(%ebp),%eax
  800805:	89 10                	mov    %edx,(%eax)
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	8b 00                	mov    (%eax),%eax
  80080c:	83 e8 08             	sub    $0x8,%eax
  80080f:	8b 50 04             	mov    0x4(%eax),%edx
  800812:	8b 00                	mov    (%eax),%eax
  800814:	eb 40                	jmp    800856 <getuint+0x65>
	else if (lflag)
  800816:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80081a:	74 1e                	je     80083a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	8b 00                	mov    (%eax),%eax
  800821:	8d 50 04             	lea    0x4(%eax),%edx
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	89 10                	mov    %edx,(%eax)
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	8b 00                	mov    (%eax),%eax
  80082e:	83 e8 04             	sub    $0x4,%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	ba 00 00 00 00       	mov    $0x0,%edx
  800838:	eb 1c                	jmp    800856 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	8b 00                	mov    (%eax),%eax
  80083f:	8d 50 04             	lea    0x4(%eax),%edx
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	89 10                	mov    %edx,(%eax)
  800847:	8b 45 08             	mov    0x8(%ebp),%eax
  80084a:	8b 00                	mov    (%eax),%eax
  80084c:	83 e8 04             	sub    $0x4,%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800856:	5d                   	pop    %ebp
  800857:	c3                   	ret    

00800858 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800858:	55                   	push   %ebp
  800859:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80085b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80085f:	7e 1c                	jle    80087d <getint+0x25>
		return va_arg(*ap, long long);
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	8b 00                	mov    (%eax),%eax
  800866:	8d 50 08             	lea    0x8(%eax),%edx
  800869:	8b 45 08             	mov    0x8(%ebp),%eax
  80086c:	89 10                	mov    %edx,(%eax)
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	8b 00                	mov    (%eax),%eax
  800873:	83 e8 08             	sub    $0x8,%eax
  800876:	8b 50 04             	mov    0x4(%eax),%edx
  800879:	8b 00                	mov    (%eax),%eax
  80087b:	eb 38                	jmp    8008b5 <getint+0x5d>
	else if (lflag)
  80087d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800881:	74 1a                	je     80089d <getint+0x45>
		return va_arg(*ap, long);
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	8b 00                	mov    (%eax),%eax
  800888:	8d 50 04             	lea    0x4(%eax),%edx
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	89 10                	mov    %edx,(%eax)
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	83 e8 04             	sub    $0x4,%eax
  800898:	8b 00                	mov    (%eax),%eax
  80089a:	99                   	cltd   
  80089b:	eb 18                	jmp    8008b5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	8b 00                	mov    (%eax),%eax
  8008a2:	8d 50 04             	lea    0x4(%eax),%edx
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	89 10                	mov    %edx,(%eax)
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	8b 00                	mov    (%eax),%eax
  8008af:	83 e8 04             	sub    $0x4,%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	99                   	cltd   
}
  8008b5:	5d                   	pop    %ebp
  8008b6:	c3                   	ret    

008008b7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008b7:	55                   	push   %ebp
  8008b8:	89 e5                	mov    %esp,%ebp
  8008ba:	56                   	push   %esi
  8008bb:	53                   	push   %ebx
  8008bc:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008bf:	eb 17                	jmp    8008d8 <vprintfmt+0x21>
			if (ch == '\0')
  8008c1:	85 db                	test   %ebx,%ebx
  8008c3:	0f 84 c1 03 00 00    	je     800c8a <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8008c9:	83 ec 08             	sub    $0x8,%esp
  8008cc:	ff 75 0c             	pushl  0xc(%ebp)
  8008cf:	53                   	push   %ebx
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	ff d0                	call   *%eax
  8008d5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008db:	8d 50 01             	lea    0x1(%eax),%edx
  8008de:	89 55 10             	mov    %edx,0x10(%ebp)
  8008e1:	8a 00                	mov    (%eax),%al
  8008e3:	0f b6 d8             	movzbl %al,%ebx
  8008e6:	83 fb 25             	cmp    $0x25,%ebx
  8008e9:	75 d6                	jne    8008c1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008eb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008ef:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008f6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800904:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80090b:	8b 45 10             	mov    0x10(%ebp),%eax
  80090e:	8d 50 01             	lea    0x1(%eax),%edx
  800911:	89 55 10             	mov    %edx,0x10(%ebp)
  800914:	8a 00                	mov    (%eax),%al
  800916:	0f b6 d8             	movzbl %al,%ebx
  800919:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80091c:	83 f8 5b             	cmp    $0x5b,%eax
  80091f:	0f 87 3d 03 00 00    	ja     800c62 <vprintfmt+0x3ab>
  800925:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  80092c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80092e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800932:	eb d7                	jmp    80090b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800934:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800938:	eb d1                	jmp    80090b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80093a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800941:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800944:	89 d0                	mov    %edx,%eax
  800946:	c1 e0 02             	shl    $0x2,%eax
  800949:	01 d0                	add    %edx,%eax
  80094b:	01 c0                	add    %eax,%eax
  80094d:	01 d8                	add    %ebx,%eax
  80094f:	83 e8 30             	sub    $0x30,%eax
  800952:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800955:	8b 45 10             	mov    0x10(%ebp),%eax
  800958:	8a 00                	mov    (%eax),%al
  80095a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80095d:	83 fb 2f             	cmp    $0x2f,%ebx
  800960:	7e 3e                	jle    8009a0 <vprintfmt+0xe9>
  800962:	83 fb 39             	cmp    $0x39,%ebx
  800965:	7f 39                	jg     8009a0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800967:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80096a:	eb d5                	jmp    800941 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 c0 04             	add    $0x4,%eax
  800972:	89 45 14             	mov    %eax,0x14(%ebp)
  800975:	8b 45 14             	mov    0x14(%ebp),%eax
  800978:	83 e8 04             	sub    $0x4,%eax
  80097b:	8b 00                	mov    (%eax),%eax
  80097d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800980:	eb 1f                	jmp    8009a1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800982:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800986:	79 83                	jns    80090b <vprintfmt+0x54>
				width = 0;
  800988:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80098f:	e9 77 ff ff ff       	jmp    80090b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800994:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80099b:	e9 6b ff ff ff       	jmp    80090b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009a0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a5:	0f 89 60 ff ff ff    	jns    80090b <vprintfmt+0x54>
				width = precision, precision = -1;
  8009ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009b1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009b8:	e9 4e ff ff ff       	jmp    80090b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009bd:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009c0:	e9 46 ff ff ff       	jmp    80090b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c8:	83 c0 04             	add    $0x4,%eax
  8009cb:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	83 e8 04             	sub    $0x4,%eax
  8009d4:	8b 00                	mov    (%eax),%eax
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	ff 75 0c             	pushl  0xc(%ebp)
  8009dc:	50                   	push   %eax
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	ff d0                	call   *%eax
  8009e2:	83 c4 10             	add    $0x10,%esp
			break;
  8009e5:	e9 9b 02 00 00       	jmp    800c85 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ed:	83 c0 04             	add    $0x4,%eax
  8009f0:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f6:	83 e8 04             	sub    $0x4,%eax
  8009f9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009fb:	85 db                	test   %ebx,%ebx
  8009fd:	79 02                	jns    800a01 <vprintfmt+0x14a>
				err = -err;
  8009ff:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a01:	83 fb 64             	cmp    $0x64,%ebx
  800a04:	7f 0b                	jg     800a11 <vprintfmt+0x15a>
  800a06:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  800a0d:	85 f6                	test   %esi,%esi
  800a0f:	75 19                	jne    800a2a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a11:	53                   	push   %ebx
  800a12:	68 65 25 80 00       	push   $0x802565
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	ff 75 08             	pushl  0x8(%ebp)
  800a1d:	e8 70 02 00 00       	call   800c92 <printfmt>
  800a22:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a25:	e9 5b 02 00 00       	jmp    800c85 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a2a:	56                   	push   %esi
  800a2b:	68 6e 25 80 00       	push   $0x80256e
  800a30:	ff 75 0c             	pushl  0xc(%ebp)
  800a33:	ff 75 08             	pushl  0x8(%ebp)
  800a36:	e8 57 02 00 00       	call   800c92 <printfmt>
  800a3b:	83 c4 10             	add    $0x10,%esp
			break;
  800a3e:	e9 42 02 00 00       	jmp    800c85 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a43:	8b 45 14             	mov    0x14(%ebp),%eax
  800a46:	83 c0 04             	add    $0x4,%eax
  800a49:	89 45 14             	mov    %eax,0x14(%ebp)
  800a4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4f:	83 e8 04             	sub    $0x4,%eax
  800a52:	8b 30                	mov    (%eax),%esi
  800a54:	85 f6                	test   %esi,%esi
  800a56:	75 05                	jne    800a5d <vprintfmt+0x1a6>
				p = "(null)";
  800a58:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  800a5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a61:	7e 6d                	jle    800ad0 <vprintfmt+0x219>
  800a63:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a67:	74 67                	je     800ad0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a69:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a6c:	83 ec 08             	sub    $0x8,%esp
  800a6f:	50                   	push   %eax
  800a70:	56                   	push   %esi
  800a71:	e8 1e 03 00 00       	call   800d94 <strnlen>
  800a76:	83 c4 10             	add    $0x10,%esp
  800a79:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a7c:	eb 16                	jmp    800a94 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a7e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a82:	83 ec 08             	sub    $0x8,%esp
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	50                   	push   %eax
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	ff d0                	call   *%eax
  800a8e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a91:	ff 4d e4             	decl   -0x1c(%ebp)
  800a94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a98:	7f e4                	jg     800a7e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a9a:	eb 34                	jmp    800ad0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a9c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aa0:	74 1c                	je     800abe <vprintfmt+0x207>
  800aa2:	83 fb 1f             	cmp    $0x1f,%ebx
  800aa5:	7e 05                	jle    800aac <vprintfmt+0x1f5>
  800aa7:	83 fb 7e             	cmp    $0x7e,%ebx
  800aaa:	7e 12                	jle    800abe <vprintfmt+0x207>
					putch('?', putdat);
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 0c             	pushl  0xc(%ebp)
  800ab2:	6a 3f                	push   $0x3f
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	ff d0                	call   *%eax
  800ab9:	83 c4 10             	add    $0x10,%esp
  800abc:	eb 0f                	jmp    800acd <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	53                   	push   %ebx
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac8:	ff d0                	call   *%eax
  800aca:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800acd:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad0:	89 f0                	mov    %esi,%eax
  800ad2:	8d 70 01             	lea    0x1(%eax),%esi
  800ad5:	8a 00                	mov    (%eax),%al
  800ad7:	0f be d8             	movsbl %al,%ebx
  800ada:	85 db                	test   %ebx,%ebx
  800adc:	74 24                	je     800b02 <vprintfmt+0x24b>
  800ade:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ae2:	78 b8                	js     800a9c <vprintfmt+0x1e5>
  800ae4:	ff 4d e0             	decl   -0x20(%ebp)
  800ae7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aeb:	79 af                	jns    800a9c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aed:	eb 13                	jmp    800b02 <vprintfmt+0x24b>
				putch(' ', putdat);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 0c             	pushl  0xc(%ebp)
  800af5:	6a 20                	push   $0x20
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	ff d0                	call   *%eax
  800afc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aff:	ff 4d e4             	decl   -0x1c(%ebp)
  800b02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b06:	7f e7                	jg     800aef <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b08:	e9 78 01 00 00       	jmp    800c85 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 e8             	pushl  -0x18(%ebp)
  800b13:	8d 45 14             	lea    0x14(%ebp),%eax
  800b16:	50                   	push   %eax
  800b17:	e8 3c fd ff ff       	call   800858 <getint>
  800b1c:	83 c4 10             	add    $0x10,%esp
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b25:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b28:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b2b:	85 d2                	test   %edx,%edx
  800b2d:	79 23                	jns    800b52 <vprintfmt+0x29b>
				putch('-', putdat);
  800b2f:	83 ec 08             	sub    $0x8,%esp
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	6a 2d                	push   $0x2d
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b45:	f7 d8                	neg    %eax
  800b47:	83 d2 00             	adc    $0x0,%edx
  800b4a:	f7 da                	neg    %edx
  800b4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b4f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b52:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b59:	e9 bc 00 00 00       	jmp    800c1a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b5e:	83 ec 08             	sub    $0x8,%esp
  800b61:	ff 75 e8             	pushl  -0x18(%ebp)
  800b64:	8d 45 14             	lea    0x14(%ebp),%eax
  800b67:	50                   	push   %eax
  800b68:	e8 84 fc ff ff       	call   8007f1 <getuint>
  800b6d:	83 c4 10             	add    $0x10,%esp
  800b70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b73:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b76:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b7d:	e9 98 00 00 00       	jmp    800c1a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b82:	83 ec 08             	sub    $0x8,%esp
  800b85:	ff 75 0c             	pushl  0xc(%ebp)
  800b88:	6a 58                	push   $0x58
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	ff d0                	call   *%eax
  800b8f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b92:	83 ec 08             	sub    $0x8,%esp
  800b95:	ff 75 0c             	pushl  0xc(%ebp)
  800b98:	6a 58                	push   $0x58
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	ff d0                	call   *%eax
  800b9f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ba2:	83 ec 08             	sub    $0x8,%esp
  800ba5:	ff 75 0c             	pushl  0xc(%ebp)
  800ba8:	6a 58                	push   $0x58
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	ff d0                	call   *%eax
  800baf:	83 c4 10             	add    $0x10,%esp
			break;
  800bb2:	e9 ce 00 00 00       	jmp    800c85 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 0c             	pushl  0xc(%ebp)
  800bbd:	6a 30                	push   $0x30
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	ff d0                	call   *%eax
  800bc4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 0c             	pushl  0xc(%ebp)
  800bcd:	6a 78                	push   $0x78
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	ff d0                	call   *%eax
  800bd4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800bda:	83 c0 04             	add    $0x4,%eax
  800bdd:	89 45 14             	mov    %eax,0x14(%ebp)
  800be0:	8b 45 14             	mov    0x14(%ebp),%eax
  800be3:	83 e8 04             	sub    $0x4,%eax
  800be6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800be8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bf2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bf9:	eb 1f                	jmp    800c1a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bfb:	83 ec 08             	sub    $0x8,%esp
  800bfe:	ff 75 e8             	pushl  -0x18(%ebp)
  800c01:	8d 45 14             	lea    0x14(%ebp),%eax
  800c04:	50                   	push   %eax
  800c05:	e8 e7 fb ff ff       	call   8007f1 <getuint>
  800c0a:	83 c4 10             	add    $0x10,%esp
  800c0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c10:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c13:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c1a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c21:	83 ec 04             	sub    $0x4,%esp
  800c24:	52                   	push   %edx
  800c25:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c28:	50                   	push   %eax
  800c29:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2c:	ff 75 f0             	pushl  -0x10(%ebp)
  800c2f:	ff 75 0c             	pushl  0xc(%ebp)
  800c32:	ff 75 08             	pushl  0x8(%ebp)
  800c35:	e8 00 fb ff ff       	call   80073a <printnum>
  800c3a:	83 c4 20             	add    $0x20,%esp
			break;
  800c3d:	eb 46                	jmp    800c85 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c3f:	83 ec 08             	sub    $0x8,%esp
  800c42:	ff 75 0c             	pushl  0xc(%ebp)
  800c45:	53                   	push   %ebx
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	ff d0                	call   *%eax
  800c4b:	83 c4 10             	add    $0x10,%esp
			break;
  800c4e:	eb 35                	jmp    800c85 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c50:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800c57:	eb 2c                	jmp    800c85 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c59:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800c60:	eb 23                	jmp    800c85 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c62:	83 ec 08             	sub    $0x8,%esp
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	6a 25                	push   $0x25
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	ff d0                	call   *%eax
  800c6f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c72:	ff 4d 10             	decl   0x10(%ebp)
  800c75:	eb 03                	jmp    800c7a <vprintfmt+0x3c3>
  800c77:	ff 4d 10             	decl   0x10(%ebp)
  800c7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7d:	48                   	dec    %eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 25                	cmp    $0x25,%al
  800c82:	75 f3                	jne    800c77 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c84:	90                   	nop
		}
	}
  800c85:	e9 35 fc ff ff       	jmp    8008bf <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c8a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c8b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c8e:	5b                   	pop    %ebx
  800c8f:	5e                   	pop    %esi
  800c90:	5d                   	pop    %ebp
  800c91:	c3                   	ret    

00800c92 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c98:	8d 45 10             	lea    0x10(%ebp),%eax
  800c9b:	83 c0 04             	add    $0x4,%eax
  800c9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ca1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca7:	50                   	push   %eax
  800ca8:	ff 75 0c             	pushl  0xc(%ebp)
  800cab:	ff 75 08             	pushl  0x8(%ebp)
  800cae:	e8 04 fc ff ff       	call   8008b7 <vprintfmt>
  800cb3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cb6:	90                   	nop
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbf:	8b 40 08             	mov    0x8(%eax),%eax
  800cc2:	8d 50 01             	lea    0x1(%eax),%edx
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cce:	8b 10                	mov    (%eax),%edx
  800cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd3:	8b 40 04             	mov    0x4(%eax),%eax
  800cd6:	39 c2                	cmp    %eax,%edx
  800cd8:	73 12                	jae    800cec <sprintputch+0x33>
		*b->buf++ = ch;
  800cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdd:	8b 00                	mov    (%eax),%eax
  800cdf:	8d 48 01             	lea    0x1(%eax),%ecx
  800ce2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce5:	89 0a                	mov    %ecx,(%edx)
  800ce7:	8b 55 08             	mov    0x8(%ebp),%edx
  800cea:	88 10                	mov    %dl,(%eax)
}
  800cec:	90                   	nop
  800ced:	5d                   	pop    %ebp
  800cee:	c3                   	ret    

00800cef <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cef:	55                   	push   %ebp
  800cf0:	89 e5                	mov    %esp,%ebp
  800cf2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	01 d0                	add    %edx,%eax
  800d06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d10:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d14:	74 06                	je     800d1c <vsnprintf+0x2d>
  800d16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1a:	7f 07                	jg     800d23 <vsnprintf+0x34>
		return -E_INVAL;
  800d1c:	b8 03 00 00 00       	mov    $0x3,%eax
  800d21:	eb 20                	jmp    800d43 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d23:	ff 75 14             	pushl  0x14(%ebp)
  800d26:	ff 75 10             	pushl  0x10(%ebp)
  800d29:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d2c:	50                   	push   %eax
  800d2d:	68 b9 0c 80 00       	push   $0x800cb9
  800d32:	e8 80 fb ff ff       	call   8008b7 <vprintfmt>
  800d37:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d3d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d4b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d4e:	83 c0 04             	add    $0x4,%eax
  800d51:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d54:	8b 45 10             	mov    0x10(%ebp),%eax
  800d57:	ff 75 f4             	pushl  -0xc(%ebp)
  800d5a:	50                   	push   %eax
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	ff 75 08             	pushl  0x8(%ebp)
  800d61:	e8 89 ff ff ff       	call   800cef <vsnprintf>
  800d66:	83 c4 10             	add    $0x10,%esp
  800d69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d7e:	eb 06                	jmp    800d86 <strlen+0x15>
		n++;
  800d80:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d83:	ff 45 08             	incl   0x8(%ebp)
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	84 c0                	test   %al,%al
  800d8d:	75 f1                	jne    800d80 <strlen+0xf>
		n++;
	return n;
  800d8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d92:	c9                   	leave  
  800d93:	c3                   	ret    

00800d94 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
  800d97:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da1:	eb 09                	jmp    800dac <strnlen+0x18>
		n++;
  800da3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800da6:	ff 45 08             	incl   0x8(%ebp)
  800da9:	ff 4d 0c             	decl   0xc(%ebp)
  800dac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db0:	74 09                	je     800dbb <strnlen+0x27>
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	84 c0                	test   %al,%al
  800db9:	75 e8                	jne    800da3 <strnlen+0xf>
		n++;
	return n;
  800dbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dbe:	c9                   	leave  
  800dbf:	c3                   	ret    

00800dc0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dc0:	55                   	push   %ebp
  800dc1:	89 e5                	mov    %esp,%ebp
  800dc3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dcc:	90                   	nop
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8d 50 01             	lea    0x1(%eax),%edx
  800dd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ddc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ddf:	8a 12                	mov    (%edx),%dl
  800de1:	88 10                	mov    %dl,(%eax)
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	84 c0                	test   %al,%al
  800de7:	75 e4                	jne    800dcd <strcpy+0xd>
		/* do nothing */;
	return ret;
  800de9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dec:	c9                   	leave  
  800ded:	c3                   	ret    

00800dee <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800dee:	55                   	push   %ebp
  800def:	89 e5                	mov    %esp,%ebp
  800df1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e01:	eb 1f                	jmp    800e22 <strncpy+0x34>
		*dst++ = *src;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	89 55 08             	mov    %edx,0x8(%ebp)
  800e0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0f:	8a 12                	mov    (%edx),%dl
  800e11:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	74 03                	je     800e1f <strncpy+0x31>
			src++;
  800e1c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e1f:	ff 45 fc             	incl   -0x4(%ebp)
  800e22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e25:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e28:	72 d9                	jb     800e03 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e2d:	c9                   	leave  
  800e2e:	c3                   	ret    

00800e2f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
  800e32:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3f:	74 30                	je     800e71 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e41:	eb 16                	jmp    800e59 <strlcpy+0x2a>
			*dst++ = *src++;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8d 50 01             	lea    0x1(%eax),%edx
  800e49:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e52:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e55:	8a 12                	mov    (%edx),%dl
  800e57:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e59:	ff 4d 10             	decl   0x10(%ebp)
  800e5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e60:	74 09                	je     800e6b <strlcpy+0x3c>
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	84 c0                	test   %al,%al
  800e69:	75 d8                	jne    800e43 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e71:	8b 55 08             	mov    0x8(%ebp),%edx
  800e74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e77:	29 c2                	sub    %eax,%edx
  800e79:	89 d0                	mov    %edx,%eax
}
  800e7b:	c9                   	leave  
  800e7c:	c3                   	ret    

00800e7d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e80:	eb 06                	jmp    800e88 <strcmp+0xb>
		p++, q++;
  800e82:	ff 45 08             	incl   0x8(%ebp)
  800e85:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8a 00                	mov    (%eax),%al
  800e8d:	84 c0                	test   %al,%al
  800e8f:	74 0e                	je     800e9f <strcmp+0x22>
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8a 10                	mov    (%eax),%dl
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	38 c2                	cmp    %al,%dl
  800e9d:	74 e3                	je     800e82 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	0f b6 d0             	movzbl %al,%edx
  800ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	0f b6 c0             	movzbl %al,%eax
  800eaf:	29 c2                	sub    %eax,%edx
  800eb1:	89 d0                	mov    %edx,%eax
}
  800eb3:	5d                   	pop    %ebp
  800eb4:	c3                   	ret    

00800eb5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800eb8:	eb 09                	jmp    800ec3 <strncmp+0xe>
		n--, p++, q++;
  800eba:	ff 4d 10             	decl   0x10(%ebp)
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ec3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec7:	74 17                	je     800ee0 <strncmp+0x2b>
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	84 c0                	test   %al,%al
  800ed0:	74 0e                	je     800ee0 <strncmp+0x2b>
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 10                	mov    (%eax),%dl
  800ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	38 c2                	cmp    %al,%dl
  800ede:	74 da                	je     800eba <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ee0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee4:	75 07                	jne    800eed <strncmp+0x38>
		return 0;
  800ee6:	b8 00 00 00 00       	mov    $0x0,%eax
  800eeb:	eb 14                	jmp    800f01 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	0f b6 d0             	movzbl %al,%edx
  800ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	0f b6 c0             	movzbl %al,%eax
  800efd:	29 c2                	sub    %eax,%edx
  800eff:	89 d0                	mov    %edx,%eax
}
  800f01:	5d                   	pop    %ebp
  800f02:	c3                   	ret    

00800f03 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f03:	55                   	push   %ebp
  800f04:	89 e5                	mov    %esp,%ebp
  800f06:	83 ec 04             	sub    $0x4,%esp
  800f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f0f:	eb 12                	jmp    800f23 <strchr+0x20>
		if (*s == c)
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f19:	75 05                	jne    800f20 <strchr+0x1d>
			return (char *) s;
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	eb 11                	jmp    800f31 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f20:	ff 45 08             	incl   0x8(%ebp)
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	84 c0                	test   %al,%al
  800f2a:	75 e5                	jne    800f11 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f31:	c9                   	leave  
  800f32:	c3                   	ret    

00800f33 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f33:	55                   	push   %ebp
  800f34:	89 e5                	mov    %esp,%ebp
  800f36:	83 ec 04             	sub    $0x4,%esp
  800f39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f3f:	eb 0d                	jmp    800f4e <strfind+0x1b>
		if (*s == c)
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f49:	74 0e                	je     800f59 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	84 c0                	test   %al,%al
  800f55:	75 ea                	jne    800f41 <strfind+0xe>
  800f57:	eb 01                	jmp    800f5a <strfind+0x27>
		if (*s == c)
			break;
  800f59:	90                   	nop
	return (char *) s;
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5d:	c9                   	leave  
  800f5e:	c3                   	ret    

00800f5f <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f5f:	55                   	push   %ebp
  800f60:	89 e5                	mov    %esp,%ebp
  800f62:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f6b:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f6f:	76 63                	jbe    800fd4 <memset+0x75>
		uint64 data_block = c;
  800f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f74:	99                   	cltd   
  800f75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f78:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f81:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f85:	c1 e0 08             	shl    $0x8,%eax
  800f88:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f8b:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f94:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f98:	c1 e0 10             	shl    $0x10,%eax
  800f9b:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f9e:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800fa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa7:	89 c2                	mov    %eax,%edx
  800fa9:	b8 00 00 00 00       	mov    $0x0,%eax
  800fae:	09 45 f0             	or     %eax,-0x10(%ebp)
  800fb1:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800fb4:	eb 18                	jmp    800fce <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800fb6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fb9:	8d 41 08             	lea    0x8(%ecx),%eax
  800fbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800fbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc5:	89 01                	mov    %eax,(%ecx)
  800fc7:	89 51 04             	mov    %edx,0x4(%ecx)
  800fca:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800fce:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fd2:	77 e2                	ja     800fb6 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800fd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd8:	74 23                	je     800ffd <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800fda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fe0:	eb 0e                	jmp    800ff0 <memset+0x91>
			*p8++ = (uint8)c;
  800fe2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe5:	8d 50 01             	lea    0x1(%eax),%edx
  800fe8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800feb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fee:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ff0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ff9:	85 c0                	test   %eax,%eax
  800ffb:	75 e5                	jne    800fe2 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801000:	c9                   	leave  
  801001:	c3                   	ret    

00801002 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801002:	55                   	push   %ebp
  801003:	89 e5                	mov    %esp,%ebp
  801005:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801008:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801014:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801018:	76 24                	jbe    80103e <memcpy+0x3c>
		while(n >= 8){
  80101a:	eb 1c                	jmp    801038 <memcpy+0x36>
			*d64 = *s64;
  80101c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101f:	8b 50 04             	mov    0x4(%eax),%edx
  801022:	8b 00                	mov    (%eax),%eax
  801024:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801027:	89 01                	mov    %eax,(%ecx)
  801029:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  80102c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801030:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801034:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801038:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80103c:	77 de                	ja     80101c <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80103e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801042:	74 31                	je     801075 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801044:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801047:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  80104a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801050:	eb 16                	jmp    801068 <memcpy+0x66>
			*d8++ = *s8++;
  801052:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801055:	8d 50 01             	lea    0x1(%eax),%edx
  801058:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80105b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80105e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801061:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801064:	8a 12                	mov    (%edx),%dl
  801066:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801068:	8b 45 10             	mov    0x10(%ebp),%eax
  80106b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80106e:	89 55 10             	mov    %edx,0x10(%ebp)
  801071:	85 c0                	test   %eax,%eax
  801073:	75 dd                	jne    801052 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80108c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80108f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801092:	73 50                	jae    8010e4 <memmove+0x6a>
  801094:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801097:	8b 45 10             	mov    0x10(%ebp),%eax
  80109a:	01 d0                	add    %edx,%eax
  80109c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80109f:	76 43                	jbe    8010e4 <memmove+0x6a>
		s += n;
  8010a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010aa:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010ad:	eb 10                	jmp    8010bf <memmove+0x45>
			*--d = *--s;
  8010af:	ff 4d f8             	decl   -0x8(%ebp)
  8010b2:	ff 4d fc             	decl   -0x4(%ebp)
  8010b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b8:	8a 10                	mov    (%eax),%dl
  8010ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8010c8:	85 c0                	test   %eax,%eax
  8010ca:	75 e3                	jne    8010af <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010cc:	eb 23                	jmp    8010f1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d1:	8d 50 01             	lea    0x1(%eax),%edx
  8010d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010dd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010e0:	8a 12                	mov    (%edx),%dl
  8010e2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ed:	85 c0                	test   %eax,%eax
  8010ef:	75 dd                	jne    8010ce <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f4:	c9                   	leave  
  8010f5:	c3                   	ret    

008010f6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010f6:	55                   	push   %ebp
  8010f7:	89 e5                	mov    %esp,%ebp
  8010f9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801102:	8b 45 0c             	mov    0xc(%ebp),%eax
  801105:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801108:	eb 2a                	jmp    801134 <memcmp+0x3e>
		if (*s1 != *s2)
  80110a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80110d:	8a 10                	mov    (%eax),%dl
  80110f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801112:	8a 00                	mov    (%eax),%al
  801114:	38 c2                	cmp    %al,%dl
  801116:	74 16                	je     80112e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801118:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80111b:	8a 00                	mov    (%eax),%al
  80111d:	0f b6 d0             	movzbl %al,%edx
  801120:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	0f b6 c0             	movzbl %al,%eax
  801128:	29 c2                	sub    %eax,%edx
  80112a:	89 d0                	mov    %edx,%eax
  80112c:	eb 18                	jmp    801146 <memcmp+0x50>
		s1++, s2++;
  80112e:	ff 45 fc             	incl   -0x4(%ebp)
  801131:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	8d 50 ff             	lea    -0x1(%eax),%edx
  80113a:	89 55 10             	mov    %edx,0x10(%ebp)
  80113d:	85 c0                	test   %eax,%eax
  80113f:	75 c9                	jne    80110a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801141:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
  80114b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80114e:	8b 55 08             	mov    0x8(%ebp),%edx
  801151:	8b 45 10             	mov    0x10(%ebp),%eax
  801154:	01 d0                	add    %edx,%eax
  801156:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801159:	eb 15                	jmp    801170 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	0f b6 d0             	movzbl %al,%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	0f b6 c0             	movzbl %al,%eax
  801169:	39 c2                	cmp    %eax,%edx
  80116b:	74 0d                	je     80117a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80116d:	ff 45 08             	incl   0x8(%ebp)
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801176:	72 e3                	jb     80115b <memfind+0x13>
  801178:	eb 01                	jmp    80117b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80117a:	90                   	nop
	return (void *) s;
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80117e:	c9                   	leave  
  80117f:	c3                   	ret    

00801180 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801180:	55                   	push   %ebp
  801181:	89 e5                	mov    %esp,%ebp
  801183:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801186:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80118d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801194:	eb 03                	jmp    801199 <strtol+0x19>
		s++;
  801196:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801199:	8b 45 08             	mov    0x8(%ebp),%eax
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	3c 20                	cmp    $0x20,%al
  8011a0:	74 f4                	je     801196 <strtol+0x16>
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 09                	cmp    $0x9,%al
  8011a9:	74 eb                	je     801196 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	3c 2b                	cmp    $0x2b,%al
  8011b2:	75 05                	jne    8011b9 <strtol+0x39>
		s++;
  8011b4:	ff 45 08             	incl   0x8(%ebp)
  8011b7:	eb 13                	jmp    8011cc <strtol+0x4c>
	else if (*s == '-')
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	8a 00                	mov    (%eax),%al
  8011be:	3c 2d                	cmp    $0x2d,%al
  8011c0:	75 0a                	jne    8011cc <strtol+0x4c>
		s++, neg = 1;
  8011c2:	ff 45 08             	incl   0x8(%ebp)
  8011c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d0:	74 06                	je     8011d8 <strtol+0x58>
  8011d2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011d6:	75 20                	jne    8011f8 <strtol+0x78>
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	3c 30                	cmp    $0x30,%al
  8011df:	75 17                	jne    8011f8 <strtol+0x78>
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	40                   	inc    %eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3c 78                	cmp    $0x78,%al
  8011e9:	75 0d                	jne    8011f8 <strtol+0x78>
		s += 2, base = 16;
  8011eb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011ef:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011f6:	eb 28                	jmp    801220 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011fc:	75 15                	jne    801213 <strtol+0x93>
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	3c 30                	cmp    $0x30,%al
  801205:	75 0c                	jne    801213 <strtol+0x93>
		s++, base = 8;
  801207:	ff 45 08             	incl   0x8(%ebp)
  80120a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801211:	eb 0d                	jmp    801220 <strtol+0xa0>
	else if (base == 0)
  801213:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801217:	75 07                	jne    801220 <strtol+0xa0>
		base = 10;
  801219:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	3c 2f                	cmp    $0x2f,%al
  801227:	7e 19                	jle    801242 <strtol+0xc2>
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	3c 39                	cmp    $0x39,%al
  801230:	7f 10                	jg     801242 <strtol+0xc2>
			dig = *s - '0';
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	0f be c0             	movsbl %al,%eax
  80123a:	83 e8 30             	sub    $0x30,%eax
  80123d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801240:	eb 42                	jmp    801284 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801242:	8b 45 08             	mov    0x8(%ebp),%eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	3c 60                	cmp    $0x60,%al
  801249:	7e 19                	jle    801264 <strtol+0xe4>
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 7a                	cmp    $0x7a,%al
  801252:	7f 10                	jg     801264 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	0f be c0             	movsbl %al,%eax
  80125c:	83 e8 57             	sub    $0x57,%eax
  80125f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801262:	eb 20                	jmp    801284 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8a 00                	mov    (%eax),%al
  801269:	3c 40                	cmp    $0x40,%al
  80126b:	7e 39                	jle    8012a6 <strtol+0x126>
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	3c 5a                	cmp    $0x5a,%al
  801274:	7f 30                	jg     8012a6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	0f be c0             	movsbl %al,%eax
  80127e:	83 e8 37             	sub    $0x37,%eax
  801281:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801284:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801287:	3b 45 10             	cmp    0x10(%ebp),%eax
  80128a:	7d 19                	jge    8012a5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80128c:	ff 45 08             	incl   0x8(%ebp)
  80128f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801292:	0f af 45 10          	imul   0x10(%ebp),%eax
  801296:	89 c2                	mov    %eax,%edx
  801298:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129b:	01 d0                	add    %edx,%eax
  80129d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012a0:	e9 7b ff ff ff       	jmp    801220 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012a5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012aa:	74 08                	je     8012b4 <strtol+0x134>
		*endptr = (char *) s;
  8012ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012af:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012b8:	74 07                	je     8012c1 <strtol+0x141>
  8012ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bd:	f7 d8                	neg    %eax
  8012bf:	eb 03                	jmp    8012c4 <strtol+0x144>
  8012c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <ltostr>:

void
ltostr(long value, char *str)
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
  8012c9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012de:	79 13                	jns    8012f3 <ltostr+0x2d>
	{
		neg = 1;
  8012e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ea:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012ed:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012f0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012fb:	99                   	cltd   
  8012fc:	f7 f9                	idiv   %ecx
  8012fe:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801301:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801304:	8d 50 01             	lea    0x1(%eax),%edx
  801307:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80130a:	89 c2                	mov    %eax,%edx
  80130c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130f:	01 d0                	add    %edx,%eax
  801311:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801314:	83 c2 30             	add    $0x30,%edx
  801317:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801319:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80131c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801321:	f7 e9                	imul   %ecx
  801323:	c1 fa 02             	sar    $0x2,%edx
  801326:	89 c8                	mov    %ecx,%eax
  801328:	c1 f8 1f             	sar    $0x1f,%eax
  80132b:	29 c2                	sub    %eax,%edx
  80132d:	89 d0                	mov    %edx,%eax
  80132f:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801332:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801336:	75 bb                	jne    8012f3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801338:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80133f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801342:	48                   	dec    %eax
  801343:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801346:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80134a:	74 3d                	je     801389 <ltostr+0xc3>
		start = 1 ;
  80134c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801353:	eb 34                	jmp    801389 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801355:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801358:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135b:	01 d0                	add    %edx,%eax
  80135d:	8a 00                	mov    (%eax),%al
  80135f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801362:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801365:	8b 45 0c             	mov    0xc(%ebp),%eax
  801368:	01 c2                	add    %eax,%edx
  80136a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80136d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801370:	01 c8                	add    %ecx,%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801376:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	01 c2                	add    %eax,%edx
  80137e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801381:	88 02                	mov    %al,(%edx)
		start++ ;
  801383:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801386:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801389:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80138c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80138f:	7c c4                	jl     801355 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801391:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	01 d0                	add    %edx,%eax
  801399:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80139c:	90                   	nop
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
  8013a2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013a5:	ff 75 08             	pushl  0x8(%ebp)
  8013a8:	e8 c4 f9 ff ff       	call   800d71 <strlen>
  8013ad:	83 c4 04             	add    $0x4,%esp
  8013b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013b3:	ff 75 0c             	pushl  0xc(%ebp)
  8013b6:	e8 b6 f9 ff ff       	call   800d71 <strlen>
  8013bb:	83 c4 04             	add    $0x4,%esp
  8013be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cf:	eb 17                	jmp    8013e8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d7:	01 c2                	add    %eax,%edx
  8013d9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	01 c8                	add    %ecx,%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013e5:	ff 45 fc             	incl   -0x4(%ebp)
  8013e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ee:	7c e1                	jl     8013d1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013fe:	eb 1f                	jmp    80141f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801400:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801403:	8d 50 01             	lea    0x1(%eax),%edx
  801406:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801409:	89 c2                	mov    %eax,%edx
  80140b:	8b 45 10             	mov    0x10(%ebp),%eax
  80140e:	01 c2                	add    %eax,%edx
  801410:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	01 c8                	add    %ecx,%eax
  801418:	8a 00                	mov    (%eax),%al
  80141a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80141c:	ff 45 f8             	incl   -0x8(%ebp)
  80141f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801422:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801425:	7c d9                	jl     801400 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801427:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142a:	8b 45 10             	mov    0x10(%ebp),%eax
  80142d:	01 d0                	add    %edx,%eax
  80142f:	c6 00 00             	movb   $0x0,(%eax)
}
  801432:	90                   	nop
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801438:	8b 45 14             	mov    0x14(%ebp),%eax
  80143b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801441:	8b 45 14             	mov    0x14(%ebp),%eax
  801444:	8b 00                	mov    (%eax),%eax
  801446:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80144d:	8b 45 10             	mov    0x10(%ebp),%eax
  801450:	01 d0                	add    %edx,%eax
  801452:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801458:	eb 0c                	jmp    801466 <strsplit+0x31>
			*string++ = 0;
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	8d 50 01             	lea    0x1(%eax),%edx
  801460:	89 55 08             	mov    %edx,0x8(%ebp)
  801463:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	84 c0                	test   %al,%al
  80146d:	74 18                	je     801487 <strsplit+0x52>
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	0f be c0             	movsbl %al,%eax
  801477:	50                   	push   %eax
  801478:	ff 75 0c             	pushl  0xc(%ebp)
  80147b:	e8 83 fa ff ff       	call   800f03 <strchr>
  801480:	83 c4 08             	add    $0x8,%esp
  801483:	85 c0                	test   %eax,%eax
  801485:	75 d3                	jne    80145a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	8a 00                	mov    (%eax),%al
  80148c:	84 c0                	test   %al,%al
  80148e:	74 5a                	je     8014ea <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801490:	8b 45 14             	mov    0x14(%ebp),%eax
  801493:	8b 00                	mov    (%eax),%eax
  801495:	83 f8 0f             	cmp    $0xf,%eax
  801498:	75 07                	jne    8014a1 <strsplit+0x6c>
		{
			return 0;
  80149a:	b8 00 00 00 00       	mov    $0x0,%eax
  80149f:	eb 66                	jmp    801507 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a4:	8b 00                	mov    (%eax),%eax
  8014a6:	8d 48 01             	lea    0x1(%eax),%ecx
  8014a9:	8b 55 14             	mov    0x14(%ebp),%edx
  8014ac:	89 0a                	mov    %ecx,(%edx)
  8014ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b8:	01 c2                	add    %eax,%edx
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014bf:	eb 03                	jmp    8014c4 <strsplit+0x8f>
			string++;
  8014c1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	8a 00                	mov    (%eax),%al
  8014c9:	84 c0                	test   %al,%al
  8014cb:	74 8b                	je     801458 <strsplit+0x23>
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	0f be c0             	movsbl %al,%eax
  8014d5:	50                   	push   %eax
  8014d6:	ff 75 0c             	pushl  0xc(%ebp)
  8014d9:	e8 25 fa ff ff       	call   800f03 <strchr>
  8014de:	83 c4 08             	add    $0x8,%esp
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	74 dc                	je     8014c1 <strsplit+0x8c>
			string++;
	}
  8014e5:	e9 6e ff ff ff       	jmp    801458 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014ea:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ee:	8b 00                	mov    (%eax),%eax
  8014f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fa:	01 d0                	add    %edx,%eax
  8014fc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801502:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801507:	c9                   	leave  
  801508:	c3                   	ret    

00801509 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801509:	55                   	push   %ebp
  80150a:	89 e5                	mov    %esp,%ebp
  80150c:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80150f:	8b 45 08             	mov    0x8(%ebp),%eax
  801512:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801515:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80151c:	eb 4a                	jmp    801568 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80151e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	01 c2                	add    %eax,%edx
  801526:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152c:	01 c8                	add    %ecx,%eax
  80152e:	8a 00                	mov    (%eax),%al
  801530:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801532:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801535:	8b 45 0c             	mov    0xc(%ebp),%eax
  801538:	01 d0                	add    %edx,%eax
  80153a:	8a 00                	mov    (%eax),%al
  80153c:	3c 40                	cmp    $0x40,%al
  80153e:	7e 25                	jle    801565 <str2lower+0x5c>
  801540:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	01 d0                	add    %edx,%eax
  801548:	8a 00                	mov    (%eax),%al
  80154a:	3c 5a                	cmp    $0x5a,%al
  80154c:	7f 17                	jg     801565 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80154e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801559:	8b 55 08             	mov    0x8(%ebp),%edx
  80155c:	01 ca                	add    %ecx,%edx
  80155e:	8a 12                	mov    (%edx),%dl
  801560:	83 c2 20             	add    $0x20,%edx
  801563:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801565:	ff 45 fc             	incl   -0x4(%ebp)
  801568:	ff 75 0c             	pushl  0xc(%ebp)
  80156b:	e8 01 f8 ff ff       	call   800d71 <strlen>
  801570:	83 c4 04             	add    $0x4,%esp
  801573:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801576:	7f a6                	jg     80151e <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801578:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801583:	a1 08 30 80 00       	mov    0x803008,%eax
  801588:	85 c0                	test   %eax,%eax
  80158a:	74 2d                	je     8015b9 <uheap_init+0x3c>
	{
		buddy_init();
  80158c:	e8 87 06 00 00       	call   801c18 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801591:	e8 31 05 00 00       	call   801ac7 <sys_get_uheap_strategy>
  801596:	a3 48 30 80 00       	mov    %eax,0x803048
		uheapPageAllocStart = USER_HEAP_START;
  80159b:	c7 05 20 31 80 00 00 	movl   $0x80000000,0x803120
  8015a2:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  8015a5:	c7 05 4c 30 80 00 00 	movl   $0x80000000,0x80304c
  8015ac:	00 00 80 
		__firstTimeFlag = 0;
  8015af:	c7 05 08 30 80 00 00 	movl   $0x0,0x803008
  8015b6:	00 00 00 
	}
}
  8015b9:	90                   	nop
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  8015c2:	83 ec 04             	sub    $0x4,%esp
  8015c5:	68 e8 26 80 00       	push   $0x8026e8
  8015ca:	6a 25                	push   $0x25
  8015cc:	68 19 27 80 00       	push   $0x802719
  8015d1:	e8 f4 ed ff ff       	call   8003ca <_panic>

008015d6 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
  8015d9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  8015dc:	83 ec 04             	sub    $0x4,%esp
  8015df:	68 28 27 80 00       	push   $0x802728
  8015e4:	6a 2f                	push   $0x2f
  8015e6:	68 19 27 80 00       	push   $0x802719
  8015eb:	e8 da ed ff ff       	call   8003ca <_panic>

008015f0 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
  8015f3:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8015f6:	e8 82 ff ff ff       	call   80157d <uheap_init>
	if (size == 0) return NULL ;
  8015fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015ff:	75 07                	jne    801608 <malloc+0x18>
  801601:	b8 00 00 00 00       	mov    $0x0,%eax
  801606:	eb 14                	jmp    80161c <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801608:	83 ec 04             	sub    $0x4,%esp
  80160b:	68 5c 27 80 00       	push   $0x80275c
  801610:	6a 43                	push   $0x43
  801612:	68 19 27 80 00       	push   $0x802719
  801617:	e8 ae ed ff ff       	call   8003ca <_panic>
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
  801621:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801624:	83 ec 04             	sub    $0x4,%esp
  801627:	68 84 27 80 00       	push   $0x802784
  80162c:	6a 4e                	push   $0x4e
  80162e:	68 19 27 80 00       	push   $0x802719
  801633:	e8 92 ed ff ff       	call   8003ca <_panic>

00801638 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 18             	sub    $0x18,%esp
  80163e:	8b 45 10             	mov    0x10(%ebp),%eax
  801641:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801644:	e8 34 ff ff ff       	call   80157d <uheap_init>
	if (size == 0) return NULL ;
  801649:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80164d:	75 07                	jne    801656 <smalloc+0x1e>
  80164f:	b8 00 00 00 00       	mov    $0x0,%eax
  801654:	eb 14                	jmp    80166a <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801656:	83 ec 04             	sub    $0x4,%esp
  801659:	68 a8 27 80 00       	push   $0x8027a8
  80165e:	6a 5f                	push   $0x5f
  801660:	68 19 27 80 00       	push   $0x802719
  801665:	e8 60 ed ff ff       	call   8003ca <_panic>
}
  80166a:	c9                   	leave  
  80166b:	c3                   	ret    

0080166c <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
  80166f:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801672:	e8 06 ff ff ff       	call   80157d <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801677:	83 ec 04             	sub    $0x4,%esp
  80167a:	68 d0 27 80 00       	push   $0x8027d0
  80167f:	6a 6f                	push   $0x6f
  801681:	68 19 27 80 00       	push   $0x802719
  801686:	e8 3f ed ff ff       	call   8003ca <_panic>

0080168b <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
  80168e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801691:	83 ec 04             	sub    $0x4,%esp
  801694:	68 f4 27 80 00       	push   $0x8027f4
  801699:	6a 7e                	push   $0x7e
  80169b:	68 19 27 80 00       	push   $0x802719
  8016a0:	e8 25 ed ff ff       	call   8003ca <_panic>

008016a5 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
  8016a8:	57                   	push   %edi
  8016a9:	56                   	push   %esi
  8016aa:	53                   	push   %ebx
  8016ab:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ba:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016bd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016c0:	cd 30                	int    $0x30
  8016c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016c8:	83 c4 10             	add    $0x10,%esp
  8016cb:	5b                   	pop    %ebx
  8016cc:	5e                   	pop    %esi
  8016cd:	5f                   	pop    %edi
  8016ce:	5d                   	pop    %ebp
  8016cf:	c3                   	ret    

008016d0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 04             	sub    $0x4,%esp
  8016d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016dc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016df:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	6a 00                	push   $0x0
  8016e8:	51                   	push   %ecx
  8016e9:	52                   	push   %edx
  8016ea:	ff 75 0c             	pushl  0xc(%ebp)
  8016ed:	50                   	push   %eax
  8016ee:	6a 00                	push   $0x0
  8016f0:	e8 b0 ff ff ff       	call   8016a5 <syscall>
  8016f5:	83 c4 18             	add    $0x18,%esp
}
  8016f8:	90                   	nop
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_cgetc>:

int
sys_cgetc(void)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 02                	push   $0x2
  80170a:	e8 96 ff ff ff       	call   8016a5 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 03                	push   $0x3
  801723:	e8 7d ff ff ff       	call   8016a5 <syscall>
  801728:	83 c4 18             	add    $0x18,%esp
}
  80172b:	90                   	nop
  80172c:	c9                   	leave  
  80172d:	c3                   	ret    

0080172e <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80172e:	55                   	push   %ebp
  80172f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 04                	push   $0x4
  80173d:	e8 63 ff ff ff       	call   8016a5 <syscall>
  801742:	83 c4 18             	add    $0x18,%esp
}
  801745:	90                   	nop
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80174b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174e:	8b 45 08             	mov    0x8(%ebp),%eax
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	52                   	push   %edx
  801758:	50                   	push   %eax
  801759:	6a 08                	push   $0x8
  80175b:	e8 45 ff ff ff       	call   8016a5 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
  801768:	56                   	push   %esi
  801769:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80176a:	8b 75 18             	mov    0x18(%ebp),%esi
  80176d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801770:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801773:	8b 55 0c             	mov    0xc(%ebp),%edx
  801776:	8b 45 08             	mov    0x8(%ebp),%eax
  801779:	56                   	push   %esi
  80177a:	53                   	push   %ebx
  80177b:	51                   	push   %ecx
  80177c:	52                   	push   %edx
  80177d:	50                   	push   %eax
  80177e:	6a 09                	push   $0x9
  801780:	e8 20 ff ff ff       	call   8016a5 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80178b:	5b                   	pop    %ebx
  80178c:	5e                   	pop    %esi
  80178d:	5d                   	pop    %ebp
  80178e:	c3                   	ret    

0080178f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	ff 75 08             	pushl  0x8(%ebp)
  80179d:	6a 0a                	push   $0xa
  80179f:	e8 01 ff ff ff       	call   8016a5 <syscall>
  8017a4:	83 c4 18             	add    $0x18,%esp
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	ff 75 0c             	pushl  0xc(%ebp)
  8017b5:	ff 75 08             	pushl  0x8(%ebp)
  8017b8:	6a 0b                	push   $0xb
  8017ba:	e8 e6 fe ff ff       	call   8016a5 <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 0c                	push   $0xc
  8017d3:	e8 cd fe ff ff       	call   8016a5 <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 0d                	push   $0xd
  8017ec:	e8 b4 fe ff ff       	call   8016a5 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 0e                	push   $0xe
  801805:	e8 9b fe ff ff       	call   8016a5 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 0f                	push   $0xf
  80181e:	e8 82 fe ff ff       	call   8016a5 <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	ff 75 08             	pushl  0x8(%ebp)
  801836:	6a 10                	push   $0x10
  801838:	e8 68 fe ff ff       	call   8016a5 <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
}
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 11                	push   $0x11
  801851:	e8 4f fe ff ff       	call   8016a5 <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
}
  801859:	90                   	nop
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_cputc>:

void
sys_cputc(const char c)
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
  80185f:	83 ec 04             	sub    $0x4,%esp
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801868:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	50                   	push   %eax
  801875:	6a 01                	push   $0x1
  801877:	e8 29 fe ff ff       	call   8016a5 <syscall>
  80187c:	83 c4 18             	add    $0x18,%esp
}
  80187f:	90                   	nop
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 14                	push   $0x14
  801891:	e8 0f fe ff ff       	call   8016a5 <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	90                   	nop
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
  80189f:	83 ec 04             	sub    $0x4,%esp
  8018a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018a8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018ab:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	6a 00                	push   $0x0
  8018b4:	51                   	push   %ecx
  8018b5:	52                   	push   %edx
  8018b6:	ff 75 0c             	pushl  0xc(%ebp)
  8018b9:	50                   	push   %eax
  8018ba:	6a 15                	push   $0x15
  8018bc:	e8 e4 fd ff ff       	call   8016a5 <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018c9:	8b 55 10             	mov    0x10(%ebp),%edx
  8018cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	52                   	push   %edx
  8018d4:	50                   	push   %eax
  8018d5:	ff 75 08             	pushl  0x8(%ebp)
  8018d8:	6a 16                	push   $0x16
  8018da:	e8 c6 fd ff ff       	call   8016a5 <syscall>
  8018df:	83 c4 18             	add    $0x18,%esp
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	52                   	push   %edx
  8018f4:	50                   	push   %eax
  8018f5:	6a 17                	push   $0x17
  8018f7:	e8 a9 fd ff ff       	call   8016a5 <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
}
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801904:	8b 55 0c             	mov    0xc(%ebp),%edx
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	52                   	push   %edx
  801911:	50                   	push   %eax
  801912:	6a 18                	push   $0x18
  801914:	e8 8c fd ff ff       	call   8016a5 <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
}
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	6a 00                	push   $0x0
  801926:	ff 75 14             	pushl  0x14(%ebp)
  801929:	ff 75 10             	pushl  0x10(%ebp)
  80192c:	ff 75 0c             	pushl  0xc(%ebp)
  80192f:	50                   	push   %eax
  801930:	6a 19                	push   $0x19
  801932:	e8 6e fd ff ff       	call   8016a5 <syscall>
  801937:	83 c4 18             	add    $0x18,%esp
}
  80193a:	c9                   	leave  
  80193b:	c3                   	ret    

0080193c <sys_run_env>:

void sys_run_env(int32 envId)
{
  80193c:	55                   	push   %ebp
  80193d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	50                   	push   %eax
  80194b:	6a 1a                	push   $0x1a
  80194d:	e8 53 fd ff ff       	call   8016a5 <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	90                   	nop
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	50                   	push   %eax
  801967:	6a 1b                	push   $0x1b
  801969:	e8 37 fd ff ff       	call   8016a5 <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
}
  801971:	c9                   	leave  
  801972:	c3                   	ret    

00801973 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801973:	55                   	push   %ebp
  801974:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 05                	push   $0x5
  801982:	e8 1e fd ff ff       	call   8016a5 <syscall>
  801987:	83 c4 18             	add    $0x18,%esp
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 06                	push   $0x6
  80199b:	e8 05 fd ff ff       	call   8016a5 <syscall>
  8019a0:	83 c4 18             	add    $0x18,%esp
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 07                	push   $0x7
  8019b4:	e8 ec fc ff ff       	call   8016a5 <syscall>
  8019b9:	83 c4 18             	add    $0x18,%esp
}
  8019bc:	c9                   	leave  
  8019bd:	c3                   	ret    

008019be <sys_exit_env>:


void sys_exit_env(void)
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 1c                	push   $0x1c
  8019cd:	e8 d3 fc ff ff       	call   8016a5 <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	90                   	nop
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	ff 75 10             	pushl  0x10(%ebp)
  8019e2:	ff 75 0c             	pushl  0xc(%ebp)
  8019e5:	ff 75 08             	pushl  0x8(%ebp)
  8019e8:	6a 13                	push   $0x13
  8019ea:	e8 b6 fc ff ff       	call   8016a5 <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f2:	90                   	nop
}
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 1e                	push   $0x1e
  801a04:	e8 9c fc ff ff       	call   8016a5 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
}
  801a0c:	c9                   	leave  
  801a0d:	c3                   	ret    

00801a0e <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 04             	sub    $0x4,%esp
  801a14:	8b 45 08             	mov    0x8(%ebp),%eax
  801a17:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a1a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	50                   	push   %eax
  801a27:	6a 1f                	push   $0x1f
  801a29:	e8 77 fc ff ff       	call   8016a5 <syscall>
  801a2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a31:	90                   	nop
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <rsttst>:
void rsttst()
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 21                	push   $0x21
  801a43:	e8 5d fc ff ff       	call   8016a5 <syscall>
  801a48:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4b:	90                   	nop
}
  801a4c:	c9                   	leave  
  801a4d:	c3                   	ret    

00801a4e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
  801a51:	83 ec 04             	sub    $0x4,%esp
  801a54:	8b 45 14             	mov    0x14(%ebp),%eax
  801a57:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a5a:	8b 55 18             	mov    0x18(%ebp),%edx
  801a5d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a61:	52                   	push   %edx
  801a62:	50                   	push   %eax
  801a63:	ff 75 10             	pushl  0x10(%ebp)
  801a66:	ff 75 0c             	pushl  0xc(%ebp)
  801a69:	ff 75 08             	pushl  0x8(%ebp)
  801a6c:	6a 20                	push   $0x20
  801a6e:	e8 32 fc ff ff       	call   8016a5 <syscall>
  801a73:	83 c4 18             	add    $0x18,%esp
	return ;
  801a76:	90                   	nop
}
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <chktst>:
void chktst(uint32 n)
{
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	ff 75 08             	pushl  0x8(%ebp)
  801a87:	6a 22                	push   $0x22
  801a89:	e8 17 fc ff ff       	call   8016a5 <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a91:	90                   	nop
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <inctst>:

void inctst()
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 23                	push   $0x23
  801aa3:	e8 fd fb ff ff       	call   8016a5 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
	return ;
  801aab:	90                   	nop
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <gettst>:
uint32 gettst()
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 24                	push   $0x24
  801abd:	e8 e3 fb ff ff       	call   8016a5 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 25                	push   $0x25
  801ad6:	e8 ca fb ff ff       	call   8016a5 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
  801ade:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801ae3:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	ff 75 08             	pushl  0x8(%ebp)
  801b00:	6a 26                	push   $0x26
  801b02:	e8 9e fb ff ff       	call   8016a5 <syscall>
  801b07:	83 c4 18             	add    $0x18,%esp
	return ;
  801b0a:	90                   	nop
}
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
  801b10:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b11:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b14:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	53                   	push   %ebx
  801b20:	51                   	push   %ecx
  801b21:	52                   	push   %edx
  801b22:	50                   	push   %eax
  801b23:	6a 27                	push   $0x27
  801b25:	e8 7b fb ff ff       	call   8016a5 <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b30:	c9                   	leave  
  801b31:	c3                   	ret    

00801b32 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b35:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b38:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	52                   	push   %edx
  801b42:	50                   	push   %eax
  801b43:	6a 28                	push   $0x28
  801b45:	e8 5b fb ff ff       	call   8016a5 <syscall>
  801b4a:	83 c4 18             	add    $0x18,%esp
}
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b52:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b58:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5b:	6a 00                	push   $0x0
  801b5d:	51                   	push   %ecx
  801b5e:	ff 75 10             	pushl  0x10(%ebp)
  801b61:	52                   	push   %edx
  801b62:	50                   	push   %eax
  801b63:	6a 29                	push   $0x29
  801b65:	e8 3b fb ff ff       	call   8016a5 <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
}
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	ff 75 10             	pushl  0x10(%ebp)
  801b79:	ff 75 0c             	pushl  0xc(%ebp)
  801b7c:	ff 75 08             	pushl  0x8(%ebp)
  801b7f:	6a 12                	push   $0x12
  801b81:	e8 1f fb ff ff       	call   8016a5 <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
	return ;
  801b89:	90                   	nop
}
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b92:	8b 45 08             	mov    0x8(%ebp),%eax
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	52                   	push   %edx
  801b9c:	50                   	push   %eax
  801b9d:	6a 2a                	push   $0x2a
  801b9f:	e8 01 fb ff ff       	call   8016a5 <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
	return;
  801ba7:	90                   	nop
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 2b                	push   $0x2b
  801bb9:	e8 e7 fa ff ff       	call   8016a5 <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
}
  801bc1:	c9                   	leave  
  801bc2:	c3                   	ret    

00801bc3 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bc3:	55                   	push   %ebp
  801bc4:	89 e5                	mov    %esp,%ebp
  801bc6:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bc9:	83 ec 04             	sub    $0x4,%esp
  801bcc:	68 18 28 80 00       	push   $0x802818
  801bd1:	68 0a 01 00 00       	push   $0x10a
  801bd6:	68 28 28 80 00       	push   $0x802828
  801bdb:	e8 ea e7 ff ff       	call   8003ca <_panic>

00801be0 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	ff 75 0c             	pushl  0xc(%ebp)
  801bec:	ff 75 08             	pushl  0x8(%ebp)
  801bef:	6a 33                	push   $0x33
  801bf1:	e8 af fa ff ff       	call   8016a5 <syscall>
  801bf6:	83 c4 18             	add    $0x18,%esp
	return;
  801bf9:	90                   	nop
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	ff 75 0c             	pushl  0xc(%ebp)
  801c08:	ff 75 08             	pushl  0x8(%ebp)
  801c0b:	6a 34                	push   $0x34
  801c0d:	e8 93 fa ff ff       	call   8016a5 <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
	return ;
  801c15:	90                   	nop
}
  801c16:	c9                   	leave  
  801c17:	c3                   	ret    

00801c18 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801c18:	55                   	push   %ebp
  801c19:	89 e5                	mov    %esp,%ebp
  801c1b:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c1e:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801c25:	eb 36                	jmp    801c5d <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801c27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c2a:	c1 e0 04             	shl    $0x4,%eax
  801c2d:	05 60 30 80 00       	add    $0x803060,%eax
  801c32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c3b:	c1 e0 04             	shl    $0x4,%eax
  801c3e:	05 64 30 80 00       	add    $0x803064,%eax
  801c43:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c4c:	c1 e0 04             	shl    $0x4,%eax
  801c4f:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c5a:	ff 45 fc             	incl   -0x4(%ebp)
  801c5d:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801c61:	7e c4                	jle    801c27 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801c63:	90                   	nop
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
  801c69:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c6c:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801c73:	eb 24                	jmp    801c99 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801c75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c78:	c1 e0 04             	shl    $0x4,%eax
  801c7b:	05 6c 30 80 00       	add    $0x80306c,%eax
  801c80:	8b 00                	mov    (%eax),%eax
  801c82:	83 ec 04             	sub    $0x4,%esp
  801c85:	50                   	push   %eax
  801c86:	ff 75 f4             	pushl  -0xc(%ebp)
  801c89:	68 38 28 80 00       	push   $0x802838
  801c8e:	e8 05 ea ff ff       	call   800698 <cprintf>
  801c93:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c96:	ff 45 f4             	incl   -0xc(%ebp)
  801c99:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801c9d:	7e d6                	jle    801c75 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801c9f:	90                   	nop
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
  801ca5:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [1] get_block_size
	//Your code is here
	//Comment the following line
	panic("get_block_size() not implemented");
  801ca8:	83 ec 04             	sub    $0x4,%esp
  801cab:	68 48 28 80 00       	push   $0x802848
  801cb0:	6a 33                	push   $0x33
  801cb2:	68 69 28 80 00       	push   $0x802869
  801cb7:	e8 0e e7 ff ff       	call   8003ca <_panic>

00801cbc <alloc_block>:
}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801cbc:	55                   	push   %ebp
  801cbd:	89 e5                	mov    %esp,%ebp
  801cbf:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	panic("alloc_block() not implemented");
  801cc2:	83 ec 04             	sub    $0x4,%esp
  801cc5:	68 81 28 80 00       	push   $0x802881
  801cca:	6a 3e                	push   $0x3e
  801ccc:	68 69 28 80 00       	push   $0x802869
  801cd1:	e8 f4 e6 ff ff       	call   8003ca <_panic>

00801cd6 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  801cd6:	55                   	push   %ebp
  801cd7:	89 e5                	mov    %esp,%ebp
  801cd9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [3] free_block
	//Your code is here
	//Comment the following line
	panic("free_block() not implemented");
  801cdc:	83 ec 04             	sub    $0x4,%esp
  801cdf:	68 9f 28 80 00       	push   $0x80289f
  801ce4:	6a 49                	push   $0x49
  801ce6:	68 69 28 80 00       	push   $0x802869
  801ceb:	e8 da e6 ff ff       	call   8003ca <_panic>

00801cf0 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  801cf0:	55                   	push   %ebp
  801cf1:	89 e5                	mov    %esp,%ebp
  801cf3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  801cf6:	83 ec 04             	sub    $0x4,%esp
  801cf9:	68 bc 28 80 00       	push   $0x8028bc
  801cfe:	6a 58                	push   $0x58
  801d00:	68 69 28 80 00       	push   $0x802869
  801d05:	e8 c0 e6 ff ff       	call   8003ca <_panic>
  801d0a:	66 90                	xchg   %ax,%ax

00801d0c <__udivdi3>:
  801d0c:	55                   	push   %ebp
  801d0d:	57                   	push   %edi
  801d0e:	56                   	push   %esi
  801d0f:	53                   	push   %ebx
  801d10:	83 ec 1c             	sub    $0x1c,%esp
  801d13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d23:	89 ca                	mov    %ecx,%edx
  801d25:	89 f8                	mov    %edi,%eax
  801d27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2b:	85 f6                	test   %esi,%esi
  801d2d:	75 2d                	jne    801d5c <__udivdi3+0x50>
  801d2f:	39 cf                	cmp    %ecx,%edi
  801d31:	77 65                	ja     801d98 <__udivdi3+0x8c>
  801d33:	89 fd                	mov    %edi,%ebp
  801d35:	85 ff                	test   %edi,%edi
  801d37:	75 0b                	jne    801d44 <__udivdi3+0x38>
  801d39:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3e:	31 d2                	xor    %edx,%edx
  801d40:	f7 f7                	div    %edi
  801d42:	89 c5                	mov    %eax,%ebp
  801d44:	31 d2                	xor    %edx,%edx
  801d46:	89 c8                	mov    %ecx,%eax
  801d48:	f7 f5                	div    %ebp
  801d4a:	89 c1                	mov    %eax,%ecx
  801d4c:	89 d8                	mov    %ebx,%eax
  801d4e:	f7 f5                	div    %ebp
  801d50:	89 cf                	mov    %ecx,%edi
  801d52:	89 fa                	mov    %edi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	39 ce                	cmp    %ecx,%esi
  801d5e:	77 28                	ja     801d88 <__udivdi3+0x7c>
  801d60:	0f bd fe             	bsr    %esi,%edi
  801d63:	83 f7 1f             	xor    $0x1f,%edi
  801d66:	75 40                	jne    801da8 <__udivdi3+0x9c>
  801d68:	39 ce                	cmp    %ecx,%esi
  801d6a:	72 0a                	jb     801d76 <__udivdi3+0x6a>
  801d6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d70:	0f 87 9e 00 00 00    	ja     801e14 <__udivdi3+0x108>
  801d76:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7b:	89 fa                	mov    %edi,%edx
  801d7d:	83 c4 1c             	add    $0x1c,%esp
  801d80:	5b                   	pop    %ebx
  801d81:	5e                   	pop    %esi
  801d82:	5f                   	pop    %edi
  801d83:	5d                   	pop    %ebp
  801d84:	c3                   	ret    
  801d85:	8d 76 00             	lea    0x0(%esi),%esi
  801d88:	31 ff                	xor    %edi,%edi
  801d8a:	31 c0                	xor    %eax,%eax
  801d8c:	89 fa                	mov    %edi,%edx
  801d8e:	83 c4 1c             	add    $0x1c,%esp
  801d91:	5b                   	pop    %ebx
  801d92:	5e                   	pop    %esi
  801d93:	5f                   	pop    %edi
  801d94:	5d                   	pop    %ebp
  801d95:	c3                   	ret    
  801d96:	66 90                	xchg   %ax,%ax
  801d98:	89 d8                	mov    %ebx,%eax
  801d9a:	f7 f7                	div    %edi
  801d9c:	31 ff                	xor    %edi,%edi
  801d9e:	89 fa                	mov    %edi,%edx
  801da0:	83 c4 1c             	add    $0x1c,%esp
  801da3:	5b                   	pop    %ebx
  801da4:	5e                   	pop    %esi
  801da5:	5f                   	pop    %edi
  801da6:	5d                   	pop    %ebp
  801da7:	c3                   	ret    
  801da8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dad:	89 eb                	mov    %ebp,%ebx
  801daf:	29 fb                	sub    %edi,%ebx
  801db1:	89 f9                	mov    %edi,%ecx
  801db3:	d3 e6                	shl    %cl,%esi
  801db5:	89 c5                	mov    %eax,%ebp
  801db7:	88 d9                	mov    %bl,%cl
  801db9:	d3 ed                	shr    %cl,%ebp
  801dbb:	89 e9                	mov    %ebp,%ecx
  801dbd:	09 f1                	or     %esi,%ecx
  801dbf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc3:	89 f9                	mov    %edi,%ecx
  801dc5:	d3 e0                	shl    %cl,%eax
  801dc7:	89 c5                	mov    %eax,%ebp
  801dc9:	89 d6                	mov    %edx,%esi
  801dcb:	88 d9                	mov    %bl,%cl
  801dcd:	d3 ee                	shr    %cl,%esi
  801dcf:	89 f9                	mov    %edi,%ecx
  801dd1:	d3 e2                	shl    %cl,%edx
  801dd3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd7:	88 d9                	mov    %bl,%cl
  801dd9:	d3 e8                	shr    %cl,%eax
  801ddb:	09 c2                	or     %eax,%edx
  801ddd:	89 d0                	mov    %edx,%eax
  801ddf:	89 f2                	mov    %esi,%edx
  801de1:	f7 74 24 0c          	divl   0xc(%esp)
  801de5:	89 d6                	mov    %edx,%esi
  801de7:	89 c3                	mov    %eax,%ebx
  801de9:	f7 e5                	mul    %ebp
  801deb:	39 d6                	cmp    %edx,%esi
  801ded:	72 19                	jb     801e08 <__udivdi3+0xfc>
  801def:	74 0b                	je     801dfc <__udivdi3+0xf0>
  801df1:	89 d8                	mov    %ebx,%eax
  801df3:	31 ff                	xor    %edi,%edi
  801df5:	e9 58 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801dfa:	66 90                	xchg   %ax,%ax
  801dfc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e00:	89 f9                	mov    %edi,%ecx
  801e02:	d3 e2                	shl    %cl,%edx
  801e04:	39 c2                	cmp    %eax,%edx
  801e06:	73 e9                	jae    801df1 <__udivdi3+0xe5>
  801e08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 40 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	31 c0                	xor    %eax,%eax
  801e16:	e9 37 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e1b:	90                   	nop

00801e1c <__umoddi3>:
  801e1c:	55                   	push   %ebp
  801e1d:	57                   	push   %edi
  801e1e:	56                   	push   %esi
  801e1f:	53                   	push   %ebx
  801e20:	83 ec 1c             	sub    $0x1c,%esp
  801e23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3b:	89 f3                	mov    %esi,%ebx
  801e3d:	89 fa                	mov    %edi,%edx
  801e3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e43:	89 34 24             	mov    %esi,(%esp)
  801e46:	85 c0                	test   %eax,%eax
  801e48:	75 1a                	jne    801e64 <__umoddi3+0x48>
  801e4a:	39 f7                	cmp    %esi,%edi
  801e4c:	0f 86 a2 00 00 00    	jbe    801ef4 <__umoddi3+0xd8>
  801e52:	89 c8                	mov    %ecx,%eax
  801e54:	89 f2                	mov    %esi,%edx
  801e56:	f7 f7                	div    %edi
  801e58:	89 d0                	mov    %edx,%eax
  801e5a:	31 d2                	xor    %edx,%edx
  801e5c:	83 c4 1c             	add    $0x1c,%esp
  801e5f:	5b                   	pop    %ebx
  801e60:	5e                   	pop    %esi
  801e61:	5f                   	pop    %edi
  801e62:	5d                   	pop    %ebp
  801e63:	c3                   	ret    
  801e64:	39 f0                	cmp    %esi,%eax
  801e66:	0f 87 ac 00 00 00    	ja     801f18 <__umoddi3+0xfc>
  801e6c:	0f bd e8             	bsr    %eax,%ebp
  801e6f:	83 f5 1f             	xor    $0x1f,%ebp
  801e72:	0f 84 ac 00 00 00    	je     801f24 <__umoddi3+0x108>
  801e78:	bf 20 00 00 00       	mov    $0x20,%edi
  801e7d:	29 ef                	sub    %ebp,%edi
  801e7f:	89 fe                	mov    %edi,%esi
  801e81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e85:	89 e9                	mov    %ebp,%ecx
  801e87:	d3 e0                	shl    %cl,%eax
  801e89:	89 d7                	mov    %edx,%edi
  801e8b:	89 f1                	mov    %esi,%ecx
  801e8d:	d3 ef                	shr    %cl,%edi
  801e8f:	09 c7                	or     %eax,%edi
  801e91:	89 e9                	mov    %ebp,%ecx
  801e93:	d3 e2                	shl    %cl,%edx
  801e95:	89 14 24             	mov    %edx,(%esp)
  801e98:	89 d8                	mov    %ebx,%eax
  801e9a:	d3 e0                	shl    %cl,%eax
  801e9c:	89 c2                	mov    %eax,%edx
  801e9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea2:	d3 e0                	shl    %cl,%eax
  801ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ea8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eac:	89 f1                	mov    %esi,%ecx
  801eae:	d3 e8                	shr    %cl,%eax
  801eb0:	09 d0                	or     %edx,%eax
  801eb2:	d3 eb                	shr    %cl,%ebx
  801eb4:	89 da                	mov    %ebx,%edx
  801eb6:	f7 f7                	div    %edi
  801eb8:	89 d3                	mov    %edx,%ebx
  801eba:	f7 24 24             	mull   (%esp)
  801ebd:	89 c6                	mov    %eax,%esi
  801ebf:	89 d1                	mov    %edx,%ecx
  801ec1:	39 d3                	cmp    %edx,%ebx
  801ec3:	0f 82 87 00 00 00    	jb     801f50 <__umoddi3+0x134>
  801ec9:	0f 84 91 00 00 00    	je     801f60 <__umoddi3+0x144>
  801ecf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed3:	29 f2                	sub    %esi,%edx
  801ed5:	19 cb                	sbb    %ecx,%ebx
  801ed7:	89 d8                	mov    %ebx,%eax
  801ed9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 e9                	mov    %ebp,%ecx
  801ee1:	d3 ea                	shr    %cl,%edx
  801ee3:	09 d0                	or     %edx,%eax
  801ee5:	89 e9                	mov    %ebp,%ecx
  801ee7:	d3 eb                	shr    %cl,%ebx
  801ee9:	89 da                	mov    %ebx,%edx
  801eeb:	83 c4 1c             	add    $0x1c,%esp
  801eee:	5b                   	pop    %ebx
  801eef:	5e                   	pop    %esi
  801ef0:	5f                   	pop    %edi
  801ef1:	5d                   	pop    %ebp
  801ef2:	c3                   	ret    
  801ef3:	90                   	nop
  801ef4:	89 fd                	mov    %edi,%ebp
  801ef6:	85 ff                	test   %edi,%edi
  801ef8:	75 0b                	jne    801f05 <__umoddi3+0xe9>
  801efa:	b8 01 00 00 00       	mov    $0x1,%eax
  801eff:	31 d2                	xor    %edx,%edx
  801f01:	f7 f7                	div    %edi
  801f03:	89 c5                	mov    %eax,%ebp
  801f05:	89 f0                	mov    %esi,%eax
  801f07:	31 d2                	xor    %edx,%edx
  801f09:	f7 f5                	div    %ebp
  801f0b:	89 c8                	mov    %ecx,%eax
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 d0                	mov    %edx,%eax
  801f11:	e9 44 ff ff ff       	jmp    801e5a <__umoddi3+0x3e>
  801f16:	66 90                	xchg   %ax,%ax
  801f18:	89 c8                	mov    %ecx,%eax
  801f1a:	89 f2                	mov    %esi,%edx
  801f1c:	83 c4 1c             	add    $0x1c,%esp
  801f1f:	5b                   	pop    %ebx
  801f20:	5e                   	pop    %esi
  801f21:	5f                   	pop    %edi
  801f22:	5d                   	pop    %ebp
  801f23:	c3                   	ret    
  801f24:	3b 04 24             	cmp    (%esp),%eax
  801f27:	72 06                	jb     801f2f <__umoddi3+0x113>
  801f29:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f2d:	77 0f                	ja     801f3e <__umoddi3+0x122>
  801f2f:	89 f2                	mov    %esi,%edx
  801f31:	29 f9                	sub    %edi,%ecx
  801f33:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f37:	89 14 24             	mov    %edx,(%esp)
  801f3a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f3e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f42:	8b 14 24             	mov    (%esp),%edx
  801f45:	83 c4 1c             	add    $0x1c,%esp
  801f48:	5b                   	pop    %ebx
  801f49:	5e                   	pop    %esi
  801f4a:	5f                   	pop    %edi
  801f4b:	5d                   	pop    %ebp
  801f4c:	c3                   	ret    
  801f4d:	8d 76 00             	lea    0x0(%esi),%esi
  801f50:	2b 04 24             	sub    (%esp),%eax
  801f53:	19 fa                	sbb    %edi,%edx
  801f55:	89 d1                	mov    %edx,%ecx
  801f57:	89 c6                	mov    %eax,%esi
  801f59:	e9 71 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
  801f5e:	66 90                	xchg   %ax,%ax
  801f60:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f64:	72 ea                	jb     801f50 <__umoddi3+0x134>
  801f66:	89 d9                	mov    %ebx,%ecx
  801f68:	e9 62 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
