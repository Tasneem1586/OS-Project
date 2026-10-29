
obj/user/tst_invalid_access:     file format elf32-i386


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
  800031:	e8 07 02 00 00       	call   80023d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int eval = 0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	cprintf_colored(TEXT_cyan, "%~PART I: Test the Pointer Validation inside fault_handler(): [70%]\n");
  800045:	83 ec 08             	sub    $0x8,%esp
  800048:	68 00 1f 80 00       	push   $0x801f00
  80004d:	6a 03                	push   $0x3
  80004f:	e8 56 05 00 00       	call   8005aa <cprintf_colored>
  800054:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_cyan, "%~=================================================================\n");
  800057:	83 ec 08             	sub    $0x8,%esp
  80005a:	68 48 1f 80 00       	push   $0x801f48
  80005f:	6a 03                	push   $0x3
  800061:	e8 44 05 00 00       	call   8005aa <cprintf_colored>
  800066:	83 c4 10             	add    $0x10,%esp
	rsttst();
  800069:	e8 83 17 00 00       	call   8017f1 <rsttst>
	int ID1 = sys_create_env("tia_slave1", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  80006e:	a1 20 30 80 00       	mov    0x803020,%eax
  800073:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  800079:	a1 20 30 80 00       	mov    0x803020,%eax
  80007e:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800084:	a1 20 30 80 00       	mov    0x803020,%eax
  800089:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  80008f:	51                   	push   %ecx
  800090:	52                   	push   %edx
  800091:	50                   	push   %eax
  800092:	68 8d 1f 80 00       	push   $0x801f8d
  800097:	e8 3f 16 00 00       	call   8016db <sys_create_env>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID1);
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	ff 75 f0             	pushl  -0x10(%ebp)
  8000a8:	e8 4c 16 00 00       	call   8016f9 <sys_run_env>
  8000ad:	83 c4 10             	add    $0x10,%esp

	int ID2 = sys_create_env("tia_slave2", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b5:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c0:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cb:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000d1:	51                   	push   %ecx
  8000d2:	52                   	push   %edx
  8000d3:	50                   	push   %eax
  8000d4:	68 98 1f 80 00       	push   $0x801f98
  8000d9:	e8 fd 15 00 00       	call   8016db <sys_create_env>
  8000de:	83 c4 10             	add    $0x10,%esp
  8000e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
	sys_run_env(ID2);
  8000e4:	83 ec 0c             	sub    $0xc,%esp
  8000e7:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ea:	e8 0a 16 00 00       	call   8016f9 <sys_run_env>
  8000ef:	83 c4 10             	add    $0x10,%esp

	int ID3 = sys_create_env("tia_slave3", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f7:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800102:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800108:	a1 20 30 80 00       	mov    0x803020,%eax
  80010d:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800113:	51                   	push   %ecx
  800114:	52                   	push   %edx
  800115:	50                   	push   %eax
  800116:	68 a3 1f 80 00       	push   $0x801fa3
  80011b:	e8 bb 15 00 00       	call   8016db <sys_create_env>
  800120:	83 c4 10             	add    $0x10,%esp
  800123:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_run_env(ID3);
  800126:	83 ec 0c             	sub    $0xc,%esp
  800129:	ff 75 e8             	pushl  -0x18(%ebp)
  80012c:	e8 c8 15 00 00       	call   8016f9 <sys_run_env>
  800131:	83 c4 10             	add    $0x10,%esp
	env_sleep(15000);
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 98 3a 00 00       	push   $0x3a98
  80013c:	e8 94 18 00 00       	call   8019d5 <env_sleep>
  800141:	83 c4 10             	add    $0x10,%esp

	if (gettst() != 0)
  800144:	e8 22 17 00 00       	call   80186b <gettst>
  800149:	85 c0                	test   %eax,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
		cprintf_colored(TEXT_TESTERR_CLR, "\n%~PART I... Failed.\n");
  80014d:	83 ec 08             	sub    $0x8,%esp
  800150:	68 ae 1f 80 00       	push   $0x801fae
  800155:	6a 0c                	push   $0xc
  800157:	e8 4e 04 00 00       	call   8005aa <cprintf_colored>
  80015c:	83 c4 10             	add    $0x10,%esp
  80015f:	eb 16                	jmp    800177 <_main+0x13f>
	else
	{
		cprintf_colored(TEXT_green, "\n%~PART I... completed successfully\n\n");
  800161:	83 ec 08             	sub    $0x8,%esp
  800164:	68 c4 1f 80 00       	push   $0x801fc4
  800169:	6a 02                	push   $0x2
  80016b:	e8 3a 04 00 00       	call   8005aa <cprintf_colored>
  800170:	83 c4 10             	add    $0x10,%esp
		eval += 70;
  800173:	83 45 f4 46          	addl   $0x46,-0xc(%ebp)
	}

	cprintf_colored(TEXT_cyan, "%~PART II: PLACEMENT: Test the Invalid Access to a NON-EXIST page in Page File, Stack & Heap: [30%]\n");
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	68 ec 1f 80 00       	push   $0x801fec
  80017f:	6a 03                	push   $0x3
  800181:	e8 24 04 00 00       	call   8005aa <cprintf_colored>
  800186:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_cyan, "%~=================================================================================================\n");
  800189:	83 ec 08             	sub    $0x8,%esp
  80018c:	68 54 20 80 00       	push   $0x802054
  800191:	6a 03                	push   $0x3
  800193:	e8 12 04 00 00       	call   8005aa <cprintf_colored>
  800198:	83 c4 10             	add    $0x10,%esp

	rsttst();
  80019b:	e8 51 16 00 00       	call   8017f1 <rsttst>
	int ID4 = sys_create_env("tia_slave4", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  8001a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a5:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8001ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b0:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8001c1:	51                   	push   %ecx
  8001c2:	52                   	push   %edx
  8001c3:	50                   	push   %eax
  8001c4:	68 b9 20 80 00       	push   $0x8020b9
  8001c9:	e8 0d 15 00 00       	call   8016db <sys_create_env>
  8001ce:	83 c4 10             	add    $0x10,%esp
  8001d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_run_env(ID4);
  8001d4:	83 ec 0c             	sub    $0xc,%esp
  8001d7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001da:	e8 1a 15 00 00       	call   8016f9 <sys_run_env>
  8001df:	83 c4 10             	add    $0x10,%esp

	env_sleep(15000);
  8001e2:	83 ec 0c             	sub    $0xc,%esp
  8001e5:	68 98 3a 00 00       	push   $0x3a98
  8001ea:	e8 e6 17 00 00       	call   8019d5 <env_sleep>
  8001ef:	83 c4 10             	add    $0x10,%esp

	if (gettst() != 0)
  8001f2:	e8 74 16 00 00       	call   80186b <gettst>
  8001f7:	85 c0                	test   %eax,%eax
  8001f9:	74 14                	je     80020f <_main+0x1d7>
		cprintf_colored(TEXT_TESTERR_CLR, "\n%~PART II... Failed.\n");
  8001fb:	83 ec 08             	sub    $0x8,%esp
  8001fe:	68 c4 20 80 00       	push   $0x8020c4
  800203:	6a 0c                	push   $0xc
  800205:	e8 a0 03 00 00       	call   8005aa <cprintf_colored>
  80020a:	83 c4 10             	add    $0x10,%esp
  80020d:	eb 16                	jmp    800225 <_main+0x1ed>
	else
	{
		cprintf_colored(TEXT_green, "\n%~PART II... completed successfully\n\n");
  80020f:	83 ec 08             	sub    $0x8,%esp
  800212:	68 dc 20 80 00       	push   $0x8020dc
  800217:	6a 02                	push   $0x2
  800219:	e8 8c 03 00 00       	call   8005aa <cprintf_colored>
  80021e:	83 c4 10             	add    $0x10,%esp
		eval += 30;
  800221:	83 45 f4 1e          	addl   $0x1e,-0xc(%ebp)
	}
	cprintf_colored(TEXT_light_green, "%~\ntest invalid access completed. Eval = %d%\n\n", eval);
  800225:	83 ec 04             	sub    $0x4,%esp
  800228:	ff 75 f4             	pushl  -0xc(%ebp)
  80022b:	68 04 21 80 00       	push   $0x802104
  800230:	6a 0a                	push   $0xa
  800232:	e8 73 03 00 00       	call   8005aa <cprintf_colored>
  800237:	83 c4 10             	add    $0x10,%esp

}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	57                   	push   %edi
  800241:	56                   	push   %esi
  800242:	53                   	push   %ebx
  800243:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800249:	e8 fb 14 00 00       	call   801749 <sys_getenvindex>
  80024e:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800251:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800254:	89 d0                	mov    %edx,%eax
  800256:	c1 e0 03             	shl    $0x3,%eax
  800259:	01 d0                	add    %edx,%eax
  80025b:	c1 e0 06             	shl    $0x6,%eax
  80025e:	01 d0                	add    %edx,%eax
  800260:	c1 e0 03             	shl    $0x3,%eax
  800263:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800268:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80026d:	a1 20 30 80 00       	mov    0x803020,%eax
  800272:	8a 40 10             	mov    0x10(%eax),%al
  800275:	84 c0                	test   %al,%al
  800277:	74 0d                	je     800286 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800279:	a1 20 30 80 00       	mov    0x803020,%eax
  80027e:	83 c0 10             	add    $0x10,%eax
  800281:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800286:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80028a:	7e 0a                	jle    800296 <libmain+0x59>
		binaryname = argv[0];
  80028c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028f:	8b 00                	mov    (%eax),%eax
  800291:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800296:	83 ec 08             	sub    $0x8,%esp
  800299:	ff 75 0c             	pushl  0xc(%ebp)
  80029c:	ff 75 08             	pushl  0x8(%ebp)
  80029f:	e8 94 fd ff ff       	call   800038 <_main>
  8002a4:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8002a7:	a1 00 30 80 00       	mov    0x803000,%eax
  8002ac:	85 c0                	test   %eax,%eax
  8002ae:	0f 84 b7 01 00 00    	je     80046b <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8002b4:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002ba:	bb 70 22 80 00       	mov    $0x802270,%ebx
  8002bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  8002c4:	89 c7                	mov    %eax,%edi
  8002c6:	89 de                	mov    %ebx,%esi
  8002c8:	89 d1                	mov    %edx,%ecx
  8002ca:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8002cc:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8002d2:	b9 56 00 00 00       	mov    $0x56,%ecx
  8002d7:	b0 00                	mov    $0x0,%al
  8002d9:	89 d7                	mov    %edx,%edi
  8002db:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8002dd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8002e4:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8002e7:	83 ec 08             	sub    $0x8,%esp
  8002ea:	50                   	push   %eax
  8002eb:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8002f1:	50                   	push   %eax
  8002f2:	e8 52 16 00 00       	call   801949 <sys_utilities>
  8002f7:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8002fa:	e8 d2 11 00 00       	call   8014d1 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8002ff:	83 ec 0c             	sub    $0xc,%esp
  800302:	68 4c 21 80 00       	push   $0x80214c
  800307:	e8 71 02 00 00       	call   80057d <cprintf>
  80030c:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80030f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800312:	85 c0                	test   %eax,%eax
  800314:	74 58                	je     80036e <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800316:	e8 4c 16 00 00       	call   801967 <sys_get_optimal_num_faults>
  80031b:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80031e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800324:	bb d4 22 80 00       	mov    $0x8022d4,%ebx
  800329:	ba 11 00 00 00       	mov    $0x11,%edx
  80032e:	89 c7                	mov    %eax,%edi
  800330:	89 de                	mov    %ebx,%esi
  800332:	89 d1                	mov    %edx,%ecx
  800334:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800336:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800339:	b9 53 00 00 00       	mov    $0x53,%ecx
  80033e:	b0 00                	mov    $0x0,%al
  800340:	89 d7                	mov    %edx,%edi
  800342:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800344:	83 ec 08             	sub    $0x8,%esp
  800347:	ff 75 dc             	pushl  -0x24(%ebp)
  80034a:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800350:	50                   	push   %eax
  800351:	e8 f3 15 00 00       	call   801949 <sys_utilities>
  800356:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800359:	83 ec 08             	sub    $0x8,%esp
  80035c:	ff 75 dc             	pushl  -0x24(%ebp)
  80035f:	68 74 21 80 00       	push   $0x802174
  800364:	e8 14 02 00 00       	call   80057d <cprintf>
  800369:	83 c4 10             	add    $0x10,%esp
  80036c:	eb 59                	jmp    8003c7 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80036e:	a1 20 30 80 00       	mov    0x803020,%eax
  800373:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800379:	a1 20 30 80 00       	mov    0x803020,%eax
  80037e:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800384:	83 ec 04             	sub    $0x4,%esp
  800387:	52                   	push   %edx
  800388:	50                   	push   %eax
  800389:	68 98 21 80 00       	push   $0x802198
  80038e:	e8 ea 01 00 00       	call   80057d <cprintf>
  800393:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800396:	a1 20 30 80 00       	mov    0x803020,%eax
  80039b:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a6:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8003b7:	51                   	push   %ecx
  8003b8:	52                   	push   %edx
  8003b9:	50                   	push   %eax
  8003ba:	68 c0 21 80 00       	push   $0x8021c0
  8003bf:	e8 b9 01 00 00       	call   80057d <cprintf>
  8003c4:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cc:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8003d2:	83 ec 08             	sub    $0x8,%esp
  8003d5:	50                   	push   %eax
  8003d6:	68 18 22 80 00       	push   $0x802218
  8003db:	e8 9d 01 00 00       	call   80057d <cprintf>
  8003e0:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8003e3:	83 ec 0c             	sub    $0xc,%esp
  8003e6:	68 2c 22 80 00       	push   $0x80222c
  8003eb:	e8 8d 01 00 00       	call   80057d <cprintf>
  8003f0:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8003f3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8003fa:	eb 28                	jmp    800424 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8003fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800401:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800404:	81 c2 74 04 00 00    	add    $0x474,%edx
  80040a:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80040d:	83 ec 04             	sub    $0x4,%esp
  800410:	50                   	push   %eax
  800411:	ff 75 e4             	pushl  -0x1c(%ebp)
  800414:	68 43 22 80 00       	push   $0x802243
  800419:	e8 5f 01 00 00       	call   80057d <cprintf>
  80041e:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800421:	ff 45 e4             	incl   -0x1c(%ebp)
  800424:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800428:	7e d2                	jle    8003fc <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80042a:	83 ec 0c             	sub    $0xc,%esp
  80042d:	68 52 22 80 00       	push   $0x802252
  800432:	e8 46 01 00 00       	call   80057d <cprintf>
  800437:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80043a:	a1 20 30 80 00       	mov    0x803020,%eax
  80043f:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800445:	83 ec 08             	sub    $0x8,%esp
  800448:	50                   	push   %eax
  800449:	68 56 22 80 00       	push   $0x802256
  80044e:	e8 2a 01 00 00       	call   80057d <cprintf>
  800453:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800456:	83 ec 0c             	sub    $0xc,%esp
  800459:	68 4c 21 80 00       	push   $0x80214c
  80045e:	e8 1a 01 00 00       	call   80057d <cprintf>
  800463:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800466:	e8 80 10 00 00       	call   8014eb <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  80046b:	e8 1f 00 00 00       	call   80048f <exit>
}
  800470:	90                   	nop
  800471:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800474:	5b                   	pop    %ebx
  800475:	5e                   	pop    %esi
  800476:	5f                   	pop    %edi
  800477:	5d                   	pop    %ebp
  800478:	c3                   	ret    

00800479 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800479:	55                   	push   %ebp
  80047a:	89 e5                	mov    %esp,%ebp
  80047c:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  80047f:	83 ec 0c             	sub    $0xc,%esp
  800482:	6a 00                	push   $0x0
  800484:	e8 8c 12 00 00       	call   801715 <sys_destroy_env>
  800489:	83 c4 10             	add    $0x10,%esp
}
  80048c:	90                   	nop
  80048d:	c9                   	leave  
  80048e:	c3                   	ret    

0080048f <exit>:

void
exit(void)
{
  80048f:	55                   	push   %ebp
  800490:	89 e5                	mov    %esp,%ebp
  800492:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800495:	e8 e1 12 00 00       	call   80177b <sys_exit_env>
}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	53                   	push   %ebx
  8004a1:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8004a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	8d 48 01             	lea    0x1(%eax),%ecx
  8004ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004af:	89 0a                	mov    %ecx,(%edx)
  8004b1:	8b 55 08             	mov    0x8(%ebp),%edx
  8004b4:	88 d1                	mov    %dl,%cl
  8004b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c0:	8b 00                	mov    (%eax),%eax
  8004c2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004c7:	75 30                	jne    8004f9 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8004c9:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8004cf:	a0 40 30 80 00       	mov    0x803040,%al
  8004d4:	0f b6 c0             	movzbl %al,%eax
  8004d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004da:	8b 09                	mov    (%ecx),%ecx
  8004dc:	89 cb                	mov    %ecx,%ebx
  8004de:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004e1:	83 c1 08             	add    $0x8,%ecx
  8004e4:	52                   	push   %edx
  8004e5:	50                   	push   %eax
  8004e6:	53                   	push   %ebx
  8004e7:	51                   	push   %ecx
  8004e8:	e8 a0 0f 00 00       	call   80148d <sys_cputs>
  8004ed:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fc:	8b 40 04             	mov    0x4(%eax),%eax
  8004ff:	8d 50 01             	lea    0x1(%eax),%edx
  800502:	8b 45 0c             	mov    0xc(%ebp),%eax
  800505:	89 50 04             	mov    %edx,0x4(%eax)
}
  800508:	90                   	nop
  800509:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80050c:	c9                   	leave  
  80050d:	c3                   	ret    

0080050e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80050e:	55                   	push   %ebp
  80050f:	89 e5                	mov    %esp,%ebp
  800511:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800517:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80051e:	00 00 00 
	b.cnt = 0;
  800521:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800528:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80052b:	ff 75 0c             	pushl  0xc(%ebp)
  80052e:	ff 75 08             	pushl  0x8(%ebp)
  800531:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800537:	50                   	push   %eax
  800538:	68 9d 04 80 00       	push   $0x80049d
  80053d:	e8 5a 02 00 00       	call   80079c <vprintfmt>
  800542:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800545:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80054b:	a0 40 30 80 00       	mov    0x803040,%al
  800550:	0f b6 c0             	movzbl %al,%eax
  800553:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800559:	52                   	push   %edx
  80055a:	50                   	push   %eax
  80055b:	51                   	push   %ecx
  80055c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800562:	83 c0 08             	add    $0x8,%eax
  800565:	50                   	push   %eax
  800566:	e8 22 0f 00 00       	call   80148d <sys_cputs>
  80056b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80056e:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  800575:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80057b:	c9                   	leave  
  80057c:	c3                   	ret    

0080057d <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  80057d:	55                   	push   %ebp
  80057e:	89 e5                	mov    %esp,%ebp
  800580:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800583:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  80058a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80058d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800590:	8b 45 08             	mov    0x8(%ebp),%eax
  800593:	83 ec 08             	sub    $0x8,%esp
  800596:	ff 75 f4             	pushl  -0xc(%ebp)
  800599:	50                   	push   %eax
  80059a:	e8 6f ff ff ff       	call   80050e <vcprintf>
  80059f:	83 c4 10             	add    $0x10,%esp
  8005a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005a8:	c9                   	leave  
  8005a9:	c3                   	ret    

008005aa <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8005aa:	55                   	push   %ebp
  8005ab:	89 e5                	mov    %esp,%ebp
  8005ad:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005b0:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	c1 e0 08             	shl    $0x8,%eax
  8005bd:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  8005c2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005c5:	83 c0 04             	add    $0x4,%eax
  8005c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ce:	83 ec 08             	sub    $0x8,%esp
  8005d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d4:	50                   	push   %eax
  8005d5:	e8 34 ff ff ff       	call   80050e <vcprintf>
  8005da:	83 c4 10             	add    $0x10,%esp
  8005dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8005e0:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  8005e7:	07 00 00 

	return cnt;
  8005ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ed:	c9                   	leave  
  8005ee:	c3                   	ret    

008005ef <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8005ef:	55                   	push   %ebp
  8005f0:	89 e5                	mov    %esp,%ebp
  8005f2:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8005f5:	e8 d7 0e 00 00       	call   8014d1 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8005fa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800600:	8b 45 08             	mov    0x8(%ebp),%eax
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	ff 75 f4             	pushl  -0xc(%ebp)
  800609:	50                   	push   %eax
  80060a:	e8 ff fe ff ff       	call   80050e <vcprintf>
  80060f:	83 c4 10             	add    $0x10,%esp
  800612:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800615:	e8 d1 0e 00 00       	call   8014eb <sys_unlock_cons>
	return cnt;
  80061a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
  800622:	53                   	push   %ebx
  800623:	83 ec 14             	sub    $0x14,%esp
  800626:	8b 45 10             	mov    0x10(%ebp),%eax
  800629:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80062c:	8b 45 14             	mov    0x14(%ebp),%eax
  80062f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800632:	8b 45 18             	mov    0x18(%ebp),%eax
  800635:	ba 00 00 00 00       	mov    $0x0,%edx
  80063a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80063d:	77 55                	ja     800694 <printnum+0x75>
  80063f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800642:	72 05                	jb     800649 <printnum+0x2a>
  800644:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800647:	77 4b                	ja     800694 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800649:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80064c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80064f:	8b 45 18             	mov    0x18(%ebp),%eax
  800652:	ba 00 00 00 00       	mov    $0x0,%edx
  800657:	52                   	push   %edx
  800658:	50                   	push   %eax
  800659:	ff 75 f4             	pushl  -0xc(%ebp)
  80065c:	ff 75 f0             	pushl  -0x10(%ebp)
  80065f:	e8 20 16 00 00       	call   801c84 <__udivdi3>
  800664:	83 c4 10             	add    $0x10,%esp
  800667:	83 ec 04             	sub    $0x4,%esp
  80066a:	ff 75 20             	pushl  0x20(%ebp)
  80066d:	53                   	push   %ebx
  80066e:	ff 75 18             	pushl  0x18(%ebp)
  800671:	52                   	push   %edx
  800672:	50                   	push   %eax
  800673:	ff 75 0c             	pushl  0xc(%ebp)
  800676:	ff 75 08             	pushl  0x8(%ebp)
  800679:	e8 a1 ff ff ff       	call   80061f <printnum>
  80067e:	83 c4 20             	add    $0x20,%esp
  800681:	eb 1a                	jmp    80069d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800683:	83 ec 08             	sub    $0x8,%esp
  800686:	ff 75 0c             	pushl  0xc(%ebp)
  800689:	ff 75 20             	pushl  0x20(%ebp)
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	ff d0                	call   *%eax
  800691:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800694:	ff 4d 1c             	decl   0x1c(%ebp)
  800697:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80069b:	7f e6                	jg     800683 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80069d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006a0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ab:	53                   	push   %ebx
  8006ac:	51                   	push   %ecx
  8006ad:	52                   	push   %edx
  8006ae:	50                   	push   %eax
  8006af:	e8 e0 16 00 00       	call   801d94 <__umoddi3>
  8006b4:	83 c4 10             	add    $0x10,%esp
  8006b7:	05 54 25 80 00       	add    $0x802554,%eax
  8006bc:	8a 00                	mov    (%eax),%al
  8006be:	0f be c0             	movsbl %al,%eax
  8006c1:	83 ec 08             	sub    $0x8,%esp
  8006c4:	ff 75 0c             	pushl  0xc(%ebp)
  8006c7:	50                   	push   %eax
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	ff d0                	call   *%eax
  8006cd:	83 c4 10             	add    $0x10,%esp
}
  8006d0:	90                   	nop
  8006d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006d4:	c9                   	leave  
  8006d5:	c3                   	ret    

008006d6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006d6:	55                   	push   %ebp
  8006d7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006d9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006dd:	7e 1c                	jle    8006fb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006df:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	8d 50 08             	lea    0x8(%eax),%edx
  8006e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ea:	89 10                	mov    %edx,(%eax)
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	83 e8 08             	sub    $0x8,%eax
  8006f4:	8b 50 04             	mov    0x4(%eax),%edx
  8006f7:	8b 00                	mov    (%eax),%eax
  8006f9:	eb 40                	jmp    80073b <getuint+0x65>
	else if (lflag)
  8006fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ff:	74 1e                	je     80071f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	8b 00                	mov    (%eax),%eax
  800706:	8d 50 04             	lea    0x4(%eax),%edx
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	89 10                	mov    %edx,(%eax)
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	8b 00                	mov    (%eax),%eax
  800713:	83 e8 04             	sub    $0x4,%eax
  800716:	8b 00                	mov    (%eax),%eax
  800718:	ba 00 00 00 00       	mov    $0x0,%edx
  80071d:	eb 1c                	jmp    80073b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	8b 00                	mov    (%eax),%eax
  800724:	8d 50 04             	lea    0x4(%eax),%edx
  800727:	8b 45 08             	mov    0x8(%ebp),%eax
  80072a:	89 10                	mov    %edx,(%eax)
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	8b 00                	mov    (%eax),%eax
  800731:	83 e8 04             	sub    $0x4,%eax
  800734:	8b 00                	mov    (%eax),%eax
  800736:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80073b:	5d                   	pop    %ebp
  80073c:	c3                   	ret    

0080073d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800740:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800744:	7e 1c                	jle    800762 <getint+0x25>
		return va_arg(*ap, long long);
  800746:	8b 45 08             	mov    0x8(%ebp),%eax
  800749:	8b 00                	mov    (%eax),%eax
  80074b:	8d 50 08             	lea    0x8(%eax),%edx
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	89 10                	mov    %edx,(%eax)
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	8b 00                	mov    (%eax),%eax
  800758:	83 e8 08             	sub    $0x8,%eax
  80075b:	8b 50 04             	mov    0x4(%eax),%edx
  80075e:	8b 00                	mov    (%eax),%eax
  800760:	eb 38                	jmp    80079a <getint+0x5d>
	else if (lflag)
  800762:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800766:	74 1a                	je     800782 <getint+0x45>
		return va_arg(*ap, long);
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	8b 00                	mov    (%eax),%eax
  80076d:	8d 50 04             	lea    0x4(%eax),%edx
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	89 10                	mov    %edx,(%eax)
  800775:	8b 45 08             	mov    0x8(%ebp),%eax
  800778:	8b 00                	mov    (%eax),%eax
  80077a:	83 e8 04             	sub    $0x4,%eax
  80077d:	8b 00                	mov    (%eax),%eax
  80077f:	99                   	cltd   
  800780:	eb 18                	jmp    80079a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	8b 00                	mov    (%eax),%eax
  800787:	8d 50 04             	lea    0x4(%eax),%edx
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	89 10                	mov    %edx,(%eax)
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	8b 00                	mov    (%eax),%eax
  800794:	83 e8 04             	sub    $0x4,%eax
  800797:	8b 00                	mov    (%eax),%eax
  800799:	99                   	cltd   
}
  80079a:	5d                   	pop    %ebp
  80079b:	c3                   	ret    

0080079c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80079c:	55                   	push   %ebp
  80079d:	89 e5                	mov    %esp,%ebp
  80079f:	56                   	push   %esi
  8007a0:	53                   	push   %ebx
  8007a1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007a4:	eb 17                	jmp    8007bd <vprintfmt+0x21>
			if (ch == '\0')
  8007a6:	85 db                	test   %ebx,%ebx
  8007a8:	0f 84 c1 03 00 00    	je     800b6f <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 0c             	pushl  0xc(%ebp)
  8007b4:	53                   	push   %ebx
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	ff d0                	call   *%eax
  8007ba:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c0:	8d 50 01             	lea    0x1(%eax),%edx
  8007c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8007c6:	8a 00                	mov    (%eax),%al
  8007c8:	0f b6 d8             	movzbl %al,%ebx
  8007cb:	83 fb 25             	cmp    $0x25,%ebx
  8007ce:	75 d6                	jne    8007a6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007d0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007d4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007db:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007e9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f3:	8d 50 01             	lea    0x1(%eax),%edx
  8007f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8007f9:	8a 00                	mov    (%eax),%al
  8007fb:	0f b6 d8             	movzbl %al,%ebx
  8007fe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800801:	83 f8 5b             	cmp    $0x5b,%eax
  800804:	0f 87 3d 03 00 00    	ja     800b47 <vprintfmt+0x3ab>
  80080a:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  800811:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800813:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800817:	eb d7                	jmp    8007f0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800819:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80081d:	eb d1                	jmp    8007f0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80081f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800826:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800829:	89 d0                	mov    %edx,%eax
  80082b:	c1 e0 02             	shl    $0x2,%eax
  80082e:	01 d0                	add    %edx,%eax
  800830:	01 c0                	add    %eax,%eax
  800832:	01 d8                	add    %ebx,%eax
  800834:	83 e8 30             	sub    $0x30,%eax
  800837:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80083a:	8b 45 10             	mov    0x10(%ebp),%eax
  80083d:	8a 00                	mov    (%eax),%al
  80083f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800842:	83 fb 2f             	cmp    $0x2f,%ebx
  800845:	7e 3e                	jle    800885 <vprintfmt+0xe9>
  800847:	83 fb 39             	cmp    $0x39,%ebx
  80084a:	7f 39                	jg     800885 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80084c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80084f:	eb d5                	jmp    800826 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800851:	8b 45 14             	mov    0x14(%ebp),%eax
  800854:	83 c0 04             	add    $0x4,%eax
  800857:	89 45 14             	mov    %eax,0x14(%ebp)
  80085a:	8b 45 14             	mov    0x14(%ebp),%eax
  80085d:	83 e8 04             	sub    $0x4,%eax
  800860:	8b 00                	mov    (%eax),%eax
  800862:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800865:	eb 1f                	jmp    800886 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800867:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80086b:	79 83                	jns    8007f0 <vprintfmt+0x54>
				width = 0;
  80086d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800874:	e9 77 ff ff ff       	jmp    8007f0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800879:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800880:	e9 6b ff ff ff       	jmp    8007f0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800885:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800886:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088a:	0f 89 60 ff ff ff    	jns    8007f0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800890:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800893:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800896:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80089d:	e9 4e ff ff ff       	jmp    8007f0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008a2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008a5:	e9 46 ff ff ff       	jmp    8007f0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ad:	83 c0 04             	add    $0x4,%eax
  8008b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b6:	83 e8 04             	sub    $0x4,%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	83 ec 08             	sub    $0x8,%esp
  8008be:	ff 75 0c             	pushl  0xc(%ebp)
  8008c1:	50                   	push   %eax
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	ff d0                	call   *%eax
  8008c7:	83 c4 10             	add    $0x10,%esp
			break;
  8008ca:	e9 9b 02 00 00       	jmp    800b6a <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d2:	83 c0 04             	add    $0x4,%eax
  8008d5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008db:	83 e8 04             	sub    $0x4,%eax
  8008de:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008e0:	85 db                	test   %ebx,%ebx
  8008e2:	79 02                	jns    8008e6 <vprintfmt+0x14a>
				err = -err;
  8008e4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008e6:	83 fb 64             	cmp    $0x64,%ebx
  8008e9:	7f 0b                	jg     8008f6 <vprintfmt+0x15a>
  8008eb:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  8008f2:	85 f6                	test   %esi,%esi
  8008f4:	75 19                	jne    80090f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008f6:	53                   	push   %ebx
  8008f7:	68 65 25 80 00       	push   $0x802565
  8008fc:	ff 75 0c             	pushl  0xc(%ebp)
  8008ff:	ff 75 08             	pushl  0x8(%ebp)
  800902:	e8 70 02 00 00       	call   800b77 <printfmt>
  800907:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80090a:	e9 5b 02 00 00       	jmp    800b6a <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80090f:	56                   	push   %esi
  800910:	68 6e 25 80 00       	push   $0x80256e
  800915:	ff 75 0c             	pushl  0xc(%ebp)
  800918:	ff 75 08             	pushl  0x8(%ebp)
  80091b:	e8 57 02 00 00       	call   800b77 <printfmt>
  800920:	83 c4 10             	add    $0x10,%esp
			break;
  800923:	e9 42 02 00 00       	jmp    800b6a <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800928:	8b 45 14             	mov    0x14(%ebp),%eax
  80092b:	83 c0 04             	add    $0x4,%eax
  80092e:	89 45 14             	mov    %eax,0x14(%ebp)
  800931:	8b 45 14             	mov    0x14(%ebp),%eax
  800934:	83 e8 04             	sub    $0x4,%eax
  800937:	8b 30                	mov    (%eax),%esi
  800939:	85 f6                	test   %esi,%esi
  80093b:	75 05                	jne    800942 <vprintfmt+0x1a6>
				p = "(null)";
  80093d:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  800942:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800946:	7e 6d                	jle    8009b5 <vprintfmt+0x219>
  800948:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80094c:	74 67                	je     8009b5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80094e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800951:	83 ec 08             	sub    $0x8,%esp
  800954:	50                   	push   %eax
  800955:	56                   	push   %esi
  800956:	e8 1e 03 00 00       	call   800c79 <strnlen>
  80095b:	83 c4 10             	add    $0x10,%esp
  80095e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800961:	eb 16                	jmp    800979 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800963:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	ff 75 0c             	pushl  0xc(%ebp)
  80096d:	50                   	push   %eax
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	ff d0                	call   *%eax
  800973:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800976:	ff 4d e4             	decl   -0x1c(%ebp)
  800979:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80097d:	7f e4                	jg     800963 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80097f:	eb 34                	jmp    8009b5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800981:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800985:	74 1c                	je     8009a3 <vprintfmt+0x207>
  800987:	83 fb 1f             	cmp    $0x1f,%ebx
  80098a:	7e 05                	jle    800991 <vprintfmt+0x1f5>
  80098c:	83 fb 7e             	cmp    $0x7e,%ebx
  80098f:	7e 12                	jle    8009a3 <vprintfmt+0x207>
					putch('?', putdat);
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 0c             	pushl  0xc(%ebp)
  800997:	6a 3f                	push   $0x3f
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	ff d0                	call   *%eax
  80099e:	83 c4 10             	add    $0x10,%esp
  8009a1:	eb 0f                	jmp    8009b2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009a3:	83 ec 08             	sub    $0x8,%esp
  8009a6:	ff 75 0c             	pushl  0xc(%ebp)
  8009a9:	53                   	push   %ebx
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	ff d0                	call   *%eax
  8009af:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009b2:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b5:	89 f0                	mov    %esi,%eax
  8009b7:	8d 70 01             	lea    0x1(%eax),%esi
  8009ba:	8a 00                	mov    (%eax),%al
  8009bc:	0f be d8             	movsbl %al,%ebx
  8009bf:	85 db                	test   %ebx,%ebx
  8009c1:	74 24                	je     8009e7 <vprintfmt+0x24b>
  8009c3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009c7:	78 b8                	js     800981 <vprintfmt+0x1e5>
  8009c9:	ff 4d e0             	decl   -0x20(%ebp)
  8009cc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009d0:	79 af                	jns    800981 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009d2:	eb 13                	jmp    8009e7 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009d4:	83 ec 08             	sub    $0x8,%esp
  8009d7:	ff 75 0c             	pushl  0xc(%ebp)
  8009da:	6a 20                	push   $0x20
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	ff d0                	call   *%eax
  8009e1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009e4:	ff 4d e4             	decl   -0x1c(%ebp)
  8009e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009eb:	7f e7                	jg     8009d4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009ed:	e9 78 01 00 00       	jmp    800b6a <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f8:	8d 45 14             	lea    0x14(%ebp),%eax
  8009fb:	50                   	push   %eax
  8009fc:	e8 3c fd ff ff       	call   80073d <getint>
  800a01:	83 c4 10             	add    $0x10,%esp
  800a04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a07:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a10:	85 d2                	test   %edx,%edx
  800a12:	79 23                	jns    800a37 <vprintfmt+0x29b>
				putch('-', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 2d                	push   $0x2d
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a24:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a2a:	f7 d8                	neg    %eax
  800a2c:	83 d2 00             	adc    $0x0,%edx
  800a2f:	f7 da                	neg    %edx
  800a31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a34:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a37:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a3e:	e9 bc 00 00 00       	jmp    800aff <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a43:	83 ec 08             	sub    $0x8,%esp
  800a46:	ff 75 e8             	pushl  -0x18(%ebp)
  800a49:	8d 45 14             	lea    0x14(%ebp),%eax
  800a4c:	50                   	push   %eax
  800a4d:	e8 84 fc ff ff       	call   8006d6 <getuint>
  800a52:	83 c4 10             	add    $0x10,%esp
  800a55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a62:	e9 98 00 00 00       	jmp    800aff <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a67:	83 ec 08             	sub    $0x8,%esp
  800a6a:	ff 75 0c             	pushl  0xc(%ebp)
  800a6d:	6a 58                	push   $0x58
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	ff d0                	call   *%eax
  800a74:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	6a 58                	push   $0x58
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a87:	83 ec 08             	sub    $0x8,%esp
  800a8a:	ff 75 0c             	pushl  0xc(%ebp)
  800a8d:	6a 58                	push   $0x58
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	ff d0                	call   *%eax
  800a94:	83 c4 10             	add    $0x10,%esp
			break;
  800a97:	e9 ce 00 00 00       	jmp    800b6a <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800a9c:	83 ec 08             	sub    $0x8,%esp
  800a9f:	ff 75 0c             	pushl  0xc(%ebp)
  800aa2:	6a 30                	push   $0x30
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	ff d0                	call   *%eax
  800aa9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 0c             	pushl  0xc(%ebp)
  800ab2:	6a 78                	push   $0x78
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	ff d0                	call   *%eax
  800ab9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800abc:	8b 45 14             	mov    0x14(%ebp),%eax
  800abf:	83 c0 04             	add    $0x4,%eax
  800ac2:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac8:	83 e8 04             	sub    $0x4,%eax
  800acb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800acd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ad7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ade:	eb 1f                	jmp    800aff <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ae6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ae9:	50                   	push   %eax
  800aea:	e8 e7 fb ff ff       	call   8006d6 <getuint>
  800aef:	83 c4 10             	add    $0x10,%esp
  800af2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800af8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800aff:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b03:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b06:	83 ec 04             	sub    $0x4,%esp
  800b09:	52                   	push   %edx
  800b0a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b0d:	50                   	push   %eax
  800b0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b11:	ff 75 f0             	pushl  -0x10(%ebp)
  800b14:	ff 75 0c             	pushl  0xc(%ebp)
  800b17:	ff 75 08             	pushl  0x8(%ebp)
  800b1a:	e8 00 fb ff ff       	call   80061f <printnum>
  800b1f:	83 c4 20             	add    $0x20,%esp
			break;
  800b22:	eb 46                	jmp    800b6a <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b24:	83 ec 08             	sub    $0x8,%esp
  800b27:	ff 75 0c             	pushl  0xc(%ebp)
  800b2a:	53                   	push   %ebx
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	ff d0                	call   *%eax
  800b30:	83 c4 10             	add    $0x10,%esp
			break;
  800b33:	eb 35                	jmp    800b6a <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b35:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800b3c:	eb 2c                	jmp    800b6a <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800b3e:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800b45:	eb 23                	jmp    800b6a <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b47:	83 ec 08             	sub    $0x8,%esp
  800b4a:	ff 75 0c             	pushl  0xc(%ebp)
  800b4d:	6a 25                	push   $0x25
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	ff d0                	call   *%eax
  800b54:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b57:	ff 4d 10             	decl   0x10(%ebp)
  800b5a:	eb 03                	jmp    800b5f <vprintfmt+0x3c3>
  800b5c:	ff 4d 10             	decl   0x10(%ebp)
  800b5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b62:	48                   	dec    %eax
  800b63:	8a 00                	mov    (%eax),%al
  800b65:	3c 25                	cmp    $0x25,%al
  800b67:	75 f3                	jne    800b5c <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800b69:	90                   	nop
		}
	}
  800b6a:	e9 35 fc ff ff       	jmp    8007a4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b6f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b70:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b73:	5b                   	pop    %ebx
  800b74:	5e                   	pop    %esi
  800b75:	5d                   	pop    %ebp
  800b76:	c3                   	ret    

00800b77 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b77:	55                   	push   %ebp
  800b78:	89 e5                	mov    %esp,%ebp
  800b7a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b7d:	8d 45 10             	lea    0x10(%ebp),%eax
  800b80:	83 c0 04             	add    $0x4,%eax
  800b83:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b86:	8b 45 10             	mov    0x10(%ebp),%eax
  800b89:	ff 75 f4             	pushl  -0xc(%ebp)
  800b8c:	50                   	push   %eax
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	ff 75 08             	pushl  0x8(%ebp)
  800b93:	e8 04 fc ff ff       	call   80079c <vprintfmt>
  800b98:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b9b:	90                   	nop
  800b9c:	c9                   	leave  
  800b9d:	c3                   	ret    

00800b9e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b9e:	55                   	push   %ebp
  800b9f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba4:	8b 40 08             	mov    0x8(%eax),%eax
  800ba7:	8d 50 01             	lea    0x1(%eax),%edx
  800baa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bad:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb3:	8b 10                	mov    (%eax),%edx
  800bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb8:	8b 40 04             	mov    0x4(%eax),%eax
  800bbb:	39 c2                	cmp    %eax,%edx
  800bbd:	73 12                	jae    800bd1 <sprintputch+0x33>
		*b->buf++ = ch;
  800bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc2:	8b 00                	mov    (%eax),%eax
  800bc4:	8d 48 01             	lea    0x1(%eax),%ecx
  800bc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bca:	89 0a                	mov    %ecx,(%edx)
  800bcc:	8b 55 08             	mov    0x8(%ebp),%edx
  800bcf:	88 10                	mov    %dl,(%eax)
}
  800bd1:	90                   	nop
  800bd2:	5d                   	pop    %ebp
  800bd3:	c3                   	ret    

00800bd4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	01 d0                	add    %edx,%eax
  800beb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bf5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bf9:	74 06                	je     800c01 <vsnprintf+0x2d>
  800bfb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bff:	7f 07                	jg     800c08 <vsnprintf+0x34>
		return -E_INVAL;
  800c01:	b8 03 00 00 00       	mov    $0x3,%eax
  800c06:	eb 20                	jmp    800c28 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c08:	ff 75 14             	pushl  0x14(%ebp)
  800c0b:	ff 75 10             	pushl  0x10(%ebp)
  800c0e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c11:	50                   	push   %eax
  800c12:	68 9e 0b 80 00       	push   $0x800b9e
  800c17:	e8 80 fb ff ff       	call   80079c <vprintfmt>
  800c1c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c22:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c25:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c28:	c9                   	leave  
  800c29:	c3                   	ret    

00800c2a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
  800c2d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c30:	8d 45 10             	lea    0x10(%ebp),%eax
  800c33:	83 c0 04             	add    $0x4,%eax
  800c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3f:	50                   	push   %eax
  800c40:	ff 75 0c             	pushl  0xc(%ebp)
  800c43:	ff 75 08             	pushl  0x8(%ebp)
  800c46:	e8 89 ff ff ff       	call   800bd4 <vsnprintf>
  800c4b:	83 c4 10             	add    $0x10,%esp
  800c4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c54:	c9                   	leave  
  800c55:	c3                   	ret    

00800c56 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
  800c59:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c63:	eb 06                	jmp    800c6b <strlen+0x15>
		n++;
  800c65:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c68:	ff 45 08             	incl   0x8(%ebp)
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	8a 00                	mov    (%eax),%al
  800c70:	84 c0                	test   %al,%al
  800c72:	75 f1                	jne    800c65 <strlen+0xf>
		n++;
	return n;
  800c74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c77:	c9                   	leave  
  800c78:	c3                   	ret    

00800c79 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
  800c7c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c86:	eb 09                	jmp    800c91 <strnlen+0x18>
		n++;
  800c88:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c8b:	ff 45 08             	incl   0x8(%ebp)
  800c8e:	ff 4d 0c             	decl   0xc(%ebp)
  800c91:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c95:	74 09                	je     800ca0 <strnlen+0x27>
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	84 c0                	test   %al,%al
  800c9e:	75 e8                	jne    800c88 <strnlen+0xf>
		n++;
	return n;
  800ca0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca3:	c9                   	leave  
  800ca4:	c3                   	ret    

00800ca5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ca5:	55                   	push   %ebp
  800ca6:	89 e5                	mov    %esp,%ebp
  800ca8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cb1:	90                   	nop
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8d 50 01             	lea    0x1(%eax),%edx
  800cb8:	89 55 08             	mov    %edx,0x8(%ebp)
  800cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cbe:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cc4:	8a 12                	mov    (%edx),%dl
  800cc6:	88 10                	mov    %dl,(%eax)
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	84 c0                	test   %al,%al
  800ccc:	75 e4                	jne    800cb2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd1:	c9                   	leave  
  800cd2:	c3                   	ret    

00800cd3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cd3:	55                   	push   %ebp
  800cd4:	89 e5                	mov    %esp,%ebp
  800cd6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cdf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce6:	eb 1f                	jmp    800d07 <strncpy+0x34>
		*dst++ = *src;
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8d 50 01             	lea    0x1(%eax),%edx
  800cee:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf4:	8a 12                	mov    (%edx),%dl
  800cf6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfb:	8a 00                	mov    (%eax),%al
  800cfd:	84 c0                	test   %al,%al
  800cff:	74 03                	je     800d04 <strncpy+0x31>
			src++;
  800d01:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d04:	ff 45 fc             	incl   -0x4(%ebp)
  800d07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d0a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d0d:	72 d9                	jb     800ce8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d12:	c9                   	leave  
  800d13:	c3                   	ret    

00800d14 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d24:	74 30                	je     800d56 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d26:	eb 16                	jmp    800d3e <strlcpy+0x2a>
			*dst++ = *src++;
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8d 50 01             	lea    0x1(%eax),%edx
  800d2e:	89 55 08             	mov    %edx,0x8(%ebp)
  800d31:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d34:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d37:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d3a:	8a 12                	mov    (%edx),%dl
  800d3c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d3e:	ff 4d 10             	decl   0x10(%ebp)
  800d41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d45:	74 09                	je     800d50 <strlcpy+0x3c>
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	84 c0                	test   %al,%al
  800d4e:	75 d8                	jne    800d28 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d56:	8b 55 08             	mov    0x8(%ebp),%edx
  800d59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5c:	29 c2                	sub    %eax,%edx
  800d5e:	89 d0                	mov    %edx,%eax
}
  800d60:	c9                   	leave  
  800d61:	c3                   	ret    

00800d62 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d65:	eb 06                	jmp    800d6d <strcmp+0xb>
		p++, q++;
  800d67:	ff 45 08             	incl   0x8(%ebp)
  800d6a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	84 c0                	test   %al,%al
  800d74:	74 0e                	je     800d84 <strcmp+0x22>
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8a 10                	mov    (%eax),%dl
  800d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	38 c2                	cmp    %al,%dl
  800d82:	74 e3                	je     800d67 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	8a 00                	mov    (%eax),%al
  800d89:	0f b6 d0             	movzbl %al,%edx
  800d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8f:	8a 00                	mov    (%eax),%al
  800d91:	0f b6 c0             	movzbl %al,%eax
  800d94:	29 c2                	sub    %eax,%edx
  800d96:	89 d0                	mov    %edx,%eax
}
  800d98:	5d                   	pop    %ebp
  800d99:	c3                   	ret    

00800d9a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d9d:	eb 09                	jmp    800da8 <strncmp+0xe>
		n--, p++, q++;
  800d9f:	ff 4d 10             	decl   0x10(%ebp)
  800da2:	ff 45 08             	incl   0x8(%ebp)
  800da5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800da8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dac:	74 17                	je     800dc5 <strncmp+0x2b>
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	84 c0                	test   %al,%al
  800db5:	74 0e                	je     800dc5 <strncmp+0x2b>
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	8a 10                	mov    (%eax),%dl
  800dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	38 c2                	cmp    %al,%dl
  800dc3:	74 da                	je     800d9f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc9:	75 07                	jne    800dd2 <strncmp+0x38>
		return 0;
  800dcb:	b8 00 00 00 00       	mov    $0x0,%eax
  800dd0:	eb 14                	jmp    800de6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	0f b6 d0             	movzbl %al,%edx
  800dda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	0f b6 c0             	movzbl %al,%eax
  800de2:	29 c2                	sub    %eax,%edx
  800de4:	89 d0                	mov    %edx,%eax
}
  800de6:	5d                   	pop    %ebp
  800de7:	c3                   	ret    

00800de8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800de8:	55                   	push   %ebp
  800de9:	89 e5                	mov    %esp,%ebp
  800deb:	83 ec 04             	sub    $0x4,%esp
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800df4:	eb 12                	jmp    800e08 <strchr+0x20>
		if (*s == c)
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	8a 00                	mov    (%eax),%al
  800dfb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dfe:	75 05                	jne    800e05 <strchr+0x1d>
			return (char *) s;
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	eb 11                	jmp    800e16 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e05:	ff 45 08             	incl   0x8(%ebp)
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8a 00                	mov    (%eax),%al
  800e0d:	84 c0                	test   %al,%al
  800e0f:	75 e5                	jne    800df6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e11:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e16:	c9                   	leave  
  800e17:	c3                   	ret    

00800e18 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e18:	55                   	push   %ebp
  800e19:	89 e5                	mov    %esp,%ebp
  800e1b:	83 ec 04             	sub    $0x4,%esp
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e24:	eb 0d                	jmp    800e33 <strfind+0x1b>
		if (*s == c)
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e2e:	74 0e                	je     800e3e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e30:	ff 45 08             	incl   0x8(%ebp)
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
  800e36:	8a 00                	mov    (%eax),%al
  800e38:	84 c0                	test   %al,%al
  800e3a:	75 ea                	jne    800e26 <strfind+0xe>
  800e3c:	eb 01                	jmp    800e3f <strfind+0x27>
		if (*s == c)
			break;
  800e3e:	90                   	nop
	return (char *) s;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e42:	c9                   	leave  
  800e43:	c3                   	ret    

00800e44 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800e44:	55                   	push   %ebp
  800e45:	89 e5                	mov    %esp,%ebp
  800e47:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800e50:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800e54:	76 63                	jbe    800eb9 <memset+0x75>
		uint64 data_block = c;
  800e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e59:	99                   	cltd   
  800e5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e66:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800e6a:	c1 e0 08             	shl    $0x8,%eax
  800e6d:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e70:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800e73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e79:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800e7d:	c1 e0 10             	shl    $0x10,%eax
  800e80:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e83:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800e86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8c:	89 c2                	mov    %eax,%edx
  800e8e:	b8 00 00 00 00       	mov    $0x0,%eax
  800e93:	09 45 f0             	or     %eax,-0x10(%ebp)
  800e96:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800e99:	eb 18                	jmp    800eb3 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800e9b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e9e:	8d 41 08             	lea    0x8(%ecx),%eax
  800ea1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eaa:	89 01                	mov    %eax,(%ecx)
  800eac:	89 51 04             	mov    %edx,0x4(%ecx)
  800eaf:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800eb3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800eb7:	77 e2                	ja     800e9b <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800eb9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ebd:	74 23                	je     800ee2 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800ebf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ec5:	eb 0e                	jmp    800ed5 <memset+0x91>
			*p8++ = (uint8)c;
  800ec7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eca:	8d 50 01             	lea    0x1(%eax),%edx
  800ecd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ed0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed3:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800ed5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800edb:	89 55 10             	mov    %edx,0x10(%ebp)
  800ede:	85 c0                	test   %eax,%eax
  800ee0:	75 e5                	jne    800ec7 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee5:	c9                   	leave  
  800ee6:	c3                   	ret    

00800ee7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ee7:	55                   	push   %ebp
  800ee8:	89 e5                	mov    %esp,%ebp
  800eea:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800ef9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800efd:	76 24                	jbe    800f23 <memcpy+0x3c>
		while(n >= 8){
  800eff:	eb 1c                	jmp    800f1d <memcpy+0x36>
			*d64 = *s64;
  800f01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f04:	8b 50 04             	mov    0x4(%eax),%edx
  800f07:	8b 00                	mov    (%eax),%eax
  800f09:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f0c:	89 01                	mov    %eax,(%ecx)
  800f0e:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f11:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f15:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f19:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f1d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f21:	77 de                	ja     800f01 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f23:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f27:	74 31                	je     800f5a <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f32:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f35:	eb 16                	jmp    800f4d <memcpy+0x66>
			*d8++ = *s8++;
  800f37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f3a:	8d 50 01             	lea    0x1(%eax),%edx
  800f3d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800f40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f43:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f46:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800f49:	8a 12                	mov    (%edx),%dl
  800f4b:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800f4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f53:	89 55 10             	mov    %edx,0x10(%ebp)
  800f56:	85 c0                	test   %eax,%eax
  800f58:	75 dd                	jne    800f37 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5d:	c9                   	leave  
  800f5e:	c3                   	ret    

00800f5f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f5f:	55                   	push   %ebp
  800f60:	89 e5                	mov    %esp,%ebp
  800f62:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f74:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f77:	73 50                	jae    800fc9 <memmove+0x6a>
  800f79:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7f:	01 d0                	add    %edx,%eax
  800f81:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f84:	76 43                	jbe    800fc9 <memmove+0x6a>
		s += n;
  800f86:	8b 45 10             	mov    0x10(%ebp),%eax
  800f89:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f92:	eb 10                	jmp    800fa4 <memmove+0x45>
			*--d = *--s;
  800f94:	ff 4d f8             	decl   -0x8(%ebp)
  800f97:	ff 4d fc             	decl   -0x4(%ebp)
  800f9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9d:	8a 10                	mov    (%eax),%dl
  800f9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fa4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800faa:	89 55 10             	mov    %edx,0x10(%ebp)
  800fad:	85 c0                	test   %eax,%eax
  800faf:	75 e3                	jne    800f94 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fb1:	eb 23                	jmp    800fd6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb6:	8d 50 01             	lea    0x1(%eax),%edx
  800fb9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fbf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc5:	8a 12                	mov    (%edx),%dl
  800fc7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fcf:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd2:	85 c0                	test   %eax,%eax
  800fd4:	75 dd                	jne    800fb3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd9:	c9                   	leave  
  800fda:	c3                   	ret    

00800fdb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fdb:	55                   	push   %ebp
  800fdc:	89 e5                	mov    %esp,%ebp
  800fde:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fea:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fed:	eb 2a                	jmp    801019 <memcmp+0x3e>
		if (*s1 != *s2)
  800fef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff2:	8a 10                	mov    (%eax),%dl
  800ff4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff7:	8a 00                	mov    (%eax),%al
  800ff9:	38 c2                	cmp    %al,%dl
  800ffb:	74 16                	je     801013 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ffd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	0f b6 d0             	movzbl %al,%edx
  801005:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	0f b6 c0             	movzbl %al,%eax
  80100d:	29 c2                	sub    %eax,%edx
  80100f:	89 d0                	mov    %edx,%eax
  801011:	eb 18                	jmp    80102b <memcmp+0x50>
		s1++, s2++;
  801013:	ff 45 fc             	incl   -0x4(%ebp)
  801016:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801019:	8b 45 10             	mov    0x10(%ebp),%eax
  80101c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80101f:	89 55 10             	mov    %edx,0x10(%ebp)
  801022:	85 c0                	test   %eax,%eax
  801024:	75 c9                	jne    800fef <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801026:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80102b:	c9                   	leave  
  80102c:	c3                   	ret    

0080102d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80102d:	55                   	push   %ebp
  80102e:	89 e5                	mov    %esp,%ebp
  801030:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801033:	8b 55 08             	mov    0x8(%ebp),%edx
  801036:	8b 45 10             	mov    0x10(%ebp),%eax
  801039:	01 d0                	add    %edx,%eax
  80103b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80103e:	eb 15                	jmp    801055 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	0f b6 d0             	movzbl %al,%edx
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	0f b6 c0             	movzbl %al,%eax
  80104e:	39 c2                	cmp    %eax,%edx
  801050:	74 0d                	je     80105f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801052:	ff 45 08             	incl   0x8(%ebp)
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80105b:	72 e3                	jb     801040 <memfind+0x13>
  80105d:	eb 01                	jmp    801060 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80105f:	90                   	nop
	return (void *) s;
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801063:	c9                   	leave  
  801064:	c3                   	ret    

00801065 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801065:	55                   	push   %ebp
  801066:	89 e5                	mov    %esp,%ebp
  801068:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80106b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801072:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801079:	eb 03                	jmp    80107e <strtol+0x19>
		s++;
  80107b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8a 00                	mov    (%eax),%al
  801083:	3c 20                	cmp    $0x20,%al
  801085:	74 f4                	je     80107b <strtol+0x16>
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	3c 09                	cmp    $0x9,%al
  80108e:	74 eb                	je     80107b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	3c 2b                	cmp    $0x2b,%al
  801097:	75 05                	jne    80109e <strtol+0x39>
		s++;
  801099:	ff 45 08             	incl   0x8(%ebp)
  80109c:	eb 13                	jmp    8010b1 <strtol+0x4c>
	else if (*s == '-')
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	8a 00                	mov    (%eax),%al
  8010a3:	3c 2d                	cmp    $0x2d,%al
  8010a5:	75 0a                	jne    8010b1 <strtol+0x4c>
		s++, neg = 1;
  8010a7:	ff 45 08             	incl   0x8(%ebp)
  8010aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b5:	74 06                	je     8010bd <strtol+0x58>
  8010b7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010bb:	75 20                	jne    8010dd <strtol+0x78>
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	3c 30                	cmp    $0x30,%al
  8010c4:	75 17                	jne    8010dd <strtol+0x78>
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	40                   	inc    %eax
  8010ca:	8a 00                	mov    (%eax),%al
  8010cc:	3c 78                	cmp    $0x78,%al
  8010ce:	75 0d                	jne    8010dd <strtol+0x78>
		s += 2, base = 16;
  8010d0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010d4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010db:	eb 28                	jmp    801105 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e1:	75 15                	jne    8010f8 <strtol+0x93>
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	3c 30                	cmp    $0x30,%al
  8010ea:	75 0c                	jne    8010f8 <strtol+0x93>
		s++, base = 8;
  8010ec:	ff 45 08             	incl   0x8(%ebp)
  8010ef:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010f6:	eb 0d                	jmp    801105 <strtol+0xa0>
	else if (base == 0)
  8010f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fc:	75 07                	jne    801105 <strtol+0xa0>
		base = 10;
  8010fe:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	8a 00                	mov    (%eax),%al
  80110a:	3c 2f                	cmp    $0x2f,%al
  80110c:	7e 19                	jle    801127 <strtol+0xc2>
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 39                	cmp    $0x39,%al
  801115:	7f 10                	jg     801127 <strtol+0xc2>
			dig = *s - '0';
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	0f be c0             	movsbl %al,%eax
  80111f:	83 e8 30             	sub    $0x30,%eax
  801122:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801125:	eb 42                	jmp    801169 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8a 00                	mov    (%eax),%al
  80112c:	3c 60                	cmp    $0x60,%al
  80112e:	7e 19                	jle    801149 <strtol+0xe4>
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	3c 7a                	cmp    $0x7a,%al
  801137:	7f 10                	jg     801149 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	0f be c0             	movsbl %al,%eax
  801141:	83 e8 57             	sub    $0x57,%eax
  801144:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801147:	eb 20                	jmp    801169 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 00                	mov    (%eax),%al
  80114e:	3c 40                	cmp    $0x40,%al
  801150:	7e 39                	jle    80118b <strtol+0x126>
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	8a 00                	mov    (%eax),%al
  801157:	3c 5a                	cmp    $0x5a,%al
  801159:	7f 30                	jg     80118b <strtol+0x126>
			dig = *s - 'A' + 10;
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	0f be c0             	movsbl %al,%eax
  801163:	83 e8 37             	sub    $0x37,%eax
  801166:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801169:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80116f:	7d 19                	jge    80118a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801171:	ff 45 08             	incl   0x8(%ebp)
  801174:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801177:	0f af 45 10          	imul   0x10(%ebp),%eax
  80117b:	89 c2                	mov    %eax,%edx
  80117d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801180:	01 d0                	add    %edx,%eax
  801182:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801185:	e9 7b ff ff ff       	jmp    801105 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80118a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80118b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80118f:	74 08                	je     801199 <strtol+0x134>
		*endptr = (char *) s;
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	8b 55 08             	mov    0x8(%ebp),%edx
  801197:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801199:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80119d:	74 07                	je     8011a6 <strtol+0x141>
  80119f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a2:	f7 d8                	neg    %eax
  8011a4:	eb 03                	jmp    8011a9 <strtol+0x144>
  8011a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <ltostr>:

void
ltostr(long value, char *str)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c3:	79 13                	jns    8011d8 <ltostr+0x2d>
	{
		neg = 1;
  8011c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011d2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011d5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011e0:	99                   	cltd   
  8011e1:	f7 f9                	idiv   %ecx
  8011e3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e9:	8d 50 01             	lea    0x1(%eax),%edx
  8011ec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011ef:	89 c2                	mov    %eax,%edx
  8011f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f4:	01 d0                	add    %edx,%eax
  8011f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f9:	83 c2 30             	add    $0x30,%edx
  8011fc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801201:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801206:	f7 e9                	imul   %ecx
  801208:	c1 fa 02             	sar    $0x2,%edx
  80120b:	89 c8                	mov    %ecx,%eax
  80120d:	c1 f8 1f             	sar    $0x1f,%eax
  801210:	29 c2                	sub    %eax,%edx
  801212:	89 d0                	mov    %edx,%eax
  801214:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801217:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121b:	75 bb                	jne    8011d8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80121d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801224:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801227:	48                   	dec    %eax
  801228:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80122b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80122f:	74 3d                	je     80126e <ltostr+0xc3>
		start = 1 ;
  801231:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801238:	eb 34                	jmp    80126e <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80123a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801240:	01 d0                	add    %edx,%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801247:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80124a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124d:	01 c2                	add    %eax,%edx
  80124f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801252:	8b 45 0c             	mov    0xc(%ebp),%eax
  801255:	01 c8                	add    %ecx,%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80125b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	01 c2                	add    %eax,%edx
  801263:	8a 45 eb             	mov    -0x15(%ebp),%al
  801266:	88 02                	mov    %al,(%edx)
		start++ ;
  801268:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80126b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80126e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801271:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801274:	7c c4                	jl     80123a <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801276:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801279:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127c:	01 d0                	add    %edx,%eax
  80127e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801281:	90                   	nop
  801282:	c9                   	leave  
  801283:	c3                   	ret    

00801284 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801284:	55                   	push   %ebp
  801285:	89 e5                	mov    %esp,%ebp
  801287:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80128a:	ff 75 08             	pushl  0x8(%ebp)
  80128d:	e8 c4 f9 ff ff       	call   800c56 <strlen>
  801292:	83 c4 04             	add    $0x4,%esp
  801295:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801298:	ff 75 0c             	pushl  0xc(%ebp)
  80129b:	e8 b6 f9 ff ff       	call   800c56 <strlen>
  8012a0:	83 c4 04             	add    $0x4,%esp
  8012a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b4:	eb 17                	jmp    8012cd <strcconcat+0x49>
		final[s] = str1[s] ;
  8012b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bc:	01 c2                	add    %eax,%edx
  8012be:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	01 c8                	add    %ecx,%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012ca:	ff 45 fc             	incl   -0x4(%ebp)
  8012cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012d3:	7c e1                	jl     8012b6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012e3:	eb 1f                	jmp    801304 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e8:	8d 50 01             	lea    0x1(%eax),%edx
  8012eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012ee:	89 c2                	mov    %eax,%edx
  8012f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f3:	01 c2                	add    %eax,%edx
  8012f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fb:	01 c8                	add    %ecx,%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801301:	ff 45 f8             	incl   -0x8(%ebp)
  801304:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801307:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80130a:	7c d9                	jl     8012e5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80130c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130f:	8b 45 10             	mov    0x10(%ebp),%eax
  801312:	01 d0                	add    %edx,%eax
  801314:	c6 00 00             	movb   $0x0,(%eax)
}
  801317:	90                   	nop
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80131d:	8b 45 14             	mov    0x14(%ebp),%eax
  801320:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801326:	8b 45 14             	mov    0x14(%ebp),%eax
  801329:	8b 00                	mov    (%eax),%eax
  80132b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801332:	8b 45 10             	mov    0x10(%ebp),%eax
  801335:	01 d0                	add    %edx,%eax
  801337:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80133d:	eb 0c                	jmp    80134b <strsplit+0x31>
			*string++ = 0;
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	8d 50 01             	lea    0x1(%eax),%edx
  801345:	89 55 08             	mov    %edx,0x8(%ebp)
  801348:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8a 00                	mov    (%eax),%al
  801350:	84 c0                	test   %al,%al
  801352:	74 18                	je     80136c <strsplit+0x52>
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	0f be c0             	movsbl %al,%eax
  80135c:	50                   	push   %eax
  80135d:	ff 75 0c             	pushl  0xc(%ebp)
  801360:	e8 83 fa ff ff       	call   800de8 <strchr>
  801365:	83 c4 08             	add    $0x8,%esp
  801368:	85 c0                	test   %eax,%eax
  80136a:	75 d3                	jne    80133f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	84 c0                	test   %al,%al
  801373:	74 5a                	je     8013cf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801375:	8b 45 14             	mov    0x14(%ebp),%eax
  801378:	8b 00                	mov    (%eax),%eax
  80137a:	83 f8 0f             	cmp    $0xf,%eax
  80137d:	75 07                	jne    801386 <strsplit+0x6c>
		{
			return 0;
  80137f:	b8 00 00 00 00       	mov    $0x0,%eax
  801384:	eb 66                	jmp    8013ec <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801386:	8b 45 14             	mov    0x14(%ebp),%eax
  801389:	8b 00                	mov    (%eax),%eax
  80138b:	8d 48 01             	lea    0x1(%eax),%ecx
  80138e:	8b 55 14             	mov    0x14(%ebp),%edx
  801391:	89 0a                	mov    %ecx,(%edx)
  801393:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80139a:	8b 45 10             	mov    0x10(%ebp),%eax
  80139d:	01 c2                	add    %eax,%edx
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a4:	eb 03                	jmp    8013a9 <strsplit+0x8f>
			string++;
  8013a6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	84 c0                	test   %al,%al
  8013b0:	74 8b                	je     80133d <strsplit+0x23>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	0f be c0             	movsbl %al,%eax
  8013ba:	50                   	push   %eax
  8013bb:	ff 75 0c             	pushl  0xc(%ebp)
  8013be:	e8 25 fa ff ff       	call   800de8 <strchr>
  8013c3:	83 c4 08             	add    $0x8,%esp
  8013c6:	85 c0                	test   %eax,%eax
  8013c8:	74 dc                	je     8013a6 <strsplit+0x8c>
			string++;
	}
  8013ca:	e9 6e ff ff ff       	jmp    80133d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013cf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d3:	8b 00                	mov    (%eax),%eax
  8013d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8013df:	01 d0                	add    %edx,%eax
  8013e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8013fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801401:	eb 4a                	jmp    80144d <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801403:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	01 c2                	add    %eax,%edx
  80140b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80140e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801411:	01 c8                	add    %ecx,%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801417:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80141a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141d:	01 d0                	add    %edx,%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	3c 40                	cmp    $0x40,%al
  801423:	7e 25                	jle    80144a <str2lower+0x5c>
  801425:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801428:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142b:	01 d0                	add    %edx,%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	3c 5a                	cmp    $0x5a,%al
  801431:	7f 17                	jg     80144a <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801433:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	01 d0                	add    %edx,%eax
  80143b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80143e:	8b 55 08             	mov    0x8(%ebp),%edx
  801441:	01 ca                	add    %ecx,%edx
  801443:	8a 12                	mov    (%edx),%dl
  801445:	83 c2 20             	add    $0x20,%edx
  801448:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80144a:	ff 45 fc             	incl   -0x4(%ebp)
  80144d:	ff 75 0c             	pushl  0xc(%ebp)
  801450:	e8 01 f8 ff ff       	call   800c56 <strlen>
  801455:	83 c4 04             	add    $0x4,%esp
  801458:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80145b:	7f a6                	jg     801403 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  80145d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801460:	c9                   	leave  
  801461:	c3                   	ret    

00801462 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
  801465:	57                   	push   %edi
  801466:	56                   	push   %esi
  801467:	53                   	push   %ebx
  801468:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801471:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801474:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801477:	8b 7d 18             	mov    0x18(%ebp),%edi
  80147a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80147d:	cd 30                	int    $0x30
  80147f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801482:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801485:	83 c4 10             	add    $0x10,%esp
  801488:	5b                   	pop    %ebx
  801489:	5e                   	pop    %esi
  80148a:	5f                   	pop    %edi
  80148b:	5d                   	pop    %ebp
  80148c:	c3                   	ret    

0080148d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
  801490:	83 ec 04             	sub    $0x4,%esp
  801493:	8b 45 10             	mov    0x10(%ebp),%eax
  801496:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801499:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80149c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	6a 00                	push   $0x0
  8014a5:	51                   	push   %ecx
  8014a6:	52                   	push   %edx
  8014a7:	ff 75 0c             	pushl  0xc(%ebp)
  8014aa:	50                   	push   %eax
  8014ab:	6a 00                	push   $0x0
  8014ad:	e8 b0 ff ff ff       	call   801462 <syscall>
  8014b2:	83 c4 18             	add    $0x18,%esp
}
  8014b5:	90                   	nop
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 02                	push   $0x2
  8014c7:	e8 96 ff ff ff       	call   801462 <syscall>
  8014cc:	83 c4 18             	add    $0x18,%esp
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 03                	push   $0x3
  8014e0:	e8 7d ff ff ff       	call   801462 <syscall>
  8014e5:	83 c4 18             	add    $0x18,%esp
}
  8014e8:	90                   	nop
  8014e9:	c9                   	leave  
  8014ea:	c3                   	ret    

008014eb <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8014eb:	55                   	push   %ebp
  8014ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 04                	push   $0x4
  8014fa:	e8 63 ff ff ff       	call   801462 <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	52                   	push   %edx
  801515:	50                   	push   %eax
  801516:	6a 08                	push   $0x8
  801518:	e8 45 ff ff ff       	call   801462 <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
  801525:	56                   	push   %esi
  801526:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801527:	8b 75 18             	mov    0x18(%ebp),%esi
  80152a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80152d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	56                   	push   %esi
  801537:	53                   	push   %ebx
  801538:	51                   	push   %ecx
  801539:	52                   	push   %edx
  80153a:	50                   	push   %eax
  80153b:	6a 09                	push   $0x9
  80153d:	e8 20 ff ff ff       	call   801462 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801548:	5b                   	pop    %ebx
  801549:	5e                   	pop    %esi
  80154a:	5d                   	pop    %ebp
  80154b:	c3                   	ret    

0080154c <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	ff 75 08             	pushl  0x8(%ebp)
  80155a:	6a 0a                	push   $0xa
  80155c:	e8 01 ff ff ff       	call   801462 <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	ff 75 0c             	pushl  0xc(%ebp)
  801572:	ff 75 08             	pushl  0x8(%ebp)
  801575:	6a 0b                	push   $0xb
  801577:	e8 e6 fe ff ff       	call   801462 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 0c                	push   $0xc
  801590:	e8 cd fe ff ff       	call   801462 <syscall>
  801595:	83 c4 18             	add    $0x18,%esp
}
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 0d                	push   $0xd
  8015a9:	e8 b4 fe ff ff       	call   801462 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 0e                	push   $0xe
  8015c2:	e8 9b fe ff ff       	call   801462 <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 0f                	push   $0xf
  8015db:	e8 82 fe ff ff       	call   801462 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	ff 75 08             	pushl  0x8(%ebp)
  8015f3:	6a 10                	push   $0x10
  8015f5:	e8 68 fe ff ff       	call   801462 <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
}
  8015fd:	c9                   	leave  
  8015fe:	c3                   	ret    

008015ff <sys_scarce_memory>:

void sys_scarce_memory()
{
  8015ff:	55                   	push   %ebp
  801600:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 11                	push   $0x11
  80160e:	e8 4f fe ff ff       	call   801462 <syscall>
  801613:	83 c4 18             	add    $0x18,%esp
}
  801616:	90                   	nop
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_cputc>:

void
sys_cputc(const char c)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 04             	sub    $0x4,%esp
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801625:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	50                   	push   %eax
  801632:	6a 01                	push   $0x1
  801634:	e8 29 fe ff ff       	call   801462 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
}
  80163c:	90                   	nop
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    

0080163f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 14                	push   $0x14
  80164e:	e8 0f fe ff ff       	call   801462 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	90                   	nop
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
  80165c:	83 ec 04             	sub    $0x4,%esp
  80165f:	8b 45 10             	mov    0x10(%ebp),%eax
  801662:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801665:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801668:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	6a 00                	push   $0x0
  801671:	51                   	push   %ecx
  801672:	52                   	push   %edx
  801673:	ff 75 0c             	pushl  0xc(%ebp)
  801676:	50                   	push   %eax
  801677:	6a 15                	push   $0x15
  801679:	e8 e4 fd ff ff       	call   801462 <syscall>
  80167e:	83 c4 18             	add    $0x18,%esp
}
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801686:	8b 55 10             	mov    0x10(%ebp),%edx
  801689:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	52                   	push   %edx
  801691:	50                   	push   %eax
  801692:	ff 75 08             	pushl  0x8(%ebp)
  801695:	6a 16                	push   $0x16
  801697:	e8 c6 fd ff ff       	call   801462 <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
}
  80169f:	c9                   	leave  
  8016a0:	c3                   	ret    

008016a1 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016a1:	55                   	push   %ebp
  8016a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	52                   	push   %edx
  8016b1:	50                   	push   %eax
  8016b2:	6a 17                	push   $0x17
  8016b4:	e8 a9 fd ff ff       	call   801462 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
}
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8016c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	52                   	push   %edx
  8016ce:	50                   	push   %eax
  8016cf:	6a 18                	push   $0x18
  8016d1:	e8 8c fd ff ff       	call   801462 <syscall>
  8016d6:	83 c4 18             	add    $0x18,%esp
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	ff 75 14             	pushl  0x14(%ebp)
  8016e6:	ff 75 10             	pushl  0x10(%ebp)
  8016e9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ec:	50                   	push   %eax
  8016ed:	6a 19                	push   $0x19
  8016ef:	e8 6e fd ff ff       	call   801462 <syscall>
  8016f4:	83 c4 18             	add    $0x18,%esp
}
  8016f7:	c9                   	leave  
  8016f8:	c3                   	ret    

008016f9 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8016f9:	55                   	push   %ebp
  8016fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	50                   	push   %eax
  801708:	6a 1a                	push   $0x1a
  80170a:	e8 53 fd ff ff       	call   801462 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
}
  801712:	90                   	nop
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	50                   	push   %eax
  801724:	6a 1b                	push   $0x1b
  801726:	e8 37 fd ff ff       	call   801462 <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 05                	push   $0x5
  80173f:	e8 1e fd ff ff       	call   801462 <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 06                	push   $0x6
  801758:	e8 05 fd ff ff       	call   801462 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 07                	push   $0x7
  801771:	e8 ec fc ff ff       	call   801462 <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_exit_env>:


void sys_exit_env(void)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 1c                	push   $0x1c
  80178a:	e8 d3 fc ff ff       	call   801462 <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	90                   	nop
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	ff 75 10             	pushl  0x10(%ebp)
  80179f:	ff 75 0c             	pushl  0xc(%ebp)
  8017a2:	ff 75 08             	pushl  0x8(%ebp)
  8017a5:	6a 13                	push   $0x13
  8017a7:	e8 b6 fc ff ff       	call   801462 <syscall>
  8017ac:	83 c4 18             	add    $0x18,%esp
	return ;
  8017af:	90                   	nop
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 1e                	push   $0x1e
  8017c1:	e8 9c fc ff ff       	call   801462 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
  8017ce:	83 ec 04             	sub    $0x4,%esp
  8017d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017d7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	50                   	push   %eax
  8017e4:	6a 1f                	push   $0x1f
  8017e6:	e8 77 fc ff ff       	call   801462 <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ee:	90                   	nop
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <rsttst>:
void rsttst()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 21                	push   $0x21
  801800:	e8 5d fc ff ff       	call   801462 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
	return ;
  801808:	90                   	nop
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
  80180e:	83 ec 04             	sub    $0x4,%esp
  801811:	8b 45 14             	mov    0x14(%ebp),%eax
  801814:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801817:	8b 55 18             	mov    0x18(%ebp),%edx
  80181a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80181e:	52                   	push   %edx
  80181f:	50                   	push   %eax
  801820:	ff 75 10             	pushl  0x10(%ebp)
  801823:	ff 75 0c             	pushl  0xc(%ebp)
  801826:	ff 75 08             	pushl  0x8(%ebp)
  801829:	6a 20                	push   $0x20
  80182b:	e8 32 fc ff ff       	call   801462 <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
	return ;
  801833:	90                   	nop
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <chktst>:
void chktst(uint32 n)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	ff 75 08             	pushl  0x8(%ebp)
  801844:	6a 22                	push   $0x22
  801846:	e8 17 fc ff ff       	call   801462 <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
	return ;
  80184e:	90                   	nop
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <inctst>:

void inctst()
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 23                	push   $0x23
  801860:	e8 fd fb ff ff       	call   801462 <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
	return ;
  801868:	90                   	nop
}
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <gettst>:
uint32 gettst()
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 24                	push   $0x24
  80187a:	e8 e3 fb ff ff       	call   801462 <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 25                	push   $0x25
  801893:	e8 ca fb ff ff       	call   801462 <syscall>
  801898:	83 c4 18             	add    $0x18,%esp
  80189b:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018a0:	a1 48 30 80 00       	mov    0x803048,%eax
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	ff 75 08             	pushl  0x8(%ebp)
  8018bd:	6a 26                	push   $0x26
  8018bf:	e8 9e fb ff ff       	call   801462 <syscall>
  8018c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c7:	90                   	nop
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
  8018cd:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018ce:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018d1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	6a 00                	push   $0x0
  8018dc:	53                   	push   %ebx
  8018dd:	51                   	push   %ecx
  8018de:	52                   	push   %edx
  8018df:	50                   	push   %eax
  8018e0:	6a 27                	push   $0x27
  8018e2:	e8 7b fb ff ff       	call   801462 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	52                   	push   %edx
  8018ff:	50                   	push   %eax
  801900:	6a 28                	push   $0x28
  801902:	e8 5b fb ff ff       	call   801462 <syscall>
  801907:	83 c4 18             	add    $0x18,%esp
}
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80190f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801912:	8b 55 0c             	mov    0xc(%ebp),%edx
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	6a 00                	push   $0x0
  80191a:	51                   	push   %ecx
  80191b:	ff 75 10             	pushl  0x10(%ebp)
  80191e:	52                   	push   %edx
  80191f:	50                   	push   %eax
  801920:	6a 29                	push   $0x29
  801922:	e8 3b fb ff ff       	call   801462 <syscall>
  801927:	83 c4 18             	add    $0x18,%esp
}
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	ff 75 10             	pushl  0x10(%ebp)
  801936:	ff 75 0c             	pushl  0xc(%ebp)
  801939:	ff 75 08             	pushl  0x8(%ebp)
  80193c:	6a 12                	push   $0x12
  80193e:	e8 1f fb ff ff       	call   801462 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
	return ;
  801946:	90                   	nop
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  80194c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	52                   	push   %edx
  801959:	50                   	push   %eax
  80195a:	6a 2a                	push   $0x2a
  80195c:	e8 01 fb ff ff       	call   801462 <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
	return;
  801964:	90                   	nop
}
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 2b                	push   $0x2b
  801976:	e8 e7 fa ff ff       	call   801462 <syscall>
  80197b:	83 c4 18             	add    $0x18,%esp
}
  80197e:	c9                   	leave  
  80197f:	c3                   	ret    

00801980 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801980:	55                   	push   %ebp
  801981:	89 e5                	mov    %esp,%ebp
  801983:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801986:	83 ec 04             	sub    $0x4,%esp
  801989:	68 e8 26 80 00       	push   $0x8026e8
  80198e:	68 0a 01 00 00       	push   $0x10a
  801993:	68 f8 26 80 00       	push   $0x8026f8
  801998:	e8 f6 00 00 00       	call   801a93 <_panic>

0080199d <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	ff 75 0c             	pushl  0xc(%ebp)
  8019a9:	ff 75 08             	pushl  0x8(%ebp)
  8019ac:	6a 33                	push   $0x33
  8019ae:	e8 af fa ff ff       	call   801462 <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
	return;
  8019b6:	90                   	nop
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	ff 75 0c             	pushl  0xc(%ebp)
  8019c5:	ff 75 08             	pushl  0x8(%ebp)
  8019c8:	6a 34                	push   $0x34
  8019ca:	e8 93 fa ff ff       	call   801462 <syscall>
  8019cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d2:	90                   	nop
}
  8019d3:	c9                   	leave  
  8019d4:	c3                   	ret    

008019d5 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
  8019d8:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8019db:	8b 55 08             	mov    0x8(%ebp),%edx
  8019de:	89 d0                	mov    %edx,%eax
  8019e0:	c1 e0 02             	shl    $0x2,%eax
  8019e3:	01 d0                	add    %edx,%eax
  8019e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ec:	01 d0                	add    %edx,%eax
  8019ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f5:	01 d0                	add    %edx,%eax
  8019f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019fe:	01 d0                	add    %edx,%eax
  801a00:	c1 e0 04             	shl    $0x4,%eax
  801a03:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801a06:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801a0d:	0f 31                	rdtsc  
  801a0f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a12:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801a15:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a18:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a1e:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a21:	eb 46                	jmp    801a69 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801a23:	0f 31                	rdtsc  
  801a25:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801a28:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801a2b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a2e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801a31:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801a34:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801a37:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3d:	29 c2                	sub    %eax,%edx
  801a3f:	89 d0                	mov    %edx,%eax
  801a41:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a44:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a4a:	89 d1                	mov    %edx,%ecx
  801a4c:	29 c1                	sub    %eax,%ecx
  801a4e:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a54:	39 c2                	cmp    %eax,%edx
  801a56:	0f 97 c0             	seta   %al
  801a59:	0f b6 c0             	movzbl %al,%eax
  801a5c:	29 c1                	sub    %eax,%ecx
  801a5e:	89 c8                	mov    %ecx,%eax
  801a60:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a63:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a6c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801a6f:	72 b2                	jb     801a23 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a71:	90                   	nop
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
  801a77:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a81:	eb 03                	jmp    801a86 <busy_wait+0x12>
  801a83:	ff 45 fc             	incl   -0x4(%ebp)
  801a86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a89:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a8c:	72 f5                	jb     801a83 <busy_wait+0xf>
	return i;
  801a8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
  801a96:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a99:	8d 45 10             	lea    0x10(%ebp),%eax
  801a9c:	83 c0 04             	add    $0x4,%eax
  801a9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801aa2:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801aa7:	85 c0                	test   %eax,%eax
  801aa9:	74 16                	je     801ac1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801aab:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801ab0:	83 ec 08             	sub    $0x8,%esp
  801ab3:	50                   	push   %eax
  801ab4:	68 08 27 80 00       	push   $0x802708
  801ab9:	e8 bf ea ff ff       	call   80057d <cprintf>
  801abe:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801ac1:	a1 04 30 80 00       	mov    0x803004,%eax
  801ac6:	83 ec 0c             	sub    $0xc,%esp
  801ac9:	ff 75 0c             	pushl  0xc(%ebp)
  801acc:	ff 75 08             	pushl  0x8(%ebp)
  801acf:	50                   	push   %eax
  801ad0:	68 10 27 80 00       	push   $0x802710
  801ad5:	6a 74                	push   $0x74
  801ad7:	e8 ce ea ff ff       	call   8005aa <cprintf_colored>
  801adc:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801adf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae2:	83 ec 08             	sub    $0x8,%esp
  801ae5:	ff 75 f4             	pushl  -0xc(%ebp)
  801ae8:	50                   	push   %eax
  801ae9:	e8 20 ea ff ff       	call   80050e <vcprintf>
  801aee:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801af1:	83 ec 08             	sub    $0x8,%esp
  801af4:	6a 00                	push   $0x0
  801af6:	68 38 27 80 00       	push   $0x802738
  801afb:	e8 0e ea ff ff       	call   80050e <vcprintf>
  801b00:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b03:	e8 87 e9 ff ff       	call   80048f <exit>

	// should not return here
	while (1) ;
  801b08:	eb fe                	jmp    801b08 <_panic+0x75>

00801b0a <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
  801b0d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b10:	a1 20 30 80 00       	mov    0x803020,%eax
  801b15:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b1e:	39 c2                	cmp    %eax,%edx
  801b20:	74 14                	je     801b36 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b22:	83 ec 04             	sub    $0x4,%esp
  801b25:	68 3c 27 80 00       	push   $0x80273c
  801b2a:	6a 26                	push   $0x26
  801b2c:	68 88 27 80 00       	push   $0x802788
  801b31:	e8 5d ff ff ff       	call   801a93 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801b3d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b44:	e9 c5 00 00 00       	jmp    801c0e <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	01 d0                	add    %edx,%eax
  801b58:	8b 00                	mov    (%eax),%eax
  801b5a:	85 c0                	test   %eax,%eax
  801b5c:	75 08                	jne    801b66 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801b5e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b61:	e9 a5 00 00 00       	jmp    801c0b <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801b66:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b6d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b74:	eb 69                	jmp    801bdf <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b76:	a1 20 30 80 00       	mov    0x803020,%eax
  801b7b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801b81:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b84:	89 d0                	mov    %edx,%eax
  801b86:	01 c0                	add    %eax,%eax
  801b88:	01 d0                	add    %edx,%eax
  801b8a:	c1 e0 03             	shl    $0x3,%eax
  801b8d:	01 c8                	add    %ecx,%eax
  801b8f:	8a 40 04             	mov    0x4(%eax),%al
  801b92:	84 c0                	test   %al,%al
  801b94:	75 46                	jne    801bdc <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b96:	a1 20 30 80 00       	mov    0x803020,%eax
  801b9b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801ba1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801ba4:	89 d0                	mov    %edx,%eax
  801ba6:	01 c0                	add    %eax,%eax
  801ba8:	01 d0                	add    %edx,%eax
  801baa:	c1 e0 03             	shl    $0x3,%eax
  801bad:	01 c8                	add    %ecx,%eax
  801baf:	8b 00                	mov    (%eax),%eax
  801bb1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bb4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bb7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801bbc:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bc1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	01 c8                	add    %ecx,%eax
  801bcd:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801bcf:	39 c2                	cmp    %eax,%edx
  801bd1:	75 09                	jne    801bdc <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801bd3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801bda:	eb 15                	jmp    801bf1 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bdc:	ff 45 e8             	incl   -0x18(%ebp)
  801bdf:	a1 20 30 80 00       	mov    0x803020,%eax
  801be4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801bea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bed:	39 c2                	cmp    %eax,%edx
  801bef:	77 85                	ja     801b76 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801bf1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801bf5:	75 14                	jne    801c0b <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801bf7:	83 ec 04             	sub    $0x4,%esp
  801bfa:	68 94 27 80 00       	push   $0x802794
  801bff:	6a 3a                	push   $0x3a
  801c01:	68 88 27 80 00       	push   $0x802788
  801c06:	e8 88 fe ff ff       	call   801a93 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c0b:	ff 45 f0             	incl   -0x10(%ebp)
  801c0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c11:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c14:	0f 8c 2f ff ff ff    	jl     801b49 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c21:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c28:	eb 26                	jmp    801c50 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c2a:	a1 20 30 80 00       	mov    0x803020,%eax
  801c2f:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c35:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c38:	89 d0                	mov    %edx,%eax
  801c3a:	01 c0                	add    %eax,%eax
  801c3c:	01 d0                	add    %edx,%eax
  801c3e:	c1 e0 03             	shl    $0x3,%eax
  801c41:	01 c8                	add    %ecx,%eax
  801c43:	8a 40 04             	mov    0x4(%eax),%al
  801c46:	3c 01                	cmp    $0x1,%al
  801c48:	75 03                	jne    801c4d <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801c4a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c4d:	ff 45 e0             	incl   -0x20(%ebp)
  801c50:	a1 20 30 80 00       	mov    0x803020,%eax
  801c55:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c5e:	39 c2                	cmp    %eax,%edx
  801c60:	77 c8                	ja     801c2a <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c65:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c68:	74 14                	je     801c7e <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801c6a:	83 ec 04             	sub    $0x4,%esp
  801c6d:	68 e8 27 80 00       	push   $0x8027e8
  801c72:	6a 44                	push   $0x44
  801c74:	68 88 27 80 00       	push   $0x802788
  801c79:	e8 15 fe ff ff       	call   801a93 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c7e:	90                   	nop
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    
  801c81:	66 90                	xchg   %ax,%ax
  801c83:	90                   	nop

00801c84 <__udivdi3>:
  801c84:	55                   	push   %ebp
  801c85:	57                   	push   %edi
  801c86:	56                   	push   %esi
  801c87:	53                   	push   %ebx
  801c88:	83 ec 1c             	sub    $0x1c,%esp
  801c8b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c8f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c93:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c97:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c9b:	89 ca                	mov    %ecx,%edx
  801c9d:	89 f8                	mov    %edi,%eax
  801c9f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ca3:	85 f6                	test   %esi,%esi
  801ca5:	75 2d                	jne    801cd4 <__udivdi3+0x50>
  801ca7:	39 cf                	cmp    %ecx,%edi
  801ca9:	77 65                	ja     801d10 <__udivdi3+0x8c>
  801cab:	89 fd                	mov    %edi,%ebp
  801cad:	85 ff                	test   %edi,%edi
  801caf:	75 0b                	jne    801cbc <__udivdi3+0x38>
  801cb1:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb6:	31 d2                	xor    %edx,%edx
  801cb8:	f7 f7                	div    %edi
  801cba:	89 c5                	mov    %eax,%ebp
  801cbc:	31 d2                	xor    %edx,%edx
  801cbe:	89 c8                	mov    %ecx,%eax
  801cc0:	f7 f5                	div    %ebp
  801cc2:	89 c1                	mov    %eax,%ecx
  801cc4:	89 d8                	mov    %ebx,%eax
  801cc6:	f7 f5                	div    %ebp
  801cc8:	89 cf                	mov    %ecx,%edi
  801cca:	89 fa                	mov    %edi,%edx
  801ccc:	83 c4 1c             	add    $0x1c,%esp
  801ccf:	5b                   	pop    %ebx
  801cd0:	5e                   	pop    %esi
  801cd1:	5f                   	pop    %edi
  801cd2:	5d                   	pop    %ebp
  801cd3:	c3                   	ret    
  801cd4:	39 ce                	cmp    %ecx,%esi
  801cd6:	77 28                	ja     801d00 <__udivdi3+0x7c>
  801cd8:	0f bd fe             	bsr    %esi,%edi
  801cdb:	83 f7 1f             	xor    $0x1f,%edi
  801cde:	75 40                	jne    801d20 <__udivdi3+0x9c>
  801ce0:	39 ce                	cmp    %ecx,%esi
  801ce2:	72 0a                	jb     801cee <__udivdi3+0x6a>
  801ce4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ce8:	0f 87 9e 00 00 00    	ja     801d8c <__udivdi3+0x108>
  801cee:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf3:	89 fa                	mov    %edi,%edx
  801cf5:	83 c4 1c             	add    $0x1c,%esp
  801cf8:	5b                   	pop    %ebx
  801cf9:	5e                   	pop    %esi
  801cfa:	5f                   	pop    %edi
  801cfb:	5d                   	pop    %ebp
  801cfc:	c3                   	ret    
  801cfd:	8d 76 00             	lea    0x0(%esi),%esi
  801d00:	31 ff                	xor    %edi,%edi
  801d02:	31 c0                	xor    %eax,%eax
  801d04:	89 fa                	mov    %edi,%edx
  801d06:	83 c4 1c             	add    $0x1c,%esp
  801d09:	5b                   	pop    %ebx
  801d0a:	5e                   	pop    %esi
  801d0b:	5f                   	pop    %edi
  801d0c:	5d                   	pop    %ebp
  801d0d:	c3                   	ret    
  801d0e:	66 90                	xchg   %ax,%ax
  801d10:	89 d8                	mov    %ebx,%eax
  801d12:	f7 f7                	div    %edi
  801d14:	31 ff                	xor    %edi,%edi
  801d16:	89 fa                	mov    %edi,%edx
  801d18:	83 c4 1c             	add    $0x1c,%esp
  801d1b:	5b                   	pop    %ebx
  801d1c:	5e                   	pop    %esi
  801d1d:	5f                   	pop    %edi
  801d1e:	5d                   	pop    %ebp
  801d1f:	c3                   	ret    
  801d20:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d25:	89 eb                	mov    %ebp,%ebx
  801d27:	29 fb                	sub    %edi,%ebx
  801d29:	89 f9                	mov    %edi,%ecx
  801d2b:	d3 e6                	shl    %cl,%esi
  801d2d:	89 c5                	mov    %eax,%ebp
  801d2f:	88 d9                	mov    %bl,%cl
  801d31:	d3 ed                	shr    %cl,%ebp
  801d33:	89 e9                	mov    %ebp,%ecx
  801d35:	09 f1                	or     %esi,%ecx
  801d37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d3b:	89 f9                	mov    %edi,%ecx
  801d3d:	d3 e0                	shl    %cl,%eax
  801d3f:	89 c5                	mov    %eax,%ebp
  801d41:	89 d6                	mov    %edx,%esi
  801d43:	88 d9                	mov    %bl,%cl
  801d45:	d3 ee                	shr    %cl,%esi
  801d47:	89 f9                	mov    %edi,%ecx
  801d49:	d3 e2                	shl    %cl,%edx
  801d4b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d4f:	88 d9                	mov    %bl,%cl
  801d51:	d3 e8                	shr    %cl,%eax
  801d53:	09 c2                	or     %eax,%edx
  801d55:	89 d0                	mov    %edx,%eax
  801d57:	89 f2                	mov    %esi,%edx
  801d59:	f7 74 24 0c          	divl   0xc(%esp)
  801d5d:	89 d6                	mov    %edx,%esi
  801d5f:	89 c3                	mov    %eax,%ebx
  801d61:	f7 e5                	mul    %ebp
  801d63:	39 d6                	cmp    %edx,%esi
  801d65:	72 19                	jb     801d80 <__udivdi3+0xfc>
  801d67:	74 0b                	je     801d74 <__udivdi3+0xf0>
  801d69:	89 d8                	mov    %ebx,%eax
  801d6b:	31 ff                	xor    %edi,%edi
  801d6d:	e9 58 ff ff ff       	jmp    801cca <__udivdi3+0x46>
  801d72:	66 90                	xchg   %ax,%ax
  801d74:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d78:	89 f9                	mov    %edi,%ecx
  801d7a:	d3 e2                	shl    %cl,%edx
  801d7c:	39 c2                	cmp    %eax,%edx
  801d7e:	73 e9                	jae    801d69 <__udivdi3+0xe5>
  801d80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d83:	31 ff                	xor    %edi,%edi
  801d85:	e9 40 ff ff ff       	jmp    801cca <__udivdi3+0x46>
  801d8a:	66 90                	xchg   %ax,%ax
  801d8c:	31 c0                	xor    %eax,%eax
  801d8e:	e9 37 ff ff ff       	jmp    801cca <__udivdi3+0x46>
  801d93:	90                   	nop

00801d94 <__umoddi3>:
  801d94:	55                   	push   %ebp
  801d95:	57                   	push   %edi
  801d96:	56                   	push   %esi
  801d97:	53                   	push   %ebx
  801d98:	83 ec 1c             	sub    $0x1c,%esp
  801d9b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d9f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801da3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801da7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801dab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801daf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801db3:	89 f3                	mov    %esi,%ebx
  801db5:	89 fa                	mov    %edi,%edx
  801db7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dbb:	89 34 24             	mov    %esi,(%esp)
  801dbe:	85 c0                	test   %eax,%eax
  801dc0:	75 1a                	jne    801ddc <__umoddi3+0x48>
  801dc2:	39 f7                	cmp    %esi,%edi
  801dc4:	0f 86 a2 00 00 00    	jbe    801e6c <__umoddi3+0xd8>
  801dca:	89 c8                	mov    %ecx,%eax
  801dcc:	89 f2                	mov    %esi,%edx
  801dce:	f7 f7                	div    %edi
  801dd0:	89 d0                	mov    %edx,%eax
  801dd2:	31 d2                	xor    %edx,%edx
  801dd4:	83 c4 1c             	add    $0x1c,%esp
  801dd7:	5b                   	pop    %ebx
  801dd8:	5e                   	pop    %esi
  801dd9:	5f                   	pop    %edi
  801dda:	5d                   	pop    %ebp
  801ddb:	c3                   	ret    
  801ddc:	39 f0                	cmp    %esi,%eax
  801dde:	0f 87 ac 00 00 00    	ja     801e90 <__umoddi3+0xfc>
  801de4:	0f bd e8             	bsr    %eax,%ebp
  801de7:	83 f5 1f             	xor    $0x1f,%ebp
  801dea:	0f 84 ac 00 00 00    	je     801e9c <__umoddi3+0x108>
  801df0:	bf 20 00 00 00       	mov    $0x20,%edi
  801df5:	29 ef                	sub    %ebp,%edi
  801df7:	89 fe                	mov    %edi,%esi
  801df9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801dfd:	89 e9                	mov    %ebp,%ecx
  801dff:	d3 e0                	shl    %cl,%eax
  801e01:	89 d7                	mov    %edx,%edi
  801e03:	89 f1                	mov    %esi,%ecx
  801e05:	d3 ef                	shr    %cl,%edi
  801e07:	09 c7                	or     %eax,%edi
  801e09:	89 e9                	mov    %ebp,%ecx
  801e0b:	d3 e2                	shl    %cl,%edx
  801e0d:	89 14 24             	mov    %edx,(%esp)
  801e10:	89 d8                	mov    %ebx,%eax
  801e12:	d3 e0                	shl    %cl,%eax
  801e14:	89 c2                	mov    %eax,%edx
  801e16:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e1a:	d3 e0                	shl    %cl,%eax
  801e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e20:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e24:	89 f1                	mov    %esi,%ecx
  801e26:	d3 e8                	shr    %cl,%eax
  801e28:	09 d0                	or     %edx,%eax
  801e2a:	d3 eb                	shr    %cl,%ebx
  801e2c:	89 da                	mov    %ebx,%edx
  801e2e:	f7 f7                	div    %edi
  801e30:	89 d3                	mov    %edx,%ebx
  801e32:	f7 24 24             	mull   (%esp)
  801e35:	89 c6                	mov    %eax,%esi
  801e37:	89 d1                	mov    %edx,%ecx
  801e39:	39 d3                	cmp    %edx,%ebx
  801e3b:	0f 82 87 00 00 00    	jb     801ec8 <__umoddi3+0x134>
  801e41:	0f 84 91 00 00 00    	je     801ed8 <__umoddi3+0x144>
  801e47:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e4b:	29 f2                	sub    %esi,%edx
  801e4d:	19 cb                	sbb    %ecx,%ebx
  801e4f:	89 d8                	mov    %ebx,%eax
  801e51:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e55:	d3 e0                	shl    %cl,%eax
  801e57:	89 e9                	mov    %ebp,%ecx
  801e59:	d3 ea                	shr    %cl,%edx
  801e5b:	09 d0                	or     %edx,%eax
  801e5d:	89 e9                	mov    %ebp,%ecx
  801e5f:	d3 eb                	shr    %cl,%ebx
  801e61:	89 da                	mov    %ebx,%edx
  801e63:	83 c4 1c             	add    $0x1c,%esp
  801e66:	5b                   	pop    %ebx
  801e67:	5e                   	pop    %esi
  801e68:	5f                   	pop    %edi
  801e69:	5d                   	pop    %ebp
  801e6a:	c3                   	ret    
  801e6b:	90                   	nop
  801e6c:	89 fd                	mov    %edi,%ebp
  801e6e:	85 ff                	test   %edi,%edi
  801e70:	75 0b                	jne    801e7d <__umoddi3+0xe9>
  801e72:	b8 01 00 00 00       	mov    $0x1,%eax
  801e77:	31 d2                	xor    %edx,%edx
  801e79:	f7 f7                	div    %edi
  801e7b:	89 c5                	mov    %eax,%ebp
  801e7d:	89 f0                	mov    %esi,%eax
  801e7f:	31 d2                	xor    %edx,%edx
  801e81:	f7 f5                	div    %ebp
  801e83:	89 c8                	mov    %ecx,%eax
  801e85:	f7 f5                	div    %ebp
  801e87:	89 d0                	mov    %edx,%eax
  801e89:	e9 44 ff ff ff       	jmp    801dd2 <__umoddi3+0x3e>
  801e8e:	66 90                	xchg   %ax,%ax
  801e90:	89 c8                	mov    %ecx,%eax
  801e92:	89 f2                	mov    %esi,%edx
  801e94:	83 c4 1c             	add    $0x1c,%esp
  801e97:	5b                   	pop    %ebx
  801e98:	5e                   	pop    %esi
  801e99:	5f                   	pop    %edi
  801e9a:	5d                   	pop    %ebp
  801e9b:	c3                   	ret    
  801e9c:	3b 04 24             	cmp    (%esp),%eax
  801e9f:	72 06                	jb     801ea7 <__umoddi3+0x113>
  801ea1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ea5:	77 0f                	ja     801eb6 <__umoddi3+0x122>
  801ea7:	89 f2                	mov    %esi,%edx
  801ea9:	29 f9                	sub    %edi,%ecx
  801eab:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eaf:	89 14 24             	mov    %edx,(%esp)
  801eb2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eb6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801eba:	8b 14 24             	mov    (%esp),%edx
  801ebd:	83 c4 1c             	add    $0x1c,%esp
  801ec0:	5b                   	pop    %ebx
  801ec1:	5e                   	pop    %esi
  801ec2:	5f                   	pop    %edi
  801ec3:	5d                   	pop    %ebp
  801ec4:	c3                   	ret    
  801ec5:	8d 76 00             	lea    0x0(%esi),%esi
  801ec8:	2b 04 24             	sub    (%esp),%eax
  801ecb:	19 fa                	sbb    %edi,%edx
  801ecd:	89 d1                	mov    %edx,%ecx
  801ecf:	89 c6                	mov    %eax,%esi
  801ed1:	e9 71 ff ff ff       	jmp    801e47 <__umoddi3+0xb3>
  801ed6:	66 90                	xchg   %ax,%ax
  801ed8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801edc:	72 ea                	jb     801ec8 <__umoddi3+0x134>
  801ede:	89 d9                	mov    %ebx,%ecx
  801ee0:	e9 62 ff ff ff       	jmp    801e47 <__umoddi3+0xb3>
